; ModuleID = 'kmp/kmp/kmp_opt.bc'
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
@.str.1.15 = private unnamed_addr constant [57 x i8] c"argc<4 && \22Usage: ./benchmark <input_file> <check_file>\22\00", align 1, !dbg !168
@.str.2.16 = private unnamed_addr constant [23 x i8] c"../../common/harness.c\00", align 1, !dbg !174
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1, !dbg !176
@.str.3 = private unnamed_addr constant [11 x i8] c"input.data\00", align 1, !dbg !179
@.str.4.17 = private unnamed_addr constant [11 x i8] c"check.data\00", align 1, !dbg !184
@INPUT_SIZE = dso_local local_unnamed_addr global i32 32436, align 4, !dbg !186
@.str.6.18 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !212
@.str.8.19 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !215
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !218
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !223
@.str.12.20 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !226
@.str.14.21 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !228
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !231
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @CPF(ptr nocapture noundef readonly %pattern, ptr nocapture noundef %kmpNext) local_unnamed_addr #0 !dbg !330 {
entry.split:
  %k.1.lcssa.reg2mem = alloca i32, align 4
  %k.136.reg2mem14 = alloca i32, align 4
  %k.038.reg2mem16 = alloca i32, align 4
  %indvars.iv.reg2mem18 = alloca i64, align 8
    #dbg_value(ptr %pattern, !335, !DIExpression(), !344)
    #dbg_value(ptr %kmpNext, !336, !DIExpression(), !344)
    #dbg_value(i32 0, !337, !DIExpression(), !344)
  store i32 0, ptr %kmpNext, align 4, !dbg !345, !tbaa !346
    #dbg_label(!339, !350)
    #dbg_value(i32 1, !338, !DIExpression(), !344)
  store i32 0, ptr %k.038.reg2mem16, align 4
  store i64 1, ptr %indvars.iv.reg2mem18, align 8
  br label %while.cond.preheader, !dbg !351

while.cond.preheader:                             ; preds = %while.end.while.cond.preheader_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv.reg2mem18.0.load, !338, !DIExpression(), !344)
    #dbg_value(i32 %k.038.reg2mem16.0.load, !337, !DIExpression(), !344)
  %indvars.iv.reg2mem18.0.load = load i64, ptr %indvars.iv.reg2mem18, align 8
  %k.038.reg2mem16.0.load = load i32, ptr %k.038.reg2mem16, align 4
  %cmp135 = icmp sgt i32 %k.038.reg2mem16.0.load, 0, !dbg !352
  %arrayidx4 = getelementptr inbounds i8, ptr %pattern, i64 %indvars.iv.reg2mem18.0.load
  %0 = load i8, ptr %arrayidx4, align 1
  br i1 %cmp135, label %land.rhs.lr.ph, label %while.cond.preheader.while.end_crit_edge, !dbg !353

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 %k.038.reg2mem16.0.load, ptr %k.1.lcssa.reg2mem, align 4
  br label %while.end, !dbg !353

land.rhs.lr.ph:                                   ; preds = %while.cond.preheader
  %arrayidx9 = getelementptr inbounds i32, ptr %kmpNext, i64 %indvars.iv.reg2mem18.0.load
  store i32 %k.038.reg2mem16.0.load, ptr %k.136.reg2mem14, align 4
  br label %land.rhs, !dbg !353

land.rhs:                                         ; preds = %while.body.land.rhs_crit_edge, %land.rhs.lr.ph
    #dbg_value(i32 %k.136.reg2mem14.0.load, !337, !DIExpression(), !344)
  %k.136.reg2mem14.0.load = load i32, ptr %k.136.reg2mem14, align 4
  %idxprom = zext nneg i32 %k.136.reg2mem14.0.load to i64
  %arrayidx2 = getelementptr inbounds i8, ptr %pattern, i64 %idxprom, !dbg !354
  %1 = load i8, ptr %arrayidx2, align 1, !dbg !354, !tbaa !355
  %cmp6.not = icmp eq i8 %1, %0, !dbg !356
  br i1 %cmp6.not, label %land.rhs.while.end_crit_edge, label %while.body, !dbg !357

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store i32 %k.136.reg2mem14.0.load, ptr %k.1.lcssa.reg2mem, align 4
  br label %while.end, !dbg !357

while.body:                                       ; preds = %land.rhs
  %2 = load i32, ptr %arrayidx9, align 4, !dbg !358
    #dbg_value(i32 %2, !337, !DIExpression(), !344)
  %cmp1 = icmp sgt i32 %2, 0, !dbg !352
  br i1 %cmp1, label %while.body.land.rhs_crit_edge, label %while.body.while.end_crit_edge, !dbg !353, !llvm.loop !360

while.body.while.end_crit_edge:                   ; preds = %while.body
  store i32 %2, ptr %k.1.lcssa.reg2mem, align 4
  br label %while.end, !dbg !353

while.body.land.rhs_crit_edge:                    ; preds = %while.body
  store i32 %2, ptr %k.136.reg2mem14, align 4
  br label %land.rhs, !dbg !353

while.end:                                        ; preds = %while.body.while.end_crit_edge, %land.rhs.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %k.1.lcssa.reg2mem.0.load = load i32, ptr %k.1.lcssa.reg2mem, align 4
  %idxprom10 = sext i32 %k.1.lcssa.reg2mem.0.load to i64, !dbg !364
  %arrayidx11 = getelementptr inbounds i8, ptr %pattern, i64 %idxprom10, !dbg !364
  %3 = load i8, ptr %arrayidx11, align 1, !dbg !364, !tbaa !355
  %cmp16 = icmp eq i8 %3, %0, !dbg !366
  %inc = zext i1 %cmp16 to i32, !dbg !367
  %spec.select = add nsw i32 %k.1.lcssa.reg2mem.0.load, %inc, !dbg !367
    #dbg_value(i32 %spec.select, !337, !DIExpression(), !344)
  %arrayidx19 = getelementptr inbounds i32, ptr %kmpNext, i64 %indvars.iv.reg2mem18.0.load, !dbg !368
  store i32 %spec.select, ptr %arrayidx19, align 4, !dbg !369, !tbaa !346
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem18.0.load, 1, !dbg !370
    #dbg_value(i64 %indvars.iv.next, !338, !DIExpression(), !344)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 4, !dbg !371
  br i1 %exitcond.not, label %for.end, label %while.end.while.cond.preheader_crit_edge, !dbg !351, !llvm.loop !372

while.end.while.cond.preheader_crit_edge:         ; preds = %while.end
  store i32 %spec.select, ptr %k.038.reg2mem16, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem18, align 8
  br label %while.cond.preheader, !dbg !351

for.end:                                          ; preds = %while.end
  ret void, !dbg !374
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local noundef signext i32 @kmp(ptr nocapture noundef readonly %pattern, ptr nocapture noundef readonly %input, ptr nocapture noundef %kmpNext, ptr nocapture noundef %n_matches) local_unnamed_addr #0 !dbg !375 {
entry.split:
  %q.3.reg2mem34 = alloca i32, align 4
  %q.1.lcssa.reg2mem = alloca i32, align 4
  %q.143.reg2mem36 = alloca i32, align 4
  %q.046.reg2mem38 = alloca i32, align 4
  %indvars.iv.reg2mem40 = alloca i64, align 8
  %k.1.lcssa.i.reg2mem = alloca i32, align 4
  %k.136.i.reg2mem42 = alloca i32, align 4
  %k.038.i.reg2mem44 = alloca i32, align 4
  %indvars.iv.i.reg2mem46 = alloca i64, align 8
    #dbg_value(ptr %pattern, !379, !DIExpression(), !390)
    #dbg_value(ptr %input, !380, !DIExpression(), !390)
    #dbg_value(ptr %kmpNext, !381, !DIExpression(), !390)
    #dbg_value(ptr %n_matches, !382, !DIExpression(), !390)
  store i32 0, ptr %n_matches, align 4, !dbg !391, !tbaa !346
    #dbg_value(ptr %pattern, !335, !DIExpression(), !392)
    #dbg_value(ptr %kmpNext, !336, !DIExpression(), !392)
    #dbg_value(i32 0, !337, !DIExpression(), !392)
  store i32 0, ptr %kmpNext, align 4, !dbg !394, !tbaa !346
    #dbg_label(!339, !395)
    #dbg_value(i32 1, !338, !DIExpression(), !392)
  store i32 0, ptr %k.038.i.reg2mem44, align 4
  store i64 1, ptr %indvars.iv.i.reg2mem46, align 8
  br label %while.cond.preheader.i, !dbg !396

while.cond.preheader.i:                           ; preds = %while.end.i.while.cond.preheader.i_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv.i.reg2mem46.0.load, !338, !DIExpression(), !392)
    #dbg_value(i32 %k.038.i.reg2mem44.0.load, !337, !DIExpression(), !392)
  %indvars.iv.i.reg2mem46.0.load = load i64, ptr %indvars.iv.i.reg2mem46, align 8
  %k.038.i.reg2mem44.0.load = load i32, ptr %k.038.i.reg2mem44, align 4
  %cmp135.i = icmp sgt i32 %k.038.i.reg2mem44.0.load, 0, !dbg !397
  %arrayidx4.i = getelementptr inbounds i8, ptr %pattern, i64 %indvars.iv.i.reg2mem46.0.load
  %0 = load i8, ptr %arrayidx4.i, align 1
  br i1 %cmp135.i, label %land.rhs.lr.ph.i, label %while.cond.preheader.i.while.end.i_crit_edge, !dbg !398

while.cond.preheader.i.while.end.i_crit_edge:     ; preds = %while.cond.preheader.i
  store i32 %k.038.i.reg2mem44.0.load, ptr %k.1.lcssa.i.reg2mem, align 4
  br label %while.end.i, !dbg !398

land.rhs.lr.ph.i:                                 ; preds = %while.cond.preheader.i
  %arrayidx9.i = getelementptr inbounds i32, ptr %kmpNext, i64 %indvars.iv.i.reg2mem46.0.load
  store i32 %k.038.i.reg2mem44.0.load, ptr %k.136.i.reg2mem42, align 4
  br label %land.rhs.i, !dbg !398

land.rhs.i:                                       ; preds = %while.body.i.land.rhs.i_crit_edge, %land.rhs.lr.ph.i
    #dbg_value(i32 %k.136.i.reg2mem42.0.load, !337, !DIExpression(), !392)
  %k.136.i.reg2mem42.0.load = load i32, ptr %k.136.i.reg2mem42, align 4
  %idxprom.i = zext nneg i32 %k.136.i.reg2mem42.0.load to i64
  %arrayidx2.i = getelementptr inbounds i8, ptr %pattern, i64 %idxprom.i, !dbg !399
  %1 = load i8, ptr %arrayidx2.i, align 1, !dbg !399, !tbaa !355
  %cmp6.not.i = icmp eq i8 %1, %0, !dbg !400
  br i1 %cmp6.not.i, label %land.rhs.i.while.end.i_crit_edge, label %while.body.i, !dbg !401

land.rhs.i.while.end.i_crit_edge:                 ; preds = %land.rhs.i
  store i32 %k.136.i.reg2mem42.0.load, ptr %k.1.lcssa.i.reg2mem, align 4
  br label %while.end.i, !dbg !401

while.body.i:                                     ; preds = %land.rhs.i
  %2 = load i32, ptr %arrayidx9.i, align 4, !dbg !402
    #dbg_value(i32 %2, !337, !DIExpression(), !392)
  %cmp1.i = icmp sgt i32 %2, 0, !dbg !397
  br i1 %cmp1.i, label %while.body.i.land.rhs.i_crit_edge, label %while.body.i.while.end.i_crit_edge, !dbg !398, !llvm.loop !403

while.body.i.while.end.i_crit_edge:               ; preds = %while.body.i
  store i32 %2, ptr %k.1.lcssa.i.reg2mem, align 4
  br label %while.end.i, !dbg !398

while.body.i.land.rhs.i_crit_edge:                ; preds = %while.body.i
  store i32 %2, ptr %k.136.i.reg2mem42, align 4
  br label %land.rhs.i, !dbg !398

while.end.i:                                      ; preds = %while.body.i.while.end.i_crit_edge, %land.rhs.i.while.end.i_crit_edge, %while.cond.preheader.i.while.end.i_crit_edge
  %k.1.lcssa.i.reg2mem.0.load = load i32, ptr %k.1.lcssa.i.reg2mem, align 4
  %idxprom10.i = sext i32 %k.1.lcssa.i.reg2mem.0.load to i64, !dbg !405
  %arrayidx11.i = getelementptr inbounds i8, ptr %pattern, i64 %idxprom10.i, !dbg !405
  %3 = load i8, ptr %arrayidx11.i, align 1, !dbg !405, !tbaa !355
  %cmp16.i = icmp eq i8 %3, %0, !dbg !406
  %inc.i = zext i1 %cmp16.i to i32, !dbg !407
  %spec.select.i = add nsw i32 %k.1.lcssa.i.reg2mem.0.load, %inc.i, !dbg !407
    #dbg_value(i32 %spec.select.i, !337, !DIExpression(), !392)
  %arrayidx19.i = getelementptr inbounds i32, ptr %kmpNext, i64 %indvars.iv.i.reg2mem46.0.load, !dbg !408
  store i32 %spec.select.i, ptr %arrayidx19.i, align 4, !dbg !409, !tbaa !346
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem46.0.load, 1, !dbg !410
    #dbg_value(i64 %indvars.iv.next.i, !338, !DIExpression(), !392)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 4, !dbg !411
  br i1 %exitcond.not.i, label %for.cond.preheader, label %while.end.i.while.cond.preheader.i_crit_edge, !dbg !396, !llvm.loop !412

while.end.i.while.cond.preheader.i_crit_edge:     ; preds = %while.end.i
  store i32 %spec.select.i, ptr %k.038.i.reg2mem44, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem46, align 8
  br label %while.cond.preheader.i, !dbg !396

for.cond.preheader:                               ; preds = %while.end.i
  %invariant.gep = getelementptr i8, ptr %kmpNext, i64 -4, !dbg !414
    #dbg_value(i32 0, !384, !DIExpression(), !390)
    #dbg_value(i32 0, !383, !DIExpression(), !390)
  store i32 0, ptr %q.046.reg2mem38, align 4
  store i64 0, ptr %indvars.iv.reg2mem40, align 8
  br label %while.cond.preheader, !dbg !414

while.cond.preheader:                             ; preds = %for.inc.while.cond.preheader_crit_edge, %for.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem40.0.load, !383, !DIExpression(), !390)
    #dbg_value(i32 %q.046.reg2mem38.0.load, !384, !DIExpression(), !390)
  %indvars.iv.reg2mem40.0.load = load i64, ptr %indvars.iv.reg2mem40, align 8
  %q.046.reg2mem38.0.load = load i32, ptr %q.046.reg2mem38, align 4
  %cmp142 = icmp sgt i32 %q.046.reg2mem38.0.load, 0, !dbg !415
  %arrayidx4 = getelementptr inbounds i8, ptr %input, i64 %indvars.iv.reg2mem40.0.load
  %4 = load i8, ptr %arrayidx4, align 1
  br i1 %cmp142, label %while.cond.preheader.land.rhs_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !416

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 %q.046.reg2mem38.0.load, ptr %q.1.lcssa.reg2mem, align 4
  br label %while.end, !dbg !416

while.cond.preheader.land.rhs_crit_edge:          ; preds = %while.cond.preheader
  store i32 %q.046.reg2mem38.0.load, ptr %q.143.reg2mem36, align 4
  br label %land.rhs, !dbg !416

land.rhs:                                         ; preds = %while.body.land.rhs_crit_edge, %while.cond.preheader.land.rhs_crit_edge
    #dbg_value(i32 %q.143.reg2mem36.0.load, !384, !DIExpression(), !390)
  %q.143.reg2mem36.0.load = load i32, ptr %q.143.reg2mem36, align 4
  %idxprom = zext nneg i32 %q.143.reg2mem36.0.load to i64
  %arrayidx2 = getelementptr inbounds i8, ptr %pattern, i64 %idxprom, !dbg !417
  %5 = load i8, ptr %arrayidx2, align 1, !dbg !417, !tbaa !355
  %cmp6.not = icmp eq i8 %5, %4, !dbg !418
  br i1 %cmp6.not, label %land.rhs.while.end_crit_edge, label %while.body, !dbg !419

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store i32 %q.143.reg2mem36.0.load, ptr %q.1.lcssa.reg2mem, align 4
  br label %while.end, !dbg !419

while.body:                                       ; preds = %land.rhs
  %arrayidx9 = getelementptr inbounds i32, ptr %kmpNext, i64 %idxprom, !dbg !420
  %6 = load i32, ptr %arrayidx9, align 4, !dbg !420
    #dbg_value(i32 %6, !384, !DIExpression(), !390)
  %cmp1 = icmp sgt i32 %6, 0, !dbg !415
  br i1 %cmp1, label %while.body.land.rhs_crit_edge, label %while.body.while.end_crit_edge, !dbg !416, !llvm.loop !422

while.body.while.end_crit_edge:                   ; preds = %while.body
  store i32 %6, ptr %q.1.lcssa.reg2mem, align 4
  br label %while.end, !dbg !416

while.body.land.rhs_crit_edge:                    ; preds = %while.body
  store i32 %6, ptr %q.143.reg2mem36, align 4
  br label %land.rhs, !dbg !416

while.end:                                        ; preds = %while.body.while.end_crit_edge, %land.rhs.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %q.1.lcssa.reg2mem.0.load = load i32, ptr %q.1.lcssa.reg2mem, align 4
  %idxprom10 = sext i32 %q.1.lcssa.reg2mem.0.load to i64, !dbg !424
  %arrayidx11 = getelementptr inbounds i8, ptr %pattern, i64 %idxprom10, !dbg !424
  %7 = load i8, ptr %arrayidx11, align 1, !dbg !424, !tbaa !355
  %cmp16 = icmp eq i8 %7, %4, !dbg !426
  %inc = zext i1 %cmp16 to i32, !dbg !427
  %spec.select = add nsw i32 %q.1.lcssa.reg2mem.0.load, %inc, !dbg !427
    #dbg_value(i32 %spec.select, !384, !DIExpression(), !390)
  %cmp18 = icmp sgt i32 %spec.select, 3, !dbg !428
  br i1 %cmp18, label %if.then20, label %while.end.for.inc_crit_edge, !dbg !430

while.end.for.inc_crit_edge:                      ; preds = %while.end
  store i32 %spec.select, ptr %q.3.reg2mem34, align 4
  br label %for.inc, !dbg !430

if.then20:                                        ; preds = %while.end
  %8 = load i32, ptr %n_matches, align 4, !dbg !431, !tbaa !346
  %inc22 = add nsw i32 %8, 1, !dbg !431
  store i32 %inc22, ptr %n_matches, align 4, !dbg !431, !tbaa !346
  %9 = zext nneg i32 %spec.select to i64, !dbg !433
  %gep = getelementptr i32, ptr %invariant.gep, i64 %9, !dbg !433
  %10 = load i32, ptr %gep, align 4, !dbg !433
    #dbg_value(i32 %10, !384, !DIExpression(), !390)
  store i32 %10, ptr %q.3.reg2mem34, align 4
  br label %for.inc, !dbg !434

for.inc:                                          ; preds = %while.end.for.inc_crit_edge, %if.then20
    #dbg_value(i32 %q.3.reg2mem34.0.load, !384, !DIExpression(), !390)
  %q.3.reg2mem34.0.load = load i32, ptr %q.3.reg2mem34, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem40.0.load, 1, !dbg !435
    #dbg_value(i64 %indvars.iv.next, !383, !DIExpression(), !390)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 32411, !dbg !436
  br i1 %exitcond.not, label %for.end, label %for.inc.while.cond.preheader_crit_edge, !dbg !414, !llvm.loop !437

for.inc.while.cond.preheader_crit_edge:           ; preds = %for.inc
  store i32 %q.3.reg2mem34.0.load, ptr %q.046.reg2mem38, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem40, align 8
  br label %while.cond.preheader, !dbg !414

for.end:                                          ; preds = %for.inc
  ret i32 0, !dbg !439
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #0 !dbg !440 {
entry.split:
  %q.3.i.reg2mem36 = alloca i32, align 4
  %q.1.lcssa.i.reg2mem = alloca i32, align 4
  %q.143.i.reg2mem38 = alloca i32, align 4
  %q.046.i.reg2mem40 = alloca i32, align 4
  %indvars.iv.i.reg2mem42 = alloca i64, align 8
  %k.1.lcssa.i.i.reg2mem = alloca i32, align 4
  %k.136.i.i.reg2mem44 = alloca i32, align 4
  %k.038.i.i.reg2mem46 = alloca i32, align 4
  %indvars.iv.i.i.reg2mem48 = alloca i64, align 8
    #dbg_value(ptr %vargs, !444, !DIExpression(), !446)
    #dbg_value(ptr %vargs, !445, !DIExpression(), !446)
  %kmpNext = getelementptr inbounds i8, ptr %vargs, i64 32416, !dbg !447
  %n_matches = getelementptr inbounds i8, ptr %vargs, i64 32432, !dbg !448
    #dbg_value(ptr %vargs, !379, !DIExpression(), !449)
    #dbg_value(ptr %input, !380, !DIExpression(), !449)
    #dbg_value(ptr %kmpNext, !381, !DIExpression(), !449)
    #dbg_value(ptr %n_matches, !382, !DIExpression(), !449)
  store i32 0, ptr %n_matches, align 4, !dbg !451, !tbaa !346
    #dbg_value(ptr %vargs, !335, !DIExpression(), !452)
    #dbg_value(ptr %kmpNext, !336, !DIExpression(), !452)
    #dbg_value(i32 0, !337, !DIExpression(), !452)
  store i32 0, ptr %kmpNext, align 4, !dbg !454, !tbaa !346
    #dbg_label(!339, !455)
    #dbg_value(i32 1, !338, !DIExpression(), !452)
  store i32 0, ptr %k.038.i.i.reg2mem46, align 4
  store i64 1, ptr %indvars.iv.i.i.reg2mem48, align 8
  br label %while.cond.preheader.i.i, !dbg !456

while.cond.preheader.i.i:                         ; preds = %while.end.i.i.while.cond.preheader.i.i_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv.i.i.reg2mem48.0.load, !338, !DIExpression(), !452)
    #dbg_value(i32 %k.038.i.i.reg2mem46.0.load, !337, !DIExpression(), !452)
  %indvars.iv.i.i.reg2mem48.0.load = load i64, ptr %indvars.iv.i.i.reg2mem48, align 8
  %k.038.i.i.reg2mem46.0.load = load i32, ptr %k.038.i.i.reg2mem46, align 4
  %cmp135.i.i = icmp sgt i32 %k.038.i.i.reg2mem46.0.load, 0, !dbg !457
  %arrayidx4.i.i = getelementptr inbounds i8, ptr %vargs, i64 %indvars.iv.i.i.reg2mem48.0.load
  %0 = load i8, ptr %arrayidx4.i.i, align 1
  br i1 %cmp135.i.i, label %land.rhs.lr.ph.i.i, label %while.cond.preheader.i.i.while.end.i.i_crit_edge, !dbg !458

while.cond.preheader.i.i.while.end.i.i_crit_edge: ; preds = %while.cond.preheader.i.i
  store i32 %k.038.i.i.reg2mem46.0.load, ptr %k.1.lcssa.i.i.reg2mem, align 4
  br label %while.end.i.i, !dbg !458

land.rhs.lr.ph.i.i:                               ; preds = %while.cond.preheader.i.i
  %arrayidx9.i.i = getelementptr inbounds i32, ptr %kmpNext, i64 %indvars.iv.i.i.reg2mem48.0.load
  store i32 %k.038.i.i.reg2mem46.0.load, ptr %k.136.i.i.reg2mem44, align 4
  br label %land.rhs.i.i, !dbg !458

land.rhs.i.i:                                     ; preds = %while.body.i.i.land.rhs.i.i_crit_edge, %land.rhs.lr.ph.i.i
    #dbg_value(i32 %k.136.i.i.reg2mem44.0.load, !337, !DIExpression(), !452)
  %k.136.i.i.reg2mem44.0.load = load i32, ptr %k.136.i.i.reg2mem44, align 4
  %idxprom.i.i = zext nneg i32 %k.136.i.i.reg2mem44.0.load to i64
  %arrayidx2.i.i = getelementptr inbounds i8, ptr %vargs, i64 %idxprom.i.i, !dbg !459
  %1 = load i8, ptr %arrayidx2.i.i, align 1, !dbg !459, !tbaa !355
  %cmp6.not.i.i = icmp eq i8 %1, %0, !dbg !460
  br i1 %cmp6.not.i.i, label %land.rhs.i.i.while.end.i.i_crit_edge, label %while.body.i.i, !dbg !461

land.rhs.i.i.while.end.i.i_crit_edge:             ; preds = %land.rhs.i.i
  store i32 %k.136.i.i.reg2mem44.0.load, ptr %k.1.lcssa.i.i.reg2mem, align 4
  br label %while.end.i.i, !dbg !461

while.body.i.i:                                   ; preds = %land.rhs.i.i
  %2 = load i32, ptr %arrayidx9.i.i, align 4, !dbg !462
    #dbg_value(i32 %2, !337, !DIExpression(), !452)
  %cmp1.i.i = icmp sgt i32 %2, 0, !dbg !457
  br i1 %cmp1.i.i, label %while.body.i.i.land.rhs.i.i_crit_edge, label %while.body.i.i.while.end.i.i_crit_edge, !dbg !458, !llvm.loop !463

while.body.i.i.while.end.i.i_crit_edge:           ; preds = %while.body.i.i
  store i32 %2, ptr %k.1.lcssa.i.i.reg2mem, align 4
  br label %while.end.i.i, !dbg !458

while.body.i.i.land.rhs.i.i_crit_edge:            ; preds = %while.body.i.i
  store i32 %2, ptr %k.136.i.i.reg2mem44, align 4
  br label %land.rhs.i.i, !dbg !458

while.end.i.i:                                    ; preds = %while.body.i.i.while.end.i.i_crit_edge, %land.rhs.i.i.while.end.i.i_crit_edge, %while.cond.preheader.i.i.while.end.i.i_crit_edge
  %k.1.lcssa.i.i.reg2mem.0.load = load i32, ptr %k.1.lcssa.i.i.reg2mem, align 4
  %idxprom10.i.i = sext i32 %k.1.lcssa.i.i.reg2mem.0.load to i64, !dbg !465
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %vargs, i64 %idxprom10.i.i, !dbg !465
  %3 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !465, !tbaa !355
  %cmp16.i.i = icmp eq i8 %3, %0, !dbg !466
  %inc.i.i = zext i1 %cmp16.i.i to i32, !dbg !467
  %spec.select.i.i = add nsw i32 %k.1.lcssa.i.i.reg2mem.0.load, %inc.i.i, !dbg !467
    #dbg_value(i32 %spec.select.i.i, !337, !DIExpression(), !452)
  %arrayidx19.i.i = getelementptr inbounds i32, ptr %kmpNext, i64 %indvars.iv.i.i.reg2mem48.0.load, !dbg !468
  store i32 %spec.select.i.i, ptr %arrayidx19.i.i, align 4, !dbg !469, !tbaa !346
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem48.0.load, 1, !dbg !470
    #dbg_value(i64 %indvars.iv.next.i.i, !338, !DIExpression(), !452)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 4, !dbg !471
  br i1 %exitcond.not.i.i, label %for.cond.preheader.i, label %while.end.i.i.while.cond.preheader.i.i_crit_edge, !dbg !456, !llvm.loop !472

while.end.i.i.while.cond.preheader.i.i_crit_edge: ; preds = %while.end.i.i
  store i32 %spec.select.i.i, ptr %k.038.i.i.reg2mem46, align 4
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem48, align 8
  br label %while.cond.preheader.i.i, !dbg !456

for.cond.preheader.i:                             ; preds = %while.end.i.i
  %input = getelementptr inbounds i8, ptr %vargs, i64 4, !dbg !474
  %invariant.gep.i = getelementptr i8, ptr %vargs, i64 32412, !dbg !475
    #dbg_value(i32 0, !384, !DIExpression(), !449)
    #dbg_value(i32 0, !383, !DIExpression(), !449)
  store i32 0, ptr %q.046.i.reg2mem40, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem42, align 8
  br label %while.cond.preheader.i, !dbg !475

while.cond.preheader.i:                           ; preds = %for.inc.i.while.cond.preheader.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem42.0.load, !383, !DIExpression(), !449)
    #dbg_value(i32 %q.046.i.reg2mem40.0.load, !384, !DIExpression(), !449)
  %indvars.iv.i.reg2mem42.0.load = load i64, ptr %indvars.iv.i.reg2mem42, align 8
  %q.046.i.reg2mem40.0.load = load i32, ptr %q.046.i.reg2mem40, align 4
  %cmp142.i = icmp sgt i32 %q.046.i.reg2mem40.0.load, 0, !dbg !476
  %arrayidx4.i = getelementptr inbounds i8, ptr %input, i64 %indvars.iv.i.reg2mem42.0.load
  %4 = load i8, ptr %arrayidx4.i, align 1
  br i1 %cmp142.i, label %while.cond.preheader.i.land.rhs.i_crit_edge, label %while.cond.preheader.i.while.end.i_crit_edge, !dbg !477

while.cond.preheader.i.while.end.i_crit_edge:     ; preds = %while.cond.preheader.i
  store i32 %q.046.i.reg2mem40.0.load, ptr %q.1.lcssa.i.reg2mem, align 4
  br label %while.end.i, !dbg !477

while.cond.preheader.i.land.rhs.i_crit_edge:      ; preds = %while.cond.preheader.i
  store i32 %q.046.i.reg2mem40.0.load, ptr %q.143.i.reg2mem38, align 4
  br label %land.rhs.i, !dbg !477

