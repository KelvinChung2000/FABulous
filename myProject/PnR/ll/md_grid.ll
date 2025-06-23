; ModuleID = 'md/grid/md_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.dvector_t = type { double, double, double }
%struct.bench_args_t = type { [4 x [4 x [4 x i32]]], [4 x [4 x [4 x [10 x %struct.dvector_t]]]], [4 x [4 x [4 x [10 x %struct.dvector_t]]]] }
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
@INPUT_SIZE = dso_local local_unnamed_addr global i32 30976, align 4, !dbg !186
@.str.6.18 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !218
@.str.8.19 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !221
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !224
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !229
@.str.12.20 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !232
@.str.14.21 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !234
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !237
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @md(ptr nocapture noundef readonly %n_points, ptr nocapture noundef %force, ptr nocapture noundef readonly %position) local_unnamed_addr #0 !dbg !334 {
entry.split:
  %.reg2mem89 = alloca i64, align 8
  %.reg2mem91 = alloca i64, align 8
  %indvars.iv361.reg2mem = alloca i64, align 8
  %.reg2mem99 = alloca i64, align 8
  %.reg2mem101 = alloca i64, align 8
  %indvars.iv364.reg2mem = alloca i64, align 8
  %sum_z.1.us.us.us.us.reg2mem109 = alloca double, align 8
  %sum_y.1.us.us.us.us.reg2mem111 = alloca double, align 8
  %sum_x.1.us.us.us.us.reg2mem113 = alloca double, align 8
  %sum_x.0330.us.us.us.us.reg2mem115 = alloca double, align 8
  %sum_y.0331.us.us.us.us.reg2mem117 = alloca double, align 8
  %sum_z.0332.us.us.us.us.reg2mem119 = alloca double, align 8
  %indvars.iv.us.us.us.us.reg2mem121 = alloca i64, align 8
  %indvars.iv346.us.us.us.us.reg2mem123 = alloca i64, align 8
  %indvars.iv350.us.us.us.reg2mem125 = alloca i64, align 8
  %indvars.iv353.us11.us.reg2mem127 = alloca i64, align 8
  %indvars.iv356.us19.reg2mem129 = alloca i64, align 8
  %indvars.iv358.reg2mem131 = alloca i64, align 8
  %indvars.iv361.reg2mem133 = alloca i64, align 8
  %indvars.iv364.reg2mem135 = alloca i64, align 8
    #dbg_value(ptr %n_points, !350, !DIExpression(), !407)
    #dbg_value(ptr %force, !351, !DIExpression(), !407)
    #dbg_value(ptr %position, !352, !DIExpression(), !407)
    #dbg_label(!372, !408)
    #dbg_value(i32 0, !353, !DIExpression(DW_OP_LLVM_fragment, 0, 32), !407)
  store i64 0, ptr %indvars.iv364.reg2mem135, align 8
  br label %for.cond2.preheader, !dbg !409

for.cond2.preheader:                              ; preds = %for.inc237.for.cond2.preheader_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv364.reg2mem135.0.load, !353, !DIExpression(DW_OP_LLVM_fragment, 0, 32), !407)
  %indvars.iv364.reg2mem135.0.load = load i64, ptr %indvars.iv364.reg2mem135, align 8
  store i64 %indvars.iv364.reg2mem135.0.load, ptr %indvars.iv364.reg2mem, align 8
  %0 = trunc i64 %indvars.iv364.reg2mem135.0.load to i32
  %smax355 = tail call i32 @llvm.smax.i32(i32 %0, i32 1)
  %1 = zext nneg i32 %smax355 to i64
  %2 = add nsw i64 %1, -1
  store i64 %2, ptr %.reg2mem101, align 8
  %3 = tail call i32 @llvm.umin.i32(i32 %0, i32 2)
  %cond24 = add nuw nsw i32 %3, 2
  %cmp25341.not = icmp ugt i32 %smax355, %cond24
    #dbg_value(i32 0, !353, !DIExpression(DW_OP_LLVM_fragment, 32, 32), !407)
  %4 = zext nneg i32 %cond24 to i64, !dbg !410
  store i64 %4, ptr %.reg2mem99, align 8
  br i1 %cmp25341.not, label %for.cond2.preheader.for.inc237_crit_edge, label %for.cond2.preheader.for.cond6.preheader_crit_edge

for.cond2.preheader.for.cond6.preheader_crit_edge: ; preds = %for.cond2.preheader
  store i64 0, ptr %indvars.iv361.reg2mem133, align 8
  br label %for.cond6.preheader

for.cond2.preheader.for.inc237_crit_edge:         ; preds = %for.cond2.preheader
  br label %for.inc237

for.cond6.preheader:                              ; preds = %for.inc233.split.for.cond6.preheader_crit_edge, %for.cond2.preheader.for.cond6.preheader_crit_edge
    #dbg_value(i64 %indvars.iv361.reg2mem133.0.load, !353, !DIExpression(DW_OP_LLVM_fragment, 32, 32), !407)
    #dbg_value(i32 0, !353, !DIExpression(DW_OP_LLVM_fragment, 64, 32), !407)
  %indvars.iv361.reg2mem133.0.load = load i64, ptr %indvars.iv361.reg2mem133, align 8
  store i64 %indvars.iv361.reg2mem133.0.load, ptr %indvars.iv361.reg2mem, align 8
  %5 = trunc i64 %indvars.iv361.reg2mem133.0.load to i32
  %smax352 = tail call i32 @llvm.smax.i32(i32 %5, i32 1)
  %6 = zext nneg i32 %smax352 to i64
  %7 = add nsw i64 %6, -1
  store i64 %7, ptr %.reg2mem91, align 8
  %8 = tail call i32 @llvm.umin.i32(i32 %5, i32 2)
  %cond47 = add nuw nsw i32 %8, 2
  %cmp48339.not = icmp ugt i32 %smax352, %cond47
  %9 = zext nneg i32 %cond47 to i64, !dbg !411
  store i64 %9, ptr %.reg2mem89, align 8
  br i1 %cmp48339.not, label %for.cond6.preheader.for.inc233.split_crit_edge, label %for.cond6.preheader.loop_grid1_x_crit_edge

for.cond6.preheader.loop_grid1_x_crit_edge:       ; preds = %for.cond6.preheader
  store i64 0, ptr %indvars.iv358.reg2mem131, align 8
  br label %loop_grid1_x

for.cond6.preheader.for.inc233.split_crit_edge:   ; preds = %for.cond6.preheader
  br label %for.inc233.split

loop_grid1_x:                                     ; preds = %for.inc229.loopexit.split.loop_grid1_x_crit_edge, %for.cond6.preheader.loop_grid1_x_crit_edge
    #dbg_value(i64 %indvars.iv358.reg2mem131.0.load, !353, !DIExpression(DW_OP_LLVM_fragment, 64, 32), !407)
    #dbg_label(!381, !412)
    #dbg_value(i32 %smax355, !360, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value, DW_OP_LLVM_fragment, 0, 32), !407)
  %indvars.iv358.reg2mem131.0.load = load i64, ptr %indvars.iv358.reg2mem131, align 8
  %10 = trunc i64 %indvars.iv358.reg2mem131.0.load to i32, !dbg !413
  %smax = tail call i32 @llvm.smax.i32(i32 %10, i32 1), !dbg !413
  %11 = zext nneg i32 %smax to i64, !dbg !413
  %12 = add nsw i64 %11, -1, !dbg !413
  %13 = tail call i32 @llvm.umin.i32(i32 %10, i32 2)
  %cond70 = add nuw nsw i32 %13, 2
  %cmp71337.not = icmp ugt i32 %smax, %cond70
  %14 = zext nneg i32 %cond70 to i64, !dbg !413
  br i1 %cmp71337.not, label %loop_grid1_x.for.inc229.loopexit.split_crit_edge, label %loop_grid1_y.lr.ph.split.split

loop_grid1_x.for.inc229.loopexit.split_crit_edge: ; preds = %loop_grid1_x
  br label %for.inc229.loopexit.split

loop_grid1_y.lr.ph.split.split:                   ; preds = %loop_grid1_x
  %indvars.iv361.reg2mem.0.load147 = load i64, ptr %indvars.iv361.reg2mem, align 8
  %indvars.iv364.reg2mem.0.load141 = load i64, ptr %indvars.iv364.reg2mem, align 8
  %arrayidx98 = getelementptr inbounds [4 x [4 x i32]], ptr %n_points, i64 %indvars.iv364.reg2mem.0.load141, i64 %indvars.iv361.reg2mem.0.load147, i64 %indvars.iv358.reg2mem131.0.load
  %15 = load i32, ptr %arrayidx98, align 4, !tbaa !414
  %cmp99335 = icmp sgt i32 %15, 0
  %wide.trip.count348 = zext nneg i32 %15 to i64
  br i1 %cmp99335, label %loop_grid1_y.lr.ph.split.split.loop_grid1_y.us18_crit_edge, label %loop_grid1_y.lr.ph.split.split.for.inc229.loopexit.split_crit_edge

loop_grid1_y.lr.ph.split.split.for.inc229.loopexit.split_crit_edge: ; preds = %loop_grid1_y.lr.ph.split.split
  br label %for.inc229.loopexit.split

loop_grid1_y.lr.ph.split.split.loop_grid1_y.us18_crit_edge: ; preds = %loop_grid1_y.lr.ph.split.split
  %.reg2mem101.0.load = load i64, ptr %.reg2mem101, align 8
  store i64 %.reg2mem101.0.load, ptr %indvars.iv356.us19.reg2mem129, align 8
  br label %loop_grid1_y.us18

loop_grid1_y.us18:                                ; preds = %for.inc225.loopexit.split.split.us.us.loop_grid1_y.us18_crit_edge, %loop_grid1_y.lr.ph.split.split.loop_grid1_y.us18_crit_edge
    #dbg_value(i64 %indvars.iv356.us19.reg2mem129.0.load, !360, !DIExpression(DW_OP_LLVM_fragment, 0, 32), !407)
    #dbg_label(!385, !418)
    #dbg_value(i32 %smax352, !360, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value, DW_OP_LLVM_fragment, 32, 32), !407)
  %indvars.iv356.us19.reg2mem129.0.load = load i64, ptr %indvars.iv356.us19.reg2mem129, align 8
  %.reg2mem91.0.load = load i64, ptr %.reg2mem91, align 8
  store i64 %.reg2mem91.0.load, ptr %indvars.iv353.us11.us.reg2mem127, align 8
  br label %loop_grid1_z.us10.us, !dbg !419

loop_grid1_z.us10.us:                             ; preds = %for.inc221.loopexit.split.us.us.us.loop_grid1_z.us10.us_crit_edge, %loop_grid1_y.us18
    #dbg_value(i64 %indvars.iv353.us11.us.reg2mem127.0.load, !360, !DIExpression(DW_OP_LLVM_fragment, 32, 32), !407)
    #dbg_label(!389, !420)
    #dbg_value(i32 %smax, !360, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value, DW_OP_LLVM_fragment, 64, 32), !407)
  %indvars.iv353.us11.us.reg2mem127.0.load = load i64, ptr %indvars.iv353.us11.us.reg2mem127, align 8
  store i64 %12, ptr %indvars.iv350.us.us.us.reg2mem125, align 8
  br label %for.body72.us.us.us, !dbg !421

for.body72.us.us.us:                              ; preds = %for.end216.loopexit.us.us.us.for.body72.us.us.us_crit_edge, %loop_grid1_z.us10.us
    #dbg_value(i64 %indvars.iv350.us.us.us.reg2mem125.0.load, !360, !DIExpression(DW_OP_LLVM_fragment, 64, 32), !407)
  %indvars.iv350.us.us.us.reg2mem125.0.load = load i64, ptr %indvars.iv350.us.us.us.reg2mem125, align 8
  %arrayidx79.us.us.us = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], ptr %position, i64 %indvars.iv356.us19.reg2mem129.0.load, i64 %indvars.iv353.us11.us.reg2mem127.0.load, i64 %indvars.iv350.us.us.us.reg2mem125.0.load, !dbg !422
    #dbg_value(ptr %arrayidx79.us.us.us, !393, !DIExpression(), !423)
    #dbg_value(i32 poison, !398, !DIExpression(), !423)
    #dbg_label(!399, !424)
    #dbg_value(i32 0, !363, !DIExpression(), !407)
  %arrayidx88.us.us.us = getelementptr inbounds [4 x [4 x i32]], ptr %n_points, i64 %indvars.iv356.us19.reg2mem129.0.load, i64 %indvars.iv353.us11.us.reg2mem127.0.load, i64 %indvars.iv350.us.us.us.reg2mem125.0.load, !dbg !425
  %16 = load i32, ptr %arrayidx88.us.us.us, align 4, !dbg !425, !tbaa !414
    #dbg_value(i32 %16, !398, !DIExpression(), !423)
  %cmp149328.us.us.us = icmp sgt i32 %16, 0
  %wide.trip.count.us.us.us = zext nneg i32 %16 to i64
  br i1 %cmp149328.us.us.us, label %for.body72.us.us.us.for.body100.us.us.us.us_crit_edge, label %for.body72.us.us.us.for.end216.loopexit.us.us.us_crit_edge

for.body72.us.us.us.for.end216.loopexit.us.us.us_crit_edge: ; preds = %for.body72.us.us.us
  br label %for.end216.loopexit.us.us.us

for.body72.us.us.us.for.body100.us.us.us.us_crit_edge: ; preds = %for.body72.us.us.us
  store i64 0, ptr %indvars.iv346.us.us.us.us.reg2mem123, align 8
  br label %for.body100.us.us.us.us

for.end216.loopexit.us.us.us:                     ; preds = %for.end.loopexit.us.us.us.us.for.end216.loopexit.us.us.us_crit_edge, %for.body72.us.us.us.for.end216.loopexit.us.us.us_crit_edge
  %indvars.iv.next351.us.us.us = add nuw nsw i64 %indvars.iv350.us.us.us.reg2mem125.0.load, 1, !dbg !426
    #dbg_value(i64 %indvars.iv.next351.us.us.us, !360, !DIExpression(DW_OP_LLVM_fragment, 64, 32), !407)
  %cmp71.us.us.us = icmp ult i64 %indvars.iv.next351.us.us.us, %14, !dbg !427
  br i1 %cmp71.us.us.us, label %for.end216.loopexit.us.us.us.for.body72.us.us.us_crit_edge, label %for.inc221.loopexit.split.us.us.us, !dbg !421, !llvm.loop !428

for.end216.loopexit.us.us.us.for.body72.us.us.us_crit_edge: ; preds = %for.end216.loopexit.us.us.us
  store i64 %indvars.iv.next351.us.us.us, ptr %indvars.iv350.us.us.us.reg2mem125, align 8
  br label %for.body72.us.us.us, !dbg !421

for.body100.us.us.us.us:                          ; preds = %for.end.loopexit.us.us.us.us.for.body100.us.us.us.us_crit_edge, %for.body72.us.us.us.for.body100.us.us.us.us_crit_edge
    #dbg_value(i64 %indvars.iv346.us.us.us.us.reg2mem123.0.load, !363, !DIExpression(), !407)
  %indvars.iv346.us.us.us.us.reg2mem123.0.load = load i64, ptr %indvars.iv346.us.us.us.us.reg2mem123, align 8
  %arrayidx111.us.us.us.us = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], ptr %position, i64 %indvars.iv364.reg2mem.0.load141, i64 %indvars.iv361.reg2mem.0.load147, i64 %indvars.iv358.reg2mem131.0.load, i64 %indvars.iv346.us.us.us.us.reg2mem123.0.load, !dbg !432
  %p.sroa.0.0.copyload.us.us.us.us = load double, ptr %arrayidx111.us.us.us.us, align 8, !dbg !432
  %p.sroa.5.0.arrayidx111.sroa_idx.us.us.us.us = getelementptr inbounds i8, ptr %arrayidx111.us.us.us.us, i64 8, !dbg !432
  %p.sroa.5.0.copyload.us.us.us.us = load double, ptr %p.sroa.5.0.arrayidx111.sroa_idx.us.us.us.us, align 8, !dbg !432
  %p.sroa.7.0.arrayidx111.sroa_idx.us.us.us.us = getelementptr inbounds i8, ptr %arrayidx111.us.us.us.us, i64 16, !dbg !432
  %p.sroa.7.0.copyload.us.us.us.us = load double, ptr %p.sroa.7.0.arrayidx111.sroa_idx.us.us.us.us, align 8, !dbg !432
    #dbg_value(double %p.sroa.0.0.copyload.us.us.us.us, !361, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !407)
    #dbg_value(double %p.sroa.5.0.copyload.us.us.us.us, !361, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !407)
    #dbg_value(double %p.sroa.7.0.copyload.us.us.us.us, !361, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !407)
  %arrayidx122.us.us.us.us = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], ptr %force, i64 %indvars.iv364.reg2mem.0.load141, i64 %indvars.iv361.reg2mem.0.load147, i64 %indvars.iv358.reg2mem131.0.load, i64 %indvars.iv346.us.us.us.us.reg2mem123.0.load, !dbg !433
  %17 = load double, ptr %arrayidx122.us.us.us.us, align 8, !dbg !434
    #dbg_value(double %17, !400, !DIExpression(), !435)
  %y135.us.us.us.us = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], ptr %force, i64 %indvars.iv364.reg2mem.0.load141, i64 %indvars.iv361.reg2mem.0.load147, i64 %indvars.iv358.reg2mem131.0.load, i64 %indvars.iv346.us.us.us.us.reg2mem123.0.load, i32 1, !dbg !436
  %18 = load double, ptr %y135.us.us.us.us, align 8, !dbg !436
    #dbg_value(double %18, !404, !DIExpression(), !435)
  %z147.us.us.us.us = getelementptr inbounds [4 x [4 x [10 x %struct.dvector_t]]], ptr %force, i64 %indvars.iv364.reg2mem.0.load141, i64 %indvars.iv361.reg2mem.0.load147, i64 %indvars.iv358.reg2mem131.0.load, i64 %indvars.iv346.us.us.us.us.reg2mem123.0.load, i32 2, !dbg !437
  %19 = load double, ptr %z147.us.us.us.us, align 8, !dbg !437
    #dbg_value(double %19, !405, !DIExpression(), !435)
    #dbg_label(!406, !438)
    #dbg_value(i32 0, !364, !DIExpression(), !407)
  store double %17, ptr %sum_x.0330.us.us.us.us.reg2mem115, align 8
  store double %18, ptr %sum_y.0331.us.us.us.us.reg2mem117, align 8
  store double %19, ptr %sum_z.0332.us.us.us.us.reg2mem119, align 8
  store i64 0, ptr %indvars.iv.us.us.us.us.reg2mem121, align 8
  br label %for.body150.us.us.us.us, !dbg !439

for.body150.us.us.us.us:                          ; preds = %for.inc.us.us.us.us.for.body150.us.us.us.us_crit_edge, %for.body100.us.us.us.us
    #dbg_value(double %sum_z.0332.us.us.us.us.reg2mem119.0.sum_z.0332.us.us.us.us.reload120, !405, !DIExpression(), !435)
    #dbg_value(double %sum_y.0331.us.us.us.us.reg2mem117.0.sum_y.0331.us.us.us.us.reload118, !404, !DIExpression(), !435)
    #dbg_value(double %sum_x.0330.us.us.us.us.reg2mem115.0.sum_x.0330.us.us.us.us.reload116, !400, !DIExpression(), !435)
    #dbg_value(i64 %indvars.iv.us.us.us.us.reg2mem121.0.load, !364, !DIExpression(), !407)
  %indvars.iv.us.us.us.us.reg2mem121.0.load = load i64, ptr %indvars.iv.us.us.us.us.reg2mem121, align 8
  %sum_z.0332.us.us.us.us.reg2mem119.0.sum_z.0332.us.us.us.us.reload120 = load double, ptr %sum_z.0332.us.us.us.us.reg2mem119, align 8
  %sum_y.0331.us.us.us.us.reg2mem117.0.sum_y.0331.us.us.us.us.reload118 = load double, ptr %sum_y.0331.us.us.us.us.reg2mem117, align 8
  %sum_x.0330.us.us.us.us.reg2mem115.0.sum_x.0330.us.us.us.us.reload116 = load double, ptr %sum_x.0330.us.us.us.us.reg2mem115, align 8
  %add.ptr.us.us.us.us = getelementptr inbounds %struct.dvector_t, ptr %arrayidx79.us.us.us, i64 %indvars.iv.us.us.us.us.reg2mem121.0.load, !dbg !441
  %q.sroa.0.0.copyload.us.us.us.us = load double, ptr %add.ptr.us.us.us.us, align 8, !dbg !444
  %q.sroa.5.0.add.ptr.sroa_idx.us.us.us.us = getelementptr inbounds i8, ptr %add.ptr.us.us.us.us, i64 8, !dbg !444
  %q.sroa.5.0.copyload.us.us.us.us = load double, ptr %q.sroa.5.0.add.ptr.sroa_idx.us.us.us.us, align 8, !dbg !444
  %q.sroa.7.0.add.ptr.sroa_idx.us.us.us.us = getelementptr inbounds i8, ptr %add.ptr.us.us.us.us, i64 16, !dbg !444
  %q.sroa.7.0.copyload.us.us.us.us = load double, ptr %q.sroa.7.0.add.ptr.sroa_idx.us.us.us.us, align 8, !dbg !444
    #dbg_value(double %q.sroa.0.0.copyload.us.us.us.us, !362, !DIExpression(DW_OP_LLVM_fragment, 0, 64), !407)
    #dbg_value(double %q.sroa.5.0.copyload.us.us.us.us, !362, !DIExpression(DW_OP_LLVM_fragment, 64, 64), !407)
    #dbg_value(double %q.sroa.7.0.copyload.us.us.us.us, !362, !DIExpression(DW_OP_LLVM_fragment, 128, 64), !407)
  %cmp153.us.us.us.us = fcmp une double %q.sroa.0.0.copyload.us.us.us.us, %p.sroa.0.0.copyload.us.us.us.us, !dbg !445
  %cmp156.us.us.us.us = fcmp une double %q.sroa.5.0.copyload.us.us.us.us, %p.sroa.5.0.copyload.us.us.us.us
  %or.cond.us.us.us.us = select i1 %cmp153.us.us.us.us, i1 true, i1 %cmp156.us.us.us.us, !dbg !447
  %cmp160.us.us.us.us = fcmp une double %q.sroa.7.0.copyload.us.us.us.us, %p.sroa.7.0.copyload.us.us.us.us
  %or.cond327.us.us.us.us = select i1 %or.cond.us.us.us.us, i1 true, i1 %cmp160.us.us.us.us, !dbg !447
  br i1 %or.cond327.us.us.us.us, label %if.then.us.us.us.us, label %for.body150.us.us.us.us.for.inc.us.us.us.us_crit_edge, !dbg !447

for.body150.us.us.us.us.for.inc.us.us.us.us_crit_edge: ; preds = %for.body150.us.us.us.us
  store double %sum_z.0332.us.us.us.us.reg2mem119.0.sum_z.0332.us.us.us.us.reload120, ptr %sum_z.1.us.us.us.us.reg2mem109, align 8
  store double %sum_y.0331.us.us.us.us.reg2mem117.0.sum_y.0331.us.us.us.us.reload118, ptr %sum_y.1.us.us.us.us.reg2mem111, align 8
  store double %sum_x.0330.us.us.us.us.reg2mem115.0.sum_x.0330.us.us.us.us.reload116, ptr %sum_x.1.us.us.us.us.reg2mem113, align 8
  br label %for.inc.us.us.us.us, !dbg !447

if.then.us.us.us.us:                              ; preds = %for.body150.us.us.us.us
  %sub163.us.us.us.us = fsub double %p.sroa.0.0.copyload.us.us.us.us, %q.sroa.0.0.copyload.us.us.us.us, !dbg !448
    #dbg_value(double %sub163.us.us.us.us, !365, !DIExpression(), !407)
  %sub166.us.us.us.us = fsub double %p.sroa.5.0.copyload.us.us.us.us, %q.sroa.5.0.copyload.us.us.us.us, !dbg !450
    #dbg_value(double %sub166.us.us.us.us, !366, !DIExpression(), !407)
  %sub169.us.us.us.us = fsub double %p.sroa.7.0.copyload.us.us.us.us, %q.sroa.7.0.copyload.us.us.us.us, !dbg !451
    #dbg_value(double %sub169.us.us.us.us, !367, !DIExpression(), !407)
  %mul170.us.us.us.us = fmul double %sub166.us.us.us.us, %sub166.us.us.us.us, !dbg !452
  %20 = tail call double @llvm.fmuladd.f64(double %sub163.us.us.us.us, double %sub163.us.us.us.us, double %mul170.us.us.us.us), !dbg !453
  %21 = tail call double @llvm.fmuladd.f64(double %sub169.us.us.us.us, double %sub169.us.us.us.us, double %20), !dbg !454
  %div.us.us.us.us = fdiv double 1.000000e+00, %21, !dbg !455
    #dbg_value(double %div.us.us.us.us, !368, !DIExpression(), !407)
  %mul.us.us.us.us = fmul double %div.us.us.us.us, %div.us.us.us.us, !dbg !456
  %mul171.us.us.us.us = fmul double %div.us.us.us.us, %mul.us.us.us.us, !dbg !457
    #dbg_value(double %mul171.us.us.us.us, !369, !DIExpression(), !407)
  %22 = tail call double @llvm.fmuladd.f64(double %mul171.us.us.us.us, double 1.500000e+00, double -2.000000e+00), !dbg !458
  %mul173.us.us.us.us = fmul double %mul171.us.us.us.us, %22, !dbg !459
    #dbg_value(double %mul173.us.us.us.us, !370, !DIExpression(), !407)
  %mul174.us.us.us.us = fmul double %div.us.us.us.us, %mul173.us.us.us.us, !dbg !460
    #dbg_value(double %mul174.us.us.us.us, !371, !DIExpression(), !407)
  %23 = tail call double @llvm.fmuladd.f64(double %mul174.us.us.us.us, double %sub163.us.us.us.us, double %sum_x.0330.us.us.us.us.reg2mem115.0.sum_x.0330.us.us.us.us.reload116), !dbg !461
    #dbg_value(double %23, !400, !DIExpression(), !435)
  %24 = tail call double @llvm.fmuladd.f64(double %mul174.us.us.us.us, double %sub166.us.us.us.us, double %sum_y.0331.us.us.us.us.reg2mem117.0.sum_y.0331.us.us.us.us.reload118), !dbg !462
    #dbg_value(double %24, !404, !DIExpression(), !435)
  %25 = tail call double @llvm.fmuladd.f64(double %mul174.us.us.us.us, double %sub169.us.us.us.us, double %sum_z.0332.us.us.us.us.reg2mem119.0.sum_z.0332.us.us.us.us.reload120), !dbg !463
    #dbg_value(double %25, !405, !DIExpression(), !435)
  store double %25, ptr %sum_z.1.us.us.us.us.reg2mem109, align 8
  store double %24, ptr %sum_y.1.us.us.us.us.reg2mem111, align 8
  store double %23, ptr %sum_x.1.us.us.us.us.reg2mem113, align 8
  br label %for.inc.us.us.us.us, !dbg !464

for.inc.us.us.us.us:                              ; preds = %for.body150.us.us.us.us.for.inc.us.us.us.us_crit_edge, %if.then.us.us.us.us
    #dbg_value(double %sum_z.1.us.us.us.us.reg2mem109.0.sum_z.1.us.us.us.us.reload110, !405, !DIExpression(), !435)
    #dbg_value(double %sum_y.1.us.us.us.us.reg2mem111.0.sum_y.1.us.us.us.us.reload112, !404, !DIExpression(), !435)
    #dbg_value(double %sum_x.1.us.us.us.us.reg2mem113.0.sum_x.1.us.us.us.us.reload114, !400, !DIExpression(), !435)
  %sum_x.1.us.us.us.us.reg2mem113.0.sum_x.1.us.us.us.us.reload114 = load double, ptr %sum_x.1.us.us.us.us.reg2mem113, align 8
  %sum_y.1.us.us.us.us.reg2mem111.0.sum_y.1.us.us.us.us.reload112 = load double, ptr %sum_y.1.us.us.us.us.reg2mem111, align 8
  %sum_z.1.us.us.us.us.reg2mem109.0.sum_z.1.us.us.us.us.reload110 = load double, ptr %sum_z.1.us.us.us.us.reg2mem109, align 8
  %indvars.iv.next.us.us.us.us = add nuw nsw i64 %indvars.iv.us.us.us.us.reg2mem121.0.load, 1, !dbg !465
    #dbg_value(i64 %indvars.iv.next.us.us.us.us, !364, !DIExpression(), !407)
  %exitcond.not.us.us.us.us = icmp eq i64 %indvars.iv.next.us.us.us.us, %wide.trip.count.us.us.us, !dbg !466
  br i1 %exitcond.not.us.us.us.us, label %for.end.loopexit.us.us.us.us, label %for.inc.us.us.us.us.for.body150.us.us.us.us_crit_edge, !dbg !439, !llvm.loop !467

