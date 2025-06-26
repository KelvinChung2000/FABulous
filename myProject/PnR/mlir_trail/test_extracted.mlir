#map = affine_map<()[s0] -> (s0 * 2)>
#map1 = affine_map<()[s0] -> (s0 * 2 + 1)>
module {
  func.func @bfs_queue_inner_loop_0(%arg0: index, %arg1: i64, %arg2: memref<4096xi64>, %arg3: memref<256xi8>, %arg4: index, %arg5: memref<10xi64>, %arg6: memref<256xi64>) -> i64 {
    %c127_i32 = arith.constant 127 : i32
    %c1_i32 = arith.constant 1 : i32
    %c1_i64 = arith.constant 1 : i64
    %c0_i64 = arith.constant 0 : i64
    %c255_i64 = arith.constant 255 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c256_i64 = arith.constant 256 : i64
    %0 = memref.load %arg2[%arg0] : memref<4096xi64>
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

