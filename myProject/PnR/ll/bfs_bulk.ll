; ModuleID = 'bfs/bulk/bfs_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.node_t_struct = type { i64, i64 }
%struct.edge_t_struct = type { i64 }
%struct.bench_args_t = type { [256 x %struct.node_t_struct], [4096 x %struct.edge_t_struct], i64, [256 x i8], [10 x i64] }
%struct.stat = type { i64, i64, i32, i32, i32, i32, i64, i64, i64, i32, i32, i64, %struct.node_t_struct, %struct.node_t_struct, %struct.node_t_struct, [2 x i32] }

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
@INPUT_SIZE = dso_local local_unnamed_addr global i32 37208, align 4, !dbg !186
@.str.6.14 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !234
@.str.8.15 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !237
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !240
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !245
@.str.12.16 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !248
@.str.14.17 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !250
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !253
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @bfs(ptr nocapture noundef readonly %nodes, ptr nocapture noundef readonly %edges, i64 noundef %starting_node, ptr nocapture noundef %level, ptr nocapture noundef writeonly %level_counts) local_unnamed_addr #0 !dbg !345 {
entry.split:
  %cnt.3.reg2mem24 = alloca i64, align 8
  %cnt.2.reg2mem26 = alloca i64, align 8
  %cnt.160.reg2mem28 = alloca i64, align 8
  %e.061.reg2mem30 = alloca i64, align 8
  %cnt.062.reg2mem32 = alloca i64, align 8
  %n.063.reg2mem34 = alloca i64, align 8
  %indvars.iv.reg2mem36 = alloca i64, align 8
    #dbg_value(ptr %nodes, !362, !DIExpression(), !389)
    #dbg_value(ptr %edges, !363, !DIExpression(), !389)
    #dbg_value(i64 %starting_node, !364, !DIExpression(), !389)
    #dbg_value(ptr %level, !365, !DIExpression(), !389)
    #dbg_value(ptr %level_counts, !366, !DIExpression(), !389)
  %arrayidx = getelementptr inbounds i8, ptr %level, i64 %starting_node, !dbg !390
  store i8 0, ptr %arrayidx, align 1, !dbg !391, !tbaa !392
  store i64 1, ptr %level_counts, align 8, !dbg !395, !tbaa !396
    #dbg_label(!371, !398)
    #dbg_value(i8 0, !369, !DIExpression(), !389)
  %invariant.gep = getelementptr i8, ptr %level_counts, i64 8, !dbg !399
  store i64 0, ptr %indvars.iv.reg2mem36, align 8
  br label %for.cond3.preheader, !dbg !400

for.cond3.preheader:                              ; preds = %for.end31.for.cond3.preheader_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv.reg2mem36.0.load, !369, !DIExpression(), !389)
    #dbg_value(i64 0, !367, !DIExpression(), !389)
    #dbg_value(i64 0, !370, !DIExpression(), !389)
  %indvars.iv.reg2mem36.0.load = load i64, ptr %indvars.iv.reg2mem36, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem36.0.load, 1, !dbg !401
  %0 = trunc i64 %indvars.iv.next to i8
  store i64 0, ptr %cnt.062.reg2mem32, align 8
  store i64 0, ptr %n.063.reg2mem34, align 8
  br label %for.body6, !dbg !402

for.body6:                                        ; preds = %for.inc29.for.body6_crit_edge, %for.cond3.preheader
    #dbg_value(i64 %n.063.reg2mem34.0.load, !367, !DIExpression(), !389)
    #dbg_value(i64 %cnt.062.reg2mem32.0.load, !370, !DIExpression(), !389)
  %n.063.reg2mem34.0.load = load i64, ptr %n.063.reg2mem34, align 8
  %cnt.062.reg2mem32.0.load = load i64, ptr %cnt.062.reg2mem32, align 8
  %arrayidx7 = getelementptr inbounds i8, ptr %level, i64 %n.063.reg2mem34.0.load, !dbg !403
  %1 = load i8, ptr %arrayidx7, align 1, !dbg !403, !tbaa !392
  %2 = zext i8 %1 to i64, !dbg !404
  %cmp10 = icmp eq i64 %indvars.iv.reg2mem36.0.load, %2, !dbg !404
  br i1 %cmp10, label %if.then, label %for.body6.for.inc29_crit_edge, !dbg !405

for.body6.for.inc29_crit_edge:                    ; preds = %for.body6
  store i64 %cnt.062.reg2mem32.0.load, ptr %cnt.3.reg2mem24, align 8
  br label %for.inc29, !dbg !405

if.then:                                          ; preds = %for.body6
  %arrayidx12 = getelementptr inbounds %struct.node_t_struct, ptr %nodes, i64 %n.063.reg2mem34.0.load, !dbg !406
  %3 = load i64, ptr %arrayidx12, align 8, !dbg !407
    #dbg_value(i64 %3, !376, !DIExpression(), !408)
  %edge_end = getelementptr inbounds %struct.node_t_struct, ptr %nodes, i64 %n.063.reg2mem34.0.load, i32 1, !dbg !409
  %4 = load i64, ptr %edge_end, align 8, !dbg !409
    #dbg_value(i64 %4, !382, !DIExpression(), !408)
    #dbg_label(!383, !410)
    #dbg_value(i64 %3, !368, !DIExpression(), !389)
    #dbg_value(i64 %cnt.062.reg2mem32.0.load, !370, !DIExpression(), !389)
  %cmp1559 = icmp ult i64 %3, %4, !dbg !411
  br i1 %cmp1559, label %if.then.for.body17_crit_edge, label %if.then.for.inc29_crit_edge, !dbg !412

if.then.for.inc29_crit_edge:                      ; preds = %if.then
  store i64 %cnt.062.reg2mem32.0.load, ptr %cnt.3.reg2mem24, align 8
  br label %for.inc29, !dbg !412

if.then.for.body17_crit_edge:                     ; preds = %if.then
  store i64 %cnt.062.reg2mem32.0.load, ptr %cnt.160.reg2mem28, align 8
  store i64 %3, ptr %e.061.reg2mem30, align 8
  br label %for.body17, !dbg !412

for.body17:                                       ; preds = %if.end.for.body17_crit_edge, %if.then.for.body17_crit_edge
    #dbg_value(i64 %e.061.reg2mem30.0.load, !368, !DIExpression(), !389)
    #dbg_value(i64 %cnt.160.reg2mem28.0.load, !370, !DIExpression(), !389)
  %e.061.reg2mem30.0.load = load i64, ptr %e.061.reg2mem30, align 8
  %cnt.160.reg2mem28.0.load = load i64, ptr %cnt.160.reg2mem28, align 8
  %arrayidx18 = getelementptr inbounds %struct.edge_t_struct, ptr %edges, i64 %e.061.reg2mem30.0.load, !dbg !413
  %5 = load i64, ptr %arrayidx18, align 8, !dbg !414, !tbaa !415
    #dbg_value(i64 %5, !384, !DIExpression(), !417)
  %arrayidx19 = getelementptr inbounds i8, ptr %level, i64 %5, !dbg !418
  %6 = load i8, ptr %arrayidx19, align 1, !dbg !418, !tbaa !392
    #dbg_value(i8 %6, !388, !DIExpression(), !417)
  %cmp21 = icmp eq i8 %6, 127, !dbg !419
  br i1 %cmp21, label %if.then23, label %for.body17.if.end_crit_edge, !dbg !421

for.body17.if.end_crit_edge:                      ; preds = %for.body17
  store i64 %cnt.160.reg2mem28.0.load, ptr %cnt.2.reg2mem26, align 8
  br label %if.end, !dbg !421

if.then23:                                        ; preds = %for.body17
  store i8 %0, ptr %arrayidx19, align 1, !dbg !422, !tbaa !392
  %inc = add i64 %cnt.160.reg2mem28.0.load, 1, !dbg !424
    #dbg_value(i64 %inc, !370, !DIExpression(), !389)
  store i64 %inc, ptr %cnt.2.reg2mem26, align 8
  br label %if.end, !dbg !425

if.end:                                           ; preds = %for.body17.if.end_crit_edge, %if.then23
    #dbg_value(i64 %cnt.2.reg2mem26.0.load, !370, !DIExpression(), !389)
  %cnt.2.reg2mem26.0.load = load i64, ptr %cnt.2.reg2mem26, align 8
  %inc27 = add nuw i64 %e.061.reg2mem30.0.load, 1, !dbg !426
    #dbg_value(i64 %inc27, !368, !DIExpression(), !389)
  %exitcond.not = icmp eq i64 %inc27, %4, !dbg !411
  br i1 %exitcond.not, label %if.end.for.inc29_crit_edge, label %if.end.for.body17_crit_edge, !dbg !412, !llvm.loop !427

if.end.for.body17_crit_edge:                      ; preds = %if.end
  store i64 %cnt.2.reg2mem26.0.load, ptr %cnt.160.reg2mem28, align 8
  store i64 %inc27, ptr %e.061.reg2mem30, align 8
  br label %for.body17, !dbg !412

if.end.for.inc29_crit_edge:                       ; preds = %if.end
  store i64 %cnt.2.reg2mem26.0.load, ptr %cnt.3.reg2mem24, align 8
  br label %for.inc29, !dbg !412

for.inc29:                                        ; preds = %if.end.for.inc29_crit_edge, %if.then.for.inc29_crit_edge, %for.body6.for.inc29_crit_edge
    #dbg_value(i64 %cnt.3.reg2mem24.0.load, !370, !DIExpression(), !389)
  %cnt.3.reg2mem24.0.load = load i64, ptr %cnt.3.reg2mem24, align 8
  %inc30 = add nuw nsw i64 %n.063.reg2mem34.0.load, 1, !dbg !431
    #dbg_value(i64 %inc30, !367, !DIExpression(), !389)
  %exitcond65.not = icmp eq i64 %inc30, 256, !dbg !432
  br i1 %exitcond65.not, label %for.end31, label %for.inc29.for.body6_crit_edge, !dbg !402, !llvm.loop !433

for.inc29.for.body6_crit_edge:                    ; preds = %for.inc29
  store i64 %cnt.3.reg2mem24.0.load, ptr %cnt.062.reg2mem32, align 8
  store i64 %inc30, ptr %n.063.reg2mem34, align 8
  br label %for.body6, !dbg !402

for.end31:                                        ; preds = %for.inc29
  %gep = getelementptr i64, ptr %invariant.gep, i64 %indvars.iv.reg2mem36.0.load, !dbg !435
  store i64 %cnt.3.reg2mem24.0.load, ptr %gep, align 8, !dbg !437, !tbaa !396
  %cmp35 = icmp eq i64 %cnt.3.reg2mem24.0.load, 0, !dbg !438
    #dbg_value(i64 %indvars.iv.next, !369, !DIExpression(), !389)
  %exitcond66.not = icmp eq i64 %indvars.iv.next, 10
  %or.cond = select i1 %cmp35, i1 true, i1 %exitcond66.not, !dbg !439
  br i1 %or.cond, label %for.end41, label %for.end31.for.cond3.preheader_crit_edge, !dbg !439, !llvm.loop !440

for.end31.for.cond3.preheader_crit_edge:          ; preds = %for.end31
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem36, align 8
  br label %for.cond3.preheader, !dbg !439

for.end41:                                        ; preds = %for.end31
  ret void, !dbg !442
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #0 !dbg !443 {
entry.split:
  %cnt.3.i.reg2mem26 = alloca i64, align 8
  %cnt.2.i.reg2mem28 = alloca i64, align 8
  %cnt.160.i.reg2mem30 = alloca i64, align 8
  %e.061.i.reg2mem32 = alloca i64, align 8
  %cnt.062.i.reg2mem34 = alloca i64, align 8
  %n.063.i.reg2mem36 = alloca i64, align 8
  %indvars.iv.i.reg2mem38 = alloca i64, align 8
    #dbg_value(ptr %vargs, !447, !DIExpression(), !449)
    #dbg_value(ptr %vargs, !448, !DIExpression(), !449)
  %edges = getelementptr inbounds i8, ptr %vargs, i64 4096, !dbg !450
  %starting_node = getelementptr inbounds i8, ptr %vargs, i64 36864, !dbg !451
  %0 = load i64, ptr %starting_node, align 8, !dbg !451, !tbaa !452
  %level = getelementptr inbounds i8, ptr %vargs, i64 36872, !dbg !454
  %level_counts = getelementptr inbounds i8, ptr %vargs, i64 37128, !dbg !455
    #dbg_value(ptr %vargs, !362, !DIExpression(), !456)
    #dbg_value(ptr %edges, !363, !DIExpression(), !456)
    #dbg_value(i64 %0, !364, !DIExpression(), !456)
    #dbg_value(ptr %level, !365, !DIExpression(), !456)
    #dbg_value(ptr %level_counts, !366, !DIExpression(), !456)
  %arrayidx.i = getelementptr inbounds i8, ptr %level, i64 %0, !dbg !458
  store i8 0, ptr %arrayidx.i, align 1, !dbg !459, !tbaa !392
  store i64 1, ptr %level_counts, align 8, !dbg !460, !tbaa !396
    #dbg_label(!371, !461)
    #dbg_value(i8 0, !369, !DIExpression(), !456)
  %invariant.gep.i = getelementptr i8, ptr %vargs, i64 37136, !dbg !462
  store i64 0, ptr %indvars.iv.i.reg2mem38, align 8
  br label %for.cond3.preheader.i, !dbg !463

for.cond3.preheader.i:                            ; preds = %for.end31.i.for.cond3.preheader.i_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv.i.reg2mem38.0.load, !369, !DIExpression(), !456)
    #dbg_value(i64 0, !367, !DIExpression(), !456)
    #dbg_value(i64 0, !370, !DIExpression(), !456)
  %indvars.iv.i.reg2mem38.0.load = load i64, ptr %indvars.iv.i.reg2mem38, align 8
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem38.0.load, 1, !dbg !464
  %1 = trunc i64 %indvars.iv.next.i to i8
  store i64 0, ptr %cnt.062.i.reg2mem34, align 8
  store i64 0, ptr %n.063.i.reg2mem36, align 8
  br label %for.body6.i, !dbg !465

for.body6.i:                                      ; preds = %for.inc29.i.for.body6.i_crit_edge, %for.cond3.preheader.i
    #dbg_value(i64 %n.063.i.reg2mem36.0.load, !367, !DIExpression(), !456)
    #dbg_value(i64 %cnt.062.i.reg2mem34.0.load, !370, !DIExpression(), !456)
  %n.063.i.reg2mem36.0.load = load i64, ptr %n.063.i.reg2mem36, align 8
  %cnt.062.i.reg2mem34.0.load = load i64, ptr %cnt.062.i.reg2mem34, align 8
  %arrayidx7.i = getelementptr inbounds i8, ptr %level, i64 %n.063.i.reg2mem36.0.load, !dbg !466
  %2 = load i8, ptr %arrayidx7.i, align 1, !dbg !466, !tbaa !392
  %3 = zext i8 %2 to i64, !dbg !467
  %cmp10.i = icmp eq i64 %indvars.iv.i.reg2mem38.0.load, %3, !dbg !467
  br i1 %cmp10.i, label %if.then.i, label %for.body6.i.for.inc29.i_crit_edge, !dbg !468

for.body6.i.for.inc29.i_crit_edge:                ; preds = %for.body6.i
  store i64 %cnt.062.i.reg2mem34.0.load, ptr %cnt.3.i.reg2mem26, align 8
  br label %for.inc29.i, !dbg !468

if.then.i:                                        ; preds = %for.body6.i
  %arrayidx12.i = getelementptr inbounds %struct.node_t_struct, ptr %vargs, i64 %n.063.i.reg2mem36.0.load, !dbg !469
  %4 = load i64, ptr %arrayidx12.i, align 8, !dbg !470
    #dbg_value(i64 %4, !376, !DIExpression(), !471)
  %edge_end.i = getelementptr inbounds %struct.node_t_struct, ptr %vargs, i64 %n.063.i.reg2mem36.0.load, i32 1, !dbg !472
  %5 = load i64, ptr %edge_end.i, align 8, !dbg !472
    #dbg_value(i64 %5, !382, !DIExpression(), !471)
    #dbg_label(!383, !473)
    #dbg_value(i64 %4, !368, !DIExpression(), !456)
    #dbg_value(i64 %cnt.062.i.reg2mem34.0.load, !370, !DIExpression(), !456)
  %cmp1559.i = icmp ult i64 %4, %5, !dbg !474
  br i1 %cmp1559.i, label %if.then.i.for.body17.i_crit_edge, label %if.then.i.for.inc29.i_crit_edge, !dbg !475

if.then.i.for.inc29.i_crit_edge:                  ; preds = %if.then.i
  store i64 %cnt.062.i.reg2mem34.0.load, ptr %cnt.3.i.reg2mem26, align 8
  br label %for.inc29.i, !dbg !475

if.then.i.for.body17.i_crit_edge:                 ; preds = %if.then.i
  store i64 %cnt.062.i.reg2mem34.0.load, ptr %cnt.160.i.reg2mem30, align 8
  store i64 %4, ptr %e.061.i.reg2mem32, align 8
  br label %for.body17.i, !dbg !475

for.body17.i:                                     ; preds = %if.end.i.for.body17.i_crit_edge, %if.then.i.for.body17.i_crit_edge
    #dbg_value(i64 %e.061.i.reg2mem32.0.load, !368, !DIExpression(), !456)
    #dbg_value(i64 %cnt.160.i.reg2mem30.0.load, !370, !DIExpression(), !456)
  %e.061.i.reg2mem32.0.load = load i64, ptr %e.061.i.reg2mem32, align 8
  %cnt.160.i.reg2mem30.0.load = load i64, ptr %cnt.160.i.reg2mem30, align 8
  %arrayidx18.i = getelementptr inbounds %struct.edge_t_struct, ptr %edges, i64 %e.061.i.reg2mem32.0.load, !dbg !476
  %6 = load i64, ptr %arrayidx18.i, align 8, !dbg !477, !tbaa !415
    #dbg_value(i64 %6, !384, !DIExpression(), !478)
  %arrayidx19.i = getelementptr inbounds i8, ptr %level, i64 %6, !dbg !479
  %7 = load i8, ptr %arrayidx19.i, align 1, !dbg !479, !tbaa !392
    #dbg_value(i8 %7, !388, !DIExpression(), !478)
  %cmp21.i = icmp eq i8 %7, 127, !dbg !480
  br i1 %cmp21.i, label %if.then23.i, label %for.body17.i.if.end.i_crit_edge, !dbg !481

for.body17.i.if.end.i_crit_edge:                  ; preds = %for.body17.i
  store i64 %cnt.160.i.reg2mem30.0.load, ptr %cnt.2.i.reg2mem28, align 8
  br label %if.end.i, !dbg !481

if.then23.i:                                      ; preds = %for.body17.i
  store i8 %1, ptr %arrayidx19.i, align 1, !dbg !482, !tbaa !392
  %inc.i = add i64 %cnt.160.i.reg2mem30.0.load, 1, !dbg !483
    #dbg_value(i64 %inc.i, !370, !DIExpression(), !456)
  store i64 %inc.i, ptr %cnt.2.i.reg2mem28, align 8
  br label %if.end.i, !dbg !484

if.end.i:                                         ; preds = %for.body17.i.if.end.i_crit_edge, %if.then23.i
    #dbg_value(i64 %cnt.2.i.reg2mem28.0.load, !370, !DIExpression(), !456)
  %cnt.2.i.reg2mem28.0.load = load i64, ptr %cnt.2.i.reg2mem28, align 8
  %inc27.i = add nuw i64 %e.061.i.reg2mem32.0.load, 1, !dbg !485
    #dbg_value(i64 %inc27.i, !368, !DIExpression(), !456)
  %exitcond.not.i = icmp eq i64 %inc27.i, %5, !dbg !474
  br i1 %exitcond.not.i, label %if.end.i.for.inc29.i_crit_edge, label %if.end.i.for.body17.i_crit_edge, !dbg !475, !llvm.loop !486

if.end.i.for.body17.i_crit_edge:                  ; preds = %if.end.i
  store i64 %cnt.2.i.reg2mem28.0.load, ptr %cnt.160.i.reg2mem30, align 8
  store i64 %inc27.i, ptr %e.061.i.reg2mem32, align 8
  br label %for.body17.i, !dbg !475

if.end.i.for.inc29.i_crit_edge:                   ; preds = %if.end.i
  store i64 %cnt.2.i.reg2mem28.0.load, ptr %cnt.3.i.reg2mem26, align 8
  br label %for.inc29.i, !dbg !475

for.inc29.i:                                      ; preds = %if.end.i.for.inc29.i_crit_edge, %if.then.i.for.inc29.i_crit_edge, %for.body6.i.for.inc29.i_crit_edge
    #dbg_value(i64 %cnt.3.i.reg2mem26.0.load, !370, !DIExpression(), !456)
  %cnt.3.i.reg2mem26.0.load = load i64, ptr %cnt.3.i.reg2mem26, align 8
  %inc30.i = add nuw nsw i64 %n.063.i.reg2mem36.0.load, 1, !dbg !488
    #dbg_value(i64 %inc30.i, !367, !DIExpression(), !456)
  %exitcond65.not.i = icmp eq i64 %inc30.i, 256, !dbg !489
  br i1 %exitcond65.not.i, label %for.end31.i, label %for.inc29.i.for.body6.i_crit_edge, !dbg !465, !llvm.loop !490

for.inc29.i.for.body6.i_crit_edge:                ; preds = %for.inc29.i
  store i64 %cnt.3.i.reg2mem26.0.load, ptr %cnt.062.i.reg2mem34, align 8
  store i64 %inc30.i, ptr %n.063.i.reg2mem36, align 8
  br label %for.body6.i, !dbg !465

for.end31.i:                                      ; preds = %for.inc29.i
  %gep.i = getelementptr i64, ptr %invariant.gep.i, i64 %indvars.iv.i.reg2mem38.0.load, !dbg !492
  store i64 %cnt.3.i.reg2mem26.0.load, ptr %gep.i, align 8, !dbg !493, !tbaa !396
  %cmp35.i = icmp eq i64 %cnt.3.i.reg2mem26.0.load, 0, !dbg !494
    #dbg_value(i64 %indvars.iv.next.i, !369, !DIExpression(), !456)
  %exitcond66.not.i = icmp eq i64 %indvars.iv.next.i, 10
  %or.cond.i = select i1 %cmp35.i, i1 true, i1 %exitcond66.not.i, !dbg !495
  br i1 %or.cond.i, label %bfs.exit, label %for.end31.i.for.cond3.preheader.i_crit_edge, !dbg !495, !llvm.loop !496

for.end31.i.for.cond3.preheader.i_crit_edge:      ; preds = %for.end31.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem38, align 8
  br label %for.cond3.preheader.i, !dbg !495

