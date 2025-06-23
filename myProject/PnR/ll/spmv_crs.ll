; ModuleID = 'spmv/crs/spmv_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.bench_args_t = type { [1666 x double], [1666 x i32], [495 x i32], [494 x double], [494 x double] }
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
@INPUT_SIZE = dso_local local_unnamed_addr global i32 29880, align 4, !dbg !186
@.str.6.18 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !217
@.str.8.19 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !220
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !223
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !228
@.str.12.20 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !231
@.str.14.21 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !233
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !236
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @spmv(ptr nocapture noundef readonly %val, ptr nocapture noundef readonly %cols, ptr nocapture noundef readonly %rowDelimiters, ptr nocapture noundef readonly %vec, ptr nocapture noundef writeonly %out) local_unnamed_addr #0 !dbg !334 {
entry.split:
  %sum.0.lcssa.reg2mem = alloca double, align 8
  %sum.028.reg2mem = alloca double, align 8
  %indvars.iv.reg2mem = alloca i64, align 8
  %indvars.iv31.reg2mem14 = alloca i64, align 8
  %.reg2mem16 = alloca i32, align 4
    #dbg_value(ptr %val, !340, !DIExpression(), !356)
    #dbg_value(ptr %cols, !341, !DIExpression(), !356)
    #dbg_value(ptr %rowDelimiters, !342, !DIExpression(), !356)
    #dbg_value(ptr %vec, !343, !DIExpression(), !356)
    #dbg_value(ptr %out, !344, !DIExpression(), !356)
    #dbg_label(!349, !357)
    #dbg_value(i32 0, !345, !DIExpression(), !356)
  %.pre = load i32, ptr %rowDelimiters, align 4, !dbg !358
  store i64 0, ptr %indvars.iv31.reg2mem14, align 8
  store i32 %.pre, ptr %.reg2mem16, align 4
  br label %for.body, !dbg !359

for.body:                                         ; preds = %for.end.for.body_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv31.reg2mem14.0.load, !345, !DIExpression(), !356)
    #dbg_value(double 0.000000e+00, !347, !DIExpression(), !356)
    #dbg_value(double 0.000000e+00, !348, !DIExpression(), !356)
    #dbg_value(i32 %.reg2mem16.0.load, !350, !DIExpression(), !360)
  %.reg2mem16.0.load = load i32, ptr %.reg2mem16, align 4
  %indvars.iv31.reg2mem14.0.load = load i64, ptr %indvars.iv31.reg2mem14, align 8
  %indvars.iv.next32 = add nuw nsw i64 %indvars.iv31.reg2mem14.0.load, 1, !dbg !361
  %arrayidx2 = getelementptr inbounds i32, ptr %rowDelimiters, i64 %indvars.iv.next32, !dbg !362
  %0 = load i32, ptr %arrayidx2, align 4, !dbg !362
    #dbg_value(i32 %0, !354, !DIExpression(), !360)
    #dbg_label(!355, !363)
    #dbg_value(i32 %.reg2mem16.0.load, !346, !DIExpression(), !356)
  %cmp427 = icmp slt i32 %.reg2mem16.0.load, %0, !dbg !364
  br i1 %cmp427, label %for.body5.preheader, label %for.body.for.end_crit_edge, !dbg !367

for.body.for.end_crit_edge:                       ; preds = %for.body
  store double 0.000000e+00, ptr %sum.0.lcssa.reg2mem, align 8
  br label %for.end, !dbg !367

for.body5.preheader:                              ; preds = %for.body
  %1 = sext i32 %.reg2mem16.0.load to i64, !dbg !367
  %wide.trip.count = sext i32 %0 to i64, !dbg !364
  store double 0.000000e+00, ptr %sum.028.reg2mem, align 8
  store i64 %1, ptr %indvars.iv.reg2mem, align 8
  br label %for.body5, !dbg !367

for.body5:                                        ; preds = %for.body5.for.body5_crit_edge, %for.body5.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !346, !DIExpression(), !356)
    #dbg_value(double %sum.028.reg2mem.0.sum.028.reload, !347, !DIExpression(), !356)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %sum.028.reg2mem.0.sum.028.reload = load double, ptr %sum.028.reg2mem, align 8
  %arrayidx7 = getelementptr inbounds double, ptr %val, i64 %indvars.iv.reg2mem.0.load, !dbg !368
  %2 = load double, ptr %arrayidx7, align 8, !dbg !368, !tbaa !370
  %arrayidx9 = getelementptr inbounds i32, ptr %cols, i64 %indvars.iv.reg2mem.0.load, !dbg !374
  %3 = load i32, ptr %arrayidx9, align 4, !dbg !374, !tbaa !375
  %idxprom10 = sext i32 %3 to i64, !dbg !377
  %arrayidx11 = getelementptr inbounds double, ptr %vec, i64 %idxprom10, !dbg !377
  %4 = load double, ptr %arrayidx11, align 8, !dbg !377, !tbaa !370
  %mul = fmul double %2, %4, !dbg !378
    #dbg_value(double %mul, !348, !DIExpression(), !356)
  %add12 = fadd double %sum.028.reg2mem.0.sum.028.reload, %mul, !dbg !379
    #dbg_value(double %add12, !347, !DIExpression(), !356)
  %indvars.iv.next = add nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !380
    #dbg_value(i64 %indvars.iv.next, !346, !DIExpression(), !356)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !364
  br i1 %exitcond.not, label %for.body5.for.end_crit_edge, label %for.body5.for.body5_crit_edge, !dbg !367, !llvm.loop !381

for.body5.for.body5_crit_edge:                    ; preds = %for.body5
  store double %add12, ptr %sum.028.reg2mem, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body5, !dbg !367

for.body5.for.end_crit_edge:                      ; preds = %for.body5
  store double %add12, ptr %sum.0.lcssa.reg2mem, align 8
  br label %for.end, !dbg !367

for.end:                                          ; preds = %for.body5.for.end_crit_edge, %for.body.for.end_crit_edge
  %sum.0.lcssa.reg2mem.0.sum.0.lcssa.reload = load double, ptr %sum.0.lcssa.reg2mem, align 8
  %arrayidx14 = getelementptr inbounds double, ptr %out, i64 %indvars.iv31.reg2mem14.0.load, !dbg !385
  store double %sum.0.lcssa.reg2mem.0.sum.0.lcssa.reload, ptr %arrayidx14, align 8, !dbg !386, !tbaa !370
    #dbg_value(i64 %indvars.iv.next32, !345, !DIExpression(), !356)
  %exitcond33.not = icmp eq i64 %indvars.iv.next32, 494, !dbg !387
  br i1 %exitcond33.not, label %for.end17, label %for.end.for.body_crit_edge, !dbg !359, !llvm.loop !388

for.end.for.body_crit_edge:                       ; preds = %for.end
  store i64 %indvars.iv.next32, ptr %indvars.iv31.reg2mem14, align 8
  store i32 %0, ptr %.reg2mem16, align 4
  br label %for.body, !dbg !359

for.end17:                                        ; preds = %for.end
  ret void, !dbg !390
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #0 !dbg !391 {
entry.split:
  %sum.0.lcssa.i.reg2mem = alloca double, align 8
  %sum.028.i.reg2mem = alloca double, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %indvars.iv31.i.reg2mem14 = alloca i64, align 8
  %.reg2mem16 = alloca i32, align 4
    #dbg_value(ptr %vargs, !395, !DIExpression(), !397)
    #dbg_value(ptr %vargs, !396, !DIExpression(), !397)
  %cols = getelementptr inbounds i8, ptr %vargs, i64 13328, !dbg !398
  %rowDelimiters = getelementptr inbounds i8, ptr %vargs, i64 19992, !dbg !399
  %vec = getelementptr inbounds i8, ptr %vargs, i64 21976, !dbg !400
  %out = getelementptr inbounds i8, ptr %vargs, i64 25928, !dbg !401
    #dbg_value(ptr %vargs, !340, !DIExpression(), !402)
    #dbg_value(ptr %cols, !341, !DIExpression(), !402)
    #dbg_value(ptr %rowDelimiters, !342, !DIExpression(), !402)
    #dbg_value(ptr %vec, !343, !DIExpression(), !402)
    #dbg_value(ptr %out, !344, !DIExpression(), !402)
    #dbg_label(!349, !404)
    #dbg_value(i32 0, !345, !DIExpression(), !402)
  %.pre.i = load i32, ptr %rowDelimiters, align 4, !dbg !405
  store i64 0, ptr %indvars.iv31.i.reg2mem14, align 8
  store i32 %.pre.i, ptr %.reg2mem16, align 4
  br label %for.body.i, !dbg !406

for.body.i:                                       ; preds = %for.end.i.for.body.i_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv31.i.reg2mem14.0.load, !345, !DIExpression(), !402)
    #dbg_value(double 0.000000e+00, !347, !DIExpression(), !402)
    #dbg_value(double 0.000000e+00, !348, !DIExpression(), !402)
    #dbg_value(i32 %.reg2mem16.0.load, !350, !DIExpression(), !407)
  %.reg2mem16.0.load = load i32, ptr %.reg2mem16, align 4
  %indvars.iv31.i.reg2mem14.0.load = load i64, ptr %indvars.iv31.i.reg2mem14, align 8
  %indvars.iv.next32.i = add nuw nsw i64 %indvars.iv31.i.reg2mem14.0.load, 1, !dbg !408
  %arrayidx2.i = getelementptr inbounds i32, ptr %rowDelimiters, i64 %indvars.iv.next32.i, !dbg !409
  %0 = load i32, ptr %arrayidx2.i, align 4, !dbg !409
    #dbg_value(i32 %0, !354, !DIExpression(), !407)
    #dbg_label(!355, !410)
    #dbg_value(i32 %.reg2mem16.0.load, !346, !DIExpression(), !402)
  %cmp427.i = icmp slt i32 %.reg2mem16.0.load, %0, !dbg !411
  br i1 %cmp427.i, label %for.body5.preheader.i, label %for.body.i.for.end.i_crit_edge, !dbg !412

for.body.i.for.end.i_crit_edge:                   ; preds = %for.body.i
  store double 0.000000e+00, ptr %sum.0.lcssa.i.reg2mem, align 8
  br label %for.end.i, !dbg !412

for.body5.preheader.i:                            ; preds = %for.body.i
  %1 = sext i32 %.reg2mem16.0.load to i64, !dbg !412
  %wide.trip.count.i = sext i32 %0 to i64, !dbg !411
  store double 0.000000e+00, ptr %sum.028.i.reg2mem, align 8
  store i64 %1, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body5.i, !dbg !412

for.body5.i:                                      ; preds = %for.body5.i.for.body5.i_crit_edge, %for.body5.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !346, !DIExpression(), !402)
    #dbg_value(double %sum.028.i.reg2mem.0.sum.028.i.reload, !347, !DIExpression(), !402)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %sum.028.i.reg2mem.0.sum.028.i.reload = load double, ptr %sum.028.i.reg2mem, align 8
  %arrayidx7.i = getelementptr inbounds double, ptr %vargs, i64 %indvars.iv.i.reg2mem.0.load, !dbg !413
  %2 = load double, ptr %arrayidx7.i, align 8, !dbg !413, !tbaa !370
  %arrayidx9.i = getelementptr inbounds i32, ptr %cols, i64 %indvars.iv.i.reg2mem.0.load, !dbg !414
  %3 = load i32, ptr %arrayidx9.i, align 4, !dbg !414, !tbaa !375
  %idxprom10.i = sext i32 %3 to i64, !dbg !415
  %arrayidx11.i = getelementptr inbounds double, ptr %vec, i64 %idxprom10.i, !dbg !415
  %4 = load double, ptr %arrayidx11.i, align 8, !dbg !415, !tbaa !370
  %mul.i = fmul double %2, %4, !dbg !416
    #dbg_value(double %mul.i, !348, !DIExpression(), !402)
  %add12.i = fadd double %sum.028.i.reg2mem.0.sum.028.i.reload, %mul.i, !dbg !417
    #dbg_value(double %add12.i, !347, !DIExpression(), !402)
  %indvars.iv.next.i = add nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !418
    #dbg_value(i64 %indvars.iv.next.i, !346, !DIExpression(), !402)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i, !dbg !411
  br i1 %exitcond.not.i, label %for.body5.i.for.end.i_crit_edge, label %for.body5.i.for.body5.i_crit_edge, !dbg !412, !llvm.loop !419

for.body5.i.for.body5.i_crit_edge:                ; preds = %for.body5.i
  store double %add12.i, ptr %sum.028.i.reg2mem, align 8
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body5.i, !dbg !412

for.body5.i.for.end.i_crit_edge:                  ; preds = %for.body5.i
  store double %add12.i, ptr %sum.0.lcssa.i.reg2mem, align 8
  br label %for.end.i, !dbg !412

for.end.i:                                        ; preds = %for.body5.i.for.end.i_crit_edge, %for.body.i.for.end.i_crit_edge
  %sum.0.lcssa.i.reg2mem.0.sum.0.lcssa.i.reload = load double, ptr %sum.0.lcssa.i.reg2mem, align 8
  %arrayidx14.i = getelementptr inbounds double, ptr %out, i64 %indvars.iv31.i.reg2mem14.0.load, !dbg !421
  store double %sum.0.lcssa.i.reg2mem.0.sum.0.lcssa.i.reload, ptr %arrayidx14.i, align 8, !dbg !422, !tbaa !370
    #dbg_value(i64 %indvars.iv.next32.i, !345, !DIExpression(), !402)
  %exitcond33.not.i = icmp eq i64 %indvars.iv.next32.i, 494, !dbg !423
  br i1 %exitcond33.not.i, label %spmv.exit, label %for.end.i.for.body.i_crit_edge, !dbg !406, !llvm.loop !424

for.end.i.for.body.i_crit_edge:                   ; preds = %for.end.i
  store i64 %indvars.iv.next32.i, ptr %indvars.iv31.i.reg2mem14, align 8
  store i32 %0, ptr %.reg2mem16, align 4
  br label %for.body.i, !dbg !406

spmv.exit:                                        ; preds = %for.end.i
  ret void, !dbg !426
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !427 {
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
    #dbg_value(i32 %fd, !431, !DIExpression(), !436)
    #dbg_value(ptr %vdata, !432, !DIExpression(), !436)
    #dbg_value(ptr %vdata, !433, !DIExpression(), !436)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(29880) %vdata, i8 0, i64 29880, i1 false), !dbg !437
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !438
    #dbg_value(ptr %call, !434, !DIExpression(), !436)
    #dbg_value(ptr %call, !439, !DIExpression(), !446)
    #dbg_value(i32 1, !444, !DIExpression(), !446)
    #dbg_value(i32 0, !445, !DIExpression(), !446)
  store ptr %call, ptr %call.reg2mem, align 8
  store ptr %call, ptr %s.addr.040.i.reg2mem166, align 8
  store i32 0, ptr %i.041.i.reg2mem168, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem168.0.load, !445, !DIExpression(), !446)
    #dbg_value(ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, !439, !DIExpression(), !446)
  %i.041.i.reg2mem168.0.load = load i32, ptr %i.041.i.reg2mem168, align 4
  %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167 = load ptr, ptr %s.addr.040.i.reg2mem166, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, align 1, !dbg !448, !tbaa !449
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !450

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !450

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem168.0.load, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !450

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 1, !dbg !451
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !451, !tbaa !449
  %cmp13.i = icmp eq i8 %1, 37, !dbg !454
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !455

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem168.0.load, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !455

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 2, !dbg !456
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !456, !tbaa !449
  %cmp18.i = icmp eq i8 %2, 10, !dbg !457
  %inc.i = zext i1 %cmp18.i to i32, !dbg !458
  %spec.select.i = add nsw i32 %i.041.i.reg2mem168.0.load, %inc.i, !dbg !458
  store i32 %spec.select.i, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !458

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem164.0.load, !445, !DIExpression(), !446)
  %i.1.i.reg2mem164.0.load = load i32, ptr %i.1.i.reg2mem164, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 1, !dbg !459
    #dbg_value(ptr %incdec.ptr.i, !439, !DIExpression(), !446)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem164.0.load, 1, !dbg !460
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !461, !llvm.loop !462

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem166, align 8
  store i32 %i.1.i.reg2mem164.0.load, ptr %i.041.i.reg2mem168, align 4
  br label %land.rhs.i, !dbg !461

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !464, !tbaa !449
  %3 = icmp eq i8 %.pre.i, 0, !dbg !466
  %4 = select i1 %3, i64 0, i64 2, !dbg !467
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !461

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !467
    #dbg_value(ptr %spec.select38.i, !435, !DIExpression(), !436)
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 1666) #18, !dbg !468
    #dbg_value(ptr %call, !439, !DIExpression(), !469)
    #dbg_value(i32 2, !444, !DIExpression(), !469)
    #dbg_value(i32 0, !445, !DIExpression(), !469)
  store ptr %call, ptr %s.addr.040.i3.reg2mem160, align 8
  store i32 0, ptr %i.041.i2.reg2mem162, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem162.0.load, !445, !DIExpression(), !469)
    #dbg_value(ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, !439, !DIExpression(), !469)
  %i.041.i2.reg2mem162.0.load = load i32, ptr %i.041.i2.reg2mem162, align 4
  %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161 = load ptr, ptr %s.addr.040.i3.reg2mem160, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, align 1, !dbg !471, !tbaa !449
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !472

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !472

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem162.0.load, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !472

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 1, !dbg !473
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !473, !tbaa !449
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !474
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !475

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem162.0.load, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !475

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 2, !dbg !476
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !476, !tbaa !449
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !477
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !478
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem162.0.load, %inc.i19, !dbg !478
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !478

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem158.0.load, !445, !DIExpression(), !469)
  %i.1.i8.reg2mem158.0.load = load i32, ptr %i.1.i8.reg2mem158, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 1, !dbg !479
    #dbg_value(ptr %incdec.ptr.i9, !439, !DIExpression(), !469)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem158.0.load, 2, !dbg !480
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !481, !llvm.loop !482

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem160, align 8
  store i32 %i.1.i8.reg2mem158.0.load, ptr %i.041.i2.reg2mem162, align 4
  br label %land.rhs.i1, !dbg !481

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !484, !tbaa !449
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !485
  %9 = select i1 %8, i64 0, i64 2, !dbg !486
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !481

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !486
    #dbg_value(ptr %spec.select38.i15, !435, !DIExpression(), !436)
  %cols = getelementptr inbounds i8, ptr %vdata, i64 13328, !dbg !487
  %call5 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %cols, i32 noundef signext 1666) #18, !dbg !488
    #dbg_value(ptr %call, !439, !DIExpression(), !489)
    #dbg_value(i32 3, !444, !DIExpression(), !489)
    #dbg_value(i32 0, !445, !DIExpression(), !489)
  store ptr %call, ptr %s.addr.040.i24.reg2mem154, align 8
  store i32 0, ptr %i.041.i23.reg2mem156, align 4
  br label %land.rhs.i22

land.rhs.i22:                                     ; preds = %if.end21.i28.land.rhs.i22_crit_edge, %find_section_start.exit21
    #dbg_value(i32 %i.041.i23.reg2mem156.0.load, !445, !DIExpression(), !489)
    #dbg_value(ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, !439, !DIExpression(), !489)
  %i.041.i23.reg2mem156.0.load = load i32, ptr %i.041.i23.reg2mem156, align 4
  %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155 = load ptr, ptr %s.addr.040.i24.reg2mem154, align 8
  %10 = load i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, align 1, !dbg !491, !tbaa !449
  switch i8 %10, label %land.rhs.i22.if.end21.i28_crit_edge [
    i8 0, label %land.rhs.i22.find_section_start.exit42_crit_edge
    i8 37, label %land.lhs.true10.i25
  ], !dbg !492

land.rhs.i22.find_section_start.exit42_crit_edge: ; preds = %land.rhs.i22
  store ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !492

land.rhs.i22.if.end21.i28_crit_edge:              ; preds = %land.rhs.i22
  store i32 %i.041.i23.reg2mem156.0.load, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !492

land.lhs.true10.i25:                              ; preds = %land.rhs.i22
  %arrayidx11.i26 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 1, !dbg !493
  %11 = load i8, ptr %arrayidx11.i26, align 1, !dbg !493, !tbaa !449
  %cmp13.i27 = icmp eq i8 %11, 37, !dbg !494
  br i1 %cmp13.i27, label %land.lhs.true15.i37, label %land.lhs.true10.i25.if.end21.i28_crit_edge, !dbg !495

land.lhs.true10.i25.if.end21.i28_crit_edge:       ; preds = %land.lhs.true10.i25
  store i32 %i.041.i23.reg2mem156.0.load, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !495

land.lhs.true15.i37:                              ; preds = %land.lhs.true10.i25
  %arrayidx16.i38 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 2, !dbg !496
  %12 = load i8, ptr %arrayidx16.i38, align 1, !dbg !496, !tbaa !449
  %cmp18.i39 = icmp eq i8 %12, 10, !dbg !497
  %inc.i40 = zext i1 %cmp18.i39 to i32, !dbg !498
  %spec.select.i41 = add nsw i32 %i.041.i23.reg2mem156.0.load, %inc.i40, !dbg !498
  store i32 %spec.select.i41, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !498

if.end21.i28:                                     ; preds = %land.lhs.true10.i25.if.end21.i28_crit_edge, %land.rhs.i22.if.end21.i28_crit_edge, %land.lhs.true15.i37
    #dbg_value(i32 %i.1.i29.reg2mem152.0.load, !445, !DIExpression(), !489)
  %i.1.i29.reg2mem152.0.load = load i32, ptr %i.1.i29.reg2mem152, align 4
  %incdec.ptr.i30 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 1, !dbg !499
    #dbg_value(ptr %incdec.ptr.i30, !439, !DIExpression(), !489)
  %cmp4.i31 = icmp slt i32 %i.1.i29.reg2mem152.0.load, 3, !dbg !500
  br i1 %cmp4.i31, label %if.end21.i28.land.rhs.i22_crit_edge, label %if.end21.while.end_crit_edge.i32, !dbg !501, !llvm.loop !502

if.end21.i28.land.rhs.i22_crit_edge:              ; preds = %if.end21.i28
  store ptr %incdec.ptr.i30, ptr %s.addr.040.i24.reg2mem154, align 8
  store i32 %i.1.i29.reg2mem152.0.load, ptr %i.041.i23.reg2mem156, align 4
  br label %land.rhs.i22, !dbg !501

if.end21.while.end_crit_edge.i32:                 ; preds = %if.end21.i28
  %.pre.i33 = load i8, ptr %incdec.ptr.i30, align 1, !dbg !504, !tbaa !449
  %13 = icmp eq i8 %.pre.i33, 0, !dbg !505
  %14 = select i1 %13, i64 0, i64 2, !dbg !506
  store ptr %incdec.ptr.i30, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 %14, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !501

find_section_start.exit42:                        ; preds = %land.rhs.i22.find_section_start.exit42_crit_edge, %if.end21.while.end_crit_edge.i32
  %cmp23.not.i34.reg2mem.0.load = load i64, ptr %cmp23.not.i34.reg2mem, align 8
  %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload = load ptr, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  %spec.select38.i36 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload, i64 %cmp23.not.i34.reg2mem.0.load, !dbg !506
    #dbg_value(ptr %spec.select38.i36, !435, !DIExpression(), !436)
  %rowDelimiters = getelementptr inbounds i8, ptr %vdata, i64 19992, !dbg !507
  %call8 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i36, ptr noundef nonnull %rowDelimiters, i32 noundef signext 495) #18, !dbg !508
    #dbg_value(ptr %call, !439, !DIExpression(), !509)
    #dbg_value(i32 4, !444, !DIExpression(), !509)
    #dbg_value(i32 0, !445, !DIExpression(), !509)
  store ptr %call, ptr %s.addr.040.i45.reg2mem148, align 8
  store i32 0, ptr %i.041.i44.reg2mem150, align 4
  br label %land.rhs.i43

land.rhs.i43:                                     ; preds = %if.end21.i49.land.rhs.i43_crit_edge, %find_section_start.exit42
    #dbg_value(i32 %i.041.i44.reg2mem150.0.load, !445, !DIExpression(), !509)
    #dbg_value(ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, !439, !DIExpression(), !509)
  %i.041.i44.reg2mem150.0.load = load i32, ptr %i.041.i44.reg2mem150, align 4
  %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149 = load ptr, ptr %s.addr.040.i45.reg2mem148, align 8
  %15 = load i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, align 1, !dbg !511, !tbaa !449
  switch i8 %15, label %land.rhs.i43.if.end21.i49_crit_edge [
    i8 0, label %land.rhs.i43.find_section_start.exit63_crit_edge
    i8 37, label %land.lhs.true10.i46
  ], !dbg !512

land.rhs.i43.find_section_start.exit63_crit_edge: ; preds = %land.rhs.i43
  store ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i55.reg2mem, align 8
  br label %find_section_start.exit63, !dbg !512

land.rhs.i43.if.end21.i49_crit_edge:              ; preds = %land.rhs.i43
  store i32 %i.041.i44.reg2mem150.0.load, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !512

land.lhs.true10.i46:                              ; preds = %land.rhs.i43
  %arrayidx11.i47 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 1, !dbg !513
  %16 = load i8, ptr %arrayidx11.i47, align 1, !dbg !513, !tbaa !449
  %cmp13.i48 = icmp eq i8 %16, 37, !dbg !514
  br i1 %cmp13.i48, label %land.lhs.true15.i58, label %land.lhs.true10.i46.if.end21.i49_crit_edge, !dbg !515

