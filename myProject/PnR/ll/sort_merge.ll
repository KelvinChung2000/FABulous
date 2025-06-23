; ModuleID = 'sort/merge/sort_opt.bc'
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
@INPUT_SIZE = dso_local local_unnamed_addr global i32 8192, align 4, !dbg !186
@.str.6.14 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !205
@.str.8.15 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !208
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !211
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !216
@.str.12.16 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !219
@.str.14.17 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !221
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !224
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @sort(ptr nocapture noundef %a) local_unnamed_addr #0 !dbg !323 {
entry.split:
  %temp.i33 = alloca [2048 x i32], align 4, !DIAssignID !341
  %temp.i = alloca [2048 x i32], align 4, !DIAssignID !342
    #dbg_value(ptr %a, !328, !DIExpression(), !343)
    #dbg_value(i32 0, !329, !DIExpression(), !343)
    #dbg_value(i32 2048, !330, !DIExpression(), !343)
    #dbg_label(!336, !344)
    #dbg_value(i32 1, !332, !DIExpression(), !343)
  %j.163.i46.reg2mem = alloca i32, align 4
  %i.164.i45.reg2mem = alloca i32, align 4
  %indvars.iv66.i44.reg2mem = alloca i64, align 8
  %indvars.iv.i67.reg2mem = alloca i64, align 8
  %j.163.i.reg2mem = alloca i32, align 4
  %i.164.i.reg2mem = alloca i32, align 4
  %indvars.iv66.i.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %indvars.iv.reg2mem52 = alloca i64, align 8
  %m.079.reg2mem54 = alloca i32, align 4
  store i32 1, ptr %m.079.reg2mem54, align 4
  br label %for.cond1.preheader, !dbg !345

for.cond1.preheader:                              ; preds = %for.inc11.for.cond1.preheader_crit_edge, %entry.split
    #dbg_value(i32 %m.079.reg2mem54.0.load, !332, !DIExpression(), !343)
  %m.079.reg2mem54.0.load = load i32, ptr %m.079.reg2mem54, align 4
  %add9 = shl i32 %m.079.reg2mem54.0.load, 1
    #dbg_value(i32 0, !331, !DIExpression(), !343)
  %0 = add nsw i32 %m.079.reg2mem54.0.load, -1, !dbg !346
  %1 = zext nneg i32 %m.079.reg2mem54.0.load to i64, !dbg !346
  %2 = shl nuw nsw i64 %1, 1, !dbg !346
  %3 = sext i32 %m.079.reg2mem54.0.load to i64, !dbg !346
  %4 = zext i32 %0 to i64
  %5 = shl nuw nsw i64 %4, 2
  %6 = add nuw nsw i64 %5, 4
  %add6 = add i32 %add9, -1
  %7 = sext i32 %add6 to i64, !dbg !346
  store i64 0, ptr %indvars.iv.reg2mem52, align 8
  br label %for.body3, !dbg !346

for.body3:                                        ; preds = %for.inc.for.body3_crit_edge, %for.cond1.preheader
    #dbg_value(i64 %indvars.iv.reg2mem52.0.load, !331, !DIExpression(), !343)
    #dbg_value(i64 %indvars.iv.reg2mem52.0.load, !333, !DIExpression(), !343)
  %indvars.iv.reg2mem52.0.load = load i64, ptr %indvars.iv.reg2mem52, align 8
  %8 = add nuw nsw i64 %indvars.iv.reg2mem52.0.load, %3, !dbg !348
    #dbg_value(i64 %8, !334, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !343)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem52.0.load, %2, !dbg !351
    #dbg_value(i64 %indvars.iv.next, !335, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !343)
  %cmp8 = icmp ult i64 %indvars.iv.next, 2049, !dbg !352
  br i1 %cmp8, label %if.then, label %if.else, !dbg !354

if.then:                                          ; preds = %for.body3
  %9 = add nuw nsw i64 %indvars.iv.reg2mem52.0.load, %7, !dbg !355
    #dbg_value(i64 %indvars.iv.next, !335, !DIExpression(DW_OP_plus_uconst, 4294967295, DW_OP_stack_value), !343)
    #dbg_assign(i1 undef, !356, !DIExpression(), !342, ptr %temp.i, !DIExpression(), !376)
    #dbg_value(ptr %a, !361, !DIExpression(), !376)
    #dbg_value(i64 %indvars.iv.reg2mem52.0.load, !362, !DIExpression(), !376)
    #dbg_value(i64 %8, !363, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !376)
    #dbg_value(i64 %indvars.iv.next, !364, !DIExpression(DW_OP_plus_uconst, 4294967295, DW_OP_stack_value), !376)
  call void @llvm.lifetime.start.p0(i64 8192, ptr nonnull %temp.i) #18, !dbg !379
    #dbg_label(!368, !380)
    #dbg_value(i64 %indvars.iv.reg2mem52.0.load, !365, !DIExpression(), !376)
  %10 = shl nuw nsw i64 %indvars.iv.reg2mem52.0.load, 2, !dbg !381
  %scevgep.i = getelementptr i8, ptr %temp.i, i64 %10, !dbg !381
  %scevgep65.i = getelementptr i8, ptr %a, i64 %10, !dbg !381
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 4 dereferenceable(1) %scevgep.i, ptr noundef nonnull align 4 dereferenceable(1) %scevgep65.i, i64 %6, i1 false), !dbg !383, !tbaa !386
    #dbg_value(i64 poison, !365, !DIExpression(), !376)
    #dbg_label(!369, !390)
    #dbg_value(i64 %8, !366, !DIExpression(), !376)
  %11 = add nsw i64 %9, %8
  store i64 %8, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body5.i, !dbg !391

for.body17.preheader.i:                           ; preds = %for.body5.i
    #dbg_value(i64 %indvars.iv.reg2mem52.0.load, !365, !DIExpression(), !376)
    #dbg_value(i64 %indvars.iv.next, !366, !DIExpression(DW_OP_plus_uconst, 4294967295, DW_OP_stack_value), !376)
    #dbg_value(i64 %indvars.iv.reg2mem52.0.load, !367, !DIExpression(), !376)
  %12 = trunc nuw i64 %indvars.iv.reg2mem52.0.load to i32, !dbg !393
  %13 = trunc nuw nsw i64 %indvars.iv.next to i32, !dbg !393
  %14 = add nsw i32 %13, -1, !dbg !393
  store i32 %14, ptr %j.163.i.reg2mem, align 4
  store i32 %12, ptr %i.164.i.reg2mem, align 4
  store i64 %indvars.iv.reg2mem52.0.load, ptr %indvars.iv66.i.reg2mem, align 8
  br label %for.body17.i, !dbg !393

for.body5.i:                                      ; preds = %for.body5.i.for.body5.i_crit_edge, %if.then
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !366, !DIExpression(), !376)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx7.i = getelementptr inbounds i32, ptr %a, i64 %indvars.iv.i.reg2mem.0.load, !dbg !394
  %15 = load i32, ptr %arrayidx7.i, align 4, !dbg !394, !tbaa !386
  %sext87 = shl i64 %indvars.iv.i.reg2mem.0.load, 32, !dbg !397
  %16 = ashr exact i64 %sext87, 32, !dbg !397
  %17 = sub nsw i64 %11, %16, !dbg !397
  %arrayidx11.i = getelementptr inbounds [2048 x i32], ptr %temp.i, i64 0, i64 %17, !dbg !398
  store i32 %15, ptr %arrayidx11.i, align 4, !dbg !399, !tbaa !386
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !400
    #dbg_value(i64 %indvars.iv.next.i, !366, !DIExpression(), !376)
  %18 = icmp eq i64 %indvars.iv.next.i, %indvars.iv.next, !dbg !401
  br i1 %18, label %for.body17.preheader.i, label %for.body5.i.for.body5.i_crit_edge, !dbg !391, !llvm.loop !402

for.body5.i.for.body5.i_crit_edge:                ; preds = %for.body5.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body5.i, !dbg !391

for.body17.i:                                     ; preds = %for.body17.i.for.body17.i_crit_edge, %for.body17.preheader.i
    #dbg_value(i32 %i.164.i.reg2mem.0.load, !365, !DIExpression(), !376)
    #dbg_value(i32 %j.163.i.reg2mem.0.load, !366, !DIExpression(), !376)
    #dbg_value(i64 %indvars.iv66.i.reg2mem.0.load, !367, !DIExpression(), !376)
  %indvars.iv66.i.reg2mem.0.load = load i64, ptr %indvars.iv66.i.reg2mem, align 8
  %i.164.i.reg2mem.0.load = load i32, ptr %i.164.i.reg2mem, align 4
  %j.163.i.reg2mem.0.load = load i32, ptr %j.163.i.reg2mem, align 4
  %idxprom18.i = sext i32 %j.163.i.reg2mem.0.load to i64, !dbg !406
  %arrayidx19.i = getelementptr inbounds [2048 x i32], ptr %temp.i, i64 0, i64 %idxprom18.i, !dbg !406
  %19 = load i32, ptr %arrayidx19.i, align 4, !dbg !406, !tbaa !386
    #dbg_value(i32 %19, !371, !DIExpression(), !407)
  %idxprom20.i = zext nneg i32 %i.164.i.reg2mem.0.load to i64, !dbg !408
  %arrayidx21.i = getelementptr inbounds [2048 x i32], ptr %temp.i, i64 0, i64 %idxprom20.i, !dbg !408
  %20 = load i32, ptr %arrayidx21.i, align 4, !dbg !408, !tbaa !386
    #dbg_value(i32 %20, !375, !DIExpression(), !407)
  %cmp22.i = icmp slt i32 %19, %20, !dbg !409
  %arrayidx24.i = getelementptr inbounds i32, ptr %a, i64 %indvars.iv66.i.reg2mem.0.load, !dbg !411
  %.sink = tail call i32 @llvm.smin.i32(i32 %19, i32 %20), !dbg !412
  %dec.i = sext i1 %cmp22.i to i32, !dbg !412
  %j.2.i = add nsw i32 %j.163.i.reg2mem.0.load, %dec.i, !dbg !412
  %not.cmp22.i = xor i1 %cmp22.i, true, !dbg !412
  %inc27.i = zext i1 %not.cmp22.i to i32, !dbg !412
  %i.2.i = add nuw nsw i32 %i.164.i.reg2mem.0.load, %inc27.i, !dbg !412
  store i32 %.sink, ptr %arrayidx24.i, align 4, !dbg !411
    #dbg_value(i32 %i.2.i, !365, !DIExpression(), !376)
    #dbg_value(i32 %j.2.i, !366, !DIExpression(), !376)
  %indvars.iv.next67.i = add nuw nsw i64 %indvars.iv66.i.reg2mem.0.load, 1, !dbg !413
    #dbg_value(i64 %indvars.iv.next67.i, !367, !DIExpression(), !376)
  %21 = icmp eq i64 %indvars.iv.next67.i, %indvars.iv.next, !dbg !414
  br i1 %21, label %merge.exit, label %for.body17.i.for.body17.i_crit_edge, !dbg !393, !llvm.loop !415

for.body17.i.for.body17.i_crit_edge:              ; preds = %for.body17.i
  store i32 %j.2.i, ptr %j.163.i.reg2mem, align 4
  store i32 %i.2.i, ptr %i.164.i.reg2mem, align 4
  store i64 %indvars.iv.next67.i, ptr %indvars.iv66.i.reg2mem, align 8
  br label %for.body17.i, !dbg !393

merge.exit:                                       ; preds = %for.body17.i
  call void @llvm.lifetime.end.p0(i64 8192, ptr nonnull %temp.i) #18, !dbg !417
  br label %for.inc, !dbg !418

if.else:                                          ; preds = %for.body3
    #dbg_assign(i1 undef, !356, !DIExpression(), !341, ptr %temp.i33, !DIExpression(), !419)
    #dbg_value(ptr %a, !361, !DIExpression(), !419)
    #dbg_value(i64 %indvars.iv.reg2mem52.0.load, !362, !DIExpression(), !419)
    #dbg_value(i64 %8, !363, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !419)
    #dbg_value(i32 2048, !364, !DIExpression(), !419)
  call void @llvm.lifetime.start.p0(i64 8192, ptr nonnull %temp.i33) #18, !dbg !422
    #dbg_label(!368, !423)
    #dbg_value(i64 %indvars.iv.reg2mem52.0.load, !365, !DIExpression(), !419)
  %22 = shl nuw nsw i64 %indvars.iv.reg2mem52.0.load, 2, !dbg !424
  %scevgep.i36 = getelementptr i8, ptr %temp.i33, i64 %22, !dbg !424
  %scevgep65.i37 = getelementptr i8, ptr %a, i64 %22, !dbg !424
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 4 dereferenceable(1) %scevgep.i36, ptr noundef nonnull align 4 dereferenceable(1) %scevgep65.i37, i64 %6, i1 false), !dbg !425, !tbaa !386
    #dbg_value(i64 poison, !365, !DIExpression(), !419)
    #dbg_label(!369, !426)
    #dbg_value(i64 %8, !366, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_plus_uconst, 1, DW_OP_stack_value), !419)
  %cmp4.not59.not.i39 = icmp ult i64 %8, 2049, !dbg !427
  br i1 %cmp4.not59.not.i39, label %for.body5.i66.preheader, label %if.else.for.body17.preheader.i42_crit_edge, !dbg !428

if.else.for.body17.preheader.i42_crit_edge:       ; preds = %if.else
  br label %for.body17.preheader.i42, !dbg !428

for.body5.i66.preheader:                          ; preds = %if.else
  %23 = add nuw nsw i64 %8, 2048
  store i64 %8, ptr %indvars.iv.i67.reg2mem, align 8
  br label %for.body5.i66, !dbg !428

for.body17.preheader.i42:                         ; preds = %for.body5.i66.for.body17.preheader.i42_crit_edge, %if.else.for.body17.preheader.i42_crit_edge
    #dbg_value(i64 %indvars.iv.reg2mem52.0.load, !365, !DIExpression(), !419)
    #dbg_value(i32 2048, !366, !DIExpression(), !419)
    #dbg_value(i64 %indvars.iv.reg2mem52.0.load, !367, !DIExpression(), !419)
  %24 = trunc i64 %indvars.iv.reg2mem52.0.load to i32, !dbg !429
  store i32 2048, ptr %j.163.i46.reg2mem, align 4
  store i32 %24, ptr %i.164.i45.reg2mem, align 4
  store i64 %indvars.iv.reg2mem52.0.load, ptr %indvars.iv66.i44.reg2mem, align 8
  br label %for.body17.i43, !dbg !429

for.body5.i66:                                    ; preds = %for.body5.i66.for.body5.i66_crit_edge, %for.body5.i66.preheader
    #dbg_value(i64 %indvars.iv.i67.reg2mem.0.load, !366, !DIExpression(), !419)
  %indvars.iv.i67.reg2mem.0.load = load i64, ptr %indvars.iv.i67.reg2mem, align 8
  %arrayidx7.i68 = getelementptr inbounds i32, ptr %a, i64 %indvars.iv.i67.reg2mem.0.load, !dbg !430
  %25 = load i32, ptr %arrayidx7.i68, align 4, !dbg !430, !tbaa !386
  %sub.i69 = sub nsw i64 %23, %indvars.iv.i67.reg2mem.0.load, !dbg !431
  %sext = shl i64 %sub.i69, 32, !dbg !432
  %idxprom10.i70 = ashr exact i64 %sext, 32, !dbg !432
  %arrayidx11.i71 = getelementptr inbounds [2048 x i32], ptr %temp.i33, i64 0, i64 %idxprom10.i70, !dbg !432
  store i32 %25, ptr %arrayidx11.i71, align 4, !dbg !433, !tbaa !386
  %indvars.iv.next.i72 = add nuw nsw i64 %indvars.iv.i67.reg2mem.0.load, 1, !dbg !434
    #dbg_value(i64 %indvars.iv.next.i72, !366, !DIExpression(), !419)
  %26 = and i64 %indvars.iv.next.i72, 4294967295, !dbg !427
  %exitcond.not.i74 = icmp eq i64 %26, 2049, !dbg !427
  br i1 %exitcond.not.i74, label %for.body5.i66.for.body17.preheader.i42_crit_edge, label %for.body5.i66.for.body5.i66_crit_edge, !dbg !428, !llvm.loop !435

for.body5.i66.for.body5.i66_crit_edge:            ; preds = %for.body5.i66
  store i64 %indvars.iv.next.i72, ptr %indvars.iv.i67.reg2mem, align 8
  br label %for.body5.i66, !dbg !428

for.body5.i66.for.body17.preheader.i42_crit_edge: ; preds = %for.body5.i66
  br label %for.body17.preheader.i42, !dbg !428

for.body17.i43:                                   ; preds = %for.body17.i43.for.body17.i43_crit_edge, %for.body17.preheader.i42
    #dbg_value(i32 %i.164.i45.reg2mem.0.load, !365, !DIExpression(), !419)
    #dbg_value(i32 %j.163.i46.reg2mem.0.load, !366, !DIExpression(), !419)
    #dbg_value(i64 %indvars.iv66.i44.reg2mem.0.load, !367, !DIExpression(), !419)
  %indvars.iv66.i44.reg2mem.0.load = load i64, ptr %indvars.iv66.i44.reg2mem, align 8
  %i.164.i45.reg2mem.0.load = load i32, ptr %i.164.i45.reg2mem, align 4
  %j.163.i46.reg2mem.0.load = load i32, ptr %j.163.i46.reg2mem, align 4
  %idxprom18.i47 = sext i32 %j.163.i46.reg2mem.0.load to i64, !dbg !437
  %arrayidx19.i48 = getelementptr inbounds [2048 x i32], ptr %temp.i33, i64 0, i64 %idxprom18.i47, !dbg !437
  %27 = load i32, ptr %arrayidx19.i48, align 4, !dbg !437, !tbaa !386
    #dbg_value(i32 %27, !371, !DIExpression(), !438)
  %idxprom20.i49 = sext i32 %i.164.i45.reg2mem.0.load to i64, !dbg !439
  %arrayidx21.i50 = getelementptr inbounds [2048 x i32], ptr %temp.i33, i64 0, i64 %idxprom20.i49, !dbg !439
  %28 = load i32, ptr %arrayidx21.i50, align 4, !dbg !439, !tbaa !386
    #dbg_value(i32 %28, !375, !DIExpression(), !438)
  %cmp22.i51 = icmp slt i32 %27, %28, !dbg !440
  %arrayidx24.i62 = getelementptr inbounds i32, ptr %a, i64 %indvars.iv66.i44.reg2mem.0.load, !dbg !441
  %.sink6 = tail call i32 @llvm.smin.i32(i32 %27, i32 %28), !dbg !442
  %dec.i63 = sext i1 %cmp22.i51 to i32, !dbg !442
  %j.2.i56 = add nsw i32 %j.163.i46.reg2mem.0.load, %dec.i63, !dbg !442
  %not.cmp22.i51 = xor i1 %cmp22.i51, true, !dbg !442
  %inc27.i54 = zext i1 %not.cmp22.i51 to i32, !dbg !442
  %i.2.i57 = add nsw i32 %i.164.i45.reg2mem.0.load, %inc27.i54, !dbg !442
  store i32 %.sink6, ptr %arrayidx24.i62, align 4, !dbg !441
    #dbg_value(i32 %i.2.i57, !365, !DIExpression(), !419)
    #dbg_value(i32 %j.2.i56, !366, !DIExpression(), !419)
  %indvars.iv.next67.i58 = add nuw nsw i64 %indvars.iv66.i44.reg2mem.0.load, 1, !dbg !443
    #dbg_value(i64 %indvars.iv.next67.i58, !367, !DIExpression(), !419)
  %29 = and i64 %indvars.iv.next67.i58, 4294967295, !dbg !444
  %exitcond69.not.i60 = icmp eq i64 %29, 2049, !dbg !444
  br i1 %exitcond69.not.i60, label %merge.exit75, label %for.body17.i43.for.body17.i43_crit_edge, !dbg !429, !llvm.loop !445

for.body17.i43.for.body17.i43_crit_edge:          ; preds = %for.body17.i43
  store i32 %j.2.i56, ptr %j.163.i46.reg2mem, align 4
  store i32 %i.2.i57, ptr %i.164.i45.reg2mem, align 4
  store i64 %indvars.iv.next67.i58, ptr %indvars.iv66.i44.reg2mem, align 8
  br label %for.body17.i43, !dbg !429

merge.exit75:                                     ; preds = %for.body17.i43
  call void @llvm.lifetime.end.p0(i64 8192, ptr nonnull %temp.i33) #18, !dbg !447
  br label %for.inc

for.inc:                                          ; preds = %merge.exit, %merge.exit75
    #dbg_value(i64 %indvars.iv.next, !331, !DIExpression(), !343)
  %cmp2 = icmp ult i64 %indvars.iv.next, 2048, !dbg !448
  br i1 %cmp2, label %for.inc.for.body3_crit_edge, label %for.inc11, !dbg !346, !llvm.loop !449

for.inc.for.body3_crit_edge:                      ; preds = %for.inc
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem52, align 8
  br label %for.body3, !dbg !346

for.inc11:                                        ; preds = %for.inc
    #dbg_value(i32 %add9, !332, !DIExpression(), !343)
  %cmp = icmp ult i32 %m.079.reg2mem54.0.load, 1024, !dbg !451
  br i1 %cmp, label %for.inc11.for.cond1.preheader_crit_edge, label %for.end13, !dbg !345, !llvm.loop !452

for.inc11.for.cond1.preheader_crit_edge:          ; preds = %for.inc11
  store i32 %add9, ptr %m.079.reg2mem54, align 4
  br label %for.cond1.preheader, !dbg !345

for.end13:                                        ; preds = %for.inc11
  ret void, !dbg !454
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #0 !dbg !455 {
entry.split:
    #dbg_value(ptr %vargs, !459, !DIExpression(), !461)
    #dbg_value(ptr %vargs, !460, !DIExpression(), !461)
  tail call void @sort(ptr noundef %vargs) #18, !dbg !462
  ret void, !dbg !463
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #3 !dbg !464 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !468, !DIExpression(), !473)
    #dbg_value(ptr %vdata, !469, !DIExpression(), !473)
    #dbg_value(ptr %vdata, !470, !DIExpression(), !473)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(8192) %vdata, i8 0, i64 8192, i1 false), !dbg !474
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !475
    #dbg_value(ptr %call, !471, !DIExpression(), !473)
    #dbg_value(ptr %call, !476, !DIExpression(), !483)
    #dbg_value(i32 1, !481, !DIExpression(), !483)
    #dbg_value(i32 0, !482, !DIExpression(), !483)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !482, !DIExpression(), !483)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !476, !DIExpression(), !483)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !485, !tbaa !486
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !487

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !487

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !487

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !488
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !488, !tbaa !486
  %cmp13.i = icmp eq i8 %1, 37, !dbg !491
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !492

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !492

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !493
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !493, !tbaa !486
  %cmp18.i = icmp eq i8 %2, 10, !dbg !494
  %inc.i = zext i1 %cmp18.i to i32, !dbg !495
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !495
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !495

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !482, !DIExpression(), !483)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !496
    #dbg_value(ptr %incdec.ptr.i, !476, !DIExpression(), !483)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !497
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !498, !llvm.loop !499

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !498

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !501, !tbaa !486
  %3 = icmp eq i8 %.pre.i, 0, !dbg !503
  %4 = select i1 %3, i64 0, i64 2, !dbg !504
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !498

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !504
    #dbg_value(ptr %spec.select38.i, !472, !DIExpression(), !473)
  %call2 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 2048) #18, !dbg !505
  tail call void @free(ptr noundef %call) #18, !dbg !506
  ret void, !dbg !507
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !508 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #3 !dbg !510 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !512, !DIExpression(), !515)
    #dbg_value(ptr %vdata, !513, !DIExpression(), !515)
    #dbg_value(ptr %vdata, !514, !DIExpression(), !515)
    #dbg_value(i32 %fd, !516, !DIExpression(), !521)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !523
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !523

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !523
  unreachable, !dbg !523

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !526
    #dbg_value(i32 %fd, !527, !DIExpression(), !535)
    #dbg_value(ptr %vdata, !532, !DIExpression(), !535)
    #dbg_value(i32 2048, !533, !DIExpression(), !535)
    #dbg_value(i32 0, !534, !DIExpression(), !535)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !537

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !534, !DIExpression(), !535)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i32, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !539
  %0 = load i32, ptr %arrayidx.i, align 4, !dbg !539, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !539
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !542
    #dbg_value(i64 %indvars.iv.next.i, !534, !DIExpression(), !535)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 2048, !dbg !542
  br i1 %exitcond.not.i, label %write_int32_t_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !537, !llvm.loop !543

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !537

