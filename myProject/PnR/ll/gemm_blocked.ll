; ModuleID = 'gemm/blocked/gemm_opt.bc'
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
define dso_local void @gemm(ptr nocapture noundef readonly %m1, ptr nocapture noundef readonly %m2, ptr nocapture noundef %prod) local_unnamed_addr #0 !dbg !325 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
  %indvars.iv61.reg2mem14 = alloca i64, align 8
  %i.056.reg2mem16 = alloca i32, align 4
  %indvars.iv67.reg2mem18 = alloca i64, align 8
  %indvars.iv69.reg2mem20 = alloca i64, align 8
    #dbg_value(ptr %m1, !330, !DIExpression(), !359)
    #dbg_value(ptr %m2, !331, !DIExpression(), !359)
    #dbg_value(ptr %prod, !332, !DIExpression(), !359)
    #dbg_label(!342, !360)
    #dbg_value(i32 0, !336, !DIExpression(), !359)
  store i64 0, ptr %indvars.iv69.reg2mem20, align 8
  br label %for.cond1.preheader, !dbg !361

for.cond1.preheader:                              ; preds = %for.inc36.for.cond1.preheader_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv69.reg2mem20.0.load, !336, !DIExpression(), !359)
    #dbg_value(i32 0, !337, !DIExpression(), !359)
  %indvars.iv69.reg2mem20.0.load = load i64, ptr %indvars.iv69.reg2mem20, align 8
  %invariant.gep73 = getelementptr double, ptr %m2, i64 %indvars.iv69.reg2mem20.0.load
  store i64 0, ptr %indvars.iv67.reg2mem18, align 8
  br label %for.cond4.preheader, !dbg !362

for.cond4.preheader:                              ; preds = %for.inc33.for.cond4.preheader_crit_edge, %for.cond1.preheader
    #dbg_value(i64 %indvars.iv67.reg2mem18.0.load, !337, !DIExpression(), !359)
    #dbg_value(i32 0, !333, !DIExpression(), !359)
  %indvars.iv67.reg2mem18.0.load = load i64, ptr %indvars.iv67.reg2mem18, align 8
  store i32 0, ptr %i.056.reg2mem16, align 4
  br label %for.cond7.preheader, !dbg !363

for.cond7.preheader:                              ; preds = %for.inc30.for.cond7.preheader_crit_edge, %for.cond4.preheader
    #dbg_value(i32 %i.056.reg2mem16.0.load, !333, !DIExpression(), !359)
  %i.056.reg2mem16.0.load = load i32, ptr %i.056.reg2mem16, align 4
  %mul10 = shl nuw nsw i32 %i.056.reg2mem16.0.load, 6
    #dbg_value(i32 0, !334, !DIExpression(), !359)
  store i64 0, ptr %indvars.iv61.reg2mem14, align 8
  br label %for.body9, !dbg !364

for.body9:                                        ; preds = %for.inc27.for.body9_crit_edge, %for.cond7.preheader
    #dbg_value(i64 %indvars.iv61.reg2mem14.0.load, !334, !DIExpression(), !359)
    #dbg_value(i32 %mul10, !338, !DIExpression(), !359)
  %indvars.iv61.reg2mem14.0.load = load i64, ptr %indvars.iv61.reg2mem14, align 8
  %0 = add nuw nsw i64 %indvars.iv61.reg2mem14.0.load, %indvars.iv67.reg2mem18.0.load, !dbg !365
    #dbg_value(i64 %0, !339, !DIExpression(DW_OP_constu, 6, DW_OP_shl, DW_OP_stack_value), !359)
  %1 = or i64 %indvars.iv61.reg2mem14.0.load, %indvars.iv67.reg2mem18.0.load, !dbg !366
  %2 = trunc i64 %1 to i32, !dbg !366
  %add13 = or i32 %mul10, %2, !dbg !366
  %idxprom = zext nneg i32 %add13 to i64, !dbg !367
  %arrayidx = getelementptr inbounds double, ptr %m1, i64 %idxprom, !dbg !367
  %3 = load double, ptr %arrayidx, align 8, !dbg !367
    #dbg_value(double %3, !340, !DIExpression(), !359)
    #dbg_label(!355, !368)
    #dbg_value(i32 0, !335, !DIExpression(), !359)
  %gep.idx = shl i64 %0, 9, !dbg !369
  %gep = getelementptr i8, ptr %invariant.gep73, i64 %gep.idx, !dbg !369
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body16, !dbg !369

for.body16:                                       ; preds = %for.body16.for.body16_crit_edge, %for.body9
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !335, !DIExpression(), !359)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %gep72 = getelementptr double, ptr %gep, i64 %indvars.iv.reg2mem.0.load, !dbg !371
  %4 = load double, ptr %gep72, align 8, !dbg !371, !tbaa !374
  %mul21 = fmul double %3, %4, !dbg !378
    #dbg_value(double %mul21, !341, !DIExpression(), !359)
  %5 = or i64 %indvars.iv.reg2mem.0.load, %indvars.iv69.reg2mem20.0.load, !dbg !379
  %6 = trunc i64 %5 to i32, !dbg !379
  %add23 = or i32 %mul10, %6, !dbg !379
  %idxprom24 = zext nneg i32 %add23 to i64, !dbg !380
  %arrayidx25 = getelementptr inbounds double, ptr %prod, i64 %idxprom24, !dbg !380
  %7 = load double, ptr %arrayidx25, align 8, !dbg !381, !tbaa !374
  %add26 = fadd double %7, %mul21, !dbg !381
  store double %add26, ptr %arrayidx25, align 8, !dbg !381, !tbaa !374
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !382
    #dbg_value(i64 %indvars.iv.next, !335, !DIExpression(), !359)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 8, !dbg !383
  br i1 %exitcond.not, label %for.inc27, label %for.body16.for.body16_crit_edge, !dbg !369, !llvm.loop !384

for.body16.for.body16_crit_edge:                  ; preds = %for.body16
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body16, !dbg !369

for.inc27:                                        ; preds = %for.body16
  %indvars.iv.next62 = add nuw nsw i64 %indvars.iv61.reg2mem14.0.load, 1, !dbg !388
    #dbg_value(i64 %indvars.iv.next62, !334, !DIExpression(), !359)
  %exitcond65.not = icmp eq i64 %indvars.iv.next62, 8, !dbg !389
  br i1 %exitcond65.not, label %for.inc30, label %for.inc27.for.body9_crit_edge, !dbg !364, !llvm.loop !390

for.inc27.for.body9_crit_edge:                    ; preds = %for.inc27
  store i64 %indvars.iv.next62, ptr %indvars.iv61.reg2mem14, align 8
  br label %for.body9, !dbg !364

for.inc30:                                        ; preds = %for.inc27
  %inc31 = add nuw nsw i32 %i.056.reg2mem16.0.load, 1, !dbg !392
    #dbg_value(i32 %inc31, !333, !DIExpression(), !359)
  %exitcond66.not = icmp eq i32 %inc31, 64, !dbg !393
  br i1 %exitcond66.not, label %for.inc33, label %for.inc30.for.cond7.preheader_crit_edge, !dbg !363, !llvm.loop !394

for.inc30.for.cond7.preheader_crit_edge:          ; preds = %for.inc30
  store i32 %inc31, ptr %i.056.reg2mem16, align 4
  br label %for.cond7.preheader, !dbg !363

for.inc33:                                        ; preds = %for.inc30
  %indvars.iv.next68 = add nuw nsw i64 %indvars.iv67.reg2mem18.0.load, 8, !dbg !396
    #dbg_value(i64 %indvars.iv.next68, !337, !DIExpression(), !359)
  %cmp2 = icmp ult i64 %indvars.iv67.reg2mem18.0.load, 56, !dbg !397
  br i1 %cmp2, label %for.inc33.for.cond4.preheader_crit_edge, label %for.inc36, !dbg !362, !llvm.loop !398

for.inc33.for.cond4.preheader_crit_edge:          ; preds = %for.inc33
  store i64 %indvars.iv.next68, ptr %indvars.iv67.reg2mem18, align 8
  br label %for.cond4.preheader, !dbg !362

for.inc36:                                        ; preds = %for.inc33
  %indvars.iv.next70 = add nuw nsw i64 %indvars.iv69.reg2mem20.0.load, 8, !dbg !400
    #dbg_value(i64 %indvars.iv.next70, !336, !DIExpression(), !359)
  %cmp = icmp ult i64 %indvars.iv69.reg2mem20.0.load, 56, !dbg !401
  br i1 %cmp, label %for.inc36.for.cond1.preheader_crit_edge, label %for.end38, !dbg !361, !llvm.loop !402

for.inc36.for.cond1.preheader_crit_edge:          ; preds = %for.inc36
  store i64 %indvars.iv.next70, ptr %indvars.iv69.reg2mem20, align 8
  br label %for.cond1.preheader, !dbg !361

for.end38:                                        ; preds = %for.inc36
  ret void, !dbg !404
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #0 !dbg !405 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %indvars.iv61.i.reg2mem14 = alloca i64, align 8
  %i.056.i.reg2mem16 = alloca i32, align 4
  %indvars.iv67.i.reg2mem18 = alloca i64, align 8
  %indvars.iv69.i.reg2mem20 = alloca i64, align 8
    #dbg_value(ptr %vargs, !409, !DIExpression(), !411)
    #dbg_value(ptr %vargs, !410, !DIExpression(), !411)
  %m2 = getelementptr inbounds i8, ptr %vargs, i64 32768, !dbg !412
  %prod = getelementptr inbounds i8, ptr %vargs, i64 65536, !dbg !413
    #dbg_value(ptr %vargs, !330, !DIExpression(), !414)
    #dbg_value(ptr %m2, !331, !DIExpression(), !414)
    #dbg_value(ptr %prod, !332, !DIExpression(), !414)
    #dbg_label(!342, !416)
    #dbg_value(i32 0, !336, !DIExpression(), !414)
  store i64 0, ptr %indvars.iv69.i.reg2mem20, align 8
  br label %for.cond1.preheader.i, !dbg !417

for.cond1.preheader.i:                            ; preds = %for.inc36.i.for.cond1.preheader.i_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv69.i.reg2mem20.0.load, !336, !DIExpression(), !414)
    #dbg_value(i32 0, !337, !DIExpression(), !414)
  %indvars.iv69.i.reg2mem20.0.load = load i64, ptr %indvars.iv69.i.reg2mem20, align 8
  %invariant.gep73.i = getelementptr double, ptr %m2, i64 %indvars.iv69.i.reg2mem20.0.load
  store i64 0, ptr %indvars.iv67.i.reg2mem18, align 8
  br label %for.cond4.preheader.i, !dbg !418

for.cond4.preheader.i:                            ; preds = %for.inc33.i.for.cond4.preheader.i_crit_edge, %for.cond1.preheader.i
    #dbg_value(i64 %indvars.iv67.i.reg2mem18.0.load, !337, !DIExpression(), !414)
    #dbg_value(i32 0, !333, !DIExpression(), !414)
  %indvars.iv67.i.reg2mem18.0.load = load i64, ptr %indvars.iv67.i.reg2mem18, align 8
  store i32 0, ptr %i.056.i.reg2mem16, align 4
  br label %for.cond7.preheader.i, !dbg !419

for.cond7.preheader.i:                            ; preds = %for.inc30.i.for.cond7.preheader.i_crit_edge, %for.cond4.preheader.i
    #dbg_value(i32 %i.056.i.reg2mem16.0.load, !333, !DIExpression(), !414)
  %i.056.i.reg2mem16.0.load = load i32, ptr %i.056.i.reg2mem16, align 4
  %mul10.i = shl nuw nsw i32 %i.056.i.reg2mem16.0.load, 6
    #dbg_value(i32 0, !334, !DIExpression(), !414)
  store i64 0, ptr %indvars.iv61.i.reg2mem14, align 8
  br label %for.body9.i, !dbg !420

for.body9.i:                                      ; preds = %for.inc27.i.for.body9.i_crit_edge, %for.cond7.preheader.i
    #dbg_value(i64 %indvars.iv61.i.reg2mem14.0.load, !334, !DIExpression(), !414)
    #dbg_value(i32 %mul10.i, !338, !DIExpression(), !414)
  %indvars.iv61.i.reg2mem14.0.load = load i64, ptr %indvars.iv61.i.reg2mem14, align 8
  %0 = add nuw nsw i64 %indvars.iv61.i.reg2mem14.0.load, %indvars.iv67.i.reg2mem18.0.load, !dbg !421
    #dbg_value(i64 %0, !339, !DIExpression(DW_OP_constu, 6, DW_OP_shl, DW_OP_stack_value), !414)
  %1 = or i64 %indvars.iv61.i.reg2mem14.0.load, %indvars.iv67.i.reg2mem18.0.load, !dbg !422
  %2 = trunc i64 %1 to i32, !dbg !422
  %add13.i = or i32 %mul10.i, %2, !dbg !422
  %idxprom.i = zext nneg i32 %add13.i to i64, !dbg !423
  %arrayidx.i = getelementptr inbounds double, ptr %vargs, i64 %idxprom.i, !dbg !423
  %3 = load double, ptr %arrayidx.i, align 8, !dbg !423
    #dbg_value(double %3, !340, !DIExpression(), !414)
    #dbg_label(!355, !424)
    #dbg_value(i32 0, !335, !DIExpression(), !414)
  %gep.idx.i = shl i64 %0, 9, !dbg !425
  %gep.i = getelementptr i8, ptr %invariant.gep73.i, i64 %gep.idx.i, !dbg !425
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body16.i, !dbg !425

for.body16.i:                                     ; preds = %for.body16.i.for.body16.i_crit_edge, %for.body9.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !335, !DIExpression(), !414)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %gep72.i = getelementptr double, ptr %gep.i, i64 %indvars.iv.i.reg2mem.0.load, !dbg !426
  %4 = load double, ptr %gep72.i, align 8, !dbg !426, !tbaa !374
  %mul21.i = fmul double %3, %4, !dbg !427
    #dbg_value(double %mul21.i, !341, !DIExpression(), !414)
  %5 = or i64 %indvars.iv.i.reg2mem.0.load, %indvars.iv69.i.reg2mem20.0.load, !dbg !428
  %6 = trunc i64 %5 to i32, !dbg !428
  %add23.i = or i32 %mul10.i, %6, !dbg !428
  %idxprom24.i = zext nneg i32 %add23.i to i64, !dbg !429
  %arrayidx25.i = getelementptr inbounds double, ptr %prod, i64 %idxprom24.i, !dbg !429
  %7 = load double, ptr %arrayidx25.i, align 8, !dbg !430, !tbaa !374
  %add26.i = fadd double %7, %mul21.i, !dbg !430
  store double %add26.i, ptr %arrayidx25.i, align 8, !dbg !430, !tbaa !374
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !431
    #dbg_value(i64 %indvars.iv.next.i, !335, !DIExpression(), !414)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 8, !dbg !432
  br i1 %exitcond.not.i, label %for.inc27.i, label %for.body16.i.for.body16.i_crit_edge, !dbg !425, !llvm.loop !433

for.body16.i.for.body16.i_crit_edge:              ; preds = %for.body16.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body16.i, !dbg !425

for.inc27.i:                                      ; preds = %for.body16.i
  %indvars.iv.next62.i = add nuw nsw i64 %indvars.iv61.i.reg2mem14.0.load, 1, !dbg !435
    #dbg_value(i64 %indvars.iv.next62.i, !334, !DIExpression(), !414)
  %exitcond65.not.i = icmp eq i64 %indvars.iv.next62.i, 8, !dbg !436
  br i1 %exitcond65.not.i, label %for.inc30.i, label %for.inc27.i.for.body9.i_crit_edge, !dbg !420, !llvm.loop !437

for.inc27.i.for.body9.i_crit_edge:                ; preds = %for.inc27.i
  store i64 %indvars.iv.next62.i, ptr %indvars.iv61.i.reg2mem14, align 8
  br label %for.body9.i, !dbg !420

for.inc30.i:                                      ; preds = %for.inc27.i
  %inc31.i = add nuw nsw i32 %i.056.i.reg2mem16.0.load, 1, !dbg !439
    #dbg_value(i32 %inc31.i, !333, !DIExpression(), !414)
  %exitcond66.not.i = icmp eq i32 %inc31.i, 64, !dbg !440
  br i1 %exitcond66.not.i, label %for.inc33.i, label %for.inc30.i.for.cond7.preheader.i_crit_edge, !dbg !419, !llvm.loop !441

for.inc30.i.for.cond7.preheader.i_crit_edge:      ; preds = %for.inc30.i
  store i32 %inc31.i, ptr %i.056.i.reg2mem16, align 4
  br label %for.cond7.preheader.i, !dbg !419

for.inc33.i:                                      ; preds = %for.inc30.i
  %indvars.iv.next68.i = add nuw nsw i64 %indvars.iv67.i.reg2mem18.0.load, 8, !dbg !443
    #dbg_value(i64 %indvars.iv.next68.i, !337, !DIExpression(), !414)
  %cmp2.i = icmp ult i64 %indvars.iv67.i.reg2mem18.0.load, 56, !dbg !444
  br i1 %cmp2.i, label %for.inc33.i.for.cond4.preheader.i_crit_edge, label %for.inc36.i, !dbg !418, !llvm.loop !445

for.inc33.i.for.cond4.preheader.i_crit_edge:      ; preds = %for.inc33.i
  store i64 %indvars.iv.next68.i, ptr %indvars.iv67.i.reg2mem18, align 8
  br label %for.cond4.preheader.i, !dbg !418

for.inc36.i:                                      ; preds = %for.inc33.i
  %indvars.iv.next70.i = add nuw nsw i64 %indvars.iv69.i.reg2mem20.0.load, 8, !dbg !447
    #dbg_value(i64 %indvars.iv.next70.i, !336, !DIExpression(), !414)
  %cmp.i = icmp ult i64 %indvars.iv69.i.reg2mem20.0.load, 56, !dbg !448
  br i1 %cmp.i, label %for.inc36.i.for.cond1.preheader.i_crit_edge, label %gemm.exit, !dbg !417, !llvm.loop !449

for.inc36.i.for.cond1.preheader.i_crit_edge:      ; preds = %for.inc36.i
  store i64 %indvars.iv.next70.i, ptr %indvars.iv69.i.reg2mem20, align 8
  br label %for.cond1.preheader.i, !dbg !417

gemm.exit:                                        ; preds = %for.inc36.i
  ret void, !dbg !451
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !452 {
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
    #dbg_value(i32 %fd, !456, !DIExpression(), !461)
    #dbg_value(ptr %vdata, !457, !DIExpression(), !461)
    #dbg_value(ptr %vdata, !458, !DIExpression(), !461)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(98304) %vdata, i8 0, i64 98304, i1 false), !dbg !462
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !463
    #dbg_value(ptr %call, !459, !DIExpression(), !461)
    #dbg_value(ptr %call, !464, !DIExpression(), !471)
    #dbg_value(i32 1, !469, !DIExpression(), !471)
    #dbg_value(i32 0, !470, !DIExpression(), !471)
  store ptr %call, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 0, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem72.0.load, !470, !DIExpression(), !471)
    #dbg_value(ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, !464, !DIExpression(), !471)
  %i.041.i.reg2mem72.0.load = load i32, ptr %i.041.i.reg2mem72, align 4
  %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71 = load ptr, ptr %s.addr.040.i.reg2mem70, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, align 1, !dbg !473, !tbaa !474
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !475

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !475

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !475

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !476
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !476, !tbaa !474
  %cmp13.i = icmp eq i8 %1, 37, !dbg !479
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !480

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !480

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 2, !dbg !481
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !481, !tbaa !474
  %cmp18.i = icmp eq i8 %2, 10, !dbg !482
  %inc.i = zext i1 %cmp18.i to i32, !dbg !483
  %spec.select.i = add nsw i32 %i.041.i.reg2mem72.0.load, %inc.i, !dbg !483
  store i32 %spec.select.i, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !483

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem68.0.load, !470, !DIExpression(), !471)
  %i.1.i.reg2mem68.0.load = load i32, ptr %i.1.i.reg2mem68, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !484
    #dbg_value(ptr %incdec.ptr.i, !464, !DIExpression(), !471)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem68.0.load, 1, !dbg !485
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !486, !llvm.loop !487

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 %i.1.i.reg2mem68.0.load, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i, !dbg !486

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !489, !tbaa !474
  %3 = icmp eq i8 %.pre.i, 0, !dbg !491
  %4 = select i1 %3, i64 0, i64 2, !dbg !492
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !486

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !492
    #dbg_value(ptr %spec.select38.i, !460, !DIExpression(), !461)
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 4096) #18, !dbg !493
    #dbg_value(ptr %call, !464, !DIExpression(), !494)
    #dbg_value(i32 2, !469, !DIExpression(), !494)
    #dbg_value(i32 0, !470, !DIExpression(), !494)
  store ptr %call, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 0, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem66.0.load, !470, !DIExpression(), !494)
    #dbg_value(ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, !464, !DIExpression(), !494)
  %i.041.i2.reg2mem66.0.load = load i32, ptr %i.041.i2.reg2mem66, align 4
  %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65 = load ptr, ptr %s.addr.040.i3.reg2mem64, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, align 1, !dbg !496, !tbaa !474
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !497

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !497

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !497

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !498
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !498, !tbaa !474
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !499
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !500

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !500

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 2, !dbg !501
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !501, !tbaa !474
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !502
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !503
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem66.0.load, %inc.i19, !dbg !503
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !503

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem62.0.load, !470, !DIExpression(), !494)
  %i.1.i8.reg2mem62.0.load = load i32, ptr %i.1.i8.reg2mem62, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !504
    #dbg_value(ptr %incdec.ptr.i9, !464, !DIExpression(), !494)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem62.0.load, 2, !dbg !505
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !506, !llvm.loop !507

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 %i.1.i8.reg2mem62.0.load, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1, !dbg !506

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !509, !tbaa !474
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !510
  %9 = select i1 %8, i64 0, i64 2, !dbg !511
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !506

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !511
    #dbg_value(ptr %spec.select38.i15, !460, !DIExpression(), !461)
  %m2 = getelementptr inbounds i8, ptr %vdata, i64 32768, !dbg !512
  %call5 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %m2, i32 noundef signext 4096) #18, !dbg !513
  tail call void @free(ptr noundef %call) #18, !dbg !514
  ret void, !dbg !515
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !516 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !518 {
entry.split:
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !520, !DIExpression(), !523)
    #dbg_value(ptr %vdata, !521, !DIExpression(), !523)
    #dbg_value(ptr %vdata, !522, !DIExpression(), !523)
    #dbg_value(i32 %fd, !524, !DIExpression(), !529)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !531
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !531

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !531
  unreachable, !dbg !531

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !534
    #dbg_value(i32 %fd, !535, !DIExpression(), !543)
    #dbg_value(ptr %vdata, !540, !DIExpression(), !543)
    #dbg_value(i32 4096, !541, !DIExpression(), !543)
    #dbg_value(i32 0, !542, !DIExpression(), !543)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !545

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !542, !DIExpression(), !543)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !547
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !547, !tbaa !374
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !547
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !550
    #dbg_value(i64 %indvars.iv.next.i, !542, !DIExpression(), !543)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 4096, !dbg !550
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !545, !llvm.loop !551

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !545

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !524, !DIExpression(), !552)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !554
  %m2 = getelementptr inbounds i8, ptr %vdata, i64 32768, !dbg !555
    #dbg_value(i32 %fd, !535, !DIExpression(), !556)
    #dbg_value(ptr %m2, !540, !DIExpression(), !556)
    #dbg_value(i32 4096, !541, !DIExpression(), !556)
    #dbg_value(i32 0, !542, !DIExpression(), !556)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !558

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !542, !DIExpression(), !556)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds double, ptr %m2, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !559
  %1 = load double, ptr %arrayidx.i11, align 8, !dbg !559, !tbaa !374
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %1), !dbg !559
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !560
    #dbg_value(i64 %indvars.iv.next.i12, !542, !DIExpression(), !556)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 4096, !dbg !560
  br i1 %exitcond.not.i13, label %write_double_array.exit14, label %for.body.i9.for.body.i9_crit_edge, !dbg !558, !llvm.loop !561

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !558