for.inc.us.us.us.us.for.body150.us.us.us.us_crit_edge: ; preds = %for.inc.us.us.us.us
  store double %sum_x.1.us.us.us.us.reg2mem113.0.sum_x.1.us.us.us.us.reload114, ptr %sum_x.0330.us.us.us.us.reg2mem115, align 8
  store double %sum_y.1.us.us.us.us.reg2mem111.0.sum_y.1.us.us.us.us.reload112, ptr %sum_y.0331.us.us.us.us.reg2mem117, align 8
  store double %sum_z.1.us.us.us.us.reg2mem109.0.sum_z.1.us.us.us.us.reload110, ptr %sum_z.0332.us.us.us.us.reg2mem119, align 8
  store i64 %indvars.iv.next.us.us.us.us, ptr %indvars.iv.us.us.us.us.reg2mem121, align 8
  br label %for.body150.us.us.us.us, !dbg !439

for.end.loopexit.us.us.us.us:                     ; preds = %for.inc.us.us.us.us
  store double %sum_x.1.us.us.us.us.reg2mem113.0.sum_x.1.us.us.us.us.reload114, ptr %arrayidx122.us.us.us.us, align 8, !dbg !469, !tbaa !470
  store double %sum_y.1.us.us.us.us.reg2mem111.0.sum_y.1.us.us.us.us.reload112, ptr %y135.us.us.us.us, align 8, !dbg !473, !tbaa !474
  store double %sum_z.1.us.us.us.us.reg2mem109.0.sum_z.1.us.us.us.us.reload110, ptr %z147.us.us.us.us, align 8, !dbg !475, !tbaa !476
  %indvars.iv.next347.us.us.us.us = add nuw nsw i64 %indvars.iv346.us.us.us.us.reg2mem123.0.load, 1, !dbg !477
    #dbg_value(i64 %indvars.iv.next347.us.us.us.us, !363, !DIExpression(), !407)
  %exitcond349.not.us.us.us.us = icmp eq i64 %indvars.iv.next347.us.us.us.us, %wide.trip.count348, !dbg !478
  br i1 %exitcond349.not.us.us.us.us, label %for.end.loopexit.us.us.us.us.for.end216.loopexit.us.us.us_crit_edge, label %for.end.loopexit.us.us.us.us.for.body100.us.us.us.us_crit_edge, !dbg !479, !llvm.loop !480

for.end.loopexit.us.us.us.us.for.body100.us.us.us.us_crit_edge: ; preds = %for.end.loopexit.us.us.us.us
  store i64 %indvars.iv.next347.us.us.us.us, ptr %indvars.iv346.us.us.us.us.reg2mem123, align 8
  br label %for.body100.us.us.us.us, !dbg !479

for.end.loopexit.us.us.us.us.for.end216.loopexit.us.us.us_crit_edge: ; preds = %for.end.loopexit.us.us.us.us
  br label %for.end216.loopexit.us.us.us, !dbg !479

for.inc221.loopexit.split.us.us.us:               ; preds = %for.end216.loopexit.us.us.us
  %indvars.iv.next354.us12.us = add nuw nsw i64 %indvars.iv353.us11.us.reg2mem127.0.load, 1, !dbg !482
    #dbg_value(i64 %indvars.iv.next354.us12.us, !360, !DIExpression(DW_OP_LLVM_fragment, 32, 32), !407)
  %.reg2mem89.0.load = load i64, ptr %.reg2mem89, align 8
  %cmp48.us13.us = icmp ult i64 %indvars.iv.next354.us12.us, %.reg2mem89.0.load, !dbg !483
  br i1 %cmp48.us13.us, label %for.inc221.loopexit.split.us.us.us.loop_grid1_z.us10.us_crit_edge, label %for.inc225.loopexit.split.split.us.us, !dbg !419, !llvm.loop !484

for.inc221.loopexit.split.us.us.us.loop_grid1_z.us10.us_crit_edge: ; preds = %for.inc221.loopexit.split.us.us.us
  store i64 %indvars.iv.next354.us12.us, ptr %indvars.iv353.us11.us.reg2mem127, align 8
  br label %loop_grid1_z.us10.us, !dbg !419

for.inc225.loopexit.split.split.us.us:            ; preds = %for.inc221.loopexit.split.us.us.us
  %indvars.iv.next357.us20 = add nuw nsw i64 %indvars.iv356.us19.reg2mem129.0.load, 1, !dbg !486
    #dbg_value(i64 %indvars.iv.next357.us20, !360, !DIExpression(DW_OP_LLVM_fragment, 0, 32), !407)
  %.reg2mem99.0.load = load i64, ptr %.reg2mem99, align 8
  %cmp25.us21 = icmp ult i64 %indvars.iv.next357.us20, %.reg2mem99.0.load, !dbg !487
  br i1 %cmp25.us21, label %for.inc225.loopexit.split.split.us.us.loop_grid1_y.us18_crit_edge, label %for.inc225.loopexit.split.split.us.us.for.inc229.loopexit.split_crit_edge, !dbg !413, !llvm.loop !488

for.inc225.loopexit.split.split.us.us.for.inc229.loopexit.split_crit_edge: ; preds = %for.inc225.loopexit.split.split.us.us
  br label %for.inc229.loopexit.split, !dbg !413

for.inc225.loopexit.split.split.us.us.loop_grid1_y.us18_crit_edge: ; preds = %for.inc225.loopexit.split.split.us.us
  store i64 %indvars.iv.next357.us20, ptr %indvars.iv356.us19.reg2mem129, align 8
  br label %loop_grid1_y.us18, !dbg !413

for.inc229.loopexit.split:                        ; preds = %for.inc225.loopexit.split.split.us.us.for.inc229.loopexit.split_crit_edge, %loop_grid1_y.lr.ph.split.split.for.inc229.loopexit.split_crit_edge, %loop_grid1_x.for.inc229.loopexit.split_crit_edge
  %indvars.iv.next359 = add nuw nsw i64 %indvars.iv358.reg2mem131.0.load, 1, !dbg !490
    #dbg_value(i64 %indvars.iv.next359, !353, !DIExpression(DW_OP_LLVM_fragment, 64, 32), !407)
  %exitcond360.not = icmp eq i64 %indvars.iv.next359, 4, !dbg !491
  br i1 %exitcond360.not, label %for.inc229.loopexit.split.for.inc233.split_crit_edge, label %for.inc229.loopexit.split.loop_grid1_x_crit_edge, !dbg !411, !llvm.loop !492

for.inc229.loopexit.split.loop_grid1_x_crit_edge: ; preds = %for.inc229.loopexit.split
  store i64 %indvars.iv.next359, ptr %indvars.iv358.reg2mem131, align 8
  br label %loop_grid1_x, !dbg !411

for.inc229.loopexit.split.for.inc233.split_crit_edge: ; preds = %for.inc229.loopexit.split
  br label %for.inc233.split, !dbg !411

for.inc233.split:                                 ; preds = %for.inc229.loopexit.split.for.inc233.split_crit_edge, %for.cond6.preheader.for.inc233.split_crit_edge
  %indvars.iv361.reg2mem.0.load148 = load i64, ptr %indvars.iv361.reg2mem, align 8
  %indvars.iv.next362 = add nuw nsw i64 %indvars.iv361.reg2mem.0.load148, 1, !dbg !494
    #dbg_value(i64 %indvars.iv.next362, !353, !DIExpression(DW_OP_LLVM_fragment, 32, 32), !407)
  %exitcond363.not = icmp eq i64 %indvars.iv.next362, 4, !dbg !495
  br i1 %exitcond363.not, label %for.inc233.split.for.inc237_crit_edge, label %for.inc233.split.for.cond6.preheader_crit_edge, !dbg !410, !llvm.loop !496

for.inc233.split.for.cond6.preheader_crit_edge:   ; preds = %for.inc233.split
  store i64 %indvars.iv.next362, ptr %indvars.iv361.reg2mem133, align 8
  br label %for.cond6.preheader, !dbg !410

for.inc233.split.for.inc237_crit_edge:            ; preds = %for.inc233.split
  br label %for.inc237, !dbg !410

for.inc237:                                       ; preds = %for.inc233.split.for.inc237_crit_edge, %for.cond2.preheader.for.inc237_crit_edge
  %indvars.iv364.reg2mem.0.load142 = load i64, ptr %indvars.iv364.reg2mem, align 8
  %indvars.iv.next365 = add nuw nsw i64 %indvars.iv364.reg2mem.0.load142, 1, !dbg !498
    #dbg_value(i64 %indvars.iv.next365, !353, !DIExpression(DW_OP_LLVM_fragment, 0, 32), !407)
  %exitcond366.not = icmp eq i64 %indvars.iv.next365, 4, !dbg !499
  br i1 %exitcond366.not, label %for.end240, label %for.inc237.for.cond2.preheader_crit_edge, !dbg !409, !llvm.loop !500

for.inc237.for.cond2.preheader_crit_edge:         ; preds = %for.inc237
  store i64 %indvars.iv.next365, ptr %indvars.iv364.reg2mem135, align 8
  br label %for.cond2.preheader, !dbg !409

for.end240:                                       ; preds = %for.inc237
  ret void, !dbg !502
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.umin.i32(i32, i32) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #0 !dbg !503 {
entry.split:
    #dbg_value(ptr %vargs, !507, !DIExpression(), !509)
    #dbg_value(ptr %vargs, !508, !DIExpression(), !509)
  %force = getelementptr inbounds i8, ptr %vargs, i64 256, !dbg !510
  %position = getelementptr inbounds i8, ptr %vargs, i64 15616, !dbg !511
  tail call void @md(ptr noundef %vargs, ptr noundef nonnull %force, ptr noundef nonnull %position) #18, !dbg !512
  ret void, !dbg !513
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #2 !dbg !514 {
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
    #dbg_value(i32 %fd, !518, !DIExpression(), !523)
    #dbg_value(ptr %vdata, !519, !DIExpression(), !523)
    #dbg_value(ptr %vdata, !520, !DIExpression(), !523)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(30976) %vdata, i8 0, i64 30976, i1 false), !dbg !524
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !525
    #dbg_value(ptr %call, !521, !DIExpression(), !523)
    #dbg_value(ptr %call, !526, !DIExpression(), !533)
    #dbg_value(i32 1, !531, !DIExpression(), !533)
    #dbg_value(i32 0, !532, !DIExpression(), !533)
  store ptr %call, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 0, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem72.0.load, !532, !DIExpression(), !533)
    #dbg_value(ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, !526, !DIExpression(), !533)
  %i.041.i.reg2mem72.0.load = load i32, ptr %i.041.i.reg2mem72, align 4
  %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71 = load ptr, ptr %s.addr.040.i.reg2mem70, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, align 1, !dbg !535, !tbaa !536
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !537

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !537

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !537

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !538
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !538, !tbaa !536
  %cmp13.i = icmp eq i8 %1, 37, !dbg !541
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !542

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !542

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 2, !dbg !543
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !543, !tbaa !536
  %cmp18.i = icmp eq i8 %2, 10, !dbg !544
  %inc.i = zext i1 %cmp18.i to i32, !dbg !545
  %spec.select.i = add nsw i32 %i.041.i.reg2mem72.0.load, %inc.i, !dbg !545
  store i32 %spec.select.i, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !545

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem68.0.load, !532, !DIExpression(), !533)
  %i.1.i.reg2mem68.0.load = load i32, ptr %i.1.i.reg2mem68, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !546
    #dbg_value(ptr %incdec.ptr.i, !526, !DIExpression(), !533)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem68.0.load, 1, !dbg !547
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !548, !llvm.loop !549

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 %i.1.i.reg2mem68.0.load, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i, !dbg !548

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !551, !tbaa !536
  %3 = icmp eq i8 %.pre.i, 0, !dbg !553
  %4 = select i1 %3, i64 0, i64 2, !dbg !554
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !548

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !554
    #dbg_value(ptr %spec.select38.i, !522, !DIExpression(), !523)
  %call2 = tail call signext i32 @parse_int32_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 64) #18, !dbg !555
    #dbg_value(ptr %call, !526, !DIExpression(), !556)
    #dbg_value(i32 2, !531, !DIExpression(), !556)
    #dbg_value(i32 0, !532, !DIExpression(), !556)
  store ptr %call, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 0, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem66.0.load, !532, !DIExpression(), !556)
    #dbg_value(ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, !526, !DIExpression(), !556)
  %i.041.i2.reg2mem66.0.load = load i32, ptr %i.041.i2.reg2mem66, align 4
  %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65 = load ptr, ptr %s.addr.040.i3.reg2mem64, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, align 1, !dbg !558, !tbaa !536
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !559

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !559

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !559

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !560
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !560, !tbaa !536
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !561
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !562

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !562

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 2, !dbg !563
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !563, !tbaa !536
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !564
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !565
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem66.0.load, %inc.i19, !dbg !565
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !565

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem62.0.load, !532, !DIExpression(), !556)
  %i.1.i8.reg2mem62.0.load = load i32, ptr %i.1.i8.reg2mem62, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !566
    #dbg_value(ptr %incdec.ptr.i9, !526, !DIExpression(), !556)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem62.0.load, 2, !dbg !567
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !568, !llvm.loop !569

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 %i.1.i8.reg2mem62.0.load, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1, !dbg !568

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !571, !tbaa !536
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !572
  %9 = select i1 %8, i64 0, i64 2, !dbg !573
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !568

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !573
    #dbg_value(ptr %spec.select38.i15, !522, !DIExpression(), !523)
  %position = getelementptr inbounds i8, ptr %vdata, i64 15616, !dbg !574
  %call5 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %position, i32 noundef signext 1920) #18, !dbg !575
  tail call void @free(ptr noundef %call) #18, !dbg !576
  ret void, !dbg !577
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !578 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #4

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #2 !dbg !580 {
entry.split:
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !582, !DIExpression(), !585)
    #dbg_value(ptr %vdata, !583, !DIExpression(), !585)
    #dbg_value(ptr %vdata, !584, !DIExpression(), !585)
    #dbg_value(i32 %fd, !586, !DIExpression(), !591)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !593
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !593

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !593
  unreachable, !dbg !593

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !596
    #dbg_value(i32 %fd, !597, !DIExpression(), !605)
    #dbg_value(ptr %vdata, !602, !DIExpression(), !605)
    #dbg_value(i32 64, !603, !DIExpression(), !605)
    #dbg_value(i32 0, !604, !DIExpression(), !605)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !607

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !604, !DIExpression(), !605)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i32, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !609
  %0 = load i32, ptr %arrayidx.i, align 4, !dbg !609, !tbaa !414
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !609
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !612
    #dbg_value(i64 %indvars.iv.next.i, !604, !DIExpression(), !605)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 64, !dbg !612
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !607, !llvm.loop !613

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !607

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !586, !DIExpression(), !614)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !616
  %position = getelementptr inbounds i8, ptr %vdata, i64 15616, !dbg !617
    #dbg_value(i32 %fd, !618, !DIExpression(), !626)
    #dbg_value(ptr %position, !623, !DIExpression(), !626)
    #dbg_value(i32 1920, !624, !DIExpression(), !626)
    #dbg_value(i32 0, !625, !DIExpression(), !626)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !628

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !625, !DIExpression(), !626)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds double, ptr %position, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !630
  %1 = load double, ptr %arrayidx.i11, align 8, !dbg !630, !tbaa !633
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %1), !dbg !630
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !634
    #dbg_value(i64 %indvars.iv.next.i12, !625, !DIExpression(), !626)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 1920, !dbg !634
  br i1 %exitcond.not.i13, label %write_double_array.exit, label %for.body.i9.for.body.i9_crit_edge, !dbg !628, !llvm.loop !635

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !628

write_double_array.exit:                          ; preds = %for.body.i9
  ret void, !dbg !636
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #2 !dbg !637 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !639, !DIExpression(), !644)
    #dbg_value(ptr %vdata, !640, !DIExpression(), !644)
    #dbg_value(ptr %vdata, !641, !DIExpression(), !644)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(30976) %vdata, i8 0, i64 30976, i1 false), !dbg !645
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !646
    #dbg_value(ptr %call, !642, !DIExpression(), !644)
    #dbg_value(ptr %call, !526, !DIExpression(), !647)
    #dbg_value(i32 1, !531, !DIExpression(), !647)
    #dbg_value(i32 0, !532, !DIExpression(), !647)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !532, !DIExpression(), !647)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !526, !DIExpression(), !647)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !649, !tbaa !536
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !650

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !650

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !650

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !651
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !651, !tbaa !536
  %cmp13.i = icmp eq i8 %1, 37, !dbg !652
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !653

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !653

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !654
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !654, !tbaa !536
  %cmp18.i = icmp eq i8 %2, 10, !dbg !655
  %inc.i = zext i1 %cmp18.i to i32, !dbg !656
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !656
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !656

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !532, !DIExpression(), !647)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !657
    #dbg_value(ptr %incdec.ptr.i, !526, !DIExpression(), !647)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !658
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !659, !llvm.loop !660

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !659

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !662, !tbaa !536
  %3 = icmp eq i8 %.pre.i, 0, !dbg !663
  %4 = select i1 %3, i64 0, i64 2, !dbg !664
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !659

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !664
    #dbg_value(ptr %spec.select38.i, !643, !DIExpression(), !644)
  %force = getelementptr inbounds i8, ptr %vdata, i64 256, !dbg !665
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %force, i32 noundef signext 1920) #18, !dbg !666
  tail call void @free(ptr noundef %call) #18, !dbg !667
  ret void, !dbg !668
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #2 !dbg !669 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !671, !DIExpression(), !674)
    #dbg_value(ptr %vdata, !672, !DIExpression(), !674)
    #dbg_value(ptr %vdata, !673, !DIExpression(), !674)
    #dbg_value(i32 %fd, !586, !DIExpression(), !675)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !677
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !677

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !677
  unreachable, !dbg !677

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !678
  %force = getelementptr inbounds i8, ptr %vdata, i64 256, !dbg !679
    #dbg_value(i32 %fd, !618, !DIExpression(), !680)
    #dbg_value(ptr %force, !623, !DIExpression(), !680)
    #dbg_value(i32 1920, !624, !DIExpression(), !680)
    #dbg_value(i32 0, !625, !DIExpression(), !680)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !682

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !625, !DIExpression(), !680)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %force, i64 %indvars.iv.i.reg2mem.0.load, !dbg !683
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !683, !tbaa !633
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !683
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !684
    #dbg_value(i64 %indvars.iv.next.i, !625, !DIExpression(), !680)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 1920, !dbg !684
  br i1 %exitcond.not.i, label %write_double_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !682, !llvm.loop !685

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !682

write_double_array.exit:                          ; preds = %for.body.i
  ret void, !dbg !686
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #5 !dbg !687 {
entry.split:
  %has_errors.3128.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
  %has_errors.2130.reg2mem27 = alloca i32, align 4
  %indvars.iv135.reg2mem29 = alloca i64, align 8
  %has_errors.1132.reg2mem31 = alloca i32, align 4
  %indvars.iv138.reg2mem33 = alloca i64, align 8
  %has_errors.0134.reg2mem35 = alloca i32, align 4
  %indvars.iv141.reg2mem37 = alloca i64, align 8
    #dbg_value(ptr %vdata, !691, !DIExpression(), !703)
    #dbg_value(ptr %vref, !692, !DIExpression(), !703)
    #dbg_value(ptr %vdata, !693, !DIExpression(), !703)
    #dbg_value(ptr %vref, !694, !DIExpression(), !703)
    #dbg_value(i32 0, !695, !DIExpression(), !703)
    #dbg_value(i32 0, !696, !DIExpression(), !703)
  store i32 0, ptr %has_errors.0134.reg2mem35, align 4
  store i64 0, ptr %indvars.iv141.reg2mem37, align 8
  br label %for.cond1.preheader, !dbg !704

for.cond1.preheader:                              ; preds = %for.inc86.for.cond1.preheader_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv141.reg2mem37.0.load, !696, !DIExpression(), !703)
    #dbg_value(i32 %has_errors.0134.reg2mem35.0.load, !695, !DIExpression(), !703)
    #dbg_value(i32 0, !697, !DIExpression(), !703)
  %indvars.iv141.reg2mem37.0.load = load i64, ptr %indvars.iv141.reg2mem37, align 8
  %has_errors.0134.reg2mem35.0.load = load i32, ptr %has_errors.0134.reg2mem35, align 4
  store i32 %has_errors.0134.reg2mem35.0.load, ptr %has_errors.1132.reg2mem31, align 4
  store i64 0, ptr %indvars.iv138.reg2mem33, align 8
  br label %for.cond4.preheader, !dbg !706

for.cond4.preheader:                              ; preds = %for.inc83.for.cond4.preheader_crit_edge, %for.cond1.preheader
    #dbg_value(i64 %indvars.iv138.reg2mem33.0.load, !697, !DIExpression(), !703)
    #dbg_value(i32 %has_errors.1132.reg2mem31.0.load, !695, !DIExpression(), !703)
    #dbg_value(i32 0, !698, !DIExpression(), !703)
  %indvars.iv138.reg2mem33.0.load = load i64, ptr %indvars.iv138.reg2mem33, align 8
  %has_errors.1132.reg2mem31.0.load = load i32, ptr %has_errors.1132.reg2mem31, align 4
  store i32 %has_errors.1132.reg2mem31.0.load, ptr %has_errors.2130.reg2mem27, align 4
  store i64 0, ptr %indvars.iv135.reg2mem29, align 8
  br label %for.cond7.preheader, !dbg !710

for.cond7.preheader:                              ; preds = %for.inc80.for.cond7.preheader_crit_edge, %for.cond4.preheader
    #dbg_value(i64 %indvars.iv135.reg2mem29.0.load, !698, !DIExpression(), !703)
    #dbg_value(i32 %has_errors.2130.reg2mem27.0.load, !695, !DIExpression(), !703)
    #dbg_value(i32 0, !699, !DIExpression(), !703)
  %indvars.iv135.reg2mem29.0.load = load i64, ptr %indvars.iv135.reg2mem29, align 8
  %has_errors.2130.reg2mem27.0.load = load i32, ptr %has_errors.2130.reg2mem27, align 4
  store i32 %has_errors.2130.reg2mem27.0.load, ptr %has_errors.3128.reg2mem, align 4
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body9, !dbg !714

for.body9:                                        ; preds = %for.body9.for.body9_crit_edge, %for.cond7.preheader
    #dbg_value(i32 %has_errors.3128.reg2mem.0.load, !695, !DIExpression(), !703)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !699, !DIExpression(), !703)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %has_errors.3128.reg2mem.0.load = load i32, ptr %has_errors.3128.reg2mem, align 4
  %arrayidx15 = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 1, i64 %indvars.iv141.reg2mem37.0.load, i64 %indvars.iv138.reg2mem33.0.load, i64 %indvars.iv135.reg2mem29.0.load, i64 %indvars.iv.reg2mem.0.load, !dbg !718
  %0 = load double, ptr %arrayidx15, align 8, !dbg !721, !tbaa !470
  %arrayidx24 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 1, i64 %indvars.iv141.reg2mem37.0.load, i64 %indvars.iv138.reg2mem33.0.load, i64 %indvars.iv135.reg2mem29.0.load, i64 %indvars.iv.reg2mem.0.load, !dbg !722
  %1 = load double, ptr %arrayidx24, align 8, !dbg !723, !tbaa !470
  %sub = fsub double %0, %1, !dbg !724
    #dbg_value(double %sub, !700, !DIExpression(), !703)
  %y = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 1, i64 %indvars.iv141.reg2mem37.0.load, i64 %indvars.iv138.reg2mem33.0.load, i64 %indvars.iv135.reg2mem29.0.load, i64 %indvars.iv.reg2mem.0.load, i32 1, !dbg !725
  %2 = load double, ptr %y, align 8, !dbg !725, !tbaa !474
  %y44 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 1, i64 %indvars.iv141.reg2mem37.0.load, i64 %indvars.iv138.reg2mem33.0.load, i64 %indvars.iv135.reg2mem29.0.load, i64 %indvars.iv.reg2mem.0.load, i32 1, !dbg !726
  %3 = load double, ptr %y44, align 8, !dbg !726, !tbaa !474
  %sub45 = fsub double %2, %3, !dbg !727
    #dbg_value(double %sub45, !701, !DIExpression(), !703)
  %z = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 1, i64 %indvars.iv141.reg2mem37.0.load, i64 %indvars.iv138.reg2mem33.0.load, i64 %indvars.iv135.reg2mem29.0.load, i64 %indvars.iv.reg2mem.0.load, i32 2, !dbg !728
  %4 = load double, ptr %z, align 8, !dbg !728, !tbaa !476
  %z64 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 1, i64 %indvars.iv141.reg2mem37.0.load, i64 %indvars.iv138.reg2mem33.0.load, i64 %indvars.iv135.reg2mem29.0.load, i64 %indvars.iv.reg2mem.0.load, i32 2, !dbg !729
  %5 = load double, ptr %z64, align 8, !dbg !729, !tbaa !476
  %sub65 = fsub double %4, %5, !dbg !730
    #dbg_value(double %sub65, !702, !DIExpression(), !703)
  %6 = tail call double @llvm.fabs.f64(double %sub), !dbg !731
  %7 = fcmp ogt double %6, 0x3EB0C6F7A0B5ED8D, !dbg !731
    #dbg_value(!DIArgList(i32 %has_errors.3128.reg2mem.0.load, i1 %7), !695, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !703)
  %8 = tail call double @llvm.fabs.f64(double %sub45), !dbg !732
  %9 = fcmp ogt double %8, 0x3EB0C6F7A0B5ED8D, !dbg !732
  %10 = or i1 %7, %9, !dbg !733
    #dbg_value(!DIArgList(i32 %has_errors.3128.reg2mem.0.load, i1 %10), !695, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !703)
  %11 = tail call double @llvm.fabs.f64(double %sub65), !dbg !734
  %12 = fcmp ogt double %11, 0x3EB0C6F7A0B5ED8D, !dbg !734
  %13 = or i1 %10, %12, !dbg !735
  %14 = zext i1 %13 to i32, !dbg !735
  %or79 = or i32 %has_errors.3128.reg2mem.0.load, %14, !dbg !735
    #dbg_value(i32 %or79, !695, !DIExpression(), !703)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !736
    #dbg_value(i64 %indvars.iv.next, !699, !DIExpression(), !703)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 10, !dbg !737
  br i1 %exitcond.not, label %for.inc80, label %for.body9.for.body9_crit_edge, !dbg !714, !llvm.loop !738

for.body9.for.body9_crit_edge:                    ; preds = %for.body9
  store i32 %or79, ptr %has_errors.3128.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body9, !dbg !714

for.inc80:                                        ; preds = %for.body9
  %indvars.iv.next136 = add nuw nsw i64 %indvars.iv135.reg2mem29.0.load, 1, !dbg !740
    #dbg_value(i32 %or79, !695, !DIExpression(), !703)
    #dbg_value(i64 %indvars.iv.next136, !698, !DIExpression(), !703)
  %exitcond137.not = icmp eq i64 %indvars.iv.next136, 4, !dbg !741
  br i1 %exitcond137.not, label %for.inc83, label %for.inc80.for.cond7.preheader_crit_edge, !dbg !710, !llvm.loop !742

for.inc80.for.cond7.preheader_crit_edge:          ; preds = %for.inc80
  store i32 %or79, ptr %has_errors.2130.reg2mem27, align 4
  store i64 %indvars.iv.next136, ptr %indvars.iv135.reg2mem29, align 8
  br label %for.cond7.preheader, !dbg !710

