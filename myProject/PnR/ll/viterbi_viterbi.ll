; ModuleID = 'viterbi/viterbi/viterbi_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.bench_args_t = type { [140 x i8], [64 x double], [4096 x double], [4096 x double], [140 x i8] }
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
@INPUT_SIZE = dso_local local_unnamed_addr global i32 66336, align 4, !dbg !186
@.str.6.18 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !221
@.str.8.19 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !224
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !227
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !232
@.str.12.20 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !235
@.str.14.21 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !237
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !240
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local noundef signext i32 @viterbi(ptr nocapture noundef readonly %obs, ptr nocapture noundef readonly %init, ptr nocapture noundef readonly %transition, ptr nocapture noundef readonly %emission, ptr nocapture noundef %path) local_unnamed_addr #0 !dbg !337 {
entry.split:
  %llike = alloca [140 x [64 x double]], align 8, !DIAssignID !376
    #dbg_assign(i1 undef, !349, !DIExpression(), !376, ptr %llike, !DIExpression(), !377)
    #dbg_value(ptr %obs, !344, !DIExpression(), !377)
    #dbg_value(ptr %init, !345, !DIExpression(), !377)
    #dbg_value(ptr %transition, !346, !DIExpression(), !377)
    #dbg_value(ptr %emission, !347, !DIExpression(), !377)
    #dbg_value(ptr %path, !348, !DIExpression(), !377)
  %polly.access.llike30.promoted.reg2mem = alloca double, align 8
  %invariant.gep44.reg2mem = alloca ptr, align 8
  %_p_scalar_31.reg2mem = alloca double, align 8
  %polly.access.llike30.reg2mem = alloca ptr, align 8
  %polly.indvar19.reg2mem = alloca i64, align 8
  %polly.indvar_next26.reg2mem = alloca i64, align 8
  %p_min_p.1.reg2mem = alloca double, align 8
  %polly.indvar_next20.reg2mem = alloca i64, align 8
  %polly.indvar_next20.1.1.reg2mem = alloca i64, align 8
  %polly.indvar_next26.1.1.reg2mem = alloca i64, align 8
  %p_min_p.1.1.1.reg2mem = alloca double, align 8
  %polly.access.llike30.promoted.1.1.reg2mem = alloca double, align 8
  %invariant.gep44.1.1.reg2mem = alloca ptr, align 8
  %_p_scalar_31.1.1.reg2mem = alloca double, align 8
  %polly.access.llike30.1.1.reg2mem = alloca ptr, align 8
  %polly.indvar19.1.1.reg2mem = alloca i64, align 8
  %polly.indvar_next20.177.reg2mem = alloca i64, align 8
  %polly.indvar_next26.174.reg2mem = alloca i64, align 8
  %p_min_p.1.173.reg2mem = alloca double, align 8
  %polly.access.llike30.promoted.162.reg2mem = alloca double, align 8
  %invariant.gep44.161.reg2mem = alloca ptr, align 8
  %_p_scalar_31.160.reg2mem = alloca double, align 8
  %polly.access.llike30.157.reg2mem = alloca ptr, align 8
  %polly.indvar19.156.reg2mem = alloca i64, align 8
  %.reg2mem = alloca ptr, align 8
  %polly.indvar_next20.1.reg2mem = alloca i64, align 8
  %polly.indvar_next26.1.reg2mem = alloca i64, align 8
  %p_min_p.1.1.reg2mem = alloca double, align 8
  %polly.access.llike30.promoted.1.reg2mem = alloca double, align 8
  %invariant.gep44.1.reg2mem = alloca ptr, align 8
  %_p_scalar_31.1.reg2mem = alloca double, align 8
  %polly.access.llike30.1.reg2mem = alloca ptr, align 8
  %polly.indvar19.1.reg2mem = alloca i64, align 8
  %scevgep33.reg2mem = alloca ptr, align 8
  %gep48.reg2mem = alloca ptr, align 8
  %.idx.reg2mem = alloca i64, align 8
  %scevgep1.reg2mem = alloca ptr, align 8
  %polly.indvar_next.reg2mem = alloca i64, align 8
  %indvar.next.reg2mem = alloca i64, align 8
  %indvars.iv.next232.reg2mem = alloca i64, align 8
  %indvars.iv.next226.reg2mem = alloca i64, align 8
  %indvars.iv.next223.reg2mem = alloca i64, align 8
  %min_p.1.reg2mem = alloca double, align 8
  %add39.reg2mem = alloca double, align 8
  %.reg2mem139 = alloca double, align 8
  %arrayidx29.reg2mem = alloca ptr, align 8
  %indvars.iv225.reg2mem = alloca i64, align 8
  %.pre.reg2mem = alloca double, align 8
  %invariant.gep245.reg2mem = alloca ptr, align 8
  %.reg2mem149 = alloca i64, align 8
  %.reg2mem153 = alloca i64, align 8
  %indvars.iv231.reg2mem = alloca i64, align 8
  %indvar.reg2mem = alloca i64, align 8
  %scevgep36.reg2mem = alloca ptr, align 8
  %scevgep32.reg2mem = alloca ptr, align 8
  %invariant.gep47.reg2mem = alloca ptr, align 8
  %indvars.iv.next.reg2mem = alloca i64, align 8
  %invariant.gep.reg2mem = alloca ptr, align 8
  %polly.indvar19.reg2mem164 = alloca i64, align 8
  %polly.indvar25.reg2mem = alloca i64, align 8
  %polly.access.llike30.reload46.reg2mem = alloca double, align 8
  %polly.indvar25.1.1.reg2mem = alloca i64, align 8
  %polly.access.llike30.reload46.1.1.reg2mem = alloca double, align 8
  %polly.indvar19.1.1.reg2mem166 = alloca i64, align 8
  %polly.indvar25.165.reg2mem = alloca i64, align 8
  %polly.access.llike30.reload46.164.reg2mem = alloca double, align 8
  %polly.indvar19.156.reg2mem168 = alloca i64, align 8
  %polly.indvar25.1.reg2mem = alloca i64, align 8
  %polly.access.llike30.reload46.1.reg2mem = alloca double, align 8
  %polly.indvar19.1.reg2mem170 = alloca i64, align 8
  %polly.indvar.reg2mem = alloca i64, align 8
  %min_p.4218.reg2mem = alloca double, align 8
  %min_s.2219.reg2mem = alloca i8, align 1
  %indvars.iv238.reg2mem = alloca i64, align 8
  %indvars.iv241.reg2mem172 = alloca i64, align 8
  %min_p.2213.reg2mem = alloca double, align 8
  %min_s.0214.reg2mem = alloca i8, align 1
  %indvars.iv235.reg2mem = alloca i64, align 8
  %min_p.0209.reg2mem = alloca double, align 8
  %indvars.iv222.reg2mem = alloca i64, align 8
  %indvars.iv225.reg2mem174 = alloca i64, align 8
  %indvars.iv231.reg2mem176 = alloca i64, align 8
  %indvar.reg2mem178 = alloca i64, align 8
  %indvars.iv.reg2mem = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 71680, ptr nonnull %llike) #18, !dbg !378
    #dbg_label(!360, !379)
    #dbg_value(i8 0, !359, !DIExpression(), !377)
  %0 = load i8, ptr %obs, align 1, !tbaa !380
  %conv4 = zext i8 %0 to i64
  %invariant.gep = getelementptr double, ptr %emission, i64 %conv4, !dbg !383
  store ptr %invariant.gep, ptr %invariant.gep.reg2mem, align 8
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !385

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !359, !DIExpression(), !377)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %init, i64 %indvars.iv.reg2mem.0.load, !dbg !386
  %1 = load double, ptr %arrayidx, align 8, !dbg !386, !tbaa !389
  %gep.idx = shl i64 %indvars.iv.reg2mem.0.load, 9, !dbg !391
  %gep = getelementptr i8, ptr %invariant.gep, i64 %gep.idx, !dbg !391
  %2 = load double, ptr %gep, align 8, !dbg !391, !tbaa !389
  %add7 = fadd double %1, %2, !dbg !392
  %arrayidx10 = getelementptr inbounds [64 x double], ptr %llike, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !393
  store double %add7, ptr %arrayidx10, align 8, !dbg !394, !tbaa !389
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !395
    #dbg_value(i64 %indvars.iv.next, !359, !DIExpression(), !377)
  store i64 %indvars.iv.next, ptr %indvars.iv.next.reg2mem, align 8
  %exitcond.not = icmp eq i64 %indvars.iv.next, 64, !dbg !396
  br i1 %exitcond.not, label %polly.split_new_and_old.preheader, label %for.body.for.body_crit_edge, !dbg !385, !llvm.loop !397

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !385

polly.split_new_and_old.preheader:                ; preds = %for.body
  %invariant.gep47 = getelementptr inbounds i8, ptr %llike, i64 512, !dbg !401
  store ptr %invariant.gep47, ptr %invariant.gep47.reg2mem, align 8
  %scevgep32 = getelementptr inbounds i8, ptr %llike, i64 8
  store ptr %scevgep32, ptr %scevgep32.reg2mem, align 8
  %scevgep36 = getelementptr i8, ptr %transition, i64 512
  store ptr %scevgep36, ptr %scevgep36.reg2mem, align 8
  store i64 1, ptr %indvars.iv231.reg2mem176, align 8
  store i64 0, ptr %indvar.reg2mem178, align 8
  br label %polly.split_new_and_old, !dbg !401

polly.split_new_and_old:                          ; preds = %for.inc78.polly.split_new_and_old_crit_edge, %polly.split_new_and_old.preheader
    #dbg_value(i64 %indvars.iv231.reg2mem176.0.load, !352, !DIExpression(), !377)
  %indvar.reg2mem178.0.load = load i64, ptr %indvar.reg2mem178, align 8
  %indvars.iv231.reg2mem176.0.load = load i64, ptr %indvars.iv231.reg2mem176, align 8
  store i64 %indvar.reg2mem178.0.load, ptr %indvar.reg2mem, align 8
  store i64 %indvars.iv231.reg2mem176.0.load, ptr %indvars.iv231.reg2mem, align 8
  %3 = add nsw i64 %indvars.iv231.reg2mem176.0.load, -1
  store i64 %3, ptr %.reg2mem153, align 8
  %arrayidx21 = getelementptr inbounds [140 x [64 x double]], ptr %llike, i64 0, i64 %3
  %arrayidx34 = getelementptr inbounds i8, ptr %obs, i64 %indvars.iv231.reg2mem176.0.load
  %4 = load i8, ptr %arrayidx34, align 1, !tbaa !380
    #dbg_value(i8 0, !355, !DIExpression(), !377)
  %5 = zext i8 %4 to i64
  store i64 %5, ptr %.reg2mem149, align 8
  %invariant.gep245 = getelementptr double, ptr %emission, i64 %5, !dbg !402
  store ptr %invariant.gep245, ptr %invariant.gep245.reg2mem, align 8
  %.pre = load double, ptr %arrayidx21, align 8, !dbg !403
  store double %.pre, ptr %.pre.reg2mem, align 8
  %6 = icmp sgt i8 %4, -1
  br i1 %6, label %polly.loop_preheader, label %polly.split_new_and_old.for.body19_crit_edge

polly.split_new_and_old.for.body19_crit_edge:     ; preds = %polly.split_new_and_old
  store i64 0, ptr %indvars.iv225.reg2mem174, align 8
  br label %for.body19

for.body19:                                       ; preds = %for.end70.for.body19_crit_edge, %polly.split_new_and_old.for.body19_crit_edge
    #dbg_value(i64 %indvars.iv225.reg2mem174.0.load, !355, !DIExpression(), !377)
    #dbg_value(i8 0, !354, !DIExpression(), !377)
  %indvars.iv225.reg2mem174.0.load = load i64, ptr %indvars.iv225.reg2mem174, align 8
  store i64 %indvars.iv225.reg2mem174.0.load, ptr %indvars.iv225.reg2mem, align 8
  %arrayidx29 = getelementptr inbounds double, ptr %transition, i64 %indvars.iv225.reg2mem174.0.load, !dbg !404
  store ptr %arrayidx29, ptr %arrayidx29.reg2mem, align 8
  %7 = load double, ptr %arrayidx29, align 8, !dbg !404, !tbaa !389
  %add30 = fadd double %.pre, %7, !dbg !405
  %gep246.idx = shl i64 %indvars.iv225.reg2mem174.0.load, 9, !dbg !406
  %gep246 = getelementptr i8, ptr %invariant.gep245, i64 %gep246.idx, !dbg !406
  %8 = load double, ptr %gep246, align 8, !dbg !406
  store double %8, ptr %.reg2mem139, align 8
  %add39 = fadd double %add30, %8, !dbg !407
    #dbg_value(double %add39, !356, !DIExpression(), !377)
    #dbg_label(!366, !408)
    #dbg_value(i8 1, !354, !DIExpression(), !377)
  store double %add39, ptr %add39.reg2mem, align 8
  store double %add39, ptr %min_p.0209.reg2mem, align 8
  store i64 1, ptr %indvars.iv222.reg2mem, align 8
  br label %for.body44, !dbg !409

for.body44:                                       ; preds = %for.body44.for.body44_crit_edge, %for.body19
    #dbg_value(double %min_p.0209.reg2mem.0.min_p.0209.reload, !356, !DIExpression(), !377)
    #dbg_value(i64 %indvars.iv222.reg2mem.0.load, !354, !DIExpression(), !377)
  %indvars.iv222.reg2mem.0.load = load i64, ptr %indvars.iv222.reg2mem, align 8
  %min_p.0209.reg2mem.0.min_p.0209.reload = load double, ptr %min_p.0209.reg2mem, align 8
  %arrayidx49 = getelementptr inbounds [140 x [64 x double]], ptr %llike, i64 0, i64 %3, i64 %indvars.iv222.reg2mem.0.load, !dbg !411
  %9 = load double, ptr %arrayidx49, align 8, !dbg !411, !tbaa !389
  %gep244.idx = shl i64 %indvars.iv222.reg2mem.0.load, 9, !dbg !414
  %gep244 = getelementptr i8, ptr %arrayidx29, i64 %gep244.idx, !dbg !414
  %10 = load double, ptr %gep244, align 8, !dbg !414, !tbaa !389
  %add56 = fadd double %9, %10, !dbg !415
  %add65 = fadd double %8, %add56, !dbg !416
    #dbg_value(double %add65, !357, !DIExpression(), !377)
  %cmp66 = fcmp olt double %add65, %min_p.0209.reg2mem.0.min_p.0209.reload, !dbg !417
  %min_p.1 = select i1 %cmp66, double %add65, double %min_p.0209.reg2mem.0.min_p.0209.reload, !dbg !419
    #dbg_value(double %min_p.1, !356, !DIExpression(), !377)
  store double %min_p.1, ptr %min_p.1.reg2mem, align 8
  %indvars.iv.next223 = add nuw nsw i64 %indvars.iv222.reg2mem.0.load, 1, !dbg !420
    #dbg_value(i64 %indvars.iv.next223, !354, !DIExpression(), !377)
  store i64 %indvars.iv.next223, ptr %indvars.iv.next223.reg2mem, align 8
  %exitcond224.not = icmp eq i64 %indvars.iv.next223, 64, !dbg !421
  br i1 %exitcond224.not, label %for.end70, label %for.body44.for.body44_crit_edge, !dbg !409, !llvm.loop !422

for.body44.for.body44_crit_edge:                  ; preds = %for.body44
  store double %min_p.1, ptr %min_p.0209.reg2mem, align 8
  store i64 %indvars.iv.next223, ptr %indvars.iv222.reg2mem, align 8
  br label %for.body44, !dbg !409

for.end70:                                        ; preds = %for.body44
  %arrayidx74 = getelementptr inbounds [140 x [64 x double]], ptr %llike, i64 0, i64 %indvars.iv231.reg2mem176.0.load, i64 %indvars.iv225.reg2mem174.0.load, !dbg !424
  store double %min_p.1, ptr %arrayidx74, align 8, !dbg !425, !tbaa !389
  %indvars.iv.next226 = add nuw nsw i64 %indvars.iv225.reg2mem174.0.load, 1, !dbg !426
    #dbg_value(i64 %indvars.iv.next226, !355, !DIExpression(), !377)
  store i64 %indvars.iv.next226, ptr %indvars.iv.next226.reg2mem, align 8
  %exitcond230.not = icmp eq i64 %indvars.iv.next226, 64, !dbg !427
  br i1 %exitcond230.not, label %for.end70.for.inc78_crit_edge, label %for.end70.for.body19_crit_edge, !dbg !402, !llvm.loop !428

for.end70.for.body19_crit_edge:                   ; preds = %for.end70
  store i64 %indvars.iv.next226, ptr %indvars.iv225.reg2mem174, align 8
  br label %for.body19, !dbg !402

for.end70.for.inc78_crit_edge:                    ; preds = %for.end70
  br label %for.inc78, !dbg !402

for.inc78:                                        ; preds = %polly.loop_exit24.1.1.for.inc78_crit_edge, %for.end70.for.inc78_crit_edge
  %indvars.iv231.reg2mem.0.load184 = load i64, ptr %indvars.iv231.reg2mem, align 8
  %indvars.iv.next232 = add nuw nsw i64 %indvars.iv231.reg2mem.0.load184, 1, !dbg !430
    #dbg_value(i64 %indvars.iv.next232, !352, !DIExpression(), !377)
  store i64 %indvars.iv.next232, ptr %indvars.iv.next232.reg2mem, align 8
  %exitcond234.not = icmp eq i64 %indvars.iv.next232, 140, !dbg !431
  %indvar.reg2mem.0.load181 = load i64, ptr %indvar.reg2mem, align 8
  %indvar.next = add nuw nsw i64 %indvar.reg2mem.0.load181, 1, !dbg !401
  store i64 %indvar.next, ptr %indvar.next.reg2mem, align 8
  br i1 %exitcond234.not, label %for.end80, label %for.inc78.polly.split_new_and_old_crit_edge, !dbg !401, !llvm.loop !432

for.inc78.polly.split_new_and_old_crit_edge:      ; preds = %for.inc78
  store i64 %indvars.iv.next232, ptr %indvars.iv231.reg2mem176, align 8
  store i64 %indvar.next, ptr %indvar.reg2mem178, align 8
  br label %polly.split_new_and_old, !dbg !401

for.end80:                                        ; preds = %for.inc78
    #dbg_value(i8 0, !358, !DIExpression(), !377)
  %arrayidx81 = getelementptr inbounds i8, ptr %llike, i64 71168, !dbg !434
  %11 = load double, ptr %arrayidx81, align 8, !dbg !434
    #dbg_value(double %11, !356, !DIExpression(), !377)
    #dbg_label(!370, !435)
    #dbg_value(i8 1, !359, !DIExpression(), !377)
  store double %11, ptr %min_p.2213.reg2mem, align 8
  store i8 0, ptr %min_s.0214.reg2mem, align 1
  store i64 1, ptr %indvars.iv235.reg2mem, align 8
  br label %for.body88, !dbg !436

for.body88:                                       ; preds = %for.body88.for.body88_crit_edge, %for.end80
    #dbg_value(i64 %indvars.iv235.reg2mem.0.load, !359, !DIExpression(), !377)
    #dbg_value(i8 %min_s.0214.reg2mem.0.load, !358, !DIExpression(), !377)
    #dbg_value(double %min_p.2213.reg2mem.0.min_p.2213.reload, !356, !DIExpression(), !377)
  %indvars.iv235.reg2mem.0.load = load i64, ptr %indvars.iv235.reg2mem, align 8
  %min_s.0214.reg2mem.0.load = load i8, ptr %min_s.0214.reg2mem, align 1
  %min_p.2213.reg2mem.0.min_p.2213.reload = load double, ptr %min_p.2213.reg2mem, align 8
  %arrayidx91 = getelementptr inbounds [140 x [64 x double]], ptr %llike, i64 0, i64 139, i64 %indvars.iv235.reg2mem.0.load, !dbg !438
  %12 = load double, ptr %arrayidx91, align 8, !dbg !438, !tbaa !389
    #dbg_value(double %12, !357, !DIExpression(), !377)
  %cmp92 = fcmp olt double %12, %min_p.2213.reg2mem.0.min_p.2213.reload, !dbg !441
  %min_p.3 = select i1 %cmp92, double %12, double %min_p.2213.reg2mem.0.min_p.2213.reload, !dbg !443
  %13 = trunc i64 %indvars.iv235.reg2mem.0.load to i8, !dbg !443
  %min_s.1 = select i1 %cmp92, i8 %13, i8 %min_s.0214.reg2mem.0.load, !dbg !443
    #dbg_value(i8 %min_s.1, !358, !DIExpression(), !377)
    #dbg_value(double %min_p.3, !356, !DIExpression(), !377)
  %indvars.iv.next236 = add nuw nsw i64 %indvars.iv235.reg2mem.0.load, 1, !dbg !444
    #dbg_value(i64 %indvars.iv.next236, !359, !DIExpression(), !377)
  %exitcond237.not = icmp eq i64 %indvars.iv.next236, 64, !dbg !445
  br i1 %exitcond237.not, label %for.end98, label %for.body88.for.body88_crit_edge, !dbg !436, !llvm.loop !446

for.body88.for.body88_crit_edge:                  ; preds = %for.body88
  store double %min_p.3, ptr %min_p.2213.reg2mem, align 8
  store i8 %min_s.1, ptr %min_s.0214.reg2mem, align 1
  store i64 %indvars.iv.next236, ptr %indvars.iv235.reg2mem, align 8
  br label %for.body88, !dbg !436

for.end98:                                        ; preds = %for.body88
  %arrayidx99 = getelementptr inbounds i8, ptr %path, i64 139, !dbg !448
  store i8 %min_s.1, ptr %arrayidx99, align 1, !dbg !449, !tbaa !380
    #dbg_label(!371, !450)
    #dbg_value(i32 138, !352, !DIExpression(), !377)
  store i64 138, ptr %indvars.iv241.reg2mem172, align 8
  br label %for.body103, !dbg !451

for.body103:                                      ; preds = %for.end143.for.body103_crit_edge, %for.end98
    #dbg_value(i64 %indvars.iv241.reg2mem172.0.load, !352, !DIExpression(), !377)
    #dbg_value(i8 0, !358, !DIExpression(), !377)
  %indvars.iv241.reg2mem172.0.load = load i64, ptr %indvars.iv241.reg2mem172, align 8
  %arrayidx105 = getelementptr inbounds [140 x [64 x double]], ptr %llike, i64 0, i64 %indvars.iv241.reg2mem172.0.load, !dbg !452
  %14 = load double, ptr %arrayidx105, align 8, !dbg !452, !tbaa !389
  %15 = getelementptr i8, ptr %path, i64 %indvars.iv241.reg2mem172.0.load, !dbg !453
  %arrayidx112 = getelementptr i8, ptr %15, i64 1, !dbg !453
  %16 = load i8, ptr %arrayidx112, align 1, !dbg !453, !tbaa !380
  %idxprom115 = zext i8 %16 to i64
  %arrayidx116 = getelementptr inbounds double, ptr %transition, i64 %idxprom115, !dbg !454
  %17 = load double, ptr %arrayidx116, align 8, !dbg !454, !tbaa !389
  %add117 = fadd double %14, %17, !dbg !455
    #dbg_value(double %add117, !356, !DIExpression(), !377)
    #dbg_label(!372, !456)
    #dbg_value(i8 1, !359, !DIExpression(), !377)
  store double %add117, ptr %min_p.4218.reg2mem, align 8
  store i8 0, ptr %min_s.2219.reg2mem, align 1
  store i64 1, ptr %indvars.iv238.reg2mem, align 8
  br label %for.body122, !dbg !457

for.body122:                                      ; preds = %for.body122.for.body122_crit_edge, %for.body103
    #dbg_value(i64 %indvars.iv238.reg2mem.0.load, !359, !DIExpression(), !377)
    #dbg_value(i8 %min_s.2219.reg2mem.0.load, !358, !DIExpression(), !377)
    #dbg_value(double %min_p.4218.reg2mem.0.min_p.4218.reload, !356, !DIExpression(), !377)
  %indvars.iv238.reg2mem.0.load = load i64, ptr %indvars.iv238.reg2mem, align 8
  %min_s.2219.reg2mem.0.load = load i8, ptr %min_s.2219.reg2mem, align 1
  %min_p.4218.reg2mem.0.min_p.4218.reload = load double, ptr %min_p.4218.reg2mem, align 8
  %arrayidx126 = getelementptr inbounds [140 x [64 x double]], ptr %llike, i64 0, i64 %indvars.iv241.reg2mem172.0.load, i64 %indvars.iv238.reg2mem.0.load, !dbg !459
  %18 = load double, ptr %arrayidx126, align 8, !dbg !459, !tbaa !389
  %gep217.idx = shl i64 %indvars.iv238.reg2mem.0.load, 9, !dbg !462
  %gep217 = getelementptr i8, ptr %arrayidx116, i64 %gep217.idx, !dbg !462
  %19 = load double, ptr %gep217, align 8, !dbg !462, !tbaa !389
  %add136 = fadd double %18, %19, !dbg !463
    #dbg_value(double %add136, !357, !DIExpression(), !377)
  %cmp137 = fcmp olt double %add136, %min_p.4218.reg2mem.0.min_p.4218.reload, !dbg !464
  %min_p.5 = select i1 %cmp137, double %add136, double %min_p.4218.reg2mem.0.min_p.4218.reload, !dbg !466
  %20 = trunc i64 %indvars.iv238.reg2mem.0.load to i8, !dbg !466
  %min_s.3 = select i1 %cmp137, i8 %20, i8 %min_s.2219.reg2mem.0.load, !dbg !466
    #dbg_value(i8 %min_s.3, !358, !DIExpression(), !377)
    #dbg_value(double %min_p.5, !356, !DIExpression(), !377)
  %indvars.iv.next239 = add nuw nsw i64 %indvars.iv238.reg2mem.0.load, 1, !dbg !467
    #dbg_value(i64 %indvars.iv.next239, !359, !DIExpression(), !377)
  %exitcond240.not = icmp eq i64 %indvars.iv.next239, 64, !dbg !468
  br i1 %exitcond240.not, label %for.end143, label %for.body122.for.body122_crit_edge, !dbg !457, !llvm.loop !469

for.body122.for.body122_crit_edge:                ; preds = %for.body122
  store double %min_p.5, ptr %min_p.4218.reg2mem, align 8
  store i8 %min_s.3, ptr %min_s.2219.reg2mem, align 1
  store i64 %indvars.iv.next239, ptr %indvars.iv238.reg2mem, align 8
  br label %for.body122, !dbg !457

for.end143:                                       ; preds = %for.body122
  store i8 %min_s.3, ptr %15, align 1, !dbg !471, !tbaa !380
  %indvars.iv.next242 = add nsw i64 %indvars.iv241.reg2mem172.0.load, -1, !dbg !472
    #dbg_value(i64 %indvars.iv.next242, !352, !DIExpression(), !377)
  %cmp101.not = icmp eq i64 %indvars.iv241.reg2mem172.0.load, 0, !dbg !473
  br i1 %cmp101.not, label %for.end147, label %for.end143.for.body103_crit_edge, !dbg !451, !llvm.loop !474

for.end143.for.body103_crit_edge:                 ; preds = %for.end143
  store i64 %indvars.iv.next242, ptr %indvars.iv241.reg2mem172, align 8
  br label %for.body103, !dbg !451

for.end147:                                       ; preds = %for.end143
  call void @llvm.lifetime.end.p0(i64 71680, ptr nonnull %llike) #18, !dbg !476
  ret i32 0, !dbg !477

polly.stmt.for.body19:                            ; preds = %polly.stmt.for.body19.polly.stmt.for.body19_crit_edge, %polly.loop_preheader
  %polly.indvar.reg2mem.0.load = load i64, ptr %polly.indvar.reg2mem, align 8
  %21 = shl nuw nsw i64 %polly.indvar.reg2mem.0.load, 3
  %scevgep = getelementptr i8, ptr %transition, i64 %21
  %_p_scalar_ = load double, ptr %scevgep, align 8, !alias.scope !478, !noalias !481
  %p_add30 = fadd double %.pre, %_p_scalar_, !dbg !405
  %22 = shl nuw nsw i64 %polly.indvar.reg2mem.0.load, 9
  %scevgep2 = getelementptr i8, ptr %scevgep1, i64 %22
  %_p_scalar_3 = load double, ptr %scevgep2, align 8, !alias.scope !484, !noalias !485
  %p_add39 = fadd double %p_add30, %_p_scalar_3, !dbg !407
  %polly.access.llike = getelementptr double, ptr %gep48, i64 %polly.indvar.reg2mem.0.load
  store double %p_add39, ptr %polly.access.llike, align 8, !alias.scope !486, !noalias !487
  %polly.indvar_next = add nuw nsw i64 %polly.indvar.reg2mem.0.load, 1
  store i64 %polly.indvar_next, ptr %polly.indvar_next.reg2mem, align 8
  %exitcond.not81 = icmp eq i64 %polly.indvar_next, 64
  br i1 %exitcond.not81, label %polly.loop_preheader5, label %polly.stmt.for.body19.polly.stmt.for.body19_crit_edge

polly.stmt.for.body19.polly.stmt.for.body19_crit_edge: ; preds = %polly.stmt.for.body19
  store i64 %polly.indvar_next, ptr %polly.indvar.reg2mem, align 8
  br label %polly.stmt.for.body19

polly.loop_preheader:                             ; preds = %polly.split_new_and_old
  %23 = shl nuw nsw i64 %5, 3
  %scevgep1 = getelementptr i8, ptr %emission, i64 %23
  store ptr %scevgep1, ptr %scevgep1.reg2mem, align 8
  %.idx = shl i64 %indvar.reg2mem178.0.load, 9
  store i64 %.idx, ptr %.idx.reg2mem, align 8
  %invariant.gep47.reg2mem.0.invariant.gep47.reload = load ptr, ptr %invariant.gep47.reg2mem, align 8
  %gep48 = getelementptr i8, ptr %invariant.gep47.reg2mem.0.invariant.gep47.reload, i64 %.idx
  store ptr %gep48, ptr %gep48.reg2mem, align 8
  store i64 0, ptr %polly.indvar.reg2mem, align 8
  br label %polly.stmt.for.body19

