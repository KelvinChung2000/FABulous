; ModuleID = 'stencil/stencil3d/stencil_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.bench_args_t = type { [2 x i32], [16384 x i32], [16384 x i32] }
%struct.stat = type { i64, i64, i32, i32, i32, i32, i64, i64, i64, i32, i32, i64, %struct.timespec, %struct.timespec, %struct.timespec, [2 x i32] }
%struct.timespec = type { i64, i64 }

@.str.1 = private unnamed_addr constant [34 x i8] c"fd>1 && \22Invalid file descriptor\22\00", align 1, !dbg !0
@.str.2 = private unnamed_addr constant [23 x i8] c"../../common/support.c\00", align 1, !dbg !7
@__PRETTY_FUNCTION__.readfile = private unnamed_addr constant [20 x i8] c"char *readfile(int)\00", align 1, !dbg !12
@.str.4 = private unnamed_addr constant [51 x i8] c"0==fstat(fd, &s) && \22Couldn't determine file size\22\00", align 1, !dbg !18
@.str.6 = private unnamed_addr constant [25 x i8] c"len>0 && \22File is empty\22\00", align 1, !dbg !23
@.str.8 = private unnamed_addr constant [29 x i8] c"status>=0 && \22read() failed\22\00", align 1, !dbg !28
@.str.10 = private unnamed_addr constant [33 x i8] c"n>=0 && \22Invalid section number\22\00", align 1, !dbg !33
@__PRETTY_FUNCTION__.find_section_start = private unnamed_addr constant [38 x i8] c"char *find_section_start(char *, int)\00", align 1, !dbg !38
@.str.12 = private unnamed_addr constant [34 x i8] c"s!=NULL && \22Invalid input string\22\00", align 1, !dbg !43
@__PRETTY_FUNCTION__.parse_string = private unnamed_addr constant [38 x i8] c"int parse_string(char *, char *, int)\00", align 1, !dbg !45
@__PRETTY_FUNCTION__.parse_uint8_t_array = private unnamed_addr constant [48 x i8] c"int parse_uint8_t_array(char *, uint8_t *, int)\00", align 1, !dbg !47
@.str.13 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1, !dbg !52
@.str.14 = private unnamed_addr constant [35 x i8] c"Invalid input: line %d of section\0A\00", align 1, !dbg !57
@__PRETTY_FUNCTION__.parse_uint16_t_array = private unnamed_addr constant [50 x i8] c"int parse_uint16_t_array(char *, uint16_t *, int)\00", align 1, !dbg !62
@__PRETTY_FUNCTION__.parse_uint32_t_array = private unnamed_addr constant [50 x i8] c"int parse_uint32_t_array(char *, uint32_t *, int)\00", align 1, !dbg !67
@__PRETTY_FUNCTION__.parse_uint64_t_array = private unnamed_addr constant [50 x i8] c"int parse_uint64_t_array(char *, uint64_t *, int)\00", align 1, !dbg !69
@__PRETTY_FUNCTION__.parse_int8_t_array = private unnamed_addr constant [46 x i8] c"int parse_int8_t_array(char *, int8_t *, int)\00", align 1, !dbg !71
@__PRETTY_FUNCTION__.parse_int16_t_array = private unnamed_addr constant [48 x i8] c"int parse_int16_t_array(char *, int16_t *, int)\00", align 1, !dbg !76
@__PRETTY_FUNCTION__.parse_int32_t_array = private unnamed_addr constant [48 x i8] c"int parse_int32_t_array(char *, int32_t *, int)\00", align 1, !dbg !78
@__PRETTY_FUNCTION__.parse_int64_t_array = private unnamed_addr constant [48 x i8] c"int parse_int64_t_array(char *, int64_t *, int)\00", align 1, !dbg !80
@__PRETTY_FUNCTION__.parse_float_array = private unnamed_addr constant [44 x i8] c"int parse_float_array(char *, float *, int)\00", align 1, !dbg !82
@__PRETTY_FUNCTION__.parse_double_array = private unnamed_addr constant [46 x i8] c"int parse_double_array(char *, double *, int)\00", align 1, !dbg !87
@__PRETTY_FUNCTION__.write_string = private unnamed_addr constant [35 x i8] c"int write_string(int, char *, int)\00", align 1, !dbg !89
@.str.16 = private unnamed_addr constant [28 x i8] c"status>=0 && \22Write failed\22\00", align 1, !dbg !92
@__PRETTY_FUNCTION__.write_uint8_t_array = private unnamed_addr constant [45 x i8] c"int write_uint8_t_array(int, uint8_t *, int)\00", align 1, !dbg !97
@.str.17 = private unnamed_addr constant [4 x i8] c"%u\0A\00", align 1, !dbg !102
@__PRETTY_FUNCTION__.write_uint16_t_array = private unnamed_addr constant [47 x i8] c"int write_uint16_t_array(int, uint16_t *, int)\00", align 1, !dbg !107
@__PRETTY_FUNCTION__.write_uint32_t_array = private unnamed_addr constant [47 x i8] c"int write_uint32_t_array(int, uint32_t *, int)\00", align 1, !dbg !112
@__PRETTY_FUNCTION__.write_uint64_t_array = private unnamed_addr constant [47 x i8] c"int write_uint64_t_array(int, uint64_t *, int)\00", align 1, !dbg !114
@.str.18 = private unnamed_addr constant [5 x i8] c"%lu\0A\00", align 1, !dbg !116
@__PRETTY_FUNCTION__.write_int8_t_array = private unnamed_addr constant [43 x i8] c"int write_int8_t_array(int, int8_t *, int)\00", align 1, !dbg !121
@.str.19 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1, !dbg !126
@__PRETTY_FUNCTION__.write_int16_t_array = private unnamed_addr constant [45 x i8] c"int write_int16_t_array(int, int16_t *, int)\00", align 1, !dbg !128
@__PRETTY_FUNCTION__.write_int32_t_array = private unnamed_addr constant [45 x i8] c"int write_int32_t_array(int, int32_t *, int)\00", align 1, !dbg !130
@__PRETTY_FUNCTION__.write_int64_t_array = private unnamed_addr constant [45 x i8] c"int write_int64_t_array(int, int64_t *, int)\00", align 1, !dbg !132
@.str.20 = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1, !dbg !134
@__PRETTY_FUNCTION__.write_float_array = private unnamed_addr constant [41 x i8] c"int write_float_array(int, float *, int)\00", align 1, !dbg !136
@.str.21 = private unnamed_addr constant [7 x i8] c"%.16f\0A\00", align 1, !dbg !141
@__PRETTY_FUNCTION__.write_double_array = private unnamed_addr constant [43 x i8] c"int write_double_array(int, double *, int)\00", align 1, !dbg !146
@__PRETTY_FUNCTION__.write_section_header = private unnamed_addr constant [30 x i8] c"int write_section_header(int)\00", align 1, !dbg !148
@.str.22 = private unnamed_addr constant [6 x i8] c"%%%%\0A\00", align 1, !dbg !153
@.str.24 = private unnamed_addr constant [90 x i8] c"buffered<SUFFICIENT_SPRINTF_SPACE && \22Overran fd_printf buffer---output possibly corrupt\22\00", align 1, !dbg !158
@__PRETTY_FUNCTION__.fd_printf = private unnamed_addr constant [38 x i8] c"int fd_printf(int, const char *, ...)\00", align 1, !dbg !163
@.str.26 = private unnamed_addr constant [50 x i8] c"written==buffered && \22Wrote more data than given\22\00", align 1, !dbg !165
@.str.1.11 = private unnamed_addr constant [57 x i8] c"argc<4 && \22Usage: ./benchmark <input_file> <check_file>\22\00", align 1, !dbg !168
@.str.2.12 = private unnamed_addr constant [23 x i8] c"../../common/harness.c\00", align 1, !dbg !174
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1, !dbg !176
@.str.3 = private unnamed_addr constant [11 x i8] c"input.data\00", align 1, !dbg !179
@.str.4.13 = private unnamed_addr constant [11 x i8] c"check.data\00", align 1, !dbg !184
@INPUT_SIZE = dso_local local_unnamed_addr global i32 131080, align 4, !dbg !186
@.str.6.14 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !208
@.str.8.15 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !211
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !214
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !219
@.str.12.16 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !222
@.str.14.17 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !224
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !227
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @stencil(ptr nocapture noundef readonly %C, ptr nocapture noundef readonly %orig, ptr nocapture noundef writeonly %sol) local_unnamed_addr #0 !dbg !326 {
entry.split:
  %scevgep56.reg2mem = alloca ptr, align 8
  %scevgep48.reg2mem = alloca ptr, align 8
  %scevgep43.reg2mem = alloca ptr, align 8
  %scevgep38.reg2mem = alloca ptr, align 8
  %scevgep33.reg2mem = alloca ptr, align 8
  %scevgep28.reg2mem = alloca ptr, align 8
  %scevgep23.reg2mem = alloca ptr, align 8
  %scevgep19.reg2mem = alloca ptr, align 8
  %polly.indvar9.reg2mem = alloca i64, align 8
  %polly.indvar_next16.reg2mem = alloca i64, align 8
  %scevgep55.reg2mem = alloca ptr, align 8
  %scevgep47.reg2mem = alloca ptr, align 8
  %scevgep42.reg2mem = alloca ptr, align 8
  %scevgep37.reg2mem = alloca ptr, align 8
  %scevgep32.reg2mem = alloca ptr, align 8
  %scevgep27.reg2mem = alloca ptr, align 8
  %scevgep22.reg2mem = alloca ptr, align 8
  %scevgep18.reg2mem = alloca ptr, align 8
  %polly.indvar.reg2mem = alloca i64, align 8
  %polly.indvar_next10.reg2mem = alloca i64, align 8
  %_p_scalar_53.reg2mem = alloca i32, align 4
  %_p_scalar_51.reg2mem = alloca i32, align 4
  %scevgep54.reg2mem = alloca ptr, align 8
  %scevgep46.reg2mem = alloca ptr, align 8
  %scevgep41.reg2mem = alloca ptr, align 8
  %scevgep36.reg2mem = alloca ptr, align 8
  %scevgep31.reg2mem = alloca ptr, align 8
  %scevgep21.reg2mem = alloca ptr, align 8
  %scevgep.reg2mem = alloca ptr, align 8
  %polly.indvar_next.reg2mem = alloca i64, align 8
  %polly.access.orig2.reg2mem = alloca ptr, align 8
  %indvars.iv.next277.reg2mem = alloca i64, align 8
  %indvars.iv.next273.reg2mem = alloca i64, align 8
  %.reg2mem153 = alloca i64, align 8
  %indvars.iv276.reg2mem = alloca i64, align 8
  %indvars.iv.next269.reg2mem = alloca i64, align 8
  %indvars.iv.next.reg2mem = alloca i64, align 8
  %.reg2mem158 = alloca i64, align 8
  %indvars.iv268.reg2mem = alloca i64, align 8
  %polly.indvar80.reg2mem = alloca i64, align 8
  %polly.indvar61.reg2mem = alloca i64, align 8
  %polly.indvar9.reg2mem161 = alloca i64, align 8
  %polly.indvar15.reg2mem = alloca i64, align 8
  %polly.indvar.reg2mem163 = alloca i64, align 8
  %indvars.iv288.reg2mem = alloca i64, align 8
  %indvars.iv298.reg2mem165 = alloca i64, align 8
  %indvars.iv312.reg2mem167 = alloca i64, align 8
  %indvars.iv280.reg2mem = alloca i64, align 8
  %indvars.iv285.reg2mem169 = alloca i64, align 8
  %indvars.iv272.reg2mem = alloca i64, align 8
  %indvars.iv276.reg2mem171 = alloca i64, align 8
  %indvars.iv.reg2mem = alloca i64, align 8
  %indvars.iv268.reg2mem173 = alloca i64, align 8
    #dbg_value(ptr %C, !331, !DIExpression(), !365)
    #dbg_value(ptr %orig, !332, !DIExpression(), !365)
    #dbg_value(ptr %sol, !333, !DIExpression(), !365)
    #dbg_label(!341, !366)
    #dbg_value(i32 0, !335, !DIExpression(), !365)
  store i64 0, ptr %indvars.iv268.reg2mem173, align 8
  br label %for.cond1.preheader, !dbg !367

for.cond1.preheader:                              ; preds = %for.inc20.for.cond1.preheader_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv268.reg2mem173.0.load, !335, !DIExpression(), !365)
  %indvars.iv268.reg2mem173.0.load = load i64, ptr %indvars.iv268.reg2mem173, align 8
  store i64 %indvars.iv268.reg2mem173.0.load, ptr %indvars.iv268.reg2mem, align 8
  %0 = shl nuw nsw i64 %indvars.iv268.reg2mem173.0.load, 4
    #dbg_value(i32 0, !336, !DIExpression(), !365)
  store i64 %0, ptr %.reg2mem158, align 8
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body3, !dbg !368

for.body3:                                        ; preds = %for.body3.for.body3_crit_edge, %for.cond1.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !336, !DIExpression(), !365)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %1 = add nuw nsw i64 %indvars.iv.reg2mem.0.load, %0, !dbg !370
  %arrayidx = getelementptr inbounds i32, ptr %orig, i64 %1, !dbg !373
  %2 = load i32, ptr %arrayidx, align 4, !dbg !373, !tbaa !374
  %arrayidx9 = getelementptr inbounds i32, ptr %sol, i64 %1, !dbg !378
  store i32 %2, ptr %arrayidx9, align 4, !dbg !379, !tbaa !374
  %add12 = and i64 %1, 4294951423, !dbg !380
  %idxprom13 = or disjoint i64 %add12, 15872, !dbg !380
  %arrayidx14 = getelementptr inbounds i32, ptr %orig, i64 %idxprom13, !dbg !380
  %3 = load i32, ptr %arrayidx14, align 4, !dbg !380, !tbaa !374
  %arrayidx19 = getelementptr inbounds i32, ptr %sol, i64 %idxprom13, !dbg !381
  store i32 %3, ptr %arrayidx19, align 4, !dbg !382, !tbaa !374
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !383
    #dbg_value(i64 %indvars.iv.next, !336, !DIExpression(), !365)
  store i64 %indvars.iv.next, ptr %indvars.iv.next.reg2mem, align 8
  %exitcond.not = icmp eq i64 %indvars.iv.next, 16, !dbg !384
  br i1 %exitcond.not, label %for.inc20, label %for.body3.for.body3_crit_edge, !dbg !368, !llvm.loop !385

for.body3.for.body3_crit_edge:                    ; preds = %for.body3
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body3, !dbg !368

for.inc20:                                        ; preds = %for.body3
  %indvars.iv.next269 = add nuw nsw i64 %indvars.iv268.reg2mem173.0.load, 1, !dbg !389
    #dbg_value(i64 %indvars.iv.next269, !335, !DIExpression(), !365)
  store i64 %indvars.iv.next269, ptr %indvars.iv.next269.reg2mem, align 8
  %exitcond271.not = icmp eq i64 %indvars.iv.next269, 32, !dbg !390
  br i1 %exitcond271.not, label %for.inc20.for.cond26.preheader_crit_edge, label %for.inc20.for.cond1.preheader_crit_edge, !dbg !367, !llvm.loop !391

for.inc20.for.cond1.preheader_crit_edge:          ; preds = %for.inc20
  store i64 %indvars.iv.next269, ptr %indvars.iv268.reg2mem173, align 8
  br label %for.cond1.preheader, !dbg !367

for.inc20.for.cond26.preheader_crit_edge:         ; preds = %for.inc20
  store i64 1, ptr %indvars.iv276.reg2mem171, align 8
  br label %for.cond26.preheader, !dbg !367

for.cond26.preheader:                             ; preds = %for.inc56.for.cond26.preheader_crit_edge, %for.inc20.for.cond26.preheader_crit_edge
    #dbg_value(i64 %indvars.iv276.reg2mem171.0.load, !334, !DIExpression(), !365)
  %indvars.iv276.reg2mem171.0.load = load i64, ptr %indvars.iv276.reg2mem171, align 8
  store i64 %indvars.iv276.reg2mem171.0.load, ptr %indvars.iv276.reg2mem, align 8
  %4 = shl nuw nsw i64 %indvars.iv276.reg2mem171.0.load, 9
    #dbg_value(i32 0, !336, !DIExpression(), !365)
  store i64 %4, ptr %.reg2mem153, align 8
  store i64 0, ptr %indvars.iv272.reg2mem, align 8
  br label %for.body28, !dbg !393

for.body28:                                       ; preds = %for.body28.for.body28_crit_edge, %for.cond26.preheader
    #dbg_value(i64 %indvars.iv272.reg2mem.0.load, !336, !DIExpression(), !365)
  %indvars.iv272.reg2mem.0.load = load i64, ptr %indvars.iv272.reg2mem, align 8
  %5 = add nuw nsw i64 %indvars.iv272.reg2mem.0.load, %4, !dbg !395
  %arrayidx34 = getelementptr inbounds i32, ptr %orig, i64 %5, !dbg !398
  %6 = load i32, ptr %arrayidx34, align 4, !dbg !398, !tbaa !374
  %arrayidx40 = getelementptr inbounds i32, ptr %sol, i64 %5, !dbg !399
  store i32 %6, ptr %arrayidx40, align 4, !dbg !400, !tbaa !374
  %add44 = and i64 %5, 4294966799, !dbg !401
  %idxprom45 = or disjoint i64 %add44, 496, !dbg !401
  %arrayidx46 = getelementptr inbounds i32, ptr %orig, i64 %idxprom45, !dbg !401
  %7 = load i32, ptr %arrayidx46, align 4, !dbg !401, !tbaa !374
  %arrayidx52 = getelementptr inbounds i32, ptr %sol, i64 %idxprom45, !dbg !402
  store i32 %7, ptr %arrayidx52, align 4, !dbg !403, !tbaa !374
  %indvars.iv.next273 = add nuw nsw i64 %indvars.iv272.reg2mem.0.load, 1, !dbg !404
    #dbg_value(i64 %indvars.iv.next273, !336, !DIExpression(), !365)
  store i64 %indvars.iv.next273, ptr %indvars.iv.next273.reg2mem, align 8
  %exitcond275.not = icmp eq i64 %indvars.iv.next273, 16, !dbg !405
  br i1 %exitcond275.not, label %for.inc56, label %for.body28.for.body28_crit_edge, !dbg !393, !llvm.loop !406

for.body28.for.body28_crit_edge:                  ; preds = %for.body28
  store i64 %indvars.iv.next273, ptr %indvars.iv272.reg2mem, align 8
  br label %for.body28, !dbg !393

for.inc56:                                        ; preds = %for.body28
  %indvars.iv.next277 = add nuw nsw i64 %indvars.iv276.reg2mem171.0.load, 1, !dbg !408
    #dbg_value(i64 %indvars.iv.next277, !334, !DIExpression(), !365)
  store i64 %indvars.iv.next277, ptr %indvars.iv.next277.reg2mem, align 8
  %exitcond279.not = icmp eq i64 %indvars.iv.next277, 31, !dbg !409
  br i1 %exitcond279.not, label %polly.split_new_and_old, label %for.inc56.for.cond26.preheader_crit_edge, !dbg !410, !llvm.loop !411

for.inc56.for.cond26.preheader_crit_edge:         ; preds = %for.inc56
  store i64 %indvars.iv.next277, ptr %indvars.iv276.reg2mem171, align 8
  br label %for.cond26.preheader, !dbg !410

polly.split_new_and_old:                          ; preds = %for.inc56
  %polly.access.orig = getelementptr i8, ptr %orig, i64 65468
  %polly.access.sol = getelementptr i8, ptr %sol, i64 1924
  %8 = icmp ule ptr %polly.access.orig, %polly.access.sol
  %polly.access.sol1 = getelementptr i8, ptr %sol, i64 63424
  %polly.access.orig2 = getelementptr i8, ptr %orig, i64 68
  store ptr %polly.access.orig2, ptr %polly.access.orig2.reg2mem, align 8
  %9 = icmp ule ptr %polly.access.sol1, %polly.access.orig2
  %10 = or i1 %8, %9
  %polly.access.C = getelementptr i8, ptr %C, i64 8
  %11 = icmp ule ptr %polly.access.C, %polly.access.sol
  %12 = icmp ule ptr %polly.access.sol1, %C
  %13 = or i1 %11, %12
  %14 = and i1 %10, %13
  br i1 %14, label %polly.loop_preheader, label %polly.split_new_and_old.for.cond62.preheader_crit_edge

polly.split_new_and_old.for.cond62.preheader_crit_edge: ; preds = %polly.split_new_and_old
  store i64 1, ptr %indvars.iv285.reg2mem169, align 8
  br label %for.cond62.preheader

for.cond62.preheader:                             ; preds = %for.inc92.for.cond62.preheader_crit_edge, %polly.split_new_and_old.for.cond62.preheader_crit_edge
    #dbg_value(i64 %indvars.iv285.reg2mem169.0.load, !334, !DIExpression(), !365)
  %indvars.iv285.reg2mem169.0.load = load i64, ptr %indvars.iv285.reg2mem169, align 8
  %15 = shl nuw nsw i64 %indvars.iv285.reg2mem169.0.load, 9
    #dbg_value(i32 1, !335, !DIExpression(), !365)
  store i64 1, ptr %indvars.iv280.reg2mem, align 8
  br label %for.body64, !dbg !413

for.cond95.preheader:                             ; preds = %for.inc92
  %arrayidx158 = getelementptr inbounds i8, ptr %C, i64 4
    #dbg_value(i32 1, !334, !DIExpression(), !365)
  %invariant.gep330 = getelementptr i8, ptr %orig, i64 -4
  store i64 1, ptr %indvars.iv312.reg2mem167, align 8
  br label %for.cond98.preheader, !dbg !415

for.body64:                                       ; preds = %for.body64.for.body64_crit_edge, %for.cond62.preheader
    #dbg_value(i64 %indvars.iv280.reg2mem.0.load, !335, !DIExpression(), !365)
  %indvars.iv280.reg2mem.0.load = load i64, ptr %indvars.iv280.reg2mem, align 8
  %16 = shl nuw nsw i64 %indvars.iv280.reg2mem.0.load, 4, !dbg !416
  %17 = add nuw nsw i64 %16, %15, !dbg !416
  %arrayidx70 = getelementptr inbounds i32, ptr %orig, i64 %17, !dbg !419
  %18 = load i32, ptr %arrayidx70, align 4, !dbg !419, !tbaa !374
  %arrayidx76 = getelementptr inbounds i32, ptr %sol, i64 %17, !dbg !420
  store i32 %18, ptr %arrayidx76, align 4, !dbg !421, !tbaa !374
  %19 = or disjoint i64 %17, 15, !dbg !422
  %arrayidx82 = getelementptr inbounds i32, ptr %orig, i64 %19, !dbg !423
  %20 = load i32, ptr %arrayidx82, align 4, !dbg !423, !tbaa !374
  %arrayidx88 = getelementptr inbounds i32, ptr %sol, i64 %19, !dbg !424
  store i32 %20, ptr %arrayidx88, align 4, !dbg !425, !tbaa !374
  %indvars.iv.next281 = add nuw nsw i64 %indvars.iv280.reg2mem.0.load, 1, !dbg !426
    #dbg_value(i64 %indvars.iv.next281, !335, !DIExpression(), !365)
  %exitcond284.not = icmp eq i64 %indvars.iv.next281, 31, !dbg !427
  br i1 %exitcond284.not, label %for.inc92, label %for.body64.for.body64_crit_edge, !dbg !413, !llvm.loop !428

for.body64.for.body64_crit_edge:                  ; preds = %for.body64
  store i64 %indvars.iv.next281, ptr %indvars.iv280.reg2mem, align 8
  br label %for.body64, !dbg !413

for.inc92:                                        ; preds = %for.body64
  %indvars.iv.next286 = add nuw nsw i64 %indvars.iv285.reg2mem169.0.load, 1, !dbg !430
    #dbg_value(i64 %indvars.iv.next286, !334, !DIExpression(), !365)
  %exitcond287.not = icmp eq i64 %indvars.iv.next286, 31, !dbg !431
  br i1 %exitcond287.not, label %for.cond95.preheader, label %for.inc92.for.cond62.preheader_crit_edge, !dbg !432, !llvm.loop !433

for.inc92.for.cond62.preheader_crit_edge:         ; preds = %for.inc92
  store i64 %indvars.iv.next286, ptr %indvars.iv285.reg2mem169, align 8
  br label %for.cond62.preheader, !dbg !432

for.cond98.preheader:                             ; preds = %for.inc173.for.cond98.preheader_crit_edge, %for.cond95.preheader
    #dbg_value(i64 %indvars.iv312.reg2mem167.0.load, !334, !DIExpression(), !365)
  %indvars.iv312.reg2mem167.0.load = load i64, ptr %indvars.iv312.reg2mem167, align 8
  %21 = shl nuw nsw i64 %indvars.iv312.reg2mem167.0.load, 5
  %22 = add nuw nsw i64 %21, 32
  %23 = add nuw nsw i64 %21, 288230376151711712
  %24 = or disjoint i64 %21, 1
  %25 = add nuw nsw i64 %21, 288230376151711743
    #dbg_value(i32 1, !335, !DIExpression(), !365)
  store i64 1, ptr %indvars.iv298.reg2mem165, align 8
  br label %for.cond101.preheader, !dbg !435

for.cond101.preheader:                            ; preds = %for.inc170.for.cond101.preheader_crit_edge, %for.cond98.preheader
    #dbg_value(i64 %indvars.iv298.reg2mem165.0.load, !335, !DIExpression(), !365)
  %indvars.iv298.reg2mem165.0.load = load i64, ptr %indvars.iv298.reg2mem165, align 8
  %26 = or disjoint i64 %indvars.iv298.reg2mem165.0.load, %21
  %27 = shl nuw nsw i64 %26, 4
  %28 = add nuw nsw i64 %22, %indvars.iv298.reg2mem165.0.load
  %29 = add nuw nsw i64 %23, %indvars.iv298.reg2mem165.0.load
  %30 = add nuw nsw i64 %24, %indvars.iv298.reg2mem165.0.load
  %31 = add nuw nsw i64 %25, %indvars.iv298.reg2mem165.0.load
    #dbg_value(i32 1, !336, !DIExpression(), !365)
  %invariant.gep.idx = shl i64 %28, 6, !dbg !436
  %invariant.gep = getelementptr i8, ptr %orig, i64 %invariant.gep.idx, !dbg !436
  %invariant.gep322.idx = shl i64 %29, 6, !dbg !436
  %invariant.gep322 = getelementptr i8, ptr %orig, i64 %invariant.gep322.idx, !dbg !436
  %invariant.gep324.idx = shl i64 %30, 6, !dbg !436
  %invariant.gep324 = getelementptr i8, ptr %orig, i64 %invariant.gep324.idx, !dbg !436
  %invariant.gep326.idx = shl i64 %31, 6, !dbg !436
  %invariant.gep326 = getelementptr i8, ptr %orig, i64 %invariant.gep326.idx, !dbg !436
  %invariant.gep328 = getelementptr i32, ptr %orig, i64 %27, !dbg !436
  %gep331 = getelementptr i32, ptr %invariant.gep330, i64 %27
  store i64 1, ptr %indvars.iv288.reg2mem, align 8
  br label %for.body103, !dbg !436

for.body103:                                      ; preds = %for.body103.for.body103_crit_edge, %for.cond101.preheader
    #dbg_value(i64 %indvars.iv288.reg2mem.0.load, !336, !DIExpression(), !365)
  %indvars.iv288.reg2mem.0.load = load i64, ptr %indvars.iv288.reg2mem, align 8
  %32 = or disjoint i64 %indvars.iv288.reg2mem.0.load, %27, !dbg !438
  %arrayidx109 = getelementptr inbounds i32, ptr %orig, i64 %32, !dbg !441
  %33 = load i32, ptr %arrayidx109, align 4, !dbg !441, !tbaa !374
    #dbg_value(i32 %33, !337, !DIExpression(), !365)
  %gep = getelementptr i32, ptr %invariant.gep, i64 %indvars.iv288.reg2mem.0.load, !dbg !442
  %34 = load i32, ptr %gep, align 4, !dbg !442, !tbaa !374
  %gep323 = getelementptr i32, ptr %invariant.gep322, i64 %indvars.iv288.reg2mem.0.load, !dbg !443
  %35 = load i32, ptr %gep323, align 4, !dbg !443, !tbaa !374
  %add123 = add nsw i32 %35, %34, !dbg !444
  %gep325 = getelementptr i32, ptr %invariant.gep324, i64 %indvars.iv288.reg2mem.0.load, !dbg !445
  %36 = load i32, ptr %gep325, align 4, !dbg !445, !tbaa !374
  %add131 = add nsw i32 %add123, %36, !dbg !446
  %gep327 = getelementptr i32, ptr %invariant.gep326, i64 %indvars.iv288.reg2mem.0.load, !dbg !447
  %37 = load i32, ptr %gep327, align 4, !dbg !447, !tbaa !374
  %add139 = add nsw i32 %add131, %37, !dbg !448
  %indvars.iv.next289 = add nuw nsw i64 %indvars.iv288.reg2mem.0.load, 1, !dbg !449
  %gep329 = getelementptr i32, ptr %invariant.gep328, i64 %indvars.iv.next289, !dbg !450
  %38 = load i32, ptr %gep329, align 4, !dbg !450, !tbaa !374
  %add147 = add nsw i32 %add139, %38, !dbg !451
  %arrayidx154 = getelementptr i32, ptr %gep331, i64 %indvars.iv288.reg2mem.0.load, !dbg !452
  %39 = load i32, ptr %arrayidx154, align 4, !dbg !452, !tbaa !374
  %add155 = add nsw i32 %add147, %39, !dbg !453
    #dbg_value(i32 %add155, !338, !DIExpression(), !365)
  %40 = load i32, ptr %C, align 4, !dbg !454, !tbaa !374
  %mul157 = mul nsw i32 %40, %33, !dbg !455
    #dbg_value(i32 %mul157, !339, !DIExpression(), !365)
  %41 = load i32, ptr %arrayidx158, align 4, !dbg !456, !tbaa !374
  %mul159 = mul nsw i32 %41, %add155, !dbg !457
    #dbg_value(i32 %mul159, !340, !DIExpression(), !365)
  %add160 = add nsw i32 %mul159, %mul157, !dbg !458
  %arrayidx166 = getelementptr inbounds i32, ptr %sol, i64 %32, !dbg !459
  store i32 %add160, ptr %arrayidx166, align 4, !dbg !460, !tbaa !374
    #dbg_value(i64 %indvars.iv.next289, !336, !DIExpression(), !365)
  %exitcond297.not = icmp eq i64 %indvars.iv.next289, 15, !dbg !461
  br i1 %exitcond297.not, label %for.inc170, label %for.body103.for.body103_crit_edge, !dbg !436, !llvm.loop !462

for.body103.for.body103_crit_edge:                ; preds = %for.body103
  store i64 %indvars.iv.next289, ptr %indvars.iv288.reg2mem, align 8
  br label %for.body103, !dbg !436

for.inc170:                                       ; preds = %for.body103
  %indvars.iv.next299 = add nuw nsw i64 %indvars.iv298.reg2mem165.0.load, 1, !dbg !464
    #dbg_value(i64 %indvars.iv.next299, !335, !DIExpression(), !365)
  %exitcond311.not = icmp eq i64 %indvars.iv.next299, 31, !dbg !465
  br i1 %exitcond311.not, label %for.inc173, label %for.inc170.for.cond101.preheader_crit_edge, !dbg !435, !llvm.loop !466

