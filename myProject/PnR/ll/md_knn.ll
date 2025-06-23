; ModuleID = 'md/knn/md_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.bench_args_t = type { [256 x double], [256 x double], [256 x double], [256 x double], [256 x double], [256 x double], [4096 x i32] }
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
@INPUT_SIZE = dso_local local_unnamed_addr global i32 28672, align 4, !dbg !186
@.str.6.18 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !215
@.str.8.19 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !218
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !221
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !226
@.str.12.20 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !229
@.str.14.21 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !231
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !234
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @md(ptr nocapture noundef writeonly %force_x, ptr nocapture noundef writeonly %force_y, ptr nocapture noundef writeonly %force_z, ptr nocapture noundef readonly %position_x, ptr nocapture noundef readonly %position_y, ptr nocapture noundef readonly %position_z, ptr nocapture noundef readonly %NL) local_unnamed_addr #0 !dbg !332 {
entry.split:
  %fy.068.reg2mem = alloca double, align 8
  %fz.069.reg2mem = alloca double, align 8
  %fx.071.reg2mem = alloca double, align 8
  %indvars.iv.reg2mem = alloca i64, align 8
  %indvars.iv76.reg2mem41 = alloca i64, align 8
    #dbg_value(ptr %force_x, !338, !DIExpression(), !369)
    #dbg_value(ptr %force_y, !339, !DIExpression(), !369)
    #dbg_value(ptr %force_z, !340, !DIExpression(), !369)
    #dbg_value(ptr %position_x, !341, !DIExpression(), !369)
    #dbg_value(ptr %position_y, !342, !DIExpression(), !369)
    #dbg_value(ptr %position_z, !343, !DIExpression(), !369)
    #dbg_value(ptr %NL, !344, !DIExpression(), !369)
    #dbg_label(!364, !370)
    #dbg_value(i32 0, !361, !DIExpression(), !369)
  store i64 0, ptr %indvars.iv76.reg2mem41, align 8
  br label %for.body, !dbg !371

for.body:                                         ; preds = %for.end.for.body_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv76.reg2mem41.0.load, !361, !DIExpression(), !369)
  %indvars.iv76.reg2mem41.0.load = load i64, ptr %indvars.iv76.reg2mem41, align 8
  %arrayidx = getelementptr inbounds double, ptr %position_x, i64 %indvars.iv76.reg2mem41.0.load, !dbg !372
  %0 = load double, ptr %arrayidx, align 8, !dbg !372
    #dbg_value(double %0, !355, !DIExpression(), !369)
  %arrayidx2 = getelementptr inbounds double, ptr %position_y, i64 %indvars.iv76.reg2mem41.0.load, !dbg !373
  %1 = load double, ptr %arrayidx2, align 8, !dbg !373
    #dbg_value(double %1, !356, !DIExpression(), !369)
  %arrayidx4 = getelementptr inbounds double, ptr %position_z, i64 %indvars.iv76.reg2mem41.0.load, !dbg !374
  %2 = load double, ptr %arrayidx4, align 8, !dbg !374
    #dbg_value(double %2, !357, !DIExpression(), !369)
    #dbg_value(double 0.000000e+00, !358, !DIExpression(), !369)
    #dbg_value(double 0.000000e+00, !359, !DIExpression(), !369)
    #dbg_value(double 0.000000e+00, !360, !DIExpression(), !369)
    #dbg_label(!365, !375)
    #dbg_value(i32 0, !362, !DIExpression(), !369)
  %invariant.gep.idx = shl i64 %indvars.iv76.reg2mem41.0.load, 6, !dbg !376
  %invariant.gep = getelementptr i8, ptr %NL, i64 %invariant.gep.idx, !dbg !376
  store double 0.000000e+00, ptr %fy.068.reg2mem, align 8
  store double 0.000000e+00, ptr %fz.069.reg2mem, align 8
  store double 0.000000e+00, ptr %fx.071.reg2mem, align 8
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body7, !dbg !376

for.body7:                                        ; preds = %for.body7.for.body7_crit_edge, %for.body
    #dbg_value(double %fx.071.reg2mem.0.fx.071.reload, !358, !DIExpression(), !369)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !362, !DIExpression(), !369)
    #dbg_value(double %fz.069.reg2mem.0.fz.069.reload, !360, !DIExpression(), !369)
    #dbg_value(double %fy.068.reg2mem.0.fy.068.reload, !359, !DIExpression(), !369)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %fx.071.reg2mem.0.fx.071.reload = load double, ptr %fx.071.reg2mem, align 8
  %fz.069.reg2mem.0.fz.069.reload = load double, ptr %fz.069.reg2mem, align 8
  %fy.068.reg2mem.0.fy.068.reload = load double, ptr %fy.068.reg2mem, align 8
  %gep = getelementptr i32, ptr %invariant.gep, i64 %indvars.iv.reg2mem.0.load, !dbg !378
  %3 = load i32, ptr %gep, align 4, !dbg !378, !tbaa !381
    #dbg_value(i32 %3, !363, !DIExpression(), !369)
  %idxprom10 = sext i32 %3 to i64, !dbg !385
  %arrayidx11 = getelementptr inbounds double, ptr %position_x, i64 %idxprom10, !dbg !385
  %4 = load double, ptr %arrayidx11, align 8, !dbg !385, !tbaa !386
    #dbg_value(double %4, !352, !DIExpression(), !369)
  %arrayidx13 = getelementptr inbounds double, ptr %position_y, i64 %idxprom10, !dbg !388
  %5 = load double, ptr %arrayidx13, align 8, !dbg !388, !tbaa !386
    #dbg_value(double %5, !353, !DIExpression(), !369)
  %arrayidx15 = getelementptr inbounds double, ptr %position_z, i64 %idxprom10, !dbg !389
  %6 = load double, ptr %arrayidx15, align 8, !dbg !389, !tbaa !386
    #dbg_value(double %6, !354, !DIExpression(), !369)
  %sub = fsub double %0, %4, !dbg !390
    #dbg_value(double %sub, !345, !DIExpression(), !369)
  %sub16 = fsub double %1, %5, !dbg !391
    #dbg_value(double %sub16, !346, !DIExpression(), !369)
  %sub17 = fsub double %2, %6, !dbg !392
    #dbg_value(double %sub17, !347, !DIExpression(), !369)
  %mul19 = fmul double %sub16, %sub16, !dbg !393
  %7 = tail call double @llvm.fmuladd.f64(double %sub, double %sub, double %mul19), !dbg !394
  %8 = tail call double @llvm.fmuladd.f64(double %sub17, double %sub17, double %7), !dbg !395
  %div = fdiv double 1.000000e+00, %8, !dbg !396
    #dbg_value(double %div, !348, !DIExpression(), !369)
  %mul21 = fmul double %div, %div, !dbg !397
  %mul22 = fmul double %div, %mul21, !dbg !398
    #dbg_value(double %mul22, !349, !DIExpression(), !369)
  %9 = tail call double @llvm.fmuladd.f64(double %mul22, double 1.500000e+00, double -2.000000e+00), !dbg !399
  %mul24 = fmul double %mul22, %9, !dbg !400
    #dbg_value(double %mul24, !350, !DIExpression(), !369)
  %mul25 = fmul double %div, %mul24, !dbg !401
    #dbg_value(double %mul25, !351, !DIExpression(), !369)
  %10 = tail call double @llvm.fmuladd.f64(double %sub, double %mul25, double %fx.071.reg2mem.0.fx.071.reload), !dbg !402
    #dbg_value(double %10, !358, !DIExpression(), !369)
  %11 = tail call double @llvm.fmuladd.f64(double %sub16, double %mul25, double %fy.068.reg2mem.0.fy.068.reload), !dbg !403
    #dbg_value(double %11, !359, !DIExpression(), !369)
  %12 = tail call double @llvm.fmuladd.f64(double %sub17, double %mul25, double %fz.069.reg2mem.0.fz.069.reload), !dbg !404
    #dbg_value(double %12, !360, !DIExpression(), !369)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !405
    #dbg_value(i64 %indvars.iv.next, !362, !DIExpression(), !369)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 16, !dbg !406
  br i1 %exitcond.not, label %for.end, label %for.body7.for.body7_crit_edge, !dbg !376, !llvm.loop !407

for.body7.for.body7_crit_edge:                    ; preds = %for.body7
  store double %11, ptr %fy.068.reg2mem, align 8
  store double %12, ptr %fz.069.reg2mem, align 8
  store double %10, ptr %fx.071.reg2mem, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body7, !dbg !376

for.end:                                          ; preds = %for.body7
  %arrayidx30 = getelementptr inbounds double, ptr %force_x, i64 %indvars.iv76.reg2mem41.0.load, !dbg !411
  store double %10, ptr %arrayidx30, align 8, !dbg !412, !tbaa !386
  %arrayidx32 = getelementptr inbounds double, ptr %force_y, i64 %indvars.iv76.reg2mem41.0.load, !dbg !413
  store double %11, ptr %arrayidx32, align 8, !dbg !414, !tbaa !386
  %arrayidx34 = getelementptr inbounds double, ptr %force_z, i64 %indvars.iv76.reg2mem41.0.load, !dbg !415
  store double %12, ptr %arrayidx34, align 8, !dbg !416, !tbaa !386
  %indvars.iv.next77 = add nuw nsw i64 %indvars.iv76.reg2mem41.0.load, 1, !dbg !417
    #dbg_value(i64 %indvars.iv.next77, !361, !DIExpression(), !369)
  %exitcond79.not = icmp eq i64 %indvars.iv.next77, 256, !dbg !418
  br i1 %exitcond79.not, label %for.end37, label %for.end.for.body_crit_edge, !dbg !371, !llvm.loop !419

for.end.for.body_crit_edge:                       ; preds = %for.end
  store i64 %indvars.iv.next77, ptr %indvars.iv76.reg2mem41, align 8
  br label %for.body, !dbg !371

for.end37:                                        ; preds = %for.end
  ret void, !dbg !421
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #0 !dbg !422 {
entry.split:
  %fy.068.i.reg2mem = alloca double, align 8
  %fz.069.i.reg2mem = alloca double, align 8
  %fx.071.i.reg2mem = alloca double, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %indvars.iv76.i.reg2mem44 = alloca i64, align 8
    #dbg_value(ptr %vargs, !426, !DIExpression(), !428)
    #dbg_value(ptr %vargs, !427, !DIExpression(), !428)
  %force_y = getelementptr inbounds i8, ptr %vargs, i64 2048, !dbg !429
  %force_z = getelementptr inbounds i8, ptr %vargs, i64 4096, !dbg !430
  %position_x = getelementptr inbounds i8, ptr %vargs, i64 6144, !dbg !431
  %position_y = getelementptr inbounds i8, ptr %vargs, i64 8192, !dbg !432
  %position_z = getelementptr inbounds i8, ptr %vargs, i64 10240, !dbg !433
  %NL = getelementptr inbounds i8, ptr %vargs, i64 12288, !dbg !434
    #dbg_value(ptr %vargs, !338, !DIExpression(), !435)
    #dbg_value(ptr %force_y, !339, !DIExpression(), !435)
    #dbg_value(ptr %force_z, !340, !DIExpression(), !435)
    #dbg_value(ptr %position_x, !341, !DIExpression(), !435)
    #dbg_value(ptr %position_y, !342, !DIExpression(), !435)
    #dbg_value(ptr %position_z, !343, !DIExpression(), !435)
    #dbg_value(ptr %NL, !344, !DIExpression(), !435)
    #dbg_label(!364, !437)
    #dbg_value(i32 0, !361, !DIExpression(), !435)
  store i64 0, ptr %indvars.iv76.i.reg2mem44, align 8
  br label %for.body.i, !dbg !438

for.body.i:                                       ; preds = %for.end.i.for.body.i_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv76.i.reg2mem44.0.load, !361, !DIExpression(), !435)
  %indvars.iv76.i.reg2mem44.0.load = load i64, ptr %indvars.iv76.i.reg2mem44, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %position_x, i64 %indvars.iv76.i.reg2mem44.0.load, !dbg !439
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !439
    #dbg_value(double %0, !355, !DIExpression(), !435)
  %arrayidx2.i = getelementptr inbounds double, ptr %position_y, i64 %indvars.iv76.i.reg2mem44.0.load, !dbg !440
  %1 = load double, ptr %arrayidx2.i, align 8, !dbg !440
    #dbg_value(double %1, !356, !DIExpression(), !435)
  %arrayidx4.i = getelementptr inbounds double, ptr %position_z, i64 %indvars.iv76.i.reg2mem44.0.load, !dbg !441
  %2 = load double, ptr %arrayidx4.i, align 8, !dbg !441
    #dbg_value(double %2, !357, !DIExpression(), !435)
    #dbg_value(double 0.000000e+00, !358, !DIExpression(), !435)
    #dbg_value(double 0.000000e+00, !359, !DIExpression(), !435)
    #dbg_value(double 0.000000e+00, !360, !DIExpression(), !435)
    #dbg_label(!365, !442)
    #dbg_value(i32 0, !362, !DIExpression(), !435)
  %invariant.gep.idx.i = shl i64 %indvars.iv76.i.reg2mem44.0.load, 6, !dbg !443
  %invariant.gep.i = getelementptr i8, ptr %NL, i64 %invariant.gep.idx.i, !dbg !443
  store double 0.000000e+00, ptr %fy.068.i.reg2mem, align 8
  store double 0.000000e+00, ptr %fz.069.i.reg2mem, align 8
  store double 0.000000e+00, ptr %fx.071.i.reg2mem, align 8
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body7.i, !dbg !443

for.body7.i:                                      ; preds = %for.body7.i.for.body7.i_crit_edge, %for.body.i
    #dbg_value(double %fx.071.i.reg2mem.0.fx.071.i.reload, !358, !DIExpression(), !435)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !362, !DIExpression(), !435)
    #dbg_value(double %fz.069.i.reg2mem.0.fz.069.i.reload, !360, !DIExpression(), !435)
    #dbg_value(double %fy.068.i.reg2mem.0.fy.068.i.reload, !359, !DIExpression(), !435)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %fx.071.i.reg2mem.0.fx.071.i.reload = load double, ptr %fx.071.i.reg2mem, align 8
  %fz.069.i.reg2mem.0.fz.069.i.reload = load double, ptr %fz.069.i.reg2mem, align 8
  %fy.068.i.reg2mem.0.fy.068.i.reload = load double, ptr %fy.068.i.reg2mem, align 8
  %gep.i = getelementptr i32, ptr %invariant.gep.i, i64 %indvars.iv.i.reg2mem.0.load, !dbg !444
  %3 = load i32, ptr %gep.i, align 4, !dbg !444, !tbaa !381
    #dbg_value(i32 %3, !363, !DIExpression(), !435)
  %idxprom10.i = sext i32 %3 to i64, !dbg !445
  %arrayidx11.i = getelementptr inbounds double, ptr %position_x, i64 %idxprom10.i, !dbg !445
  %4 = load double, ptr %arrayidx11.i, align 8, !dbg !445, !tbaa !386
    #dbg_value(double %4, !352, !DIExpression(), !435)
  %arrayidx13.i = getelementptr inbounds double, ptr %position_y, i64 %idxprom10.i, !dbg !446
  %5 = load double, ptr %arrayidx13.i, align 8, !dbg !446, !tbaa !386
    #dbg_value(double %5, !353, !DIExpression(), !435)
  %arrayidx15.i = getelementptr inbounds double, ptr %position_z, i64 %idxprom10.i, !dbg !447
  %6 = load double, ptr %arrayidx15.i, align 8, !dbg !447, !tbaa !386
    #dbg_value(double %6, !354, !DIExpression(), !435)
  %sub.i = fsub double %0, %4, !dbg !448
    #dbg_value(double %sub.i, !345, !DIExpression(), !435)
  %sub16.i = fsub double %1, %5, !dbg !449
    #dbg_value(double %sub16.i, !346, !DIExpression(), !435)
  %sub17.i = fsub double %2, %6, !dbg !450
    #dbg_value(double %sub17.i, !347, !DIExpression(), !435)
  %mul19.i = fmul double %sub16.i, %sub16.i, !dbg !451
  %7 = tail call double @llvm.fmuladd.f64(double %sub.i, double %sub.i, double %mul19.i), !dbg !452
  %8 = tail call double @llvm.fmuladd.f64(double %sub17.i, double %sub17.i, double %7), !dbg !453
  %div.i = fdiv double 1.000000e+00, %8, !dbg !454
    #dbg_value(double %div.i, !348, !DIExpression(), !435)
  %mul21.i = fmul double %div.i, %div.i, !dbg !455
  %mul22.i = fmul double %div.i, %mul21.i, !dbg !456
    #dbg_value(double %mul22.i, !349, !DIExpression(), !435)
  %9 = tail call double @llvm.fmuladd.f64(double %mul22.i, double 1.500000e+00, double -2.000000e+00), !dbg !457
  %mul24.i = fmul double %mul22.i, %9, !dbg !458
    #dbg_value(double %mul24.i, !350, !DIExpression(), !435)
  %mul25.i = fmul double %div.i, %mul24.i, !dbg !459
    #dbg_value(double %mul25.i, !351, !DIExpression(), !435)
  %10 = tail call double @llvm.fmuladd.f64(double %sub.i, double %mul25.i, double %fx.071.i.reg2mem.0.fx.071.i.reload), !dbg !460
    #dbg_value(double %10, !358, !DIExpression(), !435)
  %11 = tail call double @llvm.fmuladd.f64(double %sub16.i, double %mul25.i, double %fy.068.i.reg2mem.0.fy.068.i.reload), !dbg !461
    #dbg_value(double %11, !359, !DIExpression(), !435)
  %12 = tail call double @llvm.fmuladd.f64(double %sub17.i, double %mul25.i, double %fz.069.i.reg2mem.0.fz.069.i.reload), !dbg !462
    #dbg_value(double %12, !360, !DIExpression(), !435)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !463
    #dbg_value(i64 %indvars.iv.next.i, !362, !DIExpression(), !435)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 16, !dbg !464
  br i1 %exitcond.not.i, label %for.end.i, label %for.body7.i.for.body7.i_crit_edge, !dbg !443, !llvm.loop !465

for.body7.i.for.body7.i_crit_edge:                ; preds = %for.body7.i
  store double %11, ptr %fy.068.i.reg2mem, align 8
  store double %12, ptr %fz.069.i.reg2mem, align 8
  store double %10, ptr %fx.071.i.reg2mem, align 8
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body7.i, !dbg !443

for.end.i:                                        ; preds = %for.body7.i
  %arrayidx30.i = getelementptr inbounds double, ptr %vargs, i64 %indvars.iv76.i.reg2mem44.0.load, !dbg !467
  store double %10, ptr %arrayidx30.i, align 8, !dbg !468, !tbaa !386
  %arrayidx32.i = getelementptr inbounds double, ptr %force_y, i64 %indvars.iv76.i.reg2mem44.0.load, !dbg !469
  store double %11, ptr %arrayidx32.i, align 8, !dbg !470, !tbaa !386
  %arrayidx34.i = getelementptr inbounds double, ptr %force_z, i64 %indvars.iv76.i.reg2mem44.0.load, !dbg !471
  store double %12, ptr %arrayidx34.i, align 8, !dbg !472, !tbaa !386
  %indvars.iv.next77.i = add nuw nsw i64 %indvars.iv76.i.reg2mem44.0.load, 1, !dbg !473
    #dbg_value(i64 %indvars.iv.next77.i, !361, !DIExpression(), !435)
  %exitcond79.not.i = icmp eq i64 %indvars.iv.next77.i, 256, !dbg !474
  br i1 %exitcond79.not.i, label %md.exit, label %for.end.i.for.body.i_crit_edge, !dbg !438, !llvm.loop !475

for.end.i.for.body.i_crit_edge:                   ; preds = %for.end.i
  store i64 %indvars.iv.next77.i, ptr %indvars.iv76.i.reg2mem44, align 8
  br label %for.body.i, !dbg !438

md.exit:                                          ; preds = %for.end.i
  ret void, !dbg !477
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #2 !dbg !478 {
entry.split:
  %call.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.i56.reg2mem = alloca ptr, align 8
  %cmp23.not.i55.reg2mem = alloca i64, align 8
  %i.1.i50.reg2mem146 = alloca i32, align 4
  %s.addr.040.i45.reg2mem148 = alloca ptr, align 8
  %i.041.i44.reg2mem150 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i35.reg2mem = alloca ptr, align 8
  %cmp23.not.i34.reg2mem = alloca i64, align 8
  %i.1.i29.reg2mem152 = alloca i32, align 4
  %s.addr.040.i24.reg2mem154 = alloca ptr, align 8
  %i.041.i23.reg2mem156 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i14.reg2mem = alloca ptr, align 8
  %cmp23.not.i13.reg2mem = alloca i64, align 8
  %i.1.i8.reg2mem158 = alloca i32, align 4
  %s.addr.040.i3.reg2mem160 = alloca ptr, align 8
  %i.041.i2.reg2mem162 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem164 = alloca i32, align 4
  %s.addr.040.i.reg2mem166 = alloca ptr, align 8
  %i.041.i.reg2mem168 = alloca i32, align 4
    #dbg_value(i32 %fd, !482, !DIExpression(), !487)
    #dbg_value(ptr %vdata, !483, !DIExpression(), !487)
    #dbg_value(ptr %vdata, !484, !DIExpression(), !487)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(28672) %vdata, i8 0, i64 28672, i1 false), !dbg !488
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !489
    #dbg_value(ptr %call, !485, !DIExpression(), !487)
    #dbg_value(ptr %call, !490, !DIExpression(), !497)
    #dbg_value(i32 1, !495, !DIExpression(), !497)
    #dbg_value(i32 0, !496, !DIExpression(), !497)
  store ptr %call, ptr %call.reg2mem, align 8
  store ptr %call, ptr %s.addr.040.i.reg2mem166, align 8
  store i32 0, ptr %i.041.i.reg2mem168, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem168.0.load, !496, !DIExpression(), !497)
    #dbg_value(ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, !490, !DIExpression(), !497)
  %i.041.i.reg2mem168.0.load = load i32, ptr %i.041.i.reg2mem168, align 4
  %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167 = load ptr, ptr %s.addr.040.i.reg2mem166, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, align 1, !dbg !499, !tbaa !500
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !501

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !501

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem168.0.load, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !501

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 1, !dbg !502
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !502, !tbaa !500
  %cmp13.i = icmp eq i8 %1, 37, !dbg !505
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !506

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem168.0.load, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !506

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 2, !dbg !507
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !507, !tbaa !500
  %cmp18.i = icmp eq i8 %2, 10, !dbg !508
  %inc.i = zext i1 %cmp18.i to i32, !dbg !509
  %spec.select.i = add nsw i32 %i.041.i.reg2mem168.0.load, %inc.i, !dbg !509
  store i32 %spec.select.i, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !509

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem164.0.load, !496, !DIExpression(), !497)
  %i.1.i.reg2mem164.0.load = load i32, ptr %i.1.i.reg2mem164, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 1, !dbg !510
    #dbg_value(ptr %incdec.ptr.i, !490, !DIExpression(), !497)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem164.0.load, 1, !dbg !511
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !512, !llvm.loop !513

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem166, align 8
  store i32 %i.1.i.reg2mem164.0.load, ptr %i.041.i.reg2mem168, align 4
  br label %land.rhs.i, !dbg !512

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !515, !tbaa !500
  %3 = icmp eq i8 %.pre.i, 0, !dbg !517
  %4 = select i1 %3, i64 0, i64 2, !dbg !518
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !512

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !518
    #dbg_value(ptr %spec.select38.i, !486, !DIExpression(), !487)
  %position_x = getelementptr inbounds i8, ptr %vdata, i64 6144, !dbg !519
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %position_x, i32 noundef signext 256) #18, !dbg !520
    #dbg_value(ptr %call, !490, !DIExpression(), !521)
    #dbg_value(i32 2, !495, !DIExpression(), !521)
    #dbg_value(i32 0, !496, !DIExpression(), !521)
  store ptr %call, ptr %s.addr.040.i3.reg2mem160, align 8
  store i32 0, ptr %i.041.i2.reg2mem162, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem162.0.load, !496, !DIExpression(), !521)
    #dbg_value(ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, !490, !DIExpression(), !521)
  %i.041.i2.reg2mem162.0.load = load i32, ptr %i.041.i2.reg2mem162, align 4
  %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161 = load ptr, ptr %s.addr.040.i3.reg2mem160, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, align 1, !dbg !523, !tbaa !500
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !524

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !524

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem162.0.load, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !524

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 1, !dbg !525
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !525, !tbaa !500
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !526
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !527

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem162.0.load, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !527

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 2, !dbg !528
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !528, !tbaa !500
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !529
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !530
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem162.0.load, %inc.i19, !dbg !530
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !530

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem158.0.load, !496, !DIExpression(), !521)
  %i.1.i8.reg2mem158.0.load = load i32, ptr %i.1.i8.reg2mem158, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 1, !dbg !531
    #dbg_value(ptr %incdec.ptr.i9, !490, !DIExpression(), !521)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem158.0.load, 2, !dbg !532
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !533, !llvm.loop !534

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem160, align 8
  store i32 %i.1.i8.reg2mem158.0.load, ptr %i.041.i2.reg2mem162, align 4
  br label %land.rhs.i1, !dbg !533

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !536, !tbaa !500
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !537
  %9 = select i1 %8, i64 0, i64 2, !dbg !538
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !533

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !538
    #dbg_value(ptr %spec.select38.i15, !486, !DIExpression(), !487)
  %position_y = getelementptr inbounds i8, ptr %vdata, i64 8192, !dbg !539
  %call5 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %position_y, i32 noundef signext 256) #18, !dbg !540
    #dbg_value(ptr %call, !490, !DIExpression(), !541)
    #dbg_value(i32 3, !495, !DIExpression(), !541)
    #dbg_value(i32 0, !496, !DIExpression(), !541)
  store ptr %call, ptr %s.addr.040.i24.reg2mem154, align 8
  store i32 0, ptr %i.041.i23.reg2mem156, align 4
  br label %land.rhs.i22

land.rhs.i22:                                     ; preds = %if.end21.i28.land.rhs.i22_crit_edge, %find_section_start.exit21
    #dbg_value(i32 %i.041.i23.reg2mem156.0.load, !496, !DIExpression(), !541)
    #dbg_value(ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, !490, !DIExpression(), !541)
  %i.041.i23.reg2mem156.0.load = load i32, ptr %i.041.i23.reg2mem156, align 4
  %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155 = load ptr, ptr %s.addr.040.i24.reg2mem154, align 8
  %10 = load i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, align 1, !dbg !543, !tbaa !500
  switch i8 %10, label %land.rhs.i22.if.end21.i28_crit_edge [
    i8 0, label %land.rhs.i22.find_section_start.exit42_crit_edge
    i8 37, label %land.lhs.true10.i25
  ], !dbg !544

land.rhs.i22.find_section_start.exit42_crit_edge: ; preds = %land.rhs.i22
  store ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !544

land.rhs.i22.if.end21.i28_crit_edge:              ; preds = %land.rhs.i22
  store i32 %i.041.i23.reg2mem156.0.load, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !544

land.lhs.true10.i25:                              ; preds = %land.rhs.i22
  %arrayidx11.i26 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 1, !dbg !545
  %11 = load i8, ptr %arrayidx11.i26, align 1, !dbg !545, !tbaa !500
  %cmp13.i27 = icmp eq i8 %11, 37, !dbg !546
  br i1 %cmp13.i27, label %land.lhs.true15.i37, label %land.lhs.true10.i25.if.end21.i28_crit_edge, !dbg !547

land.lhs.true10.i25.if.end21.i28_crit_edge:       ; preds = %land.lhs.true10.i25
  store i32 %i.041.i23.reg2mem156.0.load, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !547

land.lhs.true15.i37:                              ; preds = %land.lhs.true10.i25
  %arrayidx16.i38 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 2, !dbg !548
  %12 = load i8, ptr %arrayidx16.i38, align 1, !dbg !548, !tbaa !500
  %cmp18.i39 = icmp eq i8 %12, 10, !dbg !549
  %inc.i40 = zext i1 %cmp18.i39 to i32, !dbg !550
  %spec.select.i41 = add nsw i32 %i.041.i23.reg2mem156.0.load, %inc.i40, !dbg !550
  store i32 %spec.select.i41, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !550

if.end21.i28:                                     ; preds = %land.lhs.true10.i25.if.end21.i28_crit_edge, %land.rhs.i22.if.end21.i28_crit_edge, %land.lhs.true15.i37
    #dbg_value(i32 %i.1.i29.reg2mem152.0.load, !496, !DIExpression(), !541)
  %i.1.i29.reg2mem152.0.load = load i32, ptr %i.1.i29.reg2mem152, align 4
  %incdec.ptr.i30 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 1, !dbg !551
    #dbg_value(ptr %incdec.ptr.i30, !490, !DIExpression(), !541)
  %cmp4.i31 = icmp slt i32 %i.1.i29.reg2mem152.0.load, 3, !dbg !552
  br i1 %cmp4.i31, label %if.end21.i28.land.rhs.i22_crit_edge, label %if.end21.while.end_crit_edge.i32, !dbg !553, !llvm.loop !554

if.end21.i28.land.rhs.i22_crit_edge:              ; preds = %if.end21.i28
  store ptr %incdec.ptr.i30, ptr %s.addr.040.i24.reg2mem154, align 8
  store i32 %i.1.i29.reg2mem152.0.load, ptr %i.041.i23.reg2mem156, align 4
  br label %land.rhs.i22, !dbg !553

