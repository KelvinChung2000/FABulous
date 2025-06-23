; ModuleID = 'sort/radix/sort_opt.bc'
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
@INPUT_SIZE = dso_local local_unnamed_addr global i32 25088, align 4, !dbg !186
@.str.6.14 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !207
@.str.8.15 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !210
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !213
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !218
@.str.12.16 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !221
@.str.14.17 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !223
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !226
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @sort(ptr nocapture noundef %a, ptr nocapture noundef %b, ptr nocapture noundef %bucket, ptr nocapture noundef %sum) local_unnamed_addr #0 !dbg !329 {
entry.split:
  %polly.indvar_next44.reg2mem = alloca i64, align 8
  %polly.indvar_next44.3.reg2mem = alloca i64, align 8
  %polly.indvar_next44.2.reg2mem = alloca i64, align 8
  %polly.indvar_next44.1.reg2mem = alloca i64, align 8
  %_p_scalar_2966.reg2mem = alloca i32, align 4
  %p_add.i.reg2mem = alloca i32, align 4
  %.reg2mem = alloca i64, align 8
  %.reg2mem102 = alloca i64, align 8
  %polly.indvar_next.reg2mem = alloca i64, align 8
  %add.reg2mem = alloca i32, align 4
  %valid_buffer.1.reg2mem = alloca i32, align 4
  %indvars.iv.next34.i88.reg2mem = alloca i64, align 8
  %indvars.iv.next.i85.reg2mem = alloca i64, align 8
  %.reg2mem110 = alloca i32, align 4
  %invariant.gep99.reg2mem = alloca ptr, align 8
  %indvars.iv33.i72.reg2mem = alloca i64, align 8
  %indvars.iv.next34.i.reg2mem = alloca i64, align 8
  %indvars.iv.next.i69.reg2mem = alloca i64, align 8
  %.reg2mem116 = alloca i32, align 4
  %invariant.gep101.reg2mem = alloca ptr, align 8
  %indvars.iv33.i.reg2mem = alloca i64, align 8
  %indvars.iv.next23.i.reg2mem = alloca i64, align 8
  %indvars.iv.next.i58.reg2mem = alloca i64, align 8
  %invariant.gep97.reg2mem = alloca ptr, align 8
  %arrayidx5.i.reg2mem = alloca ptr, align 8
  %indvars.iv22.i.reg2mem = alloca i64, align 8
  %indvars.iv.next.i51.reg2mem = alloca i64, align 8
  %add.i.reg2mem = alloca i32, align 4
  %indvars.iv.next20.i.reg2mem = alloca i64, align 8
  %indvars.iv.next.i46.reg2mem = alloca i64, align 8
  %add6.i.reg2mem = alloca i32, align 4
  %load_initial.reg2mem = alloca i32, align 4
  %scevgep.reg2mem = alloca ptr, align 8
  %indvars.iv19.i.reg2mem = alloca i64, align 8
  %indvars.iv.next22.i39.reg2mem = alloca i64, align 8
  %indvars.iv.next.i36.reg2mem = alloca i64, align 8
  %.reg2mem133 = alloca i32, align 4
  %invariant.gep.reg2mem = alloca ptr, align 8
  %indvars.iv21.i26.reg2mem = alloca i64, align 8
  %indvars.iv.next22.i.reg2mem = alloca i64, align 8
  %indvars.iv.next.i.reg2mem = alloca i64, align 8
  %.reg2mem139 = alloca i32, align 4
  %invariant.gep93.reg2mem = alloca ptr, align 8
  %indvars.iv21.i.reg2mem = alloca i64, align 8
  %cmp1.reg2mem = alloca i1, align 1
  %exp.0103.reg2mem = alloca i32, align 4
  %invariant.gep62.reg2mem = alloca ptr, align 8
  %.reg2mem149 = alloca i1, align 1
  %scevgep30.reg2mem = alloca ptr, align 8
  %scevgep27.reg2mem = alloca ptr, align 8
  %invariant.gep.i24.reg2mem = alloca ptr, align 8
  %invariant.gep.i48.reg2mem = alloca ptr, align 8
  %polly.indvar43.reg2mem = alloca i64, align 8
  %polly.indvar43.3.reg2mem = alloca i64, align 8
  %polly.indvar43.2.reg2mem = alloca i64, align 8
  %polly.indvar43.1.reg2mem = alloca i64, align 8
  %polly.indvar2368.reg2mem = alloca i64, align 8
  %.reg2mem155 = alloca i64, align 8
  %p_add.i69.reg2mem = alloca i32, align 4
  %polly.indvar.reg2mem = alloca i64, align 8
  %valid_buffer.1.reg2mem157 = alloca i32, align 4
  %indvars.iv.i74.reg2mem = alloca i64, align 8
  %indvars.iv33.i72.reg2mem159 = alloca i64, align 8
  %indvars.iv.i62.reg2mem = alloca i64, align 8
  %indvars.iv33.i.reg2mem161 = alloca i64, align 8
  %indvars.iv.i55.reg2mem = alloca i64, align 8
  %indvars.iv22.i.reg2mem163 = alloca i64, align 8
  %indvars.iv.i49.reg2mem = alloca i64, align 8
  %store_forwarded110.reg2mem = alloca i32, align 4
  %indvars.iv.i44.reg2mem = alloca i64, align 8
  %store_forwarded.reg2mem = alloca i32, align 4
  %indvars.iv19.i.reg2mem165 = alloca i64, align 8
  %indvars.iv.i28.reg2mem = alloca i64, align 8
  %indvars.iv21.i26.reg2mem167 = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %indvars.iv21.i.reg2mem169 = alloca i64, align 8
  %exp.0103.reg2mem171 = alloca i32, align 4
  %valid_buffer.0104.reg2mem = alloca i32, align 4
    #dbg_value(ptr %a, !334, !DIExpression(), !341)
    #dbg_value(ptr %b, !335, !DIExpression(), !341)
    #dbg_value(ptr %bucket, !336, !DIExpression(), !341)
    #dbg_value(ptr %sum, !337, !DIExpression(), !341)
    #dbg_value(i32 0, !338, !DIExpression(), !341)
    #dbg_value(i32 0, !339, !DIExpression(), !341)
    #dbg_label(!340, !342)
  %invariant.gep.i48 = getelementptr i8, ptr %bucket, i64 -4
  store ptr %invariant.gep.i48, ptr %invariant.gep.i48.reg2mem, align 8
  %invariant.gep.i24 = getelementptr i8, ptr %bucket, i64 4
  store ptr %invariant.gep.i24, ptr %invariant.gep.i24.reg2mem, align 8
  %scevgep27 = getelementptr i8, ptr %bucket, i64 60, !dbg !343
  store ptr %scevgep27, ptr %scevgep27.reg2mem, align 8
  %scevgep30 = getelementptr i8, ptr %sum, i64 4, !dbg !343
  store ptr %scevgep30, ptr %scevgep30.reg2mem, align 8
  %polly.access.sum = getelementptr i8, ptr %sum, i64 512
  %0 = icmp ule ptr %polly.access.sum, %bucket
  %polly.access.bucket7 = getelementptr i8, ptr %bucket, i64 8192
  %1 = icmp ule ptr %polly.access.bucket7, %sum
  %2 = or i1 %1, %0
  store i1 %2, ptr %.reg2mem149, align 1
  %invariant.gep62 = getelementptr i8, ptr %sum, i64 8
  store ptr %invariant.gep62, ptr %invariant.gep62.reg2mem, align 8
  store i32 0, ptr %exp.0103.reg2mem171, align 4
  store i32 0, ptr %valid_buffer.0104.reg2mem, align 4
  br label %for.body, !dbg !343

for.body:                                         ; preds = %for.inc.for.body_crit_edge, %entry.split
    #dbg_value(i32 %valid_buffer.0104.reg2mem.0.load, !339, !DIExpression(), !341)
    #dbg_value(i32 %exp.0103.reg2mem171.0.load, !338, !DIExpression(), !341)
    #dbg_value(ptr %bucket, !345, !DIExpression(), !352)
    #dbg_label(!351, !356)
    #dbg_value(i32 0, !350, !DIExpression(), !352)
  %valid_buffer.0104.reg2mem.0.load = load i32, ptr %valid_buffer.0104.reg2mem, align 4
  %exp.0103.reg2mem171.0.load = load i32, ptr %exp.0103.reg2mem171, align 4
  store i32 %exp.0103.reg2mem171.0.load, ptr %exp.0103.reg2mem, align 4
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 dereferenceable(8192) %bucket, i8 0, i64 8192, i1 false), !dbg !357, !tbaa !361
    #dbg_value(i64 poison, !350, !DIExpression(), !352)
  %cmp1 = icmp eq i32 %valid_buffer.0104.reg2mem.0.load, 0, !dbg !365
    #dbg_value(ptr %bucket, !367, !DIExpression(), !383)
    #dbg_value(ptr %bucket, !367, !DIExpression(), !386)
  store i1 %cmp1, ptr %cmp1.reg2mem, align 1
  br i1 %cmp1, label %for.body.for.cond1.preheader.i_crit_edge, label %for.body.for.cond1.preheader.i25_crit_edge, !dbg !389

for.body.for.cond1.preheader.i25_crit_edge:       ; preds = %for.body
  store i64 0, ptr %indvars.iv21.i26.reg2mem167, align 8
  br label %for.cond1.preheader.i25, !dbg !389

for.body.for.cond1.preheader.i_crit_edge:         ; preds = %for.body
  store i64 0, ptr %indvars.iv21.i.reg2mem169, align 8
  br label %for.cond1.preheader.i, !dbg !389

for.cond1.preheader.i:                            ; preds = %for.inc10.i.for.cond1.preheader.i_crit_edge, %for.body.for.cond1.preheader.i_crit_edge
    #dbg_value(i64 %indvars.iv21.i.reg2mem169.0.load, !374, !DIExpression(), !383)
    #dbg_value(i32 0, !375, !DIExpression(), !383)
  %indvars.iv21.i.reg2mem169.0.load = load i64, ptr %indvars.iv21.i.reg2mem169, align 8
  store i64 %indvars.iv21.i.reg2mem169.0.load, ptr %indvars.iv21.i.reg2mem, align 8
  %invariant.gep93.idx = shl i64 %indvars.iv21.i.reg2mem169.0.load, 4, !dbg !390
  %invariant.gep93 = getelementptr i8, ptr %a, i64 %invariant.gep93.idx, !dbg !390
  store ptr %invariant.gep93, ptr %invariant.gep93.reg2mem, align 8
  %3 = trunc i64 %indvars.iv21.i.reg2mem169.0.load to i32
  store i32 %3, ptr %.reg2mem139, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body3.i, !dbg !390

for.body3.i:                                      ; preds = %for.body3.i.for.body3.i_crit_edge, %for.cond1.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !375, !DIExpression(), !383)
    #dbg_value(!DIArgList(i64 %indvars.iv.i.reg2mem.0.load, i64 %indvars.iv21.i.reg2mem169.0.load), !377, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 2, DW_OP_shl, DW_OP_plus, DW_OP_stack_value), !383)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %gep94 = getelementptr i32, ptr %invariant.gep93, i64 %indvars.iv.i.reg2mem.0.load, !dbg !392
  %4 = load i32, ptr %gep94, align 4, !dbg !392, !tbaa !361
  %shr.i = ashr i32 %4, %exp.0103.reg2mem171.0.load, !dbg !395
  %and.i = shl i32 %shr.i, 9, !dbg !396
  %mul4.i = and i32 %and.i, 1536, !dbg !396
  %add5.i = or disjoint i32 %mul4.i, %3, !dbg !397
    #dbg_value(i32 %add5.i, !376, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !383)
  %5 = zext nneg i32 %add5.i to i64, !dbg !398
  %invariant.gep.i24.reg2mem.0.invariant.gep.i24.reload154 = load ptr, ptr %invariant.gep.i24.reg2mem, align 8
  %gep.i = getelementptr i32, ptr %invariant.gep.i24.reg2mem.0.invariant.gep.i24.reload154, i64 %5, !dbg !398
  %6 = load i32, ptr %gep.i, align 4, !dbg !399, !tbaa !361
  %inc.i = add nsw i32 %6, 1, !dbg !399
  store i32 %inc.i, ptr %gep.i, align 4, !dbg !399, !tbaa !361
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !400
    #dbg_value(i64 %indvars.iv.next.i, !375, !DIExpression(), !383)
  store i64 %indvars.iv.next.i, ptr %indvars.iv.next.i.reg2mem, align 8
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 4, !dbg !401
  br i1 %exitcond.not.i, label %for.inc10.i, label %for.body3.i.for.body3.i_crit_edge, !dbg !390, !llvm.loop !402

for.body3.i.for.body3.i_crit_edge:                ; preds = %for.body3.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body3.i, !dbg !390

for.inc10.i:                                      ; preds = %for.body3.i
  %indvars.iv.next22.i = add nuw nsw i64 %indvars.iv21.i.reg2mem169.0.load, 1, !dbg !406
    #dbg_value(i64 %indvars.iv.next22.i, !374, !DIExpression(), !383)
  store i64 %indvars.iv.next22.i, ptr %indvars.iv.next22.i.reg2mem, align 8
  %exitcond24.not.i = icmp eq i64 %indvars.iv.next22.i, 512, !dbg !407
  br i1 %exitcond24.not.i, label %for.inc10.i.polly.split_new_and_old_crit_edge, label %for.inc10.i.for.cond1.preheader.i_crit_edge, !dbg !408, !llvm.loop !409

for.inc10.i.for.cond1.preheader.i_crit_edge:      ; preds = %for.inc10.i
  store i64 %indvars.iv.next22.i, ptr %indvars.iv21.i.reg2mem169, align 8
  br label %for.cond1.preheader.i, !dbg !408

for.inc10.i.polly.split_new_and_old_crit_edge:    ; preds = %for.inc10.i
  br label %polly.split_new_and_old, !dbg !408

for.cond1.preheader.i25:                          ; preds = %for.inc10.i38.for.cond1.preheader.i25_crit_edge, %for.body.for.cond1.preheader.i25_crit_edge
    #dbg_value(i64 %indvars.iv21.i26.reg2mem167.0.load, !374, !DIExpression(), !386)
    #dbg_value(i32 0, !375, !DIExpression(), !386)
  %indvars.iv21.i26.reg2mem167.0.load = load i64, ptr %indvars.iv21.i26.reg2mem167, align 8
  store i64 %indvars.iv21.i26.reg2mem167.0.load, ptr %indvars.iv21.i26.reg2mem, align 8
  %invariant.gep.idx = shl i64 %indvars.iv21.i26.reg2mem167.0.load, 4, !dbg !411
  %invariant.gep = getelementptr i8, ptr %b, i64 %invariant.gep.idx, !dbg !411
  store ptr %invariant.gep, ptr %invariant.gep.reg2mem, align 8
  %7 = trunc i64 %indvars.iv21.i26.reg2mem167.0.load to i32
  store i32 %7, ptr %.reg2mem133, align 4
  store i64 0, ptr %indvars.iv.i28.reg2mem, align 8
  br label %for.body3.i27, !dbg !411

for.body3.i27:                                    ; preds = %for.body3.i27.for.body3.i27_crit_edge, %for.cond1.preheader.i25
    #dbg_value(i64 %indvars.iv.i28.reg2mem.0.load, !375, !DIExpression(), !386)
    #dbg_value(!DIArgList(i64 %indvars.iv.i28.reg2mem.0.load, i64 %indvars.iv21.i26.reg2mem167.0.load), !377, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 2, DW_OP_shl, DW_OP_plus, DW_OP_stack_value), !386)
  %indvars.iv.i28.reg2mem.0.load = load i64, ptr %indvars.iv.i28.reg2mem, align 8
  %gep = getelementptr i32, ptr %invariant.gep, i64 %indvars.iv.i28.reg2mem.0.load, !dbg !412
  %8 = load i32, ptr %gep, align 4, !dbg !412, !tbaa !361
  %shr.i30 = ashr i32 %8, %exp.0103.reg2mem171.0.load, !dbg !413
  %and.i31 = shl i32 %shr.i30, 9, !dbg !414
  %mul4.i32 = and i32 %and.i31, 1536, !dbg !414
  %add5.i33 = or disjoint i32 %mul4.i32, %7, !dbg !415
    #dbg_value(i32 %add5.i33, !376, !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value), !386)
  %9 = zext nneg i32 %add5.i33 to i64, !dbg !416
  %invariant.gep.i24.reg2mem.0.invariant.gep.i24.reload153 = load ptr, ptr %invariant.gep.i24.reg2mem, align 8
  %gep.i34 = getelementptr i32, ptr %invariant.gep.i24.reg2mem.0.invariant.gep.i24.reload153, i64 %9, !dbg !416
  %10 = load i32, ptr %gep.i34, align 4, !dbg !417, !tbaa !361
  %inc.i35 = add nsw i32 %10, 1, !dbg !417
  store i32 %inc.i35, ptr %gep.i34, align 4, !dbg !417, !tbaa !361
  %indvars.iv.next.i36 = add nuw nsw i64 %indvars.iv.i28.reg2mem.0.load, 1, !dbg !418
    #dbg_value(i64 %indvars.iv.next.i36, !375, !DIExpression(), !386)
  store i64 %indvars.iv.next.i36, ptr %indvars.iv.next.i36.reg2mem, align 8
  %exitcond.not.i37 = icmp eq i64 %indvars.iv.next.i36, 4, !dbg !419
  br i1 %exitcond.not.i37, label %for.inc10.i38, label %for.body3.i27.for.body3.i27_crit_edge, !dbg !411, !llvm.loop !420

for.body3.i27.for.body3.i27_crit_edge:            ; preds = %for.body3.i27
  store i64 %indvars.iv.next.i36, ptr %indvars.iv.i28.reg2mem, align 8
  br label %for.body3.i27, !dbg !411

for.inc10.i38:                                    ; preds = %for.body3.i27
  %indvars.iv.next22.i39 = add nuw nsw i64 %indvars.iv21.i26.reg2mem167.0.load, 1, !dbg !422
    #dbg_value(i64 %indvars.iv.next22.i39, !374, !DIExpression(), !386)
  store i64 %indvars.iv.next22.i39, ptr %indvars.iv.next22.i39.reg2mem, align 8
  %exitcond24.not.i40 = icmp eq i64 %indvars.iv.next22.i39, 512, !dbg !423
  br i1 %exitcond24.not.i40, label %for.inc10.i38.polly.split_new_and_old_crit_edge, label %for.inc10.i38.for.cond1.preheader.i25_crit_edge, !dbg !424, !llvm.loop !425

for.inc10.i38.for.cond1.preheader.i25_crit_edge:  ; preds = %for.inc10.i38
  store i64 %indvars.iv.next22.i39, ptr %indvars.iv21.i26.reg2mem167, align 8
  br label %for.cond1.preheader.i25, !dbg !424

for.inc10.i38.polly.split_new_and_old_crit_edge:  ; preds = %for.inc10.i38
  br label %polly.split_new_and_old, !dbg !424

polly.split_new_and_old:                          ; preds = %for.inc10.i38.polly.split_new_and_old_crit_edge, %for.inc10.i.polly.split_new_and_old_crit_edge
  %.reg2mem149.0..reload150 = load i1, ptr %.reg2mem149, align 1
  br i1 %.reg2mem149.0..reload150, label %polly.split_new_and_old.polly.loop_preheader11_crit_edge, label %polly.split_new_and_old.for.cond1.preheader.i42_crit_edge

polly.split_new_and_old.for.cond1.preheader.i42_crit_edge: ; preds = %polly.split_new_and_old
  store i64 0, ptr %indvars.iv19.i.reg2mem165, align 8
  br label %for.cond1.preheader.i42

polly.split_new_and_old.polly.loop_preheader11_crit_edge: ; preds = %polly.split_new_and_old
  store i64 0, ptr %polly.indvar.reg2mem, align 8
  br label %polly.loop_preheader11

for.cond1.preheader.i42:                          ; preds = %for.inc7.i.for.cond1.preheader.i42_crit_edge, %polly.split_new_and_old.for.cond1.preheader.i42_crit_edge
    #dbg_value(i64 %indvars.iv19.i.reg2mem165.0.load, !427, !DIExpression(), !438)
  %indvars.iv19.i.reg2mem165.0.load = load i64, ptr %indvars.iv19.i.reg2mem165, align 8
  store i64 %indvars.iv19.i.reg2mem165.0.load, ptr %indvars.iv19.i.reg2mem, align 8
  %11 = shl nuw nsw i64 %indvars.iv19.i.reg2mem165.0.load, 6
  %scevgep = getelementptr i8, ptr %bucket, i64 %11
    #dbg_value(i32 1, !431, !DIExpression(), !438)
  store ptr %scevgep, ptr %scevgep.reg2mem, align 8
  %load_initial = load i32, ptr %scevgep, align 4
  store i32 %load_initial, ptr %load_initial.reg2mem, align 4
  store i64 1, ptr %indvars.iv.i44.reg2mem, align 8
  store i32 %load_initial, ptr %store_forwarded.reg2mem, align 4
  br label %for.body3.i43, !dbg !440

for.body3.i43:                                    ; preds = %for.body3.i43.for.body3.i43_crit_edge, %for.cond1.preheader.i42
    #dbg_value(i64 %indvars.iv.i44.reg2mem.0.load, !431, !DIExpression(), !438)
    #dbg_value(!DIArgList(i64 %indvars.iv.i44.reg2mem.0.load, i64 %indvars.iv19.i.reg2mem165.0.load), !432, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 4, DW_OP_shl, DW_OP_plus, DW_OP_stack_value), !438)
  %store_forwarded.reg2mem.0.load = load i32, ptr %store_forwarded.reg2mem, align 4
  %indvars.iv.i44.reg2mem.0.load = load i64, ptr %indvars.iv.i44.reg2mem, align 8
  %gep96 = getelementptr i32, ptr %scevgep, i64 %indvars.iv.i44.reg2mem.0.load, !dbg !442
  %12 = load i32, ptr %gep96, align 4, !dbg !445, !tbaa !361
  %add6.i = add nsw i32 %12, %store_forwarded.reg2mem.0.load, !dbg !445
  store i32 %add6.i, ptr %add6.i.reg2mem, align 4
  store i32 %add6.i, ptr %gep96, align 4, !dbg !445, !tbaa !361
  %indvars.iv.next.i46 = add nuw nsw i64 %indvars.iv.i44.reg2mem.0.load, 1, !dbg !446
    #dbg_value(i64 %indvars.iv.next.i46, !431, !DIExpression(), !438)
  store i64 %indvars.iv.next.i46, ptr %indvars.iv.next.i46.reg2mem, align 8
  %exitcond.not.i47 = icmp eq i64 %indvars.iv.next.i46, 16, !dbg !447
  br i1 %exitcond.not.i47, label %for.inc7.i, label %for.body3.i43.for.body3.i43_crit_edge, !dbg !440, !llvm.loop !448

for.body3.i43.for.body3.i43_crit_edge:            ; preds = %for.body3.i43
  store i64 %indvars.iv.next.i46, ptr %indvars.iv.i44.reg2mem, align 8
  store i32 %add6.i, ptr %store_forwarded.reg2mem, align 4
  br label %for.body3.i43, !dbg !440

for.inc7.i:                                       ; preds = %for.body3.i43
  %indvars.iv.next20.i = add nuw nsw i64 %indvars.iv19.i.reg2mem165.0.load, 1, !dbg !450
    #dbg_value(i64 %indvars.iv.next20.i, !427, !DIExpression(), !438)
  store i64 %indvars.iv.next20.i, ptr %indvars.iv.next20.i.reg2mem, align 8
  %exitcond22.not.i = icmp eq i64 %indvars.iv.next20.i, 128, !dbg !451
  br i1 %exitcond22.not.i, label %local_scan.exit, label %for.inc7.i.for.cond1.preheader.i42_crit_edge, !dbg !452, !llvm.loop !453

for.inc7.i.for.cond1.preheader.i42_crit_edge:     ; preds = %for.inc7.i
  store i64 %indvars.iv.next20.i, ptr %indvars.iv19.i.reg2mem165, align 8
  br label %for.cond1.preheader.i42, !dbg !452

local_scan.exit:                                  ; preds = %for.inc7.i
    #dbg_value(ptr %sum, !455, !DIExpression(), !464)
    #dbg_value(ptr %bucket, !460, !DIExpression(), !464)
  store i32 0, ptr %sum, align 4, !dbg !466, !tbaa !361
    #dbg_label(!463, !467)
    #dbg_value(i32 1, !461, !DIExpression(), !464)
  store i64 1, ptr %indvars.iv.i49.reg2mem, align 8
  store i32 0, ptr %store_forwarded110.reg2mem, align 4
  br label %for.body.i, !dbg !468

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %local_scan.exit
    #dbg_value(i64 %indvars.iv.i49.reg2mem.0.load, !461, !DIExpression(), !464)
    #dbg_value(i64 %indvars.iv.i49.reg2mem.0.load, !462, !DIExpression(DW_OP_constu, 4, DW_OP_shl, DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !464)
  %store_forwarded110.reg2mem.0.load = load i32, ptr %store_forwarded110.reg2mem, align 4
  %indvars.iv.i49.reg2mem.0.load = load i64, ptr %indvars.iv.i49.reg2mem, align 8
  %13 = getelementptr i32, ptr %sum, i64 %indvars.iv.i49.reg2mem.0.load, !dbg !470
  %gep.i50.idx = shl i64 %indvars.iv.i49.reg2mem.0.load, 6, !dbg !473
  %invariant.gep.i48.reg2mem.0.invariant.gep.i48.reload = load ptr, ptr %invariant.gep.i48.reg2mem, align 8
  %gep.i50 = getelementptr i8, ptr %invariant.gep.i48.reg2mem.0.invariant.gep.i48.reload, i64 %gep.i50.idx, !dbg !473
  %14 = load i32, ptr %gep.i50, align 4, !dbg !473, !tbaa !361
  %add.i = add nsw i32 %14, %store_forwarded110.reg2mem.0.load, !dbg !474
  store i32 %add.i, ptr %add.i.reg2mem, align 4
  store i32 %add.i, ptr %13, align 4, !dbg !475, !tbaa !361
  %indvars.iv.next.i51 = add nuw nsw i64 %indvars.iv.i49.reg2mem.0.load, 1, !dbg !476
    #dbg_value(i64 %indvars.iv.next.i51, !461, !DIExpression(), !464)
  store i64 %indvars.iv.next.i51, ptr %indvars.iv.next.i51.reg2mem, align 8
  %exitcond.not.i52 = icmp eq i64 %indvars.iv.next.i51, 128, !dbg !477
  br i1 %exitcond.not.i52, label %for.body.i.for.cond1.preheader.i53_crit_edge, label %for.body.i.for.body.i_crit_edge, !dbg !468, !llvm.loop !478

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i51, ptr %indvars.iv.i49.reg2mem, align 8
  store i32 %add.i, ptr %store_forwarded110.reg2mem, align 4
  br label %for.body.i, !dbg !468

for.body.i.for.cond1.preheader.i53_crit_edge:     ; preds = %for.body.i
  store i64 0, ptr %indvars.iv22.i.reg2mem163, align 8
  br label %for.cond1.preheader.i53, !dbg !468

for.cond1.preheader.i53:                          ; preds = %for.inc9.i.for.cond1.preheader.i53_crit_edge, %for.body.i.for.cond1.preheader.i53_crit_edge
    #dbg_value(i64 %indvars.iv22.i.reg2mem163.0.load, !480, !DIExpression(), !492)
  %indvars.iv22.i.reg2mem163.0.load = load i64, ptr %indvars.iv22.i.reg2mem163, align 8
  store i64 %indvars.iv22.i.reg2mem163.0.load, ptr %indvars.iv22.i.reg2mem, align 8
  %arrayidx5.i = getelementptr inbounds i32, ptr %sum, i64 %indvars.iv22.i.reg2mem163.0.load
    #dbg_value(i32 0, !485, !DIExpression(), !492)
  store ptr %arrayidx5.i, ptr %arrayidx5.i.reg2mem, align 8
  %invariant.gep97.idx = shl i64 %indvars.iv22.i.reg2mem163.0.load, 6, !dbg !494
  %invariant.gep97 = getelementptr i8, ptr %bucket, i64 %invariant.gep97.idx, !dbg !494
  store ptr %invariant.gep97, ptr %invariant.gep97.reg2mem, align 8
  store i64 0, ptr %indvars.iv.i55.reg2mem, align 8
  br label %for.body3.i54, !dbg !494

for.body3.i54:                                    ; preds = %for.body3.i54.for.body3.i54_crit_edge, %for.cond1.preheader.i53
    #dbg_value(i64 %indvars.iv.i55.reg2mem.0.load, !485, !DIExpression(), !492)
    #dbg_value(!DIArgList(i64 %indvars.iv.i55.reg2mem.0.load, i64 %indvars.iv22.i.reg2mem163.0.load), !486, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 4, DW_OP_shl, DW_OP_plus, DW_OP_stack_value), !492)
  %indvars.iv.i55.reg2mem.0.load = load i64, ptr %indvars.iv.i55.reg2mem, align 8
  %gep98 = getelementptr i32, ptr %invariant.gep97, i64 %indvars.iv.i55.reg2mem.0.load, !dbg !496
  %15 = load i32, ptr %gep98, align 4, !dbg !496, !tbaa !361
  %16 = load i32, ptr %arrayidx5.i, align 4, !dbg !499, !tbaa !361
  %add6.i57 = add nsw i32 %16, %15, !dbg !500
  store i32 %add6.i57, ptr %gep98, align 4, !dbg !501, !tbaa !361
  %indvars.iv.next.i58 = add nuw nsw i64 %indvars.iv.i55.reg2mem.0.load, 1, !dbg !502
    #dbg_value(i64 %indvars.iv.next.i58, !485, !DIExpression(), !492)
  store i64 %indvars.iv.next.i58, ptr %indvars.iv.next.i58.reg2mem, align 8
  %exitcond.not.i59 = icmp eq i64 %indvars.iv.next.i58, 16, !dbg !503
  br i1 %exitcond.not.i59, label %for.inc9.i, label %for.body3.i54.for.body3.i54_crit_edge, !dbg !494, !llvm.loop !504

for.body3.i54.for.body3.i54_crit_edge:            ; preds = %for.body3.i54
  store i64 %indvars.iv.next.i58, ptr %indvars.iv.i55.reg2mem, align 8
  br label %for.body3.i54, !dbg !494

for.inc9.i:                                       ; preds = %for.body3.i54
  %indvars.iv.next23.i = add nuw nsw i64 %indvars.iv22.i.reg2mem163.0.load, 1, !dbg !506
    #dbg_value(i64 %indvars.iv.next23.i, !480, !DIExpression(), !492)
  store i64 %indvars.iv.next23.i, ptr %indvars.iv.next23.i.reg2mem, align 8
  %exitcond25.not.i = icmp eq i64 %indvars.iv.next23.i, 128, !dbg !507
  br i1 %exitcond25.not.i, label %for.inc9.i.last_step_scan.exit_crit_edge, label %for.inc9.i.for.cond1.preheader.i53_crit_edge, !dbg !508, !llvm.loop !509

for.inc9.i.for.cond1.preheader.i53_crit_edge:     ; preds = %for.inc9.i
  store i64 %indvars.iv.next23.i, ptr %indvars.iv22.i.reg2mem163, align 8
  br label %for.cond1.preheader.i53, !dbg !508

for.inc9.i.last_step_scan.exit_crit_edge:         ; preds = %for.inc9.i
  br label %last_step_scan.exit, !dbg !508

last_step_scan.exit:                              ; preds = %polly.loop_preheader47.3.last_step_scan.exit_crit_edge, %for.inc9.i.last_step_scan.exit_crit_edge
  %cmp1.reg2mem.0.cmp1.reload = load i1, ptr %cmp1.reg2mem, align 1
  br i1 %cmp1.reg2mem.0.cmp1.reload, label %last_step_scan.exit.for.cond1.preheader.i60_crit_edge, label %last_step_scan.exit.for.cond1.preheader.i71_crit_edge, !dbg !511

last_step_scan.exit.for.cond1.preheader.i71_crit_edge: ; preds = %last_step_scan.exit
  store i64 0, ptr %indvars.iv33.i72.reg2mem159, align 8
  br label %for.cond1.preheader.i71, !dbg !511

last_step_scan.exit.for.cond1.preheader.i60_crit_edge: ; preds = %last_step_scan.exit
  store i64 0, ptr %indvars.iv33.i.reg2mem161, align 8
  br label %for.cond1.preheader.i60, !dbg !511

