; ModuleID = 'spmv/ellpack/spmv_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.bench_args_t = type { [4940 x double], [4940 x i32], [494 x double], [494 x double] }
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
@.str.1.15 = private unnamed_addr constant [57 x i8] c"argc<4 && \22Usage: ./benchmark <input_file> <check_file>\22\00", align 1, !dbg !168
@.str.2.16 = private unnamed_addr constant [23 x i8] c"../../common/harness.c\00", align 1, !dbg !174
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1, !dbg !176
@.str.3 = private unnamed_addr constant [11 x i8] c"input.data\00", align 1, !dbg !179
@.str.4.17 = private unnamed_addr constant [11 x i8] c"check.data\00", align 1, !dbg !184
@INPUT_SIZE = dso_local local_unnamed_addr global i32 67184, align 4, !dbg !186
@.str.6.18 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !213
@.str.8.19 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !216
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !219
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !224
@.str.12.20 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !227
@.str.14.21 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !229
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !232
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @spmv(ptr nocapture noundef readonly %nzval, ptr nocapture noundef readonly %cols, ptr nocapture noundef readonly %vec, ptr nocapture noundef %out) local_unnamed_addr #0 !dbg !330 {
entry.split:
  %sum.030.reg2mem = alloca double, align 8
  %indvars.iv.reg2mem = alloca i64, align 8
  %indvars.iv33.reg2mem9 = alloca i64, align 8
    #dbg_value(ptr %nzval, !336, !DIExpression(), !349)
    #dbg_value(ptr %cols, !337, !DIExpression(), !349)
    #dbg_value(ptr %vec, !338, !DIExpression(), !349)
    #dbg_value(ptr %out, !339, !DIExpression(), !349)
    #dbg_label(!343, !350)
    #dbg_value(i32 0, !340, !DIExpression(), !349)
  store i64 0, ptr %indvars.iv33.reg2mem9, align 8
  br label %for.body, !dbg !351

for.body:                                         ; preds = %for.end.for.body_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv33.reg2mem9.0.load, !340, !DIExpression(), !349)
  %indvars.iv33.reg2mem9.0.load = load i64, ptr %indvars.iv33.reg2mem9, align 8
  %arrayidx = getelementptr inbounds double, ptr %out, i64 %indvars.iv33.reg2mem9.0.load, !dbg !352
  %0 = load double, ptr %arrayidx, align 8, !dbg !352
    #dbg_value(double %0, !344, !DIExpression(), !353)
    #dbg_label(!348, !354)
    #dbg_value(i32 0, !341, !DIExpression(), !349)
  %1 = mul nuw nsw i64 %indvars.iv33.reg2mem9.0.load, 10
  store double %0, ptr %sum.030.reg2mem, align 8
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body3, !dbg !355

for.body3:                                        ; preds = %for.body3.for.body3_crit_edge, %for.body
    #dbg_value(double %sum.030.reg2mem.0.sum.030.reload, !344, !DIExpression(), !353)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !341, !DIExpression(), !349)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %sum.030.reg2mem.0.sum.030.reload = load double, ptr %sum.030.reg2mem, align 8
  %2 = add nuw nsw i64 %indvars.iv.reg2mem.0.load, %1, !dbg !357
  %arrayidx5 = getelementptr inbounds double, ptr %nzval, i64 %2, !dbg !360
  %3 = load double, ptr %arrayidx5, align 8, !dbg !360, !tbaa !361
  %arrayidx9 = getelementptr inbounds i32, ptr %cols, i64 %2, !dbg !365
  %4 = load i32, ptr %arrayidx9, align 4, !dbg !365, !tbaa !366
  %idxprom10 = sext i32 %4 to i64, !dbg !368
  %arrayidx11 = getelementptr inbounds double, ptr %vec, i64 %idxprom10, !dbg !368
  %5 = load double, ptr %arrayidx11, align 8, !dbg !368, !tbaa !361
  %mul12 = fmul double %3, %5, !dbg !369
    #dbg_value(double %mul12, !342, !DIExpression(), !349)
  %add13 = fadd double %sum.030.reg2mem.0.sum.030.reload, %mul12, !dbg !370
    #dbg_value(double %add13, !344, !DIExpression(), !353)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !371
    #dbg_value(i64 %indvars.iv.next, !341, !DIExpression(), !349)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 10, !dbg !372
  br i1 %exitcond.not, label %for.end, label %for.body3.for.body3_crit_edge, !dbg !355, !llvm.loop !373

for.body3.for.body3_crit_edge:                    ; preds = %for.body3
  store double %add13, ptr %sum.030.reg2mem, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body3, !dbg !355

for.end:                                          ; preds = %for.body3
  store double %add13, ptr %arrayidx, align 8, !dbg !377, !tbaa !361
  %indvars.iv.next34 = add nuw nsw i64 %indvars.iv33.reg2mem9.0.load, 1, !dbg !378
    #dbg_value(i64 %indvars.iv.next34, !340, !DIExpression(), !349)
  %exitcond36.not = icmp eq i64 %indvars.iv.next34, 494, !dbg !379
  br i1 %exitcond36.not, label %for.end18, label %for.end.for.body_crit_edge, !dbg !351, !llvm.loop !380

for.end.for.body_crit_edge:                       ; preds = %for.end
  store i64 %indvars.iv.next34, ptr %indvars.iv33.reg2mem9, align 8
  br label %for.body, !dbg !351

for.end18:                                        ; preds = %for.end
  ret void, !dbg !382
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #0 !dbg !383 {
entry.split:
  %sum.030.i.reg2mem = alloca double, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %indvars.iv33.i.reg2mem9 = alloca i64, align 8
    #dbg_value(ptr %vargs, !387, !DIExpression(), !389)
    #dbg_value(ptr %vargs, !388, !DIExpression(), !389)
  %cols = getelementptr inbounds i8, ptr %vargs, i64 39520, !dbg !390
  %vec = getelementptr inbounds i8, ptr %vargs, i64 59280, !dbg !391
  %out = getelementptr inbounds i8, ptr %vargs, i64 63232, !dbg !392
    #dbg_value(ptr %vargs, !336, !DIExpression(), !393)
    #dbg_value(ptr %cols, !337, !DIExpression(), !393)
    #dbg_value(ptr %vec, !338, !DIExpression(), !393)
    #dbg_value(ptr %out, !339, !DIExpression(), !393)
    #dbg_label(!343, !395)
    #dbg_value(i32 0, !340, !DIExpression(), !393)
  store i64 0, ptr %indvars.iv33.i.reg2mem9, align 8
  br label %for.body.i, !dbg !396

for.body.i:                                       ; preds = %for.end.i.for.body.i_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv33.i.reg2mem9.0.load, !340, !DIExpression(), !393)
  %indvars.iv33.i.reg2mem9.0.load = load i64, ptr %indvars.iv33.i.reg2mem9, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %out, i64 %indvars.iv33.i.reg2mem9.0.load, !dbg !397
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !397
    #dbg_value(double %0, !344, !DIExpression(), !398)
    #dbg_label(!348, !399)
    #dbg_value(i32 0, !341, !DIExpression(), !393)
  %1 = mul nuw nsw i64 %indvars.iv33.i.reg2mem9.0.load, 10
  store double %0, ptr %sum.030.i.reg2mem, align 8
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body3.i, !dbg !400

for.body3.i:                                      ; preds = %for.body3.i.for.body3.i_crit_edge, %for.body.i
    #dbg_value(double %sum.030.i.reg2mem.0.sum.030.i.reload, !344, !DIExpression(), !398)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !341, !DIExpression(), !393)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %sum.030.i.reg2mem.0.sum.030.i.reload = load double, ptr %sum.030.i.reg2mem, align 8
  %2 = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, %1, !dbg !401
  %arrayidx5.i = getelementptr inbounds double, ptr %vargs, i64 %2, !dbg !402
  %3 = load double, ptr %arrayidx5.i, align 8, !dbg !402, !tbaa !361
  %arrayidx9.i = getelementptr inbounds i32, ptr %cols, i64 %2, !dbg !403
  %4 = load i32, ptr %arrayidx9.i, align 4, !dbg !403, !tbaa !366
  %idxprom10.i = sext i32 %4 to i64, !dbg !404
  %arrayidx11.i = getelementptr inbounds double, ptr %vec, i64 %idxprom10.i, !dbg !404
  %5 = load double, ptr %arrayidx11.i, align 8, !dbg !404, !tbaa !361
  %mul12.i = fmul double %3, %5, !dbg !405
    #dbg_value(double %mul12.i, !342, !DIExpression(), !393)
  %add13.i = fadd double %sum.030.i.reg2mem.0.sum.030.i.reload, %mul12.i, !dbg !406
    #dbg_value(double %add13.i, !344, !DIExpression(), !398)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !407
    #dbg_value(i64 %indvars.iv.next.i, !341, !DIExpression(), !393)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 10, !dbg !408
  br i1 %exitcond.not.i, label %for.end.i, label %for.body3.i.for.body3.i_crit_edge, !dbg !400, !llvm.loop !409

for.body3.i.for.body3.i_crit_edge:                ; preds = %for.body3.i
  store double %add13.i, ptr %sum.030.i.reg2mem, align 8
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body3.i, !dbg !400

for.end.i:                                        ; preds = %for.body3.i
  store double %add13.i, ptr %arrayidx.i, align 8, !dbg !411, !tbaa !361
  %indvars.iv.next34.i = add nuw nsw i64 %indvars.iv33.i.reg2mem9.0.load, 1, !dbg !412
    #dbg_value(i64 %indvars.iv.next34.i, !340, !DIExpression(), !393)
  %exitcond36.not.i = icmp eq i64 %indvars.iv.next34.i, 494, !dbg !413
  br i1 %exitcond36.not.i, label %spmv.exit, label %for.end.i.for.body.i_crit_edge, !dbg !396, !llvm.loop !414

for.end.i.for.body.i_crit_edge:                   ; preds = %for.end.i
  store i64 %indvars.iv.next34.i, ptr %indvars.iv33.i.reg2mem9, align 8
  br label %for.body.i, !dbg !396

spmv.exit:                                        ; preds = %for.end.i
  ret void, !dbg !416
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !417 {
entry.split:
  %s.addr.0.lcssa.ph.i35.reg2mem = alloca ptr, align 8
  %cmp23.not.i34.reg2mem = alloca i64, align 8
  %i.1.i29.reg2mem104 = alloca i32, align 4
  %s.addr.040.i24.reg2mem106 = alloca ptr, align 8
  %i.041.i23.reg2mem108 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i14.reg2mem = alloca ptr, align 8
  %cmp23.not.i13.reg2mem = alloca i64, align 8
  %i.1.i8.reg2mem110 = alloca i32, align 4
  %s.addr.040.i3.reg2mem112 = alloca ptr, align 8
  %i.041.i2.reg2mem114 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem116 = alloca i32, align 4
  %s.addr.040.i.reg2mem118 = alloca ptr, align 8
  %i.041.i.reg2mem120 = alloca i32, align 4
    #dbg_value(i32 %fd, !421, !DIExpression(), !426)
    #dbg_value(ptr %vdata, !422, !DIExpression(), !426)
    #dbg_value(ptr %vdata, !423, !DIExpression(), !426)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(67184) %vdata, i8 0, i64 67184, i1 false), !dbg !427
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !428
    #dbg_value(ptr %call, !424, !DIExpression(), !426)
    #dbg_value(ptr %call, !429, !DIExpression(), !436)
    #dbg_value(i32 1, !434, !DIExpression(), !436)
    #dbg_value(i32 0, !435, !DIExpression(), !436)
  store ptr %call, ptr %s.addr.040.i.reg2mem118, align 8
  store i32 0, ptr %i.041.i.reg2mem120, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem120.0.load, !435, !DIExpression(), !436)
    #dbg_value(ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, !429, !DIExpression(), !436)
  %i.041.i.reg2mem120.0.load = load i32, ptr %i.041.i.reg2mem120, align 4
  %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119 = load ptr, ptr %s.addr.040.i.reg2mem118, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, align 1, !dbg !438, !tbaa !439
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !440

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !440

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem120.0.load, ptr %i.1.i.reg2mem116, align 4
  br label %if.end21.i, !dbg !440

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, i64 1, !dbg !441
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !441, !tbaa !439
  %cmp13.i = icmp eq i8 %1, 37, !dbg !444
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !445

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem120.0.load, ptr %i.1.i.reg2mem116, align 4
  br label %if.end21.i, !dbg !445

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, i64 2, !dbg !446
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !446, !tbaa !439
  %cmp18.i = icmp eq i8 %2, 10, !dbg !447
  %inc.i = zext i1 %cmp18.i to i32, !dbg !448
  %spec.select.i = add nsw i32 %i.041.i.reg2mem120.0.load, %inc.i, !dbg !448
  store i32 %spec.select.i, ptr %i.1.i.reg2mem116, align 4
  br label %if.end21.i, !dbg !448

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem116.0.load, !435, !DIExpression(), !436)
  %i.1.i.reg2mem116.0.load = load i32, ptr %i.1.i.reg2mem116, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, i64 1, !dbg !449
    #dbg_value(ptr %incdec.ptr.i, !429, !DIExpression(), !436)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem116.0.load, 1, !dbg !450
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !451, !llvm.loop !452

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem118, align 8
  store i32 %i.1.i.reg2mem116.0.load, ptr %i.041.i.reg2mem120, align 4
  br label %land.rhs.i, !dbg !451

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !454, !tbaa !439
  %3 = icmp eq i8 %.pre.i, 0, !dbg !456
  %4 = select i1 %3, i64 0, i64 2, !dbg !457
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !451

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !457
    #dbg_value(ptr %spec.select38.i, !425, !DIExpression(), !426)
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 4940) #18, !dbg !458
    #dbg_value(ptr %call, !429, !DIExpression(), !459)
    #dbg_value(i32 2, !434, !DIExpression(), !459)
    #dbg_value(i32 0, !435, !DIExpression(), !459)
  store ptr %call, ptr %s.addr.040.i3.reg2mem112, align 8
  store i32 0, ptr %i.041.i2.reg2mem114, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem114.0.load, !435, !DIExpression(), !459)
    #dbg_value(ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, !429, !DIExpression(), !459)
  %i.041.i2.reg2mem114.0.load = load i32, ptr %i.041.i2.reg2mem114, align 4
  %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113 = load ptr, ptr %s.addr.040.i3.reg2mem112, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, align 1, !dbg !461, !tbaa !439
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !462

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !462

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem114.0.load, ptr %i.1.i8.reg2mem110, align 4
  br label %if.end21.i7, !dbg !462

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, i64 1, !dbg !463
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !463, !tbaa !439
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !464
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !465

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem114.0.load, ptr %i.1.i8.reg2mem110, align 4
  br label %if.end21.i7, !dbg !465

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, i64 2, !dbg !466
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !466, !tbaa !439
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !467
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !468
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem114.0.load, %inc.i19, !dbg !468
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem110, align 4
  br label %if.end21.i7, !dbg !468

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem110.0.load, !435, !DIExpression(), !459)
  %i.1.i8.reg2mem110.0.load = load i32, ptr %i.1.i8.reg2mem110, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, i64 1, !dbg !469
    #dbg_value(ptr %incdec.ptr.i9, !429, !DIExpression(), !459)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem110.0.load, 2, !dbg !470
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !471, !llvm.loop !472

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem112, align 8
  store i32 %i.1.i8.reg2mem110.0.load, ptr %i.041.i2.reg2mem114, align 4
  br label %land.rhs.i1, !dbg !471

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !474, !tbaa !439
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !475
  %9 = select i1 %8, i64 0, i64 2, !dbg !476
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !471

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !476
    #dbg_value(ptr %spec.select38.i15, !425, !DIExpression(), !426)
  %cols = getelementptr inbounds i8, ptr %vdata, i64 39520, !dbg !477
  %call5 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %cols, i32 noundef signext 4940) #18, !dbg !478
    #dbg_value(ptr %call, !429, !DIExpression(), !479)
    #dbg_value(i32 3, !434, !DIExpression(), !479)
    #dbg_value(i32 0, !435, !DIExpression(), !479)
  store ptr %call, ptr %s.addr.040.i24.reg2mem106, align 8
  store i32 0, ptr %i.041.i23.reg2mem108, align 4
  br label %land.rhs.i22

land.rhs.i22:                                     ; preds = %if.end21.i28.land.rhs.i22_crit_edge, %find_section_start.exit21
    #dbg_value(i32 %i.041.i23.reg2mem108.0.load, !435, !DIExpression(), !479)
    #dbg_value(ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, !429, !DIExpression(), !479)
  %i.041.i23.reg2mem108.0.load = load i32, ptr %i.041.i23.reg2mem108, align 4
  %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107 = load ptr, ptr %s.addr.040.i24.reg2mem106, align 8
  %10 = load i8, ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, align 1, !dbg !481, !tbaa !439
  switch i8 %10, label %land.rhs.i22.if.end21.i28_crit_edge [
    i8 0, label %land.rhs.i22.find_section_start.exit42_crit_edge
    i8 37, label %land.lhs.true10.i25
  ], !dbg !482

land.rhs.i22.find_section_start.exit42_crit_edge: ; preds = %land.rhs.i22
  store ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !482

land.rhs.i22.if.end21.i28_crit_edge:              ; preds = %land.rhs.i22
  store i32 %i.041.i23.reg2mem108.0.load, ptr %i.1.i29.reg2mem104, align 4
  br label %if.end21.i28, !dbg !482

land.lhs.true10.i25:                              ; preds = %land.rhs.i22
  %arrayidx11.i26 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, i64 1, !dbg !483
  %11 = load i8, ptr %arrayidx11.i26, align 1, !dbg !483, !tbaa !439
  %cmp13.i27 = icmp eq i8 %11, 37, !dbg !484
  br i1 %cmp13.i27, label %land.lhs.true15.i37, label %land.lhs.true10.i25.if.end21.i28_crit_edge, !dbg !485

land.lhs.true10.i25.if.end21.i28_crit_edge:       ; preds = %land.lhs.true10.i25
  store i32 %i.041.i23.reg2mem108.0.load, ptr %i.1.i29.reg2mem104, align 4
  br label %if.end21.i28, !dbg !485

land.lhs.true15.i37:                              ; preds = %land.lhs.true10.i25
  %arrayidx16.i38 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, i64 2, !dbg !486
  %12 = load i8, ptr %arrayidx16.i38, align 1, !dbg !486, !tbaa !439
  %cmp18.i39 = icmp eq i8 %12, 10, !dbg !487
  %inc.i40 = zext i1 %cmp18.i39 to i32, !dbg !488
  %spec.select.i41 = add nsw i32 %i.041.i23.reg2mem108.0.load, %inc.i40, !dbg !488
  store i32 %spec.select.i41, ptr %i.1.i29.reg2mem104, align 4
  br label %if.end21.i28, !dbg !488

if.end21.i28:                                     ; preds = %land.lhs.true10.i25.if.end21.i28_crit_edge, %land.rhs.i22.if.end21.i28_crit_edge, %land.lhs.true15.i37
    #dbg_value(i32 %i.1.i29.reg2mem104.0.load, !435, !DIExpression(), !479)
  %i.1.i29.reg2mem104.0.load = load i32, ptr %i.1.i29.reg2mem104, align 4
  %incdec.ptr.i30 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, i64 1, !dbg !489
    #dbg_value(ptr %incdec.ptr.i30, !429, !DIExpression(), !479)
  %cmp4.i31 = icmp slt i32 %i.1.i29.reg2mem104.0.load, 3, !dbg !490
  br i1 %cmp4.i31, label %if.end21.i28.land.rhs.i22_crit_edge, label %if.end21.while.end_crit_edge.i32, !dbg !491, !llvm.loop !492

if.end21.i28.land.rhs.i22_crit_edge:              ; preds = %if.end21.i28
  store ptr %incdec.ptr.i30, ptr %s.addr.040.i24.reg2mem106, align 8
  store i32 %i.1.i29.reg2mem104.0.load, ptr %i.041.i23.reg2mem108, align 4
  br label %land.rhs.i22, !dbg !491

if.end21.while.end_crit_edge.i32:                 ; preds = %if.end21.i28
  %.pre.i33 = load i8, ptr %incdec.ptr.i30, align 1, !dbg !494, !tbaa !439
  %13 = icmp eq i8 %.pre.i33, 0, !dbg !495
  %14 = select i1 %13, i64 0, i64 2, !dbg !496
  store ptr %incdec.ptr.i30, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 %14, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !491

find_section_start.exit42:                        ; preds = %land.rhs.i22.find_section_start.exit42_crit_edge, %if.end21.while.end_crit_edge.i32
  %cmp23.not.i34.reg2mem.0.load = load i64, ptr %cmp23.not.i34.reg2mem, align 8
  %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload = load ptr, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  %spec.select38.i36 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload, i64 %cmp23.not.i34.reg2mem.0.load, !dbg !496
    #dbg_value(ptr %spec.select38.i36, !425, !DIExpression(), !426)
  %vec = getelementptr inbounds i8, ptr %vdata, i64 59280, !dbg !497
  %call8 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i36, ptr noundef nonnull %vec, i32 noundef signext 494) #18, !dbg !498
  tail call void @free(ptr noundef %call) #18, !dbg !499
  ret void, !dbg !500
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !501 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !503 {
entry.split:
  %indvars.iv.i21.reg2mem = alloca i64, align 8
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !505, !DIExpression(), !508)
    #dbg_value(ptr %vdata, !506, !DIExpression(), !508)
    #dbg_value(ptr %vdata, !507, !DIExpression(), !508)
    #dbg_value(i32 %fd, !509, !DIExpression(), !514)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !516
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !516

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !516
  unreachable, !dbg !516

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !519
    #dbg_value(i32 %fd, !520, !DIExpression(), !528)
    #dbg_value(ptr %vdata, !525, !DIExpression(), !528)
    #dbg_value(i32 4940, !526, !DIExpression(), !528)
    #dbg_value(i32 0, !527, !DIExpression(), !528)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !530

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !527, !DIExpression(), !528)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !532
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !532, !tbaa !361
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !532
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !535
    #dbg_value(i64 %indvars.iv.next.i, !527, !DIExpression(), !528)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 4940, !dbg !535
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !530, !llvm.loop !536

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !530

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !509, !DIExpression(), !537)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !539
  %cols = getelementptr inbounds i8, ptr %vdata, i64 39520, !dbg !540
    #dbg_value(i32 %fd, !541, !DIExpression(), !549)
    #dbg_value(ptr %cols, !546, !DIExpression(), !549)
    #dbg_value(i32 4940, !547, !DIExpression(), !549)
    #dbg_value(i32 0, !548, !DIExpression(), !549)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !551

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !548, !DIExpression(), !549)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds i32, ptr %cols, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !553
  %1 = load i32, ptr %arrayidx.i11, align 4, !dbg !553, !tbaa !366
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %1), !dbg !553
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !556
    #dbg_value(i64 %indvars.iv.next.i12, !548, !DIExpression(), !549)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 4940, !dbg !556
  br i1 %exitcond.not.i13, label %for.cond.preheader.i19, label %for.body.i9.for.body.i9_crit_edge, !dbg !551, !llvm.loop !557

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !551

for.cond.preheader.i19:                           ; preds = %for.body.i9
    #dbg_value(i32 %fd, !509, !DIExpression(), !558)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !560
  %vec = getelementptr inbounds i8, ptr %vdata, i64 59280, !dbg !561
    #dbg_value(i32 %fd, !520, !DIExpression(), !562)
    #dbg_value(ptr %vec, !525, !DIExpression(), !562)
    #dbg_value(i32 494, !526, !DIExpression(), !562)
    #dbg_value(i32 0, !527, !DIExpression(), !562)
  store i64 0, ptr %indvars.iv.i21.reg2mem, align 8
  br label %for.body.i20, !dbg !564

