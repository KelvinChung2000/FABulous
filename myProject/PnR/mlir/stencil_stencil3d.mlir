module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @stencil_stencil3d(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c1 = arith.constant 1 : index
    %c32 = arith.constant 32 : index
    %c0 = arith.constant 0 : index
    %c31 = arith.constant 31 : index
    %c16 = arith.constant 16 : index
    %c15 = arith.constant 15 : index
    %c-1_i32 = arith.constant -1 : i32
    %c992_i32 = arith.constant 992 : i32
    %c512_i32 = arith.constant 512 : i32
    %c15_i32 = arith.constant 15 : i32
    %c1_i32 = arith.constant 1 : i32
    %c31_i32 = arith.constant 31 : i32
    %c16_i32 = arith.constant 16 : i32
    %c32_i32 = arith.constant 32 : i32
    scf.for %arg3 = %c0 to %c32 step %c1 {
      %0 = arith.index_cast %arg3 : index to i32
      %1 = arith.muli %0, %c16_i32 : i32
      %2 = arith.addi %0, %c992_i32 : i32
      %3 = arith.muli %2, %c16_i32 : i32
      scf.for %arg4 = %c0 to %c16 step %c1 {
        %4 = arith.index_cast %arg4 : index to i32
        %5 = arith.addi %4, %1 : i32
        %6 = arith.index_cast %5 : i32 to index
        %7 = memref.load %arg1[%6] : memref<?xi32>
        memref.store %7, %arg2[%6] : memref<?xi32>
        %8 = arith.addi %4, %3 : i32
        %9 = arith.index_cast %8 : i32 to index
        %10 = memref.load %arg1[%9] : memref<?xi32>
        memref.store %10, %arg2[%9] : memref<?xi32>
      }
    }
    scf.for %arg3 = %c1 to %c31 step %c1 {
      %0 = arith.index_cast %arg3 : index to i32
      %1 = arith.muli %0, %c512_i32 : i32
      %2 = arith.muli %0, %c32_i32 : i32
      %3 = arith.addi %2, %c31_i32 : i32
      %4 = arith.muli %3, %c16_i32 : i32
      scf.for %arg4 = %c0 to %c16 step %c1 {
        %5 = arith.index_cast %arg4 : index to i32
        %6 = arith.addi %5, %1 : i32
        %7 = arith.index_cast %6 : i32 to index
        %8 = memref.load %arg1[%7] : memref<?xi32>
        memref.store %8, %arg2[%7] : memref<?xi32>
        %9 = arith.addi %5, %4 : i32
        %10 = arith.index_cast %9 : i32 to index
        %11 = memref.load %arg1[%10] : memref<?xi32>
        memref.store %11, %arg2[%10] : memref<?xi32>
      }
    }
    scf.for %arg3 = %c1 to %c31 step %c1 {
      %0 = arith.index_cast %arg3 : index to i32
      %1 = arith.muli %0, %c32_i32 : i32
      scf.for %arg4 = %c1 to %c31 step %c1 {
        %2 = arith.index_cast %arg4 : index to i32
        %3 = arith.addi %2, %1 : i32
        %4 = arith.muli %3, %c16_i32 : i32
        %5 = arith.index_cast %4 : i32 to index
        %6 = memref.load %arg1[%5] : memref<?xi32>
        memref.store %6, %arg2[%5] : memref<?xi32>
        %7 = arith.addi %4, %c15_i32 : i32
        %8 = arith.index_cast %7 : i32 to index
        %9 = memref.load %arg1[%8] : memref<?xi32>
        memref.store %9, %arg2[%8] : memref<?xi32>
      }
    }
    scf.for %arg3 = %c1 to %c31 step %c1 {
      %0 = arith.index_cast %arg3 : index to i32
      %1 = arith.muli %0, %c32_i32 : i32
      %2 = arith.addi %0, %c1_i32 : i32
      %3 = arith.muli %2, %c32_i32 : i32
      %4 = arith.addi %0, %c-1_i32 : i32
      %5 = arith.muli %4, %c32_i32 : i32
      scf.for %arg4 = %c1 to %c31 step %c1 {
        %6 = arith.index_cast %arg4 : index to i32
        %7 = arith.addi %6, %1 : i32
        %8 = arith.muli %7, %c16_i32 : i32
        %9 = arith.addi %6, %3 : i32
        %10 = arith.muli %9, %c16_i32 : i32
        %11 = arith.addi %6, %5 : i32
        %12 = arith.muli %11, %c16_i32 : i32
        %13 = arith.addi %6, %c1_i32 : i32
        %14 = arith.addi %13, %1 : i32
        %15 = arith.muli %14, %c16_i32 : i32
        %16 = arith.addi %6, %c-1_i32 : i32
        %17 = arith.addi %16, %1 : i32
        %18 = arith.muli %17, %c16_i32 : i32
        scf.for %arg5 = %c1 to %c15 step %c1 {
          %19 = arith.index_cast %arg5 : index to i32
          %20 = arith.addi %19, %8 : i32
          %21 = arith.index_cast %20 : i32 to index
          %22 = memref.load %arg1[%21] : memref<?xi32>
          %23 = arith.addi %19, %10 : i32
          %24 = arith.index_cast %23 : i32 to index
          %25 = memref.load %arg1[%24] : memref<?xi32>
          %26 = arith.addi %19, %12 : i32
          %27 = arith.index_cast %26 : i32 to index
          %28 = memref.load %arg1[%27] : memref<?xi32>
          %29 = arith.addi %25, %28 : i32
          %30 = arith.addi %19, %15 : i32
          %31 = arith.index_cast %30 : i32 to index
          %32 = memref.load %arg1[%31] : memref<?xi32>
          %33 = arith.addi %29, %32 : i32
          %34 = arith.addi %19, %18 : i32
          %35 = arith.index_cast %34 : i32 to index
          %36 = memref.load %arg1[%35] : memref<?xi32>
          %37 = arith.addi %33, %36 : i32
          %38 = arith.addi %19, %c1_i32 : i32
          %39 = arith.addi %38, %8 : i32
          %40 = arith.index_cast %39 : i32 to index
          %41 = memref.load %arg1[%40] : memref<?xi32>
          %42 = arith.addi %37, %41 : i32
          %43 = arith.addi %19, %c-1_i32 : i32
          %44 = arith.addi %43, %8 : i32
          %45 = arith.index_cast %44 : i32 to index
          %46 = memref.load %arg1[%45] : memref<?xi32>
          %47 = arith.addi %42, %46 : i32
          %48 = affine.load %arg0[0] : memref<?xi32>
          %49 = arith.muli %22, %48 : i32
          %50 = affine.load %arg0[1] : memref<?xi32>
          %51 = arith.muli %47, %50 : i32
          %52 = arith.addi %49, %51 : i32
          memref.store %52, %arg2[%21] : memref<?xi32>
        }
      }
    }
    return
  }
}
