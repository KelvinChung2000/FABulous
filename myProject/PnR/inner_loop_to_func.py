#!/usr/bin/env python3
"""
Script to extract the innermost loop of a function and create a separate function.
Uses xDSL to parse and manipulate MLIR code.
"""

import argparse
import sys
from typing import List

from xdsl.context import Context
from xdsl.dialects import affine, arith, builtin, func, memref, scf
from xdsl.ir import Block, Operation, Region, SSAValue
from xdsl.parser import Parser
from xdsl.printer import Printer


def normalize_scf_while_loops(module: Operation) -> None:
    """Transform scf.while loops into guarded simple loops for easier extraction."""

    # Find all scf.while operations in the module
    while_loops = []
    for op in module.walk():
        if op.name == "scf.while":
            while_loops.append(op)

    print(f"Found {len(while_loops)} scf.while loops to normalize")

    # Transform each scf.while loop - process in reverse order to avoid iterator invalidation
    for i, while_op in enumerate(reversed(while_loops)):
        try:
            print(f"  Normalizing scf.while loop {len(while_loops) - i}/{len(while_loops)}")
            _transform_scf_while_to_guarded_loop(while_op)
        except Exception as e:
            print(f"  Warning: Could not normalize scf.while loop {len(while_loops) - i}: {e}")


def _transform_scf_while_to_guarded_loop(while_op: Operation) -> None:
    """Transform scf.while into: initial_before_ops + scf.if(cond) { after_body } else { value }"""

    # Get the parent block and insertion point
    parent_block = while_op.parent_block()
    if not parent_block:
        raise Exception("scf.while has no parent block")

    # Get the regions
    if not hasattr(while_op, "regions") or len(while_op.regions) < 2:
        raise Exception(
            f"scf.while missing regions - has {len(while_op.regions) if hasattr(while_op, 'regions') else 0} regions"
        )

    before_region = while_op.regions[0]
    after_region = while_op.regions[1]

    if not before_region.blocks or not after_region.blocks:
        raise Exception("scf.while regions missing blocks")

    before_block = before_region.blocks[0]

    # Get initial arguments and types
    init_args = list(while_op.operands)
    result_types = list(while_op.result_types) if hasattr(while_op, "result_types") else []

    # Clone before region operations (excluding scf.condition) - these become the "first iteration"
    initial_ops = []
    first_iteration_results = []  # Track the results from the first iteration
    value_mapping = {}

    # Map initial arguments to before block arguments
    if before_block.args:
        for init_arg, block_arg in zip(init_args, before_block.args):
            value_mapping[block_arg] = init_arg

    # Clone operations and find condition
    condition_op = None
    for op in before_block.ops:
        if op.name == "scf.condition":
            condition_op = op
            break
        else:
            cloned_op = _clone_operation_with_mapping(op, value_mapping)
            initial_ops.append(cloned_op)
            # Update mapping for results and track first iteration results
            if hasattr(op, "results") and hasattr(cloned_op, "results"):
                for orig_result, cloned_result in zip(op.results, cloned_op.results):
                    value_mapping[orig_result] = cloned_result
                    first_iteration_results.append(cloned_result)

    if not condition_op:
        raise Exception("No scf.condition found in before region")

    # Get condition and values from the scf.condition operation
    condition_operands = [value_mapping.get(operand, operand) for operand in condition_op.operands]

    if len(condition_operands) == 0:
        raise Exception("scf.condition has no operands")

    guard_condition = condition_operands[0]
    guard_values = condition_operands[1:] if len(condition_operands) > 1 else []

    # Insert initial operations before the while loop
    for op in initial_ops:
        parent_block.insert_op_before(op, while_op)

    # Create scf.if to guard the simplified while loop

    # Create the then region with the after region body
    then_region = Region()
    then_block = Block(arg_types=[])
    then_region.add_block(then_block)

    # Create else region
    else_region = Region()
    else_block = Block(arg_types=[])
    else_region.add_block(else_block)

    # Create a simple while loop that repeats the before region logic
    # This creates the structure from the example: while %condition { before_region_ops }

    # Create a pure while loop for the then branch
    # The before region should have ONLY scf.condition (no computation operations)
    # All computation operations move to the do region

    # Create the pure while loop's before region with only scf.condition
    pure_while_before_region = Region()
    pure_while_before_block = Block(arg_types=[arg.type for arg in before_block.args])
    pure_while_before_region.add_block(pure_while_before_block)

    # Add only scf.condition to the before region - use the external guard condition
    pure_condition = scf.ConditionOp(guard_condition, *pure_while_before_block.args)
    pure_while_before_block.add_op(pure_condition)

    # Create new after region that contains the original before region computation
    new_after_region = Region()
    new_after_block = Block(arg_types=[arg.type for arg in before_block.args])
    new_after_region.add_block(new_after_block)

    # Create value mapping for the new after block arguments
    after_value_mapping = {}
    for i, block_arg in enumerate(new_after_block.args):
        if i < len(before_block.args):
            after_value_mapping[before_block.args[i]] = block_arg

    # Clone the original before region operations (excluding scf.condition) into the new after region
    after_results = []

    for op in before_block.ops:
        if op.name != "scf.condition":
            # Clone the operation with mapped operands
            cloned_op = _clone_operation_with_mapping(op, after_value_mapping)
            new_after_block.add_op(cloned_op)

            # Update mapping for results
            if hasattr(op, "results") and hasattr(cloned_op, "results"):
                for orig_result, cloned_result in zip(op.results, cloned_op.results):
                    after_value_mapping[orig_result] = cloned_result
                    after_results.append(cloned_result)

    # Get the condition operands from the original scf.condition
    # These will be used for the final yield in the new after region
    final_yield_values = []
    if condition_op and len(condition_op.operands) > 1:
        for operand in condition_op.operands[1:]:  # Skip the condition boolean
            mapped_operand = after_value_mapping.get(operand, operand)
            final_yield_values.append(mapped_operand)

    # Add yield operation to the new after region
    if final_yield_values:
        after_yield = scf.YieldOp(*final_yield_values)
        new_after_block.add_op(after_yield)
    else:
        # Fallback empty yield
        after_yield = scf.YieldOp()
        new_after_block.add_op(after_yield)

    # Create the pure while loop: while (guard_condition) { computation_in_after_region }
    simple_while = scf.WhileOp(guard_values, result_types, pure_while_before_region, new_after_region)
    then_block.add_op(simple_while)

    # Add yield to then region using the while loop results
    then_yield = scf.YieldOp(*simple_while.results)
    then_block.add_op(then_yield)

    # Add yield to else region
    else_yield = scf.YieldOp(*guard_values)
    else_block.add_op(else_yield)

    # Create the if operation
    if_op = scf.IfOp(guard_condition, result_types, then_region, else_region)

    # Insert the if operation and remove the original while
    parent_block.insert_op_before(if_op, while_op)

    # Replace uses of original while results with if results
    if hasattr(while_op, "results") and hasattr(if_op, "results"):
        for orig_result, new_result in zip(while_op.results, if_op.results):
            orig_result.replace_by(new_result)

    # Important: Also need to replace references to the scf.while block arguments
    # The scf.while block arguments should be replaced with the init_args
    if before_block.args and init_args:
        for block_arg, init_arg in zip(before_block.args, init_args):
            # Find all uses of the block argument and replace with the init_arg
            block_arg.replace_by(init_arg)

    # Remove original while
    while_op.detach()

    print("    Successfully transformed scf.while into guarded if structure")


