module {
  func.func @bfs_queue(%arg0: memref<256x2xi64>, %arg1: memref<4096x1xi64>, %arg2: i64, %arg3: memref<256xi8>, %arg4: memref<10xi64>) {
    %true = arith.constant true
    %c-1_i64 = arith.constant -1 : i64
    %c0 = arith.constant 0 : index
    %false = arith.constant false
    %c2_i64 = arith.constant 2 : i64
    %c255_i64 = arith.constant 255 : i64
    %c256_i64 = arith.constant 256 : i64
    %c127_i32 = arith.constant 127 : i32
    %c1_i32 = arith.constant 1 : i32
    %c0_i8 = arith.constant 0 : i8
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c1 = arith.constant 1 : index
    %alloca = memref.alloca() : memref<256xi64>
    %0 = arith.index_cast %arg2 : i64 to index
    affine.store %c0_i8, %arg3[symbol(%0)] : memref<256xi8>
    affine.store %c1_i64, %arg4[0] : memref<10xi64>
    affine.store %arg2, %alloca[0] : memref<256xi64>
    %1:3 = affine.for %arg5 = 0 to 256 iter_args(%arg6 = %c0_i64, %arg7 = %c2_i64, %arg8 = %true) -> (i64, i64, i1) {
      %2:3 = scf.if %arg8 -> (i64, i64, i1) {
        %3 = arith.cmpi sgt, %arg7, %arg6 : i64
        %4 = scf.if %3 -> (i1) {
          %7 = arith.addi %arg6, %c1_i64 : i64
          %8 = arith.cmpi eq, %arg7, %7 : i64
          scf.yield %8 : i1
        } else {
          %7 = arith.cmpi eq, %arg7, %c0_i64 : i64
          %8 = scf.if %7 -> (i1) {
            %9 = arith.cmpi eq, %arg6, %c255_i64 : i64
            scf.yield %9 : i1
          } else {
            scf.yield %false : i1
          }
          scf.yield %8 : i1
        }
        %5 = arith.xori %4, %true : i1
        %6:2 = scf.if %4 -> (i64, i64) {
          scf.yield %arg6, %arg7 : i64, i64
        } else {
          %7 = arith.index_cast %arg6 : i64 to index
          %8 = memref.load %alloca[%7] : memref<256xi64>
          %9 = arith.addi %arg6, %c1_i64 : i64
          %10 = arith.remsi %9, %c256_i64 : i64
          %11 = arith.index_cast %8 : i64 to index
          %12 = memref.load %arg0[%11, %c0] : memref<256x2xi64>
          %13 = memref.load %arg0[%11, %c1] : memref<256x2xi64>
          %14 = arith.index_cast %13 : i64 to index
          %15 = arith.index_cast %12 : i64 to index
          %16 = scf.for %arg9 = %15 to %14 step %c1 iter_args(%arg10 = %arg7) -> (i64) {
            %17 = func.call @bfs_queue_inner_loop_0(%arg9, %arg10, %arg1, %arg3, %11, %arg4, %alloca) : (index, i64, memref<4096x1xi64>, memref<256xi8>, index, memref<10xi64>, memref<256xi64>) -> i64
            scf.yield %17 : i64
          }
          scf.yield %10, %16 : i64, i64
        }
        scf.yield %6#0, %6#1, %5 : i64, i64, i1
      } else {
        scf.yield %arg6, %arg7, %false : i64, i64, i1
      }
      affine.yield %2#0, %2#1, %2#2 : i64, i64, i1
    }
    return
  }
  func.func @bfs_queue_inner_loop_0(%arg0: index, %arg1: i64, %arg2: memref<4096x1xi64>, %arg3: memref<256xi8>, %arg4: index, %arg5: memref<10xi64>, %arg6: memref<256xi64>) -> i64 {
    %c0 = arith.constant 0 : index
    %c127_i32 = arith.constant 127 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1_i64 = arith.constant 1 : i64
    %c0_i64 = arith.constant 0 : i64
    %c255_i64 = arith.constant 255 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c256_i64 = arith.constant 256 : i64
    %0 = memref.load %arg2[%arg0, %c0] : memref<4096x1xi64>
    %1 = arith.index_cast %0 : i64 to index
    %2 = memref.load %arg3[%1] : memref<256xi8>
    %3 = arith.extsi %2 : i8 to i32
    %4 = arith.cmpi eq, %3, %c127_i32 : i32
    %5 = scf.if %4 -> (i64) {
      %6 = memref.load %arg3[%arg4] : memref<256xi8>
      %7 = arith.extsi %6 : i8 to i32
      %8 = arith.addi %7, %c1_i32 : i32
      %9 = arith.trunci %8 : i32 to i8
      memref.store %9, %arg3[%1] : memref<256xi8>
      %10 = arith.index_cast %9 : i8 to index
      %11 = memref.load %arg5[%10] : memref<10xi64>
      %12 = arith.addi %11, %c1_i64 : i64
      memref.store %12, %arg5[%10] : memref<10xi64>
      %13 = arith.cmpi eq, %arg1, %c0_i64 : i64
      %14 = scf.if %13 -> (i64) {
        scf.yield %c255_i64 : i64
      } else {
        %18 = arith.addi %arg1, %c-1_i64 : i64
        scf.yield %18 : i64
      }
      %15 = arith.index_cast %14 : i64 to index
      memref.store %0, %arg6[%15] : memref<256xi64>
      %16 = arith.addi %arg1, %c1_i64 : i64
      %17 = arith.remsi %16, %c256_i64 : i64
      scf.yield %17 : i64
    } else {
      scf.yield %arg1 : i64
    }
    return %5 : i64
  }
}

