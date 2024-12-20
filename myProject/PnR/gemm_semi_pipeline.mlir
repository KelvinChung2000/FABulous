module {
  func.func @gemm(%arg0: i32, %arg1: i32, %arg2: memref<30x30xi32>, %arg3: memref<30x30xi32>, %arg4: memref<30x30xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %alloca = memref.alloca() : memref<30x30xi32>
    affine.for %arg5 = 0 to 20 {
      affine.for %arg6 = 0 to 20 {
        %c0 = arith.constant 0 : index
        %c20 = arith.constant 20 : index
        %c1 = arith.constant 1 : index
        loopschedule.pipeline II =  2 trip_count =  20 iter_args(%arg7 = %c0) : (index) -> () {
          %0 = arith.cmpi ult, %arg7, %c20 : index
          loopschedule.register %0 : i1
        } do {
          %0:4 = loopschedule.pipeline.stage start = 0 {
            %3 = memref.load %arg2[%arg5, %arg7] : memref<30x30xi32>
            %4 = memref.load %arg3[%arg7, %arg6] : memref<30x30xi32>
            %5 = memref.load %alloca[%arg5, %arg6] : memref<30x30xi32>
            %6 = arith.addi %arg7, %c1 : index
            loopschedule.register %3, %4, %5, %6 : i32, i32, i32, index
          } : i32, i32, i32, index
          %1:3 = loopschedule.pipeline.stage start = 1 {
            %3 = arith.muli %arg0, %0#0 : i32
            loopschedule.register %0#1, %0#2, %3 : i32, i32, i32
          } : i32, i32, i32
          %2:2 = loopschedule.pipeline.stage start = 4 {
            %3 = arith.muli %1#2, %1#0 : i32
            loopschedule.register %1#1, %3 : i32, i32
          } : i32, i32
          loopschedule.terminator iter_args(%0#3), results() : (index) -> ()
        }
      }
    }
    return
  }
}