bfs.exit:                                         ; preds = %for.end31.i
  ret void, !dbg !498
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !499 {
entry.split:
  %s.addr.0.lcssa.ph.i35.reg2mem = alloca ptr, align 8
  %cmp23.not.i34.reg2mem = alloca i64, align 8
  %i.1.i29.reg2mem108 = alloca i32, align 4
  %s.addr.040.i24.reg2mem110 = alloca ptr, align 8
  %i.041.i23.reg2mem112 = alloca i32, align 4
  %i.143.reg2mem = alloca i64, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem = alloca ptr, align 8
  %cmp23.not.i13.reg2mem = alloca i64, align 8
  %i.1.i8.reg2mem114 = alloca i32, align 4
  %s.addr.040.i3.reg2mem116 = alloca ptr, align 8
  %i.041.i2.reg2mem118 = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem120 = alloca i32, align 4
  %s.addr.040.i.reg2mem122 = alloca ptr, align 8
  %i.041.i.reg2mem124 = alloca i32, align 4
    #dbg_value(i32 %fd, !503, !DIExpression(), !510)
    #dbg_value(ptr %vdata, !504, !DIExpression(), !510)
    #dbg_value(ptr %vdata, !505, !DIExpression(), !510)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(37208) %vdata, i8 0, i64 37208, i1 false), !dbg !511
    #dbg_value(i64 0, !509, !DIExpression(), !510)
  %scevgep = getelementptr i8, ptr %vdata, i64 36872, !dbg !512
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(256) %scevgep, i8 127, i64 256, i1 false), !dbg !514, !tbaa !392
    #dbg_value(i64 poison, !509, !DIExpression(), !510)
  %call = tail call ptr @readfile(i32 noundef signext %fd) #17, !dbg !517
    #dbg_value(ptr %call, !506, !DIExpression(), !510)
    #dbg_value(ptr %call, !518, !DIExpression(), !525)
    #dbg_value(i32 1, !523, !DIExpression(), !525)
    #dbg_value(i32 0, !524, !DIExpression(), !525)
  store ptr %call, ptr %s.addr.040.i.reg2mem122, align 8
  store i32 0, ptr %i.041.i.reg2mem124, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem124.0.load, !524, !DIExpression(), !525)
    #dbg_value(ptr %s.addr.040.i.reg2mem122.0.s.addr.040.i.reload123, !518, !DIExpression(), !525)
  %i.041.i.reg2mem124.0.load = load i32, ptr %i.041.i.reg2mem124, align 4
  %s.addr.040.i.reg2mem122.0.s.addr.040.i.reload123 = load ptr, ptr %s.addr.040.i.reg2mem122, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem122.0.s.addr.040.i.reload123, align 1, !dbg !527, !tbaa !392
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !528

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem122.0.s.addr.040.i.reload123, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !528

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem124.0.load, ptr %i.1.i.reg2mem120, align 4
  br label %if.end21.i, !dbg !528

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem122.0.s.addr.040.i.reload123, i64 1, !dbg !529
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !529, !tbaa !392
  %cmp13.i = icmp eq i8 %1, 37, !dbg !532
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !533

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem124.0.load, ptr %i.1.i.reg2mem120, align 4
  br label %if.end21.i, !dbg !533

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem122.0.s.addr.040.i.reload123, i64 2, !dbg !534
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !534, !tbaa !392
  %cmp18.i = icmp eq i8 %2, 10, !dbg !535
  %inc.i = zext i1 %cmp18.i to i32, !dbg !536
  %spec.select.i = add nsw i32 %i.041.i.reg2mem124.0.load, %inc.i, !dbg !536
  store i32 %spec.select.i, ptr %i.1.i.reg2mem120, align 4
  br label %if.end21.i, !dbg !536

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem120.0.load, !524, !DIExpression(), !525)
  %i.1.i.reg2mem120.0.load = load i32, ptr %i.1.i.reg2mem120, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem122.0.s.addr.040.i.reload123, i64 1, !dbg !537
    #dbg_value(ptr %incdec.ptr.i, !518, !DIExpression(), !525)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem120.0.load, 1, !dbg !538
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !539, !llvm.loop !540

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem122, align 8
  store i32 %i.1.i.reg2mem120.0.load, ptr %i.041.i.reg2mem124, align 4
  br label %land.rhs.i, !dbg !539

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !542, !tbaa !392
  %3 = icmp eq i8 %.pre.i, 0, !dbg !544
  %4 = select i1 %3, i64 0, i64 2, !dbg !545
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !539

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !545
    #dbg_value(ptr %spec.select38.i, !507, !DIExpression(), !510)
  %starting_node = getelementptr inbounds i8, ptr %vdata, i64 36864, !dbg !546
  %call2 = tail call signext i32 @parse_uint64_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %starting_node, i32 noundef signext 1) #17, !dbg !547
    #dbg_value(ptr %call, !518, !DIExpression(), !548)
    #dbg_value(i32 2, !523, !DIExpression(), !548)
    #dbg_value(i32 0, !524, !DIExpression(), !548)
  store ptr %call, ptr %s.addr.040.i3.reg2mem116, align 8
  store i32 0, ptr %i.041.i2.reg2mem118, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem118.0.load, !524, !DIExpression(), !548)
    #dbg_value(ptr %s.addr.040.i3.reg2mem116.0.s.addr.040.i3.reload117, !518, !DIExpression(), !548)
  %i.041.i2.reg2mem118.0.load = load i32, ptr %i.041.i2.reg2mem118, align 4
  %s.addr.040.i3.reg2mem116.0.s.addr.040.i3.reload117 = load ptr, ptr %s.addr.040.i3.reg2mem116, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem116.0.s.addr.040.i3.reload117, align 1, !dbg !550, !tbaa !392
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !551

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem116.0.s.addr.040.i3.reload117, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !551

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem118.0.load, ptr %i.1.i8.reg2mem114, align 4
  br label %if.end21.i7, !dbg !551

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem116.0.s.addr.040.i3.reload117, i64 1, !dbg !552
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !552, !tbaa !392
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !553
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !554

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem118.0.load, ptr %i.1.i8.reg2mem114, align 4
  br label %if.end21.i7, !dbg !554

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem116.0.s.addr.040.i3.reload117, i64 2, !dbg !555
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !555, !tbaa !392
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !556
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !557
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem118.0.load, %inc.i19, !dbg !557
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem114, align 4
  br label %if.end21.i7, !dbg !557

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem114.0.load, !524, !DIExpression(), !548)
  %i.1.i8.reg2mem114.0.load = load i32, ptr %i.1.i8.reg2mem114, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem116.0.s.addr.040.i3.reload117, i64 1, !dbg !558
    #dbg_value(ptr %incdec.ptr.i9, !518, !DIExpression(), !548)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem114.0.load, 2, !dbg !559
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !560, !llvm.loop !561

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem116, align 8
  store i32 %i.1.i8.reg2mem114.0.load, ptr %i.041.i2.reg2mem118, align 4
  br label %land.rhs.i1, !dbg !560

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !563, !tbaa !392
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !564
  %9 = select i1 %8, i64 0, i64 2, !dbg !565
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !560

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !565
    #dbg_value(ptr %spec.select38.i15, !507, !DIExpression(), !510)
  %call4 = tail call noalias dereferenceable_or_null(4096) ptr @malloc(i64 noundef 4096) #18, !dbg !566
    #dbg_value(ptr %call4, !508, !DIExpression(), !510)
  %call5 = tail call signext i32 @parse_uint64_t_array(ptr noundef nonnull %spec.select38.i15, ptr noundef %call4, i32 noundef signext 512) #17, !dbg !567
    #dbg_value(i64 0, !509, !DIExpression(), !510)
  store i64 0, ptr %i.143.reg2mem, align 8
  br label %for.body8, !dbg !568

for.body8:                                        ; preds = %for.body8.for.body8_crit_edge, %find_section_start.exit21
    #dbg_value(i64 %i.143.reg2mem.0.load, !509, !DIExpression(), !510)
  %i.143.reg2mem.0.load = load i64, ptr %i.143.reg2mem, align 8
  %mul = shl nuw nsw i64 %i.143.reg2mem.0.load, 1, !dbg !570
  %arrayidx9 = getelementptr inbounds i64, ptr %call4, i64 %mul, !dbg !573
  %10 = load i64, ptr %arrayidx9, align 8, !dbg !573, !tbaa !396
  %arrayidx11 = getelementptr inbounds [256 x %struct.node_t_struct], ptr %vdata, i64 0, i64 %i.143.reg2mem.0.load, !dbg !574
  store i64 %10, ptr %arrayidx11, align 8, !dbg !575, !tbaa !576
  %add = or disjoint i64 %mul, 1, !dbg !578
  %arrayidx13 = getelementptr inbounds i64, ptr %call4, i64 %add, !dbg !579
  %11 = load i64, ptr %arrayidx13, align 8, !dbg !579, !tbaa !396
  %edge_end = getelementptr inbounds [256 x %struct.node_t_struct], ptr %vdata, i64 0, i64 %i.143.reg2mem.0.load, i32 1, !dbg !580
  store i64 %11, ptr %edge_end, align 8, !dbg !581, !tbaa !582
  %inc17 = add nuw nsw i64 %i.143.reg2mem.0.load, 1, !dbg !583
    #dbg_value(i64 %inc17, !509, !DIExpression(), !510)
  %exitcond.not = icmp eq i64 %inc17, 256, !dbg !584
  br i1 %exitcond.not, label %for.end18, label %for.body8.for.body8_crit_edge, !dbg !568, !llvm.loop !585

for.body8.for.body8_crit_edge:                    ; preds = %for.body8
  store i64 %inc17, ptr %i.143.reg2mem, align 8
  br label %for.body8, !dbg !568

for.end18:                                        ; preds = %for.body8
  tail call void @free(ptr noundef nonnull %call4) #17, !dbg !587
    #dbg_value(ptr %call, !518, !DIExpression(), !588)
    #dbg_value(i32 3, !523, !DIExpression(), !588)
    #dbg_value(i32 0, !524, !DIExpression(), !588)
  store ptr %call, ptr %s.addr.040.i24.reg2mem110, align 8
  store i32 0, ptr %i.041.i23.reg2mem112, align 4
  br label %land.rhs.i22

land.rhs.i22:                                     ; preds = %if.end21.i28.land.rhs.i22_crit_edge, %for.end18
    #dbg_value(i32 %i.041.i23.reg2mem112.0.load, !524, !DIExpression(), !588)
    #dbg_value(ptr %s.addr.040.i24.reg2mem110.0.s.addr.040.i24.reload111, !518, !DIExpression(), !588)
  %i.041.i23.reg2mem112.0.load = load i32, ptr %i.041.i23.reg2mem112, align 4
  %s.addr.040.i24.reg2mem110.0.s.addr.040.i24.reload111 = load ptr, ptr %s.addr.040.i24.reg2mem110, align 8
  %12 = load i8, ptr %s.addr.040.i24.reg2mem110.0.s.addr.040.i24.reload111, align 1, !dbg !590, !tbaa !392
  switch i8 %12, label %land.rhs.i22.if.end21.i28_crit_edge [
    i8 0, label %land.rhs.i22.find_section_start.exit42_crit_edge
    i8 37, label %land.lhs.true10.i25
  ], !dbg !591

land.rhs.i22.find_section_start.exit42_crit_edge: ; preds = %land.rhs.i22
  store ptr %s.addr.040.i24.reg2mem110.0.s.addr.040.i24.reload111, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !591

land.rhs.i22.if.end21.i28_crit_edge:              ; preds = %land.rhs.i22
  store i32 %i.041.i23.reg2mem112.0.load, ptr %i.1.i29.reg2mem108, align 4
  br label %if.end21.i28, !dbg !591

land.lhs.true10.i25:                              ; preds = %land.rhs.i22
  %arrayidx11.i26 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem110.0.s.addr.040.i24.reload111, i64 1, !dbg !592
  %13 = load i8, ptr %arrayidx11.i26, align 1, !dbg !592, !tbaa !392
  %cmp13.i27 = icmp eq i8 %13, 37, !dbg !593
  br i1 %cmp13.i27, label %land.lhs.true15.i37, label %land.lhs.true10.i25.if.end21.i28_crit_edge, !dbg !594

land.lhs.true10.i25.if.end21.i28_crit_edge:       ; preds = %land.lhs.true10.i25
  store i32 %i.041.i23.reg2mem112.0.load, ptr %i.1.i29.reg2mem108, align 4
  br label %if.end21.i28, !dbg !594

land.lhs.true15.i37:                              ; preds = %land.lhs.true10.i25
  %arrayidx16.i38 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem110.0.s.addr.040.i24.reload111, i64 2, !dbg !595
  %14 = load i8, ptr %arrayidx16.i38, align 1, !dbg !595, !tbaa !392
  %cmp18.i39 = icmp eq i8 %14, 10, !dbg !596
  %inc.i40 = zext i1 %cmp18.i39 to i32, !dbg !597
  %spec.select.i41 = add nsw i32 %i.041.i23.reg2mem112.0.load, %inc.i40, !dbg !597
  store i32 %spec.select.i41, ptr %i.1.i29.reg2mem108, align 4
  br label %if.end21.i28, !dbg !597

if.end21.i28:                                     ; preds = %land.lhs.true10.i25.if.end21.i28_crit_edge, %land.rhs.i22.if.end21.i28_crit_edge, %land.lhs.true15.i37
    #dbg_value(i32 %i.1.i29.reg2mem108.0.load, !524, !DIExpression(), !588)
  %i.1.i29.reg2mem108.0.load = load i32, ptr %i.1.i29.reg2mem108, align 4
  %incdec.ptr.i30 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem110.0.s.addr.040.i24.reload111, i64 1, !dbg !598
    #dbg_value(ptr %incdec.ptr.i30, !518, !DIExpression(), !588)
  %cmp4.i31 = icmp slt i32 %i.1.i29.reg2mem108.0.load, 3, !dbg !599
  br i1 %cmp4.i31, label %if.end21.i28.land.rhs.i22_crit_edge, label %if.end21.while.end_crit_edge.i32, !dbg !600, !llvm.loop !601

if.end21.i28.land.rhs.i22_crit_edge:              ; preds = %if.end21.i28
  store ptr %incdec.ptr.i30, ptr %s.addr.040.i24.reg2mem110, align 8
  store i32 %i.1.i29.reg2mem108.0.load, ptr %i.041.i23.reg2mem112, align 4
  br label %land.rhs.i22, !dbg !600

if.end21.while.end_crit_edge.i32:                 ; preds = %if.end21.i28
  %.pre.i33 = load i8, ptr %incdec.ptr.i30, align 1, !dbg !603, !tbaa !392
  %15 = icmp eq i8 %.pre.i33, 0, !dbg !604
  %16 = select i1 %15, i64 0, i64 2, !dbg !605
  store ptr %incdec.ptr.i30, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 %16, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !600

find_section_start.exit42:                        ; preds = %land.rhs.i22.find_section_start.exit42_crit_edge, %if.end21.while.end_crit_edge.i32
  %cmp23.not.i34.reg2mem.0.load = load i64, ptr %cmp23.not.i34.reg2mem, align 8
  %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload = load ptr, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  %spec.select38.i36 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload, i64 %cmp23.not.i34.reg2mem.0.load, !dbg !605
    #dbg_value(ptr %spec.select38.i36, !507, !DIExpression(), !510)
  %edges = getelementptr inbounds i8, ptr %vdata, i64 4096, !dbg !606
  %call20 = tail call signext i32 @parse_uint64_t_array(ptr noundef nonnull %spec.select38.i36, ptr noundef nonnull %edges, i32 noundef signext 4096) #17, !dbg !607
  tail call void @free(ptr noundef %call) #17, !dbg !608
  ret void, !dbg !609
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !610 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #3

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !616 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #4

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !617 {
entry.split:
  %indvars.iv.i22.reg2mem = alloca i64, align 8
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %i.029.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !619, !DIExpression(), !624)
    #dbg_value(ptr %vdata, !620, !DIExpression(), !624)
    #dbg_value(ptr %vdata, !623, !DIExpression(), !624)
    #dbg_value(i32 %fd, !625, !DIExpression(), !630)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !632
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !632

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !632
  unreachable, !dbg !632

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !635
  %starting_node = getelementptr inbounds i8, ptr %vdata, i64 36864, !dbg !636
    #dbg_value(i32 %fd, !637, !DIExpression(), !645)
    #dbg_value(ptr %starting_node, !642, !DIExpression(), !645)
    #dbg_value(i32 1, !643, !DIExpression(), !645)
    #dbg_value(i64 0, !644, !DIExpression(), !645)
  %0 = load i64, ptr %starting_node, align 8, !dbg !647, !tbaa !396
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !647
    #dbg_value(i64 1, !644, !DIExpression(), !645)
    #dbg_value(i32 %fd, !625, !DIExpression(), !651)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !653
  %call3 = tail call noalias dereferenceable_or_null(4096) ptr @malloc(i64 noundef 4096) #18, !dbg !654
    #dbg_value(ptr %call3, !621, !DIExpression(), !624)
    #dbg_value(i64 0, !622, !DIExpression(), !624)
  store i64 0, ptr %i.029.reg2mem, align 8
  br label %for.body, !dbg !655

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %i.029.reg2mem.0.load, !622, !DIExpression(), !624)
  %i.029.reg2mem.0.load = load i64, ptr %i.029.reg2mem, align 8
  %arrayidx = getelementptr inbounds [256 x %struct.node_t_struct], ptr %vdata, i64 0, i64 %i.029.reg2mem.0.load, !dbg !657
  %1 = load i64, ptr %arrayidx, align 8, !dbg !660, !tbaa !576
  %mul = shl nuw nsw i64 %i.029.reg2mem.0.load, 1, !dbg !661
  %arrayidx5 = getelementptr inbounds i64, ptr %call3, i64 %mul, !dbg !662
  store i64 %1, ptr %arrayidx5, align 8, !dbg !663, !tbaa !396
  %edge_end = getelementptr inbounds [256 x %struct.node_t_struct], ptr %vdata, i64 0, i64 %i.029.reg2mem.0.load, i32 1, !dbg !664
  %2 = load i64, ptr %edge_end, align 8, !dbg !664, !tbaa !582
  %add = or disjoint i64 %mul, 1, !dbg !665
  %arrayidx9 = getelementptr inbounds i64, ptr %call3, i64 %add, !dbg !666
  store i64 %2, ptr %arrayidx9, align 8, !dbg !667, !tbaa !396
  %inc = add nuw nsw i64 %i.029.reg2mem.0.load, 1, !dbg !668
    #dbg_value(i64 %inc, !622, !DIExpression(), !624)
  %exitcond.not = icmp eq i64 %inc, 256, !dbg !669
  br i1 %exitcond.not, label %for.body.for.body.i9_crit_edge, label %for.body.for.body_crit_edge, !dbg !655, !llvm.loop !670

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %inc, ptr %i.029.reg2mem, align 8
  br label %for.body, !dbg !655

for.body.for.body.i9_crit_edge:                   ; preds = %for.body
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !655

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.body.for.body.i9_crit_edge
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !644, !DIExpression(), !672)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds i64, ptr %call3, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !674
  %3 = load i64, ptr %arrayidx.i11, align 8, !dbg !674, !tbaa !396
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %3), !dbg !674
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !675
    #dbg_value(i64 %indvars.iv.next.i12, !644, !DIExpression(), !672)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 512, !dbg !675
  br i1 %exitcond.not.i13, label %for.cond.preheader.i20, label %for.body.i9.for.body.i9_crit_edge, !dbg !676, !llvm.loop !677

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !676

for.cond.preheader.i20:                           ; preds = %for.body.i9
  tail call void @free(ptr noundef nonnull %call3) #17, !dbg !678
    #dbg_value(i32 %fd, !625, !DIExpression(), !679)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !681
  %edges = getelementptr inbounds i8, ptr %vdata, i64 4096, !dbg !682
    #dbg_value(i32 %fd, !637, !DIExpression(), !683)
    #dbg_value(ptr %edges, !642, !DIExpression(), !683)
    #dbg_value(i32 4096, !643, !DIExpression(), !683)
    #dbg_value(i32 0, !644, !DIExpression(), !683)
  store i64 0, ptr %indvars.iv.i22.reg2mem, align 8
  br label %for.body.i21, !dbg !685

for.body.i21:                                     ; preds = %for.body.i21.for.body.i21_crit_edge, %for.cond.preheader.i20
    #dbg_value(i64 %indvars.iv.i22.reg2mem.0.load, !644, !DIExpression(), !683)
  %indvars.iv.i22.reg2mem.0.load = load i64, ptr %indvars.iv.i22.reg2mem, align 8
  %arrayidx.i23 = getelementptr inbounds i64, ptr %edges, i64 %indvars.iv.i22.reg2mem.0.load, !dbg !686
  %4 = load i64, ptr %arrayidx.i23, align 8, !dbg !686, !tbaa !396
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %4), !dbg !686
  %indvars.iv.next.i24 = add nuw nsw i64 %indvars.iv.i22.reg2mem.0.load, 1, !dbg !687
    #dbg_value(i64 %indvars.iv.next.i24, !644, !DIExpression(), !683)
  %exitcond.not.i25 = icmp eq i64 %indvars.iv.next.i24, 4096, !dbg !687
  br i1 %exitcond.not.i25, label %write_uint64_t_array.exit26, label %for.body.i21.for.body.i21_crit_edge, !dbg !685, !llvm.loop !688

for.body.i21.for.body.i21_crit_edge:              ; preds = %for.body.i21
  store i64 %indvars.iv.next.i24, ptr %indvars.iv.i22.reg2mem, align 8
  br label %for.body.i21, !dbg !685

write_uint64_t_array.exit26:                      ; preds = %for.body.i21
  ret void, !dbg !689
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #1 !dbg !690 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !692, !DIExpression(), !697)
    #dbg_value(ptr %vdata, !693, !DIExpression(), !697)
    #dbg_value(ptr %vdata, !694, !DIExpression(), !697)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(37208) %vdata, i8 0, i64 37208, i1 false), !dbg !698
  %call = tail call ptr @readfile(i32 noundef signext %fd) #17, !dbg !699
    #dbg_value(ptr %call, !695, !DIExpression(), !697)
    #dbg_value(ptr %call, !518, !DIExpression(), !700)
    #dbg_value(i32 1, !523, !DIExpression(), !700)
    #dbg_value(i32 0, !524, !DIExpression(), !700)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !524, !DIExpression(), !700)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !518, !DIExpression(), !700)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !702, !tbaa !392
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !703

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !703

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !703

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !704
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !704, !tbaa !392
  %cmp13.i = icmp eq i8 %1, 37, !dbg !705
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !706

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !706

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !707
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !707, !tbaa !392
  %cmp18.i = icmp eq i8 %2, 10, !dbg !708
  %inc.i = zext i1 %cmp18.i to i32, !dbg !709
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !709
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !709

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !524, !DIExpression(), !700)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !710
    #dbg_value(ptr %incdec.ptr.i, !518, !DIExpression(), !700)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !711
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !712, !llvm.loop !713

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !712

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !715, !tbaa !392
  %3 = icmp eq i8 %.pre.i, 0, !dbg !716
  %4 = select i1 %3, i64 0, i64 2, !dbg !717
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !712

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !717
    #dbg_value(ptr %spec.select38.i, !696, !DIExpression(), !697)
  %level_counts = getelementptr inbounds i8, ptr %vdata, i64 37128, !dbg !718
  %call2 = tail call signext i32 @parse_uint64_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %level_counts, i32 noundef signext 10) #17, !dbg !719
  tail call void @free(ptr noundef %call) #17, !dbg !720
  ret void, !dbg !721
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #1 !dbg !722 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !724, !DIExpression(), !727)
    #dbg_value(ptr %vdata, !725, !DIExpression(), !727)
    #dbg_value(ptr %vdata, !726, !DIExpression(), !727)
    #dbg_value(i32 %fd, !625, !DIExpression(), !728)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !730
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !730

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !730
  unreachable, !dbg !730

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !731
  %level_counts = getelementptr inbounds i8, ptr %vdata, i64 37128, !dbg !732
    #dbg_value(i32 %fd, !637, !DIExpression(), !733)
    #dbg_value(ptr %level_counts, !642, !DIExpression(), !733)
    #dbg_value(i32 10, !643, !DIExpression(), !733)
    #dbg_value(i32 0, !644, !DIExpression(), !733)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !735

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !644, !DIExpression(), !733)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i64, ptr %level_counts, i64 %indvars.iv.i.reg2mem.0.load, !dbg !736
  %0 = load i64, ptr %arrayidx.i, align 8, !dbg !736, !tbaa !396
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !736
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !737
    #dbg_value(i64 %indvars.iv.next.i, !644, !DIExpression(), !733)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 10, !dbg !737
  br i1 %exitcond.not.i, label %write_uint64_t_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !735, !llvm.loop !738

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !735

write_uint64_t_array.exit:                        ; preds = %for.body.i
  ret void, !dbg !739
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #5 !dbg !740 {
entry.split:
  %has_errors.09.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(ptr %vdata, !744, !DIExpression(), !750)
    #dbg_value(ptr %vref, !745, !DIExpression(), !750)
    #dbg_value(ptr %vdata, !746, !DIExpression(), !750)
    #dbg_value(ptr %vref, !747, !DIExpression(), !750)
    #dbg_value(i32 0, !748, !DIExpression(), !750)
    #dbg_value(i32 0, !749, !DIExpression(), !750)
  store i32 0, ptr %has_errors.09.reg2mem, align 4
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !751

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !749, !DIExpression(), !750)
    #dbg_value(i32 %has_errors.09.reg2mem.0.load, !748, !DIExpression(), !750)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %has_errors.09.reg2mem.0.load = load i32, ptr %has_errors.09.reg2mem, align 4
  %arrayidx = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 4, i64 %indvars.iv.reg2mem.0.load, !dbg !753
  %0 = load i64, ptr %arrayidx, align 8, !dbg !753, !tbaa !396
  %arrayidx3 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 4, i64 %indvars.iv.reg2mem.0.load, !dbg !756
  %1 = load i64, ptr %arrayidx3, align 8, !dbg !756, !tbaa !396
  %cmp4 = icmp ne i64 %0, %1, !dbg !757
  %conv = zext i1 %cmp4 to i32, !dbg !757
  %or = or i32 %has_errors.09.reg2mem.0.load, %conv, !dbg !758
    #dbg_value(i32 %or, !748, !DIExpression(), !750)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !759
    #dbg_value(i64 %indvars.iv.next, !749, !DIExpression(), !750)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 10, !dbg !760
  br i1 %exitcond.not, label %for.end, label %for.body.for.body_crit_edge, !dbg !751, !llvm.loop !761

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i32 %or, ptr %has_errors.09.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !751

for.end:                                          ; preds = %for.body
  %tobool.not = icmp eq i32 %or, 0, !dbg !763
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !763
  ret i32 %lnot.ext, !dbg !764
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !765 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !815
    #dbg_assign(i1 undef, !771, !DIExpression(), !815, ptr %s, !DIExpression(), !816)
    #dbg_value(i32 %fd, !769, !DIExpression(), !816)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #17, !dbg !817
  %cmp = icmp sgt i32 %fd, 1, !dbg !818
  br i1 %cmp, label %if.end, label %if.else, !dbg !818

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !818
  unreachable, !dbg !818

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #17, !dbg !821
  %cmp1 = icmp eq i32 %call, 0, !dbg !821
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !821

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !821
  unreachable, !dbg !821

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !824
  %0 = load i64, ptr %st_size, align 8, !dbg !824
    #dbg_value(i64 %0, !808, !DIExpression(), !816)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !825
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !825

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !825
  unreachable, !dbg !825

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !828
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #18, !dbg !829
    #dbg_value(ptr %call11, !770, !DIExpression(), !816)
    #dbg_value(i64 0, !811, !DIExpression(), !816)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !830

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !831
    #dbg_value(i64 %add19, !811, !DIExpression(), !816)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !833
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !830, !llvm.loop !834

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !830

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !811, !DIExpression(), !816)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !836
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !837
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #17, !dbg !838
    #dbg_value(i64 %call13, !814, !DIExpression(), !816)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !839
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !811, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !816)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !839

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !839
  unreachable, !dbg !839

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !842
  store i8 0, ptr %arrayidx20, align 1, !dbg !843, !tbaa !392
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #17, !dbg !844
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #17, !dbg !845
  ret ptr %call11, !dbg !846
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: noreturn nounwind
declare !dbg !847 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare !dbg !852 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #8