polly.loop_preheader5:                            ; preds = %polly.stmt.for.body19
  %scevgep32.reg2mem.0.scevgep32.reload = load ptr, ptr %scevgep32.reg2mem, align 8
  %scevgep33 = getelementptr i8, ptr %scevgep32.reg2mem.0.scevgep32.reload, i64 %.idx
  store ptr %scevgep33, ptr %scevgep33.reg2mem, align 8
  store i64 0, ptr %polly.indvar19.reg2mem164, align 8
  br label %polly.loop_preheader23

polly.loop_preheader23.1:                         ; preds = %polly.loop_exit24.polly.loop_preheader23.1_crit_edge, %polly.loop_exit24.1.polly.loop_preheader23.1_crit_edge
  %polly.indvar19.1.reg2mem170.0.load = load i64, ptr %polly.indvar19.1.reg2mem170, align 8
  store i64 %polly.indvar19.1.reg2mem170.0.load, ptr %polly.indvar19.1.reg2mem, align 8
  %polly.access.llike30.1 = getelementptr double, ptr %gep48, i64 %polly.indvar19.1.reg2mem170.0.load
  store ptr %polly.access.llike30.1, ptr %polly.access.llike30.1.reg2mem, align 8
  %polly.access.emission.idx.1 = shl i64 %polly.indvar19.1.reg2mem170.0.load, 9
  %polly.access.emission.1 = getelementptr i8, ptr %invariant.gep245, i64 %polly.access.emission.idx.1
  %_p_scalar_31.1 = load double, ptr %polly.access.emission.1, align 8
  store double %_p_scalar_31.1, ptr %_p_scalar_31.1.reg2mem, align 8
  %24 = shl i64 %polly.indvar19.1.reg2mem170.0.load, 3
  %invariant.gep44.1 = getelementptr i8, ptr %scevgep36.reg2mem.0.scevgep36.reload162, i64 %24
  store ptr %invariant.gep44.1, ptr %invariant.gep44.1.reg2mem, align 8
  %polly.access.llike30.promoted.1 = load double, ptr %polly.access.llike30.1, align 8
  store double %polly.access.llike30.promoted.1, ptr %polly.access.llike30.promoted.1.reg2mem, align 8
  store i64 0, ptr %polly.indvar25.1.reg2mem, align 8
  store double %polly.access.llike30.promoted.1, ptr %polly.access.llike30.reload46.1.reg2mem, align 8
  br label %polly.stmt.for.body44.1

polly.stmt.for.body44.1:                          ; preds = %polly.stmt.for.body44.1.polly.stmt.for.body44.1_crit_edge, %polly.loop_preheader23.1
  %polly.access.llike30.reload46.1.reg2mem.0.polly.access.llike30.reload46.1.reload = load double, ptr %polly.access.llike30.reload46.1.reg2mem, align 8
  %polly.indvar25.1.reg2mem.0.load = load i64, ptr %polly.indvar25.1.reg2mem, align 8
  %25 = add nuw nsw i64 %polly.indvar25.1.reg2mem.0.load, 32
  %26 = shl i64 %25, 3
  %scevgep34.1 = getelementptr i8, ptr %scevgep33, i64 %26
  %_p_scalar_35.1 = load double, ptr %scevgep34.1, align 8, !alias.scope !486, !noalias !487
  %27 = shl i64 %25, 9
  %gep45.1 = getelementptr i8, ptr %invariant.gep44.1, i64 %27
  %_p_scalar_38.1 = load double, ptr %gep45.1, align 8, !alias.scope !478, !noalias !481
  %p_add56.1 = fadd double %_p_scalar_35.1, %_p_scalar_38.1, !dbg !415
  %p_add65.1 = fadd double %_p_scalar_31.1, %p_add56.1, !dbg !416
  %p_cmp66.1 = fcmp olt double %p_add65.1, %polly.access.llike30.reload46.1.reg2mem.0.polly.access.llike30.reload46.1.reload, !dbg !417
  %p_min_p.1.1 = select i1 %p_cmp66.1, double %p_add65.1, double %polly.access.llike30.reload46.1.reg2mem.0.polly.access.llike30.reload46.1.reload, !dbg !419
  store double %p_min_p.1.1, ptr %p_min_p.1.1.reg2mem, align 8
  store double %p_min_p.1.1, ptr %polly.access.llike30.1, align 8, !alias.scope !486, !noalias !487
  %polly.indvar_next26.1 = add nuw nsw i64 %polly.indvar25.1.reg2mem.0.load, 1
  store i64 %polly.indvar_next26.1, ptr %polly.indvar_next26.1.reg2mem, align 8
  %exitcond54.1.not = icmp eq i64 %polly.indvar_next26.1, 31
  br i1 %exitcond54.1.not, label %polly.loop_exit24.1, label %polly.stmt.for.body44.1.polly.stmt.for.body44.1_crit_edge

polly.stmt.for.body44.1.polly.stmt.for.body44.1_crit_edge: ; preds = %polly.stmt.for.body44.1
  store i64 %polly.indvar_next26.1, ptr %polly.indvar25.1.reg2mem, align 8
  store double %p_min_p.1.1, ptr %polly.access.llike30.reload46.1.reg2mem, align 8
  br label %polly.stmt.for.body44.1

polly.loop_exit24.1:                              ; preds = %polly.stmt.for.body44.1
  %polly.indvar_next20.1 = add nuw nsw i64 %polly.indvar19.1.reg2mem170.0.load, 1
  store i64 %polly.indvar_next20.1, ptr %polly.indvar_next20.1.reg2mem, align 8
  %exitcond55.1.not = icmp eq i64 %polly.indvar_next20.1, 32
  br i1 %exitcond55.1.not, label %polly.loop_exit18.1, label %polly.loop_exit24.1.polly.loop_preheader23.1_crit_edge

polly.loop_exit24.1.polly.loop_preheader23.1_crit_edge: ; preds = %polly.loop_exit24.1
  store i64 %polly.indvar_next20.1, ptr %polly.indvar19.1.reg2mem170, align 8
  br label %polly.loop_preheader23.1

polly.loop_exit18.1:                              ; preds = %polly.loop_exit24.1
  %28 = or disjoint i64 %5, 2048
  %29 = getelementptr double, ptr %emission, i64 %28
  store ptr %29, ptr %.reg2mem, align 8
  store i64 0, ptr %polly.indvar19.156.reg2mem168, align 8
  br label %polly.loop_preheader23.163

polly.loop_preheader23.163:                       ; preds = %polly.loop_exit24.179.polly.loop_preheader23.163_crit_edge, %polly.loop_exit18.1
  %polly.indvar19.156.reg2mem168.0.load = load i64, ptr %polly.indvar19.156.reg2mem168, align 8
  store i64 %polly.indvar19.156.reg2mem168.0.load, ptr %polly.indvar19.156.reg2mem, align 8
  %30 = add nuw nsw i64 %polly.indvar19.156.reg2mem168.0.load, 32
  %polly.access.llike30.157 = getelementptr double, ptr %gep48, i64 %30
  store ptr %polly.access.llike30.157, ptr %polly.access.llike30.157.reg2mem, align 8
  %polly.access.emission.idx.158 = shl i64 %polly.indvar19.156.reg2mem168.0.load, 9
  %polly.access.emission.159 = getelementptr i8, ptr %29, i64 %polly.access.emission.idx.158
  %_p_scalar_31.160 = load double, ptr %polly.access.emission.159, align 8
  store double %_p_scalar_31.160, ptr %_p_scalar_31.160.reg2mem, align 8
  %31 = shl i64 %30, 3
  %invariant.gep44.161 = getelementptr i8, ptr %scevgep36.reg2mem.0.scevgep36.reload162, i64 %31
  store ptr %invariant.gep44.161, ptr %invariant.gep44.161.reg2mem, align 8
  %polly.access.llike30.promoted.162 = load double, ptr %polly.access.llike30.157, align 8
  store double %polly.access.llike30.promoted.162, ptr %polly.access.llike30.promoted.162.reg2mem, align 8
  store i64 0, ptr %polly.indvar25.165.reg2mem, align 8
  store double %polly.access.llike30.promoted.162, ptr %polly.access.llike30.reload46.164.reg2mem, align 8
  br label %polly.stmt.for.body44.176

polly.stmt.for.body44.176:                        ; preds = %polly.stmt.for.body44.176.polly.stmt.for.body44.176_crit_edge, %polly.loop_preheader23.163
  %polly.access.llike30.reload46.164.reg2mem.0.polly.access.llike30.reload46.164.reload = load double, ptr %polly.access.llike30.reload46.164.reg2mem, align 8
  %polly.indvar25.165.reg2mem.0.load = load i64, ptr %polly.indvar25.165.reg2mem, align 8
  %32 = shl i64 %polly.indvar25.165.reg2mem.0.load, 3
  %scevgep34.166 = getelementptr i8, ptr %scevgep33, i64 %32
  %_p_scalar_35.167 = load double, ptr %scevgep34.166, align 8, !alias.scope !486, !noalias !487
  %33 = shl i64 %polly.indvar25.165.reg2mem.0.load, 9
  %gep45.168 = getelementptr i8, ptr %invariant.gep44.161, i64 %33
  %_p_scalar_38.169 = load double, ptr %gep45.168, align 8, !alias.scope !478, !noalias !481
  %p_add56.170 = fadd double %_p_scalar_35.167, %_p_scalar_38.169, !dbg !415
  %p_add65.171 = fadd double %_p_scalar_31.160, %p_add56.170, !dbg !416
  %p_cmp66.172 = fcmp olt double %p_add65.171, %polly.access.llike30.reload46.164.reg2mem.0.polly.access.llike30.reload46.164.reload, !dbg !417
  %p_min_p.1.173 = select i1 %p_cmp66.172, double %p_add65.171, double %polly.access.llike30.reload46.164.reg2mem.0.polly.access.llike30.reload46.164.reload, !dbg !419
  store double %p_min_p.1.173, ptr %p_min_p.1.173.reg2mem, align 8
  store double %p_min_p.1.173, ptr %polly.access.llike30.157, align 8, !alias.scope !486, !noalias !487
  %polly.indvar_next26.174 = add nuw nsw i64 %polly.indvar25.165.reg2mem.0.load, 1
  store i64 %polly.indvar_next26.174, ptr %polly.indvar_next26.174.reg2mem, align 8
  %exitcond54.175.not = icmp eq i64 %polly.indvar_next26.174, 32
  br i1 %exitcond54.175.not, label %polly.loop_exit24.179, label %polly.stmt.for.body44.176.polly.stmt.for.body44.176_crit_edge

polly.stmt.for.body44.176.polly.stmt.for.body44.176_crit_edge: ; preds = %polly.stmt.for.body44.176
  store i64 %polly.indvar_next26.174, ptr %polly.indvar25.165.reg2mem, align 8
  store double %p_min_p.1.173, ptr %polly.access.llike30.reload46.164.reg2mem, align 8
  br label %polly.stmt.for.body44.176

polly.loop_exit24.179:                            ; preds = %polly.stmt.for.body44.176
  %polly.indvar_next20.177 = add nuw nsw i64 %polly.indvar19.156.reg2mem168.0.load, 1
  store i64 %polly.indvar_next20.177, ptr %polly.indvar_next20.177.reg2mem, align 8
  %exitcond55.178.not = icmp eq i64 %polly.indvar_next20.177, 32
  br i1 %exitcond55.178.not, label %polly.loop_exit24.179.polly.loop_preheader23.1.1_crit_edge, label %polly.loop_exit24.179.polly.loop_preheader23.163_crit_edge

polly.loop_exit24.179.polly.loop_preheader23.163_crit_edge: ; preds = %polly.loop_exit24.179
  store i64 %polly.indvar_next20.177, ptr %polly.indvar19.156.reg2mem168, align 8
  br label %polly.loop_preheader23.163

polly.loop_exit24.179.polly.loop_preheader23.1.1_crit_edge: ; preds = %polly.loop_exit24.179
  store i64 0, ptr %polly.indvar19.1.1.reg2mem166, align 8
  br label %polly.loop_preheader23.1.1

polly.loop_preheader23.1.1:                       ; preds = %polly.loop_exit24.1.1.polly.loop_preheader23.1.1_crit_edge, %polly.loop_exit24.179.polly.loop_preheader23.1.1_crit_edge
  %polly.indvar19.1.1.reg2mem166.0.load = load i64, ptr %polly.indvar19.1.1.reg2mem166, align 8
  store i64 %polly.indvar19.1.1.reg2mem166.0.load, ptr %polly.indvar19.1.1.reg2mem, align 8
  %34 = add nuw nsw i64 %polly.indvar19.1.1.reg2mem166.0.load, 32
  %polly.access.llike30.1.1 = getelementptr double, ptr %gep48, i64 %34
  store ptr %polly.access.llike30.1.1, ptr %polly.access.llike30.1.1.reg2mem, align 8
  %polly.access.emission.idx.1.1 = shl i64 %polly.indvar19.1.1.reg2mem166.0.load, 9
  %polly.access.emission.1.1 = getelementptr i8, ptr %29, i64 %polly.access.emission.idx.1.1
  %_p_scalar_31.1.1 = load double, ptr %polly.access.emission.1.1, align 8
  store double %_p_scalar_31.1.1, ptr %_p_scalar_31.1.1.reg2mem, align 8
  %35 = shl i64 %34, 3
  %scevgep36.reg2mem.0.scevgep36.reload = load ptr, ptr %scevgep36.reg2mem, align 8
  %invariant.gep44.1.1 = getelementptr i8, ptr %scevgep36.reg2mem.0.scevgep36.reload, i64 %35
  store ptr %invariant.gep44.1.1, ptr %invariant.gep44.1.1.reg2mem, align 8
  %polly.access.llike30.promoted.1.1 = load double, ptr %polly.access.llike30.1.1, align 8
  store double %polly.access.llike30.promoted.1.1, ptr %polly.access.llike30.promoted.1.1.reg2mem, align 8
  store i64 0, ptr %polly.indvar25.1.1.reg2mem, align 8
  store double %polly.access.llike30.promoted.1.1, ptr %polly.access.llike30.reload46.1.1.reg2mem, align 8
  br label %polly.stmt.for.body44.1.1

polly.stmt.for.body44.1.1:                        ; preds = %polly.stmt.for.body44.1.1.polly.stmt.for.body44.1.1_crit_edge, %polly.loop_preheader23.1.1
  %polly.access.llike30.reload46.1.1.reg2mem.0.polly.access.llike30.reload46.1.1.reload = load double, ptr %polly.access.llike30.reload46.1.1.reg2mem, align 8
  %polly.indvar25.1.1.reg2mem.0.load = load i64, ptr %polly.indvar25.1.1.reg2mem, align 8
  %36 = add nuw nsw i64 %polly.indvar25.1.1.reg2mem.0.load, 32
  %37 = shl i64 %36, 3
  %scevgep34.1.1 = getelementptr i8, ptr %scevgep33, i64 %37
  %_p_scalar_35.1.1 = load double, ptr %scevgep34.1.1, align 8, !alias.scope !486, !noalias !487
  %38 = shl i64 %36, 9
  %gep45.1.1 = getelementptr i8, ptr %invariant.gep44.1.1, i64 %38
  %_p_scalar_38.1.1 = load double, ptr %gep45.1.1, align 8, !alias.scope !478, !noalias !481
  %p_add56.1.1 = fadd double %_p_scalar_35.1.1, %_p_scalar_38.1.1, !dbg !415
  %p_add65.1.1 = fadd double %_p_scalar_31.1.1, %p_add56.1.1, !dbg !416
  %p_cmp66.1.1 = fcmp olt double %p_add65.1.1, %polly.access.llike30.reload46.1.1.reg2mem.0.polly.access.llike30.reload46.1.1.reload, !dbg !417
  %p_min_p.1.1.1 = select i1 %p_cmp66.1.1, double %p_add65.1.1, double %polly.access.llike30.reload46.1.1.reg2mem.0.polly.access.llike30.reload46.1.1.reload, !dbg !419
  store double %p_min_p.1.1.1, ptr %p_min_p.1.1.1.reg2mem, align 8
  store double %p_min_p.1.1.1, ptr %polly.access.llike30.1.1, align 8, !alias.scope !486, !noalias !487
  %polly.indvar_next26.1.1 = add nuw nsw i64 %polly.indvar25.1.1.reg2mem.0.load, 1
  store i64 %polly.indvar_next26.1.1, ptr %polly.indvar_next26.1.1.reg2mem, align 8
  %exitcond54.1.1.not = icmp eq i64 %polly.indvar_next26.1.1, 31
  br i1 %exitcond54.1.1.not, label %polly.loop_exit24.1.1, label %polly.stmt.for.body44.1.1.polly.stmt.for.body44.1.1_crit_edge

polly.stmt.for.body44.1.1.polly.stmt.for.body44.1.1_crit_edge: ; preds = %polly.stmt.for.body44.1.1
  store i64 %polly.indvar_next26.1.1, ptr %polly.indvar25.1.1.reg2mem, align 8
  store double %p_min_p.1.1.1, ptr %polly.access.llike30.reload46.1.1.reg2mem, align 8
  br label %polly.stmt.for.body44.1.1

polly.loop_exit24.1.1:                            ; preds = %polly.stmt.for.body44.1.1
  %polly.indvar_next20.1.1 = add nuw nsw i64 %polly.indvar19.1.1.reg2mem166.0.load, 1
  store i64 %polly.indvar_next20.1.1, ptr %polly.indvar_next20.1.1.reg2mem, align 8
  %exitcond55.1.1.not = icmp eq i64 %polly.indvar_next20.1.1, 32
  br i1 %exitcond55.1.1.not, label %polly.loop_exit24.1.1.for.inc78_crit_edge, label %polly.loop_exit24.1.1.polly.loop_preheader23.1.1_crit_edge

polly.loop_exit24.1.1.polly.loop_preheader23.1.1_crit_edge: ; preds = %polly.loop_exit24.1.1
  store i64 %polly.indvar_next20.1.1, ptr %polly.indvar19.1.1.reg2mem166, align 8
  br label %polly.loop_preheader23.1.1

polly.loop_exit24.1.1.for.inc78_crit_edge:        ; preds = %polly.loop_exit24.1.1
  br label %for.inc78

polly.loop_exit24:                                ; preds = %polly.stmt.for.body44
  %polly.indvar_next20 = add nuw nsw i64 %polly.indvar19.reg2mem164.0.load, 1
  store i64 %polly.indvar_next20, ptr %polly.indvar_next20.reg2mem, align 8
  %exitcond55.not = icmp eq i64 %polly.indvar_next20, 32
  br i1 %exitcond55.not, label %polly.loop_exit24.polly.loop_preheader23.1_crit_edge, label %polly.loop_exit24.polly.loop_preheader23_crit_edge

polly.loop_exit24.polly.loop_preheader23_crit_edge: ; preds = %polly.loop_exit24
  store i64 %polly.indvar_next20, ptr %polly.indvar19.reg2mem164, align 8
  br label %polly.loop_preheader23

polly.loop_exit24.polly.loop_preheader23.1_crit_edge: ; preds = %polly.loop_exit24
  store i64 0, ptr %polly.indvar19.1.reg2mem170, align 8
  br label %polly.loop_preheader23.1

polly.stmt.for.body44:                            ; preds = %polly.stmt.for.body44.polly.stmt.for.body44_crit_edge, %polly.loop_preheader23
  %polly.access.llike30.reload46.reg2mem.0.polly.access.llike30.reload46.reload = load double, ptr %polly.access.llike30.reload46.reg2mem, align 8
  %polly.indvar25.reg2mem.0.load = load i64, ptr %polly.indvar25.reg2mem, align 8
  %39 = shl i64 %polly.indvar25.reg2mem.0.load, 3
  %scevgep34 = getelementptr i8, ptr %scevgep33, i64 %39
  %_p_scalar_35 = load double, ptr %scevgep34, align 8, !alias.scope !486, !noalias !487
  %40 = shl i64 %polly.indvar25.reg2mem.0.load, 9
  %gep45 = getelementptr i8, ptr %invariant.gep44, i64 %40
  %_p_scalar_38 = load double, ptr %gep45, align 8, !alias.scope !478, !noalias !481
  %p_add56 = fadd double %_p_scalar_35, %_p_scalar_38, !dbg !415
  %p_add65 = fadd double %_p_scalar_31, %p_add56, !dbg !416
  %p_cmp66 = fcmp olt double %p_add65, %polly.access.llike30.reload46.reg2mem.0.polly.access.llike30.reload46.reload, !dbg !417
  %p_min_p.1 = select i1 %p_cmp66, double %p_add65, double %polly.access.llike30.reload46.reg2mem.0.polly.access.llike30.reload46.reload, !dbg !419
  store double %p_min_p.1, ptr %p_min_p.1.reg2mem, align 8
  store double %p_min_p.1, ptr %polly.access.llike30, align 8, !alias.scope !486, !noalias !487
  %polly.indvar_next26 = add nuw nsw i64 %polly.indvar25.reg2mem.0.load, 1
  store i64 %polly.indvar_next26, ptr %polly.indvar_next26.reg2mem, align 8
  %exitcond54.not = icmp eq i64 %polly.indvar_next26, 32
  br i1 %exitcond54.not, label %polly.loop_exit24, label %polly.stmt.for.body44.polly.stmt.for.body44_crit_edge

polly.stmt.for.body44.polly.stmt.for.body44_crit_edge: ; preds = %polly.stmt.for.body44
  store i64 %polly.indvar_next26, ptr %polly.indvar25.reg2mem, align 8
  store double %p_min_p.1, ptr %polly.access.llike30.reload46.reg2mem, align 8
  br label %polly.stmt.for.body44

polly.loop_preheader23:                           ; preds = %polly.loop_exit24.polly.loop_preheader23_crit_edge, %polly.loop_preheader5
  %polly.indvar19.reg2mem164.0.load = load i64, ptr %polly.indvar19.reg2mem164, align 8
  store i64 %polly.indvar19.reg2mem164.0.load, ptr %polly.indvar19.reg2mem, align 8
  %polly.access.llike30 = getelementptr double, ptr %gep48, i64 %polly.indvar19.reg2mem164.0.load
  store ptr %polly.access.llike30, ptr %polly.access.llike30.reg2mem, align 8
  %polly.access.emission.idx = shl i64 %polly.indvar19.reg2mem164.0.load, 9
  %polly.access.emission = getelementptr i8, ptr %invariant.gep245, i64 %polly.access.emission.idx
  %_p_scalar_31 = load double, ptr %polly.access.emission, align 8
  store double %_p_scalar_31, ptr %_p_scalar_31.reg2mem, align 8
  %41 = shl i64 %polly.indvar19.reg2mem164.0.load, 3
  %scevgep36.reg2mem.0.scevgep36.reload162 = load ptr, ptr %scevgep36.reg2mem, align 8
  %invariant.gep44 = getelementptr i8, ptr %scevgep36.reg2mem.0.scevgep36.reload162, i64 %41
  store ptr %invariant.gep44, ptr %invariant.gep44.reg2mem, align 8
  %polly.access.llike30.promoted = load double, ptr %polly.access.llike30, align 8
  store double %polly.access.llike30.promoted, ptr %polly.access.llike30.promoted.reg2mem, align 8
  store i64 0, ptr %polly.indvar25.reg2mem, align 8
  store double %polly.access.llike30.promoted, ptr %polly.access.llike30.reload46.reg2mem, align 8
  br label %polly.stmt.for.body44
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #2 !dbg !488 {
entry.split:
    #dbg_value(ptr %vargs, !492, !DIExpression(), !494)
    #dbg_value(ptr %vargs, !493, !DIExpression(), !494)
  %init = getelementptr inbounds i8, ptr %vargs, i64 144, !dbg !495
  %transition = getelementptr inbounds i8, ptr %vargs, i64 656, !dbg !496
  %emission = getelementptr inbounds i8, ptr %vargs, i64 33424, !dbg !497
  %path = getelementptr inbounds i8, ptr %vargs, i64 66192, !dbg !498
  %call = tail call signext i32 @viterbi(ptr noundef %vargs, ptr noundef nonnull %init, ptr noundef nonnull %transition, ptr noundef nonnull %emission, ptr noundef nonnull %path) #18, !dbg !499
  ret void, !dbg !500
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #3 !dbg !501 {
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
    #dbg_value(i32 %fd, !505, !DIExpression(), !510)
    #dbg_value(ptr %vdata, !506, !DIExpression(), !510)
    #dbg_value(ptr %vdata, !507, !DIExpression(), !510)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(66336) %vdata, i8 0, i64 66336, i1 false), !dbg !511
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !512
    #dbg_value(ptr %call, !508, !DIExpression(), !510)
    #dbg_value(ptr %call, !513, !DIExpression(), !520)
    #dbg_value(i32 1, !518, !DIExpression(), !520)
    #dbg_value(i32 0, !519, !DIExpression(), !520)
  store ptr %call, ptr %call.reg2mem, align 8
  store ptr %call, ptr %s.addr.040.i.reg2mem166, align 8
  store i32 0, ptr %i.041.i.reg2mem168, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem168.0.load, !519, !DIExpression(), !520)
    #dbg_value(ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, !513, !DIExpression(), !520)
  %i.041.i.reg2mem168.0.load = load i32, ptr %i.041.i.reg2mem168, align 4
  %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167 = load ptr, ptr %s.addr.040.i.reg2mem166, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, align 1, !dbg !522, !tbaa !380
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !523

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !523

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem168.0.load, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !523

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 1, !dbg !524
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !524, !tbaa !380
  %cmp13.i = icmp eq i8 %1, 37, !dbg !527
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !528

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem168.0.load, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !528

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 2, !dbg !529
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !529, !tbaa !380
  %cmp18.i = icmp eq i8 %2, 10, !dbg !530
  %inc.i = zext i1 %cmp18.i to i32, !dbg !531
  %spec.select.i = add nsw i32 %i.041.i.reg2mem168.0.load, %inc.i, !dbg !531
  store i32 %spec.select.i, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !531

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem164.0.load, !519, !DIExpression(), !520)
  %i.1.i.reg2mem164.0.load = load i32, ptr %i.1.i.reg2mem164, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 1, !dbg !532
    #dbg_value(ptr %incdec.ptr.i, !513, !DIExpression(), !520)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem164.0.load, 1, !dbg !533
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !534, !llvm.loop !535

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem166, align 8
  store i32 %i.1.i.reg2mem164.0.load, ptr %i.041.i.reg2mem168, align 4
  br label %land.rhs.i, !dbg !534

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !537, !tbaa !380
  %3 = icmp eq i8 %.pre.i, 0, !dbg !539
  %4 = select i1 %3, i64 0, i64 2, !dbg !540
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !534

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !540
    #dbg_value(ptr %spec.select38.i, !509, !DIExpression(), !510)
  %call2 = tail call signext i32 @parse_uint8_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 140) #18, !dbg !541
    #dbg_value(ptr %call, !513, !DIExpression(), !542)
    #dbg_value(i32 2, !518, !DIExpression(), !542)
    #dbg_value(i32 0, !519, !DIExpression(), !542)
  store ptr %call, ptr %s.addr.040.i3.reg2mem160, align 8
  store i32 0, ptr %i.041.i2.reg2mem162, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem162.0.load, !519, !DIExpression(), !542)
    #dbg_value(ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, !513, !DIExpression(), !542)
  %i.041.i2.reg2mem162.0.load = load i32, ptr %i.041.i2.reg2mem162, align 4
  %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161 = load ptr, ptr %s.addr.040.i3.reg2mem160, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, align 1, !dbg !544, !tbaa !380
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !545

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !545

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem162.0.load, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !545

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 1, !dbg !546
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !546, !tbaa !380
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !547
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !548

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem162.0.load, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !548

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 2, !dbg !549
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !549, !tbaa !380
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !550
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !551
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem162.0.load, %inc.i19, !dbg !551
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !551

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem158.0.load, !519, !DIExpression(), !542)
  %i.1.i8.reg2mem158.0.load = load i32, ptr %i.1.i8.reg2mem158, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 1, !dbg !552
    #dbg_value(ptr %incdec.ptr.i9, !513, !DIExpression(), !542)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem158.0.load, 2, !dbg !553
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !554, !llvm.loop !555

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem160, align 8
  store i32 %i.1.i8.reg2mem158.0.load, ptr %i.041.i2.reg2mem162, align 4
  br label %land.rhs.i1, !dbg !554

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !557, !tbaa !380
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !558
  %9 = select i1 %8, i64 0, i64 2, !dbg !559
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !554

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !559
    #dbg_value(ptr %spec.select38.i15, !509, !DIExpression(), !510)
  %init = getelementptr inbounds i8, ptr %vdata, i64 144, !dbg !560
  %call5 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %init, i32 noundef signext 64) #18, !dbg !561
    #dbg_value(ptr %call, !513, !DIExpression(), !562)
    #dbg_value(i32 3, !518, !DIExpression(), !562)
    #dbg_value(i32 0, !519, !DIExpression(), !562)
  store ptr %call, ptr %s.addr.040.i24.reg2mem154, align 8
  store i32 0, ptr %i.041.i23.reg2mem156, align 4
  br label %land.rhs.i22

land.rhs.i22:                                     ; preds = %if.end21.i28.land.rhs.i22_crit_edge, %find_section_start.exit21
    #dbg_value(i32 %i.041.i23.reg2mem156.0.load, !519, !DIExpression(), !562)
    #dbg_value(ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, !513, !DIExpression(), !562)
  %i.041.i23.reg2mem156.0.load = load i32, ptr %i.041.i23.reg2mem156, align 4
  %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155 = load ptr, ptr %s.addr.040.i24.reg2mem154, align 8
  %10 = load i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, align 1, !dbg !564, !tbaa !380
  switch i8 %10, label %land.rhs.i22.if.end21.i28_crit_edge [
    i8 0, label %land.rhs.i22.find_section_start.exit42_crit_edge
    i8 37, label %land.lhs.true10.i25
  ], !dbg !565

land.rhs.i22.find_section_start.exit42_crit_edge: ; preds = %land.rhs.i22
  store ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !565

land.rhs.i22.if.end21.i28_crit_edge:              ; preds = %land.rhs.i22
  store i32 %i.041.i23.reg2mem156.0.load, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !565