for.inc83:                                        ; preds = %for.inc80
  %indvars.iv.next139 = add nuw nsw i64 %indvars.iv138.reg2mem33.0.load, 1, !dbg !744
    #dbg_value(i32 %or79, !695, !DIExpression(), !703)
    #dbg_value(i64 %indvars.iv.next139, !697, !DIExpression(), !703)
  %exitcond140.not = icmp eq i64 %indvars.iv.next139, 4, !dbg !745
  br i1 %exitcond140.not, label %for.inc86, label %for.inc83.for.cond4.preheader_crit_edge, !dbg !706, !llvm.loop !746

for.inc83.for.cond4.preheader_crit_edge:          ; preds = %for.inc83
  store i32 %or79, ptr %has_errors.1132.reg2mem31, align 4
  store i64 %indvars.iv.next139, ptr %indvars.iv138.reg2mem33, align 8
  br label %for.cond4.preheader, !dbg !706

for.inc86:                                        ; preds = %for.inc83
  %indvars.iv.next142 = add nuw nsw i64 %indvars.iv141.reg2mem37.0.load, 1, !dbg !748
    #dbg_value(i32 %or79, !695, !DIExpression(), !703)
    #dbg_value(i64 %indvars.iv.next142, !696, !DIExpression(), !703)
  %exitcond143.not = icmp eq i64 %indvars.iv.next142, 4, !dbg !749
  br i1 %exitcond143.not, label %for.end88, label %for.inc86.for.cond1.preheader_crit_edge, !dbg !704, !llvm.loop !750

for.inc86.for.cond1.preheader_crit_edge:          ; preds = %for.inc86
  store i32 %or79, ptr %has_errors.0134.reg2mem35, align 4
  store i64 %indvars.iv.next142, ptr %indvars.iv141.reg2mem37, align 8
  br label %for.cond1.preheader, !dbg !704

for.end88:                                        ; preds = %for.inc86
  %tobool.not = icmp eq i32 %or79, 0, !dbg !752
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !752
  ret i32 %lnot.ext, !dbg !753
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #2 !dbg !754 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !804
    #dbg_assign(i1 undef, !760, !DIExpression(), !804, ptr %s, !DIExpression(), !805)
    #dbg_value(i32 %fd, !758, !DIExpression(), !805)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #18, !dbg !806
  %cmp = icmp sgt i32 %fd, 1, !dbg !807
  br i1 %cmp, label %if.end, label %if.else, !dbg !807

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !807
  unreachable, !dbg !807

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #18, !dbg !810
  %cmp1 = icmp eq i32 %call, 0, !dbg !810
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !810

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !810
  unreachable, !dbg !810

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !813
  %0 = load i64, ptr %st_size, align 8, !dbg !813
    #dbg_value(i64 %0, !797, !DIExpression(), !805)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !814
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !814

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !814
  unreachable, !dbg !814

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !817
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #20, !dbg !818
    #dbg_value(ptr %call11, !759, !DIExpression(), !805)
    #dbg_value(i64 0, !800, !DIExpression(), !805)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !819

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !820
    #dbg_value(i64 %add19, !800, !DIExpression(), !805)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !822
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !819, !llvm.loop !823

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !819

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !800, !DIExpression(), !805)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !825
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !826
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #18, !dbg !827
    #dbg_value(i64 %call13, !803, !DIExpression(), !805)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !828
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !800, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !805)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !828

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !828
  unreachable, !dbg !828

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !831
  store i8 0, ptr %arrayidx20, align 1, !dbg !832, !tbaa !536
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #18, !dbg !833
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #18, !dbg !834
  ret ptr %call11, !dbg !835
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: noreturn nounwind
declare !dbg !836 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare !dbg !841 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !846 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #9

; Function Attrs: nofree
declare !dbg !851 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #10

declare !dbg !855 signext i32 @close(i32 noundef signext) local_unnamed_addr #11

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #2 !dbg !527 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !526, !DIExpression(), !856)
    #dbg_value(i32 %n, !531, !DIExpression(), !856)
    #dbg_value(i32 0, !532, !DIExpression(), !856)
  %cmp = icmp sgt i32 %n, -1, !dbg !857
  br i1 %cmp, label %if.end, label %if.else, !dbg !857

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #19, !dbg !857
  unreachable, !dbg !857

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !860
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !862

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !862

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !862

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !532, !DIExpression(), !856)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !526, !DIExpression(), !856)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !863, !tbaa !536
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !864

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !864

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !864

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !865
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !865, !tbaa !536
  %cmp13 = icmp eq i8 %1, 37, !dbg !866
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !867

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !867

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !868
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !868, !tbaa !536
  %cmp18 = icmp eq i8 %2, 10, !dbg !869
  %inc = zext i1 %cmp18 to i32, !dbg !870
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !870
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !870

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !532, !DIExpression(), !856)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !871
    #dbg_value(ptr %incdec.ptr, !526, !DIExpression(), !856)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !872
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !873, !llvm.loop !874

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !873

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !876, !tbaa !536
  %3 = icmp eq i8 %.pre, 0, !dbg !877
  %4 = select i1 %3, i64 0, i64 2, !dbg !878
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !873

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !878
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !878

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !879
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !880 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !884, !DIExpression(), !888)
    #dbg_value(ptr %arr, !885, !DIExpression(), !888)
    #dbg_value(i32 %n, !886, !DIExpression(), !888)
  %cmp.not = icmp eq ptr %s, null, !dbg !889
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !889

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #19, !dbg !889
  unreachable, !dbg !889

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !892
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !894

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !895
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !897
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !897

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !887, !DIExpression(), !888)
  %conv404 = zext nneg i32 %n to i64, !dbg !898
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !899
  br label %if.end46, !dbg !900

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !887, !DIExpression(), !888)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !901
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !902

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !902

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !903
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !904
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !904
  %cmp9.not = icmp eq i8 %0, 0, !dbg !905
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !906

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !906

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !907
  %1 = load i8, ptr %gep, align 1, !dbg !907
  %cmp16.not = icmp eq i8 %1, 0, !dbg !908
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !909

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !909

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !910
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !911
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !911
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !911, !llvm.loop !912

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !911

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !898

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !898

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !898

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !898
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !887, !DIExpression(), !888)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !899
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !914
  store i8 0, ptr %arrayidx45, align 1, !dbg !916, !tbaa !536
  br label %if.end46, !dbg !914

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !917
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !918 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !930
    #dbg_assign(i1 undef, !927, !DIExpression(), !930, ptr %endptr, !DIExpression(), !931)
    #dbg_value(ptr %s, !923, !DIExpression(), !931)
    #dbg_value(ptr %arr, !924, !DIExpression(), !931)
    #dbg_value(i32 %n, !925, !DIExpression(), !931)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !932
    #dbg_value(i32 0, !928, !DIExpression(), !931)
  %cmp.not = icmp eq ptr %s, null, !dbg !933
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !933

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #19, !dbg !933
  unreachable, !dbg !933

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !932
    #dbg_value(ptr %call, !926, !DIExpression(), !931)
    #dbg_value(i32 0, !928, !DIExpression(), !931)
  %cmp130 = icmp ne ptr %call, null, !dbg !932
  %cmp231 = icmp sgt i32 %n, 0, !dbg !932
  %0 = and i1 %cmp231, %cmp130, !dbg !932
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !932

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !932

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !932
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !932

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !926, !DIExpression(), !931)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !928, !DIExpression(), !931)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !936, !tbaa !938, !DIAssignID !940
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !927, !DIExpression(), !940, ptr %endptr, !DIExpression(), !931)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !936
  %conv = trunc i64 %call3 to i8, !dbg !936
    #dbg_value(i8 %conv, !929, !DIExpression(), !931)
  %2 = load ptr, ptr %endptr, align 8, !dbg !941, !tbaa !938
  %3 = load i8, ptr %2, align 1, !dbg !941, !tbaa !536
  %cmp5.not = icmp eq i8 %3, 0, !dbg !941
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !936

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !936

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !943, !tbaa !938
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !943
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !943
  br label %if.end9, !dbg !943

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !936
  store i8 %conv, ptr %arrayidx, align 1, !dbg !936, !tbaa !536
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !936
    #dbg_value(i64 %indvars.iv.next, !928, !DIExpression(), !931)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !936
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !936
  store i8 10, ptr %arrayidx11, align 1, !dbg !936, !tbaa !536
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !936
    #dbg_value(ptr %call12, !926, !DIExpression(), !931)
  %cmp1 = icmp ne ptr %call12, null, !dbg !932
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !932
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !932
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !932, !llvm.loop !945

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !932

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !932

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !932

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !932

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !946
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !946
  store i8 10, ptr %arrayidx17, align 1, !dbg !946, !tbaa !536
  br label %if.end18, !dbg !946

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !932
  ret i32 0, !dbg !932
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !949 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #13

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !955 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #13

; Function Attrs: nofree nounwind
declare !dbg !960 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !1015 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #14

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1018 {
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
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1032
    #dbg_value(i32 0, !1028, !DIExpression(), !1031)
  %cmp.not = icmp eq ptr %s, null, !dbg !1033
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1033

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #19, !dbg !1033
  unreachable, !dbg !1033

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1032
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
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1036, !tbaa !938, !DIAssignID !1038
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1027, !DIExpression(), !1038, ptr %endptr, !DIExpression(), !1031)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1036
  %conv = trunc i64 %call3 to i16, !dbg !1036
    #dbg_value(i16 %conv, !1029, !DIExpression(), !1031)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1039, !tbaa !938
  %3 = load i8, ptr %2, align 1, !dbg !1039, !tbaa !536
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1039
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1036

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1036

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1041, !tbaa !938
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1041
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1041
  br label %if.end9, !dbg !1041

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1036
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1036, !tbaa !1043
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1036
    #dbg_value(i64 %indvars.iv.next, !1028, !DIExpression(), !1031)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1036
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1036
  store i8 10, ptr %arrayidx11, align 1, !dbg !1036, !tbaa !536
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1036
    #dbg_value(ptr %call12, !1026, !DIExpression(), !1031)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1032
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1032
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1032
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1032, !llvm.loop !1045

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
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1046
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1046
  store i8 10, ptr %arrayidx17, align 1, !dbg !1046, !tbaa !536
  br label %if.end18, !dbg !1046

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1032
  ret i32 0, !dbg !1032
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1049 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1061
    #dbg_assign(i1 undef, !1058, !DIExpression(), !1061, ptr %endptr, !DIExpression(), !1062)
    #dbg_value(ptr %s, !1054, !DIExpression(), !1062)
    #dbg_value(ptr %arr, !1055, !DIExpression(), !1062)
    #dbg_value(i32 %n, !1056, !DIExpression(), !1062)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1063
    #dbg_value(i32 0, !1059, !DIExpression(), !1062)
  %cmp.not = icmp eq ptr %s, null, !dbg !1064
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1064

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #19, !dbg !1064
  unreachable, !dbg !1064

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1063
    #dbg_value(ptr %call, !1057, !DIExpression(), !1062)
    #dbg_value(i32 0, !1059, !DIExpression(), !1062)
  %cmp130 = icmp ne ptr %call, null, !dbg !1063
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1063
  %0 = and i1 %cmp231, %cmp130, !dbg !1063
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1063

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1063

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1063
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1063

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1057, !DIExpression(), !1062)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1059, !DIExpression(), !1062)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1067, !tbaa !938, !DIAssignID !1069
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1058, !DIExpression(), !1069, ptr %endptr, !DIExpression(), !1062)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1067
  %conv = trunc i64 %call3 to i32, !dbg !1067
    #dbg_value(i32 %conv, !1060, !DIExpression(), !1062)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1070, !tbaa !938
  %3 = load i8, ptr %2, align 1, !dbg !1070, !tbaa !536
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1070
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1067

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1067

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1072, !tbaa !938
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1072
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1072
  br label %if.end9, !dbg !1072

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1067
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1067, !tbaa !414
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1067
    #dbg_value(i64 %indvars.iv.next, !1059, !DIExpression(), !1062)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1067
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1067
  store i8 10, ptr %arrayidx11, align 1, !dbg !1067, !tbaa !536
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1067
    #dbg_value(ptr %call12, !1057, !DIExpression(), !1062)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1063
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1063
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1063
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1063, !llvm.loop !1074

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1063

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1063

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1063

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1063

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1075
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1075
  store i8 10, ptr %arrayidx17, align 1, !dbg !1075, !tbaa !536
  br label %if.end18, !dbg !1075

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1063
  ret i32 0, !dbg !1063
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1078 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1090
    #dbg_assign(i1 undef, !1087, !DIExpression(), !1090, ptr %endptr, !DIExpression(), !1091)
    #dbg_value(ptr %s, !1083, !DIExpression(), !1091)
    #dbg_value(ptr %arr, !1084, !DIExpression(), !1091)
    #dbg_value(i32 %n, !1085, !DIExpression(), !1091)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1092
    #dbg_value(i32 0, !1088, !DIExpression(), !1091)
  %cmp.not = icmp eq ptr %s, null, !dbg !1093
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1093

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #19, !dbg !1093
  unreachable, !dbg !1093

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1092
    #dbg_value(ptr %call, !1086, !DIExpression(), !1091)
    #dbg_value(i32 0, !1088, !DIExpression(), !1091)
  %cmp129 = icmp ne ptr %call, null, !dbg !1092
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1092
  %0 = and i1 %cmp230, %cmp129, !dbg !1092
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1092

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1092

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1092
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1092

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1086, !DIExpression(), !1091)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1088, !DIExpression(), !1091)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1096, !tbaa !938, !DIAssignID !1098
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1087, !DIExpression(), !1098, ptr %endptr, !DIExpression(), !1091)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1096
    #dbg_value(i64 %call3, !1089, !DIExpression(), !1091)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1099, !tbaa !938
  %3 = load i8, ptr %2, align 1, !dbg !1099, !tbaa !536
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1099
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1096

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1096

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1101, !tbaa !938
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1101
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1101
  br label %if.end8, !dbg !1101

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1096
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1096, !tbaa !1103
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1096
    #dbg_value(i64 %indvars.iv.next, !1088, !DIExpression(), !1091)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1096
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1096
  store i8 10, ptr %arrayidx10, align 1, !dbg !1096, !tbaa !536
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1096
    #dbg_value(ptr %call11, !1086, !DIExpression(), !1091)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1092
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1092
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1092
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1092, !llvm.loop !1105

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1092

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1092

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1092

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1092

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1106
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1106
  store i8 10, ptr %arrayidx16, align 1, !dbg !1106, !tbaa !536
  br label %if.end17, !dbg !1106

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1092
  ret i32 0, !dbg !1092
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1109 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1121
    #dbg_assign(i1 undef, !1118, !DIExpression(), !1121, ptr %endptr, !DIExpression(), !1122)
    #dbg_value(ptr %s, !1114, !DIExpression(), !1122)
    #dbg_value(ptr %arr, !1115, !DIExpression(), !1122)
    #dbg_value(i32 %n, !1116, !DIExpression(), !1122)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1123
    #dbg_value(i32 0, !1119, !DIExpression(), !1122)
  %cmp.not = icmp eq ptr %s, null, !dbg !1124
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1124

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #19, !dbg !1124
  unreachable, !dbg !1124

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1123
    #dbg_value(ptr %call, !1117, !DIExpression(), !1122)
    #dbg_value(i32 0, !1119, !DIExpression(), !1122)
  %cmp130 = icmp ne ptr %call, null, !dbg !1123
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1123
  %0 = and i1 %cmp231, %cmp130, !dbg !1123
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1123

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1123

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1123
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1123

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1117, !DIExpression(), !1122)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1119, !DIExpression(), !1122)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1127, !tbaa !938, !DIAssignID !1129
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1118, !DIExpression(), !1129, ptr %endptr, !DIExpression(), !1122)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1127
  %conv = trunc i64 %call3 to i8, !dbg !1127
    #dbg_value(i8 %conv, !1120, !DIExpression(), !1122)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1130, !tbaa !938
  %3 = load i8, ptr %2, align 1, !dbg !1130, !tbaa !536
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1130
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1127

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1127

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1132, !tbaa !938
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1132
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1132
  br label %if.end9, !dbg !1132

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1127
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1127, !tbaa !536
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1127
    #dbg_value(i64 %indvars.iv.next, !1119, !DIExpression(), !1122)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1127
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1127
  store i8 10, ptr %arrayidx11, align 1, !dbg !1127, !tbaa !536
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1127
    #dbg_value(ptr %call12, !1117, !DIExpression(), !1122)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1123
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1123
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1123
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1123, !llvm.loop !1134

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1123

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1123

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1123

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1123

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1135
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1135
  store i8 10, ptr %arrayidx17, align 1, !dbg !1135, !tbaa !536
  br label %if.end18, !dbg !1135

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1123
  ret i32 0, !dbg !1123
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1138 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1150
    #dbg_assign(i1 undef, !1147, !DIExpression(), !1150, ptr %endptr, !DIExpression(), !1151)
    #dbg_value(ptr %s, !1143, !DIExpression(), !1151)
    #dbg_value(ptr %arr, !1144, !DIExpression(), !1151)
    #dbg_value(i32 %n, !1145, !DIExpression(), !1151)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1152
    #dbg_value(i32 0, !1148, !DIExpression(), !1151)
  %cmp.not = icmp eq ptr %s, null, !dbg !1153
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1153

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #19, !dbg !1153
  unreachable, !dbg !1153

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1152
    #dbg_value(ptr %call, !1146, !DIExpression(), !1151)
    #dbg_value(i32 0, !1148, !DIExpression(), !1151)
  %cmp130 = icmp ne ptr %call, null, !dbg !1152
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1152
  %0 = and i1 %cmp231, %cmp130, !dbg !1152
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1152

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1152

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1152
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1152

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1146, !DIExpression(), !1151)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1148, !DIExpression(), !1151)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1156, !tbaa !938, !DIAssignID !1158
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1147, !DIExpression(), !1158, ptr %endptr, !DIExpression(), !1151)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1156
  %conv = trunc i64 %call3 to i16, !dbg !1156
    #dbg_value(i16 %conv, !1149, !DIExpression(), !1151)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1159, !tbaa !938
  %3 = load i8, ptr %2, align 1, !dbg !1159, !tbaa !536
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1159
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1156

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1156

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1161, !tbaa !938
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1161
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1161
  br label %if.end9, !dbg !1161

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1156
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1156, !tbaa !1043
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1156
    #dbg_value(i64 %indvars.iv.next, !1148, !DIExpression(), !1151)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1156
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1156
  store i8 10, ptr %arrayidx11, align 1, !dbg !1156, !tbaa !536
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1156
    #dbg_value(ptr %call12, !1146, !DIExpression(), !1151)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1152
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1152
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1152
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1152, !llvm.loop !1163

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1152

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1152

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1152

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1152

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1164
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1164
  store i8 10, ptr %arrayidx17, align 1, !dbg !1164, !tbaa !536
  br label %if.end18, !dbg !1164

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1152
  ret i32 0, !dbg !1152
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1167 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1178
    #dbg_assign(i1 undef, !1175, !DIExpression(), !1178, ptr %endptr, !DIExpression(), !1179)
    #dbg_value(ptr %s, !1171, !DIExpression(), !1179)
    #dbg_value(ptr %arr, !1172, !DIExpression(), !1179)
    #dbg_value(i32 %n, !1173, !DIExpression(), !1179)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1180
    #dbg_value(i32 0, !1176, !DIExpression(), !1179)
  %cmp.not = icmp eq ptr %s, null, !dbg !1181
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1181

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #19, !dbg !1181
  unreachable, !dbg !1181

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1180
    #dbg_value(ptr %call, !1174, !DIExpression(), !1179)
    #dbg_value(i32 0, !1176, !DIExpression(), !1179)
  %cmp130 = icmp ne ptr %call, null, !dbg !1180
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1180
  %0 = and i1 %cmp231, %cmp130, !dbg !1180
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1180

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1180

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1180
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1180

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1174, !DIExpression(), !1179)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1176, !DIExpression(), !1179)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1184, !tbaa !938, !DIAssignID !1186
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1175, !DIExpression(), !1186, ptr %endptr, !DIExpression(), !1179)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1184
  %conv = trunc i64 %call3 to i32, !dbg !1184
    #dbg_value(i32 %conv, !1177, !DIExpression(), !1179)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1187, !tbaa !938
  %3 = load i8, ptr %2, align 1, !dbg !1187, !tbaa !536
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1187
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1184

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1184

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1189, !tbaa !938
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1189
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1189
  br label %if.end9, !dbg !1189

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1184
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1184, !tbaa !414
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1184
    #dbg_value(i64 %indvars.iv.next, !1176, !DIExpression(), !1179)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1184
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1184
  store i8 10, ptr %arrayidx11, align 1, !dbg !1184, !tbaa !536
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1184
    #dbg_value(ptr %call12, !1174, !DIExpression(), !1179)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1180
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1180
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1180
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1180, !llvm.loop !1191

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1180

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1180

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1180

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1180

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1192
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1192
  store i8 10, ptr %arrayidx17, align 1, !dbg !1192, !tbaa !536
  br label %if.end18, !dbg !1192

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1180
  ret i32 0, !dbg !1180
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1195 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1207
    #dbg_assign(i1 undef, !1204, !DIExpression(), !1207, ptr %endptr, !DIExpression(), !1208)
    #dbg_value(ptr %s, !1200, !DIExpression(), !1208)
    #dbg_value(ptr %arr, !1201, !DIExpression(), !1208)
    #dbg_value(i32 %n, !1202, !DIExpression(), !1208)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1209
    #dbg_value(i32 0, !1205, !DIExpression(), !1208)
  %cmp.not = icmp eq ptr %s, null, !dbg !1210
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1210

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #19, !dbg !1210
  unreachable, !dbg !1210

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1209
    #dbg_value(ptr %call, !1203, !DIExpression(), !1208)
    #dbg_value(i32 0, !1205, !DIExpression(), !1208)
  %cmp129 = icmp ne ptr %call, null, !dbg !1209
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1209
  %0 = and i1 %cmp230, %cmp129, !dbg !1209
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1209

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1209

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1209
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1209

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1203, !DIExpression(), !1208)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1205, !DIExpression(), !1208)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1213, !tbaa !938, !DIAssignID !1215
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1204, !DIExpression(), !1215, ptr %endptr, !DIExpression(), !1208)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1213
    #dbg_value(i64 %call3, !1206, !DIExpression(), !1208)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1216, !tbaa !938
  %3 = load i8, ptr %2, align 1, !dbg !1216, !tbaa !536
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1216
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1213

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1213

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1218, !tbaa !938
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1218
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1218
  br label %if.end8, !dbg !1218

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1213
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1213, !tbaa !1103
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1213
    #dbg_value(i64 %indvars.iv.next, !1205, !DIExpression(), !1208)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1213
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1213
  store i8 10, ptr %arrayidx10, align 1, !dbg !1213, !tbaa !536
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1213
    #dbg_value(ptr %call11, !1203, !DIExpression(), !1208)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1209
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1209
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1209
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1209, !llvm.loop !1220

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1209

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1209

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1209

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1209

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1221
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1221
  store i8 10, ptr %arrayidx16, align 1, !dbg !1221, !tbaa !536
  br label %if.end17, !dbg !1221

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1209
  ret i32 0, !dbg !1209
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1224 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1236
    #dbg_assign(i1 undef, !1233, !DIExpression(), !1236, ptr %endptr, !DIExpression(), !1237)
    #dbg_value(ptr %s, !1229, !DIExpression(), !1237)
    #dbg_value(ptr %arr, !1230, !DIExpression(), !1237)
    #dbg_value(i32 %n, !1231, !DIExpression(), !1237)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1238
    #dbg_value(i32 0, !1234, !DIExpression(), !1237)
  %cmp.not = icmp eq ptr %s, null, !dbg !1239
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1239

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #19, !dbg !1239
  unreachable, !dbg !1239

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1238
    #dbg_value(ptr %call, !1232, !DIExpression(), !1237)
    #dbg_value(i32 0, !1234, !DIExpression(), !1237)
  %cmp129 = icmp ne ptr %call, null, !dbg !1238
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1238
  %0 = and i1 %cmp230, %cmp129, !dbg !1238
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1238

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1238

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1238
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1238

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1232, !DIExpression(), !1237)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1234, !DIExpression(), !1237)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1242, !tbaa !938, !DIAssignID !1244
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1233, !DIExpression(), !1244, ptr %endptr, !DIExpression(), !1237)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1242
    #dbg_value(float %call3, !1235, !DIExpression(), !1237)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1245, !tbaa !938
  %3 = load i8, ptr %2, align 1, !dbg !1245, !tbaa !536
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1245
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1242

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1242

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1247, !tbaa !938
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1247
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1247
  br label %if.end8, !dbg !1247

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1242
  store float %call3, ptr %arrayidx, align 4, !dbg !1242, !tbaa !1249
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1242
    #dbg_value(i64 %indvars.iv.next, !1234, !DIExpression(), !1237)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1242
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1242
  store i8 10, ptr %arrayidx10, align 1, !dbg !1242, !tbaa !536
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1242
    #dbg_value(ptr %call11, !1232, !DIExpression(), !1237)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1238
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1238
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1238
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1238, !llvm.loop !1251

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1238

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1238

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1238

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1238

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1252
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1252
  store i8 10, ptr %arrayidx16, align 1, !dbg !1252, !tbaa !536
  br label %if.end17, !dbg !1252

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1238
  ret i32 0, !dbg !1238
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1255 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1258 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1269
    #dbg_assign(i1 undef, !1266, !DIExpression(), !1269, ptr %endptr, !DIExpression(), !1270)
    #dbg_value(ptr %s, !1262, !DIExpression(), !1270)
    #dbg_value(ptr %arr, !1263, !DIExpression(), !1270)
    #dbg_value(i32 %n, !1264, !DIExpression(), !1270)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1271
    #dbg_value(i32 0, !1267, !DIExpression(), !1270)
  %cmp.not = icmp eq ptr %s, null, !dbg !1272
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1272

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #19, !dbg !1272
  unreachable, !dbg !1272

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1271
    #dbg_value(ptr %call, !1265, !DIExpression(), !1270)
    #dbg_value(i32 0, !1267, !DIExpression(), !1270)
  %cmp129 = icmp ne ptr %call, null, !dbg !1271
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1271
  %0 = and i1 %cmp230, %cmp129, !dbg !1271
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1271

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1271

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1271
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1271

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1265, !DIExpression(), !1270)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1267, !DIExpression(), !1270)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1275, !tbaa !938, !DIAssignID !1277
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1266, !DIExpression(), !1277, ptr %endptr, !DIExpression(), !1270)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1275
    #dbg_value(double %call3, !1268, !DIExpression(), !1270)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1278, !tbaa !938
  %3 = load i8, ptr %2, align 1, !dbg !1278, !tbaa !536
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1278
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1275

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1275

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1280, !tbaa !938
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1280
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1280
  br label %if.end8, !dbg !1280

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1275
  store double %call3, ptr %arrayidx, align 8, !dbg !1275, !tbaa !633
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1275
    #dbg_value(i64 %indvars.iv.next, !1267, !DIExpression(), !1270)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1275
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1275
  store i8 10, ptr %arrayidx10, align 1, !dbg !1275, !tbaa !536
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1275
    #dbg_value(ptr %call11, !1265, !DIExpression(), !1270)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1271
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1271
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1271
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1271, !llvm.loop !1282

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1271

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1271

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1271

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1271

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1283
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1283
  store i8 10, ptr %arrayidx16, align 1, !dbg !1283, !tbaa !536
  br label %if.end17, !dbg !1283

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1271
  ret i32 0, !dbg !1271
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1286 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1289 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1293, !DIExpression(), !1298)
    #dbg_value(ptr %arr, !1294, !DIExpression(), !1298)
    #dbg_value(i32 %n, !1295, !DIExpression(), !1298)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1299
  br i1 %cmp, label %if.end, label %if.else, !dbg !1299

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1299
  unreachable, !dbg !1299

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1302
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1304

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1304

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #22, !dbg !1305
  %conv = trunc i64 %call to i32, !dbg !1305
    #dbg_value(i32 %conv, !1295, !DIExpression(), !1298)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1307

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1295, !DIExpression(), !1298)
    #dbg_value(i32 0, !1297, !DIExpression(), !1298)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1308
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1309

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1309

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1309

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1310

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1311
    #dbg_value(i32 %add, !1297, !DIExpression(), !1298)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1308
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1309, !llvm.loop !1313

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1309

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1309

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1297, !DIExpression(), !1298)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1315
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1315
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1316
  %conv6 = sext i32 %sub to i64, !dbg !1317
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #18, !dbg !1318
  %conv8 = trunc i64 %call7 to i32, !dbg !1318
    #dbg_value(i32 %conv8, !1296, !DIExpression(), !1298)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1319
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1297, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1298)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1319

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1319
  unreachable, !dbg !1319

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #18, !dbg !1322
  %conv16 = trunc i64 %call15 to i32, !dbg !1322
    #dbg_value(i32 %conv16, !1296, !DIExpression(), !1298)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1324
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1324

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1324
  unreachable, !dbg !1324

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1327
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1328, !llvm.loop !1329

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1328

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1331
}