; Function Attrs: nofree
declare !dbg !857 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #9

declare !dbg !861 signext i32 @close(i32 noundef signext) local_unnamed_addr #10

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #1 !dbg !519 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !518, !DIExpression(), !862)
    #dbg_value(i32 %n, !523, !DIExpression(), !862)
    #dbg_value(i32 0, !524, !DIExpression(), !862)
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
    #dbg_value(i32 %i.041.reg2mem21.0.load, !524, !DIExpression(), !862)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !518, !DIExpression(), !862)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !869, !tbaa !392
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
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !871, !tbaa !392
  %cmp13 = icmp eq i8 %1, 37, !dbg !872
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !873

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !873

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !874
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !874, !tbaa !392
  %cmp18 = icmp eq i8 %2, 10, !dbg !875
  %inc = zext i1 %cmp18 to i32, !dbg !876
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !876
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !876

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !524, !DIExpression(), !862)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !877
    #dbg_value(ptr %incdec.ptr, !518, !DIExpression(), !862)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !878
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !879, !llvm.loop !880

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !879

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !882, !tbaa !392
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
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !886 {
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
  store i8 0, ptr %arrayidx45, align 1, !dbg !922, !tbaa !392
  br label %if.end46, !dbg !920

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !923
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #11

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !924 {
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
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !938
    #dbg_value(i32 0, !934, !DIExpression(), !937)
  %cmp.not = icmp eq ptr %s, null, !dbg !939
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !939

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #19, !dbg !939
  unreachable, !dbg !939

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !938
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
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !942
  %conv = trunc i64 %call3 to i8, !dbg !942
    #dbg_value(i8 %conv, !935, !DIExpression(), !937)
  %2 = load ptr, ptr %endptr, align 8, !dbg !947, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !947, !tbaa !392
  %cmp5.not = icmp eq i8 %3, 0, !dbg !947
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !942

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !942

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !949, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !949
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !949
  br label %if.end9, !dbg !949

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !942
  store i8 %conv, ptr %arrayidx, align 1, !dbg !942, !tbaa !392
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !942
    #dbg_value(i64 %indvars.iv.next, !934, !DIExpression(), !937)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !942
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !942
  store i8 10, ptr %arrayidx11, align 1, !dbg !942, !tbaa !392
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !942
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
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !952
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !952
  store i8 10, ptr %arrayidx17, align 1, !dbg !952, !tbaa !392
  br label %if.end18, !dbg !952

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !938
  ret i32 0, !dbg !938
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !955 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #12

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !961 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #12

; Function Attrs: nofree nounwind
declare !dbg !966 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !1021 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1024 {
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
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1038
    #dbg_value(i32 0, !1034, !DIExpression(), !1037)
  %cmp.not = icmp eq ptr %s, null, !dbg !1039
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1039

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #19, !dbg !1039
  unreachable, !dbg !1039

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1038
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
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1042
  %conv = trunc i64 %call3 to i16, !dbg !1042
    #dbg_value(i16 %conv, !1035, !DIExpression(), !1037)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1045, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1045, !tbaa !392
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1045
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1042

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1042

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1047, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1047
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1047
  br label %if.end9, !dbg !1047

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1042
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1042, !tbaa !1049
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1042
    #dbg_value(i64 %indvars.iv.next, !1034, !DIExpression(), !1037)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1042
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1042
  store i8 10, ptr %arrayidx11, align 1, !dbg !1042, !tbaa !392
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1042
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
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1052
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1052
  store i8 10, ptr %arrayidx17, align 1, !dbg !1052, !tbaa !392
  br label %if.end18, !dbg !1052

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1038
  ret i32 0, !dbg !1038
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1055 {
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
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1069
    #dbg_value(i32 0, !1065, !DIExpression(), !1068)
  %cmp.not = icmp eq ptr %s, null, !dbg !1070
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1070

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #19, !dbg !1070
  unreachable, !dbg !1070

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1069
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
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1073
  %conv = trunc i64 %call3 to i32, !dbg !1073
    #dbg_value(i32 %conv, !1066, !DIExpression(), !1068)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1076, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1076, !tbaa !392
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1076
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1073

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1073

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1078, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1078
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1078
  br label %if.end9, !dbg !1078

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1073
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1073, !tbaa !1080
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1073
    #dbg_value(i64 %indvars.iv.next, !1065, !DIExpression(), !1068)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1073
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1073
  store i8 10, ptr %arrayidx11, align 1, !dbg !1073, !tbaa !392
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1073
    #dbg_value(ptr %call12, !1063, !DIExpression(), !1068)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1069
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1069
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1069
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1069, !llvm.loop !1082

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
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1083
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1083
  store i8 10, ptr %arrayidx17, align 1, !dbg !1083, !tbaa !392
  br label %if.end18, !dbg !1083

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1069
  ret i32 0, !dbg !1069
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1086 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1097
    #dbg_assign(i1 undef, !1094, !DIExpression(), !1097, ptr %endptr, !DIExpression(), !1098)
    #dbg_value(ptr %s, !1090, !DIExpression(), !1098)
    #dbg_value(ptr %arr, !1091, !DIExpression(), !1098)
    #dbg_value(i32 %n, !1092, !DIExpression(), !1098)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1099
    #dbg_value(i32 0, !1095, !DIExpression(), !1098)
  %cmp.not = icmp eq ptr %s, null, !dbg !1100
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1100

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #19, !dbg !1100
  unreachable, !dbg !1100

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1099
    #dbg_value(ptr %call, !1093, !DIExpression(), !1098)
    #dbg_value(i32 0, !1095, !DIExpression(), !1098)
  %cmp129 = icmp ne ptr %call, null, !dbg !1099
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1099
  %0 = and i1 %cmp230, %cmp129, !dbg !1099
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1099

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1099

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1099
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1099

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1093, !DIExpression(), !1098)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1095, !DIExpression(), !1098)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1103, !tbaa !944, !DIAssignID !1105
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1094, !DIExpression(), !1105, ptr %endptr, !DIExpression(), !1098)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1103
    #dbg_value(i64 %call3, !1096, !DIExpression(), !1098)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1106, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1106, !tbaa !392
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1106
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1103

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1103

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1108, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1108
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1108
  br label %if.end8, !dbg !1108

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1103
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1103, !tbaa !396
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1103
    #dbg_value(i64 %indvars.iv.next, !1095, !DIExpression(), !1098)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1103
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1103
  store i8 10, ptr %arrayidx10, align 1, !dbg !1103, !tbaa !392
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1103
    #dbg_value(ptr %call11, !1093, !DIExpression(), !1098)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1099
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1099
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1099
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1099, !llvm.loop !1110

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1099

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1099

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1099

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1099

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1111
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1111
  store i8 10, ptr %arrayidx16, align 1, !dbg !1111, !tbaa !392
  br label %if.end17, !dbg !1111

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1099
  ret i32 0, !dbg !1099
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1114 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1126
    #dbg_assign(i1 undef, !1123, !DIExpression(), !1126, ptr %endptr, !DIExpression(), !1127)
    #dbg_value(ptr %s, !1119, !DIExpression(), !1127)
    #dbg_value(ptr %arr, !1120, !DIExpression(), !1127)
    #dbg_value(i32 %n, !1121, !DIExpression(), !1127)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1128
    #dbg_value(i32 0, !1124, !DIExpression(), !1127)
  %cmp.not = icmp eq ptr %s, null, !dbg !1129
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1129

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #19, !dbg !1129
  unreachable, !dbg !1129

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1128
    #dbg_value(ptr %call, !1122, !DIExpression(), !1127)
    #dbg_value(i32 0, !1124, !DIExpression(), !1127)
  %cmp130 = icmp ne ptr %call, null, !dbg !1128
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1128
  %0 = and i1 %cmp231, %cmp130, !dbg !1128
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1128

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1128

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1128
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1128

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1122, !DIExpression(), !1127)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1124, !DIExpression(), !1127)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1132, !tbaa !944, !DIAssignID !1134
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1123, !DIExpression(), !1134, ptr %endptr, !DIExpression(), !1127)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1132
  %conv = trunc i64 %call3 to i8, !dbg !1132
    #dbg_value(i8 %conv, !1125, !DIExpression(), !1127)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1135, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1135, !tbaa !392
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1135
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1132

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1132

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1137, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1137
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1137
  br label %if.end9, !dbg !1137

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1132
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1132, !tbaa !392
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1132
    #dbg_value(i64 %indvars.iv.next, !1124, !DIExpression(), !1127)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1132
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1132
  store i8 10, ptr %arrayidx11, align 1, !dbg !1132, !tbaa !392
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1132
    #dbg_value(ptr %call12, !1122, !DIExpression(), !1127)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1128
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1128
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1128
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1128, !llvm.loop !1139

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1128

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1128

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1128

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1128

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1140
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1140
  store i8 10, ptr %arrayidx17, align 1, !dbg !1140, !tbaa !392
  br label %if.end18, !dbg !1140

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1128
  ret i32 0, !dbg !1128
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1143 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1155
    #dbg_assign(i1 undef, !1152, !DIExpression(), !1155, ptr %endptr, !DIExpression(), !1156)
    #dbg_value(ptr %s, !1148, !DIExpression(), !1156)
    #dbg_value(ptr %arr, !1149, !DIExpression(), !1156)
    #dbg_value(i32 %n, !1150, !DIExpression(), !1156)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1157
    #dbg_value(i32 0, !1153, !DIExpression(), !1156)
  %cmp.not = icmp eq ptr %s, null, !dbg !1158
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1158

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #19, !dbg !1158
  unreachable, !dbg !1158

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1157
    #dbg_value(ptr %call, !1151, !DIExpression(), !1156)
    #dbg_value(i32 0, !1153, !DIExpression(), !1156)
  %cmp130 = icmp ne ptr %call, null, !dbg !1157
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1157
  %0 = and i1 %cmp231, %cmp130, !dbg !1157
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1157

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1157

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1157
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1157

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1151, !DIExpression(), !1156)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1153, !DIExpression(), !1156)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1161, !tbaa !944, !DIAssignID !1163
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1152, !DIExpression(), !1163, ptr %endptr, !DIExpression(), !1156)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1161
  %conv = trunc i64 %call3 to i16, !dbg !1161
    #dbg_value(i16 %conv, !1154, !DIExpression(), !1156)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1164, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1164, !tbaa !392
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1164
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1161

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1161

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1166, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1166
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1166
  br label %if.end9, !dbg !1166

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1161
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1161, !tbaa !1049
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1161
    #dbg_value(i64 %indvars.iv.next, !1153, !DIExpression(), !1156)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1161
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1161
  store i8 10, ptr %arrayidx11, align 1, !dbg !1161, !tbaa !392
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1161
    #dbg_value(ptr %call12, !1151, !DIExpression(), !1156)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1157
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1157
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1157
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1157, !llvm.loop !1168

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1157

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1157

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1157

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1157

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1169
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1169
  store i8 10, ptr %arrayidx17, align 1, !dbg !1169, !tbaa !392
  br label %if.end18, !dbg !1169

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1157
  ret i32 0, !dbg !1157
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1172 {
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
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1186
    #dbg_value(i32 0, !1182, !DIExpression(), !1185)
  %cmp.not = icmp eq ptr %s, null, !dbg !1187
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1187

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #19, !dbg !1187
  unreachable, !dbg !1187

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1186
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
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1190
  %conv = trunc i64 %call3 to i32, !dbg !1190
    #dbg_value(i32 %conv, !1183, !DIExpression(), !1185)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1193, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1193, !tbaa !392
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1193
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1190

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1190

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1195, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1195
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1195
  br label %if.end9, !dbg !1195

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1190
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1190, !tbaa !1080
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1190
    #dbg_value(i64 %indvars.iv.next, !1182, !DIExpression(), !1185)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #21, !dbg !1190
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1190
  store i8 10, ptr %arrayidx11, align 1, !dbg !1190, !tbaa !392
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1190
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
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1198
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1198
  store i8 10, ptr %arrayidx17, align 1, !dbg !1198, !tbaa !392
  br label %if.end18, !dbg !1198

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1186
  ret i32 0, !dbg !1186
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1201 {
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
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1215
    #dbg_value(i32 0, !1211, !DIExpression(), !1214)
  %cmp.not = icmp eq ptr %s, null, !dbg !1216
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1216

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #19, !dbg !1216
  unreachable, !dbg !1216

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1215
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
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #17, !dbg !1219
    #dbg_value(i64 %call3, !1212, !DIExpression(), !1214)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1222, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1222, !tbaa !392
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1222
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1219

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1219

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1224, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1224
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1224
  br label %if.end8, !dbg !1224

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1219
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1219, !tbaa !396
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1219
    #dbg_value(i64 %indvars.iv.next, !1211, !DIExpression(), !1214)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1219
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1219
  store i8 10, ptr %arrayidx10, align 1, !dbg !1219, !tbaa !392
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1219
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
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1227
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1227
  store i8 10, ptr %arrayidx16, align 1, !dbg !1227, !tbaa !392
  br label %if.end17, !dbg !1227

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1215
  ret i32 0, !dbg !1215
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1230 {
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
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1244
    #dbg_value(i32 0, !1240, !DIExpression(), !1243)
  %cmp.not = icmp eq ptr %s, null, !dbg !1245
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1245

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #19, !dbg !1245
  unreachable, !dbg !1245

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1244
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
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #17, !dbg !1248
    #dbg_value(float %call3, !1241, !DIExpression(), !1243)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1251, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1251, !tbaa !392
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1251
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1248

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1248

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1253, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1253
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1253
  br label %if.end8, !dbg !1253

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1248
  store float %call3, ptr %arrayidx, align 4, !dbg !1248, !tbaa !1255
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1248
    #dbg_value(i64 %indvars.iv.next, !1240, !DIExpression(), !1243)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1248
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1248
  store i8 10, ptr %arrayidx10, align 1, !dbg !1248, !tbaa !392
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1248
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
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1258
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1258
  store i8 10, ptr %arrayidx16, align 1, !dbg !1258, !tbaa !392
  br label %if.end17, !dbg !1258

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1244
  ret i32 0, !dbg !1244
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1261 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1264 {
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
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1278
    #dbg_value(i32 0, !1274, !DIExpression(), !1277)
  %cmp.not = icmp eq ptr %s, null, !dbg !1279
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1279

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #19, !dbg !1279
  unreachable, !dbg !1279

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #17, !dbg !1278
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
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #17, !dbg !1282
    #dbg_value(double %call3, !1275, !DIExpression(), !1277)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1285, !tbaa !944
  %3 = load i8, ptr %2, align 1, !dbg !1285, !tbaa !392
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1285
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1282

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1282

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1287, !tbaa !944
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1287
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #20, !dbg !1287
  br label %if.end8, !dbg !1287

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1282
  store double %call3, ptr %arrayidx, align 8, !dbg !1282, !tbaa !1289
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1282
    #dbg_value(i64 %indvars.iv.next, !1274, !DIExpression(), !1277)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #21, !dbg !1282
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1282
  store i8 10, ptr %arrayidx10, align 1, !dbg !1282, !tbaa !392
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #17, !dbg !1282
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
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #21, !dbg !1292
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1292
  store i8 10, ptr %arrayidx16, align 1, !dbg !1292, !tbaa !392
  br label %if.end17, !dbg !1292

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #17, !dbg !1278
  ret i32 0, !dbg !1278
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1295 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1298 {
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
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #21, !dbg !1314
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
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #17, !dbg !1327
  %conv8 = trunc i64 %call7 to i32, !dbg !1327
    #dbg_value(i32 %conv8, !1305, !DIExpression(), !1307)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1328
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1306, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1307)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1328

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1328
  unreachable, !dbg !1328

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #17, !dbg !1331
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
declare !dbg !1341 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #9

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1346 {
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
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1362, !tbaa !392
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
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #14 !dbg !1366 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1381
    #dbg_assign(i1 undef, !1372, !DIExpression(), !1381, ptr %args, !DIExpression(), !1382)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1383
    #dbg_assign(i1 undef, !1379, !DIExpression(), !1383, ptr %buffer, !DIExpression(), !1382)
    #dbg_value(i32 %fd, !1370, !DIExpression(), !1382)
    #dbg_value(ptr %format, !1371, !DIExpression(), !1382)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #17, !dbg !1384
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #17, !dbg !1385
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1386
  %0 = load ptr, ptr %args, align 8, !dbg !1387, !tbaa !944
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #17, !dbg !1388
    #dbg_value(i32 %call, !1376, !DIExpression(), !1382)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1389
  %cmp = icmp slt i32 %call, 256, !dbg !1390
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1390

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1377, !DIExpression(), !1382)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1393
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1394

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1394

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1394

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1390
  unreachable, !dbg !1390

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1395
    #dbg_value(i32 %add, !1377, !DIExpression(), !1382)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1393
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1394, !llvm.loop !1397

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1394

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1394

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1377, !DIExpression(), !1382)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1399
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1399
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1400
  %conv = sext i32 %sub to i64, !dbg !1401
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #17, !dbg !1402
  %conv3 = trunc i64 %call2 to i32, !dbg !1402
    #dbg_value(i32 %conv3, !1378, !DIExpression(), !1382)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1403
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1377, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1382)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1403

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1403
  unreachable, !dbg !1403

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1406
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1406

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1406
  unreachable, !dbg !1406

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #17, !dbg !1409
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #17, !dbg !1409
  ret void, !dbg !1410
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #15

; Function Attrs: nofree nounwind
declare !dbg !1411 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #8

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1416 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1420, !DIExpression(), !1424)
    #dbg_value(ptr %arr, !1421, !DIExpression(), !1424)
    #dbg_value(i32 %n, !1422, !DIExpression(), !1424)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1425
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1425

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1423, !DIExpression(), !1424)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1428
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1431

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1431

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1428
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1431

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #19, !dbg !1425
  unreachable, !dbg !1425

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1423, !DIExpression(), !1424)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1432
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1432, !tbaa !1049
  %conv = zext i16 %0 to i32, !dbg !1432
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1432
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1428
    #dbg_value(i64 %indvars.iv.next, !1423, !DIExpression(), !1424)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1428
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1431, !llvm.loop !1434

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1431

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1431

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1435
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1436 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1440, !DIExpression(), !1444)
    #dbg_value(ptr %arr, !1441, !DIExpression(), !1444)
    #dbg_value(i32 %n, !1442, !DIExpression(), !1444)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1445
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1445

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1443, !DIExpression(), !1444)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1448
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1451

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1451

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1448
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1451

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #19, !dbg !1445
  unreachable, !dbg !1445

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1443, !DIExpression(), !1444)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1452
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1452, !tbaa !1080
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1452
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1448
    #dbg_value(i64 %indvars.iv.next, !1443, !DIExpression(), !1444)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1448
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1451, !llvm.loop !1454

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1451

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1451

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1455
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !638 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !637, !DIExpression(), !1456)
    #dbg_value(ptr %arr, !642, !DIExpression(), !1456)
    #dbg_value(i32 %n, !643, !DIExpression(), !1456)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1457
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1457

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !644, !DIExpression(), !1456)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1460
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1461

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1461

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1460
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1461

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #19, !dbg !1457
  unreachable, !dbg !1457

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !644, !DIExpression(), !1456)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1462
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1462, !tbaa !396
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1462
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1460
    #dbg_value(i64 %indvars.iv.next, !644, !DIExpression(), !1456)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1460
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1461, !llvm.loop !1463

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1461

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1461

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1464
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1465 {
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
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1481, !tbaa !392
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
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1485 {
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
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1501, !tbaa !1049
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
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1505 {
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
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1521, !tbaa !1080
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
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1525 {
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
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1541, !tbaa !396
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
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1545 {
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
  %0 = load float, ptr %arrayidx, align 4, !dbg !1561, !tbaa !1255
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
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #1 !dbg !1565 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1569, !DIExpression(), !1573)
    #dbg_value(ptr %arr, !1570, !DIExpression(), !1573)
    #dbg_value(i32 %n, !1571, !DIExpression(), !1573)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1574
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1574

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1572, !DIExpression(), !1573)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1577
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1580

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1580

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1577
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1580

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #19, !dbg !1574
  unreachable, !dbg !1574

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1572, !DIExpression(), !1573)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1581
  %0 = load double, ptr %arrayidx, align 8, !dbg !1581, !tbaa !1289
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1581
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1577
    #dbg_value(i64 %indvars.iv.next, !1572, !DIExpression(), !1573)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1577
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1580, !llvm.loop !1583

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1580

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1580

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1584
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #1 !dbg !626 {
entry.split:
    #dbg_value(i32 %fd, !625, !DIExpression(), !1585)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1586
  br i1 %cmp, label %if.end, label %if.else, !dbg !1586

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1586
  unreachable, !dbg !1586

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1587
  ret i32 0, !dbg !1588
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #1 !dbg !1589 {
entry.split:
  %call.reg2mem = alloca ptr, align 8
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.09.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem86 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem88 = alloca ptr, align 8
  %i.041.i.i.reg2mem90 = alloca i32, align 4
  %indvars.iv.i.i2.reg2mem = alloca i64, align 8
  %cnt.3.i.i.reg2mem92 = alloca i64, align 8
  %cnt.2.i.i.reg2mem94 = alloca i64, align 8
  %cnt.160.i.i.reg2mem96 = alloca i64, align 8
  %e.061.i.i.reg2mem98 = alloca i64, align 8
  %cnt.062.i.i.reg2mem100 = alloca i64, align 8
  %n.063.i.i.reg2mem102 = alloca i64, align 8
  %indvars.iv.i.i.reg2mem104 = alloca i64, align 8
  %check_file.0.reg2mem106 = alloca ptr, align 8
  %in_file.010.reg2mem108 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1593, !DIExpression(), !1602)
    #dbg_value(ptr %argv, !1594, !DIExpression(), !1602)
  %cmp = icmp slt i32 %argc, 4, !dbg !1603
  br i1 %cmp, label %if.end, label %if.else, !dbg !1603

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1603
  unreachable, !dbg !1603

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1595, !DIExpression(), !1602)
    #dbg_value(ptr @.str.4.13, !1596, !DIExpression(), !1602)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1606
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1608

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.13, ptr %check_file.0.reg2mem106, align 8
  store ptr @.str.3, ptr %in_file.010.reg2mem108, align 8
  br label %if.end7, !dbg !1608

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1609
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1609
    #dbg_value(ptr %0, !1595, !DIExpression(), !1602)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1610
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1612

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.13, ptr %check_file.0.reg2mem106, align 8
  store ptr %0, ptr %in_file.010.reg2mem108, align 8
  br label %if.end7, !dbg !1612

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1613
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1613
    #dbg_value(ptr %1, !1596, !DIExpression(), !1602)
  store ptr %1, ptr %check_file.0.reg2mem106, align 8
  store ptr %0, ptr %in_file.010.reg2mem108, align 8
  br label %if.end7, !dbg !1614

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem106.0.check_file.0.reload107, !1596, !DIExpression(), !1602)
  %in_file.010.reg2mem108.0.in_file.010.reload109 = load ptr, ptr %in_file.010.reg2mem108, align 8
  %check_file.0.reg2mem106.0.check_file.0.reload107 = load ptr, ptr %check_file.0.reg2mem106, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1615, !tbaa !1080
  %conv = sext i32 %2 to i64, !dbg !1615
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #18, !dbg !1616
    #dbg_value(ptr %call, !1598, !DIExpression(), !1602)
  store ptr %call, ptr %call.reg2mem, align 8
  %cmp8.not = icmp eq ptr %call, null, !dbg !1617
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1617

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.14, ptr noundef nonnull @.str.2.12, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1617
  unreachable, !dbg !1617

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.010.reg2mem108.0.in_file.010.reload109, i32 noundef signext 0) #17, !dbg !1620
    #dbg_value(i32 %call14, !1597, !DIExpression(), !1602)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1621
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1621

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.15, ptr noundef nonnull @.str.2.12, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1621
  unreachable, !dbg !1621

if.end20:                                         ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #17, !dbg !1624
    #dbg_value(ptr %call, !447, !DIExpression(), !1625)
    #dbg_value(ptr %call, !448, !DIExpression(), !1625)
  %edges.i = getelementptr inbounds i8, ptr %call, i64 4096, !dbg !1627
  %starting_node.i = getelementptr inbounds i8, ptr %call, i64 36864, !dbg !1628
  %3 = load i64, ptr %starting_node.i, align 8, !dbg !1628, !tbaa !452
  %level.i = getelementptr inbounds i8, ptr %call, i64 36872, !dbg !1629
  %level_counts.i = getelementptr inbounds i8, ptr %call, i64 37128, !dbg !1630
    #dbg_value(ptr %call, !362, !DIExpression(), !1631)
    #dbg_value(ptr %edges.i, !363, !DIExpression(), !1631)
    #dbg_value(i64 %3, !364, !DIExpression(), !1631)
    #dbg_value(ptr %level.i, !365, !DIExpression(), !1631)
    #dbg_value(ptr %level_counts.i, !366, !DIExpression(), !1631)
  %arrayidx.i.i = getelementptr inbounds i8, ptr %level.i, i64 %3, !dbg !1633
  store i8 0, ptr %arrayidx.i.i, align 1, !dbg !1634, !tbaa !392
  store i64 1, ptr %level_counts.i, align 8, !dbg !1635, !tbaa !396
    #dbg_label(!371, !1636)
    #dbg_value(i8 0, !369, !DIExpression(), !1631)
  %invariant.gep.i.i = getelementptr i8, ptr %call, i64 37136, !dbg !1637
  store i64 0, ptr %indvars.iv.i.i.reg2mem104, align 8
  br label %for.cond3.preheader.i.i, !dbg !1638

