"""
DOT to Verilog converter for FABulous FPGA benchmarks.

This module converts DOT graph files from benchmarks/microbench into Verilog
representations using the building blocks defined in libs.v. Based on the
template approach from dotToVerilog.py but enhanced for pre-gen-graph files.
"""

from pathlib import Path
from typing import Dict, List, Optional, Set, Tuple

import networkx as nx
from loguru import logger


class DotToVerilogConverter:
    """
    Converts DOT graph files to Verilog modules using string templates.

    The converter maps DOT graph nodes to Verilog modules based on the
    building blocks available in libs.v and uses a template-based approach
    similar to the original dotToVerilog.py.
    """

    def __init__(self):
        """Initialize the converter with Verilog templates."""
        # Main module template - similar to original
        self.moduleTemplate = "module {name} #(parameter WIDTH=32);\n\n{body}\nendmodule\n"

        # Wire template
        self.wireTemplate = "wire[WIDTH-1:0] {source};\n"
        self.wireTemplate1 = "wire {source};\n"

        # Component templates based on libs.v
        self.constOp = "const_unit #(.ConfigBits({CONST})) inst_{value}(.const_out({Y}));\n"
        self.regOp = "reg_unit #(.tide_en(0), .tide_rst(0)) inst_{value}(.reg_in({IN}), .reg_out({Y}), .en(global_en), .rst(global_rst));\n"
        self.regOp1 = "reg_unit_WIDTH_1 #(.tide_en(0), .tide_rst(0)) inst_{value}(.reg_in({IN}), .reg_out({Y}), .en(global_en), .rst(global_rst));\n"
        self.unOp = "ALU #(.ALU_func({OP})) inst_{value}(.data_in1({A}), .data_in2(), .data_in3(), .data_out({Y}));\n"
        self.binOp = (
            "ALU #(.ALU_func({OP})) inst_{value}(.data_in1({A}), .data_in2({B}), .data_in3(), .data_out({Y}));\n"
        )
        self.terOp = (
            "ALU #(.ALU_func({OP})) inst_{value}(.data_in1({A}), .data_in2({B}), .data_in3({C}), .data_out({Y}));\n"
        )
        self.compareOp = "compare #(.conf({OP})) inst_{value}(.A({A}), .B({B}), .Y({Y}));\n"
        self.logicOp = "logic_op #(.conf({OP})) inst_{value}(.A({A}), .B({B}), .Y({Y}));\n"
        self.memOp = "(* keep *)Mem #(.config_bits({BITS})) inst_{value}(.addr0({ADDR}), .reset(global_rst), .write_data({WDATA}), .write_en({WEN}), .read_data({Y}));\n"
        self.ioWidth1Op = "(* keep *) IO_WIDTH_1 inst_{value}(.from_fabric({A}), .in(), .to_fabric({Y}), .out());\n"

        # Input/Output templates - using IO modules
        self.inputOp = "(* keep *) IO inst_{value}(.from_fabric(), .in(), .to_fabric({Y}), .out());\n"
        self.outputOp = "(* keep *) IO inst_{value}(.from_fabric({A}), .in(), .to_fabric(), .out());\n"

        # Local parameter template
        self.localParam = "localparam {name} = {value};\n"

        # Opcode to ALU function mapping
        self.aluOpcodeMap = {
            "add": 0,
            "plus": 0,
            "+": 0,
            "sub": 1,
            "minus": 1,
            "-": 1,
            "mul": 2,
            "mult": 2,
            "*": 2,
            "div": 3,
            "/": 3,
            "mod": 4,
            "%": 4,
            "shl": 5,
            "<<": 5,
            "shr": 6,
            ">>": 6,
            "and": 7,
            "&": 7,
            "or": 8,
            "|": 8,
            "xor": 9,
            "^": 9,
            "not": 10,
            "~": 10,
            "neg": 11,
            "negate": 11,
        }

        # Compare operation mapping
        self.compareOpcodeMap = {
            "eq": 0,
            "==": 0,
            "equal": 0,
            "icmp": 0,
            "ne": 1,
            "!=": 1,
            "not_equal": 1,
            "lt": 2,
            "<": 2,
            "less": 2,
            "le": 3,
            "<=": 3,
            "less_equal": 3,
            "gt": 4,
            ">": 4,
            "greater": 4,
            "ge": 5,
            ">=": 5,
            "greater_equal": 5,
        }

        # Logic operation mapping
        self.logicOpcodeMap = {"and": 0, "&&": 0, "or": 1, "||": 1, "xor": 2, "^^": 2, "not": 3, "!": 3}

    def sanitize_name(self, name: str) -> str:
        """
        Sanitize a node name to make it compatible with Verilog naming rules.
        
        Parameters
        ----------
        name : str
            Original node name from the graph
            
        Returns
        -------
        str
            Sanitized name with invalid characters replaced
        """
        # Replace invalid characters with safe substitutes
        sanitized = name.replace('@', '_at_')
        sanitized = sanitized.replace('#', '_hash_')
        sanitized = sanitized.replace('!', '_exclaim_')
        # Add more replacements for other invalid characters if needed
        # Ensure the name starts with a letter or underscore
        if sanitized and not (sanitized[0].isalpha() or sanitized[0] == '_'):
            sanitized = f"n_{sanitized}"
        return sanitized

    def convertDotToVerilog(self, dotFile: Path, moduleName: Optional[str] = None) -> tuple[str, nx.DiGraph]:
        """
        Convert a DOT file to Verilog module using NetworkX and templates.

        Parameters
        ----------
        dotFile : Path
            Path to the DOT file to convert
        moduleName : Optional[str]
            Name for the generated module. If None, uses the DOT filename.

        Returns
        -------
        tuple[str, nx.DiGraph]
            Generated Verilog code and the transformed graph
        """
        if moduleName is None:
            moduleName = dotFile.stem.replace("-", "_").replace(".", "_")

        logger.info(f"Converting {dotFile} to Verilog module '{moduleName}'")

        try:
            # Use NetworkX to parse DOT file (similar to original dotToVerilog.py)
            G = nx.DiGraph(nx.nx_pydot.read_dot(str(dotFile)))

            if not G.nodes():
                logger.warning(f"No nodes found in {dotFile}")
                return "", G

            logger.info(f"Found {len(G.nodes())} nodes and {len(G.edges())} edges")

            # Perform graph transformations first
            transformedG = self._transformGraph(G)

            logger.info(
                f"After transformation: {len(transformedG.nodes())} nodes and {len(transformedG.edges())} edges"
            )

            # Generate Verilog body from transformed graph
            body = self._generateVerilogBody(transformedG)

            # Assemble complete module
            verilogCode = self.moduleTemplate.format(name=moduleName, body=body)

            return verilogCode, transformedG

        except Exception as e:
            logger.error(f"Error converting {dotFile}: {e}")
            return "", nx.DiGraph()

    def _validateNodeInputs(self, G: nx.DiGraph) -> None:
        """
        Validate that all nodes have appropriate number of inputs after phi transformation.

        This method checks if any node has more inputs than it should handle based on
        its operation type and generates warnings for such cases.

        Parameters
        ----------
        G : nx.DiGraph
            Graph to validate
        """
        logger.info("Validating node input counts after phi transformation")

        warningCount = 0

        for node in G.nodes():
            inDegree = G.in_degree(node)
            maxInputs = self._getMaxInputsForOperation(G, node)

            # Skip input nodes (they have no predecessors by design)
            if inDegree == 0:
                continue

            nodeData = G.nodes[node]
            opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))
            if opcode:
                opcode = opcode.strip('"').lower()

            nodeType = nodeData.get("type", "").strip('"').lower()

            # Check if node has more inputs than it should
            if inDegree > maxInputs:
                predecessors = list(G.predecessors(node))

                # Generate detailed warning
                warningMessage = (
                    f"Node '{node}' (opcode: '{opcode}', type: '{nodeType}') has {inDegree} inputs "
                    f"but should only accept {maxInputs} inputs max. "
                    f"Predecessors: {predecessors}"
                )

                # Add operation-specific context
                if opcode in self.aluOpcodeMap:
                    warningMessage += f" [ALU operation: {opcode}]"
                elif opcode in self.compareOpcodeMap:
                    warningMessage += f" [Compare operation: {opcode}]"
                elif opcode in self.logicOpcodeMap:
                    warningMessage += f" [Logic operation: {opcode}]"
                elif opcode in ["load", "store"]:
                    warningMessage += f" [Memory operation: {opcode}]"
                elif opcode in ["not", "~", "neg", "negate"]:
                    warningMessage += f" [Unary operation: {opcode}]"
                else:
                    warningMessage += f" [Unknown operation: {opcode}]"

                logger.warning(warningMessage)
                warningCount += 1

                # Suggest what will happen during Verilog generation
                if inDegree > 2:
                    logger.warning(
                        f"  -> During Verilog generation, only the first {maxInputs} inputs will be used. "
                        f"Remaining {inDegree - maxInputs} inputs will be ignored."
                    )

        if warningCount > 0:
            logger.warning(f"Found {warningCount} nodes with excessive input counts")
            # Fix excessive inputs by removing duplicated nodes first
            self._fixExcessiveInputs(G)
        else:
            logger.info("All nodes have appropriate input counts")

    def _fixExcessiveInputs(self, G: nx.DiGraph) -> None:
        """
        Fix nodes that have more inputs than they can handle by removing duplicated nodes first.

        Priority order for removal:
        1. Duplicated nodes (created during constant duplication, with '_dup_' suffix)
        2. Constant nodes
        3. Regular inputs (as last resort)

        Parameters
        ----------
        G : nx.DiGraph
            Graph to modify in-place
        """
        logger.info("Fixing nodes with excessive input counts")

        fixedCount = 0

        # Create a copy of nodes to iterate over since we'll be modifying the graph
        nodesToCheck = list(G.nodes())

        for node in nodesToCheck:
            # Skip if node was removed during processing
            if node not in G.nodes():
                continue

            inDegree = G.in_degree(node)
            maxInputs = self._getMaxInputsForOperation(G, node)

            # Skip input nodes and nodes within limits
            if inDegree == 0 or inDegree <= maxInputs:
                continue

            predecessors = list(G.predecessors(node))
            inputsToRemove = inDegree - maxInputs

            # Categorize predecessors by type
            duplicatedPredecessors = []
            constPredecessors = []
            regularPredecessors = []

            for pred in predecessors:
                if pred == node:  # Skip self-loops (handled elsewhere)
                    continue
                elif self._isDuplicatedNode(pred):
                    duplicatedPredecessors.append(pred)
                elif self._isConstantOperation(G, pred):
                    constPredecessors.append(pred)
                else:
                    regularPredecessors.append(pred)

            logger.debug(
                f"Node {node}: need to remove {inputsToRemove} inputs, "
                f"have {len(duplicatedPredecessors)} duplicated, {len(constPredecessors)} constants, "
                f"{len(regularPredecessors)} regular inputs"
            )

            # Priority removal: duplicated first, then constants, then regular
            nodesToRemove = []

            # Remove duplicated nodes first
            if len(duplicatedPredecessors) > 0 and inputsToRemove > 0:
                duplicatedToRemove = min(inputsToRemove, len(duplicatedPredecessors))
                nodesToRemove.extend(duplicatedPredecessors[:duplicatedToRemove])
                inputsToRemove -= duplicatedToRemove

            # Remove constants if still needed
            if len(constPredecessors) > 0 and inputsToRemove > 0:
                constantsToRemove = min(inputsToRemove, len(constPredecessors))
                nodesToRemove.extend(constPredecessors[:constantsToRemove])
                inputsToRemove -= constantsToRemove

            # Remove regular inputs as last resort if still needed
            if len(regularPredecessors) > 0 and inputsToRemove > 0:
                regularToRemove = min(inputsToRemove, len(regularPredecessors))
                nodesToRemove.extend(regularPredecessors[:regularToRemove])
                inputsToRemove -= regularToRemove

            # Apply the removals
            if nodesToRemove:
                logger.info(f"Fixing node {node}: removing {len(nodesToRemove)} excessive inputs: {nodesToRemove}")

                for nodeToRemove in nodesToRemove:
                    if G.has_edge(nodeToRemove, node):
                        G.remove_edge(nodeToRemove, node)
                        logger.debug(f"Removed edge from {nodeToRemove} to {node}")

                    # If the removed node has no other outputs, remove it entirely
                    if G.out_degree(nodeToRemove) == 0:
                        G.remove_node(nodeToRemove)
                        logger.debug(f"Removed node {nodeToRemove} (no more outputs)")

                fixedCount += 1

        if fixedCount > 0:
            logger.info(f"Fixed {fixedCount} nodes with excessive input counts")
        else:
            logger.info("No nodes required input count fixes")

    def _getNodeDescription(self, G: nx.DiGraph, node: str) -> str:
        """
        Get a descriptive string for a node for logging purposes.

        Parameters
        ----------
        G : nx.DiGraph
            NetworkX directed graph
        node : str
            Node identifier

        Returns
        -------
        str
            Descriptive string for the node
        """
        nodeData = G.nodes[node]
        opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))
        if opcode:
            opcode = opcode.strip('"').lower()

        nodeType = nodeData.get("type", "").strip('"').lower()

        if opcode != "unknown":
            if nodeType:
                return f"'{node}' (opcode: '{opcode}', type: '{nodeType}')"
            else:
                return f"'{node}' (opcode: '{opcode}')"
        elif nodeType:
            return f"'{node}' (type: '{nodeType}')"
        else:
            return f"'{node}'"

    def _transformGraph(self, G: nx.DiGraph) -> nx.DiGraph:
        """
        Transform the graph by handling phi nodes, branch operations, and constant duplication.

        1. Phi nodes with out_degree=1: merge inputs into successor and remove self-loops
        2. Phi nodes with out_degree>1: copy all inputs to all outputs and remove self-loops
        3. Branch operations: replace with IO_WIDTH_1 and only take output from logic/compare ops
        4. Constant operations: duplicate if they have multiple outputs
        5. Remove isolated nodes (nodes with no inputs and no outputs)

        Parameters
        ----------
        G : nx.DiGraph
            Original graph from DOT file

        Returns
        -------
        nx.DiGraph
            Transformed graph ready for Verilog generation
        """
        # Create a copy to avoid modifying the original
        transformedG = nx.DiGraph(G)

        # First, handle phi nodes
        self._handlePhiNodes(transformedG)

        # Then, handle branch operations
        self._handleBranchOperations(transformedG)

        # Duplicate constant operations with multiple outputs
        self._duplicateConstantOperations(transformedG)

        # Remove self-loops
        self._removeSelfLoops(transformedG)

        # Remove isolated nodes (nodes with no inputs and no outputs)
        self._removeIsolatedNodes(transformedG)

        # Validate node inputs after transformations
        self._validateNodeInputs(transformedG)

        return transformedG

    def _removeIsolatedNodes(self, G: nx.DiGraph) -> None:
        """
        Remove nodes that have no inputs and no outputs (isolated nodes).

        These nodes are effectively disconnected from the graph and serve
        no purpose in the final Verilog generation.

        Parameters
        ----------
        G : nx.DiGraph
            Graph to modify in-place
        """
        isolatedNodes = []

        for node in G.nodes():
            inDegree = G.in_degree(node)
            outDegree = G.out_degree(node)

            # Node is isolated if it has no inputs AND no outputs
            if inDegree == 0 and outDegree == 0:
                isolatedNodes.append(node)

        if isolatedNodes:
            logger.info(f"Found {len(isolatedNodes)} isolated nodes to remove: {isolatedNodes}")

            for node in isolatedNodes:
                nodeDesc = self._getNodeDescription(G, node)
                logger.debug(f"Removing isolated node {nodeDesc}")
                G.remove_node(node)

            logger.info(f"Removed {len(isolatedNodes)} isolated nodes from graph")
        else:
            logger.info("No isolated nodes found")

    def _isLogicOperation(self, G: nx.DiGraph, node: str) -> bool:
        """
        Check if a node represents a logic operation that outputs width-1 signal.

        Parameters
        ----------
        G : nx.DiGraph
            NetworkX directed graph
        node : str
            Node identifier to check

        Returns
        -------
        bool
            True if the node performs a logic operation
        """
        nodeData = G.nodes[node]
        opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))

        if not opcode:
            return False

        opcode = opcode.strip('"').lower()

        # Check if opcode is in logic operation mapping
        return opcode in self.logicOpcodeMap

    def _isCompareOperation(self, G: nx.DiGraph, node: str) -> bool:
        """
        Check if a node represents a compare operation that outputs width-1 signal.

        Parameters
        ----------
        G : nx.DiGraph
            NetworkX directed graph
        node : str
            Node identifier to check

        Returns
        -------
        bool
            True if the node performs a compare operation
        """
        nodeData = G.nodes[node]
        opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))

        if not opcode:
            return False

        opcode = opcode.strip('"').lower()

        # Check if opcode is in compare operation mapping
        return opcode in self.compareOpcodeMap

    def _outputsWidth1Signal(self, G: nx.DiGraph, node: str) -> bool:
        """
        Check if a node outputs a width-1 (single bit) signal.

        Logic and compare operations output single bit signals.

        Parameters
        ----------
        G : nx.DiGraph
            NetworkX directed graph
        node : str
            Node identifier to check

        Returns
        -------
        bool
            True if the node outputs a width-1 signal
        """
        return self._isLogicOperation(G, node) or self._isCompareOperation(G, node)

    def _isAluOperation(self, G: nx.DiGraph, node: str) -> bool:
        """
        Check if a node represents an ALU operation.

        Parameters
        ----------
        G : nx.DiGraph
            NetworkX directed graph
        node : str
            Node identifier to check

        Returns
        -------
        bool
            True if the node performs an ALU operation
        """
        nodeData = G.nodes[node]
        opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))

        if not opcode:
            return False

        opcode = opcode.strip('"').lower()

        # Check if opcode is in ALU operation mapping
        return opcode in self.aluOpcodeMap

    def _prioritizeAluInputs(self, G: nx.DiGraph, predecessors: List[str], maxInputs: int) -> List[str]:
        """
        Prioritize ALU operations when selecting inputs from predecessors.

        When phi nodes create more inputs than an operation can accept,
        always pick the ones that are doing ALU operations first.

        Parameters
        ----------
        G : nx.DiGraph
            NetworkX directed graph
        predecessors : List[str]
            List of predecessor nodes
        maxInputs : int
            Maximum number of inputs to select

        Returns
        -------
        List[str]
            Prioritized list of predecessor nodes, ALU operations first
        """
        if len(predecessors) <= maxInputs:
            return predecessors

        # Separate ALU and non-ALU operations
        aluPredecessors = []
        nonAluPredecessors = []

        for pred in predecessors:
            if self._isAluOperation(G, pred):
                aluPredecessors.append(pred)
            else:
                nonAluPredecessors.append(pred)

        logger.debug(
            f"Found {len(aluPredecessors)} ALU predecessors and {len(nonAluPredecessors)} non-ALU predecessors"
        )

        # Prioritize ALU operations first
        prioritizedList = aluPredecessors + nonAluPredecessors

        # Return only the maximum allowed inputs
        selected = prioritizedList[:maxInputs]

        if len(selected) < len(predecessors):
            droppedPreds = [pred for pred in predecessors if pred not in selected]
            logger.info(f"Prioritized ALU operations: selected {selected}, dropped {droppedPreds}")

        return selected

    def _getMaxInputsForOperation(self, G: nx.DiGraph, node: str) -> int:
        """
        Determine the maximum number of inputs an operation can accept.

        Parameters
        ----------
        G : nx.DiGraph
            NetworkX directed graph
        node : str
            Node identifier

        Returns
        -------
        int
            Maximum number of inputs the operation can handle
        """
        nodeData = G.nodes[node]
        opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))

        if not opcode:
            return 2  # Default to binary operation

        opcode = opcode.strip('"').lower()

        # Unary operations (1 input)
        unaryOps = {"not", "~", "neg", "negate"}
        if opcode in unaryOps:
            return 1

        # Ternary operations (3 inputs) - rare, but possible
        ternaryOps = {"select", "mux"}
        if opcode in ternaryOps:
            return 3

        # Memory operations can handle multiple inputs
        if opcode in ["load", "store"]:
            return 3  # address, write_data, write_enable

        # Most operations are binary (2 inputs)
        return 2

    def _handlePhiNodes(self, G: nx.DiGraph) -> None:
        """
        Handle phi nodes by merging them into their successors.
        When inputs exceed operation capacity, prioritize ALU operations.

        Parameters
        ----------
        G : nx.DiGraph
            Graph to modify in-place
        """
        # Find all phi nodes
        phiNodes = []
        for node in G.nodes():
            nodeData = G.nodes[node]
            opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))
            if opcode and opcode.strip('"').lower() == "phi":
                phiNodes.append(node)

        logger.info(f"Found {len(phiNodes)} phi nodes to process")

        for phiNode in phiNodes:
            outDegree = G.out_degree(phiNode)
            predecessors = list(G.predecessors(phiNode))
            successors = list(G.successors(phiNode))

            if outDegree == 1:
                # Phi node with single output: merge inputs into successor
                successor = successors[0]
                logger.debug(f"Merging phi node {phiNode} with single successor {successor}")

                # Remove edge from phi to successor
                G.remove_edge(phiNode, successor)

                # Determine maximum inputs the successor operation can handle
                maxInputs = self._getMaxInputsForOperation(G, successor)

                # Filter out self-loops from predecessors
                validPredecessors = [pred for pred in predecessors if pred != phiNode]

                # Prioritize ALU operations if we have too many inputs
                if len(validPredecessors) > maxInputs:
                    logger.warning(
                        f"Phi node {phiNode} has {len(validPredecessors)} inputs but successor {successor} can only accept {maxInputs}"
                    )
                    validPredecessors = self._prioritizeAluInputs(G, validPredecessors, maxInputs)

                # Connect selected phi inputs directly to successor
                for pred in validPredecessors:
                    # Copy edge attributes from phi input
                    edgeData = G.get_edge_data(pred, phiNode, {})
                    G.add_edge(pred, successor, **edgeData)

                # Remove incoming edges to phi
                for pred in predecessors:
                    if G.has_edge(pred, phiNode):
                        G.remove_edge(pred, phiNode)

            elif outDegree > 1:
                # Phi node with multiple outputs: copy inputs to all outputs with prioritization
                logger.debug(f"Copying phi node {phiNode} inputs to {len(successors)} successors")

                for successor in successors:
                    # Remove edge from phi to successor
                    successorEdgeData = G.get_edge_data(phiNode, successor, {})
                    G.remove_edge(phiNode, successor)

                    # Determine maximum inputs this successor can handle
                    maxInputs = self._getMaxInputsForOperation(G, successor)

                    # Filter out self-loops from predecessors
                    validPredecessors = [pred for pred in predecessors if pred != phiNode]

                    # Prioritize ALU operations if we have too many inputs
                    if len(validPredecessors) > maxInputs:
                        logger.warning(
                            f"Phi node {phiNode} has {len(validPredecessors)} inputs but successor {successor} can only accept {maxInputs}"
                        )
                        validPredecessors = self._prioritizeAluInputs(G, validPredecessors, maxInputs)

                    # Connect selected phi inputs to this successor
                    for pred in validPredecessors:
                        predEdgeData = G.get_edge_data(pred, phiNode, {})
                        # Combine edge attributes if needed
                        combinedData = {**predEdgeData, **successorEdgeData}
                        G.add_edge(pred, successor, **combinedData)

                # Remove incoming edges to phi
                for pred in predecessors:
                    if G.has_edge(pred, phiNode):
                        G.remove_edge(pred, phiNode)

            # Remove the phi node itself
            if G.has_node(phiNode):
                G.remove_node(phiNode)
                logger.debug(f"Removed phi node {phiNode}")

    def _handleBranchOperations(self, G: nx.DiGraph) -> None:
        """
        Handle branch operations by replacing them with IO_WIDTH_1.
        Only take output from logic or compare operations.

        Parameters
        ----------
        G : nx.DiGraph
            Graph to modify in-place
        """
        # Find all branch nodes
        branchNodes = []
        for node in G.nodes():
            nodeData = G.nodes[node]
            opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))
            if opcode and opcode.strip('"').lower() in ["br", "branch"]:
                branchNodes.append(node)

        logger.info(f"Found {len(branchNodes)} branch nodes to process")

        for branchNode in branchNodes:
            # Change the opcode to indicate this should be IO_WIDTH_1
            G.nodes[branchNode]["opcode"] = "io_width_1"
            G.nodes[branchNode]["original_opcode"] = "br"

            # Find predecessors and only keep logic/compare operation outputs
            predecessors = list(G.predecessors(branchNode))
            for pred in predecessors:
                predData = G.nodes[pred]
                predOpcode = predData.get("opcode", predData.get("label", "unknown"))
                if predOpcode:
                    predOpcode = predOpcode.strip('"').lower()

                # Only keep edges from logic or compare operations
                if predOpcode not in ["icmp", "eq", "ne", "lt", "le", "gt", "ge", "and", "or", "xor", "not"]:
                    logger.debug(f"Removing edge from {pred} (opcode: {predOpcode}) to branch {branchNode}")
                    if G.has_edge(pred, branchNode):
                        G.remove_edge(pred, branchNode)

            logger.debug(f"Converted branch node {branchNode} to IO_WIDTH_1")

    def _isDuplicatedNode(self, node: str) -> bool:
        """
        Check if a node is a duplicated node created during constant duplication.

        Parameters
        ----------
        node : str
            Node identifier to check

        Returns
        -------
        bool
            True if the node is a duplicated constant node (contains '_dup_')
        """
        return "_dup_" in node

    def _isConstantOperation(self, G: nx.DiGraph, node: str) -> bool:
        """
        Check if a node represents a constant operation.

        Parameters
        ----------
        G : nx.DiGraph
            NetworkX directed graph
        node : str
            Node identifier to check

        Returns
        -------
        bool
            True if the node is a constant operation
        """
        nodeData = G.nodes[node]
        opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))
        nodeType = nodeData.get("type", "").strip('"').lower()

        # Check if this is a constant operation
        isConstant = False
        if opcode:
            opcode = opcode.strip('"').lower()
            isConstant = opcode in ["const", "constant"]
        if nodeType == "constant":
            isConstant = True

        # Check for constant nodes with no incoming edges (source constants)
        if G.in_degree(node) == 0 and not isConstant:
            # Check if this is likely a constant based on naming or other attributes
            constVal = nodeData.get("constVal", "").strip('"')
            if constVal and constVal.isdigit():
                isConstant = True

        return isConstant

    def _removeSelfLoops(self, G: nx.DiGraph) -> None:
        """
        Handle self-loops appropriately for ALU operations.

        For ALU operations with self-loops, the self-loop indicates that the output
        should be fed back as one of the inputs. Instead of removing self-loops,
        we preserve them and handle them during Verilog generation.

        Special case: If a node has a self-loop and including the self-loop would result in
        more than the maximum allowed inputs, remove constant operation inputs instead and
        keep the self-loop.

        Parameters
        ----------
        G : nx.DiGraph
            Graph to modify in-place
        """
        selfLoops = list(nx.selfloop_edges(G))
        logger.info(f"Processing {len(selfLoops)} self-loops")

        for node, _ in selfLoops:
            # Check if this is an ALU operation
            nodeData = G.nodes[node]
            opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))
            if opcode:
                opcode = opcode.strip('"').lower()

            # For ALU operations, preserve self-loops as they indicate feedback connections
            if self._isAluOperation(G, node):
                logger.debug(f"Preserving self-loop on ALU operation {node} (opcode: {opcode})")

                # Check if this node has other input edges (not just the self-loop)
                predecessors = list(G.predecessors(node))
                nonSelfPredecessors = [pred for pred in predecessors if pred != node]

                # Get the maximum inputs this operation can handle
                maxInputs = self._getMaxInputsForOperation(G, node)

                # Total inputs including self-loop = non-self predecessors + 1 (self-loop)
                totalInputsWithSelfLoop = len(nonSelfPredecessors) + 1

                logger.debug(
                    f"ALU Node {node}: max_inputs={maxInputs}, non_self_predecessors={len(nonSelfPredecessors)}, "
                    f"total_with_self_loop={totalInputsWithSelfLoop}"
                )

                if nonSelfPredecessors and totalInputsWithSelfLoop > maxInputs:
                    # Only apply special case if including self-loop would exceed max inputs
                    # Categorize predecessors: duplicated nodes, constants, and regular nodes
                    duplicatedPredecessors = []
                    constPredecessors = []
                    nonConstPredecessors = []

                    for pred in nonSelfPredecessors:
                        if self._isDuplicatedNode(pred):
                            duplicatedPredecessors.append(pred)
                        elif self._isConstantOperation(G, pred):
                            constPredecessors.append(pred)
                        else:
                            nonConstPredecessors.append(pred)

                    # Calculate how many inputs need to be removed to fit within the limit
                    inputsToRemove = totalInputsWithSelfLoop - maxInputs

                    logger.debug(
                        f"ALU Node {node}: need to remove {inputsToRemove} inputs, "
                        f"have {len(duplicatedPredecessors)} duplicated, {len(constPredecessors)} constants, "
                        f"{len(nonConstPredecessors)} regular inputs"
                    )

                    # Priority order: duplicated nodes first, then constants, then regular inputs
                    nodesToRemove = []

                    # First, try to remove duplicated nodes
                    if len(duplicatedPredecessors) > 0:
                        duplicatedToRemove = min(inputsToRemove, len(duplicatedPredecessors))
                        nodesToRemove.extend(duplicatedPredecessors[:duplicatedToRemove])
                        inputsToRemove -= duplicatedToRemove

                    # If still need to remove more, remove constants
                    if inputsToRemove > 0 and len(constPredecessors) > 0:
                        constantsToRemove = min(inputsToRemove, len(constPredecessors))
                        nodesToRemove.extend(constPredecessors[:constantsToRemove])
                        inputsToRemove -= constantsToRemove

                    # Check if we can solve the problem by removing duplicated nodes and/or constants
                    if inputsToRemove <= 0:
                        # We can keep the self-loop by removing the selected nodes
                        logger.info(
                            f"ALU Node {node} with self-loop would have {totalInputsWithSelfLoop} inputs "
                            f"(exceeds max {maxInputs}). Removing {len(nodesToRemove)} inputs: {nodesToRemove}"
                        )

                        for nodeToRemove in nodesToRemove:
                            # Remove edge from node to this node
                            if G.has_edge(nodeToRemove, node):
                                G.remove_edge(nodeToRemove, node)
                                logger.debug(f"Removed edge from {nodeToRemove} to {node}")

                            # If the node has no other outputs, remove it entirely
                            if G.out_degree(nodeToRemove) == 0:
                                G.remove_node(nodeToRemove)
                                logger.debug(f"Removed node {nodeToRemove} (no more outputs)")

                        # Keep the self-loop
                        logger.debug(f"Keeping self-loop on ALU node {node}")
                        continue
                    else:
                        # Even removing all duplicated nodes and constants wouldn't be enough
                        # For ALU operations, we still try to keep the self-loop if possible
                        # by removing regular inputs as a last resort
                        if inputsToRemove <= len(nonConstPredecessors):
                            nodesToRemove.extend(nonConstPredecessors[:inputsToRemove])
                            logger.warning(
                                f"ALU Node {node}: had to remove regular inputs {nonConstPredecessors[:inputsToRemove]} "
                                f"to keep self-loop within input limit"
                            )

                            for nodeToRemove in nodesToRemove:
                                if G.has_edge(nodeToRemove, node):
                                    G.remove_edge(nodeToRemove, node)
                                    logger.debug(f"Removed edge from {nodeToRemove} to {node}")

                                if G.out_degree(nodeToRemove) == 0:
                                    G.remove_node(nodeToRemove)
                                    logger.debug(f"Removed node {nodeToRemove} (no more outputs)")

                            logger.debug(f"Keeping self-loop on ALU node {node} after removing regular inputs")
                            continue
                        else:
                            logger.warning(
                                f"ALU Node {node}: cannot keep self-loop within input limits even after "
                                f"removing all other inputs. Falling back to removing self-loop."
                            )

                # For ALU operations, if self-loop fits within limits, always keep it
                else:
                    logger.debug(f"Keeping self-loop on ALU node {node} (within input limits)")
                    continue

            # For non-ALU operations, remove self-loops as before
            logger.debug(f"Removing self-loop on non-ALU node {node} (opcode: {opcode})")
            G.remove_edge(node, node)

    def _generateVerilogBody(self, G: nx.DiGraph) -> str:
        """
        Generate the body of the Verilog module from the NetworkX graph.

        Parameters
        ----------
        G : nx.DiGraph
            NetworkX directed graph parsed from DOT file

        Returns
        -------
        str
            Verilog module body
        """
        body = ""

        # Extract unique opcodes and create local parameters
        opSet = set()
        for node in G.nodes():
            nodeData = G.nodes[node]
            opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))
            if opcode and opcode != "unknown":
                cleanOpcode = opcode.strip('"').lower()
                # Exclude load, store, and input operations since they use Mem/IO modules instead of ALU
                if cleanOpcode not in ["load", "store", "input", "output"]:
                    opSet.add(cleanOpcode)

        # Generate local parameters for opcodes
        for i, op in enumerate(sorted(opSet)):
            body += self.localParam.format(name=f"{op}_op", value=i)

        if opSet:
            body += "\n"

        # Generate global enable and reset wires
        body += "wire global_en;\n"
        body += "wire global_rst;\n"
        body += "\n"

        # Generate wires for all connections
        used = set()
        # Add global signals to used set to avoid duplication
        used.add("global_en")
        used.add("global_rst")

        for s, d in G.edges():
            if s not in used:
                sanitized_s = self.sanitize_name(s)
                # Use width-1 wire for logic and compare operations
                if self._outputsWidth1Signal(G, s):
                    body += self.wireTemplate1.format(source=sanitized_s)
                else:
                    body += self.wireTemplate.format(source=sanitized_s)
                used.add(s)

        # Generate wires for ALU intermediate signals (for pipeline registers)
        for node in G.nodes():
            nodeData = G.nodes[node]
            opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))
            if opcode:
                opcode = opcode.strip('"').lower()

            # Check if this node generates an ALU operation (not mem, compare, logic, etc.)
            if opcode in self.aluOpcodeMap or (
                opcode not in ["load", "store", "input"]
                and opcode not in self.compareOpcodeMap
                and opcode not in self.logicOpcodeMap
                and opcode != "io_width_1"
            ):
                sanitized_node = self.sanitize_name(node)
                aluSignal = f"{sanitized_node}_alu"
                if aluSignal not in used:
                    body += self.wireTemplate.format(source=aluSignal)
                    used.add(aluSignal)

        # Generate wires for output nodes (nodes with no outgoing edges)
        for node in G.nodes():
            if G.out_degree(node) == 0 and node not in used:
                sanitized_node = self.sanitize_name(node)
                # Use width-1 wire for logic and compare operations
                if self._outputsWidth1Signal(G, node):
                    body += self.wireTemplate1.format(source=sanitized_node)
                else:
                    body += self.wireTemplate.format(source=sanitized_node)

        if used or any(G.out_degree(node) == 0 for node in G.nodes()):
            body += "\n"

        # # Generate output assignments for sink nodes
        # for node in G.nodes():
        #     if G.out_degree(node) == 0:
        #         body += self.outputOp.format(value=f"out_{node}", A=node)

        if any(G.out_degree(node) == 0 for node in G.nodes()):
            body += "\n"

        # Generate global enable and reset input signals
        body += "IO_WIDTH_1 inst_global_en(.from_fabric(), .in(), .to_fabric(global_en), .out());\n"
        body += "IO_WIDTH_1 inst_global_rst(.from_fabric(), .in(), .to_fabric(global_rst), .out());\n"
        body += "\n"

        # Generate component instances
        for node in G.nodes():
            nodeData = G.nodes[node]
            body += self._generateNodeInstance(G, node, nodeData, opSet)

        return body

    def _generateNodeInstance(self, G: nx.DiGraph, node: str, nodeData: Dict, opSet: Set[str]) -> str:
        """
        Generate a Verilog instance for a single node.

        Parameters
        ----------
        G : nx.DiGraph
            NetworkX directed graph
        node : str
            Node identifier
        nodeData : Dict
            Node attributes from the graph
        opSet : Set[str]
            Set of opcodes used in the graph

        Returns
        -------
        str
            Verilog instance string
        """
        inDegree = G.in_degree(node)
        sanitized_node = self.sanitize_name(node)

        # Extract opcode and other attributes
        opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))
        if opcode:
            opcode = opcode.strip('"').lower()

        nodeType = nodeData.get("type", "").strip('"').lower()
        constVal = nodeData.get("constVal", "0").strip('"')  # Check if this node has a self-loop
        hasSelfLoop = G.has_edge(node, node)

        # Check if this is an output node (has no outgoing edges)
        outDegree = G.out_degree(node)

        # Handle nodes with incoming edges - define predecessors first
        if inDegree > 0:
            predecessors = list(G.predecessors(node))
            # Separate self-loop from other predecessors
            nonSelfPredecessors = [pred for pred in predecessors if pred != node]

        # Handle output nodes (nodes with no outgoing edges and incoming edges)
            if outDegree == 0 and inDegree > 0:
                if nodeType == "external" or nodeType == "output" or opcode == "output":
                    inputA = self.sanitize_name(nonSelfPredecessors[0]) if len(nonSelfPredecessors) > 0 else ""
                    return self.outputOp.format(value=sanitized_node, A=inputA)
                # For nodes with specific output-like opcodes, treat as output
                elif opcode in ["ret", "return", "output", "sink"] or node.endswith("_output"):
                    inputA = self.sanitize_name(nonSelfPredecessors[0]) if len(nonSelfPredecessors) > 0 else ""
                    return self.outputOp.format(value=sanitized_node, A=inputA)

        # Handle input nodes (no incoming edges)
        if inDegree == 0:
            if nodeType == "external" or nodeType == "input" or opcode == "input":
                return self.inputOp.format(value=sanitized_node, Y=sanitized_node)
            elif nodeType == "constant" or opcode == "const":
                try:
                    constValue = int(constVal) if constVal.isdigit() else 0
                except (ValueError, AttributeError):
                    constValue = 0
                return self.constOp.format(CONST=0, value=sanitized_node, Y=sanitized_node)
            elif nodeType == "reg" or opcode == "reg":
                return self.regOp.format(value=sanitized_node, IN="", Y=sanitized_node)
            else:
                # Default to constant 0 for unknown input types
                return self.constOp.format(CONST=0, value=sanitized_node, Y=sanitized_node)

        # Check if this node has more inputs than it should handle (only for nodes with incoming edges)
        if inDegree > 0:
            expectedMaxInputs = self._getMaxInputsForOperation(G, node)
            if inDegree > expectedMaxInputs:
                nodeDesc = self._getNodeDescription(G, node)
                logger.warning(
                    f"During Verilog generation: {nodeDesc} has {inDegree} inputs "
                    f"but can only handle {expectedMaxInputs}. Using first {expectedMaxInputs} inputs only."
                )

        # Special handling for IO_WIDTH_1 (transformed branch operations)
        if opcode == "io_width_1":
            inputA = self.sanitize_name(nonSelfPredecessors[0]) if len(nonSelfPredecessors) > 0 else ""
            return self.ioWidth1Op.format(value=sanitized_node, A=inputA, Y="")

        # For ALU operations with self-loops, handle feedback properly
        if hasSelfLoop and self._isAluOperation(G, node):
            logger.debug(f"Generating ALU instance for {node} with self-loop feedback")

            if len(nonSelfPredecessors) == 0:
                # Only self-loop, create unary operation with self-feedback
                opValue = self._getOpValue(opcode, self.aluOpcodeMap, 0)
                aluInstance, regInstance = self._generateAluWithRegister(
                    self.unOp, value=sanitized_node, OP=f"{opcode}_op" if opcode in opSet else opValue, A=sanitized_node, Y=sanitized_node
                )
                return aluInstance + regInstance

            elif len(nonSelfPredecessors) == 1:
                # One external input + self-loop = binary operation
                inputA = self.sanitize_name(nonSelfPredecessors[0])
                opValue = self._getOpValue(opcode, self.aluOpcodeMap, 0)
                aluInstance, regInstance = self._generateAluWithRegister(
                    self.binOp,
                    value=sanitized_node,
                    OP=f"{opcode}_op" if opcode in opSet else opValue,
                    A=inputA,
                    B=sanitized_node,  # Self-loop as second input
                    Y=sanitized_node,
                )
                return aluInstance + regInstance

            else:
                # Multiple external inputs + self-loop
                # Use first external input and self-loop
                inputA = self.sanitize_name(nonSelfPredecessors[0])
                opValue = self._getOpValue(opcode, self.aluOpcodeMap, 0)
                aluInstance, regInstance = self._generateAluWithRegister(
                    self.binOp,
                    value=sanitized_node,
                    OP=f"{opcode}_op" if opcode in opSet else opValue,
                    A=inputA,
                    B=sanitized_node,  # Self-loop as second input
                    Y=sanitized_node,
                )
                return aluInstance + regInstance

        # Handle nodes without self-loops (original logic)
        if len(nonSelfPredecessors) == 1:
            # Unary operation
            inputA = self.sanitize_name(nonSelfPredecessors[0])

            # Special handling for load operations - use Mem module
            if opcode == "load":
                return self.memOp.format(BITS=0, value=sanitized_node, ADDR=inputA, WDATA="", WEN="", Y=sanitized_node)
            else:
                # Regular unary ALU operation with pipeline register
                opValue = self._getOpValue(opcode, self.aluOpcodeMap, 0)
                aluInstance, regInstance = self._generateAluWithRegister(
                    self.unOp, value=sanitized_node, OP=f"{opcode}_op" if opcode in opSet else opValue, A=inputA, Y=sanitized_node
                )
                return aluInstance + regInstance

        elif len(nonSelfPredecessors) == 2:
            # Binary operation - need to determine correct operand order
            inputA, inputB = self._getOperandOrder(G, node, nonSelfPredecessors)
            sanitized_inputA = self.sanitize_name(inputA)
            sanitized_inputB = self.sanitize_name(inputB)

            # Special handling for load operations with 2 inputs (address + data) - use Mem module
            if opcode == "load":
                return self.memOp.format(BITS=0, value=sanitized_node, ADDR=sanitized_inputA, WDATA=sanitized_inputB, WEN="", Y=sanitized_node)
            # Special handling for store operations - use Mem module for memory write
            elif opcode == "store":
                return self.memOp.format(BITS=0, value=sanitized_node, ADDR=sanitized_inputA, WDATA=sanitized_inputB, WEN="", Y=sanitized_node)
            # Determine operation type
            elif opcode in self.compareOpcodeMap:
                opValue = self.compareOpcodeMap[opcode]
                return self.compareOp.format(OP=opValue, value=sanitized_node, A=sanitized_inputA, B=sanitized_inputB, Y=sanitized_node)
            elif opcode in self.logicOpcodeMap:
                opValue = self.logicOpcodeMap[opcode]
                return self.logicOp.format(OP=opValue, value=sanitized_node, A=sanitized_inputA, B=sanitized_inputB, Y=sanitized_node)
            else:
                # Default to ALU binary operation with pipeline register
                opValue = self._getOpValue(opcode, self.aluOpcodeMap, 0)
                aluInstance, regInstance = self._generateAluWithRegister(
                    self.binOp,
                    value=sanitized_node,
                    OP=f"{opcode}_op" if opcode in opSet else opValue,
                    A=sanitized_inputA,
                    B=sanitized_inputB,
                    Y=sanitized_node,
                )
                return aluInstance + regInstance

        else:
            # More than 2 inputs or no inputs - handle appropriately
            if len(nonSelfPredecessors) >= 2:
                inputA, inputB = nonSelfPredecessors[:2]
                sanitized_inputA = self.sanitize_name(inputA)
                sanitized_inputB = self.sanitize_name(inputB)

                # Special handling for store operations with multiple inputs - use Mem module
                if opcode == "store":
                    return self.memOp.format(BITS=0, value=sanitized_node, ADDR=sanitized_inputA, WDATA=sanitized_inputB, WEN="", Y=sanitized_node)
                # Special handling for load operations with multiple inputs - use Mem module
                elif opcode == "load":
                    return self.memOp.format(BITS=0, value=sanitized_node, ADDR=sanitized_inputA, WDATA=sanitized_inputB, WEN="", Y=sanitized_node)
                else:
                    # Multi-input ALU operation with pipeline register (using first two inputs)
                    opValue = self._getOpValue(opcode, self.aluOpcodeMap, 0)
                    aluInstance, regInstance = self._generateAluWithRegister(
                        self.binOp,
                        value=sanitized_node,
                        OP=f"{opcode}_op" if opcode in opSet else opValue,
                        A=sanitized_inputA,
                        B=sanitized_inputB,
                        Y=sanitized_node,
                    )
                    return aluInstance + regInstance
            elif len(nonSelfPredecessors) == 0 and not hasSelfLoop:
                # No inputs at all - fallback to constant
                return self.constOp.format(CONST=0, value=sanitized_node, Y=sanitized_node)
            else:
                # Fallback
                return self.constOp.format(CONST=0, value=sanitized_node, Y=sanitized_node)

    def _getOperandOrder(self, G: nx.DiGraph, node: str, predecessors: List[str]) -> Tuple[str, str]:
        """
        Determine the correct operand order for binary operations.

        Parameters
        ----------
        G : nx.DiGraph
            NetworkX directed graph
        node : str
            Current node
        predecessors : List[str]
            List of predecessor nodes

        Returns
        -------
        Tuple[str, str]
            Ordered pair of operands (A, B)
        """
        if len(predecessors) != 2:
            return predecessors[0], predecessors[1] if len(predecessors) > 1 else ""

        predA, predB = predecessors

        # Check edge attributes for operand information
        edgeDataA = G.get_edge_data(predA, node, {})
        edgeDataB = G.get_edge_data(predB, node, {})

        operandA = edgeDataA.get("operand", "").strip('"').upper()
        operandB = edgeDataB.get("operand", "").strip('"').upper()

        # Determine order based on operand labels
        if operandA == "LHS" or operandA == "ANY2INPUT":
            return predA, predB
        elif operandB == "LHS" or operandB == "ANY2INPUT":
            return predB, predA
        elif operandA == "RHS":
            return predB, predA
        elif operandB == "RHS":
            return predA, predB
        else:
            # Default order
            return predA, predB

    def _getOpValue(self, opcode: str, opcodeMap: Dict[str, int], default: int) -> int:
        """
        Get numeric value for an opcode from the mapping.

        Parameters
        ----------
        opcode : str
            Operation code
        opcodeMap : Dict[str, int]
            Mapping from opcode strings to integers
        default : int
            Default value if opcode not found

        Returns
        -------
        int
            Numeric operation value
        """
        return opcodeMap.get(opcode, default)

    def _generateAluWithRegister(self, opTemplate: str, registerSuffix: str = "_reg", **kwargs) -> tuple[str, str]:
        """
        Generate ALU operation followed by a pipeline register.

        Parameters
        ----------
        opTemplate : str
            The ALU operation template (unOp, binOp, terOp)
        registerSuffix : str
            Suffix to add to the register instance name
        **kwargs
            Keyword arguments to format the ALU template

        Returns
        -------
        tuple[str, str]
            (ALU_instance_code, Register_instance_code)
        """
        # Generate the ALU operation with intermediate signal
        aluSignal = f"{kwargs['value']}_alu"
        aluKwargs = kwargs.copy()
        aluKwargs["Y"] = aluSignal
        aluInstance = opTemplate.format(**aluKwargs)

        # Generate the register operation
        regInstance = self.regOp.format(value=f"{kwargs['value']}{registerSuffix}", IN=aluSignal, Y=kwargs["value"])

        return aluInstance, regInstance

    def _duplicateConstantOperations(self, G: nx.DiGraph) -> None:
        """
        Duplicate constant operations that have multiple outputs.

        Each constant operation should have only one output to ensure proper
        resource allocation and avoid conflicts in the generated hardware.

        Parameters
        ----------
        G : nx.DiGraph
            Graph to modify in-place
        """
        # Find all constant nodes with multiple outputs
        constantNodesWithMultipleOutputs = []

        for node in G.nodes():
            nodeData = G.nodes[node]
            opcode = nodeData.get("opcode", nodeData.get("label", "unknown"))
            nodeType = nodeData.get("type", "").strip('"').lower()

            # Check if this is a constant operation
            isConstant = False
            if opcode:
                opcode = opcode.strip('"').lower()
                isConstant = opcode in ["const", "constant"]
            if nodeType == "constant":
                isConstant = True

            # Check for constant nodes with no incoming edges (source constants)
            if G.in_degree(node) == 0 and not isConstant:
                # Check if this is likely a constant based on naming or other attributes
                constVal = nodeData.get("constVal", "").strip('"')
                if constVal and constVal.isdigit():
                    isConstant = True

            if isConstant and G.out_degree(node) > 1:
                constantNodesWithMultipleOutputs.append(node)

        logger.info(f"Found {len(constantNodesWithMultipleOutputs)} constant nodes with multiple outputs")

        for constNode in constantNodesWithMultipleOutputs:
            successors = list(G.successors(constNode))
            constNodeData = G.nodes[constNode]

            logger.debug(f"Duplicating constant node {constNode} for {len(successors)} outputs")

            # Keep the original connection to the first successor
            # Create duplicate nodes for remaining successors
            for i, successor in enumerate(successors[1:], start=1):
                # Create unique name for duplicate constant node
                duplicateNodeName = f"{constNode}_dup_{i}"

                # Copy all attributes from original constant node
                duplicateNodeData = constNodeData.copy()
                G.add_node(duplicateNodeName, **duplicateNodeData)

                # Get edge data from original connection
                edgeData = G.get_edge_data(constNode, successor, {})

                # Remove original edge to this successor
                G.remove_edge(constNode, successor)

                # Add edge from duplicate constant to successor
                G.add_edge(duplicateNodeName, successor, **edgeData)

                logger.debug(f"Created duplicate constant {duplicateNodeName} -> {successor}")