def find_innermost_loops(op: Operation) -> List[Operation]:
    """Find all loops that have no nested loops inside them (leaf loops).
    After normalization, look for scf.while loops that are now nested inside scf.if operations."""
    innermost_loops = []

    # Find all loops in the operation using xDSL's walk method
    # After normalization, scf.while loops are nested inside scf.if operations
    all_loops = [loop_op for loop_op in op.walk() if loop_op.name in ["affine.for", "scf.for", "scf.while"]]

    # For each loop, check if it contains any nested loops
    for loop_op in all_loops:
        # Use walk to find any nested loops within this loop
        nested_loops = [
            nested
            for nested in loop_op.walk()
            if nested.name in ["affine.for", "scf.for", "scf.while"] and nested != loop_op
        ]

        # If no nested loops found, this is an innermost loop
        if not nested_loops:
            innermost_loops.append(loop_op)

    return innermost_loops


def create_extracted_function(loop_op: Operation, func_name: str, parent_func: Operation) -> Operation:
    """Create a new function containing the loop body with proper arguments and return types."""

    # Find all values used in the loop body that are defined outside the loop
    external_values = []

    # First, add loop arguments (induction variable and iter_args) as they'll be needed as function parameters
    # For transformed scf.while loops that are now scf.if, we need to handle this differently
    if loop_op.name == "scf.if":
        # For scf.if (transformed from scf.while), we don't have traditional loop arguments
        # The transformed scf.if uses the guard values from the original condition
        pass
    elif loop_op.name == "scf.while":
        # For scf.while loops, get arguments from the "do" region (second region)
        if hasattr(loop_op, "regions") and len(loop_op.regions) >= 2:
            do_region = loop_op.regions[1]  # The "do" region contains the actual loop body
            for block in do_region.blocks:
                for block_arg in block.args:
                    external_values.append(block_arg)
    elif hasattr(loop_op, "body") and loop_op.body:
        for block in loop_op.body.blocks:
            for block_arg in block.args:
                external_values.append(block_arg)

    # Separate constants from other external values
    constants_to_recreate = []

    # Walk through all operations in the loop body
    for op in loop_op.walk():
        if op != loop_op:  # Skip the loop operation itself
            for operand in op.operands:
                # Check if this operand is an SSAValue and defined outside the loop
                if isinstance(operand, SSAValue):
                    if hasattr(operand, "owner") and operand.owner:
                        if not _is_operation_within(operand.owner, loop_op):
                            # Check if this is a constant operation
                            if hasattr(operand.owner, "name") and operand.owner.name == "arith.constant":
                                # Store constant for recreation instead of passing as argument
                                if operand not in [c[0] for c in constants_to_recreate]:
                                    constants_to_recreate.append((operand, operand.owner))
                            else:
                                # Non-constant external value - pass as argument
                                if operand not in external_values:
                                    external_values.append(operand)
                    else:
                        # This might be a block argument from outside the loop
                        if operand not in external_values:
                            external_values.append(operand)

    # Determine argument types from external values
    arg_types = [val.type for val in external_values]

    print(f"    External values found: {len(external_values)}, Constants to recreate: {len(constants_to_recreate)}")

    # Find the yield operation to determine return types
    return_types = []
    for op in loop_op.walk():
        if op.name in ["affine.yield", "scf.yield"]:
            for operand in op.operands:
                return_types.append(operand.type)
            break

    # Create function type
    func_type = builtin.FunctionType.from_lists(arg_types, return_types)

    # Create the new function operation (entry block is automatically created)
    new_func = func.FuncOp(func_name, func_type, visibility=None)

    # Get the automatically created entry block
    entry_block = new_func.body.blocks[0]

    # Clone the loop body operations into the new function
    _clone_loop_body_to_function(loop_op, new_func, external_values, new_func.args, constants_to_recreate)

    return new_func