for.cond1.preheader.i60:                          ; preds = %for.inc17.i.for.cond1.preheader.i60_crit_edge, %last_step_scan.exit.for.cond1.preheader.i60_crit_edge
    #dbg_value(i64 %indvars.iv33.i.reg2mem161.0.load, !512, !DIExpression(), !529)
    #dbg_value(i32 0, !521, !DIExpression(), !529)
  %indvars.iv33.i.reg2mem161.0.load = load i64, ptr %indvars.iv33.i.reg2mem161, align 8
  store i64 %indvars.iv33.i.reg2mem161.0.load, ptr %indvars.iv33.i.reg2mem, align 8
  %invariant.gep101.idx = shl i64 %indvars.iv33.i.reg2mem161.0.load, 4, !dbg !533
  %invariant.gep101 = getelementptr i8, ptr %a, i64 %invariant.gep101.idx, !dbg !533
  store ptr %invariant.gep101, ptr %invariant.gep101.reg2mem, align 8
  %17 = trunc i64 %indvars.iv33.i.reg2mem161.0.load to i32
  store i32 %17, ptr %.reg2mem116, align 4
  store i64 0, ptr %indvars.iv.i62.reg2mem, align 8
  br label %for.body3.i61, !dbg !533

for.body3.i61:                                    ; preds = %for.body3.i61.for.body3.i61_crit_edge, %for.cond1.preheader.i60
    #dbg_value(i64 %indvars.iv.i62.reg2mem.0.load, !521, !DIExpression(), !529)
  %indvars.iv.i62.reg2mem.0.load = load i64, ptr %indvars.iv.i62.reg2mem, align 8
  %gep102 = getelementptr i32, ptr %invariant.gep101, i64 %indvars.iv.i62.reg2mem.0.load, !dbg !535
  %18 = load i32, ptr %gep102, align 4, !dbg !535, !tbaa !361
  %exp.0103.reg2mem.0.load176 = load i32, ptr %exp.0103.reg2mem, align 4
  %shr.i64 = ashr i32 %18, %exp.0103.reg2mem.0.load176, !dbg !538
  %and.i65 = shl i32 %shr.i64, 9, !dbg !539
  %mul4.i66 = and i32 %and.i65, 1536, !dbg !539
  %add5.i67 = or disjoint i32 %mul4.i66, %17, !dbg !540
    #dbg_value(i32 %add5.i67, !522, !DIExpression(), !529)
    #dbg_value(!DIArgList(i64 %indvars.iv.i62.reg2mem.0.load, i64 %indvars.iv33.i.reg2mem161.0.load), !523, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 2, DW_OP_shl, DW_OP_plus, DW_OP_stack_value), !529)
  %idxprom10.i = zext nneg i32 %add5.i67 to i64, !dbg !541
  %arrayidx11.i = getelementptr inbounds i32, ptr %bucket, i64 %idxprom10.i, !dbg !541
  %19 = load i32, ptr %arrayidx11.i, align 4, !dbg !541, !tbaa !361
  %idxprom12.i = sext i32 %19 to i64, !dbg !542
  %arrayidx13.i = getelementptr inbounds i32, ptr %b, i64 %idxprom12.i, !dbg !542
  store i32 %18, ptr %arrayidx13.i, align 4, !dbg !543, !tbaa !361
  %20 = load i32, ptr %arrayidx11.i, align 4, !dbg !544, !tbaa !361
  %inc.i68 = add nsw i32 %20, 1, !dbg !544
  store i32 %inc.i68, ptr %arrayidx11.i, align 4, !dbg !544, !tbaa !361
  %indvars.iv.next.i69 = add nuw nsw i64 %indvars.iv.i62.reg2mem.0.load, 1, !dbg !545
    #dbg_value(i64 %indvars.iv.next.i69, !521, !DIExpression(), !529)
  store i64 %indvars.iv.next.i69, ptr %indvars.iv.next.i69.reg2mem, align 8
  %exitcond.not.i70 = icmp eq i64 %indvars.iv.next.i69, 4, !dbg !546
  br i1 %exitcond.not.i70, label %for.inc17.i, label %for.body3.i61.for.body3.i61_crit_edge, !dbg !533, !llvm.loop !547

for.body3.i61.for.body3.i61_crit_edge:            ; preds = %for.body3.i61
  store i64 %indvars.iv.next.i69, ptr %indvars.iv.i62.reg2mem, align 8
  br label %for.body3.i61, !dbg !533

for.inc17.i:                                      ; preds = %for.body3.i61
  %indvars.iv.next34.i = add nuw nsw i64 %indvars.iv33.i.reg2mem161.0.load, 1, !dbg !549
    #dbg_value(i64 %indvars.iv.next34.i, !512, !DIExpression(), !529)
  store i64 %indvars.iv.next34.i, ptr %indvars.iv.next34.i.reg2mem, align 8
  %exitcond36.not.i = icmp eq i64 %indvars.iv.next34.i, 512, !dbg !550
  br i1 %exitcond36.not.i, label %for.inc17.i.for.inc_crit_edge, label %for.inc17.i.for.cond1.preheader.i60_crit_edge, !dbg !551, !llvm.loop !552

for.inc17.i.for.cond1.preheader.i60_crit_edge:    ; preds = %for.inc17.i
  store i64 %indvars.iv.next34.i, ptr %indvars.iv33.i.reg2mem161, align 8
  br label %for.cond1.preheader.i60, !dbg !551

for.inc17.i.for.inc_crit_edge:                    ; preds = %for.inc17.i
  store i32 1, ptr %valid_buffer.1.reg2mem157, align 4
  br label %for.inc, !dbg !551

for.cond1.preheader.i71:                          ; preds = %for.inc17.i87.for.cond1.preheader.i71_crit_edge, %last_step_scan.exit.for.cond1.preheader.i71_crit_edge
    #dbg_value(i64 %indvars.iv33.i72.reg2mem159.0.load, !512, !DIExpression(), !554)
    #dbg_value(i32 0, !521, !DIExpression(), !554)
  %indvars.iv33.i72.reg2mem159.0.load = load i64, ptr %indvars.iv33.i72.reg2mem159, align 8
  store i64 %indvars.iv33.i72.reg2mem159.0.load, ptr %indvars.iv33.i72.reg2mem, align 8
  %invariant.gep99.idx = shl i64 %indvars.iv33.i72.reg2mem159.0.load, 4, !dbg !557
  %invariant.gep99 = getelementptr i8, ptr %b, i64 %invariant.gep99.idx, !dbg !557
  store ptr %invariant.gep99, ptr %invariant.gep99.reg2mem, align 8
  %21 = trunc i64 %indvars.iv33.i72.reg2mem159.0.load to i32
  store i32 %21, ptr %.reg2mem110, align 4
  store i64 0, ptr %indvars.iv.i74.reg2mem, align 8
  br label %for.body3.i73, !dbg !557

for.body3.i73:                                    ; preds = %for.body3.i73.for.body3.i73_crit_edge, %for.cond1.preheader.i71
    #dbg_value(i64 %indvars.iv.i74.reg2mem.0.load, !521, !DIExpression(), !554)
  %indvars.iv.i74.reg2mem.0.load = load i64, ptr %indvars.iv.i74.reg2mem, align 8
  %gep100 = getelementptr i32, ptr %invariant.gep99, i64 %indvars.iv.i74.reg2mem.0.load, !dbg !558
  %22 = load i32, ptr %gep100, align 4, !dbg !558, !tbaa !361
  %exp.0103.reg2mem.0.load177 = load i32, ptr %exp.0103.reg2mem, align 4
  %shr.i76 = ashr i32 %22, %exp.0103.reg2mem.0.load177, !dbg !559
  %and.i77 = shl i32 %shr.i76, 9, !dbg !560
  %mul4.i78 = and i32 %and.i77, 1536, !dbg !560
  %add5.i79 = or disjoint i32 %mul4.i78, %21, !dbg !561
    #dbg_value(i32 %add5.i79, !522, !DIExpression(), !554)
    #dbg_value(!DIArgList(i64 %indvars.iv.i74.reg2mem.0.load, i64 %indvars.iv33.i72.reg2mem159.0.load), !523, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_constu, 2, DW_OP_shl, DW_OP_plus, DW_OP_stack_value), !554)
  %idxprom10.i80 = zext nneg i32 %add5.i79 to i64, !dbg !562
  %arrayidx11.i81 = getelementptr inbounds i32, ptr %bucket, i64 %idxprom10.i80, !dbg !562
  %23 = load i32, ptr %arrayidx11.i81, align 4, !dbg !562, !tbaa !361
  %idxprom12.i82 = sext i32 %23 to i64, !dbg !563
  %arrayidx13.i83 = getelementptr inbounds i32, ptr %a, i64 %idxprom12.i82, !dbg !563
  store i32 %22, ptr %arrayidx13.i83, align 4, !dbg !564, !tbaa !361
  %24 = load i32, ptr %arrayidx11.i81, align 4, !dbg !565, !tbaa !361
  %inc.i84 = add nsw i32 %24, 1, !dbg !565
  store i32 %inc.i84, ptr %arrayidx11.i81, align 4, !dbg !565, !tbaa !361
  %indvars.iv.next.i85 = add nuw nsw i64 %indvars.iv.i74.reg2mem.0.load, 1, !dbg !566
    #dbg_value(i64 %indvars.iv.next.i85, !521, !DIExpression(), !554)
  store i64 %indvars.iv.next.i85, ptr %indvars.iv.next.i85.reg2mem, align 8
  %exitcond.not.i86 = icmp eq i64 %indvars.iv.next.i85, 4, !dbg !567
  br i1 %exitcond.not.i86, label %for.inc17.i87, label %for.body3.i73.for.body3.i73_crit_edge, !dbg !557, !llvm.loop !568

for.body3.i73.for.body3.i73_crit_edge:            ; preds = %for.body3.i73
  store i64 %indvars.iv.next.i85, ptr %indvars.iv.i74.reg2mem, align 8
  br label %for.body3.i73, !dbg !557

for.inc17.i87:                                    ; preds = %for.body3.i73
  %indvars.iv.next34.i88 = add nuw nsw i64 %indvars.iv33.i72.reg2mem159.0.load, 1, !dbg !570
    #dbg_value(i64 %indvars.iv.next34.i88, !512, !DIExpression(), !554)
  store i64 %indvars.iv.next34.i88, ptr %indvars.iv.next34.i88.reg2mem, align 8
  %exitcond36.not.i89 = icmp eq i64 %indvars.iv.next34.i88, 512, !dbg !571
  br i1 %exitcond36.not.i89, label %for.inc17.i87.for.inc_crit_edge, label %for.inc17.i87.for.cond1.preheader.i71_crit_edge, !dbg !572, !llvm.loop !573

for.inc17.i87.for.cond1.preheader.i71_crit_edge:  ; preds = %for.inc17.i87
  store i64 %indvars.iv.next34.i88, ptr %indvars.iv33.i72.reg2mem159, align 8
  br label %for.cond1.preheader.i71, !dbg !572

for.inc17.i87.for.inc_crit_edge:                  ; preds = %for.inc17.i87
  store i32 0, ptr %valid_buffer.1.reg2mem157, align 4
  br label %for.inc, !dbg !572

for.inc:                                          ; preds = %for.inc17.i87.for.inc_crit_edge, %for.inc17.i.for.inc_crit_edge
    #dbg_value(i32 %valid_buffer.1.reg2mem157.0.load, !339, !DIExpression(), !341)
  %valid_buffer.1.reg2mem157.0.load = load i32, ptr %valid_buffer.1.reg2mem157, align 4
  store i32 %valid_buffer.1.reg2mem157.0.load, ptr %valid_buffer.1.reg2mem, align 4
  %exp.0103.reg2mem.0.load173 = load i32, ptr %exp.0103.reg2mem, align 4
  %add = add nuw nsw i32 %exp.0103.reg2mem.0.load173, 2, !dbg !575
    #dbg_value(i32 %add, !338, !DIExpression(), !341)
  store i32 %add, ptr %add.reg2mem, align 4
  %cmp = icmp ult i32 %exp.0103.reg2mem.0.load173, 30, !dbg !576
  br i1 %cmp, label %for.inc.for.body_crit_edge, label %for.end, !dbg !343, !llvm.loop !577

for.inc.for.body_crit_edge:                       ; preds = %for.inc
  store i32 %add, ptr %exp.0103.reg2mem171, align 4
  store i32 %valid_buffer.1.reg2mem157.0.load, ptr %valid_buffer.0104.reg2mem, align 4
  br label %for.body, !dbg !343

for.end:                                          ; preds = %for.inc
  ret void, !dbg !579

polly.loop_preheader11:                           ; preds = %polly.loop_preheader11.polly.loop_preheader11_crit_edge, %polly.split_new_and_old.polly.loop_preheader11_crit_edge
  %polly.indvar.reg2mem.0.load = load i64, ptr %polly.indvar.reg2mem, align 8
  %25 = shl nuw nsw i64 %polly.indvar.reg2mem.0.load, 6
  %scevgep9 = getelementptr i8, ptr %bucket, i64 %25
  %load_initial_p_scalar_ = load i32, ptr %scevgep9, align 4, !alias.scope !580, !noalias !583
  %invariant.gep.i24.reg2mem.0.invariant.gep.i24.reload = load ptr, ptr %invariant.gep.i24.reg2mem, align 8
  %scevgep17 = getelementptr i8, ptr %invariant.gep.i24.reg2mem.0.invariant.gep.i24.reload, i64 %25
  %_p_scalar_ = load i32, ptr %scevgep17, align 4, !alias.scope !580, !noalias !583
  %p_add6.i = add nsw i32 %_p_scalar_, %load_initial_p_scalar_, !dbg !445
  store i32 %p_add6.i, ptr %scevgep17, align 4, !alias.scope !580, !noalias !583
  %scevgep18.1 = getelementptr i8, ptr %scevgep17, i64 4
  %_p_scalar_.1 = load i32, ptr %scevgep18.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.1 = add nsw i32 %_p_scalar_.1, %p_add6.i, !dbg !445
  store i32 %p_add6.i.1, ptr %scevgep18.1, align 4, !alias.scope !580, !noalias !583
  %scevgep18.2 = getelementptr i8, ptr %scevgep17, i64 8
  %_p_scalar_.2 = load i32, ptr %scevgep18.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.2 = add nsw i32 %_p_scalar_.2, %p_add6.i.1, !dbg !445
  store i32 %p_add6.i.2, ptr %scevgep18.2, align 4, !alias.scope !580, !noalias !583
  %scevgep18.3 = getelementptr i8, ptr %scevgep17, i64 12
  %_p_scalar_.3 = load i32, ptr %scevgep18.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.3 = add nsw i32 %_p_scalar_.3, %p_add6.i.2, !dbg !445
  store i32 %p_add6.i.3, ptr %scevgep18.3, align 4, !alias.scope !580, !noalias !583
  %scevgep18.4 = getelementptr i8, ptr %scevgep17, i64 16
  %_p_scalar_.4 = load i32, ptr %scevgep18.4, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.4 = add nsw i32 %_p_scalar_.4, %p_add6.i.3, !dbg !445
  store i32 %p_add6.i.4, ptr %scevgep18.4, align 4, !alias.scope !580, !noalias !583
  %scevgep18.5 = getelementptr i8, ptr %scevgep17, i64 20
  %_p_scalar_.5 = load i32, ptr %scevgep18.5, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.5 = add nsw i32 %_p_scalar_.5, %p_add6.i.4, !dbg !445
  store i32 %p_add6.i.5, ptr %scevgep18.5, align 4, !alias.scope !580, !noalias !583
  %scevgep18.6 = getelementptr i8, ptr %scevgep17, i64 24
  %_p_scalar_.6 = load i32, ptr %scevgep18.6, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.6 = add nsw i32 %_p_scalar_.6, %p_add6.i.5, !dbg !445
  store i32 %p_add6.i.6, ptr %scevgep18.6, align 4, !alias.scope !580, !noalias !583
  %scevgep18.7 = getelementptr i8, ptr %scevgep17, i64 28
  %_p_scalar_.7 = load i32, ptr %scevgep18.7, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.7 = add nsw i32 %_p_scalar_.7, %p_add6.i.6, !dbg !445
  store i32 %p_add6.i.7, ptr %scevgep18.7, align 4, !alias.scope !580, !noalias !583
  %scevgep18.8 = getelementptr i8, ptr %scevgep17, i64 32
  %_p_scalar_.8 = load i32, ptr %scevgep18.8, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.8 = add nsw i32 %_p_scalar_.8, %p_add6.i.7, !dbg !445
  store i32 %p_add6.i.8, ptr %scevgep18.8, align 4, !alias.scope !580, !noalias !583
  %scevgep18.9 = getelementptr i8, ptr %scevgep17, i64 36
  %_p_scalar_.9 = load i32, ptr %scevgep18.9, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.9 = add nsw i32 %_p_scalar_.9, %p_add6.i.8, !dbg !445
  store i32 %p_add6.i.9, ptr %scevgep18.9, align 4, !alias.scope !580, !noalias !583
  %scevgep18.10 = getelementptr i8, ptr %scevgep17, i64 40
  %_p_scalar_.10 = load i32, ptr %scevgep18.10, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.10 = add nsw i32 %_p_scalar_.10, %p_add6.i.9, !dbg !445
  store i32 %p_add6.i.10, ptr %scevgep18.10, align 4, !alias.scope !580, !noalias !583
  %scevgep18.11 = getelementptr i8, ptr %scevgep17, i64 44
  %_p_scalar_.11 = load i32, ptr %scevgep18.11, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.11 = add nsw i32 %_p_scalar_.11, %p_add6.i.10, !dbg !445
  store i32 %p_add6.i.11, ptr %scevgep18.11, align 4, !alias.scope !580, !noalias !583
  %scevgep18.12 = getelementptr i8, ptr %scevgep17, i64 48
  %_p_scalar_.12 = load i32, ptr %scevgep18.12, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.12 = add nsw i32 %_p_scalar_.12, %p_add6.i.11, !dbg !445
  store i32 %p_add6.i.12, ptr %scevgep18.12, align 4, !alias.scope !580, !noalias !583
  %scevgep18.13 = getelementptr i8, ptr %scevgep17, i64 52
  %_p_scalar_.13 = load i32, ptr %scevgep18.13, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.13 = add nsw i32 %_p_scalar_.13, %p_add6.i.12, !dbg !445
  store i32 %p_add6.i.13, ptr %scevgep18.13, align 4, !alias.scope !580, !noalias !583
  %scevgep18.14 = getelementptr i8, ptr %scevgep17, i64 56
  %_p_scalar_.14 = load i32, ptr %scevgep18.14, align 4, !alias.scope !580, !noalias !583
  %p_add6.i.14 = add nsw i32 %_p_scalar_.14, %p_add6.i.13, !dbg !445
  store i32 %p_add6.i.14, ptr %scevgep18.14, align 4, !alias.scope !580, !noalias !583
  %polly.indvar_next = add nuw nsw i64 %polly.indvar.reg2mem.0.load, 1
  store i64 %polly.indvar_next, ptr %polly.indvar_next.reg2mem, align 8
  %exitcond.not = icmp eq i64 %polly.indvar_next, 128
  br i1 %exitcond.not, label %polly.loop_preheader21, label %polly.loop_preheader11.polly.loop_preheader11_crit_edge

polly.loop_preheader11.polly.loop_preheader11_crit_edge: ; preds = %polly.loop_preheader11
  store i64 %polly.indvar_next, ptr %polly.indvar.reg2mem, align 8
  br label %polly.loop_preheader11

polly.stmt.for.body.i.cont:                       ; preds = %polly.stmt.for.body.i.cont.polly.stmt.for.body.i.cont_crit_edge, %polly.loop_preheader21
  %p_add.i69.reg2mem.0.load = load i32, ptr %p_add.i69.reg2mem, align 4
  %.reg2mem155.0.load = load i64, ptr %.reg2mem155, align 8
  %polly.indvar2368.reg2mem.0.load = load i64, ptr %polly.indvar2368.reg2mem, align 8
  store i64 %.reg2mem155.0.load, ptr %.reg2mem102, align 8
  %invariant.gep62.reg2mem.0.invariant.gep62.reload = load ptr, ptr %invariant.gep62.reg2mem, align 8
  %gep63 = getelementptr i32, ptr %invariant.gep62.reg2mem.0.invariant.gep62.reload, i64 %polly.indvar2368.reg2mem.0.load
  store i32 %p_add.i69.reg2mem.0.load, ptr %gep63, align 4, !alias.scope !583, !noalias !580
  %26 = add nuw nsw i64 %.reg2mem155.0.load, 1
  store i64 %26, ptr %.reg2mem, align 8
  %polly.access.sum26 = getelementptr i32, ptr %sum, i64 %26
  %polly.access.sum26.reload = load i32, ptr %polly.access.sum26, align 4, !alias.scope !583, !noalias !580
  %27 = shl nuw nsw i64 %.reg2mem155.0.load, 6
  %scevgep28 = getelementptr i8, ptr %scevgep27.reg2mem.0.scevgep27.reload, i64 %27
  %_p_scalar_29 = load i32, ptr %scevgep28, align 4, !alias.scope !580, !noalias !583
  %p_add.i = add nsw i32 %_p_scalar_29, %polly.access.sum26.reload, !dbg !474
  store i32 %p_add.i, ptr %p_add.i.reg2mem, align 4
  %28 = shl nuw nsw i64 %.reg2mem155.0.load, 2
  %scevgep31 = getelementptr i8, ptr %scevgep30.reg2mem.0.scevgep30.reload, i64 %28
  store i32 %p_add.i, ptr %scevgep31, align 4, !alias.scope !583, !noalias !580
  %exitcond75.not = icmp eq i64 %26, 127
  br i1 %exitcond75.not, label %polly.loop_preheader35, label %polly.stmt.for.body.i.cont.polly.stmt.for.body.i.cont_crit_edge

polly.stmt.for.body.i.cont.polly.stmt.for.body.i.cont_crit_edge: ; preds = %polly.stmt.for.body.i.cont
  store i64 %.reg2mem155.0.load, ptr %polly.indvar2368.reg2mem, align 8
  store i64 %26, ptr %.reg2mem155, align 8
  store i32 %p_add.i, ptr %p_add.i69.reg2mem, align 4
  br label %polly.stmt.for.body.i.cont

polly.loop_preheader21:                           ; preds = %polly.loop_preheader11
  %scevgep27.reg2mem.0.scevgep27.reload = load ptr, ptr %scevgep27.reg2mem, align 8
  %_p_scalar_2966 = load i32, ptr %scevgep27.reg2mem.0.scevgep27.reload, align 4
  store i32 %_p_scalar_2966, ptr %_p_scalar_2966.reg2mem, align 4
  %scevgep30.reg2mem.0.scevgep30.reload = load ptr, ptr %scevgep30.reg2mem, align 8
  store i32 %_p_scalar_2966, ptr %scevgep30.reg2mem.0.scevgep30.reload, align 4, !alias.scope !583, !noalias !580
  store i64 0, ptr %polly.indvar2368.reg2mem, align 8
  store i64 1, ptr %.reg2mem155, align 8
  store i32 %_p_scalar_2966, ptr %p_add.i69.reg2mem, align 4
  br label %polly.stmt.for.body.i.cont

polly.loop_preheader47.1:                         ; preds = %polly.loop_preheader47.polly.loop_preheader47.1_crit_edge, %polly.loop_preheader47.1.polly.loop_preheader47.1_crit_edge
  %polly.indvar43.1.reg2mem.0.load = load i64, ptr %polly.indvar43.1.reg2mem, align 8
  %29 = add nuw nsw i64 %polly.indvar43.1.reg2mem.0.load, 32
  %30 = shl i64 %29, 6
  %31 = getelementptr i8, ptr %bucket, i64 %30
  %32 = shl i64 %29, 2
  %scevgep54.1 = getelementptr i8, ptr %sum, i64 %32
  %_p_scalar_55.1 = load i32, ptr %scevgep54.1, align 4, !alias.scope !583, !noalias !580
  %_p_scalar_53.179 = load i32, ptr %31, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.180 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.179, !dbg !500
  store i32 %p_add6.i57.180, ptr %31, align 4, !alias.scope !580, !noalias !583
  %scevgep52.1.1 = getelementptr i8, ptr %31, i64 4
  %_p_scalar_53.1.1 = load i32, ptr %scevgep52.1.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.1.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.1.1, !dbg !500
  store i32 %p_add6.i57.1.1, ptr %scevgep52.1.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.2.1 = getelementptr i8, ptr %31, i64 8
  %_p_scalar_53.2.1 = load i32, ptr %scevgep52.2.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.2.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.2.1, !dbg !500
  store i32 %p_add6.i57.2.1, ptr %scevgep52.2.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.3.1 = getelementptr i8, ptr %31, i64 12
  %_p_scalar_53.3.1 = load i32, ptr %scevgep52.3.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.3.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.3.1, !dbg !500
  store i32 %p_add6.i57.3.1, ptr %scevgep52.3.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.4.1 = getelementptr i8, ptr %31, i64 16
  %_p_scalar_53.4.1 = load i32, ptr %scevgep52.4.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.4.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.4.1, !dbg !500
  store i32 %p_add6.i57.4.1, ptr %scevgep52.4.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.5.1 = getelementptr i8, ptr %31, i64 20
  %_p_scalar_53.5.1 = load i32, ptr %scevgep52.5.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.5.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.5.1, !dbg !500
  store i32 %p_add6.i57.5.1, ptr %scevgep52.5.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.6.1 = getelementptr i8, ptr %31, i64 24
  %_p_scalar_53.6.1 = load i32, ptr %scevgep52.6.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.6.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.6.1, !dbg !500
  store i32 %p_add6.i57.6.1, ptr %scevgep52.6.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.7.1 = getelementptr i8, ptr %31, i64 28
  %_p_scalar_53.7.1 = load i32, ptr %scevgep52.7.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.7.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.7.1, !dbg !500
  store i32 %p_add6.i57.7.1, ptr %scevgep52.7.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.8.1 = getelementptr i8, ptr %31, i64 32
  %_p_scalar_53.8.1 = load i32, ptr %scevgep52.8.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.8.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.8.1, !dbg !500
  store i32 %p_add6.i57.8.1, ptr %scevgep52.8.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.9.1 = getelementptr i8, ptr %31, i64 36
  %_p_scalar_53.9.1 = load i32, ptr %scevgep52.9.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.9.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.9.1, !dbg !500
  store i32 %p_add6.i57.9.1, ptr %scevgep52.9.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.10.1 = getelementptr i8, ptr %31, i64 40
  %_p_scalar_53.10.1 = load i32, ptr %scevgep52.10.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.10.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.10.1, !dbg !500
  store i32 %p_add6.i57.10.1, ptr %scevgep52.10.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.11.1 = getelementptr i8, ptr %31, i64 44
  %_p_scalar_53.11.1 = load i32, ptr %scevgep52.11.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.11.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.11.1, !dbg !500
  store i32 %p_add6.i57.11.1, ptr %scevgep52.11.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.12.1 = getelementptr i8, ptr %31, i64 48
  %_p_scalar_53.12.1 = load i32, ptr %scevgep52.12.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.12.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.12.1, !dbg !500
  store i32 %p_add6.i57.12.1, ptr %scevgep52.12.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.13.1 = getelementptr i8, ptr %31, i64 52
  %_p_scalar_53.13.1 = load i32, ptr %scevgep52.13.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.13.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.13.1, !dbg !500
  store i32 %p_add6.i57.13.1, ptr %scevgep52.13.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.14.1 = getelementptr i8, ptr %31, i64 56
  %_p_scalar_53.14.1 = load i32, ptr %scevgep52.14.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.14.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.14.1, !dbg !500
  store i32 %p_add6.i57.14.1, ptr %scevgep52.14.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.15.1 = getelementptr i8, ptr %31, i64 60
  %_p_scalar_53.15.1 = load i32, ptr %scevgep52.15.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.15.1 = add nsw i32 %_p_scalar_55.1, %_p_scalar_53.15.1, !dbg !500
  store i32 %p_add6.i57.15.1, ptr %scevgep52.15.1, align 4, !alias.scope !580, !noalias !583
  %polly.indvar_next44.1 = add nuw nsw i64 %polly.indvar43.1.reg2mem.0.load, 1
  store i64 %polly.indvar_next44.1, ptr %polly.indvar_next44.1.reg2mem, align 8
  %exitcond77.1.not = icmp eq i64 %polly.indvar_next44.1, 32
  br i1 %exitcond77.1.not, label %polly.loop_preheader47.1.polly.loop_preheader47.2_crit_edge, label %polly.loop_preheader47.1.polly.loop_preheader47.1_crit_edge

polly.loop_preheader47.1.polly.loop_preheader47.1_crit_edge: ; preds = %polly.loop_preheader47.1
  store i64 %polly.indvar_next44.1, ptr %polly.indvar43.1.reg2mem, align 8
  br label %polly.loop_preheader47.1

polly.loop_preheader47.1.polly.loop_preheader47.2_crit_edge: ; preds = %polly.loop_preheader47.1
  store i64 0, ptr %polly.indvar43.2.reg2mem, align 8
  br label %polly.loop_preheader47.2

polly.loop_preheader47.2:                         ; preds = %polly.loop_preheader47.2.polly.loop_preheader47.2_crit_edge, %polly.loop_preheader47.1.polly.loop_preheader47.2_crit_edge
  %polly.indvar43.2.reg2mem.0.load = load i64, ptr %polly.indvar43.2.reg2mem, align 8
  %33 = add nuw nsw i64 %polly.indvar43.2.reg2mem.0.load, 64
  %34 = shl i64 %33, 6
  %35 = getelementptr i8, ptr %bucket, i64 %34
  %36 = shl i64 %33, 2
  %scevgep54.2 = getelementptr i8, ptr %sum, i64 %36
  %_p_scalar_55.2 = load i32, ptr %scevgep54.2, align 4, !alias.scope !583, !noalias !580
  %_p_scalar_53.281 = load i32, ptr %35, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.282 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.281, !dbg !500
  store i32 %p_add6.i57.282, ptr %35, align 4, !alias.scope !580, !noalias !583
  %scevgep52.1.2 = getelementptr i8, ptr %35, i64 4
  %_p_scalar_53.1.2 = load i32, ptr %scevgep52.1.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.1.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.1.2, !dbg !500
  store i32 %p_add6.i57.1.2, ptr %scevgep52.1.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.2.2 = getelementptr i8, ptr %35, i64 8
  %_p_scalar_53.2.2 = load i32, ptr %scevgep52.2.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.2.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.2.2, !dbg !500
  store i32 %p_add6.i57.2.2, ptr %scevgep52.2.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.3.2 = getelementptr i8, ptr %35, i64 12
  %_p_scalar_53.3.2 = load i32, ptr %scevgep52.3.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.3.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.3.2, !dbg !500
  store i32 %p_add6.i57.3.2, ptr %scevgep52.3.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.4.2 = getelementptr i8, ptr %35, i64 16
  %_p_scalar_53.4.2 = load i32, ptr %scevgep52.4.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.4.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.4.2, !dbg !500
  store i32 %p_add6.i57.4.2, ptr %scevgep52.4.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.5.2 = getelementptr i8, ptr %35, i64 20
  %_p_scalar_53.5.2 = load i32, ptr %scevgep52.5.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.5.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.5.2, !dbg !500
  store i32 %p_add6.i57.5.2, ptr %scevgep52.5.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.6.2 = getelementptr i8, ptr %35, i64 24
  %_p_scalar_53.6.2 = load i32, ptr %scevgep52.6.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.6.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.6.2, !dbg !500
  store i32 %p_add6.i57.6.2, ptr %scevgep52.6.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.7.2 = getelementptr i8, ptr %35, i64 28
  %_p_scalar_53.7.2 = load i32, ptr %scevgep52.7.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.7.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.7.2, !dbg !500
  store i32 %p_add6.i57.7.2, ptr %scevgep52.7.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.8.2 = getelementptr i8, ptr %35, i64 32
  %_p_scalar_53.8.2 = load i32, ptr %scevgep52.8.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.8.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.8.2, !dbg !500
  store i32 %p_add6.i57.8.2, ptr %scevgep52.8.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.9.2 = getelementptr i8, ptr %35, i64 36
  %_p_scalar_53.9.2 = load i32, ptr %scevgep52.9.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.9.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.9.2, !dbg !500
  store i32 %p_add6.i57.9.2, ptr %scevgep52.9.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.10.2 = getelementptr i8, ptr %35, i64 40
  %_p_scalar_53.10.2 = load i32, ptr %scevgep52.10.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.10.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.10.2, !dbg !500
  store i32 %p_add6.i57.10.2, ptr %scevgep52.10.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.11.2 = getelementptr i8, ptr %35, i64 44
  %_p_scalar_53.11.2 = load i32, ptr %scevgep52.11.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.11.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.11.2, !dbg !500
  store i32 %p_add6.i57.11.2, ptr %scevgep52.11.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.12.2 = getelementptr i8, ptr %35, i64 48
  %_p_scalar_53.12.2 = load i32, ptr %scevgep52.12.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.12.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.12.2, !dbg !500
  store i32 %p_add6.i57.12.2, ptr %scevgep52.12.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.13.2 = getelementptr i8, ptr %35, i64 52
  %_p_scalar_53.13.2 = load i32, ptr %scevgep52.13.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.13.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.13.2, !dbg !500
  store i32 %p_add6.i57.13.2, ptr %scevgep52.13.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.14.2 = getelementptr i8, ptr %35, i64 56
  %_p_scalar_53.14.2 = load i32, ptr %scevgep52.14.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.14.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.14.2, !dbg !500
  store i32 %p_add6.i57.14.2, ptr %scevgep52.14.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.15.2 = getelementptr i8, ptr %35, i64 60
  %_p_scalar_53.15.2 = load i32, ptr %scevgep52.15.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.15.2 = add nsw i32 %_p_scalar_55.2, %_p_scalar_53.15.2, !dbg !500
  store i32 %p_add6.i57.15.2, ptr %scevgep52.15.2, align 4, !alias.scope !580, !noalias !583
  %polly.indvar_next44.2 = add nuw nsw i64 %polly.indvar43.2.reg2mem.0.load, 1
  store i64 %polly.indvar_next44.2, ptr %polly.indvar_next44.2.reg2mem, align 8
  %exitcond77.2.not = icmp eq i64 %polly.indvar_next44.2, 32
  br i1 %exitcond77.2.not, label %polly.loop_preheader47.2.polly.loop_preheader47.3_crit_edge, label %polly.loop_preheader47.2.polly.loop_preheader47.2_crit_edge

