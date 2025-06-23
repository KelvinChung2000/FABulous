module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @spmv_ellpack(%arg0: memref<?xf64>, %arg1: memref<?xi32>, %arg2: memref<?xf64>, %arg3: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c494 = arith.constant 494 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c10 = arith.constant 10 : index
    %c10_i32 = arith.constant 10 : i32
    scf.for %arg4 = %c0 to %c494 step %c1 {
      %0 = arith.index_cast %arg4 : index to i32
      %1 = memref.load %arg3[%arg4] : memref<?xf64>
      %2 = arith.muli %0, %c10_i32 : i32
      %3 = scf.for %arg5 = %c0 to %c10 step %c1 iter_args(%arg6 = %1) -> (f64) {
        %4 = arith.index_cast %arg5 : index to i32
        %5 = arith.addi %4, %2 : i32
        %6 = arith.index_cast %5 : i32 to index
        %7 = memref.load %arg0[%6] : memref<?xf64>
        %8 = memref.load %arg1[%6] : memref<?xi32>
        %9 = arith.index_cast %8 : i32 to index
        %10 = memref.load %arg2[%9] : memref<?xf64>
        %11 = arith.mulf %7, %10 : f64
        %12 = arith.addf %arg6, %11 : f64
        scf.yield %12 : f64
      }
      memref.store %3, %arg3[%arg4] : memref<?xf64>
    }
    return
  }
}