for.inc170.for.cond101.preheader_crit_edge:       ; preds = %for.inc170
  store i64 %indvars.iv.next299, ptr %indvars.iv298.reg2mem165, align 8
  br label %for.cond101.preheader, !dbg !435

for.inc173:                                       ; preds = %for.inc170
  %indvars.iv.next313 = add nuw nsw i64 %indvars.iv312.reg2mem167.0.load, 1, !dbg !468
    #dbg_value(i64 %indvars.iv.next313, !334, !DIExpression(), !365)
  %exitcond319.not = icmp eq i64 %indvars.iv.next313, 31, !dbg !469
  br i1 %exitcond319.not, label %for.inc173.for.end175_crit_edge, label %for.inc173.for.cond98.preheader_crit_edge, !dbg !415, !llvm.loop !470

for.inc173.for.cond98.preheader_crit_edge:        ; preds = %for.inc173
  store i64 %indvars.iv.next313, ptr %indvars.iv312.reg2mem167, align 8
  br label %for.cond98.preheader, !dbg !415

for.inc173.for.end175_crit_edge:                  ; preds = %for.inc173
  br label %for.end175, !dbg !415

for.end175:                                       ; preds = %polly.loop_preheader84.for.end175_crit_edge, %for.inc173.for.end175_crit_edge
  ret void, !dbg !472

polly.loop_exit8:                                 ; preds = %polly.loop_exit14
  %polly.indvar_next = add nuw nsw i64 %polly.indvar.reg2mem163.0.load, 1
  store i64 %polly.indvar_next, ptr %polly.indvar_next.reg2mem, align 8
  %exitcond102.not = icmp eq i64 %polly.indvar_next, 30
  br i1 %exitcond102.not, label %polly.loop_preheader59, label %polly.loop_exit8.polly.loop_preheader7_crit_edge

polly.loop_exit8.polly.loop_preheader7_crit_edge: ; preds = %polly.loop_exit8
  store i64 %polly.indvar_next, ptr %polly.indvar.reg2mem163, align 8
  br label %polly.loop_preheader7

polly.loop_preheader:                             ; preds = %polly.split_new_and_old
  %scevgep = getelementptr i8, ptr %orig, i64 2116
  store ptr %scevgep, ptr %scevgep.reg2mem, align 8
  %scevgep21 = getelementptr i8, ptr %orig, i64 4164
  store ptr %scevgep21, ptr %scevgep21.reg2mem, align 8
  %scevgep31 = getelementptr i8, ptr %orig, i64 2180
  store ptr %scevgep31, ptr %scevgep31.reg2mem, align 8
  %scevgep36 = getelementptr i8, ptr %orig, i64 2052
  store ptr %scevgep36, ptr %scevgep36.reg2mem, align 8
  %scevgep41 = getelementptr i8, ptr %orig, i64 2120
  store ptr %scevgep41, ptr %scevgep41.reg2mem, align 8
  %scevgep46 = getelementptr i8, ptr %orig, i64 2112
  store ptr %scevgep46, ptr %scevgep46.reg2mem, align 8
  %scevgep52 = getelementptr i8, ptr %C, i64 4
  %scevgep54 = getelementptr i8, ptr %sol, i64 2116
  store ptr %scevgep54, ptr %scevgep54.reg2mem, align 8
  %_p_scalar_51 = load i32, ptr %C, align 4
  store i32 %_p_scalar_51, ptr %_p_scalar_51.reg2mem, align 4
  %_p_scalar_53 = load i32, ptr %scevgep52, align 4
  store i32 %_p_scalar_53, ptr %_p_scalar_53.reg2mem, align 4
  store i64 0, ptr %polly.indvar.reg2mem163, align 8
  br label %polly.loop_preheader7

polly.loop_exit14:                                ; preds = %polly.stmt.for.body103
  %polly.indvar_next10 = add nuw nsw i64 %polly.indvar9.reg2mem161.0.load, 1
  store i64 %polly.indvar_next10, ptr %polly.indvar_next10.reg2mem, align 8
  %exitcond101.not = icmp eq i64 %polly.indvar_next10, 30
  br i1 %exitcond101.not, label %polly.loop_exit8, label %polly.loop_exit14.polly.loop_preheader13_crit_edge

polly.loop_exit14.polly.loop_preheader13_crit_edge: ; preds = %polly.loop_exit14
  store i64 %polly.indvar_next10, ptr %polly.indvar9.reg2mem161, align 8
  br label %polly.loop_preheader13

polly.loop_preheader7:                            ; preds = %polly.loop_exit8.polly.loop_preheader7_crit_edge, %polly.loop_preheader
  %polly.indvar.reg2mem163.0.load = load i64, ptr %polly.indvar.reg2mem163, align 8
  store i64 %polly.indvar.reg2mem163.0.load, ptr %polly.indvar.reg2mem, align 8
  %42 = shl nuw nsw i64 %polly.indvar.reg2mem163.0.load, 11
  %scevgep18 = getelementptr i8, ptr %scevgep, i64 %42
  store ptr %scevgep18, ptr %scevgep18.reg2mem, align 8
  %scevgep22 = getelementptr i8, ptr %scevgep21, i64 %42
  store ptr %scevgep22, ptr %scevgep22.reg2mem, align 8
  %scevgep27 = getelementptr i8, ptr %polly.access.orig2, i64 %42
  store ptr %scevgep27, ptr %scevgep27.reg2mem, align 8
  %scevgep32 = getelementptr i8, ptr %scevgep31, i64 %42
  store ptr %scevgep32, ptr %scevgep32.reg2mem, align 8
  %scevgep37 = getelementptr i8, ptr %scevgep36, i64 %42
  store ptr %scevgep37, ptr %scevgep37.reg2mem, align 8
  %scevgep42 = getelementptr i8, ptr %scevgep41, i64 %42
  store ptr %scevgep42, ptr %scevgep42.reg2mem, align 8
  %scevgep47 = getelementptr i8, ptr %scevgep46, i64 %42
  store ptr %scevgep47, ptr %scevgep47.reg2mem, align 8
  %scevgep55 = getelementptr i8, ptr %scevgep54, i64 %42
  store ptr %scevgep55, ptr %scevgep55.reg2mem, align 8
  store i64 0, ptr %polly.indvar9.reg2mem161, align 8
  br label %polly.loop_preheader13

polly.stmt.for.body103:                           ; preds = %polly.stmt.for.body103.polly.stmt.for.body103_crit_edge, %polly.loop_preheader13
  %polly.indvar15.reg2mem.0.load = load i64, ptr %polly.indvar15.reg2mem, align 8
  %43 = shl nuw nsw i64 %polly.indvar15.reg2mem.0.load, 2
  %scevgep20 = getelementptr i8, ptr %scevgep19, i64 %43
  %_p_scalar_ = load i32, ptr %scevgep20, align 4, !alias.scope !473, !noalias !476
  %scevgep24 = getelementptr i8, ptr %scevgep23, i64 %43
  %_p_scalar_25 = load i32, ptr %scevgep24, align 4, !alias.scope !473, !noalias !476
  %scevgep29 = getelementptr i8, ptr %scevgep28, i64 %43
  %_p_scalar_30 = load i32, ptr %scevgep29, align 4, !alias.scope !473, !noalias !476
  %p_add123 = add nsw i32 %_p_scalar_30, %_p_scalar_25, !dbg !444
  %scevgep34 = getelementptr i8, ptr %scevgep33, i64 %43
  %_p_scalar_35 = load i32, ptr %scevgep34, align 4, !alias.scope !473, !noalias !476
  %p_add131 = add nsw i32 %p_add123, %_p_scalar_35, !dbg !446
  %scevgep39 = getelementptr i8, ptr %scevgep38, i64 %43
  %_p_scalar_40 = load i32, ptr %scevgep39, align 4, !alias.scope !473, !noalias !476
  %p_add139 = add nsw i32 %p_add131, %_p_scalar_40, !dbg !448
  %scevgep44 = getelementptr i8, ptr %scevgep43, i64 %43
  %_p_scalar_45 = load i32, ptr %scevgep44, align 4, !alias.scope !473, !noalias !476
  %p_add147 = add nsw i32 %p_add139, %_p_scalar_45, !dbg !451
  %scevgep49 = getelementptr i8, ptr %scevgep48, i64 %43
  %_p_scalar_50 = load i32, ptr %scevgep49, align 4, !alias.scope !473, !noalias !476
  %p_add155 = add nsw i32 %p_add147, %_p_scalar_50, !dbg !453
  %p_mul157 = mul nsw i32 %_p_scalar_51, %_p_scalar_, !dbg !455
  %p_mul159 = mul nsw i32 %_p_scalar_53, %p_add155, !dbg !457
  %p_add160 = add nsw i32 %p_mul159, %p_mul157, !dbg !458
  %scevgep57 = getelementptr i8, ptr %scevgep56, i64 %43
  store i32 %p_add160, ptr %scevgep57, align 4, !alias.scope !479, !noalias !480
  %polly.indvar_next16 = add nuw nsw i64 %polly.indvar15.reg2mem.0.load, 1
  store i64 %polly.indvar_next16, ptr %polly.indvar_next16.reg2mem, align 8
  %exitcond.not107 = icmp eq i64 %polly.indvar_next16, 14
  br i1 %exitcond.not107, label %polly.loop_exit14, label %polly.stmt.for.body103.polly.stmt.for.body103_crit_edge

polly.stmt.for.body103.polly.stmt.for.body103_crit_edge: ; preds = %polly.stmt.for.body103
  store i64 %polly.indvar_next16, ptr %polly.indvar15.reg2mem, align 8
  br label %polly.stmt.for.body103

polly.loop_preheader13:                           ; preds = %polly.loop_exit14.polly.loop_preheader13_crit_edge, %polly.loop_preheader7
  %polly.indvar9.reg2mem161.0.load = load i64, ptr %polly.indvar9.reg2mem161, align 8
  store i64 %polly.indvar9.reg2mem161.0.load, ptr %polly.indvar9.reg2mem, align 8
  %44 = shl nuw nsw i64 %polly.indvar9.reg2mem161.0.load, 6
  %scevgep19 = getelementptr i8, ptr %scevgep18, i64 %44
  store ptr %scevgep19, ptr %scevgep19.reg2mem, align 8
  %scevgep23 = getelementptr i8, ptr %scevgep22, i64 %44
  store ptr %scevgep23, ptr %scevgep23.reg2mem, align 8
  %scevgep28 = getelementptr i8, ptr %scevgep27, i64 %44
  store ptr %scevgep28, ptr %scevgep28.reg2mem, align 8
  %scevgep33 = getelementptr i8, ptr %scevgep32, i64 %44
  store ptr %scevgep33, ptr %scevgep33.reg2mem, align 8
  %scevgep38 = getelementptr i8, ptr %scevgep37, i64 %44
  store ptr %scevgep38, ptr %scevgep38.reg2mem, align 8
  %scevgep43 = getelementptr i8, ptr %scevgep42, i64 %44
  store ptr %scevgep43, ptr %scevgep43.reg2mem, align 8
  %scevgep48 = getelementptr i8, ptr %scevgep47, i64 %44
  store ptr %scevgep48, ptr %scevgep48.reg2mem, align 8
  %scevgep56 = getelementptr i8, ptr %scevgep55, i64 %44
  store ptr %scevgep56, ptr %scevgep56.reg2mem, align 8
  store i64 0, ptr %polly.indvar15.reg2mem, align 8
  br label %polly.stmt.for.body103

polly.loop_preheader59:                           ; preds = %polly.loop_exit8
  %scevgep70 = getelementptr i8, ptr %orig, i64 2172
  %scevgep74 = getelementptr i8, ptr %sol, i64 2172
  store i64 0, ptr %polly.indvar61.reg2mem, align 8
  br label %polly.loop_preheader65

polly.loop_preheader65:                           ; preds = %polly.loop_preheader65.polly.loop_preheader65_crit_edge, %polly.loop_preheader59
  %polly.indvar61.reg2mem.0.load = load i64, ptr %polly.indvar61.reg2mem, align 8
  %45 = shl nuw nsw i64 %polly.indvar61.reg2mem.0.load, 11
  %scevgep71 = getelementptr i8, ptr %scevgep70, i64 %45
  %scevgep75 = getelementptr i8, ptr %scevgep74, i64 %45
  %_p_scalar_73 = load i32, ptr %scevgep71, align 4, !alias.scope !473, !noalias !476
  store i32 %_p_scalar_73, ptr %scevgep75, align 4, !alias.scope !479, !noalias !480
  %scevgep72.1 = getelementptr i8, ptr %scevgep71, i64 64
  %_p_scalar_73.1 = load i32, ptr %scevgep72.1, align 4, !alias.scope !473, !noalias !476
  %scevgep76.1 = getelementptr i8, ptr %scevgep75, i64 64
  store i32 %_p_scalar_73.1, ptr %scevgep76.1, align 4, !alias.scope !479, !noalias !480
  %scevgep72.2 = getelementptr i8, ptr %scevgep71, i64 128
  %_p_scalar_73.2 = load i32, ptr %scevgep72.2, align 4, !alias.scope !473, !noalias !476
  %scevgep76.2 = getelementptr i8, ptr %scevgep75, i64 128
  store i32 %_p_scalar_73.2, ptr %scevgep76.2, align 4, !alias.scope !479, !noalias !480
  %scevgep72.3 = getelementptr i8, ptr %scevgep71, i64 192
  %_p_scalar_73.3 = load i32, ptr %scevgep72.3, align 4, !alias.scope !473, !noalias !476
  %scevgep76.3 = getelementptr i8, ptr %scevgep75, i64 192
  store i32 %_p_scalar_73.3, ptr %scevgep76.3, align 4, !alias.scope !479, !noalias !480
  %scevgep72.4 = getelementptr i8, ptr %scevgep71, i64 256
  %_p_scalar_73.4 = load i32, ptr %scevgep72.4, align 4, !alias.scope !473, !noalias !476
  %scevgep76.4 = getelementptr i8, ptr %scevgep75, i64 256
  store i32 %_p_scalar_73.4, ptr %scevgep76.4, align 4, !alias.scope !479, !noalias !480
  %scevgep72.5 = getelementptr i8, ptr %scevgep71, i64 320
  %_p_scalar_73.5 = load i32, ptr %scevgep72.5, align 4, !alias.scope !473, !noalias !476
  %scevgep76.5 = getelementptr i8, ptr %scevgep75, i64 320
  store i32 %_p_scalar_73.5, ptr %scevgep76.5, align 4, !alias.scope !479, !noalias !480
  %scevgep72.6 = getelementptr i8, ptr %scevgep71, i64 384
  %_p_scalar_73.6 = load i32, ptr %scevgep72.6, align 4, !alias.scope !473, !noalias !476
  %scevgep76.6 = getelementptr i8, ptr %scevgep75, i64 384
  store i32 %_p_scalar_73.6, ptr %scevgep76.6, align 4, !alias.scope !479, !noalias !480
  %scevgep72.7 = getelementptr i8, ptr %scevgep71, i64 448
  %_p_scalar_73.7 = load i32, ptr %scevgep72.7, align 4, !alias.scope !473, !noalias !476
  %scevgep76.7 = getelementptr i8, ptr %scevgep75, i64 448
  store i32 %_p_scalar_73.7, ptr %scevgep76.7, align 4, !alias.scope !479, !noalias !480
  %scevgep72.8 = getelementptr i8, ptr %scevgep71, i64 512
  %_p_scalar_73.8 = load i32, ptr %scevgep72.8, align 4, !alias.scope !473, !noalias !476
  %scevgep76.8 = getelementptr i8, ptr %scevgep75, i64 512
  store i32 %_p_scalar_73.8, ptr %scevgep76.8, align 4, !alias.scope !479, !noalias !480
  %scevgep72.9 = getelementptr i8, ptr %scevgep71, i64 576
  %_p_scalar_73.9 = load i32, ptr %scevgep72.9, align 4, !alias.scope !473, !noalias !476
  %scevgep76.9 = getelementptr i8, ptr %scevgep75, i64 576
  store i32 %_p_scalar_73.9, ptr %scevgep76.9, align 4, !alias.scope !479, !noalias !480
  %scevgep72.10 = getelementptr i8, ptr %scevgep71, i64 640
  %_p_scalar_73.10 = load i32, ptr %scevgep72.10, align 4, !alias.scope !473, !noalias !476
  %scevgep76.10 = getelementptr i8, ptr %scevgep75, i64 640
  store i32 %_p_scalar_73.10, ptr %scevgep76.10, align 4, !alias.scope !479, !noalias !480
  %scevgep72.11 = getelementptr i8, ptr %scevgep71, i64 704
  %_p_scalar_73.11 = load i32, ptr %scevgep72.11, align 4, !alias.scope !473, !noalias !476
  %scevgep76.11 = getelementptr i8, ptr %scevgep75, i64 704
  store i32 %_p_scalar_73.11, ptr %scevgep76.11, align 4, !alias.scope !479, !noalias !480
  %scevgep72.12 = getelementptr i8, ptr %scevgep71, i64 768
  %_p_scalar_73.12 = load i32, ptr %scevgep72.12, align 4, !alias.scope !473, !noalias !476
  %scevgep76.12 = getelementptr i8, ptr %scevgep75, i64 768
  store i32 %_p_scalar_73.12, ptr %scevgep76.12, align 4, !alias.scope !479, !noalias !480
  %scevgep72.13 = getelementptr i8, ptr %scevgep71, i64 832
  %_p_scalar_73.13 = load i32, ptr %scevgep72.13, align 4, !alias.scope !473, !noalias !476
  %scevgep76.13 = getelementptr i8, ptr %scevgep75, i64 832
  store i32 %_p_scalar_73.13, ptr %scevgep76.13, align 4, !alias.scope !479, !noalias !480
  %scevgep72.14 = getelementptr i8, ptr %scevgep71, i64 896
  %_p_scalar_73.14 = load i32, ptr %scevgep72.14, align 4, !alias.scope !473, !noalias !476
  %scevgep76.14 = getelementptr i8, ptr %scevgep75, i64 896
  store i32 %_p_scalar_73.14, ptr %scevgep76.14, align 4, !alias.scope !479, !noalias !480
  %scevgep72.15 = getelementptr i8, ptr %scevgep71, i64 960
  %_p_scalar_73.15 = load i32, ptr %scevgep72.15, align 4, !alias.scope !473, !noalias !476
  %scevgep76.15 = getelementptr i8, ptr %scevgep75, i64 960
  store i32 %_p_scalar_73.15, ptr %scevgep76.15, align 4, !alias.scope !479, !noalias !480
  %scevgep72.16 = getelementptr i8, ptr %scevgep71, i64 1024
  %_p_scalar_73.16 = load i32, ptr %scevgep72.16, align 4, !alias.scope !473, !noalias !476
  %scevgep76.16 = getelementptr i8, ptr %scevgep75, i64 1024
  store i32 %_p_scalar_73.16, ptr %scevgep76.16, align 4, !alias.scope !479, !noalias !480
  %scevgep72.17 = getelementptr i8, ptr %scevgep71, i64 1088
  %_p_scalar_73.17 = load i32, ptr %scevgep72.17, align 4, !alias.scope !473, !noalias !476
  %scevgep76.17 = getelementptr i8, ptr %scevgep75, i64 1088
  store i32 %_p_scalar_73.17, ptr %scevgep76.17, align 4, !alias.scope !479, !noalias !480
  %scevgep72.18 = getelementptr i8, ptr %scevgep71, i64 1152
  %_p_scalar_73.18 = load i32, ptr %scevgep72.18, align 4, !alias.scope !473, !noalias !476
  %scevgep76.18 = getelementptr i8, ptr %scevgep75, i64 1152
  store i32 %_p_scalar_73.18, ptr %scevgep76.18, align 4, !alias.scope !479, !noalias !480
  %scevgep72.19 = getelementptr i8, ptr %scevgep71, i64 1216
  %_p_scalar_73.19 = load i32, ptr %scevgep72.19, align 4, !alias.scope !473, !noalias !476
  %scevgep76.19 = getelementptr i8, ptr %scevgep75, i64 1216
  store i32 %_p_scalar_73.19, ptr %scevgep76.19, align 4, !alias.scope !479, !noalias !480
  %scevgep72.20 = getelementptr i8, ptr %scevgep71, i64 1280
  %_p_scalar_73.20 = load i32, ptr %scevgep72.20, align 4, !alias.scope !473, !noalias !476
  %scevgep76.20 = getelementptr i8, ptr %scevgep75, i64 1280
  store i32 %_p_scalar_73.20, ptr %scevgep76.20, align 4, !alias.scope !479, !noalias !480
  %scevgep72.21 = getelementptr i8, ptr %scevgep71, i64 1344
  %_p_scalar_73.21 = load i32, ptr %scevgep72.21, align 4, !alias.scope !473, !noalias !476
  %scevgep76.21 = getelementptr i8, ptr %scevgep75, i64 1344
  store i32 %_p_scalar_73.21, ptr %scevgep76.21, align 4, !alias.scope !479, !noalias !480
  %scevgep72.22 = getelementptr i8, ptr %scevgep71, i64 1408
  %_p_scalar_73.22 = load i32, ptr %scevgep72.22, align 4, !alias.scope !473, !noalias !476
  %scevgep76.22 = getelementptr i8, ptr %scevgep75, i64 1408
  store i32 %_p_scalar_73.22, ptr %scevgep76.22, align 4, !alias.scope !479, !noalias !480
  %scevgep72.23 = getelementptr i8, ptr %scevgep71, i64 1472
  %_p_scalar_73.23 = load i32, ptr %scevgep72.23, align 4, !alias.scope !473, !noalias !476
  %scevgep76.23 = getelementptr i8, ptr %scevgep75, i64 1472
  store i32 %_p_scalar_73.23, ptr %scevgep76.23, align 4, !alias.scope !479, !noalias !480
  %scevgep72.24 = getelementptr i8, ptr %scevgep71, i64 1536
  %_p_scalar_73.24 = load i32, ptr %scevgep72.24, align 4, !alias.scope !473, !noalias !476
  %scevgep76.24 = getelementptr i8, ptr %scevgep75, i64 1536
  store i32 %_p_scalar_73.24, ptr %scevgep76.24, align 4, !alias.scope !479, !noalias !480
  %scevgep72.25 = getelementptr i8, ptr %scevgep71, i64 1600
  %_p_scalar_73.25 = load i32, ptr %scevgep72.25, align 4, !alias.scope !473, !noalias !476
  %scevgep76.25 = getelementptr i8, ptr %scevgep75, i64 1600
  store i32 %_p_scalar_73.25, ptr %scevgep76.25, align 4, !alias.scope !479, !noalias !480
  %scevgep72.26 = getelementptr i8, ptr %scevgep71, i64 1664
  %_p_scalar_73.26 = load i32, ptr %scevgep72.26, align 4, !alias.scope !473, !noalias !476
  %scevgep76.26 = getelementptr i8, ptr %scevgep75, i64 1664
  store i32 %_p_scalar_73.26, ptr %scevgep76.26, align 4, !alias.scope !479, !noalias !480
  %scevgep72.27 = getelementptr i8, ptr %scevgep71, i64 1728
  %_p_scalar_73.27 = load i32, ptr %scevgep72.27, align 4, !alias.scope !473, !noalias !476
  %scevgep76.27 = getelementptr i8, ptr %scevgep75, i64 1728
  store i32 %_p_scalar_73.27, ptr %scevgep76.27, align 4, !alias.scope !479, !noalias !480
  %scevgep72.28 = getelementptr i8, ptr %scevgep71, i64 1792
  %_p_scalar_73.28 = load i32, ptr %scevgep72.28, align 4, !alias.scope !473, !noalias !476
  %scevgep76.28 = getelementptr i8, ptr %scevgep75, i64 1792
  store i32 %_p_scalar_73.28, ptr %scevgep76.28, align 4, !alias.scope !479, !noalias !480
  %scevgep72.29 = getelementptr i8, ptr %scevgep71, i64 1856
  %_p_scalar_73.29 = load i32, ptr %scevgep72.29, align 4, !alias.scope !473, !noalias !476
  %scevgep76.29 = getelementptr i8, ptr %scevgep75, i64 1856
  store i32 %_p_scalar_73.29, ptr %scevgep76.29, align 4, !alias.scope !479, !noalias !480
  %polly.indvar_next62 = add nuw nsw i64 %polly.indvar61.reg2mem.0.load, 1
  %exitcond104.not = icmp eq i64 %polly.indvar_next62, 30
  br i1 %exitcond104.not, label %polly.loop_preheader78, label %polly.loop_preheader65.polly.loop_preheader65_crit_edge

polly.loop_preheader65.polly.loop_preheader65_crit_edge: ; preds = %polly.loop_preheader65
  store i64 %polly.indvar_next62, ptr %polly.indvar61.reg2mem, align 8
  br label %polly.loop_preheader65

polly.loop_preheader78:                           ; preds = %polly.loop_preheader65
  %scevgep94 = getelementptr i8, ptr %sol, i64 2112
  store i64 0, ptr %polly.indvar80.reg2mem, align 8
  br label %polly.loop_preheader84

