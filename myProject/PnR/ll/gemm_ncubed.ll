; ModuleID = 'gemm/ncubed/gemm_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.bench_args_t = type { [4096 x double], [4096 x double], [4096 x double] }
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
@INPUT_SIZE = dso_local local_unnamed_addr global i32 98304, align 4, !dbg !186
@.str.6.14 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !204
@.str.8.15 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !207
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !210
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !215
@.str.12.16 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !218
@.str.14.17 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !220
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !223
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @gemm(ptr nocapture noundef readonly %m1, ptr nocapture noundef readonly %m2, ptr nocapture noundef writeonly %prod) local_unnamed_addr #0 !dbg !325 {
polly.split_new_and_old:
  %polly.indvar_next53.reg2mem = alloca i64, align 8
  %_p_scalar_.31.reg2mem = alloca double, align 8
  %_p_scalar_.30.reg2mem = alloca double, align 8
  %_p_scalar_.29.reg2mem = alloca double, align 8
  %_p_scalar_.28.reg2mem = alloca double, align 8
  %_p_scalar_.27.reg2mem = alloca double, align 8
  %_p_scalar_.26.reg2mem = alloca double, align 8
  %_p_scalar_.25.reg2mem = alloca double, align 8
  %_p_scalar_.24.reg2mem = alloca double, align 8
  %_p_scalar_.23.reg2mem = alloca double, align 8
  %_p_scalar_.22.reg2mem = alloca double, align 8
  %_p_scalar_.21.reg2mem = alloca double, align 8
  %_p_scalar_.20.reg2mem = alloca double, align 8
  %_p_scalar_.19.reg2mem = alloca double, align 8
  %_p_scalar_.18.reg2mem = alloca double, align 8
  %_p_scalar_.17.reg2mem = alloca double, align 8
  %_p_scalar_.16.reg2mem = alloca double, align 8
  %_p_scalar_.15.reg2mem = alloca double, align 8
  %_p_scalar_.14.reg2mem = alloca double, align 8
  %_p_scalar_.13.reg2mem = alloca double, align 8
  %_p_scalar_.12.reg2mem = alloca double, align 8
  %_p_scalar_.11.reg2mem = alloca double, align 8
  %_p_scalar_.10.reg2mem = alloca double, align 8
  %_p_scalar_.9.reg2mem = alloca double, align 8
  %_p_scalar_.8.reg2mem = alloca double, align 8
  %_p_scalar_.7.reg2mem = alloca double, align 8
  %_p_scalar_.6.reg2mem = alloca double, align 8
  %_p_scalar_.5.reg2mem = alloca double, align 8
  %_p_scalar_.4.reg2mem = alloca double, align 8
  %_p_scalar_.3.reg2mem = alloca double, align 8
  %_p_scalar_.2.reg2mem = alloca double, align 8
  %_p_scalar_.1179.reg2mem = alloca double, align 8
  %_p_scalar_.reg2mem = alloca double, align 8
  %.reg2mem = alloca ptr, align 8
  %polly.indvar46.reg2mem = alloca i64, align 8
  %polly.indvar_next47.reg2mem = alloca i64, align 8
  %.reg2mem193 = alloca ptr, align 8
  %polly.indvar34.reg2mem = alloca i64, align 8
  %polly.loop_cond36.reg2mem = alloca i1, align 1
  %polly.indvar_next47.1.reg2mem = alloca i64, align 8
  %polly.indvar_next53.1.reg2mem = alloca i64, align 8
  %polly.indvar_next59.1.reg2mem = alloca i64, align 8
  %p_add12.1.reg2mem = alloca double, align 8
  %polly.access.prod61.promoted.1.reg2mem = alloca double, align 8
  %invariant.gep70.1.reg2mem = alloca ptr, align 8
  %polly.access.prod61.1.reg2mem = alloca ptr, align 8
  %polly.indvar52.1.reg2mem = alloca i64, align 8
  %.reg2mem205 = alloca ptr, align 8
  %.reg2mem207 = alloca ptr, align 8
  %polly.indvar46.1.reg2mem = alloca i64, align 8
  %.reg2mem210 = alloca ptr, align 8
  %.reg2mem213 = alloca ptr, align 8
  %polly.loop_cond30.reg2mem = alloca i1, align 1
  %polly.indvar52.reg2mem = alloca i64, align 8
  %polly.indvar46.reg2mem225 = alloca i64, align 8
  %polly.indvar34.reg2mem227 = alloca i64, align 8
  %polly.loop_cond36.reg2mem229 = alloca i1, align 1
  %polly.indvar58.1.reg2mem = alloca i64, align 8
  %polly.access.prod61.reload72.1.reg2mem = alloca double, align 8
  %polly.indvar52.1.reg2mem231 = alloca i64, align 8
  %polly.indvar46.1.reg2mem233 = alloca i64, align 8
  %polly.indvar28.reg2mem = alloca i64, align 8
  %polly.loop_cond30.reg2mem235 = alloca i1, align 1
  %sum.033.reg2mem = alloca double, align 8
  %indvars.iv.reg2mem = alloca i64, align 8
  %indvars.iv39.reg2mem237 = alloca i64, align 8
  %indvars.iv43.reg2mem239 = alloca i64, align 8
    #dbg_value(ptr %m1, !330, !DIExpression(), !349)
    #dbg_value(ptr %m2, !331, !DIExpression(), !349)
    #dbg_value(ptr %prod, !332, !DIExpression(), !349)
    #dbg_label(!339, !350)
    #dbg_value(i32 0, !333, !DIExpression(), !349)
  %polly.access.m1 = getelementptr i8, ptr %m1, i64 32768
  %0 = icmp ule ptr %polly.access.m1, %prod
  %polly.access.prod1 = getelementptr i8, ptr %prod, i64 32768
  %1 = icmp ule ptr %polly.access.prod1, %m1
  %2 = or i1 %0, %1
  %polly.access.m2 = getelementptr i8, ptr %m2, i64 32768
  %3 = icmp ule ptr %polly.access.m2, %prod
  %4 = icmp ule ptr %polly.access.prod1, %m2
  %5 = or i1 %3, %4
  %6 = and i1 %2, %5
  br i1 %6, label %polly.loop_preheader7.preheader, label %polly.split_new_and_old.for.cond1.preheader_crit_edge

polly.split_new_and_old.for.cond1.preheader_crit_edge: ; preds = %polly.split_new_and_old
  store i64 0, ptr %indvars.iv43.reg2mem239, align 8
  br label %for.cond1.preheader

polly.loop_preheader7.preheader:                  ; preds = %polly.split_new_and_old
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(32768) %prod, i8 0, i64 32768, i1 false)
  store i64 0, ptr %polly.indvar28.reg2mem, align 8
  store i1 true, ptr %polly.loop_cond30.reg2mem235, align 1
  br label %polly.loop_preheader32

for.cond1.preheader:                              ; preds = %for.inc19.for.cond1.preheader_crit_edge, %polly.split_new_and_old.for.cond1.preheader_crit_edge
    #dbg_value(i64 %indvars.iv43.reg2mem239.0.load, !333, !DIExpression(), !349)
  %indvars.iv43.reg2mem239.0.load = load i64, ptr %indvars.iv43.reg2mem239, align 8
  %7 = shl nuw nsw i64 %indvars.iv43.reg2mem239.0.load, 6
    #dbg_value(i32 0, !334, !DIExpression(), !349)
  store i64 0, ptr %indvars.iv39.reg2mem237, align 8
  br label %for.body3, !dbg !351

for.body3:                                        ; preds = %for.end.for.body3_crit_edge, %for.cond1.preheader
    #dbg_value(i64 %indvars.iv39.reg2mem237.0.load, !334, !DIExpression(), !349)
    #dbg_value(i64 %7, !337, !DIExpression(), !349)
    #dbg_value(double 0.000000e+00, !344, !DIExpression(), !352)
    #dbg_label(!348, !353)
    #dbg_value(i32 0, !335, !DIExpression(), !349)
  %indvars.iv39.reg2mem237.0.load = load i64, ptr %indvars.iv39.reg2mem237, align 8
  %invariant.gep = getelementptr double, ptr %m2, i64 %indvars.iv39.reg2mem237.0.load, !dbg !354
  store double 0.000000e+00, ptr %sum.033.reg2mem, align 8
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body6, !dbg !354

for.body6:                                        ; preds = %for.body6.for.body6_crit_edge, %for.body3
    #dbg_value(double %sum.033.reg2mem.0.sum.033.reload, !344, !DIExpression(), !352)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !335, !DIExpression(), !349)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !336, !DIExpression(DW_OP_constu, 6, DW_OP_shl, DW_OP_stack_value), !349)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %sum.033.reg2mem.0.sum.033.reload = load double, ptr %sum.033.reg2mem, align 8
  %8 = or disjoint i64 %indvars.iv.reg2mem.0.load, %7, !dbg !356
  %arrayidx = getelementptr inbounds double, ptr %m1, i64 %8, !dbg !359
  %9 = load double, ptr %arrayidx, align 8, !dbg !359, !tbaa !360
  %gep.idx = shl i64 %indvars.iv.reg2mem.0.load, 9, !dbg !364
  %gep = getelementptr i8, ptr %invariant.gep, i64 %gep.idx, !dbg !364
  %10 = load double, ptr %gep, align 8, !dbg !364, !tbaa !360
  %mul11 = fmul double %9, %10, !dbg !365
    #dbg_value(double %mul11, !338, !DIExpression(), !349)
  %add12 = fadd double %sum.033.reg2mem.0.sum.033.reload, %mul11, !dbg !366
    #dbg_value(double %add12, !344, !DIExpression(), !352)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !367
    #dbg_value(i64 %indvars.iv.next, !335, !DIExpression(), !349)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 64, !dbg !368
  br i1 %exitcond.not, label %for.end, label %for.body6.for.body6_crit_edge, !dbg !354, !llvm.loop !369

for.body6.for.body6_crit_edge:                    ; preds = %for.body6
  store double %add12, ptr %sum.033.reg2mem, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body6, !dbg !354

for.end:                                          ; preds = %for.body6
  %11 = or disjoint i64 %indvars.iv39.reg2mem237.0.load, %7, !dbg !373
  %arrayidx15 = getelementptr inbounds double, ptr %prod, i64 %11, !dbg !374
  store double %add12, ptr %arrayidx15, align 8, !dbg !375, !tbaa !360
  %indvars.iv.next40 = add nuw nsw i64 %indvars.iv39.reg2mem237.0.load, 1, !dbg !376
    #dbg_value(i64 %indvars.iv.next40, !334, !DIExpression(), !349)
  %exitcond42.not = icmp eq i64 %indvars.iv.next40, 64, !dbg !377
  br i1 %exitcond42.not, label %for.inc19, label %for.end.for.body3_crit_edge, !dbg !351, !llvm.loop !378

for.end.for.body3_crit_edge:                      ; preds = %for.end
  store i64 %indvars.iv.next40, ptr %indvars.iv39.reg2mem237, align 8
  br label %for.body3, !dbg !351

for.inc19:                                        ; preds = %for.end
  %indvars.iv.next44 = add nuw nsw i64 %indvars.iv43.reg2mem239.0.load, 1, !dbg !380
    #dbg_value(i64 %indvars.iv.next44, !333, !DIExpression(), !349)
  %exitcond46.not = icmp eq i64 %indvars.iv.next44, 64, !dbg !381
  br i1 %exitcond46.not, label %for.inc19.for.end21_crit_edge, label %for.inc19.for.cond1.preheader_crit_edge, !dbg !382, !llvm.loop !383

for.inc19.for.cond1.preheader_crit_edge:          ; preds = %for.inc19
  store i64 %indvars.iv.next44, ptr %indvars.iv43.reg2mem239, align 8
  br label %for.cond1.preheader, !dbg !382

for.inc19.for.end21_crit_edge:                    ; preds = %for.inc19
  br label %for.end21, !dbg !382

for.end21:                                        ; preds = %polly.loop_exit33.for.end21_crit_edge, %for.inc19.for.end21_crit_edge
  ret void, !dbg !385

polly.loop_exit33:                                ; preds = %polly.loop_exit45.1
  br i1 %polly.loop_cond30.reg2mem235.0.polly.loop_cond30.reload236, label %polly.loop_exit33.polly.loop_preheader32_crit_edge, label %polly.loop_exit33.for.end21_crit_edge

polly.loop_exit33.for.end21_crit_edge:            ; preds = %polly.loop_exit33
  br label %for.end21

polly.loop_exit33.polly.loop_preheader32_crit_edge: ; preds = %polly.loop_exit33
  store i64 16384, ptr %polly.indvar28.reg2mem, align 8
  store i1 false, ptr %polly.loop_cond30.reg2mem235, align 1
  br label %polly.loop_preheader32

polly.loop_preheader32:                           ; preds = %polly.loop_exit33.polly.loop_preheader32_crit_edge, %polly.loop_preheader7.preheader
  %polly.loop_cond30.reg2mem235.0.polly.loop_cond30.reload236 = load i1, ptr %polly.loop_cond30.reg2mem235, align 1
  %polly.indvar28.reg2mem.0.load = load i64, ptr %polly.indvar28.reg2mem, align 8
  store i1 %polly.loop_cond30.reg2mem235.0.polly.loop_cond30.reload236, ptr %polly.loop_cond30.reg2mem, align 1
  %12 = getelementptr i8, ptr %prod, i64 %polly.indvar28.reg2mem.0.load
  store ptr %12, ptr %.reg2mem213, align 8
  %13 = getelementptr i8, ptr %m1, i64 %polly.indvar28.reg2mem.0.load
  store ptr %13, ptr %.reg2mem210, align 8
  store i64 0, ptr %polly.indvar34.reg2mem227, align 8
  store i1 true, ptr %polly.loop_cond36.reg2mem229, align 1
  br label %polly.loop_preheader38

polly.loop_preheader50.1:                         ; preds = %polly.loop_exit51.polly.loop_preheader50.1_crit_edge, %polly.loop_exit51.1.polly.loop_preheader50.1_crit_edge
  %polly.indvar46.1.reg2mem233.0.load = load i64, ptr %polly.indvar46.1.reg2mem233, align 8
  store i64 %polly.indvar46.1.reg2mem233.0.load, ptr %polly.indvar46.1.reg2mem, align 8
  %.idx68.1 = shl i64 %polly.indvar46.1.reg2mem233.0.load, 9
  %14 = getelementptr i8, ptr %21, i64 %.idx68.1
  store ptr %14, ptr %.reg2mem207, align 8
  %15 = getelementptr i8, ptr %13, i64 %.idx68.1
  store ptr %15, ptr %.reg2mem205, align 8
  store i64 0, ptr %polly.indvar52.1.reg2mem231, align 8
  br label %polly.loop_preheader56.1

polly.loop_preheader56.1:                         ; preds = %polly.loop_exit57.1.polly.loop_preheader56.1_crit_edge, %polly.loop_preheader50.1
  %polly.indvar52.1.reg2mem231.0.load = load i64, ptr %polly.indvar52.1.reg2mem231, align 8
  store i64 %polly.indvar52.1.reg2mem231.0.load, ptr %polly.indvar52.1.reg2mem, align 8
  %16 = add nuw nsw i64 %polly.indvar52.1.reg2mem231.0.load, %polly.indvar34.reg2mem227.0.load
  %polly.access.prod61.1 = getelementptr double, ptr %14, i64 %polly.indvar52.1.reg2mem231.0.load
  store ptr %polly.access.prod61.1, ptr %polly.access.prod61.1.reg2mem, align 8
  %17 = shl i64 %16, 3
  %invariant.gep70.1 = getelementptr i8, ptr %m2, i64 %17
  store ptr %invariant.gep70.1, ptr %invariant.gep70.1.reg2mem, align 8
  %polly.access.prod61.promoted.1 = load double, ptr %polly.access.prod61.1, align 8
  store double %polly.access.prod61.promoted.1, ptr %polly.access.prod61.promoted.1.reg2mem, align 8
  store i64 0, ptr %polly.indvar58.1.reg2mem, align 8
  store double %polly.access.prod61.promoted.1, ptr %polly.access.prod61.reload72.1.reg2mem, align 8
  br label %polly.stmt.for.body6.1

polly.stmt.for.body6.1:                           ; preds = %polly.stmt.for.body6.1.polly.stmt.for.body6.1_crit_edge, %polly.loop_preheader56.1
  %polly.access.prod61.reload72.1.reg2mem.0.polly.access.prod61.reload72.1.reload = load double, ptr %polly.access.prod61.reload72.1.reg2mem, align 8
  %polly.indvar58.1.reg2mem.0.load = load i64, ptr %polly.indvar58.1.reg2mem, align 8
  %18 = add nuw nsw i64 %polly.indvar58.1.reg2mem.0.load, 32
  %19 = shl i64 %18, 3
  %scevgep.1 = getelementptr i8, ptr %15, i64 %19
  %_p_scalar_.1 = load double, ptr %scevgep.1, align 8, !alias.scope !386, !noalias !389
  %20 = shl i64 %18, 9
  %gep71.1 = getelementptr i8, ptr %invariant.gep70.1, i64 %20
  %_p_scalar_63.1 = load double, ptr %gep71.1, align 8, !alias.scope !392, !noalias !393
  %p_mul11.1 = fmul double %_p_scalar_.1, %_p_scalar_63.1, !dbg !365
  %p_add12.1 = fadd double %polly.access.prod61.reload72.1.reg2mem.0.polly.access.prod61.reload72.1.reload, %p_mul11.1, !dbg !366
  store double %p_add12.1, ptr %p_add12.1.reg2mem, align 8
  %polly.indvar_next59.1 = add nuw nsw i64 %polly.indvar58.1.reg2mem.0.load, 1
  store i64 %polly.indvar_next59.1, ptr %polly.indvar_next59.1.reg2mem, align 8
  %exitcond.1.not = icmp eq i64 %polly.indvar_next59.1, 32
  br i1 %exitcond.1.not, label %polly.loop_exit57.1, label %polly.stmt.for.body6.1.polly.stmt.for.body6.1_crit_edge

polly.stmt.for.body6.1.polly.stmt.for.body6.1_crit_edge: ; preds = %polly.stmt.for.body6.1
  store i64 %polly.indvar_next59.1, ptr %polly.indvar58.1.reg2mem, align 8
  store double %p_add12.1, ptr %polly.access.prod61.reload72.1.reg2mem, align 8
  br label %polly.stmt.for.body6.1

polly.loop_exit57.1:                              ; preds = %polly.stmt.for.body6.1
  store double %p_add12.1, ptr %polly.access.prod61.1, align 8, !alias.scope !394, !noalias !395
  %polly.indvar_next53.1 = add nuw nsw i64 %polly.indvar52.1.reg2mem231.0.load, 1
  store i64 %polly.indvar_next53.1, ptr %polly.indvar_next53.1.reg2mem, align 8
  %exitcond174.1.not = icmp eq i64 %polly.indvar_next53.1, 32
  br i1 %exitcond174.1.not, label %polly.loop_exit51.1, label %polly.loop_exit57.1.polly.loop_preheader56.1_crit_edge

polly.loop_exit57.1.polly.loop_preheader56.1_crit_edge: ; preds = %polly.loop_exit57.1
  store i64 %polly.indvar_next53.1, ptr %polly.indvar52.1.reg2mem231, align 8
  br label %polly.loop_preheader56.1

polly.loop_exit51.1:                              ; preds = %polly.loop_exit57.1
  %polly.indvar_next47.1 = add nuw nsw i64 %polly.indvar46.1.reg2mem233.0.load, 1
  store i64 %polly.indvar_next47.1, ptr %polly.indvar_next47.1.reg2mem, align 8
  %exitcond175.1.not = icmp eq i64 %polly.indvar_next47.1, 32
  br i1 %exitcond175.1.not, label %polly.loop_exit45.1, label %polly.loop_exit51.1.polly.loop_preheader50.1_crit_edge

polly.loop_exit51.1.polly.loop_preheader50.1_crit_edge: ; preds = %polly.loop_exit51.1
  store i64 %polly.indvar_next47.1, ptr %polly.indvar46.1.reg2mem233, align 8
  br label %polly.loop_preheader50.1

polly.loop_exit45.1:                              ; preds = %polly.loop_exit51.1
  br i1 %polly.loop_cond36.reg2mem229.0.polly.loop_cond36.reload230, label %polly.loop_exit45.1.polly.loop_preheader38_crit_edge, label %polly.loop_exit33

polly.loop_exit45.1.polly.loop_preheader38_crit_edge: ; preds = %polly.loop_exit45.1
  store i64 32, ptr %polly.indvar34.reg2mem227, align 8
  store i1 false, ptr %polly.loop_cond36.reg2mem229, align 1
  br label %polly.loop_preheader38

polly.loop_preheader38:                           ; preds = %polly.loop_exit45.1.polly.loop_preheader38_crit_edge, %polly.loop_preheader32
  %polly.loop_cond36.reg2mem229.0.polly.loop_cond36.reload230 = load i1, ptr %polly.loop_cond36.reg2mem229, align 1
  %polly.indvar34.reg2mem227.0.load = load i64, ptr %polly.indvar34.reg2mem227, align 8
  store i1 %polly.loop_cond36.reg2mem229.0.polly.loop_cond36.reload230, ptr %polly.loop_cond36.reg2mem, align 1
  store i64 %polly.indvar34.reg2mem227.0.load, ptr %polly.indvar34.reg2mem, align 8
  %21 = getelementptr double, ptr %12, i64 %polly.indvar34.reg2mem227.0.load
  store ptr %21, ptr %.reg2mem193, align 8
  store i64 0, ptr %polly.indvar46.reg2mem225, align 8
  br label %polly.loop_preheader50

polly.loop_exit51:                                ; preds = %polly.loop_preheader56
  %polly.indvar_next47 = add nuw nsw i64 %polly.indvar46.reg2mem225.0.load, 1
  store i64 %polly.indvar_next47, ptr %polly.indvar_next47.reg2mem, align 8
  %exitcond175.not = icmp eq i64 %polly.indvar_next47, 32
  br i1 %exitcond175.not, label %polly.loop_exit51.polly.loop_preheader50.1_crit_edge, label %polly.loop_exit51.polly.loop_preheader50_crit_edge

polly.loop_exit51.polly.loop_preheader50_crit_edge: ; preds = %polly.loop_exit51
  store i64 %polly.indvar_next47, ptr %polly.indvar46.reg2mem225, align 8
  br label %polly.loop_preheader50

polly.loop_exit51.polly.loop_preheader50.1_crit_edge: ; preds = %polly.loop_exit51
  store i64 0, ptr %polly.indvar46.1.reg2mem233, align 8
  br label %polly.loop_preheader50.1

polly.loop_preheader50:                           ; preds = %polly.loop_exit51.polly.loop_preheader50_crit_edge, %polly.loop_preheader38
  %polly.indvar46.reg2mem225.0.load = load i64, ptr %polly.indvar46.reg2mem225, align 8
  store i64 %polly.indvar46.reg2mem225.0.load, ptr %polly.indvar46.reg2mem, align 8
  %.idx68 = shl i64 %polly.indvar46.reg2mem225.0.load, 9
  %22 = getelementptr i8, ptr %21, i64 %.idx68
  store ptr %22, ptr %.reg2mem, align 8
  %23 = getelementptr i8, ptr %13, i64 %.idx68
  %_p_scalar_ = load double, ptr %23, align 8
  store double %_p_scalar_, ptr %_p_scalar_.reg2mem, align 8
  %scevgep.1178 = getelementptr i8, ptr %23, i64 8
  %_p_scalar_.1179 = load double, ptr %scevgep.1178, align 8
  store double %_p_scalar_.1179, ptr %_p_scalar_.1179.reg2mem, align 8
  %scevgep.2 = getelementptr i8, ptr %23, i64 16
  %_p_scalar_.2 = load double, ptr %scevgep.2, align 8
  store double %_p_scalar_.2, ptr %_p_scalar_.2.reg2mem, align 8
  %scevgep.3 = getelementptr i8, ptr %23, i64 24
  %_p_scalar_.3 = load double, ptr %scevgep.3, align 8
  store double %_p_scalar_.3, ptr %_p_scalar_.3.reg2mem, align 8
  %scevgep.4 = getelementptr i8, ptr %23, i64 32
  %_p_scalar_.4 = load double, ptr %scevgep.4, align 8
  store double %_p_scalar_.4, ptr %_p_scalar_.4.reg2mem, align 8
  %scevgep.5 = getelementptr i8, ptr %23, i64 40
  %_p_scalar_.5 = load double, ptr %scevgep.5, align 8
  store double %_p_scalar_.5, ptr %_p_scalar_.5.reg2mem, align 8
  %scevgep.6 = getelementptr i8, ptr %23, i64 48
  %_p_scalar_.6 = load double, ptr %scevgep.6, align 8
  store double %_p_scalar_.6, ptr %_p_scalar_.6.reg2mem, align 8
  %scevgep.7 = getelementptr i8, ptr %23, i64 56
  %_p_scalar_.7 = load double, ptr %scevgep.7, align 8
  store double %_p_scalar_.7, ptr %_p_scalar_.7.reg2mem, align 8
  %scevgep.8 = getelementptr i8, ptr %23, i64 64
  %_p_scalar_.8 = load double, ptr %scevgep.8, align 8
  store double %_p_scalar_.8, ptr %_p_scalar_.8.reg2mem, align 8
  %scevgep.9 = getelementptr i8, ptr %23, i64 72
  %_p_scalar_.9 = load double, ptr %scevgep.9, align 8
  store double %_p_scalar_.9, ptr %_p_scalar_.9.reg2mem, align 8
  %scevgep.10 = getelementptr i8, ptr %23, i64 80
  %_p_scalar_.10 = load double, ptr %scevgep.10, align 8
  store double %_p_scalar_.10, ptr %_p_scalar_.10.reg2mem, align 8
  %scevgep.11 = getelementptr i8, ptr %23, i64 88
  %_p_scalar_.11 = load double, ptr %scevgep.11, align 8
  store double %_p_scalar_.11, ptr %_p_scalar_.11.reg2mem, align 8
  %scevgep.12 = getelementptr i8, ptr %23, i64 96
  %_p_scalar_.12 = load double, ptr %scevgep.12, align 8
  store double %_p_scalar_.12, ptr %_p_scalar_.12.reg2mem, align 8
  %scevgep.13 = getelementptr i8, ptr %23, i64 104
  %_p_scalar_.13 = load double, ptr %scevgep.13, align 8
  store double %_p_scalar_.13, ptr %_p_scalar_.13.reg2mem, align 8
  %scevgep.14 = getelementptr i8, ptr %23, i64 112
  %_p_scalar_.14 = load double, ptr %scevgep.14, align 8
  store double %_p_scalar_.14, ptr %_p_scalar_.14.reg2mem, align 8
  %scevgep.15 = getelementptr i8, ptr %23, i64 120
  %_p_scalar_.15 = load double, ptr %scevgep.15, align 8
  store double %_p_scalar_.15, ptr %_p_scalar_.15.reg2mem, align 8
  %scevgep.16 = getelementptr i8, ptr %23, i64 128
  %_p_scalar_.16 = load double, ptr %scevgep.16, align 8
  store double %_p_scalar_.16, ptr %_p_scalar_.16.reg2mem, align 8
  %scevgep.17 = getelementptr i8, ptr %23, i64 136
  %_p_scalar_.17 = load double, ptr %scevgep.17, align 8
  store double %_p_scalar_.17, ptr %_p_scalar_.17.reg2mem, align 8
  %scevgep.18 = getelementptr i8, ptr %23, i64 144
  %_p_scalar_.18 = load double, ptr %scevgep.18, align 8
  store double %_p_scalar_.18, ptr %_p_scalar_.18.reg2mem, align 8
  %scevgep.19 = getelementptr i8, ptr %23, i64 152
  %_p_scalar_.19 = load double, ptr %scevgep.19, align 8
  store double %_p_scalar_.19, ptr %_p_scalar_.19.reg2mem, align 8
  %scevgep.20 = getelementptr i8, ptr %23, i64 160
  %_p_scalar_.20 = load double, ptr %scevgep.20, align 8
  store double %_p_scalar_.20, ptr %_p_scalar_.20.reg2mem, align 8
  %scevgep.21 = getelementptr i8, ptr %23, i64 168
  %_p_scalar_.21 = load double, ptr %scevgep.21, align 8
  store double %_p_scalar_.21, ptr %_p_scalar_.21.reg2mem, align 8
  %scevgep.22 = getelementptr i8, ptr %23, i64 176
  %_p_scalar_.22 = load double, ptr %scevgep.22, align 8
  store double %_p_scalar_.22, ptr %_p_scalar_.22.reg2mem, align 8
  %scevgep.23 = getelementptr i8, ptr %23, i64 184
  %_p_scalar_.23 = load double, ptr %scevgep.23, align 8
  store double %_p_scalar_.23, ptr %_p_scalar_.23.reg2mem, align 8
  %scevgep.24 = getelementptr i8, ptr %23, i64 192
  %_p_scalar_.24 = load double, ptr %scevgep.24, align 8
  store double %_p_scalar_.24, ptr %_p_scalar_.24.reg2mem, align 8
  %scevgep.25 = getelementptr i8, ptr %23, i64 200
  %_p_scalar_.25 = load double, ptr %scevgep.25, align 8
  store double %_p_scalar_.25, ptr %_p_scalar_.25.reg2mem, align 8
  %scevgep.26 = getelementptr i8, ptr %23, i64 208
  %_p_scalar_.26 = load double, ptr %scevgep.26, align 8
  store double %_p_scalar_.26, ptr %_p_scalar_.26.reg2mem, align 8
  %scevgep.27 = getelementptr i8, ptr %23, i64 216
  %_p_scalar_.27 = load double, ptr %scevgep.27, align 8
  store double %_p_scalar_.27, ptr %_p_scalar_.27.reg2mem, align 8
  %scevgep.28 = getelementptr i8, ptr %23, i64 224
  %_p_scalar_.28 = load double, ptr %scevgep.28, align 8
  store double %_p_scalar_.28, ptr %_p_scalar_.28.reg2mem, align 8
  %scevgep.29 = getelementptr i8, ptr %23, i64 232
  %_p_scalar_.29 = load double, ptr %scevgep.29, align 8
  store double %_p_scalar_.29, ptr %_p_scalar_.29.reg2mem, align 8
  %scevgep.30 = getelementptr i8, ptr %23, i64 240
  %_p_scalar_.30 = load double, ptr %scevgep.30, align 8
  store double %_p_scalar_.30, ptr %_p_scalar_.30.reg2mem, align 8
  %scevgep.31 = getelementptr i8, ptr %23, i64 248
  %_p_scalar_.31 = load double, ptr %scevgep.31, align 8
  store double %_p_scalar_.31, ptr %_p_scalar_.31.reg2mem, align 8
  store i64 0, ptr %polly.indvar52.reg2mem, align 8
  br label %polly.loop_preheader56

polly.loop_preheader56:                           ; preds = %polly.loop_preheader56.polly.loop_preheader56_crit_edge, %polly.loop_preheader50
  %polly.indvar52.reg2mem.0.load = load i64, ptr %polly.indvar52.reg2mem, align 8
  %24 = add nuw nsw i64 %polly.indvar52.reg2mem.0.load, %polly.indvar34.reg2mem227.0.load
  %polly.access.prod61 = getelementptr double, ptr %22, i64 %polly.indvar52.reg2mem.0.load
  %25 = shl i64 %24, 3
  %invariant.gep70 = getelementptr i8, ptr %m2, i64 %25
  %polly.access.prod61.promoted = load double, ptr %polly.access.prod61, align 8, !alias.scope !394, !noalias !395
  %_p_scalar_63 = load double, ptr %invariant.gep70, align 8, !alias.scope !392, !noalias !393
  %p_mul11 = fmul double %_p_scalar_, %_p_scalar_63, !dbg !365
  %p_add12 = fadd double %polly.access.prod61.promoted, %p_mul11, !dbg !366
  %gep71.1180 = getelementptr i8, ptr %invariant.gep70, i64 512
  %_p_scalar_63.1181 = load double, ptr %gep71.1180, align 8, !alias.scope !392, !noalias !393
  %p_mul11.1182 = fmul double %_p_scalar_.1179, %_p_scalar_63.1181, !dbg !365
  %p_add12.1183 = fadd double %p_add12, %p_mul11.1182, !dbg !366
  %gep71.2 = getelementptr i8, ptr %invariant.gep70, i64 1024
  %_p_scalar_63.2 = load double, ptr %gep71.2, align 8, !alias.scope !392, !noalias !393
  %p_mul11.2 = fmul double %_p_scalar_.2, %_p_scalar_63.2, !dbg !365
  %p_add12.2 = fadd double %p_add12.1183, %p_mul11.2, !dbg !366
  %gep71.3 = getelementptr i8, ptr %invariant.gep70, i64 1536
  %_p_scalar_63.3 = load double, ptr %gep71.3, align 8, !alias.scope !392, !noalias !393
  %p_mul11.3 = fmul double %_p_scalar_.3, %_p_scalar_63.3, !dbg !365
  %p_add12.3 = fadd double %p_add12.2, %p_mul11.3, !dbg !366
  %gep71.4 = getelementptr i8, ptr %invariant.gep70, i64 2048
  %_p_scalar_63.4 = load double, ptr %gep71.4, align 8, !alias.scope !392, !noalias !393
  %p_mul11.4 = fmul double %_p_scalar_.4, %_p_scalar_63.4, !dbg !365
  %p_add12.4 = fadd double %p_add12.3, %p_mul11.4, !dbg !366
  %gep71.5 = getelementptr i8, ptr %invariant.gep70, i64 2560
  %_p_scalar_63.5 = load double, ptr %gep71.5, align 8, !alias.scope !392, !noalias !393
  %p_mul11.5 = fmul double %_p_scalar_.5, %_p_scalar_63.5, !dbg !365
  %p_add12.5 = fadd double %p_add12.4, %p_mul11.5, !dbg !366
  %gep71.6 = getelementptr i8, ptr %invariant.gep70, i64 3072
  %_p_scalar_63.6 = load double, ptr %gep71.6, align 8, !alias.scope !392, !noalias !393
  %p_mul11.6 = fmul double %_p_scalar_.6, %_p_scalar_63.6, !dbg !365
  %p_add12.6 = fadd double %p_add12.5, %p_mul11.6, !dbg !366
  %gep71.7 = getelementptr i8, ptr %invariant.gep70, i64 3584
  %_p_scalar_63.7 = load double, ptr %gep71.7, align 8, !alias.scope !392, !noalias !393
  %p_mul11.7 = fmul double %_p_scalar_.7, %_p_scalar_63.7, !dbg !365
  %p_add12.7 = fadd double %p_add12.6, %p_mul11.7, !dbg !366
  %gep71.8 = getelementptr i8, ptr %invariant.gep70, i64 4096
  %_p_scalar_63.8 = load double, ptr %gep71.8, align 8, !alias.scope !392, !noalias !393
  %p_mul11.8 = fmul double %_p_scalar_.8, %_p_scalar_63.8, !dbg !365
  %p_add12.8 = fadd double %p_add12.7, %p_mul11.8, !dbg !366
  %gep71.9 = getelementptr i8, ptr %invariant.gep70, i64 4608
  %_p_scalar_63.9 = load double, ptr %gep71.9, align 8, !alias.scope !392, !noalias !393
  %p_mul11.9 = fmul double %_p_scalar_.9, %_p_scalar_63.9, !dbg !365
  %p_add12.9 = fadd double %p_add12.8, %p_mul11.9, !dbg !366
  %gep71.10 = getelementptr i8, ptr %invariant.gep70, i64 5120
  %_p_scalar_63.10 = load double, ptr %gep71.10, align 8, !alias.scope !392, !noalias !393
  %p_mul11.10 = fmul double %_p_scalar_.10, %_p_scalar_63.10, !dbg !365
  %p_add12.10 = fadd double %p_add12.9, %p_mul11.10, !dbg !366
  %gep71.11 = getelementptr i8, ptr %invariant.gep70, i64 5632
  %_p_scalar_63.11 = load double, ptr %gep71.11, align 8, !alias.scope !392, !noalias !393
  %p_mul11.11 = fmul double %_p_scalar_.11, %_p_scalar_63.11, !dbg !365
  %p_add12.11 = fadd double %p_add12.10, %p_mul11.11, !dbg !366
  %gep71.12 = getelementptr i8, ptr %invariant.gep70, i64 6144
  %_p_scalar_63.12 = load double, ptr %gep71.12, align 8, !alias.scope !392, !noalias !393
  %p_mul11.12 = fmul double %_p_scalar_.12, %_p_scalar_63.12, !dbg !365
  %p_add12.12 = fadd double %p_add12.11, %p_mul11.12, !dbg !366
  %gep71.13 = getelementptr i8, ptr %invariant.gep70, i64 6656
  %_p_scalar_63.13 = load double, ptr %gep71.13, align 8, !alias.scope !392, !noalias !393
  %p_mul11.13 = fmul double %_p_scalar_.13, %_p_scalar_63.13, !dbg !365
  %p_add12.13 = fadd double %p_add12.12, %p_mul11.13, !dbg !366
  %gep71.14 = getelementptr i8, ptr %invariant.gep70, i64 7168
  %_p_scalar_63.14 = load double, ptr %gep71.14, align 8, !alias.scope !392, !noalias !393
  %p_mul11.14 = fmul double %_p_scalar_.14, %_p_scalar_63.14, !dbg !365
  %p_add12.14 = fadd double %p_add12.13, %p_mul11.14, !dbg !366
  %gep71.15 = getelementptr i8, ptr %invariant.gep70, i64 7680
  %_p_scalar_63.15 = load double, ptr %gep71.15, align 8, !alias.scope !392, !noalias !393
  %p_mul11.15 = fmul double %_p_scalar_.15, %_p_scalar_63.15, !dbg !365
  %p_add12.15 = fadd double %p_add12.14, %p_mul11.15, !dbg !366
  %gep71.16 = getelementptr i8, ptr %invariant.gep70, i64 8192
  %_p_scalar_63.16 = load double, ptr %gep71.16, align 8, !alias.scope !392, !noalias !393
  %p_mul11.16 = fmul double %_p_scalar_.16, %_p_scalar_63.16, !dbg !365
  %p_add12.16 = fadd double %p_add12.15, %p_mul11.16, !dbg !366
  %gep71.17 = getelementptr i8, ptr %invariant.gep70, i64 8704
  %_p_scalar_63.17 = load double, ptr %gep71.17, align 8, !alias.scope !392, !noalias !393
  %p_mul11.17 = fmul double %_p_scalar_.17, %_p_scalar_63.17, !dbg !365
  %p_add12.17 = fadd double %p_add12.16, %p_mul11.17, !dbg !366
  %gep71.18 = getelementptr i8, ptr %invariant.gep70, i64 9216
  %_p_scalar_63.18 = load double, ptr %gep71.18, align 8, !alias.scope !392, !noalias !393
  %p_mul11.18 = fmul double %_p_scalar_.18, %_p_scalar_63.18, !dbg !365
  %p_add12.18 = fadd double %p_add12.17, %p_mul11.18, !dbg !366
  %gep71.19 = getelementptr i8, ptr %invariant.gep70, i64 9728
  %_p_scalar_63.19 = load double, ptr %gep71.19, align 8, !alias.scope !392, !noalias !393
  %p_mul11.19 = fmul double %_p_scalar_.19, %_p_scalar_63.19, !dbg !365
  %p_add12.19 = fadd double %p_add12.18, %p_mul11.19, !dbg !366
  %gep71.20 = getelementptr i8, ptr %invariant.gep70, i64 10240
  %_p_scalar_63.20 = load double, ptr %gep71.20, align 8, !alias.scope !392, !noalias !393
  %p_mul11.20 = fmul double %_p_scalar_.20, %_p_scalar_63.20, !dbg !365
  %p_add12.20 = fadd double %p_add12.19, %p_mul11.20, !dbg !366
  %gep71.21 = getelementptr i8, ptr %invariant.gep70, i64 10752
  %_p_scalar_63.21 = load double, ptr %gep71.21, align 8, !alias.scope !392, !noalias !393
  %p_mul11.21 = fmul double %_p_scalar_.21, %_p_scalar_63.21, !dbg !365
  %p_add12.21 = fadd double %p_add12.20, %p_mul11.21, !dbg !366
  %gep71.22 = getelementptr i8, ptr %invariant.gep70, i64 11264
  %_p_scalar_63.22 = load double, ptr %gep71.22, align 8, !alias.scope !392, !noalias !393
  %p_mul11.22 = fmul double %_p_scalar_.22, %_p_scalar_63.22, !dbg !365
  %p_add12.22 = fadd double %p_add12.21, %p_mul11.22, !dbg !366
  %gep71.23 = getelementptr i8, ptr %invariant.gep70, i64 11776
  %_p_scalar_63.23 = load double, ptr %gep71.23, align 8, !alias.scope !392, !noalias !393
  %p_mul11.23 = fmul double %_p_scalar_.23, %_p_scalar_63.23, !dbg !365
  %p_add12.23 = fadd double %p_add12.22, %p_mul11.23, !dbg !366
  %gep71.24 = getelementptr i8, ptr %invariant.gep70, i64 12288
  %_p_scalar_63.24 = load double, ptr %gep71.24, align 8, !alias.scope !392, !noalias !393
  %p_mul11.24 = fmul double %_p_scalar_.24, %_p_scalar_63.24, !dbg !365
  %p_add12.24 = fadd double %p_add12.23, %p_mul11.24, !dbg !366
  %gep71.25 = getelementptr i8, ptr %invariant.gep70, i64 12800
  %_p_scalar_63.25 = load double, ptr %gep71.25, align 8, !alias.scope !392, !noalias !393
  %p_mul11.25 = fmul double %_p_scalar_.25, %_p_scalar_63.25, !dbg !365
  %p_add12.25 = fadd double %p_add12.24, %p_mul11.25, !dbg !366
  %gep71.26 = getelementptr i8, ptr %invariant.gep70, i64 13312
  %_p_scalar_63.26 = load double, ptr %gep71.26, align 8, !alias.scope !392, !noalias !393
  %p_mul11.26 = fmul double %_p_scalar_.26, %_p_scalar_63.26, !dbg !365
  %p_add12.26 = fadd double %p_add12.25, %p_mul11.26, !dbg !366
  %gep71.27 = getelementptr i8, ptr %invariant.gep70, i64 13824
  %_p_scalar_63.27 = load double, ptr %gep71.27, align 8, !alias.scope !392, !noalias !393
  %p_mul11.27 = fmul double %_p_scalar_.27, %_p_scalar_63.27, !dbg !365
  %p_add12.27 = fadd double %p_add12.26, %p_mul11.27, !dbg !366
  %gep71.28 = getelementptr i8, ptr %invariant.gep70, i64 14336
  %_p_scalar_63.28 = load double, ptr %gep71.28, align 8, !alias.scope !392, !noalias !393
  %p_mul11.28 = fmul double %_p_scalar_.28, %_p_scalar_63.28, !dbg !365
  %p_add12.28 = fadd double %p_add12.27, %p_mul11.28, !dbg !366
  %gep71.29 = getelementptr i8, ptr %invariant.gep70, i64 14848
  %_p_scalar_63.29 = load double, ptr %gep71.29, align 8, !alias.scope !392, !noalias !393
  %p_mul11.29 = fmul double %_p_scalar_.29, %_p_scalar_63.29, !dbg !365
  %p_add12.29 = fadd double %p_add12.28, %p_mul11.29, !dbg !366
  %gep71.30 = getelementptr i8, ptr %invariant.gep70, i64 15360
  %_p_scalar_63.30 = load double, ptr %gep71.30, align 8, !alias.scope !392, !noalias !393
  %p_mul11.30 = fmul double %_p_scalar_.30, %_p_scalar_63.30, !dbg !365
  %p_add12.30 = fadd double %p_add12.29, %p_mul11.30, !dbg !366
  %gep71.31 = getelementptr i8, ptr %invariant.gep70, i64 15872
  %_p_scalar_63.31 = load double, ptr %gep71.31, align 8, !alias.scope !392, !noalias !393
  %p_mul11.31 = fmul double %_p_scalar_.31, %_p_scalar_63.31, !dbg !365
  %p_add12.31 = fadd double %p_add12.30, %p_mul11.31, !dbg !366
  store double %p_add12.31, ptr %polly.access.prod61, align 8, !alias.scope !394, !noalias !395
  %polly.indvar_next53 = add nuw nsw i64 %polly.indvar52.reg2mem.0.load, 1
  store i64 %polly.indvar_next53, ptr %polly.indvar_next53.reg2mem, align 8
  %exitcond174.not = icmp eq i64 %polly.indvar_next53, 32
  br i1 %exitcond174.not, label %polly.loop_exit51, label %polly.loop_preheader56.polly.loop_preheader56_crit_edge

polly.loop_preheader56.polly.loop_preheader56_crit_edge: ; preds = %polly.loop_preheader56
  store i64 %polly.indvar_next53, ptr %polly.indvar52.reg2mem, align 8
  br label %polly.loop_preheader56
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #0 !dbg !396 {
polly.loop_preheader:
  %polly.access.vargs55.promoted.reg2mem = alloca double, align 8
  %invariant.gep.reg2mem = alloca ptr, align 8
  %gep72.reg2mem = alloca ptr, align 8
  %polly.indvar46.reg2mem = alloca i64, align 8
  %polly.indvar_next53.reg2mem = alloca i64, align 8
  %p_add12.i.reg2mem = alloca double, align 8
  %.reg2mem = alloca ptr, align 8
  %gep74.reg2mem = alloca ptr, align 8
  %polly.indvar40.reg2mem = alloca i64, align 8
  %polly.indvar_next47.reg2mem = alloca i64, align 8
  %polly.indvar_next41.reg2mem = alloca i64, align 8
  %.reg2mem319 = alloca ptr, align 8
  %polly.indvar_next41.1.1.reg2mem = alloca i64, align 8
  %polly.indvar_next47.1.1.reg2mem = alloca i64, align 8
  %polly.indvar_next53.1.1.reg2mem = alloca i64, align 8
  %p_add12.i.1.1.reg2mem = alloca double, align 8
  %polly.access.vargs55.promoted.1.1.reg2mem = alloca double, align 8
  %gep.reg2mem = alloca ptr, align 8
  %gep72.1.1.reg2mem = alloca ptr, align 8
  %polly.indvar46.1.1.reg2mem = alloca i64, align 8
  %.reg2mem332 = alloca ptr, align 8
  %gep74.1.1.reg2mem = alloca ptr, align 8
  %polly.indvar40.1.1.reg2mem = alloca i64, align 8
  %invariant.gep263.reg2mem = alloca ptr, align 8
  %polly.indvar_next41.1204.reg2mem = alloca i64, align 8
  %polly.indvar_next47.1201.reg2mem = alloca i64, align 8
  %polly.indvar_next53.1198.reg2mem = alloca i64, align 8
  %p_add12.i.1197.reg2mem = alloca double, align 8
  %polly.access.vargs55.promoted.1188.reg2mem = alloca double, align 8
  %gep265.reg2mem = alloca ptr, align 8
  %gep72.1186.reg2mem = alloca ptr, align 8
  %polly.indvar46.1185.reg2mem = alloca i64, align 8
  %.reg2mem342 = alloca ptr, align 8
  %gep74.1183.reg2mem = alloca ptr, align 8
  %polly.indvar40.1181.reg2mem = alloca i64, align 8
  %invariant.gep264.reg2mem = alloca ptr, align 8
  %gep76.1.reg2mem = alloca ptr, align 8
  %polly.indvar_next41.1.reg2mem = alloca i64, align 8
  %polly.indvar_next47.1.reg2mem = alloca i64, align 8
  %polly.indvar_next53.1.reg2mem = alloca i64, align 8
  %p_add12.i.1.reg2mem = alloca double, align 8
  %polly.access.vargs55.promoted.1.reg2mem = alloca double, align 8
  %invariant.gep.1.reg2mem = alloca ptr, align 8
  %gep72.1.reg2mem = alloca ptr, align 8
  %polly.indvar46.1.reg2mem = alloca i64, align 8
  %.reg2mem353 = alloca ptr, align 8
  %gep74.1.reg2mem = alloca ptr, align 8
  %polly.indvar40.1.reg2mem = alloca i64, align 8
  %m2.reg2mem = alloca ptr, align 8
  %scevgep79.reg2mem = alloca ptr, align 8
  %polly.indvar46.reg2mem361 = alloca i64, align 8
  %polly.indvar52.reg2mem = alloca i64, align 8
  %p_add12.i70.reg2mem = alloca double, align 8
  %polly.indvar40.reg2mem363 = alloca i64, align 8
  %polly.indvar52.1.1.1.reg2mem = alloca i64, align 8
  %p_add12.i70.1.1.1.reg2mem = alloca double, align 8
  %polly.indvar46.1.1.1.reg2mem365 = alloca i64, align 8
  %polly.indvar40.1.1.1.reg2mem367 = alloca i64, align 8
  %polly.indvar52.1191.1.reg2mem = alloca i64, align 8
  %p_add12.i70.1190.1.reg2mem = alloca double, align 8
  %polly.indvar46.1185.1.reg2mem369 = alloca i64, align 8
  %polly.indvar40.1181.1.reg2mem371 = alloca i64, align 8
  %polly.indvar52.1.1246.reg2mem = alloca i64, align 8
  %p_add12.i70.1.1245.reg2mem = alloca double, align 8
  %polly.indvar46.1.1240.reg2mem373 = alloca i64, align 8
  %polly.indvar40.1.1236.reg2mem375 = alloca i64, align 8
  %polly.indvar52.1219.reg2mem = alloca i64, align 8
  %p_add12.i70.1218.reg2mem = alloca double, align 8
  %polly.indvar46.1213.reg2mem377 = alloca i64, align 8
  %polly.indvar40.1209.reg2mem379 = alloca i64, align 8
  %polly.indvar52.1.1.reg2mem = alloca i64, align 8
  %p_add12.i70.1.1.reg2mem = alloca double, align 8
  %polly.indvar46.1.1.reg2mem381 = alloca i64, align 8
  %polly.indvar40.1.1.reg2mem383 = alloca i64, align 8
  %polly.indvar52.1191.reg2mem = alloca i64, align 8
  %p_add12.i70.1190.reg2mem = alloca double, align 8
  %polly.indvar46.1185.reg2mem385 = alloca i64, align 8
  %polly.indvar40.1181.reg2mem387 = alloca i64, align 8
  %polly.indvar52.1.reg2mem = alloca i64, align 8
  %p_add12.i70.1.reg2mem = alloca double, align 8
  %polly.indvar46.1.reg2mem389 = alloca i64, align 8
  %polly.indvar40.1.reg2mem391 = alloca i64, align 8
    #dbg_value(ptr %vargs, !400, !DIExpression(), !402)
    #dbg_value(ptr %vargs, !401, !DIExpression(), !402)
    #dbg_value(ptr %vargs, !330, !DIExpression(), !403)
    #dbg_value(ptr %m2, !331, !DIExpression(), !403)
    #dbg_value(ptr %vargs, !332, !DIExpression(DW_OP_plus_uconst, 65536, DW_OP_stack_value), !403)
    #dbg_label(!339, !405)
    #dbg_value(i32 0, !333, !DIExpression(), !403)
  %scevgep79 = getelementptr i8, ptr %vargs, i64 65536
  store ptr %scevgep79, ptr %scevgep79.reg2mem, align 8
  %m2 = getelementptr i8, ptr %vargs, i64 32768, !dbg !406
  store ptr %m2, ptr %m2.reg2mem, align 8
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(32768) %scevgep79, i8 0, i64 32768, i1 false)
  store i64 0, ptr %polly.indvar40.reg2mem363, align 8
  br label %polly.loop_preheader44

polly.loop_preheader44.1:                         ; preds = %polly.loop_exit45.polly.loop_preheader44.1_crit_edge, %polly.loop_exit45.1.polly.loop_preheader44.1_crit_edge
  %polly.indvar40.1.reg2mem391.0.load = load i64, ptr %polly.indvar40.1.reg2mem391, align 8
  store i64 %polly.indvar40.1.reg2mem391.0.load, ptr %polly.indvar40.1.reg2mem, align 8
  %.idx63.1 = shl i64 %polly.indvar40.1.reg2mem391.0.load, 9
  %gep74.1 = getelementptr i8, ptr %scevgep79, i64 %.idx63.1
  store ptr %gep74.1, ptr %gep74.1.reg2mem, align 8
  %0 = getelementptr i8, ptr %vargs, i64 %.idx63.1
  store ptr %0, ptr %.reg2mem353, align 8
  store i64 0, ptr %polly.indvar46.1.reg2mem389, align 8
  br label %polly.loop_preheader50.1

polly.loop_preheader50.1:                         ; preds = %polly.loop_exit51.1.polly.loop_preheader50.1_crit_edge, %polly.loop_preheader44.1
  %polly.indvar46.1.reg2mem389.0.load = load i64, ptr %polly.indvar46.1.reg2mem389, align 8
  store i64 %polly.indvar46.1.reg2mem389.0.load, ptr %polly.indvar46.1.reg2mem, align 8
  %gep72.1 = getelementptr double, ptr %gep74.1, i64 %polly.indvar46.1.reg2mem389.0.load
  store ptr %gep72.1, ptr %gep72.1.reg2mem, align 8
  %1 = shl i64 %polly.indvar46.1.reg2mem389.0.load, 3
  %invariant.gep.1 = getelementptr i8, ptr %m2, i64 %1
  store ptr %invariant.gep.1, ptr %invariant.gep.1.reg2mem, align 8
  %polly.access.vargs55.promoted.1 = load double, ptr %gep72.1, align 8
  store double %polly.access.vargs55.promoted.1, ptr %polly.access.vargs55.promoted.1.reg2mem, align 8
  store i64 0, ptr %polly.indvar52.1.reg2mem, align 8
  store double %polly.access.vargs55.promoted.1, ptr %p_add12.i70.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1

polly.stmt.for.body6.i.1:                         ; preds = %polly.stmt.for.body6.i.1.polly.stmt.for.body6.i.1_crit_edge, %polly.loop_preheader50.1
  %p_add12.i70.1.reg2mem.0.p_add12.i70.1.reload = load double, ptr %p_add12.i70.1.reg2mem, align 8
  %polly.indvar52.1.reg2mem.0.load = load i64, ptr %polly.indvar52.1.reg2mem, align 8
  %2 = add nuw nsw i64 %polly.indvar52.1.reg2mem.0.load, 32
  %3 = shl i64 %2, 3
  %scevgep.1 = getelementptr i8, ptr %0, i64 %3
  %_p_scalar_.1 = load double, ptr %scevgep.1, align 8, !alias.scope !407, !noalias !410
  %4 = shl i64 %2, 9
  %gep69.1 = getelementptr i8, ptr %invariant.gep.1, i64 %4
  %_p_scalar_58.1 = load double, ptr %gep69.1, align 8, !alias.scope !407, !noalias !410
  %p_mul11.i.1 = fmul double %_p_scalar_.1, %_p_scalar_58.1, !dbg !411
  %p_add12.i.1 = fadd double %p_add12.i70.1.reg2mem.0.p_add12.i70.1.reload, %p_mul11.i.1, !dbg !412
  store double %p_add12.i.1, ptr %p_add12.i.1.reg2mem, align 8
  store double %p_add12.i.1, ptr %gep72.1, align 8, !alias.scope !407, !noalias !410
  %polly.indvar_next53.1 = add nuw nsw i64 %polly.indvar52.1.reg2mem.0.load, 1
  store i64 %polly.indvar_next53.1, ptr %polly.indvar_next53.1.reg2mem, align 8
  %exitcond.1.not = icmp eq i64 %polly.indvar_next53.1, 32
  br i1 %exitcond.1.not, label %polly.loop_exit51.1, label %polly.stmt.for.body6.i.1.polly.stmt.for.body6.i.1_crit_edge

polly.stmt.for.body6.i.1.polly.stmt.for.body6.i.1_crit_edge: ; preds = %polly.stmt.for.body6.i.1
  store i64 %polly.indvar_next53.1, ptr %polly.indvar52.1.reg2mem, align 8
  store double %p_add12.i.1, ptr %p_add12.i70.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1

polly.loop_exit51.1:                              ; preds = %polly.stmt.for.body6.i.1
  %polly.indvar_next47.1 = add nuw nsw i64 %polly.indvar46.1.reg2mem389.0.load, 1
  store i64 %polly.indvar_next47.1, ptr %polly.indvar_next47.1.reg2mem, align 8
  %exitcond179.1.not = icmp eq i64 %polly.indvar_next47.1, 32
  br i1 %exitcond179.1.not, label %polly.loop_exit45.1, label %polly.loop_exit51.1.polly.loop_preheader50.1_crit_edge

polly.loop_exit51.1.polly.loop_preheader50.1_crit_edge: ; preds = %polly.loop_exit51.1
  store i64 %polly.indvar_next47.1, ptr %polly.indvar46.1.reg2mem389, align 8
  br label %polly.loop_preheader50.1

polly.loop_exit45.1:                              ; preds = %polly.loop_exit51.1
  %polly.indvar_next41.1 = add nuw nsw i64 %polly.indvar40.1.reg2mem391.0.load, 1
  store i64 %polly.indvar_next41.1, ptr %polly.indvar_next41.1.reg2mem, align 8
  %exitcond180.1.not = icmp eq i64 %polly.indvar_next41.1, 32
  br i1 %exitcond180.1.not, label %polly.loop_exit39.1, label %polly.loop_exit45.1.polly.loop_preheader44.1_crit_edge

polly.loop_exit45.1.polly.loop_preheader44.1_crit_edge: ; preds = %polly.loop_exit45.1
  store i64 %polly.indvar_next41.1, ptr %polly.indvar40.1.reg2mem391, align 8
  br label %polly.loop_preheader44.1

polly.loop_exit39.1:                              ; preds = %polly.loop_exit45.1
  %gep76.1 = getelementptr i8, ptr %vargs, i64 65792
  store ptr %gep76.1, ptr %gep76.1.reg2mem, align 8
  %invariant.gep264 = getelementptr i8, ptr %vargs, i64 33024
  store ptr %invariant.gep264, ptr %invariant.gep264.reg2mem, align 8
  store i64 0, ptr %polly.indvar40.1181.reg2mem387, align 8
  br label %polly.loop_preheader44.1184

polly.loop_preheader44.1184:                      ; preds = %polly.loop_exit45.1206.polly.loop_preheader44.1184_crit_edge, %polly.loop_exit39.1
  %polly.indvar40.1181.reg2mem387.0.load = load i64, ptr %polly.indvar40.1181.reg2mem387, align 8
  store i64 %polly.indvar40.1181.reg2mem387.0.load, ptr %polly.indvar40.1181.reg2mem, align 8
  %.idx63.1182 = shl i64 %polly.indvar40.1181.reg2mem387.0.load, 9
  %gep74.1183 = getelementptr i8, ptr %gep76.1, i64 %.idx63.1182
  store ptr %gep74.1183, ptr %gep74.1183.reg2mem, align 8
  %5 = getelementptr i8, ptr %vargs, i64 %.idx63.1182
  store ptr %5, ptr %.reg2mem342, align 8
  store i64 0, ptr %polly.indvar46.1185.reg2mem385, align 8
  br label %polly.loop_preheader50.1189

polly.loop_preheader50.1189:                      ; preds = %polly.loop_exit51.1203.polly.loop_preheader50.1189_crit_edge, %polly.loop_preheader44.1184
  %polly.indvar46.1185.reg2mem385.0.load = load i64, ptr %polly.indvar46.1185.reg2mem385, align 8
  store i64 %polly.indvar46.1185.reg2mem385.0.load, ptr %polly.indvar46.1185.reg2mem, align 8
  %gep72.1186 = getelementptr double, ptr %gep74.1183, i64 %polly.indvar46.1185.reg2mem385.0.load
  store ptr %gep72.1186, ptr %gep72.1186.reg2mem, align 8
  %6 = shl i64 %polly.indvar46.1185.reg2mem385.0.load, 3
  %gep265 = getelementptr i8, ptr %invariant.gep264, i64 %6
  store ptr %gep265, ptr %gep265.reg2mem, align 8
  %polly.access.vargs55.promoted.1188 = load double, ptr %gep72.1186, align 8
  store double %polly.access.vargs55.promoted.1188, ptr %polly.access.vargs55.promoted.1188.reg2mem, align 8
  store i64 0, ptr %polly.indvar52.1191.reg2mem, align 8
  store double %polly.access.vargs55.promoted.1188, ptr %p_add12.i70.1190.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1200

polly.stmt.for.body6.i.1200:                      ; preds = %polly.stmt.for.body6.i.1200.polly.stmt.for.body6.i.1200_crit_edge, %polly.loop_preheader50.1189
  %p_add12.i70.1190.reg2mem.0.p_add12.i70.1190.reload = load double, ptr %p_add12.i70.1190.reg2mem, align 8
  %polly.indvar52.1191.reg2mem.0.load = load i64, ptr %polly.indvar52.1191.reg2mem, align 8
  %7 = shl i64 %polly.indvar52.1191.reg2mem.0.load, 3
  %scevgep.1192 = getelementptr i8, ptr %5, i64 %7
  %_p_scalar_.1193 = load double, ptr %scevgep.1192, align 8, !alias.scope !407, !noalias !410
  %8 = shl i64 %polly.indvar52.1191.reg2mem.0.load, 9
  %gep69.1194 = getelementptr i8, ptr %gep265, i64 %8
  %_p_scalar_58.1195 = load double, ptr %gep69.1194, align 8, !alias.scope !407, !noalias !410
  %p_mul11.i.1196 = fmul double %_p_scalar_.1193, %_p_scalar_58.1195, !dbg !411
  %p_add12.i.1197 = fadd double %p_add12.i70.1190.reg2mem.0.p_add12.i70.1190.reload, %p_mul11.i.1196, !dbg !412
  store double %p_add12.i.1197, ptr %p_add12.i.1197.reg2mem, align 8
  store double %p_add12.i.1197, ptr %gep72.1186, align 8, !alias.scope !407, !noalias !410
  %polly.indvar_next53.1198 = add nuw nsw i64 %polly.indvar52.1191.reg2mem.0.load, 1
  store i64 %polly.indvar_next53.1198, ptr %polly.indvar_next53.1198.reg2mem, align 8
  %exitcond.1199.not = icmp eq i64 %polly.indvar_next53.1198, 32
  br i1 %exitcond.1199.not, label %polly.loop_exit51.1203, label %polly.stmt.for.body6.i.1200.polly.stmt.for.body6.i.1200_crit_edge

polly.stmt.for.body6.i.1200.polly.stmt.for.body6.i.1200_crit_edge: ; preds = %polly.stmt.for.body6.i.1200
  store i64 %polly.indvar_next53.1198, ptr %polly.indvar52.1191.reg2mem, align 8
  store double %p_add12.i.1197, ptr %p_add12.i70.1190.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1200

polly.loop_exit51.1203:                           ; preds = %polly.stmt.for.body6.i.1200
  %polly.indvar_next47.1201 = add nuw nsw i64 %polly.indvar46.1185.reg2mem385.0.load, 1
  store i64 %polly.indvar_next47.1201, ptr %polly.indvar_next47.1201.reg2mem, align 8
  %exitcond179.1202.not = icmp eq i64 %polly.indvar_next47.1201, 32
  br i1 %exitcond179.1202.not, label %polly.loop_exit45.1206, label %polly.loop_exit51.1203.polly.loop_preheader50.1189_crit_edge

polly.loop_exit51.1203.polly.loop_preheader50.1189_crit_edge: ; preds = %polly.loop_exit51.1203
  store i64 %polly.indvar_next47.1201, ptr %polly.indvar46.1185.reg2mem385, align 8
  br label %polly.loop_preheader50.1189

polly.loop_exit45.1206:                           ; preds = %polly.loop_exit51.1203
  %polly.indvar_next41.1204 = add nuw nsw i64 %polly.indvar40.1181.reg2mem387.0.load, 1
  store i64 %polly.indvar_next41.1204, ptr %polly.indvar_next41.1204.reg2mem, align 8
  %exitcond180.1205.not = icmp eq i64 %polly.indvar_next41.1204, 32
  br i1 %exitcond180.1205.not, label %polly.loop_exit39.1207, label %polly.loop_exit45.1206.polly.loop_preheader44.1184_crit_edge

polly.loop_exit45.1206.polly.loop_preheader44.1184_crit_edge: ; preds = %polly.loop_exit45.1206
  store i64 %polly.indvar_next41.1204, ptr %polly.indvar40.1181.reg2mem387, align 8
  br label %polly.loop_preheader44.1184

polly.loop_exit39.1207:                           ; preds = %polly.loop_exit45.1206
  store ptr %invariant.gep264, ptr %invariant.gep263.reg2mem, align 8
  store i64 0, ptr %polly.indvar40.1.1.reg2mem383, align 8
  br label %polly.loop_preheader44.1.1

polly.loop_preheader44.1.1:                       ; preds = %polly.loop_exit45.1.1.polly.loop_preheader44.1.1_crit_edge, %polly.loop_exit39.1207
  %polly.indvar40.1.1.reg2mem383.0.load = load i64, ptr %polly.indvar40.1.1.reg2mem383, align 8
  store i64 %polly.indvar40.1.1.reg2mem383.0.load, ptr %polly.indvar40.1.1.reg2mem, align 8
  %.idx63.1.1 = shl i64 %polly.indvar40.1.1.reg2mem383.0.load, 9
  %gep74.1.1 = getelementptr i8, ptr %gep76.1, i64 %.idx63.1.1
  store ptr %gep74.1.1, ptr %gep74.1.1.reg2mem, align 8
  %9 = getelementptr i8, ptr %vargs, i64 %.idx63.1.1
  store ptr %9, ptr %.reg2mem332, align 8
  store i64 0, ptr %polly.indvar46.1.1.reg2mem381, align 8
  br label %polly.loop_preheader50.1.1

polly.loop_preheader50.1.1:                       ; preds = %polly.loop_exit51.1.1.polly.loop_preheader50.1.1_crit_edge, %polly.loop_preheader44.1.1
  %polly.indvar46.1.1.reg2mem381.0.load = load i64, ptr %polly.indvar46.1.1.reg2mem381, align 8
  store i64 %polly.indvar46.1.1.reg2mem381.0.load, ptr %polly.indvar46.1.1.reg2mem, align 8
  %gep72.1.1 = getelementptr double, ptr %gep74.1.1, i64 %polly.indvar46.1.1.reg2mem381.0.load
  store ptr %gep72.1.1, ptr %gep72.1.1.reg2mem, align 8
  %10 = shl i64 %polly.indvar46.1.1.reg2mem381.0.load, 3
  %gep = getelementptr i8, ptr %invariant.gep264, i64 %10
  store ptr %gep, ptr %gep.reg2mem, align 8
  %polly.access.vargs55.promoted.1.1 = load double, ptr %gep72.1.1, align 8
  store double %polly.access.vargs55.promoted.1.1, ptr %polly.access.vargs55.promoted.1.1.reg2mem, align 8
  store i64 0, ptr %polly.indvar52.1.1.reg2mem, align 8
  store double %polly.access.vargs55.promoted.1.1, ptr %p_add12.i70.1.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1.1

polly.stmt.for.body6.i.1.1:                       ; preds = %polly.stmt.for.body6.i.1.1.polly.stmt.for.body6.i.1.1_crit_edge, %polly.loop_preheader50.1.1
  %p_add12.i70.1.1.reg2mem.0.p_add12.i70.1.1.reload = load double, ptr %p_add12.i70.1.1.reg2mem, align 8
  %polly.indvar52.1.1.reg2mem.0.load = load i64, ptr %polly.indvar52.1.1.reg2mem, align 8
  %11 = add nuw nsw i64 %polly.indvar52.1.1.reg2mem.0.load, 32
  %12 = shl i64 %11, 3
  %scevgep.1.1 = getelementptr i8, ptr %9, i64 %12
  %_p_scalar_.1.1 = load double, ptr %scevgep.1.1, align 8, !alias.scope !407, !noalias !410
  %13 = shl i64 %11, 9
  %gep69.1.1 = getelementptr i8, ptr %gep, i64 %13
  %_p_scalar_58.1.1 = load double, ptr %gep69.1.1, align 8, !alias.scope !407, !noalias !410
  %p_mul11.i.1.1 = fmul double %_p_scalar_.1.1, %_p_scalar_58.1.1, !dbg !411
  %p_add12.i.1.1 = fadd double %p_add12.i70.1.1.reg2mem.0.p_add12.i70.1.1.reload, %p_mul11.i.1.1, !dbg !412
  store double %p_add12.i.1.1, ptr %p_add12.i.1.1.reg2mem, align 8
  store double %p_add12.i.1.1, ptr %gep72.1.1, align 8, !alias.scope !407, !noalias !410
  %polly.indvar_next53.1.1 = add nuw nsw i64 %polly.indvar52.1.1.reg2mem.0.load, 1
  store i64 %polly.indvar_next53.1.1, ptr %polly.indvar_next53.1.1.reg2mem, align 8
  %exitcond.1.1.not = icmp eq i64 %polly.indvar_next53.1.1, 32
  br i1 %exitcond.1.1.not, label %polly.loop_exit51.1.1, label %polly.stmt.for.body6.i.1.1.polly.stmt.for.body6.i.1.1_crit_edge

polly.stmt.for.body6.i.1.1.polly.stmt.for.body6.i.1.1_crit_edge: ; preds = %polly.stmt.for.body6.i.1.1
  store i64 %polly.indvar_next53.1.1, ptr %polly.indvar52.1.1.reg2mem, align 8
  store double %p_add12.i.1.1, ptr %p_add12.i70.1.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1.1

polly.loop_exit51.1.1:                            ; preds = %polly.stmt.for.body6.i.1.1
  %polly.indvar_next47.1.1 = add nuw nsw i64 %polly.indvar46.1.1.reg2mem381.0.load, 1
  store i64 %polly.indvar_next47.1.1, ptr %polly.indvar_next47.1.1.reg2mem, align 8
  %exitcond179.1.1.not = icmp eq i64 %polly.indvar_next47.1.1, 32
  br i1 %exitcond179.1.1.not, label %polly.loop_exit45.1.1, label %polly.loop_exit51.1.1.polly.loop_preheader50.1.1_crit_edge

polly.loop_exit51.1.1.polly.loop_preheader50.1.1_crit_edge: ; preds = %polly.loop_exit51.1.1
  store i64 %polly.indvar_next47.1.1, ptr %polly.indvar46.1.1.reg2mem381, align 8
  br label %polly.loop_preheader50.1.1

polly.loop_exit45.1.1:                            ; preds = %polly.loop_exit51.1.1
  %polly.indvar_next41.1.1 = add nuw nsw i64 %polly.indvar40.1.1.reg2mem383.0.load, 1
  store i64 %polly.indvar_next41.1.1, ptr %polly.indvar_next41.1.1.reg2mem, align 8
  %exitcond180.1.1.not = icmp eq i64 %polly.indvar_next41.1.1, 32
  br i1 %exitcond180.1.1.not, label %polly.loop_exit39.1.1, label %polly.loop_exit45.1.1.polly.loop_preheader44.1.1_crit_edge

polly.loop_exit45.1.1.polly.loop_preheader44.1.1_crit_edge: ; preds = %polly.loop_exit45.1.1
  store i64 %polly.indvar_next41.1.1, ptr %polly.indvar40.1.1.reg2mem383, align 8
  br label %polly.loop_preheader44.1.1

polly.loop_exit39.1.1:                            ; preds = %polly.loop_exit45.1.1
  %gep78.1 = getelementptr i8, ptr %vargs, i64 81920
  %14 = getelementptr i8, ptr %vargs, i64 16384
  store ptr %14, ptr %.reg2mem319, align 8
  store i64 0, ptr %polly.indvar40.1209.reg2mem379, align 8
  br label %polly.loop_preheader44.1212

polly.loop_preheader44.1212:                      ; preds = %polly.loop_exit45.1234.polly.loop_preheader44.1212_crit_edge, %polly.loop_exit39.1.1
  %polly.indvar40.1209.reg2mem379.0.load = load i64, ptr %polly.indvar40.1209.reg2mem379, align 8
  %.idx63.1210 = shl i64 %polly.indvar40.1209.reg2mem379.0.load, 9
  %gep74.1211 = getelementptr i8, ptr %gep78.1, i64 %.idx63.1210
  %15 = getelementptr i8, ptr %14, i64 %.idx63.1210
  store i64 0, ptr %polly.indvar46.1213.reg2mem377, align 8
  br label %polly.loop_preheader50.1217

polly.loop_preheader50.1217:                      ; preds = %polly.loop_exit51.1231.polly.loop_preheader50.1217_crit_edge, %polly.loop_preheader44.1212
  %polly.indvar46.1213.reg2mem377.0.load = load i64, ptr %polly.indvar46.1213.reg2mem377, align 8
  %gep72.1214 = getelementptr double, ptr %gep74.1211, i64 %polly.indvar46.1213.reg2mem377.0.load
  %16 = shl i64 %polly.indvar46.1213.reg2mem377.0.load, 3
  %m2.reg2mem.0.m2.reload356 = load ptr, ptr %m2.reg2mem, align 8
  %invariant.gep.1215 = getelementptr i8, ptr %m2.reg2mem.0.m2.reload356, i64 %16
  %polly.access.vargs55.promoted.1216 = load double, ptr %gep72.1214, align 8
  store i64 0, ptr %polly.indvar52.1219.reg2mem, align 8
  store double %polly.access.vargs55.promoted.1216, ptr %p_add12.i70.1218.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1228

polly.stmt.for.body6.i.1228:                      ; preds = %polly.stmt.for.body6.i.1228.polly.stmt.for.body6.i.1228_crit_edge, %polly.loop_preheader50.1217
  %p_add12.i70.1218.reg2mem.0.p_add12.i70.1218.reload = load double, ptr %p_add12.i70.1218.reg2mem, align 8
  %polly.indvar52.1219.reg2mem.0.load = load i64, ptr %polly.indvar52.1219.reg2mem, align 8
  %17 = shl i64 %polly.indvar52.1219.reg2mem.0.load, 3
  %scevgep.1220 = getelementptr i8, ptr %15, i64 %17
  %_p_scalar_.1221 = load double, ptr %scevgep.1220, align 8, !alias.scope !407, !noalias !410
  %18 = shl i64 %polly.indvar52.1219.reg2mem.0.load, 9
  %gep69.1222 = getelementptr i8, ptr %invariant.gep.1215, i64 %18
  %_p_scalar_58.1223 = load double, ptr %gep69.1222, align 8, !alias.scope !407, !noalias !410
  %p_mul11.i.1224 = fmul double %_p_scalar_.1221, %_p_scalar_58.1223, !dbg !411
  %p_add12.i.1225 = fadd double %p_add12.i70.1218.reg2mem.0.p_add12.i70.1218.reload, %p_mul11.i.1224, !dbg !412
  store double %p_add12.i.1225, ptr %gep72.1214, align 8, !alias.scope !407, !noalias !410
  %polly.indvar_next53.1226 = add nuw nsw i64 %polly.indvar52.1219.reg2mem.0.load, 1
  %exitcond.1227.not = icmp eq i64 %polly.indvar_next53.1226, 32
  br i1 %exitcond.1227.not, label %polly.loop_exit51.1231, label %polly.stmt.for.body6.i.1228.polly.stmt.for.body6.i.1228_crit_edge

polly.stmt.for.body6.i.1228.polly.stmt.for.body6.i.1228_crit_edge: ; preds = %polly.stmt.for.body6.i.1228
  store i64 %polly.indvar_next53.1226, ptr %polly.indvar52.1219.reg2mem, align 8
  store double %p_add12.i.1225, ptr %p_add12.i70.1218.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1228

polly.loop_exit51.1231:                           ; preds = %polly.stmt.for.body6.i.1228
  %polly.indvar_next47.1229 = add nuw nsw i64 %polly.indvar46.1213.reg2mem377.0.load, 1
  %exitcond179.1230.not = icmp eq i64 %polly.indvar_next47.1229, 32
  br i1 %exitcond179.1230.not, label %polly.loop_exit45.1234, label %polly.loop_exit51.1231.polly.loop_preheader50.1217_crit_edge

polly.loop_exit51.1231.polly.loop_preheader50.1217_crit_edge: ; preds = %polly.loop_exit51.1231
  store i64 %polly.indvar_next47.1229, ptr %polly.indvar46.1213.reg2mem377, align 8
  br label %polly.loop_preheader50.1217

polly.loop_exit45.1234:                           ; preds = %polly.loop_exit51.1231
  %polly.indvar_next41.1232 = add nuw nsw i64 %polly.indvar40.1209.reg2mem379.0.load, 1
  %exitcond180.1233.not = icmp eq i64 %polly.indvar_next41.1232, 32
  br i1 %exitcond180.1233.not, label %polly.loop_exit45.1234.polly.loop_preheader44.1.1239_crit_edge, label %polly.loop_exit45.1234.polly.loop_preheader44.1212_crit_edge

polly.loop_exit45.1234.polly.loop_preheader44.1212_crit_edge: ; preds = %polly.loop_exit45.1234
  store i64 %polly.indvar_next41.1232, ptr %polly.indvar40.1209.reg2mem379, align 8
  br label %polly.loop_preheader44.1212

polly.loop_exit45.1234.polly.loop_preheader44.1.1239_crit_edge: ; preds = %polly.loop_exit45.1234
  store i64 0, ptr %polly.indvar40.1.1236.reg2mem375, align 8
  br label %polly.loop_preheader44.1.1239

polly.loop_preheader44.1.1239:                    ; preds = %polly.loop_exit45.1.1261.polly.loop_preheader44.1.1239_crit_edge, %polly.loop_exit45.1234.polly.loop_preheader44.1.1239_crit_edge
  %polly.indvar40.1.1236.reg2mem375.0.load = load i64, ptr %polly.indvar40.1.1236.reg2mem375, align 8
  %.idx63.1.1237 = shl i64 %polly.indvar40.1.1236.reg2mem375.0.load, 9
  %gep74.1.1238 = getelementptr i8, ptr %gep78.1, i64 %.idx63.1.1237
  %19 = getelementptr i8, ptr %14, i64 %.idx63.1.1237
  store i64 0, ptr %polly.indvar46.1.1240.reg2mem373, align 8
  br label %polly.loop_preheader50.1.1244

polly.loop_preheader50.1.1244:                    ; preds = %polly.loop_exit51.1.1258.polly.loop_preheader50.1.1244_crit_edge, %polly.loop_preheader44.1.1239
  %polly.indvar46.1.1240.reg2mem373.0.load = load i64, ptr %polly.indvar46.1.1240.reg2mem373, align 8
  %gep72.1.1241 = getelementptr double, ptr %gep74.1.1238, i64 %polly.indvar46.1.1240.reg2mem373.0.load
  %20 = shl i64 %polly.indvar46.1.1240.reg2mem373.0.load, 3
  %m2.reg2mem.0.m2.reload = load ptr, ptr %m2.reg2mem, align 8
  %invariant.gep.1.1242 = getelementptr i8, ptr %m2.reg2mem.0.m2.reload, i64 %20
  %polly.access.vargs55.promoted.1.1243 = load double, ptr %gep72.1.1241, align 8
  store i64 0, ptr %polly.indvar52.1.1246.reg2mem, align 8
  store double %polly.access.vargs55.promoted.1.1243, ptr %p_add12.i70.1.1245.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1.1255

polly.stmt.for.body6.i.1.1255:                    ; preds = %polly.stmt.for.body6.i.1.1255.polly.stmt.for.body6.i.1.1255_crit_edge, %polly.loop_preheader50.1.1244
  %p_add12.i70.1.1245.reg2mem.0.p_add12.i70.1.1245.reload = load double, ptr %p_add12.i70.1.1245.reg2mem, align 8
  %polly.indvar52.1.1246.reg2mem.0.load = load i64, ptr %polly.indvar52.1.1246.reg2mem, align 8
  %21 = add nuw nsw i64 %polly.indvar52.1.1246.reg2mem.0.load, 32
  %22 = shl i64 %21, 3
  %scevgep.1.1247 = getelementptr i8, ptr %19, i64 %22
  %_p_scalar_.1.1248 = load double, ptr %scevgep.1.1247, align 8, !alias.scope !407, !noalias !410
  %23 = shl i64 %21, 9
  %gep69.1.1249 = getelementptr i8, ptr %invariant.gep.1.1242, i64 %23
  %_p_scalar_58.1.1250 = load double, ptr %gep69.1.1249, align 8, !alias.scope !407, !noalias !410
  %p_mul11.i.1.1251 = fmul double %_p_scalar_.1.1248, %_p_scalar_58.1.1250, !dbg !411
  %p_add12.i.1.1252 = fadd double %p_add12.i70.1.1245.reg2mem.0.p_add12.i70.1.1245.reload, %p_mul11.i.1.1251, !dbg !412
  store double %p_add12.i.1.1252, ptr %gep72.1.1241, align 8, !alias.scope !407, !noalias !410
  %polly.indvar_next53.1.1253 = add nuw nsw i64 %polly.indvar52.1.1246.reg2mem.0.load, 1
  %exitcond.1.1254.not = icmp eq i64 %polly.indvar_next53.1.1253, 32
  br i1 %exitcond.1.1254.not, label %polly.loop_exit51.1.1258, label %polly.stmt.for.body6.i.1.1255.polly.stmt.for.body6.i.1.1255_crit_edge

polly.stmt.for.body6.i.1.1255.polly.stmt.for.body6.i.1.1255_crit_edge: ; preds = %polly.stmt.for.body6.i.1.1255
  store i64 %polly.indvar_next53.1.1253, ptr %polly.indvar52.1.1246.reg2mem, align 8
  store double %p_add12.i.1.1252, ptr %p_add12.i70.1.1245.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1.1255

polly.loop_exit51.1.1258:                         ; preds = %polly.stmt.for.body6.i.1.1255
  %polly.indvar_next47.1.1256 = add nuw nsw i64 %polly.indvar46.1.1240.reg2mem373.0.load, 1
  %exitcond179.1.1257.not = icmp eq i64 %polly.indvar_next47.1.1256, 32
  br i1 %exitcond179.1.1257.not, label %polly.loop_exit45.1.1261, label %polly.loop_exit51.1.1258.polly.loop_preheader50.1.1244_crit_edge

polly.loop_exit51.1.1258.polly.loop_preheader50.1.1244_crit_edge: ; preds = %polly.loop_exit51.1.1258
  store i64 %polly.indvar_next47.1.1256, ptr %polly.indvar46.1.1240.reg2mem373, align 8
  br label %polly.loop_preheader50.1.1244

polly.loop_exit45.1.1261:                         ; preds = %polly.loop_exit51.1.1258
  %polly.indvar_next41.1.1259 = add nuw nsw i64 %polly.indvar40.1.1236.reg2mem375.0.load, 1
  %exitcond180.1.1260.not = icmp eq i64 %polly.indvar_next41.1.1259, 32
  br i1 %exitcond180.1.1260.not, label %polly.loop_exit39.1.1262, label %polly.loop_exit45.1.1261.polly.loop_preheader44.1.1239_crit_edge

polly.loop_exit45.1.1261.polly.loop_preheader44.1.1239_crit_edge: ; preds = %polly.loop_exit45.1.1261
  store i64 %polly.indvar_next41.1.1259, ptr %polly.indvar40.1.1236.reg2mem375, align 8
  br label %polly.loop_preheader44.1.1239

polly.loop_exit39.1.1262:                         ; preds = %polly.loop_exit45.1.1261
  %gep76.1.1 = getelementptr i8, ptr %vargs, i64 82176
  store i64 0, ptr %polly.indvar40.1181.1.reg2mem371, align 8
  br label %polly.loop_preheader44.1184.1

polly.loop_preheader44.1184.1:                    ; preds = %polly.loop_exit45.1206.1.polly.loop_preheader44.1184.1_crit_edge, %polly.loop_exit39.1.1262
  %polly.indvar40.1181.1.reg2mem371.0.load = load i64, ptr %polly.indvar40.1181.1.reg2mem371, align 8
  %.idx63.1182.1 = shl i64 %polly.indvar40.1181.1.reg2mem371.0.load, 9
  %gep74.1183.1 = getelementptr i8, ptr %gep76.1.1, i64 %.idx63.1182.1
  %24 = getelementptr i8, ptr %14, i64 %.idx63.1182.1
  store i64 0, ptr %polly.indvar46.1185.1.reg2mem369, align 8
  br label %polly.loop_preheader50.1189.1

polly.loop_preheader50.1189.1:                    ; preds = %polly.loop_exit51.1203.1.polly.loop_preheader50.1189.1_crit_edge, %polly.loop_preheader44.1184.1
  %polly.indvar46.1185.1.reg2mem369.0.load = load i64, ptr %polly.indvar46.1185.1.reg2mem369, align 8
  %gep72.1186.1 = getelementptr double, ptr %gep74.1183.1, i64 %polly.indvar46.1185.1.reg2mem369.0.load
  %25 = shl i64 %polly.indvar46.1185.1.reg2mem369.0.load, 3
  %gep267 = getelementptr i8, ptr %invariant.gep264, i64 %25
  %polly.access.vargs55.promoted.1188.1 = load double, ptr %gep72.1186.1, align 8
  store i64 0, ptr %polly.indvar52.1191.1.reg2mem, align 8
  store double %polly.access.vargs55.promoted.1188.1, ptr %p_add12.i70.1190.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1200.1

polly.stmt.for.body6.i.1200.1:                    ; preds = %polly.stmt.for.body6.i.1200.1.polly.stmt.for.body6.i.1200.1_crit_edge, %polly.loop_preheader50.1189.1
  %p_add12.i70.1190.1.reg2mem.0.p_add12.i70.1190.1.reload = load double, ptr %p_add12.i70.1190.1.reg2mem, align 8
  %polly.indvar52.1191.1.reg2mem.0.load = load i64, ptr %polly.indvar52.1191.1.reg2mem, align 8
  %26 = shl i64 %polly.indvar52.1191.1.reg2mem.0.load, 3
  %scevgep.1192.1 = getelementptr i8, ptr %24, i64 %26
  %_p_scalar_.1193.1 = load double, ptr %scevgep.1192.1, align 8, !alias.scope !407, !noalias !410
  %27 = shl i64 %polly.indvar52.1191.1.reg2mem.0.load, 9
  %gep69.1194.1 = getelementptr i8, ptr %gep267, i64 %27
  %_p_scalar_58.1195.1 = load double, ptr %gep69.1194.1, align 8, !alias.scope !407, !noalias !410
  %p_mul11.i.1196.1 = fmul double %_p_scalar_.1193.1, %_p_scalar_58.1195.1, !dbg !411
  %p_add12.i.1197.1 = fadd double %p_add12.i70.1190.1.reg2mem.0.p_add12.i70.1190.1.reload, %p_mul11.i.1196.1, !dbg !412
  store double %p_add12.i.1197.1, ptr %gep72.1186.1, align 8, !alias.scope !407, !noalias !410
  %polly.indvar_next53.1198.1 = add nuw nsw i64 %polly.indvar52.1191.1.reg2mem.0.load, 1
  %exitcond.1199.1.not = icmp eq i64 %polly.indvar_next53.1198.1, 32
  br i1 %exitcond.1199.1.not, label %polly.loop_exit51.1203.1, label %polly.stmt.for.body6.i.1200.1.polly.stmt.for.body6.i.1200.1_crit_edge

polly.stmt.for.body6.i.1200.1.polly.stmt.for.body6.i.1200.1_crit_edge: ; preds = %polly.stmt.for.body6.i.1200.1
  store i64 %polly.indvar_next53.1198.1, ptr %polly.indvar52.1191.1.reg2mem, align 8
  store double %p_add12.i.1197.1, ptr %p_add12.i70.1190.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1200.1

polly.loop_exit51.1203.1:                         ; preds = %polly.stmt.for.body6.i.1200.1
  %polly.indvar_next47.1201.1 = add nuw nsw i64 %polly.indvar46.1185.1.reg2mem369.0.load, 1
  %exitcond179.1202.1.not = icmp eq i64 %polly.indvar_next47.1201.1, 32
  br i1 %exitcond179.1202.1.not, label %polly.loop_exit45.1206.1, label %polly.loop_exit51.1203.1.polly.loop_preheader50.1189.1_crit_edge

polly.loop_exit51.1203.1.polly.loop_preheader50.1189.1_crit_edge: ; preds = %polly.loop_exit51.1203.1
  store i64 %polly.indvar_next47.1201.1, ptr %polly.indvar46.1185.1.reg2mem369, align 8
  br label %polly.loop_preheader50.1189.1

polly.loop_exit45.1206.1:                         ; preds = %polly.loop_exit51.1203.1
  %polly.indvar_next41.1204.1 = add nuw nsw i64 %polly.indvar40.1181.1.reg2mem371.0.load, 1
  %exitcond180.1205.1.not = icmp eq i64 %polly.indvar_next41.1204.1, 32
  br i1 %exitcond180.1205.1.not, label %polly.loop_exit39.1207.1, label %polly.loop_exit45.1206.1.polly.loop_preheader44.1184.1_crit_edge

polly.loop_exit45.1206.1.polly.loop_preheader44.1184.1_crit_edge: ; preds = %polly.loop_exit45.1206.1
  store i64 %polly.indvar_next41.1204.1, ptr %polly.indvar40.1181.1.reg2mem371, align 8
  br label %polly.loop_preheader44.1184.1

polly.loop_exit39.1207.1:                         ; preds = %polly.loop_exit45.1206.1
  store i64 0, ptr %polly.indvar40.1.1.1.reg2mem367, align 8
  br label %polly.loop_preheader44.1.1.1

polly.loop_preheader44.1.1.1:                     ; preds = %polly.loop_exit45.1.1.1.polly.loop_preheader44.1.1.1_crit_edge, %polly.loop_exit39.1207.1
  %polly.indvar40.1.1.1.reg2mem367.0.load = load i64, ptr %polly.indvar40.1.1.1.reg2mem367, align 8
  %.idx63.1.1.1 = shl i64 %polly.indvar40.1.1.1.reg2mem367.0.load, 9
  %gep74.1.1.1 = getelementptr i8, ptr %gep76.1.1, i64 %.idx63.1.1.1
  %.reg2mem319.0..reload320 = load ptr, ptr %.reg2mem319, align 8
  %28 = getelementptr i8, ptr %.reg2mem319.0..reload320, i64 %.idx63.1.1.1
  store i64 0, ptr %polly.indvar46.1.1.1.reg2mem365, align 8
  br label %polly.loop_preheader50.1.1.1

polly.loop_preheader50.1.1.1:                     ; preds = %polly.loop_exit51.1.1.1.polly.loop_preheader50.1.1.1_crit_edge, %polly.loop_preheader44.1.1.1
  %polly.indvar46.1.1.1.reg2mem365.0.load = load i64, ptr %polly.indvar46.1.1.1.reg2mem365, align 8
  %gep72.1.1.1 = getelementptr double, ptr %gep74.1.1.1, i64 %polly.indvar46.1.1.1.reg2mem365.0.load
  %29 = shl i64 %polly.indvar46.1.1.1.reg2mem365.0.load, 3
  %gep269 = getelementptr i8, ptr %invariant.gep264, i64 %29
  %polly.access.vargs55.promoted.1.1.1 = load double, ptr %gep72.1.1.1, align 8
  store i64 0, ptr %polly.indvar52.1.1.1.reg2mem, align 8
  store double %polly.access.vargs55.promoted.1.1.1, ptr %p_add12.i70.1.1.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1.1.1

polly.stmt.for.body6.i.1.1.1:                     ; preds = %polly.stmt.for.body6.i.1.1.1.polly.stmt.for.body6.i.1.1.1_crit_edge, %polly.loop_preheader50.1.1.1
  %p_add12.i70.1.1.1.reg2mem.0.p_add12.i70.1.1.1.reload = load double, ptr %p_add12.i70.1.1.1.reg2mem, align 8
  %polly.indvar52.1.1.1.reg2mem.0.load = load i64, ptr %polly.indvar52.1.1.1.reg2mem, align 8
  %30 = add nuw nsw i64 %polly.indvar52.1.1.1.reg2mem.0.load, 32
  %31 = shl i64 %30, 3
  %scevgep.1.1.1 = getelementptr i8, ptr %28, i64 %31
  %_p_scalar_.1.1.1 = load double, ptr %scevgep.1.1.1, align 8, !alias.scope !407, !noalias !410
  %32 = shl i64 %30, 9
  %gep69.1.1.1 = getelementptr i8, ptr %gep269, i64 %32
  %_p_scalar_58.1.1.1 = load double, ptr %gep69.1.1.1, align 8, !alias.scope !407, !noalias !410
  %p_mul11.i.1.1.1 = fmul double %_p_scalar_.1.1.1, %_p_scalar_58.1.1.1, !dbg !411
  %p_add12.i.1.1.1 = fadd double %p_add12.i70.1.1.1.reg2mem.0.p_add12.i70.1.1.1.reload, %p_mul11.i.1.1.1, !dbg !412
  store double %p_add12.i.1.1.1, ptr %gep72.1.1.1, align 8, !alias.scope !407, !noalias !410
  %polly.indvar_next53.1.1.1 = add nuw nsw i64 %polly.indvar52.1.1.1.reg2mem.0.load, 1
  %exitcond.1.1.1.not = icmp eq i64 %polly.indvar_next53.1.1.1, 32
  br i1 %exitcond.1.1.1.not, label %polly.loop_exit51.1.1.1, label %polly.stmt.for.body6.i.1.1.1.polly.stmt.for.body6.i.1.1.1_crit_edge

polly.stmt.for.body6.i.1.1.1.polly.stmt.for.body6.i.1.1.1_crit_edge: ; preds = %polly.stmt.for.body6.i.1.1.1
  store i64 %polly.indvar_next53.1.1.1, ptr %polly.indvar52.1.1.1.reg2mem, align 8
  store double %p_add12.i.1.1.1, ptr %p_add12.i70.1.1.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.1.1.1

polly.loop_exit51.1.1.1:                          ; preds = %polly.stmt.for.body6.i.1.1.1
  %polly.indvar_next47.1.1.1 = add nuw nsw i64 %polly.indvar46.1.1.1.reg2mem365.0.load, 1
  %exitcond179.1.1.1.not = icmp eq i64 %polly.indvar_next47.1.1.1, 32
  br i1 %exitcond179.1.1.1.not, label %polly.loop_exit45.1.1.1, label %polly.loop_exit51.1.1.1.polly.loop_preheader50.1.1.1_crit_edge

polly.loop_exit51.1.1.1.polly.loop_preheader50.1.1.1_crit_edge: ; preds = %polly.loop_exit51.1.1.1
  store i64 %polly.indvar_next47.1.1.1, ptr %polly.indvar46.1.1.1.reg2mem365, align 8
  br label %polly.loop_preheader50.1.1.1

polly.loop_exit45.1.1.1:                          ; preds = %polly.loop_exit51.1.1.1
  %polly.indvar_next41.1.1.1 = add nuw nsw i64 %polly.indvar40.1.1.1.reg2mem367.0.load, 1
  %exitcond180.1.1.1.not = icmp eq i64 %polly.indvar_next41.1.1.1, 32
  br i1 %exitcond180.1.1.1.not, label %polly.loop_exit39.1.1.1, label %polly.loop_exit45.1.1.1.polly.loop_preheader44.1.1.1_crit_edge

polly.loop_exit45.1.1.1.polly.loop_preheader44.1.1.1_crit_edge: ; preds = %polly.loop_exit45.1.1.1
  store i64 %polly.indvar_next41.1.1.1, ptr %polly.indvar40.1.1.1.reg2mem367, align 8
  br label %polly.loop_preheader44.1.1.1

polly.loop_exit39.1.1.1:                          ; preds = %polly.loop_exit45.1.1.1
  ret void, !dbg !413

polly.loop_exit45:                                ; preds = %polly.loop_exit51
  %polly.indvar_next41 = add nuw nsw i64 %polly.indvar40.reg2mem363.0.load, 1
  store i64 %polly.indvar_next41, ptr %polly.indvar_next41.reg2mem, align 8
  %exitcond180.not = icmp eq i64 %polly.indvar_next41, 32
  br i1 %exitcond180.not, label %polly.loop_exit45.polly.loop_preheader44.1_crit_edge, label %polly.loop_exit45.polly.loop_preheader44_crit_edge

polly.loop_exit45.polly.loop_preheader44_crit_edge: ; preds = %polly.loop_exit45
  store i64 %polly.indvar_next41, ptr %polly.indvar40.reg2mem363, align 8
  br label %polly.loop_preheader44

polly.loop_exit45.polly.loop_preheader44.1_crit_edge: ; preds = %polly.loop_exit45
  store i64 0, ptr %polly.indvar40.1.reg2mem391, align 8
  br label %polly.loop_preheader44.1

polly.loop_exit51:                                ; preds = %polly.stmt.for.body6.i
  %polly.indvar_next47 = add nuw nsw i64 %polly.indvar46.reg2mem361.0.load, 1
  store i64 %polly.indvar_next47, ptr %polly.indvar_next47.reg2mem, align 8
  %exitcond179.not = icmp eq i64 %polly.indvar_next47, 32
  br i1 %exitcond179.not, label %polly.loop_exit45, label %polly.loop_exit51.polly.loop_preheader50_crit_edge

polly.loop_exit51.polly.loop_preheader50_crit_edge: ; preds = %polly.loop_exit51
  store i64 %polly.indvar_next47, ptr %polly.indvar46.reg2mem361, align 8
  br label %polly.loop_preheader50

polly.loop_preheader44:                           ; preds = %polly.loop_exit45.polly.loop_preheader44_crit_edge, %polly.loop_preheader
  %polly.indvar40.reg2mem363.0.load = load i64, ptr %polly.indvar40.reg2mem363, align 8
  store i64 %polly.indvar40.reg2mem363.0.load, ptr %polly.indvar40.reg2mem, align 8
  %.idx63 = shl i64 %polly.indvar40.reg2mem363.0.load, 9
  %gep74 = getelementptr i8, ptr %scevgep79, i64 %.idx63
  store ptr %gep74, ptr %gep74.reg2mem, align 8
  %33 = getelementptr i8, ptr %vargs, i64 %.idx63
  store ptr %33, ptr %.reg2mem, align 8
  store i64 0, ptr %polly.indvar46.reg2mem361, align 8
  br label %polly.loop_preheader50

polly.stmt.for.body6.i:                           ; preds = %polly.stmt.for.body6.i.polly.stmt.for.body6.i_crit_edge, %polly.loop_preheader50
  %p_add12.i70.reg2mem.0.p_add12.i70.reload = load double, ptr %p_add12.i70.reg2mem, align 8
  %polly.indvar52.reg2mem.0.load = load i64, ptr %polly.indvar52.reg2mem, align 8
  %34 = shl i64 %polly.indvar52.reg2mem.0.load, 3
  %scevgep = getelementptr i8, ptr %33, i64 %34
  %_p_scalar_ = load double, ptr %scevgep, align 8, !alias.scope !407, !noalias !410
  %35 = shl i64 %polly.indvar52.reg2mem.0.load, 9
  %gep69 = getelementptr i8, ptr %invariant.gep, i64 %35
  %_p_scalar_58 = load double, ptr %gep69, align 8, !alias.scope !407, !noalias !410
  %p_mul11.i = fmul double %_p_scalar_, %_p_scalar_58, !dbg !411
  %p_add12.i = fadd double %p_add12.i70.reg2mem.0.p_add12.i70.reload, %p_mul11.i, !dbg !412
  store double %p_add12.i, ptr %p_add12.i.reg2mem, align 8
  store double %p_add12.i, ptr %gep72, align 8, !alias.scope !407, !noalias !410
  %polly.indvar_next53 = add nuw nsw i64 %polly.indvar52.reg2mem.0.load, 1
  store i64 %polly.indvar_next53, ptr %polly.indvar_next53.reg2mem, align 8
  %exitcond.not = icmp eq i64 %polly.indvar_next53, 32
  br i1 %exitcond.not, label %polly.loop_exit51, label %polly.stmt.for.body6.i.polly.stmt.for.body6.i_crit_edge

polly.stmt.for.body6.i.polly.stmt.for.body6.i_crit_edge: ; preds = %polly.stmt.for.body6.i
  store i64 %polly.indvar_next53, ptr %polly.indvar52.reg2mem, align 8
  store double %p_add12.i, ptr %p_add12.i70.reg2mem, align 8
  br label %polly.stmt.for.body6.i

polly.loop_preheader50:                           ; preds = %polly.loop_exit51.polly.loop_preheader50_crit_edge, %polly.loop_preheader44
  %polly.indvar46.reg2mem361.0.load = load i64, ptr %polly.indvar46.reg2mem361, align 8
  store i64 %polly.indvar46.reg2mem361.0.load, ptr %polly.indvar46.reg2mem, align 8
  %gep72 = getelementptr double, ptr %gep74, i64 %polly.indvar46.reg2mem361.0.load
  store ptr %gep72, ptr %gep72.reg2mem, align 8
  %36 = shl i64 %polly.indvar46.reg2mem361.0.load, 3
  %invariant.gep = getelementptr i8, ptr %m2, i64 %36
  store ptr %invariant.gep, ptr %invariant.gep.reg2mem, align 8
  %polly.access.vargs55.promoted = load double, ptr %gep72, align 8
  store double %polly.access.vargs55.promoted, ptr %polly.access.vargs55.promoted.reg2mem, align 8
  store i64 0, ptr %polly.indvar52.reg2mem, align 8
  store double %polly.access.vargs55.promoted, ptr %p_add12.i70.reg2mem, align 8
  br label %polly.stmt.for.body6.i
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !414 {
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
    #dbg_value(i32 %fd, !418, !DIExpression(), !423)
    #dbg_value(ptr %vdata, !419, !DIExpression(), !423)
    #dbg_value(ptr %vdata, !420, !DIExpression(), !423)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(98304) %vdata, i8 0, i64 98304, i1 false), !dbg !424
  %call = tail call ptr @readfile(i32 noundef signext %fd) #19, !dbg !425
    #dbg_value(ptr %call, !421, !DIExpression(), !423)
    #dbg_value(ptr %call, !426, !DIExpression(), !433)
    #dbg_value(i32 1, !431, !DIExpression(), !433)
    #dbg_value(i32 0, !432, !DIExpression(), !433)
  store ptr %call, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 0, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem72.0.load, !432, !DIExpression(), !433)
    #dbg_value(ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, !426, !DIExpression(), !433)
  %i.041.i.reg2mem72.0.load = load i32, ptr %i.041.i.reg2mem72, align 4
  %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71 = load ptr, ptr %s.addr.040.i.reg2mem70, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, align 1, !dbg !435, !tbaa !436
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !437

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !437

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !437

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !438
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !438, !tbaa !436
  %cmp13.i = icmp eq i8 %1, 37, !dbg !441
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !442

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !442

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 2, !dbg !443
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !443, !tbaa !436
  %cmp18.i = icmp eq i8 %2, 10, !dbg !444
  %inc.i = zext i1 %cmp18.i to i32, !dbg !445
  %spec.select.i = add nsw i32 %i.041.i.reg2mem72.0.load, %inc.i, !dbg !445
  store i32 %spec.select.i, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !445

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem68.0.load, !432, !DIExpression(), !433)
  %i.1.i.reg2mem68.0.load = load i32, ptr %i.1.i.reg2mem68, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !446
    #dbg_value(ptr %incdec.ptr.i, !426, !DIExpression(), !433)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem68.0.load, 1, !dbg !447
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !448, !llvm.loop !449

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 %i.1.i.reg2mem68.0.load, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i, !dbg !448

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !451, !tbaa !436
  %3 = icmp eq i8 %.pre.i, 0, !dbg !453
  %4 = select i1 %3, i64 0, i64 2, !dbg !454
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !448

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !454
    #dbg_value(ptr %spec.select38.i, !422, !DIExpression(), !423)
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 4096) #19, !dbg !455
    #dbg_value(ptr %call, !426, !DIExpression(), !456)
    #dbg_value(i32 2, !431, !DIExpression(), !456)
    #dbg_value(i32 0, !432, !DIExpression(), !456)
  store ptr %call, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 0, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem66.0.load, !432, !DIExpression(), !456)
    #dbg_value(ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, !426, !DIExpression(), !456)
  %i.041.i2.reg2mem66.0.load = load i32, ptr %i.041.i2.reg2mem66, align 4
  %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65 = load ptr, ptr %s.addr.040.i3.reg2mem64, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, align 1, !dbg !458, !tbaa !436
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !459

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !459

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !459

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !460
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !460, !tbaa !436
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !461
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !462

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !462

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 2, !dbg !463
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !463, !tbaa !436
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !464
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !465
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem66.0.load, %inc.i19, !dbg !465
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !465

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem62.0.load, !432, !DIExpression(), !456)
  %i.1.i8.reg2mem62.0.load = load i32, ptr %i.1.i8.reg2mem62, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !466
    #dbg_value(ptr %incdec.ptr.i9, !426, !DIExpression(), !456)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem62.0.load, 2, !dbg !467
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !468, !llvm.loop !469

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 %i.1.i8.reg2mem62.0.load, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1, !dbg !468

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !471, !tbaa !436
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !472
  %9 = select i1 %8, i64 0, i64 2, !dbg !473
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !468

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !473
    #dbg_value(ptr %spec.select38.i15, !422, !DIExpression(), !423)
  %m2 = getelementptr inbounds i8, ptr %vdata, i64 32768, !dbg !474
  %call5 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %m2, i32 noundef signext 4096) #19, !dbg !475
  tail call void @free(ptr noundef %call) #19, !dbg !476
  ret void, !dbg !477
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !478 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !480 {
entry.split:
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !482, !DIExpression(), !485)
    #dbg_value(ptr %vdata, !483, !DIExpression(), !485)
    #dbg_value(ptr %vdata, !484, !DIExpression(), !485)
    #dbg_value(i32 %fd, !486, !DIExpression(), !491)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !493
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !493

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !493
  unreachable, !dbg !493

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !496
    #dbg_value(i32 %fd, !497, !DIExpression(), !505)
    #dbg_value(ptr %vdata, !502, !DIExpression(), !505)
    #dbg_value(i32 4096, !503, !DIExpression(), !505)
    #dbg_value(i32 0, !504, !DIExpression(), !505)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !507

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !504, !DIExpression(), !505)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !509
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !509, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !509
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !512
    #dbg_value(i64 %indvars.iv.next.i, !504, !DIExpression(), !505)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 4096, !dbg !512
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !507, !llvm.loop !513

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !507

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !486, !DIExpression(), !514)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !516
  %m2 = getelementptr inbounds i8, ptr %vdata, i64 32768, !dbg !517
    #dbg_value(i32 %fd, !497, !DIExpression(), !518)
    #dbg_value(ptr %m2, !502, !DIExpression(), !518)
    #dbg_value(i32 4096, !503, !DIExpression(), !518)
    #dbg_value(i32 0, !504, !DIExpression(), !518)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !520

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !504, !DIExpression(), !518)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds double, ptr %m2, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !521
  %1 = load double, ptr %arrayidx.i11, align 8, !dbg !521, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %1), !dbg !521
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !522
    #dbg_value(i64 %indvars.iv.next.i12, !504, !DIExpression(), !518)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 4096, !dbg !522
  br i1 %exitcond.not.i13, label %write_double_array.exit14, label %for.body.i9.for.body.i9_crit_edge, !dbg !520, !llvm.loop !523

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !520

write_double_array.exit14:                        ; preds = %for.body.i9
  ret void, !dbg !524
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !525 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !527, !DIExpression(), !532)
    #dbg_value(ptr %vdata, !528, !DIExpression(), !532)
    #dbg_value(ptr %vdata, !529, !DIExpression(), !532)
  %call = tail call ptr @readfile(i32 noundef signext %fd) #19, !dbg !533
    #dbg_value(ptr %call, !530, !DIExpression(), !532)
    #dbg_value(ptr %call, !426, !DIExpression(), !534)
    #dbg_value(i32 1, !431, !DIExpression(), !534)
    #dbg_value(i32 0, !432, !DIExpression(), !534)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !432, !DIExpression(), !534)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !426, !DIExpression(), !534)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !536, !tbaa !436
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !537

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !537

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !537

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !538
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !538, !tbaa !436
  %cmp13.i = icmp eq i8 %1, 37, !dbg !539
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !540

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !540

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !541
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !541, !tbaa !436
  %cmp18.i = icmp eq i8 %2, 10, !dbg !542
  %inc.i = zext i1 %cmp18.i to i32, !dbg !543
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !543
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !543

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !432, !DIExpression(), !534)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !544
    #dbg_value(ptr %incdec.ptr.i, !426, !DIExpression(), !534)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !545
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !546, !llvm.loop !547

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !546

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !549, !tbaa !436
  %3 = icmp eq i8 %.pre.i, 0, !dbg !550
  %4 = select i1 %3, i64 0, i64 2, !dbg !551
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !546

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !551
    #dbg_value(ptr %spec.select38.i, !531, !DIExpression(), !532)
  %prod = getelementptr inbounds i8, ptr %vdata, i64 65536, !dbg !552
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %prod, i32 noundef signext 4096) #19, !dbg !553
  tail call void @free(ptr noundef %call) #19, !dbg !554
  ret void, !dbg !555
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !556 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !558, !DIExpression(), !561)
    #dbg_value(ptr %vdata, !559, !DIExpression(), !561)
    #dbg_value(ptr %vdata, !560, !DIExpression(), !561)
    #dbg_value(i32 %fd, !486, !DIExpression(), !562)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !564
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !564

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !564
  unreachable, !dbg !564

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !565
  %prod = getelementptr inbounds i8, ptr %vdata, i64 65536, !dbg !566
    #dbg_value(i32 %fd, !497, !DIExpression(), !567)
    #dbg_value(ptr %prod, !502, !DIExpression(), !567)
    #dbg_value(i32 4096, !503, !DIExpression(), !567)
    #dbg_value(i32 0, !504, !DIExpression(), !567)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !569

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !504, !DIExpression(), !567)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %prod, i64 %indvars.iv.i.reg2mem.0.load, !dbg !570
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !570, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !570
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !571
    #dbg_value(i64 %indvars.iv.next.i, !504, !DIExpression(), !567)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 4096, !dbg !571
  br i1 %exitcond.not.i, label %write_double_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !569, !llvm.loop !572

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !569

write_double_array.exit:                          ; preds = %for.body.i
  ret void, !dbg !573
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #4 !dbg !574 {
entry.split:
  %has_errors.123.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
  %has_errors.025.reg2mem6 = alloca i32, align 4
  %indvars.iv27.reg2mem8 = alloca i64, align 8
    #dbg_value(ptr %vdata, !578, !DIExpression(), !586)
    #dbg_value(ptr %vref, !579, !DIExpression(), !586)
    #dbg_value(ptr %vdata, !580, !DIExpression(), !586)
    #dbg_value(ptr %vref, !581, !DIExpression(), !586)
    #dbg_value(i32 0, !582, !DIExpression(), !586)
    #dbg_value(i32 0, !583, !DIExpression(), !586)
  store i32 0, ptr %has_errors.025.reg2mem6, align 4
  store i64 0, ptr %indvars.iv27.reg2mem8, align 8
  br label %for.cond1.preheader, !dbg !587

for.cond1.preheader:                              ; preds = %for.inc11.for.cond1.preheader_crit_edge, %entry.split
    #dbg_value(i32 %has_errors.025.reg2mem6.0.load, !582, !DIExpression(), !586)
    #dbg_value(i64 %indvars.iv27.reg2mem8.0.load, !583, !DIExpression(), !586)
  %indvars.iv27.reg2mem8.0.load = load i64, ptr %indvars.iv27.reg2mem8, align 8
  %has_errors.025.reg2mem6.0.load = load i32, ptr %has_errors.025.reg2mem6, align 4
  %0 = shl nuw nsw i64 %indvars.iv27.reg2mem8.0.load, 6
    #dbg_value(i32 0, !584, !DIExpression(), !586)
  store i32 %has_errors.025.reg2mem6.0.load, ptr %has_errors.123.reg2mem, align 4
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body3, !dbg !589

for.body3:                                        ; preds = %for.body3.for.body3_crit_edge, %for.cond1.preheader
    #dbg_value(i32 %has_errors.123.reg2mem.0.load, !582, !DIExpression(), !586)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !584, !DIExpression(), !586)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %has_errors.123.reg2mem.0.load = load i32, ptr %has_errors.123.reg2mem, align 4
  %1 = add nuw nsw i64 %indvars.iv.reg2mem.0.load, %0, !dbg !593
  %arrayidx = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 2, i64 %1, !dbg !596
  %2 = load double, ptr %arrayidx, align 8, !dbg !596, !tbaa !360
  %arrayidx8 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 2, i64 %1, !dbg !597
  %3 = load double, ptr %arrayidx8, align 8, !dbg !597, !tbaa !360
  %sub = fsub double %2, %3, !dbg !598
    #dbg_value(double %sub, !585, !DIExpression(), !586)
  %4 = tail call double @llvm.fabs.f64(double %sub), !dbg !599
  %5 = fcmp ogt double %4, 0x3EB0C6F7A0B5ED8D, !dbg !599
  %lor.ext = zext i1 %5 to i32, !dbg !599
  %or = or i32 %has_errors.123.reg2mem.0.load, %lor.ext, !dbg !600
    #dbg_value(i32 %or, !582, !DIExpression(), !586)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !601
    #dbg_value(i64 %indvars.iv.next, !584, !DIExpression(), !586)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 64, !dbg !602
  br i1 %exitcond.not, label %for.inc11, label %for.body3.for.body3_crit_edge, !dbg !589, !llvm.loop !603

for.body3.for.body3_crit_edge:                    ; preds = %for.body3
  store i32 %or, ptr %has_errors.123.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body3, !dbg !589

for.inc11:                                        ; preds = %for.body3
  %indvars.iv.next28 = add nuw nsw i64 %indvars.iv27.reg2mem8.0.load, 1, !dbg !605
    #dbg_value(i32 %or, !582, !DIExpression(), !586)
    #dbg_value(i64 %indvars.iv.next28, !583, !DIExpression(), !586)
  %exitcond30.not = icmp eq i64 %indvars.iv.next28, 64, !dbg !606
  br i1 %exitcond30.not, label %for.end13, label %for.inc11.for.cond1.preheader_crit_edge, !dbg !587, !llvm.loop !607

for.inc11.for.cond1.preheader_crit_edge:          ; preds = %for.inc11
  store i32 %or, ptr %has_errors.025.reg2mem6, align 4
  store i64 %indvars.iv.next28, ptr %indvars.iv27.reg2mem8, align 8
  br label %for.cond1.preheader, !dbg !587

for.end13:                                        ; preds = %for.inc11
  %tobool.not = icmp eq i32 %or, 0, !dbg !609
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !609
  ret i32 %lnot.ext, !dbg !610
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !611 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !661
    #dbg_assign(i1 undef, !617, !DIExpression(), !661, ptr %s, !DIExpression(), !662)
    #dbg_value(i32 %fd, !615, !DIExpression(), !662)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #19, !dbg !663
  %cmp = icmp sgt i32 %fd, 1, !dbg !664
  br i1 %cmp, label %if.end, label %if.else, !dbg !664

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !664
  unreachable, !dbg !664

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #19, !dbg !667
  %cmp1 = icmp eq i32 %call, 0, !dbg !667
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !667

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !667
  unreachable, !dbg !667

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !670
  %0 = load i64, ptr %st_size, align 8, !dbg !670
    #dbg_value(i64 %0, !654, !DIExpression(), !662)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !671
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !671

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !671
  unreachable, !dbg !671

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !674
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #21, !dbg !675
    #dbg_value(ptr %call11, !616, !DIExpression(), !662)
    #dbg_value(i64 0, !657, !DIExpression(), !662)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !676

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !677
    #dbg_value(i64 %add19, !657, !DIExpression(), !662)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !679
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !676, !llvm.loop !680

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !676

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !657, !DIExpression(), !662)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !682
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !683
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #19, !dbg !684
    #dbg_value(i64 %call13, !660, !DIExpression(), !662)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !685
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !657, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !662)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !685

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !685
  unreachable, !dbg !685

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !688
  store i8 0, ptr %arrayidx20, align 1, !dbg !689, !tbaa !436
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #19, !dbg !690
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #19, !dbg !691
  ret ptr %call11, !dbg !692
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: noreturn nounwind
declare !dbg !693 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare !dbg !698 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !703 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #8

; Function Attrs: nofree
declare !dbg !708 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #9

declare !dbg !712 signext i32 @close(i32 noundef signext) local_unnamed_addr #10

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #1 !dbg !427 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !426, !DIExpression(), !713)
    #dbg_value(i32 %n, !431, !DIExpression(), !713)
    #dbg_value(i32 0, !432, !DIExpression(), !713)
  %cmp = icmp sgt i32 %n, -1, !dbg !714
  br i1 %cmp, label %if.end, label %if.else, !dbg !714

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #20, !dbg !714
  unreachable, !dbg !714

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !717
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !719

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !719

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !719

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !432, !DIExpression(), !713)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !426, !DIExpression(), !713)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !720, !tbaa !436
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !721

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !721

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !721

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !722
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !722, !tbaa !436
  %cmp13 = icmp eq i8 %1, 37, !dbg !723
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !724

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !724

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !725
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !725, !tbaa !436
  %cmp18 = icmp eq i8 %2, 10, !dbg !726
  %inc = zext i1 %cmp18 to i32, !dbg !727
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !727
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !727

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !432, !DIExpression(), !713)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !728
    #dbg_value(ptr %incdec.ptr, !426, !DIExpression(), !713)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !729
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !730, !llvm.loop !731

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !730

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !733, !tbaa !436
  %3 = icmp eq i8 %.pre, 0, !dbg !734
  %4 = select i1 %3, i64 0, i64 2, !dbg !735
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !730

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !735
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !735

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !736
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !737 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !741, !DIExpression(), !745)
    #dbg_value(ptr %arr, !742, !DIExpression(), !745)
    #dbg_value(i32 %n, !743, !DIExpression(), !745)
  %cmp.not = icmp eq ptr %s, null, !dbg !746
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !746

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #20, !dbg !746
  unreachable, !dbg !746

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !749
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !751

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !752
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !754
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !754

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !744, !DIExpression(), !745)
  %conv404 = zext nneg i32 %n to i64, !dbg !755
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !756
  br label %if.end46, !dbg !757

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !744, !DIExpression(), !745)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !758
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !759

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !759

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !760
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !761
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !761
  %cmp9.not = icmp eq i8 %0, 0, !dbg !762
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !763

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !763

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !764
  %1 = load i8, ptr %gep, align 1, !dbg !764
  %cmp16.not = icmp eq i8 %1, 0, !dbg !765
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !766

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !766

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !767
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !768
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !768
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !768, !llvm.loop !769

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !768

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !755

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !755

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !755

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !755
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !744, !DIExpression(), !745)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !756
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !771
  store i8 0, ptr %arrayidx45, align 1, !dbg !773, !tbaa !436
  br label %if.end46, !dbg !771

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !774
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #11

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !775 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !787
    #dbg_assign(i1 undef, !784, !DIExpression(), !787, ptr %endptr, !DIExpression(), !788)
    #dbg_value(ptr %s, !780, !DIExpression(), !788)
    #dbg_value(ptr %arr, !781, !DIExpression(), !788)
    #dbg_value(i32 %n, !782, !DIExpression(), !788)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !789
    #dbg_value(i32 0, !785, !DIExpression(), !788)
  %cmp.not = icmp eq ptr %s, null, !dbg !790
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !790

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #20, !dbg !790
  unreachable, !dbg !790

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !789
    #dbg_value(ptr %call, !783, !DIExpression(), !788)
    #dbg_value(i32 0, !785, !DIExpression(), !788)
  %cmp130 = icmp ne ptr %call, null, !dbg !789
  %cmp231 = icmp sgt i32 %n, 0, !dbg !789
  %0 = and i1 %cmp231, %cmp130, !dbg !789
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !789

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !789

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !789
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !789

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !783, !DIExpression(), !788)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !785, !DIExpression(), !788)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !793, !tbaa !795, !DIAssignID !797
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !784, !DIExpression(), !797, ptr %endptr, !DIExpression(), !788)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !793
  %conv = trunc i64 %call3 to i8, !dbg !793
    #dbg_value(i8 %conv, !786, !DIExpression(), !788)
  %2 = load ptr, ptr %endptr, align 8, !dbg !798, !tbaa !795
  %3 = load i8, ptr %2, align 1, !dbg !798, !tbaa !436
  %cmp5.not = icmp eq i8 %3, 0, !dbg !798
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !793

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !793

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !800, !tbaa !795
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !800
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !800
  br label %if.end9, !dbg !800

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !793
  store i8 %conv, ptr %arrayidx, align 1, !dbg !793, !tbaa !436
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !793
    #dbg_value(i64 %indvars.iv.next, !785, !DIExpression(), !788)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !793
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !793
  store i8 10, ptr %arrayidx11, align 1, !dbg !793, !tbaa !436
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !793
    #dbg_value(ptr %call12, !783, !DIExpression(), !788)
  %cmp1 = icmp ne ptr %call12, null, !dbg !789
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !789
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !789
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !789, !llvm.loop !802

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !789

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !789

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !789

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !789

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !803
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !803
  store i8 10, ptr %arrayidx17, align 1, !dbg !803, !tbaa !436
  br label %if.end18, !dbg !803

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !789
  ret i32 0, !dbg !789
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !806 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #12

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !812 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #12

; Function Attrs: nofree nounwind
declare !dbg !817 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !872 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !875 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !887
    #dbg_assign(i1 undef, !884, !DIExpression(), !887, ptr %endptr, !DIExpression(), !888)
    #dbg_value(ptr %s, !880, !DIExpression(), !888)
    #dbg_value(ptr %arr, !881, !DIExpression(), !888)
    #dbg_value(i32 %n, !882, !DIExpression(), !888)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !889
    #dbg_value(i32 0, !885, !DIExpression(), !888)
  %cmp.not = icmp eq ptr %s, null, !dbg !890
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !890

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #20, !dbg !890
  unreachable, !dbg !890

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !889
    #dbg_value(ptr %call, !883, !DIExpression(), !888)
    #dbg_value(i32 0, !885, !DIExpression(), !888)
  %cmp130 = icmp ne ptr %call, null, !dbg !889
  %cmp231 = icmp sgt i32 %n, 0, !dbg !889
  %0 = and i1 %cmp231, %cmp130, !dbg !889
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !889

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !889

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !889
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !889

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !883, !DIExpression(), !888)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !885, !DIExpression(), !888)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !893, !tbaa !795, !DIAssignID !895
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !884, !DIExpression(), !895, ptr %endptr, !DIExpression(), !888)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !893
  %conv = trunc i64 %call3 to i16, !dbg !893
    #dbg_value(i16 %conv, !886, !DIExpression(), !888)
  %2 = load ptr, ptr %endptr, align 8, !dbg !896, !tbaa !795
  %3 = load i8, ptr %2, align 1, !dbg !896, !tbaa !436
  %cmp5.not = icmp eq i8 %3, 0, !dbg !896
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !893

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !893

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !898, !tbaa !795
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !898
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !898
  br label %if.end9, !dbg !898

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !893
  store i16 %conv, ptr %arrayidx, align 2, !dbg !893, !tbaa !900
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !893
    #dbg_value(i64 %indvars.iv.next, !885, !DIExpression(), !888)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !893
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !893
  store i8 10, ptr %arrayidx11, align 1, !dbg !893, !tbaa !436
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !893
    #dbg_value(ptr %call12, !883, !DIExpression(), !888)
  %cmp1 = icmp ne ptr %call12, null, !dbg !889
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !889
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !889
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !889, !llvm.loop !902

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !889

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !889

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !889

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !889

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !903
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !903
  store i8 10, ptr %arrayidx17, align 1, !dbg !903, !tbaa !436
  br label %if.end18, !dbg !903

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !889
  ret i32 0, !dbg !889
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !906 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !918
    #dbg_assign(i1 undef, !915, !DIExpression(), !918, ptr %endptr, !DIExpression(), !919)
    #dbg_value(ptr %s, !911, !DIExpression(), !919)
    #dbg_value(ptr %arr, !912, !DIExpression(), !919)
    #dbg_value(i32 %n, !913, !DIExpression(), !919)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !920
    #dbg_value(i32 0, !916, !DIExpression(), !919)
  %cmp.not = icmp eq ptr %s, null, !dbg !921
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !921

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #20, !dbg !921
  unreachable, !dbg !921

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !920
    #dbg_value(ptr %call, !914, !DIExpression(), !919)
    #dbg_value(i32 0, !916, !DIExpression(), !919)
  %cmp130 = icmp ne ptr %call, null, !dbg !920
  %cmp231 = icmp sgt i32 %n, 0, !dbg !920
  %0 = and i1 %cmp231, %cmp130, !dbg !920
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !920

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !920

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !920
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !920

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !914, !DIExpression(), !919)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !916, !DIExpression(), !919)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !924, !tbaa !795, !DIAssignID !926
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !915, !DIExpression(), !926, ptr %endptr, !DIExpression(), !919)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !924
  %conv = trunc i64 %call3 to i32, !dbg !924
    #dbg_value(i32 %conv, !917, !DIExpression(), !919)
  %2 = load ptr, ptr %endptr, align 8, !dbg !927, !tbaa !795
  %3 = load i8, ptr %2, align 1, !dbg !927, !tbaa !436
  %cmp5.not = icmp eq i8 %3, 0, !dbg !927
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !924

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !924

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !929, !tbaa !795
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !929
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !929
  br label %if.end9, !dbg !929

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !924
  store i32 %conv, ptr %arrayidx, align 4, !dbg !924, !tbaa !931
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !924
    #dbg_value(i64 %indvars.iv.next, !916, !DIExpression(), !919)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !924
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !924
  store i8 10, ptr %arrayidx11, align 1, !dbg !924, !tbaa !436
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !924
    #dbg_value(ptr %call12, !914, !DIExpression(), !919)
  %cmp1 = icmp ne ptr %call12, null, !dbg !920
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !920
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !920
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !920, !llvm.loop !933

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !920

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !920

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !920

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !920

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !934
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !934
  store i8 10, ptr %arrayidx17, align 1, !dbg !934, !tbaa !436
  br label %if.end18, !dbg !934

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !920
  ret i32 0, !dbg !920
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !937 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !949
    #dbg_assign(i1 undef, !946, !DIExpression(), !949, ptr %endptr, !DIExpression(), !950)
    #dbg_value(ptr %s, !942, !DIExpression(), !950)
    #dbg_value(ptr %arr, !943, !DIExpression(), !950)
    #dbg_value(i32 %n, !944, !DIExpression(), !950)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !951
    #dbg_value(i32 0, !947, !DIExpression(), !950)
  %cmp.not = icmp eq ptr %s, null, !dbg !952
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !952

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #20, !dbg !952
  unreachable, !dbg !952

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !951
    #dbg_value(ptr %call, !945, !DIExpression(), !950)
    #dbg_value(i32 0, !947, !DIExpression(), !950)
  %cmp129 = icmp ne ptr %call, null, !dbg !951
  %cmp230 = icmp sgt i32 %n, 0, !dbg !951
  %0 = and i1 %cmp230, %cmp129, !dbg !951
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !951

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !951

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !951
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !951

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !945, !DIExpression(), !950)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !947, !DIExpression(), !950)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !955, !tbaa !795, !DIAssignID !957
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !946, !DIExpression(), !957, ptr %endptr, !DIExpression(), !950)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !955
    #dbg_value(i64 %call3, !948, !DIExpression(), !950)
  %2 = load ptr, ptr %endptr, align 8, !dbg !958, !tbaa !795
  %3 = load i8, ptr %2, align 1, !dbg !958, !tbaa !436
  %cmp4.not = icmp eq i8 %3, 0, !dbg !958
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !955

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !955

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !960, !tbaa !795
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !960
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !960
  br label %if.end8, !dbg !960

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !955
  store i64 %call3, ptr %arrayidx, align 8, !dbg !955, !tbaa !962
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !955
    #dbg_value(i64 %indvars.iv.next, !947, !DIExpression(), !950)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #23, !dbg !955
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !955
  store i8 10, ptr %arrayidx10, align 1, !dbg !955, !tbaa !436
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !955
    #dbg_value(ptr %call11, !945, !DIExpression(), !950)
  %cmp1 = icmp ne ptr %call11, null, !dbg !951
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !951
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !951
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !951, !llvm.loop !964

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !951

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !951

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !951

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !951

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !965
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !965
  store i8 10, ptr %arrayidx16, align 1, !dbg !965, !tbaa !436
  br label %if.end17, !dbg !965

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !951
  ret i32 0, !dbg !951
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !968 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !980
    #dbg_assign(i1 undef, !977, !DIExpression(), !980, ptr %endptr, !DIExpression(), !981)
    #dbg_value(ptr %s, !973, !DIExpression(), !981)
    #dbg_value(ptr %arr, !974, !DIExpression(), !981)
    #dbg_value(i32 %n, !975, !DIExpression(), !981)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !982
    #dbg_value(i32 0, !978, !DIExpression(), !981)
  %cmp.not = icmp eq ptr %s, null, !dbg !983
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !983

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #20, !dbg !983
  unreachable, !dbg !983

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !982
    #dbg_value(ptr %call, !976, !DIExpression(), !981)
    #dbg_value(i32 0, !978, !DIExpression(), !981)
  %cmp130 = icmp ne ptr %call, null, !dbg !982
  %cmp231 = icmp sgt i32 %n, 0, !dbg !982
  %0 = and i1 %cmp231, %cmp130, !dbg !982
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !982

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !982

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !982
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !982

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !976, !DIExpression(), !981)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !978, !DIExpression(), !981)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !986, !tbaa !795, !DIAssignID !988
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !977, !DIExpression(), !988, ptr %endptr, !DIExpression(), !981)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !986
  %conv = trunc i64 %call3 to i8, !dbg !986
    #dbg_value(i8 %conv, !979, !DIExpression(), !981)
  %2 = load ptr, ptr %endptr, align 8, !dbg !989, !tbaa !795
  %3 = load i8, ptr %2, align 1, !dbg !989, !tbaa !436
  %cmp5.not = icmp eq i8 %3, 0, !dbg !989
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !986

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !986

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !991, !tbaa !795
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !991
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !991
  br label %if.end9, !dbg !991

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !986
  store i8 %conv, ptr %arrayidx, align 1, !dbg !986, !tbaa !436
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !986
    #dbg_value(i64 %indvars.iv.next, !978, !DIExpression(), !981)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !986
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !986
  store i8 10, ptr %arrayidx11, align 1, !dbg !986, !tbaa !436
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !986
    #dbg_value(ptr %call12, !976, !DIExpression(), !981)
  %cmp1 = icmp ne ptr %call12, null, !dbg !982
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !982
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !982
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !982, !llvm.loop !993

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !982

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !982

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !982

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !982

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !994
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !994
  store i8 10, ptr %arrayidx17, align 1, !dbg !994, !tbaa !436
  br label %if.end18, !dbg !994

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !982
  ret i32 0, !dbg !982
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !997 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1009
    #dbg_assign(i1 undef, !1006, !DIExpression(), !1009, ptr %endptr, !DIExpression(), !1010)
    #dbg_value(ptr %s, !1002, !DIExpression(), !1010)
    #dbg_value(ptr %arr, !1003, !DIExpression(), !1010)
    #dbg_value(i32 %n, !1004, !DIExpression(), !1010)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1011
    #dbg_value(i32 0, !1007, !DIExpression(), !1010)
  %cmp.not = icmp eq ptr %s, null, !dbg !1012
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1012

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #20, !dbg !1012
  unreachable, !dbg !1012

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1011
    #dbg_value(ptr %call, !1005, !DIExpression(), !1010)
    #dbg_value(i32 0, !1007, !DIExpression(), !1010)
  %cmp130 = icmp ne ptr %call, null, !dbg !1011
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1011
  %0 = and i1 %cmp231, %cmp130, !dbg !1011
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1011

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1011

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1011
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1011

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1005, !DIExpression(), !1010)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1007, !DIExpression(), !1010)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1015, !tbaa !795, !DIAssignID !1017
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1006, !DIExpression(), !1017, ptr %endptr, !DIExpression(), !1010)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1015
  %conv = trunc i64 %call3 to i16, !dbg !1015
    #dbg_value(i16 %conv, !1008, !DIExpression(), !1010)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1018, !tbaa !795
  %3 = load i8, ptr %2, align 1, !dbg !1018, !tbaa !436
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1018
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1015

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1015

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1020, !tbaa !795
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1020
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !1020
  br label %if.end9, !dbg !1020

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1015
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1015, !tbaa !900
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1015
    #dbg_value(i64 %indvars.iv.next, !1007, !DIExpression(), !1010)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !1015
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1015
  store i8 10, ptr %arrayidx11, align 1, !dbg !1015, !tbaa !436
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1015
    #dbg_value(ptr %call12, !1005, !DIExpression(), !1010)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1011
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1011
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1011
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1011, !llvm.loop !1022

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1011

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1011

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1011

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1011

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !1023
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1023
  store i8 10, ptr %arrayidx17, align 1, !dbg !1023, !tbaa !436
  br label %if.end18, !dbg !1023

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1011
  ret i32 0, !dbg !1011
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1026 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1038
    #dbg_assign(i1 undef, !1035, !DIExpression(), !1038, ptr %endptr, !DIExpression(), !1039)
    #dbg_value(ptr %s, !1031, !DIExpression(), !1039)
    #dbg_value(ptr %arr, !1032, !DIExpression(), !1039)
    #dbg_value(i32 %n, !1033, !DIExpression(), !1039)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1040
    #dbg_value(i32 0, !1036, !DIExpression(), !1039)
  %cmp.not = icmp eq ptr %s, null, !dbg !1041
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1041

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #20, !dbg !1041
  unreachable, !dbg !1041

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1040
    #dbg_value(ptr %call, !1034, !DIExpression(), !1039)
    #dbg_value(i32 0, !1036, !DIExpression(), !1039)
  %cmp130 = icmp ne ptr %call, null, !dbg !1040
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1040
  %0 = and i1 %cmp231, %cmp130, !dbg !1040
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1040

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1040

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1040
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1040

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1034, !DIExpression(), !1039)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1036, !DIExpression(), !1039)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1044, !tbaa !795, !DIAssignID !1046
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1035, !DIExpression(), !1046, ptr %endptr, !DIExpression(), !1039)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1044
  %conv = trunc i64 %call3 to i32, !dbg !1044
    #dbg_value(i32 %conv, !1037, !DIExpression(), !1039)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1047, !tbaa !795
  %3 = load i8, ptr %2, align 1, !dbg !1047, !tbaa !436
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1047
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1044

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1044

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1049, !tbaa !795
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1049
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !1049
  br label %if.end9, !dbg !1049

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1044
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1044, !tbaa !931
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1044
    #dbg_value(i64 %indvars.iv.next, !1036, !DIExpression(), !1039)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !1044
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1044
  store i8 10, ptr %arrayidx11, align 1, !dbg !1044, !tbaa !436
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1044
    #dbg_value(ptr %call12, !1034, !DIExpression(), !1039)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1040
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1040
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1040
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1040, !llvm.loop !1051

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1040

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1040

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1040

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1040

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !1052
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1052
  store i8 10, ptr %arrayidx17, align 1, !dbg !1052, !tbaa !436
  br label %if.end18, !dbg !1052

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1040
  ret i32 0, !dbg !1040
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1055 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1067
    #dbg_assign(i1 undef, !1064, !DIExpression(), !1067, ptr %endptr, !DIExpression(), !1068)
    #dbg_value(ptr %s, !1060, !DIExpression(), !1068)
    #dbg_value(ptr %arr, !1061, !DIExpression(), !1068)
    #dbg_value(i32 %n, !1062, !DIExpression(), !1068)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1069
    #dbg_value(i32 0, !1065, !DIExpression(), !1068)
  %cmp.not = icmp eq ptr %s, null, !dbg !1070
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1070

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #20, !dbg !1070
  unreachable, !dbg !1070

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1069
    #dbg_value(ptr %call, !1063, !DIExpression(), !1068)
    #dbg_value(i32 0, !1065, !DIExpression(), !1068)
  %cmp129 = icmp ne ptr %call, null, !dbg !1069
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1069
  %0 = and i1 %cmp230, %cmp129, !dbg !1069
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1069

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1069

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1069
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1069

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1063, !DIExpression(), !1068)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1065, !DIExpression(), !1068)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1073, !tbaa !795, !DIAssignID !1075
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1064, !DIExpression(), !1075, ptr %endptr, !DIExpression(), !1068)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1073
    #dbg_value(i64 %call3, !1066, !DIExpression(), !1068)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1076, !tbaa !795
  %3 = load i8, ptr %2, align 1, !dbg !1076, !tbaa !436
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1076
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1073

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1073

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1078, !tbaa !795
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1078
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !1078
  br label %if.end8, !dbg !1078

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1073
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1073, !tbaa !962
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1073
    #dbg_value(i64 %indvars.iv.next, !1065, !DIExpression(), !1068)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #23, !dbg !1073
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1073
  store i8 10, ptr %arrayidx10, align 1, !dbg !1073, !tbaa !436
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1073
    #dbg_value(ptr %call11, !1063, !DIExpression(), !1068)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1069
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1069
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1069
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1069, !llvm.loop !1080

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1069

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1069

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1069

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1069

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !1081
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1081
  store i8 10, ptr %arrayidx16, align 1, !dbg !1081, !tbaa !436
  br label %if.end17, !dbg !1081

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1069
  ret i32 0, !dbg !1069
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1084 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1096
    #dbg_assign(i1 undef, !1093, !DIExpression(), !1096, ptr %endptr, !DIExpression(), !1097)
    #dbg_value(ptr %s, !1089, !DIExpression(), !1097)
    #dbg_value(ptr %arr, !1090, !DIExpression(), !1097)
    #dbg_value(i32 %n, !1091, !DIExpression(), !1097)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1098
    #dbg_value(i32 0, !1094, !DIExpression(), !1097)
  %cmp.not = icmp eq ptr %s, null, !dbg !1099
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1099

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #20, !dbg !1099
  unreachable, !dbg !1099

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1098
    #dbg_value(ptr %call, !1092, !DIExpression(), !1097)
    #dbg_value(i32 0, !1094, !DIExpression(), !1097)
  %cmp129 = icmp ne ptr %call, null, !dbg !1098
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1098
  %0 = and i1 %cmp230, %cmp129, !dbg !1098
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1098

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1098

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1098
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1098

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1092, !DIExpression(), !1097)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1094, !DIExpression(), !1097)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1102, !tbaa !795, !DIAssignID !1104
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1093, !DIExpression(), !1104, ptr %endptr, !DIExpression(), !1097)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #19, !dbg !1102
    #dbg_value(float %call3, !1095, !DIExpression(), !1097)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1105, !tbaa !795
  %3 = load i8, ptr %2, align 1, !dbg !1105, !tbaa !436
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1105
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1102

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1102

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1107, !tbaa !795
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1107
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !1107
  br label %if.end8, !dbg !1107

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1102
  store float %call3, ptr %arrayidx, align 4, !dbg !1102, !tbaa !1109
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1102
    #dbg_value(i64 %indvars.iv.next, !1094, !DIExpression(), !1097)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #23, !dbg !1102
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1102
  store i8 10, ptr %arrayidx10, align 1, !dbg !1102, !tbaa !436
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1102
    #dbg_value(ptr %call11, !1092, !DIExpression(), !1097)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1098
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1098
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1098
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1098, !llvm.loop !1111

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1098

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1098

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1098

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1098

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !1112
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1112
  store i8 10, ptr %arrayidx16, align 1, !dbg !1112, !tbaa !436
  br label %if.end17, !dbg !1112

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1098
  ret i32 0, !dbg !1098
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1115 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1118 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1129
    #dbg_assign(i1 undef, !1126, !DIExpression(), !1129, ptr %endptr, !DIExpression(), !1130)
    #dbg_value(ptr %s, !1122, !DIExpression(), !1130)
    #dbg_value(ptr %arr, !1123, !DIExpression(), !1130)
    #dbg_value(i32 %n, !1124, !DIExpression(), !1130)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1131
    #dbg_value(i32 0, !1127, !DIExpression(), !1130)
  %cmp.not = icmp eq ptr %s, null, !dbg !1132
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1132

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #20, !dbg !1132
  unreachable, !dbg !1132

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1131
    #dbg_value(ptr %call, !1125, !DIExpression(), !1130)
    #dbg_value(i32 0, !1127, !DIExpression(), !1130)
  %cmp129 = icmp ne ptr %call, null, !dbg !1131
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1131
  %0 = and i1 %cmp230, %cmp129, !dbg !1131
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1131

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1131

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1131
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1131

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1125, !DIExpression(), !1130)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1127, !DIExpression(), !1130)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1135, !tbaa !795, !DIAssignID !1137
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1126, !DIExpression(), !1137, ptr %endptr, !DIExpression(), !1130)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #19, !dbg !1135
    #dbg_value(double %call3, !1128, !DIExpression(), !1130)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1138, !tbaa !795
  %3 = load i8, ptr %2, align 1, !dbg !1138, !tbaa !436
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1138
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1135

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1135

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1140, !tbaa !795
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1140
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !1140
  br label %if.end8, !dbg !1140

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1135
  store double %call3, ptr %arrayidx, align 8, !dbg !1135, !tbaa !360
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1135
    #dbg_value(i64 %indvars.iv.next, !1127, !DIExpression(), !1130)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #23, !dbg !1135
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1135
  store i8 10, ptr %arrayidx10, align 1, !dbg !1135, !tbaa !436
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1135
    #dbg_value(ptr %call11, !1125, !DIExpression(), !1130)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1131
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1131
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1131
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1131, !llvm.loop !1142

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1131

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1131

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1131

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1131

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !1143
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1143
  store i8 10, ptr %arrayidx16, align 1, !dbg !1143, !tbaa !436
  br label %if.end17, !dbg !1143

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1131
  ret i32 0, !dbg !1131
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1146 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1149 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1153, !DIExpression(), !1158)
    #dbg_value(ptr %arr, !1154, !DIExpression(), !1158)
    #dbg_value(i32 %n, !1155, !DIExpression(), !1158)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1159
  br i1 %cmp, label %if.end, label %if.else, !dbg !1159

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #20, !dbg !1159
  unreachable, !dbg !1159

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1162
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1164

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1164

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #23, !dbg !1165
  %conv = trunc i64 %call to i32, !dbg !1165
    #dbg_value(i32 %conv, !1155, !DIExpression(), !1158)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1167

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1155, !DIExpression(), !1158)
    #dbg_value(i32 0, !1157, !DIExpression(), !1158)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1168
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1169

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1169

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1169

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1170

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1171
    #dbg_value(i32 %add, !1157, !DIExpression(), !1158)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1168
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1169, !llvm.loop !1173

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1169

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1169

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1157, !DIExpression(), !1158)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1175
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1175
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1176
  %conv6 = sext i32 %sub to i64, !dbg !1177
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #19, !dbg !1178
  %conv8 = trunc i64 %call7 to i32, !dbg !1178
    #dbg_value(i32 %conv8, !1156, !DIExpression(), !1158)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1179
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1157, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1158)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1179

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #20, !dbg !1179
  unreachable, !dbg !1179

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #19, !dbg !1182
  %conv16 = trunc i64 %call15 to i32, !dbg !1182
    #dbg_value(i32 %conv16, !1156, !DIExpression(), !1158)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1184
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1184

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #20, !dbg !1184
  unreachable, !dbg !1184

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1187
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1188, !llvm.loop !1189

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1188

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1191
}

; Function Attrs: nofree
declare !dbg !1192 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #9

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1197 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1201, !DIExpression(), !1205)
    #dbg_value(ptr %arr, !1202, !DIExpression(), !1205)
    #dbg_value(i32 %n, !1203, !DIExpression(), !1205)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1206
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1206

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1204, !DIExpression(), !1205)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1209
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1212

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1212

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1209
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1212

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #20, !dbg !1206
  unreachable, !dbg !1206

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1204, !DIExpression(), !1205)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1213
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1213, !tbaa !436
  %conv = zext i8 %0 to i32, !dbg !1213
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1213
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1209
    #dbg_value(i64 %indvars.iv.next, !1204, !DIExpression(), !1205)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1209
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1212, !llvm.loop !1215

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1212

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1212

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1216
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #14 !dbg !1217 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1234
    #dbg_assign(i1 undef, !1223, !DIExpression(), !1234, ptr %args, !DIExpression(), !1235)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1236
    #dbg_assign(i1 undef, !1230, !DIExpression(), !1236, ptr %buffer, !DIExpression(), !1235)
    #dbg_value(i32 %fd, !1221, !DIExpression(), !1235)
    #dbg_value(ptr %format, !1222, !DIExpression(), !1235)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #19, !dbg !1237
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #19, !dbg !1238
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1239
  %0 = load ptr, ptr %args, align 8, !dbg !1240, !tbaa !795
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #19, !dbg !1241
    #dbg_value(i32 %call, !1227, !DIExpression(), !1235)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1242
  %cmp = icmp slt i32 %call, 256, !dbg !1243
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1243

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1228, !DIExpression(), !1235)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1246
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1247

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1247

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1247

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #20, !dbg !1243
  unreachable, !dbg !1243

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1248
    #dbg_value(i32 %add, !1228, !DIExpression(), !1235)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1246
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1247, !llvm.loop !1250

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1247

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1247

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1228, !DIExpression(), !1235)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1252
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1252
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1253
  %conv = sext i32 %sub to i64, !dbg !1254
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #19, !dbg !1255
  %conv3 = trunc i64 %call2 to i32, !dbg !1255
    #dbg_value(i32 %conv3, !1229, !DIExpression(), !1235)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1256
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1228, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1235)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1256

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #20, !dbg !1256
  unreachable, !dbg !1256

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1259
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1259

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #20, !dbg !1259
  unreachable, !dbg !1259

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #19, !dbg !1262
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #19, !dbg !1262
  ret void, !dbg !1263
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #15

; Function Attrs: nofree nounwind
declare !dbg !1264 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #7

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1269 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1273, !DIExpression(), !1277)
    #dbg_value(ptr %arr, !1274, !DIExpression(), !1277)
    #dbg_value(i32 %n, !1275, !DIExpression(), !1277)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1278
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1278

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1276, !DIExpression(), !1277)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1281
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1284

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1284

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1281
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1284

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #20, !dbg !1278
  unreachable, !dbg !1278

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1276, !DIExpression(), !1277)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1285
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1285, !tbaa !900
  %conv = zext i16 %0 to i32, !dbg !1285
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1285
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1281
    #dbg_value(i64 %indvars.iv.next, !1276, !DIExpression(), !1277)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1281
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1284, !llvm.loop !1287

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1284

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1284

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1288
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1289 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1293, !DIExpression(), !1297)
    #dbg_value(ptr %arr, !1294, !DIExpression(), !1297)
    #dbg_value(i32 %n, !1295, !DIExpression(), !1297)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1298
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1298

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1296, !DIExpression(), !1297)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1301
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1304

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1304

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1301
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1304

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #20, !dbg !1298
  unreachable, !dbg !1298

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1296, !DIExpression(), !1297)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1305
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1305, !tbaa !931
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1305
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1301
    #dbg_value(i64 %indvars.iv.next, !1296, !DIExpression(), !1297)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1301
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1304, !llvm.loop !1307

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1304

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1304

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1308
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1309 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1313, !DIExpression(), !1317)
    #dbg_value(ptr %arr, !1314, !DIExpression(), !1317)
    #dbg_value(i32 %n, !1315, !DIExpression(), !1317)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1318
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1318

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1316, !DIExpression(), !1317)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1321
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1324

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1324

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1321
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1324

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #20, !dbg !1318
  unreachable, !dbg !1318

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1316, !DIExpression(), !1317)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1325
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1325, !tbaa !962
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1325
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1321
    #dbg_value(i64 %indvars.iv.next, !1316, !DIExpression(), !1317)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1321
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1324, !llvm.loop !1327

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1324

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1324

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1328
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1329 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1333, !DIExpression(), !1337)
    #dbg_value(ptr %arr, !1334, !DIExpression(), !1337)
    #dbg_value(i32 %n, !1335, !DIExpression(), !1337)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1338
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1338

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1336, !DIExpression(), !1337)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1341
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1344

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1344

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1341
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1344

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #20, !dbg !1338
  unreachable, !dbg !1338

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1336, !DIExpression(), !1337)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1345
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1345, !tbaa !436
  %conv = sext i8 %0 to i32, !dbg !1345
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1345
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1341
    #dbg_value(i64 %indvars.iv.next, !1336, !DIExpression(), !1337)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1341
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1344, !llvm.loop !1347

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1344

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1344

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1348
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1349 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1353, !DIExpression(), !1357)
    #dbg_value(ptr %arr, !1354, !DIExpression(), !1357)
    #dbg_value(i32 %n, !1355, !DIExpression(), !1357)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1358
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1358

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1356, !DIExpression(), !1357)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1361
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1364

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1364

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1361
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1364

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #20, !dbg !1358
  unreachable, !dbg !1358

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1356, !DIExpression(), !1357)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1365
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1365, !tbaa !900
  %conv = sext i16 %0 to i32, !dbg !1365
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1365
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1361
    #dbg_value(i64 %indvars.iv.next, !1356, !DIExpression(), !1357)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1361
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1364, !llvm.loop !1367

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1364

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1364

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1368
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1369 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1373, !DIExpression(), !1377)
    #dbg_value(ptr %arr, !1374, !DIExpression(), !1377)
    #dbg_value(i32 %n, !1375, !DIExpression(), !1377)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1378
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1378

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1376, !DIExpression(), !1377)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1381
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1384

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1384

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1381
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1384

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #20, !dbg !1378
  unreachable, !dbg !1378

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1376, !DIExpression(), !1377)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1385
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1385, !tbaa !931
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1385
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1381
    #dbg_value(i64 %indvars.iv.next, !1376, !DIExpression(), !1377)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1381
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1384, !llvm.loop !1387

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1384

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1384

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1388
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1389 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1393, !DIExpression(), !1397)
    #dbg_value(ptr %arr, !1394, !DIExpression(), !1397)
    #dbg_value(i32 %n, !1395, !DIExpression(), !1397)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1398
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1398

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1396, !DIExpression(), !1397)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1401
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1404

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1404

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1401
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1404

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #20, !dbg !1398
  unreachable, !dbg !1398

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1396, !DIExpression(), !1397)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1405
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1405, !tbaa !962
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1405
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1401
    #dbg_value(i64 %indvars.iv.next, !1396, !DIExpression(), !1397)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1401
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1404, !llvm.loop !1407

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1404

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1404

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1408
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1409 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1413, !DIExpression(), !1417)
    #dbg_value(ptr %arr, !1414, !DIExpression(), !1417)
    #dbg_value(i32 %n, !1415, !DIExpression(), !1417)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1418
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1418

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1416, !DIExpression(), !1417)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1421
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1424

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1424

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1421
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1424

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #20, !dbg !1418
  unreachable, !dbg !1418

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1416, !DIExpression(), !1417)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1425
  %0 = load float, ptr %arrayidx, align 4, !dbg !1425, !tbaa !1109
  %conv = fpext float %0 to double, !dbg !1425
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1425
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1421
    #dbg_value(i64 %indvars.iv.next, !1416, !DIExpression(), !1417)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1421
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1424, !llvm.loop !1427

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1424

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1424

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1428
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !498 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !497, !DIExpression(), !1429)
    #dbg_value(ptr %arr, !502, !DIExpression(), !1429)
    #dbg_value(i32 %n, !503, !DIExpression(), !1429)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1430
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1430

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !504, !DIExpression(), !1429)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1433
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1434

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1434

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1433
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1434

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #20, !dbg !1430
  unreachable, !dbg !1430

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !504, !DIExpression(), !1429)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1435
  %0 = load double, ptr %arrayidx, align 8, !dbg !1435, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1435
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1433
    #dbg_value(i64 %indvars.iv.next, !504, !DIExpression(), !1429)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1433
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1434, !llvm.loop !1436

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1434

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1434

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1437
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !487 {
entry.split:
    #dbg_value(i32 %fd, !486, !DIExpression(), !1438)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1439
  br i1 %cmp, label %if.end, label %if.else, !dbg !1439

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !1439
  unreachable, !dbg !1439

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1440
  ret i32 0, !dbg !1441
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #16 !dbg !1442 {
entry.split:
  %polly.access.call67.promoted.reg2mem = alloca double, align 8
  %invariant.gep.reg2mem = alloca ptr, align 8
  %gep85.reg2mem = alloca ptr, align 8
  %polly.indvar58.reg2mem = alloca i64, align 8
  %polly.indvar_next65.reg2mem = alloca i64, align 8
  %p_add12.i.i.reg2mem = alloca double, align 8
  %.reg2mem = alloca ptr, align 8
  %gep87.reg2mem = alloca ptr, align 8
  %polly.indvar52.reg2mem = alloca i64, align 8
  %polly.indvar_next59.reg2mem = alloca i64, align 8
  %polly.indvar_next53.reg2mem = alloca i64, align 8
  %polly.indvar_next53.1.1273.reg2mem = alloca i64, align 8
  %polly.indvar_next59.1.1270.reg2mem = alloca i64, align 8
  %polly.indvar_next65.1.1267.reg2mem = alloca i64, align 8
  %p_add12.i.i.1.1266.reg2mem = alloca double, align 8
  %polly.access.call67.promoted.1.1257.reg2mem = alloca double, align 8
  %invariant.gep.1.1256.reg2mem = alloca ptr, align 8
  %gep85.1.1255.reg2mem = alloca ptr, align 8
  %polly.indvar58.1.1254.reg2mem = alloca i64, align 8
  %.reg2mem328 = alloca ptr, align 8
  %gep87.1.1252.reg2mem = alloca ptr, align 8
  %polly.indvar52.1.1250.reg2mem = alloca i64, align 8
  %polly.indvar_next53.1246.reg2mem = alloca i64, align 8
  %polly.indvar_next59.1243.reg2mem = alloca i64, align 8
  %polly.indvar_next65.1240.reg2mem = alloca i64, align 8
  %p_add12.i.i.1239.reg2mem = alloca double, align 8
  %polly.access.call67.promoted.1230.reg2mem = alloca double, align 8
  %invariant.gep.1229.reg2mem = alloca ptr, align 8
  %gep85.1228.reg2mem = alloca ptr, align 8
  %polly.indvar58.1227.reg2mem = alloca i64, align 8
  %.reg2mem338 = alloca ptr, align 8
  %gep87.1225.reg2mem = alloca ptr, align 8
  %polly.indvar52.1223.reg2mem = alloca i64, align 8
  %.reg2mem341 = alloca ptr, align 8
  %gep91.1.reg2mem = alloca ptr, align 8
  %polly.indvar_next53.1.1.reg2mem = alloca i64, align 8
  %polly.indvar_next59.1.1.reg2mem = alloca i64, align 8
  %polly.indvar_next65.1.1.reg2mem = alloca i64, align 8
  %p_add12.i.i.1.1.reg2mem = alloca double, align 8
  %polly.access.call67.promoted.1.1.reg2mem = alloca double, align 8
  %gep280.reg2mem = alloca ptr, align 8
  %gep85.1.1.reg2mem = alloca ptr, align 8
  %polly.indvar58.1.1.reg2mem = alloca i64, align 8
  %.reg2mem354 = alloca ptr, align 8
  %gep87.1.1.reg2mem = alloca ptr, align 8
  %polly.indvar52.1.1.reg2mem = alloca i64, align 8
  %invariant.gep279.reg2mem = alloca ptr, align 8
  %polly.indvar_next53.1218.reg2mem = alloca i64, align 8
  %polly.indvar_next59.1215.reg2mem = alloca i64, align 8
  %polly.indvar_next65.1212.reg2mem = alloca i64, align 8
  %p_add12.i.i.1211.reg2mem = alloca double, align 8
  %polly.access.call67.promoted.1202.reg2mem = alloca double, align 8
  %gep.reg2mem = alloca ptr, align 8
  %gep85.1200.reg2mem = alloca ptr, align 8
  %polly.indvar58.1199.reg2mem = alloca i64, align 8
  %.reg2mem364 = alloca ptr, align 8
  %gep87.1197.reg2mem = alloca ptr, align 8
  %polly.indvar52.1195.reg2mem = alloca i64, align 8
  %invariant.gep278.reg2mem = alloca ptr, align 8
  %gep89.1.reg2mem = alloca ptr, align 8
  %polly.indvar_next53.1.reg2mem = alloca i64, align 8
  %polly.indvar_next59.1.reg2mem = alloca i64, align 8
  %polly.indvar_next65.1.reg2mem = alloca i64, align 8
  %p_add12.i.i.1.reg2mem = alloca double, align 8
  %polly.access.call67.promoted.1.reg2mem = alloca double, align 8
  %invariant.gep.1.reg2mem = alloca ptr, align 8
  %gep85.1.reg2mem = alloca ptr, align 8
  %polly.indvar58.1.reg2mem = alloca i64, align 8
  %.reg2mem375 = alloca ptr, align 8
  %gep87.1.reg2mem = alloca ptr, align 8
  %polly.indvar52.1.reg2mem = alloca i64, align 8
  %scevgep93.reg2mem = alloca ptr, align 8
  %m2.i.reg2mem = alloca ptr, align 8
  %call14.reg2mem = alloca i32, align 4
  %call.reg2mem = alloca ptr, align 8
  %check_file.0.reg2mem = alloca ptr, align 8
  %in_file.09.reg2mem = alloca ptr, align 8
  %.reg2mem426 = alloca ptr, align 8
  %.reg2mem428 = alloca ptr, align 8
  %polly.indvar58.reg2mem431 = alloca i64, align 8
  %polly.indvar64.reg2mem = alloca i64, align 8
  %p_add12.i.i83.reg2mem = alloca double, align 8
  %polly.indvar52.reg2mem433 = alloca i64, align 8
  %polly.indvar64.1.1.1.reg2mem = alloca i64, align 8
  %p_add12.i.i83.1.1.1.reg2mem = alloca double, align 8
  %polly.indvar58.1.1.1.reg2mem435 = alloca i64, align 8
  %polly.indvar52.1.1.1.reg2mem437 = alloca i64, align 8
  %polly.indvar64.1205.1.reg2mem = alloca i64, align 8
  %p_add12.i.i83.1204.1.reg2mem = alloca double, align 8
  %polly.indvar58.1199.1.reg2mem439 = alloca i64, align 8
  %polly.indvar52.1195.1.reg2mem441 = alloca i64, align 8
  %polly.indvar64.1.1260.reg2mem = alloca i64, align 8
  %p_add12.i.i83.1.1259.reg2mem = alloca double, align 8
  %polly.indvar58.1.1254.reg2mem443 = alloca i64, align 8
  %polly.indvar52.1.1250.reg2mem445 = alloca i64, align 8
  %polly.indvar64.1233.reg2mem = alloca i64, align 8
  %p_add12.i.i83.1232.reg2mem = alloca double, align 8
  %polly.indvar58.1227.reg2mem447 = alloca i64, align 8
  %polly.indvar52.1223.reg2mem449 = alloca i64, align 8
  %polly.indvar64.1.1.reg2mem = alloca i64, align 8
  %p_add12.i.i83.1.1.reg2mem = alloca double, align 8
  %polly.indvar58.1.1.reg2mem451 = alloca i64, align 8
  %polly.indvar52.1.1.reg2mem453 = alloca i64, align 8
  %polly.indvar64.1205.reg2mem = alloca i64, align 8
  %p_add12.i.i83.1204.reg2mem = alloca double, align 8
  %polly.indvar58.1199.reg2mem455 = alloca i64, align 8
  %polly.indvar52.1195.reg2mem457 = alloca i64, align 8
  %polly.indvar64.1.reg2mem = alloca i64, align 8
  %p_add12.i.i83.1.reg2mem = alloca double, align 8
  %polly.indvar58.1.reg2mem459 = alloca i64, align 8
  %polly.indvar52.1.reg2mem461 = alloca i64, align 8
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.123.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %has_errors.025.i.reg2mem463 = alloca i32, align 4
  %indvars.iv27.i.reg2mem465 = alloca i64, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem467 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem469 = alloca ptr, align 8
  %i.041.i.i.reg2mem471 = alloca i32, align 4
  %indvars.iv.i.i2.reg2mem = alloca i64, align 8
  %check_file.0.reg2mem473 = alloca ptr, align 8
  %in_file.09.reg2mem475 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1446, !DIExpression(), !1455)
    #dbg_value(ptr %argv, !1447, !DIExpression(), !1455)
  %cmp = icmp slt i32 %argc, 4, !dbg !1456
  br i1 %cmp, label %if.end, label %if.else, !dbg !1456

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1456
  unreachable, !dbg !1456

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1448, !DIExpression(), !1455)
    #dbg_value(ptr @.str.4.13, !1449, !DIExpression(), !1455)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1459
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1461

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.13, ptr %check_file.0.reg2mem473, align 8
  store ptr @.str.3, ptr %in_file.09.reg2mem475, align 8
  br label %if.end7, !dbg !1461

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1462
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1462
    #dbg_value(ptr %0, !1448, !DIExpression(), !1455)
  store ptr %0, ptr %.reg2mem428, align 8
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1463
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1465

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.13, ptr %check_file.0.reg2mem473, align 8
  store ptr %0, ptr %in_file.09.reg2mem475, align 8
  br label %if.end7, !dbg !1465

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1466
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1466
    #dbg_value(ptr %1, !1449, !DIExpression(), !1455)
  store ptr %1, ptr %.reg2mem426, align 8
  store ptr %1, ptr %check_file.0.reg2mem473, align 8
  store ptr %0, ptr %in_file.09.reg2mem475, align 8
  br label %if.end7, !dbg !1467

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem473.0.check_file.0.reload474, !1449, !DIExpression(), !1455)
  %in_file.09.reg2mem475.0.in_file.09.reload476 = load ptr, ptr %in_file.09.reg2mem475, align 8
  %check_file.0.reg2mem473.0.check_file.0.reload474 = load ptr, ptr %check_file.0.reg2mem473, align 8
  store ptr %in_file.09.reg2mem475.0.in_file.09.reload476, ptr %in_file.09.reg2mem, align 8
  store ptr %check_file.0.reg2mem473.0.check_file.0.reload474, ptr %check_file.0.reg2mem, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1468, !tbaa !931
  %conv = sext i32 %2 to i64, !dbg !1468
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #21, !dbg !1469
    #dbg_value(ptr %call, !1451, !DIExpression(), !1455)
  store ptr %call, ptr %call.reg2mem, align 8
  %cmp8.not = icmp eq ptr %call, null, !dbg !1470
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1470

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.14, ptr noundef nonnull @.str.2.12, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1470
  unreachable, !dbg !1470

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.09.reg2mem475.0.in_file.09.reload476, i32 noundef signext 0) #19, !dbg !1473
    #dbg_value(i32 %call14, !1450, !DIExpression(), !1455)
  store i32 %call14, ptr %call14.reg2mem, align 4
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1474
  br i1 %cmp15, label %polly.loop_preheader, label %if.else19, !dbg !1474

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.15, ptr noundef nonnull @.str.2.12, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1474
  unreachable, !dbg !1474

if.else26:                                        ; preds = %polly.loop_exit51.1.1.1
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1477
  unreachable, !dbg !1477

if.end27:                                         ; preds = %polly.loop_exit51.1.1.1
    #dbg_value(i32 %call21, !558, !DIExpression(), !1480)
    #dbg_value(ptr %call, !559, !DIExpression(), !1480)
    #dbg_value(ptr %call, !560, !DIExpression(), !1480)
    #dbg_value(i32 %call21, !486, !DIExpression(), !1482)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1484
  br i1 %cmp.i.i.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1484

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !1484
  unreachable, !dbg !1484

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1485
    #dbg_value(i32 %call21, !497, !DIExpression(), !1486)
    #dbg_value(ptr %scevgep93, !502, !DIExpression(), !1486)
    #dbg_value(i32 4096, !503, !DIExpression(), !1486)
    #dbg_value(i32 0, !504, !DIExpression(), !1486)
  store i64 0, ptr %indvars.iv.i.i2.reg2mem, align 8
  br label %for.body.i.i, !dbg !1488

for.body.i.i:                                     ; preds = %for.body.i.i.for.body.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i2.reg2mem.0.load, !504, !DIExpression(), !1486)
  %indvars.iv.i.i2.reg2mem.0.load = load i64, ptr %indvars.iv.i.i2.reg2mem, align 8
  %scevgep93.reg2mem.0.scevgep93.reload378 = load ptr, ptr %scevgep93.reg2mem, align 8
  %arrayidx.i.i3 = getelementptr inbounds double, ptr %scevgep93.reg2mem.0.scevgep93.reload378, i64 %indvars.iv.i.i2.reg2mem.0.load, !dbg !1489
  %3 = load double, ptr %arrayidx.i.i3, align 8, !dbg !1489, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.21, double noundef %3), !dbg !1489
  %indvars.iv.next.i.i4 = add nuw nsw i64 %indvars.iv.i.i2.reg2mem.0.load, 1, !dbg !1490
    #dbg_value(i64 %indvars.iv.next.i.i4, !504, !DIExpression(), !1486)
  %exitcond.not.i.i5 = icmp eq i64 %indvars.iv.next.i.i4, 4096, !dbg !1490
  br i1 %exitcond.not.i.i5, label %data_to_output.exit, label %for.body.i.i.for.body.i.i_crit_edge, !dbg !1488, !llvm.loop !1491

for.body.i.i.for.body.i.i_crit_edge:              ; preds = %for.body.i.i
  store i64 %indvars.iv.next.i.i4, ptr %indvars.iv.i.i2.reg2mem, align 8
  br label %for.body.i.i, !dbg !1488

data_to_output.exit:                              ; preds = %for.body.i.i
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #19, !dbg !1492
  %4 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1493, !tbaa !931
  %conv29 = sext i32 %4 to i64, !dbg !1493
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #21, !dbg !1494
    #dbg_value(ptr %call30, !1454, !DIExpression(), !1455)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1495
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1495

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.16, ptr noundef nonnull @.str.2.12, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1495
  unreachable, !dbg !1495

if.end36:                                         ; preds = %data_to_output.exit
  %check_file.0.reg2mem.0.check_file.0.reload = load ptr, ptr %check_file.0.reg2mem, align 8
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem.0.check_file.0.reload, i32 noundef signext 0) #19, !dbg !1498
    #dbg_value(i32 %call37, !1453, !DIExpression(), !1455)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1499
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1499

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.17, ptr noundef nonnull @.str.2.12, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1499
  unreachable, !dbg !1499

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !527, !DIExpression(), !1502)
    #dbg_value(ptr %call30, !528, !DIExpression(), !1502)
    #dbg_value(ptr %call30, !529, !DIExpression(), !1502)
  %call.i = tail call ptr @readfile(i32 noundef signext %call37) #19, !dbg !1504
    #dbg_value(ptr %call.i, !530, !DIExpression(), !1502)
    #dbg_value(ptr %call.i, !426, !DIExpression(), !1505)
    #dbg_value(i32 1, !431, !DIExpression(), !1505)
    #dbg_value(i32 0, !432, !DIExpression(), !1505)
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem469, align 8
  store i32 0, ptr %i.041.i.i.reg2mem471, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i.reg2mem471.0.load, !432, !DIExpression(), !1505)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem469.0.s.addr.040.i.i.reload470, !426, !DIExpression(), !1505)
  %i.041.i.i.reg2mem471.0.load = load i32, ptr %i.041.i.i.reg2mem471, align 4
  %s.addr.040.i.i.reg2mem469.0.s.addr.040.i.i.reload470 = load ptr, ptr %s.addr.040.i.i.reg2mem469, align 8
  %5 = load i8, ptr %s.addr.040.i.i.reg2mem469.0.s.addr.040.i.i.reload470, align 1, !dbg !1507, !tbaa !436
  switch i8 %5, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1508

land.rhs.i.i.output_to_data.exit_crit_edge:       ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem469.0.s.addr.040.i.i.reload470, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1508

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem471.0.load, ptr %i.1.i.i.reg2mem467, align 4
  br label %if.end21.i.i, !dbg !1508

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem469.0.s.addr.040.i.i.reload470, i64 1, !dbg !1509
  %6 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !1509, !tbaa !436
  %cmp13.i.i = icmp eq i8 %6, 37, !dbg !1510
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1511

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem471.0.load, ptr %i.1.i.i.reg2mem467, align 4
  br label %if.end21.i.i, !dbg !1511

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem469.0.s.addr.040.i.i.reload470, i64 2, !dbg !1512
  %7 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1512, !tbaa !436
  %cmp18.i.i = icmp eq i8 %7, 10, !dbg !1513
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1514
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem471.0.load, %inc.i.i, !dbg !1514
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem467, align 4
  br label %if.end21.i.i, !dbg !1514

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem467.0.load, !432, !DIExpression(), !1505)
  %i.1.i.i.reg2mem467.0.load = load i32, ptr %i.1.i.i.reg2mem467, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem469.0.s.addr.040.i.i.reload470, i64 1, !dbg !1515
    #dbg_value(ptr %incdec.ptr.i.i, !426, !DIExpression(), !1505)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem467.0.load, 1, !dbg !1516
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1517, !llvm.loop !1518

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem469, align 8
  store i32 %i.1.i.i.reg2mem467.0.load, ptr %i.041.i.i.reg2mem471, align 4
  br label %land.rhs.i.i, !dbg !1517

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1520, !tbaa !436
  %8 = icmp eq i8 %.pre.i.i, 0, !dbg !1521
  %9 = select i1 %8, i64 0, i64 2, !dbg !1522
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1517

output_to_data.exit:                              ; preds = %land.rhs.i.i.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1522
    #dbg_value(ptr %spec.select38.i.i, !531, !DIExpression(), !1502)
  %prod.i6 = getelementptr inbounds i8, ptr %call30, i64 65536, !dbg !1523
  %call2.i = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i.i, ptr noundef nonnull %prod.i6, i32 noundef signext 4096) #19, !dbg !1524
  tail call void @free(ptr noundef %call.i) #19, !dbg !1525
    #dbg_value(ptr %call, !578, !DIExpression(), !1526)
    #dbg_value(ptr %call30, !579, !DIExpression(), !1526)
    #dbg_value(ptr %call, !580, !DIExpression(), !1526)
    #dbg_value(ptr %call30, !581, !DIExpression(), !1526)
    #dbg_value(i32 0, !582, !DIExpression(), !1526)
    #dbg_value(i32 0, !583, !DIExpression(), !1526)
  store i32 0, ptr %has_errors.025.i.reg2mem463, align 4
  store i64 0, ptr %indvars.iv27.i.reg2mem465, align 8
  br label %for.cond1.preheader.i, !dbg !1529

for.cond1.preheader.i:                            ; preds = %for.inc11.i.for.cond1.preheader.i_crit_edge, %output_to_data.exit
    #dbg_value(i32 %has_errors.025.i.reg2mem463.0.load, !582, !DIExpression(), !1526)
    #dbg_value(i64 %indvars.iv27.i.reg2mem465.0.load, !583, !DIExpression(), !1526)
  %indvars.iv27.i.reg2mem465.0.load = load i64, ptr %indvars.iv27.i.reg2mem465, align 8
  %has_errors.025.i.reg2mem463.0.load = load i32, ptr %has_errors.025.i.reg2mem463, align 4
  %10 = shl nuw nsw i64 %indvars.iv27.i.reg2mem465.0.load, 6
    #dbg_value(i32 0, !584, !DIExpression(), !1526)
  store i32 %has_errors.025.i.reg2mem463.0.load, ptr %has_errors.123.i.reg2mem, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body3.i, !dbg !1530

for.body3.i:                                      ; preds = %for.body3.i.for.body3.i_crit_edge, %for.cond1.preheader.i
    #dbg_value(i32 %has_errors.123.i.reg2mem.0.load, !582, !DIExpression(), !1526)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !584, !DIExpression(), !1526)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %has_errors.123.i.reg2mem.0.load = load i32, ptr %has_errors.123.i.reg2mem, align 4
  %11 = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, %10, !dbg !1531
  %call.reg2mem.0.call.reload421 = load ptr, ptr %call.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds %struct.bench_args_t, ptr %call.reg2mem.0.call.reload421, i64 0, i32 2, i64 %11, !dbg !1532
  %12 = load double, ptr %arrayidx.i, align 8, !dbg !1532, !tbaa !360
  %arrayidx8.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 2, i64 %11, !dbg !1533
  %13 = load double, ptr %arrayidx8.i, align 8, !dbg !1533, !tbaa !360
  %sub.i = fsub double %12, %13, !dbg !1534
    #dbg_value(double %sub.i, !585, !DIExpression(), !1526)
  %14 = tail call double @llvm.fabs.f64(double %sub.i), !dbg !1535
  %15 = fcmp ogt double %14, 0x3EB0C6F7A0B5ED8D, !dbg !1535
  %lor.ext.i = zext i1 %15 to i32, !dbg !1535
  %or.i = or i32 %has_errors.123.i.reg2mem.0.load, %lor.ext.i, !dbg !1536
    #dbg_value(i32 %or.i, !582, !DIExpression(), !1526)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1537
    #dbg_value(i64 %indvars.iv.next.i, !584, !DIExpression(), !1526)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 64, !dbg !1538
  br i1 %exitcond.not.i, label %for.inc11.i, label %for.body3.i.for.body3.i_crit_edge, !dbg !1530, !llvm.loop !1539

for.body3.i.for.body3.i_crit_edge:                ; preds = %for.body3.i
  store i32 %or.i, ptr %has_errors.123.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body3.i, !dbg !1530

for.inc11.i:                                      ; preds = %for.body3.i
  %indvars.iv.next28.i = add nuw nsw i64 %indvars.iv27.i.reg2mem465.0.load, 1, !dbg !1541
    #dbg_value(i32 %or.i, !582, !DIExpression(), !1526)
    #dbg_value(i64 %indvars.iv.next28.i, !583, !DIExpression(), !1526)
  %exitcond30.not.i = icmp eq i64 %indvars.iv.next28.i, 64, !dbg !1542
  br i1 %exitcond30.not.i, label %check_data.exit, label %for.inc11.i.for.cond1.preheader.i_crit_edge, !dbg !1529, !llvm.loop !1543

for.inc11.i.for.cond1.preheader.i_crit_edge:      ; preds = %for.inc11.i
  store i32 %or.i, ptr %has_errors.025.i.reg2mem463, align 4
  store i64 %indvars.iv.next28.i, ptr %indvars.iv27.i.reg2mem465, align 8
  br label %for.cond1.preheader.i, !dbg !1529

check_data.exit:                                  ; preds = %for.inc11.i
  %tobool.not.i.not = icmp eq i32 %or.i, 0, !dbg !1545
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1546

if.then45:                                        ; preds = %check_data.exit
  %16 = load ptr, ptr @stderr, align 8, !dbg !1547, !tbaa !795
  %17 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %16) #22, !dbg !1549
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1550

if.end47:                                         ; preds = %check_data.exit
  %call.reg2mem.0.call.reload424 = load ptr, ptr %call.reg2mem, align 8
  tail call void @free(ptr noundef nonnull %call.reg2mem.0.call.reload424) #19, !dbg !1551
  tail call void @free(ptr noundef nonnull %call30) #19, !dbg !1552
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1553
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1554

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1555

polly.loop_preheader:                             ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #19, !dbg !1556
    #dbg_value(ptr %call, !400, !DIExpression(), !1557)
    #dbg_value(ptr %call, !401, !DIExpression(), !1557)
  %m2.i = getelementptr i8, ptr %call, i64 32768, !dbg !1559
    #dbg_value(ptr %call, !330, !DIExpression(), !1560)
    #dbg_value(ptr %m2.i, !331, !DIExpression(), !1560)
    #dbg_value(ptr %scevgep93, !332, !DIExpression(), !1560)
    #dbg_label(!339, !1562)
    #dbg_value(i32 0, !333, !DIExpression(), !1560)
  store ptr %m2.i, ptr %m2.i.reg2mem, align 8
  %scevgep93 = getelementptr i8, ptr %call, i64 65536
  store ptr %scevgep93, ptr %scevgep93.reg2mem, align 8
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(32768) %scevgep93, i8 0, i64 32768, i1 false)
  store i64 0, ptr %polly.indvar52.reg2mem433, align 8
  br label %polly.loop_preheader56

polly.loop_preheader56.1:                         ; preds = %polly.loop_exit57.polly.loop_preheader56.1_crit_edge, %polly.loop_exit57.1.polly.loop_preheader56.1_crit_edge
  %polly.indvar52.1.reg2mem461.0.load = load i64, ptr %polly.indvar52.1.reg2mem461, align 8
  store i64 %polly.indvar52.1.reg2mem461.0.load, ptr %polly.indvar52.1.reg2mem, align 8
  %.idx75.1 = shl i64 %polly.indvar52.1.reg2mem461.0.load, 9
  %gep87.1 = getelementptr i8, ptr %scevgep93, i64 %.idx75.1
  store ptr %gep87.1, ptr %gep87.1.reg2mem, align 8
  %18 = getelementptr i8, ptr %call, i64 %.idx75.1
  store ptr %18, ptr %.reg2mem375, align 8
  store i64 0, ptr %polly.indvar58.1.reg2mem459, align 8
  br label %polly.loop_preheader62.1

polly.loop_preheader62.1:                         ; preds = %polly.loop_exit63.1.polly.loop_preheader62.1_crit_edge, %polly.loop_preheader56.1
  %polly.indvar58.1.reg2mem459.0.load = load i64, ptr %polly.indvar58.1.reg2mem459, align 8
  store i64 %polly.indvar58.1.reg2mem459.0.load, ptr %polly.indvar58.1.reg2mem, align 8
  %gep85.1 = getelementptr double, ptr %gep87.1, i64 %polly.indvar58.1.reg2mem459.0.load
  store ptr %gep85.1, ptr %gep85.1.reg2mem, align 8
  %19 = shl i64 %polly.indvar58.1.reg2mem459.0.load, 3
  %invariant.gep.1 = getelementptr i8, ptr %m2.i, i64 %19
  store ptr %invariant.gep.1, ptr %invariant.gep.1.reg2mem, align 8
  %polly.access.call67.promoted.1 = load double, ptr %gep85.1, align 8
  store double %polly.access.call67.promoted.1, ptr %polly.access.call67.promoted.1.reg2mem, align 8
  store i64 0, ptr %polly.indvar64.1.reg2mem, align 8
  store double %polly.access.call67.promoted.1, ptr %p_add12.i.i83.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1

polly.stmt.for.body6.i.i.1:                       ; preds = %polly.stmt.for.body6.i.i.1.polly.stmt.for.body6.i.i.1_crit_edge, %polly.loop_preheader62.1
  %p_add12.i.i83.1.reg2mem.0.p_add12.i.i83.1.reload = load double, ptr %p_add12.i.i83.1.reg2mem, align 8
  %polly.indvar64.1.reg2mem.0.load = load i64, ptr %polly.indvar64.1.reg2mem, align 8
  %20 = add nuw nsw i64 %polly.indvar64.1.reg2mem.0.load, 32
  %21 = shl i64 %20, 3
  %scevgep.1 = getelementptr i8, ptr %18, i64 %21
  %_p_scalar_.1 = load double, ptr %scevgep.1, align 8, !alias.scope !1563, !noalias !410
  %22 = shl i64 %20, 9
  %gep82.1 = getelementptr i8, ptr %invariant.gep.1, i64 %22
  %_p_scalar_70.1 = load double, ptr %gep82.1, align 8, !alias.scope !1563, !noalias !410
  %p_mul11.i.i.1 = fmul double %_p_scalar_.1, %_p_scalar_70.1, !dbg !1566
  %p_add12.i.i.1 = fadd double %p_add12.i.i83.1.reg2mem.0.p_add12.i.i83.1.reload, %p_mul11.i.i.1, !dbg !1567
  store double %p_add12.i.i.1, ptr %p_add12.i.i.1.reg2mem, align 8
  store double %p_add12.i.i.1, ptr %gep85.1, align 8, !alias.scope !1563, !noalias !410
  %polly.indvar_next65.1 = add nuw nsw i64 %polly.indvar64.1.reg2mem.0.load, 1
  store i64 %polly.indvar_next65.1, ptr %polly.indvar_next65.1.reg2mem, align 8
  %exitcond.1.not = icmp eq i64 %polly.indvar_next65.1, 32
  br i1 %exitcond.1.not, label %polly.loop_exit63.1, label %polly.stmt.for.body6.i.i.1.polly.stmt.for.body6.i.i.1_crit_edge

polly.stmt.for.body6.i.i.1.polly.stmt.for.body6.i.i.1_crit_edge: ; preds = %polly.stmt.for.body6.i.i.1
  store i64 %polly.indvar_next65.1, ptr %polly.indvar64.1.reg2mem, align 8
  store double %p_add12.i.i.1, ptr %p_add12.i.i83.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1

polly.loop_exit63.1:                              ; preds = %polly.stmt.for.body6.i.i.1
  %polly.indvar_next59.1 = add nuw nsw i64 %polly.indvar58.1.reg2mem459.0.load, 1
  store i64 %polly.indvar_next59.1, ptr %polly.indvar_next59.1.reg2mem, align 8
  %exitcond193.1.not = icmp eq i64 %polly.indvar_next59.1, 32
  br i1 %exitcond193.1.not, label %polly.loop_exit57.1, label %polly.loop_exit63.1.polly.loop_preheader62.1_crit_edge

polly.loop_exit63.1.polly.loop_preheader62.1_crit_edge: ; preds = %polly.loop_exit63.1
  store i64 %polly.indvar_next59.1, ptr %polly.indvar58.1.reg2mem459, align 8
  br label %polly.loop_preheader62.1

polly.loop_exit57.1:                              ; preds = %polly.loop_exit63.1
  %polly.indvar_next53.1 = add nuw nsw i64 %polly.indvar52.1.reg2mem461.0.load, 1
  store i64 %polly.indvar_next53.1, ptr %polly.indvar_next53.1.reg2mem, align 8
  %exitcond194.1.not = icmp eq i64 %polly.indvar_next53.1, 32
  br i1 %exitcond194.1.not, label %polly.loop_exit51.1, label %polly.loop_exit57.1.polly.loop_preheader56.1_crit_edge

polly.loop_exit57.1.polly.loop_preheader56.1_crit_edge: ; preds = %polly.loop_exit57.1
  store i64 %polly.indvar_next53.1, ptr %polly.indvar52.1.reg2mem461, align 8
  br label %polly.loop_preheader56.1

polly.loop_exit51.1:                              ; preds = %polly.loop_exit57.1
  %gep89.1 = getelementptr i8, ptr %call, i64 65792
  store ptr %gep89.1, ptr %gep89.1.reg2mem, align 8
  %invariant.gep278 = getelementptr i8, ptr %call, i64 33024
  store ptr %invariant.gep278, ptr %invariant.gep278.reg2mem, align 8
  store i64 0, ptr %polly.indvar52.1195.reg2mem457, align 8
  br label %polly.loop_preheader56.1198

polly.loop_preheader56.1198:                      ; preds = %polly.loop_exit57.1220.polly.loop_preheader56.1198_crit_edge, %polly.loop_exit51.1
  %polly.indvar52.1195.reg2mem457.0.load = load i64, ptr %polly.indvar52.1195.reg2mem457, align 8
  store i64 %polly.indvar52.1195.reg2mem457.0.load, ptr %polly.indvar52.1195.reg2mem, align 8
  %.idx75.1196 = shl i64 %polly.indvar52.1195.reg2mem457.0.load, 9
  %gep87.1197 = getelementptr i8, ptr %gep89.1, i64 %.idx75.1196
  store ptr %gep87.1197, ptr %gep87.1197.reg2mem, align 8
  %call.reg2mem.0.call.reload417 = load ptr, ptr %call.reg2mem, align 8
  %23 = getelementptr i8, ptr %call.reg2mem.0.call.reload417, i64 %.idx75.1196
  store ptr %23, ptr %.reg2mem364, align 8
  store i64 0, ptr %polly.indvar58.1199.reg2mem455, align 8
  br label %polly.loop_preheader62.1203

polly.loop_preheader62.1203:                      ; preds = %polly.loop_exit63.1217.polly.loop_preheader62.1203_crit_edge, %polly.loop_preheader56.1198
  %polly.indvar58.1199.reg2mem455.0.load = load i64, ptr %polly.indvar58.1199.reg2mem455, align 8
  store i64 %polly.indvar58.1199.reg2mem455.0.load, ptr %polly.indvar58.1199.reg2mem, align 8
  %gep85.1200 = getelementptr double, ptr %gep87.1197, i64 %polly.indvar58.1199.reg2mem455.0.load
  store ptr %gep85.1200, ptr %gep85.1200.reg2mem, align 8
  %24 = shl i64 %polly.indvar58.1199.reg2mem455.0.load, 3
  %gep = getelementptr i8, ptr %invariant.gep278, i64 %24
  store ptr %gep, ptr %gep.reg2mem, align 8
  %polly.access.call67.promoted.1202 = load double, ptr %gep85.1200, align 8
  store double %polly.access.call67.promoted.1202, ptr %polly.access.call67.promoted.1202.reg2mem, align 8
  store i64 0, ptr %polly.indvar64.1205.reg2mem, align 8
  store double %polly.access.call67.promoted.1202, ptr %p_add12.i.i83.1204.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1214

polly.stmt.for.body6.i.i.1214:                    ; preds = %polly.stmt.for.body6.i.i.1214.polly.stmt.for.body6.i.i.1214_crit_edge, %polly.loop_preheader62.1203
  %p_add12.i.i83.1204.reg2mem.0.p_add12.i.i83.1204.reload = load double, ptr %p_add12.i.i83.1204.reg2mem, align 8
  %polly.indvar64.1205.reg2mem.0.load = load i64, ptr %polly.indvar64.1205.reg2mem, align 8
  %25 = shl i64 %polly.indvar64.1205.reg2mem.0.load, 3
  %scevgep.1206 = getelementptr i8, ptr %23, i64 %25
  %_p_scalar_.1207 = load double, ptr %scevgep.1206, align 8, !alias.scope !1563, !noalias !410
  %26 = shl i64 %polly.indvar64.1205.reg2mem.0.load, 9
  %gep82.1208 = getelementptr i8, ptr %gep, i64 %26
  %_p_scalar_70.1209 = load double, ptr %gep82.1208, align 8, !alias.scope !1563, !noalias !410
  %p_mul11.i.i.1210 = fmul double %_p_scalar_.1207, %_p_scalar_70.1209, !dbg !1566
  %p_add12.i.i.1211 = fadd double %p_add12.i.i83.1204.reg2mem.0.p_add12.i.i83.1204.reload, %p_mul11.i.i.1210, !dbg !1567
  store double %p_add12.i.i.1211, ptr %p_add12.i.i.1211.reg2mem, align 8
  store double %p_add12.i.i.1211, ptr %gep85.1200, align 8, !alias.scope !1563, !noalias !410
  %polly.indvar_next65.1212 = add nuw nsw i64 %polly.indvar64.1205.reg2mem.0.load, 1
  store i64 %polly.indvar_next65.1212, ptr %polly.indvar_next65.1212.reg2mem, align 8
  %exitcond.1213.not = icmp eq i64 %polly.indvar_next65.1212, 32
  br i1 %exitcond.1213.not, label %polly.loop_exit63.1217, label %polly.stmt.for.body6.i.i.1214.polly.stmt.for.body6.i.i.1214_crit_edge

polly.stmt.for.body6.i.i.1214.polly.stmt.for.body6.i.i.1214_crit_edge: ; preds = %polly.stmt.for.body6.i.i.1214
  store i64 %polly.indvar_next65.1212, ptr %polly.indvar64.1205.reg2mem, align 8
  store double %p_add12.i.i.1211, ptr %p_add12.i.i83.1204.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1214

polly.loop_exit63.1217:                           ; preds = %polly.stmt.for.body6.i.i.1214
  %polly.indvar_next59.1215 = add nuw nsw i64 %polly.indvar58.1199.reg2mem455.0.load, 1
  store i64 %polly.indvar_next59.1215, ptr %polly.indvar_next59.1215.reg2mem, align 8
  %exitcond193.1216.not = icmp eq i64 %polly.indvar_next59.1215, 32
  br i1 %exitcond193.1216.not, label %polly.loop_exit57.1220, label %polly.loop_exit63.1217.polly.loop_preheader62.1203_crit_edge

polly.loop_exit63.1217.polly.loop_preheader62.1203_crit_edge: ; preds = %polly.loop_exit63.1217
  store i64 %polly.indvar_next59.1215, ptr %polly.indvar58.1199.reg2mem455, align 8
  br label %polly.loop_preheader62.1203

polly.loop_exit57.1220:                           ; preds = %polly.loop_exit63.1217
  %polly.indvar_next53.1218 = add nuw nsw i64 %polly.indvar52.1195.reg2mem457.0.load, 1
  store i64 %polly.indvar_next53.1218, ptr %polly.indvar_next53.1218.reg2mem, align 8
  %exitcond194.1219.not = icmp eq i64 %polly.indvar_next53.1218, 32
  br i1 %exitcond194.1219.not, label %polly.loop_exit51.1221, label %polly.loop_exit57.1220.polly.loop_preheader56.1198_crit_edge

polly.loop_exit57.1220.polly.loop_preheader56.1198_crit_edge: ; preds = %polly.loop_exit57.1220
  store i64 %polly.indvar_next53.1218, ptr %polly.indvar52.1195.reg2mem457, align 8
  br label %polly.loop_preheader56.1198

polly.loop_exit51.1221:                           ; preds = %polly.loop_exit57.1220
  %call.reg2mem.0.call.reload410 = load ptr, ptr %call.reg2mem, align 8
  %invariant.gep279 = getelementptr i8, ptr %call.reg2mem.0.call.reload410, i64 33024
  store ptr %invariant.gep279, ptr %invariant.gep279.reg2mem, align 8
  store i64 0, ptr %polly.indvar52.1.1.reg2mem453, align 8
  br label %polly.loop_preheader56.1.1

polly.loop_preheader56.1.1:                       ; preds = %polly.loop_exit57.1.1.polly.loop_preheader56.1.1_crit_edge, %polly.loop_exit51.1221
  %polly.indvar52.1.1.reg2mem453.0.load = load i64, ptr %polly.indvar52.1.1.reg2mem453, align 8
  store i64 %polly.indvar52.1.1.reg2mem453.0.load, ptr %polly.indvar52.1.1.reg2mem, align 8
  %.idx75.1.1 = shl i64 %polly.indvar52.1.1.reg2mem453.0.load, 9
  %gep87.1.1 = getelementptr i8, ptr %gep89.1, i64 %.idx75.1.1
  store ptr %gep87.1.1, ptr %gep87.1.1.reg2mem, align 8
  %call.reg2mem.0.call.reload418 = load ptr, ptr %call.reg2mem, align 8
  %27 = getelementptr i8, ptr %call.reg2mem.0.call.reload418, i64 %.idx75.1.1
  store ptr %27, ptr %.reg2mem354, align 8
  store i64 0, ptr %polly.indvar58.1.1.reg2mem451, align 8
  br label %polly.loop_preheader62.1.1

polly.loop_preheader62.1.1:                       ; preds = %polly.loop_exit63.1.1.polly.loop_preheader62.1.1_crit_edge, %polly.loop_preheader56.1.1
  %polly.indvar58.1.1.reg2mem451.0.load = load i64, ptr %polly.indvar58.1.1.reg2mem451, align 8
  store i64 %polly.indvar58.1.1.reg2mem451.0.load, ptr %polly.indvar58.1.1.reg2mem, align 8
  %gep85.1.1 = getelementptr double, ptr %gep87.1.1, i64 %polly.indvar58.1.1.reg2mem451.0.load
  store ptr %gep85.1.1, ptr %gep85.1.1.reg2mem, align 8
  %28 = shl i64 %polly.indvar58.1.1.reg2mem451.0.load, 3
  %gep280 = getelementptr i8, ptr %invariant.gep279, i64 %28
  store ptr %gep280, ptr %gep280.reg2mem, align 8
  %polly.access.call67.promoted.1.1 = load double, ptr %gep85.1.1, align 8
  store double %polly.access.call67.promoted.1.1, ptr %polly.access.call67.promoted.1.1.reg2mem, align 8
  store i64 0, ptr %polly.indvar64.1.1.reg2mem, align 8
  store double %polly.access.call67.promoted.1.1, ptr %p_add12.i.i83.1.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1.1

polly.stmt.for.body6.i.i.1.1:                     ; preds = %polly.stmt.for.body6.i.i.1.1.polly.stmt.for.body6.i.i.1.1_crit_edge, %polly.loop_preheader62.1.1
  %p_add12.i.i83.1.1.reg2mem.0.p_add12.i.i83.1.1.reload = load double, ptr %p_add12.i.i83.1.1.reg2mem, align 8
  %polly.indvar64.1.1.reg2mem.0.load = load i64, ptr %polly.indvar64.1.1.reg2mem, align 8
  %29 = add nuw nsw i64 %polly.indvar64.1.1.reg2mem.0.load, 32
  %30 = shl i64 %29, 3
  %scevgep.1.1 = getelementptr i8, ptr %27, i64 %30
  %_p_scalar_.1.1 = load double, ptr %scevgep.1.1, align 8, !alias.scope !1563, !noalias !410
  %31 = shl i64 %29, 9
  %gep82.1.1 = getelementptr i8, ptr %gep280, i64 %31
  %_p_scalar_70.1.1 = load double, ptr %gep82.1.1, align 8, !alias.scope !1563, !noalias !410
  %p_mul11.i.i.1.1 = fmul double %_p_scalar_.1.1, %_p_scalar_70.1.1, !dbg !1566
  %p_add12.i.i.1.1 = fadd double %p_add12.i.i83.1.1.reg2mem.0.p_add12.i.i83.1.1.reload, %p_mul11.i.i.1.1, !dbg !1567
  store double %p_add12.i.i.1.1, ptr %p_add12.i.i.1.1.reg2mem, align 8
  store double %p_add12.i.i.1.1, ptr %gep85.1.1, align 8, !alias.scope !1563, !noalias !410
  %polly.indvar_next65.1.1 = add nuw nsw i64 %polly.indvar64.1.1.reg2mem.0.load, 1
  store i64 %polly.indvar_next65.1.1, ptr %polly.indvar_next65.1.1.reg2mem, align 8
  %exitcond.1.1.not = icmp eq i64 %polly.indvar_next65.1.1, 32
  br i1 %exitcond.1.1.not, label %polly.loop_exit63.1.1, label %polly.stmt.for.body6.i.i.1.1.polly.stmt.for.body6.i.i.1.1_crit_edge

polly.stmt.for.body6.i.i.1.1.polly.stmt.for.body6.i.i.1.1_crit_edge: ; preds = %polly.stmt.for.body6.i.i.1.1
  store i64 %polly.indvar_next65.1.1, ptr %polly.indvar64.1.1.reg2mem, align 8
  store double %p_add12.i.i.1.1, ptr %p_add12.i.i83.1.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1.1

polly.loop_exit63.1.1:                            ; preds = %polly.stmt.for.body6.i.i.1.1
  %polly.indvar_next59.1.1 = add nuw nsw i64 %polly.indvar58.1.1.reg2mem451.0.load, 1
  store i64 %polly.indvar_next59.1.1, ptr %polly.indvar_next59.1.1.reg2mem, align 8
  %exitcond193.1.1.not = icmp eq i64 %polly.indvar_next59.1.1, 32
  br i1 %exitcond193.1.1.not, label %polly.loop_exit57.1.1, label %polly.loop_exit63.1.1.polly.loop_preheader62.1.1_crit_edge

polly.loop_exit63.1.1.polly.loop_preheader62.1.1_crit_edge: ; preds = %polly.loop_exit63.1.1
  store i64 %polly.indvar_next59.1.1, ptr %polly.indvar58.1.1.reg2mem451, align 8
  br label %polly.loop_preheader62.1.1

polly.loop_exit57.1.1:                            ; preds = %polly.loop_exit63.1.1
  %polly.indvar_next53.1.1 = add nuw nsw i64 %polly.indvar52.1.1.reg2mem453.0.load, 1
  store i64 %polly.indvar_next53.1.1, ptr %polly.indvar_next53.1.1.reg2mem, align 8
  %exitcond194.1.1.not = icmp eq i64 %polly.indvar_next53.1.1, 32
  br i1 %exitcond194.1.1.not, label %polly.loop_exit51.1.1, label %polly.loop_exit57.1.1.polly.loop_preheader56.1.1_crit_edge

polly.loop_exit57.1.1.polly.loop_preheader56.1.1_crit_edge: ; preds = %polly.loop_exit57.1.1
  store i64 %polly.indvar_next53.1.1, ptr %polly.indvar52.1.1.reg2mem453, align 8
  br label %polly.loop_preheader56.1.1

polly.loop_exit51.1.1:                            ; preds = %polly.loop_exit57.1.1
  %call.reg2mem.0.call.reload413 = load ptr, ptr %call.reg2mem, align 8
  %gep91.1 = getelementptr i8, ptr %call.reg2mem.0.call.reload413, i64 81920
  store ptr %gep91.1, ptr %gep91.1.reg2mem, align 8
  %call.reg2mem.0.call.reload419 = load ptr, ptr %call.reg2mem, align 8
  %32 = getelementptr i8, ptr %call.reg2mem.0.call.reload419, i64 16384
  store ptr %32, ptr %.reg2mem341, align 8
  store i64 0, ptr %polly.indvar52.1223.reg2mem449, align 8
  br label %polly.loop_preheader56.1226

polly.loop_preheader56.1226:                      ; preds = %polly.loop_exit57.1248.polly.loop_preheader56.1226_crit_edge, %polly.loop_exit51.1.1
  %polly.indvar52.1223.reg2mem449.0.load = load i64, ptr %polly.indvar52.1223.reg2mem449, align 8
  store i64 %polly.indvar52.1223.reg2mem449.0.load, ptr %polly.indvar52.1223.reg2mem, align 8
  %.idx75.1224 = shl i64 %polly.indvar52.1223.reg2mem449.0.load, 9
  %gep87.1225 = getelementptr i8, ptr %gep91.1, i64 %.idx75.1224
  store ptr %gep87.1225, ptr %gep87.1225.reg2mem, align 8
  %33 = getelementptr i8, ptr %32, i64 %.idx75.1224
  store ptr %33, ptr %.reg2mem338, align 8
  store i64 0, ptr %polly.indvar58.1227.reg2mem447, align 8
  br label %polly.loop_preheader62.1231

polly.loop_preheader62.1231:                      ; preds = %polly.loop_exit63.1245.polly.loop_preheader62.1231_crit_edge, %polly.loop_preheader56.1226
  %polly.indvar58.1227.reg2mem447.0.load = load i64, ptr %polly.indvar58.1227.reg2mem447, align 8
  store i64 %polly.indvar58.1227.reg2mem447.0.load, ptr %polly.indvar58.1227.reg2mem, align 8
  %gep85.1228 = getelementptr double, ptr %gep87.1225, i64 %polly.indvar58.1227.reg2mem447.0.load
  store ptr %gep85.1228, ptr %gep85.1228.reg2mem, align 8
  %34 = shl i64 %polly.indvar58.1227.reg2mem447.0.load, 3
  %m2.i.reg2mem.0.m2.i.reload381 = load ptr, ptr %m2.i.reg2mem, align 8
  %invariant.gep.1229 = getelementptr i8, ptr %m2.i.reg2mem.0.m2.i.reload381, i64 %34
  store ptr %invariant.gep.1229, ptr %invariant.gep.1229.reg2mem, align 8
  %polly.access.call67.promoted.1230 = load double, ptr %gep85.1228, align 8
  store double %polly.access.call67.promoted.1230, ptr %polly.access.call67.promoted.1230.reg2mem, align 8
  store i64 0, ptr %polly.indvar64.1233.reg2mem, align 8
  store double %polly.access.call67.promoted.1230, ptr %p_add12.i.i83.1232.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1242

polly.stmt.for.body6.i.i.1242:                    ; preds = %polly.stmt.for.body6.i.i.1242.polly.stmt.for.body6.i.i.1242_crit_edge, %polly.loop_preheader62.1231
  %p_add12.i.i83.1232.reg2mem.0.p_add12.i.i83.1232.reload = load double, ptr %p_add12.i.i83.1232.reg2mem, align 8
  %polly.indvar64.1233.reg2mem.0.load = load i64, ptr %polly.indvar64.1233.reg2mem, align 8
  %35 = shl i64 %polly.indvar64.1233.reg2mem.0.load, 3
  %scevgep.1234 = getelementptr i8, ptr %33, i64 %35
  %_p_scalar_.1235 = load double, ptr %scevgep.1234, align 8, !alias.scope !1563, !noalias !410
  %36 = shl i64 %polly.indvar64.1233.reg2mem.0.load, 9
  %gep82.1236 = getelementptr i8, ptr %invariant.gep.1229, i64 %36
  %_p_scalar_70.1237 = load double, ptr %gep82.1236, align 8, !alias.scope !1563, !noalias !410
  %p_mul11.i.i.1238 = fmul double %_p_scalar_.1235, %_p_scalar_70.1237, !dbg !1566
  %p_add12.i.i.1239 = fadd double %p_add12.i.i83.1232.reg2mem.0.p_add12.i.i83.1232.reload, %p_mul11.i.i.1238, !dbg !1567
  store double %p_add12.i.i.1239, ptr %p_add12.i.i.1239.reg2mem, align 8
  store double %p_add12.i.i.1239, ptr %gep85.1228, align 8, !alias.scope !1563, !noalias !410
  %polly.indvar_next65.1240 = add nuw nsw i64 %polly.indvar64.1233.reg2mem.0.load, 1
  store i64 %polly.indvar_next65.1240, ptr %polly.indvar_next65.1240.reg2mem, align 8
  %exitcond.1241.not = icmp eq i64 %polly.indvar_next65.1240, 32
  br i1 %exitcond.1241.not, label %polly.loop_exit63.1245, label %polly.stmt.for.body6.i.i.1242.polly.stmt.for.body6.i.i.1242_crit_edge

polly.stmt.for.body6.i.i.1242.polly.stmt.for.body6.i.i.1242_crit_edge: ; preds = %polly.stmt.for.body6.i.i.1242
  store i64 %polly.indvar_next65.1240, ptr %polly.indvar64.1233.reg2mem, align 8
  store double %p_add12.i.i.1239, ptr %p_add12.i.i83.1232.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1242

polly.loop_exit63.1245:                           ; preds = %polly.stmt.for.body6.i.i.1242
  %polly.indvar_next59.1243 = add nuw nsw i64 %polly.indvar58.1227.reg2mem447.0.load, 1
  store i64 %polly.indvar_next59.1243, ptr %polly.indvar_next59.1243.reg2mem, align 8
  %exitcond193.1244.not = icmp eq i64 %polly.indvar_next59.1243, 32
  br i1 %exitcond193.1244.not, label %polly.loop_exit57.1248, label %polly.loop_exit63.1245.polly.loop_preheader62.1231_crit_edge

polly.loop_exit63.1245.polly.loop_preheader62.1231_crit_edge: ; preds = %polly.loop_exit63.1245
  store i64 %polly.indvar_next59.1243, ptr %polly.indvar58.1227.reg2mem447, align 8
  br label %polly.loop_preheader62.1231

polly.loop_exit57.1248:                           ; preds = %polly.loop_exit63.1245
  %polly.indvar_next53.1246 = add nuw nsw i64 %polly.indvar52.1223.reg2mem449.0.load, 1
  store i64 %polly.indvar_next53.1246, ptr %polly.indvar_next53.1246.reg2mem, align 8
  %exitcond194.1247.not = icmp eq i64 %polly.indvar_next53.1246, 32
  br i1 %exitcond194.1247.not, label %polly.loop_exit57.1248.polly.loop_preheader56.1.1253_crit_edge, label %polly.loop_exit57.1248.polly.loop_preheader56.1226_crit_edge

polly.loop_exit57.1248.polly.loop_preheader56.1226_crit_edge: ; preds = %polly.loop_exit57.1248
  store i64 %polly.indvar_next53.1246, ptr %polly.indvar52.1223.reg2mem449, align 8
  br label %polly.loop_preheader56.1226

polly.loop_exit57.1248.polly.loop_preheader56.1.1253_crit_edge: ; preds = %polly.loop_exit57.1248
  store i64 0, ptr %polly.indvar52.1.1250.reg2mem445, align 8
  br label %polly.loop_preheader56.1.1253

polly.loop_preheader56.1.1253:                    ; preds = %polly.loop_exit57.1.1275.polly.loop_preheader56.1.1253_crit_edge, %polly.loop_exit57.1248.polly.loop_preheader56.1.1253_crit_edge
  %polly.indvar52.1.1250.reg2mem445.0.load = load i64, ptr %polly.indvar52.1.1250.reg2mem445, align 8
  store i64 %polly.indvar52.1.1250.reg2mem445.0.load, ptr %polly.indvar52.1.1250.reg2mem, align 8
  %.idx75.1.1251 = shl i64 %polly.indvar52.1.1250.reg2mem445.0.load, 9
  %gep87.1.1252 = getelementptr i8, ptr %gep91.1, i64 %.idx75.1.1251
  store ptr %gep87.1.1252, ptr %gep87.1.1252.reg2mem, align 8
  %37 = getelementptr i8, ptr %32, i64 %.idx75.1.1251
  store ptr %37, ptr %.reg2mem328, align 8
  store i64 0, ptr %polly.indvar58.1.1254.reg2mem443, align 8
  br label %polly.loop_preheader62.1.1258

polly.loop_preheader62.1.1258:                    ; preds = %polly.loop_exit63.1.1272.polly.loop_preheader62.1.1258_crit_edge, %polly.loop_preheader56.1.1253
  %polly.indvar58.1.1254.reg2mem443.0.load = load i64, ptr %polly.indvar58.1.1254.reg2mem443, align 8
  store i64 %polly.indvar58.1.1254.reg2mem443.0.load, ptr %polly.indvar58.1.1254.reg2mem, align 8
  %gep85.1.1255 = getelementptr double, ptr %gep87.1.1252, i64 %polly.indvar58.1.1254.reg2mem443.0.load
  store ptr %gep85.1.1255, ptr %gep85.1.1255.reg2mem, align 8
  %38 = shl i64 %polly.indvar58.1.1254.reg2mem443.0.load, 3
  %m2.i.reg2mem.0.m2.i.reload = load ptr, ptr %m2.i.reg2mem, align 8
  %invariant.gep.1.1256 = getelementptr i8, ptr %m2.i.reg2mem.0.m2.i.reload, i64 %38
  store ptr %invariant.gep.1.1256, ptr %invariant.gep.1.1256.reg2mem, align 8
  %polly.access.call67.promoted.1.1257 = load double, ptr %gep85.1.1255, align 8
  store double %polly.access.call67.promoted.1.1257, ptr %polly.access.call67.promoted.1.1257.reg2mem, align 8
  store i64 0, ptr %polly.indvar64.1.1260.reg2mem, align 8
  store double %polly.access.call67.promoted.1.1257, ptr %p_add12.i.i83.1.1259.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1.1269

polly.stmt.for.body6.i.i.1.1269:                  ; preds = %polly.stmt.for.body6.i.i.1.1269.polly.stmt.for.body6.i.i.1.1269_crit_edge, %polly.loop_preheader62.1.1258
  %p_add12.i.i83.1.1259.reg2mem.0.p_add12.i.i83.1.1259.reload = load double, ptr %p_add12.i.i83.1.1259.reg2mem, align 8
  %polly.indvar64.1.1260.reg2mem.0.load = load i64, ptr %polly.indvar64.1.1260.reg2mem, align 8
  %39 = add nuw nsw i64 %polly.indvar64.1.1260.reg2mem.0.load, 32
  %40 = shl i64 %39, 3
  %scevgep.1.1261 = getelementptr i8, ptr %37, i64 %40
  %_p_scalar_.1.1262 = load double, ptr %scevgep.1.1261, align 8, !alias.scope !1563, !noalias !410
  %41 = shl i64 %39, 9
  %gep82.1.1263 = getelementptr i8, ptr %invariant.gep.1.1256, i64 %41
  %_p_scalar_70.1.1264 = load double, ptr %gep82.1.1263, align 8, !alias.scope !1563, !noalias !410
  %p_mul11.i.i.1.1265 = fmul double %_p_scalar_.1.1262, %_p_scalar_70.1.1264, !dbg !1566
  %p_add12.i.i.1.1266 = fadd double %p_add12.i.i83.1.1259.reg2mem.0.p_add12.i.i83.1.1259.reload, %p_mul11.i.i.1.1265, !dbg !1567
  store double %p_add12.i.i.1.1266, ptr %p_add12.i.i.1.1266.reg2mem, align 8
  store double %p_add12.i.i.1.1266, ptr %gep85.1.1255, align 8, !alias.scope !1563, !noalias !410
  %polly.indvar_next65.1.1267 = add nuw nsw i64 %polly.indvar64.1.1260.reg2mem.0.load, 1
  store i64 %polly.indvar_next65.1.1267, ptr %polly.indvar_next65.1.1267.reg2mem, align 8
  %exitcond.1.1268.not = icmp eq i64 %polly.indvar_next65.1.1267, 32
  br i1 %exitcond.1.1268.not, label %polly.loop_exit63.1.1272, label %polly.stmt.for.body6.i.i.1.1269.polly.stmt.for.body6.i.i.1.1269_crit_edge

polly.stmt.for.body6.i.i.1.1269.polly.stmt.for.body6.i.i.1.1269_crit_edge: ; preds = %polly.stmt.for.body6.i.i.1.1269
  store i64 %polly.indvar_next65.1.1267, ptr %polly.indvar64.1.1260.reg2mem, align 8
  store double %p_add12.i.i.1.1266, ptr %p_add12.i.i83.1.1259.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1.1269

polly.loop_exit63.1.1272:                         ; preds = %polly.stmt.for.body6.i.i.1.1269
  %polly.indvar_next59.1.1270 = add nuw nsw i64 %polly.indvar58.1.1254.reg2mem443.0.load, 1
  store i64 %polly.indvar_next59.1.1270, ptr %polly.indvar_next59.1.1270.reg2mem, align 8
  %exitcond193.1.1271.not = icmp eq i64 %polly.indvar_next59.1.1270, 32
  br i1 %exitcond193.1.1271.not, label %polly.loop_exit57.1.1275, label %polly.loop_exit63.1.1272.polly.loop_preheader62.1.1258_crit_edge

polly.loop_exit63.1.1272.polly.loop_preheader62.1.1258_crit_edge: ; preds = %polly.loop_exit63.1.1272
  store i64 %polly.indvar_next59.1.1270, ptr %polly.indvar58.1.1254.reg2mem443, align 8
  br label %polly.loop_preheader62.1.1258

polly.loop_exit57.1.1275:                         ; preds = %polly.loop_exit63.1.1272
  %polly.indvar_next53.1.1273 = add nuw nsw i64 %polly.indvar52.1.1250.reg2mem445.0.load, 1
  store i64 %polly.indvar_next53.1.1273, ptr %polly.indvar_next53.1.1273.reg2mem, align 8
  %exitcond194.1.1274.not = icmp eq i64 %polly.indvar_next53.1.1273, 32
  br i1 %exitcond194.1.1274.not, label %polly.loop_exit51.1.1276, label %polly.loop_exit57.1.1275.polly.loop_preheader56.1.1253_crit_edge

polly.loop_exit57.1.1275.polly.loop_preheader56.1.1253_crit_edge: ; preds = %polly.loop_exit57.1.1275
  store i64 %polly.indvar_next53.1.1273, ptr %polly.indvar52.1.1250.reg2mem445, align 8
  br label %polly.loop_preheader56.1.1253

polly.loop_exit51.1.1276:                         ; preds = %polly.loop_exit57.1.1275
  %call.reg2mem.0.call.reload412 = load ptr, ptr %call.reg2mem, align 8
  %gep89.1.1 = getelementptr i8, ptr %call.reg2mem.0.call.reload412, i64 82176
  %call.reg2mem.0.call.reload409 = load ptr, ptr %call.reg2mem, align 8
  %invariant.gep281 = getelementptr i8, ptr %call.reg2mem.0.call.reload409, i64 33024
  store i64 0, ptr %polly.indvar52.1195.1.reg2mem441, align 8
  br label %polly.loop_preheader56.1198.1

polly.loop_preheader56.1198.1:                    ; preds = %polly.loop_exit57.1220.1.polly.loop_preheader56.1198.1_crit_edge, %polly.loop_exit51.1.1276
  %polly.indvar52.1195.1.reg2mem441.0.load = load i64, ptr %polly.indvar52.1195.1.reg2mem441, align 8
  %.idx75.1196.1 = shl i64 %polly.indvar52.1195.1.reg2mem441.0.load, 9
  %gep87.1197.1 = getelementptr i8, ptr %gep89.1.1, i64 %.idx75.1196.1
  %42 = getelementptr i8, ptr %32, i64 %.idx75.1196.1
  store i64 0, ptr %polly.indvar58.1199.1.reg2mem439, align 8
  br label %polly.loop_preheader62.1203.1

polly.loop_preheader62.1203.1:                    ; preds = %polly.loop_exit63.1217.1.polly.loop_preheader62.1203.1_crit_edge, %polly.loop_preheader56.1198.1
  %polly.indvar58.1199.1.reg2mem439.0.load = load i64, ptr %polly.indvar58.1199.1.reg2mem439, align 8
  %gep85.1200.1 = getelementptr double, ptr %gep87.1197.1, i64 %polly.indvar58.1199.1.reg2mem439.0.load
  %43 = shl i64 %polly.indvar58.1199.1.reg2mem439.0.load, 3
  %gep282 = getelementptr i8, ptr %invariant.gep281, i64 %43
  %polly.access.call67.promoted.1202.1 = load double, ptr %gep85.1200.1, align 8
  store i64 0, ptr %polly.indvar64.1205.1.reg2mem, align 8
  store double %polly.access.call67.promoted.1202.1, ptr %p_add12.i.i83.1204.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1214.1

polly.stmt.for.body6.i.i.1214.1:                  ; preds = %polly.stmt.for.body6.i.i.1214.1.polly.stmt.for.body6.i.i.1214.1_crit_edge, %polly.loop_preheader62.1203.1
  %p_add12.i.i83.1204.1.reg2mem.0.p_add12.i.i83.1204.1.reload = load double, ptr %p_add12.i.i83.1204.1.reg2mem, align 8
  %polly.indvar64.1205.1.reg2mem.0.load = load i64, ptr %polly.indvar64.1205.1.reg2mem, align 8
  %44 = shl i64 %polly.indvar64.1205.1.reg2mem.0.load, 3
  %scevgep.1206.1 = getelementptr i8, ptr %42, i64 %44
  %_p_scalar_.1207.1 = load double, ptr %scevgep.1206.1, align 8, !alias.scope !1563, !noalias !410
  %45 = shl i64 %polly.indvar64.1205.1.reg2mem.0.load, 9
  %gep82.1208.1 = getelementptr i8, ptr %gep282, i64 %45
  %_p_scalar_70.1209.1 = load double, ptr %gep82.1208.1, align 8, !alias.scope !1563, !noalias !410
  %p_mul11.i.i.1210.1 = fmul double %_p_scalar_.1207.1, %_p_scalar_70.1209.1, !dbg !1566
  %p_add12.i.i.1211.1 = fadd double %p_add12.i.i83.1204.1.reg2mem.0.p_add12.i.i83.1204.1.reload, %p_mul11.i.i.1210.1, !dbg !1567
  store double %p_add12.i.i.1211.1, ptr %gep85.1200.1, align 8, !alias.scope !1563, !noalias !410
  %polly.indvar_next65.1212.1 = add nuw nsw i64 %polly.indvar64.1205.1.reg2mem.0.load, 1
  %exitcond.1213.1.not = icmp eq i64 %polly.indvar_next65.1212.1, 32
  br i1 %exitcond.1213.1.not, label %polly.loop_exit63.1217.1, label %polly.stmt.for.body6.i.i.1214.1.polly.stmt.for.body6.i.i.1214.1_crit_edge

polly.stmt.for.body6.i.i.1214.1.polly.stmt.for.body6.i.i.1214.1_crit_edge: ; preds = %polly.stmt.for.body6.i.i.1214.1
  store i64 %polly.indvar_next65.1212.1, ptr %polly.indvar64.1205.1.reg2mem, align 8
  store double %p_add12.i.i.1211.1, ptr %p_add12.i.i83.1204.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1214.1

polly.loop_exit63.1217.1:                         ; preds = %polly.stmt.for.body6.i.i.1214.1
  %polly.indvar_next59.1215.1 = add nuw nsw i64 %polly.indvar58.1199.1.reg2mem439.0.load, 1
  %exitcond193.1216.1.not = icmp eq i64 %polly.indvar_next59.1215.1, 32
  br i1 %exitcond193.1216.1.not, label %polly.loop_exit57.1220.1, label %polly.loop_exit63.1217.1.polly.loop_preheader62.1203.1_crit_edge

polly.loop_exit63.1217.1.polly.loop_preheader62.1203.1_crit_edge: ; preds = %polly.loop_exit63.1217.1
  store i64 %polly.indvar_next59.1215.1, ptr %polly.indvar58.1199.1.reg2mem439, align 8
  br label %polly.loop_preheader62.1203.1

polly.loop_exit57.1220.1:                         ; preds = %polly.loop_exit63.1217.1
  %polly.indvar_next53.1218.1 = add nuw nsw i64 %polly.indvar52.1195.1.reg2mem441.0.load, 1
  %exitcond194.1219.1.not = icmp eq i64 %polly.indvar_next53.1218.1, 32
  br i1 %exitcond194.1219.1.not, label %polly.loop_exit51.1221.1, label %polly.loop_exit57.1220.1.polly.loop_preheader56.1198.1_crit_edge

polly.loop_exit57.1220.1.polly.loop_preheader56.1198.1_crit_edge: ; preds = %polly.loop_exit57.1220.1
  store i64 %polly.indvar_next53.1218.1, ptr %polly.indvar52.1195.1.reg2mem441, align 8
  br label %polly.loop_preheader56.1198.1

polly.loop_exit51.1221.1:                         ; preds = %polly.loop_exit57.1220.1
  %call.reg2mem.0.call.reload = load ptr, ptr %call.reg2mem, align 8
  %invariant.gep283 = getelementptr i8, ptr %call.reg2mem.0.call.reload, i64 33024
  store i64 0, ptr %polly.indvar52.1.1.1.reg2mem437, align 8
  br label %polly.loop_preheader56.1.1.1

polly.loop_preheader56.1.1.1:                     ; preds = %polly.loop_exit57.1.1.1.polly.loop_preheader56.1.1.1_crit_edge, %polly.loop_exit51.1221.1
  %polly.indvar52.1.1.1.reg2mem437.0.load = load i64, ptr %polly.indvar52.1.1.1.reg2mem437, align 8
  %.idx75.1.1.1 = shl i64 %polly.indvar52.1.1.1.reg2mem437.0.load, 9
  %gep87.1.1.1 = getelementptr i8, ptr %gep89.1.1, i64 %.idx75.1.1.1
  %.reg2mem341.0..reload342 = load ptr, ptr %.reg2mem341, align 8
  %46 = getelementptr i8, ptr %.reg2mem341.0..reload342, i64 %.idx75.1.1.1
  store i64 0, ptr %polly.indvar58.1.1.1.reg2mem435, align 8
  br label %polly.loop_preheader62.1.1.1

polly.loop_preheader62.1.1.1:                     ; preds = %polly.loop_exit63.1.1.1.polly.loop_preheader62.1.1.1_crit_edge, %polly.loop_preheader56.1.1.1
  %polly.indvar58.1.1.1.reg2mem435.0.load = load i64, ptr %polly.indvar58.1.1.1.reg2mem435, align 8
  %gep85.1.1.1 = getelementptr double, ptr %gep87.1.1.1, i64 %polly.indvar58.1.1.1.reg2mem435.0.load
  %47 = shl i64 %polly.indvar58.1.1.1.reg2mem435.0.load, 3
  %gep284 = getelementptr i8, ptr %invariant.gep283, i64 %47
  %polly.access.call67.promoted.1.1.1 = load double, ptr %gep85.1.1.1, align 8
  store i64 0, ptr %polly.indvar64.1.1.1.reg2mem, align 8
  store double %polly.access.call67.promoted.1.1.1, ptr %p_add12.i.i83.1.1.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1.1.1

polly.stmt.for.body6.i.i.1.1.1:                   ; preds = %polly.stmt.for.body6.i.i.1.1.1.polly.stmt.for.body6.i.i.1.1.1_crit_edge, %polly.loop_preheader62.1.1.1
  %p_add12.i.i83.1.1.1.reg2mem.0.p_add12.i.i83.1.1.1.reload = load double, ptr %p_add12.i.i83.1.1.1.reg2mem, align 8
  %polly.indvar64.1.1.1.reg2mem.0.load = load i64, ptr %polly.indvar64.1.1.1.reg2mem, align 8
  %48 = add nuw nsw i64 %polly.indvar64.1.1.1.reg2mem.0.load, 32
  %49 = shl i64 %48, 3
  %scevgep.1.1.1 = getelementptr i8, ptr %46, i64 %49
  %_p_scalar_.1.1.1 = load double, ptr %scevgep.1.1.1, align 8, !alias.scope !1563, !noalias !410
  %50 = shl i64 %48, 9
  %gep82.1.1.1 = getelementptr i8, ptr %gep284, i64 %50
  %_p_scalar_70.1.1.1 = load double, ptr %gep82.1.1.1, align 8, !alias.scope !1563, !noalias !410
  %p_mul11.i.i.1.1.1 = fmul double %_p_scalar_.1.1.1, %_p_scalar_70.1.1.1, !dbg !1566
  %p_add12.i.i.1.1.1 = fadd double %p_add12.i.i83.1.1.1.reg2mem.0.p_add12.i.i83.1.1.1.reload, %p_mul11.i.i.1.1.1, !dbg !1567
  store double %p_add12.i.i.1.1.1, ptr %gep85.1.1.1, align 8, !alias.scope !1563, !noalias !410
  %polly.indvar_next65.1.1.1 = add nuw nsw i64 %polly.indvar64.1.1.1.reg2mem.0.load, 1
  %exitcond.1.1.1.not = icmp eq i64 %polly.indvar_next65.1.1.1, 32
  br i1 %exitcond.1.1.1.not, label %polly.loop_exit63.1.1.1, label %polly.stmt.for.body6.i.i.1.1.1.polly.stmt.for.body6.i.i.1.1.1_crit_edge

polly.stmt.for.body6.i.i.1.1.1.polly.stmt.for.body6.i.i.1.1.1_crit_edge: ; preds = %polly.stmt.for.body6.i.i.1.1.1
  store i64 %polly.indvar_next65.1.1.1, ptr %polly.indvar64.1.1.1.reg2mem, align 8
  store double %p_add12.i.i.1.1.1, ptr %p_add12.i.i83.1.1.1.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i.1.1.1

polly.loop_exit63.1.1.1:                          ; preds = %polly.stmt.for.body6.i.i.1.1.1
  %polly.indvar_next59.1.1.1 = add nuw nsw i64 %polly.indvar58.1.1.1.reg2mem435.0.load, 1
  %exitcond193.1.1.1.not = icmp eq i64 %polly.indvar_next59.1.1.1, 32
  br i1 %exitcond193.1.1.1.not, label %polly.loop_exit57.1.1.1, label %polly.loop_exit63.1.1.1.polly.loop_preheader62.1.1.1_crit_edge

polly.loop_exit63.1.1.1.polly.loop_preheader62.1.1.1_crit_edge: ; preds = %polly.loop_exit63.1.1.1
  store i64 %polly.indvar_next59.1.1.1, ptr %polly.indvar58.1.1.1.reg2mem435, align 8
  br label %polly.loop_preheader62.1.1.1

polly.loop_exit57.1.1.1:                          ; preds = %polly.loop_exit63.1.1.1
  %polly.indvar_next53.1.1.1 = add nuw nsw i64 %polly.indvar52.1.1.1.reg2mem437.0.load, 1
  %exitcond194.1.1.1.not = icmp eq i64 %polly.indvar_next53.1.1.1, 32
  br i1 %exitcond194.1.1.1.not, label %polly.loop_exit51.1.1.1, label %polly.loop_exit57.1.1.1.polly.loop_preheader56.1.1.1_crit_edge

polly.loop_exit57.1.1.1.polly.loop_preheader56.1.1.1_crit_edge: ; preds = %polly.loop_exit57.1.1.1
  store i64 %polly.indvar_next53.1.1.1, ptr %polly.indvar52.1.1.1.reg2mem437, align 8
  br label %polly.loop_preheader56.1.1.1

polly.loop_exit51.1.1.1:                          ; preds = %polly.loop_exit57.1.1.1
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #19, !dbg !1568
    #dbg_value(i32 %call21, !1452, !DIExpression(), !1455)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1477
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1477

polly.loop_exit57:                                ; preds = %polly.loop_exit63
  %polly.indvar_next53 = add nuw nsw i64 %polly.indvar52.reg2mem433.0.load, 1
  store i64 %polly.indvar_next53, ptr %polly.indvar_next53.reg2mem, align 8
  %exitcond194.not = icmp eq i64 %polly.indvar_next53, 32
  br i1 %exitcond194.not, label %polly.loop_exit57.polly.loop_preheader56.1_crit_edge, label %polly.loop_exit57.polly.loop_preheader56_crit_edge

polly.loop_exit57.polly.loop_preheader56_crit_edge: ; preds = %polly.loop_exit57
  store i64 %polly.indvar_next53, ptr %polly.indvar52.reg2mem433, align 8
  br label %polly.loop_preheader56

polly.loop_exit57.polly.loop_preheader56.1_crit_edge: ; preds = %polly.loop_exit57
  store i64 0, ptr %polly.indvar52.1.reg2mem461, align 8
  br label %polly.loop_preheader56.1

polly.loop_exit63:                                ; preds = %polly.stmt.for.body6.i.i
  %polly.indvar_next59 = add nuw nsw i64 %polly.indvar58.reg2mem431.0.load, 1
  store i64 %polly.indvar_next59, ptr %polly.indvar_next59.reg2mem, align 8
  %exitcond193.not = icmp eq i64 %polly.indvar_next59, 32
  br i1 %exitcond193.not, label %polly.loop_exit57, label %polly.loop_exit63.polly.loop_preheader62_crit_edge

polly.loop_exit63.polly.loop_preheader62_crit_edge: ; preds = %polly.loop_exit63
  store i64 %polly.indvar_next59, ptr %polly.indvar58.reg2mem431, align 8
  br label %polly.loop_preheader62

polly.loop_preheader56:                           ; preds = %polly.loop_exit57.polly.loop_preheader56_crit_edge, %polly.loop_preheader
  %polly.indvar52.reg2mem433.0.load = load i64, ptr %polly.indvar52.reg2mem433, align 8
  store i64 %polly.indvar52.reg2mem433.0.load, ptr %polly.indvar52.reg2mem, align 8
  %.idx75 = shl i64 %polly.indvar52.reg2mem433.0.load, 9
  %gep87 = getelementptr i8, ptr %scevgep93, i64 %.idx75
  store ptr %gep87, ptr %gep87.reg2mem, align 8
  %51 = getelementptr i8, ptr %call, i64 %.idx75
  store ptr %51, ptr %.reg2mem, align 8
  store i64 0, ptr %polly.indvar58.reg2mem431, align 8
  br label %polly.loop_preheader62

polly.stmt.for.body6.i.i:                         ; preds = %polly.stmt.for.body6.i.i.polly.stmt.for.body6.i.i_crit_edge, %polly.loop_preheader62
  %p_add12.i.i83.reg2mem.0.p_add12.i.i83.reload = load double, ptr %p_add12.i.i83.reg2mem, align 8
  %polly.indvar64.reg2mem.0.load = load i64, ptr %polly.indvar64.reg2mem, align 8
  %52 = shl i64 %polly.indvar64.reg2mem.0.load, 3
  %scevgep = getelementptr i8, ptr %51, i64 %52
  %_p_scalar_ = load double, ptr %scevgep, align 8, !alias.scope !1563, !noalias !410
  %53 = shl i64 %polly.indvar64.reg2mem.0.load, 9
  %gep82 = getelementptr i8, ptr %invariant.gep, i64 %53
  %_p_scalar_70 = load double, ptr %gep82, align 8, !alias.scope !1563, !noalias !410
  %p_mul11.i.i = fmul double %_p_scalar_, %_p_scalar_70, !dbg !1566
  %p_add12.i.i = fadd double %p_add12.i.i83.reg2mem.0.p_add12.i.i83.reload, %p_mul11.i.i, !dbg !1567
  store double %p_add12.i.i, ptr %p_add12.i.i.reg2mem, align 8
  store double %p_add12.i.i, ptr %gep85, align 8, !alias.scope !1563, !noalias !410
  %polly.indvar_next65 = add nuw nsw i64 %polly.indvar64.reg2mem.0.load, 1
  store i64 %polly.indvar_next65, ptr %polly.indvar_next65.reg2mem, align 8
  %exitcond.not = icmp eq i64 %polly.indvar_next65, 32
  br i1 %exitcond.not, label %polly.loop_exit63, label %polly.stmt.for.body6.i.i.polly.stmt.for.body6.i.i_crit_edge

polly.stmt.for.body6.i.i.polly.stmt.for.body6.i.i_crit_edge: ; preds = %polly.stmt.for.body6.i.i
  store i64 %polly.indvar_next65, ptr %polly.indvar64.reg2mem, align 8
  store double %p_add12.i.i, ptr %p_add12.i.i83.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i

polly.loop_preheader62:                           ; preds = %polly.loop_exit63.polly.loop_preheader62_crit_edge, %polly.loop_preheader56
  %polly.indvar58.reg2mem431.0.load = load i64, ptr %polly.indvar58.reg2mem431, align 8
  store i64 %polly.indvar58.reg2mem431.0.load, ptr %polly.indvar58.reg2mem, align 8
  %gep85 = getelementptr double, ptr %gep87, i64 %polly.indvar58.reg2mem431.0.load
  store ptr %gep85, ptr %gep85.reg2mem, align 8
  %54 = shl i64 %polly.indvar58.reg2mem431.0.load, 3
  %invariant.gep = getelementptr i8, ptr %m2.i, i64 %54
  store ptr %invariant.gep, ptr %invariant.gep.reg2mem, align 8
  %polly.access.call67.promoted = load double, ptr %gep85, align 8
  store double %polly.access.call67.promoted, ptr %polly.access.call67.promoted.reg2mem, align 8
  store i64 0, ptr %polly.indvar64.reg2mem, align 8
  store double %polly.access.call67.promoted, ptr %p_add12.i.i83.reg2mem, align 8
  br label %polly.stmt.for.body6.i.i
}

; Function Attrs: nofree
declare !dbg !1569 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #17

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #17

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #18

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "polly-optimized" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }
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
attributes #16 = { nounwind uwtable "no-trapping-math"="true" "polly-optimized" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #17 = { nofree nounwind }
attributes #18 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #19 = { nounwind }
attributes #20 = { noreturn nounwind }
attributes #21 = { nounwind allocsize(0) }
attributes #22 = { cold }
attributes #23 = { nounwind willreturn memory(read) }

!llvm.dbg.cu = !{!225, !188, !227, !292}
!llvm.ident = !{!313, !313, !313, !313}
!llvm.module.flags = !{!314, !315, !316, !317, !318, !320, !321, !322, !323, !324}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/gemm/ncubed")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/gemm/ncubed")
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
!187 = distinct !DIGlobalVariable(name: "INPUT_SIZE", scope: !188, file: !189, line: 4, type: !203, isLocal: false, isDefinition: true)
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !202, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/gemm/ncubed")
!190 = !{!191, !197}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 25, size: 786432, elements: !194)
!193 = !DIFile(filename: "./gemm.h", directory: "/home/kelvin/MachSuite/gemm/ncubed")
!194 = !{!195, !200, !201}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "m1", scope: !192, file: !193, line: 26, baseType: !196, size: 262144)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 262144, elements: !198)
!197 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!198 = !{!199}
!199 = !DISubrange(count: 4096)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "m2", scope: !192, file: !193, line: 27, baseType: !196, size: 262144, offset: 262144)
!201 = !DIDerivedType(tag: DW_TAG_member, name: "prod", scope: !192, file: !193, line: 28, baseType: !196, size: 262144, offset: 524288)
!202 = !{!186}
!203 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!204 = !DIGlobalVariableExpression(var: !205, expr: !DIExpression())
!205 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !206, isLocal: true, isDefinition: true)
!206 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!207 = !DIGlobalVariableExpression(var: !208, expr: !DIExpression())
!208 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !209, isLocal: true, isDefinition: true)
!209 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!210 = !DIGlobalVariableExpression(var: !211, expr: !DIExpression())
!211 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !212, isLocal: true, isDefinition: true)
!212 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !213)
!213 = !{!214}
!214 = !DISubrange(count: 12)
!215 = !DIGlobalVariableExpression(var: !216, expr: !DIExpression())
!216 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !217, isLocal: true, isDefinition: true)
!217 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!218 = !DIGlobalVariableExpression(var: !219, expr: !DIExpression())
!219 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!220 = !DIGlobalVariableExpression(var: !221, expr: !DIExpression())
!221 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !222, isLocal: true, isDefinition: true)
!222 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!223 = !DIGlobalVariableExpression(var: !224, expr: !DIExpression())
!224 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!225 = distinct !DICompileUnit(language: DW_LANG_C11, file: !226, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!226 = !DIFile(filename: "gemm.c", directory: "/home/kelvin/MachSuite/gemm/ncubed")
!227 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !228, globals: !258, splitDebugInlining: false, nameTableKind: None)
!228 = !{!229, !4, !230, !231, !236, !239, !242, !245, !249, !252, !254, !257, !197}
!229 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!230 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!231 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !232, line: 24, baseType: !233)
!232 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!233 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !234, line: 38, baseType: !235)
!234 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!235 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!236 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !232, line: 25, baseType: !237)
!237 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !234, line: 40, baseType: !238)
!238 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!239 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !232, line: 26, baseType: !240)
!240 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !234, line: 42, baseType: !241)
!241 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!242 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !232, line: 27, baseType: !243)
!243 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !234, line: 45, baseType: !244)
!244 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!245 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !246, line: 24, baseType: !247)
!246 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!247 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !234, line: 37, baseType: !248)
!248 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !246, line: 25, baseType: !250)
!250 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !234, line: 39, baseType: !251)
!251 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !246, line: 26, baseType: !253)
!253 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !234, line: 41, baseType: !203)
!254 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !246, line: 27, baseType: !255)
!255 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !234, line: 44, baseType: !256)
!256 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!257 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!258 = !{!259, !0, !7, !12, !264, !18, !266, !23, !271, !28, !273, !33, !38, !275, !43, !45, !47, !52, !57, !62, !67, !69, !71, !76, !78, !80, !82, !87, !89, !280, !92, !97, !102, !107, !112, !114, !116, !121, !126, !128, !130, !132, !134, !136, !141, !146, !148, !153, !285, !158, !163, !287, !165}
!259 = !DIGlobalVariableExpression(var: !260, expr: !DIExpression())
!260 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !261, isLocal: true, isDefinition: true)
!261 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !262)
!262 = !{!263}
!263 = !DISubrange(count: 24)
!264 = !DIGlobalVariableExpression(var: !265, expr: !DIExpression())
!265 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !30, isLocal: true, isDefinition: true)
!266 = !DIGlobalVariableExpression(var: !267, expr: !DIExpression())
!267 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !268, isLocal: true, isDefinition: true)
!268 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !269)
!269 = !{!270}
!270 = !DISubrange(count: 14)
!271 = !DIGlobalVariableExpression(var: !272, expr: !DIExpression())
!272 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !268, isLocal: true, isDefinition: true)
!273 = !DIGlobalVariableExpression(var: !274, expr: !DIExpression())
!274 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !9, isLocal: true, isDefinition: true)
!275 = !DIGlobalVariableExpression(var: !276, expr: !DIExpression())
!276 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !277, isLocal: true, isDefinition: true)
!277 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !278)
!278 = !{!279}
!279 = !DISubrange(count: 21)
!280 = !DIGlobalVariableExpression(var: !281, expr: !DIExpression())
!281 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !282, isLocal: true, isDefinition: true)
!282 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !283)
!283 = !{!284}
!284 = !DISubrange(count: 13)
!285 = !DIGlobalVariableExpression(var: !286, expr: !DIExpression())
!286 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !20, isLocal: true, isDefinition: true)
!287 = !DIGlobalVariableExpression(var: !288, expr: !DIExpression())
!288 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !289, isLocal: true, isDefinition: true)
!289 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !290)
!290 = !{!291}
!291 = !DISubrange(count: 27)
!292 = distinct !DICompileUnit(language: DW_LANG_C11, file: !170, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !293, globals: !294, splitDebugInlining: false, nameTableKind: None)
!293 = !{!230}
!294 = !{!295, !168, !174, !176, !179, !184, !297, !204, !299, !207, !210, !301, !215, !218, !306, !220, !223, !308}
!295 = !DIGlobalVariableExpression(var: !296, expr: !DIExpression())
!296 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !217, isLocal: true, isDefinition: true)
!297 = !DIGlobalVariableExpression(var: !298, expr: !DIExpression())
!298 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !268, isLocal: true, isDefinition: true)
!299 = !DIGlobalVariableExpression(var: !300, expr: !DIExpression())
!300 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !206, isLocal: true, isDefinition: true)
!301 = !DIGlobalVariableExpression(var: !302, expr: !DIExpression())
!302 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !303, isLocal: true, isDefinition: true)
!303 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !304)
!304 = !{!305}
!305 = !DISubrange(count: 31)
!306 = !DIGlobalVariableExpression(var: !307, expr: !DIExpression())
!307 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !206, isLocal: true, isDefinition: true)
!308 = !DIGlobalVariableExpression(var: !309, expr: !DIExpression())
!309 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !310, isLocal: true, isDefinition: true)
!310 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !311)
!311 = !{!312}
!312 = !DISubrange(count: 10)
!313 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!314 = !{i32 7, !"Dwarf Version", i32 4}
!315 = !{i32 2, !"Debug Info Version", i32 3}
!316 = !{i32 1, !"wchar_size", i32 4}
!317 = !{i32 1, !"target-abi", !"lp64d"}
!318 = distinct !{i32 6, !"riscv-isa", !319}
!319 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!320 = !{i32 8, !"PIC Level", i32 2}
!321 = !{i32 7, !"PIE Level", i32 2}
!322 = !{i32 7, !"uwtable", i32 2}
!323 = !{i32 8, !"SmallDataLimit", i32 8}
!324 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!325 = distinct !DISubprogram(name: "gemm", scope: !226, file: !226, line: 3, type: !326, scopeLine: 3, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !225, retainedNodes: !329)
!326 = !DISubroutineType(types: !327)
!327 = !{null, !328, !328, !328}
!328 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!329 = !{!330, !331, !332, !333, !334, !335, !336, !337, !338, !339, !340, !344, !348}
!330 = !DILocalVariable(name: "m1", arg: 1, scope: !325, file: !226, line: 3, type: !328)
!331 = !DILocalVariable(name: "m2", arg: 2, scope: !325, file: !226, line: 3, type: !328)
!332 = !DILocalVariable(name: "prod", arg: 3, scope: !325, file: !226, line: 3, type: !328)
!333 = !DILocalVariable(name: "i", scope: !325, file: !226, line: 4, type: !203)
!334 = !DILocalVariable(name: "j", scope: !325, file: !226, line: 4, type: !203)
!335 = !DILocalVariable(name: "k", scope: !325, file: !226, line: 4, type: !203)
!336 = !DILocalVariable(name: "k_col", scope: !325, file: !226, line: 5, type: !203)
!337 = !DILocalVariable(name: "i_col", scope: !325, file: !226, line: 5, type: !203)
!338 = !DILocalVariable(name: "mult", scope: !325, file: !226, line: 6, type: !197)
!339 = !DILabel(scope: !325, name: "outer", file: !226, line: 8)
!340 = !DILabel(scope: !341, name: "middle", file: !226, line: 9)
!341 = distinct !DILexicalBlock(scope: !342, file: !226, line: 8, column: 35)
!342 = distinct !DILexicalBlock(scope: !343, file: !226, line: 8, column: 11)
!343 = distinct !DILexicalBlock(scope: !325, file: !226, line: 8, column: 11)
!344 = !DILocalVariable(name: "sum", scope: !345, file: !226, line: 11, type: !197)
!345 = distinct !DILexicalBlock(scope: !346, file: !226, line: 9, column: 40)
!346 = distinct !DILexicalBlock(scope: !347, file: !226, line: 9, column: 16)
!347 = distinct !DILexicalBlock(scope: !341, file: !226, line: 9, column: 16)
!348 = !DILabel(scope: !345, name: "inner", file: !226, line: 12)
!349 = !DILocation(line: 0, scope: !325)
!350 = !DILocation(line: 8, column: 5, scope: !325)
!351 = !DILocation(line: 9, column: 16, scope: !347)
!352 = !DILocation(line: 0, scope: !345)
!353 = !DILocation(line: 12, column: 13, scope: !345)
!354 = !DILocation(line: 12, column: 19, scope: !355)
!355 = distinct !DILexicalBlock(scope: !345, file: !226, line: 12, column: 19)
!356 = !DILocation(line: 14, column: 33, scope: !357)
!357 = distinct !DILexicalBlock(scope: !358, file: !226, line: 12, column: 43)
!358 = distinct !DILexicalBlock(scope: !355, file: !226, line: 12, column: 19)
!359 = !DILocation(line: 14, column: 24, scope: !357)
!360 = !{!361, !361, i64 0}
!361 = !{!"double", !362, i64 0}
!362 = !{!"omnipotent char", !363, i64 0}
!363 = !{!"Simple C/C++ TBAA"}
!364 = !DILocation(line: 14, column: 40, scope: !357)
!365 = !DILocation(line: 14, column: 38, scope: !357)
!366 = !DILocation(line: 15, column: 21, scope: !357)
!367 = !DILocation(line: 12, column: 39, scope: !358)
!368 = !DILocation(line: 12, column: 28, scope: !358)
!369 = distinct !{!369, !354, !370, !371, !372}
!370 = !DILocation(line: 16, column: 13, scope: !355)
!371 = !{!"llvm.loop.mustprogress"}
!372 = !{!"llvm.loop.unroll.disable"}
!373 = !DILocation(line: 17, column: 24, scope: !345)
!374 = !DILocation(line: 17, column: 13, scope: !345)
!375 = !DILocation(line: 17, column: 30, scope: !345)
!376 = !DILocation(line: 9, column: 36, scope: !346)
!377 = !DILocation(line: 9, column: 25, scope: !346)
!378 = distinct !{!378, !351, !379, !371, !372}
!379 = !DILocation(line: 18, column: 9, scope: !347)
!380 = !DILocation(line: 8, column: 31, scope: !342)
!381 = !DILocation(line: 8, column: 20, scope: !342)
!382 = !DILocation(line: 8, column: 11, scope: !343)
!383 = distinct !{!383, !382, !384, !371, !372}
!384 = !DILocation(line: 19, column: 5, scope: !343)
!385 = !DILocation(line: 20, column: 1, scope: !325)
!386 = !{!387}
!387 = distinct !{!387, !388, !"polly.alias.scope.MemRef1"}
!388 = distinct !{!388, !"polly.alias.scope.domain"}
!389 = !{!390, !391}
!390 = distinct !{!390, !388, !"polly.alias.scope.MemRef2"}
!391 = distinct !{!391, !388, !"polly.alias.scope.MemRef4"}
!392 = !{!390}
!393 = !{!387, !391}
!394 = !{!391}
!395 = !{!387, !390}
!396 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 8, type: !397, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !399)
!397 = !DISubroutineType(types: !398)
!398 = !{null, !230}
!399 = !{!400, !401}
!400 = !DILocalVariable(name: "vargs", arg: 1, scope: !396, file: !189, line: 8, type: !230)
!401 = !DILocalVariable(name: "args", scope: !396, file: !189, line: 9, type: !191)
!402 = !DILocation(line: 0, scope: !396)
!403 = !DILocation(line: 0, scope: !325, inlinedAt: !404)
!404 = distinct !DILocation(line: 10, column: 3, scope: !396)
!405 = !DILocation(line: 8, column: 5, scope: !325, inlinedAt: !404)
!406 = !DILocation(line: 10, column: 25, scope: !396)
!407 = !{!408}
!408 = distinct !{!408, !409, !"polly.alias.scope.MemRef1"}
!409 = distinct !{!409, !"polly.alias.scope.domain"}
!410 = !{}
!411 = !DILocation(line: 14, column: 38, scope: !357, inlinedAt: !404)
!412 = !DILocation(line: 15, column: 21, scope: !357, inlinedAt: !404)
!413 = !DILocation(line: 11, column: 1, scope: !396)
!414 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 20, type: !415, scopeLine: 20, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !417)
!415 = !DISubroutineType(types: !416)
!416 = !{null, !203, !230}
!417 = !{!418, !419, !420, !421, !422}
!418 = !DILocalVariable(name: "fd", arg: 1, scope: !414, file: !189, line: 20, type: !203)
!419 = !DILocalVariable(name: "vdata", arg: 2, scope: !414, file: !189, line: 20, type: !230)
!420 = !DILocalVariable(name: "data", scope: !414, file: !189, line: 21, type: !191)
!421 = !DILocalVariable(name: "p", scope: !414, file: !189, line: 22, type: !229)
!422 = !DILocalVariable(name: "s", scope: !414, file: !189, line: 22, type: !229)
!423 = !DILocation(line: 0, scope: !414)
!424 = !DILocation(line: 24, column: 3, scope: !414)
!425 = !DILocation(line: 26, column: 7, scope: !414)
!426 = !DILocalVariable(name: "s", arg: 1, scope: !427, file: !2, line: 56, type: !229)
!427 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !428, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !430)
!428 = !DISubroutineType(types: !429)
!429 = !{!229, !229, !203}
!430 = !{!426, !431, !432}
!431 = !DILocalVariable(name: "n", arg: 2, scope: !427, file: !2, line: 56, type: !203)
!432 = !DILocalVariable(name: "i", scope: !427, file: !2, line: 57, type: !203)
!433 = !DILocation(line: 0, scope: !427, inlinedAt: !434)
!434 = distinct !DILocation(line: 28, column: 7, scope: !414)
!435 = !DILocation(line: 64, column: 17, scope: !427, inlinedAt: !434)
!436 = !{!362, !362, i64 0}
!437 = !DILocation(line: 64, column: 3, scope: !427, inlinedAt: !434)
!438 = !DILocation(line: 66, column: 22, scope: !439, inlinedAt: !434)
!439 = distinct !DILexicalBlock(scope: !440, file: !2, line: 66, column: 9)
!440 = distinct !DILexicalBlock(scope: !427, file: !2, line: 64, column: 31)
!441 = !DILocation(line: 66, column: 26, scope: !439, inlinedAt: !434)
!442 = !DILocation(line: 66, column: 32, scope: !439, inlinedAt: !434)
!443 = !DILocation(line: 66, column: 35, scope: !439, inlinedAt: !434)
!444 = !DILocation(line: 66, column: 39, scope: !439, inlinedAt: !434)
!445 = !DILocation(line: 66, column: 9, scope: !440, inlinedAt: !434)
!446 = !DILocation(line: 69, column: 6, scope: !440, inlinedAt: !434)
!447 = !DILocation(line: 64, column: 10, scope: !427, inlinedAt: !434)
!448 = !DILocation(line: 64, column: 13, scope: !427, inlinedAt: !434)
!449 = distinct !{!449, !437, !450, !371, !372}
!450 = !DILocation(line: 70, column: 3, scope: !427, inlinedAt: !434)
!451 = !DILocation(line: 71, column: 6, scope: !452, inlinedAt: !434)
!452 = distinct !DILexicalBlock(scope: !427, file: !2, line: 71, column: 6)
!453 = !DILocation(line: 71, column: 8, scope: !452, inlinedAt: !434)
!454 = !DILocation(line: 71, column: 6, scope: !427, inlinedAt: !434)
!455 = !DILocation(line: 29, column: 3, scope: !414)
!456 = !DILocation(line: 0, scope: !427, inlinedAt: !457)
!457 = distinct !DILocation(line: 31, column: 7, scope: !414)
!458 = !DILocation(line: 64, column: 17, scope: !427, inlinedAt: !457)
!459 = !DILocation(line: 64, column: 3, scope: !427, inlinedAt: !457)
!460 = !DILocation(line: 66, column: 22, scope: !439, inlinedAt: !457)
!461 = !DILocation(line: 66, column: 26, scope: !439, inlinedAt: !457)
!462 = !DILocation(line: 66, column: 32, scope: !439, inlinedAt: !457)
!463 = !DILocation(line: 66, column: 35, scope: !439, inlinedAt: !457)
!464 = !DILocation(line: 66, column: 39, scope: !439, inlinedAt: !457)
!465 = !DILocation(line: 66, column: 9, scope: !440, inlinedAt: !457)
!466 = !DILocation(line: 69, column: 6, scope: !440, inlinedAt: !457)
!467 = !DILocation(line: 64, column: 10, scope: !427, inlinedAt: !457)
!468 = !DILocation(line: 64, column: 13, scope: !427, inlinedAt: !457)
!469 = distinct !{!469, !459, !470, !371, !372}
!470 = !DILocation(line: 70, column: 3, scope: !427, inlinedAt: !457)
!471 = !DILocation(line: 71, column: 6, scope: !452, inlinedAt: !457)
!472 = !DILocation(line: 71, column: 8, scope: !452, inlinedAt: !457)
!473 = !DILocation(line: 71, column: 6, scope: !427, inlinedAt: !457)
!474 = !DILocation(line: 32, column: 37, scope: !414)
!475 = !DILocation(line: 32, column: 3, scope: !414)
!476 = !DILocation(line: 33, column: 3, scope: !414)
!477 = !DILocation(line: 35, column: 1, scope: !414)
!478 = !DISubprogram(name: "free", scope: !479, file: !479, line: 687, type: !397, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!479 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!480 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 37, type: !415, scopeLine: 37, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !481)
!481 = !{!482, !483, !484}
!482 = !DILocalVariable(name: "fd", arg: 1, scope: !480, file: !189, line: 37, type: !203)
!483 = !DILocalVariable(name: "vdata", arg: 2, scope: !480, file: !189, line: 37, type: !230)
!484 = !DILocalVariable(name: "data", scope: !480, file: !189, line: 38, type: !191)
!485 = !DILocation(line: 0, scope: !480)
!486 = !DILocalVariable(name: "fd", arg: 1, scope: !487, file: !2, line: 189, type: !203)
!487 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !488, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !490)
!488 = !DISubroutineType(types: !489)
!489 = !{!203, !203}
!490 = !{!486}
!491 = !DILocation(line: 0, scope: !487, inlinedAt: !492)
!492 = distinct !DILocation(line: 40, column: 3, scope: !480)
!493 = !DILocation(line: 190, column: 3, scope: !494, inlinedAt: !492)
!494 = distinct !DILexicalBlock(scope: !495, file: !2, line: 190, column: 3)
!495 = distinct !DILexicalBlock(scope: !487, file: !2, line: 190, column: 3)
!496 = !DILocation(line: 191, column: 3, scope: !487, inlinedAt: !492)
!497 = !DILocalVariable(name: "fd", arg: 1, scope: !498, file: !2, line: 187, type: !203)
!498 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !499, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !501)
!499 = !DISubroutineType(types: !500)
!500 = !{!203, !203, !328, !203}
!501 = !{!497, !502, !503, !504}
!502 = !DILocalVariable(name: "arr", arg: 2, scope: !498, file: !2, line: 187, type: !328)
!503 = !DILocalVariable(name: "n", arg: 3, scope: !498, file: !2, line: 187, type: !203)
!504 = !DILocalVariable(name: "i", scope: !498, file: !2, line: 187, type: !203)
!505 = !DILocation(line: 0, scope: !498, inlinedAt: !506)
!506 = distinct !DILocation(line: 41, column: 3, scope: !480)
!507 = !DILocation(line: 187, column: 1, scope: !508, inlinedAt: !506)
!508 = distinct !DILexicalBlock(scope: !498, file: !2, line: 187, column: 1)
!509 = !DILocation(line: 187, column: 1, scope: !510, inlinedAt: !506)
!510 = distinct !DILexicalBlock(scope: !511, file: !2, line: 187, column: 1)
!511 = distinct !DILexicalBlock(scope: !508, file: !2, line: 187, column: 1)
!512 = !DILocation(line: 187, column: 1, scope: !511, inlinedAt: !506)
!513 = distinct !{!513, !507, !507, !371, !372}
!514 = !DILocation(line: 0, scope: !487, inlinedAt: !515)
!515 = distinct !DILocation(line: 43, column: 3, scope: !480)
!516 = !DILocation(line: 191, column: 3, scope: !487, inlinedAt: !515)
!517 = !DILocation(line: 44, column: 38, scope: !480)
!518 = !DILocation(line: 0, scope: !498, inlinedAt: !519)
!519 = distinct !DILocation(line: 44, column: 3, scope: !480)
!520 = !DILocation(line: 187, column: 1, scope: !508, inlinedAt: !519)
!521 = !DILocation(line: 187, column: 1, scope: !510, inlinedAt: !519)
!522 = !DILocation(line: 187, column: 1, scope: !511, inlinedAt: !519)
!523 = distinct !{!523, !520, !520, !371, !372}
!524 = !DILocation(line: 45, column: 1, scope: !480)
!525 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 52, type: !415, scopeLine: 52, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !526)
!526 = !{!527, !528, !529, !530, !531}
!527 = !DILocalVariable(name: "fd", arg: 1, scope: !525, file: !189, line: 52, type: !203)
!528 = !DILocalVariable(name: "vdata", arg: 2, scope: !525, file: !189, line: 52, type: !230)
!529 = !DILocalVariable(name: "data", scope: !525, file: !189, line: 53, type: !191)
!530 = !DILocalVariable(name: "p", scope: !525, file: !189, line: 54, type: !229)
!531 = !DILocalVariable(name: "s", scope: !525, file: !189, line: 54, type: !229)
!532 = !DILocation(line: 0, scope: !525)
!533 = !DILocation(line: 56, column: 7, scope: !525)
!534 = !DILocation(line: 0, scope: !427, inlinedAt: !535)
!535 = distinct !DILocation(line: 58, column: 7, scope: !525)
!536 = !DILocation(line: 64, column: 17, scope: !427, inlinedAt: !535)
!537 = !DILocation(line: 64, column: 3, scope: !427, inlinedAt: !535)
!538 = !DILocation(line: 66, column: 22, scope: !439, inlinedAt: !535)
!539 = !DILocation(line: 66, column: 26, scope: !439, inlinedAt: !535)
!540 = !DILocation(line: 66, column: 32, scope: !439, inlinedAt: !535)
!541 = !DILocation(line: 66, column: 35, scope: !439, inlinedAt: !535)
!542 = !DILocation(line: 66, column: 39, scope: !439, inlinedAt: !535)
!543 = !DILocation(line: 66, column: 9, scope: !440, inlinedAt: !535)
!544 = !DILocation(line: 69, column: 6, scope: !440, inlinedAt: !535)
!545 = !DILocation(line: 64, column: 10, scope: !427, inlinedAt: !535)
!546 = !DILocation(line: 64, column: 13, scope: !427, inlinedAt: !535)
!547 = distinct !{!547, !537, !548, !371, !372}
!548 = !DILocation(line: 70, column: 3, scope: !427, inlinedAt: !535)
!549 = !DILocation(line: 71, column: 6, scope: !452, inlinedAt: !535)
!550 = !DILocation(line: 71, column: 8, scope: !452, inlinedAt: !535)
!551 = !DILocation(line: 71, column: 6, scope: !427, inlinedAt: !535)
!552 = !DILocation(line: 59, column: 37, scope: !525)
!553 = !DILocation(line: 59, column: 3, scope: !525)
!554 = !DILocation(line: 60, column: 3, scope: !525)
!555 = !DILocation(line: 61, column: 1, scope: !525)
!556 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 63, type: !415, scopeLine: 63, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !557)
!557 = !{!558, !559, !560}
!558 = !DILocalVariable(name: "fd", arg: 1, scope: !556, file: !189, line: 63, type: !203)
!559 = !DILocalVariable(name: "vdata", arg: 2, scope: !556, file: !189, line: 63, type: !230)
!560 = !DILocalVariable(name: "data", scope: !556, file: !189, line: 64, type: !191)
!561 = !DILocation(line: 0, scope: !556)
!562 = !DILocation(line: 0, scope: !487, inlinedAt: !563)
!563 = distinct !DILocation(line: 66, column: 3, scope: !556)
!564 = !DILocation(line: 190, column: 3, scope: !494, inlinedAt: !563)
!565 = !DILocation(line: 191, column: 3, scope: !487, inlinedAt: !563)
!566 = !DILocation(line: 67, column: 38, scope: !556)
!567 = !DILocation(line: 0, scope: !498, inlinedAt: !568)
!568 = distinct !DILocation(line: 67, column: 3, scope: !556)
!569 = !DILocation(line: 187, column: 1, scope: !508, inlinedAt: !568)
!570 = !DILocation(line: 187, column: 1, scope: !510, inlinedAt: !568)
!571 = !DILocation(line: 187, column: 1, scope: !511, inlinedAt: !568)
!572 = distinct !{!572, !569, !569, !371, !372}
!573 = !DILocation(line: 68, column: 1, scope: !556)
!574 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 70, type: !575, scopeLine: 70, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !577)
!575 = !DISubroutineType(types: !576)
!576 = !{!203, !230, !230}
!577 = !{!578, !579, !580, !581, !582, !583, !584, !585}
!578 = !DILocalVariable(name: "vdata", arg: 1, scope: !574, file: !189, line: 70, type: !230)
!579 = !DILocalVariable(name: "vref", arg: 2, scope: !574, file: !189, line: 70, type: !230)
!580 = !DILocalVariable(name: "data", scope: !574, file: !189, line: 71, type: !191)
!581 = !DILocalVariable(name: "ref", scope: !574, file: !189, line: 72, type: !191)
!582 = !DILocalVariable(name: "has_errors", scope: !574, file: !189, line: 73, type: !203)
!583 = !DILocalVariable(name: "r", scope: !574, file: !189, line: 74, type: !203)
!584 = !DILocalVariable(name: "c", scope: !574, file: !189, line: 74, type: !203)
!585 = !DILocalVariable(name: "diff", scope: !574, file: !189, line: 75, type: !197)
!586 = !DILocation(line: 0, scope: !574)
!587 = !DILocation(line: 77, column: 3, scope: !588)
!588 = distinct !DILexicalBlock(scope: !574, file: !189, line: 77, column: 3)
!589 = !DILocation(line: 78, column: 5, scope: !590)
!590 = distinct !DILexicalBlock(scope: !591, file: !189, line: 78, column: 5)
!591 = distinct !DILexicalBlock(scope: !592, file: !189, line: 77, column: 31)
!592 = distinct !DILexicalBlock(scope: !588, file: !189, line: 77, column: 3)
!593 = !DILocation(line: 79, column: 36, scope: !594)
!594 = distinct !DILexicalBlock(scope: !595, file: !189, line: 78, column: 33)
!595 = distinct !DILexicalBlock(scope: !590, file: !189, line: 78, column: 5)
!596 = !DILocation(line: 79, column: 14, scope: !594)
!597 = !DILocation(line: 79, column: 43, scope: !594)
!598 = !DILocation(line: 79, column: 41, scope: !594)
!599 = !DILocation(line: 80, column: 37, scope: !594)
!600 = !DILocation(line: 80, column: 18, scope: !594)
!601 = !DILocation(line: 78, column: 28, scope: !595)
!602 = !DILocation(line: 78, column: 16, scope: !595)
!603 = distinct !{!603, !589, !604, !371, !372}
!604 = !DILocation(line: 81, column: 5, scope: !590)
!605 = !DILocation(line: 77, column: 26, scope: !592)
!606 = !DILocation(line: 77, column: 14, scope: !592)
!607 = distinct !{!607, !587, !608, !371, !372}
!608 = !DILocation(line: 82, column: 3, scope: !588)
!609 = !DILocation(line: 85, column: 10, scope: !574)
!610 = !DILocation(line: 85, column: 3, scope: !574)
!611 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !612, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !614)
!612 = !DISubroutineType(types: !613)
!613 = !{!229, !203}
!614 = !{!615, !616, !617, !654, !657, !660}
!615 = !DILocalVariable(name: "fd", arg: 1, scope: !611, file: !2, line: 34, type: !203)
!616 = !DILocalVariable(name: "p", scope: !611, file: !2, line: 35, type: !229)
!617 = !DILocalVariable(name: "s", scope: !611, file: !2, line: 36, type: !618)
!618 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !619, line: 44, size: 1024, elements: !620)
!619 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!620 = !{!621, !623, !625, !627, !629, !631, !633, !634, !635, !637, !639, !640, !642, !650, !651, !652}
!621 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !618, file: !619, line: 46, baseType: !622, size: 64)
!622 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !234, line: 145, baseType: !244)
!623 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !618, file: !619, line: 47, baseType: !624, size: 64, offset: 64)
!624 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !234, line: 148, baseType: !244)
!625 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !618, file: !619, line: 48, baseType: !626, size: 32, offset: 128)
!626 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !234, line: 150, baseType: !241)
!627 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !618, file: !619, line: 49, baseType: !628, size: 32, offset: 160)
!628 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !234, line: 151, baseType: !241)
!629 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !618, file: !619, line: 50, baseType: !630, size: 32, offset: 192)
!630 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !234, line: 146, baseType: !241)
!631 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !618, file: !619, line: 51, baseType: !632, size: 32, offset: 224)
!632 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !234, line: 147, baseType: !241)
!633 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !618, file: !619, line: 52, baseType: !622, size: 64, offset: 256)
!634 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !618, file: !619, line: 53, baseType: !622, size: 64, offset: 320)
!635 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !618, file: !619, line: 54, baseType: !636, size: 64, offset: 384)
!636 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !234, line: 152, baseType: !256)
!637 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !618, file: !619, line: 55, baseType: !638, size: 32, offset: 448)
!638 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !234, line: 175, baseType: !203)
!639 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !618, file: !619, line: 56, baseType: !203, size: 32, offset: 480)
!640 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !618, file: !619, line: 57, baseType: !641, size: 64, offset: 512)
!641 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !234, line: 180, baseType: !256)
!642 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !618, file: !619, line: 65, baseType: !643, size: 128, offset: 576)
!643 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !644, line: 11, size: 128, elements: !645)
!644 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!645 = !{!646, !648}
!646 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !643, file: !644, line: 16, baseType: !647, size: 64)
!647 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !234, line: 160, baseType: !256)
!648 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !643, file: !644, line: 21, baseType: !649, size: 64, offset: 64)
!649 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !234, line: 197, baseType: !256)
!650 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !618, file: !619, line: 66, baseType: !643, size: 128, offset: 704)
!651 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !618, file: !619, line: 67, baseType: !643, size: 128, offset: 832)
!652 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !618, file: !619, line: 79, baseType: !653, size: 64, offset: 960)
!653 = !DICompositeType(tag: DW_TAG_array_type, baseType: !203, size: 64, elements: !55)
!654 = !DILocalVariable(name: "len", scope: !611, file: !2, line: 37, type: !655)
!655 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !656, line: 85, baseType: !636)
!656 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!657 = !DILocalVariable(name: "bytes_read", scope: !611, file: !2, line: 38, type: !658)
!658 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !656, line: 108, baseType: !659)
!659 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !234, line: 194, baseType: !256)
!660 = !DILocalVariable(name: "status", scope: !611, file: !2, line: 38, type: !658)
!661 = distinct !DIAssignID()
!662 = !DILocation(line: 0, scope: !611)
!663 = !DILocation(line: 36, column: 3, scope: !611)
!664 = !DILocation(line: 40, column: 3, scope: !665)
!665 = distinct !DILexicalBlock(scope: !666, file: !2, line: 40, column: 3)
!666 = distinct !DILexicalBlock(scope: !611, file: !2, line: 40, column: 3)
!667 = !DILocation(line: 41, column: 3, scope: !668)
!668 = distinct !DILexicalBlock(scope: !669, file: !2, line: 41, column: 3)
!669 = distinct !DILexicalBlock(scope: !611, file: !2, line: 41, column: 3)
!670 = !DILocation(line: 42, column: 11, scope: !611)
!671 = !DILocation(line: 43, column: 3, scope: !672)
!672 = distinct !DILexicalBlock(scope: !673, file: !2, line: 43, column: 3)
!673 = distinct !DILexicalBlock(scope: !611, file: !2, line: 43, column: 3)
!674 = !DILocation(line: 44, column: 25, scope: !611)
!675 = !DILocation(line: 44, column: 15, scope: !611)
!676 = !DILocation(line: 46, column: 3, scope: !611)
!677 = !DILocation(line: 49, column: 15, scope: !678)
!678 = distinct !DILexicalBlock(scope: !611, file: !2, line: 46, column: 27)
!679 = !DILocation(line: 46, column: 20, scope: !611)
!680 = distinct !{!680, !676, !681, !371, !372}
!681 = !DILocation(line: 50, column: 3, scope: !611)
!682 = !DILocation(line: 47, column: 24, scope: !678)
!683 = !DILocation(line: 47, column: 42, scope: !678)
!684 = !DILocation(line: 47, column: 14, scope: !678)
!685 = !DILocation(line: 48, column: 5, scope: !686)
!686 = distinct !DILexicalBlock(scope: !687, file: !2, line: 48, column: 5)
!687 = distinct !DILexicalBlock(scope: !678, file: !2, line: 48, column: 5)
!688 = !DILocation(line: 51, column: 3, scope: !611)
!689 = !DILocation(line: 51, column: 10, scope: !611)
!690 = !DILocation(line: 52, column: 3, scope: !611)
!691 = !DILocation(line: 54, column: 1, scope: !611)
!692 = !DILocation(line: 53, column: 3, scope: !611)
!693 = !DISubprogram(name: "__assert_fail", scope: !694, file: !694, line: 67, type: !695, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!694 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!695 = !DISubroutineType(types: !696)
!696 = !{null, !697, !697, !241, !697}
!697 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!698 = !DISubprogram(name: "fstat", scope: !699, file: !699, line: 210, type: !700, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!699 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!700 = !DISubroutineType(types: !701)
!701 = !{!203, !203, !702}
!702 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !618, size: 64)
!703 = !DISubprogram(name: "malloc", scope: !479, file: !479, line: 672, type: !704, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!704 = !DISubroutineType(types: !705)
!705 = !{!230, !706}
!706 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !707, line: 18, baseType: !244)
!707 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!708 = !DISubprogram(name: "read", scope: !709, file: !709, line: 371, type: !710, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!709 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!710 = !DISubroutineType(types: !711)
!711 = !{!658, !203, !230, !706}
!712 = !DISubprogram(name: "close", scope: !709, file: !709, line: 358, type: !488, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!713 = !DILocation(line: 0, scope: !427)
!714 = !DILocation(line: 59, column: 3, scope: !715)
!715 = distinct !DILexicalBlock(scope: !716, file: !2, line: 59, column: 3)
!716 = distinct !DILexicalBlock(scope: !427, file: !2, line: 59, column: 3)
!717 = !DILocation(line: 60, column: 7, scope: !718)
!718 = distinct !DILexicalBlock(scope: !427, file: !2, line: 60, column: 6)
!719 = !DILocation(line: 60, column: 6, scope: !427)
!720 = !DILocation(line: 64, column: 17, scope: !427)
!721 = !DILocation(line: 64, column: 3, scope: !427)
!722 = !DILocation(line: 66, column: 22, scope: !439)
!723 = !DILocation(line: 66, column: 26, scope: !439)
!724 = !DILocation(line: 66, column: 32, scope: !439)
!725 = !DILocation(line: 66, column: 35, scope: !439)
!726 = !DILocation(line: 66, column: 39, scope: !439)
!727 = !DILocation(line: 66, column: 9, scope: !440)
!728 = !DILocation(line: 69, column: 6, scope: !440)
!729 = !DILocation(line: 64, column: 10, scope: !427)
!730 = !DILocation(line: 64, column: 13, scope: !427)
!731 = distinct !{!731, !721, !732, !371, !372}
!732 = !DILocation(line: 70, column: 3, scope: !427)
!733 = !DILocation(line: 71, column: 6, scope: !452)
!734 = !DILocation(line: 71, column: 8, scope: !452)
!735 = !DILocation(line: 71, column: 6, scope: !427)
!736 = !DILocation(line: 74, column: 1, scope: !427)
!737 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !738, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !740)
!738 = !DISubroutineType(types: !739)
!739 = !{!203, !229, !229, !203}
!740 = !{!741, !742, !743, !744}
!741 = !DILocalVariable(name: "s", arg: 1, scope: !737, file: !2, line: 77, type: !229)
!742 = !DILocalVariable(name: "arr", arg: 2, scope: !737, file: !2, line: 77, type: !229)
!743 = !DILocalVariable(name: "n", arg: 3, scope: !737, file: !2, line: 77, type: !203)
!744 = !DILocalVariable(name: "k", scope: !737, file: !2, line: 78, type: !203)
!745 = !DILocation(line: 0, scope: !737)
!746 = !DILocation(line: 79, column: 3, scope: !747)
!747 = distinct !DILexicalBlock(scope: !748, file: !2, line: 79, column: 3)
!748 = distinct !DILexicalBlock(scope: !737, file: !2, line: 79, column: 3)
!749 = !DILocation(line: 81, column: 8, scope: !750)
!750 = distinct !DILexicalBlock(scope: !737, file: !2, line: 81, column: 7)
!751 = !DILocation(line: 81, column: 7, scope: !737)
!752 = !DILocation(line: 83, column: 12, scope: !753)
!753 = distinct !DILexicalBlock(scope: !750, file: !2, line: 81, column: 13)
!754 = !DILocation(line: 83, column: 5, scope: !753)
!755 = !DILocation(line: 91, column: 19, scope: !737)
!756 = !DILocation(line: 91, column: 3, scope: !737)
!757 = !DILocation(line: 92, column: 7, scope: !737)
!758 = !DILocation(line: 83, column: 16, scope: !753)
!759 = !DILocation(line: 83, column: 26, scope: !753)
!760 = !DILocation(line: 83, column: 32, scope: !753)
!761 = !DILocation(line: 83, column: 29, scope: !753)
!762 = !DILocation(line: 83, column: 35, scope: !753)
!763 = !DILocation(line: 83, column: 45, scope: !753)
!764 = !DILocation(line: 83, column: 48, scope: !753)
!765 = !DILocation(line: 83, column: 54, scope: !753)
!766 = !DILocation(line: 84, column: 9, scope: !753)
!767 = !DILocation(line: 84, column: 18, scope: !753)
!768 = !DILocation(line: 84, column: 26, scope: !753)
!769 = distinct !{!769, !754, !770, !371, !372}
!770 = !DILocation(line: 86, column: 5, scope: !753)
!771 = !DILocation(line: 93, column: 5, scope: !772)
!772 = distinct !DILexicalBlock(scope: !737, file: !2, line: 92, column: 7)
!773 = !DILocation(line: 93, column: 12, scope: !772)
!774 = !DILocation(line: 95, column: 3, scope: !737)
!775 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !776, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !779)
!776 = !DISubroutineType(types: !777)
!777 = !{!203, !229, !778, !203}
!778 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !231, size: 64)
!779 = !{!780, !781, !782, !783, !784, !785, !786}
!780 = !DILocalVariable(name: "s", arg: 1, scope: !775, file: !2, line: 132, type: !229)
!781 = !DILocalVariable(name: "arr", arg: 2, scope: !775, file: !2, line: 132, type: !778)
!782 = !DILocalVariable(name: "n", arg: 3, scope: !775, file: !2, line: 132, type: !203)
!783 = !DILocalVariable(name: "line", scope: !775, file: !2, line: 132, type: !229)
!784 = !DILocalVariable(name: "endptr", scope: !775, file: !2, line: 132, type: !229)
!785 = !DILocalVariable(name: "i", scope: !775, file: !2, line: 132, type: !203)
!786 = !DILocalVariable(name: "v", scope: !775, file: !2, line: 132, type: !231)
!787 = distinct !DIAssignID()
!788 = !DILocation(line: 0, scope: !775)
!789 = !DILocation(line: 132, column: 1, scope: !775)
!790 = !DILocation(line: 132, column: 1, scope: !791)
!791 = distinct !DILexicalBlock(scope: !792, file: !2, line: 132, column: 1)
!792 = distinct !DILexicalBlock(scope: !775, file: !2, line: 132, column: 1)
!793 = !DILocation(line: 132, column: 1, scope: !794)
!794 = distinct !DILexicalBlock(scope: !775, file: !2, line: 132, column: 1)
!795 = !{!796, !796, i64 0}
!796 = !{!"any pointer", !362, i64 0}
!797 = distinct !DIAssignID()
!798 = !DILocation(line: 132, column: 1, scope: !799)
!799 = distinct !DILexicalBlock(scope: !794, file: !2, line: 132, column: 1)
!800 = !DILocation(line: 132, column: 1, scope: !801)
!801 = distinct !DILexicalBlock(scope: !799, file: !2, line: 132, column: 1)
!802 = distinct !{!802, !789, !789, !371, !372}
!803 = !DILocation(line: 132, column: 1, scope: !804)
!804 = distinct !DILexicalBlock(scope: !805, file: !2, line: 132, column: 1)
!805 = distinct !DILexicalBlock(scope: !775, file: !2, line: 132, column: 1)
!806 = !DISubprogram(name: "strtok", scope: !807, file: !807, line: 356, type: !808, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!807 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!808 = !DISubroutineType(types: !809)
!809 = !{!229, !810, !811}
!810 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !229)
!811 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !697)
!812 = !DISubprogram(name: "strtol", scope: !479, file: !479, line: 177, type: !813, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!813 = !DISubroutineType(types: !814)
!814 = !{!256, !811, !815, !203}
!815 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !816)
!816 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !229, size: 64)
!817 = !DISubprogram(name: "fprintf", scope: !818, file: !818, line: 357, type: !819, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!818 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!819 = !DISubroutineType(types: !820)
!820 = !{!203, !821, !811, null}
!821 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !822)
!822 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !823, size: 64)
!823 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !824, line: 7, baseType: !825)
!824 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!825 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !826, line: 49, size: 1728, elements: !827)
!826 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!827 = !{!828, !829, !830, !831, !832, !833, !834, !835, !836, !837, !838, !839, !840, !843, !845, !846, !847, !848, !849, !850, !854, !857, !859, !862, !865, !866, !867, !869, !870}
!828 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !825, file: !826, line: 51, baseType: !203, size: 32)
!829 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !825, file: !826, line: 54, baseType: !229, size: 64, offset: 64)
!830 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !825, file: !826, line: 55, baseType: !229, size: 64, offset: 128)
!831 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !825, file: !826, line: 56, baseType: !229, size: 64, offset: 192)
!832 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !825, file: !826, line: 57, baseType: !229, size: 64, offset: 256)
!833 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !825, file: !826, line: 58, baseType: !229, size: 64, offset: 320)
!834 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !825, file: !826, line: 59, baseType: !229, size: 64, offset: 384)
!835 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !825, file: !826, line: 60, baseType: !229, size: 64, offset: 448)
!836 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !825, file: !826, line: 61, baseType: !229, size: 64, offset: 512)
!837 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !825, file: !826, line: 64, baseType: !229, size: 64, offset: 576)
!838 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !825, file: !826, line: 65, baseType: !229, size: 64, offset: 640)
!839 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !825, file: !826, line: 66, baseType: !229, size: 64, offset: 704)
!840 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !825, file: !826, line: 68, baseType: !841, size: 64, offset: 768)
!841 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !842, size: 64)
!842 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !826, line: 36, flags: DIFlagFwdDecl)
!843 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !825, file: !826, line: 70, baseType: !844, size: 64, offset: 832)
!844 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !825, size: 64)
!845 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !825, file: !826, line: 72, baseType: !203, size: 32, offset: 896)
!846 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !825, file: !826, line: 73, baseType: !203, size: 32, offset: 928)
!847 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !825, file: !826, line: 74, baseType: !636, size: 64, offset: 960)
!848 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !825, file: !826, line: 77, baseType: !238, size: 16, offset: 1024)
!849 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !825, file: !826, line: 78, baseType: !248, size: 8, offset: 1040)
!850 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !825, file: !826, line: 79, baseType: !851, size: 8, offset: 1048)
!851 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !852)
!852 = !{!853}
!853 = !DISubrange(count: 1)
!854 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !825, file: !826, line: 81, baseType: !855, size: 64, offset: 1088)
!855 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !856, size: 64)
!856 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !826, line: 43, baseType: null)
!857 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !825, file: !826, line: 89, baseType: !858, size: 64, offset: 1152)
!858 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !234, line: 153, baseType: !256)
!859 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !825, file: !826, line: 91, baseType: !860, size: 64, offset: 1216)
!860 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !861, size: 64)
!861 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !826, line: 37, flags: DIFlagFwdDecl)
!862 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !825, file: !826, line: 92, baseType: !863, size: 64, offset: 1280)
!863 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !864, size: 64)
!864 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !826, line: 38, flags: DIFlagFwdDecl)
!865 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !825, file: !826, line: 93, baseType: !844, size: 64, offset: 1344)
!866 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !825, file: !826, line: 94, baseType: !230, size: 64, offset: 1408)
!867 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !825, file: !826, line: 95, baseType: !868, size: 64, offset: 1472)
!868 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !844, size: 64)
!869 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !825, file: !826, line: 96, baseType: !203, size: 32, offset: 1536)
!870 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !825, file: !826, line: 98, baseType: !871, size: 160, offset: 1568)
!871 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!872 = !DISubprogram(name: "strlen", scope: !807, file: !807, line: 407, type: !873, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!873 = !DISubroutineType(types: !874)
!874 = !{!244, !697}
!875 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !876, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !879)
!876 = !DISubroutineType(types: !877)
!877 = !{!203, !229, !878, !203}
!878 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !236, size: 64)
!879 = !{!880, !881, !882, !883, !884, !885, !886}
!880 = !DILocalVariable(name: "s", arg: 1, scope: !875, file: !2, line: 133, type: !229)
!881 = !DILocalVariable(name: "arr", arg: 2, scope: !875, file: !2, line: 133, type: !878)
!882 = !DILocalVariable(name: "n", arg: 3, scope: !875, file: !2, line: 133, type: !203)
!883 = !DILocalVariable(name: "line", scope: !875, file: !2, line: 133, type: !229)
!884 = !DILocalVariable(name: "endptr", scope: !875, file: !2, line: 133, type: !229)
!885 = !DILocalVariable(name: "i", scope: !875, file: !2, line: 133, type: !203)
!886 = !DILocalVariable(name: "v", scope: !875, file: !2, line: 133, type: !236)
!887 = distinct !DIAssignID()
!888 = !DILocation(line: 0, scope: !875)
!889 = !DILocation(line: 133, column: 1, scope: !875)
!890 = !DILocation(line: 133, column: 1, scope: !891)
!891 = distinct !DILexicalBlock(scope: !892, file: !2, line: 133, column: 1)
!892 = distinct !DILexicalBlock(scope: !875, file: !2, line: 133, column: 1)
!893 = !DILocation(line: 133, column: 1, scope: !894)
!894 = distinct !DILexicalBlock(scope: !875, file: !2, line: 133, column: 1)
!895 = distinct !DIAssignID()
!896 = !DILocation(line: 133, column: 1, scope: !897)
!897 = distinct !DILexicalBlock(scope: !894, file: !2, line: 133, column: 1)
!898 = !DILocation(line: 133, column: 1, scope: !899)
!899 = distinct !DILexicalBlock(scope: !897, file: !2, line: 133, column: 1)
!900 = !{!901, !901, i64 0}
!901 = !{!"short", !362, i64 0}
!902 = distinct !{!902, !889, !889, !371, !372}
!903 = !DILocation(line: 133, column: 1, scope: !904)
!904 = distinct !DILexicalBlock(scope: !905, file: !2, line: 133, column: 1)
!905 = distinct !DILexicalBlock(scope: !875, file: !2, line: 133, column: 1)
!906 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !907, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !910)
!907 = !DISubroutineType(types: !908)
!908 = !{!203, !229, !909, !203}
!909 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !239, size: 64)
!910 = !{!911, !912, !913, !914, !915, !916, !917}
!911 = !DILocalVariable(name: "s", arg: 1, scope: !906, file: !2, line: 134, type: !229)
!912 = !DILocalVariable(name: "arr", arg: 2, scope: !906, file: !2, line: 134, type: !909)
!913 = !DILocalVariable(name: "n", arg: 3, scope: !906, file: !2, line: 134, type: !203)
!914 = !DILocalVariable(name: "line", scope: !906, file: !2, line: 134, type: !229)
!915 = !DILocalVariable(name: "endptr", scope: !906, file: !2, line: 134, type: !229)
!916 = !DILocalVariable(name: "i", scope: !906, file: !2, line: 134, type: !203)
!917 = !DILocalVariable(name: "v", scope: !906, file: !2, line: 134, type: !239)
!918 = distinct !DIAssignID()
!919 = !DILocation(line: 0, scope: !906)
!920 = !DILocation(line: 134, column: 1, scope: !906)
!921 = !DILocation(line: 134, column: 1, scope: !922)
!922 = distinct !DILexicalBlock(scope: !923, file: !2, line: 134, column: 1)
!923 = distinct !DILexicalBlock(scope: !906, file: !2, line: 134, column: 1)
!924 = !DILocation(line: 134, column: 1, scope: !925)
!925 = distinct !DILexicalBlock(scope: !906, file: !2, line: 134, column: 1)
!926 = distinct !DIAssignID()
!927 = !DILocation(line: 134, column: 1, scope: !928)
!928 = distinct !DILexicalBlock(scope: !925, file: !2, line: 134, column: 1)
!929 = !DILocation(line: 134, column: 1, scope: !930)
!930 = distinct !DILexicalBlock(scope: !928, file: !2, line: 134, column: 1)
!931 = !{!932, !932, i64 0}
!932 = !{!"int", !362, i64 0}
!933 = distinct !{!933, !920, !920, !371, !372}
!934 = !DILocation(line: 134, column: 1, scope: !935)
!935 = distinct !DILexicalBlock(scope: !936, file: !2, line: 134, column: 1)
!936 = distinct !DILexicalBlock(scope: !906, file: !2, line: 134, column: 1)
!937 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !938, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !941)
!938 = !DISubroutineType(types: !939)
!939 = !{!203, !229, !940, !203}
!940 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !242, size: 64)
!941 = !{!942, !943, !944, !945, !946, !947, !948}
!942 = !DILocalVariable(name: "s", arg: 1, scope: !937, file: !2, line: 135, type: !229)
!943 = !DILocalVariable(name: "arr", arg: 2, scope: !937, file: !2, line: 135, type: !940)
!944 = !DILocalVariable(name: "n", arg: 3, scope: !937, file: !2, line: 135, type: !203)
!945 = !DILocalVariable(name: "line", scope: !937, file: !2, line: 135, type: !229)
!946 = !DILocalVariable(name: "endptr", scope: !937, file: !2, line: 135, type: !229)
!947 = !DILocalVariable(name: "i", scope: !937, file: !2, line: 135, type: !203)
!948 = !DILocalVariable(name: "v", scope: !937, file: !2, line: 135, type: !242)
!949 = distinct !DIAssignID()
!950 = !DILocation(line: 0, scope: !937)
!951 = !DILocation(line: 135, column: 1, scope: !937)
!952 = !DILocation(line: 135, column: 1, scope: !953)
!953 = distinct !DILexicalBlock(scope: !954, file: !2, line: 135, column: 1)
!954 = distinct !DILexicalBlock(scope: !937, file: !2, line: 135, column: 1)
!955 = !DILocation(line: 135, column: 1, scope: !956)
!956 = distinct !DILexicalBlock(scope: !937, file: !2, line: 135, column: 1)
!957 = distinct !DIAssignID()
!958 = !DILocation(line: 135, column: 1, scope: !959)
!959 = distinct !DILexicalBlock(scope: !956, file: !2, line: 135, column: 1)
!960 = !DILocation(line: 135, column: 1, scope: !961)
!961 = distinct !DILexicalBlock(scope: !959, file: !2, line: 135, column: 1)
!962 = !{!963, !963, i64 0}
!963 = !{!"long", !362, i64 0}
!964 = distinct !{!964, !951, !951, !371, !372}
!965 = !DILocation(line: 135, column: 1, scope: !966)
!966 = distinct !DILexicalBlock(scope: !967, file: !2, line: 135, column: 1)
!967 = distinct !DILexicalBlock(scope: !937, file: !2, line: 135, column: 1)
!968 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !969, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !972)
!969 = !DISubroutineType(types: !970)
!970 = !{!203, !229, !971, !203}
!971 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !245, size: 64)
!972 = !{!973, !974, !975, !976, !977, !978, !979}
!973 = !DILocalVariable(name: "s", arg: 1, scope: !968, file: !2, line: 136, type: !229)
!974 = !DILocalVariable(name: "arr", arg: 2, scope: !968, file: !2, line: 136, type: !971)
!975 = !DILocalVariable(name: "n", arg: 3, scope: !968, file: !2, line: 136, type: !203)
!976 = !DILocalVariable(name: "line", scope: !968, file: !2, line: 136, type: !229)
!977 = !DILocalVariable(name: "endptr", scope: !968, file: !2, line: 136, type: !229)
!978 = !DILocalVariable(name: "i", scope: !968, file: !2, line: 136, type: !203)
!979 = !DILocalVariable(name: "v", scope: !968, file: !2, line: 136, type: !245)
!980 = distinct !DIAssignID()
!981 = !DILocation(line: 0, scope: !968)
!982 = !DILocation(line: 136, column: 1, scope: !968)
!983 = !DILocation(line: 136, column: 1, scope: !984)
!984 = distinct !DILexicalBlock(scope: !985, file: !2, line: 136, column: 1)
!985 = distinct !DILexicalBlock(scope: !968, file: !2, line: 136, column: 1)
!986 = !DILocation(line: 136, column: 1, scope: !987)
!987 = distinct !DILexicalBlock(scope: !968, file: !2, line: 136, column: 1)
!988 = distinct !DIAssignID()
!989 = !DILocation(line: 136, column: 1, scope: !990)
!990 = distinct !DILexicalBlock(scope: !987, file: !2, line: 136, column: 1)
!991 = !DILocation(line: 136, column: 1, scope: !992)
!992 = distinct !DILexicalBlock(scope: !990, file: !2, line: 136, column: 1)
!993 = distinct !{!993, !982, !982, !371, !372}
!994 = !DILocation(line: 136, column: 1, scope: !995)
!995 = distinct !DILexicalBlock(scope: !996, file: !2, line: 136, column: 1)
!996 = distinct !DILexicalBlock(scope: !968, file: !2, line: 136, column: 1)
!997 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !998, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1001)
!998 = !DISubroutineType(types: !999)
!999 = !{!203, !229, !1000, !203}
!1000 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !249, size: 64)
!1001 = !{!1002, !1003, !1004, !1005, !1006, !1007, !1008}
!1002 = !DILocalVariable(name: "s", arg: 1, scope: !997, file: !2, line: 137, type: !229)
!1003 = !DILocalVariable(name: "arr", arg: 2, scope: !997, file: !2, line: 137, type: !1000)
!1004 = !DILocalVariable(name: "n", arg: 3, scope: !997, file: !2, line: 137, type: !203)
!1005 = !DILocalVariable(name: "line", scope: !997, file: !2, line: 137, type: !229)
!1006 = !DILocalVariable(name: "endptr", scope: !997, file: !2, line: 137, type: !229)
!1007 = !DILocalVariable(name: "i", scope: !997, file: !2, line: 137, type: !203)
!1008 = !DILocalVariable(name: "v", scope: !997, file: !2, line: 137, type: !249)
!1009 = distinct !DIAssignID()
!1010 = !DILocation(line: 0, scope: !997)
!1011 = !DILocation(line: 137, column: 1, scope: !997)
!1012 = !DILocation(line: 137, column: 1, scope: !1013)
!1013 = distinct !DILexicalBlock(scope: !1014, file: !2, line: 137, column: 1)
!1014 = distinct !DILexicalBlock(scope: !997, file: !2, line: 137, column: 1)
!1015 = !DILocation(line: 137, column: 1, scope: !1016)
!1016 = distinct !DILexicalBlock(scope: !997, file: !2, line: 137, column: 1)
!1017 = distinct !DIAssignID()
!1018 = !DILocation(line: 137, column: 1, scope: !1019)
!1019 = distinct !DILexicalBlock(scope: !1016, file: !2, line: 137, column: 1)
!1020 = !DILocation(line: 137, column: 1, scope: !1021)
!1021 = distinct !DILexicalBlock(scope: !1019, file: !2, line: 137, column: 1)
!1022 = distinct !{!1022, !1011, !1011, !371, !372}
!1023 = !DILocation(line: 137, column: 1, scope: !1024)
!1024 = distinct !DILexicalBlock(scope: !1025, file: !2, line: 137, column: 1)
!1025 = distinct !DILexicalBlock(scope: !997, file: !2, line: 137, column: 1)
!1026 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1027, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1030)
!1027 = !DISubroutineType(types: !1028)
!1028 = !{!203, !229, !1029, !203}
!1029 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !252, size: 64)
!1030 = !{!1031, !1032, !1033, !1034, !1035, !1036, !1037}
!1031 = !DILocalVariable(name: "s", arg: 1, scope: !1026, file: !2, line: 138, type: !229)
!1032 = !DILocalVariable(name: "arr", arg: 2, scope: !1026, file: !2, line: 138, type: !1029)
!1033 = !DILocalVariable(name: "n", arg: 3, scope: !1026, file: !2, line: 138, type: !203)
!1034 = !DILocalVariable(name: "line", scope: !1026, file: !2, line: 138, type: !229)
!1035 = !DILocalVariable(name: "endptr", scope: !1026, file: !2, line: 138, type: !229)
!1036 = !DILocalVariable(name: "i", scope: !1026, file: !2, line: 138, type: !203)
!1037 = !DILocalVariable(name: "v", scope: !1026, file: !2, line: 138, type: !252)
!1038 = distinct !DIAssignID()
!1039 = !DILocation(line: 0, scope: !1026)
!1040 = !DILocation(line: 138, column: 1, scope: !1026)
!1041 = !DILocation(line: 138, column: 1, scope: !1042)
!1042 = distinct !DILexicalBlock(scope: !1043, file: !2, line: 138, column: 1)
!1043 = distinct !DILexicalBlock(scope: !1026, file: !2, line: 138, column: 1)
!1044 = !DILocation(line: 138, column: 1, scope: !1045)
!1045 = distinct !DILexicalBlock(scope: !1026, file: !2, line: 138, column: 1)
!1046 = distinct !DIAssignID()
!1047 = !DILocation(line: 138, column: 1, scope: !1048)
!1048 = distinct !DILexicalBlock(scope: !1045, file: !2, line: 138, column: 1)
!1049 = !DILocation(line: 138, column: 1, scope: !1050)
!1050 = distinct !DILexicalBlock(scope: !1048, file: !2, line: 138, column: 1)
!1051 = distinct !{!1051, !1040, !1040, !371, !372}
!1052 = !DILocation(line: 138, column: 1, scope: !1053)
!1053 = distinct !DILexicalBlock(scope: !1054, file: !2, line: 138, column: 1)
!1054 = distinct !DILexicalBlock(scope: !1026, file: !2, line: 138, column: 1)
!1055 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1056, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1059)
!1056 = !DISubroutineType(types: !1057)
!1057 = !{!203, !229, !1058, !203}
!1058 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 64)
!1059 = !{!1060, !1061, !1062, !1063, !1064, !1065, !1066}
!1060 = !DILocalVariable(name: "s", arg: 1, scope: !1055, file: !2, line: 139, type: !229)
!1061 = !DILocalVariable(name: "arr", arg: 2, scope: !1055, file: !2, line: 139, type: !1058)
!1062 = !DILocalVariable(name: "n", arg: 3, scope: !1055, file: !2, line: 139, type: !203)
!1063 = !DILocalVariable(name: "line", scope: !1055, file: !2, line: 139, type: !229)
!1064 = !DILocalVariable(name: "endptr", scope: !1055, file: !2, line: 139, type: !229)
!1065 = !DILocalVariable(name: "i", scope: !1055, file: !2, line: 139, type: !203)
!1066 = !DILocalVariable(name: "v", scope: !1055, file: !2, line: 139, type: !254)
!1067 = distinct !DIAssignID()
!1068 = !DILocation(line: 0, scope: !1055)
!1069 = !DILocation(line: 139, column: 1, scope: !1055)
!1070 = !DILocation(line: 139, column: 1, scope: !1071)
!1071 = distinct !DILexicalBlock(scope: !1072, file: !2, line: 139, column: 1)
!1072 = distinct !DILexicalBlock(scope: !1055, file: !2, line: 139, column: 1)
!1073 = !DILocation(line: 139, column: 1, scope: !1074)
!1074 = distinct !DILexicalBlock(scope: !1055, file: !2, line: 139, column: 1)
!1075 = distinct !DIAssignID()
!1076 = !DILocation(line: 139, column: 1, scope: !1077)
!1077 = distinct !DILexicalBlock(scope: !1074, file: !2, line: 139, column: 1)
!1078 = !DILocation(line: 139, column: 1, scope: !1079)
!1079 = distinct !DILexicalBlock(scope: !1077, file: !2, line: 139, column: 1)
!1080 = distinct !{!1080, !1069, !1069, !371, !372}
!1081 = !DILocation(line: 139, column: 1, scope: !1082)
!1082 = distinct !DILexicalBlock(scope: !1083, file: !2, line: 139, column: 1)
!1083 = distinct !DILexicalBlock(scope: !1055, file: !2, line: 139, column: 1)
!1084 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1085, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1088)
!1085 = !DISubroutineType(types: !1086)
!1086 = !{!203, !229, !1087, !203}
!1087 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !257, size: 64)
!1088 = !{!1089, !1090, !1091, !1092, !1093, !1094, !1095}
!1089 = !DILocalVariable(name: "s", arg: 1, scope: !1084, file: !2, line: 141, type: !229)
!1090 = !DILocalVariable(name: "arr", arg: 2, scope: !1084, file: !2, line: 141, type: !1087)
!1091 = !DILocalVariable(name: "n", arg: 3, scope: !1084, file: !2, line: 141, type: !203)
!1092 = !DILocalVariable(name: "line", scope: !1084, file: !2, line: 141, type: !229)
!1093 = !DILocalVariable(name: "endptr", scope: !1084, file: !2, line: 141, type: !229)
!1094 = !DILocalVariable(name: "i", scope: !1084, file: !2, line: 141, type: !203)
!1095 = !DILocalVariable(name: "v", scope: !1084, file: !2, line: 141, type: !257)
!1096 = distinct !DIAssignID()
!1097 = !DILocation(line: 0, scope: !1084)
!1098 = !DILocation(line: 141, column: 1, scope: !1084)
!1099 = !DILocation(line: 141, column: 1, scope: !1100)
!1100 = distinct !DILexicalBlock(scope: !1101, file: !2, line: 141, column: 1)
!1101 = distinct !DILexicalBlock(scope: !1084, file: !2, line: 141, column: 1)
!1102 = !DILocation(line: 141, column: 1, scope: !1103)
!1103 = distinct !DILexicalBlock(scope: !1084, file: !2, line: 141, column: 1)
!1104 = distinct !DIAssignID()
!1105 = !DILocation(line: 141, column: 1, scope: !1106)
!1106 = distinct !DILexicalBlock(scope: !1103, file: !2, line: 141, column: 1)
!1107 = !DILocation(line: 141, column: 1, scope: !1108)
!1108 = distinct !DILexicalBlock(scope: !1106, file: !2, line: 141, column: 1)
!1109 = !{!1110, !1110, i64 0}
!1110 = !{!"float", !362, i64 0}
!1111 = distinct !{!1111, !1098, !1098, !371, !372}
!1112 = !DILocation(line: 141, column: 1, scope: !1113)
!1113 = distinct !DILexicalBlock(scope: !1114, file: !2, line: 141, column: 1)
!1114 = distinct !DILexicalBlock(scope: !1084, file: !2, line: 141, column: 1)
!1115 = !DISubprogram(name: "strtof", scope: !479, file: !479, line: 124, type: !1116, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1116 = !DISubroutineType(types: !1117)
!1117 = !{!257, !811, !815}
!1118 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1119, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1121)
!1119 = !DISubroutineType(types: !1120)
!1120 = !{!203, !229, !328, !203}
!1121 = !{!1122, !1123, !1124, !1125, !1126, !1127, !1128}
!1122 = !DILocalVariable(name: "s", arg: 1, scope: !1118, file: !2, line: 142, type: !229)
!1123 = !DILocalVariable(name: "arr", arg: 2, scope: !1118, file: !2, line: 142, type: !328)
!1124 = !DILocalVariable(name: "n", arg: 3, scope: !1118, file: !2, line: 142, type: !203)
!1125 = !DILocalVariable(name: "line", scope: !1118, file: !2, line: 142, type: !229)
!1126 = !DILocalVariable(name: "endptr", scope: !1118, file: !2, line: 142, type: !229)
!1127 = !DILocalVariable(name: "i", scope: !1118, file: !2, line: 142, type: !203)
!1128 = !DILocalVariable(name: "v", scope: !1118, file: !2, line: 142, type: !197)
!1129 = distinct !DIAssignID()
!1130 = !DILocation(line: 0, scope: !1118)
!1131 = !DILocation(line: 142, column: 1, scope: !1118)
!1132 = !DILocation(line: 142, column: 1, scope: !1133)
!1133 = distinct !DILexicalBlock(scope: !1134, file: !2, line: 142, column: 1)
!1134 = distinct !DILexicalBlock(scope: !1118, file: !2, line: 142, column: 1)
!1135 = !DILocation(line: 142, column: 1, scope: !1136)
!1136 = distinct !DILexicalBlock(scope: !1118, file: !2, line: 142, column: 1)
!1137 = distinct !DIAssignID()
!1138 = !DILocation(line: 142, column: 1, scope: !1139)
!1139 = distinct !DILexicalBlock(scope: !1136, file: !2, line: 142, column: 1)
!1140 = !DILocation(line: 142, column: 1, scope: !1141)
!1141 = distinct !DILexicalBlock(scope: !1139, file: !2, line: 142, column: 1)
!1142 = distinct !{!1142, !1131, !1131, !371, !372}
!1143 = !DILocation(line: 142, column: 1, scope: !1144)
!1144 = distinct !DILexicalBlock(scope: !1145, file: !2, line: 142, column: 1)
!1145 = distinct !DILexicalBlock(scope: !1118, file: !2, line: 142, column: 1)
!1146 = !DISubprogram(name: "strtod", scope: !479, file: !479, line: 118, type: !1147, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1147 = !DISubroutineType(types: !1148)
!1148 = !{!197, !811, !815}
!1149 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1150, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1152)
!1150 = !DISubroutineType(types: !1151)
!1151 = !{!203, !203, !229, !203}
!1152 = !{!1153, !1154, !1155, !1156, !1157}
!1153 = !DILocalVariable(name: "fd", arg: 1, scope: !1149, file: !2, line: 145, type: !203)
!1154 = !DILocalVariable(name: "arr", arg: 2, scope: !1149, file: !2, line: 145, type: !229)
!1155 = !DILocalVariable(name: "n", arg: 3, scope: !1149, file: !2, line: 145, type: !203)
!1156 = !DILocalVariable(name: "status", scope: !1149, file: !2, line: 146, type: !203)
!1157 = !DILocalVariable(name: "written", scope: !1149, file: !2, line: 146, type: !203)
!1158 = !DILocation(line: 0, scope: !1149)
!1159 = !DILocation(line: 147, column: 3, scope: !1160)
!1160 = distinct !DILexicalBlock(scope: !1161, file: !2, line: 147, column: 3)
!1161 = distinct !DILexicalBlock(scope: !1149, file: !2, line: 147, column: 3)
!1162 = !DILocation(line: 148, column: 8, scope: !1163)
!1163 = distinct !DILexicalBlock(scope: !1149, file: !2, line: 148, column: 7)
!1164 = !DILocation(line: 148, column: 7, scope: !1149)
!1165 = !DILocation(line: 149, column: 9, scope: !1166)
!1166 = distinct !DILexicalBlock(scope: !1163, file: !2, line: 148, column: 13)
!1167 = !DILocation(line: 150, column: 3, scope: !1166)
!1168 = !DILocation(line: 152, column: 16, scope: !1149)
!1169 = !DILocation(line: 152, column: 3, scope: !1149)
!1170 = !DILocation(line: 158, column: 3, scope: !1149)
!1171 = !DILocation(line: 155, column: 13, scope: !1172)
!1172 = distinct !DILexicalBlock(scope: !1149, file: !2, line: 152, column: 20)
!1173 = distinct !{!1173, !1169, !1174, !371, !372}
!1174 = !DILocation(line: 156, column: 3, scope: !1149)
!1175 = !DILocation(line: 153, column: 25, scope: !1172)
!1176 = !DILocation(line: 153, column: 40, scope: !1172)
!1177 = !DILocation(line: 153, column: 39, scope: !1172)
!1178 = !DILocation(line: 153, column: 14, scope: !1172)
!1179 = !DILocation(line: 154, column: 5, scope: !1180)
!1180 = distinct !DILexicalBlock(scope: !1181, file: !2, line: 154, column: 5)
!1181 = distinct !DILexicalBlock(scope: !1172, file: !2, line: 154, column: 5)
!1182 = !DILocation(line: 159, column: 14, scope: !1183)
!1183 = distinct !DILexicalBlock(scope: !1149, file: !2, line: 158, column: 6)
!1184 = !DILocation(line: 160, column: 5, scope: !1185)
!1185 = distinct !DILexicalBlock(scope: !1186, file: !2, line: 160, column: 5)
!1186 = distinct !DILexicalBlock(scope: !1183, file: !2, line: 160, column: 5)
!1187 = !DILocation(line: 161, column: 17, scope: !1149)
!1188 = !DILocation(line: 161, column: 3, scope: !1183)
!1189 = distinct !{!1189, !1170, !1190, !371, !372}
!1190 = !DILocation(line: 161, column: 20, scope: !1149)
!1191 = !DILocation(line: 163, column: 3, scope: !1149)
!1192 = !DISubprogram(name: "write", scope: !709, file: !709, line: 378, type: !1193, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1193 = !DISubroutineType(types: !1194)
!1194 = !{!658, !203, !1195, !706}
!1195 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1196, size: 64)
!1196 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1197 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1198, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1200)
!1198 = !DISubroutineType(types: !1199)
!1199 = !{!203, !203, !778, !203}
!1200 = !{!1201, !1202, !1203, !1204}
!1201 = !DILocalVariable(name: "fd", arg: 1, scope: !1197, file: !2, line: 177, type: !203)
!1202 = !DILocalVariable(name: "arr", arg: 2, scope: !1197, file: !2, line: 177, type: !778)
!1203 = !DILocalVariable(name: "n", arg: 3, scope: !1197, file: !2, line: 177, type: !203)
!1204 = !DILocalVariable(name: "i", scope: !1197, file: !2, line: 177, type: !203)
!1205 = !DILocation(line: 0, scope: !1197)
!1206 = !DILocation(line: 177, column: 1, scope: !1207)
!1207 = distinct !DILexicalBlock(scope: !1208, file: !2, line: 177, column: 1)
!1208 = distinct !DILexicalBlock(scope: !1197, file: !2, line: 177, column: 1)
!1209 = !DILocation(line: 177, column: 1, scope: !1210)
!1210 = distinct !DILexicalBlock(scope: !1211, file: !2, line: 177, column: 1)
!1211 = distinct !DILexicalBlock(scope: !1197, file: !2, line: 177, column: 1)
!1212 = !DILocation(line: 177, column: 1, scope: !1211)
!1213 = !DILocation(line: 177, column: 1, scope: !1214)
!1214 = distinct !DILexicalBlock(scope: !1210, file: !2, line: 177, column: 1)
!1215 = distinct !{!1215, !1212, !1212, !371, !372}
!1216 = !DILocation(line: 177, column: 1, scope: !1197)
!1217 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1218, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1220)
!1218 = !DISubroutineType(cc: DW_CC_nocall, types: !1219)
!1219 = !{!203, !203, !697, null}
!1220 = !{!1221, !1222, !1223, !1227, !1228, !1229, !1230}
!1221 = !DILocalVariable(name: "fd", arg: 1, scope: !1217, file: !2, line: 15, type: !203)
!1222 = !DILocalVariable(name: "format", arg: 2, scope: !1217, file: !2, line: 15, type: !697)
!1223 = !DILocalVariable(name: "args", scope: !1217, file: !2, line: 16, type: !1224)
!1224 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1225, line: 12, baseType: !1226)
!1225 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1226 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !230)
!1227 = !DILocalVariable(name: "buffered", scope: !1217, file: !2, line: 17, type: !203)
!1228 = !DILocalVariable(name: "written", scope: !1217, file: !2, line: 17, type: !203)
!1229 = !DILocalVariable(name: "status", scope: !1217, file: !2, line: 17, type: !203)
!1230 = !DILocalVariable(name: "buffer", scope: !1217, file: !2, line: 18, type: !1231)
!1231 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !1232)
!1232 = !{!1233}
!1233 = !DISubrange(count: 256)
!1234 = distinct !DIAssignID()
!1235 = !DILocation(line: 0, scope: !1217)
!1236 = distinct !DIAssignID()
!1237 = !DILocation(line: 16, column: 3, scope: !1217)
!1238 = !DILocation(line: 18, column: 3, scope: !1217)
!1239 = !DILocation(line: 19, column: 3, scope: !1217)
!1240 = !DILocation(line: 20, column: 66, scope: !1217)
!1241 = !DILocation(line: 20, column: 14, scope: !1217)
!1242 = !DILocation(line: 21, column: 3, scope: !1217)
!1243 = !DILocation(line: 22, column: 3, scope: !1244)
!1244 = distinct !DILexicalBlock(scope: !1245, file: !2, line: 22, column: 3)
!1245 = distinct !DILexicalBlock(scope: !1217, file: !2, line: 22, column: 3)
!1246 = !DILocation(line: 24, column: 16, scope: !1217)
!1247 = !DILocation(line: 24, column: 3, scope: !1217)
!1248 = !DILocation(line: 27, column: 13, scope: !1249)
!1249 = distinct !DILexicalBlock(scope: !1217, file: !2, line: 24, column: 27)
!1250 = distinct !{!1250, !1247, !1251, !371, !372}
!1251 = !DILocation(line: 28, column: 3, scope: !1217)
!1252 = !DILocation(line: 25, column: 25, scope: !1249)
!1253 = !DILocation(line: 25, column: 50, scope: !1249)
!1254 = !DILocation(line: 25, column: 42, scope: !1249)
!1255 = !DILocation(line: 25, column: 14, scope: !1249)
!1256 = !DILocation(line: 26, column: 5, scope: !1257)
!1257 = distinct !DILexicalBlock(scope: !1258, file: !2, line: 26, column: 5)
!1258 = distinct !DILexicalBlock(scope: !1249, file: !2, line: 26, column: 5)
!1259 = !DILocation(line: 29, column: 3, scope: !1260)
!1260 = distinct !DILexicalBlock(scope: !1261, file: !2, line: 29, column: 3)
!1261 = distinct !DILexicalBlock(scope: !1217, file: !2, line: 29, column: 3)
!1262 = !DILocation(line: 31, column: 1, scope: !1217)
!1263 = !DILocation(line: 30, column: 3, scope: !1217)
!1264 = !DISubprogram(name: "vsnprintf", scope: !818, file: !818, line: 389, type: !1265, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1265 = !DISubroutineType(types: !1266)
!1266 = !{!203, !810, !706, !811, !1267}
!1267 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1268, line: 12, baseType: !1226)
!1268 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1269 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1270, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1272)
!1270 = !DISubroutineType(types: !1271)
!1271 = !{!203, !203, !878, !203}
!1272 = !{!1273, !1274, !1275, !1276}
!1273 = !DILocalVariable(name: "fd", arg: 1, scope: !1269, file: !2, line: 178, type: !203)
!1274 = !DILocalVariable(name: "arr", arg: 2, scope: !1269, file: !2, line: 178, type: !878)
!1275 = !DILocalVariable(name: "n", arg: 3, scope: !1269, file: !2, line: 178, type: !203)
!1276 = !DILocalVariable(name: "i", scope: !1269, file: !2, line: 178, type: !203)
!1277 = !DILocation(line: 0, scope: !1269)
!1278 = !DILocation(line: 178, column: 1, scope: !1279)
!1279 = distinct !DILexicalBlock(scope: !1280, file: !2, line: 178, column: 1)
!1280 = distinct !DILexicalBlock(scope: !1269, file: !2, line: 178, column: 1)
!1281 = !DILocation(line: 178, column: 1, scope: !1282)
!1282 = distinct !DILexicalBlock(scope: !1283, file: !2, line: 178, column: 1)
!1283 = distinct !DILexicalBlock(scope: !1269, file: !2, line: 178, column: 1)
!1284 = !DILocation(line: 178, column: 1, scope: !1283)
!1285 = !DILocation(line: 178, column: 1, scope: !1286)
!1286 = distinct !DILexicalBlock(scope: !1282, file: !2, line: 178, column: 1)
!1287 = distinct !{!1287, !1284, !1284, !371, !372}
!1288 = !DILocation(line: 178, column: 1, scope: !1269)
!1289 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1290, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1292)
!1290 = !DISubroutineType(types: !1291)
!1291 = !{!203, !203, !909, !203}
!1292 = !{!1293, !1294, !1295, !1296}
!1293 = !DILocalVariable(name: "fd", arg: 1, scope: !1289, file: !2, line: 179, type: !203)
!1294 = !DILocalVariable(name: "arr", arg: 2, scope: !1289, file: !2, line: 179, type: !909)
!1295 = !DILocalVariable(name: "n", arg: 3, scope: !1289, file: !2, line: 179, type: !203)
!1296 = !DILocalVariable(name: "i", scope: !1289, file: !2, line: 179, type: !203)
!1297 = !DILocation(line: 0, scope: !1289)
!1298 = !DILocation(line: 179, column: 1, scope: !1299)
!1299 = distinct !DILexicalBlock(scope: !1300, file: !2, line: 179, column: 1)
!1300 = distinct !DILexicalBlock(scope: !1289, file: !2, line: 179, column: 1)
!1301 = !DILocation(line: 179, column: 1, scope: !1302)
!1302 = distinct !DILexicalBlock(scope: !1303, file: !2, line: 179, column: 1)
!1303 = distinct !DILexicalBlock(scope: !1289, file: !2, line: 179, column: 1)
!1304 = !DILocation(line: 179, column: 1, scope: !1303)
!1305 = !DILocation(line: 179, column: 1, scope: !1306)
!1306 = distinct !DILexicalBlock(scope: !1302, file: !2, line: 179, column: 1)
!1307 = distinct !{!1307, !1304, !1304, !371, !372}
!1308 = !DILocation(line: 179, column: 1, scope: !1289)
!1309 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1310, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1312)
!1310 = !DISubroutineType(types: !1311)
!1311 = !{!203, !203, !940, !203}
!1312 = !{!1313, !1314, !1315, !1316}
!1313 = !DILocalVariable(name: "fd", arg: 1, scope: !1309, file: !2, line: 180, type: !203)
!1314 = !DILocalVariable(name: "arr", arg: 2, scope: !1309, file: !2, line: 180, type: !940)
!1315 = !DILocalVariable(name: "n", arg: 3, scope: !1309, file: !2, line: 180, type: !203)
!1316 = !DILocalVariable(name: "i", scope: !1309, file: !2, line: 180, type: !203)
!1317 = !DILocation(line: 0, scope: !1309)
!1318 = !DILocation(line: 180, column: 1, scope: !1319)
!1319 = distinct !DILexicalBlock(scope: !1320, file: !2, line: 180, column: 1)
!1320 = distinct !DILexicalBlock(scope: !1309, file: !2, line: 180, column: 1)
!1321 = !DILocation(line: 180, column: 1, scope: !1322)
!1322 = distinct !DILexicalBlock(scope: !1323, file: !2, line: 180, column: 1)
!1323 = distinct !DILexicalBlock(scope: !1309, file: !2, line: 180, column: 1)
!1324 = !DILocation(line: 180, column: 1, scope: !1323)
!1325 = !DILocation(line: 180, column: 1, scope: !1326)
!1326 = distinct !DILexicalBlock(scope: !1322, file: !2, line: 180, column: 1)
!1327 = distinct !{!1327, !1324, !1324, !371, !372}
!1328 = !DILocation(line: 180, column: 1, scope: !1309)
!1329 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1330, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1332)
!1330 = !DISubroutineType(types: !1331)
!1331 = !{!203, !203, !971, !203}
!1332 = !{!1333, !1334, !1335, !1336}
!1333 = !DILocalVariable(name: "fd", arg: 1, scope: !1329, file: !2, line: 181, type: !203)
!1334 = !DILocalVariable(name: "arr", arg: 2, scope: !1329, file: !2, line: 181, type: !971)
!1335 = !DILocalVariable(name: "n", arg: 3, scope: !1329, file: !2, line: 181, type: !203)
!1336 = !DILocalVariable(name: "i", scope: !1329, file: !2, line: 181, type: !203)
!1337 = !DILocation(line: 0, scope: !1329)
!1338 = !DILocation(line: 181, column: 1, scope: !1339)
!1339 = distinct !DILexicalBlock(scope: !1340, file: !2, line: 181, column: 1)
!1340 = distinct !DILexicalBlock(scope: !1329, file: !2, line: 181, column: 1)
!1341 = !DILocation(line: 181, column: 1, scope: !1342)
!1342 = distinct !DILexicalBlock(scope: !1343, file: !2, line: 181, column: 1)
!1343 = distinct !DILexicalBlock(scope: !1329, file: !2, line: 181, column: 1)
!1344 = !DILocation(line: 181, column: 1, scope: !1343)
!1345 = !DILocation(line: 181, column: 1, scope: !1346)
!1346 = distinct !DILexicalBlock(scope: !1342, file: !2, line: 181, column: 1)
!1347 = distinct !{!1347, !1344, !1344, !371, !372}
!1348 = !DILocation(line: 181, column: 1, scope: !1329)
!1349 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1350, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1352)
!1350 = !DISubroutineType(types: !1351)
!1351 = !{!203, !203, !1000, !203}
!1352 = !{!1353, !1354, !1355, !1356}
!1353 = !DILocalVariable(name: "fd", arg: 1, scope: !1349, file: !2, line: 182, type: !203)
!1354 = !DILocalVariable(name: "arr", arg: 2, scope: !1349, file: !2, line: 182, type: !1000)
!1355 = !DILocalVariable(name: "n", arg: 3, scope: !1349, file: !2, line: 182, type: !203)
!1356 = !DILocalVariable(name: "i", scope: !1349, file: !2, line: 182, type: !203)
!1357 = !DILocation(line: 0, scope: !1349)
!1358 = !DILocation(line: 182, column: 1, scope: !1359)
!1359 = distinct !DILexicalBlock(scope: !1360, file: !2, line: 182, column: 1)
!1360 = distinct !DILexicalBlock(scope: !1349, file: !2, line: 182, column: 1)
!1361 = !DILocation(line: 182, column: 1, scope: !1362)
!1362 = distinct !DILexicalBlock(scope: !1363, file: !2, line: 182, column: 1)
!1363 = distinct !DILexicalBlock(scope: !1349, file: !2, line: 182, column: 1)
!1364 = !DILocation(line: 182, column: 1, scope: !1363)
!1365 = !DILocation(line: 182, column: 1, scope: !1366)
!1366 = distinct !DILexicalBlock(scope: !1362, file: !2, line: 182, column: 1)
!1367 = distinct !{!1367, !1364, !1364, !371, !372}
!1368 = !DILocation(line: 182, column: 1, scope: !1349)
!1369 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !1370, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1372)
!1370 = !DISubroutineType(types: !1371)
!1371 = !{!203, !203, !1029, !203}
!1372 = !{!1373, !1374, !1375, !1376}
!1373 = !DILocalVariable(name: "fd", arg: 1, scope: !1369, file: !2, line: 183, type: !203)
!1374 = !DILocalVariable(name: "arr", arg: 2, scope: !1369, file: !2, line: 183, type: !1029)
!1375 = !DILocalVariable(name: "n", arg: 3, scope: !1369, file: !2, line: 183, type: !203)
!1376 = !DILocalVariable(name: "i", scope: !1369, file: !2, line: 183, type: !203)
!1377 = !DILocation(line: 0, scope: !1369)
!1378 = !DILocation(line: 183, column: 1, scope: !1379)
!1379 = distinct !DILexicalBlock(scope: !1380, file: !2, line: 183, column: 1)
!1380 = distinct !DILexicalBlock(scope: !1369, file: !2, line: 183, column: 1)
!1381 = !DILocation(line: 183, column: 1, scope: !1382)
!1382 = distinct !DILexicalBlock(scope: !1383, file: !2, line: 183, column: 1)
!1383 = distinct !DILexicalBlock(scope: !1369, file: !2, line: 183, column: 1)
!1384 = !DILocation(line: 183, column: 1, scope: !1383)
!1385 = !DILocation(line: 183, column: 1, scope: !1386)
!1386 = distinct !DILexicalBlock(scope: !1382, file: !2, line: 183, column: 1)
!1387 = distinct !{!1387, !1384, !1384, !371, !372}
!1388 = !DILocation(line: 183, column: 1, scope: !1369)
!1389 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1390, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1392)
!1390 = !DISubroutineType(types: !1391)
!1391 = !{!203, !203, !1058, !203}
!1392 = !{!1393, !1394, !1395, !1396}
!1393 = !DILocalVariable(name: "fd", arg: 1, scope: !1389, file: !2, line: 184, type: !203)
!1394 = !DILocalVariable(name: "arr", arg: 2, scope: !1389, file: !2, line: 184, type: !1058)
!1395 = !DILocalVariable(name: "n", arg: 3, scope: !1389, file: !2, line: 184, type: !203)
!1396 = !DILocalVariable(name: "i", scope: !1389, file: !2, line: 184, type: !203)
!1397 = !DILocation(line: 0, scope: !1389)
!1398 = !DILocation(line: 184, column: 1, scope: !1399)
!1399 = distinct !DILexicalBlock(scope: !1400, file: !2, line: 184, column: 1)
!1400 = distinct !DILexicalBlock(scope: !1389, file: !2, line: 184, column: 1)
!1401 = !DILocation(line: 184, column: 1, scope: !1402)
!1402 = distinct !DILexicalBlock(scope: !1403, file: !2, line: 184, column: 1)
!1403 = distinct !DILexicalBlock(scope: !1389, file: !2, line: 184, column: 1)
!1404 = !DILocation(line: 184, column: 1, scope: !1403)
!1405 = !DILocation(line: 184, column: 1, scope: !1406)
!1406 = distinct !DILexicalBlock(scope: !1402, file: !2, line: 184, column: 1)
!1407 = distinct !{!1407, !1404, !1404, !371, !372}
!1408 = !DILocation(line: 184, column: 1, scope: !1389)
!1409 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1410, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1412)
!1410 = !DISubroutineType(types: !1411)
!1411 = !{!203, !203, !1087, !203}
!1412 = !{!1413, !1414, !1415, !1416}
!1413 = !DILocalVariable(name: "fd", arg: 1, scope: !1409, file: !2, line: 186, type: !203)
!1414 = !DILocalVariable(name: "arr", arg: 2, scope: !1409, file: !2, line: 186, type: !1087)
!1415 = !DILocalVariable(name: "n", arg: 3, scope: !1409, file: !2, line: 186, type: !203)
!1416 = !DILocalVariable(name: "i", scope: !1409, file: !2, line: 186, type: !203)
!1417 = !DILocation(line: 0, scope: !1409)
!1418 = !DILocation(line: 186, column: 1, scope: !1419)
!1419 = distinct !DILexicalBlock(scope: !1420, file: !2, line: 186, column: 1)
!1420 = distinct !DILexicalBlock(scope: !1409, file: !2, line: 186, column: 1)
!1421 = !DILocation(line: 186, column: 1, scope: !1422)
!1422 = distinct !DILexicalBlock(scope: !1423, file: !2, line: 186, column: 1)
!1423 = distinct !DILexicalBlock(scope: !1409, file: !2, line: 186, column: 1)
!1424 = !DILocation(line: 186, column: 1, scope: !1423)
!1425 = !DILocation(line: 186, column: 1, scope: !1426)
!1426 = distinct !DILexicalBlock(scope: !1422, file: !2, line: 186, column: 1)
!1427 = distinct !{!1427, !1424, !1424, !371, !372}
!1428 = !DILocation(line: 186, column: 1, scope: !1409)
!1429 = !DILocation(line: 0, scope: !498)
!1430 = !DILocation(line: 187, column: 1, scope: !1431)
!1431 = distinct !DILexicalBlock(scope: !1432, file: !2, line: 187, column: 1)
!1432 = distinct !DILexicalBlock(scope: !498, file: !2, line: 187, column: 1)
!1433 = !DILocation(line: 187, column: 1, scope: !511)
!1434 = !DILocation(line: 187, column: 1, scope: !508)
!1435 = !DILocation(line: 187, column: 1, scope: !510)
!1436 = distinct !{!1436, !1434, !1434, !371, !372}
!1437 = !DILocation(line: 187, column: 1, scope: !498)
!1438 = !DILocation(line: 0, scope: !487)
!1439 = !DILocation(line: 190, column: 3, scope: !494)
!1440 = !DILocation(line: 191, column: 3, scope: !487)
!1441 = !DILocation(line: 192, column: 3, scope: !487)
!1442 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1443, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !292, retainedNodes: !1445)
!1443 = !DISubroutineType(types: !1444)
!1444 = !{!203, !203, !816}
!1445 = !{!1446, !1447, !1448, !1449, !1450, !1451, !1452, !1453, !1454}
!1446 = !DILocalVariable(name: "argc", arg: 1, scope: !1442, file: !170, line: 14, type: !203)
!1447 = !DILocalVariable(name: "argv", arg: 2, scope: !1442, file: !170, line: 14, type: !816)
!1448 = !DILocalVariable(name: "in_file", scope: !1442, file: !170, line: 17, type: !229)
!1449 = !DILocalVariable(name: "check_file", scope: !1442, file: !170, line: 19, type: !229)
!1450 = !DILocalVariable(name: "in_fd", scope: !1442, file: !170, line: 34, type: !203)
!1451 = !DILocalVariable(name: "data", scope: !1442, file: !170, line: 35, type: !229)
!1452 = !DILocalVariable(name: "out_fd", scope: !1442, file: !170, line: 46, type: !203)
!1453 = !DILocalVariable(name: "check_fd", scope: !1442, file: !170, line: 55, type: !203)
!1454 = !DILocalVariable(name: "ref", scope: !1442, file: !170, line: 56, type: !229)
!1455 = !DILocation(line: 0, scope: !1442)
!1456 = !DILocation(line: 21, column: 3, scope: !1457)
!1457 = distinct !DILexicalBlock(scope: !1458, file: !170, line: 21, column: 3)
!1458 = distinct !DILexicalBlock(scope: !1442, file: !170, line: 21, column: 3)
!1459 = !DILocation(line: 26, column: 11, scope: !1460)
!1460 = distinct !DILexicalBlock(scope: !1442, file: !170, line: 26, column: 7)
!1461 = !DILocation(line: 26, column: 7, scope: !1442)
!1462 = !DILocation(line: 27, column: 15, scope: !1460)
!1463 = !DILocation(line: 29, column: 11, scope: !1464)
!1464 = distinct !DILexicalBlock(scope: !1442, file: !170, line: 29, column: 7)
!1465 = !DILocation(line: 29, column: 7, scope: !1442)
!1466 = !DILocation(line: 30, column: 18, scope: !1464)
!1467 = !DILocation(line: 30, column: 5, scope: !1464)
!1468 = !DILocation(line: 36, column: 17, scope: !1442)
!1469 = !DILocation(line: 36, column: 10, scope: !1442)
!1470 = !DILocation(line: 37, column: 3, scope: !1471)
!1471 = distinct !DILexicalBlock(scope: !1472, file: !170, line: 37, column: 3)
!1472 = distinct !DILexicalBlock(scope: !1442, file: !170, line: 37, column: 3)
!1473 = !DILocation(line: 38, column: 11, scope: !1442)
!1474 = !DILocation(line: 39, column: 3, scope: !1475)
!1475 = distinct !DILexicalBlock(scope: !1476, file: !170, line: 39, column: 3)
!1476 = distinct !DILexicalBlock(scope: !1442, file: !170, line: 39, column: 3)
!1477 = !DILocation(line: 48, column: 3, scope: !1478)
!1478 = distinct !DILexicalBlock(scope: !1479, file: !170, line: 48, column: 3)
!1479 = distinct !DILexicalBlock(scope: !1442, file: !170, line: 48, column: 3)
!1480 = !DILocation(line: 0, scope: !556, inlinedAt: !1481)
!1481 = distinct !DILocation(line: 49, column: 3, scope: !1442)
!1482 = !DILocation(line: 0, scope: !487, inlinedAt: !1483)
!1483 = distinct !DILocation(line: 66, column: 3, scope: !556, inlinedAt: !1481)
!1484 = !DILocation(line: 190, column: 3, scope: !494, inlinedAt: !1483)
!1485 = !DILocation(line: 191, column: 3, scope: !487, inlinedAt: !1483)
!1486 = !DILocation(line: 0, scope: !498, inlinedAt: !1487)
!1487 = distinct !DILocation(line: 67, column: 3, scope: !556, inlinedAt: !1481)
!1488 = !DILocation(line: 187, column: 1, scope: !508, inlinedAt: !1487)
!1489 = !DILocation(line: 187, column: 1, scope: !510, inlinedAt: !1487)
!1490 = !DILocation(line: 187, column: 1, scope: !511, inlinedAt: !1487)
!1491 = distinct !{!1491, !1488, !1488, !371, !372}
!1492 = !DILocation(line: 50, column: 3, scope: !1442)
!1493 = !DILocation(line: 57, column: 16, scope: !1442)
!1494 = !DILocation(line: 57, column: 9, scope: !1442)
!1495 = !DILocation(line: 58, column: 3, scope: !1496)
!1496 = distinct !DILexicalBlock(scope: !1497, file: !170, line: 58, column: 3)
!1497 = distinct !DILexicalBlock(scope: !1442, file: !170, line: 58, column: 3)
!1498 = !DILocation(line: 59, column: 14, scope: !1442)
!1499 = !DILocation(line: 60, column: 3, scope: !1500)
!1500 = distinct !DILexicalBlock(scope: !1501, file: !170, line: 60, column: 3)
!1501 = distinct !DILexicalBlock(scope: !1442, file: !170, line: 60, column: 3)
!1502 = !DILocation(line: 0, scope: !525, inlinedAt: !1503)
!1503 = distinct !DILocation(line: 61, column: 3, scope: !1442)
!1504 = !DILocation(line: 56, column: 7, scope: !525, inlinedAt: !1503)
!1505 = !DILocation(line: 0, scope: !427, inlinedAt: !1506)
!1506 = distinct !DILocation(line: 58, column: 7, scope: !525, inlinedAt: !1503)
!1507 = !DILocation(line: 64, column: 17, scope: !427, inlinedAt: !1506)
!1508 = !DILocation(line: 64, column: 3, scope: !427, inlinedAt: !1506)
!1509 = !DILocation(line: 66, column: 22, scope: !439, inlinedAt: !1506)
!1510 = !DILocation(line: 66, column: 26, scope: !439, inlinedAt: !1506)
!1511 = !DILocation(line: 66, column: 32, scope: !439, inlinedAt: !1506)
!1512 = !DILocation(line: 66, column: 35, scope: !439, inlinedAt: !1506)
!1513 = !DILocation(line: 66, column: 39, scope: !439, inlinedAt: !1506)
!1514 = !DILocation(line: 66, column: 9, scope: !440, inlinedAt: !1506)
!1515 = !DILocation(line: 69, column: 6, scope: !440, inlinedAt: !1506)
!1516 = !DILocation(line: 64, column: 10, scope: !427, inlinedAt: !1506)
!1517 = !DILocation(line: 64, column: 13, scope: !427, inlinedAt: !1506)
!1518 = distinct !{!1518, !1508, !1519, !371, !372}
!1519 = !DILocation(line: 70, column: 3, scope: !427, inlinedAt: !1506)
!1520 = !DILocation(line: 71, column: 6, scope: !452, inlinedAt: !1506)
!1521 = !DILocation(line: 71, column: 8, scope: !452, inlinedAt: !1506)
!1522 = !DILocation(line: 71, column: 6, scope: !427, inlinedAt: !1506)
!1523 = !DILocation(line: 59, column: 37, scope: !525, inlinedAt: !1503)
!1524 = !DILocation(line: 59, column: 3, scope: !525, inlinedAt: !1503)
!1525 = !DILocation(line: 60, column: 3, scope: !525, inlinedAt: !1503)
!1526 = !DILocation(line: 0, scope: !574, inlinedAt: !1527)
!1527 = distinct !DILocation(line: 66, column: 8, scope: !1528)
!1528 = distinct !DILexicalBlock(scope: !1442, file: !170, line: 66, column: 7)
!1529 = !DILocation(line: 77, column: 3, scope: !588, inlinedAt: !1527)
!1530 = !DILocation(line: 78, column: 5, scope: !590, inlinedAt: !1527)
!1531 = !DILocation(line: 79, column: 36, scope: !594, inlinedAt: !1527)
!1532 = !DILocation(line: 79, column: 14, scope: !594, inlinedAt: !1527)
!1533 = !DILocation(line: 79, column: 43, scope: !594, inlinedAt: !1527)
!1534 = !DILocation(line: 79, column: 41, scope: !594, inlinedAt: !1527)
!1535 = !DILocation(line: 80, column: 37, scope: !594, inlinedAt: !1527)
!1536 = !DILocation(line: 80, column: 18, scope: !594, inlinedAt: !1527)
!1537 = !DILocation(line: 78, column: 28, scope: !595, inlinedAt: !1527)
!1538 = !DILocation(line: 78, column: 16, scope: !595, inlinedAt: !1527)
!1539 = distinct !{!1539, !1530, !1540, !371, !372}
!1540 = !DILocation(line: 81, column: 5, scope: !590, inlinedAt: !1527)
!1541 = !DILocation(line: 77, column: 26, scope: !592, inlinedAt: !1527)
!1542 = !DILocation(line: 77, column: 14, scope: !592, inlinedAt: !1527)
!1543 = distinct !{!1543, !1529, !1544, !371, !372}
!1544 = !DILocation(line: 82, column: 3, scope: !588, inlinedAt: !1527)
!1545 = !DILocation(line: 85, column: 10, scope: !574, inlinedAt: !1527)
!1546 = !DILocation(line: 66, column: 7, scope: !1442)
!1547 = !DILocation(line: 67, column: 13, scope: !1548)
!1548 = distinct !DILexicalBlock(scope: !1528, file: !170, line: 66, column: 32)
!1549 = !DILocation(line: 67, column: 5, scope: !1548)
!1550 = !DILocation(line: 68, column: 5, scope: !1548)
!1551 = !DILocation(line: 71, column: 3, scope: !1442)
!1552 = !DILocation(line: 72, column: 3, scope: !1442)
!1553 = !DILocation(line: 74, column: 3, scope: !1442)
!1554 = !DILocation(line: 75, column: 3, scope: !1442)
!1555 = !DILocation(line: 76, column: 1, scope: !1442)
!1556 = !DILocation(line: 40, column: 3, scope: !1442)
!1557 = !DILocation(line: 0, scope: !396, inlinedAt: !1558)
!1558 = distinct !DILocation(line: 43, column: 3, scope: !1442)
!1559 = !DILocation(line: 10, column: 25, scope: !396, inlinedAt: !1558)
!1560 = !DILocation(line: 0, scope: !325, inlinedAt: !1561)
!1561 = distinct !DILocation(line: 10, column: 3, scope: !396, inlinedAt: !1558)
!1562 = !DILocation(line: 8, column: 5, scope: !325, inlinedAt: !1561)
!1563 = !{!1564}
!1564 = distinct !{!1564, !1565, !"polly.alias.scope.MemRef1"}
!1565 = distinct !{!1565, !"polly.alias.scope.domain"}
!1566 = !DILocation(line: 14, column: 38, scope: !357, inlinedAt: !1561)
!1567 = !DILocation(line: 15, column: 21, scope: !357, inlinedAt: !1561)
!1568 = !DILocation(line: 47, column: 12, scope: !1442)
!1569 = !DISubprogram(name: "open", scope: !1570, file: !1570, line: 209, type: !1571, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1570 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1571 = !DISubroutineType(types: !1572)
!1572 = !{!203, !697, !203, null}
