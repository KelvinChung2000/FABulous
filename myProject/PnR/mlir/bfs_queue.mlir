module  {
  func.func @bfs_queue(%arg0: memref<512xi64>, %arg1: memref<4096xi64>, %arg2: i64, %arg3: memref<256xi8>, %arg4: memref<10xi64>)  {
    %true = arith.constant true
    %c-1_i64 = arith.constant -1 : i64
    %false = arith.constant false
    %c2_i64 = arith.constant 2 : i64
    %c255_i64 = arith.constant 255 : i64
    %c256_i64 = arith.constant 256 : i64
    %c127_i32 = arith.constant 127 : i32
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c1_i32 = arith.constant 1 : i32
    %c0_i8 = arith.constant 0 : i8
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
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
          %12 = arith.muli %11, %c2 : index
          %13 = memref.load %arg0[%12] : memref<512xi64>
          %14 = arith.addi %12, %c1 : index
          %15 = memref.load %arg0[%14] : memref<512xi64>
          %16 = arith.index_cast %15 : i64 to index
          %17 = arith.index_cast %13 : i64 to index
          %18 = scf.for %arg9 = %17 to %16 step %c1 iter_args(%arg10 = %arg7) -> (i64) {
            %19 = memref.load %arg1[%arg9] : memref<4096xi64>
            %20 = arith.index_cast %19 : i64 to index
            %21 = memref.load %arg3[%20] : memref<256xi8>
            %22 = arith.extsi %21 : i8 to i32
            %23 = arith.cmpi eq, %22, %c127_i32 : i32
            %24 = scf.if %23 -> (i64) {
              %25 = memref.load %arg3[%11] : memref<256xi8>
              %26 = arith.extsi %25 : i8 to i32
              %27 = arith.addi %26, %c1_i32 : i32
              %28 = arith.trunci %27 : i32 to i8
              memref.store %28, %arg3[%20] : memref<256xi8>
              %29 = arith.index_cast %28 : i8 to index
              %30 = memref.load %arg4[%29] : memref<10xi64>
              %31 = arith.addi %30, %c1_i64 : i64
              memref.store %31, %arg4[%29] : memref<10xi64>
              %32 = arith.cmpi eq, %arg10, %c0_i64 : i64
              %33 = scf.if %32 -> (i64) {
                scf.yield %c255_i64 : i64
              } else {
                %37 = arith.addi %arg10, %c-1_i64 : i64
                scf.yield %37 : i64
              }
              %34 = arith.index_cast %33 : i64 to index
              memref.store %19, %alloca[%34] : memref<256xi64>
              %35 = arith.addi %arg10, %c1_i64 : i64
              %36 = arith.remsi %35, %c256_i64 : i64
              scf.yield %36 : i64
            } else {
              scf.yield %arg10 : i64
            }
            scf.yield %24 : i64
          }
          scf.yield %10, %18 : i64, i64
        }
        scf.yield %6#0, %6#1, %5 : i64, i64, i1
      } else {
        scf.yield %arg6, %arg7, %false : i64, i64, i1
      }
      affine.yield %2#0, %2#1, %2#2 : i64, i64, i1
    }
    return
  }
}
