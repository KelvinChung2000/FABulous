module {
  func.func @gemm(%arg0: i32, %arg1: i32, %arg2: memref<30x30xi32>, %arg3: memref<30x30xi32>, %arg4: memref<30x30xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    %c1 = arith.constant 1 : index
    scf.for %arg5 = %c0 to %c20 step %c1 {
      %c0_0 = arith.constant 0 : index
      %c20_1 = arith.constant 20 : index
      %c1_2 = arith.constant 1 : index
      scf.for %arg6 = %c0_0 to %c20_1 step %c1_2 {
        %0 = memref.load %arg4[%arg5, %arg6] : memref<30x30xi32>
        %1 = arith.muli %0, %arg1 : i32
        %c0_3 = arith.constant 0 : index
        %c20_4 = arith.constant 20 : index
        %c1_5 = arith.constant 1 : index
        %2 = scf.for %arg7 = %c0_3 to %c20_4 step %c1_5 iter_args(%arg8 = %1) -> (i32) {
          %3 = memref.load %arg2[%arg5, %arg7] : memref<30x30xi32>
          %4 = arith.muli %arg0, %3 : i32
          %5 = memref.load %arg3[%arg7, %arg6] : memref<30x30xi32>
          %6 = arith.muli %4, %5 : i32
          %7 = arith.addi %arg8, %6 : i32
          scf.yield %7 : i32
        }
        memref.store %2, %arg4[%arg5, %arg6] : memref<30x30xi32>
      }
    }
    return
  }
}

