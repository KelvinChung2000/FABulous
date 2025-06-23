module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @kmp_kmp(%arg0: memref<?xi8>, %arg1: memref<?xi8>, %arg2: memref<?xi32>, %arg3: memref<?xi32>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c4 = arith.constant 4 : index
    %c32411 = arith.constant 32411 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c-1_i32 = arith.constant -1 : i32
    %c4_i32 = arith.constant 4 : i32
    %c1_i32 = arith.constant 1 : i32
    %false = arith.constant false
    %c0_i32 = arith.constant 0 : i32
    affine.store %c0_i32, %arg3[0] : memref<?xi32>
    affine.store %c0_i32, %arg2[0] : memref<?xi32>
    %0 = scf.for %arg4 = %c1 to %c4 step %c1 iter_args(%arg5 = %c0_i32) -> (i32) {
      %2 = scf.while (%arg6 = %arg5) : (i32) -> i32 {
        %8 = arith.cmpi sgt, %arg6, %c0_i32 : i32
        %9:2 = scf.if %8 -> (i1, i32) {
          %10 = arith.index_cast %arg6 : i32 to index
          %11 = memref.load %arg0[%10] : memref<?xi8>
          %12 = memref.load %arg0[%arg4] : memref<?xi8>
          %13 = arith.cmpi ne, %11, %12 : i8
          %14 = scf.if %13 -> (i32) {
            %15 = memref.load %arg2[%arg4] : memref<?xi32>
            scf.yield %15 : i32
          } else {
            scf.yield %arg6 : i32
          }
          scf.yield %13, %14 : i1, i32
        } else {
          scf.yield %false, %arg6 : i1, i32
        }
        scf.condition(%9#0) %9#1 : i32
      } do {
      ^bb0(%arg6: i32):
        scf.yield %arg6 : i32
      }
      %3 = arith.index_cast %2 : i32 to index
      %4 = memref.load %arg0[%3] : memref<?xi8>
      %5 = memref.load %arg0[%arg4] : memref<?xi8>
      %6 = arith.cmpi eq, %4, %5 : i8
      %7 = scf.if %6 -> (i32) {
        %8 = arith.addi %2, %c1_i32 : i32
        scf.yield %8 : i32
      } else {
        scf.yield %2 : i32
      }
      memref.store %7, %arg2[%arg4] : memref<?xi32>
      scf.yield %7 : i32
    }
    %1 = scf.for %arg4 = %c0 to %c32411 step %c1 iter_args(%arg5 = %c0_i32) -> (i32) {
      %2 = scf.while (%arg6 = %arg5) : (i32) -> i32 {
        %10 = arith.cmpi sgt, %arg6, %c0_i32 : i32
        %11:2 = scf.if %10 -> (i1, i32) {
          %12 = arith.index_cast %arg6 : i32 to index
          %13 = memref.load %arg0[%12] : memref<?xi8>
          %14 = memref.load %arg1[%arg4] : memref<?xi8>
          %15 = arith.cmpi ne, %13, %14 : i8
          %16 = scf.if %15 -> (i32) {
            %17 = memref.load %arg2[%12] : memref<?xi32>
            scf.yield %17 : i32
          } else {
            scf.yield %arg6 : i32
          }
          scf.yield %15, %16 : i1, i32
        } else {
          scf.yield %false, %arg6 : i1, i32
        }
        scf.condition(%11#0) %11#1 : i32
      } do {
      ^bb0(%arg6: i32):
        scf.yield %arg6 : i32
      }
      %3 = arith.index_cast %2 : i32 to index
      %4 = memref.load %arg0[%3] : memref<?xi8>
      %5 = memref.load %arg1[%arg4] : memref<?xi8>
      %6 = arith.cmpi eq, %4, %5 : i8
      %7 = scf.if %6 -> (i32) {
        %10 = arith.addi %2, %c1_i32 : i32
        scf.yield %10 : i32
      } else {
        scf.yield %2 : i32
      }
      %8 = arith.cmpi sge, %7, %c4_i32 : i32
      %9 = scf.if %8 -> (i32) {
        %10 = affine.load %arg3[0] : memref<?xi32>
        %11 = arith.addi %10, %c1_i32 : i32
        affine.store %11, %arg3[0] : memref<?xi32>
        %12 = arith.addi %7, %c-1_i32 : i32
        %13 = arith.index_cast %12 : i32 to index
        %14 = memref.load %arg2[%13] : memref<?xi32>
        scf.yield %14 : i32
      } else {
        scf.yield %7 : i32
      }
      scf.yield %9 : i32
    }
    return %c0_i32 : i32
  }
  func.func @CPF(%arg0: memref<?xi8>, %arg1: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c4 = arith.constant 4 : index
    %c1 = arith.constant 1 : index
    %false = arith.constant false
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    affine.store %c0_i32, %arg1[0] : memref<?xi32>
    %0 = scf.for %arg2 = %c1 to %c4 step %c1 iter_args(%arg3 = %c0_i32) -> (i32) {
      %1 = scf.while (%arg4 = %arg3) : (i32) -> i32 {
        %7 = arith.cmpi sgt, %arg4, %c0_i32 : i32
        %8:2 = scf.if %7 -> (i1, i32) {
          %9 = arith.index_cast %arg4 : i32 to index
          %10 = memref.load %arg0[%9] : memref<?xi8>
          %11 = memref.load %arg0[%arg2] : memref<?xi8>
          %12 = arith.cmpi ne, %10, %11 : i8
          %13 = scf.if %12 -> (i32) {
            %14 = memref.load %arg1[%arg2] : memref<?xi32>
            scf.yield %14 : i32
          } else {
            scf.yield %arg4 : i32
          }
          scf.yield %12, %13 : i1, i32
        } else {
          scf.yield %false, %arg4 : i1, i32
        }
        scf.condition(%8#0) %8#1 : i32
      } do {
      ^bb0(%arg4: i32):
        scf.yield %arg4 : i32
      }
      %2 = arith.index_cast %1 : i32 to index
      %3 = memref.load %arg0[%2] : memref<?xi8>
      %4 = memref.load %arg0[%arg2] : memref<?xi8>
      %5 = arith.cmpi eq, %3, %4 : i8
      %6 = scf.if %5 -> (i32) {
        %7 = arith.addi %1, %c1_i32 : i32
        scf.yield %7 : i32
      } else {
        scf.yield %1 : i32
      }
      memref.store %6, %arg1[%arg2] : memref<?xi32>
      scf.yield %6 : i32
    }
    return
  }
}