if.end21.while.end_crit_edge.i32:                 ; preds = %if.end21.i28
  %.pre.i33 = load i8, ptr %incdec.ptr.i30, align 1, !dbg !556, !tbaa !500
  %13 = icmp eq i8 %.pre.i33, 0, !dbg !557
  %14 = select i1 %13, i64 0, i64 2, !dbg !558
  store ptr %incdec.ptr.i30, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 %14, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !553

find_section_start.exit42:                        ; preds = %land.rhs.i22.find_section_start.exit42_crit_edge, %if.end21.while.end_crit_edge.i32
  %cmp23.not.i34.reg2mem.0.load = load i64, ptr %cmp23.not.i34.reg2mem, align 8
  %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload = load ptr, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  %spec.select38.i36 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload, i64 %cmp23.not.i34.reg2mem.0.load, !dbg !558
    #dbg_value(ptr %spec.select38.i36, !486, !DIExpression(), !487)
  %position_z = getelementptr inbounds i8, ptr %vdata, i64 10240, !dbg !559
  %call8 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i36, ptr noundef nonnull %position_z, i32 noundef signext 256) #18, !dbg !560
    #dbg_value(ptr %call, !490, !DIExpression(), !561)
    #dbg_value(i32 4, !495, !DIExpression(), !561)
    #dbg_value(i32 0, !496, !DIExpression(), !561)
  store ptr %call, ptr %s.addr.040.i45.reg2mem148, align 8
  store i32 0, ptr %i.041.i44.reg2mem150, align 4
  br label %land.rhs.i43

land.rhs.i43:                                     ; preds = %if.end21.i49.land.rhs.i43_crit_edge, %find_section_start.exit42
    #dbg_value(i32 %i.041.i44.reg2mem150.0.load, !496, !DIExpression(), !561)
    #dbg_value(ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, !490, !DIExpression(), !561)
  %i.041.i44.reg2mem150.0.load = load i32, ptr %i.041.i44.reg2mem150, align 4
  %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149 = load ptr, ptr %s.addr.040.i45.reg2mem148, align 8
  %15 = load i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, align 1, !dbg !563, !tbaa !500
  switch i8 %15, label %land.rhs.i43.if.end21.i49_crit_edge [
    i8 0, label %land.rhs.i43.find_section_start.exit63_crit_edge
    i8 37, label %land.lhs.true10.i46
  ], !dbg !564

land.rhs.i43.find_section_start.exit63_crit_edge: ; preds = %land.rhs.i43
  store ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i55.reg2mem, align 8
  br label %find_section_start.exit63, !dbg !564

land.rhs.i43.if.end21.i49_crit_edge:              ; preds = %land.rhs.i43
  store i32 %i.041.i44.reg2mem150.0.load, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !564

land.lhs.true10.i46:                              ; preds = %land.rhs.i43
  %arrayidx11.i47 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 1, !dbg !565
  %16 = load i8, ptr %arrayidx11.i47, align 1, !dbg !565, !tbaa !500
  %cmp13.i48 = icmp eq i8 %16, 37, !dbg !566
  br i1 %cmp13.i48, label %land.lhs.true15.i58, label %land.lhs.true10.i46.if.end21.i49_crit_edge, !dbg !567

land.lhs.true10.i46.if.end21.i49_crit_edge:       ; preds = %land.lhs.true10.i46
  store i32 %i.041.i44.reg2mem150.0.load, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !567

land.lhs.true15.i58:                              ; preds = %land.lhs.true10.i46
  %arrayidx16.i59 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 2, !dbg !568
  %17 = load i8, ptr %arrayidx16.i59, align 1, !dbg !568, !tbaa !500
  %cmp18.i60 = icmp eq i8 %17, 10, !dbg !569
  %inc.i61 = zext i1 %cmp18.i60 to i32, !dbg !570
  %spec.select.i62 = add nsw i32 %i.041.i44.reg2mem150.0.load, %inc.i61, !dbg !570
  store i32 %spec.select.i62, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !570

if.end21.i49:                                     ; preds = %land.lhs.true10.i46.if.end21.i49_crit_edge, %land.rhs.i43.if.end21.i49_crit_edge, %land.lhs.true15.i58
    #dbg_value(i32 %i.1.i50.reg2mem146.0.load, !496, !DIExpression(), !561)
  %i.1.i50.reg2mem146.0.load = load i32, ptr %i.1.i50.reg2mem146, align 4
  %incdec.ptr.i51 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 1, !dbg !571
    #dbg_value(ptr %incdec.ptr.i51, !490, !DIExpression(), !561)
  %cmp4.i52 = icmp slt i32 %i.1.i50.reg2mem146.0.load, 4, !dbg !572
  br i1 %cmp4.i52, label %if.end21.i49.land.rhs.i43_crit_edge, label %if.end21.while.end_crit_edge.i53, !dbg !573, !llvm.loop !574

if.end21.i49.land.rhs.i43_crit_edge:              ; preds = %if.end21.i49
  store ptr %incdec.ptr.i51, ptr %s.addr.040.i45.reg2mem148, align 8
  store i32 %i.1.i50.reg2mem146.0.load, ptr %i.041.i44.reg2mem150, align 4
  br label %land.rhs.i43, !dbg !573

if.end21.while.end_crit_edge.i53:                 ; preds = %if.end21.i49
  %.pre.i54 = load i8, ptr %incdec.ptr.i51, align 1, !dbg !576, !tbaa !500
  %18 = icmp eq i8 %.pre.i54, 0, !dbg !577
  %19 = select i1 %18, i64 0, i64 2, !dbg !578
  store ptr %incdec.ptr.i51, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  store i64 %19, ptr %cmp23.not.i55.reg2mem, align 8
  br label %find_section_start.exit63, !dbg !573

find_section_start.exit63:                        ; preds = %land.rhs.i43.find_section_start.exit63_crit_edge, %if.end21.while.end_crit_edge.i53
  %cmp23.not.i55.reg2mem.0.load = load i64, ptr %cmp23.not.i55.reg2mem, align 8
  %s.addr.0.lcssa.ph.i56.reg2mem.0.s.addr.0.lcssa.ph.i56.reload = load ptr, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  %spec.select38.i57 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i56.reg2mem.0.s.addr.0.lcssa.ph.i56.reload, i64 %cmp23.not.i55.reg2mem.0.load, !dbg !578
    #dbg_value(ptr %spec.select38.i57, !486, !DIExpression(), !487)
  %NL = getelementptr inbounds i8, ptr %vdata, i64 12288, !dbg !579
  %call11 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i57, ptr noundef nonnull %NL, i32 noundef signext 4096) #18, !dbg !580
  %call.reg2mem.0.call.reload145 = load ptr, ptr %call.reg2mem, align 8
  tail call void @free(ptr noundef %call.reg2mem.0.call.reload145) #18, !dbg !581
  ret void, !dbg !582
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !583 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #4

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #2 !dbg !585 {
entry.split:
  %indvars.iv.i34.reg2mem = alloca i64, align 8
  %indvars.iv.i22.reg2mem = alloca i64, align 8
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !587, !DIExpression(), !590)
    #dbg_value(ptr %vdata, !588, !DIExpression(), !590)
    #dbg_value(ptr %vdata, !589, !DIExpression(), !590)
    #dbg_value(i32 %fd, !591, !DIExpression(), !596)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !598
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !598

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !598
  unreachable, !dbg !598

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !601
  %position_x = getelementptr inbounds i8, ptr %vdata, i64 6144, !dbg !602
    #dbg_value(i32 %fd, !603, !DIExpression(), !611)
    #dbg_value(ptr %position_x, !608, !DIExpression(), !611)
    #dbg_value(i32 256, !609, !DIExpression(), !611)
    #dbg_value(i32 0, !610, !DIExpression(), !611)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !613

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !610, !DIExpression(), !611)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %position_x, i64 %indvars.iv.i.reg2mem.0.load, !dbg !615
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !615, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !615
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !618
    #dbg_value(i64 %indvars.iv.next.i, !610, !DIExpression(), !611)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 256, !dbg !618
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !613, !llvm.loop !619

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !613

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !591, !DIExpression(), !620)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !622
  %position_y = getelementptr inbounds i8, ptr %vdata, i64 8192, !dbg !623
    #dbg_value(i32 %fd, !603, !DIExpression(), !624)
    #dbg_value(ptr %position_y, !608, !DIExpression(), !624)
    #dbg_value(i32 256, !609, !DIExpression(), !624)
    #dbg_value(i32 0, !610, !DIExpression(), !624)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !626

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !610, !DIExpression(), !624)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds double, ptr %position_y, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !627
  %1 = load double, ptr %arrayidx.i11, align 8, !dbg !627, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %1), !dbg !627
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !628
    #dbg_value(i64 %indvars.iv.next.i12, !610, !DIExpression(), !624)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 256, !dbg !628
  br i1 %exitcond.not.i13, label %for.cond.preheader.i20, label %for.body.i9.for.body.i9_crit_edge, !dbg !626, !llvm.loop !629

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !626

for.cond.preheader.i20:                           ; preds = %for.body.i9
    #dbg_value(i32 %fd, !591, !DIExpression(), !630)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !632
  %position_z = getelementptr inbounds i8, ptr %vdata, i64 10240, !dbg !633
    #dbg_value(i32 %fd, !603, !DIExpression(), !634)
    #dbg_value(ptr %position_z, !608, !DIExpression(), !634)
    #dbg_value(i32 256, !609, !DIExpression(), !634)
    #dbg_value(i32 0, !610, !DIExpression(), !634)
  store i64 0, ptr %indvars.iv.i22.reg2mem, align 8
  br label %for.body.i21, !dbg !636

for.body.i21:                                     ; preds = %for.body.i21.for.body.i21_crit_edge, %for.cond.preheader.i20
    #dbg_value(i64 %indvars.iv.i22.reg2mem.0.load, !610, !DIExpression(), !634)
  %indvars.iv.i22.reg2mem.0.load = load i64, ptr %indvars.iv.i22.reg2mem, align 8
  %arrayidx.i23 = getelementptr inbounds double, ptr %position_z, i64 %indvars.iv.i22.reg2mem.0.load, !dbg !637
  %2 = load double, ptr %arrayidx.i23, align 8, !dbg !637, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %2), !dbg !637
  %indvars.iv.next.i24 = add nuw nsw i64 %indvars.iv.i22.reg2mem.0.load, 1, !dbg !638
    #dbg_value(i64 %indvars.iv.next.i24, !610, !DIExpression(), !634)
  %exitcond.not.i25 = icmp eq i64 %indvars.iv.next.i24, 256, !dbg !638
  br i1 %exitcond.not.i25, label %for.cond.preheader.i32, label %for.body.i21.for.body.i21_crit_edge, !dbg !636, !llvm.loop !639

for.body.i21.for.body.i21_crit_edge:              ; preds = %for.body.i21
  store i64 %indvars.iv.next.i24, ptr %indvars.iv.i22.reg2mem, align 8
  br label %for.body.i21, !dbg !636

for.cond.preheader.i32:                           ; preds = %for.body.i21
    #dbg_value(i32 %fd, !591, !DIExpression(), !640)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !642
  %NL = getelementptr inbounds i8, ptr %vdata, i64 12288, !dbg !643
    #dbg_value(i32 %fd, !644, !DIExpression(), !652)
    #dbg_value(ptr %NL, !649, !DIExpression(), !652)
    #dbg_value(i32 4096, !650, !DIExpression(), !652)
    #dbg_value(i32 0, !651, !DIExpression(), !652)
  store i64 0, ptr %indvars.iv.i34.reg2mem, align 8
  br label %for.body.i33, !dbg !654

for.body.i33:                                     ; preds = %for.body.i33.for.body.i33_crit_edge, %for.cond.preheader.i32
    #dbg_value(i64 %indvars.iv.i34.reg2mem.0.load, !651, !DIExpression(), !652)
  %indvars.iv.i34.reg2mem.0.load = load i64, ptr %indvars.iv.i34.reg2mem, align 8
  %arrayidx.i35 = getelementptr inbounds i32, ptr %NL, i64 %indvars.iv.i34.reg2mem.0.load, !dbg !656
  %3 = load i32, ptr %arrayidx.i35, align 4, !dbg !656, !tbaa !381
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %3), !dbg !656
  %indvars.iv.next.i36 = add nuw nsw i64 %indvars.iv.i34.reg2mem.0.load, 1, !dbg !659
    #dbg_value(i64 %indvars.iv.next.i36, !651, !DIExpression(), !652)
  %exitcond.not.i37 = icmp eq i64 %indvars.iv.next.i36, 4096, !dbg !659
  br i1 %exitcond.not.i37, label %write_int32_t_array.exit, label %for.body.i33.for.body.i33_crit_edge, !dbg !654, !llvm.loop !660

for.body.i33.for.body.i33_crit_edge:              ; preds = %for.body.i33
  store i64 %indvars.iv.next.i36, ptr %indvars.iv.i34.reg2mem, align 8
  br label %for.body.i33, !dbg !654

write_int32_t_array.exit:                         ; preds = %for.body.i33
  ret void, !dbg !661
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #2 !dbg !662 {
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
    #dbg_value(i32 %fd, !664, !DIExpression(), !669)
    #dbg_value(ptr %vdata, !665, !DIExpression(), !669)
    #dbg_value(ptr %vdata, !666, !DIExpression(), !669)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(28672) %vdata, i8 0, i64 28672, i1 false), !dbg !670
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !671
    #dbg_value(ptr %call, !667, !DIExpression(), !669)
    #dbg_value(ptr %call, !490, !DIExpression(), !672)
    #dbg_value(i32 1, !495, !DIExpression(), !672)
    #dbg_value(i32 0, !496, !DIExpression(), !672)
  store ptr %call, ptr %s.addr.040.i.reg2mem118, align 8
  store i32 0, ptr %i.041.i.reg2mem120, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem120.0.load, !496, !DIExpression(), !672)
    #dbg_value(ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, !490, !DIExpression(), !672)
  %i.041.i.reg2mem120.0.load = load i32, ptr %i.041.i.reg2mem120, align 4
  %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119 = load ptr, ptr %s.addr.040.i.reg2mem118, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, align 1, !dbg !674, !tbaa !500
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !675

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !675

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem120.0.load, ptr %i.1.i.reg2mem116, align 4
  br label %if.end21.i, !dbg !675

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, i64 1, !dbg !676
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !676, !tbaa !500
  %cmp13.i = icmp eq i8 %1, 37, !dbg !677
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !678

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem120.0.load, ptr %i.1.i.reg2mem116, align 4
  br label %if.end21.i, !dbg !678

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, i64 2, !dbg !679
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !679, !tbaa !500
  %cmp18.i = icmp eq i8 %2, 10, !dbg !680
  %inc.i = zext i1 %cmp18.i to i32, !dbg !681
  %spec.select.i = add nsw i32 %i.041.i.reg2mem120.0.load, %inc.i, !dbg !681
  store i32 %spec.select.i, ptr %i.1.i.reg2mem116, align 4
  br label %if.end21.i, !dbg !681

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem116.0.load, !496, !DIExpression(), !672)
  %i.1.i.reg2mem116.0.load = load i32, ptr %i.1.i.reg2mem116, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem118.0.s.addr.040.i.reload119, i64 1, !dbg !682
    #dbg_value(ptr %incdec.ptr.i, !490, !DIExpression(), !672)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem116.0.load, 1, !dbg !683
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !684, !llvm.loop !685

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem118, align 8
  store i32 %i.1.i.reg2mem116.0.load, ptr %i.041.i.reg2mem120, align 4
  br label %land.rhs.i, !dbg !684

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !687, !tbaa !500
  %3 = icmp eq i8 %.pre.i, 0, !dbg !688
  %4 = select i1 %3, i64 0, i64 2, !dbg !689
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !684

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !689
    #dbg_value(ptr %spec.select38.i, !668, !DIExpression(), !669)
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 256) #18, !dbg !690
    #dbg_value(ptr %call, !490, !DIExpression(), !691)
    #dbg_value(i32 2, !495, !DIExpression(), !691)
    #dbg_value(i32 0, !496, !DIExpression(), !691)
  store ptr %call, ptr %s.addr.040.i3.reg2mem112, align 8
  store i32 0, ptr %i.041.i2.reg2mem114, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem114.0.load, !496, !DIExpression(), !691)
    #dbg_value(ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, !490, !DIExpression(), !691)
  %i.041.i2.reg2mem114.0.load = load i32, ptr %i.041.i2.reg2mem114, align 4
  %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113 = load ptr, ptr %s.addr.040.i3.reg2mem112, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, align 1, !dbg !693, !tbaa !500
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !694

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !694

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem114.0.load, ptr %i.1.i8.reg2mem110, align 4
  br label %if.end21.i7, !dbg !694

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, i64 1, !dbg !695
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !695, !tbaa !500
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !696
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !697

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem114.0.load, ptr %i.1.i8.reg2mem110, align 4
  br label %if.end21.i7, !dbg !697

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, i64 2, !dbg !698
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !698, !tbaa !500
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !699
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !700
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem114.0.load, %inc.i19, !dbg !700
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem110, align 4
  br label %if.end21.i7, !dbg !700

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem110.0.load, !496, !DIExpression(), !691)
  %i.1.i8.reg2mem110.0.load = load i32, ptr %i.1.i8.reg2mem110, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem112.0.s.addr.040.i3.reload113, i64 1, !dbg !701
    #dbg_value(ptr %incdec.ptr.i9, !490, !DIExpression(), !691)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem110.0.load, 2, !dbg !702
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !703, !llvm.loop !704

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem112, align 8
  store i32 %i.1.i8.reg2mem110.0.load, ptr %i.041.i2.reg2mem114, align 4
  br label %land.rhs.i1, !dbg !703

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !706, !tbaa !500
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !707
  %9 = select i1 %8, i64 0, i64 2, !dbg !708
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !703

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !708
    #dbg_value(ptr %spec.select38.i15, !668, !DIExpression(), !669)
  %force_y = getelementptr inbounds i8, ptr %vdata, i64 2048, !dbg !709
  %call5 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %force_y, i32 noundef signext 256) #18, !dbg !710
    #dbg_value(ptr %call, !490, !DIExpression(), !711)
    #dbg_value(i32 3, !495, !DIExpression(), !711)
    #dbg_value(i32 0, !496, !DIExpression(), !711)
  store ptr %call, ptr %s.addr.040.i24.reg2mem106, align 8
  store i32 0, ptr %i.041.i23.reg2mem108, align 4
  br label %land.rhs.i22

land.rhs.i22:                                     ; preds = %if.end21.i28.land.rhs.i22_crit_edge, %find_section_start.exit21
    #dbg_value(i32 %i.041.i23.reg2mem108.0.load, !496, !DIExpression(), !711)
    #dbg_value(ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, !490, !DIExpression(), !711)
  %i.041.i23.reg2mem108.0.load = load i32, ptr %i.041.i23.reg2mem108, align 4
  %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107 = load ptr, ptr %s.addr.040.i24.reg2mem106, align 8
  %10 = load i8, ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, align 1, !dbg !713, !tbaa !500
  switch i8 %10, label %land.rhs.i22.if.end21.i28_crit_edge [
    i8 0, label %land.rhs.i22.find_section_start.exit42_crit_edge
    i8 37, label %land.lhs.true10.i25
  ], !dbg !714

land.rhs.i22.find_section_start.exit42_crit_edge: ; preds = %land.rhs.i22
  store ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !714

land.rhs.i22.if.end21.i28_crit_edge:              ; preds = %land.rhs.i22
  store i32 %i.041.i23.reg2mem108.0.load, ptr %i.1.i29.reg2mem104, align 4
  br label %if.end21.i28, !dbg !714

land.lhs.true10.i25:                              ; preds = %land.rhs.i22
  %arrayidx11.i26 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, i64 1, !dbg !715
  %11 = load i8, ptr %arrayidx11.i26, align 1, !dbg !715, !tbaa !500
  %cmp13.i27 = icmp eq i8 %11, 37, !dbg !716
  br i1 %cmp13.i27, label %land.lhs.true15.i37, label %land.lhs.true10.i25.if.end21.i28_crit_edge, !dbg !717

land.lhs.true10.i25.if.end21.i28_crit_edge:       ; preds = %land.lhs.true10.i25
  store i32 %i.041.i23.reg2mem108.0.load, ptr %i.1.i29.reg2mem104, align 4
  br label %if.end21.i28, !dbg !717

land.lhs.true15.i37:                              ; preds = %land.lhs.true10.i25
  %arrayidx16.i38 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, i64 2, !dbg !718
  %12 = load i8, ptr %arrayidx16.i38, align 1, !dbg !718, !tbaa !500
  %cmp18.i39 = icmp eq i8 %12, 10, !dbg !719
  %inc.i40 = zext i1 %cmp18.i39 to i32, !dbg !720
  %spec.select.i41 = add nsw i32 %i.041.i23.reg2mem108.0.load, %inc.i40, !dbg !720
  store i32 %spec.select.i41, ptr %i.1.i29.reg2mem104, align 4
  br label %if.end21.i28, !dbg !720

if.end21.i28:                                     ; preds = %land.lhs.true10.i25.if.end21.i28_crit_edge, %land.rhs.i22.if.end21.i28_crit_edge, %land.lhs.true15.i37
    #dbg_value(i32 %i.1.i29.reg2mem104.0.load, !496, !DIExpression(), !711)
  %i.1.i29.reg2mem104.0.load = load i32, ptr %i.1.i29.reg2mem104, align 4
  %incdec.ptr.i30 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem106.0.s.addr.040.i24.reload107, i64 1, !dbg !721
    #dbg_value(ptr %incdec.ptr.i30, !490, !DIExpression(), !711)
  %cmp4.i31 = icmp slt i32 %i.1.i29.reg2mem104.0.load, 3, !dbg !722
  br i1 %cmp4.i31, label %if.end21.i28.land.rhs.i22_crit_edge, label %if.end21.while.end_crit_edge.i32, !dbg !723, !llvm.loop !724

if.end21.i28.land.rhs.i22_crit_edge:              ; preds = %if.end21.i28
  store ptr %incdec.ptr.i30, ptr %s.addr.040.i24.reg2mem106, align 8
  store i32 %i.1.i29.reg2mem104.0.load, ptr %i.041.i23.reg2mem108, align 4
  br label %land.rhs.i22, !dbg !723

if.end21.while.end_crit_edge.i32:                 ; preds = %if.end21.i28
  %.pre.i33 = load i8, ptr %incdec.ptr.i30, align 1, !dbg !726, !tbaa !500
  %13 = icmp eq i8 %.pre.i33, 0, !dbg !727
  %14 = select i1 %13, i64 0, i64 2, !dbg !728
  store ptr %incdec.ptr.i30, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 %14, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !723

find_section_start.exit42:                        ; preds = %land.rhs.i22.find_section_start.exit42_crit_edge, %if.end21.while.end_crit_edge.i32
  %cmp23.not.i34.reg2mem.0.load = load i64, ptr %cmp23.not.i34.reg2mem, align 8
  %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload = load ptr, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  %spec.select38.i36 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload, i64 %cmp23.not.i34.reg2mem.0.load, !dbg !728
    #dbg_value(ptr %spec.select38.i36, !668, !DIExpression(), !669)
  %force_z = getelementptr inbounds i8, ptr %vdata, i64 4096, !dbg !729
  %call8 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i36, ptr noundef nonnull %force_z, i32 noundef signext 256) #18, !dbg !730
  tail call void @free(ptr noundef %call) #18, !dbg !731
  ret void, !dbg !732
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #2 !dbg !733 {
entry.split:
  %indvars.iv.i22.reg2mem = alloca i64, align 8
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !735, !DIExpression(), !738)
    #dbg_value(ptr %vdata, !736, !DIExpression(), !738)
    #dbg_value(ptr %vdata, !737, !DIExpression(), !738)
    #dbg_value(i32 %fd, !591, !DIExpression(), !739)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !741
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !741

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !741
  unreachable, !dbg !741

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !742
    #dbg_value(i32 %fd, !603, !DIExpression(), !743)
    #dbg_value(ptr %vdata, !608, !DIExpression(), !743)
    #dbg_value(i32 256, !609, !DIExpression(), !743)
    #dbg_value(i32 0, !610, !DIExpression(), !743)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !745

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !610, !DIExpression(), !743)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !746
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !746, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !746
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !747
    #dbg_value(i64 %indvars.iv.next.i, !610, !DIExpression(), !743)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 256, !dbg !747
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !745, !llvm.loop !748

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !745

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !591, !DIExpression(), !749)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !751
  %force_y = getelementptr inbounds i8, ptr %vdata, i64 2048, !dbg !752
    #dbg_value(i32 %fd, !603, !DIExpression(), !753)
    #dbg_value(ptr %force_y, !608, !DIExpression(), !753)
    #dbg_value(i32 256, !609, !DIExpression(), !753)
    #dbg_value(i32 0, !610, !DIExpression(), !753)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !755

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !610, !DIExpression(), !753)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds double, ptr %force_y, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !756
  %1 = load double, ptr %arrayidx.i11, align 8, !dbg !756, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %1), !dbg !756
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !757
    #dbg_value(i64 %indvars.iv.next.i12, !610, !DIExpression(), !753)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 256, !dbg !757
  br i1 %exitcond.not.i13, label %for.cond.preheader.i20, label %for.body.i9.for.body.i9_crit_edge, !dbg !755, !llvm.loop !758

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !755

for.cond.preheader.i20:                           ; preds = %for.body.i9
    #dbg_value(i32 %fd, !591, !DIExpression(), !759)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !761
  %force_z = getelementptr inbounds i8, ptr %vdata, i64 4096, !dbg !762
    #dbg_value(i32 %fd, !603, !DIExpression(), !763)
    #dbg_value(ptr %force_z, !608, !DIExpression(), !763)
    #dbg_value(i32 256, !609, !DIExpression(), !763)
    #dbg_value(i32 0, !610, !DIExpression(), !763)
  store i64 0, ptr %indvars.iv.i22.reg2mem, align 8
  br label %for.body.i21, !dbg !765

for.body.i21:                                     ; preds = %for.body.i21.for.body.i21_crit_edge, %for.cond.preheader.i20
    #dbg_value(i64 %indvars.iv.i22.reg2mem.0.load, !610, !DIExpression(), !763)
  %indvars.iv.i22.reg2mem.0.load = load i64, ptr %indvars.iv.i22.reg2mem, align 8
  %arrayidx.i23 = getelementptr inbounds double, ptr %force_z, i64 %indvars.iv.i22.reg2mem.0.load, !dbg !766
  %2 = load double, ptr %arrayidx.i23, align 8, !dbg !766, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %2), !dbg !766
  %indvars.iv.next.i24 = add nuw nsw i64 %indvars.iv.i22.reg2mem.0.load, 1, !dbg !767
    #dbg_value(i64 %indvars.iv.next.i24, !610, !DIExpression(), !763)
  %exitcond.not.i25 = icmp eq i64 %indvars.iv.next.i24, 256, !dbg !767
  br i1 %exitcond.not.i25, label %write_double_array.exit26, label %for.body.i21.for.body.i21_crit_edge, !dbg !765, !llvm.loop !768

for.body.i21.for.body.i21_crit_edge:              ; preds = %for.body.i21
  store i64 %indvars.iv.next.i24, ptr %indvars.iv.i22.reg2mem, align 8
  br label %for.body.i21, !dbg !765

write_double_array.exit26:                        ; preds = %for.body.i21
  ret void, !dbg !769
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #5 !dbg !770 {
entry.split:
  %has_errors.048.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(ptr %vdata, !774, !DIExpression(), !783)
    #dbg_value(ptr %vref, !775, !DIExpression(), !783)
    #dbg_value(ptr %vdata, !776, !DIExpression(), !783)
    #dbg_value(ptr %vref, !777, !DIExpression(), !783)
    #dbg_value(i32 0, !778, !DIExpression(), !783)
    #dbg_value(i32 0, !779, !DIExpression(), !783)
  store i32 0, ptr %has_errors.048.reg2mem, align 4
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !784

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i32 %has_errors.048.reg2mem.0.load, !778, !DIExpression(), !783)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !779, !DIExpression(), !783)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %has_errors.048.reg2mem.0.load = load i32, ptr %has_errors.048.reg2mem, align 4
  %arrayidx = getelementptr inbounds [256 x double], ptr %vdata, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !786
  %0 = load double, ptr %arrayidx, align 8, !dbg !786, !tbaa !386
  %arrayidx3 = getelementptr inbounds [256 x double], ptr %vref, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !789
  %1 = load double, ptr %arrayidx3, align 8, !dbg !789, !tbaa !386
  %sub = fsub double %0, %1, !dbg !790
    #dbg_value(double %sub, !780, !DIExpression(), !783)
  %arrayidx5 = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 1, i64 %indvars.iv.reg2mem.0.load, !dbg !791
  %2 = load double, ptr %arrayidx5, align 8, !dbg !791, !tbaa !386
  %arrayidx8 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 1, i64 %indvars.iv.reg2mem.0.load, !dbg !792
  %3 = load double, ptr %arrayidx8, align 8, !dbg !792, !tbaa !386
  %sub9 = fsub double %2, %3, !dbg !793
    #dbg_value(double %sub9, !781, !DIExpression(), !783)
  %arrayidx11 = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 2, i64 %indvars.iv.reg2mem.0.load, !dbg !794
  %4 = load double, ptr %arrayidx11, align 8, !dbg !794, !tbaa !386
  %arrayidx14 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 2, i64 %indvars.iv.reg2mem.0.load, !dbg !795
  %5 = load double, ptr %arrayidx14, align 8, !dbg !795, !tbaa !386
  %sub15 = fsub double %4, %5, !dbg !796
    #dbg_value(double %sub15, !782, !DIExpression(), !783)
  %6 = tail call double @llvm.fabs.f64(double %sub), !dbg !797
  %7 = fcmp ogt double %6, 0x3EB0C6F7A0B5ED8D, !dbg !797
    #dbg_value(!DIArgList(i32 %has_errors.048.reg2mem.0.load, i1 %7), !778, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !783)
  %8 = tail call double @llvm.fabs.f64(double %sub9), !dbg !798
  %9 = fcmp ogt double %8, 0x3EB0C6F7A0B5ED8D, !dbg !798
  %10 = or i1 %7, %9, !dbg !799
    #dbg_value(!DIArgList(i32 %has_errors.048.reg2mem.0.load, i1 %10), !778, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !783)
  %11 = tail call double @llvm.fabs.f64(double %sub15), !dbg !800
  %12 = fcmp ogt double %11, 0x3EB0C6F7A0B5ED8D, !dbg !800
  %13 = or i1 %10, %12, !dbg !801
  %14 = zext i1 %13 to i32, !dbg !801
  %or29 = or i32 %has_errors.048.reg2mem.0.load, %14, !dbg !801
    #dbg_value(i32 %or29, !778, !DIExpression(), !783)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !802
    #dbg_value(i64 %indvars.iv.next, !779, !DIExpression(), !783)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 256, !dbg !803
  br i1 %exitcond.not, label %for.end, label %for.body.for.body_crit_edge, !dbg !784, !llvm.loop !804

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i32 %or29, ptr %has_errors.048.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !784

