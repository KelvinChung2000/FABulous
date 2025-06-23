; ModuleID = 'nw/nw/nw_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

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
@INPUT_SIZE = dso_local local_unnamed_addr global i32 83976, align 4, !dbg !186
@.str.6.14 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !213
@.str.8.15 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !216
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !219
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !224
@.str.12.16 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !227
@.str.14.17 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !229
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !232
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @nw(ptr nocapture noundef readonly %SEQA, ptr nocapture noundef readonly %SEQB, ptr nocapture noundef writeonly %alignedA, ptr nocapture noundef writeonly %alignedB, ptr nocapture noundef %M, ptr nocapture noundef %ptr) local_unnamed_addr #0 !dbg !335 {
polly.loop_preheader:
  %scevgep7.reg2mem = alloca ptr, align 8
  %scevgep5.reg2mem = alloca ptr, align 8
  %invariant.gep154.reg2mem = alloca ptr, align 8
  %invariant.gep152.reg2mem = alloca ptr, align 8
  %invariant.gep150.reg2mem = alloca ptr, align 8
  %invariant.gep148.reg2mem = alloca ptr, align 8
  %scevgep8.reg2mem = alloca ptr, align 8
  %scevgep6.reg2mem = alloca ptr, align 8
  %polly.indvar_next13.reg2mem = alloca i64, align 8
  %polly.indvar_next.reg2mem = alloca i64, align 8
  %indvars.iv269.reg2mem = alloca i64, align 8
  %indvar.reg2mem = alloca i64, align 8
  %polly.indvar12.reg2mem = alloca i64, align 8
  %polly.indvar.reg2mem = alloca i64, align 8
  %b_idx.3.reg2mem244 = alloca i32, align 4
  %a_idx.3.reg2mem246 = alloca i32, align 4
  %a_idx.2247.reg2mem248 = alloca i32, align 4
  %b_idx.2248.reg2mem250 = alloca i32, align 4
  %indvars.iv275.reg2mem252 = alloca i64, align 8
  %indvars.iv261.reg2mem254 = alloca i64, align 8
  %store_forwarded.reg2mem = alloca i32, align 4
  %indvars.iv261.lver.orig.reg2mem256 = alloca i64, align 8
  %store_forwarded145.reg2mem = alloca i32, align 4
  %indvars.iv261.lver.orig.lver.orig.reg2mem258 = alloca i64, align 8
  %indvars.iv269.reg2mem260 = alloca i64, align 8
  %indvar.reg2mem262 = alloca i64, align 8
    #dbg_value(ptr %SEQA, !340, !DIExpression(), !368)
    #dbg_value(ptr %SEQB, !341, !DIExpression(), !368)
    #dbg_value(ptr %alignedA, !342, !DIExpression(), !368)
    #dbg_value(ptr %alignedB, !343, !DIExpression(), !368)
    #dbg_value(ptr %M, !344, !DIExpression(), !368)
    #dbg_value(ptr %ptr, !345, !DIExpression(), !368)
    #dbg_label(!358, !369)
    #dbg_value(i32 0, !354, !DIExpression(), !368)
  store i64 0, ptr %polly.indvar.reg2mem, align 8
  br label %polly.stmt.for.body

for.body16.lver.check:                            ; preds = %for.inc80.for.body16.lver.check_crit_edge, %for.body16.lver.check.preheader
  %indvar.reg2mem262.0.load = load i64, ptr %indvar.reg2mem262, align 8
  %indvars.iv269.reg2mem260.0.load = load i64, ptr %indvars.iv269.reg2mem260, align 8
  store i64 %indvar.reg2mem262.0.load, ptr %indvar.reg2mem, align 8
  store i64 %indvars.iv269.reg2mem260.0.load, ptr %indvars.iv269.reg2mem, align 8
  %0 = mul nuw nsw i64 %indvar.reg2mem262.0.load, 516
  %invariant.gep148.reg2mem.0.invariant.gep148.reload = load ptr, ptr %invariant.gep148.reg2mem, align 8
  %gep149 = getelementptr i8, ptr %invariant.gep148.reg2mem.0.invariant.gep148.reload, i64 %0
    #dbg_value(i64 %indvars.iv269.reg2mem260.0.load, !355, !DIExpression(), !368)
  %scevgep285 = getelementptr i8, ptr %M, i64 %0
  %scevgep5.reg2mem.0.scevgep5.reload = load ptr, ptr %scevgep5.reg2mem, align 8
  %gep303 = getelementptr i8, ptr %scevgep5.reg2mem.0.scevgep5.reload, i64 %0
  %1 = mul nuw nsw i64 %indvar.reg2mem262.0.load, 129
  %scevgep6.reg2mem.0.scevgep6.reload = load ptr, ptr %scevgep6.reg2mem, align 8
  %gep305 = getelementptr i8, ptr %scevgep6.reg2mem.0.scevgep6.reload, i64 %1
  %scevgep7.reg2mem.0.scevgep7.reload = load ptr, ptr %scevgep7.reg2mem, align 8
  %gep307 = getelementptr i8, ptr %scevgep7.reg2mem.0.scevgep7.reload, i64 %1
  %2 = add nsw i64 %indvars.iv269.reg2mem260.0.load, -1
  %arrayidx21 = getelementptr inbounds i8, ptr %SEQB, i64 %2
  %3 = mul nuw nsw i64 %2, 129
  %4 = mul nuw nsw i64 %indvars.iv269.reg2mem260.0.load, 129
    #dbg_value(i32 1, !354, !DIExpression(), !368)
  %bound0 = icmp ult ptr %scevgep285, %gep307, !dbg !370
  %bound1 = icmp ult ptr %gep305, %gep303, !dbg !370
  %found.conflict = and i1 %bound0, %bound1, !dbg !370
  br i1 %found.conflict, label %for.body16.lver.orig.lver.check, label %for.body16.pre_entry_bb, !dbg !370

for.body16.lver.orig.lver.check:                  ; preds = %for.body16.lver.check
  %invariant.gep150.reg2mem.0.invariant.gep150.reload = load ptr, ptr %invariant.gep150.reg2mem, align 8
  %gep151 = getelementptr i8, ptr %invariant.gep150.reg2mem.0.invariant.gep150.reload, i64 %1
  %invariant.gep152.reg2mem.0.invariant.gep152.reload = load ptr, ptr %invariant.gep152.reg2mem, align 8
  %gep153 = getelementptr i8, ptr %invariant.gep152.reg2mem.0.invariant.gep152.reload, i64 %1
  %invariant.gep154.reg2mem.0.invariant.gep154.reload = load ptr, ptr %invariant.gep154.reg2mem, align 8
  %gep155 = getelementptr i8, ptr %invariant.gep154.reg2mem.0.invariant.gep154.reload, i64 %0
  %invariant.gep296 = getelementptr i32, ptr %M, i64 %3, !dbg !370
  %invariant.gep300 = getelementptr i32, ptr %M, i64 %4, !dbg !370
  %bound0139 = icmp ult ptr %scevgep285, %gep151, !dbg !370
  %bound1140 = icmp ult ptr %gep153, %gep155, !dbg !370
  %found.conflict141 = and i1 %bound0139, %bound1140, !dbg !370
  br i1 %found.conflict141, label %for.body16.lver.orig.lver.check.for.body16.lver.orig.lver.orig_crit_edge, label %for.body16.lver.orig.ph, !dbg !370

for.body16.lver.orig.lver.check.for.body16.lver.orig.lver.orig_crit_edge: ; preds = %for.body16.lver.orig.lver.check
  store i64 1, ptr %indvars.iv261.lver.orig.lver.orig.reg2mem258, align 8
  br label %for.body16.lver.orig.lver.orig, !dbg !370

for.body16.lver.orig.lver.orig:                   ; preds = %for.inc77.lver.orig.lver.orig.for.body16.lver.orig.lver.orig_crit_edge, %for.body16.lver.orig.lver.check.for.body16.lver.orig.lver.orig_crit_edge
    #dbg_value(i64 %indvars.iv261.lver.orig.lver.orig.reg2mem258.0.load, !354, !DIExpression(), !368)
  %indvars.iv261.lver.orig.lver.orig.reg2mem258.0.load = load i64, ptr %indvars.iv261.lver.orig.lver.orig.reg2mem258, align 8
  %5 = add nsw i64 %indvars.iv261.lver.orig.lver.orig.reg2mem258.0.load, -1, !dbg !372
  %arrayidx18.lver.orig.lver.orig = getelementptr inbounds i8, ptr %SEQA, i64 %5, !dbg !376
  %6 = load i8, ptr %arrayidx18.lver.orig.lver.orig, align 1, !dbg !376, !tbaa !377
  %7 = load i8, ptr %arrayidx21, align 1, !dbg !380, !tbaa !377
  %cmp23.lver.orig.lver.orig = icmp eq i8 %6, %7, !dbg !381
  %..lver.orig.lver.orig = select i1 %cmp23.lver.orig.lver.orig, i32 1, i32 -1
    #dbg_value(i32 %..lver.orig.lver.orig, !346, !DIExpression(), !368)
    #dbg_value(i64 %3, !352, !DIExpression(), !368)
    #dbg_value(i64 %4, !351, !DIExpression(), !368)
  %gep297.lver.orig = getelementptr i32, ptr %invariant.gep296, i64 %5, !dbg !382
  %8 = load i32, ptr %gep297.lver.orig, align 4, !dbg !382, !tbaa !383
  %add31.lver.orig.lver.orig = add nsw i32 %..lver.orig.lver.orig, %8, !dbg !385
    #dbg_value(i32 %add31.lver.orig.lver.orig, !347, !DIExpression(), !368)
  %gep299.lver.orig = getelementptr i32, ptr %invariant.gep296, i64 %indvars.iv261.lver.orig.lver.orig.reg2mem258.0.load, !dbg !386
  %9 = load i32, ptr %gep299.lver.orig, align 4, !dbg !386, !tbaa !383
  %add35.lver.orig.lver.orig = add nsw i32 %9, -1, !dbg !387
    #dbg_value(i32 %add35.lver.orig.lver.orig, !348, !DIExpression(), !368)
  %gep301.lver.orig = getelementptr i32, ptr %invariant.gep300, i64 %5, !dbg !388
  %10 = load i32, ptr %gep301.lver.orig, align 4, !dbg !388, !tbaa !383
  %add40.lver.orig.lver.orig = add nsw i32 %10, -1, !dbg !389
    #dbg_value(i32 %add40.lver.orig.lver.orig, !349, !DIExpression(), !368)
  %cond.lver.orig.lver.orig = tail call i32 @llvm.smax.i32(i32 %add35.lver.orig.lver.orig, i32 %add40.lver.orig.lver.orig), !dbg !390
  %cond54.lver.orig.lver.orig = tail call i32 @llvm.smax.i32(i32 %add31.lver.orig.lver.orig, i32 %cond.lver.orig.lver.orig), !dbg !390
    #dbg_value(i32 %cond54.lver.orig.lver.orig, !350, !DIExpression(), !368)
  %11 = add nuw nsw i64 %indvars.iv261.lver.orig.lver.orig.reg2mem258.0.load, %4, !dbg !391
  %arrayidx57.lver.orig.lver.orig = getelementptr inbounds i32, ptr %M, i64 %11, !dbg !392
  store i32 %cond54.lver.orig.lver.orig, ptr %arrayidx57.lver.orig.lver.orig, align 4, !dbg !393, !tbaa !383
  %cmp58.lver.orig.lver.orig = icmp eq i32 %cond54.lver.orig.lver.orig, %add40.lver.orig.lver.orig, !dbg !394
  br i1 %cmp58.lver.orig.lver.orig, label %if.then60.lver.orig.lver.orig, label %if.else64.lver.orig.lver.orig, !dbg !396

if.else64.lver.orig.lver.orig:                    ; preds = %for.body16.lver.orig.lver.orig
  %cmp65.lver.orig.lver.orig = icmp eq i32 %cond54.lver.orig.lver.orig, %add35.lver.orig.lver.orig, !dbg !397
  %arrayidx70.lver.orig.lver.orig = getelementptr inbounds i8, ptr %ptr, i64 %11, !dbg !399
  br i1 %cmp65.lver.orig.lver.orig, label %if.then67.lver.orig.lver.orig, label %if.else71.lver.orig.lver.orig, !dbg !400

if.else71.lver.orig.lver.orig:                    ; preds = %if.else64.lver.orig.lver.orig
  store i8 92, ptr %arrayidx70.lver.orig.lver.orig, align 1, !dbg !401, !tbaa !377
  br label %for.inc77.lver.orig.lver.orig

if.then67.lver.orig.lver.orig:                    ; preds = %if.else64.lver.orig.lver.orig
  store i8 94, ptr %arrayidx70.lver.orig.lver.orig, align 1, !dbg !403, !tbaa !377
  br label %for.inc77.lver.orig.lver.orig, !dbg !405

if.then60.lver.orig.lver.orig:                    ; preds = %for.body16.lver.orig.lver.orig
  %arrayidx63.lver.orig.lver.orig = getelementptr inbounds i8, ptr %ptr, i64 %11, !dbg !406
  store i8 60, ptr %arrayidx63.lver.orig.lver.orig, align 1, !dbg !408, !tbaa !377
  br label %for.inc77.lver.orig.lver.orig, !dbg !409

for.inc77.lver.orig.lver.orig:                    ; preds = %if.then60.lver.orig.lver.orig, %if.then67.lver.orig.lver.orig, %if.else71.lver.orig.lver.orig
  %indvars.iv.next262.lver.orig.lver.orig = add nuw nsw i64 %indvars.iv261.lver.orig.lver.orig.reg2mem258.0.load, 1, !dbg !410
    #dbg_value(i64 %indvars.iv.next262.lver.orig.lver.orig, !354, !DIExpression(), !368)
  %exitcond268.not.lver.orig.lver.orig = icmp eq i64 %indvars.iv.next262.lver.orig.lver.orig, 129, !dbg !411
  br i1 %exitcond268.not.lver.orig.lver.orig, label %for.inc77.lver.orig.lver.orig.for.inc80_crit_edge, label %for.inc77.lver.orig.lver.orig.for.body16.lver.orig.lver.orig_crit_edge, !dbg !370, !llvm.loop !412

for.inc77.lver.orig.lver.orig.for.body16.lver.orig.lver.orig_crit_edge: ; preds = %for.inc77.lver.orig.lver.orig
  store i64 %indvars.iv.next262.lver.orig.lver.orig, ptr %indvars.iv261.lver.orig.lver.orig.reg2mem258, align 8
  br label %for.body16.lver.orig.lver.orig, !dbg !370

for.inc77.lver.orig.lver.orig.for.inc80_crit_edge: ; preds = %for.inc77.lver.orig.lver.orig
  br label %for.inc80, !dbg !370

for.body16.lver.orig.ph:                          ; preds = %for.body16.lver.orig.lver.check
  %load_initial144 = load i32, ptr %gep149, align 4
  store i64 1, ptr %indvars.iv261.lver.orig.reg2mem256, align 8
  store i32 %load_initial144, ptr %store_forwarded145.reg2mem, align 4
  br label %for.body16.lver.orig, !dbg !370

for.body16.lver.orig:                             ; preds = %for.inc77.lver.orig.for.body16.lver.orig_crit_edge, %for.body16.lver.orig.ph
    #dbg_value(i64 %indvars.iv261.lver.orig.reg2mem256.0.load, !354, !DIExpression(), !368)
  %store_forwarded145.reg2mem.0.load = load i32, ptr %store_forwarded145.reg2mem, align 4
  %indvars.iv261.lver.orig.reg2mem256.0.load = load i64, ptr %indvars.iv261.lver.orig.reg2mem256, align 8
  %12 = add nsw i64 %indvars.iv261.lver.orig.reg2mem256.0.load, -1, !dbg !372
  %arrayidx18.lver.orig = getelementptr inbounds i8, ptr %SEQA, i64 %12, !dbg !376
  %13 = load i8, ptr %arrayidx18.lver.orig, align 1, !dbg !376, !tbaa !377
  %14 = load i8, ptr %arrayidx21, align 1, !dbg !380, !tbaa !377
  %cmp23.lver.orig = icmp eq i8 %13, %14, !dbg !381
  %..lver.orig = select i1 %cmp23.lver.orig, i32 1, i32 -1
    #dbg_value(i32 %..lver.orig, !346, !DIExpression(), !368)
    #dbg_value(i64 %3, !352, !DIExpression(), !368)
    #dbg_value(i64 %4, !351, !DIExpression(), !368)
  %gep297 = getelementptr i32, ptr %invariant.gep296, i64 %12, !dbg !382
  %15 = load i32, ptr %gep297, align 4, !dbg !382, !tbaa !383
  %add31.lver.orig = add nsw i32 %..lver.orig, %15, !dbg !385
    #dbg_value(i32 %add31.lver.orig, !347, !DIExpression(), !368)
  %gep299 = getelementptr i32, ptr %invariant.gep296, i64 %indvars.iv261.lver.orig.reg2mem256.0.load, !dbg !386
  %16 = load i32, ptr %gep299, align 4, !dbg !386, !tbaa !383
  %add35.lver.orig = add nsw i32 %16, -1, !dbg !387
    #dbg_value(i32 %add35.lver.orig, !348, !DIExpression(), !368)
  %add40.lver.orig = add nsw i32 %store_forwarded145.reg2mem.0.load, -1, !dbg !389
    #dbg_value(i32 %add40.lver.orig, !349, !DIExpression(), !368)
  %cond.lver.orig = tail call i32 @llvm.smax.i32(i32 %add35.lver.orig, i32 %add40.lver.orig), !dbg !390
  %cond54.lver.orig = tail call i32 @llvm.smax.i32(i32 %add31.lver.orig, i32 %cond.lver.orig), !dbg !390
    #dbg_value(i32 %cond54.lver.orig, !350, !DIExpression(), !368)
  %17 = add nuw nsw i64 %indvars.iv261.lver.orig.reg2mem256.0.load, %4, !dbg !391
  %arrayidx57.lver.orig = getelementptr inbounds i32, ptr %M, i64 %17, !dbg !392
  store i32 %cond54.lver.orig, ptr %arrayidx57.lver.orig, align 4, !dbg !393, !tbaa !383
  %cmp58.lver.orig = icmp eq i32 %cond54.lver.orig, %add40.lver.orig, !dbg !394
  br i1 %cmp58.lver.orig, label %if.then60.lver.orig, label %if.else64.lver.orig, !dbg !396

if.else64.lver.orig:                              ; preds = %for.body16.lver.orig
  %cmp65.lver.orig = icmp eq i32 %cond54.lver.orig, %add35.lver.orig, !dbg !397
  %arrayidx70.lver.orig = getelementptr inbounds i8, ptr %ptr, i64 %17, !dbg !399
  br i1 %cmp65.lver.orig, label %if.then67.lver.orig, label %if.else71.lver.orig, !dbg !400

if.else71.lver.orig:                              ; preds = %if.else64.lver.orig
  store i8 92, ptr %arrayidx70.lver.orig, align 1, !dbg !401, !tbaa !377
  br label %for.inc77.lver.orig

if.then67.lver.orig:                              ; preds = %if.else64.lver.orig
  store i8 94, ptr %arrayidx70.lver.orig, align 1, !dbg !403, !tbaa !377
  br label %for.inc77.lver.orig, !dbg !405

if.then60.lver.orig:                              ; preds = %for.body16.lver.orig
  %arrayidx63.lver.orig = getelementptr inbounds i8, ptr %ptr, i64 %17, !dbg !406
  store i8 60, ptr %arrayidx63.lver.orig, align 1, !dbg !408, !tbaa !377
  br label %for.inc77.lver.orig, !dbg !409

for.inc77.lver.orig:                              ; preds = %if.then60.lver.orig, %if.then67.lver.orig, %if.else71.lver.orig
  %indvars.iv.next262.lver.orig = add nuw nsw i64 %indvars.iv261.lver.orig.reg2mem256.0.load, 1, !dbg !410
    #dbg_value(i64 %indvars.iv.next262.lver.orig, !354, !DIExpression(), !368)
  %exitcond268.not.lver.orig = icmp eq i64 %indvars.iv.next262.lver.orig, 129, !dbg !411
  br i1 %exitcond268.not.lver.orig, label %for.inc77.lver.orig.for.inc80_crit_edge, label %for.inc77.lver.orig.for.body16.lver.orig_crit_edge, !dbg !370, !llvm.loop !412

for.inc77.lver.orig.for.body16.lver.orig_crit_edge: ; preds = %for.inc77.lver.orig
  store i64 %indvars.iv.next262.lver.orig, ptr %indvars.iv261.lver.orig.reg2mem256, align 8
  store i32 %cond54.lver.orig, ptr %store_forwarded145.reg2mem, align 4
  br label %for.body16.lver.orig, !dbg !370

for.inc77.lver.orig.for.inc80_crit_edge:          ; preds = %for.inc77.lver.orig
  br label %for.inc80, !dbg !370

while.cond.preheader:                             ; preds = %for.inc80
  %invariant.gep = getelementptr i8, ptr %SEQA, i64 -1, !dbg !416
  %invariant.gep243 = getelementptr i8, ptr %SEQB, i64 -1, !dbg !416
    #dbg_value(i32 0, !357, !DIExpression(), !368)
    #dbg_value(i32 0, !356, !DIExpression(), !368)
    #dbg_value(i32 128, !355, !DIExpression(), !368)
    #dbg_value(i32 128, !354, !DIExpression(), !368)
  store i32 128, ptr %a_idx.2247.reg2mem248, align 4
  store i32 128, ptr %b_idx.2248.reg2mem250, align 4
  store i64 0, ptr %indvars.iv275.reg2mem252, align 8
  br label %while.body, !dbg !416

for.body16.pre_entry_bb:                          ; preds = %for.body16.lver.check
  %scevgep8.reg2mem.0.scevgep8.reload = load ptr, ptr %scevgep8.reg2mem, align 8
  %gep309 = getelementptr i8, ptr %scevgep8.reg2mem.0.scevgep8.reload, i64 %0
  %load_initial = load i32, ptr %gep309, align 4
  %invariant.gep292 = getelementptr i32, ptr %M, i64 %3, !dbg !370
  store i64 1, ptr %indvars.iv261.reg2mem254, align 8
  store i32 %load_initial, ptr %store_forwarded.reg2mem, align 4
  br label %for.body16, !dbg !370

for.body16:                                       ; preds = %for.inc77.for.body16_crit_edge, %for.body16.pre_entry_bb
    #dbg_value(i64 %indvars.iv261.reg2mem254.0.load, !354, !DIExpression(), !368)
  %store_forwarded.reg2mem.0.load = load i32, ptr %store_forwarded.reg2mem, align 4
  %indvars.iv261.reg2mem254.0.load = load i64, ptr %indvars.iv261.reg2mem254, align 8
  %18 = add nsw i64 %indvars.iv261.reg2mem254.0.load, -1, !dbg !372
  %arrayidx18 = getelementptr inbounds i8, ptr %SEQA, i64 %18, !dbg !376
  %19 = load i8, ptr %arrayidx18, align 1, !dbg !376, !tbaa !377
  %20 = load i8, ptr %arrayidx21, align 1, !dbg !380, !tbaa !377
  %cmp23 = icmp eq i8 %19, %20, !dbg !381
  %. = select i1 %cmp23, i32 1, i32 -1
    #dbg_value(i32 %., !346, !DIExpression(), !368)
    #dbg_value(i64 %3, !352, !DIExpression(), !368)
    #dbg_value(i64 %4, !351, !DIExpression(), !368)
  %gep293 = getelementptr i32, ptr %invariant.gep292, i64 %18, !dbg !382
  %21 = load i32, ptr %gep293, align 4, !dbg !382, !tbaa !383
  %add31 = add nsw i32 %., %21, !dbg !385
    #dbg_value(i32 %add31, !347, !DIExpression(), !368)
  %gep295 = getelementptr i32, ptr %invariant.gep292, i64 %indvars.iv261.reg2mem254.0.load, !dbg !386
  %22 = load i32, ptr %gep295, align 4, !dbg !386, !tbaa !383
  %add35 = add nsw i32 %22, -1, !dbg !387
    #dbg_value(i32 %add35, !348, !DIExpression(), !368)
  %add40 = add nsw i32 %store_forwarded.reg2mem.0.load, -1, !dbg !389
    #dbg_value(i32 %add40, !349, !DIExpression(), !368)
  %cond = tail call i32 @llvm.smax.i32(i32 %add35, i32 %add40), !dbg !390
  %cond54 = tail call i32 @llvm.smax.i32(i32 %add31, i32 %cond), !dbg !390
    #dbg_value(i32 %cond54, !350, !DIExpression(), !368)
  %23 = add nuw nsw i64 %indvars.iv261.reg2mem254.0.load, %4, !dbg !391
  %arrayidx57 = getelementptr inbounds i32, ptr %M, i64 %23, !dbg !392
  store i32 %cond54, ptr %arrayidx57, align 4, !dbg !393, !tbaa !383
  %cmp58 = icmp eq i32 %cond54, %add40, !dbg !394
  br i1 %cmp58, label %if.then60, label %if.else64, !dbg !396

if.then60:                                        ; preds = %for.body16
  %arrayidx63 = getelementptr inbounds i8, ptr %ptr, i64 %23, !dbg !406
  store i8 60, ptr %arrayidx63, align 1, !dbg !408, !tbaa !377
  br label %for.inc77, !dbg !409

if.else64:                                        ; preds = %for.body16
  %cmp65 = icmp eq i32 %cond54, %add35, !dbg !397
  %arrayidx70 = getelementptr inbounds i8, ptr %ptr, i64 %23, !dbg !399
  br i1 %cmp65, label %if.then67, label %if.else71, !dbg !400

if.then67:                                        ; preds = %if.else64
  store i8 94, ptr %arrayidx70, align 1, !dbg !403, !tbaa !377
  br label %for.inc77, !dbg !405

if.else71:                                        ; preds = %if.else64
  store i8 92, ptr %arrayidx70, align 1, !dbg !401, !tbaa !377
  br label %for.inc77

for.inc77:                                        ; preds = %if.then60, %if.else71, %if.then67
  %indvars.iv.next262 = add nuw nsw i64 %indvars.iv261.reg2mem254.0.load, 1, !dbg !410
    #dbg_value(i64 %indvars.iv.next262, !354, !DIExpression(), !368)
  %exitcond268.not = icmp eq i64 %indvars.iv.next262, 129, !dbg !411
  br i1 %exitcond268.not, label %for.inc77.for.inc80_crit_edge, label %for.inc77.for.body16_crit_edge, !dbg !370, !llvm.loop !412

for.inc77.for.body16_crit_edge:                   ; preds = %for.inc77
  store i64 %indvars.iv.next262, ptr %indvars.iv261.reg2mem254, align 8
  store i32 %cond54, ptr %store_forwarded.reg2mem, align 4
  br label %for.body16, !dbg !370

for.inc77.for.inc80_crit_edge:                    ; preds = %for.inc77
  br label %for.inc80, !dbg !370

for.inc80:                                        ; preds = %for.inc77.for.inc80_crit_edge, %for.inc77.lver.orig.for.inc80_crit_edge, %for.inc77.lver.orig.lver.orig.for.inc80_crit_edge
  %indvars.iv269.reg2mem.0.load270 = load i64, ptr %indvars.iv269.reg2mem, align 8
  %indvars.iv.next270 = add nuw nsw i64 %indvars.iv269.reg2mem.0.load270, 1, !dbg !417
    #dbg_value(i64 %indvars.iv.next270, !355, !DIExpression(), !368)
  %exitcond274.not = icmp eq i64 %indvars.iv.next270, 129, !dbg !418
  %indvar.reg2mem.0.load268 = load i64, ptr %indvar.reg2mem, align 8
  %indvar.next = add nuw nsw i64 %indvar.reg2mem.0.load268, 1, !dbg !419
  br i1 %exitcond274.not, label %while.cond.preheader, label %for.inc80.for.body16.lver.check_crit_edge, !dbg !419, !llvm.loop !420

for.inc80.for.body16.lver.check_crit_edge:        ; preds = %for.inc80
  store i64 %indvars.iv.next270, ptr %indvars.iv269.reg2mem260, align 8
  store i64 %indvar.next, ptr %indvar.reg2mem262, align 8
  br label %for.body16.lver.check, !dbg !419

for.cond139.preheader:                            ; preds = %if.end138
  %24 = trunc i64 %indvars.iv275.reg2mem252.0.load to i32, !dbg !422
    #dbg_value(i64 %indvars.iv.next276, !356, !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value), !368)
  %cmp140251 = icmp ult i32 %24, 255, !dbg !422
  br i1 %cmp140251, label %for.body142.preheader, label %for.cond139.preheader.for.end156_crit_edge, !dbg !425

for.cond139.preheader.for.end156_crit_edge:       ; preds = %for.cond139.preheader
  br label %for.end156, !dbg !425

for.body142.preheader:                            ; preds = %for.cond139.preheader
  %scevgep = getelementptr i8, ptr %alignedA, i64 %indvars.iv.next276, !dbg !425
  %25 = sub i64 254, %indvars.iv275.reg2mem252.0.load, !dbg !425
  %26 = and i64 %25, 4294967295, !dbg !425
  %27 = add nuw nsw i64 %26, 1, !dbg !425
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(1) %scevgep, i8 95, i64 %27, i1 false), !dbg !426, !tbaa !377
    #dbg_value(i64 poison, !356, !DIExpression(), !368)
    #dbg_value(i64 poison, !357, !DIExpression(DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value), !368)
  %scevgep281 = getelementptr i8, ptr %alignedB, i64 %indvars.iv.next276, !dbg !428
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(1) %scevgep281, i8 95, i64 %27, i1 false), !dbg !430, !tbaa !377
    #dbg_value(i64 poison, !357, !DIExpression(), !368)
  br label %for.end156, !dbg !433