for.body.i20:                                     ; preds = %for.body.i20.for.body.i20_crit_edge, %for.cond.preheader.i19
    #dbg_value(i64 %indvars.iv.i21.reg2mem.0.load, !527, !DIExpression(), !562)
  %indvars.iv.i21.reg2mem.0.load = load i64, ptr %indvars.iv.i21.reg2mem, align 8
  %arrayidx.i22 = getelementptr inbounds double, ptr %vec, i64 %indvars.iv.i21.reg2mem.0.load, !dbg !565
  %2 = load double, ptr %arrayidx.i22, align 8, !dbg !565, !tbaa !361
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %2), !dbg !565
  %indvars.iv.next.i23 = add nuw nsw i64 %indvars.iv.i21.reg2mem.0.load, 1, !dbg !566
    #dbg_value(i64 %indvars.iv.next.i23, !527, !DIExpression(), !562)
  %exitcond.not.i24 = icmp eq i64 %indvars.iv.next.i23, 494, !dbg !566
  br i1 %exitcond.not.i24, label %write_double_array.exit25, label %for.body.i20.for.body.i20_crit_edge, !dbg !564, !llvm.loop !567

for.body.i20.for.body.i20_crit_edge:              ; preds = %for.body.i20
  store i64 %indvars.iv.next.i23, ptr %indvars.iv.i21.reg2mem, align 8
  br label %for.body.i20, !dbg !564

write_double_array.exit25:                        ; preds = %for.body.i20
  ret void, !dbg !568
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !569 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !571, !DIExpression(), !576)
    #dbg_value(ptr %vdata, !572, !DIExpression(), !576)
    #dbg_value(ptr %vdata, !573, !DIExpression(), !576)
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !577
    #dbg_value(ptr %call, !574, !DIExpression(), !576)
    #dbg_value(ptr %call, !429, !DIExpression(), !578)
    #dbg_value(i32 1, !434, !DIExpression(), !578)
    #dbg_value(i32 0, !435, !DIExpression(), !578)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !435, !DIExpression(), !578)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !429, !DIExpression(), !578)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !580, !tbaa !439
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !581

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !581

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !581

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !582
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !582, !tbaa !439
  %cmp13.i = icmp eq i8 %1, 37, !dbg !583
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !584

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !584

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !585
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !585, !tbaa !439
  %cmp18.i = icmp eq i8 %2, 10, !dbg !586
  %inc.i = zext i1 %cmp18.i to i32, !dbg !587
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !587
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !587

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !435, !DIExpression(), !578)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !588
    #dbg_value(ptr %incdec.ptr.i, !429, !DIExpression(), !578)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !589
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !590, !llvm.loop !591

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !590

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !593, !tbaa !439
  %3 = icmp eq i8 %.pre.i, 0, !dbg !594
  %4 = select i1 %3, i64 0, i64 2, !dbg !595
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !590

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !595
    #dbg_value(ptr %spec.select38.i, !575, !DIExpression(), !576)
  %out = getelementptr inbounds i8, ptr %vdata, i64 63232, !dbg !596
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %out, i32 noundef signext 494) #18, !dbg !597
  tail call void @free(ptr noundef %call) #18, !dbg !598
  ret void, !dbg !599
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !600 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !602, !DIExpression(), !605)
    #dbg_value(ptr %vdata, !603, !DIExpression(), !605)
    #dbg_value(ptr %vdata, !604, !DIExpression(), !605)
    #dbg_value(i32 %fd, !509, !DIExpression(), !606)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !608
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !608

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !608
  unreachable, !dbg !608

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !609
  %out = getelementptr inbounds i8, ptr %vdata, i64 63232, !dbg !610
    #dbg_value(i32 %fd, !520, !DIExpression(), !611)
    #dbg_value(ptr %out, !525, !DIExpression(), !611)
    #dbg_value(i32 494, !526, !DIExpression(), !611)
    #dbg_value(i32 0, !527, !DIExpression(), !611)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !613

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !527, !DIExpression(), !611)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %out, i64 %indvars.iv.i.reg2mem.0.load, !dbg !614
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !614, !tbaa !361
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !614
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !615
    #dbg_value(i64 %indvars.iv.next.i, !527, !DIExpression(), !611)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 494, !dbg !615
  br i1 %exitcond.not.i, label %write_double_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !613, !llvm.loop !616

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !613

write_double_array.exit:                          ; preds = %for.body.i
  ret void, !dbg !617
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #4 !dbg !618 {
entry.split:
  %has_errors.012.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(ptr %vdata, !622, !DIExpression(), !629)
    #dbg_value(ptr %vref, !623, !DIExpression(), !629)
    #dbg_value(ptr %vdata, !624, !DIExpression(), !629)
    #dbg_value(ptr %vref, !625, !DIExpression(), !629)
    #dbg_value(i32 0, !626, !DIExpression(), !629)
    #dbg_value(i32 0, !627, !DIExpression(), !629)
  store i32 0, ptr %has_errors.012.reg2mem, align 4
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !630

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i32 %has_errors.012.reg2mem.0.load, !626, !DIExpression(), !629)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !627, !DIExpression(), !629)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %has_errors.012.reg2mem.0.load = load i32, ptr %has_errors.012.reg2mem, align 4
  %arrayidx = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 3, i64 %indvars.iv.reg2mem.0.load, !dbg !632
  %0 = load double, ptr %arrayidx, align 8, !dbg !632, !tbaa !361
  %arrayidx3 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 3, i64 %indvars.iv.reg2mem.0.load, !dbg !635
  %1 = load double, ptr %arrayidx3, align 8, !dbg !635, !tbaa !361
  %sub = fsub double %0, %1, !dbg !636
    #dbg_value(double %sub, !628, !DIExpression(), !629)
  %2 = tail call double @llvm.fabs.f64(double %sub), !dbg !637
  %3 = fcmp ogt double %2, 0x3EB0C6F7A0B5ED8D, !dbg !637
  %lor.ext = zext i1 %3 to i32, !dbg !637
  %or = or i32 %has_errors.012.reg2mem.0.load, %lor.ext, !dbg !638
    #dbg_value(i32 %or, !626, !DIExpression(), !629)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !639
    #dbg_value(i64 %indvars.iv.next, !627, !DIExpression(), !629)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 494, !dbg !640
  br i1 %exitcond.not, label %for.end, label %for.body.for.body_crit_edge, !dbg !630, !llvm.loop !641

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i32 %or, ptr %has_errors.012.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !630

for.end:                                          ; preds = %for.body
  %tobool.not = icmp eq i32 %or, 0, !dbg !643
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !643
  ret i32 %lnot.ext, !dbg !644
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !645 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !695
    #dbg_assign(i1 undef, !651, !DIExpression(), !695, ptr %s, !DIExpression(), !696)
    #dbg_value(i32 %fd, !649, !DIExpression(), !696)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #18, !dbg !697
  %cmp = icmp sgt i32 %fd, 1, !dbg !698
  br i1 %cmp, label %if.end, label %if.else, !dbg !698

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !698
  unreachable, !dbg !698

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #18, !dbg !701
  %cmp1 = icmp eq i32 %call, 0, !dbg !701
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !701

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !701
  unreachable, !dbg !701

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !704
  %0 = load i64, ptr %st_size, align 8, !dbg !704
    #dbg_value(i64 %0, !688, !DIExpression(), !696)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !705
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !705

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !705
  unreachable, !dbg !705

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !708
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #20, !dbg !709
    #dbg_value(ptr %call11, !650, !DIExpression(), !696)
    #dbg_value(i64 0, !691, !DIExpression(), !696)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !710

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !711
    #dbg_value(i64 %add19, !691, !DIExpression(), !696)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !713
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !710, !llvm.loop !714

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !710

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !691, !DIExpression(), !696)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !716
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !717
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #18, !dbg !718
    #dbg_value(i64 %call13, !694, !DIExpression(), !696)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !719
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !691, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !696)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !719

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !719
  unreachable, !dbg !719

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !722
  store i8 0, ptr %arrayidx20, align 1, !dbg !723, !tbaa !439
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #18, !dbg !724
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #18, !dbg !725
  ret ptr %call11, !dbg !726
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: noreturn nounwind
declare !dbg !727 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare !dbg !732 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !737 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #8

; Function Attrs: nofree
declare !dbg !742 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #9

declare !dbg !746 signext i32 @close(i32 noundef signext) local_unnamed_addr #10

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #1 !dbg !430 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !429, !DIExpression(), !747)
    #dbg_value(i32 %n, !434, !DIExpression(), !747)
    #dbg_value(i32 0, !435, !DIExpression(), !747)
  %cmp = icmp sgt i32 %n, -1, !dbg !748
  br i1 %cmp, label %if.end, label %if.else, !dbg !748

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #19, !dbg !748
  unreachable, !dbg !748

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !751
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !753

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !753

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !753

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !435, !DIExpression(), !747)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !429, !DIExpression(), !747)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !754, !tbaa !439
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !755

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !755

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !755

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !756
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !756, !tbaa !439
  %cmp13 = icmp eq i8 %1, 37, !dbg !757
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !758

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !758

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !759
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !759, !tbaa !439
  %cmp18 = icmp eq i8 %2, 10, !dbg !760
  %inc = zext i1 %cmp18 to i32, !dbg !761
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !761
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !761

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !435, !DIExpression(), !747)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !762
    #dbg_value(ptr %incdec.ptr, !429, !DIExpression(), !747)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !763
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !764, !llvm.loop !765

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !764

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !767, !tbaa !439
  %3 = icmp eq i8 %.pre, 0, !dbg !768
  %4 = select i1 %3, i64 0, i64 2, !dbg !769
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !764

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !769
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !769

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !770
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !771 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !775, !DIExpression(), !779)
    #dbg_value(ptr %arr, !776, !DIExpression(), !779)
    #dbg_value(i32 %n, !777, !DIExpression(), !779)
  %cmp.not = icmp eq ptr %s, null, !dbg !780
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !780

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #19, !dbg !780
  unreachable, !dbg !780

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !783
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !785

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !786
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !788
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !788

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !778, !DIExpression(), !779)
  %conv404 = zext nneg i32 %n to i64, !dbg !789
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !790
  br label %if.end46, !dbg !791

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !778, !DIExpression(), !779)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !792
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !793

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !793

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !794
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !795
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !795
  %cmp9.not = icmp eq i8 %0, 0, !dbg !796
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !797

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !797

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !798
  %1 = load i8, ptr %gep, align 1, !dbg !798
  %cmp16.not = icmp eq i8 %1, 0, !dbg !799
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !800

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !800

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !801
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !802
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !802
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !802, !llvm.loop !803

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !802

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !789

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !789

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !789

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !789
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !778, !DIExpression(), !779)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !790
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !805
  store i8 0, ptr %arrayidx45, align 1, !dbg !807, !tbaa !439
  br label %if.end46, !dbg !805

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !808
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #11

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !809 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !821
    #dbg_assign(i1 undef, !818, !DIExpression(), !821, ptr %endptr, !DIExpression(), !822)
    #dbg_value(ptr %s, !814, !DIExpression(), !822)
    #dbg_value(ptr %arr, !815, !DIExpression(), !822)
    #dbg_value(i32 %n, !816, !DIExpression(), !822)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !823
    #dbg_value(i32 0, !819, !DIExpression(), !822)
  %cmp.not = icmp eq ptr %s, null, !dbg !824
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !824

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #19, !dbg !824
  unreachable, !dbg !824

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !823
    #dbg_value(ptr %call, !817, !DIExpression(), !822)
    #dbg_value(i32 0, !819, !DIExpression(), !822)
  %cmp130 = icmp ne ptr %call, null, !dbg !823
  %cmp231 = icmp sgt i32 %n, 0, !dbg !823
  %0 = and i1 %cmp231, %cmp130, !dbg !823
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !823

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !823

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !823
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !823

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !817, !DIExpression(), !822)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !819, !DIExpression(), !822)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !827, !tbaa !829, !DIAssignID !831
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !818, !DIExpression(), !831, ptr %endptr, !DIExpression(), !822)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !827
  %conv = trunc i64 %call3 to i8, !dbg !827
    #dbg_value(i8 %conv, !820, !DIExpression(), !822)
  %2 = load ptr, ptr %endptr, align 8, !dbg !832, !tbaa !829
  %3 = load i8, ptr %2, align 1, !dbg !832, !tbaa !439
  %cmp5.not = icmp eq i8 %3, 0, !dbg !832
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !827

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !827

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !834, !tbaa !829
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !834
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !834
  br label %if.end9, !dbg !834

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !827
  store i8 %conv, ptr %arrayidx, align 1, !dbg !827, !tbaa !439
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !827
    #dbg_value(i64 %indvars.iv.next, !819, !DIExpression(), !822)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !827
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !827
  store i8 10, ptr %arrayidx11, align 1, !dbg !827, !tbaa !439
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !827
    #dbg_value(ptr %call12, !817, !DIExpression(), !822)
  %cmp1 = icmp ne ptr %call12, null, !dbg !823
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !823
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !823
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !823, !llvm.loop !836

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !823

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !823

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !823

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !823

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !837
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !837
  store i8 10, ptr %arrayidx17, align 1, !dbg !837, !tbaa !439
  br label %if.end18, !dbg !837

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !823
  ret i32 0, !dbg !823
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !840 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #12

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !846 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #12

