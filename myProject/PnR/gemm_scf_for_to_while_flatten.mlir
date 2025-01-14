module {
  func.func @gemm(%arg0: i32, %arg1: i32, %arg2: memref<900xi32>, %arg3: memref<900xi32>, %arg4: memref<900xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    %c1 = arith.constant 1 : index
    %0 = scf.while (%arg5 = %c0) : (index) -> index {
      %1 = arith.cmpi slt, %arg5, %c20 : index
      scf.condition(%1) %arg5 : index
    } do {
    ^bb0(%arg5: index):
      %1 = arith.addi %arg5, %c1 : index
      %2 = scf.while (%arg6 = %c0) : (index) -> index {
        %3 = arith.cmpi slt, %arg6, %c20 : index
        scf.condition(%3) %arg6 : index
      } do {
      ^bb0(%arg6: index):
        %3 = arith.addi %arg6, %c1 : index
        %c30 = arith.constant 30 : index
        %4 = arith.muli %arg5, %c30 : index
        %5 = arith.addi %4, %arg6 : index
        %6 = memref.load %arg4[%5] : memref<900xi32>
        %7 = arith.muli %6, %arg1 : i32
        %8:2 = scf.while (%arg7 = %c0, %arg8 = %7) : (index, i32) -> (index, i32) {
          %11 = arith.cmpi slt, %arg7, %c20 : index
          scf.condition(%11) %arg7, %arg8 : index, i32
        } do {
        ^bb0(%arg7: index, %arg8: i32):
          %11 = arith.addi %arg7, %c1 : index
          %c30_1 = arith.constant 30 : index
          %12 = arith.muli %arg5, %c30_1 : index
          %13 = arith.addi %12, %arg7 : index
          %14 = memref.load %arg2[%13] : memref<900xi32>
          %15 = arith.muli %arg0, %14 : i32
          %c30_2 = arith.constant 30 : index
          %16 = arith.muli %arg7, %c30_2 : index
          %17 = arith.addi %16, %arg6 : index
          %18 = memref.load %arg3[%17] : memref<900xi32>
          %19 = arith.muli %15, %18 : i32
          %20 = arith.addi %arg8, %19 : i32
          scf.yield %11, %20 : index, i32
        }
        %c30_0 = arith.constant 30 : index
        %9 = arith.muli %arg5, %c30_0 : index
        %10 = arith.addi %9, %arg6 : index
        memref.store %8#1, %arg4[%10] : memref<900xi32>
        scf.yield %3 : index
      }
      scf.yield %1 : index
    }
    return
  }
}

