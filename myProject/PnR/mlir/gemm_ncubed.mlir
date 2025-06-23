module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @gemm_ncubed(%arg0: memref<?xf64>, %arg1: memref<?xf64>, %arg2: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c64 = arith.constant 64 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f64
    %c64_i32 = arith.constant 64 : i32
    scf.for %arg3 = %c0 to %c64 step %c1 {
      %0 = arith.index_cast %arg3 : index to i32
      %1 = arith.muli %0, %c64_i32 : i32
      scf.for %arg4 = %c0 to %c64 step %c1 {
        %2 = arith.index_cast %arg4 : index to i32
        %3 = scf.for %arg5 = %c0 to %c64 step %c1 iter_args(%arg6 = %cst) -> (f64) {
          %6 = arith.index_cast %arg5 : index to i32
          %7 = arith.muli %6, %c64_i32 : i32
          %8 = arith.addi %1, %6 : i32
          %9 = arith.index_cast %8 : i32 to index
          %10 = memref.load %arg0[%9] : memref<?xf64>
          %11 = arith.addi %7, %2 : i32
          %12 = arith.index_cast %11 : i32 to index
          %13 = memref.load %arg1[%12] : memref<?xf64>
          %14 = arith.mulf %10, %13 : f64
          %15 = arith.addf %arg6, %14 : f64
          scf.yield %15 : f64
        }
        %4 = arith.addi %1, %2 : i32
        %5 = arith.index_cast %4 : i32 to index
        memref.store %3, %arg2[%5] : memref<?xf64>
      }
    }
    return
  }
}
