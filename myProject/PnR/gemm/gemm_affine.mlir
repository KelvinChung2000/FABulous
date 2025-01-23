module attributes {} {
  func.func @gemm(%arg0: i32, %arg1: i32, %arg2: memref<30x30xi32>, %arg3: memref<30x30xi32>, %arg4: memref<30x30xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %alloca = memref.alloca() : memref<30x30xi32>
    affine.for %arg5 = 0 to 20 {
      affine.for %arg6 = 0 to 20 {
        affine.for %arg7 = 0 to 20 {
          %0 = affine.load %arg2[%arg5, %arg7] : memref<30x30xi32>
          %1 = arith.muli %arg0, %0 : i32
          %2 = affine.load %arg3[%arg7, %arg6] : memref<30x30xi32>
          %3 = arith.muli %1, %2 : i32
          %4 = affine.load %alloca[%arg5, %arg6] : memref<30x30xi32>
          %5 = arith.addi %4, %3 : i32
          affine.store %5, %alloca[%arg5, %arg6] : memref<30x30xi32>
        }
      }
    }
    // affine.for %arg5 = 0 to 20 {
    //   affine.for %arg6 = 0 to 20 {
    //     %0 = affine.load %arg4[%arg5, %arg6] : memref<30x30xi32>
    //     %1 = arith.muli %0, %arg1 : i32
    //     %2 = affine.load %alloca[%arg5, %arg6] : memref<30x30xi32>
    //     %3 = arith.addi %1, %2 : i32
    //     affine.store %3, %arg4[%arg5, %arg6] : memref<30x30xi32>
    //   }
    // }
    return
  }
}