land.rhs.i:                                       ; preds = %while.body.i.land.rhs.i_crit_edge, %while.cond.preheader.i.land.rhs.i_crit_edge
    #dbg_value(i32 %q.143.i.reg2mem38.0.load, !384, !DIExpression(), !449)
  %q.143.i.reg2mem38.0.load = load i32, ptr %q.143.i.reg2mem38, align 4
  %idxprom.i = zext nneg i32 %q.143.i.reg2mem38.0.load to i64
  %arrayidx2.i = getelementptr inbounds i8, ptr %vargs, i64 %idxprom.i, !dbg !478
  %5 = load i8, ptr %arrayidx2.i, align 1, !dbg !478, !tbaa !355
  %cmp6.not.i = icmp eq i8 %5, %4, !dbg !479
  br i1 %cmp6.not.i, label %land.rhs.i.while.end.i_crit_edge, label %while.body.i, !dbg !480

land.rhs.i.while.end.i_crit_edge:                 ; preds = %land.rhs.i
  store i32 %q.143.i.reg2mem38.0.load, ptr %q.1.lcssa.i.reg2mem, align 4
  br label %while.end.i, !dbg !480

while.body.i:                                     ; preds = %land.rhs.i
  %arrayidx9.i = getelementptr inbounds i32, ptr %kmpNext, i64 %idxprom.i, !dbg !481
  %6 = load i32, ptr %arrayidx9.i, align 4, !dbg !481
    #dbg_value(i32 %6, !384, !DIExpression(), !449)
  %cmp1.i = icmp sgt i32 %6, 0, !dbg !476
  br i1 %cmp1.i, label %while.body.i.land.rhs.i_crit_edge, label %while.body.i.while.end.i_crit_edge, !dbg !477, !llvm.loop !482

while.body.i.while.end.i_crit_edge:               ; preds = %while.body.i
  store i32 %6, ptr %q.1.lcssa.i.reg2mem, align 4
  br label %while.end.i, !dbg !477

while.body.i.land.rhs.i_crit_edge:                ; preds = %while.body.i
  store i32 %6, ptr %q.143.i.reg2mem38, align 4
  br label %land.rhs.i, !dbg !477

while.end.i:                                      ; preds = %while.body.i.while.end.i_crit_edge, %land.rhs.i.while.end.i_crit_edge, %while.cond.preheader.i.while.end.i_crit_edge
  %q.1.lcssa.i.reg2mem.0.load = load i32, ptr %q.1.lcssa.i.reg2mem, align 4
  %idxprom10.i = sext i32 %q.1.lcssa.i.reg2mem.0.load to i64, !dbg !484
  %arrayidx11.i = getelementptr inbounds i8, ptr %vargs, i64 %idxprom10.i, !dbg !484
  %7 = load i8, ptr %arrayidx11.i, align 1, !dbg !484, !tbaa !355
  %cmp16.i = icmp eq i8 %7, %4, !dbg !485
  %inc.i = zext i1 %cmp16.i to i32, !dbg !486
  %spec.select.i = add nsw i32 %q.1.lcssa.i.reg2mem.0.load, %inc.i, !dbg !486
    #dbg_value(i32 %spec.select.i, !384, !DIExpression(), !449)
  %cmp18.i = icmp sgt i32 %spec.select.i, 3, !dbg !487
  br i1 %cmp18.i, label %if.then20.i, label %while.end.i.for.inc.i_crit_edge, !dbg !488

while.end.i.for.inc.i_crit_edge:                  ; preds = %while.end.i
  store i32 %spec.select.i, ptr %q.3.i.reg2mem36, align 4
  br label %for.inc.i, !dbg !488

if.then20.i:                                      ; preds = %while.end.i
  %8 = load i32, ptr %n_matches, align 4, !dbg !489, !tbaa !346
  %inc22.i = add nsw i32 %8, 1, !dbg !489
  store i32 %inc22.i, ptr %n_matches, align 4, !dbg !489, !tbaa !346
  %9 = zext nneg i32 %spec.select.i to i64, !dbg !490
  %gep.i = getelementptr i32, ptr %invariant.gep.i, i64 %9, !dbg !490
  %10 = load i32, ptr %gep.i, align 4, !dbg !490
    #dbg_value(i32 %10, !384, !DIExpression(), !449)
  store i32 %10, ptr %q.3.i.reg2mem36, align 4
  br label %for.inc.i, !dbg !491

for.inc.i:                                        ; preds = %while.end.i.for.inc.i_crit_edge, %if.then20.i
    #dbg_value(i32 %q.3.i.reg2mem36.0.load, !384, !DIExpression(), !449)
  %q.3.i.reg2mem36.0.load = load i32, ptr %q.3.i.reg2mem36, align 4
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem42.0.load, 1, !dbg !492
    #dbg_value(i64 %indvars.iv.next.i, !383, !DIExpression(), !449)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 32411, !dbg !493
  br i1 %exitcond.not.i, label %kmp.exit, label %for.inc.i.while.cond.preheader.i_crit_edge, !dbg !475, !llvm.loop !494

for.inc.i.while.cond.preheader.i_crit_edge:       ; preds = %for.inc.i
  store i32 %q.3.i.reg2mem36.0.load, ptr %q.046.i.reg2mem40, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem42, align 8
  br label %while.cond.preheader.i, !dbg !475

kmp.exit:                                         ; preds = %for.inc.i
  ret void, !dbg !496
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !497 {
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
    #dbg_value(i32 %fd, !501, !DIExpression(), !506)
    #dbg_value(ptr %vdata, !502, !DIExpression(), !506)
    #dbg_value(ptr %vdata, !503, !DIExpression(), !506)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(32436) %vdata, i8 0, i64 32436, i1 false), !dbg !507
  %call = tail call ptr @readfile(i32 noundef signext %fd) #17, !dbg !508
    #dbg_value(ptr %call, !504, !DIExpression(), !506)
    #dbg_value(ptr %call, !509, !DIExpression(), !516)
    #dbg_value(i32 1, !514, !DIExpression(), !516)
    #dbg_value(i32 0, !515, !DIExpression(), !516)
  store ptr %call, ptr %s.addr.040.i.reg2mem73, align 8
  store i32 0, ptr %i.041.i.reg2mem75, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem75.0.load, !515, !DIExpression(), !516)
    #dbg_value(ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, !509, !DIExpression(), !516)
  %i.041.i.reg2mem75.0.load = load i32, ptr %i.041.i.reg2mem75, align 4
  %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74 = load ptr, ptr %s.addr.040.i.reg2mem73, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, align 1, !dbg !518, !tbaa !355
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.parse_string.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !519

land.rhs.i.parse_string.exit_crit_edge:           ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %parse_string.exit, !dbg !519

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem75.0.load, ptr %i.1.i.reg2mem71, align 4
  br label %if.end21.i, !dbg !519

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, i64 1, !dbg !520
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !520, !tbaa !355
  %cmp13.i = icmp eq i8 %1, 37, !dbg !523
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !524

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem75.0.load, ptr %i.1.i.reg2mem71, align 4
  br label %if.end21.i, !dbg !524

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, i64 2, !dbg !525
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !525, !tbaa !355
  %cmp18.i = icmp eq i8 %2, 10, !dbg !526
  %inc.i = zext i1 %cmp18.i to i32, !dbg !527
  %spec.select.i = add nsw i32 %i.041.i.reg2mem75.0.load, %inc.i, !dbg !527
  store i32 %spec.select.i, ptr %i.1.i.reg2mem71, align 4
  br label %if.end21.i, !dbg !527

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem71.0.load, !515, !DIExpression(), !516)
  %i.1.i.reg2mem71.0.load = load i32, ptr %i.1.i.reg2mem71, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem73.0.s.addr.040.i.reload74, i64 1, !dbg !528
    #dbg_value(ptr %incdec.ptr.i, !509, !DIExpression(), !516)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem71.0.load, 1, !dbg !529
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !530, !llvm.loop !531

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem73, align 8
  store i32 %i.1.i.reg2mem71.0.load, ptr %i.041.i.reg2mem75, align 4
  br label %land.rhs.i, !dbg !530

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !533, !tbaa !355
  %3 = icmp eq i8 %.pre.i, 0, !dbg !535
  %4 = select i1 %3, i64 0, i64 2, !dbg !536
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %parse_string.exit, !dbg !530

parse_string.exit:                                ; preds = %land.rhs.i.parse_string.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !536
    #dbg_value(ptr %spec.select38.i, !505, !DIExpression(), !506)
    #dbg_value(ptr %spec.select38.i, !537, !DIExpression(), !545)
    #dbg_value(ptr %vdata, !542, !DIExpression(), !545)
    #dbg_value(i32 4, !543, !DIExpression(), !545)
    #dbg_value(i32 4, !544, !DIExpression(), !545)
  %5 = load i32, ptr %spec.select38.i, align 1, !dbg !547
  store i32 %5, ptr %vdata, align 1, !dbg !547
    #dbg_value(ptr %call, !509, !DIExpression(), !548)
    #dbg_value(i32 2, !514, !DIExpression(), !548)
    #dbg_value(i32 0, !515, !DIExpression(), !548)
  store ptr %call, ptr %s.addr.040.i3.reg2mem67, align 8
  store i32 0, ptr %i.041.i2.reg2mem69, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %parse_string.exit
    #dbg_value(i32 %i.041.i2.reg2mem69.0.load, !515, !DIExpression(), !548)
    #dbg_value(ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, !509, !DIExpression(), !548)
  %i.041.i2.reg2mem69.0.load = load i32, ptr %i.041.i2.reg2mem69, align 4
  %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68 = load ptr, ptr %s.addr.040.i3.reg2mem67, align 8
  %6 = load i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, align 1, !dbg !550, !tbaa !355
  switch i8 %6, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.parse_string.exit24_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !551

land.rhs.i1.parse_string.exit24_crit_edge:        ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %parse_string.exit24, !dbg !551

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem69.0.load, ptr %i.1.i8.reg2mem65, align 4
  br label %if.end21.i7, !dbg !551

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, i64 1, !dbg !552
  %7 = load i8, ptr %arrayidx11.i5, align 1, !dbg !552, !tbaa !355
  %cmp13.i6 = icmp eq i8 %7, 37, !dbg !553
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !554

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem69.0.load, ptr %i.1.i8.reg2mem65, align 4
  br label %if.end21.i7, !dbg !554

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, i64 2, !dbg !555
  %8 = load i8, ptr %arrayidx16.i17, align 1, !dbg !555, !tbaa !355
  %cmp18.i18 = icmp eq i8 %8, 10, !dbg !556
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !557
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem69.0.load, %inc.i19, !dbg !557
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem65, align 4
  br label %if.end21.i7, !dbg !557

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem65.0.load, !515, !DIExpression(), !548)
  %i.1.i8.reg2mem65.0.load = load i32, ptr %i.1.i8.reg2mem65, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem67.0.s.addr.040.i3.reload68, i64 1, !dbg !558
    #dbg_value(ptr %incdec.ptr.i9, !509, !DIExpression(), !548)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem65.0.load, 2, !dbg !559
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !560, !llvm.loop !561

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem67, align 8
  store i32 %i.1.i8.reg2mem65.0.load, ptr %i.041.i2.reg2mem69, align 4
  br label %land.rhs.i1, !dbg !560

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !563, !tbaa !355
  %9 = icmp eq i8 %.pre.i12, 0, !dbg !564
  %10 = select i1 %9, i64 0, i64 2, !dbg !565
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %10, ptr %cmp23.not.i13.reg2mem, align 8
  br label %parse_string.exit24, !dbg !560

parse_string.exit24:                              ; preds = %land.rhs.i1.parse_string.exit24_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !565
    #dbg_value(ptr %spec.select38.i15, !505, !DIExpression(), !506)
  %input = getelementptr inbounds i8, ptr %vdata, i64 4, !dbg !566
    #dbg_value(ptr %spec.select38.i15, !537, !DIExpression(), !567)
    #dbg_value(ptr %input, !542, !DIExpression(), !567)
    #dbg_value(i32 32411, !543, !DIExpression(), !567)
    #dbg_value(i32 32411, !544, !DIExpression(), !567)
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(32411) %input, ptr noundef nonnull readonly align 1 dereferenceable(32411) %spec.select38.i15, i64 32411, i1 false), !dbg !569
  tail call void @free(ptr noundef %call) #17, !dbg !570
  ret void, !dbg !571
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !572 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !574 {
entry.split:
    #dbg_value(i32 %fd, !576, !DIExpression(), !579)
    #dbg_value(ptr %vdata, !577, !DIExpression(), !579)
    #dbg_value(ptr %vdata, !578, !DIExpression(), !579)
    #dbg_value(i32 %fd, !580, !DIExpression(), !585)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !587
  br i1 %cmp.i, label %write_section_header.exit3, label %if.else.i, !dbg !587

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #18, !dbg !587
  unreachable, !dbg !587

write_section_header.exit3:                       ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !590
  %call1 = tail call signext i32 @write_string(i32 noundef signext %fd, ptr noundef %vdata, i32 noundef signext 4) #17, !dbg !591
    #dbg_value(i32 %fd, !580, !DIExpression(), !592)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !594
  %input = getelementptr inbounds i8, ptr %vdata, i64 4, !dbg !595
  %call4 = tail call signext i32 @write_string(i32 noundef signext %fd, ptr noundef nonnull %input, i32 noundef signext 32411) #17, !dbg !596
  ret void, !dbg !597
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !598 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !600, !DIExpression(), !605)
    #dbg_value(ptr %vdata, !601, !DIExpression(), !605)
    #dbg_value(ptr %vdata, !602, !DIExpression(), !605)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(32436) %vdata, i8 0, i64 32436, i1 false), !dbg !606
  %call = tail call ptr @readfile(i32 noundef signext %fd) #17, !dbg !607
    #dbg_value(ptr %call, !603, !DIExpression(), !605)
    #dbg_value(ptr %call, !509, !DIExpression(), !608)
    #dbg_value(i32 1, !514, !DIExpression(), !608)
    #dbg_value(i32 0, !515, !DIExpression(), !608)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !515, !DIExpression(), !608)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !509, !DIExpression(), !608)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !610, !tbaa !355
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !611

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !611

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !611

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !612
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !612, !tbaa !355
  %cmp13.i = icmp eq i8 %1, 37, !dbg !613
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !614

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !614

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !615
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !615, !tbaa !355
  %cmp18.i = icmp eq i8 %2, 10, !dbg !616
  %inc.i = zext i1 %cmp18.i to i32, !dbg !617
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !617
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !617

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !515, !DIExpression(), !608)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !618
    #dbg_value(ptr %incdec.ptr.i, !509, !DIExpression(), !608)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !619
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !620, !llvm.loop !621

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !620

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !623, !tbaa !355
  %3 = icmp eq i8 %.pre.i, 0, !dbg !624
  %4 = select i1 %3, i64 0, i64 2, !dbg !625
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !620

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !625
    #dbg_value(ptr %spec.select38.i, !604, !DIExpression(), !605)
  %n_matches = getelementptr inbounds i8, ptr %vdata, i64 32432, !dbg !626
  %call2 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %n_matches, i32 noundef signext 1) #17, !dbg !627
  tail call void @free(ptr noundef %call) #17, !dbg !628
  ret void, !dbg !629
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !630 {
entry.split:
    #dbg_value(i32 %fd, !632, !DIExpression(), !635)
    #dbg_value(ptr %vdata, !633, !DIExpression(), !635)
    #dbg_value(ptr %vdata, !634, !DIExpression(), !635)
    #dbg_value(i32 %fd, !580, !DIExpression(), !636)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !638
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !638

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #18, !dbg !638
  unreachable, !dbg !638

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !639
  %n_matches = getelementptr inbounds i8, ptr %vdata, i64 32432, !dbg !640
    #dbg_value(i32 %fd, !641, !DIExpression(), !649)
    #dbg_value(ptr %n_matches, !646, !DIExpression(), !649)
    #dbg_value(i32 1, !647, !DIExpression(), !649)
    #dbg_value(i64 0, !648, !DIExpression(), !649)
  %0 = load i32, ptr %n_matches, align 4, !dbg !651, !tbaa !346
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !651
    #dbg_value(i64 1, !648, !DIExpression(), !649)
  ret void, !dbg !655
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #4 !dbg !656 {
entry.split:
    #dbg_value(ptr %vdata, !660, !DIExpression(), !665)
    #dbg_value(ptr %vref, !661, !DIExpression(), !665)
    #dbg_value(ptr %vdata, !662, !DIExpression(), !665)
    #dbg_value(ptr %vref, !663, !DIExpression(), !665)
    #dbg_value(i32 0, !664, !DIExpression(), !665)
  %n_matches = getelementptr inbounds i8, ptr %vdata, i64 32432, !dbg !666
  %0 = load i32, ptr %n_matches, align 4, !dbg !667, !tbaa !346
  %n_matches1 = getelementptr inbounds i8, ptr %vref, i64 32432, !dbg !668
  %1 = load i32, ptr %n_matches1, align 4, !dbg !669, !tbaa !346
  %cmp.not = icmp eq i32 %0, %1, !dbg !670
    #dbg_value(i1 %cmp.not, !664, !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value), !665)
  %lnot.ext = zext i1 %cmp.not to i32, !dbg !671
  ret i32 %lnot.ext, !dbg !672
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !673 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !723
    #dbg_assign(i1 undef, !679, !DIExpression(), !723, ptr %s, !DIExpression(), !724)
    #dbg_value(i32 %fd, !677, !DIExpression(), !724)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #17, !dbg !725
  %cmp = icmp sgt i32 %fd, 1, !dbg !726
  br i1 %cmp, label %if.end, label %if.else, !dbg !726

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #18, !dbg !726
  unreachable, !dbg !726

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #17, !dbg !729
  %cmp1 = icmp eq i32 %call, 0, !dbg !729
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !729

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #18, !dbg !729
  unreachable, !dbg !729

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !732
  %0 = load i64, ptr %st_size, align 8, !dbg !732
    #dbg_value(i64 %0, !716, !DIExpression(), !724)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !733
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !733

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #18, !dbg !733
  unreachable, !dbg !733

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !736
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #19, !dbg !737
    #dbg_value(ptr %call11, !678, !DIExpression(), !724)
    #dbg_value(i64 0, !719, !DIExpression(), !724)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !738

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !739
    #dbg_value(i64 %add19, !719, !DIExpression(), !724)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !741
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !738, !llvm.loop !742

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !738

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !719, !DIExpression(), !724)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !744
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !745
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #17, !dbg !746
    #dbg_value(i64 %call13, !722, !DIExpression(), !724)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !747
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !719, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !724)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !747

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #18, !dbg !747
  unreachable, !dbg !747

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !750
  store i8 0, ptr %arrayidx20, align 1, !dbg !751, !tbaa !355
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #17, !dbg !752
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #17, !dbg !753
  ret ptr %call11, !dbg !754
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: noreturn nounwind
declare !dbg !755 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare !dbg !760 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !765 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #8

; Function Attrs: nofree
declare !dbg !770 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #9

declare !dbg !774 signext i32 @close(i32 noundef signext) local_unnamed_addr #10

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #1 !dbg !510 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !509, !DIExpression(), !775)
    #dbg_value(i32 %n, !514, !DIExpression(), !775)
    #dbg_value(i32 0, !515, !DIExpression(), !775)
  %cmp = icmp sgt i32 %n, -1, !dbg !776
  br i1 %cmp, label %if.end, label %if.else, !dbg !776

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #18, !dbg !776
  unreachable, !dbg !776

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !779
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !781

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !781

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !781

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !515, !DIExpression(), !775)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !509, !DIExpression(), !775)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !782, !tbaa !355
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !783

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !783

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !783

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !784
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !784, !tbaa !355
  %cmp13 = icmp eq i8 %1, 37, !dbg !785
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !786

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !786

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !787
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !787, !tbaa !355
  %cmp18 = icmp eq i8 %2, 10, !dbg !788
  %inc = zext i1 %cmp18 to i32, !dbg !789
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !789
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !789

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !515, !DIExpression(), !775)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !790
    #dbg_value(ptr %incdec.ptr, !509, !DIExpression(), !775)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !791
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !792, !llvm.loop !793

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !792

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !795, !tbaa !355
  %3 = icmp eq i8 %.pre, 0, !dbg !796
  %4 = select i1 %3, i64 0, i64 2, !dbg !797
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !792

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !797
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !797

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !798
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !538 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !537, !DIExpression(), !799)
    #dbg_value(ptr %arr, !542, !DIExpression(), !799)
    #dbg_value(i32 %n, !543, !DIExpression(), !799)
  %cmp.not = icmp eq ptr %s, null, !dbg !800
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !800

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #18, !dbg !800
  unreachable, !dbg !800

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !803
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !805

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !806
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !808
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !808

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !544, !DIExpression(), !799)
  %conv404 = zext nneg i32 %n to i64, !dbg !809
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !810
  br label %if.end46, !dbg !811

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !544, !DIExpression(), !799)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !812
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !813

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !813

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !814
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !815
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !815
  %cmp9.not = icmp eq i8 %0, 0, !dbg !816
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !817

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !817

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !818
  %1 = load i8, ptr %gep, align 1, !dbg !818
  %cmp16.not = icmp eq i8 %1, 0, !dbg !819
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !820

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !820

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !821
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !822
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !822
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !822, !llvm.loop !823

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !822

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !809

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !809

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !809

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !809
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !544, !DIExpression(), !799)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !810
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !825
  store i8 0, ptr %arrayidx45, align 1, !dbg !827, !tbaa !355
  br label %if.end46, !dbg !825

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !828
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #11

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !829 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !841
    #dbg_assign(i1 undef, !838, !DIExpression(), !841, ptr %endptr, !DIExpression(), !842)
    #dbg_value(ptr %s, !834, !DIExpression(), !842)
    #dbg_value(ptr %arr, !835, !DIExpression(), !842)
    #dbg_value(i32 %n, !836, !DIExpression(), !842)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !843
    #dbg_value(i32 0, !839, !DIExpression(), !842)
  %cmp.not = icmp eq ptr %s, null, !dbg !844
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !844

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #18, !dbg !844
  unreachable, !dbg !844

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !843
    #dbg_value(ptr %call, !837, !DIExpression(), !842)
    #dbg_value(i32 0, !839, !DIExpression(), !842)
  %cmp130 = icmp ne ptr %call, null, !dbg !843
  %cmp231 = icmp sgt i32 %n, 0, !dbg !843
  %0 = and i1 %cmp231, %cmp130, !dbg !843
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !843

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !843

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !843
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !843

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !837, !DIExpression(), !842)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !839, !DIExpression(), !842)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !847, !tbaa !849, !DIAssignID !851
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !838, !DIExpression(), !851, ptr %endptr, !DIExpression(), !842)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !847
  %conv = trunc i64 %call3 to i8, !dbg !847
    #dbg_value(i8 %conv, !840, !DIExpression(), !842)
  %2 = load ptr, ptr %endptr, align 8, !dbg !852, !tbaa !849
  %3 = load i8, ptr %2, align 1, !dbg !852, !tbaa !355
  %cmp5.not = icmp eq i8 %3, 0, !dbg !852
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !847

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !847

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !854, !tbaa !849
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !854
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !854
  br label %if.end9, !dbg !854

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !847
  store i8 %conv, ptr %arrayidx, align 1, !dbg !847, !tbaa !355
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !847
    #dbg_value(i64 %indvars.iv.next, !839, !DIExpression(), !842)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !847
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !847
  store i8 10, ptr %arrayidx11, align 1, !dbg !847, !tbaa !355
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !847
    #dbg_value(ptr %call12, !837, !DIExpression(), !842)
  %cmp1 = icmp ne ptr %call12, null, !dbg !843
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !843
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !843
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !843, !llvm.loop !856

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !843

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !843

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !843

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !843

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !857
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !857
  store i8 10, ptr %arrayidx17, align 1, !dbg !857, !tbaa !355
  br label %if.end18, !dbg !857

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !843
  ret i32 0, !dbg !843
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !860 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #12

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !866 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #12

