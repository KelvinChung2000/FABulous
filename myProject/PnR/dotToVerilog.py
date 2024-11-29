from pathlib import Path

import networkx as nx

module = "module {name} #(parameter WIDTH=32);\n\n{body}\nendmodule\n"
wireTemplate = "wire[WIDTH-1:0] {source};\n"
constOp = "ConstOp #(.CONST({CONST}), .WIDTH(WIDTH)) inst_{value}(.Y({Y}));\n"
regOp = "RegOp #(.WIDTH(WIDTH)) inst_{value}(.Y({Y}));\n"
unOp = "UnaryOp #(.OP({OP}), .WIDTH(WIDTH)) inst_{value}(.A({A}), .Y({Y}));\n"
binOp = (
    "BinaryOp #(.OP({OP}), .WIDTH(WIDTH)) inst_{value}(.A({A}), .B({B}), .Y({Y}));\n"
)
terOp = "TernaryOp #(.OP({OP}), .WIDTH(WIDTH)) inst_{value}(.A({A}), .B({B}), .C({C}), .Y({Y}));\n"

inputOp = "InputOp #(.WIDTH(WIDTH)) {value}(.Y({Y}));\n"
outputOp = "OutputOp #(.WIDTH(WIDTH)) {value}(.A({A}));\n"

localParam = "localparam {name} = {value};\n"


def dotToVerilog(dotFile: Path, verilogFile: Path):
    G = nx.DiGraph(nx.nx_pydot.read_dot(dotFile))
    body = ""

    opSet = set()
    for node in G.nodes():
        opSet.add(G.nodes[node]["opcode"])

    for i, op in enumerate(opSet):
        body += localParam.format(name=f"{op}_op", value=i)

    used = set()
    for s, d in G.edges():
        if s not in used:
            body += wireTemplate.format(source=s)
            used.add(s)

    for i in G.nodes:
        if G.out_degree(i) == 0:
            body += wireTemplate.format(source=i)

    for i in G.nodes:
        if G.out_degree(i) == 0:
            body += outputOp.format(value=f"out_{i}", A=i)

    for node in G.nodes():
        if G.in_degree(node) == 0:
            if G.nodes[node]["type"] == "external":
                body += inputOp.format(value=f"inst_{node}", Y=node)
            elif G.nodes[node]["type"] == "constant":
                body += constOp.format(
                    CONST=G.nodes[node]["constVal"], value=f"inst_{node}", Y=node
                )
            elif G.nodes[node]["type"] == "reg":
                body += regOp.format(value=f"inst_{node}", Y=node)
            else:
                body += constOp.format(CONST=0, value=f"inst_{node}", Y=node)

        elif G.in_degree(node) == 1:
            body += unOp.format(
                OP=f"{G.nodes[node]["opcode"]}_op",
                value=node,
                A=list(G.predecessors(node))[0],
                Y=node,
            )
        elif G.in_degree(node) == 2:
            a, b = list(G.predecessors(node))
            lhs = (
                list(G.predecessors(node))[0]
                if G.edges[a, node]["operand"] == "LHS"
                or G.edges[a, node]["operand"] == "any2input"
                else list(G.predecessors(node))[1]
            )
            rhs = (
                list(G.predecessors(node))[1]
                if G.edges[b, node]["operand"] == "RHS"
                or G.edges[b, node]["operand"] == "any2input"
                else list(G.predecessors(node))[0]
            )
            body += binOp.format(
                OP=f"{G.nodes[node]["opcode"]}_op",
                value=node,
                A=lhs,
                B=rhs,
                Y=node,
            )
        elif G.in_degree(node) == 3:
            body += terOp.format(
                OP=f"{G.nodes[node]["opcode"]}_op",
                value=node,
                A=list(G.predecessors(node))[0],
                B=list(G.predecessors(node))[1],
                C=list(G.predecessors(node))[2],
                Y=node,
            )
        else:
            raise ValueError("Invalid number of inputs")

    with open(verilogFile, "w") as f:
        f.write(module.format(name="test", body=body))


if __name__ == "__main__":
    dotToVerilog(
        Path.cwd() / "myProject/PnR/test.dfg.dot",
        Path.cwd() / "myProject/PnR/test.v",
    )