while.body:                                       ; preds = %if.end138.while.body_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv275.reg2mem252.0.load, !357, !DIExpression(), !368)
    #dbg_value(i64 %indvars.iv275.reg2mem252.0.load, !356, !DIExpression(), !368)
    #dbg_value(i32 %b_idx.2248.reg2mem250.0.load, !355, !DIExpression(), !368)
    #dbg_value(i32 %a_idx.2247.reg2mem248.0.load, !354, !DIExpression(), !368)
  %indvars.iv275.reg2mem252.0.load = load i64, ptr %indvars.iv275.reg2mem252, align 8
  %b_idx.2248.reg2mem250.0.load = load i32, ptr %b_idx.2248.reg2mem250, align 4
  %a_idx.2247.reg2mem248.0.load = load i32, ptr %a_idx.2247.reg2mem248, align 4
  %mul87 = mul nsw i32 %b_idx.2248.reg2mem250.0.load, 129, !dbg !434
    #dbg_value(i32 %mul87, !353, !DIExpression(), !368)
  %add88 = add nsw i32 %mul87, %a_idx.2247.reg2mem248.0.load, !dbg !436
  %idxprom89 = sext i32 %add88 to i64, !dbg !438
  %arrayidx90 = getelementptr inbounds i8, ptr %ptr, i64 %idxprom89, !dbg !438
  %28 = load i8, ptr %arrayidx90, align 1, !dbg !438, !tbaa !377
  switch i8 %28, label %if.else126 [
    i8 92, label %if.then94
    i8 60, label %if.then115
  ], !dbg !439

if.then94:                                        ; preds = %while.body
  %29 = sext i32 %a_idx.2247.reg2mem248.0.load to i64, !dbg !440
  %gep242 = getelementptr i8, ptr %invariant.gep, i64 %29, !dbg !440
  %30 = load i8, ptr %gep242, align 1, !dbg !440, !tbaa !377
    #dbg_value(i64 %indvars.iv275.reg2mem252.0.load, !356, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !368)
  %arrayidx100 = getelementptr inbounds i8, ptr %alignedA, i64 %indvars.iv275.reg2mem252.0.load, !dbg !442
  store i8 %30, ptr %arrayidx100, align 1, !dbg !443, !tbaa !377
  %31 = sext i32 %b_idx.2248.reg2mem250.0.load to i64, !dbg !444
  %gep244 = getelementptr i8, ptr %invariant.gep243, i64 %31, !dbg !444
  %32 = load i8, ptr %gep244, align 1, !dbg !444, !tbaa !377
    #dbg_value(i64 %indvars.iv275.reg2mem252.0.load, !357, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !368)
  %arrayidx106 = getelementptr inbounds i8, ptr %alignedB, i64 %indvars.iv275.reg2mem252.0.load, !dbg !445
  store i8 %32, ptr %arrayidx106, align 1, !dbg !446, !tbaa !377
  %dec = add nsw i32 %a_idx.2247.reg2mem248.0.load, -1, !dbg !447
    #dbg_value(i32 %dec, !354, !DIExpression(), !368)
  %dec107 = add nsw i32 %b_idx.2248.reg2mem250.0.load, -1, !dbg !448
    #dbg_value(i32 %dec107, !355, !DIExpression(), !368)
  store i32 %dec107, ptr %b_idx.3.reg2mem244, align 4
  store i32 %dec, ptr %a_idx.3.reg2mem246, align 4
  br label %if.end138, !dbg !449

if.then115:                                       ; preds = %while.body
  %33 = sext i32 %a_idx.2247.reg2mem248.0.load to i64, !dbg !450
  %gep = getelementptr i8, ptr %invariant.gep, i64 %33, !dbg !450
  %34 = load i8, ptr %gep, align 1, !dbg !450, !tbaa !377
    #dbg_value(i64 %indvars.iv275.reg2mem252.0.load, !356, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !368)
  %arrayidx121 = getelementptr inbounds i8, ptr %alignedA, i64 %indvars.iv275.reg2mem252.0.load, !dbg !453
  store i8 %34, ptr %arrayidx121, align 1, !dbg !454, !tbaa !377
    #dbg_value(i64 %indvars.iv275.reg2mem252.0.load, !357, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !368)
  %arrayidx124 = getelementptr inbounds i8, ptr %alignedB, i64 %indvars.iv275.reg2mem252.0.load, !dbg !455
  store i8 45, ptr %arrayidx124, align 1, !dbg !456, !tbaa !377
  %dec125 = add nsw i32 %a_idx.2247.reg2mem248.0.load, -1, !dbg !457
    #dbg_value(i32 %dec125, !354, !DIExpression(), !368)
  store i32 %b_idx.2248.reg2mem250.0.load, ptr %b_idx.3.reg2mem244, align 4
  store i32 %dec125, ptr %a_idx.3.reg2mem246, align 4
  br label %if.end138, !dbg !458

if.else126:                                       ; preds = %while.body
    #dbg_value(i64 %indvars.iv275.reg2mem252.0.load, !356, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !368)
  %arrayidx129 = getelementptr inbounds i8, ptr %alignedA, i64 %indvars.iv275.reg2mem252.0.load, !dbg !459
  store i8 45, ptr %arrayidx129, align 1, !dbg !461, !tbaa !377
  %35 = sext i32 %b_idx.2248.reg2mem250.0.load to i64, !dbg !462
  %gep246 = getelementptr i8, ptr %invariant.gep243, i64 %35, !dbg !462
  %36 = load i8, ptr %gep246, align 1, !dbg !462, !tbaa !377
    #dbg_value(i64 %indvars.iv275.reg2mem252.0.load, !357, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !368)
  %arrayidx135 = getelementptr inbounds i8, ptr %alignedB, i64 %indvars.iv275.reg2mem252.0.load, !dbg !463
  store i8 %36, ptr %arrayidx135, align 1, !dbg !464, !tbaa !377
  %dec136 = add nsw i32 %b_idx.2248.reg2mem250.0.load, -1, !dbg !465
    #dbg_value(i32 %dec136, !355, !DIExpression(), !368)
  store i32 %dec136, ptr %b_idx.3.reg2mem244, align 4
  store i32 %a_idx.2247.reg2mem248.0.load, ptr %a_idx.3.reg2mem246, align 4
  br label %if.end138

if.end138:                                        ; preds = %if.then115, %if.else126, %if.then94
  %a_idx.3.reg2mem246.0.load = load i32, ptr %a_idx.3.reg2mem246, align 4
  %b_idx.3.reg2mem244.0.load = load i32, ptr %b_idx.3.reg2mem244, align 4
  %indvars.iv.next276 = add nuw i64 %indvars.iv275.reg2mem252.0.load, 1, !dbg !466
    #dbg_value(i64 %indvars.iv.next276, !357, !DIExpression(), !368)
    #dbg_value(i64 %indvars.iv.next276, !356, !DIExpression(), !368)
    #dbg_value(i32 %b_idx.3.reg2mem244.0.load, !355, !DIExpression(), !368)
    #dbg_value(i32 %a_idx.3.reg2mem246.0.load, !354, !DIExpression(), !368)
  %cmp83 = icmp sgt i32 %a_idx.3.reg2mem246.0.load, 0, !dbg !467
  %cmp85 = icmp sgt i32 %b_idx.3.reg2mem244.0.load, 0, !dbg !468
  %37 = select i1 %cmp83, i1 true, i1 %cmp85, !dbg !468
  br i1 %37, label %if.end138.while.body_crit_edge, label %for.cond139.preheader, !dbg !416, !llvm.loop !469

if.end138.while.body_crit_edge:                   ; preds = %if.end138
  store i32 %a_idx.3.reg2mem246.0.load, ptr %a_idx.2247.reg2mem248, align 4
  store i32 %b_idx.3.reg2mem244.0.load, ptr %b_idx.2248.reg2mem250, align 4
  store i64 %indvars.iv.next276, ptr %indvars.iv275.reg2mem252, align 8
  br label %while.body, !dbg !416

for.end156:                                       ; preds = %for.cond139.preheader.for.end156_crit_edge, %for.body142.preheader
  ret void, !dbg !433

polly.stmt.for.body:                              ; preds = %polly.stmt.for.body.polly.stmt.for.body_crit_edge, %polly.loop_preheader
  %polly.indvar.reg2mem.0.load = load i64, ptr %polly.indvar.reg2mem, align 8
  %38 = shl nuw nsw i64 %polly.indvar.reg2mem.0.load, 2
  %scevgep4 = getelementptr i8, ptr %M, i64 %38
  %39 = trunc i64 %polly.indvar.reg2mem.0.load to i32
  %40 = sub nsw i32 0, %39
  store i32 %40, ptr %scevgep4, align 4, !alias.scope !471, !noalias !474
  %polly.indvar_next = add nuw nsw i64 %polly.indvar.reg2mem.0.load, 1
  store i64 %polly.indvar_next, ptr %polly.indvar_next.reg2mem, align 8
  %exitcond.not = icmp eq i64 %polly.indvar_next, 129
  br i1 %exitcond.not, label %polly.loop_preheader10, label %polly.stmt.for.body.polly.stmt.for.body_crit_edge

polly.stmt.for.body.polly.stmt.for.body_crit_edge: ; preds = %polly.stmt.for.body
  store i64 %polly.indvar_next, ptr %polly.indvar.reg2mem, align 8
  br label %polly.stmt.for.body

polly.stmt.for.body3:                             ; preds = %polly.stmt.for.body3.polly.stmt.for.body3_crit_edge, %polly.loop_preheader10
  %polly.indvar12.reg2mem.0.load = load i64, ptr %polly.indvar12.reg2mem, align 8
  %41 = mul nuw nsw i64 %polly.indvar12.reg2mem.0.load, 516
  %scevgep15 = getelementptr i8, ptr %M, i64 %41
  %42 = trunc i64 %polly.indvar12.reg2mem.0.load to i32
  %43 = sub nsw i32 0, %42
  store i32 %43, ptr %scevgep15, align 4, !alias.scope !471, !noalias !474
  %polly.indvar_next13 = add nuw nsw i64 %polly.indvar12.reg2mem.0.load, 1
  store i64 %polly.indvar_next13, ptr %polly.indvar_next13.reg2mem, align 8
  %exitcond132.not = icmp eq i64 %polly.indvar_next13, 129
  br i1 %exitcond132.not, label %for.body16.lver.check.preheader, label %polly.stmt.for.body3.polly.stmt.for.body3_crit_edge

polly.stmt.for.body3.polly.stmt.for.body3_crit_edge: ; preds = %polly.stmt.for.body3
  store i64 %polly.indvar_next13, ptr %polly.indvar12.reg2mem, align 8
  br label %polly.stmt.for.body3

for.body16.lver.check.preheader:                  ; preds = %polly.stmt.for.body3
  %scevgep6 = getelementptr i8, ptr %ptr, i64 130
  store ptr %scevgep6, ptr %scevgep6.reg2mem, align 8
  %scevgep8 = getelementptr i8, ptr %M, i64 516
  store ptr %scevgep8, ptr %scevgep8.reg2mem, align 8
  store ptr %scevgep8, ptr %invariant.gep148.reg2mem, align 8
  store ptr %scevgep7, ptr %invariant.gep150.reg2mem, align 8
  store ptr %scevgep6, ptr %invariant.gep152.reg2mem, align 8
  store ptr %scevgep5, ptr %invariant.gep154.reg2mem, align 8
  store i64 1, ptr %indvars.iv269.reg2mem260, align 8
  store i64 0, ptr %indvar.reg2mem262, align 8
  br label %for.body16.lver.check, !dbg !419

polly.loop_preheader10:                           ; preds = %polly.stmt.for.body
  %scevgep5 = getelementptr i8, ptr %M, i64 1032
  store ptr %scevgep5, ptr %scevgep5.reg2mem, align 8
  %scevgep7 = getelementptr i8, ptr %ptr, i64 258
  store ptr %scevgep7, ptr %scevgep7.reg2mem, align 8
  store i64 0, ptr %polly.indvar12.reg2mem, align 8
  br label %polly.stmt.for.body3
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #3 !dbg !475 {
entry.split:
    #dbg_value(ptr %vargs, !479, !DIExpression(), !481)
    #dbg_value(ptr %vargs, !480, !DIExpression(), !481)
  %seqB = getelementptr inbounds i8, ptr %vargs, i64 128, !dbg !482
  %alignedA = getelementptr inbounds i8, ptr %vargs, i64 256, !dbg !483
  %alignedB = getelementptr inbounds i8, ptr %vargs, i64 512, !dbg !484
  %M = getelementptr inbounds i8, ptr %vargs, i64 768, !dbg !485
  %ptr = getelementptr inbounds i8, ptr %vargs, i64 67332, !dbg !486
  tail call void @nw(ptr noundef %vargs, ptr noundef nonnull %seqB, ptr noundef nonnull %alignedA, ptr noundef nonnull %alignedB, ptr noundef nonnull %M, ptr noundef nonnull %ptr) #19, !dbg !487
  ret void, !dbg !488
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #4 !dbg !489 {
entry.split:
  %s.addr.0.lcssa.ph.i14.reg2mem = alloca ptr, align 8
  %cmp23.not.i13.reg2mem = alloca i64, align 8
  %i.1.i8.reg2mem65 = alloca i32, align 4
  %s.addr.040.i3.reg2mem67 = alloca ptr, align 8
  %i.041.i2.reg2mem69 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem71 = alloca i32, align 4
  %s.addr.040.i.reg2mem73 = alloca ptr, align 8
  %i.041.i.reg2mem75 = alloca i32, align 4
    #dbg_value(i32 %fd, !493, !DIExpression(), !498)
    #dbg_value(ptr %vdata, !494, !DIExpression(), !498)
    #dbg_value(ptr %vdata, !495, !DIExpression(), !498)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(83976) %vdata, i8 0, i64 83976, i1 false), !dbg !499
  %call = tail call ptr @readfile(i32 noundef signext %fd) #19, !dbg !500
    #dbg_value(ptr %call, !496, !DIExpression(), !498)
    #dbg_value(ptr %call, !501, !DIExpression(), !508)
    #dbg_value(i32 1, !506, !DIExpression(), !508)
    #dbg_value(i32 0, !507, !DIExpression(), !508)
  store ptr %call, ptr %s.addr.040.i.reg2mem73, align 8
  store i32 0, ptr %i.041.i.reg2mem75, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem75.0.load, !507, !DIExpression(), !508)
    #dbg_value(ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, !501, !DIExpression(), !508)
  %i.041.i.reg2mem75.0.load = load i32, ptr %i.041.i.reg2mem75, align 4
  %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74 = load ptr, ptr %s.addr.040.i.reg2mem73, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, align 1, !dbg !510, !tbaa !377
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.parse_string.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !511

land.rhs.i.parse_string.exit_crit_edge:           ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %parse_string.exit, !dbg !511

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem75.0.load, ptr %i.1.i.reg2mem71, align 4
  br label %if.end21.i, !dbg !511

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, i64 1, !dbg !512
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !512, !tbaa !377
  %cmp13.i = icmp eq i8 %1, 37, !dbg !515
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !516

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem75.0.load, ptr %i.1.i.reg2mem71, align 4
  br label %if.end21.i, !dbg !516

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, i64 2, !dbg !517
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !517, !tbaa !377
  %cmp18.i = icmp eq i8 %2, 10, !dbg !518
  %inc.i = zext i1 %cmp18.i to i32, !dbg !519
  %spec.select.i = add nsw i32 %i.041.i.reg2mem75.0.load, %inc.i, !dbg !519
  store i32 %spec.select.i, ptr %i.1.i.reg2mem71, align 4
  br label %if.end21.i, !dbg !519

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem71.0.load, !507, !DIExpression(), !508)
  %i.1.i.reg2mem71.0.load = load i32, ptr %i.1.i.reg2mem71, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, i64 1, !dbg !520
    #dbg_value(ptr %incdec.ptr.i, !501, !DIExpression(), !508)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem71.0.load, 1, !dbg !521
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !522, !llvm.loop !523

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem73, align 8
  store i32 %i.1.i.reg2mem71.0.load, ptr %i.041.i.reg2mem75, align 4
  br label %land.rhs.i, !dbg !522

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !525, !tbaa !377
  %3 = icmp eq i8 %.pre.i, 0, !dbg !527
  %4 = select i1 %3, i64 0, i64 2, !dbg !528
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %parse_string.exit, !dbg !522

parse_string.exit:                                ; preds = %land.rhs.i.parse_string.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !528
    #dbg_value(ptr %spec.select38.i, !497, !DIExpression(), !498)
    #dbg_value(ptr %spec.select38.i, !529, !DIExpression(), !537)
    #dbg_value(ptr %vdata, !534, !DIExpression(), !537)
    #dbg_value(i32 128, !535, !DIExpression(), !537)
    #dbg_value(i32 128, !536, !DIExpression(), !537)
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(128) %vdata, ptr noundef nonnull readonly align 1 dereferenceable(128) %spec.select38.i, i64 128, i1 false), !dbg !539
    #dbg_value(ptr %call, !501, !DIExpression(), !540)
    #dbg_value(i32 2, !506, !DIExpression(), !540)
    #dbg_value(i32 0, !507, !DIExpression(), !540)
  store ptr %call, ptr %s.addr.040.i3.reg2mem67, align 8
  store i32 0, ptr %i.041.i2.reg2mem69, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %parse_string.exit
    #dbg_value(i32 %i.041.i2.reg2mem69.0.load, !507, !DIExpression(), !540)
    #dbg_value(ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, !501, !DIExpression(), !540)
  %i.041.i2.reg2mem69.0.load = load i32, ptr %i.041.i2.reg2mem69, align 4
  %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68 = load ptr, ptr %s.addr.040.i3.reg2mem67, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, align 1, !dbg !542, !tbaa !377
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.parse_string.exit24_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !543

land.rhs.i1.parse_string.exit24_crit_edge:        ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %parse_string.exit24, !dbg !543

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem69.0.load, ptr %i.1.i8.reg2mem65, align 4
  br label %if.end21.i7, !dbg !543

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, i64 1, !dbg !544
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !544, !tbaa !377
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !545
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !546

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem69.0.load, ptr %i.1.i8.reg2mem65, align 4
  br label %if.end21.i7, !dbg !546

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, i64 2, !dbg !547
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !547, !tbaa !377
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !548
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !549
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem69.0.load, %inc.i19, !dbg !549
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem65, align 4
  br label %if.end21.i7, !dbg !549

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem65.0.load, !507, !DIExpression(), !540)
  %i.1.i8.reg2mem65.0.load = load i32, ptr %i.1.i8.reg2mem65, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, i64 1, !dbg !550
    #dbg_value(ptr %incdec.ptr.i9, !501, !DIExpression(), !540)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem65.0.load, 2, !dbg !551
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !552, !llvm.loop !553

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem67, align 8
  store i32 %i.1.i8.reg2mem65.0.load, ptr %i.041.i2.reg2mem69, align 4
  br label %land.rhs.i1, !dbg !552

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !555, !tbaa !377
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !556
  %9 = select i1 %8, i64 0, i64 2, !dbg !557
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %parse_string.exit24, !dbg !552

parse_string.exit24:                              ; preds = %land.rhs.i1.parse_string.exit24_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !557
    #dbg_value(ptr %spec.select38.i15, !497, !DIExpression(), !498)
  %seqB = getelementptr inbounds i8, ptr %vdata, i64 128, !dbg !558
    #dbg_value(ptr %spec.select38.i15, !529, !DIExpression(), !559)
    #dbg_value(ptr %seqB, !534, !DIExpression(), !559)
    #dbg_value(i32 128, !535, !DIExpression(), !559)
    #dbg_value(i32 128, !536, !DIExpression(), !559)
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(128) %seqB, ptr noundef nonnull readonly align 1 dereferenceable(128) %spec.select38.i15, i64 128, i1 false), !dbg !561
  tail call void @free(ptr noundef %call) #19, !dbg !562
  ret void, !dbg !563
}

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !564 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #4 !dbg !566 {
entry.split:
    #dbg_value(i32 %fd, !568, !DIExpression(), !571)
    #dbg_value(ptr %vdata, !569, !DIExpression(), !571)
    #dbg_value(ptr %vdata, !570, !DIExpression(), !571)
    #dbg_value(i32 %fd, !572, !DIExpression(), !577)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !579
  br i1 %cmp.i, label %write_section_header.exit6, label %if.else.i, !dbg !579

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !579
  unreachable, !dbg !579

write_section_header.exit6:                       ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !582
  %call1 = tail call signext i32 @write_string(i32 noundef signext %fd, ptr noundef %vdata, i32 noundef signext 128) #19, !dbg !583
    #dbg_value(i32 %fd, !572, !DIExpression(), !584)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !586
  %seqB = getelementptr inbounds i8, ptr %vdata, i64 128, !dbg !587
  %call4 = tail call signext i32 @write_string(i32 noundef signext %fd, ptr noundef nonnull %seqB, i32 noundef signext 128) #19, !dbg !588
    #dbg_value(i32 %fd, !572, !DIExpression(), !589)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !591
  ret void, !dbg !592
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #4 !dbg !593 {
entry.split:
  %s.addr.0.lcssa.ph.i14.reg2mem = alloca ptr, align 8
  %cmp23.not.i13.reg2mem = alloca i64, align 8
  %i.1.i8.reg2mem65 = alloca i32, align 4
  %s.addr.040.i3.reg2mem67 = alloca ptr, align 8
  %i.041.i2.reg2mem69 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem71 = alloca i32, align 4
  %s.addr.040.i.reg2mem73 = alloca ptr, align 8
  %i.041.i.reg2mem75 = alloca i32, align 4
    #dbg_value(i32 %fd, !595, !DIExpression(), !600)
    #dbg_value(ptr %vdata, !596, !DIExpression(), !600)
    #dbg_value(ptr %vdata, !597, !DIExpression(), !600)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(83976) %vdata, i8 0, i64 83976, i1 false), !dbg !601
  %call = tail call ptr @readfile(i32 noundef signext %fd) #19, !dbg !602
    #dbg_value(ptr %call, !598, !DIExpression(), !600)
    #dbg_value(ptr %call, !501, !DIExpression(), !603)
    #dbg_value(i32 1, !506, !DIExpression(), !603)
    #dbg_value(i32 0, !507, !DIExpression(), !603)
  store ptr %call, ptr %s.addr.040.i.reg2mem73, align 8
  store i32 0, ptr %i.041.i.reg2mem75, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem75.0.load, !507, !DIExpression(), !603)
    #dbg_value(ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, !501, !DIExpression(), !603)
  %i.041.i.reg2mem75.0.load = load i32, ptr %i.041.i.reg2mem75, align 4
  %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74 = load ptr, ptr %s.addr.040.i.reg2mem73, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, align 1, !dbg !605, !tbaa !377
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.parse_string.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !606

land.rhs.i.parse_string.exit_crit_edge:           ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %parse_string.exit, !dbg !606

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem75.0.load, ptr %i.1.i.reg2mem71, align 4
  br label %if.end21.i, !dbg !606

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, i64 1, !dbg !607
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !607, !tbaa !377
  %cmp13.i = icmp eq i8 %1, 37, !dbg !608
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !609

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem75.0.load, ptr %i.1.i.reg2mem71, align 4
  br label %if.end21.i, !dbg !609

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, i64 2, !dbg !610
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !610, !tbaa !377
  %cmp18.i = icmp eq i8 %2, 10, !dbg !611
  %inc.i = zext i1 %cmp18.i to i32, !dbg !612
  %spec.select.i = add nsw i32 %i.041.i.reg2mem75.0.load, %inc.i, !dbg !612
  store i32 %spec.select.i, ptr %i.1.i.reg2mem71, align 4
  br label %if.end21.i, !dbg !612

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem71.0.load, !507, !DIExpression(), !603)
  %i.1.i.reg2mem71.0.load = load i32, ptr %i.1.i.reg2mem71, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, i64 1, !dbg !613
    #dbg_value(ptr %incdec.ptr.i, !501, !DIExpression(), !603)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem71.0.load, 1, !dbg !614
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !615, !llvm.loop !616

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem73, align 8
  store i32 %i.1.i.reg2mem71.0.load, ptr %i.041.i.reg2mem75, align 4
  br label %land.rhs.i, !dbg !615

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !618, !tbaa !377
  %3 = icmp eq i8 %.pre.i, 0, !dbg !619
  %4 = select i1 %3, i64 0, i64 2, !dbg !620
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %parse_string.exit, !dbg !615

parse_string.exit:                                ; preds = %land.rhs.i.parse_string.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !620
    #dbg_value(ptr %spec.select38.i, !599, !DIExpression(), !600)
  %alignedA = getelementptr inbounds i8, ptr %vdata, i64 256, !dbg !621
    #dbg_value(ptr %spec.select38.i, !529, !DIExpression(), !622)
    #dbg_value(ptr %alignedA, !534, !DIExpression(), !622)
    #dbg_value(i32 256, !535, !DIExpression(), !622)
    #dbg_value(i32 256, !536, !DIExpression(), !622)
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(256) %alignedA, ptr noundef nonnull readonly align 1 dereferenceable(256) %spec.select38.i, i64 256, i1 false), !dbg !624
    #dbg_value(ptr %call, !501, !DIExpression(), !625)
    #dbg_value(i32 2, !506, !DIExpression(), !625)
    #dbg_value(i32 0, !507, !DIExpression(), !625)
  store ptr %call, ptr %s.addr.040.i3.reg2mem67, align 8
  store i32 0, ptr %i.041.i2.reg2mem69, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %parse_string.exit
    #dbg_value(i32 %i.041.i2.reg2mem69.0.load, !507, !DIExpression(), !625)
    #dbg_value(ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, !501, !DIExpression(), !625)
  %i.041.i2.reg2mem69.0.load = load i32, ptr %i.041.i2.reg2mem69, align 4
  %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68 = load ptr, ptr %s.addr.040.i3.reg2mem67, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, align 1, !dbg !627, !tbaa !377
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.parse_string.exit24_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !628

land.rhs.i1.parse_string.exit24_crit_edge:        ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %parse_string.exit24, !dbg !628

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem69.0.load, ptr %i.1.i8.reg2mem65, align 4
  br label %if.end21.i7, !dbg !628

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, i64 1, !dbg !629
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !629, !tbaa !377
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !630
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !631

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem69.0.load, ptr %i.1.i8.reg2mem65, align 4
  br label %if.end21.i7, !dbg !631

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, i64 2, !dbg !632
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !632, !tbaa !377
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !633
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !634
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem69.0.load, %inc.i19, !dbg !634
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem65, align 4
  br label %if.end21.i7, !dbg !634

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem65.0.load, !507, !DIExpression(), !625)
  %i.1.i8.reg2mem65.0.load = load i32, ptr %i.1.i8.reg2mem65, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, i64 1, !dbg !635
    #dbg_value(ptr %incdec.ptr.i9, !501, !DIExpression(), !625)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem65.0.load, 2, !dbg !636
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !637, !llvm.loop !638

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem67, align 8
  store i32 %i.1.i8.reg2mem65.0.load, ptr %i.041.i2.reg2mem69, align 4
  br label %land.rhs.i1, !dbg !637

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !640, !tbaa !377
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !641
  %9 = select i1 %8, i64 0, i64 2, !dbg !642
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %parse_string.exit24, !dbg !637

parse_string.exit24:                              ; preds = %land.rhs.i1.parse_string.exit24_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !642
    #dbg_value(ptr %spec.select38.i15, !599, !DIExpression(), !600)
  %alignedB = getelementptr inbounds i8, ptr %vdata, i64 512, !dbg !643
    #dbg_value(ptr %spec.select38.i15, !529, !DIExpression(), !644)
    #dbg_value(ptr %alignedB, !534, !DIExpression(), !644)
    #dbg_value(i32 256, !535, !DIExpression(), !644)
    #dbg_value(i32 256, !536, !DIExpression(), !644)
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(256) %alignedB, ptr noundef nonnull readonly align 1 dereferenceable(256) %spec.select38.i15, i64 256, i1 false), !dbg !646
  tail call void @free(ptr noundef %call) #19, !dbg !647
  ret void, !dbg !648
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #4 !dbg !649 {
entry.split:
    #dbg_value(i32 %fd, !651, !DIExpression(), !654)
    #dbg_value(ptr %vdata, !652, !DIExpression(), !654)
    #dbg_value(ptr %vdata, !653, !DIExpression(), !654)
    #dbg_value(i32 %fd, !572, !DIExpression(), !655)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !657
  br i1 %cmp.i, label %write_section_header.exit6, label %if.else.i, !dbg !657

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !657
  unreachable, !dbg !657

