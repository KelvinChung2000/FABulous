module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @md_knn(%arg0: memref<?xf64>, %arg1: memref<?xf64>, %arg2: memref<?xf64>, %arg3: memref<?xf64>, %arg4: memref<?xf64>, %arg5: memref<?xf64>, %arg6: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c256 = arith.constant 256 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c16 = arith.constant 16 : index
    %cst = arith.constant 2.000000e+00 : f64
    %cst_0 = arith.constant 1.500000e+00 : f64
    %cst_1 = arith.constant 1.000000e+00 : f64
    %c16_i32 = arith.constant 16 : i32
    %cst_2 = arith.constant 0.000000e+00 : f64
    scf.for %arg7 = %c0 to %c256 step %c1 {
      %0 = arith.index_cast %arg7 : index to i32
      %1 = memref.load %arg3[%arg7] : memref<?xf64>
      %2 = memref.load %arg4[%arg7] : memref<?xf64>
      %3 = memref.load %arg5[%arg7] : memref<?xf64>
      %4 = arith.muli %0, %c16_i32 : i32
      %5:3 = scf.for %arg8 = %c0 to %c16 step %c1 iter_args(%arg9 = %cst_2, %arg10 = %cst_2, %arg11 = %cst_2) -> (f64, f64, f64) {
        %6 = arith.index_cast %arg8 : index to i32
        %7 = arith.addi %4, %6 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = memref.load %arg6[%8] : memref<?xi32>
        %10 = arith.index_cast %9 : i32 to index
        %11 = memref.load %arg3[%10] : memref<?xf64>
        %12 = memref.load %arg4[%10] : memref<?xf64>
        %13 = memref.load %arg5[%10] : memref<?xf64>
        %14 = arith.subf %1, %11 : f64
        %15 = arith.subf %2, %12 : f64
        %16 = arith.subf %3, %13 : f64
        %17 = arith.mulf %14, %14 : f64
        %18 = arith.mulf %15, %15 : f64
        %19 = arith.addf %17, %18 : f64
        %20 = arith.mulf %16, %16 : f64
        %21 = arith.addf %19, %20 : f64
        %22 = arith.divf %cst_1, %21 : f64
        %23 = arith.mulf %22, %22 : f64
        %24 = arith.mulf %23, %22 : f64
        %25 = arith.mulf %24, %cst_0 : f64
        %26 = arith.subf %25, %cst : f64
        %27 = arith.mulf %24, %26 : f64
        %28 = arith.mulf %22, %27 : f64
        %29 = arith.mulf %14, %28 : f64
        %30 = arith.addf %arg11, %29 : f64
        %31 = arith.mulf %15, %28 : f64
        %32 = arith.addf %arg10, %31 : f64
        %33 = arith.mulf %16, %28 : f64
        %34 = arith.addf %arg9, %33 : f64
        scf.yield %34, %32, %30 : f64, f64, f64
      }
      memref.store %5#2, %arg0[%arg7] : memref<?xf64>
      memref.store %5#1, %arg1[%arg7] : memref<?xf64>
      memref.store %5#0, %arg2[%arg7] : memref<?xf64>
    }
    return
  }
}