polly.loop_preheader84:                           ; preds = %polly.loop_preheader84.polly.loop_preheader84_crit_edge, %polly.loop_preheader78
  %polly.indvar80.reg2mem.0.load = load i64, ptr %polly.indvar80.reg2mem, align 8
  %46 = shl nuw nsw i64 %polly.indvar80.reg2mem.0.load, 11
  %scevgep46.reg2mem.0.scevgep46.reload = load ptr, ptr %scevgep46.reg2mem, align 8
  %scevgep91 = getelementptr i8, ptr %scevgep46.reg2mem.0.scevgep46.reload, i64 %46
  %scevgep95 = getelementptr i8, ptr %scevgep94, i64 %46
  %_p_scalar_93 = load i32, ptr %scevgep91, align 4, !alias.scope !473, !noalias !476
  store i32 %_p_scalar_93, ptr %scevgep95, align 4, !alias.scope !479, !noalias !480
  %scevgep92.1 = getelementptr i8, ptr %scevgep91, i64 64
  %_p_scalar_93.1 = load i32, ptr %scevgep92.1, align 4, !alias.scope !473, !noalias !476
  %scevgep96.1 = getelementptr i8, ptr %scevgep95, i64 64
  store i32 %_p_scalar_93.1, ptr %scevgep96.1, align 4, !alias.scope !479, !noalias !480
  %scevgep92.2 = getelementptr i8, ptr %scevgep91, i64 128
  %_p_scalar_93.2 = load i32, ptr %scevgep92.2, align 4, !alias.scope !473, !noalias !476
  %scevgep96.2 = getelementptr i8, ptr %scevgep95, i64 128
  store i32 %_p_scalar_93.2, ptr %scevgep96.2, align 4, !alias.scope !479, !noalias !480
  %scevgep92.3 = getelementptr i8, ptr %scevgep91, i64 192
  %_p_scalar_93.3 = load i32, ptr %scevgep92.3, align 4, !alias.scope !473, !noalias !476
  %scevgep96.3 = getelementptr i8, ptr %scevgep95, i64 192
  store i32 %_p_scalar_93.3, ptr %scevgep96.3, align 4, !alias.scope !479, !noalias !480
  %scevgep92.4 = getelementptr i8, ptr %scevgep91, i64 256
  %_p_scalar_93.4 = load i32, ptr %scevgep92.4, align 4, !alias.scope !473, !noalias !476
  %scevgep96.4 = getelementptr i8, ptr %scevgep95, i64 256
  store i32 %_p_scalar_93.4, ptr %scevgep96.4, align 4, !alias.scope !479, !noalias !480
  %scevgep92.5 = getelementptr i8, ptr %scevgep91, i64 320
  %_p_scalar_93.5 = load i32, ptr %scevgep92.5, align 4, !alias.scope !473, !noalias !476
  %scevgep96.5 = getelementptr i8, ptr %scevgep95, i64 320
  store i32 %_p_scalar_93.5, ptr %scevgep96.5, align 4, !alias.scope !479, !noalias !480
  %scevgep92.6 = getelementptr i8, ptr %scevgep91, i64 384
  %_p_scalar_93.6 = load i32, ptr %scevgep92.6, align 4, !alias.scope !473, !noalias !476
  %scevgep96.6 = getelementptr i8, ptr %scevgep95, i64 384
  store i32 %_p_scalar_93.6, ptr %scevgep96.6, align 4, !alias.scope !479, !noalias !480
  %scevgep92.7 = getelementptr i8, ptr %scevgep91, i64 448
  %_p_scalar_93.7 = load i32, ptr %scevgep92.7, align 4, !alias.scope !473, !noalias !476
  %scevgep96.7 = getelementptr i8, ptr %scevgep95, i64 448
  store i32 %_p_scalar_93.7, ptr %scevgep96.7, align 4, !alias.scope !479, !noalias !480
  %scevgep92.8 = getelementptr i8, ptr %scevgep91, i64 512
  %_p_scalar_93.8 = load i32, ptr %scevgep92.8, align 4, !alias.scope !473, !noalias !476
  %scevgep96.8 = getelementptr i8, ptr %scevgep95, i64 512
  store i32 %_p_scalar_93.8, ptr %scevgep96.8, align 4, !alias.scope !479, !noalias !480
  %scevgep92.9 = getelementptr i8, ptr %scevgep91, i64 576
  %_p_scalar_93.9 = load i32, ptr %scevgep92.9, align 4, !alias.scope !473, !noalias !476
  %scevgep96.9 = getelementptr i8, ptr %scevgep95, i64 576
  store i32 %_p_scalar_93.9, ptr %scevgep96.9, align 4, !alias.scope !479, !noalias !480
  %scevgep92.10 = getelementptr i8, ptr %scevgep91, i64 640
  %_p_scalar_93.10 = load i32, ptr %scevgep92.10, align 4, !alias.scope !473, !noalias !476
  %scevgep96.10 = getelementptr i8, ptr %scevgep95, i64 640
  store i32 %_p_scalar_93.10, ptr %scevgep96.10, align 4, !alias.scope !479, !noalias !480
  %scevgep92.11 = getelementptr i8, ptr %scevgep91, i64 704
  %_p_scalar_93.11 = load i32, ptr %scevgep92.11, align 4, !alias.scope !473, !noalias !476
  %scevgep96.11 = getelementptr i8, ptr %scevgep95, i64 704
  store i32 %_p_scalar_93.11, ptr %scevgep96.11, align 4, !alias.scope !479, !noalias !480
  %scevgep92.12 = getelementptr i8, ptr %scevgep91, i64 768
  %_p_scalar_93.12 = load i32, ptr %scevgep92.12, align 4, !alias.scope !473, !noalias !476
  %scevgep96.12 = getelementptr i8, ptr %scevgep95, i64 768
  store i32 %_p_scalar_93.12, ptr %scevgep96.12, align 4, !alias.scope !479, !noalias !480
  %scevgep92.13 = getelementptr i8, ptr %scevgep91, i64 832
  %_p_scalar_93.13 = load i32, ptr %scevgep92.13, align 4, !alias.scope !473, !noalias !476
  %scevgep96.13 = getelementptr i8, ptr %scevgep95, i64 832
  store i32 %_p_scalar_93.13, ptr %scevgep96.13, align 4, !alias.scope !479, !noalias !480
  %scevgep92.14 = getelementptr i8, ptr %scevgep91, i64 896
  %_p_scalar_93.14 = load i32, ptr %scevgep92.14, align 4, !alias.scope !473, !noalias !476
  %scevgep96.14 = getelementptr i8, ptr %scevgep95, i64 896
  store i32 %_p_scalar_93.14, ptr %scevgep96.14, align 4, !alias.scope !479, !noalias !480
  %scevgep92.15 = getelementptr i8, ptr %scevgep91, i64 960
  %_p_scalar_93.15 = load i32, ptr %scevgep92.15, align 4, !alias.scope !473, !noalias !476
  %scevgep96.15 = getelementptr i8, ptr %scevgep95, i64 960
  store i32 %_p_scalar_93.15, ptr %scevgep96.15, align 4, !alias.scope !479, !noalias !480
  %scevgep92.16 = getelementptr i8, ptr %scevgep91, i64 1024
  %_p_scalar_93.16 = load i32, ptr %scevgep92.16, align 4, !alias.scope !473, !noalias !476
  %scevgep96.16 = getelementptr i8, ptr %scevgep95, i64 1024
  store i32 %_p_scalar_93.16, ptr %scevgep96.16, align 4, !alias.scope !479, !noalias !480
  %scevgep92.17 = getelementptr i8, ptr %scevgep91, i64 1088
  %_p_scalar_93.17 = load i32, ptr %scevgep92.17, align 4, !alias.scope !473, !noalias !476
  %scevgep96.17 = getelementptr i8, ptr %scevgep95, i64 1088
  store i32 %_p_scalar_93.17, ptr %scevgep96.17, align 4, !alias.scope !479, !noalias !480
  %scevgep92.18 = getelementptr i8, ptr %scevgep91, i64 1152
  %_p_scalar_93.18 = load i32, ptr %scevgep92.18, align 4, !alias.scope !473, !noalias !476
  %scevgep96.18 = getelementptr i8, ptr %scevgep95, i64 1152
  store i32 %_p_scalar_93.18, ptr %scevgep96.18, align 4, !alias.scope !479, !noalias !480
  %scevgep92.19 = getelementptr i8, ptr %scevgep91, i64 1216
  %_p_scalar_93.19 = load i32, ptr %scevgep92.19, align 4, !alias.scope !473, !noalias !476
  %scevgep96.19 = getelementptr i8, ptr %scevgep95, i64 1216
  store i32 %_p_scalar_93.19, ptr %scevgep96.19, align 4, !alias.scope !479, !noalias !480
  %scevgep92.20 = getelementptr i8, ptr %scevgep91, i64 1280
  %_p_scalar_93.20 = load i32, ptr %scevgep92.20, align 4, !alias.scope !473, !noalias !476
  %scevgep96.20 = getelementptr i8, ptr %scevgep95, i64 1280
  store i32 %_p_scalar_93.20, ptr %scevgep96.20, align 4, !alias.scope !479, !noalias !480
  %scevgep92.21 = getelementptr i8, ptr %scevgep91, i64 1344
  %_p_scalar_93.21 = load i32, ptr %scevgep92.21, align 4, !alias.scope !473, !noalias !476
  %scevgep96.21 = getelementptr i8, ptr %scevgep95, i64 1344
  store i32 %_p_scalar_93.21, ptr %scevgep96.21, align 4, !alias.scope !479, !noalias !480
  %scevgep92.22 = getelementptr i8, ptr %scevgep91, i64 1408
  %_p_scalar_93.22 = load i32, ptr %scevgep92.22, align 4, !alias.scope !473, !noalias !476
  %scevgep96.22 = getelementptr i8, ptr %scevgep95, i64 1408
  store i32 %_p_scalar_93.22, ptr %scevgep96.22, align 4, !alias.scope !479, !noalias !480
  %scevgep92.23 = getelementptr i8, ptr %scevgep91, i64 1472
  %_p_scalar_93.23 = load i32, ptr %scevgep92.23, align 4, !alias.scope !473, !noalias !476
  %scevgep96.23 = getelementptr i8, ptr %scevgep95, i64 1472
  store i32 %_p_scalar_93.23, ptr %scevgep96.23, align 4, !alias.scope !479, !noalias !480
  %scevgep92.24 = getelementptr i8, ptr %scevgep91, i64 1536
  %_p_scalar_93.24 = load i32, ptr %scevgep92.24, align 4, !alias.scope !473, !noalias !476
  %scevgep96.24 = getelementptr i8, ptr %scevgep95, i64 1536
  store i32 %_p_scalar_93.24, ptr %scevgep96.24, align 4, !alias.scope !479, !noalias !480
  %scevgep92.25 = getelementptr i8, ptr %scevgep91, i64 1600
  %_p_scalar_93.25 = load i32, ptr %scevgep92.25, align 4, !alias.scope !473, !noalias !476
  %scevgep96.25 = getelementptr i8, ptr %scevgep95, i64 1600
  store i32 %_p_scalar_93.25, ptr %scevgep96.25, align 4, !alias.scope !479, !noalias !480
  %scevgep92.26 = getelementptr i8, ptr %scevgep91, i64 1664
  %_p_scalar_93.26 = load i32, ptr %scevgep92.26, align 4, !alias.scope !473, !noalias !476
  %scevgep96.26 = getelementptr i8, ptr %scevgep95, i64 1664
  store i32 %_p_scalar_93.26, ptr %scevgep96.26, align 4, !alias.scope !479, !noalias !480
  %scevgep92.27 = getelementptr i8, ptr %scevgep91, i64 1728
  %_p_scalar_93.27 = load i32, ptr %scevgep92.27, align 4, !alias.scope !473, !noalias !476
  %scevgep96.27 = getelementptr i8, ptr %scevgep95, i64 1728
  store i32 %_p_scalar_93.27, ptr %scevgep96.27, align 4, !alias.scope !479, !noalias !480
  %scevgep92.28 = getelementptr i8, ptr %scevgep91, i64 1792
  %_p_scalar_93.28 = load i32, ptr %scevgep92.28, align 4, !alias.scope !473, !noalias !476
  %scevgep96.28 = getelementptr i8, ptr %scevgep95, i64 1792
  store i32 %_p_scalar_93.28, ptr %scevgep96.28, align 4, !alias.scope !479, !noalias !480
  %scevgep92.29 = getelementptr i8, ptr %scevgep91, i64 1856
  %_p_scalar_93.29 = load i32, ptr %scevgep92.29, align 4, !alias.scope !473, !noalias !476
  %scevgep96.29 = getelementptr i8, ptr %scevgep95, i64 1856
  store i32 %_p_scalar_93.29, ptr %scevgep96.29, align 4, !alias.scope !479, !noalias !480
  %polly.indvar_next81 = add nuw nsw i64 %polly.indvar80.reg2mem.0.load, 1
  %exitcond106.not = icmp eq i64 %polly.indvar_next81, 30
  br i1 %exitcond106.not, label %polly.loop_preheader84.for.end175_crit_edge, label %polly.loop_preheader84.polly.loop_preheader84_crit_edge

polly.loop_preheader84.polly.loop_preheader84_crit_edge: ; preds = %polly.loop_preheader84
  store i64 %polly.indvar_next81, ptr %polly.indvar80.reg2mem, align 8
  br label %polly.loop_preheader84

polly.loop_preheader84.for.end175_crit_edge:      ; preds = %polly.loop_preheader84
  br label %for.end175
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #1 !dbg !481 {
entry.split:
    #dbg_value(ptr %vargs, !485, !DIExpression(), !487)
    #dbg_value(ptr %vargs, !486, !DIExpression(), !487)
  %orig = getelementptr inbounds i8, ptr %vargs, i64 8, !dbg !488
  %sol = getelementptr inbounds i8, ptr %vargs, i64 65544, !dbg !489
  tail call void @stencil(ptr noundef %vargs, ptr noundef nonnull %orig, ptr noundef nonnull %sol) #17, !dbg !490
  ret void, !dbg !491
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #2 !dbg !492 {
entry.split:
  %s.addr.0.lcssa.ph.i14.reg2mem = alloca ptr, align 8
  %cmp23.not.i13.reg2mem = alloca i64, align 8
  %i.1.i8.reg2mem62 = alloca i32, align 4
  %s.addr.040.i3.reg2mem64 = alloca ptr, align 8
  %i.041.i2.reg2mem66 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem68 = alloca i32, align 4
  %s.addr.040.i.reg2mem70 = alloca ptr, align 8
  %i.041.i.reg2mem72 = alloca i32, align 4
    #dbg_value(i32 %fd, !496, !DIExpression(), !501)
    #dbg_value(ptr %vdata, !497, !DIExpression(), !501)
    #dbg_value(ptr %vdata, !498, !DIExpression(), !501)
  %call = tail call ptr @readfile(i32 noundef signext %fd) #17, !dbg !502
    #dbg_value(ptr %call, !499, !DIExpression(), !501)
    #dbg_value(ptr %call, !503, !DIExpression(), !510)
    #dbg_value(i32 1, !508, !DIExpression(), !510)
    #dbg_value(i32 0, !509, !DIExpression(), !510)
  store ptr %call, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 0, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem72.0.load, !509, !DIExpression(), !510)
    #dbg_value(ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, !503, !DIExpression(), !510)
  %i.041.i.reg2mem72.0.load = load i32, ptr %i.041.i.reg2mem72, align 4
  %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71 = load ptr, ptr %s.addr.040.i.reg2mem70, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, align 1, !dbg !512, !tbaa !513
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !514

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !514

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !514

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !515
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !515, !tbaa !513
  %cmp13.i = icmp eq i8 %1, 37, !dbg !518
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !519

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !519

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 2, !dbg !520
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !520, !tbaa !513
  %cmp18.i = icmp eq i8 %2, 10, !dbg !521
  %inc.i = zext i1 %cmp18.i to i32, !dbg !522
  %spec.select.i = add nsw i32 %i.041.i.reg2mem72.0.load, %inc.i, !dbg !522
  store i32 %spec.select.i, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !522

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem68.0.load, !509, !DIExpression(), !510)
  %i.1.i.reg2mem68.0.load = load i32, ptr %i.1.i.reg2mem68, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !523
    #dbg_value(ptr %incdec.ptr.i, !503, !DIExpression(), !510)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem68.0.load, 1, !dbg !524
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !525, !llvm.loop !526

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 %i.1.i.reg2mem68.0.load, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i, !dbg !525

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !528, !tbaa !513
  %3 = icmp eq i8 %.pre.i, 0, !dbg !530
  %4 = select i1 %3, i64 0, i64 2, !dbg !531
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !525

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !531
    #dbg_value(ptr %spec.select38.i, !500, !DIExpression(), !501)
  %call2 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 2) #17, !dbg !532
    #dbg_value(ptr %call, !503, !DIExpression(), !533)
    #dbg_value(i32 2, !508, !DIExpression(), !533)
    #dbg_value(i32 0, !509, !DIExpression(), !533)
  store ptr %call, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 0, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem66.0.load, !509, !DIExpression(), !533)
    #dbg_value(ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, !503, !DIExpression(), !533)
  %i.041.i2.reg2mem66.0.load = load i32, ptr %i.041.i2.reg2mem66, align 4
  %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65 = load ptr, ptr %s.addr.040.i3.reg2mem64, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, align 1, !dbg !535, !tbaa !513
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !536

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !536

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !536

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !537
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !537, !tbaa !513
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !538
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !539

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !539

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 2, !dbg !540
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !540, !tbaa !513
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !541
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !542
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem66.0.load, %inc.i19, !dbg !542
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !542

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem62.0.load, !509, !DIExpression(), !533)
  %i.1.i8.reg2mem62.0.load = load i32, ptr %i.1.i8.reg2mem62, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !543
    #dbg_value(ptr %incdec.ptr.i9, !503, !DIExpression(), !533)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem62.0.load, 2, !dbg !544
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !545, !llvm.loop !546

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 %i.1.i8.reg2mem62.0.load, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1, !dbg !545

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !548, !tbaa !513
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !549
  %9 = select i1 %8, i64 0, i64 2, !dbg !550
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !545

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !550
    #dbg_value(ptr %spec.select38.i15, !500, !DIExpression(), !501)
  %orig = getelementptr inbounds i8, ptr %vdata, i64 8, !dbg !551
  %call5 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %orig, i32 noundef signext 16384) #17, !dbg !552
  tail call void @free(ptr noundef %call) #17, !dbg !553
  ret void, !dbg !554
}

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !555 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #2 !dbg !557 {
entry.split:
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !559, !DIExpression(), !562)
    #dbg_value(ptr %vdata, !560, !DIExpression(), !562)
    #dbg_value(ptr %vdata, !561, !DIExpression(), !562)
    #dbg_value(i32 %fd, !563, !DIExpression(), !568)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !570
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !570

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #18, !dbg !570
  unreachable, !dbg !570

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !573
    #dbg_value(i32 %fd, !574, !DIExpression(), !582)
    #dbg_value(ptr %vdata, !579, !DIExpression(), !582)
    #dbg_value(i32 2, !580, !DIExpression(), !582)
    #dbg_value(i32 0, !581, !DIExpression(), !582)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !584

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !581, !DIExpression(), !582)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i32, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !586
  %0 = load i32, ptr %arrayidx.i, align 4, !dbg !586, !tbaa !374
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !586
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !589
    #dbg_value(i64 %indvars.iv.next.i, !581, !DIExpression(), !582)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 2, !dbg !589
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !584, !llvm.loop !590

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !584

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !563, !DIExpression(), !591)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !593
  %orig = getelementptr inbounds i8, ptr %vdata, i64 8, !dbg !594
    #dbg_value(i32 %fd, !574, !DIExpression(), !595)
    #dbg_value(ptr %orig, !579, !DIExpression(), !595)
    #dbg_value(i32 16384, !580, !DIExpression(), !595)
    #dbg_value(i32 0, !581, !DIExpression(), !595)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !597

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !581, !DIExpression(), !595)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds i32, ptr %orig, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !598
  %1 = load i32, ptr %arrayidx.i11, align 4, !dbg !598, !tbaa !374
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %1), !dbg !598
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !599
    #dbg_value(i64 %indvars.iv.next.i12, !581, !DIExpression(), !595)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 16384, !dbg !599
  br i1 %exitcond.not.i13, label %write_int32_t_array.exit14, label %for.body.i9.for.body.i9_crit_edge, !dbg !597, !llvm.loop !600

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !597

write_int32_t_array.exit14:                       ; preds = %for.body.i9
  ret void, !dbg !601
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #2 !dbg !602 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !604, !DIExpression(), !609)
    #dbg_value(ptr %vdata, !605, !DIExpression(), !609)
    #dbg_value(ptr %vdata, !606, !DIExpression(), !609)
  %call = tail call ptr @readfile(i32 noundef signext %fd) #17, !dbg !610
    #dbg_value(ptr %call, !607, !DIExpression(), !609)
    #dbg_value(ptr %call, !503, !DIExpression(), !611)
    #dbg_value(i32 1, !508, !DIExpression(), !611)
    #dbg_value(i32 0, !509, !DIExpression(), !611)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !509, !DIExpression(), !611)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !503, !DIExpression(), !611)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !613, !tbaa !513
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !614

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !614

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !614

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !615
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !615, !tbaa !513
  %cmp13.i = icmp eq i8 %1, 37, !dbg !616
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !617

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !617

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !618
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !618, !tbaa !513
  %cmp18.i = icmp eq i8 %2, 10, !dbg !619
  %inc.i = zext i1 %cmp18.i to i32, !dbg !620
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !620
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !620

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !509, !DIExpression(), !611)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !621
    #dbg_value(ptr %incdec.ptr.i, !503, !DIExpression(), !611)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !622
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !623, !llvm.loop !624

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !623

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !626, !tbaa !513
  %3 = icmp eq i8 %.pre.i, 0, !dbg !627
  %4 = select i1 %3, i64 0, i64 2, !dbg !628
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !623

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !628
    #dbg_value(ptr %spec.select38.i, !608, !DIExpression(), !609)
  %sol = getelementptr inbounds i8, ptr %vdata, i64 65544, !dbg !629
  %call2 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %sol, i32 noundef signext 16384) #17, !dbg !630
  tail call void @free(ptr noundef %call) #17, !dbg !631
  ret void, !dbg !632
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #2 !dbg !633 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !635, !DIExpression(), !638)
    #dbg_value(ptr %vdata, !636, !DIExpression(), !638)
    #dbg_value(ptr %vdata, !637, !DIExpression(), !638)
    #dbg_value(i32 %fd, !563, !DIExpression(), !639)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !641
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !641

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #18, !dbg !641
  unreachable, !dbg !641

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !642
  %sol = getelementptr inbounds i8, ptr %vdata, i64 65544, !dbg !643
    #dbg_value(i32 %fd, !574, !DIExpression(), !644)
    #dbg_value(ptr %sol, !579, !DIExpression(), !644)
    #dbg_value(i32 16384, !580, !DIExpression(), !644)
    #dbg_value(i32 0, !581, !DIExpression(), !644)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !646

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !581, !DIExpression(), !644)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i32, ptr %sol, i64 %indvars.iv.i.reg2mem.0.load, !dbg !647
  %0 = load i32, ptr %arrayidx.i, align 4, !dbg !647, !tbaa !374
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !647
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !648
    #dbg_value(i64 %indvars.iv.next.i, !581, !DIExpression(), !644)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 16384, !dbg !648
  br i1 %exitcond.not.i, label %write_int32_t_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !646, !llvm.loop !649

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !646

write_int32_t_array.exit:                         ; preds = %for.body.i
  ret void, !dbg !650
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #4 !dbg !651 {
entry.split:
  %has_errors.015.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(ptr %vdata, !655, !DIExpression(), !662)
    #dbg_value(ptr %vref, !656, !DIExpression(), !662)
    #dbg_value(ptr %vdata, !657, !DIExpression(), !662)
    #dbg_value(ptr %vref, !658, !DIExpression(), !662)
    #dbg_value(i32 0, !659, !DIExpression(), !662)
    #dbg_value(i32 0, !660, !DIExpression(), !662)
  store i32 0, ptr %has_errors.015.reg2mem, align 4
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !663

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i32 %has_errors.015.reg2mem.0.load, !659, !DIExpression(), !662)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !660, !DIExpression(), !662)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %has_errors.015.reg2mem.0.load = load i32, ptr %has_errors.015.reg2mem, align 4
  %arrayidx = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 2, i64 %indvars.iv.reg2mem.0.load, !dbg !665
  %0 = load i32, ptr %arrayidx, align 4, !dbg !665, !tbaa !374
  %arrayidx3 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 2, i64 %indvars.iv.reg2mem.0.load, !dbg !668
  %1 = load i32, ptr %arrayidx3, align 4, !dbg !668, !tbaa !374
    #dbg_value(!DIArgList(i32 %0, i32 %1), !661, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_minus, DW_OP_stack_value), !662)
  %2 = icmp ne i32 %0, %1, !dbg !669
  %lor.ext = zext i1 %2 to i32, !dbg !669
  %or = or i32 %has_errors.015.reg2mem.0.load, %lor.ext, !dbg !670
    #dbg_value(i32 %or, !659, !DIExpression(), !662)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !671
    #dbg_value(i64 %indvars.iv.next, !660, !DIExpression(), !662)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 16384, !dbg !672
  br i1 %exitcond.not, label %for.end, label %for.body.for.body_crit_edge, !dbg !663, !llvm.loop !673

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i32 %or, ptr %has_errors.015.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !663

for.end:                                          ; preds = %for.body
  %tobool.not = icmp eq i32 %or, 0, !dbg !675
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !675
  ret i32 %lnot.ext, !dbg !676
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #2 !dbg !677 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !727
    #dbg_assign(i1 undef, !683, !DIExpression(), !727, ptr %s, !DIExpression(), !728)
    #dbg_value(i32 %fd, !681, !DIExpression(), !728)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #17, !dbg !729
  %cmp = icmp sgt i32 %fd, 1, !dbg !730
  br i1 %cmp, label %if.end, label %if.else, !dbg !730

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #18, !dbg !730
  unreachable, !dbg !730

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #17, !dbg !733
  %cmp1 = icmp eq i32 %call, 0, !dbg !733
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !733

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #18, !dbg !733
  unreachable, !dbg !733

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !736
  %0 = load i64, ptr %st_size, align 8, !dbg !736
    #dbg_value(i64 %0, !720, !DIExpression(), !728)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !737
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !737

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #18, !dbg !737
  unreachable, !dbg !737

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !740
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #19, !dbg !741
    #dbg_value(ptr %call11, !682, !DIExpression(), !728)
    #dbg_value(i64 0, !723, !DIExpression(), !728)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !742

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !743
    #dbg_value(i64 %add19, !723, !DIExpression(), !728)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !745
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !742, !llvm.loop !746

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !742

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !723, !DIExpression(), !728)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !748
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !749
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #17, !dbg !750
    #dbg_value(i64 %call13, !726, !DIExpression(), !728)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !751
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !723, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !728)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !751

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #18, !dbg !751
  unreachable, !dbg !751

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !754
  store i8 0, ptr %arrayidx20, align 1, !dbg !755, !tbaa !513
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #17, !dbg !756
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #17, !dbg !757
  ret ptr %call11, !dbg !758
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: noreturn nounwind
declare !dbg !759 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare !dbg !764 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !769 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #8

; Function Attrs: nofree
declare !dbg !774 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #9

declare !dbg !778 signext i32 @close(i32 noundef signext) local_unnamed_addr #10

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #2 !dbg !504 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !503, !DIExpression(), !779)
    #dbg_value(i32 %n, !508, !DIExpression(), !779)
    #dbg_value(i32 0, !509, !DIExpression(), !779)
  %cmp = icmp sgt i32 %n, -1, !dbg !780
  br i1 %cmp, label %if.end, label %if.else, !dbg !780

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #18, !dbg !780
  unreachable, !dbg !780

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !783
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !785

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !785

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !785

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !509, !DIExpression(), !779)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !503, !DIExpression(), !779)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !786, !tbaa !513
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !787

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !787

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !787

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !788
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !788, !tbaa !513
  %cmp13 = icmp eq i8 %1, 37, !dbg !789
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !790

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !790

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !791
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !791, !tbaa !513
  %cmp18 = icmp eq i8 %2, 10, !dbg !792
  %inc = zext i1 %cmp18 to i32, !dbg !793
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !793
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !793

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !509, !DIExpression(), !779)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !794
    #dbg_value(ptr %incdec.ptr, !503, !DIExpression(), !779)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !795
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !796, !llvm.loop !797

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !796

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !799, !tbaa !513
  %3 = icmp eq i8 %.pre, 0, !dbg !800
  %4 = select i1 %3, i64 0, i64 2, !dbg !801
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !796

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !801
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !801

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !802
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !803 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !807, !DIExpression(), !811)
    #dbg_value(ptr %arr, !808, !DIExpression(), !811)
    #dbg_value(i32 %n, !809, !DIExpression(), !811)
  %cmp.not = icmp eq ptr %s, null, !dbg !812
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !812

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #18, !dbg !812
  unreachable, !dbg !812

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !815
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !817

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !818
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !820
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !820

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !810, !DIExpression(), !811)
  %conv404 = zext nneg i32 %n to i64, !dbg !821
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !822
  br label %if.end46, !dbg !823

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !810, !DIExpression(), !811)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !824
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !825

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !825

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !826
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !827
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !827
  %cmp9.not = icmp eq i8 %0, 0, !dbg !828
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !829

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !829

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !830
  %1 = load i8, ptr %gep, align 1, !dbg !830
  %cmp16.not = icmp eq i8 %1, 0, !dbg !831
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !832

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !832

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !833
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !834
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !834
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !834, !llvm.loop !835

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !834

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !821

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !821

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !821

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !821
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !810, !DIExpression(), !811)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !822
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !837
  store i8 0, ptr %arrayidx45, align 1, !dbg !839, !tbaa !513
  br label %if.end46, !dbg !837

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !840
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #11

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !841 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !853
    #dbg_assign(i1 undef, !850, !DIExpression(), !853, ptr %endptr, !DIExpression(), !854)
    #dbg_value(ptr %s, !846, !DIExpression(), !854)
    #dbg_value(ptr %arr, !847, !DIExpression(), !854)
    #dbg_value(i32 %n, !848, !DIExpression(), !854)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !855
    #dbg_value(i32 0, !851, !DIExpression(), !854)
  %cmp.not = icmp eq ptr %s, null, !dbg !856
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !856

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #18, !dbg !856
  unreachable, !dbg !856

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !855
    #dbg_value(ptr %call, !849, !DIExpression(), !854)
    #dbg_value(i32 0, !851, !DIExpression(), !854)
  %cmp130 = icmp ne ptr %call, null, !dbg !855
  %cmp231 = icmp sgt i32 %n, 0, !dbg !855
  %0 = and i1 %cmp231, %cmp130, !dbg !855
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !855

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !855

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !855
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !855

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !849, !DIExpression(), !854)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !851, !DIExpression(), !854)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !859, !tbaa !861, !DIAssignID !863
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !850, !DIExpression(), !863, ptr %endptr, !DIExpression(), !854)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !859
  %conv = trunc i64 %call3 to i8, !dbg !859
    #dbg_value(i8 %conv, !852, !DIExpression(), !854)
  %2 = load ptr, ptr %endptr, align 8, !dbg !864, !tbaa !861
  %3 = load i8, ptr %2, align 1, !dbg !864, !tbaa !513
  %cmp5.not = icmp eq i8 %3, 0, !dbg !864
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !859

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !859

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !866, !tbaa !861
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !866
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !866
  br label %if.end9, !dbg !866

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !859
  store i8 %conv, ptr %arrayidx, align 1, !dbg !859, !tbaa !513
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !859
    #dbg_value(i64 %indvars.iv.next, !851, !DIExpression(), !854)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !859
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !859
  store i8 10, ptr %arrayidx11, align 1, !dbg !859, !tbaa !513
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !859
    #dbg_value(ptr %call12, !849, !DIExpression(), !854)
  %cmp1 = icmp ne ptr %call12, null, !dbg !855
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !855
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !855
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !855, !llvm.loop !868

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !855

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !855

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !855

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !855

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !869
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !869
  store i8 10, ptr %arrayidx17, align 1, !dbg !869, !tbaa !513
  br label %if.end18, !dbg !869

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !855
  ret i32 0, !dbg !855
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !872 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #12

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !878 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #12

