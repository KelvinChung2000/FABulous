; ModuleID = 'fft/strided/fft_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.bench_args_t = type { [1024 x double], [1024 x double], [512 x double], [512 x double] }
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
@INPUT_SIZE = dso_local local_unnamed_addr global i32 24576, align 4, !dbg !186
@.str.6.14 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !208
@.str.8.15 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !211
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !214
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !219
@.str.12.16 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !222
@.str.14.17 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !224
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !227
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @fft(ptr nocapture noundef %real, ptr nocapture noundef %img, ptr nocapture noundef readonly %real_twid, ptr nocapture noundef readonly %img_twid) local_unnamed_addr #0 !dbg !329 {
entry.split:
  %odd.0104.reg2mem = alloca i32, align 4
  %span.0105.reg2mem16 = alloca i32, align 4
  %log.0106.reg2mem18 = alloca i32, align 4
    #dbg_value(ptr %real, !334, !DIExpression(), !349)
    #dbg_value(ptr %img, !335, !DIExpression(), !349)
    #dbg_value(ptr %real_twid, !336, !DIExpression(), !349)
    #dbg_value(ptr %img_twid, !337, !DIExpression(), !349)
    #dbg_value(i32 0, !341, !DIExpression(), !349)
    #dbg_label(!344, !350)
    #dbg_value(i32 512, !340, !DIExpression(), !349)
  store i32 512, ptr %span.0105.reg2mem16, align 4
  store i32 0, ptr %log.0106.reg2mem18, align 4
  br label %for.cond1.preheader, !dbg !351

for.cond1.preheader:                              ; preds = %for.inc50.for.cond1.preheader_crit_edge, %entry.split
    #dbg_value(i32 %log.0106.reg2mem18.0.load, !341, !DIExpression(), !349)
    #dbg_value(i32 %span.0105.reg2mem16.0.load, !340, !DIExpression(), !349)
    #dbg_value(i32 %span.0105.reg2mem16.0.load, !339, !DIExpression(), !349)
  %log.0106.reg2mem18.0.load = load i32, ptr %log.0106.reg2mem18, align 4
  %span.0105.reg2mem16.0.load = load i32, ptr %span.0105.reg2mem16, align 4
  store i32 %span.0105.reg2mem16.0.load, ptr %odd.0104.reg2mem, align 4
  br label %for.body2, !dbg !352

for.body2:                                        ; preds = %for.inc.for.body2_crit_edge, %for.cond1.preheader
    #dbg_value(i32 %odd.0104.reg2mem.0.load, !339, !DIExpression(), !349)
  %odd.0104.reg2mem.0.load = load i32, ptr %odd.0104.reg2mem, align 4
  %or = or i32 %odd.0104.reg2mem.0.load, %span.0105.reg2mem16.0.load, !dbg !354
    #dbg_value(i32 %or, !339, !DIExpression(), !349)
  %xor = xor i32 %or, %span.0105.reg2mem16.0.load, !dbg !357
    #dbg_value(i32 %xor, !338, !DIExpression(), !349)
  %idxprom = sext i32 %xor to i64, !dbg !358
  %arrayidx = getelementptr inbounds double, ptr %real, i64 %idxprom, !dbg !358
  %0 = load double, ptr %arrayidx, align 8, !dbg !358, !tbaa !359
  %idxprom3 = sext i32 %or to i64, !dbg !363
  %arrayidx4 = getelementptr inbounds double, ptr %real, i64 %idxprom3, !dbg !363
  %1 = load double, ptr %arrayidx4, align 8, !dbg !363, !tbaa !359
  %add = fadd double %0, %1, !dbg !364
    #dbg_value(double %add, !343, !DIExpression(), !349)
  %sub = fsub double %0, %1, !dbg !365
  store double %sub, ptr %arrayidx4, align 8, !dbg !366, !tbaa !359
  store double %add, ptr %arrayidx, align 8, !dbg !367, !tbaa !359
  %arrayidx14 = getelementptr inbounds double, ptr %img, i64 %idxprom, !dbg !368
  %2 = load double, ptr %arrayidx14, align 8, !dbg !368, !tbaa !359
  %arrayidx16 = getelementptr inbounds double, ptr %img, i64 %idxprom3, !dbg !369
  %3 = load double, ptr %arrayidx16, align 8, !dbg !369, !tbaa !359
  %add17 = fadd double %2, %3, !dbg !370
    #dbg_value(double %add17, !343, !DIExpression(), !349)
  %sub22 = fsub double %2, %3, !dbg !371
  store double %sub22, ptr %arrayidx16, align 8, !dbg !372, !tbaa !359
  store double %add17, ptr %arrayidx14, align 8, !dbg !373, !tbaa !359
  %shl = shl i32 %xor, %log.0106.reg2mem18.0.load, !dbg !374
  %and = and i32 %shl, 1023, !dbg !375
    #dbg_value(i32 %and, !342, !DIExpression(), !349)
  %tobool27.not = icmp eq i32 %and, 0, !dbg !376
  br i1 %tobool27.not, label %for.body2.for.inc_crit_edge, label %if.then, !dbg !378

for.body2.for.inc_crit_edge:                      ; preds = %for.body2
  br label %for.inc, !dbg !378

if.then:                                          ; preds = %for.body2
  %idxprom28 = zext nneg i32 %and to i64
  %arrayidx29 = getelementptr inbounds double, ptr %real_twid, i64 %idxprom28, !dbg !379
  %4 = load double, ptr %arrayidx29, align 8, !dbg !379, !tbaa !359
  %5 = load double, ptr %arrayidx4, align 8, !dbg !381, !tbaa !359
  %arrayidx33 = getelementptr inbounds double, ptr %img_twid, i64 %idxprom28, !dbg !382
  %6 = load double, ptr %arrayidx33, align 8, !dbg !382, !tbaa !359
  %7 = load double, ptr %arrayidx16, align 8, !dbg !383, !tbaa !359
  %8 = fneg double %6, !dbg !384
  %neg = fmul double %7, %8, !dbg !384
  %9 = tail call double @llvm.fmuladd.f64(double %4, double %5, double %neg), !dbg !384
    #dbg_value(double %9, !343, !DIExpression(), !349)
  %mul45 = fmul double %5, %6, !dbg !385
  %10 = tail call double @llvm.fmuladd.f64(double %4, double %7, double %mul45), !dbg !386
  store double %10, ptr %arrayidx16, align 8, !dbg !387, !tbaa !359
  store double %9, ptr %arrayidx4, align 8, !dbg !388, !tbaa !359
  br label %for.inc, !dbg !389

for.inc:                                          ; preds = %for.body2.for.inc_crit_edge, %if.then
  %inc = add nsw i32 %or, 1, !dbg !390
    #dbg_value(i32 %inc, !339, !DIExpression(), !349)
  %cmp = icmp slt i32 %or, 1023, !dbg !391
  br i1 %cmp, label %for.inc.for.body2_crit_edge, label %for.inc50, !dbg !352, !llvm.loop !392

for.inc.for.body2_crit_edge:                      ; preds = %for.inc
  store i32 %inc, ptr %odd.0104.reg2mem, align 4
  br label %for.body2, !dbg !352

for.inc50:                                        ; preds = %for.inc
  %shr = lshr i32 %span.0105.reg2mem16.0.load, 1, !dbg !396
    #dbg_value(i32 %shr, !340, !DIExpression(), !349)
  %inc51 = add nuw nsw i32 %log.0106.reg2mem18.0.load, 1, !dbg !397
    #dbg_value(i32 %inc51, !341, !DIExpression(), !349)
  %exitcond = icmp eq i32 %inc51, 10, !dbg !351
  br i1 %exitcond, label %for.end52, label %for.inc50.for.cond1.preheader_crit_edge, !dbg !351, !llvm.loop !398

for.inc50.for.cond1.preheader_crit_edge:          ; preds = %for.inc50
  store i32 %shr, ptr %span.0105.reg2mem16, align 4
  store i32 %inc51, ptr %log.0106.reg2mem18, align 4
  br label %for.cond1.preheader, !dbg !351

for.end52:                                        ; preds = %for.inc50
  ret void, !dbg !400
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #0 !dbg !401 {
entry.split:
  %odd.0104.i.reg2mem = alloca i32, align 4
  %span.0105.i.reg2mem17 = alloca i32, align 4
  %log.0106.i.reg2mem19 = alloca i32, align 4
    #dbg_value(ptr %vargs, !405, !DIExpression(), !407)
    #dbg_value(ptr %vargs, !406, !DIExpression(), !407)
  %img = getelementptr inbounds i8, ptr %vargs, i64 8192, !dbg !408
  %real_twid = getelementptr inbounds i8, ptr %vargs, i64 16384, !dbg !409
  %img_twid = getelementptr inbounds i8, ptr %vargs, i64 20480, !dbg !410
    #dbg_value(ptr %vargs, !334, !DIExpression(), !411)
    #dbg_value(ptr %img, !335, !DIExpression(), !411)
    #dbg_value(ptr %real_twid, !336, !DIExpression(), !411)
    #dbg_value(ptr %img_twid, !337, !DIExpression(), !411)
    #dbg_value(i32 0, !341, !DIExpression(), !411)
    #dbg_label(!344, !413)
    #dbg_value(i32 512, !340, !DIExpression(), !411)
  store i32 512, ptr %span.0105.i.reg2mem17, align 4
  store i32 0, ptr %log.0106.i.reg2mem19, align 4
  br label %for.cond1.preheader.i, !dbg !414

for.cond1.preheader.i:                            ; preds = %for.inc50.i.for.cond1.preheader.i_crit_edge, %entry.split
    #dbg_value(i32 %log.0106.i.reg2mem19.0.load, !341, !DIExpression(), !411)
    #dbg_value(i32 %span.0105.i.reg2mem17.0.load, !340, !DIExpression(), !411)
    #dbg_value(i32 %span.0105.i.reg2mem17.0.load, !339, !DIExpression(), !411)
  %log.0106.i.reg2mem19.0.load = load i32, ptr %log.0106.i.reg2mem19, align 4
  %span.0105.i.reg2mem17.0.load = load i32, ptr %span.0105.i.reg2mem17, align 4
  store i32 %span.0105.i.reg2mem17.0.load, ptr %odd.0104.i.reg2mem, align 4
  br label %for.body2.i, !dbg !415

for.body2.i:                                      ; preds = %for.inc.i.for.body2.i_crit_edge, %for.cond1.preheader.i
    #dbg_value(i32 %odd.0104.i.reg2mem.0.load, !339, !DIExpression(), !411)
  %odd.0104.i.reg2mem.0.load = load i32, ptr %odd.0104.i.reg2mem, align 4
  %or.i = or i32 %odd.0104.i.reg2mem.0.load, %span.0105.i.reg2mem17.0.load, !dbg !416
    #dbg_value(i32 %or.i, !339, !DIExpression(), !411)
  %xor.i = xor i32 %or.i, %span.0105.i.reg2mem17.0.load, !dbg !417
    #dbg_value(i32 %xor.i, !338, !DIExpression(), !411)
  %idxprom.i = sext i32 %xor.i to i64, !dbg !418
  %arrayidx.i = getelementptr inbounds double, ptr %vargs, i64 %idxprom.i, !dbg !418
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !418, !tbaa !359
  %idxprom3.i = sext i32 %or.i to i64, !dbg !419
  %arrayidx4.i = getelementptr inbounds double, ptr %vargs, i64 %idxprom3.i, !dbg !419
  %1 = load double, ptr %arrayidx4.i, align 8, !dbg !419, !tbaa !359
  %add.i = fadd double %0, %1, !dbg !420
    #dbg_value(double %add.i, !343, !DIExpression(), !411)
  %sub.i = fsub double %0, %1, !dbg !421
  store double %sub.i, ptr %arrayidx4.i, align 8, !dbg !422, !tbaa !359
  store double %add.i, ptr %arrayidx.i, align 8, !dbg !423, !tbaa !359
  %arrayidx14.i = getelementptr inbounds double, ptr %img, i64 %idxprom.i, !dbg !424
  %2 = load double, ptr %arrayidx14.i, align 8, !dbg !424, !tbaa !359
  %arrayidx16.i = getelementptr inbounds double, ptr %img, i64 %idxprom3.i, !dbg !425
  %3 = load double, ptr %arrayidx16.i, align 8, !dbg !425, !tbaa !359
  %add17.i = fadd double %2, %3, !dbg !426
    #dbg_value(double %add17.i, !343, !DIExpression(), !411)
  %sub22.i = fsub double %2, %3, !dbg !427
  store double %sub22.i, ptr %arrayidx16.i, align 8, !dbg !428, !tbaa !359
  store double %add17.i, ptr %arrayidx14.i, align 8, !dbg !429, !tbaa !359
  %shl.i = shl i32 %xor.i, %log.0106.i.reg2mem19.0.load, !dbg !430
  %and.i = and i32 %shl.i, 1023, !dbg !431
    #dbg_value(i32 %and.i, !342, !DIExpression(), !411)
  %tobool27.not.i = icmp eq i32 %and.i, 0, !dbg !432
  br i1 %tobool27.not.i, label %for.body2.i.for.inc.i_crit_edge, label %if.then.i, !dbg !433

for.body2.i.for.inc.i_crit_edge:                  ; preds = %for.body2.i
  br label %for.inc.i, !dbg !433

if.then.i:                                        ; preds = %for.body2.i
  %idxprom28.i = zext nneg i32 %and.i to i64
  %arrayidx29.i = getelementptr inbounds double, ptr %real_twid, i64 %idxprom28.i, !dbg !434
  %4 = load double, ptr %arrayidx29.i, align 8, !dbg !434, !tbaa !359
  %5 = load double, ptr %arrayidx4.i, align 8, !dbg !435, !tbaa !359
  %arrayidx33.i = getelementptr inbounds double, ptr %img_twid, i64 %idxprom28.i, !dbg !436
  %6 = load double, ptr %arrayidx33.i, align 8, !dbg !436, !tbaa !359
  %7 = load double, ptr %arrayidx16.i, align 8, !dbg !437, !tbaa !359
  %8 = fneg double %6, !dbg !438
  %neg.i = fmul double %7, %8, !dbg !438
  %9 = tail call double @llvm.fmuladd.f64(double %4, double %5, double %neg.i), !dbg !438
    #dbg_value(double %9, !343, !DIExpression(), !411)
  %mul45.i = fmul double %5, %6, !dbg !439
  %10 = tail call double @llvm.fmuladd.f64(double %4, double %7, double %mul45.i), !dbg !440
  store double %10, ptr %arrayidx16.i, align 8, !dbg !441, !tbaa !359
  store double %9, ptr %arrayidx4.i, align 8, !dbg !442, !tbaa !359
  br label %for.inc.i, !dbg !443

for.inc.i:                                        ; preds = %for.body2.i.for.inc.i_crit_edge, %if.then.i
  %inc.i = add nsw i32 %or.i, 1, !dbg !444
    #dbg_value(i32 %inc.i, !339, !DIExpression(), !411)
  %cmp.i = icmp slt i32 %or.i, 1023, !dbg !445
  br i1 %cmp.i, label %for.inc.i.for.body2.i_crit_edge, label %for.inc50.i, !dbg !415, !llvm.loop !446

for.inc.i.for.body2.i_crit_edge:                  ; preds = %for.inc.i
  store i32 %inc.i, ptr %odd.0104.i.reg2mem, align 4
  br label %for.body2.i, !dbg !415

for.inc50.i:                                      ; preds = %for.inc.i
  %shr.i = lshr i32 %span.0105.i.reg2mem17.0.load, 1, !dbg !448
    #dbg_value(i32 %shr.i, !340, !DIExpression(), !411)
  %inc51.i = add nuw nsw i32 %log.0106.i.reg2mem19.0.load, 1, !dbg !449
    #dbg_value(i32 %inc51.i, !341, !DIExpression(), !411)
  %exitcond.i = icmp eq i32 %inc51.i, 10, !dbg !414
  br i1 %exitcond.i, label %fft.exit, label %for.inc50.i.for.cond1.preheader.i_crit_edge, !dbg !414, !llvm.loop !450

for.inc50.i.for.cond1.preheader.i_crit_edge:      ; preds = %for.inc50.i
  store i32 %shr.i, ptr %span.0105.i.reg2mem17, align 4
  store i32 %inc51.i, ptr %log.0106.i.reg2mem19, align 4
  br label %for.cond1.preheader.i, !dbg !414

fft.exit:                                         ; preds = %for.inc50.i
  ret void, !dbg !452
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #2 !dbg !453 {
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
    #dbg_value(i32 %fd, !457, !DIExpression(), !462)
    #dbg_value(ptr %vdata, !458, !DIExpression(), !462)
    #dbg_value(ptr %vdata, !459, !DIExpression(), !462)
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !463
    #dbg_value(ptr %call, !460, !DIExpression(), !462)
    #dbg_value(ptr %call, !464, !DIExpression(), !471)
    #dbg_value(i32 1, !469, !DIExpression(), !471)
    #dbg_value(i32 0, !470, !DIExpression(), !471)
  store ptr %call, ptr %call.reg2mem, align 8
  store ptr %call, ptr %s.addr.040.i.reg2mem166, align 8
  store i32 0, ptr %i.041.i.reg2mem168, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem168.0.load, !470, !DIExpression(), !471)
    #dbg_value(ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, !464, !DIExpression(), !471)
  %i.041.i.reg2mem168.0.load = load i32, ptr %i.041.i.reg2mem168, align 4
  %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167 = load ptr, ptr %s.addr.040.i.reg2mem166, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, align 1, !dbg !473, !tbaa !474
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !475

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !475

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem168.0.load, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !475

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 1, !dbg !476
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !476, !tbaa !474
  %cmp13.i = icmp eq i8 %1, 37, !dbg !479
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !480

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem168.0.load, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !480

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 2, !dbg !481
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !481, !tbaa !474
  %cmp18.i = icmp eq i8 %2, 10, !dbg !482
  %inc.i = zext i1 %cmp18.i to i32, !dbg !483
  %spec.select.i = add nsw i32 %i.041.i.reg2mem168.0.load, %inc.i, !dbg !483
  store i32 %spec.select.i, ptr %i.1.i.reg2mem164, align 4
  br label %if.end21.i, !dbg !483

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem164.0.load, !470, !DIExpression(), !471)
  %i.1.i.reg2mem164.0.load = load i32, ptr %i.1.i.reg2mem164, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem166.0.s.addr.040.i.reload167, i64 1, !dbg !484
    #dbg_value(ptr %incdec.ptr.i, !464, !DIExpression(), !471)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem164.0.load, 1, !dbg !485
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !486, !llvm.loop !487

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem166, align 8
  store i32 %i.1.i.reg2mem164.0.load, ptr %i.041.i.reg2mem168, align 4
  br label %land.rhs.i, !dbg !486

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !489, !tbaa !474
  %3 = icmp eq i8 %.pre.i, 0, !dbg !491
  %4 = select i1 %3, i64 0, i64 2, !dbg !492
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !486

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !492
    #dbg_value(ptr %spec.select38.i, !461, !DIExpression(), !462)
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 1024) #18, !dbg !493
    #dbg_value(ptr %call, !464, !DIExpression(), !494)
    #dbg_value(i32 2, !469, !DIExpression(), !494)
    #dbg_value(i32 0, !470, !DIExpression(), !494)
  store ptr %call, ptr %s.addr.040.i3.reg2mem160, align 8
  store i32 0, ptr %i.041.i2.reg2mem162, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem162.0.load, !470, !DIExpression(), !494)
    #dbg_value(ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, !464, !DIExpression(), !494)
  %i.041.i2.reg2mem162.0.load = load i32, ptr %i.041.i2.reg2mem162, align 4
  %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161 = load ptr, ptr %s.addr.040.i3.reg2mem160, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, align 1, !dbg !496, !tbaa !474
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !497

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !497

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem162.0.load, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !497

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 1, !dbg !498
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !498, !tbaa !474
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !499
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !500

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem162.0.load, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !500

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 2, !dbg !501
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !501, !tbaa !474
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !502
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !503
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem162.0.load, %inc.i19, !dbg !503
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem158, align 4
  br label %if.end21.i7, !dbg !503

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem158.0.load, !470, !DIExpression(), !494)
  %i.1.i8.reg2mem158.0.load = load i32, ptr %i.1.i8.reg2mem158, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem160.0.s.addr.040.i3.reload161, i64 1, !dbg !504
    #dbg_value(ptr %incdec.ptr.i9, !464, !DIExpression(), !494)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem158.0.load, 2, !dbg !505
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !506, !llvm.loop !507

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem160, align 8
  store i32 %i.1.i8.reg2mem158.0.load, ptr %i.041.i2.reg2mem162, align 4
  br label %land.rhs.i1, !dbg !506

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !509, !tbaa !474
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !510
  %9 = select i1 %8, i64 0, i64 2, !dbg !511
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !506

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !511
    #dbg_value(ptr %spec.select38.i15, !461, !DIExpression(), !462)
  %img = getelementptr inbounds i8, ptr %vdata, i64 8192, !dbg !512
  %call5 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %img, i32 noundef signext 1024) #18, !dbg !513
    #dbg_value(ptr %call, !464, !DIExpression(), !514)
    #dbg_value(i32 3, !469, !DIExpression(), !514)
    #dbg_value(i32 0, !470, !DIExpression(), !514)
  store ptr %call, ptr %s.addr.040.i24.reg2mem154, align 8
  store i32 0, ptr %i.041.i23.reg2mem156, align 4
  br label %land.rhs.i22

land.rhs.i22:                                     ; preds = %if.end21.i28.land.rhs.i22_crit_edge, %find_section_start.exit21
    #dbg_value(i32 %i.041.i23.reg2mem156.0.load, !470, !DIExpression(), !514)
    #dbg_value(ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, !464, !DIExpression(), !514)
  %i.041.i23.reg2mem156.0.load = load i32, ptr %i.041.i23.reg2mem156, align 4
  %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155 = load ptr, ptr %s.addr.040.i24.reg2mem154, align 8
  %10 = load i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, align 1, !dbg !516, !tbaa !474
  switch i8 %10, label %land.rhs.i22.if.end21.i28_crit_edge [
    i8 0, label %land.rhs.i22.find_section_start.exit42_crit_edge
    i8 37, label %land.lhs.true10.i25
  ], !dbg !517

land.rhs.i22.find_section_start.exit42_crit_edge: ; preds = %land.rhs.i22
  store ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !517

land.rhs.i22.if.end21.i28_crit_edge:              ; preds = %land.rhs.i22
  store i32 %i.041.i23.reg2mem156.0.load, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !517

land.lhs.true10.i25:                              ; preds = %land.rhs.i22
  %arrayidx11.i26 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 1, !dbg !518
  %11 = load i8, ptr %arrayidx11.i26, align 1, !dbg !518, !tbaa !474
  %cmp13.i27 = icmp eq i8 %11, 37, !dbg !519
  br i1 %cmp13.i27, label %land.lhs.true15.i37, label %land.lhs.true10.i25.if.end21.i28_crit_edge, !dbg !520

land.lhs.true10.i25.if.end21.i28_crit_edge:       ; preds = %land.lhs.true10.i25
  store i32 %i.041.i23.reg2mem156.0.load, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !520

land.lhs.true15.i37:                              ; preds = %land.lhs.true10.i25
  %arrayidx16.i38 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 2, !dbg !521
  %12 = load i8, ptr %arrayidx16.i38, align 1, !dbg !521, !tbaa !474
  %cmp18.i39 = icmp eq i8 %12, 10, !dbg !522
  %inc.i40 = zext i1 %cmp18.i39 to i32, !dbg !523
  %spec.select.i41 = add nsw i32 %i.041.i23.reg2mem156.0.load, %inc.i40, !dbg !523
  store i32 %spec.select.i41, ptr %i.1.i29.reg2mem152, align 4
  br label %if.end21.i28, !dbg !523

if.end21.i28:                                     ; preds = %land.lhs.true10.i25.if.end21.i28_crit_edge, %land.rhs.i22.if.end21.i28_crit_edge, %land.lhs.true15.i37
    #dbg_value(i32 %i.1.i29.reg2mem152.0.load, !470, !DIExpression(), !514)
  %i.1.i29.reg2mem152.0.load = load i32, ptr %i.1.i29.reg2mem152, align 4
  %incdec.ptr.i30 = getelementptr inbounds i8, ptr %s.addr.040.i24.reg2mem154.0.s.addr.040.i24.reload155, i64 1, !dbg !524
    #dbg_value(ptr %incdec.ptr.i30, !464, !DIExpression(), !514)
  %cmp4.i31 = icmp slt i32 %i.1.i29.reg2mem152.0.load, 3, !dbg !525
  br i1 %cmp4.i31, label %if.end21.i28.land.rhs.i22_crit_edge, label %if.end21.while.end_crit_edge.i32, !dbg !526, !llvm.loop !527

if.end21.i28.land.rhs.i22_crit_edge:              ; preds = %if.end21.i28
  store ptr %incdec.ptr.i30, ptr %s.addr.040.i24.reg2mem154, align 8
  store i32 %i.1.i29.reg2mem152.0.load, ptr %i.041.i23.reg2mem156, align 4
  br label %land.rhs.i22, !dbg !526

if.end21.while.end_crit_edge.i32:                 ; preds = %if.end21.i28
  %.pre.i33 = load i8, ptr %incdec.ptr.i30, align 1, !dbg !529, !tbaa !474
  %13 = icmp eq i8 %.pre.i33, 0, !dbg !530
  %14 = select i1 %13, i64 0, i64 2, !dbg !531
  store ptr %incdec.ptr.i30, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  store i64 %14, ptr %cmp23.not.i34.reg2mem, align 8
  br label %find_section_start.exit42, !dbg !526

find_section_start.exit42:                        ; preds = %land.rhs.i22.find_section_start.exit42_crit_edge, %if.end21.while.end_crit_edge.i32
  %cmp23.not.i34.reg2mem.0.load = load i64, ptr %cmp23.not.i34.reg2mem, align 8
  %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload = load ptr, ptr %s.addr.0.lcssa.ph.i35.reg2mem, align 8
  %spec.select38.i36 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i35.reg2mem.0.s.addr.0.lcssa.ph.i35.reload, i64 %cmp23.not.i34.reg2mem.0.load, !dbg !531
    #dbg_value(ptr %spec.select38.i36, !461, !DIExpression(), !462)
  %real_twid = getelementptr inbounds i8, ptr %vdata, i64 16384, !dbg !532
  %call8 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i36, ptr noundef nonnull %real_twid, i32 noundef signext 512) #18, !dbg !533
    #dbg_value(ptr %call, !464, !DIExpression(), !534)
    #dbg_value(i32 4, !469, !DIExpression(), !534)
    #dbg_value(i32 0, !470, !DIExpression(), !534)
  store ptr %call, ptr %s.addr.040.i45.reg2mem148, align 8
  store i32 0, ptr %i.041.i44.reg2mem150, align 4
  br label %land.rhs.i43

land.rhs.i43:                                     ; preds = %if.end21.i49.land.rhs.i43_crit_edge, %find_section_start.exit42
    #dbg_value(i32 %i.041.i44.reg2mem150.0.load, !470, !DIExpression(), !534)
    #dbg_value(ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, !464, !DIExpression(), !534)
  %i.041.i44.reg2mem150.0.load = load i32, ptr %i.041.i44.reg2mem150, align 4
  %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149 = load ptr, ptr %s.addr.040.i45.reg2mem148, align 8
  %15 = load i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, align 1, !dbg !536, !tbaa !474
  switch i8 %15, label %land.rhs.i43.if.end21.i49_crit_edge [
    i8 0, label %land.rhs.i43.find_section_start.exit63_crit_edge
    i8 37, label %land.lhs.true10.i46
  ], !dbg !537