for.end:                                          ; preds = %for.body
  %tobool.not = icmp eq i32 %or29, 0, !dbg !806
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !806
  ret i32 %lnot.ext, !dbg !807
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #2 !dbg !808 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !858
    #dbg_assign(i1 undef, !814, !DIExpression(), !858, ptr %s, !DIExpression(), !859)
    #dbg_value(i32 %fd, !812, !DIExpression(), !859)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #18, !dbg !860
  %cmp = icmp sgt i32 %fd, 1, !dbg !861
  br i1 %cmp, label %if.end, label %if.else, !dbg !861

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !861
  unreachable, !dbg !861

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #18, !dbg !864
  %cmp1 = icmp eq i32 %call, 0, !dbg !864
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !864

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !864
  unreachable, !dbg !864

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !867
  %0 = load i64, ptr %st_size, align 8, !dbg !867
    #dbg_value(i64 %0, !851, !DIExpression(), !859)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !868
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !868

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !868
  unreachable, !dbg !868

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !871
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #20, !dbg !872
    #dbg_value(ptr %call11, !813, !DIExpression(), !859)
    #dbg_value(i64 0, !854, !DIExpression(), !859)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !873

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !874
    #dbg_value(i64 %add19, !854, !DIExpression(), !859)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !876
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !873, !llvm.loop !877

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !873

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !854, !DIExpression(), !859)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !879
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !880
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #18, !dbg !881
    #dbg_value(i64 %call13, !857, !DIExpression(), !859)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !882
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !854, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !859)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !882

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !882
  unreachable, !dbg !882

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !885
  store i8 0, ptr %arrayidx20, align 1, !dbg !886, !tbaa !500
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #18, !dbg !887
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #18, !dbg !888
  ret ptr %call11, !dbg !889
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: noreturn nounwind
declare !dbg !890 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare !dbg !895 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !900 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #9

; Function Attrs: nofree
declare !dbg !905 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #10

declare !dbg !909 signext i32 @close(i32 noundef signext) local_unnamed_addr #11

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #2 !dbg !491 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !490, !DIExpression(), !910)
    #dbg_value(i32 %n, !495, !DIExpression(), !910)
    #dbg_value(i32 0, !496, !DIExpression(), !910)
  %cmp = icmp sgt i32 %n, -1, !dbg !911
  br i1 %cmp, label %if.end, label %if.else, !dbg !911

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #19, !dbg !911
  unreachable, !dbg !911

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !914
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !916

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !916

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !916

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !496, !DIExpression(), !910)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !490, !DIExpression(), !910)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !917, !tbaa !500
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !918

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !918

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !918

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !919
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !919, !tbaa !500
  %cmp13 = icmp eq i8 %1, 37, !dbg !920
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !921

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !921

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !922
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !922, !tbaa !500
  %cmp18 = icmp eq i8 %2, 10, !dbg !923
  %inc = zext i1 %cmp18 to i32, !dbg !924
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !924
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !924

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !496, !DIExpression(), !910)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !925
    #dbg_value(ptr %incdec.ptr, !490, !DIExpression(), !910)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !926
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !927, !llvm.loop !928

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !927

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !930, !tbaa !500
  %3 = icmp eq i8 %.pre, 0, !dbg !931
  %4 = select i1 %3, i64 0, i64 2, !dbg !932
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !927

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !932
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !932

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !933
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !934 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !938, !DIExpression(), !942)
    #dbg_value(ptr %arr, !939, !DIExpression(), !942)
    #dbg_value(i32 %n, !940, !DIExpression(), !942)
  %cmp.not = icmp eq ptr %s, null, !dbg !943
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !943

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #19, !dbg !943
  unreachable, !dbg !943

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !946
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !948

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !949
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !951
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !951

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !941, !DIExpression(), !942)
  %conv404 = zext nneg i32 %n to i64, !dbg !952
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !953
  br label %if.end46, !dbg !954

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !941, !DIExpression(), !942)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !955
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !956

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !956

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !957
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !958
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !958
  %cmp9.not = icmp eq i8 %0, 0, !dbg !959
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !960

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !960

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !961
  %1 = load i8, ptr %gep, align 1, !dbg !961
  %cmp16.not = icmp eq i8 %1, 0, !dbg !962
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !963

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !963

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !964
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !965
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !965
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !965, !llvm.loop !966

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !965

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !952

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !952

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !952

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !952
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !941, !DIExpression(), !942)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !953
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !968
  store i8 0, ptr %arrayidx45, align 1, !dbg !970, !tbaa !500
  br label %if.end46, !dbg !968

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !971
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !972 {
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
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !986
    #dbg_value(i32 0, !982, !DIExpression(), !985)
  %cmp.not = icmp eq ptr %s, null, !dbg !987
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !987

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #19, !dbg !987
  unreachable, !dbg !987

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !986
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
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !990, !tbaa !992, !DIAssignID !994
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !981, !DIExpression(), !994, ptr %endptr, !DIExpression(), !985)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !990
  %conv = trunc i64 %call3 to i8, !dbg !990
    #dbg_value(i8 %conv, !983, !DIExpression(), !985)
  %2 = load ptr, ptr %endptr, align 8, !dbg !995, !tbaa !992
  %3 = load i8, ptr %2, align 1, !dbg !995, !tbaa !500
  %cmp5.not = icmp eq i8 %3, 0, !dbg !995
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !990

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !990

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !997, !tbaa !992
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !997
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !997
  br label %if.end9, !dbg !997

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !990
  store i8 %conv, ptr %arrayidx, align 1, !dbg !990, !tbaa !500
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !990
    #dbg_value(i64 %indvars.iv.next, !982, !DIExpression(), !985)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !990
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !990
  store i8 10, ptr %arrayidx11, align 1, !dbg !990, !tbaa !500
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !990
    #dbg_value(ptr %call12, !980, !DIExpression(), !985)
  %cmp1 = icmp ne ptr %call12, null, !dbg !986
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !986
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !986
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !986, !llvm.loop !999

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
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1000
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1000
  store i8 10, ptr %arrayidx17, align 1, !dbg !1000, !tbaa !500
  br label %if.end18, !dbg !1000

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !986
  ret i32 0, !dbg !986
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1003 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #13

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1009 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #13

; Function Attrs: nofree nounwind
declare !dbg !1014 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !1069 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #14

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1072 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1084
    #dbg_assign(i1 undef, !1081, !DIExpression(), !1084, ptr %endptr, !DIExpression(), !1085)
    #dbg_value(ptr %s, !1077, !DIExpression(), !1085)
    #dbg_value(ptr %arr, !1078, !DIExpression(), !1085)
    #dbg_value(i32 %n, !1079, !DIExpression(), !1085)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1086
    #dbg_value(i32 0, !1082, !DIExpression(), !1085)
  %cmp.not = icmp eq ptr %s, null, !dbg !1087
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1087

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #19, !dbg !1087
  unreachable, !dbg !1087

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1086
    #dbg_value(ptr %call, !1080, !DIExpression(), !1085)
    #dbg_value(i32 0, !1082, !DIExpression(), !1085)
  %cmp130 = icmp ne ptr %call, null, !dbg !1086
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1086
  %0 = and i1 %cmp231, %cmp130, !dbg !1086
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1086

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1086

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1086
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1086

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1080, !DIExpression(), !1085)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1082, !DIExpression(), !1085)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1090, !tbaa !992, !DIAssignID !1092
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1081, !DIExpression(), !1092, ptr %endptr, !DIExpression(), !1085)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1090
  %conv = trunc i64 %call3 to i16, !dbg !1090
    #dbg_value(i16 %conv, !1083, !DIExpression(), !1085)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1093, !tbaa !992
  %3 = load i8, ptr %2, align 1, !dbg !1093, !tbaa !500
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1093
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1090

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1090

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1095, !tbaa !992
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1095
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1095
  br label %if.end9, !dbg !1095

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1090
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1090, !tbaa !1097
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1090
    #dbg_value(i64 %indvars.iv.next, !1082, !DIExpression(), !1085)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1090
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1090
  store i8 10, ptr %arrayidx11, align 1, !dbg !1090, !tbaa !500
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1090
    #dbg_value(ptr %call12, !1080, !DIExpression(), !1085)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1086
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1086
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1086
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1086, !llvm.loop !1099

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1086

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1086

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1086

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1086

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1100
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1100
  store i8 10, ptr %arrayidx17, align 1, !dbg !1100, !tbaa !500
  br label %if.end18, !dbg !1100

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1086
  ret i32 0, !dbg !1086
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1103 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1115
    #dbg_assign(i1 undef, !1112, !DIExpression(), !1115, ptr %endptr, !DIExpression(), !1116)
    #dbg_value(ptr %s, !1108, !DIExpression(), !1116)
    #dbg_value(ptr %arr, !1109, !DIExpression(), !1116)
    #dbg_value(i32 %n, !1110, !DIExpression(), !1116)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1117
    #dbg_value(i32 0, !1113, !DIExpression(), !1116)
  %cmp.not = icmp eq ptr %s, null, !dbg !1118
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1118

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #19, !dbg !1118
  unreachable, !dbg !1118

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1117
    #dbg_value(ptr %call, !1111, !DIExpression(), !1116)
    #dbg_value(i32 0, !1113, !DIExpression(), !1116)
  %cmp130 = icmp ne ptr %call, null, !dbg !1117
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1117
  %0 = and i1 %cmp231, %cmp130, !dbg !1117
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1117

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1117

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1117
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1117

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1111, !DIExpression(), !1116)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1113, !DIExpression(), !1116)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1121, !tbaa !992, !DIAssignID !1123
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1112, !DIExpression(), !1123, ptr %endptr, !DIExpression(), !1116)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1121
  %conv = trunc i64 %call3 to i32, !dbg !1121
    #dbg_value(i32 %conv, !1114, !DIExpression(), !1116)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1124, !tbaa !992
  %3 = load i8, ptr %2, align 1, !dbg !1124, !tbaa !500
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1124
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1121

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1121

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1126, !tbaa !992
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1126
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1126
  br label %if.end9, !dbg !1126

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1121
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1121, !tbaa !381
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1121
    #dbg_value(i64 %indvars.iv.next, !1113, !DIExpression(), !1116)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1121
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1121
  store i8 10, ptr %arrayidx11, align 1, !dbg !1121, !tbaa !500
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1121
    #dbg_value(ptr %call12, !1111, !DIExpression(), !1116)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1117
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1117
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1117
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1117, !llvm.loop !1128

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1117

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1117

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1117

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1117

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1129
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1129
  store i8 10, ptr %arrayidx17, align 1, !dbg !1129, !tbaa !500
  br label %if.end18, !dbg !1129

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1117
  ret i32 0, !dbg !1117
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1132 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1144
    #dbg_assign(i1 undef, !1141, !DIExpression(), !1144, ptr %endptr, !DIExpression(), !1145)
    #dbg_value(ptr %s, !1137, !DIExpression(), !1145)
    #dbg_value(ptr %arr, !1138, !DIExpression(), !1145)
    #dbg_value(i32 %n, !1139, !DIExpression(), !1145)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1146
    #dbg_value(i32 0, !1142, !DIExpression(), !1145)
  %cmp.not = icmp eq ptr %s, null, !dbg !1147
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1147

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #19, !dbg !1147
  unreachable, !dbg !1147

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1146
    #dbg_value(ptr %call, !1140, !DIExpression(), !1145)
    #dbg_value(i32 0, !1142, !DIExpression(), !1145)
  %cmp129 = icmp ne ptr %call, null, !dbg !1146
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1146
  %0 = and i1 %cmp230, %cmp129, !dbg !1146
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1146

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1146

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1146
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1146

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1140, !DIExpression(), !1145)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1142, !DIExpression(), !1145)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1150, !tbaa !992, !DIAssignID !1152
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1141, !DIExpression(), !1152, ptr %endptr, !DIExpression(), !1145)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1150
    #dbg_value(i64 %call3, !1143, !DIExpression(), !1145)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1153, !tbaa !992
  %3 = load i8, ptr %2, align 1, !dbg !1153, !tbaa !500
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1153
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1150

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1150

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1155, !tbaa !992
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1155
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1155
  br label %if.end8, !dbg !1155

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1150
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1150, !tbaa !1157
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1150
    #dbg_value(i64 %indvars.iv.next, !1142, !DIExpression(), !1145)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1150
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1150
  store i8 10, ptr %arrayidx10, align 1, !dbg !1150, !tbaa !500
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1150
    #dbg_value(ptr %call11, !1140, !DIExpression(), !1145)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1146
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1146
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1146
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1146, !llvm.loop !1159

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1146

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1146

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1146

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1146

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1160
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1160
  store i8 10, ptr %arrayidx16, align 1, !dbg !1160, !tbaa !500
  br label %if.end17, !dbg !1160

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1146
  ret i32 0, !dbg !1146
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1163 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1175
    #dbg_assign(i1 undef, !1172, !DIExpression(), !1175, ptr %endptr, !DIExpression(), !1176)
    #dbg_value(ptr %s, !1168, !DIExpression(), !1176)
    #dbg_value(ptr %arr, !1169, !DIExpression(), !1176)
    #dbg_value(i32 %n, !1170, !DIExpression(), !1176)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1177
    #dbg_value(i32 0, !1173, !DIExpression(), !1176)
  %cmp.not = icmp eq ptr %s, null, !dbg !1178
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1178

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #19, !dbg !1178
  unreachable, !dbg !1178

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1177
    #dbg_value(ptr %call, !1171, !DIExpression(), !1176)
    #dbg_value(i32 0, !1173, !DIExpression(), !1176)
  %cmp130 = icmp ne ptr %call, null, !dbg !1177
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1177
  %0 = and i1 %cmp231, %cmp130, !dbg !1177
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1177

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1177

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1177
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1177

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1171, !DIExpression(), !1176)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1173, !DIExpression(), !1176)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1181, !tbaa !992, !DIAssignID !1183
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1172, !DIExpression(), !1183, ptr %endptr, !DIExpression(), !1176)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1181
  %conv = trunc i64 %call3 to i8, !dbg !1181
    #dbg_value(i8 %conv, !1174, !DIExpression(), !1176)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1184, !tbaa !992
  %3 = load i8, ptr %2, align 1, !dbg !1184, !tbaa !500
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1184
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1181

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1181

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1186, !tbaa !992
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1186
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1186
  br label %if.end9, !dbg !1186

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1181
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1181, !tbaa !500
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1181
    #dbg_value(i64 %indvars.iv.next, !1173, !DIExpression(), !1176)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1181
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1181
  store i8 10, ptr %arrayidx11, align 1, !dbg !1181, !tbaa !500
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1181
    #dbg_value(ptr %call12, !1171, !DIExpression(), !1176)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1177
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1177
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1177
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1177, !llvm.loop !1188

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1177

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1177

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1177

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1177

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1189
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1189
  store i8 10, ptr %arrayidx17, align 1, !dbg !1189, !tbaa !500
  br label %if.end18, !dbg !1189

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1177
  ret i32 0, !dbg !1177
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1192 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1204
    #dbg_assign(i1 undef, !1201, !DIExpression(), !1204, ptr %endptr, !DIExpression(), !1205)
    #dbg_value(ptr %s, !1197, !DIExpression(), !1205)
    #dbg_value(ptr %arr, !1198, !DIExpression(), !1205)
    #dbg_value(i32 %n, !1199, !DIExpression(), !1205)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1206
    #dbg_value(i32 0, !1202, !DIExpression(), !1205)
  %cmp.not = icmp eq ptr %s, null, !dbg !1207
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1207

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #19, !dbg !1207
  unreachable, !dbg !1207

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1206
    #dbg_value(ptr %call, !1200, !DIExpression(), !1205)
    #dbg_value(i32 0, !1202, !DIExpression(), !1205)
  %cmp130 = icmp ne ptr %call, null, !dbg !1206
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1206
  %0 = and i1 %cmp231, %cmp130, !dbg !1206
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1206

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1206

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1206
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1206

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1200, !DIExpression(), !1205)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1202, !DIExpression(), !1205)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1210, !tbaa !992, !DIAssignID !1212
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1201, !DIExpression(), !1212, ptr %endptr, !DIExpression(), !1205)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1210
  %conv = trunc i64 %call3 to i16, !dbg !1210
    #dbg_value(i16 %conv, !1203, !DIExpression(), !1205)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1213, !tbaa !992
  %3 = load i8, ptr %2, align 1, !dbg !1213, !tbaa !500
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1213
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1210

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1210

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1215, !tbaa !992
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1215
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1215
  br label %if.end9, !dbg !1215

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1210
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1210, !tbaa !1097
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1210
    #dbg_value(i64 %indvars.iv.next, !1202, !DIExpression(), !1205)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1210
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1210
  store i8 10, ptr %arrayidx11, align 1, !dbg !1210, !tbaa !500
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1210
    #dbg_value(ptr %call12, !1200, !DIExpression(), !1205)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1206
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1206
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1206
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1206, !llvm.loop !1217

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1206

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1206

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1206

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1206

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1218
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1218
  store i8 10, ptr %arrayidx17, align 1, !dbg !1218, !tbaa !500
  br label %if.end18, !dbg !1218

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1206
  ret i32 0, !dbg !1206
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1221 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1232
    #dbg_assign(i1 undef, !1229, !DIExpression(), !1232, ptr %endptr, !DIExpression(), !1233)
    #dbg_value(ptr %s, !1225, !DIExpression(), !1233)
    #dbg_value(ptr %arr, !1226, !DIExpression(), !1233)
    #dbg_value(i32 %n, !1227, !DIExpression(), !1233)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1234
    #dbg_value(i32 0, !1230, !DIExpression(), !1233)
  %cmp.not = icmp eq ptr %s, null, !dbg !1235
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1235

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #19, !dbg !1235
  unreachable, !dbg !1235

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1234
    #dbg_value(ptr %call, !1228, !DIExpression(), !1233)
    #dbg_value(i32 0, !1230, !DIExpression(), !1233)
  %cmp130 = icmp ne ptr %call, null, !dbg !1234
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1234
  %0 = and i1 %cmp231, %cmp130, !dbg !1234
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1234

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1234

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1234
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1234

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1228, !DIExpression(), !1233)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1230, !DIExpression(), !1233)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1238, !tbaa !992, !DIAssignID !1240
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1229, !DIExpression(), !1240, ptr %endptr, !DIExpression(), !1233)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1238
  %conv = trunc i64 %call3 to i32, !dbg !1238
    #dbg_value(i32 %conv, !1231, !DIExpression(), !1233)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1241, !tbaa !992
  %3 = load i8, ptr %2, align 1, !dbg !1241, !tbaa !500
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1241
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1238

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1238

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1243, !tbaa !992
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1243
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1243
  br label %if.end9, !dbg !1243

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1238
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1238, !tbaa !381
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1238
    #dbg_value(i64 %indvars.iv.next, !1230, !DIExpression(), !1233)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1238
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1238
  store i8 10, ptr %arrayidx11, align 1, !dbg !1238, !tbaa !500
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1238
    #dbg_value(ptr %call12, !1228, !DIExpression(), !1233)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1234
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1234
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1234
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1234, !llvm.loop !1245

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1234

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1234

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1234

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1234

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1246
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1246
  store i8 10, ptr %arrayidx17, align 1, !dbg !1246, !tbaa !500
  br label %if.end18, !dbg !1246

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1234
  ret i32 0, !dbg !1234
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1249 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1261
    #dbg_assign(i1 undef, !1258, !DIExpression(), !1261, ptr %endptr, !DIExpression(), !1262)
    #dbg_value(ptr %s, !1254, !DIExpression(), !1262)
    #dbg_value(ptr %arr, !1255, !DIExpression(), !1262)
    #dbg_value(i32 %n, !1256, !DIExpression(), !1262)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1263
    #dbg_value(i32 0, !1259, !DIExpression(), !1262)
  %cmp.not = icmp eq ptr %s, null, !dbg !1264
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1264

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #19, !dbg !1264
  unreachable, !dbg !1264

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1263
    #dbg_value(ptr %call, !1257, !DIExpression(), !1262)
    #dbg_value(i32 0, !1259, !DIExpression(), !1262)
  %cmp129 = icmp ne ptr %call, null, !dbg !1263
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1263
  %0 = and i1 %cmp230, %cmp129, !dbg !1263
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1263

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1263

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1263
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1263

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1257, !DIExpression(), !1262)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1259, !DIExpression(), !1262)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1267, !tbaa !992, !DIAssignID !1269
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1258, !DIExpression(), !1269, ptr %endptr, !DIExpression(), !1262)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1267
    #dbg_value(i64 %call3, !1260, !DIExpression(), !1262)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1270, !tbaa !992
  %3 = load i8, ptr %2, align 1, !dbg !1270, !tbaa !500
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1270
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1267

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1267

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1272, !tbaa !992
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1272
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1272
  br label %if.end8, !dbg !1272

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1267
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1267, !tbaa !1157
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1267
    #dbg_value(i64 %indvars.iv.next, !1259, !DIExpression(), !1262)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1267
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1267
  store i8 10, ptr %arrayidx10, align 1, !dbg !1267, !tbaa !500
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1267
    #dbg_value(ptr %call11, !1257, !DIExpression(), !1262)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1263
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1263
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1263
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1263, !llvm.loop !1274

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1263

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1263

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1263

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1263

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1275
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1275
  store i8 10, ptr %arrayidx16, align 1, !dbg !1275, !tbaa !500
  br label %if.end17, !dbg !1275

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1263
  ret i32 0, !dbg !1263
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1278 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1290
    #dbg_assign(i1 undef, !1287, !DIExpression(), !1290, ptr %endptr, !DIExpression(), !1291)
    #dbg_value(ptr %s, !1283, !DIExpression(), !1291)
    #dbg_value(ptr %arr, !1284, !DIExpression(), !1291)
    #dbg_value(i32 %n, !1285, !DIExpression(), !1291)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1292
    #dbg_value(i32 0, !1288, !DIExpression(), !1291)
  %cmp.not = icmp eq ptr %s, null, !dbg !1293
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1293

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #19, !dbg !1293
  unreachable, !dbg !1293

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1292
    #dbg_value(ptr %call, !1286, !DIExpression(), !1291)
    #dbg_value(i32 0, !1288, !DIExpression(), !1291)
  %cmp129 = icmp ne ptr %call, null, !dbg !1292
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1292
  %0 = and i1 %cmp230, %cmp129, !dbg !1292
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1292

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1292

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1292
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1292

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1286, !DIExpression(), !1291)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1288, !DIExpression(), !1291)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1296, !tbaa !992, !DIAssignID !1298
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1287, !DIExpression(), !1298, ptr %endptr, !DIExpression(), !1291)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1296
    #dbg_value(float %call3, !1289, !DIExpression(), !1291)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1299, !tbaa !992
  %3 = load i8, ptr %2, align 1, !dbg !1299, !tbaa !500
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1299
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1296

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1296

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1301, !tbaa !992
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1301
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1301
  br label %if.end8, !dbg !1301

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1296
  store float %call3, ptr %arrayidx, align 4, !dbg !1296, !tbaa !1303
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1296
    #dbg_value(i64 %indvars.iv.next, !1288, !DIExpression(), !1291)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1296
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1296
  store i8 10, ptr %arrayidx10, align 1, !dbg !1296, !tbaa !500
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1296
    #dbg_value(ptr %call11, !1286, !DIExpression(), !1291)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1292
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1292
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1292
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1292, !llvm.loop !1305

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1292

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1292

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1292

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1292

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1306
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1306
  store i8 10, ptr %arrayidx16, align 1, !dbg !1306, !tbaa !500
  br label %if.end17, !dbg !1306

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1292
  ret i32 0, !dbg !1292
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1309 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1312 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1323
    #dbg_assign(i1 undef, !1320, !DIExpression(), !1323, ptr %endptr, !DIExpression(), !1324)
    #dbg_value(ptr %s, !1316, !DIExpression(), !1324)
    #dbg_value(ptr %arr, !1317, !DIExpression(), !1324)
    #dbg_value(i32 %n, !1318, !DIExpression(), !1324)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1325
    #dbg_value(i32 0, !1321, !DIExpression(), !1324)
  %cmp.not = icmp eq ptr %s, null, !dbg !1326
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1326

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #19, !dbg !1326
  unreachable, !dbg !1326

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1325
    #dbg_value(ptr %call, !1319, !DIExpression(), !1324)
    #dbg_value(i32 0, !1321, !DIExpression(), !1324)
  %cmp129 = icmp ne ptr %call, null, !dbg !1325
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1325
  %0 = and i1 %cmp230, %cmp129, !dbg !1325
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1325

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1325

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1325
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1325

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1319, !DIExpression(), !1324)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1321, !DIExpression(), !1324)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1329, !tbaa !992, !DIAssignID !1331
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1320, !DIExpression(), !1331, ptr %endptr, !DIExpression(), !1324)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1329
    #dbg_value(double %call3, !1322, !DIExpression(), !1324)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1332, !tbaa !992
  %3 = load i8, ptr %2, align 1, !dbg !1332, !tbaa !500
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1332
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1329

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1329

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1334, !tbaa !992
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1334
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1334
  br label %if.end8, !dbg !1334

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1329
  store double %call3, ptr %arrayidx, align 8, !dbg !1329, !tbaa !386
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1329
    #dbg_value(i64 %indvars.iv.next, !1321, !DIExpression(), !1324)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1329
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1329
  store i8 10, ptr %arrayidx10, align 1, !dbg !1329, !tbaa !500
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1329
    #dbg_value(ptr %call11, !1319, !DIExpression(), !1324)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1325
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1325
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1325
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1325, !llvm.loop !1336

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1325

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1325

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1325

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1325

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1337
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1337
  store i8 10, ptr %arrayidx16, align 1, !dbg !1337, !tbaa !500
  br label %if.end17, !dbg !1337

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1325
  ret i32 0, !dbg !1325
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1340 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1343 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1347, !DIExpression(), !1352)
    #dbg_value(ptr %arr, !1348, !DIExpression(), !1352)
    #dbg_value(i32 %n, !1349, !DIExpression(), !1352)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1353
  br i1 %cmp, label %if.end, label %if.else, !dbg !1353

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1353
  unreachable, !dbg !1353

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1356
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1358

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1358

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #22, !dbg !1359
  %conv = trunc i64 %call to i32, !dbg !1359
    #dbg_value(i32 %conv, !1349, !DIExpression(), !1352)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1361

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1349, !DIExpression(), !1352)
    #dbg_value(i32 0, !1351, !DIExpression(), !1352)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1362
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1363

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1363

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1363

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1364

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1365
    #dbg_value(i32 %add, !1351, !DIExpression(), !1352)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1362
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1363, !llvm.loop !1367

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1363

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1363

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1351, !DIExpression(), !1352)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1369
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1369
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1370
  %conv6 = sext i32 %sub to i64, !dbg !1371
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #18, !dbg !1372
  %conv8 = trunc i64 %call7 to i32, !dbg !1372
    #dbg_value(i32 %conv8, !1350, !DIExpression(), !1352)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1373
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1351, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1352)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1373

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1373
  unreachable, !dbg !1373

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #18, !dbg !1376
  %conv16 = trunc i64 %call15 to i32, !dbg !1376
    #dbg_value(i32 %conv16, !1350, !DIExpression(), !1352)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1378
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1378

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1378
  unreachable, !dbg !1378

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1381
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1382, !llvm.loop !1383

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1382

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1385
}

