; ModuleID = 'fft/transpose/fft_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.bench_args_t = type { [512 x double], [512 x double] }
%struct.stat = type { i64, i64, i32, i32, i32, i32, i64, i64, i64, i32, i32, i64, %struct.timespec, %struct.timespec, %struct.timespec, [2 x i32] }
%struct.timespec = type { i64, i64 }

@__const.fft.reversed = private unnamed_addr constant [8 x i32] [i32 0, i32 4, i32 2, i32 6, i32 1, i32 5, i32 3, i32 7], align 4
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
@INPUT_SIZE = dso_local local_unnamed_addr global i32 8192, align 4, !dbg !186
@.str.6.14 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !203
@.str.8.15 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !206
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !209
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !214
@.str.12.16 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !217
@.str.14.17 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !219
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !222
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree nounwind memory(write, argmem: readwrite) uwtable
define dso_local void @twiddles8(ptr nocapture noundef %a_x, ptr nocapture noundef %a_y, i32 noundef signext %i, i32 noundef signext %n) local_unnamed_addr #0 !dbg !324 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(ptr %a_x, !329, !DIExpression(), !343)
    #dbg_value(ptr %a_y, !330, !DIExpression(), !343)
    #dbg_value(i32 %i, !331, !DIExpression(), !343)
    #dbg_value(i32 %n, !332, !DIExpression(), !343)
    #dbg_label(!342, !344)
    #dbg_value(i32 1, !337, !DIExpression(), !343)
  %conv1 = sitofp i32 %n to double
  %conv2 = sitofp i32 %i to double
  store i64 1, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !345

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !337, !DIExpression(), !343)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds [8 x i32], ptr @__const.fft.reversed, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !347
  %0 = load i32, ptr %arrayidx, align 4, !dbg !347, !tbaa !350
  %conv = sitofp i32 %0 to double, !dbg !347
  %mul = fmul double %conv, 0xC01921FB54411744, !dbg !354
  %div = fdiv double %mul, %conv1, !dbg !355
  %mul3 = fmul double %div, %conv2, !dbg !356
    #dbg_value(double %mul3, !338, !DIExpression(), !343)
  %call = tail call double @cos(double noundef %mul3) #19, !dbg !357
    #dbg_value(double %call, !340, !DIExpression(), !343)
  %call4 = tail call double @sin(double noundef %mul3) #19, !dbg !358
    #dbg_value(double %call4, !341, !DIExpression(), !343)
  %arrayidx6 = getelementptr inbounds double, ptr %a_x, i64 %indvars.iv.reg2mem.0.load, !dbg !359
  %1 = load double, ptr %arrayidx6, align 8, !dbg !359, !tbaa !360
    #dbg_value(double %1, !339, !DIExpression(), !343)
  %arrayidx11 = getelementptr inbounds double, ptr %a_y, i64 %indvars.iv.reg2mem.0.load, !dbg !362
  %2 = load double, ptr %arrayidx11, align 8, !dbg !362, !tbaa !360
  %3 = fneg double %2, !dbg !362
  %neg = fmul double %call4, %3, !dbg !362
  %4 = tail call double @llvm.fmuladd.f64(double %1, double %call, double %neg), !dbg !362
  store double %4, ptr %arrayidx6, align 8, !dbg !363, !tbaa !360
  %5 = load double, ptr %arrayidx11, align 8, !dbg !364, !tbaa !360
  %mul18 = fmul double %call, %5, !dbg !364
  %6 = tail call double @llvm.fmuladd.f64(double %1, double %call4, double %mul18), !dbg !364
  store double %6, ptr %arrayidx11, align 8, !dbg !365, !tbaa !360
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !366
    #dbg_value(i64 %indvars.iv.next, !337, !DIExpression(), !343)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 8, !dbg !367
  br i1 %exitcond.not, label %for.end, label %for.body.for.body_crit_edge, !dbg !345, !llvm.loop !368

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !345

for.end:                                          ; preds = %for.body
  ret void, !dbg !372
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare !dbg !373 double @cos(double noundef) local_unnamed_addr #1

; Function Attrs: mustprogress nofree nounwind willreturn memory(write)
declare !dbg !377 double @sin(double noundef) local_unnamed_addr #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #2

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @loadx8(ptr nocapture noundef writeonly %a_x, ptr nocapture noundef readonly %x, i32 noundef signext %offset, i32 noundef signext %sx) local_unnamed_addr #3 !dbg !378 {
entry.split:
  %i.06.reg2mem = alloca i64, align 8
    #dbg_value(ptr %a_x, !380, !DIExpression(), !388)
    #dbg_value(ptr %x, !381, !DIExpression(), !388)
    #dbg_value(i32 %offset, !382, !DIExpression(), !388)
    #dbg_value(i32 %sx, !383, !DIExpression(), !388)
    #dbg_value(i64 0, !384, !DIExpression(), !389)
  %conv = sext i32 %sx to i64
  %conv1 = sext i32 %offset to i64
  %invariant.gep = getelementptr double, ptr %x, i64 %conv1, !dbg !390
  store i64 0, ptr %i.06.reg2mem, align 8
  br label %for.body, !dbg !391

for.cond.cleanup:                                 ; preds = %for.body
  ret void, !dbg !392

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i64 %i.06.reg2mem.0.load, !384, !DIExpression(), !389)
  %i.06.reg2mem.0.load = load i64, ptr %i.06.reg2mem, align 8
  %mul = mul nsw i64 %i.06.reg2mem.0.load, %conv, !dbg !393
  %gep = getelementptr double, ptr %invariant.gep, i64 %mul, !dbg !396
  %0 = load double, ptr %gep, align 8, !dbg !396, !tbaa !360
  %arrayidx2 = getelementptr inbounds double, ptr %a_x, i64 %i.06.reg2mem.0.load, !dbg !397
  store double %0, ptr %arrayidx2, align 8, !dbg !398, !tbaa !360
  %inc = add nuw nsw i64 %i.06.reg2mem.0.load, 1, !dbg !399
    #dbg_value(i64 %inc, !384, !DIExpression(), !389)
  %exitcond.not = icmp eq i64 %inc, 8, !dbg !400
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body.for.body_crit_edge, !dbg !391, !llvm.loop !401

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %inc, ptr %i.06.reg2mem, align 8
  br label %for.body, !dbg !391
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @loady8(ptr nocapture noundef writeonly %a_y, ptr nocapture noundef readonly %x, i32 noundef signext %offset, i32 noundef signext %sx) local_unnamed_addr #3 !dbg !403 {
entry.split:
  %i.06.reg2mem = alloca i64, align 8
    #dbg_value(ptr %a_y, !405, !DIExpression(), !411)
    #dbg_value(ptr %x, !406, !DIExpression(), !411)
    #dbg_value(i32 %offset, !407, !DIExpression(), !411)
    #dbg_value(i32 %sx, !408, !DIExpression(), !411)
    #dbg_value(i64 0, !409, !DIExpression(), !412)
  %conv = sext i32 %sx to i64
  %conv1 = sext i32 %offset to i64
  %invariant.gep = getelementptr double, ptr %x, i64 %conv1, !dbg !413
  store i64 0, ptr %i.06.reg2mem, align 8
  br label %for.body, !dbg !414

for.cond.cleanup:                                 ; preds = %for.body
  ret void, !dbg !415

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i64 %i.06.reg2mem.0.load, !409, !DIExpression(), !412)
  %i.06.reg2mem.0.load = load i64, ptr %i.06.reg2mem, align 8
  %mul = mul nsw i64 %i.06.reg2mem.0.load, %conv, !dbg !416
  %gep = getelementptr double, ptr %invariant.gep, i64 %mul, !dbg !419
  %0 = load double, ptr %gep, align 8, !dbg !419, !tbaa !360
  %arrayidx2 = getelementptr inbounds double, ptr %a_y, i64 %i.06.reg2mem.0.load, !dbg !420
  store double %0, ptr %arrayidx2, align 8, !dbg !421, !tbaa !360
  %inc = add nuw nsw i64 %i.06.reg2mem.0.load, 1, !dbg !422
    #dbg_value(i64 %inc, !409, !DIExpression(), !412)
  %exitcond.not = icmp eq i64 %inc, 8, !dbg !423
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body.for.body_crit_edge, !dbg !414, !llvm.loop !424

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %inc, ptr %i.06.reg2mem, align 8
  br label %for.body, !dbg !414
}

; Function Attrs: nofree nounwind memory(write, argmem: readwrite) uwtable
define dso_local void @fft(ptr nocapture noundef %work_x, ptr nocapture noundef %work_y) local_unnamed_addr #0 !dbg !426 {
entry.split:
  %DATA_x = alloca [512 x double], align 8, !DIAssignID !652
    #dbg_assign(i1 undef, !437, !DIExpression(), !652, ptr %DATA_x, !DIExpression(), !653)
  %DATA_y = alloca [512 x double], align 8, !DIAssignID !654
    #dbg_assign(i1 undef, !438, !DIExpression(), !654, ptr %DATA_y, !DIExpression(), !653)
  %data_x = alloca [8 x double], align 8, !DIAssignID !655
    #dbg_assign(i1 undef, !439, !DIExpression(), !655, ptr %data_x, !DIExpression(), !653)
  %data_y = alloca [8 x double], align 8, !DIAssignID !656
    #dbg_assign(i1 undef, !441, !DIExpression(), !656, ptr %data_y, !DIExpression(), !653)
  %smem = alloca [576 x double], align 8, !DIAssignID !657
    #dbg_assign(i1 undef, !442, !DIExpression(), !657, ptr %smem, !DIExpression(), !653)
    #dbg_value(ptr %work_x, !430, !DIExpression(), !653)
    #dbg_value(ptr %work_y, !431, !DIExpression(), !653)
  %indvars.iv.next1936.reg2mem = alloca i64, align 8
  %indvar.next1929.reg2mem = alloca i64, align 8
  %inc871.reg2mem = alloca i32, align 4
  %indvars.iv.next.i1841.reg2mem = alloca i64, align 8
  %conv2.i1827.reg2mem = alloca double, align 8
  %scevgep1932.reg2mem = alloca ptr, align 8
  %scevgep1933.reg2mem = alloca ptr, align 8
  %tid.51866.reg2mem = alloca i32, align 4
  %indvar1928.reg2mem = alloca i64, align 8
  %indvar.next1924.reg2mem = alloca i64, align 8
  %inc548.reg2mem = alloca i32, align 4
  %inc.i.reg2mem = alloca i64, align 8
  %invariant.gep.i.reg2mem = alloca ptr, align 8
  %scevgep1926.reg2mem = alloca ptr, align 8
  %tid.41862.reg2mem = alloca i32, align 4
  %indvar1923.reg2mem = alloca i64, align 8
  %indvars.iv.next1906.reg2mem = alloca i64, align 8
  %indvars.iv.next1895.reg2mem = alloca i64, align 8
  %indvars.iv.next.reg2mem = alloca i64, align 8
  %inc.reg2mem = alloca i64, align 8
  %indvar.next.reg2mem = alloca i64, align 8
  %indvars.iv.next.i.reg2mem = alloca i64, align 8
  %conv2.i.reg2mem = alloca double, align 8
  %.reg2mem = alloca i64, align 8
  %indvar.reg2mem = alloca i64, align 8
  %arrayidx64.reg2mem = alloca ptr, align 8
  %arrayidx61.reg2mem = alloca ptr, align 8
  %arrayidx60.reg2mem = alloca ptr, align 8
  %arrayidx58.reg2mem = alloca ptr, align 8
  %arrayidx48.reg2mem = alloca ptr, align 8
  %arrayidx45.reg2mem = alloca ptr, align 8
  %arrayidx44.reg2mem = alloca ptr, align 8
  %arrayidx42.reg2mem = alloca ptr, align 8
  %arrayidx32.reg2mem = alloca ptr, align 8
  %arrayidx29.reg2mem = alloca ptr, align 8
  %arrayidx28.reg2mem = alloca ptr, align 8
  %arrayidx26.reg2mem = alloca ptr, align 8
  %arrayidx17.reg2mem = alloca ptr, align 8
  %arrayidx14.reg2mem = alloca ptr, align 8
  %i1428.01874.reg2mem = alloca i64, align 8
  %indvar1987.reg2mem106 = alloca i64, align 8
  %i.06.i1847.reg2mem = alloca i64, align 8
  %tid.91872.reg2mem108 = alloca i32, align 4
  %indvar1982.reg2mem110 = alloca i64, align 8
  %indvars.iv1964.reg2mem = alloca i64, align 8
  %indvars.iv1953.reg2mem = alloca i64, align 8
  %indvars.iv1935.reg2mem = alloca i64, align 8
  %indvars.iv.i1829.reg2mem = alloca i64, align 8
  %tid.51866.reg2mem112 = alloca i32, align 4
  %indvar1928.reg2mem114 = alloca i64, align 8
  %i.06.i.reg2mem = alloca i64, align 8
  %tid.41862.reg2mem116 = alloca i32, align 4
  %indvar1923.reg2mem118 = alloca i64, align 8
  %indvars.iv1905.reg2mem = alloca i64, align 8
  %indvars.iv1894.reg2mem = alloca i64, align 8
  %indvars.iv.reg2mem = alloca i64, align 8
  %i.01854.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %indvar.reg2mem120 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 4096, ptr nonnull %DATA_x) #19, !dbg !658
  call void @llvm.lifetime.start.p0(i64 4096, ptr nonnull %DATA_y) #19, !dbg !659
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %data_x) #19, !dbg !660
  call void @llvm.lifetime.start.p0(i64 64, ptr nonnull %data_y) #19, !dbg !661
  call void @llvm.lifetime.start.p0(i64 4608, ptr nonnull %smem) #19, !dbg !662
    #dbg_value(i32 64, !435, !DIExpression(), !653)
    #dbg_label(!446, !663)
    #dbg_value(i32 0, !432, !DIExpression(), !653)
  %arrayidx14 = getelementptr inbounds i8, ptr %data_x, i64 32
  store ptr %arrayidx14, ptr %arrayidx14.reg2mem, align 8
  %arrayidx17 = getelementptr inbounds i8, ptr %data_y, i64 32
  store ptr %arrayidx17, ptr %arrayidx17.reg2mem, align 8
  %arrayidx26 = getelementptr inbounds i8, ptr %data_x, i64 8
  store ptr %arrayidx26, ptr %arrayidx26.reg2mem, align 8
  %arrayidx28 = getelementptr inbounds i8, ptr %data_y, i64 8
  store ptr %arrayidx28, ptr %arrayidx28.reg2mem, align 8
  %arrayidx29 = getelementptr inbounds i8, ptr %data_x, i64 40
  store ptr %arrayidx29, ptr %arrayidx29.reg2mem, align 8
  %arrayidx32 = getelementptr inbounds i8, ptr %data_y, i64 40
  store ptr %arrayidx32, ptr %arrayidx32.reg2mem, align 8
  %arrayidx42 = getelementptr inbounds i8, ptr %data_x, i64 16
  store ptr %arrayidx42, ptr %arrayidx42.reg2mem, align 8
  %arrayidx44 = getelementptr inbounds i8, ptr %data_y, i64 16
  store ptr %arrayidx44, ptr %arrayidx44.reg2mem, align 8
  %arrayidx45 = getelementptr inbounds i8, ptr %data_x, i64 48
  store ptr %arrayidx45, ptr %arrayidx45.reg2mem, align 8
  %arrayidx48 = getelementptr inbounds i8, ptr %data_y, i64 48
  store ptr %arrayidx48, ptr %arrayidx48.reg2mem, align 8
  %arrayidx58 = getelementptr inbounds i8, ptr %data_x, i64 24
  store ptr %arrayidx58, ptr %arrayidx58.reg2mem, align 8
  %arrayidx60 = getelementptr inbounds i8, ptr %data_y, i64 24
  store ptr %arrayidx60, ptr %arrayidx60.reg2mem, align 8
  %arrayidx61 = getelementptr inbounds i8, ptr %data_x, i64 56
  store ptr %arrayidx61, ptr %arrayidx61.reg2mem, align 8
  %arrayidx64 = getelementptr inbounds i8, ptr %data_y, i64 56
  store ptr %arrayidx64, ptr %arrayidx64.reg2mem, align 8
  store i64 0, ptr %indvar.reg2mem120, align 8
  br label %for.cond1.preheader, !dbg !664

for.cond1.preheader:                              ; preds = %for.cond266.preheader.for.cond1.preheader_crit_edge, %entry.split
    #dbg_value(i64 %indvar.reg2mem120.0.load, !432, !DIExpression(), !653)
  %indvar.reg2mem120.0.load = load i64, ptr %indvar.reg2mem120, align 8
  store i64 %indvar.reg2mem120.0.load, ptr %indvar.reg2mem, align 8
  %0 = shl nuw nsw i64 %indvar.reg2mem120.0.load, 6
    #dbg_value(i64 0, !447, !DIExpression(), !665)
  store i64 %0, ptr %.reg2mem, align 8
  store i64 0, ptr %i.01854.reg2mem, align 8
  br label %for.body3, !dbg !666

for.cond.cleanup:                                 ; preds = %for.body3
    #dbg_value(double 1.000000e+00, !452, !DIExpression(), !667)
    #dbg_value(double -1.000000e+00, !456, !DIExpression(), !667)
    #dbg_value(double 0.000000e+00, !454, !DIExpression(), !667)
    #dbg_value(double -1.000000e+00, !457, !DIExpression(), !667)
    #dbg_value(double -1.000000e+00, !455, !DIExpression(), !667)
    #dbg_value(double -1.000000e+00, !458, !DIExpression(), !667)
  %1 = load double, ptr %data_x, align 8, !dbg !668, !tbaa !360
    #dbg_value(double %1, !460, !DIExpression(), !669)
  %2 = load double, ptr %data_y, align 8, !dbg !668, !tbaa !360
    #dbg_value(double %2, !462, !DIExpression(), !669)
  %3 = load double, ptr %arrayidx14, align 8, !dbg !668, !tbaa !360
  %add15 = fadd double %1, %3, !dbg !668
    #dbg_assign(double %add15, !439, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !670, ptr %data_x, !DIExpression(), !653)
  %4 = load double, ptr %arrayidx17, align 8, !dbg !668, !tbaa !360
  %add18 = fadd double %2, %4, !dbg !668
    #dbg_assign(double %add18, !441, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !671, ptr %data_y, !DIExpression(), !653)
  %sub = fsub double %1, %3, !dbg !668
    #dbg_assign(double %sub, !439, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !672, ptr %arrayidx14, !DIExpression(), !653)
  %sub23 = fsub double %2, %4, !dbg !668
    #dbg_assign(double %sub23, !441, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !673, ptr %arrayidx17, !DIExpression(), !653)
  %5 = load double, ptr %arrayidx26, align 8, !dbg !674, !tbaa !360
    #dbg_value(double %5, !463, !DIExpression(), !675)
  %6 = load double, ptr %arrayidx28, align 8, !dbg !674, !tbaa !360
    #dbg_value(double %6, !465, !DIExpression(), !675)
  %7 = load double, ptr %arrayidx29, align 8, !dbg !674, !tbaa !360
  %add30 = fadd double %5, %7, !dbg !674
    #dbg_assign(double %add30, !439, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !676, ptr %arrayidx26, !DIExpression(), !653)
  %8 = load double, ptr %arrayidx32, align 8, !dbg !674, !tbaa !360
  %add33 = fadd double %6, %8, !dbg !674
    #dbg_assign(double %add33, !441, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !677, ptr %arrayidx28, !DIExpression(), !653)
  %sub36 = fsub double %5, %7, !dbg !674
    #dbg_assign(double %sub36, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !678, ptr %arrayidx29, !DIExpression(), !653)
  %sub39 = fsub double %6, %8, !dbg !674
    #dbg_assign(double %sub39, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !679, ptr %arrayidx32, !DIExpression(), !653)
  %9 = load double, ptr %arrayidx42, align 8, !dbg !680, !tbaa !360
    #dbg_value(double %9, !466, !DIExpression(), !681)
  %10 = load double, ptr %arrayidx44, align 8, !dbg !680, !tbaa !360
    #dbg_value(double %10, !468, !DIExpression(), !681)
  %11 = load double, ptr %arrayidx45, align 8, !dbg !680, !tbaa !360
  %add46 = fadd double %9, %11, !dbg !680
    #dbg_assign(double %add46, !439, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !682, ptr %arrayidx42, !DIExpression(), !653)
  %12 = load double, ptr %arrayidx48, align 8, !dbg !680, !tbaa !360
  %add49 = fadd double %10, %12, !dbg !680
    #dbg_assign(double %add49, !441, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !683, ptr %arrayidx44, !DIExpression(), !653)
  %sub52 = fsub double %9, %11, !dbg !680
    #dbg_assign(double %sub52, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !684, ptr %arrayidx45, !DIExpression(), !653)
  %sub55 = fsub double %10, %12, !dbg !680
    #dbg_assign(double %sub55, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !685, ptr %arrayidx48, !DIExpression(), !653)
  %13 = load double, ptr %arrayidx58, align 8, !dbg !686, !tbaa !360
    #dbg_value(double %13, !469, !DIExpression(), !687)
  %14 = load double, ptr %arrayidx60, align 8, !dbg !686, !tbaa !360
    #dbg_value(double %14, !471, !DIExpression(), !687)
  %15 = load double, ptr %arrayidx61, align 8, !dbg !686, !tbaa !360
  %add62 = fadd double %13, %15, !dbg !686
    #dbg_assign(double %add62, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !688, ptr %arrayidx58, !DIExpression(), !653)
  %16 = load double, ptr %arrayidx64, align 8, !dbg !686, !tbaa !360
  %add65 = fadd double %14, %16, !dbg !686
    #dbg_assign(double %add65, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !689, ptr %arrayidx60, !DIExpression(), !653)
  %sub68 = fsub double %13, %15, !dbg !686
    #dbg_assign(double %sub68, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !690, ptr %arrayidx61, !DIExpression(), !653)
  %sub71 = fsub double %14, %16, !dbg !686
    #dbg_assign(double %sub71, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !691, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double %sub36, !459, !DIExpression(), !667)
  %17 = fadd double %sub36, %sub39, !dbg !692
  %mul78 = fmul double %17, 0x3FE6A09E667F3BCD, !dbg !692
    #dbg_assign(double %mul78, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !693, ptr %arrayidx29, !DIExpression(), !653)
  %18 = fsub double %sub39, %sub36, !dbg !692
  %mul83 = fmul double %18, 0x3FE6A09E667F3BCD, !dbg !692
    #dbg_assign(double %mul83, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !694, ptr %arrayidx32, !DIExpression(), !653)
    #dbg_value(double %sub52, !459, !DIExpression(), !667)
  %19 = tail call double @llvm.fmuladd.f64(double %sub52, double 0.000000e+00, double %sub55), !dbg !692
    #dbg_assign(double %19, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !695, ptr %arrayidx45, !DIExpression(), !653)
  %mul94 = fmul double %sub55, 0.000000e+00, !dbg !692
  %20 = fsub double %mul94, %sub52, !dbg !692
    #dbg_assign(double %20, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !696, ptr %arrayidx48, !DIExpression(), !653)
    #dbg_value(double %sub68, !459, !DIExpression(), !667)
  %21 = fsub double %sub71, %sub68, !dbg !692
  %mul102 = fmul double %21, 0x3FE6A09E667F3BCD, !dbg !692
    #dbg_assign(double %mul102, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !697, ptr %arrayidx61, !DIExpression(), !653)
  %mul106 = fneg double %sub71, !dbg !692
  %22 = fsub double %mul106, %sub68, !dbg !692
  %mul107 = fmul double %22, 0x3FE6A09E667F3BCD, !dbg !692
    #dbg_assign(double %mul107, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !698, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double 0.000000e+00, !472, !DIExpression(), !699)
    #dbg_value(double -1.000000e+00, !474, !DIExpression(), !699)
    #dbg_value(double %add15, !476, !DIExpression(), !700)
    #dbg_value(double %add18, !478, !DIExpression(), !700)
  %add114 = fadd double %add15, %add46, !dbg !701
    #dbg_assign(double %add114, !439, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !702, ptr %data_x, !DIExpression(), !653)
  %add117 = fadd double %add18, %add49, !dbg !701
    #dbg_assign(double %add117, !441, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !703, ptr %data_y, !DIExpression(), !653)
  %sub120 = fsub double %add15, %add46, !dbg !701
    #dbg_assign(double %sub120, !439, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !704, ptr %arrayidx42, !DIExpression(), !653)
  %sub123 = fsub double %add18, %add49, !dbg !701
    #dbg_assign(double %sub123, !441, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !705, ptr %arrayidx44, !DIExpression(), !653)
    #dbg_value(double %add30, !479, !DIExpression(), !706)
    #dbg_value(double %add33, !481, !DIExpression(), !706)
  %add130 = fadd double %add30, %add62, !dbg !707
    #dbg_assign(double %add130, !439, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !708, ptr %arrayidx26, !DIExpression(), !653)
  %add133 = fadd double %add33, %add65, !dbg !707
    #dbg_assign(double %add133, !441, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !709, ptr %arrayidx28, !DIExpression(), !653)
  %sub136 = fsub double %add30, %add62, !dbg !707
    #dbg_assign(double %sub136, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !710, ptr %arrayidx58, !DIExpression(), !653)
  %sub139 = fsub double %add33, %add65, !dbg !707
    #dbg_assign(double %sub139, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !711, ptr %arrayidx60, !DIExpression(), !653)
    #dbg_value(double %sub136, !475, !DIExpression(), !699)
  %23 = tail call double @llvm.fmuladd.f64(double %sub136, double 0.000000e+00, double %sub139), !dbg !712
    #dbg_assign(double %23, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !713, ptr %arrayidx58, !DIExpression(), !653)
  %neg151 = fmul double %sub139, -0.000000e+00, !dbg !712
  %24 = fsub double %neg151, %sub136, !dbg !712
    #dbg_assign(double %24, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !714, ptr %arrayidx60, !DIExpression(), !653)
    #dbg_value(double %add114, !482, !DIExpression(), !715)
    #dbg_value(double %add117, !484, !DIExpression(), !715)
  %add158 = fadd double %add114, %add130, !dbg !716
  store double %add158, ptr %data_x, align 8, !dbg !716, !tbaa !360, !DIAssignID !717
    #dbg_assign(double %add158, !439, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !717, ptr %data_x, !DIExpression(), !653)
  %add161 = fadd double %add117, %add133, !dbg !716
  store double %add161, ptr %data_y, align 8, !dbg !716, !tbaa !360, !DIAssignID !718
    #dbg_assign(double %add161, !441, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !718, ptr %data_y, !DIExpression(), !653)
  %sub164 = fsub double %add114, %add130, !dbg !716
  store double %sub164, ptr %arrayidx26, align 8, !dbg !716, !tbaa !360, !DIAssignID !719
    #dbg_assign(double %sub164, !439, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !719, ptr %arrayidx26, !DIExpression(), !653)
  %sub167 = fsub double %add117, %add133, !dbg !716
  store double %sub167, ptr %arrayidx28, align 8, !dbg !716, !tbaa !360, !DIAssignID !720
    #dbg_assign(double %sub167, !441, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !720, ptr %arrayidx28, !DIExpression(), !653)
    #dbg_value(double %sub120, !485, !DIExpression(), !721)
    #dbg_value(double %sub123, !487, !DIExpression(), !721)
  %add174 = fadd double %sub120, %23, !dbg !722
  store double %add174, ptr %arrayidx42, align 8, !dbg !722, !tbaa !360, !DIAssignID !723
    #dbg_assign(double %add174, !439, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !723, ptr %arrayidx42, !DIExpression(), !653)
  %add177 = fadd double %sub123, %24, !dbg !722
  store double %add177, ptr %arrayidx44, align 8, !dbg !722, !tbaa !360, !DIAssignID !724
    #dbg_assign(double %add177, !441, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !724, ptr %arrayidx44, !DIExpression(), !653)
  %sub180 = fsub double %sub120, %23, !dbg !722
  store double %sub180, ptr %arrayidx58, align 8, !dbg !722, !tbaa !360, !DIAssignID !725
    #dbg_assign(double %sub180, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !725, ptr %arrayidx58, !DIExpression(), !653)
  %sub183 = fsub double %sub123, %24, !dbg !722
  store double %sub183, ptr %arrayidx60, align 8, !dbg !722, !tbaa !360, !DIAssignID !726
    #dbg_assign(double %sub183, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !726, ptr %arrayidx60, !DIExpression(), !653)
    #dbg_value(double 0.000000e+00, !488, !DIExpression(), !727)
    #dbg_value(double -1.000000e+00, !490, !DIExpression(), !727)
    #dbg_value(double %sub, !492, !DIExpression(), !728)
    #dbg_value(double %sub23, !494, !DIExpression(), !728)
  %add193 = fadd double %sub, %19, !dbg !729
    #dbg_assign(double %add193, !439, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !730, ptr %arrayidx14, !DIExpression(), !653)
  %add196 = fadd double %sub23, %20, !dbg !729
    #dbg_assign(double %add196, !441, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !731, ptr %arrayidx17, !DIExpression(), !653)
  %sub199 = fsub double %sub, %19, !dbg !729
    #dbg_assign(double %sub199, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !732, ptr %arrayidx45, !DIExpression(), !653)
  %sub202 = fsub double %sub23, %20, !dbg !729
    #dbg_assign(double %sub202, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !733, ptr %arrayidx48, !DIExpression(), !653)
    #dbg_value(double %mul78, !495, !DIExpression(), !734)
    #dbg_value(double %mul83, !497, !DIExpression(), !734)
  %add209 = fadd double %mul78, %mul102, !dbg !735
    #dbg_assign(double %add209, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !736, ptr %arrayidx29, !DIExpression(), !653)
  %add212 = fadd double %mul83, %mul107, !dbg !735
    #dbg_assign(double %add212, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !737, ptr %arrayidx32, !DIExpression(), !653)
  %sub215 = fsub double %mul78, %mul102, !dbg !735
    #dbg_assign(double %sub215, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !738, ptr %arrayidx61, !DIExpression(), !653)
  %sub218 = fsub double %mul83, %mul107, !dbg !735
    #dbg_assign(double %sub218, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !739, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double %sub215, !491, !DIExpression(), !727)
  %25 = tail call double @llvm.fmuladd.f64(double %sub215, double 0.000000e+00, double %sub218), !dbg !740
    #dbg_assign(double %25, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !741, ptr %arrayidx61, !DIExpression(), !653)
  %neg230 = fmul double %sub218, -0.000000e+00, !dbg !740
  %26 = fsub double %neg230, %sub215, !dbg !740
    #dbg_assign(double %26, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !742, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double %add193, !498, !DIExpression(), !743)
    #dbg_value(double %add196, !500, !DIExpression(), !743)
  %add237 = fadd double %add193, %add209, !dbg !744
  store double %add237, ptr %arrayidx14, align 8, !dbg !744, !tbaa !360, !DIAssignID !745
    #dbg_assign(double %add237, !439, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !745, ptr %arrayidx14, !DIExpression(), !653)
  %add240 = fadd double %add196, %add212, !dbg !744
  store double %add240, ptr %arrayidx17, align 8, !dbg !744, !tbaa !360, !DIAssignID !746
    #dbg_assign(double %add240, !441, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !746, ptr %arrayidx17, !DIExpression(), !653)
  %sub243 = fsub double %add193, %add209, !dbg !744
  store double %sub243, ptr %arrayidx29, align 8, !dbg !744, !tbaa !360, !DIAssignID !747
    #dbg_assign(double %sub243, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !747, ptr %arrayidx29, !DIExpression(), !653)
  %sub246 = fsub double %add196, %add212, !dbg !744
  store double %sub246, ptr %arrayidx32, align 8, !dbg !744, !tbaa !360, !DIAssignID !748
    #dbg_assign(double %sub246, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !748, ptr %arrayidx32, !DIExpression(), !653)
    #dbg_value(double %sub199, !501, !DIExpression(), !749)
    #dbg_value(double %sub202, !503, !DIExpression(), !749)
  %add253 = fadd double %sub199, %25, !dbg !750
  store double %add253, ptr %arrayidx45, align 8, !dbg !750, !tbaa !360, !DIAssignID !751
    #dbg_assign(double %add253, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !751, ptr %arrayidx45, !DIExpression(), !653)
  %add256 = fadd double %sub202, %26, !dbg !750
  store double %add256, ptr %arrayidx48, align 8, !dbg !750, !tbaa !360, !DIAssignID !752
    #dbg_assign(double %add256, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !752, ptr %arrayidx48, !DIExpression(), !653)
  %sub259 = fsub double %sub199, %25, !dbg !750
  store double %sub259, ptr %arrayidx61, align 8, !dbg !750, !tbaa !360, !DIAssignID !753
    #dbg_assign(double %sub259, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !753, ptr %arrayidx61, !DIExpression(), !653)
  %sub262 = fsub double %sub202, %26, !dbg !750
  store double %sub262, ptr %arrayidx64, align 8, !dbg !750, !tbaa !360, !DIAssignID !754
    #dbg_assign(double %sub262, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !754, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(ptr %data_x, !329, !DIExpression(), !755)
    #dbg_value(ptr %data_y, !330, !DIExpression(), !755)
    #dbg_value(i64 %indvar.reg2mem120.0.load, !331, !DIExpression(), !755)
    #dbg_value(i32 512, !332, !DIExpression(), !755)
    #dbg_assign(i1 undef, !333, !DIExpression(), !757, ptr @__const.fft.reversed, !DIExpression(), !755)
    #dbg_label(!342, !758)
    #dbg_value(i32 1, !337, !DIExpression(), !755)
  %27 = trunc i64 %indvar.reg2mem120.0.load to i32
  %conv2.i = sitofp i32 %27 to double
  store double %conv2.i, ptr %conv2.i.reg2mem, align 8
  store i64 1, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !759

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.cleanup
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !337, !DIExpression(), !755)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds [8 x i32], ptr @__const.fft.reversed, i64 0, i64 %indvars.iv.i.reg2mem.0.load, !dbg !760
  %28 = load i32, ptr %arrayidx.i, align 4, !dbg !760, !tbaa !350
  %conv.i = sitofp i32 %28 to double, !dbg !760
  %mul.i = fmul double %conv.i, 0xC01921FB54411744, !dbg !761
  %div.i = fmul double %mul.i, 0x3F60000000000000, !dbg !762
  %mul3.i = fmul double %div.i, %conv2.i, !dbg !763
    #dbg_value(double %mul3.i, !338, !DIExpression(), !755)
  %call.i = tail call double @cos(double noundef %mul3.i) #19, !dbg !764
    #dbg_value(double %call.i, !340, !DIExpression(), !755)
  %call4.i = tail call double @sin(double noundef %mul3.i) #19, !dbg !765
    #dbg_value(double %call4.i, !341, !DIExpression(), !755)
  %arrayidx6.i = getelementptr inbounds double, ptr %data_x, i64 %indvars.iv.i.reg2mem.0.load, !dbg !766
  %29 = load double, ptr %arrayidx6.i, align 8, !dbg !766, !tbaa !360
    #dbg_value(double %29, !339, !DIExpression(), !755)
  %arrayidx11.i = getelementptr inbounds double, ptr %data_y, i64 %indvars.iv.i.reg2mem.0.load, !dbg !767
  %30 = load double, ptr %arrayidx11.i, align 8, !dbg !767, !tbaa !360
  %31 = fneg double %30, !dbg !767
  %neg.i = fmul double %call4.i, %31, !dbg !767
  %32 = tail call double @llvm.fmuladd.f64(double %29, double %call.i, double %neg.i), !dbg !767
  store double %32, ptr %arrayidx6.i, align 8, !dbg !768, !tbaa !360
  %mul18.i = fmul double %call.i, %30, !dbg !769
  %33 = tail call double @llvm.fmuladd.f64(double %29, double %call4.i, double %mul18.i), !dbg !769
  store double %33, ptr %arrayidx11.i, align 8, !dbg !770, !tbaa !360
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !771
    #dbg_value(i64 %indvars.iv.next.i, !337, !DIExpression(), !755)
  store i64 %indvars.iv.next.i, ptr %indvars.iv.next.i.reg2mem, align 8
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 8, !dbg !772
  br i1 %exitcond.not.i, label %for.cond266.preheader, label %for.body.i.for.body.i_crit_edge, !dbg !759, !llvm.loop !773

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !759

for.cond266.preheader:                            ; preds = %for.body.i
  %scevgep1876 = getelementptr i8, ptr %DATA_y, i64 %0
  %scevgep = getelementptr i8, ptr %DATA_x, i64 %0
    #dbg_value(i64 0, !504, !DIExpression(), !775)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %scevgep, ptr noundef nonnull align 8 dereferenceable(64) %data_x, i64 64, i1 false), !dbg !776, !tbaa !360
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %scevgep1876, ptr noundef nonnull align 8 dereferenceable(64) %data_y, i64 64, i1 false), !dbg !779, !tbaa !360
    #dbg_value(i64 poison, !504, !DIExpression(), !775)
  %indvar.next = add nuw nsw i64 %indvar.reg2mem120.0.load, 1, !dbg !780
    #dbg_value(i64 %indvar.next, !432, !DIExpression(), !653)
  store i64 %indvar.next, ptr %indvar.next.reg2mem, align 8
  %exitcond1877.not = icmp eq i64 %indvar.next, 64, !dbg !781
  br i1 %exitcond1877.not, label %for.cond266.preheader.for.body290_crit_edge, label %for.cond266.preheader.for.cond1.preheader_crit_edge, !dbg !664, !llvm.loop !782

for.cond266.preheader.for.cond1.preheader_crit_edge: ; preds = %for.cond266.preheader
  store i64 %indvar.next, ptr %indvar.reg2mem120, align 8
  br label %for.cond1.preheader, !dbg !664

for.cond266.preheader.for.body290_crit_edge:      ; preds = %for.cond266.preheader
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body290, !dbg !664

for.body3:                                        ; preds = %for.body3.for.body3_crit_edge, %for.cond1.preheader
    #dbg_value(i64 %i.01854.reg2mem.0.load, !447, !DIExpression(), !665)
  %i.01854.reg2mem.0.load = load i64, ptr %i.01854.reg2mem, align 8
  %mul = shl nuw nsw i64 %i.01854.reg2mem.0.load, 6, !dbg !784
  %add = add nuw nsw i64 %mul, %indvar.reg2mem120.0.load, !dbg !787
  %arrayidx = getelementptr inbounds double, ptr %work_x, i64 %add, !dbg !788
  %34 = load double, ptr %arrayidx, align 8, !dbg !788, !tbaa !360
  %arrayidx5 = getelementptr inbounds [8 x double], ptr %data_x, i64 0, i64 %i.01854.reg2mem.0.load, !dbg !789
  store double %34, ptr %arrayidx5, align 8, !dbg !790, !tbaa !360
  %arrayidx10 = getelementptr inbounds double, ptr %work_y, i64 %add, !dbg !791
  %35 = load double, ptr %arrayidx10, align 8, !dbg !791, !tbaa !360
  %arrayidx11 = getelementptr inbounds [8 x double], ptr %data_y, i64 0, i64 %i.01854.reg2mem.0.load, !dbg !792
  store double %35, ptr %arrayidx11, align 8, !dbg !793, !tbaa !360
  %inc = add nuw nsw i64 %i.01854.reg2mem.0.load, 1, !dbg !794
    #dbg_value(i64 %inc, !447, !DIExpression(), !665)
  store i64 %inc, ptr %inc.reg2mem, align 8
  %exitcond.not = icmp eq i64 %inc, 8, !dbg !795
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body3.for.body3_crit_edge, !dbg !666, !llvm.loop !796

for.body3.for.body3_crit_edge:                    ; preds = %for.body3
  store i64 %inc, ptr %i.01854.reg2mem, align 8
  br label %for.body3, !dbg !666

for.body290:                                      ; preds = %for.body290.for.body290_crit_edge, %for.cond266.preheader.for.body290_crit_edge
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !432, !DIExpression(), !653)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !433, !DIExpression(DW_OP_constu, 3, DW_OP_shr, DW_OP_stack_value), !653)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !434, !DIExpression(DW_OP_constu, 7, DW_OP_and, DW_OP_stack_value), !653)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !507, !DIExpression(), !653)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %36 = shl nuw nsw i64 %indvars.iv.reg2mem.0.load, 3, !dbg !798
  %arrayidx295 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %36, !dbg !802
  %37 = load double, ptr %arrayidx295, align 8, !dbg !802, !tbaa !360
  %arrayidx299 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !803
  store double %37, ptr %arrayidx299, align 8, !dbg !804, !tbaa !360
  %38 = or disjoint i64 %36, 1, !dbg !805
  %arrayidx303 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %38, !dbg !806
  %39 = load double, ptr %arrayidx303, align 8, !dbg !806, !tbaa !360
  %40 = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 264, !dbg !807
  %arrayidx307 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %40, !dbg !808
  store double %39, ptr %arrayidx307, align 8, !dbg !809, !tbaa !360
  %41 = or disjoint i64 %36, 4, !dbg !810
  %arrayidx311 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %41, !dbg !811
  %42 = load double, ptr %arrayidx311, align 8, !dbg !811, !tbaa !360
  %43 = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 66, !dbg !812
  %arrayidx315 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %43, !dbg !813
  store double %42, ptr %arrayidx315, align 8, !dbg !814, !tbaa !360
  %44 = or disjoint i64 %36, 5, !dbg !815
  %arrayidx319 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %44, !dbg !816
  %45 = load double, ptr %arrayidx319, align 8, !dbg !816, !tbaa !360
  %46 = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 330, !dbg !817
  %arrayidx323 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %46, !dbg !818
  store double %45, ptr %arrayidx323, align 8, !dbg !819, !tbaa !360
  %47 = or disjoint i64 %36, 2, !dbg !820
  %arrayidx327 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %47, !dbg !821
  %48 = load double, ptr %arrayidx327, align 8, !dbg !821, !tbaa !360
  %49 = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 132, !dbg !822
  %arrayidx331 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %49, !dbg !823
  store double %48, ptr %arrayidx331, align 8, !dbg !824, !tbaa !360
  %50 = or disjoint i64 %36, 3, !dbg !825
  %arrayidx335 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %50, !dbg !826
  %51 = load double, ptr %arrayidx335, align 8, !dbg !826, !tbaa !360
  %52 = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 396, !dbg !827
  %arrayidx339 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %52, !dbg !828
  store double %51, ptr %arrayidx339, align 8, !dbg !829, !tbaa !360
  %53 = or disjoint i64 %36, 6, !dbg !830
  %arrayidx343 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %53, !dbg !831
  %54 = load double, ptr %arrayidx343, align 8, !dbg !831, !tbaa !360
  %55 = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 198, !dbg !832
  %arrayidx347 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %55, !dbg !833
  store double %54, ptr %arrayidx347, align 8, !dbg !834, !tbaa !360
  %56 = or disjoint i64 %36, 7, !dbg !835
  %arrayidx351 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %56, !dbg !836
  %57 = load double, ptr %arrayidx351, align 8, !dbg !836, !tbaa !360
  %58 = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 462, !dbg !837
  %arrayidx355 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %58, !dbg !838
  store double %57, ptr %arrayidx355, align 8, !dbg !839, !tbaa !360
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !840
    #dbg_value(i64 %indvars.iv.next, !432, !DIExpression(), !653)
  store i64 %indvars.iv.next, ptr %indvars.iv.next.reg2mem, align 8
  %exitcond1893.not = icmp eq i64 %indvars.iv.next, 64, !dbg !841
  br i1 %exitcond1893.not, label %for.body290.for.body362_crit_edge, label %for.body290.for.body290_crit_edge, !dbg !842, !llvm.loop !843

for.body290.for.body290_crit_edge:                ; preds = %for.body290
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body290, !dbg !842

for.body290.for.body362_crit_edge:                ; preds = %for.body290
  store i64 0, ptr %indvars.iv1894.reg2mem, align 8
  br label %for.body362, !dbg !842

for.body362:                                      ; preds = %for.body362.for.body362_crit_edge, %for.body290.for.body362_crit_edge
    #dbg_value(i64 %indvars.iv1894.reg2mem.0.load, !432, !DIExpression(), !653)
  %indvars.iv1894.reg2mem.0.load = load i64, ptr %indvars.iv1894.reg2mem, align 8
  %59 = trunc i64 %indvars.iv1894.reg2mem.0.load to i32, !dbg !845
  %shr363 = lshr i32 %59, 3, !dbg !845
    #dbg_value(i32 %shr363, !433, !DIExpression(), !653)
  %and364 = and i32 %59, 7, !dbg !849
    #dbg_value(i32 %and364, !434, !DIExpression(), !653)
  %mul365 = mul nuw nsw i32 %and364, 66, !dbg !850
  %add366 = add nuw nsw i32 %mul365, %shr363, !dbg !851
    #dbg_value(i32 %add366, !507, !DIExpression(), !653)
  %idxprom369 = zext nneg i32 %add366 to i64, !dbg !852
  %arrayidx370 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom369, !dbg !852
  %60 = load double, ptr %arrayidx370, align 8, !dbg !852, !tbaa !360
  %61 = shl nuw nsw i64 %indvars.iv1894.reg2mem.0.load, 3, !dbg !853
  %arrayidx374 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %61, !dbg !854
  store double %60, ptr %arrayidx374, align 8, !dbg !855, !tbaa !360
  %add376 = add nuw nsw i32 %add366, 32, !dbg !856
  %idxprom377 = zext nneg i32 %add376 to i64, !dbg !857
  %arrayidx378 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom377, !dbg !857
  %62 = load double, ptr %arrayidx378, align 8, !dbg !857, !tbaa !360
  %63 = or disjoint i64 %61, 4, !dbg !858
  %arrayidx382 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %63, !dbg !859
  store double %62, ptr %arrayidx382, align 8, !dbg !860, !tbaa !360
  %add384 = add nuw nsw i32 %add366, 8, !dbg !861
  %idxprom385 = zext nneg i32 %add384 to i64, !dbg !862
  %arrayidx386 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom385, !dbg !862
  %64 = load double, ptr %arrayidx386, align 8, !dbg !862, !tbaa !360
  %65 = or disjoint i64 %61, 1, !dbg !863
  %arrayidx390 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %65, !dbg !864
  store double %64, ptr %arrayidx390, align 8, !dbg !865, !tbaa !360
  %add392 = add nuw nsw i32 %add366, 40, !dbg !866
  %idxprom393 = zext nneg i32 %add392 to i64, !dbg !867
  %arrayidx394 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom393, !dbg !867
  %66 = load double, ptr %arrayidx394, align 8, !dbg !867, !tbaa !360
  %67 = or disjoint i64 %61, 5, !dbg !868
  %arrayidx398 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %67, !dbg !869
  store double %66, ptr %arrayidx398, align 8, !dbg !870, !tbaa !360
  %add400 = add nuw nsw i32 %add366, 16, !dbg !871
  %idxprom401 = zext nneg i32 %add400 to i64, !dbg !872
  %arrayidx402 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom401, !dbg !872
  %68 = load double, ptr %arrayidx402, align 8, !dbg !872, !tbaa !360
  %69 = or disjoint i64 %61, 2, !dbg !873
  %arrayidx406 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %69, !dbg !874
  store double %68, ptr %arrayidx406, align 8, !dbg !875, !tbaa !360
  %add408 = add nuw nsw i32 %add366, 48, !dbg !876
  %idxprom409 = zext nneg i32 %add408 to i64, !dbg !877
  %arrayidx410 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom409, !dbg !877
  %70 = load double, ptr %arrayidx410, align 8, !dbg !877, !tbaa !360
  %71 = or disjoint i64 %61, 6, !dbg !878
  %arrayidx414 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %71, !dbg !879
  store double %70, ptr %arrayidx414, align 8, !dbg !880, !tbaa !360
  %add416 = add nuw nsw i32 %add366, 24, !dbg !881
  %idxprom417 = zext nneg i32 %add416 to i64, !dbg !882
  %arrayidx418 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom417, !dbg !882
  %72 = load double, ptr %arrayidx418, align 8, !dbg !882, !tbaa !360
  %73 = or disjoint i64 %61, 3, !dbg !883
  %arrayidx422 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %73, !dbg !884
  store double %72, ptr %arrayidx422, align 8, !dbg !885, !tbaa !360
  %add424 = add nuw nsw i32 %add366, 56, !dbg !886
  %idxprom425 = zext nneg i32 %add424 to i64, !dbg !887
  %arrayidx426 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom425, !dbg !887
  %74 = load double, ptr %arrayidx426, align 8, !dbg !887, !tbaa !360
  %75 = or disjoint i64 %61, 7, !dbg !888
  %arrayidx430 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %75, !dbg !889
  store double %74, ptr %arrayidx430, align 8, !dbg !890, !tbaa !360
  %indvars.iv.next1895 = add nuw nsw i64 %indvars.iv1894.reg2mem.0.load, 1, !dbg !891
    #dbg_value(i64 %indvars.iv.next1895, !432, !DIExpression(), !653)
  store i64 %indvars.iv.next1895, ptr %indvars.iv.next1895.reg2mem, align 8
  %exitcond1904.not = icmp eq i64 %indvars.iv.next1895, 64, !dbg !892
  br i1 %exitcond1904.not, label %for.body362.for.body437_crit_edge, label %for.body362.for.body362_crit_edge, !dbg !893, !llvm.loop !894

for.body362.for.body362_crit_edge:                ; preds = %for.body362
  store i64 %indvars.iv.next1895, ptr %indvars.iv1894.reg2mem, align 8
  br label %for.body362, !dbg !893

for.body362.for.body437_crit_edge:                ; preds = %for.body362
  store i64 0, ptr %indvars.iv1905.reg2mem, align 8
  br label %for.body437, !dbg !893

for.body437:                                      ; preds = %for.body437.for.body437_crit_edge, %for.body362.for.body437_crit_edge
    #dbg_value(i64 %indvars.iv1905.reg2mem.0.load, !432, !DIExpression(), !653)
    #dbg_value(i64 %indvars.iv1905.reg2mem.0.load, !433, !DIExpression(DW_OP_constu, 3, DW_OP_shr, DW_OP_stack_value), !653)
    #dbg_value(i64 %indvars.iv1905.reg2mem.0.load, !434, !DIExpression(DW_OP_constu, 7, DW_OP_and, DW_OP_stack_value), !653)
    #dbg_value(i64 %indvars.iv1905.reg2mem.0.load, !507, !DIExpression(), !653)
  %indvars.iv1905.reg2mem.0.load = load i64, ptr %indvars.iv1905.reg2mem, align 8
  %76 = shl nuw nsw i64 %indvars.iv1905.reg2mem.0.load, 3, !dbg !896
  %arrayidx445 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %76, !dbg !900
  %77 = load double, ptr %arrayidx445, align 8, !dbg !900, !tbaa !360
  %arrayidx449 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %indvars.iv1905.reg2mem.0.load, !dbg !901
  store double %77, ptr %arrayidx449, align 8, !dbg !902, !tbaa !360
  %78 = or disjoint i64 %76, 1, !dbg !903
  %arrayidx453 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %78, !dbg !904
  %79 = load double, ptr %arrayidx453, align 8, !dbg !904, !tbaa !360
  %80 = add nuw nsw i64 %indvars.iv1905.reg2mem.0.load, 264, !dbg !905
  %arrayidx457 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %80, !dbg !906
  store double %79, ptr %arrayidx457, align 8, !dbg !907, !tbaa !360
  %81 = or disjoint i64 %76, 4, !dbg !908
  %arrayidx461 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %81, !dbg !909
  %82 = load double, ptr %arrayidx461, align 8, !dbg !909, !tbaa !360
  %83 = add nuw nsw i64 %indvars.iv1905.reg2mem.0.load, 66, !dbg !910
  %arrayidx465 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %83, !dbg !911
  store double %82, ptr %arrayidx465, align 8, !dbg !912, !tbaa !360
  %84 = or disjoint i64 %76, 5, !dbg !913
  %arrayidx469 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %84, !dbg !914
  %85 = load double, ptr %arrayidx469, align 8, !dbg !914, !tbaa !360
  %86 = add nuw nsw i64 %indvars.iv1905.reg2mem.0.load, 330, !dbg !915
  %arrayidx473 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %86, !dbg !916
  store double %85, ptr %arrayidx473, align 8, !dbg !917, !tbaa !360
  %87 = or disjoint i64 %76, 2, !dbg !918
  %arrayidx477 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %87, !dbg !919
  %88 = load double, ptr %arrayidx477, align 8, !dbg !919, !tbaa !360
  %89 = add nuw nsw i64 %indvars.iv1905.reg2mem.0.load, 132, !dbg !920
  %arrayidx481 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %89, !dbg !921
  store double %88, ptr %arrayidx481, align 8, !dbg !922, !tbaa !360
  %90 = or disjoint i64 %76, 3, !dbg !923
  %arrayidx485 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %90, !dbg !924
  %91 = load double, ptr %arrayidx485, align 8, !dbg !924, !tbaa !360
  %92 = add nuw nsw i64 %indvars.iv1905.reg2mem.0.load, 396, !dbg !925
  %arrayidx489 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %92, !dbg !926
  store double %91, ptr %arrayidx489, align 8, !dbg !927, !tbaa !360
  %93 = or disjoint i64 %76, 6, !dbg !928
  %arrayidx493 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %93, !dbg !929
  %94 = load double, ptr %arrayidx493, align 8, !dbg !929, !tbaa !360
  %95 = add nuw nsw i64 %indvars.iv1905.reg2mem.0.load, 198, !dbg !930
  %arrayidx497 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %95, !dbg !931
  store double %94, ptr %arrayidx497, align 8, !dbg !932, !tbaa !360
  %96 = or disjoint i64 %76, 7, !dbg !933
  %arrayidx501 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %96, !dbg !934
  %97 = load double, ptr %arrayidx501, align 8, !dbg !934, !tbaa !360
  %98 = add nuw nsw i64 %indvars.iv1905.reg2mem.0.load, 462, !dbg !935
  %arrayidx505 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %98, !dbg !936
  store double %97, ptr %arrayidx505, align 8, !dbg !937, !tbaa !360
  %indvars.iv.next1906 = add nuw nsw i64 %indvars.iv1905.reg2mem.0.load, 1, !dbg !938
    #dbg_value(i64 %indvars.iv.next1906, !432, !DIExpression(), !653)
  store i64 %indvars.iv.next1906, ptr %indvars.iv.next1906.reg2mem, align 8
  %exitcond1922.not = icmp eq i64 %indvars.iv.next1906, 64, !dbg !939
  br i1 %exitcond1922.not, label %for.body437.for.cond514.preheader_crit_edge, label %for.body437.for.body437_crit_edge, !dbg !940, !llvm.loop !941

for.body437.for.body437_crit_edge:                ; preds = %for.body437
  store i64 %indvars.iv.next1906, ptr %indvars.iv1905.reg2mem, align 8
  br label %for.body437, !dbg !940

for.body437.for.cond514.preheader_crit_edge:      ; preds = %for.body437
  store i32 0, ptr %tid.41862.reg2mem116, align 4
  store i64 0, ptr %indvar1923.reg2mem118, align 8
  br label %for.cond514.preheader, !dbg !940

for.cond514.preheader:                            ; preds = %for.cond534.preheader.for.cond514.preheader_crit_edge, %for.body437.for.cond514.preheader_crit_edge
    #dbg_value(i32 %tid.41862.reg2mem116.0.load, !432, !DIExpression(), !653)
  %indvar1923.reg2mem118.0.load = load i64, ptr %indvar1923.reg2mem118, align 8
  %tid.41862.reg2mem116.0.load = load i32, ptr %tid.41862.reg2mem116, align 4
  store i64 %indvar1923.reg2mem118.0.load, ptr %indvar1923.reg2mem, align 8
  store i32 %tid.41862.reg2mem116.0.load, ptr %tid.41862.reg2mem, align 4
  %99 = shl nuw nsw i64 %indvar1923.reg2mem118.0.load, 6
  %scevgep1926 = getelementptr i8, ptr %DATA_y, i64 %99
    #dbg_value(i64 0, !512, !DIExpression(), !943)
  store ptr %scevgep1926, ptr %scevgep1926.reg2mem, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %data_y, ptr noundef nonnull align 8 dereferenceable(64) %scevgep1926, i64 64, i1 false), !dbg !944, !tbaa !360
    #dbg_value(i64 poison, !512, !DIExpression(), !943)
  %shr527 = lshr i32 %tid.41862.reg2mem116.0.load, 3, !dbg !947
    #dbg_value(i32 %shr527, !433, !DIExpression(), !653)
  %and528 = and i32 %tid.41862.reg2mem116.0.load, 7, !dbg !948
    #dbg_value(i32 %and528, !434, !DIExpression(), !653)
  %mul531 = mul nuw nsw i32 %and528, 66, !dbg !949
  %add532 = add nuw nsw i32 %mul531, %shr527, !dbg !950
    #dbg_value(ptr %data_y, !405, !DIExpression(), !951)
    #dbg_value(ptr %smem, !406, !DIExpression(), !951)
    #dbg_value(i32 %add532, !407, !DIExpression(), !951)
    #dbg_value(i32 8, !408, !DIExpression(), !951)
    #dbg_value(i64 0, !409, !DIExpression(), !953)
  %conv1.i = zext nneg i32 %add532 to i64
  %invariant.gep.i = getelementptr double, ptr %smem, i64 %conv1.i, !dbg !954
  store ptr %invariant.gep.i, ptr %invariant.gep.i.reg2mem, align 8
  store i64 0, ptr %i.06.i.reg2mem, align 8
  br label %for.body.i1824, !dbg !955

for.body.i1824:                                   ; preds = %for.body.i1824.for.body.i1824_crit_edge, %for.cond514.preheader
    #dbg_value(i64 %i.06.i.reg2mem.0.load, !409, !DIExpression(), !953)
  %i.06.i.reg2mem.0.load = load i64, ptr %i.06.i.reg2mem, align 8
  %gep.i.idx = shl i64 %i.06.i.reg2mem.0.load, 6, !dbg !956
  %gep.i = getelementptr i8, ptr %invariant.gep.i, i64 %gep.i.idx, !dbg !956
  %100 = load double, ptr %gep.i, align 8, !dbg !956, !tbaa !360
  %arrayidx2.i = getelementptr inbounds double, ptr %data_y, i64 %i.06.i.reg2mem.0.load, !dbg !957
  store double %100, ptr %arrayidx2.i, align 8, !dbg !958, !tbaa !360
  %inc.i = add nuw nsw i64 %i.06.i.reg2mem.0.load, 1, !dbg !959
    #dbg_value(i64 %inc.i, !409, !DIExpression(), !953)
  store i64 %inc.i, ptr %inc.i.reg2mem, align 8
  %exitcond.not.i1826 = icmp eq i64 %inc.i, 8, !dbg !960
  br i1 %exitcond.not.i1826, label %for.cond534.preheader, label %for.body.i1824.for.body.i1824_crit_edge, !dbg !955, !llvm.loop !961

for.body.i1824.for.body.i1824_crit_edge:          ; preds = %for.body.i1824
  store i64 %inc.i, ptr %i.06.i.reg2mem, align 8
  br label %for.body.i1824, !dbg !955

for.cond534.preheader:                            ; preds = %for.body.i1824
    #dbg_value(i64 0, !517, !DIExpression(), !963)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %scevgep1926, ptr noundef nonnull align 8 dereferenceable(64) %data_y, i64 64, i1 false), !dbg !964, !tbaa !360
    #dbg_value(i64 poison, !517, !DIExpression(), !963)
  %inc548 = add nuw nsw i32 %tid.41862.reg2mem116.0.load, 1, !dbg !967
    #dbg_value(i32 %inc548, !432, !DIExpression(), !653)
  store i32 %inc548, ptr %inc548.reg2mem, align 4
  %indvar.next1924 = add nuw nsw i64 %indvar1923.reg2mem118.0.load, 1, !dbg !968
  store i64 %indvar.next1924, ptr %indvar.next1924.reg2mem, align 8
  %exitcond1927.not = icmp eq i64 %indvar.next1924, 64, !dbg !969
  br i1 %exitcond1927.not, label %for.cond534.preheader.for.cond555.preheader_crit_edge, label %for.cond534.preheader.for.cond514.preheader_crit_edge, !dbg !968, !llvm.loop !970

for.cond534.preheader.for.cond514.preheader_crit_edge: ; preds = %for.cond534.preheader
  store i32 %inc548, ptr %tid.41862.reg2mem116, align 4
  store i64 %indvar.next1924, ptr %indvar1923.reg2mem118, align 8
  br label %for.cond514.preheader, !dbg !968

for.cond534.preheader.for.cond555.preheader_crit_edge: ; preds = %for.cond534.preheader
  store i32 0, ptr %tid.51866.reg2mem112, align 4
  store i64 0, ptr %indvar1928.reg2mem114, align 8
  br label %for.cond555.preheader, !dbg !968

for.cond555.preheader:                            ; preds = %for.cond852.preheader.for.cond555.preheader_crit_edge, %for.cond534.preheader.for.cond555.preheader_crit_edge
    #dbg_value(i32 %tid.51866.reg2mem112.0.load, !432, !DIExpression(), !653)
  %indvar1928.reg2mem114.0.load = load i64, ptr %indvar1928.reg2mem114, align 8
  %tid.51866.reg2mem112.0.load = load i32, ptr %tid.51866.reg2mem112, align 4
  store i64 %indvar1928.reg2mem114.0.load, ptr %indvar1928.reg2mem, align 8
  store i32 %tid.51866.reg2mem112.0.load, ptr %tid.51866.reg2mem, align 4
  %101 = shl nuw nsw i64 %indvar1928.reg2mem114.0.load, 6
  %scevgep1933 = getelementptr i8, ptr %DATA_y, i64 %101
  store ptr %scevgep1933, ptr %scevgep1933.reg2mem, align 8
  %scevgep1932 = getelementptr i8, ptr %DATA_x, i64 %101
    #dbg_value(i64 0, !520, !DIExpression(), !972)
  store ptr %scevgep1932, ptr %scevgep1932.reg2mem, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %data_x, ptr noundef nonnull align 8 dereferenceable(64) %scevgep1932, i64 64, i1 false), !dbg !973, !tbaa !360
    #dbg_value(i64 poison, !520, !DIExpression(), !972)
    #dbg_value(i64 0, !525, !DIExpression(), !976)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %data_y, ptr noundef nonnull align 8 dereferenceable(64) %scevgep1933, i64 64, i1 false), !dbg !977, !tbaa !360
    #dbg_value(i64 poison, !525, !DIExpression(), !976)
    #dbg_value(double 1.000000e+00, !527, !DIExpression(), !980)
    #dbg_value(double -1.000000e+00, !531, !DIExpression(), !980)
    #dbg_value(double 0.000000e+00, !529, !DIExpression(), !980)
    #dbg_value(double -1.000000e+00, !532, !DIExpression(), !980)
    #dbg_value(double -1.000000e+00, !530, !DIExpression(), !980)
    #dbg_value(double -1.000000e+00, !533, !DIExpression(), !980)
  %102 = load double, ptr %data_x, align 8, !dbg !981, !tbaa !360
    #dbg_value(double %102, !535, !DIExpression(), !982)
  %103 = load double, ptr %data_y, align 8, !dbg !981, !tbaa !360
    #dbg_value(double %103, !537, !DIExpression(), !982)
  %arrayidx14.reg2mem.0.arrayidx14.reload103 = load ptr, ptr %arrayidx14.reg2mem, align 8
  %104 = load double, ptr %arrayidx14.reg2mem.0.arrayidx14.reload103, align 8, !dbg !981, !tbaa !360
  %add594 = fadd double %102, %104, !dbg !981
    #dbg_assign(double %add594, !439, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !983, ptr %data_x, !DIExpression(), !653)
  %arrayidx17.reg2mem.0.arrayidx17.reload98 = load ptr, ptr %arrayidx17.reg2mem, align 8
  %105 = load double, ptr %arrayidx17.reg2mem.0.arrayidx17.reload98, align 8, !dbg !981, !tbaa !360
  %add597 = fadd double %103, %105, !dbg !981
    #dbg_assign(double %add597, !441, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !984, ptr %data_y, !DIExpression(), !653)
  %sub600 = fsub double %102, %104, !dbg !981
    #dbg_assign(double %sub600, !439, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !985, ptr %arrayidx14, !DIExpression(), !653)
  %sub603 = fsub double %103, %105, !dbg !981
    #dbg_assign(double %sub603, !441, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !986, ptr %arrayidx17, !DIExpression(), !653)
  %arrayidx26.reg2mem.0.arrayidx26.reload93 = load ptr, ptr %arrayidx26.reg2mem, align 8
  %106 = load double, ptr %arrayidx26.reg2mem.0.arrayidx26.reload93, align 8, !dbg !987, !tbaa !360
    #dbg_value(double %106, !538, !DIExpression(), !988)
  %arrayidx28.reg2mem.0.arrayidx28.reload88 = load ptr, ptr %arrayidx28.reg2mem, align 8
  %107 = load double, ptr %arrayidx28.reg2mem.0.arrayidx28.reload88, align 8, !dbg !987, !tbaa !360
    #dbg_value(double %107, !540, !DIExpression(), !988)
  %arrayidx29.reg2mem.0.arrayidx29.reload83 = load ptr, ptr %arrayidx29.reg2mem, align 8
  %108 = load double, ptr %arrayidx29.reg2mem.0.arrayidx29.reload83, align 8, !dbg !987, !tbaa !360
  %add610 = fadd double %106, %108, !dbg !987
    #dbg_assign(double %add610, !439, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !989, ptr %arrayidx26, !DIExpression(), !653)
  %arrayidx32.reg2mem.0.arrayidx32.reload78 = load ptr, ptr %arrayidx32.reg2mem, align 8
  %109 = load double, ptr %arrayidx32.reg2mem.0.arrayidx32.reload78, align 8, !dbg !987, !tbaa !360
  %add613 = fadd double %107, %109, !dbg !987
    #dbg_assign(double %add613, !441, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !990, ptr %arrayidx28, !DIExpression(), !653)
  %sub616 = fsub double %106, %108, !dbg !987
    #dbg_assign(double %sub616, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !991, ptr %arrayidx29, !DIExpression(), !653)
  %sub619 = fsub double %107, %109, !dbg !987
    #dbg_assign(double %sub619, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !992, ptr %arrayidx32, !DIExpression(), !653)
  %arrayidx42.reg2mem.0.arrayidx42.reload73 = load ptr, ptr %arrayidx42.reg2mem, align 8
  %110 = load double, ptr %arrayidx42.reg2mem.0.arrayidx42.reload73, align 8, !dbg !993, !tbaa !360
    #dbg_value(double %110, !541, !DIExpression(), !994)
  %arrayidx44.reg2mem.0.arrayidx44.reload68 = load ptr, ptr %arrayidx44.reg2mem, align 8
  %111 = load double, ptr %arrayidx44.reg2mem.0.arrayidx44.reload68, align 8, !dbg !993, !tbaa !360
    #dbg_value(double %111, !543, !DIExpression(), !994)
  %arrayidx45.reg2mem.0.arrayidx45.reload63 = load ptr, ptr %arrayidx45.reg2mem, align 8
  %112 = load double, ptr %arrayidx45.reg2mem.0.arrayidx45.reload63, align 8, !dbg !993, !tbaa !360
  %add626 = fadd double %110, %112, !dbg !993
    #dbg_assign(double %add626, !439, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !995, ptr %arrayidx42, !DIExpression(), !653)
  %arrayidx48.reg2mem.0.arrayidx48.reload58 = load ptr, ptr %arrayidx48.reg2mem, align 8
  %113 = load double, ptr %arrayidx48.reg2mem.0.arrayidx48.reload58, align 8, !dbg !993, !tbaa !360
  %add629 = fadd double %111, %113, !dbg !993
    #dbg_assign(double %add629, !441, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !996, ptr %arrayidx44, !DIExpression(), !653)
  %sub632 = fsub double %110, %112, !dbg !993
    #dbg_assign(double %sub632, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !997, ptr %arrayidx45, !DIExpression(), !653)
  %sub635 = fsub double %111, %113, !dbg !993
    #dbg_assign(double %sub635, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !998, ptr %arrayidx48, !DIExpression(), !653)
  %arrayidx58.reg2mem.0.arrayidx58.reload53 = load ptr, ptr %arrayidx58.reg2mem, align 8
  %114 = load double, ptr %arrayidx58.reg2mem.0.arrayidx58.reload53, align 8, !dbg !999, !tbaa !360
    #dbg_value(double %114, !544, !DIExpression(), !1000)
  %arrayidx60.reg2mem.0.arrayidx60.reload48 = load ptr, ptr %arrayidx60.reg2mem, align 8
  %115 = load double, ptr %arrayidx60.reg2mem.0.arrayidx60.reload48, align 8, !dbg !999, !tbaa !360
    #dbg_value(double %115, !546, !DIExpression(), !1000)
  %arrayidx61.reg2mem.0.arrayidx61.reload43 = load ptr, ptr %arrayidx61.reg2mem, align 8
  %116 = load double, ptr %arrayidx61.reg2mem.0.arrayidx61.reload43, align 8, !dbg !999, !tbaa !360
  %add642 = fadd double %114, %116, !dbg !999
    #dbg_assign(double %add642, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1001, ptr %arrayidx58, !DIExpression(), !653)
  %arrayidx64.reg2mem.0.arrayidx64.reload38 = load ptr, ptr %arrayidx64.reg2mem, align 8
  %117 = load double, ptr %arrayidx64.reg2mem.0.arrayidx64.reload38, align 8, !dbg !999, !tbaa !360
  %add645 = fadd double %115, %117, !dbg !999
    #dbg_assign(double %add645, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1002, ptr %arrayidx60, !DIExpression(), !653)
  %sub648 = fsub double %114, %116, !dbg !999
    #dbg_assign(double %sub648, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1003, ptr %arrayidx61, !DIExpression(), !653)
  %sub651 = fsub double %115, %117, !dbg !999
    #dbg_assign(double %sub651, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1004, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double %sub616, !534, !DIExpression(), !980)
  %118 = fadd double %sub616, %sub619, !dbg !1005
  %mul659 = fmul double %118, 0x3FE6A09E667F3BCD, !dbg !1005
    #dbg_assign(double %mul659, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1006, ptr %arrayidx29, !DIExpression(), !653)
  %119 = fsub double %sub619, %sub616, !dbg !1005
  %mul664 = fmul double %119, 0x3FE6A09E667F3BCD, !dbg !1005
    #dbg_assign(double %mul664, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1007, ptr %arrayidx32, !DIExpression(), !653)
    #dbg_value(double %sub632, !534, !DIExpression(), !980)
  %120 = tail call double @llvm.fmuladd.f64(double %sub632, double 0.000000e+00, double %sub635), !dbg !1005
    #dbg_assign(double %120, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1008, ptr %arrayidx45, !DIExpression(), !653)
  %mul675 = fmul double %sub635, 0.000000e+00, !dbg !1005
  %121 = fsub double %mul675, %sub632, !dbg !1005
    #dbg_assign(double %121, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1009, ptr %arrayidx48, !DIExpression(), !653)
    #dbg_value(double %sub648, !534, !DIExpression(), !980)
  %122 = fsub double %sub651, %sub648, !dbg !1005
  %mul683 = fmul double %122, 0x3FE6A09E667F3BCD, !dbg !1005
    #dbg_assign(double %mul683, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1010, ptr %arrayidx61, !DIExpression(), !653)
  %mul687 = fneg double %sub651, !dbg !1005
  %123 = fsub double %mul687, %sub648, !dbg !1005
  %mul688 = fmul double %123, 0x3FE6A09E667F3BCD, !dbg !1005
    #dbg_assign(double %mul688, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1011, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double 0.000000e+00, !547, !DIExpression(), !1012)
    #dbg_value(double -1.000000e+00, !549, !DIExpression(), !1012)
    #dbg_value(double %add594, !551, !DIExpression(), !1013)
    #dbg_value(double %add597, !553, !DIExpression(), !1013)
  %add698 = fadd double %add594, %add626, !dbg !1014
    #dbg_assign(double %add698, !439, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !1015, ptr %data_x, !DIExpression(), !653)
  %add701 = fadd double %add597, %add629, !dbg !1014
    #dbg_assign(double %add701, !441, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !1016, ptr %data_y, !DIExpression(), !653)
  %sub704 = fsub double %add594, %add626, !dbg !1014
    #dbg_assign(double %sub704, !439, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !1017, ptr %arrayidx42, !DIExpression(), !653)
  %sub707 = fsub double %add597, %add629, !dbg !1014
    #dbg_assign(double %sub707, !441, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !1018, ptr %arrayidx44, !DIExpression(), !653)
    #dbg_value(double %add610, !554, !DIExpression(), !1019)
    #dbg_value(double %add613, !556, !DIExpression(), !1019)
  %add714 = fadd double %add610, %add642, !dbg !1020
    #dbg_assign(double %add714, !439, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !1021, ptr %arrayidx26, !DIExpression(), !653)
  %add717 = fadd double %add613, %add645, !dbg !1020
    #dbg_assign(double %add717, !441, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !1022, ptr %arrayidx28, !DIExpression(), !653)
  %sub720 = fsub double %add610, %add642, !dbg !1020
    #dbg_assign(double %sub720, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1023, ptr %arrayidx58, !DIExpression(), !653)
  %sub723 = fsub double %add613, %add645, !dbg !1020
    #dbg_assign(double %sub723, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1024, ptr %arrayidx60, !DIExpression(), !653)
    #dbg_value(double %sub720, !550, !DIExpression(), !1012)
  %124 = tail call double @llvm.fmuladd.f64(double %sub720, double 0.000000e+00, double %sub723), !dbg !1025
    #dbg_assign(double %124, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1026, ptr %arrayidx58, !DIExpression(), !653)
  %neg735 = fmul double %sub723, -0.000000e+00, !dbg !1025
  %125 = fsub double %neg735, %sub720, !dbg !1025
    #dbg_assign(double %125, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1027, ptr %arrayidx60, !DIExpression(), !653)
    #dbg_value(double %add698, !557, !DIExpression(), !1028)
    #dbg_value(double %add701, !559, !DIExpression(), !1028)
  %add742 = fadd double %add698, %add714, !dbg !1029
  store double %add742, ptr %data_x, align 8, !dbg !1029, !tbaa !360, !DIAssignID !1030
    #dbg_assign(double %add742, !439, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !1030, ptr %data_x, !DIExpression(), !653)
  %add745 = fadd double %add701, %add717, !dbg !1029
  store double %add745, ptr %data_y, align 8, !dbg !1029, !tbaa !360, !DIAssignID !1031
    #dbg_assign(double %add745, !441, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !1031, ptr %data_y, !DIExpression(), !653)
  %sub748 = fsub double %add698, %add714, !dbg !1029
  %arrayidx26.reg2mem.0.arrayidx26.reload92 = load ptr, ptr %arrayidx26.reg2mem, align 8
  store double %sub748, ptr %arrayidx26.reg2mem.0.arrayidx26.reload92, align 8, !dbg !1029, !tbaa !360, !DIAssignID !1032
    #dbg_assign(double %sub748, !439, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !1032, ptr %arrayidx26, !DIExpression(), !653)
  %sub751 = fsub double %add701, %add717, !dbg !1029
  %arrayidx28.reg2mem.0.arrayidx28.reload87 = load ptr, ptr %arrayidx28.reg2mem, align 8
  store double %sub751, ptr %arrayidx28.reg2mem.0.arrayidx28.reload87, align 8, !dbg !1029, !tbaa !360, !DIAssignID !1033
    #dbg_assign(double %sub751, !441, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !1033, ptr %arrayidx28, !DIExpression(), !653)
    #dbg_value(double %sub704, !560, !DIExpression(), !1034)
    #dbg_value(double %sub707, !562, !DIExpression(), !1034)
  %add758 = fadd double %sub704, %124, !dbg !1035
  %arrayidx42.reg2mem.0.arrayidx42.reload72 = load ptr, ptr %arrayidx42.reg2mem, align 8
  store double %add758, ptr %arrayidx42.reg2mem.0.arrayidx42.reload72, align 8, !dbg !1035, !tbaa !360, !DIAssignID !1036
    #dbg_assign(double %add758, !439, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !1036, ptr %arrayidx42, !DIExpression(), !653)
  %add761 = fadd double %sub707, %125, !dbg !1035
  %arrayidx44.reg2mem.0.arrayidx44.reload67 = load ptr, ptr %arrayidx44.reg2mem, align 8
  store double %add761, ptr %arrayidx44.reg2mem.0.arrayidx44.reload67, align 8, !dbg !1035, !tbaa !360, !DIAssignID !1037
    #dbg_assign(double %add761, !441, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !1037, ptr %arrayidx44, !DIExpression(), !653)
  %sub764 = fsub double %sub704, %124, !dbg !1035
  %arrayidx58.reg2mem.0.arrayidx58.reload52 = load ptr, ptr %arrayidx58.reg2mem, align 8
  store double %sub764, ptr %arrayidx58.reg2mem.0.arrayidx58.reload52, align 8, !dbg !1035, !tbaa !360, !DIAssignID !1038
    #dbg_assign(double %sub764, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1038, ptr %arrayidx58, !DIExpression(), !653)
  %sub767 = fsub double %sub707, %125, !dbg !1035
  %arrayidx60.reg2mem.0.arrayidx60.reload47 = load ptr, ptr %arrayidx60.reg2mem, align 8
  store double %sub767, ptr %arrayidx60.reg2mem.0.arrayidx60.reload47, align 8, !dbg !1035, !tbaa !360, !DIAssignID !1039
    #dbg_assign(double %sub767, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1039, ptr %arrayidx60, !DIExpression(), !653)
    #dbg_value(double 0.000000e+00, !563, !DIExpression(), !1040)
    #dbg_value(double -1.000000e+00, !565, !DIExpression(), !1040)
    #dbg_value(double %sub600, !567, !DIExpression(), !1041)
    #dbg_value(double %sub603, !569, !DIExpression(), !1041)
  %add777 = fadd double %sub600, %120, !dbg !1042
    #dbg_assign(double %add777, !439, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !1043, ptr %arrayidx14, !DIExpression(), !653)
  %add780 = fadd double %sub603, %121, !dbg !1042
    #dbg_assign(double %add780, !441, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !1044, ptr %arrayidx17, !DIExpression(), !653)
  %sub783 = fsub double %sub600, %120, !dbg !1042
    #dbg_assign(double %sub783, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1045, ptr %arrayidx45, !DIExpression(), !653)
  %sub786 = fsub double %sub603, %121, !dbg !1042
    #dbg_assign(double %sub786, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1046, ptr %arrayidx48, !DIExpression(), !653)
    #dbg_value(double %mul659, !570, !DIExpression(), !1047)
    #dbg_value(double %mul664, !572, !DIExpression(), !1047)
  %add793 = fadd double %mul659, %mul683, !dbg !1048
    #dbg_assign(double %add793, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1049, ptr %arrayidx29, !DIExpression(), !653)
  %add796 = fadd double %mul664, %mul688, !dbg !1048
    #dbg_assign(double %add796, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1050, ptr %arrayidx32, !DIExpression(), !653)
  %sub799 = fsub double %mul659, %mul683, !dbg !1048
    #dbg_assign(double %sub799, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1051, ptr %arrayidx61, !DIExpression(), !653)
  %sub802 = fsub double %mul664, %mul688, !dbg !1048
    #dbg_assign(double %sub802, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1052, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double %sub799, !566, !DIExpression(), !1040)
  %126 = tail call double @llvm.fmuladd.f64(double %sub799, double 0.000000e+00, double %sub802), !dbg !1053
    #dbg_assign(double %126, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1054, ptr %arrayidx61, !DIExpression(), !653)
  %neg814 = fmul double %sub802, -0.000000e+00, !dbg !1053
  %127 = fsub double %neg814, %sub799, !dbg !1053
    #dbg_assign(double %127, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1055, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double %add777, !573, !DIExpression(), !1056)
    #dbg_value(double %add780, !575, !DIExpression(), !1056)
  %add821 = fadd double %add777, %add793, !dbg !1057
  %arrayidx14.reg2mem.0.arrayidx14.reload102 = load ptr, ptr %arrayidx14.reg2mem, align 8
  store double %add821, ptr %arrayidx14.reg2mem.0.arrayidx14.reload102, align 8, !dbg !1057, !tbaa !360, !DIAssignID !1058
    #dbg_assign(double %add821, !439, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !1058, ptr %arrayidx14, !DIExpression(), !653)
  %add824 = fadd double %add780, %add796, !dbg !1057
  %arrayidx17.reg2mem.0.arrayidx17.reload97 = load ptr, ptr %arrayidx17.reg2mem, align 8
  store double %add824, ptr %arrayidx17.reg2mem.0.arrayidx17.reload97, align 8, !dbg !1057, !tbaa !360, !DIAssignID !1059
    #dbg_assign(double %add824, !441, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !1059, ptr %arrayidx17, !DIExpression(), !653)
  %sub827 = fsub double %add777, %add793, !dbg !1057
  %arrayidx29.reg2mem.0.arrayidx29.reload82 = load ptr, ptr %arrayidx29.reg2mem, align 8
  store double %sub827, ptr %arrayidx29.reg2mem.0.arrayidx29.reload82, align 8, !dbg !1057, !tbaa !360, !DIAssignID !1060
    #dbg_assign(double %sub827, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1060, ptr %arrayidx29, !DIExpression(), !653)
  %sub830 = fsub double %add780, %add796, !dbg !1057
  %arrayidx32.reg2mem.0.arrayidx32.reload77 = load ptr, ptr %arrayidx32.reg2mem, align 8
  store double %sub830, ptr %arrayidx32.reg2mem.0.arrayidx32.reload77, align 8, !dbg !1057, !tbaa !360, !DIAssignID !1061
    #dbg_assign(double %sub830, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1061, ptr %arrayidx32, !DIExpression(), !653)
    #dbg_value(double %sub783, !576, !DIExpression(), !1062)
    #dbg_value(double %sub786, !578, !DIExpression(), !1062)
  %add837 = fadd double %sub783, %126, !dbg !1063
  %arrayidx45.reg2mem.0.arrayidx45.reload62 = load ptr, ptr %arrayidx45.reg2mem, align 8
  store double %add837, ptr %arrayidx45.reg2mem.0.arrayidx45.reload62, align 8, !dbg !1063, !tbaa !360, !DIAssignID !1064
    #dbg_assign(double %add837, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1064, ptr %arrayidx45, !DIExpression(), !653)
  %add840 = fadd double %sub786, %127, !dbg !1063
  %arrayidx48.reg2mem.0.arrayidx48.reload57 = load ptr, ptr %arrayidx48.reg2mem, align 8
  store double %add840, ptr %arrayidx48.reg2mem.0.arrayidx48.reload57, align 8, !dbg !1063, !tbaa !360, !DIAssignID !1065
    #dbg_assign(double %add840, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1065, ptr %arrayidx48, !DIExpression(), !653)
  %sub843 = fsub double %sub783, %126, !dbg !1063
  %arrayidx61.reg2mem.0.arrayidx61.reload42 = load ptr, ptr %arrayidx61.reg2mem, align 8
  store double %sub843, ptr %arrayidx61.reg2mem.0.arrayidx61.reload42, align 8, !dbg !1063, !tbaa !360, !DIAssignID !1066
    #dbg_assign(double %sub843, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1066, ptr %arrayidx61, !DIExpression(), !653)
  %sub846 = fsub double %sub786, %127, !dbg !1063
  %arrayidx64.reg2mem.0.arrayidx64.reload37 = load ptr, ptr %arrayidx64.reg2mem, align 8
  store double %sub846, ptr %arrayidx64.reg2mem.0.arrayidx64.reload37, align 8, !dbg !1063, !tbaa !360, !DIAssignID !1067
    #dbg_assign(double %sub846, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1067, ptr %arrayidx64, !DIExpression(), !653)
  %shr848 = lshr i32 %tid.51866.reg2mem112.0.load, 3, !dbg !1068
    #dbg_value(i32 %shr848, !433, !DIExpression(), !653)
    #dbg_value(ptr %data_x, !329, !DIExpression(), !1069)
    #dbg_value(ptr %data_y, !330, !DIExpression(), !1069)
    #dbg_value(i32 %shr848, !331, !DIExpression(), !1069)
    #dbg_value(i32 64, !332, !DIExpression(), !1069)
    #dbg_assign(i1 undef, !333, !DIExpression(), !1071, ptr @__const.fft.reversed, !DIExpression(), !1069)
    #dbg_label(!342, !1072)
    #dbg_value(i32 1, !337, !DIExpression(), !1069)
  %conv2.i1827 = uitofp nneg i32 %shr848 to double
  store double %conv2.i1827, ptr %conv2.i1827.reg2mem, align 8
  store i64 1, ptr %indvars.iv.i1829.reg2mem, align 8
  br label %for.body.i1828, !dbg !1073

for.body.i1828:                                   ; preds = %for.body.i1828.for.body.i1828_crit_edge, %for.cond555.preheader
    #dbg_value(i64 %indvars.iv.i1829.reg2mem.0.load, !337, !DIExpression(), !1069)
  %indvars.iv.i1829.reg2mem.0.load = load i64, ptr %indvars.iv.i1829.reg2mem, align 8
  %arrayidx.i1830 = getelementptr inbounds [8 x i32], ptr @__const.fft.reversed, i64 0, i64 %indvars.iv.i1829.reg2mem.0.load, !dbg !1074
  %128 = load i32, ptr %arrayidx.i1830, align 4, !dbg !1074, !tbaa !350
  %conv.i1831 = sitofp i32 %128 to double, !dbg !1074
  %mul.i1832 = fmul double %conv.i1831, 0xC01921FB54411744, !dbg !1075
  %div.i1833 = fmul double %mul.i1832, 1.562500e-02, !dbg !1076
  %mul3.i1834 = fmul double %div.i1833, %conv2.i1827, !dbg !1077
    #dbg_value(double %mul3.i1834, !338, !DIExpression(), !1069)
  %call.i1835 = tail call double @cos(double noundef %mul3.i1834) #19, !dbg !1078
    #dbg_value(double %call.i1835, !340, !DIExpression(), !1069)
  %call4.i1836 = tail call double @sin(double noundef %mul3.i1834) #19, !dbg !1079
    #dbg_value(double %call4.i1836, !341, !DIExpression(), !1069)
  %arrayidx6.i1837 = getelementptr inbounds double, ptr %data_x, i64 %indvars.iv.i1829.reg2mem.0.load, !dbg !1080
  %129 = load double, ptr %arrayidx6.i1837, align 8, !dbg !1080, !tbaa !360
    #dbg_value(double %129, !339, !DIExpression(), !1069)
  %arrayidx11.i1838 = getelementptr inbounds double, ptr %data_y, i64 %indvars.iv.i1829.reg2mem.0.load, !dbg !1081
  %130 = load double, ptr %arrayidx11.i1838, align 8, !dbg !1081, !tbaa !360
  %131 = fneg double %130, !dbg !1081
  %neg.i1839 = fmul double %call4.i1836, %131, !dbg !1081
  %132 = tail call double @llvm.fmuladd.f64(double %129, double %call.i1835, double %neg.i1839), !dbg !1081
  store double %132, ptr %arrayidx6.i1837, align 8, !dbg !1082, !tbaa !360
  %mul18.i1840 = fmul double %call.i1835, %130, !dbg !1083
  %133 = tail call double @llvm.fmuladd.f64(double %129, double %call4.i1836, double %mul18.i1840), !dbg !1083
  store double %133, ptr %arrayidx11.i1838, align 8, !dbg !1084, !tbaa !360
  %indvars.iv.next.i1841 = add nuw nsw i64 %indvars.iv.i1829.reg2mem.0.load, 1, !dbg !1085
    #dbg_value(i64 %indvars.iv.next.i1841, !337, !DIExpression(), !1069)
  store i64 %indvars.iv.next.i1841, ptr %indvars.iv.next.i1841.reg2mem, align 8
  %exitcond.not.i1842 = icmp eq i64 %indvars.iv.next.i1841, 8, !dbg !1086
  br i1 %exitcond.not.i1842, label %for.cond852.preheader, label %for.body.i1828.for.body.i1828_crit_edge, !dbg !1073, !llvm.loop !1087

for.body.i1828.for.body.i1828_crit_edge:          ; preds = %for.body.i1828
  store i64 %indvars.iv.next.i1841, ptr %indvars.iv.i1829.reg2mem, align 8
  br label %for.body.i1828, !dbg !1073

for.cond852.preheader:                            ; preds = %for.body.i1828
    #dbg_value(i64 0, !579, !DIExpression(), !1089)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %scevgep1932, ptr noundef nonnull align 8 dereferenceable(64) %data_x, i64 64, i1 false), !dbg !1090, !tbaa !360
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %scevgep1933, ptr noundef nonnull align 8 dereferenceable(64) %data_y, i64 64, i1 false), !dbg !1093, !tbaa !360
    #dbg_value(i64 poison, !579, !DIExpression(), !1089)
  %inc871 = add nuw nsw i32 %tid.51866.reg2mem112.0.load, 1, !dbg !1094
    #dbg_value(i32 %inc871, !432, !DIExpression(), !653)
  store i32 %inc871, ptr %inc871.reg2mem, align 4
  %indvar.next1929 = add nuw nsw i64 %indvar1928.reg2mem114.0.load, 1, !dbg !1095
  store i64 %indvar.next1929, ptr %indvar.next1929.reg2mem, align 8
  %exitcond1934.not = icmp eq i64 %indvar.next1929, 64, !dbg !1096
  br i1 %exitcond1934.not, label %for.cond852.preheader.for.body876_crit_edge, label %for.cond852.preheader.for.cond555.preheader_crit_edge, !dbg !1095, !llvm.loop !1097

for.cond852.preheader.for.cond555.preheader_crit_edge: ; preds = %for.cond852.preheader
  store i32 %inc871, ptr %tid.51866.reg2mem112, align 4
  store i64 %indvar.next1929, ptr %indvar1928.reg2mem114, align 8
  br label %for.cond555.preheader, !dbg !1095

for.cond852.preheader.for.body876_crit_edge:      ; preds = %for.cond852.preheader
  store i64 0, ptr %indvars.iv1935.reg2mem, align 8
  br label %for.body876, !dbg !1095

for.body876:                                      ; preds = %for.body876.for.body876_crit_edge, %for.cond852.preheader.for.body876_crit_edge
    #dbg_value(i64 %indvars.iv1935.reg2mem.0.load, !432, !DIExpression(), !653)
    #dbg_value(i64 %indvars.iv1935.reg2mem.0.load, !433, !DIExpression(DW_OP_constu, 3, DW_OP_shr, DW_OP_stack_value), !653)
    #dbg_value(i64 %indvars.iv1935.reg2mem.0.load, !434, !DIExpression(DW_OP_constu, 7, DW_OP_and, DW_OP_stack_value), !653)
    #dbg_value(i64 %indvars.iv1935.reg2mem.0.load, !507, !DIExpression(), !653)
  %indvars.iv1935.reg2mem.0.load = load i64, ptr %indvars.iv1935.reg2mem, align 8
  %134 = shl nuw nsw i64 %indvars.iv1935.reg2mem.0.load, 3, !dbg !1099
  %arrayidx884 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %134, !dbg !1103
  %135 = load double, ptr %arrayidx884, align 8, !dbg !1103, !tbaa !360
  %arrayidx888 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %indvars.iv1935.reg2mem.0.load, !dbg !1104
  store double %135, ptr %arrayidx888, align 8, !dbg !1105, !tbaa !360
  %136 = or disjoint i64 %134, 1, !dbg !1106
  %arrayidx892 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %136, !dbg !1107
  %137 = load double, ptr %arrayidx892, align 8, !dbg !1107, !tbaa !360
  %138 = add nuw nsw i64 %indvars.iv1935.reg2mem.0.load, 288, !dbg !1108
  %arrayidx896 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %138, !dbg !1109
  store double %137, ptr %arrayidx896, align 8, !dbg !1110, !tbaa !360
  %139 = or disjoint i64 %134, 4, !dbg !1111
  %arrayidx900 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %139, !dbg !1112
  %140 = load double, ptr %arrayidx900, align 8, !dbg !1112, !tbaa !360
  %141 = add nuw nsw i64 %indvars.iv1935.reg2mem.0.load, 72, !dbg !1113
  %arrayidx904 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %141, !dbg !1114
  store double %140, ptr %arrayidx904, align 8, !dbg !1115, !tbaa !360
  %142 = or disjoint i64 %134, 5, !dbg !1116
  %arrayidx908 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %142, !dbg !1117
  %143 = load double, ptr %arrayidx908, align 8, !dbg !1117, !tbaa !360
  %144 = add nuw nsw i64 %indvars.iv1935.reg2mem.0.load, 360, !dbg !1118
  %arrayidx912 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %144, !dbg !1119
  store double %143, ptr %arrayidx912, align 8, !dbg !1120, !tbaa !360
  %145 = or disjoint i64 %134, 2, !dbg !1121
  %arrayidx916 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %145, !dbg !1122
  %146 = load double, ptr %arrayidx916, align 8, !dbg !1122, !tbaa !360
  %147 = add nuw nsw i64 %indvars.iv1935.reg2mem.0.load, 144, !dbg !1123
  %arrayidx920 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %147, !dbg !1124
  store double %146, ptr %arrayidx920, align 8, !dbg !1125, !tbaa !360
  %148 = or disjoint i64 %134, 3, !dbg !1126
  %arrayidx924 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %148, !dbg !1127
  %149 = load double, ptr %arrayidx924, align 8, !dbg !1127, !tbaa !360
  %150 = add nuw nsw i64 %indvars.iv1935.reg2mem.0.load, 432, !dbg !1128
  %arrayidx928 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %150, !dbg !1129
  store double %149, ptr %arrayidx928, align 8, !dbg !1130, !tbaa !360
  %151 = or disjoint i64 %134, 6, !dbg !1131
  %arrayidx932 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %151, !dbg !1132
  %152 = load double, ptr %arrayidx932, align 8, !dbg !1132, !tbaa !360
  %153 = add nuw nsw i64 %indvars.iv1935.reg2mem.0.load, 216, !dbg !1133
  %arrayidx936 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %153, !dbg !1134
  store double %152, ptr %arrayidx936, align 8, !dbg !1135, !tbaa !360
  %154 = or disjoint i64 %134, 7, !dbg !1136
  %arrayidx940 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %154, !dbg !1137
  %155 = load double, ptr %arrayidx940, align 8, !dbg !1137, !tbaa !360
  %156 = add nuw nsw i64 %indvars.iv1935.reg2mem.0.load, 504, !dbg !1138
  %arrayidx944 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %156, !dbg !1139
  store double %155, ptr %arrayidx944, align 8, !dbg !1140, !tbaa !360
  %indvars.iv.next1936 = add nuw nsw i64 %indvars.iv1935.reg2mem.0.load, 1, !dbg !1141
    #dbg_value(i64 %indvars.iv.next1936, !432, !DIExpression(), !653)
  store i64 %indvars.iv.next1936, ptr %indvars.iv.next1936.reg2mem, align 8
  %exitcond1952.not = icmp eq i64 %indvars.iv.next1936, 64, !dbg !1142
  br i1 %exitcond1952.not, label %for.body876.for.body951_crit_edge, label %for.body876.for.body876_crit_edge, !dbg !1143, !llvm.loop !1144

for.body876.for.body876_crit_edge:                ; preds = %for.body876
  store i64 %indvars.iv.next1936, ptr %indvars.iv1935.reg2mem, align 8
  br label %for.body876, !dbg !1143

for.body876.for.body951_crit_edge:                ; preds = %for.body876
  store i64 0, ptr %indvars.iv1953.reg2mem, align 8
  br label %for.body951, !dbg !1143

for.body951:                                      ; preds = %for.body951.for.body951_crit_edge, %for.body876.for.body951_crit_edge
    #dbg_value(i64 %indvars.iv1953.reg2mem.0.load, !432, !DIExpression(), !653)
  %indvars.iv1953.reg2mem.0.load = load i64, ptr %indvars.iv1953.reg2mem, align 8
  %157 = trunc i64 %indvars.iv1953.reg2mem.0.load to i32, !dbg !1146
  %shr952 = lshr i32 %157, 3, !dbg !1146
    #dbg_value(i32 %shr952, !433, !DIExpression(), !653)
  %and953 = and i32 %157, 7, !dbg !1150
    #dbg_value(i32 %and953, !434, !DIExpression(), !653)
  %mul954 = mul nuw nsw i32 %shr952, 72, !dbg !1151
  %add955 = or disjoint i32 %mul954, %and953, !dbg !1152
    #dbg_value(i32 %add955, !507, !DIExpression(), !653)
  %idxprom958 = zext nneg i32 %add955 to i64, !dbg !1153
  %arrayidx959 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom958, !dbg !1153
  %158 = load double, ptr %arrayidx959, align 8, !dbg !1153, !tbaa !360
  %159 = shl nuw nsw i64 %indvars.iv1953.reg2mem.0.load, 3, !dbg !1154
  %arrayidx963 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %159, !dbg !1155
  store double %158, ptr %arrayidx963, align 8, !dbg !1156, !tbaa !360
  %add965 = add nuw nsw i32 %add955, 32, !dbg !1157
  %idxprom966 = zext nneg i32 %add965 to i64, !dbg !1158
  %arrayidx967 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom966, !dbg !1158
  %160 = load double, ptr %arrayidx967, align 8, !dbg !1158, !tbaa !360
  %161 = or disjoint i64 %159, 4, !dbg !1159
  %arrayidx971 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %161, !dbg !1160
  store double %160, ptr %arrayidx971, align 8, !dbg !1161, !tbaa !360
  %add973 = add nuw nsw i32 %add955, 8, !dbg !1162
  %idxprom974 = zext nneg i32 %add973 to i64, !dbg !1163
  %arrayidx975 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom974, !dbg !1163
  %162 = load double, ptr %arrayidx975, align 8, !dbg !1163, !tbaa !360
  %163 = or disjoint i64 %159, 1, !dbg !1164
  %arrayidx979 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %163, !dbg !1165
  store double %162, ptr %arrayidx979, align 8, !dbg !1166, !tbaa !360
  %add981 = add nuw nsw i32 %add955, 40, !dbg !1167
  %idxprom982 = zext nneg i32 %add981 to i64, !dbg !1168
  %arrayidx983 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom982, !dbg !1168
  %164 = load double, ptr %arrayidx983, align 8, !dbg !1168, !tbaa !360
  %165 = or disjoint i64 %159, 5, !dbg !1169
  %arrayidx987 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %165, !dbg !1170
  store double %164, ptr %arrayidx987, align 8, !dbg !1171, !tbaa !360
  %add989 = add nuw nsw i32 %add955, 16, !dbg !1172
  %idxprom990 = zext nneg i32 %add989 to i64, !dbg !1173
  %arrayidx991 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom990, !dbg !1173
  %166 = load double, ptr %arrayidx991, align 8, !dbg !1173, !tbaa !360
  %167 = or disjoint i64 %159, 2, !dbg !1174
  %arrayidx995 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %167, !dbg !1175
  store double %166, ptr %arrayidx995, align 8, !dbg !1176, !tbaa !360
  %add997 = add nuw nsw i32 %add955, 48, !dbg !1177
  %idxprom998 = zext nneg i32 %add997 to i64, !dbg !1178
  %arrayidx999 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom998, !dbg !1178
  %168 = load double, ptr %arrayidx999, align 8, !dbg !1178, !tbaa !360
  %169 = or disjoint i64 %159, 6, !dbg !1179
  %arrayidx1003 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %169, !dbg !1180
  store double %168, ptr %arrayidx1003, align 8, !dbg !1181, !tbaa !360
  %add1005 = add nuw nsw i32 %add955, 24, !dbg !1182
  %idxprom1006 = zext nneg i32 %add1005 to i64, !dbg !1183
  %arrayidx1007 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom1006, !dbg !1183
  %170 = load double, ptr %arrayidx1007, align 8, !dbg !1183, !tbaa !360
  %171 = or disjoint i64 %159, 3, !dbg !1184
  %arrayidx1011 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %171, !dbg !1185
  store double %170, ptr %arrayidx1011, align 8, !dbg !1186, !tbaa !360
  %add1013 = add nuw nsw i32 %add955, 56, !dbg !1187
  %idxprom1014 = zext nneg i32 %add1013 to i64, !dbg !1188
  %arrayidx1015 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %idxprom1014, !dbg !1188
  %172 = load double, ptr %arrayidx1015, align 8, !dbg !1188, !tbaa !360
  %173 = or disjoint i64 %159, 7, !dbg !1189
  %arrayidx1019 = getelementptr inbounds [512 x double], ptr %DATA_x, i64 0, i64 %173, !dbg !1190
  store double %172, ptr %arrayidx1019, align 8, !dbg !1191, !tbaa !360
  %indvars.iv.next1954 = add nuw nsw i64 %indvars.iv1953.reg2mem.0.load, 1, !dbg !1192
    #dbg_value(i64 %indvars.iv.next1954, !432, !DIExpression(), !653)
  %exitcond1963.not = icmp eq i64 %indvars.iv.next1954, 64, !dbg !1193
  br i1 %exitcond1963.not, label %for.body951.for.body1026_crit_edge, label %for.body951.for.body951_crit_edge, !dbg !1194, !llvm.loop !1195

for.body951.for.body951_crit_edge:                ; preds = %for.body951
  store i64 %indvars.iv.next1954, ptr %indvars.iv1953.reg2mem, align 8
  br label %for.body951, !dbg !1194

for.body951.for.body1026_crit_edge:               ; preds = %for.body951
  store i64 0, ptr %indvars.iv1964.reg2mem, align 8
  br label %for.body1026, !dbg !1194

for.body1026:                                     ; preds = %for.body1026.for.body1026_crit_edge, %for.body951.for.body1026_crit_edge
    #dbg_value(i64 %indvars.iv1964.reg2mem.0.load, !432, !DIExpression(), !653)
    #dbg_value(i64 %indvars.iv1964.reg2mem.0.load, !433, !DIExpression(DW_OP_constu, 3, DW_OP_shr, DW_OP_stack_value), !653)
    #dbg_value(i64 %indvars.iv1964.reg2mem.0.load, !434, !DIExpression(DW_OP_constu, 7, DW_OP_and, DW_OP_stack_value), !653)
    #dbg_value(i64 %indvars.iv1964.reg2mem.0.load, !507, !DIExpression(), !653)
  %indvars.iv1964.reg2mem.0.load = load i64, ptr %indvars.iv1964.reg2mem, align 8
  %174 = shl nuw nsw i64 %indvars.iv1964.reg2mem.0.load, 3, !dbg !1197
  %arrayidx1034 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %174, !dbg !1201
  %175 = load double, ptr %arrayidx1034, align 8, !dbg !1201, !tbaa !360
  %arrayidx1038 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %indvars.iv1964.reg2mem.0.load, !dbg !1202
  store double %175, ptr %arrayidx1038, align 8, !dbg !1203, !tbaa !360
  %176 = or disjoint i64 %174, 1, !dbg !1204
  %arrayidx1042 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %176, !dbg !1205
  %177 = load double, ptr %arrayidx1042, align 8, !dbg !1205, !tbaa !360
  %178 = add nuw nsw i64 %indvars.iv1964.reg2mem.0.load, 288, !dbg !1206
  %arrayidx1046 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %178, !dbg !1207
  store double %177, ptr %arrayidx1046, align 8, !dbg !1208, !tbaa !360
  %179 = or disjoint i64 %174, 4, !dbg !1209
  %arrayidx1050 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %179, !dbg !1210
  %180 = load double, ptr %arrayidx1050, align 8, !dbg !1210, !tbaa !360
  %181 = add nuw nsw i64 %indvars.iv1964.reg2mem.0.load, 72, !dbg !1211
  %arrayidx1054 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %181, !dbg !1212
  store double %180, ptr %arrayidx1054, align 8, !dbg !1213, !tbaa !360
  %182 = or disjoint i64 %174, 5, !dbg !1214
  %arrayidx1058 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %182, !dbg !1215
  %183 = load double, ptr %arrayidx1058, align 8, !dbg !1215, !tbaa !360
  %184 = add nuw nsw i64 %indvars.iv1964.reg2mem.0.load, 360, !dbg !1216
  %arrayidx1062 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %184, !dbg !1217
  store double %183, ptr %arrayidx1062, align 8, !dbg !1218, !tbaa !360
  %185 = or disjoint i64 %174, 2, !dbg !1219
  %arrayidx1066 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %185, !dbg !1220
  %186 = load double, ptr %arrayidx1066, align 8, !dbg !1220, !tbaa !360
  %187 = add nuw nsw i64 %indvars.iv1964.reg2mem.0.load, 144, !dbg !1221
  %arrayidx1070 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %187, !dbg !1222
  store double %186, ptr %arrayidx1070, align 8, !dbg !1223, !tbaa !360
  %188 = or disjoint i64 %174, 3, !dbg !1224
  %arrayidx1074 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %188, !dbg !1225
  %189 = load double, ptr %arrayidx1074, align 8, !dbg !1225, !tbaa !360
  %190 = add nuw nsw i64 %indvars.iv1964.reg2mem.0.load, 432, !dbg !1226
  %arrayidx1078 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %190, !dbg !1227
  store double %189, ptr %arrayidx1078, align 8, !dbg !1228, !tbaa !360
  %191 = or disjoint i64 %174, 6, !dbg !1229
  %arrayidx1082 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %191, !dbg !1230
  %192 = load double, ptr %arrayidx1082, align 8, !dbg !1230, !tbaa !360
  %193 = add nuw nsw i64 %indvars.iv1964.reg2mem.0.load, 216, !dbg !1231
  %arrayidx1086 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %193, !dbg !1232
  store double %192, ptr %arrayidx1086, align 8, !dbg !1233, !tbaa !360
  %194 = or disjoint i64 %174, 7, !dbg !1234
  %arrayidx1090 = getelementptr inbounds [512 x double], ptr %DATA_y, i64 0, i64 %194, !dbg !1235
  %195 = load double, ptr %arrayidx1090, align 8, !dbg !1235, !tbaa !360
  %196 = add nuw nsw i64 %indvars.iv1964.reg2mem.0.load, 504, !dbg !1236
  %arrayidx1094 = getelementptr inbounds [576 x double], ptr %smem, i64 0, i64 %196, !dbg !1237
  store double %195, ptr %arrayidx1094, align 8, !dbg !1238, !tbaa !360
  %indvars.iv.next1965 = add nuw nsw i64 %indvars.iv1964.reg2mem.0.load, 1, !dbg !1239
    #dbg_value(i64 %indvars.iv.next1965, !432, !DIExpression(), !653)
  %exitcond1981.not = icmp eq i64 %indvars.iv.next1965, 64, !dbg !1240
  br i1 %exitcond1981.not, label %for.body1026.for.cond1103.preheader_crit_edge, label %for.body1026.for.body1026_crit_edge, !dbg !1241, !llvm.loop !1242

for.body1026.for.body1026_crit_edge:              ; preds = %for.body1026
  store i64 %indvars.iv.next1965, ptr %indvars.iv1964.reg2mem, align 8
  br label %for.body1026, !dbg !1241

for.body1026.for.cond1103.preheader_crit_edge:    ; preds = %for.body1026
  store i32 0, ptr %tid.91872.reg2mem108, align 4
  store i64 0, ptr %indvar1982.reg2mem110, align 8
  br label %for.cond1103.preheader, !dbg !1241

for.cond1103.preheader:                           ; preds = %for.cond1123.preheader.for.cond1103.preheader_crit_edge, %for.body1026.for.cond1103.preheader_crit_edge
    #dbg_value(i32 %tid.91872.reg2mem108.0.load, !432, !DIExpression(), !653)
  %indvar1982.reg2mem110.0.load = load i64, ptr %indvar1982.reg2mem110, align 8
  %tid.91872.reg2mem108.0.load = load i32, ptr %tid.91872.reg2mem108, align 4
  %197 = shl nuw nsw i64 %indvar1982.reg2mem110.0.load, 6
  %scevgep1985 = getelementptr i8, ptr %DATA_y, i64 %197
    #dbg_value(i64 0, !585, !DIExpression(), !1244)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %data_y, ptr noundef nonnull align 8 dereferenceable(64) %scevgep1985, i64 64, i1 false), !dbg !1245, !tbaa !360
    #dbg_value(i64 poison, !585, !DIExpression(), !1244)
  %shr1116 = lshr i32 %tid.91872.reg2mem108.0.load, 3, !dbg !1248
    #dbg_value(i32 %shr1116, !433, !DIExpression(), !653)
  %and1117 = and i32 %tid.91872.reg2mem108.0.load, 7, !dbg !1249
    #dbg_value(i32 %and1117, !434, !DIExpression(), !653)
  %mul1120 = mul nuw nsw i32 %shr1116, 72, !dbg !1250
  %add1121 = or disjoint i32 %mul1120, %and1117, !dbg !1251
    #dbg_value(ptr %data_y, !405, !DIExpression(), !1252)
    #dbg_value(ptr %smem, !406, !DIExpression(), !1252)
    #dbg_value(i32 %add1121, !407, !DIExpression(), !1252)
    #dbg_value(i32 8, !408, !DIExpression(), !1252)
    #dbg_value(i64 0, !409, !DIExpression(), !1254)
  %conv1.i1844 = zext nneg i32 %add1121 to i64
  %invariant.gep.i1845 = getelementptr double, ptr %smem, i64 %conv1.i1844, !dbg !1255
  store i64 0, ptr %i.06.i1847.reg2mem, align 8
  br label %for.body.i1846, !dbg !1256

for.body.i1846:                                   ; preds = %for.body.i1846.for.body.i1846_crit_edge, %for.cond1103.preheader
    #dbg_value(i64 %i.06.i1847.reg2mem.0.load, !409, !DIExpression(), !1254)
  %i.06.i1847.reg2mem.0.load = load i64, ptr %i.06.i1847.reg2mem, align 8
  %gep.i1849.idx = shl i64 %i.06.i1847.reg2mem.0.load, 6, !dbg !1257
  %gep.i1849 = getelementptr i8, ptr %invariant.gep.i1845, i64 %gep.i1849.idx, !dbg !1257
  %198 = load double, ptr %gep.i1849, align 8, !dbg !1257, !tbaa !360
  %arrayidx2.i1850 = getelementptr inbounds double, ptr %data_y, i64 %i.06.i1847.reg2mem.0.load, !dbg !1258
  store double %198, ptr %arrayidx2.i1850, align 8, !dbg !1259, !tbaa !360
  %inc.i1851 = add nuw nsw i64 %i.06.i1847.reg2mem.0.load, 1, !dbg !1260
    #dbg_value(i64 %inc.i1851, !409, !DIExpression(), !1254)
  %exitcond.not.i1852 = icmp eq i64 %inc.i1851, 8, !dbg !1261
  br i1 %exitcond.not.i1852, label %for.cond1123.preheader, label %for.body.i1846.for.body.i1846_crit_edge, !dbg !1256, !llvm.loop !1262

for.body.i1846.for.body.i1846_crit_edge:          ; preds = %for.body.i1846
  store i64 %inc.i1851, ptr %i.06.i1847.reg2mem, align 8
  br label %for.body.i1846, !dbg !1256

for.cond1123.preheader:                           ; preds = %for.body.i1846
    #dbg_value(i64 0, !590, !DIExpression(), !1264)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %scevgep1985, ptr noundef nonnull align 8 dereferenceable(64) %data_y, i64 64, i1 false), !dbg !1265, !tbaa !360
    #dbg_value(i64 poison, !590, !DIExpression(), !1264)
  %inc1137 = add nuw nsw i32 %tid.91872.reg2mem108.0.load, 1, !dbg !1268
    #dbg_value(i32 %inc1137, !432, !DIExpression(), !653)
  %indvar.next1983 = add nuw nsw i64 %indvar1982.reg2mem110.0.load, 1, !dbg !1269
  %exitcond1986.not = icmp eq i64 %indvar.next1983, 64, !dbg !1270
  br i1 %exitcond1986.not, label %for.cond1123.preheader.for.cond1144.preheader_crit_edge, label %for.cond1123.preheader.for.cond1103.preheader_crit_edge, !dbg !1269, !llvm.loop !1271

for.cond1123.preheader.for.cond1103.preheader_crit_edge: ; preds = %for.cond1123.preheader
  store i32 %inc1137, ptr %tid.91872.reg2mem108, align 4
  store i64 %indvar.next1983, ptr %indvar1982.reg2mem110, align 8
  br label %for.cond1103.preheader, !dbg !1269

for.cond1123.preheader.for.cond1144.preheader_crit_edge: ; preds = %for.cond1123.preheader
  store i64 0, ptr %indvar1987.reg2mem106, align 8
  br label %for.cond1144.preheader, !dbg !1269

for.cond1144.preheader:                           ; preds = %for.cond.cleanup1432.for.cond1144.preheader_crit_edge, %for.cond1123.preheader.for.cond1144.preheader_crit_edge
    #dbg_value(i64 %indvar1987.reg2mem106.0.load, !432, !DIExpression(), !653)
  %indvar1987.reg2mem106.0.load = load i64, ptr %indvar1987.reg2mem106, align 8
  %199 = shl nuw nsw i64 %indvar1987.reg2mem106.0.load, 6
  %scevgep1990 = getelementptr i8, ptr %DATA_x, i64 %199
  %scevgep1989 = getelementptr i8, ptr %DATA_y, i64 %199
    #dbg_value(i64 0, !593, !DIExpression(), !1273)
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %data_y, ptr noundef nonnull align 8 dereferenceable(64) %scevgep1989, i64 64, i1 false), !dbg !1274, !tbaa !360
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(64) %data_x, ptr noundef nonnull align 8 dereferenceable(64) %scevgep1990, i64 64, i1 false), !dbg !1277, !tbaa !360
    #dbg_value(i64 poison, !593, !DIExpression(), !1273)
    #dbg_value(double 1.000000e+00, !598, !DIExpression(), !1278)
    #dbg_value(double -1.000000e+00, !602, !DIExpression(), !1278)
    #dbg_value(double 0.000000e+00, !600, !DIExpression(), !1278)
    #dbg_value(double -1.000000e+00, !603, !DIExpression(), !1278)
    #dbg_value(double -1.000000e+00, !601, !DIExpression(), !1278)
    #dbg_value(double -1.000000e+00, !604, !DIExpression(), !1278)
  %200 = load double, ptr %data_x, align 8, !dbg !1279, !tbaa !360
    #dbg_value(double %200, !606, !DIExpression(), !1280)
  %201 = load double, ptr %data_y, align 8, !dbg !1279, !tbaa !360
    #dbg_value(double %201, !608, !DIExpression(), !1280)
  %arrayidx14.reg2mem.0.arrayidx14.reload105 = load ptr, ptr %arrayidx14.reg2mem, align 8
  %202 = load double, ptr %arrayidx14.reg2mem.0.arrayidx14.reload105, align 8, !dbg !1279, !tbaa !360
  %add1174 = fadd double %200, %202, !dbg !1279
    #dbg_assign(double %add1174, !439, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !1281, ptr %data_x, !DIExpression(), !653)
  %arrayidx17.reg2mem.0.arrayidx17.reload100 = load ptr, ptr %arrayidx17.reg2mem, align 8
  %203 = load double, ptr %arrayidx17.reg2mem.0.arrayidx17.reload100, align 8, !dbg !1279, !tbaa !360
  %add1177 = fadd double %201, %203, !dbg !1279
    #dbg_assign(double %add1177, !441, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !1282, ptr %data_y, !DIExpression(), !653)
  %sub1180 = fsub double %200, %202, !dbg !1279
    #dbg_assign(double %sub1180, !439, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !1283, ptr %arrayidx14, !DIExpression(), !653)
  %sub1183 = fsub double %201, %203, !dbg !1279
    #dbg_assign(double %sub1183, !441, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !1284, ptr %arrayidx17, !DIExpression(), !653)
  %arrayidx26.reg2mem.0.arrayidx26.reload95 = load ptr, ptr %arrayidx26.reg2mem, align 8
  %204 = load double, ptr %arrayidx26.reg2mem.0.arrayidx26.reload95, align 8, !dbg !1285, !tbaa !360
    #dbg_value(double %204, !609, !DIExpression(), !1286)
  %arrayidx28.reg2mem.0.arrayidx28.reload90 = load ptr, ptr %arrayidx28.reg2mem, align 8
  %205 = load double, ptr %arrayidx28.reg2mem.0.arrayidx28.reload90, align 8, !dbg !1285, !tbaa !360
    #dbg_value(double %205, !611, !DIExpression(), !1286)
  %arrayidx29.reg2mem.0.arrayidx29.reload85 = load ptr, ptr %arrayidx29.reg2mem, align 8
  %206 = load double, ptr %arrayidx29.reg2mem.0.arrayidx29.reload85, align 8, !dbg !1285, !tbaa !360
  %add1190 = fadd double %204, %206, !dbg !1285
    #dbg_assign(double %add1190, !439, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !1287, ptr %arrayidx26, !DIExpression(), !653)
  %arrayidx32.reg2mem.0.arrayidx32.reload80 = load ptr, ptr %arrayidx32.reg2mem, align 8
  %207 = load double, ptr %arrayidx32.reg2mem.0.arrayidx32.reload80, align 8, !dbg !1285, !tbaa !360
  %add1193 = fadd double %205, %207, !dbg !1285
    #dbg_assign(double %add1193, !441, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !1288, ptr %arrayidx28, !DIExpression(), !653)
  %sub1196 = fsub double %204, %206, !dbg !1285
    #dbg_assign(double %sub1196, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1289, ptr %arrayidx29, !DIExpression(), !653)
  %sub1199 = fsub double %205, %207, !dbg !1285
    #dbg_assign(double %sub1199, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1290, ptr %arrayidx32, !DIExpression(), !653)
  %arrayidx42.reg2mem.0.arrayidx42.reload75 = load ptr, ptr %arrayidx42.reg2mem, align 8
  %208 = load double, ptr %arrayidx42.reg2mem.0.arrayidx42.reload75, align 8, !dbg !1291, !tbaa !360
    #dbg_value(double %208, !612, !DIExpression(), !1292)
  %arrayidx44.reg2mem.0.arrayidx44.reload70 = load ptr, ptr %arrayidx44.reg2mem, align 8
  %209 = load double, ptr %arrayidx44.reg2mem.0.arrayidx44.reload70, align 8, !dbg !1291, !tbaa !360
    #dbg_value(double %209, !614, !DIExpression(), !1292)
  %arrayidx45.reg2mem.0.arrayidx45.reload65 = load ptr, ptr %arrayidx45.reg2mem, align 8
  %210 = load double, ptr %arrayidx45.reg2mem.0.arrayidx45.reload65, align 8, !dbg !1291, !tbaa !360
  %add1206 = fadd double %208, %210, !dbg !1291
    #dbg_assign(double %add1206, !439, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !1293, ptr %arrayidx42, !DIExpression(), !653)
  %arrayidx48.reg2mem.0.arrayidx48.reload60 = load ptr, ptr %arrayidx48.reg2mem, align 8
  %211 = load double, ptr %arrayidx48.reg2mem.0.arrayidx48.reload60, align 8, !dbg !1291, !tbaa !360
  %add1209 = fadd double %209, %211, !dbg !1291
    #dbg_assign(double %add1209, !441, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !1294, ptr %arrayidx44, !DIExpression(), !653)
  %sub1212 = fsub double %208, %210, !dbg !1291
    #dbg_assign(double %sub1212, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1295, ptr %arrayidx45, !DIExpression(), !653)
  %sub1215 = fsub double %209, %211, !dbg !1291
    #dbg_assign(double %sub1215, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1296, ptr %arrayidx48, !DIExpression(), !653)
  %arrayidx58.reg2mem.0.arrayidx58.reload55 = load ptr, ptr %arrayidx58.reg2mem, align 8
  %212 = load double, ptr %arrayidx58.reg2mem.0.arrayidx58.reload55, align 8, !dbg !1297, !tbaa !360
    #dbg_value(double %212, !615, !DIExpression(), !1298)
  %arrayidx60.reg2mem.0.arrayidx60.reload50 = load ptr, ptr %arrayidx60.reg2mem, align 8
  %213 = load double, ptr %arrayidx60.reg2mem.0.arrayidx60.reload50, align 8, !dbg !1297, !tbaa !360
    #dbg_value(double %213, !617, !DIExpression(), !1298)
  %arrayidx61.reg2mem.0.arrayidx61.reload45 = load ptr, ptr %arrayidx61.reg2mem, align 8
  %214 = load double, ptr %arrayidx61.reg2mem.0.arrayidx61.reload45, align 8, !dbg !1297, !tbaa !360
  %add1222 = fadd double %212, %214, !dbg !1297
    #dbg_assign(double %add1222, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1299, ptr %arrayidx58, !DIExpression(), !653)
  %arrayidx64.reg2mem.0.arrayidx64.reload40 = load ptr, ptr %arrayidx64.reg2mem, align 8
  %215 = load double, ptr %arrayidx64.reg2mem.0.arrayidx64.reload40, align 8, !dbg !1297, !tbaa !360
  %add1225 = fadd double %213, %215, !dbg !1297
    #dbg_assign(double %add1225, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1300, ptr %arrayidx60, !DIExpression(), !653)
  %sub1228 = fsub double %212, %214, !dbg !1297
    #dbg_assign(double %sub1228, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1301, ptr %arrayidx61, !DIExpression(), !653)
  %sub1231 = fsub double %213, %215, !dbg !1297
    #dbg_assign(double %sub1231, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1302, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double %sub1196, !605, !DIExpression(), !1278)
  %216 = fadd double %sub1196, %sub1199, !dbg !1303
  %mul1239 = fmul double %216, 0x3FE6A09E667F3BCD, !dbg !1303
    #dbg_assign(double %mul1239, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1304, ptr %arrayidx29, !DIExpression(), !653)
  %217 = fsub double %sub1199, %sub1196, !dbg !1303
  %mul1244 = fmul double %217, 0x3FE6A09E667F3BCD, !dbg !1303
    #dbg_assign(double %mul1244, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1305, ptr %arrayidx32, !DIExpression(), !653)
    #dbg_value(double %sub1212, !605, !DIExpression(), !1278)
  %218 = tail call double @llvm.fmuladd.f64(double %sub1212, double 0.000000e+00, double %sub1215), !dbg !1303
    #dbg_assign(double %218, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1306, ptr %arrayidx45, !DIExpression(), !653)
  %mul1255 = fmul double %sub1215, 0.000000e+00, !dbg !1303
  %219 = fsub double %mul1255, %sub1212, !dbg !1303
    #dbg_assign(double %219, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1307, ptr %arrayidx48, !DIExpression(), !653)
    #dbg_value(double %sub1228, !605, !DIExpression(), !1278)
  %220 = fsub double %sub1231, %sub1228, !dbg !1303
  %mul1263 = fmul double %220, 0x3FE6A09E667F3BCD, !dbg !1303
    #dbg_assign(double %mul1263, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1308, ptr %arrayidx61, !DIExpression(), !653)
  %mul1267 = fneg double %sub1231, !dbg !1303
  %221 = fsub double %mul1267, %sub1228, !dbg !1303
  %mul1268 = fmul double %221, 0x3FE6A09E667F3BCD, !dbg !1303
    #dbg_assign(double %mul1268, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1309, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double 0.000000e+00, !618, !DIExpression(), !1310)
    #dbg_value(double -1.000000e+00, !620, !DIExpression(), !1310)
    #dbg_value(double %add1174, !622, !DIExpression(), !1311)
    #dbg_value(double %add1177, !624, !DIExpression(), !1311)
  %add1278 = fadd double %add1174, %add1206, !dbg !1312
    #dbg_assign(double %add1278, !439, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !1313, ptr %data_x, !DIExpression(), !653)
  %add1281 = fadd double %add1177, %add1209, !dbg !1312
    #dbg_assign(double %add1281, !441, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !1314, ptr %data_y, !DIExpression(), !653)
  %sub1284 = fsub double %add1174, %add1206, !dbg !1312
    #dbg_assign(double %sub1284, !439, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !1315, ptr %arrayidx42, !DIExpression(), !653)
  %sub1287 = fsub double %add1177, %add1209, !dbg !1312
    #dbg_assign(double %sub1287, !441, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !1316, ptr %arrayidx44, !DIExpression(), !653)
    #dbg_value(double %add1190, !625, !DIExpression(), !1317)
    #dbg_value(double %add1193, !627, !DIExpression(), !1317)
  %add1294 = fadd double %add1190, %add1222, !dbg !1318
    #dbg_assign(double %add1294, !439, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !1319, ptr %arrayidx26, !DIExpression(), !653)
  %add1297 = fadd double %add1193, %add1225, !dbg !1318
    #dbg_assign(double %add1297, !441, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !1320, ptr %arrayidx28, !DIExpression(), !653)
  %sub1300 = fsub double %add1190, %add1222, !dbg !1318
    #dbg_assign(double %sub1300, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1321, ptr %arrayidx58, !DIExpression(), !653)
  %sub1303 = fsub double %add1193, %add1225, !dbg !1318
    #dbg_assign(double %sub1303, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1322, ptr %arrayidx60, !DIExpression(), !653)
    #dbg_value(double %sub1300, !621, !DIExpression(), !1310)
  %222 = tail call double @llvm.fmuladd.f64(double %sub1300, double 0.000000e+00, double %sub1303), !dbg !1323
    #dbg_assign(double %222, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1324, ptr %arrayidx58, !DIExpression(), !653)
  %neg1315 = fmul double %sub1303, -0.000000e+00, !dbg !1323
  %223 = fsub double %neg1315, %sub1300, !dbg !1323
    #dbg_assign(double %223, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1325, ptr %arrayidx60, !DIExpression(), !653)
    #dbg_value(double %add1278, !628, !DIExpression(), !1326)
    #dbg_value(double %add1281, !630, !DIExpression(), !1326)
  %add1322 = fadd double %add1278, %add1294, !dbg !1327
  store double %add1322, ptr %data_x, align 8, !dbg !1327, !tbaa !360, !DIAssignID !1328
    #dbg_assign(double %add1322, !439, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !1328, ptr %data_x, !DIExpression(), !653)
  %add1325 = fadd double %add1281, %add1297, !dbg !1327
  store double %add1325, ptr %data_y, align 8, !dbg !1327, !tbaa !360, !DIAssignID !1329
    #dbg_assign(double %add1325, !441, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !1329, ptr %data_y, !DIExpression(), !653)
  %sub1328 = fsub double %add1278, %add1294, !dbg !1327
  %arrayidx26.reg2mem.0.arrayidx26.reload94 = load ptr, ptr %arrayidx26.reg2mem, align 8
  store double %sub1328, ptr %arrayidx26.reg2mem.0.arrayidx26.reload94, align 8, !dbg !1327, !tbaa !360, !DIAssignID !1330
    #dbg_assign(double %sub1328, !439, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !1330, ptr %arrayidx26, !DIExpression(), !653)
  %sub1331 = fsub double %add1281, %add1297, !dbg !1327
  %arrayidx28.reg2mem.0.arrayidx28.reload89 = load ptr, ptr %arrayidx28.reg2mem, align 8
  store double %sub1331, ptr %arrayidx28.reg2mem.0.arrayidx28.reload89, align 8, !dbg !1327, !tbaa !360, !DIAssignID !1331
    #dbg_assign(double %sub1331, !441, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !1331, ptr %arrayidx28, !DIExpression(), !653)
    #dbg_value(double %sub1284, !631, !DIExpression(), !1332)
    #dbg_value(double %sub1287, !633, !DIExpression(), !1332)
  %add1338 = fadd double %sub1284, %222, !dbg !1333
  %arrayidx42.reg2mem.0.arrayidx42.reload74 = load ptr, ptr %arrayidx42.reg2mem, align 8
  store double %add1338, ptr %arrayidx42.reg2mem.0.arrayidx42.reload74, align 8, !dbg !1333, !tbaa !360, !DIAssignID !1334
    #dbg_assign(double %add1338, !439, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !1334, ptr %arrayidx42, !DIExpression(), !653)
  %add1341 = fadd double %sub1287, %223, !dbg !1333
  %arrayidx44.reg2mem.0.arrayidx44.reload69 = load ptr, ptr %arrayidx44.reg2mem, align 8
  store double %add1341, ptr %arrayidx44.reg2mem.0.arrayidx44.reload69, align 8, !dbg !1333, !tbaa !360, !DIAssignID !1335
    #dbg_assign(double %add1341, !441, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !1335, ptr %arrayidx44, !DIExpression(), !653)
  %sub1344 = fsub double %sub1284, %222, !dbg !1333
  %arrayidx58.reg2mem.0.arrayidx58.reload54 = load ptr, ptr %arrayidx58.reg2mem, align 8
  store double %sub1344, ptr %arrayidx58.reg2mem.0.arrayidx58.reload54, align 8, !dbg !1333, !tbaa !360, !DIAssignID !1336
    #dbg_assign(double %sub1344, !439, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1336, ptr %arrayidx58, !DIExpression(), !653)
  %sub1347 = fsub double %sub1287, %223, !dbg !1333
  %arrayidx60.reg2mem.0.arrayidx60.reload49 = load ptr, ptr %arrayidx60.reg2mem, align 8
  store double %sub1347, ptr %arrayidx60.reg2mem.0.arrayidx60.reload49, align 8, !dbg !1333, !tbaa !360, !DIAssignID !1337
    #dbg_assign(double %sub1347, !441, !DIExpression(DW_OP_LLVM_fragment, 192, 64), !1337, ptr %arrayidx60, !DIExpression(), !653)
    #dbg_value(double 0.000000e+00, !634, !DIExpression(), !1338)
    #dbg_value(double -1.000000e+00, !636, !DIExpression(), !1338)
    #dbg_value(double %sub1180, !638, !DIExpression(), !1339)
    #dbg_value(double %sub1183, !640, !DIExpression(), !1339)
  %add1357 = fadd double %sub1180, %218, !dbg !1340
    #dbg_assign(double %add1357, !439, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !1341, ptr %arrayidx14, !DIExpression(), !653)
  %add1360 = fadd double %sub1183, %219, !dbg !1340
    #dbg_assign(double %add1360, !441, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !1342, ptr %arrayidx17, !DIExpression(), !653)
  %sub1363 = fsub double %sub1180, %218, !dbg !1340
    #dbg_assign(double %sub1363, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1343, ptr %arrayidx45, !DIExpression(), !653)
  %sub1366 = fsub double %sub1183, %219, !dbg !1340
    #dbg_assign(double %sub1366, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1344, ptr %arrayidx48, !DIExpression(), !653)
    #dbg_value(double %mul1239, !641, !DIExpression(), !1345)
    #dbg_value(double %mul1244, !643, !DIExpression(), !1345)
  %add1373 = fadd double %mul1239, %mul1263, !dbg !1346
    #dbg_assign(double %add1373, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1347, ptr %arrayidx29, !DIExpression(), !653)
  %add1376 = fadd double %mul1244, %mul1268, !dbg !1346
    #dbg_assign(double %add1376, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1348, ptr %arrayidx32, !DIExpression(), !653)
  %sub1379 = fsub double %mul1239, %mul1263, !dbg !1346
    #dbg_assign(double %sub1379, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1349, ptr %arrayidx61, !DIExpression(), !653)
  %sub1382 = fsub double %mul1244, %mul1268, !dbg !1346
    #dbg_assign(double %sub1382, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1350, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double %sub1379, !637, !DIExpression(), !1338)
  %224 = tail call double @llvm.fmuladd.f64(double %sub1379, double 0.000000e+00, double %sub1382), !dbg !1351
    #dbg_assign(double %224, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1352, ptr %arrayidx61, !DIExpression(), !653)
  %neg1394 = fmul double %sub1382, -0.000000e+00, !dbg !1351
  %225 = fsub double %neg1394, %sub1379, !dbg !1351
    #dbg_assign(double %225, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1353, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(double %add1357, !644, !DIExpression(), !1354)
    #dbg_value(double %add1360, !646, !DIExpression(), !1354)
  %add1401 = fadd double %add1357, %add1373, !dbg !1355
  %arrayidx14.reg2mem.0.arrayidx14.reload104 = load ptr, ptr %arrayidx14.reg2mem, align 8
  store double %add1401, ptr %arrayidx14.reg2mem.0.arrayidx14.reload104, align 8, !dbg !1355, !tbaa !360, !DIAssignID !1356
    #dbg_assign(double %add1401, !439, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !1356, ptr %arrayidx14, !DIExpression(), !653)
  %add1404 = fadd double %add1360, %add1376, !dbg !1355
  %arrayidx17.reg2mem.0.arrayidx17.reload99 = load ptr, ptr %arrayidx17.reg2mem, align 8
  store double %add1404, ptr %arrayidx17.reg2mem.0.arrayidx17.reload99, align 8, !dbg !1355, !tbaa !360, !DIAssignID !1357
    #dbg_assign(double %add1404, !441, !DIExpression(DW_OP_LLVM_fragment, 256, 64), !1357, ptr %arrayidx17, !DIExpression(), !653)
  %sub1407 = fsub double %add1357, %add1373, !dbg !1355
  %arrayidx29.reg2mem.0.arrayidx29.reload84 = load ptr, ptr %arrayidx29.reg2mem, align 8
  store double %sub1407, ptr %arrayidx29.reg2mem.0.arrayidx29.reload84, align 8, !dbg !1355, !tbaa !360, !DIAssignID !1358
    #dbg_assign(double %sub1407, !439, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1358, ptr %arrayidx29, !DIExpression(), !653)
  %sub1410 = fsub double %add1360, %add1376, !dbg !1355
  %arrayidx32.reg2mem.0.arrayidx32.reload79 = load ptr, ptr %arrayidx32.reg2mem, align 8
  store double %sub1410, ptr %arrayidx32.reg2mem.0.arrayidx32.reload79, align 8, !dbg !1355, !tbaa !360, !DIAssignID !1359
    #dbg_assign(double %sub1410, !441, !DIExpression(DW_OP_LLVM_fragment, 320, 64), !1359, ptr %arrayidx32, !DIExpression(), !653)
    #dbg_value(double %sub1363, !647, !DIExpression(), !1360)
    #dbg_value(double %sub1366, !649, !DIExpression(), !1360)
  %add1417 = fadd double %sub1363, %224, !dbg !1361
  %arrayidx45.reg2mem.0.arrayidx45.reload64 = load ptr, ptr %arrayidx45.reg2mem, align 8
  store double %add1417, ptr %arrayidx45.reg2mem.0.arrayidx45.reload64, align 8, !dbg !1361, !tbaa !360, !DIAssignID !1362
    #dbg_assign(double %add1417, !439, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1362, ptr %arrayidx45, !DIExpression(), !653)
  %add1420 = fadd double %sub1366, %225, !dbg !1361
  %arrayidx48.reg2mem.0.arrayidx48.reload59 = load ptr, ptr %arrayidx48.reg2mem, align 8
  store double %add1420, ptr %arrayidx48.reg2mem.0.arrayidx48.reload59, align 8, !dbg !1361, !tbaa !360, !DIAssignID !1363
    #dbg_assign(double %add1420, !441, !DIExpression(DW_OP_LLVM_fragment, 384, 64), !1363, ptr %arrayidx48, !DIExpression(), !653)
  %sub1423 = fsub double %sub1363, %224, !dbg !1361
  %arrayidx61.reg2mem.0.arrayidx61.reload44 = load ptr, ptr %arrayidx61.reg2mem, align 8
  store double %sub1423, ptr %arrayidx61.reg2mem.0.arrayidx61.reload44, align 8, !dbg !1361, !tbaa !360, !DIAssignID !1364
    #dbg_assign(double %sub1423, !439, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1364, ptr %arrayidx61, !DIExpression(), !653)
  %sub1426 = fsub double %sub1366, %225, !dbg !1361
  %arrayidx64.reg2mem.0.arrayidx64.reload39 = load ptr, ptr %arrayidx64.reg2mem, align 8
  store double %sub1426, ptr %arrayidx64.reg2mem.0.arrayidx64.reload39, align 8, !dbg !1361, !tbaa !360, !DIAssignID !1365
    #dbg_assign(double %sub1426, !441, !DIExpression(DW_OP_LLVM_fragment, 448, 64), !1365, ptr %arrayidx64, !DIExpression(), !653)
    #dbg_value(i64 0, !650, !DIExpression(), !1366)
  store i64 0, ptr %i1428.01874.reg2mem, align 8
  br label %for.body1433, !dbg !1367

for.cond.cleanup1432:                             ; preds = %for.body1433
  %indvar.next1988 = add nuw nsw i64 %indvar1987.reg2mem106.0.load, 1, !dbg !1368
    #dbg_value(i64 %indvar.next1988, !432, !DIExpression(), !653)
  %exitcond1992.not = icmp eq i64 %indvar.next1988, 64, !dbg !1369
  br i1 %exitcond1992.not, label %for.end1455, label %for.cond.cleanup1432.for.cond1144.preheader_crit_edge, !dbg !1370, !llvm.loop !1371

for.cond.cleanup1432.for.cond1144.preheader_crit_edge: ; preds = %for.cond.cleanup1432
  store i64 %indvar.next1988, ptr %indvar1987.reg2mem106, align 8
  br label %for.cond1144.preheader, !dbg !1370

for.body1433:                                     ; preds = %for.body1433.for.body1433_crit_edge, %for.cond1144.preheader
    #dbg_value(i64 %i1428.01874.reg2mem.0.load, !650, !DIExpression(), !1366)
  %i1428.01874.reg2mem.0.load = load i64, ptr %i1428.01874.reg2mem, align 8
  %arrayidx1434 = getelementptr inbounds [8 x i32], ptr @__const.fft.reversed, i64 0, i64 %i1428.01874.reg2mem.0.load, !dbg !1373
  %226 = load i32, ptr %arrayidx1434, align 4, !dbg !1373, !tbaa !350
  %idxprom1435 = sext i32 %226 to i64, !dbg !1376
  %arrayidx1436 = getelementptr inbounds [8 x double], ptr %data_x, i64 0, i64 %idxprom1435, !dbg !1376
  %227 = load double, ptr %arrayidx1436, align 8, !dbg !1376, !tbaa !360
  %mul1438 = shl nuw nsw i64 %i1428.01874.reg2mem.0.load, 6, !dbg !1377
  %add1440 = add nuw nsw i64 %mul1438, %indvar1987.reg2mem106.0.load, !dbg !1378
  %arrayidx1441 = getelementptr inbounds double, ptr %work_x, i64 %add1440, !dbg !1379
  store double %227, ptr %arrayidx1441, align 8, !dbg !1380, !tbaa !360
  %arrayidx1444 = getelementptr inbounds [8 x double], ptr %data_y, i64 0, i64 %idxprom1435, !dbg !1381
  %228 = load double, ptr %arrayidx1444, align 8, !dbg !1381, !tbaa !360
  %arrayidx1449 = getelementptr inbounds double, ptr %work_y, i64 %add1440, !dbg !1382
  store double %228, ptr %arrayidx1449, align 8, !dbg !1383, !tbaa !360
  %inc1451 = add nuw nsw i64 %i1428.01874.reg2mem.0.load, 1, !dbg !1384
    #dbg_value(i64 %inc1451, !650, !DIExpression(), !1366)
  %exitcond1991.not = icmp eq i64 %inc1451, 8, !dbg !1385
  br i1 %exitcond1991.not, label %for.cond.cleanup1432, label %for.body1433.for.body1433_crit_edge, !dbg !1367, !llvm.loop !1386

for.body1433.for.body1433_crit_edge:              ; preds = %for.body1433
  store i64 %inc1451, ptr %i1428.01874.reg2mem, align 8
  br label %for.body1433, !dbg !1367

for.end1455:                                      ; preds = %for.cond.cleanup1432
  call void @llvm.lifetime.end.p0(i64 4608, ptr nonnull %smem) #19, !dbg !1388
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %data_y) #19, !dbg !1388
  call void @llvm.lifetime.end.p0(i64 64, ptr nonnull %data_x) #19, !dbg !1388
  call void @llvm.lifetime.end.p0(i64 4096, ptr nonnull %DATA_y) #19, !dbg !1388
  call void @llvm.lifetime.end.p0(i64 4096, ptr nonnull %DATA_x) #19, !dbg !1388
  ret void, !dbg !1388
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #4

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #4

; Function Attrs: nofree nounwind memory(write, argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #0 !dbg !1389 {
entry.split:
    #dbg_value(ptr %vargs, !1393, !DIExpression(), !1395)
    #dbg_value(ptr %vargs, !1394, !DIExpression(), !1395)
  %work_y = getelementptr inbounds i8, ptr %vargs, i64 4096, !dbg !1396
  tail call void @fft(ptr noundef %vargs, ptr noundef nonnull %work_y) #19, !dbg !1397
  ret void, !dbg !1398
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #6 !dbg !1399 {
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
    #dbg_value(i32 %fd, !1403, !DIExpression(), !1408)
    #dbg_value(ptr %vdata, !1404, !DIExpression(), !1408)
    #dbg_value(ptr %vdata, !1405, !DIExpression(), !1408)
  %call = tail call ptr @readfile(i32 noundef signext %fd) #19, !dbg !1409
    #dbg_value(ptr %call, !1406, !DIExpression(), !1408)
    #dbg_value(ptr %call, !1410, !DIExpression(), !1417)
    #dbg_value(i32 1, !1415, !DIExpression(), !1417)
    #dbg_value(i32 0, !1416, !DIExpression(), !1417)
  store ptr %call, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 0, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem72.0.load, !1416, !DIExpression(), !1417)
    #dbg_value(ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, !1410, !DIExpression(), !1417)
  %i.041.i.reg2mem72.0.load = load i32, ptr %i.041.i.reg2mem72, align 4
  %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71 = load ptr, ptr %s.addr.040.i.reg2mem70, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, align 1, !dbg !1419, !tbaa !1420
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !1421

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !1421

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !1421

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !1422
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !1422, !tbaa !1420
  %cmp13.i = icmp eq i8 %1, 37, !dbg !1425
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !1426

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !1426

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 2, !dbg !1427
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !1427, !tbaa !1420
  %cmp18.i = icmp eq i8 %2, 10, !dbg !1428
  %inc.i = zext i1 %cmp18.i to i32, !dbg !1429
  %spec.select.i = add nsw i32 %i.041.i.reg2mem72.0.load, %inc.i, !dbg !1429
  store i32 %spec.select.i, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !1429

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem68.0.load, !1416, !DIExpression(), !1417)
  %i.1.i.reg2mem68.0.load = load i32, ptr %i.1.i.reg2mem68, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !1430
    #dbg_value(ptr %incdec.ptr.i, !1410, !DIExpression(), !1417)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem68.0.load, 1, !dbg !1431
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !1432, !llvm.loop !1433

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 %i.1.i.reg2mem68.0.load, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i, !dbg !1432

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !1435, !tbaa !1420
  %3 = icmp eq i8 %.pre.i, 0, !dbg !1437
  %4 = select i1 %3, i64 0, i64 2, !dbg !1438
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !1432

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !1438
    #dbg_value(ptr %spec.select38.i, !1407, !DIExpression(), !1408)
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 512) #19, !dbg !1439
    #dbg_value(ptr %call, !1410, !DIExpression(), !1440)
    #dbg_value(i32 2, !1415, !DIExpression(), !1440)
    #dbg_value(i32 0, !1416, !DIExpression(), !1440)
  store ptr %call, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 0, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem66.0.load, !1416, !DIExpression(), !1440)
    #dbg_value(ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, !1410, !DIExpression(), !1440)
  %i.041.i2.reg2mem66.0.load = load i32, ptr %i.041.i2.reg2mem66, align 4
  %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65 = load ptr, ptr %s.addr.040.i3.reg2mem64, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, align 1, !dbg !1442, !tbaa !1420
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !1443

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !1443

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !1443

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !1444
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !1444, !tbaa !1420
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !1445
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !1446

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !1446

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 2, !dbg !1447
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !1447, !tbaa !1420
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !1448
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !1449
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem66.0.load, %inc.i19, !dbg !1449
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !1449

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem62.0.load, !1416, !DIExpression(), !1440)
  %i.1.i8.reg2mem62.0.load = load i32, ptr %i.1.i8.reg2mem62, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !1450
    #dbg_value(ptr %incdec.ptr.i9, !1410, !DIExpression(), !1440)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem62.0.load, 2, !dbg !1451
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !1452, !llvm.loop !1453

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 %i.1.i8.reg2mem62.0.load, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1, !dbg !1452

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !1455, !tbaa !1420
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !1456
  %9 = select i1 %8, i64 0, i64 2, !dbg !1457
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !1452

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !1457
    #dbg_value(ptr %spec.select38.i15, !1407, !DIExpression(), !1408)
  %work_y = getelementptr inbounds i8, ptr %vdata, i64 4096, !dbg !1458
  %call5 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %work_y, i32 noundef signext 512) #19, !dbg !1459
  tail call void @free(ptr noundef %call) #19, !dbg !1460
  ret void, !dbg !1461
}

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !1462 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #7

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #6 !dbg !1464 {
entry.split:
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1466, !DIExpression(), !1469)
    #dbg_value(ptr %vdata, !1467, !DIExpression(), !1469)
    #dbg_value(ptr %vdata, !1468, !DIExpression(), !1469)
    #dbg_value(i32 %fd, !1470, !DIExpression(), !1475)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !1477
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !1477

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !1477
  unreachable, !dbg !1477

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1480
    #dbg_value(i32 %fd, !1481, !DIExpression(), !1489)
    #dbg_value(ptr %vdata, !1486, !DIExpression(), !1489)
    #dbg_value(i32 512, !1487, !DIExpression(), !1489)
    #dbg_value(i32 0, !1488, !DIExpression(), !1489)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1491

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !1488, !DIExpression(), !1489)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1493
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !1493, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1493
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1496
    #dbg_value(i64 %indvars.iv.next.i, !1488, !DIExpression(), !1489)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 512, !dbg !1496
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !1491, !llvm.loop !1497

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1491

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !1470, !DIExpression(), !1498)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1500
  %work_y = getelementptr inbounds i8, ptr %vdata, i64 4096, !dbg !1501
    #dbg_value(i32 %fd, !1481, !DIExpression(), !1502)
    #dbg_value(ptr %work_y, !1486, !DIExpression(), !1502)
    #dbg_value(i32 512, !1487, !DIExpression(), !1502)
    #dbg_value(i32 0, !1488, !DIExpression(), !1502)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !1504

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !1488, !DIExpression(), !1502)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds double, ptr %work_y, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !1505
  %1 = load double, ptr %arrayidx.i11, align 8, !dbg !1505, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %1), !dbg !1505
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !1506
    #dbg_value(i64 %indvars.iv.next.i12, !1488, !DIExpression(), !1502)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 512, !dbg !1506
  br i1 %exitcond.not.i13, label %write_double_array.exit14, label %for.body.i9.for.body.i9_crit_edge, !dbg !1504, !llvm.loop !1507

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !1504

write_double_array.exit14:                        ; preds = %for.body.i9
  ret void, !dbg !1508
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #6 !dbg !1509 {
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
    #dbg_value(i32 %fd, !1511, !DIExpression(), !1516)
    #dbg_value(ptr %vdata, !1512, !DIExpression(), !1516)
    #dbg_value(ptr %vdata, !1513, !DIExpression(), !1516)
  %call = tail call ptr @readfile(i32 noundef signext %fd) #19, !dbg !1517
    #dbg_value(ptr %call, !1514, !DIExpression(), !1516)
    #dbg_value(ptr %call, !1410, !DIExpression(), !1518)
    #dbg_value(i32 1, !1415, !DIExpression(), !1518)
    #dbg_value(i32 0, !1416, !DIExpression(), !1518)
  store ptr %call, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 0, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem72.0.load, !1416, !DIExpression(), !1518)
    #dbg_value(ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, !1410, !DIExpression(), !1518)
  %i.041.i.reg2mem72.0.load = load i32, ptr %i.041.i.reg2mem72, align 4
  %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71 = load ptr, ptr %s.addr.040.i.reg2mem70, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, align 1, !dbg !1520, !tbaa !1420
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !1521

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !1521

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !1521

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !1522
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !1522, !tbaa !1420
  %cmp13.i = icmp eq i8 %1, 37, !dbg !1523
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !1524

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !1524

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 2, !dbg !1525
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !1525, !tbaa !1420
  %cmp18.i = icmp eq i8 %2, 10, !dbg !1526
  %inc.i = zext i1 %cmp18.i to i32, !dbg !1527
  %spec.select.i = add nsw i32 %i.041.i.reg2mem72.0.load, %inc.i, !dbg !1527
  store i32 %spec.select.i, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !1527

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem68.0.load, !1416, !DIExpression(), !1518)
  %i.1.i.reg2mem68.0.load = load i32, ptr %i.1.i.reg2mem68, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !1528
    #dbg_value(ptr %incdec.ptr.i, !1410, !DIExpression(), !1518)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem68.0.load, 1, !dbg !1529
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !1530, !llvm.loop !1531

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 %i.1.i.reg2mem68.0.load, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i, !dbg !1530

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !1533, !tbaa !1420
  %3 = icmp eq i8 %.pre.i, 0, !dbg !1534
  %4 = select i1 %3, i64 0, i64 2, !dbg !1535
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !1530

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !1535
    #dbg_value(ptr %spec.select38.i, !1515, !DIExpression(), !1516)
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 512) #19, !dbg !1536
    #dbg_value(ptr %call, !1410, !DIExpression(), !1537)
    #dbg_value(i32 2, !1415, !DIExpression(), !1537)
    #dbg_value(i32 0, !1416, !DIExpression(), !1537)
  store ptr %call, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 0, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem66.0.load, !1416, !DIExpression(), !1537)
    #dbg_value(ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, !1410, !DIExpression(), !1537)
  %i.041.i2.reg2mem66.0.load = load i32, ptr %i.041.i2.reg2mem66, align 4
  %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65 = load ptr, ptr %s.addr.040.i3.reg2mem64, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, align 1, !dbg !1539, !tbaa !1420
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !1540

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !1540

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !1540

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !1541
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !1541, !tbaa !1420
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !1542
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !1543

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !1543

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 2, !dbg !1544
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !1544, !tbaa !1420
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !1545
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !1546
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem66.0.load, %inc.i19, !dbg !1546
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !1546

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem62.0.load, !1416, !DIExpression(), !1537)
  %i.1.i8.reg2mem62.0.load = load i32, ptr %i.1.i8.reg2mem62, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !1547
    #dbg_value(ptr %incdec.ptr.i9, !1410, !DIExpression(), !1537)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem62.0.load, 2, !dbg !1548
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !1549, !llvm.loop !1550

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 %i.1.i8.reg2mem62.0.load, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1, !dbg !1549

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !1552, !tbaa !1420
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !1553
  %9 = select i1 %8, i64 0, i64 2, !dbg !1554
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !1549

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !1554
    #dbg_value(ptr %spec.select38.i15, !1515, !DIExpression(), !1516)
  %work_y = getelementptr inbounds i8, ptr %vdata, i64 4096, !dbg !1555
  %call5 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %work_y, i32 noundef signext 512) #19, !dbg !1556
  tail call void @free(ptr noundef %call) #19, !dbg !1557
  ret void, !dbg !1558
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #6 !dbg !1559 {
entry.split:
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1561, !DIExpression(), !1564)
    #dbg_value(ptr %vdata, !1562, !DIExpression(), !1564)
    #dbg_value(ptr %vdata, !1563, !DIExpression(), !1564)
    #dbg_value(i32 %fd, !1470, !DIExpression(), !1565)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !1567
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !1567

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !1567
  unreachable, !dbg !1567

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1568
    #dbg_value(i32 %fd, !1481, !DIExpression(), !1569)
    #dbg_value(ptr %vdata, !1486, !DIExpression(), !1569)
    #dbg_value(i32 512, !1487, !DIExpression(), !1569)
    #dbg_value(i32 0, !1488, !DIExpression(), !1569)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1571

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !1488, !DIExpression(), !1569)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1572
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !1572, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1572
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1573
    #dbg_value(i64 %indvars.iv.next.i, !1488, !DIExpression(), !1569)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 512, !dbg !1573
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !1571, !llvm.loop !1574

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1571

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !1470, !DIExpression(), !1575)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1577
  %work_y = getelementptr inbounds i8, ptr %vdata, i64 4096, !dbg !1578
    #dbg_value(i32 %fd, !1481, !DIExpression(), !1579)
    #dbg_value(ptr %work_y, !1486, !DIExpression(), !1579)
    #dbg_value(i32 512, !1487, !DIExpression(), !1579)
    #dbg_value(i32 0, !1488, !DIExpression(), !1579)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !1581

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !1488, !DIExpression(), !1579)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds double, ptr %work_y, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !1582
  %1 = load double, ptr %arrayidx.i11, align 8, !dbg !1582, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %1), !dbg !1582
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !1583
    #dbg_value(i64 %indvars.iv.next.i12, !1488, !DIExpression(), !1579)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 512, !dbg !1583
  br i1 %exitcond.not.i13, label %write_double_array.exit14, label %for.body.i9.for.body.i9_crit_edge, !dbg !1581, !llvm.loop !1584

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !1581

write_double_array.exit14:                        ; preds = %for.body.i9
  ret void, !dbg !1585
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #8 !dbg !1586 {
entry.split:
  %has_errors.030.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(ptr %vdata, !1590, !DIExpression(), !1598)
    #dbg_value(ptr %vref, !1591, !DIExpression(), !1598)
    #dbg_value(ptr %vdata, !1592, !DIExpression(), !1598)
    #dbg_value(ptr %vref, !1593, !DIExpression(), !1598)
    #dbg_value(i32 0, !1594, !DIExpression(), !1598)
    #dbg_value(i32 0, !1595, !DIExpression(), !1598)
  store i32 0, ptr %has_errors.030.reg2mem, align 4
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1599

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i32 %has_errors.030.reg2mem.0.load, !1594, !DIExpression(), !1598)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1595, !DIExpression(), !1598)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %has_errors.030.reg2mem.0.load = load i32, ptr %has_errors.030.reg2mem, align 4
  %arrayidx = getelementptr inbounds [512 x double], ptr %vdata, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !1601
  %0 = load double, ptr %arrayidx, align 8, !dbg !1601, !tbaa !360
  %arrayidx3 = getelementptr inbounds [512 x double], ptr %vref, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !1604
  %1 = load double, ptr %arrayidx3, align 8, !dbg !1604, !tbaa !360
  %sub = fsub double %0, %1, !dbg !1605
    #dbg_value(double %sub, !1596, !DIExpression(), !1598)
  %arrayidx5 = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 1, i64 %indvars.iv.reg2mem.0.load, !dbg !1606
  %2 = load double, ptr %arrayidx5, align 8, !dbg !1606, !tbaa !360
  %arrayidx8 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 1, i64 %indvars.iv.reg2mem.0.load, !dbg !1607
  %3 = load double, ptr %arrayidx8, align 8, !dbg !1607, !tbaa !360
  %sub9 = fsub double %2, %3, !dbg !1608
    #dbg_value(double %sub9, !1597, !DIExpression(), !1598)
  %4 = tail call double @llvm.fabs.f64(double %sub), !dbg !1609
  %5 = fcmp ogt double %4, 0x3EB0C6F7A0B5ED8D, !dbg !1609
    #dbg_value(!DIArgList(i32 %has_errors.030.reg2mem.0.load, i1 %5), !1594, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !1598)
  %6 = tail call double @llvm.fabs.f64(double %sub9), !dbg !1610
  %7 = fcmp ogt double %6, 0x3EB0C6F7A0B5ED8D, !dbg !1610
  %8 = or i1 %5, %7, !dbg !1611
  %9 = zext i1 %8 to i32, !dbg !1611
  %or17 = or i32 %has_errors.030.reg2mem.0.load, %9, !dbg !1611
    #dbg_value(i32 %or17, !1594, !DIExpression(), !1598)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1612
    #dbg_value(i64 %indvars.iv.next, !1595, !DIExpression(), !1598)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 512, !dbg !1613
  br i1 %exitcond.not, label %for.end, label %for.body.for.body_crit_edge, !dbg !1599, !llvm.loop !1614

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i32 %or17, ptr %has_errors.030.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1599

for.end:                                          ; preds = %for.body
  %tobool.not = icmp eq i32 %or17, 0, !dbg !1616
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !1616
  ret i32 %lnot.ext, !dbg !1617
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #6 !dbg !1618 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !1668
    #dbg_assign(i1 undef, !1624, !DIExpression(), !1668, ptr %s, !DIExpression(), !1669)
    #dbg_value(i32 %fd, !1622, !DIExpression(), !1669)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #19, !dbg !1670
  %cmp = icmp sgt i32 %fd, 1, !dbg !1671
  br i1 %cmp, label %if.end, label %if.else, !dbg !1671

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !1671
  unreachable, !dbg !1671

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #19, !dbg !1674
  %cmp1 = icmp eq i32 %call, 0, !dbg !1674
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !1674

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !1674
  unreachable, !dbg !1674

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !1677
  %0 = load i64, ptr %st_size, align 8, !dbg !1677
    #dbg_value(i64 %0, !1661, !DIExpression(), !1669)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !1678
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !1678

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !1678
  unreachable, !dbg !1678

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !1681
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #21, !dbg !1682
    #dbg_value(ptr %call11, !1623, !DIExpression(), !1669)
    #dbg_value(i64 0, !1664, !DIExpression(), !1669)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !1683

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !1684
    #dbg_value(i64 %add19, !1664, !DIExpression(), !1669)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !1686
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !1683, !llvm.loop !1687

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !1683

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !1664, !DIExpression(), !1669)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !1689
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !1690
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #19, !dbg !1691
    #dbg_value(i64 %call13, !1667, !DIExpression(), !1669)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !1692
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !1664, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1669)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !1692

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !1692
  unreachable, !dbg !1692

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !1695
  store i8 0, ptr %arrayidx20, align 1, !dbg !1696, !tbaa !1420
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #19, !dbg !1697
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #19, !dbg !1698
  ret ptr %call11, !dbg !1699
}

; Function Attrs: noreturn nounwind
declare !dbg !1700 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare !dbg !1705 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #10

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !1710 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #11

; Function Attrs: nofree
declare !dbg !1713 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #12

declare !dbg !1717 signext i32 @close(i32 noundef signext) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #6 !dbg !1411 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !1410, !DIExpression(), !1718)
    #dbg_value(i32 %n, !1415, !DIExpression(), !1718)
    #dbg_value(i32 0, !1416, !DIExpression(), !1718)
  %cmp = icmp sgt i32 %n, -1, !dbg !1719
  br i1 %cmp, label %if.end, label %if.else, !dbg !1719

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #20, !dbg !1719
  unreachable, !dbg !1719

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !1722
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !1724

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !1724

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !1724

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !1416, !DIExpression(), !1718)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !1410, !DIExpression(), !1718)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !1725, !tbaa !1420
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !1726

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !1726

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !1726

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !1727
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !1727, !tbaa !1420
  %cmp13 = icmp eq i8 %1, 37, !dbg !1728
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !1729

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !1729

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !1730
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !1730, !tbaa !1420
  %cmp18 = icmp eq i8 %2, 10, !dbg !1731
  %inc = zext i1 %cmp18 to i32, !dbg !1732
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !1732
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !1732

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !1416, !DIExpression(), !1718)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !1733
    #dbg_value(ptr %incdec.ptr, !1410, !DIExpression(), !1718)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !1734
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !1735, !llvm.loop !1736

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !1735

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !1738, !tbaa !1420
  %3 = icmp eq i8 %.pre, 0, !dbg !1739
  %4 = select i1 %3, i64 0, i64 2, !dbg !1740
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !1735

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !1740
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !1740

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !1741
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !1742 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !1746, !DIExpression(), !1750)
    #dbg_value(ptr %arr, !1747, !DIExpression(), !1750)
    #dbg_value(i32 %n, !1748, !DIExpression(), !1750)
  %cmp.not = icmp eq ptr %s, null, !dbg !1751
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1751

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #20, !dbg !1751
  unreachable, !dbg !1751

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1754
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !1756

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !1757
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !1759
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !1759

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !1749, !DIExpression(), !1750)
  %conv404 = zext nneg i32 %n to i64, !dbg !1760
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !1761
  br label %if.end46, !dbg !1762

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !1749, !DIExpression(), !1750)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !1763
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !1764

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !1764

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !1765
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !1766
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !1766
  %cmp9.not = icmp eq i8 %0, 0, !dbg !1767
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !1768

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !1768

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !1769
  %1 = load i8, ptr %gep, align 1, !dbg !1769
  %cmp16.not = icmp eq i8 %1, 0, !dbg !1770
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !1771

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !1771

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !1772
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !1773
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !1773
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !1773, !llvm.loop !1774

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !1773

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !1760

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !1760

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !1760

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !1760
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !1749, !DIExpression(), !1750)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !1761
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !1776
  store i8 0, ptr %arrayidx45, align 1, !dbg !1778, !tbaa !1420
  br label %if.end46, !dbg !1776

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !1779
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !1780 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1792
    #dbg_assign(i1 undef, !1789, !DIExpression(), !1792, ptr %endptr, !DIExpression(), !1793)
    #dbg_value(ptr %s, !1785, !DIExpression(), !1793)
    #dbg_value(ptr %arr, !1786, !DIExpression(), !1793)
    #dbg_value(i32 %n, !1787, !DIExpression(), !1793)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1794
    #dbg_value(i32 0, !1790, !DIExpression(), !1793)
  %cmp.not = icmp eq ptr %s, null, !dbg !1795
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1795

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #20, !dbg !1795
  unreachable, !dbg !1795

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1794
    #dbg_value(ptr %call, !1788, !DIExpression(), !1793)
    #dbg_value(i32 0, !1790, !DIExpression(), !1793)
  %cmp130 = icmp ne ptr %call, null, !dbg !1794
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1794
  %0 = and i1 %cmp231, %cmp130, !dbg !1794
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1794

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1794

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1794
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1794

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1788, !DIExpression(), !1793)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1790, !DIExpression(), !1793)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1798, !tbaa !1800, !DIAssignID !1802
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1789, !DIExpression(), !1802, ptr %endptr, !DIExpression(), !1793)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1798
  %conv = trunc i64 %call3 to i8, !dbg !1798
    #dbg_value(i8 %conv, !1791, !DIExpression(), !1793)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1803, !tbaa !1800
  %3 = load i8, ptr %2, align 1, !dbg !1803, !tbaa !1420
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1803
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1798

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1798

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1805, !tbaa !1800
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1805
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !1805
  br label %if.end9, !dbg !1805

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1798
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1798, !tbaa !1420
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1798
    #dbg_value(i64 %indvars.iv.next, !1790, !DIExpression(), !1793)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !1798
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1798
  store i8 10, ptr %arrayidx11, align 1, !dbg !1798, !tbaa !1420
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1798
    #dbg_value(ptr %call12, !1788, !DIExpression(), !1793)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1794
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1794
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1794
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1794, !llvm.loop !1807

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1794

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1794

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1794

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1794

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !1808
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1808
  store i8 10, ptr %arrayidx17, align 1, !dbg !1808, !tbaa !1420
  br label %if.end18, !dbg !1808

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1794
  ret i32 0, !dbg !1794
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1811 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #14

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1817 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #14

; Function Attrs: nofree nounwind
declare !dbg !1822 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #10

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !1877 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !1880 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1892
    #dbg_assign(i1 undef, !1889, !DIExpression(), !1892, ptr %endptr, !DIExpression(), !1893)
    #dbg_value(ptr %s, !1885, !DIExpression(), !1893)
    #dbg_value(ptr %arr, !1886, !DIExpression(), !1893)
    #dbg_value(i32 %n, !1887, !DIExpression(), !1893)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1894
    #dbg_value(i32 0, !1890, !DIExpression(), !1893)
  %cmp.not = icmp eq ptr %s, null, !dbg !1895
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1895

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #20, !dbg !1895
  unreachable, !dbg !1895

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1894
    #dbg_value(ptr %call, !1888, !DIExpression(), !1893)
    #dbg_value(i32 0, !1890, !DIExpression(), !1893)
  %cmp130 = icmp ne ptr %call, null, !dbg !1894
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1894
  %0 = and i1 %cmp231, %cmp130, !dbg !1894
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1894

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1894

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1894
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1894

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1888, !DIExpression(), !1893)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1890, !DIExpression(), !1893)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1898, !tbaa !1800, !DIAssignID !1900
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1889, !DIExpression(), !1900, ptr %endptr, !DIExpression(), !1893)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1898
  %conv = trunc i64 %call3 to i16, !dbg !1898
    #dbg_value(i16 %conv, !1891, !DIExpression(), !1893)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1901, !tbaa !1800
  %3 = load i8, ptr %2, align 1, !dbg !1901, !tbaa !1420
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1901
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1898

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1898

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1903, !tbaa !1800
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1903
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !1903
  br label %if.end9, !dbg !1903

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1898
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1898, !tbaa !1905
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1898
    #dbg_value(i64 %indvars.iv.next, !1890, !DIExpression(), !1893)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !1898
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1898
  store i8 10, ptr %arrayidx11, align 1, !dbg !1898, !tbaa !1420
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1898
    #dbg_value(ptr %call12, !1888, !DIExpression(), !1893)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1894
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1894
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1894
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1894, !llvm.loop !1907

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1894

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1894

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1894

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1894

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !1908
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1908
  store i8 10, ptr %arrayidx17, align 1, !dbg !1908, !tbaa !1420
  br label %if.end18, !dbg !1908

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1894
  ret i32 0, !dbg !1894
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !1911 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1923
    #dbg_assign(i1 undef, !1920, !DIExpression(), !1923, ptr %endptr, !DIExpression(), !1924)
    #dbg_value(ptr %s, !1916, !DIExpression(), !1924)
    #dbg_value(ptr %arr, !1917, !DIExpression(), !1924)
    #dbg_value(i32 %n, !1918, !DIExpression(), !1924)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1925
    #dbg_value(i32 0, !1921, !DIExpression(), !1924)
  %cmp.not = icmp eq ptr %s, null, !dbg !1926
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1926

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #20, !dbg !1926
  unreachable, !dbg !1926

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1925
    #dbg_value(ptr %call, !1919, !DIExpression(), !1924)
    #dbg_value(i32 0, !1921, !DIExpression(), !1924)
  %cmp130 = icmp ne ptr %call, null, !dbg !1925
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1925
  %0 = and i1 %cmp231, %cmp130, !dbg !1925
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1925

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1925

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1925
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1925

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1919, !DIExpression(), !1924)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1921, !DIExpression(), !1924)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1929, !tbaa !1800, !DIAssignID !1931
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1920, !DIExpression(), !1931, ptr %endptr, !DIExpression(), !1924)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1929
  %conv = trunc i64 %call3 to i32, !dbg !1929
    #dbg_value(i32 %conv, !1922, !DIExpression(), !1924)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1932, !tbaa !1800
  %3 = load i8, ptr %2, align 1, !dbg !1932, !tbaa !1420
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1932
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1929

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1929

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1934, !tbaa !1800
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1934
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !1934
  br label %if.end9, !dbg !1934

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1929
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1929, !tbaa !350
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1929
    #dbg_value(i64 %indvars.iv.next, !1921, !DIExpression(), !1924)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !1929
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1929
  store i8 10, ptr %arrayidx11, align 1, !dbg !1929, !tbaa !1420
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1929
    #dbg_value(ptr %call12, !1919, !DIExpression(), !1924)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1925
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1925
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1925
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1925, !llvm.loop !1936

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1925

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1925

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1925

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1925

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !1937
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1937
  store i8 10, ptr %arrayidx17, align 1, !dbg !1937, !tbaa !1420
  br label %if.end18, !dbg !1937

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1925
  ret i32 0, !dbg !1925
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !1940 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1952
    #dbg_assign(i1 undef, !1949, !DIExpression(), !1952, ptr %endptr, !DIExpression(), !1953)
    #dbg_value(ptr %s, !1945, !DIExpression(), !1953)
    #dbg_value(ptr %arr, !1946, !DIExpression(), !1953)
    #dbg_value(i32 %n, !1947, !DIExpression(), !1953)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1954
    #dbg_value(i32 0, !1950, !DIExpression(), !1953)
  %cmp.not = icmp eq ptr %s, null, !dbg !1955
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1955

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #20, !dbg !1955
  unreachable, !dbg !1955

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1954
    #dbg_value(ptr %call, !1948, !DIExpression(), !1953)
    #dbg_value(i32 0, !1950, !DIExpression(), !1953)
  %cmp129 = icmp ne ptr %call, null, !dbg !1954
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1954
  %0 = and i1 %cmp230, %cmp129, !dbg !1954
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1954

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1954

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1954
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1954

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1948, !DIExpression(), !1953)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1950, !DIExpression(), !1953)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1958, !tbaa !1800, !DIAssignID !1960
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1949, !DIExpression(), !1960, ptr %endptr, !DIExpression(), !1953)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1958
    #dbg_value(i64 %call3, !1951, !DIExpression(), !1953)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1961, !tbaa !1800
  %3 = load i8, ptr %2, align 1, !dbg !1961, !tbaa !1420
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1961
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1958

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1958

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1963, !tbaa !1800
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1963
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !1963
  br label %if.end8, !dbg !1963

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1958
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1958, !tbaa !1965
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1958
    #dbg_value(i64 %indvars.iv.next, !1950, !DIExpression(), !1953)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #23, !dbg !1958
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1958
  store i8 10, ptr %arrayidx10, align 1, !dbg !1958, !tbaa !1420
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1958
    #dbg_value(ptr %call11, !1948, !DIExpression(), !1953)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1954
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1954
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1954
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1954, !llvm.loop !1967

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1954

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1954

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1954

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1954

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !1968
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1968
  store i8 10, ptr %arrayidx16, align 1, !dbg !1968, !tbaa !1420
  br label %if.end17, !dbg !1968

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1954
  ret i32 0, !dbg !1954
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !1971 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1983
    #dbg_assign(i1 undef, !1980, !DIExpression(), !1983, ptr %endptr, !DIExpression(), !1984)
    #dbg_value(ptr %s, !1976, !DIExpression(), !1984)
    #dbg_value(ptr %arr, !1977, !DIExpression(), !1984)
    #dbg_value(i32 %n, !1978, !DIExpression(), !1984)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1985
    #dbg_value(i32 0, !1981, !DIExpression(), !1984)
  %cmp.not = icmp eq ptr %s, null, !dbg !1986
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1986

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #20, !dbg !1986
  unreachable, !dbg !1986

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1985
    #dbg_value(ptr %call, !1979, !DIExpression(), !1984)
    #dbg_value(i32 0, !1981, !DIExpression(), !1984)
  %cmp130 = icmp ne ptr %call, null, !dbg !1985
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1985
  %0 = and i1 %cmp231, %cmp130, !dbg !1985
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1985

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1985

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1985
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1985

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1979, !DIExpression(), !1984)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1981, !DIExpression(), !1984)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1989, !tbaa !1800, !DIAssignID !1991
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1980, !DIExpression(), !1991, ptr %endptr, !DIExpression(), !1984)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1989
  %conv = trunc i64 %call3 to i8, !dbg !1989
    #dbg_value(i8 %conv, !1982, !DIExpression(), !1984)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1992, !tbaa !1800
  %3 = load i8, ptr %2, align 1, !dbg !1992, !tbaa !1420
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1992
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1989

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1989

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1994, !tbaa !1800
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1994
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !1994
  br label %if.end9, !dbg !1994

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1989
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1989, !tbaa !1420
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1989
    #dbg_value(i64 %indvars.iv.next, !1981, !DIExpression(), !1984)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !1989
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1989
  store i8 10, ptr %arrayidx11, align 1, !dbg !1989, !tbaa !1420
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1989
    #dbg_value(ptr %call12, !1979, !DIExpression(), !1984)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1985
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1985
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1985
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1985, !llvm.loop !1996

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1985

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1985

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1985

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1985

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !1997
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1997
  store i8 10, ptr %arrayidx17, align 1, !dbg !1997, !tbaa !1420
  br label %if.end18, !dbg !1997

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1985
  ret i32 0, !dbg !1985
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2000 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !2012
    #dbg_assign(i1 undef, !2009, !DIExpression(), !2012, ptr %endptr, !DIExpression(), !2013)
    #dbg_value(ptr %s, !2005, !DIExpression(), !2013)
    #dbg_value(ptr %arr, !2006, !DIExpression(), !2013)
    #dbg_value(i32 %n, !2007, !DIExpression(), !2013)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !2014
    #dbg_value(i32 0, !2010, !DIExpression(), !2013)
  %cmp.not = icmp eq ptr %s, null, !dbg !2015
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !2015

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #20, !dbg !2015
  unreachable, !dbg !2015

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !2014
    #dbg_value(ptr %call, !2008, !DIExpression(), !2013)
    #dbg_value(i32 0, !2010, !DIExpression(), !2013)
  %cmp130 = icmp ne ptr %call, null, !dbg !2014
  %cmp231 = icmp sgt i32 %n, 0, !dbg !2014
  %0 = and i1 %cmp231, %cmp130, !dbg !2014
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !2014

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !2014

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !2014
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !2014

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !2008, !DIExpression(), !2013)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !2010, !DIExpression(), !2013)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !2018, !tbaa !1800, !DIAssignID !2020
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !2009, !DIExpression(), !2020, ptr %endptr, !DIExpression(), !2013)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !2018
  %conv = trunc i64 %call3 to i16, !dbg !2018
    #dbg_value(i16 %conv, !2011, !DIExpression(), !2013)
  %2 = load ptr, ptr %endptr, align 8, !dbg !2021, !tbaa !1800
  %3 = load i8, ptr %2, align 1, !dbg !2021, !tbaa !1420
  %cmp5.not = icmp eq i8 %3, 0, !dbg !2021
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !2018

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !2018

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !2023, !tbaa !1800
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !2023
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !2023
  br label %if.end9, !dbg !2023

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !2018
  store i16 %conv, ptr %arrayidx, align 2, !dbg !2018, !tbaa !1905
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !2018
    #dbg_value(i64 %indvars.iv.next, !2010, !DIExpression(), !2013)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !2018
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !2018
  store i8 10, ptr %arrayidx11, align 1, !dbg !2018, !tbaa !1420
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !2018
    #dbg_value(ptr %call12, !2008, !DIExpression(), !2013)
  %cmp1 = icmp ne ptr %call12, null, !dbg !2014
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !2014
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !2014
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !2014, !llvm.loop !2025

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !2014

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !2014

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !2014

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !2014

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !2026
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !2026
  store i8 10, ptr %arrayidx17, align 1, !dbg !2026, !tbaa !1420
  br label %if.end18, !dbg !2026

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !2014
  ret i32 0, !dbg !2014
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2029 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !2041
    #dbg_assign(i1 undef, !2038, !DIExpression(), !2041, ptr %endptr, !DIExpression(), !2042)
    #dbg_value(ptr %s, !2034, !DIExpression(), !2042)
    #dbg_value(ptr %arr, !2035, !DIExpression(), !2042)
    #dbg_value(i32 %n, !2036, !DIExpression(), !2042)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !2043
    #dbg_value(i32 0, !2039, !DIExpression(), !2042)
  %cmp.not = icmp eq ptr %s, null, !dbg !2044
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !2044

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #20, !dbg !2044
  unreachable, !dbg !2044

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !2043
    #dbg_value(ptr %call, !2037, !DIExpression(), !2042)
    #dbg_value(i32 0, !2039, !DIExpression(), !2042)
  %cmp130 = icmp ne ptr %call, null, !dbg !2043
  %cmp231 = icmp sgt i32 %n, 0, !dbg !2043
  %0 = and i1 %cmp231, %cmp130, !dbg !2043
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !2043

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !2043

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !2043
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !2043

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !2037, !DIExpression(), !2042)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !2039, !DIExpression(), !2042)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !2047, !tbaa !1800, !DIAssignID !2049
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !2038, !DIExpression(), !2049, ptr %endptr, !DIExpression(), !2042)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !2047
  %conv = trunc i64 %call3 to i32, !dbg !2047
    #dbg_value(i32 %conv, !2040, !DIExpression(), !2042)
  %2 = load ptr, ptr %endptr, align 8, !dbg !2050, !tbaa !1800
  %3 = load i8, ptr %2, align 1, !dbg !2050, !tbaa !1420
  %cmp5.not = icmp eq i8 %3, 0, !dbg !2050
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !2047

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !2047

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !2052, !tbaa !1800
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !2052
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !2052
  br label %if.end9, !dbg !2052

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !2047
  store i32 %conv, ptr %arrayidx, align 4, !dbg !2047, !tbaa !350
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !2047
    #dbg_value(i64 %indvars.iv.next, !2039, !DIExpression(), !2042)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #23, !dbg !2047
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !2047
  store i8 10, ptr %arrayidx11, align 1, !dbg !2047, !tbaa !1420
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !2047
    #dbg_value(ptr %call12, !2037, !DIExpression(), !2042)
  %cmp1 = icmp ne ptr %call12, null, !dbg !2043
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !2043
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !2043
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !2043, !llvm.loop !2054

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !2043

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !2043

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !2043

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !2043

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !2055
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !2055
  store i8 10, ptr %arrayidx17, align 1, !dbg !2055, !tbaa !1420
  br label %if.end18, !dbg !2055

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !2043
  ret i32 0, !dbg !2043
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2058 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !2070
    #dbg_assign(i1 undef, !2067, !DIExpression(), !2070, ptr %endptr, !DIExpression(), !2071)
    #dbg_value(ptr %s, !2063, !DIExpression(), !2071)
    #dbg_value(ptr %arr, !2064, !DIExpression(), !2071)
    #dbg_value(i32 %n, !2065, !DIExpression(), !2071)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !2072
    #dbg_value(i32 0, !2068, !DIExpression(), !2071)
  %cmp.not = icmp eq ptr %s, null, !dbg !2073
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !2073

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #20, !dbg !2073
  unreachable, !dbg !2073

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !2072
    #dbg_value(ptr %call, !2066, !DIExpression(), !2071)
    #dbg_value(i32 0, !2068, !DIExpression(), !2071)
  %cmp129 = icmp ne ptr %call, null, !dbg !2072
  %cmp230 = icmp sgt i32 %n, 0, !dbg !2072
  %0 = and i1 %cmp230, %cmp129, !dbg !2072
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !2072

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !2072

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !2072
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !2072

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !2066, !DIExpression(), !2071)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !2068, !DIExpression(), !2071)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !2076, !tbaa !1800, !DIAssignID !2078
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !2067, !DIExpression(), !2078, ptr %endptr, !DIExpression(), !2071)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !2076
    #dbg_value(i64 %call3, !2069, !DIExpression(), !2071)
  %2 = load ptr, ptr %endptr, align 8, !dbg !2079, !tbaa !1800
  %3 = load i8, ptr %2, align 1, !dbg !2079, !tbaa !1420
  %cmp4.not = icmp eq i8 %3, 0, !dbg !2079
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !2076

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !2076

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !2081, !tbaa !1800
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !2081
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !2081
  br label %if.end8, !dbg !2081

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !2076
  store i64 %call3, ptr %arrayidx, align 8, !dbg !2076, !tbaa !1965
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !2076
    #dbg_value(i64 %indvars.iv.next, !2068, !DIExpression(), !2071)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #23, !dbg !2076
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !2076
  store i8 10, ptr %arrayidx10, align 1, !dbg !2076, !tbaa !1420
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !2076
    #dbg_value(ptr %call11, !2066, !DIExpression(), !2071)
  %cmp1 = icmp ne ptr %call11, null, !dbg !2072
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !2072
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !2072
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !2072, !llvm.loop !2083

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !2072

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !2072

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !2072

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !2072

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !2084
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !2084
  store i8 10, ptr %arrayidx16, align 1, !dbg !2084, !tbaa !1420
  br label %if.end17, !dbg !2084

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !2072
  ret i32 0, !dbg !2072
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2087 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !2099
    #dbg_assign(i1 undef, !2096, !DIExpression(), !2099, ptr %endptr, !DIExpression(), !2100)
    #dbg_value(ptr %s, !2092, !DIExpression(), !2100)
    #dbg_value(ptr %arr, !2093, !DIExpression(), !2100)
    #dbg_value(i32 %n, !2094, !DIExpression(), !2100)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !2101
    #dbg_value(i32 0, !2097, !DIExpression(), !2100)
  %cmp.not = icmp eq ptr %s, null, !dbg !2102
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !2102

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #20, !dbg !2102
  unreachable, !dbg !2102

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !2101
    #dbg_value(ptr %call, !2095, !DIExpression(), !2100)
    #dbg_value(i32 0, !2097, !DIExpression(), !2100)
  %cmp129 = icmp ne ptr %call, null, !dbg !2101
  %cmp230 = icmp sgt i32 %n, 0, !dbg !2101
  %0 = and i1 %cmp230, %cmp129, !dbg !2101
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !2101

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !2101

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !2101
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !2101

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !2095, !DIExpression(), !2100)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !2097, !DIExpression(), !2100)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !2105, !tbaa !1800, !DIAssignID !2107
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !2096, !DIExpression(), !2107, ptr %endptr, !DIExpression(), !2100)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #19, !dbg !2105
    #dbg_value(float %call3, !2098, !DIExpression(), !2100)
  %2 = load ptr, ptr %endptr, align 8, !dbg !2108, !tbaa !1800
  %3 = load i8, ptr %2, align 1, !dbg !2108, !tbaa !1420
  %cmp4.not = icmp eq i8 %3, 0, !dbg !2108
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !2105

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !2105

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !2110, !tbaa !1800
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !2110
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !2110
  br label %if.end8, !dbg !2110

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !2105
  store float %call3, ptr %arrayidx, align 4, !dbg !2105, !tbaa !2112
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !2105
    #dbg_value(i64 %indvars.iv.next, !2097, !DIExpression(), !2100)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #23, !dbg !2105
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !2105
  store i8 10, ptr %arrayidx10, align 1, !dbg !2105, !tbaa !1420
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !2105
    #dbg_value(ptr %call11, !2095, !DIExpression(), !2100)
  %cmp1 = icmp ne ptr %call11, null, !dbg !2101
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !2101
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !2101
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !2101, !llvm.loop !2114

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !2101

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !2101

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !2101

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !2101

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !2115
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !2115
  store i8 10, ptr %arrayidx16, align 1, !dbg !2115, !tbaa !1420
  br label %if.end17, !dbg !2115

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !2101
  ret i32 0, !dbg !2101
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !2118 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #14

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2121 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !2132
    #dbg_assign(i1 undef, !2129, !DIExpression(), !2132, ptr %endptr, !DIExpression(), !2133)
    #dbg_value(ptr %s, !2125, !DIExpression(), !2133)
    #dbg_value(ptr %arr, !2126, !DIExpression(), !2133)
    #dbg_value(i32 %n, !2127, !DIExpression(), !2133)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !2134
    #dbg_value(i32 0, !2130, !DIExpression(), !2133)
  %cmp.not = icmp eq ptr %s, null, !dbg !2135
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !2135

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #20, !dbg !2135
  unreachable, !dbg !2135

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !2134
    #dbg_value(ptr %call, !2128, !DIExpression(), !2133)
    #dbg_value(i32 0, !2130, !DIExpression(), !2133)
  %cmp129 = icmp ne ptr %call, null, !dbg !2134
  %cmp230 = icmp sgt i32 %n, 0, !dbg !2134
  %0 = and i1 %cmp230, %cmp129, !dbg !2134
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !2134

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !2134

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !2134
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !2134

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !2128, !DIExpression(), !2133)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !2130, !DIExpression(), !2133)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !2138, !tbaa !1800, !DIAssignID !2140
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !2129, !DIExpression(), !2140, ptr %endptr, !DIExpression(), !2133)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #19, !dbg !2138
    #dbg_value(double %call3, !2131, !DIExpression(), !2133)
  %2 = load ptr, ptr %endptr, align 8, !dbg !2141, !tbaa !1800
  %3 = load i8, ptr %2, align 1, !dbg !2141, !tbaa !1420
  %cmp4.not = icmp eq i8 %3, 0, !dbg !2141
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !2138

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !2138

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !2143, !tbaa !1800
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !2143
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #22, !dbg !2143
  br label %if.end8, !dbg !2143

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !2138
  store double %call3, ptr %arrayidx, align 8, !dbg !2138, !tbaa !360
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !2138
    #dbg_value(i64 %indvars.iv.next, !2130, !DIExpression(), !2133)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #23, !dbg !2138
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !2138
  store i8 10, ptr %arrayidx10, align 1, !dbg !2138, !tbaa !1420
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !2138
    #dbg_value(ptr %call11, !2128, !DIExpression(), !2133)
  %cmp1 = icmp ne ptr %call11, null, !dbg !2134
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !2134
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !2134
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !2134, !llvm.loop !2145

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !2134

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !2134

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !2134

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !2134

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #23, !dbg !2146
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !2146
  store i8 10, ptr %arrayidx16, align 1, !dbg !2146, !tbaa !1420
  br label %if.end17, !dbg !2146

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !2134
  ret i32 0, !dbg !2134
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !2149 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #14

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2152 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !2156, !DIExpression(), !2161)
    #dbg_value(ptr %arr, !2157, !DIExpression(), !2161)
    #dbg_value(i32 %n, !2158, !DIExpression(), !2161)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2162
  br i1 %cmp, label %if.end, label %if.else, !dbg !2162

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #20, !dbg !2162
  unreachable, !dbg !2162

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !2165
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !2167

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !2167

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #23, !dbg !2168
  %conv = trunc i64 %call to i32, !dbg !2168
    #dbg_value(i32 %conv, !2158, !DIExpression(), !2161)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !2170

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !2158, !DIExpression(), !2161)
    #dbg_value(i32 0, !2160, !DIExpression(), !2161)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !2171
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !2172

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !2172

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !2172

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !2173

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !2174
    #dbg_value(i32 %add, !2160, !DIExpression(), !2161)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !2171
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !2172, !llvm.loop !2176

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !2172

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !2172

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !2160, !DIExpression(), !2161)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !2178
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !2178
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !2179
  %conv6 = sext i32 %sub to i64, !dbg !2180
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #19, !dbg !2181
  %conv8 = trunc i64 %call7 to i32, !dbg !2181
    #dbg_value(i32 %conv8, !2159, !DIExpression(), !2161)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !2182
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !2160, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !2161)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !2182

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #20, !dbg !2182
  unreachable, !dbg !2182

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #19, !dbg !2185
  %conv16 = trunc i64 %call15 to i32, !dbg !2185
    #dbg_value(i32 %conv16, !2159, !DIExpression(), !2161)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !2187
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !2187

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #20, !dbg !2187
  unreachable, !dbg !2187

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !2190
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !2191, !llvm.loop !2192

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !2191

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !2194
}

; Function Attrs: nofree
declare !dbg !2195 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2200 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !2204, !DIExpression(), !2208)
    #dbg_value(ptr %arr, !2205, !DIExpression(), !2208)
    #dbg_value(i32 %n, !2206, !DIExpression(), !2208)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2209
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !2209

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !2207, !DIExpression(), !2208)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !2212
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !2215

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !2215

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !2212
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2215

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #20, !dbg !2209
  unreachable, !dbg !2209

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !2207, !DIExpression(), !2208)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !2216
  %0 = load i8, ptr %arrayidx, align 1, !dbg !2216, !tbaa !1420
  %conv = zext i8 %0 to i32, !dbg !2216
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !2216
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !2212
    #dbg_value(i64 %indvars.iv.next, !2207, !DIExpression(), !2208)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !2212
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !2215, !llvm.loop !2218

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2215

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !2215

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !2219
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #16 !dbg !2220 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !2237
    #dbg_assign(i1 undef, !2226, !DIExpression(), !2237, ptr %args, !DIExpression(), !2238)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !2239
    #dbg_assign(i1 undef, !2233, !DIExpression(), !2239, ptr %buffer, !DIExpression(), !2238)
    #dbg_value(i32 %fd, !2224, !DIExpression(), !2238)
    #dbg_value(ptr %format, !2225, !DIExpression(), !2238)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #19, !dbg !2240
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #19, !dbg !2241
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !2242
  %0 = load ptr, ptr %args, align 8, !dbg !2243, !tbaa !1800
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #19, !dbg !2244
    #dbg_value(i32 %call, !2230, !DIExpression(), !2238)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !2245
  %cmp = icmp slt i32 %call, 256, !dbg !2246
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !2246

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !2231, !DIExpression(), !2238)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !2249
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !2250

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !2250

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !2250

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #20, !dbg !2246
  unreachable, !dbg !2246

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !2251
    #dbg_value(i32 %add, !2231, !DIExpression(), !2238)
  %cmp1 = icmp slt i32 %add, %call, !dbg !2249
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !2250, !llvm.loop !2253

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !2250

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !2250

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !2231, !DIExpression(), !2238)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !2255
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !2255
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !2256
  %conv = sext i32 %sub to i64, !dbg !2257
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #19, !dbg !2258
  %conv3 = trunc i64 %call2 to i32, !dbg !2258
    #dbg_value(i32 %conv3, !2232, !DIExpression(), !2238)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !2259
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !2231, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !2238)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !2259

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #20, !dbg !2259
  unreachable, !dbg !2259

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !2262
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !2262

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #20, !dbg !2262
  unreachable, !dbg !2262

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #19, !dbg !2265
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #19, !dbg !2265
  ret void, !dbg !2266
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #17

; Function Attrs: nofree nounwind
declare !dbg !2267 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #10

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #17

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2272 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !2276, !DIExpression(), !2280)
    #dbg_value(ptr %arr, !2277, !DIExpression(), !2280)
    #dbg_value(i32 %n, !2278, !DIExpression(), !2280)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2281
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !2281

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !2279, !DIExpression(), !2280)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !2284
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !2287

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !2287

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !2284
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2287

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #20, !dbg !2281
  unreachable, !dbg !2281

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !2279, !DIExpression(), !2280)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !2288
  %0 = load i16, ptr %arrayidx, align 2, !dbg !2288, !tbaa !1905
  %conv = zext i16 %0 to i32, !dbg !2288
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !2288
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !2284
    #dbg_value(i64 %indvars.iv.next, !2279, !DIExpression(), !2280)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !2284
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !2287, !llvm.loop !2290

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2287

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !2287

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !2291
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2292 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !2296, !DIExpression(), !2300)
    #dbg_value(ptr %arr, !2297, !DIExpression(), !2300)
    #dbg_value(i32 %n, !2298, !DIExpression(), !2300)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2301
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !2301

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !2299, !DIExpression(), !2300)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !2304
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !2307

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !2307

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !2304
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2307

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #20, !dbg !2301
  unreachable, !dbg !2301

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !2299, !DIExpression(), !2300)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !2308
  %0 = load i32, ptr %arrayidx, align 4, !dbg !2308, !tbaa !350
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !2308
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !2304
    #dbg_value(i64 %indvars.iv.next, !2299, !DIExpression(), !2300)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !2304
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !2307, !llvm.loop !2310

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2307

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !2307

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !2311
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2312 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !2316, !DIExpression(), !2320)
    #dbg_value(ptr %arr, !2317, !DIExpression(), !2320)
    #dbg_value(i32 %n, !2318, !DIExpression(), !2320)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2321
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !2321

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !2319, !DIExpression(), !2320)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !2324
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !2327

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !2327

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !2324
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2327

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #20, !dbg !2321
  unreachable, !dbg !2321

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !2319, !DIExpression(), !2320)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !2328
  %0 = load i64, ptr %arrayidx, align 8, !dbg !2328, !tbaa !1965
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !2328
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !2324
    #dbg_value(i64 %indvars.iv.next, !2319, !DIExpression(), !2320)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !2324
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !2327, !llvm.loop !2330

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2327

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !2327

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !2331
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2332 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !2336, !DIExpression(), !2340)
    #dbg_value(ptr %arr, !2337, !DIExpression(), !2340)
    #dbg_value(i32 %n, !2338, !DIExpression(), !2340)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2341
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !2341

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !2339, !DIExpression(), !2340)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !2344
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !2347

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !2347

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !2344
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2347

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #20, !dbg !2341
  unreachable, !dbg !2341

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !2339, !DIExpression(), !2340)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !2348
  %0 = load i8, ptr %arrayidx, align 1, !dbg !2348, !tbaa !1420
  %conv = sext i8 %0 to i32, !dbg !2348
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !2348
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !2344
    #dbg_value(i64 %indvars.iv.next, !2339, !DIExpression(), !2340)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !2344
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !2347, !llvm.loop !2350

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2347

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !2347

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !2351
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2352 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !2356, !DIExpression(), !2360)
    #dbg_value(ptr %arr, !2357, !DIExpression(), !2360)
    #dbg_value(i32 %n, !2358, !DIExpression(), !2360)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2361
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !2361

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !2359, !DIExpression(), !2360)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !2364
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !2367

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !2367

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !2364
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2367

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #20, !dbg !2361
  unreachable, !dbg !2361

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !2359, !DIExpression(), !2360)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !2368
  %0 = load i16, ptr %arrayidx, align 2, !dbg !2368, !tbaa !1905
  %conv = sext i16 %0 to i32, !dbg !2368
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !2368
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !2364
    #dbg_value(i64 %indvars.iv.next, !2359, !DIExpression(), !2360)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !2364
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !2367, !llvm.loop !2370

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2367

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !2367

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !2371
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2372 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !2376, !DIExpression(), !2380)
    #dbg_value(ptr %arr, !2377, !DIExpression(), !2380)
    #dbg_value(i32 %n, !2378, !DIExpression(), !2380)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2381
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !2381

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !2379, !DIExpression(), !2380)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !2384
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !2387

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !2387

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !2384
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2387

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #20, !dbg !2381
  unreachable, !dbg !2381

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !2379, !DIExpression(), !2380)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !2388
  %0 = load i32, ptr %arrayidx, align 4, !dbg !2388, !tbaa !350
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !2388
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !2384
    #dbg_value(i64 %indvars.iv.next, !2379, !DIExpression(), !2380)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !2384
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !2387, !llvm.loop !2390

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2387

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !2387

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !2391
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2392 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !2396, !DIExpression(), !2400)
    #dbg_value(ptr %arr, !2397, !DIExpression(), !2400)
    #dbg_value(i32 %n, !2398, !DIExpression(), !2400)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2401
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !2401

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !2399, !DIExpression(), !2400)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !2404
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !2407

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !2407

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !2404
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2407

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #20, !dbg !2401
  unreachable, !dbg !2401

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !2399, !DIExpression(), !2400)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !2408
  %0 = load i64, ptr %arrayidx, align 8, !dbg !2408, !tbaa !1965
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !2408
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !2404
    #dbg_value(i64 %indvars.iv.next, !2399, !DIExpression(), !2400)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !2404
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !2407, !llvm.loop !2410

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2407

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !2407

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !2411
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !2412 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !2416, !DIExpression(), !2420)
    #dbg_value(ptr %arr, !2417, !DIExpression(), !2420)
    #dbg_value(i32 %n, !2418, !DIExpression(), !2420)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2421
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !2421

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !2419, !DIExpression(), !2420)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !2424
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !2427

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !2427

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !2424
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2427

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #20, !dbg !2421
  unreachable, !dbg !2421

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !2419, !DIExpression(), !2420)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !2428
  %0 = load float, ptr %arrayidx, align 4, !dbg !2428, !tbaa !2112
  %conv = fpext float %0 to double, !dbg !2428
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !2428
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !2424
    #dbg_value(i64 %indvars.iv.next, !2419, !DIExpression(), !2420)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !2424
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !2427, !llvm.loop !2430

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2427

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !2427

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !2431
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #6 !dbg !1482 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1481, !DIExpression(), !2432)
    #dbg_value(ptr %arr, !1486, !DIExpression(), !2432)
    #dbg_value(i32 %n, !1487, !DIExpression(), !2432)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2433
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !2433

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1488, !DIExpression(), !2432)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !2436
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !2437

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !2437

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !2436
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2437

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #20, !dbg !2433
  unreachable, !dbg !2433

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1488, !DIExpression(), !2432)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !2438
  %0 = load double, ptr %arrayidx, align 8, !dbg !2438, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !2438
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !2436
    #dbg_value(i64 %indvars.iv.next, !1488, !DIExpression(), !2432)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !2436
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !2437, !llvm.loop !2439

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !2437

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !2437

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !2440
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #6 !dbg !1471 {
entry.split:
    #dbg_value(i32 %fd, !1470, !DIExpression(), !2441)
  %cmp = icmp sgt i32 %fd, 1, !dbg !2442
  br i1 %cmp, label %if.end, label %if.else, !dbg !2442

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !2442
  unreachable, !dbg !2442

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !2443
  ret i32 0, !dbg !2444
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #6 !dbg !2445 {
entry.split:
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.030.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %indvars.iv.i10.i.reg2mem = alloca i64, align 8
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %check_file.0.reg2mem32 = alloca ptr, align 8
  %in_file.04.reg2mem34 = alloca ptr, align 8
    #dbg_value(i32 %argc, !2449, !DIExpression(), !2458)
    #dbg_value(ptr %argv, !2450, !DIExpression(), !2458)
  %cmp = icmp slt i32 %argc, 4, !dbg !2459
  br i1 %cmp, label %if.end, label %if.else, !dbg !2459

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !2459
  unreachable, !dbg !2459

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !2451, !DIExpression(), !2458)
    #dbg_value(ptr @.str.4.13, !2452, !DIExpression(), !2458)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !2462
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !2464

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.13, ptr %check_file.0.reg2mem32, align 8
  store ptr @.str.3, ptr %in_file.04.reg2mem34, align 8
  br label %if.end7, !dbg !2464

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !2465
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !2465
    #dbg_value(ptr %0, !2451, !DIExpression(), !2458)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !2466
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !2468

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.13, ptr %check_file.0.reg2mem32, align 8
  store ptr %0, ptr %in_file.04.reg2mem34, align 8
  br label %if.end7, !dbg !2468

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !2469
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !2469
    #dbg_value(ptr %1, !2452, !DIExpression(), !2458)
  store ptr %1, ptr %check_file.0.reg2mem32, align 8
  store ptr %0, ptr %in_file.04.reg2mem34, align 8
  br label %if.end7, !dbg !2470

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem32.0.check_file.0.reload33, !2452, !DIExpression(), !2458)
  %in_file.04.reg2mem34.0.in_file.04.reload35 = load ptr, ptr %in_file.04.reg2mem34, align 8
  %check_file.0.reg2mem32.0.check_file.0.reload33 = load ptr, ptr %check_file.0.reg2mem32, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !2471, !tbaa !350
  %conv = sext i32 %2 to i64, !dbg !2471
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #21, !dbg !2472
    #dbg_value(ptr %call, !2454, !DIExpression(), !2458)
  %cmp8.not = icmp eq ptr %call, null, !dbg !2473
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !2473

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.14, ptr noundef nonnull @.str.2.12, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !2473
  unreachable, !dbg !2473

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.04.reg2mem34.0.in_file.04.reload35, i32 noundef signext 0) #19, !dbg !2476
    #dbg_value(i32 %call14, !2453, !DIExpression(), !2458)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !2477
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !2477

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.15, ptr noundef nonnull @.str.2.12, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !2477
  unreachable, !dbg !2477

if.end20:                                         ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #19, !dbg !2480
    #dbg_value(ptr %call, !1393, !DIExpression(), !2481)
    #dbg_value(ptr %call, !1394, !DIExpression(), !2481)
  %work_y.i = getelementptr inbounds i8, ptr %call, i64 4096, !dbg !2483
  tail call void @fft(ptr noundef nonnull %call, ptr noundef nonnull %work_y.i) #19, !dbg !2484
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #19, !dbg !2485
    #dbg_value(i32 %call21, !2455, !DIExpression(), !2458)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !2486
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !2486

if.else26:                                        ; preds = %if.end20
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !2486
  unreachable, !dbg !2486

if.end27:                                         ; preds = %if.end20
    #dbg_value(i32 %call21, !1561, !DIExpression(), !2489)
    #dbg_value(ptr %call, !1562, !DIExpression(), !2489)
    #dbg_value(ptr %call, !1563, !DIExpression(), !2489)
    #dbg_value(i32 %call21, !1470, !DIExpression(), !2491)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !2493
  br i1 %cmp.i.i.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !2493

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !2493
  unreachable, !dbg !2493

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !2494
    #dbg_value(i32 %call21, !1481, !DIExpression(), !2495)
    #dbg_value(ptr %call, !1486, !DIExpression(), !2495)
    #dbg_value(i32 512, !1487, !DIExpression(), !2495)
    #dbg_value(i32 0, !1488, !DIExpression(), !2495)
  store i64 0, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !2497

for.body.i.i:                                     ; preds = %for.body.i.i.for.body.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !1488, !DIExpression(), !2495)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %arrayidx.i.i = getelementptr inbounds double, ptr %call, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !2498
  %3 = load double, ptr %arrayidx.i.i, align 8, !dbg !2498, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.21, double noundef %3), !dbg !2498
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !2499
    #dbg_value(i64 %indvars.iv.next.i.i, !1488, !DIExpression(), !2495)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 512, !dbg !2499
  br i1 %exitcond.not.i.i, label %for.cond.preheader.i8.i, label %for.body.i.i.for.body.i.i_crit_edge, !dbg !2497, !llvm.loop !2500

for.body.i.i.for.body.i.i_crit_edge:              ; preds = %for.body.i.i
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !2497

for.cond.preheader.i8.i:                          ; preds = %for.body.i.i
    #dbg_value(i32 %call21, !1470, !DIExpression(), !2501)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !2503
    #dbg_value(i32 %call21, !1481, !DIExpression(), !2504)
    #dbg_value(ptr %work_y.i, !1486, !DIExpression(), !2504)
    #dbg_value(i32 512, !1487, !DIExpression(), !2504)
    #dbg_value(i32 0, !1488, !DIExpression(), !2504)
  store i64 0, ptr %indvars.iv.i10.i.reg2mem, align 8
  br label %for.body.i9.i, !dbg !2506

for.body.i9.i:                                    ; preds = %for.body.i9.i.for.body.i9.i_crit_edge, %for.cond.preheader.i8.i
    #dbg_value(i64 %indvars.iv.i10.i.reg2mem.0.load, !1488, !DIExpression(), !2504)
  %indvars.iv.i10.i.reg2mem.0.load = load i64, ptr %indvars.iv.i10.i.reg2mem, align 8
  %arrayidx.i11.i = getelementptr inbounds double, ptr %work_y.i, i64 %indvars.iv.i10.i.reg2mem.0.load, !dbg !2507
  %4 = load double, ptr %arrayidx.i11.i, align 8, !dbg !2507, !tbaa !360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.21, double noundef %4), !dbg !2507
  %indvars.iv.next.i12.i = add nuw nsw i64 %indvars.iv.i10.i.reg2mem.0.load, 1, !dbg !2508
    #dbg_value(i64 %indvars.iv.next.i12.i, !1488, !DIExpression(), !2504)
  %exitcond.not.i13.i = icmp eq i64 %indvars.iv.next.i12.i, 512, !dbg !2508
  br i1 %exitcond.not.i13.i, label %data_to_output.exit, label %for.body.i9.i.for.body.i9.i_crit_edge, !dbg !2506, !llvm.loop !2509

for.body.i9.i.for.body.i9.i_crit_edge:            ; preds = %for.body.i9.i
  store i64 %indvars.iv.next.i12.i, ptr %indvars.iv.i10.i.reg2mem, align 8
  br label %for.body.i9.i, !dbg !2506

data_to_output.exit:                              ; preds = %for.body.i9.i
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #19, !dbg !2510
  %5 = load i32, ptr @INPUT_SIZE, align 4, !dbg !2511, !tbaa !350
  %conv29 = sext i32 %5 to i64, !dbg !2511
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #21, !dbg !2512
    #dbg_value(ptr %call30, !2457, !DIExpression(), !2458)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !2513
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !2513

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.16, ptr noundef nonnull @.str.2.12, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !2513
  unreachable, !dbg !2513

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem32.0.check_file.0.reload33, i32 noundef signext 0) #19, !dbg !2516
    #dbg_value(i32 %call37, !2456, !DIExpression(), !2458)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !2517
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !2517

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.17, ptr noundef nonnull @.str.2.12, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !2517
  unreachable, !dbg !2517

if.end43:                                         ; preds = %if.end36
  tail call void @output_to_data(i32 noundef signext %call37, ptr noundef nonnull %call30) #19, !dbg !2520
    #dbg_value(ptr %call, !1590, !DIExpression(), !2521)
    #dbg_value(ptr %call30, !1591, !DIExpression(), !2521)
    #dbg_value(ptr %call, !1592, !DIExpression(), !2521)
    #dbg_value(ptr %call30, !1593, !DIExpression(), !2521)
    #dbg_value(i32 0, !1594, !DIExpression(), !2521)
    #dbg_value(i32 0, !1595, !DIExpression(), !2521)
  store i32 0, ptr %has_errors.030.i.reg2mem, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !2524

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %if.end43
    #dbg_value(i32 %has_errors.030.i.reg2mem.0.load, !1594, !DIExpression(), !2521)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !1595, !DIExpression(), !2521)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %has_errors.030.i.reg2mem.0.load = load i32, ptr %has_errors.030.i.reg2mem, align 4
  %arrayidx.i = getelementptr inbounds [512 x double], ptr %call, i64 0, i64 %indvars.iv.i.reg2mem.0.load, !dbg !2525
  %6 = load double, ptr %arrayidx.i, align 8, !dbg !2525, !tbaa !360
  %arrayidx3.i = getelementptr inbounds [512 x double], ptr %call30, i64 0, i64 %indvars.iv.i.reg2mem.0.load, !dbg !2526
  %7 = load double, ptr %arrayidx3.i, align 8, !dbg !2526, !tbaa !360
  %sub.i = fsub double %6, %7, !dbg !2527
    #dbg_value(double %sub.i, !1596, !DIExpression(), !2521)
  %arrayidx5.i = getelementptr inbounds %struct.bench_args_t, ptr %call, i64 0, i32 1, i64 %indvars.iv.i.reg2mem.0.load, !dbg !2528
  %8 = load double, ptr %arrayidx5.i, align 8, !dbg !2528, !tbaa !360
  %arrayidx8.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 1, i64 %indvars.iv.i.reg2mem.0.load, !dbg !2529
  %9 = load double, ptr %arrayidx8.i, align 8, !dbg !2529, !tbaa !360
  %sub9.i = fsub double %8, %9, !dbg !2530
    #dbg_value(double %sub9.i, !1597, !DIExpression(), !2521)
  %10 = tail call double @llvm.fabs.f64(double %sub.i), !dbg !2531
  %11 = fcmp ogt double %10, 0x3EB0C6F7A0B5ED8D, !dbg !2531
    #dbg_value(!DIArgList(i32 %has_errors.030.i.reg2mem.0.load, i1 %11), !1594, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !2521)
  %12 = tail call double @llvm.fabs.f64(double %sub9.i), !dbg !2532
  %13 = fcmp ogt double %12, 0x3EB0C6F7A0B5ED8D, !dbg !2532
  %14 = or i1 %11, %13, !dbg !2533
  %15 = zext i1 %14 to i32, !dbg !2533
  %or17.i = or i32 %has_errors.030.i.reg2mem.0.load, %15, !dbg !2533
    #dbg_value(i32 %or17.i, !1594, !DIExpression(), !2521)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !2534
    #dbg_value(i64 %indvars.iv.next.i, !1595, !DIExpression(), !2521)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 512, !dbg !2535
  br i1 %exitcond.not.i, label %check_data.exit, label %for.body.i.for.body.i_crit_edge, !dbg !2524, !llvm.loop !2536

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i32 %or17.i, ptr %has_errors.030.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !2524

check_data.exit:                                  ; preds = %for.body.i
  %tobool.not.i.not = icmp eq i32 %or17.i, 0, !dbg !2538
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !2539

if.then45:                                        ; preds = %check_data.exit
  %16 = load ptr, ptr @stderr, align 8, !dbg !2540, !tbaa !1800
  %17 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %16) #22, !dbg !2542
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !2543

if.end47:                                         ; preds = %check_data.exit
  tail call void @free(ptr noundef nonnull %call) #19, !dbg !2544
  tail call void @free(ptr noundef nonnull %call30) #19, !dbg !2545
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !2546
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !2547

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !2548
}

; Function Attrs: nofree
declare !dbg !2549 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #12

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #18

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #18

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #2

attributes #0 = { nofree nounwind memory(write, argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { mustprogress nofree nounwind willreturn memory(write) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #6 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #7 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #8 = { nofree norecurse nosync nounwind memory(argmem: read) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #9 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #10 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #11 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #12 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #13 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #14 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #15 = { mustprogress nofree nounwind willreturn memory(argmem: read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #16 = { inlinehint nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #17 = { nocallback nofree nosync nounwind willreturn }
attributes #18 = { nofree nounwind }
attributes #19 = { nounwind }
attributes #20 = { noreturn nounwind }
attributes #21 = { nounwind allocsize(0) }
attributes #22 = { cold }
attributes #23 = { nounwind willreturn memory(read) }

!llvm.dbg.cu = !{!224, !188, !226, !291}
!llvm.ident = !{!312, !312, !312, !312}
!llvm.module.flags = !{!313, !314, !315, !316, !317, !319, !320, !321, !322, !323}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/fft/transpose")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/fft/transpose")
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
!187 = distinct !DIGlobalVariable(name: "INPUT_SIZE", scope: !188, file: !189, line: 4, type: !202, isLocal: false, isDefinition: true)
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !201, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/fft/transpose")
!190 = !{!191, !197}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 27, size: 65536, elements: !194)
!193 = !DIFile(filename: "./fft.h", directory: "/home/kelvin/MachSuite/fft/transpose")
!194 = !{!195, !200}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "work_x", scope: !192, file: !193, line: 28, baseType: !196, size: 32768)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 32768, elements: !198)
!197 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!198 = !{!199}
!199 = !DISubrange(count: 512)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "work_y", scope: !192, file: !193, line: 29, baseType: !196, size: 32768, offset: 32768)
!201 = !{!186}
!202 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!203 = !DIGlobalVariableExpression(var: !204, expr: !DIExpression())
!204 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !205, isLocal: true, isDefinition: true)
!205 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!206 = !DIGlobalVariableExpression(var: !207, expr: !DIExpression())
!207 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !208, isLocal: true, isDefinition: true)
!208 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!209 = !DIGlobalVariableExpression(var: !210, expr: !DIExpression())
!210 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !211, isLocal: true, isDefinition: true)
!211 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !212)
!212 = !{!213}
!213 = !DISubrange(count: 12)
!214 = !DIGlobalVariableExpression(var: !215, expr: !DIExpression())
!215 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !216, isLocal: true, isDefinition: true)
!216 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!217 = !DIGlobalVariableExpression(var: !218, expr: !DIExpression())
!218 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!219 = !DIGlobalVariableExpression(var: !220, expr: !DIExpression())
!220 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !221, isLocal: true, isDefinition: true)
!221 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!222 = !DIGlobalVariableExpression(var: !223, expr: !DIExpression())
!223 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!224 = distinct !DICompileUnit(language: DW_LANG_C11, file: !225, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!225 = !DIFile(filename: "fft.c", directory: "/home/kelvin/MachSuite/fft/transpose")
!226 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !227, globals: !257, splitDebugInlining: false, nameTableKind: None)
!227 = !{!228, !4, !229, !230, !235, !238, !241, !244, !248, !251, !253, !256, !197}
!228 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!229 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!230 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !231, line: 24, baseType: !232)
!231 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!232 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !233, line: 38, baseType: !234)
!233 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!234 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!235 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !231, line: 25, baseType: !236)
!236 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !233, line: 40, baseType: !237)
!237 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!238 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !231, line: 26, baseType: !239)
!239 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !233, line: 42, baseType: !240)
!240 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!241 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !231, line: 27, baseType: !242)
!242 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !233, line: 45, baseType: !243)
!243 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!244 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !245, line: 24, baseType: !246)
!245 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!246 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !233, line: 37, baseType: !247)
!247 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!248 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !245, line: 25, baseType: !249)
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !233, line: 39, baseType: !250)
!250 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!251 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !245, line: 26, baseType: !252)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !233, line: 41, baseType: !202)
!253 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !245, line: 27, baseType: !254)
!254 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !233, line: 44, baseType: !255)
!255 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!256 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!257 = !{!258, !0, !7, !12, !263, !18, !265, !23, !270, !28, !272, !33, !38, !274, !43, !45, !47, !52, !57, !62, !67, !69, !71, !76, !78, !80, !82, !87, !89, !279, !92, !97, !102, !107, !112, !114, !116, !121, !126, !128, !130, !132, !134, !136, !141, !146, !148, !153, !284, !158, !163, !286, !165}
!258 = !DIGlobalVariableExpression(var: !259, expr: !DIExpression())
!259 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !260, isLocal: true, isDefinition: true)
!260 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !261)
!261 = !{!262}
!262 = !DISubrange(count: 24)
!263 = !DIGlobalVariableExpression(var: !264, expr: !DIExpression())
!264 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !30, isLocal: true, isDefinition: true)
!265 = !DIGlobalVariableExpression(var: !266, expr: !DIExpression())
!266 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !267, isLocal: true, isDefinition: true)
!267 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !268)
!268 = !{!269}
!269 = !DISubrange(count: 14)
!270 = !DIGlobalVariableExpression(var: !271, expr: !DIExpression())
!271 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !267, isLocal: true, isDefinition: true)
!272 = !DIGlobalVariableExpression(var: !273, expr: !DIExpression())
!273 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !9, isLocal: true, isDefinition: true)
!274 = !DIGlobalVariableExpression(var: !275, expr: !DIExpression())
!275 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !276, isLocal: true, isDefinition: true)
!276 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !277)
!277 = !{!278}
!278 = !DISubrange(count: 21)
!279 = !DIGlobalVariableExpression(var: !280, expr: !DIExpression())
!280 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !281, isLocal: true, isDefinition: true)
!281 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !282)
!282 = !{!283}
!283 = !DISubrange(count: 13)
!284 = !DIGlobalVariableExpression(var: !285, expr: !DIExpression())
!285 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !20, isLocal: true, isDefinition: true)
!286 = !DIGlobalVariableExpression(var: !287, expr: !DIExpression())
!287 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !288, isLocal: true, isDefinition: true)
!288 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !289)
!289 = !{!290}
!290 = !DISubrange(count: 27)
!291 = distinct !DICompileUnit(language: DW_LANG_C11, file: !170, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !292, globals: !293, splitDebugInlining: false, nameTableKind: None)
!292 = !{!229}
!293 = !{!294, !168, !174, !176, !179, !184, !296, !203, !298, !206, !209, !300, !214, !217, !305, !219, !222, !307}
!294 = !DIGlobalVariableExpression(var: !295, expr: !DIExpression())
!295 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !216, isLocal: true, isDefinition: true)
!296 = !DIGlobalVariableExpression(var: !297, expr: !DIExpression())
!297 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !267, isLocal: true, isDefinition: true)
!298 = !DIGlobalVariableExpression(var: !299, expr: !DIExpression())
!299 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !205, isLocal: true, isDefinition: true)
!300 = !DIGlobalVariableExpression(var: !301, expr: !DIExpression())
!301 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !302, isLocal: true, isDefinition: true)
!302 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !303)
!303 = !{!304}
!304 = !DISubrange(count: 31)
!305 = !DIGlobalVariableExpression(var: !306, expr: !DIExpression())
!306 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !205, isLocal: true, isDefinition: true)
!307 = !DIGlobalVariableExpression(var: !308, expr: !DIExpression())
!308 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !309, isLocal: true, isDefinition: true)
!309 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !310)
!310 = !{!311}
!311 = !DISubrange(count: 10)
!312 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!313 = !{i32 7, !"Dwarf Version", i32 4}
!314 = !{i32 2, !"Debug Info Version", i32 3}
!315 = !{i32 1, !"wchar_size", i32 4}
!316 = !{i32 1, !"target-abi", !"lp64d"}
!317 = distinct !{i32 6, !"riscv-isa", !318}
!318 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!319 = !{i32 8, !"PIC Level", i32 2}
!320 = !{i32 7, !"PIE Level", i32 2}
!321 = !{i32 7, !"uwtable", i32 2}
!322 = !{i32 8, !"SmallDataLimit", i32 8}
!323 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!324 = distinct !DISubprogram(name: "twiddles8", scope: !225, file: !225, line: 23, type: !325, scopeLine: 23, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !224, retainedNodes: !328)
!325 = !DISubroutineType(types: !326)
!326 = !{null, !327, !327, !202, !202}
!327 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!328 = !{!329, !330, !331, !332, !333, !337, !338, !339, !340, !341, !342}
!329 = !DILocalVariable(name: "a_x", arg: 1, scope: !324, file: !225, line: 23, type: !327)
!330 = !DILocalVariable(name: "a_y", arg: 2, scope: !324, file: !225, line: 23, type: !327)
!331 = !DILocalVariable(name: "i", arg: 3, scope: !324, file: !225, line: 23, type: !202)
!332 = !DILocalVariable(name: "n", arg: 4, scope: !324, file: !225, line: 23, type: !202)
!333 = !DILocalVariable(name: "reversed8", scope: !324, file: !225, line: 24, type: !334)
!334 = !DICompositeType(tag: DW_TAG_array_type, baseType: !202, size: 256, elements: !335)
!335 = !{!336}
!336 = !DISubrange(count: 8)
!337 = !DILocalVariable(name: "j", scope: !324, file: !225, line: 25, type: !202)
!338 = !DILocalVariable(name: "phi", scope: !324, file: !225, line: 26, type: !197)
!339 = !DILocalVariable(name: "tmp", scope: !324, file: !225, line: 26, type: !197)
!340 = !DILocalVariable(name: "phi_x", scope: !324, file: !225, line: 26, type: !197)
!341 = !DILocalVariable(name: "phi_y", scope: !324, file: !225, line: 26, type: !197)
!342 = !DILabel(scope: !324, name: "twiddles", file: !225, line: 28)
!343 = !DILocation(line: 0, scope: !324)
!344 = !DILocation(line: 28, column: 5, scope: !324)
!345 = !DILocation(line: 28, column: 14, scope: !346)
!346 = distinct !DILexicalBlock(scope: !324, file: !225, line: 28, column: 14)
!347 = !DILocation(line: 29, column: 23, scope: !348)
!348 = distinct !DILexicalBlock(scope: !349, file: !225, line: 28, column: 34)
!349 = distinct !DILexicalBlock(scope: !346, file: !225, line: 28, column: 14)
!350 = !{!351, !351, i64 0}
!351 = !{!"int", !352, i64 0}
!352 = !{!"omnipotent char", !353, i64 0}
!353 = !{!"Simple C/C++ TBAA"}
!354 = !DILocation(line: 29, column: 22, scope: !348)
!355 = !DILocation(line: 29, column: 35, scope: !348)
!356 = !DILocation(line: 29, column: 38, scope: !348)
!357 = !DILocation(line: 30, column: 17, scope: !348)
!358 = !DILocation(line: 31, column: 17, scope: !348)
!359 = !DILocation(line: 32, column: 15, scope: !348)
!360 = !{!361, !361, i64 0}
!361 = !{!"double", !352, i64 0}
!362 = !DILocation(line: 33, column: 18, scope: !348)
!363 = !DILocation(line: 33, column: 16, scope: !348)
!364 = !DILocation(line: 34, column: 18, scope: !348)
!365 = !DILocation(line: 34, column: 16, scope: !348)
!366 = !DILocation(line: 28, column: 31, scope: !349)
!367 = !DILocation(line: 28, column: 25, scope: !349)
!368 = distinct !{!368, !345, !369, !370, !371}
!369 = !DILocation(line: 35, column: 5, scope: !346)
!370 = !{!"llvm.loop.mustprogress"}
!371 = !{!"llvm.loop.unroll.disable"}
!372 = !DILocation(line: 36, column: 1, scope: !324)
!373 = !DISubprogram(name: "cos", scope: !374, file: !374, line: 62, type: !375, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!374 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/mathcalls.h", directory: "")
!375 = !DISubroutineType(types: !376)
!376 = !{!197, !197}
!377 = !DISubprogram(name: "sin", scope: !374, file: !374, line: 64, type: !375, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!378 = distinct !DISubprogram(name: "loadx8", scope: !225, file: !225, line: 91, type: !325, scopeLine: 91, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !224, retainedNodes: !379)
!379 = !{!380, !381, !382, !383, !384}
!380 = !DILocalVariable(name: "a_x", arg: 1, scope: !378, file: !225, line: 91, type: !327)
!381 = !DILocalVariable(name: "x", arg: 2, scope: !378, file: !225, line: 91, type: !327)
!382 = !DILocalVariable(name: "offset", arg: 3, scope: !378, file: !225, line: 91, type: !202)
!383 = !DILocalVariable(name: "sx", arg: 4, scope: !378, file: !225, line: 91, type: !202)
!384 = !DILocalVariable(name: "i", scope: !385, file: !225, line: 92, type: !386)
!385 = distinct !DILexicalBlock(scope: !378, file: !225, line: 92, column: 5)
!386 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !387, line: 18, baseType: !243)
!387 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!388 = !DILocation(line: 0, scope: !378)
!389 = !DILocation(line: 0, scope: !385)
!390 = !DILocation(line: 92, column: 10, scope: !385)
!391 = !DILocation(line: 92, column: 5, scope: !385)
!392 = !DILocation(line: 105, column: 1, scope: !378)
!393 = !DILocation(line: 94, column: 21, scope: !394)
!394 = distinct !DILexicalBlock(scope: !395, file: !225, line: 93, column: 5)
!395 = distinct !DILexicalBlock(scope: !385, file: !225, line: 92, column: 5)
!396 = !DILocation(line: 94, column: 18, scope: !394)
!397 = !DILocation(line: 94, column: 9, scope: !394)
!398 = !DILocation(line: 94, column: 16, scope: !394)
!399 = !DILocation(line: 92, column: 32, scope: !395)
!400 = !DILocation(line: 92, column: 26, scope: !395)
!401 = distinct !{!401, !391, !402, !370, !371}
!402 = !DILocation(line: 95, column: 5, scope: !385)
!403 = distinct !DISubprogram(name: "loady8", scope: !225, file: !225, line: 107, type: !325, scopeLine: 107, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !224, retainedNodes: !404)
!404 = !{!405, !406, !407, !408, !409}
!405 = !DILocalVariable(name: "a_y", arg: 1, scope: !403, file: !225, line: 107, type: !327)
!406 = !DILocalVariable(name: "x", arg: 2, scope: !403, file: !225, line: 107, type: !327)
!407 = !DILocalVariable(name: "offset", arg: 3, scope: !403, file: !225, line: 107, type: !202)
!408 = !DILocalVariable(name: "sx", arg: 4, scope: !403, file: !225, line: 107, type: !202)
!409 = !DILocalVariable(name: "i", scope: !410, file: !225, line: 108, type: !386)
!410 = distinct !DILexicalBlock(scope: !403, file: !225, line: 108, column: 5)
!411 = !DILocation(line: 0, scope: !403)
!412 = !DILocation(line: 0, scope: !410)
!413 = !DILocation(line: 108, column: 10, scope: !410)
!414 = !DILocation(line: 108, column: 5, scope: !410)
!415 = !DILocation(line: 120, column: 1, scope: !403)
!416 = !DILocation(line: 110, column: 21, scope: !417)
!417 = distinct !DILexicalBlock(scope: !418, file: !225, line: 109, column: 5)
!418 = distinct !DILexicalBlock(scope: !410, file: !225, line: 108, column: 5)
!419 = !DILocation(line: 110, column: 18, scope: !417)
!420 = !DILocation(line: 110, column: 9, scope: !417)
!421 = !DILocation(line: 110, column: 16, scope: !417)
!422 = !DILocation(line: 108, column: 32, scope: !418)
!423 = !DILocation(line: 108, column: 26, scope: !418)
!424 = distinct !{!424, !414, !425, !370, !371}
!425 = !DILocation(line: 111, column: 5, scope: !410)
!426 = distinct !DISubprogram(name: "fft", scope: !225, file: !225, line: 122, type: !427, scopeLine: 122, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !224, retainedNodes: !429)
!427 = !DISubroutineType(types: !428)
!428 = !{null, !327, !327}
!429 = !{!430, !431, !432, !433, !434, !435, !436, !437, !438, !439, !441, !442, !446, !447, !452, !454, !455, !456, !457, !458, !459, !460, !462, !463, !465, !466, !468, !469, !471, !472, !474, !475, !476, !478, !479, !481, !482, !484, !485, !487, !488, !490, !491, !492, !494, !495, !497, !498, !500, !501, !503, !504, !506, !507, !508, !509, !510, !511, !512, !517, !519, !520, !525, !527, !529, !530, !531, !532, !533, !534, !535, !537, !538, !540, !541, !543, !544, !546, !547, !549, !550, !551, !553, !554, !556, !557, !559, !560, !562, !563, !565, !566, !567, !569, !570, !572, !573, !575, !576, !578, !579, !581, !582, !583, !584, !585, !590, !592, !593, !598, !600, !601, !602, !603, !604, !605, !606, !608, !609, !611, !612, !614, !615, !617, !618, !620, !621, !622, !624, !625, !627, !628, !630, !631, !633, !634, !636, !637, !638, !640, !641, !643, !644, !646, !647, !649, !650}
!430 = !DILocalVariable(name: "work_x", arg: 1, scope: !426, file: !225, line: 122, type: !327)
!431 = !DILocalVariable(name: "work_y", arg: 2, scope: !426, file: !225, line: 122, type: !327)
!432 = !DILocalVariable(name: "tid", scope: !426, file: !225, line: 123, type: !202)
!433 = !DILocalVariable(name: "hi", scope: !426, file: !225, line: 123, type: !202)
!434 = !DILocalVariable(name: "lo", scope: !426, file: !225, line: 123, type: !202)
!435 = !DILocalVariable(name: "stride", scope: !426, file: !225, line: 123, type: !202)
!436 = !DILocalVariable(name: "reversed", scope: !426, file: !225, line: 124, type: !334)
!437 = !DILocalVariable(name: "DATA_x", scope: !426, file: !225, line: 125, type: !196)
!438 = !DILocalVariable(name: "DATA_y", scope: !426, file: !225, line: 126, type: !196)
!439 = !DILocalVariable(name: "data_x", scope: !426, file: !225, line: 128, type: !440)
!440 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 512, elements: !335)
!441 = !DILocalVariable(name: "data_y", scope: !426, file: !225, line: 129, type: !440)
!442 = !DILocalVariable(name: "smem", scope: !426, file: !225, line: 131, type: !443)
!443 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 36864, elements: !444)
!444 = !{!445}
!445 = !DISubrange(count: 576)
!446 = !DILabel(scope: !426, name: "loop1", file: !225, line: 136)
!447 = !DILocalVariable(name: "i", scope: !448, file: !225, line: 138, type: !386)
!448 = distinct !DILexicalBlock(scope: !449, file: !225, line: 138, column: 13)
!449 = distinct !DILexicalBlock(scope: !450, file: !225, line: 136, column: 43)
!450 = distinct !DILexicalBlock(scope: !451, file: !225, line: 136, column: 9)
!451 = distinct !DILexicalBlock(scope: !426, file: !225, line: 136, column: 9)
!452 = !DILocalVariable(name: "exp_1_8_x", scope: !453, file: !225, line: 162, type: !197)
!453 = distinct !DILexicalBlock(scope: !449, file: !225, line: 162, column: 13)
!454 = !DILocalVariable(name: "exp_1_4_x", scope: !453, file: !225, line: 162, type: !197)
!455 = !DILocalVariable(name: "exp_3_8_x", scope: !453, file: !225, line: 162, type: !197)
!456 = !DILocalVariable(name: "exp_1_8_y", scope: !453, file: !225, line: 162, type: !197)
!457 = !DILocalVariable(name: "exp_1_4_y", scope: !453, file: !225, line: 162, type: !197)
!458 = !DILocalVariable(name: "exp_3_8_y", scope: !453, file: !225, line: 162, type: !197)
!459 = !DILocalVariable(name: "tmp_1", scope: !453, file: !225, line: 162, type: !197)
!460 = !DILocalVariable(name: "c0_x", scope: !461, file: !225, line: 162, type: !197)
!461 = distinct !DILexicalBlock(scope: !453, file: !225, line: 162, column: 13)
!462 = !DILocalVariable(name: "c0_y", scope: !461, file: !225, line: 162, type: !197)
!463 = !DILocalVariable(name: "c0_x", scope: !464, file: !225, line: 162, type: !197)
!464 = distinct !DILexicalBlock(scope: !453, file: !225, line: 162, column: 13)
!465 = !DILocalVariable(name: "c0_y", scope: !464, file: !225, line: 162, type: !197)
!466 = !DILocalVariable(name: "c0_x", scope: !467, file: !225, line: 162, type: !197)
!467 = distinct !DILexicalBlock(scope: !453, file: !225, line: 162, column: 13)
!468 = !DILocalVariable(name: "c0_y", scope: !467, file: !225, line: 162, type: !197)
!469 = !DILocalVariable(name: "c0_x", scope: !470, file: !225, line: 162, type: !197)
!470 = distinct !DILexicalBlock(scope: !453, file: !225, line: 162, column: 13)
!471 = !DILocalVariable(name: "c0_y", scope: !470, file: !225, line: 162, type: !197)
!472 = !DILocalVariable(name: "exp_1_44_x", scope: !473, file: !225, line: 162, type: !197)
!473 = distinct !DILexicalBlock(scope: !453, file: !225, line: 162, column: 13)
!474 = !DILocalVariable(name: "exp_1_44_y", scope: !473, file: !225, line: 162, type: !197)
!475 = !DILocalVariable(name: "tmp", scope: !473, file: !225, line: 162, type: !197)
!476 = !DILocalVariable(name: "c0_x", scope: !477, file: !225, line: 162, type: !197)
!477 = distinct !DILexicalBlock(scope: !473, file: !225, line: 162, column: 13)
!478 = !DILocalVariable(name: "c0_y", scope: !477, file: !225, line: 162, type: !197)
!479 = !DILocalVariable(name: "c0_x", scope: !480, file: !225, line: 162, type: !197)
!480 = distinct !DILexicalBlock(scope: !473, file: !225, line: 162, column: 13)
!481 = !DILocalVariable(name: "c0_y", scope: !480, file: !225, line: 162, type: !197)
!482 = !DILocalVariable(name: "c0_x", scope: !483, file: !225, line: 162, type: !197)
!483 = distinct !DILexicalBlock(scope: !473, file: !225, line: 162, column: 13)
!484 = !DILocalVariable(name: "c0_y", scope: !483, file: !225, line: 162, type: !197)
!485 = !DILocalVariable(name: "c0_x", scope: !486, file: !225, line: 162, type: !197)
!486 = distinct !DILexicalBlock(scope: !473, file: !225, line: 162, column: 13)
!487 = !DILocalVariable(name: "c0_y", scope: !486, file: !225, line: 162, type: !197)
!488 = !DILocalVariable(name: "exp_1_44_x", scope: !489, file: !225, line: 162, type: !197)
!489 = distinct !DILexicalBlock(scope: !453, file: !225, line: 162, column: 13)
!490 = !DILocalVariable(name: "exp_1_44_y", scope: !489, file: !225, line: 162, type: !197)
!491 = !DILocalVariable(name: "tmp", scope: !489, file: !225, line: 162, type: !197)
!492 = !DILocalVariable(name: "c0_x", scope: !493, file: !225, line: 162, type: !197)
!493 = distinct !DILexicalBlock(scope: !489, file: !225, line: 162, column: 13)
!494 = !DILocalVariable(name: "c0_y", scope: !493, file: !225, line: 162, type: !197)
!495 = !DILocalVariable(name: "c0_x", scope: !496, file: !225, line: 162, type: !197)
!496 = distinct !DILexicalBlock(scope: !489, file: !225, line: 162, column: 13)
!497 = !DILocalVariable(name: "c0_y", scope: !496, file: !225, line: 162, type: !197)
!498 = !DILocalVariable(name: "c0_x", scope: !499, file: !225, line: 162, type: !197)
!499 = distinct !DILexicalBlock(scope: !489, file: !225, line: 162, column: 13)
!500 = !DILocalVariable(name: "c0_y", scope: !499, file: !225, line: 162, type: !197)
!501 = !DILocalVariable(name: "c0_x", scope: !502, file: !225, line: 162, type: !197)
!502 = distinct !DILexicalBlock(scope: !489, file: !225, line: 162, column: 13)
!503 = !DILocalVariable(name: "c0_y", scope: !502, file: !225, line: 162, type: !197)
!504 = !DILocalVariable(name: "i", scope: !505, file: !225, line: 168, type: !386)
!505 = distinct !DILexicalBlock(scope: !449, file: !225, line: 168, column: 13)
!506 = !DILocalVariable(name: "sx", scope: !426, file: !225, line: 190, type: !202)
!507 = !DILocalVariable(name: "offset", scope: !426, file: !225, line: 190, type: !202)
!508 = !DILabel(scope: !426, name: "loop2", file: !225, line: 192)
!509 = !DILabel(scope: !426, name: "loop3", file: !225, line: 206)
!510 = !DILabel(scope: !426, name: "loop4", file: !225, line: 222)
!511 = !DILabel(scope: !426, name: "loop5", file: !225, line: 237)
!512 = !DILocalVariable(name: "i", scope: !513, file: !225, line: 238, type: !386)
!513 = distinct !DILexicalBlock(scope: !514, file: !225, line: 238, column: 13)
!514 = distinct !DILexicalBlock(scope: !515, file: !225, line: 237, column: 38)
!515 = distinct !DILexicalBlock(scope: !516, file: !225, line: 237, column: 9)
!516 = distinct !DILexicalBlock(scope: !426, file: !225, line: 237, column: 9)
!517 = !DILocalVariable(name: "i", scope: !518, file: !225, line: 255, type: !386)
!518 = distinct !DILexicalBlock(scope: !514, file: !225, line: 255, column: 13)
!519 = !DILabel(scope: !426, name: "loop6", file: !225, line: 269)
!520 = !DILocalVariable(name: "i", scope: !521, file: !225, line: 271, type: !386)
!521 = distinct !DILexicalBlock(scope: !522, file: !225, line: 271, column: 13)
!522 = distinct !DILexicalBlock(scope: !523, file: !225, line: 269, column: 38)
!523 = distinct !DILexicalBlock(scope: !524, file: !225, line: 269, column: 9)
!524 = distinct !DILexicalBlock(scope: !426, file: !225, line: 269, column: 9)
!525 = !DILocalVariable(name: "i", scope: !526, file: !225, line: 284, type: !386)
!526 = distinct !DILexicalBlock(scope: !522, file: !225, line: 284, column: 13)
!527 = !DILocalVariable(name: "exp_1_8_x", scope: !528, file: !225, line: 298, type: !197)
!528 = distinct !DILexicalBlock(scope: !522, file: !225, line: 298, column: 13)
!529 = !DILocalVariable(name: "exp_1_4_x", scope: !528, file: !225, line: 298, type: !197)
!530 = !DILocalVariable(name: "exp_3_8_x", scope: !528, file: !225, line: 298, type: !197)
!531 = !DILocalVariable(name: "exp_1_8_y", scope: !528, file: !225, line: 298, type: !197)
!532 = !DILocalVariable(name: "exp_1_4_y", scope: !528, file: !225, line: 298, type: !197)
!533 = !DILocalVariable(name: "exp_3_8_y", scope: !528, file: !225, line: 298, type: !197)
!534 = !DILocalVariable(name: "tmp_1", scope: !528, file: !225, line: 298, type: !197)
!535 = !DILocalVariable(name: "c0_x", scope: !536, file: !225, line: 298, type: !197)
!536 = distinct !DILexicalBlock(scope: !528, file: !225, line: 298, column: 13)
!537 = !DILocalVariable(name: "c0_y", scope: !536, file: !225, line: 298, type: !197)
!538 = !DILocalVariable(name: "c0_x", scope: !539, file: !225, line: 298, type: !197)
!539 = distinct !DILexicalBlock(scope: !528, file: !225, line: 298, column: 13)
!540 = !DILocalVariable(name: "c0_y", scope: !539, file: !225, line: 298, type: !197)
!541 = !DILocalVariable(name: "c0_x", scope: !542, file: !225, line: 298, type: !197)
!542 = distinct !DILexicalBlock(scope: !528, file: !225, line: 298, column: 13)
!543 = !DILocalVariable(name: "c0_y", scope: !542, file: !225, line: 298, type: !197)
!544 = !DILocalVariable(name: "c0_x", scope: !545, file: !225, line: 298, type: !197)
!545 = distinct !DILexicalBlock(scope: !528, file: !225, line: 298, column: 13)
!546 = !DILocalVariable(name: "c0_y", scope: !545, file: !225, line: 298, type: !197)
!547 = !DILocalVariable(name: "exp_1_44_x", scope: !548, file: !225, line: 298, type: !197)
!548 = distinct !DILexicalBlock(scope: !528, file: !225, line: 298, column: 13)
!549 = !DILocalVariable(name: "exp_1_44_y", scope: !548, file: !225, line: 298, type: !197)
!550 = !DILocalVariable(name: "tmp", scope: !548, file: !225, line: 298, type: !197)
!551 = !DILocalVariable(name: "c0_x", scope: !552, file: !225, line: 298, type: !197)
!552 = distinct !DILexicalBlock(scope: !548, file: !225, line: 298, column: 13)
!553 = !DILocalVariable(name: "c0_y", scope: !552, file: !225, line: 298, type: !197)
!554 = !DILocalVariable(name: "c0_x", scope: !555, file: !225, line: 298, type: !197)
!555 = distinct !DILexicalBlock(scope: !548, file: !225, line: 298, column: 13)
!556 = !DILocalVariable(name: "c0_y", scope: !555, file: !225, line: 298, type: !197)
!557 = !DILocalVariable(name: "c0_x", scope: !558, file: !225, line: 298, type: !197)
!558 = distinct !DILexicalBlock(scope: !548, file: !225, line: 298, column: 13)
!559 = !DILocalVariable(name: "c0_y", scope: !558, file: !225, line: 298, type: !197)
!560 = !DILocalVariable(name: "c0_x", scope: !561, file: !225, line: 298, type: !197)
!561 = distinct !DILexicalBlock(scope: !548, file: !225, line: 298, column: 13)
!562 = !DILocalVariable(name: "c0_y", scope: !561, file: !225, line: 298, type: !197)
!563 = !DILocalVariable(name: "exp_1_44_x", scope: !564, file: !225, line: 298, type: !197)
!564 = distinct !DILexicalBlock(scope: !528, file: !225, line: 298, column: 13)
!565 = !DILocalVariable(name: "exp_1_44_y", scope: !564, file: !225, line: 298, type: !197)
!566 = !DILocalVariable(name: "tmp", scope: !564, file: !225, line: 298, type: !197)
!567 = !DILocalVariable(name: "c0_x", scope: !568, file: !225, line: 298, type: !197)
!568 = distinct !DILexicalBlock(scope: !564, file: !225, line: 298, column: 13)
!569 = !DILocalVariable(name: "c0_y", scope: !568, file: !225, line: 298, type: !197)
!570 = !DILocalVariable(name: "c0_x", scope: !571, file: !225, line: 298, type: !197)
!571 = distinct !DILexicalBlock(scope: !564, file: !225, line: 298, column: 13)
!572 = !DILocalVariable(name: "c0_y", scope: !571, file: !225, line: 298, type: !197)
!573 = !DILocalVariable(name: "c0_x", scope: !574, file: !225, line: 298, type: !197)
!574 = distinct !DILexicalBlock(scope: !564, file: !225, line: 298, column: 13)
!575 = !DILocalVariable(name: "c0_y", scope: !574, file: !225, line: 298, type: !197)
!576 = !DILocalVariable(name: "c0_x", scope: !577, file: !225, line: 298, type: !197)
!577 = distinct !DILexicalBlock(scope: !564, file: !225, line: 298, column: 13)
!578 = !DILocalVariable(name: "c0_y", scope: !577, file: !225, line: 298, type: !197)
!579 = !DILocalVariable(name: "i", scope: !580, file: !225, line: 307, type: !386)
!580 = distinct !DILexicalBlock(scope: !522, file: !225, line: 307, column: 13)
!581 = !DILabel(scope: !426, name: "loop7", file: !225, line: 333)
!582 = !DILabel(scope: !426, name: "loop8", file: !225, line: 348)
!583 = !DILabel(scope: !426, name: "loop9", file: !225, line: 364)
!584 = !DILabel(scope: !426, name: "loop10", file: !225, line: 379)
!585 = !DILocalVariable(name: "i", scope: !586, file: !225, line: 381, type: !386)
!586 = distinct !DILexicalBlock(scope: !587, file: !225, line: 381, column: 13)
!587 = distinct !DILexicalBlock(scope: !588, file: !225, line: 379, column: 39)
!588 = distinct !DILexicalBlock(scope: !589, file: !225, line: 379, column: 10)
!589 = distinct !DILexicalBlock(scope: !426, file: !225, line: 379, column: 10)
!590 = !DILocalVariable(name: "i", scope: !591, file: !225, line: 398, type: !386)
!591 = distinct !DILexicalBlock(scope: !587, file: !225, line: 398, column: 14)
!592 = !DILabel(scope: !426, name: "loop11", file: !225, line: 412)
!593 = !DILocalVariable(name: "i", scope: !594, file: !225, line: 414, type: !386)
!594 = distinct !DILexicalBlock(scope: !595, file: !225, line: 414, column: 14)
!595 = distinct !DILexicalBlock(scope: !596, file: !225, line: 412, column: 39)
!596 = distinct !DILexicalBlock(scope: !597, file: !225, line: 412, column: 10)
!597 = distinct !DILexicalBlock(scope: !426, file: !225, line: 412, column: 10)
!598 = !DILocalVariable(name: "exp_1_8_x", scope: !599, file: !225, line: 438, type: !197)
!599 = distinct !DILexicalBlock(scope: !595, file: !225, line: 438, column: 14)
!600 = !DILocalVariable(name: "exp_1_4_x", scope: !599, file: !225, line: 438, type: !197)
!601 = !DILocalVariable(name: "exp_3_8_x", scope: !599, file: !225, line: 438, type: !197)
!602 = !DILocalVariable(name: "exp_1_8_y", scope: !599, file: !225, line: 438, type: !197)
!603 = !DILocalVariable(name: "exp_1_4_y", scope: !599, file: !225, line: 438, type: !197)
!604 = !DILocalVariable(name: "exp_3_8_y", scope: !599, file: !225, line: 438, type: !197)
!605 = !DILocalVariable(name: "tmp_1", scope: !599, file: !225, line: 438, type: !197)
!606 = !DILocalVariable(name: "c0_x", scope: !607, file: !225, line: 438, type: !197)
!607 = distinct !DILexicalBlock(scope: !599, file: !225, line: 438, column: 14)
!608 = !DILocalVariable(name: "c0_y", scope: !607, file: !225, line: 438, type: !197)
!609 = !DILocalVariable(name: "c0_x", scope: !610, file: !225, line: 438, type: !197)
!610 = distinct !DILexicalBlock(scope: !599, file: !225, line: 438, column: 14)
!611 = !DILocalVariable(name: "c0_y", scope: !610, file: !225, line: 438, type: !197)
!612 = !DILocalVariable(name: "c0_x", scope: !613, file: !225, line: 438, type: !197)
!613 = distinct !DILexicalBlock(scope: !599, file: !225, line: 438, column: 14)
!614 = !DILocalVariable(name: "c0_y", scope: !613, file: !225, line: 438, type: !197)
!615 = !DILocalVariable(name: "c0_x", scope: !616, file: !225, line: 438, type: !197)
!616 = distinct !DILexicalBlock(scope: !599, file: !225, line: 438, column: 14)
!617 = !DILocalVariable(name: "c0_y", scope: !616, file: !225, line: 438, type: !197)
!618 = !DILocalVariable(name: "exp_1_44_x", scope: !619, file: !225, line: 438, type: !197)
!619 = distinct !DILexicalBlock(scope: !599, file: !225, line: 438, column: 14)
!620 = !DILocalVariable(name: "exp_1_44_y", scope: !619, file: !225, line: 438, type: !197)
!621 = !DILocalVariable(name: "tmp", scope: !619, file: !225, line: 438, type: !197)
!622 = !DILocalVariable(name: "c0_x", scope: !623, file: !225, line: 438, type: !197)
!623 = distinct !DILexicalBlock(scope: !619, file: !225, line: 438, column: 14)
!624 = !DILocalVariable(name: "c0_y", scope: !623, file: !225, line: 438, type: !197)
!625 = !DILocalVariable(name: "c0_x", scope: !626, file: !225, line: 438, type: !197)
!626 = distinct !DILexicalBlock(scope: !619, file: !225, line: 438, column: 14)
!627 = !DILocalVariable(name: "c0_y", scope: !626, file: !225, line: 438, type: !197)
!628 = !DILocalVariable(name: "c0_x", scope: !629, file: !225, line: 438, type: !197)
!629 = distinct !DILexicalBlock(scope: !619, file: !225, line: 438, column: 14)
!630 = !DILocalVariable(name: "c0_y", scope: !629, file: !225, line: 438, type: !197)
!631 = !DILocalVariable(name: "c0_x", scope: !632, file: !225, line: 438, type: !197)
!632 = distinct !DILexicalBlock(scope: !619, file: !225, line: 438, column: 14)
!633 = !DILocalVariable(name: "c0_y", scope: !632, file: !225, line: 438, type: !197)
!634 = !DILocalVariable(name: "exp_1_44_x", scope: !635, file: !225, line: 438, type: !197)
!635 = distinct !DILexicalBlock(scope: !599, file: !225, line: 438, column: 14)
!636 = !DILocalVariable(name: "exp_1_44_y", scope: !635, file: !225, line: 438, type: !197)
!637 = !DILocalVariable(name: "tmp", scope: !635, file: !225, line: 438, type: !197)
!638 = !DILocalVariable(name: "c0_x", scope: !639, file: !225, line: 438, type: !197)
!639 = distinct !DILexicalBlock(scope: !635, file: !225, line: 438, column: 14)
!640 = !DILocalVariable(name: "c0_y", scope: !639, file: !225, line: 438, type: !197)
!641 = !DILocalVariable(name: "c0_x", scope: !642, file: !225, line: 438, type: !197)
!642 = distinct !DILexicalBlock(scope: !635, file: !225, line: 438, column: 14)
!643 = !DILocalVariable(name: "c0_y", scope: !642, file: !225, line: 438, type: !197)
!644 = !DILocalVariable(name: "c0_x", scope: !645, file: !225, line: 438, type: !197)
!645 = distinct !DILexicalBlock(scope: !635, file: !225, line: 438, column: 14)
!646 = !DILocalVariable(name: "c0_y", scope: !645, file: !225, line: 438, type: !197)
!647 = !DILocalVariable(name: "c0_x", scope: !648, file: !225, line: 438, type: !197)
!648 = distinct !DILexicalBlock(scope: !635, file: !225, line: 438, column: 14)
!649 = !DILocalVariable(name: "c0_y", scope: !648, file: !225, line: 438, type: !197)
!650 = !DILocalVariable(name: "i", scope: !651, file: !225, line: 441, type: !386)
!651 = distinct !DILexicalBlock(scope: !595, file: !225, line: 441, column: 14)
!652 = distinct !DIAssignID()
!653 = !DILocation(line: 0, scope: !426)
!654 = distinct !DIAssignID()
!655 = distinct !DIAssignID()
!656 = distinct !DIAssignID()
!657 = distinct !DIAssignID()
!658 = !DILocation(line: 125, column: 5, scope: !426)
!659 = !DILocation(line: 126, column: 5, scope: !426)
!660 = !DILocation(line: 128, column: 5, scope: !426)
!661 = !DILocation(line: 129, column: 5, scope: !426)
!662 = !DILocation(line: 131, column: 5, scope: !426)
!663 = !DILocation(line: 136, column: 1, scope: !426)
!664 = !DILocation(line: 136, column: 9, scope: !451)
!665 = !DILocation(line: 0, scope: !448)
!666 = !DILocation(line: 138, column: 13, scope: !448)
!667 = !DILocation(line: 0, scope: !453)
!668 = !DILocation(line: 162, column: 13, scope: !461)
!669 = !DILocation(line: 0, scope: !461)
!670 = distinct !DIAssignID()
!671 = distinct !DIAssignID()
!672 = distinct !DIAssignID()
!673 = distinct !DIAssignID()
!674 = !DILocation(line: 162, column: 13, scope: !464)
!675 = !DILocation(line: 0, scope: !464)
!676 = distinct !DIAssignID()
!677 = distinct !DIAssignID()
!678 = distinct !DIAssignID()
!679 = distinct !DIAssignID()
!680 = !DILocation(line: 162, column: 13, scope: !467)
!681 = !DILocation(line: 0, scope: !467)
!682 = distinct !DIAssignID()
!683 = distinct !DIAssignID()
!684 = distinct !DIAssignID()
!685 = distinct !DIAssignID()
!686 = !DILocation(line: 162, column: 13, scope: !470)
!687 = !DILocation(line: 0, scope: !470)
!688 = distinct !DIAssignID()
!689 = distinct !DIAssignID()
!690 = distinct !DIAssignID()
!691 = distinct !DIAssignID()
!692 = !DILocation(line: 162, column: 13, scope: !453)
!693 = distinct !DIAssignID()
!694 = distinct !DIAssignID()
!695 = distinct !DIAssignID()
!696 = distinct !DIAssignID()
!697 = distinct !DIAssignID()
!698 = distinct !DIAssignID()
!699 = !DILocation(line: 0, scope: !473)
!700 = !DILocation(line: 0, scope: !477)
!701 = !DILocation(line: 162, column: 13, scope: !477)
!702 = distinct !DIAssignID()
!703 = distinct !DIAssignID()
!704 = distinct !DIAssignID()
!705 = distinct !DIAssignID()
!706 = !DILocation(line: 0, scope: !480)
!707 = !DILocation(line: 162, column: 13, scope: !480)
!708 = distinct !DIAssignID()
!709 = distinct !DIAssignID()
!710 = distinct !DIAssignID()
!711 = distinct !DIAssignID()
!712 = !DILocation(line: 162, column: 13, scope: !473)
!713 = distinct !DIAssignID()
!714 = distinct !DIAssignID()
!715 = !DILocation(line: 0, scope: !483)
!716 = !DILocation(line: 162, column: 13, scope: !483)
!717 = distinct !DIAssignID()
!718 = distinct !DIAssignID()
!719 = distinct !DIAssignID()
!720 = distinct !DIAssignID()
!721 = !DILocation(line: 0, scope: !486)
!722 = !DILocation(line: 162, column: 13, scope: !486)
!723 = distinct !DIAssignID()
!724 = distinct !DIAssignID()
!725 = distinct !DIAssignID()
!726 = distinct !DIAssignID()
!727 = !DILocation(line: 0, scope: !489)
!728 = !DILocation(line: 0, scope: !493)
!729 = !DILocation(line: 162, column: 13, scope: !493)
!730 = distinct !DIAssignID()
!731 = distinct !DIAssignID()
!732 = distinct !DIAssignID()
!733 = distinct !DIAssignID()
!734 = !DILocation(line: 0, scope: !496)
!735 = !DILocation(line: 162, column: 13, scope: !496)
!736 = distinct !DIAssignID()
!737 = distinct !DIAssignID()
!738 = distinct !DIAssignID()
!739 = distinct !DIAssignID()
!740 = !DILocation(line: 162, column: 13, scope: !489)
!741 = distinct !DIAssignID()
!742 = distinct !DIAssignID()
!743 = !DILocation(line: 0, scope: !499)
!744 = !DILocation(line: 162, column: 13, scope: !499)
!745 = distinct !DIAssignID()
!746 = distinct !DIAssignID()
!747 = distinct !DIAssignID()
!748 = distinct !DIAssignID()
!749 = !DILocation(line: 0, scope: !502)
!750 = !DILocation(line: 162, column: 13, scope: !502)
!751 = distinct !DIAssignID()
!752 = distinct !DIAssignID()
!753 = distinct !DIAssignID()
!754 = distinct !DIAssignID()
!755 = !DILocation(line: 0, scope: !324, inlinedAt: !756)
!756 = distinct !DILocation(line: 165, column: 13, scope: !449)
!757 = distinct !DIAssignID()
!758 = !DILocation(line: 28, column: 5, scope: !324, inlinedAt: !756)
!759 = !DILocation(line: 28, column: 14, scope: !346, inlinedAt: !756)
!760 = !DILocation(line: 29, column: 23, scope: !348, inlinedAt: !756)
!761 = !DILocation(line: 29, column: 22, scope: !348, inlinedAt: !756)
!762 = !DILocation(line: 29, column: 35, scope: !348, inlinedAt: !756)
!763 = !DILocation(line: 29, column: 38, scope: !348, inlinedAt: !756)
!764 = !DILocation(line: 30, column: 17, scope: !348, inlinedAt: !756)
!765 = !DILocation(line: 31, column: 17, scope: !348, inlinedAt: !756)
!766 = !DILocation(line: 32, column: 15, scope: !348, inlinedAt: !756)
!767 = !DILocation(line: 33, column: 18, scope: !348, inlinedAt: !756)
!768 = !DILocation(line: 33, column: 16, scope: !348, inlinedAt: !756)
!769 = !DILocation(line: 34, column: 18, scope: !348, inlinedAt: !756)
!770 = !DILocation(line: 34, column: 16, scope: !348, inlinedAt: !756)
!771 = !DILocation(line: 28, column: 31, scope: !349, inlinedAt: !756)
!772 = !DILocation(line: 28, column: 25, scope: !349, inlinedAt: !756)
!773 = distinct !{!773, !759, !774, !370, !371}
!774 = !DILocation(line: 35, column: 5, scope: !346, inlinedAt: !756)
!775 = !DILocation(line: 0, scope: !505)
!776 = !DILocation(line: 169, column: 35, scope: !777)
!777 = distinct !DILexicalBlock(scope: !778, file: !225, line: 168, column: 43)
!778 = distinct !DILexicalBlock(scope: !505, file: !225, line: 168, column: 13)
!779 = !DILocation(line: 170, column: 35, scope: !777)
!780 = !DILocation(line: 136, column: 40, scope: !450)
!781 = !DILocation(line: 136, column: 26, scope: !450)
!782 = distinct !{!782, !664, !783, !370, !371}
!783 = !DILocation(line: 189, column: 9, scope: !451)
!784 = !DILocation(line: 139, column: 37, scope: !785)
!785 = distinct !DILexicalBlock(scope: !786, file: !225, line: 138, column: 43)
!786 = distinct !DILexicalBlock(scope: !448, file: !225, line: 138, column: 13)
!787 = !DILocation(line: 139, column: 44, scope: !785)
!788 = !DILocation(line: 139, column: 29, scope: !785)
!789 = !DILocation(line: 139, column: 17, scope: !785)
!790 = !DILocation(line: 139, column: 27, scope: !785)
!791 = !DILocation(line: 140, column: 29, scope: !785)
!792 = !DILocation(line: 140, column: 17, scope: !785)
!793 = !DILocation(line: 140, column: 27, scope: !785)
!794 = !DILocation(line: 138, column: 40, scope: !786)
!795 = !DILocation(line: 138, column: 34, scope: !786)
!796 = distinct !{!796, !666, !797, !370, !371}
!797 = !DILocation(line: 141, column: 13, scope: !448)
!798 = !DILocation(line: 196, column: 43, scope: !799)
!799 = distinct !DILexicalBlock(scope: !800, file: !225, line: 192, column: 38)
!800 = distinct !DILexicalBlock(scope: !801, file: !225, line: 192, column: 9)
!801 = distinct !DILexicalBlock(scope: !426, file: !225, line: 192, column: 9)
!802 = !DILocation(line: 196, column: 33, scope: !799)
!803 = !DILocation(line: 196, column: 13, scope: !799)
!804 = !DILocation(line: 196, column: 31, scope: !799)
!805 = !DILocation(line: 197, column: 46, scope: !799)
!806 = !DILocation(line: 197, column: 33, scope: !799)
!807 = !DILocation(line: 197, column: 22, scope: !799)
!808 = !DILocation(line: 197, column: 13, scope: !799)
!809 = !DILocation(line: 197, column: 31, scope: !799)
!810 = !DILocation(line: 198, column: 46, scope: !799)
!811 = !DILocation(line: 198, column: 33, scope: !799)
!812 = !DILocation(line: 198, column: 22, scope: !799)
!813 = !DILocation(line: 198, column: 13, scope: !799)
!814 = !DILocation(line: 198, column: 31, scope: !799)
!815 = !DILocation(line: 199, column: 46, scope: !799)
!816 = !DILocation(line: 199, column: 33, scope: !799)
!817 = !DILocation(line: 199, column: 22, scope: !799)
!818 = !DILocation(line: 199, column: 13, scope: !799)
!819 = !DILocation(line: 199, column: 31, scope: !799)
!820 = !DILocation(line: 200, column: 46, scope: !799)
!821 = !DILocation(line: 200, column: 33, scope: !799)
!822 = !DILocation(line: 200, column: 22, scope: !799)
!823 = !DILocation(line: 200, column: 13, scope: !799)
!824 = !DILocation(line: 200, column: 31, scope: !799)
!825 = !DILocation(line: 201, column: 46, scope: !799)
!826 = !DILocation(line: 201, column: 33, scope: !799)
!827 = !DILocation(line: 201, column: 22, scope: !799)
!828 = !DILocation(line: 201, column: 13, scope: !799)
!829 = !DILocation(line: 201, column: 31, scope: !799)
!830 = !DILocation(line: 202, column: 46, scope: !799)
!831 = !DILocation(line: 202, column: 33, scope: !799)
!832 = !DILocation(line: 202, column: 22, scope: !799)
!833 = !DILocation(line: 202, column: 13, scope: !799)
!834 = !DILocation(line: 202, column: 31, scope: !799)
!835 = !DILocation(line: 203, column: 46, scope: !799)
!836 = !DILocation(line: 203, column: 33, scope: !799)
!837 = !DILocation(line: 203, column: 22, scope: !799)
!838 = !DILocation(line: 203, column: 13, scope: !799)
!839 = !DILocation(line: 203, column: 31, scope: !799)
!840 = !DILocation(line: 192, column: 35, scope: !800)
!841 = !DILocation(line: 192, column: 26, scope: !800)
!842 = !DILocation(line: 192, column: 9, scope: !801)
!843 = distinct !{!843, !842, !844, !370, !371}
!844 = !DILocation(line: 204, column: 9, scope: !801)
!845 = !DILocation(line: 207, column: 21, scope: !846)
!846 = distinct !DILexicalBlock(scope: !847, file: !225, line: 206, column: 38)
!847 = distinct !DILexicalBlock(scope: !848, file: !225, line: 206, column: 9)
!848 = distinct !DILexicalBlock(scope: !426, file: !225, line: 206, column: 9)
!849 = !DILocation(line: 208, column: 21, scope: !846)
!850 = !DILocation(line: 209, column: 24, scope: !846)
!851 = !DILocation(line: 209, column: 27, scope: !846)
!852 = !DILocation(line: 211, column: 32, scope: !846)
!853 = !DILocation(line: 211, column: 23, scope: !846)
!854 = !DILocation(line: 211, column: 13, scope: !846)
!855 = !DILocation(line: 211, column: 30, scope: !846)
!856 = !DILocation(line: 212, column: 41, scope: !846)
!857 = !DILocation(line: 212, column: 32, scope: !846)
!858 = !DILocation(line: 212, column: 26, scope: !846)
!859 = !DILocation(line: 212, column: 13, scope: !846)
!860 = !DILocation(line: 212, column: 30, scope: !846)
!861 = !DILocation(line: 213, column: 41, scope: !846)
!862 = !DILocation(line: 213, column: 32, scope: !846)
!863 = !DILocation(line: 213, column: 26, scope: !846)
!864 = !DILocation(line: 213, column: 13, scope: !846)
!865 = !DILocation(line: 213, column: 30, scope: !846)
!866 = !DILocation(line: 214, column: 41, scope: !846)
!867 = !DILocation(line: 214, column: 32, scope: !846)
!868 = !DILocation(line: 214, column: 26, scope: !846)
!869 = !DILocation(line: 214, column: 13, scope: !846)
!870 = !DILocation(line: 214, column: 30, scope: !846)
!871 = !DILocation(line: 215, column: 41, scope: !846)
!872 = !DILocation(line: 215, column: 32, scope: !846)
!873 = !DILocation(line: 215, column: 26, scope: !846)
!874 = !DILocation(line: 215, column: 13, scope: !846)
!875 = !DILocation(line: 215, column: 30, scope: !846)
!876 = !DILocation(line: 216, column: 41, scope: !846)
!877 = !DILocation(line: 216, column: 32, scope: !846)
!878 = !DILocation(line: 216, column: 26, scope: !846)
!879 = !DILocation(line: 216, column: 13, scope: !846)
!880 = !DILocation(line: 216, column: 30, scope: !846)
!881 = !DILocation(line: 217, column: 41, scope: !846)
!882 = !DILocation(line: 217, column: 32, scope: !846)
!883 = !DILocation(line: 217, column: 26, scope: !846)
!884 = !DILocation(line: 217, column: 13, scope: !846)
!885 = !DILocation(line: 217, column: 30, scope: !846)
!886 = !DILocation(line: 218, column: 41, scope: !846)
!887 = !DILocation(line: 218, column: 32, scope: !846)
!888 = !DILocation(line: 218, column: 26, scope: !846)
!889 = !DILocation(line: 218, column: 13, scope: !846)
!890 = !DILocation(line: 218, column: 30, scope: !846)
!891 = !DILocation(line: 206, column: 35, scope: !847)
!892 = !DILocation(line: 206, column: 26, scope: !847)
!893 = !DILocation(line: 206, column: 9, scope: !848)
!894 = distinct !{!894, !893, !895, !370, !371}
!895 = !DILocation(line: 219, column: 9, scope: !848)
!896 = !DILocation(line: 227, column: 43, scope: !897)
!897 = distinct !DILexicalBlock(scope: !898, file: !225, line: 222, column: 38)
!898 = distinct !DILexicalBlock(scope: !899, file: !225, line: 222, column: 9)
!899 = distinct !DILexicalBlock(scope: !426, file: !225, line: 222, column: 9)
!900 = !DILocation(line: 227, column: 33, scope: !897)
!901 = !DILocation(line: 227, column: 13, scope: !897)
!902 = !DILocation(line: 227, column: 31, scope: !897)
!903 = !DILocation(line: 228, column: 46, scope: !897)
!904 = !DILocation(line: 228, column: 33, scope: !897)
!905 = !DILocation(line: 228, column: 22, scope: !897)
!906 = !DILocation(line: 228, column: 13, scope: !897)
!907 = !DILocation(line: 228, column: 31, scope: !897)
!908 = !DILocation(line: 229, column: 46, scope: !897)
!909 = !DILocation(line: 229, column: 33, scope: !897)
!910 = !DILocation(line: 229, column: 22, scope: !897)
!911 = !DILocation(line: 229, column: 13, scope: !897)
!912 = !DILocation(line: 229, column: 31, scope: !897)
!913 = !DILocation(line: 230, column: 46, scope: !897)
!914 = !DILocation(line: 230, column: 33, scope: !897)
!915 = !DILocation(line: 230, column: 22, scope: !897)
!916 = !DILocation(line: 230, column: 13, scope: !897)
!917 = !DILocation(line: 230, column: 31, scope: !897)
!918 = !DILocation(line: 231, column: 46, scope: !897)
!919 = !DILocation(line: 231, column: 33, scope: !897)
!920 = !DILocation(line: 231, column: 22, scope: !897)
!921 = !DILocation(line: 231, column: 13, scope: !897)
!922 = !DILocation(line: 231, column: 31, scope: !897)
!923 = !DILocation(line: 232, column: 46, scope: !897)
!924 = !DILocation(line: 232, column: 33, scope: !897)
!925 = !DILocation(line: 232, column: 22, scope: !897)
!926 = !DILocation(line: 232, column: 13, scope: !897)
!927 = !DILocation(line: 232, column: 31, scope: !897)
!928 = !DILocation(line: 233, column: 46, scope: !897)
!929 = !DILocation(line: 233, column: 33, scope: !897)
!930 = !DILocation(line: 233, column: 22, scope: !897)
!931 = !DILocation(line: 233, column: 13, scope: !897)
!932 = !DILocation(line: 233, column: 31, scope: !897)
!933 = !DILocation(line: 234, column: 46, scope: !897)
!934 = !DILocation(line: 234, column: 33, scope: !897)
!935 = !DILocation(line: 234, column: 22, scope: !897)
!936 = !DILocation(line: 234, column: 13, scope: !897)
!937 = !DILocation(line: 234, column: 31, scope: !897)
!938 = !DILocation(line: 222, column: 35, scope: !898)
!939 = !DILocation(line: 222, column: 26, scope: !898)
!940 = !DILocation(line: 222, column: 9, scope: !899)
!941 = distinct !{!941, !940, !942, !370, !371}
!942 = !DILocation(line: 235, column: 9, scope: !899)
!943 = !DILocation(line: 0, scope: !513)
!944 = !DILocation(line: 239, column: 27, scope: !945)
!945 = distinct !DILexicalBlock(scope: !946, file: !225, line: 238, column: 43)
!946 = distinct !DILexicalBlock(scope: !513, file: !225, line: 238, column: 13)
!947 = !DILocation(line: 250, column: 21, scope: !514)
!948 = !DILocation(line: 251, column: 21, scope: !514)
!949 = !DILocation(line: 253, column: 36, scope: !514)
!950 = !DILocation(line: 253, column: 39, scope: !514)
!951 = !DILocation(line: 0, scope: !403, inlinedAt: !952)
!952 = distinct !DILocation(line: 253, column: 13, scope: !514)
!953 = !DILocation(line: 0, scope: !410, inlinedAt: !952)
!954 = !DILocation(line: 108, column: 10, scope: !410, inlinedAt: !952)
!955 = !DILocation(line: 108, column: 5, scope: !410, inlinedAt: !952)
!956 = !DILocation(line: 110, column: 18, scope: !417, inlinedAt: !952)
!957 = !DILocation(line: 110, column: 9, scope: !417, inlinedAt: !952)
!958 = !DILocation(line: 110, column: 16, scope: !417, inlinedAt: !952)
!959 = !DILocation(line: 108, column: 32, scope: !418, inlinedAt: !952)
!960 = !DILocation(line: 108, column: 26, scope: !418, inlinedAt: !952)
!961 = distinct !{!961, !955, !962, !370, !371}
!962 = !DILocation(line: 111, column: 5, scope: !410, inlinedAt: !952)
!963 = !DILocation(line: 0, scope: !518)
!964 = !DILocation(line: 256, column: 37, scope: !965)
!965 = distinct !DILexicalBlock(scope: !966, file: !225, line: 255, column: 43)
!966 = distinct !DILexicalBlock(scope: !518, file: !225, line: 255, column: 13)
!967 = !DILocation(line: 237, column: 35, scope: !515)
!968 = !DILocation(line: 237, column: 9, scope: !516)
!969 = !DILocation(line: 237, column: 26, scope: !515)
!970 = distinct !{!970, !968, !971, !370, !371}
!971 = !DILocation(line: 267, column: 9, scope: !516)
!972 = !DILocation(line: 0, scope: !521)
!973 = !DILocation(line: 272, column: 27, scope: !974)
!974 = distinct !DILexicalBlock(scope: !975, file: !225, line: 271, column: 43)
!975 = distinct !DILexicalBlock(scope: !521, file: !225, line: 271, column: 13)
!976 = !DILocation(line: 0, scope: !526)
!977 = !DILocation(line: 285, column: 27, scope: !978)
!978 = distinct !DILexicalBlock(scope: !979, file: !225, line: 284, column: 43)
!979 = distinct !DILexicalBlock(scope: !526, file: !225, line: 284, column: 13)
!980 = !DILocation(line: 0, scope: !528)
!981 = !DILocation(line: 298, column: 13, scope: !536)
!982 = !DILocation(line: 0, scope: !536)
!983 = distinct !DIAssignID()
!984 = distinct !DIAssignID()
!985 = distinct !DIAssignID()
!986 = distinct !DIAssignID()
!987 = !DILocation(line: 298, column: 13, scope: !539)
!988 = !DILocation(line: 0, scope: !539)
!989 = distinct !DIAssignID()
!990 = distinct !DIAssignID()
!991 = distinct !DIAssignID()
!992 = distinct !DIAssignID()
!993 = !DILocation(line: 298, column: 13, scope: !542)
!994 = !DILocation(line: 0, scope: !542)
!995 = distinct !DIAssignID()
!996 = distinct !DIAssignID()
!997 = distinct !DIAssignID()
!998 = distinct !DIAssignID()
!999 = !DILocation(line: 298, column: 13, scope: !545)
!1000 = !DILocation(line: 0, scope: !545)
!1001 = distinct !DIAssignID()
!1002 = distinct !DIAssignID()
!1003 = distinct !DIAssignID()
!1004 = distinct !DIAssignID()
!1005 = !DILocation(line: 298, column: 13, scope: !528)
!1006 = distinct !DIAssignID()
!1007 = distinct !DIAssignID()
!1008 = distinct !DIAssignID()
!1009 = distinct !DIAssignID()
!1010 = distinct !DIAssignID()
!1011 = distinct !DIAssignID()
!1012 = !DILocation(line: 0, scope: !548)
!1013 = !DILocation(line: 0, scope: !552)
!1014 = !DILocation(line: 298, column: 13, scope: !552)
!1015 = distinct !DIAssignID()
!1016 = distinct !DIAssignID()
!1017 = distinct !DIAssignID()
!1018 = distinct !DIAssignID()
!1019 = !DILocation(line: 0, scope: !555)
!1020 = !DILocation(line: 298, column: 13, scope: !555)
!1021 = distinct !DIAssignID()
!1022 = distinct !DIAssignID()
!1023 = distinct !DIAssignID()
!1024 = distinct !DIAssignID()
!1025 = !DILocation(line: 298, column: 13, scope: !548)
!1026 = distinct !DIAssignID()
!1027 = distinct !DIAssignID()
!1028 = !DILocation(line: 0, scope: !558)
!1029 = !DILocation(line: 298, column: 13, scope: !558)
!1030 = distinct !DIAssignID()
!1031 = distinct !DIAssignID()
!1032 = distinct !DIAssignID()
!1033 = distinct !DIAssignID()
!1034 = !DILocation(line: 0, scope: !561)
!1035 = !DILocation(line: 298, column: 13, scope: !561)
!1036 = distinct !DIAssignID()
!1037 = distinct !DIAssignID()
!1038 = distinct !DIAssignID()
!1039 = distinct !DIAssignID()
!1040 = !DILocation(line: 0, scope: !564)
!1041 = !DILocation(line: 0, scope: !568)
!1042 = !DILocation(line: 298, column: 13, scope: !568)
!1043 = distinct !DIAssignID()
!1044 = distinct !DIAssignID()
!1045 = distinct !DIAssignID()
!1046 = distinct !DIAssignID()
!1047 = !DILocation(line: 0, scope: !571)
!1048 = !DILocation(line: 298, column: 13, scope: !571)
!1049 = distinct !DIAssignID()
!1050 = distinct !DIAssignID()
!1051 = distinct !DIAssignID()
!1052 = distinct !DIAssignID()
!1053 = !DILocation(line: 298, column: 13, scope: !564)
!1054 = distinct !DIAssignID()
!1055 = distinct !DIAssignID()
!1056 = !DILocation(line: 0, scope: !574)
!1057 = !DILocation(line: 298, column: 13, scope: !574)
!1058 = distinct !DIAssignID()
!1059 = distinct !DIAssignID()
!1060 = distinct !DIAssignID()
!1061 = distinct !DIAssignID()
!1062 = !DILocation(line: 0, scope: !577)
!1063 = !DILocation(line: 298, column: 13, scope: !577)
!1064 = distinct !DIAssignID()
!1065 = distinct !DIAssignID()
!1066 = distinct !DIAssignID()
!1067 = distinct !DIAssignID()
!1068 = !DILocation(line: 301, column: 21, scope: !522)
!1069 = !DILocation(line: 0, scope: !324, inlinedAt: !1070)
!1070 = distinct !DILocation(line: 304, column: 13, scope: !522)
!1071 = distinct !DIAssignID()
!1072 = !DILocation(line: 28, column: 5, scope: !324, inlinedAt: !1070)
!1073 = !DILocation(line: 28, column: 14, scope: !346, inlinedAt: !1070)
!1074 = !DILocation(line: 29, column: 23, scope: !348, inlinedAt: !1070)
!1075 = !DILocation(line: 29, column: 22, scope: !348, inlinedAt: !1070)
!1076 = !DILocation(line: 29, column: 35, scope: !348, inlinedAt: !1070)
!1077 = !DILocation(line: 29, column: 38, scope: !348, inlinedAt: !1070)
!1078 = !DILocation(line: 30, column: 17, scope: !348, inlinedAt: !1070)
!1079 = !DILocation(line: 31, column: 17, scope: !348, inlinedAt: !1070)
!1080 = !DILocation(line: 32, column: 15, scope: !348, inlinedAt: !1070)
!1081 = !DILocation(line: 33, column: 18, scope: !348, inlinedAt: !1070)
!1082 = !DILocation(line: 33, column: 16, scope: !348, inlinedAt: !1070)
!1083 = !DILocation(line: 34, column: 18, scope: !348, inlinedAt: !1070)
!1084 = !DILocation(line: 34, column: 16, scope: !348, inlinedAt: !1070)
!1085 = !DILocation(line: 28, column: 31, scope: !349, inlinedAt: !1070)
!1086 = !DILocation(line: 28, column: 25, scope: !349, inlinedAt: !1070)
!1087 = distinct !{!1087, !1073, !1088, !370, !371}
!1088 = !DILocation(line: 35, column: 5, scope: !346, inlinedAt: !1070)
!1089 = !DILocation(line: 0, scope: !580)
!1090 = !DILocation(line: 308, column: 37, scope: !1091)
!1091 = distinct !DILexicalBlock(scope: !1092, file: !225, line: 307, column: 43)
!1092 = distinct !DILexicalBlock(scope: !580, file: !225, line: 307, column: 13)
!1093 = !DILocation(line: 309, column: 37, scope: !1091)
!1094 = !DILocation(line: 269, column: 35, scope: !523)
!1095 = !DILocation(line: 269, column: 9, scope: !524)
!1096 = !DILocation(line: 269, column: 26, scope: !523)
!1097 = distinct !{!1097, !1095, !1098, !370, !371}
!1098 = !DILocation(line: 329, column: 9, scope: !524)
!1099 = !DILocation(line: 337, column: 43, scope: !1100)
!1100 = distinct !DILexicalBlock(scope: !1101, file: !225, line: 333, column: 38)
!1101 = distinct !DILexicalBlock(scope: !1102, file: !225, line: 333, column: 9)
!1102 = distinct !DILexicalBlock(scope: !426, file: !225, line: 333, column: 9)
!1103 = !DILocation(line: 337, column: 33, scope: !1100)
!1104 = !DILocation(line: 337, column: 13, scope: !1100)
!1105 = !DILocation(line: 337, column: 31, scope: !1100)
!1106 = !DILocation(line: 338, column: 46, scope: !1100)
!1107 = !DILocation(line: 338, column: 33, scope: !1100)
!1108 = !DILocation(line: 338, column: 22, scope: !1100)
!1109 = !DILocation(line: 338, column: 13, scope: !1100)
!1110 = !DILocation(line: 338, column: 31, scope: !1100)
!1111 = !DILocation(line: 339, column: 46, scope: !1100)
!1112 = !DILocation(line: 339, column: 33, scope: !1100)
!1113 = !DILocation(line: 339, column: 22, scope: !1100)
!1114 = !DILocation(line: 339, column: 13, scope: !1100)
!1115 = !DILocation(line: 339, column: 31, scope: !1100)
!1116 = !DILocation(line: 340, column: 46, scope: !1100)
!1117 = !DILocation(line: 340, column: 33, scope: !1100)
!1118 = !DILocation(line: 340, column: 22, scope: !1100)
!1119 = !DILocation(line: 340, column: 13, scope: !1100)
!1120 = !DILocation(line: 340, column: 31, scope: !1100)
!1121 = !DILocation(line: 341, column: 46, scope: !1100)
!1122 = !DILocation(line: 341, column: 33, scope: !1100)
!1123 = !DILocation(line: 341, column: 22, scope: !1100)
!1124 = !DILocation(line: 341, column: 13, scope: !1100)
!1125 = !DILocation(line: 341, column: 31, scope: !1100)
!1126 = !DILocation(line: 342, column: 46, scope: !1100)
!1127 = !DILocation(line: 342, column: 33, scope: !1100)
!1128 = !DILocation(line: 342, column: 22, scope: !1100)
!1129 = !DILocation(line: 342, column: 13, scope: !1100)
!1130 = !DILocation(line: 342, column: 31, scope: !1100)
!1131 = !DILocation(line: 343, column: 46, scope: !1100)
!1132 = !DILocation(line: 343, column: 33, scope: !1100)
!1133 = !DILocation(line: 343, column: 22, scope: !1100)
!1134 = !DILocation(line: 343, column: 13, scope: !1100)
!1135 = !DILocation(line: 343, column: 31, scope: !1100)
!1136 = !DILocation(line: 344, column: 46, scope: !1100)
!1137 = !DILocation(line: 344, column: 33, scope: !1100)
!1138 = !DILocation(line: 344, column: 22, scope: !1100)
!1139 = !DILocation(line: 344, column: 13, scope: !1100)
!1140 = !DILocation(line: 344, column: 31, scope: !1100)
!1141 = !DILocation(line: 333, column: 35, scope: !1101)
!1142 = !DILocation(line: 333, column: 26, scope: !1101)
!1143 = !DILocation(line: 333, column: 9, scope: !1102)
!1144 = distinct !{!1144, !1143, !1145, !370, !371}
!1145 = !DILocation(line: 345, column: 9, scope: !1102)
!1146 = !DILocation(line: 349, column: 21, scope: !1147)
!1147 = distinct !DILexicalBlock(scope: !1148, file: !225, line: 348, column: 38)
!1148 = distinct !DILexicalBlock(scope: !1149, file: !225, line: 348, column: 9)
!1149 = distinct !DILexicalBlock(scope: !426, file: !225, line: 348, column: 9)
!1150 = !DILocation(line: 350, column: 21, scope: !1147)
!1151 = !DILocation(line: 351, column: 24, scope: !1147)
!1152 = !DILocation(line: 351, column: 27, scope: !1147)
!1153 = !DILocation(line: 353, column: 32, scope: !1147)
!1154 = !DILocation(line: 353, column: 23, scope: !1147)
!1155 = !DILocation(line: 353, column: 13, scope: !1147)
!1156 = !DILocation(line: 353, column: 30, scope: !1147)
!1157 = !DILocation(line: 354, column: 41, scope: !1147)
!1158 = !DILocation(line: 354, column: 32, scope: !1147)
!1159 = !DILocation(line: 354, column: 26, scope: !1147)
!1160 = !DILocation(line: 354, column: 13, scope: !1147)
!1161 = !DILocation(line: 354, column: 30, scope: !1147)
!1162 = !DILocation(line: 355, column: 41, scope: !1147)
!1163 = !DILocation(line: 355, column: 32, scope: !1147)
!1164 = !DILocation(line: 355, column: 26, scope: !1147)
!1165 = !DILocation(line: 355, column: 13, scope: !1147)
!1166 = !DILocation(line: 355, column: 30, scope: !1147)
!1167 = !DILocation(line: 356, column: 41, scope: !1147)
!1168 = !DILocation(line: 356, column: 32, scope: !1147)
!1169 = !DILocation(line: 356, column: 26, scope: !1147)
!1170 = !DILocation(line: 356, column: 13, scope: !1147)
!1171 = !DILocation(line: 356, column: 30, scope: !1147)
!1172 = !DILocation(line: 357, column: 41, scope: !1147)
!1173 = !DILocation(line: 357, column: 32, scope: !1147)
!1174 = !DILocation(line: 357, column: 26, scope: !1147)
!1175 = !DILocation(line: 357, column: 13, scope: !1147)
!1176 = !DILocation(line: 357, column: 30, scope: !1147)
!1177 = !DILocation(line: 358, column: 41, scope: !1147)
!1178 = !DILocation(line: 358, column: 32, scope: !1147)
!1179 = !DILocation(line: 358, column: 26, scope: !1147)
!1180 = !DILocation(line: 358, column: 13, scope: !1147)
!1181 = !DILocation(line: 358, column: 30, scope: !1147)
!1182 = !DILocation(line: 359, column: 41, scope: !1147)
!1183 = !DILocation(line: 359, column: 32, scope: !1147)
!1184 = !DILocation(line: 359, column: 26, scope: !1147)
!1185 = !DILocation(line: 359, column: 13, scope: !1147)
!1186 = !DILocation(line: 359, column: 30, scope: !1147)
!1187 = !DILocation(line: 360, column: 41, scope: !1147)
!1188 = !DILocation(line: 360, column: 32, scope: !1147)
!1189 = !DILocation(line: 360, column: 26, scope: !1147)
!1190 = !DILocation(line: 360, column: 13, scope: !1147)
!1191 = !DILocation(line: 360, column: 30, scope: !1147)
!1192 = !DILocation(line: 348, column: 35, scope: !1148)
!1193 = !DILocation(line: 348, column: 26, scope: !1148)
!1194 = !DILocation(line: 348, column: 9, scope: !1149)
!1195 = distinct !{!1195, !1194, !1196, !370, !371}
!1196 = !DILocation(line: 361, column: 9, scope: !1149)
!1197 = !DILocation(line: 369, column: 43, scope: !1198)
!1198 = distinct !DILexicalBlock(scope: !1199, file: !225, line: 364, column: 38)
!1199 = distinct !DILexicalBlock(scope: !1200, file: !225, line: 364, column: 9)
!1200 = distinct !DILexicalBlock(scope: !426, file: !225, line: 364, column: 9)
!1201 = !DILocation(line: 369, column: 33, scope: !1198)
!1202 = !DILocation(line: 369, column: 13, scope: !1198)
!1203 = !DILocation(line: 369, column: 31, scope: !1198)
!1204 = !DILocation(line: 370, column: 46, scope: !1198)
!1205 = !DILocation(line: 370, column: 33, scope: !1198)
!1206 = !DILocation(line: 370, column: 22, scope: !1198)
!1207 = !DILocation(line: 370, column: 13, scope: !1198)
!1208 = !DILocation(line: 370, column: 31, scope: !1198)
!1209 = !DILocation(line: 371, column: 46, scope: !1198)
!1210 = !DILocation(line: 371, column: 33, scope: !1198)
!1211 = !DILocation(line: 371, column: 22, scope: !1198)
!1212 = !DILocation(line: 371, column: 13, scope: !1198)
!1213 = !DILocation(line: 371, column: 31, scope: !1198)
!1214 = !DILocation(line: 372, column: 46, scope: !1198)
!1215 = !DILocation(line: 372, column: 33, scope: !1198)
!1216 = !DILocation(line: 372, column: 22, scope: !1198)
!1217 = !DILocation(line: 372, column: 13, scope: !1198)
!1218 = !DILocation(line: 372, column: 31, scope: !1198)
!1219 = !DILocation(line: 373, column: 46, scope: !1198)
!1220 = !DILocation(line: 373, column: 33, scope: !1198)
!1221 = !DILocation(line: 373, column: 22, scope: !1198)
!1222 = !DILocation(line: 373, column: 13, scope: !1198)
!1223 = !DILocation(line: 373, column: 31, scope: !1198)
!1224 = !DILocation(line: 374, column: 46, scope: !1198)
!1225 = !DILocation(line: 374, column: 33, scope: !1198)
!1226 = !DILocation(line: 374, column: 22, scope: !1198)
!1227 = !DILocation(line: 374, column: 13, scope: !1198)
!1228 = !DILocation(line: 374, column: 31, scope: !1198)
!1229 = !DILocation(line: 375, column: 46, scope: !1198)
!1230 = !DILocation(line: 375, column: 33, scope: !1198)
!1231 = !DILocation(line: 375, column: 22, scope: !1198)
!1232 = !DILocation(line: 375, column: 13, scope: !1198)
!1233 = !DILocation(line: 375, column: 31, scope: !1198)
!1234 = !DILocation(line: 376, column: 46, scope: !1198)
!1235 = !DILocation(line: 376, column: 33, scope: !1198)
!1236 = !DILocation(line: 376, column: 22, scope: !1198)
!1237 = !DILocation(line: 376, column: 13, scope: !1198)
!1238 = !DILocation(line: 376, column: 31, scope: !1198)
!1239 = !DILocation(line: 364, column: 35, scope: !1199)
!1240 = !DILocation(line: 364, column: 26, scope: !1199)
!1241 = !DILocation(line: 364, column: 9, scope: !1200)
!1242 = distinct !{!1242, !1241, !1243, !370, !371}
!1243 = !DILocation(line: 377, column: 9, scope: !1200)
!1244 = !DILocation(line: 0, scope: !586)
!1245 = !DILocation(line: 382, column: 27, scope: !1246)
!1246 = distinct !DILexicalBlock(scope: !1247, file: !225, line: 381, column: 43)
!1247 = distinct !DILexicalBlock(scope: !586, file: !225, line: 381, column: 13)
!1248 = !DILocation(line: 393, column: 22, scope: !587)
!1249 = !DILocation(line: 394, column: 22, scope: !587)
!1250 = !DILocation(line: 396, column: 37, scope: !587)
!1251 = !DILocation(line: 396, column: 40, scope: !587)
!1252 = !DILocation(line: 0, scope: !403, inlinedAt: !1253)
!1253 = distinct !DILocation(line: 396, column: 14, scope: !587)
!1254 = !DILocation(line: 0, scope: !410, inlinedAt: !1253)
!1255 = !DILocation(line: 108, column: 10, scope: !410, inlinedAt: !1253)
!1256 = !DILocation(line: 108, column: 5, scope: !410, inlinedAt: !1253)
!1257 = !DILocation(line: 110, column: 18, scope: !417, inlinedAt: !1253)
!1258 = !DILocation(line: 110, column: 9, scope: !417, inlinedAt: !1253)
!1259 = !DILocation(line: 110, column: 16, scope: !417, inlinedAt: !1253)
!1260 = !DILocation(line: 108, column: 32, scope: !418, inlinedAt: !1253)
!1261 = !DILocation(line: 108, column: 26, scope: !418, inlinedAt: !1253)
!1262 = distinct !{!1262, !1256, !1263, !370, !371}
!1263 = !DILocation(line: 111, column: 5, scope: !410, inlinedAt: !1253)
!1264 = !DILocation(line: 0, scope: !591)
!1265 = !DILocation(line: 399, column: 36, scope: !1266)
!1266 = distinct !DILexicalBlock(scope: !1267, file: !225, line: 398, column: 44)
!1267 = distinct !DILexicalBlock(scope: !591, file: !225, line: 398, column: 14)
!1268 = !DILocation(line: 379, column: 36, scope: !588)
!1269 = !DILocation(line: 379, column: 10, scope: !589)
!1270 = !DILocation(line: 379, column: 27, scope: !588)
!1271 = distinct !{!1271, !1269, !1272, !370, !371}
!1272 = !DILocation(line: 410, column: 10, scope: !589)
!1273 = !DILocation(line: 0, scope: !594)
!1274 = !DILocation(line: 415, column: 27, scope: !1275)
!1275 = distinct !DILexicalBlock(scope: !1276, file: !225, line: 414, column: 44)
!1276 = distinct !DILexicalBlock(scope: !594, file: !225, line: 414, column: 14)
!1277 = !DILocation(line: 416, column: 27, scope: !1275)
!1278 = !DILocation(line: 0, scope: !599)
!1279 = !DILocation(line: 438, column: 14, scope: !607)
!1280 = !DILocation(line: 0, scope: !607)
!1281 = distinct !DIAssignID()
!1282 = distinct !DIAssignID()
!1283 = distinct !DIAssignID()
!1284 = distinct !DIAssignID()
!1285 = !DILocation(line: 438, column: 14, scope: !610)
!1286 = !DILocation(line: 0, scope: !610)
!1287 = distinct !DIAssignID()
!1288 = distinct !DIAssignID()
!1289 = distinct !DIAssignID()
!1290 = distinct !DIAssignID()
!1291 = !DILocation(line: 438, column: 14, scope: !613)
!1292 = !DILocation(line: 0, scope: !613)
!1293 = distinct !DIAssignID()
!1294 = distinct !DIAssignID()
!1295 = distinct !DIAssignID()
!1296 = distinct !DIAssignID()
!1297 = !DILocation(line: 438, column: 14, scope: !616)
!1298 = !DILocation(line: 0, scope: !616)
!1299 = distinct !DIAssignID()
!1300 = distinct !DIAssignID()
!1301 = distinct !DIAssignID()
!1302 = distinct !DIAssignID()
!1303 = !DILocation(line: 438, column: 14, scope: !599)
!1304 = distinct !DIAssignID()
!1305 = distinct !DIAssignID()
!1306 = distinct !DIAssignID()
!1307 = distinct !DIAssignID()
!1308 = distinct !DIAssignID()
!1309 = distinct !DIAssignID()
!1310 = !DILocation(line: 0, scope: !619)
!1311 = !DILocation(line: 0, scope: !623)
!1312 = !DILocation(line: 438, column: 14, scope: !623)
!1313 = distinct !DIAssignID()
!1314 = distinct !DIAssignID()
!1315 = distinct !DIAssignID()
!1316 = distinct !DIAssignID()
!1317 = !DILocation(line: 0, scope: !626)
!1318 = !DILocation(line: 438, column: 14, scope: !626)
!1319 = distinct !DIAssignID()
!1320 = distinct !DIAssignID()
!1321 = distinct !DIAssignID()
!1322 = distinct !DIAssignID()
!1323 = !DILocation(line: 438, column: 14, scope: !619)
!1324 = distinct !DIAssignID()
!1325 = distinct !DIAssignID()
!1326 = !DILocation(line: 0, scope: !629)
!1327 = !DILocation(line: 438, column: 14, scope: !629)
!1328 = distinct !DIAssignID()
!1329 = distinct !DIAssignID()
!1330 = distinct !DIAssignID()
!1331 = distinct !DIAssignID()
!1332 = !DILocation(line: 0, scope: !632)
!1333 = !DILocation(line: 438, column: 14, scope: !632)
!1334 = distinct !DIAssignID()
!1335 = distinct !DIAssignID()
!1336 = distinct !DIAssignID()
!1337 = distinct !DIAssignID()
!1338 = !DILocation(line: 0, scope: !635)
!1339 = !DILocation(line: 0, scope: !639)
!1340 = !DILocation(line: 438, column: 14, scope: !639)
!1341 = distinct !DIAssignID()
!1342 = distinct !DIAssignID()
!1343 = distinct !DIAssignID()
!1344 = distinct !DIAssignID()
!1345 = !DILocation(line: 0, scope: !642)
!1346 = !DILocation(line: 438, column: 14, scope: !642)
!1347 = distinct !DIAssignID()
!1348 = distinct !DIAssignID()
!1349 = distinct !DIAssignID()
!1350 = distinct !DIAssignID()
!1351 = !DILocation(line: 438, column: 14, scope: !635)
!1352 = distinct !DIAssignID()
!1353 = distinct !DIAssignID()
!1354 = !DILocation(line: 0, scope: !645)
!1355 = !DILocation(line: 438, column: 14, scope: !645)
!1356 = distinct !DIAssignID()
!1357 = distinct !DIAssignID()
!1358 = distinct !DIAssignID()
!1359 = distinct !DIAssignID()
!1360 = !DILocation(line: 0, scope: !648)
!1361 = !DILocation(line: 438, column: 14, scope: !648)
!1362 = distinct !DIAssignID()
!1363 = distinct !DIAssignID()
!1364 = distinct !DIAssignID()
!1365 = distinct !DIAssignID()
!1366 = !DILocation(line: 0, scope: !651)
!1367 = !DILocation(line: 441, column: 14, scope: !651)
!1368 = !DILocation(line: 412, column: 36, scope: !596)
!1369 = !DILocation(line: 412, column: 27, scope: !596)
!1370 = !DILocation(line: 412, column: 10, scope: !597)
!1371 = distinct !{!1371, !1370, !1372, !370, !371}
!1372 = !DILocation(line: 462, column: 10, scope: !597)
!1373 = !DILocation(line: 442, column: 47, scope: !1374)
!1374 = distinct !DILexicalBlock(scope: !1375, file: !225, line: 441, column: 44)
!1375 = distinct !DILexicalBlock(scope: !651, file: !225, line: 441, column: 14)
!1376 = !DILocation(line: 442, column: 40, scope: !1374)
!1377 = !DILocation(line: 442, column: 25, scope: !1374)
!1378 = !DILocation(line: 442, column: 32, scope: !1374)
!1379 = !DILocation(line: 442, column: 17, scope: !1374)
!1380 = !DILocation(line: 442, column: 38, scope: !1374)
!1381 = !DILocation(line: 443, column: 40, scope: !1374)
!1382 = !DILocation(line: 443, column: 17, scope: !1374)
!1383 = !DILocation(line: 443, column: 38, scope: !1374)
!1384 = !DILocation(line: 441, column: 41, scope: !1375)
!1385 = !DILocation(line: 441, column: 35, scope: !1375)
!1386 = distinct !{!1386, !1367, !1387, !370, !371}
!1387 = !DILocation(line: 444, column: 14, scope: !651)
!1388 = !DILocation(line: 463, column: 1, scope: !426)
!1389 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 8, type: !1390, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !1392)
!1390 = !DISubroutineType(types: !1391)
!1391 = !{null, !229}
!1392 = !{!1393, !1394}
!1393 = !DILocalVariable(name: "vargs", arg: 1, scope: !1389, file: !189, line: 8, type: !229)
!1394 = !DILocalVariable(name: "args", scope: !1389, file: !189, line: 9, type: !191)
!1395 = !DILocation(line: 0, scope: !1389)
!1396 = !DILocation(line: 10, column: 28, scope: !1389)
!1397 = !DILocation(line: 10, column: 3, scope: !1389)
!1398 = !DILocation(line: 11, column: 1, scope: !1389)
!1399 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 20, type: !1400, scopeLine: 20, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !1402)
!1400 = !DISubroutineType(types: !1401)
!1401 = !{null, !202, !229}
!1402 = !{!1403, !1404, !1405, !1406, !1407}
!1403 = !DILocalVariable(name: "fd", arg: 1, scope: !1399, file: !189, line: 20, type: !202)
!1404 = !DILocalVariable(name: "vdata", arg: 2, scope: !1399, file: !189, line: 20, type: !229)
!1405 = !DILocalVariable(name: "data", scope: !1399, file: !189, line: 21, type: !191)
!1406 = !DILocalVariable(name: "p", scope: !1399, file: !189, line: 22, type: !228)
!1407 = !DILocalVariable(name: "s", scope: !1399, file: !189, line: 22, type: !228)
!1408 = !DILocation(line: 0, scope: !1399)
!1409 = !DILocation(line: 24, column: 7, scope: !1399)
!1410 = !DILocalVariable(name: "s", arg: 1, scope: !1411, file: !2, line: 56, type: !228)
!1411 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !1412, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !1414)
!1412 = !DISubroutineType(types: !1413)
!1413 = !{!228, !228, !202}
!1414 = !{!1410, !1415, !1416}
!1415 = !DILocalVariable(name: "n", arg: 2, scope: !1411, file: !2, line: 56, type: !202)
!1416 = !DILocalVariable(name: "i", scope: !1411, file: !2, line: 57, type: !202)
!1417 = !DILocation(line: 0, scope: !1411, inlinedAt: !1418)
!1418 = distinct !DILocation(line: 26, column: 7, scope: !1399)
!1419 = !DILocation(line: 64, column: 17, scope: !1411, inlinedAt: !1418)
!1420 = !{!352, !352, i64 0}
!1421 = !DILocation(line: 64, column: 3, scope: !1411, inlinedAt: !1418)
!1422 = !DILocation(line: 66, column: 22, scope: !1423, inlinedAt: !1418)
!1423 = distinct !DILexicalBlock(scope: !1424, file: !2, line: 66, column: 9)
!1424 = distinct !DILexicalBlock(scope: !1411, file: !2, line: 64, column: 31)
!1425 = !DILocation(line: 66, column: 26, scope: !1423, inlinedAt: !1418)
!1426 = !DILocation(line: 66, column: 32, scope: !1423, inlinedAt: !1418)
!1427 = !DILocation(line: 66, column: 35, scope: !1423, inlinedAt: !1418)
!1428 = !DILocation(line: 66, column: 39, scope: !1423, inlinedAt: !1418)
!1429 = !DILocation(line: 66, column: 9, scope: !1424, inlinedAt: !1418)
!1430 = !DILocation(line: 69, column: 6, scope: !1424, inlinedAt: !1418)
!1431 = !DILocation(line: 64, column: 10, scope: !1411, inlinedAt: !1418)
!1432 = !DILocation(line: 64, column: 13, scope: !1411, inlinedAt: !1418)
!1433 = distinct !{!1433, !1421, !1434, !370, !371}
!1434 = !DILocation(line: 70, column: 3, scope: !1411, inlinedAt: !1418)
!1435 = !DILocation(line: 71, column: 6, scope: !1436, inlinedAt: !1418)
!1436 = distinct !DILexicalBlock(scope: !1411, file: !2, line: 71, column: 6)
!1437 = !DILocation(line: 71, column: 8, scope: !1436, inlinedAt: !1418)
!1438 = !DILocation(line: 71, column: 6, scope: !1411, inlinedAt: !1418)
!1439 = !DILocation(line: 27, column: 3, scope: !1399)
!1440 = !DILocation(line: 0, scope: !1411, inlinedAt: !1441)
!1441 = distinct !DILocation(line: 29, column: 7, scope: !1399)
!1442 = !DILocation(line: 64, column: 17, scope: !1411, inlinedAt: !1441)
!1443 = !DILocation(line: 64, column: 3, scope: !1411, inlinedAt: !1441)
!1444 = !DILocation(line: 66, column: 22, scope: !1423, inlinedAt: !1441)
!1445 = !DILocation(line: 66, column: 26, scope: !1423, inlinedAt: !1441)
!1446 = !DILocation(line: 66, column: 32, scope: !1423, inlinedAt: !1441)
!1447 = !DILocation(line: 66, column: 35, scope: !1423, inlinedAt: !1441)
!1448 = !DILocation(line: 66, column: 39, scope: !1423, inlinedAt: !1441)
!1449 = !DILocation(line: 66, column: 9, scope: !1424, inlinedAt: !1441)
!1450 = !DILocation(line: 69, column: 6, scope: !1424, inlinedAt: !1441)
!1451 = !DILocation(line: 64, column: 10, scope: !1411, inlinedAt: !1441)
!1452 = !DILocation(line: 64, column: 13, scope: !1411, inlinedAt: !1441)
!1453 = distinct !{!1453, !1443, !1454, !370, !371}
!1454 = !DILocation(line: 70, column: 3, scope: !1411, inlinedAt: !1441)
!1455 = !DILocation(line: 71, column: 6, scope: !1436, inlinedAt: !1441)
!1456 = !DILocation(line: 71, column: 8, scope: !1436, inlinedAt: !1441)
!1457 = !DILocation(line: 71, column: 6, scope: !1411, inlinedAt: !1441)
!1458 = !DILocation(line: 30, column: 37, scope: !1399)
!1459 = !DILocation(line: 30, column: 3, scope: !1399)
!1460 = !DILocation(line: 31, column: 3, scope: !1399)
!1461 = !DILocation(line: 32, column: 1, scope: !1399)
!1462 = !DISubprogram(name: "free", scope: !1463, file: !1463, line: 687, type: !1390, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1463 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!1464 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 34, type: !1400, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !1465)
!1465 = !{!1466, !1467, !1468}
!1466 = !DILocalVariable(name: "fd", arg: 1, scope: !1464, file: !189, line: 34, type: !202)
!1467 = !DILocalVariable(name: "vdata", arg: 2, scope: !1464, file: !189, line: 34, type: !229)
!1468 = !DILocalVariable(name: "data", scope: !1464, file: !189, line: 35, type: !191)
!1469 = !DILocation(line: 0, scope: !1464)
!1470 = !DILocalVariable(name: "fd", arg: 1, scope: !1471, file: !2, line: 189, type: !202)
!1471 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !1472, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !1474)
!1472 = !DISubroutineType(types: !1473)
!1473 = !{!202, !202}
!1474 = !{!1470}
!1475 = !DILocation(line: 0, scope: !1471, inlinedAt: !1476)
!1476 = distinct !DILocation(line: 37, column: 3, scope: !1464)
!1477 = !DILocation(line: 190, column: 3, scope: !1478, inlinedAt: !1476)
!1478 = distinct !DILexicalBlock(scope: !1479, file: !2, line: 190, column: 3)
!1479 = distinct !DILexicalBlock(scope: !1471, file: !2, line: 190, column: 3)
!1480 = !DILocation(line: 191, column: 3, scope: !1471, inlinedAt: !1476)
!1481 = !DILocalVariable(name: "fd", arg: 1, scope: !1482, file: !2, line: 187, type: !202)
!1482 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !1483, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !1485)
!1483 = !DISubroutineType(types: !1484)
!1484 = !{!202, !202, !327, !202}
!1485 = !{!1481, !1486, !1487, !1488}
!1486 = !DILocalVariable(name: "arr", arg: 2, scope: !1482, file: !2, line: 187, type: !327)
!1487 = !DILocalVariable(name: "n", arg: 3, scope: !1482, file: !2, line: 187, type: !202)
!1488 = !DILocalVariable(name: "i", scope: !1482, file: !2, line: 187, type: !202)
!1489 = !DILocation(line: 0, scope: !1482, inlinedAt: !1490)
!1490 = distinct !DILocation(line: 38, column: 3, scope: !1464)
!1491 = !DILocation(line: 187, column: 1, scope: !1492, inlinedAt: !1490)
!1492 = distinct !DILexicalBlock(scope: !1482, file: !2, line: 187, column: 1)
!1493 = !DILocation(line: 187, column: 1, scope: !1494, inlinedAt: !1490)
!1494 = distinct !DILexicalBlock(scope: !1495, file: !2, line: 187, column: 1)
!1495 = distinct !DILexicalBlock(scope: !1492, file: !2, line: 187, column: 1)
!1496 = !DILocation(line: 187, column: 1, scope: !1495, inlinedAt: !1490)
!1497 = distinct !{!1497, !1491, !1491, !370, !371}
!1498 = !DILocation(line: 0, scope: !1471, inlinedAt: !1499)
!1499 = distinct !DILocation(line: 40, column: 3, scope: !1464)
!1500 = !DILocation(line: 191, column: 3, scope: !1471, inlinedAt: !1499)
!1501 = !DILocation(line: 41, column: 38, scope: !1464)
!1502 = !DILocation(line: 0, scope: !1482, inlinedAt: !1503)
!1503 = distinct !DILocation(line: 41, column: 3, scope: !1464)
!1504 = !DILocation(line: 187, column: 1, scope: !1492, inlinedAt: !1503)
!1505 = !DILocation(line: 187, column: 1, scope: !1494, inlinedAt: !1503)
!1506 = !DILocation(line: 187, column: 1, scope: !1495, inlinedAt: !1503)
!1507 = distinct !{!1507, !1504, !1504, !370, !371}
!1508 = !DILocation(line: 42, column: 1, scope: !1464)
!1509 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 51, type: !1400, scopeLine: 51, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !1510)
!1510 = !{!1511, !1512, !1513, !1514, !1515}
!1511 = !DILocalVariable(name: "fd", arg: 1, scope: !1509, file: !189, line: 51, type: !202)
!1512 = !DILocalVariable(name: "vdata", arg: 2, scope: !1509, file: !189, line: 51, type: !229)
!1513 = !DILocalVariable(name: "data", scope: !1509, file: !189, line: 52, type: !191)
!1514 = !DILocalVariable(name: "p", scope: !1509, file: !189, line: 53, type: !228)
!1515 = !DILocalVariable(name: "s", scope: !1509, file: !189, line: 53, type: !228)
!1516 = !DILocation(line: 0, scope: !1509)
!1517 = !DILocation(line: 55, column: 7, scope: !1509)
!1518 = !DILocation(line: 0, scope: !1411, inlinedAt: !1519)
!1519 = distinct !DILocation(line: 57, column: 7, scope: !1509)
!1520 = !DILocation(line: 64, column: 17, scope: !1411, inlinedAt: !1519)
!1521 = !DILocation(line: 64, column: 3, scope: !1411, inlinedAt: !1519)
!1522 = !DILocation(line: 66, column: 22, scope: !1423, inlinedAt: !1519)
!1523 = !DILocation(line: 66, column: 26, scope: !1423, inlinedAt: !1519)
!1524 = !DILocation(line: 66, column: 32, scope: !1423, inlinedAt: !1519)
!1525 = !DILocation(line: 66, column: 35, scope: !1423, inlinedAt: !1519)
!1526 = !DILocation(line: 66, column: 39, scope: !1423, inlinedAt: !1519)
!1527 = !DILocation(line: 66, column: 9, scope: !1424, inlinedAt: !1519)
!1528 = !DILocation(line: 69, column: 6, scope: !1424, inlinedAt: !1519)
!1529 = !DILocation(line: 64, column: 10, scope: !1411, inlinedAt: !1519)
!1530 = !DILocation(line: 64, column: 13, scope: !1411, inlinedAt: !1519)
!1531 = distinct !{!1531, !1521, !1532, !370, !371}
!1532 = !DILocation(line: 70, column: 3, scope: !1411, inlinedAt: !1519)
!1533 = !DILocation(line: 71, column: 6, scope: !1436, inlinedAt: !1519)
!1534 = !DILocation(line: 71, column: 8, scope: !1436, inlinedAt: !1519)
!1535 = !DILocation(line: 71, column: 6, scope: !1411, inlinedAt: !1519)
!1536 = !DILocation(line: 58, column: 3, scope: !1509)
!1537 = !DILocation(line: 0, scope: !1411, inlinedAt: !1538)
!1538 = distinct !DILocation(line: 60, column: 7, scope: !1509)
!1539 = !DILocation(line: 64, column: 17, scope: !1411, inlinedAt: !1538)
!1540 = !DILocation(line: 64, column: 3, scope: !1411, inlinedAt: !1538)
!1541 = !DILocation(line: 66, column: 22, scope: !1423, inlinedAt: !1538)
!1542 = !DILocation(line: 66, column: 26, scope: !1423, inlinedAt: !1538)
!1543 = !DILocation(line: 66, column: 32, scope: !1423, inlinedAt: !1538)
!1544 = !DILocation(line: 66, column: 35, scope: !1423, inlinedAt: !1538)
!1545 = !DILocation(line: 66, column: 39, scope: !1423, inlinedAt: !1538)
!1546 = !DILocation(line: 66, column: 9, scope: !1424, inlinedAt: !1538)
!1547 = !DILocation(line: 69, column: 6, scope: !1424, inlinedAt: !1538)
!1548 = !DILocation(line: 64, column: 10, scope: !1411, inlinedAt: !1538)
!1549 = !DILocation(line: 64, column: 13, scope: !1411, inlinedAt: !1538)
!1550 = distinct !{!1550, !1540, !1551, !370, !371}
!1551 = !DILocation(line: 70, column: 3, scope: !1411, inlinedAt: !1538)
!1552 = !DILocation(line: 71, column: 6, scope: !1436, inlinedAt: !1538)
!1553 = !DILocation(line: 71, column: 8, scope: !1436, inlinedAt: !1538)
!1554 = !DILocation(line: 71, column: 6, scope: !1411, inlinedAt: !1538)
!1555 = !DILocation(line: 61, column: 37, scope: !1509)
!1556 = !DILocation(line: 61, column: 3, scope: !1509)
!1557 = !DILocation(line: 62, column: 3, scope: !1509)
!1558 = !DILocation(line: 63, column: 1, scope: !1509)
!1559 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 65, type: !1400, scopeLine: 65, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !1560)
!1560 = !{!1561, !1562, !1563}
!1561 = !DILocalVariable(name: "fd", arg: 1, scope: !1559, file: !189, line: 65, type: !202)
!1562 = !DILocalVariable(name: "vdata", arg: 2, scope: !1559, file: !189, line: 65, type: !229)
!1563 = !DILocalVariable(name: "data", scope: !1559, file: !189, line: 66, type: !191)
!1564 = !DILocation(line: 0, scope: !1559)
!1565 = !DILocation(line: 0, scope: !1471, inlinedAt: !1566)
!1566 = distinct !DILocation(line: 68, column: 3, scope: !1559)
!1567 = !DILocation(line: 190, column: 3, scope: !1478, inlinedAt: !1566)
!1568 = !DILocation(line: 191, column: 3, scope: !1471, inlinedAt: !1566)
!1569 = !DILocation(line: 0, scope: !1482, inlinedAt: !1570)
!1570 = distinct !DILocation(line: 69, column: 3, scope: !1559)
!1571 = !DILocation(line: 187, column: 1, scope: !1492, inlinedAt: !1570)
!1572 = !DILocation(line: 187, column: 1, scope: !1494, inlinedAt: !1570)
!1573 = !DILocation(line: 187, column: 1, scope: !1495, inlinedAt: !1570)
!1574 = distinct !{!1574, !1571, !1571, !370, !371}
!1575 = !DILocation(line: 0, scope: !1471, inlinedAt: !1576)
!1576 = distinct !DILocation(line: 71, column: 3, scope: !1559)
!1577 = !DILocation(line: 191, column: 3, scope: !1471, inlinedAt: !1576)
!1578 = !DILocation(line: 72, column: 38, scope: !1559)
!1579 = !DILocation(line: 0, scope: !1482, inlinedAt: !1580)
!1580 = distinct !DILocation(line: 72, column: 3, scope: !1559)
!1581 = !DILocation(line: 187, column: 1, scope: !1492, inlinedAt: !1580)
!1582 = !DILocation(line: 187, column: 1, scope: !1494, inlinedAt: !1580)
!1583 = !DILocation(line: 187, column: 1, scope: !1495, inlinedAt: !1580)
!1584 = distinct !{!1584, !1581, !1581, !370, !371}
!1585 = !DILocation(line: 73, column: 1, scope: !1559)
!1586 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 75, type: !1587, scopeLine: 75, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !1589)
!1587 = !DISubroutineType(types: !1588)
!1588 = !{!202, !229, !229}
!1589 = !{!1590, !1591, !1592, !1593, !1594, !1595, !1596, !1597}
!1590 = !DILocalVariable(name: "vdata", arg: 1, scope: !1586, file: !189, line: 75, type: !229)
!1591 = !DILocalVariable(name: "vref", arg: 2, scope: !1586, file: !189, line: 75, type: !229)
!1592 = !DILocalVariable(name: "data", scope: !1586, file: !189, line: 76, type: !191)
!1593 = !DILocalVariable(name: "ref", scope: !1586, file: !189, line: 77, type: !191)
!1594 = !DILocalVariable(name: "has_errors", scope: !1586, file: !189, line: 78, type: !202)
!1595 = !DILocalVariable(name: "i", scope: !1586, file: !189, line: 79, type: !202)
!1596 = !DILocalVariable(name: "real_diff", scope: !1586, file: !189, line: 80, type: !197)
!1597 = !DILocalVariable(name: "img_diff", scope: !1586, file: !189, line: 80, type: !197)
!1598 = !DILocation(line: 0, scope: !1586)
!1599 = !DILocation(line: 82, column: 3, scope: !1600)
!1600 = distinct !DILexicalBlock(scope: !1586, file: !189, line: 82, column: 3)
!1601 = !DILocation(line: 83, column: 17, scope: !1602)
!1602 = distinct !DILexicalBlock(scope: !1603, file: !189, line: 82, column: 24)
!1603 = distinct !DILexicalBlock(scope: !1600, file: !189, line: 82, column: 3)
!1604 = !DILocation(line: 83, column: 35, scope: !1602)
!1605 = !DILocation(line: 83, column: 33, scope: !1602)
!1606 = !DILocation(line: 84, column: 16, scope: !1602)
!1607 = !DILocation(line: 84, column: 34, scope: !1602)
!1608 = !DILocation(line: 84, column: 32, scope: !1602)
!1609 = !DILocation(line: 85, column: 40, scope: !1602)
!1610 = !DILocation(line: 88, column: 39, scope: !1602)
!1611 = !DILocation(line: 88, column: 16, scope: !1602)
!1612 = !DILocation(line: 82, column: 20, scope: !1603)
!1613 = !DILocation(line: 82, column: 13, scope: !1603)
!1614 = distinct !{!1614, !1599, !1615, !370, !371}
!1615 = !DILocation(line: 91, column: 3, scope: !1600)
!1616 = !DILocation(line: 94, column: 10, scope: !1586)
!1617 = !DILocation(line: 94, column: 3, scope: !1586)
!1618 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !1619, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !1621)
!1619 = !DISubroutineType(types: !1620)
!1620 = !{!228, !202}
!1621 = !{!1622, !1623, !1624, !1661, !1664, !1667}
!1622 = !DILocalVariable(name: "fd", arg: 1, scope: !1618, file: !2, line: 34, type: !202)
!1623 = !DILocalVariable(name: "p", scope: !1618, file: !2, line: 35, type: !228)
!1624 = !DILocalVariable(name: "s", scope: !1618, file: !2, line: 36, type: !1625)
!1625 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !1626, line: 44, size: 1024, elements: !1627)
!1626 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!1627 = !{!1628, !1630, !1632, !1634, !1636, !1638, !1640, !1641, !1642, !1644, !1646, !1647, !1649, !1657, !1658, !1659}
!1628 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !1625, file: !1626, line: 46, baseType: !1629, size: 64)
!1629 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !233, line: 145, baseType: !243)
!1630 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !1625, file: !1626, line: 47, baseType: !1631, size: 64, offset: 64)
!1631 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !233, line: 148, baseType: !243)
!1632 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !1625, file: !1626, line: 48, baseType: !1633, size: 32, offset: 128)
!1633 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !233, line: 150, baseType: !240)
!1634 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !1625, file: !1626, line: 49, baseType: !1635, size: 32, offset: 160)
!1635 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !233, line: 151, baseType: !240)
!1636 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !1625, file: !1626, line: 50, baseType: !1637, size: 32, offset: 192)
!1637 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !233, line: 146, baseType: !240)
!1638 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !1625, file: !1626, line: 51, baseType: !1639, size: 32, offset: 224)
!1639 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !233, line: 147, baseType: !240)
!1640 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !1625, file: !1626, line: 52, baseType: !1629, size: 64, offset: 256)
!1641 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !1625, file: !1626, line: 53, baseType: !1629, size: 64, offset: 320)
!1642 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !1625, file: !1626, line: 54, baseType: !1643, size: 64, offset: 384)
!1643 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !233, line: 152, baseType: !255)
!1644 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !1625, file: !1626, line: 55, baseType: !1645, size: 32, offset: 448)
!1645 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !233, line: 175, baseType: !202)
!1646 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !1625, file: !1626, line: 56, baseType: !202, size: 32, offset: 480)
!1647 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !1625, file: !1626, line: 57, baseType: !1648, size: 64, offset: 512)
!1648 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !233, line: 180, baseType: !255)
!1649 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !1625, file: !1626, line: 65, baseType: !1650, size: 128, offset: 576)
!1650 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !1651, line: 11, size: 128, elements: !1652)
!1651 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!1652 = !{!1653, !1655}
!1653 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !1650, file: !1651, line: 16, baseType: !1654, size: 64)
!1654 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !233, line: 160, baseType: !255)
!1655 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !1650, file: !1651, line: 21, baseType: !1656, size: 64, offset: 64)
!1656 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !233, line: 197, baseType: !255)
!1657 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !1625, file: !1626, line: 66, baseType: !1650, size: 128, offset: 704)
!1658 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !1625, file: !1626, line: 67, baseType: !1650, size: 128, offset: 832)
!1659 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !1625, file: !1626, line: 79, baseType: !1660, size: 64, offset: 960)
!1660 = !DICompositeType(tag: DW_TAG_array_type, baseType: !202, size: 64, elements: !55)
!1661 = !DILocalVariable(name: "len", scope: !1618, file: !2, line: 37, type: !1662)
!1662 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !1663, line: 85, baseType: !1643)
!1663 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!1664 = !DILocalVariable(name: "bytes_read", scope: !1618, file: !2, line: 38, type: !1665)
!1665 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !1663, line: 108, baseType: !1666)
!1666 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !233, line: 194, baseType: !255)
!1667 = !DILocalVariable(name: "status", scope: !1618, file: !2, line: 38, type: !1665)
!1668 = distinct !DIAssignID()
!1669 = !DILocation(line: 0, scope: !1618)
!1670 = !DILocation(line: 36, column: 3, scope: !1618)
!1671 = !DILocation(line: 40, column: 3, scope: !1672)
!1672 = distinct !DILexicalBlock(scope: !1673, file: !2, line: 40, column: 3)
!1673 = distinct !DILexicalBlock(scope: !1618, file: !2, line: 40, column: 3)
!1674 = !DILocation(line: 41, column: 3, scope: !1675)
!1675 = distinct !DILexicalBlock(scope: !1676, file: !2, line: 41, column: 3)
!1676 = distinct !DILexicalBlock(scope: !1618, file: !2, line: 41, column: 3)
!1677 = !DILocation(line: 42, column: 11, scope: !1618)
!1678 = !DILocation(line: 43, column: 3, scope: !1679)
!1679 = distinct !DILexicalBlock(scope: !1680, file: !2, line: 43, column: 3)
!1680 = distinct !DILexicalBlock(scope: !1618, file: !2, line: 43, column: 3)
!1681 = !DILocation(line: 44, column: 25, scope: !1618)
!1682 = !DILocation(line: 44, column: 15, scope: !1618)
!1683 = !DILocation(line: 46, column: 3, scope: !1618)
!1684 = !DILocation(line: 49, column: 15, scope: !1685)
!1685 = distinct !DILexicalBlock(scope: !1618, file: !2, line: 46, column: 27)
!1686 = !DILocation(line: 46, column: 20, scope: !1618)
!1687 = distinct !{!1687, !1683, !1688, !370, !371}
!1688 = !DILocation(line: 50, column: 3, scope: !1618)
!1689 = !DILocation(line: 47, column: 24, scope: !1685)
!1690 = !DILocation(line: 47, column: 42, scope: !1685)
!1691 = !DILocation(line: 47, column: 14, scope: !1685)
!1692 = !DILocation(line: 48, column: 5, scope: !1693)
!1693 = distinct !DILexicalBlock(scope: !1694, file: !2, line: 48, column: 5)
!1694 = distinct !DILexicalBlock(scope: !1685, file: !2, line: 48, column: 5)
!1695 = !DILocation(line: 51, column: 3, scope: !1618)
!1696 = !DILocation(line: 51, column: 10, scope: !1618)
!1697 = !DILocation(line: 52, column: 3, scope: !1618)
!1698 = !DILocation(line: 54, column: 1, scope: !1618)
!1699 = !DILocation(line: 53, column: 3, scope: !1618)
!1700 = !DISubprogram(name: "__assert_fail", scope: !1701, file: !1701, line: 67, type: !1702, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!1701 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!1702 = !DISubroutineType(types: !1703)
!1703 = !{null, !1704, !1704, !240, !1704}
!1704 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!1705 = !DISubprogram(name: "fstat", scope: !1706, file: !1706, line: 210, type: !1707, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1706 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!1707 = !DISubroutineType(types: !1708)
!1708 = !{!202, !202, !1709}
!1709 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1625, size: 64)
!1710 = !DISubprogram(name: "malloc", scope: !1463, file: !1463, line: 672, type: !1711, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1711 = !DISubroutineType(types: !1712)
!1712 = !{!229, !386}
!1713 = !DISubprogram(name: "read", scope: !1714, file: !1714, line: 371, type: !1715, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1714 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!1715 = !DISubroutineType(types: !1716)
!1716 = !{!1665, !202, !229, !386}
!1717 = !DISubprogram(name: "close", scope: !1714, file: !1714, line: 358, type: !1472, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1718 = !DILocation(line: 0, scope: !1411)
!1719 = !DILocation(line: 59, column: 3, scope: !1720)
!1720 = distinct !DILexicalBlock(scope: !1721, file: !2, line: 59, column: 3)
!1721 = distinct !DILexicalBlock(scope: !1411, file: !2, line: 59, column: 3)
!1722 = !DILocation(line: 60, column: 7, scope: !1723)
!1723 = distinct !DILexicalBlock(scope: !1411, file: !2, line: 60, column: 6)
!1724 = !DILocation(line: 60, column: 6, scope: !1411)
!1725 = !DILocation(line: 64, column: 17, scope: !1411)
!1726 = !DILocation(line: 64, column: 3, scope: !1411)
!1727 = !DILocation(line: 66, column: 22, scope: !1423)
!1728 = !DILocation(line: 66, column: 26, scope: !1423)
!1729 = !DILocation(line: 66, column: 32, scope: !1423)
!1730 = !DILocation(line: 66, column: 35, scope: !1423)
!1731 = !DILocation(line: 66, column: 39, scope: !1423)
!1732 = !DILocation(line: 66, column: 9, scope: !1424)
!1733 = !DILocation(line: 69, column: 6, scope: !1424)
!1734 = !DILocation(line: 64, column: 10, scope: !1411)
!1735 = !DILocation(line: 64, column: 13, scope: !1411)
!1736 = distinct !{!1736, !1726, !1737, !370, !371}
!1737 = !DILocation(line: 70, column: 3, scope: !1411)
!1738 = !DILocation(line: 71, column: 6, scope: !1436)
!1739 = !DILocation(line: 71, column: 8, scope: !1436)
!1740 = !DILocation(line: 71, column: 6, scope: !1411)
!1741 = !DILocation(line: 74, column: 1, scope: !1411)
!1742 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !1743, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !1745)
!1743 = !DISubroutineType(types: !1744)
!1744 = !{!202, !228, !228, !202}
!1745 = !{!1746, !1747, !1748, !1749}
!1746 = !DILocalVariable(name: "s", arg: 1, scope: !1742, file: !2, line: 77, type: !228)
!1747 = !DILocalVariable(name: "arr", arg: 2, scope: !1742, file: !2, line: 77, type: !228)
!1748 = !DILocalVariable(name: "n", arg: 3, scope: !1742, file: !2, line: 77, type: !202)
!1749 = !DILocalVariable(name: "k", scope: !1742, file: !2, line: 78, type: !202)
!1750 = !DILocation(line: 0, scope: !1742)
!1751 = !DILocation(line: 79, column: 3, scope: !1752)
!1752 = distinct !DILexicalBlock(scope: !1753, file: !2, line: 79, column: 3)
!1753 = distinct !DILexicalBlock(scope: !1742, file: !2, line: 79, column: 3)
!1754 = !DILocation(line: 81, column: 8, scope: !1755)
!1755 = distinct !DILexicalBlock(scope: !1742, file: !2, line: 81, column: 7)
!1756 = !DILocation(line: 81, column: 7, scope: !1742)
!1757 = !DILocation(line: 83, column: 12, scope: !1758)
!1758 = distinct !DILexicalBlock(scope: !1755, file: !2, line: 81, column: 13)
!1759 = !DILocation(line: 83, column: 5, scope: !1758)
!1760 = !DILocation(line: 91, column: 19, scope: !1742)
!1761 = !DILocation(line: 91, column: 3, scope: !1742)
!1762 = !DILocation(line: 92, column: 7, scope: !1742)
!1763 = !DILocation(line: 83, column: 16, scope: !1758)
!1764 = !DILocation(line: 83, column: 26, scope: !1758)
!1765 = !DILocation(line: 83, column: 32, scope: !1758)
!1766 = !DILocation(line: 83, column: 29, scope: !1758)
!1767 = !DILocation(line: 83, column: 35, scope: !1758)
!1768 = !DILocation(line: 83, column: 45, scope: !1758)
!1769 = !DILocation(line: 83, column: 48, scope: !1758)
!1770 = !DILocation(line: 83, column: 54, scope: !1758)
!1771 = !DILocation(line: 84, column: 9, scope: !1758)
!1772 = !DILocation(line: 84, column: 18, scope: !1758)
!1773 = !DILocation(line: 84, column: 26, scope: !1758)
!1774 = distinct !{!1774, !1759, !1775, !370, !371}
!1775 = !DILocation(line: 86, column: 5, scope: !1758)
!1776 = !DILocation(line: 93, column: 5, scope: !1777)
!1777 = distinct !DILexicalBlock(scope: !1742, file: !2, line: 92, column: 7)
!1778 = !DILocation(line: 93, column: 12, scope: !1777)
!1779 = !DILocation(line: 95, column: 3, scope: !1742)
!1780 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !1781, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !1784)
!1781 = !DISubroutineType(types: !1782)
!1782 = !{!202, !228, !1783, !202}
!1783 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !230, size: 64)
!1784 = !{!1785, !1786, !1787, !1788, !1789, !1790, !1791}
!1785 = !DILocalVariable(name: "s", arg: 1, scope: !1780, file: !2, line: 132, type: !228)
!1786 = !DILocalVariable(name: "arr", arg: 2, scope: !1780, file: !2, line: 132, type: !1783)
!1787 = !DILocalVariable(name: "n", arg: 3, scope: !1780, file: !2, line: 132, type: !202)
!1788 = !DILocalVariable(name: "line", scope: !1780, file: !2, line: 132, type: !228)
!1789 = !DILocalVariable(name: "endptr", scope: !1780, file: !2, line: 132, type: !228)
!1790 = !DILocalVariable(name: "i", scope: !1780, file: !2, line: 132, type: !202)
!1791 = !DILocalVariable(name: "v", scope: !1780, file: !2, line: 132, type: !230)
!1792 = distinct !DIAssignID()
!1793 = !DILocation(line: 0, scope: !1780)
!1794 = !DILocation(line: 132, column: 1, scope: !1780)
!1795 = !DILocation(line: 132, column: 1, scope: !1796)
!1796 = distinct !DILexicalBlock(scope: !1797, file: !2, line: 132, column: 1)
!1797 = distinct !DILexicalBlock(scope: !1780, file: !2, line: 132, column: 1)
!1798 = !DILocation(line: 132, column: 1, scope: !1799)
!1799 = distinct !DILexicalBlock(scope: !1780, file: !2, line: 132, column: 1)
!1800 = !{!1801, !1801, i64 0}
!1801 = !{!"any pointer", !352, i64 0}
!1802 = distinct !DIAssignID()
!1803 = !DILocation(line: 132, column: 1, scope: !1804)
!1804 = distinct !DILexicalBlock(scope: !1799, file: !2, line: 132, column: 1)
!1805 = !DILocation(line: 132, column: 1, scope: !1806)
!1806 = distinct !DILexicalBlock(scope: !1804, file: !2, line: 132, column: 1)
!1807 = distinct !{!1807, !1794, !1794, !370, !371}
!1808 = !DILocation(line: 132, column: 1, scope: !1809)
!1809 = distinct !DILexicalBlock(scope: !1810, file: !2, line: 132, column: 1)
!1810 = distinct !DILexicalBlock(scope: !1780, file: !2, line: 132, column: 1)
!1811 = !DISubprogram(name: "strtok", scope: !1812, file: !1812, line: 356, type: !1813, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1812 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!1813 = !DISubroutineType(types: !1814)
!1814 = !{!228, !1815, !1816}
!1815 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !228)
!1816 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1704)
!1817 = !DISubprogram(name: "strtol", scope: !1463, file: !1463, line: 177, type: !1818, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1818 = !DISubroutineType(types: !1819)
!1819 = !{!255, !1816, !1820, !202}
!1820 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1821)
!1821 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !228, size: 64)
!1822 = !DISubprogram(name: "fprintf", scope: !1823, file: !1823, line: 357, type: !1824, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1823 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!1824 = !DISubroutineType(types: !1825)
!1825 = !{!202, !1826, !1816, null}
!1826 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1827)
!1827 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1828, size: 64)
!1828 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !1829, line: 7, baseType: !1830)
!1829 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!1830 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !1831, line: 49, size: 1728, elements: !1832)
!1831 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!1832 = !{!1833, !1834, !1835, !1836, !1837, !1838, !1839, !1840, !1841, !1842, !1843, !1844, !1845, !1848, !1850, !1851, !1852, !1853, !1854, !1855, !1859, !1862, !1864, !1867, !1870, !1871, !1872, !1874, !1875}
!1833 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !1830, file: !1831, line: 51, baseType: !202, size: 32)
!1834 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !1830, file: !1831, line: 54, baseType: !228, size: 64, offset: 64)
!1835 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !1830, file: !1831, line: 55, baseType: !228, size: 64, offset: 128)
!1836 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !1830, file: !1831, line: 56, baseType: !228, size: 64, offset: 192)
!1837 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !1830, file: !1831, line: 57, baseType: !228, size: 64, offset: 256)
!1838 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !1830, file: !1831, line: 58, baseType: !228, size: 64, offset: 320)
!1839 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !1830, file: !1831, line: 59, baseType: !228, size: 64, offset: 384)
!1840 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !1830, file: !1831, line: 60, baseType: !228, size: 64, offset: 448)
!1841 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !1830, file: !1831, line: 61, baseType: !228, size: 64, offset: 512)
!1842 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !1830, file: !1831, line: 64, baseType: !228, size: 64, offset: 576)
!1843 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !1830, file: !1831, line: 65, baseType: !228, size: 64, offset: 640)
!1844 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !1830, file: !1831, line: 66, baseType: !228, size: 64, offset: 704)
!1845 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !1830, file: !1831, line: 68, baseType: !1846, size: 64, offset: 768)
!1846 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1847, size: 64)
!1847 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !1831, line: 36, flags: DIFlagFwdDecl)
!1848 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !1830, file: !1831, line: 70, baseType: !1849, size: 64, offset: 832)
!1849 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1830, size: 64)
!1850 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !1830, file: !1831, line: 72, baseType: !202, size: 32, offset: 896)
!1851 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !1830, file: !1831, line: 73, baseType: !202, size: 32, offset: 928)
!1852 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !1830, file: !1831, line: 74, baseType: !1643, size: 64, offset: 960)
!1853 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !1830, file: !1831, line: 77, baseType: !237, size: 16, offset: 1024)
!1854 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !1830, file: !1831, line: 78, baseType: !247, size: 8, offset: 1040)
!1855 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !1830, file: !1831, line: 79, baseType: !1856, size: 8, offset: 1048)
!1856 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !1857)
!1857 = !{!1858}
!1858 = !DISubrange(count: 1)
!1859 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !1830, file: !1831, line: 81, baseType: !1860, size: 64, offset: 1088)
!1860 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1861, size: 64)
!1861 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !1831, line: 43, baseType: null)
!1862 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !1830, file: !1831, line: 89, baseType: !1863, size: 64, offset: 1152)
!1863 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !233, line: 153, baseType: !255)
!1864 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !1830, file: !1831, line: 91, baseType: !1865, size: 64, offset: 1216)
!1865 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1866, size: 64)
!1866 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !1831, line: 37, flags: DIFlagFwdDecl)
!1867 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !1830, file: !1831, line: 92, baseType: !1868, size: 64, offset: 1280)
!1868 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1869, size: 64)
!1869 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !1831, line: 38, flags: DIFlagFwdDecl)
!1870 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !1830, file: !1831, line: 93, baseType: !1849, size: 64, offset: 1344)
!1871 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !1830, file: !1831, line: 94, baseType: !229, size: 64, offset: 1408)
!1872 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !1830, file: !1831, line: 95, baseType: !1873, size: 64, offset: 1472)
!1873 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1849, size: 64)
!1874 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !1830, file: !1831, line: 96, baseType: !202, size: 32, offset: 1536)
!1875 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !1830, file: !1831, line: 98, baseType: !1876, size: 160, offset: 1568)
!1876 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!1877 = !DISubprogram(name: "strlen", scope: !1812, file: !1812, line: 407, type: !1878, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1878 = !DISubroutineType(types: !1879)
!1879 = !{!243, !1704}
!1880 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !1881, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !1884)
!1881 = !DISubroutineType(types: !1882)
!1882 = !{!202, !228, !1883, !202}
!1883 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !235, size: 64)
!1884 = !{!1885, !1886, !1887, !1888, !1889, !1890, !1891}
!1885 = !DILocalVariable(name: "s", arg: 1, scope: !1880, file: !2, line: 133, type: !228)
!1886 = !DILocalVariable(name: "arr", arg: 2, scope: !1880, file: !2, line: 133, type: !1883)
!1887 = !DILocalVariable(name: "n", arg: 3, scope: !1880, file: !2, line: 133, type: !202)
!1888 = !DILocalVariable(name: "line", scope: !1880, file: !2, line: 133, type: !228)
!1889 = !DILocalVariable(name: "endptr", scope: !1880, file: !2, line: 133, type: !228)
!1890 = !DILocalVariable(name: "i", scope: !1880, file: !2, line: 133, type: !202)
!1891 = !DILocalVariable(name: "v", scope: !1880, file: !2, line: 133, type: !235)
!1892 = distinct !DIAssignID()
!1893 = !DILocation(line: 0, scope: !1880)
!1894 = !DILocation(line: 133, column: 1, scope: !1880)
!1895 = !DILocation(line: 133, column: 1, scope: !1896)
!1896 = distinct !DILexicalBlock(scope: !1897, file: !2, line: 133, column: 1)
!1897 = distinct !DILexicalBlock(scope: !1880, file: !2, line: 133, column: 1)
!1898 = !DILocation(line: 133, column: 1, scope: !1899)
!1899 = distinct !DILexicalBlock(scope: !1880, file: !2, line: 133, column: 1)
!1900 = distinct !DIAssignID()
!1901 = !DILocation(line: 133, column: 1, scope: !1902)
!1902 = distinct !DILexicalBlock(scope: !1899, file: !2, line: 133, column: 1)
!1903 = !DILocation(line: 133, column: 1, scope: !1904)
!1904 = distinct !DILexicalBlock(scope: !1902, file: !2, line: 133, column: 1)
!1905 = !{!1906, !1906, i64 0}
!1906 = !{!"short", !352, i64 0}
!1907 = distinct !{!1907, !1894, !1894, !370, !371}
!1908 = !DILocation(line: 133, column: 1, scope: !1909)
!1909 = distinct !DILexicalBlock(scope: !1910, file: !2, line: 133, column: 1)
!1910 = distinct !DILexicalBlock(scope: !1880, file: !2, line: 133, column: 1)
!1911 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !1912, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !1915)
!1912 = !DISubroutineType(types: !1913)
!1913 = !{!202, !228, !1914, !202}
!1914 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !238, size: 64)
!1915 = !{!1916, !1917, !1918, !1919, !1920, !1921, !1922}
!1916 = !DILocalVariable(name: "s", arg: 1, scope: !1911, file: !2, line: 134, type: !228)
!1917 = !DILocalVariable(name: "arr", arg: 2, scope: !1911, file: !2, line: 134, type: !1914)
!1918 = !DILocalVariable(name: "n", arg: 3, scope: !1911, file: !2, line: 134, type: !202)
!1919 = !DILocalVariable(name: "line", scope: !1911, file: !2, line: 134, type: !228)
!1920 = !DILocalVariable(name: "endptr", scope: !1911, file: !2, line: 134, type: !228)
!1921 = !DILocalVariable(name: "i", scope: !1911, file: !2, line: 134, type: !202)
!1922 = !DILocalVariable(name: "v", scope: !1911, file: !2, line: 134, type: !238)
!1923 = distinct !DIAssignID()
!1924 = !DILocation(line: 0, scope: !1911)
!1925 = !DILocation(line: 134, column: 1, scope: !1911)
!1926 = !DILocation(line: 134, column: 1, scope: !1927)
!1927 = distinct !DILexicalBlock(scope: !1928, file: !2, line: 134, column: 1)
!1928 = distinct !DILexicalBlock(scope: !1911, file: !2, line: 134, column: 1)
!1929 = !DILocation(line: 134, column: 1, scope: !1930)
!1930 = distinct !DILexicalBlock(scope: !1911, file: !2, line: 134, column: 1)
!1931 = distinct !DIAssignID()
!1932 = !DILocation(line: 134, column: 1, scope: !1933)
!1933 = distinct !DILexicalBlock(scope: !1930, file: !2, line: 134, column: 1)
!1934 = !DILocation(line: 134, column: 1, scope: !1935)
!1935 = distinct !DILexicalBlock(scope: !1933, file: !2, line: 134, column: 1)
!1936 = distinct !{!1936, !1925, !1925, !370, !371}
!1937 = !DILocation(line: 134, column: 1, scope: !1938)
!1938 = distinct !DILexicalBlock(scope: !1939, file: !2, line: 134, column: 1)
!1939 = distinct !DILexicalBlock(scope: !1911, file: !2, line: 134, column: 1)
!1940 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !1941, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !1944)
!1941 = !DISubroutineType(types: !1942)
!1942 = !{!202, !228, !1943, !202}
!1943 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !241, size: 64)
!1944 = !{!1945, !1946, !1947, !1948, !1949, !1950, !1951}
!1945 = !DILocalVariable(name: "s", arg: 1, scope: !1940, file: !2, line: 135, type: !228)
!1946 = !DILocalVariable(name: "arr", arg: 2, scope: !1940, file: !2, line: 135, type: !1943)
!1947 = !DILocalVariable(name: "n", arg: 3, scope: !1940, file: !2, line: 135, type: !202)
!1948 = !DILocalVariable(name: "line", scope: !1940, file: !2, line: 135, type: !228)
!1949 = !DILocalVariable(name: "endptr", scope: !1940, file: !2, line: 135, type: !228)
!1950 = !DILocalVariable(name: "i", scope: !1940, file: !2, line: 135, type: !202)
!1951 = !DILocalVariable(name: "v", scope: !1940, file: !2, line: 135, type: !241)
!1952 = distinct !DIAssignID()
!1953 = !DILocation(line: 0, scope: !1940)
!1954 = !DILocation(line: 135, column: 1, scope: !1940)
!1955 = !DILocation(line: 135, column: 1, scope: !1956)
!1956 = distinct !DILexicalBlock(scope: !1957, file: !2, line: 135, column: 1)
!1957 = distinct !DILexicalBlock(scope: !1940, file: !2, line: 135, column: 1)
!1958 = !DILocation(line: 135, column: 1, scope: !1959)
!1959 = distinct !DILexicalBlock(scope: !1940, file: !2, line: 135, column: 1)
!1960 = distinct !DIAssignID()
!1961 = !DILocation(line: 135, column: 1, scope: !1962)
!1962 = distinct !DILexicalBlock(scope: !1959, file: !2, line: 135, column: 1)
!1963 = !DILocation(line: 135, column: 1, scope: !1964)
!1964 = distinct !DILexicalBlock(scope: !1962, file: !2, line: 135, column: 1)
!1965 = !{!1966, !1966, i64 0}
!1966 = !{!"long", !352, i64 0}
!1967 = distinct !{!1967, !1954, !1954, !370, !371}
!1968 = !DILocation(line: 135, column: 1, scope: !1969)
!1969 = distinct !DILexicalBlock(scope: !1970, file: !2, line: 135, column: 1)
!1970 = distinct !DILexicalBlock(scope: !1940, file: !2, line: 135, column: 1)
!1971 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1972, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !1975)
!1972 = !DISubroutineType(types: !1973)
!1973 = !{!202, !228, !1974, !202}
!1974 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !244, size: 64)
!1975 = !{!1976, !1977, !1978, !1979, !1980, !1981, !1982}
!1976 = !DILocalVariable(name: "s", arg: 1, scope: !1971, file: !2, line: 136, type: !228)
!1977 = !DILocalVariable(name: "arr", arg: 2, scope: !1971, file: !2, line: 136, type: !1974)
!1978 = !DILocalVariable(name: "n", arg: 3, scope: !1971, file: !2, line: 136, type: !202)
!1979 = !DILocalVariable(name: "line", scope: !1971, file: !2, line: 136, type: !228)
!1980 = !DILocalVariable(name: "endptr", scope: !1971, file: !2, line: 136, type: !228)
!1981 = !DILocalVariable(name: "i", scope: !1971, file: !2, line: 136, type: !202)
!1982 = !DILocalVariable(name: "v", scope: !1971, file: !2, line: 136, type: !244)
!1983 = distinct !DIAssignID()
!1984 = !DILocation(line: 0, scope: !1971)
!1985 = !DILocation(line: 136, column: 1, scope: !1971)
!1986 = !DILocation(line: 136, column: 1, scope: !1987)
!1987 = distinct !DILexicalBlock(scope: !1988, file: !2, line: 136, column: 1)
!1988 = distinct !DILexicalBlock(scope: !1971, file: !2, line: 136, column: 1)
!1989 = !DILocation(line: 136, column: 1, scope: !1990)
!1990 = distinct !DILexicalBlock(scope: !1971, file: !2, line: 136, column: 1)
!1991 = distinct !DIAssignID()
!1992 = !DILocation(line: 136, column: 1, scope: !1993)
!1993 = distinct !DILexicalBlock(scope: !1990, file: !2, line: 136, column: 1)
!1994 = !DILocation(line: 136, column: 1, scope: !1995)
!1995 = distinct !DILexicalBlock(scope: !1993, file: !2, line: 136, column: 1)
!1996 = distinct !{!1996, !1985, !1985, !370, !371}
!1997 = !DILocation(line: 136, column: 1, scope: !1998)
!1998 = distinct !DILexicalBlock(scope: !1999, file: !2, line: 136, column: 1)
!1999 = distinct !DILexicalBlock(scope: !1971, file: !2, line: 136, column: 1)
!2000 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !2001, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2004)
!2001 = !DISubroutineType(types: !2002)
!2002 = !{!202, !228, !2003, !202}
!2003 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !248, size: 64)
!2004 = !{!2005, !2006, !2007, !2008, !2009, !2010, !2011}
!2005 = !DILocalVariable(name: "s", arg: 1, scope: !2000, file: !2, line: 137, type: !228)
!2006 = !DILocalVariable(name: "arr", arg: 2, scope: !2000, file: !2, line: 137, type: !2003)
!2007 = !DILocalVariable(name: "n", arg: 3, scope: !2000, file: !2, line: 137, type: !202)
!2008 = !DILocalVariable(name: "line", scope: !2000, file: !2, line: 137, type: !228)
!2009 = !DILocalVariable(name: "endptr", scope: !2000, file: !2, line: 137, type: !228)
!2010 = !DILocalVariable(name: "i", scope: !2000, file: !2, line: 137, type: !202)
!2011 = !DILocalVariable(name: "v", scope: !2000, file: !2, line: 137, type: !248)
!2012 = distinct !DIAssignID()
!2013 = !DILocation(line: 0, scope: !2000)
!2014 = !DILocation(line: 137, column: 1, scope: !2000)
!2015 = !DILocation(line: 137, column: 1, scope: !2016)
!2016 = distinct !DILexicalBlock(scope: !2017, file: !2, line: 137, column: 1)
!2017 = distinct !DILexicalBlock(scope: !2000, file: !2, line: 137, column: 1)
!2018 = !DILocation(line: 137, column: 1, scope: !2019)
!2019 = distinct !DILexicalBlock(scope: !2000, file: !2, line: 137, column: 1)
!2020 = distinct !DIAssignID()
!2021 = !DILocation(line: 137, column: 1, scope: !2022)
!2022 = distinct !DILexicalBlock(scope: !2019, file: !2, line: 137, column: 1)
!2023 = !DILocation(line: 137, column: 1, scope: !2024)
!2024 = distinct !DILexicalBlock(scope: !2022, file: !2, line: 137, column: 1)
!2025 = distinct !{!2025, !2014, !2014, !370, !371}
!2026 = !DILocation(line: 137, column: 1, scope: !2027)
!2027 = distinct !DILexicalBlock(scope: !2028, file: !2, line: 137, column: 1)
!2028 = distinct !DILexicalBlock(scope: !2000, file: !2, line: 137, column: 1)
!2029 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !2030, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2033)
!2030 = !DISubroutineType(types: !2031)
!2031 = !{!202, !228, !2032, !202}
!2032 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !251, size: 64)
!2033 = !{!2034, !2035, !2036, !2037, !2038, !2039, !2040}
!2034 = !DILocalVariable(name: "s", arg: 1, scope: !2029, file: !2, line: 138, type: !228)
!2035 = !DILocalVariable(name: "arr", arg: 2, scope: !2029, file: !2, line: 138, type: !2032)
!2036 = !DILocalVariable(name: "n", arg: 3, scope: !2029, file: !2, line: 138, type: !202)
!2037 = !DILocalVariable(name: "line", scope: !2029, file: !2, line: 138, type: !228)
!2038 = !DILocalVariable(name: "endptr", scope: !2029, file: !2, line: 138, type: !228)
!2039 = !DILocalVariable(name: "i", scope: !2029, file: !2, line: 138, type: !202)
!2040 = !DILocalVariable(name: "v", scope: !2029, file: !2, line: 138, type: !251)
!2041 = distinct !DIAssignID()
!2042 = !DILocation(line: 0, scope: !2029)
!2043 = !DILocation(line: 138, column: 1, scope: !2029)
!2044 = !DILocation(line: 138, column: 1, scope: !2045)
!2045 = distinct !DILexicalBlock(scope: !2046, file: !2, line: 138, column: 1)
!2046 = distinct !DILexicalBlock(scope: !2029, file: !2, line: 138, column: 1)
!2047 = !DILocation(line: 138, column: 1, scope: !2048)
!2048 = distinct !DILexicalBlock(scope: !2029, file: !2, line: 138, column: 1)
!2049 = distinct !DIAssignID()
!2050 = !DILocation(line: 138, column: 1, scope: !2051)
!2051 = distinct !DILexicalBlock(scope: !2048, file: !2, line: 138, column: 1)
!2052 = !DILocation(line: 138, column: 1, scope: !2053)
!2053 = distinct !DILexicalBlock(scope: !2051, file: !2, line: 138, column: 1)
!2054 = distinct !{!2054, !2043, !2043, !370, !371}
!2055 = !DILocation(line: 138, column: 1, scope: !2056)
!2056 = distinct !DILexicalBlock(scope: !2057, file: !2, line: 138, column: 1)
!2057 = distinct !DILexicalBlock(scope: !2029, file: !2, line: 138, column: 1)
!2058 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !2059, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2062)
!2059 = !DISubroutineType(types: !2060)
!2060 = !{!202, !228, !2061, !202}
!2061 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !253, size: 64)
!2062 = !{!2063, !2064, !2065, !2066, !2067, !2068, !2069}
!2063 = !DILocalVariable(name: "s", arg: 1, scope: !2058, file: !2, line: 139, type: !228)
!2064 = !DILocalVariable(name: "arr", arg: 2, scope: !2058, file: !2, line: 139, type: !2061)
!2065 = !DILocalVariable(name: "n", arg: 3, scope: !2058, file: !2, line: 139, type: !202)
!2066 = !DILocalVariable(name: "line", scope: !2058, file: !2, line: 139, type: !228)
!2067 = !DILocalVariable(name: "endptr", scope: !2058, file: !2, line: 139, type: !228)
!2068 = !DILocalVariable(name: "i", scope: !2058, file: !2, line: 139, type: !202)
!2069 = !DILocalVariable(name: "v", scope: !2058, file: !2, line: 139, type: !253)
!2070 = distinct !DIAssignID()
!2071 = !DILocation(line: 0, scope: !2058)
!2072 = !DILocation(line: 139, column: 1, scope: !2058)
!2073 = !DILocation(line: 139, column: 1, scope: !2074)
!2074 = distinct !DILexicalBlock(scope: !2075, file: !2, line: 139, column: 1)
!2075 = distinct !DILexicalBlock(scope: !2058, file: !2, line: 139, column: 1)
!2076 = !DILocation(line: 139, column: 1, scope: !2077)
!2077 = distinct !DILexicalBlock(scope: !2058, file: !2, line: 139, column: 1)
!2078 = distinct !DIAssignID()
!2079 = !DILocation(line: 139, column: 1, scope: !2080)
!2080 = distinct !DILexicalBlock(scope: !2077, file: !2, line: 139, column: 1)
!2081 = !DILocation(line: 139, column: 1, scope: !2082)
!2082 = distinct !DILexicalBlock(scope: !2080, file: !2, line: 139, column: 1)
!2083 = distinct !{!2083, !2072, !2072, !370, !371}
!2084 = !DILocation(line: 139, column: 1, scope: !2085)
!2085 = distinct !DILexicalBlock(scope: !2086, file: !2, line: 139, column: 1)
!2086 = distinct !DILexicalBlock(scope: !2058, file: !2, line: 139, column: 1)
!2087 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !2088, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2091)
!2088 = !DISubroutineType(types: !2089)
!2089 = !{!202, !228, !2090, !202}
!2090 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !256, size: 64)
!2091 = !{!2092, !2093, !2094, !2095, !2096, !2097, !2098}
!2092 = !DILocalVariable(name: "s", arg: 1, scope: !2087, file: !2, line: 141, type: !228)
!2093 = !DILocalVariable(name: "arr", arg: 2, scope: !2087, file: !2, line: 141, type: !2090)
!2094 = !DILocalVariable(name: "n", arg: 3, scope: !2087, file: !2, line: 141, type: !202)
!2095 = !DILocalVariable(name: "line", scope: !2087, file: !2, line: 141, type: !228)
!2096 = !DILocalVariable(name: "endptr", scope: !2087, file: !2, line: 141, type: !228)
!2097 = !DILocalVariable(name: "i", scope: !2087, file: !2, line: 141, type: !202)
!2098 = !DILocalVariable(name: "v", scope: !2087, file: !2, line: 141, type: !256)
!2099 = distinct !DIAssignID()
!2100 = !DILocation(line: 0, scope: !2087)
!2101 = !DILocation(line: 141, column: 1, scope: !2087)
!2102 = !DILocation(line: 141, column: 1, scope: !2103)
!2103 = distinct !DILexicalBlock(scope: !2104, file: !2, line: 141, column: 1)
!2104 = distinct !DILexicalBlock(scope: !2087, file: !2, line: 141, column: 1)
!2105 = !DILocation(line: 141, column: 1, scope: !2106)
!2106 = distinct !DILexicalBlock(scope: !2087, file: !2, line: 141, column: 1)
!2107 = distinct !DIAssignID()
!2108 = !DILocation(line: 141, column: 1, scope: !2109)
!2109 = distinct !DILexicalBlock(scope: !2106, file: !2, line: 141, column: 1)
!2110 = !DILocation(line: 141, column: 1, scope: !2111)
!2111 = distinct !DILexicalBlock(scope: !2109, file: !2, line: 141, column: 1)
!2112 = !{!2113, !2113, i64 0}
!2113 = !{!"float", !352, i64 0}
!2114 = distinct !{!2114, !2101, !2101, !370, !371}
!2115 = !DILocation(line: 141, column: 1, scope: !2116)
!2116 = distinct !DILexicalBlock(scope: !2117, file: !2, line: 141, column: 1)
!2117 = distinct !DILexicalBlock(scope: !2087, file: !2, line: 141, column: 1)
!2118 = !DISubprogram(name: "strtof", scope: !1463, file: !1463, line: 124, type: !2119, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2119 = !DISubroutineType(types: !2120)
!2120 = !{!256, !1816, !1820}
!2121 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !2122, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2124)
!2122 = !DISubroutineType(types: !2123)
!2123 = !{!202, !228, !327, !202}
!2124 = !{!2125, !2126, !2127, !2128, !2129, !2130, !2131}
!2125 = !DILocalVariable(name: "s", arg: 1, scope: !2121, file: !2, line: 142, type: !228)
!2126 = !DILocalVariable(name: "arr", arg: 2, scope: !2121, file: !2, line: 142, type: !327)
!2127 = !DILocalVariable(name: "n", arg: 3, scope: !2121, file: !2, line: 142, type: !202)
!2128 = !DILocalVariable(name: "line", scope: !2121, file: !2, line: 142, type: !228)
!2129 = !DILocalVariable(name: "endptr", scope: !2121, file: !2, line: 142, type: !228)
!2130 = !DILocalVariable(name: "i", scope: !2121, file: !2, line: 142, type: !202)
!2131 = !DILocalVariable(name: "v", scope: !2121, file: !2, line: 142, type: !197)
!2132 = distinct !DIAssignID()
!2133 = !DILocation(line: 0, scope: !2121)
!2134 = !DILocation(line: 142, column: 1, scope: !2121)
!2135 = !DILocation(line: 142, column: 1, scope: !2136)
!2136 = distinct !DILexicalBlock(scope: !2137, file: !2, line: 142, column: 1)
!2137 = distinct !DILexicalBlock(scope: !2121, file: !2, line: 142, column: 1)
!2138 = !DILocation(line: 142, column: 1, scope: !2139)
!2139 = distinct !DILexicalBlock(scope: !2121, file: !2, line: 142, column: 1)
!2140 = distinct !DIAssignID()
!2141 = !DILocation(line: 142, column: 1, scope: !2142)
!2142 = distinct !DILexicalBlock(scope: !2139, file: !2, line: 142, column: 1)
!2143 = !DILocation(line: 142, column: 1, scope: !2144)
!2144 = distinct !DILexicalBlock(scope: !2142, file: !2, line: 142, column: 1)
!2145 = distinct !{!2145, !2134, !2134, !370, !371}
!2146 = !DILocation(line: 142, column: 1, scope: !2147)
!2147 = distinct !DILexicalBlock(scope: !2148, file: !2, line: 142, column: 1)
!2148 = distinct !DILexicalBlock(scope: !2121, file: !2, line: 142, column: 1)
!2149 = !DISubprogram(name: "strtod", scope: !1463, file: !1463, line: 118, type: !2150, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2150 = !DISubroutineType(types: !2151)
!2151 = !{!197, !1816, !1820}
!2152 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !2153, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2155)
!2153 = !DISubroutineType(types: !2154)
!2154 = !{!202, !202, !228, !202}
!2155 = !{!2156, !2157, !2158, !2159, !2160}
!2156 = !DILocalVariable(name: "fd", arg: 1, scope: !2152, file: !2, line: 145, type: !202)
!2157 = !DILocalVariable(name: "arr", arg: 2, scope: !2152, file: !2, line: 145, type: !228)
!2158 = !DILocalVariable(name: "n", arg: 3, scope: !2152, file: !2, line: 145, type: !202)
!2159 = !DILocalVariable(name: "status", scope: !2152, file: !2, line: 146, type: !202)
!2160 = !DILocalVariable(name: "written", scope: !2152, file: !2, line: 146, type: !202)
!2161 = !DILocation(line: 0, scope: !2152)
!2162 = !DILocation(line: 147, column: 3, scope: !2163)
!2163 = distinct !DILexicalBlock(scope: !2164, file: !2, line: 147, column: 3)
!2164 = distinct !DILexicalBlock(scope: !2152, file: !2, line: 147, column: 3)
!2165 = !DILocation(line: 148, column: 8, scope: !2166)
!2166 = distinct !DILexicalBlock(scope: !2152, file: !2, line: 148, column: 7)
!2167 = !DILocation(line: 148, column: 7, scope: !2152)
!2168 = !DILocation(line: 149, column: 9, scope: !2169)
!2169 = distinct !DILexicalBlock(scope: !2166, file: !2, line: 148, column: 13)
!2170 = !DILocation(line: 150, column: 3, scope: !2169)
!2171 = !DILocation(line: 152, column: 16, scope: !2152)
!2172 = !DILocation(line: 152, column: 3, scope: !2152)
!2173 = !DILocation(line: 158, column: 3, scope: !2152)
!2174 = !DILocation(line: 155, column: 13, scope: !2175)
!2175 = distinct !DILexicalBlock(scope: !2152, file: !2, line: 152, column: 20)
!2176 = distinct !{!2176, !2172, !2177, !370, !371}
!2177 = !DILocation(line: 156, column: 3, scope: !2152)
!2178 = !DILocation(line: 153, column: 25, scope: !2175)
!2179 = !DILocation(line: 153, column: 40, scope: !2175)
!2180 = !DILocation(line: 153, column: 39, scope: !2175)
!2181 = !DILocation(line: 153, column: 14, scope: !2175)
!2182 = !DILocation(line: 154, column: 5, scope: !2183)
!2183 = distinct !DILexicalBlock(scope: !2184, file: !2, line: 154, column: 5)
!2184 = distinct !DILexicalBlock(scope: !2175, file: !2, line: 154, column: 5)
!2185 = !DILocation(line: 159, column: 14, scope: !2186)
!2186 = distinct !DILexicalBlock(scope: !2152, file: !2, line: 158, column: 6)
!2187 = !DILocation(line: 160, column: 5, scope: !2188)
!2188 = distinct !DILexicalBlock(scope: !2189, file: !2, line: 160, column: 5)
!2189 = distinct !DILexicalBlock(scope: !2186, file: !2, line: 160, column: 5)
!2190 = !DILocation(line: 161, column: 17, scope: !2152)
!2191 = !DILocation(line: 161, column: 3, scope: !2186)
!2192 = distinct !{!2192, !2173, !2193, !370, !371}
!2193 = !DILocation(line: 161, column: 20, scope: !2152)
!2194 = !DILocation(line: 163, column: 3, scope: !2152)
!2195 = !DISubprogram(name: "write", scope: !1714, file: !1714, line: 378, type: !2196, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2196 = !DISubroutineType(types: !2197)
!2197 = !{!1665, !202, !2198, !386}
!2198 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !2199, size: 64)
!2199 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!2200 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !2201, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2203)
!2201 = !DISubroutineType(types: !2202)
!2202 = !{!202, !202, !1783, !202}
!2203 = !{!2204, !2205, !2206, !2207}
!2204 = !DILocalVariable(name: "fd", arg: 1, scope: !2200, file: !2, line: 177, type: !202)
!2205 = !DILocalVariable(name: "arr", arg: 2, scope: !2200, file: !2, line: 177, type: !1783)
!2206 = !DILocalVariable(name: "n", arg: 3, scope: !2200, file: !2, line: 177, type: !202)
!2207 = !DILocalVariable(name: "i", scope: !2200, file: !2, line: 177, type: !202)
!2208 = !DILocation(line: 0, scope: !2200)
!2209 = !DILocation(line: 177, column: 1, scope: !2210)
!2210 = distinct !DILexicalBlock(scope: !2211, file: !2, line: 177, column: 1)
!2211 = distinct !DILexicalBlock(scope: !2200, file: !2, line: 177, column: 1)
!2212 = !DILocation(line: 177, column: 1, scope: !2213)
!2213 = distinct !DILexicalBlock(scope: !2214, file: !2, line: 177, column: 1)
!2214 = distinct !DILexicalBlock(scope: !2200, file: !2, line: 177, column: 1)
!2215 = !DILocation(line: 177, column: 1, scope: !2214)
!2216 = !DILocation(line: 177, column: 1, scope: !2217)
!2217 = distinct !DILexicalBlock(scope: !2213, file: !2, line: 177, column: 1)
!2218 = distinct !{!2218, !2215, !2215, !370, !371}
!2219 = !DILocation(line: 177, column: 1, scope: !2200)
!2220 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !2221, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2223)
!2221 = !DISubroutineType(cc: DW_CC_nocall, types: !2222)
!2222 = !{!202, !202, !1704, null}
!2223 = !{!2224, !2225, !2226, !2230, !2231, !2232, !2233}
!2224 = !DILocalVariable(name: "fd", arg: 1, scope: !2220, file: !2, line: 15, type: !202)
!2225 = !DILocalVariable(name: "format", arg: 2, scope: !2220, file: !2, line: 15, type: !1704)
!2226 = !DILocalVariable(name: "args", scope: !2220, file: !2, line: 16, type: !2227)
!2227 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !2228, line: 12, baseType: !2229)
!2228 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!2229 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !229)
!2230 = !DILocalVariable(name: "buffered", scope: !2220, file: !2, line: 17, type: !202)
!2231 = !DILocalVariable(name: "written", scope: !2220, file: !2, line: 17, type: !202)
!2232 = !DILocalVariable(name: "status", scope: !2220, file: !2, line: 17, type: !202)
!2233 = !DILocalVariable(name: "buffer", scope: !2220, file: !2, line: 18, type: !2234)
!2234 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !2235)
!2235 = !{!2236}
!2236 = !DISubrange(count: 256)
!2237 = distinct !DIAssignID()
!2238 = !DILocation(line: 0, scope: !2220)
!2239 = distinct !DIAssignID()
!2240 = !DILocation(line: 16, column: 3, scope: !2220)
!2241 = !DILocation(line: 18, column: 3, scope: !2220)
!2242 = !DILocation(line: 19, column: 3, scope: !2220)
!2243 = !DILocation(line: 20, column: 66, scope: !2220)
!2244 = !DILocation(line: 20, column: 14, scope: !2220)
!2245 = !DILocation(line: 21, column: 3, scope: !2220)
!2246 = !DILocation(line: 22, column: 3, scope: !2247)
!2247 = distinct !DILexicalBlock(scope: !2248, file: !2, line: 22, column: 3)
!2248 = distinct !DILexicalBlock(scope: !2220, file: !2, line: 22, column: 3)
!2249 = !DILocation(line: 24, column: 16, scope: !2220)
!2250 = !DILocation(line: 24, column: 3, scope: !2220)
!2251 = !DILocation(line: 27, column: 13, scope: !2252)
!2252 = distinct !DILexicalBlock(scope: !2220, file: !2, line: 24, column: 27)
!2253 = distinct !{!2253, !2250, !2254, !370, !371}
!2254 = !DILocation(line: 28, column: 3, scope: !2220)
!2255 = !DILocation(line: 25, column: 25, scope: !2252)
!2256 = !DILocation(line: 25, column: 50, scope: !2252)
!2257 = !DILocation(line: 25, column: 42, scope: !2252)
!2258 = !DILocation(line: 25, column: 14, scope: !2252)
!2259 = !DILocation(line: 26, column: 5, scope: !2260)
!2260 = distinct !DILexicalBlock(scope: !2261, file: !2, line: 26, column: 5)
!2261 = distinct !DILexicalBlock(scope: !2252, file: !2, line: 26, column: 5)
!2262 = !DILocation(line: 29, column: 3, scope: !2263)
!2263 = distinct !DILexicalBlock(scope: !2264, file: !2, line: 29, column: 3)
!2264 = distinct !DILexicalBlock(scope: !2220, file: !2, line: 29, column: 3)
!2265 = !DILocation(line: 31, column: 1, scope: !2220)
!2266 = !DILocation(line: 30, column: 3, scope: !2220)
!2267 = !DISubprogram(name: "vsnprintf", scope: !1823, file: !1823, line: 389, type: !2268, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2268 = !DISubroutineType(types: !2269)
!2269 = !{!202, !1815, !386, !1816, !2270}
!2270 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !2271, line: 12, baseType: !2229)
!2271 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!2272 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !2273, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2275)
!2273 = !DISubroutineType(types: !2274)
!2274 = !{!202, !202, !1883, !202}
!2275 = !{!2276, !2277, !2278, !2279}
!2276 = !DILocalVariable(name: "fd", arg: 1, scope: !2272, file: !2, line: 178, type: !202)
!2277 = !DILocalVariable(name: "arr", arg: 2, scope: !2272, file: !2, line: 178, type: !1883)
!2278 = !DILocalVariable(name: "n", arg: 3, scope: !2272, file: !2, line: 178, type: !202)
!2279 = !DILocalVariable(name: "i", scope: !2272, file: !2, line: 178, type: !202)
!2280 = !DILocation(line: 0, scope: !2272)
!2281 = !DILocation(line: 178, column: 1, scope: !2282)
!2282 = distinct !DILexicalBlock(scope: !2283, file: !2, line: 178, column: 1)
!2283 = distinct !DILexicalBlock(scope: !2272, file: !2, line: 178, column: 1)
!2284 = !DILocation(line: 178, column: 1, scope: !2285)
!2285 = distinct !DILexicalBlock(scope: !2286, file: !2, line: 178, column: 1)
!2286 = distinct !DILexicalBlock(scope: !2272, file: !2, line: 178, column: 1)
!2287 = !DILocation(line: 178, column: 1, scope: !2286)
!2288 = !DILocation(line: 178, column: 1, scope: !2289)
!2289 = distinct !DILexicalBlock(scope: !2285, file: !2, line: 178, column: 1)
!2290 = distinct !{!2290, !2287, !2287, !370, !371}
!2291 = !DILocation(line: 178, column: 1, scope: !2272)
!2292 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !2293, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2295)
!2293 = !DISubroutineType(types: !2294)
!2294 = !{!202, !202, !1914, !202}
!2295 = !{!2296, !2297, !2298, !2299}
!2296 = !DILocalVariable(name: "fd", arg: 1, scope: !2292, file: !2, line: 179, type: !202)
!2297 = !DILocalVariable(name: "arr", arg: 2, scope: !2292, file: !2, line: 179, type: !1914)
!2298 = !DILocalVariable(name: "n", arg: 3, scope: !2292, file: !2, line: 179, type: !202)
!2299 = !DILocalVariable(name: "i", scope: !2292, file: !2, line: 179, type: !202)
!2300 = !DILocation(line: 0, scope: !2292)
!2301 = !DILocation(line: 179, column: 1, scope: !2302)
!2302 = distinct !DILexicalBlock(scope: !2303, file: !2, line: 179, column: 1)
!2303 = distinct !DILexicalBlock(scope: !2292, file: !2, line: 179, column: 1)
!2304 = !DILocation(line: 179, column: 1, scope: !2305)
!2305 = distinct !DILexicalBlock(scope: !2306, file: !2, line: 179, column: 1)
!2306 = distinct !DILexicalBlock(scope: !2292, file: !2, line: 179, column: 1)
!2307 = !DILocation(line: 179, column: 1, scope: !2306)
!2308 = !DILocation(line: 179, column: 1, scope: !2309)
!2309 = distinct !DILexicalBlock(scope: !2305, file: !2, line: 179, column: 1)
!2310 = distinct !{!2310, !2307, !2307, !370, !371}
!2311 = !DILocation(line: 179, column: 1, scope: !2292)
!2312 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !2313, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2315)
!2313 = !DISubroutineType(types: !2314)
!2314 = !{!202, !202, !1943, !202}
!2315 = !{!2316, !2317, !2318, !2319}
!2316 = !DILocalVariable(name: "fd", arg: 1, scope: !2312, file: !2, line: 180, type: !202)
!2317 = !DILocalVariable(name: "arr", arg: 2, scope: !2312, file: !2, line: 180, type: !1943)
!2318 = !DILocalVariable(name: "n", arg: 3, scope: !2312, file: !2, line: 180, type: !202)
!2319 = !DILocalVariable(name: "i", scope: !2312, file: !2, line: 180, type: !202)
!2320 = !DILocation(line: 0, scope: !2312)
!2321 = !DILocation(line: 180, column: 1, scope: !2322)
!2322 = distinct !DILexicalBlock(scope: !2323, file: !2, line: 180, column: 1)
!2323 = distinct !DILexicalBlock(scope: !2312, file: !2, line: 180, column: 1)
!2324 = !DILocation(line: 180, column: 1, scope: !2325)
!2325 = distinct !DILexicalBlock(scope: !2326, file: !2, line: 180, column: 1)
!2326 = distinct !DILexicalBlock(scope: !2312, file: !2, line: 180, column: 1)
!2327 = !DILocation(line: 180, column: 1, scope: !2326)
!2328 = !DILocation(line: 180, column: 1, scope: !2329)
!2329 = distinct !DILexicalBlock(scope: !2325, file: !2, line: 180, column: 1)
!2330 = distinct !{!2330, !2327, !2327, !370, !371}
!2331 = !DILocation(line: 180, column: 1, scope: !2312)
!2332 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !2333, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2335)
!2333 = !DISubroutineType(types: !2334)
!2334 = !{!202, !202, !1974, !202}
!2335 = !{!2336, !2337, !2338, !2339}
!2336 = !DILocalVariable(name: "fd", arg: 1, scope: !2332, file: !2, line: 181, type: !202)
!2337 = !DILocalVariable(name: "arr", arg: 2, scope: !2332, file: !2, line: 181, type: !1974)
!2338 = !DILocalVariable(name: "n", arg: 3, scope: !2332, file: !2, line: 181, type: !202)
!2339 = !DILocalVariable(name: "i", scope: !2332, file: !2, line: 181, type: !202)
!2340 = !DILocation(line: 0, scope: !2332)
!2341 = !DILocation(line: 181, column: 1, scope: !2342)
!2342 = distinct !DILexicalBlock(scope: !2343, file: !2, line: 181, column: 1)
!2343 = distinct !DILexicalBlock(scope: !2332, file: !2, line: 181, column: 1)
!2344 = !DILocation(line: 181, column: 1, scope: !2345)
!2345 = distinct !DILexicalBlock(scope: !2346, file: !2, line: 181, column: 1)
!2346 = distinct !DILexicalBlock(scope: !2332, file: !2, line: 181, column: 1)
!2347 = !DILocation(line: 181, column: 1, scope: !2346)
!2348 = !DILocation(line: 181, column: 1, scope: !2349)
!2349 = distinct !DILexicalBlock(scope: !2345, file: !2, line: 181, column: 1)
!2350 = distinct !{!2350, !2347, !2347, !370, !371}
!2351 = !DILocation(line: 181, column: 1, scope: !2332)
!2352 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !2353, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2355)
!2353 = !DISubroutineType(types: !2354)
!2354 = !{!202, !202, !2003, !202}
!2355 = !{!2356, !2357, !2358, !2359}
!2356 = !DILocalVariable(name: "fd", arg: 1, scope: !2352, file: !2, line: 182, type: !202)
!2357 = !DILocalVariable(name: "arr", arg: 2, scope: !2352, file: !2, line: 182, type: !2003)
!2358 = !DILocalVariable(name: "n", arg: 3, scope: !2352, file: !2, line: 182, type: !202)
!2359 = !DILocalVariable(name: "i", scope: !2352, file: !2, line: 182, type: !202)
!2360 = !DILocation(line: 0, scope: !2352)
!2361 = !DILocation(line: 182, column: 1, scope: !2362)
!2362 = distinct !DILexicalBlock(scope: !2363, file: !2, line: 182, column: 1)
!2363 = distinct !DILexicalBlock(scope: !2352, file: !2, line: 182, column: 1)
!2364 = !DILocation(line: 182, column: 1, scope: !2365)
!2365 = distinct !DILexicalBlock(scope: !2366, file: !2, line: 182, column: 1)
!2366 = distinct !DILexicalBlock(scope: !2352, file: !2, line: 182, column: 1)
!2367 = !DILocation(line: 182, column: 1, scope: !2366)
!2368 = !DILocation(line: 182, column: 1, scope: !2369)
!2369 = distinct !DILexicalBlock(scope: !2365, file: !2, line: 182, column: 1)
!2370 = distinct !{!2370, !2367, !2367, !370, !371}
!2371 = !DILocation(line: 182, column: 1, scope: !2352)
!2372 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !2373, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2375)
!2373 = !DISubroutineType(types: !2374)
!2374 = !{!202, !202, !2032, !202}
!2375 = !{!2376, !2377, !2378, !2379}
!2376 = !DILocalVariable(name: "fd", arg: 1, scope: !2372, file: !2, line: 183, type: !202)
!2377 = !DILocalVariable(name: "arr", arg: 2, scope: !2372, file: !2, line: 183, type: !2032)
!2378 = !DILocalVariable(name: "n", arg: 3, scope: !2372, file: !2, line: 183, type: !202)
!2379 = !DILocalVariable(name: "i", scope: !2372, file: !2, line: 183, type: !202)
!2380 = !DILocation(line: 0, scope: !2372)
!2381 = !DILocation(line: 183, column: 1, scope: !2382)
!2382 = distinct !DILexicalBlock(scope: !2383, file: !2, line: 183, column: 1)
!2383 = distinct !DILexicalBlock(scope: !2372, file: !2, line: 183, column: 1)
!2384 = !DILocation(line: 183, column: 1, scope: !2385)
!2385 = distinct !DILexicalBlock(scope: !2386, file: !2, line: 183, column: 1)
!2386 = distinct !DILexicalBlock(scope: !2372, file: !2, line: 183, column: 1)
!2387 = !DILocation(line: 183, column: 1, scope: !2386)
!2388 = !DILocation(line: 183, column: 1, scope: !2389)
!2389 = distinct !DILexicalBlock(scope: !2385, file: !2, line: 183, column: 1)
!2390 = distinct !{!2390, !2387, !2387, !370, !371}
!2391 = !DILocation(line: 183, column: 1, scope: !2372)
!2392 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !2393, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2395)
!2393 = !DISubroutineType(types: !2394)
!2394 = !{!202, !202, !2061, !202}
!2395 = !{!2396, !2397, !2398, !2399}
!2396 = !DILocalVariable(name: "fd", arg: 1, scope: !2392, file: !2, line: 184, type: !202)
!2397 = !DILocalVariable(name: "arr", arg: 2, scope: !2392, file: !2, line: 184, type: !2061)
!2398 = !DILocalVariable(name: "n", arg: 3, scope: !2392, file: !2, line: 184, type: !202)
!2399 = !DILocalVariable(name: "i", scope: !2392, file: !2, line: 184, type: !202)
!2400 = !DILocation(line: 0, scope: !2392)
!2401 = !DILocation(line: 184, column: 1, scope: !2402)
!2402 = distinct !DILexicalBlock(scope: !2403, file: !2, line: 184, column: 1)
!2403 = distinct !DILexicalBlock(scope: !2392, file: !2, line: 184, column: 1)
!2404 = !DILocation(line: 184, column: 1, scope: !2405)
!2405 = distinct !DILexicalBlock(scope: !2406, file: !2, line: 184, column: 1)
!2406 = distinct !DILexicalBlock(scope: !2392, file: !2, line: 184, column: 1)
!2407 = !DILocation(line: 184, column: 1, scope: !2406)
!2408 = !DILocation(line: 184, column: 1, scope: !2409)
!2409 = distinct !DILexicalBlock(scope: !2405, file: !2, line: 184, column: 1)
!2410 = distinct !{!2410, !2407, !2407, !370, !371}
!2411 = !DILocation(line: 184, column: 1, scope: !2392)
!2412 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !2413, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !2415)
!2413 = !DISubroutineType(types: !2414)
!2414 = !{!202, !202, !2090, !202}
!2415 = !{!2416, !2417, !2418, !2419}
!2416 = !DILocalVariable(name: "fd", arg: 1, scope: !2412, file: !2, line: 186, type: !202)
!2417 = !DILocalVariable(name: "arr", arg: 2, scope: !2412, file: !2, line: 186, type: !2090)
!2418 = !DILocalVariable(name: "n", arg: 3, scope: !2412, file: !2, line: 186, type: !202)
!2419 = !DILocalVariable(name: "i", scope: !2412, file: !2, line: 186, type: !202)
!2420 = !DILocation(line: 0, scope: !2412)
!2421 = !DILocation(line: 186, column: 1, scope: !2422)
!2422 = distinct !DILexicalBlock(scope: !2423, file: !2, line: 186, column: 1)
!2423 = distinct !DILexicalBlock(scope: !2412, file: !2, line: 186, column: 1)
!2424 = !DILocation(line: 186, column: 1, scope: !2425)
!2425 = distinct !DILexicalBlock(scope: !2426, file: !2, line: 186, column: 1)
!2426 = distinct !DILexicalBlock(scope: !2412, file: !2, line: 186, column: 1)
!2427 = !DILocation(line: 186, column: 1, scope: !2426)
!2428 = !DILocation(line: 186, column: 1, scope: !2429)
!2429 = distinct !DILexicalBlock(scope: !2425, file: !2, line: 186, column: 1)
!2430 = distinct !{!2430, !2427, !2427, !370, !371}
!2431 = !DILocation(line: 186, column: 1, scope: !2412)
!2432 = !DILocation(line: 0, scope: !1482)
!2433 = !DILocation(line: 187, column: 1, scope: !2434)
!2434 = distinct !DILexicalBlock(scope: !2435, file: !2, line: 187, column: 1)
!2435 = distinct !DILexicalBlock(scope: !1482, file: !2, line: 187, column: 1)
!2436 = !DILocation(line: 187, column: 1, scope: !1495)
!2437 = !DILocation(line: 187, column: 1, scope: !1492)
!2438 = !DILocation(line: 187, column: 1, scope: !1494)
!2439 = distinct !{!2439, !2437, !2437, !370, !371}
!2440 = !DILocation(line: 187, column: 1, scope: !1482)
!2441 = !DILocation(line: 0, scope: !1471)
!2442 = !DILocation(line: 190, column: 3, scope: !1478)
!2443 = !DILocation(line: 191, column: 3, scope: !1471)
!2444 = !DILocation(line: 192, column: 3, scope: !1471)
!2445 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !2446, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !291, retainedNodes: !2448)
!2446 = !DISubroutineType(types: !2447)
!2447 = !{!202, !202, !1821}
!2448 = !{!2449, !2450, !2451, !2452, !2453, !2454, !2455, !2456, !2457}
!2449 = !DILocalVariable(name: "argc", arg: 1, scope: !2445, file: !170, line: 14, type: !202)
!2450 = !DILocalVariable(name: "argv", arg: 2, scope: !2445, file: !170, line: 14, type: !1821)
!2451 = !DILocalVariable(name: "in_file", scope: !2445, file: !170, line: 17, type: !228)
!2452 = !DILocalVariable(name: "check_file", scope: !2445, file: !170, line: 19, type: !228)
!2453 = !DILocalVariable(name: "in_fd", scope: !2445, file: !170, line: 34, type: !202)
!2454 = !DILocalVariable(name: "data", scope: !2445, file: !170, line: 35, type: !228)
!2455 = !DILocalVariable(name: "out_fd", scope: !2445, file: !170, line: 46, type: !202)
!2456 = !DILocalVariable(name: "check_fd", scope: !2445, file: !170, line: 55, type: !202)
!2457 = !DILocalVariable(name: "ref", scope: !2445, file: !170, line: 56, type: !228)
!2458 = !DILocation(line: 0, scope: !2445)
!2459 = !DILocation(line: 21, column: 3, scope: !2460)
!2460 = distinct !DILexicalBlock(scope: !2461, file: !170, line: 21, column: 3)
!2461 = distinct !DILexicalBlock(scope: !2445, file: !170, line: 21, column: 3)
!2462 = !DILocation(line: 26, column: 11, scope: !2463)
!2463 = distinct !DILexicalBlock(scope: !2445, file: !170, line: 26, column: 7)
!2464 = !DILocation(line: 26, column: 7, scope: !2445)
!2465 = !DILocation(line: 27, column: 15, scope: !2463)
!2466 = !DILocation(line: 29, column: 11, scope: !2467)
!2467 = distinct !DILexicalBlock(scope: !2445, file: !170, line: 29, column: 7)
!2468 = !DILocation(line: 29, column: 7, scope: !2445)
!2469 = !DILocation(line: 30, column: 18, scope: !2467)
!2470 = !DILocation(line: 30, column: 5, scope: !2467)
!2471 = !DILocation(line: 36, column: 17, scope: !2445)
!2472 = !DILocation(line: 36, column: 10, scope: !2445)
!2473 = !DILocation(line: 37, column: 3, scope: !2474)
!2474 = distinct !DILexicalBlock(scope: !2475, file: !170, line: 37, column: 3)
!2475 = distinct !DILexicalBlock(scope: !2445, file: !170, line: 37, column: 3)
!2476 = !DILocation(line: 38, column: 11, scope: !2445)
!2477 = !DILocation(line: 39, column: 3, scope: !2478)
!2478 = distinct !DILexicalBlock(scope: !2479, file: !170, line: 39, column: 3)
!2479 = distinct !DILexicalBlock(scope: !2445, file: !170, line: 39, column: 3)
!2480 = !DILocation(line: 40, column: 3, scope: !2445)
!2481 = !DILocation(line: 0, scope: !1389, inlinedAt: !2482)
!2482 = distinct !DILocation(line: 43, column: 3, scope: !2445)
!2483 = !DILocation(line: 10, column: 28, scope: !1389, inlinedAt: !2482)
!2484 = !DILocation(line: 10, column: 3, scope: !1389, inlinedAt: !2482)
!2485 = !DILocation(line: 47, column: 12, scope: !2445)
!2486 = !DILocation(line: 48, column: 3, scope: !2487)
!2487 = distinct !DILexicalBlock(scope: !2488, file: !170, line: 48, column: 3)
!2488 = distinct !DILexicalBlock(scope: !2445, file: !170, line: 48, column: 3)
!2489 = !DILocation(line: 0, scope: !1559, inlinedAt: !2490)
!2490 = distinct !DILocation(line: 49, column: 3, scope: !2445)
!2491 = !DILocation(line: 0, scope: !1471, inlinedAt: !2492)
!2492 = distinct !DILocation(line: 68, column: 3, scope: !1559, inlinedAt: !2490)
!2493 = !DILocation(line: 190, column: 3, scope: !1478, inlinedAt: !2492)
!2494 = !DILocation(line: 191, column: 3, scope: !1471, inlinedAt: !2492)
!2495 = !DILocation(line: 0, scope: !1482, inlinedAt: !2496)
!2496 = distinct !DILocation(line: 69, column: 3, scope: !1559, inlinedAt: !2490)
!2497 = !DILocation(line: 187, column: 1, scope: !1492, inlinedAt: !2496)
!2498 = !DILocation(line: 187, column: 1, scope: !1494, inlinedAt: !2496)
!2499 = !DILocation(line: 187, column: 1, scope: !1495, inlinedAt: !2496)
!2500 = distinct !{!2500, !2497, !2497, !370, !371}
!2501 = !DILocation(line: 0, scope: !1471, inlinedAt: !2502)
!2502 = distinct !DILocation(line: 71, column: 3, scope: !1559, inlinedAt: !2490)
!2503 = !DILocation(line: 191, column: 3, scope: !1471, inlinedAt: !2502)
!2504 = !DILocation(line: 0, scope: !1482, inlinedAt: !2505)
!2505 = distinct !DILocation(line: 72, column: 3, scope: !1559, inlinedAt: !2490)
!2506 = !DILocation(line: 187, column: 1, scope: !1492, inlinedAt: !2505)
!2507 = !DILocation(line: 187, column: 1, scope: !1494, inlinedAt: !2505)
!2508 = !DILocation(line: 187, column: 1, scope: !1495, inlinedAt: !2505)
!2509 = distinct !{!2509, !2506, !2506, !370, !371}
!2510 = !DILocation(line: 50, column: 3, scope: !2445)
!2511 = !DILocation(line: 57, column: 16, scope: !2445)
!2512 = !DILocation(line: 57, column: 9, scope: !2445)
!2513 = !DILocation(line: 58, column: 3, scope: !2514)
!2514 = distinct !DILexicalBlock(scope: !2515, file: !170, line: 58, column: 3)
!2515 = distinct !DILexicalBlock(scope: !2445, file: !170, line: 58, column: 3)
!2516 = !DILocation(line: 59, column: 14, scope: !2445)
!2517 = !DILocation(line: 60, column: 3, scope: !2518)
!2518 = distinct !DILexicalBlock(scope: !2519, file: !170, line: 60, column: 3)
!2519 = distinct !DILexicalBlock(scope: !2445, file: !170, line: 60, column: 3)
!2520 = !DILocation(line: 61, column: 3, scope: !2445)
!2521 = !DILocation(line: 0, scope: !1586, inlinedAt: !2522)
!2522 = distinct !DILocation(line: 66, column: 8, scope: !2523)
!2523 = distinct !DILexicalBlock(scope: !2445, file: !170, line: 66, column: 7)
!2524 = !DILocation(line: 82, column: 3, scope: !1600, inlinedAt: !2522)
!2525 = !DILocation(line: 83, column: 17, scope: !1602, inlinedAt: !2522)
!2526 = !DILocation(line: 83, column: 35, scope: !1602, inlinedAt: !2522)
!2527 = !DILocation(line: 83, column: 33, scope: !1602, inlinedAt: !2522)
!2528 = !DILocation(line: 84, column: 16, scope: !1602, inlinedAt: !2522)
!2529 = !DILocation(line: 84, column: 34, scope: !1602, inlinedAt: !2522)
!2530 = !DILocation(line: 84, column: 32, scope: !1602, inlinedAt: !2522)
!2531 = !DILocation(line: 85, column: 40, scope: !1602, inlinedAt: !2522)
!2532 = !DILocation(line: 88, column: 39, scope: !1602, inlinedAt: !2522)
!2533 = !DILocation(line: 88, column: 16, scope: !1602, inlinedAt: !2522)
!2534 = !DILocation(line: 82, column: 20, scope: !1603, inlinedAt: !2522)
!2535 = !DILocation(line: 82, column: 13, scope: !1603, inlinedAt: !2522)
!2536 = distinct !{!2536, !2524, !2537, !370, !371}
!2537 = !DILocation(line: 91, column: 3, scope: !1600, inlinedAt: !2522)
!2538 = !DILocation(line: 94, column: 10, scope: !1586, inlinedAt: !2522)
!2539 = !DILocation(line: 66, column: 7, scope: !2445)
!2540 = !DILocation(line: 67, column: 13, scope: !2541)
!2541 = distinct !DILexicalBlock(scope: !2523, file: !170, line: 66, column: 32)
!2542 = !DILocation(line: 67, column: 5, scope: !2541)
!2543 = !DILocation(line: 68, column: 5, scope: !2541)
!2544 = !DILocation(line: 71, column: 3, scope: !2445)
!2545 = !DILocation(line: 72, column: 3, scope: !2445)
!2546 = !DILocation(line: 74, column: 3, scope: !2445)
!2547 = !DILocation(line: 75, column: 3, scope: !2445)
!2548 = !DILocation(line: 76, column: 1, scope: !2445)
!2549 = !DISubprogram(name: "open", scope: !2550, file: !2550, line: 209, type: !2551, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!2550 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!2551 = !DISubroutineType(types: !2552)
!2552 = !{!202, !1704, !202, null}