write_int32_t_array.exit:                         ; preds = %for.body.i
  ret void, !dbg !544
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #3 !dbg !545 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !547, !DIExpression(), !552)
    #dbg_value(ptr %vdata, !548, !DIExpression(), !552)
    #dbg_value(ptr %vdata, !549, !DIExpression(), !552)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(8192) %vdata, i8 0, i64 8192, i1 false), !dbg !553
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !554
    #dbg_value(ptr %call, !550, !DIExpression(), !552)
    #dbg_value(ptr %call, !476, !DIExpression(), !555)
    #dbg_value(i32 1, !481, !DIExpression(), !555)
    #dbg_value(i32 0, !482, !DIExpression(), !555)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !482, !DIExpression(), !555)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !476, !DIExpression(), !555)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !557, !tbaa !486
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !558

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !558

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !558

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !559
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !559, !tbaa !486
  %cmp13.i = icmp eq i8 %1, 37, !dbg !560
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !561

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !561

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !562
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !562, !tbaa !486
  %cmp18.i = icmp eq i8 %2, 10, !dbg !563
  %inc.i = zext i1 %cmp18.i to i32, !dbg !564
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !564
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !564

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !482, !DIExpression(), !555)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !565
    #dbg_value(ptr %incdec.ptr.i, !476, !DIExpression(), !555)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !566
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !567, !llvm.loop !568

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !567

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !570, !tbaa !486
  %3 = icmp eq i8 %.pre.i, 0, !dbg !571
  %4 = select i1 %3, i64 0, i64 2, !dbg !572
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !567

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !572
    #dbg_value(ptr %spec.select38.i, !551, !DIExpression(), !552)
  %call2 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 2048) #18, !dbg !573
  tail call void @free(ptr noundef %call) #18, !dbg !574
  ret void, !dbg !575
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #3 !dbg !576 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !578, !DIExpression(), !581)
    #dbg_value(ptr %vdata, !579, !DIExpression(), !581)
    #dbg_value(ptr %vdata, !580, !DIExpression(), !581)
    #dbg_value(i32 %fd, !516, !DIExpression(), !582)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !584
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !584

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !584
  unreachable, !dbg !584

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !585
    #dbg_value(i32 %fd, !527, !DIExpression(), !586)
    #dbg_value(ptr %vdata, !532, !DIExpression(), !586)
    #dbg_value(i32 2048, !533, !DIExpression(), !586)
    #dbg_value(i32 0, !534, !DIExpression(), !586)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !588

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !534, !DIExpression(), !586)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i32, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !589
  %0 = load i32, ptr %arrayidx.i, align 4, !dbg !589, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !589
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !590
    #dbg_value(i64 %indvars.iv.next.i, !534, !DIExpression(), !586)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 2048, !dbg !590
  br i1 %exitcond.not.i, label %write_int32_t_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !588, !llvm.loop !591

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !588

write_int32_t_array.exit:                         ; preds = %for.body.i
  ret void, !dbg !592
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #6 !dbg !593 {
entry.split:
  %has_errors.032.reg2mem = alloca i32, align 4
  %data_sum.034.reg2mem = alloca i32, align 4
  %ref_sum.035.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
  %.reg2mem12 = alloca i32, align 4
    #dbg_value(ptr %vdata, !597, !DIExpression(), !605)
    #dbg_value(ptr %vref, !598, !DIExpression(), !605)
    #dbg_value(ptr %vdata, !599, !DIExpression(), !605)
    #dbg_value(ptr %vref, !600, !DIExpression(), !605)
    #dbg_value(i32 0, !601, !DIExpression(), !605)
  %0 = load i32, ptr %vdata, align 4, !dbg !606
    #dbg_value(i32 %0, !603, !DIExpression(), !605)
  %1 = load i32, ptr %vref, align 4, !dbg !607
    #dbg_value(i32 %1, !604, !DIExpression(), !605)
    #dbg_value(i32 1, !602, !DIExpression(), !605)
  store i32 0, ptr %has_errors.032.reg2mem, align 4
  store i32 %0, ptr %data_sum.034.reg2mem, align 4
  store i32 %1, ptr %ref_sum.035.reg2mem, align 4
  store i64 1, ptr %indvars.iv.reg2mem, align 8
  store i32 %0, ptr %.reg2mem12, align 4
  br label %for.body, !dbg !608

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i32 %ref_sum.035.reg2mem.0.load, !604, !DIExpression(), !605)
    #dbg_value(i32 %data_sum.034.reg2mem.0.load, !603, !DIExpression(), !605)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !602, !DIExpression(), !605)
    #dbg_value(i32 %has_errors.032.reg2mem.0.load, !601, !DIExpression(), !605)
  %.reg2mem12.0.load = load i32, ptr %.reg2mem12, align 4
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %ref_sum.035.reg2mem.0.load = load i32, ptr %ref_sum.035.reg2mem, align 4
  %data_sum.034.reg2mem.0.load = load i32, ptr %data_sum.034.reg2mem, align 4
  %has_errors.032.reg2mem.0.load = load i32, ptr %has_errors.032.reg2mem, align 4
  %arrayidx7 = getelementptr inbounds [2048 x i32], ptr %vdata, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !610
  %2 = load i32, ptr %arrayidx7, align 4, !dbg !610
  %cmp8 = icmp sgt i32 %.reg2mem12.0.load, %2, !dbg !613
  %conv = zext i1 %cmp8 to i32, !dbg !613
  %or = or i32 %has_errors.032.reg2mem.0.load, %conv, !dbg !614
    #dbg_value(i32 %or, !601, !DIExpression(), !605)
  %add = add nsw i32 %2, %data_sum.034.reg2mem.0.load, !dbg !615
    #dbg_value(i32 %add, !603, !DIExpression(), !605)
  %arrayidx14 = getelementptr inbounds [2048 x i32], ptr %vref, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !616
  %3 = load i32, ptr %arrayidx14, align 4, !dbg !616, !tbaa !386
  %add15 = add nsw i32 %3, %ref_sum.035.reg2mem.0.load, !dbg !617
    #dbg_value(i32 %add15, !604, !DIExpression(), !605)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !618
    #dbg_value(i64 %indvars.iv.next, !602, !DIExpression(), !605)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 2048, !dbg !619
  br i1 %exitcond.not, label %for.end, label %for.body.for.body_crit_edge, !dbg !608, !llvm.loop !620

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i32 %or, ptr %has_errors.032.reg2mem, align 4
  store i32 %add, ptr %data_sum.034.reg2mem, align 4
  store i32 %add15, ptr %ref_sum.035.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  store i32 %2, ptr %.reg2mem12, align 4
  br label %for.body, !dbg !608

for.end:                                          ; preds = %for.body
  %cmp16 = icmp ne i32 %add, %add15, !dbg !622
  %conv17 = zext i1 %cmp16 to i32, !dbg !622
  %or18 = or i32 %or, %conv17, !dbg !623
    #dbg_value(i32 %or18, !601, !DIExpression(), !605)
  %tobool.not = icmp eq i32 %or18, 0, !dbg !624
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !624
  ret i32 %lnot.ext, !dbg !625
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #3 !dbg !626 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !676
    #dbg_assign(i1 undef, !632, !DIExpression(), !676, ptr %s, !DIExpression(), !677)
    #dbg_value(i32 %fd, !630, !DIExpression(), !677)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #18, !dbg !678
  %cmp = icmp sgt i32 %fd, 1, !dbg !679
  br i1 %cmp, label %if.end, label %if.else, !dbg !679

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !679
  unreachable, !dbg !679

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #18, !dbg !682
  %cmp1 = icmp eq i32 %call, 0, !dbg !682
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !682

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !682
  unreachable, !dbg !682

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !685
  %0 = load i64, ptr %st_size, align 8, !dbg !685
    #dbg_value(i64 %0, !669, !DIExpression(), !677)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !686
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !686

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !686
  unreachable, !dbg !686

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !689
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #20, !dbg !690
    #dbg_value(ptr %call11, !631, !DIExpression(), !677)
    #dbg_value(i64 0, !672, !DIExpression(), !677)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !691

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !692
    #dbg_value(i64 %add19, !672, !DIExpression(), !677)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !694
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !691, !llvm.loop !695

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !691

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !672, !DIExpression(), !677)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !697
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !698
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #18, !dbg !699
    #dbg_value(i64 %call13, !675, !DIExpression(), !677)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !700
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !672, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !677)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !700

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !700
  unreachable, !dbg !700

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !703
  store i8 0, ptr %arrayidx20, align 1, !dbg !704, !tbaa !486
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #18, !dbg !705
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #18, !dbg !706
  ret ptr %call11, !dbg !707
}

; Function Attrs: noreturn nounwind
declare !dbg !708 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare !dbg !713 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !718 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #9

; Function Attrs: nofree
declare !dbg !723 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #10

declare !dbg !727 signext i32 @close(i32 noundef signext) local_unnamed_addr #11

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #3 !dbg !477 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !476, !DIExpression(), !728)
    #dbg_value(i32 %n, !481, !DIExpression(), !728)
    #dbg_value(i32 0, !482, !DIExpression(), !728)
  %cmp = icmp sgt i32 %n, -1, !dbg !729
  br i1 %cmp, label %if.end, label %if.else, !dbg !729

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #19, !dbg !729
  unreachable, !dbg !729

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !732
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !734

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !734

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !734

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !482, !DIExpression(), !728)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !476, !DIExpression(), !728)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !735, !tbaa !486
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !736

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !736

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !736

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !737
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !737, !tbaa !486
  %cmp13 = icmp eq i8 %1, 37, !dbg !738
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !739

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !739

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !740
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !740, !tbaa !486
  %cmp18 = icmp eq i8 %2, 10, !dbg !741
  %inc = zext i1 %cmp18 to i32, !dbg !742
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !742
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !742

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !482, !DIExpression(), !728)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !743
    #dbg_value(ptr %incdec.ptr, !476, !DIExpression(), !728)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !744
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !745, !llvm.loop !746

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !745

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !748, !tbaa !486
  %3 = icmp eq i8 %.pre, 0, !dbg !749
  %4 = select i1 %3, i64 0, i64 2, !dbg !750
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !745

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !750
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !750

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !751
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !752 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !756, !DIExpression(), !760)
    #dbg_value(ptr %arr, !757, !DIExpression(), !760)
    #dbg_value(i32 %n, !758, !DIExpression(), !760)
  %cmp.not = icmp eq ptr %s, null, !dbg !761
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !761

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #19, !dbg !761
  unreachable, !dbg !761

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !764
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !766

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !767
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !769
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !769

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !759, !DIExpression(), !760)
  %conv404 = zext nneg i32 %n to i64, !dbg !770
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !771
  br label %if.end46, !dbg !772

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !759, !DIExpression(), !760)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !773
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !774

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !774

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !775
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !776
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !776
  %cmp9.not = icmp eq i8 %0, 0, !dbg !777
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !778

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !778

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !779
  %1 = load i8, ptr %gep, align 1, !dbg !779
  %cmp16.not = icmp eq i8 %1, 0, !dbg !780
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !781

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !781

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !782
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !783
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !783
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !783, !llvm.loop !784

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !783

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !770

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !770

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !770

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !770
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !759, !DIExpression(), !760)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !771
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !786
  store i8 0, ptr %arrayidx45, align 1, !dbg !788, !tbaa !486
  br label %if.end46, !dbg !786

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !789
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !790 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !802
    #dbg_assign(i1 undef, !799, !DIExpression(), !802, ptr %endptr, !DIExpression(), !803)
    #dbg_value(ptr %s, !795, !DIExpression(), !803)
    #dbg_value(ptr %arr, !796, !DIExpression(), !803)
    #dbg_value(i32 %n, !797, !DIExpression(), !803)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !804
    #dbg_value(i32 0, !800, !DIExpression(), !803)
  %cmp.not = icmp eq ptr %s, null, !dbg !805
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !805

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #19, !dbg !805
  unreachable, !dbg !805

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !804
    #dbg_value(ptr %call, !798, !DIExpression(), !803)
    #dbg_value(i32 0, !800, !DIExpression(), !803)
  %cmp130 = icmp ne ptr %call, null, !dbg !804
  %cmp231 = icmp sgt i32 %n, 0, !dbg !804
  %0 = and i1 %cmp231, %cmp130, !dbg !804
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !804

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !804

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !804
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !804

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !798, !DIExpression(), !803)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !800, !DIExpression(), !803)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !808, !tbaa !810, !DIAssignID !812
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !799, !DIExpression(), !812, ptr %endptr, !DIExpression(), !803)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !808
  %conv = trunc i64 %call3 to i8, !dbg !808
    #dbg_value(i8 %conv, !801, !DIExpression(), !803)
  %2 = load ptr, ptr %endptr, align 8, !dbg !813, !tbaa !810
  %3 = load i8, ptr %2, align 1, !dbg !813, !tbaa !486
  %cmp5.not = icmp eq i8 %3, 0, !dbg !813
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !808

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !808

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !815, !tbaa !810
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !815
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !815
  br label %if.end9, !dbg !815

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !808
  store i8 %conv, ptr %arrayidx, align 1, !dbg !808, !tbaa !486
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !808
    #dbg_value(i64 %indvars.iv.next, !800, !DIExpression(), !803)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !808
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !808
  store i8 10, ptr %arrayidx11, align 1, !dbg !808, !tbaa !486
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !808
    #dbg_value(ptr %call12, !798, !DIExpression(), !803)
  %cmp1 = icmp ne ptr %call12, null, !dbg !804
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !804
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !804
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !804, !llvm.loop !817

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !804

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !804

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !804

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !804

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !818
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !818
  store i8 10, ptr %arrayidx17, align 1, !dbg !818, !tbaa !486
  br label %if.end18, !dbg !818

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !804
  ret i32 0, !dbg !804
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !821 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #12

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !827 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #12

; Function Attrs: nofree nounwind
declare !dbg !832 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !887 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !890 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !902
    #dbg_assign(i1 undef, !899, !DIExpression(), !902, ptr %endptr, !DIExpression(), !903)
    #dbg_value(ptr %s, !895, !DIExpression(), !903)
    #dbg_value(ptr %arr, !896, !DIExpression(), !903)
    #dbg_value(i32 %n, !897, !DIExpression(), !903)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !904
    #dbg_value(i32 0, !900, !DIExpression(), !903)
  %cmp.not = icmp eq ptr %s, null, !dbg !905
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !905

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #19, !dbg !905
  unreachable, !dbg !905

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !904
    #dbg_value(ptr %call, !898, !DIExpression(), !903)
    #dbg_value(i32 0, !900, !DIExpression(), !903)
  %cmp130 = icmp ne ptr %call, null, !dbg !904
  %cmp231 = icmp sgt i32 %n, 0, !dbg !904
  %0 = and i1 %cmp231, %cmp130, !dbg !904
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !904

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !904

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !904
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !904

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !898, !DIExpression(), !903)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !900, !DIExpression(), !903)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !908, !tbaa !810, !DIAssignID !910
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !899, !DIExpression(), !910, ptr %endptr, !DIExpression(), !903)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !908
  %conv = trunc i64 %call3 to i16, !dbg !908
    #dbg_value(i16 %conv, !901, !DIExpression(), !903)
  %2 = load ptr, ptr %endptr, align 8, !dbg !911, !tbaa !810
  %3 = load i8, ptr %2, align 1, !dbg !911, !tbaa !486
  %cmp5.not = icmp eq i8 %3, 0, !dbg !911
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !908

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !908

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !913, !tbaa !810
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !913
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !913
  br label %if.end9, !dbg !913

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !908
  store i16 %conv, ptr %arrayidx, align 2, !dbg !908, !tbaa !915
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !908
    #dbg_value(i64 %indvars.iv.next, !900, !DIExpression(), !903)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !908
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !908
  store i8 10, ptr %arrayidx11, align 1, !dbg !908, !tbaa !486
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !908
    #dbg_value(ptr %call12, !898, !DIExpression(), !903)
  %cmp1 = icmp ne ptr %call12, null, !dbg !904
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !904
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !904
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !904, !llvm.loop !917

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !904

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !904

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !904

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !904

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !918
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !918
  store i8 10, ptr %arrayidx17, align 1, !dbg !918, !tbaa !486
  br label %if.end18, !dbg !918

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !904
  ret i32 0, !dbg !904
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !921 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !933
    #dbg_assign(i1 undef, !930, !DIExpression(), !933, ptr %endptr, !DIExpression(), !934)
    #dbg_value(ptr %s, !926, !DIExpression(), !934)
    #dbg_value(ptr %arr, !927, !DIExpression(), !934)
    #dbg_value(i32 %n, !928, !DIExpression(), !934)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !935
    #dbg_value(i32 0, !931, !DIExpression(), !934)
  %cmp.not = icmp eq ptr %s, null, !dbg !936
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !936

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #19, !dbg !936
  unreachable, !dbg !936

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !935
    #dbg_value(ptr %call, !929, !DIExpression(), !934)
    #dbg_value(i32 0, !931, !DIExpression(), !934)
  %cmp130 = icmp ne ptr %call, null, !dbg !935
  %cmp231 = icmp sgt i32 %n, 0, !dbg !935
  %0 = and i1 %cmp231, %cmp130, !dbg !935
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !935

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !935

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !935
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !935

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !929, !DIExpression(), !934)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !931, !DIExpression(), !934)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !939, !tbaa !810, !DIAssignID !941
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !930, !DIExpression(), !941, ptr %endptr, !DIExpression(), !934)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !939
  %conv = trunc i64 %call3 to i32, !dbg !939
    #dbg_value(i32 %conv, !932, !DIExpression(), !934)
  %2 = load ptr, ptr %endptr, align 8, !dbg !942, !tbaa !810
  %3 = load i8, ptr %2, align 1, !dbg !942, !tbaa !486
  %cmp5.not = icmp eq i8 %3, 0, !dbg !942
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !939

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !939

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !944, !tbaa !810
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !944
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !944
  br label %if.end9, !dbg !944

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !939
  store i32 %conv, ptr %arrayidx, align 4, !dbg !939, !tbaa !386
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !939
    #dbg_value(i64 %indvars.iv.next, !931, !DIExpression(), !934)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !939
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !939
  store i8 10, ptr %arrayidx11, align 1, !dbg !939, !tbaa !486
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !939
    #dbg_value(ptr %call12, !929, !DIExpression(), !934)
  %cmp1 = icmp ne ptr %call12, null, !dbg !935
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !935
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !935
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !935, !llvm.loop !946

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !935

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !935

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !935

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !935

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !947
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !947
  store i8 10, ptr %arrayidx17, align 1, !dbg !947, !tbaa !486
  br label %if.end18, !dbg !947

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !935
  ret i32 0, !dbg !935
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !950 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !962
    #dbg_assign(i1 undef, !959, !DIExpression(), !962, ptr %endptr, !DIExpression(), !963)
    #dbg_value(ptr %s, !955, !DIExpression(), !963)
    #dbg_value(ptr %arr, !956, !DIExpression(), !963)
    #dbg_value(i32 %n, !957, !DIExpression(), !963)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !964
    #dbg_value(i32 0, !960, !DIExpression(), !963)
  %cmp.not = icmp eq ptr %s, null, !dbg !965
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !965

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #19, !dbg !965
  unreachable, !dbg !965

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !964
    #dbg_value(ptr %call, !958, !DIExpression(), !963)
    #dbg_value(i32 0, !960, !DIExpression(), !963)
  %cmp129 = icmp ne ptr %call, null, !dbg !964
  %cmp230 = icmp sgt i32 %n, 0, !dbg !964
  %0 = and i1 %cmp230, %cmp129, !dbg !964
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !964

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !964

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !964
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !964

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !958, !DIExpression(), !963)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !960, !DIExpression(), !963)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !968, !tbaa !810, !DIAssignID !970
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !959, !DIExpression(), !970, ptr %endptr, !DIExpression(), !963)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !968
    #dbg_value(i64 %call3, !961, !DIExpression(), !963)
  %2 = load ptr, ptr %endptr, align 8, !dbg !971, !tbaa !810
  %3 = load i8, ptr %2, align 1, !dbg !971, !tbaa !486
  %cmp4.not = icmp eq i8 %3, 0, !dbg !971
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !968

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !968

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !973, !tbaa !810
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !973
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !973
  br label %if.end8, !dbg !973

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !968
  store i64 %call3, ptr %arrayidx, align 8, !dbg !968, !tbaa !975
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !968
    #dbg_value(i64 %indvars.iv.next, !960, !DIExpression(), !963)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !968
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !968
  store i8 10, ptr %arrayidx10, align 1, !dbg !968, !tbaa !486
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !968
    #dbg_value(ptr %call11, !958, !DIExpression(), !963)
  %cmp1 = icmp ne ptr %call11, null, !dbg !964
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !964
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !964
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !964, !llvm.loop !977

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !964

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !964

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !964

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !964

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !978
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !978
  store i8 10, ptr %arrayidx16, align 1, !dbg !978, !tbaa !486
  br label %if.end17, !dbg !978

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !964
  ret i32 0, !dbg !964
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !981 {
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
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !995
    #dbg_value(i32 0, !991, !DIExpression(), !994)
  %cmp.not = icmp eq ptr %s, null, !dbg !996
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !996

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #19, !dbg !996
  unreachable, !dbg !996

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !995
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
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !999, !tbaa !810, !DIAssignID !1001
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !990, !DIExpression(), !1001, ptr %endptr, !DIExpression(), !994)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !999
  %conv = trunc i64 %call3 to i8, !dbg !999
    #dbg_value(i8 %conv, !992, !DIExpression(), !994)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1002, !tbaa !810
  %3 = load i8, ptr %2, align 1, !dbg !1002, !tbaa !486
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1002
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !999

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !999

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1004, !tbaa !810
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1004
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1004
  br label %if.end9, !dbg !1004

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !999
  store i8 %conv, ptr %arrayidx, align 1, !dbg !999, !tbaa !486
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !999
    #dbg_value(i64 %indvars.iv.next, !991, !DIExpression(), !994)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !999
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !999
  store i8 10, ptr %arrayidx11, align 1, !dbg !999, !tbaa !486
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !999
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
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1007
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1007
  store i8 10, ptr %arrayidx17, align 1, !dbg !1007, !tbaa !486
  br label %if.end18, !dbg !1007

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !995
  ret i32 0, !dbg !995
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1010 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1022
    #dbg_assign(i1 undef, !1019, !DIExpression(), !1022, ptr %endptr, !DIExpression(), !1023)
    #dbg_value(ptr %s, !1015, !DIExpression(), !1023)
    #dbg_value(ptr %arr, !1016, !DIExpression(), !1023)
    #dbg_value(i32 %n, !1017, !DIExpression(), !1023)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1024
    #dbg_value(i32 0, !1020, !DIExpression(), !1023)
  %cmp.not = icmp eq ptr %s, null, !dbg !1025
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1025

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #19, !dbg !1025
  unreachable, !dbg !1025

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1024
    #dbg_value(ptr %call, !1018, !DIExpression(), !1023)
    #dbg_value(i32 0, !1020, !DIExpression(), !1023)
  %cmp130 = icmp ne ptr %call, null, !dbg !1024
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1024
  %0 = and i1 %cmp231, %cmp130, !dbg !1024
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1024

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1024

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1024
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1024

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1018, !DIExpression(), !1023)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1020, !DIExpression(), !1023)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1028, !tbaa !810, !DIAssignID !1030
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1019, !DIExpression(), !1030, ptr %endptr, !DIExpression(), !1023)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1028
  %conv = trunc i64 %call3 to i16, !dbg !1028
    #dbg_value(i16 %conv, !1021, !DIExpression(), !1023)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1031, !tbaa !810
  %3 = load i8, ptr %2, align 1, !dbg !1031, !tbaa !486
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1031
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1028

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1028

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1033, !tbaa !810
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1033
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1033
  br label %if.end9, !dbg !1033

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1028
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1028, !tbaa !915
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1028
    #dbg_value(i64 %indvars.iv.next, !1020, !DIExpression(), !1023)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1028
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1028
  store i8 10, ptr %arrayidx11, align 1, !dbg !1028, !tbaa !486
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1028
    #dbg_value(ptr %call12, !1018, !DIExpression(), !1023)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1024
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1024
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1024
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1024, !llvm.loop !1035

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1024

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1024

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1024

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1024

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1036
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1036
  store i8 10, ptr %arrayidx17, align 1, !dbg !1036, !tbaa !486
  br label %if.end18, !dbg !1036

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1024
  ret i32 0, !dbg !1024
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1039 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1050
    #dbg_assign(i1 undef, !1047, !DIExpression(), !1050, ptr %endptr, !DIExpression(), !1051)
    #dbg_value(ptr %s, !1043, !DIExpression(), !1051)
    #dbg_value(ptr %arr, !1044, !DIExpression(), !1051)
    #dbg_value(i32 %n, !1045, !DIExpression(), !1051)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1052
    #dbg_value(i32 0, !1048, !DIExpression(), !1051)
  %cmp.not = icmp eq ptr %s, null, !dbg !1053
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1053

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #19, !dbg !1053
  unreachable, !dbg !1053

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1052
    #dbg_value(ptr %call, !1046, !DIExpression(), !1051)
    #dbg_value(i32 0, !1048, !DIExpression(), !1051)
  %cmp130 = icmp ne ptr %call, null, !dbg !1052
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1052
  %0 = and i1 %cmp231, %cmp130, !dbg !1052
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1052

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1052

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1052
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1052

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1046, !DIExpression(), !1051)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1048, !DIExpression(), !1051)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1056, !tbaa !810, !DIAssignID !1058
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1047, !DIExpression(), !1058, ptr %endptr, !DIExpression(), !1051)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1056
  %conv = trunc i64 %call3 to i32, !dbg !1056
    #dbg_value(i32 %conv, !1049, !DIExpression(), !1051)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1059, !tbaa !810
  %3 = load i8, ptr %2, align 1, !dbg !1059, !tbaa !486
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1059
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1056

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1056

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1061, !tbaa !810
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1061
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1061
  br label %if.end9, !dbg !1061

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1056
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1056, !tbaa !386
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1056
    #dbg_value(i64 %indvars.iv.next, !1048, !DIExpression(), !1051)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1056
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1056
  store i8 10, ptr %arrayidx11, align 1, !dbg !1056, !tbaa !486
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1056
    #dbg_value(ptr %call12, !1046, !DIExpression(), !1051)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1052
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1052
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1052
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1052, !llvm.loop !1063

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1052

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1052

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1052

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1052

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1064
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1064
  store i8 10, ptr %arrayidx17, align 1, !dbg !1064, !tbaa !486
  br label %if.end18, !dbg !1064

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1052
  ret i32 0, !dbg !1052
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1067 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1079
    #dbg_assign(i1 undef, !1076, !DIExpression(), !1079, ptr %endptr, !DIExpression(), !1080)
    #dbg_value(ptr %s, !1072, !DIExpression(), !1080)
    #dbg_value(ptr %arr, !1073, !DIExpression(), !1080)
    #dbg_value(i32 %n, !1074, !DIExpression(), !1080)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1081
    #dbg_value(i32 0, !1077, !DIExpression(), !1080)
  %cmp.not = icmp eq ptr %s, null, !dbg !1082
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1082

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #19, !dbg !1082
  unreachable, !dbg !1082

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1081
    #dbg_value(ptr %call, !1075, !DIExpression(), !1080)
    #dbg_value(i32 0, !1077, !DIExpression(), !1080)
  %cmp129 = icmp ne ptr %call, null, !dbg !1081
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1081
  %0 = and i1 %cmp230, %cmp129, !dbg !1081
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1081

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1081

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1081
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1081

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1075, !DIExpression(), !1080)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1077, !DIExpression(), !1080)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1085, !tbaa !810, !DIAssignID !1087
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1076, !DIExpression(), !1087, ptr %endptr, !DIExpression(), !1080)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1085
    #dbg_value(i64 %call3, !1078, !DIExpression(), !1080)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1088, !tbaa !810
  %3 = load i8, ptr %2, align 1, !dbg !1088, !tbaa !486
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1088
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1085

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1085

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1090, !tbaa !810
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1090
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1090
  br label %if.end8, !dbg !1090

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1085
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1085, !tbaa !975
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1085
    #dbg_value(i64 %indvars.iv.next, !1077, !DIExpression(), !1080)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1085
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1085
  store i8 10, ptr %arrayidx10, align 1, !dbg !1085, !tbaa !486
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1085
    #dbg_value(ptr %call11, !1075, !DIExpression(), !1080)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1081
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1081
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1081
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1081, !llvm.loop !1092

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1081

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1081

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1081

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1081

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1093
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1093
  store i8 10, ptr %arrayidx16, align 1, !dbg !1093, !tbaa !486
  br label %if.end17, !dbg !1093

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1081
  ret i32 0, !dbg !1081
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1096 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1108
    #dbg_assign(i1 undef, !1105, !DIExpression(), !1108, ptr %endptr, !DIExpression(), !1109)
    #dbg_value(ptr %s, !1101, !DIExpression(), !1109)
    #dbg_value(ptr %arr, !1102, !DIExpression(), !1109)
    #dbg_value(i32 %n, !1103, !DIExpression(), !1109)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1110
    #dbg_value(i32 0, !1106, !DIExpression(), !1109)
  %cmp.not = icmp eq ptr %s, null, !dbg !1111
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1111

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #19, !dbg !1111
  unreachable, !dbg !1111

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1110
    #dbg_value(ptr %call, !1104, !DIExpression(), !1109)
    #dbg_value(i32 0, !1106, !DIExpression(), !1109)
  %cmp129 = icmp ne ptr %call, null, !dbg !1110
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1110
  %0 = and i1 %cmp230, %cmp129, !dbg !1110
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1110

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1110

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1110
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1110

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1104, !DIExpression(), !1109)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1106, !DIExpression(), !1109)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1114, !tbaa !810, !DIAssignID !1116
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1105, !DIExpression(), !1116, ptr %endptr, !DIExpression(), !1109)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1114
    #dbg_value(float %call3, !1107, !DIExpression(), !1109)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1117, !tbaa !810
  %3 = load i8, ptr %2, align 1, !dbg !1117, !tbaa !486
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1117
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1114

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1114

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1119, !tbaa !810
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1119
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1119
  br label %if.end8, !dbg !1119

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1114
  store float %call3, ptr %arrayidx, align 4, !dbg !1114, !tbaa !1121
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1114
    #dbg_value(i64 %indvars.iv.next, !1106, !DIExpression(), !1109)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1114
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1114
  store i8 10, ptr %arrayidx10, align 1, !dbg !1114, !tbaa !486
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1114
    #dbg_value(ptr %call11, !1104, !DIExpression(), !1109)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1110
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1110
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1110
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1110, !llvm.loop !1123

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1110

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1110

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1110

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1110

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1124
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1124
  store i8 10, ptr %arrayidx16, align 1, !dbg !1124, !tbaa !486
  br label %if.end17, !dbg !1124

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1110
  ret i32 0, !dbg !1110
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1127 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1130 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1142
    #dbg_assign(i1 undef, !1139, !DIExpression(), !1142, ptr %endptr, !DIExpression(), !1143)
    #dbg_value(ptr %s, !1135, !DIExpression(), !1143)
    #dbg_value(ptr %arr, !1136, !DIExpression(), !1143)
    #dbg_value(i32 %n, !1137, !DIExpression(), !1143)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1144
    #dbg_value(i32 0, !1140, !DIExpression(), !1143)
  %cmp.not = icmp eq ptr %s, null, !dbg !1145
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1145

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #19, !dbg !1145
  unreachable, !dbg !1145

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1144
    #dbg_value(ptr %call, !1138, !DIExpression(), !1143)
    #dbg_value(i32 0, !1140, !DIExpression(), !1143)
  %cmp129 = icmp ne ptr %call, null, !dbg !1144
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1144
  %0 = and i1 %cmp230, %cmp129, !dbg !1144
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1144

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1144

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1144
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1144

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1138, !DIExpression(), !1143)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1140, !DIExpression(), !1143)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1148, !tbaa !810, !DIAssignID !1150
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1139, !DIExpression(), !1150, ptr %endptr, !DIExpression(), !1143)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1148
    #dbg_value(double %call3, !1141, !DIExpression(), !1143)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1151, !tbaa !810
  %3 = load i8, ptr %2, align 1, !dbg !1151, !tbaa !486
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1151
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1148

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1148

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1153, !tbaa !810
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1153
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1153
  br label %if.end8, !dbg !1153

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1148
  store double %call3, ptr %arrayidx, align 8, !dbg !1148, !tbaa !1155
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1148
    #dbg_value(i64 %indvars.iv.next, !1140, !DIExpression(), !1143)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1148
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1148
  store i8 10, ptr %arrayidx10, align 1, !dbg !1148, !tbaa !486
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1148
    #dbg_value(ptr %call11, !1138, !DIExpression(), !1143)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1144
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1144
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1144
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1144, !llvm.loop !1157

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1144

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1144

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1144

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1144

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1158
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1158
  store i8 10, ptr %arrayidx16, align 1, !dbg !1158, !tbaa !486
  br label %if.end17, !dbg !1158

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1144
  ret i32 0, !dbg !1144
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1161 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1164 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1168, !DIExpression(), !1173)
    #dbg_value(ptr %arr, !1169, !DIExpression(), !1173)
    #dbg_value(i32 %n, !1170, !DIExpression(), !1173)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1174
  br i1 %cmp, label %if.end, label %if.else, !dbg !1174

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1174
  unreachable, !dbg !1174

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1177
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1179

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1179

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #22, !dbg !1180
  %conv = trunc i64 %call to i32, !dbg !1180
    #dbg_value(i32 %conv, !1170, !DIExpression(), !1173)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1182

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1170, !DIExpression(), !1173)
    #dbg_value(i32 0, !1172, !DIExpression(), !1173)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1183
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1184

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1184

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1184

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1185

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1186
    #dbg_value(i32 %add, !1172, !DIExpression(), !1173)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1183
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1184, !llvm.loop !1188

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1184

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1184

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1172, !DIExpression(), !1173)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1190
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1190
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1191
  %conv6 = sext i32 %sub to i64, !dbg !1192
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #18, !dbg !1193
  %conv8 = trunc i64 %call7 to i32, !dbg !1193
    #dbg_value(i32 %conv8, !1171, !DIExpression(), !1173)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1194
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1172, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1173)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1194

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1194
  unreachable, !dbg !1194

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #18, !dbg !1197
  %conv16 = trunc i64 %call15 to i32, !dbg !1197
    #dbg_value(i32 %conv16, !1171, !DIExpression(), !1173)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1199
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1199

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1199
  unreachable, !dbg !1199

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1202
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1203, !llvm.loop !1204

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1203

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1206
}