write_section_header.exit6:                       ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !658
  %alignedA = getelementptr inbounds i8, ptr %vdata, i64 256, !dbg !659
  %call1 = tail call signext i32 @write_string(i32 noundef signext %fd, ptr noundef nonnull %alignedA, i32 noundef signext 256) #19, !dbg !660
    #dbg_value(i32 %fd, !572, !DIExpression(), !661)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !663
  %alignedB = getelementptr inbounds i8, ptr %vdata, i64 512, !dbg !664
  %call4 = tail call signext i32 @write_string(i32 noundef signext %fd, ptr noundef nonnull %alignedB, i32 noundef signext 256) #19, !dbg !665
    #dbg_value(i32 %fd, !572, !DIExpression(), !666)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !668
  ret void, !dbg !669
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #6 !dbg !670 {
entry.split:
    #dbg_value(ptr %vdata, !674, !DIExpression(), !679)
    #dbg_value(ptr %vref, !675, !DIExpression(), !679)
    #dbg_value(ptr %vdata, !676, !DIExpression(), !679)
    #dbg_value(ptr %vref, !677, !DIExpression(), !679)
    #dbg_value(i32 0, !678, !DIExpression(), !679)
  %alignedA = getelementptr inbounds i8, ptr %vdata, i64 256, !dbg !680
  %alignedA1 = getelementptr inbounds i8, ptr %vref, i64 256, !dbg !681
  %call = tail call signext i32 @memcmp(ptr noundef nonnull dereferenceable(256) %alignedA, ptr noundef nonnull dereferenceable(256) %alignedA1, i64 noundef 256) #21, !dbg !682
    #dbg_value(i32 %call, !678, !DIExpression(), !679)
  %alignedB = getelementptr inbounds i8, ptr %vdata, i64 512, !dbg !683
  %alignedB4 = getelementptr inbounds i8, ptr %vref, i64 512, !dbg !684
  %call6 = tail call signext i32 @memcmp(ptr noundef nonnull dereferenceable(256) %alignedB, ptr noundef nonnull dereferenceable(256) %alignedB4, i64 noundef 256) #21, !dbg !685
  %or7 = or i32 %call6, %call, !dbg !686
    #dbg_value(i32 %or7, !678, !DIExpression(), !679)
  %tobool.not = icmp eq i32 %or7, 0, !dbg !687
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !687
  ret i32 %lnot.ext, !dbg !688
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !689 signext i32 @memcmp(ptr nocapture noundef, ptr nocapture noundef, i64 noundef) local_unnamed_addr #7

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #4 !dbg !697 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !747
    #dbg_assign(i1 undef, !703, !DIExpression(), !747, ptr %s, !DIExpression(), !748)
    #dbg_value(i32 %fd, !701, !DIExpression(), !748)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #19, !dbg !749
  %cmp = icmp sgt i32 %fd, 1, !dbg !750
  br i1 %cmp, label %if.end, label %if.else, !dbg !750

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !750
  unreachable, !dbg !750

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #19, !dbg !753
  %cmp1 = icmp eq i32 %call, 0, !dbg !753
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !753

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !753
  unreachable, !dbg !753

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !756
  %0 = load i64, ptr %st_size, align 8, !dbg !756
    #dbg_value(i64 %0, !740, !DIExpression(), !748)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !757
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !757

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !757
  unreachable, !dbg !757

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !760
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #22, !dbg !761
    #dbg_value(ptr %call11, !702, !DIExpression(), !748)
    #dbg_value(i64 0, !743, !DIExpression(), !748)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !762

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !763
    #dbg_value(i64 %add19, !743, !DIExpression(), !748)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !765
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !762, !llvm.loop !766

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !762

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !743, !DIExpression(), !748)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !768
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !769
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #19, !dbg !770
    #dbg_value(i64 %call13, !746, !DIExpression(), !748)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !771
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !743, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !748)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !771

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #20, !dbg !771
  unreachable, !dbg !771

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !774
  store i8 0, ptr %arrayidx20, align 1, !dbg !775, !tbaa !377
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #19, !dbg !776
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #19, !dbg !777
  ret ptr %call11, !dbg !778
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #8

; Function Attrs: noreturn nounwind
declare !dbg !779 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare !dbg !784 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #10

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !789 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #11

; Function Attrs: nofree
declare !dbg !792 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #12

declare !dbg !796 signext i32 @close(i32 noundef signext) local_unnamed_addr #13

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #8

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #4 !dbg !502 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !501, !DIExpression(), !797)
    #dbg_value(i32 %n, !506, !DIExpression(), !797)
    #dbg_value(i32 0, !507, !DIExpression(), !797)
  %cmp = icmp sgt i32 %n, -1, !dbg !798
  br i1 %cmp, label %if.end, label %if.else, !dbg !798

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #20, !dbg !798
  unreachable, !dbg !798

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !801
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !803

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !803

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !803

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !507, !DIExpression(), !797)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !501, !DIExpression(), !797)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !804, !tbaa !377
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !805

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !805

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !805

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !806
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !806, !tbaa !377
  %cmp13 = icmp eq i8 %1, 37, !dbg !807
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !808

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !808

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !809
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !809, !tbaa !377
  %cmp18 = icmp eq i8 %2, 10, !dbg !810
  %inc = zext i1 %cmp18 to i32, !dbg !811
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !811
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !811

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !507, !DIExpression(), !797)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !812
    #dbg_value(ptr %incdec.ptr, !501, !DIExpression(), !797)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !813
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !814, !llvm.loop !815

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !814

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !817, !tbaa !377
  %3 = icmp eq i8 %.pre, 0, !dbg !818
  %4 = select i1 %3, i64 0, i64 2, !dbg !819
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !814

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !819
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !819

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !820
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !530 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !529, !DIExpression(), !821)
    #dbg_value(ptr %arr, !534, !DIExpression(), !821)
    #dbg_value(i32 %n, !535, !DIExpression(), !821)
  %cmp.not = icmp eq ptr %s, null, !dbg !822
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !822

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #20, !dbg !822
  unreachable, !dbg !822

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !825
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !827

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !828
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !830
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !830

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !536, !DIExpression(), !821)
  %conv404 = zext nneg i32 %n to i64, !dbg !831
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !832
  br label %if.end46, !dbg !833

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !536, !DIExpression(), !821)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !834
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !835

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !835

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !836
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !837
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !837
  %cmp9.not = icmp eq i8 %0, 0, !dbg !838
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !839

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !839

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !840
  %1 = load i8, ptr %gep, align 1, !dbg !840
  %cmp16.not = icmp eq i8 %1, 0, !dbg !841
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !842

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !842

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !843
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !844
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !844
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !844, !llvm.loop !845

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !844

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !831

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !831

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !831

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !831
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !536, !DIExpression(), !821)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !832
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !847
  store i8 0, ptr %arrayidx45, align 1, !dbg !849, !tbaa !377
  br label %if.end46, !dbg !847

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !850
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #14

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !851 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !863
    #dbg_assign(i1 undef, !860, !DIExpression(), !863, ptr %endptr, !DIExpression(), !864)
    #dbg_value(ptr %s, !856, !DIExpression(), !864)
    #dbg_value(ptr %arr, !857, !DIExpression(), !864)
    #dbg_value(i32 %n, !858, !DIExpression(), !864)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !865
    #dbg_value(i32 0, !861, !DIExpression(), !864)
  %cmp.not = icmp eq ptr %s, null, !dbg !866
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !866

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #20, !dbg !866
  unreachable, !dbg !866

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !865
    #dbg_value(ptr %call, !859, !DIExpression(), !864)
    #dbg_value(i32 0, !861, !DIExpression(), !864)
  %cmp130 = icmp ne ptr %call, null, !dbg !865
  %cmp231 = icmp sgt i32 %n, 0, !dbg !865
  %0 = and i1 %cmp231, %cmp130, !dbg !865
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !865

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !865

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !865
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !865

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !859, !DIExpression(), !864)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !861, !DIExpression(), !864)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !869, !tbaa !871, !DIAssignID !873
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !860, !DIExpression(), !873, ptr %endptr, !DIExpression(), !864)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !869
  %conv = trunc i64 %call3 to i8, !dbg !869
    #dbg_value(i8 %conv, !862, !DIExpression(), !864)
  %2 = load ptr, ptr %endptr, align 8, !dbg !874, !tbaa !871
  %3 = load i8, ptr %2, align 1, !dbg !874, !tbaa !377
  %cmp5.not = icmp eq i8 %3, 0, !dbg !874
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !869

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !869

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !876, !tbaa !871
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !876
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #23, !dbg !876
  br label %if.end9, !dbg !876

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !869
  store i8 %conv, ptr %arrayidx, align 1, !dbg !869, !tbaa !377
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !869
    #dbg_value(i64 %indvars.iv.next, !861, !DIExpression(), !864)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !869
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !869
  store i8 10, ptr %arrayidx11, align 1, !dbg !869, !tbaa !377
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !869
    #dbg_value(ptr %call12, !859, !DIExpression(), !864)
  %cmp1 = icmp ne ptr %call12, null, !dbg !865
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !865
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !865
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !865, !llvm.loop !878

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !865

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !865

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !865

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !865

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !879
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !879
  store i8 10, ptr %arrayidx17, align 1, !dbg !879, !tbaa !377
  br label %if.end18, !dbg !879

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !865
  ret i32 0, !dbg !865
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !882 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #15

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !887 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #15

; Function Attrs: nofree nounwind
declare !dbg !892 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #10

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !947 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #7

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !950 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !962
    #dbg_assign(i1 undef, !959, !DIExpression(), !962, ptr %endptr, !DIExpression(), !963)
    #dbg_value(ptr %s, !955, !DIExpression(), !963)
    #dbg_value(ptr %arr, !956, !DIExpression(), !963)
    #dbg_value(i32 %n, !957, !DIExpression(), !963)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !964
    #dbg_value(i32 0, !960, !DIExpression(), !963)
  %cmp.not = icmp eq ptr %s, null, !dbg !965
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !965

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #20, !dbg !965
  unreachable, !dbg !965

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !964
    #dbg_value(ptr %call, !958, !DIExpression(), !963)
    #dbg_value(i32 0, !960, !DIExpression(), !963)
  %cmp130 = icmp ne ptr %call, null, !dbg !964
  %cmp231 = icmp sgt i32 %n, 0, !dbg !964
  %0 = and i1 %cmp231, %cmp130, !dbg !964
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !964

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !964

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !964
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !964

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !958, !DIExpression(), !963)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !960, !DIExpression(), !963)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !968, !tbaa !871, !DIAssignID !970
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !959, !DIExpression(), !970, ptr %endptr, !DIExpression(), !963)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !968
  %conv = trunc i64 %call3 to i16, !dbg !968
    #dbg_value(i16 %conv, !961, !DIExpression(), !963)
  %2 = load ptr, ptr %endptr, align 8, !dbg !971, !tbaa !871
  %3 = load i8, ptr %2, align 1, !dbg !971, !tbaa !377
  %cmp5.not = icmp eq i8 %3, 0, !dbg !971
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !968

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !968

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !973, !tbaa !871
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !973
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #23, !dbg !973
  br label %if.end9, !dbg !973

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !968
  store i16 %conv, ptr %arrayidx, align 2, !dbg !968, !tbaa !975
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !968
    #dbg_value(i64 %indvars.iv.next, !960, !DIExpression(), !963)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !968
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !968
  store i8 10, ptr %arrayidx11, align 1, !dbg !968, !tbaa !377
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !968
    #dbg_value(ptr %call12, !958, !DIExpression(), !963)
  %cmp1 = icmp ne ptr %call12, null, !dbg !964
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !964
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !964
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !964, !llvm.loop !977

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !964

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !964

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !964

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !964

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !978
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !978
  store i8 10, ptr %arrayidx17, align 1, !dbg !978, !tbaa !377
  br label %if.end18, !dbg !978

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !964
  ret i32 0, !dbg !964
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !981 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !993
    #dbg_assign(i1 undef, !990, !DIExpression(), !993, ptr %endptr, !DIExpression(), !994)
    #dbg_value(ptr %s, !986, !DIExpression(), !994)
    #dbg_value(ptr %arr, !987, !DIExpression(), !994)
    #dbg_value(i32 %n, !988, !DIExpression(), !994)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !995
    #dbg_value(i32 0, !991, !DIExpression(), !994)
  %cmp.not = icmp eq ptr %s, null, !dbg !996
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !996

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #20, !dbg !996
  unreachable, !dbg !996

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !995
    #dbg_value(ptr %call, !989, !DIExpression(), !994)
    #dbg_value(i32 0, !991, !DIExpression(), !994)
  %cmp130 = icmp ne ptr %call, null, !dbg !995
  %cmp231 = icmp sgt i32 %n, 0, !dbg !995
  %0 = and i1 %cmp231, %cmp130, !dbg !995
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !995

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !995

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !995
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !995

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !989, !DIExpression(), !994)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !991, !DIExpression(), !994)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !999, !tbaa !871, !DIAssignID !1001
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !990, !DIExpression(), !1001, ptr %endptr, !DIExpression(), !994)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !999
  %conv = trunc i64 %call3 to i32, !dbg !999
    #dbg_value(i32 %conv, !992, !DIExpression(), !994)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1002, !tbaa !871
  %3 = load i8, ptr %2, align 1, !dbg !1002, !tbaa !377
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1002
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !999

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !999

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1004, !tbaa !871
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1004
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #23, !dbg !1004
  br label %if.end9, !dbg !1004

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !999
  store i32 %conv, ptr %arrayidx, align 4, !dbg !999, !tbaa !383
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !999
    #dbg_value(i64 %indvars.iv.next, !991, !DIExpression(), !994)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !999
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !999
  store i8 10, ptr %arrayidx11, align 1, !dbg !999, !tbaa !377
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !999
    #dbg_value(ptr %call12, !989, !DIExpression(), !994)
  %cmp1 = icmp ne ptr %call12, null, !dbg !995
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !995
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !995
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !995, !llvm.loop !1006

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !995

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !995

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !995

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !995

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1007
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1007
  store i8 10, ptr %arrayidx17, align 1, !dbg !1007, !tbaa !377
  br label %if.end18, !dbg !1007

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !995
  ret i32 0, !dbg !995
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1010 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1022
    #dbg_assign(i1 undef, !1019, !DIExpression(), !1022, ptr %endptr, !DIExpression(), !1023)
    #dbg_value(ptr %s, !1015, !DIExpression(), !1023)
    #dbg_value(ptr %arr, !1016, !DIExpression(), !1023)
    #dbg_value(i32 %n, !1017, !DIExpression(), !1023)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1024
    #dbg_value(i32 0, !1020, !DIExpression(), !1023)
  %cmp.not = icmp eq ptr %s, null, !dbg !1025
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1025

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #20, !dbg !1025
  unreachable, !dbg !1025

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1024
    #dbg_value(ptr %call, !1018, !DIExpression(), !1023)
    #dbg_value(i32 0, !1020, !DIExpression(), !1023)
  %cmp129 = icmp ne ptr %call, null, !dbg !1024
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1024
  %0 = and i1 %cmp230, %cmp129, !dbg !1024
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1024

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1024

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1024
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1024

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1018, !DIExpression(), !1023)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1020, !DIExpression(), !1023)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1028, !tbaa !871, !DIAssignID !1030
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1019, !DIExpression(), !1030, ptr %endptr, !DIExpression(), !1023)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1028
    #dbg_value(i64 %call3, !1021, !DIExpression(), !1023)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1031, !tbaa !871
  %3 = load i8, ptr %2, align 1, !dbg !1031, !tbaa !377
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1031
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1028

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1028

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1033, !tbaa !871
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1033
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #23, !dbg !1033
  br label %if.end8, !dbg !1033

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1028
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1028, !tbaa !1035
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1028
    #dbg_value(i64 %indvars.iv.next, !1020, !DIExpression(), !1023)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1028
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1028
  store i8 10, ptr %arrayidx10, align 1, !dbg !1028, !tbaa !377
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1028
    #dbg_value(ptr %call11, !1018, !DIExpression(), !1023)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1024
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1024
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1024
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1024, !llvm.loop !1037

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1024

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1024

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1024

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1024

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1038
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1038
  store i8 10, ptr %arrayidx16, align 1, !dbg !1038, !tbaa !377
  br label %if.end17, !dbg !1038

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1024
  ret i32 0, !dbg !1024
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1041 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1053
    #dbg_assign(i1 undef, !1050, !DIExpression(), !1053, ptr %endptr, !DIExpression(), !1054)
    #dbg_value(ptr %s, !1046, !DIExpression(), !1054)
    #dbg_value(ptr %arr, !1047, !DIExpression(), !1054)
    #dbg_value(i32 %n, !1048, !DIExpression(), !1054)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1055
    #dbg_value(i32 0, !1051, !DIExpression(), !1054)
  %cmp.not = icmp eq ptr %s, null, !dbg !1056
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1056

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #20, !dbg !1056
  unreachable, !dbg !1056

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1055
    #dbg_value(ptr %call, !1049, !DIExpression(), !1054)
    #dbg_value(i32 0, !1051, !DIExpression(), !1054)
  %cmp130 = icmp ne ptr %call, null, !dbg !1055
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1055
  %0 = and i1 %cmp231, %cmp130, !dbg !1055
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1055

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1055

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1055
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1055

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1049, !DIExpression(), !1054)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1051, !DIExpression(), !1054)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1059, !tbaa !871, !DIAssignID !1061
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1050, !DIExpression(), !1061, ptr %endptr, !DIExpression(), !1054)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1059
  %conv = trunc i64 %call3 to i8, !dbg !1059
    #dbg_value(i8 %conv, !1052, !DIExpression(), !1054)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1062, !tbaa !871
  %3 = load i8, ptr %2, align 1, !dbg !1062, !tbaa !377
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1062
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1059

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1059

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1064, !tbaa !871
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1064
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #23, !dbg !1064
  br label %if.end9, !dbg !1064

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1059
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1059, !tbaa !377
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1059
    #dbg_value(i64 %indvars.iv.next, !1051, !DIExpression(), !1054)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1059
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1059
  store i8 10, ptr %arrayidx11, align 1, !dbg !1059, !tbaa !377
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1059
    #dbg_value(ptr %call12, !1049, !DIExpression(), !1054)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1055
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1055
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1055
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1055, !llvm.loop !1066

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1055

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1055

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1055

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1055

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1067
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1067
  store i8 10, ptr %arrayidx17, align 1, !dbg !1067, !tbaa !377
  br label %if.end18, !dbg !1067

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1055
  ret i32 0, !dbg !1055
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1070 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1082
    #dbg_assign(i1 undef, !1079, !DIExpression(), !1082, ptr %endptr, !DIExpression(), !1083)
    #dbg_value(ptr %s, !1075, !DIExpression(), !1083)
    #dbg_value(ptr %arr, !1076, !DIExpression(), !1083)
    #dbg_value(i32 %n, !1077, !DIExpression(), !1083)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1084
    #dbg_value(i32 0, !1080, !DIExpression(), !1083)
  %cmp.not = icmp eq ptr %s, null, !dbg !1085
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1085

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #20, !dbg !1085
  unreachable, !dbg !1085

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1084
    #dbg_value(ptr %call, !1078, !DIExpression(), !1083)
    #dbg_value(i32 0, !1080, !DIExpression(), !1083)
  %cmp130 = icmp ne ptr %call, null, !dbg !1084
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1084
  %0 = and i1 %cmp231, %cmp130, !dbg !1084
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1084

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1084

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1084
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1084

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1078, !DIExpression(), !1083)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1080, !DIExpression(), !1083)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1088, !tbaa !871, !DIAssignID !1090
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1079, !DIExpression(), !1090, ptr %endptr, !DIExpression(), !1083)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1088
  %conv = trunc i64 %call3 to i16, !dbg !1088
    #dbg_value(i16 %conv, !1081, !DIExpression(), !1083)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1091, !tbaa !871
  %3 = load i8, ptr %2, align 1, !dbg !1091, !tbaa !377
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1091
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1088

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1088

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1093, !tbaa !871
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1093
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #23, !dbg !1093
  br label %if.end9, !dbg !1093

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1088
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1088, !tbaa !975
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1088
    #dbg_value(i64 %indvars.iv.next, !1080, !DIExpression(), !1083)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1088
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1088
  store i8 10, ptr %arrayidx11, align 1, !dbg !1088, !tbaa !377
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1088
    #dbg_value(ptr %call12, !1078, !DIExpression(), !1083)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1084
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1084
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1084
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1084, !llvm.loop !1095

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1084

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1084

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1084

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1084

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1096
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1096
  store i8 10, ptr %arrayidx17, align 1, !dbg !1096, !tbaa !377
  br label %if.end18, !dbg !1096

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1084
  ret i32 0, !dbg !1084
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1099 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1111
    #dbg_assign(i1 undef, !1108, !DIExpression(), !1111, ptr %endptr, !DIExpression(), !1112)
    #dbg_value(ptr %s, !1104, !DIExpression(), !1112)
    #dbg_value(ptr %arr, !1105, !DIExpression(), !1112)
    #dbg_value(i32 %n, !1106, !DIExpression(), !1112)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1113
    #dbg_value(i32 0, !1109, !DIExpression(), !1112)
  %cmp.not = icmp eq ptr %s, null, !dbg !1114
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1114

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #20, !dbg !1114
  unreachable, !dbg !1114

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1113
    #dbg_value(ptr %call, !1107, !DIExpression(), !1112)
    #dbg_value(i32 0, !1109, !DIExpression(), !1112)
  %cmp130 = icmp ne ptr %call, null, !dbg !1113
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1113
  %0 = and i1 %cmp231, %cmp130, !dbg !1113
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1113

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1113

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1113
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1113

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1107, !DIExpression(), !1112)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1109, !DIExpression(), !1112)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1117, !tbaa !871, !DIAssignID !1119
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1108, !DIExpression(), !1119, ptr %endptr, !DIExpression(), !1112)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1117
  %conv = trunc i64 %call3 to i32, !dbg !1117
    #dbg_value(i32 %conv, !1110, !DIExpression(), !1112)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1120, !tbaa !871
  %3 = load i8, ptr %2, align 1, !dbg !1120, !tbaa !377
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1120
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1117

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1117

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1122, !tbaa !871
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1122
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #23, !dbg !1122
  br label %if.end9, !dbg !1122

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1117
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1117, !tbaa !383
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1117
    #dbg_value(i64 %indvars.iv.next, !1109, !DIExpression(), !1112)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1117
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1117
  store i8 10, ptr %arrayidx11, align 1, !dbg !1117, !tbaa !377
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1117
    #dbg_value(ptr %call12, !1107, !DIExpression(), !1112)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1113
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1113
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1113
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1113, !llvm.loop !1124

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1113

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1113

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1113

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1113

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1125
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1125
  store i8 10, ptr %arrayidx17, align 1, !dbg !1125, !tbaa !377
  br label %if.end18, !dbg !1125

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1113
  ret i32 0, !dbg !1113
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1128 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1140
    #dbg_assign(i1 undef, !1137, !DIExpression(), !1140, ptr %endptr, !DIExpression(), !1141)
    #dbg_value(ptr %s, !1133, !DIExpression(), !1141)
    #dbg_value(ptr %arr, !1134, !DIExpression(), !1141)
    #dbg_value(i32 %n, !1135, !DIExpression(), !1141)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1142
    #dbg_value(i32 0, !1138, !DIExpression(), !1141)
  %cmp.not = icmp eq ptr %s, null, !dbg !1143
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1143

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #20, !dbg !1143
  unreachable, !dbg !1143

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1142
    #dbg_value(ptr %call, !1136, !DIExpression(), !1141)
    #dbg_value(i32 0, !1138, !DIExpression(), !1141)
  %cmp129 = icmp ne ptr %call, null, !dbg !1142
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1142
  %0 = and i1 %cmp230, %cmp129, !dbg !1142
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1142

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1142

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1142
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1142

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1136, !DIExpression(), !1141)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1138, !DIExpression(), !1141)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1146, !tbaa !871, !DIAssignID !1148
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1137, !DIExpression(), !1148, ptr %endptr, !DIExpression(), !1141)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #19, !dbg !1146
    #dbg_value(i64 %call3, !1139, !DIExpression(), !1141)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1149, !tbaa !871
  %3 = load i8, ptr %2, align 1, !dbg !1149, !tbaa !377
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1149
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1146

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1146

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1151, !tbaa !871
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1151
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #23, !dbg !1151
  br label %if.end8, !dbg !1151

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1146
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1146, !tbaa !1035
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1146
    #dbg_value(i64 %indvars.iv.next, !1138, !DIExpression(), !1141)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1146
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1146
  store i8 10, ptr %arrayidx10, align 1, !dbg !1146, !tbaa !377
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1146
    #dbg_value(ptr %call11, !1136, !DIExpression(), !1141)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1142
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1142
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1142
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1142, !llvm.loop !1153

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1142

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1142

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1142

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1142

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1154
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1154
  store i8 10, ptr %arrayidx16, align 1, !dbg !1154, !tbaa !377
  br label %if.end17, !dbg !1154

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1142
  ret i32 0, !dbg !1142
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1157 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1169
    #dbg_assign(i1 undef, !1166, !DIExpression(), !1169, ptr %endptr, !DIExpression(), !1170)
    #dbg_value(ptr %s, !1162, !DIExpression(), !1170)
    #dbg_value(ptr %arr, !1163, !DIExpression(), !1170)
    #dbg_value(i32 %n, !1164, !DIExpression(), !1170)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1171
    #dbg_value(i32 0, !1167, !DIExpression(), !1170)
  %cmp.not = icmp eq ptr %s, null, !dbg !1172
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1172

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #20, !dbg !1172
  unreachable, !dbg !1172

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1171
    #dbg_value(ptr %call, !1165, !DIExpression(), !1170)
    #dbg_value(i32 0, !1167, !DIExpression(), !1170)
  %cmp129 = icmp ne ptr %call, null, !dbg !1171
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1171
  %0 = and i1 %cmp230, %cmp129, !dbg !1171
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1171

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1171

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1171
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1171

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1165, !DIExpression(), !1170)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1167, !DIExpression(), !1170)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1175, !tbaa !871, !DIAssignID !1177
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1166, !DIExpression(), !1177, ptr %endptr, !DIExpression(), !1170)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #19, !dbg !1175
    #dbg_value(float %call3, !1168, !DIExpression(), !1170)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1178, !tbaa !871
  %3 = load i8, ptr %2, align 1, !dbg !1178, !tbaa !377
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1178
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1175

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1175

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1180, !tbaa !871
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1180
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #23, !dbg !1180
  br label %if.end8, !dbg !1180

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1175
  store float %call3, ptr %arrayidx, align 4, !dbg !1175, !tbaa !1182
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1175
    #dbg_value(i64 %indvars.iv.next, !1167, !DIExpression(), !1170)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1175
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1175
  store i8 10, ptr %arrayidx10, align 1, !dbg !1175, !tbaa !377
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1175
    #dbg_value(ptr %call11, !1165, !DIExpression(), !1170)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1171
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1171
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1171
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1171, !llvm.loop !1184

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1171

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1171

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1171

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1171

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1185
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1185
  store i8 10, ptr %arrayidx16, align 1, !dbg !1185, !tbaa !377
  br label %if.end17, !dbg !1185

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1171
  ret i32 0, !dbg !1171
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1188 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1191 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1203
    #dbg_assign(i1 undef, !1200, !DIExpression(), !1203, ptr %endptr, !DIExpression(), !1204)
    #dbg_value(ptr %s, !1196, !DIExpression(), !1204)
    #dbg_value(ptr %arr, !1197, !DIExpression(), !1204)
    #dbg_value(i32 %n, !1198, !DIExpression(), !1204)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1205
    #dbg_value(i32 0, !1201, !DIExpression(), !1204)
  %cmp.not = icmp eq ptr %s, null, !dbg !1206
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1206

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #20, !dbg !1206
  unreachable, !dbg !1206

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #19, !dbg !1205
    #dbg_value(ptr %call, !1199, !DIExpression(), !1204)
    #dbg_value(i32 0, !1201, !DIExpression(), !1204)
  %cmp129 = icmp ne ptr %call, null, !dbg !1205
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1205
  %0 = and i1 %cmp230, %cmp129, !dbg !1205
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1205

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1205

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1205
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1205

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1199, !DIExpression(), !1204)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1201, !DIExpression(), !1204)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1209, !tbaa !871, !DIAssignID !1211
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1200, !DIExpression(), !1211, ptr %endptr, !DIExpression(), !1204)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #19, !dbg !1209
    #dbg_value(double %call3, !1202, !DIExpression(), !1204)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1212, !tbaa !871
  %3 = load i8, ptr %2, align 1, !dbg !1212, !tbaa !377
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1212
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1209

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1209

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1214, !tbaa !871
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1214
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #23, !dbg !1214
  br label %if.end8, !dbg !1214

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1209
  store double %call3, ptr %arrayidx, align 8, !dbg !1209, !tbaa !1216
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1209
    #dbg_value(i64 %indvars.iv.next, !1201, !DIExpression(), !1204)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1209
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1209
  store i8 10, ptr %arrayidx10, align 1, !dbg !1209, !tbaa !377
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #19, !dbg !1209
    #dbg_value(ptr %call11, !1199, !DIExpression(), !1204)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1205
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1205
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1205
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1205, !llvm.loop !1218

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1205

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1205

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1205

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1205

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1219
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1219
  store i8 10, ptr %arrayidx16, align 1, !dbg !1219, !tbaa !377
  br label %if.end17, !dbg !1219

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #19, !dbg !1205
  ret i32 0, !dbg !1205
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1222 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1225 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1229, !DIExpression(), !1234)
    #dbg_value(ptr %arr, !1230, !DIExpression(), !1234)
    #dbg_value(i32 %n, !1231, !DIExpression(), !1234)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1235
  br i1 %cmp, label %if.end, label %if.else, !dbg !1235

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #20, !dbg !1235
  unreachable, !dbg !1235

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1238
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1240

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1240

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #21, !dbg !1241
  %conv = trunc i64 %call to i32, !dbg !1241
    #dbg_value(i32 %conv, !1231, !DIExpression(), !1234)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1243

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1231, !DIExpression(), !1234)
    #dbg_value(i32 0, !1233, !DIExpression(), !1234)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1244
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1245

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1245

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1245

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1246

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1247
    #dbg_value(i32 %add, !1233, !DIExpression(), !1234)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1244
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1245, !llvm.loop !1249

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1245

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1245

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1233, !DIExpression(), !1234)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1251
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1251
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1252
  %conv6 = sext i32 %sub to i64, !dbg !1253
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #19, !dbg !1254
  %conv8 = trunc i64 %call7 to i32, !dbg !1254
    #dbg_value(i32 %conv8, !1232, !DIExpression(), !1234)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1255
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1233, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1234)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1255

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #20, !dbg !1255
  unreachable, !dbg !1255

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #19, !dbg !1258
  %conv16 = trunc i64 %call15 to i32, !dbg !1258
    #dbg_value(i32 %conv16, !1232, !DIExpression(), !1234)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1260
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1260

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #20, !dbg !1260
  unreachable, !dbg !1260

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1263
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1264, !llvm.loop !1265

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1264

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1267
}