; Function Attrs: nofree
declare !dbg !1332 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #10

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1337 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1341, !DIExpression(), !1345)
    #dbg_value(ptr %arr, !1342, !DIExpression(), !1345)
    #dbg_value(i32 %n, !1343, !DIExpression(), !1345)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1346
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1346

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1344, !DIExpression(), !1345)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1349
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1352

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1352

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1349
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1352

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #19, !dbg !1346
  unreachable, !dbg !1346

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1344, !DIExpression(), !1345)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1353
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1353, !tbaa !536
  %conv = zext i8 %0 to i32, !dbg !1353
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1353
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1349
    #dbg_value(i64 %indvars.iv.next, !1344, !DIExpression(), !1345)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1349
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1352, !llvm.loop !1355

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1352

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1352

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1356
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #15 !dbg !1357 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1374
    #dbg_assign(i1 undef, !1363, !DIExpression(), !1374, ptr %args, !DIExpression(), !1375)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1376
    #dbg_assign(i1 undef, !1370, !DIExpression(), !1376, ptr %buffer, !DIExpression(), !1375)
    #dbg_value(i32 %fd, !1361, !DIExpression(), !1375)
    #dbg_value(ptr %format, !1362, !DIExpression(), !1375)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #18, !dbg !1377
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1378
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1379
  %0 = load ptr, ptr %args, align 8, !dbg !1380, !tbaa !938
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #18, !dbg !1381
    #dbg_value(i32 %call, !1367, !DIExpression(), !1375)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1382
  %cmp = icmp slt i32 %call, 256, !dbg !1383
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1383

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1368, !DIExpression(), !1375)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1386
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1387

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1387

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1387

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1383
  unreachable, !dbg !1383

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1388
    #dbg_value(i32 %add, !1368, !DIExpression(), !1375)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1386
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1387, !llvm.loop !1390

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1387

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1387

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1368, !DIExpression(), !1375)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1392
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1392
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1393
  %conv = sext i32 %sub to i64, !dbg !1394
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #18, !dbg !1395
  %conv3 = trunc i64 %call2 to i32, !dbg !1395
    #dbg_value(i32 %conv3, !1369, !DIExpression(), !1375)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1396
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1368, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1375)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1396

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1396
  unreachable, !dbg !1396

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1399
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1399

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1399
  unreachable, !dbg !1399

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1402
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #18, !dbg !1402
  ret void, !dbg !1403
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #16

; Function Attrs: nofree nounwind
declare !dbg !1404 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #8

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #16

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1409 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #19, !dbg !1418
  unreachable, !dbg !1418

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1416, !DIExpression(), !1417)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1425
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1425, !tbaa !1043
  %conv = zext i16 %0 to i32, !dbg !1425
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1425
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
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1429 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #19, !dbg !1438
  unreachable, !dbg !1438

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1436, !DIExpression(), !1437)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1445
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1445, !tbaa !414
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1445
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
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1449 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #19, !dbg !1458
  unreachable, !dbg !1458

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1456, !DIExpression(), !1457)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1465
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1465, !tbaa !1103
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1465
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
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1469 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #19, !dbg !1478
  unreachable, !dbg !1478

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1476, !DIExpression(), !1477)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1485
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1485, !tbaa !536
  %conv = sext i8 %0 to i32, !dbg !1485
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1485
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
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1489 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1493, !DIExpression(), !1497)
    #dbg_value(ptr %arr, !1494, !DIExpression(), !1497)
    #dbg_value(i32 %n, !1495, !DIExpression(), !1497)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1498
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1498

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1496, !DIExpression(), !1497)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1501
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1504

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1504

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1501
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1504

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #19, !dbg !1498
  unreachable, !dbg !1498

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1496, !DIExpression(), !1497)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1505
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1505, !tbaa !1043
  %conv = sext i16 %0 to i32, !dbg !1505
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1505
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1501
    #dbg_value(i64 %indvars.iv.next, !1496, !DIExpression(), !1497)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1501
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1504, !llvm.loop !1507

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1504

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1504

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1508
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !598 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !597, !DIExpression(), !1509)
    #dbg_value(ptr %arr, !602, !DIExpression(), !1509)
    #dbg_value(i32 %n, !603, !DIExpression(), !1509)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1510
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1510

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !604, !DIExpression(), !1509)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1513
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1514

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1514

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1513
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1514

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #19, !dbg !1510
  unreachable, !dbg !1510

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !604, !DIExpression(), !1509)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1515
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1515, !tbaa !414
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1515
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1513
    #dbg_value(i64 %indvars.iv.next, !604, !DIExpression(), !1509)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1513
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1514, !llvm.loop !1516

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1514

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1514

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1517
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1518 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1522, !DIExpression(), !1526)
    #dbg_value(ptr %arr, !1523, !DIExpression(), !1526)
    #dbg_value(i32 %n, !1524, !DIExpression(), !1526)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1527
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1527

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1525, !DIExpression(), !1526)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1530
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1533

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1533

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1530
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1533

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #19, !dbg !1527
  unreachable, !dbg !1527

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1525, !DIExpression(), !1526)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1534
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1534, !tbaa !1103
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1534
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1530
    #dbg_value(i64 %indvars.iv.next, !1525, !DIExpression(), !1526)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1530
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1533, !llvm.loop !1536

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1533

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1533

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1537
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1538 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1542, !DIExpression(), !1546)
    #dbg_value(ptr %arr, !1543, !DIExpression(), !1546)
    #dbg_value(i32 %n, !1544, !DIExpression(), !1546)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1547
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1547

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1545, !DIExpression(), !1546)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1550
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1553

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1553

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1550
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1553

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #19, !dbg !1547
  unreachable, !dbg !1547

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1545, !DIExpression(), !1546)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1554
  %0 = load float, ptr %arrayidx, align 4, !dbg !1554, !tbaa !1249
  %conv = fpext float %0 to double, !dbg !1554
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1554
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1550
    #dbg_value(i64 %indvars.iv.next, !1545, !DIExpression(), !1546)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1550
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1553, !llvm.loop !1556

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1553

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1553

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1557
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !619 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !618, !DIExpression(), !1558)
    #dbg_value(ptr %arr, !623, !DIExpression(), !1558)
    #dbg_value(i32 %n, !624, !DIExpression(), !1558)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1559
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1559

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !625, !DIExpression(), !1558)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1562
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1563

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1563

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1562
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1563

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #19, !dbg !1559
  unreachable, !dbg !1559

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !625, !DIExpression(), !1558)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1564
  %0 = load double, ptr %arrayidx, align 8, !dbg !1564, !tbaa !633
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1564
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1562
    #dbg_value(i64 %indvars.iv.next, !625, !DIExpression(), !1558)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1562
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1563, !llvm.loop !1565

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1563

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1563

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1566
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #2 !dbg !587 {
entry.split:
    #dbg_value(i32 %fd, !586, !DIExpression(), !1567)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1568
  br i1 %cmp, label %if.end, label %if.else, !dbg !1568

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1568
  unreachable, !dbg !1568

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1569
  ret i32 0, !dbg !1570
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #2 !dbg !1571 {
entry.split:
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.3128.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %has_errors.2130.i.reg2mem78 = alloca i32, align 4
  %indvars.iv135.i.reg2mem80 = alloca i64, align 8
  %has_errors.1132.i.reg2mem82 = alloca i32, align 4
  %indvars.iv138.i.reg2mem84 = alloca i64, align 8
  %has_errors.0134.i.reg2mem86 = alloca i32, align 4
  %indvars.iv141.i.reg2mem88 = alloca i64, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem90 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem92 = alloca ptr, align 8
  %i.041.i.i.reg2mem94 = alloca i32, align 4
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %check_file.0.reg2mem96 = alloca ptr, align 8
  %in_file.05.reg2mem98 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1575, !DIExpression(), !1584)
    #dbg_value(ptr %argv, !1576, !DIExpression(), !1584)
  %cmp = icmp slt i32 %argc, 4, !dbg !1585
  br i1 %cmp, label %if.end, label %if.else, !dbg !1585

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.15, ptr noundef nonnull @.str.2.16, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1585
  unreachable, !dbg !1585

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1577, !DIExpression(), !1584)
    #dbg_value(ptr @.str.4.17, !1578, !DIExpression(), !1584)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1588
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1590

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.17, ptr %check_file.0.reg2mem96, align 8
  store ptr @.str.3, ptr %in_file.05.reg2mem98, align 8
  br label %if.end7, !dbg !1590

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1591
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1591
    #dbg_value(ptr %0, !1577, !DIExpression(), !1584)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1592
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1594

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.17, ptr %check_file.0.reg2mem96, align 8
  store ptr %0, ptr %in_file.05.reg2mem98, align 8
  br label %if.end7, !dbg !1594

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1595
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1595
    #dbg_value(ptr %1, !1578, !DIExpression(), !1584)
  store ptr %1, ptr %check_file.0.reg2mem96, align 8
  store ptr %0, ptr %in_file.05.reg2mem98, align 8
  br label %if.end7, !dbg !1596

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem96.0.check_file.0.reload97, !1578, !DIExpression(), !1584)
  %in_file.05.reg2mem98.0.in_file.05.reload99 = load ptr, ptr %in_file.05.reg2mem98, align 8
  %check_file.0.reg2mem96.0.check_file.0.reload97 = load ptr, ptr %check_file.0.reg2mem96, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1597, !tbaa !414
  %conv = sext i32 %2 to i64, !dbg !1597
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #20, !dbg !1598
    #dbg_value(ptr %call, !1580, !DIExpression(), !1584)
  %cmp8.not = icmp eq ptr %call, null, !dbg !1599
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1599

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.18, ptr noundef nonnull @.str.2.16, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1599
  unreachable, !dbg !1599

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.05.reg2mem98.0.in_file.05.reload99, i32 noundef signext 0) #18, !dbg !1602
    #dbg_value(i32 %call14, !1579, !DIExpression(), !1584)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1603
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1603

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.19, ptr noundef nonnull @.str.2.16, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1603
  unreachable, !dbg !1603

if.end20:                                         ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #18, !dbg !1606
    #dbg_value(ptr %call, !507, !DIExpression(), !1607)
    #dbg_value(ptr %call, !508, !DIExpression(), !1607)
  %force.i = getelementptr inbounds i8, ptr %call, i64 256, !dbg !1609
  %position.i = getelementptr inbounds i8, ptr %call, i64 15616, !dbg !1610
  tail call void @md(ptr noundef nonnull %call, ptr noundef nonnull %force.i, ptr noundef nonnull %position.i) #18, !dbg !1611
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #18, !dbg !1612
    #dbg_value(i32 %call21, !1581, !DIExpression(), !1584)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1613
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1613

if.else26:                                        ; preds = %if.end20
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.16, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1613
  unreachable, !dbg !1613

if.end27:                                         ; preds = %if.end20
    #dbg_value(i32 %call21, !671, !DIExpression(), !1616)
    #dbg_value(ptr %call, !672, !DIExpression(), !1616)
    #dbg_value(ptr %call, !673, !DIExpression(), !1616)
    #dbg_value(i32 %call21, !586, !DIExpression(), !1618)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1620
  br i1 %cmp.i.i.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1620

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1620
  unreachable, !dbg !1620

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1621
    #dbg_value(i32 %call21, !618, !DIExpression(), !1622)
    #dbg_value(ptr %force.i, !623, !DIExpression(), !1622)
    #dbg_value(i32 1920, !624, !DIExpression(), !1622)
    #dbg_value(i32 0, !625, !DIExpression(), !1622)
  store i64 0, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1624

for.body.i.i:                                     ; preds = %for.body.i.i.for.body.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !625, !DIExpression(), !1622)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %arrayidx.i.i = getelementptr inbounds double, ptr %force.i, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !1625
  %3 = load double, ptr %arrayidx.i.i, align 8, !dbg !1625, !tbaa !633
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.21, double noundef %3), !dbg !1625
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !1626
    #dbg_value(i64 %indvars.iv.next.i.i, !625, !DIExpression(), !1622)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 1920, !dbg !1626
  br i1 %exitcond.not.i.i, label %data_to_output.exit, label %for.body.i.i.for.body.i.i_crit_edge, !dbg !1624, !llvm.loop !1627

for.body.i.i.for.body.i.i_crit_edge:              ; preds = %for.body.i.i
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1624

data_to_output.exit:                              ; preds = %for.body.i.i
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #18, !dbg !1628
  %4 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1629, !tbaa !414
  %conv29 = sext i32 %4 to i64, !dbg !1629
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #20, !dbg !1630
    #dbg_value(ptr %call30, !1583, !DIExpression(), !1584)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1631
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1631

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.20, ptr noundef nonnull @.str.2.16, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1631
  unreachable, !dbg !1631

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem96.0.check_file.0.reload97, i32 noundef signext 0) #18, !dbg !1634
    #dbg_value(i32 %call37, !1582, !DIExpression(), !1584)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1635
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1635

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.21, ptr noundef nonnull @.str.2.16, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1635
  unreachable, !dbg !1635

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !639, !DIExpression(), !1638)
    #dbg_value(ptr %call30, !640, !DIExpression(), !1638)
    #dbg_value(ptr %call30, !641, !DIExpression(), !1638)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(30976) %call30, i8 0, i64 30976, i1 false), !dbg !1640
  %call.i = tail call ptr @readfile(i32 noundef signext %call37) #18, !dbg !1641
    #dbg_value(ptr %call.i, !642, !DIExpression(), !1638)
    #dbg_value(ptr %call.i, !526, !DIExpression(), !1642)
    #dbg_value(i32 1, !531, !DIExpression(), !1642)
    #dbg_value(i32 0, !532, !DIExpression(), !1642)
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem92, align 8
  store i32 0, ptr %i.041.i.i.reg2mem94, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i.reg2mem94.0.load, !532, !DIExpression(), !1642)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem92.0.s.addr.040.i.i.reload93, !526, !DIExpression(), !1642)
  %i.041.i.i.reg2mem94.0.load = load i32, ptr %i.041.i.i.reg2mem94, align 4
  %s.addr.040.i.i.reg2mem92.0.s.addr.040.i.i.reload93 = load ptr, ptr %s.addr.040.i.i.reg2mem92, align 8
  %5 = load i8, ptr %s.addr.040.i.i.reg2mem92.0.s.addr.040.i.i.reload93, align 1, !dbg !1644, !tbaa !536
  switch i8 %5, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1645

land.rhs.i.i.output_to_data.exit_crit_edge:       ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem92.0.s.addr.040.i.i.reload93, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1645

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem94.0.load, ptr %i.1.i.i.reg2mem90, align 4
  br label %if.end21.i.i, !dbg !1645

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem92.0.s.addr.040.i.i.reload93, i64 1, !dbg !1646
  %6 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !1646, !tbaa !536
  %cmp13.i.i = icmp eq i8 %6, 37, !dbg !1647
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1648

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem94.0.load, ptr %i.1.i.i.reg2mem90, align 4
  br label %if.end21.i.i, !dbg !1648

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem92.0.s.addr.040.i.i.reload93, i64 2, !dbg !1649
  %7 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1649, !tbaa !536
  %cmp18.i.i = icmp eq i8 %7, 10, !dbg !1650
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1651
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem94.0.load, %inc.i.i, !dbg !1651
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem90, align 4
  br label %if.end21.i.i, !dbg !1651

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem90.0.load, !532, !DIExpression(), !1642)
  %i.1.i.i.reg2mem90.0.load = load i32, ptr %i.1.i.i.reg2mem90, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem92.0.s.addr.040.i.i.reload93, i64 1, !dbg !1652
    #dbg_value(ptr %incdec.ptr.i.i, !526, !DIExpression(), !1642)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem90.0.load, 1, !dbg !1653
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1654, !llvm.loop !1655

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem92, align 8
  store i32 %i.1.i.i.reg2mem90.0.load, ptr %i.041.i.i.reg2mem94, align 4
  br label %land.rhs.i.i, !dbg !1654

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1657, !tbaa !536
  %8 = icmp eq i8 %.pre.i.i, 0, !dbg !1658
  %9 = select i1 %8, i64 0, i64 2, !dbg !1659
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1654

output_to_data.exit:                              ; preds = %land.rhs.i.i.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1659
    #dbg_value(ptr %spec.select38.i.i, !643, !DIExpression(), !1638)
  %force.i2 = getelementptr inbounds i8, ptr %call30, i64 256, !dbg !1660
  %call2.i = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i.i, ptr noundef nonnull %force.i2, i32 noundef signext 1920) #18, !dbg !1661
  tail call void @free(ptr noundef %call.i) #18, !dbg !1662
    #dbg_value(ptr %call, !691, !DIExpression(), !1663)
    #dbg_value(ptr %call30, !692, !DIExpression(), !1663)
    #dbg_value(ptr %call, !693, !DIExpression(), !1663)
    #dbg_value(ptr %call30, !694, !DIExpression(), !1663)
    #dbg_value(i32 0, !695, !DIExpression(), !1663)
    #dbg_value(i32 0, !696, !DIExpression(), !1663)
  store i32 0, ptr %has_errors.0134.i.reg2mem86, align 4
  store i64 0, ptr %indvars.iv141.i.reg2mem88, align 8
  br label %for.cond1.preheader.i, !dbg !1666

for.cond1.preheader.i:                            ; preds = %for.inc86.i.for.cond1.preheader.i_crit_edge, %output_to_data.exit
    #dbg_value(i64 %indvars.iv141.i.reg2mem88.0.load, !696, !DIExpression(), !1663)
    #dbg_value(i32 %has_errors.0134.i.reg2mem86.0.load, !695, !DIExpression(), !1663)
    #dbg_value(i32 0, !697, !DIExpression(), !1663)
  %indvars.iv141.i.reg2mem88.0.load = load i64, ptr %indvars.iv141.i.reg2mem88, align 8
  %has_errors.0134.i.reg2mem86.0.load = load i32, ptr %has_errors.0134.i.reg2mem86, align 4
  store i32 %has_errors.0134.i.reg2mem86.0.load, ptr %has_errors.1132.i.reg2mem82, align 4
  store i64 0, ptr %indvars.iv138.i.reg2mem84, align 8
  br label %for.cond4.preheader.i, !dbg !1667

for.cond4.preheader.i:                            ; preds = %for.inc83.i.for.cond4.preheader.i_crit_edge, %for.cond1.preheader.i
    #dbg_value(i64 %indvars.iv138.i.reg2mem84.0.load, !697, !DIExpression(), !1663)
    #dbg_value(i32 %has_errors.1132.i.reg2mem82.0.load, !695, !DIExpression(), !1663)
    #dbg_value(i32 0, !698, !DIExpression(), !1663)
  %indvars.iv138.i.reg2mem84.0.load = load i64, ptr %indvars.iv138.i.reg2mem84, align 8
  %has_errors.1132.i.reg2mem82.0.load = load i32, ptr %has_errors.1132.i.reg2mem82, align 4
  store i32 %has_errors.1132.i.reg2mem82.0.load, ptr %has_errors.2130.i.reg2mem78, align 4
  store i64 0, ptr %indvars.iv135.i.reg2mem80, align 8
  br label %for.cond7.preheader.i, !dbg !1668

for.cond7.preheader.i:                            ; preds = %for.inc80.i.for.cond7.preheader.i_crit_edge, %for.cond4.preheader.i
    #dbg_value(i64 %indvars.iv135.i.reg2mem80.0.load, !698, !DIExpression(), !1663)
    #dbg_value(i32 %has_errors.2130.i.reg2mem78.0.load, !695, !DIExpression(), !1663)
    #dbg_value(i32 0, !699, !DIExpression(), !1663)
  %indvars.iv135.i.reg2mem80.0.load = load i64, ptr %indvars.iv135.i.reg2mem80, align 8
  %has_errors.2130.i.reg2mem78.0.load = load i32, ptr %has_errors.2130.i.reg2mem78, align 4
  store i32 %has_errors.2130.i.reg2mem78.0.load, ptr %has_errors.3128.i.reg2mem, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body9.i, !dbg !1669

for.body9.i:                                      ; preds = %for.body9.i.for.body9.i_crit_edge, %for.cond7.preheader.i
    #dbg_value(i32 %has_errors.3128.i.reg2mem.0.load, !695, !DIExpression(), !1663)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !699, !DIExpression(), !1663)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %has_errors.3128.i.reg2mem.0.load = load i32, ptr %has_errors.3128.i.reg2mem, align 4
  %arrayidx15.i = getelementptr inbounds %struct.bench_args_t, ptr %call, i64 0, i32 1, i64 %indvars.iv141.i.reg2mem88.0.load, i64 %indvars.iv138.i.reg2mem84.0.load, i64 %indvars.iv135.i.reg2mem80.0.load, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1670
  %10 = load double, ptr %arrayidx15.i, align 8, !dbg !1671, !tbaa !470
  %arrayidx24.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 1, i64 %indvars.iv141.i.reg2mem88.0.load, i64 %indvars.iv138.i.reg2mem84.0.load, i64 %indvars.iv135.i.reg2mem80.0.load, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1672
  %11 = load double, ptr %arrayidx24.i, align 8, !dbg !1673, !tbaa !470
  %sub.i = fsub double %10, %11, !dbg !1674
    #dbg_value(double %sub.i, !700, !DIExpression(), !1663)
  %y.i = getelementptr inbounds %struct.bench_args_t, ptr %call, i64 0, i32 1, i64 %indvars.iv141.i.reg2mem88.0.load, i64 %indvars.iv138.i.reg2mem84.0.load, i64 %indvars.iv135.i.reg2mem80.0.load, i64 %indvars.iv.i.reg2mem.0.load, i32 1, !dbg !1675
  %12 = load double, ptr %y.i, align 8, !dbg !1675, !tbaa !474
  %y44.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 1, i64 %indvars.iv141.i.reg2mem88.0.load, i64 %indvars.iv138.i.reg2mem84.0.load, i64 %indvars.iv135.i.reg2mem80.0.load, i64 %indvars.iv.i.reg2mem.0.load, i32 1, !dbg !1676
  %13 = load double, ptr %y44.i, align 8, !dbg !1676, !tbaa !474
  %sub45.i = fsub double %12, %13, !dbg !1677
    #dbg_value(double %sub45.i, !701, !DIExpression(), !1663)
  %z.i = getelementptr inbounds %struct.bench_args_t, ptr %call, i64 0, i32 1, i64 %indvars.iv141.i.reg2mem88.0.load, i64 %indvars.iv138.i.reg2mem84.0.load, i64 %indvars.iv135.i.reg2mem80.0.load, i64 %indvars.iv.i.reg2mem.0.load, i32 2, !dbg !1678
  %14 = load double, ptr %z.i, align 8, !dbg !1678, !tbaa !476
  %z64.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 1, i64 %indvars.iv141.i.reg2mem88.0.load, i64 %indvars.iv138.i.reg2mem84.0.load, i64 %indvars.iv135.i.reg2mem80.0.load, i64 %indvars.iv.i.reg2mem.0.load, i32 2, !dbg !1679
  %15 = load double, ptr %z64.i, align 8, !dbg !1679, !tbaa !476
  %sub65.i = fsub double %14, %15, !dbg !1680
    #dbg_value(double %sub65.i, !702, !DIExpression(), !1663)
  %16 = tail call double @llvm.fabs.f64(double %sub.i), !dbg !1681
  %17 = fcmp ogt double %16, 0x3EB0C6F7A0B5ED8D, !dbg !1681
    #dbg_value(!DIArgList(i32 %has_errors.3128.i.reg2mem.0.load, i1 %17), !695, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !1663)
  %18 = tail call double @llvm.fabs.f64(double %sub45.i), !dbg !1682
  %19 = fcmp ogt double %18, 0x3EB0C6F7A0B5ED8D, !dbg !1682
  %20 = or i1 %17, %19, !dbg !1683
    #dbg_value(!DIArgList(i32 %has_errors.3128.i.reg2mem.0.load, i1 %20), !695, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !1663)
  %21 = tail call double @llvm.fabs.f64(double %sub65.i), !dbg !1684
  %22 = fcmp ogt double %21, 0x3EB0C6F7A0B5ED8D, !dbg !1684
  %23 = or i1 %20, %22, !dbg !1685
  %24 = zext i1 %23 to i32, !dbg !1685
  %or79.i = or i32 %has_errors.3128.i.reg2mem.0.load, %24, !dbg !1685
    #dbg_value(i32 %or79.i, !695, !DIExpression(), !1663)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1686
    #dbg_value(i64 %indvars.iv.next.i, !699, !DIExpression(), !1663)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 10, !dbg !1687
  br i1 %exitcond.not.i, label %for.inc80.i, label %for.body9.i.for.body9.i_crit_edge, !dbg !1669, !llvm.loop !1688

for.body9.i.for.body9.i_crit_edge:                ; preds = %for.body9.i
  store i32 %or79.i, ptr %has_errors.3128.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body9.i, !dbg !1669

for.inc80.i:                                      ; preds = %for.body9.i
  %indvars.iv.next136.i = add nuw nsw i64 %indvars.iv135.i.reg2mem80.0.load, 1, !dbg !1690
    #dbg_value(i32 %or79.i, !695, !DIExpression(), !1663)
    #dbg_value(i64 %indvars.iv.next136.i, !698, !DIExpression(), !1663)
  %exitcond137.not.i = icmp eq i64 %indvars.iv.next136.i, 4, !dbg !1691
  br i1 %exitcond137.not.i, label %for.inc83.i, label %for.inc80.i.for.cond7.preheader.i_crit_edge, !dbg !1668, !llvm.loop !1692

for.inc80.i.for.cond7.preheader.i_crit_edge:      ; preds = %for.inc80.i
  store i32 %or79.i, ptr %has_errors.2130.i.reg2mem78, align 4
  store i64 %indvars.iv.next136.i, ptr %indvars.iv135.i.reg2mem80, align 8
  br label %for.cond7.preheader.i, !dbg !1668

for.inc83.i:                                      ; preds = %for.inc80.i
  %indvars.iv.next139.i = add nuw nsw i64 %indvars.iv138.i.reg2mem84.0.load, 1, !dbg !1694
    #dbg_value(i32 %or79.i, !695, !DIExpression(), !1663)
    #dbg_value(i64 %indvars.iv.next139.i, !697, !DIExpression(), !1663)
  %exitcond140.not.i = icmp eq i64 %indvars.iv.next139.i, 4, !dbg !1695
  br i1 %exitcond140.not.i, label %for.inc86.i, label %for.inc83.i.for.cond4.preheader.i_crit_edge, !dbg !1667, !llvm.loop !1696

for.inc83.i.for.cond4.preheader.i_crit_edge:      ; preds = %for.inc83.i
  store i32 %or79.i, ptr %has_errors.1132.i.reg2mem82, align 4
  store i64 %indvars.iv.next139.i, ptr %indvars.iv138.i.reg2mem84, align 8
  br label %for.cond4.preheader.i, !dbg !1667

for.inc86.i:                                      ; preds = %for.inc83.i
  %indvars.iv.next142.i = add nuw nsw i64 %indvars.iv141.i.reg2mem88.0.load, 1, !dbg !1698
    #dbg_value(i32 %or79.i, !695, !DIExpression(), !1663)
    #dbg_value(i64 %indvars.iv.next142.i, !696, !DIExpression(), !1663)
  %exitcond143.not.i = icmp eq i64 %indvars.iv.next142.i, 4, !dbg !1699
  br i1 %exitcond143.not.i, label %check_data.exit, label %for.inc86.i.for.cond1.preheader.i_crit_edge, !dbg !1666, !llvm.loop !1700

