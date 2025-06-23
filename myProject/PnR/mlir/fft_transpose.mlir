module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @fft_transpose(%arg0: memref<?xf64>, %arg1: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0 = arith.constant 0 : index
    %c64 = arith.constant 64 : index
    %c1 = arith.constant 1 : index
    %c462_i32 = arith.constant 462 : i32
    %c198_i32 = arith.constant 198 : i32
    %c396_i32 = arith.constant 396 : i32
    %c132_i32 = arith.constant 132 : i32
    %c330_i32 = arith.constant 330 : i32
    %c264_i32 = arith.constant 264 : i32
    %c56_i32 = arith.constant 56 : i32
    %c24_i32 = arith.constant 24 : i32
    %c48_i32 = arith.constant 48 : i32
    %c16_i32 = arith.constant 16 : i32
    %c40_i32 = arith.constant 40 : i32
    %c32_i32 = arith.constant 32 : i32
    %c504_i32 = arith.constant 504 : i32
    %c216_i32 = arith.constant 216 : i32
    %c432_i32 = arith.constant 432 : i32
    %c144_i32 = arith.constant 144 : i32
    %c360_i32 = arith.constant 360 : i32
    %c288_i32 = arith.constant 288 : i32
    %c128_i32 = arith.constant 128 : i32
    %c192_i32 = arith.constant 192 : i32
    %c256_i32 = arith.constant 256 : i32
    %c320_i32 = arith.constant 320 : i32
    %c384_i32 = arith.constant 384 : i32
    %c448_i32 = arith.constant 448 : i32
    %c72_i32 = arith.constant 72 : i32
    %c66_i32 = arith.constant 66 : i32
    %c8_i32 = arith.constant 8 : i32
    %c512_i32 = arith.constant 512 : i32
    %cst = arith.constant 0.70710678118654757 : f64
    %cst_0 = arith.constant 0.000000e+00 : f64
    %cst_1 = arith.constant -1.000000e+00 : f64
    %c64_i32 = arith.constant 64 : i32
    %c7_i32 = arith.constant 7 : i32
    %c3_i32 = arith.constant 3 : i32
    %c5_i32 = arith.constant 5 : i32
    %c1_i32 = arith.constant 1 : i32
    %c6_i32 = arith.constant 6 : i32
    %c2_i32 = arith.constant 2 : i32
    %c4_i32 = arith.constant 4 : i32
    %alloca = memref.alloca() : memref<576xf64>
    %alloca_2 = memref.alloca() : memref<8xf64>
    %alloca_3 = memref.alloca() : memref<8xf64>
    %alloca_4 = memref.alloca() : memref<512xf64>
    %alloca_5 = memref.alloca() : memref<512xf64>
    %cast = memref.cast %alloca_3 : memref<8xf64> to memref<?xf64>
    %cast_6 = memref.cast %alloca_2 : memref<8xf64> to memref<?xf64>
    scf.for %arg2 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg2 : index to i32
      %1 = memref.load %arg0[%arg2] : memref<?xf64>
      affine.store %1, %alloca_3[0] : memref<8xf64>
      %2 = arith.addi %0, %c64_i32 : i32
      %3 = arith.index_cast %2 : i32 to index
      %4 = memref.load %arg0[%3] : memref<?xf64>
      affine.store %4, %alloca_3[1] : memref<8xf64>
      %5 = arith.addi %0, %c128_i32 : i32
      %6 = arith.index_cast %5 : i32 to index
      %7 = memref.load %arg0[%6] : memref<?xf64>
      affine.store %7, %alloca_3[2] : memref<8xf64>
      %8 = arith.addi %0, %c192_i32 : i32
      %9 = arith.index_cast %8 : i32 to index
      %10 = memref.load %arg0[%9] : memref<?xf64>
      affine.store %10, %alloca_3[3] : memref<8xf64>
      %11 = arith.addi %0, %c256_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = memref.load %arg0[%12] : memref<?xf64>
      affine.store %13, %alloca_3[4] : memref<8xf64>
      %14 = arith.addi %0, %c320_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = memref.load %arg0[%15] : memref<?xf64>
      affine.store %16, %alloca_3[5] : memref<8xf64>
      %17 = arith.addi %0, %c384_i32 : i32
      %18 = arith.index_cast %17 : i32 to index
      %19 = memref.load %arg0[%18] : memref<?xf64>
      affine.store %19, %alloca_3[6] : memref<8xf64>
      %20 = arith.addi %0, %c448_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = memref.load %arg0[%21] : memref<?xf64>
      affine.store %22, %alloca_3[7] : memref<8xf64>
      %23 = memref.load %arg1[%arg2] : memref<?xf64>
      affine.store %23, %alloca_2[0] : memref<8xf64>
      %24 = memref.load %arg1[%3] : memref<?xf64>
      affine.store %24, %alloca_2[1] : memref<8xf64>
      %25 = memref.load %arg1[%6] : memref<?xf64>
      affine.store %25, %alloca_2[2] : memref<8xf64>
      %26 = memref.load %arg1[%9] : memref<?xf64>
      affine.store %26, %alloca_2[3] : memref<8xf64>
      %27 = memref.load %arg1[%12] : memref<?xf64>
      affine.store %27, %alloca_2[4] : memref<8xf64>
      %28 = memref.load %arg1[%15] : memref<?xf64>
      affine.store %28, %alloca_2[5] : memref<8xf64>
      %29 = memref.load %arg1[%18] : memref<?xf64>
      affine.store %29, %alloca_2[6] : memref<8xf64>
      %30 = memref.load %arg1[%21] : memref<?xf64>
      %31 = arith.addf %1, %13 : f64
      %32 = arith.addf %23, %27 : f64
      %33 = arith.subf %1, %13 : f64
      %34 = arith.subf %23, %27 : f64
      %35 = arith.addf %4, %16 : f64
      %36 = arith.addf %24, %28 : f64
      %37 = arith.subf %4, %16 : f64
      %38 = arith.subf %24, %28 : f64
      %39 = arith.addf %7, %19 : f64
      %40 = arith.addf %25, %29 : f64
      %41 = arith.subf %7, %19 : f64
      %42 = arith.subf %25, %29 : f64
      %43 = arith.addf %10, %22 : f64
      %44 = arith.addf %26, %30 : f64
      %45 = arith.subf %10, %22 : f64
      %46 = arith.subf %26, %30 : f64
      %47 = arith.mulf %38, %cst_1 : f64
      %48 = arith.subf %37, %47 : f64
      %49 = arith.mulf %48, %cst : f64
      %50 = arith.mulf %37, %cst_1 : f64
      %51 = arith.addf %50, %38 : f64
      %52 = arith.mulf %51, %cst : f64
      %53 = arith.mulf %41, %cst_0 : f64
      %54 = arith.mulf %42, %cst_1 : f64
      %55 = arith.subf %53, %54 : f64
      %56 = arith.mulf %41, %cst_1 : f64
      %57 = arith.mulf %42, %cst_0 : f64
      %58 = arith.addf %56, %57 : f64
      %59 = arith.mulf %45, %cst_1 : f64
      %60 = arith.mulf %46, %cst_1 : f64
      %61 = arith.subf %59, %60 : f64
      %62 = arith.mulf %61, %cst : f64
      %63 = arith.addf %59, %60 : f64
      %64 = arith.mulf %63, %cst : f64
      %65 = arith.addf %31, %39 : f64
      %66 = arith.addf %32, %40 : f64
      %67 = arith.subf %31, %39 : f64
      %68 = arith.subf %32, %40 : f64
      %69 = arith.addf %35, %43 : f64
      %70 = arith.addf %36, %44 : f64
      %71 = arith.subf %35, %43 : f64
      %72 = arith.subf %36, %44 : f64
      %73 = arith.mulf %71, %cst_0 : f64
      %74 = arith.mulf %72, %cst_1 : f64
      %75 = arith.subf %73, %74 : f64
      %76 = arith.mulf %71, %cst_1 : f64
      %77 = arith.mulf %72, %cst_0 : f64
      %78 = arith.subf %76, %77 : f64
      %79 = arith.addf %65, %69 : f64
      affine.store %79, %alloca_3[0] : memref<8xf64>
      %80 = arith.addf %66, %70 : f64
      affine.store %80, %alloca_2[0] : memref<8xf64>
      %81 = arith.subf %65, %69 : f64
      affine.store %81, %alloca_3[1] : memref<8xf64>
      %82 = arith.subf %66, %70 : f64
      affine.store %82, %alloca_2[1] : memref<8xf64>
      %83 = arith.addf %67, %75 : f64
      affine.store %83, %alloca_3[2] : memref<8xf64>
      %84 = arith.addf %68, %78 : f64
      affine.store %84, %alloca_2[2] : memref<8xf64>
      %85 = arith.subf %67, %75 : f64
      affine.store %85, %alloca_3[3] : memref<8xf64>
      %86 = arith.subf %68, %78 : f64
      affine.store %86, %alloca_2[3] : memref<8xf64>
      %87 = arith.addf %33, %55 : f64
      %88 = arith.addf %34, %58 : f64
      %89 = arith.subf %33, %55 : f64
      %90 = arith.subf %34, %58 : f64
      %91 = arith.addf %49, %62 : f64
      %92 = arith.addf %52, %64 : f64
      %93 = arith.subf %49, %62 : f64
      %94 = arith.subf %52, %64 : f64
      %95 = arith.mulf %93, %cst_0 : f64
      %96 = arith.mulf %94, %cst_1 : f64
      %97 = arith.subf %95, %96 : f64
      %98 = arith.mulf %93, %cst_1 : f64
      %99 = arith.mulf %94, %cst_0 : f64
      %100 = arith.subf %98, %99 : f64
      %101 = arith.addf %87, %91 : f64
      affine.store %101, %alloca_3[4] : memref<8xf64>
      %102 = arith.addf %88, %92 : f64
      affine.store %102, %alloca_2[4] : memref<8xf64>
      %103 = arith.subf %87, %91 : f64
      affine.store %103, %alloca_3[5] : memref<8xf64>
      %104 = arith.subf %88, %92 : f64
      affine.store %104, %alloca_2[5] : memref<8xf64>
      %105 = arith.addf %89, %97 : f64
      affine.store %105, %alloca_3[6] : memref<8xf64>
      %106 = arith.addf %90, %100 : f64
      affine.store %106, %alloca_2[6] : memref<8xf64>
      %107 = arith.subf %89, %97 : f64
      affine.store %107, %alloca_3[7] : memref<8xf64>
      %108 = arith.subf %90, %100 : f64
      affine.store %108, %alloca_2[7] : memref<8xf64>
      func.call @twiddles8(%cast, %cast_6, %0, %c512_i32) : (memref<?xf64>, memref<?xf64>, i32, i32) -> ()
      %109 = arith.muli %0, %c8_i32 : i32
      %110 = arith.index_cast %109 : i32 to index
      %111 = affine.load %alloca_3[0] : memref<8xf64>
      memref.store %111, %alloca_5[%110] : memref<512xf64>
      %112 = arith.addi %109, %c1_i32 : i32
      %113 = arith.index_cast %112 : i32 to index
      %114 = affine.load %alloca_3[1] : memref<8xf64>
      memref.store %114, %alloca_5[%113] : memref<512xf64>
      %115 = arith.addi %109, %c2_i32 : i32
      %116 = arith.index_cast %115 : i32 to index
      %117 = affine.load %alloca_3[2] : memref<8xf64>
      memref.store %117, %alloca_5[%116] : memref<512xf64>
      %118 = arith.addi %109, %c3_i32 : i32
      %119 = arith.index_cast %118 : i32 to index
      %120 = affine.load %alloca_3[3] : memref<8xf64>
      memref.store %120, %alloca_5[%119] : memref<512xf64>
      %121 = arith.addi %109, %c4_i32 : i32
      %122 = arith.index_cast %121 : i32 to index
      %123 = affine.load %alloca_3[4] : memref<8xf64>
      memref.store %123, %alloca_5[%122] : memref<512xf64>
      %124 = arith.addi %109, %c5_i32 : i32
      %125 = arith.index_cast %124 : i32 to index
      %126 = affine.load %alloca_3[5] : memref<8xf64>
      memref.store %126, %alloca_5[%125] : memref<512xf64>
      %127 = arith.addi %109, %c6_i32 : i32
      %128 = arith.index_cast %127 : i32 to index
      %129 = affine.load %alloca_3[6] : memref<8xf64>
      memref.store %129, %alloca_5[%128] : memref<512xf64>
      %130 = arith.addi %109, %c7_i32 : i32
      %131 = arith.index_cast %130 : i32 to index
      %132 = affine.load %alloca_3[7] : memref<8xf64>
      memref.store %132, %alloca_5[%131] : memref<512xf64>
      %133 = affine.load %alloca_2[0] : memref<8xf64>
      memref.store %133, %alloca_4[%110] : memref<512xf64>
      %134 = affine.load %alloca_2[1] : memref<8xf64>
      memref.store %134, %alloca_4[%113] : memref<512xf64>
      %135 = affine.load %alloca_2[2] : memref<8xf64>
      memref.store %135, %alloca_4[%116] : memref<512xf64>
      %136 = affine.load %alloca_2[3] : memref<8xf64>
      memref.store %136, %alloca_4[%119] : memref<512xf64>
      %137 = affine.load %alloca_2[4] : memref<8xf64>
      memref.store %137, %alloca_4[%122] : memref<512xf64>
      %138 = affine.load %alloca_2[5] : memref<8xf64>
      memref.store %138, %alloca_4[%125] : memref<512xf64>
      %139 = affine.load %alloca_2[6] : memref<8xf64>
      memref.store %139, %alloca_4[%128] : memref<512xf64>
      %140 = affine.load %alloca_2[7] : memref<8xf64>
      memref.store %140, %alloca_4[%131] : memref<512xf64>
    }
    scf.for %arg2 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg2 : index to i32
      %1 = arith.shrsi %0, %c3_i32 : i32
      %2 = arith.andi %0, %c7_i32 : i32
      %3 = arith.muli %1, %c8_i32 : i32
      %4 = arith.addi %3, %2 : i32
      %5 = arith.index_cast %4 : i32 to index
      %6 = arith.muli %0, %c8_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = memref.load %alloca_5[%7] : memref<512xf64>
      memref.store %8, %alloca[%5] : memref<576xf64>
      %9 = arith.addi %4, %c264_i32 : i32
      %10 = arith.index_cast %9 : i32 to index
      %11 = arith.addi %6, %c1_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = memref.load %alloca_5[%12] : memref<512xf64>
      memref.store %13, %alloca[%10] : memref<576xf64>
      %14 = arith.addi %4, %c66_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.addi %6, %c4_i32 : i32
      %17 = arith.index_cast %16 : i32 to index
      %18 = memref.load %alloca_5[%17] : memref<512xf64>
      memref.store %18, %alloca[%15] : memref<576xf64>
      %19 = arith.addi %4, %c330_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.addi %6, %c5_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = memref.load %alloca_5[%22] : memref<512xf64>
      memref.store %23, %alloca[%20] : memref<576xf64>
      %24 = arith.addi %4, %c132_i32 : i32
      %25 = arith.index_cast %24 : i32 to index
      %26 = arith.addi %6, %c2_i32 : i32
      %27 = arith.index_cast %26 : i32 to index
      %28 = memref.load %alloca_5[%27] : memref<512xf64>
      memref.store %28, %alloca[%25] : memref<576xf64>
      %29 = arith.addi %4, %c396_i32 : i32
      %30 = arith.index_cast %29 : i32 to index
      %31 = arith.addi %6, %c3_i32 : i32
      %32 = arith.index_cast %31 : i32 to index
      %33 = memref.load %alloca_5[%32] : memref<512xf64>
      memref.store %33, %alloca[%30] : memref<576xf64>
      %34 = arith.addi %4, %c198_i32 : i32
      %35 = arith.index_cast %34 : i32 to index
      %36 = arith.addi %6, %c6_i32 : i32
      %37 = arith.index_cast %36 : i32 to index
      %38 = memref.load %alloca_5[%37] : memref<512xf64>
      memref.store %38, %alloca[%35] : memref<576xf64>
      %39 = arith.addi %4, %c462_i32 : i32
      %40 = arith.index_cast %39 : i32 to index
      %41 = arith.addi %6, %c7_i32 : i32
      %42 = arith.index_cast %41 : i32 to index
      %43 = memref.load %alloca_5[%42] : memref<512xf64>
      memref.store %43, %alloca[%40] : memref<576xf64>
    }
    scf.for %arg2 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg2 : index to i32
      %1 = arith.shrsi %0, %c3_i32 : i32
      %2 = arith.andi %0, %c7_i32 : i32
      %3 = arith.muli %2, %c66_i32 : i32
      %4 = arith.addi %3, %1 : i32
      %5 = arith.muli %0, %c8_i32 : i32
      %6 = arith.index_cast %5 : i32 to index
      %7 = arith.index_cast %4 : i32 to index
      %8 = memref.load %alloca[%7] : memref<576xf64>
      memref.store %8, %alloca_5[%6] : memref<512xf64>
      %9 = arith.addi %5, %c4_i32 : i32
      %10 = arith.index_cast %9 : i32 to index
      %11 = arith.addi %4, %c32_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = memref.load %alloca[%12] : memref<576xf64>
      memref.store %13, %alloca_5[%10] : memref<512xf64>
      %14 = arith.addi %5, %c1_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.addi %4, %c8_i32 : i32
      %17 = arith.index_cast %16 : i32 to index
      %18 = memref.load %alloca[%17] : memref<576xf64>
      memref.store %18, %alloca_5[%15] : memref<512xf64>
      %19 = arith.addi %5, %c5_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.addi %4, %c40_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = memref.load %alloca[%22] : memref<576xf64>
      memref.store %23, %alloca_5[%20] : memref<512xf64>
      %24 = arith.addi %5, %c2_i32 : i32
      %25 = arith.index_cast %24 : i32 to index
      %26 = arith.addi %4, %c16_i32 : i32
      %27 = arith.index_cast %26 : i32 to index
      %28 = memref.load %alloca[%27] : memref<576xf64>
      memref.store %28, %alloca_5[%25] : memref<512xf64>
      %29 = arith.addi %5, %c6_i32 : i32
      %30 = arith.index_cast %29 : i32 to index
      %31 = arith.addi %4, %c48_i32 : i32
      %32 = arith.index_cast %31 : i32 to index
      %33 = memref.load %alloca[%32] : memref<576xf64>
      memref.store %33, %alloca_5[%30] : memref<512xf64>
      %34 = arith.addi %5, %c3_i32 : i32
      %35 = arith.index_cast %34 : i32 to index
      %36 = arith.addi %4, %c24_i32 : i32
      %37 = arith.index_cast %36 : i32 to index
      %38 = memref.load %alloca[%37] : memref<576xf64>
      memref.store %38, %alloca_5[%35] : memref<512xf64>
      %39 = arith.addi %5, %c7_i32 : i32
      %40 = arith.index_cast %39 : i32 to index
      %41 = arith.addi %4, %c56_i32 : i32
      %42 = arith.index_cast %41 : i32 to index
      %43 = memref.load %alloca[%42] : memref<576xf64>
      memref.store %43, %alloca_5[%40] : memref<512xf64>
    }
    scf.for %arg2 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg2 : index to i32
      %1 = arith.shrsi %0, %c3_i32 : i32
      %2 = arith.andi %0, %c7_i32 : i32
      %3 = arith.muli %1, %c8_i32 : i32
      %4 = arith.addi %3, %2 : i32
      %5 = arith.index_cast %4 : i32 to index
      %6 = arith.muli %0, %c8_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = memref.load %alloca_4[%7] : memref<512xf64>
      memref.store %8, %alloca[%5] : memref<576xf64>
      %9 = arith.addi %4, %c264_i32 : i32
      %10 = arith.index_cast %9 : i32 to index
      %11 = arith.addi %6, %c1_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = memref.load %alloca_4[%12] : memref<512xf64>
      memref.store %13, %alloca[%10] : memref<576xf64>
      %14 = arith.addi %4, %c66_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.addi %6, %c4_i32 : i32
      %17 = arith.index_cast %16 : i32 to index
      %18 = memref.load %alloca_4[%17] : memref<512xf64>
      memref.store %18, %alloca[%15] : memref<576xf64>
      %19 = arith.addi %4, %c330_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.addi %6, %c5_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = memref.load %alloca_4[%22] : memref<512xf64>
      memref.store %23, %alloca[%20] : memref<576xf64>
      %24 = arith.addi %4, %c132_i32 : i32
      %25 = arith.index_cast %24 : i32 to index
      %26 = arith.addi %6, %c2_i32 : i32
      %27 = arith.index_cast %26 : i32 to index
      %28 = memref.load %alloca_4[%27] : memref<512xf64>
      memref.store %28, %alloca[%25] : memref<576xf64>
      %29 = arith.addi %4, %c396_i32 : i32
      %30 = arith.index_cast %29 : i32 to index
      %31 = arith.addi %6, %c3_i32 : i32
      %32 = arith.index_cast %31 : i32 to index
      %33 = memref.load %alloca_4[%32] : memref<512xf64>
      memref.store %33, %alloca[%30] : memref<576xf64>
      %34 = arith.addi %4, %c198_i32 : i32
      %35 = arith.index_cast %34 : i32 to index
      %36 = arith.addi %6, %c6_i32 : i32
      %37 = arith.index_cast %36 : i32 to index
      %38 = memref.load %alloca_4[%37] : memref<512xf64>
      memref.store %38, %alloca[%35] : memref<576xf64>
      %39 = arith.addi %4, %c462_i32 : i32
      %40 = arith.index_cast %39 : i32 to index
      %41 = arith.addi %6, %c7_i32 : i32
      %42 = arith.index_cast %41 : i32 to index
      %43 = memref.load %alloca_4[%42] : memref<512xf64>
      memref.store %43, %alloca[%40] : memref<576xf64>
    }
    %cast_7 = memref.cast %alloca_2 : memref<8xf64> to memref<?xf64>
    %cast_8 = memref.cast %alloca : memref<576xf64> to memref<?xf64>
    scf.for %arg2 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg2 : index to i32
      %1 = arith.muli %0, %c8_i32 : i32
      %2 = arith.index_cast %1 : i32 to index
      %3 = memref.load %alloca_4[%2] : memref<512xf64>
      affine.store %3, %alloca_2[0] : memref<8xf64>
      %4 = arith.addi %1, %c1_i32 : i32
      %5 = arith.index_cast %4 : i32 to index
      %6 = memref.load %alloca_4[%5] : memref<512xf64>
      affine.store %6, %alloca_2[1] : memref<8xf64>
      %7 = arith.addi %1, %c2_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = memref.load %alloca_4[%8] : memref<512xf64>
      affine.store %9, %alloca_2[2] : memref<8xf64>
      %10 = arith.addi %1, %c3_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = memref.load %alloca_4[%11] : memref<512xf64>
      affine.store %12, %alloca_2[3] : memref<8xf64>
      %13 = arith.addi %1, %c4_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %15 = memref.load %alloca_4[%14] : memref<512xf64>
      affine.store %15, %alloca_2[4] : memref<8xf64>
      %16 = arith.addi %1, %c5_i32 : i32
      %17 = arith.index_cast %16 : i32 to index
      %18 = memref.load %alloca_4[%17] : memref<512xf64>
      affine.store %18, %alloca_2[5] : memref<8xf64>
      %19 = arith.addi %1, %c6_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = memref.load %alloca_4[%20] : memref<512xf64>
      affine.store %21, %alloca_2[6] : memref<8xf64>
      %22 = arith.addi %1, %c7_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %24 = memref.load %alloca_4[%23] : memref<512xf64>
      affine.store %24, %alloca_2[7] : memref<8xf64>
      %25 = arith.shrsi %0, %c3_i32 : i32
      %26 = arith.andi %0, %c7_i32 : i32
      %27 = arith.muli %26, %c66_i32 : i32
      %28 = arith.addi %27, %25 : i32
      func.call @loady8(%cast_7, %cast_8, %28, %c8_i32) : (memref<?xf64>, memref<?xf64>, i32, i32) -> ()
      %29 = affine.load %alloca_2[0] : memref<8xf64>
      memref.store %29, %alloca_4[%2] : memref<512xf64>
      %30 = affine.load %alloca_2[1] : memref<8xf64>
      memref.store %30, %alloca_4[%5] : memref<512xf64>
      %31 = affine.load %alloca_2[2] : memref<8xf64>
      memref.store %31, %alloca_4[%8] : memref<512xf64>
      %32 = affine.load %alloca_2[3] : memref<8xf64>
      memref.store %32, %alloca_4[%11] : memref<512xf64>
      %33 = affine.load %alloca_2[4] : memref<8xf64>
      memref.store %33, %alloca_4[%14] : memref<512xf64>
      %34 = affine.load %alloca_2[5] : memref<8xf64>
      memref.store %34, %alloca_4[%17] : memref<512xf64>
      %35 = affine.load %alloca_2[6] : memref<8xf64>
      memref.store %35, %alloca_4[%20] : memref<512xf64>
      %36 = affine.load %alloca_2[7] : memref<8xf64>
      memref.store %36, %alloca_4[%23] : memref<512xf64>
    }
    %cast_9 = memref.cast %alloca_3 : memref<8xf64> to memref<?xf64>
    %cast_10 = memref.cast %alloca_2 : memref<8xf64> to memref<?xf64>
    scf.for %arg2 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg2 : index to i32
      %1 = arith.muli %0, %c8_i32 : i32
      %2 = arith.index_cast %1 : i32 to index
      %3 = memref.load %alloca_5[%2] : memref<512xf64>
      %4 = arith.addi %1, %c1_i32 : i32
      %5 = arith.index_cast %4 : i32 to index
      %6 = memref.load %alloca_5[%5] : memref<512xf64>
      %7 = arith.addi %1, %c2_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = memref.load %alloca_5[%8] : memref<512xf64>
      %10 = arith.addi %1, %c3_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = memref.load %alloca_5[%11] : memref<512xf64>
      %13 = arith.addi %1, %c4_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %15 = memref.load %alloca_5[%14] : memref<512xf64>
      %16 = arith.addi %1, %c5_i32 : i32
      %17 = arith.index_cast %16 : i32 to index
      %18 = memref.load %alloca_5[%17] : memref<512xf64>
      %19 = arith.addi %1, %c6_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = memref.load %alloca_5[%20] : memref<512xf64>
      %22 = arith.addi %1, %c7_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %24 = memref.load %alloca_5[%23] : memref<512xf64>
      %25 = memref.load %alloca_4[%2] : memref<512xf64>
      %26 = memref.load %alloca_4[%5] : memref<512xf64>
      %27 = memref.load %alloca_4[%8] : memref<512xf64>
      %28 = memref.load %alloca_4[%11] : memref<512xf64>
      %29 = memref.load %alloca_4[%14] : memref<512xf64>
      %30 = memref.load %alloca_4[%17] : memref<512xf64>
      %31 = memref.load %alloca_4[%20] : memref<512xf64>
      %32 = memref.load %alloca_4[%23] : memref<512xf64>
      %33 = arith.addf %3, %15 : f64
      %34 = arith.addf %25, %29 : f64
      %35 = arith.subf %3, %15 : f64
      %36 = arith.subf %25, %29 : f64
      %37 = arith.addf %6, %18 : f64
      %38 = arith.addf %26, %30 : f64
      %39 = arith.subf %6, %18 : f64
      %40 = arith.subf %26, %30 : f64
      %41 = arith.addf %9, %21 : f64
      %42 = arith.addf %27, %31 : f64
      %43 = arith.subf %9, %21 : f64
      %44 = arith.subf %27, %31 : f64
      %45 = arith.addf %12, %24 : f64
      %46 = arith.addf %28, %32 : f64
      %47 = arith.subf %12, %24 : f64
      %48 = arith.subf %28, %32 : f64
      %49 = arith.mulf %40, %cst_1 : f64
      %50 = arith.subf %39, %49 : f64
      %51 = arith.mulf %50, %cst : f64
      %52 = arith.mulf %39, %cst_1 : f64
      %53 = arith.addf %52, %40 : f64
      %54 = arith.mulf %53, %cst : f64
      %55 = arith.mulf %43, %cst_0 : f64
      %56 = arith.mulf %44, %cst_1 : f64
      %57 = arith.subf %55, %56 : f64
      %58 = arith.mulf %43, %cst_1 : f64
      %59 = arith.mulf %44, %cst_0 : f64
      %60 = arith.addf %58, %59 : f64
      %61 = arith.mulf %47, %cst_1 : f64
      %62 = arith.mulf %48, %cst_1 : f64
      %63 = arith.subf %61, %62 : f64
      %64 = arith.mulf %63, %cst : f64
      %65 = arith.addf %61, %62 : f64
      %66 = arith.mulf %65, %cst : f64
      %67 = arith.addf %33, %41 : f64
      %68 = arith.addf %34, %42 : f64
      %69 = arith.subf %33, %41 : f64
      %70 = arith.subf %34, %42 : f64
      %71 = arith.addf %37, %45 : f64
      %72 = arith.addf %38, %46 : f64
      %73 = arith.subf %37, %45 : f64
      %74 = arith.subf %38, %46 : f64
      %75 = arith.mulf %73, %cst_0 : f64
      %76 = arith.mulf %74, %cst_1 : f64
      %77 = arith.subf %75, %76 : f64
      %78 = arith.mulf %73, %cst_1 : f64
      %79 = arith.mulf %74, %cst_0 : f64
      %80 = arith.subf %78, %79 : f64
      %81 = arith.addf %67, %71 : f64
      affine.store %81, %alloca_3[0] : memref<8xf64>
      %82 = arith.addf %68, %72 : f64
      affine.store %82, %alloca_2[0] : memref<8xf64>
      %83 = arith.subf %67, %71 : f64
      affine.store %83, %alloca_3[1] : memref<8xf64>
      %84 = arith.subf %68, %72 : f64
      affine.store %84, %alloca_2[1] : memref<8xf64>
      %85 = arith.addf %69, %77 : f64
      affine.store %85, %alloca_3[2] : memref<8xf64>
      %86 = arith.addf %70, %80 : f64
      affine.store %86, %alloca_2[2] : memref<8xf64>
      %87 = arith.subf %69, %77 : f64
      affine.store %87, %alloca_3[3] : memref<8xf64>
      %88 = arith.subf %70, %80 : f64
      affine.store %88, %alloca_2[3] : memref<8xf64>
      %89 = arith.addf %35, %57 : f64
      %90 = arith.addf %36, %60 : f64
      %91 = arith.subf %35, %57 : f64
      %92 = arith.subf %36, %60 : f64
      %93 = arith.addf %51, %64 : f64
      %94 = arith.addf %54, %66 : f64
      %95 = arith.subf %51, %64 : f64
      %96 = arith.subf %54, %66 : f64
      %97 = arith.mulf %95, %cst_0 : f64
      %98 = arith.mulf %96, %cst_1 : f64
      %99 = arith.subf %97, %98 : f64
      %100 = arith.mulf %95, %cst_1 : f64
      %101 = arith.mulf %96, %cst_0 : f64
      %102 = arith.subf %100, %101 : f64
      %103 = arith.addf %89, %93 : f64
      affine.store %103, %alloca_3[4] : memref<8xf64>
      %104 = arith.addf %90, %94 : f64
      affine.store %104, %alloca_2[4] : memref<8xf64>
      %105 = arith.subf %89, %93 : f64
      affine.store %105, %alloca_3[5] : memref<8xf64>
      %106 = arith.subf %90, %94 : f64
      affine.store %106, %alloca_2[5] : memref<8xf64>
      %107 = arith.addf %91, %99 : f64
      affine.store %107, %alloca_3[6] : memref<8xf64>
      %108 = arith.addf %92, %102 : f64
      affine.store %108, %alloca_2[6] : memref<8xf64>
      %109 = arith.subf %91, %99 : f64
      affine.store %109, %alloca_3[7] : memref<8xf64>
      %110 = arith.subf %92, %102 : f64
      affine.store %110, %alloca_2[7] : memref<8xf64>
      %111 = arith.shrsi %0, %c3_i32 : i32
      func.call @twiddles8(%cast_9, %cast_10, %111, %c64_i32) : (memref<?xf64>, memref<?xf64>, i32, i32) -> ()
      %112 = affine.load %alloca_3[0] : memref<8xf64>
      memref.store %112, %alloca_5[%2] : memref<512xf64>
      %113 = affine.load %alloca_3[1] : memref<8xf64>
      memref.store %113, %alloca_5[%5] : memref<512xf64>
      %114 = affine.load %alloca_3[2] : memref<8xf64>
      memref.store %114, %alloca_5[%8] : memref<512xf64>
      %115 = affine.load %alloca_3[3] : memref<8xf64>
      memref.store %115, %alloca_5[%11] : memref<512xf64>
      %116 = affine.load %alloca_3[4] : memref<8xf64>
      memref.store %116, %alloca_5[%14] : memref<512xf64>
      %117 = affine.load %alloca_3[5] : memref<8xf64>
      memref.store %117, %alloca_5[%17] : memref<512xf64>
      %118 = affine.load %alloca_3[6] : memref<8xf64>
      memref.store %118, %alloca_5[%20] : memref<512xf64>
      %119 = affine.load %alloca_3[7] : memref<8xf64>
      memref.store %119, %alloca_5[%23] : memref<512xf64>
      %120 = affine.load %alloca_2[0] : memref<8xf64>
      memref.store %120, %alloca_4[%2] : memref<512xf64>
      %121 = affine.load %alloca_2[1] : memref<8xf64>
      memref.store %121, %alloca_4[%5] : memref<512xf64>
      %122 = affine.load %alloca_2[2] : memref<8xf64>
      memref.store %122, %alloca_4[%8] : memref<512xf64>
      %123 = affine.load %alloca_2[3] : memref<8xf64>
      memref.store %123, %alloca_4[%11] : memref<512xf64>
      %124 = affine.load %alloca_2[4] : memref<8xf64>
      memref.store %124, %alloca_4[%14] : memref<512xf64>
      %125 = affine.load %alloca_2[5] : memref<8xf64>
      memref.store %125, %alloca_4[%17] : memref<512xf64>
      %126 = affine.load %alloca_2[6] : memref<8xf64>
      memref.store %126, %alloca_4[%20] : memref<512xf64>
      %127 = affine.load %alloca_2[7] : memref<8xf64>
      memref.store %127, %alloca_4[%23] : memref<512xf64>
    }
    scf.for %arg2 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg2 : index to i32
      %1 = arith.shrsi %0, %c3_i32 : i32
      %2 = arith.andi %0, %c7_i32 : i32
      %3 = arith.muli %1, %c8_i32 : i32
      %4 = arith.addi %3, %2 : i32
      %5 = arith.index_cast %4 : i32 to index
      %6 = arith.muli %0, %c8_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = memref.load %alloca_5[%7] : memref<512xf64>
      memref.store %8, %alloca[%5] : memref<576xf64>
      %9 = arith.addi %4, %c288_i32 : i32
      %10 = arith.index_cast %9 : i32 to index
      %11 = arith.addi %6, %c1_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = memref.load %alloca_5[%12] : memref<512xf64>
      memref.store %13, %alloca[%10] : memref<576xf64>
      %14 = arith.addi %4, %c72_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.addi %6, %c4_i32 : i32
      %17 = arith.index_cast %16 : i32 to index
      %18 = memref.load %alloca_5[%17] : memref<512xf64>
      memref.store %18, %alloca[%15] : memref<576xf64>
      %19 = arith.addi %4, %c360_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.addi %6, %c5_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = memref.load %alloca_5[%22] : memref<512xf64>
      memref.store %23, %alloca[%20] : memref<576xf64>
      %24 = arith.addi %4, %c144_i32 : i32
      %25 = arith.index_cast %24 : i32 to index
      %26 = arith.addi %6, %c2_i32 : i32
      %27 = arith.index_cast %26 : i32 to index
      %28 = memref.load %alloca_5[%27] : memref<512xf64>
      memref.store %28, %alloca[%25] : memref<576xf64>
      %29 = arith.addi %4, %c432_i32 : i32
      %30 = arith.index_cast %29 : i32 to index
      %31 = arith.addi %6, %c3_i32 : i32
      %32 = arith.index_cast %31 : i32 to index
      %33 = memref.load %alloca_5[%32] : memref<512xf64>
      memref.store %33, %alloca[%30] : memref<576xf64>
      %34 = arith.addi %4, %c216_i32 : i32
      %35 = arith.index_cast %34 : i32 to index
      %36 = arith.addi %6, %c6_i32 : i32
      %37 = arith.index_cast %36 : i32 to index
      %38 = memref.load %alloca_5[%37] : memref<512xf64>
      memref.store %38, %alloca[%35] : memref<576xf64>
      %39 = arith.addi %4, %c504_i32 : i32
      %40 = arith.index_cast %39 : i32 to index
      %41 = arith.addi %6, %c7_i32 : i32
      %42 = arith.index_cast %41 : i32 to index
      %43 = memref.load %alloca_5[%42] : memref<512xf64>
      memref.store %43, %alloca[%40] : memref<576xf64>
    }
    scf.for %arg2 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg2 : index to i32
      %1 = arith.shrsi %0, %c3_i32 : i32
      %2 = arith.andi %0, %c7_i32 : i32
      %3 = arith.muli %1, %c72_i32 : i32
      %4 = arith.addi %3, %2 : i32
      %5 = arith.muli %0, %c8_i32 : i32
      %6 = arith.index_cast %5 : i32 to index
      %7 = arith.index_cast %4 : i32 to index
      %8 = memref.load %alloca[%7] : memref<576xf64>
      memref.store %8, %alloca_5[%6] : memref<512xf64>
      %9 = arith.addi %5, %c4_i32 : i32
      %10 = arith.index_cast %9 : i32 to index
      %11 = arith.addi %4, %c32_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = memref.load %alloca[%12] : memref<576xf64>
      memref.store %13, %alloca_5[%10] : memref<512xf64>
      %14 = arith.addi %5, %c1_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.addi %4, %c8_i32 : i32
      %17 = arith.index_cast %16 : i32 to index
      %18 = memref.load %alloca[%17] : memref<576xf64>
      memref.store %18, %alloca_5[%15] : memref<512xf64>
      %19 = arith.addi %5, %c5_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.addi %4, %c40_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = memref.load %alloca[%22] : memref<576xf64>
      memref.store %23, %alloca_5[%20] : memref<512xf64>
      %24 = arith.addi %5, %c2_i32 : i32
      %25 = arith.index_cast %24 : i32 to index
      %26 = arith.addi %4, %c16_i32 : i32
      %27 = arith.index_cast %26 : i32 to index
      %28 = memref.load %alloca[%27] : memref<576xf64>
      memref.store %28, %alloca_5[%25] : memref<512xf64>
      %29 = arith.addi %5, %c6_i32 : i32
      %30 = arith.index_cast %29 : i32 to index
      %31 = arith.addi %4, %c48_i32 : i32
      %32 = arith.index_cast %31 : i32 to index
      %33 = memref.load %alloca[%32] : memref<576xf64>
      memref.store %33, %alloca_5[%30] : memref<512xf64>
      %34 = arith.addi %5, %c3_i32 : i32
      %35 = arith.index_cast %34 : i32 to index
      %36 = arith.addi %4, %c24_i32 : i32
      %37 = arith.index_cast %36 : i32 to index
      %38 = memref.load %alloca[%37] : memref<576xf64>
      memref.store %38, %alloca_5[%35] : memref<512xf64>
      %39 = arith.addi %5, %c7_i32 : i32
      %40 = arith.index_cast %39 : i32 to index
      %41 = arith.addi %4, %c56_i32 : i32
      %42 = arith.index_cast %41 : i32 to index
      %43 = memref.load %alloca[%42] : memref<576xf64>
      memref.store %43, %alloca_5[%40] : memref<512xf64>
    }
    scf.for %arg2 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg2 : index to i32
      %1 = arith.shrsi %0, %c3_i32 : i32
      %2 = arith.andi %0, %c7_i32 : i32
      %3 = arith.muli %1, %c8_i32 : i32
      %4 = arith.addi %3, %2 : i32
      %5 = arith.index_cast %4 : i32 to index
      %6 = arith.muli %0, %c8_i32 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = memref.load %alloca_4[%7] : memref<512xf64>
      memref.store %8, %alloca[%5] : memref<576xf64>
      %9 = arith.addi %4, %c288_i32 : i32
      %10 = arith.index_cast %9 : i32 to index
      %11 = arith.addi %6, %c1_i32 : i32
      %12 = arith.index_cast %11 : i32 to index
      %13 = memref.load %alloca_4[%12] : memref<512xf64>
      memref.store %13, %alloca[%10] : memref<576xf64>
      %14 = arith.addi %4, %c72_i32 : i32
      %15 = arith.index_cast %14 : i32 to index
      %16 = arith.addi %6, %c4_i32 : i32
      %17 = arith.index_cast %16 : i32 to index
      %18 = memref.load %alloca_4[%17] : memref<512xf64>
      memref.store %18, %alloca[%15] : memref<576xf64>
      %19 = arith.addi %4, %c360_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = arith.addi %6, %c5_i32 : i32
      %22 = arith.index_cast %21 : i32 to index
      %23 = memref.load %alloca_4[%22] : memref<512xf64>
      memref.store %23, %alloca[%20] : memref<576xf64>
      %24 = arith.addi %4, %c144_i32 : i32
      %25 = arith.index_cast %24 : i32 to index
      %26 = arith.addi %6, %c2_i32 : i32
      %27 = arith.index_cast %26 : i32 to index
      %28 = memref.load %alloca_4[%27] : memref<512xf64>
      memref.store %28, %alloca[%25] : memref<576xf64>
      %29 = arith.addi %4, %c432_i32 : i32
      %30 = arith.index_cast %29 : i32 to index
      %31 = arith.addi %6, %c3_i32 : i32
      %32 = arith.index_cast %31 : i32 to index
      %33 = memref.load %alloca_4[%32] : memref<512xf64>
      memref.store %33, %alloca[%30] : memref<576xf64>
      %34 = arith.addi %4, %c216_i32 : i32
      %35 = arith.index_cast %34 : i32 to index
      %36 = arith.addi %6, %c6_i32 : i32
      %37 = arith.index_cast %36 : i32 to index
      %38 = memref.load %alloca_4[%37] : memref<512xf64>
      memref.store %38, %alloca[%35] : memref<576xf64>
      %39 = arith.addi %4, %c504_i32 : i32
      %40 = arith.index_cast %39 : i32 to index
      %41 = arith.addi %6, %c7_i32 : i32
      %42 = arith.index_cast %41 : i32 to index
      %43 = memref.load %alloca_4[%42] : memref<512xf64>
      memref.store %43, %alloca[%40] : memref<576xf64>
    }
    %cast_11 = memref.cast %alloca_2 : memref<8xf64> to memref<?xf64>
    %cast_12 = memref.cast %alloca : memref<576xf64> to memref<?xf64>
    scf.for %arg2 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg2 : index to i32
      %1 = arith.muli %0, %c8_i32 : i32
      %2 = arith.index_cast %1 : i32 to index
      %3 = memref.load %alloca_4[%2] : memref<512xf64>
      affine.store %3, %alloca_2[0] : memref<8xf64>
      %4 = arith.addi %1, %c1_i32 : i32
      %5 = arith.index_cast %4 : i32 to index
      %6 = memref.load %alloca_4[%5] : memref<512xf64>
      affine.store %6, %alloca_2[1] : memref<8xf64>
      %7 = arith.addi %1, %c2_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = memref.load %alloca_4[%8] : memref<512xf64>
      affine.store %9, %alloca_2[2] : memref<8xf64>
      %10 = arith.addi %1, %c3_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = memref.load %alloca_4[%11] : memref<512xf64>
      affine.store %12, %alloca_2[3] : memref<8xf64>
      %13 = arith.addi %1, %c4_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %15 = memref.load %alloca_4[%14] : memref<512xf64>
      affine.store %15, %alloca_2[4] : memref<8xf64>
      %16 = arith.addi %1, %c5_i32 : i32
      %17 = arith.index_cast %16 : i32 to index
      %18 = memref.load %alloca_4[%17] : memref<512xf64>
      affine.store %18, %alloca_2[5] : memref<8xf64>
      %19 = arith.addi %1, %c6_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = memref.load %alloca_4[%20] : memref<512xf64>
      affine.store %21, %alloca_2[6] : memref<8xf64>
      %22 = arith.addi %1, %c7_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %24 = memref.load %alloca_4[%23] : memref<512xf64>
      affine.store %24, %alloca_2[7] : memref<8xf64>
      %25 = arith.shrsi %0, %c3_i32 : i32
      %26 = arith.andi %0, %c7_i32 : i32
      %27 = arith.muli %25, %c72_i32 : i32
      %28 = arith.addi %27, %26 : i32
      func.call @loady8(%cast_11, %cast_12, %28, %c8_i32) : (memref<?xf64>, memref<?xf64>, i32, i32) -> ()
      %29 = affine.load %alloca_2[0] : memref<8xf64>
      memref.store %29, %alloca_4[%2] : memref<512xf64>
      %30 = affine.load %alloca_2[1] : memref<8xf64>
      memref.store %30, %alloca_4[%5] : memref<512xf64>
      %31 = affine.load %alloca_2[2] : memref<8xf64>
      memref.store %31, %alloca_4[%8] : memref<512xf64>
      %32 = affine.load %alloca_2[3] : memref<8xf64>
      memref.store %32, %alloca_4[%11] : memref<512xf64>
      %33 = affine.load %alloca_2[4] : memref<8xf64>
      memref.store %33, %alloca_4[%14] : memref<512xf64>
      %34 = affine.load %alloca_2[5] : memref<8xf64>
      memref.store %34, %alloca_4[%17] : memref<512xf64>
      %35 = affine.load %alloca_2[6] : memref<8xf64>
      memref.store %35, %alloca_4[%20] : memref<512xf64>
      %36 = affine.load %alloca_2[7] : memref<8xf64>
      memref.store %36, %alloca_4[%23] : memref<512xf64>
    }
    scf.for %arg2 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg2 : index to i32
      %1 = arith.muli %0, %c8_i32 : i32
      %2 = arith.index_cast %1 : i32 to index
      %3 = memref.load %alloca_4[%2] : memref<512xf64>
      %4 = arith.addi %1, %c1_i32 : i32
      %5 = arith.index_cast %4 : i32 to index
      %6 = memref.load %alloca_4[%5] : memref<512xf64>
      %7 = arith.addi %1, %c2_i32 : i32
      %8 = arith.index_cast %7 : i32 to index
      %9 = memref.load %alloca_4[%8] : memref<512xf64>
      %10 = arith.addi %1, %c3_i32 : i32
      %11 = arith.index_cast %10 : i32 to index
      %12 = memref.load %alloca_4[%11] : memref<512xf64>
      %13 = arith.addi %1, %c4_i32 : i32
      %14 = arith.index_cast %13 : i32 to index
      %15 = memref.load %alloca_4[%14] : memref<512xf64>
      %16 = arith.addi %1, %c5_i32 : i32
      %17 = arith.index_cast %16 : i32 to index
      %18 = memref.load %alloca_4[%17] : memref<512xf64>
      %19 = arith.addi %1, %c6_i32 : i32
      %20 = arith.index_cast %19 : i32 to index
      %21 = memref.load %alloca_4[%20] : memref<512xf64>
      %22 = arith.addi %1, %c7_i32 : i32
      %23 = arith.index_cast %22 : i32 to index
      %24 = memref.load %alloca_4[%23] : memref<512xf64>
      %25 = memref.load %alloca_5[%2] : memref<512xf64>
      %26 = memref.load %alloca_5[%5] : memref<512xf64>
      %27 = memref.load %alloca_5[%8] : memref<512xf64>
      %28 = memref.load %alloca_5[%11] : memref<512xf64>
      %29 = memref.load %alloca_5[%14] : memref<512xf64>
      %30 = memref.load %alloca_5[%17] : memref<512xf64>
      %31 = memref.load %alloca_5[%20] : memref<512xf64>
      %32 = memref.load %alloca_5[%23] : memref<512xf64>
      %33 = arith.addf %25, %29 : f64
      %34 = arith.addf %3, %15 : f64
      %35 = arith.subf %25, %29 : f64
      %36 = arith.subf %3, %15 : f64
      %37 = arith.addf %26, %30 : f64
      %38 = arith.addf %6, %18 : f64
      %39 = arith.subf %26, %30 : f64
      %40 = arith.subf %6, %18 : f64
      %41 = arith.addf %27, %31 : f64
      %42 = arith.addf %9, %21 : f64
      %43 = arith.subf %27, %31 : f64
      %44 = arith.subf %9, %21 : f64
      %45 = arith.addf %28, %32 : f64
      %46 = arith.addf %12, %24 : f64
      %47 = arith.subf %28, %32 : f64
      %48 = arith.subf %12, %24 : f64
      %49 = arith.mulf %40, %cst_1 : f64
      %50 = arith.subf %39, %49 : f64
      %51 = arith.mulf %50, %cst : f64
      %52 = arith.mulf %39, %cst_1 : f64
      %53 = arith.addf %52, %40 : f64
      %54 = arith.mulf %53, %cst : f64
      %55 = arith.mulf %43, %cst_0 : f64
      %56 = arith.mulf %44, %cst_1 : f64
      %57 = arith.subf %55, %56 : f64
      %58 = arith.mulf %43, %cst_1 : f64
      %59 = arith.mulf %44, %cst_0 : f64
      %60 = arith.addf %58, %59 : f64
      %61 = arith.mulf %47, %cst_1 : f64
      %62 = arith.mulf %48, %cst_1 : f64
      %63 = arith.subf %61, %62 : f64
      %64 = arith.mulf %63, %cst : f64
      %65 = arith.addf %61, %62 : f64
      %66 = arith.mulf %65, %cst : f64
      %67 = arith.addf %33, %41 : f64
      %68 = arith.addf %34, %42 : f64
      %69 = arith.subf %33, %41 : f64
      %70 = arith.subf %34, %42 : f64
      %71 = arith.addf %37, %45 : f64
      %72 = arith.addf %38, %46 : f64
      %73 = arith.subf %37, %45 : f64
      %74 = arith.subf %38, %46 : f64
      %75 = arith.mulf %73, %cst_0 : f64
      %76 = arith.mulf %74, %cst_1 : f64
      %77 = arith.subf %75, %76 : f64
      %78 = arith.mulf %73, %cst_1 : f64
      %79 = arith.mulf %74, %cst_0 : f64
      %80 = arith.subf %78, %79 : f64
      %81 = arith.addf %67, %71 : f64
      affine.store %81, %alloca_3[0] : memref<8xf64>
      %82 = arith.addf %68, %72 : f64
      affine.store %82, %alloca_2[0] : memref<8xf64>
      %83 = arith.subf %67, %71 : f64
      affine.store %83, %alloca_3[1] : memref<8xf64>
      %84 = arith.subf %68, %72 : f64
      affine.store %84, %alloca_2[1] : memref<8xf64>
      %85 = arith.addf %69, %77 : f64
      affine.store %85, %alloca_3[2] : memref<8xf64>
      %86 = arith.addf %70, %80 : f64
      affine.store %86, %alloca_2[2] : memref<8xf64>
      %87 = arith.subf %69, %77 : f64
      affine.store %87, %alloca_3[3] : memref<8xf64>
      %88 = arith.subf %70, %80 : f64
      affine.store %88, %alloca_2[3] : memref<8xf64>
      %89 = arith.addf %35, %57 : f64
      %90 = arith.addf %36, %60 : f64
      %91 = arith.subf %35, %57 : f64
      %92 = arith.subf %36, %60 : f64
      %93 = arith.addf %51, %64 : f64
      %94 = arith.addf %54, %66 : f64
      %95 = arith.subf %51, %64 : f64
      %96 = arith.subf %54, %66 : f64
      %97 = arith.mulf %95, %cst_0 : f64
      %98 = arith.mulf %96, %cst_1 : f64
      %99 = arith.subf %97, %98 : f64
      %100 = arith.mulf %95, %cst_1 : f64
      %101 = arith.mulf %96, %cst_0 : f64
      %102 = arith.subf %100, %101 : f64
      %103 = arith.addf %89, %93 : f64
      affine.store %103, %alloca_3[4] : memref<8xf64>
      %104 = arith.addf %90, %94 : f64
      affine.store %104, %alloca_2[4] : memref<8xf64>
      %105 = arith.subf %89, %93 : f64
      affine.store %105, %alloca_3[5] : memref<8xf64>
      %106 = arith.subf %90, %94 : f64
      affine.store %106, %alloca_2[5] : memref<8xf64>
      %107 = arith.addf %91, %99 : f64
      affine.store %107, %alloca_3[6] : memref<8xf64>
      %108 = arith.addf %92, %102 : f64
      affine.store %108, %alloca_2[6] : memref<8xf64>
      %109 = arith.subf %91, %99 : f64
      affine.store %109, %alloca_3[7] : memref<8xf64>
      %110 = arith.subf %92, %102 : f64
      affine.store %110, %alloca_2[7] : memref<8xf64>
      memref.store %81, %arg0[%arg2] : memref<?xf64>
      %111 = arith.addi %0, %c64_i32 : i32
      %112 = arith.index_cast %111 : i32 to index
      %113 = affine.load %alloca_3[4] : memref<8xf64>
      memref.store %113, %arg0[%112] : memref<?xf64>
      %114 = arith.addi %0, %c128_i32 : i32
      %115 = arith.index_cast %114 : i32 to index
      %116 = affine.load %alloca_3[2] : memref<8xf64>
      memref.store %116, %arg0[%115] : memref<?xf64>
      %117 = arith.addi %0, %c192_i32 : i32
      %118 = arith.index_cast %117 : i32 to index
      %119 = affine.load %alloca_3[6] : memref<8xf64>
      memref.store %119, %arg0[%118] : memref<?xf64>
      %120 = arith.addi %0, %c256_i32 : i32
      %121 = arith.index_cast %120 : i32 to index
      %122 = affine.load %alloca_3[1] : memref<8xf64>
      memref.store %122, %arg0[%121] : memref<?xf64>
      %123 = arith.addi %0, %c320_i32 : i32
      %124 = arith.index_cast %123 : i32 to index
      %125 = affine.load %alloca_3[5] : memref<8xf64>
      memref.store %125, %arg0[%124] : memref<?xf64>
      %126 = arith.addi %0, %c384_i32 : i32
      %127 = arith.index_cast %126 : i32 to index
      %128 = affine.load %alloca_3[3] : memref<8xf64>
      memref.store %128, %arg0[%127] : memref<?xf64>
      %129 = arith.addi %0, %c448_i32 : i32
      %130 = arith.index_cast %129 : i32 to index
      %131 = affine.load %alloca_3[7] : memref<8xf64>
      memref.store %131, %arg0[%130] : memref<?xf64>
      %132 = affine.load %alloca_2[0] : memref<8xf64>
      memref.store %132, %arg1[%arg2] : memref<?xf64>
      %133 = affine.load %alloca_2[4] : memref<8xf64>
      memref.store %133, %arg1[%112] : memref<?xf64>
      %134 = affine.load %alloca_2[2] : memref<8xf64>
      memref.store %134, %arg1[%115] : memref<?xf64>
      %135 = affine.load %alloca_2[6] : memref<8xf64>
      memref.store %135, %arg1[%118] : memref<?xf64>
      %136 = affine.load %alloca_2[1] : memref<8xf64>
      memref.store %136, %arg1[%121] : memref<?xf64>
      %137 = affine.load %alloca_2[5] : memref<8xf64>
      memref.store %137, %arg1[%124] : memref<?xf64>
      %138 = affine.load %alloca_2[3] : memref<8xf64>
      memref.store %138, %arg1[%127] : memref<?xf64>
      %139 = affine.load %alloca_2[7] : memref<8xf64>
      memref.store %139, %arg1[%130] : memref<?xf64>
    }
    return
  }
  func.func @twiddles8(%arg0: memref<?xf64>, %arg1: memref<?xf64>, %arg2: i32, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c8 = arith.constant 8 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant -6.2831853070000001 : f64
    %c7_i32 = arith.constant 7 : i32
    %c3_i32 = arith.constant 3 : i32
    %c5_i32 = arith.constant 5 : i32
    %c1_i32 = arith.constant 1 : i32
    %c6_i32 = arith.constant 6 : i32
    %c2_i32 = arith.constant 2 : i32
    %c4_i32 = arith.constant 4 : i32
    %c0_i32 = arith.constant 0 : i32
    %alloca = memref.alloca() : memref<8xi32>
    affine.store %c0_i32, %alloca[0] : memref<8xi32>
    affine.store %c4_i32, %alloca[1] : memref<8xi32>
    affine.store %c2_i32, %alloca[2] : memref<8xi32>
    affine.store %c6_i32, %alloca[3] : memref<8xi32>
    affine.store %c1_i32, %alloca[4] : memref<8xi32>
    affine.store %c5_i32, %alloca[5] : memref<8xi32>
    affine.store %c3_i32, %alloca[6] : memref<8xi32>
    affine.store %c7_i32, %alloca[7] : memref<8xi32>
    %0 = arith.sitofp %arg3 : i32 to f64
    %1 = arith.sitofp %arg2 : i32 to f64
    scf.for %arg4 = %c1 to %c8 step %c1 {
      %2 = memref.load %alloca[%arg4] : memref<8xi32>
      %3 = arith.sitofp %2 : i32 to f64
      %4 = arith.mulf %3, %cst : f64
      %5 = arith.divf %4, %0 : f64
      %6 = arith.mulf %5, %1 : f64
      %7 = math.cos %6 : f64
      %8 = math.sin %6 : f64
      %9 = memref.load %arg0[%arg4] : memref<?xf64>
      %10 = arith.mulf %9, %7 : f64
      %11 = memref.load %arg1[%arg4] : memref<?xf64>
      %12 = arith.mulf %11, %8 : f64
      %13 = arith.subf %10, %12 : f64
      memref.store %13, %arg0[%arg4] : memref<?xf64>
      %14 = arith.mulf %9, %8 : f64
      %15 = memref.load %arg1[%arg4] : memref<?xf64>
      %16 = arith.mulf %15, %7 : f64
      %17 = arith.addf %14, %16 : f64
      memref.store %17, %arg1[%arg4] : memref<?xf64>
    }
    return
  }
  func.func @loady8(%arg0: memref<?xf64>, %arg1: memref<?xf64>, %arg2: i32, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c7_i32 = arith.constant 7 : i32
    %c6_i32 = arith.constant 6 : i32
    %c5_i32 = arith.constant 5 : i32
    %c4_i32 = arith.constant 4 : i32
    %c3_i32 = arith.constant 3 : i32
    %c2_i32 = arith.constant 2 : i32
    %0 = arith.index_cast %arg2 : i32 to index
    %1 = affine.load %arg1[symbol(%0)] : memref<?xf64>
    affine.store %1, %arg0[0] : memref<?xf64>
    %2 = arith.addi %arg3, %arg2 : i32
    %3 = arith.index_cast %2 : i32 to index
    %4 = affine.load %arg1[symbol(%3)] : memref<?xf64>
    affine.store %4, %arg0[1] : memref<?xf64>
    %5 = arith.muli %arg3, %c2_i32 : i32
    %6 = arith.addi %5, %arg2 : i32
    %7 = arith.index_cast %6 : i32 to index
    %8 = affine.load %arg1[symbol(%7)] : memref<?xf64>
    affine.store %8, %arg0[2] : memref<?xf64>
    %9 = arith.muli %arg3, %c3_i32 : i32
    %10 = arith.addi %9, %arg2 : i32
    %11 = arith.index_cast %10 : i32 to index
    %12 = affine.load %arg1[symbol(%11)] : memref<?xf64>
    affine.store %12, %arg0[3] : memref<?xf64>
    %13 = arith.muli %arg3, %c4_i32 : i32
    %14 = arith.addi %13, %arg2 : i32
    %15 = arith.index_cast %14 : i32 to index
    %16 = affine.load %arg1[symbol(%15)] : memref<?xf64>
    affine.store %16, %arg0[4] : memref<?xf64>
    %17 = arith.muli %arg3, %c5_i32 : i32
    %18 = arith.addi %17, %arg2 : i32
    %19 = arith.index_cast %18 : i32 to index
    %20 = affine.load %arg1[symbol(%19)] : memref<?xf64>
    affine.store %20, %arg0[5] : memref<?xf64>
    %21 = arith.muli %arg3, %c6_i32 : i32
    %22 = arith.addi %21, %arg2 : i32
    %23 = arith.index_cast %22 : i32 to index
    %24 = affine.load %arg1[symbol(%23)] : memref<?xf64>
    affine.store %24, %arg0[6] : memref<?xf64>
    %25 = arith.muli %arg3, %c7_i32 : i32
    %26 = arith.addi %25, %arg2 : i32
    %27 = arith.index_cast %26 : i32 to index
    %28 = affine.load %arg1[symbol(%27)] : memref<?xf64>
    affine.store %28, %arg0[7] : memref<?xf64>
    return
  }
}