; Function Attrs: nofree
declare !dbg !1268 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1271 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1275, !DIExpression(), !1279)
    #dbg_value(ptr %arr, !1276, !DIExpression(), !1279)
    #dbg_value(i32 %n, !1277, !DIExpression(), !1279)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1280
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1280

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1278, !DIExpression(), !1279)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1283
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1286

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1286

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1283
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1286

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #20, !dbg !1280
  unreachable, !dbg !1280

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1278, !DIExpression(), !1279)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1287
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1287, !tbaa !377
  %conv = zext i8 %0 to i32, !dbg !1287
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1287
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1283
    #dbg_value(i64 %indvars.iv.next, !1278, !DIExpression(), !1279)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1283
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1286, !llvm.loop !1289

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1286

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1286

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1290
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #16 !dbg !1291 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1305
    #dbg_assign(i1 undef, !1297, !DIExpression(), !1305, ptr %args, !DIExpression(), !1306)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1307
    #dbg_assign(i1 undef, !1304, !DIExpression(), !1307, ptr %buffer, !DIExpression(), !1306)
    #dbg_value(i32 %fd, !1295, !DIExpression(), !1306)
    #dbg_value(ptr %format, !1296, !DIExpression(), !1306)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #19, !dbg !1308
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #19, !dbg !1309
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1310
  %0 = load ptr, ptr %args, align 8, !dbg !1311, !tbaa !871
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #19, !dbg !1312
    #dbg_value(i32 %call, !1301, !DIExpression(), !1306)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1313
  %cmp = icmp slt i32 %call, 256, !dbg !1314
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1314

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1302, !DIExpression(), !1306)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1317
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1318

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1318

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1318

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #20, !dbg !1314
  unreachable, !dbg !1314

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1319
    #dbg_value(i32 %add, !1302, !DIExpression(), !1306)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1317
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1318, !llvm.loop !1321

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1318

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1318

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1302, !DIExpression(), !1306)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1323
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1323
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1324
  %conv = sext i32 %sub to i64, !dbg !1325
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #19, !dbg !1326
  %conv3 = trunc i64 %call2 to i32, !dbg !1326
    #dbg_value(i32 %conv3, !1303, !DIExpression(), !1306)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1327
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1302, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1306)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1327

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #20, !dbg !1327
  unreachable, !dbg !1327

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1330
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1330

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #20, !dbg !1330
  unreachable, !dbg !1330

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #19, !dbg !1333
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #19, !dbg !1333
  ret void, !dbg !1334
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #17

; Function Attrs: nofree nounwind
declare !dbg !1335 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #10

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #17

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1340 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #20, !dbg !1349
  unreachable, !dbg !1349

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1347, !DIExpression(), !1348)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1356
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1356, !tbaa !975
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
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1360 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #20, !dbg !1369
  unreachable, !dbg !1369

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1367, !DIExpression(), !1368)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1376
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1376, !tbaa !383
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
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1380 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #20, !dbg !1389
  unreachable, !dbg !1389

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1387, !DIExpression(), !1388)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1396
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1396, !tbaa !1035
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
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1400 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #20, !dbg !1409
  unreachable, !dbg !1409

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1407, !DIExpression(), !1408)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1416
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1416, !tbaa !377
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
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1420 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #20, !dbg !1429
  unreachable, !dbg !1429

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1427, !DIExpression(), !1428)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1436
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1436, !tbaa !975
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
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1440 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1444, !DIExpression(), !1448)
    #dbg_value(ptr %arr, !1445, !DIExpression(), !1448)
    #dbg_value(i32 %n, !1446, !DIExpression(), !1448)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1449
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1449

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1447, !DIExpression(), !1448)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1452
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1455

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1455

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1452
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1455

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #20, !dbg !1449
  unreachable, !dbg !1449

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1447, !DIExpression(), !1448)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1456
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1456, !tbaa !383
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1456
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1452
    #dbg_value(i64 %indvars.iv.next, !1447, !DIExpression(), !1448)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1452
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1455, !llvm.loop !1458

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1455

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1455

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1459
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1460 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1464, !DIExpression(), !1468)
    #dbg_value(ptr %arr, !1465, !DIExpression(), !1468)
    #dbg_value(i32 %n, !1466, !DIExpression(), !1468)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1469
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1469

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1467, !DIExpression(), !1468)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1472
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1475

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1475

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1472
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1475

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #20, !dbg !1469
  unreachable, !dbg !1469

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1467, !DIExpression(), !1468)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1476
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1476, !tbaa !1035
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1476
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1472
    #dbg_value(i64 %indvars.iv.next, !1467, !DIExpression(), !1468)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1472
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1475, !llvm.loop !1478

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1475

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1475

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1479
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1480 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1484, !DIExpression(), !1488)
    #dbg_value(ptr %arr, !1485, !DIExpression(), !1488)
    #dbg_value(i32 %n, !1486, !DIExpression(), !1488)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1489
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1489

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1487, !DIExpression(), !1488)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1492
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1495

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1495

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1492
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1495

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #20, !dbg !1489
  unreachable, !dbg !1489

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1487, !DIExpression(), !1488)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1496
  %0 = load float, ptr %arrayidx, align 4, !dbg !1496, !tbaa !1182
  %conv = fpext float %0 to double, !dbg !1496
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1496
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1492
    #dbg_value(i64 %indvars.iv.next, !1487, !DIExpression(), !1488)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1492
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1495, !llvm.loop !1498

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1495

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1495

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1499
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #4 !dbg !1500 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1504, !DIExpression(), !1508)
    #dbg_value(ptr %arr, !1505, !DIExpression(), !1508)
    #dbg_value(i32 %n, !1506, !DIExpression(), !1508)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1509
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1509

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1507, !DIExpression(), !1508)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1512
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1515

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1515

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1512
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1515

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #20, !dbg !1509
  unreachable, !dbg !1509

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1507, !DIExpression(), !1508)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1516
  %0 = load double, ptr %arrayidx, align 8, !dbg !1516, !tbaa !1216
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1516
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1512
    #dbg_value(i64 %indvars.iv.next, !1507, !DIExpression(), !1508)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1512
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1515, !llvm.loop !1518

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1515

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1515

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1519
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #4 !dbg !573 {
entry.split:
    #dbg_value(i32 %fd, !572, !DIExpression(), !1520)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1521
  br i1 %cmp, label %if.end, label %if.else, !dbg !1521

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !1521
  unreachable, !dbg !1521

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1522
  ret i32 0, !dbg !1523
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #4 !dbg !1524 {
entry.split:
  %call.reg2mem = alloca ptr, align 8
  %retval.0.reg2mem = alloca i32, align 4
  %s.addr.0.lcssa.ph.i14.i35.reg2mem = alloca ptr, align 8
  %cmp23.not.i13.i34.reg2mem = alloca i64, align 8
  %i.1.i8.i29.reg2mem168 = alloca i32, align 4
  %s.addr.040.i3.i24.reg2mem170 = alloca ptr, align 8
  %i.041.i2.i23.reg2mem172 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.i19.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i18.reg2mem = alloca i64, align 8
  %i.1.i.i12.reg2mem174 = alloca i32, align 4
  %s.addr.040.i.i7.reg2mem176 = alloca ptr, align 8
  %i.041.i.i6.reg2mem178 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i14.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i13.i.reg2mem = alloca i64, align 8
  %i.1.i8.i.reg2mem180 = alloca i32, align 4
  %s.addr.040.i3.i.reg2mem182 = alloca ptr, align 8
  %i.041.i2.i.reg2mem184 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem186 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem188 = alloca ptr, align 8
  %i.041.i.i.reg2mem190 = alloca i32, align 4
  %check_file.0.reg2mem192 = alloca ptr, align 8
  %in_file.053.reg2mem194 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1528, !DIExpression(), !1537)
    #dbg_value(ptr %argv, !1529, !DIExpression(), !1537)
  %cmp = icmp slt i32 %argc, 4, !dbg !1538
  br i1 %cmp, label %if.end, label %if.else, !dbg !1538

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1538
  unreachable, !dbg !1538

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1530, !DIExpression(), !1537)
    #dbg_value(ptr @.str.4.13, !1531, !DIExpression(), !1537)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1541
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1543

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.13, ptr %check_file.0.reg2mem192, align 8
  store ptr @.str.3, ptr %in_file.053.reg2mem194, align 8
  br label %if.end7, !dbg !1543

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1544
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1544
    #dbg_value(ptr %0, !1530, !DIExpression(), !1537)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1545
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1547

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.13, ptr %check_file.0.reg2mem192, align 8
  store ptr %0, ptr %in_file.053.reg2mem194, align 8
  br label %if.end7, !dbg !1547

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1548
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1548
    #dbg_value(ptr %1, !1531, !DIExpression(), !1537)
  store ptr %1, ptr %check_file.0.reg2mem192, align 8
  store ptr %0, ptr %in_file.053.reg2mem194, align 8
  br label %if.end7, !dbg !1549

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem192.0.check_file.0.reload193, !1531, !DIExpression(), !1537)
  %in_file.053.reg2mem194.0.in_file.053.reload195 = load ptr, ptr %in_file.053.reg2mem194, align 8
  %check_file.0.reg2mem192.0.check_file.0.reload193 = load ptr, ptr %check_file.0.reg2mem192, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1550, !tbaa !383
  %conv = sext i32 %2 to i64, !dbg !1550
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #22, !dbg !1551
    #dbg_value(ptr %call, !1533, !DIExpression(), !1537)
  store ptr %call, ptr %call.reg2mem, align 8
  %cmp8.not = icmp eq ptr %call, null, !dbg !1552
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1552

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.14, ptr noundef nonnull @.str.2.12, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1552
  unreachable, !dbg !1552

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.053.reg2mem194.0.in_file.053.reload195, i32 noundef signext 0) #19, !dbg !1555
    #dbg_value(i32 %call14, !1532, !DIExpression(), !1537)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1556
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1556

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.15, ptr noundef nonnull @.str.2.12, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1556
  unreachable, !dbg !1556

if.end20:                                         ; preds = %if.end13
    #dbg_value(i32 %call14, !493, !DIExpression(), !1559)
    #dbg_value(ptr %call, !494, !DIExpression(), !1559)
    #dbg_value(ptr %call, !495, !DIExpression(), !1559)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(83976) %call, i8 0, i64 83976, i1 false), !dbg !1561
  %call.i = tail call ptr @readfile(i32 noundef signext %call14) #19, !dbg !1562
    #dbg_value(ptr %call.i, !496, !DIExpression(), !1559)
    #dbg_value(ptr %call.i, !501, !DIExpression(), !1563)
    #dbg_value(i32 1, !506, !DIExpression(), !1563)
    #dbg_value(i32 0, !507, !DIExpression(), !1563)
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem188, align 8
  store i32 0, ptr %i.041.i.i.reg2mem190, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end20
    #dbg_value(i32 %i.041.i.i.reg2mem190.0.load, !507, !DIExpression(), !1563)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem188.0.s.addr.040.i.i.reload189, !501, !DIExpression(), !1563)
  %i.041.i.i.reg2mem190.0.load = load i32, ptr %i.041.i.i.reg2mem190, align 4
  %s.addr.040.i.i.reg2mem188.0.s.addr.040.i.i.reload189 = load ptr, ptr %s.addr.040.i.i.reg2mem188, align 8
  %3 = load i8, ptr %s.addr.040.i.i.reg2mem188.0.s.addr.040.i.i.reload189, align 1, !dbg !1565, !tbaa !377
  switch i8 %3, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.parse_string.exit.i_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1566

land.rhs.i.i.parse_string.exit.i_crit_edge:       ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem188.0.s.addr.040.i.i.reload189, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %parse_string.exit.i, !dbg !1566

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem190.0.load, ptr %i.1.i.i.reg2mem186, align 4
  br label %if.end21.i.i, !dbg !1566

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem188.0.s.addr.040.i.i.reload189, i64 1, !dbg !1567
  %4 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !1567, !tbaa !377
  %cmp13.i.i = icmp eq i8 %4, 37, !dbg !1568
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1569

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem190.0.load, ptr %i.1.i.i.reg2mem186, align 4
  br label %if.end21.i.i, !dbg !1569

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem188.0.s.addr.040.i.i.reload189, i64 2, !dbg !1570
  %5 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1570, !tbaa !377
  %cmp18.i.i = icmp eq i8 %5, 10, !dbg !1571
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1572
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem190.0.load, %inc.i.i, !dbg !1572
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem186, align 4
  br label %if.end21.i.i, !dbg !1572

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem186.0.load, !507, !DIExpression(), !1563)
  %i.1.i.i.reg2mem186.0.load = load i32, ptr %i.1.i.i.reg2mem186, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem188.0.s.addr.040.i.i.reload189, i64 1, !dbg !1573
    #dbg_value(ptr %incdec.ptr.i.i, !501, !DIExpression(), !1563)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem186.0.load, 1, !dbg !1574
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1575, !llvm.loop !1576

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem188, align 8
  store i32 %i.1.i.i.reg2mem186.0.load, ptr %i.041.i.i.reg2mem190, align 4
  br label %land.rhs.i.i, !dbg !1575

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1578, !tbaa !377
  %6 = icmp eq i8 %.pre.i.i, 0, !dbg !1579
  %7 = select i1 %6, i64 0, i64 2, !dbg !1580
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %7, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %parse_string.exit.i, !dbg !1575

parse_string.exit.i:                              ; preds = %land.rhs.i.i.parse_string.exit.i_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1580
    #dbg_value(ptr %spec.select38.i.i, !497, !DIExpression(), !1559)
    #dbg_value(ptr %spec.select38.i.i, !529, !DIExpression(), !1581)
    #dbg_value(ptr %call, !534, !DIExpression(), !1581)
    #dbg_value(i32 128, !535, !DIExpression(), !1581)
    #dbg_value(i32 128, !536, !DIExpression(), !1581)
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(128) %call, ptr noundef nonnull readonly align 1 dereferenceable(128) %spec.select38.i.i, i64 128, i1 false), !dbg !1583
    #dbg_value(ptr %call.i, !501, !DIExpression(), !1584)
    #dbg_value(i32 2, !506, !DIExpression(), !1584)
    #dbg_value(i32 0, !507, !DIExpression(), !1584)
  store ptr %call.i, ptr %s.addr.040.i3.i.reg2mem182, align 8
  store i32 0, ptr %i.041.i2.i.reg2mem184, align 4
  br label %land.rhs.i1.i

land.rhs.i1.i:                                    ; preds = %if.end21.i7.i.land.rhs.i1.i_crit_edge, %parse_string.exit.i
    #dbg_value(i32 %i.041.i2.i.reg2mem184.0.load, !507, !DIExpression(), !1584)
    #dbg_value(ptr %s.addr.040.i3.i.reg2mem182.0.s.addr.040.i3.i.reload183, !501, !DIExpression(), !1584)
  %i.041.i2.i.reg2mem184.0.load = load i32, ptr %i.041.i2.i.reg2mem184, align 4
  %s.addr.040.i3.i.reg2mem182.0.s.addr.040.i3.i.reload183 = load ptr, ptr %s.addr.040.i3.i.reg2mem182, align 8
  %8 = load i8, ptr %s.addr.040.i3.i.reg2mem182.0.s.addr.040.i3.i.reload183, align 1, !dbg !1586, !tbaa !377
  switch i8 %8, label %land.rhs.i1.i.if.end21.i7.i_crit_edge [
    i8 0, label %land.rhs.i1.i.input_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i4.i
  ], !dbg !1587

land.rhs.i1.i.input_to_data.exit_crit_edge:       ; preds = %land.rhs.i1.i
  store ptr %s.addr.040.i3.i.reg2mem182.0.s.addr.040.i3.i.reload183, ptr %s.addr.0.lcssa.ph.i14.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.i.reg2mem, align 8
  br label %input_to_data.exit, !dbg !1587

land.rhs.i1.i.if.end21.i7.i_crit_edge:            ; preds = %land.rhs.i1.i
  store i32 %i.041.i2.i.reg2mem184.0.load, ptr %i.1.i8.i.reg2mem180, align 4
  br label %if.end21.i7.i, !dbg !1587

land.lhs.true10.i4.i:                             ; preds = %land.rhs.i1.i
  %arrayidx11.i5.i = getelementptr inbounds i8, ptr %s.addr.040.i3.i.reg2mem182.0.s.addr.040.i3.i.reload183, i64 1, !dbg !1588
  %9 = load i8, ptr %arrayidx11.i5.i, align 1, !dbg !1588, !tbaa !377
  %cmp13.i6.i = icmp eq i8 %9, 37, !dbg !1589
  br i1 %cmp13.i6.i, label %land.lhs.true15.i16.i, label %land.lhs.true10.i4.i.if.end21.i7.i_crit_edge, !dbg !1590

land.lhs.true10.i4.i.if.end21.i7.i_crit_edge:     ; preds = %land.lhs.true10.i4.i
  store i32 %i.041.i2.i.reg2mem184.0.load, ptr %i.1.i8.i.reg2mem180, align 4
  br label %if.end21.i7.i, !dbg !1590

land.lhs.true15.i16.i:                            ; preds = %land.lhs.true10.i4.i
  %arrayidx16.i17.i = getelementptr inbounds i8, ptr %s.addr.040.i3.i.reg2mem182.0.s.addr.040.i3.i.reload183, i64 2, !dbg !1591
  %10 = load i8, ptr %arrayidx16.i17.i, align 1, !dbg !1591, !tbaa !377
  %cmp18.i18.i = icmp eq i8 %10, 10, !dbg !1592
  %inc.i19.i = zext i1 %cmp18.i18.i to i32, !dbg !1593
  %spec.select.i20.i = add nsw i32 %i.041.i2.i.reg2mem184.0.load, %inc.i19.i, !dbg !1593
  store i32 %spec.select.i20.i, ptr %i.1.i8.i.reg2mem180, align 4
  br label %if.end21.i7.i, !dbg !1593

if.end21.i7.i:                                    ; preds = %land.lhs.true10.i4.i.if.end21.i7.i_crit_edge, %land.rhs.i1.i.if.end21.i7.i_crit_edge, %land.lhs.true15.i16.i
    #dbg_value(i32 %i.1.i8.i.reg2mem180.0.load, !507, !DIExpression(), !1584)
  %i.1.i8.i.reg2mem180.0.load = load i32, ptr %i.1.i8.i.reg2mem180, align 4
  %incdec.ptr.i9.i = getelementptr inbounds i8, ptr %s.addr.040.i3.i.reg2mem182.0.s.addr.040.i3.i.reload183, i64 1, !dbg !1594
    #dbg_value(ptr %incdec.ptr.i9.i, !501, !DIExpression(), !1584)
  %cmp4.i10.i = icmp slt i32 %i.1.i8.i.reg2mem180.0.load, 2, !dbg !1595
  br i1 %cmp4.i10.i, label %if.end21.i7.i.land.rhs.i1.i_crit_edge, label %if.end21.while.end_crit_edge.i11.i, !dbg !1596, !llvm.loop !1597

if.end21.i7.i.land.rhs.i1.i_crit_edge:            ; preds = %if.end21.i7.i
  store ptr %incdec.ptr.i9.i, ptr %s.addr.040.i3.i.reg2mem182, align 8
  store i32 %i.1.i8.i.reg2mem180.0.load, ptr %i.041.i2.i.reg2mem184, align 4
  br label %land.rhs.i1.i, !dbg !1596

if.end21.while.end_crit_edge.i11.i:               ; preds = %if.end21.i7.i
  %.pre.i12.i = load i8, ptr %incdec.ptr.i9.i, align 1, !dbg !1599, !tbaa !377
  %11 = icmp eq i8 %.pre.i12.i, 0, !dbg !1600
  %12 = select i1 %11, i64 0, i64 2, !dbg !1601
  store ptr %incdec.ptr.i9.i, ptr %s.addr.0.lcssa.ph.i14.i.reg2mem, align 8
  store i64 %12, ptr %cmp23.not.i13.i.reg2mem, align 8
  br label %input_to_data.exit, !dbg !1596

input_to_data.exit:                               ; preds = %land.rhs.i1.i.input_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i11.i
  %cmp23.not.i13.i.reg2mem.0.load = load i64, ptr %cmp23.not.i13.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.i.reg2mem.0.s.addr.0.lcssa.ph.i14.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.i.reg2mem, align 8
  %spec.select38.i15.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.i.reg2mem.0.s.addr.0.lcssa.ph.i14.i.reload, i64 %cmp23.not.i13.i.reg2mem.0.load, !dbg !1601
    #dbg_value(ptr %spec.select38.i15.i, !497, !DIExpression(), !1559)
  %seqB.i = getelementptr inbounds i8, ptr %call, i64 128, !dbg !1602
    #dbg_value(ptr %spec.select38.i15.i, !529, !DIExpression(), !1603)
    #dbg_value(ptr %seqB.i, !534, !DIExpression(), !1603)
    #dbg_value(i32 128, !535, !DIExpression(), !1603)
    #dbg_value(i32 128, !536, !DIExpression(), !1603)
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(128) %seqB.i, ptr noundef nonnull readonly align 1 dereferenceable(128) %spec.select38.i15.i, i64 128, i1 false), !dbg !1605
  tail call void @free(ptr noundef %call.i) #19, !dbg !1606
    #dbg_value(ptr %call, !479, !DIExpression(), !1607)
    #dbg_value(ptr %call, !480, !DIExpression(), !1607)
  %alignedA.i = getelementptr inbounds i8, ptr %call, i64 256, !dbg !1609
  %alignedB.i = getelementptr inbounds i8, ptr %call, i64 512, !dbg !1610
  %M.i = getelementptr inbounds i8, ptr %call, i64 768, !dbg !1611
  %ptr.i = getelementptr inbounds i8, ptr %call, i64 67332, !dbg !1612
  tail call void @nw(ptr noundef nonnull %call, ptr noundef nonnull %seqB.i, ptr noundef nonnull %alignedA.i, ptr noundef nonnull %alignedB.i, ptr noundef nonnull %M.i, ptr noundef nonnull %ptr.i) #19, !dbg !1613
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #19, !dbg !1614
    #dbg_value(i32 %call21, !1534, !DIExpression(), !1537)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1615
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1615

if.else26:                                        ; preds = %input_to_data.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1615
  unreachable, !dbg !1615

if.end27:                                         ; preds = %input_to_data.exit
    #dbg_value(i32 %call21, !651, !DIExpression(), !1618)
    #dbg_value(ptr %call, !652, !DIExpression(), !1618)
    #dbg_value(ptr %call, !653, !DIExpression(), !1618)
    #dbg_value(i32 %call21, !572, !DIExpression(), !1620)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1622
  br i1 %cmp.i.i.not, label %if.else.i.i, label %data_to_output.exit, !dbg !1622

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #20, !dbg !1622
  unreachable, !dbg !1622

data_to_output.exit:                              ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1623
  %call1.i = tail call signext i32 @write_string(i32 noundef signext %call21, ptr noundef nonnull readonly %alignedA.i, i32 noundef signext 256) #19, !dbg !1624
    #dbg_value(i32 %call21, !572, !DIExpression(), !1625)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1627
  %call4.i = tail call signext i32 @write_string(i32 noundef signext %call21, ptr noundef nonnull readonly %alignedB.i, i32 noundef signext 256) #19, !dbg !1628
    #dbg_value(i32 %call21, !572, !DIExpression(), !1629)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1631
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #19, !dbg !1632
  %13 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1633, !tbaa !383
  %conv29 = sext i32 %13 to i64, !dbg !1633
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #22, !dbg !1634
    #dbg_value(ptr %call30, !1536, !DIExpression(), !1537)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1635
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1635

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.16, ptr noundef nonnull @.str.2.12, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1635
  unreachable, !dbg !1635

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem192.0.check_file.0.reload193, i32 noundef signext 0) #19, !dbg !1638
    #dbg_value(i32 %call37, !1535, !DIExpression(), !1537)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1639
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1639

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.17, ptr noundef nonnull @.str.2.12, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #20, !dbg !1639
  unreachable, !dbg !1639

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !595, !DIExpression(), !1642)
    #dbg_value(ptr %call30, !596, !DIExpression(), !1642)
    #dbg_value(ptr %call30, !597, !DIExpression(), !1642)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(83976) %call30, i8 0, i64 83976, i1 false), !dbg !1644
  %call.i4 = tail call ptr @readfile(i32 noundef signext %call37) #19, !dbg !1645
    #dbg_value(ptr %call.i4, !598, !DIExpression(), !1642)
    #dbg_value(ptr %call.i4, !501, !DIExpression(), !1646)
    #dbg_value(i32 1, !506, !DIExpression(), !1646)
    #dbg_value(i32 0, !507, !DIExpression(), !1646)
  store ptr %call.i4, ptr %s.addr.040.i.i7.reg2mem176, align 8
  store i32 0, ptr %i.041.i.i6.reg2mem178, align 4
  br label %land.rhs.i.i5

land.rhs.i.i5:                                    ; preds = %if.end21.i.i11.land.rhs.i.i5_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i6.reg2mem178.0.load, !507, !DIExpression(), !1646)
    #dbg_value(ptr %s.addr.040.i.i7.reg2mem176.0.s.addr.040.i.i7.reload177, !501, !DIExpression(), !1646)
  %i.041.i.i6.reg2mem178.0.load = load i32, ptr %i.041.i.i6.reg2mem178, align 4
  %s.addr.040.i.i7.reg2mem176.0.s.addr.040.i.i7.reload177 = load ptr, ptr %s.addr.040.i.i7.reg2mem176, align 8
  %14 = load i8, ptr %s.addr.040.i.i7.reg2mem176.0.s.addr.040.i.i7.reload177, align 1, !dbg !1648, !tbaa !377
  switch i8 %14, label %land.rhs.i.i5.if.end21.i.i11_crit_edge [
    i8 0, label %land.rhs.i.i5.parse_string.exit.i17_crit_edge
    i8 37, label %land.lhs.true10.i.i8
  ], !dbg !1649

land.rhs.i.i5.parse_string.exit.i17_crit_edge:    ; preds = %land.rhs.i.i5
  store ptr %s.addr.040.i.i7.reg2mem176.0.s.addr.040.i.i7.reload177, ptr %s.addr.0.lcssa.ph.i.i19.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i18.reg2mem, align 8
  br label %parse_string.exit.i17, !dbg !1649

land.rhs.i.i5.if.end21.i.i11_crit_edge:           ; preds = %land.rhs.i.i5
  store i32 %i.041.i.i6.reg2mem178.0.load, ptr %i.1.i.i12.reg2mem174, align 4
  br label %if.end21.i.i11, !dbg !1649

land.lhs.true10.i.i8:                             ; preds = %land.rhs.i.i5
  %arrayidx11.i.i9 = getelementptr inbounds i8, ptr %s.addr.040.i.i7.reg2mem176.0.s.addr.040.i.i7.reload177, i64 1, !dbg !1650
  %15 = load i8, ptr %arrayidx11.i.i9, align 1, !dbg !1650, !tbaa !377
  %cmp13.i.i10 = icmp eq i8 %15, 37, !dbg !1651
  br i1 %cmp13.i.i10, label %land.lhs.true15.i.i43, label %land.lhs.true10.i.i8.if.end21.i.i11_crit_edge, !dbg !1652

land.lhs.true10.i.i8.if.end21.i.i11_crit_edge:    ; preds = %land.lhs.true10.i.i8
  store i32 %i.041.i.i6.reg2mem178.0.load, ptr %i.1.i.i12.reg2mem174, align 4
  br label %if.end21.i.i11, !dbg !1652

land.lhs.true15.i.i43:                            ; preds = %land.lhs.true10.i.i8
  %arrayidx16.i.i44 = getelementptr inbounds i8, ptr %s.addr.040.i.i7.reg2mem176.0.s.addr.040.i.i7.reload177, i64 2, !dbg !1653
  %16 = load i8, ptr %arrayidx16.i.i44, align 1, !dbg !1653, !tbaa !377
  %cmp18.i.i45 = icmp eq i8 %16, 10, !dbg !1654
  %inc.i.i46 = zext i1 %cmp18.i.i45 to i32, !dbg !1655
  %spec.select.i.i47 = add nsw i32 %i.041.i.i6.reg2mem178.0.load, %inc.i.i46, !dbg !1655
  store i32 %spec.select.i.i47, ptr %i.1.i.i12.reg2mem174, align 4
  br label %if.end21.i.i11, !dbg !1655

if.end21.i.i11:                                   ; preds = %land.lhs.true10.i.i8.if.end21.i.i11_crit_edge, %land.rhs.i.i5.if.end21.i.i11_crit_edge, %land.lhs.true15.i.i43
    #dbg_value(i32 %i.1.i.i12.reg2mem174.0.load, !507, !DIExpression(), !1646)
  %i.1.i.i12.reg2mem174.0.load = load i32, ptr %i.1.i.i12.reg2mem174, align 4
  %incdec.ptr.i.i13 = getelementptr inbounds i8, ptr %s.addr.040.i.i7.reg2mem176.0.s.addr.040.i.i7.reload177, i64 1, !dbg !1656
    #dbg_value(ptr %incdec.ptr.i.i13, !501, !DIExpression(), !1646)
  %cmp4.i.i14 = icmp slt i32 %i.1.i.i12.reg2mem174.0.load, 1, !dbg !1657
  br i1 %cmp4.i.i14, label %if.end21.i.i11.land.rhs.i.i5_crit_edge, label %if.end21.while.end_crit_edge.i.i15, !dbg !1658, !llvm.loop !1659

if.end21.i.i11.land.rhs.i.i5_crit_edge:           ; preds = %if.end21.i.i11
  store ptr %incdec.ptr.i.i13, ptr %s.addr.040.i.i7.reg2mem176, align 8
  store i32 %i.1.i.i12.reg2mem174.0.load, ptr %i.041.i.i6.reg2mem178, align 4
  br label %land.rhs.i.i5, !dbg !1658

if.end21.while.end_crit_edge.i.i15:               ; preds = %if.end21.i.i11
  %.pre.i.i16 = load i8, ptr %incdec.ptr.i.i13, align 1, !dbg !1661, !tbaa !377
  %17 = icmp eq i8 %.pre.i.i16, 0, !dbg !1662
  %18 = select i1 %17, i64 0, i64 2, !dbg !1663
  store ptr %incdec.ptr.i.i13, ptr %s.addr.0.lcssa.ph.i.i19.reg2mem, align 8
  store i64 %18, ptr %cmp23.not.i.i18.reg2mem, align 8
  br label %parse_string.exit.i17, !dbg !1658

