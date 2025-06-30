#!/usr/bin/env python3
"""
Script to extract the innermost loop of a function and create a separate function.
Uses xDSL to parse and manipulate MLIR code.
"""

import argparse
from pathlib import Path
import subprocess
import sys
from typing import List

from xdsl.context import Context
from xdsl.dialects import affine, arith, builtin, func, memref, scf, math
from xdsl.ir import Block, Operation, Region, RegionBlocks, SSAValue
from xdsl.parser import Parser
from xdsl.printer import Printer

LoopOp = scf.WhileOp | scf.ForOp | affine.ForOp


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


def _transform_scf_while_to_guarded_loop(while_op: scf.WhileOp) -> None:
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

    # print(f"    Original while: {len(init_args)} init_args, {len(result_types)} result_types")
    # print(f"    Condition operands: {len(condition_operands)} total, {len(guard_values)} guard_values")
    # print(f"    Before block args: {len(before_block.args) if before_block.args else 0}")

    # The guard_values from scf.condition represent what gets passed to the after region
    # We need to preserve all of them, but understand that the new while loop structure
    # should match the original while loop's result structure
    if len(guard_values) != len(result_types):
        print(f"    WARNING: Guard values ({len(guard_values)}) != result types ({len(result_types)})")
        # This suggests the original while loop has a more complex structure
        # We should respect the original result_types as they define the while loop interface

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
    # The before region should accept the same number of arguments as guard_values
    pure_while_before_region = Region()
    guard_value_types = [val.type for val in guard_values]
    pure_while_before_block = Block(arg_types=guard_value_types)
    pure_while_before_region.add_block(pure_while_before_block)

    # print(f"    Pure while before block: {len(pure_while_before_block.args)} args for {len(guard_values)} guard_values")

    # Add only scf.condition to the before region - use the external guard condition
    pure_condition = scf.ConditionOp(guard_condition, *pure_while_before_block.args)
    pure_while_before_block.add_op(pure_condition)

    # Create new after region that contains the original before region computation
    # The after region should take the same number of arguments as the original after region
    # which matches the number of values yielded by scf.condition
    after_region = while_op.regions[1]
    after_block = after_region.blocks[0] if after_region.blocks else None

    if after_block and after_block.args:
        # Use the argument types from the original after region
        after_arg_types = [arg.type for arg in after_block.args]
        # print(f"    After region arg types: {len(after_arg_types)} from original after block")
    else:
        # Fallback: use the guard_values types if we can't get the original after region info
        after_arg_types = [val.type for val in guard_values]
        # print(f"    After region arg types: {len(after_arg_types)} from guard_values (fallback)")

    new_after_region = Region()
    new_after_block = Block(arg_types=after_arg_types)
    new_after_region.add_block(new_after_block)

    # Create value mapping for the new after block arguments
    after_value_mapping = {}
    # The new after block should map to the original before block args where they correspond
    # The additional arguments (if any) represent the extra values from scf.condition
    for i, block_arg in enumerate(new_after_block.args):
        if i < len(before_block.args):
            # Map the first N arguments to the original before block arguments
            after_value_mapping[before_block.args[i]] = block_arg
        # Additional arguments beyond the before block args represent new computed values

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
    # print(f"    Creating while loop: {len(guard_values)} guard_values, {len(result_types)} result_types")
    # print(
    #     f"    Before region args: {len(pure_while_before_block.args)}, After region args: {len(new_after_block.args)}"
    # )
    simple_while = scf.WhileOp(guard_values, result_types, pure_while_before_region, new_after_region)
    then_block.add_op(simple_while)

    # Add yield to then region using the while loop results
    then_yield = scf.YieldOp(*simple_while.results)
    then_block.add_op(then_yield)

    # Add yield to else region - ensure it yields the same types as then region
    # The else region should yield values of the same types as the while loop results
    if len(simple_while.results) == len(guard_values):
        else_yield = scf.YieldOp(*guard_values)
    else:
        # If lengths don't match, we need to pad or truncate to match
        print(
            f"    WARNING: While results ({len(simple_while.results)}) don't match guard values ({len(guard_values)})"
        )
        if len(guard_values) < len(simple_while.results):
            # Pad guard_values with the missing values from simple_while results
            padded_values = list(guard_values) + list(simple_while.results[len(guard_values) :])
            else_yield = scf.YieldOp(*padded_values)
        else:
            # Truncate guard_values to match
            else_yield = scf.YieldOp(*guard_values[: len(simple_while.results)])
    else_block.add_op(else_yield)

    # Create the if operation - use result types from the simple while loop
    actual_result_types = [result.type for result in simple_while.results]
    if_op = scf.IfOp(guard_condition, actual_result_types, then_region, else_region)

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

    # print("    Successfully transformed scf.while into guarded if structure")