land.lhs.true10.i25:                              ; preds = %land.rhs.i22
  %arrayidx11.i26 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 1, !dbg !566
  %11 = load i8, ptr %arrayidx11.i26, align 1, !dbg !566, !tbaa !380
  %cmp13.i27 = icmp eq i8 %11, 37, !dbg !567
  br i1 %cmp13.i27, label %land.lhs.true15.i37, label %land.lhs.true10.i25.if.end21.i28_crit_edge, !dbg !568

land.lhs.true10.i25.if.end21.i28_crit_edge:       ; preds = %land.lhs.true10.i25
  store i32 %i.041.i23.reg2mem156.0.load, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !568

land.lhs.true15.i37:                              ; preds = %land.lhs.true10.i25
  %arrayidx16.i38 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 2, !dbg !569
  %12 = load i8, ptr %arrayidx16.i38, align 1, !dbg !569, !tbaa !380
  %cmp18.i39 = icmp eq i8 %12, 10, !dbg !570
  %inc.i40 = zext i1 %cmp18.i39 to i32, !dbg !571
  %spec.select.i41 = add nsw i32 %i.041.i23.reg2mem156.0.load, %inc.i40, !dbg !571
  store i32 %spec.select.i41, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !571

if.end21.i28:                                     ; preds = %land.lhs.true10.i25.if.end21.i28_crit_edge, %land.rhs.i22.if.end21.i28_crit_edge, %land.lhs.true15.i37
    #dbg_value(i32 %i.1.i29.reg2mem152.0.load, !519, !DIExpression(), !562)
  %i.1.i29.reg2mem152.0.load = load i32, ptr %i.1.i29.reg2mem152, align 4
  %incdec.ptr.i30 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 1, !dbg !572
    #dbg_value(ptr %incdec.ptr.i30, !513, !DIExpression(), !562)
  %cmp4.i31 = icmp slt i32 %i.1.i29.reg2mem152.0.load, 3, !dbg !573
  br i1 %cmp4.i31, label %if.end21.i28.land.rhs.i22_crit_edge, label %if.end21.while.end_crit_edge.i32, !dbg !574, !llvm.loop !575

if.end21.i28.land.rhs.i22_crit_edge:              ; preds = %if.end21.i28
  store ptr %incdec.ptr.i30, ptr %s.addr.040.i24.reg2mem154, align 8
  store i32 %i.1.i29.reg2mem152.0.load, ptr %i.041.i23.reg2mem156, align 4
  br label %land.rhs.i22, !dbg !574

if.end21.while.end_crit_edge.i32:                 ; preds = %if.end21.i28
  %.pre.i33 = load i8, ptr %incdec.ptr.i30, align 1, !dbg !577, !tbaa !380
  %13 = icmp eq i8 %.pre.i33, 0, !dbg !578
  %14 = select i1 %13, i64 0, i64 2, !dbg !579
  store ptr %incdec.ptr.i30, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 %14, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !574

find_section_start.exit42:                        ; preds = %land.rhs.i22.find_section_start.exit42_crit_edge, %if.end21.while.end_crit_edge.i32
  %cmp23.not.i34.reg2mem.0.load = load i64, ptr %cmp23.not.i34.reg2mem, align 8
  %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload = load ptr, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  %spec.select38.i36 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload, i64 %cmp23.not.i34.reg2mem.0.load, !dbg !579
    #dbg_value(ptr %spec.select38.i36, !509, !DIExpression(), !510)
  %transition = getelementptr inbounds i8, ptr %vdata, i64 656, !dbg !580
  %call8 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i36, ptr noundef nonnull %transition, i32 noundef signext 4096) #18, !dbg !581
    #dbg_value(ptr %call, !513, !DIExpression(), !582)
    #dbg_value(i32 4, !518, !DIExpression(), !582)
    #dbg_value(i32 0, !519, !DIExpression(), !582)
  store ptr %call, ptr %s.addr.040.i45.reg2mem148, align 8
  store i32 0, ptr %i.041.i44.reg2mem150, align 4
  br label %land.rhs.i43

land.rhs.i43:                                     ; preds = %if.end21.i49.land.rhs.i43_crit_edge, %find_section_start.exit42
    #dbg_value(i32 %i.041.i44.reg2mem150.0.load, !519, !DIExpression(), !582)
    #dbg_value(ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, !513, !DIExpression(), !582)
  %i.041.i44.reg2mem150.0.load = load i32, ptr %i.041.i44.reg2mem150, align 4
  %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149 = load ptr, ptr %s.addr.040.i45.reg2mem148, align 8
  %15 = load i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, align 1, !dbg !584, !tbaa !380
  switch i8 %15, label %land.rhs.i43.if.end21.i49_crit_edge [
    i8 0, label %land.rhs.i43.find_section_start.exit63_crit_edge
    i8 37, label %land.lhs.true10.i46
  ], !dbg !585

land.rhs.i43.find_section_start.exit63_crit_edge: ; preds = %land.rhs.i43
  store ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i55.reg2mem, align 8
  br label %find_section_start.exit63, !dbg !585

land.rhs.i43.if.end21.i49_crit_edge:              ; preds = %land.rhs.i43
  store i32 %i.041.i44.reg2mem150.0.load, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !585

land.lhs.true10.i46:                              ; preds = %land.rhs.i43
  %arrayidx11.i47 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 1, !dbg !586
  %16 = load i8, ptr %arrayidx11.i47, align 1, !dbg !586, !tbaa !380
  %cmp13.i48 = icmp eq i8 %16, 37, !dbg !587
  br i1 %cmp13.i48, label %land.lhs.true15.i58, label %land.lhs.true10.i46.if.end21.i49_crit_edge, !dbg !588

land.lhs.true10.i46.if.end21.i49_crit_edge:       ; preds = %land.lhs.true10.i46
  store i32 %i.041.i44.reg2mem150.0.load, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !588

land.lhs.true15.i58:                              ; preds = %land.lhs.true10.i46
  %arrayidx16.i59 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 2, !dbg !589
  %17 = load i8, ptr %arrayidx16.i59, align 1, !dbg !589, !tbaa !380
  %cmp18.i60 = icmp eq i8 %17, 10, !dbg !590
  %inc.i61 = zext i1 %cmp18.i60 to i32, !dbg !591
  %spec.select.i62 = add nsw i32 %i.041.i44.reg2mem150.0.load, %inc.i61, !dbg !591
  store i32 %spec.select.i62, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !591

if.end21.i49:                                     ; preds = %land.lhs.true10.i46.if.end21.i49_crit_edge, %land.rhs.i43.if.end21.i49_crit_edge, %land.lhs.true15.i58
    #dbg_value(i32 %i.1.i50.reg2mem146.0.load, !519, !DIExpression(), !582)
  %i.1.i50.reg2mem146.0.load = load i32, ptr %i.1.i50.reg2mem146, align 4
  %incdec.ptr.i51 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 1, !dbg !592
    #dbg_value(ptr %incdec.ptr.i51, !513, !DIExpression(), !582)
  %cmp4.i52 = icmp slt i32 %i.1.i50.reg2mem146.0.load, 4, !dbg !593
  br i1 %cmp4.i52, label %if.end21.i49.land.rhs.i43_crit_edge, label %if.end21.while.end_crit_edge.i53, !dbg !594, !llvm.loop !595

if.end21.i49.land.rhs.i43_crit_edge:              ; preds = %if.end21.i49
  store ptr %incdec.ptr.i51, ptr %s.addr.040.i45.reg2mem148, align 8
  store i32 %i.1.i50.reg2mem146.0.load, ptr %i.041.i44.reg2mem150, align 4
  br label %land.rhs.i43, !dbg !594

if.end21.while.end_crit_edge.i53:                 ; preds = %if.end21.i49
  %.pre.i54 = load i8, ptr %incdec.ptr.i51, align 1, !dbg !597, !tbaa !380
  %18 = icmp eq i8 %.pre.i54, 0, !dbg !598
  %19 = select i1 %18, i64 0, i64 2, !dbg !599
  store ptr %incdec.ptr.i51, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  store i64 %19, ptr %cmp23.not.i55.reg2mem, align 8
  br label %find_section_start.exit63, !dbg !594

find_section_start.exit63:                        ; preds = %land.rhs.i43.find_section_start.exit63_crit_edge, %if.end21.while.end_crit_edge.i53
  %cmp23.not.i55.reg2mem.0.load = load i64, ptr %cmp23.not.i55.reg2mem, align 8
  %s.addr.0.lcssa.ph.i56.reg2mem.0.s.addr.0.lcssa.ph.i56.reload = load ptr, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  %spec.select38.i57 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i56.reg2mem.0.s.addr.0.lcssa.ph.i56.reload, i64 %cmp23.not.i55.reg2mem.0.load, !dbg !599
    #dbg_value(ptr %spec.select38.i57, !509, !DIExpression(), !510)
  %emission = getelementptr inbounds i8, ptr %vdata, i64 33424, !dbg !600
  %call11 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i57, ptr noundef nonnull %emission, i32 noundef signext 4096) #18, !dbg !601
  %call.reg2mem.0.call.reload145 = load ptr, ptr %call.reg2mem, align 8
  tail call void @free(ptr noundef %call.reg2mem.0.call.reload145) #18, !dbg !602
  ret void, !dbg !603
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !604 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #3 !dbg !606 {
entry.split:
  %indvars.iv.i33.reg2mem = alloca i64, align 8
  %indvars.iv.i21.reg2mem = alloca i64, align 8
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !608, !DIExpression(), !611)
    #dbg_value(ptr %vdata, !609, !DIExpression(), !611)
    #dbg_value(ptr %vdata, !610, !DIExpression(), !611)
    #dbg_value(i32 %fd, !612, !DIExpression(), !617)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !619
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !619

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !619
  unreachable, !dbg !619

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !622
    #dbg_value(i32 %fd, !623, !DIExpression(), !632)
    #dbg_value(ptr %vdata, !629, !DIExpression(), !632)
    #dbg_value(i32 140, !630, !DIExpression(), !632)
    #dbg_value(i32 0, !631, !DIExpression(), !632)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !634

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !631, !DIExpression(), !632)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i8, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !636
  %0 = load i8, ptr %arrayidx.i, align 1, !dbg !636, !tbaa !380
  %conv.i = zext i8 %0 to i32, !dbg !636
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv.i), !dbg !636
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !639
    #dbg_value(i64 %indvars.iv.next.i, !631, !DIExpression(), !632)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 140, !dbg !639
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !634, !llvm.loop !640

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !634

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !612, !DIExpression(), !641)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !643
  %init = getelementptr inbounds i8, ptr %vdata, i64 144, !dbg !644
    #dbg_value(i32 %fd, !645, !DIExpression(), !654)
    #dbg_value(ptr %init, !651, !DIExpression(), !654)
    #dbg_value(i32 64, !652, !DIExpression(), !654)
    #dbg_value(i32 0, !653, !DIExpression(), !654)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !656

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !653, !DIExpression(), !654)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds double, ptr %init, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !658
  %1 = load double, ptr %arrayidx.i11, align 8, !dbg !658, !tbaa !389
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %1), !dbg !658
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !661
    #dbg_value(i64 %indvars.iv.next.i12, !653, !DIExpression(), !654)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 64, !dbg !661
  br i1 %exitcond.not.i13, label %for.cond.preheader.i19, label %for.body.i9.for.body.i9_crit_edge, !dbg !656, !llvm.loop !662

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !656

for.cond.preheader.i19:                           ; preds = %for.body.i9
    #dbg_value(i32 %fd, !612, !DIExpression(), !663)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !665
  %transition = getelementptr inbounds i8, ptr %vdata, i64 656, !dbg !666
    #dbg_value(i32 %fd, !645, !DIExpression(), !667)
    #dbg_value(ptr %transition, !651, !DIExpression(), !667)
    #dbg_value(i32 4096, !652, !DIExpression(), !667)
    #dbg_value(i32 0, !653, !DIExpression(), !667)
  store i64 0, ptr %indvars.iv.i21.reg2mem, align 8
  br label %for.body.i20, !dbg !669

for.body.i20:                                     ; preds = %for.body.i20.for.body.i20_crit_edge, %for.cond.preheader.i19
    #dbg_value(i64 %indvars.iv.i21.reg2mem.0.load, !653, !DIExpression(), !667)
  %indvars.iv.i21.reg2mem.0.load = load i64, ptr %indvars.iv.i21.reg2mem, align 8
  %arrayidx.i22 = getelementptr inbounds double, ptr %transition, i64 %indvars.iv.i21.reg2mem.0.load, !dbg !670
  %2 = load double, ptr %arrayidx.i22, align 8, !dbg !670, !tbaa !389
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %2), !dbg !670
  %indvars.iv.next.i23 = add nuw nsw i64 %indvars.iv.i21.reg2mem.0.load, 1, !dbg !671
    #dbg_value(i64 %indvars.iv.next.i23, !653, !DIExpression(), !667)
  %exitcond.not.i24 = icmp eq i64 %indvars.iv.next.i23, 4096, !dbg !671
  br i1 %exitcond.not.i24, label %for.cond.preheader.i31, label %for.body.i20.for.body.i20_crit_edge, !dbg !669, !llvm.loop !672

for.body.i20.for.body.i20_crit_edge:              ; preds = %for.body.i20
  store i64 %indvars.iv.next.i23, ptr %indvars.iv.i21.reg2mem, align 8
  br label %for.body.i20, !dbg !669

for.cond.preheader.i31:                           ; preds = %for.body.i20
    #dbg_value(i32 %fd, !612, !DIExpression(), !673)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !675
  %emission = getelementptr inbounds i8, ptr %vdata, i64 33424, !dbg !676
    #dbg_value(i32 %fd, !645, !DIExpression(), !677)
    #dbg_value(ptr %emission, !651, !DIExpression(), !677)
    #dbg_value(i32 4096, !652, !DIExpression(), !677)
    #dbg_value(i32 0, !653, !DIExpression(), !677)
  store i64 0, ptr %indvars.iv.i33.reg2mem, align 8
  br label %for.body.i32, !dbg !679

for.body.i32:                                     ; preds = %for.body.i32.for.body.i32_crit_edge, %for.cond.preheader.i31
    #dbg_value(i64 %indvars.iv.i33.reg2mem.0.load, !653, !DIExpression(), !677)
  %indvars.iv.i33.reg2mem.0.load = load i64, ptr %indvars.iv.i33.reg2mem, align 8
  %arrayidx.i34 = getelementptr inbounds double, ptr %emission, i64 %indvars.iv.i33.reg2mem.0.load, !dbg !680
  %3 = load double, ptr %arrayidx.i34, align 8, !dbg !680, !tbaa !389
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %3), !dbg !680
  %indvars.iv.next.i35 = add nuw nsw i64 %indvars.iv.i33.reg2mem.0.load, 1, !dbg !681
    #dbg_value(i64 %indvars.iv.next.i35, !653, !DIExpression(), !677)
  %exitcond.not.i36 = icmp eq i64 %indvars.iv.next.i35, 4096, !dbg !681
  br i1 %exitcond.not.i36, label %write_double_array.exit37, label %for.body.i32.for.body.i32_crit_edge, !dbg !679, !llvm.loop !682

for.body.i32.for.body.i32_crit_edge:              ; preds = %for.body.i32
  store i64 %indvars.iv.next.i35, ptr %indvars.iv.i33.reg2mem, align 8
  br label %for.body.i32, !dbg !679

write_double_array.exit37:                        ; preds = %for.body.i32
  ret void, !dbg !683
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #3 !dbg !684 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !686, !DIExpression(), !691)
    #dbg_value(ptr %vdata, !687, !DIExpression(), !691)
    #dbg_value(ptr %vdata, !688, !DIExpression(), !691)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(66336) %vdata, i8 0, i64 66336, i1 false), !dbg !692
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !693
    #dbg_value(ptr %call, !689, !DIExpression(), !691)
    #dbg_value(ptr %call, !513, !DIExpression(), !694)
    #dbg_value(i32 1, !518, !DIExpression(), !694)
    #dbg_value(i32 0, !519, !DIExpression(), !694)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !519, !DIExpression(), !694)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !513, !DIExpression(), !694)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !696, !tbaa !380
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !697

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !697

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !697

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !698
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !698, !tbaa !380
  %cmp13.i = icmp eq i8 %1, 37, !dbg !699
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !700

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !700

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !701
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !701, !tbaa !380
  %cmp18.i = icmp eq i8 %2, 10, !dbg !702
  %inc.i = zext i1 %cmp18.i to i32, !dbg !703
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !703
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !703

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !519, !DIExpression(), !694)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !704
    #dbg_value(ptr %incdec.ptr.i, !513, !DIExpression(), !694)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !705
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !706, !llvm.loop !707

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !706

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !709, !tbaa !380
  %3 = icmp eq i8 %.pre.i, 0, !dbg !710
  %4 = select i1 %3, i64 0, i64 2, !dbg !711
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !706

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !711
    #dbg_value(ptr %spec.select38.i, !690, !DIExpression(), !691)
  %path = getelementptr inbounds i8, ptr %vdata, i64 66192, !dbg !712
  %call2 = tail call signext i32 @parse_uint8_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %path, i32 noundef signext 140) #18, !dbg !713
  tail call void @free(ptr noundef %call) #18, !dbg !714
  ret void, !dbg !715
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #3 !dbg !716 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !718, !DIExpression(), !721)
    #dbg_value(ptr %vdata, !719, !DIExpression(), !721)
    #dbg_value(ptr %vdata, !720, !DIExpression(), !721)
    #dbg_value(i32 %fd, !612, !DIExpression(), !722)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !724
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !724

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !724
  unreachable, !dbg !724

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !725
  %path = getelementptr inbounds i8, ptr %vdata, i64 66192, !dbg !726
    #dbg_value(i32 %fd, !623, !DIExpression(), !727)
    #dbg_value(ptr %path, !629, !DIExpression(), !727)
    #dbg_value(i32 140, !630, !DIExpression(), !727)
    #dbg_value(i32 0, !631, !DIExpression(), !727)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !729

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !631, !DIExpression(), !727)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i8, ptr %path, i64 %indvars.iv.i.reg2mem.0.load, !dbg !730
  %0 = load i8, ptr %arrayidx.i, align 1, !dbg !730, !tbaa !380
  %conv.i = zext i8 %0 to i32, !dbg !730
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv.i), !dbg !730
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !731
    #dbg_value(i64 %indvars.iv.next.i, !631, !DIExpression(), !727)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 140, !dbg !731
  br i1 %exitcond.not.i, label %write_uint8_t_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !729, !llvm.loop !732

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !729

write_uint8_t_array.exit:                         ; preds = %for.body.i
  ret void, !dbg !733
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #6 !dbg !734 {
entry.split:
  %has_errors.011.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(ptr %vdata, !738, !DIExpression(), !744)
    #dbg_value(ptr %vref, !739, !DIExpression(), !744)
    #dbg_value(ptr %vdata, !740, !DIExpression(), !744)
    #dbg_value(ptr %vref, !741, !DIExpression(), !744)
    #dbg_value(i32 0, !742, !DIExpression(), !744)
    #dbg_value(i32 0, !743, !DIExpression(), !744)
  store i32 0, ptr %has_errors.011.reg2mem, align 4
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !745

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !743, !DIExpression(), !744)
    #dbg_value(i32 %has_errors.011.reg2mem.0.load, !742, !DIExpression(), !744)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %has_errors.011.reg2mem.0.load = load i32, ptr %has_errors.011.reg2mem, align 4
  %arrayidx = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 4, i64 %indvars.iv.reg2mem.0.load, !dbg !747
  %0 = load i8, ptr %arrayidx, align 1, !dbg !747, !tbaa !380
  %arrayidx3 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 4, i64 %indvars.iv.reg2mem.0.load, !dbg !750
  %1 = load i8, ptr %arrayidx3, align 1, !dbg !750, !tbaa !380
  %cmp5 = icmp ne i8 %0, %1, !dbg !751
  %conv6 = zext i1 %cmp5 to i32, !dbg !751
  %or = or i32 %has_errors.011.reg2mem.0.load, %conv6, !dbg !752
    #dbg_value(i32 %or, !742, !DIExpression(), !744)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !753
    #dbg_value(i64 %indvars.iv.next, !743, !DIExpression(), !744)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 140, !dbg !754
  br i1 %exitcond.not, label %for.end, label %for.body.for.body_crit_edge, !dbg !745, !llvm.loop !755

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i32 %or, ptr %has_errors.011.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !745

for.end:                                          ; preds = %for.body
  %tobool.not = icmp eq i32 %or, 0, !dbg !757
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !757
  ret i32 %lnot.ext, !dbg !758
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #3 !dbg !759 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !809
    #dbg_assign(i1 undef, !765, !DIExpression(), !809, ptr %s, !DIExpression(), !810)
    #dbg_value(i32 %fd, !763, !DIExpression(), !810)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #18, !dbg !811
  %cmp = icmp sgt i32 %fd, 1, !dbg !812
  br i1 %cmp, label %if.end, label %if.else, !dbg !812

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !812
  unreachable, !dbg !812

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #18, !dbg !815
  %cmp1 = icmp eq i32 %call, 0, !dbg !815
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !815

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !815
  unreachable, !dbg !815

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !818
  %0 = load i64, ptr %st_size, align 8, !dbg !818
    #dbg_value(i64 %0, !802, !DIExpression(), !810)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !819
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !819

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !819
  unreachable, !dbg !819

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !822
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #20, !dbg !823
    #dbg_value(ptr %call11, !764, !DIExpression(), !810)
    #dbg_value(i64 0, !805, !DIExpression(), !810)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !824

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !825
    #dbg_value(i64 %add19, !805, !DIExpression(), !810)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !827
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !824, !llvm.loop !828

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !824

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !805, !DIExpression(), !810)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !830
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !831
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #18, !dbg !832
    #dbg_value(i64 %call13, !808, !DIExpression(), !810)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !833
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !805, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !810)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !833

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !833
  unreachable, !dbg !833

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !836
  store i8 0, ptr %arrayidx20, align 1, !dbg !837, !tbaa !380
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #18, !dbg !838
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #18, !dbg !839
  ret ptr %call11, !dbg !840
}

; Function Attrs: noreturn nounwind
declare !dbg !841 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare !dbg !846 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !851 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #9

; Function Attrs: nofree
declare !dbg !856 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #10

declare !dbg !860 signext i32 @close(i32 noundef signext) local_unnamed_addr #11

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #3 !dbg !514 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !513, !DIExpression(), !861)
    #dbg_value(i32 %n, !518, !DIExpression(), !861)
    #dbg_value(i32 0, !519, !DIExpression(), !861)
  %cmp = icmp sgt i32 %n, -1, !dbg !862
  br i1 %cmp, label %if.end, label %if.else, !dbg !862

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #19, !dbg !862
  unreachable, !dbg !862

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !865
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !867

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !867

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !867

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !519, !DIExpression(), !861)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !513, !DIExpression(), !861)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !868, !tbaa !380
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !869

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !869

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !869

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !870
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !870, !tbaa !380
  %cmp13 = icmp eq i8 %1, 37, !dbg !871
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !872

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !872

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !873
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !873, !tbaa !380
  %cmp18 = icmp eq i8 %2, 10, !dbg !874
  %inc = zext i1 %cmp18 to i32, !dbg !875
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !875
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !875

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !519, !DIExpression(), !861)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !876
    #dbg_value(ptr %incdec.ptr, !513, !DIExpression(), !861)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !877
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !878, !llvm.loop !879

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !878

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !881, !tbaa !380
  %3 = icmp eq i8 %.pre, 0, !dbg !882
  %4 = select i1 %3, i64 0, i64 2, !dbg !883
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !878

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !883
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !883

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !884
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !885 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !889, !DIExpression(), !893)
    #dbg_value(ptr %arr, !890, !DIExpression(), !893)
    #dbg_value(i32 %n, !891, !DIExpression(), !893)
  %cmp.not = icmp eq ptr %s, null, !dbg !894
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !894

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #19, !dbg !894
  unreachable, !dbg !894

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !897
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !899

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !900
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !902
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !902

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !892, !DIExpression(), !893)
  %conv404 = zext nneg i32 %n to i64, !dbg !903
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !904
  br label %if.end46, !dbg !905

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !892, !DIExpression(), !893)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !906
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !907

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !907

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !908
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !909
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !909
  %cmp9.not = icmp eq i8 %0, 0, !dbg !910
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !911

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !911

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !912
  %1 = load i8, ptr %gep, align 1, !dbg !912
  %cmp16.not = icmp eq i8 %1, 0, !dbg !913
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !914

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !914

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !915
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !916
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !916
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !916, !llvm.loop !917

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !916

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !903

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !903

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !903

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !903
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !892, !DIExpression(), !893)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !904
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !919
  store i8 0, ptr %arrayidx45, align 1, !dbg !921, !tbaa !380
  br label %if.end46, !dbg !919

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !922
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !923 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !934
    #dbg_assign(i1 undef, !931, !DIExpression(), !934, ptr %endptr, !DIExpression(), !935)
    #dbg_value(ptr %s, !927, !DIExpression(), !935)
    #dbg_value(ptr %arr, !928, !DIExpression(), !935)
    #dbg_value(i32 %n, !929, !DIExpression(), !935)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !936
    #dbg_value(i32 0, !932, !DIExpression(), !935)
  %cmp.not = icmp eq ptr %s, null, !dbg !937
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !937

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #19, !dbg !937
  unreachable, !dbg !937

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !936
    #dbg_value(ptr %call, !930, !DIExpression(), !935)
    #dbg_value(i32 0, !932, !DIExpression(), !935)
  %cmp130 = icmp ne ptr %call, null, !dbg !936
  %cmp231 = icmp sgt i32 %n, 0, !dbg !936
  %0 = and i1 %cmp231, %cmp130, !dbg !936
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !936

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !936

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !936
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !936

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !930, !DIExpression(), !935)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !932, !DIExpression(), !935)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !940, !tbaa !942, !DIAssignID !944
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !931, !DIExpression(), !944, ptr %endptr, !DIExpression(), !935)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !940
  %conv = trunc i64 %call3 to i8, !dbg !940
    #dbg_value(i8 %conv, !933, !DIExpression(), !935)
  %2 = load ptr, ptr %endptr, align 8, !dbg !945, !tbaa !942
  %3 = load i8, ptr %2, align 1, !dbg !945, !tbaa !380
  %cmp5.not = icmp eq i8 %3, 0, !dbg !945
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !940

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !940

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !947, !tbaa !942
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !947
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !947
  br label %if.end9, !dbg !947

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !940
  store i8 %conv, ptr %arrayidx, align 1, !dbg !940, !tbaa !380
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !940
    #dbg_value(i64 %indvars.iv.next, !932, !DIExpression(), !935)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !940
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !940
  store i8 10, ptr %arrayidx11, align 1, !dbg !940, !tbaa !380
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !940
    #dbg_value(ptr %call12, !930, !DIExpression(), !935)
  %cmp1 = icmp ne ptr %call12, null, !dbg !936
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !936
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !936
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !936, !llvm.loop !949

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !936

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !936

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !936

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !936

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !950
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !950
  store i8 10, ptr %arrayidx17, align 1, !dbg !950, !tbaa !380
  br label %if.end18, !dbg !950

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !936
  ret i32 0, !dbg !936
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !953 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #13

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !959 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #13