land.lhs.true10.i46.if.end21.i49_crit_edge:       ; preds = %land.lhs.true10.i46
  store i32 %i.041.i44.reg2mem150.0.load, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !515

land.lhs.true15.i58:                              ; preds = %land.lhs.true10.i46
  %arrayidx16.i59 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 2, !dbg !516
  %17 = load i8, ptr %arrayidx16.i59, align 1, !dbg !516, !tbaa !449
  %cmp18.i60 = icmp eq i8 %17, 10, !dbg !517
  %inc.i61 = zext i1 %cmp18.i60 to i32, !dbg !518
  %spec.select.i62 = add nsw i32 %i.041.i44.reg2mem150.0.load, %inc.i61, !dbg !518
  store i32 %spec.select.i62, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !518

if.end21.i49:                                     ; preds = %land.lhs.true10.i46.if.end21.i49_crit_edge, %land.rhs.i43.if.end21.i49_crit_edge, %land.lhs.true15.i58
    #dbg_value(i32 %i.1.i50.reg2mem146.0.load, !445, !DIExpression(), !509)
  %i.1.i50.reg2mem146.0.load = load i32, ptr %i.1.i50.reg2mem146, align 4
  %incdec.ptr.i51 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 1, !dbg !519
    #dbg_value(ptr %incdec.ptr.i51, !439, !DIExpression(), !509)
  %cmp4.i52 = icmp slt i32 %i.1.i50.reg2mem146.0.load, 4, !dbg !520
  br i1 %cmp4.i52, label %if.end21.i49.land.rhs.i43_crit_edge, label %if.end21.while.end_crit_edge.i53, !dbg !521, !llvm.loop !522

if.end21.i49.land.rhs.i43_crit_edge:              ; preds = %if.end21.i49
  store ptr %incdec.ptr.i51, ptr %s.addr.040.i45.reg2mem148, align 8
  store i32 %i.1.i50.reg2mem146.0.load, ptr %i.041.i44.reg2mem150, align 4
  br label %land.rhs.i43, !dbg !521

if.end21.while.end_crit_edge.i53:                 ; preds = %if.end21.i49
  %.pre.i54 = load i8, ptr %incdec.ptr.i51, align 1, !dbg !524, !tbaa !449
  %18 = icmp eq i8 %.pre.i54, 0, !dbg !525
  %19 = select i1 %18, i64 0, i64 2, !dbg !526
  store ptr %incdec.ptr.i51, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  store i64 %19, ptr %cmp23.not.i55.reg2mem, align 8
  br label %find_section_start.exit63, !dbg !521

find_section_start.exit63:                        ; preds = %land.rhs.i43.find_section_start.exit63_crit_edge, %if.end21.while.end_crit_edge.i53
  %cmp23.not.i55.reg2mem.0.load = load i64, ptr %cmp23.not.i55.reg2mem, align 8
  %s.addr.0.lcssa.ph.i56.reg2mem.0.s.addr.0.lcssa.ph.i56.reload = load ptr, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  %spec.select38.i57 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i56.reg2mem.0.s.addr.0.lcssa.ph.i56.reload, i64 %cmp23.not.i55.reg2mem.0.load, !dbg !526
    #dbg_value(ptr %spec.select38.i57, !435, !DIExpression(), !436)
  %vec = getelementptr inbounds i8, ptr %vdata, i64 21976, !dbg !527
  %call11 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i57, ptr noundef nonnull %vec, i32 noundef signext 494) #18, !dbg !528
  %call.reg2mem.0.call.reload145 = load ptr, ptr %call.reg2mem, align 8
  tail call void @free(ptr noundef %call.reg2mem.0.call.reload145) #18, !dbg !529
  ret void, !dbg !530
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !531 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !533 {
entry.split:
  %indvars.iv.i33.reg2mem = alloca i64, align 8
  %indvars.iv.i21.reg2mem = alloca i64, align 8
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !535, !DIExpression(), !538)
    #dbg_value(ptr %vdata, !536, !DIExpression(), !538)
    #dbg_value(ptr %vdata, !537, !DIExpression(), !538)
    #dbg_value(i32 %fd, !539, !DIExpression(), !544)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !546
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !546

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !546
  unreachable, !dbg !546

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !549
    #dbg_value(i32 %fd, !550, !DIExpression(), !558)
    #dbg_value(ptr %vdata, !555, !DIExpression(), !558)
    #dbg_value(i32 1666, !556, !DIExpression(), !558)
    #dbg_value(i32 0, !557, !DIExpression(), !558)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !560

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !557, !DIExpression(), !558)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !562
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !562, !tbaa !370
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !562
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !565
    #dbg_value(i64 %indvars.iv.next.i, !557, !DIExpression(), !558)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 1666, !dbg !565
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !560, !llvm.loop !566

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !560

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !539, !DIExpression(), !567)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !569
  %cols = getelementptr inbounds i8, ptr %vdata, i64 13328, !dbg !570
    #dbg_value(i32 %fd, !571, !DIExpression(), !579)
    #dbg_value(ptr %cols, !576, !DIExpression(), !579)
    #dbg_value(i32 1666, !577, !DIExpression(), !579)
    #dbg_value(i32 0, !578, !DIExpression(), !579)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !581

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !578, !DIExpression(), !579)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds i32, ptr %cols, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !583
  %1 = load i32, ptr %arrayidx.i11, align 4, !dbg !583, !tbaa !375
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %1), !dbg !583
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !586
    #dbg_value(i64 %indvars.iv.next.i12, !578, !DIExpression(), !579)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 1666, !dbg !586
  br i1 %exitcond.not.i13, label %for.cond.preheader.i19, label %for.body.i9.for.body.i9_crit_edge, !dbg !581, !llvm.loop !587

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !581

for.cond.preheader.i19:                           ; preds = %for.body.i9
    #dbg_value(i32 %fd, !539, !DIExpression(), !588)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !590
  %rowDelimiters = getelementptr inbounds i8, ptr %vdata, i64 19992, !dbg !591
    #dbg_value(i32 %fd, !571, !DIExpression(), !592)
    #dbg_value(ptr %rowDelimiters, !576, !DIExpression(), !592)
    #dbg_value(i32 495, !577, !DIExpression(), !592)
    #dbg_value(i32 0, !578, !DIExpression(), !592)
  store i64 0, ptr %indvars.iv.i21.reg2mem, align 8
  br label %for.body.i20, !dbg !594

for.body.i20:                                     ; preds = %for.body.i20.for.body.i20_crit_edge, %for.cond.preheader.i19
    #dbg_value(i64 %indvars.iv.i21.reg2mem.0.load, !578, !DIExpression(), !592)
  %indvars.iv.i21.reg2mem.0.load = load i64, ptr %indvars.iv.i21.reg2mem, align 8
  %arrayidx.i22 = getelementptr inbounds i32, ptr %rowDelimiters, i64 %indvars.iv.i21.reg2mem.0.load, !dbg !595
  %2 = load i32, ptr %arrayidx.i22, align 4, !dbg !595, !tbaa !375
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %2), !dbg !595
  %indvars.iv.next.i23 = add nuw nsw i64 %indvars.iv.i21.reg2mem.0.load, 1, !dbg !596
    #dbg_value(i64 %indvars.iv.next.i23, !578, !DIExpression(), !592)
  %exitcond.not.i24 = icmp eq i64 %indvars.iv.next.i23, 495, !dbg !596
  br i1 %exitcond.not.i24, label %for.cond.preheader.i31, label %for.body.i20.for.body.i20_crit_edge, !dbg !594, !llvm.loop !597

for.body.i20.for.body.i20_crit_edge:              ; preds = %for.body.i20
  store i64 %indvars.iv.next.i23, ptr %indvars.iv.i21.reg2mem, align 8
  br label %for.body.i20, !dbg !594

for.cond.preheader.i31:                           ; preds = %for.body.i20
    #dbg_value(i32 %fd, !539, !DIExpression(), !598)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !600
  %vec = getelementptr inbounds i8, ptr %vdata, i64 21976, !dbg !601
    #dbg_value(i32 %fd, !550, !DIExpression(), !602)
    #dbg_value(ptr %vec, !555, !DIExpression(), !602)
    #dbg_value(i32 494, !556, !DIExpression(), !602)
    #dbg_value(i32 0, !557, !DIExpression(), !602)
  store i64 0, ptr %indvars.iv.i33.reg2mem, align 8
  br label %for.body.i32, !dbg !604

for.body.i32:                                     ; preds = %for.body.i32.for.body.i32_crit_edge, %for.cond.preheader.i31
    #dbg_value(i64 %indvars.iv.i33.reg2mem.0.load, !557, !DIExpression(), !602)
  %indvars.iv.i33.reg2mem.0.load = load i64, ptr %indvars.iv.i33.reg2mem, align 8
  %arrayidx.i34 = getelementptr inbounds double, ptr %vec, i64 %indvars.iv.i33.reg2mem.0.load, !dbg !605
  %3 = load double, ptr %arrayidx.i34, align 8, !dbg !605, !tbaa !370
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %3), !dbg !605
  %indvars.iv.next.i35 = add nuw nsw i64 %indvars.iv.i33.reg2mem.0.load, 1, !dbg !606
    #dbg_value(i64 %indvars.iv.next.i35, !557, !DIExpression(), !602)
  %exitcond.not.i36 = icmp eq i64 %indvars.iv.next.i35, 494, !dbg !606
  br i1 %exitcond.not.i36, label %write_double_array.exit37, label %for.body.i32.for.body.i32_crit_edge, !dbg !604, !llvm.loop !607

for.body.i32.for.body.i32_crit_edge:              ; preds = %for.body.i32
  store i64 %indvars.iv.next.i35, ptr %indvars.iv.i33.reg2mem, align 8
  br label %for.body.i32, !dbg !604

write_double_array.exit37:                        ; preds = %for.body.i32
  ret void, !dbg !608
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !609 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !611, !DIExpression(), !616)
    #dbg_value(ptr %vdata, !612, !DIExpression(), !616)
    #dbg_value(ptr %vdata, !613, !DIExpression(), !616)
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !617
    #dbg_value(ptr %call, !614, !DIExpression(), !616)
    #dbg_value(ptr %call, !439, !DIExpression(), !618)
    #dbg_value(i32 1, !444, !DIExpression(), !618)
    #dbg_value(i32 0, !445, !DIExpression(), !618)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !445, !DIExpression(), !618)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !439, !DIExpression(), !618)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !620, !tbaa !449
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !621

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !621

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !621

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !622
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !622, !tbaa !449
  %cmp13.i = icmp eq i8 %1, 37, !dbg !623
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !624

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !624

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !625
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !625, !tbaa !449
  %cmp18.i = icmp eq i8 %2, 10, !dbg !626
  %inc.i = zext i1 %cmp18.i to i32, !dbg !627
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !627
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !627

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !445, !DIExpression(), !618)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !628
    #dbg_value(ptr %incdec.ptr.i, !439, !DIExpression(), !618)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !629
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !630, !llvm.loop !631

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !630

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !633, !tbaa !449
  %3 = icmp eq i8 %.pre.i, 0, !dbg !634
  %4 = select i1 %3, i64 0, i64 2, !dbg !635
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !630

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !635
    #dbg_value(ptr %spec.select38.i, !615, !DIExpression(), !616)
  %out = getelementptr inbounds i8, ptr %vdata, i64 25928, !dbg !636
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %out, i32 noundef signext 494) #18, !dbg !637
  tail call void @free(ptr noundef %call) #18, !dbg !638
  ret void, !dbg !639
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !640 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !642, !DIExpression(), !645)
    #dbg_value(ptr %vdata, !643, !DIExpression(), !645)
    #dbg_value(ptr %vdata, !644, !DIExpression(), !645)
    #dbg_value(i32 %fd, !539, !DIExpression(), !646)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !648
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !648

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !648
  unreachable, !dbg !648

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !649
  %out = getelementptr inbounds i8, ptr %vdata, i64 25928, !dbg !650
    #dbg_value(i32 %fd, !550, !DIExpression(), !651)
    #dbg_value(ptr %out, !555, !DIExpression(), !651)
    #dbg_value(i32 494, !556, !DIExpression(), !651)
    #dbg_value(i32 0, !557, !DIExpression(), !651)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !653

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !557, !DIExpression(), !651)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %out, i64 %indvars.iv.i.reg2mem.0.load, !dbg !654
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !654, !tbaa !370
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !654
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !655
    #dbg_value(i64 %indvars.iv.next.i, !557, !DIExpression(), !651)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 494, !dbg !655
  br i1 %exitcond.not.i, label %write_double_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !653, !llvm.loop !656

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !653

write_double_array.exit:                          ; preds = %for.body.i
  ret void, !dbg !657
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #4 !dbg !658 {
entry.split:
  %has_errors.012.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(ptr %vdata, !662, !DIExpression(), !669)
    #dbg_value(ptr %vref, !663, !DIExpression(), !669)
    #dbg_value(ptr %vdata, !664, !DIExpression(), !669)
    #dbg_value(ptr %vref, !665, !DIExpression(), !669)
    #dbg_value(i32 0, !666, !DIExpression(), !669)
    #dbg_value(i32 0, !667, !DIExpression(), !669)
  store i32 0, ptr %has_errors.012.reg2mem, align 4
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !670

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i32 %has_errors.012.reg2mem.0.load, !666, !DIExpression(), !669)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !667, !DIExpression(), !669)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %has_errors.012.reg2mem.0.load = load i32, ptr %has_errors.012.reg2mem, align 4
  %arrayidx = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 4, i64 %indvars.iv.reg2mem.0.load, !dbg !672
  %0 = load double, ptr %arrayidx, align 8, !dbg !672, !tbaa !370
  %arrayidx3 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 4, i64 %indvars.iv.reg2mem.0.load, !dbg !675
  %1 = load double, ptr %arrayidx3, align 8, !dbg !675, !tbaa !370
  %sub = fsub double %0, %1, !dbg !676
    #dbg_value(double %sub, !668, !DIExpression(), !669)
  %2 = tail call double @llvm.fabs.f64(double %sub), !dbg !677
  %3 = fcmp ogt double %2, 0x3EB0C6F7A0B5ED8D, !dbg !677
  %lor.ext = zext i1 %3 to i32, !dbg !677
  %or = or i32 %has_errors.012.reg2mem.0.load, %lor.ext, !dbg !678
    #dbg_value(i32 %or, !666, !DIExpression(), !669)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !679
    #dbg_value(i64 %indvars.iv.next, !667, !DIExpression(), !669)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 494, !dbg !680
  br i1 %exitcond.not, label %for.end, label %for.body.for.body_crit_edge, !dbg !670, !llvm.loop !681

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i32 %or, ptr %has_errors.012.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !670

for.end:                                          ; preds = %for.body
  %tobool.not = icmp eq i32 %or, 0, !dbg !683
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !683
  ret i32 %lnot.ext, !dbg !684
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !685 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !735
    #dbg_assign(i1 undef, !691, !DIExpression(), !735, ptr %s, !DIExpression(), !736)
    #dbg_value(i32 %fd, !689, !DIExpression(), !736)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #18, !dbg !737
  %cmp = icmp sgt i32 %fd, 1, !dbg !738
  br i1 %cmp, label %if.end, label %if.else, !dbg !738

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !738
  unreachable, !dbg !738

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #18, !dbg !741
  %cmp1 = icmp eq i32 %call, 0, !dbg !741
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !741

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !741
  unreachable, !dbg !741

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !744
  %0 = load i64, ptr %st_size, align 8, !dbg !744
    #dbg_value(i64 %0, !728, !DIExpression(), !736)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !745
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !745

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !745
  unreachable, !dbg !745

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !748
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #20, !dbg !749
    #dbg_value(ptr %call11, !690, !DIExpression(), !736)
    #dbg_value(i64 0, !731, !DIExpression(), !736)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !750

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !751
    #dbg_value(i64 %add19, !731, !DIExpression(), !736)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !753
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !750, !llvm.loop !754

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !750

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !731, !DIExpression(), !736)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !756
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !757
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #18, !dbg !758
    #dbg_value(i64 %call13, !734, !DIExpression(), !736)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !759
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !731, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !736)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !759

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !759
  unreachable, !dbg !759

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !762
  store i8 0, ptr %arrayidx20, align 1, !dbg !763, !tbaa !449
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #18, !dbg !764
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #18, !dbg !765
  ret ptr %call11, !dbg !766
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: noreturn nounwind
declare !dbg !767 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare !dbg !772 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !777 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #8

; Function Attrs: nofree
declare !dbg !782 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #9

declare !dbg !786 signext i32 @close(i32 noundef signext) local_unnamed_addr #10

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #1 !dbg !440 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !439, !DIExpression(), !787)
    #dbg_value(i32 %n, !444, !DIExpression(), !787)
    #dbg_value(i32 0, !445, !DIExpression(), !787)
  %cmp = icmp sgt i32 %n, -1, !dbg !788
  br i1 %cmp, label %if.end, label %if.else, !dbg !788

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #19, !dbg !788
  unreachable, !dbg !788

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !791
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !793

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !793

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !793

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !445, !DIExpression(), !787)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !439, !DIExpression(), !787)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !794, !tbaa !449
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !795

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !795

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !795

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !796
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !796, !tbaa !449
  %cmp13 = icmp eq i8 %1, 37, !dbg !797
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !798

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !798

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !799
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !799, !tbaa !449
  %cmp18 = icmp eq i8 %2, 10, !dbg !800
  %inc = zext i1 %cmp18 to i32, !dbg !801
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !801
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !801

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !445, !DIExpression(), !787)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !802
    #dbg_value(ptr %incdec.ptr, !439, !DIExpression(), !787)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !803
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !804, !llvm.loop !805

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !804

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !807, !tbaa !449
  %3 = icmp eq i8 %.pre, 0, !dbg !808
  %4 = select i1 %3, i64 0, i64 2, !dbg !809
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !804

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !809
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !809

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !810
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !811 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !815, !DIExpression(), !819)
    #dbg_value(ptr %arr, !816, !DIExpression(), !819)
    #dbg_value(i32 %n, !817, !DIExpression(), !819)
  %cmp.not = icmp eq ptr %s, null, !dbg !820
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !820

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #19, !dbg !820
  unreachable, !dbg !820

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !823
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !825

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !826
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !828
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !828

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !818, !DIExpression(), !819)
  %conv404 = zext nneg i32 %n to i64, !dbg !829
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !830
  br label %if.end46, !dbg !831

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !818, !DIExpression(), !819)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !832
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !833

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !833

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !834
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !835
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !835
  %cmp9.not = icmp eq i8 %0, 0, !dbg !836
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !837

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !837

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !838
  %1 = load i8, ptr %gep, align 1, !dbg !838
  %cmp16.not = icmp eq i8 %1, 0, !dbg !839
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !840

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !840

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !841
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !842
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !842
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !842, !llvm.loop !843

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !842

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !829

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !829

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !829

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !829
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !818, !DIExpression(), !819)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !830
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !845
  store i8 0, ptr %arrayidx45, align 1, !dbg !847, !tbaa !449
  br label %if.end46, !dbg !845

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !848
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #11

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !849 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !861
    #dbg_assign(i1 undef, !858, !DIExpression(), !861, ptr %endptr, !DIExpression(), !862)
    #dbg_value(ptr %s, !854, !DIExpression(), !862)
    #dbg_value(ptr %arr, !855, !DIExpression(), !862)
    #dbg_value(i32 %n, !856, !DIExpression(), !862)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !863
    #dbg_value(i32 0, !859, !DIExpression(), !862)
  %cmp.not = icmp eq ptr %s, null, !dbg !864
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !864

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #19, !dbg !864
  unreachable, !dbg !864

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !863
    #dbg_value(ptr %call, !857, !DIExpression(), !862)
    #dbg_value(i32 0, !859, !DIExpression(), !862)
  %cmp130 = icmp ne ptr %call, null, !dbg !863
  %cmp231 = icmp sgt i32 %n, 0, !dbg !863
  %0 = and i1 %cmp231, %cmp130, !dbg !863
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !863

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !863

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !863
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !863

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !857, !DIExpression(), !862)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !859, !DIExpression(), !862)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !867, !tbaa !869, !DIAssignID !871
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !858, !DIExpression(), !871, ptr %endptr, !DIExpression(), !862)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !867
  %conv = trunc i64 %call3 to i8, !dbg !867
    #dbg_value(i8 %conv, !860, !DIExpression(), !862)
  %2 = load ptr, ptr %endptr, align 8, !dbg !872, !tbaa !869
  %3 = load i8, ptr %2, align 1, !dbg !872, !tbaa !449
  %cmp5.not = icmp eq i8 %3, 0, !dbg !872
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !867

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !867

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !874, !tbaa !869
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !874
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !874
  br label %if.end9, !dbg !874

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !867
  store i8 %conv, ptr %arrayidx, align 1, !dbg !867, !tbaa !449
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !867
    #dbg_value(i64 %indvars.iv.next, !859, !DIExpression(), !862)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !867
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !867
  store i8 10, ptr %arrayidx11, align 1, !dbg !867, !tbaa !449
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !867
    #dbg_value(ptr %call12, !857, !DIExpression(), !862)
  %cmp1 = icmp ne ptr %call12, null, !dbg !863
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !863
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !863
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !863, !llvm.loop !876

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !863

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !863

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !863

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !863

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !877
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !877
  store i8 10, ptr %arrayidx17, align 1, !dbg !877, !tbaa !449
  br label %if.end18, !dbg !877

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !863
  ret i32 0, !dbg !863
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !880 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #12

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !886 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #12

