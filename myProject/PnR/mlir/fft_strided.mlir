module  {
  func.func @fft_strided(%arg0: memref<1024xf64>, %arg1: memref<1024xf64>, %arg2: memref<512xf64>, %arg3: memref<512xf64>)  {
    %c1_i32 = arith.constant 1 : i32
    %c1023_i32 = arith.constant 1023 : i32
    %c1024_i32 = arith.constant 1024 : i32
    %c512_i32 = arith.constant 512 : i32
    %c0_i32 = arith.constant 0 : i32
    %0:2 = scf.while (%arg4 = %c0_i32, %arg5 = %c512_i32) : (i32, i32) -> (i32, i32) {
      %1 = arith.cmpi ne, %arg5, %c0_i32 : i32
      scf.condition(%1) %arg4, %arg5 : i32, i32
    } do {
    ^bb0(%arg4: i32, %arg5: i32):
      %1 = scf.while (%arg6 = %arg5) : (i32) -> i32 {
        %4 = arith.cmpi slt, %arg6, %c1024_i32 : i32
        scf.condition(%4) %arg6 : i32
      } do {
      ^bb0(%arg6: i32):
        %4 = arith.ori %arg6, %arg5 : i32
        %5 = arith.xori %4, %arg5 : i32
        %6 = arith.index_cast %5 : i32 to index
        %7 = memref.load %arg0[%6] : memref<1024xf64>
        %8 = arith.index_cast %4 : i32 to index
        %9 = memref.load %arg0[%8] : memref<1024xf64>
        %10 = arith.addf %7, %9 : f64
        %11 = arith.subf %7, %9 : f64
        memref.store %11, %arg0[%8] : memref<1024xf64>
        memref.store %10, %arg0[%6] : memref<1024xf64>
        %12 = memref.load %arg1[%6] : memref<1024xf64>
        %13 = memref.load %arg1[%8] : memref<1024xf64>
        %14 = arith.addf %12, %13 : f64
        %15 = arith.subf %12, %13 : f64
        memref.store %15, %arg1[%8] : memref<1024xf64>
        memref.store %14, %arg1[%6] : memref<1024xf64>
        %16 = arith.shli %5, %arg4 : i32
        %17 = arith.andi %16, %c1023_i32 : i32
        %18 = arith.cmpi ne, %17, %c0_i32 : i32
        scf.if %18 {
          %20 = arith.index_cast %17 : i32 to index
          %21 = memref.load %arg2[%20] : memref<512xf64>
          %22 = memref.load %arg0[%8] : memref<1024xf64>
          %23 = arith.mulf %21, %22 : f64
          %24 = memref.load %arg3[%20] : memref<512xf64>
          %25 = memref.load %arg1[%8] : memref<1024xf64>
          %26 = arith.mulf %24, %25 : f64
          %27 = arith.subf %23, %26 : f64
          %28 = arith.mulf %21, %25 : f64
          %29 = arith.mulf %24, %22 : f64
          %30 = arith.addf %28, %29 : f64
          memref.store %30, %arg1[%8] : memref<1024xf64>
          memref.store %27, %arg0[%8] : memref<1024xf64>
        }
        %19 = arith.addi %4, %c1_i32 : i32
        scf.yield %19 : i32
      }
      %2 = arith.shrsi %arg5, %c1_i32 : i32
      %3 = arith.addi %arg4, %c1_i32 : i32
      scf.yield %3, %2 : i32, i32
    }
    return
  }
}