; Function Attrs: nofree nounwind
declare !dbg !871 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #7

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !924 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !927 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !939
    #dbg_assign(i1 undef, !936, !DIExpression(), !939, ptr %endptr, !DIExpression(), !940)
    #dbg_value(ptr %s, !932, !DIExpression(), !940)
    #dbg_value(ptr %arr, !933, !DIExpression(), !940)
    #dbg_value(i32 %n, !934, !DIExpression(), !940)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !941
    #dbg_value(i32 0, !937, !DIExpression(), !940)
  %cmp.not = icmp eq ptr %s, null, !dbg !942
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !942

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #18, !dbg !942
  unreachable, !dbg !942

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !941
    #dbg_value(ptr %call, !935, !DIExpression(), !940)
    #dbg_value(i32 0, !937, !DIExpression(), !940)
  %cmp130 = icmp ne ptr %call, null, !dbg !941
  %cmp231 = icmp sgt i32 %n, 0, !dbg !941
  %0 = and i1 %cmp231, %cmp130, !dbg !941
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !941

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !941

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !941
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !941

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !935, !DIExpression(), !940)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !937, !DIExpression(), !940)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !945, !tbaa !849, !DIAssignID !947
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !936, !DIExpression(), !947, ptr %endptr, !DIExpression(), !940)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !945
  %conv = trunc i64 %call3 to i16, !dbg !945
    #dbg_value(i16 %conv, !938, !DIExpression(), !940)
  %2 = load ptr, ptr %endptr, align 8, !dbg !948, !tbaa !849
  %3 = load i8, ptr %2, align 1, !dbg !948, !tbaa !355
  %cmp5.not = icmp eq i8 %3, 0, !dbg !948
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !945

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !945

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !950, !tbaa !849
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !950
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !950
  br label %if.end9, !dbg !950

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !945
  store i16 %conv, ptr %arrayidx, align 2, !dbg !945, !tbaa !952
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !945
    #dbg_value(i64 %indvars.iv.next, !937, !DIExpression(), !940)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !945
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !945
  store i8 10, ptr %arrayidx11, align 1, !dbg !945, !tbaa !355
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !945
    #dbg_value(ptr %call12, !935, !DIExpression(), !940)
  %cmp1 = icmp ne ptr %call12, null, !dbg !941
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !941
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !941
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !941, !llvm.loop !954

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !941

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !941

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !941

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !941

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !955
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !955
  store i8 10, ptr %arrayidx17, align 1, !dbg !955, !tbaa !355
  br label %if.end18, !dbg !955

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !941
  ret i32 0, !dbg !941
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !958 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !970
    #dbg_assign(i1 undef, !967, !DIExpression(), !970, ptr %endptr, !DIExpression(), !971)
    #dbg_value(ptr %s, !963, !DIExpression(), !971)
    #dbg_value(ptr %arr, !964, !DIExpression(), !971)
    #dbg_value(i32 %n, !965, !DIExpression(), !971)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !972
    #dbg_value(i32 0, !968, !DIExpression(), !971)
  %cmp.not = icmp eq ptr %s, null, !dbg !973
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !973

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #18, !dbg !973
  unreachable, !dbg !973

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !972
    #dbg_value(ptr %call, !966, !DIExpression(), !971)
    #dbg_value(i32 0, !968, !DIExpression(), !971)
  %cmp130 = icmp ne ptr %call, null, !dbg !972
  %cmp231 = icmp sgt i32 %n, 0, !dbg !972
  %0 = and i1 %cmp231, %cmp130, !dbg !972
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !972

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !972

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !972
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !972

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !966, !DIExpression(), !971)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !968, !DIExpression(), !971)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !976, !tbaa !849, !DIAssignID !978
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !967, !DIExpression(), !978, ptr %endptr, !DIExpression(), !971)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !976
  %conv = trunc i64 %call3 to i32, !dbg !976
    #dbg_value(i32 %conv, !969, !DIExpression(), !971)
  %2 = load ptr, ptr %endptr, align 8, !dbg !979, !tbaa !849
  %3 = load i8, ptr %2, align 1, !dbg !979, !tbaa !355
  %cmp5.not = icmp eq i8 %3, 0, !dbg !979
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !976

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !976

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !981, !tbaa !849
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !981
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !981
  br label %if.end9, !dbg !981

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !976
  store i32 %conv, ptr %arrayidx, align 4, !dbg !976, !tbaa !346
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !976
    #dbg_value(i64 %indvars.iv.next, !968, !DIExpression(), !971)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !976
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !976
  store i8 10, ptr %arrayidx11, align 1, !dbg !976, !tbaa !355
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !976
    #dbg_value(ptr %call12, !966, !DIExpression(), !971)
  %cmp1 = icmp ne ptr %call12, null, !dbg !972
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !972
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !972
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !972, !llvm.loop !983

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !972

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !972

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !972

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !972

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !984
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !984
  store i8 10, ptr %arrayidx17, align 1, !dbg !984, !tbaa !355
  br label %if.end18, !dbg !984

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !972
  ret i32 0, !dbg !972
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !987 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !999
    #dbg_assign(i1 undef, !996, !DIExpression(), !999, ptr %endptr, !DIExpression(), !1000)
    #dbg_value(ptr %s, !992, !DIExpression(), !1000)
    #dbg_value(ptr %arr, !993, !DIExpression(), !1000)
    #dbg_value(i32 %n, !994, !DIExpression(), !1000)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1001
    #dbg_value(i32 0, !997, !DIExpression(), !1000)
  %cmp.not = icmp eq ptr %s, null, !dbg !1002
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1002

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #18, !dbg !1002
  unreachable, !dbg !1002

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1001
    #dbg_value(ptr %call, !995, !DIExpression(), !1000)
    #dbg_value(i32 0, !997, !DIExpression(), !1000)
  %cmp129 = icmp ne ptr %call, null, !dbg !1001
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1001
  %0 = and i1 %cmp230, %cmp129, !dbg !1001
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1001

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1001

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1001
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1001

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !995, !DIExpression(), !1000)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !997, !DIExpression(), !1000)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1005, !tbaa !849, !DIAssignID !1007
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !996, !DIExpression(), !1007, ptr %endptr, !DIExpression(), !1000)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1005
    #dbg_value(i64 %call3, !998, !DIExpression(), !1000)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1008, !tbaa !849
  %3 = load i8, ptr %2, align 1, !dbg !1008, !tbaa !355
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1008
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1005

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1005

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1010, !tbaa !849
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1010
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1010
  br label %if.end8, !dbg !1010

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1005
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1005, !tbaa !1012
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1005
    #dbg_value(i64 %indvars.iv.next, !997, !DIExpression(), !1000)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1005
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1005
  store i8 10, ptr %arrayidx10, align 1, !dbg !1005, !tbaa !355
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1005
    #dbg_value(ptr %call11, !995, !DIExpression(), !1000)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1001
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1001
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1001
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1001, !llvm.loop !1014

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1001

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1001

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1001

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1001

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1015
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1015
  store i8 10, ptr %arrayidx16, align 1, !dbg !1015, !tbaa !355
  br label %if.end17, !dbg !1015

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1001
  ret i32 0, !dbg !1001
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1018 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1030
    #dbg_assign(i1 undef, !1027, !DIExpression(), !1030, ptr %endptr, !DIExpression(), !1031)
    #dbg_value(ptr %s, !1023, !DIExpression(), !1031)
    #dbg_value(ptr %arr, !1024, !DIExpression(), !1031)
    #dbg_value(i32 %n, !1025, !DIExpression(), !1031)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1032
    #dbg_value(i32 0, !1028, !DIExpression(), !1031)
  %cmp.not = icmp eq ptr %s, null, !dbg !1033
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1033

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #18, !dbg !1033
  unreachable, !dbg !1033

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1032
    #dbg_value(ptr %call, !1026, !DIExpression(), !1031)
    #dbg_value(i32 0, !1028, !DIExpression(), !1031)
  %cmp130 = icmp ne ptr %call, null, !dbg !1032
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1032
  %0 = and i1 %cmp231, %cmp130, !dbg !1032
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1032

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1032

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1032
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1032

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1026, !DIExpression(), !1031)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1028, !DIExpression(), !1031)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1036, !tbaa !849, !DIAssignID !1038
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1027, !DIExpression(), !1038, ptr %endptr, !DIExpression(), !1031)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1036
  %conv = trunc i64 %call3 to i8, !dbg !1036
    #dbg_value(i8 %conv, !1029, !DIExpression(), !1031)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1039, !tbaa !849
  %3 = load i8, ptr %2, align 1, !dbg !1039, !tbaa !355
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1039
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1036

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1036

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1041, !tbaa !849
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1041
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1041
  br label %if.end9, !dbg !1041

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1036
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1036, !tbaa !355
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1036
    #dbg_value(i64 %indvars.iv.next, !1028, !DIExpression(), !1031)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1036
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1036
  store i8 10, ptr %arrayidx11, align 1, !dbg !1036, !tbaa !355
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1036
    #dbg_value(ptr %call12, !1026, !DIExpression(), !1031)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1032
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1032
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1032
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1032, !llvm.loop !1043

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1032

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1032

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1032

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1032

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1044
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1044
  store i8 10, ptr %arrayidx17, align 1, !dbg !1044, !tbaa !355
  br label %if.end18, !dbg !1044

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1032
  ret i32 0, !dbg !1032
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1047 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1059
    #dbg_assign(i1 undef, !1056, !DIExpression(), !1059, ptr %endptr, !DIExpression(), !1060)
    #dbg_value(ptr %s, !1052, !DIExpression(), !1060)
    #dbg_value(ptr %arr, !1053, !DIExpression(), !1060)
    #dbg_value(i32 %n, !1054, !DIExpression(), !1060)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1061
    #dbg_value(i32 0, !1057, !DIExpression(), !1060)
  %cmp.not = icmp eq ptr %s, null, !dbg !1062
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1062

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #18, !dbg !1062
  unreachable, !dbg !1062

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1061
    #dbg_value(ptr %call, !1055, !DIExpression(), !1060)
    #dbg_value(i32 0, !1057, !DIExpression(), !1060)
  %cmp130 = icmp ne ptr %call, null, !dbg !1061
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1061
  %0 = and i1 %cmp231, %cmp130, !dbg !1061
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1061

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1061

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1061
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1061

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1055, !DIExpression(), !1060)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1057, !DIExpression(), !1060)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1065, !tbaa !849, !DIAssignID !1067
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1056, !DIExpression(), !1067, ptr %endptr, !DIExpression(), !1060)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1065
  %conv = trunc i64 %call3 to i16, !dbg !1065
    #dbg_value(i16 %conv, !1058, !DIExpression(), !1060)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1068, !tbaa !849
  %3 = load i8, ptr %2, align 1, !dbg !1068, !tbaa !355
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1068
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1065

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1065

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1070, !tbaa !849
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1070
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1070
  br label %if.end9, !dbg !1070

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1065
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1065, !tbaa !952
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1065
    #dbg_value(i64 %indvars.iv.next, !1057, !DIExpression(), !1060)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1065
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1065
  store i8 10, ptr %arrayidx11, align 1, !dbg !1065, !tbaa !355
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1065
    #dbg_value(ptr %call12, !1055, !DIExpression(), !1060)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1061
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1061
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1061
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1061, !llvm.loop !1072

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1061

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1061

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1061

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1061

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1073
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1073
  store i8 10, ptr %arrayidx17, align 1, !dbg !1073, !tbaa !355
  br label %if.end18, !dbg !1073

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1061
  ret i32 0, !dbg !1061
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1076 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1087
    #dbg_assign(i1 undef, !1084, !DIExpression(), !1087, ptr %endptr, !DIExpression(), !1088)
    #dbg_value(ptr %s, !1080, !DIExpression(), !1088)
    #dbg_value(ptr %arr, !1081, !DIExpression(), !1088)
    #dbg_value(i32 %n, !1082, !DIExpression(), !1088)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1089
    #dbg_value(i32 0, !1085, !DIExpression(), !1088)
  %cmp.not = icmp eq ptr %s, null, !dbg !1090
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1090

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #18, !dbg !1090
  unreachable, !dbg !1090

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1089
    #dbg_value(ptr %call, !1083, !DIExpression(), !1088)
    #dbg_value(i32 0, !1085, !DIExpression(), !1088)
  %cmp130 = icmp ne ptr %call, null, !dbg !1089
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1089
  %0 = and i1 %cmp231, %cmp130, !dbg !1089
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1089

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1089

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1089
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1089

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1083, !DIExpression(), !1088)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1085, !DIExpression(), !1088)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1093, !tbaa !849, !DIAssignID !1095
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1084, !DIExpression(), !1095, ptr %endptr, !DIExpression(), !1088)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1093
  %conv = trunc i64 %call3 to i32, !dbg !1093
    #dbg_value(i32 %conv, !1086, !DIExpression(), !1088)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1096, !tbaa !849
  %3 = load i8, ptr %2, align 1, !dbg !1096, !tbaa !355
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1096
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1093

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1093

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1098, !tbaa !849
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1098
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1098
  br label %if.end9, !dbg !1098

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1093
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1093, !tbaa !346
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1093
    #dbg_value(i64 %indvars.iv.next, !1085, !DIExpression(), !1088)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1093
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1093
  store i8 10, ptr %arrayidx11, align 1, !dbg !1093, !tbaa !355
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1093
    #dbg_value(ptr %call12, !1083, !DIExpression(), !1088)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1089
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1089
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1089
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1089, !llvm.loop !1100

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1089

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1089

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1089

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1089

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1101
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1101
  store i8 10, ptr %arrayidx17, align 1, !dbg !1101, !tbaa !355
  br label %if.end18, !dbg !1101

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1089
  ret i32 0, !dbg !1089
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1104 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1116
    #dbg_assign(i1 undef, !1113, !DIExpression(), !1116, ptr %endptr, !DIExpression(), !1117)
    #dbg_value(ptr %s, !1109, !DIExpression(), !1117)
    #dbg_value(ptr %arr, !1110, !DIExpression(), !1117)
    #dbg_value(i32 %n, !1111, !DIExpression(), !1117)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1118
    #dbg_value(i32 0, !1114, !DIExpression(), !1117)
  %cmp.not = icmp eq ptr %s, null, !dbg !1119
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1119

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #18, !dbg !1119
  unreachable, !dbg !1119

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1118
    #dbg_value(ptr %call, !1112, !DIExpression(), !1117)
    #dbg_value(i32 0, !1114, !DIExpression(), !1117)
  %cmp129 = icmp ne ptr %call, null, !dbg !1118
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1118
  %0 = and i1 %cmp230, %cmp129, !dbg !1118
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1118

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1118

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1118
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1118

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1112, !DIExpression(), !1117)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1114, !DIExpression(), !1117)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1122, !tbaa !849, !DIAssignID !1124
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1113, !DIExpression(), !1124, ptr %endptr, !DIExpression(), !1117)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1122
    #dbg_value(i64 %call3, !1115, !DIExpression(), !1117)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1125, !tbaa !849
  %3 = load i8, ptr %2, align 1, !dbg !1125, !tbaa !355
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1125
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1122

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1122

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1127, !tbaa !849
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1127
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1127
  br label %if.end8, !dbg !1127

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1122
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1122, !tbaa !1012
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1122
    #dbg_value(i64 %indvars.iv.next, !1114, !DIExpression(), !1117)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1122
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1122
  store i8 10, ptr %arrayidx10, align 1, !dbg !1122, !tbaa !355
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1122
    #dbg_value(ptr %call11, !1112, !DIExpression(), !1117)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1118
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1118
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1118
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1118, !llvm.loop !1129

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1118

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1118

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1118

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1118

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1130
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1130
  store i8 10, ptr %arrayidx16, align 1, !dbg !1130, !tbaa !355
  br label %if.end17, !dbg !1130

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1118
  ret i32 0, !dbg !1118
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1133 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1145
    #dbg_assign(i1 undef, !1142, !DIExpression(), !1145, ptr %endptr, !DIExpression(), !1146)
    #dbg_value(ptr %s, !1138, !DIExpression(), !1146)
    #dbg_value(ptr %arr, !1139, !DIExpression(), !1146)
    #dbg_value(i32 %n, !1140, !DIExpression(), !1146)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1147
    #dbg_value(i32 0, !1143, !DIExpression(), !1146)
  %cmp.not = icmp eq ptr %s, null, !dbg !1148
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1148

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #18, !dbg !1148
  unreachable, !dbg !1148

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1147
    #dbg_value(ptr %call, !1141, !DIExpression(), !1146)
    #dbg_value(i32 0, !1143, !DIExpression(), !1146)
  %cmp129 = icmp ne ptr %call, null, !dbg !1147
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1147
  %0 = and i1 %cmp230, %cmp129, !dbg !1147
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1147

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1147

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1147
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1147

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1141, !DIExpression(), !1146)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1143, !DIExpression(), !1146)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1151, !tbaa !849, !DIAssignID !1153
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1142, !DIExpression(), !1153, ptr %endptr, !DIExpression(), !1146)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #17, !dbg !1151
    #dbg_value(float %call3, !1144, !DIExpression(), !1146)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1154, !tbaa !849
  %3 = load i8, ptr %2, align 1, !dbg !1154, !tbaa !355
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1154
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1151

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1151

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1156, !tbaa !849
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1156
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1156
  br label %if.end8, !dbg !1156

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1151
  store float %call3, ptr %arrayidx, align 4, !dbg !1151, !tbaa !1158
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1151
    #dbg_value(i64 %indvars.iv.next, !1143, !DIExpression(), !1146)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1151
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1151
  store i8 10, ptr %arrayidx10, align 1, !dbg !1151, !tbaa !355
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1151
    #dbg_value(ptr %call11, !1141, !DIExpression(), !1146)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1147
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1147
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1147
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1147, !llvm.loop !1160

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1147

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1147

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1147

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1147

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1161
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1161
  store i8 10, ptr %arrayidx16, align 1, !dbg !1161, !tbaa !355
  br label %if.end17, !dbg !1161

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1147
  ret i32 0, !dbg !1147
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1164 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1167 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1179
    #dbg_assign(i1 undef, !1176, !DIExpression(), !1179, ptr %endptr, !DIExpression(), !1180)
    #dbg_value(ptr %s, !1172, !DIExpression(), !1180)
    #dbg_value(ptr %arr, !1173, !DIExpression(), !1180)
    #dbg_value(i32 %n, !1174, !DIExpression(), !1180)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1181
    #dbg_value(i32 0, !1177, !DIExpression(), !1180)
  %cmp.not = icmp eq ptr %s, null, !dbg !1182
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1182

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #18, !dbg !1182
  unreachable, !dbg !1182

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1181
    #dbg_value(ptr %call, !1175, !DIExpression(), !1180)
    #dbg_value(i32 0, !1177, !DIExpression(), !1180)
  %cmp129 = icmp ne ptr %call, null, !dbg !1181
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1181
  %0 = and i1 %cmp230, %cmp129, !dbg !1181
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1181

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1181

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1181
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1181

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1175, !DIExpression(), !1180)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1177, !DIExpression(), !1180)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1185, !tbaa !849, !DIAssignID !1187
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1176, !DIExpression(), !1187, ptr %endptr, !DIExpression(), !1180)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #17, !dbg !1185
    #dbg_value(double %call3, !1178, !DIExpression(), !1180)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1188, !tbaa !849
  %3 = load i8, ptr %2, align 1, !dbg !1188, !tbaa !355
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1188
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1185

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1185

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1190, !tbaa !849
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1190
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1190
  br label %if.end8, !dbg !1190

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1185
  store double %call3, ptr %arrayidx, align 8, !dbg !1185, !tbaa !1192
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1185
    #dbg_value(i64 %indvars.iv.next, !1177, !DIExpression(), !1180)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1185
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1185
  store i8 10, ptr %arrayidx10, align 1, !dbg !1185, !tbaa !355
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1185
    #dbg_value(ptr %call11, !1175, !DIExpression(), !1180)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1181
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1181
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1181
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1181, !llvm.loop !1194

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1181

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1181

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1181

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1181

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1195
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1195
  store i8 10, ptr %arrayidx16, align 1, !dbg !1195, !tbaa !355
  br label %if.end17, !dbg !1195

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1181
  ret i32 0, !dbg !1181
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1198 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1201 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1205, !DIExpression(), !1210)
    #dbg_value(ptr %arr, !1206, !DIExpression(), !1210)
    #dbg_value(i32 %n, !1207, !DIExpression(), !1210)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1211
  br i1 %cmp, label %if.end, label %if.else, !dbg !1211

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #18, !dbg !1211
  unreachable, !dbg !1211

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1214
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1216

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1216

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #21, !dbg !1217
  %conv = trunc i64 %call to i32, !dbg !1217
    #dbg_value(i32 %conv, !1207, !DIExpression(), !1210)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1219

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1207, !DIExpression(), !1210)
    #dbg_value(i32 0, !1209, !DIExpression(), !1210)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1220
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1221

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1221

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1221

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1222

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1223
    #dbg_value(i32 %add, !1209, !DIExpression(), !1210)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1220
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1221, !llvm.loop !1225

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1221

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1221

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1209, !DIExpression(), !1210)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1227
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1227
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1228
  %conv6 = sext i32 %sub to i64, !dbg !1229
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #17, !dbg !1230
  %conv8 = trunc i64 %call7 to i32, !dbg !1230
    #dbg_value(i32 %conv8, !1208, !DIExpression(), !1210)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1231
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1209, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1210)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1231

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #18, !dbg !1231
  unreachable, !dbg !1231

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #17, !dbg !1234
  %conv16 = trunc i64 %call15 to i32, !dbg !1234
    #dbg_value(i32 %conv16, !1208, !DIExpression(), !1210)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1236
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1236

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #18, !dbg !1236
  unreachable, !dbg !1236

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1239
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1240, !llvm.loop !1241

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1240

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1243
}

; Function Attrs: nofree
declare !dbg !1244 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #9

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1249 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1253, !DIExpression(), !1257)
    #dbg_value(ptr %arr, !1254, !DIExpression(), !1257)
    #dbg_value(i32 %n, !1255, !DIExpression(), !1257)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1258
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1258

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1256, !DIExpression(), !1257)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1261
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1264

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1264

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1261
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1264

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #18, !dbg !1258
  unreachable, !dbg !1258

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1256, !DIExpression(), !1257)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1265
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1265, !tbaa !355
  %conv = zext i8 %0 to i32, !dbg !1265
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1265
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1261
    #dbg_value(i64 %indvars.iv.next, !1256, !DIExpression(), !1257)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1261
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1264, !llvm.loop !1267

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1264

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1264

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1268
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #14 !dbg !1269 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1286
    #dbg_assign(i1 undef, !1275, !DIExpression(), !1286, ptr %args, !DIExpression(), !1287)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1288
    #dbg_assign(i1 undef, !1282, !DIExpression(), !1288, ptr %buffer, !DIExpression(), !1287)
    #dbg_value(i32 %fd, !1273, !DIExpression(), !1287)
    #dbg_value(ptr %format, !1274, !DIExpression(), !1287)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #17, !dbg !1289
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #17, !dbg !1290
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1291
  %0 = load ptr, ptr %args, align 8, !dbg !1292, !tbaa !849
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #17, !dbg !1293
    #dbg_value(i32 %call, !1279, !DIExpression(), !1287)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1294
  %cmp = icmp slt i32 %call, 256, !dbg !1295
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1295

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1280, !DIExpression(), !1287)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1298
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1299

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1299

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1299

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #18, !dbg !1295
  unreachable, !dbg !1295

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1300
    #dbg_value(i32 %add, !1280, !DIExpression(), !1287)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1298
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1299, !llvm.loop !1302

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1299

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1299

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1280, !DIExpression(), !1287)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1304
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1304
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1305
  %conv = sext i32 %sub to i64, !dbg !1306
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #17, !dbg !1307
  %conv3 = trunc i64 %call2 to i32, !dbg !1307
    #dbg_value(i32 %conv3, !1281, !DIExpression(), !1287)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1308
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1280, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1287)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1308

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #18, !dbg !1308
  unreachable, !dbg !1308

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1311
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1311

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #18, !dbg !1311
  unreachable, !dbg !1311

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #17, !dbg !1314
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #17, !dbg !1314
  ret void, !dbg !1315
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #15

; Function Attrs: nofree nounwind
declare !dbg !1316 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #7

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1321 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1325, !DIExpression(), !1329)
    #dbg_value(ptr %arr, !1326, !DIExpression(), !1329)
    #dbg_value(i32 %n, !1327, !DIExpression(), !1329)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1330
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1330

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1328, !DIExpression(), !1329)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1333
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1336

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1336

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1333
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1336

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #18, !dbg !1330
  unreachable, !dbg !1330

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1328, !DIExpression(), !1329)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1337
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1337, !tbaa !952
  %conv = zext i16 %0 to i32, !dbg !1337
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1337
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1333
    #dbg_value(i64 %indvars.iv.next, !1328, !DIExpression(), !1329)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1333
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1336, !llvm.loop !1339

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1336

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1336

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1340
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1341 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1345, !DIExpression(), !1349)
    #dbg_value(ptr %arr, !1346, !DIExpression(), !1349)
    #dbg_value(i32 %n, !1347, !DIExpression(), !1349)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1350
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1350

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1348, !DIExpression(), !1349)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1353
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1356

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1356

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1353
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1356

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #18, !dbg !1350
  unreachable, !dbg !1350

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1348, !DIExpression(), !1349)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1357
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1357, !tbaa !346
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1357
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1353
    #dbg_value(i64 %indvars.iv.next, !1348, !DIExpression(), !1349)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1353
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1356, !llvm.loop !1359

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1356

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1356

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1360
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1361 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1365, !DIExpression(), !1369)
    #dbg_value(ptr %arr, !1366, !DIExpression(), !1369)
    #dbg_value(i32 %n, !1367, !DIExpression(), !1369)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1370
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1370

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1368, !DIExpression(), !1369)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1373
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1376

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1376

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1373
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1376

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #18, !dbg !1370
  unreachable, !dbg !1370

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1368, !DIExpression(), !1369)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1377
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1377, !tbaa !1012
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1377
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1373
    #dbg_value(i64 %indvars.iv.next, !1368, !DIExpression(), !1369)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1373
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1376, !llvm.loop !1379

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1376

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1376

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1380
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1381 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1385, !DIExpression(), !1389)
    #dbg_value(ptr %arr, !1386, !DIExpression(), !1389)
    #dbg_value(i32 %n, !1387, !DIExpression(), !1389)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1390
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1390

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1388, !DIExpression(), !1389)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1393
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1396

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1396

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1393
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1396

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #18, !dbg !1390
  unreachable, !dbg !1390

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1388, !DIExpression(), !1389)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1397
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1397, !tbaa !355
  %conv = sext i8 %0 to i32, !dbg !1397
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1397
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1393
    #dbg_value(i64 %indvars.iv.next, !1388, !DIExpression(), !1389)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1393
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1396, !llvm.loop !1399

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1396

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1396

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1400
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1401 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1405, !DIExpression(), !1409)
    #dbg_value(ptr %arr, !1406, !DIExpression(), !1409)
    #dbg_value(i32 %n, !1407, !DIExpression(), !1409)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1410
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1410

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1408, !DIExpression(), !1409)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1413
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1416

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1416

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1413
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1416

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #18, !dbg !1410
  unreachable, !dbg !1410

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1408, !DIExpression(), !1409)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1417
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1417, !tbaa !952
  %conv = sext i16 %0 to i32, !dbg !1417
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1417
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1413
    #dbg_value(i64 %indvars.iv.next, !1408, !DIExpression(), !1409)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1413
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1416, !llvm.loop !1419

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1416

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1416

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1420
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !642 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !641, !DIExpression(), !1421)
    #dbg_value(ptr %arr, !646, !DIExpression(), !1421)
    #dbg_value(i32 %n, !647, !DIExpression(), !1421)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1422
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1422

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !648, !DIExpression(), !1421)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1425
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1426

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1426

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1425
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1426

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #18, !dbg !1422
  unreachable, !dbg !1422

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !648, !DIExpression(), !1421)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1427
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1427, !tbaa !346
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1427
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1425
    #dbg_value(i64 %indvars.iv.next, !648, !DIExpression(), !1421)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1425
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1426, !llvm.loop !1428

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1426

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1426

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1429
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1430 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1434, !DIExpression(), !1438)
    #dbg_value(ptr %arr, !1435, !DIExpression(), !1438)
    #dbg_value(i32 %n, !1436, !DIExpression(), !1438)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1439
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1439

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1437, !DIExpression(), !1438)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1442
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1445

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1445

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1442
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1445

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #18, !dbg !1439
  unreachable, !dbg !1439

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1437, !DIExpression(), !1438)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1446
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1446, !tbaa !1012
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1446
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1442
    #dbg_value(i64 %indvars.iv.next, !1437, !DIExpression(), !1438)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1442
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1445, !llvm.loop !1448

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1445

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1445

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1449
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1450 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1454, !DIExpression(), !1458)
    #dbg_value(ptr %arr, !1455, !DIExpression(), !1458)
    #dbg_value(i32 %n, !1456, !DIExpression(), !1458)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1459
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1459

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1457, !DIExpression(), !1458)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1462
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1465

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1465

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1462
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1465

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #18, !dbg !1459
  unreachable, !dbg !1459

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1457, !DIExpression(), !1458)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1466
  %0 = load float, ptr %arrayidx, align 4, !dbg !1466, !tbaa !1158
  %conv = fpext float %0 to double, !dbg !1466
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1466
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1462
    #dbg_value(i64 %indvars.iv.next, !1457, !DIExpression(), !1458)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1462
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1465, !llvm.loop !1468

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1465

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1465

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1469
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1470 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1474, !DIExpression(), !1478)
    #dbg_value(ptr %arr, !1475, !DIExpression(), !1478)
    #dbg_value(i32 %n, !1476, !DIExpression(), !1478)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1479
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1479

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1477, !DIExpression(), !1478)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1482
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1485

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1485

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1482
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1485

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #18, !dbg !1479
  unreachable, !dbg !1479

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1477, !DIExpression(), !1478)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1486
  %0 = load double, ptr %arrayidx, align 8, !dbg !1486, !tbaa !1192
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1486
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1482
    #dbg_value(i64 %indvars.iv.next, !1477, !DIExpression(), !1478)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1482
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1485, !llvm.loop !1488

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1485

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1485

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1489
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !581 {
entry.split:
    #dbg_value(i32 %fd, !580, !DIExpression(), !1490)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1491
  br i1 %cmp, label %if.end, label %if.else, !dbg !1491

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #18, !dbg !1491
  unreachable, !dbg !1491

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1492
  ret i32 0, !dbg !1493
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #1 !dbg !1494 {
entry.split:
  %n_matches.i.reg2mem = alloca ptr, align 8
  %incdec.ptr.i.i.reg2mem = alloca ptr, align 8
  %i.1.i.i.reg2mem = alloca i32, align 4
  %spec.select.i.i.reg2mem = alloca i32, align 4
  %s.addr.040.i.i.reg2mem = alloca ptr, align 8
  %i.041.i.i.reg2mem = alloca i32, align 4
  %call.i.reg2mem = alloca ptr, align 8
  %call14.reg2mem = alloca i32, align 4
  %call.reg2mem = alloca ptr, align 8
  %check_file.0.reg2mem = alloca ptr, align 8
  %in_file.034.reg2mem = alloca ptr, align 8
  %.reg2mem157 = alloca ptr, align 8
  %.reg2mem159 = alloca ptr, align 8
  %retval.0.reg2mem = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.i23.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i22.reg2mem = alloca i64, align 8
  %i.1.i.i17.reg2mem162 = alloca i32, align 4
  %s.addr.040.i.i12.reg2mem164 = alloca ptr, align 8
  %i.041.i.i11.reg2mem166 = alloca i32, align 4
  %q.3.i.i.reg2mem168 = alloca i32, align 4
  %q.1.lcssa.i.i.reg2mem = alloca i32, align 4
  %q.143.i.i.reg2mem170 = alloca i32, align 4
  %q.046.i.i.reg2mem172 = alloca i32, align 4
  %indvars.iv.i.i.reg2mem174 = alloca i64, align 8
  %k.1.lcssa.i.i.i.reg2mem = alloca i32, align 4
  %k.136.i.i.i.reg2mem176 = alloca i32, align 4
  %k.038.i.i.i.reg2mem178 = alloca i32, align 4
  %indvars.iv.i.i.i.reg2mem180 = alloca i64, align 8
  %s.addr.0.lcssa.ph.i14.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i13.i.reg2mem = alloca i64, align 8
  %i.1.i8.i.reg2mem182 = alloca i32, align 4
  %s.addr.040.i3.i.reg2mem184 = alloca ptr, align 8
  %i.041.i2.i.reg2mem186 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem188 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem190 = alloca ptr, align 8
  %i.041.i.i.reg2mem192 = alloca i32, align 4
  %check_file.0.reg2mem194 = alloca ptr, align 8
  %in_file.034.reg2mem196 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1498, !DIExpression(), !1507)
    #dbg_value(ptr %argv, !1499, !DIExpression(), !1507)
  %cmp = icmp slt i32 %argc, 4, !dbg !1508
  br i1 %cmp, label %if.end, label %if.else, !dbg !1508

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.15, ptr noundef nonnull @.str.2.16, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1508
  unreachable, !dbg !1508

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1500, !DIExpression(), !1507)
    #dbg_value(ptr @.str.4.17, !1501, !DIExpression(), !1507)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1511
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1513

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.17, ptr %check_file.0.reg2mem194, align 8
  store ptr @.str.3, ptr %in_file.034.reg2mem196, align 8
  br label %if.end7, !dbg !1513

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1514
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1514
    #dbg_value(ptr %0, !1500, !DIExpression(), !1507)
  store ptr %0, ptr %.reg2mem159, align 8
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1515
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1517

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.17, ptr %check_file.0.reg2mem194, align 8
  store ptr %0, ptr %in_file.034.reg2mem196, align 8
  br label %if.end7, !dbg !1517

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1518
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1518
    #dbg_value(ptr %1, !1501, !DIExpression(), !1507)
  store ptr %1, ptr %.reg2mem157, align 8
  store ptr %1, ptr %check_file.0.reg2mem194, align 8
  store ptr %0, ptr %in_file.034.reg2mem196, align 8
  br label %if.end7, !dbg !1519

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem194.0.check_file.0.reload195, !1501, !DIExpression(), !1507)
  %in_file.034.reg2mem196.0.in_file.034.reload197 = load ptr, ptr %in_file.034.reg2mem196, align 8
  %check_file.0.reg2mem194.0.check_file.0.reload195 = load ptr, ptr %check_file.0.reg2mem194, align 8
  store ptr %in_file.034.reg2mem196.0.in_file.034.reload197, ptr %in_file.034.reg2mem, align 8
  store ptr %check_file.0.reg2mem194.0.check_file.0.reload195, ptr %check_file.0.reg2mem, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1520, !tbaa !346
  %conv = sext i32 %2 to i64, !dbg !1520
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #19, !dbg !1521
    #dbg_value(ptr %call, !1503, !DIExpression(), !1507)
  store ptr %call, ptr %call.reg2mem, align 8
  %cmp8.not = icmp eq ptr %call, null, !dbg !1522
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1522

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.18, ptr noundef nonnull @.str.2.16, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1522
  unreachable, !dbg !1522

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.034.reg2mem196.0.in_file.034.reload197, i32 noundef signext 0) #17, !dbg !1525
    #dbg_value(i32 %call14, !1502, !DIExpression(), !1507)
  store i32 %call14, ptr %call14.reg2mem, align 4
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1526
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1526

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.19, ptr noundef nonnull @.str.2.16, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1526
  unreachable, !dbg !1526