; Function Attrs: nofree nounwind
declare !dbg !883 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !938 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !941 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !953
    #dbg_assign(i1 undef, !950, !DIExpression(), !953, ptr %endptr, !DIExpression(), !954)
    #dbg_value(ptr %s, !946, !DIExpression(), !954)
    #dbg_value(ptr %arr, !947, !DIExpression(), !954)
    #dbg_value(i32 %n, !948, !DIExpression(), !954)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !955
    #dbg_value(i32 0, !951, !DIExpression(), !954)
  %cmp.not = icmp eq ptr %s, null, !dbg !956
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !956

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #18, !dbg !956
  unreachable, !dbg !956

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !955
    #dbg_value(ptr %call, !949, !DIExpression(), !954)
    #dbg_value(i32 0, !951, !DIExpression(), !954)
  %cmp130 = icmp ne ptr %call, null, !dbg !955
  %cmp231 = icmp sgt i32 %n, 0, !dbg !955
  %0 = and i1 %cmp231, %cmp130, !dbg !955
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !955

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !955

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !955
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !955

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !949, !DIExpression(), !954)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !951, !DIExpression(), !954)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !959, !tbaa !861, !DIAssignID !961
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !950, !DIExpression(), !961, ptr %endptr, !DIExpression(), !954)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !959
  %conv = trunc i64 %call3 to i16, !dbg !959
    #dbg_value(i16 %conv, !952, !DIExpression(), !954)
  %2 = load ptr, ptr %endptr, align 8, !dbg !962, !tbaa !861
  %3 = load i8, ptr %2, align 1, !dbg !962, !tbaa !513
  %cmp5.not = icmp eq i8 %3, 0, !dbg !962
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !959

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !959

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !964, !tbaa !861
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !964
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !964
  br label %if.end9, !dbg !964

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !959
  store i16 %conv, ptr %arrayidx, align 2, !dbg !959, !tbaa !966
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !959
    #dbg_value(i64 %indvars.iv.next, !951, !DIExpression(), !954)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !959
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !959
  store i8 10, ptr %arrayidx11, align 1, !dbg !959, !tbaa !513
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !959
    #dbg_value(ptr %call12, !949, !DIExpression(), !954)
  %cmp1 = icmp ne ptr %call12, null, !dbg !955
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !955
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !955
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !955, !llvm.loop !968

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !955

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !955

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !955

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !955

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !969
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !969
  store i8 10, ptr %arrayidx17, align 1, !dbg !969, !tbaa !513
  br label %if.end18, !dbg !969

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !955
  ret i32 0, !dbg !955
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !972 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !984
    #dbg_assign(i1 undef, !981, !DIExpression(), !984, ptr %endptr, !DIExpression(), !985)
    #dbg_value(ptr %s, !977, !DIExpression(), !985)
    #dbg_value(ptr %arr, !978, !DIExpression(), !985)
    #dbg_value(i32 %n, !979, !DIExpression(), !985)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !986
    #dbg_value(i32 0, !982, !DIExpression(), !985)
  %cmp.not = icmp eq ptr %s, null, !dbg !987
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !987

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #18, !dbg !987
  unreachable, !dbg !987

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !986
    #dbg_value(ptr %call, !980, !DIExpression(), !985)
    #dbg_value(i32 0, !982, !DIExpression(), !985)
  %cmp130 = icmp ne ptr %call, null, !dbg !986
  %cmp231 = icmp sgt i32 %n, 0, !dbg !986
  %0 = and i1 %cmp231, %cmp130, !dbg !986
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !986

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !986

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !986
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !986

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !980, !DIExpression(), !985)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !982, !DIExpression(), !985)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !990, !tbaa !861, !DIAssignID !992
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !981, !DIExpression(), !992, ptr %endptr, !DIExpression(), !985)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !990
  %conv = trunc i64 %call3 to i32, !dbg !990
    #dbg_value(i32 %conv, !983, !DIExpression(), !985)
  %2 = load ptr, ptr %endptr, align 8, !dbg !993, !tbaa !861
  %3 = load i8, ptr %2, align 1, !dbg !993, !tbaa !513
  %cmp5.not = icmp eq i8 %3, 0, !dbg !993
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !990

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !990

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !995, !tbaa !861
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !995
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !995
  br label %if.end9, !dbg !995

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !990
  store i32 %conv, ptr %arrayidx, align 4, !dbg !990, !tbaa !374
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !990
    #dbg_value(i64 %indvars.iv.next, !982, !DIExpression(), !985)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !990
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !990
  store i8 10, ptr %arrayidx11, align 1, !dbg !990, !tbaa !513
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !990
    #dbg_value(ptr %call12, !980, !DIExpression(), !985)
  %cmp1 = icmp ne ptr %call12, null, !dbg !986
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !986
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !986
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !986, !llvm.loop !997

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !986

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !986

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !986

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !986

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !998
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !998
  store i8 10, ptr %arrayidx17, align 1, !dbg !998, !tbaa !513
  br label %if.end18, !dbg !998

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !986
  ret i32 0, !dbg !986
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1001 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1013
    #dbg_assign(i1 undef, !1010, !DIExpression(), !1013, ptr %endptr, !DIExpression(), !1014)
    #dbg_value(ptr %s, !1006, !DIExpression(), !1014)
    #dbg_value(ptr %arr, !1007, !DIExpression(), !1014)
    #dbg_value(i32 %n, !1008, !DIExpression(), !1014)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1015
    #dbg_value(i32 0, !1011, !DIExpression(), !1014)
  %cmp.not = icmp eq ptr %s, null, !dbg !1016
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1016

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #18, !dbg !1016
  unreachable, !dbg !1016

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1015
    #dbg_value(ptr %call, !1009, !DIExpression(), !1014)
    #dbg_value(i32 0, !1011, !DIExpression(), !1014)
  %cmp129 = icmp ne ptr %call, null, !dbg !1015
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1015
  %0 = and i1 %cmp230, %cmp129, !dbg !1015
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1015

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1015

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1015
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1015

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1009, !DIExpression(), !1014)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1011, !DIExpression(), !1014)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1019, !tbaa !861, !DIAssignID !1021
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1010, !DIExpression(), !1021, ptr %endptr, !DIExpression(), !1014)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1019
    #dbg_value(i64 %call3, !1012, !DIExpression(), !1014)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1022, !tbaa !861
  %3 = load i8, ptr %2, align 1, !dbg !1022, !tbaa !513
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1022
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1019

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1019

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1024, !tbaa !861
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1024
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1024
  br label %if.end8, !dbg !1024

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1019
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1019, !tbaa !1026
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1019
    #dbg_value(i64 %indvars.iv.next, !1011, !DIExpression(), !1014)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1019
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1019
  store i8 10, ptr %arrayidx10, align 1, !dbg !1019, !tbaa !513
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1019
    #dbg_value(ptr %call11, !1009, !DIExpression(), !1014)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1015
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1015
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1015
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1015, !llvm.loop !1028

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1015

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1015

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1015

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1015

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1029
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1029
  store i8 10, ptr %arrayidx16, align 1, !dbg !1029, !tbaa !513
  br label %if.end17, !dbg !1029

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1015
  ret i32 0, !dbg !1015
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1032 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1044
    #dbg_assign(i1 undef, !1041, !DIExpression(), !1044, ptr %endptr, !DIExpression(), !1045)
    #dbg_value(ptr %s, !1037, !DIExpression(), !1045)
    #dbg_value(ptr %arr, !1038, !DIExpression(), !1045)
    #dbg_value(i32 %n, !1039, !DIExpression(), !1045)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1046
    #dbg_value(i32 0, !1042, !DIExpression(), !1045)
  %cmp.not = icmp eq ptr %s, null, !dbg !1047
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1047

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #18, !dbg !1047
  unreachable, !dbg !1047

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1046
    #dbg_value(ptr %call, !1040, !DIExpression(), !1045)
    #dbg_value(i32 0, !1042, !DIExpression(), !1045)
  %cmp130 = icmp ne ptr %call, null, !dbg !1046
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1046
  %0 = and i1 %cmp231, %cmp130, !dbg !1046
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1046

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1046

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1046
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1046

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1040, !DIExpression(), !1045)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1042, !DIExpression(), !1045)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1050, !tbaa !861, !DIAssignID !1052
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1041, !DIExpression(), !1052, ptr %endptr, !DIExpression(), !1045)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1050
  %conv = trunc i64 %call3 to i8, !dbg !1050
    #dbg_value(i8 %conv, !1043, !DIExpression(), !1045)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1053, !tbaa !861
  %3 = load i8, ptr %2, align 1, !dbg !1053, !tbaa !513
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1053
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1050

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1050

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1055, !tbaa !861
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1055
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1055
  br label %if.end9, !dbg !1055

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1050
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1050, !tbaa !513
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1050
    #dbg_value(i64 %indvars.iv.next, !1042, !DIExpression(), !1045)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1050
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1050
  store i8 10, ptr %arrayidx11, align 1, !dbg !1050, !tbaa !513
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1050
    #dbg_value(ptr %call12, !1040, !DIExpression(), !1045)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1046
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1046
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1046
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1046, !llvm.loop !1057

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1046

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1046

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1046

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1046

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1058
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1058
  store i8 10, ptr %arrayidx17, align 1, !dbg !1058, !tbaa !513
  br label %if.end18, !dbg !1058

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1046
  ret i32 0, !dbg !1046
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1061 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1073
    #dbg_assign(i1 undef, !1070, !DIExpression(), !1073, ptr %endptr, !DIExpression(), !1074)
    #dbg_value(ptr %s, !1066, !DIExpression(), !1074)
    #dbg_value(ptr %arr, !1067, !DIExpression(), !1074)
    #dbg_value(i32 %n, !1068, !DIExpression(), !1074)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1075
    #dbg_value(i32 0, !1071, !DIExpression(), !1074)
  %cmp.not = icmp eq ptr %s, null, !dbg !1076
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1076

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #18, !dbg !1076
  unreachable, !dbg !1076

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1075
    #dbg_value(ptr %call, !1069, !DIExpression(), !1074)
    #dbg_value(i32 0, !1071, !DIExpression(), !1074)
  %cmp130 = icmp ne ptr %call, null, !dbg !1075
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1075
  %0 = and i1 %cmp231, %cmp130, !dbg !1075
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1075

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1075

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1075
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1075

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1069, !DIExpression(), !1074)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1071, !DIExpression(), !1074)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1079, !tbaa !861, !DIAssignID !1081
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1070, !DIExpression(), !1081, ptr %endptr, !DIExpression(), !1074)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1079
  %conv = trunc i64 %call3 to i16, !dbg !1079
    #dbg_value(i16 %conv, !1072, !DIExpression(), !1074)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1082, !tbaa !861
  %3 = load i8, ptr %2, align 1, !dbg !1082, !tbaa !513
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1082
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1079

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1079

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1084, !tbaa !861
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1084
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1084
  br label %if.end9, !dbg !1084

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1079
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1079, !tbaa !966
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1079
    #dbg_value(i64 %indvars.iv.next, !1071, !DIExpression(), !1074)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1079
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1079
  store i8 10, ptr %arrayidx11, align 1, !dbg !1079, !tbaa !513
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1079
    #dbg_value(ptr %call12, !1069, !DIExpression(), !1074)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1075
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1075
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1075
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1075, !llvm.loop !1086

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1075

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1075

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1075

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1075

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1087
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1087
  store i8 10, ptr %arrayidx17, align 1, !dbg !1087, !tbaa !513
  br label %if.end18, !dbg !1087

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1075
  ret i32 0, !dbg !1075
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1090 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1101
    #dbg_assign(i1 undef, !1098, !DIExpression(), !1101, ptr %endptr, !DIExpression(), !1102)
    #dbg_value(ptr %s, !1094, !DIExpression(), !1102)
    #dbg_value(ptr %arr, !1095, !DIExpression(), !1102)
    #dbg_value(i32 %n, !1096, !DIExpression(), !1102)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1103
    #dbg_value(i32 0, !1099, !DIExpression(), !1102)
  %cmp.not = icmp eq ptr %s, null, !dbg !1104
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1104

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #18, !dbg !1104
  unreachable, !dbg !1104

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1103
    #dbg_value(ptr %call, !1097, !DIExpression(), !1102)
    #dbg_value(i32 0, !1099, !DIExpression(), !1102)
  %cmp130 = icmp ne ptr %call, null, !dbg !1103
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1103
  %0 = and i1 %cmp231, %cmp130, !dbg !1103
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1103

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1103

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1103
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1103

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1097, !DIExpression(), !1102)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1099, !DIExpression(), !1102)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1107, !tbaa !861, !DIAssignID !1109
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1098, !DIExpression(), !1109, ptr %endptr, !DIExpression(), !1102)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1107
  %conv = trunc i64 %call3 to i32, !dbg !1107
    #dbg_value(i32 %conv, !1100, !DIExpression(), !1102)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1110, !tbaa !861
  %3 = load i8, ptr %2, align 1, !dbg !1110, !tbaa !513
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1110
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1107

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1107

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1112, !tbaa !861
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1112
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1112
  br label %if.end9, !dbg !1112

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1107
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1107, !tbaa !374
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1107
    #dbg_value(i64 %indvars.iv.next, !1099, !DIExpression(), !1102)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1107
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1107
  store i8 10, ptr %arrayidx11, align 1, !dbg !1107, !tbaa !513
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1107
    #dbg_value(ptr %call12, !1097, !DIExpression(), !1102)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1103
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1103
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1103
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1103, !llvm.loop !1114

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1103

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1103

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1103

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1103

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1115
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1115
  store i8 10, ptr %arrayidx17, align 1, !dbg !1115, !tbaa !513
  br label %if.end18, !dbg !1115

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1103
  ret i32 0, !dbg !1103
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1118 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1130
    #dbg_assign(i1 undef, !1127, !DIExpression(), !1130, ptr %endptr, !DIExpression(), !1131)
    #dbg_value(ptr %s, !1123, !DIExpression(), !1131)
    #dbg_value(ptr %arr, !1124, !DIExpression(), !1131)
    #dbg_value(i32 %n, !1125, !DIExpression(), !1131)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1132
    #dbg_value(i32 0, !1128, !DIExpression(), !1131)
  %cmp.not = icmp eq ptr %s, null, !dbg !1133
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1133

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #18, !dbg !1133
  unreachable, !dbg !1133

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1132
    #dbg_value(ptr %call, !1126, !DIExpression(), !1131)
    #dbg_value(i32 0, !1128, !DIExpression(), !1131)
  %cmp129 = icmp ne ptr %call, null, !dbg !1132
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1132
  %0 = and i1 %cmp230, %cmp129, !dbg !1132
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1132

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1132

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1132
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1132

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1126, !DIExpression(), !1131)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1128, !DIExpression(), !1131)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1136, !tbaa !861, !DIAssignID !1138
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1127, !DIExpression(), !1138, ptr %endptr, !DIExpression(), !1131)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1136
    #dbg_value(i64 %call3, !1129, !DIExpression(), !1131)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1139, !tbaa !861
  %3 = load i8, ptr %2, align 1, !dbg !1139, !tbaa !513
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1139
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1136

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1136

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1141, !tbaa !861
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1141
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1141
  br label %if.end8, !dbg !1141

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1136
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1136, !tbaa !1026
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1136
    #dbg_value(i64 %indvars.iv.next, !1128, !DIExpression(), !1131)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1136
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1136
  store i8 10, ptr %arrayidx10, align 1, !dbg !1136, !tbaa !513
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1136
    #dbg_value(ptr %call11, !1126, !DIExpression(), !1131)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1132
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1132
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1132
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1132, !llvm.loop !1143

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1132

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1132

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1132

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1132

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1144
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1144
  store i8 10, ptr %arrayidx16, align 1, !dbg !1144, !tbaa !513
  br label %if.end17, !dbg !1144

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1132
  ret i32 0, !dbg !1132
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1147 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1159
    #dbg_assign(i1 undef, !1156, !DIExpression(), !1159, ptr %endptr, !DIExpression(), !1160)
    #dbg_value(ptr %s, !1152, !DIExpression(), !1160)
    #dbg_value(ptr %arr, !1153, !DIExpression(), !1160)
    #dbg_value(i32 %n, !1154, !DIExpression(), !1160)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1161
    #dbg_value(i32 0, !1157, !DIExpression(), !1160)
  %cmp.not = icmp eq ptr %s, null, !dbg !1162
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1162

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #18, !dbg !1162
  unreachable, !dbg !1162

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1161
    #dbg_value(ptr %call, !1155, !DIExpression(), !1160)
    #dbg_value(i32 0, !1157, !DIExpression(), !1160)
  %cmp129 = icmp ne ptr %call, null, !dbg !1161
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1161
  %0 = and i1 %cmp230, %cmp129, !dbg !1161
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1161

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1161

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1161
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1161

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1155, !DIExpression(), !1160)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1157, !DIExpression(), !1160)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1165, !tbaa !861, !DIAssignID !1167
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1156, !DIExpression(), !1167, ptr %endptr, !DIExpression(), !1160)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #17, !dbg !1165
    #dbg_value(float %call3, !1158, !DIExpression(), !1160)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1168, !tbaa !861
  %3 = load i8, ptr %2, align 1, !dbg !1168, !tbaa !513
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1168
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1165

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1165

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1170, !tbaa !861
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1170
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1170
  br label %if.end8, !dbg !1170

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1165
  store float %call3, ptr %arrayidx, align 4, !dbg !1165, !tbaa !1172
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1165
    #dbg_value(i64 %indvars.iv.next, !1157, !DIExpression(), !1160)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1165
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1165
  store i8 10, ptr %arrayidx10, align 1, !dbg !1165, !tbaa !513
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1165
    #dbg_value(ptr %call11, !1155, !DIExpression(), !1160)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1161
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1161
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1161
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1161, !llvm.loop !1174

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1161

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1161

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1161

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1161

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1175
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1175
  store i8 10, ptr %arrayidx16, align 1, !dbg !1175, !tbaa !513
  br label %if.end17, !dbg !1175

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1161
  ret i32 0, !dbg !1161
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1178 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1181 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1193
    #dbg_assign(i1 undef, !1190, !DIExpression(), !1193, ptr %endptr, !DIExpression(), !1194)
    #dbg_value(ptr %s, !1186, !DIExpression(), !1194)
    #dbg_value(ptr %arr, !1187, !DIExpression(), !1194)
    #dbg_value(i32 %n, !1188, !DIExpression(), !1194)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1195
    #dbg_value(i32 0, !1191, !DIExpression(), !1194)
  %cmp.not = icmp eq ptr %s, null, !dbg !1196
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1196

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #18, !dbg !1196
  unreachable, !dbg !1196

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1195
    #dbg_value(ptr %call, !1189, !DIExpression(), !1194)
    #dbg_value(i32 0, !1191, !DIExpression(), !1194)
  %cmp129 = icmp ne ptr %call, null, !dbg !1195
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1195
  %0 = and i1 %cmp230, %cmp129, !dbg !1195
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1195

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1195

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1195
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1195

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1189, !DIExpression(), !1194)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1191, !DIExpression(), !1194)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1199, !tbaa !861, !DIAssignID !1201
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1190, !DIExpression(), !1201, ptr %endptr, !DIExpression(), !1194)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #17, !dbg !1199
    #dbg_value(double %call3, !1192, !DIExpression(), !1194)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1202, !tbaa !861
  %3 = load i8, ptr %2, align 1, !dbg !1202, !tbaa !513
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1202
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1199

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1199

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1204, !tbaa !861
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1204
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1204
  br label %if.end8, !dbg !1204

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1199
  store double %call3, ptr %arrayidx, align 8, !dbg !1199, !tbaa !1206
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1199
    #dbg_value(i64 %indvars.iv.next, !1191, !DIExpression(), !1194)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1199
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1199
  store i8 10, ptr %arrayidx10, align 1, !dbg !1199, !tbaa !513
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1199
    #dbg_value(ptr %call11, !1189, !DIExpression(), !1194)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1195
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1195
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1195
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1195, !llvm.loop !1208

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1195

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1195

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1195

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1195

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1209
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1209
  store i8 10, ptr %arrayidx16, align 1, !dbg !1209, !tbaa !513
  br label %if.end17, !dbg !1209

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1195
  ret i32 0, !dbg !1195
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1212 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1215 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1219, !DIExpression(), !1224)
    #dbg_value(ptr %arr, !1220, !DIExpression(), !1224)
    #dbg_value(i32 %n, !1221, !DIExpression(), !1224)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1225
  br i1 %cmp, label %if.end, label %if.else, !dbg !1225

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #18, !dbg !1225
  unreachable, !dbg !1225

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1228
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1230

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1230

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #21, !dbg !1231
  %conv = trunc i64 %call to i32, !dbg !1231
    #dbg_value(i32 %conv, !1221, !DIExpression(), !1224)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1233

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1221, !DIExpression(), !1224)
    #dbg_value(i32 0, !1223, !DIExpression(), !1224)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1234
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1235

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1235

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1235

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1236

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1237
    #dbg_value(i32 %add, !1223, !DIExpression(), !1224)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1234
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1235, !llvm.loop !1239

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1235

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1235

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1223, !DIExpression(), !1224)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1241
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1241
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1242
  %conv6 = sext i32 %sub to i64, !dbg !1243
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #17, !dbg !1244
  %conv8 = trunc i64 %call7 to i32, !dbg !1244
    #dbg_value(i32 %conv8, !1222, !DIExpression(), !1224)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1245
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1223, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1224)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1245

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #18, !dbg !1245
  unreachable, !dbg !1245

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #17, !dbg !1248
  %conv16 = trunc i64 %call15 to i32, !dbg !1248
    #dbg_value(i32 %conv16, !1222, !DIExpression(), !1224)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1250
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1250

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #18, !dbg !1250
  unreachable, !dbg !1250

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1253
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1254, !llvm.loop !1255

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1254

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1257
}

; Function Attrs: nofree
declare !dbg !1258 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #9

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1263 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1267, !DIExpression(), !1271)
    #dbg_value(ptr %arr, !1268, !DIExpression(), !1271)
    #dbg_value(i32 %n, !1269, !DIExpression(), !1271)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1272
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1272

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1270, !DIExpression(), !1271)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1275
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1278

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1278

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1275
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1278

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #18, !dbg !1272
  unreachable, !dbg !1272

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1270, !DIExpression(), !1271)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1279
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1279, !tbaa !513
  %conv = zext i8 %0 to i32, !dbg !1279
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1279
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1275
    #dbg_value(i64 %indvars.iv.next, !1270, !DIExpression(), !1271)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1275
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1278, !llvm.loop !1281

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1278

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1278

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1282
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #14 !dbg !1283 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1300
    #dbg_assign(i1 undef, !1289, !DIExpression(), !1300, ptr %args, !DIExpression(), !1301)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1302
    #dbg_assign(i1 undef, !1296, !DIExpression(), !1302, ptr %buffer, !DIExpression(), !1301)
    #dbg_value(i32 %fd, !1287, !DIExpression(), !1301)
    #dbg_value(ptr %format, !1288, !DIExpression(), !1301)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #17, !dbg !1303
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #17, !dbg !1304
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1305
  %0 = load ptr, ptr %args, align 8, !dbg !1306, !tbaa !861
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #17, !dbg !1307
    #dbg_value(i32 %call, !1293, !DIExpression(), !1301)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1308
  %cmp = icmp slt i32 %call, 256, !dbg !1309
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1309

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1294, !DIExpression(), !1301)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1312
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1313

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1313

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1313

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #18, !dbg !1309
  unreachable, !dbg !1309

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1314
    #dbg_value(i32 %add, !1294, !DIExpression(), !1301)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1312
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1313, !llvm.loop !1316

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1313

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1313

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1294, !DIExpression(), !1301)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1318
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1318
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1319
  %conv = sext i32 %sub to i64, !dbg !1320
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #17, !dbg !1321
  %conv3 = trunc i64 %call2 to i32, !dbg !1321
    #dbg_value(i32 %conv3, !1295, !DIExpression(), !1301)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1322
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1294, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1301)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1322

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #18, !dbg !1322
  unreachable, !dbg !1322

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1325
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1325

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #18, !dbg !1325
  unreachable, !dbg !1325

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #17, !dbg !1328
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #17, !dbg !1328
  ret void, !dbg !1329
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #15

; Function Attrs: nofree nounwind
declare !dbg !1330 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #7

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1335 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1339, !DIExpression(), !1343)
    #dbg_value(ptr %arr, !1340, !DIExpression(), !1343)
    #dbg_value(i32 %n, !1341, !DIExpression(), !1343)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1344
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1344

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1342, !DIExpression(), !1343)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1347
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1350

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1350

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1347
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1350

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #18, !dbg !1344
  unreachable, !dbg !1344

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1342, !DIExpression(), !1343)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1351
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1351, !tbaa !966
  %conv = zext i16 %0 to i32, !dbg !1351
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1351
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1347
    #dbg_value(i64 %indvars.iv.next, !1342, !DIExpression(), !1343)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1347
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1350, !llvm.loop !1353

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1350

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1350

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1354
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1355 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1359, !DIExpression(), !1363)
    #dbg_value(ptr %arr, !1360, !DIExpression(), !1363)
    #dbg_value(i32 %n, !1361, !DIExpression(), !1363)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1364
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1364

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1362, !DIExpression(), !1363)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1367
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1370

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1370

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1367
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1370

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #18, !dbg !1364
  unreachable, !dbg !1364

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1362, !DIExpression(), !1363)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1371
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1371, !tbaa !374
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1371
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1367
    #dbg_value(i64 %indvars.iv.next, !1362, !DIExpression(), !1363)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1367
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1370, !llvm.loop !1373

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1370

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1370

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1374
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1375 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1379, !DIExpression(), !1383)
    #dbg_value(ptr %arr, !1380, !DIExpression(), !1383)
    #dbg_value(i32 %n, !1381, !DIExpression(), !1383)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1384
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1384

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1382, !DIExpression(), !1383)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1387
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1390

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1390

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1387
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1390

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #18, !dbg !1384
  unreachable, !dbg !1384

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1382, !DIExpression(), !1383)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1391
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1391, !tbaa !1026
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1391
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1387
    #dbg_value(i64 %indvars.iv.next, !1382, !DIExpression(), !1383)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1387
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1390, !llvm.loop !1393

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1390

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1390

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1394
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1395 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1399, !DIExpression(), !1403)
    #dbg_value(ptr %arr, !1400, !DIExpression(), !1403)
    #dbg_value(i32 %n, !1401, !DIExpression(), !1403)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1404
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1404

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1402, !DIExpression(), !1403)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1407
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1410

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1410

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1407
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1410

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #18, !dbg !1404
  unreachable, !dbg !1404

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1402, !DIExpression(), !1403)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1411
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1411, !tbaa !513
  %conv = sext i8 %0 to i32, !dbg !1411
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1411
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1407
    #dbg_value(i64 %indvars.iv.next, !1402, !DIExpression(), !1403)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1407
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1410, !llvm.loop !1413

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1410

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1410

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1414
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1415 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1419, !DIExpression(), !1423)
    #dbg_value(ptr %arr, !1420, !DIExpression(), !1423)
    #dbg_value(i32 %n, !1421, !DIExpression(), !1423)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1424
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1424

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1422, !DIExpression(), !1423)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1427
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1430

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1430

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1427
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1430

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #18, !dbg !1424
  unreachable, !dbg !1424

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1422, !DIExpression(), !1423)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1431
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1431, !tbaa !966
  %conv = sext i16 %0 to i32, !dbg !1431
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1431
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1427
    #dbg_value(i64 %indvars.iv.next, !1422, !DIExpression(), !1423)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1427
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1430, !llvm.loop !1433

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1430

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1430

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1434
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !575 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !574, !DIExpression(), !1435)
    #dbg_value(ptr %arr, !579, !DIExpression(), !1435)
    #dbg_value(i32 %n, !580, !DIExpression(), !1435)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1436
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1436

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !581, !DIExpression(), !1435)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1439
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1440

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1440

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1439
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1440

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #18, !dbg !1436
  unreachable, !dbg !1436

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !581, !DIExpression(), !1435)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1441
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1441, !tbaa !374
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1441
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1439
    #dbg_value(i64 %indvars.iv.next, !581, !DIExpression(), !1435)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1439
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1440, !llvm.loop !1442

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1440

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1440

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1443
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1444 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1448, !DIExpression(), !1452)
    #dbg_value(ptr %arr, !1449, !DIExpression(), !1452)
    #dbg_value(i32 %n, !1450, !DIExpression(), !1452)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1453
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1453

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1451, !DIExpression(), !1452)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1456
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1459

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1459

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1456
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1459

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #18, !dbg !1453
  unreachable, !dbg !1453

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1451, !DIExpression(), !1452)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1460
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1460, !tbaa !1026
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1460
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1456
    #dbg_value(i64 %indvars.iv.next, !1451, !DIExpression(), !1452)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1456
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1459, !llvm.loop !1462

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1459

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1459

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1463
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1464 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1468, !DIExpression(), !1472)
    #dbg_value(ptr %arr, !1469, !DIExpression(), !1472)
    #dbg_value(i32 %n, !1470, !DIExpression(), !1472)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1473
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1473

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1471, !DIExpression(), !1472)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1476
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1479

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1479

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1476
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1479

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #18, !dbg !1473
  unreachable, !dbg !1473

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1471, !DIExpression(), !1472)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1480
  %0 = load float, ptr %arrayidx, align 4, !dbg !1480, !tbaa !1172
  %conv = fpext float %0 to double, !dbg !1480
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1480
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1476
    #dbg_value(i64 %indvars.iv.next, !1471, !DIExpression(), !1472)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1476
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1479, !llvm.loop !1482

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1479

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1479

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1483
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1484 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1488, !DIExpression(), !1492)
    #dbg_value(ptr %arr, !1489, !DIExpression(), !1492)
    #dbg_value(i32 %n, !1490, !DIExpression(), !1492)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1493
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1493

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1491, !DIExpression(), !1492)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1496
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1499

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1499

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1496
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1499

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #18, !dbg !1493
  unreachable, !dbg !1493

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1491, !DIExpression(), !1492)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1500
  %0 = load double, ptr %arrayidx, align 8, !dbg !1500, !tbaa !1206
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1500
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1496
    #dbg_value(i64 %indvars.iv.next, !1491, !DIExpression(), !1492)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1496
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1499, !llvm.loop !1502

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1499

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1499

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1503
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #2 !dbg !564 {
entry.split:
    #dbg_value(i32 %fd, !563, !DIExpression(), !1504)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1505
  br i1 %cmp, label %if.end, label %if.else, !dbg !1505

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #18, !dbg !1505
  unreachable, !dbg !1505

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1506
  ret i32 0, !dbg !1507
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #2 !dbg !1508 {
entry.split:
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.015.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem49 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem51 = alloca ptr, align 8
  %i.041.i.i.reg2mem53 = alloca i32, align 4
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %check_file.0.reg2mem55 = alloca ptr, align 8
  %in_file.05.reg2mem57 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1512, !DIExpression(), !1521)
    #dbg_value(ptr %argv, !1513, !DIExpression(), !1521)
  %cmp = icmp slt i32 %argc, 4, !dbg !1522
  br i1 %cmp, label %if.end, label %if.else, !dbg !1522

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1522
  unreachable, !dbg !1522

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1514, !DIExpression(), !1521)
    #dbg_value(ptr @.str.4.13, !1515, !DIExpression(), !1521)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1525
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1527

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.13, ptr %check_file.0.reg2mem55, align 8
  store ptr @.str.3, ptr %in_file.05.reg2mem57, align 8
  br label %if.end7, !dbg !1527

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1528
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1528
    #dbg_value(ptr %0, !1514, !DIExpression(), !1521)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1529
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1531

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.13, ptr %check_file.0.reg2mem55, align 8
  store ptr %0, ptr %in_file.05.reg2mem57, align 8
  br label %if.end7, !dbg !1531

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1532
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1532
    #dbg_value(ptr %1, !1515, !DIExpression(), !1521)
  store ptr %1, ptr %check_file.0.reg2mem55, align 8
  store ptr %0, ptr %in_file.05.reg2mem57, align 8
  br label %if.end7, !dbg !1533

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem55.0.check_file.0.reload56, !1515, !DIExpression(), !1521)
  %in_file.05.reg2mem57.0.in_file.05.reload58 = load ptr, ptr %in_file.05.reg2mem57, align 8
  %check_file.0.reg2mem55.0.check_file.0.reload56 = load ptr, ptr %check_file.0.reg2mem55, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1534, !tbaa !374
  %conv = sext i32 %2 to i64, !dbg !1534
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #19, !dbg !1535
    #dbg_value(ptr %call, !1517, !DIExpression(), !1521)
  %cmp8.not = icmp eq ptr %call, null, !dbg !1536
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1536

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.14, ptr noundef nonnull @.str.2.12, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1536
  unreachable, !dbg !1536

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.05.reg2mem57.0.in_file.05.reload58, i32 noundef signext 0) #17, !dbg !1539
    #dbg_value(i32 %call14, !1516, !DIExpression(), !1521)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1540
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1540

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.15, ptr noundef nonnull @.str.2.12, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1540
  unreachable, !dbg !1540

if.end20:                                         ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #17, !dbg !1543
    #dbg_value(ptr %call, !485, !DIExpression(), !1544)
    #dbg_value(ptr %call, !486, !DIExpression(), !1544)
  %orig.i = getelementptr inbounds i8, ptr %call, i64 8, !dbg !1546
  %sol.i = getelementptr inbounds i8, ptr %call, i64 65544, !dbg !1547
  tail call void @stencil(ptr noundef nonnull %call, ptr noundef nonnull %orig.i, ptr noundef nonnull %sol.i) #17, !dbg !1548
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #17, !dbg !1549
    #dbg_value(i32 %call21, !1518, !DIExpression(), !1521)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1550
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1550

if.else26:                                        ; preds = %if.end20
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1550
  unreachable, !dbg !1550

if.end27:                                         ; preds = %if.end20
    #dbg_value(i32 %call21, !635, !DIExpression(), !1553)
    #dbg_value(ptr %call, !636, !DIExpression(), !1553)
    #dbg_value(ptr %call, !637, !DIExpression(), !1553)
    #dbg_value(i32 %call21, !563, !DIExpression(), !1555)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1557
  br i1 %cmp.i.i.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1557

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #18, !dbg !1557
  unreachable, !dbg !1557

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1558
    #dbg_value(i32 %call21, !574, !DIExpression(), !1559)
    #dbg_value(ptr %sol.i, !579, !DIExpression(), !1559)
    #dbg_value(i32 16384, !580, !DIExpression(), !1559)
    #dbg_value(i32 0, !581, !DIExpression(), !1559)
  store i64 0, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1561

for.body.i.i:                                     ; preds = %for.body.i.i.for.body.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !581, !DIExpression(), !1559)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %arrayidx.i.i = getelementptr inbounds i32, ptr %sol.i, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !1562
  %3 = load i32, ptr %arrayidx.i.i, align 4, !dbg !1562, !tbaa !374
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.19, i32 noundef signext %3), !dbg !1562
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !1563
    #dbg_value(i64 %indvars.iv.next.i.i, !581, !DIExpression(), !1559)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 16384, !dbg !1563
  br i1 %exitcond.not.i.i, label %data_to_output.exit, label %for.body.i.i.for.body.i.i_crit_edge, !dbg !1561, !llvm.loop !1564

for.body.i.i.for.body.i.i_crit_edge:              ; preds = %for.body.i.i
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1561