write_double_array.exit14:                        ; preds = %for.body.i9
  ret void, !dbg !562
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !563 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !565, !DIExpression(), !570)
    #dbg_value(ptr %vdata, !566, !DIExpression(), !570)
    #dbg_value(ptr %vdata, !567, !DIExpression(), !570)
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !571
    #dbg_value(ptr %call, !568, !DIExpression(), !570)
    #dbg_value(ptr %call, !464, !DIExpression(), !572)
    #dbg_value(i32 1, !469, !DIExpression(), !572)
    #dbg_value(i32 0, !470, !DIExpression(), !572)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !470, !DIExpression(), !572)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !464, !DIExpression(), !572)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !574, !tbaa !474
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !575

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !575

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !575

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !576
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !576, !tbaa !474
  %cmp13.i = icmp eq i8 %1, 37, !dbg !577
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !578

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !578

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !579
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !579, !tbaa !474
  %cmp18.i = icmp eq i8 %2, 10, !dbg !580
  %inc.i = zext i1 %cmp18.i to i32, !dbg !581
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !581
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !581

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !470, !DIExpression(), !572)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !582
    #dbg_value(ptr %incdec.ptr.i, !464, !DIExpression(), !572)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !583
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !584, !llvm.loop !585

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !584

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !587, !tbaa !474
  %3 = icmp eq i8 %.pre.i, 0, !dbg !588
  %4 = select i1 %3, i64 0, i64 2, !dbg !589
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !584

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !589
    #dbg_value(ptr %spec.select38.i, !569, !DIExpression(), !570)
  %prod = getelementptr inbounds i8, ptr %vdata, i64 65536, !dbg !590
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %prod, i32 noundef signext 4096) #18, !dbg !591
  tail call void @free(ptr noundef %call) #18, !dbg !592
  ret void, !dbg !593
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !594 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !596, !DIExpression(), !599)
    #dbg_value(ptr %vdata, !597, !DIExpression(), !599)
    #dbg_value(ptr %vdata, !598, !DIExpression(), !599)
    #dbg_value(i32 %fd, !524, !DIExpression(), !600)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !602
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !602

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !602
  unreachable, !dbg !602

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !603
  %prod = getelementptr inbounds i8, ptr %vdata, i64 65536, !dbg !604
    #dbg_value(i32 %fd, !535, !DIExpression(), !605)
    #dbg_value(ptr %prod, !540, !DIExpression(), !605)
    #dbg_value(i32 4096, !541, !DIExpression(), !605)
    #dbg_value(i32 0, !542, !DIExpression(), !605)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !607

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !542, !DIExpression(), !605)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %prod, i64 %indvars.iv.i.reg2mem.0.load, !dbg !608
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !608, !tbaa !374
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !608
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !609
    #dbg_value(i64 %indvars.iv.next.i, !542, !DIExpression(), !605)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 4096, !dbg !609
  br i1 %exitcond.not.i, label %write_double_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !607, !llvm.loop !610

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !607

write_double_array.exit:                          ; preds = %for.body.i
  ret void, !dbg !611
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #4 !dbg !612 {
entry.split:
  %has_errors.123.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
  %has_errors.025.reg2mem6 = alloca i32, align 4
  %indvars.iv27.reg2mem8 = alloca i64, align 8
    #dbg_value(ptr %vdata, !616, !DIExpression(), !624)
    #dbg_value(ptr %vref, !617, !DIExpression(), !624)
    #dbg_value(ptr %vdata, !618, !DIExpression(), !624)
    #dbg_value(ptr %vref, !619, !DIExpression(), !624)
    #dbg_value(i32 0, !620, !DIExpression(), !624)
    #dbg_value(i32 0, !621, !DIExpression(), !624)
  store i32 0, ptr %has_errors.025.reg2mem6, align 4
  store i64 0, ptr %indvars.iv27.reg2mem8, align 8
  br label %for.cond1.preheader, !dbg !625

for.cond1.preheader:                              ; preds = %for.inc11.for.cond1.preheader_crit_edge, %entry.split
    #dbg_value(i32 %has_errors.025.reg2mem6.0.load, !620, !DIExpression(), !624)
    #dbg_value(i64 %indvars.iv27.reg2mem8.0.load, !621, !DIExpression(), !624)
  %indvars.iv27.reg2mem8.0.load = load i64, ptr %indvars.iv27.reg2mem8, align 8
  %has_errors.025.reg2mem6.0.load = load i32, ptr %has_errors.025.reg2mem6, align 4
  %0 = shl nuw nsw i64 %indvars.iv27.reg2mem8.0.load, 6
    #dbg_value(i32 0, !622, !DIExpression(), !624)
  store i32 %has_errors.025.reg2mem6.0.load, ptr %has_errors.123.reg2mem, align 4
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body3, !dbg !627

for.body3:                                        ; preds = %for.body3.for.body3_crit_edge, %for.cond1.preheader
    #dbg_value(i32 %has_errors.123.reg2mem.0.load, !620, !DIExpression(), !624)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !622, !DIExpression(), !624)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %has_errors.123.reg2mem.0.load = load i32, ptr %has_errors.123.reg2mem, align 4
  %1 = add nuw nsw i64 %indvars.iv.reg2mem.0.load, %0, !dbg !631
  %arrayidx = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 2, i64 %1, !dbg !634
  %2 = load double, ptr %arrayidx, align 8, !dbg !634, !tbaa !374
  %arrayidx8 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 2, i64 %1, !dbg !635
  %3 = load double, ptr %arrayidx8, align 8, !dbg !635, !tbaa !374
  %sub = fsub double %2, %3, !dbg !636
    #dbg_value(double %sub, !623, !DIExpression(), !624)
  %4 = tail call double @llvm.fabs.f64(double %sub), !dbg !637
  %5 = fcmp ogt double %4, 0x3EB0C6F7A0B5ED8D, !dbg !637
  %lor.ext = zext i1 %5 to i32, !dbg !637
  %or = or i32 %has_errors.123.reg2mem.0.load, %lor.ext, !dbg !638
    #dbg_value(i32 %or, !620, !DIExpression(), !624)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !639
    #dbg_value(i64 %indvars.iv.next, !622, !DIExpression(), !624)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 64, !dbg !640
  br i1 %exitcond.not, label %for.inc11, label %for.body3.for.body3_crit_edge, !dbg !627, !llvm.loop !641

for.body3.for.body3_crit_edge:                    ; preds = %for.body3
  store i32 %or, ptr %has_errors.123.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body3, !dbg !627

for.inc11:                                        ; preds = %for.body3
  %indvars.iv.next28 = add nuw nsw i64 %indvars.iv27.reg2mem8.0.load, 1, !dbg !643
    #dbg_value(i32 %or, !620, !DIExpression(), !624)
    #dbg_value(i64 %indvars.iv.next28, !621, !DIExpression(), !624)
  %exitcond30.not = icmp eq i64 %indvars.iv.next28, 64, !dbg !644
  br i1 %exitcond30.not, label %for.end13, label %for.inc11.for.cond1.preheader_crit_edge, !dbg !625, !llvm.loop !645

for.inc11.for.cond1.preheader_crit_edge:          ; preds = %for.inc11
  store i32 %or, ptr %has_errors.025.reg2mem6, align 4
  store i64 %indvars.iv.next28, ptr %indvars.iv27.reg2mem8, align 8
  br label %for.cond1.preheader, !dbg !625

for.end13:                                        ; preds = %for.inc11
  %tobool.not = icmp eq i32 %or, 0, !dbg !647
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !647
  ret i32 %lnot.ext, !dbg !648
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !649 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !699
    #dbg_assign(i1 undef, !655, !DIExpression(), !699, ptr %s, !DIExpression(), !700)
    #dbg_value(i32 %fd, !653, !DIExpression(), !700)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #18, !dbg !701
  %cmp = icmp sgt i32 %fd, 1, !dbg !702
  br i1 %cmp, label %if.end, label %if.else, !dbg !702

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !702
  unreachable, !dbg !702

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #18, !dbg !705
  %cmp1 = icmp eq i32 %call, 0, !dbg !705
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !705

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !705
  unreachable, !dbg !705

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !708
  %0 = load i64, ptr %st_size, align 8, !dbg !708
    #dbg_value(i64 %0, !692, !DIExpression(), !700)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !709
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !709

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !709
  unreachable, !dbg !709

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !712
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #20, !dbg !713
    #dbg_value(ptr %call11, !654, !DIExpression(), !700)
    #dbg_value(i64 0, !695, !DIExpression(), !700)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !714

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !715
    #dbg_value(i64 %add19, !695, !DIExpression(), !700)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !717
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !714, !llvm.loop !718

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !714

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !695, !DIExpression(), !700)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !720
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !721
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #18, !dbg !722
    #dbg_value(i64 %call13, !698, !DIExpression(), !700)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !723
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !695, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !700)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !723

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !723
  unreachable, !dbg !723

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !726
  store i8 0, ptr %arrayidx20, align 1, !dbg !727, !tbaa !474
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #18, !dbg !728
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #18, !dbg !729
  ret ptr %call11, !dbg !730
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: noreturn nounwind
declare !dbg !731 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare !dbg !736 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !741 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #8

; Function Attrs: nofree
declare !dbg !746 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #9

declare !dbg !750 signext i32 @close(i32 noundef signext) local_unnamed_addr #10

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #1 !dbg !465 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !464, !DIExpression(), !751)
    #dbg_value(i32 %n, !469, !DIExpression(), !751)
    #dbg_value(i32 0, !470, !DIExpression(), !751)
  %cmp = icmp sgt i32 %n, -1, !dbg !752
  br i1 %cmp, label %if.end, label %if.else, !dbg !752

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #19, !dbg !752
  unreachable, !dbg !752

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !755
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !757

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !757

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !757

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !470, !DIExpression(), !751)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !464, !DIExpression(), !751)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !758, !tbaa !474
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !759

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !759

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !759

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !760
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !760, !tbaa !474
  %cmp13 = icmp eq i8 %1, 37, !dbg !761
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !762

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !762

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !763
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !763, !tbaa !474
  %cmp18 = icmp eq i8 %2, 10, !dbg !764
  %inc = zext i1 %cmp18 to i32, !dbg !765
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !765
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !765

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !470, !DIExpression(), !751)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !766
    #dbg_value(ptr %incdec.ptr, !464, !DIExpression(), !751)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !767
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !768, !llvm.loop !769

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !768

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !771, !tbaa !474
  %3 = icmp eq i8 %.pre, 0, !dbg !772
  %4 = select i1 %3, i64 0, i64 2, !dbg !773
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !768

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !773
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !773

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !774
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !775 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !779, !DIExpression(), !783)
    #dbg_value(ptr %arr, !780, !DIExpression(), !783)
    #dbg_value(i32 %n, !781, !DIExpression(), !783)
  %cmp.not = icmp eq ptr %s, null, !dbg !784
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !784

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #19, !dbg !784
  unreachable, !dbg !784

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !787
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !789

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !790
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !792
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !792

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !782, !DIExpression(), !783)
  %conv404 = zext nneg i32 %n to i64, !dbg !793
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !794
  br label %if.end46, !dbg !795

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !782, !DIExpression(), !783)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !796
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !797

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !797

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !798
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !799
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !799
  %cmp9.not = icmp eq i8 %0, 0, !dbg !800
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !801

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !801

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !802
  %1 = load i8, ptr %gep, align 1, !dbg !802
  %cmp16.not = icmp eq i8 %1, 0, !dbg !803
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !804

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !804

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !805
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !806
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !806
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !806, !llvm.loop !807

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !806

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !793

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !793

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !793

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !793
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !782, !DIExpression(), !783)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !794
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !809
  store i8 0, ptr %arrayidx45, align 1, !dbg !811, !tbaa !474
  br label %if.end46, !dbg !809

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !812
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #11

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !813 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !825
    #dbg_assign(i1 undef, !822, !DIExpression(), !825, ptr %endptr, !DIExpression(), !826)
    #dbg_value(ptr %s, !818, !DIExpression(), !826)
    #dbg_value(ptr %arr, !819, !DIExpression(), !826)
    #dbg_value(i32 %n, !820, !DIExpression(), !826)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !827
    #dbg_value(i32 0, !823, !DIExpression(), !826)
  %cmp.not = icmp eq ptr %s, null, !dbg !828
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !828

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #19, !dbg !828
  unreachable, !dbg !828

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !827
    #dbg_value(ptr %call, !821, !DIExpression(), !826)
    #dbg_value(i32 0, !823, !DIExpression(), !826)
  %cmp130 = icmp ne ptr %call, null, !dbg !827
  %cmp231 = icmp sgt i32 %n, 0, !dbg !827
  %0 = and i1 %cmp231, %cmp130, !dbg !827
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !827

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !827

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !827
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !827

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !821, !DIExpression(), !826)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !823, !DIExpression(), !826)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !831, !tbaa !833, !DIAssignID !835
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !822, !DIExpression(), !835, ptr %endptr, !DIExpression(), !826)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !831
  %conv = trunc i64 %call3 to i8, !dbg !831
    #dbg_value(i8 %conv, !824, !DIExpression(), !826)
  %2 = load ptr, ptr %endptr, align 8, !dbg !836, !tbaa !833
  %3 = load i8, ptr %2, align 1, !dbg !836, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !836
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !831

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !831

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !838, !tbaa !833
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !838
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !838
  br label %if.end9, !dbg !838

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !831
  store i8 %conv, ptr %arrayidx, align 1, !dbg !831, !tbaa !474
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !831
    #dbg_value(i64 %indvars.iv.next, !823, !DIExpression(), !826)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !831
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !831
  store i8 10, ptr %arrayidx11, align 1, !dbg !831, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !831
    #dbg_value(ptr %call12, !821, !DIExpression(), !826)
  %cmp1 = icmp ne ptr %call12, null, !dbg !827
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !827
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !827
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !827, !llvm.loop !840

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !827

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !827

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !827

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !827

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !841
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !841
  store i8 10, ptr %arrayidx17, align 1, !dbg !841, !tbaa !474
  br label %if.end18, !dbg !841

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !827
  ret i32 0, !dbg !827
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !844 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #12

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !850 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #12

; Function Attrs: nofree nounwind
declare !dbg !855 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !910 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !913 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !925
    #dbg_assign(i1 undef, !922, !DIExpression(), !925, ptr %endptr, !DIExpression(), !926)
    #dbg_value(ptr %s, !918, !DIExpression(), !926)
    #dbg_value(ptr %arr, !919, !DIExpression(), !926)
    #dbg_value(i32 %n, !920, !DIExpression(), !926)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !927
    #dbg_value(i32 0, !923, !DIExpression(), !926)
  %cmp.not = icmp eq ptr %s, null, !dbg !928
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !928

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #19, !dbg !928
  unreachable, !dbg !928

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !927
    #dbg_value(ptr %call, !921, !DIExpression(), !926)
    #dbg_value(i32 0, !923, !DIExpression(), !926)
  %cmp130 = icmp ne ptr %call, null, !dbg !927
  %cmp231 = icmp sgt i32 %n, 0, !dbg !927
  %0 = and i1 %cmp231, %cmp130, !dbg !927
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !927

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !927

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !927
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !927

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !921, !DIExpression(), !926)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !923, !DIExpression(), !926)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !931, !tbaa !833, !DIAssignID !933
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !922, !DIExpression(), !933, ptr %endptr, !DIExpression(), !926)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !931
  %conv = trunc i64 %call3 to i16, !dbg !931
    #dbg_value(i16 %conv, !924, !DIExpression(), !926)
  %2 = load ptr, ptr %endptr, align 8, !dbg !934, !tbaa !833
  %3 = load i8, ptr %2, align 1, !dbg !934, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !934
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !931

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !931

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !936, !tbaa !833
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !936
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !936
  br label %if.end9, !dbg !936

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !931
  store i16 %conv, ptr %arrayidx, align 2, !dbg !931, !tbaa !938
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !931
    #dbg_value(i64 %indvars.iv.next, !923, !DIExpression(), !926)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !931
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !931
  store i8 10, ptr %arrayidx11, align 1, !dbg !931, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !931
    #dbg_value(ptr %call12, !921, !DIExpression(), !926)
  %cmp1 = icmp ne ptr %call12, null, !dbg !927
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !927
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !927
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !927, !llvm.loop !940

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !927

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !927

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !927

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !927

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !941
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !941
  store i8 10, ptr %arrayidx17, align 1, !dbg !941, !tbaa !474
  br label %if.end18, !dbg !941

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !927
  ret i32 0, !dbg !927
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !944 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !956
    #dbg_assign(i1 undef, !953, !DIExpression(), !956, ptr %endptr, !DIExpression(), !957)
    #dbg_value(ptr %s, !949, !DIExpression(), !957)
    #dbg_value(ptr %arr, !950, !DIExpression(), !957)
    #dbg_value(i32 %n, !951, !DIExpression(), !957)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !958
    #dbg_value(i32 0, !954, !DIExpression(), !957)
  %cmp.not = icmp eq ptr %s, null, !dbg !959
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !959

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #19, !dbg !959
  unreachable, !dbg !959

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !958
    #dbg_value(ptr %call, !952, !DIExpression(), !957)
    #dbg_value(i32 0, !954, !DIExpression(), !957)
  %cmp130 = icmp ne ptr %call, null, !dbg !958
  %cmp231 = icmp sgt i32 %n, 0, !dbg !958
  %0 = and i1 %cmp231, %cmp130, !dbg !958
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !958

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !958

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !958
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !958

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !952, !DIExpression(), !957)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !954, !DIExpression(), !957)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !962, !tbaa !833, !DIAssignID !964
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !953, !DIExpression(), !964, ptr %endptr, !DIExpression(), !957)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !962
  %conv = trunc i64 %call3 to i32, !dbg !962
    #dbg_value(i32 %conv, !955, !DIExpression(), !957)
  %2 = load ptr, ptr %endptr, align 8, !dbg !965, !tbaa !833
  %3 = load i8, ptr %2, align 1, !dbg !965, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !965
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !962

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !962

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !967, !tbaa !833
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !967
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !967
  br label %if.end9, !dbg !967

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !962
  store i32 %conv, ptr %arrayidx, align 4, !dbg !962, !tbaa !969
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !962
    #dbg_value(i64 %indvars.iv.next, !954, !DIExpression(), !957)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !962
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !962
  store i8 10, ptr %arrayidx11, align 1, !dbg !962, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !962
    #dbg_value(ptr %call12, !952, !DIExpression(), !957)
  %cmp1 = icmp ne ptr %call12, null, !dbg !958
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !958
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !958
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !958, !llvm.loop !971

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !958

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !958

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !958

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !958

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !972
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !972
  store i8 10, ptr %arrayidx17, align 1, !dbg !972, !tbaa !474
  br label %if.end18, !dbg !972

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !958
  ret i32 0, !dbg !958
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !975 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !987
    #dbg_assign(i1 undef, !984, !DIExpression(), !987, ptr %endptr, !DIExpression(), !988)
    #dbg_value(ptr %s, !980, !DIExpression(), !988)
    #dbg_value(ptr %arr, !981, !DIExpression(), !988)
    #dbg_value(i32 %n, !982, !DIExpression(), !988)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !989
    #dbg_value(i32 0, !985, !DIExpression(), !988)
  %cmp.not = icmp eq ptr %s, null, !dbg !990
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !990

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #19, !dbg !990
  unreachable, !dbg !990

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !989
    #dbg_value(ptr %call, !983, !DIExpression(), !988)
    #dbg_value(i32 0, !985, !DIExpression(), !988)
  %cmp129 = icmp ne ptr %call, null, !dbg !989
  %cmp230 = icmp sgt i32 %n, 0, !dbg !989
  %0 = and i1 %cmp230, %cmp129, !dbg !989
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !989

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !989

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !989
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !989

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !983, !DIExpression(), !988)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !985, !DIExpression(), !988)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !993, !tbaa !833, !DIAssignID !995
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !984, !DIExpression(), !995, ptr %endptr, !DIExpression(), !988)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !993
    #dbg_value(i64 %call3, !986, !DIExpression(), !988)
  %2 = load ptr, ptr %endptr, align 8, !dbg !996, !tbaa !833
  %3 = load i8, ptr %2, align 1, !dbg !996, !tbaa !474
  %cmp4.not = icmp eq i8 %3, 0, !dbg !996
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !993

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !993

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !998, !tbaa !833
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !998
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !998
  br label %if.end8, !dbg !998

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !993
  store i64 %call3, ptr %arrayidx, align 8, !dbg !993, !tbaa !1000
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !993
    #dbg_value(i64 %indvars.iv.next, !985, !DIExpression(), !988)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !993
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !993
  store i8 10, ptr %arrayidx10, align 1, !dbg !993, !tbaa !474
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !993
    #dbg_value(ptr %call11, !983, !DIExpression(), !988)
  %cmp1 = icmp ne ptr %call11, null, !dbg !989
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !989
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !989
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !989, !llvm.loop !1002

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !989

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !989

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !989

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !989

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1003
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1003
  store i8 10, ptr %arrayidx16, align 1, !dbg !1003, !tbaa !474
  br label %if.end17, !dbg !1003

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !989
  ret i32 0, !dbg !989
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1006 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1018
    #dbg_assign(i1 undef, !1015, !DIExpression(), !1018, ptr %endptr, !DIExpression(), !1019)
    #dbg_value(ptr %s, !1011, !DIExpression(), !1019)
    #dbg_value(ptr %arr, !1012, !DIExpression(), !1019)
    #dbg_value(i32 %n, !1013, !DIExpression(), !1019)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1020
    #dbg_value(i32 0, !1016, !DIExpression(), !1019)
  %cmp.not = icmp eq ptr %s, null, !dbg !1021
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1021

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #19, !dbg !1021
  unreachable, !dbg !1021

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1020
    #dbg_value(ptr %call, !1014, !DIExpression(), !1019)
    #dbg_value(i32 0, !1016, !DIExpression(), !1019)
  %cmp130 = icmp ne ptr %call, null, !dbg !1020
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1020
  %0 = and i1 %cmp231, %cmp130, !dbg !1020
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1020

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1020

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1020
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1020

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1014, !DIExpression(), !1019)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1016, !DIExpression(), !1019)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1024, !tbaa !833, !DIAssignID !1026
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1015, !DIExpression(), !1026, ptr %endptr, !DIExpression(), !1019)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1024
  %conv = trunc i64 %call3 to i8, !dbg !1024
    #dbg_value(i8 %conv, !1017, !DIExpression(), !1019)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1027, !tbaa !833
  %3 = load i8, ptr %2, align 1, !dbg !1027, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1027
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1024

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1024

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1029, !tbaa !833
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1029
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1029
  br label %if.end9, !dbg !1029

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1024
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1024, !tbaa !474
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1024
    #dbg_value(i64 %indvars.iv.next, !1016, !DIExpression(), !1019)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1024
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1024
  store i8 10, ptr %arrayidx11, align 1, !dbg !1024, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1024
    #dbg_value(ptr %call12, !1014, !DIExpression(), !1019)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1020
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1020
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1020
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1020, !llvm.loop !1031

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1020

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1020

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1020

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1020

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1032
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1032
  store i8 10, ptr %arrayidx17, align 1, !dbg !1032, !tbaa !474
  br label %if.end18, !dbg !1032

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1020
  ret i32 0, !dbg !1020
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1035 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1047
    #dbg_assign(i1 undef, !1044, !DIExpression(), !1047, ptr %endptr, !DIExpression(), !1048)
    #dbg_value(ptr %s, !1040, !DIExpression(), !1048)
    #dbg_value(ptr %arr, !1041, !DIExpression(), !1048)
    #dbg_value(i32 %n, !1042, !DIExpression(), !1048)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1049
    #dbg_value(i32 0, !1045, !DIExpression(), !1048)
  %cmp.not = icmp eq ptr %s, null, !dbg !1050
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1050

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #19, !dbg !1050
  unreachable, !dbg !1050

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1049
    #dbg_value(ptr %call, !1043, !DIExpression(), !1048)
    #dbg_value(i32 0, !1045, !DIExpression(), !1048)
  %cmp130 = icmp ne ptr %call, null, !dbg !1049
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1049
  %0 = and i1 %cmp231, %cmp130, !dbg !1049
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1049

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1049

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1049
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1049

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1043, !DIExpression(), !1048)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1045, !DIExpression(), !1048)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1053, !tbaa !833, !DIAssignID !1055
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1044, !DIExpression(), !1055, ptr %endptr, !DIExpression(), !1048)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1053
  %conv = trunc i64 %call3 to i16, !dbg !1053
    #dbg_value(i16 %conv, !1046, !DIExpression(), !1048)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1056, !tbaa !833
  %3 = load i8, ptr %2, align 1, !dbg !1056, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1056
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1053

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1053

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1058, !tbaa !833
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1058
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1058
  br label %if.end9, !dbg !1058

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1053
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1053, !tbaa !938
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1053
    #dbg_value(i64 %indvars.iv.next, !1045, !DIExpression(), !1048)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1053
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1053
  store i8 10, ptr %arrayidx11, align 1, !dbg !1053, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1053
    #dbg_value(ptr %call12, !1043, !DIExpression(), !1048)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1049
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1049
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1049
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1049, !llvm.loop !1060

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1049

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1049

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1049

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1049

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1061
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1061
  store i8 10, ptr %arrayidx17, align 1, !dbg !1061, !tbaa !474
  br label %if.end18, !dbg !1061

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1049
  ret i32 0, !dbg !1049
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1064 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1076
    #dbg_assign(i1 undef, !1073, !DIExpression(), !1076, ptr %endptr, !DIExpression(), !1077)
    #dbg_value(ptr %s, !1069, !DIExpression(), !1077)
    #dbg_value(ptr %arr, !1070, !DIExpression(), !1077)
    #dbg_value(i32 %n, !1071, !DIExpression(), !1077)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1078
    #dbg_value(i32 0, !1074, !DIExpression(), !1077)
  %cmp.not = icmp eq ptr %s, null, !dbg !1079
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1079

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #19, !dbg !1079
  unreachable, !dbg !1079

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1078
    #dbg_value(ptr %call, !1072, !DIExpression(), !1077)
    #dbg_value(i32 0, !1074, !DIExpression(), !1077)
  %cmp130 = icmp ne ptr %call, null, !dbg !1078
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1078
  %0 = and i1 %cmp231, %cmp130, !dbg !1078
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1078

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1078

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1078
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1078

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1072, !DIExpression(), !1077)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1074, !DIExpression(), !1077)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1082, !tbaa !833, !DIAssignID !1084
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1073, !DIExpression(), !1084, ptr %endptr, !DIExpression(), !1077)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1082
  %conv = trunc i64 %call3 to i32, !dbg !1082
    #dbg_value(i32 %conv, !1075, !DIExpression(), !1077)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1085, !tbaa !833
  %3 = load i8, ptr %2, align 1, !dbg !1085, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1085
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1082

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1082

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1087, !tbaa !833
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1087
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1087
  br label %if.end9, !dbg !1087

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1082
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1082, !tbaa !969
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1082
    #dbg_value(i64 %indvars.iv.next, !1074, !DIExpression(), !1077)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1082
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1082
  store i8 10, ptr %arrayidx11, align 1, !dbg !1082, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1082
    #dbg_value(ptr %call12, !1072, !DIExpression(), !1077)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1078
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1078
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1078
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1078, !llvm.loop !1089

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1078

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1078

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1078

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1078

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1090
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1090
  store i8 10, ptr %arrayidx17, align 1, !dbg !1090, !tbaa !474
  br label %if.end18, !dbg !1090

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1078
  ret i32 0, !dbg !1078
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1093 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1105
    #dbg_assign(i1 undef, !1102, !DIExpression(), !1105, ptr %endptr, !DIExpression(), !1106)
    #dbg_value(ptr %s, !1098, !DIExpression(), !1106)
    #dbg_value(ptr %arr, !1099, !DIExpression(), !1106)
    #dbg_value(i32 %n, !1100, !DIExpression(), !1106)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1107
    #dbg_value(i32 0, !1103, !DIExpression(), !1106)
  %cmp.not = icmp eq ptr %s, null, !dbg !1108
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1108

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #19, !dbg !1108
  unreachable, !dbg !1108

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1107
    #dbg_value(ptr %call, !1101, !DIExpression(), !1106)
    #dbg_value(i32 0, !1103, !DIExpression(), !1106)
  %cmp129 = icmp ne ptr %call, null, !dbg !1107
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1107
  %0 = and i1 %cmp230, %cmp129, !dbg !1107
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1107

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1107

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1107
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1107

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1101, !DIExpression(), !1106)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1103, !DIExpression(), !1106)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1111, !tbaa !833, !DIAssignID !1113
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1102, !DIExpression(), !1113, ptr %endptr, !DIExpression(), !1106)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1111
    #dbg_value(i64 %call3, !1104, !DIExpression(), !1106)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1114, !tbaa !833
  %3 = load i8, ptr %2, align 1, !dbg !1114, !tbaa !474
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1114
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1111

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1111

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1116, !tbaa !833
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1116
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1116
  br label %if.end8, !dbg !1116

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1111
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1111, !tbaa !1000
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1111
    #dbg_value(i64 %indvars.iv.next, !1103, !DIExpression(), !1106)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1111
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1111
  store i8 10, ptr %arrayidx10, align 1, !dbg !1111, !tbaa !474
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1111
    #dbg_value(ptr %call11, !1101, !DIExpression(), !1106)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1107
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1107
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1107
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1107, !llvm.loop !1118

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1107

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1107

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1107

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1107

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1119
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1119
  store i8 10, ptr %arrayidx16, align 1, !dbg !1119, !tbaa !474
  br label %if.end17, !dbg !1119

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1107
  ret i32 0, !dbg !1107
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1122 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1134
    #dbg_assign(i1 undef, !1131, !DIExpression(), !1134, ptr %endptr, !DIExpression(), !1135)
    #dbg_value(ptr %s, !1127, !DIExpression(), !1135)
    #dbg_value(ptr %arr, !1128, !DIExpression(), !1135)
    #dbg_value(i32 %n, !1129, !DIExpression(), !1135)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1136
    #dbg_value(i32 0, !1132, !DIExpression(), !1135)
  %cmp.not = icmp eq ptr %s, null, !dbg !1137
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1137

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #19, !dbg !1137
  unreachable, !dbg !1137

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1136
    #dbg_value(ptr %call, !1130, !DIExpression(), !1135)
    #dbg_value(i32 0, !1132, !DIExpression(), !1135)
  %cmp129 = icmp ne ptr %call, null, !dbg !1136
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1136
  %0 = and i1 %cmp230, %cmp129, !dbg !1136
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1136

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1136

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1136
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1136

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1130, !DIExpression(), !1135)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1132, !DIExpression(), !1135)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1140, !tbaa !833, !DIAssignID !1142
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1131, !DIExpression(), !1142, ptr %endptr, !DIExpression(), !1135)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1140
    #dbg_value(float %call3, !1133, !DIExpression(), !1135)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1143, !tbaa !833
  %3 = load i8, ptr %2, align 1, !dbg !1143, !tbaa !474
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1143
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1140

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1140

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1145, !tbaa !833
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1145
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1145
  br label %if.end8, !dbg !1145

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1140
  store float %call3, ptr %arrayidx, align 4, !dbg !1140, !tbaa !1147
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1140
    #dbg_value(i64 %indvars.iv.next, !1132, !DIExpression(), !1135)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1140
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1140
  store i8 10, ptr %arrayidx10, align 1, !dbg !1140, !tbaa !474
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1140
    #dbg_value(ptr %call11, !1130, !DIExpression(), !1135)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1136
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1136
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1136
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1136, !llvm.loop !1149

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1136

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1136

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1136

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1136

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1150
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1150
  store i8 10, ptr %arrayidx16, align 1, !dbg !1150, !tbaa !474
  br label %if.end17, !dbg !1150

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1136
  ret i32 0, !dbg !1136
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1153 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1156 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1167
    #dbg_assign(i1 undef, !1164, !DIExpression(), !1167, ptr %endptr, !DIExpression(), !1168)
    #dbg_value(ptr %s, !1160, !DIExpression(), !1168)
    #dbg_value(ptr %arr, !1161, !DIExpression(), !1168)
    #dbg_value(i32 %n, !1162, !DIExpression(), !1168)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1169
    #dbg_value(i32 0, !1165, !DIExpression(), !1168)
  %cmp.not = icmp eq ptr %s, null, !dbg !1170
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1170

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #19, !dbg !1170
  unreachable, !dbg !1170

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1169
    #dbg_value(ptr %call, !1163, !DIExpression(), !1168)
    #dbg_value(i32 0, !1165, !DIExpression(), !1168)
  %cmp129 = icmp ne ptr %call, null, !dbg !1169
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1169
  %0 = and i1 %cmp230, %cmp129, !dbg !1169
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1169

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1169

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1169
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1169

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1163, !DIExpression(), !1168)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1165, !DIExpression(), !1168)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1173, !tbaa !833, !DIAssignID !1175
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1164, !DIExpression(), !1175, ptr %endptr, !DIExpression(), !1168)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1173
    #dbg_value(double %call3, !1166, !DIExpression(), !1168)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1176, !tbaa !833
  %3 = load i8, ptr %2, align 1, !dbg !1176, !tbaa !474
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1176
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1173

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1173

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1178, !tbaa !833
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1178
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1178
  br label %if.end8, !dbg !1178

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1173
  store double %call3, ptr %arrayidx, align 8, !dbg !1173, !tbaa !374
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1173
    #dbg_value(i64 %indvars.iv.next, !1165, !DIExpression(), !1168)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1173
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1173
  store i8 10, ptr %arrayidx10, align 1, !dbg !1173, !tbaa !474
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1173
    #dbg_value(ptr %call11, !1163, !DIExpression(), !1168)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1169
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1169
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1169
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1169, !llvm.loop !1180

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1169

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1169

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1169

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1169

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1181
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1181
  store i8 10, ptr %arrayidx16, align 1, !dbg !1181, !tbaa !474
  br label %if.end17, !dbg !1181

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1169
  ret i32 0, !dbg !1169
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1184 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1187 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1191, !DIExpression(), !1196)
    #dbg_value(ptr %arr, !1192, !DIExpression(), !1196)
    #dbg_value(i32 %n, !1193, !DIExpression(), !1196)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1197
  br i1 %cmp, label %if.end, label %if.else, !dbg !1197

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1197
  unreachable, !dbg !1197

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1200
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1202

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1202

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #22, !dbg !1203
  %conv = trunc i64 %call to i32, !dbg !1203
    #dbg_value(i32 %conv, !1193, !DIExpression(), !1196)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1205

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1193, !DIExpression(), !1196)
    #dbg_value(i32 0, !1195, !DIExpression(), !1196)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1206
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1207

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1207

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1207

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1208

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1209
    #dbg_value(i32 %add, !1195, !DIExpression(), !1196)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1206
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1207, !llvm.loop !1211

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1207

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1207

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1195, !DIExpression(), !1196)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1213
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1213
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1214
  %conv6 = sext i32 %sub to i64, !dbg !1215
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #18, !dbg !1216
  %conv8 = trunc i64 %call7 to i32, !dbg !1216
    #dbg_value(i32 %conv8, !1194, !DIExpression(), !1196)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1217
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1195, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1196)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1217

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1217
  unreachable, !dbg !1217

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #18, !dbg !1220
  %conv16 = trunc i64 %call15 to i32, !dbg !1220
    #dbg_value(i32 %conv16, !1194, !DIExpression(), !1196)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1222
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1222

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1222
  unreachable, !dbg !1222

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1225
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1226, !llvm.loop !1227

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1226

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1229
}