if.end20:                                         ; preds = %if.end13
    #dbg_value(i32 %call14, !501, !DIExpression(), !1529)
    #dbg_value(ptr %call, !502, !DIExpression(), !1529)
    #dbg_value(ptr %call, !503, !DIExpression(), !1529)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(32436) %call, i8 0, i64 32436, i1 false), !dbg !1531
  %call.i = tail call ptr @readfile(i32 noundef signext %call14) #17, !dbg !1532
    #dbg_value(ptr %call.i, !504, !DIExpression(), !1529)
    #dbg_value(ptr %call.i, !509, !DIExpression(), !1533)
    #dbg_value(i32 1, !514, !DIExpression(), !1533)
    #dbg_value(i32 0, !515, !DIExpression(), !1533)
  store ptr %call.i, ptr %call.i.reg2mem, align 8
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem190, align 8
  store i32 0, ptr %i.041.i.i.reg2mem192, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end20
    #dbg_value(i32 %i.041.i.i.reg2mem192.0.load, !515, !DIExpression(), !1533)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem190.0.s.addr.040.i.i.reload191, !509, !DIExpression(), !1533)
  %i.041.i.i.reg2mem192.0.load = load i32, ptr %i.041.i.i.reg2mem192, align 4
  %s.addr.040.i.i.reg2mem190.0.s.addr.040.i.i.reload191 = load ptr, ptr %s.addr.040.i.i.reg2mem190, align 8
  store i32 %i.041.i.i.reg2mem192.0.load, ptr %i.041.i.i.reg2mem, align 4
  store ptr %s.addr.040.i.i.reg2mem190.0.s.addr.040.i.i.reload191, ptr %s.addr.040.i.i.reg2mem, align 8
  %3 = load i8, ptr %s.addr.040.i.i.reg2mem190.0.s.addr.040.i.i.reload191, align 1, !dbg !1535, !tbaa !355
  switch i8 %3, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.parse_string.exit.i_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1536

land.rhs.i.i.parse_string.exit.i_crit_edge:       ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem190.0.s.addr.040.i.i.reload191, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %parse_string.exit.i, !dbg !1536

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem192.0.load, ptr %i.1.i.i.reg2mem188, align 4
  br label %if.end21.i.i, !dbg !1536

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem190.0.s.addr.040.i.i.reload191, i64 1, !dbg !1537
  %4 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !1537, !tbaa !355
  %cmp13.i.i = icmp eq i8 %4, 37, !dbg !1538
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1539

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem192.0.load, ptr %i.1.i.i.reg2mem188, align 4
  br label %if.end21.i.i, !dbg !1539

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem190.0.s.addr.040.i.i.reload191, i64 2, !dbg !1540
  %5 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1540, !tbaa !355
  %cmp18.i.i = icmp eq i8 %5, 10, !dbg !1541
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1542
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem192.0.load, %inc.i.i, !dbg !1542
  store i32 %spec.select.i.i, ptr %spec.select.i.i.reg2mem, align 4
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem188, align 4
  br label %if.end21.i.i, !dbg !1542

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem188.0.load, !515, !DIExpression(), !1533)
  %i.1.i.i.reg2mem188.0.load = load i32, ptr %i.1.i.i.reg2mem188, align 4
  store i32 %i.1.i.i.reg2mem188.0.load, ptr %i.1.i.i.reg2mem, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem190.0.s.addr.040.i.i.reload191, i64 1, !dbg !1543
    #dbg_value(ptr %incdec.ptr.i.i, !509, !DIExpression(), !1533)
  store ptr %incdec.ptr.i.i, ptr %incdec.ptr.i.i.reg2mem, align 8
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem188.0.load, 1, !dbg !1544
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1545, !llvm.loop !1546

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem190, align 8
  store i32 %i.1.i.i.reg2mem188.0.load, ptr %i.041.i.i.reg2mem192, align 4
  br label %land.rhs.i.i, !dbg !1545

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1548, !tbaa !355
  %6 = icmp eq i8 %.pre.i.i, 0, !dbg !1549
  %7 = select i1 %6, i64 0, i64 2, !dbg !1550
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %7, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %parse_string.exit.i, !dbg !1545

parse_string.exit.i:                              ; preds = %land.rhs.i.i.parse_string.exit.i_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1550
    #dbg_value(ptr %spec.select38.i.i, !505, !DIExpression(), !1529)
    #dbg_value(ptr %spec.select38.i.i, !537, !DIExpression(), !1551)
    #dbg_value(ptr %call, !542, !DIExpression(), !1551)
    #dbg_value(i32 4, !543, !DIExpression(), !1551)
    #dbg_value(i32 4, !544, !DIExpression(), !1551)
  %8 = load i32, ptr %spec.select38.i.i, align 1, !dbg !1553
  store i32 %8, ptr %call, align 1, !dbg !1553
    #dbg_value(ptr %call.i, !509, !DIExpression(), !1554)
    #dbg_value(i32 2, !514, !DIExpression(), !1554)
    #dbg_value(i32 0, !515, !DIExpression(), !1554)
  store ptr %call.i, ptr %s.addr.040.i3.i.reg2mem184, align 8
  store i32 0, ptr %i.041.i2.i.reg2mem186, align 4
  br label %land.rhs.i1.i

land.rhs.i1.i:                                    ; preds = %if.end21.i7.i.land.rhs.i1.i_crit_edge, %parse_string.exit.i
    #dbg_value(i32 %i.041.i2.i.reg2mem186.0.load, !515, !DIExpression(), !1554)
    #dbg_value(ptr %s.addr.040.i3.i.reg2mem184.0.s.addr.040.i3.i.reload185, !509, !DIExpression(), !1554)
  %i.041.i2.i.reg2mem186.0.load = load i32, ptr %i.041.i2.i.reg2mem186, align 4
  %s.addr.040.i3.i.reg2mem184.0.s.addr.040.i3.i.reload185 = load ptr, ptr %s.addr.040.i3.i.reg2mem184, align 8
  %9 = load i8, ptr %s.addr.040.i3.i.reg2mem184.0.s.addr.040.i3.i.reload185, align 1, !dbg !1556, !tbaa !355
  switch i8 %9, label %land.rhs.i1.i.if.end21.i7.i_crit_edge [
    i8 0, label %land.rhs.i1.i.input_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i4.i
  ], !dbg !1557

land.rhs.i1.i.input_to_data.exit_crit_edge:       ; preds = %land.rhs.i1.i
  store ptr %s.addr.040.i3.i.reg2mem184.0.s.addr.040.i3.i.reload185, ptr %s.addr.0.lcssa.ph.i14.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.i.reg2mem, align 8
  br label %input_to_data.exit, !dbg !1557

land.rhs.i1.i.if.end21.i7.i_crit_edge:            ; preds = %land.rhs.i1.i
  store i32 %i.041.i2.i.reg2mem186.0.load, ptr %i.1.i8.i.reg2mem182, align 4
  br label %if.end21.i7.i, !dbg !1557

land.lhs.true10.i4.i:                             ; preds = %land.rhs.i1.i
  %arrayidx11.i5.i = getelementptr inbounds i8, ptr %s.addr.040.i3.i.reg2mem184.0.s.addr.040.i3.i.reload185, i64 1, !dbg !1558
  %10 = load i8, ptr %arrayidx11.i5.i, align 1, !dbg !1558, !tbaa !355
  %cmp13.i6.i = icmp eq i8 %10, 37, !dbg !1559
  br i1 %cmp13.i6.i, label %land.lhs.true15.i16.i, label %land.lhs.true10.i4.i.if.end21.i7.i_crit_edge, !dbg !1560

land.lhs.true10.i4.i.if.end21.i7.i_crit_edge:     ; preds = %land.lhs.true10.i4.i
  store i32 %i.041.i2.i.reg2mem186.0.load, ptr %i.1.i8.i.reg2mem182, align 4
  br label %if.end21.i7.i, !dbg !1560

land.lhs.true15.i16.i:                            ; preds = %land.lhs.true10.i4.i
  %arrayidx16.i17.i = getelementptr inbounds i8, ptr %s.addr.040.i3.i.reg2mem184.0.s.addr.040.i3.i.reload185, i64 2, !dbg !1561
  %11 = load i8, ptr %arrayidx16.i17.i, align 1, !dbg !1561, !tbaa !355
  %cmp18.i18.i = icmp eq i8 %11, 10, !dbg !1562
  %inc.i19.i = zext i1 %cmp18.i18.i to i32, !dbg !1563
  %spec.select.i20.i = add nsw i32 %i.041.i2.i.reg2mem186.0.load, %inc.i19.i, !dbg !1563
  store i32 %spec.select.i20.i, ptr %i.1.i8.i.reg2mem182, align 4
  br label %if.end21.i7.i, !dbg !1563

if.end21.i7.i:                                    ; preds = %land.lhs.true10.i4.i.if.end21.i7.i_crit_edge, %land.rhs.i1.i.if.end21.i7.i_crit_edge, %land.lhs.true15.i16.i
    #dbg_value(i32 %i.1.i8.i.reg2mem182.0.load, !515, !DIExpression(), !1554)
  %i.1.i8.i.reg2mem182.0.load = load i32, ptr %i.1.i8.i.reg2mem182, align 4
  %incdec.ptr.i9.i = getelementptr inbounds i8, ptr %s.addr.040.i3.i.reg2mem184.0.s.addr.040.i3.i.reload185, i64 1, !dbg !1564
    #dbg_value(ptr %incdec.ptr.i9.i, !509, !DIExpression(), !1554)
  %cmp4.i10.i = icmp slt i32 %i.1.i8.i.reg2mem182.0.load, 2, !dbg !1565
  br i1 %cmp4.i10.i, label %if.end21.i7.i.land.rhs.i1.i_crit_edge, label %if.end21.while.end_crit_edge.i11.i, !dbg !1566, !llvm.loop !1567

if.end21.i7.i.land.rhs.i1.i_crit_edge:            ; preds = %if.end21.i7.i
  store ptr %incdec.ptr.i9.i, ptr %s.addr.040.i3.i.reg2mem184, align 8
  store i32 %i.1.i8.i.reg2mem182.0.load, ptr %i.041.i2.i.reg2mem186, align 4
  br label %land.rhs.i1.i, !dbg !1566

if.end21.while.end_crit_edge.i11.i:               ; preds = %if.end21.i7.i
  %.pre.i12.i = load i8, ptr %incdec.ptr.i9.i, align 1, !dbg !1569, !tbaa !355
  %12 = icmp eq i8 %.pre.i12.i, 0, !dbg !1570
  %13 = select i1 %12, i64 0, i64 2, !dbg !1571
  store ptr %incdec.ptr.i9.i, ptr %s.addr.0.lcssa.ph.i14.i.reg2mem, align 8
  store i64 %13, ptr %cmp23.not.i13.i.reg2mem, align 8
  br label %input_to_data.exit, !dbg !1566

input_to_data.exit:                               ; preds = %land.rhs.i1.i.input_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i11.i
  %cmp23.not.i13.i.reg2mem.0.load = load i64, ptr %cmp23.not.i13.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.i.reg2mem.0.s.addr.0.lcssa.ph.i14.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.i.reg2mem, align 8
  %spec.select38.i15.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.i.reg2mem.0.s.addr.0.lcssa.ph.i14.i.reload, i64 %cmp23.not.i13.i.reg2mem.0.load, !dbg !1571
    #dbg_value(ptr %spec.select38.i15.i, !505, !DIExpression(), !1529)
  %input.i = getelementptr inbounds i8, ptr %call, i64 4, !dbg !1572
    #dbg_value(ptr %spec.select38.i15.i, !537, !DIExpression(), !1573)
    #dbg_value(ptr %input.i, !542, !DIExpression(), !1573)
    #dbg_value(i32 32411, !543, !DIExpression(), !1573)
    #dbg_value(i32 32411, !544, !DIExpression(), !1573)
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(32411) %input.i, ptr noundef nonnull readonly align 1 dereferenceable(32411) %spec.select38.i15.i, i64 32411, i1 false), !dbg !1575
  tail call void @free(ptr noundef %call.i) #17, !dbg !1576
    #dbg_value(ptr %call, !444, !DIExpression(), !1577)
    #dbg_value(ptr %call, !445, !DIExpression(), !1577)
  %kmpNext.i = getelementptr inbounds i8, ptr %call, i64 32416, !dbg !1579
  %n_matches.i = getelementptr inbounds i8, ptr %call, i64 32432, !dbg !1580
    #dbg_value(ptr %call, !379, !DIExpression(), !1581)
    #dbg_value(ptr %input.i, !380, !DIExpression(), !1581)
    #dbg_value(ptr %kmpNext.i, !381, !DIExpression(), !1581)
    #dbg_value(ptr %n_matches.i, !382, !DIExpression(), !1581)
  store ptr %n_matches.i, ptr %n_matches.i.reg2mem, align 8
  store i32 0, ptr %n_matches.i, align 4, !dbg !1583, !tbaa !346
    #dbg_value(ptr %call, !335, !DIExpression(), !1584)
    #dbg_value(ptr %kmpNext.i, !336, !DIExpression(), !1584)
    #dbg_value(i32 0, !337, !DIExpression(), !1584)
  store i32 0, ptr %kmpNext.i, align 4, !dbg !1586, !tbaa !346
    #dbg_label(!339, !1587)
    #dbg_value(i32 1, !338, !DIExpression(), !1584)
  store i32 0, ptr %k.038.i.i.i.reg2mem178, align 4
  store i64 1, ptr %indvars.iv.i.i.i.reg2mem180, align 8
  br label %while.cond.preheader.i.i.i, !dbg !1588

while.cond.preheader.i.i.i:                       ; preds = %while.end.i.i.i.while.cond.preheader.i.i.i_crit_edge, %input_to_data.exit
    #dbg_value(i64 %indvars.iv.i.i.i.reg2mem180.0.load, !338, !DIExpression(), !1584)
    #dbg_value(i32 %k.038.i.i.i.reg2mem178.0.load, !337, !DIExpression(), !1584)
  %indvars.iv.i.i.i.reg2mem180.0.load = load i64, ptr %indvars.iv.i.i.i.reg2mem180, align 8
  %k.038.i.i.i.reg2mem178.0.load = load i32, ptr %k.038.i.i.i.reg2mem178, align 4
  %cmp135.i.i.i = icmp sgt i32 %k.038.i.i.i.reg2mem178.0.load, 0, !dbg !1589
  %arrayidx4.i.i.i = getelementptr inbounds i8, ptr %call, i64 %indvars.iv.i.i.i.reg2mem180.0.load
  %14 = load i8, ptr %arrayidx4.i.i.i, align 1
  br i1 %cmp135.i.i.i, label %land.rhs.lr.ph.i.i.i, label %while.cond.preheader.i.i.i.while.end.i.i.i_crit_edge, !dbg !1590

while.cond.preheader.i.i.i.while.end.i.i.i_crit_edge: ; preds = %while.cond.preheader.i.i.i
  store i32 %k.038.i.i.i.reg2mem178.0.load, ptr %k.1.lcssa.i.i.i.reg2mem, align 4
  br label %while.end.i.i.i, !dbg !1590

land.rhs.lr.ph.i.i.i:                             ; preds = %while.cond.preheader.i.i.i
  %arrayidx9.i.i.i = getelementptr inbounds i32, ptr %kmpNext.i, i64 %indvars.iv.i.i.i.reg2mem180.0.load
  store i32 %k.038.i.i.i.reg2mem178.0.load, ptr %k.136.i.i.i.reg2mem176, align 4
  br label %land.rhs.i.i.i, !dbg !1590

land.rhs.i.i.i:                                   ; preds = %while.body.i.i.i.land.rhs.i.i.i_crit_edge, %land.rhs.lr.ph.i.i.i
    #dbg_value(i32 %k.136.i.i.i.reg2mem176.0.load, !337, !DIExpression(), !1584)
  %k.136.i.i.i.reg2mem176.0.load = load i32, ptr %k.136.i.i.i.reg2mem176, align 4
  %idxprom.i.i.i = zext nneg i32 %k.136.i.i.i.reg2mem176.0.load to i64
  %arrayidx2.i.i.i = getelementptr inbounds i8, ptr %call, i64 %idxprom.i.i.i, !dbg !1591
  %15 = load i8, ptr %arrayidx2.i.i.i, align 1, !dbg !1591, !tbaa !355
  %cmp6.not.i.i.i = icmp eq i8 %15, %14, !dbg !1592
  br i1 %cmp6.not.i.i.i, label %land.rhs.i.i.i.while.end.i.i.i_crit_edge, label %while.body.i.i.i, !dbg !1593

land.rhs.i.i.i.while.end.i.i.i_crit_edge:         ; preds = %land.rhs.i.i.i
  store i32 %k.136.i.i.i.reg2mem176.0.load, ptr %k.1.lcssa.i.i.i.reg2mem, align 4
  br label %while.end.i.i.i, !dbg !1593

while.body.i.i.i:                                 ; preds = %land.rhs.i.i.i
  %16 = load i32, ptr %arrayidx9.i.i.i, align 4, !dbg !1594
    #dbg_value(i32 %16, !337, !DIExpression(), !1584)
  %cmp1.i.i.i = icmp sgt i32 %16, 0, !dbg !1589
  br i1 %cmp1.i.i.i, label %while.body.i.i.i.land.rhs.i.i.i_crit_edge, label %while.body.i.i.i.while.end.i.i.i_crit_edge, !dbg !1590, !llvm.loop !1595

while.body.i.i.i.while.end.i.i.i_crit_edge:       ; preds = %while.body.i.i.i
  store i32 %16, ptr %k.1.lcssa.i.i.i.reg2mem, align 4
  br label %while.end.i.i.i, !dbg !1590

while.body.i.i.i.land.rhs.i.i.i_crit_edge:        ; preds = %while.body.i.i.i
  store i32 %16, ptr %k.136.i.i.i.reg2mem176, align 4
  br label %land.rhs.i.i.i, !dbg !1590

while.end.i.i.i:                                  ; preds = %while.body.i.i.i.while.end.i.i.i_crit_edge, %land.rhs.i.i.i.while.end.i.i.i_crit_edge, %while.cond.preheader.i.i.i.while.end.i.i.i_crit_edge
  %k.1.lcssa.i.i.i.reg2mem.0.load = load i32, ptr %k.1.lcssa.i.i.i.reg2mem, align 4
  %idxprom10.i.i.i = sext i32 %k.1.lcssa.i.i.i.reg2mem.0.load to i64, !dbg !1597
  %arrayidx11.i.i.i = getelementptr inbounds i8, ptr %call, i64 %idxprom10.i.i.i, !dbg !1597
  %17 = load i8, ptr %arrayidx11.i.i.i, align 1, !dbg !1597, !tbaa !355
  %cmp16.i.i.i = icmp eq i8 %17, %14, !dbg !1598
  %inc.i.i.i = zext i1 %cmp16.i.i.i to i32, !dbg !1599
  %spec.select.i.i.i = add nsw i32 %k.1.lcssa.i.i.i.reg2mem.0.load, %inc.i.i.i, !dbg !1599
    #dbg_value(i32 %spec.select.i.i.i, !337, !DIExpression(), !1584)
  %arrayidx19.i.i.i = getelementptr inbounds i32, ptr %kmpNext.i, i64 %indvars.iv.i.i.i.reg2mem180.0.load, !dbg !1600
  store i32 %spec.select.i.i.i, ptr %arrayidx19.i.i.i, align 4, !dbg !1601, !tbaa !346
  %indvars.iv.next.i.i.i = add nuw nsw i64 %indvars.iv.i.i.i.reg2mem180.0.load, 1, !dbg !1602
    #dbg_value(i64 %indvars.iv.next.i.i.i, !338, !DIExpression(), !1584)
  %exitcond.not.i.i.i = icmp eq i64 %indvars.iv.next.i.i.i, 4, !dbg !1603
  br i1 %exitcond.not.i.i.i, label %for.cond.preheader.i.i, label %while.end.i.i.i.while.cond.preheader.i.i.i_crit_edge, !dbg !1588, !llvm.loop !1604

while.end.i.i.i.while.cond.preheader.i.i.i_crit_edge: ; preds = %while.end.i.i.i
  store i32 %spec.select.i.i.i, ptr %k.038.i.i.i.reg2mem178, align 4
  store i64 %indvars.iv.next.i.i.i, ptr %indvars.iv.i.i.i.reg2mem180, align 8
  br label %while.cond.preheader.i.i.i, !dbg !1588

for.cond.preheader.i.i:                           ; preds = %while.end.i.i.i
  %invariant.gep.i.i = getelementptr i8, ptr %call, i64 32412, !dbg !1606
    #dbg_value(i32 0, !384, !DIExpression(), !1581)
    #dbg_value(i32 0, !383, !DIExpression(), !1581)
  store i32 0, ptr %q.046.i.i.reg2mem172, align 4
  store i64 0, ptr %indvars.iv.i.i.reg2mem174, align 8
  br label %while.cond.preheader.i.i, !dbg !1606

while.cond.preheader.i.i:                         ; preds = %for.inc.i.i.while.cond.preheader.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i.reg2mem174.0.load, !383, !DIExpression(), !1581)
    #dbg_value(i32 %q.046.i.i.reg2mem172.0.load, !384, !DIExpression(), !1581)
  %indvars.iv.i.i.reg2mem174.0.load = load i64, ptr %indvars.iv.i.i.reg2mem174, align 8
  %q.046.i.i.reg2mem172.0.load = load i32, ptr %q.046.i.i.reg2mem172, align 4
  %cmp142.i.i = icmp sgt i32 %q.046.i.i.reg2mem172.0.load, 0, !dbg !1607
  %arrayidx4.i.i = getelementptr inbounds i8, ptr %input.i, i64 %indvars.iv.i.i.reg2mem174.0.load
  %18 = load i8, ptr %arrayidx4.i.i, align 1
  br i1 %cmp142.i.i, label %while.cond.preheader.i.i.land.rhs.i.i6_crit_edge, label %while.cond.preheader.i.i.while.end.i.i_crit_edge, !dbg !1608

while.cond.preheader.i.i.while.end.i.i_crit_edge: ; preds = %while.cond.preheader.i.i
  store i32 %q.046.i.i.reg2mem172.0.load, ptr %q.1.lcssa.i.i.reg2mem, align 4
  br label %while.end.i.i, !dbg !1608

while.cond.preheader.i.i.land.rhs.i.i6_crit_edge: ; preds = %while.cond.preheader.i.i
  store i32 %q.046.i.i.reg2mem172.0.load, ptr %q.143.i.i.reg2mem170, align 4
  br label %land.rhs.i.i6, !dbg !1608

land.rhs.i.i6:                                    ; preds = %while.body.i.i.land.rhs.i.i6_crit_edge, %while.cond.preheader.i.i.land.rhs.i.i6_crit_edge
    #dbg_value(i32 %q.143.i.i.reg2mem170.0.load, !384, !DIExpression(), !1581)
  %q.143.i.i.reg2mem170.0.load = load i32, ptr %q.143.i.i.reg2mem170, align 4
  %idxprom.i.i = zext nneg i32 %q.143.i.i.reg2mem170.0.load to i64
  %call.reg2mem.0.call.reload145 = load ptr, ptr %call.reg2mem, align 8
  %arrayidx2.i.i = getelementptr inbounds i8, ptr %call.reg2mem.0.call.reload145, i64 %idxprom.i.i, !dbg !1609
  %19 = load i8, ptr %arrayidx2.i.i, align 1, !dbg !1609, !tbaa !355
  %cmp6.not.i.i = icmp eq i8 %19, %18, !dbg !1610
  br i1 %cmp6.not.i.i, label %land.rhs.i.i6.while.end.i.i_crit_edge, label %while.body.i.i, !dbg !1611

land.rhs.i.i6.while.end.i.i_crit_edge:            ; preds = %land.rhs.i.i6
  store i32 %q.143.i.i.reg2mem170.0.load, ptr %q.1.lcssa.i.i.reg2mem, align 4
  br label %while.end.i.i, !dbg !1611

while.body.i.i:                                   ; preds = %land.rhs.i.i6
  %arrayidx9.i.i = getelementptr inbounds i32, ptr %kmpNext.i, i64 %idxprom.i.i, !dbg !1612
  %20 = load i32, ptr %arrayidx9.i.i, align 4, !dbg !1612
    #dbg_value(i32 %20, !384, !DIExpression(), !1581)
  %cmp1.i.i = icmp sgt i32 %20, 0, !dbg !1607
  br i1 %cmp1.i.i, label %while.body.i.i.land.rhs.i.i6_crit_edge, label %while.body.i.i.while.end.i.i_crit_edge, !dbg !1608, !llvm.loop !1613

while.body.i.i.while.end.i.i_crit_edge:           ; preds = %while.body.i.i
  store i32 %20, ptr %q.1.lcssa.i.i.reg2mem, align 4
  br label %while.end.i.i, !dbg !1608

while.body.i.i.land.rhs.i.i6_crit_edge:           ; preds = %while.body.i.i
  store i32 %20, ptr %q.143.i.i.reg2mem170, align 4
  br label %land.rhs.i.i6, !dbg !1608

while.end.i.i:                                    ; preds = %while.body.i.i.while.end.i.i_crit_edge, %land.rhs.i.i6.while.end.i.i_crit_edge, %while.cond.preheader.i.i.while.end.i.i_crit_edge
  %q.1.lcssa.i.i.reg2mem.0.load = load i32, ptr %q.1.lcssa.i.i.reg2mem, align 4
  %idxprom10.i.i = sext i32 %q.1.lcssa.i.i.reg2mem.0.load to i64, !dbg !1615
  %call.reg2mem.0.call.reload146 = load ptr, ptr %call.reg2mem, align 8
  %arrayidx11.i.i2 = getelementptr inbounds i8, ptr %call.reg2mem.0.call.reload146, i64 %idxprom10.i.i, !dbg !1615
  %21 = load i8, ptr %arrayidx11.i.i2, align 1, !dbg !1615, !tbaa !355
  %cmp16.i.i = icmp eq i8 %21, %18, !dbg !1616
  %inc.i.i3 = zext i1 %cmp16.i.i to i32, !dbg !1617
  %spec.select.i.i4 = add nsw i32 %q.1.lcssa.i.i.reg2mem.0.load, %inc.i.i3, !dbg !1617
    #dbg_value(i32 %spec.select.i.i4, !384, !DIExpression(), !1581)
  %cmp18.i.i5 = icmp sgt i32 %spec.select.i.i4, 3, !dbg !1618
  br i1 %cmp18.i.i5, label %if.then20.i.i, label %while.end.i.i.for.inc.i.i_crit_edge, !dbg !1619

while.end.i.i.for.inc.i.i_crit_edge:              ; preds = %while.end.i.i
  store i32 %spec.select.i.i4, ptr %q.3.i.i.reg2mem168, align 4
  br label %for.inc.i.i, !dbg !1619

if.then20.i.i:                                    ; preds = %while.end.i.i
  %22 = load i32, ptr %n_matches.i, align 4, !dbg !1620, !tbaa !346
  %inc22.i.i = add nsw i32 %22, 1, !dbg !1620
  store i32 %inc22.i.i, ptr %n_matches.i, align 4, !dbg !1620, !tbaa !346
  %23 = zext nneg i32 %spec.select.i.i4 to i64, !dbg !1621
  %gep.i.i = getelementptr i32, ptr %invariant.gep.i.i, i64 %23, !dbg !1621
  %24 = load i32, ptr %gep.i.i, align 4, !dbg !1621
    #dbg_value(i32 %24, !384, !DIExpression(), !1581)
  store i32 %24, ptr %q.3.i.i.reg2mem168, align 4
  br label %for.inc.i.i, !dbg !1622

for.inc.i.i:                                      ; preds = %while.end.i.i.for.inc.i.i_crit_edge, %if.then20.i.i
    #dbg_value(i32 %q.3.i.i.reg2mem168.0.load, !384, !DIExpression(), !1581)
  %q.3.i.i.reg2mem168.0.load = load i32, ptr %q.3.i.i.reg2mem168, align 4
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem174.0.load, 1, !dbg !1623
    #dbg_value(i64 %indvars.iv.next.i.i, !383, !DIExpression(), !1581)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 32411, !dbg !1624
  br i1 %exitcond.not.i.i, label %run_benchmark.exit, label %for.inc.i.i.while.cond.preheader.i.i_crit_edge, !dbg !1606, !llvm.loop !1625

for.inc.i.i.while.cond.preheader.i.i_crit_edge:   ; preds = %for.inc.i.i
  store i32 %q.3.i.i.reg2mem168.0.load, ptr %q.046.i.i.reg2mem172, align 4
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem174, align 8
  br label %while.cond.preheader.i.i, !dbg !1606

run_benchmark.exit:                               ; preds = %for.inc.i.i
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #17, !dbg !1627
    #dbg_value(i32 %call21, !1504, !DIExpression(), !1507)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1628
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1628

if.else26:                                        ; preds = %run_benchmark.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.16, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1628
  unreachable, !dbg !1628

if.end27:                                         ; preds = %run_benchmark.exit
    #dbg_value(i32 %call21, !632, !DIExpression(), !1631)
    #dbg_value(ptr %call, !633, !DIExpression(), !1631)
    #dbg_value(ptr %call, !634, !DIExpression(), !1631)
    #dbg_value(i32 %call21, !580, !DIExpression(), !1633)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1635
  br i1 %cmp.i.i.not, label %if.else.i.i, label %data_to_output.exit, !dbg !1635

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #18, !dbg !1635
  unreachable, !dbg !1635

data_to_output.exit:                              ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1636
    #dbg_value(i32 %call21, !641, !DIExpression(), !1637)
    #dbg_value(ptr %n_matches.i, !646, !DIExpression(), !1637)
    #dbg_value(i32 1, !647, !DIExpression(), !1637)
    #dbg_value(i64 0, !648, !DIExpression(), !1637)
  %25 = load i32, ptr %n_matches.i, align 4, !dbg !1639, !tbaa !346
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.19, i32 noundef signext %25), !dbg !1639
    #dbg_value(i64 1, !648, !DIExpression(), !1637)
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #17, !dbg !1640
  %26 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1641, !tbaa !346
  %conv29 = sext i32 %26 to i64, !dbg !1641
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #19, !dbg !1642
    #dbg_value(ptr %call30, !1506, !DIExpression(), !1507)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1643
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1643

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.20, ptr noundef nonnull @.str.2.16, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1643
  unreachable, !dbg !1643