; Function Attrs: nofree
declare !dbg !1386 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #10

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1391 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1395, !DIExpression(), !1399)
    #dbg_value(ptr %arr, !1396, !DIExpression(), !1399)
    #dbg_value(i32 %n, !1397, !DIExpression(), !1399)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1400
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1400

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1398, !DIExpression(), !1399)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1403
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1406

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1406

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1403
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1406

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #19, !dbg !1400
  unreachable, !dbg !1400

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1398, !DIExpression(), !1399)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1407
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1407, !tbaa !500
  %conv = zext i8 %0 to i32, !dbg !1407
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1407
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1403
    #dbg_value(i64 %indvars.iv.next, !1398, !DIExpression(), !1399)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1403
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1406, !llvm.loop !1409

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1406

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1406

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1410
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #15 !dbg !1411 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1426
    #dbg_assign(i1 undef, !1417, !DIExpression(), !1426, ptr %args, !DIExpression(), !1427)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1428
    #dbg_assign(i1 undef, !1424, !DIExpression(), !1428, ptr %buffer, !DIExpression(), !1427)
    #dbg_value(i32 %fd, !1415, !DIExpression(), !1427)
    #dbg_value(ptr %format, !1416, !DIExpression(), !1427)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #18, !dbg !1429
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1430
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1431
  %0 = load ptr, ptr %args, align 8, !dbg !1432, !tbaa !992
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #18, !dbg !1433
    #dbg_value(i32 %call, !1421, !DIExpression(), !1427)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1434
  %cmp = icmp slt i32 %call, 256, !dbg !1435
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1435

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1422, !DIExpression(), !1427)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1438
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1439

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1439

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1439

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1435
  unreachable, !dbg !1435

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1440
    #dbg_value(i32 %add, !1422, !DIExpression(), !1427)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1438
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1439, !llvm.loop !1442

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1439

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1439

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1422, !DIExpression(), !1427)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1444
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1444
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1445
  %conv = sext i32 %sub to i64, !dbg !1446
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #18, !dbg !1447
  %conv3 = trunc i64 %call2 to i32, !dbg !1447
    #dbg_value(i32 %conv3, !1423, !DIExpression(), !1427)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1448
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1422, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1427)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1448

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1448
  unreachable, !dbg !1448

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1451
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1451

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1451
  unreachable, !dbg !1451

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1454
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #18, !dbg !1454
  ret void, !dbg !1455
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #16

; Function Attrs: nofree nounwind
declare !dbg !1456 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #8

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #16

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1461 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1465, !DIExpression(), !1469)
    #dbg_value(ptr %arr, !1466, !DIExpression(), !1469)
    #dbg_value(i32 %n, !1467, !DIExpression(), !1469)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1470
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1470

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1468, !DIExpression(), !1469)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1473
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1476

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1476

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1473
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1476

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #19, !dbg !1470
  unreachable, !dbg !1470

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1468, !DIExpression(), !1469)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1477
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1477, !tbaa !1097
  %conv = zext i16 %0 to i32, !dbg !1477
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1477
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1473
    #dbg_value(i64 %indvars.iv.next, !1468, !DIExpression(), !1469)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1473
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1476, !llvm.loop !1479

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1476

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1476

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1480
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1481 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1485, !DIExpression(), !1489)
    #dbg_value(ptr %arr, !1486, !DIExpression(), !1489)
    #dbg_value(i32 %n, !1487, !DIExpression(), !1489)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1490
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1490

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1488, !DIExpression(), !1489)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1493
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1496

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1496

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1493
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1496

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #19, !dbg !1490
  unreachable, !dbg !1490

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1488, !DIExpression(), !1489)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1497
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1497, !tbaa !381
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1497
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1493
    #dbg_value(i64 %indvars.iv.next, !1488, !DIExpression(), !1489)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1493
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1496, !llvm.loop !1499

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1496

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1496

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1500
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1501 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1505, !DIExpression(), !1509)
    #dbg_value(ptr %arr, !1506, !DIExpression(), !1509)
    #dbg_value(i32 %n, !1507, !DIExpression(), !1509)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1510
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1510

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1508, !DIExpression(), !1509)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1513
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1516

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1516

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1513
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1516

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #19, !dbg !1510
  unreachable, !dbg !1510

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1508, !DIExpression(), !1509)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1517
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1517, !tbaa !1157
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1517
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1513
    #dbg_value(i64 %indvars.iv.next, !1508, !DIExpression(), !1509)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1513
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1516, !llvm.loop !1519

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1516

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1516

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1520
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1521 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1525, !DIExpression(), !1529)
    #dbg_value(ptr %arr, !1526, !DIExpression(), !1529)
    #dbg_value(i32 %n, !1527, !DIExpression(), !1529)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1530
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1530

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1528, !DIExpression(), !1529)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1533
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1536

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1536

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1533
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1536

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #19, !dbg !1530
  unreachable, !dbg !1530

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1528, !DIExpression(), !1529)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1537
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1537, !tbaa !500
  %conv = sext i8 %0 to i32, !dbg !1537
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1537
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1533
    #dbg_value(i64 %indvars.iv.next, !1528, !DIExpression(), !1529)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1533
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1536, !llvm.loop !1539

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1536

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1536

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1540
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1541 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1545, !DIExpression(), !1549)
    #dbg_value(ptr %arr, !1546, !DIExpression(), !1549)
    #dbg_value(i32 %n, !1547, !DIExpression(), !1549)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1550
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1550

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1548, !DIExpression(), !1549)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1553
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1556

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1556

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1553
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1556

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #19, !dbg !1550
  unreachable, !dbg !1550

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1548, !DIExpression(), !1549)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1557
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1557, !tbaa !1097
  %conv = sext i16 %0 to i32, !dbg !1557
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1557
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1553
    #dbg_value(i64 %indvars.iv.next, !1548, !DIExpression(), !1549)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1553
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1556, !llvm.loop !1559

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1556

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1556

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1560
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !645 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !644, !DIExpression(), !1561)
    #dbg_value(ptr %arr, !649, !DIExpression(), !1561)
    #dbg_value(i32 %n, !650, !DIExpression(), !1561)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1562
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1562

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !651, !DIExpression(), !1561)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1565
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1566

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1566

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1565
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1566

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #19, !dbg !1562
  unreachable, !dbg !1562

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !651, !DIExpression(), !1561)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1567
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1567, !tbaa !381
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1567
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1565
    #dbg_value(i64 %indvars.iv.next, !651, !DIExpression(), !1561)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1565
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1566, !llvm.loop !1568

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1566

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1566

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1569
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1570 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1574, !DIExpression(), !1578)
    #dbg_value(ptr %arr, !1575, !DIExpression(), !1578)
    #dbg_value(i32 %n, !1576, !DIExpression(), !1578)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1579
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1579

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1577, !DIExpression(), !1578)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1582
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1585

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1585

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1582
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1585

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #19, !dbg !1579
  unreachable, !dbg !1579

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1577, !DIExpression(), !1578)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1586
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1586, !tbaa !1157
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1586
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1582
    #dbg_value(i64 %indvars.iv.next, !1577, !DIExpression(), !1578)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1582
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1585, !llvm.loop !1588

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1585

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1585

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1589
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1590 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1594, !DIExpression(), !1598)
    #dbg_value(ptr %arr, !1595, !DIExpression(), !1598)
    #dbg_value(i32 %n, !1596, !DIExpression(), !1598)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1599
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1599

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1597, !DIExpression(), !1598)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1602
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1605

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1605

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1602
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1605

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #19, !dbg !1599
  unreachable, !dbg !1599

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1597, !DIExpression(), !1598)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1606
  %0 = load float, ptr %arrayidx, align 4, !dbg !1606, !tbaa !1303
  %conv = fpext float %0 to double, !dbg !1606
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1606
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1602
    #dbg_value(i64 %indvars.iv.next, !1597, !DIExpression(), !1598)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1602
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1605, !llvm.loop !1608

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1605

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1605

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1609
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !604 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !603, !DIExpression(), !1610)
    #dbg_value(ptr %arr, !608, !DIExpression(), !1610)
    #dbg_value(i32 %n, !609, !DIExpression(), !1610)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1611
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1611

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !610, !DIExpression(), !1610)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1614
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1615

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1615

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1614
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1615

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #19, !dbg !1611
  unreachable, !dbg !1611

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !610, !DIExpression(), !1610)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1616
  %0 = load double, ptr %arrayidx, align 8, !dbg !1616, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1616
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1614
    #dbg_value(i64 %indvars.iv.next, !610, !DIExpression(), !1610)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1614
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1615, !llvm.loop !1617

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1615

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1615

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1618
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #2 !dbg !592 {
entry.split:
    #dbg_value(i32 %fd, !591, !DIExpression(), !1619)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1620
  br i1 %cmp, label %if.end, label %if.else, !dbg !1620

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1620
  unreachable, !dbg !1620

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1621
  ret i32 0, !dbg !1622
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #2 !dbg !1623 {
entry.split:
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.048.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %fy.068.i.i.reg2mem = alloca double, align 8
  %fz.069.i.i.reg2mem = alloca double, align 8
  %fx.071.i.i.reg2mem = alloca double, align 8
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %indvars.iv76.i.i.reg2mem76 = alloca i64, align 8
  %check_file.0.reg2mem78 = alloca ptr, align 8
  %in_file.03.reg2mem80 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1627, !DIExpression(), !1636)
    #dbg_value(ptr %argv, !1628, !DIExpression(), !1636)
  %cmp = icmp slt i32 %argc, 4, !dbg !1637
  br i1 %cmp, label %if.end, label %if.else, !dbg !1637

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.15, ptr noundef nonnull @.str.2.16, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1637
  unreachable, !dbg !1637

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1629, !DIExpression(), !1636)
    #dbg_value(ptr @.str.4.17, !1630, !DIExpression(), !1636)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1640
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1642

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.17, ptr %check_file.0.reg2mem78, align 8
  store ptr @.str.3, ptr %in_file.03.reg2mem80, align 8
  br label %if.end7, !dbg !1642

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1643
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1643
    #dbg_value(ptr %0, !1629, !DIExpression(), !1636)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1644
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1646

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.17, ptr %check_file.0.reg2mem78, align 8
  store ptr %0, ptr %in_file.03.reg2mem80, align 8
  br label %if.end7, !dbg !1646

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1647
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1647
    #dbg_value(ptr %1, !1630, !DIExpression(), !1636)
  store ptr %1, ptr %check_file.0.reg2mem78, align 8
  store ptr %0, ptr %in_file.03.reg2mem80, align 8
  br label %if.end7, !dbg !1648

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem78.0.check_file.0.reload79, !1630, !DIExpression(), !1636)
  %in_file.03.reg2mem80.0.in_file.03.reload81 = load ptr, ptr %in_file.03.reg2mem80, align 8
  %check_file.0.reg2mem78.0.check_file.0.reload79 = load ptr, ptr %check_file.0.reg2mem78, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1649, !tbaa !381
  %conv = sext i32 %2 to i64, !dbg !1649
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #20, !dbg !1650
    #dbg_value(ptr %call, !1632, !DIExpression(), !1636)
  %cmp8.not = icmp eq ptr %call, null, !dbg !1651
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1651

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.18, ptr noundef nonnull @.str.2.16, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1651
  unreachable, !dbg !1651

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.03.reg2mem80.0.in_file.03.reload81, i32 noundef signext 0) #18, !dbg !1654
    #dbg_value(i32 %call14, !1631, !DIExpression(), !1636)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1655
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1655

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.19, ptr noundef nonnull @.str.2.16, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1655
  unreachable, !dbg !1655

if.end20:                                         ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #18, !dbg !1658
    #dbg_value(ptr %call, !426, !DIExpression(), !1659)
    #dbg_value(ptr %call, !427, !DIExpression(), !1659)
  %force_y.i = getelementptr inbounds i8, ptr %call, i64 2048, !dbg !1661
  %force_z.i = getelementptr inbounds i8, ptr %call, i64 4096, !dbg !1662
  %position_x.i = getelementptr inbounds i8, ptr %call, i64 6144, !dbg !1663
  %position_y.i = getelementptr inbounds i8, ptr %call, i64 8192, !dbg !1664
  %position_z.i = getelementptr inbounds i8, ptr %call, i64 10240, !dbg !1665
  %NL.i = getelementptr inbounds i8, ptr %call, i64 12288, !dbg !1666
    #dbg_value(ptr %call, !338, !DIExpression(), !1667)
    #dbg_value(ptr %force_y.i, !339, !DIExpression(), !1667)
    #dbg_value(ptr %force_z.i, !340, !DIExpression(), !1667)
    #dbg_value(ptr %position_x.i, !341, !DIExpression(), !1667)
    #dbg_value(ptr %position_y.i, !342, !DIExpression(), !1667)
    #dbg_value(ptr %position_z.i, !343, !DIExpression(), !1667)
    #dbg_value(ptr %NL.i, !344, !DIExpression(), !1667)
    #dbg_label(!364, !1669)
    #dbg_value(i32 0, !361, !DIExpression(), !1667)
  store i64 0, ptr %indvars.iv76.i.i.reg2mem76, align 8
  br label %for.body.i.i, !dbg !1670

for.body.i.i:                                     ; preds = %for.end.i.i.for.body.i.i_crit_edge, %if.end20
    #dbg_value(i64 %indvars.iv76.i.i.reg2mem76.0.load, !361, !DIExpression(), !1667)
  %indvars.iv76.i.i.reg2mem76.0.load = load i64, ptr %indvars.iv76.i.i.reg2mem76, align 8
  %arrayidx.i.i = getelementptr inbounds double, ptr %position_x.i, i64 %indvars.iv76.i.i.reg2mem76.0.load, !dbg !1671
  %3 = load double, ptr %arrayidx.i.i, align 8, !dbg !1671
    #dbg_value(double %3, !355, !DIExpression(), !1667)
  %arrayidx2.i.i = getelementptr inbounds double, ptr %position_y.i, i64 %indvars.iv76.i.i.reg2mem76.0.load, !dbg !1672
  %4 = load double, ptr %arrayidx2.i.i, align 8, !dbg !1672
    #dbg_value(double %4, !356, !DIExpression(), !1667)
  %arrayidx4.i.i = getelementptr inbounds double, ptr %position_z.i, i64 %indvars.iv76.i.i.reg2mem76.0.load, !dbg !1673
  %5 = load double, ptr %arrayidx4.i.i, align 8, !dbg !1673
    #dbg_value(double %5, !357, !DIExpression(), !1667)
    #dbg_value(double 0.000000e+00, !358, !DIExpression(), !1667)
    #dbg_value(double 0.000000e+00, !359, !DIExpression(), !1667)
    #dbg_value(double 0.000000e+00, !360, !DIExpression(), !1667)
    #dbg_label(!365, !1674)
    #dbg_value(i32 0, !362, !DIExpression(), !1667)
  %invariant.gep.idx.i.i = shl i64 %indvars.iv76.i.i.reg2mem76.0.load, 6, !dbg !1675
  %invariant.gep.i.i = getelementptr i8, ptr %NL.i, i64 %invariant.gep.idx.i.i, !dbg !1675
  store double 0.000000e+00, ptr %fy.068.i.i.reg2mem, align 8
  store double 0.000000e+00, ptr %fz.069.i.i.reg2mem, align 8
  store double 0.000000e+00, ptr %fx.071.i.i.reg2mem, align 8
  store i64 0, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body7.i.i, !dbg !1675

for.body7.i.i:                                    ; preds = %for.body7.i.i.for.body7.i.i_crit_edge, %for.body.i.i
    #dbg_value(double %fx.071.i.i.reg2mem.0.fx.071.i.i.reload, !358, !DIExpression(), !1667)
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !362, !DIExpression(), !1667)
    #dbg_value(double %fz.069.i.i.reg2mem.0.fz.069.i.i.reload, !360, !DIExpression(), !1667)
    #dbg_value(double %fy.068.i.i.reg2mem.0.fy.068.i.i.reload, !359, !DIExpression(), !1667)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %fx.071.i.i.reg2mem.0.fx.071.i.i.reload = load double, ptr %fx.071.i.i.reg2mem, align 8
  %fz.069.i.i.reg2mem.0.fz.069.i.i.reload = load double, ptr %fz.069.i.i.reg2mem, align 8
  %fy.068.i.i.reg2mem.0.fy.068.i.i.reload = load double, ptr %fy.068.i.i.reg2mem, align 8
  %gep.i.i = getelementptr i32, ptr %invariant.gep.i.i, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !1676
  %6 = load i32, ptr %gep.i.i, align 4, !dbg !1676, !tbaa !381
    #dbg_value(i32 %6, !363, !DIExpression(), !1667)
  %idxprom10.i.i = sext i32 %6 to i64, !dbg !1677
  %arrayidx11.i.i = getelementptr inbounds double, ptr %position_x.i, i64 %idxprom10.i.i, !dbg !1677
  %7 = load double, ptr %arrayidx11.i.i, align 8, !dbg !1677, !tbaa !386
    #dbg_value(double %7, !352, !DIExpression(), !1667)
  %arrayidx13.i.i = getelementptr inbounds double, ptr %position_y.i, i64 %idxprom10.i.i, !dbg !1678
  %8 = load double, ptr %arrayidx13.i.i, align 8, !dbg !1678, !tbaa !386
    #dbg_value(double %8, !353, !DIExpression(), !1667)
  %arrayidx15.i.i = getelementptr inbounds double, ptr %position_z.i, i64 %idxprom10.i.i, !dbg !1679
  %9 = load double, ptr %arrayidx15.i.i, align 8, !dbg !1679, !tbaa !386
    #dbg_value(double %9, !354, !DIExpression(), !1667)
  %sub.i.i = fsub double %3, %7, !dbg !1680
    #dbg_value(double %sub.i.i, !345, !DIExpression(), !1667)
  %sub16.i.i = fsub double %4, %8, !dbg !1681
    #dbg_value(double %sub16.i.i, !346, !DIExpression(), !1667)
  %sub17.i.i = fsub double %5, %9, !dbg !1682
    #dbg_value(double %sub17.i.i, !347, !DIExpression(), !1667)
  %mul19.i.i = fmul double %sub16.i.i, %sub16.i.i, !dbg !1683
  %10 = tail call double @llvm.fmuladd.f64(double %sub.i.i, double %sub.i.i, double %mul19.i.i), !dbg !1684
  %11 = tail call double @llvm.fmuladd.f64(double %sub17.i.i, double %sub17.i.i, double %10), !dbg !1685
  %div.i.i = fdiv double 1.000000e+00, %11, !dbg !1686
    #dbg_value(double %div.i.i, !348, !DIExpression(), !1667)
  %mul21.i.i = fmul double %div.i.i, %div.i.i, !dbg !1687
  %mul22.i.i = fmul double %div.i.i, %mul21.i.i, !dbg !1688
    #dbg_value(double %mul22.i.i, !349, !DIExpression(), !1667)
  %12 = tail call double @llvm.fmuladd.f64(double %mul22.i.i, double 1.500000e+00, double -2.000000e+00), !dbg !1689
  %mul24.i.i = fmul double %mul22.i.i, %12, !dbg !1690
    #dbg_value(double %mul24.i.i, !350, !DIExpression(), !1667)
  %mul25.i.i = fmul double %div.i.i, %mul24.i.i, !dbg !1691
    #dbg_value(double %mul25.i.i, !351, !DIExpression(), !1667)
  %13 = tail call double @llvm.fmuladd.f64(double %sub.i.i, double %mul25.i.i, double %fx.071.i.i.reg2mem.0.fx.071.i.i.reload), !dbg !1692
    #dbg_value(double %13, !358, !DIExpression(), !1667)
  %14 = tail call double @llvm.fmuladd.f64(double %sub16.i.i, double %mul25.i.i, double %fy.068.i.i.reg2mem.0.fy.068.i.i.reload), !dbg !1693
    #dbg_value(double %14, !359, !DIExpression(), !1667)
  %15 = tail call double @llvm.fmuladd.f64(double %sub17.i.i, double %mul25.i.i, double %fz.069.i.i.reg2mem.0.fz.069.i.i.reload), !dbg !1694
    #dbg_value(double %15, !360, !DIExpression(), !1667)
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !1695
    #dbg_value(i64 %indvars.iv.next.i.i, !362, !DIExpression(), !1667)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 16, !dbg !1696
  br i1 %exitcond.not.i.i, label %for.end.i.i, label %for.body7.i.i.for.body7.i.i_crit_edge, !dbg !1675, !llvm.loop !1697

for.body7.i.i.for.body7.i.i_crit_edge:            ; preds = %for.body7.i.i
  store double %14, ptr %fy.068.i.i.reg2mem, align 8
  store double %15, ptr %fz.069.i.i.reg2mem, align 8
  store double %13, ptr %fx.071.i.i.reg2mem, align 8
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body7.i.i, !dbg !1675

for.end.i.i:                                      ; preds = %for.body7.i.i
  %arrayidx30.i.i = getelementptr inbounds double, ptr %call, i64 %indvars.iv76.i.i.reg2mem76.0.load, !dbg !1699
  store double %13, ptr %arrayidx30.i.i, align 8, !dbg !1700, !tbaa !386
  %arrayidx32.i.i = getelementptr inbounds double, ptr %force_y.i, i64 %indvars.iv76.i.i.reg2mem76.0.load, !dbg !1701
  store double %14, ptr %arrayidx32.i.i, align 8, !dbg !1702, !tbaa !386
  %arrayidx34.i.i = getelementptr inbounds double, ptr %force_z.i, i64 %indvars.iv76.i.i.reg2mem76.0.load, !dbg !1703
  store double %15, ptr %arrayidx34.i.i, align 8, !dbg !1704, !tbaa !386
  %indvars.iv.next77.i.i = add nuw nsw i64 %indvars.iv76.i.i.reg2mem76.0.load, 1, !dbg !1705
    #dbg_value(i64 %indvars.iv.next77.i.i, !361, !DIExpression(), !1667)
  %exitcond79.not.i.i = icmp eq i64 %indvars.iv.next77.i.i, 256, !dbg !1706
  br i1 %exitcond79.not.i.i, label %run_benchmark.exit, label %for.end.i.i.for.body.i.i_crit_edge, !dbg !1670, !llvm.loop !1707

for.end.i.i.for.body.i.i_crit_edge:               ; preds = %for.end.i.i
  store i64 %indvars.iv.next77.i.i, ptr %indvars.iv76.i.i.reg2mem76, align 8
  br label %for.body.i.i, !dbg !1670

run_benchmark.exit:                               ; preds = %for.end.i.i
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #18, !dbg !1709
    #dbg_value(i32 %call21, !1633, !DIExpression(), !1636)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1710
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1710

if.else26:                                        ; preds = %run_benchmark.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.16, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1710
  unreachable, !dbg !1710

if.end27:                                         ; preds = %run_benchmark.exit
  tail call void @data_to_output(i32 noundef signext %call21, ptr noundef nonnull %call) #18, !dbg !1713
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #18, !dbg !1714
  %16 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1715, !tbaa !381
  %conv29 = sext i32 %16 to i64, !dbg !1715
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #20, !dbg !1716
    #dbg_value(ptr %call30, !1635, !DIExpression(), !1636)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1717
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1717

if.else35:                                        ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.20, ptr noundef nonnull @.str.2.16, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1717
  unreachable, !dbg !1717

if.end36:                                         ; preds = %if.end27
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem78.0.check_file.0.reload79, i32 noundef signext 0) #18, !dbg !1720
    #dbg_value(i32 %call37, !1634, !DIExpression(), !1636)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1721
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1721

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.21, ptr noundef nonnull @.str.2.16, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1721
  unreachable, !dbg !1721

if.end43:                                         ; preds = %if.end36
  tail call void @output_to_data(i32 noundef signext %call37, ptr noundef nonnull %call30) #18, !dbg !1724
    #dbg_value(ptr %call, !774, !DIExpression(), !1725)
    #dbg_value(ptr %call30, !775, !DIExpression(), !1725)
    #dbg_value(ptr %call, !776, !DIExpression(), !1725)
    #dbg_value(ptr %call30, !777, !DIExpression(), !1725)
    #dbg_value(i32 0, !778, !DIExpression(), !1725)
    #dbg_value(i32 0, !779, !DIExpression(), !1725)
  store i32 0, ptr %has_errors.048.i.reg2mem, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1728

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %if.end43
    #dbg_value(i32 %has_errors.048.i.reg2mem.0.load, !778, !DIExpression(), !1725)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !779, !DIExpression(), !1725)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %has_errors.048.i.reg2mem.0.load = load i32, ptr %has_errors.048.i.reg2mem, align 4
  %arrayidx.i = getelementptr inbounds [256 x double], ptr %call, i64 0, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1729
  %17 = load double, ptr %arrayidx.i, align 8, !dbg !1729, !tbaa !386
  %arrayidx3.i = getelementptr inbounds [256 x double], ptr %call30, i64 0, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1730
  %18 = load double, ptr %arrayidx3.i, align 8, !dbg !1730, !tbaa !386
  %sub.i = fsub double %17, %18, !dbg !1731
    #dbg_value(double %sub.i, !780, !DIExpression(), !1725)
  %arrayidx5.i = getelementptr inbounds %struct.bench_args_t, ptr %call, i64 0, i32 1, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1732
  %19 = load double, ptr %arrayidx5.i, align 8, !dbg !1732, !tbaa !386
  %arrayidx8.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 1, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1733
  %20 = load double, ptr %arrayidx8.i, align 8, !dbg !1733, !tbaa !386
  %sub9.i = fsub double %19, %20, !dbg !1734
    #dbg_value(double %sub9.i, !781, !DIExpression(), !1725)
  %arrayidx11.i = getelementptr inbounds %struct.bench_args_t, ptr %call, i64 0, i32 2, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1735
  %21 = load double, ptr %arrayidx11.i, align 8, !dbg !1735, !tbaa !386
  %arrayidx14.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 2, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1736
  %22 = load double, ptr %arrayidx14.i, align 8, !dbg !1736, !tbaa !386
  %sub15.i = fsub double %21, %22, !dbg !1737
    #dbg_value(double %sub15.i, !782, !DIExpression(), !1725)
  %23 = tail call double @llvm.fabs.f64(double %sub.i), !dbg !1738
  %24 = fcmp ogt double %23, 0x3EB0C6F7A0B5ED8D, !dbg !1738
    #dbg_value(!DIArgList(i32 %has_errors.048.i.reg2mem.0.load, i1 %24), !778, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !1725)
  %25 = tail call double @llvm.fabs.f64(double %sub9.i), !dbg !1739
  %26 = fcmp ogt double %25, 0x3EB0C6F7A0B5ED8D, !dbg !1739
  %27 = or i1 %24, %26, !dbg !1740
    #dbg_value(!DIArgList(i32 %has_errors.048.i.reg2mem.0.load, i1 %27), !778, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !1725)
  %28 = tail call double @llvm.fabs.f64(double %sub15.i), !dbg !1741
  %29 = fcmp ogt double %28, 0x3EB0C6F7A0B5ED8D, !dbg !1741
  %30 = or i1 %27, %29, !dbg !1742
  %31 = zext i1 %30 to i32, !dbg !1742
  %or29.i = or i32 %has_errors.048.i.reg2mem.0.load, %31, !dbg !1742
    #dbg_value(i32 %or29.i, !778, !DIExpression(), !1725)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1743
    #dbg_value(i64 %indvars.iv.next.i, !779, !DIExpression(), !1725)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 256, !dbg !1744
  br i1 %exitcond.not.i, label %check_data.exit, label %for.body.i.for.body.i_crit_edge, !dbg !1728, !llvm.loop !1745

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i32 %or29.i, ptr %has_errors.048.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1728

check_data.exit:                                  ; preds = %for.body.i
  %tobool.not.i.not = icmp eq i32 %or29.i, 0, !dbg !1747
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1748

if.then45:                                        ; preds = %check_data.exit
  %32 = load ptr, ptr @stderr, align 8, !dbg !1749, !tbaa !992
  %33 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %32) #21, !dbg !1751
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1752

if.end47:                                         ; preds = %check_data.exit
  tail call void @free(ptr noundef nonnull %call) #18, !dbg !1753
  tail call void @free(ptr noundef nonnull %call30) #18, !dbg !1754
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1755
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1756

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1757
}

; Function Attrs: nofree
declare !dbg !1758 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #10

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #17

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #17

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #1

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #4 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #5 = { nofree norecurse nosync nounwind memory(argmem: read) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #8 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #9 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #10 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #11 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #12 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #13 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #14 = { mustprogress nofree nounwind willreturn memory(argmem: read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #15 = { inlinehint nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #16 = { nocallback nofree nosync nounwind willreturn }
attributes #17 = { nofree nounwind }
attributes #18 = { nounwind }
attributes #19 = { noreturn nounwind }
attributes #20 = { nounwind allocsize(0) }
attributes #21 = { cold }
attributes #22 = { nounwind willreturn memory(read) }