def replace_loop_with_call(parent_func: Operation, loop_op: Operation, extracted_func_name: str):
    """Replace the loop body with a function call to the extracted function."""

    # Find all external values that need to be passed as arguments (same logic as create_extracted_function)
    external_values = []

    # First, add loop arguments (induction variable and iter_args) - but when calling, pass the actual values
    loop_args_placeholders = []
    if loop_op.name == "scf.while":
        # For scf.while loops, get arguments from the "do" region (second region)
        if hasattr(loop_op, "regions") and len(loop_op.regions) >= 2:
            do_region = loop_op.regions[1]  # The "do" region contains the actual loop body
            for block in do_region.blocks:
                for block_arg in block.args:
                    loop_args_placeholders.append(block_arg)
                    external_values.append(None)  # Placeholder, will be filled with actual values
    elif hasattr(loop_op, "body") and loop_op.body:
        for block in loop_op.body.blocks:
            for block_arg in block.args:
                loop_args_placeholders.append(block_arg)
                external_values.append(None)  # Placeholder, will be filled with actual values

    # Separate constants from other external values (constants will be recreated in function)
    for op in loop_op.walk():
        if op != loop_op:  # Skip the loop operation itself
            for operand in op.operands:
                # Check if this operand is an SSAValue and defined outside the loop
                if isinstance(operand, SSAValue):
                    if hasattr(operand, "owner") and operand.owner:
                        if not _is_operation_within(operand.owner, loop_op):
                            # Skip constants - they will be recreated in the function, not passed as arguments
                            if not (hasattr(operand.owner, "name") and operand.owner.name == "arith.constant"):
                                if operand not in external_values:
                                    external_values.append(operand)
                    else:
                        # This might be a block argument from outside the loop
                        if operand not in external_values:
                            external_values.append(operand)

    # Replace placeholders with actual loop arguments
    # For scf.for: first arg is induction var, rest are iter_args
    # For scf.while: args are the loop variables
    actual_call_args = []
    loop_arg_index = 0
    for val in external_values:
        if val is None:  # This was a loop argument placeholder
            # Get the loop block based on loop type
            if loop_op.name == "scf.while":
                if hasattr(loop_op, "regions") and len(loop_op.regions) >= 2:
                    loop_block = loop_op.regions[1].blocks[0]  # "do" region
                    actual_call_args.append(loop_block.args[loop_arg_index])
            else:
                loop_block = loop_op.body.blocks[0]
                actual_call_args.append(loop_block.args[loop_arg_index])
            loop_arg_index += 1
        else:
            actual_call_args.append(val)

    external_values = actual_call_args

    # Get return types from the loop results - these will be yielded by the function call
    yield_types = []
    for op in loop_op.walk():
        if op.name in ["scf.yield", "affine.yield"]:
            for operand in op.operands:
                yield_types.append(operand.type)
            break

    # Create function call operation
    call_op = func.CallOp(extracted_func_name, external_values, yield_types)

    # Replace the loop body with the function call
    try:
        # Access the loop body region based on loop type
        if loop_op.name == "scf.while":
            # For scf.while loops, replace the "do" region (second region)
            if hasattr(loop_op, "regions") and len(loop_op.regions) >= 2:
                do_region = loop_op.regions[1]  # The "do" region contains the actual loop body
                
                # Replace the body contents
                for block in do_region.blocks:
                    # Find and preserve the yield operation
                    yield_op = None
                    for op in list(block.ops):
                        if op.name in ["scf.yield", "affine.yield"]:
                            yield_op = op
                            break

                    # Remove all operations from the block
                    ops_to_remove = list(block.ops)
                    for op in ops_to_remove:
                        block.detach_op(op)

                    # Add the function call
                    block.add_op(call_op)

                    # Create new yield operation using function call results
                    if yield_types and len(yield_types) > 0:
                        new_yield = scf.YieldOp(*call_op.results)
                        block.add_op(new_yield)
                    elif yield_op:
                        # If there was a yield but no return types, recreate empty yield
                        new_yield = scf.YieldOp()
                        block.add_op(new_yield)

                    print(f"  Replaced loop body of {loop_op.name} with call to {extracted_func_name}")
                    break
            else:
                print(f"  Warning: scf.while loop missing do region")
                
        elif hasattr(loop_op, "body") and loop_op.body:
            loop_body = loop_op.body

            # Replace the body contents
            for block in loop_body.blocks:
                # Find and preserve the yield operation
                yield_op = None
                for op in list(block.ops):
                    if op.name in ["scf.yield", "affine.yield"]:
                        yield_op = op
                        break

                # Remove all operations from the block
                ops_to_remove = list(block.ops)
                for op in ops_to_remove:
                    block.detach_op(op)

                # Add the function call
                block.add_op(call_op)

                # Create new yield operation using function call results
                if yield_types and len(yield_types) > 0:
                    if loop_op.name == "affine.for":
                        new_yield = affine.YieldOp.get(*call_op.results)
                    else:  # scf.for
                        new_yield = scf.YieldOp(*call_op.results)
                    block.add_op(new_yield)
                elif yield_op:
                    # If there was a yield but no return types, recreate empty yield
                    if loop_op.name == "affine.for":
                        new_yield = affine.YieldOp.get()
                    else:
                        new_yield = scf.YieldOp()
                    block.add_op(new_yield)

                print(f"  Replaced loop body of {loop_op.name} with call to {extracted_func_name}")
                break
        else:
            print(f"  Warning: Could not access body/regions of loop {loop_op.name}")

    except Exception as e:
        print(f"  Warning: Could not replace loop body {loop_op.name}: {e}")
        pass


