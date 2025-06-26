#map = affine_map<()[s0] -> (s0)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<()[s0] -> (s0 * 2)>
#map3 = affine_map<()[s0] -> (s0 * 2 + 1)>
"builtin.module"() ({
  "func.func"() <{function_type = (memref<256x2xi64>, memref<4096xi64>, i64, memref<256xi8>, memref<10xi64>) -> (), sym_name = "bfs_queue"}> ({
  ^bb0(%arg0: memref<256x2xi64>, %arg1: memref<4096xi64>, %arg2: i64, %arg3: memref<256xi8>, %arg4: memref<10xi64>):
    %0 = "arith.constant"() <{value = true}> : () -> i1
    %1 = "arith.constant"() <{value = 256 : index}> : () -> index
    %2 = "arith.constant"() <{value = -1 : i64}> : () -> i64
    %3 = "arith.constant"() <{value = 0 : index}> : () -> index
    %4 = "arith.constant"() <{value = false}> : () -> i1
    %5 = "arith.constant"() <{value = 2 : i64}> : () -> i64
    %6 = "arith.constant"() <{value = 255 : i64}> : () -> i64
    %7 = "arith.constant"() <{value = 256 : i64}> : () -> i64
    %8 = "arith.constant"() <{value = 127 : i32}> : () -> i32
    %9 = "arith.constant"() <{value = 1 : i32}> : () -> i32
    %10 = "arith.constant"() <{value = 0 : i8}> : () -> i8
    %11 = "arith.constant"() <{value = 0 : i64}> : () -> i64
    %12 = "arith.constant"() <{value = 1 : i64}> : () -> i64
    %13 = "arith.constant"() <{value = 1 : index}> : () -> index
    %14 = "memref.alloca"() <{operandSegmentSizes = array<i32: 0, 0>}> : () -> memref<256xi64>
    %15 = "arith.index_cast"(%arg2) : (i64) -> index
    "affine.store"(%10, %arg3, %15) <{map = #map}> : (i8, memref<256xi8>, index) -> ()
    "affine.store"(%12, %arg4) <{map = #map1}> : (i64, memref<10xi64>) -> ()
    "affine.store"(%arg2, %14) <{map = #map1}> : (i64, memref<256xi64>) -> ()
    %16:3 = "scf.for"(%3, %1, %13, %11, %5, %0) ({
    ^bb0(%arg5: index, %arg6: i64, %arg7: i64, %arg8: i1):
      %17:3 = "scf.if"(%arg8) ({
        %18 = "arith.cmpi"(%arg7, %arg6) <{predicate = 4 : i64}> : (i64, i64) -> i1
        %19 = "scf.if"(%18) ({
          %59 = "arith.addi"(%arg6, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          %60 = "arith.cmpi"(%arg7, %59) <{predicate = 0 : i64}> : (i64, i64) -> i1
          "scf.yield"(%60) : (i1) -> ()
        }, {
          %56 = "arith.cmpi"(%arg7, %11) <{predicate = 0 : i64}> : (i64, i64) -> i1
          %57 = "scf.if"(%56) ({
            %58 = "arith.cmpi"(%arg6, %6) <{predicate = 0 : i64}> : (i64, i64) -> i1
            "scf.yield"(%58) : (i1) -> ()
          }, {
            "scf.yield"(%4) : (i1) -> ()
          }) : (i1) -> i1
          "scf.yield"(%57) : (i1) -> ()
        }) : (i1) -> i1
        %20 = "arith.xori"(%19, %0) : (i1, i1) -> i1
        %21:2 = "scf.if"(%19) ({
          "scf.yield"(%arg6, %arg7) : (i64, i64) -> ()
        }, {
          %22 = "arith.index_cast"(%arg6) : (i64) -> index
          %23 = "memref.load"(%14, %22) : (memref<256xi64>, index) -> i64
          %24 = "arith.addi"(%arg6, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
          %25 = "arith.remsi"(%24, %7) : (i64, i64) -> i64
          %26 = "arith.index_cast"(%23) : (i64) -> index
          %27 = "affine.apply"(%26) <{map = #map2}> : (index) -> index
          %28 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 512>, static_strides = array<i64: 1>}> : (memref<256x2xi64>) -> memref<512xi64, strided<[1]>>
          %29 = "memref.load"(%28, %27) <{nontemporal = false}> : (memref<512xi64, strided<[1]>>, index) -> i64
          %30 = "affine.apply"(%26) <{map = #map3}> : (index) -> index
          %31 = "memref.reinterpret_cast"(%arg0) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 512>, static_strides = array<i64: 1>}> : (memref<256x2xi64>) -> memref<512xi64, strided<[1]>>
          %32 = "memref.load"(%31, %30) <{nontemporal = false}> : (memref<512xi64, strided<[1]>>, index) -> i64
          %33 = "arith.index_cast"(%32) : (i64) -> index
          %34 = "arith.index_cast"(%29) : (i64) -> index
          %35 = "scf.for"(%34, %33, %13, %arg7) ({
          ^bb0(%arg9: index, %arg10: i64):
            %36 = "memref.reinterpret_cast"(%arg1) <{operandSegmentSizes = array<i32: 1, 0, 0, 0>, static_offsets = array<i64: 0>, static_sizes = array<i64: 4096>, static_strides = array<i64: 1>}> : (memref<4096xi64>) -> memref<4096xi64, strided<[1]>>
            %37 = "memref.load"(%36, %arg9) <{nontemporal = false}> : (memref<4096xi64, strided<[1]>>, index) -> i64
            %38 = "arith.index_cast"(%37) : (i64) -> index
            %39 = "memref.load"(%arg3, %38) : (memref<256xi8>, index) -> i8
            %40 = "arith.extsi"(%39) : (i8) -> i32
            %41 = "arith.cmpi"(%40, %8) <{predicate = 0 : i64}> : (i32, i32) -> i1
            %42 = "scf.if"(%41) ({
              %43 = "memref.load"(%arg3, %26) : (memref<256xi8>, index) -> i8
              %44 = "arith.extsi"(%43) : (i8) -> i32
              %45 = "arith.addi"(%44, %9) <{overflowFlags = #arith.overflow<none>}> : (i32, i32) -> i32
              %46 = "arith.trunci"(%45) : (i32) -> i8
              "memref.store"(%46, %arg3, %38) : (i8, memref<256xi8>, index) -> ()
              %47 = "arith.index_cast"(%46) : (i8) -> index
              %48 = "memref.load"(%arg4, %47) : (memref<10xi64>, index) -> i64
              %49 = "arith.addi"(%48, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
              "memref.store"(%49, %arg4, %47) : (i64, memref<10xi64>, index) -> ()
              %50 = "arith.cmpi"(%arg10, %11) <{predicate = 0 : i64}> : (i64, i64) -> i1
              %51 = "scf.if"(%50) ({
                "scf.yield"(%6) : (i64) -> ()
              }, {
                %55 = "arith.addi"(%arg10, %2) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
                "scf.yield"(%55) : (i64) -> ()
              }) : (i1) -> i64
              %52 = "arith.index_cast"(%51) : (i64) -> index
              "memref.store"(%37, %14, %52) : (i64, memref<256xi64>, index) -> ()
              %53 = "arith.addi"(%arg10, %12) <{overflowFlags = #arith.overflow<none>}> : (i64, i64) -> i64
              %54 = "arith.remsi"(%53, %7) : (i64, i64) -> i64
              "scf.yield"(%54) : (i64) -> ()
            }, {
              "scf.yield"(%arg10) : (i64) -> ()
            }) : (i1) -> i64
            "scf.yield"(%42) : (i64) -> ()
          }) : (index, index, index, i64) -> i64
          "scf.yield"(%25, %35) : (i64, i64) -> ()
        }) : (i1) -> (i64, i64)
        "scf.yield"(%21#0, %21#1, %20) : (i64, i64, i1) -> ()
      }, {
        "scf.yield"(%arg6, %arg7, %4) : (i64, i64, i1) -> ()
      }) : (i1) -> (i64, i64, i1)
      "scf.yield"(%17#0, %17#1, %17#2) : (i64, i64, i1) -> ()
    }) : (index, index, index, i64, i64, i1) -> (i64, i64, i1)
    "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