for.cond3.preheader.i.i:                          ; preds = %for.end31.i.i.for.cond3.preheader.i.i_crit_edge, %if.end20
    #dbg_value(i64 %indvars.iv.i.i.reg2mem104.0.load, !369, !DIExpression(), !1631)
    #dbg_value(i64 0, !367, !DIExpression(), !1631)
    #dbg_value(i64 0, !370, !DIExpression(), !1631)
  %indvars.iv.i.i.reg2mem104.0.load = load i64, ptr %indvars.iv.i.i.reg2mem104, align 8
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem104.0.load, 1, !dbg !1639
  %4 = trunc i64 %indvars.iv.next.i.i to i8
  store i64 0, ptr %cnt.062.i.i.reg2mem100, align 8
  store i64 0, ptr %n.063.i.i.reg2mem102, align 8
  br label %for.body6.i.i, !dbg !1640

for.body6.i.i:                                    ; preds = %for.inc29.i.i.for.body6.i.i_crit_edge, %for.cond3.preheader.i.i
    #dbg_value(i64 %n.063.i.i.reg2mem102.0.load, !367, !DIExpression(), !1631)
    #dbg_value(i64 %cnt.062.i.i.reg2mem100.0.load, !370, !DIExpression(), !1631)
  %n.063.i.i.reg2mem102.0.load = load i64, ptr %n.063.i.i.reg2mem102, align 8
  %cnt.062.i.i.reg2mem100.0.load = load i64, ptr %cnt.062.i.i.reg2mem100, align 8
  %arrayidx7.i.i = getelementptr inbounds i8, ptr %level.i, i64 %n.063.i.i.reg2mem102.0.load, !dbg !1641
  %5 = load i8, ptr %arrayidx7.i.i, align 1, !dbg !1641, !tbaa !392
  %6 = zext i8 %5 to i64, !dbg !1642
  %cmp10.i.i = icmp eq i64 %indvars.iv.i.i.reg2mem104.0.load, %6, !dbg !1642
  br i1 %cmp10.i.i, label %if.then.i.i, label %for.body6.i.i.for.inc29.i.i_crit_edge, !dbg !1643

for.body6.i.i.for.inc29.i.i_crit_edge:            ; preds = %for.body6.i.i
  store i64 %cnt.062.i.i.reg2mem100.0.load, ptr %cnt.3.i.i.reg2mem92, align 8
  br label %for.inc29.i.i, !dbg !1643

if.then.i.i:                                      ; preds = %for.body6.i.i
  %arrayidx12.i.i = getelementptr inbounds %struct.node_t_struct, ptr %call, i64 %n.063.i.i.reg2mem102.0.load, !dbg !1644
  %7 = load i64, ptr %arrayidx12.i.i, align 8, !dbg !1645
    #dbg_value(i64 %7, !376, !DIExpression(), !1646)
  %edge_end.i.i = getelementptr inbounds %struct.node_t_struct, ptr %call, i64 %n.063.i.i.reg2mem102.0.load, i32 1, !dbg !1647
  %8 = load i64, ptr %edge_end.i.i, align 8, !dbg !1647
    #dbg_value(i64 %8, !382, !DIExpression(), !1646)
    #dbg_label(!383, !1648)
    #dbg_value(i64 %7, !368, !DIExpression(), !1631)
    #dbg_value(i64 %cnt.062.i.i.reg2mem100.0.load, !370, !DIExpression(), !1631)
  %cmp1559.i.i = icmp ult i64 %7, %8, !dbg !1649
  br i1 %cmp1559.i.i, label %if.then.i.i.for.body17.i.i_crit_edge, label %if.then.i.i.for.inc29.i.i_crit_edge, !dbg !1650

if.then.i.i.for.inc29.i.i_crit_edge:              ; preds = %if.then.i.i
  store i64 %cnt.062.i.i.reg2mem100.0.load, ptr %cnt.3.i.i.reg2mem92, align 8
  br label %for.inc29.i.i, !dbg !1650

if.then.i.i.for.body17.i.i_crit_edge:             ; preds = %if.then.i.i
  store i64 %cnt.062.i.i.reg2mem100.0.load, ptr %cnt.160.i.i.reg2mem96, align 8
  store i64 %7, ptr %e.061.i.i.reg2mem98, align 8
  br label %for.body17.i.i, !dbg !1650

for.body17.i.i:                                   ; preds = %if.end.i.i.for.body17.i.i_crit_edge, %if.then.i.i.for.body17.i.i_crit_edge
    #dbg_value(i64 %e.061.i.i.reg2mem98.0.load, !368, !DIExpression(), !1631)
    #dbg_value(i64 %cnt.160.i.i.reg2mem96.0.load, !370, !DIExpression(), !1631)
  %e.061.i.i.reg2mem98.0.load = load i64, ptr %e.061.i.i.reg2mem98, align 8
  %cnt.160.i.i.reg2mem96.0.load = load i64, ptr %cnt.160.i.i.reg2mem96, align 8
  %arrayidx18.i.i = getelementptr inbounds %struct.edge_t_struct, ptr %edges.i, i64 %e.061.i.i.reg2mem98.0.load, !dbg !1651
  %9 = load i64, ptr %arrayidx18.i.i, align 8, !dbg !1652, !tbaa !415
    #dbg_value(i64 %9, !384, !DIExpression(), !1653)
  %arrayidx19.i.i = getelementptr inbounds i8, ptr %level.i, i64 %9, !dbg !1654
  %10 = load i8, ptr %arrayidx19.i.i, align 1, !dbg !1654, !tbaa !392
    #dbg_value(i8 %10, !388, !DIExpression(), !1653)
  %cmp21.i.i = icmp eq i8 %10, 127, !dbg !1655
  br i1 %cmp21.i.i, label %if.then23.i.i, label %for.body17.i.i.if.end.i.i_crit_edge, !dbg !1656

for.body17.i.i.if.end.i.i_crit_edge:              ; preds = %for.body17.i.i
  store i64 %cnt.160.i.i.reg2mem96.0.load, ptr %cnt.2.i.i.reg2mem94, align 8
  br label %if.end.i.i, !dbg !1656

if.then23.i.i:                                    ; preds = %for.body17.i.i
  store i8 %4, ptr %arrayidx19.i.i, align 1, !dbg !1657, !tbaa !392
  %inc.i.i = add i64 %cnt.160.i.i.reg2mem96.0.load, 1, !dbg !1658
    #dbg_value(i64 %inc.i.i, !370, !DIExpression(), !1631)
  store i64 %inc.i.i, ptr %cnt.2.i.i.reg2mem94, align 8
  br label %if.end.i.i, !dbg !1659

if.end.i.i:                                       ; preds = %for.body17.i.i.if.end.i.i_crit_edge, %if.then23.i.i
    #dbg_value(i64 %cnt.2.i.i.reg2mem94.0.load, !370, !DIExpression(), !1631)
  %cnt.2.i.i.reg2mem94.0.load = load i64, ptr %cnt.2.i.i.reg2mem94, align 8
  %inc27.i.i = add nuw i64 %e.061.i.i.reg2mem98.0.load, 1, !dbg !1660
    #dbg_value(i64 %inc27.i.i, !368, !DIExpression(), !1631)
  %exitcond.not.i.i = icmp eq i64 %inc27.i.i, %8, !dbg !1649
  br i1 %exitcond.not.i.i, label %if.end.i.i.for.inc29.i.i_crit_edge, label %if.end.i.i.for.body17.i.i_crit_edge, !dbg !1650, !llvm.loop !1661

if.end.i.i.for.body17.i.i_crit_edge:              ; preds = %if.end.i.i
  store i64 %cnt.2.i.i.reg2mem94.0.load, ptr %cnt.160.i.i.reg2mem96, align 8
  store i64 %inc27.i.i, ptr %e.061.i.i.reg2mem98, align 8
  br label %for.body17.i.i, !dbg !1650

if.end.i.i.for.inc29.i.i_crit_edge:               ; preds = %if.end.i.i
  store i64 %cnt.2.i.i.reg2mem94.0.load, ptr %cnt.3.i.i.reg2mem92, align 8
  br label %for.inc29.i.i, !dbg !1650

for.inc29.i.i:                                    ; preds = %if.end.i.i.for.inc29.i.i_crit_edge, %if.then.i.i.for.inc29.i.i_crit_edge, %for.body6.i.i.for.inc29.i.i_crit_edge
    #dbg_value(i64 %cnt.3.i.i.reg2mem92.0.load, !370, !DIExpression(), !1631)
  %cnt.3.i.i.reg2mem92.0.load = load i64, ptr %cnt.3.i.i.reg2mem92, align 8
  %inc30.i.i = add nuw nsw i64 %n.063.i.i.reg2mem102.0.load, 1, !dbg !1663
    #dbg_value(i64 %inc30.i.i, !367, !DIExpression(), !1631)
  %exitcond65.not.i.i = icmp eq i64 %inc30.i.i, 256, !dbg !1664
  br i1 %exitcond65.not.i.i, label %for.end31.i.i, label %for.inc29.i.i.for.body6.i.i_crit_edge, !dbg !1640, !llvm.loop !1665

for.inc29.i.i.for.body6.i.i_crit_edge:            ; preds = %for.inc29.i.i
  store i64 %cnt.3.i.i.reg2mem92.0.load, ptr %cnt.062.i.i.reg2mem100, align 8
  store i64 %inc30.i.i, ptr %n.063.i.i.reg2mem102, align 8
  br label %for.body6.i.i, !dbg !1640

for.end31.i.i:                                    ; preds = %for.inc29.i.i
  %gep.i.i = getelementptr i64, ptr %invariant.gep.i.i, i64 %indvars.iv.i.i.reg2mem104.0.load, !dbg !1667
  store i64 %cnt.3.i.i.reg2mem92.0.load, ptr %gep.i.i, align 8, !dbg !1668, !tbaa !396
  %cmp35.i.i = icmp eq i64 %cnt.3.i.i.reg2mem92.0.load, 0, !dbg !1669
    #dbg_value(i64 %indvars.iv.next.i.i, !369, !DIExpression(), !1631)
  %exitcond66.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 10
  %or.cond.i.i = select i1 %cmp35.i.i, i1 true, i1 %exitcond66.not.i.i, !dbg !1670
  br i1 %or.cond.i.i, label %run_benchmark.exit, label %for.end31.i.i.for.cond3.preheader.i.i_crit_edge, !dbg !1670, !llvm.loop !1671

for.end31.i.i.for.cond3.preheader.i.i_crit_edge:  ; preds = %for.end31.i.i
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem104, align 8
  br label %for.cond3.preheader.i.i, !dbg !1670

run_benchmark.exit:                               ; preds = %for.end31.i.i
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #17, !dbg !1673
    #dbg_value(i32 %call21, !1599, !DIExpression(), !1602)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1674
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1674

if.else26:                                        ; preds = %run_benchmark.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1674
  unreachable, !dbg !1674

if.end27:                                         ; preds = %run_benchmark.exit
    #dbg_value(i32 %call21, !724, !DIExpression(), !1677)
    #dbg_value(ptr %call, !725, !DIExpression(), !1677)
    #dbg_value(ptr %call, !726, !DIExpression(), !1677)
    #dbg_value(i32 %call21, !625, !DIExpression(), !1679)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1681
  br i1 %cmp.i.i.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1681

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1681
  unreachable, !dbg !1681

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1682
    #dbg_value(i32 %call21, !637, !DIExpression(), !1683)
    #dbg_value(ptr %level_counts.i, !642, !DIExpression(), !1683)
    #dbg_value(i32 10, !643, !DIExpression(), !1683)
    #dbg_value(i32 0, !644, !DIExpression(), !1683)
  store i64 0, ptr %indvars.iv.i.i2.reg2mem, align 8
  br label %for.body.i.i, !dbg !1685

for.body.i.i:                                     ; preds = %for.body.i.i.for.body.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i2.reg2mem.0.load, !644, !DIExpression(), !1683)
  %indvars.iv.i.i2.reg2mem.0.load = load i64, ptr %indvars.iv.i.i2.reg2mem, align 8
  %arrayidx.i.i3 = getelementptr inbounds i64, ptr %level_counts.i, i64 %indvars.iv.i.i2.reg2mem.0.load, !dbg !1686
  %11 = load i64, ptr %arrayidx.i.i3, align 8, !dbg !1686, !tbaa !396
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.18, i64 noundef %11), !dbg !1686
  %indvars.iv.next.i.i4 = add nuw nsw i64 %indvars.iv.i.i2.reg2mem.0.load, 1, !dbg !1687
    #dbg_value(i64 %indvars.iv.next.i.i4, !644, !DIExpression(), !1683)
  %exitcond.not.i.i5 = icmp eq i64 %indvars.iv.next.i.i4, 10, !dbg !1687
  br i1 %exitcond.not.i.i5, label %data_to_output.exit, label %for.body.i.i.for.body.i.i_crit_edge, !dbg !1685, !llvm.loop !1688

for.body.i.i.for.body.i.i_crit_edge:              ; preds = %for.body.i.i
  store i64 %indvars.iv.next.i.i4, ptr %indvars.iv.i.i2.reg2mem, align 8
  br label %for.body.i.i, !dbg !1685

data_to_output.exit:                              ; preds = %for.body.i.i
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #17, !dbg !1689
  %12 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1690, !tbaa !1080
  %conv29 = sext i32 %12 to i64, !dbg !1690
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #18, !dbg !1691
    #dbg_value(ptr %call30, !1601, !DIExpression(), !1602)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1692
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1692

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.16, ptr noundef nonnull @.str.2.12, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1692
  unreachable, !dbg !1692

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem106.0.check_file.0.reload107, i32 noundef signext 0) #17, !dbg !1695
    #dbg_value(i32 %call37, !1600, !DIExpression(), !1602)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1696
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1696

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.17, ptr noundef nonnull @.str.2.12, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1696
  unreachable, !dbg !1696

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !692, !DIExpression(), !1699)
    #dbg_value(ptr %call30, !693, !DIExpression(), !1699)
    #dbg_value(ptr %call30, !694, !DIExpression(), !1699)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(37208) %call30, i8 0, i64 37208, i1 false), !dbg !1701
  %call.i = tail call ptr @readfile(i32 noundef signext %call37) #17, !dbg !1702
    #dbg_value(ptr %call.i, !695, !DIExpression(), !1699)
    #dbg_value(ptr %call.i, !518, !DIExpression(), !1703)
    #dbg_value(i32 1, !523, !DIExpression(), !1703)
    #dbg_value(i32 0, !524, !DIExpression(), !1703)
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem88, align 8
  store i32 0, ptr %i.041.i.i.reg2mem90, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i.reg2mem90.0.load, !524, !DIExpression(), !1703)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem88.0.s.addr.040.i.i.reload89, !518, !DIExpression(), !1703)
  %i.041.i.i.reg2mem90.0.load = load i32, ptr %i.041.i.i.reg2mem90, align 4
  %s.addr.040.i.i.reg2mem88.0.s.addr.040.i.i.reload89 = load ptr, ptr %s.addr.040.i.i.reg2mem88, align 8
  %13 = load i8, ptr %s.addr.040.i.i.reg2mem88.0.s.addr.040.i.i.reload89, align 1, !dbg !1705, !tbaa !392
  switch i8 %13, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1706

land.rhs.i.i.output_to_data.exit_crit_edge:       ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem88.0.s.addr.040.i.i.reload89, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1706

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem90.0.load, ptr %i.1.i.i.reg2mem86, align 4
  br label %if.end21.i.i, !dbg !1706

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem88.0.s.addr.040.i.i.reload89, i64 1, !dbg !1707
  %14 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !1707, !tbaa !392
  %cmp13.i.i = icmp eq i8 %14, 37, !dbg !1708
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1709

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem90.0.load, ptr %i.1.i.i.reg2mem86, align 4
  br label %if.end21.i.i, !dbg !1709

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem88.0.s.addr.040.i.i.reload89, i64 2, !dbg !1710
  %15 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1710, !tbaa !392
  %cmp18.i.i = icmp eq i8 %15, 10, !dbg !1711
  %inc.i.i7 = zext i1 %cmp18.i.i to i32, !dbg !1712
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem90.0.load, %inc.i.i7, !dbg !1712
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem86, align 4
  br label %if.end21.i.i, !dbg !1712

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem86.0.load, !524, !DIExpression(), !1703)
  %i.1.i.i.reg2mem86.0.load = load i32, ptr %i.1.i.i.reg2mem86, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem88.0.s.addr.040.i.i.reload89, i64 1, !dbg !1713
    #dbg_value(ptr %incdec.ptr.i.i, !518, !DIExpression(), !1703)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem86.0.load, 1, !dbg !1714
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1715, !llvm.loop !1716

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem88, align 8
  store i32 %i.1.i.i.reg2mem86.0.load, ptr %i.041.i.i.reg2mem90, align 4
  br label %land.rhs.i.i, !dbg !1715

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1718, !tbaa !392
  %16 = icmp eq i8 %.pre.i.i, 0, !dbg !1719
  %17 = select i1 %16, i64 0, i64 2, !dbg !1720
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %17, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1715

output_to_data.exit:                              ; preds = %land.rhs.i.i.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1720
    #dbg_value(ptr %spec.select38.i.i, !696, !DIExpression(), !1699)
  %level_counts.i6 = getelementptr inbounds i8, ptr %call30, i64 37128, !dbg !1721
  %call2.i = tail call signext i32 @parse_uint64_t_array(ptr noundef nonnull %spec.select38.i.i, ptr noundef nonnull %level_counts.i6, i32 noundef signext 10) #17, !dbg !1722
  tail call void @free(ptr noundef %call.i) #17, !dbg !1723
    #dbg_value(ptr %call, !744, !DIExpression(), !1724)
    #dbg_value(ptr %call30, !745, !DIExpression(), !1724)
    #dbg_value(ptr %call, !746, !DIExpression(), !1724)
    #dbg_value(ptr %call30, !747, !DIExpression(), !1724)
    #dbg_value(i32 0, !748, !DIExpression(), !1724)
    #dbg_value(i32 0, !749, !DIExpression(), !1724)
  store i32 0, ptr %has_errors.09.i.reg2mem, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1727

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %output_to_data.exit
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !749, !DIExpression(), !1724)
    #dbg_value(i32 %has_errors.09.i.reg2mem.0.load, !748, !DIExpression(), !1724)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %has_errors.09.i.reg2mem.0.load = load i32, ptr %has_errors.09.i.reg2mem, align 4
  %call.reg2mem.0.call.reload = load ptr, ptr %call.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds %struct.bench_args_t, ptr %call.reg2mem.0.call.reload, i64 0, i32 4, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1728
  %18 = load i64, ptr %arrayidx.i, align 8, !dbg !1728, !tbaa !396
  %arrayidx3.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 4, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1729
  %19 = load i64, ptr %arrayidx3.i, align 8, !dbg !1729, !tbaa !396
  %cmp4.i = icmp ne i64 %18, %19, !dbg !1730
  %conv.i = zext i1 %cmp4.i to i32, !dbg !1730
  %or.i = or i32 %has_errors.09.i.reg2mem.0.load, %conv.i, !dbg !1731
    #dbg_value(i32 %or.i, !748, !DIExpression(), !1724)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1732
    #dbg_value(i64 %indvars.iv.next.i, !749, !DIExpression(), !1724)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 10, !dbg !1733
  br i1 %exitcond.not.i, label %check_data.exit, label %for.body.i.for.body.i_crit_edge, !dbg !1727, !llvm.loop !1734

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i32 %or.i, ptr %has_errors.09.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1727

check_data.exit:                                  ; preds = %for.body.i
  %tobool.not.i.not = icmp eq i32 %or.i, 0, !dbg !1736
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1737

if.then45:                                        ; preds = %check_data.exit
  %20 = load ptr, ptr @stderr, align 8, !dbg !1738, !tbaa !944
  %21 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %20) #20, !dbg !1740
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1741

if.end47:                                         ; preds = %check_data.exit
  %call.reg2mem.0.call.reload79 = load ptr, ptr %call.reg2mem, align 8
  tail call void @free(ptr noundef nonnull %call.reg2mem.0.call.reload79) #17, !dbg !1742
  tail call void @free(ptr noundef nonnull %call30) #17, !dbg !1743
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1744
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1745

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1746
}

; Function Attrs: nofree
declare !dbg !1747 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #9

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #16

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #16

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #5 = { nofree norecurse nosync nounwind memory(argmem: read) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #8 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #9 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #10 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #11 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #12 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #13 = { mustprogress nofree nounwind willreturn memory(argmem: read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #14 = { inlinehint nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #15 = { nocallback nofree nosync nounwind willreturn }
attributes #16 = { nofree nounwind }
attributes #17 = { nounwind }
attributes #18 = { nounwind allocsize(0) }
attributes #19 = { noreturn nounwind }
attributes #20 = { cold }
attributes #21 = { nounwind willreturn memory(read) }