def convertAllMicrobenchGraphs() -> Dict[str, Optional[tuple[str, nx.DiGraph]]]:
    """
    Convert all pre-gen-graph DOT files from microbench to Verilog.

    Returns
    -------
    Dict[str, Optional[tuple[str, nx.DiGraph]]]
        Dictionary mapping benchmark names to generated Verilog code and graph, or None if failed
    """
    converter = DotToVerilogConverter()
    microbenchDir = Path("/home/kelvin/FABulous_fork/benchmarks/microbench")

    results: dict[str, Optional[tuple[str, nx.DiGraph]]] = {}

    if not microbenchDir.exists():
        logger.error(f"Microbench directory not found: {microbenchDir}")
        return results

    # Find all pre-gen-graph DOT files
    preGenGraphFiles = list(microbenchDir.glob("*/pre-gen-graph*.dot"))

    logger.info(f"Found {len(preGenGraphFiles)} pre-gen-graph DOT files")

    for dotFile in preGenGraphFiles:
        try:
            benchmarkName = dotFile.parent.name
            logger.info(f"Processing {benchmarkName}: {dotFile}")

            verilogCode, transformedGraph = converter.convertDotToVerilog(dotFile, benchmarkName)

            if verilogCode:
                results[benchmarkName] = (verilogCode, transformedGraph)
                logger.info(f"✓ Successfully converted {benchmarkName}")
            else:
                logger.warning(f"✗ Failed to convert {benchmarkName}")
                results[benchmarkName] = None

        except Exception as e:
            logger.error(f"✗ Error converting {dotFile}: {e}")
            results[dotFile.parent.name] = None

    return results


if __name__ == "__main__":
    # Test conversion
    converter = DotToVerilogConverter()

    # Test with a specific file
    testFile = Path("/home/kelvin/FABulous_fork/benchmarks/microbench/mac/pre-gen-graph_loop.dot")

    if testFile.exists():
        verilogCode, transformedGraph = converter.convertDotToVerilog(testFile)
        print("Generated Verilog:")
        print(verilogCode)
    else:
        print(f"Test file not found: {testFile}")

        # Try batch conversion
        results = convertAllMicrobenchGraphs()
        for name, result in results.items():
            if result and isinstance(result, tuple):
                verilogCode, graph = result
                print(f"\n=== {name} ===")
                print(verilogCode[:500] + "..." if len(verilogCode) > 500 else verilogCode)