land.rhs.i43.find_section_start.exit63_crit_edge: ; preds = %land.rhs.i43
  store ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i55.reg2mem, align 8
  br label %find_section_start.exit63, !dbg !537

land.rhs.i43.if.end21.i49_crit_edge:              ; preds = %land.rhs.i43
  store i32 %i.041.i44.reg2mem150.0.load, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !537

land.lhs.true10.i46:                              ; preds = %land.rhs.i43
  %arrayidx11.i47 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 1, !dbg !538
  %16 = load i8, ptr %arrayidx11.i47, align 1, !dbg !538, !tbaa !474
  %cmp13.i48 = icmp eq i8 %16, 37, !dbg !539
  br i1 %cmp13.i48, label %land.lhs.true15.i58, label %land.lhs.true10.i46.if.end21.i49_crit_edge, !dbg !540

land.lhs.true10.i46.if.end21.i49_crit_edge:       ; preds = %land.lhs.true10.i46
  store i32 %i.041.i44.reg2mem150.0.load, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !540

land.lhs.true15.i58:                              ; preds = %land.lhs.true10.i46
  %arrayidx16.i59 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 2, !dbg !541
  %17 = load i8, ptr %arrayidx16.i59, align 1, !dbg !541, !tbaa !474
  %cmp18.i60 = icmp eq i8 %17, 10, !dbg !542
  %inc.i61 = zext i1 %cmp18.i60 to i32, !dbg !543
  %spec.select.i62 = add nsw i32 %i.041.i44.reg2mem150.0.load, %inc.i61, !dbg !543
  store i32 %spec.select.i62, ptr %i.1.i50.reg2mem146, align 4
  br label %if.end21.i49, !dbg !543

if.end21.i49:                                     ; preds = %land.lhs.true10.i46.if.end21.i49_crit_edge, %land.rhs.i43.if.end21.i49_crit_edge, %land.lhs.true15.i58
    #dbg_value(i32 %i.1.i50.reg2mem146.0.load, !470, !DIExpression(), !534)
  %i.1.i50.reg2mem146.0.load = load i32, ptr %i.1.i50.reg2mem146, align 4
  %incdec.ptr.i51 = getelementptr inbounds i8, ptr %s.addr.040.i45.reg2mem148.0.s.addr.040.i45.reload149, i64 1, !dbg !544
    #dbg_value(ptr %incdec.ptr.i51, !464, !DIExpression(), !534)
  %cmp4.i52 = icmp slt i32 %i.1.i50.reg2mem146.0.load, 4, !dbg !545
  br i1 %cmp4.i52, label %if.end21.i49.land.rhs.i43_crit_edge, label %if.end21.while.end_crit_edge.i53, !dbg !546, !llvm.loop !547

if.end21.i49.land.rhs.i43_crit_edge:              ; preds = %if.end21.i49
  store ptr %incdec.ptr.i51, ptr %s.addr.040.i45.reg2mem148, align 8
  store i32 %i.1.i50.reg2mem146.0.load, ptr %i.041.i44.reg2mem150, align 4
  br label %land.rhs.i43, !dbg !546

if.end21.while.end_crit_edge.i53:                 ; preds = %if.end21.i49
  %.pre.i54 = load i8, ptr %incdec.ptr.i51, align 1, !dbg !549, !tbaa !474
  %18 = icmp eq i8 %.pre.i54, 0, !dbg !550
  %19 = select i1 %18, i64 0, i64 2, !dbg !551
  store ptr %incdec.ptr.i51, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  store i64 %19, ptr %cmp23.not.i55.reg2mem, align 8
  br label %find_section_start.exit63, !dbg !546

find_section_start.exit63:                        ; preds = %land.rhs.i43.find_section_start.exit63_crit_edge, %if.end21.while.end_crit_edge.i53
  %cmp23.not.i55.reg2mem.0.load = load i64, ptr %cmp23.not.i55.reg2mem, align 8
  %s.addr.0.lcssa.ph.i56.reg2mem.0.s.addr.0.lcssa.ph.i56.reload = load ptr, ptr %s.addr.0.lcssa.ph.i56.reg2mem, align 8
  %spec.select38.i57 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i56.reg2mem.0.s.addr.0.lcssa.ph.i56.reload, i64 %cmp23.not.i55.reg2mem.0.load, !dbg !551
    #dbg_value(ptr %spec.select38.i57, !461, !DIExpression(), !462)
  %img_twid = getelementptr inbounds i8, ptr %vdata, i64 20480, !dbg !552
  %call11 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i57, ptr noundef nonnull %img_twid, i32 noundef signext 512) #18, !dbg !553
  %call.reg2mem.0.call.reload145 = load ptr, ptr %call.reg2mem, align 8
  tail call void @free(ptr noundef %call.reg2mem.0.call.reload145) #18, !dbg !554
  ret void, !dbg !555
}

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !556 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #3

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #2 !dbg !558 {
entry.split:
  %indvars.iv.i34.reg2mem = alloca i64, align 8
  %indvars.iv.i22.reg2mem = alloca i64, align 8
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !560, !DIExpression(), !563)
    #dbg_value(ptr %vdata, !561, !DIExpression(), !563)
    #dbg_value(ptr %vdata, !562, !DIExpression(), !563)
    #dbg_value(i32 %fd, !564, !DIExpression(), !569)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !571
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !571

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !571
  unreachable, !dbg !571

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !574
    #dbg_value(i32 %fd, !575, !DIExpression(), !583)
    #dbg_value(ptr %vdata, !580, !DIExpression(), !583)
    #dbg_value(i32 1024, !581, !DIExpression(), !583)
    #dbg_value(i32 0, !582, !DIExpression(), !583)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !585

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !582, !DIExpression(), !583)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !587
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !587, !tbaa !359
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !587
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !590
    #dbg_value(i64 %indvars.iv.next.i, !582, !DIExpression(), !583)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 1024, !dbg !590
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !585, !llvm.loop !591

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !585

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !564, !DIExpression(), !592)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !594
  %img = getelementptr inbounds i8, ptr %vdata, i64 8192, !dbg !595
    #dbg_value(i32 %fd, !575, !DIExpression(), !596)
    #dbg_value(ptr %img, !580, !DIExpression(), !596)
    #dbg_value(i32 1024, !581, !DIExpression(), !596)
    #dbg_value(i32 0, !582, !DIExpression(), !596)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !598

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !582, !DIExpression(), !596)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds double, ptr %img, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !599
  %1 = load double, ptr %arrayidx.i11, align 8, !dbg !599, !tbaa !359
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %1), !dbg !599
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !600
    #dbg_value(i64 %indvars.iv.next.i12, !582, !DIExpression(), !596)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 1024, !dbg !600
  br i1 %exitcond.not.i13, label %for.cond.preheader.i20, label %for.body.i9.for.body.i9_crit_edge, !dbg !598, !llvm.loop !601

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !598

for.cond.preheader.i20:                           ; preds = %for.body.i9
    #dbg_value(i32 %fd, !564, !DIExpression(), !602)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !604
  %real_twid = getelementptr inbounds i8, ptr %vdata, i64 16384, !dbg !605
    #dbg_value(i32 %fd, !575, !DIExpression(), !606)
    #dbg_value(ptr %real_twid, !580, !DIExpression(), !606)
    #dbg_value(i32 512, !581, !DIExpression(), !606)
    #dbg_value(i32 0, !582, !DIExpression(), !606)
  store i64 0, ptr %indvars.iv.i22.reg2mem, align 8
  br label %for.body.i21, !dbg !608

for.body.i21:                                     ; preds = %for.body.i21.for.body.i21_crit_edge, %for.cond.preheader.i20
    #dbg_value(i64 %indvars.iv.i22.reg2mem.0.load, !582, !DIExpression(), !606)
  %indvars.iv.i22.reg2mem.0.load = load i64, ptr %indvars.iv.i22.reg2mem, align 8
  %arrayidx.i23 = getelementptr inbounds double, ptr %real_twid, i64 %indvars.iv.i22.reg2mem.0.load, !dbg !609
  %2 = load double, ptr %arrayidx.i23, align 8, !dbg !609, !tbaa !359
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %2), !dbg !609
  %indvars.iv.next.i24 = add nuw nsw i64 %indvars.iv.i22.reg2mem.0.load, 1, !dbg !610
    #dbg_value(i64 %indvars.iv.next.i24, !582, !DIExpression(), !606)
  %exitcond.not.i25 = icmp eq i64 %indvars.iv.next.i24, 512, !dbg !610
  br i1 %exitcond.not.i25, label %for.cond.preheader.i32, label %for.body.i21.for.body.i21_crit_edge, !dbg !608, !llvm.loop !611

for.body.i21.for.body.i21_crit_edge:              ; preds = %for.body.i21
  store i64 %indvars.iv.next.i24, ptr %indvars.iv.i22.reg2mem, align 8
  br label %for.body.i21, !dbg !608

for.cond.preheader.i32:                           ; preds = %for.body.i21
    #dbg_value(i32 %fd, !564, !DIExpression(), !612)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !614
  %img_twid = getelementptr inbounds i8, ptr %vdata, i64 20480, !dbg !615
    #dbg_value(i32 %fd, !575, !DIExpression(), !616)
    #dbg_value(ptr %img_twid, !580, !DIExpression(), !616)
    #dbg_value(i32 512, !581, !DIExpression(), !616)
    #dbg_value(i32 0, !582, !DIExpression(), !616)
  store i64 0, ptr %indvars.iv.i34.reg2mem, align 8
  br label %for.body.i33, !dbg !618

for.body.i33:                                     ; preds = %for.body.i33.for.body.i33_crit_edge, %for.cond.preheader.i32
    #dbg_value(i64 %indvars.iv.i34.reg2mem.0.load, !582, !DIExpression(), !616)
  %indvars.iv.i34.reg2mem.0.load = load i64, ptr %indvars.iv.i34.reg2mem, align 8
  %arrayidx.i35 = getelementptr inbounds double, ptr %img_twid, i64 %indvars.iv.i34.reg2mem.0.load, !dbg !619
  %3 = load double, ptr %arrayidx.i35, align 8, !dbg !619, !tbaa !359
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %3), !dbg !619
  %indvars.iv.next.i36 = add nuw nsw i64 %indvars.iv.i34.reg2mem.0.load, 1, !dbg !620
    #dbg_value(i64 %indvars.iv.next.i36, !582, !DIExpression(), !616)
  %exitcond.not.i37 = icmp eq i64 %indvars.iv.next.i36, 512, !dbg !620
  br i1 %exitcond.not.i37, label %write_double_array.exit38, label %for.body.i33.for.body.i33_crit_edge, !dbg !618, !llvm.loop !621

for.body.i33.for.body.i33_crit_edge:              ; preds = %for.body.i33
  store i64 %indvars.iv.next.i36, ptr %indvars.iv.i34.reg2mem, align 8
  br label %for.body.i33, !dbg !618

write_double_array.exit38:                        ; preds = %for.body.i33
  ret void, !dbg !622
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #2 !dbg !623 {
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
    #dbg_value(i32 %fd, !625, !DIExpression(), !630)
    #dbg_value(ptr %vdata, !626, !DIExpression(), !630)
    #dbg_value(ptr %vdata, !627, !DIExpression(), !630)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(24576) %vdata, i8 0, i64 24576, i1 false), !dbg !631
  %call = tail call ptr @readfile(i32 noundef signext %fd) #18, !dbg !632
    #dbg_value(ptr %call, !628, !DIExpression(), !630)
    #dbg_value(ptr %call, !464, !DIExpression(), !633)
    #dbg_value(i32 1, !469, !DIExpression(), !633)
    #dbg_value(i32 0, !470, !DIExpression(), !633)
  store ptr %call, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 0, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem72.0.load, !470, !DIExpression(), !633)
    #dbg_value(ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, !464, !DIExpression(), !633)
  %i.041.i.reg2mem72.0.load = load i32, ptr %i.041.i.reg2mem72, align 4
  %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71 = load ptr, ptr %s.addr.040.i.reg2mem70, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, align 1, !dbg !635, !tbaa !474
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !636

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !636

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !636

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !637
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !637, !tbaa !474
  %cmp13.i = icmp eq i8 %1, 37, !dbg !638
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !639

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !639

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 2, !dbg !640
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !640, !tbaa !474
  %cmp18.i = icmp eq i8 %2, 10, !dbg !641
  %inc.i = zext i1 %cmp18.i to i32, !dbg !642
  %spec.select.i = add nsw i32 %i.041.i.reg2mem72.0.load, %inc.i, !dbg !642
  store i32 %spec.select.i, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !642

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem68.0.load, !470, !DIExpression(), !633)
  %i.1.i.reg2mem68.0.load = load i32, ptr %i.1.i.reg2mem68, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !643
    #dbg_value(ptr %incdec.ptr.i, !464, !DIExpression(), !633)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem68.0.load, 1, !dbg !644
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !645, !llvm.loop !646

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 %i.1.i.reg2mem68.0.load, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i, !dbg !645

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !648, !tbaa !474
  %3 = icmp eq i8 %.pre.i, 0, !dbg !649
  %4 = select i1 %3, i64 0, i64 2, !dbg !650
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !645

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !650
    #dbg_value(ptr %spec.select38.i, !629, !DIExpression(), !630)
  %call2 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i, ptr noundef %vdata, i32 noundef signext 1024) #18, !dbg !651
    #dbg_value(ptr %call, !464, !DIExpression(), !652)
    #dbg_value(i32 2, !469, !DIExpression(), !652)
    #dbg_value(i32 0, !470, !DIExpression(), !652)
  store ptr %call, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 0, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem66.0.load, !470, !DIExpression(), !652)
    #dbg_value(ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, !464, !DIExpression(), !652)
  %i.041.i2.reg2mem66.0.load = load i32, ptr %i.041.i2.reg2mem66, align 4
  %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65 = load ptr, ptr %s.addr.040.i3.reg2mem64, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, align 1, !dbg !654, !tbaa !474
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !655

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !655

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !655

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !656
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !656, !tbaa !474
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !657
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !658

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !658

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 2, !dbg !659
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !659, !tbaa !474
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !660
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !661
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem66.0.load, %inc.i19, !dbg !661
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !661

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem62.0.load, !470, !DIExpression(), !652)
  %i.1.i8.reg2mem62.0.load = load i32, ptr %i.1.i8.reg2mem62, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !662
    #dbg_value(ptr %incdec.ptr.i9, !464, !DIExpression(), !652)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem62.0.load, 2, !dbg !663
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !664, !llvm.loop !665

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 %i.1.i8.reg2mem62.0.load, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1, !dbg !664

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !667, !tbaa !474
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !668
  %9 = select i1 %8, i64 0, i64 2, !dbg !669
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !664

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !669
    #dbg_value(ptr %spec.select38.i15, !629, !DIExpression(), !630)
  %img = getelementptr inbounds i8, ptr %vdata, i64 8192, !dbg !670
  %call5 = tail call signext i32 @parse_double_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %img, i32 noundef signext 1024) #18, !dbg !671
  tail call void @free(ptr noundef %call) #18, !dbg !672
  ret void, !dbg !673
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #2 !dbg !674 {
entry.split:
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !676, !DIExpression(), !679)
    #dbg_value(ptr %vdata, !677, !DIExpression(), !679)
    #dbg_value(ptr %vdata, !678, !DIExpression(), !679)
    #dbg_value(i32 %fd, !564, !DIExpression(), !680)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !682
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !682

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !682
  unreachable, !dbg !682

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !683
    #dbg_value(i32 %fd, !575, !DIExpression(), !684)
    #dbg_value(ptr %vdata, !580, !DIExpression(), !684)
    #dbg_value(i32 1024, !581, !DIExpression(), !684)
    #dbg_value(i32 0, !582, !DIExpression(), !684)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !686

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !582, !DIExpression(), !684)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds double, ptr %vdata, i64 %indvars.iv.i.reg2mem.0.load, !dbg !687
  %0 = load double, ptr %arrayidx.i, align 8, !dbg !687, !tbaa !359
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !687
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !688
    #dbg_value(i64 %indvars.iv.next.i, !582, !DIExpression(), !684)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 1024, !dbg !688
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !686, !llvm.loop !689

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !686

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !564, !DIExpression(), !690)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !692
  %img = getelementptr inbounds i8, ptr %vdata, i64 8192, !dbg !693
    #dbg_value(i32 %fd, !575, !DIExpression(), !694)
    #dbg_value(ptr %img, !580, !DIExpression(), !694)
    #dbg_value(i32 1024, !581, !DIExpression(), !694)
    #dbg_value(i32 0, !582, !DIExpression(), !694)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !696

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !582, !DIExpression(), !694)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds double, ptr %img, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !697
  %1 = load double, ptr %arrayidx.i11, align 8, !dbg !697, !tbaa !359
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %1), !dbg !697
  %indvars.iv.next.i12 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !698
    #dbg_value(i64 %indvars.iv.next.i12, !582, !DIExpression(), !694)
  %exitcond.not.i13 = icmp eq i64 %indvars.iv.next.i12, 1024, !dbg !698
  br i1 %exitcond.not.i13, label %write_double_array.exit14, label %for.body.i9.for.body.i9_crit_edge, !dbg !696, !llvm.loop !699

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i12, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !696

write_double_array.exit14:                        ; preds = %for.body.i9
  ret void, !dbg !700
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #5 !dbg !701 {
entry.split:
  %has_errors.030.reg2mem = alloca i32, align 4
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(ptr %vdata, !705, !DIExpression(), !713)
    #dbg_value(ptr %vref, !706, !DIExpression(), !713)
    #dbg_value(ptr %vdata, !707, !DIExpression(), !713)
    #dbg_value(ptr %vref, !708, !DIExpression(), !713)
    #dbg_value(i32 0, !709, !DIExpression(), !713)
    #dbg_value(i32 0, !710, !DIExpression(), !713)
  store i32 0, ptr %has_errors.030.reg2mem, align 4
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !714

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i32 %has_errors.030.reg2mem.0.load, !709, !DIExpression(), !713)
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !710, !DIExpression(), !713)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %has_errors.030.reg2mem.0.load = load i32, ptr %has_errors.030.reg2mem, align 4
  %arrayidx = getelementptr inbounds [1024 x double], ptr %vdata, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !716
  %0 = load double, ptr %arrayidx, align 8, !dbg !716, !tbaa !359
  %arrayidx3 = getelementptr inbounds [1024 x double], ptr %vref, i64 0, i64 %indvars.iv.reg2mem.0.load, !dbg !719
  %1 = load double, ptr %arrayidx3, align 8, !dbg !719, !tbaa !359
  %sub = fsub double %0, %1, !dbg !720
    #dbg_value(double %sub, !711, !DIExpression(), !713)
  %arrayidx5 = getelementptr inbounds %struct.bench_args_t, ptr %vdata, i64 0, i32 1, i64 %indvars.iv.reg2mem.0.load, !dbg !721
  %2 = load double, ptr %arrayidx5, align 8, !dbg !721, !tbaa !359
  %arrayidx8 = getelementptr inbounds %struct.bench_args_t, ptr %vref, i64 0, i32 1, i64 %indvars.iv.reg2mem.0.load, !dbg !722
  %3 = load double, ptr %arrayidx8, align 8, !dbg !722, !tbaa !359
  %sub9 = fsub double %2, %3, !dbg !723
    #dbg_value(double %sub9, !712, !DIExpression(), !713)
  %4 = tail call double @llvm.fabs.f64(double %sub), !dbg !724
  %5 = fcmp ogt double %4, 0x3EB0C6F7A0B5ED8D, !dbg !724
    #dbg_value(!DIArgList(i32 %has_errors.030.reg2mem.0.load, i1 %5), !709, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !713)
  %6 = tail call double @llvm.fabs.f64(double %sub9), !dbg !725
  %7 = fcmp ogt double %6, 0x3EB0C6F7A0B5ED8D, !dbg !725
  %8 = or i1 %5, %7, !dbg !726
  %9 = zext i1 %8 to i32, !dbg !726
  %or17 = or i32 %has_errors.030.reg2mem.0.load, %9, !dbg !726
    #dbg_value(i32 %or17, !709, !DIExpression(), !713)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !727
    #dbg_value(i64 %indvars.iv.next, !710, !DIExpression(), !713)
  %exitcond.not = icmp eq i64 %indvars.iv.next, 1024, !dbg !728
  br i1 %exitcond.not, label %for.end, label %for.body.for.body_crit_edge, !dbg !714, !llvm.loop !729

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i32 %or17, ptr %has_errors.030.reg2mem, align 4
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !714

for.end:                                          ; preds = %for.body
  %tobool.not = icmp eq i32 %or17, 0, !dbg !731
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !731
  ret i32 %lnot.ext, !dbg !732
}

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #2 !dbg !733 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !783
    #dbg_assign(i1 undef, !739, !DIExpression(), !783, ptr %s, !DIExpression(), !784)
    #dbg_value(i32 %fd, !737, !DIExpression(), !784)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #18, !dbg !785
  %cmp = icmp sgt i32 %fd, 1, !dbg !786
  br i1 %cmp, label %if.end, label %if.else, !dbg !786

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !786
  unreachable, !dbg !786

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #18, !dbg !789
  %cmp1 = icmp eq i32 %call, 0, !dbg !789
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !789

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !789
  unreachable, !dbg !789

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !792
  %0 = load i64, ptr %st_size, align 8, !dbg !792
    #dbg_value(i64 %0, !776, !DIExpression(), !784)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !793
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !793

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !793
  unreachable, !dbg !793

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !796
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #20, !dbg !797
    #dbg_value(ptr %call11, !738, !DIExpression(), !784)
    #dbg_value(i64 0, !779, !DIExpression(), !784)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !798

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !799
    #dbg_value(i64 %add19, !779, !DIExpression(), !784)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !801
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !798, !llvm.loop !802

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !798

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !779, !DIExpression(), !784)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !804
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !805
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #18, !dbg !806
    #dbg_value(i64 %call13, !782, !DIExpression(), !784)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !807
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !779, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !784)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !807

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #19, !dbg !807
  unreachable, !dbg !807

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !810
  store i8 0, ptr %arrayidx20, align 1, !dbg !811, !tbaa !474
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #18, !dbg !812
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #18, !dbg !813
  ret ptr %call11, !dbg !814
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: noreturn nounwind
declare !dbg !815 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #7

; Function Attrs: nofree nounwind
declare !dbg !820 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !825 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #9

; Function Attrs: nofree
declare !dbg !830 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #10

declare !dbg !834 signext i32 @close(i32 noundef signext) local_unnamed_addr #11

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #6

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #2 !dbg !465 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !464, !DIExpression(), !835)
    #dbg_value(i32 %n, !469, !DIExpression(), !835)
    #dbg_value(i32 0, !470, !DIExpression(), !835)
  %cmp = icmp sgt i32 %n, -1, !dbg !836
  br i1 %cmp, label %if.end, label %if.else, !dbg !836

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #19, !dbg !836
  unreachable, !dbg !836

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !839
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !841

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !841

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !841

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !470, !DIExpression(), !835)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !464, !DIExpression(), !835)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !842, !tbaa !474
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !843

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !843

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !843

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !844
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !844, !tbaa !474
  %cmp13 = icmp eq i8 %1, 37, !dbg !845
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !846

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !846

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !847
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !847, !tbaa !474
  %cmp18 = icmp eq i8 %2, 10, !dbg !848
  %inc = zext i1 %cmp18 to i32, !dbg !849
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !849
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !849

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !470, !DIExpression(), !835)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !850
    #dbg_value(ptr %incdec.ptr, !464, !DIExpression(), !835)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !851
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !852, !llvm.loop !853

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !852

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !855, !tbaa !474
  %3 = icmp eq i8 %.pre, 0, !dbg !856
  %4 = select i1 %3, i64 0, i64 2, !dbg !857
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !852

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !857
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !857

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !858
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !859 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !863, !DIExpression(), !867)
    #dbg_value(ptr %arr, !864, !DIExpression(), !867)
    #dbg_value(i32 %n, !865, !DIExpression(), !867)
  %cmp.not = icmp eq ptr %s, null, !dbg !868
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !868

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #19, !dbg !868
  unreachable, !dbg !868

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !871
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !873

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !874
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !876
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !876

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !866, !DIExpression(), !867)
  %conv404 = zext nneg i32 %n to i64, !dbg !877
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !878
  br label %if.end46, !dbg !879

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !866, !DIExpression(), !867)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !880
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !881

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !881

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !882
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !883
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !883
  %cmp9.not = icmp eq i8 %0, 0, !dbg !884
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !885

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !885

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !886
  %1 = load i8, ptr %gep, align 1, !dbg !886
  %cmp16.not = icmp eq i8 %1, 0, !dbg !887
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !888

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !888

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !889
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !890
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !890
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !890, !llvm.loop !891

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !890

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !877

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !877

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !877

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !877
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !866, !DIExpression(), !867)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !878
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !893
  store i8 0, ptr %arrayidx45, align 1, !dbg !895, !tbaa !474
  br label %if.end46, !dbg !893

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !896
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #12

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !897 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !909
    #dbg_assign(i1 undef, !906, !DIExpression(), !909, ptr %endptr, !DIExpression(), !910)
    #dbg_value(ptr %s, !902, !DIExpression(), !910)
    #dbg_value(ptr %arr, !903, !DIExpression(), !910)
    #dbg_value(i32 %n, !904, !DIExpression(), !910)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !911
    #dbg_value(i32 0, !907, !DIExpression(), !910)
  %cmp.not = icmp eq ptr %s, null, !dbg !912
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !912

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #19, !dbg !912
  unreachable, !dbg !912

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !911
    #dbg_value(ptr %call, !905, !DIExpression(), !910)
    #dbg_value(i32 0, !907, !DIExpression(), !910)
  %cmp130 = icmp ne ptr %call, null, !dbg !911
  %cmp231 = icmp sgt i32 %n, 0, !dbg !911
  %0 = and i1 %cmp231, %cmp130, !dbg !911
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !911

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !911

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !911
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !911

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !905, !DIExpression(), !910)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !907, !DIExpression(), !910)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !915, !tbaa !917, !DIAssignID !919
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !906, !DIExpression(), !919, ptr %endptr, !DIExpression(), !910)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !915
  %conv = trunc i64 %call3 to i8, !dbg !915
    #dbg_value(i8 %conv, !908, !DIExpression(), !910)
  %2 = load ptr, ptr %endptr, align 8, !dbg !920, !tbaa !917
  %3 = load i8, ptr %2, align 1, !dbg !920, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !920
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !915

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !915

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !922, !tbaa !917
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !922
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !922
  br label %if.end9, !dbg !922

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !915
  store i8 %conv, ptr %arrayidx, align 1, !dbg !915, !tbaa !474
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !915
    #dbg_value(i64 %indvars.iv.next, !907, !DIExpression(), !910)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !915
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !915
  store i8 10, ptr %arrayidx11, align 1, !dbg !915, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !915
    #dbg_value(ptr %call12, !905, !DIExpression(), !910)
  %cmp1 = icmp ne ptr %call12, null, !dbg !911
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !911
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !911
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !911, !llvm.loop !924

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !911

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !911

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !911

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !911

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !925
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !925
  store i8 10, ptr %arrayidx17, align 1, !dbg !925, !tbaa !474
  br label %if.end18, !dbg !925

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !911
  ret i32 0, !dbg !911
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !928 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #13

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !934 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #13