; Function Attrs: nofree
declare !dbg !1207 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #10

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1212 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1216, !DIExpression(), !1220)
    #dbg_value(ptr %arr, !1217, !DIExpression(), !1220)
    #dbg_value(i32 %n, !1218, !DIExpression(), !1220)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1221
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1221

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1219, !DIExpression(), !1220)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1224
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1227

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1227

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1224
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1227

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #19, !dbg !1221
  unreachable, !dbg !1221

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1219, !DIExpression(), !1220)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1228
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1228, !tbaa !486
  %conv = zext i8 %0 to i32, !dbg !1228
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1228
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1224
    #dbg_value(i64 %indvars.iv.next, !1219, !DIExpression(), !1220)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1224
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1227, !llvm.loop !1230

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1227

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1227

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1231
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #14 !dbg !1232 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1249
    #dbg_assign(i1 undef, !1238, !DIExpression(), !1249, ptr %args, !DIExpression(), !1250)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1251
    #dbg_assign(i1 undef, !1245, !DIExpression(), !1251, ptr %buffer, !DIExpression(), !1250)
    #dbg_value(i32 %fd, !1236, !DIExpression(), !1250)
    #dbg_value(ptr %format, !1237, !DIExpression(), !1250)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #18, !dbg !1252
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1253
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1254
  %0 = load ptr, ptr %args, align 8, !dbg !1255, !tbaa !810
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #18, !dbg !1256
    #dbg_value(i32 %call, !1242, !DIExpression(), !1250)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1257
  %cmp = icmp slt i32 %call, 256, !dbg !1258
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1258

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1243, !DIExpression(), !1250)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1261
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1262

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1262

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1262

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1258
  unreachable, !dbg !1258

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1263
    #dbg_value(i32 %add, !1243, !DIExpression(), !1250)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1261
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1262, !llvm.loop !1265

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1262

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1262

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1243, !DIExpression(), !1250)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1267
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1267
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1268
  %conv = sext i32 %sub to i64, !dbg !1269
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #18, !dbg !1270
  %conv3 = trunc i64 %call2 to i32, !dbg !1270
    #dbg_value(i32 %conv3, !1244, !DIExpression(), !1250)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1271
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1243, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1250)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1271

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1271
  unreachable, !dbg !1271

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1274
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1274

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1274
  unreachable, !dbg !1274

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1277
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #18, !dbg !1277
  ret void, !dbg !1278
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #15

; Function Attrs: nofree nounwind
declare !dbg !1279 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #8

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1284 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1288, !DIExpression(), !1292)
    #dbg_value(ptr %arr, !1289, !DIExpression(), !1292)
    #dbg_value(i32 %n, !1290, !DIExpression(), !1292)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1293
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1293

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1291, !DIExpression(), !1292)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1296
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1299

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1299

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1296
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1299

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #19, !dbg !1293
  unreachable, !dbg !1293

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1291, !DIExpression(), !1292)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1300
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1300, !tbaa !915
  %conv = zext i16 %0 to i32, !dbg !1300
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1300
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1296
    #dbg_value(i64 %indvars.iv.next, !1291, !DIExpression(), !1292)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1296
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1299, !llvm.loop !1302

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1299

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1299

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1303
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1304 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1308, !DIExpression(), !1312)
    #dbg_value(ptr %arr, !1309, !DIExpression(), !1312)
    #dbg_value(i32 %n, !1310, !DIExpression(), !1312)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1313
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1313

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1311, !DIExpression(), !1312)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1316
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1319

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1319

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1316
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1319

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #19, !dbg !1313
  unreachable, !dbg !1313

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1311, !DIExpression(), !1312)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1320
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1320, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1320
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1316
    #dbg_value(i64 %indvars.iv.next, !1311, !DIExpression(), !1312)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1316
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1319, !llvm.loop !1322

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1319

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1319

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1323
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1324 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1328, !DIExpression(), !1332)
    #dbg_value(ptr %arr, !1329, !DIExpression(), !1332)
    #dbg_value(i32 %n, !1330, !DIExpression(), !1332)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1333
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1333

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1331, !DIExpression(), !1332)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1336
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1339

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1339

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1336
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1339

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #19, !dbg !1333
  unreachable, !dbg !1333

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1331, !DIExpression(), !1332)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1340
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1340, !tbaa !975
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1340
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1336
    #dbg_value(i64 %indvars.iv.next, !1331, !DIExpression(), !1332)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1336
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1339, !llvm.loop !1342

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1339

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1339

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1343
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1344 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1348, !DIExpression(), !1352)
    #dbg_value(ptr %arr, !1349, !DIExpression(), !1352)
    #dbg_value(i32 %n, !1350, !DIExpression(), !1352)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1353
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1353

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1351, !DIExpression(), !1352)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1356
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1359

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1359

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1356
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1359

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #19, !dbg !1353
  unreachable, !dbg !1353

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1351, !DIExpression(), !1352)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1360
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1360, !tbaa !486
  %conv = sext i8 %0 to i32, !dbg !1360
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1360
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1356
    #dbg_value(i64 %indvars.iv.next, !1351, !DIExpression(), !1352)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1356
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1359, !llvm.loop !1362

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1359

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1359

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1363
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1364 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1368, !DIExpression(), !1372)
    #dbg_value(ptr %arr, !1369, !DIExpression(), !1372)
    #dbg_value(i32 %n, !1370, !DIExpression(), !1372)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1373
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1373

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1371, !DIExpression(), !1372)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1376
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1379

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1379

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1376
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1379

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #19, !dbg !1373
  unreachable, !dbg !1373

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1371, !DIExpression(), !1372)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1380
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1380, !tbaa !915
  %conv = sext i16 %0 to i32, !dbg !1380
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1380
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1376
    #dbg_value(i64 %indvars.iv.next, !1371, !DIExpression(), !1372)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1376
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1379, !llvm.loop !1382

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1379

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1379

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1383
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !528 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !527, !DIExpression(), !1384)
    #dbg_value(ptr %arr, !532, !DIExpression(), !1384)
    #dbg_value(i32 %n, !533, !DIExpression(), !1384)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1385
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1385

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !534, !DIExpression(), !1384)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1388
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1389

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1389

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1388
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1389

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #19, !dbg !1385
  unreachable, !dbg !1385

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !534, !DIExpression(), !1384)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1390
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1390, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1390
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1388
    #dbg_value(i64 %indvars.iv.next, !534, !DIExpression(), !1384)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1388
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1389, !llvm.loop !1391

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1389

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1389

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1392
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1393 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1397, !DIExpression(), !1401)
    #dbg_value(ptr %arr, !1398, !DIExpression(), !1401)
    #dbg_value(i32 %n, !1399, !DIExpression(), !1401)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1402
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1402

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1400, !DIExpression(), !1401)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1405
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1408

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1408

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1405
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1408

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #19, !dbg !1402
  unreachable, !dbg !1402

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1400, !DIExpression(), !1401)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1409
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1409, !tbaa !975
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1409
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1405
    #dbg_value(i64 %indvars.iv.next, !1400, !DIExpression(), !1401)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1405
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1408, !llvm.loop !1411

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1408

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1408

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1412
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1413 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1417, !DIExpression(), !1421)
    #dbg_value(ptr %arr, !1418, !DIExpression(), !1421)
    #dbg_value(i32 %n, !1419, !DIExpression(), !1421)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1422
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1422

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1420, !DIExpression(), !1421)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1425
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1428

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1428

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1425
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1428

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #19, !dbg !1422
  unreachable, !dbg !1422

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1420, !DIExpression(), !1421)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1429
  %0 = load float, ptr %arrayidx, align 4, !dbg !1429, !tbaa !1121
  %conv = fpext float %0 to double, !dbg !1429
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1429
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1425
    #dbg_value(i64 %indvars.iv.next, !1420, !DIExpression(), !1421)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1425
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1428, !llvm.loop !1431

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1428

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1428

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1432
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #3 !dbg !1433 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1437, !DIExpression(), !1441)
    #dbg_value(ptr %arr, !1438, !DIExpression(), !1441)
    #dbg_value(i32 %n, !1439, !DIExpression(), !1441)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1442
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1442

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1440, !DIExpression(), !1441)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1445
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1448

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1448

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1445
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1448

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #19, !dbg !1442
  unreachable, !dbg !1442

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1440, !DIExpression(), !1441)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1449
  %0 = load double, ptr %arrayidx, align 8, !dbg !1449, !tbaa !1155
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1449
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1445
    #dbg_value(i64 %indvars.iv.next, !1440, !DIExpression(), !1441)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1445
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1448, !llvm.loop !1451

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1448

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1448

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1452
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #3 !dbg !517 {
entry.split:
    #dbg_value(i32 %fd, !516, !DIExpression(), !1453)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1454
  br i1 %cmp, label %if.end, label %if.else, !dbg !1454

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1454
  unreachable, !dbg !1454

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1455
  ret i32 0, !dbg !1456
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #3 !dbg !1457 {
entry.split:
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.032.i.reg2mem = alloca i32, align 4
  %data_sum.034.i.reg2mem = alloca i32, align 4
  %ref_sum.035.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %.reg2mem103 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.i15.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i14.reg2mem = alloca i64, align 8
  %i.1.i.i9.reg2mem105 = alloca i32, align 4
  %s.addr.040.i.i4.reg2mem107 = alloca ptr, align 8
  %i.041.i.i3.reg2mem109 = alloca i32, align 4
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem111 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem113 = alloca ptr, align 8
  %i.041.i.i.reg2mem115 = alloca i32, align 4
  %check_file.0.reg2mem117 = alloca ptr, align 8
  %in_file.025.reg2mem119 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1461, !DIExpression(), !1470)
    #dbg_value(ptr %argv, !1462, !DIExpression(), !1470)
  %cmp = icmp slt i32 %argc, 4, !dbg !1471
  br i1 %cmp, label %if.end, label %if.else, !dbg !1471

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1471
  unreachable, !dbg !1471

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1463, !DIExpression(), !1470)
    #dbg_value(ptr @.str.4.13, !1464, !DIExpression(), !1470)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1474
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1476

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.13, ptr %check_file.0.reg2mem117, align 8
  store ptr @.str.3, ptr %in_file.025.reg2mem119, align 8
  br label %if.end7, !dbg !1476

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1477
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1477
    #dbg_value(ptr %0, !1463, !DIExpression(), !1470)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1478
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1480

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.13, ptr %check_file.0.reg2mem117, align 8
  store ptr %0, ptr %in_file.025.reg2mem119, align 8
  br label %if.end7, !dbg !1480

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1481
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1481
    #dbg_value(ptr %1, !1464, !DIExpression(), !1470)
  store ptr %1, ptr %check_file.0.reg2mem117, align 8
  store ptr %0, ptr %in_file.025.reg2mem119, align 8
  br label %if.end7, !dbg !1482

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem117.0.check_file.0.reload118, !1464, !DIExpression(), !1470)
  %in_file.025.reg2mem119.0.in_file.025.reload120 = load ptr, ptr %in_file.025.reg2mem119, align 8
  %check_file.0.reg2mem117.0.check_file.0.reload118 = load ptr, ptr %check_file.0.reg2mem117, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1483, !tbaa !386
  %conv = sext i32 %2 to i64, !dbg !1483
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #20, !dbg !1484
    #dbg_value(ptr %call, !1466, !DIExpression(), !1470)
  %cmp8.not = icmp eq ptr %call, null, !dbg !1485
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1485

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.14, ptr noundef nonnull @.str.2.12, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1485
  unreachable, !dbg !1485

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.025.reg2mem119.0.in_file.025.reload120, i32 noundef signext 0) #18, !dbg !1488
    #dbg_value(i32 %call14, !1465, !DIExpression(), !1470)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1489
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1489

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.15, ptr noundef nonnull @.str.2.12, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1489
  unreachable, !dbg !1489

if.end20:                                         ; preds = %if.end13
    #dbg_value(i32 %call14, !468, !DIExpression(), !1492)
    #dbg_value(ptr %call, !469, !DIExpression(), !1492)
    #dbg_value(ptr %call, !470, !DIExpression(), !1492)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(8192) %call, i8 0, i64 8192, i1 false), !dbg !1494
  %call.i = tail call ptr @readfile(i32 noundef signext %call14) #18, !dbg !1495
    #dbg_value(ptr %call.i, !471, !DIExpression(), !1492)
    #dbg_value(ptr %call.i, !476, !DIExpression(), !1496)
    #dbg_value(i32 1, !481, !DIExpression(), !1496)
    #dbg_value(i32 0, !482, !DIExpression(), !1496)
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem113, align 8
  store i32 0, ptr %i.041.i.i.reg2mem115, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end20
    #dbg_value(i32 %i.041.i.i.reg2mem115.0.load, !482, !DIExpression(), !1496)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem113.0.s.addr.040.i.i.reload114, !476, !DIExpression(), !1496)
  %i.041.i.i.reg2mem115.0.load = load i32, ptr %i.041.i.i.reg2mem115, align 4
  %s.addr.040.i.i.reg2mem113.0.s.addr.040.i.i.reload114 = load ptr, ptr %s.addr.040.i.i.reg2mem113, align 8
  %3 = load i8, ptr %s.addr.040.i.i.reg2mem113.0.s.addr.040.i.i.reload114, align 1, !dbg !1498, !tbaa !486
  switch i8 %3, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.input_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1499