; Function Attrs: nofree nounwind
declare !dbg !964 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !1019 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #14

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1022 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1034
    #dbg_assign(i1 undef, !1031, !DIExpression(), !1034, ptr %endptr, !DIExpression(), !1035)
    #dbg_value(ptr %s, !1027, !DIExpression(), !1035)
    #dbg_value(ptr %arr, !1028, !DIExpression(), !1035)
    #dbg_value(i32 %n, !1029, !DIExpression(), !1035)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1036
    #dbg_value(i32 0, !1032, !DIExpression(), !1035)
  %cmp.not = icmp eq ptr %s, null, !dbg !1037
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1037

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #19, !dbg !1037
  unreachable, !dbg !1037

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1036
    #dbg_value(ptr %call, !1030, !DIExpression(), !1035)
    #dbg_value(i32 0, !1032, !DIExpression(), !1035)
  %cmp130 = icmp ne ptr %call, null, !dbg !1036
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1036
  %0 = and i1 %cmp231, %cmp130, !dbg !1036
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1036

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1036

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1036
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1036

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1030, !DIExpression(), !1035)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1032, !DIExpression(), !1035)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1040, !tbaa !942, !DIAssignID !1042
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1031, !DIExpression(), !1042, ptr %endptr, !DIExpression(), !1035)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1040
  %conv = trunc i64 %call3 to i16, !dbg !1040
    #dbg_value(i16 %conv, !1033, !DIExpression(), !1035)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1043, !tbaa !942
  %3 = load i8, ptr %2, align 1, !dbg !1043, !tbaa !380
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1043
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1040

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1040

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1045, !tbaa !942
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1045
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1045
  br label %if.end9, !dbg !1045

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1040
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1040, !tbaa !1047
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1040
    #dbg_value(i64 %indvars.iv.next, !1032, !DIExpression(), !1035)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1040
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1040
  store i8 10, ptr %arrayidx11, align 1, !dbg !1040, !tbaa !380
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1040
    #dbg_value(ptr %call12, !1030, !DIExpression(), !1035)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1036
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1036
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1036
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1036, !llvm.loop !1049

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1036

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1036

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1036

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1036

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1050
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1050
  store i8 10, ptr %arrayidx17, align 1, !dbg !1050, !tbaa !380
  br label %if.end18, !dbg !1050

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1036
  ret i32 0, !dbg !1036
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1053 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1065
    #dbg_assign(i1 undef, !1062, !DIExpression(), !1065, ptr %endptr, !DIExpression(), !1066)
    #dbg_value(ptr %s, !1058, !DIExpression(), !1066)
    #dbg_value(ptr %arr, !1059, !DIExpression(), !1066)
    #dbg_value(i32 %n, !1060, !DIExpression(), !1066)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1067
    #dbg_value(i32 0, !1063, !DIExpression(), !1066)
  %cmp.not = icmp eq ptr %s, null, !dbg !1068
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1068

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #19, !dbg !1068
  unreachable, !dbg !1068

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1067
    #dbg_value(ptr %call, !1061, !DIExpression(), !1066)
    #dbg_value(i32 0, !1063, !DIExpression(), !1066)
  %cmp130 = icmp ne ptr %call, null, !dbg !1067
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1067
  %0 = and i1 %cmp231, %cmp130, !dbg !1067
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1067

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1067

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1067
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1067

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1061, !DIExpression(), !1066)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1063, !DIExpression(), !1066)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1071, !tbaa !942, !DIAssignID !1073
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1062, !DIExpression(), !1073, ptr %endptr, !DIExpression(), !1066)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1071
  %conv = trunc i64 %call3 to i32, !dbg !1071
    #dbg_value(i32 %conv, !1064, !DIExpression(), !1066)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1074, !tbaa !942
  %3 = load i8, ptr %2, align 1, !dbg !1074, !tbaa !380
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1074
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1071

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1071

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1076, !tbaa !942
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1076
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1076
  br label %if.end9, !dbg !1076

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1071
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1071, !tbaa !1078
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1071
    #dbg_value(i64 %indvars.iv.next, !1063, !DIExpression(), !1066)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1071
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1071
  store i8 10, ptr %arrayidx11, align 1, !dbg !1071, !tbaa !380
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1071
    #dbg_value(ptr %call12, !1061, !DIExpression(), !1066)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1067
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1067
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1067
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1067, !llvm.loop !1080

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1067

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1067

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1067

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1067

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1081
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1081
  store i8 10, ptr %arrayidx17, align 1, !dbg !1081, !tbaa !380
  br label %if.end18, !dbg !1081

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1067
  ret i32 0, !dbg !1067
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1084 {
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
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1098
    #dbg_value(i32 0, !1094, !DIExpression(), !1097)
  %cmp.not = icmp eq ptr %s, null, !dbg !1099
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1099

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #19, !dbg !1099
  unreachable, !dbg !1099

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1098
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
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1102, !tbaa !942, !DIAssignID !1104
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1093, !DIExpression(), !1104, ptr %endptr, !DIExpression(), !1097)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1102
    #dbg_value(i64 %call3, !1095, !DIExpression(), !1097)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1105, !tbaa !942
  %3 = load i8, ptr %2, align 1, !dbg !1105, !tbaa !380
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1105
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1102

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1102

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1107, !tbaa !942
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1107
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1107
  br label %if.end8, !dbg !1107

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1102
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1102, !tbaa !1109
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1102
    #dbg_value(i64 %indvars.iv.next, !1094, !DIExpression(), !1097)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1102
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1102
  store i8 10, ptr %arrayidx10, align 1, !dbg !1102, !tbaa !380
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1102
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
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1112
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1112
  store i8 10, ptr %arrayidx16, align 1, !dbg !1112, !tbaa !380
  br label %if.end17, !dbg !1112

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1098
  ret i32 0, !dbg !1098
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1115 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1127
    #dbg_assign(i1 undef, !1124, !DIExpression(), !1127, ptr %endptr, !DIExpression(), !1128)
    #dbg_value(ptr %s, !1120, !DIExpression(), !1128)
    #dbg_value(ptr %arr, !1121, !DIExpression(), !1128)
    #dbg_value(i32 %n, !1122, !DIExpression(), !1128)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1129
    #dbg_value(i32 0, !1125, !DIExpression(), !1128)
  %cmp.not = icmp eq ptr %s, null, !dbg !1130
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1130

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #19, !dbg !1130
  unreachable, !dbg !1130

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1129
    #dbg_value(ptr %call, !1123, !DIExpression(), !1128)
    #dbg_value(i32 0, !1125, !DIExpression(), !1128)
  %cmp130 = icmp ne ptr %call, null, !dbg !1129
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1129
  %0 = and i1 %cmp231, %cmp130, !dbg !1129
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1129

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1129

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1129
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1129

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1123, !DIExpression(), !1128)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1125, !DIExpression(), !1128)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1133, !tbaa !942, !DIAssignID !1135
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1124, !DIExpression(), !1135, ptr %endptr, !DIExpression(), !1128)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1133
  %conv = trunc i64 %call3 to i8, !dbg !1133
    #dbg_value(i8 %conv, !1126, !DIExpression(), !1128)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1136, !tbaa !942
  %3 = load i8, ptr %2, align 1, !dbg !1136, !tbaa !380
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1136
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1133

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1133

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1138, !tbaa !942
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1138
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1138
  br label %if.end9, !dbg !1138

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1133
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1133, !tbaa !380
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1133
    #dbg_value(i64 %indvars.iv.next, !1125, !DIExpression(), !1128)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1133
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1133
  store i8 10, ptr %arrayidx11, align 1, !dbg !1133, !tbaa !380
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1133
    #dbg_value(ptr %call12, !1123, !DIExpression(), !1128)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1129
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1129
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1129
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1129, !llvm.loop !1140

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1129

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1129

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1129

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1129

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1141
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1141
  store i8 10, ptr %arrayidx17, align 1, !dbg !1141, !tbaa !380
  br label %if.end18, !dbg !1141

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1129
  ret i32 0, !dbg !1129
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1144 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1156
    #dbg_assign(i1 undef, !1153, !DIExpression(), !1156, ptr %endptr, !DIExpression(), !1157)
    #dbg_value(ptr %s, !1149, !DIExpression(), !1157)
    #dbg_value(ptr %arr, !1150, !DIExpression(), !1157)
    #dbg_value(i32 %n, !1151, !DIExpression(), !1157)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1158
    #dbg_value(i32 0, !1154, !DIExpression(), !1157)
  %cmp.not = icmp eq ptr %s, null, !dbg !1159
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1159

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #19, !dbg !1159
  unreachable, !dbg !1159

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1158
    #dbg_value(ptr %call, !1152, !DIExpression(), !1157)
    #dbg_value(i32 0, !1154, !DIExpression(), !1157)
  %cmp130 = icmp ne ptr %call, null, !dbg !1158
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1158
  %0 = and i1 %cmp231, %cmp130, !dbg !1158
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1158

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1158

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1158
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1158

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1152, !DIExpression(), !1157)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1154, !DIExpression(), !1157)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1162, !tbaa !942, !DIAssignID !1164
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1153, !DIExpression(), !1164, ptr %endptr, !DIExpression(), !1157)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1162
  %conv = trunc i64 %call3 to i16, !dbg !1162
    #dbg_value(i16 %conv, !1155, !DIExpression(), !1157)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1165, !tbaa !942
  %3 = load i8, ptr %2, align 1, !dbg !1165, !tbaa !380
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1165
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1162

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1162

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1167, !tbaa !942
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1167
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1167
  br label %if.end9, !dbg !1167

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1162
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1162, !tbaa !1047
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1162
    #dbg_value(i64 %indvars.iv.next, !1154, !DIExpression(), !1157)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1162
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1162
  store i8 10, ptr %arrayidx11, align 1, !dbg !1162, !tbaa !380
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1162
    #dbg_value(ptr %call12, !1152, !DIExpression(), !1157)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1158
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1158
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1158
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1158, !llvm.loop !1169

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1158

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1158

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1158

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1158

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1170
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1170
  store i8 10, ptr %arrayidx17, align 1, !dbg !1170, !tbaa !380
  br label %if.end18, !dbg !1170

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1158
  ret i32 0, !dbg !1158
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1173 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1185
    #dbg_assign(i1 undef, !1182, !DIExpression(), !1185, ptr %endptr, !DIExpression(), !1186)
    #dbg_value(ptr %s, !1178, !DIExpression(), !1186)
    #dbg_value(ptr %arr, !1179, !DIExpression(), !1186)
    #dbg_value(i32 %n, !1180, !DIExpression(), !1186)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1187
    #dbg_value(i32 0, !1183, !DIExpression(), !1186)
  %cmp.not = icmp eq ptr %s, null, !dbg !1188
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1188

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #19, !dbg !1188
  unreachable, !dbg !1188

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1187
    #dbg_value(ptr %call, !1181, !DIExpression(), !1186)
    #dbg_value(i32 0, !1183, !DIExpression(), !1186)
  %cmp130 = icmp ne ptr %call, null, !dbg !1187
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1187
  %0 = and i1 %cmp231, %cmp130, !dbg !1187
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1187

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1187

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1187
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1187

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1181, !DIExpression(), !1186)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1183, !DIExpression(), !1186)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1191, !tbaa !942, !DIAssignID !1193
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1182, !DIExpression(), !1193, ptr %endptr, !DIExpression(), !1186)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1191
  %conv = trunc i64 %call3 to i32, !dbg !1191
    #dbg_value(i32 %conv, !1184, !DIExpression(), !1186)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1194, !tbaa !942
  %3 = load i8, ptr %2, align 1, !dbg !1194, !tbaa !380
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1194
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1191

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1191

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1196, !tbaa !942
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1196
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1196
  br label %if.end9, !dbg !1196

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1191
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1191, !tbaa !1078
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1191
    #dbg_value(i64 %indvars.iv.next, !1183, !DIExpression(), !1186)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1191
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1191
  store i8 10, ptr %arrayidx11, align 1, !dbg !1191, !tbaa !380
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1191
    #dbg_value(ptr %call12, !1181, !DIExpression(), !1186)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1187
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1187
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1187
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1187, !llvm.loop !1198

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1187

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1187

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1187

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1187

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1199
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1199
  store i8 10, ptr %arrayidx17, align 1, !dbg !1199, !tbaa !380
  br label %if.end18, !dbg !1199

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1187
  ret i32 0, !dbg !1187
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1202 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1214
    #dbg_assign(i1 undef, !1211, !DIExpression(), !1214, ptr %endptr, !DIExpression(), !1215)
    #dbg_value(ptr %s, !1207, !DIExpression(), !1215)
    #dbg_value(ptr %arr, !1208, !DIExpression(), !1215)
    #dbg_value(i32 %n, !1209, !DIExpression(), !1215)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1216
    #dbg_value(i32 0, !1212, !DIExpression(), !1215)
  %cmp.not = icmp eq ptr %s, null, !dbg !1217
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1217

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #19, !dbg !1217
  unreachable, !dbg !1217

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1216
    #dbg_value(ptr %call, !1210, !DIExpression(), !1215)
    #dbg_value(i32 0, !1212, !DIExpression(), !1215)
  %cmp129 = icmp ne ptr %call, null, !dbg !1216
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1216
  %0 = and i1 %cmp230, %cmp129, !dbg !1216
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1216

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1216

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1216
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1216

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1210, !DIExpression(), !1215)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1212, !DIExpression(), !1215)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1220, !tbaa !942, !DIAssignID !1222
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1211, !DIExpression(), !1222, ptr %endptr, !DIExpression(), !1215)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1220
    #dbg_value(i64 %call3, !1213, !DIExpression(), !1215)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1223, !tbaa !942
  %3 = load i8, ptr %2, align 1, !dbg !1223, !tbaa !380
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1223
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1220

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1220

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1225, !tbaa !942
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1225
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1225
  br label %if.end8, !dbg !1225

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1220
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1220, !tbaa !1109
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1220
    #dbg_value(i64 %indvars.iv.next, !1212, !DIExpression(), !1215)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1220
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1220
  store i8 10, ptr %arrayidx10, align 1, !dbg !1220, !tbaa !380
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1220
    #dbg_value(ptr %call11, !1210, !DIExpression(), !1215)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1216
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1216
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1216
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1216, !llvm.loop !1227

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1216

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1216

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1216

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1216

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1228
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1228
  store i8 10, ptr %arrayidx16, align 1, !dbg !1228, !tbaa !380
  br label %if.end17, !dbg !1228

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1216
  ret i32 0, !dbg !1216
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1231 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1243
    #dbg_assign(i1 undef, !1240, !DIExpression(), !1243, ptr %endptr, !DIExpression(), !1244)
    #dbg_value(ptr %s, !1236, !DIExpression(), !1244)
    #dbg_value(ptr %arr, !1237, !DIExpression(), !1244)
    #dbg_value(i32 %n, !1238, !DIExpression(), !1244)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1245
    #dbg_value(i32 0, !1241, !DIExpression(), !1244)
  %cmp.not = icmp eq ptr %s, null, !dbg !1246
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1246

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #19, !dbg !1246
  unreachable, !dbg !1246

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1245
    #dbg_value(ptr %call, !1239, !DIExpression(), !1244)
    #dbg_value(i32 0, !1241, !DIExpression(), !1244)
  %cmp129 = icmp ne ptr %call, null, !dbg !1245
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1245
  %0 = and i1 %cmp230, %cmp129, !dbg !1245
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1245

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1245

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1245
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1245

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1239, !DIExpression(), !1244)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1241, !DIExpression(), !1244)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1249, !tbaa !942, !DIAssignID !1251
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1240, !DIExpression(), !1251, ptr %endptr, !DIExpression(), !1244)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1249
    #dbg_value(float %call3, !1242, !DIExpression(), !1244)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1252, !tbaa !942
  %3 = load i8, ptr %2, align 1, !dbg !1252, !tbaa !380
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1252
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1249

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1249

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1254, !tbaa !942
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1254
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1254
  br label %if.end8, !dbg !1254

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1249
  store float %call3, ptr %arrayidx, align 4, !dbg !1249, !tbaa !1256
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1249
    #dbg_value(i64 %indvars.iv.next, !1241, !DIExpression(), !1244)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1249
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1249
  store i8 10, ptr %arrayidx10, align 1, !dbg !1249, !tbaa !380
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1249
    #dbg_value(ptr %call11, !1239, !DIExpression(), !1244)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1245
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1245
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1245
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1245, !llvm.loop !1258

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1245

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1245

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1245

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1245

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1259
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1259
  store i8 10, ptr %arrayidx16, align 1, !dbg !1259, !tbaa !380
  br label %if.end17, !dbg !1259

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1245
  ret i32 0, !dbg !1245
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1262 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1265 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1276
    #dbg_assign(i1 undef, !1273, !DIExpression(), !1276, ptr %endptr, !DIExpression(), !1277)
    #dbg_value(ptr %s, !1269, !DIExpression(), !1277)
    #dbg_value(ptr %arr, !1270, !DIExpression(), !1277)
    #dbg_value(i32 %n, !1271, !DIExpression(), !1277)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1278
    #dbg_value(i32 0, !1274, !DIExpression(), !1277)
  %cmp.not = icmp eq ptr %s, null, !dbg !1279
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1279

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #19, !dbg !1279
  unreachable, !dbg !1279

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1278
    #dbg_value(ptr %call, !1272, !DIExpression(), !1277)
    #dbg_value(i32 0, !1274, !DIExpression(), !1277)
  %cmp129 = icmp ne ptr %call, null, !dbg !1278
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1278
  %0 = and i1 %cmp230, %cmp129, !dbg !1278
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1278

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1278

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1278
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1278

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1272, !DIExpression(), !1277)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1274, !DIExpression(), !1277)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1282, !tbaa !942, !DIAssignID !1284
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1273, !DIExpression(), !1284, ptr %endptr, !DIExpression(), !1277)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1282
    #dbg_value(double %call3, !1275, !DIExpression(), !1277)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1285, !tbaa !942
  %3 = load i8, ptr %2, align 1, !dbg !1285, !tbaa !380
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1285
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1282

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1282

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1287, !tbaa !942
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1287
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1287
  br label %if.end8, !dbg !1287

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1282
  store double %call3, ptr %arrayidx, align 8, !dbg !1282, !tbaa !389
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1282
    #dbg_value(i64 %indvars.iv.next, !1274, !DIExpression(), !1277)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1282
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1282
  store i8 10, ptr %arrayidx10, align 1, !dbg !1282, !tbaa !380
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1282
    #dbg_value(ptr %call11, !1272, !DIExpression(), !1277)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1278
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1278
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1278
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1278, !llvm.loop !1289

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1278

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1278

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1278

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1278

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1290
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1290
  store i8 10, ptr %arrayidx16, align 1, !dbg !1290, !tbaa !380
  br label %if.end17, !dbg !1290

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1278
  ret i32 0, !dbg !1278
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1293 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1296 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1300, !DIExpression(), !1305)
    #dbg_value(ptr %arr, !1301, !DIExpression(), !1305)
    #dbg_value(i32 %n, !1302, !DIExpression(), !1305)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1306
  br i1 %cmp, label %if.end, label %if.else, !dbg !1306

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1306
  unreachable, !dbg !1306

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1309
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1311

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1311

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #22, !dbg !1312
  %conv = trunc i64 %call to i32, !dbg !1312
    #dbg_value(i32 %conv, !1302, !DIExpression(), !1305)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1314

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1302, !DIExpression(), !1305)
    #dbg_value(i32 0, !1304, !DIExpression(), !1305)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1315
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1316

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1316

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1316

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1317

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1318
    #dbg_value(i32 %add, !1304, !DIExpression(), !1305)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1315
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1316, !llvm.loop !1320

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1316

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1316

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1304, !DIExpression(), !1305)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1322
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1322
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1323
  %conv6 = sext i32 %sub to i64, !dbg !1324
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #18, !dbg !1325
  %conv8 = trunc i64 %call7 to i32, !dbg !1325
    #dbg_value(i32 %conv8, !1303, !DIExpression(), !1305)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1326
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1304, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1305)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1326

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1326
  unreachable, !dbg !1326

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #18, !dbg !1329
  %conv16 = trunc i64 %call15 to i32, !dbg !1329
    #dbg_value(i32 %conv16, !1303, !DIExpression(), !1305)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1331
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1331

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1331
  unreachable, !dbg !1331

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1334
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1335, !llvm.loop !1336

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1335

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1338
}

; Function Attrs: nofree
declare !dbg !1339 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #10

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !624 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !623, !DIExpression(), !1344)
    #dbg_value(ptr %arr, !629, !DIExpression(), !1344)
    #dbg_value(i32 %n, !630, !DIExpression(), !1344)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1345
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1345

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !631, !DIExpression(), !1344)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1348
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1349

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1349

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1348
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1349

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #19, !dbg !1345
  unreachable, !dbg !1345

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !631, !DIExpression(), !1344)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1350
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1350, !tbaa !380
  %conv = zext i8 %0 to i32, !dbg !1350
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1350
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1348
    #dbg_value(i64 %indvars.iv.next, !631, !DIExpression(), !1344)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1348
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1349, !llvm.loop !1351

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1349

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1349

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1352
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #15 !dbg !1353 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1370
    #dbg_assign(i1 undef, !1359, !DIExpression(), !1370, ptr %args, !DIExpression(), !1371)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1372
    #dbg_assign(i1 undef, !1366, !DIExpression(), !1372, ptr %buffer, !DIExpression(), !1371)
    #dbg_value(i32 %fd, !1357, !DIExpression(), !1371)
    #dbg_value(ptr %format, !1358, !DIExpression(), !1371)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #18, !dbg !1373
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1374
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1375
  %0 = load ptr, ptr %args, align 8, !dbg !1376, !tbaa !942
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #18, !dbg !1377
    #dbg_value(i32 %call, !1363, !DIExpression(), !1371)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1378
  %cmp = icmp slt i32 %call, 256, !dbg !1379
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1379

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1364, !DIExpression(), !1371)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1382
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1383

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1383

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1383

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1379
  unreachable, !dbg !1379

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1384
    #dbg_value(i32 %add, !1364, !DIExpression(), !1371)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1382
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1383, !llvm.loop !1386

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1383

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1383

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1364, !DIExpression(), !1371)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1388
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1388
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1389
  %conv = sext i32 %sub to i64, !dbg !1390
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #18, !dbg !1391
  %conv3 = trunc i64 %call2 to i32, !dbg !1391
    #dbg_value(i32 %conv3, !1365, !DIExpression(), !1371)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1392
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1364, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1371)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1392

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1392
  unreachable, !dbg !1392

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1395
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1395

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1395
  unreachable, !dbg !1395

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1398
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #18, !dbg !1398
  ret void, !dbg !1399
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #16

; Function Attrs: nofree nounwind
declare !dbg !1400 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #8

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #16

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1405 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1409, !DIExpression(), !1413)
    #dbg_value(ptr %arr, !1410, !DIExpression(), !1413)
    #dbg_value(i32 %n, !1411, !DIExpression(), !1413)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1414
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1414

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1412, !DIExpression(), !1413)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1417
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1420

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1420

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1417
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1420

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #19, !dbg !1414
  unreachable, !dbg !1414

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1412, !DIExpression(), !1413)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1421
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1421, !tbaa !1047
  %conv = zext i16 %0 to i32, !dbg !1421
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1421
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1417
    #dbg_value(i64 %indvars.iv.next, !1412, !DIExpression(), !1413)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1417
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1420, !llvm.loop !1423

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1420

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1420

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1424
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1425 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1429, !DIExpression(), !1433)
    #dbg_value(ptr %arr, !1430, !DIExpression(), !1433)
    #dbg_value(i32 %n, !1431, !DIExpression(), !1433)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1434
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1434

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1432, !DIExpression(), !1433)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1437
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1440

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1440

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1437
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1440

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #19, !dbg !1434
  unreachable, !dbg !1434

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1432, !DIExpression(), !1433)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1441
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1441, !tbaa !1078
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1441
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1437
    #dbg_value(i64 %indvars.iv.next, !1432, !DIExpression(), !1433)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1437
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1440, !llvm.loop !1443

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1440

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1440

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1444
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1445 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1449, !DIExpression(), !1453)
    #dbg_value(ptr %arr, !1450, !DIExpression(), !1453)
    #dbg_value(i32 %n, !1451, !DIExpression(), !1453)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1454
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1454

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1452, !DIExpression(), !1453)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1457
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1460

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1460

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1457
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1460

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #19, !dbg !1454
  unreachable, !dbg !1454

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1452, !DIExpression(), !1453)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1461
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1461, !tbaa !1109
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1461
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1457
    #dbg_value(i64 %indvars.iv.next, !1452, !DIExpression(), !1453)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1457
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1460, !llvm.loop !1463

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1460

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1460

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1464
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1465 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1469, !DIExpression(), !1473)
    #dbg_value(ptr %arr, !1470, !DIExpression(), !1473)
    #dbg_value(i32 %n, !1471, !DIExpression(), !1473)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1474
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1474

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1472, !DIExpression(), !1473)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1477
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1480

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1480

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1477
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1480

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #19, !dbg !1474
  unreachable, !dbg !1474

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1472, !DIExpression(), !1473)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1481
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1481, !tbaa !380
  %conv = sext i8 %0 to i32, !dbg !1481
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1481
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1477
    #dbg_value(i64 %indvars.iv.next, !1472, !DIExpression(), !1473)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1477
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1480, !llvm.loop !1483

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1480

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1480

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1484
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1485 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1489, !DIExpression(), !1493)
    #dbg_value(ptr %arr, !1490, !DIExpression(), !1493)
    #dbg_value(i32 %n, !1491, !DIExpression(), !1493)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1494
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1494

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1492, !DIExpression(), !1493)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1497
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1500

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1500

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1497
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1500

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #19, !dbg !1494
  unreachable, !dbg !1494

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1492, !DIExpression(), !1493)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1501
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1501, !tbaa !1047
  %conv = sext i16 %0 to i32, !dbg !1501
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1501
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1497
    #dbg_value(i64 %indvars.iv.next, !1492, !DIExpression(), !1493)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1497
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1500, !llvm.loop !1503

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1500

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1500

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1504
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1505 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1509, !DIExpression(), !1513)
    #dbg_value(ptr %arr, !1510, !DIExpression(), !1513)
    #dbg_value(i32 %n, !1511, !DIExpression(), !1513)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1514
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1514

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1512, !DIExpression(), !1513)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1517
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1520

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1520

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1517
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1520

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #19, !dbg !1514
  unreachable, !dbg !1514

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1512, !DIExpression(), !1513)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1521
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1521, !tbaa !1078
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1521
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1517
    #dbg_value(i64 %indvars.iv.next, !1512, !DIExpression(), !1513)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1517
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1520, !llvm.loop !1523

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1520

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1520

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1524
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1525 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1529, !DIExpression(), !1533)
    #dbg_value(ptr %arr, !1530, !DIExpression(), !1533)
    #dbg_value(i32 %n, !1531, !DIExpression(), !1533)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1534
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1534

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1532, !DIExpression(), !1533)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1537
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1540

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1540

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1537
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1540

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #19, !dbg !1534
  unreachable, !dbg !1534

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1532, !DIExpression(), !1533)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1541
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1541, !tbaa !1109
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1541
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1537
    #dbg_value(i64 %indvars.iv.next, !1532, !DIExpression(), !1533)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1537
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1540, !llvm.loop !1543

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1540

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1540

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1544
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1545 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1549, !DIExpression(), !1553)
    #dbg_value(ptr %arr, !1550, !DIExpression(), !1553)
    #dbg_value(i32 %n, !1551, !DIExpression(), !1553)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1554
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1554

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1552, !DIExpression(), !1553)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1557
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1560

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1560

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1557
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1560

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #19, !dbg !1554
  unreachable, !dbg !1554

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1552, !DIExpression(), !1553)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1561
  %0 = load float, ptr %arrayidx, align 4, !dbg !1561, !tbaa !1256
  %conv = fpext float %0 to double, !dbg !1561
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1561
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1557
    #dbg_value(i64 %indvars.iv.next, !1552, !DIExpression(), !1553)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1557
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1560, !llvm.loop !1563

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1560

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1560

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1564
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !646 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !645, !DIExpression(), !1565)
    #dbg_value(ptr %arr, !651, !DIExpression(), !1565)
    #dbg_value(i32 %n, !652, !DIExpression(), !1565)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1566
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1566

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !653, !DIExpression(), !1565)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1569
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1570

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1570

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1569
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1570

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #19, !dbg !1566
  unreachable, !dbg !1566

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !653, !DIExpression(), !1565)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1571
  %0 = load double, ptr %arrayidx, align 8, !dbg !1571, !tbaa !389
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1571
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1569
    #dbg_value(i64 %indvars.iv.next, !653, !DIExpression(), !1565)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1569
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1570, !llvm.loop !1572

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1570

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1570

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1573
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #3 !dbg !613 {
entry.split:
    #dbg_value(i32 %fd, !612, !DIExpression(), !1574)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1575
  br i1 %cmp, label %if.end, label %if.else, !dbg !1575

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1575
  unreachable, !dbg !1575

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1576
  ret i32 0, !dbg !1577
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #3 !dbg !1578 {
entry.split:
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.011.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem53 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem55 = alloca ptr, align 8
  %i.041.i.i.reg2mem57 = alloca i32, align 4
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %check_file.0.reg2mem59 = alloca ptr, align 8
  %in_file.06.reg2mem61 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1582, !DIExpression(), !1591)
    #dbg_value(ptr %argv, !1583, !DIExpression(), !1591)
  %cmp = icmp slt i32 %argc, 4, !dbg !1592
  br i1 %cmp, label %if.end, label %if.else, !dbg !1592

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.15, ptr noundef nonnull @.str.2.16, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1592
  unreachable, !dbg !1592

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1584, !DIExpression(), !1591)
    #dbg_value(ptr @.str.4.17, !1585, !DIExpression(), !1591)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1595
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1597

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.17, ptr %check_file.0.reg2mem59, align 8
  store ptr @.str.3, ptr %in_file.06.reg2mem61, align 8
  br label %if.end7, !dbg !1597

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1598
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1598
    #dbg_value(ptr %0, !1584, !DIExpression(), !1591)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1599
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1601

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.17, ptr %check_file.0.reg2mem59, align 8
  store ptr %0, ptr %in_file.06.reg2mem61, align 8
  br label %if.end7, !dbg !1601

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1602
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1602
    #dbg_value(ptr %1, !1585, !DIExpression(), !1591)
  store ptr %1, ptr %check_file.0.reg2mem59, align 8
  store ptr %0, ptr %in_file.06.reg2mem61, align 8
  br label %if.end7, !dbg !1603

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem59.0.check_file.0.reload60, !1585, !DIExpression(), !1591)
  %in_file.06.reg2mem61.0.in_file.06.reload62 = load ptr, ptr %in_file.06.reg2mem61, align 8
  %check_file.0.reg2mem59.0.check_file.0.reload60 = load ptr, ptr %check_file.0.reg2mem59, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1604, !tbaa !1078
  %conv = sext i32 %2 to i64, !dbg !1604
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #20, !dbg !1605
    #dbg_value(ptr %call, !1587, !DIExpression(), !1591)
  %cmp8.not = icmp eq ptr %call, null, !dbg !1606
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1606

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.18, ptr noundef nonnull @.str.2.16, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1606
  unreachable, !dbg !1606

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.06.reg2mem61.0.in_file.06.reload62, i32 noundef signext 0) #18, !dbg !1609
    #dbg_value(i32 %call14, !1586, !DIExpression(), !1591)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1610
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1610

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.19, ptr noundef nonnull @.str.2.16, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1610
  unreachable, !dbg !1610

if.end20:                                         ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #18, !dbg !1613
    #dbg_value(ptr %call, !492, !DIExpression(), !1614)
    #dbg_value(ptr %call, !493, !DIExpression(), !1614)
  %init.i = getelementptr inbounds i8, ptr %call, i64 144, !dbg !1616
  %transition.i = getelementptr inbounds i8, ptr %call, i64 656, !dbg !1617
  %emission.i = getelementptr inbounds i8, ptr %call, i64 33424, !dbg !1618
  %path.i = getelementptr inbounds i8, ptr %call, i64 66192, !dbg !1619
  %call.i = tail call signext i32 @viterbi(ptr noundef nonnull %call, ptr noundef nonnull %init.i, ptr noundef nonnull %transition.i, ptr noundef nonnull %emission.i, ptr noundef nonnull %path.i) #18, !dbg !1620
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #18, !dbg !1621
    #dbg_value(i32 %call21, !1588, !DIExpression(), !1591)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1622
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1622

if.else26:                                        ; preds = %if.end20
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.16, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1622
  unreachable, !dbg !1622

if.end27:                                         ; preds = %if.end20
    #dbg_value(i32 %call21, !718, !DIExpression(), !1625)
    #dbg_value(ptr %call, !719, !DIExpression(), !1625)
    #dbg_value(ptr %call, !720, !DIExpression(), !1625)
    #dbg_value(i32 %call21, !612, !DIExpression(), !1627)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1629
  br i1 %cmp.i.i.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1629

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1629
  unreachable, !dbg !1629

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1630
    #dbg_value(i32 %call21, !623, !DIExpression(), !1631)
    #dbg_value(ptr %path.i, !629, !DIExpression(), !1631)
    #dbg_value(i32 140, !630, !DIExpression(), !1631)
    #dbg_value(i32 0, !631, !DIExpression(), !1631)
  store i64 0, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1633