; Function Attrs: nofree nounwind
declare !dbg !939 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #8

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !994 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #14

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !997 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1009
    #dbg_assign(i1 undef, !1006, !DIExpression(), !1009, ptr %endptr, !DIExpression(), !1010)
    #dbg_value(ptr %s, !1002, !DIExpression(), !1010)
    #dbg_value(ptr %arr, !1003, !DIExpression(), !1010)
    #dbg_value(i32 %n, !1004, !DIExpression(), !1010)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1011
    #dbg_value(i32 0, !1007, !DIExpression(), !1010)
  %cmp.not = icmp eq ptr %s, null, !dbg !1012
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1012

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #19, !dbg !1012
  unreachable, !dbg !1012

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1011
    #dbg_value(ptr %call, !1005, !DIExpression(), !1010)
    #dbg_value(i32 0, !1007, !DIExpression(), !1010)
  %cmp130 = icmp ne ptr %call, null, !dbg !1011
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1011
  %0 = and i1 %cmp231, %cmp130, !dbg !1011
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1011

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1011

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1011
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1011

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1005, !DIExpression(), !1010)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1007, !DIExpression(), !1010)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1015, !tbaa !917, !DIAssignID !1017
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1006, !DIExpression(), !1017, ptr %endptr, !DIExpression(), !1010)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1015
  %conv = trunc i64 %call3 to i16, !dbg !1015
    #dbg_value(i16 %conv, !1008, !DIExpression(), !1010)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1018, !tbaa !917
  %3 = load i8, ptr %2, align 1, !dbg !1018, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1018
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1015

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1015

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1020, !tbaa !917
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1020
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1020
  br label %if.end9, !dbg !1020

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1015
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1015, !tbaa !1022
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1015
    #dbg_value(i64 %indvars.iv.next, !1007, !DIExpression(), !1010)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1015
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1015
  store i8 10, ptr %arrayidx11, align 1, !dbg !1015, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1015
    #dbg_value(ptr %call12, !1005, !DIExpression(), !1010)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1011
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1011
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1011
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1011, !llvm.loop !1024

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1011

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1011

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1011

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1011

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1025
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1025
  store i8 10, ptr %arrayidx17, align 1, !dbg !1025, !tbaa !474
  br label %if.end18, !dbg !1025

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1011
  ret i32 0, !dbg !1011
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1028 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1040
    #dbg_assign(i1 undef, !1037, !DIExpression(), !1040, ptr %endptr, !DIExpression(), !1041)
    #dbg_value(ptr %s, !1033, !DIExpression(), !1041)
    #dbg_value(ptr %arr, !1034, !DIExpression(), !1041)
    #dbg_value(i32 %n, !1035, !DIExpression(), !1041)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1042
    #dbg_value(i32 0, !1038, !DIExpression(), !1041)
  %cmp.not = icmp eq ptr %s, null, !dbg !1043
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1043

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #19, !dbg !1043
  unreachable, !dbg !1043

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1042
    #dbg_value(ptr %call, !1036, !DIExpression(), !1041)
    #dbg_value(i32 0, !1038, !DIExpression(), !1041)
  %cmp130 = icmp ne ptr %call, null, !dbg !1042
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1042
  %0 = and i1 %cmp231, %cmp130, !dbg !1042
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1042

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1042

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1042
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1042

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1036, !DIExpression(), !1041)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1038, !DIExpression(), !1041)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1046, !tbaa !917, !DIAssignID !1048
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1037, !DIExpression(), !1048, ptr %endptr, !DIExpression(), !1041)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1046
  %conv = trunc i64 %call3 to i32, !dbg !1046
    #dbg_value(i32 %conv, !1039, !DIExpression(), !1041)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1049, !tbaa !917
  %3 = load i8, ptr %2, align 1, !dbg !1049, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1049
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1046

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1046

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1051, !tbaa !917
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1051
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1051
  br label %if.end9, !dbg !1051

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1046
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1046, !tbaa !1053
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1046
    #dbg_value(i64 %indvars.iv.next, !1038, !DIExpression(), !1041)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1046
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1046
  store i8 10, ptr %arrayidx11, align 1, !dbg !1046, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1046
    #dbg_value(ptr %call12, !1036, !DIExpression(), !1041)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1042
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1042
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1042
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1042, !llvm.loop !1055

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1042

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1042

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1042

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1042

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1056
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1056
  store i8 10, ptr %arrayidx17, align 1, !dbg !1056, !tbaa !474
  br label %if.end18, !dbg !1056

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1042
  ret i32 0, !dbg !1042
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1059 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1071
    #dbg_assign(i1 undef, !1068, !DIExpression(), !1071, ptr %endptr, !DIExpression(), !1072)
    #dbg_value(ptr %s, !1064, !DIExpression(), !1072)
    #dbg_value(ptr %arr, !1065, !DIExpression(), !1072)
    #dbg_value(i32 %n, !1066, !DIExpression(), !1072)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1073
    #dbg_value(i32 0, !1069, !DIExpression(), !1072)
  %cmp.not = icmp eq ptr %s, null, !dbg !1074
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1074

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #19, !dbg !1074
  unreachable, !dbg !1074

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1073
    #dbg_value(ptr %call, !1067, !DIExpression(), !1072)
    #dbg_value(i32 0, !1069, !DIExpression(), !1072)
  %cmp129 = icmp ne ptr %call, null, !dbg !1073
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1073
  %0 = and i1 %cmp230, %cmp129, !dbg !1073
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1073

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1073

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1073
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1073

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1067, !DIExpression(), !1072)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1069, !DIExpression(), !1072)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1077, !tbaa !917, !DIAssignID !1079
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1068, !DIExpression(), !1079, ptr %endptr, !DIExpression(), !1072)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1077
    #dbg_value(i64 %call3, !1070, !DIExpression(), !1072)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1080, !tbaa !917
  %3 = load i8, ptr %2, align 1, !dbg !1080, !tbaa !474
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1080
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1077

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1077

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1082, !tbaa !917
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1082
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1082
  br label %if.end8, !dbg !1082

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1077
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1077, !tbaa !1084
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1077
    #dbg_value(i64 %indvars.iv.next, !1069, !DIExpression(), !1072)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1077
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1077
  store i8 10, ptr %arrayidx10, align 1, !dbg !1077, !tbaa !474
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1077
    #dbg_value(ptr %call11, !1067, !DIExpression(), !1072)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1073
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1073
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1073
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1073, !llvm.loop !1086

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1073

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1073

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1073

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1073

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1087
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1087
  store i8 10, ptr %arrayidx16, align 1, !dbg !1087, !tbaa !474
  br label %if.end17, !dbg !1087

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1073
  ret i32 0, !dbg !1073
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1090 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1102
    #dbg_assign(i1 undef, !1099, !DIExpression(), !1102, ptr %endptr, !DIExpression(), !1103)
    #dbg_value(ptr %s, !1095, !DIExpression(), !1103)
    #dbg_value(ptr %arr, !1096, !DIExpression(), !1103)
    #dbg_value(i32 %n, !1097, !DIExpression(), !1103)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1104
    #dbg_value(i32 0, !1100, !DIExpression(), !1103)
  %cmp.not = icmp eq ptr %s, null, !dbg !1105
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1105

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #19, !dbg !1105
  unreachable, !dbg !1105

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1104
    #dbg_value(ptr %call, !1098, !DIExpression(), !1103)
    #dbg_value(i32 0, !1100, !DIExpression(), !1103)
  %cmp130 = icmp ne ptr %call, null, !dbg !1104
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1104
  %0 = and i1 %cmp231, %cmp130, !dbg !1104
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1104

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1104

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1104
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1104

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1098, !DIExpression(), !1103)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1100, !DIExpression(), !1103)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1108, !tbaa !917, !DIAssignID !1110
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1099, !DIExpression(), !1110, ptr %endptr, !DIExpression(), !1103)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1108
  %conv = trunc i64 %call3 to i8, !dbg !1108
    #dbg_value(i8 %conv, !1101, !DIExpression(), !1103)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1111, !tbaa !917
  %3 = load i8, ptr %2, align 1, !dbg !1111, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1111
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1108

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1108

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1113, !tbaa !917
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1113
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1113
  br label %if.end9, !dbg !1113

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1108
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1108, !tbaa !474
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1108
    #dbg_value(i64 %indvars.iv.next, !1100, !DIExpression(), !1103)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1108
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1108
  store i8 10, ptr %arrayidx11, align 1, !dbg !1108, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1108
    #dbg_value(ptr %call12, !1098, !DIExpression(), !1103)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1104
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1104
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1104
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1104, !llvm.loop !1115

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1104

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1104

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1104

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1104

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1116
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1116
  store i8 10, ptr %arrayidx17, align 1, !dbg !1116, !tbaa !474
  br label %if.end18, !dbg !1116

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1104
  ret i32 0, !dbg !1104
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1119 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1131
    #dbg_assign(i1 undef, !1128, !DIExpression(), !1131, ptr %endptr, !DIExpression(), !1132)
    #dbg_value(ptr %s, !1124, !DIExpression(), !1132)
    #dbg_value(ptr %arr, !1125, !DIExpression(), !1132)
    #dbg_value(i32 %n, !1126, !DIExpression(), !1132)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1133
    #dbg_value(i32 0, !1129, !DIExpression(), !1132)
  %cmp.not = icmp eq ptr %s, null, !dbg !1134
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1134

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #19, !dbg !1134
  unreachable, !dbg !1134

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1133
    #dbg_value(ptr %call, !1127, !DIExpression(), !1132)
    #dbg_value(i32 0, !1129, !DIExpression(), !1132)
  %cmp130 = icmp ne ptr %call, null, !dbg !1133
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1133
  %0 = and i1 %cmp231, %cmp130, !dbg !1133
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1133

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1133

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1133
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1133

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1127, !DIExpression(), !1132)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1129, !DIExpression(), !1132)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1137, !tbaa !917, !DIAssignID !1139
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1128, !DIExpression(), !1139, ptr %endptr, !DIExpression(), !1132)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1137
  %conv = trunc i64 %call3 to i16, !dbg !1137
    #dbg_value(i16 %conv, !1130, !DIExpression(), !1132)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1140, !tbaa !917
  %3 = load i8, ptr %2, align 1, !dbg !1140, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1140
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1137

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1137

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1142, !tbaa !917
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1142
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1142
  br label %if.end9, !dbg !1142

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1137
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1137, !tbaa !1022
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1137
    #dbg_value(i64 %indvars.iv.next, !1129, !DIExpression(), !1132)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1137
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1137
  store i8 10, ptr %arrayidx11, align 1, !dbg !1137, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1137
    #dbg_value(ptr %call12, !1127, !DIExpression(), !1132)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1133
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1133
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1133
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1133, !llvm.loop !1144

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1133

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1133

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1133

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1133

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1145
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1145
  store i8 10, ptr %arrayidx17, align 1, !dbg !1145, !tbaa !474
  br label %if.end18, !dbg !1145

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1133
  ret i32 0, !dbg !1133
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1148 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1160
    #dbg_assign(i1 undef, !1157, !DIExpression(), !1160, ptr %endptr, !DIExpression(), !1161)
    #dbg_value(ptr %s, !1153, !DIExpression(), !1161)
    #dbg_value(ptr %arr, !1154, !DIExpression(), !1161)
    #dbg_value(i32 %n, !1155, !DIExpression(), !1161)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1162
    #dbg_value(i32 0, !1158, !DIExpression(), !1161)
  %cmp.not = icmp eq ptr %s, null, !dbg !1163
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1163

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #19, !dbg !1163
  unreachable, !dbg !1163

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1162
    #dbg_value(ptr %call, !1156, !DIExpression(), !1161)
    #dbg_value(i32 0, !1158, !DIExpression(), !1161)
  %cmp130 = icmp ne ptr %call, null, !dbg !1162
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1162
  %0 = and i1 %cmp231, %cmp130, !dbg !1162
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1162

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1162

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1162
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1162

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1156, !DIExpression(), !1161)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1158, !DIExpression(), !1161)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1166, !tbaa !917, !DIAssignID !1168
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1157, !DIExpression(), !1168, ptr %endptr, !DIExpression(), !1161)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1166
  %conv = trunc i64 %call3 to i32, !dbg !1166
    #dbg_value(i32 %conv, !1159, !DIExpression(), !1161)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1169, !tbaa !917
  %3 = load i8, ptr %2, align 1, !dbg !1169, !tbaa !474
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1169
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1166

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1166

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1171, !tbaa !917
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1171
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1171
  br label %if.end9, !dbg !1171

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1166
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1166, !tbaa !1053
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1166
    #dbg_value(i64 %indvars.iv.next, !1158, !DIExpression(), !1161)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #22, !dbg !1166
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1166
  store i8 10, ptr %arrayidx11, align 1, !dbg !1166, !tbaa !474
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1166
    #dbg_value(ptr %call12, !1156, !DIExpression(), !1161)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1162
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1162
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1162
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1162, !llvm.loop !1173

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1162

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1162

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1162

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1162

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1174
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1174
  store i8 10, ptr %arrayidx17, align 1, !dbg !1174, !tbaa !474
  br label %if.end18, !dbg !1174

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1162
  ret i32 0, !dbg !1162
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1177 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1189
    #dbg_assign(i1 undef, !1186, !DIExpression(), !1189, ptr %endptr, !DIExpression(), !1190)
    #dbg_value(ptr %s, !1182, !DIExpression(), !1190)
    #dbg_value(ptr %arr, !1183, !DIExpression(), !1190)
    #dbg_value(i32 %n, !1184, !DIExpression(), !1190)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1191
    #dbg_value(i32 0, !1187, !DIExpression(), !1190)
  %cmp.not = icmp eq ptr %s, null, !dbg !1192
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1192

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #19, !dbg !1192
  unreachable, !dbg !1192

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1191
    #dbg_value(ptr %call, !1185, !DIExpression(), !1190)
    #dbg_value(i32 0, !1187, !DIExpression(), !1190)
  %cmp129 = icmp ne ptr %call, null, !dbg !1191
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1191
  %0 = and i1 %cmp230, %cmp129, !dbg !1191
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1191

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1191

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1191
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1191

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1185, !DIExpression(), !1190)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1187, !DIExpression(), !1190)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1195, !tbaa !917, !DIAssignID !1197
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1186, !DIExpression(), !1197, ptr %endptr, !DIExpression(), !1190)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #18, !dbg !1195
    #dbg_value(i64 %call3, !1188, !DIExpression(), !1190)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1198, !tbaa !917
  %3 = load i8, ptr %2, align 1, !dbg !1198, !tbaa !474
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1198
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1195

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1195

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1200, !tbaa !917
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1200
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1200
  br label %if.end8, !dbg !1200

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1195
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1195, !tbaa !1084
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1195
    #dbg_value(i64 %indvars.iv.next, !1187, !DIExpression(), !1190)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1195
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1195
  store i8 10, ptr %arrayidx10, align 1, !dbg !1195, !tbaa !474
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1195
    #dbg_value(ptr %call11, !1185, !DIExpression(), !1190)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1191
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1191
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1191
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1191, !llvm.loop !1202

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1191

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1191

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1191

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1191

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1203
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1203
  store i8 10, ptr %arrayidx16, align 1, !dbg !1203, !tbaa !474
  br label %if.end17, !dbg !1203

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1191
  ret i32 0, !dbg !1191
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1206 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1218
    #dbg_assign(i1 undef, !1215, !DIExpression(), !1218, ptr %endptr, !DIExpression(), !1219)
    #dbg_value(ptr %s, !1211, !DIExpression(), !1219)
    #dbg_value(ptr %arr, !1212, !DIExpression(), !1219)
    #dbg_value(i32 %n, !1213, !DIExpression(), !1219)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1220
    #dbg_value(i32 0, !1216, !DIExpression(), !1219)
  %cmp.not = icmp eq ptr %s, null, !dbg !1221
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1221

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #19, !dbg !1221
  unreachable, !dbg !1221

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1220
    #dbg_value(ptr %call, !1214, !DIExpression(), !1219)
    #dbg_value(i32 0, !1216, !DIExpression(), !1219)
  %cmp129 = icmp ne ptr %call, null, !dbg !1220
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1220
  %0 = and i1 %cmp230, %cmp129, !dbg !1220
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1220

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1220

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1220
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1220

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1214, !DIExpression(), !1219)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1216, !DIExpression(), !1219)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1224, !tbaa !917, !DIAssignID !1226
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1215, !DIExpression(), !1226, ptr %endptr, !DIExpression(), !1219)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1224
    #dbg_value(float %call3, !1217, !DIExpression(), !1219)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1227, !tbaa !917
  %3 = load i8, ptr %2, align 1, !dbg !1227, !tbaa !474
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1227
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1224

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1224

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1229, !tbaa !917
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1229
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1229
  br label %if.end8, !dbg !1229

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1224
  store float %call3, ptr %arrayidx, align 4, !dbg !1224, !tbaa !1231
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1224
    #dbg_value(i64 %indvars.iv.next, !1216, !DIExpression(), !1219)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1224
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1224
  store i8 10, ptr %arrayidx10, align 1, !dbg !1224, !tbaa !474
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1224
    #dbg_value(ptr %call11, !1214, !DIExpression(), !1219)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1220
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1220
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1220
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1220, !llvm.loop !1233

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1220

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1220

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1220

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1220

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1234
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1234
  store i8 10, ptr %arrayidx16, align 1, !dbg !1234, !tbaa !474
  br label %if.end17, !dbg !1234

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1220
  ret i32 0, !dbg !1220
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1237 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1240 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1251
    #dbg_assign(i1 undef, !1248, !DIExpression(), !1251, ptr %endptr, !DIExpression(), !1252)
    #dbg_value(ptr %s, !1244, !DIExpression(), !1252)
    #dbg_value(ptr %arr, !1245, !DIExpression(), !1252)
    #dbg_value(i32 %n, !1246, !DIExpression(), !1252)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1253
    #dbg_value(i32 0, !1249, !DIExpression(), !1252)
  %cmp.not = icmp eq ptr %s, null, !dbg !1254
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1254

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #19, !dbg !1254
  unreachable, !dbg !1254

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #18, !dbg !1253
    #dbg_value(ptr %call, !1247, !DIExpression(), !1252)
    #dbg_value(i32 0, !1249, !DIExpression(), !1252)
  %cmp129 = icmp ne ptr %call, null, !dbg !1253
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1253
  %0 = and i1 %cmp230, %cmp129, !dbg !1253
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1253

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1253

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1253
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1253

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1247, !DIExpression(), !1252)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1249, !DIExpression(), !1252)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1257, !tbaa !917, !DIAssignID !1259
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1248, !DIExpression(), !1259, ptr %endptr, !DIExpression(), !1252)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #18, !dbg !1257
    #dbg_value(double %call3, !1250, !DIExpression(), !1252)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1260, !tbaa !917
  %3 = load i8, ptr %2, align 1, !dbg !1260, !tbaa !474
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1260
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1257

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1257

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1262, !tbaa !917
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1262
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #21, !dbg !1262
  br label %if.end8, !dbg !1262

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1257
  store double %call3, ptr %arrayidx, align 8, !dbg !1257, !tbaa !359
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1257
    #dbg_value(i64 %indvars.iv.next, !1249, !DIExpression(), !1252)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #22, !dbg !1257
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1257
  store i8 10, ptr %arrayidx10, align 1, !dbg !1257, !tbaa !474
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #18, !dbg !1257
    #dbg_value(ptr %call11, !1247, !DIExpression(), !1252)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1253
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1253
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1253
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1253, !llvm.loop !1264

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1253

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1253

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1253

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1253

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #22, !dbg !1265
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1265
  store i8 10, ptr %arrayidx16, align 1, !dbg !1265, !tbaa !474
  br label %if.end17, !dbg !1265

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #18, !dbg !1253
  ret i32 0, !dbg !1253
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1268 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1271 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1275, !DIExpression(), !1280)
    #dbg_value(ptr %arr, !1276, !DIExpression(), !1280)
    #dbg_value(i32 %n, !1277, !DIExpression(), !1280)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1281
  br i1 %cmp, label %if.end, label %if.else, !dbg !1281

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1281
  unreachable, !dbg !1281

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1284
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1286

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1286

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #22, !dbg !1287
  %conv = trunc i64 %call to i32, !dbg !1287
    #dbg_value(i32 %conv, !1277, !DIExpression(), !1280)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1289

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1277, !DIExpression(), !1280)
    #dbg_value(i32 0, !1279, !DIExpression(), !1280)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1290
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1291

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1291

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1291

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1292

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1293
    #dbg_value(i32 %add, !1279, !DIExpression(), !1280)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1290
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1291, !llvm.loop !1295

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1291

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1291

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1279, !DIExpression(), !1280)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1297
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1297
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1298
  %conv6 = sext i32 %sub to i64, !dbg !1299
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #18, !dbg !1300
  %conv8 = trunc i64 %call7 to i32, !dbg !1300
    #dbg_value(i32 %conv8, !1278, !DIExpression(), !1280)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1301
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1279, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1280)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1301

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1301
  unreachable, !dbg !1301

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #18, !dbg !1304
  %conv16 = trunc i64 %call15 to i32, !dbg !1304
    #dbg_value(i32 %conv16, !1278, !DIExpression(), !1280)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1306
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1306

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #19, !dbg !1306
  unreachable, !dbg !1306

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1309
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1310, !llvm.loop !1311

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1310

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1313
}

; Function Attrs: nofree
declare !dbg !1314 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #10

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1319 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1323, !DIExpression(), !1327)
    #dbg_value(ptr %arr, !1324, !DIExpression(), !1327)
    #dbg_value(i32 %n, !1325, !DIExpression(), !1327)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1328
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1328

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1326, !DIExpression(), !1327)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1331
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1334

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1334

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1331
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1334

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #19, !dbg !1328
  unreachable, !dbg !1328

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1326, !DIExpression(), !1327)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1335
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1335, !tbaa !474
  %conv = zext i8 %0 to i32, !dbg !1335
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1335
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1331
    #dbg_value(i64 %indvars.iv.next, !1326, !DIExpression(), !1327)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1331
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1334, !llvm.loop !1337

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1334

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1334

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1338
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #15 !dbg !1339 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1356
    #dbg_assign(i1 undef, !1345, !DIExpression(), !1356, ptr %args, !DIExpression(), !1357)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1358
    #dbg_assign(i1 undef, !1352, !DIExpression(), !1358, ptr %buffer, !DIExpression(), !1357)
    #dbg_value(i32 %fd, !1343, !DIExpression(), !1357)
    #dbg_value(ptr %format, !1344, !DIExpression(), !1357)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #18, !dbg !1359
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1360
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1361
  %0 = load ptr, ptr %args, align 8, !dbg !1362, !tbaa !917
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #18, !dbg !1363
    #dbg_value(i32 %call, !1349, !DIExpression(), !1357)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1364
  %cmp = icmp slt i32 %call, 256, !dbg !1365
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1365

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1350, !DIExpression(), !1357)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1368
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1369

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1369

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1369

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1365
  unreachable, !dbg !1365

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1370
    #dbg_value(i32 %add, !1350, !DIExpression(), !1357)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1368
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1369, !llvm.loop !1372

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1369

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1369

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1350, !DIExpression(), !1357)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1374
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1374
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1375
  %conv = sext i32 %sub to i64, !dbg !1376
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #18, !dbg !1377
  %conv3 = trunc i64 %call2 to i32, !dbg !1377
    #dbg_value(i32 %conv3, !1351, !DIExpression(), !1357)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1378
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1350, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1357)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1378

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1378
  unreachable, !dbg !1378

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1381
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1381

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #19, !dbg !1381
  unreachable, !dbg !1381

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #18, !dbg !1384
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #18, !dbg !1384
  ret void, !dbg !1385
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #16

