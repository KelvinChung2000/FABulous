module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @bfs_queue(%arg0: memref<?x2xi64>, %arg1: memref<?x1xi64>, %arg2: i64, %arg3: memref<?xi8>, %arg4: memref<?xi64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %true = arith.constant true
    %c256 = arith.constant 256 : index
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
    affine.store %c0_i8, %arg3[symbol(%0)] : memref<?xi8>
    affine.store %c1_i64, %arg4[0] : memref<?xi64>
    affine.store %arg2, %alloca[0] : memref<256xi64>
    %1:3 = scf.for %arg5 = %c0 to %c256 step %c1 iter_args(%arg6 = %c0_i64, %arg7 = %c2_i64, %arg8 = %true) -> (i64, i64, i1) {
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
          %12 = memref.load %arg0[%11, %c0] : memref<?x2xi64>
          %13 = memref.load %arg0[%11, %c1] : memref<?x2xi64>
          %14 = arith.index_cast %13 : i64 to index
          %15 = arith.index_cast %12 : i64 to index
          %16 = scf.for %arg9 = %15 to %14 step %c1 iter_args(%arg10 = %arg7) -> (i64) {
            %17 = memref.load %arg1[%arg9, %c0] : memref<?x1xi64>
            %18 = arith.index_cast %17 : i64 to index
            %19 = memref.load %arg3[%18] : memref<?xi8>
            %20 = arith.extsi %19 : i8 to i32
            %21 = arith.cmpi eq, %20, %c127_i32 : i32
            %22 = scf.if %21 -> (i64) {
              %23 = memref.load %arg3[%11] : memref<?xi8>
              %24 = arith.extsi %23 : i8 to i32
              %25 = arith.addi %24, %c1_i32 : i32
              %26 = arith.trunci %25 : i32 to i8
              memref.store %26, %arg3[%18] : memref<?xi8>
              %27 = arith.index_cast %26 : i8 to index
              %28 = memref.load %arg4[%27] : memref<?xi64>
              %29 = arith.addi %28, %c1_i64 : i64
              memref.store %29, %arg4[%27] : memref<?xi64>
              %30 = arith.cmpi eq, %arg10, %c0_i64 : i64
              %31 = scf.if %30 -> (i64) {
                scf.yield %c255_i64 : i64
              } else {
                %35 = arith.addi %arg10, %c-1_i64 : i64
                scf.yield %35 : i64
              }
              %32 = arith.index_cast %31 : i64 to index
              memref.store %17, %alloca[%32] : memref<256xi64>
              %33 = arith.addi %arg10, %c1_i64 : i64
              %34 = arith.remsi %33, %c256_i64 : i64
              scf.yield %34 : i64
            } else {
              scf.yield %arg10 : i64
            }
            scf.yield %22 : i64
          }
          scf.yield %10, %16 : i64, i64
        }
        scf.yield %6#0, %6#1, %5 : i64, i64, i1
      } else {
        scf.yield %arg6, %arg7, %false : i64, i64, i1
      }
      scf.yield %2#0, %2#1, %2#2 : i64, i64, i1
    }
    return
  }
}