; Function Attrs: nofree
declare !dbg !1230 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #9

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1235 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1239, !DIExpression(), !1243)
    #dbg_value(ptr %arr, !1240, !DIExpression(), !1243)
    #dbg_value(i32 %n, !1241, !DIExpression(), !1243)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1244
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1244

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1242, !DIExpression(), !1243)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1247
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1250

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1250

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1247
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1250

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #19, !dbg !1244
  unreachable, !dbg !1244

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1242, !DIExpression(), !1243)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1251
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1251, !tbaa !474
  %conv = zext i8 %0 to i32, !dbg !1251
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1251
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1247
    #dbg_value(i64 %indvars.iv.next, !1242, !DIExpression(), !1243)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1247
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1250, !llvm.loop !1253

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1250

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1250

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1254
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #14 !dbg !1255 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1272
    #dbg_assign(i1 undef, !1261, !DIExpression(), !1272, ptr %args, !DIExpression(), !1273)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1274
    #dbg_assign(i1 undef, !1268, !DIExpression(), !1274, ptr %buffer, !DIExpression(), !1273)
    #dbg_value(i32 %fd, !1259, !DIExpression(), !1273)
    #dbg_value(ptr %format, !1260, !DIExpression(), !1273)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #18, !dbg !1275
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1276
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1277
  %0 = load ptr, ptr %args, align 8, !dbg !1278, !tbaa !833
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #18, !dbg !1279
    #dbg_value(i32 %call, !1265, !DIExpression(), !1273)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1280
  %cmp = icmp slt i32 %call, 256, !dbg !1281
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1281

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1266, !DIExpression(), !1273)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1284
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1285

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1285

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1285

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1281
  unreachable, !dbg !1281

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1286
    #dbg_value(i32 %add, !1266, !DIExpression(), !1273)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1284
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1285, !llvm.loop !1288

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1285

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1285

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1266, !DIExpression(), !1273)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1290
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1290
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1291
  %conv = sext i32 %sub to i64, !dbg !1292
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #18, !dbg !1293
  %conv3 = trunc i64 %call2 to i32, !dbg !1293
    #dbg_value(i32 %conv3, !1267, !DIExpression(), !1273)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1294
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1266, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1273)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1294

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1294
  unreachable, !dbg !1294

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1297
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1297

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1297
  unreachable, !dbg !1297

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1300
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #18, !dbg !1300
  ret void, !dbg !1301
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #15

; Function Attrs: nofree nounwind
declare !dbg !1302 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #7

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1307 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1311, !DIExpression(), !1315)
    #dbg_value(ptr %arr, !1312, !DIExpression(), !1315)
    #dbg_value(i32 %n, !1313, !DIExpression(), !1315)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1316
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1316

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1314, !DIExpression(), !1315)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1319
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1322

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1322

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1319
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1322

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #19, !dbg !1316
  unreachable, !dbg !1316

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1314, !DIExpression(), !1315)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1323
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1323, !tbaa !938
  %conv = zext i16 %0 to i32, !dbg !1323
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1323
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1319
    #dbg_value(i64 %indvars.iv.next, !1314, !DIExpression(), !1315)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1319
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1322, !llvm.loop !1325

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1322

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1322

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1326
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1327 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1331, !DIExpression(), !1335)
    #dbg_value(ptr %arr, !1332, !DIExpression(), !1335)
    #dbg_value(i32 %n, !1333, !DIExpression(), !1335)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1336
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1336

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1334, !DIExpression(), !1335)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1339
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1342

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1342

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1339
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1342

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #19, !dbg !1336
  unreachable, !dbg !1336

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1334, !DIExpression(), !1335)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1343
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1343, !tbaa !969
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1343
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1339
    #dbg_value(i64 %indvars.iv.next, !1334, !DIExpression(), !1335)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1339
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1342, !llvm.loop !1345

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1342

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1342

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1346
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1347 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1351, !DIExpression(), !1355)
    #dbg_value(ptr %arr, !1352, !DIExpression(), !1355)
    #dbg_value(i32 %n, !1353, !DIExpression(), !1355)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1356
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1356

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1354, !DIExpression(), !1355)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1359
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1362

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1362

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1359
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1362

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #19, !dbg !1356
  unreachable, !dbg !1356

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1354, !DIExpression(), !1355)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1363
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1363, !tbaa !1000
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1363
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1359
    #dbg_value(i64 %indvars.iv.next, !1354, !DIExpression(), !1355)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1359
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1362, !llvm.loop !1365

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1362

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1362

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1366
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1367 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1371, !DIExpression(), !1375)
    #dbg_value(ptr %arr, !1372, !DIExpression(), !1375)
    #dbg_value(i32 %n, !1373, !DIExpression(), !1375)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1376
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1376

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1374, !DIExpression(), !1375)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1379
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1382

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1382

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1379
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1382

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #19, !dbg !1376
  unreachable, !dbg !1376

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1374, !DIExpression(), !1375)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1383
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1383, !tbaa !474
  %conv = sext i8 %0 to i32, !dbg !1383
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1383
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1379
    #dbg_value(i64 %indvars.iv.next, !1374, !DIExpression(), !1375)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1379
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1382, !llvm.loop !1385

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1382

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1382

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1386
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1387 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1391, !DIExpression(), !1395)
    #dbg_value(ptr %arr, !1392, !DIExpression(), !1395)
    #dbg_value(i32 %n, !1393, !DIExpression(), !1395)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1396
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1396

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1394, !DIExpression(), !1395)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1399
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1402

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1402

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1399
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1402

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #19, !dbg !1396
  unreachable, !dbg !1396

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1394, !DIExpression(), !1395)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1403
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1403, !tbaa !938
  %conv = sext i16 %0 to i32, !dbg !1403
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1403
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1399
    #dbg_value(i64 %indvars.iv.next, !1394, !DIExpression(), !1395)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1399
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1402, !llvm.loop !1405

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1402

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1402

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1406
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1407 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1411, !DIExpression(), !1415)
    #dbg_value(ptr %arr, !1412, !DIExpression(), !1415)
    #dbg_value(i32 %n, !1413, !DIExpression(), !1415)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1416
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1416

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1414, !DIExpression(), !1415)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1419
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1422

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1422

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1419
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1422

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #19, !dbg !1416
  unreachable, !dbg !1416

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1414, !DIExpression(), !1415)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1423
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1423, !tbaa !969
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1423
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1419
    #dbg_value(i64 %indvars.iv.next, !1414, !DIExpression(), !1415)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1419
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1422, !llvm.loop !1425

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1422

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1422

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1426
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1427 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1431, !DIExpression(), !1435)
    #dbg_value(ptr %arr, !1432, !DIExpression(), !1435)
    #dbg_value(i32 %n, !1433, !DIExpression(), !1435)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1436
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1436

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1434, !DIExpression(), !1435)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1439
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1442

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1442

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1439
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1442

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #19, !dbg !1436
  unreachable, !dbg !1436

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1434, !DIExpression(), !1435)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1443
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1443, !tbaa !1000
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1443
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1439
    #dbg_value(i64 %indvars.iv.next, !1434, !DIExpression(), !1435)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1439
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1442, !llvm.loop !1445

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1442

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1442

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1446
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1447 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1451, !DIExpression(), !1455)
    #dbg_value(ptr %arr, !1452, !DIExpression(), !1455)
    #dbg_value(i32 %n, !1453, !DIExpression(), !1455)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1456
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1456

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1454, !DIExpression(), !1455)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1459
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1462

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1462

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1459
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1462

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #19, !dbg !1456
  unreachable, !dbg !1456

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1454, !DIExpression(), !1455)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1463
  %0 = load float, ptr %arrayidx, align 4, !dbg !1463, !tbaa !1147
  %conv = fpext float %0 to double, !dbg !1463
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1463
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1459
    #dbg_value(i64 %indvars.iv.next, !1454, !DIExpression(), !1455)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1459
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1462, !llvm.loop !1465

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1462

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1462

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1466
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !536 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !535, !DIExpression(), !1467)
    #dbg_value(ptr %arr, !540, !DIExpression(), !1467)
    #dbg_value(i32 %n, !541, !DIExpression(), !1467)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1468
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1468

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !542, !DIExpression(), !1467)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1471
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1472

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1472

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1471
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1472

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #19, !dbg !1468
  unreachable, !dbg !1468

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !542, !DIExpression(), !1467)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1473
  %0 = load double, ptr %arrayidx, align 8, !dbg !1473, !tbaa !374
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1473
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1471
    #dbg_value(i64 %indvars.iv.next, !542, !DIExpression(), !1467)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1471
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1472, !llvm.loop !1474

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1472

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1472

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1475
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !525 {
entry.split:
    #dbg_value(i32 %fd, !524, !DIExpression(), !1476)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1477
  br i1 %cmp, label %if.end, label %if.else, !dbg !1477

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1477
  unreachable, !dbg !1477

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1478
  ret i32 0, !dbg !1479
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #1 !dbg !1480 {
entry.split:
  %call.reg2mem = alloca ptr, align 8
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.123.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %has_errors.025.i.reg2mem74 = alloca i32, align 4
  %indvars.iv27.i.reg2mem76 = alloca i64, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem78 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem80 = alloca ptr, align 8
  %i.041.i.i.reg2mem82 = alloca i32, align 4
  %indvars.iv.i.i3.reg2mem = alloca i64, align 8
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %indvars.iv61.i.i.reg2mem84 = alloca i64, align 8
  %i.056.i.i.reg2mem86 = alloca i32, align 4
  %indvars.iv67.i.i.reg2mem88 = alloca i64, align 8
  %indvars.iv69.i.i.reg2mem90 = alloca i64, align 8
  %check_file.0.reg2mem92 = alloca ptr, align 8
  %in_file.010.reg2mem94 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1484, !DIExpression(), !1493)
    #dbg_value(ptr %argv, !1485, !DIExpression(), !1493)
  %cmp = icmp slt i32 %argc, 4, !dbg !1494
  br i1 %cmp, label %if.end, label %if.else, !dbg !1494

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1494
  unreachable, !dbg !1494

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1486, !DIExpression(), !1493)
    #dbg_value(ptr @.str.4.13, !1487, !DIExpression(), !1493)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1497
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1499

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.13, ptr %check_file.0.reg2mem92, align 8
  store ptr @.str.3, ptr %in_file.010.reg2mem94, align 8
  br label %if.end7, !dbg !1499

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1500
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1500
    #dbg_value(ptr %0, !1486, !DIExpression(), !1493)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1501
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1503

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.13, ptr %check_file.0.reg2mem92, align 8
  store ptr %0, ptr %in_file.010.reg2mem94, align 8
  br label %if.end7, !dbg !1503

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1504
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1504
    #dbg_value(ptr %1, !1487, !DIExpression(), !1493)
  store ptr %1, ptr %check_file.0.reg2mem92, align 8
  store ptr %0, ptr %in_file.010.reg2mem94, align 8
  br label %if.end7, !dbg !1505

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem92.0.check_file.0.reload93, !1487, !DIExpression(), !1493)
  %in_file.010.reg2mem94.0.in_file.010.reload95 = load ptr, ptr %in_file.010.reg2mem94, align 8
  %check_file.0.reg2mem92.0.check_file.0.reload93 = load ptr, ptr %check_file.0.reg2mem92, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1506, !tbaa !969
  %conv = sext i32 %2 to i64, !dbg !1506
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #20, !dbg !1507
    #dbg_value(ptr %call, !1489, !DIExpression(), !1493)
  store ptr %call, ptr %call.reg2mem, align 8
  %cmp8.not = icmp eq ptr %call, null, !dbg !1508
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1508

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.14, ptr noundef nonnull @.str.2.12, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1508
  unreachable, !dbg !1508

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.010.reg2mem94.0.in_file.010.reload95, i32 noundef signext 0) #18, !dbg !1511
    #dbg_value(i32 %call14, !1488, !DIExpression(), !1493)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1512
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1512

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.15, ptr noundef nonnull @.str.2.12, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1512
  unreachable, !dbg !1512

if.end20:                                         ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #18, !dbg !1515
    #dbg_value(ptr %call, !409, !DIExpression(), !1516)
    #dbg_value(ptr %call, !410, !DIExpression(), !1516)
  %m2.i = getelementptr inbounds i8, ptr %call, i64 32768, !dbg !1518
  %prod.i = getelementptr inbounds i8, ptr %call, i64 65536, !dbg !1519
    #dbg_value(ptr %call, !330, !DIExpression(), !1520)
    #dbg_value(ptr %m2.i, !331, !DIExpression(), !1520)
    #dbg_value(ptr %prod.i, !332, !DIExpression(), !1520)
    #dbg_label(!342, !1522)
    #dbg_value(i32 0, !336, !DIExpression(), !1520)
  store i64 0, ptr %indvars.iv69.i.i.reg2mem90, align 8
  br label %for.cond1.preheader.i.i, !dbg !1523

for.cond1.preheader.i.i:                          ; preds = %for.inc36.i.i.for.cond1.preheader.i.i_crit_edge, %if.end20
    #dbg_value(i64 %indvars.iv69.i.i.reg2mem90.0.load, !336, !DIExpression(), !1520)
    #dbg_value(i32 0, !337, !DIExpression(), !1520)
  %indvars.iv69.i.i.reg2mem90.0.load = load i64, ptr %indvars.iv69.i.i.reg2mem90, align 8
  %invariant.gep73.i.i = getelementptr double, ptr %m2.i, i64 %indvars.iv69.i.i.reg2mem90.0.load
  store i64 0, ptr %indvars.iv67.i.i.reg2mem88, align 8
  br label %for.cond4.preheader.i.i, !dbg !1524

for.cond4.preheader.i.i:                          ; preds = %for.inc33.i.i.for.cond4.preheader.i.i_crit_edge, %for.cond1.preheader.i.i
    #dbg_value(i64 %indvars.iv67.i.i.reg2mem88.0.load, !337, !DIExpression(), !1520)
    #dbg_value(i32 0, !333, !DIExpression(), !1520)
  %indvars.iv67.i.i.reg2mem88.0.load = load i64, ptr %indvars.iv67.i.i.reg2mem88, align 8
  store i32 0, ptr %i.056.i.i.reg2mem86, align 4
  br label %for.cond7.preheader.i.i, !dbg !1525