land.rhs.i.i.input_to_data.exit_crit_edge:        ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem113.0.s.addr.040.i.i.reload114, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %input_to_data.exit, !dbg !1499

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem115.0.load, ptr %i.1.i.i.reg2mem111, align 4
  br label %if.end21.i.i, !dbg !1499

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem113.0.s.addr.040.i.i.reload114, i64 1, !dbg !1500
  %4 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !1500, !tbaa !486
  %cmp13.i.i = icmp eq i8 %4, 37, !dbg !1501
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1502

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem115.0.load, ptr %i.1.i.i.reg2mem111, align 4
  br label %if.end21.i.i, !dbg !1502

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem113.0.s.addr.040.i.i.reload114, i64 2, !dbg !1503
  %5 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1503, !tbaa !486
  %cmp18.i.i = icmp eq i8 %5, 10, !dbg !1504
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1505
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem115.0.load, %inc.i.i, !dbg !1505
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem111, align 4
  br label %if.end21.i.i, !dbg !1505

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem111.0.load, !482, !DIExpression(), !1496)
  %i.1.i.i.reg2mem111.0.load = load i32, ptr %i.1.i.i.reg2mem111, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem113.0.s.addr.040.i.i.reload114, i64 1, !dbg !1506
    #dbg_value(ptr %incdec.ptr.i.i, !476, !DIExpression(), !1496)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem111.0.load, 1, !dbg !1507
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1508, !llvm.loop !1509

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem113, align 8
  store i32 %i.1.i.i.reg2mem111.0.load, ptr %i.041.i.i.reg2mem115, align 4
  br label %land.rhs.i.i, !dbg !1508

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1511, !tbaa !486
  %6 = icmp eq i8 %.pre.i.i, 0, !dbg !1512
  %7 = select i1 %6, i64 0, i64 2, !dbg !1513
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %7, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %input_to_data.exit, !dbg !1508

input_to_data.exit:                               ; preds = %land.rhs.i.i.input_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1513
    #dbg_value(ptr %spec.select38.i.i, !472, !DIExpression(), !1492)
  %call2.i = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i.i, ptr noundef nonnull %call, i32 noundef signext 2048) #18, !dbg !1514
  tail call void @free(ptr noundef %call.i) #18, !dbg !1515
    #dbg_value(ptr %call, !459, !DIExpression(), !1516)
    #dbg_value(ptr %call, !460, !DIExpression(), !1516)
  tail call void @sort(ptr noundef nonnull %call) #18, !dbg !1518
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #18, !dbg !1519
    #dbg_value(i32 %call21, !1467, !DIExpression(), !1470)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1520
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1520

if.else26:                                        ; preds = %input_to_data.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1520
  unreachable, !dbg !1520

if.end27:                                         ; preds = %input_to_data.exit
    #dbg_value(i32 %call21, !578, !DIExpression(), !1523)
    #dbg_value(ptr %call, !579, !DIExpression(), !1523)
    #dbg_value(ptr %call, !580, !DIExpression(), !1523)
    #dbg_value(i32 %call21, !516, !DIExpression(), !1525)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1527
  br i1 %cmp.i.i.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1527

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1527
  unreachable, !dbg !1527

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1528
    #dbg_value(i32 %call21, !527, !DIExpression(), !1529)
    #dbg_value(ptr %call, !532, !DIExpression(), !1529)
    #dbg_value(i32 2048, !533, !DIExpression(), !1529)
    #dbg_value(i32 0, !534, !DIExpression(), !1529)
  store i64 0, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1531

for.body.i.i:                                     ; preds = %for.body.i.i.for.body.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !534, !DIExpression(), !1529)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %arrayidx.i.i = getelementptr inbounds i32, ptr %call, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !1532
  %8 = load i32, ptr %arrayidx.i.i, align 4, !dbg !1532, !tbaa !386
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.19, i32 noundef signext %8), !dbg !1532
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !1533
    #dbg_value(i64 %indvars.iv.next.i.i, !534, !DIExpression(), !1529)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 2048, !dbg !1533
  br i1 %exitcond.not.i.i, label %data_to_output.exit, label %for.body.i.i.for.body.i.i_crit_edge, !dbg !1531, !llvm.loop !1534

for.body.i.i.for.body.i.i_crit_edge:              ; preds = %for.body.i.i
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1531

data_to_output.exit:                              ; preds = %for.body.i.i
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #18, !dbg !1535
  %9 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1536, !tbaa !386
  %conv29 = sext i32 %9 to i64, !dbg !1536
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #20, !dbg !1537
    #dbg_value(ptr %call30, !1469, !DIExpression(), !1470)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1538
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1538

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.16, ptr noundef nonnull @.str.2.12, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1538
  unreachable, !dbg !1538

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem117.0.check_file.0.reload118, i32 noundef signext 0) #18, !dbg !1541
    #dbg_value(i32 %call37, !1468, !DIExpression(), !1470)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1542
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1542

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.17, ptr noundef nonnull @.str.2.12, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1542
  unreachable, !dbg !1542

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !547, !DIExpression(), !1545)
    #dbg_value(ptr %call30, !548, !DIExpression(), !1545)
    #dbg_value(ptr %call30, !549, !DIExpression(), !1545)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(8192) %call30, i8 0, i64 8192, i1 false), !dbg !1547
  %call.i1 = tail call ptr @readfile(i32 noundef signext %call37) #18, !dbg !1548
    #dbg_value(ptr %call.i1, !550, !DIExpression(), !1545)
    #dbg_value(ptr %call.i1, !476, !DIExpression(), !1549)
    #dbg_value(i32 1, !481, !DIExpression(), !1549)
    #dbg_value(i32 0, !482, !DIExpression(), !1549)
  store ptr %call.i1, ptr %s.addr.040.i.i4.reg2mem107, align 8
  store i32 0, ptr %i.041.i.i3.reg2mem109, align 4
  br label %land.rhs.i.i2

land.rhs.i.i2:                                    ; preds = %if.end21.i.i8.land.rhs.i.i2_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i3.reg2mem109.0.load, !482, !DIExpression(), !1549)
    #dbg_value(ptr %s.addr.040.i.i4.reg2mem107.0.s.addr.040.i.i4.reload108, !476, !DIExpression(), !1549)
  %i.041.i.i3.reg2mem109.0.load = load i32, ptr %i.041.i.i3.reg2mem109, align 4
  %s.addr.040.i.i4.reg2mem107.0.s.addr.040.i.i4.reload108 = load ptr, ptr %s.addr.040.i.i4.reg2mem107, align 8
  %10 = load i8, ptr %s.addr.040.i.i4.reg2mem107.0.s.addr.040.i.i4.reload108, align 1, !dbg !1551, !tbaa !486
  switch i8 %10, label %land.rhs.i.i2.if.end21.i.i8_crit_edge [
    i8 0, label %land.rhs.i.i2.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i5
  ], !dbg !1552

land.rhs.i.i2.output_to_data.exit_crit_edge:      ; preds = %land.rhs.i.i2
  store ptr %s.addr.040.i.i4.reg2mem107.0.s.addr.040.i.i4.reload108, ptr %s.addr.0.lcssa.ph.i.i15.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i14.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1552

land.rhs.i.i2.if.end21.i.i8_crit_edge:            ; preds = %land.rhs.i.i2
  store i32 %i.041.i.i3.reg2mem109.0.load, ptr %i.1.i.i9.reg2mem105, align 4
  br label %if.end21.i.i8, !dbg !1552

land.lhs.true10.i.i5:                             ; preds = %land.rhs.i.i2
  %arrayidx11.i.i6 = getelementptr inbounds i8, ptr %s.addr.040.i.i4.reg2mem107.0.s.addr.040.i.i4.reload108, i64 1, !dbg !1553
  %11 = load i8, ptr %arrayidx11.i.i6, align 1, !dbg !1553, !tbaa !486
  %cmp13.i.i7 = icmp eq i8 %11, 37, !dbg !1554
  br i1 %cmp13.i.i7, label %land.lhs.true15.i.i18, label %land.lhs.true10.i.i5.if.end21.i.i8_crit_edge, !dbg !1555

land.lhs.true10.i.i5.if.end21.i.i8_crit_edge:     ; preds = %land.lhs.true10.i.i5
  store i32 %i.041.i.i3.reg2mem109.0.load, ptr %i.1.i.i9.reg2mem105, align 4
  br label %if.end21.i.i8, !dbg !1555

land.lhs.true15.i.i18:                            ; preds = %land.lhs.true10.i.i5
  %arrayidx16.i.i19 = getelementptr inbounds i8, ptr %s.addr.040.i.i4.reg2mem107.0.s.addr.040.i.i4.reload108, i64 2, !dbg !1556
  %12 = load i8, ptr %arrayidx16.i.i19, align 1, !dbg !1556, !tbaa !486
  %cmp18.i.i20 = icmp eq i8 %12, 10, !dbg !1557
  %inc.i.i21 = zext i1 %cmp18.i.i20 to i32, !dbg !1558
  %spec.select.i.i22 = add nsw i32 %i.041.i.i3.reg2mem109.0.load, %inc.i.i21, !dbg !1558
  store i32 %spec.select.i.i22, ptr %i.1.i.i9.reg2mem105, align 4
  br label %if.end21.i.i8, !dbg !1558

if.end21.i.i8:                                    ; preds = %land.lhs.true10.i.i5.if.end21.i.i8_crit_edge, %land.rhs.i.i2.if.end21.i.i8_crit_edge, %land.lhs.true15.i.i18
    #dbg_value(i32 %i.1.i.i9.reg2mem105.0.load, !482, !DIExpression(), !1549)
  %i.1.i.i9.reg2mem105.0.load = load i32, ptr %i.1.i.i9.reg2mem105, align 4
  %incdec.ptr.i.i10 = getelementptr inbounds i8, ptr %s.addr.040.i.i4.reg2mem107.0.s.addr.040.i.i4.reload108, i64 1, !dbg !1559
    #dbg_value(ptr %incdec.ptr.i.i10, !476, !DIExpression(), !1549)
  %cmp4.i.i11 = icmp slt i32 %i.1.i.i9.reg2mem105.0.load, 1, !dbg !1560
  br i1 %cmp4.i.i11, label %if.end21.i.i8.land.rhs.i.i2_crit_edge, label %if.end21.while.end_crit_edge.i.i12, !dbg !1561, !llvm.loop !1562

if.end21.i.i8.land.rhs.i.i2_crit_edge:            ; preds = %if.end21.i.i8
  store ptr %incdec.ptr.i.i10, ptr %s.addr.040.i.i4.reg2mem107, align 8
  store i32 %i.1.i.i9.reg2mem105.0.load, ptr %i.041.i.i3.reg2mem109, align 4
  br label %land.rhs.i.i2, !dbg !1561

if.end21.while.end_crit_edge.i.i12:               ; preds = %if.end21.i.i8
  %.pre.i.i13 = load i8, ptr %incdec.ptr.i.i10, align 1, !dbg !1564, !tbaa !486
  %13 = icmp eq i8 %.pre.i.i13, 0, !dbg !1565
  %14 = select i1 %13, i64 0, i64 2, !dbg !1566
  store ptr %incdec.ptr.i.i10, ptr %s.addr.0.lcssa.ph.i.i15.reg2mem, align 8
  store i64 %14, ptr %cmp23.not.i.i14.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1561

output_to_data.exit:                              ; preds = %land.rhs.i.i2.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i12
  %cmp23.not.i.i14.reg2mem.0.load = load i64, ptr %cmp23.not.i.i14.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i15.reg2mem.0.s.addr.0.lcssa.ph.i.i15.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i15.reg2mem, align 8
  %spec.select38.i.i16 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i15.reg2mem.0.s.addr.0.lcssa.ph.i.i15.reload, i64 %cmp23.not.i.i14.reg2mem.0.load, !dbg !1566
    #dbg_value(ptr %spec.select38.i.i16, !551, !DIExpression(), !1545)
  %call2.i17 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i.i16, ptr noundef nonnull %call30, i32 noundef signext 2048) #18, !dbg !1567
  tail call void @free(ptr noundef %call.i1) #18, !dbg !1568
    #dbg_value(ptr %call, !597, !DIExpression(), !1569)
    #dbg_value(ptr %call30, !598, !DIExpression(), !1569)
    #dbg_value(ptr %call, !599, !DIExpression(), !1569)
    #dbg_value(ptr %call30, !600, !DIExpression(), !1569)
    #dbg_value(i32 0, !601, !DIExpression(), !1569)
  %15 = load i32, ptr %call, align 4, !dbg !1572
    #dbg_value(i32 %15, !603, !DIExpression(), !1569)
  %16 = load i32, ptr %call30, align 4, !dbg !1573
    #dbg_value(i32 %16, !604, !DIExpression(), !1569)
    #dbg_value(i32 1, !602, !DIExpression(), !1569)
  store i32 0, ptr %has_errors.032.i.reg2mem, align 4
  store i32 %15, ptr %data_sum.034.i.reg2mem, align 4
  store i32 %16, ptr %ref_sum.035.i.reg2mem, align 4
  store i64 1, ptr %indvars.iv.i.reg2mem, align 8
  store i32 %15, ptr %.reg2mem103, align 4
  br label %for.body.i, !dbg !1574

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %output_to_data.exit
    #dbg_value(i32 %ref_sum.035.i.reg2mem.0.load, !604, !DIExpression(), !1569)
    #dbg_value(i32 %data_sum.034.i.reg2mem.0.load, !603, !DIExpression(), !1569)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !602, !DIExpression(), !1569)
    #dbg_value(i32 %has_errors.032.i.reg2mem.0.load, !601, !DIExpression(), !1569)
  %.reg2mem103.0.load = load i32, ptr %.reg2mem103, align 4
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %ref_sum.035.i.reg2mem.0.load = load i32, ptr %ref_sum.035.i.reg2mem, align 4
  %data_sum.034.i.reg2mem.0.load = load i32, ptr %data_sum.034.i.reg2mem, align 4
  %has_errors.032.i.reg2mem.0.load = load i32, ptr %has_errors.032.i.reg2mem, align 4
  %arrayidx7.i = getelementptr inbounds [2048 x i32], ptr %call, i64 0, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1575
  %17 = load i32, ptr %arrayidx7.i, align 4, !dbg !1575
  %cmp8.i = icmp sgt i32 %.reg2mem103.0.load, %17, !dbg !1576
  %conv.i = zext i1 %cmp8.i to i32, !dbg !1576
  %or.i = or i32 %has_errors.032.i.reg2mem.0.load, %conv.i, !dbg !1577
    #dbg_value(i32 %or.i, !601, !DIExpression(), !1569)
  %add.i = add nsw i32 %17, %data_sum.034.i.reg2mem.0.load, !dbg !1578
    #dbg_value(i32 %add.i, !603, !DIExpression(), !1569)
  %arrayidx14.i = getelementptr inbounds [2048 x i32], ptr %call30, i64 0, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1579
  %18 = load i32, ptr %arrayidx14.i, align 4, !dbg !1579, !tbaa !386
  %add15.i = add nsw i32 %18, %ref_sum.035.i.reg2mem.0.load, !dbg !1580
    #dbg_value(i32 %add15.i, !604, !DIExpression(), !1569)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1581
    #dbg_value(i64 %indvars.iv.next.i, !602, !DIExpression(), !1569)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 2048, !dbg !1582
  br i1 %exitcond.not.i, label %check_data.exit, label %for.body.i.for.body.i_crit_edge, !dbg !1574, !llvm.loop !1583

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i32 %or.i, ptr %has_errors.032.i.reg2mem, align 4
  store i32 %add.i, ptr %data_sum.034.i.reg2mem, align 4
  store i32 %add15.i, ptr %ref_sum.035.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  store i32 %17, ptr %.reg2mem103, align 4
  br label %for.body.i, !dbg !1574

check_data.exit:                                  ; preds = %for.body.i
  %cmp16.i = icmp ne i32 %add.i, %add15.i, !dbg !1585
  %conv17.i = zext i1 %cmp16.i to i32, !dbg !1585
  %or18.i = or i32 %or.i, %conv17.i, !dbg !1586
    #dbg_value(i32 %or18.i, !601, !DIExpression(), !1569)
  %tobool.not.i.not = icmp eq i32 %or18.i, 0, !dbg !1587
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1588

if.then45:                                        ; preds = %check_data.exit
  %19 = load ptr, ptr @stderr, align 8, !dbg !1589, !tbaa !810
  %20 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %19) #21, !dbg !1591
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1592

if.end47:                                         ; preds = %check_data.exit
  tail call void @free(ptr noundef nonnull %call) #18, !dbg !1593
  tail call void @free(ptr noundef nonnull %call30) #18, !dbg !1594
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1595
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1596

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1597
}

; Function Attrs: nofree
declare !dbg !1598 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #10

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #16

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #16

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #17

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #5 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #6 = { nofree norecurse nosync nounwind memory(argmem: read) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #7 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #8 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #9 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #10 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #11 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
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