polly.loop_preheader47.2.polly.loop_preheader47.2_crit_edge: ; preds = %polly.loop_preheader47.2
  store i64 %polly.indvar_next44.2, ptr %polly.indvar43.2.reg2mem, align 8
  br label %polly.loop_preheader47.2

polly.loop_preheader47.2.polly.loop_preheader47.3_crit_edge: ; preds = %polly.loop_preheader47.2
  store i64 0, ptr %polly.indvar43.3.reg2mem, align 8
  br label %polly.loop_preheader47.3

polly.loop_preheader47.3:                         ; preds = %polly.loop_preheader47.3.polly.loop_preheader47.3_crit_edge, %polly.loop_preheader47.2.polly.loop_preheader47.3_crit_edge
  %polly.indvar43.3.reg2mem.0.load = load i64, ptr %polly.indvar43.3.reg2mem, align 8
  %37 = add nuw nsw i64 %polly.indvar43.3.reg2mem.0.load, 96
  %38 = shl i64 %37, 6
  %39 = getelementptr i8, ptr %bucket, i64 %38
  %40 = shl i64 %37, 2
  %scevgep54.3 = getelementptr i8, ptr %sum, i64 %40
  %_p_scalar_55.3 = load i32, ptr %scevgep54.3, align 4, !alias.scope !583, !noalias !580
  %_p_scalar_53.383 = load i32, ptr %39, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.384 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.383, !dbg !500
  store i32 %p_add6.i57.384, ptr %39, align 4, !alias.scope !580, !noalias !583
  %scevgep52.1.3 = getelementptr i8, ptr %39, i64 4
  %_p_scalar_53.1.3 = load i32, ptr %scevgep52.1.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.1.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.1.3, !dbg !500
  store i32 %p_add6.i57.1.3, ptr %scevgep52.1.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.2.3 = getelementptr i8, ptr %39, i64 8
  %_p_scalar_53.2.3 = load i32, ptr %scevgep52.2.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.2.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.2.3, !dbg !500
  store i32 %p_add6.i57.2.3, ptr %scevgep52.2.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.3.3 = getelementptr i8, ptr %39, i64 12
  %_p_scalar_53.3.3 = load i32, ptr %scevgep52.3.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.3.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.3.3, !dbg !500
  store i32 %p_add6.i57.3.3, ptr %scevgep52.3.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.4.3 = getelementptr i8, ptr %39, i64 16
  %_p_scalar_53.4.3 = load i32, ptr %scevgep52.4.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.4.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.4.3, !dbg !500
  store i32 %p_add6.i57.4.3, ptr %scevgep52.4.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.5.3 = getelementptr i8, ptr %39, i64 20
  %_p_scalar_53.5.3 = load i32, ptr %scevgep52.5.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.5.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.5.3, !dbg !500
  store i32 %p_add6.i57.5.3, ptr %scevgep52.5.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.6.3 = getelementptr i8, ptr %39, i64 24
  %_p_scalar_53.6.3 = load i32, ptr %scevgep52.6.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.6.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.6.3, !dbg !500
  store i32 %p_add6.i57.6.3, ptr %scevgep52.6.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.7.3 = getelementptr i8, ptr %39, i64 28
  %_p_scalar_53.7.3 = load i32, ptr %scevgep52.7.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.7.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.7.3, !dbg !500
  store i32 %p_add6.i57.7.3, ptr %scevgep52.7.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.8.3 = getelementptr i8, ptr %39, i64 32
  %_p_scalar_53.8.3 = load i32, ptr %scevgep52.8.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.8.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.8.3, !dbg !500
  store i32 %p_add6.i57.8.3, ptr %scevgep52.8.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.9.3 = getelementptr i8, ptr %39, i64 36
  %_p_scalar_53.9.3 = load i32, ptr %scevgep52.9.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.9.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.9.3, !dbg !500
  store i32 %p_add6.i57.9.3, ptr %scevgep52.9.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.10.3 = getelementptr i8, ptr %39, i64 40
  %_p_scalar_53.10.3 = load i32, ptr %scevgep52.10.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.10.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.10.3, !dbg !500
  store i32 %p_add6.i57.10.3, ptr %scevgep52.10.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.11.3 = getelementptr i8, ptr %39, i64 44
  %_p_scalar_53.11.3 = load i32, ptr %scevgep52.11.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.11.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.11.3, !dbg !500
  store i32 %p_add6.i57.11.3, ptr %scevgep52.11.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.12.3 = getelementptr i8, ptr %39, i64 48
  %_p_scalar_53.12.3 = load i32, ptr %scevgep52.12.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.12.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.12.3, !dbg !500
  store i32 %p_add6.i57.12.3, ptr %scevgep52.12.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.13.3 = getelementptr i8, ptr %39, i64 52
  %_p_scalar_53.13.3 = load i32, ptr %scevgep52.13.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.13.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.13.3, !dbg !500
  store i32 %p_add6.i57.13.3, ptr %scevgep52.13.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.14.3 = getelementptr i8, ptr %39, i64 56
  %_p_scalar_53.14.3 = load i32, ptr %scevgep52.14.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.14.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.14.3, !dbg !500
  store i32 %p_add6.i57.14.3, ptr %scevgep52.14.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.15.3 = getelementptr i8, ptr %39, i64 60
  %_p_scalar_53.15.3 = load i32, ptr %scevgep52.15.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.15.3 = add nsw i32 %_p_scalar_55.3, %_p_scalar_53.15.3, !dbg !500
  store i32 %p_add6.i57.15.3, ptr %scevgep52.15.3, align 4, !alias.scope !580, !noalias !583
  %polly.indvar_next44.3 = add nuw nsw i64 %polly.indvar43.3.reg2mem.0.load, 1
  store i64 %polly.indvar_next44.3, ptr %polly.indvar_next44.3.reg2mem, align 8
  %exitcond77.3.not = icmp eq i64 %polly.indvar_next44.3, 32
  br i1 %exitcond77.3.not, label %polly.loop_preheader47.3.last_step_scan.exit_crit_edge, label %polly.loop_preheader47.3.polly.loop_preheader47.3_crit_edge

polly.loop_preheader47.3.polly.loop_preheader47.3_crit_edge: ; preds = %polly.loop_preheader47.3
  store i64 %polly.indvar_next44.3, ptr %polly.indvar43.3.reg2mem, align 8
  br label %polly.loop_preheader47.3

polly.loop_preheader47.3.last_step_scan.exit_crit_edge: ; preds = %polly.loop_preheader47.3
  br label %last_step_scan.exit

polly.loop_preheader35:                           ; preds = %polly.stmt.for.body.i.cont
  store i32 0, ptr %sum, align 4, !alias.scope !583, !noalias !580
  store i64 0, ptr %polly.indvar43.reg2mem, align 8
  br label %polly.loop_preheader47

polly.loop_preheader47:                           ; preds = %polly.loop_preheader47.polly.loop_preheader47_crit_edge, %polly.loop_preheader35
  %polly.indvar43.reg2mem.0.load = load i64, ptr %polly.indvar43.reg2mem, align 8
  %41 = shl i64 %polly.indvar43.reg2mem.0.load, 6
  %42 = getelementptr i8, ptr %bucket, i64 %41
  %43 = shl i64 %polly.indvar43.reg2mem.0.load, 2
  %scevgep54 = getelementptr i8, ptr %sum, i64 %43
  %_p_scalar_55 = load i32, ptr %scevgep54, align 4, !alias.scope !583, !noalias !580
  %_p_scalar_53 = load i32, ptr %42, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57 = add nsw i32 %_p_scalar_55, %_p_scalar_53, !dbg !500
  store i32 %p_add6.i57, ptr %42, align 4, !alias.scope !580, !noalias !583
  %scevgep52.1 = getelementptr i8, ptr %42, i64 4
  %_p_scalar_53.1 = load i32, ptr %scevgep52.1, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.1 = add nsw i32 %_p_scalar_55, %_p_scalar_53.1, !dbg !500
  store i32 %p_add6.i57.1, ptr %scevgep52.1, align 4, !alias.scope !580, !noalias !583
  %scevgep52.2 = getelementptr i8, ptr %42, i64 8
  %_p_scalar_53.2 = load i32, ptr %scevgep52.2, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.2 = add nsw i32 %_p_scalar_55, %_p_scalar_53.2, !dbg !500
  store i32 %p_add6.i57.2, ptr %scevgep52.2, align 4, !alias.scope !580, !noalias !583
  %scevgep52.3 = getelementptr i8, ptr %42, i64 12
  %_p_scalar_53.3 = load i32, ptr %scevgep52.3, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.3 = add nsw i32 %_p_scalar_55, %_p_scalar_53.3, !dbg !500
  store i32 %p_add6.i57.3, ptr %scevgep52.3, align 4, !alias.scope !580, !noalias !583
  %scevgep52.4 = getelementptr i8, ptr %42, i64 16
  %_p_scalar_53.4 = load i32, ptr %scevgep52.4, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.4 = add nsw i32 %_p_scalar_55, %_p_scalar_53.4, !dbg !500
  store i32 %p_add6.i57.4, ptr %scevgep52.4, align 4, !alias.scope !580, !noalias !583
  %scevgep52.5 = getelementptr i8, ptr %42, i64 20
  %_p_scalar_53.5 = load i32, ptr %scevgep52.5, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.5 = add nsw i32 %_p_scalar_55, %_p_scalar_53.5, !dbg !500
  store i32 %p_add6.i57.5, ptr %scevgep52.5, align 4, !alias.scope !580, !noalias !583
  %scevgep52.6 = getelementptr i8, ptr %42, i64 24
  %_p_scalar_53.6 = load i32, ptr %scevgep52.6, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.6 = add nsw i32 %_p_scalar_55, %_p_scalar_53.6, !dbg !500
  store i32 %p_add6.i57.6, ptr %scevgep52.6, align 4, !alias.scope !580, !noalias !583
  %scevgep52.7 = getelementptr i8, ptr %42, i64 28
  %_p_scalar_53.7 = load i32, ptr %scevgep52.7, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.7 = add nsw i32 %_p_scalar_55, %_p_scalar_53.7, !dbg !500
  store i32 %p_add6.i57.7, ptr %scevgep52.7, align 4, !alias.scope !580, !noalias !583
  %scevgep52.8 = getelementptr i8, ptr %42, i64 32
  %_p_scalar_53.8 = load i32, ptr %scevgep52.8, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.8 = add nsw i32 %_p_scalar_55, %_p_scalar_53.8, !dbg !500
  store i32 %p_add6.i57.8, ptr %scevgep52.8, align 4, !alias.scope !580, !noalias !583
  %scevgep52.9 = getelementptr i8, ptr %42, i64 36
  %_p_scalar_53.9 = load i32, ptr %scevgep52.9, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.9 = add nsw i32 %_p_scalar_55, %_p_scalar_53.9, !dbg !500
  store i32 %p_add6.i57.9, ptr %scevgep52.9, align 4, !alias.scope !580, !noalias !583
  %scevgep52.10 = getelementptr i8, ptr %42, i64 40
  %_p_scalar_53.10 = load i32, ptr %scevgep52.10, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.10 = add nsw i32 %_p_scalar_55, %_p_scalar_53.10, !dbg !500
  store i32 %p_add6.i57.10, ptr %scevgep52.10, align 4, !alias.scope !580, !noalias !583
  %scevgep52.11 = getelementptr i8, ptr %42, i64 44
  %_p_scalar_53.11 = load i32, ptr %scevgep52.11, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.11 = add nsw i32 %_p_scalar_55, %_p_scalar_53.11, !dbg !500
  store i32 %p_add6.i57.11, ptr %scevgep52.11, align 4, !alias.scope !580, !noalias !583
  %scevgep52.12 = getelementptr i8, ptr %42, i64 48
  %_p_scalar_53.12 = load i32, ptr %scevgep52.12, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.12 = add nsw i32 %_p_scalar_55, %_p_scalar_53.12, !dbg !500
  store i32 %p_add6.i57.12, ptr %scevgep52.12, align 4, !alias.scope !580, !noalias !583
  %scevgep52.13 = getelementptr i8, ptr %42, i64 52
  %_p_scalar_53.13 = load i32, ptr %scevgep52.13, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.13 = add nsw i32 %_p_scalar_55, %_p_scalar_53.13, !dbg !500
  store i32 %p_add6.i57.13, ptr %scevgep52.13, align 4, !alias.scope !580, !noalias !583
  %scevgep52.14 = getelementptr i8, ptr %42, i64 56
  %_p_scalar_53.14 = load i32, ptr %scevgep52.14, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.14 = add nsw i32 %_p_scalar_55, %_p_scalar_53.14, !dbg !500
  store i32 %p_add6.i57.14, ptr %scevgep52.14, align 4, !alias.scope !580, !noalias !583
  %scevgep52.15 = getelementptr i8, ptr %42, i64 60
  %_p_scalar_53.15 = load i32, ptr %scevgep52.15, align 4, !alias.scope !580, !noalias !583
  %p_add6.i57.15 = add nsw i32 %_p_scalar_55, %_p_scalar_53.15, !dbg !500
  store i32 %p_add6.i57.15, ptr %scevgep52.15, align 4, !alias.scope !580, !noalias !583
  %polly.indvar_next44 = add nuw nsw i64 %polly.indvar43.reg2mem.0.load, 1
  store i64 %polly.indvar_next44, ptr %polly.indvar_next44.reg2mem, align 8
  %exitcond77.not = icmp eq i64 %polly.indvar_next44, 32
  br i1 %exitcond77.not, label %polly.loop_preheader47.polly.loop_preheader47.1_crit_edge, label %polly.loop_preheader47.polly.loop_preheader47_crit_edge

polly.loop_preheader47.polly.loop_preheader47_crit_edge: ; preds = %polly.loop_preheader47
  store i64 %polly.indvar_next44, ptr %polly.indvar43.reg2mem, align 8
  br label %polly.loop_preheader47

polly.loop_preheader47.polly.loop_preheader47.1_crit_edge: ; preds = %polly.loop_preheader47
  store i64 0, ptr %polly.indvar43.1.reg2mem, align 8
  br label %polly.loop_preheader47.1
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #2 !dbg !585 {
entry.split:
    #dbg_value(ptr %vargs, !589, !DIExpression(), !591)
    #dbg_value(ptr %vargs, !590, !DIExpression(), !591)
  %b = getelementptr inbounds i8, ptr %vargs, i64 8192, !dbg !592
  %bucket = getelementptr inbounds i8, ptr %vargs, i64 16384, !dbg !593
  %sum = getelementptr inbounds i8, ptr %vargs, i64 24576, !dbg !594
  tail call void @sort(ptr noundef %vargs, ptr noundef nonnull %b, ptr noundef nonnull %bucket, ptr noundef nonnull %sum) #18, !dbg !595
  ret void, !dbg !596
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #3 !dbg !597 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !601, !DIExpression(), !606)
    #dbg_value(ptr %vdata, !602, !DIExpression(), !606)
    #dbg_value(ptr %vdata, !603, !DIExpression(), !606)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(25088) %vdata, i8 0, i64 25088, i1 false), !dbg !607
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !608
    #dbg_value(ptr %call, !604, !DIExpression(), !606)
    #dbg_value(ptr %call, !609, !DIExpression(), !616)
    #dbg_value(i32 1, !614, !DIExpression(), !616)
    #dbg_value(i32 0, !615, !DIExpression(), !616)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !615, !DIExpression(), !616)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !609, !DIExpression(), !616)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !618, !tbaa !619
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !620

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !620

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !620

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !621
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !621, !tbaa !619
  %cmp13.i = icmp eq i8 %1, 37, !dbg !624
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !625

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !625

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !626
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !626, !tbaa !619
  %cmp18.i = icmp eq i8 %2, 10, !dbg !627
  %inc.i = zext i1 %cmp18.i to i32, !dbg !628
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !628
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !628

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !615, !DIExpression(), !616)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !629
    #dbg_value(ptr %incdec.ptr.i, !609, !DIExpression(), !616)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !630
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !631, !llvm.loop !632

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !631

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !634, !tbaa !619
  %3 = icmp eq i8 %.pre.i, 0, !dbg !636
  %4 = select i1 %3, i64 0, i64 2, !dbg !637
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !631

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !637
    #dbg_value(ptr %spec.select38.i, !605, !DIExpression(), !606)
  %call2 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 2048) #18, !dbg !638
  tail call void @free(ptr noundef %call) #18, !dbg !639
  ret void, !dbg !640
}

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !641 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #4

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #3 !dbg !643 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !645, !DIExpression(), !648)
    #dbg_value(ptr %vdata, !646, !DIExpression(), !648)
    #dbg_value(ptr %vdata, !647, !DIExpression(), !648)
    #dbg_value(i32 %fd, !649, !DIExpression(), !654)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !656
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !656

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !656
  unreachable, !dbg !656

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !659
    #dbg_value(i32 %fd, !660, !DIExpression(), !669)
    #dbg_value(ptr %vdata, !666, !DIExpression(), !669)
    #dbg_value(i32 2048, !667, !DIExpression(), !669)
    #dbg_value(i32 0, !668, !DIExpression(), !669)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !671

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !668, !DIExpression(), !669)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i32, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !673
  %0 = load i32, ptr %arrayidx.i, align 4, !dbg !673, !tbaa !361
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !673
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !676
    #dbg_value(i64 %indvars.iv.next.i, !668, !DIExpression(), !669)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 2048, !dbg !676
  br i1 %exitcond.not.i, label %write_int32_t_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !671, !llvm.loop !677

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !671

write_int32_t_array.exit:                         ; preds = %for.body.i
  ret void, !dbg !678
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #3 !dbg !679 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !681, !DIExpression(), !686)
    #dbg_value(ptr %vdata, !682, !DIExpression(), !686)
    #dbg_value(ptr %vdata, !683, !DIExpression(), !686)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(25088) %vdata, i8 0, i64 25088, i1 false), !dbg !687
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !688
    #dbg_value(ptr %call, !684, !DIExpression(), !686)
    #dbg_value(ptr %call, !609, !DIExpression(), !689)
    #dbg_value(i32 1, !614, !DIExpression(), !689)
    #dbg_value(i32 0, !615, !DIExpression(), !689)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !615, !DIExpression(), !689)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !609, !DIExpression(), !689)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !691, !tbaa !619
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !692

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !692

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !692

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !693
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !693, !tbaa !619
  %cmp13.i = icmp eq i8 %1, 37, !dbg !694
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !695

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !695

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !696
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !696, !tbaa !619
  %cmp18.i = icmp eq i8 %2, 10, !dbg !697
  %inc.i = zext i1 %cmp18.i to i32, !dbg !698
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !698
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !698

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !615, !DIExpression(), !689)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !699
    #dbg_value(ptr %incdec.ptr.i, !609, !DIExpression(), !689)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !700
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !701, !llvm.loop !702

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !701

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !704, !tbaa !619
  %3 = icmp eq i8 %.pre.i, 0, !dbg !705
  %4 = select i1 %3, i64 0, i64 2, !dbg !706
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !701

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !706
    #dbg_value(ptr %spec.select38.i, !685, !DIExpression(), !686)
  %call2 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 2048) #18, !dbg !707
  tail call void @free(ptr noundef %call) #18, !dbg !708
  ret void, !dbg !709
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #3 !dbg !710 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !712, !DIExpression(), !715)
    #dbg_value(ptr %vdata, !713, !DIExpression(), !715)
    #dbg_value(ptr %vdata, !714, !DIExpression(), !715)
    #dbg_value(i32 %fd, !649, !DIExpression(), !716)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !718
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !718

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !718
  unreachable, !dbg !718

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !719
    #dbg_value(i32 %fd, !660, !DIExpression(), !720)
    #dbg_value(ptr %vdata, !666, !DIExpression(), !720)
    #dbg_value(i32 2048, !667, !DIExpression(), !720)
    #dbg_value(i32 0, !668, !DIExpression(), !720)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !722

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !668, !DIExpression(), !720)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i32, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !723
  %0 = load i32, ptr %arrayidx.i, align 4, !dbg !723, !tbaa !361
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !723
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !724
    #dbg_value(i64 %indvars.iv.next.i, !668, !DIExpression(), !720)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 2048, !dbg !724
  br i1 %exitcond.not.i, label %write_int32_t_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !722, !llvm.loop !725

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !722

write_int32_t_array.exit:                         ; preds = %for.body.i
  ret void, !dbg !726
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #5 !dbg !727 {
entry.split:
  %has_errors.032.reg2mem = alloca i32, align 4
  %data_sum.034.reg2mem = alloca i32, align 4
  %ref_sum.035.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
  %.reg2mem12 = alloca i32, align 4
    #dbg_value(ptr %vdata, !731, !DIExpression(), !739)
    #dbg_value(ptr %vref, !732, !DIExpression(), !739)
    #dbg_value(ptr %vdata, !733, !DIExpression(), !739)
    #dbg_value(ptr %vref, !734, !DIExpression(), !739)
    #dbg_value(i32 0, !735, !DIExpression(), !739)
  %0 = load i32, ptr %vdata, align 4, !dbg !740
    #dbg_value(i32 %0, !737, !DIExpression(), !739)
  %1 = load i32, ptr %vref, align 4, !dbg !741
    #dbg_value(i32 %1, !738, !DIExpression(), !739)
    #dbg_value(i32 1, !736, !DIExpression(), !739)
  store i32 0, ptr %has_errors.032.reg2mem, align 4
  store i32 %0, ptr %data_sum.034.reg2mem, align 4
  store i32 %1, ptr %ref_sum.035.reg2mem, align 4
  store i64 1, ptr %indvars.iv.reg2mem, align 8
  store i32 %0, ptr %.reg2mem12, align 4
  br label %for.body, !dbg !742

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i32 %ref_sum.035.reg2mem.0.load, !738, !DIExpression(), !739)
    #dbg_value(i32 %data_sum.034.reg2mem.0.load, !737, !DIExpression(), !739)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !736, !DIExpression(), !739)
    #dbg_value(i32 %has_errors.032.reg2mem.0.load, !735, !DIExpression(), !739)
  %.reg2mem12.0.load = load i32, ptr %.reg2mem12, align 4
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %ref_sum.035.reg2mem.0.load = load i32, ptr %ref_sum.035.reg2mem, align 4
  %data_sum.034.reg2mem.0.load = load i32, ptr %data_sum.034.reg2mem, align 4
  %has_errors.032.reg2mem.0.load = load i32, ptr %has_errors.032.reg2mem, align 4
  %arrayidx7 = getelementptr inbounds [2048 x i32], ptr %vdata, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !744
  %2 = load i32, ptr %arrayidx7, align 4, !dbg !744
  %cmp8 = icmp sgt i32 %.reg2mem12.0.load, %2, !dbg !747
  %conv = zext i1 %cmp8 to i32, !dbg !747
  %or = or i32 %has_errors.032.reg2mem.0.load, %conv, !dbg !748
    #dbg_value(i32 %or, !735, !DIExpression(), !739)
  %add = add nsw i32 %2, %data_sum.034.reg2mem.0.load, !dbg !749
    #dbg_value(i32 %add, !737, !DIExpression(), !739)
  %arrayidx14 = getelementptr inbounds [2048 x i32], ptr %vref, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !750
  %3 = load i32, ptr %arrayidx14, align 4, !dbg !750, !tbaa !361
  %add15 = add nsw i32 %3, %ref_sum.035.reg2mem.0.load, !dbg !751
    #dbg_value(i32 %add15, !738, !DIExpression(), !739)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !752
    #dbg_value(i64 %indvars.iv.next, !736, !DIExpression(), !739)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 2048, !dbg !753
  br i1 %exitcond.not, label %for.end, label %for.body.for.body_crit_edge, !dbg !742, !llvm.loop !754

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i32 %or, ptr %has_errors.032.reg2mem, align 4
  store i32 %add, ptr %data_sum.034.reg2mem, align 4
  store i32 %add15, ptr %ref_sum.035.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  store i32 %2, ptr %.reg2mem12, align 4
  br label %for.body, !dbg !742

for.end:                                          ; preds = %for.body
  %cmp16 = icmp ne i32 %add, %add15, !dbg !756
  %conv17 = zext i1 %cmp16 to i32, !dbg !756
  %or18 = or i32 %or, %conv17, !dbg !757
    #dbg_value(i32 %or18, !735, !DIExpression(), !739)
  %tobool.not = icmp eq i32 %or18, 0, !dbg !758
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !758
  ret i32 %lnot.ext, !dbg !759
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #3 !dbg !760 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !810
    #dbg_assign(i1 undef, !766, !DIExpression(), !810, ptr %s, !DIExpression(), !811)
    #dbg_value(i32 %fd, !764, !DIExpression(), !811)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #18, !dbg !812
  %cmp = icmp sgt i32 %fd, 1, !dbg !813
  br i1 %cmp, label %if.end, label %if.else, !dbg !813

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !813
  unreachable, !dbg !813

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #18, !dbg !816
  %cmp1 = icmp eq i32 %call, 0, !dbg !816
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !816

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !816
  unreachable, !dbg !816

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !819
  %0 = load i64, ptr %st_size, align 8, !dbg !819
    #dbg_value(i64 %0, !803, !DIExpression(), !811)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !820
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !820

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !820
  unreachable, !dbg !820

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !823
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #20, !dbg !824
    #dbg_value(ptr %call11, !765, !DIExpression(), !811)
    #dbg_value(i64 0, !806, !DIExpression(), !811)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !825

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !826
    #dbg_value(i64 %add19, !806, !DIExpression(), !811)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !828
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !825, !llvm.loop !829

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !825

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !806, !DIExpression(), !811)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !831
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !832
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #18, !dbg !833
    #dbg_value(i64 %call13, !809, !DIExpression(), !811)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !834
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !806, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !811)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !834

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !834
  unreachable, !dbg !834

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !837
  store i8 0, ptr %arrayidx20, align 1, !dbg !838, !tbaa !619
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #18, !dbg !839
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #18, !dbg !840
  ret ptr %call11, !dbg !841
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: noreturn nounwind
declare !dbg !842 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare !dbg !847 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !852 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #9

; Function Attrs: nofree
declare !dbg !857 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #10

declare !dbg !861 signext i32 @close(i32 noundef signext) local_unnamed_addr #11

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #3 !dbg !610 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !609, !DIExpression(), !862)
    #dbg_value(i32 %n, !614, !DIExpression(), !862)
    #dbg_value(i32 0, !615, !DIExpression(), !862)
  %cmp = icmp sgt i32 %n, -1, !dbg !863
  br i1 %cmp, label %if.end, label %if.else, !dbg !863

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #19, !dbg !863
  unreachable, !dbg !863

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !866
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !868

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !868

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !868

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !615, !DIExpression(), !862)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !609, !DIExpression(), !862)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !869, !tbaa !619
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !870

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !870

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !870

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !871
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !871, !tbaa !619
  %cmp13 = icmp eq i8 %1, 37, !dbg !872
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !873

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !873

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !874
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !874, !tbaa !619
  %cmp18 = icmp eq i8 %2, 10, !dbg !875
  %inc = zext i1 %cmp18 to i32, !dbg !876
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !876
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !876

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !615, !DIExpression(), !862)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !877
    #dbg_value(ptr %incdec.ptr, !609, !DIExpression(), !862)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !878
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !879, !llvm.loop !880

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !879

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !882, !tbaa !619
  %3 = icmp eq i8 %.pre, 0, !dbg !883
  %4 = select i1 %3, i64 0, i64 2, !dbg !884
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !879

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !884
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !884

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !885
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !886 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !890, !DIExpression(), !894)
    #dbg_value(ptr %arr, !891, !DIExpression(), !894)
    #dbg_value(i32 %n, !892, !DIExpression(), !894)
  %cmp.not = icmp eq ptr %s, null, !dbg !895
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !895

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #19, !dbg !895
  unreachable, !dbg !895

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !898
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !900

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !901
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !903
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !903

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !893, !DIExpression(), !894)
  %conv404 = zext nneg i32 %n to i64, !dbg !904
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !905
  br label %if.end46, !dbg !906

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !893, !DIExpression(), !894)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !907
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !908

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !908

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !909
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !910
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !910
  %cmp9.not = icmp eq i8 %0, 0, !dbg !911
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !912

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !912

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !913
  %1 = load i8, ptr %gep, align 1, !dbg !913
  %cmp16.not = icmp eq i8 %1, 0, !dbg !914
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !915

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !915

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !916
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !917
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !917
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !917, !llvm.loop !918

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !917

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !904

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !904

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !904

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !904
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !893, !DIExpression(), !894)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !905
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !920
  store i8 0, ptr %arrayidx45, align 1, !dbg !922, !tbaa !619
  br label %if.end46, !dbg !920

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !923
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !924 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !936
    #dbg_assign(i1 undef, !933, !DIExpression(), !936, ptr %endptr, !DIExpression(), !937)
    #dbg_value(ptr %s, !929, !DIExpression(), !937)
    #dbg_value(ptr %arr, !930, !DIExpression(), !937)
    #dbg_value(i32 %n, !931, !DIExpression(), !937)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !938
    #dbg_value(i32 0, !934, !DIExpression(), !937)
  %cmp.not = icmp eq ptr %s, null, !dbg !939
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !939

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #19, !dbg !939
  unreachable, !dbg !939

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !938
    #dbg_value(ptr %call, !932, !DIExpression(), !937)
    #dbg_value(i32 0, !934, !DIExpression(), !937)
  %cmp130 = icmp ne ptr %call, null, !dbg !938
  %cmp231 = icmp sgt i32 %n, 0, !dbg !938
  %0 = and i1 %cmp231, %cmp130, !dbg !938
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !938

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !938

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !938
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !938

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !932, !DIExpression(), !937)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !934, !DIExpression(), !937)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !942, !tbaa !944, !DIAssignID !946
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !933, !DIExpression(), !946, ptr %endptr, !DIExpression(), !937)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !942
  %conv = trunc i64 %call3 to i8, !dbg !942
    #dbg_value(i8 %conv, !935, !DIExpression(), !937)
  %2 = load ptr, ptr %endptr, align 8, !dbg !947, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !947, !tbaa !619
  %cmp5.not = icmp eq i8 %3, 0, !dbg !947
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !942

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !942

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !949, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !949
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !949
  br label %if.end9, !dbg !949

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !942
  store i8 %conv, ptr %arrayidx, align 1, !dbg !942, !tbaa !619
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !942
    #dbg_value(i64 %indvars.iv.next, !934, !DIExpression(), !937)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !942
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !942
  store i8 10, ptr %arrayidx11, align 1, !dbg !942, !tbaa !619
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !942
    #dbg_value(ptr %call12, !932, !DIExpression(), !937)
  %cmp1 = icmp ne ptr %call12, null, !dbg !938
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !938
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !938
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !938, !llvm.loop !951

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !938

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !938

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !938

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !938

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !952
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !952
  store i8 10, ptr %arrayidx17, align 1, !dbg !952, !tbaa !619
  br label %if.end18, !dbg !952

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !938
  ret i32 0, !dbg !938
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !955 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #13

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !961 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #13