data_to_output.exit:                              ; preds = %for.body.i.i
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #17, !dbg !1565
  %4 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1566, !tbaa !374
  %conv29 = sext i32 %4 to i64, !dbg !1566
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #19, !dbg !1567
    #dbg_value(ptr %call30, !1520, !DIExpression(), !1521)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1568
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1568

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.16, ptr noundef nonnull @.str.2.12, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1568
  unreachable, !dbg !1568

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem55.0.check_file.0.reload56, i32 noundef signext 0) #17, !dbg !1571
    #dbg_value(i32 %call37, !1519, !DIExpression(), !1521)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1572
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1572

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.17, ptr noundef nonnull @.str.2.12, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1572
  unreachable, !dbg !1572

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !604, !DIExpression(), !1575)
    #dbg_value(ptr %call30, !605, !DIExpression(), !1575)
    #dbg_value(ptr %call30, !606, !DIExpression(), !1575)
  %call.i = tail call ptr @readfile(i32 noundef signext %call37) #17, !dbg !1577
    #dbg_value(ptr %call.i, !607, !DIExpression(), !1575)
    #dbg_value(ptr %call.i, !503, !DIExpression(), !1578)
    #dbg_value(i32 1, !508, !DIExpression(), !1578)
    #dbg_value(i32 0, !509, !DIExpression(), !1578)
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem51, align 8
  store i32 0, ptr %i.041.i.i.reg2mem53, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i.reg2mem53.0.load, !509, !DIExpression(), !1578)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem51.0.s.addr.040.i.i.reload52, !503, !DIExpression(), !1578)
  %i.041.i.i.reg2mem53.0.load = load i32, ptr %i.041.i.i.reg2mem53, align 4
  %s.addr.040.i.i.reg2mem51.0.s.addr.040.i.i.reload52 = load ptr, ptr %s.addr.040.i.i.reg2mem51, align 8
  %5 = load i8, ptr %s.addr.040.i.i.reg2mem51.0.s.addr.040.i.i.reload52, align 1, !dbg !1580, !tbaa !513
  switch i8 %5, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1581

land.rhs.i.i.output_to_data.exit_crit_edge:       ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem51.0.s.addr.040.i.i.reload52, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1581

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem53.0.load, ptr %i.1.i.i.reg2mem49, align 4
  br label %if.end21.i.i, !dbg !1581

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem51.0.s.addr.040.i.i.reload52, i64 1, !dbg !1582
  %6 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !1582, !tbaa !513
  %cmp13.i.i = icmp eq i8 %6, 37, !dbg !1583
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1584

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem53.0.load, ptr %i.1.i.i.reg2mem49, align 4
  br label %if.end21.i.i, !dbg !1584

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem51.0.s.addr.040.i.i.reload52, i64 2, !dbg !1585
  %7 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1585, !tbaa !513
  %cmp18.i.i = icmp eq i8 %7, 10, !dbg !1586
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1587
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem53.0.load, %inc.i.i, !dbg !1587
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem49, align 4
  br label %if.end21.i.i, !dbg !1587

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem49.0.load, !509, !DIExpression(), !1578)
  %i.1.i.i.reg2mem49.0.load = load i32, ptr %i.1.i.i.reg2mem49, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem51.0.s.addr.040.i.i.reload52, i64 1, !dbg !1588
    #dbg_value(ptr %incdec.ptr.i.i, !503, !DIExpression(), !1578)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem49.0.load, 1, !dbg !1589
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1590, !llvm.loop !1591

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem51, align 8
  store i32 %i.1.i.i.reg2mem49.0.load, ptr %i.041.i.i.reg2mem53, align 4
  br label %land.rhs.i.i, !dbg !1590

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1593, !tbaa !513
  %8 = icmp eq i8 %.pre.i.i, 0, !dbg !1594
  %9 = select i1 %8, i64 0, i64 2, !dbg !1595
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1590

output_to_data.exit:                              ; preds = %land.rhs.i.i.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1595
    #dbg_value(ptr %spec.select38.i.i, !608, !DIExpression(), !1575)
  %sol.i2 = getelementptr inbounds i8, ptr %call30, i64 65544, !dbg !1596
  %call2.i = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i.i, ptr noundef nonnull %sol.i2, i32 noundef signext 16384) #17, !dbg !1597
  tail call void @free(ptr noundef %call.i) #17, !dbg !1598
    #dbg_value(ptr %call, !655, !DIExpression(), !1599)
    #dbg_value(ptr %call30, !656, !DIExpression(), !1599)
    #dbg_value(ptr %call, !657, !DIExpression(), !1599)
    #dbg_value(ptr %call30, !658, !DIExpression(), !1599)
    #dbg_value(i32 0, !659, !DIExpression(), !1599)
    #dbg_value(i32 0, !660, !DIExpression(), !1599)
  store i32 0, ptr %has_errors.015.i.reg2mem, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1602

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %output_to_data.exit
    #dbg_value(i32 %has_errors.015.i.reg2mem.0.load, !659, !DIExpression(), !1599)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !660, !DIExpression(), !1599)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %has_errors.015.i.reg2mem.0.load = load i32, ptr %has_errors.015.i.reg2mem, align 4
  %arrayidx.i = getelementptr inbounds %struct.bench_args_t, ptr %call, i64 0, i32 2, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1603
  %10 = load i32, ptr %arrayidx.i, align 4, !dbg !1603, !tbaa !374
  %arrayidx3.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 2, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1604
  %11 = load i32, ptr %arrayidx3.i, align 4, !dbg !1604, !tbaa !374
    #dbg_value(!DIArgList(i32 %10, i32 %11), !661, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_minus, DW_OP_stack_value), !1599)
  %12 = icmp ne i32 %10, %11, !dbg !1605
  %lor.ext.i = zext i1 %12 to i32, !dbg !1605
  %or.i = or i32 %has_errors.015.i.reg2mem.0.load, %lor.ext.i, !dbg !1606
    #dbg_value(i32 %or.i, !659, !DIExpression(), !1599)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1607
    #dbg_value(i64 %indvars.iv.next.i, !660, !DIExpression(), !1599)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 16384, !dbg !1608
  br i1 %exitcond.not.i, label %check_data.exit, label %for.body.i.for.body.i_crit_edge, !dbg !1602, !llvm.loop !1609

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i32 %or.i, ptr %has_errors.015.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1602

check_data.exit:                                  ; preds = %for.body.i
  %tobool.not.i.not = icmp eq i32 %or.i, 0, !dbg !1611
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1612

if.then45:                                        ; preds = %check_data.exit
  %13 = load ptr, ptr @stderr, align 8, !dbg !1613, !tbaa !861
  %14 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %13) #20, !dbg !1615
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1616

if.end47:                                         ; preds = %check_data.exit
  tail call void @free(ptr noundef nonnull %call) #17, !dbg !1617
  tail call void @free(ptr noundef nonnull %call30) #17, !dbg !1618
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1619
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1620

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1621
}

; Function Attrs: nofree
declare !dbg !1622 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #16

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #16

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "polly-optimized" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #2 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #3 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { nofree norecurse nosync nounwind memory(argmem: read) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #6 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #7 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #8 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #9 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #10 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #11 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #12 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #13 = { mustprogress nofree nounwind willreturn memory(argmem: read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #14 = { inlinehint nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #15 = { nocallback nofree nosync nounwind willreturn }
attributes #16 = { nofree nounwind }
attributes #17 = { nounwind }
attributes #18 = { noreturn nounwind }
attributes #19 = { nounwind allocsize(0) }
attributes #20 = { cold }
attributes #21 = { nounwind willreturn memory(read) }