for.body.i.i:                                     ; preds = %for.body.i.i.for.body.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !631, !DIExpression(), !1631)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %arrayidx.i.i = getelementptr inbounds i8, ptr %path.i, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !1634
  %3 = load i8, ptr %arrayidx.i.i, align 1, !dbg !1634, !tbaa !380
  %conv.i.i = zext i8 %3 to i32, !dbg !1634
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.17, i32 noundef signext %conv.i.i), !dbg !1634
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !1635
    #dbg_value(i64 %indvars.iv.next.i.i, !631, !DIExpression(), !1631)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 140, !dbg !1635
  br i1 %exitcond.not.i.i, label %data_to_output.exit, label %for.body.i.i.for.body.i.i_crit_edge, !dbg !1633, !llvm.loop !1636

for.body.i.i.for.body.i.i_crit_edge:              ; preds = %for.body.i.i
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1633

data_to_output.exit:                              ; preds = %for.body.i.i
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #18, !dbg !1637
  %4 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1638, !tbaa !1078
  %conv29 = sext i32 %4 to i64, !dbg !1638
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #20, !dbg !1639
    #dbg_value(ptr %call30, !1590, !DIExpression(), !1591)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1640
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1640

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.20, ptr noundef nonnull @.str.2.16, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1640
  unreachable, !dbg !1640

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem59.0.check_file.0.reload60, i32 noundef signext 0) #18, !dbg !1643
    #dbg_value(i32 %call37, !1589, !DIExpression(), !1591)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1644
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1644

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.21, ptr noundef nonnull @.str.2.16, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1644
  unreachable, !dbg !1644

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !686, !DIExpression(), !1647)
    #dbg_value(ptr %call30, !687, !DIExpression(), !1647)
    #dbg_value(ptr %call30, !688, !DIExpression(), !1647)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(66336) %call30, i8 0, i64 66336, i1 false), !dbg !1649
  %call.i2 = tail call ptr @readfile(i32 noundef signext %call37) #18, !dbg !1650
    #dbg_value(ptr %call.i2, !689, !DIExpression(), !1647)
    #dbg_value(ptr %call.i2, !513, !DIExpression(), !1651)
    #dbg_value(i32 1, !518, !DIExpression(), !1651)
    #dbg_value(i32 0, !519, !DIExpression(), !1651)
  store ptr %call.i2, ptr %s.addr.040.i.i.reg2mem55, align 8
  store i32 0, ptr %i.041.i.i.reg2mem57, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i.reg2mem57.0.load, !519, !DIExpression(), !1651)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem55.0.s.addr.040.i.i.reload56, !513, !DIExpression(), !1651)
  %i.041.i.i.reg2mem57.0.load = load i32, ptr %i.041.i.i.reg2mem57, align 4
  %s.addr.040.i.i.reg2mem55.0.s.addr.040.i.i.reload56 = load ptr, ptr %s.addr.040.i.i.reg2mem55, align 8
  %5 = load i8, ptr %s.addr.040.i.i.reg2mem55.0.s.addr.040.i.i.reload56, align 1, !dbg !1653, !tbaa !380
  switch i8 %5, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1654

land.rhs.i.i.output_to_data.exit_crit_edge:       ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem55.0.s.addr.040.i.i.reload56, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1654

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem57.0.load, ptr %i.1.i.i.reg2mem53, align 4
  br label %if.end21.i.i, !dbg !1654

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem55.0.s.addr.040.i.i.reload56, i64 1, !dbg !1655
  %6 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !1655, !tbaa !380
  %cmp13.i.i = icmp eq i8 %6, 37, !dbg !1656
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1657

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem57.0.load, ptr %i.1.i.i.reg2mem53, align 4
  br label %if.end21.i.i, !dbg !1657

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem55.0.s.addr.040.i.i.reload56, i64 2, !dbg !1658
  %7 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1658, !tbaa !380
  %cmp18.i.i = icmp eq i8 %7, 10, !dbg !1659
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1660
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem57.0.load, %inc.i.i, !dbg !1660
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem53, align 4
  br label %if.end21.i.i, !dbg !1660

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem53.0.load, !519, !DIExpression(), !1651)
  %i.1.i.i.reg2mem53.0.load = load i32, ptr %i.1.i.i.reg2mem53, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem55.0.s.addr.040.i.i.reload56, i64 1, !dbg !1661
    #dbg_value(ptr %incdec.ptr.i.i, !513, !DIExpression(), !1651)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem53.0.load, 1, !dbg !1662
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1663, !llvm.loop !1664

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem55, align 8
  store i32 %i.1.i.i.reg2mem53.0.load, ptr %i.041.i.i.reg2mem57, align 4
  br label %land.rhs.i.i, !dbg !1663

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1666, !tbaa !380
  %8 = icmp eq i8 %.pre.i.i, 0, !dbg !1667
  %9 = select i1 %8, i64 0, i64 2, !dbg !1668
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1663

output_to_data.exit:                              ; preds = %land.rhs.i.i.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1668
    #dbg_value(ptr %spec.select38.i.i, !690, !DIExpression(), !1647)
  %path.i3 = getelementptr inbounds i8, ptr %call30, i64 66192, !dbg !1669
  %call2.i = tail call signext i32 @parse_uint8_t_array(ptr noundef nonnull %spec.select38.i.i, ptr noundef nonnull %path.i3, i32 noundef signext 140) #18, !dbg !1670
  tail call void @free(ptr noundef %call.i2) #18, !dbg !1671
    #dbg_value(ptr %call, !738, !DIExpression(), !1672)
    #dbg_value(ptr %call30, !739, !DIExpression(), !1672)
    #dbg_value(ptr %call, !740, !DIExpression(), !1672)
    #dbg_value(ptr %call30, !741, !DIExpression(), !1672)
    #dbg_value(i32 0, !742, !DIExpression(), !1672)
    #dbg_value(i32 0, !743, !DIExpression(), !1672)
  store i32 0, ptr %has_errors.011.i.reg2mem, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1675

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %output_to_data.exit
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !743, !DIExpression(), !1672)
    #dbg_value(i32 %has_errors.011.i.reg2mem.0.load, !742, !DIExpression(), !1672)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %has_errors.011.i.reg2mem.0.load = load i32, ptr %has_errors.011.i.reg2mem, align 4
  %arrayidx.i = getelementptr inbounds %struct.bench_args_t, ptr %call, i64 0, i32 4, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1676
  %10 = load i8, ptr %arrayidx.i, align 1, !dbg !1676, !tbaa !380
  %arrayidx3.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 4, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1677
  %11 = load i8, ptr %arrayidx3.i, align 1, !dbg !1677, !tbaa !380
  %cmp5.i = icmp ne i8 %10, %11, !dbg !1678
  %conv6.i = zext i1 %cmp5.i to i32, !dbg !1678
  %or.i = or i32 %has_errors.011.i.reg2mem.0.load, %conv6.i, !dbg !1679
    #dbg_value(i32 %or.i, !742, !DIExpression(), !1672)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1680
    #dbg_value(i64 %indvars.iv.next.i, !743, !DIExpression(), !1672)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 140, !dbg !1681
  br i1 %exitcond.not.i, label %check_data.exit, label %for.body.i.for.body.i_crit_edge, !dbg !1675, !llvm.loop !1682

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i32 %or.i, ptr %has_errors.011.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1675

check_data.exit:                                  ; preds = %for.body.i
  %tobool.not.i.not = icmp eq i32 %or.i, 0, !dbg !1684
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1685

if.then45:                                        ; preds = %check_data.exit
  %12 = load ptr, ptr @stderr, align 8, !dbg !1686, !tbaa !942
  %13 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %12) #21, !dbg !1688
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1689

if.end47:                                         ; preds = %check_data.exit
  tail call void @free(ptr noundef nonnull %call) #18, !dbg !1690
  tail call void @free(ptr noundef nonnull %call30) #18, !dbg !1691
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1692
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1693

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1694
}

; Function Attrs: nofree
declare !dbg !1695 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #10

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #17

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #17

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "polly-optimized" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #3 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #5 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #6 = { nofree norecurse nosync nounwind memory(argmem: read) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
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