def _is_operation_within(defining_op: Operation, container_op: Operation) -> bool:
    """Check if an operation is defined within a container operation."""
    try:
        current = defining_op
        while current:
            if current == container_op:
                return True
            if hasattr(current, "parent_op"):
                current = current.parent_op()
            elif hasattr(current, "parent"):
                current = current.parent
            else:
                break
        return False
    except:
        return False


def _get_loop_results(loop_op: Operation) -> List[SSAValue]:
    """Get the result values from a loop operation."""
    if hasattr(loop_op, "results"):
        return list(loop_op.results)
    return []


def _clone_loop_body_to_function(
    loop_op: Operation, new_func: Operation, external_values: List[SSAValue], func_args, constants_to_recreate
):
    """Clone the loop body operations into the new function, replacing external references with function arguments."""

    # Create a mapping from external values to function arguments
    value_mapping = dict(zip(external_values, func_args))

    # Recreate constants in the function and add to value mapping
    entry_block = new_func.body.blocks[0]
    for const_val, const_op in constants_to_recreate:
        try:
            # Clone the constant operation
            cloned_const = const_op.clone()
            entry_block.add_op(cloned_const)
            # Map the original constant value to the new one
            value_mapping[const_val] = cloned_const.result
        except Exception as e:
            print(f"      Warning: Could not create constant for {const_val}: {e}")

    # Get the loop body and clone operations
    cloned_operations = []
    return_values = []
    
    # Handle different loop types
    if loop_op.name == "scf.while":
        # For scf.while loops, we need to extract from the "do" region (second region)
        if hasattr(loop_op, "regions") and len(loop_op.regions) >= 2:
            do_region = loop_op.regions[1]  # The "do" region contains the actual loop body
            
            for block in do_region.blocks:
                for op in block.ops:
                    if op.name not in ["scf.yield", "affine.yield"]:
                        # Clone the operation with remapped operands
                        try:
                            cloned_op = _clone_operation_with_mapping(op, value_mapping)
                            cloned_operations.append(cloned_op)
                            new_func.body.blocks[0].add_op(cloned_op)

                            # Update value mapping for results of this operation
                            if hasattr(op, "results") and hasattr(cloned_op, "results"):
                                for orig_result, cloned_result in zip(op.results, cloned_op.results):
                                    value_mapping[orig_result] = cloned_result

                            # Recursively process nested regions (e.g., scf.if blocks)
                            if hasattr(op, "regions") and hasattr(cloned_op, "regions"):
                                for orig_region, cloned_region in zip(op.regions, cloned_op.regions):
                                    _clone_region_with_mapping(orig_region, cloned_region, value_mapping)

                        except Exception as e:
                            print(f"Warning: Could not clone operation {op.name}: {e}")
                            continue
                    else:
                        # Handle yield operation - extract return values
                        for operand in op.operands:
                            mapped_operand = value_mapping.get(operand, operand)
                            return_values.append(mapped_operand)
        else:
            print(f"Warning: scf.while loop missing do region")
            
    elif hasattr(loop_op, "body") and loop_op.body:
        # For scf.for and affine.for loops, get the body region
        loop_body = loop_op.body

        # Clone each operation in the loop body (excluding yield operations)
        for block in loop_body.blocks:
            for op in block.ops:
                if op.name not in ["scf.yield", "affine.yield"]:
                    # Clone the operation with remapped operands
                    try:
                        cloned_op = _clone_operation_with_mapping(op, value_mapping)
                        cloned_operations.append(cloned_op)
                        new_func.body.blocks[0].add_op(cloned_op)

                        # Update value mapping for results of this operation
                        if hasattr(op, "results") and hasattr(cloned_op, "results"):
                            for orig_result, cloned_result in zip(op.results, cloned_op.results):
                                value_mapping[orig_result] = cloned_result

                        # Recursively process nested regions (e.g., scf.if blocks)
                        if hasattr(op, "regions") and hasattr(cloned_op, "regions"):
                            for orig_region, cloned_region in zip(op.regions, cloned_op.regions):
                                _clone_region_with_mapping(orig_region, cloned_region, value_mapping)

                    except Exception as e:
                        print(f"Warning: Could not clone operation {op.name}: {e}")
                        continue
                else:
                    # Handle yield operation - extract return values
                    for operand in op.operands:
                        mapped_operand = value_mapping.get(operand, operand)
                        return_values.append(mapped_operand)
    else:
        print(f"Warning: Could not access body/regions of loop {loop_op.name}")

    # Add return operation with mapped values
    if return_values:
        return_op = func.ReturnOp(*return_values)
    else:
        return_op = func.ReturnOp()

    new_func.body.blocks[0].add_op(return_op)