; Function Attrs: nofree nounwind
declare !dbg !966 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !1021 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #14

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1024 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1036
    #dbg_assign(i1 undef, !1033, !DIExpression(), !1036, ptr %endptr, !DIExpression(), !1037)
    #dbg_value(ptr %s, !1029, !DIExpression(), !1037)
    #dbg_value(ptr %arr, !1030, !DIExpression(), !1037)
    #dbg_value(i32 %n, !1031, !DIExpression(), !1037)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1038
    #dbg_value(i32 0, !1034, !DIExpression(), !1037)
  %cmp.not = icmp eq ptr %s, null, !dbg !1039
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1039

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #19, !dbg !1039
  unreachable, !dbg !1039

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1038
    #dbg_value(ptr %call, !1032, !DIExpression(), !1037)
    #dbg_value(i32 0, !1034, !DIExpression(), !1037)
  %cmp130 = icmp ne ptr %call, null, !dbg !1038
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1038
  %0 = and i1 %cmp231, %cmp130, !dbg !1038
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1038

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1038

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1038
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1038

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1032, !DIExpression(), !1037)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1034, !DIExpression(), !1037)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1042, !tbaa !944, !DIAssignID !1044
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1033, !DIExpression(), !1044, ptr %endptr, !DIExpression(), !1037)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1042
  %conv = trunc i64 %call3 to i16, !dbg !1042
    #dbg_value(i16 %conv, !1035, !DIExpression(), !1037)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1045, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1045, !tbaa !619
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1045
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1042

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1042

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1047, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1047
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1047
  br label %if.end9, !dbg !1047

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1042
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1042, !tbaa !1049
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1042
    #dbg_value(i64 %indvars.iv.next, !1034, !DIExpression(), !1037)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1042
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1042
  store i8 10, ptr %arrayidx11, align 1, !dbg !1042, !tbaa !619
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1042
    #dbg_value(ptr %call12, !1032, !DIExpression(), !1037)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1038
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1038
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1038
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1038, !llvm.loop !1051

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1038

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1038

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1038

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1038

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1052
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1052
  store i8 10, ptr %arrayidx17, align 1, !dbg !1052, !tbaa !619
  br label %if.end18, !dbg !1052

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1038
  ret i32 0, !dbg !1038
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1055 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1067
    #dbg_assign(i1 undef, !1064, !DIExpression(), !1067, ptr %endptr, !DIExpression(), !1068)
    #dbg_value(ptr %s, !1060, !DIExpression(), !1068)
    #dbg_value(ptr %arr, !1061, !DIExpression(), !1068)
    #dbg_value(i32 %n, !1062, !DIExpression(), !1068)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1069
    #dbg_value(i32 0, !1065, !DIExpression(), !1068)
  %cmp.not = icmp eq ptr %s, null, !dbg !1070
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1070

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #19, !dbg !1070
  unreachable, !dbg !1070

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1069
    #dbg_value(ptr %call, !1063, !DIExpression(), !1068)
    #dbg_value(i32 0, !1065, !DIExpression(), !1068)
  %cmp130 = icmp ne ptr %call, null, !dbg !1069
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1069
  %0 = and i1 %cmp231, %cmp130, !dbg !1069
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1069

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1069

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1069
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1069

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1063, !DIExpression(), !1068)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1065, !DIExpression(), !1068)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1073, !tbaa !944, !DIAssignID !1075
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1064, !DIExpression(), !1075, ptr %endptr, !DIExpression(), !1068)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1073
  %conv = trunc i64 %call3 to i32, !dbg !1073
    #dbg_value(i32 %conv, !1066, !DIExpression(), !1068)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1076, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1076, !tbaa !619
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1076
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1073

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1073

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1078, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1078
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1078
  br label %if.end9, !dbg !1078

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1073
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1073, !tbaa !361
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1073
    #dbg_value(i64 %indvars.iv.next, !1065, !DIExpression(), !1068)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1073
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1073
  store i8 10, ptr %arrayidx11, align 1, !dbg !1073, !tbaa !619
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1073
    #dbg_value(ptr %call12, !1063, !DIExpression(), !1068)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1069
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1069
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1069
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1069, !llvm.loop !1080

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1069

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1069

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1069

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1069

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1081
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1081
  store i8 10, ptr %arrayidx17, align 1, !dbg !1081, !tbaa !619
  br label %if.end18, !dbg !1081

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1069
  ret i32 0, !dbg !1069
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
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1102, !tbaa !944, !DIAssignID !1104
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1093, !DIExpression(), !1104, ptr %endptr, !DIExpression(), !1097)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1102
    #dbg_value(i64 %call3, !1095, !DIExpression(), !1097)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1105, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1105, !tbaa !619
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1105
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1102

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1102

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1107, !tbaa !944
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
  store i8 10, ptr %arrayidx10, align 1, !dbg !1102, !tbaa !619
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
  store i8 10, ptr %arrayidx16, align 1, !dbg !1112, !tbaa !619
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
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1133, !tbaa !944, !DIAssignID !1135
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1124, !DIExpression(), !1135, ptr %endptr, !DIExpression(), !1128)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1133
  %conv = trunc i64 %call3 to i8, !dbg !1133
    #dbg_value(i8 %conv, !1126, !DIExpression(), !1128)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1136, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1136, !tbaa !619
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1136
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1133

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1133

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1138, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1138
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1138
  br label %if.end9, !dbg !1138

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1133
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1133, !tbaa !619
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1133
    #dbg_value(i64 %indvars.iv.next, !1125, !DIExpression(), !1128)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1133
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1133
  store i8 10, ptr %arrayidx11, align 1, !dbg !1133, !tbaa !619
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
  store i8 10, ptr %arrayidx17, align 1, !dbg !1141, !tbaa !619
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
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1162, !tbaa !944, !DIAssignID !1164
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1153, !DIExpression(), !1164, ptr %endptr, !DIExpression(), !1157)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1162
  %conv = trunc i64 %call3 to i16, !dbg !1162
    #dbg_value(i16 %conv, !1155, !DIExpression(), !1157)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1165, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1165, !tbaa !619
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1165
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1162

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1162

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1167, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1167
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1167
  br label %if.end9, !dbg !1167

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1162
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1162, !tbaa !1049
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1162
    #dbg_value(i64 %indvars.iv.next, !1154, !DIExpression(), !1157)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1162
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1162
  store i8 10, ptr %arrayidx11, align 1, !dbg !1162, !tbaa !619
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
  store i8 10, ptr %arrayidx17, align 1, !dbg !1170, !tbaa !619
  br label %if.end18, !dbg !1170

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1158
  ret i32 0, !dbg !1158
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1173 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1184
    #dbg_assign(i1 undef, !1181, !DIExpression(), !1184, ptr %endptr, !DIExpression(), !1185)
    #dbg_value(ptr %s, !1177, !DIExpression(), !1185)
    #dbg_value(ptr %arr, !1178, !DIExpression(), !1185)
    #dbg_value(i32 %n, !1179, !DIExpression(), !1185)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1186
    #dbg_value(i32 0, !1182, !DIExpression(), !1185)
  %cmp.not = icmp eq ptr %s, null, !dbg !1187
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1187

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #19, !dbg !1187
  unreachable, !dbg !1187

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1186
    #dbg_value(ptr %call, !1180, !DIExpression(), !1185)
    #dbg_value(i32 0, !1182, !DIExpression(), !1185)
  %cmp130 = icmp ne ptr %call, null, !dbg !1186
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1186
  %0 = and i1 %cmp231, %cmp130, !dbg !1186
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1186

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1186

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1186
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1186

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1180, !DIExpression(), !1185)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1182, !DIExpression(), !1185)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1190, !tbaa !944, !DIAssignID !1192
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1181, !DIExpression(), !1192, ptr %endptr, !DIExpression(), !1185)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1190
  %conv = trunc i64 %call3 to i32, !dbg !1190
    #dbg_value(i32 %conv, !1183, !DIExpression(), !1185)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1193, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1193, !tbaa !619
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1193
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1190

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1190

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1195, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1195
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1195
  br label %if.end9, !dbg !1195

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1190
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1190, !tbaa !361
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1190
    #dbg_value(i64 %indvars.iv.next, !1182, !DIExpression(), !1185)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1190
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1190
  store i8 10, ptr %arrayidx11, align 1, !dbg !1190, !tbaa !619
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1190
    #dbg_value(ptr %call12, !1180, !DIExpression(), !1185)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1186
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1186
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1186
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1186, !llvm.loop !1197

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1186

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1186

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1186

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1186

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1198
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1198
  store i8 10, ptr %arrayidx17, align 1, !dbg !1198, !tbaa !619
  br label %if.end18, !dbg !1198

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1186
  ret i32 0, !dbg !1186
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1201 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1213
    #dbg_assign(i1 undef, !1210, !DIExpression(), !1213, ptr %endptr, !DIExpression(), !1214)
    #dbg_value(ptr %s, !1206, !DIExpression(), !1214)
    #dbg_value(ptr %arr, !1207, !DIExpression(), !1214)
    #dbg_value(i32 %n, !1208, !DIExpression(), !1214)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1215
    #dbg_value(i32 0, !1211, !DIExpression(), !1214)
  %cmp.not = icmp eq ptr %s, null, !dbg !1216
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1216

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #19, !dbg !1216
  unreachable, !dbg !1216

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1215
    #dbg_value(ptr %call, !1209, !DIExpression(), !1214)
    #dbg_value(i32 0, !1211, !DIExpression(), !1214)
  %cmp129 = icmp ne ptr %call, null, !dbg !1215
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1215
  %0 = and i1 %cmp230, %cmp129, !dbg !1215
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1215

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1215

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1215
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1215

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1209, !DIExpression(), !1214)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1211, !DIExpression(), !1214)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1219, !tbaa !944, !DIAssignID !1221
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1210, !DIExpression(), !1221, ptr %endptr, !DIExpression(), !1214)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1219
    #dbg_value(i64 %call3, !1212, !DIExpression(), !1214)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1222, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1222, !tbaa !619
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1222
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1219

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1219

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1224, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1224
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1224
  br label %if.end8, !dbg !1224

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1219
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1219, !tbaa !1109
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1219
    #dbg_value(i64 %indvars.iv.next, !1211, !DIExpression(), !1214)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1219
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1219
  store i8 10, ptr %arrayidx10, align 1, !dbg !1219, !tbaa !619
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1219
    #dbg_value(ptr %call11, !1209, !DIExpression(), !1214)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1215
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1215
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1215
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1215, !llvm.loop !1226

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1215

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1215

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1215

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1215

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1227
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1227
  store i8 10, ptr %arrayidx16, align 1, !dbg !1227, !tbaa !619
  br label %if.end17, !dbg !1227

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1215
  ret i32 0, !dbg !1215
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1230 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1242
    #dbg_assign(i1 undef, !1239, !DIExpression(), !1242, ptr %endptr, !DIExpression(), !1243)
    #dbg_value(ptr %s, !1235, !DIExpression(), !1243)
    #dbg_value(ptr %arr, !1236, !DIExpression(), !1243)
    #dbg_value(i32 %n, !1237, !DIExpression(), !1243)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1244
    #dbg_value(i32 0, !1240, !DIExpression(), !1243)
  %cmp.not = icmp eq ptr %s, null, !dbg !1245
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1245

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #19, !dbg !1245
  unreachable, !dbg !1245

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1244
    #dbg_value(ptr %call, !1238, !DIExpression(), !1243)
    #dbg_value(i32 0, !1240, !DIExpression(), !1243)
  %cmp129 = icmp ne ptr %call, null, !dbg !1244
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1244
  %0 = and i1 %cmp230, %cmp129, !dbg !1244
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1244

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1244

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1244
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1244

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1238, !DIExpression(), !1243)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1240, !DIExpression(), !1243)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1248, !tbaa !944, !DIAssignID !1250
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1239, !DIExpression(), !1250, ptr %endptr, !DIExpression(), !1243)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1248
    #dbg_value(float %call3, !1241, !DIExpression(), !1243)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1251, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1251, !tbaa !619
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1251
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1248

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1248

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1253, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1253
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1253
  br label %if.end8, !dbg !1253

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1248
  store float %call3, ptr %arrayidx, align 4, !dbg !1248, !tbaa !1255
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1248
    #dbg_value(i64 %indvars.iv.next, !1240, !DIExpression(), !1243)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1248
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1248
  store i8 10, ptr %arrayidx10, align 1, !dbg !1248, !tbaa !619
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1248
    #dbg_value(ptr %call11, !1238, !DIExpression(), !1243)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1244
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1244
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1244
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1244, !llvm.loop !1257

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1244

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1244

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1244

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1244

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1258
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1258
  store i8 10, ptr %arrayidx16, align 1, !dbg !1258, !tbaa !619
  br label %if.end17, !dbg !1258

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1244
  ret i32 0, !dbg !1244
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1261 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1264 {
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
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1282, !tbaa !944, !DIAssignID !1284
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1273, !DIExpression(), !1284, ptr %endptr, !DIExpression(), !1277)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1282
    #dbg_value(double %call3, !1275, !DIExpression(), !1277)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1285, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1285, !tbaa !619
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1285
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1282

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1282

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1287, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1287
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1287
  br label %if.end8, !dbg !1287

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1282
  store double %call3, ptr %arrayidx, align 8, !dbg !1282, !tbaa !1289
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1282
    #dbg_value(i64 %indvars.iv.next, !1274, !DIExpression(), !1277)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1282
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1282
  store i8 10, ptr %arrayidx10, align 1, !dbg !1282, !tbaa !619
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1282
    #dbg_value(ptr %call11, !1272, !DIExpression(), !1277)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1278
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1278
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1278
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1278, !llvm.loop !1291

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
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1292
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1292
  store i8 10, ptr %arrayidx16, align 1, !dbg !1292, !tbaa !619
  br label %if.end17, !dbg !1292

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1278
  ret i32 0, !dbg !1278
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1295 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1298 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1302, !DIExpression(), !1307)
    #dbg_value(ptr %arr, !1303, !DIExpression(), !1307)
    #dbg_value(i32 %n, !1304, !DIExpression(), !1307)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1308
  br i1 %cmp, label %if.end, label %if.else, !dbg !1308

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1308
  unreachable, !dbg !1308

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1311
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1313

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1313

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #22, !dbg !1314
  %conv = trunc i64 %call to i32, !dbg !1314
    #dbg_value(i32 %conv, !1304, !DIExpression(), !1307)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1316

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1304, !DIExpression(), !1307)
    #dbg_value(i32 0, !1306, !DIExpression(), !1307)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1317
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1318

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1318

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1318

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1319

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1320
    #dbg_value(i32 %add, !1306, !DIExpression(), !1307)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1317
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1318, !llvm.loop !1322

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1318

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1318

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1306, !DIExpression(), !1307)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1324
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1324
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1325
  %conv6 = sext i32 %sub to i64, !dbg !1326
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #18, !dbg !1327
  %conv8 = trunc i64 %call7 to i32, !dbg !1327
    #dbg_value(i32 %conv8, !1305, !DIExpression(), !1307)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1328
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1306, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1307)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1328

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1328
  unreachable, !dbg !1328

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #18, !dbg !1331
  %conv16 = trunc i64 %call15 to i32, !dbg !1331
    #dbg_value(i32 %conv16, !1305, !DIExpression(), !1307)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1333
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1333

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1333
  unreachable, !dbg !1333

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1336
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1337, !llvm.loop !1338

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1337

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1340
}

; Function Attrs: nofree
declare !dbg !1341 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #10

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1346 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1350, !DIExpression(), !1354)
    #dbg_value(ptr %arr, !1351, !DIExpression(), !1354)
    #dbg_value(i32 %n, !1352, !DIExpression(), !1354)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1355
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1355

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1353, !DIExpression(), !1354)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1358
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1361

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1361

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1358
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1361

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #19, !dbg !1355
  unreachable, !dbg !1355

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1353, !DIExpression(), !1354)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1362
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1362, !tbaa !619
  %conv = zext i8 %0 to i32, !dbg !1362
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1362
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1358
    #dbg_value(i64 %indvars.iv.next, !1353, !DIExpression(), !1354)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1358
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1361, !llvm.loop !1364

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1361

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1361

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1365
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #15 !dbg !1366 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1383
    #dbg_assign(i1 undef, !1372, !DIExpression(), !1383, ptr %args, !DIExpression(), !1384)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1385
    #dbg_assign(i1 undef, !1379, !DIExpression(), !1385, ptr %buffer, !DIExpression(), !1384)
    #dbg_value(i32 %fd, !1370, !DIExpression(), !1384)
    #dbg_value(ptr %format, !1371, !DIExpression(), !1384)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #18, !dbg !1386
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1387
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1388
  %0 = load ptr, ptr %args, align 8, !dbg !1389, !tbaa !944
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #18, !dbg !1390
    #dbg_value(i32 %call, !1376, !DIExpression(), !1384)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1391
  %cmp = icmp slt i32 %call, 256, !dbg !1392
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1392

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1377, !DIExpression(), !1384)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1395
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1396

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1396

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1396

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1392
  unreachable, !dbg !1392

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1397
    #dbg_value(i32 %add, !1377, !DIExpression(), !1384)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1395
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1396, !llvm.loop !1399

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1396

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1396

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1377, !DIExpression(), !1384)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1401
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1401
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1402
  %conv = sext i32 %sub to i64, !dbg !1403
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #18, !dbg !1404
  %conv3 = trunc i64 %call2 to i32, !dbg !1404
    #dbg_value(i32 %conv3, !1378, !DIExpression(), !1384)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1405
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1377, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1384)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1405

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1405
  unreachable, !dbg !1405

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1408
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1408

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1408
  unreachable, !dbg !1408

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1411
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #18, !dbg !1411
  ret void, !dbg !1412
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #16

; Function Attrs: nofree nounwind
declare !dbg !1413 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #8

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #16

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1418 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1422, !DIExpression(), !1426)
    #dbg_value(ptr %arr, !1423, !DIExpression(), !1426)
    #dbg_value(i32 %n, !1424, !DIExpression(), !1426)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1427
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1427

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1425, !DIExpression(), !1426)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1430
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1433

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1433

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1430
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1433

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #19, !dbg !1427
  unreachable, !dbg !1427

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1425, !DIExpression(), !1426)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1434
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1434, !tbaa !1049
  %conv = zext i16 %0 to i32, !dbg !1434
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1434
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1430
    #dbg_value(i64 %indvars.iv.next, !1425, !DIExpression(), !1426)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1430
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1433, !llvm.loop !1436

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1433

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1433

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1437
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1438 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1442, !DIExpression(), !1446)
    #dbg_value(ptr %arr, !1443, !DIExpression(), !1446)
    #dbg_value(i32 %n, !1444, !DIExpression(), !1446)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1447
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1447

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1445, !DIExpression(), !1446)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1450
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1453

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1453

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1450
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1453

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #19, !dbg !1447
  unreachable, !dbg !1447

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1445, !DIExpression(), !1446)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1454
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1454, !tbaa !361
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1454
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1450
    #dbg_value(i64 %indvars.iv.next, !1445, !DIExpression(), !1446)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1450
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1453, !llvm.loop !1456

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1453

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1453

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1457
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1458 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1462, !DIExpression(), !1466)
    #dbg_value(ptr %arr, !1463, !DIExpression(), !1466)
    #dbg_value(i32 %n, !1464, !DIExpression(), !1466)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1467
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1467

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1465, !DIExpression(), !1466)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1470
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1473

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1473

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1470
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1473

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #19, !dbg !1467
  unreachable, !dbg !1467

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1465, !DIExpression(), !1466)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1474
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1474, !tbaa !1109
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1474
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1470
    #dbg_value(i64 %indvars.iv.next, !1465, !DIExpression(), !1466)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1470
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1473, !llvm.loop !1476

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1473

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1473

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1477
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1478 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1482, !DIExpression(), !1486)
    #dbg_value(ptr %arr, !1483, !DIExpression(), !1486)
    #dbg_value(i32 %n, !1484, !DIExpression(), !1486)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1487
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1487

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1485, !DIExpression(), !1486)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1490
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1493

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1493

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1490
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1493

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #19, !dbg !1487
  unreachable, !dbg !1487

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1485, !DIExpression(), !1486)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1494
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1494, !tbaa !619
  %conv = sext i8 %0 to i32, !dbg !1494
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1494
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1490
    #dbg_value(i64 %indvars.iv.next, !1485, !DIExpression(), !1486)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1490
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1493, !llvm.loop !1496

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1493

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1493

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1497
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1498 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1502, !DIExpression(), !1506)
    #dbg_value(ptr %arr, !1503, !DIExpression(), !1506)
    #dbg_value(i32 %n, !1504, !DIExpression(), !1506)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1507
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1507

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1505, !DIExpression(), !1506)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1510
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1513

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1513

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1510
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1513

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #19, !dbg !1507
  unreachable, !dbg !1507

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1505, !DIExpression(), !1506)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1514
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1514, !tbaa !1049
  %conv = sext i16 %0 to i32, !dbg !1514
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1514
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1510
    #dbg_value(i64 %indvars.iv.next, !1505, !DIExpression(), !1506)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1510
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1513, !llvm.loop !1516

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1513

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1513

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1517
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !661 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !660, !DIExpression(), !1518)
    #dbg_value(ptr %arr, !666, !DIExpression(), !1518)
    #dbg_value(i32 %n, !667, !DIExpression(), !1518)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1519
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1519

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !668, !DIExpression(), !1518)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1522
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1523

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1523

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1522
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1523

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #19, !dbg !1519
  unreachable, !dbg !1519

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !668, !DIExpression(), !1518)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1524
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1524, !tbaa !361
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1524
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1522
    #dbg_value(i64 %indvars.iv.next, !668, !DIExpression(), !1518)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1522
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1523, !llvm.loop !1525

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1523

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1523

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1526
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1527 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1531, !DIExpression(), !1535)
    #dbg_value(ptr %arr, !1532, !DIExpression(), !1535)
    #dbg_value(i32 %n, !1533, !DIExpression(), !1535)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1536
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1536

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1534, !DIExpression(), !1535)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1539
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1542

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1542

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1539
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1542

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #19, !dbg !1536
  unreachable, !dbg !1536

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1534, !DIExpression(), !1535)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1543
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1543, !tbaa !1109
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1543
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1539
    #dbg_value(i64 %indvars.iv.next, !1534, !DIExpression(), !1535)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1539
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1542, !llvm.loop !1545

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1542

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1542

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1546
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1547 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1551, !DIExpression(), !1555)
    #dbg_value(ptr %arr, !1552, !DIExpression(), !1555)
    #dbg_value(i32 %n, !1553, !DIExpression(), !1555)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1556
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1556

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1554, !DIExpression(), !1555)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1559
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1562

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1562

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1559
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1562

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #19, !dbg !1556
  unreachable, !dbg !1556

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1554, !DIExpression(), !1555)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1563
  %0 = load float, ptr %arrayidx, align 4, !dbg !1563, !tbaa !1255
  %conv = fpext float %0 to double, !dbg !1563
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1563
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1559
    #dbg_value(i64 %indvars.iv.next, !1554, !DIExpression(), !1555)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1559
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1562, !llvm.loop !1565

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1562

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1562

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1566
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1567 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1571, !DIExpression(), !1575)
    #dbg_value(ptr %arr, !1572, !DIExpression(), !1575)
    #dbg_value(i32 %n, !1573, !DIExpression(), !1575)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1576
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1576

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1574, !DIExpression(), !1575)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1579
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1582

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1582

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1579
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1582

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #19, !dbg !1576
  unreachable, !dbg !1576

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1574, !DIExpression(), !1575)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1583
  %0 = load double, ptr %arrayidx, align 8, !dbg !1583, !tbaa !1289
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1583
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1579
    #dbg_value(i64 %indvars.iv.next, !1574, !DIExpression(), !1575)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1579
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1582, !llvm.loop !1585

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1582

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1582

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1586
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #3 !dbg !650 {
entry.split:
    #dbg_value(i32 %fd, !649, !DIExpression(), !1587)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1588
  br i1 %cmp, label %if.end, label %if.else, !dbg !1588

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1588
  unreachable, !dbg !1588

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1589
  ret i32 0, !dbg !1590
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #3 !dbg !1591 {
entry.split:
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.032.i.reg2mem = alloca i32, align 4
  %data_sum.034.i.reg2mem = alloca i32, align 4
  %ref_sum.035.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %.reg2mem106 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.i15.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i14.reg2mem = alloca i64, align 8
  %i.1.i.i9.reg2mem108 = alloca i32, align 4
  %s.addr.040.i.i4.reg2mem110 = alloca ptr, align 8
  %i.041.i.i3.reg2mem112 = alloca i32, align 4
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem114 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem116 = alloca ptr, align 8
  %i.041.i.i.reg2mem118 = alloca i32, align 4
  %check_file.0.reg2mem120 = alloca ptr, align 8
  %in_file.025.reg2mem122 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1595, !DIExpression(), !1604)
    #dbg_value(ptr %argv, !1596, !DIExpression(), !1604)
  %cmp = icmp slt i32 %argc, 4, !dbg !1605
  br i1 %cmp, label %if.end, label %if.else, !dbg !1605

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1605
  unreachable, !dbg !1605

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1597, !DIExpression(), !1604)
    #dbg_value(ptr @.str.4.13, !1598, !DIExpression(), !1604)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1608
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1610

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.13, ptr %check_file.0.reg2mem120, align 8
  store ptr @.str.3, ptr %in_file.025.reg2mem122, align 8
  br label %if.end7, !dbg !1610

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1611
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1611
    #dbg_value(ptr %0, !1597, !DIExpression(), !1604)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1612
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1614

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.13, ptr %check_file.0.reg2mem120, align 8
  store ptr %0, ptr %in_file.025.reg2mem122, align 8
  br label %if.end7, !dbg !1614

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1615
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1615
    #dbg_value(ptr %1, !1598, !DIExpression(), !1604)
  store ptr %1, ptr %check_file.0.reg2mem120, align 8
  store ptr %0, ptr %in_file.025.reg2mem122, align 8
  br label %if.end7, !dbg !1616

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem120.0.check_file.0.reload121, !1598, !DIExpression(), !1604)
  %in_file.025.reg2mem122.0.in_file.025.reload123 = load ptr, ptr %in_file.025.reg2mem122, align 8
  %check_file.0.reg2mem120.0.check_file.0.reload121 = load ptr, ptr %check_file.0.reg2mem120, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1617, !tbaa !361
  %conv = sext i32 %2 to i64, !dbg !1617
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #20, !dbg !1618
    #dbg_value(ptr %call, !1600, !DIExpression(), !1604)
  %cmp8.not = icmp eq ptr %call, null, !dbg !1619
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1619

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.14, ptr noundef nonnull @.str.2.12, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1619
  unreachable, !dbg !1619

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.025.reg2mem122.0.in_file.025.reload123, i32 noundef signext 0) #18, !dbg !1622
    #dbg_value(i32 %call14, !1599, !DIExpression(), !1604)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1623
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1623

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.15, ptr noundef nonnull @.str.2.12, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1623
  unreachable, !dbg !1623

if.end20:                                         ; preds = %if.end13
    #dbg_value(i32 %call14, !601, !DIExpression(), !1626)
    #dbg_value(ptr %call, !602, !DIExpression(), !1626)
    #dbg_value(ptr %call, !603, !DIExpression(), !1626)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(25088) %call, i8 0, i64 25088, i1 false), !dbg !1628
  %call.i = tail call ptr @readfile(i32 noundef signext %call14) #18, !dbg !1629
    #dbg_value(ptr %call.i, !604, !DIExpression(), !1626)
    #dbg_value(ptr %call.i, !609, !DIExpression(), !1630)
    #dbg_value(i32 1, !614, !DIExpression(), !1630)
    #dbg_value(i32 0, !615, !DIExpression(), !1630)
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem116, align 8
  store i32 0, ptr %i.041.i.i.reg2mem118, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end20
    #dbg_value(i32 %i.041.i.i.reg2mem118.0.load, !615, !DIExpression(), !1630)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem116.0.s.addr.040.i.i.reload117, !609, !DIExpression(), !1630)
  %i.041.i.i.reg2mem118.0.load = load i32, ptr %i.041.i.i.reg2mem118, align 4
  %s.addr.040.i.i.reg2mem116.0.s.addr.040.i.i.reload117 = load ptr, ptr %s.addr.040.i.i.reg2mem116, align 8
  %3 = load i8, ptr %s.addr.040.i.i.reg2mem116.0.s.addr.040.i.i.reload117, align 1, !dbg !1632, !tbaa !619
  switch i8 %3, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.input_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1633

land.rhs.i.i.input_to_data.exit_crit_edge:        ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem116.0.s.addr.040.i.i.reload117, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %input_to_data.exit, !dbg !1633

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem118.0.load, ptr %i.1.i.i.reg2mem114, align 4
  br label %if.end21.i.i, !dbg !1633

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem116.0.s.addr.040.i.i.reload117, i64 1, !dbg !1634
  %4 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !1634, !tbaa !619
  %cmp13.i.i = icmp eq i8 %4, 37, !dbg !1635
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1636

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem118.0.load, ptr %i.1.i.i.reg2mem114, align 4
  br label %if.end21.i.i, !dbg !1636

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem116.0.s.addr.040.i.i.reload117, i64 2, !dbg !1637
  %5 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1637, !tbaa !619
  %cmp18.i.i = icmp eq i8 %5, 10, !dbg !1638
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1639
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem118.0.load, %inc.i.i, !dbg !1639
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem114, align 4
  br label %if.end21.i.i, !dbg !1639

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem114.0.load, !615, !DIExpression(), !1630)
  %i.1.i.i.reg2mem114.0.load = load i32, ptr %i.1.i.i.reg2mem114, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem116.0.s.addr.040.i.i.reload117, i64 1, !dbg !1640
    #dbg_value(ptr %incdec.ptr.i.i, !609, !DIExpression(), !1630)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem114.0.load, 1, !dbg !1641
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1642, !llvm.loop !1643

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem116, align 8
  store i32 %i.1.i.i.reg2mem114.0.load, ptr %i.041.i.i.reg2mem118, align 4
  br label %land.rhs.i.i, !dbg !1642

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1645, !tbaa !619
  %6 = icmp eq i8 %.pre.i.i, 0, !dbg !1646
  %7 = select i1 %6, i64 0, i64 2, !dbg !1647
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %7, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %input_to_data.exit, !dbg !1642

input_to_data.exit:                               ; preds = %land.rhs.i.i.input_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1647
    #dbg_value(ptr %spec.select38.i.i, !605, !DIExpression(), !1626)
  %call2.i = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i.i, ptr noundef nonnull %call, i32 noundef signext 2048) #18, !dbg !1648
  tail call void @free(ptr noundef %call.i) #18, !dbg !1649
    #dbg_value(ptr %call, !589, !DIExpression(), !1650)
    #dbg_value(ptr %call, !590, !DIExpression(), !1650)
  %b.i = getelementptr inbounds i8, ptr %call, i64 8192, !dbg !1652
  %bucket.i = getelementptr inbounds i8, ptr %call, i64 16384, !dbg !1653
  %sum.i = getelementptr inbounds i8, ptr %call, i64 24576, !dbg !1654
  tail call void @sort(ptr noundef nonnull %call, ptr noundef nonnull %b.i, ptr noundef nonnull %bucket.i, ptr noundef nonnull %sum.i) #18, !dbg !1655
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #18, !dbg !1656
    #dbg_value(i32 %call21, !1601, !DIExpression(), !1604)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1657
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1657

if.else26:                                        ; preds = %input_to_data.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1657
  unreachable, !dbg !1657