; Function Attrs: nofree nounwind
declare !dbg !891 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !946 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !949 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !961
    #dbg_assign(i1 undef, !958, !DIExpression(), !961, ptr %endptr, !DIExpression(), !962)
    #dbg_value(ptr %s, !954, !DIExpression(), !962)
    #dbg_value(ptr %arr, !955, !DIExpression(), !962)
    #dbg_value(i32 %n, !956, !DIExpression(), !962)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !963
    #dbg_value(i32 0, !959, !DIExpression(), !962)
  %cmp.not = icmp eq ptr %s, null, !dbg !964
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !964

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #19, !dbg !964
  unreachable, !dbg !964

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !963
    #dbg_value(ptr %call, !957, !DIExpression(), !962)
    #dbg_value(i32 0, !959, !DIExpression(), !962)
  %cmp130 = icmp ne ptr %call, null, !dbg !963
  %cmp231 = icmp sgt i32 %n, 0, !dbg !963
  %0 = and i1 %cmp231, %cmp130, !dbg !963
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !963

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !963

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !963
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !963

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !957, !DIExpression(), !962)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !959, !DIExpression(), !962)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !967, !tbaa !869, !DIAssignID !969
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !958, !DIExpression(), !969, ptr %endptr, !DIExpression(), !962)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !967
  %conv = trunc i64 %call3 to i16, !dbg !967
    #dbg_value(i16 %conv, !960, !DIExpression(), !962)
  %2 = load ptr, ptr %endptr, align 8, !dbg !970, !tbaa !869
  %3 = load i8, ptr %2, align 1, !dbg !970, !tbaa !449
  %cmp5.not = icmp eq i8 %3, 0, !dbg !970
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !967

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !967

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !972, !tbaa !869
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !972
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !972
  br label %if.end9, !dbg !972

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !967
  store i16 %conv, ptr %arrayidx, align 2, !dbg !967, !tbaa !974
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !967
    #dbg_value(i64 %indvars.iv.next, !959, !DIExpression(), !962)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !967
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !967
  store i8 10, ptr %arrayidx11, align 1, !dbg !967, !tbaa !449
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !967
    #dbg_value(ptr %call12, !957, !DIExpression(), !962)
  %cmp1 = icmp ne ptr %call12, null, !dbg !963
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !963
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !963
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !963, !llvm.loop !976

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !963

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !963

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !963

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !963

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !977
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !977
  store i8 10, ptr %arrayidx17, align 1, !dbg !977, !tbaa !449
  br label %if.end18, !dbg !977

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !963
  ret i32 0, !dbg !963
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !980 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !992
    #dbg_assign(i1 undef, !989, !DIExpression(), !992, ptr %endptr, !DIExpression(), !993)
    #dbg_value(ptr %s, !985, !DIExpression(), !993)
    #dbg_value(ptr %arr, !986, !DIExpression(), !993)
    #dbg_value(i32 %n, !987, !DIExpression(), !993)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !994
    #dbg_value(i32 0, !990, !DIExpression(), !993)
  %cmp.not = icmp eq ptr %s, null, !dbg !995
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !995

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #19, !dbg !995
  unreachable, !dbg !995

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !994
    #dbg_value(ptr %call, !988, !DIExpression(), !993)
    #dbg_value(i32 0, !990, !DIExpression(), !993)
  %cmp130 = icmp ne ptr %call, null, !dbg !994
  %cmp231 = icmp sgt i32 %n, 0, !dbg !994
  %0 = and i1 %cmp231, %cmp130, !dbg !994
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !994

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !994

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !994
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !994

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !988, !DIExpression(), !993)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !990, !DIExpression(), !993)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !998, !tbaa !869, !DIAssignID !1000
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !989, !DIExpression(), !1000, ptr %endptr, !DIExpression(), !993)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !998
  %conv = trunc i64 %call3 to i32, !dbg !998
    #dbg_value(i32 %conv, !991, !DIExpression(), !993)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1001, !tbaa !869
  %3 = load i8, ptr %2, align 1, !dbg !1001, !tbaa !449
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1001
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !998

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !998

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1003, !tbaa !869
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1003
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1003
  br label %if.end9, !dbg !1003

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !998
  store i32 %conv, ptr %arrayidx, align 4, !dbg !998, !tbaa !375
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !998
    #dbg_value(i64 %indvars.iv.next, !990, !DIExpression(), !993)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !998
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !998
  store i8 10, ptr %arrayidx11, align 1, !dbg !998, !tbaa !449
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !998
    #dbg_value(ptr %call12, !988, !DIExpression(), !993)
  %cmp1 = icmp ne ptr %call12, null, !dbg !994
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !994
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !994
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !994, !llvm.loop !1005

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !994

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !994

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !994

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !994

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1006
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1006
  store i8 10, ptr %arrayidx17, align 1, !dbg !1006, !tbaa !449
  br label %if.end18, !dbg !1006

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !994
  ret i32 0, !dbg !994
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1009 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1021
    #dbg_assign(i1 undef, !1018, !DIExpression(), !1021, ptr %endptr, !DIExpression(), !1022)
    #dbg_value(ptr %s, !1014, !DIExpression(), !1022)
    #dbg_value(ptr %arr, !1015, !DIExpression(), !1022)
    #dbg_value(i32 %n, !1016, !DIExpression(), !1022)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1023
    #dbg_value(i32 0, !1019, !DIExpression(), !1022)
  %cmp.not = icmp eq ptr %s, null, !dbg !1024
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1024

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #19, !dbg !1024
  unreachable, !dbg !1024

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1023
    #dbg_value(ptr %call, !1017, !DIExpression(), !1022)
    #dbg_value(i32 0, !1019, !DIExpression(), !1022)
  %cmp129 = icmp ne ptr %call, null, !dbg !1023
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1023
  %0 = and i1 %cmp230, %cmp129, !dbg !1023
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1023

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1023

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1023
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1023

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1017, !DIExpression(), !1022)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1019, !DIExpression(), !1022)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1027, !tbaa !869, !DIAssignID !1029
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1018, !DIExpression(), !1029, ptr %endptr, !DIExpression(), !1022)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1027
    #dbg_value(i64 %call3, !1020, !DIExpression(), !1022)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1030, !tbaa !869
  %3 = load i8, ptr %2, align 1, !dbg !1030, !tbaa !449
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1030
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1027

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1027

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1032, !tbaa !869
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1032
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1032
  br label %if.end8, !dbg !1032

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1027
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1027, !tbaa !1034
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1027
    #dbg_value(i64 %indvars.iv.next, !1019, !DIExpression(), !1022)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1027
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1027
  store i8 10, ptr %arrayidx10, align 1, !dbg !1027, !tbaa !449
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1027
    #dbg_value(ptr %call11, !1017, !DIExpression(), !1022)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1023
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1023
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1023
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1023, !llvm.loop !1036

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1023

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1023

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1023

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1023

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1037
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1037
  store i8 10, ptr %arrayidx16, align 1, !dbg !1037, !tbaa !449
  br label %if.end17, !dbg !1037

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1023
  ret i32 0, !dbg !1023
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1040 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1052
    #dbg_assign(i1 undef, !1049, !DIExpression(), !1052, ptr %endptr, !DIExpression(), !1053)
    #dbg_value(ptr %s, !1045, !DIExpression(), !1053)
    #dbg_value(ptr %arr, !1046, !DIExpression(), !1053)
    #dbg_value(i32 %n, !1047, !DIExpression(), !1053)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1054
    #dbg_value(i32 0, !1050, !DIExpression(), !1053)
  %cmp.not = icmp eq ptr %s, null, !dbg !1055
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1055

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #19, !dbg !1055
  unreachable, !dbg !1055

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1054
    #dbg_value(ptr %call, !1048, !DIExpression(), !1053)
    #dbg_value(i32 0, !1050, !DIExpression(), !1053)
  %cmp130 = icmp ne ptr %call, null, !dbg !1054
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1054
  %0 = and i1 %cmp231, %cmp130, !dbg !1054
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1054

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1054

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1054
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1054

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1048, !DIExpression(), !1053)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1050, !DIExpression(), !1053)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1058, !tbaa !869, !DIAssignID !1060
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1049, !DIExpression(), !1060, ptr %endptr, !DIExpression(), !1053)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1058
  %conv = trunc i64 %call3 to i8, !dbg !1058
    #dbg_value(i8 %conv, !1051, !DIExpression(), !1053)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1061, !tbaa !869
  %3 = load i8, ptr %2, align 1, !dbg !1061, !tbaa !449
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1061
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1058

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1058

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1063, !tbaa !869
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1063
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1063
  br label %if.end9, !dbg !1063

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1058
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1058, !tbaa !449
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1058
    #dbg_value(i64 %indvars.iv.next, !1050, !DIExpression(), !1053)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1058
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1058
  store i8 10, ptr %arrayidx11, align 1, !dbg !1058, !tbaa !449
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1058
    #dbg_value(ptr %call12, !1048, !DIExpression(), !1053)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1054
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1054
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1054
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1054, !llvm.loop !1065

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1054

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1054

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1054

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1054

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1066
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1066
  store i8 10, ptr %arrayidx17, align 1, !dbg !1066, !tbaa !449
  br label %if.end18, !dbg !1066

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1054
  ret i32 0, !dbg !1054
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1069 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1081
    #dbg_assign(i1 undef, !1078, !DIExpression(), !1081, ptr %endptr, !DIExpression(), !1082)
    #dbg_value(ptr %s, !1074, !DIExpression(), !1082)
    #dbg_value(ptr %arr, !1075, !DIExpression(), !1082)
    #dbg_value(i32 %n, !1076, !DIExpression(), !1082)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1083
    #dbg_value(i32 0, !1079, !DIExpression(), !1082)
  %cmp.not = icmp eq ptr %s, null, !dbg !1084
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1084

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #19, !dbg !1084
  unreachable, !dbg !1084

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1083
    #dbg_value(ptr %call, !1077, !DIExpression(), !1082)
    #dbg_value(i32 0, !1079, !DIExpression(), !1082)
  %cmp130 = icmp ne ptr %call, null, !dbg !1083
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1083
  %0 = and i1 %cmp231, %cmp130, !dbg !1083
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1083

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1083

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1083
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1083

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1077, !DIExpression(), !1082)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1079, !DIExpression(), !1082)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1087, !tbaa !869, !DIAssignID !1089
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1078, !DIExpression(), !1089, ptr %endptr, !DIExpression(), !1082)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1087
  %conv = trunc i64 %call3 to i16, !dbg !1087
    #dbg_value(i16 %conv, !1080, !DIExpression(), !1082)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1090, !tbaa !869
  %3 = load i8, ptr %2, align 1, !dbg !1090, !tbaa !449
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1090
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1087

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1087

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1092, !tbaa !869
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1092
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1092
  br label %if.end9, !dbg !1092

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1087
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1087, !tbaa !974
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1087
    #dbg_value(i64 %indvars.iv.next, !1079, !DIExpression(), !1082)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1087
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1087
  store i8 10, ptr %arrayidx11, align 1, !dbg !1087, !tbaa !449
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1087
    #dbg_value(ptr %call12, !1077, !DIExpression(), !1082)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1083
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1083
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1083
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1083, !llvm.loop !1094

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1083

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1083

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1083

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1083

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1095
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1095
  store i8 10, ptr %arrayidx17, align 1, !dbg !1095, !tbaa !449
  br label %if.end18, !dbg !1095

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1083
  ret i32 0, !dbg !1083
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1098 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1109
    #dbg_assign(i1 undef, !1106, !DIExpression(), !1109, ptr %endptr, !DIExpression(), !1110)
    #dbg_value(ptr %s, !1102, !DIExpression(), !1110)
    #dbg_value(ptr %arr, !1103, !DIExpression(), !1110)
    #dbg_value(i32 %n, !1104, !DIExpression(), !1110)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1111
    #dbg_value(i32 0, !1107, !DIExpression(), !1110)
  %cmp.not = icmp eq ptr %s, null, !dbg !1112
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1112

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #19, !dbg !1112
  unreachable, !dbg !1112

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1111
    #dbg_value(ptr %call, !1105, !DIExpression(), !1110)
    #dbg_value(i32 0, !1107, !DIExpression(), !1110)
  %cmp130 = icmp ne ptr %call, null, !dbg !1111
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1111
  %0 = and i1 %cmp231, %cmp130, !dbg !1111
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1111

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1111

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1111
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1111

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1105, !DIExpression(), !1110)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1107, !DIExpression(), !1110)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1115, !tbaa !869, !DIAssignID !1117
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1106, !DIExpression(), !1117, ptr %endptr, !DIExpression(), !1110)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1115
  %conv = trunc i64 %call3 to i32, !dbg !1115
    #dbg_value(i32 %conv, !1108, !DIExpression(), !1110)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1118, !tbaa !869
  %3 = load i8, ptr %2, align 1, !dbg !1118, !tbaa !449
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1118
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1115

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1115

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1120, !tbaa !869
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1120
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1120
  br label %if.end9, !dbg !1120

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1115
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1115, !tbaa !375
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1115
    #dbg_value(i64 %indvars.iv.next, !1107, !DIExpression(), !1110)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1115
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1115
  store i8 10, ptr %arrayidx11, align 1, !dbg !1115, !tbaa !449
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1115
    #dbg_value(ptr %call12, !1105, !DIExpression(), !1110)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1111
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1111
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1111
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1111, !llvm.loop !1122

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1111

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1111

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1111

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1111

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1123
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1123
  store i8 10, ptr %arrayidx17, align 1, !dbg !1123, !tbaa !449
  br label %if.end18, !dbg !1123

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1111
  ret i32 0, !dbg !1111
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1126 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1138
    #dbg_assign(i1 undef, !1135, !DIExpression(), !1138, ptr %endptr, !DIExpression(), !1139)
    #dbg_value(ptr %s, !1131, !DIExpression(), !1139)
    #dbg_value(ptr %arr, !1132, !DIExpression(), !1139)
    #dbg_value(i32 %n, !1133, !DIExpression(), !1139)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1140
    #dbg_value(i32 0, !1136, !DIExpression(), !1139)
  %cmp.not = icmp eq ptr %s, null, !dbg !1141
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1141

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #19, !dbg !1141
  unreachable, !dbg !1141

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1140
    #dbg_value(ptr %call, !1134, !DIExpression(), !1139)
    #dbg_value(i32 0, !1136, !DIExpression(), !1139)
  %cmp129 = icmp ne ptr %call, null, !dbg !1140
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1140
  %0 = and i1 %cmp230, %cmp129, !dbg !1140
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1140

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1140

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1140
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1140

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1134, !DIExpression(), !1139)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1136, !DIExpression(), !1139)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1144, !tbaa !869, !DIAssignID !1146
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1135, !DIExpression(), !1146, ptr %endptr, !DIExpression(), !1139)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1144
    #dbg_value(i64 %call3, !1137, !DIExpression(), !1139)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1147, !tbaa !869
  %3 = load i8, ptr %2, align 1, !dbg !1147, !tbaa !449
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1147
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1144

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1144

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1149, !tbaa !869
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1149
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1149
  br label %if.end8, !dbg !1149

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1144
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1144, !tbaa !1034
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1144
    #dbg_value(i64 %indvars.iv.next, !1136, !DIExpression(), !1139)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1144
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1144
  store i8 10, ptr %arrayidx10, align 1, !dbg !1144, !tbaa !449
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1144
    #dbg_value(ptr %call11, !1134, !DIExpression(), !1139)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1140
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1140
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1140
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1140, !llvm.loop !1151

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1140

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1140

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1140

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1140

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1152
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1152
  store i8 10, ptr %arrayidx16, align 1, !dbg !1152, !tbaa !449
  br label %if.end17, !dbg !1152

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1140
  ret i32 0, !dbg !1140
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1155 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #19, !dbg !1170
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
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1173, !tbaa !869, !DIAssignID !1175
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1164, !DIExpression(), !1175, ptr %endptr, !DIExpression(), !1168)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1173
    #dbg_value(float %call3, !1166, !DIExpression(), !1168)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1176, !tbaa !869
  %3 = load i8, ptr %2, align 1, !dbg !1176, !tbaa !449
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1176
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1173

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1173

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1178, !tbaa !869
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1178
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1178
  br label %if.end8, !dbg !1178

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1173
  store float %call3, ptr %arrayidx, align 4, !dbg !1173, !tbaa !1180
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1173
    #dbg_value(i64 %indvars.iv.next, !1165, !DIExpression(), !1168)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1173
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1173
  store i8 10, ptr %arrayidx10, align 1, !dbg !1173, !tbaa !449
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1173
    #dbg_value(ptr %call11, !1163, !DIExpression(), !1168)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1169
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1169
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1169
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1169, !llvm.loop !1182

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
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1183
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1183
  store i8 10, ptr %arrayidx16, align 1, !dbg !1183, !tbaa !449
  br label %if.end17, !dbg !1183

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1169
  ret i32 0, !dbg !1169
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1186 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1189 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1200
    #dbg_assign(i1 undef, !1197, !DIExpression(), !1200, ptr %endptr, !DIExpression(), !1201)
    #dbg_value(ptr %s, !1193, !DIExpression(), !1201)
    #dbg_value(ptr %arr, !1194, !DIExpression(), !1201)
    #dbg_value(i32 %n, !1195, !DIExpression(), !1201)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1202
    #dbg_value(i32 0, !1198, !DIExpression(), !1201)
  %cmp.not = icmp eq ptr %s, null, !dbg !1203
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1203

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #19, !dbg !1203
  unreachable, !dbg !1203

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1202
    #dbg_value(ptr %call, !1196, !DIExpression(), !1201)
    #dbg_value(i32 0, !1198, !DIExpression(), !1201)
  %cmp129 = icmp ne ptr %call, null, !dbg !1202
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1202
  %0 = and i1 %cmp230, %cmp129, !dbg !1202
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1202

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1202

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1202
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1202

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1196, !DIExpression(), !1201)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1198, !DIExpression(), !1201)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1206, !tbaa !869, !DIAssignID !1208
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1197, !DIExpression(), !1208, ptr %endptr, !DIExpression(), !1201)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1206
    #dbg_value(double %call3, !1199, !DIExpression(), !1201)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1209, !tbaa !869
  %3 = load i8, ptr %2, align 1, !dbg !1209, !tbaa !449
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1209
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1206

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1206

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1211, !tbaa !869
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1211
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1211
  br label %if.end8, !dbg !1211

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1206
  store double %call3, ptr %arrayidx, align 8, !dbg !1206, !tbaa !370
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1206
    #dbg_value(i64 %indvars.iv.next, !1198, !DIExpression(), !1201)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1206
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1206
  store i8 10, ptr %arrayidx10, align 1, !dbg !1206, !tbaa !449
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1206
    #dbg_value(ptr %call11, !1196, !DIExpression(), !1201)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1202
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1202
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1202
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1202, !llvm.loop !1213

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1202

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1202

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1202

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1202

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1214
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1214
  store i8 10, ptr %arrayidx16, align 1, !dbg !1214, !tbaa !449
  br label %if.end17, !dbg !1214

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1202
  ret i32 0, !dbg !1202
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1217 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1220 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1224, !DIExpression(), !1229)
    #dbg_value(ptr %arr, !1225, !DIExpression(), !1229)
    #dbg_value(i32 %n, !1226, !DIExpression(), !1229)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1230
  br i1 %cmp, label %if.end, label %if.else, !dbg !1230

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1230
  unreachable, !dbg !1230

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1233
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1235

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1235

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #22, !dbg !1236
  %conv = trunc i64 %call to i32, !dbg !1236
    #dbg_value(i32 %conv, !1226, !DIExpression(), !1229)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1238

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1226, !DIExpression(), !1229)
    #dbg_value(i32 0, !1228, !DIExpression(), !1229)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1239
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1240

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1240

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1240

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1241

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1242
    #dbg_value(i32 %add, !1228, !DIExpression(), !1229)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1239
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1240, !llvm.loop !1244

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1240

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1240

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1228, !DIExpression(), !1229)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1246
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1246
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1247
  %conv6 = sext i32 %sub to i64, !dbg !1248
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #18, !dbg !1249
  %conv8 = trunc i64 %call7 to i32, !dbg !1249
    #dbg_value(i32 %conv8, !1227, !DIExpression(), !1229)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1250
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1228, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1229)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1250

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1250
  unreachable, !dbg !1250

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #18, !dbg !1253
  %conv16 = trunc i64 %call15 to i32, !dbg !1253
    #dbg_value(i32 %conv16, !1227, !DIExpression(), !1229)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1255
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1255

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1255
  unreachable, !dbg !1255

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1258
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1259, !llvm.loop !1260

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1259

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1262
}

; Function Attrs: nofree
declare !dbg !1263 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #9

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1268 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1272, !DIExpression(), !1276)
    #dbg_value(ptr %arr, !1273, !DIExpression(), !1276)
    #dbg_value(i32 %n, !1274, !DIExpression(), !1276)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1277
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1277

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1275, !DIExpression(), !1276)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1280
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1283

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1283

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1280
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1283

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #19, !dbg !1277
  unreachable, !dbg !1277

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1275, !DIExpression(), !1276)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1284
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1284, !tbaa !449
  %conv = zext i8 %0 to i32, !dbg !1284
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1284
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1280
    #dbg_value(i64 %indvars.iv.next, !1275, !DIExpression(), !1276)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1280
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1283, !llvm.loop !1286

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1283

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1283

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1287
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #14 !dbg !1288 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1305
    #dbg_assign(i1 undef, !1294, !DIExpression(), !1305, ptr %args, !DIExpression(), !1306)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1307
    #dbg_assign(i1 undef, !1301, !DIExpression(), !1307, ptr %buffer, !DIExpression(), !1306)
    #dbg_value(i32 %fd, !1292, !DIExpression(), !1306)
    #dbg_value(ptr %format, !1293, !DIExpression(), !1306)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #18, !dbg !1308
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1309
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1310
  %0 = load ptr, ptr %args, align 8, !dbg !1311, !tbaa !869
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #18, !dbg !1312
    #dbg_value(i32 %call, !1298, !DIExpression(), !1306)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1313
  %cmp = icmp slt i32 %call, 256, !dbg !1314
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1314

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1299, !DIExpression(), !1306)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1317
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1318

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1318

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1318

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1314
  unreachable, !dbg !1314

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1319
    #dbg_value(i32 %add, !1299, !DIExpression(), !1306)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1317
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1318, !llvm.loop !1321

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1318

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1318

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1299, !DIExpression(), !1306)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1323
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1323
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1324
  %conv = sext i32 %sub to i64, !dbg !1325
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #18, !dbg !1326
  %conv3 = trunc i64 %call2 to i32, !dbg !1326
    #dbg_value(i32 %conv3, !1300, !DIExpression(), !1306)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1327
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1299, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1306)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1327

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1327
  unreachable, !dbg !1327

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1330
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1330

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1330
  unreachable, !dbg !1330

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1333
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #18, !dbg !1333
  ret void, !dbg !1334
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #15

; Function Attrs: nofree nounwind
declare !dbg !1335 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #7

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1340 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #19, !dbg !1349
  unreachable, !dbg !1349

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1347, !DIExpression(), !1348)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1356
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1356, !tbaa !974
  %conv = zext i16 %0 to i32, !dbg !1356
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1356
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
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1360 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #19, !dbg !1369
  unreachable, !dbg !1369

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1367, !DIExpression(), !1368)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1376
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1376, !tbaa !375
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1376
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
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1380 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #19, !dbg !1389
  unreachable, !dbg !1389

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1387, !DIExpression(), !1388)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1396
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1396, !tbaa !1034
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1396
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
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1400 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1404, !DIExpression(), !1408)
    #dbg_value(ptr %arr, !1405, !DIExpression(), !1408)
    #dbg_value(i32 %n, !1406, !DIExpression(), !1408)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1409
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1409

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1407, !DIExpression(), !1408)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1412
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1415

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1415

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1412
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1415

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #19, !dbg !1409
  unreachable, !dbg !1409

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1407, !DIExpression(), !1408)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1416
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1416, !tbaa !449
  %conv = sext i8 %0 to i32, !dbg !1416
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1416
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1412
    #dbg_value(i64 %indvars.iv.next, !1407, !DIExpression(), !1408)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1412
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1415, !llvm.loop !1418

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1415

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1415

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1419
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1420 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1424, !DIExpression(), !1428)
    #dbg_value(ptr %arr, !1425, !DIExpression(), !1428)
    #dbg_value(i32 %n, !1426, !DIExpression(), !1428)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1429
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1429

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1427, !DIExpression(), !1428)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1432
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1435

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1435

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1432
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1435

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #19, !dbg !1429
  unreachable, !dbg !1429

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1427, !DIExpression(), !1428)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1436
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1436, !tbaa !974
  %conv = sext i16 %0 to i32, !dbg !1436
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1436
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1432
    #dbg_value(i64 %indvars.iv.next, !1427, !DIExpression(), !1428)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1432
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1435, !llvm.loop !1438

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1435

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1435

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1439
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !572 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !571, !DIExpression(), !1440)
    #dbg_value(ptr %arr, !576, !DIExpression(), !1440)
    #dbg_value(i32 %n, !577, !DIExpression(), !1440)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1441
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1441

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !578, !DIExpression(), !1440)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1444
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1445

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1445

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1444
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1445

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #19, !dbg !1441
  unreachable, !dbg !1441

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !578, !DIExpression(), !1440)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1446
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1446, !tbaa !375
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1446
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1444
    #dbg_value(i64 %indvars.iv.next, !578, !DIExpression(), !1440)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1444
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1445, !llvm.loop !1447

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1445

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1445

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1448
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1449 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1453, !DIExpression(), !1457)
    #dbg_value(ptr %arr, !1454, !DIExpression(), !1457)
    #dbg_value(i32 %n, !1455, !DIExpression(), !1457)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1458
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1458

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1456, !DIExpression(), !1457)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1461
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1464

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1464

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1461
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1464

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #19, !dbg !1458
  unreachable, !dbg !1458

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1456, !DIExpression(), !1457)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1465
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1465, !tbaa !1034
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1465
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1461
    #dbg_value(i64 %indvars.iv.next, !1456, !DIExpression(), !1457)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1461
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1464, !llvm.loop !1467

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1464

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1464

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1468
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1469 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1473, !DIExpression(), !1477)
    #dbg_value(ptr %arr, !1474, !DIExpression(), !1477)
    #dbg_value(i32 %n, !1475, !DIExpression(), !1477)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1478
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1478

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1476, !DIExpression(), !1477)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1481
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1484

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1484

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1481
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1484

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #19, !dbg !1478
  unreachable, !dbg !1478

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1476, !DIExpression(), !1477)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1485
  %0 = load float, ptr %arrayidx, align 4, !dbg !1485, !tbaa !1180
  %conv = fpext float %0 to double, !dbg !1485
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1485
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1481
    #dbg_value(i64 %indvars.iv.next, !1476, !DIExpression(), !1477)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1481
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1484, !llvm.loop !1487

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1484

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1484

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1488
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !551 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !550, !DIExpression(), !1489)
    #dbg_value(ptr %arr, !555, !DIExpression(), !1489)
    #dbg_value(i32 %n, !556, !DIExpression(), !1489)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1490
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1490

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !557, !DIExpression(), !1489)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1493
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1494

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1494

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1493
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1494

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #19, !dbg !1490
  unreachable, !dbg !1490

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !557, !DIExpression(), !1489)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1495
  %0 = load double, ptr %arrayidx, align 8, !dbg !1495, !tbaa !370
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1495
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1493
    #dbg_value(i64 %indvars.iv.next, !557, !DIExpression(), !1489)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1493
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1494, !llvm.loop !1496

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1494

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1494

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1497
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !540 {
entry.split:
    #dbg_value(i32 %fd, !539, !DIExpression(), !1498)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1499
  br i1 %cmp, label %if.end, label %if.else, !dbg !1499

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1499
  unreachable, !dbg !1499

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1500
  ret i32 0, !dbg !1501
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #1 !dbg !1502 {
entry.split:
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.012.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem72 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem74 = alloca ptr, align 8
  %i.041.i.i.reg2mem76 = alloca i32, align 4
  %indvars.iv.i.i3.reg2mem = alloca i64, align 8
  %sum.0.lcssa.i.i.reg2mem = alloca double, align 8
  %sum.028.i.i.reg2mem = alloca double, align 8
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %indvars.iv31.i.i.reg2mem78 = alloca i64, align 8
  %.reg2mem80 = alloca i32, align 4
  %check_file.0.reg2mem82 = alloca ptr, align 8
  %in_file.011.reg2mem84 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1506, !DIExpression(), !1515)
    #dbg_value(ptr %argv, !1507, !DIExpression(), !1515)
  %cmp = icmp slt i32 %argc, 4, !dbg !1516
  br i1 %cmp, label %if.end, label %if.else, !dbg !1516

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.15, ptr noundef nonnull @.str.2.16, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1516
  unreachable, !dbg !1516

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1508, !DIExpression(), !1515)
    #dbg_value(ptr @.str.4.17, !1509, !DIExpression(), !1515)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1519
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1521

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.17, ptr %check_file.0.reg2mem82, align 8
  store ptr @.str.3, ptr %in_file.011.reg2mem84, align 8
  br label %if.end7, !dbg !1521

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1522
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1522
    #dbg_value(ptr %0, !1508, !DIExpression(), !1515)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1523
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1525

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.17, ptr %check_file.0.reg2mem82, align 8
  store ptr %0, ptr %in_file.011.reg2mem84, align 8
  br label %if.end7, !dbg !1525

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1526
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1526
    #dbg_value(ptr %1, !1509, !DIExpression(), !1515)
  store ptr %1, ptr %check_file.0.reg2mem82, align 8
  store ptr %0, ptr %in_file.011.reg2mem84, align 8
  br label %if.end7, !dbg !1527

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem82.0.check_file.0.reload83, !1509, !DIExpression(), !1515)
  %in_file.011.reg2mem84.0.in_file.011.reload85 = load ptr, ptr %in_file.011.reg2mem84, align 8
  %check_file.0.reg2mem82.0.check_file.0.reload83 = load ptr, ptr %check_file.0.reg2mem82, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1528, !tbaa !375
  %conv = sext i32 %2 to i64, !dbg !1528
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #20, !dbg !1529
    #dbg_value(ptr %call, !1511, !DIExpression(), !1515)
  %cmp8.not = icmp eq ptr %call, null, !dbg !1530
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1530

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.18, ptr noundef nonnull @.str.2.16, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1530
  unreachable, !dbg !1530

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.011.reg2mem84.0.in_file.011.reload85, i32 noundef signext 0) #18, !dbg !1533
    #dbg_value(i32 %call14, !1510, !DIExpression(), !1515)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1534
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1534

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.19, ptr noundef nonnull @.str.2.16, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1534
  unreachable, !dbg !1534

