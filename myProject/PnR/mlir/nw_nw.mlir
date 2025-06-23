module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @nw_nw(%arg0: memref<?xi8>, %arg1: memref<?xi8>, %arg2: memref<?xi8>, %arg3: memref<?xi8>, %arg4: memref<?xi32>, %arg5: memref<?xi8>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c129 = arith.constant 129 : index
    %c256 = arith.constant 256 : index
    %true = arith.constant true
    %c95_i8 = arith.constant 95 : i8
    %c45_i8 = arith.constant 45 : i8
    %c60_i32 = arith.constant 60 : i32
    %c92_i32 = arith.constant 92 : i32
    %c128_i32 = arith.constant 128 : i32
    %c92_i8 = arith.constant 92 : i8
    %c94_i8 = arith.constant 94 : i8
    %c60_i8 = arith.constant 60 : i8
    %c1_i32 = arith.constant 1 : i32
    %c-1_i32 = arith.constant -1 : i32
    %c129_i32 = arith.constant 129 : i32
    %c0_i32 = arith.constant 0 : i32
    scf.for %arg6 = %c0 to %c129 step %c1 {
      %3 = arith.index_cast %arg6 : index to i32
      %4 = arith.muli %3, %c-1_i32 : i32
      memref.store %4, %arg4[%arg6] : memref<?xi32>
    }
    scf.for %arg6 = %c0 to %c129 step %c1 {
      %3 = arith.index_cast %arg6 : index to i32
      %4 = arith.muli %3, %c129_i32 : i32
      %5 = arith.index_cast %4 : i32 to index
      %6 = arith.muli %3, %c-1_i32 : i32
      memref.store %6, %arg4[%5] : memref<?xi32>
    }
    scf.for %arg6 = %c1 to %c129 step %c1 {
      %3 = arith.index_cast %arg6 : index to i32
      %4 = arith.addi %3, %c-1_i32 : i32
      %5 = arith.index_cast %4 : i32 to index
      %6 = arith.muli %4, %c129_i32 : i32
      %7 = arith.muli %3, %c129_i32 : i32
      scf.for %arg7 = %c1 to %c129 step %c1 {
        %8 = arith.index_cast %arg7 : index to i32
        %9 = arith.addi %8, %c-1_i32 : i32
        %10 = arith.index_cast %9 : i32 to index
        %11 = memref.load %arg0[%10] : memref<?xi8>
        %12 = memref.load %arg1[%5] : memref<?xi8>
        %13 = arith.cmpi eq, %11, %12 : i8
        %14 = arith.select %13, %c1_i32, %c-1_i32 : i32
        %15 = arith.addi %6, %9 : i32
        %16 = arith.index_cast %15 : i32 to index
        %17 = memref.load %arg4[%16] : memref<?xi32>
        %18 = arith.addi %17, %14 : i32
        %19 = arith.addi %6, %8 : i32
        %20 = arith.index_cast %19 : i32 to index
        %21 = memref.load %arg4[%20] : memref<?xi32>
        %22 = arith.addi %21, %c-1_i32 : i32
        %23 = arith.addi %7, %9 : i32
        %24 = arith.index_cast %23 : i32 to index
        %25 = memref.load %arg4[%24] : memref<?xi32>
        %26 = arith.addi %25, %c-1_i32 : i32
        %27 = arith.cmpi sgt, %22, %26 : i32
        %28 = arith.select %27, %22, %26 : i32
        %29 = arith.cmpi sgt, %18, %28 : i32
        %30 = arith.select %29, %18, %28 : i32
        %31 = arith.addi %7, %8 : i32
        %32 = arith.index_cast %31 : i32 to index
        memref.store %30, %arg4[%32] : memref<?xi32>
        %33 = arith.cmpi eq, %30, %26 : i32
        scf.if %33 {
          memref.store %c60_i8, %arg5[%32] : memref<?xi8>
        } else {
          %34 = arith.cmpi eq, %30, %22 : i32
          scf.if %34 {
            memref.store %c94_i8, %arg5[%32] : memref<?xi8>
          } else {
            memref.store %c92_i8, %arg5[%32] : memref<?xi8>
          }
        }
      }
    }
    %0:5 = scf.while (%arg6 = %c0_i32, %arg7 = %c0_i32, %arg8 = %c128_i32, %arg9 = %c128_i32) : (i32, i32, i32, i32) -> (i32, i32, i32, i32, i32) {
      %3 = arith.cmpi sgt, %arg9, %c0_i32 : i32
      %4 = scf.if %3 -> (i1) {
        scf.yield %true : i1
      } else {
        %6 = arith.cmpi sgt, %arg8, %c0_i32 : i32
        scf.yield %6 : i1
      }
      %5:5 = scf.if %4 -> (i32, i32, i32, i32, i32) {
        %6 = arith.muli %arg8, %c129_i32 : i32
        %7 = arith.addi %6, %arg9 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = memref.load %arg5[%8] : memref<?xi8>
        %10 = arith.extsi %9 : i8 to i32
        %11 = arith.cmpi eq, %10, %c92_i32 : i32
        %12:4 = scf.if %11 -> (i32, i32, i32, i32) {
          %14 = arith.addi %arg7, %c1_i32 : i32
          %15 = arith.index_cast %arg7 : i32 to index
          %16 = arith.addi %arg9, %c-1_i32 : i32
          %17 = arith.index_cast %16 : i32 to index
          %18 = memref.load %arg0[%17] : memref<?xi8>
          memref.store %18, %arg2[%15] : memref<?xi8>
          %19 = arith.addi %arg6, %c1_i32 : i32
          %20 = arith.index_cast %arg6 : i32 to index
          %21 = arith.addi %arg8, %c-1_i32 : i32
          %22 = arith.index_cast %21 : i32 to index
          %23 = memref.load %arg1[%22] : memref<?xi8>
          memref.store %23, %arg3[%20] : memref<?xi8>
          scf.yield %19, %14, %21, %16 : i32, i32, i32, i32
        } else {
          %14 = memref.load %arg5[%8] : memref<?xi8>
          %15 = arith.extsi %14 : i8 to i32
          %16 = arith.cmpi eq, %15, %c60_i32 : i32
          %17:4 = scf.if %16 -> (i32, i32, i32, i32) {
            %18 = arith.addi %arg7, %c1_i32 : i32
            %19 = arith.index_cast %arg7 : i32 to index
            %20 = arith.addi %arg9, %c-1_i32 : i32
            %21 = arith.index_cast %20 : i32 to index
            %22 = memref.load %arg0[%21] : memref<?xi8>
            memref.store %22, %arg2[%19] : memref<?xi8>
            %23 = arith.addi %arg6, %c1_i32 : i32
            %24 = arith.index_cast %arg6 : i32 to index
            memref.store %c45_i8, %arg3[%24] : memref<?xi8>
            scf.yield %23, %18, %arg8, %20 : i32, i32, i32, i32
          } else {
            %18 = arith.addi %arg7, %c1_i32 : i32
            %19 = arith.index_cast %arg7 : i32 to index
            memref.store %c45_i8, %arg2[%19] : memref<?xi8>
            %20 = arith.addi %arg6, %c1_i32 : i32
            %21 = arith.index_cast %arg6 : i32 to index
            %22 = arith.addi %arg8, %c-1_i32 : i32
            %23 = arith.index_cast %22 : i32 to index
            %24 = memref.load %arg1[%23] : memref<?xi8>
            memref.store %24, %arg3[%21] : memref<?xi8>
            scf.yield %20, %18, %22, %arg9 : i32, i32, i32, i32
          }
          scf.yield %17#0, %17#1, %17#2, %17#3 : i32, i32, i32, i32
        }
        %13 = llvm.mlir.undef : i32
        scf.yield %12#0, %12#1, %12#2, %12#3, %13 : i32, i32, i32, i32, i32
      } else {
        scf.yield %arg6, %arg7, %arg8, %arg9, %arg7 : i32, i32, i32, i32, i32
      }
      scf.condition(%4) %5#0, %5#1, %5#2, %5#3, %5#4 : i32, i32, i32, i32, i32
    } do {
    ^bb0(%arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32):
      scf.yield %arg6, %arg7, %arg8, %arg9 : i32, i32, i32, i32
    }
    %1 = arith.index_cast %0#4 : i32 to index
    scf.for %arg6 = %1 to %c256 step %c1 {
      memref.store %c95_i8, %arg2[%arg6] : memref<?xi8>
    }
    %2 = arith.index_cast %0#0 : i32 to index
    scf.for %arg6 = %2 to %c256 step %c1 {
      memref.store %c95_i8, %arg3[%arg6] : memref<?xi8>
    }
    return
  }
}