parse_string.exit.i17:                            ; preds = %land.rhs.i.i5.parse_string.exit.i17_crit_edge, %if.end21.while.end_crit_edge.i.i15
  %cmp23.not.i.i18.reg2mem.0.load = load i64, ptr %cmp23.not.i.i18.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i19.reg2mem.0.s.addr.0.lcssa.ph.i.i19.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i19.reg2mem, align 8
  %spec.select38.i.i20 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i19.reg2mem.0.s.addr.0.lcssa.ph.i.i19.reload, i64 %cmp23.not.i.i18.reg2mem.0.load, !dbg !1663
    #dbg_value(ptr %spec.select38.i.i20, !599, !DIExpression(), !1642)
  %alignedA.i21 = getelementptr inbounds i8, ptr %call30, i64 256, !dbg !1664
    #dbg_value(ptr %spec.select38.i.i20, !529, !DIExpression(), !1665)
    #dbg_value(ptr %alignedA.i21, !534, !DIExpression(), !1665)
    #dbg_value(i32 256, !535, !DIExpression(), !1665)
    #dbg_value(i32 256, !536, !DIExpression(), !1665)
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(256) %alignedA.i21, ptr noundef nonnull readonly align 1 dereferenceable(256) %spec.select38.i.i20, i64 256, i1 false), !dbg !1667
    #dbg_value(ptr %call.i4, !501, !DIExpression(), !1668)
    #dbg_value(i32 2, !506, !DIExpression(), !1668)
    #dbg_value(i32 0, !507, !DIExpression(), !1668)
  store ptr %call.i4, ptr %s.addr.040.i3.i24.reg2mem170, align 8
  store i32 0, ptr %i.041.i2.i23.reg2mem172, align 4
  br label %land.rhs.i1.i22

land.rhs.i1.i22:                                  ; preds = %if.end21.i7.i28.land.rhs.i1.i22_crit_edge, %parse_string.exit.i17
    #dbg_value(i32 %i.041.i2.i23.reg2mem172.0.load, !507, !DIExpression(), !1668)
    #dbg_value(ptr %s.addr.040.i3.i24.reg2mem170.0.s.addr.040.i3.i24.reload171, !501, !DIExpression(), !1668)
  %i.041.i2.i23.reg2mem172.0.load = load i32, ptr %i.041.i2.i23.reg2mem172, align 4
  %s.addr.040.i3.i24.reg2mem170.0.s.addr.040.i3.i24.reload171 = load ptr, ptr %s.addr.040.i3.i24.reg2mem170, align 8
  %19 = load i8, ptr %s.addr.040.i3.i24.reg2mem170.0.s.addr.040.i3.i24.reload171, align 1, !dbg !1670, !tbaa !377
  switch i8 %19, label %land.rhs.i1.i22.if.end21.i7.i28_crit_edge [
    i8 0, label %land.rhs.i1.i22.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i4.i25
  ], !dbg !1671

land.rhs.i1.i22.output_to_data.exit_crit_edge:    ; preds = %land.rhs.i1.i22
  store ptr %s.addr.040.i3.i24.reg2mem170.0.s.addr.040.i3.i24.reload171, ptr %s.addr.0.lcssa.ph.i14.i35.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.i34.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1671

land.rhs.i1.i22.if.end21.i7.i28_crit_edge:        ; preds = %land.rhs.i1.i22
  store i32 %i.041.i2.i23.reg2mem172.0.load, ptr %i.1.i8.i29.reg2mem168, align 4
  br label %if.end21.i7.i28, !dbg !1671

land.lhs.true10.i4.i25:                           ; preds = %land.rhs.i1.i22
  %arrayidx11.i5.i26 = getelementptr inbounds i8, ptr %s.addr.040.i3.i24.reg2mem170.0.s.addr.040.i3.i24.reload171, i64 1, !dbg !1672
  %20 = load i8, ptr %arrayidx11.i5.i26, align 1, !dbg !1672, !tbaa !377
  %cmp13.i6.i27 = icmp eq i8 %20, 37, !dbg !1673
  br i1 %cmp13.i6.i27, label %land.lhs.true15.i16.i38, label %land.lhs.true10.i4.i25.if.end21.i7.i28_crit_edge, !dbg !1674

land.lhs.true10.i4.i25.if.end21.i7.i28_crit_edge: ; preds = %land.lhs.true10.i4.i25
  store i32 %i.041.i2.i23.reg2mem172.0.load, ptr %i.1.i8.i29.reg2mem168, align 4
  br label %if.end21.i7.i28, !dbg !1674

land.lhs.true15.i16.i38:                          ; preds = %land.lhs.true10.i4.i25
  %arrayidx16.i17.i39 = getelementptr inbounds i8, ptr %s.addr.040.i3.i24.reg2mem170.0.s.addr.040.i3.i24.reload171, i64 2, !dbg !1675
  %21 = load i8, ptr %arrayidx16.i17.i39, align 1, !dbg !1675, !tbaa !377
  %cmp18.i18.i40 = icmp eq i8 %21, 10, !dbg !1676
  %inc.i19.i41 = zext i1 %cmp18.i18.i40 to i32, !dbg !1677
  %spec.select.i20.i42 = add nsw i32 %i.041.i2.i23.reg2mem172.0.load, %inc.i19.i41, !dbg !1677
  store i32 %spec.select.i20.i42, ptr %i.1.i8.i29.reg2mem168, align 4
  br label %if.end21.i7.i28, !dbg !1677

if.end21.i7.i28:                                  ; preds = %land.lhs.true10.i4.i25.if.end21.i7.i28_crit_edge, %land.rhs.i1.i22.if.end21.i7.i28_crit_edge, %land.lhs.true15.i16.i38
    #dbg_value(i32 %i.1.i8.i29.reg2mem168.0.load, !507, !DIExpression(), !1668)
  %i.1.i8.i29.reg2mem168.0.load = load i32, ptr %i.1.i8.i29.reg2mem168, align 4
  %incdec.ptr.i9.i30 = getelementptr inbounds i8, ptr %s.addr.040.i3.i24.reg2mem170.0.s.addr.040.i3.i24.reload171, i64 1, !dbg !1678
    #dbg_value(ptr %incdec.ptr.i9.i30, !501, !DIExpression(), !1668)
  %cmp4.i10.i31 = icmp slt i32 %i.1.i8.i29.reg2mem168.0.load, 2, !dbg !1679
  br i1 %cmp4.i10.i31, label %if.end21.i7.i28.land.rhs.i1.i22_crit_edge, label %if.end21.while.end_crit_edge.i11.i32, !dbg !1680, !llvm.loop !1681

if.end21.i7.i28.land.rhs.i1.i22_crit_edge:        ; preds = %if.end21.i7.i28
  store ptr %incdec.ptr.i9.i30, ptr %s.addr.040.i3.i24.reg2mem170, align 8
  store i32 %i.1.i8.i29.reg2mem168.0.load, ptr %i.041.i2.i23.reg2mem172, align 4
  br label %land.rhs.i1.i22, !dbg !1680

if.end21.while.end_crit_edge.i11.i32:             ; preds = %if.end21.i7.i28
  %.pre.i12.i33 = load i8, ptr %incdec.ptr.i9.i30, align 1, !dbg !1683, !tbaa !377
  %22 = icmp eq i8 %.pre.i12.i33, 0, !dbg !1684
  %23 = select i1 %22, i64 0, i64 2, !dbg !1685
  store ptr %incdec.ptr.i9.i30, ptr %s.addr.0.lcssa.ph.i14.i35.reg2mem, align 8
  store i64 %23, ptr %cmp23.not.i13.i34.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1680

output_to_data.exit:                              ; preds = %land.rhs.i1.i22.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i11.i32
  %cmp23.not.i13.i34.reg2mem.0.load = load i64, ptr %cmp23.not.i13.i34.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.i35.reg2mem.0.s.addr.0.lcssa.ph.i14.i35.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.i35.reg2mem, align 8
  %spec.select38.i15.i36 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.i35.reg2mem.0.s.addr.0.lcssa.ph.i14.i35.reload, i64 %cmp23.not.i13.i34.reg2mem.0.load, !dbg !1685
    #dbg_value(ptr %spec.select38.i15.i36, !599, !DIExpression(), !1642)
  %alignedB.i37 = getelementptr inbounds i8, ptr %call30, i64 512, !dbg !1686
    #dbg_value(ptr %spec.select38.i15.i36, !529, !DIExpression(), !1687)
    #dbg_value(ptr %alignedB.i37, !534, !DIExpression(), !1687)
    #dbg_value(i32 256, !535, !DIExpression(), !1687)
    #dbg_value(i32 256, !536, !DIExpression(), !1687)
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(256) %alignedB.i37, ptr noundef nonnull readonly align 1 dereferenceable(256) %spec.select38.i15.i36, i64 256, i1 false), !dbg !1689
  tail call void @free(ptr noundef %call.i4) #19, !dbg !1690
    #dbg_value(ptr %call, !674, !DIExpression(), !1691)
    #dbg_value(ptr %call30, !675, !DIExpression(), !1691)
    #dbg_value(ptr %call, !676, !DIExpression(), !1691)
    #dbg_value(ptr %call30, !677, !DIExpression(), !1691)
    #dbg_value(i32 0, !678, !DIExpression(), !1691)
  %call.i49 = tail call signext i32 @memcmp(ptr noundef nonnull readonly dereferenceable(256) %alignedA.i, ptr noundef nonnull readonly dereferenceable(256) %alignedA.i21, i64 noundef 256) #21, !dbg !1694
    #dbg_value(i32 %call.i49, !678, !DIExpression(), !1691)
  %call6.i = tail call signext i32 @memcmp(ptr noundef nonnull readonly dereferenceable(256) %alignedB.i, ptr noundef nonnull readonly dereferenceable(256) %alignedB.i37, i64 noundef 256) #21, !dbg !1695
  %or7.i = or i32 %call6.i, %call.i49, !dbg !1696
    #dbg_value(i32 %or7.i, !678, !DIExpression(), !1691)
  %tobool.not.i.not = icmp eq i32 %or7.i, 0, !dbg !1697
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1698

if.then45:                                        ; preds = %output_to_data.exit
  %24 = load ptr, ptr @stderr, align 8, !dbg !1699, !tbaa !871
  %25 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %24) #23, !dbg !1701
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1702

if.end47:                                         ; preds = %output_to_data.exit
  %call.reg2mem.0.call.reload161 = load ptr, ptr %call.reg2mem, align 8
  tail call void @free(ptr noundef %call.reg2mem.0.call.reload161) #19, !dbg !1703
  tail call void @free(ptr noundef nonnull %call30) #19, !dbg !1704
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1705
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1706

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1707
}

; Function Attrs: nofree
declare !dbg !1708 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #12

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #18

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #18

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "polly-optimized" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #5 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #6 = { mustprogress nofree nounwind willreturn memory(argmem: read) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #7 = { mustprogress nofree nounwind willreturn memory(argmem: read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #8 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #9 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #10 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #11 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #12 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #13 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #14 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #15 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #16 = { inlinehint nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #17 = { nocallback nofree nosync nounwind willreturn }
attributes #18 = { nofree nounwind }
attributes #19 = { nounwind }
attributes #20 = { noreturn nounwind }
attributes #21 = { nounwind willreturn memory(read) }
attributes #22 = { nounwind allocsize(0) }
attributes #23 = { cold }