def find_innermost_loops(op: Operation) -> List[LoopOp]:
    """Find all loops that have no nested loops inside them (leaf loops).
    After normalization, look for scf.while loops that are now nested inside scf.if operations."""
    innermost_loops = []

    # Find all loops in the operation using xDSL's walk method
    # After normalization, scf.while loops are nested inside scf.if operations
    all_loops = [loop_op for loop_op in op.walk() if isinstance(loop_op, LoopOp)]

    # For each loop, check if it contains any nested loops
    for loop_op in all_loops:
        # Use walk to find any nested loops within this loop
        nested_loops = [nested for nested in loop_op.walk() if isinstance(nested, LoopOp) and nested != loop_op]

        # If no nested loops found, this is an innermost loop
        if not nested_loops:
            innermost_loops.append(loop_op)

    return innermost_loops


def create_extracted_function(loop_op: LoopOp, func_name: str) -> func.FuncOp:
    """Create a new function containing the loop body with proper arguments and return types."""

    # Find all values used in the loop body that are defined outside the loop
    external_values = []

    # First, add loop arguments (induction variable and iter_args) as they'll be needed as function parameters
    # For transformed scf.while loops that are now scf.if, we need to handle this differently
    if loop_op.name == "scf.if":
        # For scf.if (transformed from scf.while), we don't have traditional loop arguments
        # The transformed scf.if uses the guard values from the original condition
        pass
    elif isinstance(loop_op, scf.WhileOp):
        for block in loop_op.after_region.blocks:
            for block_arg in block.args:
                external_values.append(block_arg)
    elif isinstance(loop_op, (scf.ForOp, affine.ForOp)):
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

    # print(f"    External values found: {len(external_values)}, Constants to recreate: {len(constants_to_recreate)}")

    # Find the yield operation to determine return types
    return_types = loop_op.result_types

    # Create function type
    func_type = builtin.FunctionType.from_lists(arg_types, return_types)

    # Create the new function operation (entry block is automatically created)
    new_func = func.FuncOp(func_name, func_type, visibility=None)

    # Get the automatically created entry block
    entry_block = new_func.body.blocks[0]

    # Clone the loop body operations into the new function
    _clone_loop_body_to_function(loop_op, new_func, external_values, new_func.args, constants_to_recreate)

    return new_func


def replace_loop_with_call(loop_op: LoopOp, extracted_func_name: str):
    """Replace the loop body with a function call to the extracted function."""

    # Find all external values that need to be passed as arguments (same logic as create_extracted_function)
    external_values = []

    # First, add loop arguments (induction variable and iter_args) - but when calling, pass the actual values
    loop_args_placeholders = []

    blocks: RegionBlocks
    if isinstance(loop_op, scf.WhileOp):
        blocks = loop_op.after_region.blocks  # "do" region
    elif isinstance(loop_op, (scf.ForOp, affine.ForOp)):
        blocks = loop_op.body.blocks
    else:
        raise ValueError(f"Unsupported loop operation type: {loop_op.name}")

    for block in blocks:
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
            if isinstance(loop_op, scf.WhileOp):
                loop_block = loop_op.after_region.blocks[0]  # "do" region
                actual_call_args.append(loop_block.args[loop_arg_index])
            elif isinstance(loop_op, (scf.ForOp, affine.ForOp)):
                loop_block = loop_op.body.blocks[0]
                actual_call_args.append(loop_block.args[loop_arg_index])
            loop_arg_index += 1
        else:
            actual_call_args.append(val)

    external_values = actual_call_args

    # Get return types from the loop results - these will be yielded by the function call
    yield_types = loop_op.result_types

    # Create function call operation
    call_op = func.CallOp(extracted_func_name, external_values, yield_types)

    # Replace the loop body with the function call
    # Access the loop body region based on loop type
    loop_body_blocks: RegionBlocks
    if isinstance(loop_op, scf.WhileOp):
        loop_body_blocks = loop_op.after_region.blocks
    elif isinstance(loop_op, (scf.ForOp, affine.ForOp)):
        loop_body_blocks = loop_op.body.blocks

    # Replace the body contents
    for block in loop_body_blocks:

        # Remove all operations from the block
        ops_to_remove = list(block.ops)
        for op in ops_to_remove:
            block.detach_op(op)

        # Add the function call
        block.add_op(call_op)

        if isinstance(loop_op, affine.ForOp):
            new_yield = affine.YieldOp.get(*call_op.results)
            block.add_op(new_yield)
        elif isinstance(loop_op, (scf.ForOp, scf.WhileOp)):
            new_yield = scf.YieldOp(*call_op.results)
            block.add_op(new_yield)
        else:
            raise ValueError(f"Unsupported loop operation type for yield: {loop_op.name}")

        print(f"  Replaced loop body of {loop_op.name} with call to {extracted_func_name}")