; Function Attrs: nofree nounwind
declare !dbg !851 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !906 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !909 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !921
    #dbg_assign(i1 undef, !918, !DIExpression(), !921, ptr %endptr, !DIExpression(), !922)
    #dbg_value(ptr %s, !914, !DIExpression(), !922)
    #dbg_value(ptr %arr, !915, !DIExpression(), !922)
    #dbg_value(i32 %n, !916, !DIExpression(), !922)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !923
    #dbg_value(i32 0, !919, !DIExpression(), !922)
  %cmp.not = icmp eq ptr %s, null, !dbg !924
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !924

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #19, !dbg !924
  unreachable, !dbg !924

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !923
    #dbg_value(ptr %call, !917, !DIExpression(), !922)
    #dbg_value(i32 0, !919, !DIExpression(), !922)
  %cmp130 = icmp ne ptr %call, null, !dbg !923
  %cmp231 = icmp sgt i32 %n, 0, !dbg !923
  %0 = and i1 %cmp231, %cmp130, !dbg !923
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !923

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !923

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !923
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !923

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !917, !DIExpression(), !922)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !919, !DIExpression(), !922)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !927, !tbaa !829, !DIAssignID !929
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !918, !DIExpression(), !929, ptr %endptr, !DIExpression(), !922)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !927
  %conv = trunc i64 %call3 to i16, !dbg !927
    #dbg_value(i16 %conv, !920, !DIExpression(), !922)
  %2 = load ptr, ptr %endptr, align 8, !dbg !930, !tbaa !829
  %3 = load i8, ptr %2, align 1, !dbg !930, !tbaa !439
  %cmp5.not = icmp eq i8 %3, 0, !dbg !930
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !927

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !927

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !932, !tbaa !829
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !932
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !932
  br label %if.end9, !dbg !932

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !927
  store i16 %conv, ptr %arrayidx, align 2, !dbg !927, !tbaa !934
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !927
    #dbg_value(i64 %indvars.iv.next, !919, !DIExpression(), !922)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !927
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !927
  store i8 10, ptr %arrayidx11, align 1, !dbg !927, !tbaa !439
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !927
    #dbg_value(ptr %call12, !917, !DIExpression(), !922)
  %cmp1 = icmp ne ptr %call12, null, !dbg !923
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !923
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !923
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !923, !llvm.loop !936

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !923

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !923

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !923

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !923

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !937
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !937
  store i8 10, ptr %arrayidx17, align 1, !dbg !937, !tbaa !439
  br label %if.end18, !dbg !937

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !923
  ret i32 0, !dbg !923
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !940 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !952
    #dbg_assign(i1 undef, !949, !DIExpression(), !952, ptr %endptr, !DIExpression(), !953)
    #dbg_value(ptr %s, !945, !DIExpression(), !953)
    #dbg_value(ptr %arr, !946, !DIExpression(), !953)
    #dbg_value(i32 %n, !947, !DIExpression(), !953)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !954
    #dbg_value(i32 0, !950, !DIExpression(), !953)
  %cmp.not = icmp eq ptr %s, null, !dbg !955
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !955

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #19, !dbg !955
  unreachable, !dbg !955

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !954
    #dbg_value(ptr %call, !948, !DIExpression(), !953)
    #dbg_value(i32 0, !950, !DIExpression(), !953)
  %cmp130 = icmp ne ptr %call, null, !dbg !954
  %cmp231 = icmp sgt i32 %n, 0, !dbg !954
  %0 = and i1 %cmp231, %cmp130, !dbg !954
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !954

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !954

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !954
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !954

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !948, !DIExpression(), !953)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !950, !DIExpression(), !953)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !958, !tbaa !829, !DIAssignID !960
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !949, !DIExpression(), !960, ptr %endptr, !DIExpression(), !953)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !958
  %conv = trunc i64 %call3 to i32, !dbg !958
    #dbg_value(i32 %conv, !951, !DIExpression(), !953)
  %2 = load ptr, ptr %endptr, align 8, !dbg !961, !tbaa !829
  %3 = load i8, ptr %2, align 1, !dbg !961, !tbaa !439
  %cmp5.not = icmp eq i8 %3, 0, !dbg !961
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !958

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !958

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !963, !tbaa !829
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !963
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !963
  br label %if.end9, !dbg !963

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !958
  store i32 %conv, ptr %arrayidx, align 4, !dbg !958, !tbaa !366
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !958
    #dbg_value(i64 %indvars.iv.next, !950, !DIExpression(), !953)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !958
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !958
  store i8 10, ptr %arrayidx11, align 1, !dbg !958, !tbaa !439
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !958
    #dbg_value(ptr %call12, !948, !DIExpression(), !953)
  %cmp1 = icmp ne ptr %call12, null, !dbg !954
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !954
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !954
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !954, !llvm.loop !965

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !954

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !954

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !954

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !954

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !966
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !966
  store i8 10, ptr %arrayidx17, align 1, !dbg !966, !tbaa !439
  br label %if.end18, !dbg !966

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !954
  ret i32 0, !dbg !954
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !969 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !981
    #dbg_assign(i1 undef, !978, !DIExpression(), !981, ptr %endptr, !DIExpression(), !982)
    #dbg_value(ptr %s, !974, !DIExpression(), !982)
    #dbg_value(ptr %arr, !975, !DIExpression(), !982)
    #dbg_value(i32 %n, !976, !DIExpression(), !982)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !983
    #dbg_value(i32 0, !979, !DIExpression(), !982)
  %cmp.not = icmp eq ptr %s, null, !dbg !984
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !984

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #19, !dbg !984
  unreachable, !dbg !984

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !983
    #dbg_value(ptr %call, !977, !DIExpression(), !982)
    #dbg_value(i32 0, !979, !DIExpression(), !982)
  %cmp129 = icmp ne ptr %call, null, !dbg !983
  %cmp230 = icmp sgt i32 %n, 0, !dbg !983
  %0 = and i1 %cmp230, %cmp129, !dbg !983
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !983

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !983

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !983
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !983

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !977, !DIExpression(), !982)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !979, !DIExpression(), !982)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !987, !tbaa !829, !DIAssignID !989
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !978, !DIExpression(), !989, ptr %endptr, !DIExpression(), !982)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !987
    #dbg_value(i64 %call3, !980, !DIExpression(), !982)
  %2 = load ptr, ptr %endptr, align 8, !dbg !990, !tbaa !829
  %3 = load i8, ptr %2, align 1, !dbg !990, !tbaa !439
  %cmp4.not = icmp eq i8 %3, 0, !dbg !990
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !987

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !987

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !992, !tbaa !829
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !992
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !992
  br label %if.end8, !dbg !992

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !987
  store i64 %call3, ptr %arrayidx, align 8, !dbg !987, !tbaa !994
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !987
    #dbg_value(i64 %indvars.iv.next, !979, !DIExpression(), !982)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !987
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !987
  store i8 10, ptr %arrayidx10, align 1, !dbg !987, !tbaa !439
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !987
    #dbg_value(ptr %call11, !977, !DIExpression(), !982)
  %cmp1 = icmp ne ptr %call11, null, !dbg !983
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !983
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !983
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !983, !llvm.loop !996

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !983

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !983

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !983

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !983

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !997
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !997
  store i8 10, ptr %arrayidx16, align 1, !dbg !997, !tbaa !439
  br label %if.end17, !dbg !997

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !983
  ret i32 0, !dbg !983
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1000 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1012
    #dbg_assign(i1 undef, !1009, !DIExpression(), !1012, ptr %endptr, !DIExpression(), !1013)
    #dbg_value(ptr %s, !1005, !DIExpression(), !1013)
    #dbg_value(ptr %arr, !1006, !DIExpression(), !1013)
    #dbg_value(i32 %n, !1007, !DIExpression(), !1013)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1014
    #dbg_value(i32 0, !1010, !DIExpression(), !1013)
  %cmp.not = icmp eq ptr %s, null, !dbg !1015
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1015

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #19, !dbg !1015
  unreachable, !dbg !1015

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1014
    #dbg_value(ptr %call, !1008, !DIExpression(), !1013)
    #dbg_value(i32 0, !1010, !DIExpression(), !1013)
  %cmp130 = icmp ne ptr %call, null, !dbg !1014
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1014
  %0 = and i1 %cmp231, %cmp130, !dbg !1014
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1014

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1014

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1014
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1014

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1008, !DIExpression(), !1013)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1010, !DIExpression(), !1013)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1018, !tbaa !829, !DIAssignID !1020
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1009, !DIExpression(), !1020, ptr %endptr, !DIExpression(), !1013)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1018
  %conv = trunc i64 %call3 to i8, !dbg !1018
    #dbg_value(i8 %conv, !1011, !DIExpression(), !1013)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1021, !tbaa !829
  %3 = load i8, ptr %2, align 1, !dbg !1021, !tbaa !439
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1021
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1018

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1018

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1023, !tbaa !829
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1023
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1023
  br label %if.end9, !dbg !1023

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1018
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1018, !tbaa !439
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1018
    #dbg_value(i64 %indvars.iv.next, !1010, !DIExpression(), !1013)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1018
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1018
  store i8 10, ptr %arrayidx11, align 1, !dbg !1018, !tbaa !439
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1018
    #dbg_value(ptr %call12, !1008, !DIExpression(), !1013)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1014
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1014
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1014
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1014, !llvm.loop !1025

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1014

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1014

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1014

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1014

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1026
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1026
  store i8 10, ptr %arrayidx17, align 1, !dbg !1026, !tbaa !439
  br label %if.end18, !dbg !1026

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1014
  ret i32 0, !dbg !1014
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1029 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1041
    #dbg_assign(i1 undef, !1038, !DIExpression(), !1041, ptr %endptr, !DIExpression(), !1042)
    #dbg_value(ptr %s, !1034, !DIExpression(), !1042)
    #dbg_value(ptr %arr, !1035, !DIExpression(), !1042)
    #dbg_value(i32 %n, !1036, !DIExpression(), !1042)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1043
    #dbg_value(i32 0, !1039, !DIExpression(), !1042)
  %cmp.not = icmp eq ptr %s, null, !dbg !1044
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1044

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #19, !dbg !1044
  unreachable, !dbg !1044

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1043
    #dbg_value(ptr %call, !1037, !DIExpression(), !1042)
    #dbg_value(i32 0, !1039, !DIExpression(), !1042)
  %cmp130 = icmp ne ptr %call, null, !dbg !1043
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1043
  %0 = and i1 %cmp231, %cmp130, !dbg !1043
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1043

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1043

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1043
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1043

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1037, !DIExpression(), !1042)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1039, !DIExpression(), !1042)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1047, !tbaa !829, !DIAssignID !1049
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1038, !DIExpression(), !1049, ptr %endptr, !DIExpression(), !1042)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1047
  %conv = trunc i64 %call3 to i16, !dbg !1047
    #dbg_value(i16 %conv, !1040, !DIExpression(), !1042)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1050, !tbaa !829
  %3 = load i8, ptr %2, align 1, !dbg !1050, !tbaa !439
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1050
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1047

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1047

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1052, !tbaa !829
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1052
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1052
  br label %if.end9, !dbg !1052

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1047
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1047, !tbaa !934
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1047
    #dbg_value(i64 %indvars.iv.next, !1039, !DIExpression(), !1042)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1047
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1047
  store i8 10, ptr %arrayidx11, align 1, !dbg !1047, !tbaa !439
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1047
    #dbg_value(ptr %call12, !1037, !DIExpression(), !1042)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1043
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1043
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1043
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1043, !llvm.loop !1054

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1043

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1043

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1043

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1043

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1055
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1055
  store i8 10, ptr %arrayidx17, align 1, !dbg !1055, !tbaa !439
  br label %if.end18, !dbg !1055

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1043
  ret i32 0, !dbg !1043
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1058 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1069
    #dbg_assign(i1 undef, !1066, !DIExpression(), !1069, ptr %endptr, !DIExpression(), !1070)
    #dbg_value(ptr %s, !1062, !DIExpression(), !1070)
    #dbg_value(ptr %arr, !1063, !DIExpression(), !1070)
    #dbg_value(i32 %n, !1064, !DIExpression(), !1070)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1071
    #dbg_value(i32 0, !1067, !DIExpression(), !1070)
  %cmp.not = icmp eq ptr %s, null, !dbg !1072
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1072

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #19, !dbg !1072
  unreachable, !dbg !1072

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1071
    #dbg_value(ptr %call, !1065, !DIExpression(), !1070)
    #dbg_value(i32 0, !1067, !DIExpression(), !1070)
  %cmp130 = icmp ne ptr %call, null, !dbg !1071
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1071
  %0 = and i1 %cmp231, %cmp130, !dbg !1071
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1071

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1071

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1071
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1071

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1065, !DIExpression(), !1070)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1067, !DIExpression(), !1070)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1075, !tbaa !829, !DIAssignID !1077
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1066, !DIExpression(), !1077, ptr %endptr, !DIExpression(), !1070)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1075
  %conv = trunc i64 %call3 to i32, !dbg !1075
    #dbg_value(i32 %conv, !1068, !DIExpression(), !1070)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1078, !tbaa !829
  %3 = load i8, ptr %2, align 1, !dbg !1078, !tbaa !439
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1078
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1075

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1075

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1080, !tbaa !829
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1080
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1080
  br label %if.end9, !dbg !1080

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1075
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1075, !tbaa !366
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1075
    #dbg_value(i64 %indvars.iv.next, !1067, !DIExpression(), !1070)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1075
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1075
  store i8 10, ptr %arrayidx11, align 1, !dbg !1075, !tbaa !439
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1075
    #dbg_value(ptr %call12, !1065, !DIExpression(), !1070)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1071
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1071
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1071
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1071, !llvm.loop !1082

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1071

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1071

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1071

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1071

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1083
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1083
  store i8 10, ptr %arrayidx17, align 1, !dbg !1083, !tbaa !439
  br label %if.end18, !dbg !1083

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1071
  ret i32 0, !dbg !1071
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1086 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1098
    #dbg_assign(i1 undef, !1095, !DIExpression(), !1098, ptr %endptr, !DIExpression(), !1099)
    #dbg_value(ptr %s, !1091, !DIExpression(), !1099)
    #dbg_value(ptr %arr, !1092, !DIExpression(), !1099)
    #dbg_value(i32 %n, !1093, !DIExpression(), !1099)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1100
    #dbg_value(i32 0, !1096, !DIExpression(), !1099)
  %cmp.not = icmp eq ptr %s, null, !dbg !1101
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1101

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #19, !dbg !1101
  unreachable, !dbg !1101

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1100
    #dbg_value(ptr %call, !1094, !DIExpression(), !1099)
    #dbg_value(i32 0, !1096, !DIExpression(), !1099)
  %cmp129 = icmp ne ptr %call, null, !dbg !1100
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1100
  %0 = and i1 %cmp230, %cmp129, !dbg !1100
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1100

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1100

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1100
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1100

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1094, !DIExpression(), !1099)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1096, !DIExpression(), !1099)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1104, !tbaa !829, !DIAssignID !1106
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1095, !DIExpression(), !1106, ptr %endptr, !DIExpression(), !1099)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1104
    #dbg_value(i64 %call3, !1097, !DIExpression(), !1099)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1107, !tbaa !829
  %3 = load i8, ptr %2, align 1, !dbg !1107, !tbaa !439
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1107
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1104

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1104

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1109, !tbaa !829
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1109
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1109
  br label %if.end8, !dbg !1109

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1104
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1104, !tbaa !994
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1104
    #dbg_value(i64 %indvars.iv.next, !1096, !DIExpression(), !1099)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1104
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1104
  store i8 10, ptr %arrayidx10, align 1, !dbg !1104, !tbaa !439
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1104
    #dbg_value(ptr %call11, !1094, !DIExpression(), !1099)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1100
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1100
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1100
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1100, !llvm.loop !1111

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1100

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1100

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1100

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1100

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1112
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1112
  store i8 10, ptr %arrayidx16, align 1, !dbg !1112, !tbaa !439
  br label %if.end17, !dbg !1112

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1100
  ret i32 0, !dbg !1100
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1115 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1127
    #dbg_assign(i1 undef, !1124, !DIExpression(), !1127, ptr %endptr, !DIExpression(), !1128)
    #dbg_value(ptr %s, !1120, !DIExpression(), !1128)
    #dbg_value(ptr %arr, !1121, !DIExpression(), !1128)
    #dbg_value(i32 %n, !1122, !DIExpression(), !1128)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1129
    #dbg_value(i32 0, !1125, !DIExpression(), !1128)
  %cmp.not = icmp eq ptr %s, null, !dbg !1130
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1130

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #19, !dbg !1130
  unreachable, !dbg !1130

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1129
    #dbg_value(ptr %call, !1123, !DIExpression(), !1128)
    #dbg_value(i32 0, !1125, !DIExpression(), !1128)
  %cmp129 = icmp ne ptr %call, null, !dbg !1129
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1129
  %0 = and i1 %cmp230, %cmp129, !dbg !1129
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1129

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1129

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1129
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1129

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1123, !DIExpression(), !1128)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1125, !DIExpression(), !1128)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1133, !tbaa !829, !DIAssignID !1135
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1124, !DIExpression(), !1135, ptr %endptr, !DIExpression(), !1128)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1133
    #dbg_value(float %call3, !1126, !DIExpression(), !1128)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1136, !tbaa !829
  %3 = load i8, ptr %2, align 1, !dbg !1136, !tbaa !439
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1136
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1133

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1133

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1138, !tbaa !829
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1138
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1138
  br label %if.end8, !dbg !1138

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1133
  store float %call3, ptr %arrayidx, align 4, !dbg !1133, !tbaa !1140
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1133
    #dbg_value(i64 %indvars.iv.next, !1125, !DIExpression(), !1128)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1133
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1133
  store i8 10, ptr %arrayidx10, align 1, !dbg !1133, !tbaa !439
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1133
    #dbg_value(ptr %call11, !1123, !DIExpression(), !1128)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1129
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1129
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1129
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1129, !llvm.loop !1142

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1129

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1129

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1129

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1129

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1143
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1143
  store i8 10, ptr %arrayidx16, align 1, !dbg !1143, !tbaa !439
  br label %if.end17, !dbg !1143

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1129
  ret i32 0, !dbg !1129
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1146 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1149 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1160
    #dbg_assign(i1 undef, !1157, !DIExpression(), !1160, ptr %endptr, !DIExpression(), !1161)
    #dbg_value(ptr %s, !1153, !DIExpression(), !1161)
    #dbg_value(ptr %arr, !1154, !DIExpression(), !1161)
    #dbg_value(i32 %n, !1155, !DIExpression(), !1161)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1162
    #dbg_value(i32 0, !1158, !DIExpression(), !1161)
  %cmp.not = icmp eq ptr %s, null, !dbg !1163
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1163

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #19, !dbg !1163
  unreachable, !dbg !1163

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1162
    #dbg_value(ptr %call, !1156, !DIExpression(), !1161)
    #dbg_value(i32 0, !1158, !DIExpression(), !1161)
  %cmp129 = icmp ne ptr %call, null, !dbg !1162
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1162
  %0 = and i1 %cmp230, %cmp129, !dbg !1162
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1162

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1162

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1162
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1162

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1156, !DIExpression(), !1161)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1158, !DIExpression(), !1161)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1166, !tbaa !829, !DIAssignID !1168
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1157, !DIExpression(), !1168, ptr %endptr, !DIExpression(), !1161)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1166
    #dbg_value(double %call3, !1159, !DIExpression(), !1161)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1169, !tbaa !829
  %3 = load i8, ptr %2, align 1, !dbg !1169, !tbaa !439
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1169
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1166

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1166

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1171, !tbaa !829
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1171
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1171
  br label %if.end8, !dbg !1171

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1166
  store double %call3, ptr %arrayidx, align 8, !dbg !1166, !tbaa !361
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1166
    #dbg_value(i64 %indvars.iv.next, !1158, !DIExpression(), !1161)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1166
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1166
  store i8 10, ptr %arrayidx10, align 1, !dbg !1166, !tbaa !439
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1166
    #dbg_value(ptr %call11, !1156, !DIExpression(), !1161)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1162
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1162
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1162
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1162, !llvm.loop !1173

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1162

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1162

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1162

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1162

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1174
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1174
  store i8 10, ptr %arrayidx16, align 1, !dbg !1174, !tbaa !439
  br label %if.end17, !dbg !1174

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1162
  ret i32 0, !dbg !1162
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1177 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1180 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1184, !DIExpression(), !1189)
    #dbg_value(ptr %arr, !1185, !DIExpression(), !1189)
    #dbg_value(i32 %n, !1186, !DIExpression(), !1189)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1190
  br i1 %cmp, label %if.end, label %if.else, !dbg !1190

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1190
  unreachable, !dbg !1190

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1193
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1195

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1195

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #22, !dbg !1196
  %conv = trunc i64 %call to i32, !dbg !1196
    #dbg_value(i32 %conv, !1186, !DIExpression(), !1189)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1198

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1186, !DIExpression(), !1189)
    #dbg_value(i32 0, !1188, !DIExpression(), !1189)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1199
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1200

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1200

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1200

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1201

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1202
    #dbg_value(i32 %add, !1188, !DIExpression(), !1189)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1199
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1200, !llvm.loop !1204

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1200

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1200

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1188, !DIExpression(), !1189)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1206
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1206
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1207
  %conv6 = sext i32 %sub to i64, !dbg !1208
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #18, !dbg !1209
  %conv8 = trunc i64 %call7 to i32, !dbg !1209
    #dbg_value(i32 %conv8, !1187, !DIExpression(), !1189)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1210
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1188, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1189)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1210

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1210
  unreachable, !dbg !1210

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #18, !dbg !1213
  %conv16 = trunc i64 %call15 to i32, !dbg !1213
    #dbg_value(i32 %conv16, !1187, !DIExpression(), !1189)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1215
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1215

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1215
  unreachable, !dbg !1215

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1218
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1219, !llvm.loop !1220

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1219

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1222
}

; Function Attrs: nofree
declare !dbg !1223 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #9

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1228 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1232, !DIExpression(), !1236)
    #dbg_value(ptr %arr, !1233, !DIExpression(), !1236)
    #dbg_value(i32 %n, !1234, !DIExpression(), !1236)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1237
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1237

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1235, !DIExpression(), !1236)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1240
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1243

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1243

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1240
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1243

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #19, !dbg !1237
  unreachable, !dbg !1237

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1235, !DIExpression(), !1236)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1244
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1244, !tbaa !439
  %conv = zext i8 %0 to i32, !dbg !1244
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1244
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1240
    #dbg_value(i64 %indvars.iv.next, !1235, !DIExpression(), !1236)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1240
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1243, !llvm.loop !1246

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1243

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1243

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1247
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #14 !dbg !1248 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1265
    #dbg_assign(i1 undef, !1254, !DIExpression(), !1265, ptr %args, !DIExpression(), !1266)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1267
    #dbg_assign(i1 undef, !1261, !DIExpression(), !1267, ptr %buffer, !DIExpression(), !1266)
    #dbg_value(i32 %fd, !1252, !DIExpression(), !1266)
    #dbg_value(ptr %format, !1253, !DIExpression(), !1266)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #18, !dbg !1268
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1269
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1270
  %0 = load ptr, ptr %args, align 8, !dbg !1271, !tbaa !829
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #18, !dbg !1272
    #dbg_value(i32 %call, !1258, !DIExpression(), !1266)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1273
  %cmp = icmp slt i32 %call, 256, !dbg !1274
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1274

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1259, !DIExpression(), !1266)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1277
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1278

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1278

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1278

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1274
  unreachable, !dbg !1274

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1279
    #dbg_value(i32 %add, !1259, !DIExpression(), !1266)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1277
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1278, !llvm.loop !1281

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1278

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1278

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1259, !DIExpression(), !1266)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1283
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1283
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1284
  %conv = sext i32 %sub to i64, !dbg !1285
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #18, !dbg !1286
  %conv3 = trunc i64 %call2 to i32, !dbg !1286
    #dbg_value(i32 %conv3, !1260, !DIExpression(), !1266)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1287
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1259, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1266)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1287

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1287
  unreachable, !dbg !1287

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1290
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1290

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1290
  unreachable, !dbg !1290

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1293
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #18, !dbg !1293
  ret void, !dbg !1294
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #15

; Function Attrs: nofree nounwind
declare !dbg !1295 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #7

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1300 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1304, !DIExpression(), !1308)
    #dbg_value(ptr %arr, !1305, !DIExpression(), !1308)
    #dbg_value(i32 %n, !1306, !DIExpression(), !1308)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1309
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1309

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1307, !DIExpression(), !1308)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1312
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1315

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1315

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1312
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1315

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #19, !dbg !1309
  unreachable, !dbg !1309

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1307, !DIExpression(), !1308)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1316
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1316, !tbaa !934
  %conv = zext i16 %0 to i32, !dbg !1316
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1316
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1312
    #dbg_value(i64 %indvars.iv.next, !1307, !DIExpression(), !1308)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1312
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1315, !llvm.loop !1318

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1315

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1315

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1319
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1320 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1324, !DIExpression(), !1328)
    #dbg_value(ptr %arr, !1325, !DIExpression(), !1328)
    #dbg_value(i32 %n, !1326, !DIExpression(), !1328)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1329
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1329

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1327, !DIExpression(), !1328)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1332
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1335

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1335

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1332
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1335

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #19, !dbg !1329
  unreachable, !dbg !1329

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1327, !DIExpression(), !1328)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1336
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1336, !tbaa !366
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1336
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1332
    #dbg_value(i64 %indvars.iv.next, !1327, !DIExpression(), !1328)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1332
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1335, !llvm.loop !1338

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1335

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1335

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1339
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1340 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1344, !DIExpression(), !1348)
    #dbg_value(ptr %arr, !1345, !DIExpression(), !1348)
    #dbg_value(i32 %n, !1346, !DIExpression(), !1348)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1349
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1349

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1347, !DIExpression(), !1348)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1352
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1355

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1355

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1352
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1355

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #19, !dbg !1349
  unreachable, !dbg !1349

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1347, !DIExpression(), !1348)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1356
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1356, !tbaa !994
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1356
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1352
    #dbg_value(i64 %indvars.iv.next, !1347, !DIExpression(), !1348)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1352
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1355, !llvm.loop !1358

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1355

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1355

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1359
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1360 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1364, !DIExpression(), !1368)
    #dbg_value(ptr %arr, !1365, !DIExpression(), !1368)
    #dbg_value(i32 %n, !1366, !DIExpression(), !1368)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1369
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1369

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1367, !DIExpression(), !1368)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1372
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1375

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1375

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1372
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1375

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #19, !dbg !1369
  unreachable, !dbg !1369

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1367, !DIExpression(), !1368)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1376
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1376, !tbaa !439
  %conv = sext i8 %0 to i32, !dbg !1376
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1376
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1372
    #dbg_value(i64 %indvars.iv.next, !1367, !DIExpression(), !1368)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1372
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1375, !llvm.loop !1378

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1375

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1375

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1379
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1380 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1384, !DIExpression(), !1388)
    #dbg_value(ptr %arr, !1385, !DIExpression(), !1388)
    #dbg_value(i32 %n, !1386, !DIExpression(), !1388)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1389
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1389

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1387, !DIExpression(), !1388)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1392
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1395

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1395

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1392
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1395

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #19, !dbg !1389
  unreachable, !dbg !1389

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1387, !DIExpression(), !1388)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1396
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1396, !tbaa !934
  %conv = sext i16 %0 to i32, !dbg !1396
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1396
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1392
    #dbg_value(i64 %indvars.iv.next, !1387, !DIExpression(), !1388)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1392
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1395, !llvm.loop !1398

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1395

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1395

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1399
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !542 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !541, !DIExpression(), !1400)
    #dbg_value(ptr %arr, !546, !DIExpression(), !1400)
    #dbg_value(i32 %n, !547, !DIExpression(), !1400)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1401
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1401

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !548, !DIExpression(), !1400)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1404
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1405

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1405

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1404
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1405

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #19, !dbg !1401
  unreachable, !dbg !1401

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !548, !DIExpression(), !1400)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1406
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1406, !tbaa !366
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1406
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1404
    #dbg_value(i64 %indvars.iv.next, !548, !DIExpression(), !1400)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1404
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1405, !llvm.loop !1407

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1405

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1405

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1408
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1409 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #19, !dbg !1418
  unreachable, !dbg !1418

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1416, !DIExpression(), !1417)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1425
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1425, !tbaa !994
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1425
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
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1429 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1433, !DIExpression(), !1437)
    #dbg_value(ptr %arr, !1434, !DIExpression(), !1437)
    #dbg_value(i32 %n, !1435, !DIExpression(), !1437)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1438
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1438

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1436, !DIExpression(), !1437)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1441
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1444

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1444

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1441
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1444

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #19, !dbg !1438
  unreachable, !dbg !1438

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1436, !DIExpression(), !1437)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1445
  %0 = load float, ptr %arrayidx, align 4, !dbg !1445, !tbaa !1140
  %conv = fpext float %0 to double, !dbg !1445
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1445
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1441
    #dbg_value(i64 %indvars.iv.next, !1436, !DIExpression(), !1437)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1441
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1444, !llvm.loop !1447

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1444

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1444

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1448
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !521 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !520, !DIExpression(), !1449)
    #dbg_value(ptr %arr, !525, !DIExpression(), !1449)
    #dbg_value(i32 %n, !526, !DIExpression(), !1449)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1450
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1450

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !527, !DIExpression(), !1449)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1453
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1454

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1454

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1453
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1454

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #19, !dbg !1450
  unreachable, !dbg !1450

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !527, !DIExpression(), !1449)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1455
  %0 = load double, ptr %arrayidx, align 8, !dbg !1455, !tbaa !361
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1455
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1453
    #dbg_value(i64 %indvars.iv.next, !527, !DIExpression(), !1449)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1453
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1454, !llvm.loop !1456

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1454

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1454

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1457
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !510 {
entry.split:
    #dbg_value(i32 %fd, !509, !DIExpression(), !1458)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1459
  br i1 %cmp, label %if.end, label %if.else, !dbg !1459

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1459
  unreachable, !dbg !1459

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1460
  ret i32 0, !dbg !1461
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #1 !dbg !1462 {
entry.split:
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.012.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem66 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem68 = alloca ptr, align 8
  %i.041.i.i.reg2mem70 = alloca i32, align 4
  %indvars.iv.i.i3.reg2mem = alloca i64, align 8
  %sum.030.i.i.reg2mem = alloca double, align 8
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %indvars.iv33.i.i.reg2mem72 = alloca i64, align 8
  %check_file.0.reg2mem74 = alloca ptr, align 8
  %in_file.011.reg2mem76 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1466, !DIExpression(), !1475)
    #dbg_value(ptr %argv, !1467, !DIExpression(), !1475)
  %cmp = icmp slt i32 %argc, 4, !dbg !1476
  br i1 %cmp, label %if.end, label %if.else, !dbg !1476

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.15, ptr noundef nonnull @.str.2.16, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1476
  unreachable, !dbg !1476

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1468, !DIExpression(), !1475)
    #dbg_value(ptr @.str.4.17, !1469, !DIExpression(), !1475)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1479
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1481

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.17, ptr %check_file.0.reg2mem74, align 8
  store ptr @.str.3, ptr %in_file.011.reg2mem76, align 8
  br label %if.end7, !dbg !1481

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1482
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1482
    #dbg_value(ptr %0, !1468, !DIExpression(), !1475)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1483
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1485

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.17, ptr %check_file.0.reg2mem74, align 8
  store ptr %0, ptr %in_file.011.reg2mem76, align 8
  br label %if.end7, !dbg !1485

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1486
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1486
    #dbg_value(ptr %1, !1469, !DIExpression(), !1475)
  store ptr %1, ptr %check_file.0.reg2mem74, align 8
  store ptr %0, ptr %in_file.011.reg2mem76, align 8
  br label %if.end7, !dbg !1487

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem74.0.check_file.0.reload75, !1469, !DIExpression(), !1475)
  %in_file.011.reg2mem76.0.in_file.011.reload77 = load ptr, ptr %in_file.011.reg2mem76, align 8
  %check_file.0.reg2mem74.0.check_file.0.reload75 = load ptr, ptr %check_file.0.reg2mem74, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1488, !tbaa !366
  %conv = sext i32 %2 to i64, !dbg !1488
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #20, !dbg !1489
    #dbg_value(ptr %call, !1471, !DIExpression(), !1475)
  %cmp8.not = icmp eq ptr %call, null, !dbg !1490
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1490

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.18, ptr noundef nonnull @.str.2.16, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1490
  unreachable, !dbg !1490

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.011.reg2mem76.0.in_file.011.reload77, i32 noundef signext 0) #18, !dbg !1493
    #dbg_value(i32 %call14, !1470, !DIExpression(), !1475)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1494
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1494

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.19, ptr noundef nonnull @.str.2.16, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1494
  unreachable, !dbg !1494

if.end20:                                         ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #18, !dbg !1497
    #dbg_value(ptr %call, !387, !DIExpression(), !1498)
    #dbg_value(ptr %call, !388, !DIExpression(), !1498)
  %cols.i = getelementptr inbounds i8, ptr %call, i64 39520, !dbg !1500
  %vec.i = getelementptr inbounds i8, ptr %call, i64 59280, !dbg !1501
  %out.i = getelementptr inbounds i8, ptr %call, i64 63232, !dbg !1502
    #dbg_value(ptr %call, !336, !DIExpression(), !1503)
    #dbg_value(ptr %cols.i, !337, !DIExpression(), !1503)
    #dbg_value(ptr %vec.i, !338, !DIExpression(), !1503)
    #dbg_value(ptr %out.i, !339, !DIExpression(), !1503)
    #dbg_label(!343, !1505)
    #dbg_value(i32 0, !340, !DIExpression(), !1503)
  store i64 0, ptr %indvars.iv33.i.i.reg2mem72, align 8
  br label %for.body.i.i, !dbg !1506

for.body.i.i:                                     ; preds = %for.end.i.i.for.body.i.i_crit_edge, %if.end20
    #dbg_value(i64 %indvars.iv33.i.i.reg2mem72.0.load, !340, !DIExpression(), !1503)
  %indvars.iv33.i.i.reg2mem72.0.load = load i64, ptr %indvars.iv33.i.i.reg2mem72, align 8
  %arrayidx.i.i = getelementptr inbounds double, ptr %out.i, i64 %indvars.iv33.i.i.reg2mem72.0.load, !dbg !1507
  %3 = load double, ptr %arrayidx.i.i, align 8, !dbg !1507
    #dbg_value(double %3, !344, !DIExpression(), !1508)
    #dbg_label(!348, !1509)
    #dbg_value(i32 0, !341, !DIExpression(), !1503)
  %4 = mul nuw nsw i64 %indvars.iv33.i.i.reg2mem72.0.load, 10
  store double %3, ptr %sum.030.i.i.reg2mem, align 8
  store i64 0, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body3.i.i, !dbg !1510