!llvm.dbg.cu = !{!255, !188, !257, !314}
!llvm.ident = !{!333, !333, !333, !333}
!llvm.module.flags = !{!334, !335, !336, !337, !338, !340, !341, !342, !343, !344}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/bfs/bulk")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/bfs/bulk")
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
!187 = distinct !DIGlobalVariable(name: "INPUT_SIZE", scope: !188, file: !189, line: 5, type: !233, isLocal: false, isDefinition: true)
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !232, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/bfs/bulk")
!190 = !{!191, !231}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 46, size: 297664, elements: !194)
!193 = !DIFile(filename: "./bfs.h", directory: "/home/kelvin/MachSuite/bfs/bulk")
!194 = !{!195, !210, !219, !220, !227}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "nodes", scope: !192, file: !193, line: 47, baseType: !196, size: 32768)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 32768, elements: !208)
!197 = !DIDerivedType(tag: DW_TAG_typedef, name: "node_t", file: !193, line: 38, baseType: !198)
!198 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node_t_struct", file: !193, line: 35, size: 128, elements: !199)
!199 = !{!200, !207}
!200 = !DIDerivedType(tag: DW_TAG_member, name: "edge_begin", scope: !198, file: !193, line: 36, baseType: !201, size: 64)
!201 = !DIDerivedType(tag: DW_TAG_typedef, name: "edge_index_t", file: !193, line: 25, baseType: !202)
!202 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !203, line: 27, baseType: !204)
!203 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!204 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !205, line: 45, baseType: !206)
!205 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!206 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "edge_end", scope: !198, file: !193, line: 37, baseType: !201, size: 64, offset: 64)
!208 = !{!209}
!209 = !DISubrange(count: 256)
!210 = !DIDerivedType(tag: DW_TAG_member, name: "edges", scope: !192, file: !193, line: 48, baseType: !211, size: 262144, offset: 32768)
!211 = !DICompositeType(tag: DW_TAG_array_type, baseType: !212, size: 262144, elements: !217)
!212 = !DIDerivedType(tag: DW_TAG_typedef, name: "edge_t", file: !193, line: 33, baseType: !213)
!213 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "edge_t_struct", file: !193, line: 28, size: 64, elements: !214)
!214 = !{!215}
!215 = !DIDerivedType(tag: DW_TAG_member, name: "dst", scope: !213, file: !193, line: 32, baseType: !216, size: 64)
!216 = !DIDerivedType(tag: DW_TAG_typedef, name: "node_index_t", file: !193, line: 26, baseType: !202)
!217 = !{!218}
!218 = !DISubrange(count: 4096)
!219 = !DIDerivedType(tag: DW_TAG_member, name: "starting_node", scope: !192, file: !193, line: 49, baseType: !216, size: 64, offset: 294912)
!220 = !DIDerivedType(tag: DW_TAG_member, name: "level", scope: !192, file: !193, line: 50, baseType: !221, size: 2048, offset: 294976)
!221 = !DICompositeType(tag: DW_TAG_array_type, baseType: !222, size: 2048, elements: !208)
!222 = !DIDerivedType(tag: DW_TAG_typedef, name: "level_t", file: !193, line: 40, baseType: !223)
!223 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !224, line: 24, baseType: !225)
!224 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!225 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !205, line: 37, baseType: !226)
!226 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!227 = !DIDerivedType(tag: DW_TAG_member, name: "level_counts", scope: !192, file: !193, line: 51, baseType: !228, size: 640, offset: 297024)
!228 = !DICompositeType(tag: DW_TAG_array_type, baseType: !201, size: 640, elements: !229)
!229 = !{!230}
!230 = !DISubrange(count: 10)
!231 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !202, size: 64)
!232 = !{!186}
!233 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!234 = !DIGlobalVariableExpression(var: !235, expr: !DIExpression())
!235 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !236, isLocal: true, isDefinition: true)
!236 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!237 = !DIGlobalVariableExpression(var: !238, expr: !DIExpression())
!238 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !239, isLocal: true, isDefinition: true)
!239 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!240 = !DIGlobalVariableExpression(var: !241, expr: !DIExpression())
!241 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !242, isLocal: true, isDefinition: true)
!242 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !243)
!243 = !{!244}
!244 = !DISubrange(count: 12)
!245 = !DIGlobalVariableExpression(var: !246, expr: !DIExpression())
!246 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !247, isLocal: true, isDefinition: true)
!247 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!248 = !DIGlobalVariableExpression(var: !249, expr: !DIExpression())
!249 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!250 = !DIGlobalVariableExpression(var: !251, expr: !DIExpression())
!251 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !252, isLocal: true, isDefinition: true)
!252 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!253 = !DIGlobalVariableExpression(var: !254, expr: !DIExpression())
!254 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!255 = distinct !DICompileUnit(language: DW_LANG_C11, file: !256, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!256 = !DIFile(filename: "bfs.c", directory: "/home/kelvin/MachSuite/bfs/bulk")
!257 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !258, globals: !280, splitDebugInlining: false, nameTableKind: None)
!258 = !{!259, !4, !260, !261, !264, !267, !202, !223, !270, !273, !275, !278, !279}
!259 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!260 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!261 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !203, line: 24, baseType: !262)
!262 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !205, line: 38, baseType: !263)
!263 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!264 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !203, line: 25, baseType: !265)
!265 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !205, line: 40, baseType: !266)
!266 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!267 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !203, line: 26, baseType: !268)
!268 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !205, line: 42, baseType: !269)
!269 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!270 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !224, line: 25, baseType: !271)
!271 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !205, line: 39, baseType: !272)
!272 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!273 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !224, line: 26, baseType: !274)
!274 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !205, line: 41, baseType: !233)
!275 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !224, line: 27, baseType: !276)
!276 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !205, line: 44, baseType: !277)
!277 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!278 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!279 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!280 = !{!281, !0, !7, !12, !286, !18, !288, !23, !293, !28, !295, !33, !38, !297, !43, !45, !47, !52, !57, !62, !67, !69, !71, !76, !78, !80, !82, !87, !89, !302, !92, !97, !102, !107, !112, !114, !116, !121, !126, !128, !130, !132, !134, !136, !141, !146, !148, !153, !307, !158, !163, !309, !165}
!281 = !DIGlobalVariableExpression(var: !282, expr: !DIExpression())
!282 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !283, isLocal: true, isDefinition: true)
!283 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 192, elements: !284)
!284 = !{!285}
!285 = !DISubrange(count: 24)
!286 = !DIGlobalVariableExpression(var: !287, expr: !DIExpression())
!287 = distinct !DIGlobalVariable(scope: null, file: !2, line: 41, type: !30, isLocal: true, isDefinition: true)
!288 = !DIGlobalVariableExpression(var: !289, expr: !DIExpression())
!289 = distinct !DIGlobalVariable(scope: null, file: !2, line: 43, type: !290, isLocal: true, isDefinition: true)
!290 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !291)
!291 = !{!292}
!292 = !DISubrange(count: 14)
!293 = !DIGlobalVariableExpression(var: !294, expr: !DIExpression())
!294 = distinct !DIGlobalVariable(scope: null, file: !2, line: 48, type: !290, isLocal: true, isDefinition: true)
!295 = !DIGlobalVariableExpression(var: !296, expr: !DIExpression())
!296 = distinct !DIGlobalVariable(scope: null, file: !2, line: 59, type: !9, isLocal: true, isDefinition: true)
!297 = !DIGlobalVariableExpression(var: !298, expr: !DIExpression())
!298 = distinct !DIGlobalVariable(scope: null, file: !2, line: 79, type: !299, isLocal: true, isDefinition: true)
!299 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !300)
!300 = !{!301}
!301 = !DISubrange(count: 21)
!302 = !DIGlobalVariableExpression(var: !303, expr: !DIExpression())
!303 = distinct !DIGlobalVariable(scope: null, file: !2, line: 154, type: !304, isLocal: true, isDefinition: true)
!304 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 104, elements: !305)
!305 = !{!306}
!306 = !DISubrange(count: 13)
!307 = !DIGlobalVariableExpression(var: !308, expr: !DIExpression())
!308 = distinct !DIGlobalVariable(scope: null, file: !2, line: 22, type: !20, isLocal: true, isDefinition: true)
!309 = !DIGlobalVariableExpression(var: !310, expr: !DIExpression())
!310 = distinct !DIGlobalVariable(scope: null, file: !2, line: 29, type: !311, isLocal: true, isDefinition: true)
!311 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 216, elements: !312)
!312 = !{!313}
!313 = !DISubrange(count: 27)
!314 = distinct !DICompileUnit(language: DW_LANG_C11, file: !170, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !315, globals: !316, splitDebugInlining: false, nameTableKind: None)
!315 = !{!260}
!316 = !{!317, !168, !174, !176, !179, !184, !319, !234, !321, !237, !240, !323, !245, !248, !328, !250, !253, !330}
!317 = !DIGlobalVariableExpression(var: !318, expr: !DIExpression())
!318 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !247, isLocal: true, isDefinition: true)
!319 = !DIGlobalVariableExpression(var: !320, expr: !DIExpression())
!320 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !290, isLocal: true, isDefinition: true)
!321 = !DIGlobalVariableExpression(var: !322, expr: !DIExpression())
!322 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !236, isLocal: true, isDefinition: true)
!323 = !DIGlobalVariableExpression(var: !324, expr: !DIExpression())
!324 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !325, isLocal: true, isDefinition: true)
!325 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !326)
!326 = !{!327}
!327 = !DISubrange(count: 31)
!328 = !DIGlobalVariableExpression(var: !329, expr: !DIExpression())
!329 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !236, isLocal: true, isDefinition: true)
!330 = !DIGlobalVariableExpression(var: !331, expr: !DIExpression())
!331 = distinct !DIGlobalVariable(scope: null, file: !170, line: 74, type: !332, isLocal: true, isDefinition: true)
!332 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 80, elements: !229)
!333 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!334 = !{i32 7, !"Dwarf Version", i32 4}
!335 = !{i32 2, !"Debug Info Version", i32 3}
!336 = !{i32 1, !"wchar_size", i32 4}
!337 = !{i32 1, !"target-abi", !"lp64d"}
!338 = distinct !{i32 6, !"riscv-isa", !339}
!339 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!340 = !{i32 8, !"PIC Level", i32 2}
!341 = !{i32 7, !"PIE Level", i32 2}
!342 = !{i32 7, !"uwtable", i32 2}
!343 = !{i32 8, !"SmallDataLimit", i32 8}
!344 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!345 = distinct !DISubprogram(name: "bfs", scope: !256, file: !256, line: 9, type: !346, scopeLine: 12, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !255, retainedNodes: !361)
!346 = !DISubroutineType(types: !347)
!347 = !{null, !348, !354, !216, !359, !360}
!348 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !349, size: 64)
!349 = !DIDerivedType(tag: DW_TAG_typedef, name: "node_t", file: !193, line: 38, baseType: !350)
!350 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node_t_struct", file: !193, line: 35, size: 128, elements: !351)
!351 = !{!352, !353}
!352 = !DIDerivedType(tag: DW_TAG_member, name: "edge_begin", scope: !350, file: !193, line: 36, baseType: !201, size: 64)
!353 = !DIDerivedType(tag: DW_TAG_member, name: "edge_end", scope: !350, file: !193, line: 37, baseType: !201, size: 64, offset: 64)
!354 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !355, size: 64)
!355 = !DIDerivedType(tag: DW_TAG_typedef, name: "edge_t", file: !193, line: 33, baseType: !356)
!356 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "edge_t_struct", file: !193, line: 28, size: 64, elements: !357)
!357 = !{!358}
!358 = !DIDerivedType(tag: DW_TAG_member, name: "dst", scope: !356, file: !193, line: 32, baseType: !216, size: 64)
!359 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !222, size: 64)
!360 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !201, size: 64)
!361 = !{!362, !363, !364, !365, !366, !367, !368, !369, !370, !371, !372, !376, !382, !383, !384, !388}
!362 = !DILocalVariable(name: "nodes", arg: 1, scope: !345, file: !256, line: 9, type: !348)
!363 = !DILocalVariable(name: "edges", arg: 2, scope: !345, file: !256, line: 9, type: !354)
!364 = !DILocalVariable(name: "starting_node", arg: 3, scope: !345, file: !256, line: 10, type: !216)
!365 = !DILocalVariable(name: "level", arg: 4, scope: !345, file: !256, line: 10, type: !359)
!366 = !DILocalVariable(name: "level_counts", arg: 5, scope: !345, file: !256, line: 11, type: !360)
!367 = !DILocalVariable(name: "n", scope: !345, file: !256, line: 13, type: !216)
!368 = !DILocalVariable(name: "e", scope: !345, file: !256, line: 14, type: !201)
!369 = !DILocalVariable(name: "horizon", scope: !345, file: !256, line: 15, type: !222)
!370 = !DILocalVariable(name: "cnt", scope: !345, file: !256, line: 16, type: !201)
!371 = !DILabel(scope: !345, name: "loop_horizons", file: !256, line: 21)
!372 = !DILabel(scope: !373, name: "loop_nodes", file: !256, line: 24)
!373 = distinct !DILexicalBlock(scope: !374, file: !256, line: 21, column: 64)
!374 = distinct !DILexicalBlock(scope: !375, file: !256, line: 21, column: 18)
!375 = distinct !DILexicalBlock(scope: !345, file: !256, line: 21, column: 18)
!376 = !DILocalVariable(name: "tmp_begin", scope: !377, file: !256, line: 26, type: !201)
!377 = distinct !DILexicalBlock(scope: !378, file: !256, line: 25, column: 31)
!378 = distinct !DILexicalBlock(scope: !379, file: !256, line: 25, column: 11)
!379 = distinct !DILexicalBlock(scope: !380, file: !256, line: 24, column: 44)
!380 = distinct !DILexicalBlock(scope: !381, file: !256, line: 24, column: 17)
!381 = distinct !DILexicalBlock(scope: !373, file: !256, line: 24, column: 17)
!382 = !DILocalVariable(name: "tmp_end", scope: !377, file: !256, line: 27, type: !201)
!383 = !DILabel(scope: !377, name: "loop_neighbors", file: !256, line: 28)
!384 = !DILocalVariable(name: "tmp_dst", scope: !385, file: !256, line: 29, type: !216)
!385 = distinct !DILexicalBlock(scope: !386, file: !256, line: 28, column: 60)
!386 = distinct !DILexicalBlock(scope: !387, file: !256, line: 28, column: 25)
!387 = distinct !DILexicalBlock(scope: !377, file: !256, line: 28, column: 25)
!388 = !DILocalVariable(name: "tmp_level", scope: !385, file: !256, line: 30, type: !222)
!389 = !DILocation(line: 0, scope: !345)
!390 = !DILocation(line: 18, column: 3, scope: !345)
!391 = !DILocation(line: 18, column: 24, scope: !345)
!392 = !{!393, !393, i64 0}
!393 = !{!"omnipotent char", !394, i64 0}
!394 = !{!"Simple C/C++ TBAA"}
!395 = !DILocation(line: 19, column: 19, scope: !345)
!396 = !{!397, !397, i64 0}
!397 = !{!"long", !393, i64 0}
!398 = !DILocation(line: 21, column: 3, scope: !345)
!399 = !DILocation(line: 21, column: 23, scope: !375)
!400 = !DILocation(line: 21, column: 18, scope: !375)
!401 = !DILocation(line: 21, column: 59, scope: !374)
!402 = !DILocation(line: 24, column: 17, scope: !381)
!403 = !DILocation(line: 25, column: 11, scope: !378)
!404 = !DILocation(line: 25, column: 19, scope: !378)
!405 = !DILocation(line: 25, column: 11, scope: !379)
!406 = !DILocation(line: 26, column: 34, scope: !377)
!407 = !DILocation(line: 26, column: 43, scope: !377)
!408 = !DILocation(line: 0, scope: !377)
!409 = !DILocation(line: 27, column: 41, scope: !377)
!410 = !DILocation(line: 28, column: 9, scope: !377)
!411 = !DILocation(line: 28, column: 44, scope: !386)
!412 = !DILocation(line: 28, column: 25, scope: !387)
!413 = !DILocation(line: 29, column: 34, scope: !385)
!414 = !DILocation(line: 29, column: 43, scope: !385)
!415 = !{!416, !397, i64 0}
!416 = !{!"edge_t_struct", !397, i64 0}
!417 = !DILocation(line: 0, scope: !385)
!418 = !DILocation(line: 30, column: 31, scope: !385)
!419 = !DILocation(line: 32, column: 25, scope: !420)
!420 = distinct !DILexicalBlock(scope: !385, file: !256, line: 32, column: 15)
!421 = !DILocation(line: 32, column: 15, scope: !385)
!422 = !DILocation(line: 33, column: 28, scope: !423)
!423 = distinct !DILexicalBlock(scope: !420, file: !256, line: 32, column: 39)
!424 = !DILocation(line: 34, column: 13, scope: !423)
!425 = !DILocation(line: 35, column: 11, scope: !423)
!426 = !DILocation(line: 28, column: 55, scope: !386)
!427 = distinct !{!427, !412, !428, !429, !430}
!428 = !DILocation(line: 36, column: 9, scope: !387)
!429 = !{!"llvm.loop.mustprogress"}
!430 = !{!"llvm.loop.unroll.disable"}
!431 = !DILocation(line: 24, column: 39, scope: !380)
!432 = !DILocation(line: 24, column: 28, scope: !380)
!433 = distinct !{!433, !402, !434, !429, !430}
!434 = !DILocation(line: 38, column: 5, scope: !381)
!435 = !DILocation(line: 39, column: 10, scope: !436)
!436 = distinct !DILexicalBlock(scope: !373, file: !256, line: 39, column: 9)
!437 = !DILocation(line: 39, column: 33, scope: !436)
!438 = !DILocation(line: 39, column: 38, scope: !436)
!439 = !DILocation(line: 39, column: 9, scope: !373)
!440 = distinct !{!440, !400, !441, !429, !430}
!441 = !DILocation(line: 41, column: 3, scope: !375)
!442 = !DILocation(line: 42, column: 1, scope: !345)
!443 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 7, type: !444, scopeLine: 7, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !446)
!444 = !DISubroutineType(types: !445)
!445 = !{null, !260}
!446 = !{!447, !448}
!447 = !DILocalVariable(name: "vargs", arg: 1, scope: !443, file: !189, line: 7, type: !260)
!448 = !DILocalVariable(name: "args", scope: !443, file: !189, line: 8, type: !191)
!449 = !DILocation(line: 0, scope: !443)
!450 = !DILocation(line: 9, column: 26, scope: !443)
!451 = !DILocation(line: 9, column: 39, scope: !443)
!452 = !{!453, !397, i64 36864}
!453 = !{!"bench_args_t", !393, i64 0, !393, i64 4096, !397, i64 36864, !393, i64 36872, !393, i64 37128}
!454 = !DILocation(line: 9, column: 60, scope: !443)
!455 = !DILocation(line: 9, column: 73, scope: !443)
!456 = !DILocation(line: 0, scope: !345, inlinedAt: !457)
!457 = distinct !DILocation(line: 9, column: 3, scope: !443)
!458 = !DILocation(line: 18, column: 3, scope: !345, inlinedAt: !457)
!459 = !DILocation(line: 18, column: 24, scope: !345, inlinedAt: !457)
!460 = !DILocation(line: 19, column: 19, scope: !345, inlinedAt: !457)
!461 = !DILocation(line: 21, column: 3, scope: !345, inlinedAt: !457)
!462 = !DILocation(line: 21, column: 23, scope: !375, inlinedAt: !457)
!463 = !DILocation(line: 21, column: 18, scope: !375, inlinedAt: !457)
!464 = !DILocation(line: 21, column: 59, scope: !374, inlinedAt: !457)
!465 = !DILocation(line: 24, column: 17, scope: !381, inlinedAt: !457)
!466 = !DILocation(line: 25, column: 11, scope: !378, inlinedAt: !457)
!467 = !DILocation(line: 25, column: 19, scope: !378, inlinedAt: !457)
!468 = !DILocation(line: 25, column: 11, scope: !379, inlinedAt: !457)
!469 = !DILocation(line: 26, column: 34, scope: !377, inlinedAt: !457)
!470 = !DILocation(line: 26, column: 43, scope: !377, inlinedAt: !457)
!471 = !DILocation(line: 0, scope: !377, inlinedAt: !457)
!472 = !DILocation(line: 27, column: 41, scope: !377, inlinedAt: !457)
!473 = !DILocation(line: 28, column: 9, scope: !377, inlinedAt: !457)
!474 = !DILocation(line: 28, column: 44, scope: !386, inlinedAt: !457)
!475 = !DILocation(line: 28, column: 25, scope: !387, inlinedAt: !457)
!476 = !DILocation(line: 29, column: 34, scope: !385, inlinedAt: !457)
!477 = !DILocation(line: 29, column: 43, scope: !385, inlinedAt: !457)
!478 = !DILocation(line: 0, scope: !385, inlinedAt: !457)
!479 = !DILocation(line: 30, column: 31, scope: !385, inlinedAt: !457)
!480 = !DILocation(line: 32, column: 25, scope: !420, inlinedAt: !457)
!481 = !DILocation(line: 32, column: 15, scope: !385, inlinedAt: !457)
!482 = !DILocation(line: 33, column: 28, scope: !423, inlinedAt: !457)
!483 = !DILocation(line: 34, column: 13, scope: !423, inlinedAt: !457)
!484 = !DILocation(line: 35, column: 11, scope: !423, inlinedAt: !457)
!485 = !DILocation(line: 28, column: 55, scope: !386, inlinedAt: !457)
!486 = distinct !{!486, !475, !487, !429, !430}
!487 = !DILocation(line: 36, column: 9, scope: !387, inlinedAt: !457)
!488 = !DILocation(line: 24, column: 39, scope: !380, inlinedAt: !457)
!489 = !DILocation(line: 24, column: 28, scope: !380, inlinedAt: !457)
!490 = distinct !{!490, !465, !491, !429, !430}
!491 = !DILocation(line: 38, column: 5, scope: !381, inlinedAt: !457)
!492 = !DILocation(line: 39, column: 10, scope: !436, inlinedAt: !457)
!493 = !DILocation(line: 39, column: 33, scope: !436, inlinedAt: !457)
!494 = !DILocation(line: 39, column: 38, scope: !436, inlinedAt: !457)
!495 = !DILocation(line: 39, column: 9, scope: !373, inlinedAt: !457)
!496 = distinct !{!496, !463, !497, !429, !430}
!497 = !DILocation(line: 41, column: 3, scope: !375, inlinedAt: !457)
!498 = !DILocation(line: 10, column: 1, scope: !443)
!499 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 21, type: !500, scopeLine: 21, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !502)
!500 = !DISubroutineType(types: !501)
!501 = !{null, !233, !260}
!502 = !{!503, !504, !505, !506, !507, !508, !509}
!503 = !DILocalVariable(name: "fd", arg: 1, scope: !499, file: !189, line: 21, type: !233)
!504 = !DILocalVariable(name: "vdata", arg: 2, scope: !499, file: !189, line: 21, type: !260)
!505 = !DILocalVariable(name: "data", scope: !499, file: !189, line: 22, type: !191)
!506 = !DILocalVariable(name: "p", scope: !499, file: !189, line: 23, type: !259)
!507 = !DILocalVariable(name: "s", scope: !499, file: !189, line: 23, type: !259)
!508 = !DILocalVariable(name: "nodes", scope: !499, file: !189, line: 24, type: !231)
!509 = !DILocalVariable(name: "i", scope: !499, file: !189, line: 25, type: !275)
!510 = !DILocation(line: 0, scope: !499)
!511 = !DILocation(line: 28, column: 3, scope: !499)
!512 = !DILocation(line: 30, column: 3, scope: !513)
!513 = distinct !DILexicalBlock(scope: !499, file: !189, line: 30, column: 3)
!514 = !DILocation(line: 31, column: 19, scope: !515)
!515 = distinct !DILexicalBlock(scope: !516, file: !189, line: 30, column: 28)
!516 = distinct !DILexicalBlock(scope: !513, file: !189, line: 30, column: 3)
!517 = !DILocation(line: 34, column: 7, scope: !499)
!518 = !DILocalVariable(name: "s", arg: 1, scope: !519, file: !2, line: 56, type: !259)
!519 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !520, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !522)
!520 = !DISubroutineType(types: !521)
!521 = !{!259, !259, !233}
!522 = !{!518, !523, !524}
!523 = !DILocalVariable(name: "n", arg: 2, scope: !519, file: !2, line: 56, type: !233)
!524 = !DILocalVariable(name: "i", scope: !519, file: !2, line: 57, type: !233)
!525 = !DILocation(line: 0, scope: !519, inlinedAt: !526)
!526 = distinct !DILocation(line: 36, column: 7, scope: !499)
!527 = !DILocation(line: 64, column: 17, scope: !519, inlinedAt: !526)
!528 = !DILocation(line: 64, column: 3, scope: !519, inlinedAt: !526)
!529 = !DILocation(line: 66, column: 22, scope: !530, inlinedAt: !526)
!530 = distinct !DILexicalBlock(scope: !531, file: !2, line: 66, column: 9)
!531 = distinct !DILexicalBlock(scope: !519, file: !2, line: 64, column: 31)
!532 = !DILocation(line: 66, column: 26, scope: !530, inlinedAt: !526)
!533 = !DILocation(line: 66, column: 32, scope: !530, inlinedAt: !526)
!534 = !DILocation(line: 66, column: 35, scope: !530, inlinedAt: !526)
!535 = !DILocation(line: 66, column: 39, scope: !530, inlinedAt: !526)
!536 = !DILocation(line: 66, column: 9, scope: !531, inlinedAt: !526)
!537 = !DILocation(line: 69, column: 6, scope: !531, inlinedAt: !526)
!538 = !DILocation(line: 64, column: 10, scope: !519, inlinedAt: !526)
!539 = !DILocation(line: 64, column: 13, scope: !519, inlinedAt: !526)
!540 = distinct !{!540, !528, !541, !429, !430}
!541 = !DILocation(line: 70, column: 3, scope: !519, inlinedAt: !526)
!542 = !DILocation(line: 71, column: 6, scope: !543, inlinedAt: !526)
!543 = distinct !DILexicalBlock(scope: !519, file: !2, line: 71, column: 6)
!544 = !DILocation(line: 71, column: 8, scope: !543, inlinedAt: !526)
!545 = !DILocation(line: 71, column: 6, scope: !519, inlinedAt: !526)
!546 = !DILocation(line: 37, column: 34, scope: !499)
!547 = !DILocation(line: 37, column: 3, scope: !499)
!548 = !DILocation(line: 0, scope: !519, inlinedAt: !549)
!549 = distinct !DILocation(line: 40, column: 7, scope: !499)
!550 = !DILocation(line: 64, column: 17, scope: !519, inlinedAt: !549)
!551 = !DILocation(line: 64, column: 3, scope: !519, inlinedAt: !549)
!552 = !DILocation(line: 66, column: 22, scope: !530, inlinedAt: !549)
!553 = !DILocation(line: 66, column: 26, scope: !530, inlinedAt: !549)
!554 = !DILocation(line: 66, column: 32, scope: !530, inlinedAt: !549)
!555 = !DILocation(line: 66, column: 35, scope: !530, inlinedAt: !549)
!556 = !DILocation(line: 66, column: 39, scope: !530, inlinedAt: !549)
!557 = !DILocation(line: 66, column: 9, scope: !531, inlinedAt: !549)
!558 = !DILocation(line: 69, column: 6, scope: !531, inlinedAt: !549)
!559 = !DILocation(line: 64, column: 10, scope: !519, inlinedAt: !549)
!560 = !DILocation(line: 64, column: 13, scope: !519, inlinedAt: !549)
!561 = distinct !{!561, !551, !562, !429, !430}
!562 = !DILocation(line: 70, column: 3, scope: !519, inlinedAt: !549)
!563 = !DILocation(line: 71, column: 6, scope: !543, inlinedAt: !549)
!564 = !DILocation(line: 71, column: 8, scope: !543, inlinedAt: !549)
!565 = !DILocation(line: 71, column: 6, scope: !519, inlinedAt: !549)
!566 = !DILocation(line: 41, column: 23, scope: !499)
!567 = !DILocation(line: 42, column: 3, scope: !499)
!568 = !DILocation(line: 43, column: 3, scope: !569)
!569 = distinct !DILexicalBlock(scope: !499, file: !189, line: 43, column: 3)
!570 = !DILocation(line: 44, column: 40, scope: !571)
!571 = distinct !DILexicalBlock(scope: !572, file: !189, line: 43, column: 28)
!572 = distinct !DILexicalBlock(scope: !569, file: !189, line: 43, column: 3)
!573 = !DILocation(line: 44, column: 33, scope: !571)
!574 = !DILocation(line: 44, column: 5, scope: !571)
!575 = !DILocation(line: 44, column: 31, scope: !571)
!576 = !{!577, !397, i64 0}
!577 = !{!"node_t_struct", !397, i64 0, !397, i64 8}
!578 = !DILocation(line: 45, column: 40, scope: !571)
!579 = !DILocation(line: 45, column: 31, scope: !571)
!580 = !DILocation(line: 45, column: 20, scope: !571)
!581 = !DILocation(line: 45, column: 29, scope: !571)
!582 = !{!577, !397, i64 8}
!583 = !DILocation(line: 43, column: 24, scope: !572)
!584 = !DILocation(line: 43, column: 13, scope: !572)
!585 = distinct !{!585, !568, !586, !429, !430}
!586 = !DILocation(line: 46, column: 3, scope: !569)
!587 = !DILocation(line: 47, column: 3, scope: !499)
!588 = !DILocation(line: 0, scope: !519, inlinedAt: !589)
!589 = distinct !DILocation(line: 49, column: 7, scope: !499)
!590 = !DILocation(line: 64, column: 17, scope: !519, inlinedAt: !589)
!591 = !DILocation(line: 64, column: 3, scope: !519, inlinedAt: !589)
!592 = !DILocation(line: 66, column: 22, scope: !530, inlinedAt: !589)
!593 = !DILocation(line: 66, column: 26, scope: !530, inlinedAt: !589)
!594 = !DILocation(line: 66, column: 32, scope: !530, inlinedAt: !589)
!595 = !DILocation(line: 66, column: 35, scope: !530, inlinedAt: !589)
!596 = !DILocation(line: 66, column: 39, scope: !530, inlinedAt: !589)
!597 = !DILocation(line: 66, column: 9, scope: !531, inlinedAt: !589)
!598 = !DILocation(line: 69, column: 6, scope: !531, inlinedAt: !589)
!599 = !DILocation(line: 64, column: 10, scope: !519, inlinedAt: !589)
!600 = !DILocation(line: 64, column: 13, scope: !519, inlinedAt: !589)
!601 = distinct !{!601, !591, !602, !429, !430}
!602 = !DILocation(line: 70, column: 3, scope: !519, inlinedAt: !589)
!603 = !DILocation(line: 71, column: 6, scope: !543, inlinedAt: !589)
!604 = !DILocation(line: 71, column: 8, scope: !543, inlinedAt: !589)
!605 = !DILocation(line: 71, column: 6, scope: !519, inlinedAt: !589)
!606 = !DILocation(line: 50, column: 46, scope: !499)
!607 = !DILocation(line: 50, column: 3, scope: !499)
!608 = !DILocation(line: 51, column: 3, scope: !499)
!609 = !DILocation(line: 52, column: 1, scope: !499)
!610 = !DISubprogram(name: "malloc", scope: !611, file: !611, line: 672, type: !612, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!611 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!612 = !DISubroutineType(types: !613)
!613 = !{!260, !614}
!614 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !615, line: 18, baseType: !206)
!615 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!616 = !DISubprogram(name: "free", scope: !611, file: !611, line: 687, type: !444, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!617 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 54, type: !500, scopeLine: 54, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !618)
!618 = !{!619, !620, !621, !622, !623}
!619 = !DILocalVariable(name: "fd", arg: 1, scope: !617, file: !189, line: 54, type: !233)
!620 = !DILocalVariable(name: "vdata", arg: 2, scope: !617, file: !189, line: 54, type: !260)
!621 = !DILocalVariable(name: "nodes", scope: !617, file: !189, line: 55, type: !231)
!622 = !DILocalVariable(name: "i", scope: !617, file: !189, line: 56, type: !275)
!623 = !DILocalVariable(name: "data", scope: !617, file: !189, line: 58, type: !191)
!624 = !DILocation(line: 0, scope: !617)
!625 = !DILocalVariable(name: "fd", arg: 1, scope: !626, file: !2, line: 189, type: !233)
!626 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !627, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !629)
!627 = !DISubroutineType(types: !628)
!628 = !{!233, !233}
!629 = !{!625}
!630 = !DILocation(line: 0, scope: !626, inlinedAt: !631)
!631 = distinct !DILocation(line: 60, column: 3, scope: !617)
!632 = !DILocation(line: 190, column: 3, scope: !633, inlinedAt: !631)
!633 = distinct !DILexicalBlock(scope: !634, file: !2, line: 190, column: 3)
!634 = distinct !DILexicalBlock(scope: !626, file: !2, line: 190, column: 3)
!635 = !DILocation(line: 191, column: 3, scope: !626, inlinedAt: !631)
!636 = !DILocation(line: 61, column: 35, scope: !617)
!637 = !DILocalVariable(name: "fd", arg: 1, scope: !638, file: !2, line: 180, type: !233)
!638 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !639, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !641)
!639 = !DISubroutineType(types: !640)
!640 = !{!233, !233, !231, !233}
!641 = !{!637, !642, !643, !644}
!642 = !DILocalVariable(name: "arr", arg: 2, scope: !638, file: !2, line: 180, type: !231)
!643 = !DILocalVariable(name: "n", arg: 3, scope: !638, file: !2, line: 180, type: !233)
!644 = !DILocalVariable(name: "i", scope: !638, file: !2, line: 180, type: !233)
!645 = !DILocation(line: 0, scope: !638, inlinedAt: !646)
!646 = distinct !DILocation(line: 61, column: 3, scope: !617)
!647 = !DILocation(line: 180, column: 1, scope: !648, inlinedAt: !646)
!648 = distinct !DILexicalBlock(scope: !649, file: !2, line: 180, column: 1)
!649 = distinct !DILexicalBlock(scope: !650, file: !2, line: 180, column: 1)
!650 = distinct !DILexicalBlock(scope: !638, file: !2, line: 180, column: 1)
!651 = !DILocation(line: 0, scope: !626, inlinedAt: !652)
!652 = distinct !DILocation(line: 63, column: 3, scope: !617)
!653 = !DILocation(line: 191, column: 3, scope: !626, inlinedAt: !652)
!654 = !DILocation(line: 64, column: 23, scope: !617)
!655 = !DILocation(line: 65, column: 3, scope: !656)
!656 = distinct !DILexicalBlock(scope: !617, file: !189, line: 65, column: 3)
!657 = !DILocation(line: 66, column: 19, scope: !658)
!658 = distinct !DILexicalBlock(scope: !659, file: !189, line: 65, column: 28)
!659 = distinct !DILexicalBlock(scope: !656, file: !189, line: 65, column: 3)
!660 = !DILocation(line: 66, column: 34, scope: !658)
!661 = !DILocation(line: 66, column: 12, scope: !658)
!662 = !DILocation(line: 66, column: 5, scope: !658)
!663 = !DILocation(line: 66, column: 17, scope: !658)
!664 = !DILocation(line: 67, column: 34, scope: !658)
!665 = !DILocation(line: 67, column: 14, scope: !658)
!666 = !DILocation(line: 67, column: 5, scope: !658)
!667 = !DILocation(line: 67, column: 17, scope: !658)
!668 = !DILocation(line: 65, column: 24, scope: !659)
!669 = !DILocation(line: 65, column: 13, scope: !659)
!670 = distinct !{!670, !655, !671, !429, !430}
!671 = !DILocation(line: 68, column: 3, scope: !656)
!672 = !DILocation(line: 0, scope: !638, inlinedAt: !673)
!673 = distinct !DILocation(line: 69, column: 3, scope: !617)
!674 = !DILocation(line: 180, column: 1, scope: !648, inlinedAt: !673)
!675 = !DILocation(line: 180, column: 1, scope: !649, inlinedAt: !673)
!676 = !DILocation(line: 180, column: 1, scope: !650, inlinedAt: !673)
!677 = distinct !{!677, !676, !676, !429, !430}
!678 = !DILocation(line: 70, column: 3, scope: !617)
!679 = !DILocation(line: 0, scope: !626, inlinedAt: !680)
!680 = distinct !DILocation(line: 72, column: 3, scope: !617)
!681 = !DILocation(line: 191, column: 3, scope: !626, inlinedAt: !680)
!682 = !DILocation(line: 73, column: 48, scope: !617)
!683 = !DILocation(line: 0, scope: !638, inlinedAt: !684)
!684 = distinct !DILocation(line: 73, column: 3, scope: !617)
!685 = !DILocation(line: 180, column: 1, scope: !650, inlinedAt: !684)
!686 = !DILocation(line: 180, column: 1, scope: !648, inlinedAt: !684)
!687 = !DILocation(line: 180, column: 1, scope: !649, inlinedAt: !684)
!688 = distinct !{!688, !685, !685, !429, !430}
!689 = !DILocation(line: 74, column: 1, scope: !617)
!690 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 81, type: !500, scopeLine: 81, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !691)
!691 = !{!692, !693, !694, !695, !696}
!692 = !DILocalVariable(name: "fd", arg: 1, scope: !690, file: !189, line: 81, type: !233)
!693 = !DILocalVariable(name: "vdata", arg: 2, scope: !690, file: !189, line: 81, type: !260)
!694 = !DILocalVariable(name: "data", scope: !690, file: !189, line: 82, type: !191)
!695 = !DILocalVariable(name: "p", scope: !690, file: !189, line: 83, type: !259)
!696 = !DILocalVariable(name: "s", scope: !690, file: !189, line: 83, type: !259)
!697 = !DILocation(line: 0, scope: !690)
!698 = !DILocation(line: 85, column: 3, scope: !690)
!699 = !DILocation(line: 87, column: 7, scope: !690)
!700 = !DILocation(line: 0, scope: !519, inlinedAt: !701)
!701 = distinct !DILocation(line: 89, column: 7, scope: !690)
!702 = !DILocation(line: 64, column: 17, scope: !519, inlinedAt: !701)
!703 = !DILocation(line: 64, column: 3, scope: !519, inlinedAt: !701)
!704 = !DILocation(line: 66, column: 22, scope: !530, inlinedAt: !701)
!705 = !DILocation(line: 66, column: 26, scope: !530, inlinedAt: !701)
!706 = !DILocation(line: 66, column: 32, scope: !530, inlinedAt: !701)
!707 = !DILocation(line: 66, column: 35, scope: !530, inlinedAt: !701)
!708 = !DILocation(line: 66, column: 39, scope: !530, inlinedAt: !701)
!709 = !DILocation(line: 66, column: 9, scope: !531, inlinedAt: !701)
!710 = !DILocation(line: 69, column: 6, scope: !531, inlinedAt: !701)
!711 = !DILocation(line: 64, column: 10, scope: !519, inlinedAt: !701)
!712 = !DILocation(line: 64, column: 13, scope: !519, inlinedAt: !701)
!713 = distinct !{!713, !703, !714, !429, !430}
!714 = !DILocation(line: 70, column: 3, scope: !519, inlinedAt: !701)
!715 = !DILocation(line: 71, column: 6, scope: !543, inlinedAt: !701)
!716 = !DILocation(line: 71, column: 8, scope: !543, inlinedAt: !701)
!717 = !DILocation(line: 71, column: 6, scope: !519, inlinedAt: !701)
!718 = !DILocation(line: 90, column: 33, scope: !690)
!719 = !DILocation(line: 90, column: 3, scope: !690)
!720 = !DILocation(line: 91, column: 3, scope: !690)
!721 = !DILocation(line: 92, column: 1, scope: !690)
!722 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 94, type: !500, scopeLine: 94, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !723)
!723 = !{!724, !725, !726}
!724 = !DILocalVariable(name: "fd", arg: 1, scope: !722, file: !189, line: 94, type: !233)
!725 = !DILocalVariable(name: "vdata", arg: 2, scope: !722, file: !189, line: 94, type: !260)
!726 = !DILocalVariable(name: "data", scope: !722, file: !189, line: 95, type: !191)
!727 = !DILocation(line: 0, scope: !722)
!728 = !DILocation(line: 0, scope: !626, inlinedAt: !729)
!729 = distinct !DILocation(line: 97, column: 3, scope: !722)
!730 = !DILocation(line: 190, column: 3, scope: !633, inlinedAt: !729)
!731 = !DILocation(line: 191, column: 3, scope: !626, inlinedAt: !729)
!732 = !DILocation(line: 98, column: 34, scope: !722)
!733 = !DILocation(line: 0, scope: !638, inlinedAt: !734)
!734 = distinct !DILocation(line: 98, column: 3, scope: !722)
!735 = !DILocation(line: 180, column: 1, scope: !650, inlinedAt: !734)
!736 = !DILocation(line: 180, column: 1, scope: !648, inlinedAt: !734)
!737 = !DILocation(line: 180, column: 1, scope: !649, inlinedAt: !734)
!738 = distinct !{!738, !735, !735, !429, !430}
!739 = !DILocation(line: 99, column: 1, scope: !722)
!740 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 101, type: !741, scopeLine: 101, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !743)
!741 = !DISubroutineType(types: !742)
!742 = !{!233, !260, !260}
!743 = !{!744, !745, !746, !747, !748, !749}
!744 = !DILocalVariable(name: "vdata", arg: 1, scope: !740, file: !189, line: 101, type: !260)
!745 = !DILocalVariable(name: "vref", arg: 2, scope: !740, file: !189, line: 101, type: !260)
!746 = !DILocalVariable(name: "data", scope: !740, file: !189, line: 102, type: !191)
!747 = !DILocalVariable(name: "ref", scope: !740, file: !189, line: 103, type: !191)
!748 = !DILocalVariable(name: "has_errors", scope: !740, file: !189, line: 104, type: !233)
!749 = !DILocalVariable(name: "i", scope: !740, file: !189, line: 105, type: !233)
!750 = !DILocation(line: 0, scope: !740)
!751 = !DILocation(line: 108, column: 3, scope: !752)
!752 = distinct !DILexicalBlock(scope: !740, file: !189, line: 108, column: 3)
!753 = !DILocation(line: 109, column: 20, scope: !754)
!754 = distinct !DILexicalBlock(scope: !755, file: !189, line: 108, column: 29)
!755 = distinct !DILexicalBlock(scope: !752, file: !189, line: 108, column: 3)
!756 = !DILocation(line: 109, column: 43, scope: !754)
!757 = !DILocation(line: 109, column: 41, scope: !754)
!758 = !DILocation(line: 109, column: 16, scope: !754)
!759 = !DILocation(line: 108, column: 25, scope: !755)
!760 = !DILocation(line: 108, column: 13, scope: !755)
!761 = distinct !{!761, !751, !762, !429, !430}
!762 = !DILocation(line: 110, column: 3, scope: !752)
!763 = !DILocation(line: 113, column: 10, scope: !740)
!764 = !DILocation(line: 113, column: 3, scope: !740)
!765 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !766, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !768)
!766 = !DISubroutineType(types: !767)
!767 = !{!259, !233}
!768 = !{!769, !770, !771, !808, !811, !814}
!769 = !DILocalVariable(name: "fd", arg: 1, scope: !765, file: !2, line: 34, type: !233)
!770 = !DILocalVariable(name: "p", scope: !765, file: !2, line: 35, type: !259)
!771 = !DILocalVariable(name: "s", scope: !765, file: !2, line: 36, type: !772)
!772 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !773, line: 44, size: 1024, elements: !774)
!773 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!774 = !{!775, !777, !779, !781, !783, !785, !787, !788, !789, !791, !793, !794, !796, !804, !805, !806}
!775 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !772, file: !773, line: 46, baseType: !776, size: 64)
!776 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !205, line: 145, baseType: !206)
!777 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !772, file: !773, line: 47, baseType: !778, size: 64, offset: 64)
!778 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !205, line: 148, baseType: !206)
!779 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !772, file: !773, line: 48, baseType: !780, size: 32, offset: 128)
!780 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !205, line: 150, baseType: !269)
!781 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !772, file: !773, line: 49, baseType: !782, size: 32, offset: 160)
!782 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !205, line: 151, baseType: !269)
!783 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !772, file: !773, line: 50, baseType: !784, size: 32, offset: 192)
!784 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !205, line: 146, baseType: !269)
!785 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !772, file: !773, line: 51, baseType: !786, size: 32, offset: 224)
!786 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !205, line: 147, baseType: !269)
!787 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !772, file: !773, line: 52, baseType: !776, size: 64, offset: 256)
!788 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !772, file: !773, line: 53, baseType: !776, size: 64, offset: 320)
!789 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !772, file: !773, line: 54, baseType: !790, size: 64, offset: 384)
!790 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !205, line: 152, baseType: !277)
!791 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !772, file: !773, line: 55, baseType: !792, size: 32, offset: 448)
!792 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !205, line: 175, baseType: !233)
!793 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !772, file: !773, line: 56, baseType: !233, size: 32, offset: 480)
!794 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !772, file: !773, line: 57, baseType: !795, size: 64, offset: 512)
!795 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !205, line: 180, baseType: !277)
!796 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !772, file: !773, line: 65, baseType: !797, size: 128, offset: 576)
!797 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !798, line: 11, size: 128, elements: !799)
!798 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!799 = !{!800, !802}
!800 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !797, file: !798, line: 16, baseType: !801, size: 64)
!801 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !205, line: 160, baseType: !277)
!802 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !797, file: !798, line: 21, baseType: !803, size: 64, offset: 64)
!803 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !205, line: 197, baseType: !277)
!804 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !772, file: !773, line: 66, baseType: !797, size: 128, offset: 704)
!805 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !772, file: !773, line: 67, baseType: !797, size: 128, offset: 832)
!806 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !772, file: !773, line: 79, baseType: !807, size: 64, offset: 960)
!807 = !DICompositeType(tag: DW_TAG_array_type, baseType: !233, size: 64, elements: !55)
!808 = !DILocalVariable(name: "len", scope: !765, file: !2, line: 37, type: !809)
!809 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !810, line: 85, baseType: !790)
!810 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!811 = !DILocalVariable(name: "bytes_read", scope: !765, file: !2, line: 38, type: !812)
!812 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !810, line: 108, baseType: !813)
!813 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !205, line: 194, baseType: !277)
!814 = !DILocalVariable(name: "status", scope: !765, file: !2, line: 38, type: !812)
!815 = distinct !DIAssignID()
!816 = !DILocation(line: 0, scope: !765)
!817 = !DILocation(line: 36, column: 3, scope: !765)
!818 = !DILocation(line: 40, column: 3, scope: !819)
!819 = distinct !DILexicalBlock(scope: !820, file: !2, line: 40, column: 3)
!820 = distinct !DILexicalBlock(scope: !765, file: !2, line: 40, column: 3)
!821 = !DILocation(line: 41, column: 3, scope: !822)
!822 = distinct !DILexicalBlock(scope: !823, file: !2, line: 41, column: 3)
!823 = distinct !DILexicalBlock(scope: !765, file: !2, line: 41, column: 3)
!824 = !DILocation(line: 42, column: 11, scope: !765)
!825 = !DILocation(line: 43, column: 3, scope: !826)
!826 = distinct !DILexicalBlock(scope: !827, file: !2, line: 43, column: 3)
!827 = distinct !DILexicalBlock(scope: !765, file: !2, line: 43, column: 3)
!828 = !DILocation(line: 44, column: 25, scope: !765)
!829 = !DILocation(line: 44, column: 15, scope: !765)
!830 = !DILocation(line: 46, column: 3, scope: !765)
!831 = !DILocation(line: 49, column: 15, scope: !832)
!832 = distinct !DILexicalBlock(scope: !765, file: !2, line: 46, column: 27)
!833 = !DILocation(line: 46, column: 20, scope: !765)
!834 = distinct !{!834, !830, !835, !429, !430}
!835 = !DILocation(line: 50, column: 3, scope: !765)
!836 = !DILocation(line: 47, column: 24, scope: !832)
!837 = !DILocation(line: 47, column: 42, scope: !832)
!838 = !DILocation(line: 47, column: 14, scope: !832)
!839 = !DILocation(line: 48, column: 5, scope: !840)
!840 = distinct !DILexicalBlock(scope: !841, file: !2, line: 48, column: 5)
!841 = distinct !DILexicalBlock(scope: !832, file: !2, line: 48, column: 5)
!842 = !DILocation(line: 51, column: 3, scope: !765)
!843 = !DILocation(line: 51, column: 10, scope: !765)
!844 = !DILocation(line: 52, column: 3, scope: !765)
!845 = !DILocation(line: 54, column: 1, scope: !765)
!846 = !DILocation(line: 53, column: 3, scope: !765)
!847 = !DISubprogram(name: "__assert_fail", scope: !848, file: !848, line: 67, type: !849, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!848 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!849 = !DISubroutineType(types: !850)
!850 = !{null, !851, !851, !269, !851}
!851 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!852 = !DISubprogram(name: "fstat", scope: !853, file: !853, line: 210, type: !854, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!853 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!854 = !DISubroutineType(types: !855)
!855 = !{!233, !233, !856}
!856 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !772, size: 64)
!857 = !DISubprogram(name: "read", scope: !858, file: !858, line: 371, type: !859, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!858 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!859 = !DISubroutineType(types: !860)
!860 = !{!812, !233, !260, !614}
!861 = !DISubprogram(name: "close", scope: !858, file: !858, line: 358, type: !627, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!862 = !DILocation(line: 0, scope: !519)
!863 = !DILocation(line: 59, column: 3, scope: !864)
!864 = distinct !DILexicalBlock(scope: !865, file: !2, line: 59, column: 3)
!865 = distinct !DILexicalBlock(scope: !519, file: !2, line: 59, column: 3)
!866 = !DILocation(line: 60, column: 7, scope: !867)
!867 = distinct !DILexicalBlock(scope: !519, file: !2, line: 60, column: 6)
!868 = !DILocation(line: 60, column: 6, scope: !519)
!869 = !DILocation(line: 64, column: 17, scope: !519)
!870 = !DILocation(line: 64, column: 3, scope: !519)
!871 = !DILocation(line: 66, column: 22, scope: !530)
!872 = !DILocation(line: 66, column: 26, scope: !530)
!873 = !DILocation(line: 66, column: 32, scope: !530)
!874 = !DILocation(line: 66, column: 35, scope: !530)
!875 = !DILocation(line: 66, column: 39, scope: !530)
!876 = !DILocation(line: 66, column: 9, scope: !531)
!877 = !DILocation(line: 69, column: 6, scope: !531)
!878 = !DILocation(line: 64, column: 10, scope: !519)
!879 = !DILocation(line: 64, column: 13, scope: !519)
!880 = distinct !{!880, !870, !881, !429, !430}
!881 = !DILocation(line: 70, column: 3, scope: !519)
!882 = !DILocation(line: 71, column: 6, scope: !543)
!883 = !DILocation(line: 71, column: 8, scope: !543)
!884 = !DILocation(line: 71, column: 6, scope: !519)
!885 = !DILocation(line: 74, column: 1, scope: !519)
!886 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !887, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !889)
!887 = !DISubroutineType(types: !888)
!888 = !{!233, !259, !259, !233}
!889 = !{!890, !891, !892, !893}
!890 = !DILocalVariable(name: "s", arg: 1, scope: !886, file: !2, line: 77, type: !259)
!891 = !DILocalVariable(name: "arr", arg: 2, scope: !886, file: !2, line: 77, type: !259)
!892 = !DILocalVariable(name: "n", arg: 3, scope: !886, file: !2, line: 77, type: !233)
!893 = !DILocalVariable(name: "k", scope: !886, file: !2, line: 78, type: !233)
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
!918 = distinct !{!918, !903, !919, !429, !430}
!919 = !DILocation(line: 86, column: 5, scope: !902)
!920 = !DILocation(line: 93, column: 5, scope: !921)
!921 = distinct !DILexicalBlock(scope: !886, file: !2, line: 92, column: 7)
!922 = !DILocation(line: 93, column: 12, scope: !921)
!923 = !DILocation(line: 95, column: 3, scope: !886)
!924 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !925, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !928)
!925 = !DISubroutineType(types: !926)
!926 = !{!233, !259, !927, !233}
!927 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !261, size: 64)
!928 = !{!929, !930, !931, !932, !933, !934, !935}
!929 = !DILocalVariable(name: "s", arg: 1, scope: !924, file: !2, line: 132, type: !259)
!930 = !DILocalVariable(name: "arr", arg: 2, scope: !924, file: !2, line: 132, type: !927)
!931 = !DILocalVariable(name: "n", arg: 3, scope: !924, file: !2, line: 132, type: !233)
!932 = !DILocalVariable(name: "line", scope: !924, file: !2, line: 132, type: !259)
!933 = !DILocalVariable(name: "endptr", scope: !924, file: !2, line: 132, type: !259)
!934 = !DILocalVariable(name: "i", scope: !924, file: !2, line: 132, type: !233)
!935 = !DILocalVariable(name: "v", scope: !924, file: !2, line: 132, type: !261)
!936 = distinct !DIAssignID()
!937 = !DILocation(line: 0, scope: !924)
!938 = !DILocation(line: 132, column: 1, scope: !924)
!939 = !DILocation(line: 132, column: 1, scope: !940)
!940 = distinct !DILexicalBlock(scope: !941, file: !2, line: 132, column: 1)
!941 = distinct !DILexicalBlock(scope: !924, file: !2, line: 132, column: 1)
!942 = !DILocation(line: 132, column: 1, scope: !943)
!943 = distinct !DILexicalBlock(scope: !924, file: !2, line: 132, column: 1)
!944 = !{!945, !945, i64 0}
!945 = !{!"any pointer", !393, i64 0}
!946 = distinct !DIAssignID()
!947 = !DILocation(line: 132, column: 1, scope: !948)
!948 = distinct !DILexicalBlock(scope: !943, file: !2, line: 132, column: 1)
!949 = !DILocation(line: 132, column: 1, scope: !950)
!950 = distinct !DILexicalBlock(scope: !948, file: !2, line: 132, column: 1)
!951 = distinct !{!951, !938, !938, !429, !430}
!952 = !DILocation(line: 132, column: 1, scope: !953)
!953 = distinct !DILexicalBlock(scope: !954, file: !2, line: 132, column: 1)
!954 = distinct !DILexicalBlock(scope: !924, file: !2, line: 132, column: 1)
!955 = !DISubprogram(name: "strtok", scope: !956, file: !956, line: 356, type: !957, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!956 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!957 = !DISubroutineType(types: !958)
!958 = !{!259, !959, !960}
!959 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !259)
!960 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !851)
!961 = !DISubprogram(name: "strtol", scope: !611, file: !611, line: 177, type: !962, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!962 = !DISubroutineType(types: !963)
!963 = !{!277, !960, !964, !233}
!964 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !965)
!965 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !259, size: 64)
!966 = !DISubprogram(name: "fprintf", scope: !967, file: !967, line: 357, type: !968, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!967 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!968 = !DISubroutineType(types: !969)
!969 = !{!233, !970, !960, null}
!970 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !971)
!971 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !972, size: 64)
!972 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !973, line: 7, baseType: !974)
!973 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!974 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !975, line: 49, size: 1728, elements: !976)
!975 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!976 = !{!977, !978, !979, !980, !981, !982, !983, !984, !985, !986, !987, !988, !989, !992, !994, !995, !996, !997, !998, !999, !1003, !1006, !1008, !1011, !1014, !1015, !1016, !1018, !1019}
!977 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !974, file: !975, line: 51, baseType: !233, size: 32)
!978 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !974, file: !975, line: 54, baseType: !259, size: 64, offset: 64)
!979 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !974, file: !975, line: 55, baseType: !259, size: 64, offset: 128)
!980 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !974, file: !975, line: 56, baseType: !259, size: 64, offset: 192)
!981 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !974, file: !975, line: 57, baseType: !259, size: 64, offset: 256)
!982 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !974, file: !975, line: 58, baseType: !259, size: 64, offset: 320)
!983 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !974, file: !975, line: 59, baseType: !259, size: 64, offset: 384)
!984 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !974, file: !975, line: 60, baseType: !259, size: 64, offset: 448)
!985 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !974, file: !975, line: 61, baseType: !259, size: 64, offset: 512)
!986 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !974, file: !975, line: 64, baseType: !259, size: 64, offset: 576)
!987 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !974, file: !975, line: 65, baseType: !259, size: 64, offset: 640)
!988 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !974, file: !975, line: 66, baseType: !259, size: 64, offset: 704)
!989 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !974, file: !975, line: 68, baseType: !990, size: 64, offset: 768)
!990 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !991, size: 64)
!991 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !975, line: 36, flags: DIFlagFwdDecl)
!992 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !974, file: !975, line: 70, baseType: !993, size: 64, offset: 832)
!993 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !974, size: 64)
!994 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !974, file: !975, line: 72, baseType: !233, size: 32, offset: 896)
!995 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !974, file: !975, line: 73, baseType: !233, size: 32, offset: 928)
!996 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !974, file: !975, line: 74, baseType: !790, size: 64, offset: 960)
!997 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !974, file: !975, line: 77, baseType: !266, size: 16, offset: 1024)
!998 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !974, file: !975, line: 78, baseType: !226, size: 8, offset: 1040)
!999 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !974, file: !975, line: 79, baseType: !1000, size: 8, offset: 1048)
!1000 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !1001)
!1001 = !{!1002}
!1002 = !DISubrange(count: 1)
!1003 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !974, file: !975, line: 81, baseType: !1004, size: 64, offset: 1088)
!1004 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1005, size: 64)
!1005 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !975, line: 43, baseType: null)
!1006 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !974, file: !975, line: 89, baseType: !1007, size: 64, offset: 1152)
!1007 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !205, line: 153, baseType: !277)
!1008 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !974, file: !975, line: 91, baseType: !1009, size: 64, offset: 1216)
!1009 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1010, size: 64)
!1010 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !975, line: 37, flags: DIFlagFwdDecl)
!1011 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !974, file: !975, line: 92, baseType: !1012, size: 64, offset: 1280)
!1012 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1013, size: 64)
!1013 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !975, line: 38, flags: DIFlagFwdDecl)
!1014 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !974, file: !975, line: 93, baseType: !993, size: 64, offset: 1344)
!1015 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !974, file: !975, line: 94, baseType: !260, size: 64, offset: 1408)
!1016 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !974, file: !975, line: 95, baseType: !1017, size: 64, offset: 1472)
!1017 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !993, size: 64)
!1018 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !974, file: !975, line: 96, baseType: !233, size: 32, offset: 1536)
!1019 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !974, file: !975, line: 98, baseType: !1020, size: 160, offset: 1568)
!1020 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!1021 = !DISubprogram(name: "strlen", scope: !956, file: !956, line: 407, type: !1022, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1022 = !DISubroutineType(types: !1023)
!1023 = !{!206, !851}
!1024 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !1025, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1028)
!1025 = !DISubroutineType(types: !1026)
!1026 = !{!233, !259, !1027, !233}
!1027 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !264, size: 64)
!1028 = !{!1029, !1030, !1031, !1032, !1033, !1034, !1035}
!1029 = !DILocalVariable(name: "s", arg: 1, scope: !1024, file: !2, line: 133, type: !259)
!1030 = !DILocalVariable(name: "arr", arg: 2, scope: !1024, file: !2, line: 133, type: !1027)
!1031 = !DILocalVariable(name: "n", arg: 3, scope: !1024, file: !2, line: 133, type: !233)
!1032 = !DILocalVariable(name: "line", scope: !1024, file: !2, line: 133, type: !259)
!1033 = !DILocalVariable(name: "endptr", scope: !1024, file: !2, line: 133, type: !259)
!1034 = !DILocalVariable(name: "i", scope: !1024, file: !2, line: 133, type: !233)
!1035 = !DILocalVariable(name: "v", scope: !1024, file: !2, line: 133, type: !264)
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
!1050 = !{!"short", !393, i64 0}
!1051 = distinct !{!1051, !1038, !1038, !429, !430}
!1052 = !DILocation(line: 133, column: 1, scope: !1053)
!1053 = distinct !DILexicalBlock(scope: !1054, file: !2, line: 133, column: 1)
!1054 = distinct !DILexicalBlock(scope: !1024, file: !2, line: 133, column: 1)
!1055 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !1056, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1059)
!1056 = !DISubroutineType(types: !1057)
!1057 = !{!233, !259, !1058, !233}
!1058 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !267, size: 64)
!1059 = !{!1060, !1061, !1062, !1063, !1064, !1065, !1066}
!1060 = !DILocalVariable(name: "s", arg: 1, scope: !1055, file: !2, line: 134, type: !259)
!1061 = !DILocalVariable(name: "arr", arg: 2, scope: !1055, file: !2, line: 134, type: !1058)
!1062 = !DILocalVariable(name: "n", arg: 3, scope: !1055, file: !2, line: 134, type: !233)
!1063 = !DILocalVariable(name: "line", scope: !1055, file: !2, line: 134, type: !259)
!1064 = !DILocalVariable(name: "endptr", scope: !1055, file: !2, line: 134, type: !259)
!1065 = !DILocalVariable(name: "i", scope: !1055, file: !2, line: 134, type: !233)
!1066 = !DILocalVariable(name: "v", scope: !1055, file: !2, line: 134, type: !267)
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
!1080 = !{!1081, !1081, i64 0}
!1081 = !{!"int", !393, i64 0}
!1082 = distinct !{!1082, !1069, !1069, !429, !430}
!1083 = !DILocation(line: 134, column: 1, scope: !1084)
!1084 = distinct !DILexicalBlock(scope: !1085, file: !2, line: 134, column: 1)
!1085 = distinct !DILexicalBlock(scope: !1055, file: !2, line: 134, column: 1)
!1086 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !1087, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1089)
!1087 = !DISubroutineType(types: !1088)
!1088 = !{!233, !259, !231, !233}
!1089 = !{!1090, !1091, !1092, !1093, !1094, !1095, !1096}
!1090 = !DILocalVariable(name: "s", arg: 1, scope: !1086, file: !2, line: 135, type: !259)
!1091 = !DILocalVariable(name: "arr", arg: 2, scope: !1086, file: !2, line: 135, type: !231)
!1092 = !DILocalVariable(name: "n", arg: 3, scope: !1086, file: !2, line: 135, type: !233)
!1093 = !DILocalVariable(name: "line", scope: !1086, file: !2, line: 135, type: !259)
!1094 = !DILocalVariable(name: "endptr", scope: !1086, file: !2, line: 135, type: !259)
!1095 = !DILocalVariable(name: "i", scope: !1086, file: !2, line: 135, type: !233)
!1096 = !DILocalVariable(name: "v", scope: !1086, file: !2, line: 135, type: !202)
!1097 = distinct !DIAssignID()
!1098 = !DILocation(line: 0, scope: !1086)
!1099 = !DILocation(line: 135, column: 1, scope: !1086)
!1100 = !DILocation(line: 135, column: 1, scope: !1101)
!1101 = distinct !DILexicalBlock(scope: !1102, file: !2, line: 135, column: 1)
!1102 = distinct !DILexicalBlock(scope: !1086, file: !2, line: 135, column: 1)
!1103 = !DILocation(line: 135, column: 1, scope: !1104)
!1104 = distinct !DILexicalBlock(scope: !1086, file: !2, line: 135, column: 1)
!1105 = distinct !DIAssignID()
!1106 = !DILocation(line: 135, column: 1, scope: !1107)
!1107 = distinct !DILexicalBlock(scope: !1104, file: !2, line: 135, column: 1)
!1108 = !DILocation(line: 135, column: 1, scope: !1109)
!1109 = distinct !DILexicalBlock(scope: !1107, file: !2, line: 135, column: 1)
!1110 = distinct !{!1110, !1099, !1099, !429, !430}
!1111 = !DILocation(line: 135, column: 1, scope: !1112)
!1112 = distinct !DILexicalBlock(scope: !1113, file: !2, line: 135, column: 1)
!1113 = distinct !DILexicalBlock(scope: !1086, file: !2, line: 135, column: 1)
!1114 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1115, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1118)
!1115 = !DISubroutineType(types: !1116)
!1116 = !{!233, !259, !1117, !233}
!1117 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !223, size: 64)
!1118 = !{!1119, !1120, !1121, !1122, !1123, !1124, !1125}
!1119 = !DILocalVariable(name: "s", arg: 1, scope: !1114, file: !2, line: 136, type: !259)
!1120 = !DILocalVariable(name: "arr", arg: 2, scope: !1114, file: !2, line: 136, type: !1117)
!1121 = !DILocalVariable(name: "n", arg: 3, scope: !1114, file: !2, line: 136, type: !233)
!1122 = !DILocalVariable(name: "line", scope: !1114, file: !2, line: 136, type: !259)
!1123 = !DILocalVariable(name: "endptr", scope: !1114, file: !2, line: 136, type: !259)
!1124 = !DILocalVariable(name: "i", scope: !1114, file: !2, line: 136, type: !233)
!1125 = !DILocalVariable(name: "v", scope: !1114, file: !2, line: 136, type: !223)
!1126 = distinct !DIAssignID()
!1127 = !DILocation(line: 0, scope: !1114)
!1128 = !DILocation(line: 136, column: 1, scope: !1114)
!1129 = !DILocation(line: 136, column: 1, scope: !1130)
!1130 = distinct !DILexicalBlock(scope: !1131, file: !2, line: 136, column: 1)
!1131 = distinct !DILexicalBlock(scope: !1114, file: !2, line: 136, column: 1)
!1132 = !DILocation(line: 136, column: 1, scope: !1133)
!1133 = distinct !DILexicalBlock(scope: !1114, file: !2, line: 136, column: 1)
!1134 = distinct !DIAssignID()
!1135 = !DILocation(line: 136, column: 1, scope: !1136)
!1136 = distinct !DILexicalBlock(scope: !1133, file: !2, line: 136, column: 1)
!1137 = !DILocation(line: 136, column: 1, scope: !1138)
!1138 = distinct !DILexicalBlock(scope: !1136, file: !2, line: 136, column: 1)
!1139 = distinct !{!1139, !1128, !1128, !429, !430}
!1140 = !DILocation(line: 136, column: 1, scope: !1141)
!1141 = distinct !DILexicalBlock(scope: !1142, file: !2, line: 136, column: 1)
!1142 = distinct !DILexicalBlock(scope: !1114, file: !2, line: 136, column: 1)
!1143 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1144, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1147)
!1144 = !DISubroutineType(types: !1145)
!1145 = !{!233, !259, !1146, !233}
!1146 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !270, size: 64)
!1147 = !{!1148, !1149, !1150, !1151, !1152, !1153, !1154}
!1148 = !DILocalVariable(name: "s", arg: 1, scope: !1143, file: !2, line: 137, type: !259)
!1149 = !DILocalVariable(name: "arr", arg: 2, scope: !1143, file: !2, line: 137, type: !1146)
!1150 = !DILocalVariable(name: "n", arg: 3, scope: !1143, file: !2, line: 137, type: !233)
!1151 = !DILocalVariable(name: "line", scope: !1143, file: !2, line: 137, type: !259)
!1152 = !DILocalVariable(name: "endptr", scope: !1143, file: !2, line: 137, type: !259)
!1153 = !DILocalVariable(name: "i", scope: !1143, file: !2, line: 137, type: !233)
!1154 = !DILocalVariable(name: "v", scope: !1143, file: !2, line: 137, type: !270)
!1155 = distinct !DIAssignID()
!1156 = !DILocation(line: 0, scope: !1143)
!1157 = !DILocation(line: 137, column: 1, scope: !1143)
!1158 = !DILocation(line: 137, column: 1, scope: !1159)
!1159 = distinct !DILexicalBlock(scope: !1160, file: !2, line: 137, column: 1)
!1160 = distinct !DILexicalBlock(scope: !1143, file: !2, line: 137, column: 1)
!1161 = !DILocation(line: 137, column: 1, scope: !1162)
!1162 = distinct !DILexicalBlock(scope: !1143, file: !2, line: 137, column: 1)
!1163 = distinct !DIAssignID()
!1164 = !DILocation(line: 137, column: 1, scope: !1165)
!1165 = distinct !DILexicalBlock(scope: !1162, file: !2, line: 137, column: 1)
!1166 = !DILocation(line: 137, column: 1, scope: !1167)
!1167 = distinct !DILexicalBlock(scope: !1165, file: !2, line: 137, column: 1)
!1168 = distinct !{!1168, !1157, !1157, !429, !430}
!1169 = !DILocation(line: 137, column: 1, scope: !1170)
!1170 = distinct !DILexicalBlock(scope: !1171, file: !2, line: 137, column: 1)
!1171 = distinct !DILexicalBlock(scope: !1143, file: !2, line: 137, column: 1)
!1172 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1173, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1176)
!1173 = !DISubroutineType(types: !1174)
!1174 = !{!233, !259, !1175, !233}
!1175 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !273, size: 64)
!1176 = !{!1177, !1178, !1179, !1180, !1181, !1182, !1183}
!1177 = !DILocalVariable(name: "s", arg: 1, scope: !1172, file: !2, line: 138, type: !259)
!1178 = !DILocalVariable(name: "arr", arg: 2, scope: !1172, file: !2, line: 138, type: !1175)
!1179 = !DILocalVariable(name: "n", arg: 3, scope: !1172, file: !2, line: 138, type: !233)
!1180 = !DILocalVariable(name: "line", scope: !1172, file: !2, line: 138, type: !259)
!1181 = !DILocalVariable(name: "endptr", scope: !1172, file: !2, line: 138, type: !259)
!1182 = !DILocalVariable(name: "i", scope: !1172, file: !2, line: 138, type: !233)
!1183 = !DILocalVariable(name: "v", scope: !1172, file: !2, line: 138, type: !273)
!1184 = distinct !DIAssignID()
!1185 = !DILocation(line: 0, scope: !1172)
!1186 = !DILocation(line: 138, column: 1, scope: !1172)
!1187 = !DILocation(line: 138, column: 1, scope: !1188)
!1188 = distinct !DILexicalBlock(scope: !1189, file: !2, line: 138, column: 1)
!1189 = distinct !DILexicalBlock(scope: !1172, file: !2, line: 138, column: 1)
!1190 = !DILocation(line: 138, column: 1, scope: !1191)
!1191 = distinct !DILexicalBlock(scope: !1172, file: !2, line: 138, column: 1)
!1192 = distinct !DIAssignID()
!1193 = !DILocation(line: 138, column: 1, scope: !1194)
!1194 = distinct !DILexicalBlock(scope: !1191, file: !2, line: 138, column: 1)
!1195 = !DILocation(line: 138, column: 1, scope: !1196)
!1196 = distinct !DILexicalBlock(scope: !1194, file: !2, line: 138, column: 1)
!1197 = distinct !{!1197, !1186, !1186, !429, !430}
!1198 = !DILocation(line: 138, column: 1, scope: !1199)
!1199 = distinct !DILexicalBlock(scope: !1200, file: !2, line: 138, column: 1)
!1200 = distinct !DILexicalBlock(scope: !1172, file: !2, line: 138, column: 1)
!1201 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1202, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1205)
!1202 = !DISubroutineType(types: !1203)
!1203 = !{!233, !259, !1204, !233}
!1204 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !275, size: 64)
!1205 = !{!1206, !1207, !1208, !1209, !1210, !1211, !1212}
!1206 = !DILocalVariable(name: "s", arg: 1, scope: !1201, file: !2, line: 139, type: !259)
!1207 = !DILocalVariable(name: "arr", arg: 2, scope: !1201, file: !2, line: 139, type: !1204)
!1208 = !DILocalVariable(name: "n", arg: 3, scope: !1201, file: !2, line: 139, type: !233)
!1209 = !DILocalVariable(name: "line", scope: !1201, file: !2, line: 139, type: !259)
!1210 = !DILocalVariable(name: "endptr", scope: !1201, file: !2, line: 139, type: !259)
!1211 = !DILocalVariable(name: "i", scope: !1201, file: !2, line: 139, type: !233)
!1212 = !DILocalVariable(name: "v", scope: !1201, file: !2, line: 139, type: !275)
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
!1226 = distinct !{!1226, !1215, !1215, !429, !430}
!1227 = !DILocation(line: 139, column: 1, scope: !1228)
!1228 = distinct !DILexicalBlock(scope: !1229, file: !2, line: 139, column: 1)
!1229 = distinct !DILexicalBlock(scope: !1201, file: !2, line: 139, column: 1)
!1230 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1231, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1234)
!1231 = !DISubroutineType(types: !1232)
!1232 = !{!233, !259, !1233, !233}
!1233 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !278, size: 64)
!1234 = !{!1235, !1236, !1237, !1238, !1239, !1240, !1241}
!1235 = !DILocalVariable(name: "s", arg: 1, scope: !1230, file: !2, line: 141, type: !259)
!1236 = !DILocalVariable(name: "arr", arg: 2, scope: !1230, file: !2, line: 141, type: !1233)
!1237 = !DILocalVariable(name: "n", arg: 3, scope: !1230, file: !2, line: 141, type: !233)
!1238 = !DILocalVariable(name: "line", scope: !1230, file: !2, line: 141, type: !259)
!1239 = !DILocalVariable(name: "endptr", scope: !1230, file: !2, line: 141, type: !259)
!1240 = !DILocalVariable(name: "i", scope: !1230, file: !2, line: 141, type: !233)
!1241 = !DILocalVariable(name: "v", scope: !1230, file: !2, line: 141, type: !278)
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
!1256 = !{!"float", !393, i64 0}
!1257 = distinct !{!1257, !1244, !1244, !429, !430}
!1258 = !DILocation(line: 141, column: 1, scope: !1259)
!1259 = distinct !DILexicalBlock(scope: !1260, file: !2, line: 141, column: 1)
!1260 = distinct !DILexicalBlock(scope: !1230, file: !2, line: 141, column: 1)
!1261 = !DISubprogram(name: "strtof", scope: !611, file: !611, line: 124, type: !1262, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1262 = !DISubroutineType(types: !1263)
!1263 = !{!278, !960, !964}
!1264 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1265, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1268)
!1265 = !DISubroutineType(types: !1266)
!1266 = !{!233, !259, !1267, !233}
!1267 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !279, size: 64)
!1268 = !{!1269, !1270, !1271, !1272, !1273, !1274, !1275}
!1269 = !DILocalVariable(name: "s", arg: 1, scope: !1264, file: !2, line: 142, type: !259)
!1270 = !DILocalVariable(name: "arr", arg: 2, scope: !1264, file: !2, line: 142, type: !1267)
!1271 = !DILocalVariable(name: "n", arg: 3, scope: !1264, file: !2, line: 142, type: !233)
!1272 = !DILocalVariable(name: "line", scope: !1264, file: !2, line: 142, type: !259)
!1273 = !DILocalVariable(name: "endptr", scope: !1264, file: !2, line: 142, type: !259)
!1274 = !DILocalVariable(name: "i", scope: !1264, file: !2, line: 142, type: !233)
!1275 = !DILocalVariable(name: "v", scope: !1264, file: !2, line: 142, type: !279)
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
!1290 = !{!"double", !393, i64 0}
!1291 = distinct !{!1291, !1278, !1278, !429, !430}
!1292 = !DILocation(line: 142, column: 1, scope: !1293)
!1293 = distinct !DILexicalBlock(scope: !1294, file: !2, line: 142, column: 1)
!1294 = distinct !DILexicalBlock(scope: !1264, file: !2, line: 142, column: 1)
!1295 = !DISubprogram(name: "strtod", scope: !611, file: !611, line: 118, type: !1296, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1296 = !DISubroutineType(types: !1297)
!1297 = !{!279, !960, !964}
!1298 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1299, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1301)
!1299 = !DISubroutineType(types: !1300)
!1300 = !{!233, !233, !259, !233}
!1301 = !{!1302, !1303, !1304, !1305, !1306}
!1302 = !DILocalVariable(name: "fd", arg: 1, scope: !1298, file: !2, line: 145, type: !233)
!1303 = !DILocalVariable(name: "arr", arg: 2, scope: !1298, file: !2, line: 145, type: !259)
!1304 = !DILocalVariable(name: "n", arg: 3, scope: !1298, file: !2, line: 145, type: !233)
!1305 = !DILocalVariable(name: "status", scope: !1298, file: !2, line: 146, type: !233)
!1306 = !DILocalVariable(name: "written", scope: !1298, file: !2, line: 146, type: !233)
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
!1322 = distinct !{!1322, !1318, !1323, !429, !430}
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
!1338 = distinct !{!1338, !1319, !1339, !429, !430}
!1339 = !DILocation(line: 161, column: 20, scope: !1298)
!1340 = !DILocation(line: 163, column: 3, scope: !1298)
!1341 = !DISubprogram(name: "write", scope: !858, file: !858, line: 378, type: !1342, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1342 = !DISubroutineType(types: !1343)
!1343 = !{!812, !233, !1344, !614}
!1344 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1345, size: 64)
!1345 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1346 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1347, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1349)
!1347 = !DISubroutineType(types: !1348)
!1348 = !{!233, !233, !927, !233}
!1349 = !{!1350, !1351, !1352, !1353}
!1350 = !DILocalVariable(name: "fd", arg: 1, scope: !1346, file: !2, line: 177, type: !233)
!1351 = !DILocalVariable(name: "arr", arg: 2, scope: !1346, file: !2, line: 177, type: !927)
!1352 = !DILocalVariable(name: "n", arg: 3, scope: !1346, file: !2, line: 177, type: !233)
!1353 = !DILocalVariable(name: "i", scope: !1346, file: !2, line: 177, type: !233)
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
!1364 = distinct !{!1364, !1361, !1361, !429, !430}
!1365 = !DILocation(line: 177, column: 1, scope: !1346)
!1366 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1367, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1369)
!1367 = !DISubroutineType(cc: DW_CC_nocall, types: !1368)
!1368 = !{!233, !233, !851, null}
!1369 = !{!1370, !1371, !1372, !1376, !1377, !1378, !1379}
!1370 = !DILocalVariable(name: "fd", arg: 1, scope: !1366, file: !2, line: 15, type: !233)
!1371 = !DILocalVariable(name: "format", arg: 2, scope: !1366, file: !2, line: 15, type: !851)
!1372 = !DILocalVariable(name: "args", scope: !1366, file: !2, line: 16, type: !1373)
!1373 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1374, line: 12, baseType: !1375)
!1374 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1375 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !260)
!1376 = !DILocalVariable(name: "buffered", scope: !1366, file: !2, line: 17, type: !233)
!1377 = !DILocalVariable(name: "written", scope: !1366, file: !2, line: 17, type: !233)
!1378 = !DILocalVariable(name: "status", scope: !1366, file: !2, line: 17, type: !233)
!1379 = !DILocalVariable(name: "buffer", scope: !1366, file: !2, line: 18, type: !1380)
!1380 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !208)
!1381 = distinct !DIAssignID()
!1382 = !DILocation(line: 0, scope: !1366)
!1383 = distinct !DIAssignID()
!1384 = !DILocation(line: 16, column: 3, scope: !1366)
!1385 = !DILocation(line: 18, column: 3, scope: !1366)
!1386 = !DILocation(line: 19, column: 3, scope: !1366)
!1387 = !DILocation(line: 20, column: 66, scope: !1366)
!1388 = !DILocation(line: 20, column: 14, scope: !1366)
!1389 = !DILocation(line: 21, column: 3, scope: !1366)
!1390 = !DILocation(line: 22, column: 3, scope: !1391)
!1391 = distinct !DILexicalBlock(scope: !1392, file: !2, line: 22, column: 3)
!1392 = distinct !DILexicalBlock(scope: !1366, file: !2, line: 22, column: 3)
!1393 = !DILocation(line: 24, column: 16, scope: !1366)
!1394 = !DILocation(line: 24, column: 3, scope: !1366)
!1395 = !DILocation(line: 27, column: 13, scope: !1396)
!1396 = distinct !DILexicalBlock(scope: !1366, file: !2, line: 24, column: 27)
!1397 = distinct !{!1397, !1394, !1398, !429, !430}
!1398 = !DILocation(line: 28, column: 3, scope: !1366)
!1399 = !DILocation(line: 25, column: 25, scope: !1396)
!1400 = !DILocation(line: 25, column: 50, scope: !1396)
!1401 = !DILocation(line: 25, column: 42, scope: !1396)
!1402 = !DILocation(line: 25, column: 14, scope: !1396)
!1403 = !DILocation(line: 26, column: 5, scope: !1404)
!1404 = distinct !DILexicalBlock(scope: !1405, file: !2, line: 26, column: 5)
!1405 = distinct !DILexicalBlock(scope: !1396, file: !2, line: 26, column: 5)
!1406 = !DILocation(line: 29, column: 3, scope: !1407)
!1407 = distinct !DILexicalBlock(scope: !1408, file: !2, line: 29, column: 3)
!1408 = distinct !DILexicalBlock(scope: !1366, file: !2, line: 29, column: 3)
!1409 = !DILocation(line: 31, column: 1, scope: !1366)
!1410 = !DILocation(line: 30, column: 3, scope: !1366)
!1411 = !DISubprogram(name: "vsnprintf", scope: !967, file: !967, line: 389, type: !1412, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1412 = !DISubroutineType(types: !1413)
!1413 = !{!233, !959, !614, !960, !1414}
!1414 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1415, line: 12, baseType: !1375)
!1415 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1416 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1417, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1419)
!1417 = !DISubroutineType(types: !1418)
!1418 = !{!233, !233, !1027, !233}
!1419 = !{!1420, !1421, !1422, !1423}
!1420 = !DILocalVariable(name: "fd", arg: 1, scope: !1416, file: !2, line: 178, type: !233)
!1421 = !DILocalVariable(name: "arr", arg: 2, scope: !1416, file: !2, line: 178, type: !1027)
!1422 = !DILocalVariable(name: "n", arg: 3, scope: !1416, file: !2, line: 178, type: !233)
!1423 = !DILocalVariable(name: "i", scope: !1416, file: !2, line: 178, type: !233)
!1424 = !DILocation(line: 0, scope: !1416)
!1425 = !DILocation(line: 178, column: 1, scope: !1426)
!1426 = distinct !DILexicalBlock(scope: !1427, file: !2, line: 178, column: 1)
!1427 = distinct !DILexicalBlock(scope: !1416, file: !2, line: 178, column: 1)
!1428 = !DILocation(line: 178, column: 1, scope: !1429)
!1429 = distinct !DILexicalBlock(scope: !1430, file: !2, line: 178, column: 1)
!1430 = distinct !DILexicalBlock(scope: !1416, file: !2, line: 178, column: 1)
!1431 = !DILocation(line: 178, column: 1, scope: !1430)
!1432 = !DILocation(line: 178, column: 1, scope: !1433)
!1433 = distinct !DILexicalBlock(scope: !1429, file: !2, line: 178, column: 1)
!1434 = distinct !{!1434, !1431, !1431, !429, !430}
!1435 = !DILocation(line: 178, column: 1, scope: !1416)
!1436 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1437, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1439)
!1437 = !DISubroutineType(types: !1438)
!1438 = !{!233, !233, !1058, !233}
!1439 = !{!1440, !1441, !1442, !1443}
!1440 = !DILocalVariable(name: "fd", arg: 1, scope: !1436, file: !2, line: 179, type: !233)
!1441 = !DILocalVariable(name: "arr", arg: 2, scope: !1436, file: !2, line: 179, type: !1058)
!1442 = !DILocalVariable(name: "n", arg: 3, scope: !1436, file: !2, line: 179, type: !233)
!1443 = !DILocalVariable(name: "i", scope: !1436, file: !2, line: 179, type: !233)
!1444 = !DILocation(line: 0, scope: !1436)
!1445 = !DILocation(line: 179, column: 1, scope: !1446)
!1446 = distinct !DILexicalBlock(scope: !1447, file: !2, line: 179, column: 1)
!1447 = distinct !DILexicalBlock(scope: !1436, file: !2, line: 179, column: 1)
!1448 = !DILocation(line: 179, column: 1, scope: !1449)
!1449 = distinct !DILexicalBlock(scope: !1450, file: !2, line: 179, column: 1)
!1450 = distinct !DILexicalBlock(scope: !1436, file: !2, line: 179, column: 1)
!1451 = !DILocation(line: 179, column: 1, scope: !1450)
!1452 = !DILocation(line: 179, column: 1, scope: !1453)
!1453 = distinct !DILexicalBlock(scope: !1449, file: !2, line: 179, column: 1)
!1454 = distinct !{!1454, !1451, !1451, !429, !430}
!1455 = !DILocation(line: 179, column: 1, scope: !1436)
!1456 = !DILocation(line: 0, scope: !638)
!1457 = !DILocation(line: 180, column: 1, scope: !1458)
!1458 = distinct !DILexicalBlock(scope: !1459, file: !2, line: 180, column: 1)
!1459 = distinct !DILexicalBlock(scope: !638, file: !2, line: 180, column: 1)
!1460 = !DILocation(line: 180, column: 1, scope: !649)
!1461 = !DILocation(line: 180, column: 1, scope: !650)
!1462 = !DILocation(line: 180, column: 1, scope: !648)
!1463 = distinct !{!1463, !1461, !1461, !429, !430}
!1464 = !DILocation(line: 180, column: 1, scope: !638)
!1465 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1466, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1468)
!1466 = !DISubroutineType(types: !1467)
!1467 = !{!233, !233, !1117, !233}
!1468 = !{!1469, !1470, !1471, !1472}
!1469 = !DILocalVariable(name: "fd", arg: 1, scope: !1465, file: !2, line: 181, type: !233)
!1470 = !DILocalVariable(name: "arr", arg: 2, scope: !1465, file: !2, line: 181, type: !1117)
!1471 = !DILocalVariable(name: "n", arg: 3, scope: !1465, file: !2, line: 181, type: !233)
!1472 = !DILocalVariable(name: "i", scope: !1465, file: !2, line: 181, type: !233)
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
!1483 = distinct !{!1483, !1480, !1480, !429, !430}
!1484 = !DILocation(line: 181, column: 1, scope: !1465)
!1485 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1486, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1488)
!1486 = !DISubroutineType(types: !1487)
!1487 = !{!233, !233, !1146, !233}
!1488 = !{!1489, !1490, !1491, !1492}
!1489 = !DILocalVariable(name: "fd", arg: 1, scope: !1485, file: !2, line: 182, type: !233)
!1490 = !DILocalVariable(name: "arr", arg: 2, scope: !1485, file: !2, line: 182, type: !1146)
!1491 = !DILocalVariable(name: "n", arg: 3, scope: !1485, file: !2, line: 182, type: !233)
!1492 = !DILocalVariable(name: "i", scope: !1485, file: !2, line: 182, type: !233)
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
!1503 = distinct !{!1503, !1500, !1500, !429, !430}
!1504 = !DILocation(line: 182, column: 1, scope: !1485)
!1505 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !1506, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1508)
!1506 = !DISubroutineType(types: !1507)
!1507 = !{!233, !233, !1175, !233}
!1508 = !{!1509, !1510, !1511, !1512}
!1509 = !DILocalVariable(name: "fd", arg: 1, scope: !1505, file: !2, line: 183, type: !233)
!1510 = !DILocalVariable(name: "arr", arg: 2, scope: !1505, file: !2, line: 183, type: !1175)
!1511 = !DILocalVariable(name: "n", arg: 3, scope: !1505, file: !2, line: 183, type: !233)
!1512 = !DILocalVariable(name: "i", scope: !1505, file: !2, line: 183, type: !233)
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
!1523 = distinct !{!1523, !1520, !1520, !429, !430}
!1524 = !DILocation(line: 183, column: 1, scope: !1505)
!1525 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1526, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1528)
!1526 = !DISubroutineType(types: !1527)
!1527 = !{!233, !233, !1204, !233}
!1528 = !{!1529, !1530, !1531, !1532}
!1529 = !DILocalVariable(name: "fd", arg: 1, scope: !1525, file: !2, line: 184, type: !233)
!1530 = !DILocalVariable(name: "arr", arg: 2, scope: !1525, file: !2, line: 184, type: !1204)
!1531 = !DILocalVariable(name: "n", arg: 3, scope: !1525, file: !2, line: 184, type: !233)
!1532 = !DILocalVariable(name: "i", scope: !1525, file: !2, line: 184, type: !233)
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
!1543 = distinct !{!1543, !1540, !1540, !429, !430}
!1544 = !DILocation(line: 184, column: 1, scope: !1525)
!1545 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1546, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1548)
!1546 = !DISubroutineType(types: !1547)
!1547 = !{!233, !233, !1233, !233}
!1548 = !{!1549, !1550, !1551, !1552}
!1549 = !DILocalVariable(name: "fd", arg: 1, scope: !1545, file: !2, line: 186, type: !233)
!1550 = !DILocalVariable(name: "arr", arg: 2, scope: !1545, file: !2, line: 186, type: !1233)
!1551 = !DILocalVariable(name: "n", arg: 3, scope: !1545, file: !2, line: 186, type: !233)
!1552 = !DILocalVariable(name: "i", scope: !1545, file: !2, line: 186, type: !233)
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
!1563 = distinct !{!1563, !1560, !1560, !429, !430}
!1564 = !DILocation(line: 186, column: 1, scope: !1545)
!1565 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !1566, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !257, retainedNodes: !1568)
!1566 = !DISubroutineType(types: !1567)
!1567 = !{!233, !233, !1267, !233}
!1568 = !{!1569, !1570, !1571, !1572}
!1569 = !DILocalVariable(name: "fd", arg: 1, scope: !1565, file: !2, line: 187, type: !233)
!1570 = !DILocalVariable(name: "arr", arg: 2, scope: !1565, file: !2, line: 187, type: !1267)
!1571 = !DILocalVariable(name: "n", arg: 3, scope: !1565, file: !2, line: 187, type: !233)
!1572 = !DILocalVariable(name: "i", scope: !1565, file: !2, line: 187, type: !233)
!1573 = !DILocation(line: 0, scope: !1565)
!1574 = !DILocation(line: 187, column: 1, scope: !1575)
!1575 = distinct !DILexicalBlock(scope: !1576, file: !2, line: 187, column: 1)
!1576 = distinct !DILexicalBlock(scope: !1565, file: !2, line: 187, column: 1)
!1577 = !DILocation(line: 187, column: 1, scope: !1578)
!1578 = distinct !DILexicalBlock(scope: !1579, file: !2, line: 187, column: 1)
!1579 = distinct !DILexicalBlock(scope: !1565, file: !2, line: 187, column: 1)
!1580 = !DILocation(line: 187, column: 1, scope: !1579)
!1581 = !DILocation(line: 187, column: 1, scope: !1582)
!1582 = distinct !DILexicalBlock(scope: !1578, file: !2, line: 187, column: 1)
!1583 = distinct !{!1583, !1580, !1580, !429, !430}
!1584 = !DILocation(line: 187, column: 1, scope: !1565)
!1585 = !DILocation(line: 0, scope: !626)
!1586 = !DILocation(line: 190, column: 3, scope: !633)
!1587 = !DILocation(line: 191, column: 3, scope: !626)
!1588 = !DILocation(line: 192, column: 3, scope: !626)
!1589 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1590, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !314, retainedNodes: !1592)
!1590 = !DISubroutineType(types: !1591)
!1591 = !{!233, !233, !965}
!1592 = !{!1593, !1594, !1595, !1596, !1597, !1598, !1599, !1600, !1601}
!1593 = !DILocalVariable(name: "argc", arg: 1, scope: !1589, file: !170, line: 14, type: !233)
!1594 = !DILocalVariable(name: "argv", arg: 2, scope: !1589, file: !170, line: 14, type: !965)
!1595 = !DILocalVariable(name: "in_file", scope: !1589, file: !170, line: 17, type: !259)
!1596 = !DILocalVariable(name: "check_file", scope: !1589, file: !170, line: 19, type: !259)
!1597 = !DILocalVariable(name: "in_fd", scope: !1589, file: !170, line: 34, type: !233)
!1598 = !DILocalVariable(name: "data", scope: !1589, file: !170, line: 35, type: !259)
!1599 = !DILocalVariable(name: "out_fd", scope: !1589, file: !170, line: 46, type: !233)
!1600 = !DILocalVariable(name: "check_fd", scope: !1589, file: !170, line: 55, type: !233)
!1601 = !DILocalVariable(name: "ref", scope: !1589, file: !170, line: 56, type: !259)
!1602 = !DILocation(line: 0, scope: !1589)
!1603 = !DILocation(line: 21, column: 3, scope: !1604)
!1604 = distinct !DILexicalBlock(scope: !1605, file: !170, line: 21, column: 3)
!1605 = distinct !DILexicalBlock(scope: !1589, file: !170, line: 21, column: 3)
!1606 = !DILocation(line: 26, column: 11, scope: !1607)
!1607 = distinct !DILexicalBlock(scope: !1589, file: !170, line: 26, column: 7)
!1608 = !DILocation(line: 26, column: 7, scope: !1589)
!1609 = !DILocation(line: 27, column: 15, scope: !1607)
!1610 = !DILocation(line: 29, column: 11, scope: !1611)
!1611 = distinct !DILexicalBlock(scope: !1589, file: !170, line: 29, column: 7)
!1612 = !DILocation(line: 29, column: 7, scope: !1589)
!1613 = !DILocation(line: 30, column: 18, scope: !1611)
!1614 = !DILocation(line: 30, column: 5, scope: !1611)
!1615 = !DILocation(line: 36, column: 17, scope: !1589)
!1616 = !DILocation(line: 36, column: 10, scope: !1589)
!1617 = !DILocation(line: 37, column: 3, scope: !1618)
!1618 = distinct !DILexicalBlock(scope: !1619, file: !170, line: 37, column: 3)
!1619 = distinct !DILexicalBlock(scope: !1589, file: !170, line: 37, column: 3)
!1620 = !DILocation(line: 38, column: 11, scope: !1589)
!1621 = !DILocation(line: 39, column: 3, scope: !1622)
!1622 = distinct !DILexicalBlock(scope: !1623, file: !170, line: 39, column: 3)
!1623 = distinct !DILexicalBlock(scope: !1589, file: !170, line: 39, column: 3)
!1624 = !DILocation(line: 40, column: 3, scope: !1589)
!1625 = !DILocation(line: 0, scope: !443, inlinedAt: !1626)
!1626 = distinct !DILocation(line: 43, column: 3, scope: !1589)
!1627 = !DILocation(line: 9, column: 26, scope: !443, inlinedAt: !1626)
!1628 = !DILocation(line: 9, column: 39, scope: !443, inlinedAt: !1626)
!1629 = !DILocation(line: 9, column: 60, scope: !443, inlinedAt: !1626)
!1630 = !DILocation(line: 9, column: 73, scope: !443, inlinedAt: !1626)
!1631 = !DILocation(line: 0, scope: !345, inlinedAt: !1632)
!1632 = distinct !DILocation(line: 9, column: 3, scope: !443, inlinedAt: !1626)
!1633 = !DILocation(line: 18, column: 3, scope: !345, inlinedAt: !1632)
!1634 = !DILocation(line: 18, column: 24, scope: !345, inlinedAt: !1632)
!1635 = !DILocation(line: 19, column: 19, scope: !345, inlinedAt: !1632)
!1636 = !DILocation(line: 21, column: 3, scope: !345, inlinedAt: !1632)
!1637 = !DILocation(line: 21, column: 23, scope: !375, inlinedAt: !1632)
!1638 = !DILocation(line: 21, column: 18, scope: !375, inlinedAt: !1632)
!1639 = !DILocation(line: 21, column: 59, scope: !374, inlinedAt: !1632)
!1640 = !DILocation(line: 24, column: 17, scope: !381, inlinedAt: !1632)
!1641 = !DILocation(line: 25, column: 11, scope: !378, inlinedAt: !1632)
!1642 = !DILocation(line: 25, column: 19, scope: !378, inlinedAt: !1632)
!1643 = !DILocation(line: 25, column: 11, scope: !379, inlinedAt: !1632)
!1644 = !DILocation(line: 26, column: 34, scope: !377, inlinedAt: !1632)
!1645 = !DILocation(line: 26, column: 43, scope: !377, inlinedAt: !1632)
!1646 = !DILocation(line: 0, scope: !377, inlinedAt: !1632)
!1647 = !DILocation(line: 27, column: 41, scope: !377, inlinedAt: !1632)
!1648 = !DILocation(line: 28, column: 9, scope: !377, inlinedAt: !1632)
!1649 = !DILocation(line: 28, column: 44, scope: !386, inlinedAt: !1632)
!1650 = !DILocation(line: 28, column: 25, scope: !387, inlinedAt: !1632)
!1651 = !DILocation(line: 29, column: 34, scope: !385, inlinedAt: !1632)
!1652 = !DILocation(line: 29, column: 43, scope: !385, inlinedAt: !1632)
!1653 = !DILocation(line: 0, scope: !385, inlinedAt: !1632)
!1654 = !DILocation(line: 30, column: 31, scope: !385, inlinedAt: !1632)
!1655 = !DILocation(line: 32, column: 25, scope: !420, inlinedAt: !1632)
!1656 = !DILocation(line: 32, column: 15, scope: !385, inlinedAt: !1632)
!1657 = !DILocation(line: 33, column: 28, scope: !423, inlinedAt: !1632)
!1658 = !DILocation(line: 34, column: 13, scope: !423, inlinedAt: !1632)
!1659 = !DILocation(line: 35, column: 11, scope: !423, inlinedAt: !1632)
!1660 = !DILocation(line: 28, column: 55, scope: !386, inlinedAt: !1632)
!1661 = distinct !{!1661, !1650, !1662, !429, !430}
!1662 = !DILocation(line: 36, column: 9, scope: !387, inlinedAt: !1632)
!1663 = !DILocation(line: 24, column: 39, scope: !380, inlinedAt: !1632)
!1664 = !DILocation(line: 24, column: 28, scope: !380, inlinedAt: !1632)
!1665 = distinct !{!1665, !1640, !1666, !429, !430}
!1666 = !DILocation(line: 38, column: 5, scope: !381, inlinedAt: !1632)
!1667 = !DILocation(line: 39, column: 10, scope: !436, inlinedAt: !1632)
!1668 = !DILocation(line: 39, column: 33, scope: !436, inlinedAt: !1632)
!1669 = !DILocation(line: 39, column: 38, scope: !436, inlinedAt: !1632)
!1670 = !DILocation(line: 39, column: 9, scope: !373, inlinedAt: !1632)
!1671 = distinct !{!1671, !1638, !1672, !429, !430}
!1672 = !DILocation(line: 41, column: 3, scope: !375, inlinedAt: !1632)
!1673 = !DILocation(line: 47, column: 12, scope: !1589)
!1674 = !DILocation(line: 48, column: 3, scope: !1675)
!1675 = distinct !DILexicalBlock(scope: !1676, file: !170, line: 48, column: 3)
!1676 = distinct !DILexicalBlock(scope: !1589, file: !170, line: 48, column: 3)
!1677 = !DILocation(line: 0, scope: !722, inlinedAt: !1678)
!1678 = distinct !DILocation(line: 49, column: 3, scope: !1589)
!1679 = !DILocation(line: 0, scope: !626, inlinedAt: !1680)
!1680 = distinct !DILocation(line: 97, column: 3, scope: !722, inlinedAt: !1678)
!1681 = !DILocation(line: 190, column: 3, scope: !633, inlinedAt: !1680)
!1682 = !DILocation(line: 191, column: 3, scope: !626, inlinedAt: !1680)
!1683 = !DILocation(line: 0, scope: !638, inlinedAt: !1684)
!1684 = distinct !DILocation(line: 98, column: 3, scope: !722, inlinedAt: !1678)
!1685 = !DILocation(line: 180, column: 1, scope: !650, inlinedAt: !1684)
!1686 = !DILocation(line: 180, column: 1, scope: !648, inlinedAt: !1684)
!1687 = !DILocation(line: 180, column: 1, scope: !649, inlinedAt: !1684)
!1688 = distinct !{!1688, !1685, !1685, !429, !430}
!1689 = !DILocation(line: 50, column: 3, scope: !1589)
!1690 = !DILocation(line: 57, column: 16, scope: !1589)
!1691 = !DILocation(line: 57, column: 9, scope: !1589)
!1692 = !DILocation(line: 58, column: 3, scope: !1693)
!1693 = distinct !DILexicalBlock(scope: !1694, file: !170, line: 58, column: 3)
!1694 = distinct !DILexicalBlock(scope: !1589, file: !170, line: 58, column: 3)
!1695 = !DILocation(line: 59, column: 14, scope: !1589)
!1696 = !DILocation(line: 60, column: 3, scope: !1697)
!1697 = distinct !DILexicalBlock(scope: !1698, file: !170, line: 60, column: 3)
!1698 = distinct !DILexicalBlock(scope: !1589, file: !170, line: 60, column: 3)
!1699 = !DILocation(line: 0, scope: !690, inlinedAt: !1700)
!1700 = distinct !DILocation(line: 61, column: 3, scope: !1589)
!1701 = !DILocation(line: 85, column: 3, scope: !690, inlinedAt: !1700)
!1702 = !DILocation(line: 87, column: 7, scope: !690, inlinedAt: !1700)
!1703 = !DILocation(line: 0, scope: !519, inlinedAt: !1704)
!1704 = distinct !DILocation(line: 89, column: 7, scope: !690, inlinedAt: !1700)
!1705 = !DILocation(line: 64, column: 17, scope: !519, inlinedAt: !1704)
!1706 = !DILocation(line: 64, column: 3, scope: !519, inlinedAt: !1704)
!1707 = !DILocation(line: 66, column: 22, scope: !530, inlinedAt: !1704)
!1708 = !DILocation(line: 66, column: 26, scope: !530, inlinedAt: !1704)
!1709 = !DILocation(line: 66, column: 32, scope: !530, inlinedAt: !1704)
!1710 = !DILocation(line: 66, column: 35, scope: !530, inlinedAt: !1704)
!1711 = !DILocation(line: 66, column: 39, scope: !530, inlinedAt: !1704)
!1712 = !DILocation(line: 66, column: 9, scope: !531, inlinedAt: !1704)
!1713 = !DILocation(line: 69, column: 6, scope: !531, inlinedAt: !1704)
!1714 = !DILocation(line: 64, column: 10, scope: !519, inlinedAt: !1704)
!1715 = !DILocation(line: 64, column: 13, scope: !519, inlinedAt: !1704)
!1716 = distinct !{!1716, !1706, !1717, !429, !430}
!1717 = !DILocation(line: 70, column: 3, scope: !519, inlinedAt: !1704)
!1718 = !DILocation(line: 71, column: 6, scope: !543, inlinedAt: !1704)
!1719 = !DILocation(line: 71, column: 8, scope: !543, inlinedAt: !1704)
!1720 = !DILocation(line: 71, column: 6, scope: !519, inlinedAt: !1704)
!1721 = !DILocation(line: 90, column: 33, scope: !690, inlinedAt: !1700)
!1722 = !DILocation(line: 90, column: 3, scope: !690, inlinedAt: !1700)
!1723 = !DILocation(line: 91, column: 3, scope: !690, inlinedAt: !1700)
!1724 = !DILocation(line: 0, scope: !740, inlinedAt: !1725)
!1725 = distinct !DILocation(line: 66, column: 8, scope: !1726)
!1726 = distinct !DILexicalBlock(scope: !1589, file: !170, line: 66, column: 7)
!1727 = !DILocation(line: 108, column: 3, scope: !752, inlinedAt: !1725)
!1728 = !DILocation(line: 109, column: 20, scope: !754, inlinedAt: !1725)
!1729 = !DILocation(line: 109, column: 43, scope: !754, inlinedAt: !1725)
!1730 = !DILocation(line: 109, column: 41, scope: !754, inlinedAt: !1725)
!1731 = !DILocation(line: 109, column: 16, scope: !754, inlinedAt: !1725)
!1732 = !DILocation(line: 108, column: 25, scope: !755, inlinedAt: !1725)
!1733 = !DILocation(line: 108, column: 13, scope: !755, inlinedAt: !1725)
!1734 = distinct !{!1734, !1727, !1735, !429, !430}
!1735 = !DILocation(line: 110, column: 3, scope: !752, inlinedAt: !1725)
!1736 = !DILocation(line: 113, column: 10, scope: !740, inlinedAt: !1725)
!1737 = !DILocation(line: 66, column: 7, scope: !1589)
!1738 = !DILocation(line: 67, column: 13, scope: !1739)
!1739 = distinct !DILexicalBlock(scope: !1726, file: !170, line: 66, column: 32)
!1740 = !DILocation(line: 67, column: 5, scope: !1739)
!1741 = !DILocation(line: 68, column: 5, scope: !1739)
!1742 = !DILocation(line: 71, column: 3, scope: !1589)
!1743 = !DILocation(line: 72, column: 3, scope: !1589)
!1744 = !DILocation(line: 74, column: 3, scope: !1589)
!1745 = !DILocation(line: 75, column: 3, scope: !1589)
!1746 = !DILocation(line: 76, column: 1, scope: !1589)
!1747 = !DISubprogram(name: "open", scope: !1748, file: !1748, line: 209, type: !1749, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1748 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1749 = !DISubroutineType(types: !1750)
!1750 = !{!233, !851, !233, null}