; Function Attrs: nofree nounwind
declare !dbg !1386 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #8

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #16

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1391 {
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
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #19, !dbg !1400
  unreachable, !dbg !1400

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1398, !DIExpression(), !1399)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1407
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1407, !tbaa !1022
  %conv = zext i16 %0 to i32, !dbg !1407
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

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1411 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1415, !DIExpression(), !1419)
    #dbg_value(ptr %arr, !1416, !DIExpression(), !1419)
    #dbg_value(i32 %n, !1417, !DIExpression(), !1419)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1420
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1420

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1418, !DIExpression(), !1419)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1423
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1426

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1426

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1423
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1426

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #19, !dbg !1420
  unreachable, !dbg !1420

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1418, !DIExpression(), !1419)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1427
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1427, !tbaa !1053
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1427
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1423
    #dbg_value(i64 %indvars.iv.next, !1418, !DIExpression(), !1419)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1423
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1426, !llvm.loop !1429

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1426

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1426

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1430
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1431 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1435, !DIExpression(), !1439)
    #dbg_value(ptr %arr, !1436, !DIExpression(), !1439)
    #dbg_value(i32 %n, !1437, !DIExpression(), !1439)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1440
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1440

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1438, !DIExpression(), !1439)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1443
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1446

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1446

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1443
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1446

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #19, !dbg !1440
  unreachable, !dbg !1440

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1438, !DIExpression(), !1439)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1447
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1447, !tbaa !1084
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1447
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1443
    #dbg_value(i64 %indvars.iv.next, !1438, !DIExpression(), !1439)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1443
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1446, !llvm.loop !1449

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1446

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1446

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1450
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1451 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1455, !DIExpression(), !1459)
    #dbg_value(ptr %arr, !1456, !DIExpression(), !1459)
    #dbg_value(i32 %n, !1457, !DIExpression(), !1459)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1460
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1460

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1458, !DIExpression(), !1459)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1463
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1466

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1466

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1463
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1466

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #19, !dbg !1460
  unreachable, !dbg !1460

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1458, !DIExpression(), !1459)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1467
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1467, !tbaa !474
  %conv = sext i8 %0 to i32, !dbg !1467
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1467
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1463
    #dbg_value(i64 %indvars.iv.next, !1458, !DIExpression(), !1459)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1463
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1466, !llvm.loop !1469

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1466

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1466

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1470
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1471 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1475, !DIExpression(), !1479)
    #dbg_value(ptr %arr, !1476, !DIExpression(), !1479)
    #dbg_value(i32 %n, !1477, !DIExpression(), !1479)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1480
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1480

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1478, !DIExpression(), !1479)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1483
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1486

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1486

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1483
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1486

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #19, !dbg !1480
  unreachable, !dbg !1480

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1478, !DIExpression(), !1479)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1487
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1487, !tbaa !1022
  %conv = sext i16 %0 to i32, !dbg !1487
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1487
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1483
    #dbg_value(i64 %indvars.iv.next, !1478, !DIExpression(), !1479)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1483
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1486, !llvm.loop !1489

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1486

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1486

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1490
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1491 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1495, !DIExpression(), !1499)
    #dbg_value(ptr %arr, !1496, !DIExpression(), !1499)
    #dbg_value(i32 %n, !1497, !DIExpression(), !1499)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1500
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1500

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1498, !DIExpression(), !1499)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1503
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1506

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1506

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1503
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1506

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #19, !dbg !1500
  unreachable, !dbg !1500

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1498, !DIExpression(), !1499)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1507
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1507, !tbaa !1053
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1507
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1503
    #dbg_value(i64 %indvars.iv.next, !1498, !DIExpression(), !1499)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1503
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1506, !llvm.loop !1509

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1506

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1506

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1510
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1511 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1515, !DIExpression(), !1519)
    #dbg_value(ptr %arr, !1516, !DIExpression(), !1519)
    #dbg_value(i32 %n, !1517, !DIExpression(), !1519)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1520
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1520

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1518, !DIExpression(), !1519)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1523
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1526

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1526

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1523
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1526

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #19, !dbg !1520
  unreachable, !dbg !1520

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1518, !DIExpression(), !1519)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1527
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1527, !tbaa !1084
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1527
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1523
    #dbg_value(i64 %indvars.iv.next, !1518, !DIExpression(), !1519)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1523
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1526, !llvm.loop !1529

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1526

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1526

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1530
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !1531 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1535, !DIExpression(), !1539)
    #dbg_value(ptr %arr, !1536, !DIExpression(), !1539)
    #dbg_value(i32 %n, !1537, !DIExpression(), !1539)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1540
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1540

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1538, !DIExpression(), !1539)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1543
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1546

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1546

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1543
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1546

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #19, !dbg !1540
  unreachable, !dbg !1540

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1538, !DIExpression(), !1539)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1547
  %0 = load float, ptr %arrayidx, align 4, !dbg !1547, !tbaa !1231
  %conv = fpext float %0 to double, !dbg !1547
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1547
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1543
    #dbg_value(i64 %indvars.iv.next, !1538, !DIExpression(), !1539)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1543
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1546, !llvm.loop !1549

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1546

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1546

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1550
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #2 !dbg !576 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !575, !DIExpression(), !1551)
    #dbg_value(ptr %arr, !580, !DIExpression(), !1551)
    #dbg_value(i32 %n, !581, !DIExpression(), !1551)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1552
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1552

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !582, !DIExpression(), !1551)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1555
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1556

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1556

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1555
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1556

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #19, !dbg !1552
  unreachable, !dbg !1552

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !582, !DIExpression(), !1551)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1557
  %0 = load double, ptr %arrayidx, align 8, !dbg !1557, !tbaa !359
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1557
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1555
    #dbg_value(i64 %indvars.iv.next, !582, !DIExpression(), !1551)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1555
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1556, !llvm.loop !1558

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1556

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1556

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1559
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #2 !dbg !565 {
entry.split:
    #dbg_value(i32 %fd, !564, !DIExpression(), !1560)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1561
  br i1 %cmp, label %if.end, label %if.else, !dbg !1561

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1561
  unreachable, !dbg !1561

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1562
  ret i32 0, !dbg !1563
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #2 !dbg !1564 {
entry.split:
  %retval.0.reg2mem = alloca i32, align 4
  %has_errors.030.i.reg2mem = alloca i32, align 4
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %indvars.iv.i10.i.reg2mem = alloca i64, align 8
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %odd.0104.i.i.reg2mem = alloca i32, align 4
  %span.0105.i.i.reg2mem53 = alloca i32, align 4
  %log.0106.i.i.reg2mem55 = alloca i32, align 4
  %check_file.0.reg2mem57 = alloca ptr, align 8
  %in_file.06.reg2mem59 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1568, !DIExpression(), !1577)
    #dbg_value(ptr %argv, !1569, !DIExpression(), !1577)
  %cmp = icmp slt i32 %argc, 4, !dbg !1578
  br i1 %cmp, label %if.end, label %if.else, !dbg !1578

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1578
  unreachable, !dbg !1578

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1570, !DIExpression(), !1577)
    #dbg_value(ptr @.str.4.13, !1571, !DIExpression(), !1577)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1581
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1583

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.13, ptr %check_file.0.reg2mem57, align 8
  store ptr @.str.3, ptr %in_file.06.reg2mem59, align 8
  br label %if.end7, !dbg !1583

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1584
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1584
    #dbg_value(ptr %0, !1570, !DIExpression(), !1577)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1585
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1587

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.13, ptr %check_file.0.reg2mem57, align 8
  store ptr %0, ptr %in_file.06.reg2mem59, align 8
  br label %if.end7, !dbg !1587

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1588
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1588
    #dbg_value(ptr %1, !1571, !DIExpression(), !1577)
  store ptr %1, ptr %check_file.0.reg2mem57, align 8
  store ptr %0, ptr %in_file.06.reg2mem59, align 8
  br label %if.end7, !dbg !1589

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem57.0.check_file.0.reload58, !1571, !DIExpression(), !1577)
  %in_file.06.reg2mem59.0.in_file.06.reload60 = load ptr, ptr %in_file.06.reg2mem59, align 8
  %check_file.0.reg2mem57.0.check_file.0.reload58 = load ptr, ptr %check_file.0.reg2mem57, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1590, !tbaa !1053
  %conv = sext i32 %2 to i64, !dbg !1590
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #20, !dbg !1591
    #dbg_value(ptr %call, !1573, !DIExpression(), !1577)
  %cmp8.not = icmp eq ptr %call, null, !dbg !1592
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1592

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.14, ptr noundef nonnull @.str.2.12, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1592
  unreachable, !dbg !1592

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.06.reg2mem59.0.in_file.06.reload60, i32 noundef signext 0) #18, !dbg !1595
    #dbg_value(i32 %call14, !1572, !DIExpression(), !1577)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1596
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1596

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.15, ptr noundef nonnull @.str.2.12, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1596
  unreachable, !dbg !1596

if.end20:                                         ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #18, !dbg !1599
    #dbg_value(ptr %call, !405, !DIExpression(), !1600)
    #dbg_value(ptr %call, !406, !DIExpression(), !1600)
  %img.i = getelementptr inbounds i8, ptr %call, i64 8192, !dbg !1602
  %real_twid.i = getelementptr inbounds i8, ptr %call, i64 16384, !dbg !1603
  %img_twid.i = getelementptr inbounds i8, ptr %call, i64 20480, !dbg !1604
    #dbg_value(ptr %call, !334, !DIExpression(), !1605)
    #dbg_value(ptr %img.i, !335, !DIExpression(), !1605)
    #dbg_value(ptr %real_twid.i, !336, !DIExpression(), !1605)
    #dbg_value(ptr %img_twid.i, !337, !DIExpression(), !1605)
    #dbg_value(i32 0, !341, !DIExpression(), !1605)
    #dbg_label(!344, !1607)
    #dbg_value(i32 512, !340, !DIExpression(), !1605)
  store i32 512, ptr %span.0105.i.i.reg2mem53, align 4
  store i32 0, ptr %log.0106.i.i.reg2mem55, align 4
  br label %for.cond1.preheader.i.i, !dbg !1608

for.cond1.preheader.i.i:                          ; preds = %for.inc50.i.i.for.cond1.preheader.i.i_crit_edge, %if.end20
    #dbg_value(i32 %log.0106.i.i.reg2mem55.0.load, !341, !DIExpression(), !1605)
    #dbg_value(i32 %span.0105.i.i.reg2mem53.0.load, !340, !DIExpression(), !1605)
    #dbg_value(i32 %span.0105.i.i.reg2mem53.0.load, !339, !DIExpression(), !1605)
  %log.0106.i.i.reg2mem55.0.load = load i32, ptr %log.0106.i.i.reg2mem55, align 4
  %span.0105.i.i.reg2mem53.0.load = load i32, ptr %span.0105.i.i.reg2mem53, align 4
  store i32 %span.0105.i.i.reg2mem53.0.load, ptr %odd.0104.i.i.reg2mem, align 4
  br label %for.body2.i.i, !dbg !1609

for.body2.i.i:                                    ; preds = %for.inc.i.i.for.body2.i.i_crit_edge, %for.cond1.preheader.i.i
    #dbg_value(i32 %odd.0104.i.i.reg2mem.0.load, !339, !DIExpression(), !1605)
  %odd.0104.i.i.reg2mem.0.load = load i32, ptr %odd.0104.i.i.reg2mem, align 4
  %or.i.i = or i32 %odd.0104.i.i.reg2mem.0.load, %span.0105.i.i.reg2mem53.0.load, !dbg !1610
    #dbg_value(i32 %or.i.i, !339, !DIExpression(), !1605)
  %xor.i.i = xor i32 %or.i.i, %span.0105.i.i.reg2mem53.0.load, !dbg !1611
    #dbg_value(i32 %xor.i.i, !338, !DIExpression(), !1605)
  %idxprom.i.i = sext i32 %xor.i.i to i64, !dbg !1612
  %arrayidx.i.i = getelementptr inbounds double, ptr %call, i64 %idxprom.i.i, !dbg !1612
  %3 = load double, ptr %arrayidx.i.i, align 8, !dbg !1612, !tbaa !359
  %idxprom3.i.i = sext i32 %or.i.i to i64, !dbg !1613
  %arrayidx4.i.i = getelementptr inbounds double, ptr %call, i64 %idxprom3.i.i, !dbg !1613
  %4 = load double, ptr %arrayidx4.i.i, align 8, !dbg !1613, !tbaa !359
  %add.i.i = fadd double %3, %4, !dbg !1614
    #dbg_value(double %add.i.i, !343, !DIExpression(), !1605)
  %sub.i.i = fsub double %3, %4, !dbg !1615
  store double %sub.i.i, ptr %arrayidx4.i.i, align 8, !dbg !1616, !tbaa !359
  store double %add.i.i, ptr %arrayidx.i.i, align 8, !dbg !1617, !tbaa !359
  %arrayidx14.i.i = getelementptr inbounds double, ptr %img.i, i64 %idxprom.i.i, !dbg !1618
  %5 = load double, ptr %arrayidx14.i.i, align 8, !dbg !1618, !tbaa !359
  %arrayidx16.i.i = getelementptr inbounds double, ptr %img.i, i64 %idxprom3.i.i, !dbg !1619
  %6 = load double, ptr %arrayidx16.i.i, align 8, !dbg !1619, !tbaa !359
  %add17.i.i = fadd double %5, %6, !dbg !1620
    #dbg_value(double %add17.i.i, !343, !DIExpression(), !1605)
  %sub22.i.i = fsub double %5, %6, !dbg !1621
  store double %sub22.i.i, ptr %arrayidx16.i.i, align 8, !dbg !1622, !tbaa !359
  store double %add17.i.i, ptr %arrayidx14.i.i, align 8, !dbg !1623, !tbaa !359
  %shl.i.i = shl i32 %xor.i.i, %log.0106.i.i.reg2mem55.0.load, !dbg !1624
  %and.i.i = and i32 %shl.i.i, 1023, !dbg !1625
    #dbg_value(i32 %and.i.i, !342, !DIExpression(), !1605)
  %tobool27.not.i.i = icmp eq i32 %and.i.i, 0, !dbg !1626
  br i1 %tobool27.not.i.i, label %for.body2.i.i.for.inc.i.i_crit_edge, label %if.then.i.i, !dbg !1627

for.body2.i.i.for.inc.i.i_crit_edge:              ; preds = %for.body2.i.i
  br label %for.inc.i.i, !dbg !1627

if.then.i.i:                                      ; preds = %for.body2.i.i
  %idxprom28.i.i = zext nneg i32 %and.i.i to i64
  %arrayidx29.i.i = getelementptr inbounds double, ptr %real_twid.i, i64 %idxprom28.i.i, !dbg !1628
  %7 = load double, ptr %arrayidx29.i.i, align 8, !dbg !1628, !tbaa !359
  %8 = load double, ptr %arrayidx4.i.i, align 8, !dbg !1629, !tbaa !359
  %arrayidx33.i.i = getelementptr inbounds double, ptr %img_twid.i, i64 %idxprom28.i.i, !dbg !1630
  %9 = load double, ptr %arrayidx33.i.i, align 8, !dbg !1630, !tbaa !359
  %10 = load double, ptr %arrayidx16.i.i, align 8, !dbg !1631, !tbaa !359
  %11 = fneg double %9, !dbg !1632
  %neg.i.i = fmul double %10, %11, !dbg !1632
  %12 = tail call double @llvm.fmuladd.f64(double %7, double %8, double %neg.i.i), !dbg !1632
    #dbg_value(double %12, !343, !DIExpression(), !1605)
  %mul45.i.i = fmul double %8, %9, !dbg !1633
  %13 = tail call double @llvm.fmuladd.f64(double %7, double %10, double %mul45.i.i), !dbg !1634
  store double %13, ptr %arrayidx16.i.i, align 8, !dbg !1635, !tbaa !359
  store double %12, ptr %arrayidx4.i.i, align 8, !dbg !1636, !tbaa !359
  br label %for.inc.i.i, !dbg !1637

for.inc.i.i:                                      ; preds = %for.body2.i.i.for.inc.i.i_crit_edge, %if.then.i.i
  %inc.i.i = add nsw i32 %or.i.i, 1, !dbg !1638
    #dbg_value(i32 %inc.i.i, !339, !DIExpression(), !1605)
  %cmp.i.i = icmp slt i32 %or.i.i, 1023, !dbg !1639
  br i1 %cmp.i.i, label %for.inc.i.i.for.body2.i.i_crit_edge, label %for.inc50.i.i, !dbg !1609, !llvm.loop !1640

for.inc.i.i.for.body2.i.i_crit_edge:              ; preds = %for.inc.i.i
  store i32 %inc.i.i, ptr %odd.0104.i.i.reg2mem, align 4
  br label %for.body2.i.i, !dbg !1609

for.inc50.i.i:                                    ; preds = %for.inc.i.i
  %shr.i.i = lshr i32 %span.0105.i.i.reg2mem53.0.load, 1, !dbg !1642
    #dbg_value(i32 %shr.i.i, !340, !DIExpression(), !1605)
  %inc51.i.i = add nuw nsw i32 %log.0106.i.i.reg2mem55.0.load, 1, !dbg !1643
    #dbg_value(i32 %inc51.i.i, !341, !DIExpression(), !1605)
  %exitcond.i.i = icmp eq i32 %inc51.i.i, 10, !dbg !1608
  br i1 %exitcond.i.i, label %run_benchmark.exit, label %for.inc50.i.i.for.cond1.preheader.i.i_crit_edge, !dbg !1608, !llvm.loop !1644

for.inc50.i.i.for.cond1.preheader.i.i_crit_edge:  ; preds = %for.inc50.i.i
  store i32 %shr.i.i, ptr %span.0105.i.i.reg2mem53, align 4
  store i32 %inc51.i.i, ptr %log.0106.i.i.reg2mem55, align 4
  br label %for.cond1.preheader.i.i, !dbg !1608

run_benchmark.exit:                               ; preds = %for.inc50.i.i
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #18, !dbg !1646
    #dbg_value(i32 %call21, !1574, !DIExpression(), !1577)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1647
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1647

if.else26:                                        ; preds = %run_benchmark.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1647
  unreachable, !dbg !1647

if.end27:                                         ; preds = %run_benchmark.exit
    #dbg_value(i32 %call21, !676, !DIExpression(), !1650)
    #dbg_value(ptr %call, !677, !DIExpression(), !1650)
    #dbg_value(ptr %call, !678, !DIExpression(), !1650)
    #dbg_value(i32 %call21, !564, !DIExpression(), !1652)
  %cmp.i.i1.not = icmp eq i32 %call21, 1, !dbg !1654
  br i1 %cmp.i.i1.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1654

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #19, !dbg !1654
  unreachable, !dbg !1654

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1655
    #dbg_value(i32 %call21, !575, !DIExpression(), !1656)
    #dbg_value(ptr %call, !580, !DIExpression(), !1656)
    #dbg_value(i32 1024, !581, !DIExpression(), !1656)
    #dbg_value(i32 0, !582, !DIExpression(), !1656)
  store i64 0, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1658

for.body.i.i:                                     ; preds = %for.body.i.i.for.body.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !582, !DIExpression(), !1656)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %arrayidx.i.i2 = getelementptr inbounds double, ptr %call, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !1659
  %14 = load double, ptr %arrayidx.i.i2, align 8, !dbg !1659, !tbaa !359
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.21, double noundef %14), !dbg !1659
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !1660
    #dbg_value(i64 %indvars.iv.next.i.i, !582, !DIExpression(), !1656)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 1024, !dbg !1660
  br i1 %exitcond.not.i.i, label %for.cond.preheader.i8.i, label %for.body.i.i.for.body.i.i_crit_edge, !dbg !1658, !llvm.loop !1661

for.body.i.i.for.body.i.i_crit_edge:              ; preds = %for.body.i.i
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1658

for.cond.preheader.i8.i:                          ; preds = %for.body.i.i
    #dbg_value(i32 %call21, !564, !DIExpression(), !1662)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1664
    #dbg_value(i32 %call21, !575, !DIExpression(), !1665)
    #dbg_value(ptr %img.i, !580, !DIExpression(), !1665)
    #dbg_value(i32 1024, !581, !DIExpression(), !1665)
    #dbg_value(i32 0, !582, !DIExpression(), !1665)
  store i64 0, ptr %indvars.iv.i10.i.reg2mem, align 8
  br label %for.body.i9.i, !dbg !1667

for.body.i9.i:                                    ; preds = %for.body.i9.i.for.body.i9.i_crit_edge, %for.cond.preheader.i8.i
    #dbg_value(i64 %indvars.iv.i10.i.reg2mem.0.load, !582, !DIExpression(), !1665)
  %indvars.iv.i10.i.reg2mem.0.load = load i64, ptr %indvars.iv.i10.i.reg2mem, align 8
  %arrayidx.i11.i = getelementptr inbounds double, ptr %img.i, i64 %indvars.iv.i10.i.reg2mem.0.load, !dbg !1668
  %15 = load double, ptr %arrayidx.i11.i, align 8, !dbg !1668, !tbaa !359
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.21, double noundef %15), !dbg !1668
  %indvars.iv.next.i12.i = add nuw nsw i64 %indvars.iv.i10.i.reg2mem.0.load, 1, !dbg !1669
    #dbg_value(i64 %indvars.iv.next.i12.i, !582, !DIExpression(), !1665)
  %exitcond.not.i13.i = icmp eq i64 %indvars.iv.next.i12.i, 1024, !dbg !1669
  br i1 %exitcond.not.i13.i, label %data_to_output.exit, label %for.body.i9.i.for.body.i9.i_crit_edge, !dbg !1667, !llvm.loop !1670

for.body.i9.i.for.body.i9.i_crit_edge:            ; preds = %for.body.i9.i
  store i64 %indvars.iv.next.i12.i, ptr %indvars.iv.i10.i.reg2mem, align 8
  br label %for.body.i9.i, !dbg !1667

data_to_output.exit:                              ; preds = %for.body.i9.i
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #18, !dbg !1671
  %16 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1672, !tbaa !1053
  %conv29 = sext i32 %16 to i64, !dbg !1672
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #20, !dbg !1673
    #dbg_value(ptr %call30, !1576, !DIExpression(), !1577)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1674
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1674

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.16, ptr noundef nonnull @.str.2.12, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1674
  unreachable, !dbg !1674

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem57.0.check_file.0.reload58, i32 noundef signext 0) #18, !dbg !1677
    #dbg_value(i32 %call37, !1575, !DIExpression(), !1577)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1678
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1678

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.17, ptr noundef nonnull @.str.2.12, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #19, !dbg !1678
  unreachable, !dbg !1678

if.end43:                                         ; preds = %if.end36
  tail call void @output_to_data(i32 noundef signext %call37, ptr noundef nonnull %call30) #18, !dbg !1681
    #dbg_value(ptr %call, !705, !DIExpression(), !1682)
    #dbg_value(ptr %call30, !706, !DIExpression(), !1682)
    #dbg_value(ptr %call, !707, !DIExpression(), !1682)
    #dbg_value(ptr %call30, !708, !DIExpression(), !1682)
    #dbg_value(i32 0, !709, !DIExpression(), !1682)
    #dbg_value(i32 0, !710, !DIExpression(), !1682)
  store i32 0, ptr %has_errors.030.i.reg2mem, align 4
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1685

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %if.end43
    #dbg_value(i32 %has_errors.030.i.reg2mem.0.load, !709, !DIExpression(), !1682)
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !710, !DIExpression(), !1682)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %has_errors.030.i.reg2mem.0.load = load i32, ptr %has_errors.030.i.reg2mem, align 4
  %arrayidx.i = getelementptr inbounds [1024 x double], ptr %call, i64 0, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1686
  %17 = load double, ptr %arrayidx.i, align 8, !dbg !1686, !tbaa !359
  %arrayidx3.i = getelementptr inbounds [1024 x double], ptr %call30, i64 0, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1687
  %18 = load double, ptr %arrayidx3.i, align 8, !dbg !1687, !tbaa !359
  %sub.i = fsub double %17, %18, !dbg !1688
    #dbg_value(double %sub.i, !711, !DIExpression(), !1682)
  %arrayidx5.i = getelementptr inbounds %struct.bench_args_t, ptr %call, i64 0, i32 1, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1689
  %19 = load double, ptr %arrayidx5.i, align 8, !dbg !1689, !tbaa !359
  %arrayidx8.i = getelementptr inbounds %struct.bench_args_t, ptr %call30, i64 0, i32 1, i64 %indvars.iv.i.reg2mem.0.load, !dbg !1690
  %20 = load double, ptr %arrayidx8.i, align 8, !dbg !1690, !tbaa !359
  %sub9.i = fsub double %19, %20, !dbg !1691
    #dbg_value(double %sub9.i, !712, !DIExpression(), !1682)
  %21 = tail call double @llvm.fabs.f64(double %sub.i), !dbg !1692
  %22 = fcmp ogt double %21, 0x3EB0C6F7A0B5ED8D, !dbg !1692
    #dbg_value(!DIArgList(i32 %has_errors.030.i.reg2mem.0.load, i1 %22), !709, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_or, DW_OP_stack_value), !1682)
  %23 = tail call double @llvm.fabs.f64(double %sub9.i), !dbg !1693
  %24 = fcmp ogt double %23, 0x3EB0C6F7A0B5ED8D, !dbg !1693
  %25 = or i1 %22, %24, !dbg !1694
  %26 = zext i1 %25 to i32, !dbg !1694
  %or17.i = or i32 %has_errors.030.i.reg2mem.0.load, %26, !dbg !1694
    #dbg_value(i32 %or17.i, !709, !DIExpression(), !1682)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !1695
    #dbg_value(i64 %indvars.iv.next.i, !710, !DIExpression(), !1682)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 1024, !dbg !1696
  br i1 %exitcond.not.i, label %check_data.exit, label %for.body.i.for.body.i_crit_edge, !dbg !1685, !llvm.loop !1697

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i32 %or17.i, ptr %has_errors.030.i.reg2mem, align 4
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !1685

check_data.exit:                                  ; preds = %for.body.i
  %tobool.not.i.not = icmp eq i32 %or17.i, 0, !dbg !1699
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1700

if.then45:                                        ; preds = %check_data.exit
  %27 = load ptr, ptr @stderr, align 8, !dbg !1701, !tbaa !917
  %28 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %27) #21, !dbg !1703
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1704

if.end47:                                         ; preds = %check_data.exit
  tail call void @free(ptr noundef nonnull %call) #18, !dbg !1705
  tail call void @free(ptr noundef nonnull %call30) #18, !dbg !1706
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1707
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1708

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1709
}

; Function Attrs: nofree
declare !dbg !1710 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #10

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #17

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #17

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fabs.f64(double) #1

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #3 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { nocallback nofree nounwind willreturn memory(argmem: write) }
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