def _is_operation_within(defining_op: Operation, container_op: Operation) -> bool:
    """Check if an operation is defined within a container operation."""
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

def _clone_loop_body_to_function(
    loop_op: Operation, new_func: func.FuncOp, external_values: List[SSAValue], func_args, constants_to_recreate
):
    """Clone the loop body operations into the new function, replacing external references with function arguments."""

    # Create a mapping from external values to function arguments
    # print(f"      External values: {len(external_values)}, Function args: {len(func_args)}")
    if len(external_values) != len(func_args):
        print("      WARNING: Mismatch in external values vs function args")
        print(f"      External values: {external_values}")
        print(f"      Function args: {func_args}")
        # Take the minimum to avoid zip error
        min_len = min(len(external_values), len(func_args))
        value_mapping = dict(zip(external_values[:min_len], func_args[:min_len]))
        # Add any remaining external values as identity mapping
        for i in range(min_len, len(external_values)):
            value_mapping[external_values[i]] = external_values[i]
    else:
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

    loop_body: RegionBlocks
    if isinstance(loop_op, scf.WhileOp):
        loop_body = loop_op.after_region.blocks
    elif isinstance(loop_op, (scf.ForOp, affine.ForOp)):
        loop_body = loop_op.body.blocks


    for block in loop_body:
        for op in block.ops:
            if isinstance(op, (scf.YieldOp, affine.YieldOp)):
                # Handle yield operation - extract return values
                for operand in op.operands:
                    mapped_operand = value_mapping.get(operand, operand)
                    return_values.append(mapped_operand)
                continue
            else:
                cloned_op = _clone_operation_with_mapping(op, value_mapping)
                cloned_operations.append(cloned_op)
                new_func.body.blocks[0].add_op(cloned_op)

                for orig_result, cloned_result in zip(op.results, cloned_op.results, strict=True):
                    value_mapping[orig_result] = cloned_result

                for orig_region, cloned_region in zip(op.regions, cloned_op.regions, strict=True):
                    _clone_region_with_mapping(orig_region, cloned_region, value_mapping)

    return_op = func.ReturnOp(*return_values)
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

        # Get result types from original operation
    result_types = [result.type for result in op.results]

    # Get attributes from original operation
    attributes = op.attributes if hasattr(op, "attributes") else {}

    # Use a simpler approach - clone and replace operands directly
    new_op = op.clone()

    # Replace operands in the cloned operation
    # This works by directly modifying the operand list
    if len(new_operands) == len(new_op.operands):
        for i, new_operand in enumerate(new_operands):
            new_op.operands[i] = new_operand
    else:
        raise ValueError(
            f"Operand count mismatch for {op.name}: original={len(op.operands)}, cloned={len(new_operands)}"
        )
    return new_op