if.end20:                                         ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #18, !dbg !1537
    #dbg_value(ptr %call, !395, !DIExpression(), !1538)
    #dbg_value(ptr %call, !396, !DIExpression(), !1538)
  %cols.i = getelementptr inbounds i8, ptr %call, i64 13328, !dbg !1540
  %rowDelimiters.i = getelementptr inbounds i8, ptr %call, i64 19992, !dbg !1541
  %vec.i = getelementptr inbounds i8, ptr %call, i64 21976, !dbg !1542
  %out.i = getelementptr inbounds i8, ptr %call, i64 25928, !dbg !1543
    #dbg_value(ptr %call, !340, !DIExpression(), !1544)
    #dbg_value(ptr %cols.i, !341, !DIExpression(), !1544)
    #dbg_value(ptr %rowDelimiters.i, !342, !DIExpression(), !1544)
    #dbg_value(ptr %vec.i, !343, !DIExpression(), !1544)
    #dbg_value(ptr %out.i, !344, !DIExpression(), !1544)
    #dbg_label(!349, !1546)
    #dbg_value(i32 0, !345, !DIExpression(), !1544)
  %.pre.i.i = load i32, ptr %rowDelimiters.i, align 4, !dbg !1547
  store i64 0, ptr %indvars.iv31.i.i.reg2mem78, align 8
  store i32 %.pre.i.i, ptr %.reg2mem80, align 4
  br label %for.body.i.i, !dbg !1548

for.body.i.i:                                     ; preds = %for.end.i.i.for.body.i.i_crit_edge, %if.end20
    #dbg_value(i64 %indvars.iv31.i.i.reg2mem78.0.load, !345, !DIExpression(), !1544)
    #dbg_value(double 0.000000e+00, !347, !DIExpression(), !1544)
    #dbg_value(double 0.000000e+00, !348, !DIExpression(), !1544)
    #dbg_value(i32 %.reg2mem80.0.load, !350, !DIExpression(), !1549)
  %.reg2mem80.0.load = load i32, ptr %.reg2mem80, align 4
  %indvars.iv31.i.i.reg2mem78.0.load = load i64, ptr %indvars.iv31.i.i.reg2mem78, align 8
  %indvars.iv.next32.i.i = add nuw nsw i64 %indvars.iv31.i.i.reg2mem78.0.load, 1, !dbg !1550
  %arrayidx2.i.i = getelementptr inbounds i32, ptr %rowDelimiters.i, i64 %indvars.iv.next32.i.i, !dbg !1551
  %3 = load i32, ptr %arrayidx2.i.i, align 4, !dbg !1551
    #dbg_value(i32 %3, !354, !DIExpression(), !1549)
    #dbg_label(!355, !1552)
    #dbg_value(i32 %.reg2mem80.0.load, !346, !DIExpression(), !1544)
  %cmp427.i.i = icmp slt i32 %.reg2mem80.0.load, %3, !dbg !1553
  br i1 %cmp427.i.i, label %for.body5.preheader.i.i, label %for.body.i.i.for.end.i.i_crit_edge, !dbg !1554

for.body.i.i.for.end.i.i_crit_edge:               ; preds = %for.body.i.i
  store double 0.000000e+00, ptr %sum.0.lcssa.i.i.reg2mem, align 8
  br label %for.end.i.i, !dbg !1554

for.body5.preheader.i.i:                          ; preds = %for.body.i.i
  %4 = sext i32 %.reg2mem80.0.load to i64, !dbg !1554
  %wide.trip.count.i.i = sext i32 %3 to i64, !dbg !1553
  store double 0.000000e+00, ptr %sum.028.i.i.reg2mem, align 8
  store i64 %4, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body5.i.i, !dbg !1554

for.body5.i.i:                                    ; preds = %for.body5.i.i.for.body5.i.i_crit_edge, %for.body5.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !346, !DIExpression(), !1544)
    #dbg_value(double %sum.028.i.i.reg2mem.0.sum.028.i.i.reload, !347, !DIExpression(), !1544)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %sum.028.i.i.reg2mem.0.sum.028.i.i.reload = load double, ptr %sum.028.i.i.reg2mem, align 8
  %arrayidx7.i.i = getelementptr inbounds double, ptr %call, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !1555
  %5 = load double, ptr %arrayidx7.i.i, align 8, !dbg !1555, !tbaa !370
  %arrayidx9.i.i = getelementptr inbounds i32, ptr %cols.i, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !1556
  %6 = load i32, ptr %arrayidx9.i.i, align 4, !dbg !1556, !tbaa !375
  %idxprom10.i.i = sext i32 %6 to i64, !dbg !1557
  %arrayidx11.i.i = getelementptr inbounds double, ptr %vec.i, i64 %idxprom10.i.i, !dbg !1557
  %7 = load double, ptr %arrayidx11.i.i, align 8, !dbg !1557, !tbaa !370
  %mul.i.i = fmul double %5, %7, !dbg !1558
    #dbg_value(double %mul.i.i, !348, !DIExpression(), !1544)
  %add12.i.i = fadd double %sum.028.i.i.reg2mem.0.sum.028.i.i.reload, %mul.i.i, !dbg !1559
    #dbg_value(double %add12.i.i, !347, !DIExpression(), !1544)
  %indvars.iv.next.i.i = add nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !1560
    #dbg_value(i64 %indvars.iv.next.i.i, !346, !DIExpression(), !1544)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, %wide.trip.count.i.i, !dbg !1553
  br i1 %exitcond.not.i.i, label %for.body5.i.i.for.end.i.i_crit_edge, label %for.body5.i.i.for.body5.i.i_crit_edge, !dbg !1554, !llvm.loop !1561

for.body5.i.i.for.body5.i.i_crit_edge:            ; preds = %for.body5.i.i
  store double %add12.i.i, ptr %sum.028.i.i.reg2mem, align 8
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body5.i.i, !dbg !1554

for.body5.i.i.for.end.i.i_crit_edge:              ; preds = %for.body5.i.i
  store double %add12.i.i, ptr %sum.0.lcssa.i.i.reg2mem, align 8
  br label %for.end.i.i, !dbg !1554

for.end.i.i:                                      ; preds = %for.body5.i.i.for.end.i.i_crit_edge, %for.body.i.i.for.end.i.i_crit_edge
  %sum.0.lcssa.i.i.reg2mem.0.sum.0.lcssa.i.i.reload = load double, ptr %sum.0.lcssa.i.i.reg2mem, align 8
  %arrayidx14.i.i = getelementptr inbounds double, ptr %out.i, i64 %indvars.iv31.i.i.reg2mem78.0.load, !dbg !1563
  store double %sum.0.lcssa.i.i.reg2mem.0.sum.0.lcssa.i.i.reload, ptr %arrayidx14.i.i, align 8, !dbg !1564, !tbaa !370
    #dbg_value(i64 %indvars.iv.next32.i.i, !345, !DIExpression(), !1544)
  %exitcond33.not.i.i = icmp eq i64 %indvars.iv.next32.i.i, 494, !dbg !1565
  br i1 %exitcond33.not.i.i, label %run_benchmark.exit, label %for.end.i.i.for.body.i.i_crit_edge, !dbg !1548, !llvm.loop !1566

for.end.i.i.for.body.i.i_crit_edge:               ; preds = %for.end.i.i
  store i64 %indvars.iv.next32.i.i, ptr %indvars.iv31.i.i.reg2mem78, align 8
  store i32 %3, ptr %.reg2mem80, align 4
  br label %for.body.i.i, !dbg !1548

run_benchmark.exit:                               ; preds = %for.end.i.i
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #18, !dbg !1568
    #dbg_value(i32 %call21, !1512, !DIExpression(), !1515)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1569
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1569

if.else26:                                        ; preds = %run_benchmark.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.16, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1569
  unreachable, !dbg !1569

if.end27:                                         ; preds = %run_benchmark.exit
    #dbg_value(i32 %call21, !642, !DIExpression(), !1572)
    #dbg_value(ptr %call, !643, !DIExpression(), !1572)
    #dbg_value(ptr %call, !644, !DIExpression(), !1572)
    #dbg_value(i32 %call21, !539, !DIExpression(), !1574)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1576
  br i1 %cmp.i.i.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1576

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1576
  unreachable, !dbg !1576

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1577
    #dbg_value(i32 %call21, !550, !DIExpression(), !1578)
    #dbg_value(ptr %out.i, !555, !DIExpression(), !1578)
    #dbg_value(i32 494, !556, !DIExpression(), !1578)
    #dbg_value(i32 0, !557, !DIExpression(), !1578)
  store i64 0, ptr %indvars.iv.i.i3.reg2mem, align 8
  br label %for.body.i.i2, !dbg !1580

for.body.i.i2:                                    ; preds = %for.body.i.i2.for.body.i.i2_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i3.reg2mem.0.load, !557, !DIExpression(), !1578)
  %indvars.iv.i.i3.reg2mem.0.load = load i64, ptr %indvars.iv.i.i3.reg2mem, align 8
  %arrayidx.i.i = getelementptr inbounds double, ptr %out.i, i64 %indvars.iv.i.i3.reg2mem.0.load, !dbg !1581
  %8 = load double, ptr %arrayidx.i.i, align 8, !dbg !1581, !tbaa !370
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.21, double noundef %8), !dbg !1581
  %indvars.iv.next.i.i4 = add nuw nsw i64 %indvars.iv.i.i3.reg2mem.0.load, 1, !dbg !1582
    #dbg_value(i64 %indvars.iv.next.i.i4, !557, !DIExpression(), !1578)
  %exitcond.not.i.i5 = icmp eq i64 %indvars.iv.next.i.i4, 494, !dbg !1582
  br i1 %exitcond.not.i.i5, label %data_to_output.exit, label %for.body.i.i2.for.body.i.i2_crit_edge, !dbg !1580, !llvm.loop !1583

for.body.i.i2.for.body.i.i2_crit_edge:            ; preds = %for.body.i.i2
  store i64 %indvars.iv.next.i.i4, ptr %indvars.iv.i.i3.reg2mem, align 8
  br label %for.body.i.i2, !dbg !1580

data_to_output.exit:                              ; preds = %for.body.i.i2
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #18, !dbg !1584
  %9 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1585, !tbaa !375
  %conv29 = sext i32 %9 to i64, !dbg !1585
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #20, !dbg !1586
    #dbg_value(ptr %call30, !1514, !DIExpression(), !1515)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1587
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1587

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.20, ptr noundef nonnull @.str.2.16, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1587
  unreachable, !dbg !1587

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem82.0.check_file.0.reload83, i32 noundef signext 0) #18, !dbg !1590
    #dbg_value(i32 %call37, !1513, !DIExpression(), !1515)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1591
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1591

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.21, ptr noundef nonnull @.str.2.16, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1591
  unreachable, !dbg !1591

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !611, !DIExpression(), !1594)
    #dbg_value(ptr %call30, !612, !DIExpression(), !1594)
    #dbg_value(ptr %call30, !613, !DIExpression(), !1594)
  %call.i = tail call ptr @readfile(i32 noundef signext %call37) #18, !dbg !1596
    #dbg_value(ptr %call.i, !614, !DIExpression(), !1594)
    #dbg_value(ptr %call.i, !439, !DIExpression(), !1597)
    #dbg_value(i32 1, !444, !DIExpression(), !1597)
    #dbg_value(i32 0, !445, !DIExpression(), !1597)
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem74, align 8
  store i32 0, ptr %i.041.i.i.reg2mem76, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i.reg2mem76.0.load, !445, !DIExpression(), !1597)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem74.0.s.addr.040.i.i.reload75, !439, !DIExpression(), !1597)
  %i.041.i.i.reg2mem76.0.load = load i32, ptr %i.041.i.i.reg2mem76, align 4
  %s.addr.040.i.i.reg2mem74.0.s.addr.040.i.i.reload75 = load ptr, ptr %s.addr.040.i.i.reg2mem74, align 8
  %10 = load i8, ptr %s.addr.040.i.i.reg2mem74.0.s.addr.040.i.i.reload75, align 1, !dbg !1599, !tbaa !449
  switch i8 %10, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1600

land.rhs.i.i.output_to_data.exit_crit_edge:       ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem74.0.s.addr.040.i.i.reload75, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1600

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem76.0.load, ptr %i.1.i.i.reg2mem72, align 4
  br label %if.end21.i.i, !dbg !1600

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i6 = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem74.0.s.addr.040.i.i.reload75, i64 1, !dbg !1601
  %11 = load i8, ptr %arrayidx11.i.i6, align 1, !dbg !1601, !tbaa !449
  %cmp13.i.i = icmp eq i8 %11, 37, !dbg !1602
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1603

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem76.0.load, ptr %i.1.i.i.reg2mem72, align 4
  br label %if.end21.i.i, !dbg !1603

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem74.0.s.addr.040.i.i.reload75, i64 2, !dbg !1604
  %12 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1604, !tbaa !449
  %cmp18.i.i = icmp eq i8 %12, 10, !dbg !1605
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1606
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem76.0.load, %inc.i.i, !dbg !1606
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem72, align 4
  br label %if.end21.i.i, !dbg !1606

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem72.0.load, !445, !DIExpression(), !1597)
  %i.1.i.i.reg2mem72.0.load = load i32, ptr %i.1.i.i.reg2mem72, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem74.0.s.addr.040.i.i.reload75, i64 1, !dbg !1607
    #dbg_value(ptr %incdec.ptr.i.i, !439, !DIExpression(), !1597)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem72.0.load, 1, !dbg !1608
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1609, !llvm.loop !1610

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem74, align 8
  store i32 %i.1.i.i.reg2mem72.0.load, ptr %i.041.i.i.reg2mem76, align 4
  br label %land.rhs.i.i, !dbg !1609

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i7 = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1612, !tbaa !449
  %13 = icmp eq i8 %.pre.i.i7, 0, !dbg !1613
  %14 = select i1 %13, i64 0, i64 2, !dbg !1614
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %14, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1609

output_to_data.exit:                              ; preds = %land.rhs.i.i.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1614
    #dbg_value(ptr %spec.select38.i.i, !615, !DIExpression(), !1594)
  %out.i8 = getelementptr inbounds i8, ptr %call30, i64 25928, !dbg !1615
  %call2.i = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i.i, ptr noundef nonnull %out.i8, i32 noundef signext 494) #18, !dbg !1616
  tail call void @free(ptr noundef %call.i) #18, !dbg !1617
    #dbg_value(ptr %call, !662, !DIExpression(), !1618)
    #dbg_value(ptr %call30, !663, !DIExpression(), !1618)
    #dbg_value(ptr %call, !664, !DIExpression(), !1618)
    #dbg_value(ptr %call30, !665, !DIExpression(), !1618)
    #dbg_value(i32 0, !666, !DIExpression(), !1618)
    #dbg_value(i32 0, !667, !DIExpression(), !1618)
  store i32 0, ptr %has_errors.012.i.reg2mem, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1621

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %output_to_data.exit
    #dbg_value(i32 %has_errors.012.i.reg2mem.0.load, !666, !DIExpression(), !1618)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !667, !DIExpression(), !1618)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %has_errors.012.i.reg2mem.0.load = load i32, ptr %has_errors.012.i.reg2mem, align 4
  %arrayidx.i = getelementptr inbounds %struct.bench_args_t, ptr %call, i64 0, i32 4, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1622
  %15 = load double, ptr %arrayidx.i, align 8, !dbg !1622, !tbaa !370
  %arrayidx3.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 4, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1623
  %16 = load double, ptr %arrayidx3.i, align 8, !dbg !1623, !tbaa !370
  %sub.i = fsub double %15, %16, !dbg !1624
    #dbg_value(double %sub.i, !668, !DIExpression(), !1618)
  %17 = tail call double @llvm.fabs.f64(double %sub.i), !dbg !1625
  %18 = fcmp ogt double %17, 0x3EB0C6F7A0B5ED8D, !dbg !1625
  %lor.ext.i = zext i1 %18 to i32, !dbg !1625
  %or.i = or i32 %has_errors.012.i.reg2mem.0.load, %lor.ext.i, !dbg !1626
    #dbg_value(i32 %or.i, !666, !DIExpression(), !1618)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1627
    #dbg_value(i64 %indvars.iv.next.i, !667, !DIExpression(), !1618)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 494, !dbg !1628
  br i1 %exitcond.not.i, label %check_data.exit, label %for.body.i.for.body.i_crit_edge, !dbg !1621, !llvm.loop !1629

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i32 %or.i, ptr %has_errors.012.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1621

check_data.exit:                                  ; preds = %for.body.i
  %tobool.not.i.not = icmp eq i32 %or.i, 0, !dbg !1631
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1632

if.then45:                                        ; preds = %check_data.exit
  %19 = load ptr, ptr @stderr, align 8, !dbg !1633, !tbaa !869
  %20 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %19) #21, !dbg !1635
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1636

if.end47:                                         ; preds = %check_data.exit
  tail call void @free(ptr noundef nonnull %call) #18, !dbg !1637
  tail call void @free(ptr noundef nonnull %call30) #18, !dbg !1638
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1639
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1640

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1641
}

; Function Attrs: nofree
declare !dbg !1642 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #9

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