for.body3.i.i:                                    ; preds = %for.body3.i.i.for.body3.i.i_crit_edge, %for.body.i.i
    #dbg_value(double %sum.030.i.i.reg2mem.0.sum.030.i.i.reload, !344, !DIExpression(), !1508)
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !341, !DIExpression(), !1503)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %sum.030.i.i.reg2mem.0.sum.030.i.i.reload = load double, ptr %sum.030.i.i.reg2mem, align 8
  %5 = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, %4, !dbg !1511
  %arrayidx5.i.i = getelementptr inbounds double, ptr %call, i64 %5, !dbg !1512
  %6 = load double, ptr %arrayidx5.i.i, align 8, !dbg !1512, !tbaa !361
  %arrayidx9.i.i = getelementptr inbounds i32, ptr %cols.i, i64 %5, !dbg !1513
  %7 = load i32, ptr %arrayidx9.i.i, align 4, !dbg !1513, !tbaa !366
  %idxprom10.i.i = sext i32 %7 to i64, !dbg !1514
  %arrayidx11.i.i = getelementptr inbounds double, ptr %vec.i, i64 %idxprom10.i.i, !dbg !1514
  %8 = load double, ptr %arrayidx11.i.i, align 8, !dbg !1514, !tbaa !361
  %mul12.i.i = fmul double %6, %8, !dbg !1515
    #dbg_value(double %mul12.i.i, !342, !DIExpression(), !1503)
  %add13.i.i = fadd double %sum.030.i.i.reg2mem.0.sum.030.i.i.reload, %mul12.i.i, !dbg !1516
    #dbg_value(double %add13.i.i, !344, !DIExpression(), !1508)
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !1517
    #dbg_value(i64 %indvars.iv.next.i.i, !341, !DIExpression(), !1503)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 10, !dbg !1518
  br i1 %exitcond.not.i.i, label %for.end.i.i, label %for.body3.i.i.for.body3.i.i_crit_edge, !dbg !1510, !llvm.loop !1519

for.body3.i.i.for.body3.i.i_crit_edge:            ; preds = %for.body3.i.i
  store double %add13.i.i, ptr %sum.030.i.i.reg2mem, align 8
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body3.i.i, !dbg !1510

for.end.i.i:                                      ; preds = %for.body3.i.i
  store double %add13.i.i, ptr %arrayidx.i.i, align 8, !dbg !1521, !tbaa !361
  %indvars.iv.next34.i.i = add nuw nsw i64 %indvars.iv33.i.i.reg2mem72.0.load, 1, !dbg !1522
    #dbg_value(i64 %indvars.iv.next34.i.i, !340, !DIExpression(), !1503)
  %exitcond36.not.i.i = icmp eq i64 %indvars.iv.next34.i.i, 494, !dbg !1523
  br i1 %exitcond36.not.i.i, label %run_benchmark.exit, label %for.end.i.i.for.body.i.i_crit_edge, !dbg !1506, !llvm.loop !1524

for.end.i.i.for.body.i.i_crit_edge:               ; preds = %for.end.i.i
  store i64 %indvars.iv.next34.i.i, ptr %indvars.iv33.i.i.reg2mem72, align 8
  br label %for.body.i.i, !dbg !1506

run_benchmark.exit:                               ; preds = %for.end.i.i
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #18, !dbg !1526
    #dbg_value(i32 %call21, !1472, !DIExpression(), !1475)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1527
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1527

if.else26:                                        ; preds = %run_benchmark.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.16, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1527
  unreachable, !dbg !1527

if.end27:                                         ; preds = %run_benchmark.exit
    #dbg_value(i32 %call21, !602, !DIExpression(), !1530)
    #dbg_value(ptr %call, !603, !DIExpression(), !1530)
    #dbg_value(ptr %call, !604, !DIExpression(), !1530)
    #dbg_value(i32 %call21, !509, !DIExpression(), !1532)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1534
  br i1 %cmp.i.i.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1534

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1534
  unreachable, !dbg !1534

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1535
    #dbg_value(i32 %call21, !520, !DIExpression(), !1536)
    #dbg_value(ptr %out.i, !525, !DIExpression(), !1536)
    #dbg_value(i32 494, !526, !DIExpression(), !1536)
    #dbg_value(i32 0, !527, !DIExpression(), !1536)
  store i64 0, ptr %indvars.iv.i.i3.reg2mem, align 8
  br label %for.body.i.i2, !dbg !1538

for.body.i.i2:                                    ; preds = %for.body.i.i2.for.body.i.i2_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i3.reg2mem.0.load, !527, !DIExpression(), !1536)
  %indvars.iv.i.i3.reg2mem.0.load = load i64, ptr %indvars.iv.i.i3.reg2mem, align 8
  %arrayidx.i.i4 = getelementptr inbounds double, ptr %out.i, i64 %indvars.iv.i.i3.reg2mem.0.load, !dbg !1539
  %9 = load double, ptr %arrayidx.i.i4, align 8, !dbg !1539, !tbaa !361
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.21, double noundef %9), !dbg !1539
  %indvars.iv.next.i.i5 = add nuw nsw i64 %indvars.iv.i.i3.reg2mem.0.load, 1, !dbg !1540
    #dbg_value(i64 %indvars.iv.next.i.i5, !527, !DIExpression(), !1536)
  %exitcond.not.i.i6 = icmp eq i64 %indvars.iv.next.i.i5, 494, !dbg !1540
  br i1 %exitcond.not.i.i6, label %data_to_output.exit, label %for.body.i.i2.for.body.i.i2_crit_edge, !dbg !1538, !llvm.loop !1541

for.body.i.i2.for.body.i.i2_crit_edge:            ; preds = %for.body.i.i2
  store i64 %indvars.iv.next.i.i5, ptr %indvars.iv.i.i3.reg2mem, align 8
  br label %for.body.i.i2, !dbg !1538

data_to_output.exit:                              ; preds = %for.body.i.i2
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #18, !dbg !1542
  %10 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1543, !tbaa !366
  %conv29 = sext i32 %10 to i64, !dbg !1543
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #20, !dbg !1544
    #dbg_value(ptr %call30, !1474, !DIExpression(), !1475)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1545
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1545

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.20, ptr noundef nonnull @.str.2.16, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1545
  unreachable, !dbg !1545

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem74.0.check_file.0.reload75, i32 noundef signext 0) #18, !dbg !1548
    #dbg_value(i32 %call37, !1473, !DIExpression(), !1475)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1549
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1549

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.21, ptr noundef nonnull @.str.2.16, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1549
  unreachable, !dbg !1549

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !571, !DIExpression(), !1552)
    #dbg_value(ptr %call30, !572, !DIExpression(), !1552)
    #dbg_value(ptr %call30, !573, !DIExpression(), !1552)
  %call.i = tail call ptr @readfile(i32 noundef signext %call37) #18, !dbg !1554
    #dbg_value(ptr %call.i, !574, !DIExpression(), !1552)
    #dbg_value(ptr %call.i, !429, !DIExpression(), !1555)
    #dbg_value(i32 1, !434, !DIExpression(), !1555)
    #dbg_value(i32 0, !435, !DIExpression(), !1555)
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem68, align 8
  store i32 0, ptr %i.041.i.i.reg2mem70, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i.reg2mem70.0.load, !435, !DIExpression(), !1555)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem68.0.s.addr.040.i.i.reload69, !429, !DIExpression(), !1555)
  %i.041.i.i.reg2mem70.0.load = load i32, ptr %i.041.i.i.reg2mem70, align 4
  %s.addr.040.i.i.reg2mem68.0.s.addr.040.i.i.reload69 = load ptr, ptr %s.addr.040.i.i.reg2mem68, align 8
  %11 = load i8, ptr %s.addr.040.i.i.reg2mem68.0.s.addr.040.i.i.reload69, align 1, !dbg !1557, !tbaa !439
  switch i8 %11, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1558

land.rhs.i.i.output_to_data.exit_crit_edge:       ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem68.0.s.addr.040.i.i.reload69, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1558

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem70.0.load, ptr %i.1.i.i.reg2mem66, align 4
  br label %if.end21.i.i, !dbg !1558

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i7 = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem68.0.s.addr.040.i.i.reload69, i64 1, !dbg !1559
  %12 = load i8, ptr %arrayidx11.i.i7, align 1, !dbg !1559, !tbaa !439
  %cmp13.i.i = icmp eq i8 %12, 37, !dbg !1560
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1561

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem70.0.load, ptr %i.1.i.i.reg2mem66, align 4
  br label %if.end21.i.i, !dbg !1561

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem68.0.s.addr.040.i.i.reload69, i64 2, !dbg !1562
  %13 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1562, !tbaa !439
  %cmp18.i.i = icmp eq i8 %13, 10, !dbg !1563
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1564
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem70.0.load, %inc.i.i, !dbg !1564
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem66, align 4
  br label %if.end21.i.i, !dbg !1564

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem66.0.load, !435, !DIExpression(), !1555)
  %i.1.i.i.reg2mem66.0.load = load i32, ptr %i.1.i.i.reg2mem66, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem68.0.s.addr.040.i.i.reload69, i64 1, !dbg !1565
    #dbg_value(ptr %incdec.ptr.i.i, !429, !DIExpression(), !1555)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem66.0.load, 1, !dbg !1566
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1567, !llvm.loop !1568

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem68, align 8
  store i32 %i.1.i.i.reg2mem66.0.load, ptr %i.041.i.i.reg2mem70, align 4
  br label %land.rhs.i.i, !dbg !1567

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1570, !tbaa !439
  %14 = icmp eq i8 %.pre.i.i, 0, !dbg !1571
  %15 = select i1 %14, i64 0, i64 2, !dbg !1572
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %15, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1567

output_to_data.exit:                              ; preds = %land.rhs.i.i.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1572
    #dbg_value(ptr %spec.select38.i.i, !575, !DIExpression(), !1552)
  %out.i8 = getelementptr inbounds i8, ptr %call30, i64 63232, !dbg !1573
  %call2.i = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i.i, ptr noundef nonnull %out.i8, i32 noundef signext 494) #18, !dbg !1574
  tail call void @free(ptr noundef %call.i) #18, !dbg !1575
    #dbg_value(ptr %call, !622, !DIExpression(), !1576)
    #dbg_value(ptr %call30, !623, !DIExpression(), !1576)
    #dbg_value(ptr %call, !624, !DIExpression(), !1576)
    #dbg_value(ptr %call30, !625, !DIExpression(), !1576)
    #dbg_value(i32 0, !626, !DIExpression(), !1576)
    #dbg_value(i32 0, !627, !DIExpression(), !1576)
  store i32 0, ptr %has_errors.012.i.reg2mem, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1579

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %output_to_data.exit
    #dbg_value(i32 %has_errors.012.i.reg2mem.0.load, !626, !DIExpression(), !1576)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !627, !DIExpression(), !1576)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %has_errors.012.i.reg2mem.0.load = load i32, ptr %has_errors.012.i.reg2mem, align 4
  %arrayidx.i = getelementptr inbounds %struct.bench_args_t, ptr %call, i64 0, i32 3, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1580
  %16 = load double, ptr %arrayidx.i, align 8, !dbg !1580, !tbaa !361
  %arrayidx3.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 3, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1581
  %17 = load double, ptr %arrayidx3.i, align 8, !dbg !1581, !tbaa !361
  %sub.i = fsub double %16, %17, !dbg !1582
    #dbg_value(double %sub.i, !628, !DIExpression(), !1576)
  %18 = tail call double @llvm.fabs.f64(double %sub.i), !dbg !1583
  %19 = fcmp ogt double %18, 0x3EB0C6F7A0B5ED8D, !dbg !1583
  %lor.ext.i = zext i1 %19 to i32, !dbg !1583
  %or.i = or i32 %has_errors.012.i.reg2mem.0.load, %lor.ext.i, !dbg !1584
    #dbg_value(i32 %or.i, !626, !DIExpression(), !1576)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1585
    #dbg_value(i64 %indvars.iv.next.i, !627, !DIExpression(), !1576)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 494, !dbg !1586
  br i1 %exitcond.not.i, label %check_data.exit, label %for.body.i.for.body.i_crit_edge, !dbg !1579, !llvm.loop !1587

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i32 %or.i, ptr %has_errors.012.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1579

check_data.exit:                                  ; preds = %for.body.i
  %tobool.not.i.not = icmp eq i32 %or.i, 0, !dbg !1589
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1590

if.then45:                                        ; preds = %check_data.exit
  %20 = load ptr, ptr @stderr, align 8, !dbg !1591, !tbaa !829
  %21 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %20) #21, !dbg !1593
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1594

if.end47:                                         ; preds = %check_data.exit
  tail call void @free(ptr noundef nonnull %call) #18, !dbg !1595
  tail call void @free(ptr noundef nonnull %call30) #18, !dbg !1596
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1597
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1598

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1599
}

; Function Attrs: nofree
declare !dbg !1600 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #9

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