def _clone_region_with_mapping(orig_region: Region, cloned_region: Region, value_mapping: dict):
    """Recursively clone region contents with value mapping."""

    if len(orig_region.blocks) != len(cloned_region.blocks):
        print(
            f"WARNING: Block count mismatch in region: orig={len(orig_region.blocks)}, cloned={len(cloned_region.blocks)}"
        )
        raise ValueError("Region block count mismatch during cloning")

    for orig_block, cloned_block in zip(orig_region.blocks, cloned_region.blocks, strict=True):
        # Clear the cloned block and rebuild it with mapped values
        ops_to_remove = list(cloned_block.ops)
        for op in ops_to_remove:
            cloned_block.detach_op(op)

        # Clone each operation in the original block
        for op in orig_block.ops:
            cloned_op = _clone_operation_with_mapping(op, value_mapping)
            cloned_block.add_op(cloned_op)

            for orig_result, cloned_result in zip(op.results, cloned_op.results, strict=True):
                value_mapping[orig_result] = cloned_result

            for orig_nested_region, cloned_nested_region in zip(op.regions, cloned_op.regions, strict=True):
                _clone_region_with_mapping(orig_nested_region, cloned_nested_region, value_mapping)

def process_mlir_file(input_file: str, output_dir: str) -> list[Path]:
    """Process MLIR file to extract innermost loops into separate functions using xDSL."""
    import os
    
    try:
        # Create output directory if it doesn't exist
        os.makedirs(output_dir, exist_ok=True)
        
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
        ctx.load_dialect(math.Math)

        parser = Parser(ctx, content)
        module = parser.parse_module()

        print(f"Successfully parsed with xDSL! Module has {len(module.ops)} operations")

        # Normalize scf.while loops before extraction
        normalize_scf_while_loops(module)

        # Process using xDSL IR
        extracted_functions: list[tuple[func.FuncOp, str]] = []
        for op in module.ops:
            if isinstance(op, func.FuncOp):
                func_name = op.sym_name.data
                print(f"Found function: {func_name}")

                # Find innermost loops using xDSL IR traversal
                innermost_loops = find_innermost_loops(op)
                print(f"  Found {len(innermost_loops)} innermost loops")

                for i, loop in enumerate(innermost_loops):
                    # print(f"    Loop {i}:")

                    # Create extracted function
                    extracted_func_name = f"{func_name}_inner_loop_{i}"
                    extracted_func = create_extracted_function(loop, extracted_func_name)
                    extracted_functions.append((extracted_func, extracted_func_name))

                    # Replace loop with function call
                    replace_loop_with_call(loop, extracted_func_name)

        # output_file = Path(output_dir) / f"full_file/{func_name}.mlir"
        # # Add extracted functions to module
        # for extracted_func, _ in extracted_functions:
        #     module.body.block.add_op(extracted_func)
        # # Write output using xDSL printer
        # with open(output_file, "w") as f:
        #     printer = Printer(f)
        #     printer.print(module)

        out_files = []
        # Write each extracted function to a separate file
        for extracted_func, func_name in extracted_functions:
            # Create a new module containing only this function
            func_module = builtin.ModuleOp(ops=[extracted_func])
            
            # Write to separate file
            output_file = Path(output_dir) / f"{func_name}.mlir"
            tmp_output_file = output_file.with_suffix(".tmp")
            with open(tmp_output_file, "w") as f:
                printer = Printer(f)
                printer.print(func_module)

            optCmd = [
                "mlir-opt",
                str(tmp_output_file),
                "-o", str(output_file)
            ]
    
            result = subprocess.run(optCmd, capture_output=True, text=True, timeout=300)
            if result.returncode != 0:
                print(f"Error round tripping {tmp_output_file}: {result.stderr}")
                raise Exception(f"mlir-opt failed for {tmp_output_file}")

            print(f"  Extracted function written to {output_file}")
            tmp_output_file.unlink()  # Remove temporary file

            with open(output_file, "r") as f:
                content = f.read()
                content = content.replace("i64", "i32")
                content = content.replace("f64", "f32")

            with open(output_file, "w") as f:
                f.write(content)
            out_files.append(output_file)

        print(f"Total extracted functions: {len(extracted_functions)}")
        return out_files

    except Exception as e:
        import traceback

        print("Full traceback:")
        print(traceback.format_exc())
        raise Exception(f"Failed to process MLIR: {e}")


def main():
    parser = argparse.ArgumentParser(description="Extract innermost loops from MLIR functions")
    parser.add_argument("input", help="Input MLIR file")
    parser.add_argument("output_dir", help="Output directory for extracted functions")

    args = parser.parse_args()

    try:
        process_mlir_file(args.input, args.output_dir)
        print(f"Successfully processed {args.input} -> {args.output_dir}")
    except Exception as e:
        print(f"Error processing MLIR file: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