for.cond7.preheader.i.i:                          ; preds = %for.inc30.i.i.for.cond7.preheader.i.i_crit_edge, %for.cond4.preheader.i.i
    #dbg_value(i32 %i.056.i.i.reg2mem86.0.load, !333, !DIExpression(), !1520)
  %i.056.i.i.reg2mem86.0.load = load i32, ptr %i.056.i.i.reg2mem86, align 4
  %mul10.i.i = shl nuw nsw i32 %i.056.i.i.reg2mem86.0.load, 6
    #dbg_value(i32 0, !334, !DIExpression(), !1520)
  store i64 0, ptr %indvars.iv61.i.i.reg2mem84, align 8
  br label %for.body9.i.i, !dbg !1526

for.body9.i.i:                                    ; preds = %for.inc27.i.i.for.body9.i.i_crit_edge, %for.cond7.preheader.i.i
    #dbg_value(i64 %indvars.iv61.i.i.reg2mem84.0.load, !334, !DIExpression(), !1520)
    #dbg_value(i32 %mul10.i.i, !338, !DIExpression(), !1520)
  %indvars.iv61.i.i.reg2mem84.0.load = load i64, ptr %indvars.iv61.i.i.reg2mem84, align 8
  %3 = add nuw nsw i64 %indvars.iv61.i.i.reg2mem84.0.load, %indvars.iv67.i.i.reg2mem88.0.load, !dbg !1527
    #dbg_value(i64 %3, !339, !DIExpression(DW_OP_constu, 6, DW_OP_shl, DW_OP_stack_value), !1520)
  %4 = or i64 %indvars.iv61.i.i.reg2mem84.0.load, %indvars.iv67.i.i.reg2mem88.0.load, !dbg !1528
  %5 = trunc i64 %4 to i32, !dbg !1528
  %add13.i.i = or i32 %mul10.i.i, %5, !dbg !1528
  %idxprom.i.i = zext nneg i32 %add13.i.i to i64, !dbg !1529
  %arrayidx.i.i = getelementptr inbounds double, ptr %call, i64 %idxprom.i.i, !dbg !1529
  %6 = load double, ptr %arrayidx.i.i, align 8, !dbg !1529
    #dbg_value(double %6, !340, !DIExpression(), !1520)
    #dbg_label(!355, !1530)
    #dbg_value(i32 0, !335, !DIExpression(), !1520)
  %gep.idx.i.i = shl i64 %3, 9, !dbg !1531
  %gep.i.i = getelementptr i8, ptr %invariant.gep73.i.i, i64 %gep.idx.i.i, !dbg !1531
  store i64 0, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body16.i.i, !dbg !1531

for.body16.i.i:                                   ; preds = %for.body16.i.i.for.body16.i.i_crit_edge, %for.body9.i.i
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !335, !DIExpression(), !1520)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %gep72.i.i = getelementptr double, ptr %gep.i.i, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !1532
  %7 = load double, ptr %gep72.i.i, align 8, !dbg !1532, !tbaa !374
  %mul21.i.i = fmul double %6, %7, !dbg !1533
    #dbg_value(double %mul21.i.i, !341, !DIExpression(), !1520)
  %8 = or i64 %indvars.iv.i.i.reg2mem.0.load, %indvars.iv69.i.i.reg2mem90.0.load, !dbg !1534
  %9 = trunc i64 %8 to i32, !dbg !1534
  %add23.i.i = or i32 %mul10.i.i, %9, !dbg !1534
  %idxprom24.i.i = zext nneg i32 %add23.i.i to i64, !dbg !1535
  %arrayidx25.i.i = getelementptr inbounds double, ptr %prod.i, i64 %idxprom24.i.i, !dbg !1535
  %10 = load double, ptr %arrayidx25.i.i, align 8, !dbg !1536, !tbaa !374
  %add26.i.i = fadd double %10, %mul21.i.i, !dbg !1536
  store double %add26.i.i, ptr %arrayidx25.i.i, align 8, !dbg !1536, !tbaa !374
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !1537
    #dbg_value(i64 %indvars.iv.next.i.i, !335, !DIExpression(), !1520)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 8, !dbg !1538
  br i1 %exitcond.not.i.i, label %for.inc27.i.i, label %for.body16.i.i.for.body16.i.i_crit_edge, !dbg !1531, !llvm.loop !1539

for.body16.i.i.for.body16.i.i_crit_edge:          ; preds = %for.body16.i.i
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body16.i.i, !dbg !1531

for.inc27.i.i:                                    ; preds = %for.body16.i.i
  %indvars.iv.next62.i.i = add nuw nsw i64 %indvars.iv61.i.i.reg2mem84.0.load, 1, !dbg !1541
    #dbg_value(i64 %indvars.iv.next62.i.i, !334, !DIExpression(), !1520)
  %exitcond65.not.i.i = icmp eq i64 %indvars.iv.next62.i.i, 8, !dbg !1542
  br i1 %exitcond65.not.i.i, label %for.inc30.i.i, label %for.inc27.i.i.for.body9.i.i_crit_edge, !dbg !1526, !llvm.loop !1543

for.inc27.i.i.for.body9.i.i_crit_edge:            ; preds = %for.inc27.i.i
  store i64 %indvars.iv.next62.i.i, ptr %indvars.iv61.i.i.reg2mem84, align 8
  br label %for.body9.i.i, !dbg !1526

for.inc30.i.i:                                    ; preds = %for.inc27.i.i
  %inc31.i.i = add nuw nsw i32 %i.056.i.i.reg2mem86.0.load, 1, !dbg !1545
    #dbg_value(i32 %inc31.i.i, !333, !DIExpression(), !1520)
  %exitcond66.not.i.i = icmp eq i32 %inc31.i.i, 64, !dbg !1546
  br i1 %exitcond66.not.i.i, label %for.inc33.i.i, label %for.inc30.i.i.for.cond7.preheader.i.i_crit_edge, !dbg !1525, !llvm.loop !1547

for.inc30.i.i.for.cond7.preheader.i.i_crit_edge:  ; preds = %for.inc30.i.i
  store i32 %inc31.i.i, ptr %i.056.i.i.reg2mem86, align 4
  br label %for.cond7.preheader.i.i, !dbg !1525

for.inc33.i.i:                                    ; preds = %for.inc30.i.i
  %indvars.iv.next68.i.i = add nuw nsw i64 %indvars.iv67.i.i.reg2mem88.0.load, 8, !dbg !1549
    #dbg_value(i64 %indvars.iv.next68.i.i, !337, !DIExpression(), !1520)
  %cmp2.i.i = icmp ult i64 %indvars.iv67.i.i.reg2mem88.0.load, 56, !dbg !1550
  br i1 %cmp2.i.i, label %for.inc33.i.i.for.cond4.preheader.i.i_crit_edge, label %for.inc36.i.i, !dbg !1524, !llvm.loop !1551

for.inc33.i.i.for.cond4.preheader.i.i_crit_edge:  ; preds = %for.inc33.i.i
  store i64 %indvars.iv.next68.i.i, ptr %indvars.iv67.i.i.reg2mem88, align 8
  br label %for.cond4.preheader.i.i, !dbg !1524

for.inc36.i.i:                                    ; preds = %for.inc33.i.i
  %indvars.iv.next70.i.i = add nuw nsw i64 %indvars.iv69.i.i.reg2mem90.0.load, 8, !dbg !1553
    #dbg_value(i64 %indvars.iv.next70.i.i, !336, !DIExpression(), !1520)
  %cmp.i.i = icmp ult i64 %indvars.iv69.i.i.reg2mem90.0.load, 56, !dbg !1554
  br i1 %cmp.i.i, label %for.inc36.i.i.for.cond1.preheader.i.i_crit_edge, label %run_benchmark.exit, !dbg !1523, !llvm.loop !1555

for.inc36.i.i.for.cond1.preheader.i.i_crit_edge:  ; preds = %for.inc36.i.i
  store i64 %indvars.iv.next70.i.i, ptr %indvars.iv69.i.i.reg2mem90, align 8
  br label %for.cond1.preheader.i.i, !dbg !1523

run_benchmark.exit:                               ; preds = %for.inc36.i.i
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #18, !dbg !1557
    #dbg_value(i32 %call21, !1490, !DIExpression(), !1493)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1558
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1558

if.else26:                                        ; preds = %run_benchmark.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1558
  unreachable, !dbg !1558

if.end27:                                         ; preds = %run_benchmark.exit
    #dbg_value(i32 %call21, !596, !DIExpression(), !1561)
    #dbg_value(ptr %call, !597, !DIExpression(), !1561)
    #dbg_value(ptr %call, !598, !DIExpression(), !1561)
    #dbg_value(i32 %call21, !524, !DIExpression(), !1563)
  %cmp.i.i1.not = icmp eq i32 %call21, 1, !dbg !1565
  br i1 %cmp.i.i1.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1565

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1565
  unreachable, !dbg !1565

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1566
    #dbg_value(i32 %call21, !535, !DIExpression(), !1567)
    #dbg_value(ptr %prod.i, !540, !DIExpression(), !1567)
    #dbg_value(i32 4096, !541, !DIExpression(), !1567)
    #dbg_value(i32 0, !542, !DIExpression(), !1567)
  store i64 0, ptr %indvars.iv.i.i3.reg2mem, align 8
  br label %for.body.i.i, !dbg !1569

for.body.i.i:                                     ; preds = %for.body.i.i.for.body.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i3.reg2mem.0.load, !542, !DIExpression(), !1567)
  %indvars.iv.i.i3.reg2mem.0.load = load i64, ptr %indvars.iv.i.i3.reg2mem, align 8
  %arrayidx.i.i4 = getelementptr inbounds double, ptr %prod.i, i64 %indvars.iv.i.i3.reg2mem.0.load, !dbg !1570
  %11 = load double, ptr %arrayidx.i.i4, align 8, !dbg !1570, !tbaa !374
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.21, double noundef %11), !dbg !1570
  %indvars.iv.next.i.i5 = add nuw nsw i64 %indvars.iv.i.i3.reg2mem.0.load, 1, !dbg !1571
    #dbg_value(i64 %indvars.iv.next.i.i5, !542, !DIExpression(), !1567)
  %exitcond.not.i.i6 = icmp eq i64 %indvars.iv.next.i.i5, 4096, !dbg !1571
  br i1 %exitcond.not.i.i6, label %data_to_output.exit, label %for.body.i.i.for.body.i.i_crit_edge, !dbg !1569, !llvm.loop !1572

for.body.i.i.for.body.i.i_crit_edge:              ; preds = %for.body.i.i
  store i64 %indvars.iv.next.i.i5, ptr %indvars.iv.i.i3.reg2mem, align 8
  br label %for.body.i.i, !dbg !1569

data_to_output.exit:                              ; preds = %for.body.i.i
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #18, !dbg !1573
  %12 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1574, !tbaa !969
  %conv29 = sext i32 %12 to i64, !dbg !1574
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #20, !dbg !1575
    #dbg_value(ptr %call30, !1492, !DIExpression(), !1493)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1576
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1576

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.16, ptr noundef nonnull @.str.2.12, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1576
  unreachable, !dbg !1576

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem92.0.check_file.0.reload93, i32 noundef signext 0) #18, !dbg !1579
    #dbg_value(i32 %call37, !1491, !DIExpression(), !1493)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1580
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1580

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.17, ptr noundef nonnull @.str.2.12, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1580
  unreachable, !dbg !1580

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !565, !DIExpression(), !1583)
    #dbg_value(ptr %call30, !566, !DIExpression(), !1583)
    #dbg_value(ptr %call30, !567, !DIExpression(), !1583)
  %call.i = tail call ptr @readfile(i32 noundef signext %call37) #18, !dbg !1585
    #dbg_value(ptr %call.i, !568, !DIExpression(), !1583)
    #dbg_value(ptr %call.i, !464, !DIExpression(), !1586)
    #dbg_value(i32 1, !469, !DIExpression(), !1586)
    #dbg_value(i32 0, !470, !DIExpression(), !1586)
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem80, align 8
  store i32 0, ptr %i.041.i.i.reg2mem82, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i.reg2mem82.0.load, !470, !DIExpression(), !1586)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem80.0.s.addr.040.i.i.reload81, !464, !DIExpression(), !1586)
  %i.041.i.i.reg2mem82.0.load = load i32, ptr %i.041.i.i.reg2mem82, align 4
  %s.addr.040.i.i.reg2mem80.0.s.addr.040.i.i.reload81 = load ptr, ptr %s.addr.040.i.i.reg2mem80, align 8
  %13 = load i8, ptr %s.addr.040.i.i.reg2mem80.0.s.addr.040.i.i.reload81, align 1, !dbg !1588, !tbaa !474
  switch i8 %13, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1589

land.rhs.i.i.output_to_data.exit_crit_edge:       ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem80.0.s.addr.040.i.i.reload81, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1589

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem82.0.load, ptr %i.1.i.i.reg2mem78, align 4
  br label %if.end21.i.i, !dbg !1589

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem80.0.s.addr.040.i.i.reload81, i64 1, !dbg !1590
  %14 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !1590, !tbaa !474
  %cmp13.i.i = icmp eq i8 %14, 37, !dbg !1591
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1592

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem82.0.load, ptr %i.1.i.i.reg2mem78, align 4
  br label %if.end21.i.i, !dbg !1592

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem80.0.s.addr.040.i.i.reload81, i64 2, !dbg !1593
  %15 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1593, !tbaa !474
  %cmp18.i.i = icmp eq i8 %15, 10, !dbg !1594
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1595
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem82.0.load, %inc.i.i, !dbg !1595
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem78, align 4
  br label %if.end21.i.i, !dbg !1595

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem78.0.load, !470, !DIExpression(), !1586)
  %i.1.i.i.reg2mem78.0.load = load i32, ptr %i.1.i.i.reg2mem78, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem80.0.s.addr.040.i.i.reload81, i64 1, !dbg !1596
    #dbg_value(ptr %incdec.ptr.i.i, !464, !DIExpression(), !1586)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem78.0.load, 1, !dbg !1597
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1598, !llvm.loop !1599

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem80, align 8
  store i32 %i.1.i.i.reg2mem78.0.load, ptr %i.041.i.i.reg2mem82, align 4
  br label %land.rhs.i.i, !dbg !1598

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1601, !tbaa !474
  %16 = icmp eq i8 %.pre.i.i, 0, !dbg !1602
  %17 = select i1 %16, i64 0, i64 2, !dbg !1603
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %17, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1598

output_to_data.exit:                              ; preds = %land.rhs.i.i.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1603
    #dbg_value(ptr %spec.select38.i.i, !569, !DIExpression(), !1583)
  %prod.i7 = getelementptr inbounds i8, ptr %call30, i64 65536, !dbg !1604
  %call2.i = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i.i, ptr noundef nonnull %prod.i7, i32 noundef signext 4096) #18, !dbg !1605
  tail call void @free(ptr noundef %call.i) #18, !dbg !1606
    #dbg_value(ptr %call, !616, !DIExpression(), !1607)
    #dbg_value(ptr %call30, !617, !DIExpression(), !1607)
    #dbg_value(ptr %call, !618, !DIExpression(), !1607)
    #dbg_value(ptr %call30, !619, !DIExpression(), !1607)
    #dbg_value(i32 0, !620, !DIExpression(), !1607)
    #dbg_value(i32 0, !621, !DIExpression(), !1607)
  store i32 0, ptr %has_errors.025.i.reg2mem74, align 4
  store i64 0, ptr %indvars.iv27.i.reg2mem76, align 8
  br label %for.cond1.preheader.i, !dbg !1610

for.cond1.preheader.i:                            ; preds = %for.inc11.i.for.cond1.preheader.i_crit_edge, %output_to_data.exit
    #dbg_value(i32 %has_errors.025.i.reg2mem74.0.load, !620, !DIExpression(), !1607)
    #dbg_value(i64 %indvars.iv27.i.reg2mem76.0.load, !621, !DIExpression(), !1607)
  %indvars.iv27.i.reg2mem76.0.load = load i64, ptr %indvars.iv27.i.reg2mem76, align 8
  %has_errors.025.i.reg2mem74.0.load = load i32, ptr %has_errors.025.i.reg2mem74, align 4
  %18 = shl nuw nsw i64 %indvars.iv27.i.reg2mem76.0.load, 6
    #dbg_value(i32 0, !622, !DIExpression(), !1607)
  store i32 %has_errors.025.i.reg2mem74.0.load, ptr %has_errors.123.i.reg2mem, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body3.i, !dbg !1611

for.body3.i:                                      ; preds = %for.body3.i.for.body3.i_crit_edge, %for.cond1.preheader.i
    #dbg_value(i32 %has_errors.123.i.reg2mem.0.load, !620, !DIExpression(), !1607)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !622, !DIExpression(), !1607)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %has_errors.123.i.reg2mem.0.load = load i32, ptr %has_errors.123.i.reg2mem, align 4
  %19 = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, %18, !dbg !1612
  %call.reg2mem.0.call.reload = load ptr, ptr %call.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds %struct.bench_args_t, ptr %call.reg2mem.0.call.reload, i64 0, i32 2, i64 %19, !dbg !1613
  %20 = load double, ptr %arrayidx.i, align 8, !dbg !1613, !tbaa !374
  %arrayidx8.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 2, i64 %19, !dbg !1614
  %21 = load double, ptr %arrayidx8.i, align 8, !dbg !1614, !tbaa !374
  %sub.i = fsub double %20, %21, !dbg !1615
    #dbg_value(double %sub.i, !623, !DIExpression(), !1607)
  %22 = tail call double @llvm.fabs.f64(double %sub.i), !dbg !1616
  %23 = fcmp ogt double %22, 0x3EB0C6F7A0B5ED8D, !dbg !1616
  %lor.ext.i = zext i1 %23 to i32, !dbg !1616
  %or.i = or i32 %has_errors.123.i.reg2mem.0.load, %lor.ext.i, !dbg !1617
    #dbg_value(i32 %or.i, !620, !DIExpression(), !1607)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1618
    #dbg_value(i64 %indvars.iv.next.i, !622, !DIExpression(), !1607)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 64, !dbg !1619
  br i1 %exitcond.not.i, label %for.inc11.i, label %for.body3.i.for.body3.i_crit_edge, !dbg !1611, !llvm.loop !1620

for.body3.i.for.body3.i_crit_edge:                ; preds = %for.body3.i
  store i32 %or.i, ptr %has_errors.123.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body3.i, !dbg !1611

for.inc11.i:                                      ; preds = %for.body3.i
  %indvars.iv.next28.i = add nuw nsw i64 %indvars.iv27.i.reg2mem76.0.load, 1, !dbg !1622
    #dbg_value(i32 %or.i, !620, !DIExpression(), !1607)
    #dbg_value(i64 %indvars.iv.next28.i, !621, !DIExpression(), !1607)
  %exitcond30.not.i = icmp eq i64 %indvars.iv.next28.i, 64, !dbg !1623
  br i1 %exitcond30.not.i, label %check_data.exit, label %for.inc11.i.for.cond1.preheader.i_crit_edge, !dbg !1610, !llvm.loop !1624

for.inc11.i.for.cond1.preheader.i_crit_edge:      ; preds = %for.inc11.i
  store i32 %or.i, ptr %has_errors.025.i.reg2mem74, align 4
  store i64 %indvars.iv.next28.i, ptr %indvars.iv27.i.reg2mem76, align 8
  br label %for.cond1.preheader.i, !dbg !1610

check_data.exit:                                  ; preds = %for.inc11.i
  %tobool.not.i.not = icmp eq i32 %or.i, 0, !dbg !1626
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1627

if.then45:                                        ; preds = %check_data.exit
  %24 = load ptr, ptr @stderr, align 8, !dbg !1628, !tbaa !833
  %25 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %24) #21, !dbg !1630
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1631

if.end47:                                         ; preds = %check_data.exit
  tail call void @free(ptr noundef nonnull %call.reg2mem.0.call.reload) #18, !dbg !1632
  tail call void @free(ptr noundef nonnull %call30) #18, !dbg !1633
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1634
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1635

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1636
}

; Function Attrs: nofree
declare !dbg !1637 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #16

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #16

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #17

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
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
attributes #16 = { nofree nounwind }
attributes #17 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #18 = { nounwind }
attributes #19 = { noreturn nounwind }
attributes #20 = { nounwind allocsize(0) }
attributes #21 = { cold }
attributes #22 = { nounwind willreturn memory(read) }