def _clone_operation_with_mapping(op: Operation, value_mapping: dict) -> Operation:
    """Clone an operation while remapping its operands according to the value mapping."""

    # Map operands - this is the critical step
    new_operands = []
    for operand in op.operands:
        if operand in value_mapping:
            mapped_operand = value_mapping[operand]
            new_operands.append(mapped_operand)
        else:
            new_operands.append(operand)

    # Try to create a new operation with the mapped operands
    try:
        # Get result types from original operation
        if hasattr(op, "results"):
            result_types = [result.type for result in op.results]
        else:
            result_types = []

        # Get attributes from original operation
        attributes = op.attributes if hasattr(op, "attributes") else {}

        # Use a simpler approach - clone and replace operands directly
        new_op = op.clone()

        # Replace operands in the cloned operation
        # This works by directly modifying the operand list
        if hasattr(new_op, "operands") and len(new_operands) == len(new_op.operands):
            for i, new_operand in enumerate(new_operands):
                new_op.operands[i] = new_operand

        return new_op

    except Exception as e:
        print(f"      Warning: Could not create operation {op.name} with mapped operands: {e}")
        # Fallback: return original operation clone
        return op.clone()


def _clone_region_with_mapping(orig_region: Region, cloned_region: Region, value_mapping: dict):
    """Recursively clone region contents with value mapping."""
    try:
        for orig_block, cloned_block in zip(orig_region.blocks, cloned_region.blocks):
            # Clear the cloned block and rebuild it with mapped values
            ops_to_remove = list(cloned_block.ops)
            for op in ops_to_remove:
                cloned_block.detach_op(op)

            # Clone each operation in the original block
            for op in orig_block.ops:
                cloned_op = _clone_operation_with_mapping(op, value_mapping)
                cloned_block.add_op(cloned_op)

                # Update value mapping for results
                if hasattr(op, "results") and hasattr(cloned_op, "results"):
                    for orig_result, cloned_result in zip(op.results, cloned_op.results):
                        value_mapping[orig_result] = cloned_result

                # Recursively process nested regions
                if hasattr(op, "regions") and hasattr(cloned_op, "regions"):
                    for orig_nested_region, cloned_nested_region in zip(op.regions, cloned_op.regions):
                        _clone_region_with_mapping(orig_nested_region, cloned_nested_region, value_mapping)

    except Exception as e:
        print(f"Warning: Could not clone region: {e}")