!llvm.dbg.cu = !{!234, !188, !236, !302}
!llvm.ident = !{!323, !323, !323, !323}
!llvm.module.flags = !{!324, !325, !326, !327, !328, !330, !331, !332, !333, !334}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/nw/nw")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/nw/nw")
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
!187 = distinct !DIGlobalVariable(name: "INPUT_SIZE", scope: !188, file: !189, line: 4, type: !207, isLocal: false, isDefinition: true)
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !212, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/nw/nw")
!190 = !{!191}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 14, size: 671808, elements: !194)
!193 = !DIFile(filename: "./nw.h", directory: "/home/kelvin/MachSuite/nw/nw")
!194 = !{!195, !199, !200, !204, !205, !210}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "seqA", scope: !192, file: !193, line: 15, baseType: !196, size: 1024)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 1024, elements: !197)
!197 = !{!198}
!198 = !DISubrange(count: 128)
!199 = !DIDerivedType(tag: DW_TAG_member, name: "seqB", scope: !192, file: !193, line: 16, baseType: !196, size: 1024, offset: 1024)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "alignedA", scope: !192, file: !193, line: 17, baseType: !201, size: 2048, offset: 2048)
!201 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !202)
!202 = !{!203}
!203 = !DISubrange(count: 256)
!204 = !DIDerivedType(tag: DW_TAG_member, name: "alignedB", scope: !192, file: !193, line: 18, baseType: !201, size: 2048, offset: 4096)
!205 = !DIDerivedType(tag: DW_TAG_member, name: "M", scope: !192, file: !193, line: 19, baseType: !206, size: 532512, offset: 6144)
!206 = !DICompositeType(tag: DW_TAG_array_type, baseType: !207, size: 532512, elements: !208)
!207 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!208 = !{!209}
!209 = !DISubrange(count: 16641)
!210 = !DIDerivedType(tag: DW_TAG_member, name: "ptr", scope: !192, file: !193, line: 20, baseType: !211, size: 133128, offset: 538656)
!211 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 133128, elements: !208)
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
!235 = !DIFile(filename: "nw.c", directory: "/home/kelvin/MachSuite/nw/nw")
!236 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !237, globals: !268, splitDebugInlining: false, nameTableKind: None)
!237 = !{!238, !4, !239, !240, !245, !248, !251, !254, !258, !261, !263, !266, !267}
!238 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!239 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!240 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !241, line: 24, baseType: !242)
!241 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!242 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !243, line: 38, baseType: !244)
!243 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!244 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!245 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !241, line: 25, baseType: !246)
!246 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !243, line: 40, baseType: !247)
!247 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!248 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !241, line: 26, baseType: !249)
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !243, line: 42, baseType: !250)
!250 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!251 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !241, line: 27, baseType: !252)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !243, line: 45, baseType: !253)
!253 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!254 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !255, line: 24, baseType: !256)
!255 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!256 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !243, line: 37, baseType: !257)
!257 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!258 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !255, line: 25, baseType: !259)
!259 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !243, line: 39, baseType: !260)
!260 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!261 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !255, line: 26, baseType: !262)
!262 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !243, line: 41, baseType: !207)
!263 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !255, line: 27, baseType: !264)
!264 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !243, line: 44, baseType: !265)
!265 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!266 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!267 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!268 = !{!269, !0, !7, !12, !274, !18, !276, !23, !281, !28, !283, !33, !38, !285, !43, !45, !47, !52, !57, !62, !67, !69, !71, !76, !78, !80, !82, !87, !89, !290, !92, !97, !102, !107, !112, !114, !116, !121, !126, !128, !130, !132, !134, !136, !141, !146, !148, !153, !295, !158, !163, !297, !165}
!269 = !DIGlobalVariableExpression(var: !270, expr: !DIExpression())
!270 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !271, isLocal: true, isDefinition: true)
!271 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !272)
!272 = !{!273}
!273 = !DISubrange(count: 24)
!274 = !DIGlobalVariableExpression(var: !275, expr: !DIExpression())
!275 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !30, isLocal: true, isDefinition: true)
!276 = !DIGlobalVariableExpression(var: !277, expr: !DIExpression())
!277 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !278, isLocal: true, isDefinition: true)
!278 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !279)
!279 = !{!280}
!280 = !DISubrange(count: 14)
!281 = !DIGlobalVariableExpression(var: !282, expr: !DIExpression())
!282 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !278, isLocal: true, isDefinition: true)
!283 = !DIGlobalVariableExpression(var: !284, expr: !DIExpression())
!284 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !9, isLocal: true, isDefinition: true)
!285 = !DIGlobalVariableExpression(var: !286, expr: !DIExpression())
!286 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !287, isLocal: true, isDefinition: true)
!287 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !288)
!288 = !{!289}
!289 = !DISubrange(count: 21)
!290 = !DIGlobalVariableExpression(var: !291, expr: !DIExpression())
!291 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !292, isLocal: true, isDefinition: true)
!292 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !293)
!293 = !{!294}
!294 = !DISubrange(count: 13)
!295 = !DIGlobalVariableExpression(var: !296, expr: !DIExpression())
!296 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !20, isLocal: true, isDefinition: true)
!297 = !DIGlobalVariableExpression(var: !298, expr: !DIExpression())
!298 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !299, isLocal: true, isDefinition: true)
!299 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !300)
!300 = !{!301}
!301 = !DISubrange(count: 27)
!302 = distinct !DICompileUnit(language: DW_LANG_C11, file: !170, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !303, globals: !304, splitDebugInlining: false, nameTableKind: None)
!303 = !{!239}
!304 = !{!305, !168, !174, !176, !179, !184, !307, !213, !309, !216, !219, !311, !224, !227, !316, !229, !232, !318}
!305 = !DIGlobalVariableExpression(var: !306, expr: !DIExpression())
!306 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !226, isLocal: true, isDefinition: true)
!307 = !DIGlobalVariableExpression(var: !308, expr: !DIExpression())
!308 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !278, isLocal: true, isDefinition: true)
!309 = !DIGlobalVariableExpression(var: !310, expr: !DIExpression())
!310 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !215, isLocal: true, isDefinition: true)
!311 = !DIGlobalVariableExpression(var: !312, expr: !DIExpression())
!312 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !313, isLocal: true, isDefinition: true)
!313 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !314)
!314 = !{!315}
!315 = !DISubrange(count: 31)
!316 = !DIGlobalVariableExpression(var: !317, expr: !DIExpression())
!317 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !215, isLocal: true, isDefinition: true)
!318 = !DIGlobalVariableExpression(var: !319, expr: !DIExpression())
!319 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !320, isLocal: true, isDefinition: true)
!320 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !321)
!321 = !{!322}
!322 = !DISubrange(count: 10)
!323 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!324 = !{i32 7, !"Dwarf Version", i32 4}
!325 = !{i32 2, !"Debug Info Version", i32 3}
!326 = !{i32 1, !"wchar_size", i32 4}
!327 = !{i32 1, !"target-abi", !"lp64d"}
!328 = distinct !{i32 6, !"riscv-isa", !329}
!329 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!330 = !{i32 8, !"PIC Level", i32 2}
!331 = !{i32 7, !"PIE Level", i32 2}
!332 = !{i32 7, !"uwtable", i32 2}
!333 = !{i32 8, !"SmallDataLimit", i32 8}
!334 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!335 = distinct !DISubprogram(name: "nw", scope: !235, file: !235, line: 13, type: !336, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !234, retainedNodes: !339)
!336 = !DISubroutineType(types: !337)
!337 = !{null, !238, !238, !238, !238, !338, !238}
!338 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !207, size: 64)
!339 = !{!340, !341, !342, !343, !344, !345, !346, !347, !348, !349, !350, !351, !352, !353, !354, !355, !356, !357, !358, !359, !360, !361, !365, !366, !367}
!340 = !DILocalVariable(name: "SEQA", arg: 1, scope: !335, file: !235, line: 13, type: !238)
!341 = !DILocalVariable(name: "SEQB", arg: 2, scope: !335, file: !235, line: 13, type: !238)
!342 = !DILocalVariable(name: "alignedA", arg: 3, scope: !335, file: !235, line: 14, type: !238)
!343 = !DILocalVariable(name: "alignedB", arg: 4, scope: !335, file: !235, line: 14, type: !238)
!344 = !DILocalVariable(name: "M", arg: 5, scope: !335, file: !235, line: 15, type: !338)
!345 = !DILocalVariable(name: "ptr", arg: 6, scope: !335, file: !235, line: 15, type: !238)
!346 = !DILocalVariable(name: "score", scope: !335, file: !235, line: 17, type: !207)
!347 = !DILocalVariable(name: "up_left", scope: !335, file: !235, line: 17, type: !207)
!348 = !DILocalVariable(name: "up", scope: !335, file: !235, line: 17, type: !207)
!349 = !DILocalVariable(name: "left", scope: !335, file: !235, line: 17, type: !207)
!350 = !DILocalVariable(name: "max", scope: !335, file: !235, line: 17, type: !207)
!351 = !DILocalVariable(name: "row", scope: !335, file: !235, line: 18, type: !207)
!352 = !DILocalVariable(name: "row_up", scope: !335, file: !235, line: 18, type: !207)
!353 = !DILocalVariable(name: "r", scope: !335, file: !235, line: 18, type: !207)
!354 = !DILocalVariable(name: "a_idx", scope: !335, file: !235, line: 19, type: !207)
!355 = !DILocalVariable(name: "b_idx", scope: !335, file: !235, line: 19, type: !207)
!356 = !DILocalVariable(name: "a_str_idx", scope: !335, file: !235, line: 20, type: !207)
!357 = !DILocalVariable(name: "b_str_idx", scope: !335, file: !235, line: 20, type: !207)
!358 = !DILabel(scope: !335, name: "init_row", file: !235, line: 22)
!359 = !DILabel(scope: !335, name: "init_col", file: !235, line: 25)
!360 = !DILabel(scope: !335, name: "fill_out", file: !235, line: 30)
!361 = !DILabel(scope: !362, name: "fill_in", file: !235, line: 31)
!362 = distinct !DILexicalBlock(scope: !363, file: !235, line: 30, column: 52)
!363 = distinct !DILexicalBlock(scope: !364, file: !235, line: 30, column: 15)
!364 = distinct !DILexicalBlock(scope: !335, file: !235, line: 30, column: 15)
!365 = !DILabel(scope: !335, name: "trace", file: !235, line: 64)
!366 = !DILabel(scope: !335, name: "pad_a", file: !235, line: 85)
!367 = !DILabel(scope: !335, name: "pad_b", file: !235, line: 88)
!368 = !DILocation(line: 0, scope: !335)
!369 = !DILocation(line: 22, column: 5, scope: !335)
!370 = !DILocation(line: 31, column: 18, scope: !371)
!371 = distinct !DILexicalBlock(scope: !362, file: !235, line: 31, column: 18)
!372 = !DILocation(line: 32, column: 26, scope: !373)
!373 = distinct !DILexicalBlock(scope: !374, file: !235, line: 32, column: 16)
!374 = distinct !DILexicalBlock(scope: !375, file: !235, line: 31, column: 55)
!375 = distinct !DILexicalBlock(scope: !371, file: !235, line: 31, column: 18)
!376 = !DILocation(line: 32, column: 16, scope: !373)
!377 = !{!378, !378, i64 0}
!378 = !{!"omnipotent char", !379, i64 0}
!379 = !{!"Simple C/C++ TBAA"}
!380 = !DILocation(line: 32, column: 33, scope: !373)
!381 = !DILocation(line: 32, column: 30, scope: !373)
!382 = !DILocation(line: 41, column: 23, scope: !374)
!383 = !{!384, !384, i64 0}
!384 = !{!"int", !378, i64 0}
!385 = !DILocation(line: 41, column: 45, scope: !374)
!386 = !DILocation(line: 42, column: 23, scope: !374)
!387 = !DILocation(line: 42, column: 45, scope: !374)
!388 = !DILocation(line: 43, column: 23, scope: !374)
!389 = !DILocation(line: 43, column: 45, scope: !374)
!390 = !DILocation(line: 45, column: 19, scope: !374)
!391 = !DILocation(line: 47, column: 19, scope: !374)
!392 = !DILocation(line: 47, column: 13, scope: !374)
!393 = !DILocation(line: 47, column: 28, scope: !374)
!394 = !DILocation(line: 48, column: 20, scope: !395)
!395 = distinct !DILexicalBlock(scope: !374, file: !235, line: 48, column: 16)
!396 = !DILocation(line: 48, column: 16, scope: !374)
!397 = !DILocation(line: 50, column: 27, scope: !398)
!398 = distinct !DILexicalBlock(scope: !395, file: !235, line: 50, column: 23)
!399 = !DILocation(line: 0, scope: !398)
!400 = !DILocation(line: 50, column: 23, scope: !395)
!401 = !DILocation(line: 53, column: 34, scope: !402)
!402 = distinct !DILexicalBlock(scope: !398, file: !235, line: 52, column: 19)
!403 = !DILocation(line: 51, column: 34, scope: !404)
!404 = distinct !DILexicalBlock(scope: !398, file: !235, line: 50, column: 33)
!405 = !DILocation(line: 52, column: 13, scope: !404)
!406 = !DILocation(line: 49, column: 17, scope: !407)
!407 = distinct !DILexicalBlock(scope: !395, file: !235, line: 48, column: 28)
!408 = !DILocation(line: 49, column: 34, scope: !407)
!409 = !DILocation(line: 50, column: 13, scope: !407)
!410 = !DILocation(line: 31, column: 52, scope: !375)
!411 = !DILocation(line: 31, column: 36, scope: !375)
!412 = distinct !{!412, !370, !413, !414, !415}
!413 = !DILocation(line: 55, column: 9, scope: !371)
!414 = !{!"llvm.loop.mustprogress"}
!415 = !{!"llvm.loop.unroll.disable"}
!416 = !DILocation(line: 64, column: 12, scope: !335)
!417 = !DILocation(line: 30, column: 49, scope: !363)
!418 = !DILocation(line: 30, column: 33, scope: !363)
!419 = !DILocation(line: 30, column: 15, scope: !364)
!420 = distinct !{!420, !419, !421, !414, !415}
!421 = !DILocation(line: 56, column: 5, scope: !364)
!422 = !DILocation(line: 85, column: 28, scope: !423)
!423 = distinct !DILexicalBlock(scope: !424, file: !235, line: 85, column: 12)
!424 = distinct !DILexicalBlock(scope: !335, file: !235, line: 85, column: 12)
!425 = !DILocation(line: 85, column: 12, scope: !424)
!426 = !DILocation(line: 86, column: 27, scope: !427)
!427 = distinct !DILexicalBlock(scope: !423, file: !235, line: 85, column: 54)
!428 = !DILocation(line: 88, column: 12, scope: !429)
!429 = distinct !DILexicalBlock(scope: !335, file: !235, line: 88, column: 12)
!430 = !DILocation(line: 89, column: 27, scope: !431)
!431 = distinct !DILexicalBlock(scope: !432, file: !235, line: 88, column: 54)
!432 = distinct !DILexicalBlock(scope: !429, file: !235, line: 88, column: 12)
!433 = !DILocation(line: 91, column: 1, scope: !335)
!434 = !DILocation(line: 65, column: 18, scope: !435)
!435 = distinct !DILexicalBlock(scope: !335, file: !235, line: 64, column: 38)
!436 = !DILocation(line: 66, column: 19, scope: !437)
!437 = distinct !DILexicalBlock(scope: !435, file: !235, line: 66, column: 13)
!438 = !DILocation(line: 66, column: 13, scope: !437)
!439 = !DILocation(line: 66, column: 13, scope: !435)
!440 = !DILocation(line: 67, column: 37, scope: !441)
!441 = distinct !DILexicalBlock(scope: !437, file: !235, line: 66, column: 37)
!442 = !DILocation(line: 67, column: 13, scope: !441)
!443 = !DILocation(line: 67, column: 35, scope: !441)
!444 = !DILocation(line: 68, column: 37, scope: !441)
!445 = !DILocation(line: 68, column: 13, scope: !441)
!446 = !DILocation(line: 68, column: 35, scope: !441)
!447 = !DILocation(line: 69, column: 18, scope: !441)
!448 = !DILocation(line: 70, column: 18, scope: !441)
!449 = !DILocation(line: 71, column: 9, scope: !441)
!450 = !DILocation(line: 73, column: 37, scope: !451)
!451 = distinct !DILexicalBlock(scope: !452, file: !235, line: 72, column: 42)
!452 = distinct !DILexicalBlock(scope: !437, file: !235, line: 72, column: 18)
!453 = !DILocation(line: 73, column: 13, scope: !451)
!454 = !DILocation(line: 73, column: 35, scope: !451)
!455 = !DILocation(line: 74, column: 13, scope: !451)
!456 = !DILocation(line: 74, column: 35, scope: !451)
!457 = !DILocation(line: 75, column: 18, scope: !451)
!458 = !DILocation(line: 76, column: 9, scope: !451)
!459 = !DILocation(line: 78, column: 13, scope: !460)
!460 = distinct !DILexicalBlock(scope: !452, file: !235, line: 77, column: 13)
!461 = !DILocation(line: 78, column: 35, scope: !460)
!462 = !DILocation(line: 79, column: 37, scope: !460)
!463 = !DILocation(line: 79, column: 13, scope: !460)
!464 = !DILocation(line: 79, column: 35, scope: !460)
!465 = !DILocation(line: 80, column: 18, scope: !460)
!466 = !DILocation(line: 0, scope: !437)
!467 = !DILocation(line: 64, column: 23, scope: !335)
!468 = !DILocation(line: 64, column: 26, scope: !335)
!469 = distinct !{!469, !416, !470, !414, !415}
!470 = !DILocation(line: 82, column: 5, scope: !335)
!471 = !{!472}
!472 = distinct !{!472, !473, !"polly.alias.scope.MemRef0"}
!473 = distinct !{!473, !"polly.alias.scope.domain"}
!474 = !{}
!475 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 6, type: !476, scopeLine: 6, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !478)
!476 = !DISubroutineType(types: !477)
!477 = !{null, !239}
!478 = !{!479, !480}
!479 = !DILocalVariable(name: "vargs", arg: 1, scope: !475, file: !189, line: 6, type: !239)
!480 = !DILocalVariable(name: "args", scope: !475, file: !189, line: 7, type: !191)
!481 = !DILocation(line: 0, scope: !475)
!482 = !DILocation(line: 8, column: 25, scope: !475)
!483 = !DILocation(line: 8, column: 37, scope: !475)
!484 = !DILocation(line: 8, column: 53, scope: !475)
!485 = !DILocation(line: 8, column: 69, scope: !475)
!486 = !DILocation(line: 8, column: 78, scope: !475)
!487 = !DILocation(line: 8, column: 3, scope: !475)
!488 = !DILocation(line: 9, column: 1, scope: !475)
!489 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 18, type: !490, scopeLine: 18, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !492)
!490 = !DISubroutineType(types: !491)
!491 = !{null, !207, !239}
!492 = !{!493, !494, !495, !496, !497}
!493 = !DILocalVariable(name: "fd", arg: 1, scope: !489, file: !189, line: 18, type: !207)
!494 = !DILocalVariable(name: "vdata", arg: 2, scope: !489, file: !189, line: 18, type: !239)
!495 = !DILocalVariable(name: "data", scope: !489, file: !189, line: 19, type: !191)
!496 = !DILocalVariable(name: "p", scope: !489, file: !189, line: 20, type: !238)
!497 = !DILocalVariable(name: "s", scope: !489, file: !189, line: 20, type: !238)
!498 = !DILocation(line: 0, scope: !489)
!499 = !DILocation(line: 22, column: 3, scope: !489)
!500 = !DILocation(line: 24, column: 7, scope: !489)
!501 = !DILocalVariable(name: "s", arg: 1, scope: !502, file: !2, line: 56, type: !238)
!502 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !503, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !505)
!503 = !DISubroutineType(types: !504)
!504 = !{!238, !238, !207}
!505 = !{!501, !506, !507}
!506 = !DILocalVariable(name: "n", arg: 2, scope: !502, file: !2, line: 56, type: !207)
!507 = !DILocalVariable(name: "i", scope: !502, file: !2, line: 57, type: !207)
!508 = !DILocation(line: 0, scope: !502, inlinedAt: !509)
!509 = distinct !DILocation(line: 26, column: 7, scope: !489)
!510 = !DILocation(line: 64, column: 17, scope: !502, inlinedAt: !509)
!511 = !DILocation(line: 64, column: 3, scope: !502, inlinedAt: !509)
!512 = !DILocation(line: 66, column: 22, scope: !513, inlinedAt: !509)
!513 = distinct !DILexicalBlock(scope: !514, file: !2, line: 66, column: 9)
!514 = distinct !DILexicalBlock(scope: !502, file: !2, line: 64, column: 31)
!515 = !DILocation(line: 66, column: 26, scope: !513, inlinedAt: !509)
!516 = !DILocation(line: 66, column: 32, scope: !513, inlinedAt: !509)
!517 = !DILocation(line: 66, column: 35, scope: !513, inlinedAt: !509)
!518 = !DILocation(line: 66, column: 39, scope: !513, inlinedAt: !509)
!519 = !DILocation(line: 66, column: 9, scope: !514, inlinedAt: !509)
!520 = !DILocation(line: 69, column: 6, scope: !514, inlinedAt: !509)
!521 = !DILocation(line: 64, column: 10, scope: !502, inlinedAt: !509)
!522 = !DILocation(line: 64, column: 13, scope: !502, inlinedAt: !509)
!523 = distinct !{!523, !511, !524, !414, !415}
!524 = !DILocation(line: 70, column: 3, scope: !502, inlinedAt: !509)
!525 = !DILocation(line: 71, column: 6, scope: !526, inlinedAt: !509)
!526 = distinct !DILexicalBlock(scope: !502, file: !2, line: 71, column: 6)
!527 = !DILocation(line: 71, column: 8, scope: !526, inlinedAt: !509)
!528 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !509)
!529 = !DILocalVariable(name: "s", arg: 1, scope: !530, file: !2, line: 77, type: !238)
!530 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !531, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !533)
!531 = !DISubroutineType(types: !532)
!532 = !{!207, !238, !238, !207}
!533 = !{!529, !534, !535, !536}
!534 = !DILocalVariable(name: "arr", arg: 2, scope: !530, file: !2, line: 77, type: !238)
!535 = !DILocalVariable(name: "n", arg: 3, scope: !530, file: !2, line: 77, type: !207)
!536 = !DILocalVariable(name: "k", scope: !530, file: !2, line: 78, type: !207)
!537 = !DILocation(line: 0, scope: !530, inlinedAt: !538)
!538 = distinct !DILocation(line: 27, column: 3, scope: !489)
!539 = !DILocation(line: 91, column: 3, scope: !530, inlinedAt: !538)
!540 = !DILocation(line: 0, scope: !502, inlinedAt: !541)
!541 = distinct !DILocation(line: 29, column: 7, scope: !489)
!542 = !DILocation(line: 64, column: 17, scope: !502, inlinedAt: !541)
!543 = !DILocation(line: 64, column: 3, scope: !502, inlinedAt: !541)
!544 = !DILocation(line: 66, column: 22, scope: !513, inlinedAt: !541)
!545 = !DILocation(line: 66, column: 26, scope: !513, inlinedAt: !541)
!546 = !DILocation(line: 66, column: 32, scope: !513, inlinedAt: !541)
!547 = !DILocation(line: 66, column: 35, scope: !513, inlinedAt: !541)
!548 = !DILocation(line: 66, column: 39, scope: !513, inlinedAt: !541)
!549 = !DILocation(line: 66, column: 9, scope: !514, inlinedAt: !541)
!550 = !DILocation(line: 69, column: 6, scope: !514, inlinedAt: !541)
!551 = !DILocation(line: 64, column: 10, scope: !502, inlinedAt: !541)
!552 = !DILocation(line: 64, column: 13, scope: !502, inlinedAt: !541)
!553 = distinct !{!553, !543, !554, !414, !415}
!554 = !DILocation(line: 70, column: 3, scope: !502, inlinedAt: !541)
!555 = !DILocation(line: 71, column: 6, scope: !526, inlinedAt: !541)
!556 = !DILocation(line: 71, column: 8, scope: !526, inlinedAt: !541)
!557 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !541)
!558 = !DILocation(line: 30, column: 25, scope: !489)
!559 = !DILocation(line: 0, scope: !530, inlinedAt: !560)
!560 = distinct !DILocation(line: 30, column: 3, scope: !489)
!561 = !DILocation(line: 91, column: 3, scope: !530, inlinedAt: !560)
!562 = !DILocation(line: 31, column: 3, scope: !489)
!563 = !DILocation(line: 33, column: 1, scope: !489)
!564 = !DISubprogram(name: "free", scope: !565, file: !565, line: 687, type: !476, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!565 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!566 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 35, type: !490, scopeLine: 35, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !567)
!567 = !{!568, !569, !570}
!568 = !DILocalVariable(name: "fd", arg: 1, scope: !566, file: !189, line: 35, type: !207)
!569 = !DILocalVariable(name: "vdata", arg: 2, scope: !566, file: !189, line: 35, type: !239)
!570 = !DILocalVariable(name: "data", scope: !566, file: !189, line: 36, type: !191)
!571 = !DILocation(line: 0, scope: !566)
!572 = !DILocalVariable(name: "fd", arg: 1, scope: !573, file: !2, line: 189, type: !207)
!573 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !574, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !576)
!574 = !DISubroutineType(types: !575)
!575 = !{!207, !207}
!576 = !{!572}
!577 = !DILocation(line: 0, scope: !573, inlinedAt: !578)
!578 = distinct !DILocation(line: 38, column: 3, scope: !566)
!579 = !DILocation(line: 190, column: 3, scope: !580, inlinedAt: !578)
!580 = distinct !DILexicalBlock(scope: !581, file: !2, line: 190, column: 3)
!581 = distinct !DILexicalBlock(scope: !573, file: !2, line: 190, column: 3)
!582 = !DILocation(line: 191, column: 3, scope: !573, inlinedAt: !578)
!583 = !DILocation(line: 39, column: 3, scope: !566)
!584 = !DILocation(line: 0, scope: !573, inlinedAt: !585)
!585 = distinct !DILocation(line: 41, column: 3, scope: !566)
!586 = !DILocation(line: 191, column: 3, scope: !573, inlinedAt: !585)
!587 = !DILocation(line: 42, column: 26, scope: !566)
!588 = !DILocation(line: 42, column: 3, scope: !566)
!589 = !DILocation(line: 0, scope: !573, inlinedAt: !590)
!590 = distinct !DILocation(line: 44, column: 3, scope: !566)
!591 = !DILocation(line: 191, column: 3, scope: !573, inlinedAt: !590)
!592 = !DILocation(line: 45, column: 1, scope: !566)
!593 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 54, type: !490, scopeLine: 54, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !594)
!594 = !{!595, !596, !597, !598, !599}
!595 = !DILocalVariable(name: "fd", arg: 1, scope: !593, file: !189, line: 54, type: !207)
!596 = !DILocalVariable(name: "vdata", arg: 2, scope: !593, file: !189, line: 54, type: !239)
!597 = !DILocalVariable(name: "data", scope: !593, file: !189, line: 55, type: !191)
!598 = !DILocalVariable(name: "p", scope: !593, file: !189, line: 56, type: !238)
!599 = !DILocalVariable(name: "s", scope: !593, file: !189, line: 56, type: !238)
!600 = !DILocation(line: 0, scope: !593)
!601 = !DILocation(line: 58, column: 3, scope: !593)
!602 = !DILocation(line: 60, column: 7, scope: !593)
!603 = !DILocation(line: 0, scope: !502, inlinedAt: !604)
!604 = distinct !DILocation(line: 62, column: 7, scope: !593)
!605 = !DILocation(line: 64, column: 17, scope: !502, inlinedAt: !604)
!606 = !DILocation(line: 64, column: 3, scope: !502, inlinedAt: !604)
!607 = !DILocation(line: 66, column: 22, scope: !513, inlinedAt: !604)
!608 = !DILocation(line: 66, column: 26, scope: !513, inlinedAt: !604)
!609 = !DILocation(line: 66, column: 32, scope: !513, inlinedAt: !604)
!610 = !DILocation(line: 66, column: 35, scope: !513, inlinedAt: !604)
!611 = !DILocation(line: 66, column: 39, scope: !513, inlinedAt: !604)
!612 = !DILocation(line: 66, column: 9, scope: !514, inlinedAt: !604)
!613 = !DILocation(line: 69, column: 6, scope: !514, inlinedAt: !604)
!614 = !DILocation(line: 64, column: 10, scope: !502, inlinedAt: !604)
!615 = !DILocation(line: 64, column: 13, scope: !502, inlinedAt: !604)
!616 = distinct !{!616, !606, !617, !414, !415}
!617 = !DILocation(line: 70, column: 3, scope: !502, inlinedAt: !604)
!618 = !DILocation(line: 71, column: 6, scope: !526, inlinedAt: !604)
!619 = !DILocation(line: 71, column: 8, scope: !526, inlinedAt: !604)
!620 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !604)
!621 = !DILocation(line: 63, column: 25, scope: !593)
!622 = !DILocation(line: 0, scope: !530, inlinedAt: !623)
!623 = distinct !DILocation(line: 63, column: 3, scope: !593)
!624 = !DILocation(line: 91, column: 3, scope: !530, inlinedAt: !623)
!625 = !DILocation(line: 0, scope: !502, inlinedAt: !626)
!626 = distinct !DILocation(line: 65, column: 7, scope: !593)
!627 = !DILocation(line: 64, column: 17, scope: !502, inlinedAt: !626)
!628 = !DILocation(line: 64, column: 3, scope: !502, inlinedAt: !626)
!629 = !DILocation(line: 66, column: 22, scope: !513, inlinedAt: !626)
!630 = !DILocation(line: 66, column: 26, scope: !513, inlinedAt: !626)
!631 = !DILocation(line: 66, column: 32, scope: !513, inlinedAt: !626)
!632 = !DILocation(line: 66, column: 35, scope: !513, inlinedAt: !626)
!633 = !DILocation(line: 66, column: 39, scope: !513, inlinedAt: !626)
!634 = !DILocation(line: 66, column: 9, scope: !514, inlinedAt: !626)
!635 = !DILocation(line: 69, column: 6, scope: !514, inlinedAt: !626)
!636 = !DILocation(line: 64, column: 10, scope: !502, inlinedAt: !626)
!637 = !DILocation(line: 64, column: 13, scope: !502, inlinedAt: !626)
!638 = distinct !{!638, !628, !639, !414, !415}
!639 = !DILocation(line: 70, column: 3, scope: !502, inlinedAt: !626)
!640 = !DILocation(line: 71, column: 6, scope: !526, inlinedAt: !626)
!641 = !DILocation(line: 71, column: 8, scope: !526, inlinedAt: !626)
!642 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !626)
!643 = !DILocation(line: 66, column: 25, scope: !593)
!644 = !DILocation(line: 0, scope: !530, inlinedAt: !645)
!645 = distinct !DILocation(line: 66, column: 3, scope: !593)
!646 = !DILocation(line: 91, column: 3, scope: !530, inlinedAt: !645)
!647 = !DILocation(line: 67, column: 3, scope: !593)
!648 = !DILocation(line: 68, column: 1, scope: !593)
!649 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 70, type: !490, scopeLine: 70, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !650)
!650 = !{!651, !652, !653}
!651 = !DILocalVariable(name: "fd", arg: 1, scope: !649, file: !189, line: 70, type: !207)
!652 = !DILocalVariable(name: "vdata", arg: 2, scope: !649, file: !189, line: 70, type: !239)
!653 = !DILocalVariable(name: "data", scope: !649, file: !189, line: 71, type: !191)
!654 = !DILocation(line: 0, scope: !649)
!655 = !DILocation(line: 0, scope: !573, inlinedAt: !656)
!656 = distinct !DILocation(line: 73, column: 3, scope: !649)
!657 = !DILocation(line: 190, column: 3, scope: !580, inlinedAt: !656)
!658 = !DILocation(line: 191, column: 3, scope: !573, inlinedAt: !656)
!659 = !DILocation(line: 74, column: 26, scope: !649)
!660 = !DILocation(line: 74, column: 3, scope: !649)
!661 = !DILocation(line: 0, scope: !573, inlinedAt: !662)
!662 = distinct !DILocation(line: 76, column: 3, scope: !649)
!663 = !DILocation(line: 191, column: 3, scope: !573, inlinedAt: !662)
!664 = !DILocation(line: 77, column: 26, scope: !649)
!665 = !DILocation(line: 77, column: 3, scope: !649)
!666 = !DILocation(line: 0, scope: !573, inlinedAt: !667)
!667 = distinct !DILocation(line: 79, column: 3, scope: !649)
!668 = !DILocation(line: 191, column: 3, scope: !573, inlinedAt: !667)
!669 = !DILocation(line: 80, column: 1, scope: !649)
!670 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 82, type: !671, scopeLine: 82, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !673)
!671 = !DISubroutineType(types: !672)
!672 = !{!207, !239, !239}
!673 = !{!674, !675, !676, !677, !678}
!674 = !DILocalVariable(name: "vdata", arg: 1, scope: !670, file: !189, line: 82, type: !239)
!675 = !DILocalVariable(name: "vref", arg: 2, scope: !670, file: !189, line: 82, type: !239)
!676 = !DILocalVariable(name: "data", scope: !670, file: !189, line: 83, type: !191)
!677 = !DILocalVariable(name: "ref", scope: !670, file: !189, line: 84, type: !191)
!678 = !DILocalVariable(name: "has_errors", scope: !670, file: !189, line: 85, type: !207)
!679 = !DILocation(line: 0, scope: !670)
!680 = !DILocation(line: 87, column: 30, scope: !670)
!681 = !DILocation(line: 87, column: 45, scope: !670)
!682 = !DILocation(line: 87, column: 17, scope: !670)
!683 = !DILocation(line: 88, column: 30, scope: !670)
!684 = !DILocation(line: 88, column: 45, scope: !670)
!685 = !DILocation(line: 88, column: 17, scope: !670)
!686 = !DILocation(line: 88, column: 14, scope: !670)
!687 = !DILocation(line: 91, column: 10, scope: !670)
!688 = !DILocation(line: 91, column: 3, scope: !670)
!689 = !DISubprogram(name: "memcmp", scope: !690, file: !690, line: 64, type: !691, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!690 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!691 = !DISubroutineType(types: !692)
!692 = !{!207, !693, !693, !695}
!693 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !694, size: 64)
!694 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!695 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !696, line: 18, baseType: !253)
!696 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!697 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !698, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !700)
!698 = !DISubroutineType(types: !699)
!699 = !{!238, !207}
!700 = !{!701, !702, !703, !740, !743, !746}
!701 = !DILocalVariable(name: "fd", arg: 1, scope: !697, file: !2, line: 34, type: !207)
!702 = !DILocalVariable(name: "p", scope: !697, file: !2, line: 35, type: !238)
!703 = !DILocalVariable(name: "s", scope: !697, file: !2, line: 36, type: !704)
!704 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !705, line: 44, size: 1024, elements: !706)
!705 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!706 = !{!707, !709, !711, !713, !715, !717, !719, !720, !721, !723, !725, !726, !728, !736, !737, !738}
!707 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !704, file: !705, line: 46, baseType: !708, size: 64)
!708 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !243, line: 145, baseType: !253)
!709 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !704, file: !705, line: 47, baseType: !710, size: 64, offset: 64)
!710 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !243, line: 148, baseType: !253)
!711 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !704, file: !705, line: 48, baseType: !712, size: 32, offset: 128)
!712 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !243, line: 150, baseType: !250)
!713 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !704, file: !705, line: 49, baseType: !714, size: 32, offset: 160)
!714 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !243, line: 151, baseType: !250)
!715 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !704, file: !705, line: 50, baseType: !716, size: 32, offset: 192)
!716 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !243, line: 146, baseType: !250)
!717 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !704, file: !705, line: 51, baseType: !718, size: 32, offset: 224)
!718 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !243, line: 147, baseType: !250)
!719 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !704, file: !705, line: 52, baseType: !708, size: 64, offset: 256)
!720 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !704, file: !705, line: 53, baseType: !708, size: 64, offset: 320)
!721 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !704, file: !705, line: 54, baseType: !722, size: 64, offset: 384)
!722 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !243, line: 152, baseType: !265)
!723 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !704, file: !705, line: 55, baseType: !724, size: 32, offset: 448)
!724 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !243, line: 175, baseType: !207)
!725 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !704, file: !705, line: 56, baseType: !207, size: 32, offset: 480)
!726 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !704, file: !705, line: 57, baseType: !727, size: 64, offset: 512)
!727 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !243, line: 180, baseType: !265)
!728 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !704, file: !705, line: 65, baseType: !729, size: 128, offset: 576)
!729 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !730, line: 11, size: 128, elements: !731)
!730 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!731 = !{!732, !734}
!732 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !729, file: !730, line: 16, baseType: !733, size: 64)
!733 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !243, line: 160, baseType: !265)
!734 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !729, file: !730, line: 21, baseType: !735, size: 64, offset: 64)
!735 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !243, line: 197, baseType: !265)
!736 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !704, file: !705, line: 66, baseType: !729, size: 128, offset: 704)
!737 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !704, file: !705, line: 67, baseType: !729, size: 128, offset: 832)
!738 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !704, file: !705, line: 79, baseType: !739, size: 64, offset: 960)
!739 = !DICompositeType(tag: DW_TAG_array_type, baseType: !207, size: 64, elements: !55)
!740 = !DILocalVariable(name: "len", scope: !697, file: !2, line: 37, type: !741)
!741 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !742, line: 85, baseType: !722)
!742 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!743 = !DILocalVariable(name: "bytes_read", scope: !697, file: !2, line: 38, type: !744)
!744 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !742, line: 108, baseType: !745)
!745 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !243, line: 194, baseType: !265)
!746 = !DILocalVariable(name: "status", scope: !697, file: !2, line: 38, type: !744)
!747 = distinct !DIAssignID()
!748 = !DILocation(line: 0, scope: !697)
!749 = !DILocation(line: 36, column: 3, scope: !697)
!750 = !DILocation(line: 40, column: 3, scope: !751)
!751 = distinct !DILexicalBlock(scope: !752, file: !2, line: 40, column: 3)
!752 = distinct !DILexicalBlock(scope: !697, file: !2, line: 40, column: 3)
!753 = !DILocation(line: 41, column: 3, scope: !754)
!754 = distinct !DILexicalBlock(scope: !755, file: !2, line: 41, column: 3)
!755 = distinct !DILexicalBlock(scope: !697, file: !2, line: 41, column: 3)
!756 = !DILocation(line: 42, column: 11, scope: !697)
!757 = !DILocation(line: 43, column: 3, scope: !758)
!758 = distinct !DILexicalBlock(scope: !759, file: !2, line: 43, column: 3)
!759 = distinct !DILexicalBlock(scope: !697, file: !2, line: 43, column: 3)
!760 = !DILocation(line: 44, column: 25, scope: !697)
!761 = !DILocation(line: 44, column: 15, scope: !697)
!762 = !DILocation(line: 46, column: 3, scope: !697)
!763 = !DILocation(line: 49, column: 15, scope: !764)
!764 = distinct !DILexicalBlock(scope: !697, file: !2, line: 46, column: 27)
!765 = !DILocation(line: 46, column: 20, scope: !697)
!766 = distinct !{!766, !762, !767, !414, !415}
!767 = !DILocation(line: 50, column: 3, scope: !697)
!768 = !DILocation(line: 47, column: 24, scope: !764)
!769 = !DILocation(line: 47, column: 42, scope: !764)
!770 = !DILocation(line: 47, column: 14, scope: !764)
!771 = !DILocation(line: 48, column: 5, scope: !772)
!772 = distinct !DILexicalBlock(scope: !773, file: !2, line: 48, column: 5)
!773 = distinct !DILexicalBlock(scope: !764, file: !2, line: 48, column: 5)
!774 = !DILocation(line: 51, column: 3, scope: !697)
!775 = !DILocation(line: 51, column: 10, scope: !697)
!776 = !DILocation(line: 52, column: 3, scope: !697)
!777 = !DILocation(line: 54, column: 1, scope: !697)
!778 = !DILocation(line: 53, column: 3, scope: !697)
!779 = !DISubprogram(name: "__assert_fail", scope: !780, file: !780, line: 67, type: !781, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!780 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!781 = !DISubroutineType(types: !782)
!782 = !{null, !783, !783, !250, !783}
!783 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!784 = !DISubprogram(name: "fstat", scope: !785, file: !785, line: 210, type: !786, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!785 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!786 = !DISubroutineType(types: !787)
!787 = !{!207, !207, !788}
!788 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !704, size: 64)
!789 = !DISubprogram(name: "malloc", scope: !565, file: !565, line: 672, type: !790, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!790 = !DISubroutineType(types: !791)
!791 = !{!239, !695}
!792 = !DISubprogram(name: "read", scope: !793, file: !793, line: 371, type: !794, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!793 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!794 = !DISubroutineType(types: !795)
!795 = !{!744, !207, !239, !695}
!796 = !DISubprogram(name: "close", scope: !793, file: !793, line: 358, type: !574, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!797 = !DILocation(line: 0, scope: !502)
!798 = !DILocation(line: 59, column: 3, scope: !799)
!799 = distinct !DILexicalBlock(scope: !800, file: !2, line: 59, column: 3)
!800 = distinct !DILexicalBlock(scope: !502, file: !2, line: 59, column: 3)
!801 = !DILocation(line: 60, column: 7, scope: !802)
!802 = distinct !DILexicalBlock(scope: !502, file: !2, line: 60, column: 6)
!803 = !DILocation(line: 60, column: 6, scope: !502)
!804 = !DILocation(line: 64, column: 17, scope: !502)
!805 = !DILocation(line: 64, column: 3, scope: !502)
!806 = !DILocation(line: 66, column: 22, scope: !513)
!807 = !DILocation(line: 66, column: 26, scope: !513)
!808 = !DILocation(line: 66, column: 32, scope: !513)
!809 = !DILocation(line: 66, column: 35, scope: !513)
!810 = !DILocation(line: 66, column: 39, scope: !513)
!811 = !DILocation(line: 66, column: 9, scope: !514)
!812 = !DILocation(line: 69, column: 6, scope: !514)
!813 = !DILocation(line: 64, column: 10, scope: !502)
!814 = !DILocation(line: 64, column: 13, scope: !502)
!815 = distinct !{!815, !805, !816, !414, !415}
!816 = !DILocation(line: 70, column: 3, scope: !502)
!817 = !DILocation(line: 71, column: 6, scope: !526)
!818 = !DILocation(line: 71, column: 8, scope: !526)
!819 = !DILocation(line: 71, column: 6, scope: !502)
!820 = !DILocation(line: 74, column: 1, scope: !502)
!821 = !DILocation(line: 0, scope: !530)
!822 = !DILocation(line: 79, column: 3, scope: !823)
!823 = distinct !DILexicalBlock(scope: !824, file: !2, line: 79, column: 3)
!824 = distinct !DILexicalBlock(scope: !530, file: !2, line: 79, column: 3)
!825 = !DILocation(line: 81, column: 8, scope: !826)
!826 = distinct !DILexicalBlock(scope: !530, file: !2, line: 81, column: 7)
!827 = !DILocation(line: 81, column: 7, scope: !530)
!828 = !DILocation(line: 83, column: 12, scope: !829)
!829 = distinct !DILexicalBlock(scope: !826, file: !2, line: 81, column: 13)
!830 = !DILocation(line: 83, column: 5, scope: !829)
!831 = !DILocation(line: 91, column: 19, scope: !530)
!832 = !DILocation(line: 91, column: 3, scope: !530)
!833 = !DILocation(line: 92, column: 7, scope: !530)
!834 = !DILocation(line: 83, column: 16, scope: !829)
!835 = !DILocation(line: 83, column: 26, scope: !829)
!836 = !DILocation(line: 83, column: 32, scope: !829)
!837 = !DILocation(line: 83, column: 29, scope: !829)
!838 = !DILocation(line: 83, column: 35, scope: !829)
!839 = !DILocation(line: 83, column: 45, scope: !829)
!840 = !DILocation(line: 83, column: 48, scope: !829)
!841 = !DILocation(line: 83, column: 54, scope: !829)
!842 = !DILocation(line: 84, column: 9, scope: !829)
!843 = !DILocation(line: 84, column: 18, scope: !829)
!844 = !DILocation(line: 84, column: 26, scope: !829)
!845 = distinct !{!845, !830, !846, !414, !415}
!846 = !DILocation(line: 86, column: 5, scope: !829)
!847 = !DILocation(line: 93, column: 5, scope: !848)
!848 = distinct !DILexicalBlock(scope: !530, file: !2, line: 92, column: 7)
!849 = !DILocation(line: 93, column: 12, scope: !848)
!850 = !DILocation(line: 95, column: 3, scope: !530)
!851 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !852, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !855)
!852 = !DISubroutineType(types: !853)
!853 = !{!207, !238, !854, !207}
!854 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !240, size: 64)
!855 = !{!856, !857, !858, !859, !860, !861, !862}
!856 = !DILocalVariable(name: "s", arg: 1, scope: !851, file: !2, line: 132, type: !238)
!857 = !DILocalVariable(name: "arr", arg: 2, scope: !851, file: !2, line: 132, type: !854)
!858 = !DILocalVariable(name: "n", arg: 3, scope: !851, file: !2, line: 132, type: !207)
!859 = !DILocalVariable(name: "line", scope: !851, file: !2, line: 132, type: !238)
!860 = !DILocalVariable(name: "endptr", scope: !851, file: !2, line: 132, type: !238)
!861 = !DILocalVariable(name: "i", scope: !851, file: !2, line: 132, type: !207)
!862 = !DILocalVariable(name: "v", scope: !851, file: !2, line: 132, type: !240)
!863 = distinct !DIAssignID()
!864 = !DILocation(line: 0, scope: !851)
!865 = !DILocation(line: 132, column: 1, scope: !851)
!866 = !DILocation(line: 132, column: 1, scope: !867)
!867 = distinct !DILexicalBlock(scope: !868, file: !2, line: 132, column: 1)
!868 = distinct !DILexicalBlock(scope: !851, file: !2, line: 132, column: 1)
!869 = !DILocation(line: 132, column: 1, scope: !870)
!870 = distinct !DILexicalBlock(scope: !851, file: !2, line: 132, column: 1)
!871 = !{!872, !872, i64 0}
!872 = !{!"any pointer", !378, i64 0}
!873 = distinct !DIAssignID()
!874 = !DILocation(line: 132, column: 1, scope: !875)
!875 = distinct !DILexicalBlock(scope: !870, file: !2, line: 132, column: 1)
!876 = !DILocation(line: 132, column: 1, scope: !877)
!877 = distinct !DILexicalBlock(scope: !875, file: !2, line: 132, column: 1)
!878 = distinct !{!878, !865, !865, !414, !415}
!879 = !DILocation(line: 132, column: 1, scope: !880)
!880 = distinct !DILexicalBlock(scope: !881, file: !2, line: 132, column: 1)
!881 = distinct !DILexicalBlock(scope: !851, file: !2, line: 132, column: 1)
!882 = !DISubprogram(name: "strtok", scope: !690, file: !690, line: 356, type: !883, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!883 = !DISubroutineType(types: !884)
!884 = !{!238, !885, !886}
!885 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !238)
!886 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !783)
!887 = !DISubprogram(name: "strtol", scope: !565, file: !565, line: 177, type: !888, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!888 = !DISubroutineType(types: !889)
!889 = !{!265, !886, !890, !207}
!890 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !891)
!891 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !238, size: 64)
!892 = !DISubprogram(name: "fprintf", scope: !893, file: !893, line: 357, type: !894, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!893 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!894 = !DISubroutineType(types: !895)
!895 = !{!207, !896, !886, null}
!896 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !897)
!897 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !898, size: 64)
!898 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !899, line: 7, baseType: !900)
!899 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!900 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !901, line: 49, size: 1728, elements: !902)
!901 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!902 = !{!903, !904, !905, !906, !907, !908, !909, !910, !911, !912, !913, !914, !915, !918, !920, !921, !922, !923, !924, !925, !929, !932, !934, !937, !940, !941, !942, !944, !945}
!903 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !900, file: !901, line: 51, baseType: !207, size: 32)
!904 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !900, file: !901, line: 54, baseType: !238, size: 64, offset: 64)
!905 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !900, file: !901, line: 55, baseType: !238, size: 64, offset: 128)
!906 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !900, file: !901, line: 56, baseType: !238, size: 64, offset: 192)
!907 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !900, file: !901, line: 57, baseType: !238, size: 64, offset: 256)
!908 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !900, file: !901, line: 58, baseType: !238, size: 64, offset: 320)
!909 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !900, file: !901, line: 59, baseType: !238, size: 64, offset: 384)
!910 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !900, file: !901, line: 60, baseType: !238, size: 64, offset: 448)
!911 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !900, file: !901, line: 61, baseType: !238, size: 64, offset: 512)
!912 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !900, file: !901, line: 64, baseType: !238, size: 64, offset: 576)
!913 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !900, file: !901, line: 65, baseType: !238, size: 64, offset: 640)
!914 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !900, file: !901, line: 66, baseType: !238, size: 64, offset: 704)
!915 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !900, file: !901, line: 68, baseType: !916, size: 64, offset: 768)
!916 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !917, size: 64)
!917 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !901, line: 36, flags: DIFlagFwdDecl)
!918 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !900, file: !901, line: 70, baseType: !919, size: 64, offset: 832)
!919 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !900, size: 64)
!920 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !900, file: !901, line: 72, baseType: !207, size: 32, offset: 896)
!921 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !900, file: !901, line: 73, baseType: !207, size: 32, offset: 928)
!922 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !900, file: !901, line: 74, baseType: !722, size: 64, offset: 960)
!923 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !900, file: !901, line: 77, baseType: !247, size: 16, offset: 1024)
!924 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !900, file: !901, line: 78, baseType: !257, size: 8, offset: 1040)
!925 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !900, file: !901, line: 79, baseType: !926, size: 8, offset: 1048)
!926 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !927)
!927 = !{!928}
!928 = !DISubrange(count: 1)
!929 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !900, file: !901, line: 81, baseType: !930, size: 64, offset: 1088)
!930 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !931, size: 64)
!931 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !901, line: 43, baseType: null)
!932 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !900, file: !901, line: 89, baseType: !933, size: 64, offset: 1152)
!933 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !243, line: 153, baseType: !265)
!934 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !900, file: !901, line: 91, baseType: !935, size: 64, offset: 1216)
!935 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !936, size: 64)
!936 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !901, line: 37, flags: DIFlagFwdDecl)
!937 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !900, file: !901, line: 92, baseType: !938, size: 64, offset: 1280)
!938 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !939, size: 64)
!939 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !901, line: 38, flags: DIFlagFwdDecl)
!940 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !900, file: !901, line: 93, baseType: !919, size: 64, offset: 1344)
!941 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !900, file: !901, line: 94, baseType: !239, size: 64, offset: 1408)
!942 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !900, file: !901, line: 95, baseType: !943, size: 64, offset: 1472)
!943 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !919, size: 64)
!944 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !900, file: !901, line: 96, baseType: !207, size: 32, offset: 1536)
!945 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !900, file: !901, line: 98, baseType: !946, size: 160, offset: 1568)
!946 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!947 = !DISubprogram(name: "strlen", scope: !690, file: !690, line: 407, type: !948, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!948 = !DISubroutineType(types: !949)
!949 = !{!253, !783}
!950 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !951, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !954)
!951 = !DISubroutineType(types: !952)
!952 = !{!207, !238, !953, !207}
!953 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !245, size: 64)
!954 = !{!955, !956, !957, !958, !959, !960, !961}
!955 = !DILocalVariable(name: "s", arg: 1, scope: !950, file: !2, line: 133, type: !238)
!956 = !DILocalVariable(name: "arr", arg: 2, scope: !950, file: !2, line: 133, type: !953)
!957 = !DILocalVariable(name: "n", arg: 3, scope: !950, file: !2, line: 133, type: !207)
!958 = !DILocalVariable(name: "line", scope: !950, file: !2, line: 133, type: !238)
!959 = !DILocalVariable(name: "endptr", scope: !950, file: !2, line: 133, type: !238)
!960 = !DILocalVariable(name: "i", scope: !950, file: !2, line: 133, type: !207)
!961 = !DILocalVariable(name: "v", scope: !950, file: !2, line: 133, type: !245)
!962 = distinct !DIAssignID()
!963 = !DILocation(line: 0, scope: !950)
!964 = !DILocation(line: 133, column: 1, scope: !950)
!965 = !DILocation(line: 133, column: 1, scope: !966)
!966 = distinct !DILexicalBlock(scope: !967, file: !2, line: 133, column: 1)
!967 = distinct !DILexicalBlock(scope: !950, file: !2, line: 133, column: 1)
!968 = !DILocation(line: 133, column: 1, scope: !969)
!969 = distinct !DILexicalBlock(scope: !950, file: !2, line: 133, column: 1)
!970 = distinct !DIAssignID()
!971 = !DILocation(line: 133, column: 1, scope: !972)
!972 = distinct !DILexicalBlock(scope: !969, file: !2, line: 133, column: 1)
!973 = !DILocation(line: 133, column: 1, scope: !974)
!974 = distinct !DILexicalBlock(scope: !972, file: !2, line: 133, column: 1)
!975 = !{!976, !976, i64 0}
!976 = !{!"short", !378, i64 0}
!977 = distinct !{!977, !964, !964, !414, !415}
!978 = !DILocation(line: 133, column: 1, scope: !979)
!979 = distinct !DILexicalBlock(scope: !980, file: !2, line: 133, column: 1)
!980 = distinct !DILexicalBlock(scope: !950, file: !2, line: 133, column: 1)
!981 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !982, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !985)
!982 = !DISubroutineType(types: !983)
!983 = !{!207, !238, !984, !207}
!984 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !248, size: 64)
!985 = !{!986, !987, !988, !989, !990, !991, !992}
!986 = !DILocalVariable(name: "s", arg: 1, scope: !981, file: !2, line: 134, type: !238)
!987 = !DILocalVariable(name: "arr", arg: 2, scope: !981, file: !2, line: 134, type: !984)
!988 = !DILocalVariable(name: "n", arg: 3, scope: !981, file: !2, line: 134, type: !207)
!989 = !DILocalVariable(name: "line", scope: !981, file: !2, line: 134, type: !238)
!990 = !DILocalVariable(name: "endptr", scope: !981, file: !2, line: 134, type: !238)
!991 = !DILocalVariable(name: "i", scope: !981, file: !2, line: 134, type: !207)
!992 = !DILocalVariable(name: "v", scope: !981, file: !2, line: 134, type: !248)
!993 = distinct !DIAssignID()
!994 = !DILocation(line: 0, scope: !981)
!995 = !DILocation(line: 134, column: 1, scope: !981)
!996 = !DILocation(line: 134, column: 1, scope: !997)
!997 = distinct !DILexicalBlock(scope: !998, file: !2, line: 134, column: 1)
!998 = distinct !DILexicalBlock(scope: !981, file: !2, line: 134, column: 1)
!999 = !DILocation(line: 134, column: 1, scope: !1000)
!1000 = distinct !DILexicalBlock(scope: !981, file: !2, line: 134, column: 1)
!1001 = distinct !DIAssignID()
!1002 = !DILocation(line: 134, column: 1, scope: !1003)
!1003 = distinct !DILexicalBlock(scope: !1000, file: !2, line: 134, column: 1)
!1004 = !DILocation(line: 134, column: 1, scope: !1005)
!1005 = distinct !DILexicalBlock(scope: !1003, file: !2, line: 134, column: 1)
!1006 = distinct !{!1006, !995, !995, !414, !415}
!1007 = !DILocation(line: 134, column: 1, scope: !1008)
!1008 = distinct !DILexicalBlock(scope: !1009, file: !2, line: 134, column: 1)
!1009 = distinct !DILexicalBlock(scope: !981, file: !2, line: 134, column: 1)
!1010 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !1011, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1014)
!1011 = !DISubroutineType(types: !1012)
!1012 = !{!207, !238, !1013, !207}
!1013 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !251, size: 64)
!1014 = !{!1015, !1016, !1017, !1018, !1019, !1020, !1021}
!1015 = !DILocalVariable(name: "s", arg: 1, scope: !1010, file: !2, line: 135, type: !238)
!1016 = !DILocalVariable(name: "arr", arg: 2, scope: !1010, file: !2, line: 135, type: !1013)
!1017 = !DILocalVariable(name: "n", arg: 3, scope: !1010, file: !2, line: 135, type: !207)
!1018 = !DILocalVariable(name: "line", scope: !1010, file: !2, line: 135, type: !238)
!1019 = !DILocalVariable(name: "endptr", scope: !1010, file: !2, line: 135, type: !238)
!1020 = !DILocalVariable(name: "i", scope: !1010, file: !2, line: 135, type: !207)
!1021 = !DILocalVariable(name: "v", scope: !1010, file: !2, line: 135, type: !251)
!1022 = distinct !DIAssignID()
!1023 = !DILocation(line: 0, scope: !1010)
!1024 = !DILocation(line: 135, column: 1, scope: !1010)
!1025 = !DILocation(line: 135, column: 1, scope: !1026)
!1026 = distinct !DILexicalBlock(scope: !1027, file: !2, line: 135, column: 1)
!1027 = distinct !DILexicalBlock(scope: !1010, file: !2, line: 135, column: 1)
!1028 = !DILocation(line: 135, column: 1, scope: !1029)
!1029 = distinct !DILexicalBlock(scope: !1010, file: !2, line: 135, column: 1)
!1030 = distinct !DIAssignID()
!1031 = !DILocation(line: 135, column: 1, scope: !1032)
!1032 = distinct !DILexicalBlock(scope: !1029, file: !2, line: 135, column: 1)
!1033 = !DILocation(line: 135, column: 1, scope: !1034)
!1034 = distinct !DILexicalBlock(scope: !1032, file: !2, line: 135, column: 1)
!1035 = !{!1036, !1036, i64 0}
!1036 = !{!"long", !378, i64 0}
!1037 = distinct !{!1037, !1024, !1024, !414, !415}
!1038 = !DILocation(line: 135, column: 1, scope: !1039)
!1039 = distinct !DILexicalBlock(scope: !1040, file: !2, line: 135, column: 1)
!1040 = distinct !DILexicalBlock(scope: !1010, file: !2, line: 135, column: 1)
!1041 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1042, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1045)
!1042 = !DISubroutineType(types: !1043)
!1043 = !{!207, !238, !1044, !207}
!1044 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 64)
!1045 = !{!1046, !1047, !1048, !1049, !1050, !1051, !1052}
!1046 = !DILocalVariable(name: "s", arg: 1, scope: !1041, file: !2, line: 136, type: !238)
!1047 = !DILocalVariable(name: "arr", arg: 2, scope: !1041, file: !2, line: 136, type: !1044)
!1048 = !DILocalVariable(name: "n", arg: 3, scope: !1041, file: !2, line: 136, type: !207)
!1049 = !DILocalVariable(name: "line", scope: !1041, file: !2, line: 136, type: !238)
!1050 = !DILocalVariable(name: "endptr", scope: !1041, file: !2, line: 136, type: !238)
!1051 = !DILocalVariable(name: "i", scope: !1041, file: !2, line: 136, type: !207)
!1052 = !DILocalVariable(name: "v", scope: !1041, file: !2, line: 136, type: !254)
!1053 = distinct !DIAssignID()
!1054 = !DILocation(line: 0, scope: !1041)
!1055 = !DILocation(line: 136, column: 1, scope: !1041)
!1056 = !DILocation(line: 136, column: 1, scope: !1057)
!1057 = distinct !DILexicalBlock(scope: !1058, file: !2, line: 136, column: 1)
!1058 = distinct !DILexicalBlock(scope: !1041, file: !2, line: 136, column: 1)
!1059 = !DILocation(line: 136, column: 1, scope: !1060)
!1060 = distinct !DILexicalBlock(scope: !1041, file: !2, line: 136, column: 1)
!1061 = distinct !DIAssignID()
!1062 = !DILocation(line: 136, column: 1, scope: !1063)
!1063 = distinct !DILexicalBlock(scope: !1060, file: !2, line: 136, column: 1)
!1064 = !DILocation(line: 136, column: 1, scope: !1065)
!1065 = distinct !DILexicalBlock(scope: !1063, file: !2, line: 136, column: 1)
!1066 = distinct !{!1066, !1055, !1055, !414, !415}
!1067 = !DILocation(line: 136, column: 1, scope: !1068)
!1068 = distinct !DILexicalBlock(scope: !1069, file: !2, line: 136, column: 1)
!1069 = distinct !DILexicalBlock(scope: !1041, file: !2, line: 136, column: 1)
!1070 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1071, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1074)
!1071 = !DISubroutineType(types: !1072)
!1072 = !{!207, !238, !1073, !207}
!1073 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !258, size: 64)
!1074 = !{!1075, !1076, !1077, !1078, !1079, !1080, !1081}
!1075 = !DILocalVariable(name: "s", arg: 1, scope: !1070, file: !2, line: 137, type: !238)
!1076 = !DILocalVariable(name: "arr", arg: 2, scope: !1070, file: !2, line: 137, type: !1073)
!1077 = !DILocalVariable(name: "n", arg: 3, scope: !1070, file: !2, line: 137, type: !207)
!1078 = !DILocalVariable(name: "line", scope: !1070, file: !2, line: 137, type: !238)
!1079 = !DILocalVariable(name: "endptr", scope: !1070, file: !2, line: 137, type: !238)
!1080 = !DILocalVariable(name: "i", scope: !1070, file: !2, line: 137, type: !207)
!1081 = !DILocalVariable(name: "v", scope: !1070, file: !2, line: 137, type: !258)
!1082 = distinct !DIAssignID()
!1083 = !DILocation(line: 0, scope: !1070)
!1084 = !DILocation(line: 137, column: 1, scope: !1070)
!1085 = !DILocation(line: 137, column: 1, scope: !1086)
!1086 = distinct !DILexicalBlock(scope: !1087, file: !2, line: 137, column: 1)
!1087 = distinct !DILexicalBlock(scope: !1070, file: !2, line: 137, column: 1)
!1088 = !DILocation(line: 137, column: 1, scope: !1089)
!1089 = distinct !DILexicalBlock(scope: !1070, file: !2, line: 137, column: 1)
!1090 = distinct !DIAssignID()
!1091 = !DILocation(line: 137, column: 1, scope: !1092)
!1092 = distinct !DILexicalBlock(scope: !1089, file: !2, line: 137, column: 1)
!1093 = !DILocation(line: 137, column: 1, scope: !1094)
!1094 = distinct !DILexicalBlock(scope: !1092, file: !2, line: 137, column: 1)
!1095 = distinct !{!1095, !1084, !1084, !414, !415}
!1096 = !DILocation(line: 137, column: 1, scope: !1097)
!1097 = distinct !DILexicalBlock(scope: !1098, file: !2, line: 137, column: 1)
!1098 = distinct !DILexicalBlock(scope: !1070, file: !2, line: 137, column: 1)
!1099 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1100, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1103)
!1100 = !DISubroutineType(types: !1101)
!1101 = !{!207, !238, !1102, !207}
!1102 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !261, size: 64)
!1103 = !{!1104, !1105, !1106, !1107, !1108, !1109, !1110}
!1104 = !DILocalVariable(name: "s", arg: 1, scope: !1099, file: !2, line: 138, type: !238)
!1105 = !DILocalVariable(name: "arr", arg: 2, scope: !1099, file: !2, line: 138, type: !1102)
!1106 = !DILocalVariable(name: "n", arg: 3, scope: !1099, file: !2, line: 138, type: !207)
!1107 = !DILocalVariable(name: "line", scope: !1099, file: !2, line: 138, type: !238)
!1108 = !DILocalVariable(name: "endptr", scope: !1099, file: !2, line: 138, type: !238)
!1109 = !DILocalVariable(name: "i", scope: !1099, file: !2, line: 138, type: !207)
!1110 = !DILocalVariable(name: "v", scope: !1099, file: !2, line: 138, type: !261)
!1111 = distinct !DIAssignID()
!1112 = !DILocation(line: 0, scope: !1099)
!1113 = !DILocation(line: 138, column: 1, scope: !1099)
!1114 = !DILocation(line: 138, column: 1, scope: !1115)
!1115 = distinct !DILexicalBlock(scope: !1116, file: !2, line: 138, column: 1)
!1116 = distinct !DILexicalBlock(scope: !1099, file: !2, line: 138, column: 1)
!1117 = !DILocation(line: 138, column: 1, scope: !1118)
!1118 = distinct !DILexicalBlock(scope: !1099, file: !2, line: 138, column: 1)
!1119 = distinct !DIAssignID()
!1120 = !DILocation(line: 138, column: 1, scope: !1121)
!1121 = distinct !DILexicalBlock(scope: !1118, file: !2, line: 138, column: 1)
!1122 = !DILocation(line: 138, column: 1, scope: !1123)
!1123 = distinct !DILexicalBlock(scope: !1121, file: !2, line: 138, column: 1)
!1124 = distinct !{!1124, !1113, !1113, !414, !415}
!1125 = !DILocation(line: 138, column: 1, scope: !1126)
!1126 = distinct !DILexicalBlock(scope: !1127, file: !2, line: 138, column: 1)
!1127 = distinct !DILexicalBlock(scope: !1099, file: !2, line: 138, column: 1)
!1128 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1129, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1132)
!1129 = !DISubroutineType(types: !1130)
!1130 = !{!207, !238, !1131, !207}
!1131 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !263, size: 64)
!1132 = !{!1133, !1134, !1135, !1136, !1137, !1138, !1139}
!1133 = !DILocalVariable(name: "s", arg: 1, scope: !1128, file: !2, line: 139, type: !238)
!1134 = !DILocalVariable(name: "arr", arg: 2, scope: !1128, file: !2, line: 139, type: !1131)
!1135 = !DILocalVariable(name: "n", arg: 3, scope: !1128, file: !2, line: 139, type: !207)
!1136 = !DILocalVariable(name: "line", scope: !1128, file: !2, line: 139, type: !238)
!1137 = !DILocalVariable(name: "endptr", scope: !1128, file: !2, line: 139, type: !238)
!1138 = !DILocalVariable(name: "i", scope: !1128, file: !2, line: 139, type: !207)
!1139 = !DILocalVariable(name: "v", scope: !1128, file: !2, line: 139, type: !263)
!1140 = distinct !DIAssignID()
!1141 = !DILocation(line: 0, scope: !1128)
!1142 = !DILocation(line: 139, column: 1, scope: !1128)
!1143 = !DILocation(line: 139, column: 1, scope: !1144)
!1144 = distinct !DILexicalBlock(scope: !1145, file: !2, line: 139, column: 1)
!1145 = distinct !DILexicalBlock(scope: !1128, file: !2, line: 139, column: 1)
!1146 = !DILocation(line: 139, column: 1, scope: !1147)
!1147 = distinct !DILexicalBlock(scope: !1128, file: !2, line: 139, column: 1)
!1148 = distinct !DIAssignID()
!1149 = !DILocation(line: 139, column: 1, scope: !1150)
!1150 = distinct !DILexicalBlock(scope: !1147, file: !2, line: 139, column: 1)
!1151 = !DILocation(line: 139, column: 1, scope: !1152)
!1152 = distinct !DILexicalBlock(scope: !1150, file: !2, line: 139, column: 1)
!1153 = distinct !{!1153, !1142, !1142, !414, !415}
!1154 = !DILocation(line: 139, column: 1, scope: !1155)
!1155 = distinct !DILexicalBlock(scope: !1156, file: !2, line: 139, column: 1)
!1156 = distinct !DILexicalBlock(scope: !1128, file: !2, line: 139, column: 1)
!1157 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1158, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1161)
!1158 = !DISubroutineType(types: !1159)
!1159 = !{!207, !238, !1160, !207}
!1160 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !266, size: 64)
!1161 = !{!1162, !1163, !1164, !1165, !1166, !1167, !1168}
!1162 = !DILocalVariable(name: "s", arg: 1, scope: !1157, file: !2, line: 141, type: !238)
!1163 = !DILocalVariable(name: "arr", arg: 2, scope: !1157, file: !2, line: 141, type: !1160)
!1164 = !DILocalVariable(name: "n", arg: 3, scope: !1157, file: !2, line: 141, type: !207)
!1165 = !DILocalVariable(name: "line", scope: !1157, file: !2, line: 141, type: !238)
!1166 = !DILocalVariable(name: "endptr", scope: !1157, file: !2, line: 141, type: !238)
!1167 = !DILocalVariable(name: "i", scope: !1157, file: !2, line: 141, type: !207)
!1168 = !DILocalVariable(name: "v", scope: !1157, file: !2, line: 141, type: !266)
!1169 = distinct !DIAssignID()
!1170 = !DILocation(line: 0, scope: !1157)
!1171 = !DILocation(line: 141, column: 1, scope: !1157)
!1172 = !DILocation(line: 141, column: 1, scope: !1173)
!1173 = distinct !DILexicalBlock(scope: !1174, file: !2, line: 141, column: 1)
!1174 = distinct !DILexicalBlock(scope: !1157, file: !2, line: 141, column: 1)
!1175 = !DILocation(line: 141, column: 1, scope: !1176)
!1176 = distinct !DILexicalBlock(scope: !1157, file: !2, line: 141, column: 1)
!1177 = distinct !DIAssignID()
!1178 = !DILocation(line: 141, column: 1, scope: !1179)
!1179 = distinct !DILexicalBlock(scope: !1176, file: !2, line: 141, column: 1)
!1180 = !DILocation(line: 141, column: 1, scope: !1181)
!1181 = distinct !DILexicalBlock(scope: !1179, file: !2, line: 141, column: 1)
!1182 = !{!1183, !1183, i64 0}
!1183 = !{!"float", !378, i64 0}
!1184 = distinct !{!1184, !1171, !1171, !414, !415}
!1185 = !DILocation(line: 141, column: 1, scope: !1186)
!1186 = distinct !DILexicalBlock(scope: !1187, file: !2, line: 141, column: 1)
!1187 = distinct !DILexicalBlock(scope: !1157, file: !2, line: 141, column: 1)
!1188 = !DISubprogram(name: "strtof", scope: !565, file: !565, line: 124, type: !1189, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1189 = !DISubroutineType(types: !1190)
!1190 = !{!266, !886, !890}
!1191 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1192, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1195)
!1192 = !DISubroutineType(types: !1193)
!1193 = !{!207, !238, !1194, !207}
!1194 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !267, size: 64)
!1195 = !{!1196, !1197, !1198, !1199, !1200, !1201, !1202}
!1196 = !DILocalVariable(name: "s", arg: 1, scope: !1191, file: !2, line: 142, type: !238)
!1197 = !DILocalVariable(name: "arr", arg: 2, scope: !1191, file: !2, line: 142, type: !1194)
!1198 = !DILocalVariable(name: "n", arg: 3, scope: !1191, file: !2, line: 142, type: !207)
!1199 = !DILocalVariable(name: "line", scope: !1191, file: !2, line: 142, type: !238)
!1200 = !DILocalVariable(name: "endptr", scope: !1191, file: !2, line: 142, type: !238)
!1201 = !DILocalVariable(name: "i", scope: !1191, file: !2, line: 142, type: !207)
!1202 = !DILocalVariable(name: "v", scope: !1191, file: !2, line: 142, type: !267)
!1203 = distinct !DIAssignID()
!1204 = !DILocation(line: 0, scope: !1191)
!1205 = !DILocation(line: 142, column: 1, scope: !1191)
!1206 = !DILocation(line: 142, column: 1, scope: !1207)
!1207 = distinct !DILexicalBlock(scope: !1208, file: !2, line: 142, column: 1)
!1208 = distinct !DILexicalBlock(scope: !1191, file: !2, line: 142, column: 1)
!1209 = !DILocation(line: 142, column: 1, scope: !1210)
!1210 = distinct !DILexicalBlock(scope: !1191, file: !2, line: 142, column: 1)
!1211 = distinct !DIAssignID()
!1212 = !DILocation(line: 142, column: 1, scope: !1213)
!1213 = distinct !DILexicalBlock(scope: !1210, file: !2, line: 142, column: 1)
!1214 = !DILocation(line: 142, column: 1, scope: !1215)
!1215 = distinct !DILexicalBlock(scope: !1213, file: !2, line: 142, column: 1)
!1216 = !{!1217, !1217, i64 0}
!1217 = !{!"double", !378, i64 0}
!1218 = distinct !{!1218, !1205, !1205, !414, !415}
!1219 = !DILocation(line: 142, column: 1, scope: !1220)
!1220 = distinct !DILexicalBlock(scope: !1221, file: !2, line: 142, column: 1)
!1221 = distinct !DILexicalBlock(scope: !1191, file: !2, line: 142, column: 1)
!1222 = !DISubprogram(name: "strtod", scope: !565, file: !565, line: 118, type: !1223, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1223 = !DISubroutineType(types: !1224)
!1224 = !{!267, !886, !890}
!1225 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1226, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1228)
!1226 = !DISubroutineType(types: !1227)
!1227 = !{!207, !207, !238, !207}
!1228 = !{!1229, !1230, !1231, !1232, !1233}
!1229 = !DILocalVariable(name: "fd", arg: 1, scope: !1225, file: !2, line: 145, type: !207)
!1230 = !DILocalVariable(name: "arr", arg: 2, scope: !1225, file: !2, line: 145, type: !238)
!1231 = !DILocalVariable(name: "n", arg: 3, scope: !1225, file: !2, line: 145, type: !207)
!1232 = !DILocalVariable(name: "status", scope: !1225, file: !2, line: 146, type: !207)
!1233 = !DILocalVariable(name: "written", scope: !1225, file: !2, line: 146, type: !207)
!1234 = !DILocation(line: 0, scope: !1225)
!1235 = !DILocation(line: 147, column: 3, scope: !1236)
!1236 = distinct !DILexicalBlock(scope: !1237, file: !2, line: 147, column: 3)
!1237 = distinct !DILexicalBlock(scope: !1225, file: !2, line: 147, column: 3)
!1238 = !DILocation(line: 148, column: 8, scope: !1239)
!1239 = distinct !DILexicalBlock(scope: !1225, file: !2, line: 148, column: 7)
!1240 = !DILocation(line: 148, column: 7, scope: !1225)
!1241 = !DILocation(line: 149, column: 9, scope: !1242)
!1242 = distinct !DILexicalBlock(scope: !1239, file: !2, line: 148, column: 13)
!1243 = !DILocation(line: 150, column: 3, scope: !1242)
!1244 = !DILocation(line: 152, column: 16, scope: !1225)
!1245 = !DILocation(line: 152, column: 3, scope: !1225)
!1246 = !DILocation(line: 158, column: 3, scope: !1225)
!1247 = !DILocation(line: 155, column: 13, scope: !1248)
!1248 = distinct !DILexicalBlock(scope: !1225, file: !2, line: 152, column: 20)
!1249 = distinct !{!1249, !1245, !1250, !414, !415}
!1250 = !DILocation(line: 156, column: 3, scope: !1225)
!1251 = !DILocation(line: 153, column: 25, scope: !1248)
!1252 = !DILocation(line: 153, column: 40, scope: !1248)
!1253 = !DILocation(line: 153, column: 39, scope: !1248)
!1254 = !DILocation(line: 153, column: 14, scope: !1248)
!1255 = !DILocation(line: 154, column: 5, scope: !1256)
!1256 = distinct !DILexicalBlock(scope: !1257, file: !2, line: 154, column: 5)
!1257 = distinct !DILexicalBlock(scope: !1248, file: !2, line: 154, column: 5)
!1258 = !DILocation(line: 159, column: 14, scope: !1259)
!1259 = distinct !DILexicalBlock(scope: !1225, file: !2, line: 158, column: 6)
!1260 = !DILocation(line: 160, column: 5, scope: !1261)
!1261 = distinct !DILexicalBlock(scope: !1262, file: !2, line: 160, column: 5)
!1262 = distinct !DILexicalBlock(scope: !1259, file: !2, line: 160, column: 5)
!1263 = !DILocation(line: 161, column: 17, scope: !1225)
!1264 = !DILocation(line: 161, column: 3, scope: !1259)
!1265 = distinct !{!1265, !1246, !1266, !414, !415}
!1266 = !DILocation(line: 161, column: 20, scope: !1225)
!1267 = !DILocation(line: 163, column: 3, scope: !1225)
!1268 = !DISubprogram(name: "write", scope: !793, file: !793, line: 378, type: !1269, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1269 = !DISubroutineType(types: !1270)
!1270 = !{!744, !207, !693, !695}
!1271 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1272, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1274)
!1272 = !DISubroutineType(types: !1273)
!1273 = !{!207, !207, !854, !207}
!1274 = !{!1275, !1276, !1277, !1278}
!1275 = !DILocalVariable(name: "fd", arg: 1, scope: !1271, file: !2, line: 177, type: !207)
!1276 = !DILocalVariable(name: "arr", arg: 2, scope: !1271, file: !2, line: 177, type: !854)
!1277 = !DILocalVariable(name: "n", arg: 3, scope: !1271, file: !2, line: 177, type: !207)
!1278 = !DILocalVariable(name: "i", scope: !1271, file: !2, line: 177, type: !207)
!1279 = !DILocation(line: 0, scope: !1271)
!1280 = !DILocation(line: 177, column: 1, scope: !1281)
!1281 = distinct !DILexicalBlock(scope: !1282, file: !2, line: 177, column: 1)
!1282 = distinct !DILexicalBlock(scope: !1271, file: !2, line: 177, column: 1)
!1283 = !DILocation(line: 177, column: 1, scope: !1284)
!1284 = distinct !DILexicalBlock(scope: !1285, file: !2, line: 177, column: 1)
!1285 = distinct !DILexicalBlock(scope: !1271, file: !2, line: 177, column: 1)
!1286 = !DILocation(line: 177, column: 1, scope: !1285)
!1287 = !DILocation(line: 177, column: 1, scope: !1288)
!1288 = distinct !DILexicalBlock(scope: !1284, file: !2, line: 177, column: 1)
!1289 = distinct !{!1289, !1286, !1286, !414, !415}
!1290 = !DILocation(line: 177, column: 1, scope: !1271)
!1291 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1292, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1294)
!1292 = !DISubroutineType(cc: DW_CC_nocall, types: !1293)
!1293 = !{!207, !207, !783, null}
!1294 = !{!1295, !1296, !1297, !1301, !1302, !1303, !1304}
!1295 = !DILocalVariable(name: "fd", arg: 1, scope: !1291, file: !2, line: 15, type: !207)
!1296 = !DILocalVariable(name: "format", arg: 2, scope: !1291, file: !2, line: 15, type: !783)
!1297 = !DILocalVariable(name: "args", scope: !1291, file: !2, line: 16, type: !1298)
!1298 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1299, line: 12, baseType: !1300)
!1299 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1300 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !239)
!1301 = !DILocalVariable(name: "buffered", scope: !1291, file: !2, line: 17, type: !207)
!1302 = !DILocalVariable(name: "written", scope: !1291, file: !2, line: 17, type: !207)
!1303 = !DILocalVariable(name: "status", scope: !1291, file: !2, line: 17, type: !207)
!1304 = !DILocalVariable(name: "buffer", scope: !1291, file: !2, line: 18, type: !201)
!1305 = distinct !DIAssignID()
!1306 = !DILocation(line: 0, scope: !1291)
!1307 = distinct !DIAssignID()
!1308 = !DILocation(line: 16, column: 3, scope: !1291)
!1309 = !DILocation(line: 18, column: 3, scope: !1291)
!1310 = !DILocation(line: 19, column: 3, scope: !1291)
!1311 = !DILocation(line: 20, column: 66, scope: !1291)
!1312 = !DILocation(line: 20, column: 14, scope: !1291)
!1313 = !DILocation(line: 21, column: 3, scope: !1291)
!1314 = !DILocation(line: 22, column: 3, scope: !1315)
!1315 = distinct !DILexicalBlock(scope: !1316, file: !2, line: 22, column: 3)
!1316 = distinct !DILexicalBlock(scope: !1291, file: !2, line: 22, column: 3)
!1317 = !DILocation(line: 24, column: 16, scope: !1291)
!1318 = !DILocation(line: 24, column: 3, scope: !1291)
!1319 = !DILocation(line: 27, column: 13, scope: !1320)
!1320 = distinct !DILexicalBlock(scope: !1291, file: !2, line: 24, column: 27)
!1321 = distinct !{!1321, !1318, !1322, !414, !415}
!1322 = !DILocation(line: 28, column: 3, scope: !1291)
!1323 = !DILocation(line: 25, column: 25, scope: !1320)
!1324 = !DILocation(line: 25, column: 50, scope: !1320)
!1325 = !DILocation(line: 25, column: 42, scope: !1320)
!1326 = !DILocation(line: 25, column: 14, scope: !1320)
!1327 = !DILocation(line: 26, column: 5, scope: !1328)
!1328 = distinct !DILexicalBlock(scope: !1329, file: !2, line: 26, column: 5)
!1329 = distinct !DILexicalBlock(scope: !1320, file: !2, line: 26, column: 5)
!1330 = !DILocation(line: 29, column: 3, scope: !1331)
!1331 = distinct !DILexicalBlock(scope: !1332, file: !2, line: 29, column: 3)
!1332 = distinct !DILexicalBlock(scope: !1291, file: !2, line: 29, column: 3)
!1333 = !DILocation(line: 31, column: 1, scope: !1291)
!1334 = !DILocation(line: 30, column: 3, scope: !1291)
!1335 = !DISubprogram(name: "vsnprintf", scope: !893, file: !893, line: 389, type: !1336, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1336 = !DISubroutineType(types: !1337)
!1337 = !{!207, !885, !695, !886, !1338}
!1338 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1339, line: 12, baseType: !1300)
!1339 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1340 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1341, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1343)
!1341 = !DISubroutineType(types: !1342)
!1342 = !{!207, !207, !953, !207}
!1343 = !{!1344, !1345, !1346, !1347}
!1344 = !DILocalVariable(name: "fd", arg: 1, scope: !1340, file: !2, line: 178, type: !207)
!1345 = !DILocalVariable(name: "arr", arg: 2, scope: !1340, file: !2, line: 178, type: !953)
!1346 = !DILocalVariable(name: "n", arg: 3, scope: !1340, file: !2, line: 178, type: !207)
!1347 = !DILocalVariable(name: "i", scope: !1340, file: !2, line: 178, type: !207)
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
!1358 = distinct !{!1358, !1355, !1355, !414, !415}
!1359 = !DILocation(line: 178, column: 1, scope: !1340)
!1360 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1361, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1363)
!1361 = !DISubroutineType(types: !1362)
!1362 = !{!207, !207, !984, !207}
!1363 = !{!1364, !1365, !1366, !1367}
!1364 = !DILocalVariable(name: "fd", arg: 1, scope: !1360, file: !2, line: 179, type: !207)
!1365 = !DILocalVariable(name: "arr", arg: 2, scope: !1360, file: !2, line: 179, type: !984)
!1366 = !DILocalVariable(name: "n", arg: 3, scope: !1360, file: !2, line: 179, type: !207)
!1367 = !DILocalVariable(name: "i", scope: !1360, file: !2, line: 179, type: !207)
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
!1378 = distinct !{!1378, !1375, !1375, !414, !415}
!1379 = !DILocation(line: 179, column: 1, scope: !1360)
!1380 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1381, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1383)
!1381 = !DISubroutineType(types: !1382)
!1382 = !{!207, !207, !1013, !207}
!1383 = !{!1384, !1385, !1386, !1387}
!1384 = !DILocalVariable(name: "fd", arg: 1, scope: !1380, file: !2, line: 180, type: !207)
!1385 = !DILocalVariable(name: "arr", arg: 2, scope: !1380, file: !2, line: 180, type: !1013)
!1386 = !DILocalVariable(name: "n", arg: 3, scope: !1380, file: !2, line: 180, type: !207)
!1387 = !DILocalVariable(name: "i", scope: !1380, file: !2, line: 180, type: !207)
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
!1398 = distinct !{!1398, !1395, !1395, !414, !415}
!1399 = !DILocation(line: 180, column: 1, scope: !1380)
!1400 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1401, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1403)
!1401 = !DISubroutineType(types: !1402)
!1402 = !{!207, !207, !1044, !207}
!1403 = !{!1404, !1405, !1406, !1407}
!1404 = !DILocalVariable(name: "fd", arg: 1, scope: !1400, file: !2, line: 181, type: !207)
!1405 = !DILocalVariable(name: "arr", arg: 2, scope: !1400, file: !2, line: 181, type: !1044)
!1406 = !DILocalVariable(name: "n", arg: 3, scope: !1400, file: !2, line: 181, type: !207)
!1407 = !DILocalVariable(name: "i", scope: !1400, file: !2, line: 181, type: !207)
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
!1418 = distinct !{!1418, !1415, !1415, !414, !415}
!1419 = !DILocation(line: 181, column: 1, scope: !1400)
!1420 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1421, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1423)
!1421 = !DISubroutineType(types: !1422)
!1422 = !{!207, !207, !1073, !207}
!1423 = !{!1424, !1425, !1426, !1427}
!1424 = !DILocalVariable(name: "fd", arg: 1, scope: !1420, file: !2, line: 182, type: !207)
!1425 = !DILocalVariable(name: "arr", arg: 2, scope: !1420, file: !2, line: 182, type: !1073)
!1426 = !DILocalVariable(name: "n", arg: 3, scope: !1420, file: !2, line: 182, type: !207)
!1427 = !DILocalVariable(name: "i", scope: !1420, file: !2, line: 182, type: !207)
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
!1438 = distinct !{!1438, !1435, !1435, !414, !415}
!1439 = !DILocation(line: 182, column: 1, scope: !1420)
!1440 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !1441, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1443)
!1441 = !DISubroutineType(types: !1442)
!1442 = !{!207, !207, !1102, !207}
!1443 = !{!1444, !1445, !1446, !1447}
!1444 = !DILocalVariable(name: "fd", arg: 1, scope: !1440, file: !2, line: 183, type: !207)
!1445 = !DILocalVariable(name: "arr", arg: 2, scope: !1440, file: !2, line: 183, type: !1102)
!1446 = !DILocalVariable(name: "n", arg: 3, scope: !1440, file: !2, line: 183, type: !207)
!1447 = !DILocalVariable(name: "i", scope: !1440, file: !2, line: 183, type: !207)
!1448 = !DILocation(line: 0, scope: !1440)
!1449 = !DILocation(line: 183, column: 1, scope: !1450)
!1450 = distinct !DILexicalBlock(scope: !1451, file: !2, line: 183, column: 1)
!1451 = distinct !DILexicalBlock(scope: !1440, file: !2, line: 183, column: 1)
!1452 = !DILocation(line: 183, column: 1, scope: !1453)
!1453 = distinct !DILexicalBlock(scope: !1454, file: !2, line: 183, column: 1)
!1454 = distinct !DILexicalBlock(scope: !1440, file: !2, line: 183, column: 1)
!1455 = !DILocation(line: 183, column: 1, scope: !1454)
!1456 = !DILocation(line: 183, column: 1, scope: !1457)
!1457 = distinct !DILexicalBlock(scope: !1453, file: !2, line: 183, column: 1)
!1458 = distinct !{!1458, !1455, !1455, !414, !415}
!1459 = !DILocation(line: 183, column: 1, scope: !1440)
!1460 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1461, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1463)
!1461 = !DISubroutineType(types: !1462)
!1462 = !{!207, !207, !1131, !207}
!1463 = !{!1464, !1465, !1466, !1467}
!1464 = !DILocalVariable(name: "fd", arg: 1, scope: !1460, file: !2, line: 184, type: !207)
!1465 = !DILocalVariable(name: "arr", arg: 2, scope: !1460, file: !2, line: 184, type: !1131)
!1466 = !DILocalVariable(name: "n", arg: 3, scope: !1460, file: !2, line: 184, type: !207)
!1467 = !DILocalVariable(name: "i", scope: !1460, file: !2, line: 184, type: !207)
!1468 = !DILocation(line: 0, scope: !1460)
!1469 = !DILocation(line: 184, column: 1, scope: !1470)
!1470 = distinct !DILexicalBlock(scope: !1471, file: !2, line: 184, column: 1)
!1471 = distinct !DILexicalBlock(scope: !1460, file: !2, line: 184, column: 1)
!1472 = !DILocation(line: 184, column: 1, scope: !1473)
!1473 = distinct !DILexicalBlock(scope: !1474, file: !2, line: 184, column: 1)
!1474 = distinct !DILexicalBlock(scope: !1460, file: !2, line: 184, column: 1)
!1475 = !DILocation(line: 184, column: 1, scope: !1474)
!1476 = !DILocation(line: 184, column: 1, scope: !1477)
!1477 = distinct !DILexicalBlock(scope: !1473, file: !2, line: 184, column: 1)
!1478 = distinct !{!1478, !1475, !1475, !414, !415}
!1479 = !DILocation(line: 184, column: 1, scope: !1460)
!1480 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1481, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1483)
!1481 = !DISubroutineType(types: !1482)
!1482 = !{!207, !207, !1160, !207}
!1483 = !{!1484, !1485, !1486, !1487}
!1484 = !DILocalVariable(name: "fd", arg: 1, scope: !1480, file: !2, line: 186, type: !207)
!1485 = !DILocalVariable(name: "arr", arg: 2, scope: !1480, file: !2, line: 186, type: !1160)
!1486 = !DILocalVariable(name: "n", arg: 3, scope: !1480, file: !2, line: 186, type: !207)
!1487 = !DILocalVariable(name: "i", scope: !1480, file: !2, line: 186, type: !207)
!1488 = !DILocation(line: 0, scope: !1480)
!1489 = !DILocation(line: 186, column: 1, scope: !1490)
!1490 = distinct !DILexicalBlock(scope: !1491, file: !2, line: 186, column: 1)
!1491 = distinct !DILexicalBlock(scope: !1480, file: !2, line: 186, column: 1)
!1492 = !DILocation(line: 186, column: 1, scope: !1493)
!1493 = distinct !DILexicalBlock(scope: !1494, file: !2, line: 186, column: 1)
!1494 = distinct !DILexicalBlock(scope: !1480, file: !2, line: 186, column: 1)
!1495 = !DILocation(line: 186, column: 1, scope: !1494)
!1496 = !DILocation(line: 186, column: 1, scope: !1497)
!1497 = distinct !DILexicalBlock(scope: !1493, file: !2, line: 186, column: 1)
!1498 = distinct !{!1498, !1495, !1495, !414, !415}
!1499 = !DILocation(line: 186, column: 1, scope: !1480)
!1500 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !1501, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !236, retainedNodes: !1503)
!1501 = !DISubroutineType(types: !1502)
!1502 = !{!207, !207, !1194, !207}
!1503 = !{!1504, !1505, !1506, !1507}
!1504 = !DILocalVariable(name: "fd", arg: 1, scope: !1500, file: !2, line: 187, type: !207)
!1505 = !DILocalVariable(name: "arr", arg: 2, scope: !1500, file: !2, line: 187, type: !1194)
!1506 = !DILocalVariable(name: "n", arg: 3, scope: !1500, file: !2, line: 187, type: !207)
!1507 = !DILocalVariable(name: "i", scope: !1500, file: !2, line: 187, type: !207)
!1508 = !DILocation(line: 0, scope: !1500)
!1509 = !DILocation(line: 187, column: 1, scope: !1510)
!1510 = distinct !DILexicalBlock(scope: !1511, file: !2, line: 187, column: 1)
!1511 = distinct !DILexicalBlock(scope: !1500, file: !2, line: 187, column: 1)
!1512 = !DILocation(line: 187, column: 1, scope: !1513)
!1513 = distinct !DILexicalBlock(scope: !1514, file: !2, line: 187, column: 1)
!1514 = distinct !DILexicalBlock(scope: !1500, file: !2, line: 187, column: 1)
!1515 = !DILocation(line: 187, column: 1, scope: !1514)
!1516 = !DILocation(line: 187, column: 1, scope: !1517)
!1517 = distinct !DILexicalBlock(scope: !1513, file: !2, line: 187, column: 1)
!1518 = distinct !{!1518, !1515, !1515, !414, !415}
!1519 = !DILocation(line: 187, column: 1, scope: !1500)
!1520 = !DILocation(line: 0, scope: !573)
!1521 = !DILocation(line: 190, column: 3, scope: !580)
!1522 = !DILocation(line: 191, column: 3, scope: !573)
!1523 = !DILocation(line: 192, column: 3, scope: !573)
!1524 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1525, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !302, retainedNodes: !1527)
!1525 = !DISubroutineType(types: !1526)
!1526 = !{!207, !207, !891}
!1527 = !{!1528, !1529, !1530, !1531, !1532, !1533, !1534, !1535, !1536}
!1528 = !DILocalVariable(name: "argc", arg: 1, scope: !1524, file: !170, line: 14, type: !207)
!1529 = !DILocalVariable(name: "argv", arg: 2, scope: !1524, file: !170, line: 14, type: !891)
!1530 = !DILocalVariable(name: "in_file", scope: !1524, file: !170, line: 17, type: !238)
!1531 = !DILocalVariable(name: "check_file", scope: !1524, file: !170, line: 19, type: !238)
!1532 = !DILocalVariable(name: "in_fd", scope: !1524, file: !170, line: 34, type: !207)
!1533 = !DILocalVariable(name: "data", scope: !1524, file: !170, line: 35, type: !238)
!1534 = !DILocalVariable(name: "out_fd", scope: !1524, file: !170, line: 46, type: !207)
!1535 = !DILocalVariable(name: "check_fd", scope: !1524, file: !170, line: 55, type: !207)
!1536 = !DILocalVariable(name: "ref", scope: !1524, file: !170, line: 56, type: !238)
!1537 = !DILocation(line: 0, scope: !1524)
!1538 = !DILocation(line: 21, column: 3, scope: !1539)
!1539 = distinct !DILexicalBlock(scope: !1540, file: !170, line: 21, column: 3)
!1540 = distinct !DILexicalBlock(scope: !1524, file: !170, line: 21, column: 3)
!1541 = !DILocation(line: 26, column: 11, scope: !1542)
!1542 = distinct !DILexicalBlock(scope: !1524, file: !170, line: 26, column: 7)
!1543 = !DILocation(line: 26, column: 7, scope: !1524)
!1544 = !DILocation(line: 27, column: 15, scope: !1542)
!1545 = !DILocation(line: 29, column: 11, scope: !1546)
!1546 = distinct !DILexicalBlock(scope: !1524, file: !170, line: 29, column: 7)
!1547 = !DILocation(line: 29, column: 7, scope: !1524)
!1548 = !DILocation(line: 30, column: 18, scope: !1546)
!1549 = !DILocation(line: 30, column: 5, scope: !1546)
!1550 = !DILocation(line: 36, column: 17, scope: !1524)
!1551 = !DILocation(line: 36, column: 10, scope: !1524)
!1552 = !DILocation(line: 37, column: 3, scope: !1553)
!1553 = distinct !DILexicalBlock(scope: !1554, file: !170, line: 37, column: 3)
!1554 = distinct !DILexicalBlock(scope: !1524, file: !170, line: 37, column: 3)
!1555 = !DILocation(line: 38, column: 11, scope: !1524)
!1556 = !DILocation(line: 39, column: 3, scope: !1557)
!1557 = distinct !DILexicalBlock(scope: !1558, file: !170, line: 39, column: 3)
!1558 = distinct !DILexicalBlock(scope: !1524, file: !170, line: 39, column: 3)
!1559 = !DILocation(line: 0, scope: !489, inlinedAt: !1560)
!1560 = distinct !DILocation(line: 40, column: 3, scope: !1524)
!1561 = !DILocation(line: 22, column: 3, scope: !489, inlinedAt: !1560)
!1562 = !DILocation(line: 24, column: 7, scope: !489, inlinedAt: !1560)
!1563 = !DILocation(line: 0, scope: !502, inlinedAt: !1564)
!1564 = distinct !DILocation(line: 26, column: 7, scope: !489, inlinedAt: !1560)
!1565 = !DILocation(line: 64, column: 17, scope: !502, inlinedAt: !1564)
!1566 = !DILocation(line: 64, column: 3, scope: !502, inlinedAt: !1564)
!1567 = !DILocation(line: 66, column: 22, scope: !513, inlinedAt: !1564)
!1568 = !DILocation(line: 66, column: 26, scope: !513, inlinedAt: !1564)
!1569 = !DILocation(line: 66, column: 32, scope: !513, inlinedAt: !1564)
!1570 = !DILocation(line: 66, column: 35, scope: !513, inlinedAt: !1564)
!1571 = !DILocation(line: 66, column: 39, scope: !513, inlinedAt: !1564)
!1572 = !DILocation(line: 66, column: 9, scope: !514, inlinedAt: !1564)
!1573 = !DILocation(line: 69, column: 6, scope: !514, inlinedAt: !1564)
!1574 = !DILocation(line: 64, column: 10, scope: !502, inlinedAt: !1564)
!1575 = !DILocation(line: 64, column: 13, scope: !502, inlinedAt: !1564)
!1576 = distinct !{!1576, !1566, !1577, !414, !415}
!1577 = !DILocation(line: 70, column: 3, scope: !502, inlinedAt: !1564)
!1578 = !DILocation(line: 71, column: 6, scope: !526, inlinedAt: !1564)
!1579 = !DILocation(line: 71, column: 8, scope: !526, inlinedAt: !1564)
!1580 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !1564)
!1581 = !DILocation(line: 0, scope: !530, inlinedAt: !1582)
!1582 = distinct !DILocation(line: 27, column: 3, scope: !489, inlinedAt: !1560)
!1583 = !DILocation(line: 91, column: 3, scope: !530, inlinedAt: !1582)
!1584 = !DILocation(line: 0, scope: !502, inlinedAt: !1585)
!1585 = distinct !DILocation(line: 29, column: 7, scope: !489, inlinedAt: !1560)
!1586 = !DILocation(line: 64, column: 17, scope: !502, inlinedAt: !1585)
!1587 = !DILocation(line: 64, column: 3, scope: !502, inlinedAt: !1585)
!1588 = !DILocation(line: 66, column: 22, scope: !513, inlinedAt: !1585)
!1589 = !DILocation(line: 66, column: 26, scope: !513, inlinedAt: !1585)
!1590 = !DILocation(line: 66, column: 32, scope: !513, inlinedAt: !1585)
!1591 = !DILocation(line: 66, column: 35, scope: !513, inlinedAt: !1585)
!1592 = !DILocation(line: 66, column: 39, scope: !513, inlinedAt: !1585)
!1593 = !DILocation(line: 66, column: 9, scope: !514, inlinedAt: !1585)
!1594 = !DILocation(line: 69, column: 6, scope: !514, inlinedAt: !1585)
!1595 = !DILocation(line: 64, column: 10, scope: !502, inlinedAt: !1585)
!1596 = !DILocation(line: 64, column: 13, scope: !502, inlinedAt: !1585)
!1597 = distinct !{!1597, !1587, !1598, !414, !415}
!1598 = !DILocation(line: 70, column: 3, scope: !502, inlinedAt: !1585)
!1599 = !DILocation(line: 71, column: 6, scope: !526, inlinedAt: !1585)
!1600 = !DILocation(line: 71, column: 8, scope: !526, inlinedAt: !1585)
!1601 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !1585)
!1602 = !DILocation(line: 30, column: 25, scope: !489, inlinedAt: !1560)
!1603 = !DILocation(line: 0, scope: !530, inlinedAt: !1604)
!1604 = distinct !DILocation(line: 30, column: 3, scope: !489, inlinedAt: !1560)
!1605 = !DILocation(line: 91, column: 3, scope: !530, inlinedAt: !1604)
!1606 = !DILocation(line: 31, column: 3, scope: !489, inlinedAt: !1560)
!1607 = !DILocation(line: 0, scope: !475, inlinedAt: !1608)
!1608 = distinct !DILocation(line: 43, column: 3, scope: !1524)
!1609 = !DILocation(line: 8, column: 37, scope: !475, inlinedAt: !1608)
!1610 = !DILocation(line: 8, column: 53, scope: !475, inlinedAt: !1608)
!1611 = !DILocation(line: 8, column: 69, scope: !475, inlinedAt: !1608)
!1612 = !DILocation(line: 8, column: 78, scope: !475, inlinedAt: !1608)
!1613 = !DILocation(line: 8, column: 3, scope: !475, inlinedAt: !1608)
!1614 = !DILocation(line: 47, column: 12, scope: !1524)
!1615 = !DILocation(line: 48, column: 3, scope: !1616)
!1616 = distinct !DILexicalBlock(scope: !1617, file: !170, line: 48, column: 3)
!1617 = distinct !DILexicalBlock(scope: !1524, file: !170, line: 48, column: 3)
!1618 = !DILocation(line: 0, scope: !649, inlinedAt: !1619)
!1619 = distinct !DILocation(line: 49, column: 3, scope: !1524)
!1620 = !DILocation(line: 0, scope: !573, inlinedAt: !1621)
!1621 = distinct !DILocation(line: 73, column: 3, scope: !649, inlinedAt: !1619)
!1622 = !DILocation(line: 190, column: 3, scope: !580, inlinedAt: !1621)
!1623 = !DILocation(line: 191, column: 3, scope: !573, inlinedAt: !1621)
!1624 = !DILocation(line: 74, column: 3, scope: !649, inlinedAt: !1619)
!1625 = !DILocation(line: 0, scope: !573, inlinedAt: !1626)
!1626 = distinct !DILocation(line: 76, column: 3, scope: !649, inlinedAt: !1619)
!1627 = !DILocation(line: 191, column: 3, scope: !573, inlinedAt: !1626)
!1628 = !DILocation(line: 77, column: 3, scope: !649, inlinedAt: !1619)
!1629 = !DILocation(line: 0, scope: !573, inlinedAt: !1630)
!1630 = distinct !DILocation(line: 79, column: 3, scope: !649, inlinedAt: !1619)
!1631 = !DILocation(line: 191, column: 3, scope: !573, inlinedAt: !1630)
!1632 = !DILocation(line: 50, column: 3, scope: !1524)
!1633 = !DILocation(line: 57, column: 16, scope: !1524)
!1634 = !DILocation(line: 57, column: 9, scope: !1524)
!1635 = !DILocation(line: 58, column: 3, scope: !1636)
!1636 = distinct !DILexicalBlock(scope: !1637, file: !170, line: 58, column: 3)
!1637 = distinct !DILexicalBlock(scope: !1524, file: !170, line: 58, column: 3)
!1638 = !DILocation(line: 59, column: 14, scope: !1524)
!1639 = !DILocation(line: 60, column: 3, scope: !1640)
!1640 = distinct !DILexicalBlock(scope: !1641, file: !170, line: 60, column: 3)
!1641 = distinct !DILexicalBlock(scope: !1524, file: !170, line: 60, column: 3)
!1642 = !DILocation(line: 0, scope: !593, inlinedAt: !1643)
!1643 = distinct !DILocation(line: 61, column: 3, scope: !1524)
!1644 = !DILocation(line: 58, column: 3, scope: !593, inlinedAt: !1643)
!1645 = !DILocation(line: 60, column: 7, scope: !593, inlinedAt: !1643)
!1646 = !DILocation(line: 0, scope: !502, inlinedAt: !1647)
!1647 = distinct !DILocation(line: 62, column: 7, scope: !593, inlinedAt: !1643)
!1648 = !DILocation(line: 64, column: 17, scope: !502, inlinedAt: !1647)
!1649 = !DILocation(line: 64, column: 3, scope: !502, inlinedAt: !1647)
!1650 = !DILocation(line: 66, column: 22, scope: !513, inlinedAt: !1647)
!1651 = !DILocation(line: 66, column: 26, scope: !513, inlinedAt: !1647)
!1652 = !DILocation(line: 66, column: 32, scope: !513, inlinedAt: !1647)
!1653 = !DILocation(line: 66, column: 35, scope: !513, inlinedAt: !1647)
!1654 = !DILocation(line: 66, column: 39, scope: !513, inlinedAt: !1647)
!1655 = !DILocation(line: 66, column: 9, scope: !514, inlinedAt: !1647)
!1656 = !DILocation(line: 69, column: 6, scope: !514, inlinedAt: !1647)
!1657 = !DILocation(line: 64, column: 10, scope: !502, inlinedAt: !1647)
!1658 = !DILocation(line: 64, column: 13, scope: !502, inlinedAt: !1647)
!1659 = distinct !{!1659, !1649, !1660, !414, !415}
!1660 = !DILocation(line: 70, column: 3, scope: !502, inlinedAt: !1647)
!1661 = !DILocation(line: 71, column: 6, scope: !526, inlinedAt: !1647)
!1662 = !DILocation(line: 71, column: 8, scope: !526, inlinedAt: !1647)
!1663 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !1647)
!1664 = !DILocation(line: 63, column: 25, scope: !593, inlinedAt: !1643)
!1665 = !DILocation(line: 0, scope: !530, inlinedAt: !1666)
!1666 = distinct !DILocation(line: 63, column: 3, scope: !593, inlinedAt: !1643)
!1667 = !DILocation(line: 91, column: 3, scope: !530, inlinedAt: !1666)
!1668 = !DILocation(line: 0, scope: !502, inlinedAt: !1669)
!1669 = distinct !DILocation(line: 65, column: 7, scope: !593, inlinedAt: !1643)
!1670 = !DILocation(line: 64, column: 17, scope: !502, inlinedAt: !1669)
!1671 = !DILocation(line: 64, column: 3, scope: !502, inlinedAt: !1669)
!1672 = !DILocation(line: 66, column: 22, scope: !513, inlinedAt: !1669)
!1673 = !DILocation(line: 66, column: 26, scope: !513, inlinedAt: !1669)
!1674 = !DILocation(line: 66, column: 32, scope: !513, inlinedAt: !1669)
!1675 = !DILocation(line: 66, column: 35, scope: !513, inlinedAt: !1669)
!1676 = !DILocation(line: 66, column: 39, scope: !513, inlinedAt: !1669)
!1677 = !DILocation(line: 66, column: 9, scope: !514, inlinedAt: !1669)
!1678 = !DILocation(line: 69, column: 6, scope: !514, inlinedAt: !1669)
!1679 = !DILocation(line: 64, column: 10, scope: !502, inlinedAt: !1669)
!1680 = !DILocation(line: 64, column: 13, scope: !502, inlinedAt: !1669)
!1681 = distinct !{!1681, !1671, !1682, !414, !415}
!1682 = !DILocation(line: 70, column: 3, scope: !502, inlinedAt: !1669)
!1683 = !DILocation(line: 71, column: 6, scope: !526, inlinedAt: !1669)
!1684 = !DILocation(line: 71, column: 8, scope: !526, inlinedAt: !1669)
!1685 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !1669)
!1686 = !DILocation(line: 66, column: 25, scope: !593, inlinedAt: !1643)
!1687 = !DILocation(line: 0, scope: !530, inlinedAt: !1688)
!1688 = distinct !DILocation(line: 66, column: 3, scope: !593, inlinedAt: !1643)
!1689 = !DILocation(line: 91, column: 3, scope: !530, inlinedAt: !1688)
!1690 = !DILocation(line: 67, column: 3, scope: !593, inlinedAt: !1643)
!1691 = !DILocation(line: 0, scope: !670, inlinedAt: !1692)
!1692 = distinct !DILocation(line: 66, column: 8, scope: !1693)
!1693 = distinct !DILexicalBlock(scope: !1524, file: !170, line: 66, column: 7)
!1694 = !DILocation(line: 87, column: 17, scope: !670, inlinedAt: !1692)
!1695 = !DILocation(line: 88, column: 17, scope: !670, inlinedAt: !1692)
!1696 = !DILocation(line: 88, column: 14, scope: !670, inlinedAt: !1692)
!1697 = !DILocation(line: 91, column: 10, scope: !670, inlinedAt: !1692)
!1698 = !DILocation(line: 66, column: 7, scope: !1524)
!1699 = !DILocation(line: 67, column: 13, scope: !1700)
!1700 = distinct !DILexicalBlock(scope: !1693, file: !170, line: 66, column: 32)
!1701 = !DILocation(line: 67, column: 5, scope: !1700)
!1702 = !DILocation(line: 68, column: 5, scope: !1700)
!1703 = !DILocation(line: 71, column: 3, scope: !1524)
!1704 = !DILocation(line: 72, column: 3, scope: !1524)
!1705 = !DILocation(line: 74, column: 3, scope: !1524)
!1706 = !DILocation(line: 75, column: 3, scope: !1524)
!1707 = !DILocation(line: 76, column: 1, scope: !1524)
!1708 = !DISubprogram(name: "open", scope: !1709, file: !1709, line: 209, type: !1710, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1709 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1710 = !DISubroutineType(types: !1711)
!1711 = !{!207, !783, !207, null}