!llvm.dbg.cu = !{!236, !188, !238, !299}
!llvm.ident = !{!320, !320, !320, !320}
!llvm.module.flags = !{!321, !322, !323, !324, !325, !327, !328, !329, !330, !331}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/md/knn")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/md/knn")
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
!187 = distinct !DIGlobalVariable(name: "INPUT_SIZE", scope: !188, file: !189, line: 4, type: !211, isLocal: false, isDefinition: true)
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !214, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/md/knn")
!190 = !{!191, !197}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 31, size: 229376, elements: !194)
!193 = !DIFile(filename: "./md.h", directory: "/home/kelvin/MachSuite/md/knn")
!194 = !{!195, !200, !201, !202, !203, !204, !205}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "force_x", scope: !192, file: !193, line: 32, baseType: !196, size: 16384)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 16384, elements: !198)
!197 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!198 = !{!199}
!199 = !DISubrange(count: 256)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "force_y", scope: !192, file: !193, line: 33, baseType: !196, size: 16384, offset: 16384)
!201 = !DIDerivedType(tag: DW_TAG_member, name: "force_z", scope: !192, file: !193, line: 34, baseType: !196, size: 16384, offset: 32768)
!202 = !DIDerivedType(tag: DW_TAG_member, name: "position_x", scope: !192, file: !193, line: 35, baseType: !196, size: 16384, offset: 49152)
!203 = !DIDerivedType(tag: DW_TAG_member, name: "position_y", scope: !192, file: !193, line: 36, baseType: !196, size: 16384, offset: 65536)
!204 = !DIDerivedType(tag: DW_TAG_member, name: "position_z", scope: !192, file: !193, line: 37, baseType: !196, size: 16384, offset: 81920)
!205 = !DIDerivedType(tag: DW_TAG_member, name: "NL", scope: !192, file: !193, line: 38, baseType: !206, size: 131072, offset: 98304)
!206 = !DICompositeType(tag: DW_TAG_array_type, baseType: !207, size: 131072, elements: !212)
!207 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !208, line: 26, baseType: !209)
!208 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!209 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !210, line: 41, baseType: !211)
!210 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!211 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!212 = !{!213}
!213 = !DISubrange(count: 4096)
!214 = !{!186}
!215 = !DIGlobalVariableExpression(var: !216, expr: !DIExpression())
!216 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !217, isLocal: true, isDefinition: true)
!217 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!218 = !DIGlobalVariableExpression(var: !219, expr: !DIExpression())
!219 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !220, isLocal: true, isDefinition: true)
!220 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!221 = !DIGlobalVariableExpression(var: !222, expr: !DIExpression())
!222 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !223, isLocal: true, isDefinition: true)
!223 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !224)
!224 = !{!225}
!225 = !DISubrange(count: 12)
!226 = !DIGlobalVariableExpression(var: !227, expr: !DIExpression())
!227 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !228, isLocal: true, isDefinition: true)
!228 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!229 = !DIGlobalVariableExpression(var: !230, expr: !DIExpression())
!230 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!231 = !DIGlobalVariableExpression(var: !232, expr: !DIExpression())
!232 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !233, isLocal: true, isDefinition: true)
!233 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!234 = !DIGlobalVariableExpression(var: !235, expr: !DIExpression())
!235 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!236 = distinct !DICompileUnit(language: DW_LANG_C11, file: !237, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!237 = !DIFile(filename: "md.c", directory: "/home/kelvin/MachSuite/md/knn")
!238 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !239, globals: !265, splitDebugInlining: false, nameTableKind: None)
!239 = !{!240, !4, !241, !242, !246, !249, !252, !255, !258, !207, !261, !264, !197}
!240 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!241 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!242 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !243, line: 24, baseType: !244)
!243 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!244 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !210, line: 38, baseType: !245)
!245 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!246 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !243, line: 25, baseType: !247)
!247 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !210, line: 40, baseType: !248)
!248 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !243, line: 26, baseType: !250)
!250 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !210, line: 42, baseType: !251)
!251 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !243, line: 27, baseType: !253)
!253 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !210, line: 45, baseType: !254)
!254 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!255 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !208, line: 24, baseType: !256)
!256 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !210, line: 37, baseType: !257)
!257 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!258 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !208, line: 25, baseType: !259)
!259 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !210, line: 39, baseType: !260)
!260 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!261 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !208, line: 27, baseType: !262)
!262 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !210, line: 44, baseType: !263)
!263 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!264 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!265 = !{!266, !0, !7, !12, !271, !18, !273, !23, !278, !28, !280, !33, !38, !282, !43, !45, !47, !52, !57, !62, !67, !69, !71, !76, !78, !80, !82, !87, !89, !287, !92, !97, !102, !107, !112, !114, !116, !121, !126, !128, !130, !132, !134, !136, !141, !146, !148, !153, !292, !158, !163, !294, !165}
!266 = !DIGlobalVariableExpression(var: !267, expr: !DIExpression())
!267 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !268, isLocal: true, isDefinition: true)
!268 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !269)
!269 = !{!270}
!270 = !DISubrange(count: 24)
!271 = !DIGlobalVariableExpression(var: !272, expr: !DIExpression())
!272 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !30, isLocal: true, isDefinition: true)
!273 = !DIGlobalVariableExpression(var: !274, expr: !DIExpression())
!274 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !275, isLocal: true, isDefinition: true)
!275 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !276)
!276 = !{!277}
!277 = !DISubrange(count: 14)
!278 = !DIGlobalVariableExpression(var: !279, expr: !DIExpression())
!279 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !275, isLocal: true, isDefinition: true)
!280 = !DIGlobalVariableExpression(var: !281, expr: !DIExpression())
!281 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !9, isLocal: true, isDefinition: true)
!282 = !DIGlobalVariableExpression(var: !283, expr: !DIExpression())
!283 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !284, isLocal: true, isDefinition: true)
!284 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !285)
!285 = !{!286}
!286 = !DISubrange(count: 21)
!287 = !DIGlobalVariableExpression(var: !288, expr: !DIExpression())
!288 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !289, isLocal: true, isDefinition: true)
!289 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !290)
!290 = !{!291}
!291 = !DISubrange(count: 13)
!292 = !DIGlobalVariableExpression(var: !293, expr: !DIExpression())
!293 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !20, isLocal: true, isDefinition: true)
!294 = !DIGlobalVariableExpression(var: !295, expr: !DIExpression())
!295 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !296, isLocal: true, isDefinition: true)
!296 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !297)
!297 = !{!298}
!298 = !DISubrange(count: 27)
!299 = distinct !DICompileUnit(language: DW_LANG_C11, file: !170, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !300, globals: !301, splitDebugInlining: false, nameTableKind: None)
!300 = !{!241}
!301 = !{!302, !168, !174, !176, !179, !184, !304, !215, !306, !218, !221, !308, !226, !229, !313, !231, !234, !315}
!302 = !DIGlobalVariableExpression(var: !303, expr: !DIExpression())
!303 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !228, isLocal: true, isDefinition: true)
!304 = !DIGlobalVariableExpression(var: !305, expr: !DIExpression())
!305 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !275, isLocal: true, isDefinition: true)
!306 = !DIGlobalVariableExpression(var: !307, expr: !DIExpression())
!307 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !217, isLocal: true, isDefinition: true)
!308 = !DIGlobalVariableExpression(var: !309, expr: !DIExpression())
!309 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !310, isLocal: true, isDefinition: true)
!310 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !311)
!311 = !{!312}
!312 = !DISubrange(count: 31)
!313 = !DIGlobalVariableExpression(var: !314, expr: !DIExpression())
!314 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !217, isLocal: true, isDefinition: true)
!315 = !DIGlobalVariableExpression(var: !316, expr: !DIExpression())
!316 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !317, isLocal: true, isDefinition: true)
!317 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !318)
!318 = !{!319}
!319 = !DISubrange(count: 10)
!320 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!321 = !{i32 7, !"Dwarf Version", i32 4}
!322 = !{i32 2, !"Debug Info Version", i32 3}
!323 = !{i32 1, !"wchar_size", i32 4}
!324 = !{i32 1, !"target-abi", !"lp64d"}
!325 = distinct !{i32 6, !"riscv-isa", !326}
!326 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!327 = !{i32 8, !"PIC Level", i32 2}
!328 = !{i32 7, !"PIE Level", i32 2}
!329 = !{i32 7, !"uwtable", i32 2}
!330 = !{i32 8, !"SmallDataLimit", i32 8}
!331 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!332 = distinct !DISubprogram(name: "md", scope: !237, file: !237, line: 10, type: !333, scopeLine: 17, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !337)
!333 = !DISubroutineType(types: !334)
!334 = !{null, !335, !335, !335, !335, !335, !335, !336}
!335 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!336 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !207, size: 64)
!337 = !{!338, !339, !340, !341, !342, !343, !344, !345, !346, !347, !348, !349, !350, !351, !352, !353, !354, !355, !356, !357, !358, !359, !360, !361, !362, !363, !364, !365}
!338 = !DILocalVariable(name: "force_x", arg: 1, scope: !332, file: !237, line: 10, type: !335)
!339 = !DILocalVariable(name: "force_y", arg: 2, scope: !332, file: !237, line: 11, type: !335)
!340 = !DILocalVariable(name: "force_z", arg: 3, scope: !332, file: !237, line: 12, type: !335)
!341 = !DILocalVariable(name: "position_x", arg: 4, scope: !332, file: !237, line: 13, type: !335)
!342 = !DILocalVariable(name: "position_y", arg: 5, scope: !332, file: !237, line: 14, type: !335)
!343 = !DILocalVariable(name: "position_z", arg: 6, scope: !332, file: !237, line: 15, type: !335)
!344 = !DILocalVariable(name: "NL", arg: 7, scope: !332, file: !237, line: 16, type: !336)
!345 = !DILocalVariable(name: "delx", scope: !332, file: !237, line: 18, type: !197)
!346 = !DILocalVariable(name: "dely", scope: !332, file: !237, line: 18, type: !197)
!347 = !DILocalVariable(name: "delz", scope: !332, file: !237, line: 18, type: !197)
!348 = !DILocalVariable(name: "r2inv", scope: !332, file: !237, line: 18, type: !197)
!349 = !DILocalVariable(name: "r6inv", scope: !332, file: !237, line: 19, type: !197)
!350 = !DILocalVariable(name: "potential", scope: !332, file: !237, line: 19, type: !197)
!351 = !DILocalVariable(name: "force", scope: !332, file: !237, line: 19, type: !197)
!352 = !DILocalVariable(name: "j_x", scope: !332, file: !237, line: 19, type: !197)
!353 = !DILocalVariable(name: "j_y", scope: !332, file: !237, line: 19, type: !197)
!354 = !DILocalVariable(name: "j_z", scope: !332, file: !237, line: 19, type: !197)
!355 = !DILocalVariable(name: "i_x", scope: !332, file: !237, line: 20, type: !197)
!356 = !DILocalVariable(name: "i_y", scope: !332, file: !237, line: 20, type: !197)
!357 = !DILocalVariable(name: "i_z", scope: !332, file: !237, line: 20, type: !197)
!358 = !DILocalVariable(name: "fx", scope: !332, file: !237, line: 20, type: !197)
!359 = !DILocalVariable(name: "fy", scope: !332, file: !237, line: 20, type: !197)
!360 = !DILocalVariable(name: "fz", scope: !332, file: !237, line: 20, type: !197)
!361 = !DILocalVariable(name: "i", scope: !332, file: !237, line: 22, type: !207)
!362 = !DILocalVariable(name: "j", scope: !332, file: !237, line: 22, type: !207)
!363 = !DILocalVariable(name: "jidx", scope: !332, file: !237, line: 22, type: !207)
!364 = !DILabel(scope: !332, name: "loop_i", file: !237, line: 24)
!365 = !DILabel(scope: !366, name: "loop_j", file: !237, line: 31)
!366 = distinct !DILexicalBlock(scope: !367, file: !237, line: 24, column: 38)
!367 = distinct !DILexicalBlock(scope: !368, file: !237, line: 24, column: 10)
!368 = distinct !DILexicalBlock(scope: !332, file: !237, line: 24, column: 10)
!369 = !DILocation(line: 0, scope: !332)
!370 = !DILocation(line: 24, column: 1, scope: !332)
!371 = !DILocation(line: 24, column: 10, scope: !368)
!372 = !DILocation(line: 25, column: 20, scope: !366)
!373 = !DILocation(line: 26, column: 20, scope: !366)
!374 = !DILocation(line: 27, column: 20, scope: !366)
!375 = !DILocation(line: 31, column: 1, scope: !366)
!376 = !DILocation(line: 31, column: 10, scope: !377)
!377 = distinct !DILexicalBlock(scope: !366, file: !237, line: 31, column: 10)
!378 = !DILocation(line: 33, column: 21, scope: !379)
!379 = distinct !DILexicalBlock(scope: !380, file: !237, line: 31, column: 44)
!380 = distinct !DILexicalBlock(scope: !377, file: !237, line: 31, column: 10)
!381 = !{!382, !382, i64 0}
!382 = !{!"int", !383, i64 0}
!383 = !{!"omnipotent char", !384, i64 0}
!384 = !{!"Simple C/C++ TBAA"}
!385 = !DILocation(line: 35, column: 20, scope: !379)
!386 = !{!387, !387, i64 0}
!387 = !{!"double", !383, i64 0}
!388 = !DILocation(line: 36, column: 20, scope: !379)
!389 = !DILocation(line: 37, column: 20, scope: !379)
!390 = !DILocation(line: 39, column: 25, scope: !379)
!391 = !DILocation(line: 40, column: 25, scope: !379)
!392 = !DILocation(line: 41, column: 25, scope: !379)
!393 = !DILocation(line: 42, column: 44, scope: !379)
!394 = !DILocation(line: 42, column: 38, scope: !379)
!395 = !DILocation(line: 42, column: 50, scope: !379)
!396 = !DILocation(line: 42, column: 25, scope: !379)
!397 = !DILocation(line: 44, column: 28, scope: !379)
!398 = !DILocation(line: 44, column: 36, scope: !379)
!399 = !DILocation(line: 45, column: 43, scope: !379)
!400 = !DILocation(line: 45, column: 31, scope: !379)
!401 = !DILocation(line: 47, column: 27, scope: !379)
!402 = !DILocation(line: 48, column: 17, scope: !379)
!403 = !DILocation(line: 49, column: 17, scope: !379)
!404 = !DILocation(line: 50, column: 17, scope: !379)
!405 = !DILocation(line: 31, column: 41, scope: !380)
!406 = !DILocation(line: 31, column: 24, scope: !380)
!407 = distinct !{!407, !376, !408, !409, !410}
!408 = !DILocation(line: 51, column: 10, scope: !377)
!409 = !{!"llvm.loop.mustprogress"}
!410 = !{!"llvm.loop.unroll.disable"}
!411 = !DILocation(line: 53, column: 10, scope: !366)
!412 = !DILocation(line: 53, column: 21, scope: !366)
!413 = !DILocation(line: 54, column: 10, scope: !366)
!414 = !DILocation(line: 54, column: 21, scope: !366)
!415 = !DILocation(line: 55, column: 10, scope: !366)
!416 = !DILocation(line: 55, column: 21, scope: !366)
!417 = !DILocation(line: 24, column: 35, scope: !367)
!418 = !DILocation(line: 24, column: 24, scope: !367)
!419 = distinct !{!419, !371, !420, !409, !410}
!420 = !DILocation(line: 57, column: 10, scope: !368)
!421 = !DILocation(line: 58, column: 1, scope: !332)
!422 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 8, type: !423, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !425)
!423 = !DISubroutineType(types: !424)
!424 = !{null, !241}
!425 = !{!426, !427}
!426 = !DILocalVariable(name: "vargs", arg: 1, scope: !422, file: !189, line: 8, type: !241)
!427 = !DILocalVariable(name: "args", scope: !422, file: !189, line: 9, type: !191)
!428 = !DILocation(line: 0, scope: !422)
!429 = !DILocation(line: 10, column: 28, scope: !422)
!430 = !DILocation(line: 10, column: 43, scope: !422)
!431 = !DILocation(line: 11, column: 20, scope: !422)
!432 = !DILocation(line: 11, column: 38, scope: !422)
!433 = !DILocation(line: 11, column: 56, scope: !422)
!434 = !DILocation(line: 12, column: 20, scope: !422)
!435 = !DILocation(line: 0, scope: !332, inlinedAt: !436)
!436 = distinct !DILocation(line: 10, column: 3, scope: !422)
!437 = !DILocation(line: 24, column: 1, scope: !332, inlinedAt: !436)
!438 = !DILocation(line: 24, column: 10, scope: !368, inlinedAt: !436)
!439 = !DILocation(line: 25, column: 20, scope: !366, inlinedAt: !436)
!440 = !DILocation(line: 26, column: 20, scope: !366, inlinedAt: !436)
!441 = !DILocation(line: 27, column: 20, scope: !366, inlinedAt: !436)
!442 = !DILocation(line: 31, column: 1, scope: !366, inlinedAt: !436)
!443 = !DILocation(line: 31, column: 10, scope: !377, inlinedAt: !436)
!444 = !DILocation(line: 33, column: 21, scope: !379, inlinedAt: !436)
!445 = !DILocation(line: 35, column: 20, scope: !379, inlinedAt: !436)
!446 = !DILocation(line: 36, column: 20, scope: !379, inlinedAt: !436)
!447 = !DILocation(line: 37, column: 20, scope: !379, inlinedAt: !436)
!448 = !DILocation(line: 39, column: 25, scope: !379, inlinedAt: !436)
!449 = !DILocation(line: 40, column: 25, scope: !379, inlinedAt: !436)
!450 = !DILocation(line: 41, column: 25, scope: !379, inlinedAt: !436)
!451 = !DILocation(line: 42, column: 44, scope: !379, inlinedAt: !436)
!452 = !DILocation(line: 42, column: 38, scope: !379, inlinedAt: !436)
!453 = !DILocation(line: 42, column: 50, scope: !379, inlinedAt: !436)
!454 = !DILocation(line: 42, column: 25, scope: !379, inlinedAt: !436)
!455 = !DILocation(line: 44, column: 28, scope: !379, inlinedAt: !436)
!456 = !DILocation(line: 44, column: 36, scope: !379, inlinedAt: !436)
!457 = !DILocation(line: 45, column: 43, scope: !379, inlinedAt: !436)
!458 = !DILocation(line: 45, column: 31, scope: !379, inlinedAt: !436)
!459 = !DILocation(line: 47, column: 27, scope: !379, inlinedAt: !436)
!460 = !DILocation(line: 48, column: 17, scope: !379, inlinedAt: !436)
!461 = !DILocation(line: 49, column: 17, scope: !379, inlinedAt: !436)
!462 = !DILocation(line: 50, column: 17, scope: !379, inlinedAt: !436)
!463 = !DILocation(line: 31, column: 41, scope: !380, inlinedAt: !436)
!464 = !DILocation(line: 31, column: 24, scope: !380, inlinedAt: !436)
!465 = distinct !{!465, !443, !466, !409, !410}
!466 = !DILocation(line: 51, column: 10, scope: !377, inlinedAt: !436)
!467 = !DILocation(line: 53, column: 10, scope: !366, inlinedAt: !436)
!468 = !DILocation(line: 53, column: 21, scope: !366, inlinedAt: !436)
!469 = !DILocation(line: 54, column: 10, scope: !366, inlinedAt: !436)
!470 = !DILocation(line: 54, column: 21, scope: !366, inlinedAt: !436)
!471 = !DILocation(line: 55, column: 10, scope: !366, inlinedAt: !436)
!472 = !DILocation(line: 55, column: 21, scope: !366, inlinedAt: !436)
!473 = !DILocation(line: 24, column: 35, scope: !367, inlinedAt: !436)
!474 = !DILocation(line: 24, column: 24, scope: !367, inlinedAt: !436)
!475 = distinct !{!475, !438, !476, !409, !410}
!476 = !DILocation(line: 57, column: 10, scope: !368, inlinedAt: !436)
!477 = !DILocation(line: 13, column: 1, scope: !422)
!478 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 26, type: !479, scopeLine: 26, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !481)
!479 = !DISubroutineType(types: !480)
!480 = !{null, !211, !241}
!481 = !{!482, !483, !484, !485, !486}
!482 = !DILocalVariable(name: "fd", arg: 1, scope: !478, file: !189, line: 26, type: !211)
!483 = !DILocalVariable(name: "vdata", arg: 2, scope: !478, file: !189, line: 26, type: !241)
!484 = !DILocalVariable(name: "data", scope: !478, file: !189, line: 27, type: !191)
!485 = !DILocalVariable(name: "p", scope: !478, file: !189, line: 28, type: !240)
!486 = !DILocalVariable(name: "s", scope: !478, file: !189, line: 28, type: !240)
!487 = !DILocation(line: 0, scope: !478)
!488 = !DILocation(line: 30, column: 3, scope: !478)
!489 = !DILocation(line: 32, column: 7, scope: !478)
!490 = !DILocalVariable(name: "s", arg: 1, scope: !491, file: !2, line: 56, type: !240)
!491 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !492, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !494)
!492 = !DISubroutineType(types: !493)
!493 = !{!240, !240, !211}
!494 = !{!490, !495, !496}
!495 = !DILocalVariable(name: "n", arg: 2, scope: !491, file: !2, line: 56, type: !211)
!496 = !DILocalVariable(name: "i", scope: !491, file: !2, line: 57, type: !211)
!497 = !DILocation(line: 0, scope: !491, inlinedAt: !498)
!498 = distinct !DILocation(line: 34, column: 7, scope: !478)
!499 = !DILocation(line: 64, column: 17, scope: !491, inlinedAt: !498)
!500 = !{!383, !383, i64 0}
!501 = !DILocation(line: 64, column: 3, scope: !491, inlinedAt: !498)
!502 = !DILocation(line: 66, column: 22, scope: !503, inlinedAt: !498)
!503 = distinct !DILexicalBlock(scope: !504, file: !2, line: 66, column: 9)
!504 = distinct !DILexicalBlock(scope: !491, file: !2, line: 64, column: 31)
!505 = !DILocation(line: 66, column: 26, scope: !503, inlinedAt: !498)
!506 = !DILocation(line: 66, column: 32, scope: !503, inlinedAt: !498)
!507 = !DILocation(line: 66, column: 35, scope: !503, inlinedAt: !498)
!508 = !DILocation(line: 66, column: 39, scope: !503, inlinedAt: !498)
!509 = !DILocation(line: 66, column: 9, scope: !504, inlinedAt: !498)
!510 = !DILocation(line: 69, column: 6, scope: !504, inlinedAt: !498)
!511 = !DILocation(line: 64, column: 10, scope: !491, inlinedAt: !498)
!512 = !DILocation(line: 64, column: 13, scope: !491, inlinedAt: !498)
!513 = distinct !{!513, !501, !514, !409, !410}
!514 = !DILocation(line: 70, column: 3, scope: !491, inlinedAt: !498)
!515 = !DILocation(line: 71, column: 6, scope: !516, inlinedAt: !498)
!516 = distinct !DILexicalBlock(scope: !491, file: !2, line: 71, column: 6)
!517 = !DILocation(line: 71, column: 8, scope: !516, inlinedAt: !498)
!518 = !DILocation(line: 71, column: 6, scope: !491, inlinedAt: !498)
!519 = !DILocation(line: 35, column: 37, scope: !478)
!520 = !DILocation(line: 35, column: 3, scope: !478)
!521 = !DILocation(line: 0, scope: !491, inlinedAt: !522)
!522 = distinct !DILocation(line: 37, column: 7, scope: !478)
!523 = !DILocation(line: 64, column: 17, scope: !491, inlinedAt: !522)
!524 = !DILocation(line: 64, column: 3, scope: !491, inlinedAt: !522)
!525 = !DILocation(line: 66, column: 22, scope: !503, inlinedAt: !522)
!526 = !DILocation(line: 66, column: 26, scope: !503, inlinedAt: !522)
!527 = !DILocation(line: 66, column: 32, scope: !503, inlinedAt: !522)
!528 = !DILocation(line: 66, column: 35, scope: !503, inlinedAt: !522)
!529 = !DILocation(line: 66, column: 39, scope: !503, inlinedAt: !522)
!530 = !DILocation(line: 66, column: 9, scope: !504, inlinedAt: !522)
!531 = !DILocation(line: 69, column: 6, scope: !504, inlinedAt: !522)
!532 = !DILocation(line: 64, column: 10, scope: !491, inlinedAt: !522)
!533 = !DILocation(line: 64, column: 13, scope: !491, inlinedAt: !522)
!534 = distinct !{!534, !524, !535, !409, !410}
!535 = !DILocation(line: 70, column: 3, scope: !491, inlinedAt: !522)
!536 = !DILocation(line: 71, column: 6, scope: !516, inlinedAt: !522)
!537 = !DILocation(line: 71, column: 8, scope: !516, inlinedAt: !522)
!538 = !DILocation(line: 71, column: 6, scope: !491, inlinedAt: !522)
!539 = !DILocation(line: 38, column: 37, scope: !478)
!540 = !DILocation(line: 38, column: 3, scope: !478)
!541 = !DILocation(line: 0, scope: !491, inlinedAt: !542)
!542 = distinct !DILocation(line: 40, column: 7, scope: !478)
!543 = !DILocation(line: 64, column: 17, scope: !491, inlinedAt: !542)
!544 = !DILocation(line: 64, column: 3, scope: !491, inlinedAt: !542)
!545 = !DILocation(line: 66, column: 22, scope: !503, inlinedAt: !542)
!546 = !DILocation(line: 66, column: 26, scope: !503, inlinedAt: !542)
!547 = !DILocation(line: 66, column: 32, scope: !503, inlinedAt: !542)
!548 = !DILocation(line: 66, column: 35, scope: !503, inlinedAt: !542)
!549 = !DILocation(line: 66, column: 39, scope: !503, inlinedAt: !542)
!550 = !DILocation(line: 66, column: 9, scope: !504, inlinedAt: !542)
!551 = !DILocation(line: 69, column: 6, scope: !504, inlinedAt: !542)
!552 = !DILocation(line: 64, column: 10, scope: !491, inlinedAt: !542)
!553 = !DILocation(line: 64, column: 13, scope: !491, inlinedAt: !542)
!554 = distinct !{!554, !544, !555, !409, !410}
!555 = !DILocation(line: 70, column: 3, scope: !491, inlinedAt: !542)
!556 = !DILocation(line: 71, column: 6, scope: !516, inlinedAt: !542)
!557 = !DILocation(line: 71, column: 8, scope: !516, inlinedAt: !542)
!558 = !DILocation(line: 71, column: 6, scope: !491, inlinedAt: !542)
!559 = !DILocation(line: 41, column: 37, scope: !478)
!560 = !DILocation(line: 41, column: 3, scope: !478)
!561 = !DILocation(line: 0, scope: !491, inlinedAt: !562)
!562 = distinct !DILocation(line: 43, column: 7, scope: !478)
!563 = !DILocation(line: 64, column: 17, scope: !491, inlinedAt: !562)
!564 = !DILocation(line: 64, column: 3, scope: !491, inlinedAt: !562)
!565 = !DILocation(line: 66, column: 22, scope: !503, inlinedAt: !562)
!566 = !DILocation(line: 66, column: 26, scope: !503, inlinedAt: !562)
!567 = !DILocation(line: 66, column: 32, scope: !503, inlinedAt: !562)
!568 = !DILocation(line: 66, column: 35, scope: !503, inlinedAt: !562)
!569 = !DILocation(line: 66, column: 39, scope: !503, inlinedAt: !562)
!570 = !DILocation(line: 66, column: 9, scope: !504, inlinedAt: !562)
!571 = !DILocation(line: 69, column: 6, scope: !504, inlinedAt: !562)
!572 = !DILocation(line: 64, column: 10, scope: !491, inlinedAt: !562)
!573 = !DILocation(line: 64, column: 13, scope: !491, inlinedAt: !562)
!574 = distinct !{!574, !564, !575, !409, !410}
!575 = !DILocation(line: 70, column: 3, scope: !491, inlinedAt: !562)
!576 = !DILocation(line: 71, column: 6, scope: !516, inlinedAt: !562)
!577 = !DILocation(line: 71, column: 8, scope: !516, inlinedAt: !562)
!578 = !DILocation(line: 71, column: 6, scope: !491, inlinedAt: !562)
!579 = !DILocation(line: 44, column: 32, scope: !478)
!580 = !DILocation(line: 44, column: 3, scope: !478)
!581 = !DILocation(line: 45, column: 3, scope: !478)
!582 = !DILocation(line: 46, column: 1, scope: !478)
!583 = !DISubprogram(name: "free", scope: !584, file: !584, line: 687, type: !423, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!584 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!585 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 48, type: !479, scopeLine: 48, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !586)
!586 = !{!587, !588, !589}
!587 = !DILocalVariable(name: "fd", arg: 1, scope: !585, file: !189, line: 48, type: !211)
!588 = !DILocalVariable(name: "vdata", arg: 2, scope: !585, file: !189, line: 48, type: !241)
!589 = !DILocalVariable(name: "data", scope: !585, file: !189, line: 49, type: !191)
!590 = !DILocation(line: 0, scope: !585)
!591 = !DILocalVariable(name: "fd", arg: 1, scope: !592, file: !2, line: 189, type: !211)
!592 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !593, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !595)
!593 = !DISubroutineType(types: !594)
!594 = !{!211, !211}
!595 = !{!591}
!596 = !DILocation(line: 0, scope: !592, inlinedAt: !597)
!597 = distinct !DILocation(line: 51, column: 3, scope: !585)
!598 = !DILocation(line: 190, column: 3, scope: !599, inlinedAt: !597)
!599 = distinct !DILexicalBlock(scope: !600, file: !2, line: 190, column: 3)
!600 = distinct !DILexicalBlock(scope: !592, file: !2, line: 190, column: 3)
!601 = !DILocation(line: 191, column: 3, scope: !592, inlinedAt: !597)
!602 = !DILocation(line: 52, column: 38, scope: !585)
!603 = !DILocalVariable(name: "fd", arg: 1, scope: !604, file: !2, line: 187, type: !211)
!604 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !605, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !607)
!605 = !DISubroutineType(types: !606)
!606 = !{!211, !211, !335, !211}
!607 = !{!603, !608, !609, !610}
!608 = !DILocalVariable(name: "arr", arg: 2, scope: !604, file: !2, line: 187, type: !335)
!609 = !DILocalVariable(name: "n", arg: 3, scope: !604, file: !2, line: 187, type: !211)
!610 = !DILocalVariable(name: "i", scope: !604, file: !2, line: 187, type: !211)
!611 = !DILocation(line: 0, scope: !604, inlinedAt: !612)
!612 = distinct !DILocation(line: 52, column: 3, scope: !585)
!613 = !DILocation(line: 187, column: 1, scope: !614, inlinedAt: !612)
!614 = distinct !DILexicalBlock(scope: !604, file: !2, line: 187, column: 1)
!615 = !DILocation(line: 187, column: 1, scope: !616, inlinedAt: !612)
!616 = distinct !DILexicalBlock(scope: !617, file: !2, line: 187, column: 1)
!617 = distinct !DILexicalBlock(scope: !614, file: !2, line: 187, column: 1)
!618 = !DILocation(line: 187, column: 1, scope: !617, inlinedAt: !612)
!619 = distinct !{!619, !613, !613, !409, !410}
!620 = !DILocation(line: 0, scope: !592, inlinedAt: !621)
!621 = distinct !DILocation(line: 54, column: 3, scope: !585)
!622 = !DILocation(line: 191, column: 3, scope: !592, inlinedAt: !621)
!623 = !DILocation(line: 55, column: 38, scope: !585)
!624 = !DILocation(line: 0, scope: !604, inlinedAt: !625)
!625 = distinct !DILocation(line: 55, column: 3, scope: !585)
!626 = !DILocation(line: 187, column: 1, scope: !614, inlinedAt: !625)
!627 = !DILocation(line: 187, column: 1, scope: !616, inlinedAt: !625)
!628 = !DILocation(line: 187, column: 1, scope: !617, inlinedAt: !625)
!629 = distinct !{!629, !626, !626, !409, !410}
!630 = !DILocation(line: 0, scope: !592, inlinedAt: !631)
!631 = distinct !DILocation(line: 57, column: 3, scope: !585)
!632 = !DILocation(line: 191, column: 3, scope: !592, inlinedAt: !631)
!633 = !DILocation(line: 58, column: 38, scope: !585)
!634 = !DILocation(line: 0, scope: !604, inlinedAt: !635)
!635 = distinct !DILocation(line: 58, column: 3, scope: !585)
!636 = !DILocation(line: 187, column: 1, scope: !614, inlinedAt: !635)
!637 = !DILocation(line: 187, column: 1, scope: !616, inlinedAt: !635)
!638 = !DILocation(line: 187, column: 1, scope: !617, inlinedAt: !635)
!639 = distinct !{!639, !636, !636, !409, !410}
!640 = !DILocation(line: 0, scope: !592, inlinedAt: !641)
!641 = distinct !DILocation(line: 60, column: 3, scope: !585)
!642 = !DILocation(line: 191, column: 3, scope: !592, inlinedAt: !641)
!643 = !DILocation(line: 61, column: 33, scope: !585)
!644 = !DILocalVariable(name: "fd", arg: 1, scope: !645, file: !2, line: 183, type: !211)
!645 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !646, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !648)
!646 = !DISubroutineType(types: !647)
!647 = !{!211, !211, !336, !211}
!648 = !{!644, !649, !650, !651}
!649 = !DILocalVariable(name: "arr", arg: 2, scope: !645, file: !2, line: 183, type: !336)
!650 = !DILocalVariable(name: "n", arg: 3, scope: !645, file: !2, line: 183, type: !211)
!651 = !DILocalVariable(name: "i", scope: !645, file: !2, line: 183, type: !211)
!652 = !DILocation(line: 0, scope: !645, inlinedAt: !653)
!653 = distinct !DILocation(line: 61, column: 3, scope: !585)
!654 = !DILocation(line: 183, column: 1, scope: !655, inlinedAt: !653)
!655 = distinct !DILexicalBlock(scope: !645, file: !2, line: 183, column: 1)
!656 = !DILocation(line: 183, column: 1, scope: !657, inlinedAt: !653)
!657 = distinct !DILexicalBlock(scope: !658, file: !2, line: 183, column: 1)
!658 = distinct !DILexicalBlock(scope: !655, file: !2, line: 183, column: 1)
!659 = !DILocation(line: 183, column: 1, scope: !658, inlinedAt: !653)
!660 = distinct !{!660, !654, !654, !409, !410}
!661 = !DILocation(line: 63, column: 1, scope: !585)
!662 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 74, type: !479, scopeLine: 74, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !663)
!663 = !{!664, !665, !666, !667, !668}
!664 = !DILocalVariable(name: "fd", arg: 1, scope: !662, file: !189, line: 74, type: !211)
!665 = !DILocalVariable(name: "vdata", arg: 2, scope: !662, file: !189, line: 74, type: !241)
!666 = !DILocalVariable(name: "data", scope: !662, file: !189, line: 75, type: !191)
!667 = !DILocalVariable(name: "p", scope: !662, file: !189, line: 76, type: !240)
!668 = !DILocalVariable(name: "s", scope: !662, file: !189, line: 76, type: !240)
!669 = !DILocation(line: 0, scope: !662)
!670 = !DILocation(line: 78, column: 3, scope: !662)
!671 = !DILocation(line: 80, column: 7, scope: !662)
!672 = !DILocation(line: 0, scope: !491, inlinedAt: !673)
!673 = distinct !DILocation(line: 82, column: 7, scope: !662)
!674 = !DILocation(line: 64, column: 17, scope: !491, inlinedAt: !673)
!675 = !DILocation(line: 64, column: 3, scope: !491, inlinedAt: !673)
!676 = !DILocation(line: 66, column: 22, scope: !503, inlinedAt: !673)
!677 = !DILocation(line: 66, column: 26, scope: !503, inlinedAt: !673)
!678 = !DILocation(line: 66, column: 32, scope: !503, inlinedAt: !673)
!679 = !DILocation(line: 66, column: 35, scope: !503, inlinedAt: !673)
!680 = !DILocation(line: 66, column: 39, scope: !503, inlinedAt: !673)
!681 = !DILocation(line: 66, column: 9, scope: !504, inlinedAt: !673)
!682 = !DILocation(line: 69, column: 6, scope: !504, inlinedAt: !673)
!683 = !DILocation(line: 64, column: 10, scope: !491, inlinedAt: !673)
!684 = !DILocation(line: 64, column: 13, scope: !491, inlinedAt: !673)
!685 = distinct !{!685, !675, !686, !409, !410}
!686 = !DILocation(line: 70, column: 3, scope: !491, inlinedAt: !673)
!687 = !DILocation(line: 71, column: 6, scope: !516, inlinedAt: !673)
!688 = !DILocation(line: 71, column: 8, scope: !516, inlinedAt: !673)
!689 = !DILocation(line: 71, column: 6, scope: !491, inlinedAt: !673)
!690 = !DILocation(line: 83, column: 3, scope: !662)
!691 = !DILocation(line: 0, scope: !491, inlinedAt: !692)
!692 = distinct !DILocation(line: 85, column: 7, scope: !662)
!693 = !DILocation(line: 64, column: 17, scope: !491, inlinedAt: !692)
!694 = !DILocation(line: 64, column: 3, scope: !491, inlinedAt: !692)
!695 = !DILocation(line: 66, column: 22, scope: !503, inlinedAt: !692)
!696 = !DILocation(line: 66, column: 26, scope: !503, inlinedAt: !692)
!697 = !DILocation(line: 66, column: 32, scope: !503, inlinedAt: !692)
!698 = !DILocation(line: 66, column: 35, scope: !503, inlinedAt: !692)
!699 = !DILocation(line: 66, column: 39, scope: !503, inlinedAt: !692)
!700 = !DILocation(line: 66, column: 9, scope: !504, inlinedAt: !692)
!701 = !DILocation(line: 69, column: 6, scope: !504, inlinedAt: !692)
!702 = !DILocation(line: 64, column: 10, scope: !491, inlinedAt: !692)
!703 = !DILocation(line: 64, column: 13, scope: !491, inlinedAt: !692)
!704 = distinct !{!704, !694, !705, !409, !410}
!705 = !DILocation(line: 70, column: 3, scope: !491, inlinedAt: !692)
!706 = !DILocation(line: 71, column: 6, scope: !516, inlinedAt: !692)
!707 = !DILocation(line: 71, column: 8, scope: !516, inlinedAt: !692)
!708 = !DILocation(line: 71, column: 6, scope: !491, inlinedAt: !692)
!709 = !DILocation(line: 86, column: 37, scope: !662)
!710 = !DILocation(line: 86, column: 3, scope: !662)
!711 = !DILocation(line: 0, scope: !491, inlinedAt: !712)
!712 = distinct !DILocation(line: 88, column: 7, scope: !662)
!713 = !DILocation(line: 64, column: 17, scope: !491, inlinedAt: !712)
!714 = !DILocation(line: 64, column: 3, scope: !491, inlinedAt: !712)
!715 = !DILocation(line: 66, column: 22, scope: !503, inlinedAt: !712)
!716 = !DILocation(line: 66, column: 26, scope: !503, inlinedAt: !712)
!717 = !DILocation(line: 66, column: 32, scope: !503, inlinedAt: !712)
!718 = !DILocation(line: 66, column: 35, scope: !503, inlinedAt: !712)
!719 = !DILocation(line: 66, column: 39, scope: !503, inlinedAt: !712)
!720 = !DILocation(line: 66, column: 9, scope: !504, inlinedAt: !712)
!721 = !DILocation(line: 69, column: 6, scope: !504, inlinedAt: !712)
!722 = !DILocation(line: 64, column: 10, scope: !491, inlinedAt: !712)
!723 = !DILocation(line: 64, column: 13, scope: !491, inlinedAt: !712)
!724 = distinct !{!724, !714, !725, !409, !410}
!725 = !DILocation(line: 70, column: 3, scope: !491, inlinedAt: !712)
!726 = !DILocation(line: 71, column: 6, scope: !516, inlinedAt: !712)
!727 = !DILocation(line: 71, column: 8, scope: !516, inlinedAt: !712)
!728 = !DILocation(line: 71, column: 6, scope: !491, inlinedAt: !712)
!729 = !DILocation(line: 89, column: 37, scope: !662)
!730 = !DILocation(line: 89, column: 3, scope: !662)
!731 = !DILocation(line: 90, column: 3, scope: !662)
!732 = !DILocation(line: 91, column: 1, scope: !662)
!733 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 93, type: !479, scopeLine: 93, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !734)
!734 = !{!735, !736, !737}
!735 = !DILocalVariable(name: "fd", arg: 1, scope: !733, file: !189, line: 93, type: !211)
!736 = !DILocalVariable(name: "vdata", arg: 2, scope: !733, file: !189, line: 93, type: !241)
!737 = !DILocalVariable(name: "data", scope: !733, file: !189, line: 94, type: !191)
!738 = !DILocation(line: 0, scope: !733)
!739 = !DILocation(line: 0, scope: !592, inlinedAt: !740)
!740 = distinct !DILocation(line: 96, column: 3, scope: !733)
!741 = !DILocation(line: 190, column: 3, scope: !599, inlinedAt: !740)
!742 = !DILocation(line: 191, column: 3, scope: !592, inlinedAt: !740)
!743 = !DILocation(line: 0, scope: !604, inlinedAt: !744)
!744 = distinct !DILocation(line: 97, column: 3, scope: !733)
!745 = !DILocation(line: 187, column: 1, scope: !614, inlinedAt: !744)
!746 = !DILocation(line: 187, column: 1, scope: !616, inlinedAt: !744)
!747 = !DILocation(line: 187, column: 1, scope: !617, inlinedAt: !744)
!748 = distinct !{!748, !745, !745, !409, !410}
!749 = !DILocation(line: 0, scope: !592, inlinedAt: !750)
!750 = distinct !DILocation(line: 99, column: 3, scope: !733)
!751 = !DILocation(line: 191, column: 3, scope: !592, inlinedAt: !750)
!752 = !DILocation(line: 100, column: 38, scope: !733)
!753 = !DILocation(line: 0, scope: !604, inlinedAt: !754)
!754 = distinct !DILocation(line: 100, column: 3, scope: !733)
!755 = !DILocation(line: 187, column: 1, scope: !614, inlinedAt: !754)
!756 = !DILocation(line: 187, column: 1, scope: !616, inlinedAt: !754)
!757 = !DILocation(line: 187, column: 1, scope: !617, inlinedAt: !754)
!758 = distinct !{!758, !755, !755, !409, !410}
!759 = !DILocation(line: 0, scope: !592, inlinedAt: !760)
!760 = distinct !DILocation(line: 102, column: 3, scope: !733)
!761 = !DILocation(line: 191, column: 3, scope: !592, inlinedAt: !760)
!762 = !DILocation(line: 103, column: 38, scope: !733)
!763 = !DILocation(line: 0, scope: !604, inlinedAt: !764)
!764 = distinct !DILocation(line: 103, column: 3, scope: !733)
!765 = !DILocation(line: 187, column: 1, scope: !614, inlinedAt: !764)
!766 = !DILocation(line: 187, column: 1, scope: !616, inlinedAt: !764)
!767 = !DILocation(line: 187, column: 1, scope: !617, inlinedAt: !764)
!768 = distinct !{!768, !765, !765, !409, !410}
!769 = !DILocation(line: 104, column: 1, scope: !733)
!770 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 106, type: !771, scopeLine: 106, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !773)
!771 = !DISubroutineType(types: !772)
!772 = !{!211, !241, !241}
!773 = !{!774, !775, !776, !777, !778, !779, !780, !781, !782}
!774 = !DILocalVariable(name: "vdata", arg: 1, scope: !770, file: !189, line: 106, type: !241)
!775 = !DILocalVariable(name: "vref", arg: 2, scope: !770, file: !189, line: 106, type: !241)
!776 = !DILocalVariable(name: "data", scope: !770, file: !189, line: 107, type: !191)
!777 = !DILocalVariable(name: "ref", scope: !770, file: !189, line: 108, type: !191)
!778 = !DILocalVariable(name: "has_errors", scope: !770, file: !189, line: 109, type: !211)
!779 = !DILocalVariable(name: "i", scope: !770, file: !189, line: 110, type: !211)
!780 = !DILocalVariable(name: "diff_x", scope: !770, file: !189, line: 111, type: !197)
!781 = !DILocalVariable(name: "diff_y", scope: !770, file: !189, line: 111, type: !197)
!782 = !DILocalVariable(name: "diff_z", scope: !770, file: !189, line: 111, type: !197)
!783 = !DILocation(line: 0, scope: !770)
!784 = !DILocation(line: 113, column: 3, scope: !785)
!785 = distinct !DILexicalBlock(scope: !770, file: !189, line: 113, column: 3)
!786 = !DILocation(line: 114, column: 14, scope: !787)
!787 = distinct !DILexicalBlock(scope: !788, file: !189, line: 113, column: 29)
!788 = distinct !DILexicalBlock(scope: !785, file: !189, line: 113, column: 3)
!789 = !DILocation(line: 114, column: 33, scope: !787)
!790 = !DILocation(line: 114, column: 31, scope: !787)
!791 = !DILocation(line: 115, column: 14, scope: !787)
!792 = !DILocation(line: 115, column: 33, scope: !787)
!793 = !DILocation(line: 115, column: 31, scope: !787)
!794 = !DILocation(line: 116, column: 14, scope: !787)
!795 = !DILocation(line: 116, column: 33, scope: !787)
!796 = !DILocation(line: 116, column: 31, scope: !787)
!797 = !DILocation(line: 117, column: 37, scope: !787)
!798 = !DILocation(line: 118, column: 37, scope: !787)
!799 = !DILocation(line: 118, column: 16, scope: !787)
!800 = !DILocation(line: 119, column: 37, scope: !787)
!801 = !DILocation(line: 119, column: 16, scope: !787)
!802 = !DILocation(line: 113, column: 24, scope: !788)
!803 = !DILocation(line: 113, column: 14, scope: !788)
!804 = distinct !{!804, !784, !805, !409, !410}
!805 = !DILocation(line: 120, column: 3, scope: !785)
!806 = !DILocation(line: 123, column: 10, scope: !770)
!807 = !DILocation(line: 123, column: 3, scope: !770)
!808 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !809, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !811)
!809 = !DISubroutineType(types: !810)
!810 = !{!240, !211}
!811 = !{!812, !813, !814, !851, !854, !857}
!812 = !DILocalVariable(name: "fd", arg: 1, scope: !808, file: !2, line: 34, type: !211)
!813 = !DILocalVariable(name: "p", scope: !808, file: !2, line: 35, type: !240)
!814 = !DILocalVariable(name: "s", scope: !808, file: !2, line: 36, type: !815)
!815 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !816, line: 44, size: 1024, elements: !817)
!816 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!817 = !{!818, !820, !822, !824, !826, !828, !830, !831, !832, !834, !836, !837, !839, !847, !848, !849}
!818 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !815, file: !816, line: 46, baseType: !819, size: 64)
!819 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !210, line: 145, baseType: !254)
!820 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !815, file: !816, line: 47, baseType: !821, size: 64, offset: 64)
!821 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !210, line: 148, baseType: !254)
!822 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !815, file: !816, line: 48, baseType: !823, size: 32, offset: 128)
!823 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !210, line: 150, baseType: !251)
!824 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !815, file: !816, line: 49, baseType: !825, size: 32, offset: 160)
!825 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !210, line: 151, baseType: !251)
!826 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !815, file: !816, line: 50, baseType: !827, size: 32, offset: 192)
!827 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !210, line: 146, baseType: !251)
!828 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !815, file: !816, line: 51, baseType: !829, size: 32, offset: 224)
!829 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !210, line: 147, baseType: !251)
!830 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !815, file: !816, line: 52, baseType: !819, size: 64, offset: 256)
!831 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !815, file: !816, line: 53, baseType: !819, size: 64, offset: 320)
!832 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !815, file: !816, line: 54, baseType: !833, size: 64, offset: 384)
!833 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !210, line: 152, baseType: !263)
!834 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !815, file: !816, line: 55, baseType: !835, size: 32, offset: 448)
!835 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !210, line: 175, baseType: !211)
!836 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !815, file: !816, line: 56, baseType: !211, size: 32, offset: 480)
!837 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !815, file: !816, line: 57, baseType: !838, size: 64, offset: 512)
!838 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !210, line: 180, baseType: !263)
!839 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !815, file: !816, line: 65, baseType: !840, size: 128, offset: 576)
!840 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !841, line: 11, size: 128, elements: !842)
!841 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!842 = !{!843, !845}
!843 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !840, file: !841, line: 16, baseType: !844, size: 64)
!844 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !210, line: 160, baseType: !263)
!845 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !840, file: !841, line: 21, baseType: !846, size: 64, offset: 64)
!846 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !210, line: 197, baseType: !263)
!847 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !815, file: !816, line: 66, baseType: !840, size: 128, offset: 704)
!848 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !815, file: !816, line: 67, baseType: !840, size: 128, offset: 832)
!849 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !815, file: !816, line: 79, baseType: !850, size: 64, offset: 960)
!850 = !DICompositeType(tag: DW_TAG_array_type, baseType: !211, size: 64, elements: !55)
!851 = !DILocalVariable(name: "len", scope: !808, file: !2, line: 37, type: !852)
!852 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !853, line: 85, baseType: !833)
!853 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!854 = !DILocalVariable(name: "bytes_read", scope: !808, file: !2, line: 38, type: !855)
!855 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !853, line: 108, baseType: !856)
!856 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !210, line: 194, baseType: !263)
!857 = !DILocalVariable(name: "status", scope: !808, file: !2, line: 38, type: !855)
!858 = distinct !DIAssignID()
!859 = !DILocation(line: 0, scope: !808)
!860 = !DILocation(line: 36, column: 3, scope: !808)
!861 = !DILocation(line: 40, column: 3, scope: !862)
!862 = distinct !DILexicalBlock(scope: !863, file: !2, line: 40, column: 3)
!863 = distinct !DILexicalBlock(scope: !808, file: !2, line: 40, column: 3)
!864 = !DILocation(line: 41, column: 3, scope: !865)
!865 = distinct !DILexicalBlock(scope: !866, file: !2, line: 41, column: 3)
!866 = distinct !DILexicalBlock(scope: !808, file: !2, line: 41, column: 3)
!867 = !DILocation(line: 42, column: 11, scope: !808)
!868 = !DILocation(line: 43, column: 3, scope: !869)
!869 = distinct !DILexicalBlock(scope: !870, file: !2, line: 43, column: 3)
!870 = distinct !DILexicalBlock(scope: !808, file: !2, line: 43, column: 3)
!871 = !DILocation(line: 44, column: 25, scope: !808)
!872 = !DILocation(line: 44, column: 15, scope: !808)
!873 = !DILocation(line: 46, column: 3, scope: !808)
!874 = !DILocation(line: 49, column: 15, scope: !875)
!875 = distinct !DILexicalBlock(scope: !808, file: !2, line: 46, column: 27)
!876 = !DILocation(line: 46, column: 20, scope: !808)
!877 = distinct !{!877, !873, !878, !409, !410}
!878 = !DILocation(line: 50, column: 3, scope: !808)
!879 = !DILocation(line: 47, column: 24, scope: !875)
!880 = !DILocation(line: 47, column: 42, scope: !875)
!881 = !DILocation(line: 47, column: 14, scope: !875)
!882 = !DILocation(line: 48, column: 5, scope: !883)
!883 = distinct !DILexicalBlock(scope: !884, file: !2, line: 48, column: 5)
!884 = distinct !DILexicalBlock(scope: !875, file: !2, line: 48, column: 5)
!885 = !DILocation(line: 51, column: 3, scope: !808)
!886 = !DILocation(line: 51, column: 10, scope: !808)
!887 = !DILocation(line: 52, column: 3, scope: !808)
!888 = !DILocation(line: 54, column: 1, scope: !808)
!889 = !DILocation(line: 53, column: 3, scope: !808)
!890 = !DISubprogram(name: "__assert_fail", scope: !891, file: !891, line: 67, type: !892, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!891 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!892 = !DISubroutineType(types: !893)
!893 = !{null, !894, !894, !251, !894}
!894 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!895 = !DISubprogram(name: "fstat", scope: !896, file: !896, line: 210, type: !897, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!896 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!897 = !DISubroutineType(types: !898)
!898 = !{!211, !211, !899}
!899 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !815, size: 64)
!900 = !DISubprogram(name: "malloc", scope: !584, file: !584, line: 672, type: !901, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!901 = !DISubroutineType(types: !902)
!902 = !{!241, !903}
!903 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !904, line: 18, baseType: !254)
!904 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!905 = !DISubprogram(name: "read", scope: !906, file: !906, line: 371, type: !907, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!906 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!907 = !DISubroutineType(types: !908)
!908 = !{!855, !211, !241, !903}
!909 = !DISubprogram(name: "close", scope: !906, file: !906, line: 358, type: !593, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!910 = !DILocation(line: 0, scope: !491)
!911 = !DILocation(line: 59, column: 3, scope: !912)
!912 = distinct !DILexicalBlock(scope: !913, file: !2, line: 59, column: 3)
!913 = distinct !DILexicalBlock(scope: !491, file: !2, line: 59, column: 3)
!914 = !DILocation(line: 60, column: 7, scope: !915)
!915 = distinct !DILexicalBlock(scope: !491, file: !2, line: 60, column: 6)
!916 = !DILocation(line: 60, column: 6, scope: !491)
!917 = !DILocation(line: 64, column: 17, scope: !491)
!918 = !DILocation(line: 64, column: 3, scope: !491)
!919 = !DILocation(line: 66, column: 22, scope: !503)
!920 = !DILocation(line: 66, column: 26, scope: !503)
!921 = !DILocation(line: 66, column: 32, scope: !503)
!922 = !DILocation(line: 66, column: 35, scope: !503)
!923 = !DILocation(line: 66, column: 39, scope: !503)
!924 = !DILocation(line: 66, column: 9, scope: !504)
!925 = !DILocation(line: 69, column: 6, scope: !504)
!926 = !DILocation(line: 64, column: 10, scope: !491)
!927 = !DILocation(line: 64, column: 13, scope: !491)
!928 = distinct !{!928, !918, !929, !409, !410}
!929 = !DILocation(line: 70, column: 3, scope: !491)
!930 = !DILocation(line: 71, column: 6, scope: !516)
!931 = !DILocation(line: 71, column: 8, scope: !516)
!932 = !DILocation(line: 71, column: 6, scope: !491)
!933 = !DILocation(line: 74, column: 1, scope: !491)
!934 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !935, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !937)
!935 = !DISubroutineType(types: !936)
!936 = !{!211, !240, !240, !211}
!937 = !{!938, !939, !940, !941}
!938 = !DILocalVariable(name: "s", arg: 1, scope: !934, file: !2, line: 77, type: !240)
!939 = !DILocalVariable(name: "arr", arg: 2, scope: !934, file: !2, line: 77, type: !240)
!940 = !DILocalVariable(name: "n", arg: 3, scope: !934, file: !2, line: 77, type: !211)
!941 = !DILocalVariable(name: "k", scope: !934, file: !2, line: 78, type: !211)
!942 = !DILocation(line: 0, scope: !934)
!943 = !DILocation(line: 79, column: 3, scope: !944)
!944 = distinct !DILexicalBlock(scope: !945, file: !2, line: 79, column: 3)
!945 = distinct !DILexicalBlock(scope: !934, file: !2, line: 79, column: 3)
!946 = !DILocation(line: 81, column: 8, scope: !947)
!947 = distinct !DILexicalBlock(scope: !934, file: !2, line: 81, column: 7)
!948 = !DILocation(line: 81, column: 7, scope: !934)
!949 = !DILocation(line: 83, column: 12, scope: !950)
!950 = distinct !DILexicalBlock(scope: !947, file: !2, line: 81, column: 13)
!951 = !DILocation(line: 83, column: 5, scope: !950)
!952 = !DILocation(line: 91, column: 19, scope: !934)
!953 = !DILocation(line: 91, column: 3, scope: !934)
!954 = !DILocation(line: 92, column: 7, scope: !934)
!955 = !DILocation(line: 83, column: 16, scope: !950)
!956 = !DILocation(line: 83, column: 26, scope: !950)
!957 = !DILocation(line: 83, column: 32, scope: !950)
!958 = !DILocation(line: 83, column: 29, scope: !950)
!959 = !DILocation(line: 83, column: 35, scope: !950)
!960 = !DILocation(line: 83, column: 45, scope: !950)
!961 = !DILocation(line: 83, column: 48, scope: !950)
!962 = !DILocation(line: 83, column: 54, scope: !950)
!963 = !DILocation(line: 84, column: 9, scope: !950)
!964 = !DILocation(line: 84, column: 18, scope: !950)
!965 = !DILocation(line: 84, column: 26, scope: !950)
!966 = distinct !{!966, !951, !967, !409, !410}
!967 = !DILocation(line: 86, column: 5, scope: !950)
!968 = !DILocation(line: 93, column: 5, scope: !969)
!969 = distinct !DILexicalBlock(scope: !934, file: !2, line: 92, column: 7)
!970 = !DILocation(line: 93, column: 12, scope: !969)
!971 = !DILocation(line: 95, column: 3, scope: !934)
!972 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !973, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !976)
!973 = !DISubroutineType(types: !974)
!974 = !{!211, !240, !975, !211}
!975 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !242, size: 64)
!976 = !{!977, !978, !979, !980, !981, !982, !983}
!977 = !DILocalVariable(name: "s", arg: 1, scope: !972, file: !2, line: 132, type: !240)
!978 = !DILocalVariable(name: "arr", arg: 2, scope: !972, file: !2, line: 132, type: !975)
!979 = !DILocalVariable(name: "n", arg: 3, scope: !972, file: !2, line: 132, type: !211)
!980 = !DILocalVariable(name: "line", scope: !972, file: !2, line: 132, type: !240)
!981 = !DILocalVariable(name: "endptr", scope: !972, file: !2, line: 132, type: !240)
!982 = !DILocalVariable(name: "i", scope: !972, file: !2, line: 132, type: !211)
!983 = !DILocalVariable(name: "v", scope: !972, file: !2, line: 132, type: !242)
!984 = distinct !DIAssignID()
!985 = !DILocation(line: 0, scope: !972)
!986 = !DILocation(line: 132, column: 1, scope: !972)
!987 = !DILocation(line: 132, column: 1, scope: !988)
!988 = distinct !DILexicalBlock(scope: !989, file: !2, line: 132, column: 1)
!989 = distinct !DILexicalBlock(scope: !972, file: !2, line: 132, column: 1)
!990 = !DILocation(line: 132, column: 1, scope: !991)
!991 = distinct !DILexicalBlock(scope: !972, file: !2, line: 132, column: 1)
!992 = !{!993, !993, i64 0}
!993 = !{!"any pointer", !383, i64 0}
!994 = distinct !DIAssignID()
!995 = !DILocation(line: 132, column: 1, scope: !996)
!996 = distinct !DILexicalBlock(scope: !991, file: !2, line: 132, column: 1)
!997 = !DILocation(line: 132, column: 1, scope: !998)
!998 = distinct !DILexicalBlock(scope: !996, file: !2, line: 132, column: 1)
!999 = distinct !{!999, !986, !986, !409, !410}
!1000 = !DILocation(line: 132, column: 1, scope: !1001)
!1001 = distinct !DILexicalBlock(scope: !1002, file: !2, line: 132, column: 1)
!1002 = distinct !DILexicalBlock(scope: !972, file: !2, line: 132, column: 1)
!1003 = !DISubprogram(name: "strtok", scope: !1004, file: !1004, line: 356, type: !1005, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1004 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!1005 = !DISubroutineType(types: !1006)
!1006 = !{!240, !1007, !1008}
!1007 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !240)
!1008 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !894)
!1009 = !DISubprogram(name: "strtol", scope: !584, file: !584, line: 177, type: !1010, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1010 = !DISubroutineType(types: !1011)
!1011 = !{!263, !1008, !1012, !211}
!1012 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1013)
!1013 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !240, size: 64)
!1014 = !DISubprogram(name: "fprintf", scope: !1015, file: !1015, line: 357, type: !1016, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1015 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!1016 = !DISubroutineType(types: !1017)
!1017 = !{!211, !1018, !1008, null}
!1018 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1019)
!1019 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1020, size: 64)
!1020 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !1021, line: 7, baseType: !1022)
!1021 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!1022 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !1023, line: 49, size: 1728, elements: !1024)
!1023 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!1024 = !{!1025, !1026, !1027, !1028, !1029, !1030, !1031, !1032, !1033, !1034, !1035, !1036, !1037, !1040, !1042, !1043, !1044, !1045, !1046, !1047, !1051, !1054, !1056, !1059, !1062, !1063, !1064, !1066, !1067}
!1025 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !1022, file: !1023, line: 51, baseType: !211, size: 32)
!1026 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !1022, file: !1023, line: 54, baseType: !240, size: 64, offset: 64)
!1027 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !1022, file: !1023, line: 55, baseType: !240, size: 64, offset: 128)
!1028 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !1022, file: !1023, line: 56, baseType: !240, size: 64, offset: 192)
!1029 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !1022, file: !1023, line: 57, baseType: !240, size: 64, offset: 256)
!1030 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !1022, file: !1023, line: 58, baseType: !240, size: 64, offset: 320)
!1031 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !1022, file: !1023, line: 59, baseType: !240, size: 64, offset: 384)
!1032 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !1022, file: !1023, line: 60, baseType: !240, size: 64, offset: 448)
!1033 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !1022, file: !1023, line: 61, baseType: !240, size: 64, offset: 512)
!1034 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !1022, file: !1023, line: 64, baseType: !240, size: 64, offset: 576)
!1035 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !1022, file: !1023, line: 65, baseType: !240, size: 64, offset: 640)
!1036 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !1022, file: !1023, line: 66, baseType: !240, size: 64, offset: 704)
!1037 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !1022, file: !1023, line: 68, baseType: !1038, size: 64, offset: 768)
!1038 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1039, size: 64)
!1039 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !1023, line: 36, flags: DIFlagFwdDecl)
!1040 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !1022, file: !1023, line: 70, baseType: !1041, size: 64, offset: 832)
!1041 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1022, size: 64)
!1042 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !1022, file: !1023, line: 72, baseType: !211, size: 32, offset: 896)
!1043 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !1022, file: !1023, line: 73, baseType: !211, size: 32, offset: 928)
!1044 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !1022, file: !1023, line: 74, baseType: !833, size: 64, offset: 960)
!1045 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !1022, file: !1023, line: 77, baseType: !248, size: 16, offset: 1024)
!1046 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !1022, file: !1023, line: 78, baseType: !257, size: 8, offset: 1040)
!1047 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !1022, file: !1023, line: 79, baseType: !1048, size: 8, offset: 1048)
!1048 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !1049)
!1049 = !{!1050}
!1050 = !DISubrange(count: 1)
!1051 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !1022, file: !1023, line: 81, baseType: !1052, size: 64, offset: 1088)
!1052 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1053, size: 64)
!1053 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !1023, line: 43, baseType: null)
!1054 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !1022, file: !1023, line: 89, baseType: !1055, size: 64, offset: 1152)
!1055 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !210, line: 153, baseType: !263)
!1056 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !1022, file: !1023, line: 91, baseType: !1057, size: 64, offset: 1216)
!1057 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1058, size: 64)
!1058 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !1023, line: 37, flags: DIFlagFwdDecl)
!1059 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !1022, file: !1023, line: 92, baseType: !1060, size: 64, offset: 1280)
!1060 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1061, size: 64)
!1061 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !1023, line: 38, flags: DIFlagFwdDecl)
!1062 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !1022, file: !1023, line: 93, baseType: !1041, size: 64, offset: 1344)
!1063 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !1022, file: !1023, line: 94, baseType: !241, size: 64, offset: 1408)
!1064 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !1022, file: !1023, line: 95, baseType: !1065, size: 64, offset: 1472)
!1065 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1041, size: 64)
!1066 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !1022, file: !1023, line: 96, baseType: !211, size: 32, offset: 1536)
!1067 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !1022, file: !1023, line: 98, baseType: !1068, size: 160, offset: 1568)
!1068 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!1069 = !DISubprogram(name: "strlen", scope: !1004, file: !1004, line: 407, type: !1070, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1070 = !DISubroutineType(types: !1071)
!1071 = !{!254, !894}
!1072 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !1073, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1076)
!1073 = !DISubroutineType(types: !1074)
!1074 = !{!211, !240, !1075, !211}
!1075 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !246, size: 64)
!1076 = !{!1077, !1078, !1079, !1080, !1081, !1082, !1083}
!1077 = !DILocalVariable(name: "s", arg: 1, scope: !1072, file: !2, line: 133, type: !240)
!1078 = !DILocalVariable(name: "arr", arg: 2, scope: !1072, file: !2, line: 133, type: !1075)
!1079 = !DILocalVariable(name: "n", arg: 3, scope: !1072, file: !2, line: 133, type: !211)
!1080 = !DILocalVariable(name: "line", scope: !1072, file: !2, line: 133, type: !240)
!1081 = !DILocalVariable(name: "endptr", scope: !1072, file: !2, line: 133, type: !240)
!1082 = !DILocalVariable(name: "i", scope: !1072, file: !2, line: 133, type: !211)
!1083 = !DILocalVariable(name: "v", scope: !1072, file: !2, line: 133, type: !246)
!1084 = distinct !DIAssignID()
!1085 = !DILocation(line: 0, scope: !1072)
!1086 = !DILocation(line: 133, column: 1, scope: !1072)
!1087 = !DILocation(line: 133, column: 1, scope: !1088)
!1088 = distinct !DILexicalBlock(scope: !1089, file: !2, line: 133, column: 1)
!1089 = distinct !DILexicalBlock(scope: !1072, file: !2, line: 133, column: 1)
!1090 = !DILocation(line: 133, column: 1, scope: !1091)
!1091 = distinct !DILexicalBlock(scope: !1072, file: !2, line: 133, column: 1)
!1092 = distinct !DIAssignID()
!1093 = !DILocation(line: 133, column: 1, scope: !1094)
!1094 = distinct !DILexicalBlock(scope: !1091, file: !2, line: 133, column: 1)
!1095 = !DILocation(line: 133, column: 1, scope: !1096)
!1096 = distinct !DILexicalBlock(scope: !1094, file: !2, line: 133, column: 1)
!1097 = !{!1098, !1098, i64 0}
!1098 = !{!"short", !383, i64 0}
!1099 = distinct !{!1099, !1086, !1086, !409, !410}
!1100 = !DILocation(line: 133, column: 1, scope: !1101)
!1101 = distinct !DILexicalBlock(scope: !1102, file: !2, line: 133, column: 1)
!1102 = distinct !DILexicalBlock(scope: !1072, file: !2, line: 133, column: 1)
!1103 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !1104, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1107)
!1104 = !DISubroutineType(types: !1105)
!1105 = !{!211, !240, !1106, !211}
!1106 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !249, size: 64)
!1107 = !{!1108, !1109, !1110, !1111, !1112, !1113, !1114}
!1108 = !DILocalVariable(name: "s", arg: 1, scope: !1103, file: !2, line: 134, type: !240)
!1109 = !DILocalVariable(name: "arr", arg: 2, scope: !1103, file: !2, line: 134, type: !1106)
!1110 = !DILocalVariable(name: "n", arg: 3, scope: !1103, file: !2, line: 134, type: !211)
!1111 = !DILocalVariable(name: "line", scope: !1103, file: !2, line: 134, type: !240)
!1112 = !DILocalVariable(name: "endptr", scope: !1103, file: !2, line: 134, type: !240)
!1113 = !DILocalVariable(name: "i", scope: !1103, file: !2, line: 134, type: !211)
!1114 = !DILocalVariable(name: "v", scope: !1103, file: !2, line: 134, type: !249)
!1115 = distinct !DIAssignID()
!1116 = !DILocation(line: 0, scope: !1103)
!1117 = !DILocation(line: 134, column: 1, scope: !1103)
!1118 = !DILocation(line: 134, column: 1, scope: !1119)
!1119 = distinct !DILexicalBlock(scope: !1120, file: !2, line: 134, column: 1)
!1120 = distinct !DILexicalBlock(scope: !1103, file: !2, line: 134, column: 1)
!1121 = !DILocation(line: 134, column: 1, scope: !1122)
!1122 = distinct !DILexicalBlock(scope: !1103, file: !2, line: 134, column: 1)
!1123 = distinct !DIAssignID()
!1124 = !DILocation(line: 134, column: 1, scope: !1125)
!1125 = distinct !DILexicalBlock(scope: !1122, file: !2, line: 134, column: 1)
!1126 = !DILocation(line: 134, column: 1, scope: !1127)
!1127 = distinct !DILexicalBlock(scope: !1125, file: !2, line: 134, column: 1)
!1128 = distinct !{!1128, !1117, !1117, !409, !410}
!1129 = !DILocation(line: 134, column: 1, scope: !1130)
!1130 = distinct !DILexicalBlock(scope: !1131, file: !2, line: 134, column: 1)
!1131 = distinct !DILexicalBlock(scope: !1103, file: !2, line: 134, column: 1)
!1132 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !1133, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1136)
!1133 = !DISubroutineType(types: !1134)
!1134 = !{!211, !240, !1135, !211}
!1135 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !252, size: 64)
!1136 = !{!1137, !1138, !1139, !1140, !1141, !1142, !1143}
!1137 = !DILocalVariable(name: "s", arg: 1, scope: !1132, file: !2, line: 135, type: !240)
!1138 = !DILocalVariable(name: "arr", arg: 2, scope: !1132, file: !2, line: 135, type: !1135)
!1139 = !DILocalVariable(name: "n", arg: 3, scope: !1132, file: !2, line: 135, type: !211)
!1140 = !DILocalVariable(name: "line", scope: !1132, file: !2, line: 135, type: !240)
!1141 = !DILocalVariable(name: "endptr", scope: !1132, file: !2, line: 135, type: !240)
!1142 = !DILocalVariable(name: "i", scope: !1132, file: !2, line: 135, type: !211)
!1143 = !DILocalVariable(name: "v", scope: !1132, file: !2, line: 135, type: !252)
!1144 = distinct !DIAssignID()
!1145 = !DILocation(line: 0, scope: !1132)
!1146 = !DILocation(line: 135, column: 1, scope: !1132)
!1147 = !DILocation(line: 135, column: 1, scope: !1148)
!1148 = distinct !DILexicalBlock(scope: !1149, file: !2, line: 135, column: 1)
!1149 = distinct !DILexicalBlock(scope: !1132, file: !2, line: 135, column: 1)
!1150 = !DILocation(line: 135, column: 1, scope: !1151)
!1151 = distinct !DILexicalBlock(scope: !1132, file: !2, line: 135, column: 1)
!1152 = distinct !DIAssignID()
!1153 = !DILocation(line: 135, column: 1, scope: !1154)
!1154 = distinct !DILexicalBlock(scope: !1151, file: !2, line: 135, column: 1)
!1155 = !DILocation(line: 135, column: 1, scope: !1156)
!1156 = distinct !DILexicalBlock(scope: !1154, file: !2, line: 135, column: 1)
!1157 = !{!1158, !1158, i64 0}
!1158 = !{!"long", !383, i64 0}
!1159 = distinct !{!1159, !1146, !1146, !409, !410}
!1160 = !DILocation(line: 135, column: 1, scope: !1161)
!1161 = distinct !DILexicalBlock(scope: !1162, file: !2, line: 135, column: 1)
!1162 = distinct !DILexicalBlock(scope: !1132, file: !2, line: 135, column: 1)
!1163 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1164, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1167)
!1164 = !DISubroutineType(types: !1165)
!1165 = !{!211, !240, !1166, !211}
!1166 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !255, size: 64)
!1167 = !{!1168, !1169, !1170, !1171, !1172, !1173, !1174}
!1168 = !DILocalVariable(name: "s", arg: 1, scope: !1163, file: !2, line: 136, type: !240)
!1169 = !DILocalVariable(name: "arr", arg: 2, scope: !1163, file: !2, line: 136, type: !1166)
!1170 = !DILocalVariable(name: "n", arg: 3, scope: !1163, file: !2, line: 136, type: !211)
!1171 = !DILocalVariable(name: "line", scope: !1163, file: !2, line: 136, type: !240)
!1172 = !DILocalVariable(name: "endptr", scope: !1163, file: !2, line: 136, type: !240)
!1173 = !DILocalVariable(name: "i", scope: !1163, file: !2, line: 136, type: !211)
!1174 = !DILocalVariable(name: "v", scope: !1163, file: !2, line: 136, type: !255)
!1175 = distinct !DIAssignID()
!1176 = !DILocation(line: 0, scope: !1163)
!1177 = !DILocation(line: 136, column: 1, scope: !1163)
!1178 = !DILocation(line: 136, column: 1, scope: !1179)
!1179 = distinct !DILexicalBlock(scope: !1180, file: !2, line: 136, column: 1)
!1180 = distinct !DILexicalBlock(scope: !1163, file: !2, line: 136, column: 1)
!1181 = !DILocation(line: 136, column: 1, scope: !1182)
!1182 = distinct !DILexicalBlock(scope: !1163, file: !2, line: 136, column: 1)
!1183 = distinct !DIAssignID()
!1184 = !DILocation(line: 136, column: 1, scope: !1185)
!1185 = distinct !DILexicalBlock(scope: !1182, file: !2, line: 136, column: 1)
!1186 = !DILocation(line: 136, column: 1, scope: !1187)
!1187 = distinct !DILexicalBlock(scope: !1185, file: !2, line: 136, column: 1)
!1188 = distinct !{!1188, !1177, !1177, !409, !410}
!1189 = !DILocation(line: 136, column: 1, scope: !1190)
!1190 = distinct !DILexicalBlock(scope: !1191, file: !2, line: 136, column: 1)
!1191 = distinct !DILexicalBlock(scope: !1163, file: !2, line: 136, column: 1)
!1192 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1193, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1196)
!1193 = !DISubroutineType(types: !1194)
!1194 = !{!211, !240, !1195, !211}
!1195 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !258, size: 64)
!1196 = !{!1197, !1198, !1199, !1200, !1201, !1202, !1203}
!1197 = !DILocalVariable(name: "s", arg: 1, scope: !1192, file: !2, line: 137, type: !240)
!1198 = !DILocalVariable(name: "arr", arg: 2, scope: !1192, file: !2, line: 137, type: !1195)
!1199 = !DILocalVariable(name: "n", arg: 3, scope: !1192, file: !2, line: 137, type: !211)
!1200 = !DILocalVariable(name: "line", scope: !1192, file: !2, line: 137, type: !240)
!1201 = !DILocalVariable(name: "endptr", scope: !1192, file: !2, line: 137, type: !240)
!1202 = !DILocalVariable(name: "i", scope: !1192, file: !2, line: 137, type: !211)
!1203 = !DILocalVariable(name: "v", scope: !1192, file: !2, line: 137, type: !258)
!1204 = distinct !DIAssignID()
!1205 = !DILocation(line: 0, scope: !1192)
!1206 = !DILocation(line: 137, column: 1, scope: !1192)
!1207 = !DILocation(line: 137, column: 1, scope: !1208)
!1208 = distinct !DILexicalBlock(scope: !1209, file: !2, line: 137, column: 1)
!1209 = distinct !DILexicalBlock(scope: !1192, file: !2, line: 137, column: 1)
!1210 = !DILocation(line: 137, column: 1, scope: !1211)
!1211 = distinct !DILexicalBlock(scope: !1192, file: !2, line: 137, column: 1)
!1212 = distinct !DIAssignID()
!1213 = !DILocation(line: 137, column: 1, scope: !1214)
!1214 = distinct !DILexicalBlock(scope: !1211, file: !2, line: 137, column: 1)
!1215 = !DILocation(line: 137, column: 1, scope: !1216)
!1216 = distinct !DILexicalBlock(scope: !1214, file: !2, line: 137, column: 1)
!1217 = distinct !{!1217, !1206, !1206, !409, !410}
!1218 = !DILocation(line: 137, column: 1, scope: !1219)
!1219 = distinct !DILexicalBlock(scope: !1220, file: !2, line: 137, column: 1)
!1220 = distinct !DILexicalBlock(scope: !1192, file: !2, line: 137, column: 1)
!1221 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1222, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1224)
!1222 = !DISubroutineType(types: !1223)
!1223 = !{!211, !240, !336, !211}
!1224 = !{!1225, !1226, !1227, !1228, !1229, !1230, !1231}
!1225 = !DILocalVariable(name: "s", arg: 1, scope: !1221, file: !2, line: 138, type: !240)
!1226 = !DILocalVariable(name: "arr", arg: 2, scope: !1221, file: !2, line: 138, type: !336)
!1227 = !DILocalVariable(name: "n", arg: 3, scope: !1221, file: !2, line: 138, type: !211)
!1228 = !DILocalVariable(name: "line", scope: !1221, file: !2, line: 138, type: !240)
!1229 = !DILocalVariable(name: "endptr", scope: !1221, file: !2, line: 138, type: !240)
!1230 = !DILocalVariable(name: "i", scope: !1221, file: !2, line: 138, type: !211)
!1231 = !DILocalVariable(name: "v", scope: !1221, file: !2, line: 138, type: !207)
!1232 = distinct !DIAssignID()
!1233 = !DILocation(line: 0, scope: !1221)
!1234 = !DILocation(line: 138, column: 1, scope: !1221)
!1235 = !DILocation(line: 138, column: 1, scope: !1236)
!1236 = distinct !DILexicalBlock(scope: !1237, file: !2, line: 138, column: 1)
!1237 = distinct !DILexicalBlock(scope: !1221, file: !2, line: 138, column: 1)
!1238 = !DILocation(line: 138, column: 1, scope: !1239)
!1239 = distinct !DILexicalBlock(scope: !1221, file: !2, line: 138, column: 1)
!1240 = distinct !DIAssignID()
!1241 = !DILocation(line: 138, column: 1, scope: !1242)
!1242 = distinct !DILexicalBlock(scope: !1239, file: !2, line: 138, column: 1)
!1243 = !DILocation(line: 138, column: 1, scope: !1244)
!1244 = distinct !DILexicalBlock(scope: !1242, file: !2, line: 138, column: 1)
!1245 = distinct !{!1245, !1234, !1234, !409, !410}
!1246 = !DILocation(line: 138, column: 1, scope: !1247)
!1247 = distinct !DILexicalBlock(scope: !1248, file: !2, line: 138, column: 1)
!1248 = distinct !DILexicalBlock(scope: !1221, file: !2, line: 138, column: 1)
!1249 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1250, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1253)
!1250 = !DISubroutineType(types: !1251)
!1251 = !{!211, !240, !1252, !211}
!1252 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !261, size: 64)
!1253 = !{!1254, !1255, !1256, !1257, !1258, !1259, !1260}
!1254 = !DILocalVariable(name: "s", arg: 1, scope: !1249, file: !2, line: 139, type: !240)
!1255 = !DILocalVariable(name: "arr", arg: 2, scope: !1249, file: !2, line: 139, type: !1252)
!1256 = !DILocalVariable(name: "n", arg: 3, scope: !1249, file: !2, line: 139, type: !211)
!1257 = !DILocalVariable(name: "line", scope: !1249, file: !2, line: 139, type: !240)
!1258 = !DILocalVariable(name: "endptr", scope: !1249, file: !2, line: 139, type: !240)
!1259 = !DILocalVariable(name: "i", scope: !1249, file: !2, line: 139, type: !211)
!1260 = !DILocalVariable(name: "v", scope: !1249, file: !2, line: 139, type: !261)
!1261 = distinct !DIAssignID()
!1262 = !DILocation(line: 0, scope: !1249)
!1263 = !DILocation(line: 139, column: 1, scope: !1249)
!1264 = !DILocation(line: 139, column: 1, scope: !1265)
!1265 = distinct !DILexicalBlock(scope: !1266, file: !2, line: 139, column: 1)
!1266 = distinct !DILexicalBlock(scope: !1249, file: !2, line: 139, column: 1)
!1267 = !DILocation(line: 139, column: 1, scope: !1268)
!1268 = distinct !DILexicalBlock(scope: !1249, file: !2, line: 139, column: 1)
!1269 = distinct !DIAssignID()
!1270 = !DILocation(line: 139, column: 1, scope: !1271)
!1271 = distinct !DILexicalBlock(scope: !1268, file: !2, line: 139, column: 1)
!1272 = !DILocation(line: 139, column: 1, scope: !1273)
!1273 = distinct !DILexicalBlock(scope: !1271, file: !2, line: 139, column: 1)
!1274 = distinct !{!1274, !1263, !1263, !409, !410}
!1275 = !DILocation(line: 139, column: 1, scope: !1276)
!1276 = distinct !DILexicalBlock(scope: !1277, file: !2, line: 139, column: 1)
!1277 = distinct !DILexicalBlock(scope: !1249, file: !2, line: 139, column: 1)
!1278 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1279, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1282)
!1279 = !DISubroutineType(types: !1280)
!1280 = !{!211, !240, !1281, !211}
!1281 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !264, size: 64)
!1282 = !{!1283, !1284, !1285, !1286, !1287, !1288, !1289}
!1283 = !DILocalVariable(name: "s", arg: 1, scope: !1278, file: !2, line: 141, type: !240)
!1284 = !DILocalVariable(name: "arr", arg: 2, scope: !1278, file: !2, line: 141, type: !1281)
!1285 = !DILocalVariable(name: "n", arg: 3, scope: !1278, file: !2, line: 141, type: !211)
!1286 = !DILocalVariable(name: "line", scope: !1278, file: !2, line: 141, type: !240)
!1287 = !DILocalVariable(name: "endptr", scope: !1278, file: !2, line: 141, type: !240)
!1288 = !DILocalVariable(name: "i", scope: !1278, file: !2, line: 141, type: !211)
!1289 = !DILocalVariable(name: "v", scope: !1278, file: !2, line: 141, type: !264)
!1290 = distinct !DIAssignID()
!1291 = !DILocation(line: 0, scope: !1278)
!1292 = !DILocation(line: 141, column: 1, scope: !1278)
!1293 = !DILocation(line: 141, column: 1, scope: !1294)
!1294 = distinct !DILexicalBlock(scope: !1295, file: !2, line: 141, column: 1)
!1295 = distinct !DILexicalBlock(scope: !1278, file: !2, line: 141, column: 1)
!1296 = !DILocation(line: 141, column: 1, scope: !1297)
!1297 = distinct !DILexicalBlock(scope: !1278, file: !2, line: 141, column: 1)
!1298 = distinct !DIAssignID()
!1299 = !DILocation(line: 141, column: 1, scope: !1300)
!1300 = distinct !DILexicalBlock(scope: !1297, file: !2, line: 141, column: 1)
!1301 = !DILocation(line: 141, column: 1, scope: !1302)
!1302 = distinct !DILexicalBlock(scope: !1300, file: !2, line: 141, column: 1)
!1303 = !{!1304, !1304, i64 0}
!1304 = !{!"float", !383, i64 0}
!1305 = distinct !{!1305, !1292, !1292, !409, !410}
!1306 = !DILocation(line: 141, column: 1, scope: !1307)
!1307 = distinct !DILexicalBlock(scope: !1308, file: !2, line: 141, column: 1)
!1308 = distinct !DILexicalBlock(scope: !1278, file: !2, line: 141, column: 1)
!1309 = !DISubprogram(name: "strtof", scope: !584, file: !584, line: 124, type: !1310, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1310 = !DISubroutineType(types: !1311)
!1311 = !{!264, !1008, !1012}
!1312 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1313, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1315)
!1313 = !DISubroutineType(types: !1314)
!1314 = !{!211, !240, !335, !211}
!1315 = !{!1316, !1317, !1318, !1319, !1320, !1321, !1322}
!1316 = !DILocalVariable(name: "s", arg: 1, scope: !1312, file: !2, line: 142, type: !240)
!1317 = !DILocalVariable(name: "arr", arg: 2, scope: !1312, file: !2, line: 142, type: !335)
!1318 = !DILocalVariable(name: "n", arg: 3, scope: !1312, file: !2, line: 142, type: !211)
!1319 = !DILocalVariable(name: "line", scope: !1312, file: !2, line: 142, type: !240)
!1320 = !DILocalVariable(name: "endptr", scope: !1312, file: !2, line: 142, type: !240)
!1321 = !DILocalVariable(name: "i", scope: !1312, file: !2, line: 142, type: !211)
!1322 = !DILocalVariable(name: "v", scope: !1312, file: !2, line: 142, type: !197)
!1323 = distinct !DIAssignID()
!1324 = !DILocation(line: 0, scope: !1312)
!1325 = !DILocation(line: 142, column: 1, scope: !1312)
!1326 = !DILocation(line: 142, column: 1, scope: !1327)
!1327 = distinct !DILexicalBlock(scope: !1328, file: !2, line: 142, column: 1)
!1328 = distinct !DILexicalBlock(scope: !1312, file: !2, line: 142, column: 1)
!1329 = !DILocation(line: 142, column: 1, scope: !1330)
!1330 = distinct !DILexicalBlock(scope: !1312, file: !2, line: 142, column: 1)
!1331 = distinct !DIAssignID()
!1332 = !DILocation(line: 142, column: 1, scope: !1333)
!1333 = distinct !DILexicalBlock(scope: !1330, file: !2, line: 142, column: 1)
!1334 = !DILocation(line: 142, column: 1, scope: !1335)
!1335 = distinct !DILexicalBlock(scope: !1333, file: !2, line: 142, column: 1)
!1336 = distinct !{!1336, !1325, !1325, !409, !410}
!1337 = !DILocation(line: 142, column: 1, scope: !1338)
!1338 = distinct !DILexicalBlock(scope: !1339, file: !2, line: 142, column: 1)
!1339 = distinct !DILexicalBlock(scope: !1312, file: !2, line: 142, column: 1)
!1340 = !DISubprogram(name: "strtod", scope: !584, file: !584, line: 118, type: !1341, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1341 = !DISubroutineType(types: !1342)
!1342 = !{!197, !1008, !1012}
!1343 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1344, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1346)
!1344 = !DISubroutineType(types: !1345)
!1345 = !{!211, !211, !240, !211}
!1346 = !{!1347, !1348, !1349, !1350, !1351}
!1347 = !DILocalVariable(name: "fd", arg: 1, scope: !1343, file: !2, line: 145, type: !211)
!1348 = !DILocalVariable(name: "arr", arg: 2, scope: !1343, file: !2, line: 145, type: !240)
!1349 = !DILocalVariable(name: "n", arg: 3, scope: !1343, file: !2, line: 145, type: !211)
!1350 = !DILocalVariable(name: "status", scope: !1343, file: !2, line: 146, type: !211)
!1351 = !DILocalVariable(name: "written", scope: !1343, file: !2, line: 146, type: !211)
!1352 = !DILocation(line: 0, scope: !1343)
!1353 = !DILocation(line: 147, column: 3, scope: !1354)
!1354 = distinct !DILexicalBlock(scope: !1355, file: !2, line: 147, column: 3)
!1355 = distinct !DILexicalBlock(scope: !1343, file: !2, line: 147, column: 3)
!1356 = !DILocation(line: 148, column: 8, scope: !1357)
!1357 = distinct !DILexicalBlock(scope: !1343, file: !2, line: 148, column: 7)
!1358 = !DILocation(line: 148, column: 7, scope: !1343)
!1359 = !DILocation(line: 149, column: 9, scope: !1360)
!1360 = distinct !DILexicalBlock(scope: !1357, file: !2, line: 148, column: 13)
!1361 = !DILocation(line: 150, column: 3, scope: !1360)
!1362 = !DILocation(line: 152, column: 16, scope: !1343)
!1363 = !DILocation(line: 152, column: 3, scope: !1343)
!1364 = !DILocation(line: 158, column: 3, scope: !1343)
!1365 = !DILocation(line: 155, column: 13, scope: !1366)
!1366 = distinct !DILexicalBlock(scope: !1343, file: !2, line: 152, column: 20)
!1367 = distinct !{!1367, !1363, !1368, !409, !410}
!1368 = !DILocation(line: 156, column: 3, scope: !1343)
!1369 = !DILocation(line: 153, column: 25, scope: !1366)
!1370 = !DILocation(line: 153, column: 40, scope: !1366)
!1371 = !DILocation(line: 153, column: 39, scope: !1366)
!1372 = !DILocation(line: 153, column: 14, scope: !1366)
!1373 = !DILocation(line: 154, column: 5, scope: !1374)
!1374 = distinct !DILexicalBlock(scope: !1375, file: !2, line: 154, column: 5)
!1375 = distinct !DILexicalBlock(scope: !1366, file: !2, line: 154, column: 5)
!1376 = !DILocation(line: 159, column: 14, scope: !1377)
!1377 = distinct !DILexicalBlock(scope: !1343, file: !2, line: 158, column: 6)
!1378 = !DILocation(line: 160, column: 5, scope: !1379)
!1379 = distinct !DILexicalBlock(scope: !1380, file: !2, line: 160, column: 5)
!1380 = distinct !DILexicalBlock(scope: !1377, file: !2, line: 160, column: 5)
!1381 = !DILocation(line: 161, column: 17, scope: !1343)
!1382 = !DILocation(line: 161, column: 3, scope: !1377)
!1383 = distinct !{!1383, !1364, !1384, !409, !410}
!1384 = !DILocation(line: 161, column: 20, scope: !1343)
!1385 = !DILocation(line: 163, column: 3, scope: !1343)
!1386 = !DISubprogram(name: "write", scope: !906, file: !906, line: 378, type: !1387, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1387 = !DISubroutineType(types: !1388)
!1388 = !{!855, !211, !1389, !903}
!1389 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1390, size: 64)
!1390 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1391 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1392, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1394)
!1392 = !DISubroutineType(types: !1393)
!1393 = !{!211, !211, !975, !211}
!1394 = !{!1395, !1396, !1397, !1398}
!1395 = !DILocalVariable(name: "fd", arg: 1, scope: !1391, file: !2, line: 177, type: !211)
!1396 = !DILocalVariable(name: "arr", arg: 2, scope: !1391, file: !2, line: 177, type: !975)
!1397 = !DILocalVariable(name: "n", arg: 3, scope: !1391, file: !2, line: 177, type: !211)
!1398 = !DILocalVariable(name: "i", scope: !1391, file: !2, line: 177, type: !211)
!1399 = !DILocation(line: 0, scope: !1391)
!1400 = !DILocation(line: 177, column: 1, scope: !1401)
!1401 = distinct !DILexicalBlock(scope: !1402, file: !2, line: 177, column: 1)
!1402 = distinct !DILexicalBlock(scope: !1391, file: !2, line: 177, column: 1)
!1403 = !DILocation(line: 177, column: 1, scope: !1404)
!1404 = distinct !DILexicalBlock(scope: !1405, file: !2, line: 177, column: 1)
!1405 = distinct !DILexicalBlock(scope: !1391, file: !2, line: 177, column: 1)
!1406 = !DILocation(line: 177, column: 1, scope: !1405)
!1407 = !DILocation(line: 177, column: 1, scope: !1408)
!1408 = distinct !DILexicalBlock(scope: !1404, file: !2, line: 177, column: 1)
!1409 = distinct !{!1409, !1406, !1406, !409, !410}
!1410 = !DILocation(line: 177, column: 1, scope: !1391)
!1411 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1412, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1414)
!1412 = !DISubroutineType(cc: DW_CC_nocall, types: !1413)
!1413 = !{!211, !211, !894, null}
!1414 = !{!1415, !1416, !1417, !1421, !1422, !1423, !1424}
!1415 = !DILocalVariable(name: "fd", arg: 1, scope: !1411, file: !2, line: 15, type: !211)
!1416 = !DILocalVariable(name: "format", arg: 2, scope: !1411, file: !2, line: 15, type: !894)
!1417 = !DILocalVariable(name: "args", scope: !1411, file: !2, line: 16, type: !1418)
!1418 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1419, line: 12, baseType: !1420)
!1419 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1420 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !241)
!1421 = !DILocalVariable(name: "buffered", scope: !1411, file: !2, line: 17, type: !211)
!1422 = !DILocalVariable(name: "written", scope: !1411, file: !2, line: 17, type: !211)
!1423 = !DILocalVariable(name: "status", scope: !1411, file: !2, line: 17, type: !211)
!1424 = !DILocalVariable(name: "buffer", scope: !1411, file: !2, line: 18, type: !1425)
!1425 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !198)
!1426 = distinct !DIAssignID()
!1427 = !DILocation(line: 0, scope: !1411)
!1428 = distinct !DIAssignID()
!1429 = !DILocation(line: 16, column: 3, scope: !1411)
!1430 = !DILocation(line: 18, column: 3, scope: !1411)
!1431 = !DILocation(line: 19, column: 3, scope: !1411)
!1432 = !DILocation(line: 20, column: 66, scope: !1411)
!1433 = !DILocation(line: 20, column: 14, scope: !1411)
!1434 = !DILocation(line: 21, column: 3, scope: !1411)
!1435 = !DILocation(line: 22, column: 3, scope: !1436)
!1436 = distinct !DILexicalBlock(scope: !1437, file: !2, line: 22, column: 3)
!1437 = distinct !DILexicalBlock(scope: !1411, file: !2, line: 22, column: 3)
!1438 = !DILocation(line: 24, column: 16, scope: !1411)
!1439 = !DILocation(line: 24, column: 3, scope: !1411)
!1440 = !DILocation(line: 27, column: 13, scope: !1441)
!1441 = distinct !DILexicalBlock(scope: !1411, file: !2, line: 24, column: 27)
!1442 = distinct !{!1442, !1439, !1443, !409, !410}
!1443 = !DILocation(line: 28, column: 3, scope: !1411)
!1444 = !DILocation(line: 25, column: 25, scope: !1441)
!1445 = !DILocation(line: 25, column: 50, scope: !1441)
!1446 = !DILocation(line: 25, column: 42, scope: !1441)
!1447 = !DILocation(line: 25, column: 14, scope: !1441)
!1448 = !DILocation(line: 26, column: 5, scope: !1449)
!1449 = distinct !DILexicalBlock(scope: !1450, file: !2, line: 26, column: 5)
!1450 = distinct !DILexicalBlock(scope: !1441, file: !2, line: 26, column: 5)
!1451 = !DILocation(line: 29, column: 3, scope: !1452)
!1452 = distinct !DILexicalBlock(scope: !1453, file: !2, line: 29, column: 3)
!1453 = distinct !DILexicalBlock(scope: !1411, file: !2, line: 29, column: 3)
!1454 = !DILocation(line: 31, column: 1, scope: !1411)
!1455 = !DILocation(line: 30, column: 3, scope: !1411)
!1456 = !DISubprogram(name: "vsnprintf", scope: !1015, file: !1015, line: 389, type: !1457, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1457 = !DISubroutineType(types: !1458)
!1458 = !{!211, !1007, !903, !1008, !1459}
!1459 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1460, line: 12, baseType: !1420)
!1460 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1461 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1462, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1464)
!1462 = !DISubroutineType(types: !1463)
!1463 = !{!211, !211, !1075, !211}
!1464 = !{!1465, !1466, !1467, !1468}
!1465 = !DILocalVariable(name: "fd", arg: 1, scope: !1461, file: !2, line: 178, type: !211)
!1466 = !DILocalVariable(name: "arr", arg: 2, scope: !1461, file: !2, line: 178, type: !1075)
!1467 = !DILocalVariable(name: "n", arg: 3, scope: !1461, file: !2, line: 178, type: !211)
!1468 = !DILocalVariable(name: "i", scope: !1461, file: !2, line: 178, type: !211)
!1469 = !DILocation(line: 0, scope: !1461)
!1470 = !DILocation(line: 178, column: 1, scope: !1471)
!1471 = distinct !DILexicalBlock(scope: !1472, file: !2, line: 178, column: 1)
!1472 = distinct !DILexicalBlock(scope: !1461, file: !2, line: 178, column: 1)
!1473 = !DILocation(line: 178, column: 1, scope: !1474)
!1474 = distinct !DILexicalBlock(scope: !1475, file: !2, line: 178, column: 1)
!1475 = distinct !DILexicalBlock(scope: !1461, file: !2, line: 178, column: 1)
!1476 = !DILocation(line: 178, column: 1, scope: !1475)
!1477 = !DILocation(line: 178, column: 1, scope: !1478)
!1478 = distinct !DILexicalBlock(scope: !1474, file: !2, line: 178, column: 1)
!1479 = distinct !{!1479, !1476, !1476, !409, !410}
!1480 = !DILocation(line: 178, column: 1, scope: !1461)
!1481 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1482, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1484)
!1482 = !DISubroutineType(types: !1483)
!1483 = !{!211, !211, !1106, !211}
!1484 = !{!1485, !1486, !1487, !1488}
!1485 = !DILocalVariable(name: "fd", arg: 1, scope: !1481, file: !2, line: 179, type: !211)
!1486 = !DILocalVariable(name: "arr", arg: 2, scope: !1481, file: !2, line: 179, type: !1106)
!1487 = !DILocalVariable(name: "n", arg: 3, scope: !1481, file: !2, line: 179, type: !211)
!1488 = !DILocalVariable(name: "i", scope: !1481, file: !2, line: 179, type: !211)
!1489 = !DILocation(line: 0, scope: !1481)
!1490 = !DILocation(line: 179, column: 1, scope: !1491)
!1491 = distinct !DILexicalBlock(scope: !1492, file: !2, line: 179, column: 1)
!1492 = distinct !DILexicalBlock(scope: !1481, file: !2, line: 179, column: 1)
!1493 = !DILocation(line: 179, column: 1, scope: !1494)
!1494 = distinct !DILexicalBlock(scope: !1495, file: !2, line: 179, column: 1)
!1495 = distinct !DILexicalBlock(scope: !1481, file: !2, line: 179, column: 1)
!1496 = !DILocation(line: 179, column: 1, scope: !1495)
!1497 = !DILocation(line: 179, column: 1, scope: !1498)
!1498 = distinct !DILexicalBlock(scope: !1494, file: !2, line: 179, column: 1)
!1499 = distinct !{!1499, !1496, !1496, !409, !410}
!1500 = !DILocation(line: 179, column: 1, scope: !1481)
!1501 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1502, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1504)
!1502 = !DISubroutineType(types: !1503)
!1503 = !{!211, !211, !1135, !211}
!1504 = !{!1505, !1506, !1507, !1508}
!1505 = !DILocalVariable(name: "fd", arg: 1, scope: !1501, file: !2, line: 180, type: !211)
!1506 = !DILocalVariable(name: "arr", arg: 2, scope: !1501, file: !2, line: 180, type: !1135)
!1507 = !DILocalVariable(name: "n", arg: 3, scope: !1501, file: !2, line: 180, type: !211)
!1508 = !DILocalVariable(name: "i", scope: !1501, file: !2, line: 180, type: !211)
!1509 = !DILocation(line: 0, scope: !1501)
!1510 = !DILocation(line: 180, column: 1, scope: !1511)
!1511 = distinct !DILexicalBlock(scope: !1512, file: !2, line: 180, column: 1)
!1512 = distinct !DILexicalBlock(scope: !1501, file: !2, line: 180, column: 1)
!1513 = !DILocation(line: 180, column: 1, scope: !1514)
!1514 = distinct !DILexicalBlock(scope: !1515, file: !2, line: 180, column: 1)
!1515 = distinct !DILexicalBlock(scope: !1501, file: !2, line: 180, column: 1)
!1516 = !DILocation(line: 180, column: 1, scope: !1515)
!1517 = !DILocation(line: 180, column: 1, scope: !1518)
!1518 = distinct !DILexicalBlock(scope: !1514, file: !2, line: 180, column: 1)
!1519 = distinct !{!1519, !1516, !1516, !409, !410}
!1520 = !DILocation(line: 180, column: 1, scope: !1501)
!1521 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1522, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1524)
!1522 = !DISubroutineType(types: !1523)
!1523 = !{!211, !211, !1166, !211}
!1524 = !{!1525, !1526, !1527, !1528}
!1525 = !DILocalVariable(name: "fd", arg: 1, scope: !1521, file: !2, line: 181, type: !211)
!1526 = !DILocalVariable(name: "arr", arg: 2, scope: !1521, file: !2, line: 181, type: !1166)
!1527 = !DILocalVariable(name: "n", arg: 3, scope: !1521, file: !2, line: 181, type: !211)
!1528 = !DILocalVariable(name: "i", scope: !1521, file: !2, line: 181, type: !211)
!1529 = !DILocation(line: 0, scope: !1521)
!1530 = !DILocation(line: 181, column: 1, scope: !1531)
!1531 = distinct !DILexicalBlock(scope: !1532, file: !2, line: 181, column: 1)
!1532 = distinct !DILexicalBlock(scope: !1521, file: !2, line: 181, column: 1)
!1533 = !DILocation(line: 181, column: 1, scope: !1534)
!1534 = distinct !DILexicalBlock(scope: !1535, file: !2, line: 181, column: 1)
!1535 = distinct !DILexicalBlock(scope: !1521, file: !2, line: 181, column: 1)
!1536 = !DILocation(line: 181, column: 1, scope: !1535)
!1537 = !DILocation(line: 181, column: 1, scope: !1538)
!1538 = distinct !DILexicalBlock(scope: !1534, file: !2, line: 181, column: 1)
!1539 = distinct !{!1539, !1536, !1536, !409, !410}
!1540 = !DILocation(line: 181, column: 1, scope: !1521)
!1541 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1542, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1544)
!1542 = !DISubroutineType(types: !1543)
!1543 = !{!211, !211, !1195, !211}
!1544 = !{!1545, !1546, !1547, !1548}
!1545 = !DILocalVariable(name: "fd", arg: 1, scope: !1541, file: !2, line: 182, type: !211)
!1546 = !DILocalVariable(name: "arr", arg: 2, scope: !1541, file: !2, line: 182, type: !1195)
!1547 = !DILocalVariable(name: "n", arg: 3, scope: !1541, file: !2, line: 182, type: !211)
!1548 = !DILocalVariable(name: "i", scope: !1541, file: !2, line: 182, type: !211)
!1549 = !DILocation(line: 0, scope: !1541)
!1550 = !DILocation(line: 182, column: 1, scope: !1551)
!1551 = distinct !DILexicalBlock(scope: !1552, file: !2, line: 182, column: 1)
!1552 = distinct !DILexicalBlock(scope: !1541, file: !2, line: 182, column: 1)
!1553 = !DILocation(line: 182, column: 1, scope: !1554)
!1554 = distinct !DILexicalBlock(scope: !1555, file: !2, line: 182, column: 1)
!1555 = distinct !DILexicalBlock(scope: !1541, file: !2, line: 182, column: 1)
!1556 = !DILocation(line: 182, column: 1, scope: !1555)
!1557 = !DILocation(line: 182, column: 1, scope: !1558)
!1558 = distinct !DILexicalBlock(scope: !1554, file: !2, line: 182, column: 1)
!1559 = distinct !{!1559, !1556, !1556, !409, !410}
!1560 = !DILocation(line: 182, column: 1, scope: !1541)
!1561 = !DILocation(line: 0, scope: !645)
!1562 = !DILocation(line: 183, column: 1, scope: !1563)
!1563 = distinct !DILexicalBlock(scope: !1564, file: !2, line: 183, column: 1)
!1564 = distinct !DILexicalBlock(scope: !645, file: !2, line: 183, column: 1)
!1565 = !DILocation(line: 183, column: 1, scope: !658)
!1566 = !DILocation(line: 183, column: 1, scope: !655)
!1567 = !DILocation(line: 183, column: 1, scope: !657)
!1568 = distinct !{!1568, !1566, !1566, !409, !410}
!1569 = !DILocation(line: 183, column: 1, scope: !645)
!1570 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1571, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1573)
!1571 = !DISubroutineType(types: !1572)
!1572 = !{!211, !211, !1252, !211}
!1573 = !{!1574, !1575, !1576, !1577}
!1574 = !DILocalVariable(name: "fd", arg: 1, scope: !1570, file: !2, line: 184, type: !211)
!1575 = !DILocalVariable(name: "arr", arg: 2, scope: !1570, file: !2, line: 184, type: !1252)
!1576 = !DILocalVariable(name: "n", arg: 3, scope: !1570, file: !2, line: 184, type: !211)
!1577 = !DILocalVariable(name: "i", scope: !1570, file: !2, line: 184, type: !211)
!1578 = !DILocation(line: 0, scope: !1570)
!1579 = !DILocation(line: 184, column: 1, scope: !1580)
!1580 = distinct !DILexicalBlock(scope: !1581, file: !2, line: 184, column: 1)
!1581 = distinct !DILexicalBlock(scope: !1570, file: !2, line: 184, column: 1)
!1582 = !DILocation(line: 184, column: 1, scope: !1583)
!1583 = distinct !DILexicalBlock(scope: !1584, file: !2, line: 184, column: 1)
!1584 = distinct !DILexicalBlock(scope: !1570, file: !2, line: 184, column: 1)
!1585 = !DILocation(line: 184, column: 1, scope: !1584)
!1586 = !DILocation(line: 184, column: 1, scope: !1587)
!1587 = distinct !DILexicalBlock(scope: !1583, file: !2, line: 184, column: 1)
!1588 = distinct !{!1588, !1585, !1585, !409, !410}
!1589 = !DILocation(line: 184, column: 1, scope: !1570)
!1590 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1591, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !1593)
!1591 = !DISubroutineType(types: !1592)
!1592 = !{!211, !211, !1281, !211}
!1593 = !{!1594, !1595, !1596, !1597}
!1594 = !DILocalVariable(name: "fd", arg: 1, scope: !1590, file: !2, line: 186, type: !211)
!1595 = !DILocalVariable(name: "arr", arg: 2, scope: !1590, file: !2, line: 186, type: !1281)
!1596 = !DILocalVariable(name: "n", arg: 3, scope: !1590, file: !2, line: 186, type: !211)
!1597 = !DILocalVariable(name: "i", scope: !1590, file: !2, line: 186, type: !211)
!1598 = !DILocation(line: 0, scope: !1590)
!1599 = !DILocation(line: 186, column: 1, scope: !1600)
!1600 = distinct !DILexicalBlock(scope: !1601, file: !2, line: 186, column: 1)
!1601 = distinct !DILexicalBlock(scope: !1590, file: !2, line: 186, column: 1)
!1602 = !DILocation(line: 186, column: 1, scope: !1603)
!1603 = distinct !DILexicalBlock(scope: !1604, file: !2, line: 186, column: 1)
!1604 = distinct !DILexicalBlock(scope: !1590, file: !2, line: 186, column: 1)
!1605 = !DILocation(line: 186, column: 1, scope: !1604)
!1606 = !DILocation(line: 186, column: 1, scope: !1607)
!1607 = distinct !DILexicalBlock(scope: !1603, file: !2, line: 186, column: 1)
!1608 = distinct !{!1608, !1605, !1605, !409, !410}
!1609 = !DILocation(line: 186, column: 1, scope: !1590)
!1610 = !DILocation(line: 0, scope: !604)
!1611 = !DILocation(line: 187, column: 1, scope: !1612)
!1612 = distinct !DILexicalBlock(scope: !1613, file: !2, line: 187, column: 1)
!1613 = distinct !DILexicalBlock(scope: !604, file: !2, line: 187, column: 1)
!1614 = !DILocation(line: 187, column: 1, scope: !617)
!1615 = !DILocation(line: 187, column: 1, scope: !614)
!1616 = !DILocation(line: 187, column: 1, scope: !616)
!1617 = distinct !{!1617, !1615, !1615, !409, !410}
!1618 = !DILocation(line: 187, column: 1, scope: !604)
!1619 = !DILocation(line: 0, scope: !592)
!1620 = !DILocation(line: 190, column: 3, scope: !599)
!1621 = !DILocation(line: 191, column: 3, scope: !592)
!1622 = !DILocation(line: 192, column: 3, scope: !592)
!1623 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1624, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !299, retainedNodes: !1626)
!1624 = !DISubroutineType(types: !1625)
!1625 = !{!211, !211, !1013}
!1626 = !{!1627, !1628, !1629, !1630, !1631, !1632, !1633, !1634, !1635}
!1627 = !DILocalVariable(name: "argc", arg: 1, scope: !1623, file: !170, line: 14, type: !211)
!1628 = !DILocalVariable(name: "argv", arg: 2, scope: !1623, file: !170, line: 14, type: !1013)
!1629 = !DILocalVariable(name: "in_file", scope: !1623, file: !170, line: 17, type: !240)
!1630 = !DILocalVariable(name: "check_file", scope: !1623, file: !170, line: 19, type: !240)
!1631 = !DILocalVariable(name: "in_fd", scope: !1623, file: !170, line: 34, type: !211)
!1632 = !DILocalVariable(name: "data", scope: !1623, file: !170, line: 35, type: !240)
!1633 = !DILocalVariable(name: "out_fd", scope: !1623, file: !170, line: 46, type: !211)
!1634 = !DILocalVariable(name: "check_fd", scope: !1623, file: !170, line: 55, type: !211)
!1635 = !DILocalVariable(name: "ref", scope: !1623, file: !170, line: 56, type: !240)
!1636 = !DILocation(line: 0, scope: !1623)
!1637 = !DILocation(line: 21, column: 3, scope: !1638)
!1638 = distinct !DILexicalBlock(scope: !1639, file: !170, line: 21, column: 3)
!1639 = distinct !DILexicalBlock(scope: !1623, file: !170, line: 21, column: 3)
!1640 = !DILocation(line: 26, column: 11, scope: !1641)
!1641 = distinct !DILexicalBlock(scope: !1623, file: !170, line: 26, column: 7)
!1642 = !DILocation(line: 26, column: 7, scope: !1623)
!1643 = !DILocation(line: 27, column: 15, scope: !1641)
!1644 = !DILocation(line: 29, column: 11, scope: !1645)
!1645 = distinct !DILexicalBlock(scope: !1623, file: !170, line: 29, column: 7)
!1646 = !DILocation(line: 29, column: 7, scope: !1623)
!1647 = !DILocation(line: 30, column: 18, scope: !1645)
!1648 = !DILocation(line: 30, column: 5, scope: !1645)
!1649 = !DILocation(line: 36, column: 17, scope: !1623)
!1650 = !DILocation(line: 36, column: 10, scope: !1623)
!1651 = !DILocation(line: 37, column: 3, scope: !1652)
!1652 = distinct !DILexicalBlock(scope: !1653, file: !170, line: 37, column: 3)
!1653 = distinct !DILexicalBlock(scope: !1623, file: !170, line: 37, column: 3)
!1654 = !DILocation(line: 38, column: 11, scope: !1623)
!1655 = !DILocation(line: 39, column: 3, scope: !1656)
!1656 = distinct !DILexicalBlock(scope: !1657, file: !170, line: 39, column: 3)
!1657 = distinct !DILexicalBlock(scope: !1623, file: !170, line: 39, column: 3)
!1658 = !DILocation(line: 40, column: 3, scope: !1623)
!1659 = !DILocation(line: 0, scope: !422, inlinedAt: !1660)
!1660 = distinct !DILocation(line: 43, column: 3, scope: !1623)
!1661 = !DILocation(line: 10, column: 28, scope: !422, inlinedAt: !1660)
!1662 = !DILocation(line: 10, column: 43, scope: !422, inlinedAt: !1660)
!1663 = !DILocation(line: 11, column: 20, scope: !422, inlinedAt: !1660)
!1664 = !DILocation(line: 11, column: 38, scope: !422, inlinedAt: !1660)
!1665 = !DILocation(line: 11, column: 56, scope: !422, inlinedAt: !1660)
!1666 = !DILocation(line: 12, column: 20, scope: !422, inlinedAt: !1660)
!1667 = !DILocation(line: 0, scope: !332, inlinedAt: !1668)
!1668 = distinct !DILocation(line: 10, column: 3, scope: !422, inlinedAt: !1660)
!1669 = !DILocation(line: 24, column: 1, scope: !332, inlinedAt: !1668)
!1670 = !DILocation(line: 24, column: 10, scope: !368, inlinedAt: !1668)
!1671 = !DILocation(line: 25, column: 20, scope: !366, inlinedAt: !1668)
!1672 = !DILocation(line: 26, column: 20, scope: !366, inlinedAt: !1668)
!1673 = !DILocation(line: 27, column: 20, scope: !366, inlinedAt: !1668)
!1674 = !DILocation(line: 31, column: 1, scope: !366, inlinedAt: !1668)
!1675 = !DILocation(line: 31, column: 10, scope: !377, inlinedAt: !1668)
!1676 = !DILocation(line: 33, column: 21, scope: !379, inlinedAt: !1668)
!1677 = !DILocation(line: 35, column: 20, scope: !379, inlinedAt: !1668)
!1678 = !DILocation(line: 36, column: 20, scope: !379, inlinedAt: !1668)
!1679 = !DILocation(line: 37, column: 20, scope: !379, inlinedAt: !1668)
!1680 = !DILocation(line: 39, column: 25, scope: !379, inlinedAt: !1668)
!1681 = !DILocation(line: 40, column: 25, scope: !379, inlinedAt: !1668)
!1682 = !DILocation(line: 41, column: 25, scope: !379, inlinedAt: !1668)
!1683 = !DILocation(line: 42, column: 44, scope: !379, inlinedAt: !1668)
!1684 = !DILocation(line: 42, column: 38, scope: !379, inlinedAt: !1668)
!1685 = !DILocation(line: 42, column: 50, scope: !379, inlinedAt: !1668)
!1686 = !DILocation(line: 42, column: 25, scope: !379, inlinedAt: !1668)
!1687 = !DILocation(line: 44, column: 28, scope: !379, inlinedAt: !1668)
!1688 = !DILocation(line: 44, column: 36, scope: !379, inlinedAt: !1668)
!1689 = !DILocation(line: 45, column: 43, scope: !379, inlinedAt: !1668)
!1690 = !DILocation(line: 45, column: 31, scope: !379, inlinedAt: !1668)
!1691 = !DILocation(line: 47, column: 27, scope: !379, inlinedAt: !1668)
!1692 = !DILocation(line: 48, column: 17, scope: !379, inlinedAt: !1668)
!1693 = !DILocation(line: 49, column: 17, scope: !379, inlinedAt: !1668)
!1694 = !DILocation(line: 50, column: 17, scope: !379, inlinedAt: !1668)
!1695 = !DILocation(line: 31, column: 41, scope: !380, inlinedAt: !1668)
!1696 = !DILocation(line: 31, column: 24, scope: !380, inlinedAt: !1668)
!1697 = distinct !{!1697, !1675, !1698, !409, !410}
!1698 = !DILocation(line: 51, column: 10, scope: !377, inlinedAt: !1668)
!1699 = !DILocation(line: 53, column: 10, scope: !366, inlinedAt: !1668)
!1700 = !DILocation(line: 53, column: 21, scope: !366, inlinedAt: !1668)
!1701 = !DILocation(line: 54, column: 10, scope: !366, inlinedAt: !1668)
!1702 = !DILocation(line: 54, column: 21, scope: !366, inlinedAt: !1668)
!1703 = !DILocation(line: 55, column: 10, scope: !366, inlinedAt: !1668)
!1704 = !DILocation(line: 55, column: 21, scope: !366, inlinedAt: !1668)
!1705 = !DILocation(line: 24, column: 35, scope: !367, inlinedAt: !1668)
!1706 = !DILocation(line: 24, column: 24, scope: !367, inlinedAt: !1668)
!1707 = distinct !{!1707, !1670, !1708, !409, !410}
!1708 = !DILocation(line: 57, column: 10, scope: !368, inlinedAt: !1668)
!1709 = !DILocation(line: 47, column: 12, scope: !1623)
!1710 = !DILocation(line: 48, column: 3, scope: !1711)
!1711 = distinct !DILexicalBlock(scope: !1712, file: !170, line: 48, column: 3)
!1712 = distinct !DILexicalBlock(scope: !1623, file: !170, line: 48, column: 3)
!1713 = !DILocation(line: 49, column: 3, scope: !1623)
!1714 = !DILocation(line: 50, column: 3, scope: !1623)
!1715 = !DILocation(line: 57, column: 16, scope: !1623)
!1716 = !DILocation(line: 57, column: 9, scope: !1623)
!1717 = !DILocation(line: 58, column: 3, scope: !1718)
!1718 = distinct !DILexicalBlock(scope: !1719, file: !170, line: 58, column: 3)
!1719 = distinct !DILexicalBlock(scope: !1623, file: !170, line: 58, column: 3)
!1720 = !DILocation(line: 59, column: 14, scope: !1623)
!1721 = !DILocation(line: 60, column: 3, scope: !1722)
!1722 = distinct !DILexicalBlock(scope: !1723, file: !170, line: 60, column: 3)
!1723 = distinct !DILexicalBlock(scope: !1623, file: !170, line: 60, column: 3)
!1724 = !DILocation(line: 61, column: 3, scope: !1623)
!1725 = !DILocation(line: 0, scope: !770, inlinedAt: !1726)
!1726 = distinct !DILocation(line: 66, column: 8, scope: !1727)
!1727 = distinct !DILexicalBlock(scope: !1623, file: !170, line: 66, column: 7)
!1728 = !DILocation(line: 113, column: 3, scope: !785, inlinedAt: !1726)
!1729 = !DILocation(line: 114, column: 14, scope: !787, inlinedAt: !1726)
!1730 = !DILocation(line: 114, column: 33, scope: !787, inlinedAt: !1726)
!1731 = !DILocation(line: 114, column: 31, scope: !787, inlinedAt: !1726)
!1732 = !DILocation(line: 115, column: 14, scope: !787, inlinedAt: !1726)
!1733 = !DILocation(line: 115, column: 33, scope: !787, inlinedAt: !1726)
!1734 = !DILocation(line: 115, column: 31, scope: !787, inlinedAt: !1726)
!1735 = !DILocation(line: 116, column: 14, scope: !787, inlinedAt: !1726)
!1736 = !DILocation(line: 116, column: 33, scope: !787, inlinedAt: !1726)
!1737 = !DILocation(line: 116, column: 31, scope: !787, inlinedAt: !1726)
!1738 = !DILocation(line: 117, column: 37, scope: !787, inlinedAt: !1726)
!1739 = !DILocation(line: 118, column: 37, scope: !787, inlinedAt: !1726)
!1740 = !DILocation(line: 118, column: 16, scope: !787, inlinedAt: !1726)
!1741 = !DILocation(line: 119, column: 37, scope: !787, inlinedAt: !1726)
!1742 = !DILocation(line: 119, column: 16, scope: !787, inlinedAt: !1726)
!1743 = !DILocation(line: 113, column: 24, scope: !788, inlinedAt: !1726)
!1744 = !DILocation(line: 113, column: 14, scope: !788, inlinedAt: !1726)
!1745 = distinct !{!1745, !1728, !1746, !409, !410}
!1746 = !DILocation(line: 120, column: 3, scope: !785, inlinedAt: !1726)
!1747 = !DILocation(line: 123, column: 10, scope: !770, inlinedAt: !1726)
!1748 = !DILocation(line: 66, column: 7, scope: !1623)
!1749 = !DILocation(line: 67, column: 13, scope: !1750)
!1750 = distinct !DILexicalBlock(scope: !1727, file: !170, line: 66, column: 32)
!1751 = !DILocation(line: 67, column: 5, scope: !1750)
!1752 = !DILocation(line: 68, column: 5, scope: !1750)
!1753 = !DILocation(line: 71, column: 3, scope: !1623)
!1754 = !DILocation(line: 72, column: 3, scope: !1623)
!1755 = !DILocation(line: 74, column: 3, scope: !1623)
!1756 = !DILocation(line: 75, column: 3, scope: !1623)
!1757 = !DILocation(line: 76, column: 1, scope: !1623)
!1758 = !DISubprogram(name: "open", scope: !1759, file: !1759, line: 209, type: !1760, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1759 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1760 = !DISubroutineType(types: !1761)
!1761 = !{!211, !894, !211, null}
