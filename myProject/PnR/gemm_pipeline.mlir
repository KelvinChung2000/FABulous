module {
  func.func @gemm(%arg0: i32, %arg1: i32, %arg2: memref<30x30xi32>, %arg3: memref<30x30xi32>, %arg4: memref<30x30xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %alloca = memref.alloca() : memref<30x30xi32>
    %c0 = arith.constant 0 : index
    %c20 = arith.constant 20 : index
    %c1 = arith.constant 1 : index
    cf.br ^bb1(%c0 : index)
  ^bb1(%0: index):  // 2 preds: ^bb0, ^bb5
    %1 = arith.cmpi slt, %0, %c20 : index
    cf.cond_br %1, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    %c0_0 = arith.constant 0 : index
    %c20_1 = arith.constant 20 : index
    %c1_2 = arith.constant 1 : index
    cf.br ^bb3(%c0_0 : index)
  ^bb3(%2: index):  // 2 preds: ^bb2, ^bb4
    %3 = arith.cmpi slt, %2, %c20_1 : index
    cf.cond_br %3, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %c0_3 = arith.constant 0 : index
    %c20_4 = arith.constant 20 : index
    %c1_5 = arith.constant 1 : index
    loopschedule.pipeline II =  2 trip_count =  20 iter_args(%arg5 = %c0_3) : (index) -> () {
      %6 = arith.cmpi ult, %arg5, %c20_4 : index
      loopschedule.register %6 : i1
    } do {
      %6:4 = loopschedule.pipeline.stage start = 0 {
        %10 = memref.load %arg2[%0, %arg5] : memref<30x30xi32>
        %11 = memref.load %arg3[%arg5, %2] : memref<30x30xi32>
        %12 = memref.load %alloca[%0, %2] : memref<30x30xi32>
        %13 = arith.addi %arg5, %c1_5 : index
        loopschedule.register %10, %11, %12, %13 : i32, i32, i32, index
      } : i32, i32, i32, index
      %7:3 = loopschedule.pipeline.stage start = 1 {
        %10 = arith.muli %arg0, %6#0 : i32
        loopschedule.register %6#1, %6#2, %10 : i32, i32, i32
      } : i32, i32, i32
      %8:2 = loopschedule.pipeline.stage start = 4 {
        %10 = arith.muli %7#2, %7#0 : i32
        loopschedule.register %7#1, %10 : i32, i32
      } : i32, i32
      %9 = loopschedule.pipeline.stage start = 7 {
        %10 = arith.addi %8#0, %8#1 : i32
        memref.store %10, %alloca[%0, %2] : memref<30x30xi32>
        loopschedule.register %10 : i32
      } : i32
      loopschedule.terminator iter_args(%6#3), results() : (index) -> ()
    }
    %4 = arith.addi %2, %c1_2 : index
    cf.br ^bb3(%4 : index)
  ^bb5:  // pred: ^bb3
    %5 = arith.addi %0, %c1 : index
    cf.br ^bb1(%5 : index)
  ^bb6:  // pred: ^bb1
    return
  }
}