!llvm.dbg.cu = !{!242, !188, !244, !304}
!llvm.ident = !{!325, !325, !325, !325}
!llvm.module.flags = !{!326, !327, !328, !329, !330, !332, !333, !334, !335, !336}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/viterbi/viterbi")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/viterbi/viterbi")
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
!187 = distinct !DIGlobalVariable(name: "INPUT_SIZE", scope: !188, file: !189, line: 4, type: !220, isLocal: false, isDefinition: true)
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !219, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/viterbi/viterbi")
!190 = !{!191}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 30, size: 530688, elements: !194)
!193 = !DIFile(filename: "./viterbi.h", directory: "/home/kelvin/MachSuite/viterbi/viterbi")
!194 = !{!195, !205, !211, !215, !216}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "obs", scope: !192, file: !193, line: 31, baseType: !196, size: 1120)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 1120, elements: !203)
!197 = !DIDerivedType(tag: DW_TAG_typedef, name: "tok_t", file: !193, line: 13, baseType: !198)
!198 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !199, line: 24, baseType: !200)
!199 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!200 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !201, line: 38, baseType: !202)
!201 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!202 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!203 = !{!204}
!204 = !DISubrange(count: 140)
!205 = !DIDerivedType(tag: DW_TAG_member, name: "init", scope: !192, file: !193, line: 32, baseType: !206, size: 4096, offset: 1152)
!206 = !DICompositeType(tag: DW_TAG_array_type, baseType: !207, size: 4096, elements: !209)
!207 = !DIDerivedType(tag: DW_TAG_typedef, name: "prob_t", file: !193, line: 14, baseType: !208)
!208 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!209 = !{!210}
!210 = !DISubrange(count: 64)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "transition", scope: !192, file: !193, line: 33, baseType: !212, size: 262144, offset: 5248)
!212 = !DICompositeType(tag: DW_TAG_array_type, baseType: !207, size: 262144, elements: !213)
!213 = !{!214}
!214 = !DISubrange(count: 4096)
!215 = !DIDerivedType(tag: DW_TAG_member, name: "emission", scope: !192, file: !193, line: 34, baseType: !212, size: 262144, offset: 267392)
!216 = !DIDerivedType(tag: DW_TAG_member, name: "path", scope: !192, file: !193, line: 35, baseType: !217, size: 1120, offset: 529536)
!217 = !DICompositeType(tag: DW_TAG_array_type, baseType: !218, size: 1120, elements: !203)
!218 = !DIDerivedType(tag: DW_TAG_typedef, name: "state_t", file: !193, line: 15, baseType: !198)
!219 = !{!186}
!220 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!221 = !DIGlobalVariableExpression(var: !222, expr: !DIExpression())
!222 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !223, isLocal: true, isDefinition: true)
!223 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!224 = !DIGlobalVariableExpression(var: !225, expr: !DIExpression())
!225 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !226, isLocal: true, isDefinition: true)
!226 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!227 = !DIGlobalVariableExpression(var: !228, expr: !DIExpression())
!228 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !229, isLocal: true, isDefinition: true)
!229 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !230)
!230 = !{!231}
!231 = !DISubrange(count: 12)
!232 = !DIGlobalVariableExpression(var: !233, expr: !DIExpression())
!233 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !234, isLocal: true, isDefinition: true)
!234 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!235 = !DIGlobalVariableExpression(var: !236, expr: !DIExpression())
!236 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!237 = !DIGlobalVariableExpression(var: !238, expr: !DIExpression())
!238 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !239, isLocal: true, isDefinition: true)
!239 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!240 = !DIGlobalVariableExpression(var: !241, expr: !DIExpression())
!241 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!242 = distinct !DICompileUnit(language: DW_LANG_C11, file: !243, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!243 = !DIFile(filename: "viterbi.c", directory: "/home/kelvin/MachSuite/viterbi/viterbi")
!244 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !245, globals: !270, splitDebugInlining: false, nameTableKind: None)
!245 = !{!246, !4, !247, !198, !248, !251, !254, !257, !261, !264, !266, !269, !208}
!246 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!247 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!248 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !199, line: 25, baseType: !249)
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !201, line: 40, baseType: !250)
!250 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!251 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !199, line: 26, baseType: !252)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !201, line: 42, baseType: !253)
!253 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!254 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !199, line: 27, baseType: !255)
!255 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !201, line: 45, baseType: !256)
!256 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!257 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !258, line: 24, baseType: !259)
!258 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!259 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !201, line: 37, baseType: !260)
!260 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!261 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !258, line: 25, baseType: !262)
!262 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !201, line: 39, baseType: !263)
!263 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!264 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !258, line: 26, baseType: !265)
!265 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !201, line: 41, baseType: !220)
!266 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !258, line: 27, baseType: !267)
!267 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !201, line: 44, baseType: !268)
!268 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!269 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!270 = !{!271, !0, !7, !12, !276, !18, !278, !23, !283, !28, !285, !33, !38, !287, !43, !45, !47, !52, !57, !62, !67, !69, !71, !76, !78, !80, !82, !87, !89, !292, !92, !97, !102, !107, !112, !114, !116, !121, !126, !128, !130, !132, !134, !136, !141, !146, !148, !153, !297, !158, !163, !299, !165}
!271 = !DIGlobalVariableExpression(var: !272, expr: !DIExpression())
!272 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !273, isLocal: true, isDefinition: true)
!273 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !274)
!274 = !{!275}
!275 = !DISubrange(count: 24)
!276 = !DIGlobalVariableExpression(var: !277, expr: !DIExpression())
!277 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !30, isLocal: true, isDefinition: true)
!278 = !DIGlobalVariableExpression(var: !279, expr: !DIExpression())
!279 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !280, isLocal: true, isDefinition: true)
!280 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !281)
!281 = !{!282}
!282 = !DISubrange(count: 14)
!283 = !DIGlobalVariableExpression(var: !284, expr: !DIExpression())
!284 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !280, isLocal: true, isDefinition: true)
!285 = !DIGlobalVariableExpression(var: !286, expr: !DIExpression())
!286 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !9, isLocal: true, isDefinition: true)
!287 = !DIGlobalVariableExpression(var: !288, expr: !DIExpression())
!288 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !289, isLocal: true, isDefinition: true)
!289 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !290)
!290 = !{!291}
!291 = !DISubrange(count: 21)
!292 = !DIGlobalVariableExpression(var: !293, expr: !DIExpression())
!293 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !294, isLocal: true, isDefinition: true)
!294 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !295)
!295 = !{!296}
!296 = !DISubrange(count: 13)
!297 = !DIGlobalVariableExpression(var: !298, expr: !DIExpression())
!298 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !20, isLocal: true, isDefinition: true)
!299 = !DIGlobalVariableExpression(var: !300, expr: !DIExpression())
!300 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !301, isLocal: true, isDefinition: true)
!301 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !302)
!302 = !{!303}
!303 = !DISubrange(count: 27)
!304 = distinct !DICompileUnit(language: DW_LANG_C11, file: !170, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !305, globals: !306, splitDebugInlining: false, nameTableKind: None)
!305 = !{!247}
!306 = !{!307, !168, !174, !176, !179, !184, !309, !221, !311, !224, !227, !313, !232, !235, !318, !237, !240, !320}
!307 = !DIGlobalVariableExpression(var: !308, expr: !DIExpression())
!308 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !234, isLocal: true, isDefinition: true)
!309 = !DIGlobalVariableExpression(var: !310, expr: !DIExpression())
!310 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !280, isLocal: true, isDefinition: true)
!311 = !DIGlobalVariableExpression(var: !312, expr: !DIExpression())
!312 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !223, isLocal: true, isDefinition: true)
!313 = !DIGlobalVariableExpression(var: !314, expr: !DIExpression())
!314 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !315, isLocal: true, isDefinition: true)
!315 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !316)
!316 = !{!317}
!317 = !DISubrange(count: 31)
!318 = !DIGlobalVariableExpression(var: !319, expr: !DIExpression())
!319 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !223, isLocal: true, isDefinition: true)
!320 = !DIGlobalVariableExpression(var: !321, expr: !DIExpression())
!321 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !322, isLocal: true, isDefinition: true)
!322 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !323)
!323 = !{!324}
!324 = !DISubrange(count: 10)
!325 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!326 = !{i32 7, !"Dwarf Version", i32 4}
!327 = !{i32 2, !"Debug Info Version", i32 3}
!328 = !{i32 1, !"wchar_size", i32 4}
!329 = !{i32 1, !"target-abi", !"lp64d"}
!330 = distinct !{i32 6, !"riscv-isa", !331}
!331 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!332 = !{i32 8, !"PIC Level", i32 2}
!333 = !{i32 7, !"PIE Level", i32 2}
!334 = !{i32 7, !"uwtable", i32 2}
!335 = !{i32 8, !"SmallDataLimit", i32 8}
!336 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!337 = distinct !DISubprogram(name: "viterbi", scope: !243, file: !243, line: 3, type: !338, scopeLine: 4, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !242, retainedNodes: !343)
!338 = !DISubroutineType(types: !339)
!339 = !{!220, !340, !341, !341, !341, !342}
!340 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!341 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !207, size: 64)
!342 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !218, size: 64)
!343 = !{!344, !345, !346, !347, !348, !349, !352, !354, !355, !356, !357, !358, !359, !360, !361, !362, !366, !370, !371, !372}
!344 = !DILocalVariable(name: "obs", arg: 1, scope: !337, file: !243, line: 3, type: !340)
!345 = !DILocalVariable(name: "init", arg: 2, scope: !337, file: !243, line: 3, type: !341)
!346 = !DILocalVariable(name: "transition", arg: 3, scope: !337, file: !243, line: 3, type: !341)
!347 = !DILocalVariable(name: "emission", arg: 4, scope: !337, file: !243, line: 3, type: !341)
!348 = !DILocalVariable(name: "path", arg: 5, scope: !337, file: !243, line: 3, type: !342)
!349 = !DILocalVariable(name: "llike", scope: !337, file: !243, line: 5, type: !350)
!350 = !DICompositeType(tag: DW_TAG_array_type, baseType: !207, size: 573440, elements: !351)
!351 = !{!204, !210}
!352 = !DILocalVariable(name: "t", scope: !337, file: !243, line: 6, type: !353)
!353 = !DIDerivedType(tag: DW_TAG_typedef, name: "step_t", file: !193, line: 16, baseType: !264)
!354 = !DILocalVariable(name: "prev", scope: !337, file: !243, line: 7, type: !218)
!355 = !DILocalVariable(name: "curr", scope: !337, file: !243, line: 7, type: !218)
!356 = !DILocalVariable(name: "min_p", scope: !337, file: !243, line: 8, type: !207)
!357 = !DILocalVariable(name: "p", scope: !337, file: !243, line: 8, type: !207)
!358 = !DILocalVariable(name: "min_s", scope: !337, file: !243, line: 9, type: !218)
!359 = !DILocalVariable(name: "s", scope: !337, file: !243, line: 9, type: !218)
!360 = !DILabel(scope: !337, name: "L_init", file: !243, line: 13)
!361 = !DILabel(scope: !337, name: "L_timestep", file: !243, line: 18)
!362 = !DILabel(scope: !363, name: "L_curr_state", file: !243, line: 19)
!363 = distinct !DILexicalBlock(scope: !364, file: !243, line: 18, column: 40)
!364 = distinct !DILexicalBlock(scope: !365, file: !243, line: 18, column: 15)
!365 = distinct !DILexicalBlock(scope: !337, file: !243, line: 18, column: 15)
!366 = !DILabel(scope: !367, name: "L_prev_state", file: !243, line: 25)
!367 = distinct !DILexicalBlock(scope: !368, file: !243, line: 19, column: 56)
!368 = distinct !DILexicalBlock(scope: !369, file: !243, line: 19, column: 19)
!369 = distinct !DILexicalBlock(scope: !363, file: !243, line: 19, column: 19)
!370 = !DILabel(scope: !337, name: "L_end", file: !243, line: 40)
!371 = !DILabel(scope: !337, name: "L_backtrack", file: !243, line: 50)
!372 = !DILabel(scope: !373, name: "L_state", file: !243, line: 53)
!373 = distinct !DILexicalBlock(scope: !374, file: !243, line: 50, column: 44)
!374 = distinct !DILexicalBlock(scope: !375, file: !243, line: 50, column: 16)
!375 = distinct !DILexicalBlock(scope: !337, file: !243, line: 50, column: 16)
!376 = distinct !DIAssignID()
!377 = !DILocation(line: 0, scope: !337)
!378 = !DILocation(line: 5, column: 3, scope: !337)
!379 = !DILocation(line: 13, column: 3, scope: !337)
!380 = !{!381, !381, i64 0}
!381 = !{!"omnipotent char", !382, i64 0}
!382 = !{!"Simple C/C++ TBAA"}
!383 = !DILocation(line: 13, column: 16, scope: !384)
!384 = distinct !DILexicalBlock(scope: !337, file: !243, line: 13, column: 11)
!385 = !DILocation(line: 13, column: 11, scope: !384)
!386 = !DILocation(line: 14, column: 19, scope: !387)
!387 = distinct !DILexicalBlock(scope: !388, file: !243, line: 13, column: 39)
!388 = distinct !DILexicalBlock(scope: !384, file: !243, line: 13, column: 11)
!389 = !{!390, !390, i64 0}
!390 = !{!"double", !381, i64 0}
!391 = !DILocation(line: 14, column: 29, scope: !387)
!392 = !DILocation(line: 14, column: 27, scope: !387)
!393 = !DILocation(line: 14, column: 5, scope: !387)
!394 = !DILocation(line: 14, column: 17, scope: !387)
!395 = !DILocation(line: 13, column: 34, scope: !388)
!396 = !DILocation(line: 13, column: 22, scope: !388)
!397 = distinct !{!397, !385, !398, !399, !400}
!398 = !DILocation(line: 15, column: 3, scope: !384)
!399 = !{!"llvm.loop.mustprogress"}
!400 = !{!"llvm.loop.unroll.disable"}
!401 = !DILocation(line: 18, column: 15, scope: !365)
!402 = !DILocation(line: 19, column: 19, scope: !369)
!403 = !DILocation(line: 22, column: 15, scope: !367)
!404 = !DILocation(line: 23, column: 15, scope: !367)
!405 = !DILocation(line: 22, column: 32, scope: !367)
!406 = !DILocation(line: 24, column: 15, scope: !367)
!407 = !DILocation(line: 23, column: 46, scope: !367)
!408 = !DILocation(line: 25, column: 7, scope: !367)
!409 = !DILocation(line: 25, column: 21, scope: !410)
!410 = distinct !DILexicalBlock(scope: !367, file: !243, line: 25, column: 21)
!411 = !DILocation(line: 26, column: 13, scope: !412)
!412 = distinct !DILexicalBlock(scope: !413, file: !243, line: 25, column: 58)
!413 = distinct !DILexicalBlock(scope: !410, file: !243, line: 25, column: 21)
!414 = !DILocation(line: 27, column: 13, scope: !412)
!415 = !DILocation(line: 26, column: 30, scope: !412)
!416 = !DILocation(line: 27, column: 44, scope: !412)
!417 = !DILocation(line: 29, column: 14, scope: !418)
!418 = distinct !DILexicalBlock(scope: !412, file: !243, line: 29, column: 13)
!419 = !DILocation(line: 29, column: 13, scope: !412)
!420 = !DILocation(line: 25, column: 53, scope: !413)
!421 = !DILocation(line: 25, column: 38, scope: !413)
!422 = distinct !{!422, !409, !423, !399, !400}
!423 = !DILocation(line: 32, column: 7, scope: !410)
!424 = !DILocation(line: 33, column: 7, scope: !367)
!425 = !DILocation(line: 33, column: 22, scope: !367)
!426 = !DILocation(line: 19, column: 51, scope: !368)
!427 = !DILocation(line: 19, column: 36, scope: !368)
!428 = distinct !{!428, !402, !429, !399, !400}
!429 = !DILocation(line: 34, column: 5, scope: !369)
!430 = !DILocation(line: 18, column: 35, scope: !364)
!431 = !DILocation(line: 18, column: 26, scope: !364)
!432 = distinct !{!432, !401, !433, !399, !400}
!433 = !DILocation(line: 35, column: 3, scope: !365)
!434 = !DILocation(line: 39, column: 11, scope: !337)
!435 = !DILocation(line: 40, column: 3, scope: !337)
!436 = !DILocation(line: 40, column: 10, scope: !437)
!437 = distinct !DILexicalBlock(scope: !337, file: !243, line: 40, column: 10)
!438 = !DILocation(line: 41, column: 9, scope: !439)
!439 = distinct !DILexicalBlock(scope: !440, file: !243, line: 40, column: 38)
!440 = distinct !DILexicalBlock(scope: !437, file: !243, line: 40, column: 10)
!441 = !DILocation(line: 42, column: 10, scope: !442)
!442 = distinct !DILexicalBlock(scope: !439, file: !243, line: 42, column: 9)
!443 = !DILocation(line: 42, column: 9, scope: !439)
!444 = !DILocation(line: 40, column: 33, scope: !440)
!445 = !DILocation(line: 40, column: 21, scope: !440)
!446 = distinct !{!446, !436, !447, !399, !400}
!447 = !DILocation(line: 46, column: 3, scope: !437)
!448 = !DILocation(line: 47, column: 3, scope: !337)
!449 = !DILocation(line: 47, column: 17, scope: !337)
!450 = !DILocation(line: 50, column: 3, scope: !337)
!451 = !DILocation(line: 50, column: 16, scope: !375)
!452 = !DILocation(line: 52, column: 13, scope: !373)
!453 = !DILocation(line: 52, column: 57, scope: !373)
!454 = !DILocation(line: 52, column: 31, scope: !373)
!455 = !DILocation(line: 52, column: 29, scope: !373)
!456 = !DILocation(line: 53, column: 5, scope: !373)
!457 = !DILocation(line: 53, column: 14, scope: !458)
!458 = distinct !DILexicalBlock(scope: !373, file: !243, line: 53, column: 14)
!459 = !DILocation(line: 54, column: 11, scope: !460)
!460 = distinct !DILexicalBlock(scope: !461, file: !243, line: 53, column: 42)
!461 = distinct !DILexicalBlock(scope: !458, file: !243, line: 53, column: 14)
!462 = !DILocation(line: 54, column: 25, scope: !460)
!463 = !DILocation(line: 54, column: 23, scope: !460)
!464 = !DILocation(line: 55, column: 12, scope: !465)
!465 = distinct !DILexicalBlock(scope: !460, file: !243, line: 55, column: 11)
!466 = !DILocation(line: 55, column: 11, scope: !460)
!467 = !DILocation(line: 53, column: 37, scope: !461)
!468 = !DILocation(line: 53, column: 25, scope: !461)
!469 = distinct !{!469, !457, !470, !399, !400}
!470 = !DILocation(line: 59, column: 5, scope: !458)
!471 = !DILocation(line: 60, column: 13, scope: !373)
!472 = !DILocation(line: 50, column: 39, scope: !374)
!473 = !DILocation(line: 50, column: 33, scope: !374)
!474 = distinct !{!474, !451, !475, !399, !400}
!475 = !DILocation(line: 61, column: 3, scope: !375)
!476 = !DILocation(line: 64, column: 1, scope: !337)
!477 = !DILocation(line: 63, column: 3, scope: !337)
!478 = !{!479}
!479 = distinct !{!479, !480, !"polly.alias.scope.MemRef0"}
!480 = distinct !{!480, !"polly.alias.scope.domain"}
!481 = !{!482, !483}
!482 = distinct !{!482, !480, !"polly.alias.scope.MemRef2"}
!483 = distinct !{!483, !480, !"polly.alias.scope.MemRef5"}
!484 = !{!482}
!485 = !{!479, !483}
!486 = !{!483}
!487 = !{!479, !482}
!488 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 6, type: !489, scopeLine: 6, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !491)
!489 = !DISubroutineType(types: !490)
!490 = !{null, !247}
!491 = !{!492, !493}
!492 = !DILocalVariable(name: "vargs", arg: 1, scope: !488, file: !189, line: 6, type: !247)
!493 = !DILocalVariable(name: "args", scope: !488, file: !189, line: 7, type: !191)
!494 = !DILocation(line: 0, scope: !488)
!495 = !DILocation(line: 8, column: 29, scope: !488)
!496 = !DILocation(line: 8, column: 41, scope: !488)
!497 = !DILocation(line: 8, column: 59, scope: !488)
!498 = !DILocation(line: 8, column: 75, scope: !488)
!499 = !DILocation(line: 8, column: 3, scope: !488)
!500 = !DILocation(line: 9, column: 1, scope: !488)
!501 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 22, type: !502, scopeLine: 22, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !504)
!502 = !DISubroutineType(types: !503)
!503 = !{null, !220, !247}
!504 = !{!505, !506, !507, !508, !509}
!505 = !DILocalVariable(name: "fd", arg: 1, scope: !501, file: !189, line: 22, type: !220)
!506 = !DILocalVariable(name: "vdata", arg: 2, scope: !501, file: !189, line: 22, type: !247)
!507 = !DILocalVariable(name: "data", scope: !501, file: !189, line: 23, type: !191)
!508 = !DILocalVariable(name: "p", scope: !501, file: !189, line: 24, type: !246)
!509 = !DILocalVariable(name: "s", scope: !501, file: !189, line: 24, type: !246)
!510 = !DILocation(line: 0, scope: !501)
!511 = !DILocation(line: 26, column: 3, scope: !501)
!512 = !DILocation(line: 28, column: 7, scope: !501)
!513 = !DILocalVariable(name: "s", arg: 1, scope: !514, file: !2, line: 56, type: !246)
!514 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !515, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !517)
!515 = !DISubroutineType(types: !516)
!516 = !{!246, !246, !220}
!517 = !{!513, !518, !519}
!518 = !DILocalVariable(name: "n", arg: 2, scope: !514, file: !2, line: 56, type: !220)
!519 = !DILocalVariable(name: "i", scope: !514, file: !2, line: 57, type: !220)
!520 = !DILocation(line: 0, scope: !514, inlinedAt: !521)
!521 = distinct !DILocation(line: 30, column: 7, scope: !501)
!522 = !DILocation(line: 64, column: 17, scope: !514, inlinedAt: !521)
!523 = !DILocation(line: 64, column: 3, scope: !514, inlinedAt: !521)
!524 = !DILocation(line: 66, column: 22, scope: !525, inlinedAt: !521)
!525 = distinct !DILexicalBlock(scope: !526, file: !2, line: 66, column: 9)
!526 = distinct !DILexicalBlock(scope: !514, file: !2, line: 64, column: 31)
!527 = !DILocation(line: 66, column: 26, scope: !525, inlinedAt: !521)
!528 = !DILocation(line: 66, column: 32, scope: !525, inlinedAt: !521)
!529 = !DILocation(line: 66, column: 35, scope: !525, inlinedAt: !521)
!530 = !DILocation(line: 66, column: 39, scope: !525, inlinedAt: !521)
!531 = !DILocation(line: 66, column: 9, scope: !526, inlinedAt: !521)
!532 = !DILocation(line: 69, column: 6, scope: !526, inlinedAt: !521)
!533 = !DILocation(line: 64, column: 10, scope: !514, inlinedAt: !521)
!534 = !DILocation(line: 64, column: 13, scope: !514, inlinedAt: !521)
!535 = distinct !{!535, !523, !536, !399, !400}
!536 = !DILocation(line: 70, column: 3, scope: !514, inlinedAt: !521)
!537 = !DILocation(line: 71, column: 6, scope: !538, inlinedAt: !521)
!538 = distinct !DILexicalBlock(scope: !514, file: !2, line: 71, column: 6)
!539 = !DILocation(line: 71, column: 8, scope: !538, inlinedAt: !521)
!540 = !DILocation(line: 71, column: 6, scope: !514, inlinedAt: !521)
!541 = !DILocation(line: 31, column: 3, scope: !501)
!542 = !DILocation(line: 0, scope: !514, inlinedAt: !543)
!543 = distinct !DILocation(line: 33, column: 7, scope: !501)
!544 = !DILocation(line: 64, column: 17, scope: !514, inlinedAt: !543)
!545 = !DILocation(line: 64, column: 3, scope: !514, inlinedAt: !543)
!546 = !DILocation(line: 66, column: 22, scope: !525, inlinedAt: !543)
!547 = !DILocation(line: 66, column: 26, scope: !525, inlinedAt: !543)
!548 = !DILocation(line: 66, column: 32, scope: !525, inlinedAt: !543)
!549 = !DILocation(line: 66, column: 35, scope: !525, inlinedAt: !543)
!550 = !DILocation(line: 66, column: 39, scope: !525, inlinedAt: !543)
!551 = !DILocation(line: 66, column: 9, scope: !526, inlinedAt: !543)
!552 = !DILocation(line: 69, column: 6, scope: !526, inlinedAt: !543)
!553 = !DILocation(line: 64, column: 10, scope: !514, inlinedAt: !543)
!554 = !DILocation(line: 64, column: 13, scope: !514, inlinedAt: !543)
!555 = distinct !{!555, !545, !556, !399, !400}
!556 = !DILocation(line: 70, column: 3, scope: !514, inlinedAt: !543)
!557 = !DILocation(line: 71, column: 6, scope: !538, inlinedAt: !543)
!558 = !DILocation(line: 71, column: 8, scope: !538, inlinedAt: !543)
!559 = !DILocation(line: 71, column: 6, scope: !514, inlinedAt: !543)
!560 = !DILocation(line: 34, column: 37, scope: !501)
!561 = !DILocation(line: 34, column: 3, scope: !501)
!562 = !DILocation(line: 0, scope: !514, inlinedAt: !563)
!563 = distinct !DILocation(line: 36, column: 7, scope: !501)
!564 = !DILocation(line: 64, column: 17, scope: !514, inlinedAt: !563)
!565 = !DILocation(line: 64, column: 3, scope: !514, inlinedAt: !563)
!566 = !DILocation(line: 66, column: 22, scope: !525, inlinedAt: !563)
!567 = !DILocation(line: 66, column: 26, scope: !525, inlinedAt: !563)
!568 = !DILocation(line: 66, column: 32, scope: !525, inlinedAt: !563)
!569 = !DILocation(line: 66, column: 35, scope: !525, inlinedAt: !563)
!570 = !DILocation(line: 66, column: 39, scope: !525, inlinedAt: !563)
!571 = !DILocation(line: 66, column: 9, scope: !526, inlinedAt: !563)
!572 = !DILocation(line: 69, column: 6, scope: !526, inlinedAt: !563)
!573 = !DILocation(line: 64, column: 10, scope: !514, inlinedAt: !563)
!574 = !DILocation(line: 64, column: 13, scope: !514, inlinedAt: !563)
!575 = distinct !{!575, !565, !576, !399, !400}
!576 = !DILocation(line: 70, column: 3, scope: !514, inlinedAt: !563)
!577 = !DILocation(line: 71, column: 6, scope: !538, inlinedAt: !563)
!578 = !DILocation(line: 71, column: 8, scope: !538, inlinedAt: !563)
!579 = !DILocation(line: 71, column: 6, scope: !514, inlinedAt: !563)
!580 = !DILocation(line: 37, column: 37, scope: !501)
!581 = !DILocation(line: 37, column: 3, scope: !501)
!582 = !DILocation(line: 0, scope: !514, inlinedAt: !583)
!583 = distinct !DILocation(line: 39, column: 7, scope: !501)
!584 = !DILocation(line: 64, column: 17, scope: !514, inlinedAt: !583)
!585 = !DILocation(line: 64, column: 3, scope: !514, inlinedAt: !583)
!586 = !DILocation(line: 66, column: 22, scope: !525, inlinedAt: !583)
!587 = !DILocation(line: 66, column: 26, scope: !525, inlinedAt: !583)
!588 = !DILocation(line: 66, column: 32, scope: !525, inlinedAt: !583)
!589 = !DILocation(line: 66, column: 35, scope: !525, inlinedAt: !583)
!590 = !DILocation(line: 66, column: 39, scope: !525, inlinedAt: !583)
!591 = !DILocation(line: 66, column: 9, scope: !526, inlinedAt: !583)
!592 = !DILocation(line: 69, column: 6, scope: !526, inlinedAt: !583)
!593 = !DILocation(line: 64, column: 10, scope: !514, inlinedAt: !583)
!594 = !DILocation(line: 64, column: 13, scope: !514, inlinedAt: !583)
!595 = distinct !{!595, !585, !596, !399, !400}
!596 = !DILocation(line: 70, column: 3, scope: !514, inlinedAt: !583)
!597 = !DILocation(line: 71, column: 6, scope: !538, inlinedAt: !583)
!598 = !DILocation(line: 71, column: 8, scope: !538, inlinedAt: !583)
!599 = !DILocation(line: 71, column: 6, scope: !514, inlinedAt: !583)
!600 = !DILocation(line: 40, column: 37, scope: !501)
!601 = !DILocation(line: 40, column: 3, scope: !501)
!602 = !DILocation(line: 41, column: 3, scope: !501)
!603 = !DILocation(line: 42, column: 1, scope: !501)
!604 = !DISubprogram(name: "free", scope: !605, file: !605, line: 687, type: !489, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!605 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!606 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 44, type: !502, scopeLine: 44, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !607)
!607 = !{!608, !609, !610}
!608 = !DILocalVariable(name: "fd", arg: 1, scope: !606, file: !189, line: 44, type: !220)
!609 = !DILocalVariable(name: "vdata", arg: 2, scope: !606, file: !189, line: 44, type: !247)
!610 = !DILocalVariable(name: "data", scope: !606, file: !189, line: 45, type: !191)
!611 = !DILocation(line: 0, scope: !606)
!612 = !DILocalVariable(name: "fd", arg: 1, scope: !613, file: !2, line: 189, type: !220)
!613 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !614, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !616)
!614 = !DISubroutineType(types: !615)
!615 = !{!220, !220}
!616 = !{!612}
!617 = !DILocation(line: 0, scope: !613, inlinedAt: !618)
!618 = distinct !DILocation(line: 47, column: 3, scope: !606)
!619 = !DILocation(line: 190, column: 3, scope: !620, inlinedAt: !618)
!620 = distinct !DILexicalBlock(scope: !621, file: !2, line: 190, column: 3)
!621 = distinct !DILexicalBlock(scope: !613, file: !2, line: 190, column: 3)
!622 = !DILocation(line: 191, column: 3, scope: !613, inlinedAt: !618)
!623 = !DILocalVariable(name: "fd", arg: 1, scope: !624, file: !2, line: 177, type: !220)
!624 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !625, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !628)
!625 = !DISubroutineType(types: !626)
!626 = !{!220, !220, !627, !220}
!627 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !198, size: 64)
!628 = !{!623, !629, !630, !631}
!629 = !DILocalVariable(name: "arr", arg: 2, scope: !624, file: !2, line: 177, type: !627)
!630 = !DILocalVariable(name: "n", arg: 3, scope: !624, file: !2, line: 177, type: !220)
!631 = !DILocalVariable(name: "i", scope: !624, file: !2, line: 177, type: !220)
!632 = !DILocation(line: 0, scope: !624, inlinedAt: !633)
!633 = distinct !DILocation(line: 48, column: 3, scope: !606)
!634 = !DILocation(line: 177, column: 1, scope: !635, inlinedAt: !633)
!635 = distinct !DILexicalBlock(scope: !624, file: !2, line: 177, column: 1)
!636 = !DILocation(line: 177, column: 1, scope: !637, inlinedAt: !633)
!637 = distinct !DILexicalBlock(scope: !638, file: !2, line: 177, column: 1)
!638 = distinct !DILexicalBlock(scope: !635, file: !2, line: 177, column: 1)
!639 = !DILocation(line: 177, column: 1, scope: !638, inlinedAt: !633)
!640 = distinct !{!640, !634, !634, !399, !400}
!641 = !DILocation(line: 0, scope: !613, inlinedAt: !642)
!642 = distinct !DILocation(line: 50, column: 3, scope: !606)
!643 = !DILocation(line: 191, column: 3, scope: !613, inlinedAt: !642)
!644 = !DILocation(line: 51, column: 38, scope: !606)
!645 = !DILocalVariable(name: "fd", arg: 1, scope: !646, file: !2, line: 187, type: !220)
!646 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !647, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !650)
!647 = !DISubroutineType(types: !648)
!648 = !{!220, !220, !649, !220}
!649 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !208, size: 64)
!650 = !{!645, !651, !652, !653}
!651 = !DILocalVariable(name: "arr", arg: 2, scope: !646, file: !2, line: 187, type: !649)
!652 = !DILocalVariable(name: "n", arg: 3, scope: !646, file: !2, line: 187, type: !220)
!653 = !DILocalVariable(name: "i", scope: !646, file: !2, line: 187, type: !220)
!654 = !DILocation(line: 0, scope: !646, inlinedAt: !655)
!655 = distinct !DILocation(line: 51, column: 3, scope: !606)
!656 = !DILocation(line: 187, column: 1, scope: !657, inlinedAt: !655)
!657 = distinct !DILexicalBlock(scope: !646, file: !2, line: 187, column: 1)
!658 = !DILocation(line: 187, column: 1, scope: !659, inlinedAt: !655)
!659 = distinct !DILexicalBlock(scope: !660, file: !2, line: 187, column: 1)
!660 = distinct !DILexicalBlock(scope: !657, file: !2, line: 187, column: 1)
!661 = !DILocation(line: 187, column: 1, scope: !660, inlinedAt: !655)
!662 = distinct !{!662, !656, !656, !399, !400}
!663 = !DILocation(line: 0, scope: !613, inlinedAt: !664)
!664 = distinct !DILocation(line: 53, column: 3, scope: !606)
!665 = !DILocation(line: 191, column: 3, scope: !613, inlinedAt: !664)
!666 = !DILocation(line: 54, column: 38, scope: !606)
!667 = !DILocation(line: 0, scope: !646, inlinedAt: !668)
!668 = distinct !DILocation(line: 54, column: 3, scope: !606)
!669 = !DILocation(line: 187, column: 1, scope: !657, inlinedAt: !668)
!670 = !DILocation(line: 187, column: 1, scope: !659, inlinedAt: !668)
!671 = !DILocation(line: 187, column: 1, scope: !660, inlinedAt: !668)
!672 = distinct !{!672, !669, !669, !399, !400}
!673 = !DILocation(line: 0, scope: !613, inlinedAt: !674)
!674 = distinct !DILocation(line: 56, column: 3, scope: !606)
!675 = !DILocation(line: 191, column: 3, scope: !613, inlinedAt: !674)
!676 = !DILocation(line: 57, column: 38, scope: !606)
!677 = !DILocation(line: 0, scope: !646, inlinedAt: !678)
!678 = distinct !DILocation(line: 57, column: 3, scope: !606)
!679 = !DILocation(line: 187, column: 1, scope: !657, inlinedAt: !678)
!680 = !DILocation(line: 187, column: 1, scope: !659, inlinedAt: !678)
!681 = !DILocation(line: 187, column: 1, scope: !660, inlinedAt: !678)
!682 = distinct !{!682, !679, !679, !399, !400}
!683 = !DILocation(line: 58, column: 1, scope: !606)
!684 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 65, type: !502, scopeLine: 65, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !685)
!685 = !{!686, !687, !688, !689, !690}
!686 = !DILocalVariable(name: "fd", arg: 1, scope: !684, file: !189, line: 65, type: !220)
!687 = !DILocalVariable(name: "vdata", arg: 2, scope: !684, file: !189, line: 65, type: !247)
!688 = !DILocalVariable(name: "data", scope: !684, file: !189, line: 66, type: !191)
!689 = !DILocalVariable(name: "p", scope: !684, file: !189, line: 67, type: !246)
!690 = !DILocalVariable(name: "s", scope: !684, file: !189, line: 67, type: !246)
!691 = !DILocation(line: 0, scope: !684)
!692 = !DILocation(line: 69, column: 3, scope: !684)
!693 = !DILocation(line: 71, column: 7, scope: !684)
!694 = !DILocation(line: 0, scope: !514, inlinedAt: !695)
!695 = distinct !DILocation(line: 73, column: 7, scope: !684)
!696 = !DILocation(line: 64, column: 17, scope: !514, inlinedAt: !695)
!697 = !DILocation(line: 64, column: 3, scope: !514, inlinedAt: !695)
!698 = !DILocation(line: 66, column: 22, scope: !525, inlinedAt: !695)
!699 = !DILocation(line: 66, column: 26, scope: !525, inlinedAt: !695)
!700 = !DILocation(line: 66, column: 32, scope: !525, inlinedAt: !695)
!701 = !DILocation(line: 66, column: 35, scope: !525, inlinedAt: !695)
!702 = !DILocation(line: 66, column: 39, scope: !525, inlinedAt: !695)
!703 = !DILocation(line: 66, column: 9, scope: !526, inlinedAt: !695)
!704 = !DILocation(line: 69, column: 6, scope: !526, inlinedAt: !695)
!705 = !DILocation(line: 64, column: 10, scope: !514, inlinedAt: !695)
!706 = !DILocation(line: 64, column: 13, scope: !514, inlinedAt: !695)
!707 = distinct !{!707, !697, !708, !399, !400}
!708 = !DILocation(line: 70, column: 3, scope: !514, inlinedAt: !695)
!709 = !DILocation(line: 71, column: 6, scope: !538, inlinedAt: !695)
!710 = !DILocation(line: 71, column: 8, scope: !538, inlinedAt: !695)
!711 = !DILocation(line: 71, column: 6, scope: !514, inlinedAt: !695)
!712 = !DILocation(line: 74, column: 32, scope: !684)
!713 = !DILocation(line: 74, column: 3, scope: !684)
!714 = !DILocation(line: 75, column: 3, scope: !684)
!715 = !DILocation(line: 76, column: 1, scope: !684)
!716 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 78, type: !502, scopeLine: 78, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !717)
!717 = !{!718, !719, !720}
!718 = !DILocalVariable(name: "fd", arg: 1, scope: !716, file: !189, line: 78, type: !220)
!719 = !DILocalVariable(name: "vdata", arg: 2, scope: !716, file: !189, line: 78, type: !247)
!720 = !DILocalVariable(name: "data", scope: !716, file: !189, line: 79, type: !191)
!721 = !DILocation(line: 0, scope: !716)
!722 = !DILocation(line: 0, scope: !613, inlinedAt: !723)
!723 = distinct !DILocation(line: 81, column: 3, scope: !716)
!724 = !DILocation(line: 190, column: 3, scope: !620, inlinedAt: !723)
!725 = !DILocation(line: 191, column: 3, scope: !613, inlinedAt: !723)
!726 = !DILocation(line: 82, column: 33, scope: !716)
!727 = !DILocation(line: 0, scope: !624, inlinedAt: !728)
!728 = distinct !DILocation(line: 82, column: 3, scope: !716)
!729 = !DILocation(line: 177, column: 1, scope: !635, inlinedAt: !728)
!730 = !DILocation(line: 177, column: 1, scope: !637, inlinedAt: !728)
!731 = !DILocation(line: 177, column: 1, scope: !638, inlinedAt: !728)
!732 = distinct !{!732, !729, !729, !399, !400}
!733 = !DILocation(line: 83, column: 1, scope: !716)
!734 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 85, type: !735, scopeLine: 85, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !737)
!735 = !DISubroutineType(types: !736)
!736 = !{!220, !247, !247}
!737 = !{!738, !739, !740, !741, !742, !743}
!738 = !DILocalVariable(name: "vdata", arg: 1, scope: !734, file: !189, line: 85, type: !247)
!739 = !DILocalVariable(name: "vref", arg: 2, scope: !734, file: !189, line: 85, type: !247)
!740 = !DILocalVariable(name: "data", scope: !734, file: !189, line: 86, type: !191)
!741 = !DILocalVariable(name: "ref", scope: !734, file: !189, line: 87, type: !191)
!742 = !DILocalVariable(name: "has_errors", scope: !734, file: !189, line: 88, type: !220)
!743 = !DILocalVariable(name: "i", scope: !734, file: !189, line: 89, type: !220)
!744 = !DILocation(line: 0, scope: !734)
!745 = !DILocation(line: 91, column: 3, scope: !746)
!746 = distinct !DILexicalBlock(scope: !734, file: !189, line: 91, column: 3)
!747 = !DILocation(line: 92, column: 20, scope: !748)
!748 = distinct !DILexicalBlock(scope: !749, file: !189, line: 91, column: 26)
!749 = distinct !DILexicalBlock(scope: !746, file: !189, line: 91, column: 3)
!750 = !DILocation(line: 92, column: 35, scope: !748)
!751 = !DILocation(line: 92, column: 33, scope: !748)
!752 = !DILocation(line: 92, column: 16, scope: !748)
!753 = !DILocation(line: 91, column: 22, scope: !749)
!754 = !DILocation(line: 91, column: 13, scope: !749)
!755 = distinct !{!755, !745, !756, !399, !400}
!756 = !DILocation(line: 93, column: 3, scope: !746)
!757 = !DILocation(line: 96, column: 10, scope: !734)
!758 = !DILocation(line: 96, column: 3, scope: !734)
!759 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !760, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !762)
!760 = !DISubroutineType(types: !761)
!761 = !{!246, !220}
!762 = !{!763, !764, !765, !802, !805, !808}
!763 = !DILocalVariable(name: "fd", arg: 1, scope: !759, file: !2, line: 34, type: !220)
!764 = !DILocalVariable(name: "p", scope: !759, file: !2, line: 35, type: !246)
!765 = !DILocalVariable(name: "s", scope: !759, file: !2, line: 36, type: !766)
!766 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !767, line: 44, size: 1024, elements: !768)
!767 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!768 = !{!769, !771, !773, !775, !777, !779, !781, !782, !783, !785, !787, !788, !790, !798, !799, !800}
!769 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !766, file: !767, line: 46, baseType: !770, size: 64)
!770 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !201, line: 145, baseType: !256)
!771 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !766, file: !767, line: 47, baseType: !772, size: 64, offset: 64)
!772 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !201, line: 148, baseType: !256)
!773 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !766, file: !767, line: 48, baseType: !774, size: 32, offset: 128)
!774 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !201, line: 150, baseType: !253)
!775 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !766, file: !767, line: 49, baseType: !776, size: 32, offset: 160)
!776 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !201, line: 151, baseType: !253)
!777 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !766, file: !767, line: 50, baseType: !778, size: 32, offset: 192)
!778 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !201, line: 146, baseType: !253)
!779 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !766, file: !767, line: 51, baseType: !780, size: 32, offset: 224)
!780 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !201, line: 147, baseType: !253)
!781 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !766, file: !767, line: 52, baseType: !770, size: 64, offset: 256)
!782 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !766, file: !767, line: 53, baseType: !770, size: 64, offset: 320)
!783 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !766, file: !767, line: 54, baseType: !784, size: 64, offset: 384)
!784 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !201, line: 152, baseType: !268)
!785 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !766, file: !767, line: 55, baseType: !786, size: 32, offset: 448)
!786 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !201, line: 175, baseType: !220)
!787 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !766, file: !767, line: 56, baseType: !220, size: 32, offset: 480)
!788 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !766, file: !767, line: 57, baseType: !789, size: 64, offset: 512)
!789 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !201, line: 180, baseType: !268)
!790 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !766, file: !767, line: 65, baseType: !791, size: 128, offset: 576)
!791 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !792, line: 11, size: 128, elements: !793)
!792 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!793 = !{!794, !796}
!794 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !791, file: !792, line: 16, baseType: !795, size: 64)
!795 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !201, line: 160, baseType: !268)
!796 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !791, file: !792, line: 21, baseType: !797, size: 64, offset: 64)
!797 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !201, line: 197, baseType: !268)
!798 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !766, file: !767, line: 66, baseType: !791, size: 128, offset: 704)
!799 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !766, file: !767, line: 67, baseType: !791, size: 128, offset: 832)
!800 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !766, file: !767, line: 79, baseType: !801, size: 64, offset: 960)
!801 = !DICompositeType(tag: DW_TAG_array_type, baseType: !220, size: 64, elements: !55)
!802 = !DILocalVariable(name: "len", scope: !759, file: !2, line: 37, type: !803)
!803 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !804, line: 85, baseType: !784)
!804 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!805 = !DILocalVariable(name: "bytes_read", scope: !759, file: !2, line: 38, type: !806)
!806 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !804, line: 108, baseType: !807)
!807 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !201, line: 194, baseType: !268)
!808 = !DILocalVariable(name: "status", scope: !759, file: !2, line: 38, type: !806)
!809 = distinct !DIAssignID()
!810 = !DILocation(line: 0, scope: !759)
!811 = !DILocation(line: 36, column: 3, scope: !759)
!812 = !DILocation(line: 40, column: 3, scope: !813)
!813 = distinct !DILexicalBlock(scope: !814, file: !2, line: 40, column: 3)
!814 = distinct !DILexicalBlock(scope: !759, file: !2, line: 40, column: 3)
!815 = !DILocation(line: 41, column: 3, scope: !816)
!816 = distinct !DILexicalBlock(scope: !817, file: !2, line: 41, column: 3)
!817 = distinct !DILexicalBlock(scope: !759, file: !2, line: 41, column: 3)
!818 = !DILocation(line: 42, column: 11, scope: !759)
!819 = !DILocation(line: 43, column: 3, scope: !820)
!820 = distinct !DILexicalBlock(scope: !821, file: !2, line: 43, column: 3)
!821 = distinct !DILexicalBlock(scope: !759, file: !2, line: 43, column: 3)
!822 = !DILocation(line: 44, column: 25, scope: !759)
!823 = !DILocation(line: 44, column: 15, scope: !759)
!824 = !DILocation(line: 46, column: 3, scope: !759)
!825 = !DILocation(line: 49, column: 15, scope: !826)
!826 = distinct !DILexicalBlock(scope: !759, file: !2, line: 46, column: 27)
!827 = !DILocation(line: 46, column: 20, scope: !759)
!828 = distinct !{!828, !824, !829, !399, !400}
!829 = !DILocation(line: 50, column: 3, scope: !759)
!830 = !DILocation(line: 47, column: 24, scope: !826)
!831 = !DILocation(line: 47, column: 42, scope: !826)
!832 = !DILocation(line: 47, column: 14, scope: !826)
!833 = !DILocation(line: 48, column: 5, scope: !834)
!834 = distinct !DILexicalBlock(scope: !835, file: !2, line: 48, column: 5)
!835 = distinct !DILexicalBlock(scope: !826, file: !2, line: 48, column: 5)
!836 = !DILocation(line: 51, column: 3, scope: !759)
!837 = !DILocation(line: 51, column: 10, scope: !759)
!838 = !DILocation(line: 52, column: 3, scope: !759)
!839 = !DILocation(line: 54, column: 1, scope: !759)
!840 = !DILocation(line: 53, column: 3, scope: !759)
!841 = !DISubprogram(name: "__assert_fail", scope: !842, file: !842, line: 67, type: !843, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!842 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!843 = !DISubroutineType(types: !844)
!844 = !{null, !845, !845, !253, !845}
!845 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!846 = !DISubprogram(name: "fstat", scope: !847, file: !847, line: 210, type: !848, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!847 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!848 = !DISubroutineType(types: !849)
!849 = !{!220, !220, !850}
!850 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !766, size: 64)
!851 = !DISubprogram(name: "malloc", scope: !605, file: !605, line: 672, type: !852, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!852 = !DISubroutineType(types: !853)
!853 = !{!247, !854}
!854 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !855, line: 18, baseType: !256)
!855 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!856 = !DISubprogram(name: "read", scope: !857, file: !857, line: 371, type: !858, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!857 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!858 = !DISubroutineType(types: !859)
!859 = !{!806, !220, !247, !854}
!860 = !DISubprogram(name: "close", scope: !857, file: !857, line: 358, type: !614, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!861 = !DILocation(line: 0, scope: !514)
!862 = !DILocation(line: 59, column: 3, scope: !863)
!863 = distinct !DILexicalBlock(scope: !864, file: !2, line: 59, column: 3)
!864 = distinct !DILexicalBlock(scope: !514, file: !2, line: 59, column: 3)
!865 = !DILocation(line: 60, column: 7, scope: !866)
!866 = distinct !DILexicalBlock(scope: !514, file: !2, line: 60, column: 6)
!867 = !DILocation(line: 60, column: 6, scope: !514)
!868 = !DILocation(line: 64, column: 17, scope: !514)
!869 = !DILocation(line: 64, column: 3, scope: !514)
!870 = !DILocation(line: 66, column: 22, scope: !525)
!871 = !DILocation(line: 66, column: 26, scope: !525)
!872 = !DILocation(line: 66, column: 32, scope: !525)
!873 = !DILocation(line: 66, column: 35, scope: !525)
!874 = !DILocation(line: 66, column: 39, scope: !525)
!875 = !DILocation(line: 66, column: 9, scope: !526)
!876 = !DILocation(line: 69, column: 6, scope: !526)
!877 = !DILocation(line: 64, column: 10, scope: !514)
!878 = !DILocation(line: 64, column: 13, scope: !514)
!879 = distinct !{!879, !869, !880, !399, !400}
!880 = !DILocation(line: 70, column: 3, scope: !514)
!881 = !DILocation(line: 71, column: 6, scope: !538)
!882 = !DILocation(line: 71, column: 8, scope: !538)
!883 = !DILocation(line: 71, column: 6, scope: !514)
!884 = !DILocation(line: 74, column: 1, scope: !514)
!885 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !886, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !888)
!886 = !DISubroutineType(types: !887)
!887 = !{!220, !246, !246, !220}
!888 = !{!889, !890, !891, !892}
!889 = !DILocalVariable(name: "s", arg: 1, scope: !885, file: !2, line: 77, type: !246)
!890 = !DILocalVariable(name: "arr", arg: 2, scope: !885, file: !2, line: 77, type: !246)
!891 = !DILocalVariable(name: "n", arg: 3, scope: !885, file: !2, line: 77, type: !220)
!892 = !DILocalVariable(name: "k", scope: !885, file: !2, line: 78, type: !220)
!893 = !DILocation(line: 0, scope: !885)
!894 = !DILocation(line: 79, column: 3, scope: !895)
!895 = distinct !DILexicalBlock(scope: !896, file: !2, line: 79, column: 3)
!896 = distinct !DILexicalBlock(scope: !885, file: !2, line: 79, column: 3)
!897 = !DILocation(line: 81, column: 8, scope: !898)
!898 = distinct !DILexicalBlock(scope: !885, file: !2, line: 81, column: 7)
!899 = !DILocation(line: 81, column: 7, scope: !885)
!900 = !DILocation(line: 83, column: 12, scope: !901)
!901 = distinct !DILexicalBlock(scope: !898, file: !2, line: 81, column: 13)
!902 = !DILocation(line: 83, column: 5, scope: !901)
!903 = !DILocation(line: 91, column: 19, scope: !885)
!904 = !DILocation(line: 91, column: 3, scope: !885)
!905 = !DILocation(line: 92, column: 7, scope: !885)
!906 = !DILocation(line: 83, column: 16, scope: !901)
!907 = !DILocation(line: 83, column: 26, scope: !901)
!908 = !DILocation(line: 83, column: 32, scope: !901)
!909 = !DILocation(line: 83, column: 29, scope: !901)
!910 = !DILocation(line: 83, column: 35, scope: !901)
!911 = !DILocation(line: 83, column: 45, scope: !901)
!912 = !DILocation(line: 83, column: 48, scope: !901)
!913 = !DILocation(line: 83, column: 54, scope: !901)
!914 = !DILocation(line: 84, column: 9, scope: !901)
!915 = !DILocation(line: 84, column: 18, scope: !901)
!916 = !DILocation(line: 84, column: 26, scope: !901)
!917 = distinct !{!917, !902, !918, !399, !400}
!918 = !DILocation(line: 86, column: 5, scope: !901)
!919 = !DILocation(line: 93, column: 5, scope: !920)
!920 = distinct !DILexicalBlock(scope: !885, file: !2, line: 92, column: 7)
!921 = !DILocation(line: 93, column: 12, scope: !920)
!922 = !DILocation(line: 95, column: 3, scope: !885)
!923 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !924, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !926)
!924 = !DISubroutineType(types: !925)
!925 = !{!220, !246, !627, !220}
!926 = !{!927, !928, !929, !930, !931, !932, !933}
!927 = !DILocalVariable(name: "s", arg: 1, scope: !923, file: !2, line: 132, type: !246)
!928 = !DILocalVariable(name: "arr", arg: 2, scope: !923, file: !2, line: 132, type: !627)
!929 = !DILocalVariable(name: "n", arg: 3, scope: !923, file: !2, line: 132, type: !220)
!930 = !DILocalVariable(name: "line", scope: !923, file: !2, line: 132, type: !246)
!931 = !DILocalVariable(name: "endptr", scope: !923, file: !2, line: 132, type: !246)
!932 = !DILocalVariable(name: "i", scope: !923, file: !2, line: 132, type: !220)
!933 = !DILocalVariable(name: "v", scope: !923, file: !2, line: 132, type: !198)
!934 = distinct !DIAssignID()
!935 = !DILocation(line: 0, scope: !923)
!936 = !DILocation(line: 132, column: 1, scope: !923)
!937 = !DILocation(line: 132, column: 1, scope: !938)
!938 = distinct !DILexicalBlock(scope: !939, file: !2, line: 132, column: 1)
!939 = distinct !DILexicalBlock(scope: !923, file: !2, line: 132, column: 1)
!940 = !DILocation(line: 132, column: 1, scope: !941)
!941 = distinct !DILexicalBlock(scope: !923, file: !2, line: 132, column: 1)
!942 = !{!943, !943, i64 0}
!943 = !{!"any pointer", !381, i64 0}
!944 = distinct !DIAssignID()
!945 = !DILocation(line: 132, column: 1, scope: !946)
!946 = distinct !DILexicalBlock(scope: !941, file: !2, line: 132, column: 1)
!947 = !DILocation(line: 132, column: 1, scope: !948)
!948 = distinct !DILexicalBlock(scope: !946, file: !2, line: 132, column: 1)
!949 = distinct !{!949, !936, !936, !399, !400}
!950 = !DILocation(line: 132, column: 1, scope: !951)
!951 = distinct !DILexicalBlock(scope: !952, file: !2, line: 132, column: 1)
!952 = distinct !DILexicalBlock(scope: !923, file: !2, line: 132, column: 1)
!953 = !DISubprogram(name: "strtok", scope: !954, file: !954, line: 356, type: !955, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!954 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!955 = !DISubroutineType(types: !956)
!956 = !{!246, !957, !958}
!957 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !246)
!958 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !845)
!959 = !DISubprogram(name: "strtol", scope: !605, file: !605, line: 177, type: !960, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!960 = !DISubroutineType(types: !961)
!961 = !{!268, !958, !962, !220}
!962 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !963)
!963 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !246, size: 64)
!964 = !DISubprogram(name: "fprintf", scope: !965, file: !965, line: 357, type: !966, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!965 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!966 = !DISubroutineType(types: !967)
!967 = !{!220, !968, !958, null}
!968 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !969)
!969 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !970, size: 64)
!970 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !971, line: 7, baseType: !972)
!971 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!972 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !973, line: 49, size: 1728, elements: !974)
!973 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!974 = !{!975, !976, !977, !978, !979, !980, !981, !982, !983, !984, !985, !986, !987, !990, !992, !993, !994, !995, !996, !997, !1001, !1004, !1006, !1009, !1012, !1013, !1014, !1016, !1017}
!975 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !972, file: !973, line: 51, baseType: !220, size: 32)
!976 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !972, file: !973, line: 54, baseType: !246, size: 64, offset: 64)
!977 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !972, file: !973, line: 55, baseType: !246, size: 64, offset: 128)
!978 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !972, file: !973, line: 56, baseType: !246, size: 64, offset: 192)
!979 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !972, file: !973, line: 57, baseType: !246, size: 64, offset: 256)
!980 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !972, file: !973, line: 58, baseType: !246, size: 64, offset: 320)
!981 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !972, file: !973, line: 59, baseType: !246, size: 64, offset: 384)
!982 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !972, file: !973, line: 60, baseType: !246, size: 64, offset: 448)
!983 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !972, file: !973, line: 61, baseType: !246, size: 64, offset: 512)
!984 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !972, file: !973, line: 64, baseType: !246, size: 64, offset: 576)
!985 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !972, file: !973, line: 65, baseType: !246, size: 64, offset: 640)
!986 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !972, file: !973, line: 66, baseType: !246, size: 64, offset: 704)
!987 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !972, file: !973, line: 68, baseType: !988, size: 64, offset: 768)
!988 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !989, size: 64)
!989 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !973, line: 36, flags: DIFlagFwdDecl)
!990 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !972, file: !973, line: 70, baseType: !991, size: 64, offset: 832)
!991 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !972, size: 64)
!992 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !972, file: !973, line: 72, baseType: !220, size: 32, offset: 896)
!993 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !972, file: !973, line: 73, baseType: !220, size: 32, offset: 928)
!994 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !972, file: !973, line: 74, baseType: !784, size: 64, offset: 960)
!995 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !972, file: !973, line: 77, baseType: !250, size: 16, offset: 1024)
!996 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !972, file: !973, line: 78, baseType: !260, size: 8, offset: 1040)
!997 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !972, file: !973, line: 79, baseType: !998, size: 8, offset: 1048)
!998 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !999)
!999 = !{!1000}
!1000 = !DISubrange(count: 1)
!1001 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !972, file: !973, line: 81, baseType: !1002, size: 64, offset: 1088)
!1002 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1003, size: 64)
!1003 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !973, line: 43, baseType: null)
!1004 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !972, file: !973, line: 89, baseType: !1005, size: 64, offset: 1152)
!1005 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !201, line: 153, baseType: !268)
!1006 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !972, file: !973, line: 91, baseType: !1007, size: 64, offset: 1216)
!1007 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1008, size: 64)
!1008 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !973, line: 37, flags: DIFlagFwdDecl)
!1009 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !972, file: !973, line: 92, baseType: !1010, size: 64, offset: 1280)
!1010 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1011, size: 64)
!1011 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !973, line: 38, flags: DIFlagFwdDecl)
!1012 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !972, file: !973, line: 93, baseType: !991, size: 64, offset: 1344)
!1013 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !972, file: !973, line: 94, baseType: !247, size: 64, offset: 1408)
!1014 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !972, file: !973, line: 95, baseType: !1015, size: 64, offset: 1472)
!1015 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !991, size: 64)
!1016 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !972, file: !973, line: 96, baseType: !220, size: 32, offset: 1536)
!1017 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !972, file: !973, line: 98, baseType: !1018, size: 160, offset: 1568)
!1018 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!1019 = !DISubprogram(name: "strlen", scope: !954, file: !954, line: 407, type: !1020, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1020 = !DISubroutineType(types: !1021)
!1021 = !{!256, !845}
!1022 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !1023, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1026)
!1023 = !DISubroutineType(types: !1024)
!1024 = !{!220, !246, !1025, !220}
!1025 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !248, size: 64)
!1026 = !{!1027, !1028, !1029, !1030, !1031, !1032, !1033}
!1027 = !DILocalVariable(name: "s", arg: 1, scope: !1022, file: !2, line: 133, type: !246)
!1028 = !DILocalVariable(name: "arr", arg: 2, scope: !1022, file: !2, line: 133, type: !1025)
!1029 = !DILocalVariable(name: "n", arg: 3, scope: !1022, file: !2, line: 133, type: !220)
!1030 = !DILocalVariable(name: "line", scope: !1022, file: !2, line: 133, type: !246)
!1031 = !DILocalVariable(name: "endptr", scope: !1022, file: !2, line: 133, type: !246)
!1032 = !DILocalVariable(name: "i", scope: !1022, file: !2, line: 133, type: !220)
!1033 = !DILocalVariable(name: "v", scope: !1022, file: !2, line: 133, type: !248)
!1034 = distinct !DIAssignID()
!1035 = !DILocation(line: 0, scope: !1022)
!1036 = !DILocation(line: 133, column: 1, scope: !1022)
!1037 = !DILocation(line: 133, column: 1, scope: !1038)
!1038 = distinct !DILexicalBlock(scope: !1039, file: !2, line: 133, column: 1)
!1039 = distinct !DILexicalBlock(scope: !1022, file: !2, line: 133, column: 1)
!1040 = !DILocation(line: 133, column: 1, scope: !1041)
!1041 = distinct !DILexicalBlock(scope: !1022, file: !2, line: 133, column: 1)
!1042 = distinct !DIAssignID()
!1043 = !DILocation(line: 133, column: 1, scope: !1044)
!1044 = distinct !DILexicalBlock(scope: !1041, file: !2, line: 133, column: 1)
!1045 = !DILocation(line: 133, column: 1, scope: !1046)
!1046 = distinct !DILexicalBlock(scope: !1044, file: !2, line: 133, column: 1)
!1047 = !{!1048, !1048, i64 0}
!1048 = !{!"short", !381, i64 0}
!1049 = distinct !{!1049, !1036, !1036, !399, !400}
!1050 = !DILocation(line: 133, column: 1, scope: !1051)
!1051 = distinct !DILexicalBlock(scope: !1052, file: !2, line: 133, column: 1)
!1052 = distinct !DILexicalBlock(scope: !1022, file: !2, line: 133, column: 1)
!1053 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !1054, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1057)
!1054 = !DISubroutineType(types: !1055)
!1055 = !{!220, !246, !1056, !220}
!1056 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !251, size: 64)
!1057 = !{!1058, !1059, !1060, !1061, !1062, !1063, !1064}
!1058 = !DILocalVariable(name: "s", arg: 1, scope: !1053, file: !2, line: 134, type: !246)
!1059 = !DILocalVariable(name: "arr", arg: 2, scope: !1053, file: !2, line: 134, type: !1056)
!1060 = !DILocalVariable(name: "n", arg: 3, scope: !1053, file: !2, line: 134, type: !220)
!1061 = !DILocalVariable(name: "line", scope: !1053, file: !2, line: 134, type: !246)
!1062 = !DILocalVariable(name: "endptr", scope: !1053, file: !2, line: 134, type: !246)
!1063 = !DILocalVariable(name: "i", scope: !1053, file: !2, line: 134, type: !220)
!1064 = !DILocalVariable(name: "v", scope: !1053, file: !2, line: 134, type: !251)
!1065 = distinct !DIAssignID()
!1066 = !DILocation(line: 0, scope: !1053)
!1067 = !DILocation(line: 134, column: 1, scope: !1053)
!1068 = !DILocation(line: 134, column: 1, scope: !1069)
!1069 = distinct !DILexicalBlock(scope: !1070, file: !2, line: 134, column: 1)
!1070 = distinct !DILexicalBlock(scope: !1053, file: !2, line: 134, column: 1)
!1071 = !DILocation(line: 134, column: 1, scope: !1072)
!1072 = distinct !DILexicalBlock(scope: !1053, file: !2, line: 134, column: 1)
!1073 = distinct !DIAssignID()
!1074 = !DILocation(line: 134, column: 1, scope: !1075)
!1075 = distinct !DILexicalBlock(scope: !1072, file: !2, line: 134, column: 1)
!1076 = !DILocation(line: 134, column: 1, scope: !1077)
!1077 = distinct !DILexicalBlock(scope: !1075, file: !2, line: 134, column: 1)
!1078 = !{!1079, !1079, i64 0}
!1079 = !{!"int", !381, i64 0}
!1080 = distinct !{!1080, !1067, !1067, !399, !400}
!1081 = !DILocation(line: 134, column: 1, scope: !1082)
!1082 = distinct !DILexicalBlock(scope: !1083, file: !2, line: 134, column: 1)
!1083 = distinct !DILexicalBlock(scope: !1053, file: !2, line: 134, column: 1)
!1084 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !1085, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1088)
!1085 = !DISubroutineType(types: !1086)
!1086 = !{!220, !246, !1087, !220}
!1087 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 64)
!1088 = !{!1089, !1090, !1091, !1092, !1093, !1094, !1095}
!1089 = !DILocalVariable(name: "s", arg: 1, scope: !1084, file: !2, line: 135, type: !246)
!1090 = !DILocalVariable(name: "arr", arg: 2, scope: !1084, file: !2, line: 135, type: !1087)
!1091 = !DILocalVariable(name: "n", arg: 3, scope: !1084, file: !2, line: 135, type: !220)
!1092 = !DILocalVariable(name: "line", scope: !1084, file: !2, line: 135, type: !246)
!1093 = !DILocalVariable(name: "endptr", scope: !1084, file: !2, line: 135, type: !246)
!1094 = !DILocalVariable(name: "i", scope: !1084, file: !2, line: 135, type: !220)
!1095 = !DILocalVariable(name: "v", scope: !1084, file: !2, line: 135, type: !254)
!1096 = distinct !DIAssignID()
!1097 = !DILocation(line: 0, scope: !1084)
!1098 = !DILocation(line: 135, column: 1, scope: !1084)
!1099 = !DILocation(line: 135, column: 1, scope: !1100)
!1100 = distinct !DILexicalBlock(scope: !1101, file: !2, line: 135, column: 1)
!1101 = distinct !DILexicalBlock(scope: !1084, file: !2, line: 135, column: 1)
!1102 = !DILocation(line: 135, column: 1, scope: !1103)
!1103 = distinct !DILexicalBlock(scope: !1084, file: !2, line: 135, column: 1)
!1104 = distinct !DIAssignID()
!1105 = !DILocation(line: 135, column: 1, scope: !1106)
!1106 = distinct !DILexicalBlock(scope: !1103, file: !2, line: 135, column: 1)
!1107 = !DILocation(line: 135, column: 1, scope: !1108)
!1108 = distinct !DILexicalBlock(scope: !1106, file: !2, line: 135, column: 1)
!1109 = !{!1110, !1110, i64 0}
!1110 = !{!"long", !381, i64 0}
!1111 = distinct !{!1111, !1098, !1098, !399, !400}
!1112 = !DILocation(line: 135, column: 1, scope: !1113)
!1113 = distinct !DILexicalBlock(scope: !1114, file: !2, line: 135, column: 1)
!1114 = distinct !DILexicalBlock(scope: !1084, file: !2, line: 135, column: 1)
!1115 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1116, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1119)
!1116 = !DISubroutineType(types: !1117)
!1117 = !{!220, !246, !1118, !220}
!1118 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !257, size: 64)
!1119 = !{!1120, !1121, !1122, !1123, !1124, !1125, !1126}
!1120 = !DILocalVariable(name: "s", arg: 1, scope: !1115, file: !2, line: 136, type: !246)
!1121 = !DILocalVariable(name: "arr", arg: 2, scope: !1115, file: !2, line: 136, type: !1118)
!1122 = !DILocalVariable(name: "n", arg: 3, scope: !1115, file: !2, line: 136, type: !220)
!1123 = !DILocalVariable(name: "line", scope: !1115, file: !2, line: 136, type: !246)
!1124 = !DILocalVariable(name: "endptr", scope: !1115, file: !2, line: 136, type: !246)
!1125 = !DILocalVariable(name: "i", scope: !1115, file: !2, line: 136, type: !220)
!1126 = !DILocalVariable(name: "v", scope: !1115, file: !2, line: 136, type: !257)
!1127 = distinct !DIAssignID()
!1128 = !DILocation(line: 0, scope: !1115)
!1129 = !DILocation(line: 136, column: 1, scope: !1115)
!1130 = !DILocation(line: 136, column: 1, scope: !1131)
!1131 = distinct !DILexicalBlock(scope: !1132, file: !2, line: 136, column: 1)
!1132 = distinct !DILexicalBlock(scope: !1115, file: !2, line: 136, column: 1)
!1133 = !DILocation(line: 136, column: 1, scope: !1134)
!1134 = distinct !DILexicalBlock(scope: !1115, file: !2, line: 136, column: 1)
!1135 = distinct !DIAssignID()
!1136 = !DILocation(line: 136, column: 1, scope: !1137)
!1137 = distinct !DILexicalBlock(scope: !1134, file: !2, line: 136, column: 1)
!1138 = !DILocation(line: 136, column: 1, scope: !1139)
!1139 = distinct !DILexicalBlock(scope: !1137, file: !2, line: 136, column: 1)
!1140 = distinct !{!1140, !1129, !1129, !399, !400}
!1141 = !DILocation(line: 136, column: 1, scope: !1142)
!1142 = distinct !DILexicalBlock(scope: !1143, file: !2, line: 136, column: 1)
!1143 = distinct !DILexicalBlock(scope: !1115, file: !2, line: 136, column: 1)
!1144 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1145, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1148)
!1145 = !DISubroutineType(types: !1146)
!1146 = !{!220, !246, !1147, !220}
!1147 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !261, size: 64)
!1148 = !{!1149, !1150, !1151, !1152, !1153, !1154, !1155}
!1149 = !DILocalVariable(name: "s", arg: 1, scope: !1144, file: !2, line: 137, type: !246)
!1150 = !DILocalVariable(name: "arr", arg: 2, scope: !1144, file: !2, line: 137, type: !1147)
!1151 = !DILocalVariable(name: "n", arg: 3, scope: !1144, file: !2, line: 137, type: !220)
!1152 = !DILocalVariable(name: "line", scope: !1144, file: !2, line: 137, type: !246)
!1153 = !DILocalVariable(name: "endptr", scope: !1144, file: !2, line: 137, type: !246)
!1154 = !DILocalVariable(name: "i", scope: !1144, file: !2, line: 137, type: !220)
!1155 = !DILocalVariable(name: "v", scope: !1144, file: !2, line: 137, type: !261)
!1156 = distinct !DIAssignID()
!1157 = !DILocation(line: 0, scope: !1144)
!1158 = !DILocation(line: 137, column: 1, scope: !1144)
!1159 = !DILocation(line: 137, column: 1, scope: !1160)
!1160 = distinct !DILexicalBlock(scope: !1161, file: !2, line: 137, column: 1)
!1161 = distinct !DILexicalBlock(scope: !1144, file: !2, line: 137, column: 1)
!1162 = !DILocation(line: 137, column: 1, scope: !1163)
!1163 = distinct !DILexicalBlock(scope: !1144, file: !2, line: 137, column: 1)
!1164 = distinct !DIAssignID()
!1165 = !DILocation(line: 137, column: 1, scope: !1166)
!1166 = distinct !DILexicalBlock(scope: !1163, file: !2, line: 137, column: 1)
!1167 = !DILocation(line: 137, column: 1, scope: !1168)
!1168 = distinct !DILexicalBlock(scope: !1166, file: !2, line: 137, column: 1)
!1169 = distinct !{!1169, !1158, !1158, !399, !400}
!1170 = !DILocation(line: 137, column: 1, scope: !1171)
!1171 = distinct !DILexicalBlock(scope: !1172, file: !2, line: 137, column: 1)
!1172 = distinct !DILexicalBlock(scope: !1144, file: !2, line: 137, column: 1)
!1173 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1174, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1177)
!1174 = !DISubroutineType(types: !1175)
!1175 = !{!220, !246, !1176, !220}
!1176 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !264, size: 64)
!1177 = !{!1178, !1179, !1180, !1181, !1182, !1183, !1184}
!1178 = !DILocalVariable(name: "s", arg: 1, scope: !1173, file: !2, line: 138, type: !246)
!1179 = !DILocalVariable(name: "arr", arg: 2, scope: !1173, file: !2, line: 138, type: !1176)
!1180 = !DILocalVariable(name: "n", arg: 3, scope: !1173, file: !2, line: 138, type: !220)
!1181 = !DILocalVariable(name: "line", scope: !1173, file: !2, line: 138, type: !246)
!1182 = !DILocalVariable(name: "endptr", scope: !1173, file: !2, line: 138, type: !246)
!1183 = !DILocalVariable(name: "i", scope: !1173, file: !2, line: 138, type: !220)
!1184 = !DILocalVariable(name: "v", scope: !1173, file: !2, line: 138, type: !264)
!1185 = distinct !DIAssignID()
!1186 = !DILocation(line: 0, scope: !1173)
!1187 = !DILocation(line: 138, column: 1, scope: !1173)
!1188 = !DILocation(line: 138, column: 1, scope: !1189)
!1189 = distinct !DILexicalBlock(scope: !1190, file: !2, line: 138, column: 1)
!1190 = distinct !DILexicalBlock(scope: !1173, file: !2, line: 138, column: 1)
!1191 = !DILocation(line: 138, column: 1, scope: !1192)
!1192 = distinct !DILexicalBlock(scope: !1173, file: !2, line: 138, column: 1)
!1193 = distinct !DIAssignID()
!1194 = !DILocation(line: 138, column: 1, scope: !1195)
!1195 = distinct !DILexicalBlock(scope: !1192, file: !2, line: 138, column: 1)
!1196 = !DILocation(line: 138, column: 1, scope: !1197)
!1197 = distinct !DILexicalBlock(scope: !1195, file: !2, line: 138, column: 1)
!1198 = distinct !{!1198, !1187, !1187, !399, !400}
!1199 = !DILocation(line: 138, column: 1, scope: !1200)
!1200 = distinct !DILexicalBlock(scope: !1201, file: !2, line: 138, column: 1)
!1201 = distinct !DILexicalBlock(scope: !1173, file: !2, line: 138, column: 1)
!1202 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1203, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1206)
!1203 = !DISubroutineType(types: !1204)
!1204 = !{!220, !246, !1205, !220}
!1205 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !266, size: 64)
!1206 = !{!1207, !1208, !1209, !1210, !1211, !1212, !1213}
!1207 = !DILocalVariable(name: "s", arg: 1, scope: !1202, file: !2, line: 139, type: !246)
!1208 = !DILocalVariable(name: "arr", arg: 2, scope: !1202, file: !2, line: 139, type: !1205)
!1209 = !DILocalVariable(name: "n", arg: 3, scope: !1202, file: !2, line: 139, type: !220)
!1210 = !DILocalVariable(name: "line", scope: !1202, file: !2, line: 139, type: !246)
!1211 = !DILocalVariable(name: "endptr", scope: !1202, file: !2, line: 139, type: !246)
!1212 = !DILocalVariable(name: "i", scope: !1202, file: !2, line: 139, type: !220)
!1213 = !DILocalVariable(name: "v", scope: !1202, file: !2, line: 139, type: !266)
!1214 = distinct !DIAssignID()
!1215 = !DILocation(line: 0, scope: !1202)
!1216 = !DILocation(line: 139, column: 1, scope: !1202)
!1217 = !DILocation(line: 139, column: 1, scope: !1218)
!1218 = distinct !DILexicalBlock(scope: !1219, file: !2, line: 139, column: 1)
!1219 = distinct !DILexicalBlock(scope: !1202, file: !2, line: 139, column: 1)
!1220 = !DILocation(line: 139, column: 1, scope: !1221)
!1221 = distinct !DILexicalBlock(scope: !1202, file: !2, line: 139, column: 1)
!1222 = distinct !DIAssignID()
!1223 = !DILocation(line: 139, column: 1, scope: !1224)
!1224 = distinct !DILexicalBlock(scope: !1221, file: !2, line: 139, column: 1)
!1225 = !DILocation(line: 139, column: 1, scope: !1226)
!1226 = distinct !DILexicalBlock(scope: !1224, file: !2, line: 139, column: 1)
!1227 = distinct !{!1227, !1216, !1216, !399, !400}
!1228 = !DILocation(line: 139, column: 1, scope: !1229)
!1229 = distinct !DILexicalBlock(scope: !1230, file: !2, line: 139, column: 1)
!1230 = distinct !DILexicalBlock(scope: !1202, file: !2, line: 139, column: 1)
!1231 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1232, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1235)
!1232 = !DISubroutineType(types: !1233)
!1233 = !{!220, !246, !1234, !220}
!1234 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !269, size: 64)
!1235 = !{!1236, !1237, !1238, !1239, !1240, !1241, !1242}
!1236 = !DILocalVariable(name: "s", arg: 1, scope: !1231, file: !2, line: 141, type: !246)
!1237 = !DILocalVariable(name: "arr", arg: 2, scope: !1231, file: !2, line: 141, type: !1234)
!1238 = !DILocalVariable(name: "n", arg: 3, scope: !1231, file: !2, line: 141, type: !220)
!1239 = !DILocalVariable(name: "line", scope: !1231, file: !2, line: 141, type: !246)
!1240 = !DILocalVariable(name: "endptr", scope: !1231, file: !2, line: 141, type: !246)
!1241 = !DILocalVariable(name: "i", scope: !1231, file: !2, line: 141, type: !220)
!1242 = !DILocalVariable(name: "v", scope: !1231, file: !2, line: 141, type: !269)
!1243 = distinct !DIAssignID()
!1244 = !DILocation(line: 0, scope: !1231)
!1245 = !DILocation(line: 141, column: 1, scope: !1231)
!1246 = !DILocation(line: 141, column: 1, scope: !1247)
!1247 = distinct !DILexicalBlock(scope: !1248, file: !2, line: 141, column: 1)
!1248 = distinct !DILexicalBlock(scope: !1231, file: !2, line: 141, column: 1)
!1249 = !DILocation(line: 141, column: 1, scope: !1250)
!1250 = distinct !DILexicalBlock(scope: !1231, file: !2, line: 141, column: 1)
!1251 = distinct !DIAssignID()
!1252 = !DILocation(line: 141, column: 1, scope: !1253)
!1253 = distinct !DILexicalBlock(scope: !1250, file: !2, line: 141, column: 1)
!1254 = !DILocation(line: 141, column: 1, scope: !1255)
!1255 = distinct !DILexicalBlock(scope: !1253, file: !2, line: 141, column: 1)
!1256 = !{!1257, !1257, i64 0}
!1257 = !{!"float", !381, i64 0}
!1258 = distinct !{!1258, !1245, !1245, !399, !400}
!1259 = !DILocation(line: 141, column: 1, scope: !1260)
!1260 = distinct !DILexicalBlock(scope: !1261, file: !2, line: 141, column: 1)
!1261 = distinct !DILexicalBlock(scope: !1231, file: !2, line: 141, column: 1)
!1262 = !DISubprogram(name: "strtof", scope: !605, file: !605, line: 124, type: !1263, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1263 = !DISubroutineType(types: !1264)
!1264 = !{!269, !958, !962}
!1265 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1266, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1268)
!1266 = !DISubroutineType(types: !1267)
!1267 = !{!220, !246, !649, !220}
!1268 = !{!1269, !1270, !1271, !1272, !1273, !1274, !1275}
!1269 = !DILocalVariable(name: "s", arg: 1, scope: !1265, file: !2, line: 142, type: !246)
!1270 = !DILocalVariable(name: "arr", arg: 2, scope: !1265, file: !2, line: 142, type: !649)
!1271 = !DILocalVariable(name: "n", arg: 3, scope: !1265, file: !2, line: 142, type: !220)
!1272 = !DILocalVariable(name: "line", scope: !1265, file: !2, line: 142, type: !246)
!1273 = !DILocalVariable(name: "endptr", scope: !1265, file: !2, line: 142, type: !246)
!1274 = !DILocalVariable(name: "i", scope: !1265, file: !2, line: 142, type: !220)
!1275 = !DILocalVariable(name: "v", scope: !1265, file: !2, line: 142, type: !208)
!1276 = distinct !DIAssignID()
!1277 = !DILocation(line: 0, scope: !1265)
!1278 = !DILocation(line: 142, column: 1, scope: !1265)
!1279 = !DILocation(line: 142, column: 1, scope: !1280)
!1280 = distinct !DILexicalBlock(scope: !1281, file: !2, line: 142, column: 1)
!1281 = distinct !DILexicalBlock(scope: !1265, file: !2, line: 142, column: 1)
!1282 = !DILocation(line: 142, column: 1, scope: !1283)
!1283 = distinct !DILexicalBlock(scope: !1265, file: !2, line: 142, column: 1)
!1284 = distinct !DIAssignID()
!1285 = !DILocation(line: 142, column: 1, scope: !1286)
!1286 = distinct !DILexicalBlock(scope: !1283, file: !2, line: 142, column: 1)
!1287 = !DILocation(line: 142, column: 1, scope: !1288)
!1288 = distinct !DILexicalBlock(scope: !1286, file: !2, line: 142, column: 1)
!1289 = distinct !{!1289, !1278, !1278, !399, !400}
!1290 = !DILocation(line: 142, column: 1, scope: !1291)
!1291 = distinct !DILexicalBlock(scope: !1292, file: !2, line: 142, column: 1)
!1292 = distinct !DILexicalBlock(scope: !1265, file: !2, line: 142, column: 1)
!1293 = !DISubprogram(name: "strtod", scope: !605, file: !605, line: 118, type: !1294, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1294 = !DISubroutineType(types: !1295)
!1295 = !{!208, !958, !962}
!1296 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1297, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1299)
!1297 = !DISubroutineType(types: !1298)
!1298 = !{!220, !220, !246, !220}
!1299 = !{!1300, !1301, !1302, !1303, !1304}
!1300 = !DILocalVariable(name: "fd", arg: 1, scope: !1296, file: !2, line: 145, type: !220)
!1301 = !DILocalVariable(name: "arr", arg: 2, scope: !1296, file: !2, line: 145, type: !246)
!1302 = !DILocalVariable(name: "n", arg: 3, scope: !1296, file: !2, line: 145, type: !220)
!1303 = !DILocalVariable(name: "status", scope: !1296, file: !2, line: 146, type: !220)
!1304 = !DILocalVariable(name: "written", scope: !1296, file: !2, line: 146, type: !220)
!1305 = !DILocation(line: 0, scope: !1296)
!1306 = !DILocation(line: 147, column: 3, scope: !1307)
!1307 = distinct !DILexicalBlock(scope: !1308, file: !2, line: 147, column: 3)
!1308 = distinct !DILexicalBlock(scope: !1296, file: !2, line: 147, column: 3)
!1309 = !DILocation(line: 148, column: 8, scope: !1310)
!1310 = distinct !DILexicalBlock(scope: !1296, file: !2, line: 148, column: 7)
!1311 = !DILocation(line: 148, column: 7, scope: !1296)
!1312 = !DILocation(line: 149, column: 9, scope: !1313)
!1313 = distinct !DILexicalBlock(scope: !1310, file: !2, line: 148, column: 13)
!1314 = !DILocation(line: 150, column: 3, scope: !1313)
!1315 = !DILocation(line: 152, column: 16, scope: !1296)
!1316 = !DILocation(line: 152, column: 3, scope: !1296)
!1317 = !DILocation(line: 158, column: 3, scope: !1296)
!1318 = !DILocation(line: 155, column: 13, scope: !1319)
!1319 = distinct !DILexicalBlock(scope: !1296, file: !2, line: 152, column: 20)
!1320 = distinct !{!1320, !1316, !1321, !399, !400}
!1321 = !DILocation(line: 156, column: 3, scope: !1296)
!1322 = !DILocation(line: 153, column: 25, scope: !1319)
!1323 = !DILocation(line: 153, column: 40, scope: !1319)
!1324 = !DILocation(line: 153, column: 39, scope: !1319)
!1325 = !DILocation(line: 153, column: 14, scope: !1319)
!1326 = !DILocation(line: 154, column: 5, scope: !1327)
!1327 = distinct !DILexicalBlock(scope: !1328, file: !2, line: 154, column: 5)
!1328 = distinct !DILexicalBlock(scope: !1319, file: !2, line: 154, column: 5)
!1329 = !DILocation(line: 159, column: 14, scope: !1330)
!1330 = distinct !DILexicalBlock(scope: !1296, file: !2, line: 158, column: 6)
!1331 = !DILocation(line: 160, column: 5, scope: !1332)
!1332 = distinct !DILexicalBlock(scope: !1333, file: !2, line: 160, column: 5)
!1333 = distinct !DILexicalBlock(scope: !1330, file: !2, line: 160, column: 5)
!1334 = !DILocation(line: 161, column: 17, scope: !1296)
!1335 = !DILocation(line: 161, column: 3, scope: !1330)
!1336 = distinct !{!1336, !1317, !1337, !399, !400}
!1337 = !DILocation(line: 161, column: 20, scope: !1296)
!1338 = !DILocation(line: 163, column: 3, scope: !1296)
!1339 = !DISubprogram(name: "write", scope: !857, file: !857, line: 378, type: !1340, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1340 = !DISubroutineType(types: !1341)
!1341 = !{!806, !220, !1342, !854}
!1342 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1343, size: 64)
!1343 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1344 = !DILocation(line: 0, scope: !624)
!1345 = !DILocation(line: 177, column: 1, scope: !1346)
!1346 = distinct !DILexicalBlock(scope: !1347, file: !2, line: 177, column: 1)
!1347 = distinct !DILexicalBlock(scope: !624, file: !2, line: 177, column: 1)
!1348 = !DILocation(line: 177, column: 1, scope: !638)
!1349 = !DILocation(line: 177, column: 1, scope: !635)
!1350 = !DILocation(line: 177, column: 1, scope: !637)
!1351 = distinct !{!1351, !1349, !1349, !399, !400}
!1352 = !DILocation(line: 177, column: 1, scope: !624)
!1353 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1354, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1356)
!1354 = !DISubroutineType(cc: DW_CC_nocall, types: !1355)
!1355 = !{!220, !220, !845, null}
!1356 = !{!1357, !1358, !1359, !1363, !1364, !1365, !1366}
!1357 = !DILocalVariable(name: "fd", arg: 1, scope: !1353, file: !2, line: 15, type: !220)
!1358 = !DILocalVariable(name: "format", arg: 2, scope: !1353, file: !2, line: 15, type: !845)
!1359 = !DILocalVariable(name: "args", scope: !1353, file: !2, line: 16, type: !1360)
!1360 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1361, line: 12, baseType: !1362)
!1361 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1362 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !247)
!1363 = !DILocalVariable(name: "buffered", scope: !1353, file: !2, line: 17, type: !220)
!1364 = !DILocalVariable(name: "written", scope: !1353, file: !2, line: 17, type: !220)
!1365 = !DILocalVariable(name: "status", scope: !1353, file: !2, line: 17, type: !220)
!1366 = !DILocalVariable(name: "buffer", scope: !1353, file: !2, line: 18, type: !1367)
!1367 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !1368)
!1368 = !{!1369}
!1369 = !DISubrange(count: 256)
!1370 = distinct !DIAssignID()
!1371 = !DILocation(line: 0, scope: !1353)
!1372 = distinct !DIAssignID()
!1373 = !DILocation(line: 16, column: 3, scope: !1353)
!1374 = !DILocation(line: 18, column: 3, scope: !1353)
!1375 = !DILocation(line: 19, column: 3, scope: !1353)
!1376 = !DILocation(line: 20, column: 66, scope: !1353)
!1377 = !DILocation(line: 20, column: 14, scope: !1353)
!1378 = !DILocation(line: 21, column: 3, scope: !1353)
!1379 = !DILocation(line: 22, column: 3, scope: !1380)
!1380 = distinct !DILexicalBlock(scope: !1381, file: !2, line: 22, column: 3)
!1381 = distinct !DILexicalBlock(scope: !1353, file: !2, line: 22, column: 3)
!1382 = !DILocation(line: 24, column: 16, scope: !1353)
!1383 = !DILocation(line: 24, column: 3, scope: !1353)
!1384 = !DILocation(line: 27, column: 13, scope: !1385)
!1385 = distinct !DILexicalBlock(scope: !1353, file: !2, line: 24, column: 27)
!1386 = distinct !{!1386, !1383, !1387, !399, !400}
!1387 = !DILocation(line: 28, column: 3, scope: !1353)
!1388 = !DILocation(line: 25, column: 25, scope: !1385)
!1389 = !DILocation(line: 25, column: 50, scope: !1385)
!1390 = !DILocation(line: 25, column: 42, scope: !1385)
!1391 = !DILocation(line: 25, column: 14, scope: !1385)
!1392 = !DILocation(line: 26, column: 5, scope: !1393)
!1393 = distinct !DILexicalBlock(scope: !1394, file: !2, line: 26, column: 5)
!1394 = distinct !DILexicalBlock(scope: !1385, file: !2, line: 26, column: 5)
!1395 = !DILocation(line: 29, column: 3, scope: !1396)
!1396 = distinct !DILexicalBlock(scope: !1397, file: !2, line: 29, column: 3)
!1397 = distinct !DILexicalBlock(scope: !1353, file: !2, line: 29, column: 3)
!1398 = !DILocation(line: 31, column: 1, scope: !1353)
!1399 = !DILocation(line: 30, column: 3, scope: !1353)
!1400 = !DISubprogram(name: "vsnprintf", scope: !965, file: !965, line: 389, type: !1401, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1401 = !DISubroutineType(types: !1402)
!1402 = !{!220, !957, !854, !958, !1403}
!1403 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1404, line: 12, baseType: !1362)
!1404 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1405 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1406, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1408)
!1406 = !DISubroutineType(types: !1407)
!1407 = !{!220, !220, !1025, !220}
!1408 = !{!1409, !1410, !1411, !1412}
!1409 = !DILocalVariable(name: "fd", arg: 1, scope: !1405, file: !2, line: 178, type: !220)
!1410 = !DILocalVariable(name: "arr", arg: 2, scope: !1405, file: !2, line: 178, type: !1025)
!1411 = !DILocalVariable(name: "n", arg: 3, scope: !1405, file: !2, line: 178, type: !220)
!1412 = !DILocalVariable(name: "i", scope: !1405, file: !2, line: 178, type: !220)
!1413 = !DILocation(line: 0, scope: !1405)
!1414 = !DILocation(line: 178, column: 1, scope: !1415)
!1415 = distinct !DILexicalBlock(scope: !1416, file: !2, line: 178, column: 1)
!1416 = distinct !DILexicalBlock(scope: !1405, file: !2, line: 178, column: 1)
!1417 = !DILocation(line: 178, column: 1, scope: !1418)
!1418 = distinct !DILexicalBlock(scope: !1419, file: !2, line: 178, column: 1)
!1419 = distinct !DILexicalBlock(scope: !1405, file: !2, line: 178, column: 1)
!1420 = !DILocation(line: 178, column: 1, scope: !1419)
!1421 = !DILocation(line: 178, column: 1, scope: !1422)
!1422 = distinct !DILexicalBlock(scope: !1418, file: !2, line: 178, column: 1)
!1423 = distinct !{!1423, !1420, !1420, !399, !400}
!1424 = !DILocation(line: 178, column: 1, scope: !1405)
!1425 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1426, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1428)
!1426 = !DISubroutineType(types: !1427)
!1427 = !{!220, !220, !1056, !220}
!1428 = !{!1429, !1430, !1431, !1432}
!1429 = !DILocalVariable(name: "fd", arg: 1, scope: !1425, file: !2, line: 179, type: !220)
!1430 = !DILocalVariable(name: "arr", arg: 2, scope: !1425, file: !2, line: 179, type: !1056)
!1431 = !DILocalVariable(name: "n", arg: 3, scope: !1425, file: !2, line: 179, type: !220)
!1432 = !DILocalVariable(name: "i", scope: !1425, file: !2, line: 179, type: !220)
!1433 = !DILocation(line: 0, scope: !1425)
!1434 = !DILocation(line: 179, column: 1, scope: !1435)
!1435 = distinct !DILexicalBlock(scope: !1436, file: !2, line: 179, column: 1)
!1436 = distinct !DILexicalBlock(scope: !1425, file: !2, line: 179, column: 1)
!1437 = !DILocation(line: 179, column: 1, scope: !1438)
!1438 = distinct !DILexicalBlock(scope: !1439, file: !2, line: 179, column: 1)
!1439 = distinct !DILexicalBlock(scope: !1425, file: !2, line: 179, column: 1)
!1440 = !DILocation(line: 179, column: 1, scope: !1439)
!1441 = !DILocation(line: 179, column: 1, scope: !1442)
!1442 = distinct !DILexicalBlock(scope: !1438, file: !2, line: 179, column: 1)
!1443 = distinct !{!1443, !1440, !1440, !399, !400}
!1444 = !DILocation(line: 179, column: 1, scope: !1425)
!1445 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1446, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1448)
!1446 = !DISubroutineType(types: !1447)
!1447 = !{!220, !220, !1087, !220}
!1448 = !{!1449, !1450, !1451, !1452}
!1449 = !DILocalVariable(name: "fd", arg: 1, scope: !1445, file: !2, line: 180, type: !220)
!1450 = !DILocalVariable(name: "arr", arg: 2, scope: !1445, file: !2, line: 180, type: !1087)
!1451 = !DILocalVariable(name: "n", arg: 3, scope: !1445, file: !2, line: 180, type: !220)
!1452 = !DILocalVariable(name: "i", scope: !1445, file: !2, line: 180, type: !220)
!1453 = !DILocation(line: 0, scope: !1445)
!1454 = !DILocation(line: 180, column: 1, scope: !1455)
!1455 = distinct !DILexicalBlock(scope: !1456, file: !2, line: 180, column: 1)
!1456 = distinct !DILexicalBlock(scope: !1445, file: !2, line: 180, column: 1)
!1457 = !DILocation(line: 180, column: 1, scope: !1458)
!1458 = distinct !DILexicalBlock(scope: !1459, file: !2, line: 180, column: 1)
!1459 = distinct !DILexicalBlock(scope: !1445, file: !2, line: 180, column: 1)
!1460 = !DILocation(line: 180, column: 1, scope: !1459)
!1461 = !DILocation(line: 180, column: 1, scope: !1462)
!1462 = distinct !DILexicalBlock(scope: !1458, file: !2, line: 180, column: 1)
!1463 = distinct !{!1463, !1460, !1460, !399, !400}
!1464 = !DILocation(line: 180, column: 1, scope: !1445)
!1465 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1466, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1468)
!1466 = !DISubroutineType(types: !1467)
!1467 = !{!220, !220, !1118, !220}
!1468 = !{!1469, !1470, !1471, !1472}
!1469 = !DILocalVariable(name: "fd", arg: 1, scope: !1465, file: !2, line: 181, type: !220)
!1470 = !DILocalVariable(name: "arr", arg: 2, scope: !1465, file: !2, line: 181, type: !1118)
!1471 = !DILocalVariable(name: "n", arg: 3, scope: !1465, file: !2, line: 181, type: !220)
!1472 = !DILocalVariable(name: "i", scope: !1465, file: !2, line: 181, type: !220)
!1473 = !DILocation(line: 0, scope: !1465)
!1474 = !DILocation(line: 181, column: 1, scope: !1475)
!1475 = distinct !DILexicalBlock(scope: !1476, file: !2, line: 181, column: 1)
!1476 = distinct !DILexicalBlock(scope: !1465, file: !2, line: 181, column: 1)
!1477 = !DILocation(line: 181, column: 1, scope: !1478)
!1478 = distinct !DILexicalBlock(scope: !1479, file: !2, line: 181, column: 1)
!1479 = distinct !DILexicalBlock(scope: !1465, file: !2, line: 181, column: 1)
!1480 = !DILocation(line: 181, column: 1, scope: !1479)
!1481 = !DILocation(line: 181, column: 1, scope: !1482)
!1482 = distinct !DILexicalBlock(scope: !1478, file: !2, line: 181, column: 1)
!1483 = distinct !{!1483, !1480, !1480, !399, !400}
!1484 = !DILocation(line: 181, column: 1, scope: !1465)
!1485 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1486, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1488)
!1486 = !DISubroutineType(types: !1487)
!1487 = !{!220, !220, !1147, !220}
!1488 = !{!1489, !1490, !1491, !1492}
!1489 = !DILocalVariable(name: "fd", arg: 1, scope: !1485, file: !2, line: 182, type: !220)
!1490 = !DILocalVariable(name: "arr", arg: 2, scope: !1485, file: !2, line: 182, type: !1147)
!1491 = !DILocalVariable(name: "n", arg: 3, scope: !1485, file: !2, line: 182, type: !220)
!1492 = !DILocalVariable(name: "i", scope: !1485, file: !2, line: 182, type: !220)
!1493 = !DILocation(line: 0, scope: !1485)
!1494 = !DILocation(line: 182, column: 1, scope: !1495)
!1495 = distinct !DILexicalBlock(scope: !1496, file: !2, line: 182, column: 1)
!1496 = distinct !DILexicalBlock(scope: !1485, file: !2, line: 182, column: 1)
!1497 = !DILocation(line: 182, column: 1, scope: !1498)
!1498 = distinct !DILexicalBlock(scope: !1499, file: !2, line: 182, column: 1)
!1499 = distinct !DILexicalBlock(scope: !1485, file: !2, line: 182, column: 1)
!1500 = !DILocation(line: 182, column: 1, scope: !1499)
!1501 = !DILocation(line: 182, column: 1, scope: !1502)
!1502 = distinct !DILexicalBlock(scope: !1498, file: !2, line: 182, column: 1)
!1503 = distinct !{!1503, !1500, !1500, !399, !400}
!1504 = !DILocation(line: 182, column: 1, scope: !1485)
!1505 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !1506, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1508)
!1506 = !DISubroutineType(types: !1507)
!1507 = !{!220, !220, !1176, !220}
!1508 = !{!1509, !1510, !1511, !1512}
!1509 = !DILocalVariable(name: "fd", arg: 1, scope: !1505, file: !2, line: 183, type: !220)
!1510 = !DILocalVariable(name: "arr", arg: 2, scope: !1505, file: !2, line: 183, type: !1176)
!1511 = !DILocalVariable(name: "n", arg: 3, scope: !1505, file: !2, line: 183, type: !220)
!1512 = !DILocalVariable(name: "i", scope: !1505, file: !2, line: 183, type: !220)
!1513 = !DILocation(line: 0, scope: !1505)
!1514 = !DILocation(line: 183, column: 1, scope: !1515)
!1515 = distinct !DILexicalBlock(scope: !1516, file: !2, line: 183, column: 1)
!1516 = distinct !DILexicalBlock(scope: !1505, file: !2, line: 183, column: 1)
!1517 = !DILocation(line: 183, column: 1, scope: !1518)
!1518 = distinct !DILexicalBlock(scope: !1519, file: !2, line: 183, column: 1)
!1519 = distinct !DILexicalBlock(scope: !1505, file: !2, line: 183, column: 1)
!1520 = !DILocation(line: 183, column: 1, scope: !1519)
!1521 = !DILocation(line: 183, column: 1, scope: !1522)
!1522 = distinct !DILexicalBlock(scope: !1518, file: !2, line: 183, column: 1)
!1523 = distinct !{!1523, !1520, !1520, !399, !400}
!1524 = !DILocation(line: 183, column: 1, scope: !1505)
!1525 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1526, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1528)
!1526 = !DISubroutineType(types: !1527)
!1527 = !{!220, !220, !1205, !220}
!1528 = !{!1529, !1530, !1531, !1532}
!1529 = !DILocalVariable(name: "fd", arg: 1, scope: !1525, file: !2, line: 184, type: !220)
!1530 = !DILocalVariable(name: "arr", arg: 2, scope: !1525, file: !2, line: 184, type: !1205)
!1531 = !DILocalVariable(name: "n", arg: 3, scope: !1525, file: !2, line: 184, type: !220)
!1532 = !DILocalVariable(name: "i", scope: !1525, file: !2, line: 184, type: !220)
!1533 = !DILocation(line: 0, scope: !1525)
!1534 = !DILocation(line: 184, column: 1, scope: !1535)
!1535 = distinct !DILexicalBlock(scope: !1536, file: !2, line: 184, column: 1)
!1536 = distinct !DILexicalBlock(scope: !1525, file: !2, line: 184, column: 1)
!1537 = !DILocation(line: 184, column: 1, scope: !1538)
!1538 = distinct !DILexicalBlock(scope: !1539, file: !2, line: 184, column: 1)
!1539 = distinct !DILexicalBlock(scope: !1525, file: !2, line: 184, column: 1)
!1540 = !DILocation(line: 184, column: 1, scope: !1539)
!1541 = !DILocation(line: 184, column: 1, scope: !1542)
!1542 = distinct !DILexicalBlock(scope: !1538, file: !2, line: 184, column: 1)
!1543 = distinct !{!1543, !1540, !1540, !399, !400}
!1544 = !DILocation(line: 184, column: 1, scope: !1525)
!1545 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1546, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !244, retainedNodes: !1548)
!1546 = !DISubroutineType(types: !1547)
!1547 = !{!220, !220, !1234, !220}
!1548 = !{!1549, !1550, !1551, !1552}
!1549 = !DILocalVariable(name: "fd", arg: 1, scope: !1545, file: !2, line: 186, type: !220)
!1550 = !DILocalVariable(name: "arr", arg: 2, scope: !1545, file: !2, line: 186, type: !1234)
!1551 = !DILocalVariable(name: "n", arg: 3, scope: !1545, file: !2, line: 186, type: !220)
!1552 = !DILocalVariable(name: "i", scope: !1545, file: !2, line: 186, type: !220)
!1553 = !DILocation(line: 0, scope: !1545)
!1554 = !DILocation(line: 186, column: 1, scope: !1555)
!1555 = distinct !DILexicalBlock(scope: !1556, file: !2, line: 186, column: 1)
!1556 = distinct !DILexicalBlock(scope: !1545, file: !2, line: 186, column: 1)
!1557 = !DILocation(line: 186, column: 1, scope: !1558)
!1558 = distinct !DILexicalBlock(scope: !1559, file: !2, line: 186, column: 1)
!1559 = distinct !DILexicalBlock(scope: !1545, file: !2, line: 186, column: 1)
!1560 = !DILocation(line: 186, column: 1, scope: !1559)
!1561 = !DILocation(line: 186, column: 1, scope: !1562)
!1562 = distinct !DILexicalBlock(scope: !1558, file: !2, line: 186, column: 1)
!1563 = distinct !{!1563, !1560, !1560, !399, !400}
!1564 = !DILocation(line: 186, column: 1, scope: !1545)
!1565 = !DILocation(line: 0, scope: !646)
!1566 = !DILocation(line: 187, column: 1, scope: !1567)
!1567 = distinct !DILexicalBlock(scope: !1568, file: !2, line: 187, column: 1)
!1568 = distinct !DILexicalBlock(scope: !646, file: !2, line: 187, column: 1)
!1569 = !DILocation(line: 187, column: 1, scope: !660)
!1570 = !DILocation(line: 187, column: 1, scope: !657)
!1571 = !DILocation(line: 187, column: 1, scope: !659)
!1572 = distinct !{!1572, !1570, !1570, !399, !400}
!1573 = !DILocation(line: 187, column: 1, scope: !646)
!1574 = !DILocation(line: 0, scope: !613)
!1575 = !DILocation(line: 190, column: 3, scope: !620)
!1576 = !DILocation(line: 191, column: 3, scope: !613)
!1577 = !DILocation(line: 192, column: 3, scope: !613)
!1578 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1579, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !304, retainedNodes: !1581)
!1579 = !DISubroutineType(types: !1580)
!1580 = !{!220, !220, !963}
!1581 = !{!1582, !1583, !1584, !1585, !1586, !1587, !1588, !1589, !1590}
!1582 = !DILocalVariable(name: "argc", arg: 1, scope: !1578, file: !170, line: 14, type: !220)
!1583 = !DILocalVariable(name: "argv", arg: 2, scope: !1578, file: !170, line: 14, type: !963)
!1584 = !DILocalVariable(name: "in_file", scope: !1578, file: !170, line: 17, type: !246)
!1585 = !DILocalVariable(name: "check_file", scope: !1578, file: !170, line: 19, type: !246)
!1586 = !DILocalVariable(name: "in_fd", scope: !1578, file: !170, line: 34, type: !220)
!1587 = !DILocalVariable(name: "data", scope: !1578, file: !170, line: 35, type: !246)
!1588 = !DILocalVariable(name: "out_fd", scope: !1578, file: !170, line: 46, type: !220)
!1589 = !DILocalVariable(name: "check_fd", scope: !1578, file: !170, line: 55, type: !220)
!1590 = !DILocalVariable(name: "ref", scope: !1578, file: !170, line: 56, type: !246)
!1591 = !DILocation(line: 0, scope: !1578)
!1592 = !DILocation(line: 21, column: 3, scope: !1593)
!1593 = distinct !DILexicalBlock(scope: !1594, file: !170, line: 21, column: 3)
!1594 = distinct !DILexicalBlock(scope: !1578, file: !170, line: 21, column: 3)
!1595 = !DILocation(line: 26, column: 11, scope: !1596)
!1596 = distinct !DILexicalBlock(scope: !1578, file: !170, line: 26, column: 7)
!1597 = !DILocation(line: 26, column: 7, scope: !1578)
!1598 = !DILocation(line: 27, column: 15, scope: !1596)
!1599 = !DILocation(line: 29, column: 11, scope: !1600)
!1600 = distinct !DILexicalBlock(scope: !1578, file: !170, line: 29, column: 7)
!1601 = !DILocation(line: 29, column: 7, scope: !1578)
!1602 = !DILocation(line: 30, column: 18, scope: !1600)
!1603 = !DILocation(line: 30, column: 5, scope: !1600)
!1604 = !DILocation(line: 36, column: 17, scope: !1578)
!1605 = !DILocation(line: 36, column: 10, scope: !1578)
!1606 = !DILocation(line: 37, column: 3, scope: !1607)
!1607 = distinct !DILexicalBlock(scope: !1608, file: !170, line: 37, column: 3)
!1608 = distinct !DILexicalBlock(scope: !1578, file: !170, line: 37, column: 3)
!1609 = !DILocation(line: 38, column: 11, scope: !1578)
!1610 = !DILocation(line: 39, column: 3, scope: !1611)
!1611 = distinct !DILexicalBlock(scope: !1612, file: !170, line: 39, column: 3)
!1612 = distinct !DILexicalBlock(scope: !1578, file: !170, line: 39, column: 3)
!1613 = !DILocation(line: 40, column: 3, scope: !1578)
!1614 = !DILocation(line: 0, scope: !488, inlinedAt: !1615)
!1615 = distinct !DILocation(line: 43, column: 3, scope: !1578)
!1616 = !DILocation(line: 8, column: 29, scope: !488, inlinedAt: !1615)
!1617 = !DILocation(line: 8, column: 41, scope: !488, inlinedAt: !1615)
!1618 = !DILocation(line: 8, column: 59, scope: !488, inlinedAt: !1615)
!1619 = !DILocation(line: 8, column: 75, scope: !488, inlinedAt: !1615)
!1620 = !DILocation(line: 8, column: 3, scope: !488, inlinedAt: !1615)
!1621 = !DILocation(line: 47, column: 12, scope: !1578)
!1622 = !DILocation(line: 48, column: 3, scope: !1623)
!1623 = distinct !DILexicalBlock(scope: !1624, file: !170, line: 48, column: 3)
!1624 = distinct !DILexicalBlock(scope: !1578, file: !170, line: 48, column: 3)
!1625 = !DILocation(line: 0, scope: !716, inlinedAt: !1626)
!1626 = distinct !DILocation(line: 49, column: 3, scope: !1578)
!1627 = !DILocation(line: 0, scope: !613, inlinedAt: !1628)
!1628 = distinct !DILocation(line: 81, column: 3, scope: !716, inlinedAt: !1626)
!1629 = !DILocation(line: 190, column: 3, scope: !620, inlinedAt: !1628)
!1630 = !DILocation(line: 191, column: 3, scope: !613, inlinedAt: !1628)
!1631 = !DILocation(line: 0, scope: !624, inlinedAt: !1632)
!1632 = distinct !DILocation(line: 82, column: 3, scope: !716, inlinedAt: !1626)
!1633 = !DILocation(line: 177, column: 1, scope: !635, inlinedAt: !1632)
!1634 = !DILocation(line: 177, column: 1, scope: !637, inlinedAt: !1632)
!1635 = !DILocation(line: 177, column: 1, scope: !638, inlinedAt: !1632)
!1636 = distinct !{!1636, !1633, !1633, !399, !400}
!1637 = !DILocation(line: 50, column: 3, scope: !1578)
!1638 = !DILocation(line: 57, column: 16, scope: !1578)
!1639 = !DILocation(line: 57, column: 9, scope: !1578)
!1640 = !DILocation(line: 58, column: 3, scope: !1641)
!1641 = distinct !DILexicalBlock(scope: !1642, file: !170, line: 58, column: 3)
!1642 = distinct !DILexicalBlock(scope: !1578, file: !170, line: 58, column: 3)
!1643 = !DILocation(line: 59, column: 14, scope: !1578)
!1644 = !DILocation(line: 60, column: 3, scope: !1645)
!1645 = distinct !DILexicalBlock(scope: !1646, file: !170, line: 60, column: 3)
!1646 = distinct !DILexicalBlock(scope: !1578, file: !170, line: 60, column: 3)
!1647 = !DILocation(line: 0, scope: !684, inlinedAt: !1648)
!1648 = distinct !DILocation(line: 61, column: 3, scope: !1578)
!1649 = !DILocation(line: 69, column: 3, scope: !684, inlinedAt: !1648)
!1650 = !DILocation(line: 71, column: 7, scope: !684, inlinedAt: !1648)
!1651 = !DILocation(line: 0, scope: !514, inlinedAt: !1652)
!1652 = distinct !DILocation(line: 73, column: 7, scope: !684, inlinedAt: !1648)
!1653 = !DILocation(line: 64, column: 17, scope: !514, inlinedAt: !1652)
!1654 = !DILocation(line: 64, column: 3, scope: !514, inlinedAt: !1652)
!1655 = !DILocation(line: 66, column: 22, scope: !525, inlinedAt: !1652)
!1656 = !DILocation(line: 66, column: 26, scope: !525, inlinedAt: !1652)
!1657 = !DILocation(line: 66, column: 32, scope: !525, inlinedAt: !1652)
!1658 = !DILocation(line: 66, column: 35, scope: !525, inlinedAt: !1652)
!1659 = !DILocation(line: 66, column: 39, scope: !525, inlinedAt: !1652)
!1660 = !DILocation(line: 66, column: 9, scope: !526, inlinedAt: !1652)
!1661 = !DILocation(line: 69, column: 6, scope: !526, inlinedAt: !1652)
!1662 = !DILocation(line: 64, column: 10, scope: !514, inlinedAt: !1652)
!1663 = !DILocation(line: 64, column: 13, scope: !514, inlinedAt: !1652)
!1664 = distinct !{!1664, !1654, !1665, !399, !400}
!1665 = !DILocation(line: 70, column: 3, scope: !514, inlinedAt: !1652)
!1666 = !DILocation(line: 71, column: 6, scope: !538, inlinedAt: !1652)
!1667 = !DILocation(line: 71, column: 8, scope: !538, inlinedAt: !1652)
!1668 = !DILocation(line: 71, column: 6, scope: !514, inlinedAt: !1652)
!1669 = !DILocation(line: 74, column: 32, scope: !684, inlinedAt: !1648)
!1670 = !DILocation(line: 74, column: 3, scope: !684, inlinedAt: !1648)
!1671 = !DILocation(line: 75, column: 3, scope: !684, inlinedAt: !1648)
!1672 = !DILocation(line: 0, scope: !734, inlinedAt: !1673)
!1673 = distinct !DILocation(line: 66, column: 8, scope: !1674)
!1674 = distinct !DILexicalBlock(scope: !1578, file: !170, line: 66, column: 7)
!1675 = !DILocation(line: 91, column: 3, scope: !746, inlinedAt: !1673)
!1676 = !DILocation(line: 92, column: 20, scope: !748, inlinedAt: !1673)
!1677 = !DILocation(line: 92, column: 35, scope: !748, inlinedAt: !1673)
!1678 = !DILocation(line: 92, column: 33, scope: !748, inlinedAt: !1673)
!1679 = !DILocation(line: 92, column: 16, scope: !748, inlinedAt: !1673)
!1680 = !DILocation(line: 91, column: 22, scope: !749, inlinedAt: !1673)
!1681 = !DILocation(line: 91, column: 13, scope: !749, inlinedAt: !1673)
!1682 = distinct !{!1682, !1675, !1683, !399, !400}
!1683 = !DILocation(line: 93, column: 3, scope: !746, inlinedAt: !1673)
!1684 = !DILocation(line: 96, column: 10, scope: !734, inlinedAt: !1673)
!1685 = !DILocation(line: 66, column: 7, scope: !1578)
!1686 = !DILocation(line: 67, column: 13, scope: !1687)
!1687 = distinct !DILexicalBlock(scope: !1674, file: !170, line: 66, column: 32)
!1688 = !DILocation(line: 67, column: 5, scope: !1687)
!1689 = !DILocation(line: 68, column: 5, scope: !1687)
!1690 = !DILocation(line: 71, column: 3, scope: !1578)
!1691 = !DILocation(line: 72, column: 3, scope: !1578)
!1692 = !DILocation(line: 74, column: 3, scope: !1578)
!1693 = !DILocation(line: 75, column: 3, scope: !1578)
!1694 = !DILocation(line: 76, column: 1, scope: !1578)
!1695 = !DISubprogram(name: "open", scope: !1696, file: !1696, line: 209, type: !1697, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1696 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1697 = !DISubroutineType(types: !1698)
!1698 = !{!220, !845, !220, null}