if.end36:                                         ; preds = %data_to_output.exit
  %check_file.0.reg2mem.0.check_file.0.reload = load ptr, ptr %check_file.0.reg2mem, align 8
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem.0.check_file.0.reload, i32 noundef signext 0) #17, !dbg !1646
    #dbg_value(i32 %call37, !1505, !DIExpression(), !1507)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1647
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1647

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.21, ptr noundef nonnull @.str.2.16, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #18, !dbg !1647
  unreachable, !dbg !1647

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !600, !DIExpression(), !1650)
    #dbg_value(ptr %call30, !601, !DIExpression(), !1650)
    #dbg_value(ptr %call30, !602, !DIExpression(), !1650)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(32436) %call30, i8 0, i64 32436, i1 false), !dbg !1652
  %call.i9 = tail call ptr @readfile(i32 noundef signext %call37) #17, !dbg !1653
    #dbg_value(ptr %call.i9, !603, !DIExpression(), !1650)
    #dbg_value(ptr %call.i9, !509, !DIExpression(), !1654)
    #dbg_value(i32 1, !514, !DIExpression(), !1654)
    #dbg_value(i32 0, !515, !DIExpression(), !1654)
  store ptr %call.i9, ptr %s.addr.040.i.i12.reg2mem164, align 8
  store i32 0, ptr %i.041.i.i11.reg2mem166, align 4
  br label %land.rhs.i.i10

land.rhs.i.i10:                                   ; preds = %if.end21.i.i16.land.rhs.i.i10_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i11.reg2mem166.0.load, !515, !DIExpression(), !1654)
    #dbg_value(ptr %s.addr.040.i.i12.reg2mem164.0.s.addr.040.i.i12.reload165, !509, !DIExpression(), !1654)
  %i.041.i.i11.reg2mem166.0.load = load i32, ptr %i.041.i.i11.reg2mem166, align 4
  %s.addr.040.i.i12.reg2mem164.0.s.addr.040.i.i12.reload165 = load ptr, ptr %s.addr.040.i.i12.reg2mem164, align 8
  %27 = load i8, ptr %s.addr.040.i.i12.reg2mem164.0.s.addr.040.i.i12.reload165, align 1, !dbg !1656, !tbaa !355
  switch i8 %27, label %land.rhs.i.i10.if.end21.i.i16_crit_edge [
    i8 0, label %land.rhs.i.i10.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i13
  ], !dbg !1657

land.rhs.i.i10.output_to_data.exit_crit_edge:     ; preds = %land.rhs.i.i10
  store ptr %s.addr.040.i.i12.reg2mem164.0.s.addr.040.i.i12.reload165, ptr %s.addr.0.lcssa.ph.i.i23.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i22.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1657

land.rhs.i.i10.if.end21.i.i16_crit_edge:          ; preds = %land.rhs.i.i10
  store i32 %i.041.i.i11.reg2mem166.0.load, ptr %i.1.i.i17.reg2mem162, align 4
  br label %if.end21.i.i16, !dbg !1657

land.lhs.true10.i.i13:                            ; preds = %land.rhs.i.i10
  %arrayidx11.i.i14 = getelementptr inbounds i8, ptr %s.addr.040.i.i12.reg2mem164.0.s.addr.040.i.i12.reload165, i64 1, !dbg !1658
  %28 = load i8, ptr %arrayidx11.i.i14, align 1, !dbg !1658, !tbaa !355
  %cmp13.i.i15 = icmp eq i8 %28, 37, !dbg !1659
  br i1 %cmp13.i.i15, label %land.lhs.true15.i.i26, label %land.lhs.true10.i.i13.if.end21.i.i16_crit_edge, !dbg !1660

land.lhs.true10.i.i13.if.end21.i.i16_crit_edge:   ; preds = %land.lhs.true10.i.i13
  store i32 %i.041.i.i11.reg2mem166.0.load, ptr %i.1.i.i17.reg2mem162, align 4
  br label %if.end21.i.i16, !dbg !1660

land.lhs.true15.i.i26:                            ; preds = %land.lhs.true10.i.i13
  %arrayidx16.i.i27 = getelementptr inbounds i8, ptr %s.addr.040.i.i12.reg2mem164.0.s.addr.040.i.i12.reload165, i64 2, !dbg !1661
  %29 = load i8, ptr %arrayidx16.i.i27, align 1, !dbg !1661, !tbaa !355
  %cmp18.i.i28 = icmp eq i8 %29, 10, !dbg !1662
  %inc.i.i29 = zext i1 %cmp18.i.i28 to i32, !dbg !1663
  %spec.select.i.i30 = add nsw i32 %i.041.i.i11.reg2mem166.0.load, %inc.i.i29, !dbg !1663
  store i32 %spec.select.i.i30, ptr %i.1.i.i17.reg2mem162, align 4
  br label %if.end21.i.i16, !dbg !1663

if.end21.i.i16:                                   ; preds = %land.lhs.true10.i.i13.if.end21.i.i16_crit_edge, %land.rhs.i.i10.if.end21.i.i16_crit_edge, %land.lhs.true15.i.i26
    #dbg_value(i32 %i.1.i.i17.reg2mem162.0.load, !515, !DIExpression(), !1654)
  %i.1.i.i17.reg2mem162.0.load = load i32, ptr %i.1.i.i17.reg2mem162, align 4
  %incdec.ptr.i.i18 = getelementptr inbounds i8, ptr %s.addr.040.i.i12.reg2mem164.0.s.addr.040.i.i12.reload165, i64 1, !dbg !1664
    #dbg_value(ptr %incdec.ptr.i.i18, !509, !DIExpression(), !1654)
  %cmp4.i.i19 = icmp slt i32 %i.1.i.i17.reg2mem162.0.load, 1, !dbg !1665
  br i1 %cmp4.i.i19, label %if.end21.i.i16.land.rhs.i.i10_crit_edge, label %if.end21.while.end_crit_edge.i.i20, !dbg !1666, !llvm.loop !1667

if.end21.i.i16.land.rhs.i.i10_crit_edge:          ; preds = %if.end21.i.i16
  store ptr %incdec.ptr.i.i18, ptr %s.addr.040.i.i12.reg2mem164, align 8
  store i32 %i.1.i.i17.reg2mem162.0.load, ptr %i.041.i.i11.reg2mem166, align 4
  br label %land.rhs.i.i10, !dbg !1666

if.end21.while.end_crit_edge.i.i20:               ; preds = %if.end21.i.i16
  %.pre.i.i21 = load i8, ptr %incdec.ptr.i.i18, align 1, !dbg !1669, !tbaa !355
  %30 = icmp eq i8 %.pre.i.i21, 0, !dbg !1670
  %31 = select i1 %30, i64 0, i64 2, !dbg !1671
  store ptr %incdec.ptr.i.i18, ptr %s.addr.0.lcssa.ph.i.i23.reg2mem, align 8
  store i64 %31, ptr %cmp23.not.i.i22.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1666

output_to_data.exit:                              ; preds = %land.rhs.i.i10.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i20
  %cmp23.not.i.i22.reg2mem.0.load = load i64, ptr %cmp23.not.i.i22.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i23.reg2mem.0.s.addr.0.lcssa.ph.i.i23.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i23.reg2mem, align 8
  %spec.select38.i.i24 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i23.reg2mem.0.s.addr.0.lcssa.ph.i.i23.reload, i64 %cmp23.not.i.i22.reg2mem.0.load, !dbg !1671
    #dbg_value(ptr %spec.select38.i.i24, !604, !DIExpression(), !1650)
  %n_matches.i25 = getelementptr inbounds i8, ptr %call30, i64 32432, !dbg !1672
  %call2.i = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i.i24, ptr noundef nonnull %n_matches.i25, i32 noundef signext 1) #17, !dbg !1673
  tail call void @free(ptr noundef %call.i9) #17, !dbg !1674
    #dbg_value(ptr %call, !660, !DIExpression(), !1675)
    #dbg_value(ptr %call30, !661, !DIExpression(), !1675)
    #dbg_value(ptr %call, !662, !DIExpression(), !1675)
    #dbg_value(ptr %call30, !663, !DIExpression(), !1675)
    #dbg_value(i32 0, !664, !DIExpression(), !1675)
  %n_matches.i.reg2mem.0.n_matches.i.reload = load ptr, ptr %n_matches.i.reg2mem, align 8
  %32 = load i32, ptr %n_matches.i.reg2mem.0.n_matches.i.reload, align 4, !dbg !1678, !tbaa !346
  %33 = load i32, ptr %n_matches.i25, align 4, !dbg !1679, !tbaa !346
  %cmp.not.i.not = icmp eq i32 %32, %33, !dbg !1680
    #dbg_value(i1 %cmp.not.i.not, !664, !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value), !1675)
  br i1 %cmp.not.i.not, label %if.end47, label %if.then45, !dbg !1681

if.then45:                                        ; preds = %output_to_data.exit
  %34 = load ptr, ptr @stderr, align 8, !dbg !1682, !tbaa !849
  %35 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %34) #20, !dbg !1684
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1685

if.end47:                                         ; preds = %output_to_data.exit
  %call.reg2mem.0.call.reload155 = load ptr, ptr %call.reg2mem, align 8
  tail call void @free(ptr noundef nonnull %call.reg2mem.0.call.reload155) #17, !dbg !1686
  tail call void @free(ptr noundef nonnull %call30) #17, !dbg !1687
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1688
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1689

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1690
}

; Function Attrs: nofree
declare !dbg !1691 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #16

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #16

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
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