!llvm.dbg.cu = !{!229, !188, !231, !296}
!llvm.ident = !{!317, !317, !317, !317}
!llvm.module.flags = !{!318, !319, !320, !321, !322, !324, !325, !326, !327, !328}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 40, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/fft/strided")
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
!170 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/fft/strided")
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
!188 = distinct !DICompileUnit(language: DW_LANG_C11, file: !189, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !190, globals: !206, splitDebugInlining: false, nameTableKind: None)
!189 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/fft/strided")
!190 = !{!191, !197}
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !193, line: 14, size: 196608, elements: !194)
!193 = !DIFile(filename: "./fft.h", directory: "/home/kelvin/MachSuite/fft/strided")
!194 = !{!195, !200, !201, !205}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "real", scope: !192, file: !193, line: 15, baseType: !196, size: 65536)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 65536, elements: !198)
!197 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!198 = !{!199}
!199 = !DISubrange(count: 1024)
!200 = !DIDerivedType(tag: DW_TAG_member, name: "img", scope: !192, file: !193, line: 16, baseType: !196, size: 65536, offset: 65536)
!201 = !DIDerivedType(tag: DW_TAG_member, name: "real_twid", scope: !192, file: !193, line: 17, baseType: !202, size: 32768, offset: 131072)
!202 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 32768, elements: !203)
!203 = !{!204}
!204 = !DISubrange(count: 512)
!205 = !DIDerivedType(tag: DW_TAG_member, name: "img_twid", scope: !192, file: !193, line: 18, baseType: !202, size: 32768, offset: 163840)
!206 = !{!186}
!207 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!208 = !DIGlobalVariableExpression(var: !209, expr: !DIExpression())
!209 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !210, isLocal: true, isDefinition: true)
!210 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 240, elements: !151)
!211 = !DIGlobalVariableExpression(var: !212, expr: !DIExpression())
!212 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !213, isLocal: true, isDefinition: true)
!213 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 344, elements: !124)
!214 = !DIGlobalVariableExpression(var: !215, expr: !DIExpression())
!215 = distinct !DIGlobalVariable(scope: null, file: !170, line: 47, type: !216, isLocal: true, isDefinition: true)
!216 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 96, elements: !217)
!217 = !{!218}
!218 = !DISubrange(count: 12)
!219 = !DIGlobalVariableExpression(var: !220, expr: !DIExpression())
!220 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !221, isLocal: true, isDefinition: true)
!221 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 360, elements: !100)
!222 = !DIGlobalVariableExpression(var: !223, expr: !DIExpression())
!223 = distinct !DIGlobalVariable(scope: null, file: !170, line: 58, type: !30, isLocal: true, isDefinition: true)
!224 = !DIGlobalVariableExpression(var: !225, expr: !DIExpression())
!225 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !226, isLocal: true, isDefinition: true)
!226 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 368, elements: !74)
!227 = !DIGlobalVariableExpression(var: !228, expr: !DIExpression())
!228 = distinct !DIGlobalVariable(scope: null, file: !170, line: 67, type: !35, isLocal: true, isDefinition: true)
!229 = distinct !DICompileUnit(language: DW_LANG_C11, file: !230, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!230 = !DIFile(filename: "fft.c", directory: "/home/kelvin/MachSuite/fft/strided")
!231 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !232, globals: !262, splitDebugInlining: false, nameTableKind: None)
!232 = !{!233, !4, !234, !235, !240, !243, !246, !249, !253, !256, !258, !261, !197}
!233 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!234 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!235 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !236, line: 24, baseType: !237)
!236 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!237 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !238, line: 38, baseType: !239)
!238 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!239 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!240 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !236, line: 25, baseType: !241)
!241 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !238, line: 40, baseType: !242)
!242 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!243 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !236, line: 26, baseType: !244)
!244 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !238, line: 42, baseType: !245)
!245 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!246 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !236, line: 27, baseType: !247)
!247 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !238, line: 45, baseType: !248)
!248 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !250, line: 24, baseType: !251)
!250 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!251 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !238, line: 37, baseType: !252)
!252 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!253 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !250, line: 25, baseType: !254)
!254 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !238, line: 39, baseType: !255)
!255 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!256 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !250, line: 26, baseType: !257)
!257 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !238, line: 41, baseType: !207)
!258 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !250, line: 27, baseType: !259)
!259 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !238, line: 44, baseType: !260)
!260 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!261 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
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
!297 = !{!234}
!298 = !{!299, !168, !174, !176, !179, !184, !301, !208, !303, !211, !214, !305, !219, !222, !310, !224, !227, !312}
!299 = !DIGlobalVariableExpression(var: !300, expr: !DIExpression())
!300 = distinct !DIGlobalVariable(scope: null, file: !170, line: 21, type: !221, isLocal: true, isDefinition: true)
!301 = !DIGlobalVariableExpression(var: !302, expr: !DIExpression())
!302 = distinct !DIGlobalVariable(scope: null, file: !170, line: 37, type: !272, isLocal: true, isDefinition: true)
!303 = !DIGlobalVariableExpression(var: !304, expr: !DIExpression())
!304 = distinct !DIGlobalVariable(scope: null, file: !170, line: 39, type: !210, isLocal: true, isDefinition: true)
!305 = !DIGlobalVariableExpression(var: !306, expr: !DIExpression())
!306 = distinct !DIGlobalVariable(scope: null, file: !170, line: 48, type: !307, isLocal: true, isDefinition: true)
!307 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 248, elements: !308)
!308 = !{!309}
!309 = !DISubrange(count: 31)
!310 = !DIGlobalVariableExpression(var: !311, expr: !DIExpression())
!311 = distinct !DIGlobalVariable(scope: null, file: !170, line: 60, type: !210, isLocal: true, isDefinition: true)
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
!329 = distinct !DISubprogram(name: "fft", scope: !230, file: !230, line: 3, type: !330, scopeLine: 3, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !229, retainedNodes: !333)
!330 = !DISubroutineType(types: !331)
!331 = !{null, !332, !332, !332, !332}
!332 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !197, size: 64)
!333 = !{!334, !335, !336, !337, !338, !339, !340, !341, !342, !343, !344, !345}
!334 = !DILocalVariable(name: "real", arg: 1, scope: !329, file: !230, line: 3, type: !332)
!335 = !DILocalVariable(name: "img", arg: 2, scope: !329, file: !230, line: 3, type: !332)
!336 = !DILocalVariable(name: "real_twid", arg: 3, scope: !329, file: !230, line: 3, type: !332)
!337 = !DILocalVariable(name: "img_twid", arg: 4, scope: !329, file: !230, line: 3, type: !332)
!338 = !DILocalVariable(name: "even", scope: !329, file: !230, line: 4, type: !207)
!339 = !DILocalVariable(name: "odd", scope: !329, file: !230, line: 4, type: !207)
!340 = !DILocalVariable(name: "span", scope: !329, file: !230, line: 4, type: !207)
!341 = !DILocalVariable(name: "log", scope: !329, file: !230, line: 4, type: !207)
!342 = !DILocalVariable(name: "rootindex", scope: !329, file: !230, line: 4, type: !207)
!343 = !DILocalVariable(name: "temp", scope: !329, file: !230, line: 5, type: !197)
!344 = !DILabel(scope: !329, name: "outer", file: !230, line: 8)
!345 = !DILabel(scope: !346, name: "inner", file: !230, line: 9)
!346 = distinct !DILexicalBlock(scope: !347, file: !230, line: 8, column: 55)
!347 = distinct !DILexicalBlock(scope: !348, file: !230, line: 8, column: 11)
!348 = distinct !DILexicalBlock(scope: !329, file: !230, line: 8, column: 11)
!349 = !DILocation(line: 0, scope: !329)
!350 = !DILocation(line: 8, column: 5, scope: !329)
!351 = !DILocation(line: 8, column: 11, scope: !348)
!352 = !DILocation(line: 9, column: 15, scope: !353)
!353 = distinct !DILexicalBlock(scope: !346, file: !230, line: 9, column: 15)
!354 = !DILocation(line: 10, column: 17, scope: !355)
!355 = distinct !DILexicalBlock(scope: !356, file: !230, line: 9, column: 49)
!356 = distinct !DILexicalBlock(scope: !353, file: !230, line: 9, column: 15)
!357 = !DILocation(line: 11, column: 24, scope: !355)
!358 = !DILocation(line: 13, column: 20, scope: !355)
!359 = !{!360, !360, i64 0}
!360 = !{!"double", !361, i64 0}
!361 = !{!"omnipotent char", !362, i64 0}
!362 = !{!"Simple C/C++ TBAA"}
!363 = !DILocation(line: 13, column: 33, scope: !355)
!364 = !DILocation(line: 13, column: 31, scope: !355)
!365 = !DILocation(line: 14, column: 36, scope: !355)
!366 = !DILocation(line: 14, column: 23, scope: !355)
!367 = !DILocation(line: 15, column: 24, scope: !355)
!368 = !DILocation(line: 17, column: 20, scope: !355)
!369 = !DILocation(line: 17, column: 32, scope: !355)
!370 = !DILocation(line: 17, column: 30, scope: !355)
!371 = !DILocation(line: 18, column: 34, scope: !355)
!372 = !DILocation(line: 18, column: 22, scope: !355)
!373 = !DILocation(line: 19, column: 23, scope: !355)
!374 = !DILocation(line: 21, column: 30, scope: !355)
!375 = !DILocation(line: 21, column: 37, scope: !355)
!376 = !DILocation(line: 22, column: 16, scope: !377)
!377 = distinct !DILexicalBlock(scope: !355, file: !230, line: 22, column: 16)
!378 = !DILocation(line: 22, column: 16, scope: !355)
!379 = !DILocation(line: 23, column: 24, scope: !380)
!380 = distinct !DILexicalBlock(scope: !377, file: !230, line: 22, column: 26)
!381 = !DILocation(line: 23, column: 47, scope: !380)
!382 = !DILocation(line: 24, column: 21, scope: !380)
!383 = !DILocation(line: 24, column: 44, scope: !380)
!384 = !DILocation(line: 23, column: 57, scope: !380)
!385 = !DILocation(line: 26, column: 40, scope: !380)
!386 = !DILocation(line: 25, column: 58, scope: !380)
!387 = !DILocation(line: 25, column: 26, scope: !380)
!388 = !DILocation(line: 27, column: 27, scope: !380)
!389 = !DILocation(line: 28, column: 13, scope: !380)
!390 = !DILocation(line: 9, column: 46, scope: !356)
!391 = !DILocation(line: 9, column: 32, scope: !356)
!392 = distinct !{!392, !352, !393, !394, !395}
!393 = !DILocation(line: 29, column: 9, scope: !353)
!394 = !{!"llvm.loop.mustprogress"}
!395 = !{!"llvm.loop.unroll.disable"}
!396 = !DILocation(line: 8, column: 43, scope: !347)
!397 = !DILocation(line: 8, column: 52, scope: !347)
!398 = distinct !{!398, !351, !399, !394, !395}
!399 = !DILocation(line: 30, column: 5, scope: !348)
!400 = !DILocation(line: 31, column: 1, scope: !329)
!401 = distinct !DISubprogram(name: "run_benchmark", scope: !189, file: !189, line: 8, type: !402, scopeLine: 8, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !404)
!402 = !DISubroutineType(types: !403)
!403 = !{null, !234}
!404 = !{!405, !406}
!405 = !DILocalVariable(name: "vargs", arg: 1, scope: !401, file: !189, line: 8, type: !234)
!406 = !DILocalVariable(name: "args", scope: !401, file: !189, line: 9, type: !191)
!407 = !DILocation(line: 0, scope: !401)
!408 = !DILocation(line: 10, column: 25, scope: !401)
!409 = !DILocation(line: 10, column: 36, scope: !401)
!410 = !DILocation(line: 10, column: 53, scope: !401)
!411 = !DILocation(line: 0, scope: !329, inlinedAt: !412)
!412 = distinct !DILocation(line: 10, column: 3, scope: !401)
!413 = !DILocation(line: 8, column: 5, scope: !329, inlinedAt: !412)
!414 = !DILocation(line: 8, column: 11, scope: !348, inlinedAt: !412)
!415 = !DILocation(line: 9, column: 15, scope: !353, inlinedAt: !412)
!416 = !DILocation(line: 10, column: 17, scope: !355, inlinedAt: !412)
!417 = !DILocation(line: 11, column: 24, scope: !355, inlinedAt: !412)
!418 = !DILocation(line: 13, column: 20, scope: !355, inlinedAt: !412)
!419 = !DILocation(line: 13, column: 33, scope: !355, inlinedAt: !412)
!420 = !DILocation(line: 13, column: 31, scope: !355, inlinedAt: !412)
!421 = !DILocation(line: 14, column: 36, scope: !355, inlinedAt: !412)
!422 = !DILocation(line: 14, column: 23, scope: !355, inlinedAt: !412)
!423 = !DILocation(line: 15, column: 24, scope: !355, inlinedAt: !412)
!424 = !DILocation(line: 17, column: 20, scope: !355, inlinedAt: !412)
!425 = !DILocation(line: 17, column: 32, scope: !355, inlinedAt: !412)
!426 = !DILocation(line: 17, column: 30, scope: !355, inlinedAt: !412)
!427 = !DILocation(line: 18, column: 34, scope: !355, inlinedAt: !412)
!428 = !DILocation(line: 18, column: 22, scope: !355, inlinedAt: !412)
!429 = !DILocation(line: 19, column: 23, scope: !355, inlinedAt: !412)
!430 = !DILocation(line: 21, column: 30, scope: !355, inlinedAt: !412)
!431 = !DILocation(line: 21, column: 37, scope: !355, inlinedAt: !412)
!432 = !DILocation(line: 22, column: 16, scope: !377, inlinedAt: !412)
!433 = !DILocation(line: 22, column: 16, scope: !355, inlinedAt: !412)
!434 = !DILocation(line: 23, column: 24, scope: !380, inlinedAt: !412)
!435 = !DILocation(line: 23, column: 47, scope: !380, inlinedAt: !412)
!436 = !DILocation(line: 24, column: 21, scope: !380, inlinedAt: !412)
!437 = !DILocation(line: 24, column: 44, scope: !380, inlinedAt: !412)
!438 = !DILocation(line: 23, column: 57, scope: !380, inlinedAt: !412)
!439 = !DILocation(line: 26, column: 40, scope: !380, inlinedAt: !412)
!440 = !DILocation(line: 25, column: 58, scope: !380, inlinedAt: !412)
!441 = !DILocation(line: 25, column: 26, scope: !380, inlinedAt: !412)
!442 = !DILocation(line: 27, column: 27, scope: !380, inlinedAt: !412)
!443 = !DILocation(line: 28, column: 13, scope: !380, inlinedAt: !412)
!444 = !DILocation(line: 9, column: 46, scope: !356, inlinedAt: !412)
!445 = !DILocation(line: 9, column: 32, scope: !356, inlinedAt: !412)
!446 = distinct !{!446, !415, !447, !394, !395}
!447 = !DILocation(line: 29, column: 9, scope: !353, inlinedAt: !412)
!448 = !DILocation(line: 8, column: 43, scope: !347, inlinedAt: !412)
!449 = !DILocation(line: 8, column: 52, scope: !347, inlinedAt: !412)
!450 = distinct !{!450, !414, !451, !394, !395}
!451 = !DILocation(line: 30, column: 5, scope: !348, inlinedAt: !412)
!452 = !DILocation(line: 11, column: 1, scope: !401)
!453 = distinct !DISubprogram(name: "input_to_data", scope: !189, file: !189, line: 24, type: !454, scopeLine: 24, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !456)
!454 = !DISubroutineType(types: !455)
!455 = !{null, !207, !234}
!456 = !{!457, !458, !459, !460, !461}
!457 = !DILocalVariable(name: "fd", arg: 1, scope: !453, file: !189, line: 24, type: !207)
!458 = !DILocalVariable(name: "vdata", arg: 2, scope: !453, file: !189, line: 24, type: !234)
!459 = !DILocalVariable(name: "data", scope: !453, file: !189, line: 25, type: !191)
!460 = !DILocalVariable(name: "p", scope: !453, file: !189, line: 26, type: !233)
!461 = !DILocalVariable(name: "s", scope: !453, file: !189, line: 26, type: !233)
!462 = !DILocation(line: 0, scope: !453)
!463 = !DILocation(line: 28, column: 7, scope: !453)
!464 = !DILocalVariable(name: "s", arg: 1, scope: !465, file: !2, line: 56, type: !233)
!465 = distinct !DISubprogram(name: "find_section_start", scope: !2, file: !2, line: 56, type: !466, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !468)
!466 = !DISubroutineType(types: !467)
!467 = !{!233, !233, !207}
!468 = !{!464, !469, !470}
!469 = !DILocalVariable(name: "n", arg: 2, scope: !465, file: !2, line: 56, type: !207)
!470 = !DILocalVariable(name: "i", scope: !465, file: !2, line: 57, type: !207)
!471 = !DILocation(line: 0, scope: !465, inlinedAt: !472)
!472 = distinct !DILocation(line: 30, column: 7, scope: !453)
!473 = !DILocation(line: 64, column: 17, scope: !465, inlinedAt: !472)
!474 = !{!361, !361, i64 0}
!475 = !DILocation(line: 64, column: 3, scope: !465, inlinedAt: !472)
!476 = !DILocation(line: 66, column: 22, scope: !477, inlinedAt: !472)
!477 = distinct !DILexicalBlock(scope: !478, file: !2, line: 66, column: 9)
!478 = distinct !DILexicalBlock(scope: !465, file: !2, line: 64, column: 31)
!479 = !DILocation(line: 66, column: 26, scope: !477, inlinedAt: !472)
!480 = !DILocation(line: 66, column: 32, scope: !477, inlinedAt: !472)
!481 = !DILocation(line: 66, column: 35, scope: !477, inlinedAt: !472)
!482 = !DILocation(line: 66, column: 39, scope: !477, inlinedAt: !472)
!483 = !DILocation(line: 66, column: 9, scope: !478, inlinedAt: !472)
!484 = !DILocation(line: 69, column: 6, scope: !478, inlinedAt: !472)
!485 = !DILocation(line: 64, column: 10, scope: !465, inlinedAt: !472)
!486 = !DILocation(line: 64, column: 13, scope: !465, inlinedAt: !472)
!487 = distinct !{!487, !475, !488, !394, !395}
!488 = !DILocation(line: 70, column: 3, scope: !465, inlinedAt: !472)
!489 = !DILocation(line: 71, column: 6, scope: !490, inlinedAt: !472)
!490 = distinct !DILexicalBlock(scope: !465, file: !2, line: 71, column: 6)
!491 = !DILocation(line: 71, column: 8, scope: !490, inlinedAt: !472)
!492 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !472)
!493 = !DILocation(line: 31, column: 3, scope: !453)
!494 = !DILocation(line: 0, scope: !465, inlinedAt: !495)
!495 = distinct !DILocation(line: 33, column: 7, scope: !453)
!496 = !DILocation(line: 64, column: 17, scope: !465, inlinedAt: !495)
!497 = !DILocation(line: 64, column: 3, scope: !465, inlinedAt: !495)
!498 = !DILocation(line: 66, column: 22, scope: !477, inlinedAt: !495)
!499 = !DILocation(line: 66, column: 26, scope: !477, inlinedAt: !495)
!500 = !DILocation(line: 66, column: 32, scope: !477, inlinedAt: !495)
!501 = !DILocation(line: 66, column: 35, scope: !477, inlinedAt: !495)
!502 = !DILocation(line: 66, column: 39, scope: !477, inlinedAt: !495)
!503 = !DILocation(line: 66, column: 9, scope: !478, inlinedAt: !495)
!504 = !DILocation(line: 69, column: 6, scope: !478, inlinedAt: !495)
!505 = !DILocation(line: 64, column: 10, scope: !465, inlinedAt: !495)
!506 = !DILocation(line: 64, column: 13, scope: !465, inlinedAt: !495)
!507 = distinct !{!507, !497, !508, !394, !395}
!508 = !DILocation(line: 70, column: 3, scope: !465, inlinedAt: !495)
!509 = !DILocation(line: 71, column: 6, scope: !490, inlinedAt: !495)
!510 = !DILocation(line: 71, column: 8, scope: !490, inlinedAt: !495)
!511 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !495)
!512 = !DILocation(line: 34, column: 31, scope: !453)
!513 = !DILocation(line: 34, column: 3, scope: !453)
!514 = !DILocation(line: 0, scope: !465, inlinedAt: !515)
!515 = distinct !DILocation(line: 36, column: 7, scope: !453)
!516 = !DILocation(line: 64, column: 17, scope: !465, inlinedAt: !515)
!517 = !DILocation(line: 64, column: 3, scope: !465, inlinedAt: !515)
!518 = !DILocation(line: 66, column: 22, scope: !477, inlinedAt: !515)
!519 = !DILocation(line: 66, column: 26, scope: !477, inlinedAt: !515)
!520 = !DILocation(line: 66, column: 32, scope: !477, inlinedAt: !515)
!521 = !DILocation(line: 66, column: 35, scope: !477, inlinedAt: !515)
!522 = !DILocation(line: 66, column: 39, scope: !477, inlinedAt: !515)
!523 = !DILocation(line: 66, column: 9, scope: !478, inlinedAt: !515)
!524 = !DILocation(line: 69, column: 6, scope: !478, inlinedAt: !515)
!525 = !DILocation(line: 64, column: 10, scope: !465, inlinedAt: !515)
!526 = !DILocation(line: 64, column: 13, scope: !465, inlinedAt: !515)
!527 = distinct !{!527, !517, !528, !394, !395}
!528 = !DILocation(line: 70, column: 3, scope: !465, inlinedAt: !515)
!529 = !DILocation(line: 71, column: 6, scope: !490, inlinedAt: !515)
!530 = !DILocation(line: 71, column: 8, scope: !490, inlinedAt: !515)
!531 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !515)
!532 = !DILocation(line: 37, column: 31, scope: !453)
!533 = !DILocation(line: 37, column: 3, scope: !453)
!534 = !DILocation(line: 0, scope: !465, inlinedAt: !535)
!535 = distinct !DILocation(line: 39, column: 7, scope: !453)
!536 = !DILocation(line: 64, column: 17, scope: !465, inlinedAt: !535)
!537 = !DILocation(line: 64, column: 3, scope: !465, inlinedAt: !535)
!538 = !DILocation(line: 66, column: 22, scope: !477, inlinedAt: !535)
!539 = !DILocation(line: 66, column: 26, scope: !477, inlinedAt: !535)
!540 = !DILocation(line: 66, column: 32, scope: !477, inlinedAt: !535)
!541 = !DILocation(line: 66, column: 35, scope: !477, inlinedAt: !535)
!542 = !DILocation(line: 66, column: 39, scope: !477, inlinedAt: !535)
!543 = !DILocation(line: 66, column: 9, scope: !478, inlinedAt: !535)
!544 = !DILocation(line: 69, column: 6, scope: !478, inlinedAt: !535)
!545 = !DILocation(line: 64, column: 10, scope: !465, inlinedAt: !535)
!546 = !DILocation(line: 64, column: 13, scope: !465, inlinedAt: !535)
!547 = distinct !{!547, !537, !548, !394, !395}
!548 = !DILocation(line: 70, column: 3, scope: !465, inlinedAt: !535)
!549 = !DILocation(line: 71, column: 6, scope: !490, inlinedAt: !535)
!550 = !DILocation(line: 71, column: 8, scope: !490, inlinedAt: !535)
!551 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !535)
!552 = !DILocation(line: 40, column: 31, scope: !453)
!553 = !DILocation(line: 40, column: 3, scope: !453)
!554 = !DILocation(line: 41, column: 3, scope: !453)
!555 = !DILocation(line: 42, column: 1, scope: !453)
!556 = !DISubprogram(name: "free", scope: !557, file: !557, line: 687, type: !402, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!557 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!558 = distinct !DISubprogram(name: "data_to_input", scope: !189, file: !189, line: 44, type: !454, scopeLine: 44, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !559)
!559 = !{!560, !561, !562}
!560 = !DILocalVariable(name: "fd", arg: 1, scope: !558, file: !189, line: 44, type: !207)
!561 = !DILocalVariable(name: "vdata", arg: 2, scope: !558, file: !189, line: 44, type: !234)
!562 = !DILocalVariable(name: "data", scope: !558, file: !189, line: 45, type: !191)
!563 = !DILocation(line: 0, scope: !558)
!564 = !DILocalVariable(name: "fd", arg: 1, scope: !565, file: !2, line: 189, type: !207)
!565 = distinct !DISubprogram(name: "write_section_header", scope: !2, file: !2, line: 189, type: !566, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !568)
!566 = !DISubroutineType(types: !567)
!567 = !{!207, !207}
!568 = !{!564}
!569 = !DILocation(line: 0, scope: !565, inlinedAt: !570)
!570 = distinct !DILocation(line: 47, column: 3, scope: !558)
!571 = !DILocation(line: 190, column: 3, scope: !572, inlinedAt: !570)
!572 = distinct !DILexicalBlock(scope: !573, file: !2, line: 190, column: 3)
!573 = distinct !DILexicalBlock(scope: !565, file: !2, line: 190, column: 3)
!574 = !DILocation(line: 191, column: 3, scope: !565, inlinedAt: !570)
!575 = !DILocalVariable(name: "fd", arg: 1, scope: !576, file: !2, line: 187, type: !207)
!576 = distinct !DISubprogram(name: "write_double_array", scope: !2, file: !2, line: 187, type: !577, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !579)
!577 = !DISubroutineType(types: !578)
!578 = !{!207, !207, !332, !207}
!579 = !{!575, !580, !581, !582}
!580 = !DILocalVariable(name: "arr", arg: 2, scope: !576, file: !2, line: 187, type: !332)
!581 = !DILocalVariable(name: "n", arg: 3, scope: !576, file: !2, line: 187, type: !207)
!582 = !DILocalVariable(name: "i", scope: !576, file: !2, line: 187, type: !207)
!583 = !DILocation(line: 0, scope: !576, inlinedAt: !584)
!584 = distinct !DILocation(line: 48, column: 3, scope: !558)
!585 = !DILocation(line: 187, column: 1, scope: !586, inlinedAt: !584)
!586 = distinct !DILexicalBlock(scope: !576, file: !2, line: 187, column: 1)
!587 = !DILocation(line: 187, column: 1, scope: !588, inlinedAt: !584)
!588 = distinct !DILexicalBlock(scope: !589, file: !2, line: 187, column: 1)
!589 = distinct !DILexicalBlock(scope: !586, file: !2, line: 187, column: 1)
!590 = !DILocation(line: 187, column: 1, scope: !589, inlinedAt: !584)
!591 = distinct !{!591, !585, !585, !394, !395}
!592 = !DILocation(line: 0, scope: !565, inlinedAt: !593)
!593 = distinct !DILocation(line: 50, column: 3, scope: !558)
!594 = !DILocation(line: 191, column: 3, scope: !565, inlinedAt: !593)
!595 = !DILocation(line: 51, column: 32, scope: !558)
!596 = !DILocation(line: 0, scope: !576, inlinedAt: !597)
!597 = distinct !DILocation(line: 51, column: 3, scope: !558)
!598 = !DILocation(line: 187, column: 1, scope: !586, inlinedAt: !597)
!599 = !DILocation(line: 187, column: 1, scope: !588, inlinedAt: !597)
!600 = !DILocation(line: 187, column: 1, scope: !589, inlinedAt: !597)
!601 = distinct !{!601, !598, !598, !394, !395}
!602 = !DILocation(line: 0, scope: !565, inlinedAt: !603)
!603 = distinct !DILocation(line: 53, column: 3, scope: !558)
!604 = !DILocation(line: 191, column: 3, scope: !565, inlinedAt: !603)
!605 = !DILocation(line: 54, column: 32, scope: !558)
!606 = !DILocation(line: 0, scope: !576, inlinedAt: !607)
!607 = distinct !DILocation(line: 54, column: 3, scope: !558)
!608 = !DILocation(line: 187, column: 1, scope: !586, inlinedAt: !607)
!609 = !DILocation(line: 187, column: 1, scope: !588, inlinedAt: !607)
!610 = !DILocation(line: 187, column: 1, scope: !589, inlinedAt: !607)
!611 = distinct !{!611, !608, !608, !394, !395}
!612 = !DILocation(line: 0, scope: !565, inlinedAt: !613)
!613 = distinct !DILocation(line: 56, column: 3, scope: !558)
!614 = !DILocation(line: 191, column: 3, scope: !565, inlinedAt: !613)
!615 = !DILocation(line: 57, column: 32, scope: !558)
!616 = !DILocation(line: 0, scope: !576, inlinedAt: !617)
!617 = distinct !DILocation(line: 57, column: 3, scope: !558)
!618 = !DILocation(line: 187, column: 1, scope: !586, inlinedAt: !617)
!619 = !DILocation(line: 187, column: 1, scope: !588, inlinedAt: !617)
!620 = !DILocation(line: 187, column: 1, scope: !589, inlinedAt: !617)
!621 = distinct !{!621, !618, !618, !394, !395}
!622 = !DILocation(line: 58, column: 1, scope: !558)
!623 = distinct !DISubprogram(name: "output_to_data", scope: !189, file: !189, line: 67, type: !454, scopeLine: 67, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !624)
!624 = !{!625, !626, !627, !628, !629}
!625 = !DILocalVariable(name: "fd", arg: 1, scope: !623, file: !189, line: 67, type: !207)
!626 = !DILocalVariable(name: "vdata", arg: 2, scope: !623, file: !189, line: 67, type: !234)
!627 = !DILocalVariable(name: "data", scope: !623, file: !189, line: 68, type: !191)
!628 = !DILocalVariable(name: "p", scope: !623, file: !189, line: 69, type: !233)
!629 = !DILocalVariable(name: "s", scope: !623, file: !189, line: 69, type: !233)
!630 = !DILocation(line: 0, scope: !623)
!631 = !DILocation(line: 71, column: 3, scope: !623)
!632 = !DILocation(line: 73, column: 7, scope: !623)
!633 = !DILocation(line: 0, scope: !465, inlinedAt: !634)
!634 = distinct !DILocation(line: 75, column: 7, scope: !623)
!635 = !DILocation(line: 64, column: 17, scope: !465, inlinedAt: !634)
!636 = !DILocation(line: 64, column: 3, scope: !465, inlinedAt: !634)
!637 = !DILocation(line: 66, column: 22, scope: !477, inlinedAt: !634)
!638 = !DILocation(line: 66, column: 26, scope: !477, inlinedAt: !634)
!639 = !DILocation(line: 66, column: 32, scope: !477, inlinedAt: !634)
!640 = !DILocation(line: 66, column: 35, scope: !477, inlinedAt: !634)
!641 = !DILocation(line: 66, column: 39, scope: !477, inlinedAt: !634)
!642 = !DILocation(line: 66, column: 9, scope: !478, inlinedAt: !634)
!643 = !DILocation(line: 69, column: 6, scope: !478, inlinedAt: !634)
!644 = !DILocation(line: 64, column: 10, scope: !465, inlinedAt: !634)
!645 = !DILocation(line: 64, column: 13, scope: !465, inlinedAt: !634)
!646 = distinct !{!646, !636, !647, !394, !395}
!647 = !DILocation(line: 70, column: 3, scope: !465, inlinedAt: !634)
!648 = !DILocation(line: 71, column: 6, scope: !490, inlinedAt: !634)
!649 = !DILocation(line: 71, column: 8, scope: !490, inlinedAt: !634)
!650 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !634)
!651 = !DILocation(line: 76, column: 3, scope: !623)
!652 = !DILocation(line: 0, scope: !465, inlinedAt: !653)
!653 = distinct !DILocation(line: 78, column: 7, scope: !623)
!654 = !DILocation(line: 64, column: 17, scope: !465, inlinedAt: !653)
!655 = !DILocation(line: 64, column: 3, scope: !465, inlinedAt: !653)
!656 = !DILocation(line: 66, column: 22, scope: !477, inlinedAt: !653)
!657 = !DILocation(line: 66, column: 26, scope: !477, inlinedAt: !653)
!658 = !DILocation(line: 66, column: 32, scope: !477, inlinedAt: !653)
!659 = !DILocation(line: 66, column: 35, scope: !477, inlinedAt: !653)
!660 = !DILocation(line: 66, column: 39, scope: !477, inlinedAt: !653)
!661 = !DILocation(line: 66, column: 9, scope: !478, inlinedAt: !653)
!662 = !DILocation(line: 69, column: 6, scope: !478, inlinedAt: !653)
!663 = !DILocation(line: 64, column: 10, scope: !465, inlinedAt: !653)
!664 = !DILocation(line: 64, column: 13, scope: !465, inlinedAt: !653)
!665 = distinct !{!665, !655, !666, !394, !395}
!666 = !DILocation(line: 70, column: 3, scope: !465, inlinedAt: !653)
!667 = !DILocation(line: 71, column: 6, scope: !490, inlinedAt: !653)
!668 = !DILocation(line: 71, column: 8, scope: !490, inlinedAt: !653)
!669 = !DILocation(line: 71, column: 6, scope: !465, inlinedAt: !653)
!670 = !DILocation(line: 79, column: 31, scope: !623)
!671 = !DILocation(line: 79, column: 3, scope: !623)
!672 = !DILocation(line: 80, column: 3, scope: !623)
!673 = !DILocation(line: 81, column: 1, scope: !623)
!674 = distinct !DISubprogram(name: "data_to_output", scope: !189, file: !189, line: 83, type: !454, scopeLine: 83, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !675)
!675 = !{!676, !677, !678}
!676 = !DILocalVariable(name: "fd", arg: 1, scope: !674, file: !189, line: 83, type: !207)
!677 = !DILocalVariable(name: "vdata", arg: 2, scope: !674, file: !189, line: 83, type: !234)
!678 = !DILocalVariable(name: "data", scope: !674, file: !189, line: 84, type: !191)
!679 = !DILocation(line: 0, scope: !674)
!680 = !DILocation(line: 0, scope: !565, inlinedAt: !681)
!681 = distinct !DILocation(line: 86, column: 3, scope: !674)
!682 = !DILocation(line: 190, column: 3, scope: !572, inlinedAt: !681)
!683 = !DILocation(line: 191, column: 3, scope: !565, inlinedAt: !681)
!684 = !DILocation(line: 0, scope: !576, inlinedAt: !685)
!685 = distinct !DILocation(line: 87, column: 3, scope: !674)
!686 = !DILocation(line: 187, column: 1, scope: !586, inlinedAt: !685)
!687 = !DILocation(line: 187, column: 1, scope: !588, inlinedAt: !685)
!688 = !DILocation(line: 187, column: 1, scope: !589, inlinedAt: !685)
!689 = distinct !{!689, !686, !686, !394, !395}
!690 = !DILocation(line: 0, scope: !565, inlinedAt: !691)
!691 = distinct !DILocation(line: 89, column: 3, scope: !674)
!692 = !DILocation(line: 191, column: 3, scope: !565, inlinedAt: !691)
!693 = !DILocation(line: 90, column: 32, scope: !674)
!694 = !DILocation(line: 0, scope: !576, inlinedAt: !695)
!695 = distinct !DILocation(line: 90, column: 3, scope: !674)
!696 = !DILocation(line: 187, column: 1, scope: !586, inlinedAt: !695)
!697 = !DILocation(line: 187, column: 1, scope: !588, inlinedAt: !695)
!698 = !DILocation(line: 187, column: 1, scope: !589, inlinedAt: !695)
!699 = distinct !{!699, !696, !696, !394, !395}
!700 = !DILocation(line: 91, column: 1, scope: !674)
!701 = distinct !DISubprogram(name: "check_data", scope: !189, file: !189, line: 93, type: !702, scopeLine: 93, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !188, retainedNodes: !704)
!702 = !DISubroutineType(types: !703)
!703 = !{!207, !234, !234}
!704 = !{!705, !706, !707, !708, !709, !710, !711, !712}
!705 = !DILocalVariable(name: "vdata", arg: 1, scope: !701, file: !189, line: 93, type: !234)
!706 = !DILocalVariable(name: "vref", arg: 2, scope: !701, file: !189, line: 93, type: !234)
!707 = !DILocalVariable(name: "data", scope: !701, file: !189, line: 94, type: !191)
!708 = !DILocalVariable(name: "ref", scope: !701, file: !189, line: 95, type: !191)
!709 = !DILocalVariable(name: "has_errors", scope: !701, file: !189, line: 96, type: !207)
!710 = !DILocalVariable(name: "i", scope: !701, file: !189, line: 97, type: !207)
!711 = !DILocalVariable(name: "real_diff", scope: !701, file: !189, line: 98, type: !197)
!712 = !DILocalVariable(name: "img_diff", scope: !701, file: !189, line: 98, type: !197)
!713 = !DILocation(line: 0, scope: !701)
!714 = !DILocation(line: 100, column: 3, scope: !715)
!715 = distinct !DILexicalBlock(scope: !701, file: !189, line: 100, column: 3)
!716 = !DILocation(line: 101, column: 17, scope: !717)
!717 = distinct !DILexicalBlock(scope: !718, file: !189, line: 100, column: 29)
!718 = distinct !DILexicalBlock(scope: !715, file: !189, line: 100, column: 3)
!719 = !DILocation(line: 101, column: 33, scope: !717)
!720 = !DILocation(line: 101, column: 31, scope: !717)
!721 = !DILocation(line: 102, column: 16, scope: !717)
!722 = !DILocation(line: 102, column: 31, scope: !717)
!723 = !DILocation(line: 102, column: 29, scope: !717)
!724 = !DILocation(line: 103, column: 40, scope: !717)
!725 = !DILocation(line: 106, column: 39, scope: !717)
!726 = !DILocation(line: 106, column: 16, scope: !717)
!727 = !DILocation(line: 100, column: 25, scope: !718)
!728 = !DILocation(line: 100, column: 13, scope: !718)
!729 = distinct !{!729, !714, !730, !394, !395}
!730 = !DILocation(line: 109, column: 3, scope: !715)
!731 = !DILocation(line: 112, column: 10, scope: !701)
!732 = !DILocation(line: 112, column: 3, scope: !701)
!733 = distinct !DISubprogram(name: "readfile", scope: !2, file: !2, line: 34, type: !734, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !736)
!734 = !DISubroutineType(types: !735)
!735 = !{!233, !207}
!736 = !{!737, !738, !739, !776, !779, !782}
!737 = !DILocalVariable(name: "fd", arg: 1, scope: !733, file: !2, line: 34, type: !207)
!738 = !DILocalVariable(name: "p", scope: !733, file: !2, line: 35, type: !233)
!739 = !DILocalVariable(name: "s", scope: !733, file: !2, line: 36, type: !740)
!740 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !741, line: 44, size: 1024, elements: !742)
!741 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!742 = !{!743, !745, !747, !749, !751, !753, !755, !756, !757, !759, !761, !762, !764, !772, !773, !774}
!743 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !740, file: !741, line: 46, baseType: !744, size: 64)
!744 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !238, line: 145, baseType: !248)
!745 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !740, file: !741, line: 47, baseType: !746, size: 64, offset: 64)
!746 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !238, line: 148, baseType: !248)
!747 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !740, file: !741, line: 48, baseType: !748, size: 32, offset: 128)
!748 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !238, line: 150, baseType: !245)
!749 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !740, file: !741, line: 49, baseType: !750, size: 32, offset: 160)
!750 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !238, line: 151, baseType: !245)
!751 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !740, file: !741, line: 50, baseType: !752, size: 32, offset: 192)
!752 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !238, line: 146, baseType: !245)
!753 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !740, file: !741, line: 51, baseType: !754, size: 32, offset: 224)
!754 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !238, line: 147, baseType: !245)
!755 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !740, file: !741, line: 52, baseType: !744, size: 64, offset: 256)
!756 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !740, file: !741, line: 53, baseType: !744, size: 64, offset: 320)
!757 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !740, file: !741, line: 54, baseType: !758, size: 64, offset: 384)
!758 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !238, line: 152, baseType: !260)
!759 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !740, file: !741, line: 55, baseType: !760, size: 32, offset: 448)
!760 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !238, line: 175, baseType: !207)
!761 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !740, file: !741, line: 56, baseType: !207, size: 32, offset: 480)
!762 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !740, file: !741, line: 57, baseType: !763, size: 64, offset: 512)
!763 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !238, line: 180, baseType: !260)
!764 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !740, file: !741, line: 65, baseType: !765, size: 128, offset: 576)
!765 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !766, line: 11, size: 128, elements: !767)
!766 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!767 = !{!768, !770}
!768 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !765, file: !766, line: 16, baseType: !769, size: 64)
!769 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !238, line: 160, baseType: !260)
!770 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !765, file: !766, line: 21, baseType: !771, size: 64, offset: 64)
!771 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !238, line: 197, baseType: !260)
!772 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !740, file: !741, line: 66, baseType: !765, size: 128, offset: 704)
!773 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !740, file: !741, line: 67, baseType: !765, size: 128, offset: 832)
!774 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !740, file: !741, line: 79, baseType: !775, size: 64, offset: 960)
!775 = !DICompositeType(tag: DW_TAG_array_type, baseType: !207, size: 64, elements: !55)
!776 = !DILocalVariable(name: "len", scope: !733, file: !2, line: 37, type: !777)
!777 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !778, line: 85, baseType: !758)
!778 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!779 = !DILocalVariable(name: "bytes_read", scope: !733, file: !2, line: 38, type: !780)
!780 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !778, line: 108, baseType: !781)
!781 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !238, line: 194, baseType: !260)
!782 = !DILocalVariable(name: "status", scope: !733, file: !2, line: 38, type: !780)
!783 = distinct !DIAssignID()
!784 = !DILocation(line: 0, scope: !733)
!785 = !DILocation(line: 36, column: 3, scope: !733)
!786 = !DILocation(line: 40, column: 3, scope: !787)
!787 = distinct !DILexicalBlock(scope: !788, file: !2, line: 40, column: 3)
!788 = distinct !DILexicalBlock(scope: !733, file: !2, line: 40, column: 3)
!789 = !DILocation(line: 41, column: 3, scope: !790)
!790 = distinct !DILexicalBlock(scope: !791, file: !2, line: 41, column: 3)
!791 = distinct !DILexicalBlock(scope: !733, file: !2, line: 41, column: 3)
!792 = !DILocation(line: 42, column: 11, scope: !733)
!793 = !DILocation(line: 43, column: 3, scope: !794)
!794 = distinct !DILexicalBlock(scope: !795, file: !2, line: 43, column: 3)
!795 = distinct !DILexicalBlock(scope: !733, file: !2, line: 43, column: 3)
!796 = !DILocation(line: 44, column: 25, scope: !733)
!797 = !DILocation(line: 44, column: 15, scope: !733)
!798 = !DILocation(line: 46, column: 3, scope: !733)
!799 = !DILocation(line: 49, column: 15, scope: !800)
!800 = distinct !DILexicalBlock(scope: !733, file: !2, line: 46, column: 27)
!801 = !DILocation(line: 46, column: 20, scope: !733)
!802 = distinct !{!802, !798, !803, !394, !395}
!803 = !DILocation(line: 50, column: 3, scope: !733)
!804 = !DILocation(line: 47, column: 24, scope: !800)
!805 = !DILocation(line: 47, column: 42, scope: !800)
!806 = !DILocation(line: 47, column: 14, scope: !800)
!807 = !DILocation(line: 48, column: 5, scope: !808)
!808 = distinct !DILexicalBlock(scope: !809, file: !2, line: 48, column: 5)
!809 = distinct !DILexicalBlock(scope: !800, file: !2, line: 48, column: 5)
!810 = !DILocation(line: 51, column: 3, scope: !733)
!811 = !DILocation(line: 51, column: 10, scope: !733)
!812 = !DILocation(line: 52, column: 3, scope: !733)
!813 = !DILocation(line: 54, column: 1, scope: !733)
!814 = !DILocation(line: 53, column: 3, scope: !733)
!815 = !DISubprogram(name: "__assert_fail", scope: !816, file: !816, line: 67, type: !817, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!816 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!817 = !DISubroutineType(types: !818)
!818 = !{null, !819, !819, !245, !819}
!819 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!820 = !DISubprogram(name: "fstat", scope: !821, file: !821, line: 210, type: !822, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!821 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!822 = !DISubroutineType(types: !823)
!823 = !{!207, !207, !824}
!824 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !740, size: 64)
!825 = !DISubprogram(name: "malloc", scope: !557, file: !557, line: 672, type: !826, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!826 = !DISubroutineType(types: !827)
!827 = !{!234, !828}
!828 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !829, line: 18, baseType: !248)
!829 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!830 = !DISubprogram(name: "read", scope: !831, file: !831, line: 371, type: !832, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!831 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!832 = !DISubroutineType(types: !833)
!833 = !{!780, !207, !234, !828}
!834 = !DISubprogram(name: "close", scope: !831, file: !831, line: 358, type: !566, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!835 = !DILocation(line: 0, scope: !465)
!836 = !DILocation(line: 59, column: 3, scope: !837)
!837 = distinct !DILexicalBlock(scope: !838, file: !2, line: 59, column: 3)
!838 = distinct !DILexicalBlock(scope: !465, file: !2, line: 59, column: 3)
!839 = !DILocation(line: 60, column: 7, scope: !840)
!840 = distinct !DILexicalBlock(scope: !465, file: !2, line: 60, column: 6)
!841 = !DILocation(line: 60, column: 6, scope: !465)
!842 = !DILocation(line: 64, column: 17, scope: !465)
!843 = !DILocation(line: 64, column: 3, scope: !465)
!844 = !DILocation(line: 66, column: 22, scope: !477)
!845 = !DILocation(line: 66, column: 26, scope: !477)
!846 = !DILocation(line: 66, column: 32, scope: !477)
!847 = !DILocation(line: 66, column: 35, scope: !477)
!848 = !DILocation(line: 66, column: 39, scope: !477)
!849 = !DILocation(line: 66, column: 9, scope: !478)
!850 = !DILocation(line: 69, column: 6, scope: !478)
!851 = !DILocation(line: 64, column: 10, scope: !465)
!852 = !DILocation(line: 64, column: 13, scope: !465)
!853 = distinct !{!853, !843, !854, !394, !395}
!854 = !DILocation(line: 70, column: 3, scope: !465)
!855 = !DILocation(line: 71, column: 6, scope: !490)
!856 = !DILocation(line: 71, column: 8, scope: !490)
!857 = !DILocation(line: 71, column: 6, scope: !465)
!858 = !DILocation(line: 74, column: 1, scope: !465)
!859 = distinct !DISubprogram(name: "parse_string", scope: !2, file: !2, line: 77, type: !860, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !862)
!860 = !DISubroutineType(types: !861)
!861 = !{!207, !233, !233, !207}
!862 = !{!863, !864, !865, !866}
!863 = !DILocalVariable(name: "s", arg: 1, scope: !859, file: !2, line: 77, type: !233)
!864 = !DILocalVariable(name: "arr", arg: 2, scope: !859, file: !2, line: 77, type: !233)
!865 = !DILocalVariable(name: "n", arg: 3, scope: !859, file: !2, line: 77, type: !207)
!866 = !DILocalVariable(name: "k", scope: !859, file: !2, line: 78, type: !207)
!867 = !DILocation(line: 0, scope: !859)
!868 = !DILocation(line: 79, column: 3, scope: !869)
!869 = distinct !DILexicalBlock(scope: !870, file: !2, line: 79, column: 3)
!870 = distinct !DILexicalBlock(scope: !859, file: !2, line: 79, column: 3)
!871 = !DILocation(line: 81, column: 8, scope: !872)
!872 = distinct !DILexicalBlock(scope: !859, file: !2, line: 81, column: 7)
!873 = !DILocation(line: 81, column: 7, scope: !859)
!874 = !DILocation(line: 83, column: 12, scope: !875)
!875 = distinct !DILexicalBlock(scope: !872, file: !2, line: 81, column: 13)
!876 = !DILocation(line: 83, column: 5, scope: !875)
!877 = !DILocation(line: 91, column: 19, scope: !859)
!878 = !DILocation(line: 91, column: 3, scope: !859)
!879 = !DILocation(line: 92, column: 7, scope: !859)
!880 = !DILocation(line: 83, column: 16, scope: !875)
!881 = !DILocation(line: 83, column: 26, scope: !875)
!882 = !DILocation(line: 83, column: 32, scope: !875)
!883 = !DILocation(line: 83, column: 29, scope: !875)
!884 = !DILocation(line: 83, column: 35, scope: !875)
!885 = !DILocation(line: 83, column: 45, scope: !875)
!886 = !DILocation(line: 83, column: 48, scope: !875)
!887 = !DILocation(line: 83, column: 54, scope: !875)
!888 = !DILocation(line: 84, column: 9, scope: !875)
!889 = !DILocation(line: 84, column: 18, scope: !875)
!890 = !DILocation(line: 84, column: 26, scope: !875)
!891 = distinct !{!891, !876, !892, !394, !395}
!892 = !DILocation(line: 86, column: 5, scope: !875)
!893 = !DILocation(line: 93, column: 5, scope: !894)
!894 = distinct !DILexicalBlock(scope: !859, file: !2, line: 92, column: 7)
!895 = !DILocation(line: 93, column: 12, scope: !894)
!896 = !DILocation(line: 95, column: 3, scope: !859)
!897 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !2, file: !2, line: 132, type: !898, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !901)
!898 = !DISubroutineType(types: !899)
!899 = !{!207, !233, !900, !207}
!900 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !235, size: 64)
!901 = !{!902, !903, !904, !905, !906, !907, !908}
!902 = !DILocalVariable(name: "s", arg: 1, scope: !897, file: !2, line: 132, type: !233)
!903 = !DILocalVariable(name: "arr", arg: 2, scope: !897, file: !2, line: 132, type: !900)
!904 = !DILocalVariable(name: "n", arg: 3, scope: !897, file: !2, line: 132, type: !207)
!905 = !DILocalVariable(name: "line", scope: !897, file: !2, line: 132, type: !233)
!906 = !DILocalVariable(name: "endptr", scope: !897, file: !2, line: 132, type: !233)
!907 = !DILocalVariable(name: "i", scope: !897, file: !2, line: 132, type: !207)
!908 = !DILocalVariable(name: "v", scope: !897, file: !2, line: 132, type: !235)
!909 = distinct !DIAssignID()
!910 = !DILocation(line: 0, scope: !897)
!911 = !DILocation(line: 132, column: 1, scope: !897)
!912 = !DILocation(line: 132, column: 1, scope: !913)
!913 = distinct !DILexicalBlock(scope: !914, file: !2, line: 132, column: 1)
!914 = distinct !DILexicalBlock(scope: !897, file: !2, line: 132, column: 1)
!915 = !DILocation(line: 132, column: 1, scope: !916)
!916 = distinct !DILexicalBlock(scope: !897, file: !2, line: 132, column: 1)
!917 = !{!918, !918, i64 0}
!918 = !{!"any pointer", !361, i64 0}
!919 = distinct !DIAssignID()
!920 = !DILocation(line: 132, column: 1, scope: !921)
!921 = distinct !DILexicalBlock(scope: !916, file: !2, line: 132, column: 1)
!922 = !DILocation(line: 132, column: 1, scope: !923)
!923 = distinct !DILexicalBlock(scope: !921, file: !2, line: 132, column: 1)
!924 = distinct !{!924, !911, !911, !394, !395}
!925 = !DILocation(line: 132, column: 1, scope: !926)
!926 = distinct !DILexicalBlock(scope: !927, file: !2, line: 132, column: 1)
!927 = distinct !DILexicalBlock(scope: !897, file: !2, line: 132, column: 1)
!928 = !DISubprogram(name: "strtok", scope: !929, file: !929, line: 356, type: !930, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!929 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!930 = !DISubroutineType(types: !931)
!931 = !{!233, !932, !933}
!932 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !233)
!933 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !819)
!934 = !DISubprogram(name: "strtol", scope: !557, file: !557, line: 177, type: !935, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!935 = !DISubroutineType(types: !936)
!936 = !{!260, !933, !937, !207}
!937 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !938)
!938 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !233, size: 64)
!939 = !DISubprogram(name: "fprintf", scope: !940, file: !940, line: 357, type: !941, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!940 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!941 = !DISubroutineType(types: !942)
!942 = !{!207, !943, !933, null}
!943 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !944)
!944 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !945, size: 64)
!945 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !946, line: 7, baseType: !947)
!946 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!947 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !948, line: 49, size: 1728, elements: !949)
!948 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!949 = !{!950, !951, !952, !953, !954, !955, !956, !957, !958, !959, !960, !961, !962, !965, !967, !968, !969, !970, !971, !972, !976, !979, !981, !984, !987, !988, !989, !991, !992}
!950 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !947, file: !948, line: 51, baseType: !207, size: 32)
!951 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !947, file: !948, line: 54, baseType: !233, size: 64, offset: 64)
!952 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !947, file: !948, line: 55, baseType: !233, size: 64, offset: 128)
!953 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !947, file: !948, line: 56, baseType: !233, size: 64, offset: 192)
!954 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !947, file: !948, line: 57, baseType: !233, size: 64, offset: 256)
!955 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !947, file: !948, line: 58, baseType: !233, size: 64, offset: 320)
!956 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !947, file: !948, line: 59, baseType: !233, size: 64, offset: 384)
!957 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !947, file: !948, line: 60, baseType: !233, size: 64, offset: 448)
!958 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !947, file: !948, line: 61, baseType: !233, size: 64, offset: 512)
!959 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !947, file: !948, line: 64, baseType: !233, size: 64, offset: 576)
!960 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !947, file: !948, line: 65, baseType: !233, size: 64, offset: 640)
!961 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !947, file: !948, line: 66, baseType: !233, size: 64, offset: 704)
!962 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !947, file: !948, line: 68, baseType: !963, size: 64, offset: 768)
!963 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !964, size: 64)
!964 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !948, line: 36, flags: DIFlagFwdDecl)
!965 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !947, file: !948, line: 70, baseType: !966, size: 64, offset: 832)
!966 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !947, size: 64)
!967 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !947, file: !948, line: 72, baseType: !207, size: 32, offset: 896)
!968 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !947, file: !948, line: 73, baseType: !207, size: 32, offset: 928)
!969 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !947, file: !948, line: 74, baseType: !758, size: 64, offset: 960)
!970 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !947, file: !948, line: 77, baseType: !242, size: 16, offset: 1024)
!971 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !947, file: !948, line: 78, baseType: !252, size: 8, offset: 1040)
!972 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !947, file: !948, line: 79, baseType: !973, size: 8, offset: 1048)
!973 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 8, elements: !974)
!974 = !{!975}
!975 = !DISubrange(count: 1)
!976 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !947, file: !948, line: 81, baseType: !977, size: 64, offset: 1088)
!977 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !978, size: 64)
!978 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !948, line: 43, baseType: null)
!979 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !947, file: !948, line: 89, baseType: !980, size: 64, offset: 1152)
!980 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !238, line: 153, baseType: !260)
!981 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !947, file: !948, line: 91, baseType: !982, size: 64, offset: 1216)
!982 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !983, size: 64)
!983 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !948, line: 37, flags: DIFlagFwdDecl)
!984 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !947, file: !948, line: 92, baseType: !985, size: 64, offset: 1280)
!985 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !986, size: 64)
!986 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !948, line: 38, flags: DIFlagFwdDecl)
!987 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !947, file: !948, line: 93, baseType: !966, size: 64, offset: 1344)
!988 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !947, file: !948, line: 94, baseType: !234, size: 64, offset: 1408)
!989 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !947, file: !948, line: 95, baseType: !990, size: 64, offset: 1472)
!990 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !966, size: 64)
!991 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !947, file: !948, line: 96, baseType: !207, size: 32, offset: 1536)
!992 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !947, file: !948, line: 98, baseType: !993, size: 160, offset: 1568)
!993 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !16)
!994 = !DISubprogram(name: "strlen", scope: !929, file: !929, line: 407, type: !995, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!995 = !DISubroutineType(types: !996)
!996 = !{!248, !819}
!997 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !2, file: !2, line: 133, type: !998, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1001)
!998 = !DISubroutineType(types: !999)
!999 = !{!207, !233, !1000, !207}
!1000 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !240, size: 64)
!1001 = !{!1002, !1003, !1004, !1005, !1006, !1007, !1008}
!1002 = !DILocalVariable(name: "s", arg: 1, scope: !997, file: !2, line: 133, type: !233)
!1003 = !DILocalVariable(name: "arr", arg: 2, scope: !997, file: !2, line: 133, type: !1000)
!1004 = !DILocalVariable(name: "n", arg: 3, scope: !997, file: !2, line: 133, type: !207)
!1005 = !DILocalVariable(name: "line", scope: !997, file: !2, line: 133, type: !233)
!1006 = !DILocalVariable(name: "endptr", scope: !997, file: !2, line: 133, type: !233)
!1007 = !DILocalVariable(name: "i", scope: !997, file: !2, line: 133, type: !207)
!1008 = !DILocalVariable(name: "v", scope: !997, file: !2, line: 133, type: !240)
!1009 = distinct !DIAssignID()
!1010 = !DILocation(line: 0, scope: !997)
!1011 = !DILocation(line: 133, column: 1, scope: !997)
!1012 = !DILocation(line: 133, column: 1, scope: !1013)
!1013 = distinct !DILexicalBlock(scope: !1014, file: !2, line: 133, column: 1)
!1014 = distinct !DILexicalBlock(scope: !997, file: !2, line: 133, column: 1)
!1015 = !DILocation(line: 133, column: 1, scope: !1016)
!1016 = distinct !DILexicalBlock(scope: !997, file: !2, line: 133, column: 1)
!1017 = distinct !DIAssignID()
!1018 = !DILocation(line: 133, column: 1, scope: !1019)
!1019 = distinct !DILexicalBlock(scope: !1016, file: !2, line: 133, column: 1)
!1020 = !DILocation(line: 133, column: 1, scope: !1021)
!1021 = distinct !DILexicalBlock(scope: !1019, file: !2, line: 133, column: 1)
!1022 = !{!1023, !1023, i64 0}
!1023 = !{!"short", !361, i64 0}
!1024 = distinct !{!1024, !1011, !1011, !394, !395}
!1025 = !DILocation(line: 133, column: 1, scope: !1026)
!1026 = distinct !DILexicalBlock(scope: !1027, file: !2, line: 133, column: 1)
!1027 = distinct !DILexicalBlock(scope: !997, file: !2, line: 133, column: 1)
!1028 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !2, file: !2, line: 134, type: !1029, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1032)
!1029 = !DISubroutineType(types: !1030)
!1030 = !{!207, !233, !1031, !207}
!1031 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !243, size: 64)
!1032 = !{!1033, !1034, !1035, !1036, !1037, !1038, !1039}
!1033 = !DILocalVariable(name: "s", arg: 1, scope: !1028, file: !2, line: 134, type: !233)
!1034 = !DILocalVariable(name: "arr", arg: 2, scope: !1028, file: !2, line: 134, type: !1031)
!1035 = !DILocalVariable(name: "n", arg: 3, scope: !1028, file: !2, line: 134, type: !207)
!1036 = !DILocalVariable(name: "line", scope: !1028, file: !2, line: 134, type: !233)
!1037 = !DILocalVariable(name: "endptr", scope: !1028, file: !2, line: 134, type: !233)
!1038 = !DILocalVariable(name: "i", scope: !1028, file: !2, line: 134, type: !207)
!1039 = !DILocalVariable(name: "v", scope: !1028, file: !2, line: 134, type: !243)
!1040 = distinct !DIAssignID()
!1041 = !DILocation(line: 0, scope: !1028)
!1042 = !DILocation(line: 134, column: 1, scope: !1028)
!1043 = !DILocation(line: 134, column: 1, scope: !1044)
!1044 = distinct !DILexicalBlock(scope: !1045, file: !2, line: 134, column: 1)
!1045 = distinct !DILexicalBlock(scope: !1028, file: !2, line: 134, column: 1)
!1046 = !DILocation(line: 134, column: 1, scope: !1047)
!1047 = distinct !DILexicalBlock(scope: !1028, file: !2, line: 134, column: 1)
!1048 = distinct !DIAssignID()
!1049 = !DILocation(line: 134, column: 1, scope: !1050)
!1050 = distinct !DILexicalBlock(scope: !1047, file: !2, line: 134, column: 1)
!1051 = !DILocation(line: 134, column: 1, scope: !1052)
!1052 = distinct !DILexicalBlock(scope: !1050, file: !2, line: 134, column: 1)
!1053 = !{!1054, !1054, i64 0}
!1054 = !{!"int", !361, i64 0}
!1055 = distinct !{!1055, !1042, !1042, !394, !395}
!1056 = !DILocation(line: 134, column: 1, scope: !1057)
!1057 = distinct !DILexicalBlock(scope: !1058, file: !2, line: 134, column: 1)
!1058 = distinct !DILexicalBlock(scope: !1028, file: !2, line: 134, column: 1)
!1059 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !2, file: !2, line: 135, type: !1060, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1063)
!1060 = !DISubroutineType(types: !1061)
!1061 = !{!207, !233, !1062, !207}
!1062 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !246, size: 64)
!1063 = !{!1064, !1065, !1066, !1067, !1068, !1069, !1070}
!1064 = !DILocalVariable(name: "s", arg: 1, scope: !1059, file: !2, line: 135, type: !233)
!1065 = !DILocalVariable(name: "arr", arg: 2, scope: !1059, file: !2, line: 135, type: !1062)
!1066 = !DILocalVariable(name: "n", arg: 3, scope: !1059, file: !2, line: 135, type: !207)
!1067 = !DILocalVariable(name: "line", scope: !1059, file: !2, line: 135, type: !233)
!1068 = !DILocalVariable(name: "endptr", scope: !1059, file: !2, line: 135, type: !233)
!1069 = !DILocalVariable(name: "i", scope: !1059, file: !2, line: 135, type: !207)
!1070 = !DILocalVariable(name: "v", scope: !1059, file: !2, line: 135, type: !246)
!1071 = distinct !DIAssignID()
!1072 = !DILocation(line: 0, scope: !1059)
!1073 = !DILocation(line: 135, column: 1, scope: !1059)
!1074 = !DILocation(line: 135, column: 1, scope: !1075)
!1075 = distinct !DILexicalBlock(scope: !1076, file: !2, line: 135, column: 1)
!1076 = distinct !DILexicalBlock(scope: !1059, file: !2, line: 135, column: 1)
!1077 = !DILocation(line: 135, column: 1, scope: !1078)
!1078 = distinct !DILexicalBlock(scope: !1059, file: !2, line: 135, column: 1)
!1079 = distinct !DIAssignID()
!1080 = !DILocation(line: 135, column: 1, scope: !1081)
!1081 = distinct !DILexicalBlock(scope: !1078, file: !2, line: 135, column: 1)
!1082 = !DILocation(line: 135, column: 1, scope: !1083)
!1083 = distinct !DILexicalBlock(scope: !1081, file: !2, line: 135, column: 1)
!1084 = !{!1085, !1085, i64 0}
!1085 = !{!"long", !361, i64 0}
!1086 = distinct !{!1086, !1073, !1073, !394, !395}
!1087 = !DILocation(line: 135, column: 1, scope: !1088)
!1088 = distinct !DILexicalBlock(scope: !1089, file: !2, line: 135, column: 1)
!1089 = distinct !DILexicalBlock(scope: !1059, file: !2, line: 135, column: 1)
!1090 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !2, file: !2, line: 136, type: !1091, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1094)
!1091 = !DISubroutineType(types: !1092)
!1092 = !{!207, !233, !1093, !207}
!1093 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !249, size: 64)
!1094 = !{!1095, !1096, !1097, !1098, !1099, !1100, !1101}
!1095 = !DILocalVariable(name: "s", arg: 1, scope: !1090, file: !2, line: 136, type: !233)
!1096 = !DILocalVariable(name: "arr", arg: 2, scope: !1090, file: !2, line: 136, type: !1093)
!1097 = !DILocalVariable(name: "n", arg: 3, scope: !1090, file: !2, line: 136, type: !207)
!1098 = !DILocalVariable(name: "line", scope: !1090, file: !2, line: 136, type: !233)
!1099 = !DILocalVariable(name: "endptr", scope: !1090, file: !2, line: 136, type: !233)
!1100 = !DILocalVariable(name: "i", scope: !1090, file: !2, line: 136, type: !207)
!1101 = !DILocalVariable(name: "v", scope: !1090, file: !2, line: 136, type: !249)
!1102 = distinct !DIAssignID()
!1103 = !DILocation(line: 0, scope: !1090)
!1104 = !DILocation(line: 136, column: 1, scope: !1090)
!1105 = !DILocation(line: 136, column: 1, scope: !1106)
!1106 = distinct !DILexicalBlock(scope: !1107, file: !2, line: 136, column: 1)
!1107 = distinct !DILexicalBlock(scope: !1090, file: !2, line: 136, column: 1)
!1108 = !DILocation(line: 136, column: 1, scope: !1109)
!1109 = distinct !DILexicalBlock(scope: !1090, file: !2, line: 136, column: 1)
!1110 = distinct !DIAssignID()
!1111 = !DILocation(line: 136, column: 1, scope: !1112)
!1112 = distinct !DILexicalBlock(scope: !1109, file: !2, line: 136, column: 1)
!1113 = !DILocation(line: 136, column: 1, scope: !1114)
!1114 = distinct !DILexicalBlock(scope: !1112, file: !2, line: 136, column: 1)
!1115 = distinct !{!1115, !1104, !1104, !394, !395}
!1116 = !DILocation(line: 136, column: 1, scope: !1117)
!1117 = distinct !DILexicalBlock(scope: !1118, file: !2, line: 136, column: 1)
!1118 = distinct !DILexicalBlock(scope: !1090, file: !2, line: 136, column: 1)
!1119 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !2, file: !2, line: 137, type: !1120, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1123)
!1120 = !DISubroutineType(types: !1121)
!1121 = !{!207, !233, !1122, !207}
!1122 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !253, size: 64)
!1123 = !{!1124, !1125, !1126, !1127, !1128, !1129, !1130}
!1124 = !DILocalVariable(name: "s", arg: 1, scope: !1119, file: !2, line: 137, type: !233)
!1125 = !DILocalVariable(name: "arr", arg: 2, scope: !1119, file: !2, line: 137, type: !1122)
!1126 = !DILocalVariable(name: "n", arg: 3, scope: !1119, file: !2, line: 137, type: !207)
!1127 = !DILocalVariable(name: "line", scope: !1119, file: !2, line: 137, type: !233)
!1128 = !DILocalVariable(name: "endptr", scope: !1119, file: !2, line: 137, type: !233)
!1129 = !DILocalVariable(name: "i", scope: !1119, file: !2, line: 137, type: !207)
!1130 = !DILocalVariable(name: "v", scope: !1119, file: !2, line: 137, type: !253)
!1131 = distinct !DIAssignID()
!1132 = !DILocation(line: 0, scope: !1119)
!1133 = !DILocation(line: 137, column: 1, scope: !1119)
!1134 = !DILocation(line: 137, column: 1, scope: !1135)
!1135 = distinct !DILexicalBlock(scope: !1136, file: !2, line: 137, column: 1)
!1136 = distinct !DILexicalBlock(scope: !1119, file: !2, line: 137, column: 1)
!1137 = !DILocation(line: 137, column: 1, scope: !1138)
!1138 = distinct !DILexicalBlock(scope: !1119, file: !2, line: 137, column: 1)
!1139 = distinct !DIAssignID()
!1140 = !DILocation(line: 137, column: 1, scope: !1141)
!1141 = distinct !DILexicalBlock(scope: !1138, file: !2, line: 137, column: 1)
!1142 = !DILocation(line: 137, column: 1, scope: !1143)
!1143 = distinct !DILexicalBlock(scope: !1141, file: !2, line: 137, column: 1)
!1144 = distinct !{!1144, !1133, !1133, !394, !395}
!1145 = !DILocation(line: 137, column: 1, scope: !1146)
!1146 = distinct !DILexicalBlock(scope: !1147, file: !2, line: 137, column: 1)
!1147 = distinct !DILexicalBlock(scope: !1119, file: !2, line: 137, column: 1)
!1148 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !2, file: !2, line: 138, type: !1149, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1152)
!1149 = !DISubroutineType(types: !1150)
!1150 = !{!207, !233, !1151, !207}
!1151 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !256, size: 64)
!1152 = !{!1153, !1154, !1155, !1156, !1157, !1158, !1159}
!1153 = !DILocalVariable(name: "s", arg: 1, scope: !1148, file: !2, line: 138, type: !233)
!1154 = !DILocalVariable(name: "arr", arg: 2, scope: !1148, file: !2, line: 138, type: !1151)
!1155 = !DILocalVariable(name: "n", arg: 3, scope: !1148, file: !2, line: 138, type: !207)
!1156 = !DILocalVariable(name: "line", scope: !1148, file: !2, line: 138, type: !233)
!1157 = !DILocalVariable(name: "endptr", scope: !1148, file: !2, line: 138, type: !233)
!1158 = !DILocalVariable(name: "i", scope: !1148, file: !2, line: 138, type: !207)
!1159 = !DILocalVariable(name: "v", scope: !1148, file: !2, line: 138, type: !256)
!1160 = distinct !DIAssignID()
!1161 = !DILocation(line: 0, scope: !1148)
!1162 = !DILocation(line: 138, column: 1, scope: !1148)
!1163 = !DILocation(line: 138, column: 1, scope: !1164)
!1164 = distinct !DILexicalBlock(scope: !1165, file: !2, line: 138, column: 1)
!1165 = distinct !DILexicalBlock(scope: !1148, file: !2, line: 138, column: 1)
!1166 = !DILocation(line: 138, column: 1, scope: !1167)
!1167 = distinct !DILexicalBlock(scope: !1148, file: !2, line: 138, column: 1)
!1168 = distinct !DIAssignID()
!1169 = !DILocation(line: 138, column: 1, scope: !1170)
!1170 = distinct !DILexicalBlock(scope: !1167, file: !2, line: 138, column: 1)
!1171 = !DILocation(line: 138, column: 1, scope: !1172)
!1172 = distinct !DILexicalBlock(scope: !1170, file: !2, line: 138, column: 1)
!1173 = distinct !{!1173, !1162, !1162, !394, !395}
!1174 = !DILocation(line: 138, column: 1, scope: !1175)
!1175 = distinct !DILexicalBlock(scope: !1176, file: !2, line: 138, column: 1)
!1176 = distinct !DILexicalBlock(scope: !1148, file: !2, line: 138, column: 1)
!1177 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !2, file: !2, line: 139, type: !1178, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1181)
!1178 = !DISubroutineType(types: !1179)
!1179 = !{!207, !233, !1180, !207}
!1180 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !258, size: 64)
!1181 = !{!1182, !1183, !1184, !1185, !1186, !1187, !1188}
!1182 = !DILocalVariable(name: "s", arg: 1, scope: !1177, file: !2, line: 139, type: !233)
!1183 = !DILocalVariable(name: "arr", arg: 2, scope: !1177, file: !2, line: 139, type: !1180)
!1184 = !DILocalVariable(name: "n", arg: 3, scope: !1177, file: !2, line: 139, type: !207)
!1185 = !DILocalVariable(name: "line", scope: !1177, file: !2, line: 139, type: !233)
!1186 = !DILocalVariable(name: "endptr", scope: !1177, file: !2, line: 139, type: !233)
!1187 = !DILocalVariable(name: "i", scope: !1177, file: !2, line: 139, type: !207)
!1188 = !DILocalVariable(name: "v", scope: !1177, file: !2, line: 139, type: !258)
!1189 = distinct !DIAssignID()
!1190 = !DILocation(line: 0, scope: !1177)
!1191 = !DILocation(line: 139, column: 1, scope: !1177)
!1192 = !DILocation(line: 139, column: 1, scope: !1193)
!1193 = distinct !DILexicalBlock(scope: !1194, file: !2, line: 139, column: 1)
!1194 = distinct !DILexicalBlock(scope: !1177, file: !2, line: 139, column: 1)
!1195 = !DILocation(line: 139, column: 1, scope: !1196)
!1196 = distinct !DILexicalBlock(scope: !1177, file: !2, line: 139, column: 1)
!1197 = distinct !DIAssignID()
!1198 = !DILocation(line: 139, column: 1, scope: !1199)
!1199 = distinct !DILexicalBlock(scope: !1196, file: !2, line: 139, column: 1)
!1200 = !DILocation(line: 139, column: 1, scope: !1201)
!1201 = distinct !DILexicalBlock(scope: !1199, file: !2, line: 139, column: 1)
!1202 = distinct !{!1202, !1191, !1191, !394, !395}
!1203 = !DILocation(line: 139, column: 1, scope: !1204)
!1204 = distinct !DILexicalBlock(scope: !1205, file: !2, line: 139, column: 1)
!1205 = distinct !DILexicalBlock(scope: !1177, file: !2, line: 139, column: 1)
!1206 = distinct !DISubprogram(name: "parse_float_array", scope: !2, file: !2, line: 141, type: !1207, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1210)
!1207 = !DISubroutineType(types: !1208)
!1208 = !{!207, !233, !1209, !207}
!1209 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !261, size: 64)
!1210 = !{!1211, !1212, !1213, !1214, !1215, !1216, !1217}
!1211 = !DILocalVariable(name: "s", arg: 1, scope: !1206, file: !2, line: 141, type: !233)
!1212 = !DILocalVariable(name: "arr", arg: 2, scope: !1206, file: !2, line: 141, type: !1209)
!1213 = !DILocalVariable(name: "n", arg: 3, scope: !1206, file: !2, line: 141, type: !207)
!1214 = !DILocalVariable(name: "line", scope: !1206, file: !2, line: 141, type: !233)
!1215 = !DILocalVariable(name: "endptr", scope: !1206, file: !2, line: 141, type: !233)
!1216 = !DILocalVariable(name: "i", scope: !1206, file: !2, line: 141, type: !207)
!1217 = !DILocalVariable(name: "v", scope: !1206, file: !2, line: 141, type: !261)
!1218 = distinct !DIAssignID()
!1219 = !DILocation(line: 0, scope: !1206)
!1220 = !DILocation(line: 141, column: 1, scope: !1206)
!1221 = !DILocation(line: 141, column: 1, scope: !1222)
!1222 = distinct !DILexicalBlock(scope: !1223, file: !2, line: 141, column: 1)
!1223 = distinct !DILexicalBlock(scope: !1206, file: !2, line: 141, column: 1)
!1224 = !DILocation(line: 141, column: 1, scope: !1225)
!1225 = distinct !DILexicalBlock(scope: !1206, file: !2, line: 141, column: 1)
!1226 = distinct !DIAssignID()
!1227 = !DILocation(line: 141, column: 1, scope: !1228)
!1228 = distinct !DILexicalBlock(scope: !1225, file: !2, line: 141, column: 1)
!1229 = !DILocation(line: 141, column: 1, scope: !1230)
!1230 = distinct !DILexicalBlock(scope: !1228, file: !2, line: 141, column: 1)
!1231 = !{!1232, !1232, i64 0}
!1232 = !{!"float", !361, i64 0}
!1233 = distinct !{!1233, !1220, !1220, !394, !395}
!1234 = !DILocation(line: 141, column: 1, scope: !1235)
!1235 = distinct !DILexicalBlock(scope: !1236, file: !2, line: 141, column: 1)
!1236 = distinct !DILexicalBlock(scope: !1206, file: !2, line: 141, column: 1)
!1237 = !DISubprogram(name: "strtof", scope: !557, file: !557, line: 124, type: !1238, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1238 = !DISubroutineType(types: !1239)
!1239 = !{!261, !933, !937}
!1240 = distinct !DISubprogram(name: "parse_double_array", scope: !2, file: !2, line: 142, type: !1241, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1243)
!1241 = !DISubroutineType(types: !1242)
!1242 = !{!207, !233, !332, !207}
!1243 = !{!1244, !1245, !1246, !1247, !1248, !1249, !1250}
!1244 = !DILocalVariable(name: "s", arg: 1, scope: !1240, file: !2, line: 142, type: !233)
!1245 = !DILocalVariable(name: "arr", arg: 2, scope: !1240, file: !2, line: 142, type: !332)
!1246 = !DILocalVariable(name: "n", arg: 3, scope: !1240, file: !2, line: 142, type: !207)
!1247 = !DILocalVariable(name: "line", scope: !1240, file: !2, line: 142, type: !233)
!1248 = !DILocalVariable(name: "endptr", scope: !1240, file: !2, line: 142, type: !233)
!1249 = !DILocalVariable(name: "i", scope: !1240, file: !2, line: 142, type: !207)
!1250 = !DILocalVariable(name: "v", scope: !1240, file: !2, line: 142, type: !197)
!1251 = distinct !DIAssignID()
!1252 = !DILocation(line: 0, scope: !1240)
!1253 = !DILocation(line: 142, column: 1, scope: !1240)
!1254 = !DILocation(line: 142, column: 1, scope: !1255)
!1255 = distinct !DILexicalBlock(scope: !1256, file: !2, line: 142, column: 1)
!1256 = distinct !DILexicalBlock(scope: !1240, file: !2, line: 142, column: 1)
!1257 = !DILocation(line: 142, column: 1, scope: !1258)
!1258 = distinct !DILexicalBlock(scope: !1240, file: !2, line: 142, column: 1)
!1259 = distinct !DIAssignID()
!1260 = !DILocation(line: 142, column: 1, scope: !1261)
!1261 = distinct !DILexicalBlock(scope: !1258, file: !2, line: 142, column: 1)
!1262 = !DILocation(line: 142, column: 1, scope: !1263)
!1263 = distinct !DILexicalBlock(scope: !1261, file: !2, line: 142, column: 1)
!1264 = distinct !{!1264, !1253, !1253, !394, !395}
!1265 = !DILocation(line: 142, column: 1, scope: !1266)
!1266 = distinct !DILexicalBlock(scope: !1267, file: !2, line: 142, column: 1)
!1267 = distinct !DILexicalBlock(scope: !1240, file: !2, line: 142, column: 1)
!1268 = !DISubprogram(name: "strtod", scope: !557, file: !557, line: 118, type: !1269, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1269 = !DISubroutineType(types: !1270)
!1270 = !{!197, !933, !937}
!1271 = distinct !DISubprogram(name: "write_string", scope: !2, file: !2, line: 145, type: !1272, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1274)
!1272 = !DISubroutineType(types: !1273)
!1273 = !{!207, !207, !233, !207}
!1274 = !{!1275, !1276, !1277, !1278, !1279}
!1275 = !DILocalVariable(name: "fd", arg: 1, scope: !1271, file: !2, line: 145, type: !207)
!1276 = !DILocalVariable(name: "arr", arg: 2, scope: !1271, file: !2, line: 145, type: !233)
!1277 = !DILocalVariable(name: "n", arg: 3, scope: !1271, file: !2, line: 145, type: !207)
!1278 = !DILocalVariable(name: "status", scope: !1271, file: !2, line: 146, type: !207)
!1279 = !DILocalVariable(name: "written", scope: !1271, file: !2, line: 146, type: !207)
!1280 = !DILocation(line: 0, scope: !1271)
!1281 = !DILocation(line: 147, column: 3, scope: !1282)
!1282 = distinct !DILexicalBlock(scope: !1283, file: !2, line: 147, column: 3)
!1283 = distinct !DILexicalBlock(scope: !1271, file: !2, line: 147, column: 3)
!1284 = !DILocation(line: 148, column: 8, scope: !1285)
!1285 = distinct !DILexicalBlock(scope: !1271, file: !2, line: 148, column: 7)
!1286 = !DILocation(line: 148, column: 7, scope: !1271)
!1287 = !DILocation(line: 149, column: 9, scope: !1288)
!1288 = distinct !DILexicalBlock(scope: !1285, file: !2, line: 148, column: 13)
!1289 = !DILocation(line: 150, column: 3, scope: !1288)
!1290 = !DILocation(line: 152, column: 16, scope: !1271)
!1291 = !DILocation(line: 152, column: 3, scope: !1271)
!1292 = !DILocation(line: 158, column: 3, scope: !1271)
!1293 = !DILocation(line: 155, column: 13, scope: !1294)
!1294 = distinct !DILexicalBlock(scope: !1271, file: !2, line: 152, column: 20)
!1295 = distinct !{!1295, !1291, !1296, !394, !395}
!1296 = !DILocation(line: 156, column: 3, scope: !1271)
!1297 = !DILocation(line: 153, column: 25, scope: !1294)
!1298 = !DILocation(line: 153, column: 40, scope: !1294)
!1299 = !DILocation(line: 153, column: 39, scope: !1294)
!1300 = !DILocation(line: 153, column: 14, scope: !1294)
!1301 = !DILocation(line: 154, column: 5, scope: !1302)
!1302 = distinct !DILexicalBlock(scope: !1303, file: !2, line: 154, column: 5)
!1303 = distinct !DILexicalBlock(scope: !1294, file: !2, line: 154, column: 5)
!1304 = !DILocation(line: 159, column: 14, scope: !1305)
!1305 = distinct !DILexicalBlock(scope: !1271, file: !2, line: 158, column: 6)
!1306 = !DILocation(line: 160, column: 5, scope: !1307)
!1307 = distinct !DILexicalBlock(scope: !1308, file: !2, line: 160, column: 5)
!1308 = distinct !DILexicalBlock(scope: !1305, file: !2, line: 160, column: 5)
!1309 = !DILocation(line: 161, column: 17, scope: !1271)
!1310 = !DILocation(line: 161, column: 3, scope: !1305)
!1311 = distinct !{!1311, !1292, !1312, !394, !395}
!1312 = !DILocation(line: 161, column: 20, scope: !1271)
!1313 = !DILocation(line: 163, column: 3, scope: !1271)
!1314 = !DISubprogram(name: "write", scope: !831, file: !831, line: 378, type: !1315, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1315 = !DISubroutineType(types: !1316)
!1316 = !{!780, !207, !1317, !828}
!1317 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1318, size: 64)
!1318 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1319 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !2, file: !2, line: 177, type: !1320, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1322)
!1320 = !DISubroutineType(types: !1321)
!1321 = !{!207, !207, !900, !207}
!1322 = !{!1323, !1324, !1325, !1326}
!1323 = !DILocalVariable(name: "fd", arg: 1, scope: !1319, file: !2, line: 177, type: !207)
!1324 = !DILocalVariable(name: "arr", arg: 2, scope: !1319, file: !2, line: 177, type: !900)
!1325 = !DILocalVariable(name: "n", arg: 3, scope: !1319, file: !2, line: 177, type: !207)
!1326 = !DILocalVariable(name: "i", scope: !1319, file: !2, line: 177, type: !207)
!1327 = !DILocation(line: 0, scope: !1319)
!1328 = !DILocation(line: 177, column: 1, scope: !1329)
!1329 = distinct !DILexicalBlock(scope: !1330, file: !2, line: 177, column: 1)
!1330 = distinct !DILexicalBlock(scope: !1319, file: !2, line: 177, column: 1)
!1331 = !DILocation(line: 177, column: 1, scope: !1332)
!1332 = distinct !DILexicalBlock(scope: !1333, file: !2, line: 177, column: 1)
!1333 = distinct !DILexicalBlock(scope: !1319, file: !2, line: 177, column: 1)
!1334 = !DILocation(line: 177, column: 1, scope: !1333)
!1335 = !DILocation(line: 177, column: 1, scope: !1336)
!1336 = distinct !DILexicalBlock(scope: !1332, file: !2, line: 177, column: 1)
!1337 = distinct !{!1337, !1334, !1334, !394, !395}
!1338 = !DILocation(line: 177, column: 1, scope: !1319)
!1339 = distinct !DISubprogram(name: "fd_printf", scope: !2, file: !2, line: 15, type: !1340, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1342)
!1340 = !DISubroutineType(cc: DW_CC_nocall, types: !1341)
!1341 = !{!207, !207, !819, null}
!1342 = !{!1343, !1344, !1345, !1349, !1350, !1351, !1352}
!1343 = !DILocalVariable(name: "fd", arg: 1, scope: !1339, file: !2, line: 15, type: !207)
!1344 = !DILocalVariable(name: "format", arg: 2, scope: !1339, file: !2, line: 15, type: !819)
!1345 = !DILocalVariable(name: "args", scope: !1339, file: !2, line: 16, type: !1346)
!1346 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1347, line: 12, baseType: !1348)
!1347 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1348 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !2, baseType: !234)
!1349 = !DILocalVariable(name: "buffered", scope: !1339, file: !2, line: 17, type: !207)
!1350 = !DILocalVariable(name: "written", scope: !1339, file: !2, line: 17, type: !207)
!1351 = !DILocalVariable(name: "status", scope: !1339, file: !2, line: 17, type: !207)
!1352 = !DILocalVariable(name: "buffer", scope: !1339, file: !2, line: 18, type: !1353)
!1353 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 2048, elements: !1354)
!1354 = !{!1355}
!1355 = !DISubrange(count: 256)
!1356 = distinct !DIAssignID()
!1357 = !DILocation(line: 0, scope: !1339)
!1358 = distinct !DIAssignID()
!1359 = !DILocation(line: 16, column: 3, scope: !1339)
!1360 = !DILocation(line: 18, column: 3, scope: !1339)
!1361 = !DILocation(line: 19, column: 3, scope: !1339)
!1362 = !DILocation(line: 20, column: 66, scope: !1339)
!1363 = !DILocation(line: 20, column: 14, scope: !1339)
!1364 = !DILocation(line: 21, column: 3, scope: !1339)
!1365 = !DILocation(line: 22, column: 3, scope: !1366)
!1366 = distinct !DILexicalBlock(scope: !1367, file: !2, line: 22, column: 3)
!1367 = distinct !DILexicalBlock(scope: !1339, file: !2, line: 22, column: 3)
!1368 = !DILocation(line: 24, column: 16, scope: !1339)
!1369 = !DILocation(line: 24, column: 3, scope: !1339)
!1370 = !DILocation(line: 27, column: 13, scope: !1371)
!1371 = distinct !DILexicalBlock(scope: !1339, file: !2, line: 24, column: 27)
!1372 = distinct !{!1372, !1369, !1373, !394, !395}
!1373 = !DILocation(line: 28, column: 3, scope: !1339)
!1374 = !DILocation(line: 25, column: 25, scope: !1371)
!1375 = !DILocation(line: 25, column: 50, scope: !1371)
!1376 = !DILocation(line: 25, column: 42, scope: !1371)
!1377 = !DILocation(line: 25, column: 14, scope: !1371)
!1378 = !DILocation(line: 26, column: 5, scope: !1379)
!1379 = distinct !DILexicalBlock(scope: !1380, file: !2, line: 26, column: 5)
!1380 = distinct !DILexicalBlock(scope: !1371, file: !2, line: 26, column: 5)
!1381 = !DILocation(line: 29, column: 3, scope: !1382)
!1382 = distinct !DILexicalBlock(scope: !1383, file: !2, line: 29, column: 3)
!1383 = distinct !DILexicalBlock(scope: !1339, file: !2, line: 29, column: 3)
!1384 = !DILocation(line: 31, column: 1, scope: !1339)
!1385 = !DILocation(line: 30, column: 3, scope: !1339)
!1386 = !DISubprogram(name: "vsnprintf", scope: !940, file: !940, line: 389, type: !1387, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1387 = !DISubroutineType(types: !1388)
!1388 = !{!207, !932, !828, !933, !1389}
!1389 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1390, line: 12, baseType: !1348)
!1390 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1391 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !2, file: !2, line: 178, type: !1392, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1394)
!1392 = !DISubroutineType(types: !1393)
!1393 = !{!207, !207, !1000, !207}
!1394 = !{!1395, !1396, !1397, !1398}
!1395 = !DILocalVariable(name: "fd", arg: 1, scope: !1391, file: !2, line: 178, type: !207)
!1396 = !DILocalVariable(name: "arr", arg: 2, scope: !1391, file: !2, line: 178, type: !1000)
!1397 = !DILocalVariable(name: "n", arg: 3, scope: !1391, file: !2, line: 178, type: !207)
!1398 = !DILocalVariable(name: "i", scope: !1391, file: !2, line: 178, type: !207)
!1399 = !DILocation(line: 0, scope: !1391)
!1400 = !DILocation(line: 178, column: 1, scope: !1401)
!1401 = distinct !DILexicalBlock(scope: !1402, file: !2, line: 178, column: 1)
!1402 = distinct !DILexicalBlock(scope: !1391, file: !2, line: 178, column: 1)
!1403 = !DILocation(line: 178, column: 1, scope: !1404)
!1404 = distinct !DILexicalBlock(scope: !1405, file: !2, line: 178, column: 1)
!1405 = distinct !DILexicalBlock(scope: !1391, file: !2, line: 178, column: 1)
!1406 = !DILocation(line: 178, column: 1, scope: !1405)
!1407 = !DILocation(line: 178, column: 1, scope: !1408)
!1408 = distinct !DILexicalBlock(scope: !1404, file: !2, line: 178, column: 1)
!1409 = distinct !{!1409, !1406, !1406, !394, !395}
!1410 = !DILocation(line: 178, column: 1, scope: !1391)
!1411 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !2, file: !2, line: 179, type: !1412, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1414)
!1412 = !DISubroutineType(types: !1413)
!1413 = !{!207, !207, !1031, !207}
!1414 = !{!1415, !1416, !1417, !1418}
!1415 = !DILocalVariable(name: "fd", arg: 1, scope: !1411, file: !2, line: 179, type: !207)
!1416 = !DILocalVariable(name: "arr", arg: 2, scope: !1411, file: !2, line: 179, type: !1031)
!1417 = !DILocalVariable(name: "n", arg: 3, scope: !1411, file: !2, line: 179, type: !207)
!1418 = !DILocalVariable(name: "i", scope: !1411, file: !2, line: 179, type: !207)
!1419 = !DILocation(line: 0, scope: !1411)
!1420 = !DILocation(line: 179, column: 1, scope: !1421)
!1421 = distinct !DILexicalBlock(scope: !1422, file: !2, line: 179, column: 1)
!1422 = distinct !DILexicalBlock(scope: !1411, file: !2, line: 179, column: 1)
!1423 = !DILocation(line: 179, column: 1, scope: !1424)
!1424 = distinct !DILexicalBlock(scope: !1425, file: !2, line: 179, column: 1)
!1425 = distinct !DILexicalBlock(scope: !1411, file: !2, line: 179, column: 1)
!1426 = !DILocation(line: 179, column: 1, scope: !1425)
!1427 = !DILocation(line: 179, column: 1, scope: !1428)
!1428 = distinct !DILexicalBlock(scope: !1424, file: !2, line: 179, column: 1)
!1429 = distinct !{!1429, !1426, !1426, !394, !395}
!1430 = !DILocation(line: 179, column: 1, scope: !1411)
!1431 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !2, file: !2, line: 180, type: !1432, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1434)
!1432 = !DISubroutineType(types: !1433)
!1433 = !{!207, !207, !1062, !207}
!1434 = !{!1435, !1436, !1437, !1438}
!1435 = !DILocalVariable(name: "fd", arg: 1, scope: !1431, file: !2, line: 180, type: !207)
!1436 = !DILocalVariable(name: "arr", arg: 2, scope: !1431, file: !2, line: 180, type: !1062)
!1437 = !DILocalVariable(name: "n", arg: 3, scope: !1431, file: !2, line: 180, type: !207)
!1438 = !DILocalVariable(name: "i", scope: !1431, file: !2, line: 180, type: !207)
!1439 = !DILocation(line: 0, scope: !1431)
!1440 = !DILocation(line: 180, column: 1, scope: !1441)
!1441 = distinct !DILexicalBlock(scope: !1442, file: !2, line: 180, column: 1)
!1442 = distinct !DILexicalBlock(scope: !1431, file: !2, line: 180, column: 1)
!1443 = !DILocation(line: 180, column: 1, scope: !1444)
!1444 = distinct !DILexicalBlock(scope: !1445, file: !2, line: 180, column: 1)
!1445 = distinct !DILexicalBlock(scope: !1431, file: !2, line: 180, column: 1)
!1446 = !DILocation(line: 180, column: 1, scope: !1445)
!1447 = !DILocation(line: 180, column: 1, scope: !1448)
!1448 = distinct !DILexicalBlock(scope: !1444, file: !2, line: 180, column: 1)
!1449 = distinct !{!1449, !1446, !1446, !394, !395}
!1450 = !DILocation(line: 180, column: 1, scope: !1431)
!1451 = distinct !DISubprogram(name: "write_int8_t_array", scope: !2, file: !2, line: 181, type: !1452, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1454)
!1452 = !DISubroutineType(types: !1453)
!1453 = !{!207, !207, !1093, !207}
!1454 = !{!1455, !1456, !1457, !1458}
!1455 = !DILocalVariable(name: "fd", arg: 1, scope: !1451, file: !2, line: 181, type: !207)
!1456 = !DILocalVariable(name: "arr", arg: 2, scope: !1451, file: !2, line: 181, type: !1093)
!1457 = !DILocalVariable(name: "n", arg: 3, scope: !1451, file: !2, line: 181, type: !207)
!1458 = !DILocalVariable(name: "i", scope: !1451, file: !2, line: 181, type: !207)
!1459 = !DILocation(line: 0, scope: !1451)
!1460 = !DILocation(line: 181, column: 1, scope: !1461)
!1461 = distinct !DILexicalBlock(scope: !1462, file: !2, line: 181, column: 1)
!1462 = distinct !DILexicalBlock(scope: !1451, file: !2, line: 181, column: 1)
!1463 = !DILocation(line: 181, column: 1, scope: !1464)
!1464 = distinct !DILexicalBlock(scope: !1465, file: !2, line: 181, column: 1)
!1465 = distinct !DILexicalBlock(scope: !1451, file: !2, line: 181, column: 1)
!1466 = !DILocation(line: 181, column: 1, scope: !1465)
!1467 = !DILocation(line: 181, column: 1, scope: !1468)
!1468 = distinct !DILexicalBlock(scope: !1464, file: !2, line: 181, column: 1)
!1469 = distinct !{!1469, !1466, !1466, !394, !395}
!1470 = !DILocation(line: 181, column: 1, scope: !1451)
!1471 = distinct !DISubprogram(name: "write_int16_t_array", scope: !2, file: !2, line: 182, type: !1472, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1474)
!1472 = !DISubroutineType(types: !1473)
!1473 = !{!207, !207, !1122, !207}
!1474 = !{!1475, !1476, !1477, !1478}
!1475 = !DILocalVariable(name: "fd", arg: 1, scope: !1471, file: !2, line: 182, type: !207)
!1476 = !DILocalVariable(name: "arr", arg: 2, scope: !1471, file: !2, line: 182, type: !1122)
!1477 = !DILocalVariable(name: "n", arg: 3, scope: !1471, file: !2, line: 182, type: !207)
!1478 = !DILocalVariable(name: "i", scope: !1471, file: !2, line: 182, type: !207)
!1479 = !DILocation(line: 0, scope: !1471)
!1480 = !DILocation(line: 182, column: 1, scope: !1481)
!1481 = distinct !DILexicalBlock(scope: !1482, file: !2, line: 182, column: 1)
!1482 = distinct !DILexicalBlock(scope: !1471, file: !2, line: 182, column: 1)
!1483 = !DILocation(line: 182, column: 1, scope: !1484)
!1484 = distinct !DILexicalBlock(scope: !1485, file: !2, line: 182, column: 1)
!1485 = distinct !DILexicalBlock(scope: !1471, file: !2, line: 182, column: 1)
!1486 = !DILocation(line: 182, column: 1, scope: !1485)
!1487 = !DILocation(line: 182, column: 1, scope: !1488)
!1488 = distinct !DILexicalBlock(scope: !1484, file: !2, line: 182, column: 1)
!1489 = distinct !{!1489, !1486, !1486, !394, !395}
!1490 = !DILocation(line: 182, column: 1, scope: !1471)
!1491 = distinct !DISubprogram(name: "write_int32_t_array", scope: !2, file: !2, line: 183, type: !1492, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1494)
!1492 = !DISubroutineType(types: !1493)
!1493 = !{!207, !207, !1151, !207}
!1494 = !{!1495, !1496, !1497, !1498}
!1495 = !DILocalVariable(name: "fd", arg: 1, scope: !1491, file: !2, line: 183, type: !207)
!1496 = !DILocalVariable(name: "arr", arg: 2, scope: !1491, file: !2, line: 183, type: !1151)
!1497 = !DILocalVariable(name: "n", arg: 3, scope: !1491, file: !2, line: 183, type: !207)
!1498 = !DILocalVariable(name: "i", scope: !1491, file: !2, line: 183, type: !207)
!1499 = !DILocation(line: 0, scope: !1491)
!1500 = !DILocation(line: 183, column: 1, scope: !1501)
!1501 = distinct !DILexicalBlock(scope: !1502, file: !2, line: 183, column: 1)
!1502 = distinct !DILexicalBlock(scope: !1491, file: !2, line: 183, column: 1)
!1503 = !DILocation(line: 183, column: 1, scope: !1504)
!1504 = distinct !DILexicalBlock(scope: !1505, file: !2, line: 183, column: 1)
!1505 = distinct !DILexicalBlock(scope: !1491, file: !2, line: 183, column: 1)
!1506 = !DILocation(line: 183, column: 1, scope: !1505)
!1507 = !DILocation(line: 183, column: 1, scope: !1508)
!1508 = distinct !DILexicalBlock(scope: !1504, file: !2, line: 183, column: 1)
!1509 = distinct !{!1509, !1506, !1506, !394, !395}
!1510 = !DILocation(line: 183, column: 1, scope: !1491)
!1511 = distinct !DISubprogram(name: "write_int64_t_array", scope: !2, file: !2, line: 184, type: !1512, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1514)
!1512 = !DISubroutineType(types: !1513)
!1513 = !{!207, !207, !1180, !207}
!1514 = !{!1515, !1516, !1517, !1518}
!1515 = !DILocalVariable(name: "fd", arg: 1, scope: !1511, file: !2, line: 184, type: !207)
!1516 = !DILocalVariable(name: "arr", arg: 2, scope: !1511, file: !2, line: 184, type: !1180)
!1517 = !DILocalVariable(name: "n", arg: 3, scope: !1511, file: !2, line: 184, type: !207)
!1518 = !DILocalVariable(name: "i", scope: !1511, file: !2, line: 184, type: !207)
!1519 = !DILocation(line: 0, scope: !1511)
!1520 = !DILocation(line: 184, column: 1, scope: !1521)
!1521 = distinct !DILexicalBlock(scope: !1522, file: !2, line: 184, column: 1)
!1522 = distinct !DILexicalBlock(scope: !1511, file: !2, line: 184, column: 1)
!1523 = !DILocation(line: 184, column: 1, scope: !1524)
!1524 = distinct !DILexicalBlock(scope: !1525, file: !2, line: 184, column: 1)
!1525 = distinct !DILexicalBlock(scope: !1511, file: !2, line: 184, column: 1)
!1526 = !DILocation(line: 184, column: 1, scope: !1525)
!1527 = !DILocation(line: 184, column: 1, scope: !1528)
!1528 = distinct !DILexicalBlock(scope: !1524, file: !2, line: 184, column: 1)
!1529 = distinct !{!1529, !1526, !1526, !394, !395}
!1530 = !DILocation(line: 184, column: 1, scope: !1511)
!1531 = distinct !DISubprogram(name: "write_float_array", scope: !2, file: !2, line: 186, type: !1532, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !231, retainedNodes: !1534)
!1532 = !DISubroutineType(types: !1533)
!1533 = !{!207, !207, !1209, !207}
!1534 = !{!1535, !1536, !1537, !1538}
!1535 = !DILocalVariable(name: "fd", arg: 1, scope: !1531, file: !2, line: 186, type: !207)
!1536 = !DILocalVariable(name: "arr", arg: 2, scope: !1531, file: !2, line: 186, type: !1209)
!1537 = !DILocalVariable(name: "n", arg: 3, scope: !1531, file: !2, line: 186, type: !207)
!1538 = !DILocalVariable(name: "i", scope: !1531, file: !2, line: 186, type: !207)
!1539 = !DILocation(line: 0, scope: !1531)
!1540 = !DILocation(line: 186, column: 1, scope: !1541)
!1541 = distinct !DILexicalBlock(scope: !1542, file: !2, line: 186, column: 1)
!1542 = distinct !DILexicalBlock(scope: !1531, file: !2, line: 186, column: 1)
!1543 = !DILocation(line: 186, column: 1, scope: !1544)
!1544 = distinct !DILexicalBlock(scope: !1545, file: !2, line: 186, column: 1)
!1545 = distinct !DILexicalBlock(scope: !1531, file: !2, line: 186, column: 1)
!1546 = !DILocation(line: 186, column: 1, scope: !1545)
!1547 = !DILocation(line: 186, column: 1, scope: !1548)
!1548 = distinct !DILexicalBlock(scope: !1544, file: !2, line: 186, column: 1)
!1549 = distinct !{!1549, !1546, !1546, !394, !395}
!1550 = !DILocation(line: 186, column: 1, scope: !1531)
!1551 = !DILocation(line: 0, scope: !576)
!1552 = !DILocation(line: 187, column: 1, scope: !1553)
!1553 = distinct !DILexicalBlock(scope: !1554, file: !2, line: 187, column: 1)
!1554 = distinct !DILexicalBlock(scope: !576, file: !2, line: 187, column: 1)
!1555 = !DILocation(line: 187, column: 1, scope: !589)
!1556 = !DILocation(line: 187, column: 1, scope: !586)
!1557 = !DILocation(line: 187, column: 1, scope: !588)
!1558 = distinct !{!1558, !1556, !1556, !394, !395}
!1559 = !DILocation(line: 187, column: 1, scope: !576)
!1560 = !DILocation(line: 0, scope: !565)
!1561 = !DILocation(line: 190, column: 3, scope: !572)
!1562 = !DILocation(line: 191, column: 3, scope: !565)
!1563 = !DILocation(line: 192, column: 3, scope: !565)
!1564 = distinct !DISubprogram(name: "main", scope: !170, file: !170, line: 14, type: !1565, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !296, retainedNodes: !1567)
!1565 = !DISubroutineType(types: !1566)
!1566 = !{!207, !207, !938}
!1567 = !{!1568, !1569, !1570, !1571, !1572, !1573, !1574, !1575, !1576}
!1568 = !DILocalVariable(name: "argc", arg: 1, scope: !1564, file: !170, line: 14, type: !207)
!1569 = !DILocalVariable(name: "argv", arg: 2, scope: !1564, file: !170, line: 14, type: !938)
!1570 = !DILocalVariable(name: "in_file", scope: !1564, file: !170, line: 17, type: !233)
!1571 = !DILocalVariable(name: "check_file", scope: !1564, file: !170, line: 19, type: !233)
!1572 = !DILocalVariable(name: "in_fd", scope: !1564, file: !170, line: 34, type: !207)
!1573 = !DILocalVariable(name: "data", scope: !1564, file: !170, line: 35, type: !233)
!1574 = !DILocalVariable(name: "out_fd", scope: !1564, file: !170, line: 46, type: !207)
!1575 = !DILocalVariable(name: "check_fd", scope: !1564, file: !170, line: 55, type: !207)
!1576 = !DILocalVariable(name: "ref", scope: !1564, file: !170, line: 56, type: !233)
!1577 = !DILocation(line: 0, scope: !1564)
!1578 = !DILocation(line: 21, column: 3, scope: !1579)
!1579 = distinct !DILexicalBlock(scope: !1580, file: !170, line: 21, column: 3)
!1580 = distinct !DILexicalBlock(scope: !1564, file: !170, line: 21, column: 3)
!1581 = !DILocation(line: 26, column: 11, scope: !1582)
!1582 = distinct !DILexicalBlock(scope: !1564, file: !170, line: 26, column: 7)
!1583 = !DILocation(line: 26, column: 7, scope: !1564)
!1584 = !DILocation(line: 27, column: 15, scope: !1582)
!1585 = !DILocation(line: 29, column: 11, scope: !1586)
!1586 = distinct !DILexicalBlock(scope: !1564, file: !170, line: 29, column: 7)
!1587 = !DILocation(line: 29, column: 7, scope: !1564)
!1588 = !DILocation(line: 30, column: 18, scope: !1586)
!1589 = !DILocation(line: 30, column: 5, scope: !1586)
!1590 = !DILocation(line: 36, column: 17, scope: !1564)
!1591 = !DILocation(line: 36, column: 10, scope: !1564)
!1592 = !DILocation(line: 37, column: 3, scope: !1593)
!1593 = distinct !DILexicalBlock(scope: !1594, file: !170, line: 37, column: 3)
!1594 = distinct !DILexicalBlock(scope: !1564, file: !170, line: 37, column: 3)
!1595 = !DILocation(line: 38, column: 11, scope: !1564)
!1596 = !DILocation(line: 39, column: 3, scope: !1597)
!1597 = distinct !DILexicalBlock(scope: !1598, file: !170, line: 39, column: 3)
!1598 = distinct !DILexicalBlock(scope: !1564, file: !170, line: 39, column: 3)
!1599 = !DILocation(line: 40, column: 3, scope: !1564)
!1600 = !DILocation(line: 0, scope: !401, inlinedAt: !1601)
!1601 = distinct !DILocation(line: 43, column: 3, scope: !1564)
!1602 = !DILocation(line: 10, column: 25, scope: !401, inlinedAt: !1601)
!1603 = !DILocation(line: 10, column: 36, scope: !401, inlinedAt: !1601)
!1604 = !DILocation(line: 10, column: 53, scope: !401, inlinedAt: !1601)
!1605 = !DILocation(line: 0, scope: !329, inlinedAt: !1606)
!1606 = distinct !DILocation(line: 10, column: 3, scope: !401, inlinedAt: !1601)
!1607 = !DILocation(line: 8, column: 5, scope: !329, inlinedAt: !1606)
!1608 = !DILocation(line: 8, column: 11, scope: !348, inlinedAt: !1606)
!1609 = !DILocation(line: 9, column: 15, scope: !353, inlinedAt: !1606)
!1610 = !DILocation(line: 10, column: 17, scope: !355, inlinedAt: !1606)
!1611 = !DILocation(line: 11, column: 24, scope: !355, inlinedAt: !1606)
!1612 = !DILocation(line: 13, column: 20, scope: !355, inlinedAt: !1606)
!1613 = !DILocation(line: 13, column: 33, scope: !355, inlinedAt: !1606)
!1614 = !DILocation(line: 13, column: 31, scope: !355, inlinedAt: !1606)
!1615 = !DILocation(line: 14, column: 36, scope: !355, inlinedAt: !1606)
!1616 = !DILocation(line: 14, column: 23, scope: !355, inlinedAt: !1606)
!1617 = !DILocation(line: 15, column: 24, scope: !355, inlinedAt: !1606)
!1618 = !DILocation(line: 17, column: 20, scope: !355, inlinedAt: !1606)
!1619 = !DILocation(line: 17, column: 32, scope: !355, inlinedAt: !1606)
!1620 = !DILocation(line: 17, column: 30, scope: !355, inlinedAt: !1606)
!1621 = !DILocation(line: 18, column: 34, scope: !355, inlinedAt: !1606)
!1622 = !DILocation(line: 18, column: 22, scope: !355, inlinedAt: !1606)
!1623 = !DILocation(line: 19, column: 23, scope: !355, inlinedAt: !1606)
!1624 = !DILocation(line: 21, column: 30, scope: !355, inlinedAt: !1606)
!1625 = !DILocation(line: 21, column: 37, scope: !355, inlinedAt: !1606)
!1626 = !DILocation(line: 22, column: 16, scope: !377, inlinedAt: !1606)
!1627 = !DILocation(line: 22, column: 16, scope: !355, inlinedAt: !1606)
!1628 = !DILocation(line: 23, column: 24, scope: !380, inlinedAt: !1606)
!1629 = !DILocation(line: 23, column: 47, scope: !380, inlinedAt: !1606)
!1630 = !DILocation(line: 24, column: 21, scope: !380, inlinedAt: !1606)
!1631 = !DILocation(line: 24, column: 44, scope: !380, inlinedAt: !1606)
!1632 = !DILocation(line: 23, column: 57, scope: !380, inlinedAt: !1606)
!1633 = !DILocation(line: 26, column: 40, scope: !380, inlinedAt: !1606)
!1634 = !DILocation(line: 25, column: 58, scope: !380, inlinedAt: !1606)
!1635 = !DILocation(line: 25, column: 26, scope: !380, inlinedAt: !1606)
!1636 = !DILocation(line: 27, column: 27, scope: !380, inlinedAt: !1606)
!1637 = !DILocation(line: 28, column: 13, scope: !380, inlinedAt: !1606)
!1638 = !DILocation(line: 9, column: 46, scope: !356, inlinedAt: !1606)
!1639 = !DILocation(line: 9, column: 32, scope: !356, inlinedAt: !1606)
!1640 = distinct !{!1640, !1609, !1641, !394, !395}
!1641 = !DILocation(line: 29, column: 9, scope: !353, inlinedAt: !1606)
!1642 = !DILocation(line: 8, column: 43, scope: !347, inlinedAt: !1606)
!1643 = !DILocation(line: 8, column: 52, scope: !347, inlinedAt: !1606)
!1644 = distinct !{!1644, !1608, !1645, !394, !395}
!1645 = !DILocation(line: 30, column: 5, scope: !348, inlinedAt: !1606)
!1646 = !DILocation(line: 47, column: 12, scope: !1564)
!1647 = !DILocation(line: 48, column: 3, scope: !1648)
!1648 = distinct !DILexicalBlock(scope: !1649, file: !170, line: 48, column: 3)
!1649 = distinct !DILexicalBlock(scope: !1564, file: !170, line: 48, column: 3)
!1650 = !DILocation(line: 0, scope: !674, inlinedAt: !1651)
!1651 = distinct !DILocation(line: 49, column: 3, scope: !1564)
!1652 = !DILocation(line: 0, scope: !565, inlinedAt: !1653)
!1653 = distinct !DILocation(line: 86, column: 3, scope: !674, inlinedAt: !1651)
!1654 = !DILocation(line: 190, column: 3, scope: !572, inlinedAt: !1653)
!1655 = !DILocation(line: 191, column: 3, scope: !565, inlinedAt: !1653)
!1656 = !DILocation(line: 0, scope: !576, inlinedAt: !1657)
!1657 = distinct !DILocation(line: 87, column: 3, scope: !674, inlinedAt: !1651)
!1658 = !DILocation(line: 187, column: 1, scope: !586, inlinedAt: !1657)
!1659 = !DILocation(line: 187, column: 1, scope: !588, inlinedAt: !1657)
!1660 = !DILocation(line: 187, column: 1, scope: !589, inlinedAt: !1657)
!1661 = distinct !{!1661, !1658, !1658, !394, !395}
!1662 = !DILocation(line: 0, scope: !565, inlinedAt: !1663)
!1663 = distinct !DILocation(line: 89, column: 3, scope: !674, inlinedAt: !1651)
!1664 = !DILocation(line: 191, column: 3, scope: !565, inlinedAt: !1663)
!1665 = !DILocation(line: 0, scope: !576, inlinedAt: !1666)
!1666 = distinct !DILocation(line: 90, column: 3, scope: !674, inlinedAt: !1651)
!1667 = !DILocation(line: 187, column: 1, scope: !586, inlinedAt: !1666)
!1668 = !DILocation(line: 187, column: 1, scope: !588, inlinedAt: !1666)
!1669 = !DILocation(line: 187, column: 1, scope: !589, inlinedAt: !1666)
!1670 = distinct !{!1670, !1667, !1667, !394, !395}
!1671 = !DILocation(line: 50, column: 3, scope: !1564)
!1672 = !DILocation(line: 57, column: 16, scope: !1564)
!1673 = !DILocation(line: 57, column: 9, scope: !1564)
!1674 = !DILocation(line: 58, column: 3, scope: !1675)
!1675 = distinct !DILexicalBlock(scope: !1676, file: !170, line: 58, column: 3)
!1676 = distinct !DILexicalBlock(scope: !1564, file: !170, line: 58, column: 3)
!1677 = !DILocation(line: 59, column: 14, scope: !1564)
!1678 = !DILocation(line: 60, column: 3, scope: !1679)
!1679 = distinct !DILexicalBlock(scope: !1680, file: !170, line: 60, column: 3)
!1680 = distinct !DILexicalBlock(scope: !1564, file: !170, line: 60, column: 3)
!1681 = !DILocation(line: 61, column: 3, scope: !1564)
!1682 = !DILocation(line: 0, scope: !701, inlinedAt: !1683)
!1683 = distinct !DILocation(line: 66, column: 8, scope: !1684)
!1684 = distinct !DILexicalBlock(scope: !1564, file: !170, line: 66, column: 7)
!1685 = !DILocation(line: 100, column: 3, scope: !715, inlinedAt: !1683)
!1686 = !DILocation(line: 101, column: 17, scope: !717, inlinedAt: !1683)
!1687 = !DILocation(line: 101, column: 33, scope: !717, inlinedAt: !1683)
!1688 = !DILocation(line: 101, column: 31, scope: !717, inlinedAt: !1683)
!1689 = !DILocation(line: 102, column: 16, scope: !717, inlinedAt: !1683)
!1690 = !DILocation(line: 102, column: 31, scope: !717, inlinedAt: !1683)
!1691 = !DILocation(line: 102, column: 29, scope: !717, inlinedAt: !1683)
!1692 = !DILocation(line: 103, column: 40, scope: !717, inlinedAt: !1683)
!1693 = !DILocation(line: 106, column: 39, scope: !717, inlinedAt: !1683)
!1694 = !DILocation(line: 106, column: 16, scope: !717, inlinedAt: !1683)
!1695 = !DILocation(line: 100, column: 25, scope: !718, inlinedAt: !1683)
!1696 = !DILocation(line: 100, column: 13, scope: !718, inlinedAt: !1683)
!1697 = distinct !{!1697, !1685, !1698, !394, !395}
!1698 = !DILocation(line: 109, column: 3, scope: !715, inlinedAt: !1683)
!1699 = !DILocation(line: 112, column: 10, scope: !701, inlinedAt: !1683)
!1700 = !DILocation(line: 66, column: 7, scope: !1564)
!1701 = !DILocation(line: 67, column: 13, scope: !1702)
!1702 = distinct !DILexicalBlock(scope: !1684, file: !170, line: 66, column: 32)
!1703 = !DILocation(line: 67, column: 5, scope: !1702)
!1704 = !DILocation(line: 68, column: 5, scope: !1702)
!1705 = !DILocation(line: 71, column: 3, scope: !1564)
!1706 = !DILocation(line: 72, column: 3, scope: !1564)
!1707 = !DILocation(line: 74, column: 3, scope: !1564)
!1708 = !DILocation(line: 75, column: 3, scope: !1564)
!1709 = !DILocation(line: 76, column: 1, scope: !1564)
!1710 = !DISubprogram(name: "open", scope: !1711, file: !1711, line: 209, type: !1712, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1711 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1712 = !DISubroutineType(types: !1713)
!1713 = !{!207, !819, !207, null}
