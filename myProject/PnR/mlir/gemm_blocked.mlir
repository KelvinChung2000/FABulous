module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @gemm_blocked(%arg0: memref<?xf64>, %arg1: memref<?xf64>, %arg2: memref<?xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c64 = arith.constant 64 : index
    %c0 = arith.constant 0 : index
    %c8 = arith.constant 8 : index
    %c1 = arith.constant 1 : index
    %c64_i32 = arith.constant 64 : i32
    scf.for %arg3 = %c0 to %c64 step %c8 {
      %0 = arith.index_cast %arg3 : index to i32
      scf.for %arg4 = %c0 to %c64 step %c8 {
        %1 = arith.index_cast %arg4 : index to i32
        scf.for %arg5 = %c0 to %c64 step %c1 {
          %2 = arith.index_cast %arg5 : index to i32
          %3 = arith.muli %2, %c64_i32 : i32
          scf.for %arg6 = %c0 to %c8 step %c1 {
            %4 = arith.index_cast %arg6 : index to i32
            %5 = arith.addi %4, %1 : i32
            %6 = arith.muli %5, %c64_i32 : i32
            %7 = arith.addi %3, %4 : i32
            %8 = arith.addi %7, %1 : i32
            %9 = arith.index_cast %8 : i32 to index
            %10 = memref.load %arg0[%9] : memref<?xf64>
            scf.for %arg7 = %c0 to %c8 step %c1 {
              %11 = arith.index_cast %arg7 : index to i32
              %12 = arith.addi %6, %11 : i32
              %13 = arith.addi %12, %0 : i32
              %14 = arith.index_cast %13 : i32 to index
              %15 = memref.load %arg1[%14] : memref<?xf64>
              %16 = arith.mulf %10, %15 : f64
              %17 = arith.addi %3, %11 : i32
              %18 = arith.addi %17, %0 : i32
              %19 = arith.index_cast %18 : i32 to index
              %20 = memref.load %arg2[%19] : memref<?xf64>
              %21 = arith.addf %20, %16 : f64
              memref.store %21, %arg2[%19] : memref<?xf64>
            }
          }
        }
      }
    }
    return
  }
}
