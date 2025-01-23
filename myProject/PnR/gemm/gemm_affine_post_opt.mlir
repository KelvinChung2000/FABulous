module {
  func.func @gemm(%arg0: i32, %arg1: i32, %arg2: memref<900xi32>, %arg3: memref<900xi32>, %arg4: memref<900xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    %c1 = arith.constant 1 : index
    %c30 = arith.constant 30 : index
    %alloca = memref.alloca() : memref<900xi32>
    %0 = scf.while (%arg5 = %c0) : (index) -> index {
      %1 = arith.cmpi slt, %arg5, %c20 : index
      scf.condition(%1) %arg5 : index
    } do {
    ^bb0(%arg5: index):
      %1 = arith.addi %arg5, %c1 : index
      %2 = arith.muli %arg5, %c30 : index
      %3 = scf.while (%arg6 = %c0) : (index) -> index {
        %4 = arith.cmpi slt, %arg6, %c20 : index
        scf.condition(%4) %arg6 : index
      } do {
      ^bb0(%arg6: index):
        %4 = arith.addi %arg6, %c1 : index
        %5 = arith.addi %2, %arg6 : index
        %6 = scf.while (%arg7 = %c0) : (index) -> index {
          %7 = arith.cmpi slt, %arg7, %c20 : index
          scf.condition(%7) %arg7 : index
        } do {
        ^bb0(%arg7: index):
          %7 = arith.addi %arg7, %c1 : index
          %8 = arith.addi %2, %arg7 : index
          %9 = memref.load %arg2[%8] : memref<900xi32>
          %10 = arith.muli %arg0, %9 : i32
          %11 = arith.muli %arg7, %c30 : index
          %12 = arith.addi %11, %arg6 : index
          %13 = memref.load %arg3[%12] : memref<900xi32>
          %14 = arith.muli %10, %13 : i32
          %15 = memref.load %alloca[%5] : memref<900xi32>
          %16 = arith.addi %15, %14 : i32
          memref.store %16, %alloca[%5] : memref<900xi32>
          scf.yield %7 : index
        }
        scf.yield %4 : index
      }
      scf.yield %1 : index
    }
    return
  }
}