if.end27:                                         ; preds = %input_to_data.exit
    #dbg_value(i32 %call21, !712, !DIExpression(), !1660)
    #dbg_value(ptr %call, !713, !DIExpression(), !1660)
    #dbg_value(ptr %call, !714, !DIExpression(), !1660)
    #dbg_value(i32 %call21, !649, !DIExpression(), !1662)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1664
  br i1 %cmp.i.i.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1664

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1664
  unreachable, !dbg !1664

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1665
    #dbg_value(i32 %call21, !660, !DIExpression(), !1666)
    #dbg_value(ptr %call, !666, !DIExpression(), !1666)
    #dbg_value(i32 2048, !667, !DIExpression(), !1666)
    #dbg_value(i32 0, !668, !DIExpression(), !1666)
  store i64 0, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1668

for.body.i.i:                                     ; preds = %for.body.i.i.for.body.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !668, !DIExpression(), !1666)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %arrayidx.i.i = getelementptr inbounds i32, ptr %call, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !1669
  %8 = load i32, ptr %arrayidx.i.i, align 4, !dbg !1669, !tbaa !361
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.19, i32 noundef signext %8), !dbg !1669
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !1670
    #dbg_value(i64 %indvars.iv.next.i.i, !668, !DIExpression(), !1666)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 2048, !dbg !1670
  br i1 %exitcond.not.i.i, label %data_to_output.exit, label %for.body.i.i.for.body.i.i_crit_edge, !dbg !1668, !llvm.loop !1671

for.body.i.i.for.body.i.i_crit_edge:              ; preds = %for.body.i.i
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1668

data_to_output.exit:                              ; preds = %for.body.i.i
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #18, !dbg !1672
  %9 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1673, !tbaa !361
  %conv29 = sext i32 %9 to i64, !dbg !1673
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #20, !dbg !1674
    #dbg_value(ptr %call30, !1603, !DIExpression(), !1604)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1675
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1675

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.16, ptr noundef nonnull @.str.2.12, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1675
  unreachable, !dbg !1675

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem120.0.check_file.0.reload121, i32 noundef signext 0) #18, !dbg !1678
    #dbg_value(i32 %call37, !1602, !DIExpression(), !1604)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1679
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1679

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.17, ptr noundef nonnull @.str.2.12, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1679
  unreachable, !dbg !1679

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !681, !DIExpression(), !1682)
    #dbg_value(ptr %call30, !682, !DIExpression(), !1682)
    #dbg_value(ptr %call30, !683, !DIExpression(), !1682)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(25088) %call30, i8 0, i64 25088, i1 false), !dbg !1684
  %call.i1 = tail call ptr @readfile(i32 noundef signext %call37) #18, !dbg !1685
    #dbg_value(ptr %call.i1, !684, !DIExpression(), !1682)
    #dbg_value(ptr %call.i1, !609, !DIExpression(), !1686)
    #dbg_value(i32 1, !614, !DIExpression(), !1686)
    #dbg_value(i32 0, !615, !DIExpression(), !1686)
  store ptr %call.i1, ptr %s.addr.040.i.i4.reg2mem110, align 8
  store i32 0, ptr %i.041.i.i3.reg2mem112, align 4
  br label %land.rhs.i.i2

land.rhs.i.i2:                                    ; preds = %if.end21.i.i8.land.rhs.i.i2_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i3.reg2mem112.0.load, !615, !DIExpression(), !1686)
    #dbg_value(ptr %s.addr.040.i.i4.reg2mem110.0.s.addr.040.i.i4.reload111, !609, !DIExpression(), !1686)
  %i.041.i.i3.reg2mem112.0.load = load i32, ptr %i.041.i.i3.reg2mem112, align 4
  %s.addr.040.i.i4.reg2mem110.0.s.addr.040.i.i4.reload111 = load ptr, ptr %s.addr.040.i.i4.reg2mem110, align 8
  %10 = load i8, ptr %s.addr.040.i.i4.reg2mem110.0.s.addr.040.i.i4.reload111, align 1, !dbg !1688, !tbaa !619
  switch i8 %10, label %land.rhs.i.i2.if.end21.i.i8_crit_edge [
    i8 0, label %land.rhs.i.i2.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i5
  ], !dbg !1689

land.rhs.i.i2.output_to_data.exit_crit_edge:      ; preds = %land.rhs.i.i2
  store ptr %s.addr.040.i.i4.reg2mem110.0.s.addr.040.i.i4.reload111, ptr %s.addr.0.lcssa.ph.i.i15.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i14.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1689

land.rhs.i.i2.if.end21.i.i8_crit_edge:            ; preds = %land.rhs.i.i2
  store i32 %i.041.i.i3.reg2mem112.0.load, ptr %i.1.i.i9.reg2mem108, align 4
  br label %if.end21.i.i8, !dbg !1689

land.lhs.true10.i.i5:                             ; preds = %land.rhs.i.i2
  %arrayidx11.i.i6 = getelementptr inbounds i8, ptr %s.addr.040.i.i4.reg2mem110.0.s.addr.040.i.i4.reload111, i64 1, !dbg !1690
  %11 = load i8, ptr %arrayidx11.i.i6, align 1, !dbg !1690, !tbaa !619
  %cmp13.i.i7 = icmp eq i8 %11, 37, !dbg !1691
  br i1 %cmp13.i.i7, label %land.lhs.true15.i.i18, label %land.lhs.true10.i.i5.if.end21.i.i8_crit_edge, !dbg !1692

land.lhs.true10.i.i5.if.end21.i.i8_crit_edge:     ; preds = %land.lhs.true10.i.i5
  store i32 %i.041.i.i3.reg2mem112.0.load, ptr %i.1.i.i9.reg2mem108, align 4
  br label %if.end21.i.i8, !dbg !1692

land.lhs.true15.i.i18:                            ; preds = %land.lhs.true10.i.i5
  %arrayidx16.i.i19 = getelementptr inbounds i8, ptr %s.addr.040.i.i4.reg2mem110.0.s.addr.040.i.i4.reload111, i64 2, !dbg !1693
  %12 = load i8, ptr %arrayidx16.i.i19, align 1, !dbg !1693, !tbaa !619
  %cmp18.i.i20 = icmp eq i8 %12, 10, !dbg !1694
  %inc.i.i21 = zext i1 %cmp18.i.i20 to i32, !dbg !1695
  %spec.select.i.i22 = add nsw i32 %i.041.i.i3.reg2mem112.0.load, %inc.i.i21, !dbg !1695
  store i32 %spec.select.i.i22, ptr %i.1.i.i9.reg2mem108, align 4
  br label %if.end21.i.i8, !dbg !1695

if.end21.i.i8:                                    ; preds = %land.lhs.true10.i.i5.if.end21.i.i8_crit_edge, %land.rhs.i.i2.if.end21.i.i8_crit_edge, %land.lhs.true15.i.i18
    #dbg_value(i32 %i.1.i.i9.reg2mem108.0.load, !615, !DIExpression(), !1686)
  %i.1.i.i9.reg2mem108.0.load = load i32, ptr %i.1.i.i9.reg2mem108, align 4
  %incdec.ptr.i.i10 = getelementptr inbounds i8, ptr %s.addr.040.i.i4.reg2mem110.0.s.addr.040.i.i4.reload111, i64 1, !dbg !1696
    #dbg_value(ptr %incdec.ptr.i.i10, !609, !DIExpression(), !1686)
  %cmp4.i.i11 = icmp slt i32 %i.1.i.i9.reg2mem108.0.load, 1, !dbg !1697
  br i1 %cmp4.i.i11, label %if.end21.i.i8.land.rhs.i.i2_crit_edge, label %if.end21.while.end_crit_edge.i.i12, !dbg !1698, !llvm.loop !1699

if.end21.i.i8.land.rhs.i.i2_crit_edge:            ; preds = %if.end21.i.i8
  store ptr %incdec.ptr.i.i10, ptr %s.addr.040.i.i4.reg2mem110, align 8
  store i32 %i.1.i.i9.reg2mem108.0.load, ptr %i.041.i.i3.reg2mem112, align 4
  br label %land.rhs.i.i2, !dbg !1698

if.end21.while.end_crit_edge.i.i12:               ; preds = %if.end21.i.i8
  %.pre.i.i13 = load i8, ptr %incdec.ptr.i.i10, align 1, !dbg !1701, !tbaa !619
  %13 = icmp eq i8 %.pre.i.i13, 0, !dbg !1702
  %14 = select i1 %13, i64 0, i64 2, !dbg !1703
  store ptr %incdec.ptr.i.i10, ptr %s.addr.0.lcssa.ph.i.i15.reg2mem, align 8
  store i64 %14, ptr %cmp23.not.i.i14.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1698

output_to_data.exit:                              ; preds = %land.rhs.i.i2.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i12
  %cmp23.not.i.i14.reg2mem.0.load = load i64, ptr %cmp23.not.i.i14.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i15.reg2mem.0.s.addr.0.lcssa.ph.i.i15.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i15.reg2mem, align 8
  %spec.select38.i.i16 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i15.reg2mem.0.s.addr.0.lcssa.ph.i.i15.reload, i64 %cmp23.not.i.i14.reg2mem.0.load, !dbg !1703
    #dbg_value(ptr %spec.select38.i.i16, !685, !DIExpression(), !1682)
  %call2.i17 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i.i16, ptr noundef nonnull %call30, i32 noundef signext 2048) #18, !dbg !1704
  tail call void @free(ptr noundef %call.i1) #18, !dbg !1705
    #dbg_value(ptr %call, !731, !DIExpression(), !1706)
    #dbg_value(ptr %call30, !732, !DIExpression(), !1706)
    #dbg_value(ptr %call, !733, !DIExpression(), !1706)
    #dbg_value(ptr %call30, !734, !DIExpression(), !1706)
    #dbg_value(i32 0, !735, !DIExpression(), !1706)
  %15 = load i32, ptr %call, align 4, !dbg !1709
    #dbg_value(i32 %15, !737, !DIExpression(), !1706)
  %16 = load i32, ptr %call30, align 4, !dbg !1710
    #dbg_value(i32 %16, !738, !DIExpression(), !1706)
    #dbg_value(i32 1, !736, !DIExpression(), !1706)
  store i32 0, ptr %has_errors.032.i.reg2mem, align 4
  store i32 %15, ptr %data_sum.034.i.reg2mem, align 4
  store i32 %16, ptr %ref_sum.035.i.reg2mem, align 4
  store i64 1, ptr %indvars.iv.i.reg2mem, align 8
  store i32 %15, ptr %.reg2mem106, align 4
  br label %for.body.i, !dbg !1711

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %output_to_data.exit
    #dbg_value(i32 %ref_sum.035.i.reg2mem.0.load, !738, !DIExpression(), !1706)
    #dbg_value(i32 %data_sum.034.i.reg2mem.0.load, !737, !DIExpression(), !1706)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !736, !DIExpression(), !1706)
    #dbg_value(i32 %has_errors.032.i.reg2mem.0.load, !735, !DIExpression(), !1706)
  %.reg2mem106.0.load = load i32, ptr %.reg2mem106, align 4
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %ref_sum.035.i.reg2mem.0.load = load i32, ptr %ref_sum.035.i.reg2mem, align 4
  %data_sum.034.i.reg2mem.0.load = load i32, ptr %data_sum.034.i.reg2mem, align 4
  %has_errors.032.i.reg2mem.0.load = load i32, ptr %has_errors.032.i.reg2mem, align 4
  %arrayidx7.i = getelementptr inbounds [2048 x i32], ptr %call, i64 0, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1712
  %17 = load i32, ptr %arrayidx7.i, align 4, !dbg !1712
  %cmp8.i = icmp sgt i32 %.reg2mem106.0.load, %17, !dbg !1713
  %conv.i = zext i1 %cmp8.i to i32, !dbg !1713
  %or.i = or i32 %has_errors.032.i.reg2mem.0.load, %conv.i, !dbg !1714
    #dbg_value(i32 %or.i, !735, !DIExpression(), !1706)
  %add.i = add nsw i32 %17, %data_sum.034.i.reg2mem.0.load, !dbg !1715
    #dbg_value(i32 %add.i, !737, !DIExpression(), !1706)
  %arrayidx14.i = getelementptr inbounds [2048 x i32], ptr %call30, i64 0, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1716
  %18 = load i32, ptr %arrayidx14.i, align 4, !dbg !1716, !tbaa !361
  %add15.i = add nsw i32 %18, %ref_sum.035.i.reg2mem.0.load, !dbg !1717
    #dbg_value(i32 %add15.i, !738, !DIExpression(), !1706)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1718
    #dbg_value(i64 %indvars.iv.next.i, !736, !DIExpression(), !1706)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 2048, !dbg !1719
  br i1 %exitcond.not.i, label %check_data.exit, label %for.body.i.for.body.i_crit_edge, !dbg !1711, !llvm.loop !1720

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i32 %or.i, ptr %has_errors.032.i.reg2mem, align 4
  store i32 %add.i, ptr %data_sum.034.i.reg2mem, align 4
  store i32 %add15.i, ptr %ref_sum.035.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  store i32 %17, ptr %.reg2mem106, align 4
  br label %for.body.i, !dbg !1711

check_data.exit:                                  ; preds = %for.body.i
  %cmp16.i = icmp ne i32 %add.i, %add15.i, !dbg !1722
  %conv17.i = zext i1 %cmp16.i to i32, !dbg !1722
  %or18.i = or i32 %or.i, %conv17.i, !dbg !1723
    #dbg_value(i32 %or18.i, !735, !DIExpression(), !1706)
  %tobool.not.i.not = icmp eq i32 %or18.i, 0, !dbg !1724
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1725

if.then45:                                        ; preds = %check_data.exit
  %19 = load ptr, ptr @stderr, align 8, !dbg !1726, !tbaa !944
  %20 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %19) #21, !dbg !1728
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1729

if.end47:                                         ; preds = %check_data.exit
  tail call void @free(ptr noundef nonnull %call) #18, !dbg !1730
  tail call void @free(ptr noundef nonnull %call30) #18, !dbg !1731
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1732
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1733

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1734
}

; Function Attrs: nofree
declare !dbg !1735 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #10

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #17

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #17

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "polly-optimized" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #2 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #3 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
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