!llvm.dbg.cu = !{!229, !188, !231, !293}
!llvm.ident = !{!314, !314, !314, !314}
!llvm.module.flags = !{!315, !316, !317, !318, !319, !321, !322, !323, !324, !325}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/stencil/stencil3d")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 272, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_unsigned_char)
!5 = !{!6}
!6 = !DISubrange(count: 34)
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !9, isLocal: true, isDefinition: true)
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 184, elements: !10)
!10 = !{!11}
!11 = !DISubrange(count: 23)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !14, isLocal: true, isDefinition: true)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 160, elements: !16)
!15 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4)
!16 = !{!17}
!17 = !DISubrange(count: 20)
!18 = !DIGlobalVariableExpression(var: !19, expr: !DIExpression())
!19 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !20, isLocal: true, isDefinition: true)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 408, elements: !21)
!21 = !{!22}
!22 = !DISubrange(count: 51)
!23 = !DIGlobalVariableExpression(var: !24, expr: !DIExpression())
!24 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !25, isLocal: true, isDefinition: true)
!25 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 200, elements: !26)
!26 = !{!27}
!27 = !DISubrange(count: 25)
!28 = !DIGlobalVariableExpression(var: !29, expr: !DIExpression())
!29 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !30, isLocal: true, isDefinition: true)
!30 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 232, elements: !31)
!31 = !{!32}
!32 = !DISubrange(count: 29)
!33 = !DIGlobalVariableExpression(var: !34, expr: !DIExpression())
!34 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !35, isLocal: true, isDefinition: true)
!35 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 264, elements: !36)
!36 = !{!37}
!37 = !DISubrange(count: 33)
!38 = !DIGlobalVariableExpression(var: !39, expr: !DIExpression())
!39 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !40, isLocal: true, isDefinition: true)
!40 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 304, elements: !41)
!41 = !{!42}
!42 = !DISubrange(count: 38)
!43 = !DIGlobalVariableExpression(var: !44, expr: !DIExpression())
!44 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !3, isLocal: true, isDefinition: true)
!45 = !DIGlobalVariableExpression(var: !46, expr: !DIExpression())
!46 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !40, isLocal: true, isDefinition: true)
!47 = !DIGlobalVariableExpression(var: !48, expr: !DIExpression())
!48 = distinct !DIGlobalVariable(scope: null, file: !2, line: 132, type: !49, isLocal: true, isDefinition: true)
!49 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 384, elements: !50)
!50 = !{!51}
!51 = !DISubrange(count: 48)
!52 = !DIGlobalVariableExpression(var: !53, expr: !DIExpression())
!53 = distinct !DIGlobalVariable(scope: null, file: !2, line: 132, type: !54, isLocal: true, isDefinition: true)
!54 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 16, elements: !55)
!55 = !{!56}
!56 = !DISubrange(count: 2)
!57 = !DIGlobalVariableExpression(var: !58, expr: !DIExpression())
!58 = distinct !DIGlobalVariable(scope: null, file: !2, line: 132, type: !59, isLocal: true, isDefinition: true)
!59 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 280, elements: !60)
!60 = !{!61}
!61 = !DISubrange(count: 35)
!62 = !DIGlobalVariableExpression(var: !63, expr: !DIExpression())
!63 = distinct !DIGlobalVariable(scope: null, file: !2, line: 133, type: !64, isLocal: true, isDefinition: true)
!64 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 400, elements: !65)
!65 = !{!66}
!66 = !DISubrange(count: 50)
!67 = !DIGlobalVariableExpression(var: !68, expr: !DIExpression())
!68 = distinct !DIGlobalVariable(scope: null, file: !2, line: 134, type: !64, isLocal: true, isDefinition: true)
!69 = !DIGlobalVariableExpression(var: !70, expr: !DIExpression())
!70 = distinct !DIGlobalVariable(scope: null, file: !2, line: 135, type: !64, isLocal: true, isDefinition: true)
!71 = !DIGlobalVariableExpression(var: !72, expr: !DIExpression())
!72 = distinct !DIGlobalVariable(scope: null, file: !2, line: 136, type: !73, isLocal: true, isDefinition: true)
!73 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 368, elements: !74)
!74 = !{!75}
!75 = !DISubrange(count: 46)
!76 = !DIGlobalVariableExpression(var: !77, expr: !DIExpression())
!77 = distinct !DIGlobalVariable(scope: null, file: !2, line: 137, type: !49, isLocal: true, isDefinition: true)
!78 = !DIGlobalVariableExpression(var: !79, expr: !DIExpression())
!79 = distinct !DIGlobalVariable(scope: null, file: !2, line: 138, type: !49, isLocal: true, isDefinition: true)
!80 = !DIGlobalVariableExpression(var: !81, expr: !DIExpression())
!81 = distinct !DIGlobalVariable(scope: null, file: !2, line: 139, type: !49, isLocal: true, isDefinition: true)
!82 = !DIGlobalVariableExpression(var: !83, expr: !DIExpression())
!83 = distinct !DIGlobalVariable(scope: null, file: !2, line: 141, type: !84, isLocal: true, isDefinition: true)
!84 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 352, elements: !85)
!85 = !{!86}
!86 = !DISubrange(count: 44)
!87 = !DIGlobalVariableExpression(var: !88, expr: !DIExpression())
!88 = distinct !DIGlobalVariable(scope: null, file: !2, line: 142, type: !73, isLocal: true, isDefinition: true)
!89 = !DIGlobalVariableExpression(var: !90, expr: !DIExpression())
!90 = distinct !DIGlobalVariable(scope: null, file: !2, line: 147, type: !91, isLocal: true, isDefinition: true)
!91 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 280, elements: !60)
!92 = !DIGlobalVariableExpression(var: !93, expr: !DIExpression())
!93 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !94, isLocal: true, isDefinition: true)
!94 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 224, elements: !95)
!95 = !{!96}
!96 = !DISubrange(count: 28)
!97 = !DIGlobalVariableExpression(var: !98, expr: !DIExpression())
!98 = distinct !DIGlobalVariable(scope: null, file: !2, line: 177, type: !99, isLocal: true, isDefinition: true)
!99 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 360, elements: !100)
!100 = !{!101}
!101 = !DISubrange(count: 45)
!102 = !DIGlobalVariableExpression(var: !103, expr: !DIExpression())
!103 = distinct !DIGlobalVariable(scope: null, file: !2, line: 177, type: !104, isLocal: true, isDefinition: true)
!104 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 32, elements: !105)
!105 = !{!106}
!106 = !DISubrange(count: 4)
!107 = !DIGlobalVariableExpression(var: !108, expr: !DIExpression())
!108 = distinct !DIGlobalVariable(scope: null, file: !2, line: 178, type: !109, isLocal: true, isDefinition: true)
!109 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 376, elements: !110)
!110 = !{!111}
!111 = !DISubrange(count: 47)
!112 = !DIGlobalVariableExpression(var: !113, expr: !DIExpression())
!113 = distinct !DIGlobalVariable(scope: null, file: !2, line: 179, type: !109, isLocal: true, isDefinition: true)
!114 = !DIGlobalVariableExpression(var: !115, expr: !DIExpression())
!115 = distinct !DIGlobalVariable(scope: null, file: !2, line: 180, type: !109, isLocal: true, isDefinition: true)
!116 = !DIGlobalVariableExpression(var: !117, expr: !DIExpression())
!117 = distinct !DIGlobalVariable(scope: null, file: !2, line: 180, type: !118, isLocal: true, isDefinition: true)
!118 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 40, elements: !119)
!119 = !{!120}
!120 = !DISubrange(count: 5)
!121 = !DIGlobalVariableExpression(var: !122, expr: !DIExpression())
!122 = distinct !DIGlobalVariable(scope: null, file: !2, line: 181, type: !123, isLocal: true, isDefinition: true)
!123 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 344, elements: !124)
!124 = !{!125}
!125 = !DISubrange(count: 43)
!126 = !DIGlobalVariableExpression(var: !127, expr: !DIExpression())
!127 = distinct !DIGlobalVariable(scope: null, file: !2, line: 181, type: !104, isLocal: true, isDefinition: true)
!128 = !DIGlobalVariableExpression(var: !129, expr: !DIExpression())
!129 = distinct !DIGlobalVariable(scope: null, file: !2, line: 182, type: !99, isLocal: true, isDefinition: true)
!130 = !DIGlobalVariableExpression(var: !131, expr: !DIExpression())
!131 = distinct !DIGlobalVariable(scope: null, file: !2, line: 183, type: !99, isLocal: true, isDefinition: true)
!132 = !DIGlobalVariableExpression(var: !133, expr: !DIExpression())
!133 = distinct !DIGlobalVariable(scope: null, file: !2, line: 184, type: !99, isLocal: true, isDefinition: true)
!134 = !DIGlobalVariableExpression(var: !135, expr: !DIExpression())
!135 = distinct !DIGlobalVariable(scope: null, file: !2, line: 184, type: !118, isLocal: true, isDefinition: true)
!136 = !DIGlobalVariableExpression(var: !137, expr: !DIExpression())
!137 = distinct !DIGlobalVariable(scope: null, file: !2, line: 186, type: !138, isLocal: true, isDefinition: true)
!138 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 328, elements: !139)
!139 = !{!140}
!140 = !DISubrange(count: 41)
!141 = !DIGlobalVariableExpression(var: !142, expr: !DIExpression())
!142 = distinct !DIGlobalVariable(scope: null, file: !2, line: 186, type: !143, isLocal: true, isDefinition: true)
!143 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 56, elements: !144)
!144 = !{!145}
!145 = !DISubrange(count: 7)
!146 = !DIGlobalVariableExpression(var: !147, expr: !DIExpression())
!147 = distinct !DIGlobalVariable(scope: null, file: !2, line: 187, type: !123, isLocal: true, isDefinition: true)
!148 = !DIGlobalVariableExpression(var: !149, expr: !DIExpression())
!149 = distinct !DIGlobalVariable(scope: null, file: !2, line: 190, type: !150, isLocal: true, isDefinition: true)
!150 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 240, elements: !151)
!151 = !{!152}
!152 = !DISubrange(count: 30)
!153 = !DIGlobalVariableExpression(var: !154, expr: !DIExpression())
!154 = distinct !DIGlobalVariable(scope: null, file: !2, line: 191, type: !155, isLocal: true, isDefinition: true)
!155 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 48, elements: !156)
!156 = !{!157}
!157 = !DISubrange(count: 6)
!158 = !DIGlobalVariableExpression(var: !159, expr: !DIExpression())
!159 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !160, isLocal: true, isDefinition: true)
!160 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 720, elements: !161)
!161 = !{!162}
!162 = !DISubrange(count: 90)
!163 = !DIGlobalVariableExpression(var: !164, expr: !DIExpression())
!164 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !40, isLocal: true, isDefinition: true)
!165 = !DIGlobalVariableExpression(var: !166, expr: !DIExpression())
!166 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !167, isLocal: true, isDefinition: true)
!167 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 400, elements: !65)
!168 = !DIGlobalVariableExpression(var: !169, expr: !DIExpression())
!169 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !171, isLocal: true, isDefinition: true)
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/stencil/stencil3d")
!171 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 456, elements: !172)
!172 = !{!173}
!173 = !DISubrange(count: 57)
!174 = !DIGlobalVariableExpression(var: !175, expr: !DIExpression())
!175 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !9, isLocal: true, isDefinition: true)
!176 = !DIGlobalVariableExpression(var: !177, expr: !DIExpression())
!177 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !178, isLocal: true, isDefinition: true)
!178 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 184, elements: !10)
!179 = !DIGlobalVariableExpression(var: !180, expr: !DIExpression())
!180 = distinct !DIGlobalVariable(scope: null, file: !170, line: 22, type: !181, isLocal: true, isDefinition: true)
!181 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 88, elements: !182)
!182 = !{!183}
!183 = !DISubrange(count: 11)
!184 = !DIGlobalVariableExpression(var: !185, expr: !DIExpression())
!185 = distinct !DIGlobalVariable(scope: null, file: !170, line: 24, type: !181, isLocal: true, isDefinition: true)
!186 = !DIGlobalVariableExpression(var: !187, expr: !DIExpression())
!187 = distinct !DIGlobalVariable(name: "INPUT_SIZE", scope: !188, file: !189, line: 4, type: !201, isLocal: false, isDefinition: true)
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !207, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/stencil/stencil3d")
!190 = !{!191}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 29, size: 1048640, elements: !194)
!193 = !DIFile(filename: "./stencil.h", directory: "/home/kelvin/MachSuite/stencil/stencil3d")
!194 = !{!195, !202, !206}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "C", scope: !192, file: !193, line: 30, baseType: !196, size: 64)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 64, elements: !55)
!197 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !198, line: 26, baseType: !199)
!198 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!199 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !200, line: 41, baseType: !201)
!200 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!201 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!202 = !DIDerivedType(tag: DW_TAG_member, name: "orig", scope: !192, file: !193, line: 31, baseType: !203, size: 524288, offset: 64)
!203 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 524288, elements: !204)
!204 = !{!205}
!205 = !DISubrange(count: 16384)
!206 = !DIDerivedType(tag: DW_TAG_member, name: "sol", scope: !192, file: !193, line: 32, baseType: !203, size: 524288, offset: 524352)
!207 = !{!186}
!208 = !DIGlobalVariableExpression(var: !209, expr: !DIExpression())
!209 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !210, isLocal: true, isDefinition: true)
!210 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!211 = !DIGlobalVariableExpression(var: !212, expr: !DIExpression())
!212 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !213, isLocal: true, isDefinition: true)
!213 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!214 = !DIGlobalVariableExpression(var: !215, expr: !DIExpression())
!215 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !216, isLocal: true, isDefinition: true)
!216 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !217)
!217 = !{!218}
!218 = !DISubrange(count: 12)
!219 = !DIGlobalVariableExpression(var: !220, expr: !DIExpression())
!220 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !221, isLocal: true, isDefinition: true)
!221 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!222 = !DIGlobalVariableExpression(var: !223, expr: !DIExpression())
!223 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!224 = !DIGlobalVariableExpression(var: !225, expr: !DIExpression())
!225 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !226, isLocal: true, isDefinition: true)
!226 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!227 = !DIGlobalVariableExpression(var: !228, expr: !DIExpression())
!228 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!229 = distinct !DICompileUnit(language: DW_LANG_C11, file: !230, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!230 = !DIFile(filename: "stencil.c", directory: "/home/kelvin/MachSuite/stencil/stencil3d")
!231 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !232, globals: !259, splitDebugInlining: false, nameTableKind: None)
!232 = !{!233, !4, !234, !235, !239, !242, !245, !248, !251, !197, !254, !257, !258}
!233 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!234 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!235 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !236, line: 24, baseType: !237)
!236 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!237 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !200, line: 38, baseType: !238)
!238 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!239 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !236, line: 25, baseType: !240)
!240 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !200, line: 40, baseType: !241)
!241 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!242 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !236, line: 26, baseType: !243)
!243 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !200, line: 42, baseType: !244)
!244 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!245 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !236, line: 27, baseType: !246)
!246 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !200, line: 45, baseType: !247)
!247 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!248 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !198, line: 24, baseType: !249)
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !200, line: 37, baseType: !250)
!250 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!251 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !198, line: 25, baseType: !252)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !200, line: 39, baseType: !253)
!253 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!254 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !198, line: 27, baseType: !255)
!255 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !200, line: 44, baseType: !256)
!256 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!257 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!258 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!259 = !{!260, !0, !7, !12, !265, !18, !267, !23, !272, !28, !274, !33, !38, !276, !43, !45, !47, !52, !57, !62, !67, !69, !71, !76, !78, !80, !82, !87, !89, !281, !92, !97, !102, !107, !112, !114, !116, !121, !126, !128, !130, !132, !134, !136, !141, !146, !148, !153, !286, !158, !163, !288, !165}
!260 = !DIGlobalVariableExpression(var: !261, expr: !DIExpression())
!261 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !262, isLocal: true, isDefinition: true)
!262 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !263)
!263 = !{!264}
!264 = !DISubrange(count: 24)
!265 = !DIGlobalVariableExpression(var: !266, expr: !DIExpression())
!266 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !30, isLocal: true, isDefinition: true)
!267 = !DIGlobalVariableExpression(var: !268, expr: !DIExpression())
!268 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !269, isLocal: true, isDefinition: true)
!269 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !270)
!270 = !{!271}
!271 = !DISubrange(count: 14)
!272 = !DIGlobalVariableExpression(var: !273, expr: !DIExpression())
!273 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !269, isLocal: true, isDefinition: true)
!274 = !DIGlobalVariableExpression(var: !275, expr: !DIExpression())
!275 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !9, isLocal: true, isDefinition: true)
!276 = !DIGlobalVariableExpression(var: !277, expr: !DIExpression())
!277 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !278, isLocal: true, isDefinition: true)
!278 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !279)
!279 = !{!280}
!280 = !DISubrange(count: 21)
!281 = !DIGlobalVariableExpression(var: !282, expr: !DIExpression())
!282 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !283, isLocal: true, isDefinition: true)
!283 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !284)
!284 = !{!285}
!285 = !DISubrange(count: 13)
!286 = !DIGlobalVariableExpression(var: !287, expr: !DIExpression())
!287 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !20, isLocal: true, isDefinition: true)
!288 = !DIGlobalVariableExpression(var: !289, expr: !DIExpression())
!289 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !290, isLocal: true, isDefinition: true)
!290 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !291)
!291 = !{!292}
!292 = !DISubrange(count: 27)
!293 = distinct !DICompileUnit(language: DW_LANG_C11, file: !170, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !294, globals: !295, splitDebugInlining: false, nameTableKind: None)
!294 = !{!234}
!295 = !{!296, !168, !174, !176, !179, !184, !298, !208, !300, !211, !214, !302, !219, !222, !307, !224, !227, !309}
!296 = !DIGlobalVariableExpression(var: !297, expr: !DIExpression())
!297 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !221, isLocal: true, isDefinition: true)
!298 = !DIGlobalVariableExpression(var: !299, expr: !DIExpression())
!299 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !269, isLocal: true, isDefinition: true)
!300 = !DIGlobalVariableExpression(var: !301, expr: !DIExpression())
!301 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !210, isLocal: true, isDefinition: true)
!302 = !DIGlobalVariableExpression(var: !303, expr: !DIExpression())
!303 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !304, isLocal: true, isDefinition: true)
!304 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !305)
!305 = !{!306}
!306 = !DISubrange(count: 31)
!307 = !DIGlobalVariableExpression(var: !308, expr: !DIExpression())
!308 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !210, isLocal: true, isDefinition: true)
!309 = !DIGlobalVariableExpression(var: !310, expr: !DIExpression())
!310 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !311, isLocal: true, isDefinition: true)
!311 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !312)
!312 = !{!313}
!313 = !DISubrange(count: 10)
!314 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!315 = !{i32 7, !"Dwarf Version", i32 4}
!316 = !{i32 2, !"Debug Info Version", i32 3}
!317 = !{i32 1, !"wchar_size", i32 4}
!318 = !{i32 1, !"target-abi", !"lp64d"}
!319 = distinct !{i32 6, !"riscv-isa", !320}
!320 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!321 = !{i32 8, !"PIC Level", i32 2}
!322 = !{i32 7, !"PIE Level", i32 2}
!323 = !{i32 7, !"uwtable", i32 2}
!324 = !{i32 8, !"SmallDataLimit", i32 8}
!325 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!326 = distinct !DISubprogram(name: "stencil", scope: !230, file: !230, line: 10, type: !327, scopeLine: 10, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !229, retainedNodes: !330)
!327 = !DISubroutineType(types: !328)
!328 = !{null, !329, !329, !329}
!329 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!330 = !{!331, !332, !333, !334, !335, !336, !337, !338, !339, !340, !341, !342, !346, !347, !351, !352, !356, !357, !361}
!331 = !DILocalVariable(name: "C", arg: 1, scope: !326, file: !230, line: 10, type: !329)
!332 = !DILocalVariable(name: "orig", arg: 2, scope: !326, file: !230, line: 10, type: !329)
!333 = !DILocalVariable(name: "sol", arg: 3, scope: !326, file: !230, line: 10, type: !329)
!334 = !DILocalVariable(name: "i", scope: !326, file: !230, line: 11, type: !201)
!335 = !DILocalVariable(name: "j", scope: !326, file: !230, line: 11, type: !201)
!336 = !DILocalVariable(name: "k", scope: !326, file: !230, line: 11, type: !201)
!337 = !DILocalVariable(name: "sum0", scope: !326, file: !230, line: 12, type: !197)
!338 = !DILocalVariable(name: "sum1", scope: !326, file: !230, line: 12, type: !197)
!339 = !DILocalVariable(name: "mul0", scope: !326, file: !230, line: 12, type: !197)
!340 = !DILocalVariable(name: "mul1", scope: !326, file: !230, line: 12, type: !197)
!341 = !DILabel(scope: !326, name: "height_bound_col", file: !230, line: 15)
!342 = !DILabel(scope: !343, name: "height_bound_row", file: !230, line: 16)
!343 = distinct !DILexicalBlock(scope: !344, file: !230, line: 15, column: 50)
!344 = distinct !DILexicalBlock(scope: !345, file: !230, line: 15, column: 24)
!345 = distinct !DILexicalBlock(scope: !326, file: !230, line: 15, column: 24)
!346 = !DILabel(scope: !326, name: "col_bound_height", file: !230, line: 21)
!347 = !DILabel(scope: !348, name: "col_bound_row", file: !230, line: 22)
!348 = distinct !DILexicalBlock(scope: !349, file: !230, line: 21, column: 55)
!349 = distinct !DILexicalBlock(scope: !350, file: !230, line: 21, column: 24)
!350 = distinct !DILexicalBlock(scope: !326, file: !230, line: 21, column: 24)
!351 = !DILabel(scope: !326, name: "row_bound_height", file: !230, line: 27)
!352 = !DILabel(scope: !353, name: "row_bound_col", file: !230, line: 28)
!353 = distinct !DILexicalBlock(scope: !354, file: !230, line: 27, column: 55)
!354 = distinct !DILexicalBlock(scope: !355, file: !230, line: 27, column: 24)
!355 = distinct !DILexicalBlock(scope: !326, file: !230, line: 27, column: 24)
!356 = !DILabel(scope: !326, name: "loop_height", file: !230, line: 36)
!357 = !DILabel(scope: !358, name: "loop_col", file: !230, line: 37)
!358 = distinct !DILexicalBlock(scope: !359, file: !230, line: 36, column: 55)
!359 = distinct !DILexicalBlock(scope: !360, file: !230, line: 36, column: 19)
!360 = distinct !DILexicalBlock(scope: !326, file: !230, line: 36, column: 19)
!361 = !DILabel(scope: !362, name: "loop_row", file: !230, line: 38)
!362 = distinct !DILexicalBlock(scope: !363, file: !230, line: 37, column: 53)
!363 = distinct !DILexicalBlock(scope: !364, file: !230, line: 37, column: 20)
!364 = distinct !DILexicalBlock(scope: !358, file: !230, line: 37, column: 20)
!365 = !DILocation(line: 0, scope: !326)
!366 = !DILocation(line: 15, column: 5, scope: !326)
!367 = !DILocation(line: 15, column: 24, scope: !345)
!368 = !DILocation(line: 16, column: 28, scope: !369)
!369 = distinct !DILexicalBlock(scope: !343, file: !230, line: 16, column: 28)
!370 = !DILocation(line: 17, column: 59, scope: !371)
!371 = distinct !DILexicalBlock(scope: !372, file: !230, line: 16, column: 54)
!372 = distinct !DILexicalBlock(scope: !369, file: !230, line: 16, column: 28)
!373 = !DILocation(line: 17, column: 54, scope: !371)
!374 = !{!375, !375, i64 0}
!375 = !{!"int", !376, i64 0}
!376 = !{!"omnipotent char", !377, i64 0}
!377 = !{!"Simple C/C++ TBAA"}
!378 = !DILocation(line: 17, column: 13, scope: !371)
!379 = !DILocation(line: 17, column: 52, scope: !371)
!380 = !DILocation(line: 18, column: 66, scope: !371)
!381 = !DILocation(line: 18, column: 13, scope: !371)
!382 = !DILocation(line: 18, column: 64, scope: !371)
!383 = !DILocation(line: 16, column: 50, scope: !372)
!384 = !DILocation(line: 16, column: 38, scope: !372)
!385 = distinct !{!385, !368, !386, !387, !388}
!386 = !DILocation(line: 19, column: 9, scope: !369)
!387 = !{!"llvm.loop.mustprogress"}
!388 = !{!"llvm.loop.unroll.disable"}
!389 = !DILocation(line: 15, column: 46, scope: !344)
!390 = !DILocation(line: 15, column: 34, scope: !344)
!391 = distinct !{!391, !367, !392, !387, !388}
!392 = !DILocation(line: 20, column: 5, scope: !345)
!393 = !DILocation(line: 22, column: 25, scope: !394)
!394 = distinct !DILexicalBlock(scope: !348, file: !230, line: 22, column: 25)
!395 = !DILocation(line: 23, column: 59, scope: !396)
!396 = distinct !DILexicalBlock(scope: !397, file: !230, line: 22, column: 51)
!397 = distinct !DILexicalBlock(scope: !394, file: !230, line: 22, column: 25)
!398 = !DILocation(line: 23, column: 54, scope: !396)
!399 = !DILocation(line: 23, column: 13, scope: !396)
!400 = !DILocation(line: 23, column: 52, scope: !396)
!401 = !DILocation(line: 24, column: 63, scope: !396)
!402 = !DILocation(line: 24, column: 13, scope: !396)
!403 = !DILocation(line: 24, column: 61, scope: !396)
!404 = !DILocation(line: 22, column: 47, scope: !397)
!405 = !DILocation(line: 22, column: 35, scope: !397)
!406 = distinct !{!406, !393, !407, !387, !388}
!407 = !DILocation(line: 25, column: 9, scope: !394)
!408 = !DILocation(line: 21, column: 51, scope: !349)
!409 = !DILocation(line: 21, column: 34, scope: !349)
!410 = !DILocation(line: 21, column: 24, scope: !350)
!411 = distinct !{!411, !410, !412, !387, !388}
!412 = !DILocation(line: 26, column: 5, scope: !350)
!413 = !DILocation(line: 28, column: 25, scope: !414)
!414 = distinct !DILexicalBlock(scope: !353, file: !230, line: 28, column: 25)
!415 = !DILocation(line: 36, column: 19, scope: !360)
!416 = !DILocation(line: 29, column: 59, scope: !417)
!417 = distinct !DILexicalBlock(scope: !418, file: !230, line: 28, column: 53)
!418 = distinct !DILexicalBlock(scope: !414, file: !230, line: 28, column: 25)
!419 = !DILocation(line: 29, column: 54, scope: !417)
!420 = !DILocation(line: 29, column: 13, scope: !417)
!421 = !DILocation(line: 29, column: 52, scope: !417)
!422 = !DILocation(line: 30, column: 68, scope: !417)
!423 = !DILocation(line: 30, column: 63, scope: !417)
!424 = !DILocation(line: 30, column: 13, scope: !417)
!425 = !DILocation(line: 30, column: 61, scope: !417)
!426 = !DILocation(line: 28, column: 49, scope: !418)
!427 = !DILocation(line: 28, column: 35, scope: !418)
!428 = distinct !{!428, !413, !429, !387, !388}
!429 = !DILocation(line: 31, column: 9, scope: !414)
!430 = !DILocation(line: 27, column: 51, scope: !354)
!431 = !DILocation(line: 27, column: 34, scope: !354)
!432 = !DILocation(line: 27, column: 24, scope: !355)
!433 = distinct !{!433, !432, !434, !387, !388}
!434 = !DILocation(line: 32, column: 5, scope: !355)
!435 = !DILocation(line: 37, column: 20, scope: !364)
!436 = !DILocation(line: 38, column: 24, scope: !437)
!437 = distinct !DILexicalBlock(scope: !362, file: !230, line: 38, column: 24)
!438 = !DILocation(line: 39, column: 29, scope: !439)
!439 = distinct !DILexicalBlock(scope: !440, file: !230, line: 38, column: 57)
!440 = distinct !DILexicalBlock(scope: !437, file: !230, line: 38, column: 24)
!441 = !DILocation(line: 39, column: 24, scope: !439)
!442 = !DILocation(line: 40, column: 24, scope: !439)
!443 = !DILocation(line: 41, column: 24, scope: !439)
!444 = !DILocation(line: 40, column: 68, scope: !439)
!445 = !DILocation(line: 42, column: 24, scope: !439)
!446 = !DILocation(line: 41, column: 68, scope: !439)
!447 = !DILocation(line: 43, column: 24, scope: !439)
!448 = !DILocation(line: 42, column: 68, scope: !439)
!449 = !DILocation(line: 44, column: 29, scope: !439)
!450 = !DILocation(line: 44, column: 24, scope: !439)
!451 = !DILocation(line: 43, column: 68, scope: !439)
!452 = !DILocation(line: 45, column: 24, scope: !439)
!453 = !DILocation(line: 44, column: 68, scope: !439)
!454 = !DILocation(line: 46, column: 31, scope: !439)
!455 = !DILocation(line: 46, column: 29, scope: !439)
!456 = !DILocation(line: 47, column: 31, scope: !439)
!457 = !DILocation(line: 47, column: 29, scope: !439)
!458 = !DILocation(line: 48, column: 63, scope: !439)
!459 = !DILocation(line: 48, column: 17, scope: !439)
!460 = !DILocation(line: 48, column: 56, scope: !439)
!461 = !DILocation(line: 38, column: 37, scope: !440)
!462 = distinct !{!462, !436, !463, !387, !388}
!463 = !DILocation(line: 49, column: 13, scope: !437)
!464 = !DILocation(line: 37, column: 50, scope: !363)
!465 = !DILocation(line: 37, column: 33, scope: !363)
!466 = distinct !{!466, !435, !467, !387, !388}
!467 = !DILocation(line: 50, column: 9, scope: !364)
!468 = !DILocation(line: 36, column: 52, scope: !359)
!469 = !DILocation(line: 36, column: 32, scope: !359)
!470 = distinct !{!470, !415, !471, !387, !388}
!471 = !DILocation(line: 51, column: 5, scope: !360)
!472 = !DILocation(line: 52, column: 1, scope: !326)
!473 = !{!474}
!474 = distinct !{!474, !475, !"polly.alias.scope.MemRef0"}
!475 = distinct !{!475, !"polly.alias.scope.domain"}
!476 = !{!477, !478}
!477 = distinct !{!477, !475, !"polly.alias.scope.MemRef1"}
!478 = distinct !{!478, !475, !"polly.alias.scope.MemRef2"}
!479 = !{!477}
!480 = !{!474, !478}
!481 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 8, type: !482, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !484)
!482 = !DISubroutineType(types: !483)
!483 = !{null, !234}
!484 = !{!485, !486}
!485 = !DILocalVariable(name: "vargs", arg: 1, scope: !481, file: !189, line: 8, type: !234)
!486 = !DILocalVariable(name: "args", scope: !481, file: !189, line: 9, type: !191)
!487 = !DILocation(line: 0, scope: !481)
!488 = !DILocation(line: 10, column: 27, scope: !481)
!489 = !DILocation(line: 10, column: 39, scope: !481)
!490 = !DILocation(line: 10, column: 3, scope: !481)
!491 = !DILocation(line: 11, column: 1, scope: !481)
!492 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 20, type: !493, scopeLine: 20, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !495)
!493 = !DISubroutineType(types: !494)
!494 = !{null, !201, !234}
!495 = !{!496, !497, !498, !499, !500}
!496 = !DILocalVariable(name: "fd", arg: 1, scope: !492, file: !189, line: 20, type: !201)
!497 = !DILocalVariable(name: "vdata", arg: 2, scope: !492, file: !189, line: 20, type: !234)
!498 = !DILocalVariable(name: "data", scope: !492, file: !189, line: 21, type: !191)
!499 = !DILocalVariable(name: "p", scope: !492, file: !189, line: 22, type: !233)
!500 = !DILocalVariable(name: "s", scope: !492, file: !189, line: 22, type: !233)
!501 = !DILocation(line: 0, scope: !492)
!502 = !DILocation(line: 24, column: 7, scope: !492)
!503 = !DILocalVariable(name: "s", arg: 1, scope: !504, file: !2, line: 56, type: !233)
!504 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !505, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !507)
!505 = !DISubroutineType(types: !506)
!506 = !{!233, !233, !201}
!507 = !{!503, !508, !509}
!508 = !DILocalVariable(name: "n", arg: 2, scope: !504, file: !2, line: 56, type: !201)
!509 = !DILocalVariable(name: "i", scope: !504, file: !2, line: 57, type: !201)
!510 = !DILocation(line: 0, scope: !504, inlinedAt: !511)
!511 = distinct !DILocation(line: 26, column: 7, scope: !492)
!512 = !DILocation(line: 64, column: 17, scope: !504, inlinedAt: !511)
!513 = !{!376, !376, i64 0}
!514 = !DILocation(line: 64, column: 3, scope: !504, inlinedAt: !511)
!515 = !DILocation(line: 66, column: 22, scope: !516, inlinedAt: !511)
!516 = distinct !DILexicalBlock(scope: !517, file: !2, line: 66, column: 9)
!517 = distinct !DILexicalBlock(scope: !504, file: !2, line: 64, column: 31)
!518 = !DILocation(line: 66, column: 26, scope: !516, inlinedAt: !511)
!519 = !DILocation(line: 66, column: 32, scope: !516, inlinedAt: !511)
!520 = !DILocation(line: 66, column: 35, scope: !516, inlinedAt: !511)
!521 = !DILocation(line: 66, column: 39, scope: !516, inlinedAt: !511)
!522 = !DILocation(line: 66, column: 9, scope: !517, inlinedAt: !511)
!523 = !DILocation(line: 69, column: 6, scope: !517, inlinedAt: !511)
!524 = !DILocation(line: 64, column: 10, scope: !504, inlinedAt: !511)
!525 = !DILocation(line: 64, column: 13, scope: !504, inlinedAt: !511)
!526 = distinct !{!526, !514, !527, !387, !388}
!527 = !DILocation(line: 70, column: 3, scope: !504, inlinedAt: !511)
!528 = !DILocation(line: 71, column: 6, scope: !529, inlinedAt: !511)
!529 = distinct !DILexicalBlock(scope: !504, file: !2, line: 71, column: 6)
!530 = !DILocation(line: 71, column: 8, scope: !529, inlinedAt: !511)
!531 = !DILocation(line: 71, column: 6, scope: !504, inlinedAt: !511)
!532 = !DILocation(line: 27, column: 3, scope: !492)
!533 = !DILocation(line: 0, scope: !504, inlinedAt: !534)
!534 = distinct !DILocation(line: 29, column: 7, scope: !492)
!535 = !DILocation(line: 64, column: 17, scope: !504, inlinedAt: !534)
!536 = !DILocation(line: 64, column: 3, scope: !504, inlinedAt: !534)
!537 = !DILocation(line: 66, column: 22, scope: !516, inlinedAt: !534)
!538 = !DILocation(line: 66, column: 26, scope: !516, inlinedAt: !534)
!539 = !DILocation(line: 66, column: 32, scope: !516, inlinedAt: !534)
!540 = !DILocation(line: 66, column: 35, scope: !516, inlinedAt: !534)
!541 = !DILocation(line: 66, column: 39, scope: !516, inlinedAt: !534)
!542 = !DILocation(line: 66, column: 9, scope: !517, inlinedAt: !534)
!543 = !DILocation(line: 69, column: 6, scope: !517, inlinedAt: !534)
!544 = !DILocation(line: 64, column: 10, scope: !504, inlinedAt: !534)
!545 = !DILocation(line: 64, column: 13, scope: !504, inlinedAt: !534)
!546 = distinct !{!546, !536, !547, !387, !388}
!547 = !DILocation(line: 70, column: 3, scope: !504, inlinedAt: !534)
!548 = !DILocation(line: 71, column: 6, scope: !529, inlinedAt: !534)
!549 = !DILocation(line: 71, column: 8, scope: !529, inlinedAt: !534)
!550 = !DILocation(line: 71, column: 6, scope: !504, inlinedAt: !534)
!551 = !DILocation(line: 30, column: 37, scope: !492)
!552 = !DILocation(line: 30, column: 3, scope: !492)
!553 = !DILocation(line: 31, column: 3, scope: !492)
!554 = !DILocation(line: 32, column: 1, scope: !492)
!555 = !DISubprogram(name: "free", scope: !556, file: !556, line: 687, type: !482, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!556 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!557 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 34, type: !493, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !558)
!558 = !{!559, !560, !561}
!559 = !DILocalVariable(name: "fd", arg: 1, scope: !557, file: !189, line: 34, type: !201)
!560 = !DILocalVariable(name: "vdata", arg: 2, scope: !557, file: !189, line: 34, type: !234)
!561 = !DILocalVariable(name: "data", scope: !557, file: !189, line: 35, type: !191)
!562 = !DILocation(line: 0, scope: !557)
!563 = !DILocalVariable(name: "fd", arg: 1, scope: !564, file: !2, line: 189, type: !201)
!564 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !565, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !567)
!565 = !DISubroutineType(types: !566)
!566 = !{!201, !201}
!567 = !{!563}
!568 = !DILocation(line: 0, scope: !564, inlinedAt: !569)
!569 = distinct !DILocation(line: 37, column: 3, scope: !557)
!570 = !DILocation(line: 190, column: 3, scope: !571, inlinedAt: !569)
!571 = distinct !DILexicalBlock(scope: !572, file: !2, line: 190, column: 3)
!572 = distinct !DILexicalBlock(scope: !564, file: !2, line: 190, column: 3)
!573 = !DILocation(line: 191, column: 3, scope: !564, inlinedAt: !569)
!574 = !DILocalVariable(name: "fd", arg: 1, scope: !575, file: !2, line: 183, type: !201)
!575 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !576, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !578)
!576 = !DISubroutineType(types: !577)
!577 = !{!201, !201, !329, !201}
!578 = !{!574, !579, !580, !581}
!579 = !DILocalVariable(name: "arr", arg: 2, scope: !575, file: !2, line: 183, type: !329)
!580 = !DILocalVariable(name: "n", arg: 3, scope: !575, file: !2, line: 183, type: !201)
!581 = !DILocalVariable(name: "i", scope: !575, file: !2, line: 183, type: !201)
!582 = !DILocation(line: 0, scope: !575, inlinedAt: !583)
!583 = distinct !DILocation(line: 38, column: 3, scope: !557)
!584 = !DILocation(line: 183, column: 1, scope: !585, inlinedAt: !583)
!585 = distinct !DILexicalBlock(scope: !575, file: !2, line: 183, column: 1)
!586 = !DILocation(line: 183, column: 1, scope: !587, inlinedAt: !583)
!587 = distinct !DILexicalBlock(scope: !588, file: !2, line: 183, column: 1)
!588 = distinct !DILexicalBlock(scope: !585, file: !2, line: 183, column: 1)
!589 = !DILocation(line: 183, column: 1, scope: !588, inlinedAt: !583)
!590 = distinct !{!590, !584, !584, !387, !388}
!591 = !DILocation(line: 0, scope: !564, inlinedAt: !592)
!592 = distinct !DILocation(line: 40, column: 3, scope: !557)
!593 = !DILocation(line: 191, column: 3, scope: !564, inlinedAt: !592)
!594 = !DILocation(line: 41, column: 38, scope: !557)
!595 = !DILocation(line: 0, scope: !575, inlinedAt: !596)
!596 = distinct !DILocation(line: 41, column: 3, scope: !557)
!597 = !DILocation(line: 183, column: 1, scope: !585, inlinedAt: !596)
!598 = !DILocation(line: 183, column: 1, scope: !587, inlinedAt: !596)
!599 = !DILocation(line: 183, column: 1, scope: !588, inlinedAt: !596)
!600 = distinct !{!600, !597, !597, !387, !388}
!601 = !DILocation(line: 42, column: 1, scope: !557)
!602 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 49, type: !493, scopeLine: 49, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !603)
!603 = !{!604, !605, !606, !607, !608}
!604 = !DILocalVariable(name: "fd", arg: 1, scope: !602, file: !189, line: 49, type: !201)
!605 = !DILocalVariable(name: "vdata", arg: 2, scope: !602, file: !189, line: 49, type: !234)
!606 = !DILocalVariable(name: "data", scope: !602, file: !189, line: 50, type: !191)
!607 = !DILocalVariable(name: "p", scope: !602, file: !189, line: 51, type: !233)
!608 = !DILocalVariable(name: "s", scope: !602, file: !189, line: 51, type: !233)
!609 = !DILocation(line: 0, scope: !602)
!610 = !DILocation(line: 53, column: 7, scope: !602)
!611 = !DILocation(line: 0, scope: !504, inlinedAt: !612)
!612 = distinct !DILocation(line: 55, column: 7, scope: !602)
!613 = !DILocation(line: 64, column: 17, scope: !504, inlinedAt: !612)
!614 = !DILocation(line: 64, column: 3, scope: !504, inlinedAt: !612)
!615 = !DILocation(line: 66, column: 22, scope: !516, inlinedAt: !612)
!616 = !DILocation(line: 66, column: 26, scope: !516, inlinedAt: !612)
!617 = !DILocation(line: 66, column: 32, scope: !516, inlinedAt: !612)
!618 = !DILocation(line: 66, column: 35, scope: !516, inlinedAt: !612)
!619 = !DILocation(line: 66, column: 39, scope: !516, inlinedAt: !612)
!620 = !DILocation(line: 66, column: 9, scope: !517, inlinedAt: !612)
!621 = !DILocation(line: 69, column: 6, scope: !517, inlinedAt: !612)
!622 = !DILocation(line: 64, column: 10, scope: !504, inlinedAt: !612)
!623 = !DILocation(line: 64, column: 13, scope: !504, inlinedAt: !612)
!624 = distinct !{!624, !614, !625, !387, !388}
!625 = !DILocation(line: 70, column: 3, scope: !504, inlinedAt: !612)
!626 = !DILocation(line: 71, column: 6, scope: !529, inlinedAt: !612)
!627 = !DILocation(line: 71, column: 8, scope: !529, inlinedAt: !612)
!628 = !DILocation(line: 71, column: 6, scope: !504, inlinedAt: !612)
!629 = !DILocation(line: 56, column: 37, scope: !602)
!630 = !DILocation(line: 56, column: 3, scope: !602)
!631 = !DILocation(line: 57, column: 3, scope: !602)
!632 = !DILocation(line: 58, column: 1, scope: !602)
!633 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 60, type: !493, scopeLine: 60, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !634)
!634 = !{!635, !636, !637}
!635 = !DILocalVariable(name: "fd", arg: 1, scope: !633, file: !189, line: 60, type: !201)
!636 = !DILocalVariable(name: "vdata", arg: 2, scope: !633, file: !189, line: 60, type: !234)
!637 = !DILocalVariable(name: "data", scope: !633, file: !189, line: 61, type: !191)
!638 = !DILocation(line: 0, scope: !633)
!639 = !DILocation(line: 0, scope: !564, inlinedAt: !640)
!640 = distinct !DILocation(line: 63, column: 3, scope: !633)
!641 = !DILocation(line: 190, column: 3, scope: !571, inlinedAt: !640)
!642 = !DILocation(line: 191, column: 3, scope: !564, inlinedAt: !640)
!643 = !DILocation(line: 64, column: 38, scope: !633)
!644 = !DILocation(line: 0, scope: !575, inlinedAt: !645)
!645 = distinct !DILocation(line: 64, column: 3, scope: !633)
!646 = !DILocation(line: 183, column: 1, scope: !585, inlinedAt: !645)
!647 = !DILocation(line: 183, column: 1, scope: !587, inlinedAt: !645)
!648 = !DILocation(line: 183, column: 1, scope: !588, inlinedAt: !645)
!649 = distinct !{!649, !646, !646, !387, !388}
!650 = !DILocation(line: 65, column: 1, scope: !633)
!651 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 67, type: !652, scopeLine: 67, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !654)
!652 = !DISubroutineType(types: !653)
!653 = !{!201, !234, !234}
!654 = !{!655, !656, !657, !658, !659, !660, !661}
!655 = !DILocalVariable(name: "vdata", arg: 1, scope: !651, file: !189, line: 67, type: !234)
!656 = !DILocalVariable(name: "vref", arg: 2, scope: !651, file: !189, line: 67, type: !234)
!657 = !DILocalVariable(name: "data", scope: !651, file: !189, line: 68, type: !191)
!658 = !DILocalVariable(name: "ref", scope: !651, file: !189, line: 69, type: !191)
!659 = !DILocalVariable(name: "has_errors", scope: !651, file: !189, line: 70, type: !201)
!660 = !DILocalVariable(name: "i", scope: !651, file: !189, line: 71, type: !201)
!661 = !DILocalVariable(name: "diff", scope: !651, file: !189, line: 72, type: !197)
!662 = !DILocation(line: 0, scope: !651)
!663 = !DILocation(line: 74, column: 3, scope: !664)
!664 = distinct !DILexicalBlock(scope: !651, file: !189, line: 74, column: 3)
!665 = !DILocation(line: 75, column: 12, scope: !666)
!666 = distinct !DILexicalBlock(scope: !667, file: !189, line: 74, column: 25)
!667 = distinct !DILexicalBlock(scope: !664, file: !189, line: 74, column: 3)
!668 = !DILocation(line: 75, column: 27, scope: !666)
!669 = !DILocation(line: 76, column: 35, scope: !666)
!670 = !DILocation(line: 76, column: 16, scope: !666)
!671 = !DILocation(line: 74, column: 21, scope: !667)
!672 = !DILocation(line: 74, column: 13, scope: !667)
!673 = distinct !{!673, !663, !674, !387, !388}
!674 = !DILocation(line: 77, column: 3, scope: !664)
!675 = !DILocation(line: 80, column: 10, scope: !651)
!676 = !DILocation(line: 80, column: 3, scope: !651)
!677 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !678, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !680)
!678 = !DISubroutineType(types: !679)
!679 = !{!233, !201}
!680 = !{!681, !682, !683, !720, !723, !726}
!681 = !DILocalVariable(name: "fd", arg: 1, scope: !677, file: !2, line: 34, type: !201)
!682 = !DILocalVariable(name: "p", scope: !677, file: !2, line: 35, type: !233)
!683 = !DILocalVariable(name: "s", scope: !677, file: !2, line: 36, type: !684)
!684 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !685, line: 44, size: 1024, elements: !686)
!685 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!686 = !{!687, !689, !691, !693, !695, !697, !699, !700, !701, !703, !705, !706, !708, !716, !717, !718}
!687 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !684, file: !685, line: 46, baseType: !688, size: 64)
!688 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !200, line: 145, baseType: !247)
!689 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !684, file: !685, line: 47, baseType: !690, size: 64, offset: 64)
!690 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !200, line: 148, baseType: !247)
!691 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !684, file: !685, line: 48, baseType: !692, size: 32, offset: 128)
!692 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !200, line: 150, baseType: !244)
!693 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !684, file: !685, line: 49, baseType: !694, size: 32, offset: 160)
!694 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !200, line: 151, baseType: !244)
!695 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !684, file: !685, line: 50, baseType: !696, size: 32, offset: 192)
!696 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !200, line: 146, baseType: !244)
!697 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !684, file: !685, line: 51, baseType: !698, size: 32, offset: 224)
!698 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !200, line: 147, baseType: !244)
!699 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !684, file: !685, line: 52, baseType: !688, size: 64, offset: 256)
!700 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !684, file: !685, line: 53, baseType: !688, size: 64, offset: 320)
!701 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !684, file: !685, line: 54, baseType: !702, size: 64, offset: 384)
!702 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !200, line: 152, baseType: !256)
!703 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !684, file: !685, line: 55, baseType: !704, size: 32, offset: 448)
!704 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !200, line: 175, baseType: !201)
!705 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !684, file: !685, line: 56, baseType: !201, size: 32, offset: 480)
!706 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !684, file: !685, line: 57, baseType: !707, size: 64, offset: 512)
!707 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !200, line: 180, baseType: !256)
!708 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !684, file: !685, line: 65, baseType: !709, size: 128, offset: 576)
!709 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !710, line: 11, size: 128, elements: !711)
!710 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!711 = !{!712, !714}
!712 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !709, file: !710, line: 16, baseType: !713, size: 64)
!713 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !200, line: 160, baseType: !256)
!714 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !709, file: !710, line: 21, baseType: !715, size: 64, offset: 64)
!715 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !200, line: 197, baseType: !256)
!716 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !684, file: !685, line: 66, baseType: !709, size: 128, offset: 704)
!717 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !684, file: !685, line: 67, baseType: !709, size: 128, offset: 832)
!718 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !684, file: !685, line: 79, baseType: !719, size: 64, offset: 960)
!719 = !DICompositeType(tag: DW_TAG_array_type, baseType: !201, size: 64, elements: !55)
!720 = !DILocalVariable(name: "len", scope: !677, file: !2, line: 37, type: !721)
!721 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !722, line: 85, baseType: !702)
!722 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!723 = !DILocalVariable(name: "bytes_read", scope: !677, file: !2, line: 38, type: !724)
!724 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !722, line: 108, baseType: !725)
!725 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !200, line: 194, baseType: !256)
!726 = !DILocalVariable(name: "status", scope: !677, file: !2, line: 38, type: !724)
!727 = distinct !DIAssignID()
!728 = !DILocation(line: 0, scope: !677)
!729 = !DILocation(line: 36, column: 3, scope: !677)
!730 = !DILocation(line: 40, column: 3, scope: !731)
!731 = distinct !DILexicalBlock(scope: !732, file: !2, line: 40, column: 3)
!732 = distinct !DILexicalBlock(scope: !677, file: !2, line: 40, column: 3)
!733 = !DILocation(line: 41, column: 3, scope: !734)
!734 = distinct !DILexicalBlock(scope: !735, file: !2, line: 41, column: 3)
!735 = distinct !DILexicalBlock(scope: !677, file: !2, line: 41, column: 3)
!736 = !DILocation(line: 42, column: 11, scope: !677)
!737 = !DILocation(line: 43, column: 3, scope: !738)
!738 = distinct !DILexicalBlock(scope: !739, file: !2, line: 43, column: 3)
!739 = distinct !DILexicalBlock(scope: !677, file: !2, line: 43, column: 3)
!740 = !DILocation(line: 44, column: 25, scope: !677)
!741 = !DILocation(line: 44, column: 15, scope: !677)
!742 = !DILocation(line: 46, column: 3, scope: !677)
!743 = !DILocation(line: 49, column: 15, scope: !744)
!744 = distinct !DILexicalBlock(scope: !677, file: !2, line: 46, column: 27)
!745 = !DILocation(line: 46, column: 20, scope: !677)
!746 = distinct !{!746, !742, !747, !387, !388}
!747 = !DILocation(line: 50, column: 3, scope: !677)
!748 = !DILocation(line: 47, column: 24, scope: !744)
!749 = !DILocation(line: 47, column: 42, scope: !744)
!750 = !DILocation(line: 47, column: 14, scope: !744)
!751 = !DILocation(line: 48, column: 5, scope: !752)
!752 = distinct !DILexicalBlock(scope: !753, file: !2, line: 48, column: 5)
!753 = distinct !DILexicalBlock(scope: !744, file: !2, line: 48, column: 5)
!754 = !DILocation(line: 51, column: 3, scope: !677)
!755 = !DILocation(line: 51, column: 10, scope: !677)
!756 = !DILocation(line: 52, column: 3, scope: !677)
!757 = !DILocation(line: 54, column: 1, scope: !677)
!758 = !DILocation(line: 53, column: 3, scope: !677)
!759 = !DISubprogram(name: "__assert_fail", scope: !760, file: !760, line: 67, type: !761, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!760 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!761 = !DISubroutineType(types: !762)
!762 = !{null, !763, !763, !244, !763}
!763 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!764 = !DISubprogram(name: "fstat", scope: !765, file: !765, line: 210, type: !766, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!765 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!766 = !DISubroutineType(types: !767)
!767 = !{!201, !201, !768}
!768 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !684, size: 64)
!769 = !DISubprogram(name: "malloc", scope: !556, file: !556, line: 672, type: !770, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!770 = !DISubroutineType(types: !771)
!771 = !{!234, !772}
!772 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !773, line: 18, baseType: !247)
!773 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!774 = !DISubprogram(name: "read", scope: !775, file: !775, line: 371, type: !776, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!775 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!776 = !DISubroutineType(types: !777)
!777 = !{!724, !201, !234, !772}
!778 = !DISubprogram(name: "close", scope: !775, file: !775, line: 358, type: !565, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!779 = !DILocation(line: 0, scope: !504)
!780 = !DILocation(line: 59, column: 3, scope: !781)
!781 = distinct !DILexicalBlock(scope: !782, file: !2, line: 59, column: 3)
!782 = distinct !DILexicalBlock(scope: !504, file: !2, line: 59, column: 3)
!783 = !DILocation(line: 60, column: 7, scope: !784)
!784 = distinct !DILexicalBlock(scope: !504, file: !2, line: 60, column: 6)
!785 = !DILocation(line: 60, column: 6, scope: !504)
!786 = !DILocation(line: 64, column: 17, scope: !504)
!787 = !DILocation(line: 64, column: 3, scope: !504)
!788 = !DILocation(line: 66, column: 22, scope: !516)
!789 = !DILocation(line: 66, column: 26, scope: !516)
!790 = !DILocation(line: 66, column: 32, scope: !516)
!791 = !DILocation(line: 66, column: 35, scope: !516)
!792 = !DILocation(line: 66, column: 39, scope: !516)
!793 = !DILocation(line: 66, column: 9, scope: !517)
!794 = !DILocation(line: 69, column: 6, scope: !517)
!795 = !DILocation(line: 64, column: 10, scope: !504)
!796 = !DILocation(line: 64, column: 13, scope: !504)
!797 = distinct !{!797, !787, !798, !387, !388}
!798 = !DILocation(line: 70, column: 3, scope: !504)
!799 = !DILocation(line: 71, column: 6, scope: !529)
!800 = !DILocation(line: 71, column: 8, scope: !529)
!801 = !DILocation(line: 71, column: 6, scope: !504)
!802 = !DILocation(line: 74, column: 1, scope: !504)
!803 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !804, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !806)
!804 = !DISubroutineType(types: !805)
!805 = !{!201, !233, !233, !201}
!806 = !{!807, !808, !809, !810}
!807 = !DILocalVariable(name: "s", arg: 1, scope: !803, file: !2, line: 77, type: !233)
!808 = !DILocalVariable(name: "arr", arg: 2, scope: !803, file: !2, line: 77, type: !233)
!809 = !DILocalVariable(name: "n", arg: 3, scope: !803, file: !2, line: 77, type: !201)
!810 = !DILocalVariable(name: "k", scope: !803, file: !2, line: 78, type: !201)
!811 = !DILocation(line: 0, scope: !803)
!812 = !DILocation(line: 79, column: 3, scope: !813)
!813 = distinct !DILexicalBlock(scope: !814, file: !2, line: 79, column: 3)
!814 = distinct !DILexicalBlock(scope: !803, file: !2, line: 79, column: 3)
!815 = !DILocation(line: 81, column: 8, scope: !816)
!816 = distinct !DILexicalBlock(scope: !803, file: !2, line: 81, column: 7)
!817 = !DILocation(line: 81, column: 7, scope: !803)
!818 = !DILocation(line: 83, column: 12, scope: !819)
!819 = distinct !DILexicalBlock(scope: !816, file: !2, line: 81, column: 13)
!820 = !DILocation(line: 83, column: 5, scope: !819)
!821 = !DILocation(line: 91, column: 19, scope: !803)
!822 = !DILocation(line: 91, column: 3, scope: !803)
!823 = !DILocation(line: 92, column: 7, scope: !803)
!824 = !DILocation(line: 83, column: 16, scope: !819)
!825 = !DILocation(line: 83, column: 26, scope: !819)
!826 = !DILocation(line: 83, column: 32, scope: !819)
!827 = !DILocation(line: 83, column: 29, scope: !819)
!828 = !DILocation(line: 83, column: 35, scope: !819)
!829 = !DILocation(line: 83, column: 45, scope: !819)
!830 = !DILocation(line: 83, column: 48, scope: !819)
!831 = !DILocation(line: 83, column: 54, scope: !819)
!832 = !DILocation(line: 84, column: 9, scope: !819)
!833 = !DILocation(line: 84, column: 18, scope: !819)
!834 = !DILocation(line: 84, column: 26, scope: !819)
!835 = distinct !{!835, !820, !836, !387, !388}
!836 = !DILocation(line: 86, column: 5, scope: !819)
!837 = !DILocation(line: 93, column: 5, scope: !838)
!838 = distinct !DILexicalBlock(scope: !803, file: !2, line: 92, column: 7)
!839 = !DILocation(line: 93, column: 12, scope: !838)
!840 = !DILocation(line: 95, column: 3, scope: !803)
!841 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !842, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !845)
!842 = !DISubroutineType(types: !843)
!843 = !{!201, !233, !844, !201}
!844 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !235, size: 64)
!845 = !{!846, !847, !848, !849, !850, !851, !852}
!846 = !DILocalVariable(name: "s", arg: 1, scope: !841, file: !2, line: 132, type: !233)
!847 = !DILocalVariable(name: "arr", arg: 2, scope: !841, file: !2, line: 132, type: !844)
!848 = !DILocalVariable(name: "n", arg: 3, scope: !841, file: !2, line: 132, type: !201)
!849 = !DILocalVariable(name: "line", scope: !841, file: !2, line: 132, type: !233)
!850 = !DILocalVariable(name: "endptr", scope: !841, file: !2, line: 132, type: !233)
!851 = !DILocalVariable(name: "i", scope: !841, file: !2, line: 132, type: !201)
!852 = !DILocalVariable(name: "v", scope: !841, file: !2, line: 132, type: !235)
!853 = distinct !DIAssignID()
!854 = !DILocation(line: 0, scope: !841)
!855 = !DILocation(line: 132, column: 1, scope: !841)
!856 = !DILocation(line: 132, column: 1, scope: !857)
!857 = distinct !DILexicalBlock(scope: !858, file: !2, line: 132, column: 1)
!858 = distinct !DILexicalBlock(scope: !841, file: !2, line: 132, column: 1)
!859 = !DILocation(line: 132, column: 1, scope: !860)
!860 = distinct !DILexicalBlock(scope: !841, file: !2, line: 132, column: 1)
!861 = !{!862, !862, i64 0}
!862 = !{!"any pointer", !376, i64 0}
!863 = distinct !DIAssignID()
!864 = !DILocation(line: 132, column: 1, scope: !865)
!865 = distinct !DILexicalBlock(scope: !860, file: !2, line: 132, column: 1)
!866 = !DILocation(line: 132, column: 1, scope: !867)
!867 = distinct !DILexicalBlock(scope: !865, file: !2, line: 132, column: 1)
!868 = distinct !{!868, !855, !855, !387, !388}
!869 = !DILocation(line: 132, column: 1, scope: !870)
!870 = distinct !DILexicalBlock(scope: !871, file: !2, line: 132, column: 1)
!871 = distinct !DILexicalBlock(scope: !841, file: !2, line: 132, column: 1)
!872 = !DISubprogram(name: "strtok", scope: !873, file: !873, line: 356, type: !874, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!873 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!874 = !DISubroutineType(types: !875)
!875 = !{!233, !876, !877}
!876 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !233)
!877 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !763)
!878 = !DISubprogram(name: "strtol", scope: !556, file: !556, line: 177, type: !879, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!879 = !DISubroutineType(types: !880)
!880 = !{!256, !877, !881, !201}
!881 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !882)
!882 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !233, size: 64)
!883 = !DISubprogram(name: "fprintf", scope: !884, file: !884, line: 357, type: !885, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!884 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!885 = !DISubroutineType(types: !886)
!886 = !{!201, !887, !877, null}
!887 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !888)
!888 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !889, size: 64)
!889 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !890, line: 7, baseType: !891)
!890 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!891 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !892, line: 49, size: 1728, elements: !893)
!892 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!893 = !{!894, !895, !896, !897, !898, !899, !900, !901, !902, !903, !904, !905, !906, !909, !911, !912, !913, !914, !915, !916, !920, !923, !925, !928, !931, !932, !933, !935, !936}
!894 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !891, file: !892, line: 51, baseType: !201, size: 32)
!895 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !891, file: !892, line: 54, baseType: !233, size: 64, offset: 64)
!896 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !891, file: !892, line: 55, baseType: !233, size: 64, offset: 128)
!897 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !891, file: !892, line: 56, baseType: !233, size: 64, offset: 192)
!898 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !891, file: !892, line: 57, baseType: !233, size: 64, offset: 256)
!899 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !891, file: !892, line: 58, baseType: !233, size: 64, offset: 320)
!900 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !891, file: !892, line: 59, baseType: !233, size: 64, offset: 384)
!901 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !891, file: !892, line: 60, baseType: !233, size: 64, offset: 448)
!902 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !891, file: !892, line: 61, baseType: !233, size: 64, offset: 512)
!903 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !891, file: !892, line: 64, baseType: !233, size: 64, offset: 576)
!904 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !891, file: !892, line: 65, baseType: !233, size: 64, offset: 640)
!905 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !891, file: !892, line: 66, baseType: !233, size: 64, offset: 704)
!906 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !891, file: !892, line: 68, baseType: !907, size: 64, offset: 768)
!907 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !908, size: 64)
!908 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !892, line: 36, flags: DIFlagFwdDecl)
!909 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !891, file: !892, line: 70, baseType: !910, size: 64, offset: 832)
!910 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !891, size: 64)
!911 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !891, file: !892, line: 72, baseType: !201, size: 32, offset: 896)
!912 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !891, file: !892, line: 73, baseType: !201, size: 32, offset: 928)
!913 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !891, file: !892, line: 74, baseType: !702, size: 64, offset: 960)
!914 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !891, file: !892, line: 77, baseType: !241, size: 16, offset: 1024)
!915 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !891, file: !892, line: 78, baseType: !250, size: 8, offset: 1040)
!916 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !891, file: !892, line: 79, baseType: !917, size: 8, offset: 1048)
!917 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !918)
!918 = !{!919}
!919 = !DISubrange(count: 1)
!920 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !891, file: !892, line: 81, baseType: !921, size: 64, offset: 1088)
!921 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !922, size: 64)
!922 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !892, line: 43, baseType: null)
!923 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !891, file: !892, line: 89, baseType: !924, size: 64, offset: 1152)
!924 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !200, line: 153, baseType: !256)
!925 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !891, file: !892, line: 91, baseType: !926, size: 64, offset: 1216)
!926 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !927, size: 64)
!927 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !892, line: 37, flags: DIFlagFwdDecl)
!928 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !891, file: !892, line: 92, baseType: !929, size: 64, offset: 1280)
!929 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !930, size: 64)
!930 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !892, line: 38, flags: DIFlagFwdDecl)
!931 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !891, file: !892, line: 93, baseType: !910, size: 64, offset: 1344)
!932 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !891, file: !892, line: 94, baseType: !234, size: 64, offset: 1408)
!933 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !891, file: !892, line: 95, baseType: !934, size: 64, offset: 1472)
!934 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !910, size: 64)
!935 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !891, file: !892, line: 96, baseType: !201, size: 32, offset: 1536)
!936 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !891, file: !892, line: 98, baseType: !937, size: 160, offset: 1568)
!937 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!938 = !DISubprogram(name: "strlen", scope: !873, file: !873, line: 407, type: !939, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!939 = !DISubroutineType(types: !940)
!940 = !{!247, !763}
!941 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !942, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !945)
!942 = !DISubroutineType(types: !943)
!943 = !{!201, !233, !944, !201}
!944 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !239, size: 64)
!945 = !{!946, !947, !948, !949, !950, !951, !952}
!946 = !DILocalVariable(name: "s", arg: 1, scope: !941, file: !2, line: 133, type: !233)
!947 = !DILocalVariable(name: "arr", arg: 2, scope: !941, file: !2, line: 133, type: !944)
!948 = !DILocalVariable(name: "n", arg: 3, scope: !941, file: !2, line: 133, type: !201)
!949 = !DILocalVariable(name: "line", scope: !941, file: !2, line: 133, type: !233)
!950 = !DILocalVariable(name: "endptr", scope: !941, file: !2, line: 133, type: !233)
!951 = !DILocalVariable(name: "i", scope: !941, file: !2, line: 133, type: !201)
!952 = !DILocalVariable(name: "v", scope: !941, file: !2, line: 133, type: !239)
!953 = distinct !DIAssignID()
!954 = !DILocation(line: 0, scope: !941)
!955 = !DILocation(line: 133, column: 1, scope: !941)
!956 = !DILocation(line: 133, column: 1, scope: !957)
!957 = distinct !DILexicalBlock(scope: !958, file: !2, line: 133, column: 1)
!958 = distinct !DILexicalBlock(scope: !941, file: !2, line: 133, column: 1)
!959 = !DILocation(line: 133, column: 1, scope: !960)
!960 = distinct !DILexicalBlock(scope: !941, file: !2, line: 133, column: 1)
!961 = distinct !DIAssignID()
!962 = !DILocation(line: 133, column: 1, scope: !963)
!963 = distinct !DILexicalBlock(scope: !960, file: !2, line: 133, column: 1)
!964 = !DILocation(line: 133, column: 1, scope: !965)
!965 = distinct !DILexicalBlock(scope: !963, file: !2, line: 133, column: 1)
!966 = !{!967, !967, i64 0}
!967 = !{!"short", !376, i64 0}
!968 = distinct !{!968, !955, !955, !387, !388}
!969 = !DILocation(line: 133, column: 1, scope: !970)
!970 = distinct !DILexicalBlock(scope: !971, file: !2, line: 133, column: 1)
!971 = distinct !DILexicalBlock(scope: !941, file: !2, line: 133, column: 1)
!972 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !973, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !976)
!973 = !DISubroutineType(types: !974)
!974 = !{!201, !233, !975, !201}
!975 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !242, size: 64)
!976 = !{!977, !978, !979, !980, !981, !982, !983}
!977 = !DILocalVariable(name: "s", arg: 1, scope: !972, file: !2, line: 134, type: !233)
!978 = !DILocalVariable(name: "arr", arg: 2, scope: !972, file: !2, line: 134, type: !975)
!979 = !DILocalVariable(name: "n", arg: 3, scope: !972, file: !2, line: 134, type: !201)
!980 = !DILocalVariable(name: "line", scope: !972, file: !2, line: 134, type: !233)
!981 = !DILocalVariable(name: "endptr", scope: !972, file: !2, line: 134, type: !233)
!982 = !DILocalVariable(name: "i", scope: !972, file: !2, line: 134, type: !201)
!983 = !DILocalVariable(name: "v", scope: !972, file: !2, line: 134, type: !242)
!984 = distinct !DIAssignID()
!985 = !DILocation(line: 0, scope: !972)
!986 = !DILocation(line: 134, column: 1, scope: !972)
!987 = !DILocation(line: 134, column: 1, scope: !988)
!988 = distinct !DILexicalBlock(scope: !989, file: !2, line: 134, column: 1)
!989 = distinct !DILexicalBlock(scope: !972, file: !2, line: 134, column: 1)
!990 = !DILocation(line: 134, column: 1, scope: !991)
!991 = distinct !DILexicalBlock(scope: !972, file: !2, line: 134, column: 1)
!992 = distinct !DIAssignID()
!993 = !DILocation(line: 134, column: 1, scope: !994)
!994 = distinct !DILexicalBlock(scope: !991, file: !2, line: 134, column: 1)
!995 = !DILocation(line: 134, column: 1, scope: !996)
!996 = distinct !DILexicalBlock(scope: !994, file: !2, line: 134, column: 1)
!997 = distinct !{!997, !986, !986, !387, !388}
!998 = !DILocation(line: 134, column: 1, scope: !999)
!999 = distinct !DILexicalBlock(scope: !1000, file: !2, line: 134, column: 1)
!1000 = distinct !DILexicalBlock(scope: !972, file: !2, line: 134, column: 1)
!1001 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !1002, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1005)
!1002 = !DISubroutineType(types: !1003)
!1003 = !{!201, !233, !1004, !201}
!1004 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !245, size: 64)
!1005 = !{!1006, !1007, !1008, !1009, !1010, !1011, !1012}
!1006 = !DILocalVariable(name: "s", arg: 1, scope: !1001, file: !2, line: 135, type: !233)
!1007 = !DILocalVariable(name: "arr", arg: 2, scope: !1001, file: !2, line: 135, type: !1004)
!1008 = !DILocalVariable(name: "n", arg: 3, scope: !1001, file: !2, line: 135, type: !201)
!1009 = !DILocalVariable(name: "line", scope: !1001, file: !2, line: 135, type: !233)
!1010 = !DILocalVariable(name: "endptr", scope: !1001, file: !2, line: 135, type: !233)
!1011 = !DILocalVariable(name: "i", scope: !1001, file: !2, line: 135, type: !201)
!1012 = !DILocalVariable(name: "v", scope: !1001, file: !2, line: 135, type: !245)
!1013 = distinct !DIAssignID()
!1014 = !DILocation(line: 0, scope: !1001)
!1015 = !DILocation(line: 135, column: 1, scope: !1001)
!1016 = !DILocation(line: 135, column: 1, scope: !1017)
!1017 = distinct !DILexicalBlock(scope: !1018, file: !2, line: 135, column: 1)
!1018 = distinct !DILexicalBlock(scope: !1001, file: !2, line: 135, column: 1)
!1019 = !DILocation(line: 135, column: 1, scope: !1020)
!1020 = distinct !DILexicalBlock(scope: !1001, file: !2, line: 135, column: 1)
!1021 = distinct !DIAssignID()
!1022 = !DILocation(line: 135, column: 1, scope: !1023)
!1023 = distinct !DILexicalBlock(scope: !1020, file: !2, line: 135, column: 1)
!1024 = !DILocation(line: 135, column: 1, scope: !1025)
!1025 = distinct !DILexicalBlock(scope: !1023, file: !2, line: 135, column: 1)
!1026 = !{!1027, !1027, i64 0}
!1027 = !{!"long", !376, i64 0}
!1028 = distinct !{!1028, !1015, !1015, !387, !388}
!1029 = !DILocation(line: 135, column: 1, scope: !1030)
!1030 = distinct !DILexicalBlock(scope: !1031, file: !2, line: 135, column: 1)
!1031 = distinct !DILexicalBlock(scope: !1001, file: !2, line: 135, column: 1)
!1032 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1033, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1036)
!1033 = !DISubroutineType(types: !1034)
!1034 = !{!201, !233, !1035, !201}
!1035 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !248, size: 64)
!1036 = !{!1037, !1038, !1039, !1040, !1041, !1042, !1043}
!1037 = !DILocalVariable(name: "s", arg: 1, scope: !1032, file: !2, line: 136, type: !233)
!1038 = !DILocalVariable(name: "arr", arg: 2, scope: !1032, file: !2, line: 136, type: !1035)
!1039 = !DILocalVariable(name: "n", arg: 3, scope: !1032, file: !2, line: 136, type: !201)
!1040 = !DILocalVariable(name: "line", scope: !1032, file: !2, line: 136, type: !233)
!1041 = !DILocalVariable(name: "endptr", scope: !1032, file: !2, line: 136, type: !233)
!1042 = !DILocalVariable(name: "i", scope: !1032, file: !2, line: 136, type: !201)
!1043 = !DILocalVariable(name: "v", scope: !1032, file: !2, line: 136, type: !248)
!1044 = distinct !DIAssignID()
!1045 = !DILocation(line: 0, scope: !1032)
!1046 = !DILocation(line: 136, column: 1, scope: !1032)
!1047 = !DILocation(line: 136, column: 1, scope: !1048)
!1048 = distinct !DILexicalBlock(scope: !1049, file: !2, line: 136, column: 1)
!1049 = distinct !DILexicalBlock(scope: !1032, file: !2, line: 136, column: 1)
!1050 = !DILocation(line: 136, column: 1, scope: !1051)
!1051 = distinct !DILexicalBlock(scope: !1032, file: !2, line: 136, column: 1)
!1052 = distinct !DIAssignID()
!1053 = !DILocation(line: 136, column: 1, scope: !1054)
!1054 = distinct !DILexicalBlock(scope: !1051, file: !2, line: 136, column: 1)
!1055 = !DILocation(line: 136, column: 1, scope: !1056)
!1056 = distinct !DILexicalBlock(scope: !1054, file: !2, line: 136, column: 1)
!1057 = distinct !{!1057, !1046, !1046, !387, !388}
!1058 = !DILocation(line: 136, column: 1, scope: !1059)
!1059 = distinct !DILexicalBlock(scope: !1060, file: !2, line: 136, column: 1)
!1060 = distinct !DILexicalBlock(scope: !1032, file: !2, line: 136, column: 1)
!1061 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1062, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1065)
!1062 = !DISubroutineType(types: !1063)
!1063 = !{!201, !233, !1064, !201}
!1064 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !251, size: 64)
!1065 = !{!1066, !1067, !1068, !1069, !1070, !1071, !1072}
!1066 = !DILocalVariable(name: "s", arg: 1, scope: !1061, file: !2, line: 137, type: !233)
!1067 = !DILocalVariable(name: "arr", arg: 2, scope: !1061, file: !2, line: 137, type: !1064)
!1068 = !DILocalVariable(name: "n", arg: 3, scope: !1061, file: !2, line: 137, type: !201)
!1069 = !DILocalVariable(name: "line", scope: !1061, file: !2, line: 137, type: !233)
!1070 = !DILocalVariable(name: "endptr", scope: !1061, file: !2, line: 137, type: !233)
!1071 = !DILocalVariable(name: "i", scope: !1061, file: !2, line: 137, type: !201)
!1072 = !DILocalVariable(name: "v", scope: !1061, file: !2, line: 137, type: !251)
!1073 = distinct !DIAssignID()
!1074 = !DILocation(line: 0, scope: !1061)
!1075 = !DILocation(line: 137, column: 1, scope: !1061)
!1076 = !DILocation(line: 137, column: 1, scope: !1077)
!1077 = distinct !DILexicalBlock(scope: !1078, file: !2, line: 137, column: 1)
!1078 = distinct !DILexicalBlock(scope: !1061, file: !2, line: 137, column: 1)
!1079 = !DILocation(line: 137, column: 1, scope: !1080)
!1080 = distinct !DILexicalBlock(scope: !1061, file: !2, line: 137, column: 1)
!1081 = distinct !DIAssignID()
!1082 = !DILocation(line: 137, column: 1, scope: !1083)
!1083 = distinct !DILexicalBlock(scope: !1080, file: !2, line: 137, column: 1)
!1084 = !DILocation(line: 137, column: 1, scope: !1085)
!1085 = distinct !DILexicalBlock(scope: !1083, file: !2, line: 137, column: 1)
!1086 = distinct !{!1086, !1075, !1075, !387, !388}
!1087 = !DILocation(line: 137, column: 1, scope: !1088)
!1088 = distinct !DILexicalBlock(scope: !1089, file: !2, line: 137, column: 1)
!1089 = distinct !DILexicalBlock(scope: !1061, file: !2, line: 137, column: 1)
!1090 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1091, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1093)
!1091 = !DISubroutineType(types: !1092)
!1092 = !{!201, !233, !329, !201}
!1093 = !{!1094, !1095, !1096, !1097, !1098, !1099, !1100}
!1094 = !DILocalVariable(name: "s", arg: 1, scope: !1090, file: !2, line: 138, type: !233)
!1095 = !DILocalVariable(name: "arr", arg: 2, scope: !1090, file: !2, line: 138, type: !329)
!1096 = !DILocalVariable(name: "n", arg: 3, scope: !1090, file: !2, line: 138, type: !201)
!1097 = !DILocalVariable(name: "line", scope: !1090, file: !2, line: 138, type: !233)
!1098 = !DILocalVariable(name: "endptr", scope: !1090, file: !2, line: 138, type: !233)
!1099 = !DILocalVariable(name: "i", scope: !1090, file: !2, line: 138, type: !201)
!1100 = !DILocalVariable(name: "v", scope: !1090, file: !2, line: 138, type: !197)
!1101 = distinct !DIAssignID()
!1102 = !DILocation(line: 0, scope: !1090)
!1103 = !DILocation(line: 138, column: 1, scope: !1090)
!1104 = !DILocation(line: 138, column: 1, scope: !1105)
!1105 = distinct !DILexicalBlock(scope: !1106, file: !2, line: 138, column: 1)
!1106 = distinct !DILexicalBlock(scope: !1090, file: !2, line: 138, column: 1)
!1107 = !DILocation(line: 138, column: 1, scope: !1108)
!1108 = distinct !DILexicalBlock(scope: !1090, file: !2, line: 138, column: 1)
!1109 = distinct !DIAssignID()
!1110 = !DILocation(line: 138, column: 1, scope: !1111)
!1111 = distinct !DILexicalBlock(scope: !1108, file: !2, line: 138, column: 1)
!1112 = !DILocation(line: 138, column: 1, scope: !1113)
!1113 = distinct !DILexicalBlock(scope: !1111, file: !2, line: 138, column: 1)
!1114 = distinct !{!1114, !1103, !1103, !387, !388}
!1115 = !DILocation(line: 138, column: 1, scope: !1116)
!1116 = distinct !DILexicalBlock(scope: !1117, file: !2, line: 138, column: 1)
!1117 = distinct !DILexicalBlock(scope: !1090, file: !2, line: 138, column: 1)
!1118 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1119, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1122)
!1119 = !DISubroutineType(types: !1120)
!1120 = !{!201, !233, !1121, !201}
!1121 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 64)
!1122 = !{!1123, !1124, !1125, !1126, !1127, !1128, !1129}
!1123 = !DILocalVariable(name: "s", arg: 1, scope: !1118, file: !2, line: 139, type: !233)
!1124 = !DILocalVariable(name: "arr", arg: 2, scope: !1118, file: !2, line: 139, type: !1121)
!1125 = !DILocalVariable(name: "n", arg: 3, scope: !1118, file: !2, line: 139, type: !201)
!1126 = !DILocalVariable(name: "line", scope: !1118, file: !2, line: 139, type: !233)
!1127 = !DILocalVariable(name: "endptr", scope: !1118, file: !2, line: 139, type: !233)
!1128 = !DILocalVariable(name: "i", scope: !1118, file: !2, line: 139, type: !201)
!1129 = !DILocalVariable(name: "v", scope: !1118, file: !2, line: 139, type: !254)
!1130 = distinct !DIAssignID()
!1131 = !DILocation(line: 0, scope: !1118)
!1132 = !DILocation(line: 139, column: 1, scope: !1118)
!1133 = !DILocation(line: 139, column: 1, scope: !1134)
!1134 = distinct !DILexicalBlock(scope: !1135, file: !2, line: 139, column: 1)
!1135 = distinct !DILexicalBlock(scope: !1118, file: !2, line: 139, column: 1)
!1136 = !DILocation(line: 139, column: 1, scope: !1137)
!1137 = distinct !DILexicalBlock(scope: !1118, file: !2, line: 139, column: 1)
!1138 = distinct !DIAssignID()
!1139 = !DILocation(line: 139, column: 1, scope: !1140)
!1140 = distinct !DILexicalBlock(scope: !1137, file: !2, line: 139, column: 1)
!1141 = !DILocation(line: 139, column: 1, scope: !1142)
!1142 = distinct !DILexicalBlock(scope: !1140, file: !2, line: 139, column: 1)
!1143 = distinct !{!1143, !1132, !1132, !387, !388}
!1144 = !DILocation(line: 139, column: 1, scope: !1145)
!1145 = distinct !DILexicalBlock(scope: !1146, file: !2, line: 139, column: 1)
!1146 = distinct !DILexicalBlock(scope: !1118, file: !2, line: 139, column: 1)
!1147 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1148, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1151)
!1148 = !DISubroutineType(types: !1149)
!1149 = !{!201, !233, !1150, !201}
!1150 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !257, size: 64)
!1151 = !{!1152, !1153, !1154, !1155, !1156, !1157, !1158}
!1152 = !DILocalVariable(name: "s", arg: 1, scope: !1147, file: !2, line: 141, type: !233)
!1153 = !DILocalVariable(name: "arr", arg: 2, scope: !1147, file: !2, line: 141, type: !1150)
!1154 = !DILocalVariable(name: "n", arg: 3, scope: !1147, file: !2, line: 141, type: !201)
!1155 = !DILocalVariable(name: "line", scope: !1147, file: !2, line: 141, type: !233)
!1156 = !DILocalVariable(name: "endptr", scope: !1147, file: !2, line: 141, type: !233)
!1157 = !DILocalVariable(name: "i", scope: !1147, file: !2, line: 141, type: !201)
!1158 = !DILocalVariable(name: "v", scope: !1147, file: !2, line: 141, type: !257)
!1159 = distinct !DIAssignID()
!1160 = !DILocation(line: 0, scope: !1147)
!1161 = !DILocation(line: 141, column: 1, scope: !1147)
!1162 = !DILocation(line: 141, column: 1, scope: !1163)
!1163 = distinct !DILexicalBlock(scope: !1164, file: !2, line: 141, column: 1)
!1164 = distinct !DILexicalBlock(scope: !1147, file: !2, line: 141, column: 1)
!1165 = !DILocation(line: 141, column: 1, scope: !1166)
!1166 = distinct !DILexicalBlock(scope: !1147, file: !2, line: 141, column: 1)
!1167 = distinct !DIAssignID()
!1168 = !DILocation(line: 141, column: 1, scope: !1169)
!1169 = distinct !DILexicalBlock(scope: !1166, file: !2, line: 141, column: 1)
!1170 = !DILocation(line: 141, column: 1, scope: !1171)
!1171 = distinct !DILexicalBlock(scope: !1169, file: !2, line: 141, column: 1)
!1172 = !{!1173, !1173, i64 0}
!1173 = !{!"float", !376, i64 0}
!1174 = distinct !{!1174, !1161, !1161, !387, !388}
!1175 = !DILocation(line: 141, column: 1, scope: !1176)
!1176 = distinct !DILexicalBlock(scope: !1177, file: !2, line: 141, column: 1)
!1177 = distinct !DILexicalBlock(scope: !1147, file: !2, line: 141, column: 1)
!1178 = !DISubprogram(name: "strtof", scope: !556, file: !556, line: 124, type: !1179, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1179 = !DISubroutineType(types: !1180)
!1180 = !{!257, !877, !881}
!1181 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1182, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1185)
!1182 = !DISubroutineType(types: !1183)
!1183 = !{!201, !233, !1184, !201}
!1184 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !258, size: 64)
!1185 = !{!1186, !1187, !1188, !1189, !1190, !1191, !1192}
!1186 = !DILocalVariable(name: "s", arg: 1, scope: !1181, file: !2, line: 142, type: !233)
!1187 = !DILocalVariable(name: "arr", arg: 2, scope: !1181, file: !2, line: 142, type: !1184)
!1188 = !DILocalVariable(name: "n", arg: 3, scope: !1181, file: !2, line: 142, type: !201)
!1189 = !DILocalVariable(name: "line", scope: !1181, file: !2, line: 142, type: !233)
!1190 = !DILocalVariable(name: "endptr", scope: !1181, file: !2, line: 142, type: !233)
!1191 = !DILocalVariable(name: "i", scope: !1181, file: !2, line: 142, type: !201)
!1192 = !DILocalVariable(name: "v", scope: !1181, file: !2, line: 142, type: !258)
!1193 = distinct !DIAssignID()
!1194 = !DILocation(line: 0, scope: !1181)
!1195 = !DILocation(line: 142, column: 1, scope: !1181)
!1196 = !DILocation(line: 142, column: 1, scope: !1197)
!1197 = distinct !DILexicalBlock(scope: !1198, file: !2, line: 142, column: 1)
!1198 = distinct !DILexicalBlock(scope: !1181, file: !2, line: 142, column: 1)
!1199 = !DILocation(line: 142, column: 1, scope: !1200)
!1200 = distinct !DILexicalBlock(scope: !1181, file: !2, line: 142, column: 1)
!1201 = distinct !DIAssignID()
!1202 = !DILocation(line: 142, column: 1, scope: !1203)
!1203 = distinct !DILexicalBlock(scope: !1200, file: !2, line: 142, column: 1)
!1204 = !DILocation(line: 142, column: 1, scope: !1205)
!1205 = distinct !DILexicalBlock(scope: !1203, file: !2, line: 142, column: 1)
!1206 = !{!1207, !1207, i64 0}
!1207 = !{!"double", !376, i64 0}
!1208 = distinct !{!1208, !1195, !1195, !387, !388}
!1209 = !DILocation(line: 142, column: 1, scope: !1210)
!1210 = distinct !DILexicalBlock(scope: !1211, file: !2, line: 142, column: 1)
!1211 = distinct !DILexicalBlock(scope: !1181, file: !2, line: 142, column: 1)
!1212 = !DISubprogram(name: "strtod", scope: !556, file: !556, line: 118, type: !1213, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1213 = !DISubroutineType(types: !1214)
!1214 = !{!258, !877, !881}
!1215 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1216, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1218)
!1216 = !DISubroutineType(types: !1217)
!1217 = !{!201, !201, !233, !201}
!1218 = !{!1219, !1220, !1221, !1222, !1223}
!1219 = !DILocalVariable(name: "fd", arg: 1, scope: !1215, file: !2, line: 145, type: !201)
!1220 = !DILocalVariable(name: "arr", arg: 2, scope: !1215, file: !2, line: 145, type: !233)
!1221 = !DILocalVariable(name: "n", arg: 3, scope: !1215, file: !2, line: 145, type: !201)
!1222 = !DILocalVariable(name: "status", scope: !1215, file: !2, line: 146, type: !201)
!1223 = !DILocalVariable(name: "written", scope: !1215, file: !2, line: 146, type: !201)
!1224 = !DILocation(line: 0, scope: !1215)
!1225 = !DILocation(line: 147, column: 3, scope: !1226)
!1226 = distinct !DILexicalBlock(scope: !1227, file: !2, line: 147, column: 3)
!1227 = distinct !DILexicalBlock(scope: !1215, file: !2, line: 147, column: 3)
!1228 = !DILocation(line: 148, column: 8, scope: !1229)
!1229 = distinct !DILexicalBlock(scope: !1215, file: !2, line: 148, column: 7)
!1230 = !DILocation(line: 148, column: 7, scope: !1215)
!1231 = !DILocation(line: 149, column: 9, scope: !1232)
!1232 = distinct !DILexicalBlock(scope: !1229, file: !2, line: 148, column: 13)
!1233 = !DILocation(line: 150, column: 3, scope: !1232)
!1234 = !DILocation(line: 152, column: 16, scope: !1215)
!1235 = !DILocation(line: 152, column: 3, scope: !1215)
!1236 = !DILocation(line: 158, column: 3, scope: !1215)
!1237 = !DILocation(line: 155, column: 13, scope: !1238)
!1238 = distinct !DILexicalBlock(scope: !1215, file: !2, line: 152, column: 20)
!1239 = distinct !{!1239, !1235, !1240, !387, !388}
!1240 = !DILocation(line: 156, column: 3, scope: !1215)
!1241 = !DILocation(line: 153, column: 25, scope: !1238)
!1242 = !DILocation(line: 153, column: 40, scope: !1238)
!1243 = !DILocation(line: 153, column: 39, scope: !1238)
!1244 = !DILocation(line: 153, column: 14, scope: !1238)
!1245 = !DILocation(line: 154, column: 5, scope: !1246)
!1246 = distinct !DILexicalBlock(scope: !1247, file: !2, line: 154, column: 5)
!1247 = distinct !DILexicalBlock(scope: !1238, file: !2, line: 154, column: 5)
!1248 = !DILocation(line: 159, column: 14, scope: !1249)
!1249 = distinct !DILexicalBlock(scope: !1215, file: !2, line: 158, column: 6)
!1250 = !DILocation(line: 160, column: 5, scope: !1251)
!1251 = distinct !DILexicalBlock(scope: !1252, file: !2, line: 160, column: 5)
!1252 = distinct !DILexicalBlock(scope: !1249, file: !2, line: 160, column: 5)
!1253 = !DILocation(line: 161, column: 17, scope: !1215)
!1254 = !DILocation(line: 161, column: 3, scope: !1249)
!1255 = distinct !{!1255, !1236, !1256, !387, !388}
!1256 = !DILocation(line: 161, column: 20, scope: !1215)
!1257 = !DILocation(line: 163, column: 3, scope: !1215)
!1258 = !DISubprogram(name: "write", scope: !775, file: !775, line: 378, type: !1259, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1259 = !DISubroutineType(types: !1260)
!1260 = !{!724, !201, !1261, !772}
!1261 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1262, size: 64)
!1262 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1263 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1264, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1266)
!1264 = !DISubroutineType(types: !1265)
!1265 = !{!201, !201, !844, !201}
!1266 = !{!1267, !1268, !1269, !1270}
!1267 = !DILocalVariable(name: "fd", arg: 1, scope: !1263, file: !2, line: 177, type: !201)
!1268 = !DILocalVariable(name: "arr", arg: 2, scope: !1263, file: !2, line: 177, type: !844)
!1269 = !DILocalVariable(name: "n", arg: 3, scope: !1263, file: !2, line: 177, type: !201)
!1270 = !DILocalVariable(name: "i", scope: !1263, file: !2, line: 177, type: !201)
!1271 = !DILocation(line: 0, scope: !1263)
!1272 = !DILocation(line: 177, column: 1, scope: !1273)
!1273 = distinct !DILexicalBlock(scope: !1274, file: !2, line: 177, column: 1)
!1274 = distinct !DILexicalBlock(scope: !1263, file: !2, line: 177, column: 1)
!1275 = !DILocation(line: 177, column: 1, scope: !1276)
!1276 = distinct !DILexicalBlock(scope: !1277, file: !2, line: 177, column: 1)
!1277 = distinct !DILexicalBlock(scope: !1263, file: !2, line: 177, column: 1)
!1278 = !DILocation(line: 177, column: 1, scope: !1277)
!1279 = !DILocation(line: 177, column: 1, scope: !1280)
!1280 = distinct !DILexicalBlock(scope: !1276, file: !2, line: 177, column: 1)
!1281 = distinct !{!1281, !1278, !1278, !387, !388}
!1282 = !DILocation(line: 177, column: 1, scope: !1263)
!1283 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1284, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1286)
!1284 = !DISubroutineType(cc: DW_CC_nocall, types: !1285)
!1285 = !{!201, !201, !763, null}
!1286 = !{!1287, !1288, !1289, !1293, !1294, !1295, !1296}
!1287 = !DILocalVariable(name: "fd", arg: 1, scope: !1283, file: !2, line: 15, type: !201)
!1288 = !DILocalVariable(name: "format", arg: 2, scope: !1283, file: !2, line: 15, type: !763)
!1289 = !DILocalVariable(name: "args", scope: !1283, file: !2, line: 16, type: !1290)
!1290 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1291, line: 12, baseType: !1292)
!1291 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1292 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !234)
!1293 = !DILocalVariable(name: "buffered", scope: !1283, file: !2, line: 17, type: !201)
!1294 = !DILocalVariable(name: "written", scope: !1283, file: !2, line: 17, type: !201)
!1295 = !DILocalVariable(name: "status", scope: !1283, file: !2, line: 17, type: !201)
!1296 = !DILocalVariable(name: "buffer", scope: !1283, file: !2, line: 18, type: !1297)
!1297 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !1298)
!1298 = !{!1299}
!1299 = !DISubrange(count: 256)
!1300 = distinct !DIAssignID()
!1301 = !DILocation(line: 0, scope: !1283)
!1302 = distinct !DIAssignID()
!1303 = !DILocation(line: 16, column: 3, scope: !1283)
!1304 = !DILocation(line: 18, column: 3, scope: !1283)
!1305 = !DILocation(line: 19, column: 3, scope: !1283)
!1306 = !DILocation(line: 20, column: 66, scope: !1283)
!1307 = !DILocation(line: 20, column: 14, scope: !1283)
!1308 = !DILocation(line: 21, column: 3, scope: !1283)
!1309 = !DILocation(line: 22, column: 3, scope: !1310)
!1310 = distinct !DILexicalBlock(scope: !1311, file: !2, line: 22, column: 3)
!1311 = distinct !DILexicalBlock(scope: !1283, file: !2, line: 22, column: 3)
!1312 = !DILocation(line: 24, column: 16, scope: !1283)
!1313 = !DILocation(line: 24, column: 3, scope: !1283)
!1314 = !DILocation(line: 27, column: 13, scope: !1315)
!1315 = distinct !DILexicalBlock(scope: !1283, file: !2, line: 24, column: 27)
!1316 = distinct !{!1316, !1313, !1317, !387, !388}
!1317 = !DILocation(line: 28, column: 3, scope: !1283)
!1318 = !DILocation(line: 25, column: 25, scope: !1315)
!1319 = !DILocation(line: 25, column: 50, scope: !1315)
!1320 = !DILocation(line: 25, column: 42, scope: !1315)
!1321 = !DILocation(line: 25, column: 14, scope: !1315)
!1322 = !DILocation(line: 26, column: 5, scope: !1323)
!1323 = distinct !DILexicalBlock(scope: !1324, file: !2, line: 26, column: 5)
!1324 = distinct !DILexicalBlock(scope: !1315, file: !2, line: 26, column: 5)
!1325 = !DILocation(line: 29, column: 3, scope: !1326)
!1326 = distinct !DILexicalBlock(scope: !1327, file: !2, line: 29, column: 3)
!1327 = distinct !DILexicalBlock(scope: !1283, file: !2, line: 29, column: 3)
!1328 = !DILocation(line: 31, column: 1, scope: !1283)
!1329 = !DILocation(line: 30, column: 3, scope: !1283)
!1330 = !DISubprogram(name: "vsnprintf", scope: !884, file: !884, line: 389, type: !1331, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1331 = !DISubroutineType(types: !1332)
!1332 = !{!201, !876, !772, !877, !1333}
!1333 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1334, line: 12, baseType: !1292)
!1334 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1335 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1336, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1338)
!1336 = !DISubroutineType(types: !1337)
!1337 = !{!201, !201, !944, !201}
!1338 = !{!1339, !1340, !1341, !1342}
!1339 = !DILocalVariable(name: "fd", arg: 1, scope: !1335, file: !2, line: 178, type: !201)
!1340 = !DILocalVariable(name: "arr", arg: 2, scope: !1335, file: !2, line: 178, type: !944)
!1341 = !DILocalVariable(name: "n", arg: 3, scope: !1335, file: !2, line: 178, type: !201)
!1342 = !DILocalVariable(name: "i", scope: !1335, file: !2, line: 178, type: !201)
!1343 = !DILocation(line: 0, scope: !1335)
!1344 = !DILocation(line: 178, column: 1, scope: !1345)
!1345 = distinct !DILexicalBlock(scope: !1346, file: !2, line: 178, column: 1)
!1346 = distinct !DILexicalBlock(scope: !1335, file: !2, line: 178, column: 1)
!1347 = !DILocation(line: 178, column: 1, scope: !1348)
!1348 = distinct !DILexicalBlock(scope: !1349, file: !2, line: 178, column: 1)
!1349 = distinct !DILexicalBlock(scope: !1335, file: !2, line: 178, column: 1)
!1350 = !DILocation(line: 178, column: 1, scope: !1349)
!1351 = !DILocation(line: 178, column: 1, scope: !1352)
!1352 = distinct !DILexicalBlock(scope: !1348, file: !2, line: 178, column: 1)
!1353 = distinct !{!1353, !1350, !1350, !387, !388}
!1354 = !DILocation(line: 178, column: 1, scope: !1335)
!1355 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1356, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1358)
!1356 = !DISubroutineType(types: !1357)
!1357 = !{!201, !201, !975, !201}
!1358 = !{!1359, !1360, !1361, !1362}
!1359 = !DILocalVariable(name: "fd", arg: 1, scope: !1355, file: !2, line: 179, type: !201)
!1360 = !DILocalVariable(name: "arr", arg: 2, scope: !1355, file: !2, line: 179, type: !975)
!1361 = !DILocalVariable(name: "n", arg: 3, scope: !1355, file: !2, line: 179, type: !201)
!1362 = !DILocalVariable(name: "i", scope: !1355, file: !2, line: 179, type: !201)
!1363 = !DILocation(line: 0, scope: !1355)
!1364 = !DILocation(line: 179, column: 1, scope: !1365)
!1365 = distinct !DILexicalBlock(scope: !1366, file: !2, line: 179, column: 1)
!1366 = distinct !DILexicalBlock(scope: !1355, file: !2, line: 179, column: 1)
!1367 = !DILocation(line: 179, column: 1, scope: !1368)
!1368 = distinct !DILexicalBlock(scope: !1369, file: !2, line: 179, column: 1)
!1369 = distinct !DILexicalBlock(scope: !1355, file: !2, line: 179, column: 1)
!1370 = !DILocation(line: 179, column: 1, scope: !1369)
!1371 = !DILocation(line: 179, column: 1, scope: !1372)
!1372 = distinct !DILexicalBlock(scope: !1368, file: !2, line: 179, column: 1)
!1373 = distinct !{!1373, !1370, !1370, !387, !388}
!1374 = !DILocation(line: 179, column: 1, scope: !1355)
!1375 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1376, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1378)
!1376 = !DISubroutineType(types: !1377)
!1377 = !{!201, !201, !1004, !201}
!1378 = !{!1379, !1380, !1381, !1382}
!1379 = !DILocalVariable(name: "fd", arg: 1, scope: !1375, file: !2, line: 180, type: !201)
!1380 = !DILocalVariable(name: "arr", arg: 2, scope: !1375, file: !2, line: 180, type: !1004)
!1381 = !DILocalVariable(name: "n", arg: 3, scope: !1375, file: !2, line: 180, type: !201)
!1382 = !DILocalVariable(name: "i", scope: !1375, file: !2, line: 180, type: !201)
!1383 = !DILocation(line: 0, scope: !1375)
!1384 = !DILocation(line: 180, column: 1, scope: !1385)
!1385 = distinct !DILexicalBlock(scope: !1386, file: !2, line: 180, column: 1)
!1386 = distinct !DILexicalBlock(scope: !1375, file: !2, line: 180, column: 1)
!1387 = !DILocation(line: 180, column: 1, scope: !1388)
!1388 = distinct !DILexicalBlock(scope: !1389, file: !2, line: 180, column: 1)
!1389 = distinct !DILexicalBlock(scope: !1375, file: !2, line: 180, column: 1)
!1390 = !DILocation(line: 180, column: 1, scope: !1389)
!1391 = !DILocation(line: 180, column: 1, scope: !1392)
!1392 = distinct !DILexicalBlock(scope: !1388, file: !2, line: 180, column: 1)
!1393 = distinct !{!1393, !1390, !1390, !387, !388}
!1394 = !DILocation(line: 180, column: 1, scope: !1375)
!1395 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1396, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1398)
!1396 = !DISubroutineType(types: !1397)
!1397 = !{!201, !201, !1035, !201}
!1398 = !{!1399, !1400, !1401, !1402}
!1399 = !DILocalVariable(name: "fd", arg: 1, scope: !1395, file: !2, line: 181, type: !201)
!1400 = !DILocalVariable(name: "arr", arg: 2, scope: !1395, file: !2, line: 181, type: !1035)
!1401 = !DILocalVariable(name: "n", arg: 3, scope: !1395, file: !2, line: 181, type: !201)
!1402 = !DILocalVariable(name: "i", scope: !1395, file: !2, line: 181, type: !201)
!1403 = !DILocation(line: 0, scope: !1395)
!1404 = !DILocation(line: 181, column: 1, scope: !1405)
!1405 = distinct !DILexicalBlock(scope: !1406, file: !2, line: 181, column: 1)
!1406 = distinct !DILexicalBlock(scope: !1395, file: !2, line: 181, column: 1)
!1407 = !DILocation(line: 181, column: 1, scope: !1408)
!1408 = distinct !DILexicalBlock(scope: !1409, file: !2, line: 181, column: 1)
!1409 = distinct !DILexicalBlock(scope: !1395, file: !2, line: 181, column: 1)
!1410 = !DILocation(line: 181, column: 1, scope: !1409)
!1411 = !DILocation(line: 181, column: 1, scope: !1412)
!1412 = distinct !DILexicalBlock(scope: !1408, file: !2, line: 181, column: 1)
!1413 = distinct !{!1413, !1410, !1410, !387, !388}
!1414 = !DILocation(line: 181, column: 1, scope: !1395)
!1415 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1416, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1418)
!1416 = !DISubroutineType(types: !1417)
!1417 = !{!201, !201, !1064, !201}
!1418 = !{!1419, !1420, !1421, !1422}
!1419 = !DILocalVariable(name: "fd", arg: 1, scope: !1415, file: !2, line: 182, type: !201)
!1420 = !DILocalVariable(name: "arr", arg: 2, scope: !1415, file: !2, line: 182, type: !1064)
!1421 = !DILocalVariable(name: "n", arg: 3, scope: !1415, file: !2, line: 182, type: !201)
!1422 = !DILocalVariable(name: "i", scope: !1415, file: !2, line: 182, type: !201)
!1423 = !DILocation(line: 0, scope: !1415)
!1424 = !DILocation(line: 182, column: 1, scope: !1425)
!1425 = distinct !DILexicalBlock(scope: !1426, file: !2, line: 182, column: 1)
!1426 = distinct !DILexicalBlock(scope: !1415, file: !2, line: 182, column: 1)
!1427 = !DILocation(line: 182, column: 1, scope: !1428)
!1428 = distinct !DILexicalBlock(scope: !1429, file: !2, line: 182, column: 1)
!1429 = distinct !DILexicalBlock(scope: !1415, file: !2, line: 182, column: 1)
!1430 = !DILocation(line: 182, column: 1, scope: !1429)
!1431 = !DILocation(line: 182, column: 1, scope: !1432)
!1432 = distinct !DILexicalBlock(scope: !1428, file: !2, line: 182, column: 1)
!1433 = distinct !{!1433, !1430, !1430, !387, !388}
!1434 = !DILocation(line: 182, column: 1, scope: !1415)
!1435 = !DILocation(line: 0, scope: !575)
!1436 = !DILocation(line: 183, column: 1, scope: !1437)
!1437 = distinct !DILexicalBlock(scope: !1438, file: !2, line: 183, column: 1)
!1438 = distinct !DILexicalBlock(scope: !575, file: !2, line: 183, column: 1)
!1439 = !DILocation(line: 183, column: 1, scope: !588)
!1440 = !DILocation(line: 183, column: 1, scope: !585)
!1441 = !DILocation(line: 183, column: 1, scope: !587)
!1442 = distinct !{!1442, !1440, !1440, !387, !388}
!1443 = !DILocation(line: 183, column: 1, scope: !575)
!1444 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1445, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1447)
!1445 = !DISubroutineType(types: !1446)
!1446 = !{!201, !201, !1121, !201}
!1447 = !{!1448, !1449, !1450, !1451}
!1448 = !DILocalVariable(name: "fd", arg: 1, scope: !1444, file: !2, line: 184, type: !201)
!1449 = !DILocalVariable(name: "arr", arg: 2, scope: !1444, file: !2, line: 184, type: !1121)
!1450 = !DILocalVariable(name: "n", arg: 3, scope: !1444, file: !2, line: 184, type: !201)
!1451 = !DILocalVariable(name: "i", scope: !1444, file: !2, line: 184, type: !201)
!1452 = !DILocation(line: 0, scope: !1444)
!1453 = !DILocation(line: 184, column: 1, scope: !1454)
!1454 = distinct !DILexicalBlock(scope: !1455, file: !2, line: 184, column: 1)
!1455 = distinct !DILexicalBlock(scope: !1444, file: !2, line: 184, column: 1)
!1456 = !DILocation(line: 184, column: 1, scope: !1457)
!1457 = distinct !DILexicalBlock(scope: !1458, file: !2, line: 184, column: 1)
!1458 = distinct !DILexicalBlock(scope: !1444, file: !2, line: 184, column: 1)
!1459 = !DILocation(line: 184, column: 1, scope: !1458)
!1460 = !DILocation(line: 184, column: 1, scope: !1461)
!1461 = distinct !DILexicalBlock(scope: !1457, file: !2, line: 184, column: 1)
!1462 = distinct !{!1462, !1459, !1459, !387, !388}
!1463 = !DILocation(line: 184, column: 1, scope: !1444)
!1464 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1465, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1467)
!1465 = !DISubroutineType(types: !1466)
!1466 = !{!201, !201, !1150, !201}
!1467 = !{!1468, !1469, !1470, !1471}
!1468 = !DILocalVariable(name: "fd", arg: 1, scope: !1464, file: !2, line: 186, type: !201)
!1469 = !DILocalVariable(name: "arr", arg: 2, scope: !1464, file: !2, line: 186, type: !1150)
!1470 = !DILocalVariable(name: "n", arg: 3, scope: !1464, file: !2, line: 186, type: !201)
!1471 = !DILocalVariable(name: "i", scope: !1464, file: !2, line: 186, type: !201)
!1472 = !DILocation(line: 0, scope: !1464)
!1473 = !DILocation(line: 186, column: 1, scope: !1474)
!1474 = distinct !DILexicalBlock(scope: !1475, file: !2, line: 186, column: 1)
!1475 = distinct !DILexicalBlock(scope: !1464, file: !2, line: 186, column: 1)
!1476 = !DILocation(line: 186, column: 1, scope: !1477)
!1477 = distinct !DILexicalBlock(scope: !1478, file: !2, line: 186, column: 1)
!1478 = distinct !DILexicalBlock(scope: !1464, file: !2, line: 186, column: 1)
!1479 = !DILocation(line: 186, column: 1, scope: !1478)
!1480 = !DILocation(line: 186, column: 1, scope: !1481)
!1481 = distinct !DILexicalBlock(scope: !1477, file: !2, line: 186, column: 1)
!1482 = distinct !{!1482, !1479, !1479, !387, !388}
!1483 = !DILocation(line: 186, column: 1, scope: !1464)
!1484 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !1485, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1487)
!1485 = !DISubroutineType(types: !1486)
!1486 = !{!201, !201, !1184, !201}
!1487 = !{!1488, !1489, !1490, !1491}
!1488 = !DILocalVariable(name: "fd", arg: 1, scope: !1484, file: !2, line: 187, type: !201)
!1489 = !DILocalVariable(name: "arr", arg: 2, scope: !1484, file: !2, line: 187, type: !1184)
!1490 = !DILocalVariable(name: "n", arg: 3, scope: !1484, file: !2, line: 187, type: !201)
!1491 = !DILocalVariable(name: "i", scope: !1484, file: !2, line: 187, type: !201)
!1492 = !DILocation(line: 0, scope: !1484)
!1493 = !DILocation(line: 187, column: 1, scope: !1494)
!1494 = distinct !DILexicalBlock(scope: !1495, file: !2, line: 187, column: 1)
!1495 = distinct !DILexicalBlock(scope: !1484, file: !2, line: 187, column: 1)
!1496 = !DILocation(line: 187, column: 1, scope: !1497)
!1497 = distinct !DILexicalBlock(scope: !1498, file: !2, line: 187, column: 1)
!1498 = distinct !DILexicalBlock(scope: !1484, file: !2, line: 187, column: 1)
!1499 = !DILocation(line: 187, column: 1, scope: !1498)
!1500 = !DILocation(line: 187, column: 1, scope: !1501)
!1501 = distinct !DILexicalBlock(scope: !1497, file: !2, line: 187, column: 1)
!1502 = distinct !{!1502, !1499, !1499, !387, !388}
!1503 = !DILocation(line: 187, column: 1, scope: !1484)
!1504 = !DILocation(line: 0, scope: !564)
!1505 = !DILocation(line: 190, column: 3, scope: !571)
!1506 = !DILocation(line: 191, column: 3, scope: !564)
!1507 = !DILocation(line: 192, column: 3, scope: !564)
!1508 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1509, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !293, retainedNodes: !1511)
!1509 = !DISubroutineType(types: !1510)
!1510 = !{!201, !201, !882}
!1511 = !{!1512, !1513, !1514, !1515, !1516, !1517, !1518, !1519, !1520}
!1512 = !DILocalVariable(name: "argc", arg: 1, scope: !1508, file: !170, line: 14, type: !201)
!1513 = !DILocalVariable(name: "argv", arg: 2, scope: !1508, file: !170, line: 14, type: !882)
!1514 = !DILocalVariable(name: "in_file", scope: !1508, file: !170, line: 17, type: !233)
!1515 = !DILocalVariable(name: "check_file", scope: !1508, file: !170, line: 19, type: !233)
!1516 = !DILocalVariable(name: "in_fd", scope: !1508, file: !170, line: 34, type: !201)
!1517 = !DILocalVariable(name: "data", scope: !1508, file: !170, line: 35, type: !233)
!1518 = !DILocalVariable(name: "out_fd", scope: !1508, file: !170, line: 46, type: !201)
!1519 = !DILocalVariable(name: "check_fd", scope: !1508, file: !170, line: 55, type: !201)
!1520 = !DILocalVariable(name: "ref", scope: !1508, file: !170, line: 56, type: !233)
!1521 = !DILocation(line: 0, scope: !1508)
!1522 = !DILocation(line: 21, column: 3, scope: !1523)
!1523 = distinct !DILexicalBlock(scope: !1524, file: !170, line: 21, column: 3)
!1524 = distinct !DILexicalBlock(scope: !1508, file: !170, line: 21, column: 3)
!1525 = !DILocation(line: 26, column: 11, scope: !1526)
!1526 = distinct !DILexicalBlock(scope: !1508, file: !170, line: 26, column: 7)
!1527 = !DILocation(line: 26, column: 7, scope: !1508)
!1528 = !DILocation(line: 27, column: 15, scope: !1526)
!1529 = !DILocation(line: 29, column: 11, scope: !1530)
!1530 = distinct !DILexicalBlock(scope: !1508, file: !170, line: 29, column: 7)
!1531 = !DILocation(line: 29, column: 7, scope: !1508)
!1532 = !DILocation(line: 30, column: 18, scope: !1530)
!1533 = !DILocation(line: 30, column: 5, scope: !1530)
!1534 = !DILocation(line: 36, column: 17, scope: !1508)
!1535 = !DILocation(line: 36, column: 10, scope: !1508)
!1536 = !DILocation(line: 37, column: 3, scope: !1537)
!1537 = distinct !DILexicalBlock(scope: !1538, file: !170, line: 37, column: 3)
!1538 = distinct !DILexicalBlock(scope: !1508, file: !170, line: 37, column: 3)
!1539 = !DILocation(line: 38, column: 11, scope: !1508)
!1540 = !DILocation(line: 39, column: 3, scope: !1541)
!1541 = distinct !DILexicalBlock(scope: !1542, file: !170, line: 39, column: 3)
!1542 = distinct !DILexicalBlock(scope: !1508, file: !170, line: 39, column: 3)
!1543 = !DILocation(line: 40, column: 3, scope: !1508)
!1544 = !DILocation(line: 0, scope: !481, inlinedAt: !1545)
!1545 = distinct !DILocation(line: 43, column: 3, scope: !1508)
!1546 = !DILocation(line: 10, column: 27, scope: !481, inlinedAt: !1545)
!1547 = !DILocation(line: 10, column: 39, scope: !481, inlinedAt: !1545)
!1548 = !DILocation(line: 10, column: 3, scope: !481, inlinedAt: !1545)
!1549 = !DILocation(line: 47, column: 12, scope: !1508)
!1550 = !DILocation(line: 48, column: 3, scope: !1551)
!1551 = distinct !DILexicalBlock(scope: !1552, file: !170, line: 48, column: 3)
!1552 = distinct !DILexicalBlock(scope: !1508, file: !170, line: 48, column: 3)
!1553 = !DILocation(line: 0, scope: !633, inlinedAt: !1554)
!1554 = distinct !DILocation(line: 49, column: 3, scope: !1508)
!1555 = !DILocation(line: 0, scope: !564, inlinedAt: !1556)
!1556 = distinct !DILocation(line: 63, column: 3, scope: !633, inlinedAt: !1554)
!1557 = !DILocation(line: 190, column: 3, scope: !571, inlinedAt: !1556)
!1558 = !DILocation(line: 191, column: 3, scope: !564, inlinedAt: !1556)
!1559 = !DILocation(line: 0, scope: !575, inlinedAt: !1560)
!1560 = distinct !DILocation(line: 64, column: 3, scope: !633, inlinedAt: !1554)
!1561 = !DILocation(line: 183, column: 1, scope: !585, inlinedAt: !1560)
!1562 = !DILocation(line: 183, column: 1, scope: !587, inlinedAt: !1560)
!1563 = !DILocation(line: 183, column: 1, scope: !588, inlinedAt: !1560)
!1564 = distinct !{!1564, !1561, !1561, !387, !388}
!1565 = !DILocation(line: 50, column: 3, scope: !1508)
!1566 = !DILocation(line: 57, column: 16, scope: !1508)
!1567 = !DILocation(line: 57, column: 9, scope: !1508)
!1568 = !DILocation(line: 58, column: 3, scope: !1569)
!1569 = distinct !DILexicalBlock(scope: !1570, file: !170, line: 58, column: 3)
!1570 = distinct !DILexicalBlock(scope: !1508, file: !170, line: 58, column: 3)
!1571 = !DILocation(line: 59, column: 14, scope: !1508)
!1572 = !DILocation(line: 60, column: 3, scope: !1573)
!1573 = distinct !DILexicalBlock(scope: !1574, file: !170, line: 60, column: 3)
!1574 = distinct !DILexicalBlock(scope: !1508, file: !170, line: 60, column: 3)
!1575 = !DILocation(line: 0, scope: !602, inlinedAt: !1576)
!1576 = distinct !DILocation(line: 61, column: 3, scope: !1508)
!1577 = !DILocation(line: 53, column: 7, scope: !602, inlinedAt: !1576)
!1578 = !DILocation(line: 0, scope: !504, inlinedAt: !1579)
!1579 = distinct !DILocation(line: 55, column: 7, scope: !602, inlinedAt: !1576)
!1580 = !DILocation(line: 64, column: 17, scope: !504, inlinedAt: !1579)
!1581 = !DILocation(line: 64, column: 3, scope: !504, inlinedAt: !1579)
!1582 = !DILocation(line: 66, column: 22, scope: !516, inlinedAt: !1579)
!1583 = !DILocation(line: 66, column: 26, scope: !516, inlinedAt: !1579)
!1584 = !DILocation(line: 66, column: 32, scope: !516, inlinedAt: !1579)
!1585 = !DILocation(line: 66, column: 35, scope: !516, inlinedAt: !1579)
!1586 = !DILocation(line: 66, column: 39, scope: !516, inlinedAt: !1579)
!1587 = !DILocation(line: 66, column: 9, scope: !517, inlinedAt: !1579)
!1588 = !DILocation(line: 69, column: 6, scope: !517, inlinedAt: !1579)
!1589 = !DILocation(line: 64, column: 10, scope: !504, inlinedAt: !1579)
!1590 = !DILocation(line: 64, column: 13, scope: !504, inlinedAt: !1579)
!1591 = distinct !{!1591, !1581, !1592, !387, !388}
!1592 = !DILocation(line: 70, column: 3, scope: !504, inlinedAt: !1579)
!1593 = !DILocation(line: 71, column: 6, scope: !529, inlinedAt: !1579)
!1594 = !DILocation(line: 71, column: 8, scope: !529, inlinedAt: !1579)
!1595 = !DILocation(line: 71, column: 6, scope: !504, inlinedAt: !1579)
!1596 = !DILocation(line: 56, column: 37, scope: !602, inlinedAt: !1576)
!1597 = !DILocation(line: 56, column: 3, scope: !602, inlinedAt: !1576)
!1598 = !DILocation(line: 57, column: 3, scope: !602, inlinedAt: !1576)
!1599 = !DILocation(line: 0, scope: !651, inlinedAt: !1600)
!1600 = distinct !DILocation(line: 66, column: 8, scope: !1601)
!1601 = distinct !DILexicalBlock(scope: !1508, file: !170, line: 66, column: 7)
!1602 = !DILocation(line: 74, column: 3, scope: !664, inlinedAt: !1600)
!1603 = !DILocation(line: 75, column: 12, scope: !666, inlinedAt: !1600)
!1604 = !DILocation(line: 75, column: 27, scope: !666, inlinedAt: !1600)
!1605 = !DILocation(line: 76, column: 35, scope: !666, inlinedAt: !1600)
!1606 = !DILocation(line: 76, column: 16, scope: !666, inlinedAt: !1600)
!1607 = !DILocation(line: 74, column: 21, scope: !667, inlinedAt: !1600)
!1608 = !DILocation(line: 74, column: 13, scope: !667, inlinedAt: !1600)
!1609 = distinct !{!1609, !1602, !1610, !387, !388}
!1610 = !DILocation(line: 77, column: 3, scope: !664, inlinedAt: !1600)
!1611 = !DILocation(line: 80, column: 10, scope: !651, inlinedAt: !1600)
!1612 = !DILocation(line: 66, column: 7, scope: !1508)
!1613 = !DILocation(line: 67, column: 13, scope: !1614)
!1614 = distinct !DILexicalBlock(scope: !1601, file: !170, line: 66, column: 32)
!1615 = !DILocation(line: 67, column: 5, scope: !1614)
!1616 = !DILocation(line: 68, column: 5, scope: !1614)
!1617 = !DILocation(line: 71, column: 3, scope: !1508)
!1618 = !DILocation(line: 72, column: 3, scope: !1508)
!1619 = !DILocation(line: 74, column: 3, scope: !1508)
!1620 = !DILocation(line: 75, column: 3, scope: !1508)
!1621 = !DILocation(line: 76, column: 1, scope: !1508)
!1622 = !DISubprogram(name: "open", scope: !1623, file: !1623, line: 209, type: !1624, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1623 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1624 = !DISubroutineType(types: !1625)
!1625 = !{!201, !763, !201, null}
