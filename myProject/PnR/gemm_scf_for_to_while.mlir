module {
  func.func @gemm(%arg0: i32, %arg1: i32, %arg2: memref<30x30xi32>, %arg3: memref<30x30xi32>, %arg4: memref<30x30xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
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
        %4 = memref.load %arg4[%arg5, %arg6] : memref<30x30xi32>
        %5 = arith.muli %4, %arg1 : i32
        %6:2 = scf.while (%arg7 = %c0, %arg8 = %5) : (index, i32) -> (index, i32) {
          %7 = arith.cmpi slt, %arg7, %c20 : index
          scf.condition(%7) %arg7, %arg8 : index, i32
        } do {
        ^bb0(%arg7: index, %arg8: i32):
          %7 = arith.addi %arg7, %c1 : index
          %8 = memref.load %arg2[%arg5, %arg7] : memref<30x30xi32>
          %9 = arith.muli %arg0, %8 : i32
          %10 = memref.load %arg3[%arg7, %arg6] : memref<30x30xi32>
          %11 = arith.muli %9, %10 : i32
          %12 = arith.addi %arg8, %11 : i32
          scf.yield %7, %12 : index, i32
        }
        memref.store %6#1, %arg4[%arg5, %arg6] : memref<30x30xi32>
        scf.yield %3 : index
      }
      scf.yield %1 : index
    }
    return
  }
}