for.inc86.i.for.cond1.preheader.i_crit_edge:      ; preds = %for.inc86.i
  store i32 %or79.i, ptr %has_errors.0134.i.reg2mem86, align 4
  store i64 %indvars.iv.next142.i, ptr %indvars.iv141.i.reg2mem88, align 8
  br label %for.cond1.preheader.i, !dbg !1666

check_data.exit:                                  ; preds = %for.inc86.i
  %tobool.not.i.not = icmp eq i32 %or79.i, 0, !dbg !1702
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1703

if.then45:                                        ; preds = %check_data.exit
  %25 = load ptr, ptr @stderr, align 8, !dbg !1704, !tbaa !938
  %26 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %25) #21, !dbg !1706
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1707

if.end47:                                         ; preds = %check_data.exit
  tail call void @free(ptr noundef nonnull %call) #18, !dbg !1708
  tail call void @free(ptr noundef nonnull %call30) #18, !dbg !1709
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1710
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1711

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1712
}

; Function Attrs: nofree
declare !dbg !1713 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #10

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

!llvm.dbg.cu = !{!239, !188, !241, !302}
!llvm.ident = !{!322, !322, !322, !322}
!llvm.module.flags = !{!323, !324, !325, !326, !327, !329, !330, !331, !332, !333}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/md/grid")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/md/grid")
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
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !217, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/md/grid")
!190 = !{!191, !215, !216, !209}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 37, size: 247808, elements: !194)
!193 = !DIFile(filename: "./md.h", directory: "/home/kelvin/MachSuite/md/grid")
!194 = !{!195, !203, !214}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "n_points", scope: !192, file: !193, line: 38, baseType: !196, size: 2048)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 2048, elements: !202)
!197 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !198, line: 26, baseType: !199)
!198 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!199 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !200, line: 41, baseType: !201)
!200 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!201 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!202 = !{!106, !106, !106}
!203 = !DIDerivedType(tag: DW_TAG_member, name: "force", scope: !192, file: !193, line: 39, baseType: !204, size: 122880, offset: 2048)
!204 = !DICompositeType(tag: DW_TAG_array_type, baseType: !205, size: 122880, elements: !212)
!205 = !DIDerivedType(tag: DW_TAG_typedef, name: "dvector_t", file: !193, line: 25, baseType: !206)
!206 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !193, line: 23, size: 192, elements: !207)
!207 = !{!208, !210, !211}
!208 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !206, file: !193, line: 24, baseType: !209, size: 64)
!209 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!210 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !206, file: !193, line: 24, baseType: !209, size: 64, offset: 64)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "z", scope: !206, file: !193, line: 24, baseType: !209, size: 64, offset: 128)
!212 = !{!106, !106, !106, !213}
!213 = !DISubrange(count: 10)
!214 = !DIDerivedType(tag: DW_TAG_member, name: "position", scope: !192, file: !193, line: 40, baseType: !204, size: 122880, offset: 124928)
!215 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!216 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !209, size: 64)
!217 = !{!186}
!218 = !DIGlobalVariableExpression(var: !219, expr: !DIExpression())
!219 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !220, isLocal: true, isDefinition: true)
!220 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!221 = !DIGlobalVariableExpression(var: !222, expr: !DIExpression())
!222 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !223, isLocal: true, isDefinition: true)
!223 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!224 = !DIGlobalVariableExpression(var: !225, expr: !DIExpression())
!225 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !226, isLocal: true, isDefinition: true)
!226 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !227)
!227 = !{!228}
!228 = !DISubrange(count: 12)
!229 = !DIGlobalVariableExpression(var: !230, expr: !DIExpression())
!230 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !231, isLocal: true, isDefinition: true)
!231 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!232 = !DIGlobalVariableExpression(var: !233, expr: !DIExpression())
!233 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!234 = !DIGlobalVariableExpression(var: !235, expr: !DIExpression())
!235 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !236, isLocal: true, isDefinition: true)
!236 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!237 = !DIGlobalVariableExpression(var: !238, expr: !DIExpression())
!238 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!239 = distinct !DICompileUnit(language: DW_LANG_C11, file: !240, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!240 = !DIFile(filename: "md.c", directory: "/home/kelvin/MachSuite/md/grid")
!241 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !242, globals: !268, splitDebugInlining: false, nameTableKind: None)
!242 = !{!243, !4, !244, !245, !249, !252, !255, !258, !261, !197, !264, !267, !209}
!243 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!244 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!245 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !246, line: 24, baseType: !247)
!246 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!247 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !200, line: 38, baseType: !248)
!248 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !246, line: 25, baseType: !250)
!250 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !200, line: 40, baseType: !251)
!251 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !246, line: 26, baseType: !253)
!253 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !200, line: 42, baseType: !254)
!254 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!255 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !246, line: 27, baseType: !256)
!256 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !200, line: 45, baseType: !257)
!257 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!258 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !198, line: 24, baseType: !259)
!259 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !200, line: 37, baseType: !260)
!260 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!261 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !198, line: 25, baseType: !262)
!262 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !200, line: 39, baseType: !263)
!263 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!264 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !198, line: 27, baseType: !265)
!265 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !200, line: 44, baseType: !266)
!266 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!267 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
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
!303 = !{!244}
!304 = !{!305, !168, !174, !176, !179, !184, !307, !218, !309, !221, !224, !311, !229, !232, !316, !234, !237, !318}
!305 = !DIGlobalVariableExpression(var: !306, expr: !DIExpression())
!306 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !231, isLocal: true, isDefinition: true)
!307 = !DIGlobalVariableExpression(var: !308, expr: !DIExpression())
!308 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !278, isLocal: true, isDefinition: true)
!309 = !DIGlobalVariableExpression(var: !310, expr: !DIExpression())
!310 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !220, isLocal: true, isDefinition: true)
!311 = !DIGlobalVariableExpression(var: !312, expr: !DIExpression())
!312 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !313, isLocal: true, isDefinition: true)
!313 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !314)
!314 = !{!315}
!315 = !DISubrange(count: 31)
!316 = !DIGlobalVariableExpression(var: !317, expr: !DIExpression())
!317 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !220, isLocal: true, isDefinition: true)
!318 = !DIGlobalVariableExpression(var: !319, expr: !DIExpression())
!319 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !320, isLocal: true, isDefinition: true)
!320 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !321)
!321 = !{!213}
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
!334 = distinct !DISubprogram(name: "md", scope: !240, file: !240, line: 6, type: !335, scopeLine: 9, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !239, retainedNodes: !349)
!335 = !DISubroutineType(types: !336)
!336 = !{null, !337, !340, !340}
!337 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !338, size: 64)
!338 = !DICompositeType(tag: DW_TAG_array_type, baseType: !201, size: 512, elements: !339)
!339 = !{!106, !106}
!340 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !341, size: 64)
!341 = !DICompositeType(tag: DW_TAG_array_type, baseType: !342, size: 30720, elements: !348)
!342 = !DIDerivedType(tag: DW_TAG_typedef, name: "dvector_t", file: !193, line: 25, baseType: !343)
!343 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !193, line: 23, size: 192, elements: !344)
!344 = !{!345, !346, !347}
!345 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !343, file: !193, line: 24, baseType: !209, size: 64)
!346 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !343, file: !193, line: 24, baseType: !209, size: 64, offset: 64)
!347 = !DIDerivedType(tag: DW_TAG_member, name: "z", scope: !343, file: !193, line: 24, baseType: !209, size: 64, offset: 128)
!348 = !{!106, !106, !213}
!349 = !{!350, !351, !352, !353, !360, !361, !362, !363, !364, !365, !366, !367, !368, !369, !370, !371, !372, !373, !377, !381, !385, !389, !393, !398, !399, !400, !404, !405, !406}
!350 = !DILocalVariable(name: "n_points", arg: 1, scope: !334, file: !240, line: 6, type: !337)
!351 = !DILocalVariable(name: "force", arg: 2, scope: !334, file: !240, line: 7, type: !340)
!352 = !DILocalVariable(name: "position", arg: 3, scope: !334, file: !240, line: 8, type: !340)
!353 = !DILocalVariable(name: "b0", scope: !334, file: !240, line: 10, type: !354)
!354 = !DIDerivedType(tag: DW_TAG_typedef, name: "ivector_t", file: !193, line: 28, baseType: !355)
!355 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !193, line: 26, size: 96, elements: !356)
!356 = !{!357, !358, !359}
!357 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !355, file: !193, line: 27, baseType: !197, size: 32)
!358 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !355, file: !193, line: 27, baseType: !197, size: 32, offset: 32)
!359 = !DIDerivedType(tag: DW_TAG_member, name: "z", scope: !355, file: !193, line: 27, baseType: !197, size: 32, offset: 64)
!360 = !DILocalVariable(name: "b1", scope: !334, file: !240, line: 10, type: !354)
!361 = !DILocalVariable(name: "p", scope: !334, file: !240, line: 11, type: !342)
!362 = !DILocalVariable(name: "q", scope: !334, file: !240, line: 11, type: !342)
!363 = !DILocalVariable(name: "p_idx", scope: !334, file: !240, line: 12, type: !197)
!364 = !DILocalVariable(name: "q_idx", scope: !334, file: !240, line: 12, type: !197)
!365 = !DILocalVariable(name: "dx", scope: !334, file: !240, line: 13, type: !209)
!366 = !DILocalVariable(name: "dy", scope: !334, file: !240, line: 13, type: !209)
!367 = !DILocalVariable(name: "dz", scope: !334, file: !240, line: 13, type: !209)
!368 = !DILocalVariable(name: "r2inv", scope: !334, file: !240, line: 13, type: !209)
!369 = !DILocalVariable(name: "r6inv", scope: !334, file: !240, line: 13, type: !209)
!370 = !DILocalVariable(name: "potential", scope: !334, file: !240, line: 13, type: !209)
!371 = !DILocalVariable(name: "f", scope: !334, file: !240, line: 13, type: !209)
!372 = !DILabel(scope: !334, name: "loop_grid0_x", file: !240, line: 16)
!373 = !DILabel(scope: !374, name: "loop_grid0_y", file: !240, line: 17)
!374 = distinct !DILexicalBlock(scope: !375, file: !240, line: 16, column: 55)
!375 = distinct !DILexicalBlock(scope: !376, file: !240, line: 16, column: 17)
!376 = distinct !DILexicalBlock(scope: !334, file: !240, line: 16, column: 17)
!377 = !DILabel(scope: !378, name: "loop_grid0_z", file: !240, line: 18)
!378 = distinct !DILexicalBlock(scope: !379, file: !240, line: 17, column: 55)
!379 = distinct !DILexicalBlock(scope: !380, file: !240, line: 17, column: 17)
!380 = distinct !DILexicalBlock(scope: !374, file: !240, line: 17, column: 17)
!381 = !DILabel(scope: !382, name: "loop_grid1_x", file: !240, line: 20)
!382 = distinct !DILexicalBlock(scope: !383, file: !240, line: 18, column: 55)
!383 = distinct !DILexicalBlock(scope: !384, file: !240, line: 18, column: 17)
!384 = distinct !DILexicalBlock(scope: !378, file: !240, line: 18, column: 17)
!385 = !DILabel(scope: !386, name: "loop_grid1_y", file: !240, line: 21)
!386 = distinct !DILexicalBlock(scope: !387, file: !240, line: 20, column: 79)
!387 = distinct !DILexicalBlock(scope: !388, file: !240, line: 20, column: 17)
!388 = distinct !DILexicalBlock(scope: !382, file: !240, line: 20, column: 17)
!389 = !DILabel(scope: !390, name: "loop_grid1_z", file: !240, line: 22)
!390 = distinct !DILexicalBlock(scope: !391, file: !240, line: 21, column: 79)
!391 = distinct !DILexicalBlock(scope: !392, file: !240, line: 21, column: 17)
!392 = distinct !DILexicalBlock(scope: !386, file: !240, line: 21, column: 17)
!393 = !DILocalVariable(name: "base_q", scope: !394, file: !240, line: 24, type: !397)
!394 = distinct !DILexicalBlock(scope: !395, file: !240, line: 22, column: 79)
!395 = distinct !DILexicalBlock(scope: !396, file: !240, line: 22, column: 17)
!396 = distinct !DILexicalBlock(scope: !390, file: !240, line: 22, column: 17)
!397 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !342, size: 64)
!398 = !DILocalVariable(name: "q_idx_range", scope: !394, file: !240, line: 25, type: !201)
!399 = !DILabel(scope: !394, name: "loop_p", file: !240, line: 26)
!400 = !DILocalVariable(name: "sum_x", scope: !401, file: !240, line: 28, type: !209)
!401 = distinct !DILexicalBlock(scope: !402, file: !240, line: 26, column: 71)
!402 = distinct !DILexicalBlock(scope: !403, file: !240, line: 26, column: 13)
!403 = distinct !DILexicalBlock(scope: !394, file: !240, line: 26, column: 13)
!404 = !DILocalVariable(name: "sum_y", scope: !401, file: !240, line: 29, type: !209)
!405 = !DILocalVariable(name: "sum_z", scope: !401, file: !240, line: 30, type: !209)
!406 = !DILabel(scope: !401, name: "loop_q", file: !240, line: 32)
!407 = !DILocation(line: 0, scope: !334)
!408 = !DILocation(line: 16, column: 3, scope: !334)
!409 = !DILocation(line: 16, column: 17, scope: !376)
!410 = !DILocation(line: 17, column: 17, scope: !380)
!411 = !DILocation(line: 18, column: 17, scope: !384)
!412 = !DILocation(line: 20, column: 3, scope: !382)
!413 = !DILocation(line: 20, column: 17, scope: !388)
!414 = !{!415, !415, i64 0}
!415 = !{!"int", !416, i64 0}
!416 = !{!"omnipotent char", !417, i64 0}
!417 = !{!"Simple C/C++ TBAA"}
!418 = !DILocation(line: 21, column: 3, scope: !386)
!419 = !DILocation(line: 21, column: 17, scope: !392)
!420 = !DILocation(line: 22, column: 3, scope: !390)
!421 = !DILocation(line: 22, column: 17, scope: !396)
!422 = !DILocation(line: 24, column: 25, scope: !394)
!423 = !DILocation(line: 0, scope: !394)
!424 = !DILocation(line: 26, column: 5, scope: !394)
!425 = !DILocation(line: 25, column: 23, scope: !394)
!426 = !DILocation(line: 22, column: 74, scope: !395)
!427 = !DILocation(line: 22, column: 46, scope: !395)
!428 = distinct !{!428, !421, !429, !430, !431}
!429 = !DILocation(line: 55, column: 3, scope: !396)
!430 = !{!"llvm.loop.mustprogress"}
!431 = !{!"llvm.loop.unroll.disable"}
!432 = !DILocation(line: 27, column: 11, scope: !401)
!433 = !DILocation(line: 28, column: 20, scope: !401)
!434 = !DILocation(line: 28, column: 51, scope: !401)
!435 = !DILocation(line: 0, scope: !401)
!436 = !DILocation(line: 29, column: 51, scope: !401)
!437 = !DILocation(line: 30, column: 51, scope: !401)
!438 = !DILocation(line: 32, column: 7, scope: !401)
!439 = !DILocation(line: 32, column: 15, scope: !440)
!440 = distinct !DILexicalBlock(scope: !401, file: !240, line: 32, column: 15)
!441 = !DILocation(line: 33, column: 22, scope: !442)
!442 = distinct !DILexicalBlock(scope: !443, file: !240, line: 32, column: 60)
!443 = distinct !DILexicalBlock(scope: !440, file: !240, line: 32, column: 15)
!444 = !DILocation(line: 33, column: 13, scope: !442)
!445 = !DILocation(line: 36, column: 16, scope: !446)
!446 = distinct !DILexicalBlock(scope: !442, file: !240, line: 36, column: 13)
!447 = !DILocation(line: 36, column: 22, scope: !446)
!448 = !DILocation(line: 38, column: 20, scope: !449)
!449 = distinct !DILexicalBlock(scope: !446, file: !240, line: 36, column: 48)
!450 = !DILocation(line: 39, column: 20, scope: !449)
!451 = !DILocation(line: 40, column: 20, scope: !449)
!452 = !DILocation(line: 41, column: 35, scope: !449)
!453 = !DILocation(line: 41, column: 31, scope: !449)
!454 = !DILocation(line: 41, column: 39, scope: !449)
!455 = !DILocation(line: 41, column: 22, scope: !449)
!456 = !DILocation(line: 42, column: 24, scope: !449)
!457 = !DILocation(line: 42, column: 30, scope: !449)
!458 = !DILocation(line: 43, column: 40, scope: !449)
!459 = !DILocation(line: 43, column: 28, scope: !449)
!460 = !DILocation(line: 45, column: 20, scope: !449)
!461 = !DILocation(line: 46, column: 17, scope: !449)
!462 = !DILocation(line: 47, column: 17, scope: !449)
!463 = !DILocation(line: 48, column: 17, scope: !449)
!464 = !DILocation(line: 49, column: 9, scope: !449)
!465 = !DILocation(line: 32, column: 55, scope: !443)
!466 = !DILocation(line: 32, column: 34, scope: !443)
!467 = distinct !{!467, !439, !468, !430, !431}
!468 = !DILocation(line: 50, column: 7, scope: !440)
!469 = !DILocation(line: 51, column: 40, scope: !401)
!470 = !{!471, !472, i64 0}
!471 = !{!"", !472, i64 0, !472, i64 8, !472, i64 16}
!472 = !{!"double", !416, i64 0}
!473 = !DILocation(line: 52, column: 40, scope: !401)
!474 = !{!471, !472, i64 8}
!475 = !DILocation(line: 53, column: 40, scope: !401)
!476 = !{!471, !472, i64 16}
!477 = !DILocation(line: 26, column: 66, scope: !402)
!478 = !DILocation(line: 26, column: 32, scope: !402)
!479 = !DILocation(line: 26, column: 13, scope: !403)
!480 = distinct !{!480, !479, !481, !430, !431}
!481 = !DILocation(line: 54, column: 5, scope: !403)
!482 = !DILocation(line: 21, column: 74, scope: !391)
!483 = !DILocation(line: 21, column: 46, scope: !391)
!484 = distinct !{!484, !419, !485, !430, !431}
!485 = !DILocation(line: 55, column: 4, scope: !392)
!486 = !DILocation(line: 20, column: 74, scope: !387)
!487 = !DILocation(line: 20, column: 46, scope: !387)
!488 = distinct !{!488, !413, !489, !430, !431}
!489 = !DILocation(line: 55, column: 5, scope: !388)
!490 = !DILocation(line: 18, column: 50, scope: !383)
!491 = !DILocation(line: 18, column: 34, scope: !383)
!492 = distinct !{!492, !411, !493, !430, !431}
!493 = !DILocation(line: 56, column: 3, scope: !384)
!494 = !DILocation(line: 17, column: 50, scope: !379)
!495 = !DILocation(line: 17, column: 34, scope: !379)
!496 = distinct !{!496, !410, !497, !430, !431}
!497 = !DILocation(line: 56, column: 4, scope: !380)
!498 = !DILocation(line: 16, column: 50, scope: !375)
!499 = !DILocation(line: 16, column: 34, scope: !375)
!500 = distinct !{!500, !409, !501, !430, !431}
!501 = !DILocation(line: 56, column: 5, scope: !376)
!502 = !DILocation(line: 57, column: 1, scope: !334)
!503 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 8, type: !504, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !506)
!504 = !DISubroutineType(types: !505)
!505 = !{null, !244}
!506 = !{!507, !508}
!507 = !DILocalVariable(name: "vargs", arg: 1, scope: !503, file: !189, line: 8, type: !244)
!508 = !DILocalVariable(name: "args", scope: !503, file: !189, line: 9, type: !191)
!509 = !DILocation(line: 0, scope: !503)
!510 = !DILocation(line: 10, column: 29, scope: !503)
!511 = !DILocation(line: 10, column: 42, scope: !503)
!512 = !DILocation(line: 10, column: 3, scope: !503)
!513 = !DILocation(line: 11, column: 1, scope: !503)
!514 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 20, type: !515, scopeLine: 20, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !517)
!515 = !DISubroutineType(types: !516)
!516 = !{null, !201, !244}
!517 = !{!518, !519, !520, !521, !522}
!518 = !DILocalVariable(name: "fd", arg: 1, scope: !514, file: !189, line: 20, type: !201)
!519 = !DILocalVariable(name: "vdata", arg: 2, scope: !514, file: !189, line: 20, type: !244)
!520 = !DILocalVariable(name: "data", scope: !514, file: !189, line: 21, type: !191)
!521 = !DILocalVariable(name: "p", scope: !514, file: !189, line: 22, type: !243)
!522 = !DILocalVariable(name: "s", scope: !514, file: !189, line: 22, type: !243)
!523 = !DILocation(line: 0, scope: !514)
!524 = !DILocation(line: 24, column: 3, scope: !514)
!525 = !DILocation(line: 26, column: 7, scope: !514)
!526 = !DILocalVariable(name: "s", arg: 1, scope: !527, file: !2, line: 56, type: !243)
!527 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !528, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !530)
!528 = !DISubroutineType(types: !529)
!529 = !{!243, !243, !201}
!530 = !{!526, !531, !532}
!531 = !DILocalVariable(name: "n", arg: 2, scope: !527, file: !2, line: 56, type: !201)
!532 = !DILocalVariable(name: "i", scope: !527, file: !2, line: 57, type: !201)
!533 = !DILocation(line: 0, scope: !527, inlinedAt: !534)
!534 = distinct !DILocation(line: 28, column: 7, scope: !514)
!535 = !DILocation(line: 64, column: 17, scope: !527, inlinedAt: !534)
!536 = !{!416, !416, i64 0}
!537 = !DILocation(line: 64, column: 3, scope: !527, inlinedAt: !534)
!538 = !DILocation(line: 66, column: 22, scope: !539, inlinedAt: !534)
!539 = distinct !DILexicalBlock(scope: !540, file: !2, line: 66, column: 9)
!540 = distinct !DILexicalBlock(scope: !527, file: !2, line: 64, column: 31)
!541 = !DILocation(line: 66, column: 26, scope: !539, inlinedAt: !534)
!542 = !DILocation(line: 66, column: 32, scope: !539, inlinedAt: !534)
!543 = !DILocation(line: 66, column: 35, scope: !539, inlinedAt: !534)
!544 = !DILocation(line: 66, column: 39, scope: !539, inlinedAt: !534)
!545 = !DILocation(line: 66, column: 9, scope: !540, inlinedAt: !534)
!546 = !DILocation(line: 69, column: 6, scope: !540, inlinedAt: !534)
!547 = !DILocation(line: 64, column: 10, scope: !527, inlinedAt: !534)
!548 = !DILocation(line: 64, column: 13, scope: !527, inlinedAt: !534)
!549 = distinct !{!549, !537, !550, !430, !431}
!550 = !DILocation(line: 70, column: 3, scope: !527, inlinedAt: !534)
!551 = !DILocation(line: 71, column: 6, scope: !552, inlinedAt: !534)
!552 = distinct !DILexicalBlock(scope: !527, file: !2, line: 71, column: 6)
!553 = !DILocation(line: 71, column: 8, scope: !552, inlinedAt: !534)
!554 = !DILocation(line: 71, column: 6, scope: !527, inlinedAt: !534)
!555 = !DILocation(line: 29, column: 3, scope: !514)
!556 = !DILocation(line: 0, scope: !527, inlinedAt: !557)
!557 = distinct !DILocation(line: 31, column: 7, scope: !514)
!558 = !DILocation(line: 64, column: 17, scope: !527, inlinedAt: !557)
!559 = !DILocation(line: 64, column: 3, scope: !527, inlinedAt: !557)
!560 = !DILocation(line: 66, column: 22, scope: !539, inlinedAt: !557)
!561 = !DILocation(line: 66, column: 26, scope: !539, inlinedAt: !557)
!562 = !DILocation(line: 66, column: 32, scope: !539, inlinedAt: !557)
!563 = !DILocation(line: 66, column: 35, scope: !539, inlinedAt: !557)
!564 = !DILocation(line: 66, column: 39, scope: !539, inlinedAt: !557)
!565 = !DILocation(line: 66, column: 9, scope: !540, inlinedAt: !557)
!566 = !DILocation(line: 69, column: 6, scope: !540, inlinedAt: !557)
!567 = !DILocation(line: 64, column: 10, scope: !527, inlinedAt: !557)
!568 = !DILocation(line: 64, column: 13, scope: !527, inlinedAt: !557)
!569 = distinct !{!569, !559, !570, !430, !431}
!570 = !DILocation(line: 70, column: 3, scope: !527, inlinedAt: !557)
!571 = !DILocation(line: 71, column: 6, scope: !552, inlinedAt: !557)
!572 = !DILocation(line: 71, column: 8, scope: !552, inlinedAt: !557)
!573 = !DILocation(line: 71, column: 6, scope: !527, inlinedAt: !557)
!574 = !DILocation(line: 32, column: 48, scope: !514)
!575 = !DILocation(line: 32, column: 3, scope: !514)
!576 = !DILocation(line: 33, column: 3, scope: !514)
!577 = !DILocation(line: 34, column: 1, scope: !514)
!578 = !DISubprogram(name: "free", scope: !579, file: !579, line: 687, type: !504, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!579 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!580 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 36, type: !515, scopeLine: 36, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !581)
!581 = !{!582, !583, !584}
!582 = !DILocalVariable(name: "fd", arg: 1, scope: !580, file: !189, line: 36, type: !201)
!583 = !DILocalVariable(name: "vdata", arg: 2, scope: !580, file: !189, line: 36, type: !244)
!584 = !DILocalVariable(name: "data", scope: !580, file: !189, line: 37, type: !191)
!585 = !DILocation(line: 0, scope: !580)
!586 = !DILocalVariable(name: "fd", arg: 1, scope: !587, file: !2, line: 189, type: !201)
!587 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !588, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !590)
!588 = !DISubroutineType(types: !589)
!589 = !{!201, !201}
!590 = !{!586}
!591 = !DILocation(line: 0, scope: !587, inlinedAt: !592)
!592 = distinct !DILocation(line: 39, column: 3, scope: !580)
!593 = !DILocation(line: 190, column: 3, scope: !594, inlinedAt: !592)
!594 = distinct !DILexicalBlock(scope: !595, file: !2, line: 190, column: 3)
!595 = distinct !DILexicalBlock(scope: !587, file: !2, line: 190, column: 3)
!596 = !DILocation(line: 191, column: 3, scope: !587, inlinedAt: !592)
!597 = !DILocalVariable(name: "fd", arg: 1, scope: !598, file: !2, line: 183, type: !201)
!598 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !599, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !601)
!599 = !DISubroutineType(types: !600)
!600 = !{!201, !201, !215, !201}
!601 = !{!597, !602, !603, !604}
!602 = !DILocalVariable(name: "arr", arg: 2, scope: !598, file: !2, line: 183, type: !215)
!603 = !DILocalVariable(name: "n", arg: 3, scope: !598, file: !2, line: 183, type: !201)
!604 = !DILocalVariable(name: "i", scope: !598, file: !2, line: 183, type: !201)
!605 = !DILocation(line: 0, scope: !598, inlinedAt: !606)
!606 = distinct !DILocation(line: 40, column: 3, scope: !580)
!607 = !DILocation(line: 183, column: 1, scope: !608, inlinedAt: !606)
!608 = distinct !DILexicalBlock(scope: !598, file: !2, line: 183, column: 1)
!609 = !DILocation(line: 183, column: 1, scope: !610, inlinedAt: !606)
!610 = distinct !DILexicalBlock(scope: !611, file: !2, line: 183, column: 1)
!611 = distinct !DILexicalBlock(scope: !608, file: !2, line: 183, column: 1)
!612 = !DILocation(line: 183, column: 1, scope: !611, inlinedAt: !606)
!613 = distinct !{!613, !607, !607, !430, !431}
!614 = !DILocation(line: 0, scope: !587, inlinedAt: !615)
!615 = distinct !DILocation(line: 42, column: 3, scope: !580)
!616 = !DILocation(line: 191, column: 3, scope: !587, inlinedAt: !615)
!617 = !DILocation(line: 43, column: 49, scope: !580)
!618 = !DILocalVariable(name: "fd", arg: 1, scope: !619, file: !2, line: 187, type: !201)
!619 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !620, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !622)
!620 = !DISubroutineType(types: !621)
!621 = !{!201, !201, !216, !201}
!622 = !{!618, !623, !624, !625}
!623 = !DILocalVariable(name: "arr", arg: 2, scope: !619, file: !2, line: 187, type: !216)
!624 = !DILocalVariable(name: "n", arg: 3, scope: !619, file: !2, line: 187, type: !201)
!625 = !DILocalVariable(name: "i", scope: !619, file: !2, line: 187, type: !201)
!626 = !DILocation(line: 0, scope: !619, inlinedAt: !627)
!627 = distinct !DILocation(line: 43, column: 3, scope: !580)
!628 = !DILocation(line: 187, column: 1, scope: !629, inlinedAt: !627)
!629 = distinct !DILexicalBlock(scope: !619, file: !2, line: 187, column: 1)
!630 = !DILocation(line: 187, column: 1, scope: !631, inlinedAt: !627)
!631 = distinct !DILexicalBlock(scope: !632, file: !2, line: 187, column: 1)
!632 = distinct !DILexicalBlock(scope: !629, file: !2, line: 187, column: 1)
!633 = !{!472, !472, i64 0}
!634 = !DILocation(line: 187, column: 1, scope: !632, inlinedAt: !627)
!635 = distinct !{!635, !628, !628, !430, !431}
!636 = !DILocation(line: 45, column: 1, scope: !580)
!637 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 52, type: !515, scopeLine: 52, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !638)
!638 = !{!639, !640, !641, !642, !643}
!639 = !DILocalVariable(name: "fd", arg: 1, scope: !637, file: !189, line: 52, type: !201)
!640 = !DILocalVariable(name: "vdata", arg: 2, scope: !637, file: !189, line: 52, type: !244)
!641 = !DILocalVariable(name: "data", scope: !637, file: !189, line: 53, type: !191)
!642 = !DILocalVariable(name: "p", scope: !637, file: !189, line: 54, type: !243)
!643 = !DILocalVariable(name: "s", scope: !637, file: !189, line: 54, type: !243)
!644 = !DILocation(line: 0, scope: !637)
!645 = !DILocation(line: 56, column: 3, scope: !637)
!646 = !DILocation(line: 58, column: 7, scope: !637)
!647 = !DILocation(line: 0, scope: !527, inlinedAt: !648)
!648 = distinct !DILocation(line: 60, column: 7, scope: !637)
!649 = !DILocation(line: 64, column: 17, scope: !527, inlinedAt: !648)
!650 = !DILocation(line: 64, column: 3, scope: !527, inlinedAt: !648)
!651 = !DILocation(line: 66, column: 22, scope: !539, inlinedAt: !648)
!652 = !DILocation(line: 66, column: 26, scope: !539, inlinedAt: !648)
!653 = !DILocation(line: 66, column: 32, scope: !539, inlinedAt: !648)
!654 = !DILocation(line: 66, column: 35, scope: !539, inlinedAt: !648)
!655 = !DILocation(line: 66, column: 39, scope: !539, inlinedAt: !648)
!656 = !DILocation(line: 66, column: 9, scope: !540, inlinedAt: !648)
!657 = !DILocation(line: 69, column: 6, scope: !540, inlinedAt: !648)
!658 = !DILocation(line: 64, column: 10, scope: !527, inlinedAt: !648)
!659 = !DILocation(line: 64, column: 13, scope: !527, inlinedAt: !648)
!660 = distinct !{!660, !650, !661, !430, !431}
!661 = !DILocation(line: 70, column: 3, scope: !527, inlinedAt: !648)
!662 = !DILocation(line: 71, column: 6, scope: !552, inlinedAt: !648)
!663 = !DILocation(line: 71, column: 8, scope: !552, inlinedAt: !648)
!664 = !DILocation(line: 71, column: 6, scope: !527, inlinedAt: !648)
!665 = !DILocation(line: 61, column: 47, scope: !637)
!666 = !DILocation(line: 61, column: 3, scope: !637)
!667 = !DILocation(line: 62, column: 3, scope: !637)
!668 = !DILocation(line: 63, column: 1, scope: !637)
!669 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 65, type: !515, scopeLine: 65, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !670)
!670 = !{!671, !672, !673}
!671 = !DILocalVariable(name: "fd", arg: 1, scope: !669, file: !189, line: 65, type: !201)
!672 = !DILocalVariable(name: "vdata", arg: 2, scope: !669, file: !189, line: 65, type: !244)
!673 = !DILocalVariable(name: "data", scope: !669, file: !189, line: 66, type: !191)
!674 = !DILocation(line: 0, scope: !669)
!675 = !DILocation(line: 0, scope: !587, inlinedAt: !676)
!676 = distinct !DILocation(line: 68, column: 3, scope: !669)
!677 = !DILocation(line: 190, column: 3, scope: !594, inlinedAt: !676)
!678 = !DILocation(line: 191, column: 3, scope: !587, inlinedAt: !676)
!679 = !DILocation(line: 69, column: 48, scope: !669)
!680 = !DILocation(line: 0, scope: !619, inlinedAt: !681)
!681 = distinct !DILocation(line: 69, column: 3, scope: !669)
!682 = !DILocation(line: 187, column: 1, scope: !629, inlinedAt: !681)
!683 = !DILocation(line: 187, column: 1, scope: !631, inlinedAt: !681)
!684 = !DILocation(line: 187, column: 1, scope: !632, inlinedAt: !681)
!685 = distinct !{!685, !682, !682, !430, !431}
!686 = !DILocation(line: 70, column: 1, scope: !669)
!687 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 72, type: !688, scopeLine: 72, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !690)
!688 = !DISubroutineType(types: !689)
!689 = !{!201, !244, !244}
!690 = !{!691, !692, !693, !694, !695, !696, !697, !698, !699, !700, !701, !702}
!691 = !DILocalVariable(name: "vdata", arg: 1, scope: !687, file: !189, line: 72, type: !244)
!692 = !DILocalVariable(name: "vref", arg: 2, scope: !687, file: !189, line: 72, type: !244)
!693 = !DILocalVariable(name: "data", scope: !687, file: !189, line: 73, type: !191)
!694 = !DILocalVariable(name: "ref", scope: !687, file: !189, line: 74, type: !191)
!695 = !DILocalVariable(name: "has_errors", scope: !687, file: !189, line: 75, type: !201)
!696 = !DILocalVariable(name: "i", scope: !687, file: !189, line: 76, type: !201)
!697 = !DILocalVariable(name: "j", scope: !687, file: !189, line: 76, type: !201)
!698 = !DILocalVariable(name: "k", scope: !687, file: !189, line: 76, type: !201)
!699 = !DILocalVariable(name: "d", scope: !687, file: !189, line: 76, type: !201)
!700 = !DILocalVariable(name: "diff_x", scope: !687, file: !189, line: 77, type: !209)
!701 = !DILocalVariable(name: "diff_y", scope: !687, file: !189, line: 77, type: !209)
!702 = !DILocalVariable(name: "diff_z", scope: !687, file: !189, line: 77, type: !209)
!703 = !DILocation(line: 0, scope: !687)
!704 = !DILocation(line: 79, column: 3, scope: !705)
!705 = distinct !DILexicalBlock(scope: !687, file: !189, line: 79, column: 3)
!706 = !DILocation(line: 80, column: 5, scope: !707)
!707 = distinct !DILexicalBlock(scope: !708, file: !189, line: 80, column: 5)
!708 = distinct !DILexicalBlock(scope: !709, file: !189, line: 79, column: 30)
!709 = distinct !DILexicalBlock(scope: !705, file: !189, line: 79, column: 3)
!710 = !DILocation(line: 81, column: 7, scope: !711)
!711 = distinct !DILexicalBlock(scope: !712, file: !189, line: 81, column: 7)
!712 = distinct !DILexicalBlock(scope: !713, file: !189, line: 80, column: 32)
!713 = distinct !DILexicalBlock(scope: !707, file: !189, line: 80, column: 5)
!714 = !DILocation(line: 82, column: 9, scope: !715)
!715 = distinct !DILexicalBlock(scope: !716, file: !189, line: 82, column: 9)
!716 = distinct !DILexicalBlock(scope: !717, file: !189, line: 81, column: 34)
!717 = distinct !DILexicalBlock(scope: !711, file: !189, line: 81, column: 7)
!718 = !DILocation(line: 83, column: 20, scope: !719)
!719 = distinct !DILexicalBlock(scope: !720, file: !189, line: 82, column: 40)
!720 = distinct !DILexicalBlock(scope: !715, file: !189, line: 82, column: 9)
!721 = !DILocation(line: 83, column: 44, scope: !719)
!722 = !DILocation(line: 83, column: 48, scope: !719)
!723 = !DILocation(line: 83, column: 71, scope: !719)
!724 = !DILocation(line: 83, column: 46, scope: !719)
!725 = !DILocation(line: 84, column: 44, scope: !719)
!726 = !DILocation(line: 84, column: 71, scope: !719)
!727 = !DILocation(line: 84, column: 46, scope: !719)
!728 = !DILocation(line: 85, column: 44, scope: !719)
!729 = !DILocation(line: 85, column: 71, scope: !719)
!730 = !DILocation(line: 85, column: 46, scope: !719)
!731 = !DILocation(line: 86, column: 43, scope: !719)
!732 = !DILocation(line: 87, column: 43, scope: !719)
!733 = !DILocation(line: 87, column: 22, scope: !719)
!734 = !DILocation(line: 88, column: 43, scope: !719)
!735 = !DILocation(line: 88, column: 22, scope: !719)
!736 = !DILocation(line: 82, column: 36, scope: !720)
!737 = !DILocation(line: 82, column: 19, scope: !720)
!738 = distinct !{!738, !714, !739, !430, !431}
!739 = !DILocation(line: 89, column: 9, scope: !715)
!740 = !DILocation(line: 81, column: 30, scope: !717)
!741 = !DILocation(line: 81, column: 17, scope: !717)
!742 = distinct !{!742, !710, !743, !430, !431}
!743 = !DILocation(line: 90, column: 7, scope: !711)
!744 = !DILocation(line: 80, column: 28, scope: !713)
!745 = !DILocation(line: 80, column: 15, scope: !713)
!746 = distinct !{!746, !706, !747, !430, !431}
!747 = !DILocation(line: 91, column: 5, scope: !707)
!748 = !DILocation(line: 79, column: 26, scope: !709)
!749 = !DILocation(line: 79, column: 13, scope: !709)
!750 = distinct !{!750, !704, !751, !430, !431}
!751 = !DILocation(line: 92, column: 3, scope: !705)
!752 = !DILocation(line: 95, column: 10, scope: !687)
!753 = !DILocation(line: 95, column: 3, scope: !687)
!754 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !755, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !757)
!755 = !DISubroutineType(types: !756)
!756 = !{!243, !201}
!757 = !{!758, !759, !760, !797, !800, !803}
!758 = !DILocalVariable(name: "fd", arg: 1, scope: !754, file: !2, line: 34, type: !201)
!759 = !DILocalVariable(name: "p", scope: !754, file: !2, line: 35, type: !243)
!760 = !DILocalVariable(name: "s", scope: !754, file: !2, line: 36, type: !761)
!761 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !762, line: 44, size: 1024, elements: !763)
!762 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!763 = !{!764, !766, !768, !770, !772, !774, !776, !777, !778, !780, !782, !783, !785, !793, !794, !795}
!764 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !761, file: !762, line: 46, baseType: !765, size: 64)
!765 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !200, line: 145, baseType: !257)
!766 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !761, file: !762, line: 47, baseType: !767, size: 64, offset: 64)
!767 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !200, line: 148, baseType: !257)
!768 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !761, file: !762, line: 48, baseType: !769, size: 32, offset: 128)
!769 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !200, line: 150, baseType: !254)
!770 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !761, file: !762, line: 49, baseType: !771, size: 32, offset: 160)
!771 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !200, line: 151, baseType: !254)
!772 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !761, file: !762, line: 50, baseType: !773, size: 32, offset: 192)
!773 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !200, line: 146, baseType: !254)
!774 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !761, file: !762, line: 51, baseType: !775, size: 32, offset: 224)
!775 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !200, line: 147, baseType: !254)
!776 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !761, file: !762, line: 52, baseType: !765, size: 64, offset: 256)
!777 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !761, file: !762, line: 53, baseType: !765, size: 64, offset: 320)
!778 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !761, file: !762, line: 54, baseType: !779, size: 64, offset: 384)
!779 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !200, line: 152, baseType: !266)
!780 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !761, file: !762, line: 55, baseType: !781, size: 32, offset: 448)
!781 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !200, line: 175, baseType: !201)
!782 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !761, file: !762, line: 56, baseType: !201, size: 32, offset: 480)
!783 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !761, file: !762, line: 57, baseType: !784, size: 64, offset: 512)
!784 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !200, line: 180, baseType: !266)
!785 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !761, file: !762, line: 65, baseType: !786, size: 128, offset: 576)
!786 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !787, line: 11, size: 128, elements: !788)
!787 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!788 = !{!789, !791}
!789 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !786, file: !787, line: 16, baseType: !790, size: 64)
!790 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !200, line: 160, baseType: !266)
!791 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !786, file: !787, line: 21, baseType: !792, size: 64, offset: 64)
!792 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !200, line: 197, baseType: !266)
!793 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !761, file: !762, line: 66, baseType: !786, size: 128, offset: 704)
!794 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !761, file: !762, line: 67, baseType: !786, size: 128, offset: 832)
!795 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !761, file: !762, line: 79, baseType: !796, size: 64, offset: 960)
!796 = !DICompositeType(tag: DW_TAG_array_type, baseType: !201, size: 64, elements: !55)
!797 = !DILocalVariable(name: "len", scope: !754, file: !2, line: 37, type: !798)
!798 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !799, line: 85, baseType: !779)
!799 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!800 = !DILocalVariable(name: "bytes_read", scope: !754, file: !2, line: 38, type: !801)
!801 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !799, line: 108, baseType: !802)
!802 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !200, line: 194, baseType: !266)
!803 = !DILocalVariable(name: "status", scope: !754, file: !2, line: 38, type: !801)
!804 = distinct !DIAssignID()
!805 = !DILocation(line: 0, scope: !754)
!806 = !DILocation(line: 36, column: 3, scope: !754)
!807 = !DILocation(line: 40, column: 3, scope: !808)
!808 = distinct !DILexicalBlock(scope: !809, file: !2, line: 40, column: 3)
!809 = distinct !DILexicalBlock(scope: !754, file: !2, line: 40, column: 3)
!810 = !DILocation(line: 41, column: 3, scope: !811)
!811 = distinct !DILexicalBlock(scope: !812, file: !2, line: 41, column: 3)
!812 = distinct !DILexicalBlock(scope: !754, file: !2, line: 41, column: 3)
!813 = !DILocation(line: 42, column: 11, scope: !754)
!814 = !DILocation(line: 43, column: 3, scope: !815)
!815 = distinct !DILexicalBlock(scope: !816, file: !2, line: 43, column: 3)
!816 = distinct !DILexicalBlock(scope: !754, file: !2, line: 43, column: 3)
!817 = !DILocation(line: 44, column: 25, scope: !754)
!818 = !DILocation(line: 44, column: 15, scope: !754)
!819 = !DILocation(line: 46, column: 3, scope: !754)
!820 = !DILocation(line: 49, column: 15, scope: !821)
!821 = distinct !DILexicalBlock(scope: !754, file: !2, line: 46, column: 27)
!822 = !DILocation(line: 46, column: 20, scope: !754)
!823 = distinct !{!823, !819, !824, !430, !431}
!824 = !DILocation(line: 50, column: 3, scope: !754)
!825 = !DILocation(line: 47, column: 24, scope: !821)
!826 = !DILocation(line: 47, column: 42, scope: !821)
!827 = !DILocation(line: 47, column: 14, scope: !821)
!828 = !DILocation(line: 48, column: 5, scope: !829)
!829 = distinct !DILexicalBlock(scope: !830, file: !2, line: 48, column: 5)
!830 = distinct !DILexicalBlock(scope: !821, file: !2, line: 48, column: 5)
!831 = !DILocation(line: 51, column: 3, scope: !754)
!832 = !DILocation(line: 51, column: 10, scope: !754)
!833 = !DILocation(line: 52, column: 3, scope: !754)
!834 = !DILocation(line: 54, column: 1, scope: !754)
!835 = !DILocation(line: 53, column: 3, scope: !754)
!836 = !DISubprogram(name: "__assert_fail", scope: !837, file: !837, line: 67, type: !838, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!837 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!838 = !DISubroutineType(types: !839)
!839 = !{null, !840, !840, !254, !840}
!840 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!841 = !DISubprogram(name: "fstat", scope: !842, file: !842, line: 210, type: !843, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!842 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!843 = !DISubroutineType(types: !844)
!844 = !{!201, !201, !845}
!845 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !761, size: 64)
!846 = !DISubprogram(name: "malloc", scope: !579, file: !579, line: 672, type: !847, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!847 = !DISubroutineType(types: !848)
!848 = !{!244, !849}
!849 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !850, line: 18, baseType: !257)
!850 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!851 = !DISubprogram(name: "read", scope: !852, file: !852, line: 371, type: !853, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!852 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!853 = !DISubroutineType(types: !854)
!854 = !{!801, !201, !244, !849}
!855 = !DISubprogram(name: "close", scope: !852, file: !852, line: 358, type: !588, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!856 = !DILocation(line: 0, scope: !527)
!857 = !DILocation(line: 59, column: 3, scope: !858)
!858 = distinct !DILexicalBlock(scope: !859, file: !2, line: 59, column: 3)
!859 = distinct !DILexicalBlock(scope: !527, file: !2, line: 59, column: 3)
!860 = !DILocation(line: 60, column: 7, scope: !861)
!861 = distinct !DILexicalBlock(scope: !527, file: !2, line: 60, column: 6)
!862 = !DILocation(line: 60, column: 6, scope: !527)
!863 = !DILocation(line: 64, column: 17, scope: !527)
!864 = !DILocation(line: 64, column: 3, scope: !527)
!865 = !DILocation(line: 66, column: 22, scope: !539)
!866 = !DILocation(line: 66, column: 26, scope: !539)
!867 = !DILocation(line: 66, column: 32, scope: !539)
!868 = !DILocation(line: 66, column: 35, scope: !539)
!869 = !DILocation(line: 66, column: 39, scope: !539)
!870 = !DILocation(line: 66, column: 9, scope: !540)
!871 = !DILocation(line: 69, column: 6, scope: !540)
!872 = !DILocation(line: 64, column: 10, scope: !527)
!873 = !DILocation(line: 64, column: 13, scope: !527)
!874 = distinct !{!874, !864, !875, !430, !431}
!875 = !DILocation(line: 70, column: 3, scope: !527)
!876 = !DILocation(line: 71, column: 6, scope: !552)
!877 = !DILocation(line: 71, column: 8, scope: !552)
!878 = !DILocation(line: 71, column: 6, scope: !527)
!879 = !DILocation(line: 74, column: 1, scope: !527)
!880 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !881, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !883)
!881 = !DISubroutineType(types: !882)
!882 = !{!201, !243, !243, !201}
!883 = !{!884, !885, !886, !887}
!884 = !DILocalVariable(name: "s", arg: 1, scope: !880, file: !2, line: 77, type: !243)
!885 = !DILocalVariable(name: "arr", arg: 2, scope: !880, file: !2, line: 77, type: !243)
!886 = !DILocalVariable(name: "n", arg: 3, scope: !880, file: !2, line: 77, type: !201)
!887 = !DILocalVariable(name: "k", scope: !880, file: !2, line: 78, type: !201)
!888 = !DILocation(line: 0, scope: !880)
!889 = !DILocation(line: 79, column: 3, scope: !890)
!890 = distinct !DILexicalBlock(scope: !891, file: !2, line: 79, column: 3)
!891 = distinct !DILexicalBlock(scope: !880, file: !2, line: 79, column: 3)
!892 = !DILocation(line: 81, column: 8, scope: !893)
!893 = distinct !DILexicalBlock(scope: !880, file: !2, line: 81, column: 7)
!894 = !DILocation(line: 81, column: 7, scope: !880)
!895 = !DILocation(line: 83, column: 12, scope: !896)
!896 = distinct !DILexicalBlock(scope: !893, file: !2, line: 81, column: 13)
!897 = !DILocation(line: 83, column: 5, scope: !896)
!898 = !DILocation(line: 91, column: 19, scope: !880)
!899 = !DILocation(line: 91, column: 3, scope: !880)
!900 = !DILocation(line: 92, column: 7, scope: !880)
!901 = !DILocation(line: 83, column: 16, scope: !896)
!902 = !DILocation(line: 83, column: 26, scope: !896)
!903 = !DILocation(line: 83, column: 32, scope: !896)
!904 = !DILocation(line: 83, column: 29, scope: !896)
!905 = !DILocation(line: 83, column: 35, scope: !896)
!906 = !DILocation(line: 83, column: 45, scope: !896)
!907 = !DILocation(line: 83, column: 48, scope: !896)
!908 = !DILocation(line: 83, column: 54, scope: !896)
!909 = !DILocation(line: 84, column: 9, scope: !896)
!910 = !DILocation(line: 84, column: 18, scope: !896)
!911 = !DILocation(line: 84, column: 26, scope: !896)
!912 = distinct !{!912, !897, !913, !430, !431}
!913 = !DILocation(line: 86, column: 5, scope: !896)
!914 = !DILocation(line: 93, column: 5, scope: !915)
!915 = distinct !DILexicalBlock(scope: !880, file: !2, line: 92, column: 7)
!916 = !DILocation(line: 93, column: 12, scope: !915)
!917 = !DILocation(line: 95, column: 3, scope: !880)
!918 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !919, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !922)
!919 = !DISubroutineType(types: !920)
!920 = !{!201, !243, !921, !201}
!921 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !245, size: 64)
!922 = !{!923, !924, !925, !926, !927, !928, !929}
!923 = !DILocalVariable(name: "s", arg: 1, scope: !918, file: !2, line: 132, type: !243)
!924 = !DILocalVariable(name: "arr", arg: 2, scope: !918, file: !2, line: 132, type: !921)
!925 = !DILocalVariable(name: "n", arg: 3, scope: !918, file: !2, line: 132, type: !201)
!926 = !DILocalVariable(name: "line", scope: !918, file: !2, line: 132, type: !243)
!927 = !DILocalVariable(name: "endptr", scope: !918, file: !2, line: 132, type: !243)
!928 = !DILocalVariable(name: "i", scope: !918, file: !2, line: 132, type: !201)
!929 = !DILocalVariable(name: "v", scope: !918, file: !2, line: 132, type: !245)
!930 = distinct !DIAssignID()
!931 = !DILocation(line: 0, scope: !918)
!932 = !DILocation(line: 132, column: 1, scope: !918)
!933 = !DILocation(line: 132, column: 1, scope: !934)
!934 = distinct !DILexicalBlock(scope: !935, file: !2, line: 132, column: 1)
!935 = distinct !DILexicalBlock(scope: !918, file: !2, line: 132, column: 1)
!936 = !DILocation(line: 132, column: 1, scope: !937)
!937 = distinct !DILexicalBlock(scope: !918, file: !2, line: 132, column: 1)
!938 = !{!939, !939, i64 0}
!939 = !{!"any pointer", !416, i64 0}
!940 = distinct !DIAssignID()
!941 = !DILocation(line: 132, column: 1, scope: !942)
!942 = distinct !DILexicalBlock(scope: !937, file: !2, line: 132, column: 1)
!943 = !DILocation(line: 132, column: 1, scope: !944)
!944 = distinct !DILexicalBlock(scope: !942, file: !2, line: 132, column: 1)
!945 = distinct !{!945, !932, !932, !430, !431}
!946 = !DILocation(line: 132, column: 1, scope: !947)
!947 = distinct !DILexicalBlock(scope: !948, file: !2, line: 132, column: 1)
!948 = distinct !DILexicalBlock(scope: !918, file: !2, line: 132, column: 1)
!949 = !DISubprogram(name: "strtok", scope: !950, file: !950, line: 356, type: !951, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!950 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!951 = !DISubroutineType(types: !952)
!952 = !{!243, !953, !954}
!953 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !243)
!954 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !840)
!955 = !DISubprogram(name: "strtol", scope: !579, file: !579, line: 177, type: !956, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!956 = !DISubroutineType(types: !957)
!957 = !{!266, !954, !958, !201}
!958 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !959)
!959 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !243, size: 64)
!960 = !DISubprogram(name: "fprintf", scope: !961, file: !961, line: 357, type: !962, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!961 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!962 = !DISubroutineType(types: !963)
!963 = !{!201, !964, !954, null}
!964 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !965)
!965 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !966, size: 64)
!966 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !967, line: 7, baseType: !968)
!967 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!968 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !969, line: 49, size: 1728, elements: !970)
!969 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!970 = !{!971, !972, !973, !974, !975, !976, !977, !978, !979, !980, !981, !982, !983, !986, !988, !989, !990, !991, !992, !993, !997, !1000, !1002, !1005, !1008, !1009, !1010, !1012, !1013}
!971 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !968, file: !969, line: 51, baseType: !201, size: 32)
!972 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !968, file: !969, line: 54, baseType: !243, size: 64, offset: 64)
!973 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !968, file: !969, line: 55, baseType: !243, size: 64, offset: 128)
!974 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !968, file: !969, line: 56, baseType: !243, size: 64, offset: 192)
!975 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !968, file: !969, line: 57, baseType: !243, size: 64, offset: 256)
!976 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !968, file: !969, line: 58, baseType: !243, size: 64, offset: 320)
!977 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !968, file: !969, line: 59, baseType: !243, size: 64, offset: 384)
!978 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !968, file: !969, line: 60, baseType: !243, size: 64, offset: 448)
!979 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !968, file: !969, line: 61, baseType: !243, size: 64, offset: 512)
!980 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !968, file: !969, line: 64, baseType: !243, size: 64, offset: 576)
!981 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !968, file: !969, line: 65, baseType: !243, size: 64, offset: 640)
!982 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !968, file: !969, line: 66, baseType: !243, size: 64, offset: 704)
!983 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !968, file: !969, line: 68, baseType: !984, size: 64, offset: 768)
!984 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !985, size: 64)
!985 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !969, line: 36, flags: DIFlagFwdDecl)
!986 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !968, file: !969, line: 70, baseType: !987, size: 64, offset: 832)
!987 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !968, size: 64)
!988 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !968, file: !969, line: 72, baseType: !201, size: 32, offset: 896)
!989 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !968, file: !969, line: 73, baseType: !201, size: 32, offset: 928)
!990 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !968, file: !969, line: 74, baseType: !779, size: 64, offset: 960)
!991 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !968, file: !969, line: 77, baseType: !251, size: 16, offset: 1024)
!992 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !968, file: !969, line: 78, baseType: !260, size: 8, offset: 1040)
!993 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !968, file: !969, line: 79, baseType: !994, size: 8, offset: 1048)
!994 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !995)
!995 = !{!996}
!996 = !DISubrange(count: 1)
!997 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !968, file: !969, line: 81, baseType: !998, size: 64, offset: 1088)
!998 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !999, size: 64)
!999 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !969, line: 43, baseType: null)
!1000 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !968, file: !969, line: 89, baseType: !1001, size: 64, offset: 1152)
!1001 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !200, line: 153, baseType: !266)
!1002 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !968, file: !969, line: 91, baseType: !1003, size: 64, offset: 1216)
!1003 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1004, size: 64)
!1004 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !969, line: 37, flags: DIFlagFwdDecl)
!1005 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !968, file: !969, line: 92, baseType: !1006, size: 64, offset: 1280)
!1006 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1007, size: 64)
!1007 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !969, line: 38, flags: DIFlagFwdDecl)
!1008 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !968, file: !969, line: 93, baseType: !987, size: 64, offset: 1344)
!1009 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !968, file: !969, line: 94, baseType: !244, size: 64, offset: 1408)
!1010 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !968, file: !969, line: 95, baseType: !1011, size: 64, offset: 1472)
!1011 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !987, size: 64)
!1012 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !968, file: !969, line: 96, baseType: !201, size: 32, offset: 1536)
!1013 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !968, file: !969, line: 98, baseType: !1014, size: 160, offset: 1568)
!1014 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!1015 = !DISubprogram(name: "strlen", scope: !950, file: !950, line: 407, type: !1016, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1016 = !DISubroutineType(types: !1017)
!1017 = !{!257, !840}
!1018 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !1019, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1022)
!1019 = !DISubroutineType(types: !1020)
!1020 = !{!201, !243, !1021, !201}
!1021 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !249, size: 64)
!1022 = !{!1023, !1024, !1025, !1026, !1027, !1028, !1029}
!1023 = !DILocalVariable(name: "s", arg: 1, scope: !1018, file: !2, line: 133, type: !243)
!1024 = !DILocalVariable(name: "arr", arg: 2, scope: !1018, file: !2, line: 133, type: !1021)
!1025 = !DILocalVariable(name: "n", arg: 3, scope: !1018, file: !2, line: 133, type: !201)
!1026 = !DILocalVariable(name: "line", scope: !1018, file: !2, line: 133, type: !243)
!1027 = !DILocalVariable(name: "endptr", scope: !1018, file: !2, line: 133, type: !243)
!1028 = !DILocalVariable(name: "i", scope: !1018, file: !2, line: 133, type: !201)
!1029 = !DILocalVariable(name: "v", scope: !1018, file: !2, line: 133, type: !249)
!1030 = distinct !DIAssignID()
!1031 = !DILocation(line: 0, scope: !1018)
!1032 = !DILocation(line: 133, column: 1, scope: !1018)
!1033 = !DILocation(line: 133, column: 1, scope: !1034)
!1034 = distinct !DILexicalBlock(scope: !1035, file: !2, line: 133, column: 1)
!1035 = distinct !DILexicalBlock(scope: !1018, file: !2, line: 133, column: 1)
!1036 = !DILocation(line: 133, column: 1, scope: !1037)
!1037 = distinct !DILexicalBlock(scope: !1018, file: !2, line: 133, column: 1)
!1038 = distinct !DIAssignID()
!1039 = !DILocation(line: 133, column: 1, scope: !1040)
!1040 = distinct !DILexicalBlock(scope: !1037, file: !2, line: 133, column: 1)
!1041 = !DILocation(line: 133, column: 1, scope: !1042)
!1042 = distinct !DILexicalBlock(scope: !1040, file: !2, line: 133, column: 1)
!1043 = !{!1044, !1044, i64 0}
!1044 = !{!"short", !416, i64 0}
!1045 = distinct !{!1045, !1032, !1032, !430, !431}
!1046 = !DILocation(line: 133, column: 1, scope: !1047)
!1047 = distinct !DILexicalBlock(scope: !1048, file: !2, line: 133, column: 1)
!1048 = distinct !DILexicalBlock(scope: !1018, file: !2, line: 133, column: 1)
!1049 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !1050, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1053)
!1050 = !DISubroutineType(types: !1051)
!1051 = !{!201, !243, !1052, !201}
!1052 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !252, size: 64)
!1053 = !{!1054, !1055, !1056, !1057, !1058, !1059, !1060}
!1054 = !DILocalVariable(name: "s", arg: 1, scope: !1049, file: !2, line: 134, type: !243)
!1055 = !DILocalVariable(name: "arr", arg: 2, scope: !1049, file: !2, line: 134, type: !1052)
!1056 = !DILocalVariable(name: "n", arg: 3, scope: !1049, file: !2, line: 134, type: !201)
!1057 = !DILocalVariable(name: "line", scope: !1049, file: !2, line: 134, type: !243)
!1058 = !DILocalVariable(name: "endptr", scope: !1049, file: !2, line: 134, type: !243)
!1059 = !DILocalVariable(name: "i", scope: !1049, file: !2, line: 134, type: !201)
!1060 = !DILocalVariable(name: "v", scope: !1049, file: !2, line: 134, type: !252)
!1061 = distinct !DIAssignID()
!1062 = !DILocation(line: 0, scope: !1049)
!1063 = !DILocation(line: 134, column: 1, scope: !1049)
!1064 = !DILocation(line: 134, column: 1, scope: !1065)
!1065 = distinct !DILexicalBlock(scope: !1066, file: !2, line: 134, column: 1)
!1066 = distinct !DILexicalBlock(scope: !1049, file: !2, line: 134, column: 1)
!1067 = !DILocation(line: 134, column: 1, scope: !1068)
!1068 = distinct !DILexicalBlock(scope: !1049, file: !2, line: 134, column: 1)
!1069 = distinct !DIAssignID()
!1070 = !DILocation(line: 134, column: 1, scope: !1071)
!1071 = distinct !DILexicalBlock(scope: !1068, file: !2, line: 134, column: 1)
!1072 = !DILocation(line: 134, column: 1, scope: !1073)
!1073 = distinct !DILexicalBlock(scope: !1071, file: !2, line: 134, column: 1)
!1074 = distinct !{!1074, !1063, !1063, !430, !431}
!1075 = !DILocation(line: 134, column: 1, scope: !1076)
!1076 = distinct !DILexicalBlock(scope: !1077, file: !2, line: 134, column: 1)
!1077 = distinct !DILexicalBlock(scope: !1049, file: !2, line: 134, column: 1)
!1078 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !1079, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1082)
!1079 = !DISubroutineType(types: !1080)
!1080 = !{!201, !243, !1081, !201}
!1081 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !255, size: 64)
!1082 = !{!1083, !1084, !1085, !1086, !1087, !1088, !1089}
!1083 = !DILocalVariable(name: "s", arg: 1, scope: !1078, file: !2, line: 135, type: !243)
!1084 = !DILocalVariable(name: "arr", arg: 2, scope: !1078, file: !2, line: 135, type: !1081)
!1085 = !DILocalVariable(name: "n", arg: 3, scope: !1078, file: !2, line: 135, type: !201)
!1086 = !DILocalVariable(name: "line", scope: !1078, file: !2, line: 135, type: !243)
!1087 = !DILocalVariable(name: "endptr", scope: !1078, file: !2, line: 135, type: !243)
!1088 = !DILocalVariable(name: "i", scope: !1078, file: !2, line: 135, type: !201)
!1089 = !DILocalVariable(name: "v", scope: !1078, file: !2, line: 135, type: !255)
!1090 = distinct !DIAssignID()
!1091 = !DILocation(line: 0, scope: !1078)
!1092 = !DILocation(line: 135, column: 1, scope: !1078)
!1093 = !DILocation(line: 135, column: 1, scope: !1094)
!1094 = distinct !DILexicalBlock(scope: !1095, file: !2, line: 135, column: 1)
!1095 = distinct !DILexicalBlock(scope: !1078, file: !2, line: 135, column: 1)
!1096 = !DILocation(line: 135, column: 1, scope: !1097)
!1097 = distinct !DILexicalBlock(scope: !1078, file: !2, line: 135, column: 1)
!1098 = distinct !DIAssignID()
!1099 = !DILocation(line: 135, column: 1, scope: !1100)
!1100 = distinct !DILexicalBlock(scope: !1097, file: !2, line: 135, column: 1)
!1101 = !DILocation(line: 135, column: 1, scope: !1102)
!1102 = distinct !DILexicalBlock(scope: !1100, file: !2, line: 135, column: 1)
!1103 = !{!1104, !1104, i64 0}
!1104 = !{!"long", !416, i64 0}
!1105 = distinct !{!1105, !1092, !1092, !430, !431}
!1106 = !DILocation(line: 135, column: 1, scope: !1107)
!1107 = distinct !DILexicalBlock(scope: !1108, file: !2, line: 135, column: 1)
!1108 = distinct !DILexicalBlock(scope: !1078, file: !2, line: 135, column: 1)
!1109 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1110, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1113)
!1110 = !DISubroutineType(types: !1111)
!1111 = !{!201, !243, !1112, !201}
!1112 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !258, size: 64)
!1113 = !{!1114, !1115, !1116, !1117, !1118, !1119, !1120}
!1114 = !DILocalVariable(name: "s", arg: 1, scope: !1109, file: !2, line: 136, type: !243)
!1115 = !DILocalVariable(name: "arr", arg: 2, scope: !1109, file: !2, line: 136, type: !1112)
!1116 = !DILocalVariable(name: "n", arg: 3, scope: !1109, file: !2, line: 136, type: !201)
!1117 = !DILocalVariable(name: "line", scope: !1109, file: !2, line: 136, type: !243)
!1118 = !DILocalVariable(name: "endptr", scope: !1109, file: !2, line: 136, type: !243)
!1119 = !DILocalVariable(name: "i", scope: !1109, file: !2, line: 136, type: !201)
!1120 = !DILocalVariable(name: "v", scope: !1109, file: !2, line: 136, type: !258)
!1121 = distinct !DIAssignID()
!1122 = !DILocation(line: 0, scope: !1109)
!1123 = !DILocation(line: 136, column: 1, scope: !1109)
!1124 = !DILocation(line: 136, column: 1, scope: !1125)
!1125 = distinct !DILexicalBlock(scope: !1126, file: !2, line: 136, column: 1)
!1126 = distinct !DILexicalBlock(scope: !1109, file: !2, line: 136, column: 1)
!1127 = !DILocation(line: 136, column: 1, scope: !1128)
!1128 = distinct !DILexicalBlock(scope: !1109, file: !2, line: 136, column: 1)
!1129 = distinct !DIAssignID()
!1130 = !DILocation(line: 136, column: 1, scope: !1131)
!1131 = distinct !DILexicalBlock(scope: !1128, file: !2, line: 136, column: 1)
!1132 = !DILocation(line: 136, column: 1, scope: !1133)
!1133 = distinct !DILexicalBlock(scope: !1131, file: !2, line: 136, column: 1)
!1134 = distinct !{!1134, !1123, !1123, !430, !431}
!1135 = !DILocation(line: 136, column: 1, scope: !1136)
!1136 = distinct !DILexicalBlock(scope: !1137, file: !2, line: 136, column: 1)
!1137 = distinct !DILexicalBlock(scope: !1109, file: !2, line: 136, column: 1)
!1138 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1139, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1142)
!1139 = !DISubroutineType(types: !1140)
!1140 = !{!201, !243, !1141, !201}
!1141 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !261, size: 64)
!1142 = !{!1143, !1144, !1145, !1146, !1147, !1148, !1149}
!1143 = !DILocalVariable(name: "s", arg: 1, scope: !1138, file: !2, line: 137, type: !243)
!1144 = !DILocalVariable(name: "arr", arg: 2, scope: !1138, file: !2, line: 137, type: !1141)
!1145 = !DILocalVariable(name: "n", arg: 3, scope: !1138, file: !2, line: 137, type: !201)
!1146 = !DILocalVariable(name: "line", scope: !1138, file: !2, line: 137, type: !243)
!1147 = !DILocalVariable(name: "endptr", scope: !1138, file: !2, line: 137, type: !243)
!1148 = !DILocalVariable(name: "i", scope: !1138, file: !2, line: 137, type: !201)
!1149 = !DILocalVariable(name: "v", scope: !1138, file: !2, line: 137, type: !261)
!1150 = distinct !DIAssignID()
!1151 = !DILocation(line: 0, scope: !1138)
!1152 = !DILocation(line: 137, column: 1, scope: !1138)
!1153 = !DILocation(line: 137, column: 1, scope: !1154)
!1154 = distinct !DILexicalBlock(scope: !1155, file: !2, line: 137, column: 1)
!1155 = distinct !DILexicalBlock(scope: !1138, file: !2, line: 137, column: 1)
!1156 = !DILocation(line: 137, column: 1, scope: !1157)
!1157 = distinct !DILexicalBlock(scope: !1138, file: !2, line: 137, column: 1)
!1158 = distinct !DIAssignID()
!1159 = !DILocation(line: 137, column: 1, scope: !1160)
!1160 = distinct !DILexicalBlock(scope: !1157, file: !2, line: 137, column: 1)
!1161 = !DILocation(line: 137, column: 1, scope: !1162)
!1162 = distinct !DILexicalBlock(scope: !1160, file: !2, line: 137, column: 1)
!1163 = distinct !{!1163, !1152, !1152, !430, !431}
!1164 = !DILocation(line: 137, column: 1, scope: !1165)
!1165 = distinct !DILexicalBlock(scope: !1166, file: !2, line: 137, column: 1)
!1166 = distinct !DILexicalBlock(scope: !1138, file: !2, line: 137, column: 1)
!1167 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1168, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1170)
!1168 = !DISubroutineType(types: !1169)
!1169 = !{!201, !243, !215, !201}
!1170 = !{!1171, !1172, !1173, !1174, !1175, !1176, !1177}
!1171 = !DILocalVariable(name: "s", arg: 1, scope: !1167, file: !2, line: 138, type: !243)
!1172 = !DILocalVariable(name: "arr", arg: 2, scope: !1167, file: !2, line: 138, type: !215)
!1173 = !DILocalVariable(name: "n", arg: 3, scope: !1167, file: !2, line: 138, type: !201)
!1174 = !DILocalVariable(name: "line", scope: !1167, file: !2, line: 138, type: !243)
!1175 = !DILocalVariable(name: "endptr", scope: !1167, file: !2, line: 138, type: !243)
!1176 = !DILocalVariable(name: "i", scope: !1167, file: !2, line: 138, type: !201)
!1177 = !DILocalVariable(name: "v", scope: !1167, file: !2, line: 138, type: !197)
!1178 = distinct !DIAssignID()
!1179 = !DILocation(line: 0, scope: !1167)
!1180 = !DILocation(line: 138, column: 1, scope: !1167)
!1181 = !DILocation(line: 138, column: 1, scope: !1182)
!1182 = distinct !DILexicalBlock(scope: !1183, file: !2, line: 138, column: 1)
!1183 = distinct !DILexicalBlock(scope: !1167, file: !2, line: 138, column: 1)
!1184 = !DILocation(line: 138, column: 1, scope: !1185)
!1185 = distinct !DILexicalBlock(scope: !1167, file: !2, line: 138, column: 1)
!1186 = distinct !DIAssignID()
!1187 = !DILocation(line: 138, column: 1, scope: !1188)
!1188 = distinct !DILexicalBlock(scope: !1185, file: !2, line: 138, column: 1)
!1189 = !DILocation(line: 138, column: 1, scope: !1190)
!1190 = distinct !DILexicalBlock(scope: !1188, file: !2, line: 138, column: 1)
!1191 = distinct !{!1191, !1180, !1180, !430, !431}
!1192 = !DILocation(line: 138, column: 1, scope: !1193)
!1193 = distinct !DILexicalBlock(scope: !1194, file: !2, line: 138, column: 1)
!1194 = distinct !DILexicalBlock(scope: !1167, file: !2, line: 138, column: 1)
!1195 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1196, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1199)
!1196 = !DISubroutineType(types: !1197)
!1197 = !{!201, !243, !1198, !201}
!1198 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !264, size: 64)
!1199 = !{!1200, !1201, !1202, !1203, !1204, !1205, !1206}
!1200 = !DILocalVariable(name: "s", arg: 1, scope: !1195, file: !2, line: 139, type: !243)
!1201 = !DILocalVariable(name: "arr", arg: 2, scope: !1195, file: !2, line: 139, type: !1198)
!1202 = !DILocalVariable(name: "n", arg: 3, scope: !1195, file: !2, line: 139, type: !201)
!1203 = !DILocalVariable(name: "line", scope: !1195, file: !2, line: 139, type: !243)
!1204 = !DILocalVariable(name: "endptr", scope: !1195, file: !2, line: 139, type: !243)
!1205 = !DILocalVariable(name: "i", scope: !1195, file: !2, line: 139, type: !201)
!1206 = !DILocalVariable(name: "v", scope: !1195, file: !2, line: 139, type: !264)
!1207 = distinct !DIAssignID()
!1208 = !DILocation(line: 0, scope: !1195)
!1209 = !DILocation(line: 139, column: 1, scope: !1195)
!1210 = !DILocation(line: 139, column: 1, scope: !1211)
!1211 = distinct !DILexicalBlock(scope: !1212, file: !2, line: 139, column: 1)
!1212 = distinct !DILexicalBlock(scope: !1195, file: !2, line: 139, column: 1)
!1213 = !DILocation(line: 139, column: 1, scope: !1214)
!1214 = distinct !DILexicalBlock(scope: !1195, file: !2, line: 139, column: 1)
!1215 = distinct !DIAssignID()
!1216 = !DILocation(line: 139, column: 1, scope: !1217)
!1217 = distinct !DILexicalBlock(scope: !1214, file: !2, line: 139, column: 1)
!1218 = !DILocation(line: 139, column: 1, scope: !1219)
!1219 = distinct !DILexicalBlock(scope: !1217, file: !2, line: 139, column: 1)
!1220 = distinct !{!1220, !1209, !1209, !430, !431}
!1221 = !DILocation(line: 139, column: 1, scope: !1222)
!1222 = distinct !DILexicalBlock(scope: !1223, file: !2, line: 139, column: 1)
!1223 = distinct !DILexicalBlock(scope: !1195, file: !2, line: 139, column: 1)
!1224 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1225, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1228)
!1225 = !DISubroutineType(types: !1226)
!1226 = !{!201, !243, !1227, !201}
!1227 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !267, size: 64)
!1228 = !{!1229, !1230, !1231, !1232, !1233, !1234, !1235}
!1229 = !DILocalVariable(name: "s", arg: 1, scope: !1224, file: !2, line: 141, type: !243)
!1230 = !DILocalVariable(name: "arr", arg: 2, scope: !1224, file: !2, line: 141, type: !1227)
!1231 = !DILocalVariable(name: "n", arg: 3, scope: !1224, file: !2, line: 141, type: !201)
!1232 = !DILocalVariable(name: "line", scope: !1224, file: !2, line: 141, type: !243)
!1233 = !DILocalVariable(name: "endptr", scope: !1224, file: !2, line: 141, type: !243)
!1234 = !DILocalVariable(name: "i", scope: !1224, file: !2, line: 141, type: !201)
!1235 = !DILocalVariable(name: "v", scope: !1224, file: !2, line: 141, type: !267)
!1236 = distinct !DIAssignID()
!1237 = !DILocation(line: 0, scope: !1224)
!1238 = !DILocation(line: 141, column: 1, scope: !1224)
!1239 = !DILocation(line: 141, column: 1, scope: !1240)
!1240 = distinct !DILexicalBlock(scope: !1241, file: !2, line: 141, column: 1)
!1241 = distinct !DILexicalBlock(scope: !1224, file: !2, line: 141, column: 1)
!1242 = !DILocation(line: 141, column: 1, scope: !1243)
!1243 = distinct !DILexicalBlock(scope: !1224, file: !2, line: 141, column: 1)
!1244 = distinct !DIAssignID()
!1245 = !DILocation(line: 141, column: 1, scope: !1246)
!1246 = distinct !DILexicalBlock(scope: !1243, file: !2, line: 141, column: 1)
!1247 = !DILocation(line: 141, column: 1, scope: !1248)
!1248 = distinct !DILexicalBlock(scope: !1246, file: !2, line: 141, column: 1)
!1249 = !{!1250, !1250, i64 0}
!1250 = !{!"float", !416, i64 0}
!1251 = distinct !{!1251, !1238, !1238, !430, !431}
!1252 = !DILocation(line: 141, column: 1, scope: !1253)
!1253 = distinct !DILexicalBlock(scope: !1254, file: !2, line: 141, column: 1)
!1254 = distinct !DILexicalBlock(scope: !1224, file: !2, line: 141, column: 1)
!1255 = !DISubprogram(name: "strtof", scope: !579, file: !579, line: 124, type: !1256, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1256 = !DISubroutineType(types: !1257)
!1257 = !{!267, !954, !958}
!1258 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1259, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1261)
!1259 = !DISubroutineType(types: !1260)
!1260 = !{!201, !243, !216, !201}
!1261 = !{!1262, !1263, !1264, !1265, !1266, !1267, !1268}
!1262 = !DILocalVariable(name: "s", arg: 1, scope: !1258, file: !2, line: 142, type: !243)
!1263 = !DILocalVariable(name: "arr", arg: 2, scope: !1258, file: !2, line: 142, type: !216)
!1264 = !DILocalVariable(name: "n", arg: 3, scope: !1258, file: !2, line: 142, type: !201)
!1265 = !DILocalVariable(name: "line", scope: !1258, file: !2, line: 142, type: !243)
!1266 = !DILocalVariable(name: "endptr", scope: !1258, file: !2, line: 142, type: !243)
!1267 = !DILocalVariable(name: "i", scope: !1258, file: !2, line: 142, type: !201)
!1268 = !DILocalVariable(name: "v", scope: !1258, file: !2, line: 142, type: !209)
!1269 = distinct !DIAssignID()
!1270 = !DILocation(line: 0, scope: !1258)
!1271 = !DILocation(line: 142, column: 1, scope: !1258)
!1272 = !DILocation(line: 142, column: 1, scope: !1273)
!1273 = distinct !DILexicalBlock(scope: !1274, file: !2, line: 142, column: 1)
!1274 = distinct !DILexicalBlock(scope: !1258, file: !2, line: 142, column: 1)
!1275 = !DILocation(line: 142, column: 1, scope: !1276)
!1276 = distinct !DILexicalBlock(scope: !1258, file: !2, line: 142, column: 1)
!1277 = distinct !DIAssignID()
!1278 = !DILocation(line: 142, column: 1, scope: !1279)
!1279 = distinct !DILexicalBlock(scope: !1276, file: !2, line: 142, column: 1)
!1280 = !DILocation(line: 142, column: 1, scope: !1281)
!1281 = distinct !DILexicalBlock(scope: !1279, file: !2, line: 142, column: 1)
!1282 = distinct !{!1282, !1271, !1271, !430, !431}
!1283 = !DILocation(line: 142, column: 1, scope: !1284)
!1284 = distinct !DILexicalBlock(scope: !1285, file: !2, line: 142, column: 1)
!1285 = distinct !DILexicalBlock(scope: !1258, file: !2, line: 142, column: 1)
!1286 = !DISubprogram(name: "strtod", scope: !579, file: !579, line: 118, type: !1287, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1287 = !DISubroutineType(types: !1288)
!1288 = !{!209, !954, !958}
!1289 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1290, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1292)
!1290 = !DISubroutineType(types: !1291)
!1291 = !{!201, !201, !243, !201}
!1292 = !{!1293, !1294, !1295, !1296, !1297}
!1293 = !DILocalVariable(name: "fd", arg: 1, scope: !1289, file: !2, line: 145, type: !201)
!1294 = !DILocalVariable(name: "arr", arg: 2, scope: !1289, file: !2, line: 145, type: !243)
!1295 = !DILocalVariable(name: "n", arg: 3, scope: !1289, file: !2, line: 145, type: !201)
!1296 = !DILocalVariable(name: "status", scope: !1289, file: !2, line: 146, type: !201)
!1297 = !DILocalVariable(name: "written", scope: !1289, file: !2, line: 146, type: !201)
!1298 = !DILocation(line: 0, scope: !1289)
!1299 = !DILocation(line: 147, column: 3, scope: !1300)
!1300 = distinct !DILexicalBlock(scope: !1301, file: !2, line: 147, column: 3)
!1301 = distinct !DILexicalBlock(scope: !1289, file: !2, line: 147, column: 3)
!1302 = !DILocation(line: 148, column: 8, scope: !1303)
!1303 = distinct !DILexicalBlock(scope: !1289, file: !2, line: 148, column: 7)
!1304 = !DILocation(line: 148, column: 7, scope: !1289)
!1305 = !DILocation(line: 149, column: 9, scope: !1306)
!1306 = distinct !DILexicalBlock(scope: !1303, file: !2, line: 148, column: 13)
!1307 = !DILocation(line: 150, column: 3, scope: !1306)
!1308 = !DILocation(line: 152, column: 16, scope: !1289)
!1309 = !DILocation(line: 152, column: 3, scope: !1289)
!1310 = !DILocation(line: 158, column: 3, scope: !1289)
!1311 = !DILocation(line: 155, column: 13, scope: !1312)
!1312 = distinct !DILexicalBlock(scope: !1289, file: !2, line: 152, column: 20)
!1313 = distinct !{!1313, !1309, !1314, !430, !431}
!1314 = !DILocation(line: 156, column: 3, scope: !1289)
!1315 = !DILocation(line: 153, column: 25, scope: !1312)
!1316 = !DILocation(line: 153, column: 40, scope: !1312)
!1317 = !DILocation(line: 153, column: 39, scope: !1312)
!1318 = !DILocation(line: 153, column: 14, scope: !1312)
!1319 = !DILocation(line: 154, column: 5, scope: !1320)
!1320 = distinct !DILexicalBlock(scope: !1321, file: !2, line: 154, column: 5)
!1321 = distinct !DILexicalBlock(scope: !1312, file: !2, line: 154, column: 5)
!1322 = !DILocation(line: 159, column: 14, scope: !1323)
!1323 = distinct !DILexicalBlock(scope: !1289, file: !2, line: 158, column: 6)
!1324 = !DILocation(line: 160, column: 5, scope: !1325)
!1325 = distinct !DILexicalBlock(scope: !1326, file: !2, line: 160, column: 5)
!1326 = distinct !DILexicalBlock(scope: !1323, file: !2, line: 160, column: 5)
!1327 = !DILocation(line: 161, column: 17, scope: !1289)
!1328 = !DILocation(line: 161, column: 3, scope: !1323)
!1329 = distinct !{!1329, !1310, !1330, !430, !431}
!1330 = !DILocation(line: 161, column: 20, scope: !1289)
!1331 = !DILocation(line: 163, column: 3, scope: !1289)
!1332 = !DISubprogram(name: "write", scope: !852, file: !852, line: 378, type: !1333, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1333 = !DISubroutineType(types: !1334)
!1334 = !{!801, !201, !1335, !849}
!1335 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1336, size: 64)
!1336 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1337 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1338, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1340)
!1338 = !DISubroutineType(types: !1339)
!1339 = !{!201, !201, !921, !201}
!1340 = !{!1341, !1342, !1343, !1344}
!1341 = !DILocalVariable(name: "fd", arg: 1, scope: !1337, file: !2, line: 177, type: !201)
!1342 = !DILocalVariable(name: "arr", arg: 2, scope: !1337, file: !2, line: 177, type: !921)
!1343 = !DILocalVariable(name: "n", arg: 3, scope: !1337, file: !2, line: 177, type: !201)
!1344 = !DILocalVariable(name: "i", scope: !1337, file: !2, line: 177, type: !201)
!1345 = !DILocation(line: 0, scope: !1337)
!1346 = !DILocation(line: 177, column: 1, scope: !1347)
!1347 = distinct !DILexicalBlock(scope: !1348, file: !2, line: 177, column: 1)
!1348 = distinct !DILexicalBlock(scope: !1337, file: !2, line: 177, column: 1)
!1349 = !DILocation(line: 177, column: 1, scope: !1350)
!1350 = distinct !DILexicalBlock(scope: !1351, file: !2, line: 177, column: 1)
!1351 = distinct !DILexicalBlock(scope: !1337, file: !2, line: 177, column: 1)
!1352 = !DILocation(line: 177, column: 1, scope: !1351)
!1353 = !DILocation(line: 177, column: 1, scope: !1354)
!1354 = distinct !DILexicalBlock(scope: !1350, file: !2, line: 177, column: 1)
!1355 = distinct !{!1355, !1352, !1352, !430, !431}
!1356 = !DILocation(line: 177, column: 1, scope: !1337)
!1357 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1358, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1360)
!1358 = !DISubroutineType(cc: DW_CC_nocall, types: !1359)
!1359 = !{!201, !201, !840, null}
!1360 = !{!1361, !1362, !1363, !1367, !1368, !1369, !1370}
!1361 = !DILocalVariable(name: "fd", arg: 1, scope: !1357, file: !2, line: 15, type: !201)
!1362 = !DILocalVariable(name: "format", arg: 2, scope: !1357, file: !2, line: 15, type: !840)
!1363 = !DILocalVariable(name: "args", scope: !1357, file: !2, line: 16, type: !1364)
!1364 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1365, line: 12, baseType: !1366)
!1365 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1366 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !244)
!1367 = !DILocalVariable(name: "buffered", scope: !1357, file: !2, line: 17, type: !201)
!1368 = !DILocalVariable(name: "written", scope: !1357, file: !2, line: 17, type: !201)
!1369 = !DILocalVariable(name: "status", scope: !1357, file: !2, line: 17, type: !201)
!1370 = !DILocalVariable(name: "buffer", scope: !1357, file: !2, line: 18, type: !1371)
!1371 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !1372)
!1372 = !{!1373}
!1373 = !DISubrange(count: 256)
!1374 = distinct !DIAssignID()
!1375 = !DILocation(line: 0, scope: !1357)
!1376 = distinct !DIAssignID()
!1377 = !DILocation(line: 16, column: 3, scope: !1357)
!1378 = !DILocation(line: 18, column: 3, scope: !1357)
!1379 = !DILocation(line: 19, column: 3, scope: !1357)
!1380 = !DILocation(line: 20, column: 66, scope: !1357)
!1381 = !DILocation(line: 20, column: 14, scope: !1357)
!1382 = !DILocation(line: 21, column: 3, scope: !1357)
!1383 = !DILocation(line: 22, column: 3, scope: !1384)
!1384 = distinct !DILexicalBlock(scope: !1385, file: !2, line: 22, column: 3)
!1385 = distinct !DILexicalBlock(scope: !1357, file: !2, line: 22, column: 3)
!1386 = !DILocation(line: 24, column: 16, scope: !1357)
!1387 = !DILocation(line: 24, column: 3, scope: !1357)
!1388 = !DILocation(line: 27, column: 13, scope: !1389)
!1389 = distinct !DILexicalBlock(scope: !1357, file: !2, line: 24, column: 27)
!1390 = distinct !{!1390, !1387, !1391, !430, !431}
!1391 = !DILocation(line: 28, column: 3, scope: !1357)
!1392 = !DILocation(line: 25, column: 25, scope: !1389)
!1393 = !DILocation(line: 25, column: 50, scope: !1389)
!1394 = !DILocation(line: 25, column: 42, scope: !1389)
!1395 = !DILocation(line: 25, column: 14, scope: !1389)
!1396 = !DILocation(line: 26, column: 5, scope: !1397)
!1397 = distinct !DILexicalBlock(scope: !1398, file: !2, line: 26, column: 5)
!1398 = distinct !DILexicalBlock(scope: !1389, file: !2, line: 26, column: 5)
!1399 = !DILocation(line: 29, column: 3, scope: !1400)
!1400 = distinct !DILexicalBlock(scope: !1401, file: !2, line: 29, column: 3)
!1401 = distinct !DILexicalBlock(scope: !1357, file: !2, line: 29, column: 3)
!1402 = !DILocation(line: 31, column: 1, scope: !1357)
!1403 = !DILocation(line: 30, column: 3, scope: !1357)
!1404 = !DISubprogram(name: "vsnprintf", scope: !961, file: !961, line: 389, type: !1405, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1405 = !DISubroutineType(types: !1406)
!1406 = !{!201, !953, !849, !954, !1407}
!1407 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1408, line: 12, baseType: !1366)
!1408 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1409 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1410, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1412)
!1410 = !DISubroutineType(types: !1411)
!1411 = !{!201, !201, !1021, !201}
!1412 = !{!1413, !1414, !1415, !1416}
!1413 = !DILocalVariable(name: "fd", arg: 1, scope: !1409, file: !2, line: 178, type: !201)
!1414 = !DILocalVariable(name: "arr", arg: 2, scope: !1409, file: !2, line: 178, type: !1021)
!1415 = !DILocalVariable(name: "n", arg: 3, scope: !1409, file: !2, line: 178, type: !201)
!1416 = !DILocalVariable(name: "i", scope: !1409, file: !2, line: 178, type: !201)
!1417 = !DILocation(line: 0, scope: !1409)
!1418 = !DILocation(line: 178, column: 1, scope: !1419)
!1419 = distinct !DILexicalBlock(scope: !1420, file: !2, line: 178, column: 1)
!1420 = distinct !DILexicalBlock(scope: !1409, file: !2, line: 178, column: 1)
!1421 = !DILocation(line: 178, column: 1, scope: !1422)
!1422 = distinct !DILexicalBlock(scope: !1423, file: !2, line: 178, column: 1)
!1423 = distinct !DILexicalBlock(scope: !1409, file: !2, line: 178, column: 1)
!1424 = !DILocation(line: 178, column: 1, scope: !1423)
!1425 = !DILocation(line: 178, column: 1, scope: !1426)
!1426 = distinct !DILexicalBlock(scope: !1422, file: !2, line: 178, column: 1)
!1427 = distinct !{!1427, !1424, !1424, !430, !431}
!1428 = !DILocation(line: 178, column: 1, scope: !1409)
!1429 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1430, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1432)
!1430 = !DISubroutineType(types: !1431)
!1431 = !{!201, !201, !1052, !201}
!1432 = !{!1433, !1434, !1435, !1436}
!1433 = !DILocalVariable(name: "fd", arg: 1, scope: !1429, file: !2, line: 179, type: !201)
!1434 = !DILocalVariable(name: "arr", arg: 2, scope: !1429, file: !2, line: 179, type: !1052)
!1435 = !DILocalVariable(name: "n", arg: 3, scope: !1429, file: !2, line: 179, type: !201)
!1436 = !DILocalVariable(name: "i", scope: !1429, file: !2, line: 179, type: !201)
!1437 = !DILocation(line: 0, scope: !1429)
!1438 = !DILocation(line: 179, column: 1, scope: !1439)
!1439 = distinct !DILexicalBlock(scope: !1440, file: !2, line: 179, column: 1)
!1440 = distinct !DILexicalBlock(scope: !1429, file: !2, line: 179, column: 1)
!1441 = !DILocation(line: 179, column: 1, scope: !1442)
!1442 = distinct !DILexicalBlock(scope: !1443, file: !2, line: 179, column: 1)
!1443 = distinct !DILexicalBlock(scope: !1429, file: !2, line: 179, column: 1)
!1444 = !DILocation(line: 179, column: 1, scope: !1443)
!1445 = !DILocation(line: 179, column: 1, scope: !1446)
!1446 = distinct !DILexicalBlock(scope: !1442, file: !2, line: 179, column: 1)
!1447 = distinct !{!1447, !1444, !1444, !430, !431}
!1448 = !DILocation(line: 179, column: 1, scope: !1429)
!1449 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1450, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1452)
!1450 = !DISubroutineType(types: !1451)
!1451 = !{!201, !201, !1081, !201}
!1452 = !{!1453, !1454, !1455, !1456}
!1453 = !DILocalVariable(name: "fd", arg: 1, scope: !1449, file: !2, line: 180, type: !201)
!1454 = !DILocalVariable(name: "arr", arg: 2, scope: !1449, file: !2, line: 180, type: !1081)
!1455 = !DILocalVariable(name: "n", arg: 3, scope: !1449, file: !2, line: 180, type: !201)
!1456 = !DILocalVariable(name: "i", scope: !1449, file: !2, line: 180, type: !201)
!1457 = !DILocation(line: 0, scope: !1449)
!1458 = !DILocation(line: 180, column: 1, scope: !1459)
!1459 = distinct !DILexicalBlock(scope: !1460, file: !2, line: 180, column: 1)
!1460 = distinct !DILexicalBlock(scope: !1449, file: !2, line: 180, column: 1)
!1461 = !DILocation(line: 180, column: 1, scope: !1462)
!1462 = distinct !DILexicalBlock(scope: !1463, file: !2, line: 180, column: 1)
!1463 = distinct !DILexicalBlock(scope: !1449, file: !2, line: 180, column: 1)
!1464 = !DILocation(line: 180, column: 1, scope: !1463)
!1465 = !DILocation(line: 180, column: 1, scope: !1466)
!1466 = distinct !DILexicalBlock(scope: !1462, file: !2, line: 180, column: 1)
!1467 = distinct !{!1467, !1464, !1464, !430, !431}
!1468 = !DILocation(line: 180, column: 1, scope: !1449)
!1469 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1470, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1472)
!1470 = !DISubroutineType(types: !1471)
!1471 = !{!201, !201, !1112, !201}
!1472 = !{!1473, !1474, !1475, !1476}
!1473 = !DILocalVariable(name: "fd", arg: 1, scope: !1469, file: !2, line: 181, type: !201)
!1474 = !DILocalVariable(name: "arr", arg: 2, scope: !1469, file: !2, line: 181, type: !1112)
!1475 = !DILocalVariable(name: "n", arg: 3, scope: !1469, file: !2, line: 181, type: !201)
!1476 = !DILocalVariable(name: "i", scope: !1469, file: !2, line: 181, type: !201)
!1477 = !DILocation(line: 0, scope: !1469)
!1478 = !DILocation(line: 181, column: 1, scope: !1479)
!1479 = distinct !DILexicalBlock(scope: !1480, file: !2, line: 181, column: 1)
!1480 = distinct !DILexicalBlock(scope: !1469, file: !2, line: 181, column: 1)
!1481 = !DILocation(line: 181, column: 1, scope: !1482)
!1482 = distinct !DILexicalBlock(scope: !1483, file: !2, line: 181, column: 1)
!1483 = distinct !DILexicalBlock(scope: !1469, file: !2, line: 181, column: 1)
!1484 = !DILocation(line: 181, column: 1, scope: !1483)
!1485 = !DILocation(line: 181, column: 1, scope: !1486)
!1486 = distinct !DILexicalBlock(scope: !1482, file: !2, line: 181, column: 1)
!1487 = distinct !{!1487, !1484, !1484, !430, !431}
!1488 = !DILocation(line: 181, column: 1, scope: !1469)
!1489 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1490, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1492)
!1490 = !DISubroutineType(types: !1491)
!1491 = !{!201, !201, !1141, !201}
!1492 = !{!1493, !1494, !1495, !1496}
!1493 = !DILocalVariable(name: "fd", arg: 1, scope: !1489, file: !2, line: 182, type: !201)
!1494 = !DILocalVariable(name: "arr", arg: 2, scope: !1489, file: !2, line: 182, type: !1141)
!1495 = !DILocalVariable(name: "n", arg: 3, scope: !1489, file: !2, line: 182, type: !201)
!1496 = !DILocalVariable(name: "i", scope: !1489, file: !2, line: 182, type: !201)
!1497 = !DILocation(line: 0, scope: !1489)
!1498 = !DILocation(line: 182, column: 1, scope: !1499)
!1499 = distinct !DILexicalBlock(scope: !1500, file: !2, line: 182, column: 1)
!1500 = distinct !DILexicalBlock(scope: !1489, file: !2, line: 182, column: 1)
!1501 = !DILocation(line: 182, column: 1, scope: !1502)
!1502 = distinct !DILexicalBlock(scope: !1503, file: !2, line: 182, column: 1)
!1503 = distinct !DILexicalBlock(scope: !1489, file: !2, line: 182, column: 1)
!1504 = !DILocation(line: 182, column: 1, scope: !1503)
!1505 = !DILocation(line: 182, column: 1, scope: !1506)
!1506 = distinct !DILexicalBlock(scope: !1502, file: !2, line: 182, column: 1)
!1507 = distinct !{!1507, !1504, !1504, !430, !431}
!1508 = !DILocation(line: 182, column: 1, scope: !1489)
!1509 = !DILocation(line: 0, scope: !598)
!1510 = !DILocation(line: 183, column: 1, scope: !1511)
!1511 = distinct !DILexicalBlock(scope: !1512, file: !2, line: 183, column: 1)
!1512 = distinct !DILexicalBlock(scope: !598, file: !2, line: 183, column: 1)
!1513 = !DILocation(line: 183, column: 1, scope: !611)
!1514 = !DILocation(line: 183, column: 1, scope: !608)
!1515 = !DILocation(line: 183, column: 1, scope: !610)
!1516 = distinct !{!1516, !1514, !1514, !430, !431}
!1517 = !DILocation(line: 183, column: 1, scope: !598)
!1518 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1519, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1521)
!1519 = !DISubroutineType(types: !1520)
!1520 = !{!201, !201, !1198, !201}
!1521 = !{!1522, !1523, !1524, !1525}
!1522 = !DILocalVariable(name: "fd", arg: 1, scope: !1518, file: !2, line: 184, type: !201)
!1523 = !DILocalVariable(name: "arr", arg: 2, scope: !1518, file: !2, line: 184, type: !1198)
!1524 = !DILocalVariable(name: "n", arg: 3, scope: !1518, file: !2, line: 184, type: !201)
!1525 = !DILocalVariable(name: "i", scope: !1518, file: !2, line: 184, type: !201)
!1526 = !DILocation(line: 0, scope: !1518)
!1527 = !DILocation(line: 184, column: 1, scope: !1528)
!1528 = distinct !DILexicalBlock(scope: !1529, file: !2, line: 184, column: 1)
!1529 = distinct !DILexicalBlock(scope: !1518, file: !2, line: 184, column: 1)
!1530 = !DILocation(line: 184, column: 1, scope: !1531)
!1531 = distinct !DILexicalBlock(scope: !1532, file: !2, line: 184, column: 1)
!1532 = distinct !DILexicalBlock(scope: !1518, file: !2, line: 184, column: 1)
!1533 = !DILocation(line: 184, column: 1, scope: !1532)
!1534 = !DILocation(line: 184, column: 1, scope: !1535)
!1535 = distinct !DILexicalBlock(scope: !1531, file: !2, line: 184, column: 1)
!1536 = distinct !{!1536, !1533, !1533, !430, !431}
!1537 = !DILocation(line: 184, column: 1, scope: !1518)
!1538 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1539, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !241, retainedNodes: !1541)
!1539 = !DISubroutineType(types: !1540)
!1540 = !{!201, !201, !1227, !201}
!1541 = !{!1542, !1543, !1544, !1545}
!1542 = !DILocalVariable(name: "fd", arg: 1, scope: !1538, file: !2, line: 186, type: !201)
!1543 = !DILocalVariable(name: "arr", arg: 2, scope: !1538, file: !2, line: 186, type: !1227)
!1544 = !DILocalVariable(name: "n", arg: 3, scope: !1538, file: !2, line: 186, type: !201)
!1545 = !DILocalVariable(name: "i", scope: !1538, file: !2, line: 186, type: !201)
!1546 = !DILocation(line: 0, scope: !1538)
!1547 = !DILocation(line: 186, column: 1, scope: !1548)
!1548 = distinct !DILexicalBlock(scope: !1549, file: !2, line: 186, column: 1)
!1549 = distinct !DILexicalBlock(scope: !1538, file: !2, line: 186, column: 1)
!1550 = !DILocation(line: 186, column: 1, scope: !1551)
!1551 = distinct !DILexicalBlock(scope: !1552, file: !2, line: 186, column: 1)
!1552 = distinct !DILexicalBlock(scope: !1538, file: !2, line: 186, column: 1)
!1553 = !DILocation(line: 186, column: 1, scope: !1552)
!1554 = !DILocation(line: 186, column: 1, scope: !1555)
!1555 = distinct !DILexicalBlock(scope: !1551, file: !2, line: 186, column: 1)
!1556 = distinct !{!1556, !1553, !1553, !430, !431}
!1557 = !DILocation(line: 186, column: 1, scope: !1538)
!1558 = !DILocation(line: 0, scope: !619)
!1559 = !DILocation(line: 187, column: 1, scope: !1560)
!1560 = distinct !DILexicalBlock(scope: !1561, file: !2, line: 187, column: 1)
!1561 = distinct !DILexicalBlock(scope: !619, file: !2, line: 187, column: 1)
!1562 = !DILocation(line: 187, column: 1, scope: !632)
!1563 = !DILocation(line: 187, column: 1, scope: !629)
!1564 = !DILocation(line: 187, column: 1, scope: !631)
!1565 = distinct !{!1565, !1563, !1563, !430, !431}
!1566 = !DILocation(line: 187, column: 1, scope: !619)
!1567 = !DILocation(line: 0, scope: !587)
!1568 = !DILocation(line: 190, column: 3, scope: !594)
!1569 = !DILocation(line: 191, column: 3, scope: !587)
!1570 = !DILocation(line: 192, column: 3, scope: !587)
!1571 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1572, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !302, retainedNodes: !1574)
!1572 = !DISubroutineType(types: !1573)
!1573 = !{!201, !201, !959}
!1574 = !{!1575, !1576, !1577, !1578, !1579, !1580, !1581, !1582, !1583}
!1575 = !DILocalVariable(name: "argc", arg: 1, scope: !1571, file: !170, line: 14, type: !201)
!1576 = !DILocalVariable(name: "argv", arg: 2, scope: !1571, file: !170, line: 14, type: !959)
!1577 = !DILocalVariable(name: "in_file", scope: !1571, file: !170, line: 17, type: !243)
!1578 = !DILocalVariable(name: "check_file", scope: !1571, file: !170, line: 19, type: !243)
!1579 = !DILocalVariable(name: "in_fd", scope: !1571, file: !170, line: 34, type: !201)
!1580 = !DILocalVariable(name: "data", scope: !1571, file: !170, line: 35, type: !243)
!1581 = !DILocalVariable(name: "out_fd", scope: !1571, file: !170, line: 46, type: !201)
!1582 = !DILocalVariable(name: "check_fd", scope: !1571, file: !170, line: 55, type: !201)
!1583 = !DILocalVariable(name: "ref", scope: !1571, file: !170, line: 56, type: !243)
!1584 = !DILocation(line: 0, scope: !1571)
!1585 = !DILocation(line: 21, column: 3, scope: !1586)
!1586 = distinct !DILexicalBlock(scope: !1587, file: !170, line: 21, column: 3)
!1587 = distinct !DILexicalBlock(scope: !1571, file: !170, line: 21, column: 3)
!1588 = !DILocation(line: 26, column: 11, scope: !1589)
!1589 = distinct !DILexicalBlock(scope: !1571, file: !170, line: 26, column: 7)
!1590 = !DILocation(line: 26, column: 7, scope: !1571)
!1591 = !DILocation(line: 27, column: 15, scope: !1589)
!1592 = !DILocation(line: 29, column: 11, scope: !1593)
!1593 = distinct !DILexicalBlock(scope: !1571, file: !170, line: 29, column: 7)
!1594 = !DILocation(line: 29, column: 7, scope: !1571)
!1595 = !DILocation(line: 30, column: 18, scope: !1593)
!1596 = !DILocation(line: 30, column: 5, scope: !1593)
!1597 = !DILocation(line: 36, column: 17, scope: !1571)
!1598 = !DILocation(line: 36, column: 10, scope: !1571)
!1599 = !DILocation(line: 37, column: 3, scope: !1600)
!1600 = distinct !DILexicalBlock(scope: !1601, file: !170, line: 37, column: 3)
!1601 = distinct !DILexicalBlock(scope: !1571, file: !170, line: 37, column: 3)
!1602 = !DILocation(line: 38, column: 11, scope: !1571)
!1603 = !DILocation(line: 39, column: 3, scope: !1604)
!1604 = distinct !DILexicalBlock(scope: !1605, file: !170, line: 39, column: 3)
!1605 = distinct !DILexicalBlock(scope: !1571, file: !170, line: 39, column: 3)
!1606 = !DILocation(line: 40, column: 3, scope: !1571)
!1607 = !DILocation(line: 0, scope: !503, inlinedAt: !1608)
!1608 = distinct !DILocation(line: 43, column: 3, scope: !1571)
!1609 = !DILocation(line: 10, column: 29, scope: !503, inlinedAt: !1608)
!1610 = !DILocation(line: 10, column: 42, scope: !503, inlinedAt: !1608)
!1611 = !DILocation(line: 10, column: 3, scope: !503, inlinedAt: !1608)
!1612 = !DILocation(line: 47, column: 12, scope: !1571)
!1613 = !DILocation(line: 48, column: 3, scope: !1614)
!1614 = distinct !DILexicalBlock(scope: !1615, file: !170, line: 48, column: 3)
!1615 = distinct !DILexicalBlock(scope: !1571, file: !170, line: 48, column: 3)
!1616 = !DILocation(line: 0, scope: !669, inlinedAt: !1617)
!1617 = distinct !DILocation(line: 49, column: 3, scope: !1571)
!1618 = !DILocation(line: 0, scope: !587, inlinedAt: !1619)
!1619 = distinct !DILocation(line: 68, column: 3, scope: !669, inlinedAt: !1617)
!1620 = !DILocation(line: 190, column: 3, scope: !594, inlinedAt: !1619)
!1621 = !DILocation(line: 191, column: 3, scope: !587, inlinedAt: !1619)
!1622 = !DILocation(line: 0, scope: !619, inlinedAt: !1623)
!1623 = distinct !DILocation(line: 69, column: 3, scope: !669, inlinedAt: !1617)
!1624 = !DILocation(line: 187, column: 1, scope: !629, inlinedAt: !1623)
!1625 = !DILocation(line: 187, column: 1, scope: !631, inlinedAt: !1623)
!1626 = !DILocation(line: 187, column: 1, scope: !632, inlinedAt: !1623)
!1627 = distinct !{!1627, !1624, !1624, !430, !431}
!1628 = !DILocation(line: 50, column: 3, scope: !1571)
!1629 = !DILocation(line: 57, column: 16, scope: !1571)
!1630 = !DILocation(line: 57, column: 9, scope: !1571)
!1631 = !DILocation(line: 58, column: 3, scope: !1632)
!1632 = distinct !DILexicalBlock(scope: !1633, file: !170, line: 58, column: 3)
!1633 = distinct !DILexicalBlock(scope: !1571, file: !170, line: 58, column: 3)
!1634 = !DILocation(line: 59, column: 14, scope: !1571)
!1635 = !DILocation(line: 60, column: 3, scope: !1636)
!1636 = distinct !DILexicalBlock(scope: !1637, file: !170, line: 60, column: 3)
!1637 = distinct !DILexicalBlock(scope: !1571, file: !170, line: 60, column: 3)
!1638 = !DILocation(line: 0, scope: !637, inlinedAt: !1639)
!1639 = distinct !DILocation(line: 61, column: 3, scope: !1571)
!1640 = !DILocation(line: 56, column: 3, scope: !637, inlinedAt: !1639)
!1641 = !DILocation(line: 58, column: 7, scope: !637, inlinedAt: !1639)
!1642 = !DILocation(line: 0, scope: !527, inlinedAt: !1643)
!1643 = distinct !DILocation(line: 60, column: 7, scope: !637, inlinedAt: !1639)
!1644 = !DILocation(line: 64, column: 17, scope: !527, inlinedAt: !1643)
!1645 = !DILocation(line: 64, column: 3, scope: !527, inlinedAt: !1643)
!1646 = !DILocation(line: 66, column: 22, scope: !539, inlinedAt: !1643)
!1647 = !DILocation(line: 66, column: 26, scope: !539, inlinedAt: !1643)
!1648 = !DILocation(line: 66, column: 32, scope: !539, inlinedAt: !1643)
!1649 = !DILocation(line: 66, column: 35, scope: !539, inlinedAt: !1643)
!1650 = !DILocation(line: 66, column: 39, scope: !539, inlinedAt: !1643)
!1651 = !DILocation(line: 66, column: 9, scope: !540, inlinedAt: !1643)
!1652 = !DILocation(line: 69, column: 6, scope: !540, inlinedAt: !1643)
!1653 = !DILocation(line: 64, column: 10, scope: !527, inlinedAt: !1643)
!1654 = !DILocation(line: 64, column: 13, scope: !527, inlinedAt: !1643)
!1655 = distinct !{!1655, !1645, !1656, !430, !431}
!1656 = !DILocation(line: 70, column: 3, scope: !527, inlinedAt: !1643)
!1657 = !DILocation(line: 71, column: 6, scope: !552, inlinedAt: !1643)
!1658 = !DILocation(line: 71, column: 8, scope: !552, inlinedAt: !1643)
!1659 = !DILocation(line: 71, column: 6, scope: !527, inlinedAt: !1643)
!1660 = !DILocation(line: 61, column: 47, scope: !637, inlinedAt: !1639)
!1661 = !DILocation(line: 61, column: 3, scope: !637, inlinedAt: !1639)
!1662 = !DILocation(line: 62, column: 3, scope: !637, inlinedAt: !1639)
!1663 = !DILocation(line: 0, scope: !687, inlinedAt: !1664)
!1664 = distinct !DILocation(line: 66, column: 8, scope: !1665)
!1665 = distinct !DILexicalBlock(scope: !1571, file: !170, line: 66, column: 7)
!1666 = !DILocation(line: 79, column: 3, scope: !705, inlinedAt: !1664)
!1667 = !DILocation(line: 80, column: 5, scope: !707, inlinedAt: !1664)
!1668 = !DILocation(line: 81, column: 7, scope: !711, inlinedAt: !1664)
!1669 = !DILocation(line: 82, column: 9, scope: !715, inlinedAt: !1664)
!1670 = !DILocation(line: 83, column: 20, scope: !719, inlinedAt: !1664)
!1671 = !DILocation(line: 83, column: 44, scope: !719, inlinedAt: !1664)
!1672 = !DILocation(line: 83, column: 48, scope: !719, inlinedAt: !1664)
!1673 = !DILocation(line: 83, column: 71, scope: !719, inlinedAt: !1664)
!1674 = !DILocation(line: 83, column: 46, scope: !719, inlinedAt: !1664)
!1675 = !DILocation(line: 84, column: 44, scope: !719, inlinedAt: !1664)
!1676 = !DILocation(line: 84, column: 71, scope: !719, inlinedAt: !1664)
!1677 = !DILocation(line: 84, column: 46, scope: !719, inlinedAt: !1664)
!1678 = !DILocation(line: 85, column: 44, scope: !719, inlinedAt: !1664)
!1679 = !DILocation(line: 85, column: 71, scope: !719, inlinedAt: !1664)
!1680 = !DILocation(line: 85, column: 46, scope: !719, inlinedAt: !1664)
!1681 = !DILocation(line: 86, column: 43, scope: !719, inlinedAt: !1664)
!1682 = !DILocation(line: 87, column: 43, scope: !719, inlinedAt: !1664)
!1683 = !DILocation(line: 87, column: 22, scope: !719, inlinedAt: !1664)
!1684 = !DILocation(line: 88, column: 43, scope: !719, inlinedAt: !1664)
!1685 = !DILocation(line: 88, column: 22, scope: !719, inlinedAt: !1664)
!1686 = !DILocation(line: 82, column: 36, scope: !720, inlinedAt: !1664)
!1687 = !DILocation(line: 82, column: 19, scope: !720, inlinedAt: !1664)
!1688 = distinct !{!1688, !1669, !1689, !430, !431}
!1689 = !DILocation(line: 89, column: 9, scope: !715, inlinedAt: !1664)
!1690 = !DILocation(line: 81, column: 30, scope: !717, inlinedAt: !1664)
!1691 = !DILocation(line: 81, column: 17, scope: !717, inlinedAt: !1664)
!1692 = distinct !{!1692, !1668, !1693, !430, !431}
!1693 = !DILocation(line: 90, column: 7, scope: !711, inlinedAt: !1664)
!1694 = !DILocation(line: 80, column: 28, scope: !713, inlinedAt: !1664)
!1695 = !DILocation(line: 80, column: 15, scope: !713, inlinedAt: !1664)
!1696 = distinct !{!1696, !1667, !1697, !430, !431}
!1697 = !DILocation(line: 91, column: 5, scope: !707, inlinedAt: !1664)
!1698 = !DILocation(line: 79, column: 26, scope: !709, inlinedAt: !1664)
!1699 = !DILocation(line: 79, column: 13, scope: !709, inlinedAt: !1664)
!1700 = distinct !{!1700, !1666, !1701, !430, !431}
!1701 = !DILocation(line: 92, column: 3, scope: !705, inlinedAt: !1664)
!1702 = !DILocation(line: 95, column: 10, scope: !687, inlinedAt: !1664)
!1703 = !DILocation(line: 66, column: 7, scope: !1571)
!1704 = !DILocation(line: 67, column: 13, scope: !1705)
!1705 = distinct !DILexicalBlock(scope: !1665, file: !170, line: 66, column: 32)
!1706 = !DILocation(line: 67, column: 5, scope: !1705)
!1707 = !DILocation(line: 68, column: 5, scope: !1705)
!1708 = !DILocation(line: 71, column: 3, scope: !1571)
!1709 = !DILocation(line: 72, column: 3, scope: !1571)
!1710 = !DILocation(line: 74, column: 3, scope: !1571)
!1711 = !DILocation(line: 75, column: 3, scope: !1571)
!1712 = !DILocation(line: 76, column: 1, scope: !1571)
!1713 = !DISubprogram(name: "open", scope: !1714, file: !1714, line: 209, type: !1715, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1714 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1715 = !DISubroutineType(types: !1716)
!1716 = !{!201, !840, !201, null}