!llvm.dbg.cu = !{!234, !188, !236, !297}
!llvm.ident = !{!318, !318, !318, !318}
!llvm.module.flags = !{!319, !320, !321, !322, !323, !325, !326, !327, !328, !329}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/spmv/ellpack")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/spmv/ellpack")
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
!187 = distinct !DIGlobalVariable(name: "INPUT_SIZE", scope: !188, file: !189, line: 4, type: !206, isLocal: false, isDefinition: true)
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !212, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/spmv/ellpack")
!190 = !{!191}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 21, size: 537472, elements: !194)
!193 = !DIFile(filename: "./spmv.h", directory: "/home/kelvin/MachSuite/spmv/ellpack")
!194 = !{!195, !200, !207, !211}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "nzval", scope: !192, file: !193, line: 22, baseType: !196, size: 316160)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 316160, elements: !198)
!197 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!198 = !{!199}
!199 = !DISubrange(count: 4940)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "cols", scope: !192, file: !193, line: 23, baseType: !201, size: 158080, offset: 316160)
!201 = !DICompositeType(tag: DW_TAG_array_type, baseType: !202, size: 158080, elements: !198)
!202 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !203, line: 26, baseType: !204)
!203 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!204 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !205, line: 41, baseType: !206)
!205 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!206 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "vec", scope: !192, file: !193, line: 24, baseType: !208, size: 31616, offset: 474240)
!208 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 31616, elements: !209)
!209 = !{!210}
!210 = !DISubrange(count: 494)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "out", scope: !192, file: !193, line: 25, baseType: !208, size: 31616, offset: 505856)
!212 = !{!186}
!213 = !DIGlobalVariableExpression(var: !214, expr: !DIExpression())
!214 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !215, isLocal: true, isDefinition: true)
!215 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!216 = !DIGlobalVariableExpression(var: !217, expr: !DIExpression())
!217 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !218, isLocal: true, isDefinition: true)
!218 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!219 = !DIGlobalVariableExpression(var: !220, expr: !DIExpression())
!220 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !221, isLocal: true, isDefinition: true)
!221 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !222)
!222 = !{!223}
!223 = !DISubrange(count: 12)
!224 = !DIGlobalVariableExpression(var: !225, expr: !DIExpression())
!225 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !226, isLocal: true, isDefinition: true)
!226 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!227 = !DIGlobalVariableExpression(var: !228, expr: !DIExpression())
!228 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!229 = !DIGlobalVariableExpression(var: !230, expr: !DIExpression())
!230 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !231, isLocal: true, isDefinition: true)
!231 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!232 = !DIGlobalVariableExpression(var: !233, expr: !DIExpression())
!233 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!234 = distinct !DICompileUnit(language: DW_LANG_C11, file: !235, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!235 = !DIFile(filename: "spmv.c", directory: "/home/kelvin/MachSuite/spmv/ellpack")
!236 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !237, globals: !263, splitDebugInlining: false, nameTableKind: None)
!237 = !{!238, !4, !239, !240, !244, !247, !250, !253, !256, !202, !259, !262, !197}
!238 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!239 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!240 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !241, line: 24, baseType: !242)
!241 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!242 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !205, line: 38, baseType: !243)
!243 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!244 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !241, line: 25, baseType: !245)
!245 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !205, line: 40, baseType: !246)
!246 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!247 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !241, line: 26, baseType: !248)
!248 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !205, line: 42, baseType: !249)
!249 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!250 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !241, line: 27, baseType: !251)
!251 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !205, line: 45, baseType: !252)
!252 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!253 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !203, line: 24, baseType: !254)
!254 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !205, line: 37, baseType: !255)
!255 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!256 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !203, line: 25, baseType: !257)
!257 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !205, line: 39, baseType: !258)
!258 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!259 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !203, line: 27, baseType: !260)
!260 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !205, line: 44, baseType: !261)
!261 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!262 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!263 = !{!264, !0, !7, !12, !269, !18, !271, !23, !276, !28, !278, !33, !38, !280, !43, !45, !47, !52, !57, !62, !67, !69, !71, !76, !78, !80, !82, !87, !89, !285, !92, !97, !102, !107, !112, !114, !116, !121, !126, !128, !130, !132, !134, !136, !141, !146, !148, !153, !290, !158, !163, !292, !165}
!264 = !DIGlobalVariableExpression(var: !265, expr: !DIExpression())
!265 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !266, isLocal: true, isDefinition: true)
!266 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !267)
!267 = !{!268}
!268 = !DISubrange(count: 24)
!269 = !DIGlobalVariableExpression(var: !270, expr: !DIExpression())
!270 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !30, isLocal: true, isDefinition: true)
!271 = !DIGlobalVariableExpression(var: !272, expr: !DIExpression())
!272 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !273, isLocal: true, isDefinition: true)
!273 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !274)
!274 = !{!275}
!275 = !DISubrange(count: 14)
!276 = !DIGlobalVariableExpression(var: !277, expr: !DIExpression())
!277 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !273, isLocal: true, isDefinition: true)
!278 = !DIGlobalVariableExpression(var: !279, expr: !DIExpression())
!279 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !9, isLocal: true, isDefinition: true)
!280 = !DIGlobalVariableExpression(var: !281, expr: !DIExpression())
!281 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !282, isLocal: true, isDefinition: true)
!282 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !283)
!283 = !{!284}
!284 = !DISubrange(count: 21)
!285 = !DIGlobalVariableExpression(var: !286, expr: !DIExpression())
!286 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !287, isLocal: true, isDefinition: true)
!287 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !288)
!288 = !{!289}
!289 = !DISubrange(count: 13)
!290 = !DIGlobalVariableExpression(var: !291, expr: !DIExpression())
!291 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !20, isLocal: true, isDefinition: true)
!292 = !DIGlobalVariableExpression(var: !293, expr: !DIExpression())
!293 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !294, isLocal: true, isDefinition: true)
!294 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !295)
!295 = !{!296}
!296 = !DISubrange(count: 27)
!297 = distinct !DICompileUnit(language: DW_LANG_C11, file: !170, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !298, globals: !299, splitDebugInlining: false, nameTableKind: None)
!298 = !{!239}
!299 = !{!300, !168, !174, !176, !179, !184, !302, !213, !304, !216, !219, !306, !224, !227, !311, !229, !232, !313}
!300 = !DIGlobalVariableExpression(var: !301, expr: !DIExpression())
!301 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !226, isLocal: true, isDefinition: true)
!302 = !DIGlobalVariableExpression(var: !303, expr: !DIExpression())
!303 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !273, isLocal: true, isDefinition: true)
!304 = !DIGlobalVariableExpression(var: !305, expr: !DIExpression())
!305 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !215, isLocal: true, isDefinition: true)
!306 = !DIGlobalVariableExpression(var: !307, expr: !DIExpression())
!307 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !308, isLocal: true, isDefinition: true)
!308 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !309)
!309 = !{!310}
!310 = !DISubrange(count: 31)
!311 = !DIGlobalVariableExpression(var: !312, expr: !DIExpression())
!312 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !215, isLocal: true, isDefinition: true)
!313 = !DIGlobalVariableExpression(var: !314, expr: !DIExpression())
!314 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !315, isLocal: true, isDefinition: true)
!315 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !316)
!316 = !{!317}
!317 = !DISubrange(count: 10)
!318 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!319 = !{i32 7, !"Dwarf Version", i32 4}
!320 = !{i32 2, !"Debug Info Version", i32 3}
!321 = !{i32 1, !"wchar_size", i32 4}
!322 = !{i32 1, !"target-abi", !"lp64d"}
!323 = distinct !{i32 6, !"riscv-isa", !324}
!324 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!325 = !{i32 8, !"PIC Level", i32 2}
!326 = !{i32 7, !"PIE Level", i32 2}
!327 = !{i32 7, !"uwtable", i32 2}
!328 = !{i32 8, !"SmallDataLimit", i32 8}
!329 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!330 = distinct !DISubprogram(name: "spmv", scope: !235, file: !235, line: 8, type: !331, scopeLine: 9, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !234, retainedNodes: !335)
!331 = !DISubroutineType(types: !332)
!332 = !{null, !333, !334, !333, !333}
!333 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!334 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !202, size: 64)
!335 = !{!336, !337, !338, !339, !340, !341, !342, !343, !344, !348}
!336 = !DILocalVariable(name: "nzval", arg: 1, scope: !330, file: !235, line: 8, type: !333)
!337 = !DILocalVariable(name: "cols", arg: 2, scope: !330, file: !235, line: 8, type: !334)
!338 = !DILocalVariable(name: "vec", arg: 3, scope: !330, file: !235, line: 8, type: !333)
!339 = !DILocalVariable(name: "out", arg: 4, scope: !330, file: !235, line: 8, type: !333)
!340 = !DILocalVariable(name: "i", scope: !330, file: !235, line: 10, type: !206)
!341 = !DILocalVariable(name: "j", scope: !330, file: !235, line: 10, type: !206)
!342 = !DILocalVariable(name: "Si", scope: !330, file: !235, line: 11, type: !197)
!343 = !DILabel(scope: !330, name: "ellpack_1", file: !235, line: 13)
!344 = !DILocalVariable(name: "sum", scope: !345, file: !235, line: 14, type: !197)
!345 = distinct !DILexicalBlock(scope: !346, file: !235, line: 13, column: 37)
!346 = distinct !DILexicalBlock(scope: !347, file: !235, line: 13, column: 17)
!347 = distinct !DILexicalBlock(scope: !330, file: !235, line: 13, column: 17)
!348 = !DILabel(scope: !345, name: "ellpack_2", file: !235, line: 15)
!349 = !DILocation(line: 0, scope: !330)
!350 = !DILocation(line: 13, column: 5, scope: !330)
!351 = !DILocation(line: 13, column: 17, scope: !347)
!352 = !DILocation(line: 14, column: 20, scope: !345)
!353 = !DILocation(line: 0, scope: !345)
!354 = !DILocation(line: 15, column: 9, scope: !345)
!355 = !DILocation(line: 15, column: 21, scope: !356)
!356 = distinct !DILexicalBlock(scope: !345, file: !235, line: 15, column: 21)
!357 = !DILocation(line: 16, column: 30, scope: !358)
!358 = distinct !DILexicalBlock(scope: !359, file: !235, line: 15, column: 41)
!359 = distinct !DILexicalBlock(scope: !356, file: !235, line: 15, column: 21)
!360 = !DILocation(line: 16, column: 22, scope: !358)
!361 = !{!362, !362, i64 0}
!362 = !{!"double", !363, i64 0}
!363 = !{!"omnipotent char", !364, i64 0}
!364 = !{!"Simple C/C++ TBAA"}
!365 = !DILocation(line: 16, column: 43, scope: !358)
!366 = !{!367, !367, i64 0}
!367 = !{!"int", !363, i64 0}
!368 = !DILocation(line: 16, column: 39, scope: !358)
!369 = !DILocation(line: 16, column: 37, scope: !358)
!370 = !DILocation(line: 17, column: 21, scope: !358)
!371 = !DILocation(line: 15, column: 37, scope: !359)
!372 = !DILocation(line: 15, column: 32, scope: !359)
!373 = distinct !{!373, !355, !374, !375, !376}
!374 = !DILocation(line: 18, column: 9, scope: !356)
!375 = !{!"llvm.loop.mustprogress"}
!376 = !{!"llvm.loop.unroll.disable"}
!377 = !DILocation(line: 19, column: 16, scope: !345)
!378 = !DILocation(line: 13, column: 33, scope: !346)
!379 = !DILocation(line: 13, column: 28, scope: !346)
!380 = distinct !{!380, !351, !381, !375, !376}
!381 = !DILocation(line: 20, column: 5, scope: !347)
!382 = !DILocation(line: 21, column: 1, scope: !330)
!383 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 8, type: !384, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !386)
!384 = !DISubroutineType(types: !385)
!385 = !{null, !239}
!386 = !{!387, !388}
!387 = !DILocalVariable(name: "vargs", arg: 1, scope: !383, file: !189, line: 8, type: !239)
!388 = !DILocalVariable(name: "args", scope: !383, file: !189, line: 9, type: !191)
!389 = !DILocation(line: 0, scope: !383)
!390 = !DILocation(line: 10, column: 28, scope: !383)
!391 = !DILocation(line: 10, column: 40, scope: !383)
!392 = !DILocation(line: 10, column: 51, scope: !383)
!393 = !DILocation(line: 0, scope: !330, inlinedAt: !394)
!394 = distinct !DILocation(line: 10, column: 3, scope: !383)
!395 = !DILocation(line: 13, column: 5, scope: !330, inlinedAt: !394)
!396 = !DILocation(line: 13, column: 17, scope: !347, inlinedAt: !394)
!397 = !DILocation(line: 14, column: 20, scope: !345, inlinedAt: !394)
!398 = !DILocation(line: 0, scope: !345, inlinedAt: !394)
!399 = !DILocation(line: 15, column: 9, scope: !345, inlinedAt: !394)
!400 = !DILocation(line: 15, column: 21, scope: !356, inlinedAt: !394)
!401 = !DILocation(line: 16, column: 30, scope: !358, inlinedAt: !394)
!402 = !DILocation(line: 16, column: 22, scope: !358, inlinedAt: !394)
!403 = !DILocation(line: 16, column: 43, scope: !358, inlinedAt: !394)
!404 = !DILocation(line: 16, column: 39, scope: !358, inlinedAt: !394)
!405 = !DILocation(line: 16, column: 37, scope: !358, inlinedAt: !394)
!406 = !DILocation(line: 17, column: 21, scope: !358, inlinedAt: !394)
!407 = !DILocation(line: 15, column: 37, scope: !359, inlinedAt: !394)
!408 = !DILocation(line: 15, column: 32, scope: !359, inlinedAt: !394)
!409 = distinct !{!409, !400, !410, !375, !376}
!410 = !DILocation(line: 18, column: 9, scope: !356, inlinedAt: !394)
!411 = !DILocation(line: 19, column: 16, scope: !345, inlinedAt: !394)
!412 = !DILocation(line: 13, column: 33, scope: !346, inlinedAt: !394)
!413 = !DILocation(line: 13, column: 28, scope: !346, inlinedAt: !394)
!414 = distinct !{!414, !396, !415, !375, !376}
!415 = !DILocation(line: 20, column: 5, scope: !347, inlinedAt: !394)
!416 = !DILocation(line: 11, column: 1, scope: !383)
!417 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 22, type: !418, scopeLine: 22, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !420)
!418 = !DISubroutineType(types: !419)
!419 = !{null, !206, !239}
!420 = !{!421, !422, !423, !424, !425}
!421 = !DILocalVariable(name: "fd", arg: 1, scope: !417, file: !189, line: 22, type: !206)
!422 = !DILocalVariable(name: "vdata", arg: 2, scope: !417, file: !189, line: 22, type: !239)
!423 = !DILocalVariable(name: "data", scope: !417, file: !189, line: 23, type: !191)
!424 = !DILocalVariable(name: "p", scope: !417, file: !189, line: 24, type: !238)
!425 = !DILocalVariable(name: "s", scope: !417, file: !189, line: 24, type: !238)
!426 = !DILocation(line: 0, scope: !417)
!427 = !DILocation(line: 26, column: 3, scope: !417)
!428 = !DILocation(line: 28, column: 7, scope: !417)
!429 = !DILocalVariable(name: "s", arg: 1, scope: !430, file: !2, line: 56, type: !238)
!430 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !431, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !433)
!431 = !DISubroutineType(types: !432)
!432 = !{!238, !238, !206}
!433 = !{!429, !434, !435}
!434 = !DILocalVariable(name: "n", arg: 2, scope: !430, file: !2, line: 56, type: !206)
!435 = !DILocalVariable(name: "i", scope: !430, file: !2, line: 57, type: !206)
!436 = !DILocation(line: 0, scope: !430, inlinedAt: !437)
!437 = distinct !DILocation(line: 30, column: 7, scope: !417)
!438 = !DILocation(line: 64, column: 17, scope: !430, inlinedAt: !437)
!439 = !{!363, !363, i64 0}
!440 = !DILocation(line: 64, column: 3, scope: !430, inlinedAt: !437)
!441 = !DILocation(line: 66, column: 22, scope: !442, inlinedAt: !437)
!442 = distinct !DILexicalBlock(scope: !443, file: !2, line: 66, column: 9)
!443 = distinct !DILexicalBlock(scope: !430, file: !2, line: 64, column: 31)
!444 = !DILocation(line: 66, column: 26, scope: !442, inlinedAt: !437)
!445 = !DILocation(line: 66, column: 32, scope: !442, inlinedAt: !437)
!446 = !DILocation(line: 66, column: 35, scope: !442, inlinedAt: !437)
!447 = !DILocation(line: 66, column: 39, scope: !442, inlinedAt: !437)
!448 = !DILocation(line: 66, column: 9, scope: !443, inlinedAt: !437)
!449 = !DILocation(line: 69, column: 6, scope: !443, inlinedAt: !437)
!450 = !DILocation(line: 64, column: 10, scope: !430, inlinedAt: !437)
!451 = !DILocation(line: 64, column: 13, scope: !430, inlinedAt: !437)
!452 = distinct !{!452, !440, !453, !375, !376}
!453 = !DILocation(line: 70, column: 3, scope: !430, inlinedAt: !437)
!454 = !DILocation(line: 71, column: 6, scope: !455, inlinedAt: !437)
!455 = distinct !DILexicalBlock(scope: !430, file: !2, line: 71, column: 6)
!456 = !DILocation(line: 71, column: 8, scope: !455, inlinedAt: !437)
!457 = !DILocation(line: 71, column: 6, scope: !430, inlinedAt: !437)
!458 = !DILocation(line: 31, column: 3, scope: !417)
!459 = !DILocation(line: 0, scope: !430, inlinedAt: !460)
!460 = distinct !DILocation(line: 33, column: 7, scope: !417)
!461 = !DILocation(line: 64, column: 17, scope: !430, inlinedAt: !460)
!462 = !DILocation(line: 64, column: 3, scope: !430, inlinedAt: !460)
!463 = !DILocation(line: 66, column: 22, scope: !442, inlinedAt: !460)
!464 = !DILocation(line: 66, column: 26, scope: !442, inlinedAt: !460)
!465 = !DILocation(line: 66, column: 32, scope: !442, inlinedAt: !460)
!466 = !DILocation(line: 66, column: 35, scope: !442, inlinedAt: !460)
!467 = !DILocation(line: 66, column: 39, scope: !442, inlinedAt: !460)
!468 = !DILocation(line: 66, column: 9, scope: !443, inlinedAt: !460)
!469 = !DILocation(line: 69, column: 6, scope: !443, inlinedAt: !460)
!470 = !DILocation(line: 64, column: 10, scope: !430, inlinedAt: !460)
!471 = !DILocation(line: 64, column: 13, scope: !430, inlinedAt: !460)
!472 = distinct !{!472, !462, !473, !375, !376}
!473 = !DILocation(line: 70, column: 3, scope: !430, inlinedAt: !460)
!474 = !DILocation(line: 71, column: 6, scope: !455, inlinedAt: !460)
!475 = !DILocation(line: 71, column: 8, scope: !455, inlinedAt: !460)
!476 = !DILocation(line: 71, column: 6, scope: !430, inlinedAt: !460)
!477 = !DILocation(line: 34, column: 32, scope: !417)
!478 = !DILocation(line: 34, column: 3, scope: !417)
!479 = !DILocation(line: 0, scope: !430, inlinedAt: !480)
!480 = distinct !DILocation(line: 36, column: 7, scope: !417)
!481 = !DILocation(line: 64, column: 17, scope: !430, inlinedAt: !480)
!482 = !DILocation(line: 64, column: 3, scope: !430, inlinedAt: !480)
!483 = !DILocation(line: 66, column: 22, scope: !442, inlinedAt: !480)
!484 = !DILocation(line: 66, column: 26, scope: !442, inlinedAt: !480)
!485 = !DILocation(line: 66, column: 32, scope: !442, inlinedAt: !480)
!486 = !DILocation(line: 66, column: 35, scope: !442, inlinedAt: !480)
!487 = !DILocation(line: 66, column: 39, scope: !442, inlinedAt: !480)
!488 = !DILocation(line: 66, column: 9, scope: !443, inlinedAt: !480)
!489 = !DILocation(line: 69, column: 6, scope: !443, inlinedAt: !480)
!490 = !DILocation(line: 64, column: 10, scope: !430, inlinedAt: !480)
!491 = !DILocation(line: 64, column: 13, scope: !430, inlinedAt: !480)
!492 = distinct !{!492, !482, !493, !375, !376}
!493 = !DILocation(line: 70, column: 3, scope: !430, inlinedAt: !480)
!494 = !DILocation(line: 71, column: 6, scope: !455, inlinedAt: !480)
!495 = !DILocation(line: 71, column: 8, scope: !455, inlinedAt: !480)
!496 = !DILocation(line: 71, column: 6, scope: !430, inlinedAt: !480)
!497 = !DILocation(line: 37, column: 37, scope: !417)
!498 = !DILocation(line: 37, column: 3, scope: !417)
!499 = !DILocation(line: 38, column: 3, scope: !417)
!500 = !DILocation(line: 39, column: 1, scope: !417)
!501 = !DISubprogram(name: "free", scope: !502, file: !502, line: 687, type: !384, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!502 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!503 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 41, type: !418, scopeLine: 41, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !504)
!504 = !{!505, !506, !507}
!505 = !DILocalVariable(name: "fd", arg: 1, scope: !503, file: !189, line: 41, type: !206)
!506 = !DILocalVariable(name: "vdata", arg: 2, scope: !503, file: !189, line: 41, type: !239)
!507 = !DILocalVariable(name: "data", scope: !503, file: !189, line: 42, type: !191)
!508 = !DILocation(line: 0, scope: !503)
!509 = !DILocalVariable(name: "fd", arg: 1, scope: !510, file: !2, line: 189, type: !206)
!510 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !511, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !513)
!511 = !DISubroutineType(types: !512)
!512 = !{!206, !206}
!513 = !{!509}
!514 = !DILocation(line: 0, scope: !510, inlinedAt: !515)
!515 = distinct !DILocation(line: 44, column: 3, scope: !503)
!516 = !DILocation(line: 190, column: 3, scope: !517, inlinedAt: !515)
!517 = distinct !DILexicalBlock(scope: !518, file: !2, line: 190, column: 3)
!518 = distinct !DILexicalBlock(scope: !510, file: !2, line: 190, column: 3)
!519 = !DILocation(line: 191, column: 3, scope: !510, inlinedAt: !515)
!520 = !DILocalVariable(name: "fd", arg: 1, scope: !521, file: !2, line: 187, type: !206)
!521 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !522, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !524)
!522 = !DISubroutineType(types: !523)
!523 = !{!206, !206, !333, !206}
!524 = !{!520, !525, !526, !527}
!525 = !DILocalVariable(name: "arr", arg: 2, scope: !521, file: !2, line: 187, type: !333)
!526 = !DILocalVariable(name: "n", arg: 3, scope: !521, file: !2, line: 187, type: !206)
!527 = !DILocalVariable(name: "i", scope: !521, file: !2, line: 187, type: !206)
!528 = !DILocation(line: 0, scope: !521, inlinedAt: !529)
!529 = distinct !DILocation(line: 45, column: 3, scope: !503)
!530 = !DILocation(line: 187, column: 1, scope: !531, inlinedAt: !529)
!531 = distinct !DILexicalBlock(scope: !521, file: !2, line: 187, column: 1)
!532 = !DILocation(line: 187, column: 1, scope: !533, inlinedAt: !529)
!533 = distinct !DILexicalBlock(scope: !534, file: !2, line: 187, column: 1)
!534 = distinct !DILexicalBlock(scope: !531, file: !2, line: 187, column: 1)
!535 = !DILocation(line: 187, column: 1, scope: !534, inlinedAt: !529)
!536 = distinct !{!536, !530, !530, !375, !376}
!537 = !DILocation(line: 0, scope: !510, inlinedAt: !538)
!538 = distinct !DILocation(line: 47, column: 3, scope: !503)
!539 = !DILocation(line: 191, column: 3, scope: !510, inlinedAt: !538)
!540 = !DILocation(line: 48, column: 33, scope: !503)
!541 = !DILocalVariable(name: "fd", arg: 1, scope: !542, file: !2, line: 183, type: !206)
!542 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !543, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !545)
!543 = !DISubroutineType(types: !544)
!544 = !{!206, !206, !334, !206}
!545 = !{!541, !546, !547, !548}
!546 = !DILocalVariable(name: "arr", arg: 2, scope: !542, file: !2, line: 183, type: !334)
!547 = !DILocalVariable(name: "n", arg: 3, scope: !542, file: !2, line: 183, type: !206)
!548 = !DILocalVariable(name: "i", scope: !542, file: !2, line: 183, type: !206)
!549 = !DILocation(line: 0, scope: !542, inlinedAt: !550)
!550 = distinct !DILocation(line: 48, column: 3, scope: !503)
!551 = !DILocation(line: 183, column: 1, scope: !552, inlinedAt: !550)
!552 = distinct !DILexicalBlock(scope: !542, file: !2, line: 183, column: 1)
!553 = !DILocation(line: 183, column: 1, scope: !554, inlinedAt: !550)
!554 = distinct !DILexicalBlock(scope: !555, file: !2, line: 183, column: 1)
!555 = distinct !DILexicalBlock(scope: !552, file: !2, line: 183, column: 1)
!556 = !DILocation(line: 183, column: 1, scope: !555, inlinedAt: !550)
!557 = distinct !{!557, !551, !551, !375, !376}
!558 = !DILocation(line: 0, scope: !510, inlinedAt: !559)
!559 = distinct !DILocation(line: 50, column: 3, scope: !503)
!560 = !DILocation(line: 191, column: 3, scope: !510, inlinedAt: !559)
!561 = !DILocation(line: 51, column: 38, scope: !503)
!562 = !DILocation(line: 0, scope: !521, inlinedAt: !563)
!563 = distinct !DILocation(line: 51, column: 3, scope: !503)
!564 = !DILocation(line: 187, column: 1, scope: !531, inlinedAt: !563)
!565 = !DILocation(line: 187, column: 1, scope: !533, inlinedAt: !563)
!566 = !DILocation(line: 187, column: 1, scope: !534, inlinedAt: !563)
!567 = distinct !{!567, !564, !564, !375, !376}
!568 = !DILocation(line: 52, column: 1, scope: !503)
!569 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 59, type: !418, scopeLine: 59, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !570)
!570 = !{!571, !572, !573, !574, !575}
!571 = !DILocalVariable(name: "fd", arg: 1, scope: !569, file: !189, line: 59, type: !206)
!572 = !DILocalVariable(name: "vdata", arg: 2, scope: !569, file: !189, line: 59, type: !239)
!573 = !DILocalVariable(name: "data", scope: !569, file: !189, line: 60, type: !191)
!574 = !DILocalVariable(name: "p", scope: !569, file: !189, line: 61, type: !238)
!575 = !DILocalVariable(name: "s", scope: !569, file: !189, line: 61, type: !238)
!576 = !DILocation(line: 0, scope: !569)
!577 = !DILocation(line: 63, column: 7, scope: !569)
!578 = !DILocation(line: 0, scope: !430, inlinedAt: !579)
!579 = distinct !DILocation(line: 65, column: 7, scope: !569)
!580 = !DILocation(line: 64, column: 17, scope: !430, inlinedAt: !579)
!581 = !DILocation(line: 64, column: 3, scope: !430, inlinedAt: !579)
!582 = !DILocation(line: 66, column: 22, scope: !442, inlinedAt: !579)
!583 = !DILocation(line: 66, column: 26, scope: !442, inlinedAt: !579)
!584 = !DILocation(line: 66, column: 32, scope: !442, inlinedAt: !579)
!585 = !DILocation(line: 66, column: 35, scope: !442, inlinedAt: !579)
!586 = !DILocation(line: 66, column: 39, scope: !442, inlinedAt: !579)
!587 = !DILocation(line: 66, column: 9, scope: !443, inlinedAt: !579)
!588 = !DILocation(line: 69, column: 6, scope: !443, inlinedAt: !579)
!589 = !DILocation(line: 64, column: 10, scope: !430, inlinedAt: !579)
!590 = !DILocation(line: 64, column: 13, scope: !430, inlinedAt: !579)
!591 = distinct !{!591, !581, !592, !375, !376}
!592 = !DILocation(line: 70, column: 3, scope: !430, inlinedAt: !579)
!593 = !DILocation(line: 71, column: 6, scope: !455, inlinedAt: !579)
!594 = !DILocation(line: 71, column: 8, scope: !455, inlinedAt: !579)
!595 = !DILocation(line: 71, column: 6, scope: !430, inlinedAt: !579)
!596 = !DILocation(line: 66, column: 37, scope: !569)
!597 = !DILocation(line: 66, column: 3, scope: !569)
!598 = !DILocation(line: 67, column: 3, scope: !569)
!599 = !DILocation(line: 68, column: 1, scope: !569)
!600 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 70, type: !418, scopeLine: 70, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !601)
!601 = !{!602, !603, !604}
!602 = !DILocalVariable(name: "fd", arg: 1, scope: !600, file: !189, line: 70, type: !206)
!603 = !DILocalVariable(name: "vdata", arg: 2, scope: !600, file: !189, line: 70, type: !239)
!604 = !DILocalVariable(name: "data", scope: !600, file: !189, line: 71, type: !191)
!605 = !DILocation(line: 0, scope: !600)
!606 = !DILocation(line: 0, scope: !510, inlinedAt: !607)
!607 = distinct !DILocation(line: 73, column: 3, scope: !600)
!608 = !DILocation(line: 190, column: 3, scope: !517, inlinedAt: !607)
!609 = !DILocation(line: 191, column: 3, scope: !510, inlinedAt: !607)
!610 = !DILocation(line: 74, column: 38, scope: !600)
!611 = !DILocation(line: 0, scope: !521, inlinedAt: !612)
!612 = distinct !DILocation(line: 74, column: 3, scope: !600)
!613 = !DILocation(line: 187, column: 1, scope: !531, inlinedAt: !612)
!614 = !DILocation(line: 187, column: 1, scope: !533, inlinedAt: !612)
!615 = !DILocation(line: 187, column: 1, scope: !534, inlinedAt: !612)
!616 = distinct !{!616, !613, !613, !375, !376}
!617 = !DILocation(line: 75, column: 1, scope: !600)
!618 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 77, type: !619, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !621)
!619 = !DISubroutineType(types: !620)
!620 = !{!206, !239, !239}
!621 = !{!622, !623, !624, !625, !626, !627, !628}
!622 = !DILocalVariable(name: "vdata", arg: 1, scope: !618, file: !189, line: 77, type: !239)
!623 = !DILocalVariable(name: "vref", arg: 2, scope: !618, file: !189, line: 77, type: !239)
!624 = !DILocalVariable(name: "data", scope: !618, file: !189, line: 78, type: !191)
!625 = !DILocalVariable(name: "ref", scope: !618, file: !189, line: 79, type: !191)
!626 = !DILocalVariable(name: "has_errors", scope: !618, file: !189, line: 80, type: !206)
!627 = !DILocalVariable(name: "i", scope: !618, file: !189, line: 81, type: !206)
!628 = !DILocalVariable(name: "diff", scope: !618, file: !189, line: 82, type: !197)
!629 = !DILocation(line: 0, scope: !618)
!630 = !DILocation(line: 84, column: 3, scope: !631)
!631 = distinct !DILexicalBlock(scope: !618, file: !189, line: 84, column: 3)
!632 = !DILocation(line: 85, column: 12, scope: !633)
!633 = distinct !DILexicalBlock(scope: !634, file: !189, line: 84, column: 22)
!634 = distinct !DILexicalBlock(scope: !631, file: !189, line: 84, column: 3)
!635 = !DILocation(line: 85, column: 27, scope: !633)
!636 = !DILocation(line: 85, column: 25, scope: !633)
!637 = !DILocation(line: 86, column: 35, scope: !633)
!638 = !DILocation(line: 86, column: 16, scope: !633)
!639 = !DILocation(line: 84, column: 18, scope: !634)
!640 = !DILocation(line: 84, column: 13, scope: !634)
!641 = distinct !{!641, !630, !642, !375, !376}
!642 = !DILocation(line: 87, column: 3, scope: !631)
!643 = !DILocation(line: 90, column: 10, scope: !618)
!644 = !DILocation(line: 90, column: 3, scope: !618)
!645 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !646, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !648)
!646 = !DISubroutineType(types: !647)
!647 = !{!238, !206}
!648 = !{!649, !650, !651, !688, !691, !694}
!649 = !DILocalVariable(name: "fd", arg: 1, scope: !645, file: !2, line: 34, type: !206)
!650 = !DILocalVariable(name: "p", scope: !645, file: !2, line: 35, type: !238)
!651 = !DILocalVariable(name: "s", scope: !645, file: !2, line: 36, type: !652)
!652 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !653, line: 44, size: 1024, elements: !654)
!653 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!654 = !{!655, !657, !659, !661, !663, !665, !667, !668, !669, !671, !673, !674, !676, !684, !685, !686}
!655 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !652, file: !653, line: 46, baseType: !656, size: 64)
!656 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !205, line: 145, baseType: !252)
!657 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !652, file: !653, line: 47, baseType: !658, size: 64, offset: 64)
!658 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !205, line: 148, baseType: !252)
!659 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !652, file: !653, line: 48, baseType: !660, size: 32, offset: 128)
!660 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !205, line: 150, baseType: !249)
!661 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !652, file: !653, line: 49, baseType: !662, size: 32, offset: 160)
!662 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !205, line: 151, baseType: !249)
!663 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !652, file: !653, line: 50, baseType: !664, size: 32, offset: 192)
!664 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !205, line: 146, baseType: !249)
!665 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !652, file: !653, line: 51, baseType: !666, size: 32, offset: 224)
!666 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !205, line: 147, baseType: !249)
!667 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !652, file: !653, line: 52, baseType: !656, size: 64, offset: 256)
!668 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !652, file: !653, line: 53, baseType: !656, size: 64, offset: 320)
!669 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !652, file: !653, line: 54, baseType: !670, size: 64, offset: 384)
!670 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !205, line: 152, baseType: !261)
!671 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !652, file: !653, line: 55, baseType: !672, size: 32, offset: 448)
!672 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !205, line: 175, baseType: !206)
!673 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !652, file: !653, line: 56, baseType: !206, size: 32, offset: 480)
!674 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !652, file: !653, line: 57, baseType: !675, size: 64, offset: 512)
!675 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !205, line: 180, baseType: !261)
!676 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !652, file: !653, line: 65, baseType: !677, size: 128, offset: 576)
!677 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !678, line: 11, size: 128, elements: !679)
!678 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!679 = !{!680, !682}
!680 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !677, file: !678, line: 16, baseType: !681, size: 64)
!681 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !205, line: 160, baseType: !261)
!682 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !677, file: !678, line: 21, baseType: !683, size: 64, offset: 64)
!683 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !205, line: 197, baseType: !261)
!684 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !652, file: !653, line: 66, baseType: !677, size: 128, offset: 704)
!685 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !652, file: !653, line: 67, baseType: !677, size: 128, offset: 832)
!686 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !652, file: !653, line: 79, baseType: !687, size: 64, offset: 960)
!687 = !DICompositeType(tag: DW_TAG_array_type, baseType: !206, size: 64, elements: !55)
!688 = !DILocalVariable(name: "len", scope: !645, file: !2, line: 37, type: !689)
!689 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !690, line: 85, baseType: !670)
!690 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!691 = !DILocalVariable(name: "bytes_read", scope: !645, file: !2, line: 38, type: !692)
!692 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !690, line: 108, baseType: !693)
!693 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !205, line: 194, baseType: !261)
!694 = !DILocalVariable(name: "status", scope: !645, file: !2, line: 38, type: !692)
!695 = distinct !DIAssignID()
!696 = !DILocation(line: 0, scope: !645)
!697 = !DILocation(line: 36, column: 3, scope: !645)
!698 = !DILocation(line: 40, column: 3, scope: !699)
!699 = distinct !DILexicalBlock(scope: !700, file: !2, line: 40, column: 3)
!700 = distinct !DILexicalBlock(scope: !645, file: !2, line: 40, column: 3)
!701 = !DILocation(line: 41, column: 3, scope: !702)
!702 = distinct !DILexicalBlock(scope: !703, file: !2, line: 41, column: 3)
!703 = distinct !DILexicalBlock(scope: !645, file: !2, line: 41, column: 3)
!704 = !DILocation(line: 42, column: 11, scope: !645)
!705 = !DILocation(line: 43, column: 3, scope: !706)
!706 = distinct !DILexicalBlock(scope: !707, file: !2, line: 43, column: 3)
!707 = distinct !DILexicalBlock(scope: !645, file: !2, line: 43, column: 3)
!708 = !DILocation(line: 44, column: 25, scope: !645)
!709 = !DILocation(line: 44, column: 15, scope: !645)
!710 = !DILocation(line: 46, column: 3, scope: !645)
!711 = !DILocation(line: 49, column: 15, scope: !712)
!712 = distinct !DILexicalBlock(scope: !645, file: !2, line: 46, column: 27)
!713 = !DILocation(line: 46, column: 20, scope: !645)
!714 = distinct !{!714, !710, !715, !375, !376}
!715 = !DILocation(line: 50, column: 3, scope: !645)
!716 = !DILocation(line: 47, column: 24, scope: !712)
!717 = !DILocation(line: 47, column: 42, scope: !712)
!718 = !DILocation(line: 47, column: 14, scope: !712)
!719 = !DILocation(line: 48, column: 5, scope: !720)
!720 = distinct !DILexicalBlock(scope: !721, file: !2, line: 48, column: 5)
!721 = distinct !DILexicalBlock(scope: !712, file: !2, line: 48, column: 5)
!722 = !DILocation(line: 51, column: 3, scope: !645)
!723 = !DILocation(line: 51, column: 10, scope: !645)
!724 = !DILocation(line: 52, column: 3, scope: !645)
!725 = !DILocation(line: 54, column: 1, scope: !645)
!726 = !DILocation(line: 53, column: 3, scope: !645)
!727 = !DISubprogram(name: "__assert_fail", scope: !728, file: !728, line: 67, type: !729, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!728 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!729 = !DISubroutineType(types: !730)
!730 = !{null, !731, !731, !249, !731}
!731 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!732 = !DISubprogram(name: "fstat", scope: !733, file: !733, line: 210, type: !734, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!733 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!734 = !DISubroutineType(types: !735)
!735 = !{!206, !206, !736}
!736 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !652, size: 64)
!737 = !DISubprogram(name: "malloc", scope: !502, file: !502, line: 672, type: !738, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!738 = !DISubroutineType(types: !739)
!739 = !{!239, !740}
!740 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !741, line: 18, baseType: !252)
!741 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!742 = !DISubprogram(name: "read", scope: !743, file: !743, line: 371, type: !744, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!743 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!744 = !DISubroutineType(types: !745)
!745 = !{!692, !206, !239, !740}
!746 = !DISubprogram(name: "close", scope: !743, file: !743, line: 358, type: !511, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!747 = !DILocation(line: 0, scope: !430)
!748 = !DILocation(line: 59, column: 3, scope: !749)
!749 = distinct !DILexicalBlock(scope: !750, file: !2, line: 59, column: 3)
!750 = distinct !DILexicalBlock(scope: !430, file: !2, line: 59, column: 3)
!751 = !DILocation(line: 60, column: 7, scope: !752)
!752 = distinct !DILexicalBlock(scope: !430, file: !2, line: 60, column: 6)
!753 = !DILocation(line: 60, column: 6, scope: !430)
!754 = !DILocation(line: 64, column: 17, scope: !430)
!755 = !DILocation(line: 64, column: 3, scope: !430)
!756 = !DILocation(line: 66, column: 22, scope: !442)
!757 = !DILocation(line: 66, column: 26, scope: !442)
!758 = !DILocation(line: 66, column: 32, scope: !442)
!759 = !DILocation(line: 66, column: 35, scope: !442)
!760 = !DILocation(line: 66, column: 39, scope: !442)
!761 = !DILocation(line: 66, column: 9, scope: !443)
!762 = !DILocation(line: 69, column: 6, scope: !443)
!763 = !DILocation(line: 64, column: 10, scope: !430)
!764 = !DILocation(line: 64, column: 13, scope: !430)
!765 = distinct !{!765, !755, !766, !375, !376}
!766 = !DILocation(line: 70, column: 3, scope: !430)
!767 = !DILocation(line: 71, column: 6, scope: !455)
!768 = !DILocation(line: 71, column: 8, scope: !455)
!769 = !DILocation(line: 71, column: 6, scope: !430)
!770 = !DILocation(line: 74, column: 1, scope: !430)
!771 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !772, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !774)
!772 = !DISubroutineType(types: !773)
!773 = !{!206, !238, !238, !206}
!774 = !{!775, !776, !777, !778}
!775 = !DILocalVariable(name: "s", arg: 1, scope: !771, file: !2, line: 77, type: !238)
!776 = !DILocalVariable(name: "arr", arg: 2, scope: !771, file: !2, line: 77, type: !238)
!777 = !DILocalVariable(name: "n", arg: 3, scope: !771, file: !2, line: 77, type: !206)
!778 = !DILocalVariable(name: "k", scope: !771, file: !2, line: 78, type: !206)
!779 = !DILocation(line: 0, scope: !771)
!780 = !DILocation(line: 79, column: 3, scope: !781)
!781 = distinct !DILexicalBlock(scope: !782, file: !2, line: 79, column: 3)
!782 = distinct !DILexicalBlock(scope: !771, file: !2, line: 79, column: 3)
!783 = !DILocation(line: 81, column: 8, scope: !784)
!784 = distinct !DILexicalBlock(scope: !771, file: !2, line: 81, column: 7)
!785 = !DILocation(line: 81, column: 7, scope: !771)
!786 = !DILocation(line: 83, column: 12, scope: !787)
!787 = distinct !DILexicalBlock(scope: !784, file: !2, line: 81, column: 13)
!788 = !DILocation(line: 83, column: 5, scope: !787)
!789 = !DILocation(line: 91, column: 19, scope: !771)
!790 = !DILocation(line: 91, column: 3, scope: !771)
!791 = !DILocation(line: 92, column: 7, scope: !771)
!792 = !DILocation(line: 83, column: 16, scope: !787)
!793 = !DILocation(line: 83, column: 26, scope: !787)
!794 = !DILocation(line: 83, column: 32, scope: !787)
!795 = !DILocation(line: 83, column: 29, scope: !787)
!796 = !DILocation(line: 83, column: 35, scope: !787)
!797 = !DILocation(line: 83, column: 45, scope: !787)
!798 = !DILocation(line: 83, column: 48, scope: !787)
!799 = !DILocation(line: 83, column: 54, scope: !787)
!800 = !DILocation(line: 84, column: 9, scope: !787)
!801 = !DILocation(line: 84, column: 18, scope: !787)
!802 = !DILocation(line: 84, column: 26, scope: !787)
!803 = distinct !{!803, !788, !804, !375, !376}
!804 = !DILocation(line: 86, column: 5, scope: !787)
!805 = !DILocation(line: 93, column: 5, scope: !806)
!806 = distinct !DILexicalBlock(scope: !771, file: !2, line: 92, column: 7)
!807 = !DILocation(line: 93, column: 12, scope: !806)
!808 = !DILocation(line: 95, column: 3, scope: !771)
!809 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !810, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !813)
!810 = !DISubroutineType(types: !811)
!811 = !{!206, !238, !812, !206}
!812 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !240, size: 64)
!813 = !{!814, !815, !816, !817, !818, !819, !820}
!814 = !DILocalVariable(name: "s", arg: 1, scope: !809, file: !2, line: 132, type: !238)
!815 = !DILocalVariable(name: "arr", arg: 2, scope: !809, file: !2, line: 132, type: !812)
!816 = !DILocalVariable(name: "n", arg: 3, scope: !809, file: !2, line: 132, type: !206)
!817 = !DILocalVariable(name: "line", scope: !809, file: !2, line: 132, type: !238)
!818 = !DILocalVariable(name: "endptr", scope: !809, file: !2, line: 132, type: !238)
!819 = !DILocalVariable(name: "i", scope: !809, file: !2, line: 132, type: !206)
!820 = !DILocalVariable(name: "v", scope: !809, file: !2, line: 132, type: !240)
!821 = distinct !DIAssignID()
!822 = !DILocation(line: 0, scope: !809)
!823 = !DILocation(line: 132, column: 1, scope: !809)
!824 = !DILocation(line: 132, column: 1, scope: !825)
!825 = distinct !DILexicalBlock(scope: !826, file: !2, line: 132, column: 1)
!826 = distinct !DILexicalBlock(scope: !809, file: !2, line: 132, column: 1)
!827 = !DILocation(line: 132, column: 1, scope: !828)
!828 = distinct !DILexicalBlock(scope: !809, file: !2, line: 132, column: 1)
!829 = !{!830, !830, i64 0}
!830 = !{!"any pointer", !363, i64 0}
!831 = distinct !DIAssignID()
!832 = !DILocation(line: 132, column: 1, scope: !833)
!833 = distinct !DILexicalBlock(scope: !828, file: !2, line: 132, column: 1)
!834 = !DILocation(line: 132, column: 1, scope: !835)
!835 = distinct !DILexicalBlock(scope: !833, file: !2, line: 132, column: 1)
!836 = distinct !{!836, !823, !823, !375, !376}
!837 = !DILocation(line: 132, column: 1, scope: !838)
!838 = distinct !DILexicalBlock(scope: !839, file: !2, line: 132, column: 1)
!839 = distinct !DILexicalBlock(scope: !809, file: !2, line: 132, column: 1)
!840 = !DISubprogram(name: "strtok", scope: !841, file: !841, line: 356, type: !842, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!841 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!842 = !DISubroutineType(types: !843)
!843 = !{!238, !844, !845}
!844 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !238)
!845 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !731)
!846 = !DISubprogram(name: "strtol", scope: !502, file: !502, line: 177, type: !847, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!847 = !DISubroutineType(types: !848)
!848 = !{!261, !845, !849, !206}
!849 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !850)
!850 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !238, size: 64)
!851 = !DISubprogram(name: "fprintf", scope: !852, file: !852, line: 357, type: !853, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!852 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!853 = !DISubroutineType(types: !854)
!854 = !{!206, !855, !845, null}
!855 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !856)
!856 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !857, size: 64)
!857 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !858, line: 7, baseType: !859)
!858 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!859 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !860, line: 49, size: 1728, elements: !861)
!860 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!861 = !{!862, !863, !864, !865, !866, !867, !868, !869, !870, !871, !872, !873, !874, !877, !879, !880, !881, !882, !883, !884, !888, !891, !893, !896, !899, !900, !901, !903, !904}
!862 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !859, file: !860, line: 51, baseType: !206, size: 32)
!863 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !859, file: !860, line: 54, baseType: !238, size: 64, offset: 64)
!864 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !859, file: !860, line: 55, baseType: !238, size: 64, offset: 128)
!865 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !859, file: !860, line: 56, baseType: !238, size: 64, offset: 192)
!866 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !859, file: !860, line: 57, baseType: !238, size: 64, offset: 256)
!867 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !859, file: !860, line: 58, baseType: !238, size: 64, offset: 320)
!868 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !859, file: !860, line: 59, baseType: !238, size: 64, offset: 384)
!869 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !859, file: !860, line: 60, baseType: !238, size: 64, offset: 448)
!870 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !859, file: !860, line: 61, baseType: !238, size: 64, offset: 512)
!871 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !859, file: !860, line: 64, baseType: !238, size: 64, offset: 576)
!872 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !859, file: !860, line: 65, baseType: !238, size: 64, offset: 640)
!873 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !859, file: !860, line: 66, baseType: !238, size: 64, offset: 704)
!874 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !859, file: !860, line: 68, baseType: !875, size: 64, offset: 768)
!875 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !876, size: 64)
!876 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !860, line: 36, flags: DIFlagFwdDecl)
!877 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !859, file: !860, line: 70, baseType: !878, size: 64, offset: 832)
!878 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !859, size: 64)
!879 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !859, file: !860, line: 72, baseType: !206, size: 32, offset: 896)
!880 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !859, file: !860, line: 73, baseType: !206, size: 32, offset: 928)
!881 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !859, file: !860, line: 74, baseType: !670, size: 64, offset: 960)
!882 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !859, file: !860, line: 77, baseType: !246, size: 16, offset: 1024)
!883 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !859, file: !860, line: 78, baseType: !255, size: 8, offset: 1040)
!884 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !859, file: !860, line: 79, baseType: !885, size: 8, offset: 1048)
!885 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !886)
!886 = !{!887}
!887 = !DISubrange(count: 1)
!888 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !859, file: !860, line: 81, baseType: !889, size: 64, offset: 1088)
!889 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !890, size: 64)
!890 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !860, line: 43, baseType: null)
!891 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !859, file: !860, line: 89, baseType: !892, size: 64, offset: 1152)
!892 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !205, line: 153, baseType: !261)
!893 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !859, file: !860, line: 91, baseType: !894, size: 64, offset: 1216)
!894 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !895, size: 64)
!895 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !860, line: 37, flags: DIFlagFwdDecl)
!896 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !859, file: !860, line: 92, baseType: !897, size: 64, offset: 1280)
!897 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !898, size: 64)
!898 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !860, line: 38, flags: DIFlagFwdDecl)
!899 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !859, file: !860, line: 93, baseType: !878, size: 64, offset: 1344)
!900 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !859, file: !860, line: 94, baseType: !239, size: 64, offset: 1408)
!901 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !859, file: !860, line: 95, baseType: !902, size: 64, offset: 1472)
!902 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !878, size: 64)
!903 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !859, file: !860, line: 96, baseType: !206, size: 32, offset: 1536)
!904 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !859, file: !860, line: 98, baseType: !905, size: 160, offset: 1568)
!905 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!906 = !DISubprogram(name: "strlen", scope: !841, file: !841, line: 407, type: !907, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!907 = !DISubroutineType(types: !908)
!908 = !{!252, !731}
!909 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !910, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !913)
!910 = !DISubroutineType(types: !911)
!911 = !{!206, !238, !912, !206}
!912 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !244, size: 64)
!913 = !{!914, !915, !916, !917, !918, !919, !920}
!914 = !DILocalVariable(name: "s", arg: 1, scope: !909, file: !2, line: 133, type: !238)
!915 = !DILocalVariable(name: "arr", arg: 2, scope: !909, file: !2, line: 133, type: !912)
!916 = !DILocalVariable(name: "n", arg: 3, scope: !909, file: !2, line: 133, type: !206)
!917 = !DILocalVariable(name: "line", scope: !909, file: !2, line: 133, type: !238)
!918 = !DILocalVariable(name: "endptr", scope: !909, file: !2, line: 133, type: !238)
!919 = !DILocalVariable(name: "i", scope: !909, file: !2, line: 133, type: !206)
!920 = !DILocalVariable(name: "v", scope: !909, file: !2, line: 133, type: !244)
!921 = distinct !DIAssignID()
!922 = !DILocation(line: 0, scope: !909)
!923 = !DILocation(line: 133, column: 1, scope: !909)
!924 = !DILocation(line: 133, column: 1, scope: !925)
!925 = distinct !DILexicalBlock(scope: !926, file: !2, line: 133, column: 1)
!926 = distinct !DILexicalBlock(scope: !909, file: !2, line: 133, column: 1)
!927 = !DILocation(line: 133, column: 1, scope: !928)
!928 = distinct !DILexicalBlock(scope: !909, file: !2, line: 133, column: 1)
!929 = distinct !DIAssignID()
!930 = !DILocation(line: 133, column: 1, scope: !931)
!931 = distinct !DILexicalBlock(scope: !928, file: !2, line: 133, column: 1)
!932 = !DILocation(line: 133, column: 1, scope: !933)
!933 = distinct !DILexicalBlock(scope: !931, file: !2, line: 133, column: 1)
!934 = !{!935, !935, i64 0}
!935 = !{!"short", !363, i64 0}
!936 = distinct !{!936, !923, !923, !375, !376}
!937 = !DILocation(line: 133, column: 1, scope: !938)
!938 = distinct !DILexicalBlock(scope: !939, file: !2, line: 133, column: 1)
!939 = distinct !DILexicalBlock(scope: !909, file: !2, line: 133, column: 1)
!940 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !941, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !944)
!941 = !DISubroutineType(types: !942)
!942 = !{!206, !238, !943, !206}
!943 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !247, size: 64)
!944 = !{!945, !946, !947, !948, !949, !950, !951}
!945 = !DILocalVariable(name: "s", arg: 1, scope: !940, file: !2, line: 134, type: !238)
!946 = !DILocalVariable(name: "arr", arg: 2, scope: !940, file: !2, line: 134, type: !943)
!947 = !DILocalVariable(name: "n", arg: 3, scope: !940, file: !2, line: 134, type: !206)
!948 = !DILocalVariable(name: "line", scope: !940, file: !2, line: 134, type: !238)
!949 = !DILocalVariable(name: "endptr", scope: !940, file: !2, line: 134, type: !238)
!950 = !DILocalVariable(name: "i", scope: !940, file: !2, line: 134, type: !206)
!951 = !DILocalVariable(name: "v", scope: !940, file: !2, line: 134, type: !247)
!952 = distinct !DIAssignID()
!953 = !DILocation(line: 0, scope: !940)
!954 = !DILocation(line: 134, column: 1, scope: !940)
!955 = !DILocation(line: 134, column: 1, scope: !956)
!956 = distinct !DILexicalBlock(scope: !957, file: !2, line: 134, column: 1)
!957 = distinct !DILexicalBlock(scope: !940, file: !2, line: 134, column: 1)
!958 = !DILocation(line: 134, column: 1, scope: !959)
!959 = distinct !DILexicalBlock(scope: !940, file: !2, line: 134, column: 1)
!960 = distinct !DIAssignID()
!961 = !DILocation(line: 134, column: 1, scope: !962)
!962 = distinct !DILexicalBlock(scope: !959, file: !2, line: 134, column: 1)
!963 = !DILocation(line: 134, column: 1, scope: !964)
!964 = distinct !DILexicalBlock(scope: !962, file: !2, line: 134, column: 1)
!965 = distinct !{!965, !954, !954, !375, !376}
!966 = !DILocation(line: 134, column: 1, scope: !967)
!967 = distinct !DILexicalBlock(scope: !968, file: !2, line: 134, column: 1)
!968 = distinct !DILexicalBlock(scope: !940, file: !2, line: 134, column: 1)
!969 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !970, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !973)
!970 = !DISubroutineType(types: !971)
!971 = !{!206, !238, !972, !206}
!972 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !250, size: 64)
!973 = !{!974, !975, !976, !977, !978, !979, !980}
!974 = !DILocalVariable(name: "s", arg: 1, scope: !969, file: !2, line: 135, type: !238)
!975 = !DILocalVariable(name: "arr", arg: 2, scope: !969, file: !2, line: 135, type: !972)
!976 = !DILocalVariable(name: "n", arg: 3, scope: !969, file: !2, line: 135, type: !206)
!977 = !DILocalVariable(name: "line", scope: !969, file: !2, line: 135, type: !238)
!978 = !DILocalVariable(name: "endptr", scope: !969, file: !2, line: 135, type: !238)
!979 = !DILocalVariable(name: "i", scope: !969, file: !2, line: 135, type: !206)
!980 = !DILocalVariable(name: "v", scope: !969, file: !2, line: 135, type: !250)
!981 = distinct !DIAssignID()
!982 = !DILocation(line: 0, scope: !969)
!983 = !DILocation(line: 135, column: 1, scope: !969)
!984 = !DILocation(line: 135, column: 1, scope: !985)
!985 = distinct !DILexicalBlock(scope: !986, file: !2, line: 135, column: 1)
!986 = distinct !DILexicalBlock(scope: !969, file: !2, line: 135, column: 1)
!987 = !DILocation(line: 135, column: 1, scope: !988)
!988 = distinct !DILexicalBlock(scope: !969, file: !2, line: 135, column: 1)
!989 = distinct !DIAssignID()
!990 = !DILocation(line: 135, column: 1, scope: !991)
!991 = distinct !DILexicalBlock(scope: !988, file: !2, line: 135, column: 1)
!992 = !DILocation(line: 135, column: 1, scope: !993)
!993 = distinct !DILexicalBlock(scope: !991, file: !2, line: 135, column: 1)
!994 = !{!995, !995, i64 0}
!995 = !{!"long", !363, i64 0}
!996 = distinct !{!996, !983, !983, !375, !376}
!997 = !DILocation(line: 135, column: 1, scope: !998)
!998 = distinct !DILexicalBlock(scope: !999, file: !2, line: 135, column: 1)
!999 = distinct !DILexicalBlock(scope: !969, file: !2, line: 135, column: 1)
!1000 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1001, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1004)
!1001 = !DISubroutineType(types: !1002)
!1002 = !{!206, !238, !1003, !206}
!1003 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !253, size: 64)
!1004 = !{!1005, !1006, !1007, !1008, !1009, !1010, !1011}
!1005 = !DILocalVariable(name: "s", arg: 1, scope: !1000, file: !2, line: 136, type: !238)
!1006 = !DILocalVariable(name: "arr", arg: 2, scope: !1000, file: !2, line: 136, type: !1003)
!1007 = !DILocalVariable(name: "n", arg: 3, scope: !1000, file: !2, line: 136, type: !206)
!1008 = !DILocalVariable(name: "line", scope: !1000, file: !2, line: 136, type: !238)
!1009 = !DILocalVariable(name: "endptr", scope: !1000, file: !2, line: 136, type: !238)
!1010 = !DILocalVariable(name: "i", scope: !1000, file: !2, line: 136, type: !206)
!1011 = !DILocalVariable(name: "v", scope: !1000, file: !2, line: 136, type: !253)
!1012 = distinct !DIAssignID()
!1013 = !DILocation(line: 0, scope: !1000)
!1014 = !DILocation(line: 136, column: 1, scope: !1000)
!1015 = !DILocation(line: 136, column: 1, scope: !1016)
!1016 = distinct !DILexicalBlock(scope: !1017, file: !2, line: 136, column: 1)
!1017 = distinct !DILexicalBlock(scope: !1000, file: !2, line: 136, column: 1)
!1018 = !DILocation(line: 136, column: 1, scope: !1019)
!1019 = distinct !DILexicalBlock(scope: !1000, file: !2, line: 136, column: 1)
!1020 = distinct !DIAssignID()
!1021 = !DILocation(line: 136, column: 1, scope: !1022)
!1022 = distinct !DILexicalBlock(scope: !1019, file: !2, line: 136, column: 1)
!1023 = !DILocation(line: 136, column: 1, scope: !1024)
!1024 = distinct !DILexicalBlock(scope: !1022, file: !2, line: 136, column: 1)
!1025 = distinct !{!1025, !1014, !1014, !375, !376}
!1026 = !DILocation(line: 136, column: 1, scope: !1027)
!1027 = distinct !DILexicalBlock(scope: !1028, file: !2, line: 136, column: 1)
!1028 = distinct !DILexicalBlock(scope: !1000, file: !2, line: 136, column: 1)
!1029 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1030, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1033)
!1030 = !DISubroutineType(types: !1031)
!1031 = !{!206, !238, !1032, !206}
!1032 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !256, size: 64)
!1033 = !{!1034, !1035, !1036, !1037, !1038, !1039, !1040}
!1034 = !DILocalVariable(name: "s", arg: 1, scope: !1029, file: !2, line: 137, type: !238)
!1035 = !DILocalVariable(name: "arr", arg: 2, scope: !1029, file: !2, line: 137, type: !1032)
!1036 = !DILocalVariable(name: "n", arg: 3, scope: !1029, file: !2, line: 137, type: !206)
!1037 = !DILocalVariable(name: "line", scope: !1029, file: !2, line: 137, type: !238)
!1038 = !DILocalVariable(name: "endptr", scope: !1029, file: !2, line: 137, type: !238)
!1039 = !DILocalVariable(name: "i", scope: !1029, file: !2, line: 137, type: !206)
!1040 = !DILocalVariable(name: "v", scope: !1029, file: !2, line: 137, type: !256)
!1041 = distinct !DIAssignID()
!1042 = !DILocation(line: 0, scope: !1029)
!1043 = !DILocation(line: 137, column: 1, scope: !1029)
!1044 = !DILocation(line: 137, column: 1, scope: !1045)
!1045 = distinct !DILexicalBlock(scope: !1046, file: !2, line: 137, column: 1)
!1046 = distinct !DILexicalBlock(scope: !1029, file: !2, line: 137, column: 1)
!1047 = !DILocation(line: 137, column: 1, scope: !1048)
!1048 = distinct !DILexicalBlock(scope: !1029, file: !2, line: 137, column: 1)
!1049 = distinct !DIAssignID()
!1050 = !DILocation(line: 137, column: 1, scope: !1051)
!1051 = distinct !DILexicalBlock(scope: !1048, file: !2, line: 137, column: 1)
!1052 = !DILocation(line: 137, column: 1, scope: !1053)
!1053 = distinct !DILexicalBlock(scope: !1051, file: !2, line: 137, column: 1)
!1054 = distinct !{!1054, !1043, !1043, !375, !376}
!1055 = !DILocation(line: 137, column: 1, scope: !1056)
!1056 = distinct !DILexicalBlock(scope: !1057, file: !2, line: 137, column: 1)
!1057 = distinct !DILexicalBlock(scope: !1029, file: !2, line: 137, column: 1)
!1058 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1059, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1061)
!1059 = !DISubroutineType(types: !1060)
!1060 = !{!206, !238, !334, !206}
!1061 = !{!1062, !1063, !1064, !1065, !1066, !1067, !1068}
!1062 = !DILocalVariable(name: "s", arg: 1, scope: !1058, file: !2, line: 138, type: !238)
!1063 = !DILocalVariable(name: "arr", arg: 2, scope: !1058, file: !2, line: 138, type: !334)
!1064 = !DILocalVariable(name: "n", arg: 3, scope: !1058, file: !2, line: 138, type: !206)
!1065 = !DILocalVariable(name: "line", scope: !1058, file: !2, line: 138, type: !238)
!1066 = !DILocalVariable(name: "endptr", scope: !1058, file: !2, line: 138, type: !238)
!1067 = !DILocalVariable(name: "i", scope: !1058, file: !2, line: 138, type: !206)
!1068 = !DILocalVariable(name: "v", scope: !1058, file: !2, line: 138, type: !202)
!1069 = distinct !DIAssignID()
!1070 = !DILocation(line: 0, scope: !1058)
!1071 = !DILocation(line: 138, column: 1, scope: !1058)
!1072 = !DILocation(line: 138, column: 1, scope: !1073)
!1073 = distinct !DILexicalBlock(scope: !1074, file: !2, line: 138, column: 1)
!1074 = distinct !DILexicalBlock(scope: !1058, file: !2, line: 138, column: 1)
!1075 = !DILocation(line: 138, column: 1, scope: !1076)
!1076 = distinct !DILexicalBlock(scope: !1058, file: !2, line: 138, column: 1)
!1077 = distinct !DIAssignID()
!1078 = !DILocation(line: 138, column: 1, scope: !1079)
!1079 = distinct !DILexicalBlock(scope: !1076, file: !2, line: 138, column: 1)
!1080 = !DILocation(line: 138, column: 1, scope: !1081)
!1081 = distinct !DILexicalBlock(scope: !1079, file: !2, line: 138, column: 1)
!1082 = distinct !{!1082, !1071, !1071, !375, !376}
!1083 = !DILocation(line: 138, column: 1, scope: !1084)
!1084 = distinct !DILexicalBlock(scope: !1085, file: !2, line: 138, column: 1)
!1085 = distinct !DILexicalBlock(scope: !1058, file: !2, line: 138, column: 1)
!1086 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1087, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1090)
!1087 = !DISubroutineType(types: !1088)
!1088 = !{!206, !238, !1089, !206}
!1089 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !259, size: 64)
!1090 = !{!1091, !1092, !1093, !1094, !1095, !1096, !1097}
!1091 = !DILocalVariable(name: "s", arg: 1, scope: !1086, file: !2, line: 139, type: !238)
!1092 = !DILocalVariable(name: "arr", arg: 2, scope: !1086, file: !2, line: 139, type: !1089)
!1093 = !DILocalVariable(name: "n", arg: 3, scope: !1086, file: !2, line: 139, type: !206)
!1094 = !DILocalVariable(name: "line", scope: !1086, file: !2, line: 139, type: !238)
!1095 = !DILocalVariable(name: "endptr", scope: !1086, file: !2, line: 139, type: !238)
!1096 = !DILocalVariable(name: "i", scope: !1086, file: !2, line: 139, type: !206)
!1097 = !DILocalVariable(name: "v", scope: !1086, file: !2, line: 139, type: !259)
!1098 = distinct !DIAssignID()
!1099 = !DILocation(line: 0, scope: !1086)
!1100 = !DILocation(line: 139, column: 1, scope: !1086)
!1101 = !DILocation(line: 139, column: 1, scope: !1102)
!1102 = distinct !DILexicalBlock(scope: !1103, file: !2, line: 139, column: 1)
!1103 = distinct !DILexicalBlock(scope: !1086, file: !2, line: 139, column: 1)
!1104 = !DILocation(line: 139, column: 1, scope: !1105)
!1105 = distinct !DILexicalBlock(scope: !1086, file: !2, line: 139, column: 1)
!1106 = distinct !DIAssignID()
!1107 = !DILocation(line: 139, column: 1, scope: !1108)
!1108 = distinct !DILexicalBlock(scope: !1105, file: !2, line: 139, column: 1)
!1109 = !DILocation(line: 139, column: 1, scope: !1110)
!1110 = distinct !DILexicalBlock(scope: !1108, file: !2, line: 139, column: 1)
!1111 = distinct !{!1111, !1100, !1100, !375, !376}
!1112 = !DILocation(line: 139, column: 1, scope: !1113)
!1113 = distinct !DILexicalBlock(scope: !1114, file: !2, line: 139, column: 1)
!1114 = distinct !DILexicalBlock(scope: !1086, file: !2, line: 139, column: 1)
!1115 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1116, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1119)
!1116 = !DISubroutineType(types: !1117)
!1117 = !{!206, !238, !1118, !206}
!1118 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !262, size: 64)
!1119 = !{!1120, !1121, !1122, !1123, !1124, !1125, !1126}
!1120 = !DILocalVariable(name: "s", arg: 1, scope: !1115, file: !2, line: 141, type: !238)
!1121 = !DILocalVariable(name: "arr", arg: 2, scope: !1115, file: !2, line: 141, type: !1118)
!1122 = !DILocalVariable(name: "n", arg: 3, scope: !1115, file: !2, line: 141, type: !206)
!1123 = !DILocalVariable(name: "line", scope: !1115, file: !2, line: 141, type: !238)
!1124 = !DILocalVariable(name: "endptr", scope: !1115, file: !2, line: 141, type: !238)
!1125 = !DILocalVariable(name: "i", scope: !1115, file: !2, line: 141, type: !206)
!1126 = !DILocalVariable(name: "v", scope: !1115, file: !2, line: 141, type: !262)
!1127 = distinct !DIAssignID()
!1128 = !DILocation(line: 0, scope: !1115)
!1129 = !DILocation(line: 141, column: 1, scope: !1115)
!1130 = !DILocation(line: 141, column: 1, scope: !1131)
!1131 = distinct !DILexicalBlock(scope: !1132, file: !2, line: 141, column: 1)
!1132 = distinct !DILexicalBlock(scope: !1115, file: !2, line: 141, column: 1)
!1133 = !DILocation(line: 141, column: 1, scope: !1134)
!1134 = distinct !DILexicalBlock(scope: !1115, file: !2, line: 141, column: 1)
!1135 = distinct !DIAssignID()
!1136 = !DILocation(line: 141, column: 1, scope: !1137)
!1137 = distinct !DILexicalBlock(scope: !1134, file: !2, line: 141, column: 1)
!1138 = !DILocation(line: 141, column: 1, scope: !1139)
!1139 = distinct !DILexicalBlock(scope: !1137, file: !2, line: 141, column: 1)
!1140 = !{!1141, !1141, i64 0}
!1141 = !{!"float", !363, i64 0}
!1142 = distinct !{!1142, !1129, !1129, !375, !376}
!1143 = !DILocation(line: 141, column: 1, scope: !1144)
!1144 = distinct !DILexicalBlock(scope: !1145, file: !2, line: 141, column: 1)
!1145 = distinct !DILexicalBlock(scope: !1115, file: !2, line: 141, column: 1)
!1146 = !DISubprogram(name: "strtof", scope: !502, file: !502, line: 124, type: !1147, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1147 = !DISubroutineType(types: !1148)
!1148 = !{!262, !845, !849}
!1149 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1150, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1152)
!1150 = !DISubroutineType(types: !1151)
!1151 = !{!206, !238, !333, !206}
!1152 = !{!1153, !1154, !1155, !1156, !1157, !1158, !1159}
!1153 = !DILocalVariable(name: "s", arg: 1, scope: !1149, file: !2, line: 142, type: !238)
!1154 = !DILocalVariable(name: "arr", arg: 2, scope: !1149, file: !2, line: 142, type: !333)
!1155 = !DILocalVariable(name: "n", arg: 3, scope: !1149, file: !2, line: 142, type: !206)
!1156 = !DILocalVariable(name: "line", scope: !1149, file: !2, line: 142, type: !238)
!1157 = !DILocalVariable(name: "endptr", scope: !1149, file: !2, line: 142, type: !238)
!1158 = !DILocalVariable(name: "i", scope: !1149, file: !2, line: 142, type: !206)
!1159 = !DILocalVariable(name: "v", scope: !1149, file: !2, line: 142, type: !197)
!1160 = distinct !DIAssignID()
!1161 = !DILocation(line: 0, scope: !1149)
!1162 = !DILocation(line: 142, column: 1, scope: !1149)
!1163 = !DILocation(line: 142, column: 1, scope: !1164)
!1164 = distinct !DILexicalBlock(scope: !1165, file: !2, line: 142, column: 1)
!1165 = distinct !DILexicalBlock(scope: !1149, file: !2, line: 142, column: 1)
!1166 = !DILocation(line: 142, column: 1, scope: !1167)
!1167 = distinct !DILexicalBlock(scope: !1149, file: !2, line: 142, column: 1)
!1168 = distinct !DIAssignID()
!1169 = !DILocation(line: 142, column: 1, scope: !1170)
!1170 = distinct !DILexicalBlock(scope: !1167, file: !2, line: 142, column: 1)
!1171 = !DILocation(line: 142, column: 1, scope: !1172)
!1172 = distinct !DILexicalBlock(scope: !1170, file: !2, line: 142, column: 1)
!1173 = distinct !{!1173, !1162, !1162, !375, !376}
!1174 = !DILocation(line: 142, column: 1, scope: !1175)
!1175 = distinct !DILexicalBlock(scope: !1176, file: !2, line: 142, column: 1)
!1176 = distinct !DILexicalBlock(scope: !1149, file: !2, line: 142, column: 1)
!1177 = !DISubprogram(name: "strtod", scope: !502, file: !502, line: 118, type: !1178, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1178 = !DISubroutineType(types: !1179)
!1179 = !{!197, !845, !849}
!1180 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1181, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1183)
!1181 = !DISubroutineType(types: !1182)
!1182 = !{!206, !206, !238, !206}
!1183 = !{!1184, !1185, !1186, !1187, !1188}
!1184 = !DILocalVariable(name: "fd", arg: 1, scope: !1180, file: !2, line: 145, type: !206)
!1185 = !DILocalVariable(name: "arr", arg: 2, scope: !1180, file: !2, line: 145, type: !238)
!1186 = !DILocalVariable(name: "n", arg: 3, scope: !1180, file: !2, line: 145, type: !206)
!1187 = !DILocalVariable(name: "status", scope: !1180, file: !2, line: 146, type: !206)
!1188 = !DILocalVariable(name: "written", scope: !1180, file: !2, line: 146, type: !206)
!1189 = !DILocation(line: 0, scope: !1180)
!1190 = !DILocation(line: 147, column: 3, scope: !1191)
!1191 = distinct !DILexicalBlock(scope: !1192, file: !2, line: 147, column: 3)
!1192 = distinct !DILexicalBlock(scope: !1180, file: !2, line: 147, column: 3)
!1193 = !DILocation(line: 148, column: 8, scope: !1194)
!1194 = distinct !DILexicalBlock(scope: !1180, file: !2, line: 148, column: 7)
!1195 = !DILocation(line: 148, column: 7, scope: !1180)
!1196 = !DILocation(line: 149, column: 9, scope: !1197)
!1197 = distinct !DILexicalBlock(scope: !1194, file: !2, line: 148, column: 13)
!1198 = !DILocation(line: 150, column: 3, scope: !1197)
!1199 = !DILocation(line: 152, column: 16, scope: !1180)
!1200 = !DILocation(line: 152, column: 3, scope: !1180)
!1201 = !DILocation(line: 158, column: 3, scope: !1180)
!1202 = !DILocation(line: 155, column: 13, scope: !1203)
!1203 = distinct !DILexicalBlock(scope: !1180, file: !2, line: 152, column: 20)
!1204 = distinct !{!1204, !1200, !1205, !375, !376}
!1205 = !DILocation(line: 156, column: 3, scope: !1180)
!1206 = !DILocation(line: 153, column: 25, scope: !1203)
!1207 = !DILocation(line: 153, column: 40, scope: !1203)
!1208 = !DILocation(line: 153, column: 39, scope: !1203)
!1209 = !DILocation(line: 153, column: 14, scope: !1203)
!1210 = !DILocation(line: 154, column: 5, scope: !1211)
!1211 = distinct !DILexicalBlock(scope: !1212, file: !2, line: 154, column: 5)
!1212 = distinct !DILexicalBlock(scope: !1203, file: !2, line: 154, column: 5)
!1213 = !DILocation(line: 159, column: 14, scope: !1214)
!1214 = distinct !DILexicalBlock(scope: !1180, file: !2, line: 158, column: 6)
!1215 = !DILocation(line: 160, column: 5, scope: !1216)
!1216 = distinct !DILexicalBlock(scope: !1217, file: !2, line: 160, column: 5)
!1217 = distinct !DILexicalBlock(scope: !1214, file: !2, line: 160, column: 5)
!1218 = !DILocation(line: 161, column: 17, scope: !1180)
!1219 = !DILocation(line: 161, column: 3, scope: !1214)
!1220 = distinct !{!1220, !1201, !1221, !375, !376}
!1221 = !DILocation(line: 161, column: 20, scope: !1180)
!1222 = !DILocation(line: 163, column: 3, scope: !1180)
!1223 = !DISubprogram(name: "write", scope: !743, file: !743, line: 378, type: !1224, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1224 = !DISubroutineType(types: !1225)
!1225 = !{!692, !206, !1226, !740}
!1226 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1227, size: 64)
!1227 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1228 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1229, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1231)
!1229 = !DISubroutineType(types: !1230)
!1230 = !{!206, !206, !812, !206}
!1231 = !{!1232, !1233, !1234, !1235}
!1232 = !DILocalVariable(name: "fd", arg: 1, scope: !1228, file: !2, line: 177, type: !206)
!1233 = !DILocalVariable(name: "arr", arg: 2, scope: !1228, file: !2, line: 177, type: !812)
!1234 = !DILocalVariable(name: "n", arg: 3, scope: !1228, file: !2, line: 177, type: !206)
!1235 = !DILocalVariable(name: "i", scope: !1228, file: !2, line: 177, type: !206)
!1236 = !DILocation(line: 0, scope: !1228)
!1237 = !DILocation(line: 177, column: 1, scope: !1238)
!1238 = distinct !DILexicalBlock(scope: !1239, file: !2, line: 177, column: 1)
!1239 = distinct !DILexicalBlock(scope: !1228, file: !2, line: 177, column: 1)
!1240 = !DILocation(line: 177, column: 1, scope: !1241)
!1241 = distinct !DILexicalBlock(scope: !1242, file: !2, line: 177, column: 1)
!1242 = distinct !DILexicalBlock(scope: !1228, file: !2, line: 177, column: 1)
!1243 = !DILocation(line: 177, column: 1, scope: !1242)
!1244 = !DILocation(line: 177, column: 1, scope: !1245)
!1245 = distinct !DILexicalBlock(scope: !1241, file: !2, line: 177, column: 1)
!1246 = distinct !{!1246, !1243, !1243, !375, !376}
!1247 = !DILocation(line: 177, column: 1, scope: !1228)
!1248 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1249, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1251)
!1249 = !DISubroutineType(cc: DW_CC_nocall, types: !1250)
!1250 = !{!206, !206, !731, null}
!1251 = !{!1252, !1253, !1254, !1258, !1259, !1260, !1261}
!1252 = !DILocalVariable(name: "fd", arg: 1, scope: !1248, file: !2, line: 15, type: !206)
!1253 = !DILocalVariable(name: "format", arg: 2, scope: !1248, file: !2, line: 15, type: !731)
!1254 = !DILocalVariable(name: "args", scope: !1248, file: !2, line: 16, type: !1255)
!1255 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1256, line: 12, baseType: !1257)
!1256 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1257 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !239)
!1258 = !DILocalVariable(name: "buffered", scope: !1248, file: !2, line: 17, type: !206)
!1259 = !DILocalVariable(name: "written", scope: !1248, file: !2, line: 17, type: !206)
!1260 = !DILocalVariable(name: "status", scope: !1248, file: !2, line: 17, type: !206)
!1261 = !DILocalVariable(name: "buffer", scope: !1248, file: !2, line: 18, type: !1262)
!1262 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !1263)
!1263 = !{!1264}
!1264 = !DISubrange(count: 256)
!1265 = distinct !DIAssignID()
!1266 = !DILocation(line: 0, scope: !1248)
!1267 = distinct !DIAssignID()
!1268 = !DILocation(line: 16, column: 3, scope: !1248)
!1269 = !DILocation(line: 18, column: 3, scope: !1248)
!1270 = !DILocation(line: 19, column: 3, scope: !1248)
!1271 = !DILocation(line: 20, column: 66, scope: !1248)
!1272 = !DILocation(line: 20, column: 14, scope: !1248)
!1273 = !DILocation(line: 21, column: 3, scope: !1248)
!1274 = !DILocation(line: 22, column: 3, scope: !1275)
!1275 = distinct !DILexicalBlock(scope: !1276, file: !2, line: 22, column: 3)
!1276 = distinct !DILexicalBlock(scope: !1248, file: !2, line: 22, column: 3)
!1277 = !DILocation(line: 24, column: 16, scope: !1248)
!1278 = !DILocation(line: 24, column: 3, scope: !1248)
!1279 = !DILocation(line: 27, column: 13, scope: !1280)
!1280 = distinct !DILexicalBlock(scope: !1248, file: !2, line: 24, column: 27)
!1281 = distinct !{!1281, !1278, !1282, !375, !376}
!1282 = !DILocation(line: 28, column: 3, scope: !1248)
!1283 = !DILocation(line: 25, column: 25, scope: !1280)
!1284 = !DILocation(line: 25, column: 50, scope: !1280)
!1285 = !DILocation(line: 25, column: 42, scope: !1280)
!1286 = !DILocation(line: 25, column: 14, scope: !1280)
!1287 = !DILocation(line: 26, column: 5, scope: !1288)
!1288 = distinct !DILexicalBlock(scope: !1289, file: !2, line: 26, column: 5)
!1289 = distinct !DILexicalBlock(scope: !1280, file: !2, line: 26, column: 5)
!1290 = !DILocation(line: 29, column: 3, scope: !1291)
!1291 = distinct !DILexicalBlock(scope: !1292, file: !2, line: 29, column: 3)
!1292 = distinct !DILexicalBlock(scope: !1248, file: !2, line: 29, column: 3)
!1293 = !DILocation(line: 31, column: 1, scope: !1248)
!1294 = !DILocation(line: 30, column: 3, scope: !1248)
!1295 = !DISubprogram(name: "vsnprintf", scope: !852, file: !852, line: 389, type: !1296, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1296 = !DISubroutineType(types: !1297)
!1297 = !{!206, !844, !740, !845, !1298}
!1298 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1299, line: 12, baseType: !1257)
!1299 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1300 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1301, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1303)
!1301 = !DISubroutineType(types: !1302)
!1302 = !{!206, !206, !912, !206}
!1303 = !{!1304, !1305, !1306, !1307}
!1304 = !DILocalVariable(name: "fd", arg: 1, scope: !1300, file: !2, line: 178, type: !206)
!1305 = !DILocalVariable(name: "arr", arg: 2, scope: !1300, file: !2, line: 178, type: !912)
!1306 = !DILocalVariable(name: "n", arg: 3, scope: !1300, file: !2, line: 178, type: !206)
!1307 = !DILocalVariable(name: "i", scope: !1300, file: !2, line: 178, type: !206)
!1308 = !DILocation(line: 0, scope: !1300)
!1309 = !DILocation(line: 178, column: 1, scope: !1310)
!1310 = distinct !DILexicalBlock(scope: !1311, file: !2, line: 178, column: 1)
!1311 = distinct !DILexicalBlock(scope: !1300, file: !2, line: 178, column: 1)
!1312 = !DILocation(line: 178, column: 1, scope: !1313)
!1313 = distinct !DILexicalBlock(scope: !1314, file: !2, line: 178, column: 1)
!1314 = distinct !DILexicalBlock(scope: !1300, file: !2, line: 178, column: 1)
!1315 = !DILocation(line: 178, column: 1, scope: !1314)
!1316 = !DILocation(line: 178, column: 1, scope: !1317)
!1317 = distinct !DILexicalBlock(scope: !1313, file: !2, line: 178, column: 1)
!1318 = distinct !{!1318, !1315, !1315, !375, !376}
!1319 = !DILocation(line: 178, column: 1, scope: !1300)
!1320 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1321, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1323)
!1321 = !DISubroutineType(types: !1322)
!1322 = !{!206, !206, !943, !206}
!1323 = !{!1324, !1325, !1326, !1327}
!1324 = !DILocalVariable(name: "fd", arg: 1, scope: !1320, file: !2, line: 179, type: !206)
!1325 = !DILocalVariable(name: "arr", arg: 2, scope: !1320, file: !2, line: 179, type: !943)
!1326 = !DILocalVariable(name: "n", arg: 3, scope: !1320, file: !2, line: 179, type: !206)
!1327 = !DILocalVariable(name: "i", scope: !1320, file: !2, line: 179, type: !206)
!1328 = !DILocation(line: 0, scope: !1320)
!1329 = !DILocation(line: 179, column: 1, scope: !1330)
!1330 = distinct !DILexicalBlock(scope: !1331, file: !2, line: 179, column: 1)
!1331 = distinct !DILexicalBlock(scope: !1320, file: !2, line: 179, column: 1)
!1332 = !DILocation(line: 179, column: 1, scope: !1333)
!1333 = distinct !DILexicalBlock(scope: !1334, file: !2, line: 179, column: 1)
!1334 = distinct !DILexicalBlock(scope: !1320, file: !2, line: 179, column: 1)
!1335 = !DILocation(line: 179, column: 1, scope: !1334)
!1336 = !DILocation(line: 179, column: 1, scope: !1337)
!1337 = distinct !DILexicalBlock(scope: !1333, file: !2, line: 179, column: 1)
!1338 = distinct !{!1338, !1335, !1335, !375, !376}
!1339 = !DILocation(line: 179, column: 1, scope: !1320)
!1340 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1341, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1343)
!1341 = !DISubroutineType(types: !1342)
!1342 = !{!206, !206, !972, !206}
!1343 = !{!1344, !1345, !1346, !1347}
!1344 = !DILocalVariable(name: "fd", arg: 1, scope: !1340, file: !2, line: 180, type: !206)
!1345 = !DILocalVariable(name: "arr", arg: 2, scope: !1340, file: !2, line: 180, type: !972)
!1346 = !DILocalVariable(name: "n", arg: 3, scope: !1340, file: !2, line: 180, type: !206)
!1347 = !DILocalVariable(name: "i", scope: !1340, file: !2, line: 180, type: !206)
!1348 = !DILocation(line: 0, scope: !1340)
!1349 = !DILocation(line: 180, column: 1, scope: !1350)
!1350 = distinct !DILexicalBlock(scope: !1351, file: !2, line: 180, column: 1)
!1351 = distinct !DILexicalBlock(scope: !1340, file: !2, line: 180, column: 1)
!1352 = !DILocation(line: 180, column: 1, scope: !1353)
!1353 = distinct !DILexicalBlock(scope: !1354, file: !2, line: 180, column: 1)
!1354 = distinct !DILexicalBlock(scope: !1340, file: !2, line: 180, column: 1)
!1355 = !DILocation(line: 180, column: 1, scope: !1354)
!1356 = !DILocation(line: 180, column: 1, scope: !1357)
!1357 = distinct !DILexicalBlock(scope: !1353, file: !2, line: 180, column: 1)
!1358 = distinct !{!1358, !1355, !1355, !375, !376}
!1359 = !DILocation(line: 180, column: 1, scope: !1340)
!1360 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1361, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1363)
!1361 = !DISubroutineType(types: !1362)
!1362 = !{!206, !206, !1003, !206}
!1363 = !{!1364, !1365, !1366, !1367}
!1364 = !DILocalVariable(name: "fd", arg: 1, scope: !1360, file: !2, line: 181, type: !206)
!1365 = !DILocalVariable(name: "arr", arg: 2, scope: !1360, file: !2, line: 181, type: !1003)
!1366 = !DILocalVariable(name: "n", arg: 3, scope: !1360, file: !2, line: 181, type: !206)
!1367 = !DILocalVariable(name: "i", scope: !1360, file: !2, line: 181, type: !206)
!1368 = !DILocation(line: 0, scope: !1360)
!1369 = !DILocation(line: 181, column: 1, scope: !1370)
!1370 = distinct !DILexicalBlock(scope: !1371, file: !2, line: 181, column: 1)
!1371 = distinct !DILexicalBlock(scope: !1360, file: !2, line: 181, column: 1)
!1372 = !DILocation(line: 181, column: 1, scope: !1373)
!1373 = distinct !DILexicalBlock(scope: !1374, file: !2, line: 181, column: 1)
!1374 = distinct !DILexicalBlock(scope: !1360, file: !2, line: 181, column: 1)
!1375 = !DILocation(line: 181, column: 1, scope: !1374)
!1376 = !DILocation(line: 181, column: 1, scope: !1377)
!1377 = distinct !DILexicalBlock(scope: !1373, file: !2, line: 181, column: 1)
!1378 = distinct !{!1378, !1375, !1375, !375, !376}
!1379 = !DILocation(line: 181, column: 1, scope: !1360)
!1380 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1381, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1383)
!1381 = !DISubroutineType(types: !1382)
!1382 = !{!206, !206, !1032, !206}
!1383 = !{!1384, !1385, !1386, !1387}
!1384 = !DILocalVariable(name: "fd", arg: 1, scope: !1380, file: !2, line: 182, type: !206)
!1385 = !DILocalVariable(name: "arr", arg: 2, scope: !1380, file: !2, line: 182, type: !1032)
!1386 = !DILocalVariable(name: "n", arg: 3, scope: !1380, file: !2, line: 182, type: !206)
!1387 = !DILocalVariable(name: "i", scope: !1380, file: !2, line: 182, type: !206)
!1388 = !DILocation(line: 0, scope: !1380)
!1389 = !DILocation(line: 182, column: 1, scope: !1390)
!1390 = distinct !DILexicalBlock(scope: !1391, file: !2, line: 182, column: 1)
!1391 = distinct !DILexicalBlock(scope: !1380, file: !2, line: 182, column: 1)
!1392 = !DILocation(line: 182, column: 1, scope: !1393)
!1393 = distinct !DILexicalBlock(scope: !1394, file: !2, line: 182, column: 1)
!1394 = distinct !DILexicalBlock(scope: !1380, file: !2, line: 182, column: 1)
!1395 = !DILocation(line: 182, column: 1, scope: !1394)
!1396 = !DILocation(line: 182, column: 1, scope: !1397)
!1397 = distinct !DILexicalBlock(scope: !1393, file: !2, line: 182, column: 1)
!1398 = distinct !{!1398, !1395, !1395, !375, !376}
!1399 = !DILocation(line: 182, column: 1, scope: !1380)
!1400 = !DILocation(line: 0, scope: !542)
!1401 = !DILocation(line: 183, column: 1, scope: !1402)
!1402 = distinct !DILexicalBlock(scope: !1403, file: !2, line: 183, column: 1)
!1403 = distinct !DILexicalBlock(scope: !542, file: !2, line: 183, column: 1)
!1404 = !DILocation(line: 183, column: 1, scope: !555)
!1405 = !DILocation(line: 183, column: 1, scope: !552)
!1406 = !DILocation(line: 183, column: 1, scope: !554)
!1407 = distinct !{!1407, !1405, !1405, !375, !376}
!1408 = !DILocation(line: 183, column: 1, scope: !542)
!1409 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1410, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1412)
!1410 = !DISubroutineType(types: !1411)
!1411 = !{!206, !206, !1089, !206}
!1412 = !{!1413, !1414, !1415, !1416}
!1413 = !DILocalVariable(name: "fd", arg: 1, scope: !1409, file: !2, line: 184, type: !206)
!1414 = !DILocalVariable(name: "arr", arg: 2, scope: !1409, file: !2, line: 184, type: !1089)
!1415 = !DILocalVariable(name: "n", arg: 3, scope: !1409, file: !2, line: 184, type: !206)
!1416 = !DILocalVariable(name: "i", scope: !1409, file: !2, line: 184, type: !206)
!1417 = !DILocation(line: 0, scope: !1409)
!1418 = !DILocation(line: 184, column: 1, scope: !1419)
!1419 = distinct !DILexicalBlock(scope: !1420, file: !2, line: 184, column: 1)
!1420 = distinct !DILexicalBlock(scope: !1409, file: !2, line: 184, column: 1)
!1421 = !DILocation(line: 184, column: 1, scope: !1422)
!1422 = distinct !DILexicalBlock(scope: !1423, file: !2, line: 184, column: 1)
!1423 = distinct !DILexicalBlock(scope: !1409, file: !2, line: 184, column: 1)
!1424 = !DILocation(line: 184, column: 1, scope: !1423)
!1425 = !DILocation(line: 184, column: 1, scope: !1426)
!1426 = distinct !DILexicalBlock(scope: !1422, file: !2, line: 184, column: 1)
!1427 = distinct !{!1427, !1424, !1424, !375, !376}
!1428 = !DILocation(line: 184, column: 1, scope: !1409)
!1429 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1430, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1432)
!1430 = !DISubroutineType(types: !1431)
!1431 = !{!206, !206, !1118, !206}
!1432 = !{!1433, !1434, !1435, !1436}
!1433 = !DILocalVariable(name: "fd", arg: 1, scope: !1429, file: !2, line: 186, type: !206)
!1434 = !DILocalVariable(name: "arr", arg: 2, scope: !1429, file: !2, line: 186, type: !1118)
!1435 = !DILocalVariable(name: "n", arg: 3, scope: !1429, file: !2, line: 186, type: !206)
!1436 = !DILocalVariable(name: "i", scope: !1429, file: !2, line: 186, type: !206)
!1437 = !DILocation(line: 0, scope: !1429)
!1438 = !DILocation(line: 186, column: 1, scope: !1439)
!1439 = distinct !DILexicalBlock(scope: !1440, file: !2, line: 186, column: 1)
!1440 = distinct !DILexicalBlock(scope: !1429, file: !2, line: 186, column: 1)
!1441 = !DILocation(line: 186, column: 1, scope: !1442)
!1442 = distinct !DILexicalBlock(scope: !1443, file: !2, line: 186, column: 1)
!1443 = distinct !DILexicalBlock(scope: !1429, file: !2, line: 186, column: 1)
!1444 = !DILocation(line: 186, column: 1, scope: !1443)
!1445 = !DILocation(line: 186, column: 1, scope: !1446)
!1446 = distinct !DILexicalBlock(scope: !1442, file: !2, line: 186, column: 1)
!1447 = distinct !{!1447, !1444, !1444, !375, !376}
!1448 = !DILocation(line: 186, column: 1, scope: !1429)
!1449 = !DILocation(line: 0, scope: !521)
!1450 = !DILocation(line: 187, column: 1, scope: !1451)
!1451 = distinct !DILexicalBlock(scope: !1452, file: !2, line: 187, column: 1)
!1452 = distinct !DILexicalBlock(scope: !521, file: !2, line: 187, column: 1)
!1453 = !DILocation(line: 187, column: 1, scope: !534)
!1454 = !DILocation(line: 187, column: 1, scope: !531)
!1455 = !DILocation(line: 187, column: 1, scope: !533)
!1456 = distinct !{!1456, !1454, !1454, !375, !376}
!1457 = !DILocation(line: 187, column: 1, scope: !521)
!1458 = !DILocation(line: 0, scope: !510)
!1459 = !DILocation(line: 190, column: 3, scope: !517)
!1460 = !DILocation(line: 191, column: 3, scope: !510)
!1461 = !DILocation(line: 192, column: 3, scope: !510)
!1462 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1463, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !297, retainedNodes: !1465)
!1463 = !DISubroutineType(types: !1464)
!1464 = !{!206, !206, !850}
!1465 = !{!1466, !1467, !1468, !1469, !1470, !1471, !1472, !1473, !1474}
!1466 = !DILocalVariable(name: "argc", arg: 1, scope: !1462, file: !170, line: 14, type: !206)
!1467 = !DILocalVariable(name: "argv", arg: 2, scope: !1462, file: !170, line: 14, type: !850)
!1468 = !DILocalVariable(name: "in_file", scope: !1462, file: !170, line: 17, type: !238)
!1469 = !DILocalVariable(name: "check_file", scope: !1462, file: !170, line: 19, type: !238)
!1470 = !DILocalVariable(name: "in_fd", scope: !1462, file: !170, line: 34, type: !206)
!1471 = !DILocalVariable(name: "data", scope: !1462, file: !170, line: 35, type: !238)
!1472 = !DILocalVariable(name: "out_fd", scope: !1462, file: !170, line: 46, type: !206)
!1473 = !DILocalVariable(name: "check_fd", scope: !1462, file: !170, line: 55, type: !206)
!1474 = !DILocalVariable(name: "ref", scope: !1462, file: !170, line: 56, type: !238)
!1475 = !DILocation(line: 0, scope: !1462)
!1476 = !DILocation(line: 21, column: 3, scope: !1477)
!1477 = distinct !DILexicalBlock(scope: !1478, file: !170, line: 21, column: 3)
!1478 = distinct !DILexicalBlock(scope: !1462, file: !170, line: 21, column: 3)
!1479 = !DILocation(line: 26, column: 11, scope: !1480)
!1480 = distinct !DILexicalBlock(scope: !1462, file: !170, line: 26, column: 7)
!1481 = !DILocation(line: 26, column: 7, scope: !1462)
!1482 = !DILocation(line: 27, column: 15, scope: !1480)
!1483 = !DILocation(line: 29, column: 11, scope: !1484)
!1484 = distinct !DILexicalBlock(scope: !1462, file: !170, line: 29, column: 7)
!1485 = !DILocation(line: 29, column: 7, scope: !1462)
!1486 = !DILocation(line: 30, column: 18, scope: !1484)
!1487 = !DILocation(line: 30, column: 5, scope: !1484)
!1488 = !DILocation(line: 36, column: 17, scope: !1462)
!1489 = !DILocation(line: 36, column: 10, scope: !1462)
!1490 = !DILocation(line: 37, column: 3, scope: !1491)
!1491 = distinct !DILexicalBlock(scope: !1492, file: !170, line: 37, column: 3)
!1492 = distinct !DILexicalBlock(scope: !1462, file: !170, line: 37, column: 3)
!1493 = !DILocation(line: 38, column: 11, scope: !1462)
!1494 = !DILocation(line: 39, column: 3, scope: !1495)
!1495 = distinct !DILexicalBlock(scope: !1496, file: !170, line: 39, column: 3)
!1496 = distinct !DILexicalBlock(scope: !1462, file: !170, line: 39, column: 3)
!1497 = !DILocation(line: 40, column: 3, scope: !1462)
!1498 = !DILocation(line: 0, scope: !383, inlinedAt: !1499)
!1499 = distinct !DILocation(line: 43, column: 3, scope: !1462)
!1500 = !DILocation(line: 10, column: 28, scope: !383, inlinedAt: !1499)
!1501 = !DILocation(line: 10, column: 40, scope: !383, inlinedAt: !1499)
!1502 = !DILocation(line: 10, column: 51, scope: !383, inlinedAt: !1499)
!1503 = !DILocation(line: 0, scope: !330, inlinedAt: !1504)
!1504 = distinct !DILocation(line: 10, column: 3, scope: !383, inlinedAt: !1499)
!1505 = !DILocation(line: 13, column: 5, scope: !330, inlinedAt: !1504)
!1506 = !DILocation(line: 13, column: 17, scope: !347, inlinedAt: !1504)
!1507 = !DILocation(line: 14, column: 20, scope: !345, inlinedAt: !1504)
!1508 = !DILocation(line: 0, scope: !345, inlinedAt: !1504)
!1509 = !DILocation(line: 15, column: 9, scope: !345, inlinedAt: !1504)
!1510 = !DILocation(line: 15, column: 21, scope: !356, inlinedAt: !1504)
!1511 = !DILocation(line: 16, column: 30, scope: !358, inlinedAt: !1504)
!1512 = !DILocation(line: 16, column: 22, scope: !358, inlinedAt: !1504)
!1513 = !DILocation(line: 16, column: 43, scope: !358, inlinedAt: !1504)
!1514 = !DILocation(line: 16, column: 39, scope: !358, inlinedAt: !1504)
!1515 = !DILocation(line: 16, column: 37, scope: !358, inlinedAt: !1504)
!1516 = !DILocation(line: 17, column: 21, scope: !358, inlinedAt: !1504)
!1517 = !DILocation(line: 15, column: 37, scope: !359, inlinedAt: !1504)
!1518 = !DILocation(line: 15, column: 32, scope: !359, inlinedAt: !1504)
!1519 = distinct !{!1519, !1510, !1520, !375, !376}
!1520 = !DILocation(line: 18, column: 9, scope: !356, inlinedAt: !1504)
!1521 = !DILocation(line: 19, column: 16, scope: !345, inlinedAt: !1504)
!1522 = !DILocation(line: 13, column: 33, scope: !346, inlinedAt: !1504)
!1523 = !DILocation(line: 13, column: 28, scope: !346, inlinedAt: !1504)
!1524 = distinct !{!1524, !1506, !1525, !375, !376}
!1525 = !DILocation(line: 20, column: 5, scope: !347, inlinedAt: !1504)
!1526 = !DILocation(line: 47, column: 12, scope: !1462)
!1527 = !DILocation(line: 48, column: 3, scope: !1528)
!1528 = distinct !DILexicalBlock(scope: !1529, file: !170, line: 48, column: 3)
!1529 = distinct !DILexicalBlock(scope: !1462, file: !170, line: 48, column: 3)
!1530 = !DILocation(line: 0, scope: !600, inlinedAt: !1531)
!1531 = distinct !DILocation(line: 49, column: 3, scope: !1462)
!1532 = !DILocation(line: 0, scope: !510, inlinedAt: !1533)
!1533 = distinct !DILocation(line: 73, column: 3, scope: !600, inlinedAt: !1531)
!1534 = !DILocation(line: 190, column: 3, scope: !517, inlinedAt: !1533)
!1535 = !DILocation(line: 191, column: 3, scope: !510, inlinedAt: !1533)
!1536 = !DILocation(line: 0, scope: !521, inlinedAt: !1537)
!1537 = distinct !DILocation(line: 74, column: 3, scope: !600, inlinedAt: !1531)
!1538 = !DILocation(line: 187, column: 1, scope: !531, inlinedAt: !1537)
!1539 = !DILocation(line: 187, column: 1, scope: !533, inlinedAt: !1537)
!1540 = !DILocation(line: 187, column: 1, scope: !534, inlinedAt: !1537)
!1541 = distinct !{!1541, !1538, !1538, !375, !376}
!1542 = !DILocation(line: 50, column: 3, scope: !1462)
!1543 = !DILocation(line: 57, column: 16, scope: !1462)
!1544 = !DILocation(line: 57, column: 9, scope: !1462)
!1545 = !DILocation(line: 58, column: 3, scope: !1546)
!1546 = distinct !DILexicalBlock(scope: !1547, file: !170, line: 58, column: 3)
!1547 = distinct !DILexicalBlock(scope: !1462, file: !170, line: 58, column: 3)
!1548 = !DILocation(line: 59, column: 14, scope: !1462)
!1549 = !DILocation(line: 60, column: 3, scope: !1550)
!1550 = distinct !DILexicalBlock(scope: !1551, file: !170, line: 60, column: 3)
!1551 = distinct !DILexicalBlock(scope: !1462, file: !170, line: 60, column: 3)
!1552 = !DILocation(line: 0, scope: !569, inlinedAt: !1553)
!1553 = distinct !DILocation(line: 61, column: 3, scope: !1462)
!1554 = !DILocation(line: 63, column: 7, scope: !569, inlinedAt: !1553)
!1555 = !DILocation(line: 0, scope: !430, inlinedAt: !1556)
!1556 = distinct !DILocation(line: 65, column: 7, scope: !569, inlinedAt: !1553)
!1557 = !DILocation(line: 64, column: 17, scope: !430, inlinedAt: !1556)
!1558 = !DILocation(line: 64, column: 3, scope: !430, inlinedAt: !1556)
!1559 = !DILocation(line: 66, column: 22, scope: !442, inlinedAt: !1556)
!1560 = !DILocation(line: 66, column: 26, scope: !442, inlinedAt: !1556)
!1561 = !DILocation(line: 66, column: 32, scope: !442, inlinedAt: !1556)
!1562 = !DILocation(line: 66, column: 35, scope: !442, inlinedAt: !1556)
!1563 = !DILocation(line: 66, column: 39, scope: !442, inlinedAt: !1556)
!1564 = !DILocation(line: 66, column: 9, scope: !443, inlinedAt: !1556)
!1565 = !DILocation(line: 69, column: 6, scope: !443, inlinedAt: !1556)
!1566 = !DILocation(line: 64, column: 10, scope: !430, inlinedAt: !1556)
!1567 = !DILocation(line: 64, column: 13, scope: !430, inlinedAt: !1556)
!1568 = distinct !{!1568, !1558, !1569, !375, !376}
!1569 = !DILocation(line: 70, column: 3, scope: !430, inlinedAt: !1556)
!1570 = !DILocation(line: 71, column: 6, scope: !455, inlinedAt: !1556)
!1571 = !DILocation(line: 71, column: 8, scope: !455, inlinedAt: !1556)
!1572 = !DILocation(line: 71, column: 6, scope: !430, inlinedAt: !1556)
!1573 = !DILocation(line: 66, column: 37, scope: !569, inlinedAt: !1553)
!1574 = !DILocation(line: 66, column: 3, scope: !569, inlinedAt: !1553)
!1575 = !DILocation(line: 67, column: 3, scope: !569, inlinedAt: !1553)
!1576 = !DILocation(line: 0, scope: !618, inlinedAt: !1577)
!1577 = distinct !DILocation(line: 66, column: 8, scope: !1578)
!1578 = distinct !DILexicalBlock(scope: !1462, file: !170, line: 66, column: 7)
!1579 = !DILocation(line: 84, column: 3, scope: !631, inlinedAt: !1577)
!1580 = !DILocation(line: 85, column: 12, scope: !633, inlinedAt: !1577)
!1581 = !DILocation(line: 85, column: 27, scope: !633, inlinedAt: !1577)
!1582 = !DILocation(line: 85, column: 25, scope: !633, inlinedAt: !1577)
!1583 = !DILocation(line: 86, column: 35, scope: !633, inlinedAt: !1577)
!1584 = !DILocation(line: 86, column: 16, scope: !633, inlinedAt: !1577)
!1585 = !DILocation(line: 84, column: 18, scope: !634, inlinedAt: !1577)
!1586 = !DILocation(line: 84, column: 13, scope: !634, inlinedAt: !1577)
!1587 = distinct !{!1587, !1579, !1588, !375, !376}
!1588 = !DILocation(line: 87, column: 3, scope: !631, inlinedAt: !1577)
!1589 = !DILocation(line: 90, column: 10, scope: !618, inlinedAt: !1577)
!1590 = !DILocation(line: 66, column: 7, scope: !1462)
!1591 = !DILocation(line: 67, column: 13, scope: !1592)
!1592 = distinct !DILexicalBlock(scope: !1578, file: !170, line: 66, column: 32)
!1593 = !DILocation(line: 67, column: 5, scope: !1592)
!1594 = !DILocation(line: 68, column: 5, scope: !1592)
!1595 = !DILocation(line: 71, column: 3, scope: !1462)
!1596 = !DILocation(line: 72, column: 3, scope: !1462)
!1597 = !DILocation(line: 74, column: 3, scope: !1462)
!1598 = !DILocation(line: 75, column: 3, scope: !1462)
!1599 = !DILocation(line: 76, column: 1, scope: !1462)
!1600 = !DISubprogram(name: "open", scope: !1601, file: !1601, line: 209, type: !1602, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1601 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1602 = !DISubroutineType(types: !1603)
!1603 = !{!206, !731, !206, null}