!llvm.dbg.cu = !{!238, !188, !240, !301}
!llvm.ident = !{!322, !322, !322, !322}
!llvm.module.flags = !{!323, !324, !325, !326, !327, !329, !330, !331, !332, !333}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/spmv/crs")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/spmv/crs")
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
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !216, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/spmv/crs")
!190 = !{!191}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 21, size: 239040, elements: !194)
!193 = !DIFile(filename: "./spmv.h", directory: "/home/kelvin/MachSuite/spmv/crs")
!194 = !{!195, !200, !207, !211, !215}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "val", scope: !192, file: !193, line: 22, baseType: !196, size: 106624)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 106624, elements: !198)
!197 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!198 = !{!199}
!199 = !DISubrange(count: 1666)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "cols", scope: !192, file: !193, line: 23, baseType: !201, size: 53312, offset: 106624)
!201 = !DICompositeType(tag: DW_TAG_array_type, baseType: !202, size: 53312, elements: !198)
!202 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !203, line: 26, baseType: !204)
!203 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!204 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !205, line: 41, baseType: !206)
!205 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!206 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "rowDelimiters", scope: !192, file: !193, line: 24, baseType: !208, size: 15840, offset: 159936)
!208 = !DICompositeType(tag: DW_TAG_array_type, baseType: !202, size: 15840, elements: !209)
!209 = !{!210}
!210 = !DISubrange(count: 495)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "vec", scope: !192, file: !193, line: 25, baseType: !212, size: 31616, offset: 175808)
!212 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 31616, elements: !213)
!213 = !{!214}
!214 = !DISubrange(count: 494)
!215 = !DIDerivedType(tag: DW_TAG_member, name: "out", scope: !192, file: !193, line: 26, baseType: !212, size: 31616, offset: 207424)
!216 = !{!186}
!217 = !DIGlobalVariableExpression(var: !218, expr: !DIExpression())
!218 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !219, isLocal: true, isDefinition: true)
!219 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!220 = !DIGlobalVariableExpression(var: !221, expr: !DIExpression())
!221 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !222, isLocal: true, isDefinition: true)
!222 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!223 = !DIGlobalVariableExpression(var: !224, expr: !DIExpression())
!224 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !225, isLocal: true, isDefinition: true)
!225 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !226)
!226 = !{!227}
!227 = !DISubrange(count: 12)
!228 = !DIGlobalVariableExpression(var: !229, expr: !DIExpression())
!229 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !230, isLocal: true, isDefinition: true)
!230 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!231 = !DIGlobalVariableExpression(var: !232, expr: !DIExpression())
!232 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!233 = !DIGlobalVariableExpression(var: !234, expr: !DIExpression())
!234 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !235, isLocal: true, isDefinition: true)
!235 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!236 = !DIGlobalVariableExpression(var: !237, expr: !DIExpression())
!237 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!238 = distinct !DICompileUnit(language: DW_LANG_C11, file: !239, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!239 = !DIFile(filename: "spmv.c", directory: "/home/kelvin/MachSuite/spmv/crs")
!240 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !241, globals: !267, splitDebugInlining: false, nameTableKind: None)
!241 = !{!242, !4, !243, !244, !248, !251, !254, !257, !260, !202, !263, !266, !197}
!242 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!243 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!244 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !245, line: 24, baseType: !246)
!245 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!246 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !205, line: 38, baseType: !247)
!247 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!248 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !245, line: 25, baseType: !249)
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !205, line: 40, baseType: !250)
!250 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!251 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !245, line: 26, baseType: !252)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !205, line: 42, baseType: !253)
!253 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!254 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !245, line: 27, baseType: !255)
!255 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !205, line: 45, baseType: !256)
!256 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!257 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !203, line: 24, baseType: !258)
!258 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !205, line: 37, baseType: !259)
!259 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!260 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !203, line: 25, baseType: !261)
!261 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !205, line: 39, baseType: !262)
!262 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!263 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !203, line: 27, baseType: !264)
!264 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !205, line: 44, baseType: !265)
!265 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!266 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!267 = !{!268, !0, !7, !12, !273, !18, !275, !23, !280, !28, !282, !33, !38, !284, !43, !45, !47, !52, !57, !62, !67, !69, !71, !76, !78, !80, !82, !87, !89, !289, !92, !97, !102, !107, !112, !114, !116, !121, !126, !128, !130, !132, !134, !136, !141, !146, !148, !153, !294, !158, !163, !296, !165}
!268 = !DIGlobalVariableExpression(var: !269, expr: !DIExpression())
!269 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !270, isLocal: true, isDefinition: true)
!270 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !271)
!271 = !{!272}
!272 = !DISubrange(count: 24)
!273 = !DIGlobalVariableExpression(var: !274, expr: !DIExpression())
!274 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !30, isLocal: true, isDefinition: true)
!275 = !DIGlobalVariableExpression(var: !276, expr: !DIExpression())
!276 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !277, isLocal: true, isDefinition: true)
!277 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !278)
!278 = !{!279}
!279 = !DISubrange(count: 14)
!280 = !DIGlobalVariableExpression(var: !281, expr: !DIExpression())
!281 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !277, isLocal: true, isDefinition: true)
!282 = !DIGlobalVariableExpression(var: !283, expr: !DIExpression())
!283 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !9, isLocal: true, isDefinition: true)
!284 = !DIGlobalVariableExpression(var: !285, expr: !DIExpression())
!285 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !286, isLocal: true, isDefinition: true)
!286 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !287)
!287 = !{!288}
!288 = !DISubrange(count: 21)
!289 = !DIGlobalVariableExpression(var: !290, expr: !DIExpression())
!290 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !291, isLocal: true, isDefinition: true)
!291 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !292)
!292 = !{!293}
!293 = !DISubrange(count: 13)
!294 = !DIGlobalVariableExpression(var: !295, expr: !DIExpression())
!295 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !20, isLocal: true, isDefinition: true)
!296 = !DIGlobalVariableExpression(var: !297, expr: !DIExpression())
!297 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !298, isLocal: true, isDefinition: true)
!298 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !299)
!299 = !{!300}
!300 = !DISubrange(count: 27)
!301 = distinct !DICompileUnit(language: DW_LANG_C11, file: !170, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !302, globals: !303, splitDebugInlining: false, nameTableKind: None)
!302 = !{!243}
!303 = !{!304, !168, !174, !176, !179, !184, !306, !217, !308, !220, !223, !310, !228, !231, !315, !233, !236, !317}
!304 = !DIGlobalVariableExpression(var: !305, expr: !DIExpression())
!305 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !230, isLocal: true, isDefinition: true)
!306 = !DIGlobalVariableExpression(var: !307, expr: !DIExpression())
!307 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !277, isLocal: true, isDefinition: true)
!308 = !DIGlobalVariableExpression(var: !309, expr: !DIExpression())
!309 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !219, isLocal: true, isDefinition: true)
!310 = !DIGlobalVariableExpression(var: !311, expr: !DIExpression())
!311 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !312, isLocal: true, isDefinition: true)
!312 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !313)
!313 = !{!314}
!314 = !DISubrange(count: 31)
!315 = !DIGlobalVariableExpression(var: !316, expr: !DIExpression())
!316 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !219, isLocal: true, isDefinition: true)
!317 = !DIGlobalVariableExpression(var: !318, expr: !DIExpression())
!318 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !319, isLocal: true, isDefinition: true)
!319 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !320)
!320 = !{!321}
!321 = !DISubrange(count: 10)
!322 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!323 = !{i32 7, !"Dwarf Version", i32 4}
!324 = !{i32 2, !"Debug Info Version", i32 3}
!325 = !{i32 1, !"wchar_size", i32 4}
!326 = !{i32 1, !"target-abi", !"lp64d"}
!327 = distinct !{i32 6, !"riscv-isa", !328}
!328 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!329 = !{i32 8, !"PIC Level", i32 2}
!330 = !{i32 7, !"PIE Level", i32 2}
!331 = !{i32 7, !"uwtable", i32 2}
!332 = !{i32 8, !"SmallDataLimit", i32 8}
!333 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!334 = distinct !DISubprogram(name: "spmv", scope: !239, file: !239, line: 8, type: !335, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !238, retainedNodes: !339)
!335 = !DISubroutineType(types: !336)
!336 = !{null, !337, !338, !338, !337, !337}
!337 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!338 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !202, size: 64)
!339 = !{!340, !341, !342, !343, !344, !345, !346, !347, !348, !349, !350, !354, !355}
!340 = !DILocalVariable(name: "val", arg: 1, scope: !334, file: !239, line: 8, type: !337)
!341 = !DILocalVariable(name: "cols", arg: 2, scope: !334, file: !239, line: 8, type: !338)
!342 = !DILocalVariable(name: "rowDelimiters", arg: 3, scope: !334, file: !239, line: 8, type: !338)
!343 = !DILocalVariable(name: "vec", arg: 4, scope: !334, file: !239, line: 8, type: !337)
!344 = !DILocalVariable(name: "out", arg: 5, scope: !334, file: !239, line: 8, type: !337)
!345 = !DILocalVariable(name: "i", scope: !334, file: !239, line: 9, type: !206)
!346 = !DILocalVariable(name: "j", scope: !334, file: !239, line: 9, type: !206)
!347 = !DILocalVariable(name: "sum", scope: !334, file: !239, line: 10, type: !197)
!348 = !DILocalVariable(name: "Si", scope: !334, file: !239, line: 10, type: !197)
!349 = !DILabel(scope: !334, name: "spmv_1", file: !239, line: 12)
!350 = !DILocalVariable(name: "tmp_begin", scope: !351, file: !239, line: 14, type: !206)
!351 = distinct !DILexicalBlock(scope: !352, file: !239, line: 12, column: 36)
!352 = distinct !DILexicalBlock(scope: !353, file: !239, line: 12, column: 14)
!353 = distinct !DILexicalBlock(scope: !334, file: !239, line: 12, column: 14)
!354 = !DILocalVariable(name: "tmp_end", scope: !351, file: !239, line: 15, type: !206)
!355 = !DILabel(scope: !351, name: "spmv_2", file: !239, line: 16)
!356 = !DILocation(line: 0, scope: !334)
!357 = !DILocation(line: 12, column: 5, scope: !334)
!358 = !DILocation(line: 14, column: 25, scope: !351)
!359 = !DILocation(line: 12, column: 14, scope: !353)
!360 = !DILocation(line: 0, scope: !351)
!361 = !DILocation(line: 15, column: 38, scope: !351)
!362 = !DILocation(line: 15, column: 23, scope: !351)
!363 = !DILocation(line: 16, column: 9, scope: !351)
!364 = !DILocation(line: 16, column: 40, scope: !365)
!365 = distinct !DILexicalBlock(scope: !366, file: !239, line: 16, column: 18)
!366 = distinct !DILexicalBlock(scope: !351, file: !239, line: 16, column: 18)
!367 = !DILocation(line: 16, column: 18, scope: !366)
!368 = !DILocation(line: 17, column: 18, scope: !369)
!369 = distinct !DILexicalBlock(scope: !365, file: !239, line: 16, column: 55)
!370 = !{!371, !371, i64 0}
!371 = !{!"double", !372, i64 0}
!372 = !{!"omnipotent char", !373, i64 0}
!373 = !{!"Simple C/C++ TBAA"}
!374 = !DILocation(line: 17, column: 31, scope: !369)
!375 = !{!376, !376, i64 0}
!376 = !{!"int", !372, i64 0}
!377 = !DILocation(line: 17, column: 27, scope: !369)
!378 = !DILocation(line: 17, column: 25, scope: !369)
!379 = !DILocation(line: 18, column: 23, scope: !369)
!380 = !DILocation(line: 16, column: 52, scope: !365)
!381 = distinct !{!381, !367, !382, !383, !384}
!382 = !DILocation(line: 19, column: 9, scope: !366)
!383 = !{!"llvm.loop.mustprogress"}
!384 = !{!"llvm.loop.unroll.disable"}
!385 = !DILocation(line: 20, column: 9, scope: !351)
!386 = !DILocation(line: 20, column: 16, scope: !351)
!387 = !DILocation(line: 12, column: 27, scope: !352)
!388 = distinct !{!388, !359, !389, !383, !384}
!389 = !DILocation(line: 21, column: 5, scope: !353)
!390 = !DILocation(line: 22, column: 1, scope: !334)
!391 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 8, type: !392, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !394)
!392 = !DISubroutineType(types: !393)
!393 = !{null, !243}
!394 = !{!395, !396}
!395 = !DILocalVariable(name: "vargs", arg: 1, scope: !391, file: !189, line: 8, type: !243)
!396 = !DILocalVariable(name: "args", scope: !391, file: !189, line: 9, type: !191)
!397 = !DILocation(line: 0, scope: !391)
!398 = !DILocation(line: 10, column: 26, scope: !391)
!399 = !DILocation(line: 10, column: 38, scope: !391)
!400 = !DILocation(line: 10, column: 59, scope: !391)
!401 = !DILocation(line: 10, column: 70, scope: !391)
!402 = !DILocation(line: 0, scope: !334, inlinedAt: !403)
!403 = distinct !DILocation(line: 10, column: 3, scope: !391)
!404 = !DILocation(line: 12, column: 5, scope: !334, inlinedAt: !403)
!405 = !DILocation(line: 14, column: 25, scope: !351, inlinedAt: !403)
!406 = !DILocation(line: 12, column: 14, scope: !353, inlinedAt: !403)
!407 = !DILocation(line: 0, scope: !351, inlinedAt: !403)
!408 = !DILocation(line: 15, column: 38, scope: !351, inlinedAt: !403)
!409 = !DILocation(line: 15, column: 23, scope: !351, inlinedAt: !403)
!410 = !DILocation(line: 16, column: 9, scope: !351, inlinedAt: !403)
!411 = !DILocation(line: 16, column: 40, scope: !365, inlinedAt: !403)
!412 = !DILocation(line: 16, column: 18, scope: !366, inlinedAt: !403)
!413 = !DILocation(line: 17, column: 18, scope: !369, inlinedAt: !403)
!414 = !DILocation(line: 17, column: 31, scope: !369, inlinedAt: !403)
!415 = !DILocation(line: 17, column: 27, scope: !369, inlinedAt: !403)
!416 = !DILocation(line: 17, column: 25, scope: !369, inlinedAt: !403)
!417 = !DILocation(line: 18, column: 23, scope: !369, inlinedAt: !403)
!418 = !DILocation(line: 16, column: 52, scope: !365, inlinedAt: !403)
!419 = distinct !{!419, !412, !420, !383, !384}
!420 = !DILocation(line: 19, column: 9, scope: !366, inlinedAt: !403)
!421 = !DILocation(line: 20, column: 9, scope: !351, inlinedAt: !403)
!422 = !DILocation(line: 20, column: 16, scope: !351, inlinedAt: !403)
!423 = !DILocation(line: 12, column: 27, scope: !352, inlinedAt: !403)
!424 = distinct !{!424, !406, !425, !383, !384}
!425 = !DILocation(line: 21, column: 5, scope: !353, inlinedAt: !403)
!426 = !DILocation(line: 11, column: 1, scope: !391)
!427 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 24, type: !428, scopeLine: 24, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !430)
!428 = !DISubroutineType(types: !429)
!429 = !{null, !206, !243}
!430 = !{!431, !432, !433, !434, !435}
!431 = !DILocalVariable(name: "fd", arg: 1, scope: !427, file: !189, line: 24, type: !206)
!432 = !DILocalVariable(name: "vdata", arg: 2, scope: !427, file: !189, line: 24, type: !243)
!433 = !DILocalVariable(name: "data", scope: !427, file: !189, line: 25, type: !191)
!434 = !DILocalVariable(name: "p", scope: !427, file: !189, line: 26, type: !242)
!435 = !DILocalVariable(name: "s", scope: !427, file: !189, line: 26, type: !242)
!436 = !DILocation(line: 0, scope: !427)
!437 = !DILocation(line: 28, column: 3, scope: !427)
!438 = !DILocation(line: 30, column: 7, scope: !427)
!439 = !DILocalVariable(name: "s", arg: 1, scope: !440, file: !2, line: 56, type: !242)
!440 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !441, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !443)
!441 = !DISubroutineType(types: !442)
!442 = !{!242, !242, !206}
!443 = !{!439, !444, !445}
!444 = !DILocalVariable(name: "n", arg: 2, scope: !440, file: !2, line: 56, type: !206)
!445 = !DILocalVariable(name: "i", scope: !440, file: !2, line: 57, type: !206)
!446 = !DILocation(line: 0, scope: !440, inlinedAt: !447)
!447 = distinct !DILocation(line: 32, column: 7, scope: !427)
!448 = !DILocation(line: 64, column: 17, scope: !440, inlinedAt: !447)
!449 = !{!372, !372, i64 0}
!450 = !DILocation(line: 64, column: 3, scope: !440, inlinedAt: !447)
!451 = !DILocation(line: 66, column: 22, scope: !452, inlinedAt: !447)
!452 = distinct !DILexicalBlock(scope: !453, file: !2, line: 66, column: 9)
!453 = distinct !DILexicalBlock(scope: !440, file: !2, line: 64, column: 31)
!454 = !DILocation(line: 66, column: 26, scope: !452, inlinedAt: !447)
!455 = !DILocation(line: 66, column: 32, scope: !452, inlinedAt: !447)
!456 = !DILocation(line: 66, column: 35, scope: !452, inlinedAt: !447)
!457 = !DILocation(line: 66, column: 39, scope: !452, inlinedAt: !447)
!458 = !DILocation(line: 66, column: 9, scope: !453, inlinedAt: !447)
!459 = !DILocation(line: 69, column: 6, scope: !453, inlinedAt: !447)
!460 = !DILocation(line: 64, column: 10, scope: !440, inlinedAt: !447)
!461 = !DILocation(line: 64, column: 13, scope: !440, inlinedAt: !447)
!462 = distinct !{!462, !450, !463, !383, !384}
!463 = !DILocation(line: 70, column: 3, scope: !440, inlinedAt: !447)
!464 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !447)
!465 = distinct !DILexicalBlock(scope: !440, file: !2, line: 71, column: 6)
!466 = !DILocation(line: 71, column: 8, scope: !465, inlinedAt: !447)
!467 = !DILocation(line: 71, column: 6, scope: !440, inlinedAt: !447)
!468 = !DILocation(line: 33, column: 3, scope: !427)
!469 = !DILocation(line: 0, scope: !440, inlinedAt: !470)
!470 = distinct !DILocation(line: 35, column: 7, scope: !427)
!471 = !DILocation(line: 64, column: 17, scope: !440, inlinedAt: !470)
!472 = !DILocation(line: 64, column: 3, scope: !440, inlinedAt: !470)
!473 = !DILocation(line: 66, column: 22, scope: !452, inlinedAt: !470)
!474 = !DILocation(line: 66, column: 26, scope: !452, inlinedAt: !470)
!475 = !DILocation(line: 66, column: 32, scope: !452, inlinedAt: !470)
!476 = !DILocation(line: 66, column: 35, scope: !452, inlinedAt: !470)
!477 = !DILocation(line: 66, column: 39, scope: !452, inlinedAt: !470)
!478 = !DILocation(line: 66, column: 9, scope: !453, inlinedAt: !470)
!479 = !DILocation(line: 69, column: 6, scope: !453, inlinedAt: !470)
!480 = !DILocation(line: 64, column: 10, scope: !440, inlinedAt: !470)
!481 = !DILocation(line: 64, column: 13, scope: !440, inlinedAt: !470)
!482 = distinct !{!482, !472, !483, !383, !384}
!483 = !DILocation(line: 70, column: 3, scope: !440, inlinedAt: !470)
!484 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !470)
!485 = !DILocation(line: 71, column: 8, scope: !465, inlinedAt: !470)
!486 = !DILocation(line: 71, column: 6, scope: !440, inlinedAt: !470)
!487 = !DILocation(line: 36, column: 32, scope: !427)
!488 = !DILocation(line: 36, column: 3, scope: !427)
!489 = !DILocation(line: 0, scope: !440, inlinedAt: !490)
!490 = distinct !DILocation(line: 38, column: 7, scope: !427)
!491 = !DILocation(line: 64, column: 17, scope: !440, inlinedAt: !490)
!492 = !DILocation(line: 64, column: 3, scope: !440, inlinedAt: !490)
!493 = !DILocation(line: 66, column: 22, scope: !452, inlinedAt: !490)
!494 = !DILocation(line: 66, column: 26, scope: !452, inlinedAt: !490)
!495 = !DILocation(line: 66, column: 32, scope: !452, inlinedAt: !490)
!496 = !DILocation(line: 66, column: 35, scope: !452, inlinedAt: !490)
!497 = !DILocation(line: 66, column: 39, scope: !452, inlinedAt: !490)
!498 = !DILocation(line: 66, column: 9, scope: !453, inlinedAt: !490)
!499 = !DILocation(line: 69, column: 6, scope: !453, inlinedAt: !490)
!500 = !DILocation(line: 64, column: 10, scope: !440, inlinedAt: !490)
!501 = !DILocation(line: 64, column: 13, scope: !440, inlinedAt: !490)
!502 = distinct !{!502, !492, !503, !383, !384}
!503 = !DILocation(line: 70, column: 3, scope: !440, inlinedAt: !490)
!504 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !490)
!505 = !DILocation(line: 71, column: 8, scope: !465, inlinedAt: !490)
!506 = !DILocation(line: 71, column: 6, scope: !440, inlinedAt: !490)
!507 = !DILocation(line: 39, column: 32, scope: !427)
!508 = !DILocation(line: 39, column: 3, scope: !427)
!509 = !DILocation(line: 0, scope: !440, inlinedAt: !510)
!510 = distinct !DILocation(line: 41, column: 7, scope: !427)
!511 = !DILocation(line: 64, column: 17, scope: !440, inlinedAt: !510)
!512 = !DILocation(line: 64, column: 3, scope: !440, inlinedAt: !510)
!513 = !DILocation(line: 66, column: 22, scope: !452, inlinedAt: !510)
!514 = !DILocation(line: 66, column: 26, scope: !452, inlinedAt: !510)
!515 = !DILocation(line: 66, column: 32, scope: !452, inlinedAt: !510)
!516 = !DILocation(line: 66, column: 35, scope: !452, inlinedAt: !510)
!517 = !DILocation(line: 66, column: 39, scope: !452, inlinedAt: !510)
!518 = !DILocation(line: 66, column: 9, scope: !453, inlinedAt: !510)
!519 = !DILocation(line: 69, column: 6, scope: !453, inlinedAt: !510)
!520 = !DILocation(line: 64, column: 10, scope: !440, inlinedAt: !510)
!521 = !DILocation(line: 64, column: 13, scope: !440, inlinedAt: !510)
!522 = distinct !{!522, !512, !523, !383, !384}
!523 = !DILocation(line: 70, column: 3, scope: !440, inlinedAt: !510)
!524 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !510)
!525 = !DILocation(line: 71, column: 8, scope: !465, inlinedAt: !510)
!526 = !DILocation(line: 71, column: 6, scope: !440, inlinedAt: !510)
!527 = !DILocation(line: 42, column: 37, scope: !427)
!528 = !DILocation(line: 42, column: 3, scope: !427)
!529 = !DILocation(line: 43, column: 3, scope: !427)
!530 = !DILocation(line: 44, column: 1, scope: !427)
!531 = !DISubprogram(name: "free", scope: !532, file: !532, line: 687, type: !392, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!532 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!533 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 46, type: !428, scopeLine: 46, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !534)
!534 = !{!535, !536, !537}
!535 = !DILocalVariable(name: "fd", arg: 1, scope: !533, file: !189, line: 46, type: !206)
!536 = !DILocalVariable(name: "vdata", arg: 2, scope: !533, file: !189, line: 46, type: !243)
!537 = !DILocalVariable(name: "data", scope: !533, file: !189, line: 47, type: !191)
!538 = !DILocation(line: 0, scope: !533)
!539 = !DILocalVariable(name: "fd", arg: 1, scope: !540, file: !2, line: 189, type: !206)
!540 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !541, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !543)
!541 = !DISubroutineType(types: !542)
!542 = !{!206, !206}
!543 = !{!539}
!544 = !DILocation(line: 0, scope: !540, inlinedAt: !545)
!545 = distinct !DILocation(line: 49, column: 3, scope: !533)
!546 = !DILocation(line: 190, column: 3, scope: !547, inlinedAt: !545)
!547 = distinct !DILexicalBlock(scope: !548, file: !2, line: 190, column: 3)
!548 = distinct !DILexicalBlock(scope: !540, file: !2, line: 190, column: 3)
!549 = !DILocation(line: 191, column: 3, scope: !540, inlinedAt: !545)
!550 = !DILocalVariable(name: "fd", arg: 1, scope: !551, file: !2, line: 187, type: !206)
!551 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !552, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !554)
!552 = !DISubroutineType(types: !553)
!553 = !{!206, !206, !337, !206}
!554 = !{!550, !555, !556, !557}
!555 = !DILocalVariable(name: "arr", arg: 2, scope: !551, file: !2, line: 187, type: !337)
!556 = !DILocalVariable(name: "n", arg: 3, scope: !551, file: !2, line: 187, type: !206)
!557 = !DILocalVariable(name: "i", scope: !551, file: !2, line: 187, type: !206)
!558 = !DILocation(line: 0, scope: !551, inlinedAt: !559)
!559 = distinct !DILocation(line: 50, column: 3, scope: !533)
!560 = !DILocation(line: 187, column: 1, scope: !561, inlinedAt: !559)
!561 = distinct !DILexicalBlock(scope: !551, file: !2, line: 187, column: 1)
!562 = !DILocation(line: 187, column: 1, scope: !563, inlinedAt: !559)
!563 = distinct !DILexicalBlock(scope: !564, file: !2, line: 187, column: 1)
!564 = distinct !DILexicalBlock(scope: !561, file: !2, line: 187, column: 1)
!565 = !DILocation(line: 187, column: 1, scope: !564, inlinedAt: !559)
!566 = distinct !{!566, !560, !560, !383, !384}
!567 = !DILocation(line: 0, scope: !540, inlinedAt: !568)
!568 = distinct !DILocation(line: 52, column: 3, scope: !533)
!569 = !DILocation(line: 191, column: 3, scope: !540, inlinedAt: !568)
!570 = !DILocation(line: 53, column: 33, scope: !533)
!571 = !DILocalVariable(name: "fd", arg: 1, scope: !572, file: !2, line: 183, type: !206)
!572 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !573, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !575)
!573 = !DISubroutineType(types: !574)
!574 = !{!206, !206, !338, !206}
!575 = !{!571, !576, !577, !578}
!576 = !DILocalVariable(name: "arr", arg: 2, scope: !572, file: !2, line: 183, type: !338)
!577 = !DILocalVariable(name: "n", arg: 3, scope: !572, file: !2, line: 183, type: !206)
!578 = !DILocalVariable(name: "i", scope: !572, file: !2, line: 183, type: !206)
!579 = !DILocation(line: 0, scope: !572, inlinedAt: !580)
!580 = distinct !DILocation(line: 53, column: 3, scope: !533)
!581 = !DILocation(line: 183, column: 1, scope: !582, inlinedAt: !580)
!582 = distinct !DILexicalBlock(scope: !572, file: !2, line: 183, column: 1)
!583 = !DILocation(line: 183, column: 1, scope: !584, inlinedAt: !580)
!584 = distinct !DILexicalBlock(scope: !585, file: !2, line: 183, column: 1)
!585 = distinct !DILexicalBlock(scope: !582, file: !2, line: 183, column: 1)
!586 = !DILocation(line: 183, column: 1, scope: !585, inlinedAt: !580)
!587 = distinct !{!587, !581, !581, !383, !384}
!588 = !DILocation(line: 0, scope: !540, inlinedAt: !589)
!589 = distinct !DILocation(line: 55, column: 3, scope: !533)
!590 = !DILocation(line: 191, column: 3, scope: !540, inlinedAt: !589)
!591 = !DILocation(line: 56, column: 33, scope: !533)
!592 = !DILocation(line: 0, scope: !572, inlinedAt: !593)
!593 = distinct !DILocation(line: 56, column: 3, scope: !533)
!594 = !DILocation(line: 183, column: 1, scope: !582, inlinedAt: !593)
!595 = !DILocation(line: 183, column: 1, scope: !584, inlinedAt: !593)
!596 = !DILocation(line: 183, column: 1, scope: !585, inlinedAt: !593)
!597 = distinct !{!597, !594, !594, !383, !384}
!598 = !DILocation(line: 0, scope: !540, inlinedAt: !599)
!599 = distinct !DILocation(line: 58, column: 3, scope: !533)
!600 = !DILocation(line: 191, column: 3, scope: !540, inlinedAt: !599)
!601 = !DILocation(line: 59, column: 38, scope: !533)
!602 = !DILocation(line: 0, scope: !551, inlinedAt: !603)
!603 = distinct !DILocation(line: 59, column: 3, scope: !533)
!604 = !DILocation(line: 187, column: 1, scope: !561, inlinedAt: !603)
!605 = !DILocation(line: 187, column: 1, scope: !563, inlinedAt: !603)
!606 = !DILocation(line: 187, column: 1, scope: !564, inlinedAt: !603)
!607 = distinct !{!607, !604, !604, !383, !384}
!608 = !DILocation(line: 60, column: 1, scope: !533)
!609 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 67, type: !428, scopeLine: 67, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !610)
!610 = !{!611, !612, !613, !614, !615}
!611 = !DILocalVariable(name: "fd", arg: 1, scope: !609, file: !189, line: 67, type: !206)
!612 = !DILocalVariable(name: "vdata", arg: 2, scope: !609, file: !189, line: 67, type: !243)
!613 = !DILocalVariable(name: "data", scope: !609, file: !189, line: 68, type: !191)
!614 = !DILocalVariable(name: "p", scope: !609, file: !189, line: 69, type: !242)
!615 = !DILocalVariable(name: "s", scope: !609, file: !189, line: 69, type: !242)
!616 = !DILocation(line: 0, scope: !609)
!617 = !DILocation(line: 71, column: 7, scope: !609)
!618 = !DILocation(line: 0, scope: !440, inlinedAt: !619)
!619 = distinct !DILocation(line: 73, column: 7, scope: !609)
!620 = !DILocation(line: 64, column: 17, scope: !440, inlinedAt: !619)
!621 = !DILocation(line: 64, column: 3, scope: !440, inlinedAt: !619)
!622 = !DILocation(line: 66, column: 22, scope: !452, inlinedAt: !619)
!623 = !DILocation(line: 66, column: 26, scope: !452, inlinedAt: !619)
!624 = !DILocation(line: 66, column: 32, scope: !452, inlinedAt: !619)
!625 = !DILocation(line: 66, column: 35, scope: !452, inlinedAt: !619)
!626 = !DILocation(line: 66, column: 39, scope: !452, inlinedAt: !619)
!627 = !DILocation(line: 66, column: 9, scope: !453, inlinedAt: !619)
!628 = !DILocation(line: 69, column: 6, scope: !453, inlinedAt: !619)
!629 = !DILocation(line: 64, column: 10, scope: !440, inlinedAt: !619)
!630 = !DILocation(line: 64, column: 13, scope: !440, inlinedAt: !619)
!631 = distinct !{!631, !621, !632, !383, !384}
!632 = !DILocation(line: 70, column: 3, scope: !440, inlinedAt: !619)
!633 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !619)
!634 = !DILocation(line: 71, column: 8, scope: !465, inlinedAt: !619)
!635 = !DILocation(line: 71, column: 6, scope: !440, inlinedAt: !619)
!636 = !DILocation(line: 74, column: 37, scope: !609)
!637 = !DILocation(line: 74, column: 3, scope: !609)
!638 = !DILocation(line: 75, column: 3, scope: !609)
!639 = !DILocation(line: 76, column: 1, scope: !609)
!640 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 78, type: !428, scopeLine: 78, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !641)
!641 = !{!642, !643, !644}
!642 = !DILocalVariable(name: "fd", arg: 1, scope: !640, file: !189, line: 78, type: !206)
!643 = !DILocalVariable(name: "vdata", arg: 2, scope: !640, file: !189, line: 78, type: !243)
!644 = !DILocalVariable(name: "data", scope: !640, file: !189, line: 79, type: !191)
!645 = !DILocation(line: 0, scope: !640)
!646 = !DILocation(line: 0, scope: !540, inlinedAt: !647)
!647 = distinct !DILocation(line: 81, column: 3, scope: !640)
!648 = !DILocation(line: 190, column: 3, scope: !547, inlinedAt: !647)
!649 = !DILocation(line: 191, column: 3, scope: !540, inlinedAt: !647)
!650 = !DILocation(line: 82, column: 38, scope: !640)
!651 = !DILocation(line: 0, scope: !551, inlinedAt: !652)
!652 = distinct !DILocation(line: 82, column: 3, scope: !640)
!653 = !DILocation(line: 187, column: 1, scope: !561, inlinedAt: !652)
!654 = !DILocation(line: 187, column: 1, scope: !563, inlinedAt: !652)
!655 = !DILocation(line: 187, column: 1, scope: !564, inlinedAt: !652)
!656 = distinct !{!656, !653, !653, !383, !384}
!657 = !DILocation(line: 83, column: 1, scope: !640)
!658 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 85, type: !659, scopeLine: 85, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !661)
!659 = !DISubroutineType(types: !660)
!660 = !{!206, !243, !243}
!661 = !{!662, !663, !664, !665, !666, !667, !668}
!662 = !DILocalVariable(name: "vdata", arg: 1, scope: !658, file: !189, line: 85, type: !243)
!663 = !DILocalVariable(name: "vref", arg: 2, scope: !658, file: !189, line: 85, type: !243)
!664 = !DILocalVariable(name: "data", scope: !658, file: !189, line: 86, type: !191)
!665 = !DILocalVariable(name: "ref", scope: !658, file: !189, line: 87, type: !191)
!666 = !DILocalVariable(name: "has_errors", scope: !658, file: !189, line: 88, type: !206)
!667 = !DILocalVariable(name: "i", scope: !658, file: !189, line: 89, type: !206)
!668 = !DILocalVariable(name: "diff", scope: !658, file: !189, line: 90, type: !197)
!669 = !DILocation(line: 0, scope: !658)
!670 = !DILocation(line: 92, column: 3, scope: !671)
!671 = distinct !DILexicalBlock(scope: !658, file: !189, line: 92, column: 3)
!672 = !DILocation(line: 93, column: 12, scope: !673)
!673 = distinct !DILexicalBlock(scope: !674, file: !189, line: 92, column: 22)
!674 = distinct !DILexicalBlock(scope: !671, file: !189, line: 92, column: 3)
!675 = !DILocation(line: 93, column: 27, scope: !673)
!676 = !DILocation(line: 93, column: 25, scope: !673)
!677 = !DILocation(line: 94, column: 35, scope: !673)
!678 = !DILocation(line: 94, column: 16, scope: !673)
!679 = !DILocation(line: 92, column: 18, scope: !674)
!680 = !DILocation(line: 92, column: 13, scope: !674)
!681 = distinct !{!681, !670, !682, !383, !384}
!682 = !DILocation(line: 95, column: 3, scope: !671)
!683 = !DILocation(line: 98, column: 10, scope: !658)
!684 = !DILocation(line: 98, column: 3, scope: !658)
!685 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !686, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !688)
!686 = !DISubroutineType(types: !687)
!687 = !{!242, !206}
!688 = !{!689, !690, !691, !728, !731, !734}
!689 = !DILocalVariable(name: "fd", arg: 1, scope: !685, file: !2, line: 34, type: !206)
!690 = !DILocalVariable(name: "p", scope: !685, file: !2, line: 35, type: !242)
!691 = !DILocalVariable(name: "s", scope: !685, file: !2, line: 36, type: !692)
!692 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !693, line: 44, size: 1024, elements: !694)
!693 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!694 = !{!695, !697, !699, !701, !703, !705, !707, !708, !709, !711, !713, !714, !716, !724, !725, !726}
!695 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !692, file: !693, line: 46, baseType: !696, size: 64)
!696 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !205, line: 145, baseType: !256)
!697 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !692, file: !693, line: 47, baseType: !698, size: 64, offset: 64)
!698 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !205, line: 148, baseType: !256)
!699 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !692, file: !693, line: 48, baseType: !700, size: 32, offset: 128)
!700 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !205, line: 150, baseType: !253)
!701 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !692, file: !693, line: 49, baseType: !702, size: 32, offset: 160)
!702 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !205, line: 151, baseType: !253)
!703 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !692, file: !693, line: 50, baseType: !704, size: 32, offset: 192)
!704 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !205, line: 146, baseType: !253)
!705 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !692, file: !693, line: 51, baseType: !706, size: 32, offset: 224)
!706 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !205, line: 147, baseType: !253)
!707 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !692, file: !693, line: 52, baseType: !696, size: 64, offset: 256)
!708 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !692, file: !693, line: 53, baseType: !696, size: 64, offset: 320)
!709 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !692, file: !693, line: 54, baseType: !710, size: 64, offset: 384)
!710 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !205, line: 152, baseType: !265)
!711 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !692, file: !693, line: 55, baseType: !712, size: 32, offset: 448)
!712 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !205, line: 175, baseType: !206)
!713 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !692, file: !693, line: 56, baseType: !206, size: 32, offset: 480)
!714 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !692, file: !693, line: 57, baseType: !715, size: 64, offset: 512)
!715 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !205, line: 180, baseType: !265)
!716 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !692, file: !693, line: 65, baseType: !717, size: 128, offset: 576)
!717 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !718, line: 11, size: 128, elements: !719)
!718 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!719 = !{!720, !722}
!720 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !717, file: !718, line: 16, baseType: !721, size: 64)
!721 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !205, line: 160, baseType: !265)
!722 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !717, file: !718, line: 21, baseType: !723, size: 64, offset: 64)
!723 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !205, line: 197, baseType: !265)
!724 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !692, file: !693, line: 66, baseType: !717, size: 128, offset: 704)
!725 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !692, file: !693, line: 67, baseType: !717, size: 128, offset: 832)
!726 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !692, file: !693, line: 79, baseType: !727, size: 64, offset: 960)
!727 = !DICompositeType(tag: DW_TAG_array_type, baseType: !206, size: 64, elements: !55)
!728 = !DILocalVariable(name: "len", scope: !685, file: !2, line: 37, type: !729)
!729 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !730, line: 85, baseType: !710)
!730 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!731 = !DILocalVariable(name: "bytes_read", scope: !685, file: !2, line: 38, type: !732)
!732 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !730, line: 108, baseType: !733)
!733 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !205, line: 194, baseType: !265)
!734 = !DILocalVariable(name: "status", scope: !685, file: !2, line: 38, type: !732)
!735 = distinct !DIAssignID()
!736 = !DILocation(line: 0, scope: !685)
!737 = !DILocation(line: 36, column: 3, scope: !685)
!738 = !DILocation(line: 40, column: 3, scope: !739)
!739 = distinct !DILexicalBlock(scope: !740, file: !2, line: 40, column: 3)
!740 = distinct !DILexicalBlock(scope: !685, file: !2, line: 40, column: 3)
!741 = !DILocation(line: 41, column: 3, scope: !742)
!742 = distinct !DILexicalBlock(scope: !743, file: !2, line: 41, column: 3)
!743 = distinct !DILexicalBlock(scope: !685, file: !2, line: 41, column: 3)
!744 = !DILocation(line: 42, column: 11, scope: !685)
!745 = !DILocation(line: 43, column: 3, scope: !746)
!746 = distinct !DILexicalBlock(scope: !747, file: !2, line: 43, column: 3)
!747 = distinct !DILexicalBlock(scope: !685, file: !2, line: 43, column: 3)
!748 = !DILocation(line: 44, column: 25, scope: !685)
!749 = !DILocation(line: 44, column: 15, scope: !685)
!750 = !DILocation(line: 46, column: 3, scope: !685)
!751 = !DILocation(line: 49, column: 15, scope: !752)
!752 = distinct !DILexicalBlock(scope: !685, file: !2, line: 46, column: 27)
!753 = !DILocation(line: 46, column: 20, scope: !685)
!754 = distinct !{!754, !750, !755, !383, !384}
!755 = !DILocation(line: 50, column: 3, scope: !685)
!756 = !DILocation(line: 47, column: 24, scope: !752)
!757 = !DILocation(line: 47, column: 42, scope: !752)
!758 = !DILocation(line: 47, column: 14, scope: !752)
!759 = !DILocation(line: 48, column: 5, scope: !760)
!760 = distinct !DILexicalBlock(scope: !761, file: !2, line: 48, column: 5)
!761 = distinct !DILexicalBlock(scope: !752, file: !2, line: 48, column: 5)
!762 = !DILocation(line: 51, column: 3, scope: !685)
!763 = !DILocation(line: 51, column: 10, scope: !685)
!764 = !DILocation(line: 52, column: 3, scope: !685)
!765 = !DILocation(line: 54, column: 1, scope: !685)
!766 = !DILocation(line: 53, column: 3, scope: !685)
!767 = !DISubprogram(name: "__assert_fail", scope: !768, file: !768, line: 67, type: !769, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!768 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!769 = !DISubroutineType(types: !770)
!770 = !{null, !771, !771, !253, !771}
!771 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!772 = !DISubprogram(name: "fstat", scope: !773, file: !773, line: 210, type: !774, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!773 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!774 = !DISubroutineType(types: !775)
!775 = !{!206, !206, !776}
!776 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !692, size: 64)
!777 = !DISubprogram(name: "malloc", scope: !532, file: !532, line: 672, type: !778, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!778 = !DISubroutineType(types: !779)
!779 = !{!243, !780}
!780 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !781, line: 18, baseType: !256)
!781 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!782 = !DISubprogram(name: "read", scope: !783, file: !783, line: 371, type: !784, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!783 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!784 = !DISubroutineType(types: !785)
!785 = !{!732, !206, !243, !780}
!786 = !DISubprogram(name: "close", scope: !783, file: !783, line: 358, type: !541, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!787 = !DILocation(line: 0, scope: !440)
!788 = !DILocation(line: 59, column: 3, scope: !789)
!789 = distinct !DILexicalBlock(scope: !790, file: !2, line: 59, column: 3)
!790 = distinct !DILexicalBlock(scope: !440, file: !2, line: 59, column: 3)
!791 = !DILocation(line: 60, column: 7, scope: !792)
!792 = distinct !DILexicalBlock(scope: !440, file: !2, line: 60, column: 6)
!793 = !DILocation(line: 60, column: 6, scope: !440)
!794 = !DILocation(line: 64, column: 17, scope: !440)
!795 = !DILocation(line: 64, column: 3, scope: !440)
!796 = !DILocation(line: 66, column: 22, scope: !452)
!797 = !DILocation(line: 66, column: 26, scope: !452)
!798 = !DILocation(line: 66, column: 32, scope: !452)
!799 = !DILocation(line: 66, column: 35, scope: !452)
!800 = !DILocation(line: 66, column: 39, scope: !452)
!801 = !DILocation(line: 66, column: 9, scope: !453)
!802 = !DILocation(line: 69, column: 6, scope: !453)
!803 = !DILocation(line: 64, column: 10, scope: !440)
!804 = !DILocation(line: 64, column: 13, scope: !440)
!805 = distinct !{!805, !795, !806, !383, !384}
!806 = !DILocation(line: 70, column: 3, scope: !440)
!807 = !DILocation(line: 71, column: 6, scope: !465)
!808 = !DILocation(line: 71, column: 8, scope: !465)
!809 = !DILocation(line: 71, column: 6, scope: !440)
!810 = !DILocation(line: 74, column: 1, scope: !440)
!811 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !812, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !814)
!812 = !DISubroutineType(types: !813)
!813 = !{!206, !242, !242, !206}
!814 = !{!815, !816, !817, !818}
!815 = !DILocalVariable(name: "s", arg: 1, scope: !811, file: !2, line: 77, type: !242)
!816 = !DILocalVariable(name: "arr", arg: 2, scope: !811, file: !2, line: 77, type: !242)
!817 = !DILocalVariable(name: "n", arg: 3, scope: !811, file: !2, line: 77, type: !206)
!818 = !DILocalVariable(name: "k", scope: !811, file: !2, line: 78, type: !206)
!819 = !DILocation(line: 0, scope: !811)
!820 = !DILocation(line: 79, column: 3, scope: !821)
!821 = distinct !DILexicalBlock(scope: !822, file: !2, line: 79, column: 3)
!822 = distinct !DILexicalBlock(scope: !811, file: !2, line: 79, column: 3)
!823 = !DILocation(line: 81, column: 8, scope: !824)
!824 = distinct !DILexicalBlock(scope: !811, file: !2, line: 81, column: 7)
!825 = !DILocation(line: 81, column: 7, scope: !811)
!826 = !DILocation(line: 83, column: 12, scope: !827)
!827 = distinct !DILexicalBlock(scope: !824, file: !2, line: 81, column: 13)
!828 = !DILocation(line: 83, column: 5, scope: !827)
!829 = !DILocation(line: 91, column: 19, scope: !811)
!830 = !DILocation(line: 91, column: 3, scope: !811)
!831 = !DILocation(line: 92, column: 7, scope: !811)
!832 = !DILocation(line: 83, column: 16, scope: !827)
!833 = !DILocation(line: 83, column: 26, scope: !827)
!834 = !DILocation(line: 83, column: 32, scope: !827)
!835 = !DILocation(line: 83, column: 29, scope: !827)
!836 = !DILocation(line: 83, column: 35, scope: !827)
!837 = !DILocation(line: 83, column: 45, scope: !827)
!838 = !DILocation(line: 83, column: 48, scope: !827)
!839 = !DILocation(line: 83, column: 54, scope: !827)
!840 = !DILocation(line: 84, column: 9, scope: !827)
!841 = !DILocation(line: 84, column: 18, scope: !827)
!842 = !DILocation(line: 84, column: 26, scope: !827)
!843 = distinct !{!843, !828, !844, !383, !384}
!844 = !DILocation(line: 86, column: 5, scope: !827)
!845 = !DILocation(line: 93, column: 5, scope: !846)
!846 = distinct !DILexicalBlock(scope: !811, file: !2, line: 92, column: 7)
!847 = !DILocation(line: 93, column: 12, scope: !846)
!848 = !DILocation(line: 95, column: 3, scope: !811)
!849 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !850, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !853)
!850 = !DISubroutineType(types: !851)
!851 = !{!206, !242, !852, !206}
!852 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !244, size: 64)
!853 = !{!854, !855, !856, !857, !858, !859, !860}
!854 = !DILocalVariable(name: "s", arg: 1, scope: !849, file: !2, line: 132, type: !242)
!855 = !DILocalVariable(name: "arr", arg: 2, scope: !849, file: !2, line: 132, type: !852)
!856 = !DILocalVariable(name: "n", arg: 3, scope: !849, file: !2, line: 132, type: !206)
!857 = !DILocalVariable(name: "line", scope: !849, file: !2, line: 132, type: !242)
!858 = !DILocalVariable(name: "endptr", scope: !849, file: !2, line: 132, type: !242)
!859 = !DILocalVariable(name: "i", scope: !849, file: !2, line: 132, type: !206)
!860 = !DILocalVariable(name: "v", scope: !849, file: !2, line: 132, type: !244)
!861 = distinct !DIAssignID()
!862 = !DILocation(line: 0, scope: !849)
!863 = !DILocation(line: 132, column: 1, scope: !849)
!864 = !DILocation(line: 132, column: 1, scope: !865)
!865 = distinct !DILexicalBlock(scope: !866, file: !2, line: 132, column: 1)
!866 = distinct !DILexicalBlock(scope: !849, file: !2, line: 132, column: 1)
!867 = !DILocation(line: 132, column: 1, scope: !868)
!868 = distinct !DILexicalBlock(scope: !849, file: !2, line: 132, column: 1)
!869 = !{!870, !870, i64 0}
!870 = !{!"any pointer", !372, i64 0}
!871 = distinct !DIAssignID()
!872 = !DILocation(line: 132, column: 1, scope: !873)
!873 = distinct !DILexicalBlock(scope: !868, file: !2, line: 132, column: 1)
!874 = !DILocation(line: 132, column: 1, scope: !875)
!875 = distinct !DILexicalBlock(scope: !873, file: !2, line: 132, column: 1)
!876 = distinct !{!876, !863, !863, !383, !384}
!877 = !DILocation(line: 132, column: 1, scope: !878)
!878 = distinct !DILexicalBlock(scope: !879, file: !2, line: 132, column: 1)
!879 = distinct !DILexicalBlock(scope: !849, file: !2, line: 132, column: 1)
!880 = !DISubprogram(name: "strtok", scope: !881, file: !881, line: 356, type: !882, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!881 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!882 = !DISubroutineType(types: !883)
!883 = !{!242, !884, !885}
!884 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !242)
!885 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !771)
!886 = !DISubprogram(name: "strtol", scope: !532, file: !532, line: 177, type: !887, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!887 = !DISubroutineType(types: !888)
!888 = !{!265, !885, !889, !206}
!889 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !890)
!890 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !242, size: 64)
!891 = !DISubprogram(name: "fprintf", scope: !892, file: !892, line: 357, type: !893, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!892 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!893 = !DISubroutineType(types: !894)
!894 = !{!206, !895, !885, null}
!895 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !896)
!896 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !897, size: 64)
!897 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !898, line: 7, baseType: !899)
!898 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!899 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !900, line: 49, size: 1728, elements: !901)
!900 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!901 = !{!902, !903, !904, !905, !906, !907, !908, !909, !910, !911, !912, !913, !914, !917, !919, !920, !921, !922, !923, !924, !928, !931, !933, !936, !939, !940, !941, !943, !944}
!902 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !899, file: !900, line: 51, baseType: !206, size: 32)
!903 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !899, file: !900, line: 54, baseType: !242, size: 64, offset: 64)
!904 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !899, file: !900, line: 55, baseType: !242, size: 64, offset: 128)
!905 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !899, file: !900, line: 56, baseType: !242, size: 64, offset: 192)
!906 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !899, file: !900, line: 57, baseType: !242, size: 64, offset: 256)
!907 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !899, file: !900, line: 58, baseType: !242, size: 64, offset: 320)
!908 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !899, file: !900, line: 59, baseType: !242, size: 64, offset: 384)
!909 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !899, file: !900, line: 60, baseType: !242, size: 64, offset: 448)
!910 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !899, file: !900, line: 61, baseType: !242, size: 64, offset: 512)
!911 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !899, file: !900, line: 64, baseType: !242, size: 64, offset: 576)
!912 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !899, file: !900, line: 65, baseType: !242, size: 64, offset: 640)
!913 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !899, file: !900, line: 66, baseType: !242, size: 64, offset: 704)
!914 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !899, file: !900, line: 68, baseType: !915, size: 64, offset: 768)
!915 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !916, size: 64)
!916 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !900, line: 36, flags: DIFlagFwdDecl)
!917 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !899, file: !900, line: 70, baseType: !918, size: 64, offset: 832)
!918 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !899, size: 64)
!919 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !899, file: !900, line: 72, baseType: !206, size: 32, offset: 896)
!920 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !899, file: !900, line: 73, baseType: !206, size: 32, offset: 928)
!921 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !899, file: !900, line: 74, baseType: !710, size: 64, offset: 960)
!922 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !899, file: !900, line: 77, baseType: !250, size: 16, offset: 1024)
!923 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !899, file: !900, line: 78, baseType: !259, size: 8, offset: 1040)
!924 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !899, file: !900, line: 79, baseType: !925, size: 8, offset: 1048)
!925 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !926)
!926 = !{!927}
!927 = !DISubrange(count: 1)
!928 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !899, file: !900, line: 81, baseType: !929, size: 64, offset: 1088)
!929 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !930, size: 64)
!930 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !900, line: 43, baseType: null)
!931 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !899, file: !900, line: 89, baseType: !932, size: 64, offset: 1152)
!932 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !205, line: 153, baseType: !265)
!933 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !899, file: !900, line: 91, baseType: !934, size: 64, offset: 1216)
!934 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !935, size: 64)
!935 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !900, line: 37, flags: DIFlagFwdDecl)
!936 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !899, file: !900, line: 92, baseType: !937, size: 64, offset: 1280)
!937 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !938, size: 64)
!938 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !900, line: 38, flags: DIFlagFwdDecl)
!939 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !899, file: !900, line: 93, baseType: !918, size: 64, offset: 1344)
!940 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !899, file: !900, line: 94, baseType: !243, size: 64, offset: 1408)
!941 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !899, file: !900, line: 95, baseType: !942, size: 64, offset: 1472)
!942 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !918, size: 64)
!943 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !899, file: !900, line: 96, baseType: !206, size: 32, offset: 1536)
!944 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !899, file: !900, line: 98, baseType: !945, size: 160, offset: 1568)
!945 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!946 = !DISubprogram(name: "strlen", scope: !881, file: !881, line: 407, type: !947, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!947 = !DISubroutineType(types: !948)
!948 = !{!256, !771}
!949 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !950, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !953)
!950 = !DISubroutineType(types: !951)
!951 = !{!206, !242, !952, !206}
!952 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !248, size: 64)
!953 = !{!954, !955, !956, !957, !958, !959, !960}
!954 = !DILocalVariable(name: "s", arg: 1, scope: !949, file: !2, line: 133, type: !242)
!955 = !DILocalVariable(name: "arr", arg: 2, scope: !949, file: !2, line: 133, type: !952)
!956 = !DILocalVariable(name: "n", arg: 3, scope: !949, file: !2, line: 133, type: !206)
!957 = !DILocalVariable(name: "line", scope: !949, file: !2, line: 133, type: !242)
!958 = !DILocalVariable(name: "endptr", scope: !949, file: !2, line: 133, type: !242)
!959 = !DILocalVariable(name: "i", scope: !949, file: !2, line: 133, type: !206)
!960 = !DILocalVariable(name: "v", scope: !949, file: !2, line: 133, type: !248)
!961 = distinct !DIAssignID()
!962 = !DILocation(line: 0, scope: !949)
!963 = !DILocation(line: 133, column: 1, scope: !949)
!964 = !DILocation(line: 133, column: 1, scope: !965)
!965 = distinct !DILexicalBlock(scope: !966, file: !2, line: 133, column: 1)
!966 = distinct !DILexicalBlock(scope: !949, file: !2, line: 133, column: 1)
!967 = !DILocation(line: 133, column: 1, scope: !968)
!968 = distinct !DILexicalBlock(scope: !949, file: !2, line: 133, column: 1)
!969 = distinct !DIAssignID()
!970 = !DILocation(line: 133, column: 1, scope: !971)
!971 = distinct !DILexicalBlock(scope: !968, file: !2, line: 133, column: 1)
!972 = !DILocation(line: 133, column: 1, scope: !973)
!973 = distinct !DILexicalBlock(scope: !971, file: !2, line: 133, column: 1)
!974 = !{!975, !975, i64 0}
!975 = !{!"short", !372, i64 0}
!976 = distinct !{!976, !963, !963, !383, !384}
!977 = !DILocation(line: 133, column: 1, scope: !978)
!978 = distinct !DILexicalBlock(scope: !979, file: !2, line: 133, column: 1)
!979 = distinct !DILexicalBlock(scope: !949, file: !2, line: 133, column: 1)
!980 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !981, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !984)
!981 = !DISubroutineType(types: !982)
!982 = !{!206, !242, !983, !206}
!983 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !251, size: 64)
!984 = !{!985, !986, !987, !988, !989, !990, !991}
!985 = !DILocalVariable(name: "s", arg: 1, scope: !980, file: !2, line: 134, type: !242)
!986 = !DILocalVariable(name: "arr", arg: 2, scope: !980, file: !2, line: 134, type: !983)
!987 = !DILocalVariable(name: "n", arg: 3, scope: !980, file: !2, line: 134, type: !206)
!988 = !DILocalVariable(name: "line", scope: !980, file: !2, line: 134, type: !242)
!989 = !DILocalVariable(name: "endptr", scope: !980, file: !2, line: 134, type: !242)
!990 = !DILocalVariable(name: "i", scope: !980, file: !2, line: 134, type: !206)
!991 = !DILocalVariable(name: "v", scope: !980, file: !2, line: 134, type: !251)
!992 = distinct !DIAssignID()
!993 = !DILocation(line: 0, scope: !980)
!994 = !DILocation(line: 134, column: 1, scope: !980)
!995 = !DILocation(line: 134, column: 1, scope: !996)
!996 = distinct !DILexicalBlock(scope: !997, file: !2, line: 134, column: 1)
!997 = distinct !DILexicalBlock(scope: !980, file: !2, line: 134, column: 1)
!998 = !DILocation(line: 134, column: 1, scope: !999)
!999 = distinct !DILexicalBlock(scope: !980, file: !2, line: 134, column: 1)
!1000 = distinct !DIAssignID()
!1001 = !DILocation(line: 134, column: 1, scope: !1002)
!1002 = distinct !DILexicalBlock(scope: !999, file: !2, line: 134, column: 1)
!1003 = !DILocation(line: 134, column: 1, scope: !1004)
!1004 = distinct !DILexicalBlock(scope: !1002, file: !2, line: 134, column: 1)
!1005 = distinct !{!1005, !994, !994, !383, !384}
!1006 = !DILocation(line: 134, column: 1, scope: !1007)
!1007 = distinct !DILexicalBlock(scope: !1008, file: !2, line: 134, column: 1)
!1008 = distinct !DILexicalBlock(scope: !980, file: !2, line: 134, column: 1)
!1009 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !1010, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1013)
!1010 = !DISubroutineType(types: !1011)
!1011 = !{!206, !242, !1012, !206}
!1012 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 64)
!1013 = !{!1014, !1015, !1016, !1017, !1018, !1019, !1020}
!1014 = !DILocalVariable(name: "s", arg: 1, scope: !1009, file: !2, line: 135, type: !242)
!1015 = !DILocalVariable(name: "arr", arg: 2, scope: !1009, file: !2, line: 135, type: !1012)
!1016 = !DILocalVariable(name: "n", arg: 3, scope: !1009, file: !2, line: 135, type: !206)
!1017 = !DILocalVariable(name: "line", scope: !1009, file: !2, line: 135, type: !242)
!1018 = !DILocalVariable(name: "endptr", scope: !1009, file: !2, line: 135, type: !242)
!1019 = !DILocalVariable(name: "i", scope: !1009, file: !2, line: 135, type: !206)
!1020 = !DILocalVariable(name: "v", scope: !1009, file: !2, line: 135, type: !254)
!1021 = distinct !DIAssignID()
!1022 = !DILocation(line: 0, scope: !1009)
!1023 = !DILocation(line: 135, column: 1, scope: !1009)
!1024 = !DILocation(line: 135, column: 1, scope: !1025)
!1025 = distinct !DILexicalBlock(scope: !1026, file: !2, line: 135, column: 1)
!1026 = distinct !DILexicalBlock(scope: !1009, file: !2, line: 135, column: 1)
!1027 = !DILocation(line: 135, column: 1, scope: !1028)
!1028 = distinct !DILexicalBlock(scope: !1009, file: !2, line: 135, column: 1)
!1029 = distinct !DIAssignID()
!1030 = !DILocation(line: 135, column: 1, scope: !1031)
!1031 = distinct !DILexicalBlock(scope: !1028, file: !2, line: 135, column: 1)
!1032 = !DILocation(line: 135, column: 1, scope: !1033)
!1033 = distinct !DILexicalBlock(scope: !1031, file: !2, line: 135, column: 1)
!1034 = !{!1035, !1035, i64 0}
!1035 = !{!"long", !372, i64 0}
!1036 = distinct !{!1036, !1023, !1023, !383, !384}
!1037 = !DILocation(line: 135, column: 1, scope: !1038)
!1038 = distinct !DILexicalBlock(scope: !1039, file: !2, line: 135, column: 1)
!1039 = distinct !DILexicalBlock(scope: !1009, file: !2, line: 135, column: 1)
!1040 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1041, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1044)
!1041 = !DISubroutineType(types: !1042)
!1042 = !{!206, !242, !1043, !206}
!1043 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !257, size: 64)
!1044 = !{!1045, !1046, !1047, !1048, !1049, !1050, !1051}
!1045 = !DILocalVariable(name: "s", arg: 1, scope: !1040, file: !2, line: 136, type: !242)
!1046 = !DILocalVariable(name: "arr", arg: 2, scope: !1040, file: !2, line: 136, type: !1043)
!1047 = !DILocalVariable(name: "n", arg: 3, scope: !1040, file: !2, line: 136, type: !206)
!1048 = !DILocalVariable(name: "line", scope: !1040, file: !2, line: 136, type: !242)
!1049 = !DILocalVariable(name: "endptr", scope: !1040, file: !2, line: 136, type: !242)
!1050 = !DILocalVariable(name: "i", scope: !1040, file: !2, line: 136, type: !206)
!1051 = !DILocalVariable(name: "v", scope: !1040, file: !2, line: 136, type: !257)
!1052 = distinct !DIAssignID()
!1053 = !DILocation(line: 0, scope: !1040)
!1054 = !DILocation(line: 136, column: 1, scope: !1040)
!1055 = !DILocation(line: 136, column: 1, scope: !1056)
!1056 = distinct !DILexicalBlock(scope: !1057, file: !2, line: 136, column: 1)
!1057 = distinct !DILexicalBlock(scope: !1040, file: !2, line: 136, column: 1)
!1058 = !DILocation(line: 136, column: 1, scope: !1059)
!1059 = distinct !DILexicalBlock(scope: !1040, file: !2, line: 136, column: 1)
!1060 = distinct !DIAssignID()
!1061 = !DILocation(line: 136, column: 1, scope: !1062)
!1062 = distinct !DILexicalBlock(scope: !1059, file: !2, line: 136, column: 1)
!1063 = !DILocation(line: 136, column: 1, scope: !1064)
!1064 = distinct !DILexicalBlock(scope: !1062, file: !2, line: 136, column: 1)
!1065 = distinct !{!1065, !1054, !1054, !383, !384}
!1066 = !DILocation(line: 136, column: 1, scope: !1067)
!1067 = distinct !DILexicalBlock(scope: !1068, file: !2, line: 136, column: 1)
!1068 = distinct !DILexicalBlock(scope: !1040, file: !2, line: 136, column: 1)
!1069 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1070, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1073)
!1070 = !DISubroutineType(types: !1071)
!1071 = !{!206, !242, !1072, !206}
!1072 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !260, size: 64)
!1073 = !{!1074, !1075, !1076, !1077, !1078, !1079, !1080}
!1074 = !DILocalVariable(name: "s", arg: 1, scope: !1069, file: !2, line: 137, type: !242)
!1075 = !DILocalVariable(name: "arr", arg: 2, scope: !1069, file: !2, line: 137, type: !1072)
!1076 = !DILocalVariable(name: "n", arg: 3, scope: !1069, file: !2, line: 137, type: !206)
!1077 = !DILocalVariable(name: "line", scope: !1069, file: !2, line: 137, type: !242)
!1078 = !DILocalVariable(name: "endptr", scope: !1069, file: !2, line: 137, type: !242)
!1079 = !DILocalVariable(name: "i", scope: !1069, file: !2, line: 137, type: !206)
!1080 = !DILocalVariable(name: "v", scope: !1069, file: !2, line: 137, type: !260)
!1081 = distinct !DIAssignID()
!1082 = !DILocation(line: 0, scope: !1069)
!1083 = !DILocation(line: 137, column: 1, scope: !1069)
!1084 = !DILocation(line: 137, column: 1, scope: !1085)
!1085 = distinct !DILexicalBlock(scope: !1086, file: !2, line: 137, column: 1)
!1086 = distinct !DILexicalBlock(scope: !1069, file: !2, line: 137, column: 1)
!1087 = !DILocation(line: 137, column: 1, scope: !1088)
!1088 = distinct !DILexicalBlock(scope: !1069, file: !2, line: 137, column: 1)
!1089 = distinct !DIAssignID()
!1090 = !DILocation(line: 137, column: 1, scope: !1091)
!1091 = distinct !DILexicalBlock(scope: !1088, file: !2, line: 137, column: 1)
!1092 = !DILocation(line: 137, column: 1, scope: !1093)
!1093 = distinct !DILexicalBlock(scope: !1091, file: !2, line: 137, column: 1)
!1094 = distinct !{!1094, !1083, !1083, !383, !384}
!1095 = !DILocation(line: 137, column: 1, scope: !1096)
!1096 = distinct !DILexicalBlock(scope: !1097, file: !2, line: 137, column: 1)
!1097 = distinct !DILexicalBlock(scope: !1069, file: !2, line: 137, column: 1)
!1098 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1099, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1101)
!1099 = !DISubroutineType(types: !1100)
!1100 = !{!206, !242, !338, !206}
!1101 = !{!1102, !1103, !1104, !1105, !1106, !1107, !1108}
!1102 = !DILocalVariable(name: "s", arg: 1, scope: !1098, file: !2, line: 138, type: !242)
!1103 = !DILocalVariable(name: "arr", arg: 2, scope: !1098, file: !2, line: 138, type: !338)
!1104 = !DILocalVariable(name: "n", arg: 3, scope: !1098, file: !2, line: 138, type: !206)
!1105 = !DILocalVariable(name: "line", scope: !1098, file: !2, line: 138, type: !242)
!1106 = !DILocalVariable(name: "endptr", scope: !1098, file: !2, line: 138, type: !242)
!1107 = !DILocalVariable(name: "i", scope: !1098, file: !2, line: 138, type: !206)
!1108 = !DILocalVariable(name: "v", scope: !1098, file: !2, line: 138, type: !202)
!1109 = distinct !DIAssignID()
!1110 = !DILocation(line: 0, scope: !1098)
!1111 = !DILocation(line: 138, column: 1, scope: !1098)
!1112 = !DILocation(line: 138, column: 1, scope: !1113)
!1113 = distinct !DILexicalBlock(scope: !1114, file: !2, line: 138, column: 1)
!1114 = distinct !DILexicalBlock(scope: !1098, file: !2, line: 138, column: 1)
!1115 = !DILocation(line: 138, column: 1, scope: !1116)
!1116 = distinct !DILexicalBlock(scope: !1098, file: !2, line: 138, column: 1)
!1117 = distinct !DIAssignID()
!1118 = !DILocation(line: 138, column: 1, scope: !1119)
!1119 = distinct !DILexicalBlock(scope: !1116, file: !2, line: 138, column: 1)
!1120 = !DILocation(line: 138, column: 1, scope: !1121)
!1121 = distinct !DILexicalBlock(scope: !1119, file: !2, line: 138, column: 1)
!1122 = distinct !{!1122, !1111, !1111, !383, !384}
!1123 = !DILocation(line: 138, column: 1, scope: !1124)
!1124 = distinct !DILexicalBlock(scope: !1125, file: !2, line: 138, column: 1)
!1125 = distinct !DILexicalBlock(scope: !1098, file: !2, line: 138, column: 1)
!1126 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1127, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1130)
!1127 = !DISubroutineType(types: !1128)
!1128 = !{!206, !242, !1129, !206}
!1129 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !263, size: 64)
!1130 = !{!1131, !1132, !1133, !1134, !1135, !1136, !1137}
!1131 = !DILocalVariable(name: "s", arg: 1, scope: !1126, file: !2, line: 139, type: !242)
!1132 = !DILocalVariable(name: "arr", arg: 2, scope: !1126, file: !2, line: 139, type: !1129)
!1133 = !DILocalVariable(name: "n", arg: 3, scope: !1126, file: !2, line: 139, type: !206)
!1134 = !DILocalVariable(name: "line", scope: !1126, file: !2, line: 139, type: !242)
!1135 = !DILocalVariable(name: "endptr", scope: !1126, file: !2, line: 139, type: !242)
!1136 = !DILocalVariable(name: "i", scope: !1126, file: !2, line: 139, type: !206)
!1137 = !DILocalVariable(name: "v", scope: !1126, file: !2, line: 139, type: !263)
!1138 = distinct !DIAssignID()
!1139 = !DILocation(line: 0, scope: !1126)
!1140 = !DILocation(line: 139, column: 1, scope: !1126)
!1141 = !DILocation(line: 139, column: 1, scope: !1142)
!1142 = distinct !DILexicalBlock(scope: !1143, file: !2, line: 139, column: 1)
!1143 = distinct !DILexicalBlock(scope: !1126, file: !2, line: 139, column: 1)
!1144 = !DILocation(line: 139, column: 1, scope: !1145)
!1145 = distinct !DILexicalBlock(scope: !1126, file: !2, line: 139, column: 1)
!1146 = distinct !DIAssignID()
!1147 = !DILocation(line: 139, column: 1, scope: !1148)
!1148 = distinct !DILexicalBlock(scope: !1145, file: !2, line: 139, column: 1)
!1149 = !DILocation(line: 139, column: 1, scope: !1150)
!1150 = distinct !DILexicalBlock(scope: !1148, file: !2, line: 139, column: 1)
!1151 = distinct !{!1151, !1140, !1140, !383, !384}
!1152 = !DILocation(line: 139, column: 1, scope: !1153)
!1153 = distinct !DILexicalBlock(scope: !1154, file: !2, line: 139, column: 1)
!1154 = distinct !DILexicalBlock(scope: !1126, file: !2, line: 139, column: 1)
!1155 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1156, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1159)
!1156 = !DISubroutineType(types: !1157)
!1157 = !{!206, !242, !1158, !206}
!1158 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !266, size: 64)
!1159 = !{!1160, !1161, !1162, !1163, !1164, !1165, !1166}
!1160 = !DILocalVariable(name: "s", arg: 1, scope: !1155, file: !2, line: 141, type: !242)
!1161 = !DILocalVariable(name: "arr", arg: 2, scope: !1155, file: !2, line: 141, type: !1158)
!1162 = !DILocalVariable(name: "n", arg: 3, scope: !1155, file: !2, line: 141, type: !206)
!1163 = !DILocalVariable(name: "line", scope: !1155, file: !2, line: 141, type: !242)
!1164 = !DILocalVariable(name: "endptr", scope: !1155, file: !2, line: 141, type: !242)
!1165 = !DILocalVariable(name: "i", scope: !1155, file: !2, line: 141, type: !206)
!1166 = !DILocalVariable(name: "v", scope: !1155, file: !2, line: 141, type: !266)
!1167 = distinct !DIAssignID()
!1168 = !DILocation(line: 0, scope: !1155)
!1169 = !DILocation(line: 141, column: 1, scope: !1155)
!1170 = !DILocation(line: 141, column: 1, scope: !1171)
!1171 = distinct !DILexicalBlock(scope: !1172, file: !2, line: 141, column: 1)
!1172 = distinct !DILexicalBlock(scope: !1155, file: !2, line: 141, column: 1)
!1173 = !DILocation(line: 141, column: 1, scope: !1174)
!1174 = distinct !DILexicalBlock(scope: !1155, file: !2, line: 141, column: 1)
!1175 = distinct !DIAssignID()
!1176 = !DILocation(line: 141, column: 1, scope: !1177)
!1177 = distinct !DILexicalBlock(scope: !1174, file: !2, line: 141, column: 1)
!1178 = !DILocation(line: 141, column: 1, scope: !1179)
!1179 = distinct !DILexicalBlock(scope: !1177, file: !2, line: 141, column: 1)
!1180 = !{!1181, !1181, i64 0}
!1181 = !{!"float", !372, i64 0}
!1182 = distinct !{!1182, !1169, !1169, !383, !384}
!1183 = !DILocation(line: 141, column: 1, scope: !1184)
!1184 = distinct !DILexicalBlock(scope: !1185, file: !2, line: 141, column: 1)
!1185 = distinct !DILexicalBlock(scope: !1155, file: !2, line: 141, column: 1)
!1186 = !DISubprogram(name: "strtof", scope: !532, file: !532, line: 124, type: !1187, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1187 = !DISubroutineType(types: !1188)
!1188 = !{!266, !885, !889}
!1189 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1190, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1192)
!1190 = !DISubroutineType(types: !1191)
!1191 = !{!206, !242, !337, !206}
!1192 = !{!1193, !1194, !1195, !1196, !1197, !1198, !1199}
!1193 = !DILocalVariable(name: "s", arg: 1, scope: !1189, file: !2, line: 142, type: !242)
!1194 = !DILocalVariable(name: "arr", arg: 2, scope: !1189, file: !2, line: 142, type: !337)
!1195 = !DILocalVariable(name: "n", arg: 3, scope: !1189, file: !2, line: 142, type: !206)
!1196 = !DILocalVariable(name: "line", scope: !1189, file: !2, line: 142, type: !242)
!1197 = !DILocalVariable(name: "endptr", scope: !1189, file: !2, line: 142, type: !242)
!1198 = !DILocalVariable(name: "i", scope: !1189, file: !2, line: 142, type: !206)
!1199 = !DILocalVariable(name: "v", scope: !1189, file: !2, line: 142, type: !197)
!1200 = distinct !DIAssignID()
!1201 = !DILocation(line: 0, scope: !1189)
!1202 = !DILocation(line: 142, column: 1, scope: !1189)
!1203 = !DILocation(line: 142, column: 1, scope: !1204)
!1204 = distinct !DILexicalBlock(scope: !1205, file: !2, line: 142, column: 1)
!1205 = distinct !DILexicalBlock(scope: !1189, file: !2, line: 142, column: 1)
!1206 = !DILocation(line: 142, column: 1, scope: !1207)
!1207 = distinct !DILexicalBlock(scope: !1189, file: !2, line: 142, column: 1)
!1208 = distinct !DIAssignID()
!1209 = !DILocation(line: 142, column: 1, scope: !1210)
!1210 = distinct !DILexicalBlock(scope: !1207, file: !2, line: 142, column: 1)
!1211 = !DILocation(line: 142, column: 1, scope: !1212)
!1212 = distinct !DILexicalBlock(scope: !1210, file: !2, line: 142, column: 1)
!1213 = distinct !{!1213, !1202, !1202, !383, !384}
!1214 = !DILocation(line: 142, column: 1, scope: !1215)
!1215 = distinct !DILexicalBlock(scope: !1216, file: !2, line: 142, column: 1)
!1216 = distinct !DILexicalBlock(scope: !1189, file: !2, line: 142, column: 1)
!1217 = !DISubprogram(name: "strtod", scope: !532, file: !532, line: 118, type: !1218, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1218 = !DISubroutineType(types: !1219)
!1219 = !{!197, !885, !889}
!1220 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1221, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1223)
!1221 = !DISubroutineType(types: !1222)
!1222 = !{!206, !206, !242, !206}
!1223 = !{!1224, !1225, !1226, !1227, !1228}
!1224 = !DILocalVariable(name: "fd", arg: 1, scope: !1220, file: !2, line: 145, type: !206)
!1225 = !DILocalVariable(name: "arr", arg: 2, scope: !1220, file: !2, line: 145, type: !242)
!1226 = !DILocalVariable(name: "n", arg: 3, scope: !1220, file: !2, line: 145, type: !206)
!1227 = !DILocalVariable(name: "status", scope: !1220, file: !2, line: 146, type: !206)
!1228 = !DILocalVariable(name: "written", scope: !1220, file: !2, line: 146, type: !206)
!1229 = !DILocation(line: 0, scope: !1220)
!1230 = !DILocation(line: 147, column: 3, scope: !1231)
!1231 = distinct !DILexicalBlock(scope: !1232, file: !2, line: 147, column: 3)
!1232 = distinct !DILexicalBlock(scope: !1220, file: !2, line: 147, column: 3)
!1233 = !DILocation(line: 148, column: 8, scope: !1234)
!1234 = distinct !DILexicalBlock(scope: !1220, file: !2, line: 148, column: 7)
!1235 = !DILocation(line: 148, column: 7, scope: !1220)
!1236 = !DILocation(line: 149, column: 9, scope: !1237)
!1237 = distinct !DILexicalBlock(scope: !1234, file: !2, line: 148, column: 13)
!1238 = !DILocation(line: 150, column: 3, scope: !1237)
!1239 = !DILocation(line: 152, column: 16, scope: !1220)
!1240 = !DILocation(line: 152, column: 3, scope: !1220)
!1241 = !DILocation(line: 158, column: 3, scope: !1220)
!1242 = !DILocation(line: 155, column: 13, scope: !1243)
!1243 = distinct !DILexicalBlock(scope: !1220, file: !2, line: 152, column: 20)
!1244 = distinct !{!1244, !1240, !1245, !383, !384}
!1245 = !DILocation(line: 156, column: 3, scope: !1220)
!1246 = !DILocation(line: 153, column: 25, scope: !1243)
!1247 = !DILocation(line: 153, column: 40, scope: !1243)
!1248 = !DILocation(line: 153, column: 39, scope: !1243)
!1249 = !DILocation(line: 153, column: 14, scope: !1243)
!1250 = !DILocation(line: 154, column: 5, scope: !1251)
!1251 = distinct !DILexicalBlock(scope: !1252, file: !2, line: 154, column: 5)
!1252 = distinct !DILexicalBlock(scope: !1243, file: !2, line: 154, column: 5)
!1253 = !DILocation(line: 159, column: 14, scope: !1254)
!1254 = distinct !DILexicalBlock(scope: !1220, file: !2, line: 158, column: 6)
!1255 = !DILocation(line: 160, column: 5, scope: !1256)
!1256 = distinct !DILexicalBlock(scope: !1257, file: !2, line: 160, column: 5)
!1257 = distinct !DILexicalBlock(scope: !1254, file: !2, line: 160, column: 5)
!1258 = !DILocation(line: 161, column: 17, scope: !1220)
!1259 = !DILocation(line: 161, column: 3, scope: !1254)
!1260 = distinct !{!1260, !1241, !1261, !383, !384}
!1261 = !DILocation(line: 161, column: 20, scope: !1220)
!1262 = !DILocation(line: 163, column: 3, scope: !1220)
!1263 = !DISubprogram(name: "write", scope: !783, file: !783, line: 378, type: !1264, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1264 = !DISubroutineType(types: !1265)
!1265 = !{!732, !206, !1266, !780}
!1266 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1267, size: 64)
!1267 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1268 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1269, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1271)
!1269 = !DISubroutineType(types: !1270)
!1270 = !{!206, !206, !852, !206}
!1271 = !{!1272, !1273, !1274, !1275}
!1272 = !DILocalVariable(name: "fd", arg: 1, scope: !1268, file: !2, line: 177, type: !206)
!1273 = !DILocalVariable(name: "arr", arg: 2, scope: !1268, file: !2, line: 177, type: !852)
!1274 = !DILocalVariable(name: "n", arg: 3, scope: !1268, file: !2, line: 177, type: !206)
!1275 = !DILocalVariable(name: "i", scope: !1268, file: !2, line: 177, type: !206)
!1276 = !DILocation(line: 0, scope: !1268)
!1277 = !DILocation(line: 177, column: 1, scope: !1278)
!1278 = distinct !DILexicalBlock(scope: !1279, file: !2, line: 177, column: 1)
!1279 = distinct !DILexicalBlock(scope: !1268, file: !2, line: 177, column: 1)
!1280 = !DILocation(line: 177, column: 1, scope: !1281)
!1281 = distinct !DILexicalBlock(scope: !1282, file: !2, line: 177, column: 1)
!1282 = distinct !DILexicalBlock(scope: !1268, file: !2, line: 177, column: 1)
!1283 = !DILocation(line: 177, column: 1, scope: !1282)
!1284 = !DILocation(line: 177, column: 1, scope: !1285)
!1285 = distinct !DILexicalBlock(scope: !1281, file: !2, line: 177, column: 1)
!1286 = distinct !{!1286, !1283, !1283, !383, !384}
!1287 = !DILocation(line: 177, column: 1, scope: !1268)
!1288 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1289, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1291)
!1289 = !DISubroutineType(cc: DW_CC_nocall, types: !1290)
!1290 = !{!206, !206, !771, null}
!1291 = !{!1292, !1293, !1294, !1298, !1299, !1300, !1301}
!1292 = !DILocalVariable(name: "fd", arg: 1, scope: !1288, file: !2, line: 15, type: !206)
!1293 = !DILocalVariable(name: "format", arg: 2, scope: !1288, file: !2, line: 15, type: !771)
!1294 = !DILocalVariable(name: "args", scope: !1288, file: !2, line: 16, type: !1295)
!1295 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1296, line: 12, baseType: !1297)
!1296 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1297 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !243)
!1298 = !DILocalVariable(name: "buffered", scope: !1288, file: !2, line: 17, type: !206)
!1299 = !DILocalVariable(name: "written", scope: !1288, file: !2, line: 17, type: !206)
!1300 = !DILocalVariable(name: "status", scope: !1288, file: !2, line: 17, type: !206)
!1301 = !DILocalVariable(name: "buffer", scope: !1288, file: !2, line: 18, type: !1302)
!1302 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !1303)
!1303 = !{!1304}
!1304 = !DISubrange(count: 256)
!1305 = distinct !DIAssignID()
!1306 = !DILocation(line: 0, scope: !1288)
!1307 = distinct !DIAssignID()
!1308 = !DILocation(line: 16, column: 3, scope: !1288)
!1309 = !DILocation(line: 18, column: 3, scope: !1288)
!1310 = !DILocation(line: 19, column: 3, scope: !1288)
!1311 = !DILocation(line: 20, column: 66, scope: !1288)
!1312 = !DILocation(line: 20, column: 14, scope: !1288)
!1313 = !DILocation(line: 21, column: 3, scope: !1288)
!1314 = !DILocation(line: 22, column: 3, scope: !1315)
!1315 = distinct !DILexicalBlock(scope: !1316, file: !2, line: 22, column: 3)
!1316 = distinct !DILexicalBlock(scope: !1288, file: !2, line: 22, column: 3)
!1317 = !DILocation(line: 24, column: 16, scope: !1288)
!1318 = !DILocation(line: 24, column: 3, scope: !1288)
!1319 = !DILocation(line: 27, column: 13, scope: !1320)
!1320 = distinct !DILexicalBlock(scope: !1288, file: !2, line: 24, column: 27)
!1321 = distinct !{!1321, !1318, !1322, !383, !384}
!1322 = !DILocation(line: 28, column: 3, scope: !1288)
!1323 = !DILocation(line: 25, column: 25, scope: !1320)
!1324 = !DILocation(line: 25, column: 50, scope: !1320)
!1325 = !DILocation(line: 25, column: 42, scope: !1320)
!1326 = !DILocation(line: 25, column: 14, scope: !1320)
!1327 = !DILocation(line: 26, column: 5, scope: !1328)
!1328 = distinct !DILexicalBlock(scope: !1329, file: !2, line: 26, column: 5)
!1329 = distinct !DILexicalBlock(scope: !1320, file: !2, line: 26, column: 5)
!1330 = !DILocation(line: 29, column: 3, scope: !1331)
!1331 = distinct !DILexicalBlock(scope: !1332, file: !2, line: 29, column: 3)
!1332 = distinct !DILexicalBlock(scope: !1288, file: !2, line: 29, column: 3)
!1333 = !DILocation(line: 31, column: 1, scope: !1288)
!1334 = !DILocation(line: 30, column: 3, scope: !1288)
!1335 = !DISubprogram(name: "vsnprintf", scope: !892, file: !892, line: 389, type: !1336, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1336 = !DISubroutineType(types: !1337)
!1337 = !{!206, !884, !780, !885, !1338}
!1338 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1339, line: 12, baseType: !1297)
!1339 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1340 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1341, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1343)
!1341 = !DISubroutineType(types: !1342)
!1342 = !{!206, !206, !952, !206}
!1343 = !{!1344, !1345, !1346, !1347}
!1344 = !DILocalVariable(name: "fd", arg: 1, scope: !1340, file: !2, line: 178, type: !206)
!1345 = !DILocalVariable(name: "arr", arg: 2, scope: !1340, file: !2, line: 178, type: !952)
!1346 = !DILocalVariable(name: "n", arg: 3, scope: !1340, file: !2, line: 178, type: !206)
!1347 = !DILocalVariable(name: "i", scope: !1340, file: !2, line: 178, type: !206)
!1348 = !DILocation(line: 0, scope: !1340)
!1349 = !DILocation(line: 178, column: 1, scope: !1350)
!1350 = distinct !DILexicalBlock(scope: !1351, file: !2, line: 178, column: 1)
!1351 = distinct !DILexicalBlock(scope: !1340, file: !2, line: 178, column: 1)
!1352 = !DILocation(line: 178, column: 1, scope: !1353)
!1353 = distinct !DILexicalBlock(scope: !1354, file: !2, line: 178, column: 1)
!1354 = distinct !DILexicalBlock(scope: !1340, file: !2, line: 178, column: 1)
!1355 = !DILocation(line: 178, column: 1, scope: !1354)
!1356 = !DILocation(line: 178, column: 1, scope: !1357)
!1357 = distinct !DILexicalBlock(scope: !1353, file: !2, line: 178, column: 1)
!1358 = distinct !{!1358, !1355, !1355, !383, !384}
!1359 = !DILocation(line: 178, column: 1, scope: !1340)
!1360 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1361, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1363)
!1361 = !DISubroutineType(types: !1362)
!1362 = !{!206, !206, !983, !206}
!1363 = !{!1364, !1365, !1366, !1367}
!1364 = !DILocalVariable(name: "fd", arg: 1, scope: !1360, file: !2, line: 179, type: !206)
!1365 = !DILocalVariable(name: "arr", arg: 2, scope: !1360, file: !2, line: 179, type: !983)
!1366 = !DILocalVariable(name: "n", arg: 3, scope: !1360, file: !2, line: 179, type: !206)
!1367 = !DILocalVariable(name: "i", scope: !1360, file: !2, line: 179, type: !206)
!1368 = !DILocation(line: 0, scope: !1360)
!1369 = !DILocation(line: 179, column: 1, scope: !1370)
!1370 = distinct !DILexicalBlock(scope: !1371, file: !2, line: 179, column: 1)
!1371 = distinct !DILexicalBlock(scope: !1360, file: !2, line: 179, column: 1)
!1372 = !DILocation(line: 179, column: 1, scope: !1373)
!1373 = distinct !DILexicalBlock(scope: !1374, file: !2, line: 179, column: 1)
!1374 = distinct !DILexicalBlock(scope: !1360, file: !2, line: 179, column: 1)
!1375 = !DILocation(line: 179, column: 1, scope: !1374)
!1376 = !DILocation(line: 179, column: 1, scope: !1377)
!1377 = distinct !DILexicalBlock(scope: !1373, file: !2, line: 179, column: 1)
!1378 = distinct !{!1378, !1375, !1375, !383, !384}
!1379 = !DILocation(line: 179, column: 1, scope: !1360)
!1380 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1381, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1383)
!1381 = !DISubroutineType(types: !1382)
!1382 = !{!206, !206, !1012, !206}
!1383 = !{!1384, !1385, !1386, !1387}
!1384 = !DILocalVariable(name: "fd", arg: 1, scope: !1380, file: !2, line: 180, type: !206)
!1385 = !DILocalVariable(name: "arr", arg: 2, scope: !1380, file: !2, line: 180, type: !1012)
!1386 = !DILocalVariable(name: "n", arg: 3, scope: !1380, file: !2, line: 180, type: !206)
!1387 = !DILocalVariable(name: "i", scope: !1380, file: !2, line: 180, type: !206)
!1388 = !DILocation(line: 0, scope: !1380)
!1389 = !DILocation(line: 180, column: 1, scope: !1390)
!1390 = distinct !DILexicalBlock(scope: !1391, file: !2, line: 180, column: 1)
!1391 = distinct !DILexicalBlock(scope: !1380, file: !2, line: 180, column: 1)
!1392 = !DILocation(line: 180, column: 1, scope: !1393)
!1393 = distinct !DILexicalBlock(scope: !1394, file: !2, line: 180, column: 1)
!1394 = distinct !DILexicalBlock(scope: !1380, file: !2, line: 180, column: 1)
!1395 = !DILocation(line: 180, column: 1, scope: !1394)
!1396 = !DILocation(line: 180, column: 1, scope: !1397)
!1397 = distinct !DILexicalBlock(scope: !1393, file: !2, line: 180, column: 1)
!1398 = distinct !{!1398, !1395, !1395, !383, !384}
!1399 = !DILocation(line: 180, column: 1, scope: !1380)
!1400 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1401, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1403)
!1401 = !DISubroutineType(types: !1402)
!1402 = !{!206, !206, !1043, !206}
!1403 = !{!1404, !1405, !1406, !1407}
!1404 = !DILocalVariable(name: "fd", arg: 1, scope: !1400, file: !2, line: 181, type: !206)
!1405 = !DILocalVariable(name: "arr", arg: 2, scope: !1400, file: !2, line: 181, type: !1043)
!1406 = !DILocalVariable(name: "n", arg: 3, scope: !1400, file: !2, line: 181, type: !206)
!1407 = !DILocalVariable(name: "i", scope: !1400, file: !2, line: 181, type: !206)
!1408 = !DILocation(line: 0, scope: !1400)
!1409 = !DILocation(line: 181, column: 1, scope: !1410)
!1410 = distinct !DILexicalBlock(scope: !1411, file: !2, line: 181, column: 1)
!1411 = distinct !DILexicalBlock(scope: !1400, file: !2, line: 181, column: 1)
!1412 = !DILocation(line: 181, column: 1, scope: !1413)
!1413 = distinct !DILexicalBlock(scope: !1414, file: !2, line: 181, column: 1)
!1414 = distinct !DILexicalBlock(scope: !1400, file: !2, line: 181, column: 1)
!1415 = !DILocation(line: 181, column: 1, scope: !1414)
!1416 = !DILocation(line: 181, column: 1, scope: !1417)
!1417 = distinct !DILexicalBlock(scope: !1413, file: !2, line: 181, column: 1)
!1418 = distinct !{!1418, !1415, !1415, !383, !384}
!1419 = !DILocation(line: 181, column: 1, scope: !1400)
!1420 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1421, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1423)
!1421 = !DISubroutineType(types: !1422)
!1422 = !{!206, !206, !1072, !206}
!1423 = !{!1424, !1425, !1426, !1427}
!1424 = !DILocalVariable(name: "fd", arg: 1, scope: !1420, file: !2, line: 182, type: !206)
!1425 = !DILocalVariable(name: "arr", arg: 2, scope: !1420, file: !2, line: 182, type: !1072)
!1426 = !DILocalVariable(name: "n", arg: 3, scope: !1420, file: !2, line: 182, type: !206)
!1427 = !DILocalVariable(name: "i", scope: !1420, file: !2, line: 182, type: !206)
!1428 = !DILocation(line: 0, scope: !1420)
!1429 = !DILocation(line: 182, column: 1, scope: !1430)
!1430 = distinct !DILexicalBlock(scope: !1431, file: !2, line: 182, column: 1)
!1431 = distinct !DILexicalBlock(scope: !1420, file: !2, line: 182, column: 1)
!1432 = !DILocation(line: 182, column: 1, scope: !1433)
!1433 = distinct !DILexicalBlock(scope: !1434, file: !2, line: 182, column: 1)
!1434 = distinct !DILexicalBlock(scope: !1420, file: !2, line: 182, column: 1)
!1435 = !DILocation(line: 182, column: 1, scope: !1434)
!1436 = !DILocation(line: 182, column: 1, scope: !1437)
!1437 = distinct !DILexicalBlock(scope: !1433, file: !2, line: 182, column: 1)
!1438 = distinct !{!1438, !1435, !1435, !383, !384}
!1439 = !DILocation(line: 182, column: 1, scope: !1420)
!1440 = !DILocation(line: 0, scope: !572)
!1441 = !DILocation(line: 183, column: 1, scope: !1442)
!1442 = distinct !DILexicalBlock(scope: !1443, file: !2, line: 183, column: 1)
!1443 = distinct !DILexicalBlock(scope: !572, file: !2, line: 183, column: 1)
!1444 = !DILocation(line: 183, column: 1, scope: !585)
!1445 = !DILocation(line: 183, column: 1, scope: !582)
!1446 = !DILocation(line: 183, column: 1, scope: !584)
!1447 = distinct !{!1447, !1445, !1445, !383, !384}
!1448 = !DILocation(line: 183, column: 1, scope: !572)
!1449 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1450, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1452)
!1450 = !DISubroutineType(types: !1451)
!1451 = !{!206, !206, !1129, !206}
!1452 = !{!1453, !1454, !1455, !1456}
!1453 = !DILocalVariable(name: "fd", arg: 1, scope: !1449, file: !2, line: 184, type: !206)
!1454 = !DILocalVariable(name: "arr", arg: 2, scope: !1449, file: !2, line: 184, type: !1129)
!1455 = !DILocalVariable(name: "n", arg: 3, scope: !1449, file: !2, line: 184, type: !206)
!1456 = !DILocalVariable(name: "i", scope: !1449, file: !2, line: 184, type: !206)
!1457 = !DILocation(line: 0, scope: !1449)
!1458 = !DILocation(line: 184, column: 1, scope: !1459)
!1459 = distinct !DILexicalBlock(scope: !1460, file: !2, line: 184, column: 1)
!1460 = distinct !DILexicalBlock(scope: !1449, file: !2, line: 184, column: 1)
!1461 = !DILocation(line: 184, column: 1, scope: !1462)
!1462 = distinct !DILexicalBlock(scope: !1463, file: !2, line: 184, column: 1)
!1463 = distinct !DILexicalBlock(scope: !1449, file: !2, line: 184, column: 1)
!1464 = !DILocation(line: 184, column: 1, scope: !1463)
!1465 = !DILocation(line: 184, column: 1, scope: !1466)
!1466 = distinct !DILexicalBlock(scope: !1462, file: !2, line: 184, column: 1)
!1467 = distinct !{!1467, !1464, !1464, !383, !384}
!1468 = !DILocation(line: 184, column: 1, scope: !1449)
!1469 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1470, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !240, retainedNodes: !1472)
!1470 = !DISubroutineType(types: !1471)
!1471 = !{!206, !206, !1158, !206}
!1472 = !{!1473, !1474, !1475, !1476}
!1473 = !DILocalVariable(name: "fd", arg: 1, scope: !1469, file: !2, line: 186, type: !206)
!1474 = !DILocalVariable(name: "arr", arg: 2, scope: !1469, file: !2, line: 186, type: !1158)
!1475 = !DILocalVariable(name: "n", arg: 3, scope: !1469, file: !2, line: 186, type: !206)
!1476 = !DILocalVariable(name: "i", scope: !1469, file: !2, line: 186, type: !206)
!1477 = !DILocation(line: 0, scope: !1469)
!1478 = !DILocation(line: 186, column: 1, scope: !1479)
!1479 = distinct !DILexicalBlock(scope: !1480, file: !2, line: 186, column: 1)
!1480 = distinct !DILexicalBlock(scope: !1469, file: !2, line: 186, column: 1)
!1481 = !DILocation(line: 186, column: 1, scope: !1482)
!1482 = distinct !DILexicalBlock(scope: !1483, file: !2, line: 186, column: 1)
!1483 = distinct !DILexicalBlock(scope: !1469, file: !2, line: 186, column: 1)
!1484 = !DILocation(line: 186, column: 1, scope: !1483)
!1485 = !DILocation(line: 186, column: 1, scope: !1486)
!1486 = distinct !DILexicalBlock(scope: !1482, file: !2, line: 186, column: 1)
!1487 = distinct !{!1487, !1484, !1484, !383, !384}
!1488 = !DILocation(line: 186, column: 1, scope: !1469)
!1489 = !DILocation(line: 0, scope: !551)
!1490 = !DILocation(line: 187, column: 1, scope: !1491)
!1491 = distinct !DILexicalBlock(scope: !1492, file: !2, line: 187, column: 1)
!1492 = distinct !DILexicalBlock(scope: !551, file: !2, line: 187, column: 1)
!1493 = !DILocation(line: 187, column: 1, scope: !564)
!1494 = !DILocation(line: 187, column: 1, scope: !561)
!1495 = !DILocation(line: 187, column: 1, scope: !563)
!1496 = distinct !{!1496, !1494, !1494, !383, !384}
!1497 = !DILocation(line: 187, column: 1, scope: !551)
!1498 = !DILocation(line: 0, scope: !540)
!1499 = !DILocation(line: 190, column: 3, scope: !547)
!1500 = !DILocation(line: 191, column: 3, scope: !540)
!1501 = !DILocation(line: 192, column: 3, scope: !540)
!1502 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1503, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !301, retainedNodes: !1505)
!1503 = !DISubroutineType(types: !1504)
!1504 = !{!206, !206, !890}
!1505 = !{!1506, !1507, !1508, !1509, !1510, !1511, !1512, !1513, !1514}
!1506 = !DILocalVariable(name: "argc", arg: 1, scope: !1502, file: !170, line: 14, type: !206)
!1507 = !DILocalVariable(name: "argv", arg: 2, scope: !1502, file: !170, line: 14, type: !890)
!1508 = !DILocalVariable(name: "in_file", scope: !1502, file: !170, line: 17, type: !242)
!1509 = !DILocalVariable(name: "check_file", scope: !1502, file: !170, line: 19, type: !242)
!1510 = !DILocalVariable(name: "in_fd", scope: !1502, file: !170, line: 34, type: !206)
!1511 = !DILocalVariable(name: "data", scope: !1502, file: !170, line: 35, type: !242)
!1512 = !DILocalVariable(name: "out_fd", scope: !1502, file: !170, line: 46, type: !206)
!1513 = !DILocalVariable(name: "check_fd", scope: !1502, file: !170, line: 55, type: !206)
!1514 = !DILocalVariable(name: "ref", scope: !1502, file: !170, line: 56, type: !242)
!1515 = !DILocation(line: 0, scope: !1502)
!1516 = !DILocation(line: 21, column: 3, scope: !1517)
!1517 = distinct !DILexicalBlock(scope: !1518, file: !170, line: 21, column: 3)
!1518 = distinct !DILexicalBlock(scope: !1502, file: !170, line: 21, column: 3)
!1519 = !DILocation(line: 26, column: 11, scope: !1520)
!1520 = distinct !DILexicalBlock(scope: !1502, file: !170, line: 26, column: 7)
!1521 = !DILocation(line: 26, column: 7, scope: !1502)
!1522 = !DILocation(line: 27, column: 15, scope: !1520)
!1523 = !DILocation(line: 29, column: 11, scope: !1524)
!1524 = distinct !DILexicalBlock(scope: !1502, file: !170, line: 29, column: 7)
!1525 = !DILocation(line: 29, column: 7, scope: !1502)
!1526 = !DILocation(line: 30, column: 18, scope: !1524)
!1527 = !DILocation(line: 30, column: 5, scope: !1524)
!1528 = !DILocation(line: 36, column: 17, scope: !1502)
!1529 = !DILocation(line: 36, column: 10, scope: !1502)
!1530 = !DILocation(line: 37, column: 3, scope: !1531)
!1531 = distinct !DILexicalBlock(scope: !1532, file: !170, line: 37, column: 3)
!1532 = distinct !DILexicalBlock(scope: !1502, file: !170, line: 37, column: 3)
!1533 = !DILocation(line: 38, column: 11, scope: !1502)
!1534 = !DILocation(line: 39, column: 3, scope: !1535)
!1535 = distinct !DILexicalBlock(scope: !1536, file: !170, line: 39, column: 3)
!1536 = distinct !DILexicalBlock(scope: !1502, file: !170, line: 39, column: 3)
!1537 = !DILocation(line: 40, column: 3, scope: !1502)
!1538 = !DILocation(line: 0, scope: !391, inlinedAt: !1539)
!1539 = distinct !DILocation(line: 43, column: 3, scope: !1502)
!1540 = !DILocation(line: 10, column: 26, scope: !391, inlinedAt: !1539)
!1541 = !DILocation(line: 10, column: 38, scope: !391, inlinedAt: !1539)
!1542 = !DILocation(line: 10, column: 59, scope: !391, inlinedAt: !1539)
!1543 = !DILocation(line: 10, column: 70, scope: !391, inlinedAt: !1539)
!1544 = !DILocation(line: 0, scope: !334, inlinedAt: !1545)
!1545 = distinct !DILocation(line: 10, column: 3, scope: !391, inlinedAt: !1539)
!1546 = !DILocation(line: 12, column: 5, scope: !334, inlinedAt: !1545)
!1547 = !DILocation(line: 14, column: 25, scope: !351, inlinedAt: !1545)
!1548 = !DILocation(line: 12, column: 14, scope: !353, inlinedAt: !1545)
!1549 = !DILocation(line: 0, scope: !351, inlinedAt: !1545)
!1550 = !DILocation(line: 15, column: 38, scope: !351, inlinedAt: !1545)
!1551 = !DILocation(line: 15, column: 23, scope: !351, inlinedAt: !1545)
!1552 = !DILocation(line: 16, column: 9, scope: !351, inlinedAt: !1545)
!1553 = !DILocation(line: 16, column: 40, scope: !365, inlinedAt: !1545)
!1554 = !DILocation(line: 16, column: 18, scope: !366, inlinedAt: !1545)
!1555 = !DILocation(line: 17, column: 18, scope: !369, inlinedAt: !1545)
!1556 = !DILocation(line: 17, column: 31, scope: !369, inlinedAt: !1545)
!1557 = !DILocation(line: 17, column: 27, scope: !369, inlinedAt: !1545)
!1558 = !DILocation(line: 17, column: 25, scope: !369, inlinedAt: !1545)
!1559 = !DILocation(line: 18, column: 23, scope: !369, inlinedAt: !1545)
!1560 = !DILocation(line: 16, column: 52, scope: !365, inlinedAt: !1545)
!1561 = distinct !{!1561, !1554, !1562, !383, !384}
!1562 = !DILocation(line: 19, column: 9, scope: !366, inlinedAt: !1545)
!1563 = !DILocation(line: 20, column: 9, scope: !351, inlinedAt: !1545)
!1564 = !DILocation(line: 20, column: 16, scope: !351, inlinedAt: !1545)
!1565 = !DILocation(line: 12, column: 27, scope: !352, inlinedAt: !1545)
!1566 = distinct !{!1566, !1548, !1567, !383, !384}
!1567 = !DILocation(line: 21, column: 5, scope: !353, inlinedAt: !1545)
!1568 = !DILocation(line: 47, column: 12, scope: !1502)
!1569 = !DILocation(line: 48, column: 3, scope: !1570)
!1570 = distinct !DILexicalBlock(scope: !1571, file: !170, line: 48, column: 3)
!1571 = distinct !DILexicalBlock(scope: !1502, file: !170, line: 48, column: 3)
!1572 = !DILocation(line: 0, scope: !640, inlinedAt: !1573)
!1573 = distinct !DILocation(line: 49, column: 3, scope: !1502)
!1574 = !DILocation(line: 0, scope: !540, inlinedAt: !1575)
!1575 = distinct !DILocation(line: 81, column: 3, scope: !640, inlinedAt: !1573)
!1576 = !DILocation(line: 190, column: 3, scope: !547, inlinedAt: !1575)
!1577 = !DILocation(line: 191, column: 3, scope: !540, inlinedAt: !1575)
!1578 = !DILocation(line: 0, scope: !551, inlinedAt: !1579)
!1579 = distinct !DILocation(line: 82, column: 3, scope: !640, inlinedAt: !1573)
!1580 = !DILocation(line: 187, column: 1, scope: !561, inlinedAt: !1579)
!1581 = !DILocation(line: 187, column: 1, scope: !563, inlinedAt: !1579)
!1582 = !DILocation(line: 187, column: 1, scope: !564, inlinedAt: !1579)
!1583 = distinct !{!1583, !1580, !1580, !383, !384}
!1584 = !DILocation(line: 50, column: 3, scope: !1502)
!1585 = !DILocation(line: 57, column: 16, scope: !1502)
!1586 = !DILocation(line: 57, column: 9, scope: !1502)
!1587 = !DILocation(line: 58, column: 3, scope: !1588)
!1588 = distinct !DILexicalBlock(scope: !1589, file: !170, line: 58, column: 3)
!1589 = distinct !DILexicalBlock(scope: !1502, file: !170, line: 58, column: 3)
!1590 = !DILocation(line: 59, column: 14, scope: !1502)
!1591 = !DILocation(line: 60, column: 3, scope: !1592)
!1592 = distinct !DILexicalBlock(scope: !1593, file: !170, line: 60, column: 3)
!1593 = distinct !DILexicalBlock(scope: !1502, file: !170, line: 60, column: 3)
!1594 = !DILocation(line: 0, scope: !609, inlinedAt: !1595)
!1595 = distinct !DILocation(line: 61, column: 3, scope: !1502)
!1596 = !DILocation(line: 71, column: 7, scope: !609, inlinedAt: !1595)
!1597 = !DILocation(line: 0, scope: !440, inlinedAt: !1598)
!1598 = distinct !DILocation(line: 73, column: 7, scope: !609, inlinedAt: !1595)
!1599 = !DILocation(line: 64, column: 17, scope: !440, inlinedAt: !1598)
!1600 = !DILocation(line: 64, column: 3, scope: !440, inlinedAt: !1598)
!1601 = !DILocation(line: 66, column: 22, scope: !452, inlinedAt: !1598)
!1602 = !DILocation(line: 66, column: 26, scope: !452, inlinedAt: !1598)
!1603 = !DILocation(line: 66, column: 32, scope: !452, inlinedAt: !1598)
!1604 = !DILocation(line: 66, column: 35, scope: !452, inlinedAt: !1598)
!1605 = !DILocation(line: 66, column: 39, scope: !452, inlinedAt: !1598)
!1606 = !DILocation(line: 66, column: 9, scope: !453, inlinedAt: !1598)
!1607 = !DILocation(line: 69, column: 6, scope: !453, inlinedAt: !1598)
!1608 = !DILocation(line: 64, column: 10, scope: !440, inlinedAt: !1598)
!1609 = !DILocation(line: 64, column: 13, scope: !440, inlinedAt: !1598)
!1610 = distinct !{!1610, !1600, !1611, !383, !384}
!1611 = !DILocation(line: 70, column: 3, scope: !440, inlinedAt: !1598)
!1612 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !1598)
!1613 = !DILocation(line: 71, column: 8, scope: !465, inlinedAt: !1598)
!1614 = !DILocation(line: 71, column: 6, scope: !440, inlinedAt: !1598)
!1615 = !DILocation(line: 74, column: 37, scope: !609, inlinedAt: !1595)
!1616 = !DILocation(line: 74, column: 3, scope: !609, inlinedAt: !1595)
!1617 = !DILocation(line: 75, column: 3, scope: !609, inlinedAt: !1595)
!1618 = !DILocation(line: 0, scope: !658, inlinedAt: !1619)
!1619 = distinct !DILocation(line: 66, column: 8, scope: !1620)
!1620 = distinct !DILexicalBlock(scope: !1502, file: !170, line: 66, column: 7)
!1621 = !DILocation(line: 92, column: 3, scope: !671, inlinedAt: !1619)
!1622 = !DILocation(line: 93, column: 12, scope: !673, inlinedAt: !1619)
!1623 = !DILocation(line: 93, column: 27, scope: !673, inlinedAt: !1619)
!1624 = !DILocation(line: 93, column: 25, scope: !673, inlinedAt: !1619)
!1625 = !DILocation(line: 94, column: 35, scope: !673, inlinedAt: !1619)
!1626 = !DILocation(line: 94, column: 16, scope: !673, inlinedAt: !1619)
!1627 = !DILocation(line: 92, column: 18, scope: !674, inlinedAt: !1619)
!1628 = !DILocation(line: 92, column: 13, scope: !674, inlinedAt: !1619)
!1629 = distinct !{!1629, !1621, !1630, !383, !384}
!1630 = !DILocation(line: 95, column: 3, scope: !671, inlinedAt: !1619)
!1631 = !DILocation(line: 98, column: 10, scope: !658, inlinedAt: !1619)
!1632 = !DILocation(line: 66, column: 7, scope: !1502)
!1633 = !DILocation(line: 67, column: 13, scope: !1634)
!1634 = distinct !DILexicalBlock(scope: !1620, file: !170, line: 66, column: 32)
!1635 = !DILocation(line: 67, column: 5, scope: !1634)
!1636 = !DILocation(line: 68, column: 5, scope: !1634)
!1637 = !DILocation(line: 71, column: 3, scope: !1502)
!1638 = !DILocation(line: 72, column: 3, scope: !1502)
!1639 = !DILocation(line: 74, column: 3, scope: !1502)
!1640 = !DILocation(line: 75, column: 3, scope: !1502)
!1641 = !DILocation(line: 76, column: 1, scope: !1502)
!1642 = !DISubprogram(name: "open", scope: !1643, file: !1643, line: 209, type: !1644, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1643 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1644 = !DISubroutineType(types: !1645)
!1645 = !{!206, !771, !206, null}