!llvm.dbg.cu = !{!226, !188, !228, !290}
!llvm.ident = !{!311, !311, !311, !311}
!llvm.module.flags = !{!312, !313, !314, !315, !316, !318, !319, !320, !321, !322}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/sort/merge")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/sort/merge")
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
!187 = distinct !DIGlobalVariable(name: "INPUT_SIZE", scope: !188, file: !189, line: 4, type: !201, isLocal: false, isDefinition: true)
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !204, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/sort/merge")
!190 = !{!191}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 15, size: 65536, elements: !194)
!193 = !DIFile(filename: "./sort.h", directory: "/home/kelvin/MachSuite/sort/merge")
!194 = !{!195}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !192, file: !193, line: 16, baseType: !196, size: 65536)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 65536, elements: !202)
!197 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !198, line: 26, baseType: !199)
!198 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!199 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !200, line: 41, baseType: !201)
!200 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!201 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!202 = !{!203}
!203 = !DISubrange(count: 2048)
!204 = !{!186}
!205 = !DIGlobalVariableExpression(var: !206, expr: !DIExpression())
!206 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !207, isLocal: true, isDefinition: true)
!207 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!208 = !DIGlobalVariableExpression(var: !209, expr: !DIExpression())
!209 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !210, isLocal: true, isDefinition: true)
!210 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!211 = !DIGlobalVariableExpression(var: !212, expr: !DIExpression())
!212 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !213, isLocal: true, isDefinition: true)
!213 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !214)
!214 = !{!215}
!215 = !DISubrange(count: 12)
!216 = !DIGlobalVariableExpression(var: !217, expr: !DIExpression())
!217 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !218, isLocal: true, isDefinition: true)
!218 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!219 = !DIGlobalVariableExpression(var: !220, expr: !DIExpression())
!220 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!221 = !DIGlobalVariableExpression(var: !222, expr: !DIExpression())
!222 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !223, isLocal: true, isDefinition: true)
!223 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!224 = !DIGlobalVariableExpression(var: !225, expr: !DIExpression())
!225 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!226 = distinct !DICompileUnit(language: DW_LANG_C11, file: !227, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!227 = !DIFile(filename: "sort.c", directory: "/home/kelvin/MachSuite/sort/merge")
!228 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !229, globals: !256, splitDebugInlining: false, nameTableKind: None)
!229 = !{!230, !4, !231, !232, !236, !239, !242, !245, !248, !197, !251, !254, !255}
!230 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!231 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!232 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !233, line: 24, baseType: !234)
!233 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!234 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !200, line: 38, baseType: !235)
!235 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!236 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !233, line: 25, baseType: !237)
!237 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !200, line: 40, baseType: !238)
!238 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!239 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !233, line: 26, baseType: !240)
!240 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !200, line: 42, baseType: !241)
!241 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!242 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !233, line: 27, baseType: !243)
!243 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !200, line: 45, baseType: !244)
!244 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!245 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !198, line: 24, baseType: !246)
!246 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !200, line: 37, baseType: !247)
!247 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!248 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !198, line: 25, baseType: !249)
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !200, line: 39, baseType: !250)
!250 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!251 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !198, line: 27, baseType: !252)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !200, line: 44, baseType: !253)
!253 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!254 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!255 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!256 = !{!257, !0, !7, !12, !262, !18, !264, !23, !269, !28, !271, !33, !38, !273, !43, !45, !47, !52, !57, !62, !67, !69, !71, !76, !78, !80, !82, !87, !89, !278, !92, !97, !102, !107, !112, !114, !116, !121, !126, !128, !130, !132, !134, !136, !141, !146, !148, !153, !283, !158, !163, !285, !165}
!257 = !DIGlobalVariableExpression(var: !258, expr: !DIExpression())
!258 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !259, isLocal: true, isDefinition: true)
!259 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !260)
!260 = !{!261}
!261 = !DISubrange(count: 24)
!262 = !DIGlobalVariableExpression(var: !263, expr: !DIExpression())
!263 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !30, isLocal: true, isDefinition: true)
!264 = !DIGlobalVariableExpression(var: !265, expr: !DIExpression())
!265 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !266, isLocal: true, isDefinition: true)
!266 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !267)
!267 = !{!268}
!268 = !DISubrange(count: 14)
!269 = !DIGlobalVariableExpression(var: !270, expr: !DIExpression())
!270 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !266, isLocal: true, isDefinition: true)
!271 = !DIGlobalVariableExpression(var: !272, expr: !DIExpression())
!272 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !9, isLocal: true, isDefinition: true)
!273 = !DIGlobalVariableExpression(var: !274, expr: !DIExpression())
!274 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !275, isLocal: true, isDefinition: true)
!275 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !276)
!276 = !{!277}
!277 = !DISubrange(count: 21)
!278 = !DIGlobalVariableExpression(var: !279, expr: !DIExpression())
!279 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !280, isLocal: true, isDefinition: true)
!280 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !281)
!281 = !{!282}
!282 = !DISubrange(count: 13)
!283 = !DIGlobalVariableExpression(var: !284, expr: !DIExpression())
!284 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !20, isLocal: true, isDefinition: true)
!285 = !DIGlobalVariableExpression(var: !286, expr: !DIExpression())
!286 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !287, isLocal: true, isDefinition: true)
!287 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !288)
!288 = !{!289}
!289 = !DISubrange(count: 27)
!290 = distinct !DICompileUnit(language: DW_LANG_C11, file: !170, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !291, globals: !292, splitDebugInlining: false, nameTableKind: None)
!291 = !{!231}
!292 = !{!293, !168, !174, !176, !179, !184, !295, !205, !297, !208, !211, !299, !216, !219, !304, !221, !224, !306}
!293 = !DIGlobalVariableExpression(var: !294, expr: !DIExpression())
!294 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !218, isLocal: true, isDefinition: true)
!295 = !DIGlobalVariableExpression(var: !296, expr: !DIExpression())
!296 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !266, isLocal: true, isDefinition: true)
!297 = !DIGlobalVariableExpression(var: !298, expr: !DIExpression())
!298 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !207, isLocal: true, isDefinition: true)
!299 = !DIGlobalVariableExpression(var: !300, expr: !DIExpression())
!300 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !301, isLocal: true, isDefinition: true)
!301 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !302)
!302 = !{!303}
!303 = !DISubrange(count: 31)
!304 = !DIGlobalVariableExpression(var: !305, expr: !DIExpression())
!305 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !207, isLocal: true, isDefinition: true)
!306 = !DIGlobalVariableExpression(var: !307, expr: !DIExpression())
!307 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !308, isLocal: true, isDefinition: true)
!308 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !309)
!309 = !{!310}
!310 = !DISubrange(count: 10)
!311 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!312 = !{i32 7, !"Dwarf Version", i32 4}
!313 = !{i32 2, !"Debug Info Version", i32 3}
!314 = !{i32 1, !"wchar_size", i32 4}
!315 = !{i32 1, !"target-abi", !"lp64d"}
!316 = distinct !{i32 6, !"riscv-isa", !317}
!317 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!318 = !{i32 8, !"PIC Level", i32 2}
!319 = !{i32 7, !"PIE Level", i32 2}
!320 = !{i32 7, !"uwtable", i32 2}
!321 = !{i32 8, !"SmallDataLimit", i32 8}
!322 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!323 = distinct !DISubprogram(name: "sort", scope: !227, file: !227, line: 31, type: !324, scopeLine: 31, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !327)
!324 = !DISubroutineType(types: !325)
!325 = !{null, !326}
!326 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!327 = !{!328, !329, !330, !331, !332, !333, !334, !335, !336, !337}
!328 = !DILocalVariable(name: "a", arg: 1, scope: !323, file: !227, line: 31, type: !326)
!329 = !DILocalVariable(name: "start", scope: !323, file: !227, line: 32, type: !201)
!330 = !DILocalVariable(name: "stop", scope: !323, file: !227, line: 32, type: !201)
!331 = !DILocalVariable(name: "i", scope: !323, file: !227, line: 33, type: !201)
!332 = !DILocalVariable(name: "m", scope: !323, file: !227, line: 33, type: !201)
!333 = !DILocalVariable(name: "from", scope: !323, file: !227, line: 33, type: !201)
!334 = !DILocalVariable(name: "mid", scope: !323, file: !227, line: 33, type: !201)
!335 = !DILocalVariable(name: "to", scope: !323, file: !227, line: 33, type: !201)
!336 = !DILabel(scope: !323, name: "mergesort_label1", file: !227, line: 38)
!337 = !DILabel(scope: !338, name: "mergesort_label2", file: !227, line: 39)
!338 = distinct !DILexicalBlock(scope: !339, file: !227, line: 38, column: 53)
!339 = distinct !DILexicalBlock(scope: !340, file: !227, line: 38, column: 24)
!340 = distinct !DILexicalBlock(scope: !323, file: !227, line: 38, column: 24)
!341 = distinct !DIAssignID()
!342 = distinct !DIAssignID()
!343 = !DILocation(line: 0, scope: !323)
!344 = !DILocation(line: 38, column: 5, scope: !323)
!345 = !DILocation(line: 38, column: 24, scope: !340)
!346 = !DILocation(line: 39, column: 28, scope: !347)
!347 = distinct !DILexicalBlock(scope: !338, file: !227, line: 39, column: 28)
!348 = !DILocation(line: 41, column: 20, scope: !349)
!349 = distinct !DILexicalBlock(scope: !350, file: !227, line: 39, column: 57)
!350 = distinct !DILexicalBlock(scope: !347, file: !227, line: 39, column: 28)
!351 = !DILocation(line: 39, column: 50, scope: !350)
!352 = !DILocation(line: 43, column: 19, scope: !353)
!353 = distinct !DILexicalBlock(scope: !349, file: !227, line: 43, column: 16)
!354 = !DILocation(line: 43, column: 16, scope: !349)
!355 = !DILocation(line: 42, column: 23, scope: !349)
!356 = !DILocalVariable(name: "temp", scope: !357, file: !227, line: 4, type: !196)
!357 = distinct !DISubprogram(name: "merge", scope: !227, file: !227, line: 3, type: !358, scopeLine: 3, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !226, retainedNodes: !360)
!358 = !DISubroutineType(types: !359)
!359 = !{null, !326, !201, !201, !201}
!360 = !{!361, !362, !363, !364, !356, !365, !366, !367, !368, !369, !370, !371, !375}
!361 = !DILocalVariable(name: "a", arg: 1, scope: !357, file: !227, line: 3, type: !326)
!362 = !DILocalVariable(name: "start", arg: 2, scope: !357, file: !227, line: 3, type: !201)
!363 = !DILocalVariable(name: "m", arg: 3, scope: !357, file: !227, line: 3, type: !201)
!364 = !DILocalVariable(name: "stop", arg: 4, scope: !357, file: !227, line: 3, type: !201)
!365 = !DILocalVariable(name: "i", scope: !357, file: !227, line: 5, type: !201)
!366 = !DILocalVariable(name: "j", scope: !357, file: !227, line: 5, type: !201)
!367 = !DILocalVariable(name: "k", scope: !357, file: !227, line: 5, type: !201)
!368 = !DILabel(scope: !357, name: "merge_label1", file: !227, line: 7)
!369 = !DILabel(scope: !357, name: "merge_label2", file: !227, line: 11)
!370 = !DILabel(scope: !357, name: "merge_label3", file: !227, line: 18)
!371 = !DILocalVariable(name: "tmp_j", scope: !372, file: !227, line: 19, type: !197)
!372 = distinct !DILexicalBlock(scope: !373, file: !227, line: 18, column: 46)
!373 = distinct !DILexicalBlock(scope: !374, file: !227, line: 18, column: 20)
!374 = distinct !DILexicalBlock(scope: !357, file: !227, line: 18, column: 20)
!375 = !DILocalVariable(name: "tmp_i", scope: !372, file: !227, line: 20, type: !197)
!376 = !DILocation(line: 0, scope: !357, inlinedAt: !377)
!377 = distinct !DILocation(line: 44, column: 17, scope: !378)
!378 = distinct !DILexicalBlock(scope: !353, file: !227, line: 43, column: 26)
!379 = !DILocation(line: 4, column: 5, scope: !357, inlinedAt: !377)
!380 = !DILocation(line: 7, column: 5, scope: !357, inlinedAt: !377)
!381 = !DILocation(line: 7, column: 20, scope: !382, inlinedAt: !377)
!382 = distinct !DILexicalBlock(scope: !357, file: !227, line: 7, column: 20)
!383 = !DILocation(line: 8, column: 17, scope: !384, inlinedAt: !377)
!384 = distinct !DILexicalBlock(scope: !385, file: !227, line: 7, column: 43)
!385 = distinct !DILexicalBlock(scope: !382, file: !227, line: 7, column: 20)
!386 = !{!387, !387, i64 0}
!387 = !{!"int", !388, i64 0}
!388 = !{!"omnipotent char", !389, i64 0}
!389 = !{!"Simple C/C++ TBAA"}
!390 = !DILocation(line: 11, column: 5, scope: !357, inlinedAt: !377)
!391 = !DILocation(line: 11, column: 20, scope: !392, inlinedAt: !377)
!392 = distinct !DILexicalBlock(scope: !357, file: !227, line: 11, column: 20)
!393 = !DILocation(line: 18, column: 20, scope: !374, inlinedAt: !377)
!394 = !DILocation(line: 12, column: 28, scope: !395, inlinedAt: !377)
!395 = distinct !DILexicalBlock(scope: !396, file: !227, line: 11, column: 44)
!396 = distinct !DILexicalBlock(scope: !392, file: !227, line: 11, column: 20)
!397 = !DILocation(line: 12, column: 22, scope: !395, inlinedAt: !377)
!398 = !DILocation(line: 12, column: 9, scope: !395, inlinedAt: !377)
!399 = !DILocation(line: 12, column: 26, scope: !395, inlinedAt: !377)
!400 = !DILocation(line: 11, column: 41, scope: !396, inlinedAt: !377)
!401 = !DILocation(line: 11, column: 32, scope: !396, inlinedAt: !377)
!402 = distinct !{!402, !391, !403, !404, !405}
!403 = !DILocation(line: 13, column: 5, scope: !392, inlinedAt: !377)
!404 = !{!"llvm.loop.mustprogress"}
!405 = !{!"llvm.loop.unroll.disable"}
!406 = !DILocation(line: 19, column: 22, scope: !372, inlinedAt: !377)
!407 = !DILocation(line: 0, scope: !372, inlinedAt: !377)
!408 = !DILocation(line: 20, column: 22, scope: !372, inlinedAt: !377)
!409 = !DILocation(line: 21, column: 18, scope: !410, inlinedAt: !377)
!410 = distinct !DILexicalBlock(scope: !372, file: !227, line: 21, column: 12)
!411 = !DILocation(line: 0, scope: !410, inlinedAt: !377)
!412 = !DILocation(line: 21, column: 12, scope: !372, inlinedAt: !377)
!413 = !DILocation(line: 18, column: 43, scope: !373, inlinedAt: !377)
!414 = !DILocation(line: 18, column: 34, scope: !373, inlinedAt: !377)
!415 = distinct !{!415, !393, !416, !404, !405}
!416 = !DILocation(line: 28, column: 5, scope: !374, inlinedAt: !377)
!417 = !DILocation(line: 29, column: 1, scope: !357, inlinedAt: !377)
!418 = !DILocation(line: 45, column: 13, scope: !378)
!419 = !DILocation(line: 0, scope: !357, inlinedAt: !420)
!420 = distinct !DILocation(line: 47, column: 17, scope: !421)
!421 = distinct !DILexicalBlock(scope: !353, file: !227, line: 46, column: 17)
!422 = !DILocation(line: 4, column: 5, scope: !357, inlinedAt: !420)
!423 = !DILocation(line: 7, column: 5, scope: !357, inlinedAt: !420)
!424 = !DILocation(line: 7, column: 20, scope: !382, inlinedAt: !420)
!425 = !DILocation(line: 8, column: 17, scope: !384, inlinedAt: !420)
!426 = !DILocation(line: 11, column: 5, scope: !357, inlinedAt: !420)
!427 = !DILocation(line: 11, column: 32, scope: !396, inlinedAt: !420)
!428 = !DILocation(line: 11, column: 20, scope: !392, inlinedAt: !420)
!429 = !DILocation(line: 18, column: 20, scope: !374, inlinedAt: !420)
!430 = !DILocation(line: 12, column: 28, scope: !395, inlinedAt: !420)
!431 = !DILocation(line: 12, column: 22, scope: !395, inlinedAt: !420)
!432 = !DILocation(line: 12, column: 9, scope: !395, inlinedAt: !420)
!433 = !DILocation(line: 12, column: 26, scope: !395, inlinedAt: !420)
!434 = !DILocation(line: 11, column: 41, scope: !396, inlinedAt: !420)
!435 = distinct !{!435, !428, !436, !404, !405}
!436 = !DILocation(line: 13, column: 5, scope: !392, inlinedAt: !420)
!437 = !DILocation(line: 19, column: 22, scope: !372, inlinedAt: !420)
!438 = !DILocation(line: 0, scope: !372, inlinedAt: !420)
!439 = !DILocation(line: 20, column: 22, scope: !372, inlinedAt: !420)
!440 = !DILocation(line: 21, column: 18, scope: !410, inlinedAt: !420)
!441 = !DILocation(line: 0, scope: !410, inlinedAt: !420)
!442 = !DILocation(line: 21, column: 12, scope: !372, inlinedAt: !420)
!443 = !DILocation(line: 18, column: 43, scope: !373, inlinedAt: !420)
!444 = !DILocation(line: 18, column: 34, scope: !373, inlinedAt: !420)
!445 = distinct !{!445, !429, !446, !404, !405}
!446 = !DILocation(line: 28, column: 5, scope: !374, inlinedAt: !420)
!447 = !DILocation(line: 29, column: 1, scope: !357, inlinedAt: !420)
!448 = !DILocation(line: 39, column: 42, scope: !350)
!449 = distinct !{!449, !346, !450, !404, !405}
!450 = !DILocation(line: 49, column: 9, scope: !347)
!451 = !DILocation(line: 38, column: 34, scope: !339)
!452 = distinct !{!452, !345, !453, !404, !405}
!453 = !DILocation(line: 50, column: 5, scope: !340)
!454 = !DILocation(line: 51, column: 1, scope: !323)
!455 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 6, type: !456, scopeLine: 6, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !458)
!456 = !DISubroutineType(types: !457)
!457 = !{null, !231}
!458 = !{!459, !460}
!459 = !DILocalVariable(name: "vargs", arg: 1, scope: !455, file: !189, line: 6, type: !231)
!460 = !DILocalVariable(name: "args", scope: !455, file: !189, line: 7, type: !191)
!461 = !DILocation(line: 0, scope: !455)
!462 = !DILocation(line: 8, column: 3, scope: !455)
!463 = !DILocation(line: 9, column: 1, scope: !455)
!464 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 16, type: !465, scopeLine: 16, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !467)
!465 = !DISubroutineType(types: !466)
!466 = !{null, !201, !231}
!467 = !{!468, !469, !470, !471, !472}
!468 = !DILocalVariable(name: "fd", arg: 1, scope: !464, file: !189, line: 16, type: !201)
!469 = !DILocalVariable(name: "vdata", arg: 2, scope: !464, file: !189, line: 16, type: !231)
!470 = !DILocalVariable(name: "data", scope: !464, file: !189, line: 17, type: !191)
!471 = !DILocalVariable(name: "p", scope: !464, file: !189, line: 18, type: !230)
!472 = !DILocalVariable(name: "s", scope: !464, file: !189, line: 18, type: !230)
!473 = !DILocation(line: 0, scope: !464)
!474 = !DILocation(line: 20, column: 3, scope: !464)
!475 = !DILocation(line: 22, column: 7, scope: !464)
!476 = !DILocalVariable(name: "s", arg: 1, scope: !477, file: !2, line: 56, type: !230)
!477 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !478, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !480)
!478 = !DISubroutineType(types: !479)
!479 = !{!230, !230, !201}
!480 = !{!476, !481, !482}
!481 = !DILocalVariable(name: "n", arg: 2, scope: !477, file: !2, line: 56, type: !201)
!482 = !DILocalVariable(name: "i", scope: !477, file: !2, line: 57, type: !201)
!483 = !DILocation(line: 0, scope: !477, inlinedAt: !484)
!484 = distinct !DILocation(line: 24, column: 7, scope: !464)
!485 = !DILocation(line: 64, column: 17, scope: !477, inlinedAt: !484)
!486 = !{!388, !388, i64 0}
!487 = !DILocation(line: 64, column: 3, scope: !477, inlinedAt: !484)
!488 = !DILocation(line: 66, column: 22, scope: !489, inlinedAt: !484)
!489 = distinct !DILexicalBlock(scope: !490, file: !2, line: 66, column: 9)
!490 = distinct !DILexicalBlock(scope: !477, file: !2, line: 64, column: 31)
!491 = !DILocation(line: 66, column: 26, scope: !489, inlinedAt: !484)
!492 = !DILocation(line: 66, column: 32, scope: !489, inlinedAt: !484)
!493 = !DILocation(line: 66, column: 35, scope: !489, inlinedAt: !484)
!494 = !DILocation(line: 66, column: 39, scope: !489, inlinedAt: !484)
!495 = !DILocation(line: 66, column: 9, scope: !490, inlinedAt: !484)
!496 = !DILocation(line: 69, column: 6, scope: !490, inlinedAt: !484)
!497 = !DILocation(line: 64, column: 10, scope: !477, inlinedAt: !484)
!498 = !DILocation(line: 64, column: 13, scope: !477, inlinedAt: !484)
!499 = distinct !{!499, !487, !500, !404, !405}
!500 = !DILocation(line: 70, column: 3, scope: !477, inlinedAt: !484)
!501 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !484)
!502 = distinct !DILexicalBlock(scope: !477, file: !2, line: 71, column: 6)
!503 = !DILocation(line: 71, column: 8, scope: !502, inlinedAt: !484)
!504 = !DILocation(line: 71, column: 6, scope: !477, inlinedAt: !484)
!505 = !DILocation(line: 25, column: 3, scope: !464)
!506 = !DILocation(line: 26, column: 3, scope: !464)
!507 = !DILocation(line: 27, column: 1, scope: !464)
!508 = !DISubprogram(name: "free", scope: !509, file: !509, line: 687, type: !456, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!509 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!510 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 29, type: !465, scopeLine: 29, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !511)
!511 = !{!512, !513, !514}
!512 = !DILocalVariable(name: "fd", arg: 1, scope: !510, file: !189, line: 29, type: !201)
!513 = !DILocalVariable(name: "vdata", arg: 2, scope: !510, file: !189, line: 29, type: !231)
!514 = !DILocalVariable(name: "data", scope: !510, file: !189, line: 30, type: !191)
!515 = !DILocation(line: 0, scope: !510)
!516 = !DILocalVariable(name: "fd", arg: 1, scope: !517, file: !2, line: 189, type: !201)
!517 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !518, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !520)
!518 = !DISubroutineType(types: !519)
!519 = !{!201, !201}
!520 = !{!516}
!521 = !DILocation(line: 0, scope: !517, inlinedAt: !522)
!522 = distinct !DILocation(line: 32, column: 3, scope: !510)
!523 = !DILocation(line: 190, column: 3, scope: !524, inlinedAt: !522)
!524 = distinct !DILexicalBlock(scope: !525, file: !2, line: 190, column: 3)
!525 = distinct !DILexicalBlock(scope: !517, file: !2, line: 190, column: 3)
!526 = !DILocation(line: 191, column: 3, scope: !517, inlinedAt: !522)
!527 = !DILocalVariable(name: "fd", arg: 1, scope: !528, file: !2, line: 183, type: !201)
!528 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !529, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !531)
!529 = !DISubroutineType(types: !530)
!530 = !{!201, !201, !326, !201}
!531 = !{!527, !532, !533, !534}
!532 = !DILocalVariable(name: "arr", arg: 2, scope: !528, file: !2, line: 183, type: !326)
!533 = !DILocalVariable(name: "n", arg: 3, scope: !528, file: !2, line: 183, type: !201)
!534 = !DILocalVariable(name: "i", scope: !528, file: !2, line: 183, type: !201)
!535 = !DILocation(line: 0, scope: !528, inlinedAt: !536)
!536 = distinct !DILocation(line: 33, column: 3, scope: !510)
!537 = !DILocation(line: 183, column: 1, scope: !538, inlinedAt: !536)
!538 = distinct !DILexicalBlock(scope: !528, file: !2, line: 183, column: 1)
!539 = !DILocation(line: 183, column: 1, scope: !540, inlinedAt: !536)
!540 = distinct !DILexicalBlock(scope: !541, file: !2, line: 183, column: 1)
!541 = distinct !DILexicalBlock(scope: !538, file: !2, line: 183, column: 1)
!542 = !DILocation(line: 183, column: 1, scope: !541, inlinedAt: !536)
!543 = distinct !{!543, !537, !537, !404, !405}
!544 = !DILocation(line: 34, column: 1, scope: !510)
!545 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 41, type: !465, scopeLine: 41, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !546)
!546 = !{!547, !548, !549, !550, !551}
!547 = !DILocalVariable(name: "fd", arg: 1, scope: !545, file: !189, line: 41, type: !201)
!548 = !DILocalVariable(name: "vdata", arg: 2, scope: !545, file: !189, line: 41, type: !231)
!549 = !DILocalVariable(name: "data", scope: !545, file: !189, line: 42, type: !191)
!550 = !DILocalVariable(name: "p", scope: !545, file: !189, line: 43, type: !230)
!551 = !DILocalVariable(name: "s", scope: !545, file: !189, line: 43, type: !230)
!552 = !DILocation(line: 0, scope: !545)
!553 = !DILocation(line: 45, column: 3, scope: !545)
!554 = !DILocation(line: 47, column: 7, scope: !545)
!555 = !DILocation(line: 0, scope: !477, inlinedAt: !556)
!556 = distinct !DILocation(line: 49, column: 7, scope: !545)
!557 = !DILocation(line: 64, column: 17, scope: !477, inlinedAt: !556)
!558 = !DILocation(line: 64, column: 3, scope: !477, inlinedAt: !556)
!559 = !DILocation(line: 66, column: 22, scope: !489, inlinedAt: !556)
!560 = !DILocation(line: 66, column: 26, scope: !489, inlinedAt: !556)
!561 = !DILocation(line: 66, column: 32, scope: !489, inlinedAt: !556)
!562 = !DILocation(line: 66, column: 35, scope: !489, inlinedAt: !556)
!563 = !DILocation(line: 66, column: 39, scope: !489, inlinedAt: !556)
!564 = !DILocation(line: 66, column: 9, scope: !490, inlinedAt: !556)
!565 = !DILocation(line: 69, column: 6, scope: !490, inlinedAt: !556)
!566 = !DILocation(line: 64, column: 10, scope: !477, inlinedAt: !556)
!567 = !DILocation(line: 64, column: 13, scope: !477, inlinedAt: !556)
!568 = distinct !{!568, !558, !569, !404, !405}
!569 = !DILocation(line: 70, column: 3, scope: !477, inlinedAt: !556)
!570 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !556)
!571 = !DILocation(line: 71, column: 8, scope: !502, inlinedAt: !556)
!572 = !DILocation(line: 71, column: 6, scope: !477, inlinedAt: !556)
!573 = !DILocation(line: 50, column: 3, scope: !545)
!574 = !DILocation(line: 51, column: 3, scope: !545)
!575 = !DILocation(line: 52, column: 1, scope: !545)
!576 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 54, type: !465, scopeLine: 54, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !577)
!577 = !{!578, !579, !580}
!578 = !DILocalVariable(name: "fd", arg: 1, scope: !576, file: !189, line: 54, type: !201)
!579 = !DILocalVariable(name: "vdata", arg: 2, scope: !576, file: !189, line: 54, type: !231)
!580 = !DILocalVariable(name: "data", scope: !576, file: !189, line: 55, type: !191)
!581 = !DILocation(line: 0, scope: !576)
!582 = !DILocation(line: 0, scope: !517, inlinedAt: !583)
!583 = distinct !DILocation(line: 57, column: 3, scope: !576)
!584 = !DILocation(line: 190, column: 3, scope: !524, inlinedAt: !583)
!585 = !DILocation(line: 191, column: 3, scope: !517, inlinedAt: !583)
!586 = !DILocation(line: 0, scope: !528, inlinedAt: !587)
!587 = distinct !DILocation(line: 58, column: 3, scope: !576)
!588 = !DILocation(line: 183, column: 1, scope: !538, inlinedAt: !587)
!589 = !DILocation(line: 183, column: 1, scope: !540, inlinedAt: !587)
!590 = !DILocation(line: 183, column: 1, scope: !541, inlinedAt: !587)
!591 = distinct !{!591, !588, !588, !404, !405}
!592 = !DILocation(line: 59, column: 1, scope: !576)
!593 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 61, type: !594, scopeLine: 61, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !596)
!594 = !DISubroutineType(types: !595)
!595 = !{!201, !231, !231}
!596 = !{!597, !598, !599, !600, !601, !602, !603, !604}
!597 = !DILocalVariable(name: "vdata", arg: 1, scope: !593, file: !189, line: 61, type: !231)
!598 = !DILocalVariable(name: "vref", arg: 2, scope: !593, file: !189, line: 61, type: !231)
!599 = !DILocalVariable(name: "data", scope: !593, file: !189, line: 62, type: !191)
!600 = !DILocalVariable(name: "ref", scope: !593, file: !189, line: 63, type: !191)
!601 = !DILocalVariable(name: "has_errors", scope: !593, file: !189, line: 64, type: !201)
!602 = !DILocalVariable(name: "i", scope: !593, file: !189, line: 65, type: !201)
!603 = !DILocalVariable(name: "data_sum", scope: !593, file: !189, line: 66, type: !197)
!604 = !DILocalVariable(name: "ref_sum", scope: !593, file: !189, line: 66, type: !197)
!605 = !DILocation(line: 0, scope: !593)
!606 = !DILocation(line: 69, column: 14, scope: !593)
!607 = !DILocation(line: 70, column: 13, scope: !593)
!608 = !DILocation(line: 71, column: 3, scope: !609)
!609 = distinct !DILexicalBlock(scope: !593, file: !189, line: 71, column: 3)
!610 = !DILocation(line: 72, column: 34, scope: !611)
!611 = distinct !DILexicalBlock(scope: !612, file: !189, line: 71, column: 27)
!612 = distinct !DILexicalBlock(scope: !609, file: !189, line: 71, column: 3)
!613 = !DILocation(line: 72, column: 32, scope: !611)
!614 = !DILocation(line: 72, column: 16, scope: !611)
!615 = !DILocation(line: 73, column: 14, scope: !611)
!616 = !DILocation(line: 74, column: 16, scope: !611)
!617 = !DILocation(line: 74, column: 13, scope: !611)
!618 = !DILocation(line: 71, column: 22, scope: !612)
!619 = !DILocation(line: 71, column: 14, scope: !612)
!620 = distinct !{!620, !608, !621, !404, !405}
!621 = !DILocation(line: 75, column: 3, scope: !609)
!622 = !DILocation(line: 76, column: 26, scope: !593)
!623 = !DILocation(line: 76, column: 14, scope: !593)
!624 = !DILocation(line: 79, column: 10, scope: !593)
!625 = !DILocation(line: 79, column: 3, scope: !593)
!626 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !627, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !629)
!627 = !DISubroutineType(types: !628)
!628 = !{!230, !201}
!629 = !{!630, !631, !632, !669, !672, !675}
!630 = !DILocalVariable(name: "fd", arg: 1, scope: !626, file: !2, line: 34, type: !201)
!631 = !DILocalVariable(name: "p", scope: !626, file: !2, line: 35, type: !230)
!632 = !DILocalVariable(name: "s", scope: !626, file: !2, line: 36, type: !633)
!633 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !634, line: 44, size: 1024, elements: !635)
!634 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!635 = !{!636, !638, !640, !642, !644, !646, !648, !649, !650, !652, !654, !655, !657, !665, !666, !667}
!636 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !633, file: !634, line: 46, baseType: !637, size: 64)
!637 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !200, line: 145, baseType: !244)
!638 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !633, file: !634, line: 47, baseType: !639, size: 64, offset: 64)
!639 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !200, line: 148, baseType: !244)
!640 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !633, file: !634, line: 48, baseType: !641, size: 32, offset: 128)
!641 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !200, line: 150, baseType: !241)
!642 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !633, file: !634, line: 49, baseType: !643, size: 32, offset: 160)
!643 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !200, line: 151, baseType: !241)
!644 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !633, file: !634, line: 50, baseType: !645, size: 32, offset: 192)
!645 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !200, line: 146, baseType: !241)
!646 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !633, file: !634, line: 51, baseType: !647, size: 32, offset: 224)
!647 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !200, line: 147, baseType: !241)
!648 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !633, file: !634, line: 52, baseType: !637, size: 64, offset: 256)
!649 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !633, file: !634, line: 53, baseType: !637, size: 64, offset: 320)
!650 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !633, file: !634, line: 54, baseType: !651, size: 64, offset: 384)
!651 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !200, line: 152, baseType: !253)
!652 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !633, file: !634, line: 55, baseType: !653, size: 32, offset: 448)
!653 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !200, line: 175, baseType: !201)
!654 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !633, file: !634, line: 56, baseType: !201, size: 32, offset: 480)
!655 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !633, file: !634, line: 57, baseType: !656, size: 64, offset: 512)
!656 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !200, line: 180, baseType: !253)
!657 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !633, file: !634, line: 65, baseType: !658, size: 128, offset: 576)
!658 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !659, line: 11, size: 128, elements: !660)
!659 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!660 = !{!661, !663}
!661 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !658, file: !659, line: 16, baseType: !662, size: 64)
!662 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !200, line: 160, baseType: !253)
!663 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !658, file: !659, line: 21, baseType: !664, size: 64, offset: 64)
!664 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !200, line: 197, baseType: !253)
!665 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !633, file: !634, line: 66, baseType: !658, size: 128, offset: 704)
!666 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !633, file: !634, line: 67, baseType: !658, size: 128, offset: 832)
!667 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !633, file: !634, line: 79, baseType: !668, size: 64, offset: 960)
!668 = !DICompositeType(tag: DW_TAG_array_type, baseType: !201, size: 64, elements: !55)
!669 = !DILocalVariable(name: "len", scope: !626, file: !2, line: 37, type: !670)
!670 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !671, line: 85, baseType: !651)
!671 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!672 = !DILocalVariable(name: "bytes_read", scope: !626, file: !2, line: 38, type: !673)
!673 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !671, line: 108, baseType: !674)
!674 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !200, line: 194, baseType: !253)
!675 = !DILocalVariable(name: "status", scope: !626, file: !2, line: 38, type: !673)
!676 = distinct !DIAssignID()
!677 = !DILocation(line: 0, scope: !626)
!678 = !DILocation(line: 36, column: 3, scope: !626)
!679 = !DILocation(line: 40, column: 3, scope: !680)
!680 = distinct !DILexicalBlock(scope: !681, file: !2, line: 40, column: 3)
!681 = distinct !DILexicalBlock(scope: !626, file: !2, line: 40, column: 3)
!682 = !DILocation(line: 41, column: 3, scope: !683)
!683 = distinct !DILexicalBlock(scope: !684, file: !2, line: 41, column: 3)
!684 = distinct !DILexicalBlock(scope: !626, file: !2, line: 41, column: 3)
!685 = !DILocation(line: 42, column: 11, scope: !626)
!686 = !DILocation(line: 43, column: 3, scope: !687)
!687 = distinct !DILexicalBlock(scope: !688, file: !2, line: 43, column: 3)
!688 = distinct !DILexicalBlock(scope: !626, file: !2, line: 43, column: 3)
!689 = !DILocation(line: 44, column: 25, scope: !626)
!690 = !DILocation(line: 44, column: 15, scope: !626)
!691 = !DILocation(line: 46, column: 3, scope: !626)
!692 = !DILocation(line: 49, column: 15, scope: !693)
!693 = distinct !DILexicalBlock(scope: !626, file: !2, line: 46, column: 27)
!694 = !DILocation(line: 46, column: 20, scope: !626)
!695 = distinct !{!695, !691, !696, !404, !405}
!696 = !DILocation(line: 50, column: 3, scope: !626)
!697 = !DILocation(line: 47, column: 24, scope: !693)
!698 = !DILocation(line: 47, column: 42, scope: !693)
!699 = !DILocation(line: 47, column: 14, scope: !693)
!700 = !DILocation(line: 48, column: 5, scope: !701)
!701 = distinct !DILexicalBlock(scope: !702, file: !2, line: 48, column: 5)
!702 = distinct !DILexicalBlock(scope: !693, file: !2, line: 48, column: 5)
!703 = !DILocation(line: 51, column: 3, scope: !626)
!704 = !DILocation(line: 51, column: 10, scope: !626)
!705 = !DILocation(line: 52, column: 3, scope: !626)
!706 = !DILocation(line: 54, column: 1, scope: !626)
!707 = !DILocation(line: 53, column: 3, scope: !626)
!708 = !DISubprogram(name: "__assert_fail", scope: !709, file: !709, line: 67, type: !710, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!709 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!710 = !DISubroutineType(types: !711)
!711 = !{null, !712, !712, !241, !712}
!712 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!713 = !DISubprogram(name: "fstat", scope: !714, file: !714, line: 210, type: !715, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!714 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!715 = !DISubroutineType(types: !716)
!716 = !{!201, !201, !717}
!717 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !633, size: 64)
!718 = !DISubprogram(name: "malloc", scope: !509, file: !509, line: 672, type: !719, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!719 = !DISubroutineType(types: !720)
!720 = !{!231, !721}
!721 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !722, line: 18, baseType: !244)
!722 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!723 = !DISubprogram(name: "read", scope: !724, file: !724, line: 371, type: !725, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!724 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!725 = !DISubroutineType(types: !726)
!726 = !{!673, !201, !231, !721}
!727 = !DISubprogram(name: "close", scope: !724, file: !724, line: 358, type: !518, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!728 = !DILocation(line: 0, scope: !477)
!729 = !DILocation(line: 59, column: 3, scope: !730)
!730 = distinct !DILexicalBlock(scope: !731, file: !2, line: 59, column: 3)
!731 = distinct !DILexicalBlock(scope: !477, file: !2, line: 59, column: 3)
!732 = !DILocation(line: 60, column: 7, scope: !733)
!733 = distinct !DILexicalBlock(scope: !477, file: !2, line: 60, column: 6)
!734 = !DILocation(line: 60, column: 6, scope: !477)
!735 = !DILocation(line: 64, column: 17, scope: !477)
!736 = !DILocation(line: 64, column: 3, scope: !477)
!737 = !DILocation(line: 66, column: 22, scope: !489)
!738 = !DILocation(line: 66, column: 26, scope: !489)
!739 = !DILocation(line: 66, column: 32, scope: !489)
!740 = !DILocation(line: 66, column: 35, scope: !489)
!741 = !DILocation(line: 66, column: 39, scope: !489)
!742 = !DILocation(line: 66, column: 9, scope: !490)
!743 = !DILocation(line: 69, column: 6, scope: !490)
!744 = !DILocation(line: 64, column: 10, scope: !477)
!745 = !DILocation(line: 64, column: 13, scope: !477)
!746 = distinct !{!746, !736, !747, !404, !405}
!747 = !DILocation(line: 70, column: 3, scope: !477)
!748 = !DILocation(line: 71, column: 6, scope: !502)
!749 = !DILocation(line: 71, column: 8, scope: !502)
!750 = !DILocation(line: 71, column: 6, scope: !477)
!751 = !DILocation(line: 74, column: 1, scope: !477)
!752 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !753, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !755)
!753 = !DISubroutineType(types: !754)
!754 = !{!201, !230, !230, !201}
!755 = !{!756, !757, !758, !759}
!756 = !DILocalVariable(name: "s", arg: 1, scope: !752, file: !2, line: 77, type: !230)
!757 = !DILocalVariable(name: "arr", arg: 2, scope: !752, file: !2, line: 77, type: !230)
!758 = !DILocalVariable(name: "n", arg: 3, scope: !752, file: !2, line: 77, type: !201)
!759 = !DILocalVariable(name: "k", scope: !752, file: !2, line: 78, type: !201)
!760 = !DILocation(line: 0, scope: !752)
!761 = !DILocation(line: 79, column: 3, scope: !762)
!762 = distinct !DILexicalBlock(scope: !763, file: !2, line: 79, column: 3)
!763 = distinct !DILexicalBlock(scope: !752, file: !2, line: 79, column: 3)
!764 = !DILocation(line: 81, column: 8, scope: !765)
!765 = distinct !DILexicalBlock(scope: !752, file: !2, line: 81, column: 7)
!766 = !DILocation(line: 81, column: 7, scope: !752)
!767 = !DILocation(line: 83, column: 12, scope: !768)
!768 = distinct !DILexicalBlock(scope: !765, file: !2, line: 81, column: 13)
!769 = !DILocation(line: 83, column: 5, scope: !768)
!770 = !DILocation(line: 91, column: 19, scope: !752)
!771 = !DILocation(line: 91, column: 3, scope: !752)
!772 = !DILocation(line: 92, column: 7, scope: !752)
!773 = !DILocation(line: 83, column: 16, scope: !768)
!774 = !DILocation(line: 83, column: 26, scope: !768)
!775 = !DILocation(line: 83, column: 32, scope: !768)
!776 = !DILocation(line: 83, column: 29, scope: !768)
!777 = !DILocation(line: 83, column: 35, scope: !768)
!778 = !DILocation(line: 83, column: 45, scope: !768)
!779 = !DILocation(line: 83, column: 48, scope: !768)
!780 = !DILocation(line: 83, column: 54, scope: !768)
!781 = !DILocation(line: 84, column: 9, scope: !768)
!782 = !DILocation(line: 84, column: 18, scope: !768)
!783 = !DILocation(line: 84, column: 26, scope: !768)
!784 = distinct !{!784, !769, !785, !404, !405}
!785 = !DILocation(line: 86, column: 5, scope: !768)
!786 = !DILocation(line: 93, column: 5, scope: !787)
!787 = distinct !DILexicalBlock(scope: !752, file: !2, line: 92, column: 7)
!788 = !DILocation(line: 93, column: 12, scope: !787)
!789 = !DILocation(line: 95, column: 3, scope: !752)
!790 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !791, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !794)
!791 = !DISubroutineType(types: !792)
!792 = !{!201, !230, !793, !201}
!793 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !232, size: 64)
!794 = !{!795, !796, !797, !798, !799, !800, !801}
!795 = !DILocalVariable(name: "s", arg: 1, scope: !790, file: !2, line: 132, type: !230)
!796 = !DILocalVariable(name: "arr", arg: 2, scope: !790, file: !2, line: 132, type: !793)
!797 = !DILocalVariable(name: "n", arg: 3, scope: !790, file: !2, line: 132, type: !201)
!798 = !DILocalVariable(name: "line", scope: !790, file: !2, line: 132, type: !230)
!799 = !DILocalVariable(name: "endptr", scope: !790, file: !2, line: 132, type: !230)
!800 = !DILocalVariable(name: "i", scope: !790, file: !2, line: 132, type: !201)
!801 = !DILocalVariable(name: "v", scope: !790, file: !2, line: 132, type: !232)
!802 = distinct !DIAssignID()
!803 = !DILocation(line: 0, scope: !790)
!804 = !DILocation(line: 132, column: 1, scope: !790)
!805 = !DILocation(line: 132, column: 1, scope: !806)
!806 = distinct !DILexicalBlock(scope: !807, file: !2, line: 132, column: 1)
!807 = distinct !DILexicalBlock(scope: !790, file: !2, line: 132, column: 1)
!808 = !DILocation(line: 132, column: 1, scope: !809)
!809 = distinct !DILexicalBlock(scope: !790, file: !2, line: 132, column: 1)
!810 = !{!811, !811, i64 0}
!811 = !{!"any pointer", !388, i64 0}
!812 = distinct !DIAssignID()
!813 = !DILocation(line: 132, column: 1, scope: !814)
!814 = distinct !DILexicalBlock(scope: !809, file: !2, line: 132, column: 1)
!815 = !DILocation(line: 132, column: 1, scope: !816)
!816 = distinct !DILexicalBlock(scope: !814, file: !2, line: 132, column: 1)
!817 = distinct !{!817, !804, !804, !404, !405}
!818 = !DILocation(line: 132, column: 1, scope: !819)
!819 = distinct !DILexicalBlock(scope: !820, file: !2, line: 132, column: 1)
!820 = distinct !DILexicalBlock(scope: !790, file: !2, line: 132, column: 1)
!821 = !DISubprogram(name: "strtok", scope: !822, file: !822, line: 356, type: !823, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!822 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!823 = !DISubroutineType(types: !824)
!824 = !{!230, !825, !826}
!825 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !230)
!826 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !712)
!827 = !DISubprogram(name: "strtol", scope: !509, file: !509, line: 177, type: !828, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!828 = !DISubroutineType(types: !829)
!829 = !{!253, !826, !830, !201}
!830 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !831)
!831 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !230, size: 64)
!832 = !DISubprogram(name: "fprintf", scope: !833, file: !833, line: 357, type: !834, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!833 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!834 = !DISubroutineType(types: !835)
!835 = !{!201, !836, !826, null}
!836 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !837)
!837 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !838, size: 64)
!838 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !839, line: 7, baseType: !840)
!839 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!840 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !841, line: 49, size: 1728, elements: !842)
!841 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!842 = !{!843, !844, !845, !846, !847, !848, !849, !850, !851, !852, !853, !854, !855, !858, !860, !861, !862, !863, !864, !865, !869, !872, !874, !877, !880, !881, !882, !884, !885}
!843 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !840, file: !841, line: 51, baseType: !201, size: 32)
!844 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !840, file: !841, line: 54, baseType: !230, size: 64, offset: 64)
!845 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !840, file: !841, line: 55, baseType: !230, size: 64, offset: 128)
!846 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !840, file: !841, line: 56, baseType: !230, size: 64, offset: 192)
!847 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !840, file: !841, line: 57, baseType: !230, size: 64, offset: 256)
!848 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !840, file: !841, line: 58, baseType: !230, size: 64, offset: 320)
!849 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !840, file: !841, line: 59, baseType: !230, size: 64, offset: 384)
!850 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !840, file: !841, line: 60, baseType: !230, size: 64, offset: 448)
!851 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !840, file: !841, line: 61, baseType: !230, size: 64, offset: 512)
!852 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !840, file: !841, line: 64, baseType: !230, size: 64, offset: 576)
!853 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !840, file: !841, line: 65, baseType: !230, size: 64, offset: 640)
!854 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !840, file: !841, line: 66, baseType: !230, size: 64, offset: 704)
!855 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !840, file: !841, line: 68, baseType: !856, size: 64, offset: 768)
!856 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !857, size: 64)
!857 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !841, line: 36, flags: DIFlagFwdDecl)
!858 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !840, file: !841, line: 70, baseType: !859, size: 64, offset: 832)
!859 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !840, size: 64)
!860 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !840, file: !841, line: 72, baseType: !201, size: 32, offset: 896)
!861 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !840, file: !841, line: 73, baseType: !201, size: 32, offset: 928)
!862 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !840, file: !841, line: 74, baseType: !651, size: 64, offset: 960)
!863 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !840, file: !841, line: 77, baseType: !238, size: 16, offset: 1024)
!864 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !840, file: !841, line: 78, baseType: !247, size: 8, offset: 1040)
!865 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !840, file: !841, line: 79, baseType: !866, size: 8, offset: 1048)
!866 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !867)
!867 = !{!868}
!868 = !DISubrange(count: 1)
!869 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !840, file: !841, line: 81, baseType: !870, size: 64, offset: 1088)
!870 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !871, size: 64)
!871 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !841, line: 43, baseType: null)
!872 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !840, file: !841, line: 89, baseType: !873, size: 64, offset: 1152)
!873 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !200, line: 153, baseType: !253)
!874 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !840, file: !841, line: 91, baseType: !875, size: 64, offset: 1216)
!875 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !876, size: 64)
!876 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !841, line: 37, flags: DIFlagFwdDecl)
!877 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !840, file: !841, line: 92, baseType: !878, size: 64, offset: 1280)
!878 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !879, size: 64)
!879 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !841, line: 38, flags: DIFlagFwdDecl)
!880 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !840, file: !841, line: 93, baseType: !859, size: 64, offset: 1344)
!881 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !840, file: !841, line: 94, baseType: !231, size: 64, offset: 1408)
!882 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !840, file: !841, line: 95, baseType: !883, size: 64, offset: 1472)
!883 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !859, size: 64)
!884 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !840, file: !841, line: 96, baseType: !201, size: 32, offset: 1536)
!885 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !840, file: !841, line: 98, baseType: !886, size: 160, offset: 1568)
!886 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!887 = !DISubprogram(name: "strlen", scope: !822, file: !822, line: 407, type: !888, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!888 = !DISubroutineType(types: !889)
!889 = !{!244, !712}
!890 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !891, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !894)
!891 = !DISubroutineType(types: !892)
!892 = !{!201, !230, !893, !201}
!893 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !236, size: 64)
!894 = !{!895, !896, !897, !898, !899, !900, !901}
!895 = !DILocalVariable(name: "s", arg: 1, scope: !890, file: !2, line: 133, type: !230)
!896 = !DILocalVariable(name: "arr", arg: 2, scope: !890, file: !2, line: 133, type: !893)
!897 = !DILocalVariable(name: "n", arg: 3, scope: !890, file: !2, line: 133, type: !201)
!898 = !DILocalVariable(name: "line", scope: !890, file: !2, line: 133, type: !230)
!899 = !DILocalVariable(name: "endptr", scope: !890, file: !2, line: 133, type: !230)
!900 = !DILocalVariable(name: "i", scope: !890, file: !2, line: 133, type: !201)
!901 = !DILocalVariable(name: "v", scope: !890, file: !2, line: 133, type: !236)
!902 = distinct !DIAssignID()
!903 = !DILocation(line: 0, scope: !890)
!904 = !DILocation(line: 133, column: 1, scope: !890)
!905 = !DILocation(line: 133, column: 1, scope: !906)
!906 = distinct !DILexicalBlock(scope: !907, file: !2, line: 133, column: 1)
!907 = distinct !DILexicalBlock(scope: !890, file: !2, line: 133, column: 1)
!908 = !DILocation(line: 133, column: 1, scope: !909)
!909 = distinct !DILexicalBlock(scope: !890, file: !2, line: 133, column: 1)
!910 = distinct !DIAssignID()
!911 = !DILocation(line: 133, column: 1, scope: !912)
!912 = distinct !DILexicalBlock(scope: !909, file: !2, line: 133, column: 1)
!913 = !DILocation(line: 133, column: 1, scope: !914)
!914 = distinct !DILexicalBlock(scope: !912, file: !2, line: 133, column: 1)
!915 = !{!916, !916, i64 0}
!916 = !{!"short", !388, i64 0}
!917 = distinct !{!917, !904, !904, !404, !405}
!918 = !DILocation(line: 133, column: 1, scope: !919)
!919 = distinct !DILexicalBlock(scope: !920, file: !2, line: 133, column: 1)
!920 = distinct !DILexicalBlock(scope: !890, file: !2, line: 133, column: 1)
!921 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !922, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !925)
!922 = !DISubroutineType(types: !923)
!923 = !{!201, !230, !924, !201}
!924 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !239, size: 64)
!925 = !{!926, !927, !928, !929, !930, !931, !932}
!926 = !DILocalVariable(name: "s", arg: 1, scope: !921, file: !2, line: 134, type: !230)
!927 = !DILocalVariable(name: "arr", arg: 2, scope: !921, file: !2, line: 134, type: !924)
!928 = !DILocalVariable(name: "n", arg: 3, scope: !921, file: !2, line: 134, type: !201)
!929 = !DILocalVariable(name: "line", scope: !921, file: !2, line: 134, type: !230)
!930 = !DILocalVariable(name: "endptr", scope: !921, file: !2, line: 134, type: !230)
!931 = !DILocalVariable(name: "i", scope: !921, file: !2, line: 134, type: !201)
!932 = !DILocalVariable(name: "v", scope: !921, file: !2, line: 134, type: !239)
!933 = distinct !DIAssignID()
!934 = !DILocation(line: 0, scope: !921)
!935 = !DILocation(line: 134, column: 1, scope: !921)
!936 = !DILocation(line: 134, column: 1, scope: !937)
!937 = distinct !DILexicalBlock(scope: !938, file: !2, line: 134, column: 1)
!938 = distinct !DILexicalBlock(scope: !921, file: !2, line: 134, column: 1)
!939 = !DILocation(line: 134, column: 1, scope: !940)
!940 = distinct !DILexicalBlock(scope: !921, file: !2, line: 134, column: 1)
!941 = distinct !DIAssignID()
!942 = !DILocation(line: 134, column: 1, scope: !943)
!943 = distinct !DILexicalBlock(scope: !940, file: !2, line: 134, column: 1)
!944 = !DILocation(line: 134, column: 1, scope: !945)
!945 = distinct !DILexicalBlock(scope: !943, file: !2, line: 134, column: 1)
!946 = distinct !{!946, !935, !935, !404, !405}
!947 = !DILocation(line: 134, column: 1, scope: !948)
!948 = distinct !DILexicalBlock(scope: !949, file: !2, line: 134, column: 1)
!949 = distinct !DILexicalBlock(scope: !921, file: !2, line: 134, column: 1)
!950 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !951, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !954)
!951 = !DISubroutineType(types: !952)
!952 = !{!201, !230, !953, !201}
!953 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !242, size: 64)
!954 = !{!955, !956, !957, !958, !959, !960, !961}
!955 = !DILocalVariable(name: "s", arg: 1, scope: !950, file: !2, line: 135, type: !230)
!956 = !DILocalVariable(name: "arr", arg: 2, scope: !950, file: !2, line: 135, type: !953)
!957 = !DILocalVariable(name: "n", arg: 3, scope: !950, file: !2, line: 135, type: !201)
!958 = !DILocalVariable(name: "line", scope: !950, file: !2, line: 135, type: !230)
!959 = !DILocalVariable(name: "endptr", scope: !950, file: !2, line: 135, type: !230)
!960 = !DILocalVariable(name: "i", scope: !950, file: !2, line: 135, type: !201)
!961 = !DILocalVariable(name: "v", scope: !950, file: !2, line: 135, type: !242)
!962 = distinct !DIAssignID()
!963 = !DILocation(line: 0, scope: !950)
!964 = !DILocation(line: 135, column: 1, scope: !950)
!965 = !DILocation(line: 135, column: 1, scope: !966)
!966 = distinct !DILexicalBlock(scope: !967, file: !2, line: 135, column: 1)
!967 = distinct !DILexicalBlock(scope: !950, file: !2, line: 135, column: 1)
!968 = !DILocation(line: 135, column: 1, scope: !969)
!969 = distinct !DILexicalBlock(scope: !950, file: !2, line: 135, column: 1)
!970 = distinct !DIAssignID()
!971 = !DILocation(line: 135, column: 1, scope: !972)
!972 = distinct !DILexicalBlock(scope: !969, file: !2, line: 135, column: 1)
!973 = !DILocation(line: 135, column: 1, scope: !974)
!974 = distinct !DILexicalBlock(scope: !972, file: !2, line: 135, column: 1)
!975 = !{!976, !976, i64 0}
!976 = !{!"long", !388, i64 0}
!977 = distinct !{!977, !964, !964, !404, !405}
!978 = !DILocation(line: 135, column: 1, scope: !979)
!979 = distinct !DILexicalBlock(scope: !980, file: !2, line: 135, column: 1)
!980 = distinct !DILexicalBlock(scope: !950, file: !2, line: 135, column: 1)
!981 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !982, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !985)
!982 = !DISubroutineType(types: !983)
!983 = !{!201, !230, !984, !201}
!984 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !245, size: 64)
!985 = !{!986, !987, !988, !989, !990, !991, !992}
!986 = !DILocalVariable(name: "s", arg: 1, scope: !981, file: !2, line: 136, type: !230)
!987 = !DILocalVariable(name: "arr", arg: 2, scope: !981, file: !2, line: 136, type: !984)
!988 = !DILocalVariable(name: "n", arg: 3, scope: !981, file: !2, line: 136, type: !201)
!989 = !DILocalVariable(name: "line", scope: !981, file: !2, line: 136, type: !230)
!990 = !DILocalVariable(name: "endptr", scope: !981, file: !2, line: 136, type: !230)
!991 = !DILocalVariable(name: "i", scope: !981, file: !2, line: 136, type: !201)
!992 = !DILocalVariable(name: "v", scope: !981, file: !2, line: 136, type: !245)
!993 = distinct !DIAssignID()
!994 = !DILocation(line: 0, scope: !981)
!995 = !DILocation(line: 136, column: 1, scope: !981)
!996 = !DILocation(line: 136, column: 1, scope: !997)
!997 = distinct !DILexicalBlock(scope: !998, file: !2, line: 136, column: 1)
!998 = distinct !DILexicalBlock(scope: !981, file: !2, line: 136, column: 1)
!999 = !DILocation(line: 136, column: 1, scope: !1000)
!1000 = distinct !DILexicalBlock(scope: !981, file: !2, line: 136, column: 1)
!1001 = distinct !DIAssignID()
!1002 = !DILocation(line: 136, column: 1, scope: !1003)
!1003 = distinct !DILexicalBlock(scope: !1000, file: !2, line: 136, column: 1)
!1004 = !DILocation(line: 136, column: 1, scope: !1005)
!1005 = distinct !DILexicalBlock(scope: !1003, file: !2, line: 136, column: 1)
!1006 = distinct !{!1006, !995, !995, !404, !405}
!1007 = !DILocation(line: 136, column: 1, scope: !1008)
!1008 = distinct !DILexicalBlock(scope: !1009, file: !2, line: 136, column: 1)
!1009 = distinct !DILexicalBlock(scope: !981, file: !2, line: 136, column: 1)
!1010 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1011, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1014)
!1011 = !DISubroutineType(types: !1012)
!1012 = !{!201, !230, !1013, !201}
!1013 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !248, size: 64)
!1014 = !{!1015, !1016, !1017, !1018, !1019, !1020, !1021}
!1015 = !DILocalVariable(name: "s", arg: 1, scope: !1010, file: !2, line: 137, type: !230)
!1016 = !DILocalVariable(name: "arr", arg: 2, scope: !1010, file: !2, line: 137, type: !1013)
!1017 = !DILocalVariable(name: "n", arg: 3, scope: !1010, file: !2, line: 137, type: !201)
!1018 = !DILocalVariable(name: "line", scope: !1010, file: !2, line: 137, type: !230)
!1019 = !DILocalVariable(name: "endptr", scope: !1010, file: !2, line: 137, type: !230)
!1020 = !DILocalVariable(name: "i", scope: !1010, file: !2, line: 137, type: !201)
!1021 = !DILocalVariable(name: "v", scope: !1010, file: !2, line: 137, type: !248)
!1022 = distinct !DIAssignID()
!1023 = !DILocation(line: 0, scope: !1010)
!1024 = !DILocation(line: 137, column: 1, scope: !1010)
!1025 = !DILocation(line: 137, column: 1, scope: !1026)
!1026 = distinct !DILexicalBlock(scope: !1027, file: !2, line: 137, column: 1)
!1027 = distinct !DILexicalBlock(scope: !1010, file: !2, line: 137, column: 1)
!1028 = !DILocation(line: 137, column: 1, scope: !1029)
!1029 = distinct !DILexicalBlock(scope: !1010, file: !2, line: 137, column: 1)
!1030 = distinct !DIAssignID()
!1031 = !DILocation(line: 137, column: 1, scope: !1032)
!1032 = distinct !DILexicalBlock(scope: !1029, file: !2, line: 137, column: 1)
!1033 = !DILocation(line: 137, column: 1, scope: !1034)
!1034 = distinct !DILexicalBlock(scope: !1032, file: !2, line: 137, column: 1)
!1035 = distinct !{!1035, !1024, !1024, !404, !405}
!1036 = !DILocation(line: 137, column: 1, scope: !1037)
!1037 = distinct !DILexicalBlock(scope: !1038, file: !2, line: 137, column: 1)
!1038 = distinct !DILexicalBlock(scope: !1010, file: !2, line: 137, column: 1)
!1039 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1040, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1042)
!1040 = !DISubroutineType(types: !1041)
!1041 = !{!201, !230, !326, !201}
!1042 = !{!1043, !1044, !1045, !1046, !1047, !1048, !1049}
!1043 = !DILocalVariable(name: "s", arg: 1, scope: !1039, file: !2, line: 138, type: !230)
!1044 = !DILocalVariable(name: "arr", arg: 2, scope: !1039, file: !2, line: 138, type: !326)
!1045 = !DILocalVariable(name: "n", arg: 3, scope: !1039, file: !2, line: 138, type: !201)
!1046 = !DILocalVariable(name: "line", scope: !1039, file: !2, line: 138, type: !230)
!1047 = !DILocalVariable(name: "endptr", scope: !1039, file: !2, line: 138, type: !230)
!1048 = !DILocalVariable(name: "i", scope: !1039, file: !2, line: 138, type: !201)
!1049 = !DILocalVariable(name: "v", scope: !1039, file: !2, line: 138, type: !197)
!1050 = distinct !DIAssignID()
!1051 = !DILocation(line: 0, scope: !1039)
!1052 = !DILocation(line: 138, column: 1, scope: !1039)
!1053 = !DILocation(line: 138, column: 1, scope: !1054)
!1054 = distinct !DILexicalBlock(scope: !1055, file: !2, line: 138, column: 1)
!1055 = distinct !DILexicalBlock(scope: !1039, file: !2, line: 138, column: 1)
!1056 = !DILocation(line: 138, column: 1, scope: !1057)
!1057 = distinct !DILexicalBlock(scope: !1039, file: !2, line: 138, column: 1)
!1058 = distinct !DIAssignID()
!1059 = !DILocation(line: 138, column: 1, scope: !1060)
!1060 = distinct !DILexicalBlock(scope: !1057, file: !2, line: 138, column: 1)
!1061 = !DILocation(line: 138, column: 1, scope: !1062)
!1062 = distinct !DILexicalBlock(scope: !1060, file: !2, line: 138, column: 1)
!1063 = distinct !{!1063, !1052, !1052, !404, !405}
!1064 = !DILocation(line: 138, column: 1, scope: !1065)
!1065 = distinct !DILexicalBlock(scope: !1066, file: !2, line: 138, column: 1)
!1066 = distinct !DILexicalBlock(scope: !1039, file: !2, line: 138, column: 1)
!1067 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1068, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1071)
!1068 = !DISubroutineType(types: !1069)
!1069 = !{!201, !230, !1070, !201}
!1070 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !251, size: 64)
!1071 = !{!1072, !1073, !1074, !1075, !1076, !1077, !1078}
!1072 = !DILocalVariable(name: "s", arg: 1, scope: !1067, file: !2, line: 139, type: !230)
!1073 = !DILocalVariable(name: "arr", arg: 2, scope: !1067, file: !2, line: 139, type: !1070)
!1074 = !DILocalVariable(name: "n", arg: 3, scope: !1067, file: !2, line: 139, type: !201)
!1075 = !DILocalVariable(name: "line", scope: !1067, file: !2, line: 139, type: !230)
!1076 = !DILocalVariable(name: "endptr", scope: !1067, file: !2, line: 139, type: !230)
!1077 = !DILocalVariable(name: "i", scope: !1067, file: !2, line: 139, type: !201)
!1078 = !DILocalVariable(name: "v", scope: !1067, file: !2, line: 139, type: !251)
!1079 = distinct !DIAssignID()
!1080 = !DILocation(line: 0, scope: !1067)
!1081 = !DILocation(line: 139, column: 1, scope: !1067)
!1082 = !DILocation(line: 139, column: 1, scope: !1083)
!1083 = distinct !DILexicalBlock(scope: !1084, file: !2, line: 139, column: 1)
!1084 = distinct !DILexicalBlock(scope: !1067, file: !2, line: 139, column: 1)
!1085 = !DILocation(line: 139, column: 1, scope: !1086)
!1086 = distinct !DILexicalBlock(scope: !1067, file: !2, line: 139, column: 1)
!1087 = distinct !DIAssignID()
!1088 = !DILocation(line: 139, column: 1, scope: !1089)
!1089 = distinct !DILexicalBlock(scope: !1086, file: !2, line: 139, column: 1)
!1090 = !DILocation(line: 139, column: 1, scope: !1091)
!1091 = distinct !DILexicalBlock(scope: !1089, file: !2, line: 139, column: 1)
!1092 = distinct !{!1092, !1081, !1081, !404, !405}
!1093 = !DILocation(line: 139, column: 1, scope: !1094)
!1094 = distinct !DILexicalBlock(scope: !1095, file: !2, line: 139, column: 1)
!1095 = distinct !DILexicalBlock(scope: !1067, file: !2, line: 139, column: 1)
!1096 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1097, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1100)
!1097 = !DISubroutineType(types: !1098)
!1098 = !{!201, !230, !1099, !201}
!1099 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 64)
!1100 = !{!1101, !1102, !1103, !1104, !1105, !1106, !1107}
!1101 = !DILocalVariable(name: "s", arg: 1, scope: !1096, file: !2, line: 141, type: !230)
!1102 = !DILocalVariable(name: "arr", arg: 2, scope: !1096, file: !2, line: 141, type: !1099)
!1103 = !DILocalVariable(name: "n", arg: 3, scope: !1096, file: !2, line: 141, type: !201)
!1104 = !DILocalVariable(name: "line", scope: !1096, file: !2, line: 141, type: !230)
!1105 = !DILocalVariable(name: "endptr", scope: !1096, file: !2, line: 141, type: !230)
!1106 = !DILocalVariable(name: "i", scope: !1096, file: !2, line: 141, type: !201)
!1107 = !DILocalVariable(name: "v", scope: !1096, file: !2, line: 141, type: !254)
!1108 = distinct !DIAssignID()
!1109 = !DILocation(line: 0, scope: !1096)
!1110 = !DILocation(line: 141, column: 1, scope: !1096)
!1111 = !DILocation(line: 141, column: 1, scope: !1112)
!1112 = distinct !DILexicalBlock(scope: !1113, file: !2, line: 141, column: 1)
!1113 = distinct !DILexicalBlock(scope: !1096, file: !2, line: 141, column: 1)
!1114 = !DILocation(line: 141, column: 1, scope: !1115)
!1115 = distinct !DILexicalBlock(scope: !1096, file: !2, line: 141, column: 1)
!1116 = distinct !DIAssignID()
!1117 = !DILocation(line: 141, column: 1, scope: !1118)
!1118 = distinct !DILexicalBlock(scope: !1115, file: !2, line: 141, column: 1)
!1119 = !DILocation(line: 141, column: 1, scope: !1120)
!1120 = distinct !DILexicalBlock(scope: !1118, file: !2, line: 141, column: 1)
!1121 = !{!1122, !1122, i64 0}
!1122 = !{!"float", !388, i64 0}
!1123 = distinct !{!1123, !1110, !1110, !404, !405}
!1124 = !DILocation(line: 141, column: 1, scope: !1125)
!1125 = distinct !DILexicalBlock(scope: !1126, file: !2, line: 141, column: 1)
!1126 = distinct !DILexicalBlock(scope: !1096, file: !2, line: 141, column: 1)
!1127 = !DISubprogram(name: "strtof", scope: !509, file: !509, line: 124, type: !1128, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1128 = !DISubroutineType(types: !1129)
!1129 = !{!254, !826, !830}
!1130 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1131, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1134)
!1131 = !DISubroutineType(types: !1132)
!1132 = !{!201, !230, !1133, !201}
!1133 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !255, size: 64)
!1134 = !{!1135, !1136, !1137, !1138, !1139, !1140, !1141}
!1135 = !DILocalVariable(name: "s", arg: 1, scope: !1130, file: !2, line: 142, type: !230)
!1136 = !DILocalVariable(name: "arr", arg: 2, scope: !1130, file: !2, line: 142, type: !1133)
!1137 = !DILocalVariable(name: "n", arg: 3, scope: !1130, file: !2, line: 142, type: !201)
!1138 = !DILocalVariable(name: "line", scope: !1130, file: !2, line: 142, type: !230)
!1139 = !DILocalVariable(name: "endptr", scope: !1130, file: !2, line: 142, type: !230)
!1140 = !DILocalVariable(name: "i", scope: !1130, file: !2, line: 142, type: !201)
!1141 = !DILocalVariable(name: "v", scope: !1130, file: !2, line: 142, type: !255)
!1142 = distinct !DIAssignID()
!1143 = !DILocation(line: 0, scope: !1130)
!1144 = !DILocation(line: 142, column: 1, scope: !1130)
!1145 = !DILocation(line: 142, column: 1, scope: !1146)
!1146 = distinct !DILexicalBlock(scope: !1147, file: !2, line: 142, column: 1)
!1147 = distinct !DILexicalBlock(scope: !1130, file: !2, line: 142, column: 1)
!1148 = !DILocation(line: 142, column: 1, scope: !1149)
!1149 = distinct !DILexicalBlock(scope: !1130, file: !2, line: 142, column: 1)
!1150 = distinct !DIAssignID()
!1151 = !DILocation(line: 142, column: 1, scope: !1152)
!1152 = distinct !DILexicalBlock(scope: !1149, file: !2, line: 142, column: 1)
!1153 = !DILocation(line: 142, column: 1, scope: !1154)
!1154 = distinct !DILexicalBlock(scope: !1152, file: !2, line: 142, column: 1)
!1155 = !{!1156, !1156, i64 0}
!1156 = !{!"double", !388, i64 0}
!1157 = distinct !{!1157, !1144, !1144, !404, !405}
!1158 = !DILocation(line: 142, column: 1, scope: !1159)
!1159 = distinct !DILexicalBlock(scope: !1160, file: !2, line: 142, column: 1)
!1160 = distinct !DILexicalBlock(scope: !1130, file: !2, line: 142, column: 1)
!1161 = !DISubprogram(name: "strtod", scope: !509, file: !509, line: 118, type: !1162, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1162 = !DISubroutineType(types: !1163)
!1163 = !{!255, !826, !830}
!1164 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1165, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1167)
!1165 = !DISubroutineType(types: !1166)
!1166 = !{!201, !201, !230, !201}
!1167 = !{!1168, !1169, !1170, !1171, !1172}
!1168 = !DILocalVariable(name: "fd", arg: 1, scope: !1164, file: !2, line: 145, type: !201)
!1169 = !DILocalVariable(name: "arr", arg: 2, scope: !1164, file: !2, line: 145, type: !230)
!1170 = !DILocalVariable(name: "n", arg: 3, scope: !1164, file: !2, line: 145, type: !201)
!1171 = !DILocalVariable(name: "status", scope: !1164, file: !2, line: 146, type: !201)
!1172 = !DILocalVariable(name: "written", scope: !1164, file: !2, line: 146, type: !201)
!1173 = !DILocation(line: 0, scope: !1164)
!1174 = !DILocation(line: 147, column: 3, scope: !1175)
!1175 = distinct !DILexicalBlock(scope: !1176, file: !2, line: 147, column: 3)
!1176 = distinct !DILexicalBlock(scope: !1164, file: !2, line: 147, column: 3)
!1177 = !DILocation(line: 148, column: 8, scope: !1178)
!1178 = distinct !DILexicalBlock(scope: !1164, file: !2, line: 148, column: 7)
!1179 = !DILocation(line: 148, column: 7, scope: !1164)
!1180 = !DILocation(line: 149, column: 9, scope: !1181)
!1181 = distinct !DILexicalBlock(scope: !1178, file: !2, line: 148, column: 13)
!1182 = !DILocation(line: 150, column: 3, scope: !1181)
!1183 = !DILocation(line: 152, column: 16, scope: !1164)
!1184 = !DILocation(line: 152, column: 3, scope: !1164)
!1185 = !DILocation(line: 158, column: 3, scope: !1164)
!1186 = !DILocation(line: 155, column: 13, scope: !1187)
!1187 = distinct !DILexicalBlock(scope: !1164, file: !2, line: 152, column: 20)
!1188 = distinct !{!1188, !1184, !1189, !404, !405}
!1189 = !DILocation(line: 156, column: 3, scope: !1164)
!1190 = !DILocation(line: 153, column: 25, scope: !1187)
!1191 = !DILocation(line: 153, column: 40, scope: !1187)
!1192 = !DILocation(line: 153, column: 39, scope: !1187)
!1193 = !DILocation(line: 153, column: 14, scope: !1187)
!1194 = !DILocation(line: 154, column: 5, scope: !1195)
!1195 = distinct !DILexicalBlock(scope: !1196, file: !2, line: 154, column: 5)
!1196 = distinct !DILexicalBlock(scope: !1187, file: !2, line: 154, column: 5)
!1197 = !DILocation(line: 159, column: 14, scope: !1198)
!1198 = distinct !DILexicalBlock(scope: !1164, file: !2, line: 158, column: 6)
!1199 = !DILocation(line: 160, column: 5, scope: !1200)
!1200 = distinct !DILexicalBlock(scope: !1201, file: !2, line: 160, column: 5)
!1201 = distinct !DILexicalBlock(scope: !1198, file: !2, line: 160, column: 5)
!1202 = !DILocation(line: 161, column: 17, scope: !1164)
!1203 = !DILocation(line: 161, column: 3, scope: !1198)
!1204 = distinct !{!1204, !1185, !1205, !404, !405}
!1205 = !DILocation(line: 161, column: 20, scope: !1164)
!1206 = !DILocation(line: 163, column: 3, scope: !1164)
!1207 = !DISubprogram(name: "write", scope: !724, file: !724, line: 378, type: !1208, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1208 = !DISubroutineType(types: !1209)
!1209 = !{!673, !201, !1210, !721}
!1210 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1211, size: 64)
!1211 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1212 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1213, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1215)
!1213 = !DISubroutineType(types: !1214)
!1214 = !{!201, !201, !793, !201}
!1215 = !{!1216, !1217, !1218, !1219}
!1216 = !DILocalVariable(name: "fd", arg: 1, scope: !1212, file: !2, line: 177, type: !201)
!1217 = !DILocalVariable(name: "arr", arg: 2, scope: !1212, file: !2, line: 177, type: !793)
!1218 = !DILocalVariable(name: "n", arg: 3, scope: !1212, file: !2, line: 177, type: !201)
!1219 = !DILocalVariable(name: "i", scope: !1212, file: !2, line: 177, type: !201)
!1220 = !DILocation(line: 0, scope: !1212)
!1221 = !DILocation(line: 177, column: 1, scope: !1222)
!1222 = distinct !DILexicalBlock(scope: !1223, file: !2, line: 177, column: 1)
!1223 = distinct !DILexicalBlock(scope: !1212, file: !2, line: 177, column: 1)
!1224 = !DILocation(line: 177, column: 1, scope: !1225)
!1225 = distinct !DILexicalBlock(scope: !1226, file: !2, line: 177, column: 1)
!1226 = distinct !DILexicalBlock(scope: !1212, file: !2, line: 177, column: 1)
!1227 = !DILocation(line: 177, column: 1, scope: !1226)
!1228 = !DILocation(line: 177, column: 1, scope: !1229)
!1229 = distinct !DILexicalBlock(scope: !1225, file: !2, line: 177, column: 1)
!1230 = distinct !{!1230, !1227, !1227, !404, !405}
!1231 = !DILocation(line: 177, column: 1, scope: !1212)
!1232 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1233, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1235)
!1233 = !DISubroutineType(cc: DW_CC_nocall, types: !1234)
!1234 = !{!201, !201, !712, null}
!1235 = !{!1236, !1237, !1238, !1242, !1243, !1244, !1245}
!1236 = !DILocalVariable(name: "fd", arg: 1, scope: !1232, file: !2, line: 15, type: !201)
!1237 = !DILocalVariable(name: "format", arg: 2, scope: !1232, file: !2, line: 15, type: !712)
!1238 = !DILocalVariable(name: "args", scope: !1232, file: !2, line: 16, type: !1239)
!1239 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1240, line: 12, baseType: !1241)
!1240 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1241 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !231)
!1242 = !DILocalVariable(name: "buffered", scope: !1232, file: !2, line: 17, type: !201)
!1243 = !DILocalVariable(name: "written", scope: !1232, file: !2, line: 17, type: !201)
!1244 = !DILocalVariable(name: "status", scope: !1232, file: !2, line: 17, type: !201)
!1245 = !DILocalVariable(name: "buffer", scope: !1232, file: !2, line: 18, type: !1246)
!1246 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !1247)
!1247 = !{!1248}
!1248 = !DISubrange(count: 256)
!1249 = distinct !DIAssignID()
!1250 = !DILocation(line: 0, scope: !1232)
!1251 = distinct !DIAssignID()
!1252 = !DILocation(line: 16, column: 3, scope: !1232)
!1253 = !DILocation(line: 18, column: 3, scope: !1232)
!1254 = !DILocation(line: 19, column: 3, scope: !1232)
!1255 = !DILocation(line: 20, column: 66, scope: !1232)
!1256 = !DILocation(line: 20, column: 14, scope: !1232)
!1257 = !DILocation(line: 21, column: 3, scope: !1232)
!1258 = !DILocation(line: 22, column: 3, scope: !1259)
!1259 = distinct !DILexicalBlock(scope: !1260, file: !2, line: 22, column: 3)
!1260 = distinct !DILexicalBlock(scope: !1232, file: !2, line: 22, column: 3)
!1261 = !DILocation(line: 24, column: 16, scope: !1232)
!1262 = !DILocation(line: 24, column: 3, scope: !1232)
!1263 = !DILocation(line: 27, column: 13, scope: !1264)
!1264 = distinct !DILexicalBlock(scope: !1232, file: !2, line: 24, column: 27)
!1265 = distinct !{!1265, !1262, !1266, !404, !405}
!1266 = !DILocation(line: 28, column: 3, scope: !1232)
!1267 = !DILocation(line: 25, column: 25, scope: !1264)
!1268 = !DILocation(line: 25, column: 50, scope: !1264)
!1269 = !DILocation(line: 25, column: 42, scope: !1264)
!1270 = !DILocation(line: 25, column: 14, scope: !1264)
!1271 = !DILocation(line: 26, column: 5, scope: !1272)
!1272 = distinct !DILexicalBlock(scope: !1273, file: !2, line: 26, column: 5)
!1273 = distinct !DILexicalBlock(scope: !1264, file: !2, line: 26, column: 5)
!1274 = !DILocation(line: 29, column: 3, scope: !1275)
!1275 = distinct !DILexicalBlock(scope: !1276, file: !2, line: 29, column: 3)
!1276 = distinct !DILexicalBlock(scope: !1232, file: !2, line: 29, column: 3)
!1277 = !DILocation(line: 31, column: 1, scope: !1232)
!1278 = !DILocation(line: 30, column: 3, scope: !1232)
!1279 = !DISubprogram(name: "vsnprintf", scope: !833, file: !833, line: 389, type: !1280, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1280 = !DISubroutineType(types: !1281)
!1281 = !{!201, !825, !721, !826, !1282}
!1282 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1283, line: 12, baseType: !1241)
!1283 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1284 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1285, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1287)
!1285 = !DISubroutineType(types: !1286)
!1286 = !{!201, !201, !893, !201}
!1287 = !{!1288, !1289, !1290, !1291}
!1288 = !DILocalVariable(name: "fd", arg: 1, scope: !1284, file: !2, line: 178, type: !201)
!1289 = !DILocalVariable(name: "arr", arg: 2, scope: !1284, file: !2, line: 178, type: !893)
!1290 = !DILocalVariable(name: "n", arg: 3, scope: !1284, file: !2, line: 178, type: !201)
!1291 = !DILocalVariable(name: "i", scope: !1284, file: !2, line: 178, type: !201)
!1292 = !DILocation(line: 0, scope: !1284)
!1293 = !DILocation(line: 178, column: 1, scope: !1294)
!1294 = distinct !DILexicalBlock(scope: !1295, file: !2, line: 178, column: 1)
!1295 = distinct !DILexicalBlock(scope: !1284, file: !2, line: 178, column: 1)
!1296 = !DILocation(line: 178, column: 1, scope: !1297)
!1297 = distinct !DILexicalBlock(scope: !1298, file: !2, line: 178, column: 1)
!1298 = distinct !DILexicalBlock(scope: !1284, file: !2, line: 178, column: 1)
!1299 = !DILocation(line: 178, column: 1, scope: !1298)
!1300 = !DILocation(line: 178, column: 1, scope: !1301)
!1301 = distinct !DILexicalBlock(scope: !1297, file: !2, line: 178, column: 1)
!1302 = distinct !{!1302, !1299, !1299, !404, !405}
!1303 = !DILocation(line: 178, column: 1, scope: !1284)
!1304 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1305, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1307)
!1305 = !DISubroutineType(types: !1306)
!1306 = !{!201, !201, !924, !201}
!1307 = !{!1308, !1309, !1310, !1311}
!1308 = !DILocalVariable(name: "fd", arg: 1, scope: !1304, file: !2, line: 179, type: !201)
!1309 = !DILocalVariable(name: "arr", arg: 2, scope: !1304, file: !2, line: 179, type: !924)
!1310 = !DILocalVariable(name: "n", arg: 3, scope: !1304, file: !2, line: 179, type: !201)
!1311 = !DILocalVariable(name: "i", scope: !1304, file: !2, line: 179, type: !201)
!1312 = !DILocation(line: 0, scope: !1304)
!1313 = !DILocation(line: 179, column: 1, scope: !1314)
!1314 = distinct !DILexicalBlock(scope: !1315, file: !2, line: 179, column: 1)
!1315 = distinct !DILexicalBlock(scope: !1304, file: !2, line: 179, column: 1)
!1316 = !DILocation(line: 179, column: 1, scope: !1317)
!1317 = distinct !DILexicalBlock(scope: !1318, file: !2, line: 179, column: 1)
!1318 = distinct !DILexicalBlock(scope: !1304, file: !2, line: 179, column: 1)
!1319 = !DILocation(line: 179, column: 1, scope: !1318)
!1320 = !DILocation(line: 179, column: 1, scope: !1321)
!1321 = distinct !DILexicalBlock(scope: !1317, file: !2, line: 179, column: 1)
!1322 = distinct !{!1322, !1319, !1319, !404, !405}
!1323 = !DILocation(line: 179, column: 1, scope: !1304)
!1324 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1325, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1327)
!1325 = !DISubroutineType(types: !1326)
!1326 = !{!201, !201, !953, !201}
!1327 = !{!1328, !1329, !1330, !1331}
!1328 = !DILocalVariable(name: "fd", arg: 1, scope: !1324, file: !2, line: 180, type: !201)
!1329 = !DILocalVariable(name: "arr", arg: 2, scope: !1324, file: !2, line: 180, type: !953)
!1330 = !DILocalVariable(name: "n", arg: 3, scope: !1324, file: !2, line: 180, type: !201)
!1331 = !DILocalVariable(name: "i", scope: !1324, file: !2, line: 180, type: !201)
!1332 = !DILocation(line: 0, scope: !1324)
!1333 = !DILocation(line: 180, column: 1, scope: !1334)
!1334 = distinct !DILexicalBlock(scope: !1335, file: !2, line: 180, column: 1)
!1335 = distinct !DILexicalBlock(scope: !1324, file: !2, line: 180, column: 1)
!1336 = !DILocation(line: 180, column: 1, scope: !1337)
!1337 = distinct !DILexicalBlock(scope: !1338, file: !2, line: 180, column: 1)
!1338 = distinct !DILexicalBlock(scope: !1324, file: !2, line: 180, column: 1)
!1339 = !DILocation(line: 180, column: 1, scope: !1338)
!1340 = !DILocation(line: 180, column: 1, scope: !1341)
!1341 = distinct !DILexicalBlock(scope: !1337, file: !2, line: 180, column: 1)
!1342 = distinct !{!1342, !1339, !1339, !404, !405}
!1343 = !DILocation(line: 180, column: 1, scope: !1324)
!1344 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1345, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1347)
!1345 = !DISubroutineType(types: !1346)
!1346 = !{!201, !201, !984, !201}
!1347 = !{!1348, !1349, !1350, !1351}
!1348 = !DILocalVariable(name: "fd", arg: 1, scope: !1344, file: !2, line: 181, type: !201)
!1349 = !DILocalVariable(name: "arr", arg: 2, scope: !1344, file: !2, line: 181, type: !984)
!1350 = !DILocalVariable(name: "n", arg: 3, scope: !1344, file: !2, line: 181, type: !201)
!1351 = !DILocalVariable(name: "i", scope: !1344, file: !2, line: 181, type: !201)
!1352 = !DILocation(line: 0, scope: !1344)
!1353 = !DILocation(line: 181, column: 1, scope: !1354)
!1354 = distinct !DILexicalBlock(scope: !1355, file: !2, line: 181, column: 1)
!1355 = distinct !DILexicalBlock(scope: !1344, file: !2, line: 181, column: 1)
!1356 = !DILocation(line: 181, column: 1, scope: !1357)
!1357 = distinct !DILexicalBlock(scope: !1358, file: !2, line: 181, column: 1)
!1358 = distinct !DILexicalBlock(scope: !1344, file: !2, line: 181, column: 1)
!1359 = !DILocation(line: 181, column: 1, scope: !1358)
!1360 = !DILocation(line: 181, column: 1, scope: !1361)
!1361 = distinct !DILexicalBlock(scope: !1357, file: !2, line: 181, column: 1)
!1362 = distinct !{!1362, !1359, !1359, !404, !405}
!1363 = !DILocation(line: 181, column: 1, scope: !1344)
!1364 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1365, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1367)
!1365 = !DISubroutineType(types: !1366)
!1366 = !{!201, !201, !1013, !201}
!1367 = !{!1368, !1369, !1370, !1371}
!1368 = !DILocalVariable(name: "fd", arg: 1, scope: !1364, file: !2, line: 182, type: !201)
!1369 = !DILocalVariable(name: "arr", arg: 2, scope: !1364, file: !2, line: 182, type: !1013)
!1370 = !DILocalVariable(name: "n", arg: 3, scope: !1364, file: !2, line: 182, type: !201)
!1371 = !DILocalVariable(name: "i", scope: !1364, file: !2, line: 182, type: !201)
!1372 = !DILocation(line: 0, scope: !1364)
!1373 = !DILocation(line: 182, column: 1, scope: !1374)
!1374 = distinct !DILexicalBlock(scope: !1375, file: !2, line: 182, column: 1)
!1375 = distinct !DILexicalBlock(scope: !1364, file: !2, line: 182, column: 1)
!1376 = !DILocation(line: 182, column: 1, scope: !1377)
!1377 = distinct !DILexicalBlock(scope: !1378, file: !2, line: 182, column: 1)
!1378 = distinct !DILexicalBlock(scope: !1364, file: !2, line: 182, column: 1)
!1379 = !DILocation(line: 182, column: 1, scope: !1378)
!1380 = !DILocation(line: 182, column: 1, scope: !1381)
!1381 = distinct !DILexicalBlock(scope: !1377, file: !2, line: 182, column: 1)
!1382 = distinct !{!1382, !1379, !1379, !404, !405}
!1383 = !DILocation(line: 182, column: 1, scope: !1364)
!1384 = !DILocation(line: 0, scope: !528)
!1385 = !DILocation(line: 183, column: 1, scope: !1386)
!1386 = distinct !DILexicalBlock(scope: !1387, file: !2, line: 183, column: 1)
!1387 = distinct !DILexicalBlock(scope: !528, file: !2, line: 183, column: 1)
!1388 = !DILocation(line: 183, column: 1, scope: !541)
!1389 = !DILocation(line: 183, column: 1, scope: !538)
!1390 = !DILocation(line: 183, column: 1, scope: !540)
!1391 = distinct !{!1391, !1389, !1389, !404, !405}
!1392 = !DILocation(line: 183, column: 1, scope: !528)
!1393 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1394, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1396)
!1394 = !DISubroutineType(types: !1395)
!1395 = !{!201, !201, !1070, !201}
!1396 = !{!1397, !1398, !1399, !1400}
!1397 = !DILocalVariable(name: "fd", arg: 1, scope: !1393, file: !2, line: 184, type: !201)
!1398 = !DILocalVariable(name: "arr", arg: 2, scope: !1393, file: !2, line: 184, type: !1070)
!1399 = !DILocalVariable(name: "n", arg: 3, scope: !1393, file: !2, line: 184, type: !201)
!1400 = !DILocalVariable(name: "i", scope: !1393, file: !2, line: 184, type: !201)
!1401 = !DILocation(line: 0, scope: !1393)
!1402 = !DILocation(line: 184, column: 1, scope: !1403)
!1403 = distinct !DILexicalBlock(scope: !1404, file: !2, line: 184, column: 1)
!1404 = distinct !DILexicalBlock(scope: !1393, file: !2, line: 184, column: 1)
!1405 = !DILocation(line: 184, column: 1, scope: !1406)
!1406 = distinct !DILexicalBlock(scope: !1407, file: !2, line: 184, column: 1)
!1407 = distinct !DILexicalBlock(scope: !1393, file: !2, line: 184, column: 1)
!1408 = !DILocation(line: 184, column: 1, scope: !1407)
!1409 = !DILocation(line: 184, column: 1, scope: !1410)
!1410 = distinct !DILexicalBlock(scope: !1406, file: !2, line: 184, column: 1)
!1411 = distinct !{!1411, !1408, !1408, !404, !405}
!1412 = !DILocation(line: 184, column: 1, scope: !1393)
!1413 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1414, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1416)
!1414 = !DISubroutineType(types: !1415)
!1415 = !{!201, !201, !1099, !201}
!1416 = !{!1417, !1418, !1419, !1420}
!1417 = !DILocalVariable(name: "fd", arg: 1, scope: !1413, file: !2, line: 186, type: !201)
!1418 = !DILocalVariable(name: "arr", arg: 2, scope: !1413, file: !2, line: 186, type: !1099)
!1419 = !DILocalVariable(name: "n", arg: 3, scope: !1413, file: !2, line: 186, type: !201)
!1420 = !DILocalVariable(name: "i", scope: !1413, file: !2, line: 186, type: !201)
!1421 = !DILocation(line: 0, scope: !1413)
!1422 = !DILocation(line: 186, column: 1, scope: !1423)
!1423 = distinct !DILexicalBlock(scope: !1424, file: !2, line: 186, column: 1)
!1424 = distinct !DILexicalBlock(scope: !1413, file: !2, line: 186, column: 1)
!1425 = !DILocation(line: 186, column: 1, scope: !1426)
!1426 = distinct !DILexicalBlock(scope: !1427, file: !2, line: 186, column: 1)
!1427 = distinct !DILexicalBlock(scope: !1413, file: !2, line: 186, column: 1)
!1428 = !DILocation(line: 186, column: 1, scope: !1427)
!1429 = !DILocation(line: 186, column: 1, scope: !1430)
!1430 = distinct !DILexicalBlock(scope: !1426, file: !2, line: 186, column: 1)
!1431 = distinct !{!1431, !1428, !1428, !404, !405}
!1432 = !DILocation(line: 186, column: 1, scope: !1413)
!1433 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !1434, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !228, retainedNodes: !1436)
!1434 = !DISubroutineType(types: !1435)
!1435 = !{!201, !201, !1133, !201}
!1436 = !{!1437, !1438, !1439, !1440}
!1437 = !DILocalVariable(name: "fd", arg: 1, scope: !1433, file: !2, line: 187, type: !201)
!1438 = !DILocalVariable(name: "arr", arg: 2, scope: !1433, file: !2, line: 187, type: !1133)
!1439 = !DILocalVariable(name: "n", arg: 3, scope: !1433, file: !2, line: 187, type: !201)
!1440 = !DILocalVariable(name: "i", scope: !1433, file: !2, line: 187, type: !201)
!1441 = !DILocation(line: 0, scope: !1433)
!1442 = !DILocation(line: 187, column: 1, scope: !1443)
!1443 = distinct !DILexicalBlock(scope: !1444, file: !2, line: 187, column: 1)
!1444 = distinct !DILexicalBlock(scope: !1433, file: !2, line: 187, column: 1)
!1445 = !DILocation(line: 187, column: 1, scope: !1446)
!1446 = distinct !DILexicalBlock(scope: !1447, file: !2, line: 187, column: 1)
!1447 = distinct !DILexicalBlock(scope: !1433, file: !2, line: 187, column: 1)
!1448 = !DILocation(line: 187, column: 1, scope: !1447)
!1449 = !DILocation(line: 187, column: 1, scope: !1450)
!1450 = distinct !DILexicalBlock(scope: !1446, file: !2, line: 187, column: 1)
!1451 = distinct !{!1451, !1448, !1448, !404, !405}
!1452 = !DILocation(line: 187, column: 1, scope: !1433)
!1453 = !DILocation(line: 0, scope: !517)
!1454 = !DILocation(line: 190, column: 3, scope: !524)
!1455 = !DILocation(line: 191, column: 3, scope: !517)
!1456 = !DILocation(line: 192, column: 3, scope: !517)
!1457 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1458, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !290, retainedNodes: !1460)
!1458 = !DISubroutineType(types: !1459)
!1459 = !{!201, !201, !831}
!1460 = !{!1461, !1462, !1463, !1464, !1465, !1466, !1467, !1468, !1469}
!1461 = !DILocalVariable(name: "argc", arg: 1, scope: !1457, file: !170, line: 14, type: !201)
!1462 = !DILocalVariable(name: "argv", arg: 2, scope: !1457, file: !170, line: 14, type: !831)
!1463 = !DILocalVariable(name: "in_file", scope: !1457, file: !170, line: 17, type: !230)
!1464 = !DILocalVariable(name: "check_file", scope: !1457, file: !170, line: 19, type: !230)
!1465 = !DILocalVariable(name: "in_fd", scope: !1457, file: !170, line: 34, type: !201)
!1466 = !DILocalVariable(name: "data", scope: !1457, file: !170, line: 35, type: !230)
!1467 = !DILocalVariable(name: "out_fd", scope: !1457, file: !170, line: 46, type: !201)
!1468 = !DILocalVariable(name: "check_fd", scope: !1457, file: !170, line: 55, type: !201)
!1469 = !DILocalVariable(name: "ref", scope: !1457, file: !170, line: 56, type: !230)
!1470 = !DILocation(line: 0, scope: !1457)
!1471 = !DILocation(line: 21, column: 3, scope: !1472)
!1472 = distinct !DILexicalBlock(scope: !1473, file: !170, line: 21, column: 3)
!1473 = distinct !DILexicalBlock(scope: !1457, file: !170, line: 21, column: 3)
!1474 = !DILocation(line: 26, column: 11, scope: !1475)
!1475 = distinct !DILexicalBlock(scope: !1457, file: !170, line: 26, column: 7)
!1476 = !DILocation(line: 26, column: 7, scope: !1457)
!1477 = !DILocation(line: 27, column: 15, scope: !1475)
!1478 = !DILocation(line: 29, column: 11, scope: !1479)
!1479 = distinct !DILexicalBlock(scope: !1457, file: !170, line: 29, column: 7)
!1480 = !DILocation(line: 29, column: 7, scope: !1457)
!1481 = !DILocation(line: 30, column: 18, scope: !1479)
!1482 = !DILocation(line: 30, column: 5, scope: !1479)
!1483 = !DILocation(line: 36, column: 17, scope: !1457)
!1484 = !DILocation(line: 36, column: 10, scope: !1457)
!1485 = !DILocation(line: 37, column: 3, scope: !1486)
!1486 = distinct !DILexicalBlock(scope: !1487, file: !170, line: 37, column: 3)
!1487 = distinct !DILexicalBlock(scope: !1457, file: !170, line: 37, column: 3)
!1488 = !DILocation(line: 38, column: 11, scope: !1457)
!1489 = !DILocation(line: 39, column: 3, scope: !1490)
!1490 = distinct !DILexicalBlock(scope: !1491, file: !170, line: 39, column: 3)
!1491 = distinct !DILexicalBlock(scope: !1457, file: !170, line: 39, column: 3)
!1492 = !DILocation(line: 0, scope: !464, inlinedAt: !1493)
!1493 = distinct !DILocation(line: 40, column: 3, scope: !1457)
!1494 = !DILocation(line: 20, column: 3, scope: !464, inlinedAt: !1493)
!1495 = !DILocation(line: 22, column: 7, scope: !464, inlinedAt: !1493)
!1496 = !DILocation(line: 0, scope: !477, inlinedAt: !1497)
!1497 = distinct !DILocation(line: 24, column: 7, scope: !464, inlinedAt: !1493)
!1498 = !DILocation(line: 64, column: 17, scope: !477, inlinedAt: !1497)
!1499 = !DILocation(line: 64, column: 3, scope: !477, inlinedAt: !1497)
!1500 = !DILocation(line: 66, column: 22, scope: !489, inlinedAt: !1497)
!1501 = !DILocation(line: 66, column: 26, scope: !489, inlinedAt: !1497)
!1502 = !DILocation(line: 66, column: 32, scope: !489, inlinedAt: !1497)
!1503 = !DILocation(line: 66, column: 35, scope: !489, inlinedAt: !1497)
!1504 = !DILocation(line: 66, column: 39, scope: !489, inlinedAt: !1497)
!1505 = !DILocation(line: 66, column: 9, scope: !490, inlinedAt: !1497)
!1506 = !DILocation(line: 69, column: 6, scope: !490, inlinedAt: !1497)
!1507 = !DILocation(line: 64, column: 10, scope: !477, inlinedAt: !1497)
!1508 = !DILocation(line: 64, column: 13, scope: !477, inlinedAt: !1497)
!1509 = distinct !{!1509, !1499, !1510, !404, !405}
!1510 = !DILocation(line: 70, column: 3, scope: !477, inlinedAt: !1497)
!1511 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !1497)
!1512 = !DILocation(line: 71, column: 8, scope: !502, inlinedAt: !1497)
!1513 = !DILocation(line: 71, column: 6, scope: !477, inlinedAt: !1497)
!1514 = !DILocation(line: 25, column: 3, scope: !464, inlinedAt: !1493)
!1515 = !DILocation(line: 26, column: 3, scope: !464, inlinedAt: !1493)
!1516 = !DILocation(line: 0, scope: !455, inlinedAt: !1517)
!1517 = distinct !DILocation(line: 43, column: 3, scope: !1457)
!1518 = !DILocation(line: 8, column: 3, scope: !455, inlinedAt: !1517)
!1519 = !DILocation(line: 47, column: 12, scope: !1457)
!1520 = !DILocation(line: 48, column: 3, scope: !1521)
!1521 = distinct !DILexicalBlock(scope: !1522, file: !170, line: 48, column: 3)
!1522 = distinct !DILexicalBlock(scope: !1457, file: !170, line: 48, column: 3)
!1523 = !DILocation(line: 0, scope: !576, inlinedAt: !1524)
!1524 = distinct !DILocation(line: 49, column: 3, scope: !1457)
!1525 = !DILocation(line: 0, scope: !517, inlinedAt: !1526)
!1526 = distinct !DILocation(line: 57, column: 3, scope: !576, inlinedAt: !1524)
!1527 = !DILocation(line: 190, column: 3, scope: !524, inlinedAt: !1526)
!1528 = !DILocation(line: 191, column: 3, scope: !517, inlinedAt: !1526)
!1529 = !DILocation(line: 0, scope: !528, inlinedAt: !1530)
!1530 = distinct !DILocation(line: 58, column: 3, scope: !576, inlinedAt: !1524)
!1531 = !DILocation(line: 183, column: 1, scope: !538, inlinedAt: !1530)
!1532 = !DILocation(line: 183, column: 1, scope: !540, inlinedAt: !1530)
!1533 = !DILocation(line: 183, column: 1, scope: !541, inlinedAt: !1530)
!1534 = distinct !{!1534, !1531, !1531, !404, !405}
!1535 = !DILocation(line: 50, column: 3, scope: !1457)
!1536 = !DILocation(line: 57, column: 16, scope: !1457)
!1537 = !DILocation(line: 57, column: 9, scope: !1457)
!1538 = !DILocation(line: 58, column: 3, scope: !1539)
!1539 = distinct !DILexicalBlock(scope: !1540, file: !170, line: 58, column: 3)
!1540 = distinct !DILexicalBlock(scope: !1457, file: !170, line: 58, column: 3)
!1541 = !DILocation(line: 59, column: 14, scope: !1457)
!1542 = !DILocation(line: 60, column: 3, scope: !1543)
!1543 = distinct !DILexicalBlock(scope: !1544, file: !170, line: 60, column: 3)
!1544 = distinct !DILexicalBlock(scope: !1457, file: !170, line: 60, column: 3)
!1545 = !DILocation(line: 0, scope: !545, inlinedAt: !1546)
!1546 = distinct !DILocation(line: 61, column: 3, scope: !1457)
!1547 = !DILocation(line: 45, column: 3, scope: !545, inlinedAt: !1546)
!1548 = !DILocation(line: 47, column: 7, scope: !545, inlinedAt: !1546)
!1549 = !DILocation(line: 0, scope: !477, inlinedAt: !1550)
!1550 = distinct !DILocation(line: 49, column: 7, scope: !545, inlinedAt: !1546)
!1551 = !DILocation(line: 64, column: 17, scope: !477, inlinedAt: !1550)
!1552 = !DILocation(line: 64, column: 3, scope: !477, inlinedAt: !1550)
!1553 = !DILocation(line: 66, column: 22, scope: !489, inlinedAt: !1550)
!1554 = !DILocation(line: 66, column: 26, scope: !489, inlinedAt: !1550)
!1555 = !DILocation(line: 66, column: 32, scope: !489, inlinedAt: !1550)
!1556 = !DILocation(line: 66, column: 35, scope: !489, inlinedAt: !1550)
!1557 = !DILocation(line: 66, column: 39, scope: !489, inlinedAt: !1550)
!1558 = !DILocation(line: 66, column: 9, scope: !490, inlinedAt: !1550)
!1559 = !DILocation(line: 69, column: 6, scope: !490, inlinedAt: !1550)
!1560 = !DILocation(line: 64, column: 10, scope: !477, inlinedAt: !1550)
!1561 = !DILocation(line: 64, column: 13, scope: !477, inlinedAt: !1550)
!1562 = distinct !{!1562, !1552, !1563, !404, !405}
!1563 = !DILocation(line: 70, column: 3, scope: !477, inlinedAt: !1550)
!1564 = !DILocation(line: 71, column: 6, scope: !502, inlinedAt: !1550)
!1565 = !DILocation(line: 71, column: 8, scope: !502, inlinedAt: !1550)
!1566 = !DILocation(line: 71, column: 6, scope: !477, inlinedAt: !1550)
!1567 = !DILocation(line: 50, column: 3, scope: !545, inlinedAt: !1546)
!1568 = !DILocation(line: 51, column: 3, scope: !545, inlinedAt: !1546)
!1569 = !DILocation(line: 0, scope: !593, inlinedAt: !1570)
!1570 = distinct !DILocation(line: 66, column: 8, scope: !1571)
!1571 = distinct !DILexicalBlock(scope: !1457, file: !170, line: 66, column: 7)
!1572 = !DILocation(line: 69, column: 14, scope: !593, inlinedAt: !1570)
!1573 = !DILocation(line: 70, column: 13, scope: !593, inlinedAt: !1570)
!1574 = !DILocation(line: 71, column: 3, scope: !609, inlinedAt: !1570)
!1575 = !DILocation(line: 72, column: 34, scope: !611, inlinedAt: !1570)
!1576 = !DILocation(line: 72, column: 32, scope: !611, inlinedAt: !1570)
!1577 = !DILocation(line: 72, column: 16, scope: !611, inlinedAt: !1570)
!1578 = !DILocation(line: 73, column: 14, scope: !611, inlinedAt: !1570)
!1579 = !DILocation(line: 74, column: 16, scope: !611, inlinedAt: !1570)
!1580 = !DILocation(line: 74, column: 13, scope: !611, inlinedAt: !1570)
!1581 = !DILocation(line: 71, column: 22, scope: !612, inlinedAt: !1570)
!1582 = !DILocation(line: 71, column: 14, scope: !612, inlinedAt: !1570)
!1583 = distinct !{!1583, !1574, !1584, !404, !405}
!1584 = !DILocation(line: 75, column: 3, scope: !609, inlinedAt: !1570)
!1585 = !DILocation(line: 76, column: 26, scope: !593, inlinedAt: !1570)
!1586 = !DILocation(line: 76, column: 14, scope: !593, inlinedAt: !1570)
!1587 = !DILocation(line: 79, column: 10, scope: !593, inlinedAt: !1570)
!1588 = !DILocation(line: 66, column: 7, scope: !1457)
!1589 = !DILocation(line: 67, column: 13, scope: !1590)
!1590 = distinct !DILexicalBlock(scope: !1571, file: !170, line: 66, column: 32)
!1591 = !DILocation(line: 67, column: 5, scope: !1590)
!1592 = !DILocation(line: 68, column: 5, scope: !1590)
!1593 = !DILocation(line: 71, column: 3, scope: !1457)
!1594 = !DILocation(line: 72, column: 3, scope: !1457)
!1595 = !DILocation(line: 74, column: 3, scope: !1457)
!1596 = !DILocation(line: 75, column: 3, scope: !1457)
!1597 = !DILocation(line: 76, column: 1, scope: !1457)
!1598 = !DISubprogram(name: "open", scope: !1599, file: !1599, line: 209, type: !1600, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1599 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1600 = !DISubroutineType(types: !1601)
!1601 = !{!201, !712, !201, null}