!llvm.dbg.cu = !{!228, !188, !230, !296}
!llvm.ident = !{!317, !317, !317, !317}
!llvm.module.flags = !{!318, !319, !320, !321, !322, !324, !325, !326, !327, !328}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/sort/radix")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/sort/radix")
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
!187 = distinct !DIGlobalVariable(name: "INPUT_SIZE", scope: !188, file: !189, line: 4, type: !197, isLocal: false, isDefinition: true)
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !206, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/sort/radix")
!190 = !{!191}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 32, size: 200704, elements: !194)
!193 = !DIFile(filename: "./sort.h", directory: "/home/kelvin/MachSuite/sort/radix")
!194 = !{!195, !200, !201, !202}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !192, file: !193, line: 33, baseType: !196, size: 65536)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 65536, elements: !198)
!197 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!198 = !{!199}
!199 = !DISubrange(count: 2048)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !192, file: !193, line: 34, baseType: !196, size: 65536, offset: 65536)
!201 = !DIDerivedType(tag: DW_TAG_member, name: "bucket", scope: !192, file: !193, line: 35, baseType: !196, size: 65536, offset: 131072)
!202 = !DIDerivedType(tag: DW_TAG_member, name: "sum", scope: !192, file: !193, line: 36, baseType: !203, size: 4096, offset: 196608)
!203 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 4096, elements: !204)
!204 = !{!205}
!205 = !DISubrange(count: 128)
!206 = !{!186}
!207 = !DIGlobalVariableExpression(var: !208, expr: !DIExpression())
!208 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !209, isLocal: true, isDefinition: true)
!209 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!210 = !DIGlobalVariableExpression(var: !211, expr: !DIExpression())
!211 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !212, isLocal: true, isDefinition: true)
!212 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!213 = !DIGlobalVariableExpression(var: !214, expr: !DIExpression())
!214 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !215, isLocal: true, isDefinition: true)
!215 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !216)
!216 = !{!217}
!217 = !DISubrange(count: 12)
!218 = !DIGlobalVariableExpression(var: !219, expr: !DIExpression())
!219 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !220, isLocal: true, isDefinition: true)
!220 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!221 = !DIGlobalVariableExpression(var: !222, expr: !DIExpression())
!222 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!223 = !DIGlobalVariableExpression(var: !224, expr: !DIExpression())
!224 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !225, isLocal: true, isDefinition: true)
!225 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!226 = !DIGlobalVariableExpression(var: !227, expr: !DIExpression())
!227 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!228 = distinct !DICompileUnit(language: DW_LANG_C11, file: !229, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!229 = !DIFile(filename: "sort.c", directory: "/home/kelvin/MachSuite/sort/radix")
!230 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !231, globals: !262, splitDebugInlining: false, nameTableKind: None)
!231 = !{!232, !4, !233, !234, !239, !242, !245, !248, !252, !255, !257, !260, !261}
!232 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!233 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!234 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !235, line: 24, baseType: !236)
!235 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!236 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !237, line: 38, baseType: !238)
!237 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!238 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!239 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !235, line: 25, baseType: !240)
!240 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !237, line: 40, baseType: !241)
!241 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!242 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !235, line: 26, baseType: !243)
!243 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !237, line: 42, baseType: !244)
!244 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!245 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !235, line: 27, baseType: !246)
!246 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !237, line: 45, baseType: !247)
!247 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!248 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !249, line: 24, baseType: !250)
!249 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!250 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !237, line: 37, baseType: !251)
!251 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !249, line: 25, baseType: !253)
!253 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !237, line: 39, baseType: !254)
!254 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!255 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !249, line: 26, baseType: !256)
!256 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !237, line: 41, baseType: !197)
!257 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !249, line: 27, baseType: !258)
!258 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !237, line: 44, baseType: !259)
!259 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!260 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!261 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!262 = !{!263, !0, !7, !12, !268, !18, !270, !23, !275, !28, !277, !33, !38, !279, !43, !45, !47, !52, !57, !62, !67, !69, !71, !76, !78, !80, !82, !87, !89, !284, !92, !97, !102, !107, !112, !114, !116, !121, !126, !128, !130, !132, !134, !136, !141, !146, !148, !153, !289, !158, !163, !291, !165}
!263 = !DIGlobalVariableExpression(var: !264, expr: !DIExpression())
!264 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !265, isLocal: true, isDefinition: true)
!265 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !266)
!266 = !{!267}
!267 = !DISubrange(count: 24)
!268 = !DIGlobalVariableExpression(var: !269, expr: !DIExpression())
!269 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !30, isLocal: true, isDefinition: true)
!270 = !DIGlobalVariableExpression(var: !271, expr: !DIExpression())
!271 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !272, isLocal: true, isDefinition: true)
!272 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !273)
!273 = !{!274}
!274 = !DISubrange(count: 14)
!275 = !DIGlobalVariableExpression(var: !276, expr: !DIExpression())
!276 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !272, isLocal: true, isDefinition: true)
!277 = !DIGlobalVariableExpression(var: !278, expr: !DIExpression())
!278 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !9, isLocal: true, isDefinition: true)
!279 = !DIGlobalVariableExpression(var: !280, expr: !DIExpression())
!280 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !281, isLocal: true, isDefinition: true)
!281 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !282)
!282 = !{!283}
!283 = !DISubrange(count: 21)
!284 = !DIGlobalVariableExpression(var: !285, expr: !DIExpression())
!285 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !286, isLocal: true, isDefinition: true)
!286 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !287)
!287 = !{!288}
!288 = !DISubrange(count: 13)
!289 = !DIGlobalVariableExpression(var: !290, expr: !DIExpression())
!290 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !20, isLocal: true, isDefinition: true)
!291 = !DIGlobalVariableExpression(var: !292, expr: !DIExpression())
!292 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !293, isLocal: true, isDefinition: true)
!293 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !294)
!294 = !{!295}
!295 = !DISubrange(count: 27)
!296 = distinct !DICompileUnit(language: DW_LANG_C11, file: !170, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !297, globals: !298, splitDebugInlining: false, nameTableKind: None)
!297 = !{!233}
!298 = !{!299, !168, !174, !176, !179, !184, !301, !207, !303, !210, !213, !305, !218, !221, !310, !223, !226, !312}
!299 = !DIGlobalVariableExpression(var: !300, expr: !DIExpression())
!300 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !220, isLocal: true, isDefinition: true)
!301 = !DIGlobalVariableExpression(var: !302, expr: !DIExpression())
!302 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !272, isLocal: true, isDefinition: true)
!303 = !DIGlobalVariableExpression(var: !304, expr: !DIExpression())
!304 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !209, isLocal: true, isDefinition: true)
!305 = !DIGlobalVariableExpression(var: !306, expr: !DIExpression())
!306 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !307, isLocal: true, isDefinition: true)
!307 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !308)
!308 = !{!309}
!309 = !DISubrange(count: 31)
!310 = !DIGlobalVariableExpression(var: !311, expr: !DIExpression())
!311 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !209, isLocal: true, isDefinition: true)
!312 = !DIGlobalVariableExpression(var: !313, expr: !DIExpression())
!313 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !314, isLocal: true, isDefinition: true)
!314 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !315)
!315 = !{!316}
!316 = !DISubrange(count: 10)
!317 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!318 = !{i32 7, !"Dwarf Version", i32 4}
!319 = !{i32 2, !"Debug Info Version", i32 3}
!320 = !{i32 1, !"wchar_size", i32 4}
!321 = !{i32 1, !"target-abi", !"lp64d"}
!322 = distinct !{i32 6, !"riscv-isa", !323}
!323 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!324 = !{i32 8, !"PIC Level", i32 2}
!325 = !{i32 7, !"PIE Level", i32 2}
!326 = !{i32 7, !"uwtable", i32 2}
!327 = !{i32 8, !"SmallDataLimit", i32 8}
!328 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!329 = distinct !DISubprogram(name: "sort", scope: !229, file: !229, line: 78, type: !330, scopeLine: 78, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !333)
!330 = !DISubroutineType(types: !331)
!331 = !{null, !332, !332, !332, !332}
!332 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!333 = !{!334, !335, !336, !337, !338, !339, !340}
!334 = !DILocalVariable(name: "a", arg: 1, scope: !329, file: !229, line: 78, type: !332)
!335 = !DILocalVariable(name: "b", arg: 2, scope: !329, file: !229, line: 78, type: !332)
!336 = !DILocalVariable(name: "bucket", arg: 3, scope: !329, file: !229, line: 78, type: !332)
!337 = !DILocalVariable(name: "sum", arg: 4, scope: !329, file: !229, line: 78, type: !332)
!338 = !DILocalVariable(name: "exp", scope: !329, file: !229, line: 79, type: !197)
!339 = !DILocalVariable(name: "valid_buffer", scope: !329, file: !229, line: 80, type: !197)
!340 = !DILabel(scope: !329, name: "sort_1", file: !229, line: 84)
!341 = !DILocation(line: 0, scope: !329)
!342 = !DILocation(line: 84, column: 5, scope: !329)
!343 = !DILocation(line: 84, column: 14, scope: !344)
!344 = distinct !DILexicalBlock(scope: !329, file: !229, line: 84, column: 14)
!345 = !DILocalVariable(name: "bucket", arg: 1, scope: !346, file: !229, line: 42, type: !332)
!346 = distinct !DISubprogram(name: "init", scope: !229, file: !229, line: 42, type: !347, scopeLine: 43, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !349)
!347 = !DISubroutineType(types: !348)
!348 = !{null, !332}
!349 = !{!345, !350, !351}
!350 = !DILocalVariable(name: "i", scope: !346, file: !229, line: 44, type: !197)
!351 = !DILabel(scope: !346, name: "init_1", file: !229, line: 45)
!352 = !DILocation(line: 0, scope: !346, inlinedAt: !353)
!353 = distinct !DILocation(line: 85, column: 9, scope: !354)
!354 = distinct !DILexicalBlock(scope: !355, file: !229, line: 84, column: 42)
!355 = distinct !DILexicalBlock(scope: !344, file: !229, line: 84, column: 14)
!356 = !DILocation(line: 45, column: 5, scope: !346, inlinedAt: !353)
!357 = !DILocation(line: 46, column: 19, scope: !358, inlinedAt: !353)
!358 = distinct !DILexicalBlock(scope: !359, file: !229, line: 45, column: 43)
!359 = distinct !DILexicalBlock(scope: !360, file: !229, line: 45, column: 14)
!360 = distinct !DILexicalBlock(scope: !346, file: !229, line: 45, column: 14)
!361 = !{!362, !362, i64 0}
!362 = !{!"int", !363, i64 0}
!363 = !{!"omnipotent char", !364, i64 0}
!364 = !{!"Simple C/C++ TBAA"}
!365 = !DILocation(line: 86, column: 26, scope: !366)
!366 = distinct !DILexicalBlock(scope: !354, file: !229, line: 86, column: 13)
!367 = !DILocalVariable(name: "bucket", arg: 1, scope: !368, file: !229, line: 50, type: !332)
!368 = distinct !DISubprogram(name: "hist", scope: !229, file: !229, line: 50, type: !369, scopeLine: 51, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !371)
!369 = !DISubroutineType(types: !370)
!370 = !{null, !332, !332, !197}
!371 = !{!367, !372, !373, !374, !375, !376, !377, !378, !379}
!372 = !DILocalVariable(name: "a", arg: 2, scope: !368, file: !229, line: 50, type: !332)
!373 = !DILocalVariable(name: "exp", arg: 3, scope: !368, file: !229, line: 50, type: !197)
!374 = !DILocalVariable(name: "blockID", scope: !368, file: !229, line: 52, type: !197)
!375 = !DILocalVariable(name: "i", scope: !368, file: !229, line: 52, type: !197)
!376 = !DILocalVariable(name: "bucket_indx", scope: !368, file: !229, line: 52, type: !197)
!377 = !DILocalVariable(name: "a_indx", scope: !368, file: !229, line: 52, type: !197)
!378 = !DILabel(scope: !368, name: "hist_1", file: !229, line: 54)
!379 = !DILabel(scope: !380, name: "hist_2", file: !229, line: 55)
!380 = distinct !DILexicalBlock(scope: !381, file: !229, line: 54, column: 62)
!381 = distinct !DILexicalBlock(scope: !382, file: !229, line: 54, column: 14)
!382 = distinct !DILexicalBlock(scope: !368, file: !229, line: 54, column: 14)
!383 = !DILocation(line: 0, scope: !368, inlinedAt: !384)
!384 = distinct !DILocation(line: 87, column: 13, scope: !385)
!385 = distinct !DILexicalBlock(scope: !366, file: !229, line: 86, column: 39)
!386 = !DILocation(line: 0, scope: !368, inlinedAt: !387)
!387 = distinct !DILocation(line: 89, column: 13, scope: !388)
!388 = distinct !DILexicalBlock(scope: !366, file: !229, line: 88, column: 16)
!389 = !DILocation(line: 86, column: 13, scope: !354)
!390 = !DILocation(line: 55, column: 18, scope: !391, inlinedAt: !384)
!391 = distinct !DILexicalBlock(scope: !380, file: !229, line: 55, column: 18)
!392 = !DILocation(line: 57, column: 29, scope: !393, inlinedAt: !384)
!393 = distinct !DILexicalBlock(scope: !394, file: !229, line: 55, column: 37)
!394 = distinct !DILexicalBlock(scope: !391, file: !229, line: 55, column: 18)
!395 = !DILocation(line: 57, column: 39, scope: !393, inlinedAt: !384)
!396 = !DILocation(line: 57, column: 53, scope: !393, inlinedAt: !384)
!397 = !DILocation(line: 57, column: 66, scope: !393, inlinedAt: !384)
!398 = !DILocation(line: 58, column: 13, scope: !393, inlinedAt: !384)
!399 = !DILocation(line: 58, column: 32, scope: !393, inlinedAt: !384)
!400 = !DILocation(line: 55, column: 33, scope: !394, inlinedAt: !384)
!401 = !DILocation(line: 55, column: 28, scope: !394, inlinedAt: !384)
!402 = distinct !{!402, !390, !403, !404, !405}
!403 = !DILocation(line: 59, column: 9, scope: !391, inlinedAt: !384)
!404 = !{!"llvm.loop.mustprogress"}
!405 = !{!"llvm.loop.unroll.disable"}
!406 = !DILocation(line: 54, column: 58, scope: !381, inlinedAt: !384)
!407 = !DILocation(line: 54, column: 37, scope: !381, inlinedAt: !384)
!408 = !DILocation(line: 54, column: 14, scope: !382, inlinedAt: !384)
!409 = distinct !{!409, !408, !410, !404, !405}
!410 = !DILocation(line: 60, column: 5, scope: !382, inlinedAt: !384)
!411 = !DILocation(line: 55, column: 18, scope: !391, inlinedAt: !387)
!412 = !DILocation(line: 57, column: 29, scope: !393, inlinedAt: !387)
!413 = !DILocation(line: 57, column: 39, scope: !393, inlinedAt: !387)
!414 = !DILocation(line: 57, column: 53, scope: !393, inlinedAt: !387)
!415 = !DILocation(line: 57, column: 66, scope: !393, inlinedAt: !387)
!416 = !DILocation(line: 58, column: 13, scope: !393, inlinedAt: !387)
!417 = !DILocation(line: 58, column: 32, scope: !393, inlinedAt: !387)
!418 = !DILocation(line: 55, column: 33, scope: !394, inlinedAt: !387)
!419 = !DILocation(line: 55, column: 28, scope: !394, inlinedAt: !387)
!420 = distinct !{!420, !411, !421, !404, !405}
!421 = !DILocation(line: 59, column: 9, scope: !391, inlinedAt: !387)
!422 = !DILocation(line: 54, column: 58, scope: !381, inlinedAt: !387)
!423 = !DILocation(line: 54, column: 37, scope: !381, inlinedAt: !387)
!424 = !DILocation(line: 54, column: 14, scope: !382, inlinedAt: !387)
!425 = distinct !{!425, !424, !426, !404, !405}
!426 = !DILocation(line: 60, column: 5, scope: !382, inlinedAt: !387)
!427 = !DILocalVariable(name: "radixID", scope: !428, file: !229, line: 12, type: !197)
!428 = distinct !DISubprogram(name: "local_scan", scope: !229, file: !229, line: 10, type: !347, scopeLine: 11, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !429)
!429 = !{!430, !427, !431, !432, !433, !434}
!430 = !DILocalVariable(name: "bucket", arg: 1, scope: !428, file: !229, line: 10, type: !332)
!431 = !DILocalVariable(name: "i", scope: !428, file: !229, line: 12, type: !197)
!432 = !DILocalVariable(name: "bucket_indx", scope: !428, file: !229, line: 12, type: !197)
!433 = !DILabel(scope: !428, name: "local_1", file: !229, line: 13)
!434 = !DILabel(scope: !435, name: "local_2", file: !229, line: 14)
!435 = distinct !DILexicalBlock(scope: !436, file: !229, line: 13, column: 62)
!436 = distinct !DILexicalBlock(scope: !437, file: !229, line: 13, column: 15)
!437 = distinct !DILexicalBlock(scope: !428, file: !229, line: 13, column: 15)
!438 = !DILocation(line: 0, scope: !428, inlinedAt: !439)
!439 = distinct !DILocation(line: 92, column: 9, scope: !354)
!440 = !DILocation(line: 14, column: 19, scope: !441, inlinedAt: !439)
!441 = distinct !DILexicalBlock(scope: !435, file: !229, line: 14, column: 19)
!442 = !DILocation(line: 16, column: 36, scope: !443, inlinedAt: !439)
!443 = distinct !DILexicalBlock(scope: !444, file: !229, line: 14, column: 47)
!444 = distinct !DILexicalBlock(scope: !441, file: !229, line: 14, column: 19)
!445 = !DILocation(line: 16, column: 33, scope: !443, inlinedAt: !439)
!446 = !DILocation(line: 14, column: 44, scope: !444, inlinedAt: !439)
!447 = !DILocation(line: 14, column: 30, scope: !444, inlinedAt: !439)
!448 = distinct !{!448, !440, !449, !404, !405}
!449 = !DILocation(line: 17, column: 9, scope: !441, inlinedAt: !439)
!450 = !DILocation(line: 13, column: 58, scope: !436, inlinedAt: !439)
!451 = !DILocation(line: 13, column: 38, scope: !436, inlinedAt: !439)
!452 = !DILocation(line: 13, column: 15, scope: !437, inlinedAt: !439)
!453 = distinct !{!453, !452, !454, !404, !405}
!454 = !DILocation(line: 18, column: 5, scope: !437, inlinedAt: !439)
!455 = !DILocalVariable(name: "sum", arg: 1, scope: !456, file: !229, line: 21, type: !332)
!456 = distinct !DISubprogram(name: "sum_scan", scope: !229, file: !229, line: 21, type: !457, scopeLine: 22, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !459)
!457 = !DISubroutineType(types: !458)
!458 = !{null, !332, !332}
!459 = !{!455, !460, !461, !462, !463}
!460 = !DILocalVariable(name: "bucket", arg: 2, scope: !456, file: !229, line: 21, type: !332)
!461 = !DILocalVariable(name: "radixID", scope: !456, file: !229, line: 23, type: !197)
!462 = !DILocalVariable(name: "bucket_indx", scope: !456, file: !229, line: 23, type: !197)
!463 = !DILabel(scope: !456, name: "sum_1", file: !229, line: 25)
!464 = !DILocation(line: 0, scope: !456, inlinedAt: !465)
!465 = distinct !DILocation(line: 93, column: 9, scope: !354)
!466 = !DILocation(line: 24, column: 12, scope: !456, inlinedAt: !465)
!467 = !DILocation(line: 25, column: 5, scope: !456, inlinedAt: !465)
!468 = !DILocation(line: 25, column: 13, scope: !469, inlinedAt: !465)
!469 = distinct !DILexicalBlock(scope: !456, file: !229, line: 25, column: 13)
!470 = !DILocation(line: 27, column: 24, scope: !471, inlinedAt: !465)
!471 = distinct !DILexicalBlock(scope: !472, file: !229, line: 25, column: 60)
!472 = distinct !DILexicalBlock(scope: !469, file: !229, line: 25, column: 13)
!473 = !DILocation(line: 27, column: 41, scope: !471, inlinedAt: !465)
!474 = !DILocation(line: 27, column: 39, scope: !471, inlinedAt: !465)
!475 = !DILocation(line: 27, column: 22, scope: !471, inlinedAt: !465)
!476 = !DILocation(line: 25, column: 56, scope: !472, inlinedAt: !465)
!477 = !DILocation(line: 25, column: 36, scope: !472, inlinedAt: !465)
!478 = distinct !{!478, !468, !479, !404, !405}
!479 = !DILocation(line: 28, column: 5, scope: !469, inlinedAt: !465)
!480 = !DILocalVariable(name: "radixID", scope: !481, file: !229, line: 33, type: !197)
!481 = distinct !DISubprogram(name: "last_step_scan", scope: !229, file: !229, line: 31, type: !457, scopeLine: 32, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !482)
!482 = !{!483, !484, !480, !485, !486, !487, !488}
!483 = !DILocalVariable(name: "bucket", arg: 1, scope: !481, file: !229, line: 31, type: !332)
!484 = !DILocalVariable(name: "sum", arg: 2, scope: !481, file: !229, line: 31, type: !332)
!485 = !DILocalVariable(name: "i", scope: !481, file: !229, line: 33, type: !197)
!486 = !DILocalVariable(name: "bucket_indx", scope: !481, file: !229, line: 33, type: !197)
!487 = !DILabel(scope: !481, name: "last_1", file: !229, line: 34)
!488 = !DILabel(scope: !489, name: "last_2", file: !229, line: 35)
!489 = distinct !DILexicalBlock(scope: !490, file: !229, line: 34, column: 59)
!490 = distinct !DILexicalBlock(scope: !491, file: !229, line: 34, column: 12)
!491 = distinct !DILexicalBlock(scope: !481, file: !229, line: 34, column: 12)
!492 = !DILocation(line: 0, scope: !481, inlinedAt: !493)
!493 = distinct !DILocation(line: 94, column: 9, scope: !354)
!494 = !DILocation(line: 35, column: 16, scope: !495, inlinedAt: !493)
!495 = distinct !DILexicalBlock(scope: !489, file: !229, line: 35, column: 16)
!496 = !DILocation(line: 37, column: 35, scope: !497, inlinedAt: !493)
!497 = distinct !DILexicalBlock(scope: !498, file: !229, line: 35, column: 45)
!498 = distinct !DILexicalBlock(scope: !495, file: !229, line: 35, column: 16)
!499 = !DILocation(line: 37, column: 57, scope: !497, inlinedAt: !493)
!500 = !DILocation(line: 37, column: 55, scope: !497, inlinedAt: !493)
!501 = !DILocation(line: 37, column: 33, scope: !497, inlinedAt: !493)
!502 = !DILocation(line: 35, column: 41, scope: !498, inlinedAt: !493)
!503 = !DILocation(line: 35, column: 27, scope: !498, inlinedAt: !493)
!504 = distinct !{!504, !494, !505, !404, !405}
!505 = !DILocation(line: 38, column: 9, scope: !495, inlinedAt: !493)
!506 = !DILocation(line: 34, column: 55, scope: !490, inlinedAt: !493)
!507 = !DILocation(line: 34, column: 35, scope: !490, inlinedAt: !493)
!508 = !DILocation(line: 34, column: 12, scope: !491, inlinedAt: !493)
!509 = distinct !{!509, !508, !510, !404, !405}
!510 = !DILocation(line: 39, column: 5, scope: !491, inlinedAt: !493)
!511 = !DILocation(line: 96, column: 13, scope: !354)
!512 = !DILocalVariable(name: "blockID", scope: !513, file: !229, line: 65, type: !197)
!513 = distinct !DISubprogram(name: "update", scope: !229, file: !229, line: 63, type: !514, scopeLine: 64, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !516)
!514 = !DISubroutineType(types: !515)
!515 = !{null, !332, !332, !332, !197}
!516 = !{!517, !518, !519, !520, !521, !512, !522, !523, !524, !525}
!517 = !DILocalVariable(name: "b", arg: 1, scope: !513, file: !229, line: 63, type: !332)
!518 = !DILocalVariable(name: "bucket", arg: 2, scope: !513, file: !229, line: 63, type: !332)
!519 = !DILocalVariable(name: "a", arg: 3, scope: !513, file: !229, line: 63, type: !332)
!520 = !DILocalVariable(name: "exp", arg: 4, scope: !513, file: !229, line: 63, type: !197)
!521 = !DILocalVariable(name: "i", scope: !513, file: !229, line: 65, type: !197)
!522 = !DILocalVariable(name: "bucket_indx", scope: !513, file: !229, line: 65, type: !197)
!523 = !DILocalVariable(name: "a_indx", scope: !513, file: !229, line: 65, type: !197)
!524 = !DILabel(scope: !513, name: "update_1", file: !229, line: 68)
!525 = !DILabel(scope: !526, name: "update_2", file: !229, line: 69)
!526 = distinct !DILexicalBlock(scope: !527, file: !229, line: 68, column: 68)
!527 = distinct !DILexicalBlock(scope: !528, file: !229, line: 68, column: 16)
!528 = distinct !DILexicalBlock(scope: !513, file: !229, line: 68, column: 16)
!529 = !DILocation(line: 0, scope: !513, inlinedAt: !530)
!530 = distinct !DILocation(line: 97, column: 13, scope: !531)
!531 = distinct !DILexicalBlock(scope: !532, file: !229, line: 96, column: 37)
!532 = distinct !DILexicalBlock(scope: !354, file: !229, line: 96, column: 13)
!533 = !DILocation(line: 69, column: 20, scope: !534, inlinedAt: !530)
!534 = distinct !DILexicalBlock(scope: !526, file: !229, line: 69, column: 20)
!535 = !DILocation(line: 70, column: 29, scope: !536, inlinedAt: !530)
!536 = distinct !DILexicalBlock(scope: !537, file: !229, line: 69, column: 39)
!537 = distinct !DILexicalBlock(scope: !534, file: !229, line: 69, column: 20)
!538 = !DILocation(line: 70, column: 63, scope: !536, inlinedAt: !530)
!539 = !DILocation(line: 70, column: 77, scope: !536, inlinedAt: !530)
!540 = !DILocation(line: 70, column: 90, scope: !536, inlinedAt: !530)
!541 = !DILocation(line: 72, column: 15, scope: !536, inlinedAt: !530)
!542 = !DILocation(line: 72, column: 13, scope: !536, inlinedAt: !530)
!543 = !DILocation(line: 72, column: 36, scope: !536, inlinedAt: !530)
!544 = !DILocation(line: 73, column: 32, scope: !536, inlinedAt: !530)
!545 = !DILocation(line: 69, column: 35, scope: !537, inlinedAt: !530)
!546 = !DILocation(line: 69, column: 30, scope: !537, inlinedAt: !530)
!547 = distinct !{!547, !533, !548, !404, !405}
!548 = !DILocation(line: 74, column: 9, scope: !534, inlinedAt: !530)
!549 = !DILocation(line: 68, column: 64, scope: !527, inlinedAt: !530)
!550 = !DILocation(line: 68, column: 42, scope: !527, inlinedAt: !530)
!551 = !DILocation(line: 68, column: 16, scope: !528, inlinedAt: !530)
!552 = distinct !{!552, !551, !553, !404, !405}
!553 = !DILocation(line: 75, column: 5, scope: !528, inlinedAt: !530)
!554 = !DILocation(line: 0, scope: !513, inlinedAt: !555)
!555 = distinct !DILocation(line: 100, column: 13, scope: !556)
!556 = distinct !DILexicalBlock(scope: !532, file: !229, line: 99, column: 16)
!557 = !DILocation(line: 69, column: 20, scope: !534, inlinedAt: !555)
!558 = !DILocation(line: 70, column: 29, scope: !536, inlinedAt: !555)
!559 = !DILocation(line: 70, column: 63, scope: !536, inlinedAt: !555)
!560 = !DILocation(line: 70, column: 77, scope: !536, inlinedAt: !555)
!561 = !DILocation(line: 70, column: 90, scope: !536, inlinedAt: !555)
!562 = !DILocation(line: 72, column: 15, scope: !536, inlinedAt: !555)
!563 = !DILocation(line: 72, column: 13, scope: !536, inlinedAt: !555)
!564 = !DILocation(line: 72, column: 36, scope: !536, inlinedAt: !555)
!565 = !DILocation(line: 73, column: 32, scope: !536, inlinedAt: !555)
!566 = !DILocation(line: 69, column: 35, scope: !537, inlinedAt: !555)
!567 = !DILocation(line: 69, column: 30, scope: !537, inlinedAt: !555)
!568 = distinct !{!568, !557, !569, !404, !405}
!569 = !DILocation(line: 74, column: 9, scope: !534, inlinedAt: !555)
!570 = !DILocation(line: 68, column: 64, scope: !527, inlinedAt: !555)
!571 = !DILocation(line: 68, column: 42, scope: !527, inlinedAt: !555)
!572 = !DILocation(line: 68, column: 16, scope: !528, inlinedAt: !555)
!573 = distinct !{!573, !572, !574, !404, !405}
!574 = !DILocation(line: 75, column: 5, scope: !528, inlinedAt: !555)
!575 = !DILocation(line: 84, column: 37, scope: !355)
!576 = !DILocation(line: 84, column: 29, scope: !355)
!577 = distinct !{!577, !343, !578, !404, !405}
!578 = !DILocation(line: 103, column: 5, scope: !344)
!579 = !DILocation(line: 105, column: 1, scope: !329)
!580 = !{!581}
!581 = distinct !{!581, !582, !"polly.alias.scope.MemRef0"}
!582 = distinct !{!582, !"polly.alias.scope.domain"}
!583 = !{!584}
!584 = distinct !{!584, !582, !"polly.alias.scope.MemRef2"}
!585 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 6, type: !586, scopeLine: 6, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !588)
!586 = !DISubroutineType(types: !587)
!587 = !{null, !233}
!588 = !{!589, !590}
!589 = !DILocalVariable(name: "vargs", arg: 1, scope: !585, file: !189, line: 6, type: !233)
!590 = !DILocalVariable(name: "args", scope: !585, file: !189, line: 7, type: !191)
!591 = !DILocation(line: 0, scope: !585)
!592 = !DILocation(line: 8, column: 24, scope: !585)
!593 = !DILocation(line: 8, column: 33, scope: !585)
!594 = !DILocation(line: 8, column: 47, scope: !585)
!595 = !DILocation(line: 8, column: 3, scope: !585)
!596 = !DILocation(line: 9, column: 1, scope: !585)
!597 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 16, type: !598, scopeLine: 16, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !600)
!598 = !DISubroutineType(types: !599)
!599 = !{null, !197, !233}
!600 = !{!601, !602, !603, !604, !605}
!601 = !DILocalVariable(name: "fd", arg: 1, scope: !597, file: !189, line: 16, type: !197)
!602 = !DILocalVariable(name: "vdata", arg: 2, scope: !597, file: !189, line: 16, type: !233)
!603 = !DILocalVariable(name: "data", scope: !597, file: !189, line: 17, type: !191)
!604 = !DILocalVariable(name: "p", scope: !597, file: !189, line: 18, type: !232)
!605 = !DILocalVariable(name: "s", scope: !597, file: !189, line: 18, type: !232)
!606 = !DILocation(line: 0, scope: !597)
!607 = !DILocation(line: 20, column: 3, scope: !597)
!608 = !DILocation(line: 22, column: 7, scope: !597)
!609 = !DILocalVariable(name: "s", arg: 1, scope: !610, file: !2, line: 56, type: !232)
!610 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !611, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !613)
!611 = !DISubroutineType(types: !612)
!612 = !{!232, !232, !197}
!613 = !{!609, !614, !615}
!614 = !DILocalVariable(name: "n", arg: 2, scope: !610, file: !2, line: 56, type: !197)
!615 = !DILocalVariable(name: "i", scope: !610, file: !2, line: 57, type: !197)
!616 = !DILocation(line: 0, scope: !610, inlinedAt: !617)
!617 = distinct !DILocation(line: 24, column: 7, scope: !597)
!618 = !DILocation(line: 64, column: 17, scope: !610, inlinedAt: !617)
!619 = !{!363, !363, i64 0}
!620 = !DILocation(line: 64, column: 3, scope: !610, inlinedAt: !617)
!621 = !DILocation(line: 66, column: 22, scope: !622, inlinedAt: !617)
!622 = distinct !DILexicalBlock(scope: !623, file: !2, line: 66, column: 9)
!623 = distinct !DILexicalBlock(scope: !610, file: !2, line: 64, column: 31)
!624 = !DILocation(line: 66, column: 26, scope: !622, inlinedAt: !617)
!625 = !DILocation(line: 66, column: 32, scope: !622, inlinedAt: !617)
!626 = !DILocation(line: 66, column: 35, scope: !622, inlinedAt: !617)
!627 = !DILocation(line: 66, column: 39, scope: !622, inlinedAt: !617)
!628 = !DILocation(line: 66, column: 9, scope: !623, inlinedAt: !617)
!629 = !DILocation(line: 69, column: 6, scope: !623, inlinedAt: !617)
!630 = !DILocation(line: 64, column: 10, scope: !610, inlinedAt: !617)
!631 = !DILocation(line: 64, column: 13, scope: !610, inlinedAt: !617)
!632 = distinct !{!632, !620, !633, !404, !405}
!633 = !DILocation(line: 70, column: 3, scope: !610, inlinedAt: !617)
!634 = !DILocation(line: 71, column: 6, scope: !635, inlinedAt: !617)
!635 = distinct !DILexicalBlock(scope: !610, file: !2, line: 71, column: 6)
!636 = !DILocation(line: 71, column: 8, scope: !635, inlinedAt: !617)
!637 = !DILocation(line: 71, column: 6, scope: !610, inlinedAt: !617)
!638 = !DILocation(line: 25, column: 3, scope: !597)
!639 = !DILocation(line: 26, column: 3, scope: !597)
!640 = !DILocation(line: 27, column: 1, scope: !597)
!641 = !DISubprogram(name: "free", scope: !642, file: !642, line: 687, type: !586, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!642 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!643 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 29, type: !598, scopeLine: 29, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !644)
!644 = !{!645, !646, !647}
!645 = !DILocalVariable(name: "fd", arg: 1, scope: !643, file: !189, line: 29, type: !197)
!646 = !DILocalVariable(name: "vdata", arg: 2, scope: !643, file: !189, line: 29, type: !233)
!647 = !DILocalVariable(name: "data", scope: !643, file: !189, line: 30, type: !191)
!648 = !DILocation(line: 0, scope: !643)
!649 = !DILocalVariable(name: "fd", arg: 1, scope: !650, file: !2, line: 189, type: !197)
!650 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !651, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !653)
!651 = !DISubroutineType(types: !652)
!652 = !{!197, !197}
!653 = !{!649}
!654 = !DILocation(line: 0, scope: !650, inlinedAt: !655)
!655 = distinct !DILocation(line: 32, column: 3, scope: !643)
!656 = !DILocation(line: 190, column: 3, scope: !657, inlinedAt: !655)
!657 = distinct !DILexicalBlock(scope: !658, file: !2, line: 190, column: 3)
!658 = distinct !DILexicalBlock(scope: !650, file: !2, line: 190, column: 3)
!659 = !DILocation(line: 191, column: 3, scope: !650, inlinedAt: !655)
!660 = !DILocalVariable(name: "fd", arg: 1, scope: !661, file: !2, line: 183, type: !197)
!661 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !662, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !665)
!662 = !DISubroutineType(types: !663)
!663 = !{!197, !197, !664, !197}
!664 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !255, size: 64)
!665 = !{!660, !666, !667, !668}
!666 = !DILocalVariable(name: "arr", arg: 2, scope: !661, file: !2, line: 183, type: !664)
!667 = !DILocalVariable(name: "n", arg: 3, scope: !661, file: !2, line: 183, type: !197)
!668 = !DILocalVariable(name: "i", scope: !661, file: !2, line: 183, type: !197)
!669 = !DILocation(line: 0, scope: !661, inlinedAt: !670)
!670 = distinct !DILocation(line: 33, column: 3, scope: !643)
!671 = !DILocation(line: 183, column: 1, scope: !672, inlinedAt: !670)
!672 = distinct !DILexicalBlock(scope: !661, file: !2, line: 183, column: 1)
!673 = !DILocation(line: 183, column: 1, scope: !674, inlinedAt: !670)
!674 = distinct !DILexicalBlock(scope: !675, file: !2, line: 183, column: 1)
!675 = distinct !DILexicalBlock(scope: !672, file: !2, line: 183, column: 1)
!676 = !DILocation(line: 183, column: 1, scope: !675, inlinedAt: !670)
!677 = distinct !{!677, !671, !671, !404, !405}
!678 = !DILocation(line: 34, column: 1, scope: !643)
!679 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 41, type: !598, scopeLine: 41, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !680)
!680 = !{!681, !682, !683, !684, !685}
!681 = !DILocalVariable(name: "fd", arg: 1, scope: !679, file: !189, line: 41, type: !197)
!682 = !DILocalVariable(name: "vdata", arg: 2, scope: !679, file: !189, line: 41, type: !233)
!683 = !DILocalVariable(name: "data", scope: !679, file: !189, line: 42, type: !191)
!684 = !DILocalVariable(name: "p", scope: !679, file: !189, line: 43, type: !232)
!685 = !DILocalVariable(name: "s", scope: !679, file: !189, line: 43, type: !232)
!686 = !DILocation(line: 0, scope: !679)
!687 = !DILocation(line: 45, column: 3, scope: !679)
!688 = !DILocation(line: 47, column: 7, scope: !679)
!689 = !DILocation(line: 0, scope: !610, inlinedAt: !690)
!690 = distinct !DILocation(line: 49, column: 7, scope: !679)
!691 = !DILocation(line: 64, column: 17, scope: !610, inlinedAt: !690)
!692 = !DILocation(line: 64, column: 3, scope: !610, inlinedAt: !690)
!693 = !DILocation(line: 66, column: 22, scope: !622, inlinedAt: !690)
!694 = !DILocation(line: 66, column: 26, scope: !622, inlinedAt: !690)
!695 = !DILocation(line: 66, column: 32, scope: !622, inlinedAt: !690)
!696 = !DILocation(line: 66, column: 35, scope: !622, inlinedAt: !690)
!697 = !DILocation(line: 66, column: 39, scope: !622, inlinedAt: !690)
!698 = !DILocation(line: 66, column: 9, scope: !623, inlinedAt: !690)
!699 = !DILocation(line: 69, column: 6, scope: !623, inlinedAt: !690)
!700 = !DILocation(line: 64, column: 10, scope: !610, inlinedAt: !690)
!701 = !DILocation(line: 64, column: 13, scope: !610, inlinedAt: !690)
!702 = distinct !{!702, !692, !703, !404, !405}
!703 = !DILocation(line: 70, column: 3, scope: !610, inlinedAt: !690)
!704 = !DILocation(line: 71, column: 6, scope: !635, inlinedAt: !690)
!705 = !DILocation(line: 71, column: 8, scope: !635, inlinedAt: !690)
!706 = !DILocation(line: 71, column: 6, scope: !610, inlinedAt: !690)
!707 = !DILocation(line: 50, column: 3, scope: !679)
!708 = !DILocation(line: 51, column: 3, scope: !679)
!709 = !DILocation(line: 52, column: 1, scope: !679)
!710 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 54, type: !598, scopeLine: 54, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !711)
!711 = !{!712, !713, !714}
!712 = !DILocalVariable(name: "fd", arg: 1, scope: !710, file: !189, line: 54, type: !197)
!713 = !DILocalVariable(name: "vdata", arg: 2, scope: !710, file: !189, line: 54, type: !233)
!714 = !DILocalVariable(name: "data", scope: !710, file: !189, line: 55, type: !191)
!715 = !DILocation(line: 0, scope: !710)
!716 = !DILocation(line: 0, scope: !650, inlinedAt: !717)
!717 = distinct !DILocation(line: 57, column: 3, scope: !710)
!718 = !DILocation(line: 190, column: 3, scope: !657, inlinedAt: !717)
!719 = !DILocation(line: 191, column: 3, scope: !650, inlinedAt: !717)
!720 = !DILocation(line: 0, scope: !661, inlinedAt: !721)
!721 = distinct !DILocation(line: 58, column: 3, scope: !710)
!722 = !DILocation(line: 183, column: 1, scope: !672, inlinedAt: !721)
!723 = !DILocation(line: 183, column: 1, scope: !674, inlinedAt: !721)
!724 = !DILocation(line: 183, column: 1, scope: !675, inlinedAt: !721)
!725 = distinct !{!725, !722, !722, !404, !405}
!726 = !DILocation(line: 59, column: 1, scope: !710)
!727 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 61, type: !728, scopeLine: 61, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !730)
!728 = !DISubroutineType(types: !729)
!729 = !{!197, !233, !233}
!730 = !{!731, !732, !733, !734, !735, !736, !737, !738}
!731 = !DILocalVariable(name: "vdata", arg: 1, scope: !727, file: !189, line: 61, type: !233)
!732 = !DILocalVariable(name: "vref", arg: 2, scope: !727, file: !189, line: 61, type: !233)
!733 = !DILocalVariable(name: "data", scope: !727, file: !189, line: 62, type: !191)
!734 = !DILocalVariable(name: "ref", scope: !727, file: !189, line: 63, type: !191)
!735 = !DILocalVariable(name: "has_errors", scope: !727, file: !189, line: 64, type: !197)
!736 = !DILocalVariable(name: "i", scope: !727, file: !189, line: 65, type: !197)
!737 = !DILocalVariable(name: "data_sum", scope: !727, file: !189, line: 66, type: !255)
!738 = !DILocalVariable(name: "ref_sum", scope: !727, file: !189, line: 66, type: !255)
!739 = !DILocation(line: 0, scope: !727)
!740 = !DILocation(line: 69, column: 14, scope: !727)
!741 = !DILocation(line: 70, column: 13, scope: !727)
!742 = !DILocation(line: 71, column: 3, scope: !743)
!743 = distinct !DILexicalBlock(scope: !727, file: !189, line: 71, column: 3)
!744 = !DILocation(line: 72, column: 34, scope: !745)
!745 = distinct !DILexicalBlock(scope: !746, file: !189, line: 71, column: 27)
!746 = distinct !DILexicalBlock(scope: !743, file: !189, line: 71, column: 3)
!747 = !DILocation(line: 72, column: 32, scope: !745)
!748 = !DILocation(line: 72, column: 16, scope: !745)
!749 = !DILocation(line: 73, column: 14, scope: !745)
!750 = !DILocation(line: 74, column: 16, scope: !745)
!751 = !DILocation(line: 74, column: 13, scope: !745)
!752 = !DILocation(line: 71, column: 22, scope: !746)
!753 = !DILocation(line: 71, column: 14, scope: !746)
!754 = distinct !{!754, !742, !755, !404, !405}
!755 = !DILocation(line: 75, column: 3, scope: !743)
!756 = !DILocation(line: 76, column: 26, scope: !727)
!757 = !DILocation(line: 76, column: 14, scope: !727)
!758 = !DILocation(line: 79, column: 10, scope: !727)
!759 = !DILocation(line: 79, column: 3, scope: !727)
!760 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !761, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !763)
!761 = !DISubroutineType(types: !762)
!762 = !{!232, !197}
!763 = !{!764, !765, !766, !803, !806, !809}
!764 = !DILocalVariable(name: "fd", arg: 1, scope: !760, file: !2, line: 34, type: !197)
!765 = !DILocalVariable(name: "p", scope: !760, file: !2, line: 35, type: !232)
!766 = !DILocalVariable(name: "s", scope: !760, file: !2, line: 36, type: !767)
!767 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !768, line: 44, size: 1024, elements: !769)
!768 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!769 = !{!770, !772, !774, !776, !778, !780, !782, !783, !784, !786, !788, !789, !791, !799, !800, !801}
!770 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !767, file: !768, line: 46, baseType: !771, size: 64)
!771 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !237, line: 145, baseType: !247)
!772 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !767, file: !768, line: 47, baseType: !773, size: 64, offset: 64)
!773 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !237, line: 148, baseType: !247)
!774 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !767, file: !768, line: 48, baseType: !775, size: 32, offset: 128)
!775 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !237, line: 150, baseType: !244)
!776 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !767, file: !768, line: 49, baseType: !777, size: 32, offset: 160)
!777 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !237, line: 151, baseType: !244)
!778 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !767, file: !768, line: 50, baseType: !779, size: 32, offset: 192)
!779 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !237, line: 146, baseType: !244)
!780 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !767, file: !768, line: 51, baseType: !781, size: 32, offset: 224)
!781 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !237, line: 147, baseType: !244)
!782 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !767, file: !768, line: 52, baseType: !771, size: 64, offset: 256)
!783 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !767, file: !768, line: 53, baseType: !771, size: 64, offset: 320)
!784 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !767, file: !768, line: 54, baseType: !785, size: 64, offset: 384)
!785 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !237, line: 152, baseType: !259)
!786 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !767, file: !768, line: 55, baseType: !787, size: 32, offset: 448)
!787 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !237, line: 175, baseType: !197)
!788 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !767, file: !768, line: 56, baseType: !197, size: 32, offset: 480)
!789 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !767, file: !768, line: 57, baseType: !790, size: 64, offset: 512)
!790 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !237, line: 180, baseType: !259)
!791 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !767, file: !768, line: 65, baseType: !792, size: 128, offset: 576)
!792 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !793, line: 11, size: 128, elements: !794)
!793 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!794 = !{!795, !797}
!795 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !792, file: !793, line: 16, baseType: !796, size: 64)
!796 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !237, line: 160, baseType: !259)
!797 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !792, file: !793, line: 21, baseType: !798, size: 64, offset: 64)
!798 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !237, line: 197, baseType: !259)
!799 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !767, file: !768, line: 66, baseType: !792, size: 128, offset: 704)
!800 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !767, file: !768, line: 67, baseType: !792, size: 128, offset: 832)
!801 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !767, file: !768, line: 79, baseType: !802, size: 64, offset: 960)
!802 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 64, elements: !55)
!803 = !DILocalVariable(name: "len", scope: !760, file: !2, line: 37, type: !804)
!804 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !805, line: 85, baseType: !785)
!805 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!806 = !DILocalVariable(name: "bytes_read", scope: !760, file: !2, line: 38, type: !807)
!807 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !805, line: 108, baseType: !808)
!808 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !237, line: 194, baseType: !259)
!809 = !DILocalVariable(name: "status", scope: !760, file: !2, line: 38, type: !807)
!810 = distinct !DIAssignID()
!811 = !DILocation(line: 0, scope: !760)
!812 = !DILocation(line: 36, column: 3, scope: !760)
!813 = !DILocation(line: 40, column: 3, scope: !814)
!814 = distinct !DILexicalBlock(scope: !815, file: !2, line: 40, column: 3)
!815 = distinct !DILexicalBlock(scope: !760, file: !2, line: 40, column: 3)
!816 = !DILocation(line: 41, column: 3, scope: !817)
!817 = distinct !DILexicalBlock(scope: !818, file: !2, line: 41, column: 3)
!818 = distinct !DILexicalBlock(scope: !760, file: !2, line: 41, column: 3)
!819 = !DILocation(line: 42, column: 11, scope: !760)
!820 = !DILocation(line: 43, column: 3, scope: !821)
!821 = distinct !DILexicalBlock(scope: !822, file: !2, line: 43, column: 3)
!822 = distinct !DILexicalBlock(scope: !760, file: !2, line: 43, column: 3)
!823 = !DILocation(line: 44, column: 25, scope: !760)
!824 = !DILocation(line: 44, column: 15, scope: !760)
!825 = !DILocation(line: 46, column: 3, scope: !760)
!826 = !DILocation(line: 49, column: 15, scope: !827)
!827 = distinct !DILexicalBlock(scope: !760, file: !2, line: 46, column: 27)
!828 = !DILocation(line: 46, column: 20, scope: !760)
!829 = distinct !{!829, !825, !830, !404, !405}
!830 = !DILocation(line: 50, column: 3, scope: !760)
!831 = !DILocation(line: 47, column: 24, scope: !827)
!832 = !DILocation(line: 47, column: 42, scope: !827)
!833 = !DILocation(line: 47, column: 14, scope: !827)
!834 = !DILocation(line: 48, column: 5, scope: !835)
!835 = distinct !DILexicalBlock(scope: !836, file: !2, line: 48, column: 5)
!836 = distinct !DILexicalBlock(scope: !827, file: !2, line: 48, column: 5)
!837 = !DILocation(line: 51, column: 3, scope: !760)
!838 = !DILocation(line: 51, column: 10, scope: !760)
!839 = !DILocation(line: 52, column: 3, scope: !760)
!840 = !DILocation(line: 54, column: 1, scope: !760)
!841 = !DILocation(line: 53, column: 3, scope: !760)
!842 = !DISubprogram(name: "__assert_fail", scope: !843, file: !843, line: 67, type: !844, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!843 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!844 = !DISubroutineType(types: !845)
!845 = !{null, !846, !846, !244, !846}
!846 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!847 = !DISubprogram(name: "fstat", scope: !848, file: !848, line: 210, type: !849, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!848 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!849 = !DISubroutineType(types: !850)
!850 = !{!197, !197, !851}
!851 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !767, size: 64)
!852 = !DISubprogram(name: "malloc", scope: !642, file: !642, line: 672, type: !853, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!853 = !DISubroutineType(types: !854)
!854 = !{!233, !855}
!855 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !856, line: 18, baseType: !247)
!856 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!857 = !DISubprogram(name: "read", scope: !858, file: !858, line: 371, type: !859, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!858 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!859 = !DISubroutineType(types: !860)
!860 = !{!807, !197, !233, !855}
!861 = !DISubprogram(name: "close", scope: !858, file: !858, line: 358, type: !651, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!862 = !DILocation(line: 0, scope: !610)
!863 = !DILocation(line: 59, column: 3, scope: !864)
!864 = distinct !DILexicalBlock(scope: !865, file: !2, line: 59, column: 3)
!865 = distinct !DILexicalBlock(scope: !610, file: !2, line: 59, column: 3)
!866 = !DILocation(line: 60, column: 7, scope: !867)
!867 = distinct !DILexicalBlock(scope: !610, file: !2, line: 60, column: 6)
!868 = !DILocation(line: 60, column: 6, scope: !610)
!869 = !DILocation(line: 64, column: 17, scope: !610)
!870 = !DILocation(line: 64, column: 3, scope: !610)
!871 = !DILocation(line: 66, column: 22, scope: !622)
!872 = !DILocation(line: 66, column: 26, scope: !622)
!873 = !DILocation(line: 66, column: 32, scope: !622)
!874 = !DILocation(line: 66, column: 35, scope: !622)
!875 = !DILocation(line: 66, column: 39, scope: !622)
!876 = !DILocation(line: 66, column: 9, scope: !623)
!877 = !DILocation(line: 69, column: 6, scope: !623)
!878 = !DILocation(line: 64, column: 10, scope: !610)
!879 = !DILocation(line: 64, column: 13, scope: !610)
!880 = distinct !{!880, !870, !881, !404, !405}
!881 = !DILocation(line: 70, column: 3, scope: !610)
!882 = !DILocation(line: 71, column: 6, scope: !635)
!883 = !DILocation(line: 71, column: 8, scope: !635)
!884 = !DILocation(line: 71, column: 6, scope: !610)
!885 = !DILocation(line: 74, column: 1, scope: !610)
!886 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !887, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !889)
!887 = !DISubroutineType(types: !888)
!888 = !{!197, !232, !232, !197}
!889 = !{!890, !891, !892, !893}
!890 = !DILocalVariable(name: "s", arg: 1, scope: !886, file: !2, line: 77, type: !232)
!891 = !DILocalVariable(name: "arr", arg: 2, scope: !886, file: !2, line: 77, type: !232)
!892 = !DILocalVariable(name: "n", arg: 3, scope: !886, file: !2, line: 77, type: !197)
!893 = !DILocalVariable(name: "k", scope: !886, file: !2, line: 78, type: !197)
!894 = !DILocation(line: 0, scope: !886)
!895 = !DILocation(line: 79, column: 3, scope: !896)
!896 = distinct !DILexicalBlock(scope: !897, file: !2, line: 79, column: 3)
!897 = distinct !DILexicalBlock(scope: !886, file: !2, line: 79, column: 3)
!898 = !DILocation(line: 81, column: 8, scope: !899)
!899 = distinct !DILexicalBlock(scope: !886, file: !2, line: 81, column: 7)
!900 = !DILocation(line: 81, column: 7, scope: !886)
!901 = !DILocation(line: 83, column: 12, scope: !902)
!902 = distinct !DILexicalBlock(scope: !899, file: !2, line: 81, column: 13)
!903 = !DILocation(line: 83, column: 5, scope: !902)
!904 = !DILocation(line: 91, column: 19, scope: !886)
!905 = !DILocation(line: 91, column: 3, scope: !886)
!906 = !DILocation(line: 92, column: 7, scope: !886)
!907 = !DILocation(line: 83, column: 16, scope: !902)
!908 = !DILocation(line: 83, column: 26, scope: !902)
!909 = !DILocation(line: 83, column: 32, scope: !902)
!910 = !DILocation(line: 83, column: 29, scope: !902)
!911 = !DILocation(line: 83, column: 35, scope: !902)
!912 = !DILocation(line: 83, column: 45, scope: !902)
!913 = !DILocation(line: 83, column: 48, scope: !902)
!914 = !DILocation(line: 83, column: 54, scope: !902)
!915 = !DILocation(line: 84, column: 9, scope: !902)
!916 = !DILocation(line: 84, column: 18, scope: !902)
!917 = !DILocation(line: 84, column: 26, scope: !902)
!918 = distinct !{!918, !903, !919, !404, !405}
!919 = !DILocation(line: 86, column: 5, scope: !902)
!920 = !DILocation(line: 93, column: 5, scope: !921)
!921 = distinct !DILexicalBlock(scope: !886, file: !2, line: 92, column: 7)
!922 = !DILocation(line: 93, column: 12, scope: !921)
!923 = !DILocation(line: 95, column: 3, scope: !886)
!924 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !925, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !928)
!925 = !DISubroutineType(types: !926)
!926 = !{!197, !232, !927, !197}
!927 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !234, size: 64)
!928 = !{!929, !930, !931, !932, !933, !934, !935}
!929 = !DILocalVariable(name: "s", arg: 1, scope: !924, file: !2, line: 132, type: !232)
!930 = !DILocalVariable(name: "arr", arg: 2, scope: !924, file: !2, line: 132, type: !927)
!931 = !DILocalVariable(name: "n", arg: 3, scope: !924, file: !2, line: 132, type: !197)
!932 = !DILocalVariable(name: "line", scope: !924, file: !2, line: 132, type: !232)
!933 = !DILocalVariable(name: "endptr", scope: !924, file: !2, line: 132, type: !232)
!934 = !DILocalVariable(name: "i", scope: !924, file: !2, line: 132, type: !197)
!935 = !DILocalVariable(name: "v", scope: !924, file: !2, line: 132, type: !234)
!936 = distinct !DIAssignID()
!937 = !DILocation(line: 0, scope: !924)
!938 = !DILocation(line: 132, column: 1, scope: !924)
!939 = !DILocation(line: 132, column: 1, scope: !940)
!940 = distinct !DILexicalBlock(scope: !941, file: !2, line: 132, column: 1)
!941 = distinct !DILexicalBlock(scope: !924, file: !2, line: 132, column: 1)
!942 = !DILocation(line: 132, column: 1, scope: !943)
!943 = distinct !DILexicalBlock(scope: !924, file: !2, line: 132, column: 1)
!944 = !{!945, !945, i64 0}
!945 = !{!"any pointer", !363, i64 0}
!946 = distinct !DIAssignID()
!947 = !DILocation(line: 132, column: 1, scope: !948)
!948 = distinct !DILexicalBlock(scope: !943, file: !2, line: 132, column: 1)
!949 = !DILocation(line: 132, column: 1, scope: !950)
!950 = distinct !DILexicalBlock(scope: !948, file: !2, line: 132, column: 1)
!951 = distinct !{!951, !938, !938, !404, !405}
!952 = !DILocation(line: 132, column: 1, scope: !953)
!953 = distinct !DILexicalBlock(scope: !954, file: !2, line: 132, column: 1)
!954 = distinct !DILexicalBlock(scope: !924, file: !2, line: 132, column: 1)
!955 = !DISubprogram(name: "strtok", scope: !956, file: !956, line: 356, type: !957, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!956 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!957 = !DISubroutineType(types: !958)
!958 = !{!232, !959, !960}
!959 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !232)
!960 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !846)
!961 = !DISubprogram(name: "strtol", scope: !642, file: !642, line: 177, type: !962, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!962 = !DISubroutineType(types: !963)
!963 = !{!259, !960, !964, !197}
!964 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !965)
!965 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !232, size: 64)
!966 = !DISubprogram(name: "fprintf", scope: !967, file: !967, line: 357, type: !968, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!967 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!968 = !DISubroutineType(types: !969)
!969 = !{!197, !970, !960, null}
!970 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !971)
!971 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !972, size: 64)
!972 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !973, line: 7, baseType: !974)
!973 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!974 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !975, line: 49, size: 1728, elements: !976)
!975 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!976 = !{!977, !978, !979, !980, !981, !982, !983, !984, !985, !986, !987, !988, !989, !992, !994, !995, !996, !997, !998, !999, !1003, !1006, !1008, !1011, !1014, !1015, !1016, !1018, !1019}
!977 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !974, file: !975, line: 51, baseType: !197, size: 32)
!978 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !974, file: !975, line: 54, baseType: !232, size: 64, offset: 64)
!979 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !974, file: !975, line: 55, baseType: !232, size: 64, offset: 128)
!980 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !974, file: !975, line: 56, baseType: !232, size: 64, offset: 192)
!981 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !974, file: !975, line: 57, baseType: !232, size: 64, offset: 256)
!982 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !974, file: !975, line: 58, baseType: !232, size: 64, offset: 320)
!983 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !974, file: !975, line: 59, baseType: !232, size: 64, offset: 384)
!984 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !974, file: !975, line: 60, baseType: !232, size: 64, offset: 448)
!985 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !974, file: !975, line: 61, baseType: !232, size: 64, offset: 512)
!986 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !974, file: !975, line: 64, baseType: !232, size: 64, offset: 576)
!987 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !974, file: !975, line: 65, baseType: !232, size: 64, offset: 640)
!988 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !974, file: !975, line: 66, baseType: !232, size: 64, offset: 704)
!989 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !974, file: !975, line: 68, baseType: !990, size: 64, offset: 768)
!990 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !991, size: 64)
!991 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !975, line: 36, flags: DIFlagFwdDecl)
!992 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !974, file: !975, line: 70, baseType: !993, size: 64, offset: 832)
!993 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !974, size: 64)
!994 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !974, file: !975, line: 72, baseType: !197, size: 32, offset: 896)
!995 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !974, file: !975, line: 73, baseType: !197, size: 32, offset: 928)
!996 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !974, file: !975, line: 74, baseType: !785, size: 64, offset: 960)
!997 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !974, file: !975, line: 77, baseType: !241, size: 16, offset: 1024)
!998 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !974, file: !975, line: 78, baseType: !251, size: 8, offset: 1040)
!999 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !974, file: !975, line: 79, baseType: !1000, size: 8, offset: 1048)
!1000 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !1001)
!1001 = !{!1002}
!1002 = !DISubrange(count: 1)
!1003 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !974, file: !975, line: 81, baseType: !1004, size: 64, offset: 1088)
!1004 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1005, size: 64)
!1005 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !975, line: 43, baseType: null)
!1006 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !974, file: !975, line: 89, baseType: !1007, size: 64, offset: 1152)
!1007 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !237, line: 153, baseType: !259)
!1008 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !974, file: !975, line: 91, baseType: !1009, size: 64, offset: 1216)
!1009 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1010, size: 64)
!1010 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !975, line: 37, flags: DIFlagFwdDecl)
!1011 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !974, file: !975, line: 92, baseType: !1012, size: 64, offset: 1280)
!1012 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1013, size: 64)
!1013 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !975, line: 38, flags: DIFlagFwdDecl)
!1014 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !974, file: !975, line: 93, baseType: !993, size: 64, offset: 1344)
!1015 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !974, file: !975, line: 94, baseType: !233, size: 64, offset: 1408)
!1016 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !974, file: !975, line: 95, baseType: !1017, size: 64, offset: 1472)
!1017 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !993, size: 64)
!1018 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !974, file: !975, line: 96, baseType: !197, size: 32, offset: 1536)
!1019 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !974, file: !975, line: 98, baseType: !1020, size: 160, offset: 1568)
!1020 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!1021 = !DISubprogram(name: "strlen", scope: !956, file: !956, line: 407, type: !1022, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1022 = !DISubroutineType(types: !1023)
!1023 = !{!247, !846}
!1024 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !1025, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1028)
!1025 = !DISubroutineType(types: !1026)
!1026 = !{!197, !232, !1027, !197}
!1027 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !239, size: 64)
!1028 = !{!1029, !1030, !1031, !1032, !1033, !1034, !1035}
!1029 = !DILocalVariable(name: "s", arg: 1, scope: !1024, file: !2, line: 133, type: !232)
!1030 = !DILocalVariable(name: "arr", arg: 2, scope: !1024, file: !2, line: 133, type: !1027)
!1031 = !DILocalVariable(name: "n", arg: 3, scope: !1024, file: !2, line: 133, type: !197)
!1032 = !DILocalVariable(name: "line", scope: !1024, file: !2, line: 133, type: !232)
!1033 = !DILocalVariable(name: "endptr", scope: !1024, file: !2, line: 133, type: !232)
!1034 = !DILocalVariable(name: "i", scope: !1024, file: !2, line: 133, type: !197)
!1035 = !DILocalVariable(name: "v", scope: !1024, file: !2, line: 133, type: !239)
!1036 = distinct !DIAssignID()
!1037 = !DILocation(line: 0, scope: !1024)
!1038 = !DILocation(line: 133, column: 1, scope: !1024)
!1039 = !DILocation(line: 133, column: 1, scope: !1040)
!1040 = distinct !DILexicalBlock(scope: !1041, file: !2, line: 133, column: 1)
!1041 = distinct !DILexicalBlock(scope: !1024, file: !2, line: 133, column: 1)
!1042 = !DILocation(line: 133, column: 1, scope: !1043)
!1043 = distinct !DILexicalBlock(scope: !1024, file: !2, line: 133, column: 1)
!1044 = distinct !DIAssignID()
!1045 = !DILocation(line: 133, column: 1, scope: !1046)
!1046 = distinct !DILexicalBlock(scope: !1043, file: !2, line: 133, column: 1)
!1047 = !DILocation(line: 133, column: 1, scope: !1048)
!1048 = distinct !DILexicalBlock(scope: !1046, file: !2, line: 133, column: 1)
!1049 = !{!1050, !1050, i64 0}
!1050 = !{!"short", !363, i64 0}
!1051 = distinct !{!1051, !1038, !1038, !404, !405}
!1052 = !DILocation(line: 133, column: 1, scope: !1053)
!1053 = distinct !DILexicalBlock(scope: !1054, file: !2, line: 133, column: 1)
!1054 = distinct !DILexicalBlock(scope: !1024, file: !2, line: 133, column: 1)
!1055 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !1056, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1059)
!1056 = !DISubroutineType(types: !1057)
!1057 = !{!197, !232, !1058, !197}
!1058 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !242, size: 64)
!1059 = !{!1060, !1061, !1062, !1063, !1064, !1065, !1066}
!1060 = !DILocalVariable(name: "s", arg: 1, scope: !1055, file: !2, line: 134, type: !232)
!1061 = !DILocalVariable(name: "arr", arg: 2, scope: !1055, file: !2, line: 134, type: !1058)
!1062 = !DILocalVariable(name: "n", arg: 3, scope: !1055, file: !2, line: 134, type: !197)
!1063 = !DILocalVariable(name: "line", scope: !1055, file: !2, line: 134, type: !232)
!1064 = !DILocalVariable(name: "endptr", scope: !1055, file: !2, line: 134, type: !232)
!1065 = !DILocalVariable(name: "i", scope: !1055, file: !2, line: 134, type: !197)
!1066 = !DILocalVariable(name: "v", scope: !1055, file: !2, line: 134, type: !242)
!1067 = distinct !DIAssignID()
!1068 = !DILocation(line: 0, scope: !1055)
!1069 = !DILocation(line: 134, column: 1, scope: !1055)
!1070 = !DILocation(line: 134, column: 1, scope: !1071)
!1071 = distinct !DILexicalBlock(scope: !1072, file: !2, line: 134, column: 1)
!1072 = distinct !DILexicalBlock(scope: !1055, file: !2, line: 134, column: 1)
!1073 = !DILocation(line: 134, column: 1, scope: !1074)
!1074 = distinct !DILexicalBlock(scope: !1055, file: !2, line: 134, column: 1)
!1075 = distinct !DIAssignID()
!1076 = !DILocation(line: 134, column: 1, scope: !1077)
!1077 = distinct !DILexicalBlock(scope: !1074, file: !2, line: 134, column: 1)
!1078 = !DILocation(line: 134, column: 1, scope: !1079)
!1079 = distinct !DILexicalBlock(scope: !1077, file: !2, line: 134, column: 1)
!1080 = distinct !{!1080, !1069, !1069, !404, !405}
!1081 = !DILocation(line: 134, column: 1, scope: !1082)
!1082 = distinct !DILexicalBlock(scope: !1083, file: !2, line: 134, column: 1)
!1083 = distinct !DILexicalBlock(scope: !1055, file: !2, line: 134, column: 1)
!1084 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !1085, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1088)
!1085 = !DISubroutineType(types: !1086)
!1086 = !{!197, !232, !1087, !197}
!1087 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !245, size: 64)
!1088 = !{!1089, !1090, !1091, !1092, !1093, !1094, !1095}
!1089 = !DILocalVariable(name: "s", arg: 1, scope: !1084, file: !2, line: 135, type: !232)
!1090 = !DILocalVariable(name: "arr", arg: 2, scope: !1084, file: !2, line: 135, type: !1087)
!1091 = !DILocalVariable(name: "n", arg: 3, scope: !1084, file: !2, line: 135, type: !197)
!1092 = !DILocalVariable(name: "line", scope: !1084, file: !2, line: 135, type: !232)
!1093 = !DILocalVariable(name: "endptr", scope: !1084, file: !2, line: 135, type: !232)
!1094 = !DILocalVariable(name: "i", scope: !1084, file: !2, line: 135, type: !197)
!1095 = !DILocalVariable(name: "v", scope: !1084, file: !2, line: 135, type: !245)
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
!1110 = !{!"long", !363, i64 0}
!1111 = distinct !{!1111, !1098, !1098, !404, !405}
!1112 = !DILocation(line: 135, column: 1, scope: !1113)
!1113 = distinct !DILexicalBlock(scope: !1114, file: !2, line: 135, column: 1)
!1114 = distinct !DILexicalBlock(scope: !1084, file: !2, line: 135, column: 1)
!1115 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1116, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1119)
!1116 = !DISubroutineType(types: !1117)
!1117 = !{!197, !232, !1118, !197}
!1118 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !248, size: 64)
!1119 = !{!1120, !1121, !1122, !1123, !1124, !1125, !1126}
!1120 = !DILocalVariable(name: "s", arg: 1, scope: !1115, file: !2, line: 136, type: !232)
!1121 = !DILocalVariable(name: "arr", arg: 2, scope: !1115, file: !2, line: 136, type: !1118)
!1122 = !DILocalVariable(name: "n", arg: 3, scope: !1115, file: !2, line: 136, type: !197)
!1123 = !DILocalVariable(name: "line", scope: !1115, file: !2, line: 136, type: !232)
!1124 = !DILocalVariable(name: "endptr", scope: !1115, file: !2, line: 136, type: !232)
!1125 = !DILocalVariable(name: "i", scope: !1115, file: !2, line: 136, type: !197)
!1126 = !DILocalVariable(name: "v", scope: !1115, file: !2, line: 136, type: !248)
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
!1140 = distinct !{!1140, !1129, !1129, !404, !405}
!1141 = !DILocation(line: 136, column: 1, scope: !1142)
!1142 = distinct !DILexicalBlock(scope: !1143, file: !2, line: 136, column: 1)
!1143 = distinct !DILexicalBlock(scope: !1115, file: !2, line: 136, column: 1)
!1144 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1145, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1148)
!1145 = !DISubroutineType(types: !1146)
!1146 = !{!197, !232, !1147, !197}
!1147 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !252, size: 64)
!1148 = !{!1149, !1150, !1151, !1152, !1153, !1154, !1155}
!1149 = !DILocalVariable(name: "s", arg: 1, scope: !1144, file: !2, line: 137, type: !232)
!1150 = !DILocalVariable(name: "arr", arg: 2, scope: !1144, file: !2, line: 137, type: !1147)
!1151 = !DILocalVariable(name: "n", arg: 3, scope: !1144, file: !2, line: 137, type: !197)
!1152 = !DILocalVariable(name: "line", scope: !1144, file: !2, line: 137, type: !232)
!1153 = !DILocalVariable(name: "endptr", scope: !1144, file: !2, line: 137, type: !232)
!1154 = !DILocalVariable(name: "i", scope: !1144, file: !2, line: 137, type: !197)
!1155 = !DILocalVariable(name: "v", scope: !1144, file: !2, line: 137, type: !252)
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
!1169 = distinct !{!1169, !1158, !1158, !404, !405}
!1170 = !DILocation(line: 137, column: 1, scope: !1171)
!1171 = distinct !DILexicalBlock(scope: !1172, file: !2, line: 137, column: 1)
!1172 = distinct !DILexicalBlock(scope: !1144, file: !2, line: 137, column: 1)
!1173 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1174, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1176)
!1174 = !DISubroutineType(types: !1175)
!1175 = !{!197, !232, !664, !197}
!1176 = !{!1177, !1178, !1179, !1180, !1181, !1182, !1183}
!1177 = !DILocalVariable(name: "s", arg: 1, scope: !1173, file: !2, line: 138, type: !232)
!1178 = !DILocalVariable(name: "arr", arg: 2, scope: !1173, file: !2, line: 138, type: !664)
!1179 = !DILocalVariable(name: "n", arg: 3, scope: !1173, file: !2, line: 138, type: !197)
!1180 = !DILocalVariable(name: "line", scope: !1173, file: !2, line: 138, type: !232)
!1181 = !DILocalVariable(name: "endptr", scope: !1173, file: !2, line: 138, type: !232)
!1182 = !DILocalVariable(name: "i", scope: !1173, file: !2, line: 138, type: !197)
!1183 = !DILocalVariable(name: "v", scope: !1173, file: !2, line: 138, type: !255)
!1184 = distinct !DIAssignID()
!1185 = !DILocation(line: 0, scope: !1173)
!1186 = !DILocation(line: 138, column: 1, scope: !1173)
!1187 = !DILocation(line: 138, column: 1, scope: !1188)
!1188 = distinct !DILexicalBlock(scope: !1189, file: !2, line: 138, column: 1)
!1189 = distinct !DILexicalBlock(scope: !1173, file: !2, line: 138, column: 1)
!1190 = !DILocation(line: 138, column: 1, scope: !1191)
!1191 = distinct !DILexicalBlock(scope: !1173, file: !2, line: 138, column: 1)
!1192 = distinct !DIAssignID()
!1193 = !DILocation(line: 138, column: 1, scope: !1194)
!1194 = distinct !DILexicalBlock(scope: !1191, file: !2, line: 138, column: 1)
!1195 = !DILocation(line: 138, column: 1, scope: !1196)
!1196 = distinct !DILexicalBlock(scope: !1194, file: !2, line: 138, column: 1)
!1197 = distinct !{!1197, !1186, !1186, !404, !405}
!1198 = !DILocation(line: 138, column: 1, scope: !1199)
!1199 = distinct !DILexicalBlock(scope: !1200, file: !2, line: 138, column: 1)
!1200 = distinct !DILexicalBlock(scope: !1173, file: !2, line: 138, column: 1)
!1201 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1202, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1205)
!1202 = !DISubroutineType(types: !1203)
!1203 = !{!197, !232, !1204, !197}
!1204 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !257, size: 64)
!1205 = !{!1206, !1207, !1208, !1209, !1210, !1211, !1212}
!1206 = !DILocalVariable(name: "s", arg: 1, scope: !1201, file: !2, line: 139, type: !232)
!1207 = !DILocalVariable(name: "arr", arg: 2, scope: !1201, file: !2, line: 139, type: !1204)
!1208 = !DILocalVariable(name: "n", arg: 3, scope: !1201, file: !2, line: 139, type: !197)
!1209 = !DILocalVariable(name: "line", scope: !1201, file: !2, line: 139, type: !232)
!1210 = !DILocalVariable(name: "endptr", scope: !1201, file: !2, line: 139, type: !232)
!1211 = !DILocalVariable(name: "i", scope: !1201, file: !2, line: 139, type: !197)
!1212 = !DILocalVariable(name: "v", scope: !1201, file: !2, line: 139, type: !257)
!1213 = distinct !DIAssignID()
!1214 = !DILocation(line: 0, scope: !1201)
!1215 = !DILocation(line: 139, column: 1, scope: !1201)
!1216 = !DILocation(line: 139, column: 1, scope: !1217)
!1217 = distinct !DILexicalBlock(scope: !1218, file: !2, line: 139, column: 1)
!1218 = distinct !DILexicalBlock(scope: !1201, file: !2, line: 139, column: 1)
!1219 = !DILocation(line: 139, column: 1, scope: !1220)
!1220 = distinct !DILexicalBlock(scope: !1201, file: !2, line: 139, column: 1)
!1221 = distinct !DIAssignID()
!1222 = !DILocation(line: 139, column: 1, scope: !1223)
!1223 = distinct !DILexicalBlock(scope: !1220, file: !2, line: 139, column: 1)
!1224 = !DILocation(line: 139, column: 1, scope: !1225)
!1225 = distinct !DILexicalBlock(scope: !1223, file: !2, line: 139, column: 1)
!1226 = distinct !{!1226, !1215, !1215, !404, !405}
!1227 = !DILocation(line: 139, column: 1, scope: !1228)
!1228 = distinct !DILexicalBlock(scope: !1229, file: !2, line: 139, column: 1)
!1229 = distinct !DILexicalBlock(scope: !1201, file: !2, line: 139, column: 1)
!1230 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1231, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1234)
!1231 = !DISubroutineType(types: !1232)
!1232 = !{!197, !232, !1233, !197}
!1233 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !260, size: 64)
!1234 = !{!1235, !1236, !1237, !1238, !1239, !1240, !1241}
!1235 = !DILocalVariable(name: "s", arg: 1, scope: !1230, file: !2, line: 141, type: !232)
!1236 = !DILocalVariable(name: "arr", arg: 2, scope: !1230, file: !2, line: 141, type: !1233)
!1237 = !DILocalVariable(name: "n", arg: 3, scope: !1230, file: !2, line: 141, type: !197)
!1238 = !DILocalVariable(name: "line", scope: !1230, file: !2, line: 141, type: !232)
!1239 = !DILocalVariable(name: "endptr", scope: !1230, file: !2, line: 141, type: !232)
!1240 = !DILocalVariable(name: "i", scope: !1230, file: !2, line: 141, type: !197)
!1241 = !DILocalVariable(name: "v", scope: !1230, file: !2, line: 141, type: !260)
!1242 = distinct !DIAssignID()
!1243 = !DILocation(line: 0, scope: !1230)
!1244 = !DILocation(line: 141, column: 1, scope: !1230)
!1245 = !DILocation(line: 141, column: 1, scope: !1246)
!1246 = distinct !DILexicalBlock(scope: !1247, file: !2, line: 141, column: 1)
!1247 = distinct !DILexicalBlock(scope: !1230, file: !2, line: 141, column: 1)
!1248 = !DILocation(line: 141, column: 1, scope: !1249)
!1249 = distinct !DILexicalBlock(scope: !1230, file: !2, line: 141, column: 1)
!1250 = distinct !DIAssignID()
!1251 = !DILocation(line: 141, column: 1, scope: !1252)
!1252 = distinct !DILexicalBlock(scope: !1249, file: !2, line: 141, column: 1)
!1253 = !DILocation(line: 141, column: 1, scope: !1254)
!1254 = distinct !DILexicalBlock(scope: !1252, file: !2, line: 141, column: 1)
!1255 = !{!1256, !1256, i64 0}
!1256 = !{!"float", !363, i64 0}
!1257 = distinct !{!1257, !1244, !1244, !404, !405}
!1258 = !DILocation(line: 141, column: 1, scope: !1259)
!1259 = distinct !DILexicalBlock(scope: !1260, file: !2, line: 141, column: 1)
!1260 = distinct !DILexicalBlock(scope: !1230, file: !2, line: 141, column: 1)
!1261 = !DISubprogram(name: "strtof", scope: !642, file: !642, line: 124, type: !1262, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1262 = !DISubroutineType(types: !1263)
!1263 = !{!260, !960, !964}
!1264 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1265, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1268)
!1265 = !DISubroutineType(types: !1266)
!1266 = !{!197, !232, !1267, !197}
!1267 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !261, size: 64)
!1268 = !{!1269, !1270, !1271, !1272, !1273, !1274, !1275}
!1269 = !DILocalVariable(name: "s", arg: 1, scope: !1264, file: !2, line: 142, type: !232)
!1270 = !DILocalVariable(name: "arr", arg: 2, scope: !1264, file: !2, line: 142, type: !1267)
!1271 = !DILocalVariable(name: "n", arg: 3, scope: !1264, file: !2, line: 142, type: !197)
!1272 = !DILocalVariable(name: "line", scope: !1264, file: !2, line: 142, type: !232)
!1273 = !DILocalVariable(name: "endptr", scope: !1264, file: !2, line: 142, type: !232)
!1274 = !DILocalVariable(name: "i", scope: !1264, file: !2, line: 142, type: !197)
!1275 = !DILocalVariable(name: "v", scope: !1264, file: !2, line: 142, type: !261)
!1276 = distinct !DIAssignID()
!1277 = !DILocation(line: 0, scope: !1264)
!1278 = !DILocation(line: 142, column: 1, scope: !1264)
!1279 = !DILocation(line: 142, column: 1, scope: !1280)
!1280 = distinct !DILexicalBlock(scope: !1281, file: !2, line: 142, column: 1)
!1281 = distinct !DILexicalBlock(scope: !1264, file: !2, line: 142, column: 1)
!1282 = !DILocation(line: 142, column: 1, scope: !1283)
!1283 = distinct !DILexicalBlock(scope: !1264, file: !2, line: 142, column: 1)
!1284 = distinct !DIAssignID()
!1285 = !DILocation(line: 142, column: 1, scope: !1286)
!1286 = distinct !DILexicalBlock(scope: !1283, file: !2, line: 142, column: 1)
!1287 = !DILocation(line: 142, column: 1, scope: !1288)
!1288 = distinct !DILexicalBlock(scope: !1286, file: !2, line: 142, column: 1)
!1289 = !{!1290, !1290, i64 0}
!1290 = !{!"double", !363, i64 0}
!1291 = distinct !{!1291, !1278, !1278, !404, !405}
!1292 = !DILocation(line: 142, column: 1, scope: !1293)
!1293 = distinct !DILexicalBlock(scope: !1294, file: !2, line: 142, column: 1)
!1294 = distinct !DILexicalBlock(scope: !1264, file: !2, line: 142, column: 1)
!1295 = !DISubprogram(name: "strtod", scope: !642, file: !642, line: 118, type: !1296, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1296 = !DISubroutineType(types: !1297)
!1297 = !{!261, !960, !964}
!1298 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1299, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1301)
!1299 = !DISubroutineType(types: !1300)
!1300 = !{!197, !197, !232, !197}
!1301 = !{!1302, !1303, !1304, !1305, !1306}
!1302 = !DILocalVariable(name: "fd", arg: 1, scope: !1298, file: !2, line: 145, type: !197)
!1303 = !DILocalVariable(name: "arr", arg: 2, scope: !1298, file: !2, line: 145, type: !232)
!1304 = !DILocalVariable(name: "n", arg: 3, scope: !1298, file: !2, line: 145, type: !197)
!1305 = !DILocalVariable(name: "status", scope: !1298, file: !2, line: 146, type: !197)
!1306 = !DILocalVariable(name: "written", scope: !1298, file: !2, line: 146, type: !197)
!1307 = !DILocation(line: 0, scope: !1298)
!1308 = !DILocation(line: 147, column: 3, scope: !1309)
!1309 = distinct !DILexicalBlock(scope: !1310, file: !2, line: 147, column: 3)
!1310 = distinct !DILexicalBlock(scope: !1298, file: !2, line: 147, column: 3)
!1311 = !DILocation(line: 148, column: 8, scope: !1312)
!1312 = distinct !DILexicalBlock(scope: !1298, file: !2, line: 148, column: 7)
!1313 = !DILocation(line: 148, column: 7, scope: !1298)
!1314 = !DILocation(line: 149, column: 9, scope: !1315)
!1315 = distinct !DILexicalBlock(scope: !1312, file: !2, line: 148, column: 13)
!1316 = !DILocation(line: 150, column: 3, scope: !1315)
!1317 = !DILocation(line: 152, column: 16, scope: !1298)
!1318 = !DILocation(line: 152, column: 3, scope: !1298)
!1319 = !DILocation(line: 158, column: 3, scope: !1298)
!1320 = !DILocation(line: 155, column: 13, scope: !1321)
!1321 = distinct !DILexicalBlock(scope: !1298, file: !2, line: 152, column: 20)
!1322 = distinct !{!1322, !1318, !1323, !404, !405}
!1323 = !DILocation(line: 156, column: 3, scope: !1298)
!1324 = !DILocation(line: 153, column: 25, scope: !1321)
!1325 = !DILocation(line: 153, column: 40, scope: !1321)
!1326 = !DILocation(line: 153, column: 39, scope: !1321)
!1327 = !DILocation(line: 153, column: 14, scope: !1321)
!1328 = !DILocation(line: 154, column: 5, scope: !1329)
!1329 = distinct !DILexicalBlock(scope: !1330, file: !2, line: 154, column: 5)
!1330 = distinct !DILexicalBlock(scope: !1321, file: !2, line: 154, column: 5)
!1331 = !DILocation(line: 159, column: 14, scope: !1332)
!1332 = distinct !DILexicalBlock(scope: !1298, file: !2, line: 158, column: 6)
!1333 = !DILocation(line: 160, column: 5, scope: !1334)
!1334 = distinct !DILexicalBlock(scope: !1335, file: !2, line: 160, column: 5)
!1335 = distinct !DILexicalBlock(scope: !1332, file: !2, line: 160, column: 5)
!1336 = !DILocation(line: 161, column: 17, scope: !1298)
!1337 = !DILocation(line: 161, column: 3, scope: !1332)
!1338 = distinct !{!1338, !1319, !1339, !404, !405}
!1339 = !DILocation(line: 161, column: 20, scope: !1298)
!1340 = !DILocation(line: 163, column: 3, scope: !1298)
!1341 = !DISubprogram(name: "write", scope: !858, file: !858, line: 378, type: !1342, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1342 = !DISubroutineType(types: !1343)
!1343 = !{!807, !197, !1344, !855}
!1344 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1345, size: 64)
!1345 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1346 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1347, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1349)
!1347 = !DISubroutineType(types: !1348)
!1348 = !{!197, !197, !927, !197}
!1349 = !{!1350, !1351, !1352, !1353}
!1350 = !DILocalVariable(name: "fd", arg: 1, scope: !1346, file: !2, line: 177, type: !197)
!1351 = !DILocalVariable(name: "arr", arg: 2, scope: !1346, file: !2, line: 177, type: !927)
!1352 = !DILocalVariable(name: "n", arg: 3, scope: !1346, file: !2, line: 177, type: !197)
!1353 = !DILocalVariable(name: "i", scope: !1346, file: !2, line: 177, type: !197)
!1354 = !DILocation(line: 0, scope: !1346)
!1355 = !DILocation(line: 177, column: 1, scope: !1356)
!1356 = distinct !DILexicalBlock(scope: !1357, file: !2, line: 177, column: 1)
!1357 = distinct !DILexicalBlock(scope: !1346, file: !2, line: 177, column: 1)
!1358 = !DILocation(line: 177, column: 1, scope: !1359)
!1359 = distinct !DILexicalBlock(scope: !1360, file: !2, line: 177, column: 1)
!1360 = distinct !DILexicalBlock(scope: !1346, file: !2, line: 177, column: 1)
!1361 = !DILocation(line: 177, column: 1, scope: !1360)
!1362 = !DILocation(line: 177, column: 1, scope: !1363)
!1363 = distinct !DILexicalBlock(scope: !1359, file: !2, line: 177, column: 1)
!1364 = distinct !{!1364, !1361, !1361, !404, !405}
!1365 = !DILocation(line: 177, column: 1, scope: !1346)
!1366 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1367, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1369)
!1367 = !DISubroutineType(cc: DW_CC_nocall, types: !1368)
!1368 = !{!197, !197, !846, null}
!1369 = !{!1370, !1371, !1372, !1376, !1377, !1378, !1379}
!1370 = !DILocalVariable(name: "fd", arg: 1, scope: !1366, file: !2, line: 15, type: !197)
!1371 = !DILocalVariable(name: "format", arg: 2, scope: !1366, file: !2, line: 15, type: !846)
!1372 = !DILocalVariable(name: "args", scope: !1366, file: !2, line: 16, type: !1373)
!1373 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1374, line: 12, baseType: !1375)
!1374 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1375 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !233)
!1376 = !DILocalVariable(name: "buffered", scope: !1366, file: !2, line: 17, type: !197)
!1377 = !DILocalVariable(name: "written", scope: !1366, file: !2, line: 17, type: !197)
!1378 = !DILocalVariable(name: "status", scope: !1366, file: !2, line: 17, type: !197)
!1379 = !DILocalVariable(name: "buffer", scope: !1366, file: !2, line: 18, type: !1380)
!1380 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !1381)
!1381 = !{!1382}
!1382 = !DISubrange(count: 256)
!1383 = distinct !DIAssignID()
!1384 = !DILocation(line: 0, scope: !1366)
!1385 = distinct !DIAssignID()
!1386 = !DILocation(line: 16, column: 3, scope: !1366)
!1387 = !DILocation(line: 18, column: 3, scope: !1366)
!1388 = !DILocation(line: 19, column: 3, scope: !1366)
!1389 = !DILocation(line: 20, column: 66, scope: !1366)
!1390 = !DILocation(line: 20, column: 14, scope: !1366)
!1391 = !DILocation(line: 21, column: 3, scope: !1366)
!1392 = !DILocation(line: 22, column: 3, scope: !1393)
!1393 = distinct !DILexicalBlock(scope: !1394, file: !2, line: 22, column: 3)
!1394 = distinct !DILexicalBlock(scope: !1366, file: !2, line: 22, column: 3)
!1395 = !DILocation(line: 24, column: 16, scope: !1366)
!1396 = !DILocation(line: 24, column: 3, scope: !1366)
!1397 = !DILocation(line: 27, column: 13, scope: !1398)
!1398 = distinct !DILexicalBlock(scope: !1366, file: !2, line: 24, column: 27)
!1399 = distinct !{!1399, !1396, !1400, !404, !405}
!1400 = !DILocation(line: 28, column: 3, scope: !1366)
!1401 = !DILocation(line: 25, column: 25, scope: !1398)
!1402 = !DILocation(line: 25, column: 50, scope: !1398)
!1403 = !DILocation(line: 25, column: 42, scope: !1398)
!1404 = !DILocation(line: 25, column: 14, scope: !1398)
!1405 = !DILocation(line: 26, column: 5, scope: !1406)
!1406 = distinct !DILexicalBlock(scope: !1407, file: !2, line: 26, column: 5)
!1407 = distinct !DILexicalBlock(scope: !1398, file: !2, line: 26, column: 5)
!1408 = !DILocation(line: 29, column: 3, scope: !1409)
!1409 = distinct !DILexicalBlock(scope: !1410, file: !2, line: 29, column: 3)
!1410 = distinct !DILexicalBlock(scope: !1366, file: !2, line: 29, column: 3)
!1411 = !DILocation(line: 31, column: 1, scope: !1366)
!1412 = !DILocation(line: 30, column: 3, scope: !1366)
!1413 = !DISubprogram(name: "vsnprintf", scope: !967, file: !967, line: 389, type: !1414, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1414 = !DISubroutineType(types: !1415)
!1415 = !{!197, !959, !855, !960, !1416}
!1416 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1417, line: 12, baseType: !1375)
!1417 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1418 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1419, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1421)
!1419 = !DISubroutineType(types: !1420)
!1420 = !{!197, !197, !1027, !197}
!1421 = !{!1422, !1423, !1424, !1425}
!1422 = !DILocalVariable(name: "fd", arg: 1, scope: !1418, file: !2, line: 178, type: !197)
!1423 = !DILocalVariable(name: "arr", arg: 2, scope: !1418, file: !2, line: 178, type: !1027)
!1424 = !DILocalVariable(name: "n", arg: 3, scope: !1418, file: !2, line: 178, type: !197)
!1425 = !DILocalVariable(name: "i", scope: !1418, file: !2, line: 178, type: !197)
!1426 = !DILocation(line: 0, scope: !1418)
!1427 = !DILocation(line: 178, column: 1, scope: !1428)
!1428 = distinct !DILexicalBlock(scope: !1429, file: !2, line: 178, column: 1)
!1429 = distinct !DILexicalBlock(scope: !1418, file: !2, line: 178, column: 1)
!1430 = !DILocation(line: 178, column: 1, scope: !1431)
!1431 = distinct !DILexicalBlock(scope: !1432, file: !2, line: 178, column: 1)
!1432 = distinct !DILexicalBlock(scope: !1418, file: !2, line: 178, column: 1)
!1433 = !DILocation(line: 178, column: 1, scope: !1432)
!1434 = !DILocation(line: 178, column: 1, scope: !1435)
!1435 = distinct !DILexicalBlock(scope: !1431, file: !2, line: 178, column: 1)
!1436 = distinct !{!1436, !1433, !1433, !404, !405}
!1437 = !DILocation(line: 178, column: 1, scope: !1418)
!1438 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1439, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1441)
!1439 = !DISubroutineType(types: !1440)
!1440 = !{!197, !197, !1058, !197}
!1441 = !{!1442, !1443, !1444, !1445}
!1442 = !DILocalVariable(name: "fd", arg: 1, scope: !1438, file: !2, line: 179, type: !197)
!1443 = !DILocalVariable(name: "arr", arg: 2, scope: !1438, file: !2, line: 179, type: !1058)
!1444 = !DILocalVariable(name: "n", arg: 3, scope: !1438, file: !2, line: 179, type: !197)
!1445 = !DILocalVariable(name: "i", scope: !1438, file: !2, line: 179, type: !197)
!1446 = !DILocation(line: 0, scope: !1438)
!1447 = !DILocation(line: 179, column: 1, scope: !1448)
!1448 = distinct !DILexicalBlock(scope: !1449, file: !2, line: 179, column: 1)
!1449 = distinct !DILexicalBlock(scope: !1438, file: !2, line: 179, column: 1)
!1450 = !DILocation(line: 179, column: 1, scope: !1451)
!1451 = distinct !DILexicalBlock(scope: !1452, file: !2, line: 179, column: 1)
!1452 = distinct !DILexicalBlock(scope: !1438, file: !2, line: 179, column: 1)
!1453 = !DILocation(line: 179, column: 1, scope: !1452)
!1454 = !DILocation(line: 179, column: 1, scope: !1455)
!1455 = distinct !DILexicalBlock(scope: !1451, file: !2, line: 179, column: 1)
!1456 = distinct !{!1456, !1453, !1453, !404, !405}
!1457 = !DILocation(line: 179, column: 1, scope: !1438)
!1458 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1459, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1461)
!1459 = !DISubroutineType(types: !1460)
!1460 = !{!197, !197, !1087, !197}
!1461 = !{!1462, !1463, !1464, !1465}
!1462 = !DILocalVariable(name: "fd", arg: 1, scope: !1458, file: !2, line: 180, type: !197)
!1463 = !DILocalVariable(name: "arr", arg: 2, scope: !1458, file: !2, line: 180, type: !1087)
!1464 = !DILocalVariable(name: "n", arg: 3, scope: !1458, file: !2, line: 180, type: !197)
!1465 = !DILocalVariable(name: "i", scope: !1458, file: !2, line: 180, type: !197)
!1466 = !DILocation(line: 0, scope: !1458)
!1467 = !DILocation(line: 180, column: 1, scope: !1468)
!1468 = distinct !DILexicalBlock(scope: !1469, file: !2, line: 180, column: 1)
!1469 = distinct !DILexicalBlock(scope: !1458, file: !2, line: 180, column: 1)
!1470 = !DILocation(line: 180, column: 1, scope: !1471)
!1471 = distinct !DILexicalBlock(scope: !1472, file: !2, line: 180, column: 1)
!1472 = distinct !DILexicalBlock(scope: !1458, file: !2, line: 180, column: 1)
!1473 = !DILocation(line: 180, column: 1, scope: !1472)
!1474 = !DILocation(line: 180, column: 1, scope: !1475)
!1475 = distinct !DILexicalBlock(scope: !1471, file: !2, line: 180, column: 1)
!1476 = distinct !{!1476, !1473, !1473, !404, !405}
!1477 = !DILocation(line: 180, column: 1, scope: !1458)
!1478 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1479, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1481)
!1479 = !DISubroutineType(types: !1480)
!1480 = !{!197, !197, !1118, !197}
!1481 = !{!1482, !1483, !1484, !1485}
!1482 = !DILocalVariable(name: "fd", arg: 1, scope: !1478, file: !2, line: 181, type: !197)
!1483 = !DILocalVariable(name: "arr", arg: 2, scope: !1478, file: !2, line: 181, type: !1118)
!1484 = !DILocalVariable(name: "n", arg: 3, scope: !1478, file: !2, line: 181, type: !197)
!1485 = !DILocalVariable(name: "i", scope: !1478, file: !2, line: 181, type: !197)
!1486 = !DILocation(line: 0, scope: !1478)
!1487 = !DILocation(line: 181, column: 1, scope: !1488)
!1488 = distinct !DILexicalBlock(scope: !1489, file: !2, line: 181, column: 1)
!1489 = distinct !DILexicalBlock(scope: !1478, file: !2, line: 181, column: 1)
!1490 = !DILocation(line: 181, column: 1, scope: !1491)
!1491 = distinct !DILexicalBlock(scope: !1492, file: !2, line: 181, column: 1)
!1492 = distinct !DILexicalBlock(scope: !1478, file: !2, line: 181, column: 1)
!1493 = !DILocation(line: 181, column: 1, scope: !1492)
!1494 = !DILocation(line: 181, column: 1, scope: !1495)
!1495 = distinct !DILexicalBlock(scope: !1491, file: !2, line: 181, column: 1)
!1496 = distinct !{!1496, !1493, !1493, !404, !405}
!1497 = !DILocation(line: 181, column: 1, scope: !1478)
!1498 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1499, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1501)
!1499 = !DISubroutineType(types: !1500)
!1500 = !{!197, !197, !1147, !197}
!1501 = !{!1502, !1503, !1504, !1505}
!1502 = !DILocalVariable(name: "fd", arg: 1, scope: !1498, file: !2, line: 182, type: !197)
!1503 = !DILocalVariable(name: "arr", arg: 2, scope: !1498, file: !2, line: 182, type: !1147)
!1504 = !DILocalVariable(name: "n", arg: 3, scope: !1498, file: !2, line: 182, type: !197)
!1505 = !DILocalVariable(name: "i", scope: !1498, file: !2, line: 182, type: !197)
!1506 = !DILocation(line: 0, scope: !1498)
!1507 = !DILocation(line: 182, column: 1, scope: !1508)
!1508 = distinct !DILexicalBlock(scope: !1509, file: !2, line: 182, column: 1)
!1509 = distinct !DILexicalBlock(scope: !1498, file: !2, line: 182, column: 1)
!1510 = !DILocation(line: 182, column: 1, scope: !1511)
!1511 = distinct !DILexicalBlock(scope: !1512, file: !2, line: 182, column: 1)
!1512 = distinct !DILexicalBlock(scope: !1498, file: !2, line: 182, column: 1)
!1513 = !DILocation(line: 182, column: 1, scope: !1512)
!1514 = !DILocation(line: 182, column: 1, scope: !1515)
!1515 = distinct !DILexicalBlock(scope: !1511, file: !2, line: 182, column: 1)
!1516 = distinct !{!1516, !1513, !1513, !404, !405}
!1517 = !DILocation(line: 182, column: 1, scope: !1498)
!1518 = !DILocation(line: 0, scope: !661)
!1519 = !DILocation(line: 183, column: 1, scope: !1520)
!1520 = distinct !DILexicalBlock(scope: !1521, file: !2, line: 183, column: 1)
!1521 = distinct !DILexicalBlock(scope: !661, file: !2, line: 183, column: 1)
!1522 = !DILocation(line: 183, column: 1, scope: !675)
!1523 = !DILocation(line: 183, column: 1, scope: !672)
!1524 = !DILocation(line: 183, column: 1, scope: !674)
!1525 = distinct !{!1525, !1523, !1523, !404, !405}
!1526 = !DILocation(line: 183, column: 1, scope: !661)
!1527 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1528, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1530)
!1528 = !DISubroutineType(types: !1529)
!1529 = !{!197, !197, !1204, !197}
!1530 = !{!1531, !1532, !1533, !1534}
!1531 = !DILocalVariable(name: "fd", arg: 1, scope: !1527, file: !2, line: 184, type: !197)
!1532 = !DILocalVariable(name: "arr", arg: 2, scope: !1527, file: !2, line: 184, type: !1204)
!1533 = !DILocalVariable(name: "n", arg: 3, scope: !1527, file: !2, line: 184, type: !197)
!1534 = !DILocalVariable(name: "i", scope: !1527, file: !2, line: 184, type: !197)
!1535 = !DILocation(line: 0, scope: !1527)
!1536 = !DILocation(line: 184, column: 1, scope: !1537)
!1537 = distinct !DILexicalBlock(scope: !1538, file: !2, line: 184, column: 1)
!1538 = distinct !DILexicalBlock(scope: !1527, file: !2, line: 184, column: 1)
!1539 = !DILocation(line: 184, column: 1, scope: !1540)
!1540 = distinct !DILexicalBlock(scope: !1541, file: !2, line: 184, column: 1)
!1541 = distinct !DILexicalBlock(scope: !1527, file: !2, line: 184, column: 1)
!1542 = !DILocation(line: 184, column: 1, scope: !1541)
!1543 = !DILocation(line: 184, column: 1, scope: !1544)
!1544 = distinct !DILexicalBlock(scope: !1540, file: !2, line: 184, column: 1)
!1545 = distinct !{!1545, !1542, !1542, !404, !405}
!1546 = !DILocation(line: 184, column: 1, scope: !1527)
!1547 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1548, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1550)
!1548 = !DISubroutineType(types: !1549)
!1549 = !{!197, !197, !1233, !197}
!1550 = !{!1551, !1552, !1553, !1554}
!1551 = !DILocalVariable(name: "fd", arg: 1, scope: !1547, file: !2, line: 186, type: !197)
!1552 = !DILocalVariable(name: "arr", arg: 2, scope: !1547, file: !2, line: 186, type: !1233)
!1553 = !DILocalVariable(name: "n", arg: 3, scope: !1547, file: !2, line: 186, type: !197)
!1554 = !DILocalVariable(name: "i", scope: !1547, file: !2, line: 186, type: !197)
!1555 = !DILocation(line: 0, scope: !1547)
!1556 = !DILocation(line: 186, column: 1, scope: !1557)
!1557 = distinct !DILexicalBlock(scope: !1558, file: !2, line: 186, column: 1)
!1558 = distinct !DILexicalBlock(scope: !1547, file: !2, line: 186, column: 1)
!1559 = !DILocation(line: 186, column: 1, scope: !1560)
!1560 = distinct !DILexicalBlock(scope: !1561, file: !2, line: 186, column: 1)
!1561 = distinct !DILexicalBlock(scope: !1547, file: !2, line: 186, column: 1)
!1562 = !DILocation(line: 186, column: 1, scope: !1561)
!1563 = !DILocation(line: 186, column: 1, scope: !1564)
!1564 = distinct !DILexicalBlock(scope: !1560, file: !2, line: 186, column: 1)
!1565 = distinct !{!1565, !1562, !1562, !404, !405}
!1566 = !DILocation(line: 186, column: 1, scope: !1547)
!1567 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !1568, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !230, retainedNodes: !1570)
!1568 = !DISubroutineType(types: !1569)
!1569 = !{!197, !197, !1267, !197}
!1570 = !{!1571, !1572, !1573, !1574}
!1571 = !DILocalVariable(name: "fd", arg: 1, scope: !1567, file: !2, line: 187, type: !197)
!1572 = !DILocalVariable(name: "arr", arg: 2, scope: !1567, file: !2, line: 187, type: !1267)
!1573 = !DILocalVariable(name: "n", arg: 3, scope: !1567, file: !2, line: 187, type: !197)
!1574 = !DILocalVariable(name: "i", scope: !1567, file: !2, line: 187, type: !197)
!1575 = !DILocation(line: 0, scope: !1567)
!1576 = !DILocation(line: 187, column: 1, scope: !1577)
!1577 = distinct !DILexicalBlock(scope: !1578, file: !2, line: 187, column: 1)
!1578 = distinct !DILexicalBlock(scope: !1567, file: !2, line: 187, column: 1)
!1579 = !DILocation(line: 187, column: 1, scope: !1580)
!1580 = distinct !DILexicalBlock(scope: !1581, file: !2, line: 187, column: 1)
!1581 = distinct !DILexicalBlock(scope: !1567, file: !2, line: 187, column: 1)
!1582 = !DILocation(line: 187, column: 1, scope: !1581)
!1583 = !DILocation(line: 187, column: 1, scope: !1584)
!1584 = distinct !DILexicalBlock(scope: !1580, file: !2, line: 187, column: 1)
!1585 = distinct !{!1585, !1582, !1582, !404, !405}
!1586 = !DILocation(line: 187, column: 1, scope: !1567)
!1587 = !DILocation(line: 0, scope: !650)
!1588 = !DILocation(line: 190, column: 3, scope: !657)
!1589 = !DILocation(line: 191, column: 3, scope: !650)
!1590 = !DILocation(line: 192, column: 3, scope: !650)
!1591 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1592, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !296, retainedNodes: !1594)
!1592 = !DISubroutineType(types: !1593)
!1593 = !{!197, !197, !965}
!1594 = !{!1595, !1596, !1597, !1598, !1599, !1600, !1601, !1602, !1603}
!1595 = !DILocalVariable(name: "argc", arg: 1, scope: !1591, file: !170, line: 14, type: !197)
!1596 = !DILocalVariable(name: "argv", arg: 2, scope: !1591, file: !170, line: 14, type: !965)
!1597 = !DILocalVariable(name: "in_file", scope: !1591, file: !170, line: 17, type: !232)
!1598 = !DILocalVariable(name: "check_file", scope: !1591, file: !170, line: 19, type: !232)
!1599 = !DILocalVariable(name: "in_fd", scope: !1591, file: !170, line: 34, type: !197)
!1600 = !DILocalVariable(name: "data", scope: !1591, file: !170, line: 35, type: !232)
!1601 = !DILocalVariable(name: "out_fd", scope: !1591, file: !170, line: 46, type: !197)
!1602 = !DILocalVariable(name: "check_fd", scope: !1591, file: !170, line: 55, type: !197)
!1603 = !DILocalVariable(name: "ref", scope: !1591, file: !170, line: 56, type: !232)
!1604 = !DILocation(line: 0, scope: !1591)
!1605 = !DILocation(line: 21, column: 3, scope: !1606)
!1606 = distinct !DILexicalBlock(scope: !1607, file: !170, line: 21, column: 3)
!1607 = distinct !DILexicalBlock(scope: !1591, file: !170, line: 21, column: 3)
!1608 = !DILocation(line: 26, column: 11, scope: !1609)
!1609 = distinct !DILexicalBlock(scope: !1591, file: !170, line: 26, column: 7)
!1610 = !DILocation(line: 26, column: 7, scope: !1591)
!1611 = !DILocation(line: 27, column: 15, scope: !1609)
!1612 = !DILocation(line: 29, column: 11, scope: !1613)
!1613 = distinct !DILexicalBlock(scope: !1591, file: !170, line: 29, column: 7)
!1614 = !DILocation(line: 29, column: 7, scope: !1591)
!1615 = !DILocation(line: 30, column: 18, scope: !1613)
!1616 = !DILocation(line: 30, column: 5, scope: !1613)
!1617 = !DILocation(line: 36, column: 17, scope: !1591)
!1618 = !DILocation(line: 36, column: 10, scope: !1591)
!1619 = !DILocation(line: 37, column: 3, scope: !1620)
!1620 = distinct !DILexicalBlock(scope: !1621, file: !170, line: 37, column: 3)
!1621 = distinct !DILexicalBlock(scope: !1591, file: !170, line: 37, column: 3)
!1622 = !DILocation(line: 38, column: 11, scope: !1591)
!1623 = !DILocation(line: 39, column: 3, scope: !1624)
!1624 = distinct !DILexicalBlock(scope: !1625, file: !170, line: 39, column: 3)
!1625 = distinct !DILexicalBlock(scope: !1591, file: !170, line: 39, column: 3)
!1626 = !DILocation(line: 0, scope: !597, inlinedAt: !1627)
!1627 = distinct !DILocation(line: 40, column: 3, scope: !1591)
!1628 = !DILocation(line: 20, column: 3, scope: !597, inlinedAt: !1627)
!1629 = !DILocation(line: 22, column: 7, scope: !597, inlinedAt: !1627)
!1630 = !DILocation(line: 0, scope: !610, inlinedAt: !1631)
!1631 = distinct !DILocation(line: 24, column: 7, scope: !597, inlinedAt: !1627)
!1632 = !DILocation(line: 64, column: 17, scope: !610, inlinedAt: !1631)
!1633 = !DILocation(line: 64, column: 3, scope: !610, inlinedAt: !1631)
!1634 = !DILocation(line: 66, column: 22, scope: !622, inlinedAt: !1631)
!1635 = !DILocation(line: 66, column: 26, scope: !622, inlinedAt: !1631)
!1636 = !DILocation(line: 66, column: 32, scope: !622, inlinedAt: !1631)
!1637 = !DILocation(line: 66, column: 35, scope: !622, inlinedAt: !1631)
!1638 = !DILocation(line: 66, column: 39, scope: !622, inlinedAt: !1631)
!1639 = !DILocation(line: 66, column: 9, scope: !623, inlinedAt: !1631)
!1640 = !DILocation(line: 69, column: 6, scope: !623, inlinedAt: !1631)
!1641 = !DILocation(line: 64, column: 10, scope: !610, inlinedAt: !1631)
!1642 = !DILocation(line: 64, column: 13, scope: !610, inlinedAt: !1631)
!1643 = distinct !{!1643, !1633, !1644, !404, !405}
!1644 = !DILocation(line: 70, column: 3, scope: !610, inlinedAt: !1631)
!1645 = !DILocation(line: 71, column: 6, scope: !635, inlinedAt: !1631)
!1646 = !DILocation(line: 71, column: 8, scope: !635, inlinedAt: !1631)
!1647 = !DILocation(line: 71, column: 6, scope: !610, inlinedAt: !1631)
!1648 = !DILocation(line: 25, column: 3, scope: !597, inlinedAt: !1627)
!1649 = !DILocation(line: 26, column: 3, scope: !597, inlinedAt: !1627)
!1650 = !DILocation(line: 0, scope: !585, inlinedAt: !1651)
!1651 = distinct !DILocation(line: 43, column: 3, scope: !1591)
!1652 = !DILocation(line: 8, column: 24, scope: !585, inlinedAt: !1651)
!1653 = !DILocation(line: 8, column: 33, scope: !585, inlinedAt: !1651)
!1654 = !DILocation(line: 8, column: 47, scope: !585, inlinedAt: !1651)
!1655 = !DILocation(line: 8, column: 3, scope: !585, inlinedAt: !1651)
!1656 = !DILocation(line: 47, column: 12, scope: !1591)
!1657 = !DILocation(line: 48, column: 3, scope: !1658)
!1658 = distinct !DILexicalBlock(scope: !1659, file: !170, line: 48, column: 3)
!1659 = distinct !DILexicalBlock(scope: !1591, file: !170, line: 48, column: 3)
!1660 = !DILocation(line: 0, scope: !710, inlinedAt: !1661)
!1661 = distinct !DILocation(line: 49, column: 3, scope: !1591)
!1662 = !DILocation(line: 0, scope: !650, inlinedAt: !1663)
!1663 = distinct !DILocation(line: 57, column: 3, scope: !710, inlinedAt: !1661)
!1664 = !DILocation(line: 190, column: 3, scope: !657, inlinedAt: !1663)
!1665 = !DILocation(line: 191, column: 3, scope: !650, inlinedAt: !1663)
!1666 = !DILocation(line: 0, scope: !661, inlinedAt: !1667)
!1667 = distinct !DILocation(line: 58, column: 3, scope: !710, inlinedAt: !1661)
!1668 = !DILocation(line: 183, column: 1, scope: !672, inlinedAt: !1667)
!1669 = !DILocation(line: 183, column: 1, scope: !674, inlinedAt: !1667)
!1670 = !DILocation(line: 183, column: 1, scope: !675, inlinedAt: !1667)
!1671 = distinct !{!1671, !1668, !1668, !404, !405}
!1672 = !DILocation(line: 50, column: 3, scope: !1591)
!1673 = !DILocation(line: 57, column: 16, scope: !1591)
!1674 = !DILocation(line: 57, column: 9, scope: !1591)
!1675 = !DILocation(line: 58, column: 3, scope: !1676)
!1676 = distinct !DILexicalBlock(scope: !1677, file: !170, line: 58, column: 3)
!1677 = distinct !DILexicalBlock(scope: !1591, file: !170, line: 58, column: 3)
!1678 = !DILocation(line: 59, column: 14, scope: !1591)
!1679 = !DILocation(line: 60, column: 3, scope: !1680)
!1680 = distinct !DILexicalBlock(scope: !1681, file: !170, line: 60, column: 3)
!1681 = distinct !DILexicalBlock(scope: !1591, file: !170, line: 60, column: 3)
!1682 = !DILocation(line: 0, scope: !679, inlinedAt: !1683)
!1683 = distinct !DILocation(line: 61, column: 3, scope: !1591)
!1684 = !DILocation(line: 45, column: 3, scope: !679, inlinedAt: !1683)
!1685 = !DILocation(line: 47, column: 7, scope: !679, inlinedAt: !1683)
!1686 = !DILocation(line: 0, scope: !610, inlinedAt: !1687)
!1687 = distinct !DILocation(line: 49, column: 7, scope: !679, inlinedAt: !1683)
!1688 = !DILocation(line: 64, column: 17, scope: !610, inlinedAt: !1687)
!1689 = !DILocation(line: 64, column: 3, scope: !610, inlinedAt: !1687)
!1690 = !DILocation(line: 66, column: 22, scope: !622, inlinedAt: !1687)
!1691 = !DILocation(line: 66, column: 26, scope: !622, inlinedAt: !1687)
!1692 = !DILocation(line: 66, column: 32, scope: !622, inlinedAt: !1687)
!1693 = !DILocation(line: 66, column: 35, scope: !622, inlinedAt: !1687)
!1694 = !DILocation(line: 66, column: 39, scope: !622, inlinedAt: !1687)
!1695 = !DILocation(line: 66, column: 9, scope: !623, inlinedAt: !1687)
!1696 = !DILocation(line: 69, column: 6, scope: !623, inlinedAt: !1687)
!1697 = !DILocation(line: 64, column: 10, scope: !610, inlinedAt: !1687)
!1698 = !DILocation(line: 64, column: 13, scope: !610, inlinedAt: !1687)
!1699 = distinct !{!1699, !1689, !1700, !404, !405}
!1700 = !DILocation(line: 70, column: 3, scope: !610, inlinedAt: !1687)
!1701 = !DILocation(line: 71, column: 6, scope: !635, inlinedAt: !1687)
!1702 = !DILocation(line: 71, column: 8, scope: !635, inlinedAt: !1687)
!1703 = !DILocation(line: 71, column: 6, scope: !610, inlinedAt: !1687)
!1704 = !DILocation(line: 50, column: 3, scope: !679, inlinedAt: !1683)
!1705 = !DILocation(line: 51, column: 3, scope: !679, inlinedAt: !1683)
!1706 = !DILocation(line: 0, scope: !727, inlinedAt: !1707)
!1707 = distinct !DILocation(line: 66, column: 8, scope: !1708)
!1708 = distinct !DILexicalBlock(scope: !1591, file: !170, line: 66, column: 7)
!1709 = !DILocation(line: 69, column: 14, scope: !727, inlinedAt: !1707)
!1710 = !DILocation(line: 70, column: 13, scope: !727, inlinedAt: !1707)
!1711 = !DILocation(line: 71, column: 3, scope: !743, inlinedAt: !1707)
!1712 = !DILocation(line: 72, column: 34, scope: !745, inlinedAt: !1707)
!1713 = !DILocation(line: 72, column: 32, scope: !745, inlinedAt: !1707)
!1714 = !DILocation(line: 72, column: 16, scope: !745, inlinedAt: !1707)
!1715 = !DILocation(line: 73, column: 14, scope: !745, inlinedAt: !1707)
!1716 = !DILocation(line: 74, column: 16, scope: !745, inlinedAt: !1707)
!1717 = !DILocation(line: 74, column: 13, scope: !745, inlinedAt: !1707)
!1718 = !DILocation(line: 71, column: 22, scope: !746, inlinedAt: !1707)
!1719 = !DILocation(line: 71, column: 14, scope: !746, inlinedAt: !1707)
!1720 = distinct !{!1720, !1711, !1721, !404, !405}
!1721 = !DILocation(line: 75, column: 3, scope: !743, inlinedAt: !1707)
!1722 = !DILocation(line: 76, column: 26, scope: !727, inlinedAt: !1707)
!1723 = !DILocation(line: 76, column: 14, scope: !727, inlinedAt: !1707)
!1724 = !DILocation(line: 79, column: 10, scope: !727, inlinedAt: !1707)
!1725 = !DILocation(line: 66, column: 7, scope: !1591)
!1726 = !DILocation(line: 67, column: 13, scope: !1727)
!1727 = distinct !DILexicalBlock(scope: !1708, file: !170, line: 66, column: 32)
!1728 = !DILocation(line: 67, column: 5, scope: !1727)
!1729 = !DILocation(line: 68, column: 5, scope: !1727)
!1730 = !DILocation(line: 71, column: 3, scope: !1591)
!1731 = !DILocation(line: 72, column: 3, scope: !1591)
!1732 = !DILocation(line: 74, column: 3, scope: !1591)
!1733 = !DILocation(line: 75, column: 3, scope: !1591)
!1734 = !DILocation(line: 76, column: 1, scope: !1591)
!1735 = !DISubprogram(name: "open", scope: !1736, file: !1736, line: 209, type: !1737, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1736 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1737 = !DISubroutineType(types: !1738)
!1738 = !{!197, !846, !197, null}