def process_mlir_file(input_file: str, output_file: str):
    """Process MLIR file to extract innermost loops into separate functions using xDSL."""
    try:
        # Read input file
        with open(input_file, "r") as f:
            content = f.read()

        print(f"Read {len(content)} characters from {input_file}")

        # Parse with xDSL
        ctx = Context()
        ctx.load_dialect(builtin.Builtin)
        ctx.load_dialect(func.Func)
        ctx.load_dialect(affine.Affine)
        ctx.load_dialect(arith.Arith)
        ctx.load_dialect(memref.MemRef)
        ctx.load_dialect(scf.Scf)

        parser = Parser(ctx, content)
        module = parser.parse_module()

        print(f"Successfully parsed with xDSL! Module has {len(module.ops)} operations")

        # Normalize scf.while loops before extraction
        normalize_scf_while_loops(module)

        # Process using xDSL IR
        extracted_functions = []
        for op in module.ops:
            if op.name == "func.func":
                func_name = getattr(op, "sym_name", "unknown")
                if hasattr(func_name, "data"):
                    func_name = func_name.data

                print(f"Found function: {func_name}")

                # Find innermost loops using xDSL IR traversal
                innermost_loops = find_innermost_loops(op)
                print(f"  Found {len(innermost_loops)} innermost loops")

                for i, loop in enumerate(innermost_loops):
                    print(f"    Loop {i}: {loop.name}")

                    # Create extracted function
                    extracted_func_name = f"{func_name}_inner_loop_{i}"
                    extracted_func = create_extracted_function(loop, extracted_func_name, op)
                    extracted_functions.append(extracted_func)

                    # Replace loop with function call
                    replace_loop_with_call(op, loop, extracted_func_name)

        # Add extracted functions to module
        for extracted_func in extracted_functions:
            module.body.block.add_op(extracted_func)

        # Write output using xDSL printer
        with open(output_file, "w") as f:
            printer = Printer(f)
            printer.print(module)

        print(f"Output written to {output_file} using xDSL")

    except Exception as e:
        raise Exception(f"Failed to process MLIR: {e}")


def main():
    parser = argparse.ArgumentParser(description="Extract innermost loops from MLIR functions")
    parser.add_argument("input", help="Input MLIR file")
    parser.add_argument("output", help="Output MLIR file")

    args = parser.parse_args()

    try:
        process_mlir_file(args.input, args.output)
        print(f"Successfully processed {args.input} -> {args.output}")
    except Exception as e:
        print(f"Error processing MLIR file: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
