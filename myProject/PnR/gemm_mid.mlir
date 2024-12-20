#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (20)>
"builtin.module"() ({
  "func.func"() <{function_type = (i32, i32, memref<30x30xi32>, memref<30x30xi32>, memref<30x30xi32>) -> (), sym_name = "gemm"}> ({
  ^bb0(%arg0: i32, %arg1: i32, %arg2: memref<30x30xi32>, %arg3: memref<30x30xi32>, %arg4: memref<30x30xi32>):
    %0 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<30x30xi32>
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg7: index):
      "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg8: index):
        "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
        ^bb0(%arg9: index):
          %5 = "affine.load"(%arg2, %arg7, %arg9) <{map = #map}> : (memref<30x30xi32>, index, index) -> i32
          %6 = "arith.muli"(%arg0, %5) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          %7 = "affine.load"(%arg3, %arg9, %arg8) <{map = #map}> : (memref<30x30xi32>, index, index) -> i32
          %8 = "arith.muli"(%6, %7) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          %9 = "affine.load"(%0, %arg7, %arg8) <{map = #map}> : (memref<30x30xi32>, index, index) -> i32
          %10 = "arith.addi"(%9, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
          "affine.store"(%10, %0, %arg7, %arg8) <{map = #map}> : (i32, memref<30x30xi32>, index, index) -> ()
          "affine.yield"() : () -> ()
        }) : () -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg5: index):
      "affine.for"() <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 0>, step = 1 : index, upperBoundMap = #map2}> ({
      ^bb0(%arg6: index):
        %1 = "affine.load"(%arg4, %arg5, %arg6) <{map = #map}> : (memref<30x30xi32>, index, index) -> i32
        %2 = "arith.muli"(%1, %arg1) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        %3 = "affine.load"(%0, %arg5, %arg6) <{map = #map}> : (memref<30x30xi32>, index, index) -> i32
        %4 = "arith.addi"(%2, %3) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
        "affine.store"(%4, %arg4, %arg5, %arg6) <{map = #map}> : (i32, memref<30x30xi32>, index, index) -> ()
        "affine.yield"() : () -> ()
      }) : () -> ()
      "affine.yield"() : () -> ()
    }) : () -> ()
    "func.return"() : () -> ()
  }) {llvm.linkage = #llvm.linkage<external>} : () -> ()
}) : () -> ()