!llvm.dbg.cu = !{!233, !188, !235, !297}
!llvm.ident = !{!318, !318, !318, !318}
!llvm.module.flags = !{!319, !320, !321, !322, !323, !325, !326, !327, !328, !329}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/kmp/kmp")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/kmp/kmp")
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
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !211, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/kmp/kmp")
!190 = !{!191}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 17, size: 259488, elements: !194)
!193 = !DIFile(filename: "./kmp.h", directory: "/home/kelvin/MachSuite/kmp/kmp")
!194 = !{!195, !196, !200, !207}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "pattern", scope: !192, file: !193, line: 18, baseType: !104, size: 32)
!196 = !DIDerivedType(tag: DW_TAG_member, name: "input", scope: !192, file: !193, line: 19, baseType: !197, size: 259288, offset: 32)
!197 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 259288, elements: !198)
!198 = !{!199}
!199 = !DISubrange(count: 32411)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "kmpNext", scope: !192, file: !193, line: 20, baseType: !201, size: 128, offset: 259328)
!201 = !DICompositeType(tag: DW_TAG_array_type, baseType: !202, size: 128, elements: !105)
!202 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !203, line: 26, baseType: !204)
!203 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!204 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !205, line: 41, baseType: !206)
!205 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!206 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "n_matches", scope: !192, file: !193, line: 21, baseType: !208, size: 32, offset: 259456)
!208 = !DICompositeType(tag: DW_TAG_array_type, baseType: !202, size: 32, elements: !209)
!209 = !{!210}
!210 = !DISubrange(count: 1)
!211 = !{!186}
!212 = !DIGlobalVariableExpression(var: !213, expr: !DIExpression())
!213 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !214, isLocal: true, isDefinition: true)
!214 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!215 = !DIGlobalVariableExpression(var: !216, expr: !DIExpression())
!216 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !217, isLocal: true, isDefinition: true)
!217 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!218 = !DIGlobalVariableExpression(var: !219, expr: !DIExpression())
!219 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !220, isLocal: true, isDefinition: true)
!220 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !221)
!221 = !{!222}
!222 = !DISubrange(count: 12)
!223 = !DIGlobalVariableExpression(var: !224, expr: !DIExpression())
!224 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !225, isLocal: true, isDefinition: true)
!225 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!226 = !DIGlobalVariableExpression(var: !227, expr: !DIExpression())
!227 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!228 = !DIGlobalVariableExpression(var: !229, expr: !DIExpression())
!229 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !230, isLocal: true, isDefinition: true)
!230 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!231 = !DIGlobalVariableExpression(var: !232, expr: !DIExpression())
!232 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!233 = distinct !DICompileUnit(language: DW_LANG_C11, file: !234, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!234 = !DIFile(filename: "kmp.c", directory: "/home/kelvin/MachSuite/kmp/kmp")
!235 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !236, globals: !263, splitDebugInlining: false, nameTableKind: None)
!236 = !{!237, !4, !238, !239, !243, !246, !249, !252, !255, !202, !258, !261, !262}
!237 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!238 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!239 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !240, line: 24, baseType: !241)
!240 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!241 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !205, line: 38, baseType: !242)
!242 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!243 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !240, line: 25, baseType: !244)
!244 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !205, line: 40, baseType: !245)
!245 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!246 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !240, line: 26, baseType: !247)
!247 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !205, line: 42, baseType: !248)
!248 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !240, line: 27, baseType: !250)
!250 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !205, line: 45, baseType: !251)
!251 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !203, line: 24, baseType: !253)
!253 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !205, line: 37, baseType: !254)
!254 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!255 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !203, line: 25, baseType: !256)
!256 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !205, line: 39, baseType: !257)
!257 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!258 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !203, line: 27, baseType: !259)
!259 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !205, line: 44, baseType: !260)
!260 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!261 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!262 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
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
!298 = !{!238}
!299 = !{!300, !168, !174, !176, !179, !184, !302, !212, !304, !215, !218, !306, !223, !226, !311, !228, !231, !313}
!300 = !DIGlobalVariableExpression(var: !301, expr: !DIExpression())
!301 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !225, isLocal: true, isDefinition: true)
!302 = !DIGlobalVariableExpression(var: !303, expr: !DIExpression())
!303 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !273, isLocal: true, isDefinition: true)
!304 = !DIGlobalVariableExpression(var: !305, expr: !DIExpression())
!305 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !214, isLocal: true, isDefinition: true)
!306 = !DIGlobalVariableExpression(var: !307, expr: !DIExpression())
!307 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !308, isLocal: true, isDefinition: true)
!308 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !309)
!309 = !{!310}
!310 = !DISubrange(count: 31)
!311 = !DIGlobalVariableExpression(var: !312, expr: !DIExpression())
!312 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !214, isLocal: true, isDefinition: true)
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
!330 = distinct !DISubprogram(name: "CPF", scope: !234, file: !234, line: 7, type: !331, scopeLine: 7, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !233, retainedNodes: !334)
!331 = !DISubroutineType(types: !332)
!332 = !{null, !237, !333}
!333 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !202, size: 64)
!334 = !{!335, !336, !337, !338, !339, !340}
!335 = !DILocalVariable(name: "pattern", arg: 1, scope: !330, file: !234, line: 7, type: !237)
!336 = !DILocalVariable(name: "kmpNext", arg: 2, scope: !330, file: !234, line: 7, type: !333)
!337 = !DILocalVariable(name: "k", scope: !330, file: !234, line: 8, type: !202)
!338 = !DILocalVariable(name: "q", scope: !330, file: !234, line: 8, type: !202)
!339 = !DILabel(scope: !330, name: "c1", file: !234, line: 12)
!340 = !DILabel(scope: !341, name: "c2", file: !234, line: 13)
!341 = distinct !DILexicalBlock(scope: !342, file: !234, line: 12, column: 43)
!342 = distinct !DILexicalBlock(scope: !343, file: !234, line: 12, column: 10)
!343 = distinct !DILexicalBlock(scope: !330, file: !234, line: 12, column: 10)
!344 = !DILocation(line: 0, scope: !330)
!345 = !DILocation(line: 10, column: 16, scope: !330)
!346 = !{!347, !347, i64 0}
!347 = !{!"int", !348, i64 0}
!348 = !{!"omnipotent char", !349, i64 0}
!349 = !{!"Simple C/C++ TBAA"}
!350 = !DILocation(line: 12, column: 5, scope: !330)
!351 = !DILocation(line: 12, column: 10, scope: !343)
!352 = !DILocation(line: 13, column: 22, scope: !341)
!353 = !DILocation(line: 13, column: 26, scope: !341)
!354 = !DILocation(line: 13, column: 29, scope: !341)
!355 = !{!348, !348, i64 0}
!356 = !DILocation(line: 13, column: 40, scope: !341)
!357 = !DILocation(line: 13, column: 14, scope: !341)
!358 = !DILocation(line: 14, column: 17, scope: !359)
!359 = distinct !DILexicalBlock(scope: !341, file: !234, line: 13, column: 54)
!360 = distinct !{!360, !357, !361, !362, !363}
!361 = !DILocation(line: 15, column: 9, scope: !341)
!362 = !{!"llvm.loop.mustprogress"}
!363 = !{!"llvm.loop.unroll.disable"}
!364 = !DILocation(line: 16, column: 12, scope: !365)
!365 = distinct !DILexicalBlock(scope: !341, file: !234, line: 16, column: 12)
!366 = !DILocation(line: 16, column: 23, scope: !365)
!367 = !DILocation(line: 16, column: 12, scope: !341)
!368 = !DILocation(line: 19, column: 9, scope: !341)
!369 = !DILocation(line: 19, column: 20, scope: !341)
!370 = !DILocation(line: 12, column: 40, scope: !342)
!371 = !DILocation(line: 12, column: 23, scope: !342)
!372 = distinct !{!372, !351, !373, !362, !363}
!373 = !DILocation(line: 20, column: 5, scope: !343)
!374 = !DILocation(line: 21, column: 1, scope: !330)
!375 = distinct !DISubprogram(name: "kmp", scope: !234, file: !234, line: 24, type: !376, scopeLine: 24, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !233, retainedNodes: !378)
!376 = !DISubroutineType(types: !377)
!377 = !{!206, !237, !237, !333, !333}
!378 = !{!379, !380, !381, !382, !383, !384, !385, !386}
!379 = !DILocalVariable(name: "pattern", arg: 1, scope: !375, file: !234, line: 24, type: !237)
!380 = !DILocalVariable(name: "input", arg: 2, scope: !375, file: !234, line: 24, type: !237)
!381 = !DILocalVariable(name: "kmpNext", arg: 3, scope: !375, file: !234, line: 24, type: !333)
!382 = !DILocalVariable(name: "n_matches", arg: 4, scope: !375, file: !234, line: 24, type: !333)
!383 = !DILocalVariable(name: "i", scope: !375, file: !234, line: 25, type: !202)
!384 = !DILocalVariable(name: "q", scope: !375, file: !234, line: 25, type: !202)
!385 = !DILabel(scope: !375, name: "k1", file: !234, line: 31)
!386 = !DILabel(scope: !387, name: "k2", file: !234, line: 32)
!387 = distinct !DILexicalBlock(scope: !388, file: !234, line: 31, column: 42)
!388 = distinct !DILexicalBlock(scope: !389, file: !234, line: 31, column: 10)
!389 = distinct !DILexicalBlock(scope: !375, file: !234, line: 31, column: 10)
!390 = !DILocation(line: 0, scope: !375)
!391 = !DILocation(line: 26, column: 18, scope: !375)
!392 = !DILocation(line: 0, scope: !330, inlinedAt: !393)
!393 = distinct !DILocation(line: 28, column: 5, scope: !375)
!394 = !DILocation(line: 10, column: 16, scope: !330, inlinedAt: !393)
!395 = !DILocation(line: 12, column: 5, scope: !330, inlinedAt: !393)
!396 = !DILocation(line: 12, column: 10, scope: !343, inlinedAt: !393)
!397 = !DILocation(line: 13, column: 22, scope: !341, inlinedAt: !393)
!398 = !DILocation(line: 13, column: 26, scope: !341, inlinedAt: !393)
!399 = !DILocation(line: 13, column: 29, scope: !341, inlinedAt: !393)
!400 = !DILocation(line: 13, column: 40, scope: !341, inlinedAt: !393)
!401 = !DILocation(line: 13, column: 14, scope: !341, inlinedAt: !393)
!402 = !DILocation(line: 14, column: 17, scope: !359, inlinedAt: !393)
!403 = distinct !{!403, !401, !404, !362, !363}
!404 = !DILocation(line: 15, column: 9, scope: !341, inlinedAt: !393)
!405 = !DILocation(line: 16, column: 12, scope: !365, inlinedAt: !393)
!406 = !DILocation(line: 16, column: 23, scope: !365, inlinedAt: !393)
!407 = !DILocation(line: 16, column: 12, scope: !341, inlinedAt: !393)
!408 = !DILocation(line: 19, column: 9, scope: !341, inlinedAt: !393)
!409 = !DILocation(line: 19, column: 20, scope: !341, inlinedAt: !393)
!410 = !DILocation(line: 12, column: 40, scope: !342, inlinedAt: !393)
!411 = !DILocation(line: 12, column: 23, scope: !342, inlinedAt: !393)
!412 = distinct !{!412, !396, !413, !362, !363}
!413 = !DILocation(line: 20, column: 5, scope: !343, inlinedAt: !393)
!414 = !DILocation(line: 31, column: 10, scope: !389)
!415 = !DILocation(line: 32, column: 23, scope: !387)
!416 = !DILocation(line: 32, column: 27, scope: !387)
!417 = !DILocation(line: 32, column: 30, scope: !387)
!418 = !DILocation(line: 32, column: 41, scope: !387)
!419 = !DILocation(line: 32, column: 14, scope: !387)
!420 = !DILocation(line: 33, column: 17, scope: !421)
!421 = distinct !DILexicalBlock(scope: !387, file: !234, line: 32, column: 53)
!422 = distinct !{!422, !419, !423, !362, !363}
!423 = !DILocation(line: 34, column: 9, scope: !387)
!424 = !DILocation(line: 35, column: 13, scope: !425)
!425 = distinct !DILexicalBlock(scope: !387, file: !234, line: 35, column: 13)
!426 = !DILocation(line: 35, column: 24, scope: !425)
!427 = !DILocation(line: 35, column: 13, scope: !387)
!428 = !DILocation(line: 38, column: 15, scope: !429)
!429 = distinct !DILexicalBlock(scope: !387, file: !234, line: 38, column: 13)
!430 = !DILocation(line: 38, column: 13, scope: !387)
!431 = !DILocation(line: 39, column: 25, scope: !432)
!432 = distinct !DILexicalBlock(scope: !429, file: !234, line: 38, column: 31)
!433 = !DILocation(line: 40, column: 17, scope: !432)
!434 = !DILocation(line: 41, column: 9, scope: !432)
!435 = !DILocation(line: 31, column: 39, scope: !388)
!436 = !DILocation(line: 31, column: 23, scope: !388)
!437 = distinct !{!437, !414, !438, !362, !363}
!438 = !DILocation(line: 42, column: 5, scope: !389)
!439 = !DILocation(line: 43, column: 5, scope: !375)
!440 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 6, type: !441, scopeLine: 6, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !443)
!441 = !DISubroutineType(types: !442)
!442 = !{null, !238}
!443 = !{!444, !445}
!444 = !DILocalVariable(name: "vargs", arg: 1, scope: !440, file: !189, line: 6, type: !238)
!445 = !DILocalVariable(name: "args", scope: !440, file: !189, line: 7, type: !191)
!446 = !DILocation(line: 0, scope: !440)
!447 = !DILocation(line: 8, column: 42, scope: !440)
!448 = !DILocation(line: 8, column: 57, scope: !440)
!449 = !DILocation(line: 0, scope: !375, inlinedAt: !450)
!450 = distinct !DILocation(line: 8, column: 3, scope: !440)
!451 = !DILocation(line: 26, column: 18, scope: !375, inlinedAt: !450)
!452 = !DILocation(line: 0, scope: !330, inlinedAt: !453)
!453 = distinct !DILocation(line: 28, column: 5, scope: !375, inlinedAt: !450)
!454 = !DILocation(line: 10, column: 16, scope: !330, inlinedAt: !453)
!455 = !DILocation(line: 12, column: 5, scope: !330, inlinedAt: !453)
!456 = !DILocation(line: 12, column: 10, scope: !343, inlinedAt: !453)
!457 = !DILocation(line: 13, column: 22, scope: !341, inlinedAt: !453)
!458 = !DILocation(line: 13, column: 26, scope: !341, inlinedAt: !453)
!459 = !DILocation(line: 13, column: 29, scope: !341, inlinedAt: !453)
!460 = !DILocation(line: 13, column: 40, scope: !341, inlinedAt: !453)
!461 = !DILocation(line: 13, column: 14, scope: !341, inlinedAt: !453)
!462 = !DILocation(line: 14, column: 17, scope: !359, inlinedAt: !453)
!463 = distinct !{!463, !461, !464, !362, !363}
!464 = !DILocation(line: 15, column: 9, scope: !341, inlinedAt: !453)
!465 = !DILocation(line: 16, column: 12, scope: !365, inlinedAt: !453)
!466 = !DILocation(line: 16, column: 23, scope: !365, inlinedAt: !453)
!467 = !DILocation(line: 16, column: 12, scope: !341, inlinedAt: !453)
!468 = !DILocation(line: 19, column: 9, scope: !341, inlinedAt: !453)
!469 = !DILocation(line: 19, column: 20, scope: !341, inlinedAt: !453)
!470 = !DILocation(line: 12, column: 40, scope: !342, inlinedAt: !453)
!471 = !DILocation(line: 12, column: 23, scope: !342, inlinedAt: !453)
!472 = distinct !{!472, !456, !473, !362, !363}
!473 = !DILocation(line: 20, column: 5, scope: !343, inlinedAt: !453)
!474 = !DILocation(line: 8, column: 29, scope: !440)
!475 = !DILocation(line: 31, column: 10, scope: !389, inlinedAt: !450)
!476 = !DILocation(line: 32, column: 23, scope: !387, inlinedAt: !450)
!477 = !DILocation(line: 32, column: 27, scope: !387, inlinedAt: !450)
!478 = !DILocation(line: 32, column: 30, scope: !387, inlinedAt: !450)
!479 = !DILocation(line: 32, column: 41, scope: !387, inlinedAt: !450)
!480 = !DILocation(line: 32, column: 14, scope: !387, inlinedAt: !450)
!481 = !DILocation(line: 33, column: 17, scope: !421, inlinedAt: !450)
!482 = distinct !{!482, !480, !483, !362, !363}
!483 = !DILocation(line: 34, column: 9, scope: !387, inlinedAt: !450)
!484 = !DILocation(line: 35, column: 13, scope: !425, inlinedAt: !450)
!485 = !DILocation(line: 35, column: 24, scope: !425, inlinedAt: !450)
!486 = !DILocation(line: 35, column: 13, scope: !387, inlinedAt: !450)
!487 = !DILocation(line: 38, column: 15, scope: !429, inlinedAt: !450)
!488 = !DILocation(line: 38, column: 13, scope: !387, inlinedAt: !450)
!489 = !DILocation(line: 39, column: 25, scope: !432, inlinedAt: !450)
!490 = !DILocation(line: 40, column: 17, scope: !432, inlinedAt: !450)
!491 = !DILocation(line: 41, column: 9, scope: !432, inlinedAt: !450)
!492 = !DILocation(line: 31, column: 39, scope: !388, inlinedAt: !450)
!493 = !DILocation(line: 31, column: 23, scope: !388, inlinedAt: !450)
!494 = distinct !{!494, !475, !495, !362, !363}
!495 = !DILocation(line: 42, column: 5, scope: !389, inlinedAt: !450)
!496 = !DILocation(line: 9, column: 1, scope: !440)
!497 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 18, type: !498, scopeLine: 18, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !500)
!498 = !DISubroutineType(types: !499)
!499 = !{null, !206, !238}
!500 = !{!501, !502, !503, !504, !505}
!501 = !DILocalVariable(name: "fd", arg: 1, scope: !497, file: !189, line: 18, type: !206)
!502 = !DILocalVariable(name: "vdata", arg: 2, scope: !497, file: !189, line: 18, type: !238)
!503 = !DILocalVariable(name: "data", scope: !497, file: !189, line: 19, type: !191)
!504 = !DILocalVariable(name: "p", scope: !497, file: !189, line: 20, type: !237)
!505 = !DILocalVariable(name: "s", scope: !497, file: !189, line: 20, type: !237)
!506 = !DILocation(line: 0, scope: !497)
!507 = !DILocation(line: 22, column: 3, scope: !497)
!508 = !DILocation(line: 24, column: 7, scope: !497)
!509 = !DILocalVariable(name: "s", arg: 1, scope: !510, file: !2, line: 56, type: !237)
!510 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !511, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !513)
!511 = !DISubroutineType(types: !512)
!512 = !{!237, !237, !206}
!513 = !{!509, !514, !515}
!514 = !DILocalVariable(name: "n", arg: 2, scope: !510, file: !2, line: 56, type: !206)
!515 = !DILocalVariable(name: "i", scope: !510, file: !2, line: 57, type: !206)
!516 = !DILocation(line: 0, scope: !510, inlinedAt: !517)
!517 = distinct !DILocation(line: 26, column: 7, scope: !497)
!518 = !DILocation(line: 64, column: 17, scope: !510, inlinedAt: !517)
!519 = !DILocation(line: 64, column: 3, scope: !510, inlinedAt: !517)
!520 = !DILocation(line: 66, column: 22, scope: !521, inlinedAt: !517)
!521 = distinct !DILexicalBlock(scope: !522, file: !2, line: 66, column: 9)
!522 = distinct !DILexicalBlock(scope: !510, file: !2, line: 64, column: 31)
!523 = !DILocation(line: 66, column: 26, scope: !521, inlinedAt: !517)
!524 = !DILocation(line: 66, column: 32, scope: !521, inlinedAt: !517)
!525 = !DILocation(line: 66, column: 35, scope: !521, inlinedAt: !517)
!526 = !DILocation(line: 66, column: 39, scope: !521, inlinedAt: !517)
!527 = !DILocation(line: 66, column: 9, scope: !522, inlinedAt: !517)
!528 = !DILocation(line: 69, column: 6, scope: !522, inlinedAt: !517)
!529 = !DILocation(line: 64, column: 10, scope: !510, inlinedAt: !517)
!530 = !DILocation(line: 64, column: 13, scope: !510, inlinedAt: !517)
!531 = distinct !{!531, !519, !532, !362, !363}
!532 = !DILocation(line: 70, column: 3, scope: !510, inlinedAt: !517)
!533 = !DILocation(line: 71, column: 6, scope: !534, inlinedAt: !517)
!534 = distinct !DILexicalBlock(scope: !510, file: !2, line: 71, column: 6)
!535 = !DILocation(line: 71, column: 8, scope: !534, inlinedAt: !517)
!536 = !DILocation(line: 71, column: 6, scope: !510, inlinedAt: !517)
!537 = !DILocalVariable(name: "s", arg: 1, scope: !538, file: !2, line: 77, type: !237)
!538 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !539, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !541)
!539 = !DISubroutineType(types: !540)
!540 = !{!206, !237, !237, !206}
!541 = !{!537, !542, !543, !544}
!542 = !DILocalVariable(name: "arr", arg: 2, scope: !538, file: !2, line: 77, type: !237)
!543 = !DILocalVariable(name: "n", arg: 3, scope: !538, file: !2, line: 77, type: !206)
!544 = !DILocalVariable(name: "k", scope: !538, file: !2, line: 78, type: !206)
!545 = !DILocation(line: 0, scope: !538, inlinedAt: !546)
!546 = distinct !DILocation(line: 27, column: 3, scope: !497)
!547 = !DILocation(line: 91, column: 3, scope: !538, inlinedAt: !546)
!548 = !DILocation(line: 0, scope: !510, inlinedAt: !549)
!549 = distinct !DILocation(line: 29, column: 7, scope: !497)
!550 = !DILocation(line: 64, column: 17, scope: !510, inlinedAt: !549)
!551 = !DILocation(line: 64, column: 3, scope: !510, inlinedAt: !549)
!552 = !DILocation(line: 66, column: 22, scope: !521, inlinedAt: !549)
!553 = !DILocation(line: 66, column: 26, scope: !521, inlinedAt: !549)
!554 = !DILocation(line: 66, column: 32, scope: !521, inlinedAt: !549)
!555 = !DILocation(line: 66, column: 35, scope: !521, inlinedAt: !549)
!556 = !DILocation(line: 66, column: 39, scope: !521, inlinedAt: !549)
!557 = !DILocation(line: 66, column: 9, scope: !522, inlinedAt: !549)
!558 = !DILocation(line: 69, column: 6, scope: !522, inlinedAt: !549)
!559 = !DILocation(line: 64, column: 10, scope: !510, inlinedAt: !549)
!560 = !DILocation(line: 64, column: 13, scope: !510, inlinedAt: !549)
!561 = distinct !{!561, !551, !562, !362, !363}
!562 = !DILocation(line: 70, column: 3, scope: !510, inlinedAt: !549)
!563 = !DILocation(line: 71, column: 6, scope: !534, inlinedAt: !549)
!564 = !DILocation(line: 71, column: 8, scope: !534, inlinedAt: !549)
!565 = !DILocation(line: 71, column: 6, scope: !510, inlinedAt: !549)
!566 = !DILocation(line: 30, column: 25, scope: !497)
!567 = !DILocation(line: 0, scope: !538, inlinedAt: !568)
!568 = distinct !DILocation(line: 30, column: 3, scope: !497)
!569 = !DILocation(line: 91, column: 3, scope: !538, inlinedAt: !568)
!570 = !DILocation(line: 31, column: 3, scope: !497)
!571 = !DILocation(line: 32, column: 1, scope: !497)
!572 = !DISubprogram(name: "free", scope: !573, file: !573, line: 687, type: !441, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!573 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!574 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 34, type: !498, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !575)
!575 = !{!576, !577, !578}
!576 = !DILocalVariable(name: "fd", arg: 1, scope: !574, file: !189, line: 34, type: !206)
!577 = !DILocalVariable(name: "vdata", arg: 2, scope: !574, file: !189, line: 34, type: !238)
!578 = !DILocalVariable(name: "data", scope: !574, file: !189, line: 35, type: !191)
!579 = !DILocation(line: 0, scope: !574)
!580 = !DILocalVariable(name: "fd", arg: 1, scope: !581, file: !2, line: 189, type: !206)
!581 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !582, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !584)
!582 = !DISubroutineType(types: !583)
!583 = !{!206, !206}
!584 = !{!580}
!585 = !DILocation(line: 0, scope: !581, inlinedAt: !586)
!586 = distinct !DILocation(line: 37, column: 3, scope: !574)
!587 = !DILocation(line: 190, column: 3, scope: !588, inlinedAt: !586)
!588 = distinct !DILexicalBlock(scope: !589, file: !2, line: 190, column: 3)
!589 = distinct !DILexicalBlock(scope: !581, file: !2, line: 190, column: 3)
!590 = !DILocation(line: 191, column: 3, scope: !581, inlinedAt: !586)
!591 = !DILocation(line: 38, column: 3, scope: !574)
!592 = !DILocation(line: 0, scope: !581, inlinedAt: !593)
!593 = distinct !DILocation(line: 40, column: 3, scope: !574)
!594 = !DILocation(line: 191, column: 3, scope: !581, inlinedAt: !593)
!595 = !DILocation(line: 41, column: 26, scope: !574)
!596 = !DILocation(line: 41, column: 3, scope: !574)
!597 = !DILocation(line: 42, column: 1, scope: !574)
!598 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 49, type: !498, scopeLine: 49, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !599)
!599 = !{!600, !601, !602, !603, !604}
!600 = !DILocalVariable(name: "fd", arg: 1, scope: !598, file: !189, line: 49, type: !206)
!601 = !DILocalVariable(name: "vdata", arg: 2, scope: !598, file: !189, line: 49, type: !238)
!602 = !DILocalVariable(name: "data", scope: !598, file: !189, line: 50, type: !191)
!603 = !DILocalVariable(name: "p", scope: !598, file: !189, line: 51, type: !237)
!604 = !DILocalVariable(name: "s", scope: !598, file: !189, line: 51, type: !237)
!605 = !DILocation(line: 0, scope: !598)
!606 = !DILocation(line: 53, column: 3, scope: !598)
!607 = !DILocation(line: 55, column: 7, scope: !598)
!608 = !DILocation(line: 0, scope: !510, inlinedAt: !609)
!609 = distinct !DILocation(line: 57, column: 7, scope: !598)
!610 = !DILocation(line: 64, column: 17, scope: !510, inlinedAt: !609)
!611 = !DILocation(line: 64, column: 3, scope: !510, inlinedAt: !609)
!612 = !DILocation(line: 66, column: 22, scope: !521, inlinedAt: !609)
!613 = !DILocation(line: 66, column: 26, scope: !521, inlinedAt: !609)
!614 = !DILocation(line: 66, column: 32, scope: !521, inlinedAt: !609)
!615 = !DILocation(line: 66, column: 35, scope: !521, inlinedAt: !609)
!616 = !DILocation(line: 66, column: 39, scope: !521, inlinedAt: !609)
!617 = !DILocation(line: 66, column: 9, scope: !522, inlinedAt: !609)
!618 = !DILocation(line: 69, column: 6, scope: !522, inlinedAt: !609)
!619 = !DILocation(line: 64, column: 10, scope: !510, inlinedAt: !609)
!620 = !DILocation(line: 64, column: 13, scope: !510, inlinedAt: !609)
!621 = distinct !{!621, !611, !622, !362, !363}
!622 = !DILocation(line: 70, column: 3, scope: !510, inlinedAt: !609)
!623 = !DILocation(line: 71, column: 6, scope: !534, inlinedAt: !609)
!624 = !DILocation(line: 71, column: 8, scope: !534, inlinedAt: !609)
!625 = !DILocation(line: 71, column: 6, scope: !510, inlinedAt: !609)
!626 = !DILocation(line: 58, column: 32, scope: !598)
!627 = !DILocation(line: 58, column: 3, scope: !598)
!628 = !DILocation(line: 59, column: 3, scope: !598)
!629 = !DILocation(line: 60, column: 1, scope: !598)
!630 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 62, type: !498, scopeLine: 62, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !631)
!631 = !{!632, !633, !634}
!632 = !DILocalVariable(name: "fd", arg: 1, scope: !630, file: !189, line: 62, type: !206)
!633 = !DILocalVariable(name: "vdata", arg: 2, scope: !630, file: !189, line: 62, type: !238)
!634 = !DILocalVariable(name: "data", scope: !630, file: !189, line: 63, type: !191)
!635 = !DILocation(line: 0, scope: !630)
!636 = !DILocation(line: 0, scope: !581, inlinedAt: !637)
!637 = distinct !DILocation(line: 65, column: 3, scope: !630)
!638 = !DILocation(line: 190, column: 3, scope: !588, inlinedAt: !637)
!639 = !DILocation(line: 191, column: 3, scope: !581, inlinedAt: !637)
!640 = !DILocation(line: 66, column: 33, scope: !630)
!641 = !DILocalVariable(name: "fd", arg: 1, scope: !642, file: !2, line: 183, type: !206)
!642 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !643, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !645)
!643 = !DISubroutineType(types: !644)
!644 = !{!206, !206, !333, !206}
!645 = !{!641, !646, !647, !648}
!646 = !DILocalVariable(name: "arr", arg: 2, scope: !642, file: !2, line: 183, type: !333)
!647 = !DILocalVariable(name: "n", arg: 3, scope: !642, file: !2, line: 183, type: !206)
!648 = !DILocalVariable(name: "i", scope: !642, file: !2, line: 183, type: !206)
!649 = !DILocation(line: 0, scope: !642, inlinedAt: !650)
!650 = distinct !DILocation(line: 66, column: 3, scope: !630)
!651 = !DILocation(line: 183, column: 1, scope: !652, inlinedAt: !650)
!652 = distinct !DILexicalBlock(scope: !653, file: !2, line: 183, column: 1)
!653 = distinct !DILexicalBlock(scope: !654, file: !2, line: 183, column: 1)
!654 = distinct !DILexicalBlock(scope: !642, file: !2, line: 183, column: 1)
!655 = !DILocation(line: 67, column: 1, scope: !630)
!656 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 69, type: !657, scopeLine: 69, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !659)
!657 = !DISubroutineType(types: !658)
!658 = !{!206, !238, !238}
!659 = !{!660, !661, !662, !663, !664}
!660 = !DILocalVariable(name: "vdata", arg: 1, scope: !656, file: !189, line: 69, type: !238)
!661 = !DILocalVariable(name: "vref", arg: 2, scope: !656, file: !189, line: 69, type: !238)
!662 = !DILocalVariable(name: "data", scope: !656, file: !189, line: 70, type: !191)
!663 = !DILocalVariable(name: "ref", scope: !656, file: !189, line: 71, type: !191)
!664 = !DILocalVariable(name: "has_errors", scope: !656, file: !189, line: 72, type: !206)
!665 = !DILocation(line: 0, scope: !656)
!666 = !DILocation(line: 74, column: 24, scope: !656)
!667 = !DILocation(line: 74, column: 18, scope: !656)
!668 = !DILocation(line: 74, column: 45, scope: !656)
!669 = !DILocation(line: 74, column: 40, scope: !656)
!670 = !DILocation(line: 74, column: 37, scope: !656)
!671 = !DILocation(line: 77, column: 10, scope: !656)
!672 = !DILocation(line: 77, column: 3, scope: !656)
!673 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !674, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !676)
!674 = !DISubroutineType(types: !675)
!675 = !{!237, !206}
!676 = !{!677, !678, !679, !716, !719, !722}
!677 = !DILocalVariable(name: "fd", arg: 1, scope: !673, file: !2, line: 34, type: !206)
!678 = !DILocalVariable(name: "p", scope: !673, file: !2, line: 35, type: !237)
!679 = !DILocalVariable(name: "s", scope: !673, file: !2, line: 36, type: !680)
!680 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !681, line: 44, size: 1024, elements: !682)
!681 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!682 = !{!683, !685, !687, !689, !691, !693, !695, !696, !697, !699, !701, !702, !704, !712, !713, !714}
!683 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !680, file: !681, line: 46, baseType: !684, size: 64)
!684 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !205, line: 145, baseType: !251)
!685 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !680, file: !681, line: 47, baseType: !686, size: 64, offset: 64)
!686 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !205, line: 148, baseType: !251)
!687 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !680, file: !681, line: 48, baseType: !688, size: 32, offset: 128)
!688 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !205, line: 150, baseType: !248)
!689 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !680, file: !681, line: 49, baseType: !690, size: 32, offset: 160)
!690 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !205, line: 151, baseType: !248)
!691 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !680, file: !681, line: 50, baseType: !692, size: 32, offset: 192)
!692 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !205, line: 146, baseType: !248)
!693 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !680, file: !681, line: 51, baseType: !694, size: 32, offset: 224)
!694 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !205, line: 147, baseType: !248)
!695 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !680, file: !681, line: 52, baseType: !684, size: 64, offset: 256)
!696 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !680, file: !681, line: 53, baseType: !684, size: 64, offset: 320)
!697 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !680, file: !681, line: 54, baseType: !698, size: 64, offset: 384)
!698 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !205, line: 152, baseType: !260)
!699 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !680, file: !681, line: 55, baseType: !700, size: 32, offset: 448)
!700 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !205, line: 175, baseType: !206)
!701 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !680, file: !681, line: 56, baseType: !206, size: 32, offset: 480)
!702 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !680, file: !681, line: 57, baseType: !703, size: 64, offset: 512)
!703 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !205, line: 180, baseType: !260)
!704 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !680, file: !681, line: 65, baseType: !705, size: 128, offset: 576)
!705 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !706, line: 11, size: 128, elements: !707)
!706 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!707 = !{!708, !710}
!708 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !705, file: !706, line: 16, baseType: !709, size: 64)
!709 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !205, line: 160, baseType: !260)
!710 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !705, file: !706, line: 21, baseType: !711, size: 64, offset: 64)
!711 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !205, line: 197, baseType: !260)
!712 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !680, file: !681, line: 66, baseType: !705, size: 128, offset: 704)
!713 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !680, file: !681, line: 67, baseType: !705, size: 128, offset: 832)
!714 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !680, file: !681, line: 79, baseType: !715, size: 64, offset: 960)
!715 = !DICompositeType(tag: DW_TAG_array_type, baseType: !206, size: 64, elements: !55)
!716 = !DILocalVariable(name: "len", scope: !673, file: !2, line: 37, type: !717)
!717 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !718, line: 85, baseType: !698)
!718 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!719 = !DILocalVariable(name: "bytes_read", scope: !673, file: !2, line: 38, type: !720)
!720 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !718, line: 108, baseType: !721)
!721 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !205, line: 194, baseType: !260)
!722 = !DILocalVariable(name: "status", scope: !673, file: !2, line: 38, type: !720)
!723 = distinct !DIAssignID()
!724 = !DILocation(line: 0, scope: !673)
!725 = !DILocation(line: 36, column: 3, scope: !673)
!726 = !DILocation(line: 40, column: 3, scope: !727)
!727 = distinct !DILexicalBlock(scope: !728, file: !2, line: 40, column: 3)
!728 = distinct !DILexicalBlock(scope: !673, file: !2, line: 40, column: 3)
!729 = !DILocation(line: 41, column: 3, scope: !730)
!730 = distinct !DILexicalBlock(scope: !731, file: !2, line: 41, column: 3)
!731 = distinct !DILexicalBlock(scope: !673, file: !2, line: 41, column: 3)
!732 = !DILocation(line: 42, column: 11, scope: !673)
!733 = !DILocation(line: 43, column: 3, scope: !734)
!734 = distinct !DILexicalBlock(scope: !735, file: !2, line: 43, column: 3)
!735 = distinct !DILexicalBlock(scope: !673, file: !2, line: 43, column: 3)
!736 = !DILocation(line: 44, column: 25, scope: !673)
!737 = !DILocation(line: 44, column: 15, scope: !673)
!738 = !DILocation(line: 46, column: 3, scope: !673)
!739 = !DILocation(line: 49, column: 15, scope: !740)
!740 = distinct !DILexicalBlock(scope: !673, file: !2, line: 46, column: 27)
!741 = !DILocation(line: 46, column: 20, scope: !673)
!742 = distinct !{!742, !738, !743, !362, !363}
!743 = !DILocation(line: 50, column: 3, scope: !673)
!744 = !DILocation(line: 47, column: 24, scope: !740)
!745 = !DILocation(line: 47, column: 42, scope: !740)
!746 = !DILocation(line: 47, column: 14, scope: !740)
!747 = !DILocation(line: 48, column: 5, scope: !748)
!748 = distinct !DILexicalBlock(scope: !749, file: !2, line: 48, column: 5)
!749 = distinct !DILexicalBlock(scope: !740, file: !2, line: 48, column: 5)
!750 = !DILocation(line: 51, column: 3, scope: !673)
!751 = !DILocation(line: 51, column: 10, scope: !673)
!752 = !DILocation(line: 52, column: 3, scope: !673)
!753 = !DILocation(line: 54, column: 1, scope: !673)
!754 = !DILocation(line: 53, column: 3, scope: !673)
!755 = !DISubprogram(name: "__assert_fail", scope: !756, file: !756, line: 67, type: !757, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!756 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!757 = !DISubroutineType(types: !758)
!758 = !{null, !759, !759, !248, !759}
!759 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!760 = !DISubprogram(name: "fstat", scope: !761, file: !761, line: 210, type: !762, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!761 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!762 = !DISubroutineType(types: !763)
!763 = !{!206, !206, !764}
!764 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !680, size: 64)
!765 = !DISubprogram(name: "malloc", scope: !573, file: !573, line: 672, type: !766, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!766 = !DISubroutineType(types: !767)
!767 = !{!238, !768}
!768 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !769, line: 18, baseType: !251)
!769 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!770 = !DISubprogram(name: "read", scope: !771, file: !771, line: 371, type: !772, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!771 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!772 = !DISubroutineType(types: !773)
!773 = !{!720, !206, !238, !768}
!774 = !DISubprogram(name: "close", scope: !771, file: !771, line: 358, type: !582, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!775 = !DILocation(line: 0, scope: !510)
!776 = !DILocation(line: 59, column: 3, scope: !777)
!777 = distinct !DILexicalBlock(scope: !778, file: !2, line: 59, column: 3)
!778 = distinct !DILexicalBlock(scope: !510, file: !2, line: 59, column: 3)
!779 = !DILocation(line: 60, column: 7, scope: !780)
!780 = distinct !DILexicalBlock(scope: !510, file: !2, line: 60, column: 6)
!781 = !DILocation(line: 60, column: 6, scope: !510)
!782 = !DILocation(line: 64, column: 17, scope: !510)
!783 = !DILocation(line: 64, column: 3, scope: !510)
!784 = !DILocation(line: 66, column: 22, scope: !521)
!785 = !DILocation(line: 66, column: 26, scope: !521)
!786 = !DILocation(line: 66, column: 32, scope: !521)
!787 = !DILocation(line: 66, column: 35, scope: !521)
!788 = !DILocation(line: 66, column: 39, scope: !521)
!789 = !DILocation(line: 66, column: 9, scope: !522)
!790 = !DILocation(line: 69, column: 6, scope: !522)
!791 = !DILocation(line: 64, column: 10, scope: !510)
!792 = !DILocation(line: 64, column: 13, scope: !510)
!793 = distinct !{!793, !783, !794, !362, !363}
!794 = !DILocation(line: 70, column: 3, scope: !510)
!795 = !DILocation(line: 71, column: 6, scope: !534)
!796 = !DILocation(line: 71, column: 8, scope: !534)
!797 = !DILocation(line: 71, column: 6, scope: !510)
!798 = !DILocation(line: 74, column: 1, scope: !510)
!799 = !DILocation(line: 0, scope: !538)
!800 = !DILocation(line: 79, column: 3, scope: !801)
!801 = distinct !DILexicalBlock(scope: !802, file: !2, line: 79, column: 3)
!802 = distinct !DILexicalBlock(scope: !538, file: !2, line: 79, column: 3)
!803 = !DILocation(line: 81, column: 8, scope: !804)
!804 = distinct !DILexicalBlock(scope: !538, file: !2, line: 81, column: 7)
!805 = !DILocation(line: 81, column: 7, scope: !538)
!806 = !DILocation(line: 83, column: 12, scope: !807)
!807 = distinct !DILexicalBlock(scope: !804, file: !2, line: 81, column: 13)
!808 = !DILocation(line: 83, column: 5, scope: !807)
!809 = !DILocation(line: 91, column: 19, scope: !538)
!810 = !DILocation(line: 91, column: 3, scope: !538)
!811 = !DILocation(line: 92, column: 7, scope: !538)
!812 = !DILocation(line: 83, column: 16, scope: !807)
!813 = !DILocation(line: 83, column: 26, scope: !807)
!814 = !DILocation(line: 83, column: 32, scope: !807)
!815 = !DILocation(line: 83, column: 29, scope: !807)
!816 = !DILocation(line: 83, column: 35, scope: !807)
!817 = !DILocation(line: 83, column: 45, scope: !807)
!818 = !DILocation(line: 83, column: 48, scope: !807)
!819 = !DILocation(line: 83, column: 54, scope: !807)
!820 = !DILocation(line: 84, column: 9, scope: !807)
!821 = !DILocation(line: 84, column: 18, scope: !807)
!822 = !DILocation(line: 84, column: 26, scope: !807)
!823 = distinct !{!823, !808, !824, !362, !363}
!824 = !DILocation(line: 86, column: 5, scope: !807)
!825 = !DILocation(line: 93, column: 5, scope: !826)
!826 = distinct !DILexicalBlock(scope: !538, file: !2, line: 92, column: 7)
!827 = !DILocation(line: 93, column: 12, scope: !826)
!828 = !DILocation(line: 95, column: 3, scope: !538)
!829 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !830, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !833)
!830 = !DISubroutineType(types: !831)
!831 = !{!206, !237, !832, !206}
!832 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !239, size: 64)
!833 = !{!834, !835, !836, !837, !838, !839, !840}
!834 = !DILocalVariable(name: "s", arg: 1, scope: !829, file: !2, line: 132, type: !237)
!835 = !DILocalVariable(name: "arr", arg: 2, scope: !829, file: !2, line: 132, type: !832)
!836 = !DILocalVariable(name: "n", arg: 3, scope: !829, file: !2, line: 132, type: !206)
!837 = !DILocalVariable(name: "line", scope: !829, file: !2, line: 132, type: !237)
!838 = !DILocalVariable(name: "endptr", scope: !829, file: !2, line: 132, type: !237)
!839 = !DILocalVariable(name: "i", scope: !829, file: !2, line: 132, type: !206)
!840 = !DILocalVariable(name: "v", scope: !829, file: !2, line: 132, type: !239)
!841 = distinct !DIAssignID()
!842 = !DILocation(line: 0, scope: !829)
!843 = !DILocation(line: 132, column: 1, scope: !829)
!844 = !DILocation(line: 132, column: 1, scope: !845)
!845 = distinct !DILexicalBlock(scope: !846, file: !2, line: 132, column: 1)
!846 = distinct !DILexicalBlock(scope: !829, file: !2, line: 132, column: 1)
!847 = !DILocation(line: 132, column: 1, scope: !848)
!848 = distinct !DILexicalBlock(scope: !829, file: !2, line: 132, column: 1)
!849 = !{!850, !850, i64 0}
!850 = !{!"any pointer", !348, i64 0}
!851 = distinct !DIAssignID()
!852 = !DILocation(line: 132, column: 1, scope: !853)
!853 = distinct !DILexicalBlock(scope: !848, file: !2, line: 132, column: 1)
!854 = !DILocation(line: 132, column: 1, scope: !855)
!855 = distinct !DILexicalBlock(scope: !853, file: !2, line: 132, column: 1)
!856 = distinct !{!856, !843, !843, !362, !363}
!857 = !DILocation(line: 132, column: 1, scope: !858)
!858 = distinct !DILexicalBlock(scope: !859, file: !2, line: 132, column: 1)
!859 = distinct !DILexicalBlock(scope: !829, file: !2, line: 132, column: 1)
!860 = !DISubprogram(name: "strtok", scope: !861, file: !861, line: 356, type: !862, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!861 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!862 = !DISubroutineType(types: !863)
!863 = !{!237, !864, !865}
!864 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !237)
!865 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !759)
!866 = !DISubprogram(name: "strtol", scope: !573, file: !573, line: 177, type: !867, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!867 = !DISubroutineType(types: !868)
!868 = !{!260, !865, !869, !206}
!869 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !870)
!870 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !237, size: 64)
!871 = !DISubprogram(name: "fprintf", scope: !872, file: !872, line: 357, type: !873, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!872 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!873 = !DISubroutineType(types: !874)
!874 = !{!206, !875, !865, null}
!875 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !876)
!876 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !877, size: 64)
!877 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !878, line: 7, baseType: !879)
!878 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!879 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !880, line: 49, size: 1728, elements: !881)
!880 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!881 = !{!882, !883, !884, !885, !886, !887, !888, !889, !890, !891, !892, !893, !894, !897, !899, !900, !901, !902, !903, !904, !906, !909, !911, !914, !917, !918, !919, !921, !922}
!882 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !879, file: !880, line: 51, baseType: !206, size: 32)
!883 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !879, file: !880, line: 54, baseType: !237, size: 64, offset: 64)
!884 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !879, file: !880, line: 55, baseType: !237, size: 64, offset: 128)
!885 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !879, file: !880, line: 56, baseType: !237, size: 64, offset: 192)
!886 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !879, file: !880, line: 57, baseType: !237, size: 64, offset: 256)
!887 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !879, file: !880, line: 58, baseType: !237, size: 64, offset: 320)
!888 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !879, file: !880, line: 59, baseType: !237, size: 64, offset: 384)
!889 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !879, file: !880, line: 60, baseType: !237, size: 64, offset: 448)
!890 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !879, file: !880, line: 61, baseType: !237, size: 64, offset: 512)
!891 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !879, file: !880, line: 64, baseType: !237, size: 64, offset: 576)
!892 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !879, file: !880, line: 65, baseType: !237, size: 64, offset: 640)
!893 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !879, file: !880, line: 66, baseType: !237, size: 64, offset: 704)
!894 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !879, file: !880, line: 68, baseType: !895, size: 64, offset: 768)
!895 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !896, size: 64)
!896 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !880, line: 36, flags: DIFlagFwdDecl)
!897 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !879, file: !880, line: 70, baseType: !898, size: 64, offset: 832)
!898 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !879, size: 64)
!899 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !879, file: !880, line: 72, baseType: !206, size: 32, offset: 896)
!900 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !879, file: !880, line: 73, baseType: !206, size: 32, offset: 928)
!901 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !879, file: !880, line: 74, baseType: !698, size: 64, offset: 960)
!902 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !879, file: !880, line: 77, baseType: !245, size: 16, offset: 1024)
!903 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !879, file: !880, line: 78, baseType: !254, size: 8, offset: 1040)
!904 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !879, file: !880, line: 79, baseType: !905, size: 8, offset: 1048)
!905 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !209)
!906 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !879, file: !880, line: 81, baseType: !907, size: 64, offset: 1088)
!907 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !908, size: 64)
!908 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !880, line: 43, baseType: null)
!909 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !879, file: !880, line: 89, baseType: !910, size: 64, offset: 1152)
!910 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !205, line: 153, baseType: !260)
!911 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !879, file: !880, line: 91, baseType: !912, size: 64, offset: 1216)
!912 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !913, size: 64)
!913 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !880, line: 37, flags: DIFlagFwdDecl)
!914 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !879, file: !880, line: 92, baseType: !915, size: 64, offset: 1280)
!915 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !916, size: 64)
!916 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !880, line: 38, flags: DIFlagFwdDecl)
!917 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !879, file: !880, line: 93, baseType: !898, size: 64, offset: 1344)
!918 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !879, file: !880, line: 94, baseType: !238, size: 64, offset: 1408)
!919 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !879, file: !880, line: 95, baseType: !920, size: 64, offset: 1472)
!920 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !898, size: 64)
!921 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !879, file: !880, line: 96, baseType: !206, size: 32, offset: 1536)
!922 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !879, file: !880, line: 98, baseType: !923, size: 160, offset: 1568)
!923 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!924 = !DISubprogram(name: "strlen", scope: !861, file: !861, line: 407, type: !925, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!925 = !DISubroutineType(types: !926)
!926 = !{!251, !759}
!927 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !928, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !931)
!928 = !DISubroutineType(types: !929)
!929 = !{!206, !237, !930, !206}
!930 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !243, size: 64)
!931 = !{!932, !933, !934, !935, !936, !937, !938}
!932 = !DILocalVariable(name: "s", arg: 1, scope: !927, file: !2, line: 133, type: !237)
!933 = !DILocalVariable(name: "arr", arg: 2, scope: !927, file: !2, line: 133, type: !930)
!934 = !DILocalVariable(name: "n", arg: 3, scope: !927, file: !2, line: 133, type: !206)
!935 = !DILocalVariable(name: "line", scope: !927, file: !2, line: 133, type: !237)
!936 = !DILocalVariable(name: "endptr", scope: !927, file: !2, line: 133, type: !237)
!937 = !DILocalVariable(name: "i", scope: !927, file: !2, line: 133, type: !206)
!938 = !DILocalVariable(name: "v", scope: !927, file: !2, line: 133, type: !243)
!939 = distinct !DIAssignID()
!940 = !DILocation(line: 0, scope: !927)
!941 = !DILocation(line: 133, column: 1, scope: !927)
!942 = !DILocation(line: 133, column: 1, scope: !943)
!943 = distinct !DILexicalBlock(scope: !944, file: !2, line: 133, column: 1)
!944 = distinct !DILexicalBlock(scope: !927, file: !2, line: 133, column: 1)
!945 = !DILocation(line: 133, column: 1, scope: !946)
!946 = distinct !DILexicalBlock(scope: !927, file: !2, line: 133, column: 1)
!947 = distinct !DIAssignID()
!948 = !DILocation(line: 133, column: 1, scope: !949)
!949 = distinct !DILexicalBlock(scope: !946, file: !2, line: 133, column: 1)
!950 = !DILocation(line: 133, column: 1, scope: !951)
!951 = distinct !DILexicalBlock(scope: !949, file: !2, line: 133, column: 1)
!952 = !{!953, !953, i64 0}
!953 = !{!"short", !348, i64 0}
!954 = distinct !{!954, !941, !941, !362, !363}
!955 = !DILocation(line: 133, column: 1, scope: !956)
!956 = distinct !DILexicalBlock(scope: !957, file: !2, line: 133, column: 1)
!957 = distinct !DILexicalBlock(scope: !927, file: !2, line: 133, column: 1)
!958 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !959, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !962)
!959 = !DISubroutineType(types: !960)
!960 = !{!206, !237, !961, !206}
!961 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !246, size: 64)
!962 = !{!963, !964, !965, !966, !967, !968, !969}
!963 = !DILocalVariable(name: "s", arg: 1, scope: !958, file: !2, line: 134, type: !237)
!964 = !DILocalVariable(name: "arr", arg: 2, scope: !958, file: !2, line: 134, type: !961)
!965 = !DILocalVariable(name: "n", arg: 3, scope: !958, file: !2, line: 134, type: !206)
!966 = !DILocalVariable(name: "line", scope: !958, file: !2, line: 134, type: !237)
!967 = !DILocalVariable(name: "endptr", scope: !958, file: !2, line: 134, type: !237)
!968 = !DILocalVariable(name: "i", scope: !958, file: !2, line: 134, type: !206)
!969 = !DILocalVariable(name: "v", scope: !958, file: !2, line: 134, type: !246)
!970 = distinct !DIAssignID()
!971 = !DILocation(line: 0, scope: !958)
!972 = !DILocation(line: 134, column: 1, scope: !958)
!973 = !DILocation(line: 134, column: 1, scope: !974)
!974 = distinct !DILexicalBlock(scope: !975, file: !2, line: 134, column: 1)
!975 = distinct !DILexicalBlock(scope: !958, file: !2, line: 134, column: 1)
!976 = !DILocation(line: 134, column: 1, scope: !977)
!977 = distinct !DILexicalBlock(scope: !958, file: !2, line: 134, column: 1)
!978 = distinct !DIAssignID()
!979 = !DILocation(line: 134, column: 1, scope: !980)
!980 = distinct !DILexicalBlock(scope: !977, file: !2, line: 134, column: 1)
!981 = !DILocation(line: 134, column: 1, scope: !982)
!982 = distinct !DILexicalBlock(scope: !980, file: !2, line: 134, column: 1)
!983 = distinct !{!983, !972, !972, !362, !363}
!984 = !DILocation(line: 134, column: 1, scope: !985)
!985 = distinct !DILexicalBlock(scope: !986, file: !2, line: 134, column: 1)
!986 = distinct !DILexicalBlock(scope: !958, file: !2, line: 134, column: 1)
!987 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !988, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !991)
!988 = !DISubroutineType(types: !989)
!989 = !{!206, !237, !990, !206}
!990 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !249, size: 64)
!991 = !{!992, !993, !994, !995, !996, !997, !998}
!992 = !DILocalVariable(name: "s", arg: 1, scope: !987, file: !2, line: 135, type: !237)
!993 = !DILocalVariable(name: "arr", arg: 2, scope: !987, file: !2, line: 135, type: !990)
!994 = !DILocalVariable(name: "n", arg: 3, scope: !987, file: !2, line: 135, type: !206)
!995 = !DILocalVariable(name: "line", scope: !987, file: !2, line: 135, type: !237)
!996 = !DILocalVariable(name: "endptr", scope: !987, file: !2, line: 135, type: !237)
!997 = !DILocalVariable(name: "i", scope: !987, file: !2, line: 135, type: !206)
!998 = !DILocalVariable(name: "v", scope: !987, file: !2, line: 135, type: !249)
!999 = distinct !DIAssignID()
!1000 = !DILocation(line: 0, scope: !987)
!1001 = !DILocation(line: 135, column: 1, scope: !987)
!1002 = !DILocation(line: 135, column: 1, scope: !1003)
!1003 = distinct !DILexicalBlock(scope: !1004, file: !2, line: 135, column: 1)
!1004 = distinct !DILexicalBlock(scope: !987, file: !2, line: 135, column: 1)
!1005 = !DILocation(line: 135, column: 1, scope: !1006)
!1006 = distinct !DILexicalBlock(scope: !987, file: !2, line: 135, column: 1)
!1007 = distinct !DIAssignID()
!1008 = !DILocation(line: 135, column: 1, scope: !1009)
!1009 = distinct !DILexicalBlock(scope: !1006, file: !2, line: 135, column: 1)
!1010 = !DILocation(line: 135, column: 1, scope: !1011)
!1011 = distinct !DILexicalBlock(scope: !1009, file: !2, line: 135, column: 1)
!1012 = !{!1013, !1013, i64 0}
!1013 = !{!"long", !348, i64 0}
!1014 = distinct !{!1014, !1001, !1001, !362, !363}
!1015 = !DILocation(line: 135, column: 1, scope: !1016)
!1016 = distinct !DILexicalBlock(scope: !1017, file: !2, line: 135, column: 1)
!1017 = distinct !DILexicalBlock(scope: !987, file: !2, line: 135, column: 1)
!1018 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1019, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1022)
!1019 = !DISubroutineType(types: !1020)
!1020 = !{!206, !237, !1021, !206}
!1021 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !252, size: 64)
!1022 = !{!1023, !1024, !1025, !1026, !1027, !1028, !1029}
!1023 = !DILocalVariable(name: "s", arg: 1, scope: !1018, file: !2, line: 136, type: !237)
!1024 = !DILocalVariable(name: "arr", arg: 2, scope: !1018, file: !2, line: 136, type: !1021)
!1025 = !DILocalVariable(name: "n", arg: 3, scope: !1018, file: !2, line: 136, type: !206)
!1026 = !DILocalVariable(name: "line", scope: !1018, file: !2, line: 136, type: !237)
!1027 = !DILocalVariable(name: "endptr", scope: !1018, file: !2, line: 136, type: !237)
!1028 = !DILocalVariable(name: "i", scope: !1018, file: !2, line: 136, type: !206)
!1029 = !DILocalVariable(name: "v", scope: !1018, file: !2, line: 136, type: !252)
!1030 = distinct !DIAssignID()
!1031 = !DILocation(line: 0, scope: !1018)
!1032 = !DILocation(line: 136, column: 1, scope: !1018)
!1033 = !DILocation(line: 136, column: 1, scope: !1034)
!1034 = distinct !DILexicalBlock(scope: !1035, file: !2, line: 136, column: 1)
!1035 = distinct !DILexicalBlock(scope: !1018, file: !2, line: 136, column: 1)
!1036 = !DILocation(line: 136, column: 1, scope: !1037)
!1037 = distinct !DILexicalBlock(scope: !1018, file: !2, line: 136, column: 1)
!1038 = distinct !DIAssignID()
!1039 = !DILocation(line: 136, column: 1, scope: !1040)
!1040 = distinct !DILexicalBlock(scope: !1037, file: !2, line: 136, column: 1)
!1041 = !DILocation(line: 136, column: 1, scope: !1042)
!1042 = distinct !DILexicalBlock(scope: !1040, file: !2, line: 136, column: 1)
!1043 = distinct !{!1043, !1032, !1032, !362, !363}
!1044 = !DILocation(line: 136, column: 1, scope: !1045)
!1045 = distinct !DILexicalBlock(scope: !1046, file: !2, line: 136, column: 1)
!1046 = distinct !DILexicalBlock(scope: !1018, file: !2, line: 136, column: 1)
!1047 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1048, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1051)
!1048 = !DISubroutineType(types: !1049)
!1049 = !{!206, !237, !1050, !206}
!1050 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !255, size: 64)
!1051 = !{!1052, !1053, !1054, !1055, !1056, !1057, !1058}
!1052 = !DILocalVariable(name: "s", arg: 1, scope: !1047, file: !2, line: 137, type: !237)
!1053 = !DILocalVariable(name: "arr", arg: 2, scope: !1047, file: !2, line: 137, type: !1050)
!1054 = !DILocalVariable(name: "n", arg: 3, scope: !1047, file: !2, line: 137, type: !206)
!1055 = !DILocalVariable(name: "line", scope: !1047, file: !2, line: 137, type: !237)
!1056 = !DILocalVariable(name: "endptr", scope: !1047, file: !2, line: 137, type: !237)
!1057 = !DILocalVariable(name: "i", scope: !1047, file: !2, line: 137, type: !206)
!1058 = !DILocalVariable(name: "v", scope: !1047, file: !2, line: 137, type: !255)
!1059 = distinct !DIAssignID()
!1060 = !DILocation(line: 0, scope: !1047)
!1061 = !DILocation(line: 137, column: 1, scope: !1047)
!1062 = !DILocation(line: 137, column: 1, scope: !1063)
!1063 = distinct !DILexicalBlock(scope: !1064, file: !2, line: 137, column: 1)
!1064 = distinct !DILexicalBlock(scope: !1047, file: !2, line: 137, column: 1)
!1065 = !DILocation(line: 137, column: 1, scope: !1066)
!1066 = distinct !DILexicalBlock(scope: !1047, file: !2, line: 137, column: 1)
!1067 = distinct !DIAssignID()
!1068 = !DILocation(line: 137, column: 1, scope: !1069)
!1069 = distinct !DILexicalBlock(scope: !1066, file: !2, line: 137, column: 1)
!1070 = !DILocation(line: 137, column: 1, scope: !1071)
!1071 = distinct !DILexicalBlock(scope: !1069, file: !2, line: 137, column: 1)
!1072 = distinct !{!1072, !1061, !1061, !362, !363}
!1073 = !DILocation(line: 137, column: 1, scope: !1074)
!1074 = distinct !DILexicalBlock(scope: !1075, file: !2, line: 137, column: 1)
!1075 = distinct !DILexicalBlock(scope: !1047, file: !2, line: 137, column: 1)
!1076 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1077, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1079)
!1077 = !DISubroutineType(types: !1078)
!1078 = !{!206, !237, !333, !206}
!1079 = !{!1080, !1081, !1082, !1083, !1084, !1085, !1086}
!1080 = !DILocalVariable(name: "s", arg: 1, scope: !1076, file: !2, line: 138, type: !237)
!1081 = !DILocalVariable(name: "arr", arg: 2, scope: !1076, file: !2, line: 138, type: !333)
!1082 = !DILocalVariable(name: "n", arg: 3, scope: !1076, file: !2, line: 138, type: !206)
!1083 = !DILocalVariable(name: "line", scope: !1076, file: !2, line: 138, type: !237)
!1084 = !DILocalVariable(name: "endptr", scope: !1076, file: !2, line: 138, type: !237)
!1085 = !DILocalVariable(name: "i", scope: !1076, file: !2, line: 138, type: !206)
!1086 = !DILocalVariable(name: "v", scope: !1076, file: !2, line: 138, type: !202)
!1087 = distinct !DIAssignID()
!1088 = !DILocation(line: 0, scope: !1076)
!1089 = !DILocation(line: 138, column: 1, scope: !1076)
!1090 = !DILocation(line: 138, column: 1, scope: !1091)
!1091 = distinct !DILexicalBlock(scope: !1092, file: !2, line: 138, column: 1)
!1092 = distinct !DILexicalBlock(scope: !1076, file: !2, line: 138, column: 1)
!1093 = !DILocation(line: 138, column: 1, scope: !1094)
!1094 = distinct !DILexicalBlock(scope: !1076, file: !2, line: 138, column: 1)
!1095 = distinct !DIAssignID()
!1096 = !DILocation(line: 138, column: 1, scope: !1097)
!1097 = distinct !DILexicalBlock(scope: !1094, file: !2, line: 138, column: 1)
!1098 = !DILocation(line: 138, column: 1, scope: !1099)
!1099 = distinct !DILexicalBlock(scope: !1097, file: !2, line: 138, column: 1)
!1100 = distinct !{!1100, !1089, !1089, !362, !363}
!1101 = !DILocation(line: 138, column: 1, scope: !1102)
!1102 = distinct !DILexicalBlock(scope: !1103, file: !2, line: 138, column: 1)
!1103 = distinct !DILexicalBlock(scope: !1076, file: !2, line: 138, column: 1)
!1104 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1105, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1108)
!1105 = !DISubroutineType(types: !1106)
!1106 = !{!206, !237, !1107, !206}
!1107 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !258, size: 64)
!1108 = !{!1109, !1110, !1111, !1112, !1113, !1114, !1115}
!1109 = !DILocalVariable(name: "s", arg: 1, scope: !1104, file: !2, line: 139, type: !237)
!1110 = !DILocalVariable(name: "arr", arg: 2, scope: !1104, file: !2, line: 139, type: !1107)
!1111 = !DILocalVariable(name: "n", arg: 3, scope: !1104, file: !2, line: 139, type: !206)
!1112 = !DILocalVariable(name: "line", scope: !1104, file: !2, line: 139, type: !237)
!1113 = !DILocalVariable(name: "endptr", scope: !1104, file: !2, line: 139, type: !237)
!1114 = !DILocalVariable(name: "i", scope: !1104, file: !2, line: 139, type: !206)
!1115 = !DILocalVariable(name: "v", scope: !1104, file: !2, line: 139, type: !258)
!1116 = distinct !DIAssignID()
!1117 = !DILocation(line: 0, scope: !1104)
!1118 = !DILocation(line: 139, column: 1, scope: !1104)
!1119 = !DILocation(line: 139, column: 1, scope: !1120)
!1120 = distinct !DILexicalBlock(scope: !1121, file: !2, line: 139, column: 1)
!1121 = distinct !DILexicalBlock(scope: !1104, file: !2, line: 139, column: 1)
!1122 = !DILocation(line: 139, column: 1, scope: !1123)
!1123 = distinct !DILexicalBlock(scope: !1104, file: !2, line: 139, column: 1)
!1124 = distinct !DIAssignID()
!1125 = !DILocation(line: 139, column: 1, scope: !1126)
!1126 = distinct !DILexicalBlock(scope: !1123, file: !2, line: 139, column: 1)
!1127 = !DILocation(line: 139, column: 1, scope: !1128)
!1128 = distinct !DILexicalBlock(scope: !1126, file: !2, line: 139, column: 1)
!1129 = distinct !{!1129, !1118, !1118, !362, !363}
!1130 = !DILocation(line: 139, column: 1, scope: !1131)
!1131 = distinct !DILexicalBlock(scope: !1132, file: !2, line: 139, column: 1)
!1132 = distinct !DILexicalBlock(scope: !1104, file: !2, line: 139, column: 1)
!1133 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1134, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1137)
!1134 = !DISubroutineType(types: !1135)
!1135 = !{!206, !237, !1136, !206}
!1136 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !261, size: 64)
!1137 = !{!1138, !1139, !1140, !1141, !1142, !1143, !1144}
!1138 = !DILocalVariable(name: "s", arg: 1, scope: !1133, file: !2, line: 141, type: !237)
!1139 = !DILocalVariable(name: "arr", arg: 2, scope: !1133, file: !2, line: 141, type: !1136)
!1140 = !DILocalVariable(name: "n", arg: 3, scope: !1133, file: !2, line: 141, type: !206)
!1141 = !DILocalVariable(name: "line", scope: !1133, file: !2, line: 141, type: !237)
!1142 = !DILocalVariable(name: "endptr", scope: !1133, file: !2, line: 141, type: !237)
!1143 = !DILocalVariable(name: "i", scope: !1133, file: !2, line: 141, type: !206)
!1144 = !DILocalVariable(name: "v", scope: !1133, file: !2, line: 141, type: !261)
!1145 = distinct !DIAssignID()
!1146 = !DILocation(line: 0, scope: !1133)
!1147 = !DILocation(line: 141, column: 1, scope: !1133)
!1148 = !DILocation(line: 141, column: 1, scope: !1149)
!1149 = distinct !DILexicalBlock(scope: !1150, file: !2, line: 141, column: 1)
!1150 = distinct !DILexicalBlock(scope: !1133, file: !2, line: 141, column: 1)
!1151 = !DILocation(line: 141, column: 1, scope: !1152)
!1152 = distinct !DILexicalBlock(scope: !1133, file: !2, line: 141, column: 1)
!1153 = distinct !DIAssignID()
!1154 = !DILocation(line: 141, column: 1, scope: !1155)
!1155 = distinct !DILexicalBlock(scope: !1152, file: !2, line: 141, column: 1)
!1156 = !DILocation(line: 141, column: 1, scope: !1157)
!1157 = distinct !DILexicalBlock(scope: !1155, file: !2, line: 141, column: 1)
!1158 = !{!1159, !1159, i64 0}
!1159 = !{!"float", !348, i64 0}
!1160 = distinct !{!1160, !1147, !1147, !362, !363}
!1161 = !DILocation(line: 141, column: 1, scope: !1162)
!1162 = distinct !DILexicalBlock(scope: !1163, file: !2, line: 141, column: 1)
!1163 = distinct !DILexicalBlock(scope: !1133, file: !2, line: 141, column: 1)
!1164 = !DISubprogram(name: "strtof", scope: !573, file: !573, line: 124, type: !1165, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1165 = !DISubroutineType(types: !1166)
!1166 = !{!261, !865, !869}
!1167 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1168, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1171)
!1168 = !DISubroutineType(types: !1169)
!1169 = !{!206, !237, !1170, !206}
!1170 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !262, size: 64)
!1171 = !{!1172, !1173, !1174, !1175, !1176, !1177, !1178}
!1172 = !DILocalVariable(name: "s", arg: 1, scope: !1167, file: !2, line: 142, type: !237)
!1173 = !DILocalVariable(name: "arr", arg: 2, scope: !1167, file: !2, line: 142, type: !1170)
!1174 = !DILocalVariable(name: "n", arg: 3, scope: !1167, file: !2, line: 142, type: !206)
!1175 = !DILocalVariable(name: "line", scope: !1167, file: !2, line: 142, type: !237)
!1176 = !DILocalVariable(name: "endptr", scope: !1167, file: !2, line: 142, type: !237)
!1177 = !DILocalVariable(name: "i", scope: !1167, file: !2, line: 142, type: !206)
!1178 = !DILocalVariable(name: "v", scope: !1167, file: !2, line: 142, type: !262)
!1179 = distinct !DIAssignID()
!1180 = !DILocation(line: 0, scope: !1167)
!1181 = !DILocation(line: 142, column: 1, scope: !1167)
!1182 = !DILocation(line: 142, column: 1, scope: !1183)
!1183 = distinct !DILexicalBlock(scope: !1184, file: !2, line: 142, column: 1)
!1184 = distinct !DILexicalBlock(scope: !1167, file: !2, line: 142, column: 1)
!1185 = !DILocation(line: 142, column: 1, scope: !1186)
!1186 = distinct !DILexicalBlock(scope: !1167, file: !2, line: 142, column: 1)
!1187 = distinct !DIAssignID()
!1188 = !DILocation(line: 142, column: 1, scope: !1189)
!1189 = distinct !DILexicalBlock(scope: !1186, file: !2, line: 142, column: 1)
!1190 = !DILocation(line: 142, column: 1, scope: !1191)
!1191 = distinct !DILexicalBlock(scope: !1189, file: !2, line: 142, column: 1)
!1192 = !{!1193, !1193, i64 0}
!1193 = !{!"double", !348, i64 0}
!1194 = distinct !{!1194, !1181, !1181, !362, !363}
!1195 = !DILocation(line: 142, column: 1, scope: !1196)
!1196 = distinct !DILexicalBlock(scope: !1197, file: !2, line: 142, column: 1)
!1197 = distinct !DILexicalBlock(scope: !1167, file: !2, line: 142, column: 1)
!1198 = !DISubprogram(name: "strtod", scope: !573, file: !573, line: 118, type: !1199, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1199 = !DISubroutineType(types: !1200)
!1200 = !{!262, !865, !869}
!1201 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1202, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1204)
!1202 = !DISubroutineType(types: !1203)
!1203 = !{!206, !206, !237, !206}
!1204 = !{!1205, !1206, !1207, !1208, !1209}
!1205 = !DILocalVariable(name: "fd", arg: 1, scope: !1201, file: !2, line: 145, type: !206)
!1206 = !DILocalVariable(name: "arr", arg: 2, scope: !1201, file: !2, line: 145, type: !237)
!1207 = !DILocalVariable(name: "n", arg: 3, scope: !1201, file: !2, line: 145, type: !206)
!1208 = !DILocalVariable(name: "status", scope: !1201, file: !2, line: 146, type: !206)
!1209 = !DILocalVariable(name: "written", scope: !1201, file: !2, line: 146, type: !206)
!1210 = !DILocation(line: 0, scope: !1201)
!1211 = !DILocation(line: 147, column: 3, scope: !1212)
!1212 = distinct !DILexicalBlock(scope: !1213, file: !2, line: 147, column: 3)
!1213 = distinct !DILexicalBlock(scope: !1201, file: !2, line: 147, column: 3)
!1214 = !DILocation(line: 148, column: 8, scope: !1215)
!1215 = distinct !DILexicalBlock(scope: !1201, file: !2, line: 148, column: 7)
!1216 = !DILocation(line: 148, column: 7, scope: !1201)
!1217 = !DILocation(line: 149, column: 9, scope: !1218)
!1218 = distinct !DILexicalBlock(scope: !1215, file: !2, line: 148, column: 13)
!1219 = !DILocation(line: 150, column: 3, scope: !1218)
!1220 = !DILocation(line: 152, column: 16, scope: !1201)
!1221 = !DILocation(line: 152, column: 3, scope: !1201)
!1222 = !DILocation(line: 158, column: 3, scope: !1201)
!1223 = !DILocation(line: 155, column: 13, scope: !1224)
!1224 = distinct !DILexicalBlock(scope: !1201, file: !2, line: 152, column: 20)
!1225 = distinct !{!1225, !1221, !1226, !362, !363}
!1226 = !DILocation(line: 156, column: 3, scope: !1201)
!1227 = !DILocation(line: 153, column: 25, scope: !1224)
!1228 = !DILocation(line: 153, column: 40, scope: !1224)
!1229 = !DILocation(line: 153, column: 39, scope: !1224)
!1230 = !DILocation(line: 153, column: 14, scope: !1224)
!1231 = !DILocation(line: 154, column: 5, scope: !1232)
!1232 = distinct !DILexicalBlock(scope: !1233, file: !2, line: 154, column: 5)
!1233 = distinct !DILexicalBlock(scope: !1224, file: !2, line: 154, column: 5)
!1234 = !DILocation(line: 159, column: 14, scope: !1235)
!1235 = distinct !DILexicalBlock(scope: !1201, file: !2, line: 158, column: 6)
!1236 = !DILocation(line: 160, column: 5, scope: !1237)
!1237 = distinct !DILexicalBlock(scope: !1238, file: !2, line: 160, column: 5)
!1238 = distinct !DILexicalBlock(scope: !1235, file: !2, line: 160, column: 5)
!1239 = !DILocation(line: 161, column: 17, scope: !1201)
!1240 = !DILocation(line: 161, column: 3, scope: !1235)
!1241 = distinct !{!1241, !1222, !1242, !362, !363}
!1242 = !DILocation(line: 161, column: 20, scope: !1201)
!1243 = !DILocation(line: 163, column: 3, scope: !1201)
!1244 = !DISubprogram(name: "write", scope: !771, file: !771, line: 378, type: !1245, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1245 = !DISubroutineType(types: !1246)
!1246 = !{!720, !206, !1247, !768}
!1247 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1248, size: 64)
!1248 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1249 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1250, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1252)
!1250 = !DISubroutineType(types: !1251)
!1251 = !{!206, !206, !832, !206}
!1252 = !{!1253, !1254, !1255, !1256}
!1253 = !DILocalVariable(name: "fd", arg: 1, scope: !1249, file: !2, line: 177, type: !206)
!1254 = !DILocalVariable(name: "arr", arg: 2, scope: !1249, file: !2, line: 177, type: !832)
!1255 = !DILocalVariable(name: "n", arg: 3, scope: !1249, file: !2, line: 177, type: !206)
!1256 = !DILocalVariable(name: "i", scope: !1249, file: !2, line: 177, type: !206)
!1257 = !DILocation(line: 0, scope: !1249)
!1258 = !DILocation(line: 177, column: 1, scope: !1259)
!1259 = distinct !DILexicalBlock(scope: !1260, file: !2, line: 177, column: 1)
!1260 = distinct !DILexicalBlock(scope: !1249, file: !2, line: 177, column: 1)
!1261 = !DILocation(line: 177, column: 1, scope: !1262)
!1262 = distinct !DILexicalBlock(scope: !1263, file: !2, line: 177, column: 1)
!1263 = distinct !DILexicalBlock(scope: !1249, file: !2, line: 177, column: 1)
!1264 = !DILocation(line: 177, column: 1, scope: !1263)
!1265 = !DILocation(line: 177, column: 1, scope: !1266)
!1266 = distinct !DILexicalBlock(scope: !1262, file: !2, line: 177, column: 1)
!1267 = distinct !{!1267, !1264, !1264, !362, !363}
!1268 = !DILocation(line: 177, column: 1, scope: !1249)
!1269 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1270, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1272)
!1270 = !DISubroutineType(cc: DW_CC_nocall, types: !1271)
!1271 = !{!206, !206, !759, null}
!1272 = !{!1273, !1274, !1275, !1279, !1280, !1281, !1282}
!1273 = !DILocalVariable(name: "fd", arg: 1, scope: !1269, file: !2, line: 15, type: !206)
!1274 = !DILocalVariable(name: "format", arg: 2, scope: !1269, file: !2, line: 15, type: !759)
!1275 = !DILocalVariable(name: "args", scope: !1269, file: !2, line: 16, type: !1276)
!1276 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1277, line: 12, baseType: !1278)
!1277 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1278 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !238)
!1279 = !DILocalVariable(name: "buffered", scope: !1269, file: !2, line: 17, type: !206)
!1280 = !DILocalVariable(name: "written", scope: !1269, file: !2, line: 17, type: !206)
!1281 = !DILocalVariable(name: "status", scope: !1269, file: !2, line: 17, type: !206)
!1282 = !DILocalVariable(name: "buffer", scope: !1269, file: !2, line: 18, type: !1283)
!1283 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !1284)
!1284 = !{!1285}
!1285 = !DISubrange(count: 256)
!1286 = distinct !DIAssignID()
!1287 = !DILocation(line: 0, scope: !1269)
!1288 = distinct !DIAssignID()
!1289 = !DILocation(line: 16, column: 3, scope: !1269)
!1290 = !DILocation(line: 18, column: 3, scope: !1269)
!1291 = !DILocation(line: 19, column: 3, scope: !1269)
!1292 = !DILocation(line: 20, column: 66, scope: !1269)
!1293 = !DILocation(line: 20, column: 14, scope: !1269)
!1294 = !DILocation(line: 21, column: 3, scope: !1269)
!1295 = !DILocation(line: 22, column: 3, scope: !1296)
!1296 = distinct !DILexicalBlock(scope: !1297, file: !2, line: 22, column: 3)
!1297 = distinct !DILexicalBlock(scope: !1269, file: !2, line: 22, column: 3)
!1298 = !DILocation(line: 24, column: 16, scope: !1269)
!1299 = !DILocation(line: 24, column: 3, scope: !1269)
!1300 = !DILocation(line: 27, column: 13, scope: !1301)
!1301 = distinct !DILexicalBlock(scope: !1269, file: !2, line: 24, column: 27)
!1302 = distinct !{!1302, !1299, !1303, !362, !363}
!1303 = !DILocation(line: 28, column: 3, scope: !1269)
!1304 = !DILocation(line: 25, column: 25, scope: !1301)
!1305 = !DILocation(line: 25, column: 50, scope: !1301)
!1306 = !DILocation(line: 25, column: 42, scope: !1301)
!1307 = !DILocation(line: 25, column: 14, scope: !1301)
!1308 = !DILocation(line: 26, column: 5, scope: !1309)
!1309 = distinct !DILexicalBlock(scope: !1310, file: !2, line: 26, column: 5)
!1310 = distinct !DILexicalBlock(scope: !1301, file: !2, line: 26, column: 5)
!1311 = !DILocation(line: 29, column: 3, scope: !1312)
!1312 = distinct !DILexicalBlock(scope: !1313, file: !2, line: 29, column: 3)
!1313 = distinct !DILexicalBlock(scope: !1269, file: !2, line: 29, column: 3)
!1314 = !DILocation(line: 31, column: 1, scope: !1269)
!1315 = !DILocation(line: 30, column: 3, scope: !1269)
!1316 = !DISubprogram(name: "vsnprintf", scope: !872, file: !872, line: 389, type: !1317, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1317 = !DISubroutineType(types: !1318)
!1318 = !{!206, !864, !768, !865, !1319}
!1319 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1320, line: 12, baseType: !1278)
!1320 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1321 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1322, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1324)
!1322 = !DISubroutineType(types: !1323)
!1323 = !{!206, !206, !930, !206}
!1324 = !{!1325, !1326, !1327, !1328}
!1325 = !DILocalVariable(name: "fd", arg: 1, scope: !1321, file: !2, line: 178, type: !206)
!1326 = !DILocalVariable(name: "arr", arg: 2, scope: !1321, file: !2, line: 178, type: !930)
!1327 = !DILocalVariable(name: "n", arg: 3, scope: !1321, file: !2, line: 178, type: !206)
!1328 = !DILocalVariable(name: "i", scope: !1321, file: !2, line: 178, type: !206)
!1329 = !DILocation(line: 0, scope: !1321)
!1330 = !DILocation(line: 178, column: 1, scope: !1331)
!1331 = distinct !DILexicalBlock(scope: !1332, file: !2, line: 178, column: 1)
!1332 = distinct !DILexicalBlock(scope: !1321, file: !2, line: 178, column: 1)
!1333 = !DILocation(line: 178, column: 1, scope: !1334)
!1334 = distinct !DILexicalBlock(scope: !1335, file: !2, line: 178, column: 1)
!1335 = distinct !DILexicalBlock(scope: !1321, file: !2, line: 178, column: 1)
!1336 = !DILocation(line: 178, column: 1, scope: !1335)
!1337 = !DILocation(line: 178, column: 1, scope: !1338)
!1338 = distinct !DILexicalBlock(scope: !1334, file: !2, line: 178, column: 1)
!1339 = distinct !{!1339, !1336, !1336, !362, !363}
!1340 = !DILocation(line: 178, column: 1, scope: !1321)
!1341 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1342, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1344)
!1342 = !DISubroutineType(types: !1343)
!1343 = !{!206, !206, !961, !206}
!1344 = !{!1345, !1346, !1347, !1348}
!1345 = !DILocalVariable(name: "fd", arg: 1, scope: !1341, file: !2, line: 179, type: !206)
!1346 = !DILocalVariable(name: "arr", arg: 2, scope: !1341, file: !2, line: 179, type: !961)
!1347 = !DILocalVariable(name: "n", arg: 3, scope: !1341, file: !2, line: 179, type: !206)
!1348 = !DILocalVariable(name: "i", scope: !1341, file: !2, line: 179, type: !206)
!1349 = !DILocation(line: 0, scope: !1341)
!1350 = !DILocation(line: 179, column: 1, scope: !1351)
!1351 = distinct !DILexicalBlock(scope: !1352, file: !2, line: 179, column: 1)
!1352 = distinct !DILexicalBlock(scope: !1341, file: !2, line: 179, column: 1)
!1353 = !DILocation(line: 179, column: 1, scope: !1354)
!1354 = distinct !DILexicalBlock(scope: !1355, file: !2, line: 179, column: 1)
!1355 = distinct !DILexicalBlock(scope: !1341, file: !2, line: 179, column: 1)
!1356 = !DILocation(line: 179, column: 1, scope: !1355)
!1357 = !DILocation(line: 179, column: 1, scope: !1358)
!1358 = distinct !DILexicalBlock(scope: !1354, file: !2, line: 179, column: 1)
!1359 = distinct !{!1359, !1356, !1356, !362, !363}
!1360 = !DILocation(line: 179, column: 1, scope: !1341)
!1361 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1362, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1364)
!1362 = !DISubroutineType(types: !1363)
!1363 = !{!206, !206, !990, !206}
!1364 = !{!1365, !1366, !1367, !1368}
!1365 = !DILocalVariable(name: "fd", arg: 1, scope: !1361, file: !2, line: 180, type: !206)
!1366 = !DILocalVariable(name: "arr", arg: 2, scope: !1361, file: !2, line: 180, type: !990)
!1367 = !DILocalVariable(name: "n", arg: 3, scope: !1361, file: !2, line: 180, type: !206)
!1368 = !DILocalVariable(name: "i", scope: !1361, file: !2, line: 180, type: !206)
!1369 = !DILocation(line: 0, scope: !1361)
!1370 = !DILocation(line: 180, column: 1, scope: !1371)
!1371 = distinct !DILexicalBlock(scope: !1372, file: !2, line: 180, column: 1)
!1372 = distinct !DILexicalBlock(scope: !1361, file: !2, line: 180, column: 1)
!1373 = !DILocation(line: 180, column: 1, scope: !1374)
!1374 = distinct !DILexicalBlock(scope: !1375, file: !2, line: 180, column: 1)
!1375 = distinct !DILexicalBlock(scope: !1361, file: !2, line: 180, column: 1)
!1376 = !DILocation(line: 180, column: 1, scope: !1375)
!1377 = !DILocation(line: 180, column: 1, scope: !1378)
!1378 = distinct !DILexicalBlock(scope: !1374, file: !2, line: 180, column: 1)
!1379 = distinct !{!1379, !1376, !1376, !362, !363}
!1380 = !DILocation(line: 180, column: 1, scope: !1361)
!1381 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1382, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1384)
!1382 = !DISubroutineType(types: !1383)
!1383 = !{!206, !206, !1021, !206}
!1384 = !{!1385, !1386, !1387, !1388}
!1385 = !DILocalVariable(name: "fd", arg: 1, scope: !1381, file: !2, line: 181, type: !206)
!1386 = !DILocalVariable(name: "arr", arg: 2, scope: !1381, file: !2, line: 181, type: !1021)
!1387 = !DILocalVariable(name: "n", arg: 3, scope: !1381, file: !2, line: 181, type: !206)
!1388 = !DILocalVariable(name: "i", scope: !1381, file: !2, line: 181, type: !206)
!1389 = !DILocation(line: 0, scope: !1381)
!1390 = !DILocation(line: 181, column: 1, scope: !1391)
!1391 = distinct !DILexicalBlock(scope: !1392, file: !2, line: 181, column: 1)
!1392 = distinct !DILexicalBlock(scope: !1381, file: !2, line: 181, column: 1)
!1393 = !DILocation(line: 181, column: 1, scope: !1394)
!1394 = distinct !DILexicalBlock(scope: !1395, file: !2, line: 181, column: 1)
!1395 = distinct !DILexicalBlock(scope: !1381, file: !2, line: 181, column: 1)
!1396 = !DILocation(line: 181, column: 1, scope: !1395)
!1397 = !DILocation(line: 181, column: 1, scope: !1398)
!1398 = distinct !DILexicalBlock(scope: !1394, file: !2, line: 181, column: 1)
!1399 = distinct !{!1399, !1396, !1396, !362, !363}
!1400 = !DILocation(line: 181, column: 1, scope: !1381)
!1401 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1402, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1404)
!1402 = !DISubroutineType(types: !1403)
!1403 = !{!206, !206, !1050, !206}
!1404 = !{!1405, !1406, !1407, !1408}
!1405 = !DILocalVariable(name: "fd", arg: 1, scope: !1401, file: !2, line: 182, type: !206)
!1406 = !DILocalVariable(name: "arr", arg: 2, scope: !1401, file: !2, line: 182, type: !1050)
!1407 = !DILocalVariable(name: "n", arg: 3, scope: !1401, file: !2, line: 182, type: !206)
!1408 = !DILocalVariable(name: "i", scope: !1401, file: !2, line: 182, type: !206)
!1409 = !DILocation(line: 0, scope: !1401)
!1410 = !DILocation(line: 182, column: 1, scope: !1411)
!1411 = distinct !DILexicalBlock(scope: !1412, file: !2, line: 182, column: 1)
!1412 = distinct !DILexicalBlock(scope: !1401, file: !2, line: 182, column: 1)
!1413 = !DILocation(line: 182, column: 1, scope: !1414)
!1414 = distinct !DILexicalBlock(scope: !1415, file: !2, line: 182, column: 1)
!1415 = distinct !DILexicalBlock(scope: !1401, file: !2, line: 182, column: 1)
!1416 = !DILocation(line: 182, column: 1, scope: !1415)
!1417 = !DILocation(line: 182, column: 1, scope: !1418)
!1418 = distinct !DILexicalBlock(scope: !1414, file: !2, line: 182, column: 1)
!1419 = distinct !{!1419, !1416, !1416, !362, !363}
!1420 = !DILocation(line: 182, column: 1, scope: !1401)
!1421 = !DILocation(line: 0, scope: !642)
!1422 = !DILocation(line: 183, column: 1, scope: !1423)
!1423 = distinct !DILexicalBlock(scope: !1424, file: !2, line: 183, column: 1)
!1424 = distinct !DILexicalBlock(scope: !642, file: !2, line: 183, column: 1)
!1425 = !DILocation(line: 183, column: 1, scope: !653)
!1426 = !DILocation(line: 183, column: 1, scope: !654)
!1427 = !DILocation(line: 183, column: 1, scope: !652)
!1428 = distinct !{!1428, !1426, !1426, !362, !363}
!1429 = !DILocation(line: 183, column: 1, scope: !642)
!1430 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1431, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1433)
!1431 = !DISubroutineType(types: !1432)
!1432 = !{!206, !206, !1107, !206}
!1433 = !{!1434, !1435, !1436, !1437}
!1434 = !DILocalVariable(name: "fd", arg: 1, scope: !1430, file: !2, line: 184, type: !206)
!1435 = !DILocalVariable(name: "arr", arg: 2, scope: !1430, file: !2, line: 184, type: !1107)
!1436 = !DILocalVariable(name: "n", arg: 3, scope: !1430, file: !2, line: 184, type: !206)
!1437 = !DILocalVariable(name: "i", scope: !1430, file: !2, line: 184, type: !206)
!1438 = !DILocation(line: 0, scope: !1430)
!1439 = !DILocation(line: 184, column: 1, scope: !1440)
!1440 = distinct !DILexicalBlock(scope: !1441, file: !2, line: 184, column: 1)
!1441 = distinct !DILexicalBlock(scope: !1430, file: !2, line: 184, column: 1)
!1442 = !DILocation(line: 184, column: 1, scope: !1443)
!1443 = distinct !DILexicalBlock(scope: !1444, file: !2, line: 184, column: 1)
!1444 = distinct !DILexicalBlock(scope: !1430, file: !2, line: 184, column: 1)
!1445 = !DILocation(line: 184, column: 1, scope: !1444)
!1446 = !DILocation(line: 184, column: 1, scope: !1447)
!1447 = distinct !DILexicalBlock(scope: !1443, file: !2, line: 184, column: 1)
!1448 = distinct !{!1448, !1445, !1445, !362, !363}
!1449 = !DILocation(line: 184, column: 1, scope: !1430)
!1450 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1451, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1453)
!1451 = !DISubroutineType(types: !1452)
!1452 = !{!206, !206, !1136, !206}
!1453 = !{!1454, !1455, !1456, !1457}
!1454 = !DILocalVariable(name: "fd", arg: 1, scope: !1450, file: !2, line: 186, type: !206)
!1455 = !DILocalVariable(name: "arr", arg: 2, scope: !1450, file: !2, line: 186, type: !1136)
!1456 = !DILocalVariable(name: "n", arg: 3, scope: !1450, file: !2, line: 186, type: !206)
!1457 = !DILocalVariable(name: "i", scope: !1450, file: !2, line: 186, type: !206)
!1458 = !DILocation(line: 0, scope: !1450)
!1459 = !DILocation(line: 186, column: 1, scope: !1460)
!1460 = distinct !DILexicalBlock(scope: !1461, file: !2, line: 186, column: 1)
!1461 = distinct !DILexicalBlock(scope: !1450, file: !2, line: 186, column: 1)
!1462 = !DILocation(line: 186, column: 1, scope: !1463)
!1463 = distinct !DILexicalBlock(scope: !1464, file: !2, line: 186, column: 1)
!1464 = distinct !DILexicalBlock(scope: !1450, file: !2, line: 186, column: 1)
!1465 = !DILocation(line: 186, column: 1, scope: !1464)
!1466 = !DILocation(line: 186, column: 1, scope: !1467)
!1467 = distinct !DILexicalBlock(scope: !1463, file: !2, line: 186, column: 1)
!1468 = distinct !{!1468, !1465, !1465, !362, !363}
!1469 = !DILocation(line: 186, column: 1, scope: !1450)
!1470 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !1471, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !235, retainedNodes: !1473)
!1471 = !DISubroutineType(types: !1472)
!1472 = !{!206, !206, !1170, !206}
!1473 = !{!1474, !1475, !1476, !1477}
!1474 = !DILocalVariable(name: "fd", arg: 1, scope: !1470, file: !2, line: 187, type: !206)
!1475 = !DILocalVariable(name: "arr", arg: 2, scope: !1470, file: !2, line: 187, type: !1170)
!1476 = !DILocalVariable(name: "n", arg: 3, scope: !1470, file: !2, line: 187, type: !206)
!1477 = !DILocalVariable(name: "i", scope: !1470, file: !2, line: 187, type: !206)
!1478 = !DILocation(line: 0, scope: !1470)
!1479 = !DILocation(line: 187, column: 1, scope: !1480)
!1480 = distinct !DILexicalBlock(scope: !1481, file: !2, line: 187, column: 1)
!1481 = distinct !DILexicalBlock(scope: !1470, file: !2, line: 187, column: 1)
!1482 = !DILocation(line: 187, column: 1, scope: !1483)
!1483 = distinct !DILexicalBlock(scope: !1484, file: !2, line: 187, column: 1)
!1484 = distinct !DILexicalBlock(scope: !1470, file: !2, line: 187, column: 1)
!1485 = !DILocation(line: 187, column: 1, scope: !1484)
!1486 = !DILocation(line: 187, column: 1, scope: !1487)
!1487 = distinct !DILexicalBlock(scope: !1483, file: !2, line: 187, column: 1)
!1488 = distinct !{!1488, !1485, !1485, !362, !363}
!1489 = !DILocation(line: 187, column: 1, scope: !1470)
!1490 = !DILocation(line: 0, scope: !581)
!1491 = !DILocation(line: 190, column: 3, scope: !588)
!1492 = !DILocation(line: 191, column: 3, scope: !581)
!1493 = !DILocation(line: 192, column: 3, scope: !581)
!1494 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1495, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !297, retainedNodes: !1497)
!1495 = !DISubroutineType(types: !1496)
!1496 = !{!206, !206, !870}
!1497 = !{!1498, !1499, !1500, !1501, !1502, !1503, !1504, !1505, !1506}
!1498 = !DILocalVariable(name: "argc", arg: 1, scope: !1494, file: !170, line: 14, type: !206)
!1499 = !DILocalVariable(name: "argv", arg: 2, scope: !1494, file: !170, line: 14, type: !870)
!1500 = !DILocalVariable(name: "in_file", scope: !1494, file: !170, line: 17, type: !237)
!1501 = !DILocalVariable(name: "check_file", scope: !1494, file: !170, line: 19, type: !237)
!1502 = !DILocalVariable(name: "in_fd", scope: !1494, file: !170, line: 34, type: !206)
!1503 = !DILocalVariable(name: "data", scope: !1494, file: !170, line: 35, type: !237)
!1504 = !DILocalVariable(name: "out_fd", scope: !1494, file: !170, line: 46, type: !206)
!1505 = !DILocalVariable(name: "check_fd", scope: !1494, file: !170, line: 55, type: !206)
!1506 = !DILocalVariable(name: "ref", scope: !1494, file: !170, line: 56, type: !237)
!1507 = !DILocation(line: 0, scope: !1494)
!1508 = !DILocation(line: 21, column: 3, scope: !1509)
!1509 = distinct !DILexicalBlock(scope: !1510, file: !170, line: 21, column: 3)
!1510 = distinct !DILexicalBlock(scope: !1494, file: !170, line: 21, column: 3)
!1511 = !DILocation(line: 26, column: 11, scope: !1512)
!1512 = distinct !DILexicalBlock(scope: !1494, file: !170, line: 26, column: 7)
!1513 = !DILocation(line: 26, column: 7, scope: !1494)
!1514 = !DILocation(line: 27, column: 15, scope: !1512)
!1515 = !DILocation(line: 29, column: 11, scope: !1516)
!1516 = distinct !DILexicalBlock(scope: !1494, file: !170, line: 29, column: 7)
!1517 = !DILocation(line: 29, column: 7, scope: !1494)
!1518 = !DILocation(line: 30, column: 18, scope: !1516)
!1519 = !DILocation(line: 30, column: 5, scope: !1516)
!1520 = !DILocation(line: 36, column: 17, scope: !1494)
!1521 = !DILocation(line: 36, column: 10, scope: !1494)
!1522 = !DILocation(line: 37, column: 3, scope: !1523)
!1523 = distinct !DILexicalBlock(scope: !1524, file: !170, line: 37, column: 3)
!1524 = distinct !DILexicalBlock(scope: !1494, file: !170, line: 37, column: 3)
!1525 = !DILocation(line: 38, column: 11, scope: !1494)
!1526 = !DILocation(line: 39, column: 3, scope: !1527)
!1527 = distinct !DILexicalBlock(scope: !1528, file: !170, line: 39, column: 3)
!1528 = distinct !DILexicalBlock(scope: !1494, file: !170, line: 39, column: 3)
!1529 = !DILocation(line: 0, scope: !497, inlinedAt: !1530)
!1530 = distinct !DILocation(line: 40, column: 3, scope: !1494)
!1531 = !DILocation(line: 22, column: 3, scope: !497, inlinedAt: !1530)
!1532 = !DILocation(line: 24, column: 7, scope: !497, inlinedAt: !1530)
!1533 = !DILocation(line: 0, scope: !510, inlinedAt: !1534)
!1534 = distinct !DILocation(line: 26, column: 7, scope: !497, inlinedAt: !1530)
!1535 = !DILocation(line: 64, column: 17, scope: !510, inlinedAt: !1534)
!1536 = !DILocation(line: 64, column: 3, scope: !510, inlinedAt: !1534)
!1537 = !DILocation(line: 66, column: 22, scope: !521, inlinedAt: !1534)
!1538 = !DILocation(line: 66, column: 26, scope: !521, inlinedAt: !1534)
!1539 = !DILocation(line: 66, column: 32, scope: !521, inlinedAt: !1534)
!1540 = !DILocation(line: 66, column: 35, scope: !521, inlinedAt: !1534)
!1541 = !DILocation(line: 66, column: 39, scope: !521, inlinedAt: !1534)
!1542 = !DILocation(line: 66, column: 9, scope: !522, inlinedAt: !1534)
!1543 = !DILocation(line: 69, column: 6, scope: !522, inlinedAt: !1534)
!1544 = !DILocation(line: 64, column: 10, scope: !510, inlinedAt: !1534)
!1545 = !DILocation(line: 64, column: 13, scope: !510, inlinedAt: !1534)
!1546 = distinct !{!1546, !1536, !1547, !362, !363}
!1547 = !DILocation(line: 70, column: 3, scope: !510, inlinedAt: !1534)
!1548 = !DILocation(line: 71, column: 6, scope: !534, inlinedAt: !1534)
!1549 = !DILocation(line: 71, column: 8, scope: !534, inlinedAt: !1534)
!1550 = !DILocation(line: 71, column: 6, scope: !510, inlinedAt: !1534)
!1551 = !DILocation(line: 0, scope: !538, inlinedAt: !1552)
!1552 = distinct !DILocation(line: 27, column: 3, scope: !497, inlinedAt: !1530)
!1553 = !DILocation(line: 91, column: 3, scope: !538, inlinedAt: !1552)
!1554 = !DILocation(line: 0, scope: !510, inlinedAt: !1555)
!1555 = distinct !DILocation(line: 29, column: 7, scope: !497, inlinedAt: !1530)
!1556 = !DILocation(line: 64, column: 17, scope: !510, inlinedAt: !1555)
!1557 = !DILocation(line: 64, column: 3, scope: !510, inlinedAt: !1555)
!1558 = !DILocation(line: 66, column: 22, scope: !521, inlinedAt: !1555)
!1559 = !DILocation(line: 66, column: 26, scope: !521, inlinedAt: !1555)
!1560 = !DILocation(line: 66, column: 32, scope: !521, inlinedAt: !1555)
!1561 = !DILocation(line: 66, column: 35, scope: !521, inlinedAt: !1555)
!1562 = !DILocation(line: 66, column: 39, scope: !521, inlinedAt: !1555)
!1563 = !DILocation(line: 66, column: 9, scope: !522, inlinedAt: !1555)
!1564 = !DILocation(line: 69, column: 6, scope: !522, inlinedAt: !1555)
!1565 = !DILocation(line: 64, column: 10, scope: !510, inlinedAt: !1555)
!1566 = !DILocation(line: 64, column: 13, scope: !510, inlinedAt: !1555)
!1567 = distinct !{!1567, !1557, !1568, !362, !363}
!1568 = !DILocation(line: 70, column: 3, scope: !510, inlinedAt: !1555)
!1569 = !DILocation(line: 71, column: 6, scope: !534, inlinedAt: !1555)
!1570 = !DILocation(line: 71, column: 8, scope: !534, inlinedAt: !1555)
!1571 = !DILocation(line: 71, column: 6, scope: !510, inlinedAt: !1555)
!1572 = !DILocation(line: 30, column: 25, scope: !497, inlinedAt: !1530)
!1573 = !DILocation(line: 0, scope: !538, inlinedAt: !1574)
!1574 = distinct !DILocation(line: 30, column: 3, scope: !497, inlinedAt: !1530)
!1575 = !DILocation(line: 91, column: 3, scope: !538, inlinedAt: !1574)
!1576 = !DILocation(line: 31, column: 3, scope: !497, inlinedAt: !1530)
!1577 = !DILocation(line: 0, scope: !440, inlinedAt: !1578)
!1578 = distinct !DILocation(line: 43, column: 3, scope: !1494)
!1579 = !DILocation(line: 8, column: 42, scope: !440, inlinedAt: !1578)
!1580 = !DILocation(line: 8, column: 57, scope: !440, inlinedAt: !1578)
!1581 = !DILocation(line: 0, scope: !375, inlinedAt: !1582)
!1582 = distinct !DILocation(line: 8, column: 3, scope: !440, inlinedAt: !1578)
!1583 = !DILocation(line: 26, column: 18, scope: !375, inlinedAt: !1582)
!1584 = !DILocation(line: 0, scope: !330, inlinedAt: !1585)
!1585 = distinct !DILocation(line: 28, column: 5, scope: !375, inlinedAt: !1582)
!1586 = !DILocation(line: 10, column: 16, scope: !330, inlinedAt: !1585)
!1587 = !DILocation(line: 12, column: 5, scope: !330, inlinedAt: !1585)
!1588 = !DILocation(line: 12, column: 10, scope: !343, inlinedAt: !1585)
!1589 = !DILocation(line: 13, column: 22, scope: !341, inlinedAt: !1585)
!1590 = !DILocation(line: 13, column: 26, scope: !341, inlinedAt: !1585)
!1591 = !DILocation(line: 13, column: 29, scope: !341, inlinedAt: !1585)
!1592 = !DILocation(line: 13, column: 40, scope: !341, inlinedAt: !1585)
!1593 = !DILocation(line: 13, column: 14, scope: !341, inlinedAt: !1585)
!1594 = !DILocation(line: 14, column: 17, scope: !359, inlinedAt: !1585)
!1595 = distinct !{!1595, !1593, !1596, !362, !363}
!1596 = !DILocation(line: 15, column: 9, scope: !341, inlinedAt: !1585)
!1597 = !DILocation(line: 16, column: 12, scope: !365, inlinedAt: !1585)
!1598 = !DILocation(line: 16, column: 23, scope: !365, inlinedAt: !1585)
!1599 = !DILocation(line: 16, column: 12, scope: !341, inlinedAt: !1585)
!1600 = !DILocation(line: 19, column: 9, scope: !341, inlinedAt: !1585)
!1601 = !DILocation(line: 19, column: 20, scope: !341, inlinedAt: !1585)
!1602 = !DILocation(line: 12, column: 40, scope: !342, inlinedAt: !1585)
!1603 = !DILocation(line: 12, column: 23, scope: !342, inlinedAt: !1585)
!1604 = distinct !{!1604, !1588, !1605, !362, !363}
!1605 = !DILocation(line: 20, column: 5, scope: !343, inlinedAt: !1585)
!1606 = !DILocation(line: 31, column: 10, scope: !389, inlinedAt: !1582)
!1607 = !DILocation(line: 32, column: 23, scope: !387, inlinedAt: !1582)
!1608 = !DILocation(line: 32, column: 27, scope: !387, inlinedAt: !1582)
!1609 = !DILocation(line: 32, column: 30, scope: !387, inlinedAt: !1582)
!1610 = !DILocation(line: 32, column: 41, scope: !387, inlinedAt: !1582)
!1611 = !DILocation(line: 32, column: 14, scope: !387, inlinedAt: !1582)
!1612 = !DILocation(line: 33, column: 17, scope: !421, inlinedAt: !1582)
!1613 = distinct !{!1613, !1611, !1614, !362, !363}
!1614 = !DILocation(line: 34, column: 9, scope: !387, inlinedAt: !1582)
!1615 = !DILocation(line: 35, column: 13, scope: !425, inlinedAt: !1582)
!1616 = !DILocation(line: 35, column: 24, scope: !425, inlinedAt: !1582)
!1617 = !DILocation(line: 35, column: 13, scope: !387, inlinedAt: !1582)
!1618 = !DILocation(line: 38, column: 15, scope: !429, inlinedAt: !1582)
!1619 = !DILocation(line: 38, column: 13, scope: !387, inlinedAt: !1582)
!1620 = !DILocation(line: 39, column: 25, scope: !432, inlinedAt: !1582)
!1621 = !DILocation(line: 40, column: 17, scope: !432, inlinedAt: !1582)
!1622 = !DILocation(line: 41, column: 9, scope: !432, inlinedAt: !1582)
!1623 = !DILocation(line: 31, column: 39, scope: !388, inlinedAt: !1582)
!1624 = !DILocation(line: 31, column: 23, scope: !388, inlinedAt: !1582)
!1625 = distinct !{!1625, !1606, !1626, !362, !363}
!1626 = !DILocation(line: 42, column: 5, scope: !389, inlinedAt: !1582)
!1627 = !DILocation(line: 47, column: 12, scope: !1494)
!1628 = !DILocation(line: 48, column: 3, scope: !1629)
!1629 = distinct !DILexicalBlock(scope: !1630, file: !170, line: 48, column: 3)
!1630 = distinct !DILexicalBlock(scope: !1494, file: !170, line: 48, column: 3)
!1631 = !DILocation(line: 0, scope: !630, inlinedAt: !1632)
!1632 = distinct !DILocation(line: 49, column: 3, scope: !1494)
!1633 = !DILocation(line: 0, scope: !581, inlinedAt: !1634)
!1634 = distinct !DILocation(line: 65, column: 3, scope: !630, inlinedAt: !1632)
!1635 = !DILocation(line: 190, column: 3, scope: !588, inlinedAt: !1634)
!1636 = !DILocation(line: 191, column: 3, scope: !581, inlinedAt: !1634)
!1637 = !DILocation(line: 0, scope: !642, inlinedAt: !1638)
!1638 = distinct !DILocation(line: 66, column: 3, scope: !630, inlinedAt: !1632)
!1639 = !DILocation(line: 183, column: 1, scope: !652, inlinedAt: !1638)
!1640 = !DILocation(line: 50, column: 3, scope: !1494)
!1641 = !DILocation(line: 57, column: 16, scope: !1494)
!1642 = !DILocation(line: 57, column: 9, scope: !1494)
!1643 = !DILocation(line: 58, column: 3, scope: !1644)
!1644 = distinct !DILexicalBlock(scope: !1645, file: !170, line: 58, column: 3)
!1645 = distinct !DILexicalBlock(scope: !1494, file: !170, line: 58, column: 3)
!1646 = !DILocation(line: 59, column: 14, scope: !1494)
!1647 = !DILocation(line: 60, column: 3, scope: !1648)
!1648 = distinct !DILexicalBlock(scope: !1649, file: !170, line: 60, column: 3)
!1649 = distinct !DILexicalBlock(scope: !1494, file: !170, line: 60, column: 3)
!1650 = !DILocation(line: 0, scope: !598, inlinedAt: !1651)
!1651 = distinct !DILocation(line: 61, column: 3, scope: !1494)
!1652 = !DILocation(line: 53, column: 3, scope: !598, inlinedAt: !1651)
!1653 = !DILocation(line: 55, column: 7, scope: !598, inlinedAt: !1651)
!1654 = !DILocation(line: 0, scope: !510, inlinedAt: !1655)
!1655 = distinct !DILocation(line: 57, column: 7, scope: !598, inlinedAt: !1651)
!1656 = !DILocation(line: 64, column: 17, scope: !510, inlinedAt: !1655)
!1657 = !DILocation(line: 64, column: 3, scope: !510, inlinedAt: !1655)
!1658 = !DILocation(line: 66, column: 22, scope: !521, inlinedAt: !1655)
!1659 = !DILocation(line: 66, column: 26, scope: !521, inlinedAt: !1655)
!1660 = !DILocation(line: 66, column: 32, scope: !521, inlinedAt: !1655)
!1661 = !DILocation(line: 66, column: 35, scope: !521, inlinedAt: !1655)
!1662 = !DILocation(line: 66, column: 39, scope: !521, inlinedAt: !1655)
!1663 = !DILocation(line: 66, column: 9, scope: !522, inlinedAt: !1655)
!1664 = !DILocation(line: 69, column: 6, scope: !522, inlinedAt: !1655)
!1665 = !DILocation(line: 64, column: 10, scope: !510, inlinedAt: !1655)
!1666 = !DILocation(line: 64, column: 13, scope: !510, inlinedAt: !1655)
!1667 = distinct !{!1667, !1657, !1668, !362, !363}
!1668 = !DILocation(line: 70, column: 3, scope: !510, inlinedAt: !1655)
!1669 = !DILocation(line: 71, column: 6, scope: !534, inlinedAt: !1655)
!1670 = !DILocation(line: 71, column: 8, scope: !534, inlinedAt: !1655)
!1671 = !DILocation(line: 71, column: 6, scope: !510, inlinedAt: !1655)
!1672 = !DILocation(line: 58, column: 32, scope: !598, inlinedAt: !1651)
!1673 = !DILocation(line: 58, column: 3, scope: !598, inlinedAt: !1651)
!1674 = !DILocation(line: 59, column: 3, scope: !598, inlinedAt: !1651)
!1675 = !DILocation(line: 0, scope: !656, inlinedAt: !1676)
!1676 = distinct !DILocation(line: 66, column: 8, scope: !1677)
!1677 = distinct !DILexicalBlock(scope: !1494, file: !170, line: 66, column: 7)
!1678 = !DILocation(line: 74, column: 18, scope: !656, inlinedAt: !1676)
!1679 = !DILocation(line: 74, column: 40, scope: !656, inlinedAt: !1676)
!1680 = !DILocation(line: 74, column: 37, scope: !656, inlinedAt: !1676)
!1681 = !DILocation(line: 66, column: 7, scope: !1494)
!1682 = !DILocation(line: 67, column: 13, scope: !1683)
!1683 = distinct !DILexicalBlock(scope: !1677, file: !170, line: 66, column: 32)
!1684 = !DILocation(line: 67, column: 5, scope: !1683)
!1685 = !DILocation(line: 68, column: 5, scope: !1683)
!1686 = !DILocation(line: 71, column: 3, scope: !1494)
!1687 = !DILocation(line: 72, column: 3, scope: !1494)
!1688 = !DILocation(line: 74, column: 3, scope: !1494)
!1689 = !DILocation(line: 75, column: 3, scope: !1494)
!1690 = !DILocation(line: 76, column: 1, scope: !1494)
!1691 = !DISubprogram(name: "open", scope: !1692, file: !1692, line: 209, type: !1693, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1692 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1693 = !DISubroutineType(types: !1694)
!1694 = !{!206, !759, !206, null}