!llvm.dbg.cu = !{!225, !188, !227, !292}
!llvm.ident = !{!313, !313, !313, !313}
!llvm.module.flags = !{!314, !315, !316, !317, !318, !320, !321, !322, !323, !324}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/gemm/blocked")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/gemm/blocked")
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
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/gemm/blocked")
!190 = !{!191, !197}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 33, size: 786432, elements: !194)
!193 = !DIFile(filename: "./gemm.h", directory: "/home/kelvin/MachSuite/gemm/blocked")
!194 = !{!195, !200, !201}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "m1", scope: !192, file: !193, line: 34, baseType: !196, size: 262144)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 262144, elements: !198)
!197 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!198 = !{!199}
!199 = !DISubrange(count: 4096)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "m2", scope: !192, file: !193, line: 35, baseType: !196, size: 262144, offset: 262144)
!201 = !DIDerivedType(tag: DW_TAG_member, name: "prod", scope: !192, file: !193, line: 36, baseType: !196, size: 262144, offset: 524288)
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
!226 = !DIFile(filename: "gemm.c", directory: "/home/kelvin/MachSuite/gemm/blocked")
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
!325 = distinct !DISubprogram(name: "gemm", scope: !226, file: !226, line: 10, type: !326, scopeLine: 10, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !225, retainedNodes: !329)
!326 = !DISubroutineType(types: !327)
!327 = !{null, !328, !328, !328}
!328 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!329 = !{!330, !331, !332, !333, !334, !335, !336, !337, !338, !339, !340, !341, !342, !343, !347, !351, !355}
!330 = !DILocalVariable(name: "m1", arg: 1, scope: !325, file: !226, line: 10, type: !328)
!331 = !DILocalVariable(name: "m2", arg: 2, scope: !325, file: !226, line: 10, type: !328)
!332 = !DILocalVariable(name: "prod", arg: 3, scope: !325, file: !226, line: 10, type: !328)
!333 = !DILocalVariable(name: "i", scope: !325, file: !226, line: 11, type: !203)
!334 = !DILocalVariable(name: "k", scope: !325, file: !226, line: 11, type: !203)
!335 = !DILocalVariable(name: "j", scope: !325, file: !226, line: 11, type: !203)
!336 = !DILocalVariable(name: "jj", scope: !325, file: !226, line: 11, type: !203)
!337 = !DILocalVariable(name: "kk", scope: !325, file: !226, line: 11, type: !203)
!338 = !DILocalVariable(name: "i_row", scope: !325, file: !226, line: 12, type: !203)
!339 = !DILocalVariable(name: "k_row", scope: !325, file: !226, line: 12, type: !203)
!340 = !DILocalVariable(name: "temp_x", scope: !325, file: !226, line: 13, type: !197)
!341 = !DILocalVariable(name: "mul", scope: !325, file: !226, line: 13, type: !197)
!342 = !DILabel(scope: !325, name: "loopjj", file: !226, line: 15)
!343 = !DILabel(scope: !344, name: "loopkk", file: !226, line: 16)
!344 = distinct !DILexicalBlock(scope: !345, file: !226, line: 15, column: 57)
!345 = distinct !DILexicalBlock(scope: !346, file: !226, line: 15, column: 12)
!346 = distinct !DILexicalBlock(scope: !325, file: !226, line: 15, column: 12)
!347 = !DILabel(scope: !348, name: "loopi", file: !226, line: 17)
!348 = distinct !DILexicalBlock(scope: !349, file: !226, line: 16, column: 61)
!349 = distinct !DILexicalBlock(scope: !350, file: !226, line: 16, column: 16)
!350 = distinct !DILexicalBlock(scope: !344, file: !226, line: 16, column: 16)
!351 = !DILabel(scope: !352, name: "loopk", file: !226, line: 18)
!352 = distinct !DILexicalBlock(scope: !353, file: !226, line: 17, column: 50)
!353 = distinct !DILexicalBlock(scope: !354, file: !226, line: 17, column: 19)
!354 = distinct !DILexicalBlock(scope: !348, file: !226, line: 17, column: 19)
!355 = !DILabel(scope: !356, name: "loopj", file: !226, line: 22)
!356 = distinct !DILexicalBlock(scope: !357, file: !226, line: 18, column: 55)
!357 = distinct !DILexicalBlock(scope: !358, file: !226, line: 18, column: 23)
!358 = distinct !DILexicalBlock(scope: !352, file: !226, line: 18, column: 23)
!359 = !DILocation(line: 0, scope: !325)
!360 = !DILocation(line: 15, column: 5, scope: !325)
!361 = !DILocation(line: 15, column: 12, scope: !346)
!362 = !DILocation(line: 16, column: 16, scope: !350)
!363 = !DILocation(line: 17, column: 19, scope: !354)
!364 = !DILocation(line: 18, column: 23, scope: !358)
!365 = !DILocation(line: 20, column: 33, scope: !356)
!366 = !DILocation(line: 21, column: 43, scope: !356)
!367 = !DILocation(line: 21, column: 30, scope: !356)
!368 = !DILocation(line: 22, column: 21, scope: !356)
!369 = !DILocation(line: 22, column: 27, scope: !370)
!370 = distinct !DILexicalBlock(scope: !356, file: !226, line: 22, column: 27)
!371 = !DILocation(line: 23, column: 40, scope: !372)
!372 = distinct !DILexicalBlock(scope: !373, file: !226, line: 22, column: 59)
!373 = distinct !DILexicalBlock(scope: !370, file: !226, line: 22, column: 27)
!374 = !{!375, !375, i64 0}
!375 = !{!"double", !376, i64 0}
!376 = !{!"omnipotent char", !377, i64 0}
!377 = !{!"Simple C/C++ TBAA"}
!378 = !DILocation(line: 23, column: 38, scope: !372)
!379 = !DILocation(line: 24, column: 40, scope: !372)
!380 = !DILocation(line: 24, column: 25, scope: !372)
!381 = !DILocation(line: 24, column: 46, scope: !372)
!382 = !DILocation(line: 22, column: 55, scope: !373)
!383 = !DILocation(line: 22, column: 41, scope: !373)
!384 = distinct !{!384, !369, !385, !386, !387}
!385 = !DILocation(line: 25, column: 21, scope: !370)
!386 = !{!"llvm.loop.mustprogress"}
!387 = !{!"llvm.loop.unroll.disable"}
!388 = !DILocation(line: 18, column: 51, scope: !357)
!389 = !DILocation(line: 18, column: 37, scope: !357)
!390 = distinct !{!390, !364, !391, !386, !387}
!391 = !DILocation(line: 26, column: 17, scope: !358)
!392 = !DILocation(line: 17, column: 46, scope: !353)
!393 = !DILocation(line: 17, column: 34, scope: !353)
!394 = distinct !{!394, !363, !395, !386, !387}
!395 = !DILocation(line: 27, column: 13, scope: !354)
!396 = !DILocation(line: 16, column: 47, scope: !349)
!397 = !DILocation(line: 16, column: 32, scope: !349)
!398 = distinct !{!398, !362, !399, !386, !387}
!399 = !DILocation(line: 28, column: 9, scope: !350)
!400 = !DILocation(line: 15, column: 43, scope: !345)
!401 = !DILocation(line: 15, column: 28, scope: !345)
!402 = distinct !{!402, !361, !403, !386, !387}
!403 = !DILocation(line: 29, column: 5, scope: !346)
!404 = !DILocation(line: 30, column: 1, scope: !325)
!405 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 8, type: !406, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !408)
!406 = !DISubroutineType(types: !407)
!407 = !{null, !230}
!408 = !{!409, !410}
!409 = !DILocalVariable(name: "vargs", arg: 1, scope: !405, file: !189, line: 8, type: !230)
!410 = !DILocalVariable(name: "args", scope: !405, file: !189, line: 9, type: !191)
!411 = !DILocation(line: 0, scope: !405)
!412 = !DILocation(line: 10, column: 25, scope: !405)
!413 = !DILocation(line: 10, column: 35, scope: !405)
!414 = !DILocation(line: 0, scope: !325, inlinedAt: !415)
!415 = distinct !DILocation(line: 10, column: 3, scope: !405)
!416 = !DILocation(line: 15, column: 5, scope: !325, inlinedAt: !415)
!417 = !DILocation(line: 15, column: 12, scope: !346, inlinedAt: !415)
!418 = !DILocation(line: 16, column: 16, scope: !350, inlinedAt: !415)
!419 = !DILocation(line: 17, column: 19, scope: !354, inlinedAt: !415)
!420 = !DILocation(line: 18, column: 23, scope: !358, inlinedAt: !415)
!421 = !DILocation(line: 20, column: 33, scope: !356, inlinedAt: !415)
!422 = !DILocation(line: 21, column: 43, scope: !356, inlinedAt: !415)
!423 = !DILocation(line: 21, column: 30, scope: !356, inlinedAt: !415)
!424 = !DILocation(line: 22, column: 21, scope: !356, inlinedAt: !415)
!425 = !DILocation(line: 22, column: 27, scope: !370, inlinedAt: !415)
!426 = !DILocation(line: 23, column: 40, scope: !372, inlinedAt: !415)
!427 = !DILocation(line: 23, column: 38, scope: !372, inlinedAt: !415)
!428 = !DILocation(line: 24, column: 40, scope: !372, inlinedAt: !415)
!429 = !DILocation(line: 24, column: 25, scope: !372, inlinedAt: !415)
!430 = !DILocation(line: 24, column: 46, scope: !372, inlinedAt: !415)
!431 = !DILocation(line: 22, column: 55, scope: !373, inlinedAt: !415)
!432 = !DILocation(line: 22, column: 41, scope: !373, inlinedAt: !415)
!433 = distinct !{!433, !425, !434, !386, !387}
!434 = !DILocation(line: 25, column: 21, scope: !370, inlinedAt: !415)
!435 = !DILocation(line: 18, column: 51, scope: !357, inlinedAt: !415)
!436 = !DILocation(line: 18, column: 37, scope: !357, inlinedAt: !415)
!437 = distinct !{!437, !420, !438, !386, !387}
!438 = !DILocation(line: 26, column: 17, scope: !358, inlinedAt: !415)
!439 = !DILocation(line: 17, column: 46, scope: !353, inlinedAt: !415)
!440 = !DILocation(line: 17, column: 34, scope: !353, inlinedAt: !415)
!441 = distinct !{!441, !419, !442, !386, !387}
!442 = !DILocation(line: 27, column: 13, scope: !354, inlinedAt: !415)
!443 = !DILocation(line: 16, column: 47, scope: !349, inlinedAt: !415)
!444 = !DILocation(line: 16, column: 32, scope: !349, inlinedAt: !415)
!445 = distinct !{!445, !418, !446, !386, !387}
!446 = !DILocation(line: 28, column: 9, scope: !350, inlinedAt: !415)
!447 = !DILocation(line: 15, column: 43, scope: !345, inlinedAt: !415)
!448 = !DILocation(line: 15, column: 28, scope: !345, inlinedAt: !415)
!449 = distinct !{!449, !417, !450, !386, !387}
!450 = !DILocation(line: 29, column: 5, scope: !346, inlinedAt: !415)
!451 = !DILocation(line: 11, column: 1, scope: !405)
!452 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 20, type: !453, scopeLine: 20, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !455)
!453 = !DISubroutineType(types: !454)
!454 = !{null, !203, !230}
!455 = !{!456, !457, !458, !459, !460}
!456 = !DILocalVariable(name: "fd", arg: 1, scope: !452, file: !189, line: 20, type: !203)
!457 = !DILocalVariable(name: "vdata", arg: 2, scope: !452, file: !189, line: 20, type: !230)
!458 = !DILocalVariable(name: "data", scope: !452, file: !189, line: 21, type: !191)
!459 = !DILocalVariable(name: "p", scope: !452, file: !189, line: 22, type: !229)
!460 = !DILocalVariable(name: "s", scope: !452, file: !189, line: 22, type: !229)
!461 = !DILocation(line: 0, scope: !452)
!462 = !DILocation(line: 24, column: 3, scope: !452)
!463 = !DILocation(line: 26, column: 7, scope: !452)
!464 = !DILocalVariable(name: "s", arg: 1, scope: !465, file: !2, line: 56, type: !229)
!465 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !466, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !468)
!466 = !DISubroutineType(types: !467)
!467 = !{!229, !229, !203}
!468 = !{!464, !469, !470}
!469 = !DILocalVariable(name: "n", arg: 2, scope: !465, file: !2, line: 56, type: !203)
!470 = !DILocalVariable(name: "i", scope: !465, file: !2, line: 57, type: !203)
!471 = !DILocation(line: 0, scope: !465, inlinedAt: !472)
!472 = distinct !DILocation(line: 28, column: 7, scope: !452)
!473 = !DILocation(line: 64, column: 17, scope: !465, inlinedAt: !472)
!474 = !{!376, !376, i64 0}
!475 = !DILocation(line: 64, column: 3, scope: !465, inlinedAt: !472)
!476 = !DILocation(line: 66, column: 22, scope: !477, inlinedAt: !472)
!477 = distinct !DILexicalBlock(scope: !478, file: !2, line: 66, column: 9)
!478 = distinct !DILexicalBlock(scope: !465, file: !2, line: 64, column: 31)
!479 = !DILocation(line: 66, column: 26, scope: !477, inlinedAt: !472)
!480 = !DILocation(line: 66, column: 32, scope: !477, inlinedAt: !472)
!481 = !DILocation(line: 66, column: 35, scope: !477, inlinedAt: !472)
!482 = !DILocation(line: 66, column: 39, scope: !477, inlinedAt: !472)
!483 = !DILocation(line: 66, column: 9, scope: !478, inlinedAt: !472)
!484 = !DILocation(line: 69, column: 6, scope: !478, inlinedAt: !472)
!485 = !DILocation(line: 64, column: 10, scope: !465, inlinedAt: !472)
!486 = !DILocation(line: 64, column: 13, scope: !465, inlinedAt: !472)
!487 = distinct !{!487, !475, !488, !386, !387}
!488 = !DILocation(line: 70, column: 3, scope: !465, inlinedAt: !472)
!489 = !DILocation(line: 71, column: 6, scope: !490, inlinedAt: !472)
!490 = distinct !DILexicalBlock(scope: !465, file: !2, line: 71, column: 6)
!491 = !DILocation(line: 71, column: 8, scope: !490, inlinedAt: !472)
!492 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !472)
!493 = !DILocation(line: 29, column: 3, scope: !452)
!494 = !DILocation(line: 0, scope: !465, inlinedAt: !495)
!495 = distinct !DILocation(line: 31, column: 7, scope: !452)
!496 = !DILocation(line: 64, column: 17, scope: !465, inlinedAt: !495)
!497 = !DILocation(line: 64, column: 3, scope: !465, inlinedAt: !495)
!498 = !DILocation(line: 66, column: 22, scope: !477, inlinedAt: !495)
!499 = !DILocation(line: 66, column: 26, scope: !477, inlinedAt: !495)
!500 = !DILocation(line: 66, column: 32, scope: !477, inlinedAt: !495)
!501 = !DILocation(line: 66, column: 35, scope: !477, inlinedAt: !495)
!502 = !DILocation(line: 66, column: 39, scope: !477, inlinedAt: !495)
!503 = !DILocation(line: 66, column: 9, scope: !478, inlinedAt: !495)
!504 = !DILocation(line: 69, column: 6, scope: !478, inlinedAt: !495)
!505 = !DILocation(line: 64, column: 10, scope: !465, inlinedAt: !495)
!506 = !DILocation(line: 64, column: 13, scope: !465, inlinedAt: !495)
!507 = distinct !{!507, !497, !508, !386, !387}
!508 = !DILocation(line: 70, column: 3, scope: !465, inlinedAt: !495)
!509 = !DILocation(line: 71, column: 6, scope: !490, inlinedAt: !495)
!510 = !DILocation(line: 71, column: 8, scope: !490, inlinedAt: !495)
!511 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !495)
!512 = !DILocation(line: 32, column: 37, scope: !452)
!513 = !DILocation(line: 32, column: 3, scope: !452)
!514 = !DILocation(line: 33, column: 3, scope: !452)
!515 = !DILocation(line: 34, column: 1, scope: !452)
!516 = !DISubprogram(name: "free", scope: !517, file: !517, line: 687, type: !406, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!517 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!518 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 36, type: !453, scopeLine: 36, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !519)
!519 = !{!520, !521, !522}
!520 = !DILocalVariable(name: "fd", arg: 1, scope: !518, file: !189, line: 36, type: !203)
!521 = !DILocalVariable(name: "vdata", arg: 2, scope: !518, file: !189, line: 36, type: !230)
!522 = !DILocalVariable(name: "data", scope: !518, file: !189, line: 37, type: !191)
!523 = !DILocation(line: 0, scope: !518)
!524 = !DILocalVariable(name: "fd", arg: 1, scope: !525, file: !2, line: 189, type: !203)
!525 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !526, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !528)
!526 = !DISubroutineType(types: !527)
!527 = !{!203, !203}
!528 = !{!524}
!529 = !DILocation(line: 0, scope: !525, inlinedAt: !530)
!530 = distinct !DILocation(line: 39, column: 3, scope: !518)
!531 = !DILocation(line: 190, column: 3, scope: !532, inlinedAt: !530)
!532 = distinct !DILexicalBlock(scope: !533, file: !2, line: 190, column: 3)
!533 = distinct !DILexicalBlock(scope: !525, file: !2, line: 190, column: 3)
!534 = !DILocation(line: 191, column: 3, scope: !525, inlinedAt: !530)
!535 = !DILocalVariable(name: "fd", arg: 1, scope: !536, file: !2, line: 187, type: !203)
!536 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !537, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !539)
!537 = !DISubroutineType(types: !538)
!538 = !{!203, !203, !328, !203}
!539 = !{!535, !540, !541, !542}
!540 = !DILocalVariable(name: "arr", arg: 2, scope: !536, file: !2, line: 187, type: !328)
!541 = !DILocalVariable(name: "n", arg: 3, scope: !536, file: !2, line: 187, type: !203)
!542 = !DILocalVariable(name: "i", scope: !536, file: !2, line: 187, type: !203)
!543 = !DILocation(line: 0, scope: !536, inlinedAt: !544)
!544 = distinct !DILocation(line: 40, column: 3, scope: !518)
!545 = !DILocation(line: 187, column: 1, scope: !546, inlinedAt: !544)
!546 = distinct !DILexicalBlock(scope: !536, file: !2, line: 187, column: 1)
!547 = !DILocation(line: 187, column: 1, scope: !548, inlinedAt: !544)
!548 = distinct !DILexicalBlock(scope: !549, file: !2, line: 187, column: 1)
!549 = distinct !DILexicalBlock(scope: !546, file: !2, line: 187, column: 1)
!550 = !DILocation(line: 187, column: 1, scope: !549, inlinedAt: !544)
!551 = distinct !{!551, !545, !545, !386, !387}
!552 = !DILocation(line: 0, scope: !525, inlinedAt: !553)
!553 = distinct !DILocation(line: 42, column: 3, scope: !518)
!554 = !DILocation(line: 191, column: 3, scope: !525, inlinedAt: !553)
!555 = !DILocation(line: 43, column: 38, scope: !518)
!556 = !DILocation(line: 0, scope: !536, inlinedAt: !557)
!557 = distinct !DILocation(line: 43, column: 3, scope: !518)
!558 = !DILocation(line: 187, column: 1, scope: !546, inlinedAt: !557)
!559 = !DILocation(line: 187, column: 1, scope: !548, inlinedAt: !557)
!560 = !DILocation(line: 187, column: 1, scope: !549, inlinedAt: !557)
!561 = distinct !{!561, !558, !558, !386, !387}
!562 = !DILocation(line: 44, column: 1, scope: !518)
!563 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 51, type: !453, scopeLine: 51, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !564)
!564 = !{!565, !566, !567, !568, !569}
!565 = !DILocalVariable(name: "fd", arg: 1, scope: !563, file: !189, line: 51, type: !203)
!566 = !DILocalVariable(name: "vdata", arg: 2, scope: !563, file: !189, line: 51, type: !230)
!567 = !DILocalVariable(name: "data", scope: !563, file: !189, line: 52, type: !191)
!568 = !DILocalVariable(name: "p", scope: !563, file: !189, line: 53, type: !229)
!569 = !DILocalVariable(name: "s", scope: !563, file: !189, line: 53, type: !229)
!570 = !DILocation(line: 0, scope: !563)
!571 = !DILocation(line: 55, column: 7, scope: !563)
!572 = !DILocation(line: 0, scope: !465, inlinedAt: !573)
!573 = distinct !DILocation(line: 57, column: 7, scope: !563)
!574 = !DILocation(line: 64, column: 17, scope: !465, inlinedAt: !573)
!575 = !DILocation(line: 64, column: 3, scope: !465, inlinedAt: !573)
!576 = !DILocation(line: 66, column: 22, scope: !477, inlinedAt: !573)
!577 = !DILocation(line: 66, column: 26, scope: !477, inlinedAt: !573)
!578 = !DILocation(line: 66, column: 32, scope: !477, inlinedAt: !573)
!579 = !DILocation(line: 66, column: 35, scope: !477, inlinedAt: !573)
!580 = !DILocation(line: 66, column: 39, scope: !477, inlinedAt: !573)
!581 = !DILocation(line: 66, column: 9, scope: !478, inlinedAt: !573)
!582 = !DILocation(line: 69, column: 6, scope: !478, inlinedAt: !573)
!583 = !DILocation(line: 64, column: 10, scope: !465, inlinedAt: !573)
!584 = !DILocation(line: 64, column: 13, scope: !465, inlinedAt: !573)
!585 = distinct !{!585, !575, !586, !386, !387}
!586 = !DILocation(line: 70, column: 3, scope: !465, inlinedAt: !573)
!587 = !DILocation(line: 71, column: 6, scope: !490, inlinedAt: !573)
!588 = !DILocation(line: 71, column: 8, scope: !490, inlinedAt: !573)
!589 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !573)
!590 = !DILocation(line: 58, column: 37, scope: !563)
!591 = !DILocation(line: 58, column: 3, scope: !563)
!592 = !DILocation(line: 59, column: 3, scope: !563)
!593 = !DILocation(line: 60, column: 1, scope: !563)
!594 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 62, type: !453, scopeLine: 62, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !595)
!595 = !{!596, !597, !598}
!596 = !DILocalVariable(name: "fd", arg: 1, scope: !594, file: !189, line: 62, type: !203)
!597 = !DILocalVariable(name: "vdata", arg: 2, scope: !594, file: !189, line: 62, type: !230)
!598 = !DILocalVariable(name: "data", scope: !594, file: !189, line: 63, type: !191)
!599 = !DILocation(line: 0, scope: !594)
!600 = !DILocation(line: 0, scope: !525, inlinedAt: !601)
!601 = distinct !DILocation(line: 65, column: 3, scope: !594)
!602 = !DILocation(line: 190, column: 3, scope: !532, inlinedAt: !601)
!603 = !DILocation(line: 191, column: 3, scope: !525, inlinedAt: !601)
!604 = !DILocation(line: 66, column: 38, scope: !594)
!605 = !DILocation(line: 0, scope: !536, inlinedAt: !606)
!606 = distinct !DILocation(line: 66, column: 3, scope: !594)
!607 = !DILocation(line: 187, column: 1, scope: !546, inlinedAt: !606)
!608 = !DILocation(line: 187, column: 1, scope: !548, inlinedAt: !606)
!609 = !DILocation(line: 187, column: 1, scope: !549, inlinedAt: !606)
!610 = distinct !{!610, !607, !607, !386, !387}
!611 = !DILocation(line: 67, column: 1, scope: !594)
!612 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 69, type: !613, scopeLine: 69, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !615)
!613 = !DISubroutineType(types: !614)
!614 = !{!203, !230, !230}
!615 = !{!616, !617, !618, !619, !620, !621, !622, !623}
!616 = !DILocalVariable(name: "vdata", arg: 1, scope: !612, file: !189, line: 69, type: !230)
!617 = !DILocalVariable(name: "vref", arg: 2, scope: !612, file: !189, line: 69, type: !230)
!618 = !DILocalVariable(name: "data", scope: !612, file: !189, line: 70, type: !191)
!619 = !DILocalVariable(name: "ref", scope: !612, file: !189, line: 71, type: !191)
!620 = !DILocalVariable(name: "has_errors", scope: !612, file: !189, line: 72, type: !203)
!621 = !DILocalVariable(name: "r", scope: !612, file: !189, line: 73, type: !203)
!622 = !DILocalVariable(name: "c", scope: !612, file: !189, line: 73, type: !203)
!623 = !DILocalVariable(name: "diff", scope: !612, file: !189, line: 74, type: !197)
!624 = !DILocation(line: 0, scope: !612)
!625 = !DILocation(line: 76, column: 3, scope: !626)
!626 = distinct !DILexicalBlock(scope: !612, file: !189, line: 76, column: 3)
!627 = !DILocation(line: 77, column: 5, scope: !628)
!628 = distinct !DILexicalBlock(scope: !629, file: !189, line: 77, column: 5)
!629 = distinct !DILexicalBlock(scope: !630, file: !189, line: 76, column: 31)
!630 = distinct !DILexicalBlock(scope: !626, file: !189, line: 76, column: 3)
!631 = !DILocation(line: 78, column: 36, scope: !632)
!632 = distinct !DILexicalBlock(scope: !633, file: !189, line: 77, column: 33)
!633 = distinct !DILexicalBlock(scope: !628, file: !189, line: 77, column: 5)
!634 = !DILocation(line: 78, column: 14, scope: !632)
!635 = !DILocation(line: 78, column: 43, scope: !632)
!636 = !DILocation(line: 78, column: 41, scope: !632)
!637 = !DILocation(line: 79, column: 37, scope: !632)
!638 = !DILocation(line: 79, column: 18, scope: !632)
!639 = !DILocation(line: 77, column: 28, scope: !633)
!640 = !DILocation(line: 77, column: 16, scope: !633)
!641 = distinct !{!641, !627, !642, !386, !387}
!642 = !DILocation(line: 80, column: 5, scope: !628)
!643 = !DILocation(line: 76, column: 26, scope: !630)
!644 = !DILocation(line: 76, column: 14, scope: !630)
!645 = distinct !{!645, !625, !646, !386, !387}
!646 = !DILocation(line: 81, column: 3, scope: !626)
!647 = !DILocation(line: 84, column: 10, scope: !612)
!648 = !DILocation(line: 84, column: 3, scope: !612)
!649 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !650, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !652)
!650 = !DISubroutineType(types: !651)
!651 = !{!229, !203}
!652 = !{!653, !654, !655, !692, !695, !698}
!653 = !DILocalVariable(name: "fd", arg: 1, scope: !649, file: !2, line: 34, type: !203)
!654 = !DILocalVariable(name: "p", scope: !649, file: !2, line: 35, type: !229)
!655 = !DILocalVariable(name: "s", scope: !649, file: !2, line: 36, type: !656)
!656 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !657, line: 44, size: 1024, elements: !658)
!657 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!658 = !{!659, !661, !663, !665, !667, !669, !671, !672, !673, !675, !677, !678, !680, !688, !689, !690}
!659 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !656, file: !657, line: 46, baseType: !660, size: 64)
!660 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !234, line: 145, baseType: !244)
!661 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !656, file: !657, line: 47, baseType: !662, size: 64, offset: 64)
!662 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !234, line: 148, baseType: !244)
!663 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !656, file: !657, line: 48, baseType: !664, size: 32, offset: 128)
!664 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !234, line: 150, baseType: !241)
!665 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !656, file: !657, line: 49, baseType: !666, size: 32, offset: 160)
!666 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !234, line: 151, baseType: !241)
!667 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !656, file: !657, line: 50, baseType: !668, size: 32, offset: 192)
!668 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !234, line: 146, baseType: !241)
!669 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !656, file: !657, line: 51, baseType: !670, size: 32, offset: 224)
!670 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !234, line: 147, baseType: !241)
!671 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !656, file: !657, line: 52, baseType: !660, size: 64, offset: 256)
!672 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !656, file: !657, line: 53, baseType: !660, size: 64, offset: 320)
!673 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !656, file: !657, line: 54, baseType: !674, size: 64, offset: 384)
!674 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !234, line: 152, baseType: !256)
!675 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !656, file: !657, line: 55, baseType: !676, size: 32, offset: 448)
!676 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !234, line: 175, baseType: !203)
!677 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !656, file: !657, line: 56, baseType: !203, size: 32, offset: 480)
!678 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !656, file: !657, line: 57, baseType: !679, size: 64, offset: 512)
!679 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !234, line: 180, baseType: !256)
!680 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !656, file: !657, line: 65, baseType: !681, size: 128, offset: 576)
!681 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !682, line: 11, size: 128, elements: !683)
!682 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!683 = !{!684, !686}
!684 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !681, file: !682, line: 16, baseType: !685, size: 64)
!685 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !234, line: 160, baseType: !256)
!686 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !681, file: !682, line: 21, baseType: !687, size: 64, offset: 64)
!687 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !234, line: 197, baseType: !256)
!688 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !656, file: !657, line: 66, baseType: !681, size: 128, offset: 704)
!689 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !656, file: !657, line: 67, baseType: !681, size: 128, offset: 832)
!690 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !656, file: !657, line: 79, baseType: !691, size: 64, offset: 960)
!691 = !DICompositeType(tag: DW_TAG_array_type, baseType: !203, size: 64, elements: !55)
!692 = !DILocalVariable(name: "len", scope: !649, file: !2, line: 37, type: !693)
!693 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !694, line: 85, baseType: !674)
!694 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!695 = !DILocalVariable(name: "bytes_read", scope: !649, file: !2, line: 38, type: !696)
!696 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !694, line: 108, baseType: !697)
!697 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !234, line: 194, baseType: !256)
!698 = !DILocalVariable(name: "status", scope: !649, file: !2, line: 38, type: !696)
!699 = distinct !DIAssignID()
!700 = !DILocation(line: 0, scope: !649)
!701 = !DILocation(line: 36, column: 3, scope: !649)
!702 = !DILocation(line: 40, column: 3, scope: !703)
!703 = distinct !DILexicalBlock(scope: !704, file: !2, line: 40, column: 3)
!704 = distinct !DILexicalBlock(scope: !649, file: !2, line: 40, column: 3)
!705 = !DILocation(line: 41, column: 3, scope: !706)
!706 = distinct !DILexicalBlock(scope: !707, file: !2, line: 41, column: 3)
!707 = distinct !DILexicalBlock(scope: !649, file: !2, line: 41, column: 3)
!708 = !DILocation(line: 42, column: 11, scope: !649)
!709 = !DILocation(line: 43, column: 3, scope: !710)
!710 = distinct !DILexicalBlock(scope: !711, file: !2, line: 43, column: 3)
!711 = distinct !DILexicalBlock(scope: !649, file: !2, line: 43, column: 3)
!712 = !DILocation(line: 44, column: 25, scope: !649)
!713 = !DILocation(line: 44, column: 15, scope: !649)
!714 = !DILocation(line: 46, column: 3, scope: !649)
!715 = !DILocation(line: 49, column: 15, scope: !716)
!716 = distinct !DILexicalBlock(scope: !649, file: !2, line: 46, column: 27)
!717 = !DILocation(line: 46, column: 20, scope: !649)
!718 = distinct !{!718, !714, !719, !386, !387}
!719 = !DILocation(line: 50, column: 3, scope: !649)
!720 = !DILocation(line: 47, column: 24, scope: !716)
!721 = !DILocation(line: 47, column: 42, scope: !716)
!722 = !DILocation(line: 47, column: 14, scope: !716)
!723 = !DILocation(line: 48, column: 5, scope: !724)
!724 = distinct !DILexicalBlock(scope: !725, file: !2, line: 48, column: 5)
!725 = distinct !DILexicalBlock(scope: !716, file: !2, line: 48, column: 5)
!726 = !DILocation(line: 51, column: 3, scope: !649)
!727 = !DILocation(line: 51, column: 10, scope: !649)
!728 = !DILocation(line: 52, column: 3, scope: !649)
!729 = !DILocation(line: 54, column: 1, scope: !649)
!730 = !DILocation(line: 53, column: 3, scope: !649)
!731 = !DISubprogram(name: "__assert_fail", scope: !732, file: !732, line: 67, type: !733, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!732 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!733 = !DISubroutineType(types: !734)
!734 = !{null, !735, !735, !241, !735}
!735 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!736 = !DISubprogram(name: "fstat", scope: !737, file: !737, line: 210, type: !738, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!737 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!738 = !DISubroutineType(types: !739)
!739 = !{!203, !203, !740}
!740 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !656, size: 64)
!741 = !DISubprogram(name: "malloc", scope: !517, file: !517, line: 672, type: !742, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!742 = !DISubroutineType(types: !743)
!743 = !{!230, !744}
!744 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !745, line: 18, baseType: !244)
!745 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!746 = !DISubprogram(name: "read", scope: !747, file: !747, line: 371, type: !748, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!747 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!748 = !DISubroutineType(types: !749)
!749 = !{!696, !203, !230, !744}
!750 = !DISubprogram(name: "close", scope: !747, file: !747, line: 358, type: !526, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!751 = !DILocation(line: 0, scope: !465)
!752 = !DILocation(line: 59, column: 3, scope: !753)
!753 = distinct !DILexicalBlock(scope: !754, file: !2, line: 59, column: 3)
!754 = distinct !DILexicalBlock(scope: !465, file: !2, line: 59, column: 3)
!755 = !DILocation(line: 60, column: 7, scope: !756)
!756 = distinct !DILexicalBlock(scope: !465, file: !2, line: 60, column: 6)
!757 = !DILocation(line: 60, column: 6, scope: !465)
!758 = !DILocation(line: 64, column: 17, scope: !465)
!759 = !DILocation(line: 64, column: 3, scope: !465)
!760 = !DILocation(line: 66, column: 22, scope: !477)
!761 = !DILocation(line: 66, column: 26, scope: !477)
!762 = !DILocation(line: 66, column: 32, scope: !477)
!763 = !DILocation(line: 66, column: 35, scope: !477)
!764 = !DILocation(line: 66, column: 39, scope: !477)
!765 = !DILocation(line: 66, column: 9, scope: !478)
!766 = !DILocation(line: 69, column: 6, scope: !478)
!767 = !DILocation(line: 64, column: 10, scope: !465)
!768 = !DILocation(line: 64, column: 13, scope: !465)
!769 = distinct !{!769, !759, !770, !386, !387}
!770 = !DILocation(line: 70, column: 3, scope: !465)
!771 = !DILocation(line: 71, column: 6, scope: !490)
!772 = !DILocation(line: 71, column: 8, scope: !490)
!773 = !DILocation(line: 71, column: 6, scope: !465)
!774 = !DILocation(line: 74, column: 1, scope: !465)
!775 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !776, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !778)
!776 = !DISubroutineType(types: !777)
!777 = !{!203, !229, !229, !203}
!778 = !{!779, !780, !781, !782}
!779 = !DILocalVariable(name: "s", arg: 1, scope: !775, file: !2, line: 77, type: !229)
!780 = !DILocalVariable(name: "arr", arg: 2, scope: !775, file: !2, line: 77, type: !229)
!781 = !DILocalVariable(name: "n", arg: 3, scope: !775, file: !2, line: 77, type: !203)
!782 = !DILocalVariable(name: "k", scope: !775, file: !2, line: 78, type: !203)
!783 = !DILocation(line: 0, scope: !775)
!784 = !DILocation(line: 79, column: 3, scope: !785)
!785 = distinct !DILexicalBlock(scope: !786, file: !2, line: 79, column: 3)
!786 = distinct !DILexicalBlock(scope: !775, file: !2, line: 79, column: 3)
!787 = !DILocation(line: 81, column: 8, scope: !788)
!788 = distinct !DILexicalBlock(scope: !775, file: !2, line: 81, column: 7)
!789 = !DILocation(line: 81, column: 7, scope: !775)
!790 = !DILocation(line: 83, column: 12, scope: !791)
!791 = distinct !DILexicalBlock(scope: !788, file: !2, line: 81, column: 13)
!792 = !DILocation(line: 83, column: 5, scope: !791)
!793 = !DILocation(line: 91, column: 19, scope: !775)
!794 = !DILocation(line: 91, column: 3, scope: !775)
!795 = !DILocation(line: 92, column: 7, scope: !775)
!796 = !DILocation(line: 83, column: 16, scope: !791)
!797 = !DILocation(line: 83, column: 26, scope: !791)
!798 = !DILocation(line: 83, column: 32, scope: !791)
!799 = !DILocation(line: 83, column: 29, scope: !791)
!800 = !DILocation(line: 83, column: 35, scope: !791)
!801 = !DILocation(line: 83, column: 45, scope: !791)
!802 = !DILocation(line: 83, column: 48, scope: !791)
!803 = !DILocation(line: 83, column: 54, scope: !791)
!804 = !DILocation(line: 84, column: 9, scope: !791)
!805 = !DILocation(line: 84, column: 18, scope: !791)
!806 = !DILocation(line: 84, column: 26, scope: !791)
!807 = distinct !{!807, !792, !808, !386, !387}
!808 = !DILocation(line: 86, column: 5, scope: !791)
!809 = !DILocation(line: 93, column: 5, scope: !810)
!810 = distinct !DILexicalBlock(scope: !775, file: !2, line: 92, column: 7)
!811 = !DILocation(line: 93, column: 12, scope: !810)
!812 = !DILocation(line: 95, column: 3, scope: !775)
!813 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !814, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !817)
!814 = !DISubroutineType(types: !815)
!815 = !{!203, !229, !816, !203}
!816 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !231, size: 64)
!817 = !{!818, !819, !820, !821, !822, !823, !824}
!818 = !DILocalVariable(name: "s", arg: 1, scope: !813, file: !2, line: 132, type: !229)
!819 = !DILocalVariable(name: "arr", arg: 2, scope: !813, file: !2, line: 132, type: !816)
!820 = !DILocalVariable(name: "n", arg: 3, scope: !813, file: !2, line: 132, type: !203)
!821 = !DILocalVariable(name: "line", scope: !813, file: !2, line: 132, type: !229)
!822 = !DILocalVariable(name: "endptr", scope: !813, file: !2, line: 132, type: !229)
!823 = !DILocalVariable(name: "i", scope: !813, file: !2, line: 132, type: !203)
!824 = !DILocalVariable(name: "v", scope: !813, file: !2, line: 132, type: !231)
!825 = distinct !DIAssignID()
!826 = !DILocation(line: 0, scope: !813)
!827 = !DILocation(line: 132, column: 1, scope: !813)
!828 = !DILocation(line: 132, column: 1, scope: !829)
!829 = distinct !DILexicalBlock(scope: !830, file: !2, line: 132, column: 1)
!830 = distinct !DILexicalBlock(scope: !813, file: !2, line: 132, column: 1)
!831 = !DILocation(line: 132, column: 1, scope: !832)
!832 = distinct !DILexicalBlock(scope: !813, file: !2, line: 132, column: 1)
!833 = !{!834, !834, i64 0}
!834 = !{!"any pointer", !376, i64 0}
!835 = distinct !DIAssignID()
!836 = !DILocation(line: 132, column: 1, scope: !837)
!837 = distinct !DILexicalBlock(scope: !832, file: !2, line: 132, column: 1)
!838 = !DILocation(line: 132, column: 1, scope: !839)
!839 = distinct !DILexicalBlock(scope: !837, file: !2, line: 132, column: 1)
!840 = distinct !{!840, !827, !827, !386, !387}
!841 = !DILocation(line: 132, column: 1, scope: !842)
!842 = distinct !DILexicalBlock(scope: !843, file: !2, line: 132, column: 1)
!843 = distinct !DILexicalBlock(scope: !813, file: !2, line: 132, column: 1)
!844 = !DISubprogram(name: "strtok", scope: !845, file: !845, line: 356, type: !846, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!845 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!846 = !DISubroutineType(types: !847)
!847 = !{!229, !848, !849}
!848 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !229)
!849 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !735)
!850 = !DISubprogram(name: "strtol", scope: !517, file: !517, line: 177, type: !851, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!851 = !DISubroutineType(types: !852)
!852 = !{!256, !849, !853, !203}
!853 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !854)
!854 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !229, size: 64)
!855 = !DISubprogram(name: "fprintf", scope: !856, file: !856, line: 357, type: !857, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!856 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!857 = !DISubroutineType(types: !858)
!858 = !{!203, !859, !849, null}
!859 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !860)
!860 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !861, size: 64)
!861 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !862, line: 7, baseType: !863)
!862 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!863 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !864, line: 49, size: 1728, elements: !865)
!864 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!865 = !{!866, !867, !868, !869, !870, !871, !872, !873, !874, !875, !876, !877, !878, !881, !883, !884, !885, !886, !887, !888, !892, !895, !897, !900, !903, !904, !905, !907, !908}
!866 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !863, file: !864, line: 51, baseType: !203, size: 32)
!867 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !863, file: !864, line: 54, baseType: !229, size: 64, offset: 64)
!868 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !863, file: !864, line: 55, baseType: !229, size: 64, offset: 128)
!869 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !863, file: !864, line: 56, baseType: !229, size: 64, offset: 192)
!870 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !863, file: !864, line: 57, baseType: !229, size: 64, offset: 256)
!871 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !863, file: !864, line: 58, baseType: !229, size: 64, offset: 320)
!872 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !863, file: !864, line: 59, baseType: !229, size: 64, offset: 384)
!873 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !863, file: !864, line: 60, baseType: !229, size: 64, offset: 448)
!874 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !863, file: !864, line: 61, baseType: !229, size: 64, offset: 512)
!875 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !863, file: !864, line: 64, baseType: !229, size: 64, offset: 576)
!876 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !863, file: !864, line: 65, baseType: !229, size: 64, offset: 640)
!877 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !863, file: !864, line: 66, baseType: !229, size: 64, offset: 704)
!878 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !863, file: !864, line: 68, baseType: !879, size: 64, offset: 768)
!879 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !880, size: 64)
!880 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !864, line: 36, flags: DIFlagFwdDecl)
!881 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !863, file: !864, line: 70, baseType: !882, size: 64, offset: 832)
!882 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !863, size: 64)
!883 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !863, file: !864, line: 72, baseType: !203, size: 32, offset: 896)
!884 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !863, file: !864, line: 73, baseType: !203, size: 32, offset: 928)
!885 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !863, file: !864, line: 74, baseType: !674, size: 64, offset: 960)
!886 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !863, file: !864, line: 77, baseType: !238, size: 16, offset: 1024)
!887 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !863, file: !864, line: 78, baseType: !248, size: 8, offset: 1040)
!888 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !863, file: !864, line: 79, baseType: !889, size: 8, offset: 1048)
!889 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !890)
!890 = !{!891}
!891 = !DISubrange(count: 1)
!892 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !863, file: !864, line: 81, baseType: !893, size: 64, offset: 1088)
!893 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !894, size: 64)
!894 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !864, line: 43, baseType: null)
!895 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !863, file: !864, line: 89, baseType: !896, size: 64, offset: 1152)
!896 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !234, line: 153, baseType: !256)
!897 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !863, file: !864, line: 91, baseType: !898, size: 64, offset: 1216)
!898 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !899, size: 64)
!899 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !864, line: 37, flags: DIFlagFwdDecl)
!900 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !863, file: !864, line: 92, baseType: !901, size: 64, offset: 1280)
!901 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !902, size: 64)
!902 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !864, line: 38, flags: DIFlagFwdDecl)
!903 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !863, file: !864, line: 93, baseType: !882, size: 64, offset: 1344)
!904 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !863, file: !864, line: 94, baseType: !230, size: 64, offset: 1408)
!905 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !863, file: !864, line: 95, baseType: !906, size: 64, offset: 1472)
!906 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !882, size: 64)
!907 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !863, file: !864, line: 96, baseType: !203, size: 32, offset: 1536)
!908 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !863, file: !864, line: 98, baseType: !909, size: 160, offset: 1568)
!909 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!910 = !DISubprogram(name: "strlen", scope: !845, file: !845, line: 407, type: !911, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!911 = !DISubroutineType(types: !912)
!912 = !{!244, !735}
!913 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !914, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !917)
!914 = !DISubroutineType(types: !915)
!915 = !{!203, !229, !916, !203}
!916 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !236, size: 64)
!917 = !{!918, !919, !920, !921, !922, !923, !924}
!918 = !DILocalVariable(name: "s", arg: 1, scope: !913, file: !2, line: 133, type: !229)
!919 = !DILocalVariable(name: "arr", arg: 2, scope: !913, file: !2, line: 133, type: !916)
!920 = !DILocalVariable(name: "n", arg: 3, scope: !913, file: !2, line: 133, type: !203)
!921 = !DILocalVariable(name: "line", scope: !913, file: !2, line: 133, type: !229)
!922 = !DILocalVariable(name: "endptr", scope: !913, file: !2, line: 133, type: !229)
!923 = !DILocalVariable(name: "i", scope: !913, file: !2, line: 133, type: !203)
!924 = !DILocalVariable(name: "v", scope: !913, file: !2, line: 133, type: !236)
!925 = distinct !DIAssignID()
!926 = !DILocation(line: 0, scope: !913)
!927 = !DILocation(line: 133, column: 1, scope: !913)
!928 = !DILocation(line: 133, column: 1, scope: !929)
!929 = distinct !DILexicalBlock(scope: !930, file: !2, line: 133, column: 1)
!930 = distinct !DILexicalBlock(scope: !913, file: !2, line: 133, column: 1)
!931 = !DILocation(line: 133, column: 1, scope: !932)
!932 = distinct !DILexicalBlock(scope: !913, file: !2, line: 133, column: 1)
!933 = distinct !DIAssignID()
!934 = !DILocation(line: 133, column: 1, scope: !935)
!935 = distinct !DILexicalBlock(scope: !932, file: !2, line: 133, column: 1)
!936 = !DILocation(line: 133, column: 1, scope: !937)
!937 = distinct !DILexicalBlock(scope: !935, file: !2, line: 133, column: 1)
!938 = !{!939, !939, i64 0}
!939 = !{!"short", !376, i64 0}
!940 = distinct !{!940, !927, !927, !386, !387}
!941 = !DILocation(line: 133, column: 1, scope: !942)
!942 = distinct !DILexicalBlock(scope: !943, file: !2, line: 133, column: 1)
!943 = distinct !DILexicalBlock(scope: !913, file: !2, line: 133, column: 1)
!944 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !945, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !948)
!945 = !DISubroutineType(types: !946)
!946 = !{!203, !229, !947, !203}
!947 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !239, size: 64)
!948 = !{!949, !950, !951, !952, !953, !954, !955}
!949 = !DILocalVariable(name: "s", arg: 1, scope: !944, file: !2, line: 134, type: !229)
!950 = !DILocalVariable(name: "arr", arg: 2, scope: !944, file: !2, line: 134, type: !947)
!951 = !DILocalVariable(name: "n", arg: 3, scope: !944, file: !2, line: 134, type: !203)
!952 = !DILocalVariable(name: "line", scope: !944, file: !2, line: 134, type: !229)
!953 = !DILocalVariable(name: "endptr", scope: !944, file: !2, line: 134, type: !229)
!954 = !DILocalVariable(name: "i", scope: !944, file: !2, line: 134, type: !203)
!955 = !DILocalVariable(name: "v", scope: !944, file: !2, line: 134, type: !239)
!956 = distinct !DIAssignID()
!957 = !DILocation(line: 0, scope: !944)
!958 = !DILocation(line: 134, column: 1, scope: !944)
!959 = !DILocation(line: 134, column: 1, scope: !960)
!960 = distinct !DILexicalBlock(scope: !961, file: !2, line: 134, column: 1)
!961 = distinct !DILexicalBlock(scope: !944, file: !2, line: 134, column: 1)
!962 = !DILocation(line: 134, column: 1, scope: !963)
!963 = distinct !DILexicalBlock(scope: !944, file: !2, line: 134, column: 1)
!964 = distinct !DIAssignID()
!965 = !DILocation(line: 134, column: 1, scope: !966)
!966 = distinct !DILexicalBlock(scope: !963, file: !2, line: 134, column: 1)
!967 = !DILocation(line: 134, column: 1, scope: !968)
!968 = distinct !DILexicalBlock(scope: !966, file: !2, line: 134, column: 1)
!969 = !{!970, !970, i64 0}
!970 = !{!"int", !376, i64 0}
!971 = distinct !{!971, !958, !958, !386, !387}
!972 = !DILocation(line: 134, column: 1, scope: !973)
!973 = distinct !DILexicalBlock(scope: !974, file: !2, line: 134, column: 1)
!974 = distinct !DILexicalBlock(scope: !944, file: !2, line: 134, column: 1)
!975 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !976, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !979)
!976 = !DISubroutineType(types: !977)
!977 = !{!203, !229, !978, !203}
!978 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !242, size: 64)
!979 = !{!980, !981, !982, !983, !984, !985, !986}
!980 = !DILocalVariable(name: "s", arg: 1, scope: !975, file: !2, line: 135, type: !229)
!981 = !DILocalVariable(name: "arr", arg: 2, scope: !975, file: !2, line: 135, type: !978)
!982 = !DILocalVariable(name: "n", arg: 3, scope: !975, file: !2, line: 135, type: !203)
!983 = !DILocalVariable(name: "line", scope: !975, file: !2, line: 135, type: !229)
!984 = !DILocalVariable(name: "endptr", scope: !975, file: !2, line: 135, type: !229)
!985 = !DILocalVariable(name: "i", scope: !975, file: !2, line: 135, type: !203)
!986 = !DILocalVariable(name: "v", scope: !975, file: !2, line: 135, type: !242)
!987 = distinct !DIAssignID()
!988 = !DILocation(line: 0, scope: !975)
!989 = !DILocation(line: 135, column: 1, scope: !975)
!990 = !DILocation(line: 135, column: 1, scope: !991)
!991 = distinct !DILexicalBlock(scope: !992, file: !2, line: 135, column: 1)
!992 = distinct !DILexicalBlock(scope: !975, file: !2, line: 135, column: 1)
!993 = !DILocation(line: 135, column: 1, scope: !994)
!994 = distinct !DILexicalBlock(scope: !975, file: !2, line: 135, column: 1)
!995 = distinct !DIAssignID()
!996 = !DILocation(line: 135, column: 1, scope: !997)
!997 = distinct !DILexicalBlock(scope: !994, file: !2, line: 135, column: 1)
!998 = !DILocation(line: 135, column: 1, scope: !999)
!999 = distinct !DILexicalBlock(scope: !997, file: !2, line: 135, column: 1)
!1000 = !{!1001, !1001, i64 0}
!1001 = !{!"long", !376, i64 0}
!1002 = distinct !{!1002, !989, !989, !386, !387}
!1003 = !DILocation(line: 135, column: 1, scope: !1004)
!1004 = distinct !DILexicalBlock(scope: !1005, file: !2, line: 135, column: 1)
!1005 = distinct !DILexicalBlock(scope: !975, file: !2, line: 135, column: 1)
!1006 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1007, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1010)
!1007 = !DISubroutineType(types: !1008)
!1008 = !{!203, !229, !1009, !203}
!1009 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !245, size: 64)
!1010 = !{!1011, !1012, !1013, !1014, !1015, !1016, !1017}
!1011 = !DILocalVariable(name: "s", arg: 1, scope: !1006, file: !2, line: 136, type: !229)
!1012 = !DILocalVariable(name: "arr", arg: 2, scope: !1006, file: !2, line: 136, type: !1009)
!1013 = !DILocalVariable(name: "n", arg: 3, scope: !1006, file: !2, line: 136, type: !203)
!1014 = !DILocalVariable(name: "line", scope: !1006, file: !2, line: 136, type: !229)
!1015 = !DILocalVariable(name: "endptr", scope: !1006, file: !2, line: 136, type: !229)
!1016 = !DILocalVariable(name: "i", scope: !1006, file: !2, line: 136, type: !203)
!1017 = !DILocalVariable(name: "v", scope: !1006, file: !2, line: 136, type: !245)
!1018 = distinct !DIAssignID()
!1019 = !DILocation(line: 0, scope: !1006)
!1020 = !DILocation(line: 136, column: 1, scope: !1006)
!1021 = !DILocation(line: 136, column: 1, scope: !1022)
!1022 = distinct !DILexicalBlock(scope: !1023, file: !2, line: 136, column: 1)
!1023 = distinct !DILexicalBlock(scope: !1006, file: !2, line: 136, column: 1)
!1024 = !DILocation(line: 136, column: 1, scope: !1025)
!1025 = distinct !DILexicalBlock(scope: !1006, file: !2, line: 136, column: 1)
!1026 = distinct !DIAssignID()
!1027 = !DILocation(line: 136, column: 1, scope: !1028)
!1028 = distinct !DILexicalBlock(scope: !1025, file: !2, line: 136, column: 1)
!1029 = !DILocation(line: 136, column: 1, scope: !1030)
!1030 = distinct !DILexicalBlock(scope: !1028, file: !2, line: 136, column: 1)
!1031 = distinct !{!1031, !1020, !1020, !386, !387}
!1032 = !DILocation(line: 136, column: 1, scope: !1033)
!1033 = distinct !DILexicalBlock(scope: !1034, file: !2, line: 136, column: 1)
!1034 = distinct !DILexicalBlock(scope: !1006, file: !2, line: 136, column: 1)
!1035 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1036, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1039)
!1036 = !DISubroutineType(types: !1037)
!1037 = !{!203, !229, !1038, !203}
!1038 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !249, size: 64)
!1039 = !{!1040, !1041, !1042, !1043, !1044, !1045, !1046}
!1040 = !DILocalVariable(name: "s", arg: 1, scope: !1035, file: !2, line: 137, type: !229)
!1041 = !DILocalVariable(name: "arr", arg: 2, scope: !1035, file: !2, line: 137, type: !1038)
!1042 = !DILocalVariable(name: "n", arg: 3, scope: !1035, file: !2, line: 137, type: !203)
!1043 = !DILocalVariable(name: "line", scope: !1035, file: !2, line: 137, type: !229)
!1044 = !DILocalVariable(name: "endptr", scope: !1035, file: !2, line: 137, type: !229)
!1045 = !DILocalVariable(name: "i", scope: !1035, file: !2, line: 137, type: !203)
!1046 = !DILocalVariable(name: "v", scope: !1035, file: !2, line: 137, type: !249)
!1047 = distinct !DIAssignID()
!1048 = !DILocation(line: 0, scope: !1035)
!1049 = !DILocation(line: 137, column: 1, scope: !1035)
!1050 = !DILocation(line: 137, column: 1, scope: !1051)
!1051 = distinct !DILexicalBlock(scope: !1052, file: !2, line: 137, column: 1)
!1052 = distinct !DILexicalBlock(scope: !1035, file: !2, line: 137, column: 1)
!1053 = !DILocation(line: 137, column: 1, scope: !1054)
!1054 = distinct !DILexicalBlock(scope: !1035, file: !2, line: 137, column: 1)
!1055 = distinct !DIAssignID()
!1056 = !DILocation(line: 137, column: 1, scope: !1057)
!1057 = distinct !DILexicalBlock(scope: !1054, file: !2, line: 137, column: 1)
!1058 = !DILocation(line: 137, column: 1, scope: !1059)
!1059 = distinct !DILexicalBlock(scope: !1057, file: !2, line: 137, column: 1)
!1060 = distinct !{!1060, !1049, !1049, !386, !387}
!1061 = !DILocation(line: 137, column: 1, scope: !1062)
!1062 = distinct !DILexicalBlock(scope: !1063, file: !2, line: 137, column: 1)
!1063 = distinct !DILexicalBlock(scope: !1035, file: !2, line: 137, column: 1)
!1064 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1065, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1068)
!1065 = !DISubroutineType(types: !1066)
!1066 = !{!203, !229, !1067, !203}
!1067 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !252, size: 64)
!1068 = !{!1069, !1070, !1071, !1072, !1073, !1074, !1075}
!1069 = !DILocalVariable(name: "s", arg: 1, scope: !1064, file: !2, line: 138, type: !229)
!1070 = !DILocalVariable(name: "arr", arg: 2, scope: !1064, file: !2, line: 138, type: !1067)
!1071 = !DILocalVariable(name: "n", arg: 3, scope: !1064, file: !2, line: 138, type: !203)
!1072 = !DILocalVariable(name: "line", scope: !1064, file: !2, line: 138, type: !229)
!1073 = !DILocalVariable(name: "endptr", scope: !1064, file: !2, line: 138, type: !229)
!1074 = !DILocalVariable(name: "i", scope: !1064, file: !2, line: 138, type: !203)
!1075 = !DILocalVariable(name: "v", scope: !1064, file: !2, line: 138, type: !252)
!1076 = distinct !DIAssignID()
!1077 = !DILocation(line: 0, scope: !1064)
!1078 = !DILocation(line: 138, column: 1, scope: !1064)
!1079 = !DILocation(line: 138, column: 1, scope: !1080)
!1080 = distinct !DILexicalBlock(scope: !1081, file: !2, line: 138, column: 1)
!1081 = distinct !DILexicalBlock(scope: !1064, file: !2, line: 138, column: 1)
!1082 = !DILocation(line: 138, column: 1, scope: !1083)
!1083 = distinct !DILexicalBlock(scope: !1064, file: !2, line: 138, column: 1)
!1084 = distinct !DIAssignID()
!1085 = !DILocation(line: 138, column: 1, scope: !1086)
!1086 = distinct !DILexicalBlock(scope: !1083, file: !2, line: 138, column: 1)
!1087 = !DILocation(line: 138, column: 1, scope: !1088)
!1088 = distinct !DILexicalBlock(scope: !1086, file: !2, line: 138, column: 1)
!1089 = distinct !{!1089, !1078, !1078, !386, !387}
!1090 = !DILocation(line: 138, column: 1, scope: !1091)
!1091 = distinct !DILexicalBlock(scope: !1092, file: !2, line: 138, column: 1)
!1092 = distinct !DILexicalBlock(scope: !1064, file: !2, line: 138, column: 1)
!1093 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1094, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1097)
!1094 = !DISubroutineType(types: !1095)
!1095 = !{!203, !229, !1096, !203}
!1096 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 64)
!1097 = !{!1098, !1099, !1100, !1101, !1102, !1103, !1104}
!1098 = !DILocalVariable(name: "s", arg: 1, scope: !1093, file: !2, line: 139, type: !229)
!1099 = !DILocalVariable(name: "arr", arg: 2, scope: !1093, file: !2, line: 139, type: !1096)
!1100 = !DILocalVariable(name: "n", arg: 3, scope: !1093, file: !2, line: 139, type: !203)
!1101 = !DILocalVariable(name: "line", scope: !1093, file: !2, line: 139, type: !229)
!1102 = !DILocalVariable(name: "endptr", scope: !1093, file: !2, line: 139, type: !229)
!1103 = !DILocalVariable(name: "i", scope: !1093, file: !2, line: 139, type: !203)
!1104 = !DILocalVariable(name: "v", scope: !1093, file: !2, line: 139, type: !254)
!1105 = distinct !DIAssignID()
!1106 = !DILocation(line: 0, scope: !1093)
!1107 = !DILocation(line: 139, column: 1, scope: !1093)
!1108 = !DILocation(line: 139, column: 1, scope: !1109)
!1109 = distinct !DILexicalBlock(scope: !1110, file: !2, line: 139, column: 1)
!1110 = distinct !DILexicalBlock(scope: !1093, file: !2, line: 139, column: 1)
!1111 = !DILocation(line: 139, column: 1, scope: !1112)
!1112 = distinct !DILexicalBlock(scope: !1093, file: !2, line: 139, column: 1)
!1113 = distinct !DIAssignID()
!1114 = !DILocation(line: 139, column: 1, scope: !1115)
!1115 = distinct !DILexicalBlock(scope: !1112, file: !2, line: 139, column: 1)
!1116 = !DILocation(line: 139, column: 1, scope: !1117)
!1117 = distinct !DILexicalBlock(scope: !1115, file: !2, line: 139, column: 1)
!1118 = distinct !{!1118, !1107, !1107, !386, !387}
!1119 = !DILocation(line: 139, column: 1, scope: !1120)
!1120 = distinct !DILexicalBlock(scope: !1121, file: !2, line: 139, column: 1)
!1121 = distinct !DILexicalBlock(scope: !1093, file: !2, line: 139, column: 1)
!1122 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1123, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1126)
!1123 = !DISubroutineType(types: !1124)
!1124 = !{!203, !229, !1125, !203}
!1125 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !257, size: 64)
!1126 = !{!1127, !1128, !1129, !1130, !1131, !1132, !1133}
!1127 = !DILocalVariable(name: "s", arg: 1, scope: !1122, file: !2, line: 141, type: !229)
!1128 = !DILocalVariable(name: "arr", arg: 2, scope: !1122, file: !2, line: 141, type: !1125)
!1129 = !DILocalVariable(name: "n", arg: 3, scope: !1122, file: !2, line: 141, type: !203)
!1130 = !DILocalVariable(name: "line", scope: !1122, file: !2, line: 141, type: !229)
!1131 = !DILocalVariable(name: "endptr", scope: !1122, file: !2, line: 141, type: !229)
!1132 = !DILocalVariable(name: "i", scope: !1122, file: !2, line: 141, type: !203)
!1133 = !DILocalVariable(name: "v", scope: !1122, file: !2, line: 141, type: !257)
!1134 = distinct !DIAssignID()
!1135 = !DILocation(line: 0, scope: !1122)
!1136 = !DILocation(line: 141, column: 1, scope: !1122)
!1137 = !DILocation(line: 141, column: 1, scope: !1138)
!1138 = distinct !DILexicalBlock(scope: !1139, file: !2, line: 141, column: 1)
!1139 = distinct !DILexicalBlock(scope: !1122, file: !2, line: 141, column: 1)
!1140 = !DILocation(line: 141, column: 1, scope: !1141)
!1141 = distinct !DILexicalBlock(scope: !1122, file: !2, line: 141, column: 1)
!1142 = distinct !DIAssignID()
!1143 = !DILocation(line: 141, column: 1, scope: !1144)
!1144 = distinct !DILexicalBlock(scope: !1141, file: !2, line: 141, column: 1)
!1145 = !DILocation(line: 141, column: 1, scope: !1146)
!1146 = distinct !DILexicalBlock(scope: !1144, file: !2, line: 141, column: 1)
!1147 = !{!1148, !1148, i64 0}
!1148 = !{!"float", !376, i64 0}
!1149 = distinct !{!1149, !1136, !1136, !386, !387}
!1150 = !DILocation(line: 141, column: 1, scope: !1151)
!1151 = distinct !DILexicalBlock(scope: !1152, file: !2, line: 141, column: 1)
!1152 = distinct !DILexicalBlock(scope: !1122, file: !2, line: 141, column: 1)
!1153 = !DISubprogram(name: "strtof", scope: !517, file: !517, line: 124, type: !1154, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1154 = !DISubroutineType(types: !1155)
!1155 = !{!257, !849, !853}
!1156 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1157, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1159)
!1157 = !DISubroutineType(types: !1158)
!1158 = !{!203, !229, !328, !203}
!1159 = !{!1160, !1161, !1162, !1163, !1164, !1165, !1166}
!1160 = !DILocalVariable(name: "s", arg: 1, scope: !1156, file: !2, line: 142, type: !229)
!1161 = !DILocalVariable(name: "arr", arg: 2, scope: !1156, file: !2, line: 142, type: !328)
!1162 = !DILocalVariable(name: "n", arg: 3, scope: !1156, file: !2, line: 142, type: !203)
!1163 = !DILocalVariable(name: "line", scope: !1156, file: !2, line: 142, type: !229)
!1164 = !DILocalVariable(name: "endptr", scope: !1156, file: !2, line: 142, type: !229)
!1165 = !DILocalVariable(name: "i", scope: !1156, file: !2, line: 142, type: !203)
!1166 = !DILocalVariable(name: "v", scope: !1156, file: !2, line: 142, type: !197)
!1167 = distinct !DIAssignID()
!1168 = !DILocation(line: 0, scope: !1156)
!1169 = !DILocation(line: 142, column: 1, scope: !1156)
!1170 = !DILocation(line: 142, column: 1, scope: !1171)
!1171 = distinct !DILexicalBlock(scope: !1172, file: !2, line: 142, column: 1)
!1172 = distinct !DILexicalBlock(scope: !1156, file: !2, line: 142, column: 1)
!1173 = !DILocation(line: 142, column: 1, scope: !1174)
!1174 = distinct !DILexicalBlock(scope: !1156, file: !2, line: 142, column: 1)
!1175 = distinct !DIAssignID()
!1176 = !DILocation(line: 142, column: 1, scope: !1177)
!1177 = distinct !DILexicalBlock(scope: !1174, file: !2, line: 142, column: 1)
!1178 = !DILocation(line: 142, column: 1, scope: !1179)
!1179 = distinct !DILexicalBlock(scope: !1177, file: !2, line: 142, column: 1)
!1180 = distinct !{!1180, !1169, !1169, !386, !387}
!1181 = !DILocation(line: 142, column: 1, scope: !1182)
!1182 = distinct !DILexicalBlock(scope: !1183, file: !2, line: 142, column: 1)
!1183 = distinct !DILexicalBlock(scope: !1156, file: !2, line: 142, column: 1)
!1184 = !DISubprogram(name: "strtod", scope: !517, file: !517, line: 118, type: !1185, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1185 = !DISubroutineType(types: !1186)
!1186 = !{!197, !849, !853}
!1187 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1188, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1190)
!1188 = !DISubroutineType(types: !1189)
!1189 = !{!203, !203, !229, !203}
!1190 = !{!1191, !1192, !1193, !1194, !1195}
!1191 = !DILocalVariable(name: "fd", arg: 1, scope: !1187, file: !2, line: 145, type: !203)
!1192 = !DILocalVariable(name: "arr", arg: 2, scope: !1187, file: !2, line: 145, type: !229)
!1193 = !DILocalVariable(name: "n", arg: 3, scope: !1187, file: !2, line: 145, type: !203)
!1194 = !DILocalVariable(name: "status", scope: !1187, file: !2, line: 146, type: !203)
!1195 = !DILocalVariable(name: "written", scope: !1187, file: !2, line: 146, type: !203)
!1196 = !DILocation(line: 0, scope: !1187)
!1197 = !DILocation(line: 147, column: 3, scope: !1198)
!1198 = distinct !DILexicalBlock(scope: !1199, file: !2, line: 147, column: 3)
!1199 = distinct !DILexicalBlock(scope: !1187, file: !2, line: 147, column: 3)
!1200 = !DILocation(line: 148, column: 8, scope: !1201)
!1201 = distinct !DILexicalBlock(scope: !1187, file: !2, line: 148, column: 7)
!1202 = !DILocation(line: 148, column: 7, scope: !1187)
!1203 = !DILocation(line: 149, column: 9, scope: !1204)
!1204 = distinct !DILexicalBlock(scope: !1201, file: !2, line: 148, column: 13)
!1205 = !DILocation(line: 150, column: 3, scope: !1204)
!1206 = !DILocation(line: 152, column: 16, scope: !1187)
!1207 = !DILocation(line: 152, column: 3, scope: !1187)
!1208 = !DILocation(line: 158, column: 3, scope: !1187)
!1209 = !DILocation(line: 155, column: 13, scope: !1210)
!1210 = distinct !DILexicalBlock(scope: !1187, file: !2, line: 152, column: 20)
!1211 = distinct !{!1211, !1207, !1212, !386, !387}
!1212 = !DILocation(line: 156, column: 3, scope: !1187)
!1213 = !DILocation(line: 153, column: 25, scope: !1210)
!1214 = !DILocation(line: 153, column: 40, scope: !1210)
!1215 = !DILocation(line: 153, column: 39, scope: !1210)
!1216 = !DILocation(line: 153, column: 14, scope: !1210)
!1217 = !DILocation(line: 154, column: 5, scope: !1218)
!1218 = distinct !DILexicalBlock(scope: !1219, file: !2, line: 154, column: 5)
!1219 = distinct !DILexicalBlock(scope: !1210, file: !2, line: 154, column: 5)
!1220 = !DILocation(line: 159, column: 14, scope: !1221)
!1221 = distinct !DILexicalBlock(scope: !1187, file: !2, line: 158, column: 6)
!1222 = !DILocation(line: 160, column: 5, scope: !1223)
!1223 = distinct !DILexicalBlock(scope: !1224, file: !2, line: 160, column: 5)
!1224 = distinct !DILexicalBlock(scope: !1221, file: !2, line: 160, column: 5)
!1225 = !DILocation(line: 161, column: 17, scope: !1187)
!1226 = !DILocation(line: 161, column: 3, scope: !1221)
!1227 = distinct !{!1227, !1208, !1228, !386, !387}
!1228 = !DILocation(line: 161, column: 20, scope: !1187)
!1229 = !DILocation(line: 163, column: 3, scope: !1187)
!1230 = !DISubprogram(name: "write", scope: !747, file: !747, line: 378, type: !1231, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1231 = !DISubroutineType(types: !1232)
!1232 = !{!696, !203, !1233, !744}
!1233 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1234, size: 64)
!1234 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1235 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1236, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1238)
!1236 = !DISubroutineType(types: !1237)
!1237 = !{!203, !203, !816, !203}
!1238 = !{!1239, !1240, !1241, !1242}
!1239 = !DILocalVariable(name: "fd", arg: 1, scope: !1235, file: !2, line: 177, type: !203)
!1240 = !DILocalVariable(name: "arr", arg: 2, scope: !1235, file: !2, line: 177, type: !816)
!1241 = !DILocalVariable(name: "n", arg: 3, scope: !1235, file: !2, line: 177, type: !203)
!1242 = !DILocalVariable(name: "i", scope: !1235, file: !2, line: 177, type: !203)
!1243 = !DILocation(line: 0, scope: !1235)
!1244 = !DILocation(line: 177, column: 1, scope: !1245)
!1245 = distinct !DILexicalBlock(scope: !1246, file: !2, line: 177, column: 1)
!1246 = distinct !DILexicalBlock(scope: !1235, file: !2, line: 177, column: 1)
!1247 = !DILocation(line: 177, column: 1, scope: !1248)
!1248 = distinct !DILexicalBlock(scope: !1249, file: !2, line: 177, column: 1)
!1249 = distinct !DILexicalBlock(scope: !1235, file: !2, line: 177, column: 1)
!1250 = !DILocation(line: 177, column: 1, scope: !1249)
!1251 = !DILocation(line: 177, column: 1, scope: !1252)
!1252 = distinct !DILexicalBlock(scope: !1248, file: !2, line: 177, column: 1)
!1253 = distinct !{!1253, !1250, !1250, !386, !387}
!1254 = !DILocation(line: 177, column: 1, scope: !1235)
!1255 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1256, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1258)
!1256 = !DISubroutineType(cc: DW_CC_nocall, types: !1257)
!1257 = !{!203, !203, !735, null}
!1258 = !{!1259, !1260, !1261, !1265, !1266, !1267, !1268}
!1259 = !DILocalVariable(name: "fd", arg: 1, scope: !1255, file: !2, line: 15, type: !203)
!1260 = !DILocalVariable(name: "format", arg: 2, scope: !1255, file: !2, line: 15, type: !735)
!1261 = !DILocalVariable(name: "args", scope: !1255, file: !2, line: 16, type: !1262)
!1262 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1263, line: 12, baseType: !1264)
!1263 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1264 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !230)
!1265 = !DILocalVariable(name: "buffered", scope: !1255, file: !2, line: 17, type: !203)
!1266 = !DILocalVariable(name: "written", scope: !1255, file: !2, line: 17, type: !203)
!1267 = !DILocalVariable(name: "status", scope: !1255, file: !2, line: 17, type: !203)
!1268 = !DILocalVariable(name: "buffer", scope: !1255, file: !2, line: 18, type: !1269)
!1269 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !1270)
!1270 = !{!1271}
!1271 = !DISubrange(count: 256)
!1272 = distinct !DIAssignID()
!1273 = !DILocation(line: 0, scope: !1255)
!1274 = distinct !DIAssignID()
!1275 = !DILocation(line: 16, column: 3, scope: !1255)
!1276 = !DILocation(line: 18, column: 3, scope: !1255)
!1277 = !DILocation(line: 19, column: 3, scope: !1255)
!1278 = !DILocation(line: 20, column: 66, scope: !1255)
!1279 = !DILocation(line: 20, column: 14, scope: !1255)
!1280 = !DILocation(line: 21, column: 3, scope: !1255)
!1281 = !DILocation(line: 22, column: 3, scope: !1282)
!1282 = distinct !DILexicalBlock(scope: !1283, file: !2, line: 22, column: 3)
!1283 = distinct !DILexicalBlock(scope: !1255, file: !2, line: 22, column: 3)
!1284 = !DILocation(line: 24, column: 16, scope: !1255)
!1285 = !DILocation(line: 24, column: 3, scope: !1255)
!1286 = !DILocation(line: 27, column: 13, scope: !1287)
!1287 = distinct !DILexicalBlock(scope: !1255, file: !2, line: 24, column: 27)
!1288 = distinct !{!1288, !1285, !1289, !386, !387}
!1289 = !DILocation(line: 28, column: 3, scope: !1255)
!1290 = !DILocation(line: 25, column: 25, scope: !1287)
!1291 = !DILocation(line: 25, column: 50, scope: !1287)
!1292 = !DILocation(line: 25, column: 42, scope: !1287)
!1293 = !DILocation(line: 25, column: 14, scope: !1287)
!1294 = !DILocation(line: 26, column: 5, scope: !1295)
!1295 = distinct !DILexicalBlock(scope: !1296, file: !2, line: 26, column: 5)
!1296 = distinct !DILexicalBlock(scope: !1287, file: !2, line: 26, column: 5)
!1297 = !DILocation(line: 29, column: 3, scope: !1298)
!1298 = distinct !DILexicalBlock(scope: !1299, file: !2, line: 29, column: 3)
!1299 = distinct !DILexicalBlock(scope: !1255, file: !2, line: 29, column: 3)
!1300 = !DILocation(line: 31, column: 1, scope: !1255)
!1301 = !DILocation(line: 30, column: 3, scope: !1255)
!1302 = !DISubprogram(name: "vsnprintf", scope: !856, file: !856, line: 389, type: !1303, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1303 = !DISubroutineType(types: !1304)
!1304 = !{!203, !848, !744, !849, !1305}
!1305 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1306, line: 12, baseType: !1264)
!1306 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1307 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1308, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1310)
!1308 = !DISubroutineType(types: !1309)
!1309 = !{!203, !203, !916, !203}
!1310 = !{!1311, !1312, !1313, !1314}
!1311 = !DILocalVariable(name: "fd", arg: 1, scope: !1307, file: !2, line: 178, type: !203)
!1312 = !DILocalVariable(name: "arr", arg: 2, scope: !1307, file: !2, line: 178, type: !916)
!1313 = !DILocalVariable(name: "n", arg: 3, scope: !1307, file: !2, line: 178, type: !203)
!1314 = !DILocalVariable(name: "i", scope: !1307, file: !2, line: 178, type: !203)
!1315 = !DILocation(line: 0, scope: !1307)
!1316 = !DILocation(line: 178, column: 1, scope: !1317)
!1317 = distinct !DILexicalBlock(scope: !1318, file: !2, line: 178, column: 1)
!1318 = distinct !DILexicalBlock(scope: !1307, file: !2, line: 178, column: 1)
!1319 = !DILocation(line: 178, column: 1, scope: !1320)
!1320 = distinct !DILexicalBlock(scope: !1321, file: !2, line: 178, column: 1)
!1321 = distinct !DILexicalBlock(scope: !1307, file: !2, line: 178, column: 1)
!1322 = !DILocation(line: 178, column: 1, scope: !1321)
!1323 = !DILocation(line: 178, column: 1, scope: !1324)
!1324 = distinct !DILexicalBlock(scope: !1320, file: !2, line: 178, column: 1)
!1325 = distinct !{!1325, !1322, !1322, !386, !387}
!1326 = !DILocation(line: 178, column: 1, scope: !1307)
!1327 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1328, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1330)
!1328 = !DISubroutineType(types: !1329)
!1329 = !{!203, !203, !947, !203}
!1330 = !{!1331, !1332, !1333, !1334}
!1331 = !DILocalVariable(name: "fd", arg: 1, scope: !1327, file: !2, line: 179, type: !203)
!1332 = !DILocalVariable(name: "arr", arg: 2, scope: !1327, file: !2, line: 179, type: !947)
!1333 = !DILocalVariable(name: "n", arg: 3, scope: !1327, file: !2, line: 179, type: !203)
!1334 = !DILocalVariable(name: "i", scope: !1327, file: !2, line: 179, type: !203)
!1335 = !DILocation(line: 0, scope: !1327)
!1336 = !DILocation(line: 179, column: 1, scope: !1337)
!1337 = distinct !DILexicalBlock(scope: !1338, file: !2, line: 179, column: 1)
!1338 = distinct !DILexicalBlock(scope: !1327, file: !2, line: 179, column: 1)
!1339 = !DILocation(line: 179, column: 1, scope: !1340)
!1340 = distinct !DILexicalBlock(scope: !1341, file: !2, line: 179, column: 1)
!1341 = distinct !DILexicalBlock(scope: !1327, file: !2, line: 179, column: 1)
!1342 = !DILocation(line: 179, column: 1, scope: !1341)
!1343 = !DILocation(line: 179, column: 1, scope: !1344)
!1344 = distinct !DILexicalBlock(scope: !1340, file: !2, line: 179, column: 1)
!1345 = distinct !{!1345, !1342, !1342, !386, !387}
!1346 = !DILocation(line: 179, column: 1, scope: !1327)
!1347 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1348, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1350)
!1348 = !DISubroutineType(types: !1349)
!1349 = !{!203, !203, !978, !203}
!1350 = !{!1351, !1352, !1353, !1354}
!1351 = !DILocalVariable(name: "fd", arg: 1, scope: !1347, file: !2, line: 180, type: !203)
!1352 = !DILocalVariable(name: "arr", arg: 2, scope: !1347, file: !2, line: 180, type: !978)
!1353 = !DILocalVariable(name: "n", arg: 3, scope: !1347, file: !2, line: 180, type: !203)
!1354 = !DILocalVariable(name: "i", scope: !1347, file: !2, line: 180, type: !203)
!1355 = !DILocation(line: 0, scope: !1347)
!1356 = !DILocation(line: 180, column: 1, scope: !1357)
!1357 = distinct !DILexicalBlock(scope: !1358, file: !2, line: 180, column: 1)
!1358 = distinct !DILexicalBlock(scope: !1347, file: !2, line: 180, column: 1)
!1359 = !DILocation(line: 180, column: 1, scope: !1360)
!1360 = distinct !DILexicalBlock(scope: !1361, file: !2, line: 180, column: 1)
!1361 = distinct !DILexicalBlock(scope: !1347, file: !2, line: 180, column: 1)
!1362 = !DILocation(line: 180, column: 1, scope: !1361)
!1363 = !DILocation(line: 180, column: 1, scope: !1364)
!1364 = distinct !DILexicalBlock(scope: !1360, file: !2, line: 180, column: 1)
!1365 = distinct !{!1365, !1362, !1362, !386, !387}
!1366 = !DILocation(line: 180, column: 1, scope: !1347)
!1367 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1368, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1370)
!1368 = !DISubroutineType(types: !1369)
!1369 = !{!203, !203, !1009, !203}
!1370 = !{!1371, !1372, !1373, !1374}
!1371 = !DILocalVariable(name: "fd", arg: 1, scope: !1367, file: !2, line: 181, type: !203)
!1372 = !DILocalVariable(name: "arr", arg: 2, scope: !1367, file: !2, line: 181, type: !1009)
!1373 = !DILocalVariable(name: "n", arg: 3, scope: !1367, file: !2, line: 181, type: !203)
!1374 = !DILocalVariable(name: "i", scope: !1367, file: !2, line: 181, type: !203)
!1375 = !DILocation(line: 0, scope: !1367)
!1376 = !DILocation(line: 181, column: 1, scope: !1377)
!1377 = distinct !DILexicalBlock(scope: !1378, file: !2, line: 181, column: 1)
!1378 = distinct !DILexicalBlock(scope: !1367, file: !2, line: 181, column: 1)
!1379 = !DILocation(line: 181, column: 1, scope: !1380)
!1380 = distinct !DILexicalBlock(scope: !1381, file: !2, line: 181, column: 1)
!1381 = distinct !DILexicalBlock(scope: !1367, file: !2, line: 181, column: 1)
!1382 = !DILocation(line: 181, column: 1, scope: !1381)
!1383 = !DILocation(line: 181, column: 1, scope: !1384)
!1384 = distinct !DILexicalBlock(scope: !1380, file: !2, line: 181, column: 1)
!1385 = distinct !{!1385, !1382, !1382, !386, !387}
!1386 = !DILocation(line: 181, column: 1, scope: !1367)
!1387 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1388, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1390)
!1388 = !DISubroutineType(types: !1389)
!1389 = !{!203, !203, !1038, !203}
!1390 = !{!1391, !1392, !1393, !1394}
!1391 = !DILocalVariable(name: "fd", arg: 1, scope: !1387, file: !2, line: 182, type: !203)
!1392 = !DILocalVariable(name: "arr", arg: 2, scope: !1387, file: !2, line: 182, type: !1038)
!1393 = !DILocalVariable(name: "n", arg: 3, scope: !1387, file: !2, line: 182, type: !203)
!1394 = !DILocalVariable(name: "i", scope: !1387, file: !2, line: 182, type: !203)
!1395 = !DILocation(line: 0, scope: !1387)
!1396 = !DILocation(line: 182, column: 1, scope: !1397)
!1397 = distinct !DILexicalBlock(scope: !1398, file: !2, line: 182, column: 1)
!1398 = distinct !DILexicalBlock(scope: !1387, file: !2, line: 182, column: 1)
!1399 = !DILocation(line: 182, column: 1, scope: !1400)
!1400 = distinct !DILexicalBlock(scope: !1401, file: !2, line: 182, column: 1)
!1401 = distinct !DILexicalBlock(scope: !1387, file: !2, line: 182, column: 1)
!1402 = !DILocation(line: 182, column: 1, scope: !1401)
!1403 = !DILocation(line: 182, column: 1, scope: !1404)
!1404 = distinct !DILexicalBlock(scope: !1400, file: !2, line: 182, column: 1)
!1405 = distinct !{!1405, !1402, !1402, !386, !387}
!1406 = !DILocation(line: 182, column: 1, scope: !1387)
!1407 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !1408, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1410)
!1408 = !DISubroutineType(types: !1409)
!1409 = !{!203, !203, !1067, !203}
!1410 = !{!1411, !1412, !1413, !1414}
!1411 = !DILocalVariable(name: "fd", arg: 1, scope: !1407, file: !2, line: 183, type: !203)
!1412 = !DILocalVariable(name: "arr", arg: 2, scope: !1407, file: !2, line: 183, type: !1067)
!1413 = !DILocalVariable(name: "n", arg: 3, scope: !1407, file: !2, line: 183, type: !203)
!1414 = !DILocalVariable(name: "i", scope: !1407, file: !2, line: 183, type: !203)
!1415 = !DILocation(line: 0, scope: !1407)
!1416 = !DILocation(line: 183, column: 1, scope: !1417)
!1417 = distinct !DILexicalBlock(scope: !1418, file: !2, line: 183, column: 1)
!1418 = distinct !DILexicalBlock(scope: !1407, file: !2, line: 183, column: 1)
!1419 = !DILocation(line: 183, column: 1, scope: !1420)
!1420 = distinct !DILexicalBlock(scope: !1421, file: !2, line: 183, column: 1)
!1421 = distinct !DILexicalBlock(scope: !1407, file: !2, line: 183, column: 1)
!1422 = !DILocation(line: 183, column: 1, scope: !1421)
!1423 = !DILocation(line: 183, column: 1, scope: !1424)
!1424 = distinct !DILexicalBlock(scope: !1420, file: !2, line: 183, column: 1)
!1425 = distinct !{!1425, !1422, !1422, !386, !387}
!1426 = !DILocation(line: 183, column: 1, scope: !1407)
!1427 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1428, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1430)
!1428 = !DISubroutineType(types: !1429)
!1429 = !{!203, !203, !1096, !203}
!1430 = !{!1431, !1432, !1433, !1434}
!1431 = !DILocalVariable(name: "fd", arg: 1, scope: !1427, file: !2, line: 184, type: !203)
!1432 = !DILocalVariable(name: "arr", arg: 2, scope: !1427, file: !2, line: 184, type: !1096)
!1433 = !DILocalVariable(name: "n", arg: 3, scope: !1427, file: !2, line: 184, type: !203)
!1434 = !DILocalVariable(name: "i", scope: !1427, file: !2, line: 184, type: !203)
!1435 = !DILocation(line: 0, scope: !1427)
!1436 = !DILocation(line: 184, column: 1, scope: !1437)
!1437 = distinct !DILexicalBlock(scope: !1438, file: !2, line: 184, column: 1)
!1438 = distinct !DILexicalBlock(scope: !1427, file: !2, line: 184, column: 1)
!1439 = !DILocation(line: 184, column: 1, scope: !1440)
!1440 = distinct !DILexicalBlock(scope: !1441, file: !2, line: 184, column: 1)
!1441 = distinct !DILexicalBlock(scope: !1427, file: !2, line: 184, column: 1)
!1442 = !DILocation(line: 184, column: 1, scope: !1441)
!1443 = !DILocation(line: 184, column: 1, scope: !1444)
!1444 = distinct !DILexicalBlock(scope: !1440, file: !2, line: 184, column: 1)
!1445 = distinct !{!1445, !1442, !1442, !386, !387}
!1446 = !DILocation(line: 184, column: 1, scope: !1427)
!1447 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1448, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !227, retainedNodes: !1450)
!1448 = !DISubroutineType(types: !1449)
!1449 = !{!203, !203, !1125, !203}
!1450 = !{!1451, !1452, !1453, !1454}
!1451 = !DILocalVariable(name: "fd", arg: 1, scope: !1447, file: !2, line: 186, type: !203)
!1452 = !DILocalVariable(name: "arr", arg: 2, scope: !1447, file: !2, line: 186, type: !1125)
!1453 = !DILocalVariable(name: "n", arg: 3, scope: !1447, file: !2, line: 186, type: !203)
!1454 = !DILocalVariable(name: "i", scope: !1447, file: !2, line: 186, type: !203)
!1455 = !DILocation(line: 0, scope: !1447)
!1456 = !DILocation(line: 186, column: 1, scope: !1457)
!1457 = distinct !DILexicalBlock(scope: !1458, file: !2, line: 186, column: 1)
!1458 = distinct !DILexicalBlock(scope: !1447, file: !2, line: 186, column: 1)
!1459 = !DILocation(line: 186, column: 1, scope: !1460)
!1460 = distinct !DILexicalBlock(scope: !1461, file: !2, line: 186, column: 1)
!1461 = distinct !DILexicalBlock(scope: !1447, file: !2, line: 186, column: 1)
!1462 = !DILocation(line: 186, column: 1, scope: !1461)
!1463 = !DILocation(line: 186, column: 1, scope: !1464)
!1464 = distinct !DILexicalBlock(scope: !1460, file: !2, line: 186, column: 1)
!1465 = distinct !{!1465, !1462, !1462, !386, !387}
!1466 = !DILocation(line: 186, column: 1, scope: !1447)
!1467 = !DILocation(line: 0, scope: !536)
!1468 = !DILocation(line: 187, column: 1, scope: !1469)
!1469 = distinct !DILexicalBlock(scope: !1470, file: !2, line: 187, column: 1)
!1470 = distinct !DILexicalBlock(scope: !536, file: !2, line: 187, column: 1)
!1471 = !DILocation(line: 187, column: 1, scope: !549)
!1472 = !DILocation(line: 187, column: 1, scope: !546)
!1473 = !DILocation(line: 187, column: 1, scope: !548)
!1474 = distinct !{!1474, !1472, !1472, !386, !387}
!1475 = !DILocation(line: 187, column: 1, scope: !536)
!1476 = !DILocation(line: 0, scope: !525)
!1477 = !DILocation(line: 190, column: 3, scope: !532)
!1478 = !DILocation(line: 191, column: 3, scope: !525)
!1479 = !DILocation(line: 192, column: 3, scope: !525)
!1480 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1481, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !292, retainedNodes: !1483)
!1481 = !DISubroutineType(types: !1482)
!1482 = !{!203, !203, !854}
!1483 = !{!1484, !1485, !1486, !1487, !1488, !1489, !1490, !1491, !1492}
!1484 = !DILocalVariable(name: "argc", arg: 1, scope: !1480, file: !170, line: 14, type: !203)
!1485 = !DILocalVariable(name: "argv", arg: 2, scope: !1480, file: !170, line: 14, type: !854)
!1486 = !DILocalVariable(name: "in_file", scope: !1480, file: !170, line: 17, type: !229)
!1487 = !DILocalVariable(name: "check_file", scope: !1480, file: !170, line: 19, type: !229)
!1488 = !DILocalVariable(name: "in_fd", scope: !1480, file: !170, line: 34, type: !203)
!1489 = !DILocalVariable(name: "data", scope: !1480, file: !170, line: 35, type: !229)
!1490 = !DILocalVariable(name: "out_fd", scope: !1480, file: !170, line: 46, type: !203)
!1491 = !DILocalVariable(name: "check_fd", scope: !1480, file: !170, line: 55, type: !203)
!1492 = !DILocalVariable(name: "ref", scope: !1480, file: !170, line: 56, type: !229)
!1493 = !DILocation(line: 0, scope: !1480)
!1494 = !DILocation(line: 21, column: 3, scope: !1495)
!1495 = distinct !DILexicalBlock(scope: !1496, file: !170, line: 21, column: 3)
!1496 = distinct !DILexicalBlock(scope: !1480, file: !170, line: 21, column: 3)
!1497 = !DILocation(line: 26, column: 11, scope: !1498)
!1498 = distinct !DILexicalBlock(scope: !1480, file: !170, line: 26, column: 7)
!1499 = !DILocation(line: 26, column: 7, scope: !1480)
!1500 = !DILocation(line: 27, column: 15, scope: !1498)
!1501 = !DILocation(line: 29, column: 11, scope: !1502)
!1502 = distinct !DILexicalBlock(scope: !1480, file: !170, line: 29, column: 7)
!1503 = !DILocation(line: 29, column: 7, scope: !1480)
!1504 = !DILocation(line: 30, column: 18, scope: !1502)
!1505 = !DILocation(line: 30, column: 5, scope: !1502)
!1506 = !DILocation(line: 36, column: 17, scope: !1480)
!1507 = !DILocation(line: 36, column: 10, scope: !1480)
!1508 = !DILocation(line: 37, column: 3, scope: !1509)
!1509 = distinct !DILexicalBlock(scope: !1510, file: !170, line: 37, column: 3)
!1510 = distinct !DILexicalBlock(scope: !1480, file: !170, line: 37, column: 3)
!1511 = !DILocation(line: 38, column: 11, scope: !1480)
!1512 = !DILocation(line: 39, column: 3, scope: !1513)
!1513 = distinct !DILexicalBlock(scope: !1514, file: !170, line: 39, column: 3)
!1514 = distinct !DILexicalBlock(scope: !1480, file: !170, line: 39, column: 3)
!1515 = !DILocation(line: 40, column: 3, scope: !1480)
!1516 = !DILocation(line: 0, scope: !405, inlinedAt: !1517)
!1517 = distinct !DILocation(line: 43, column: 3, scope: !1480)
!1518 = !DILocation(line: 10, column: 25, scope: !405, inlinedAt: !1517)
!1519 = !DILocation(line: 10, column: 35, scope: !405, inlinedAt: !1517)
!1520 = !DILocation(line: 0, scope: !325, inlinedAt: !1521)
!1521 = distinct !DILocation(line: 10, column: 3, scope: !405, inlinedAt: !1517)
!1522 = !DILocation(line: 15, column: 5, scope: !325, inlinedAt: !1521)
!1523 = !DILocation(line: 15, column: 12, scope: !346, inlinedAt: !1521)
!1524 = !DILocation(line: 16, column: 16, scope: !350, inlinedAt: !1521)
!1525 = !DILocation(line: 17, column: 19, scope: !354, inlinedAt: !1521)
!1526 = !DILocation(line: 18, column: 23, scope: !358, inlinedAt: !1521)
!1527 = !DILocation(line: 20, column: 33, scope: !356, inlinedAt: !1521)
!1528 = !DILocation(line: 21, column: 43, scope: !356, inlinedAt: !1521)
!1529 = !DILocation(line: 21, column: 30, scope: !356, inlinedAt: !1521)
!1530 = !DILocation(line: 22, column: 21, scope: !356, inlinedAt: !1521)
!1531 = !DILocation(line: 22, column: 27, scope: !370, inlinedAt: !1521)
!1532 = !DILocation(line: 23, column: 40, scope: !372, inlinedAt: !1521)
!1533 = !DILocation(line: 23, column: 38, scope: !372, inlinedAt: !1521)
!1534 = !DILocation(line: 24, column: 40, scope: !372, inlinedAt: !1521)
!1535 = !DILocation(line: 24, column: 25, scope: !372, inlinedAt: !1521)
!1536 = !DILocation(line: 24, column: 46, scope: !372, inlinedAt: !1521)
!1537 = !DILocation(line: 22, column: 55, scope: !373, inlinedAt: !1521)
!1538 = !DILocation(line: 22, column: 41, scope: !373, inlinedAt: !1521)
!1539 = distinct !{!1539, !1531, !1540, !386, !387}
!1540 = !DILocation(line: 25, column: 21, scope: !370, inlinedAt: !1521)
!1541 = !DILocation(line: 18, column: 51, scope: !357, inlinedAt: !1521)
!1542 = !DILocation(line: 18, column: 37, scope: !357, inlinedAt: !1521)
!1543 = distinct !{!1543, !1526, !1544, !386, !387}
!1544 = !DILocation(line: 26, column: 17, scope: !358, inlinedAt: !1521)
!1545 = !DILocation(line: 17, column: 46, scope: !353, inlinedAt: !1521)
!1546 = !DILocation(line: 17, column: 34, scope: !353, inlinedAt: !1521)
!1547 = distinct !{!1547, !1525, !1548, !386, !387}
!1548 = !DILocation(line: 27, column: 13, scope: !354, inlinedAt: !1521)
!1549 = !DILocation(line: 16, column: 47, scope: !349, inlinedAt: !1521)
!1550 = !DILocation(line: 16, column: 32, scope: !349, inlinedAt: !1521)
!1551 = distinct !{!1551, !1524, !1552, !386, !387}
!1552 = !DILocation(line: 28, column: 9, scope: !350, inlinedAt: !1521)
!1553 = !DILocation(line: 15, column: 43, scope: !345, inlinedAt: !1521)
!1554 = !DILocation(line: 15, column: 28, scope: !345, inlinedAt: !1521)
!1555 = distinct !{!1555, !1523, !1556, !386, !387}
!1556 = !DILocation(line: 29, column: 5, scope: !346, inlinedAt: !1521)
!1557 = !DILocation(line: 47, column: 12, scope: !1480)
!1558 = !DILocation(line: 48, column: 3, scope: !1559)
!1559 = distinct !DILexicalBlock(scope: !1560, file: !170, line: 48, column: 3)
!1560 = distinct !DILexicalBlock(scope: !1480, file: !170, line: 48, column: 3)
!1561 = !DILocation(line: 0, scope: !594, inlinedAt: !1562)
!1562 = distinct !DILocation(line: 49, column: 3, scope: !1480)
!1563 = !DILocation(line: 0, scope: !525, inlinedAt: !1564)
!1564 = distinct !DILocation(line: 65, column: 3, scope: !594, inlinedAt: !1562)
!1565 = !DILocation(line: 190, column: 3, scope: !532, inlinedAt: !1564)
!1566 = !DILocation(line: 191, column: 3, scope: !525, inlinedAt: !1564)
!1567 = !DILocation(line: 0, scope: !536, inlinedAt: !1568)
!1568 = distinct !DILocation(line: 66, column: 3, scope: !594, inlinedAt: !1562)
!1569 = !DILocation(line: 187, column: 1, scope: !546, inlinedAt: !1568)
!1570 = !DILocation(line: 187, column: 1, scope: !548, inlinedAt: !1568)
!1571 = !DILocation(line: 187, column: 1, scope: !549, inlinedAt: !1568)
!1572 = distinct !{!1572, !1569, !1569, !386, !387}
!1573 = !DILocation(line: 50, column: 3, scope: !1480)
!1574 = !DILocation(line: 57, column: 16, scope: !1480)
!1575 = !DILocation(line: 57, column: 9, scope: !1480)
!1576 = !DILocation(line: 58, column: 3, scope: !1577)
!1577 = distinct !DILexicalBlock(scope: !1578, file: !170, line: 58, column: 3)
!1578 = distinct !DILexicalBlock(scope: !1480, file: !170, line: 58, column: 3)
!1579 = !DILocation(line: 59, column: 14, scope: !1480)
!1580 = !DILocation(line: 60, column: 3, scope: !1581)
!1581 = distinct !DILexicalBlock(scope: !1582, file: !170, line: 60, column: 3)
!1582 = distinct !DILexicalBlock(scope: !1480, file: !170, line: 60, column: 3)
!1583 = !DILocation(line: 0, scope: !563, inlinedAt: !1584)
!1584 = distinct !DILocation(line: 61, column: 3, scope: !1480)
!1585 = !DILocation(line: 55, column: 7, scope: !563, inlinedAt: !1584)
!1586 = !DILocation(line: 0, scope: !465, inlinedAt: !1587)
!1587 = distinct !DILocation(line: 57, column: 7, scope: !563, inlinedAt: !1584)
!1588 = !DILocation(line: 64, column: 17, scope: !465, inlinedAt: !1587)
!1589 = !DILocation(line: 64, column: 3, scope: !465, inlinedAt: !1587)
!1590 = !DILocation(line: 66, column: 22, scope: !477, inlinedAt: !1587)
!1591 = !DILocation(line: 66, column: 26, scope: !477, inlinedAt: !1587)
!1592 = !DILocation(line: 66, column: 32, scope: !477, inlinedAt: !1587)
!1593 = !DILocation(line: 66, column: 35, scope: !477, inlinedAt: !1587)
!1594 = !DILocation(line: 66, column: 39, scope: !477, inlinedAt: !1587)
!1595 = !DILocation(line: 66, column: 9, scope: !478, inlinedAt: !1587)
!1596 = !DILocation(line: 69, column: 6, scope: !478, inlinedAt: !1587)
!1597 = !DILocation(line: 64, column: 10, scope: !465, inlinedAt: !1587)
!1598 = !DILocation(line: 64, column: 13, scope: !465, inlinedAt: !1587)
!1599 = distinct !{!1599, !1589, !1600, !386, !387}
!1600 = !DILocation(line: 70, column: 3, scope: !465, inlinedAt: !1587)
!1601 = !DILocation(line: 71, column: 6, scope: !490, inlinedAt: !1587)
!1602 = !DILocation(line: 71, column: 8, scope: !490, inlinedAt: !1587)
!1603 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !1587)
!1604 = !DILocation(line: 58, column: 37, scope: !563, inlinedAt: !1584)
!1605 = !DILocation(line: 58, column: 3, scope: !563, inlinedAt: !1584)
!1606 = !DILocation(line: 59, column: 3, scope: !563, inlinedAt: !1584)
!1607 = !DILocation(line: 0, scope: !612, inlinedAt: !1608)
!1608 = distinct !DILocation(line: 66, column: 8, scope: !1609)
!1609 = distinct !DILexicalBlock(scope: !1480, file: !170, line: 66, column: 7)
!1610 = !DILocation(line: 76, column: 3, scope: !626, inlinedAt: !1608)
!1611 = !DILocation(line: 77, column: 5, scope: !628, inlinedAt: !1608)
!1612 = !DILocation(line: 78, column: 36, scope: !632, inlinedAt: !1608)
!1613 = !DILocation(line: 78, column: 14, scope: !632, inlinedAt: !1608)
!1614 = !DILocation(line: 78, column: 43, scope: !632, inlinedAt: !1608)
!1615 = !DILocation(line: 78, column: 41, scope: !632, inlinedAt: !1608)
!1616 = !DILocation(line: 79, column: 37, scope: !632, inlinedAt: !1608)
!1617 = !DILocation(line: 79, column: 18, scope: !632, inlinedAt: !1608)
!1618 = !DILocation(line: 77, column: 28, scope: !633, inlinedAt: !1608)
!1619 = !DILocation(line: 77, column: 16, scope: !633, inlinedAt: !1608)
!1620 = distinct !{!1620, !1611, !1621, !386, !387}
!1621 = !DILocation(line: 80, column: 5, scope: !628, inlinedAt: !1608)
!1622 = !DILocation(line: 76, column: 26, scope: !630, inlinedAt: !1608)
!1623 = !DILocation(line: 76, column: 14, scope: !630, inlinedAt: !1608)
!1624 = distinct !{!1624, !1610, !1625, !386, !387}
!1625 = !DILocation(line: 81, column: 3, scope: !626, inlinedAt: !1608)
!1626 = !DILocation(line: 84, column: 10, scope: !612, inlinedAt: !1608)
!1627 = !DILocation(line: 66, column: 7, scope: !1480)
!1628 = !DILocation(line: 67, column: 13, scope: !1629)
!1629 = distinct !DILexicalBlock(scope: !1609, file: !170, line: 66, column: 32)
!1630 = !DILocation(line: 67, column: 5, scope: !1629)
!1631 = !DILocation(line: 68, column: 5, scope: !1629)
!1632 = !DILocation(line: 71, column: 3, scope: !1480)
!1633 = !DILocation(line: 72, column: 3, scope: !1480)
!1634 = !DILocation(line: 74, column: 3, scope: !1480)
!1635 = !DILocation(line: 75, column: 3, scope: !1480)
!1636 = !DILocation(line: 76, column: 1, scope: !1480)
!1637 = !DISubprogram(name: "open", scope: !1638, file: !1638, line: 209, type: !1639, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1638 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1639 = !DISubroutineType(types: !1640)
!1640 = !{!203, !735, !203, null}
