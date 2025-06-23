#map = affine_map<()[s0] -> (s0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (256)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<256x2xi64>, memref<4096x1xi64>, i64, memref<256xi8>, memref<10xi64>) -> (), sym_name = "bfs_queue"}> ({
  ^bb0(%arg0: memref<256x2xi64>, %arg1: memref<4096x1xi64>, %arg2: i64, %arg3: memref<256xi8>, %arg4: memref<10xi64>):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %2 = "arith.constant"() <{value = 0 : index}> : () -> index
    %3 = "arith.constant"() <{value = false}> : () -> i1
    %4 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %5 = "arith.constant"() <{value = 255 : i64}> : () -> i64
    %6 = "arith.constant"() <{value = 256 : i64}> : () -> i64
    %7 = "arith.constant"() <{value = 127 : i32}> : () -> i32
    %8 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %10 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %11 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %12 = "arith.constant"() <{value = 1 : index}> : () -> index
    %13 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<256xi64>
    %14 = "arith.index_cast"(%arg2) : (i64) -> index
    "affine.store"(%9, %arg3, %14) <{map = #map}> : (i8, memref<256xi8>, index) -> ()
    "affine.store"(%11, %arg4) <{map = #map1}> : (i64, memref<10xi64>) -> ()
    "affine.store"(%arg2, %13) <{map = #map1}> : (i64, memref<256xi64>) -> ()
    %15:3 = "affine.for"(%10, %4, %0) <{lowerBoundMap = #map1, operandSegmentSizes = array<i32: 0, 0, 3>, step = 1 : index, upperBoundMap = #map2}> ({
    ^bb0(%arg5: index, %arg6: i64, %arg7: i64, %arg8: i1):
      %16:3 = "scf.if"(%arg8) ({
        %17 = "arith.cmpi"(%arg7, %arg6) <{predicate = 4 : i64}> : (i64, i64) -> i1
        %18 = "scf.if"(%17) ({
          %53 = "arith.addi"(%arg6, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          %54 = "arith.cmpi"(%arg7, %53) <{predicate = 0 : i64}> : (i64, i64) -> i1
          "scf.yield"(%54) : (i1) -> ()
        }, {
          %50 = "arith.cmpi"(%arg7, %10) <{predicate = 0 : i64}> : (i64, i64) -> i1
          %51 = "scf.if"(%50) ({
            %52 = "arith.cmpi"(%arg6, %5) <{predicate = 0 : i64}> : (i64, i64) -> i1
            "scf.yield"(%52) : (i1) -> ()
          }, {
            "scf.yield"(%3) : (i1) -> ()
          }) : (i1) -> i1
          "scf.yield"(%51) : (i1) -> ()
        }) : (i1) -> i1
        %19 = "arith.xori"(%18, %0) : (i1, i1) -> i1
        %20:2 = "scf.if"(%18) ({
          "scf.yield"(%arg6, %arg7) : (i64, i64) -> ()
        }, {
          %21 = "arith.index_cast"(%arg6) : (i64) -> index
          %22 = "memref.load"(%13, %21) : (memref<256xi64>, index) -> i64
          %23 = "arith.addi"(%arg6, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          %24 = "arith.remsi"(%23, %6) : (i64, i64) -> i64
          %25 = "arith.index_cast"(%22) : (i64) -> index
          %26 = "memref.load"(%arg0, %25, %2) : (memref<256x2xi64>, index, index) -> i64
          %27 = "memref.load"(%arg0, %25, %12) : (memref<256x2xi64>, index, index) -> i64
          %28 = "arith.index_cast"(%27) : (i64) -> index
          %29 = "arith.index_cast"(%26) : (i64) -> index
          %30 = "scf.for"(%29, %28, %12, %arg7) ({
          ^bb0(%arg9: index, %arg10: i64):
            %31 = "memref.load"(%arg1, %arg9, %2) : (memref<4096x1xi64>, index, index) -> i64
            %32 = "arith.index_cast"(%31) : (i64) -> index
            %33 = "memref.load"(%arg3, %32) : (memref<256xi8>, index) -> i8
            %34 = "arith.extsi"(%33) : (i8) -> i32
            %35 = "arith.cmpi"(%34, %7) <{predicate = 0 : i64}> : (i32, i32) -> i1
            %36 = "scf.if"(%35) ({
              %37 = "memref.load"(%arg3, %25) : (memref<256xi8>, index) -> i8
              %38 = "arith.extsi"(%37) : (i8) -> i32
              %39 = "arith.addi"(%38, %8) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
              %40 = "arith.trunci"(%39) : (i32) -> i8
              "memref.store"(%40, %arg3, %32) : (i8, memref<256xi8>, index) -> ()
              %41 = "arith.index_cast"(%40) : (i8) -> index
              %42 = "memref.load"(%arg4, %41) : (memref<10xi64>, index) -> i64
              %43 = "arith.addi"(%42, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
              "memref.store"(%43, %arg4, %41) : (i64, memref<10xi64>, index) -> ()
              %44 = "arith.cmpi"(%arg10, %10) <{predicate = 0 : i64}> : (i64, i64) -> i1
              %45 = "scf.if"(%44) ({
                "scf.yield"(%5) : (i64) -> ()
              }, {
                %49 = "arith.addi"(%arg10, %1) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
                "scf.yield"(%49) : (i64) -> ()
              }) : (i1) -> i64
              %46 = "arith.index_cast"(%45) : (i64) -> index
              "memref.store"(%31, %13, %46) : (i64, memref<256xi64>, index) -> ()
              %47 = "arith.addi"(%arg10, %11) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
              %48 = "arith.remsi"(%47, %6) : (i64, i64) -> i64
              "scf.yield"(%48) : (i64) -> ()
            }, {
              "scf.yield"(%arg10) : (i64) -> ()
            }) : (i1) -> i64
            "scf.yield"(%36) : (i64) -> ()
          }) : (index, index, index, i64) -> i64
          "scf.yield"(%24, %30) : (i64, i64) -> ()
        }) : (i1) -> (i64, i64)
        "scf.yield"(%20#0, %20#1, %19) : (i64, i64, i1) -> ()
      }, {
        "scf.yield"(%arg6, %arg7, %3) : (i64, i64, i1) -> ()
      }) : (i1) -> (i64, i64, i1)
      "affine.yield"(%16#0, %16#1, %16#2) : (i64, i64, i1) -> ()
    }) : (i64, i64, i1) -> (i64, i64, i1)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

