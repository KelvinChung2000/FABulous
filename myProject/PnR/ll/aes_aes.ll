; ModuleID = 'aes/aes/aes_opt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-linux-gnu"

%struct.aes256_context = type { [32 x i8], [32 x i8], [32 x i8] }
%struct.stat = type { i64, i64, i32, i32, i32, i32, i64, i64, i64, i32, i32, i64, %struct.timespec, %struct.timespec, %struct.timespec, [2 x i32] }
%struct.timespec = type { i64, i64 }

@sbox = dso_local local_unnamed_addr constant [256 x i8] c"c|w{\F2ko\C50\01g+\FE\D7\ABv\CA\82\C9}\FAYG\F0\AD\D4\A2\AF\9C\A4r\C0\B7\FD\93&6?\F7\CC4\A5\E5\F1q\D81\15\04\C7#\C3\18\96\05\9A\07\12\80\E2\EB'\B2u\09\83,\1A\1BnZ\A0R;\D6\B3)\E3/\84S\D1\00\ED \FC\B1[j\CB\BE9JLX\CF\D0\EF\AA\FBCM3\85E\F9\02\7FP<\9F\A8Q\A3@\8F\92\9D8\F5\BC\B6\DA!\10\FF\F3\D2\CD\0C\13\EC_\97D\17\C4\A7~=d]\19s`\81O\DC\22*\90\88F\EE\B8\14\DE^\0B\DB\E02:\0AI\06$\\\C2\D3\ACb\91\95\E4y\E7\C87m\8D\D5N\A9lV\F4\EAez\AE\08\BAx%.\1C\A6\B4\C6\E8\DDt\1FK\BD\8B\8Ap>\B5fH\03\F6\0Ea5W\B9\86\C1\1D\9E\E1\F8\98\11i\D9\8E\94\9B\1E\87\E9\CEU(\DF\8C\A1\89\0D\BF\E6BhA\99-\0F\B0T\BB\16", align 1, !dbg !0
@.str.1 = private unnamed_addr constant [34 x i8] c"fd>1 && \22Invalid file descriptor\22\00", align 1, !dbg !14
@.str.2 = private unnamed_addr constant [23 x i8] c"../../common/support.c\00", align 1, !dbg !21
@__PRETTY_FUNCTION__.readfile = private unnamed_addr constant [20 x i8] c"char *readfile(int)\00", align 1, !dbg !26
@.str.4 = private unnamed_addr constant [51 x i8] c"0==fstat(fd, &s) && \22Couldn't determine file size\22\00", align 1, !dbg !32
@.str.6 = private unnamed_addr constant [25 x i8] c"len>0 && \22File is empty\22\00", align 1, !dbg !37
@.str.8 = private unnamed_addr constant [29 x i8] c"status>=0 && \22read() failed\22\00", align 1, !dbg !42
@.str.10 = private unnamed_addr constant [33 x i8] c"n>=0 && \22Invalid section number\22\00", align 1, !dbg !47
@__PRETTY_FUNCTION__.find_section_start = private unnamed_addr constant [38 x i8] c"char *find_section_start(char *, int)\00", align 1, !dbg !52
@.str.12 = private unnamed_addr constant [34 x i8] c"s!=NULL && \22Invalid input string\22\00", align 1, !dbg !57
@__PRETTY_FUNCTION__.parse_string = private unnamed_addr constant [38 x i8] c"int parse_string(char *, char *, int)\00", align 1, !dbg !59
@__PRETTY_FUNCTION__.parse_uint8_t_array = private unnamed_addr constant [48 x i8] c"int parse_uint8_t_array(char *, uint8_t *, int)\00", align 1, !dbg !61
@.str.13 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1, !dbg !66
@.str.14 = private unnamed_addr constant [35 x i8] c"Invalid input: line %d of section\0A\00", align 1, !dbg !71
@__PRETTY_FUNCTION__.parse_uint16_t_array = private unnamed_addr constant [50 x i8] c"int parse_uint16_t_array(char *, uint16_t *, int)\00", align 1, !dbg !76
@__PRETTY_FUNCTION__.parse_uint32_t_array = private unnamed_addr constant [50 x i8] c"int parse_uint32_t_array(char *, uint32_t *, int)\00", align 1, !dbg !81
@__PRETTY_FUNCTION__.parse_uint64_t_array = private unnamed_addr constant [50 x i8] c"int parse_uint64_t_array(char *, uint64_t *, int)\00", align 1, !dbg !83
@__PRETTY_FUNCTION__.parse_int8_t_array = private unnamed_addr constant [46 x i8] c"int parse_int8_t_array(char *, int8_t *, int)\00", align 1, !dbg !85
@__PRETTY_FUNCTION__.parse_int16_t_array = private unnamed_addr constant [48 x i8] c"int parse_int16_t_array(char *, int16_t *, int)\00", align 1, !dbg !90
@__PRETTY_FUNCTION__.parse_int32_t_array = private unnamed_addr constant [48 x i8] c"int parse_int32_t_array(char *, int32_t *, int)\00", align 1, !dbg !92
@__PRETTY_FUNCTION__.parse_int64_t_array = private unnamed_addr constant [48 x i8] c"int parse_int64_t_array(char *, int64_t *, int)\00", align 1, !dbg !94
@__PRETTY_FUNCTION__.parse_float_array = private unnamed_addr constant [44 x i8] c"int parse_float_array(char *, float *, int)\00", align 1, !dbg !96
@__PRETTY_FUNCTION__.parse_double_array = private unnamed_addr constant [46 x i8] c"int parse_double_array(char *, double *, int)\00", align 1, !dbg !101
@__PRETTY_FUNCTION__.write_string = private unnamed_addr constant [35 x i8] c"int write_string(int, char *, int)\00", align 1, !dbg !103
@.str.16 = private unnamed_addr constant [28 x i8] c"status>=0 && \22Write failed\22\00", align 1, !dbg !106
@__PRETTY_FUNCTION__.write_uint8_t_array = private unnamed_addr constant [45 x i8] c"int write_uint8_t_array(int, uint8_t *, int)\00", align 1, !dbg !111
@.str.17 = private unnamed_addr constant [4 x i8] c"%u\0A\00", align 1, !dbg !116
@__PRETTY_FUNCTION__.write_uint16_t_array = private unnamed_addr constant [47 x i8] c"int write_uint16_t_array(int, uint16_t *, int)\00", align 1, !dbg !121
@__PRETTY_FUNCTION__.write_uint32_t_array = private unnamed_addr constant [47 x i8] c"int write_uint32_t_array(int, uint32_t *, int)\00", align 1, !dbg !126
@__PRETTY_FUNCTION__.write_uint64_t_array = private unnamed_addr constant [47 x i8] c"int write_uint64_t_array(int, uint64_t *, int)\00", align 1, !dbg !128
@.str.18 = private unnamed_addr constant [5 x i8] c"%lu\0A\00", align 1, !dbg !130
@__PRETTY_FUNCTION__.write_int8_t_array = private unnamed_addr constant [43 x i8] c"int write_int8_t_array(int, int8_t *, int)\00", align 1, !dbg !135
@.str.19 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1, !dbg !140
@__PRETTY_FUNCTION__.write_int16_t_array = private unnamed_addr constant [45 x i8] c"int write_int16_t_array(int, int16_t *, int)\00", align 1, !dbg !142
@__PRETTY_FUNCTION__.write_int32_t_array = private unnamed_addr constant [45 x i8] c"int write_int32_t_array(int, int32_t *, int)\00", align 1, !dbg !144
@__PRETTY_FUNCTION__.write_int64_t_array = private unnamed_addr constant [45 x i8] c"int write_int64_t_array(int, int64_t *, int)\00", align 1, !dbg !146
@.str.20 = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1, !dbg !148
@__PRETTY_FUNCTION__.write_float_array = private unnamed_addr constant [41 x i8] c"int write_float_array(int, float *, int)\00", align 1, !dbg !150
@.str.21 = private unnamed_addr constant [7 x i8] c"%.16f\0A\00", align 1, !dbg !155
@__PRETTY_FUNCTION__.write_double_array = private unnamed_addr constant [43 x i8] c"int write_double_array(int, double *, int)\00", align 1, !dbg !160
@__PRETTY_FUNCTION__.write_section_header = private unnamed_addr constant [30 x i8] c"int write_section_header(int)\00", align 1, !dbg !162
@.str.22 = private unnamed_addr constant [6 x i8] c"%%%%\0A\00", align 1, !dbg !167
@.str.24 = private unnamed_addr constant [90 x i8] c"buffered<SUFFICIENT_SPRINTF_SPACE && \22Overran fd_printf buffer---output possibly corrupt\22\00", align 1, !dbg !172
@__PRETTY_FUNCTION__.fd_printf = private unnamed_addr constant [38 x i8] c"int fd_printf(int, const char *, ...)\00", align 1, !dbg !177
@.str.26 = private unnamed_addr constant [50 x i8] c"written==buffered && \22Wrote more data than given\22\00", align 1, !dbg !179
@.str.1.11 = private unnamed_addr constant [57 x i8] c"argc<4 && \22Usage: ./benchmark <input_file> <check_file>\22\00", align 1, !dbg !182
@.str.2.12 = private unnamed_addr constant [23 x i8] c"../../common/harness.c\00", align 1, !dbg !188
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1, !dbg !190
@.str.3 = private unnamed_addr constant [11 x i8] c"input.data\00", align 1, !dbg !193
@.str.4.13 = private unnamed_addr constant [11 x i8] c"check.data\00", align 1, !dbg !198
@INPUT_SIZE = dso_local local_unnamed_addr global i32 144, align 4, !dbg !200
@.str.6.14 = private unnamed_addr constant [30 x i8] c"data!=NULL && \22Out of memory\22\00", align 1, !dbg !226
@.str.8.15 = private unnamed_addr constant [43 x i8] c"in_fd>0 && \22Couldn't open input data file\22\00", align 1, !dbg !229
@.str.9 = private unnamed_addr constant [12 x i8] c"output.data\00", align 1, !dbg !232
@.str.11 = private unnamed_addr constant [45 x i8] c"out_fd>0 && \22Couldn't open output data file\22\00", align 1, !dbg !237
@.str.12.16 = private unnamed_addr constant [29 x i8] c"ref!=NULL && \22Out of memory\22\00", align 1, !dbg !240
@.str.14.17 = private unnamed_addr constant [46 x i8] c"check_fd>0 && \22Couldn't open check data file\22\00", align 1, !dbg !242
@stderr = external local_unnamed_addr global ptr, align 8
@.str.15 = private unnamed_addr constant [33 x i8] c"Benchmark results are incorrect\0A\00", align 1, !dbg !245
@str = private unnamed_addr constant [9 x i8] c"Success.\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable
define dso_local noundef zeroext i8 @rj_xtime(i8 noundef zeroext %x) local_unnamed_addr #0 !dbg !341 {
entry.split:
    #dbg_value(i8 %x, !345, !DIExpression(), !346)
  %shl = shl i8 %x, 1, !dbg !347
  %xor = xor i8 %shl, 27, !dbg !347
  %tobool.not7 = icmp slt i8 %x, 0, !dbg !347
  %cond = select i1 %tobool.not7, i8 %xor, i8 %shl, !dbg !347
  ret i8 %cond, !dbg !348
}

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @aes(ptr nocapture noundef %ctx, ptr nocapture noundef readonly %k, ptr nocapture noundef %buf) local_unnamed_addr #1 !dbg !349 {
entry.split:
  %rcon = alloca i8, align 1, !DIAssignID !369
    #dbg_assign(i1 undef, !364, !DIExpression(), !369, ptr %rcon, !DIExpression(), !370)
    #dbg_value(ptr %ctx, !361, !DIExpression(), !370)
    #dbg_value(ptr %k, !362, !DIExpression(), !370)
    #dbg_value(ptr %buf, !363, !DIExpression(), !370)
  %polly.indvar_next24.reg2mem = alloca i64, align 8
  %polly.indvar_next.reg2mem = alloca i64, align 8
  %indvar.next.reg2mem = alloca i1, align 1
  %inc27.reg2mem = alloca i8, align 1
  %indvars.iv.next.i81.reg2mem = alloca i64, align 8
  %indvars.iv.next.i75.reg2mem = alloca i64, align 8
  %indvars.iv.next.i72.reg2mem = alloca i64, align 8
  %indvars.iv.next.i60.reg2mem = alloca i64, align 8
  %i.2118.reg2mem = alloca i8, align 1
  %indvar.reg2mem = alloca i1, align 1
  %.not35.reg2mem = alloca i1, align 1
  %scevgep26.reg2mem = alloca ptr, align 8
  %arrayidx21.reg2mem = alloca ptr, align 8
  %arrayidx21.i.reg2mem = alloca ptr, align 8
  %arrayidx20.i.reg2mem = alloca ptr, align 8
  %arrayidx17.i.reg2mem = alloca ptr, align 8
  %arrayidx15.i.reg2mem = alloca ptr, align 8
  %arrayidx13.i66.reg2mem = alloca ptr, align 8
  %arrayidx12.i.reg2mem = alloca ptr, align 8
  %arrayidx9.i65.reg2mem = alloca ptr, align 8
  %arrayidx8.i.reg2mem = alloca ptr, align 8
  %arrayidx5.i.reg2mem = alloca ptr, align 8
  %arrayidx3.i.reg2mem = alloca ptr, align 8
  %arrayidx1.i.reg2mem = alloca ptr, align 8
  %arrayidx.i64.reg2mem = alloca ptr, align 8
  %indvars.iv.next.i.reg2mem = alloca i64, align 8
  %enckey10.reg2mem = alloca ptr, align 8
  %dec.reg2mem = alloca i8, align 1
  %indvars.iv.next.reg2mem = alloca i64, align 8
  %deckey8.reg2mem = alloca ptr, align 8
  %polly.indvar23.reg2mem = alloca i64, align 8
  %polly.indvar.reg2mem = alloca i64, align 8
  %indvars.iv.i108.reg2mem = alloca i64, align 8
  %indvars.iv.i88.reg2mem = alloca i64, align 8
  %indvars.iv.i80.reg2mem = alloca i64, align 8
  %indvars.iv.i74.reg2mem = alloca i64, align 8
  %indvars.iv.i67.reg2mem = alloca i64, align 8
  %indvars.iv.i59.reg2mem = alloca i64, align 8
  %i.2118.reg2mem117 = alloca i8, align 1
  %indvar.reg2mem119 = alloca i1, align 1
  %indvars.iv.i.reg2mem = alloca i64, align 8
  %dec117.reg2mem = alloca i8, align 1
  %indvars.iv.reg2mem = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 1, ptr nonnull %rcon) #21, !dbg !371
  store i8 1, ptr %rcon, align 1, !dbg !372, !tbaa !373, !DIAssignID !376
    #dbg_assign(i8 1, !364, !DIExpression(), !376, ptr %rcon, !DIExpression(), !370)
    #dbg_label(!366, !377)
    #dbg_value(i8 0, !365, !DIExpression(), !370)
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !378

for.cond6.preheader:                              ; preds = %for.body
    #dbg_value(i8 7, !365, !DIExpression(), !370)
  %deckey8 = getelementptr inbounds i8, ptr %ctx, i64 64
  store ptr %deckey8, ptr %deckey8.reg2mem, align 8
  store i8 7, ptr %dec117.reg2mem, align 1
  br label %for.body7, !dbg !380

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !365, !DIExpression(), !370)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %k, i64 %indvars.iv.reg2mem.0.load, !dbg !382
  %0 = load i8, ptr %arrayidx, align 1, !dbg !382, !tbaa !373
  %arrayidx3 = getelementptr inbounds %struct.aes256_context, ptr %ctx, i64 0, i32 2, i64 %indvars.iv.reg2mem.0.load, !dbg !385
  store i8 %0, ptr %arrayidx3, align 1, !dbg !386, !tbaa !373
  %arrayidx5 = getelementptr inbounds %struct.aes256_context, ptr %ctx, i64 0, i32 1, i64 %indvars.iv.reg2mem.0.load, !dbg !387
  store i8 %0, ptr %arrayidx5, align 1, !dbg !388, !tbaa !373
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !389
    #dbg_value(i64 %indvars.iv.next, !365, !DIExpression(), !370)
  store i64 %indvars.iv.next, ptr %indvars.iv.next.reg2mem, align 8
  %exitcond.not = icmp eq i64 %indvars.iv.next, 32, !dbg !390
  br i1 %exitcond.not, label %for.cond6.preheader, label %for.body.for.body_crit_edge, !dbg !378, !llvm.loop !391

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !378

for.body7:                                        ; preds = %for.body7.for.body7_crit_edge, %for.cond6.preheader
  %dec117.reg2mem.0.load = load i8, ptr %dec117.reg2mem, align 1
  call fastcc void @aes_expandEncKey(ptr noundef nonnull %deckey8, ptr noundef nonnull %rcon), !dbg !395
    #dbg_value(i8 %dec117.reg2mem.0.load, !365, !DIExpression(), !370)
  %dec = add nsw i8 %dec117.reg2mem.0.load, -1, !dbg !398
    #dbg_value(i8 %dec, !365, !DIExpression(), !370)
  store i8 %dec, ptr %dec.reg2mem, align 1
  %tobool.not = icmp eq i8 %dec, 0, !dbg !380
  br i1 %tobool.not, label %for.end9, label %for.body7.for.body7_crit_edge, !dbg !380, !llvm.loop !399

for.body7.for.body7_crit_edge:                    ; preds = %for.body7
  store i8 %dec, ptr %dec117.reg2mem, align 1
  br label %for.body7, !dbg !380

for.end9:                                         ; preds = %for.body7
  %enckey10 = getelementptr inbounds i8, ptr %ctx, i64 32, !dbg !401
    #dbg_value(ptr %buf, !402, !DIExpression(), !411)
    #dbg_value(ptr %enckey10, !407, !DIExpression(), !411)
    #dbg_value(ptr %ctx, !408, !DIExpression(), !411)
    #dbg_value(i8 16, !409, !DIExpression(), !411)
    #dbg_label(!410, !413)
    #dbg_value(i8 16, !409, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !411)
  store ptr %enckey10, ptr %enckey10.reg2mem, align 8
  store i64 16, ptr %indvars.iv.i.reg2mem, align 8
  br label %while.body.i, !dbg !414

while.body.i:                                     ; preds = %while.body.i.while.body.i_crit_edge, %for.end9
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !409, !DIExpression(), !411)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %indvars.iv.next.i = add nsw i64 %indvars.iv.i.reg2mem.0.load, -1, !dbg !415
    #dbg_value(i64 %indvars.iv.next.i, !409, !DIExpression(), !411)
  store i64 %indvars.iv.next.i, ptr %indvars.iv.next.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i8, ptr %enckey10, i64 %indvars.iv.next.i, !dbg !416
  %1 = load i8, ptr %arrayidx.i, align 1, !dbg !416, !tbaa !373
  %arrayidx2.i = getelementptr inbounds i8, ptr %ctx, i64 %indvars.iv.next.i, !dbg !417
  store i8 %1, ptr %arrayidx2.i, align 1, !dbg !418, !tbaa !373
  %arrayidx4.i = getelementptr inbounds i8, ptr %buf, i64 %indvars.iv.next.i, !dbg !419
  %2 = load i8, ptr %arrayidx4.i, align 1, !dbg !420, !tbaa !373
  %xor21.i = xor i8 %2, %1, !dbg !420
  store i8 %xor21.i, ptr %arrayidx4.i, align 1, !dbg !420, !tbaa !373
  %add.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 15, !dbg !421
  %arrayidx9.i = getelementptr inbounds i8, ptr %enckey10, i64 %add.i, !dbg !422
  %3 = load i8, ptr %arrayidx9.i, align 1, !dbg !422, !tbaa !373
  %arrayidx13.i = getelementptr inbounds i8, ptr %ctx, i64 %add.i, !dbg !423
  store i8 %3, ptr %arrayidx13.i, align 1, !dbg !424, !tbaa !373
    #dbg_value(i64 %indvars.iv.next.i, !409, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !411)
  %tobool.not.i = icmp eq i64 %indvars.iv.next.i, 0, !dbg !414
  br i1 %tobool.not.i, label %aes_addRoundKey_cpy.exit, label %while.body.i.while.body.i_crit_edge, !dbg !414, !llvm.loop !425

while.body.i.while.body.i_crit_edge:              ; preds = %while.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %while.body.i, !dbg !414

aes_addRoundKey_cpy.exit:                         ; preds = %while.body.i
    #dbg_label(!368, !427)
    #dbg_value(i8 1, !365, !DIExpression(), !370)
  store i8 1, ptr %rcon, align 1, !dbg !428, !tbaa !373, !DIAssignID !430
    #dbg_assign(i8 1, !364, !DIExpression(), !430, ptr %rcon, !DIExpression(), !370)
  %arrayidx.i64 = getelementptr i8, ptr %buf, i64 1
  store ptr %arrayidx.i64, ptr %arrayidx.i64.reg2mem, align 8
  %arrayidx1.i = getelementptr inbounds i8, ptr %buf, i64 5
  store ptr %arrayidx1.i, ptr %arrayidx1.i.reg2mem, align 8
  %arrayidx3.i = getelementptr inbounds i8, ptr %buf, i64 9
  store ptr %arrayidx3.i, ptr %arrayidx3.i.reg2mem, align 8
  %arrayidx5.i = getelementptr inbounds i8, ptr %buf, i64 13
  store ptr %arrayidx5.i, ptr %arrayidx5.i.reg2mem, align 8
  %arrayidx8.i = getelementptr inbounds i8, ptr %buf, i64 10
  store ptr %arrayidx8.i, ptr %arrayidx8.i.reg2mem, align 8
  %arrayidx9.i65 = getelementptr i8, ptr %buf, i64 2
  store ptr %arrayidx9.i65, ptr %arrayidx9.i65.reg2mem, align 8
  %arrayidx12.i = getelementptr i8, ptr %buf, i64 3
  store ptr %arrayidx12.i, ptr %arrayidx12.i.reg2mem, align 8
  %arrayidx13.i66 = getelementptr i8, ptr %buf, i64 15
  store ptr %arrayidx13.i66, ptr %arrayidx13.i66.reg2mem, align 8
  %arrayidx15.i = getelementptr inbounds i8, ptr %buf, i64 11
  store ptr %arrayidx15.i, ptr %arrayidx15.i.reg2mem, align 8
  %arrayidx17.i = getelementptr inbounds i8, ptr %buf, i64 7
  store ptr %arrayidx17.i, ptr %arrayidx17.i.reg2mem, align 8
  %arrayidx20.i = getelementptr inbounds i8, ptr %buf, i64 14
  store ptr %arrayidx20.i, ptr %arrayidx20.i.reg2mem, align 8
  %arrayidx21.i = getelementptr inbounds i8, ptr %buf, i64 6
    #dbg_value(ptr %buf, !431, !DIExpression(), !438)
    #dbg_value(ptr %buf, !431, !DIExpression(), !442)
    #dbg_value(i8 16, !436, !DIExpression(), !438)
    #dbg_value(i8 16, !436, !DIExpression(), !442)
    #dbg_label(!437, !444)
    #dbg_label(!437, !445)
    #dbg_value(i8 16, !436, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !438)
    #dbg_value(i8 16, !436, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !442)
  store ptr %arrayidx21.i, ptr %arrayidx21.i.reg2mem, align 8
  %arrayidx21 = getelementptr i8, ptr %ctx, i64 16
  store ptr %arrayidx21, ptr %arrayidx21.reg2mem, align 8
  %scevgep26 = getelementptr i8, ptr %ctx, i64 31, !dbg !446
  store ptr %scevgep26, ptr %scevgep26.reg2mem, align 8
  %4 = icmp ugt ptr %enckey10, %buf
  %5 = icmp ugt ptr %buf, %ctx
  %.not35 = and i1 %4, %5
  store i1 %.not35, ptr %.not35.reg2mem, align 1
  store i8 1, ptr %i.2118.reg2mem117, align 1
  store i1 false, ptr %indvar.reg2mem119, align 1
  br label %while.body.i58.preheader, !dbg !446

while.body.i58.preheader:                         ; preds = %for.inc26.while.body.i58.preheader_crit_edge, %aes_addRoundKey_cpy.exit
    #dbg_value(i8 %i.2118.reg2mem117.0.load, !365, !DIExpression(), !370)
  %indvar.reg2mem119.0.indvar.reload120 = load i1, ptr %indvar.reg2mem119, align 1
  %i.2118.reg2mem117.0.load = load i8, ptr %i.2118.reg2mem117, align 1
  store i1 %indvar.reg2mem119.0.indvar.reload120, ptr %indvar.reg2mem, align 1
  store i8 %i.2118.reg2mem117.0.load, ptr %i.2118.reg2mem, align 1
  store i64 16, ptr %indvars.iv.i59.reg2mem, align 8
  br label %while.body.i58, !dbg !447

while.body.i58:                                   ; preds = %while.body.i58.while.body.i58_crit_edge, %while.body.i58.preheader
    #dbg_value(i64 %indvars.iv.i59.reg2mem.0.load, !436, !DIExpression(), !438)
  %indvars.iv.i59.reg2mem.0.load = load i64, ptr %indvars.iv.i59.reg2mem, align 8
  %indvars.iv.next.i60 = add nsw i64 %indvars.iv.i59.reg2mem.0.load, -1, !dbg !448
    #dbg_value(i64 %indvars.iv.next.i60, !436, !DIExpression(), !438)
  store i64 %indvars.iv.next.i60, ptr %indvars.iv.next.i60.reg2mem, align 8
  %arrayidx.i61 = getelementptr inbounds i8, ptr %buf, i64 %indvars.iv.next.i60, !dbg !449
  %6 = load i8, ptr %arrayidx.i61, align 1, !dbg !449, !tbaa !373
  %idxprom1.i = zext i8 %6 to i64, !dbg !449
  %arrayidx2.i62 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.i, !dbg !449
  %7 = load i8, ptr %arrayidx2.i62, align 1, !dbg !449, !tbaa !373
  store i8 %7, ptr %arrayidx.i61, align 1, !dbg !450, !tbaa !373
    #dbg_value(i64 %indvars.iv.next.i60, !436, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !438)
  %tobool.not.i63 = icmp eq i64 %indvars.iv.next.i60, 0, !dbg !447
  br i1 %tobool.not.i63, label %polly.split_new_and_old, label %while.body.i58.while.body.i58_crit_edge, !dbg !447, !llvm.loop !451

while.body.i58.while.body.i58_crit_edge:          ; preds = %while.body.i58
  store i64 %indvars.iv.next.i60, ptr %indvars.iv.i59.reg2mem, align 8
  br label %while.body.i58, !dbg !447

polly.split_new_and_old:                          ; preds = %while.body.i58
    #dbg_value(ptr %buf, !452, !DIExpression(), !457)
  %arrayidx.i64.reg2mem.0.arrayidx.i64.reload108 = load ptr, ptr %arrayidx.i64.reg2mem, align 8
  %8 = load i8, ptr %arrayidx.i64.reg2mem.0.arrayidx.i64.reload108, align 1, !dbg !459, !tbaa !373
    #dbg_value(i8 %8, !455, !DIExpression(), !457)
  %arrayidx1.i.reg2mem.0.arrayidx1.i.reload104 = load ptr, ptr %arrayidx1.i.reg2mem, align 8
  %9 = load i8, ptr %arrayidx1.i.reg2mem.0.arrayidx1.i.reload104, align 1, !dbg !460, !tbaa !373
  store i8 %9, ptr %arrayidx.i64.reg2mem.0.arrayidx.i64.reload108, align 1, !dbg !461, !tbaa !373
  %arrayidx3.i.reg2mem.0.arrayidx3.i.reload101 = load ptr, ptr %arrayidx3.i.reg2mem, align 8
  %10 = load i8, ptr %arrayidx3.i.reg2mem.0.arrayidx3.i.reload101, align 1, !dbg !462, !tbaa !373
  %arrayidx1.i.reg2mem.0.arrayidx1.i.reload103 = load ptr, ptr %arrayidx1.i.reg2mem, align 8
  store i8 %10, ptr %arrayidx1.i.reg2mem.0.arrayidx1.i.reload103, align 1, !dbg !463, !tbaa !373
  %arrayidx5.i.reg2mem.0.arrayidx5.i.reload98 = load ptr, ptr %arrayidx5.i.reg2mem, align 8
  %11 = load i8, ptr %arrayidx5.i.reg2mem.0.arrayidx5.i.reload98, align 1, !dbg !464, !tbaa !373
  %arrayidx3.i.reg2mem.0.arrayidx3.i.reload100 = load ptr, ptr %arrayidx3.i.reg2mem, align 8
  store i8 %11, ptr %arrayidx3.i.reg2mem.0.arrayidx3.i.reload100, align 1, !dbg !465, !tbaa !373
  %arrayidx5.i.reg2mem.0.arrayidx5.i.reload97 = load ptr, ptr %arrayidx5.i.reg2mem, align 8
  store i8 %8, ptr %arrayidx5.i.reg2mem.0.arrayidx5.i.reload97, align 1, !dbg !466, !tbaa !373
  %arrayidx8.i.reg2mem.0.arrayidx8.i.reload95 = load ptr, ptr %arrayidx8.i.reg2mem, align 8
  %12 = load i8, ptr %arrayidx8.i.reg2mem.0.arrayidx8.i.reload95, align 1, !dbg !467, !tbaa !373
    #dbg_value(i8 %12, !455, !DIExpression(), !457)
  %arrayidx9.i65.reg2mem.0.arrayidx9.i65.reload92 = load ptr, ptr %arrayidx9.i65.reg2mem, align 8
  %13 = load i8, ptr %arrayidx9.i65.reg2mem.0.arrayidx9.i65.reload92, align 1, !dbg !468, !tbaa !373
  store i8 %13, ptr %arrayidx8.i.reg2mem.0.arrayidx8.i.reload95, align 1, !dbg !469, !tbaa !373
  %arrayidx9.i65.reg2mem.0.arrayidx9.i65.reload91 = load ptr, ptr %arrayidx9.i65.reg2mem, align 8
  store i8 %12, ptr %arrayidx9.i65.reg2mem.0.arrayidx9.i65.reload91, align 1, !dbg !470, !tbaa !373
  %arrayidx12.i.reg2mem.0.arrayidx12.i.reload88 = load ptr, ptr %arrayidx12.i.reg2mem, align 8
  %14 = load i8, ptr %arrayidx12.i.reg2mem.0.arrayidx12.i.reload88, align 1, !dbg !471, !tbaa !373
    #dbg_value(i8 %14, !456, !DIExpression(), !457)
  %arrayidx13.i66.reg2mem.0.arrayidx13.i66.reload84 = load ptr, ptr %arrayidx13.i66.reg2mem, align 8
  %15 = load i8, ptr %arrayidx13.i66.reg2mem.0.arrayidx13.i66.reload84, align 1, !dbg !472, !tbaa !373
  store i8 %15, ptr %arrayidx12.i.reg2mem.0.arrayidx12.i.reload88, align 1, !dbg !473, !tbaa !373
  %arrayidx15.i.reg2mem.0.arrayidx15.i.reload80 = load ptr, ptr %arrayidx15.i.reg2mem, align 8
  %16 = load i8, ptr %arrayidx15.i.reg2mem.0.arrayidx15.i.reload80, align 1, !dbg !474, !tbaa !373
  %arrayidx13.i66.reg2mem.0.arrayidx13.i66.reload83 = load ptr, ptr %arrayidx13.i66.reg2mem, align 8
  store i8 %16, ptr %arrayidx13.i66.reg2mem.0.arrayidx13.i66.reload83, align 1, !dbg !475, !tbaa !373
  %arrayidx17.i.reg2mem.0.arrayidx17.i.reload77 = load ptr, ptr %arrayidx17.i.reg2mem, align 8
  %17 = load i8, ptr %arrayidx17.i.reg2mem.0.arrayidx17.i.reload77, align 1, !dbg !476, !tbaa !373
  %arrayidx15.i.reg2mem.0.arrayidx15.i.reload79 = load ptr, ptr %arrayidx15.i.reg2mem, align 8
  store i8 %17, ptr %arrayidx15.i.reg2mem.0.arrayidx15.i.reload79, align 1, !dbg !477, !tbaa !373
  %arrayidx17.i.reg2mem.0.arrayidx17.i.reload76 = load ptr, ptr %arrayidx17.i.reg2mem, align 8
  store i8 %14, ptr %arrayidx17.i.reg2mem.0.arrayidx17.i.reload76, align 1, !dbg !478, !tbaa !373
  %arrayidx20.i.reg2mem.0.arrayidx20.i.reload74 = load ptr, ptr %arrayidx20.i.reg2mem, align 8
  %18 = load i8, ptr %arrayidx20.i.reg2mem.0.arrayidx20.i.reload74, align 1, !dbg !479, !tbaa !373
    #dbg_value(i8 %18, !456, !DIExpression(), !457)
  %arrayidx21.i.reg2mem.0.arrayidx21.i.reload71 = load ptr, ptr %arrayidx21.i.reg2mem, align 8
  %19 = load i8, ptr %arrayidx21.i.reg2mem.0.arrayidx21.i.reload71, align 1, !dbg !480, !tbaa !373
  store i8 %19, ptr %arrayidx20.i.reg2mem.0.arrayidx20.i.reload74, align 1, !dbg !481, !tbaa !373
  %arrayidx21.i.reg2mem.0.arrayidx21.i.reload70 = load ptr, ptr %arrayidx21.i.reg2mem, align 8
  store i8 %18, ptr %arrayidx21.i.reg2mem.0.arrayidx21.i.reload70, align 1, !dbg !482, !tbaa !373
    #dbg_value(ptr %buf, !483, !DIExpression(), !493)
    #dbg_label(!492, !495)
    #dbg_value(i8 0, !486, !DIExpression(), !493)
  %.not35.reg2mem.0..not35.reload = load i1, ptr %.not35.reg2mem, align 1
  %.not32 = or i1 %.not35.reg2mem.0..not35.reload, %indvar.reg2mem119.0.indvar.reload120
  br i1 %.not32, label %polly.split_new_and_old.for.body.i_crit_edge, label %polly.split_new_and_old.polly.stmt.for.body.i_crit_edge

polly.split_new_and_old.polly.stmt.for.body.i_crit_edge: ; preds = %polly.split_new_and_old
  store i64 0, ptr %polly.indvar.reg2mem, align 8
  br label %polly.stmt.for.body.i

polly.split_new_and_old.for.body.i_crit_edge:     ; preds = %polly.split_new_and_old
  store i64 0, ptr %indvars.iv.i67.reg2mem, align 8
  br label %for.body.i

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %polly.split_new_and_old.for.body.i_crit_edge
    #dbg_value(i64 %indvars.iv.i67.reg2mem.0.load, !486, !DIExpression(), !493)
  %indvars.iv.i67.reg2mem.0.load = load i64, ptr %indvars.iv.i67.reg2mem, align 8
  %arrayidx.i68 = getelementptr inbounds i8, ptr %buf, i64 %indvars.iv.i67.reg2mem.0.load, !dbg !496
  %20 = load i8, ptr %arrayidx.i68, align 1, !dbg !496, !tbaa !373
    #dbg_value(i8 %20, !487, !DIExpression(), !493)
  %arrayidx4.i69 = getelementptr i8, ptr %arrayidx.i68, i64 1, !dbg !500
  %21 = load i8, ptr %arrayidx4.i69, align 1, !dbg !500, !tbaa !373
    #dbg_value(i8 %21, !488, !DIExpression(), !493)
  %arrayidx8.i70 = getelementptr i8, ptr %arrayidx.i68, i64 2, !dbg !501
  %22 = load i8, ptr %arrayidx8.i70, align 1, !dbg !501, !tbaa !373
    #dbg_value(i8 %22, !489, !DIExpression(), !493)
  %arrayidx12.i71 = getelementptr i8, ptr %arrayidx.i68, i64 3, !dbg !502
  %23 = load i8, ptr %arrayidx12.i71, align 1, !dbg !502, !tbaa !373
    #dbg_value(i8 %23, !490, !DIExpression(), !493)
  %xor109.i = xor i8 %21, %20, !dbg !503
  %24 = xor i8 %22, %xor109.i, !dbg !504
  %conv19.i = xor i8 %24, %23, !dbg !504
    #dbg_value(i8 %conv19.i, !491, !DIExpression(), !493)
    #dbg_value(i8 %xor109.i, !345, !DIExpression(), !505)
  %shl.i.i = shl i8 %xor109.i, 1, !dbg !507
  %xor.i.i = xor i8 %shl.i.i, 27, !dbg !507
  %tobool.not7.i.i = icmp slt i8 %xor109.i, 0, !dbg !507
  %cond.i.i = select i1 %tobool.not7.i.i, i8 %xor.i.i, i8 %shl.i.i, !dbg !507
  %25 = xor i8 %20, %cond.i.i, !dbg !508
  %xor30108.i = xor i8 %25, %conv19.i, !dbg !508
  store i8 %xor30108.i, ptr %arrayidx.i68, align 1, !dbg !508, !tbaa !373
  %xor35.i = xor i8 %22, %21, !dbg !509
    #dbg_value(i8 %xor35.i, !345, !DIExpression(), !510)
  %shl.i118.i = shl i8 %xor35.i, 1, !dbg !512
  %xor.i119.i = xor i8 %shl.i118.i, 27, !dbg !512
  %tobool.not7.i120.i = icmp slt i8 %xor35.i, 0, !dbg !512
  %cond.i121.i = select i1 %tobool.not7.i120.i, i8 %xor.i119.i, i8 %shl.i118.i, !dbg !512
  %26 = xor i8 %21, %cond.i121.i, !dbg !513
  %xor45111.i = xor i8 %26, %conv19.i, !dbg !513
  store i8 %xor45111.i, ptr %arrayidx4.i69, align 1, !dbg !513, !tbaa !373
  %xor50112.i = xor i8 %23, %22, !dbg !514
    #dbg_value(i8 %xor50112.i, !345, !DIExpression(), !515)
  %shl.i122.i = shl i8 %xor50112.i, 1, !dbg !517
  %xor.i123.i = xor i8 %shl.i122.i, 27, !dbg !517
  %tobool.not7.i124.i = icmp slt i8 %xor50112.i, 0, !dbg !517
  %cond.i125.i = select i1 %tobool.not7.i124.i, i8 %xor.i123.i, i8 %shl.i122.i, !dbg !517
  %27 = xor i8 %xor109.i, %cond.i125.i, !dbg !518
  %xor60114.i = xor i8 %27, %23, !dbg !518
  store i8 %xor60114.i, ptr %arrayidx8.i70, align 1, !dbg !518, !tbaa !373
  %xor65115.i = xor i8 %23, %20, !dbg !519
    #dbg_value(i8 %xor65115.i, !345, !DIExpression(), !520)
  %shl.i126.i = shl i8 %xor65115.i, 1, !dbg !522
  %xor.i127.i = xor i8 %shl.i126.i, 27, !dbg !522
  %tobool.not7.i128.i = icmp slt i8 %xor65115.i, 0, !dbg !522
  %cond.i129.i = select i1 %tobool.not7.i128.i, i8 %xor.i127.i, i8 %shl.i126.i, !dbg !522
  %xor75117.i = xor i8 %cond.i129.i, %24, !dbg !523
  store i8 %xor75117.i, ptr %arrayidx12.i71, align 1, !dbg !523, !tbaa !373
  %indvars.iv.next.i72 = add nuw nsw i64 %indvars.iv.i67.reg2mem.0.load, 4, !dbg !524
    #dbg_value(i64 %indvars.iv.next.i72, !486, !DIExpression(), !493)
  store i64 %indvars.iv.next.i72, ptr %indvars.iv.next.i72.reg2mem, align 8
  %cmp.i = icmp ult i64 %indvars.iv.i67.reg2mem.0.load, 12, !dbg !525
  br i1 %cmp.i, label %for.body.i.for.body.i_crit_edge, label %aes_mixColumns.exit, !dbg !526, !llvm.loop !527

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i72, ptr %indvars.iv.i67.reg2mem, align 8
  br label %for.body.i, !dbg !526

aes_mixColumns.exit:                              ; preds = %for.body.i
  %28 = and i8 %i.2118.reg2mem117.0.load, 1, !dbg !529
  %tobool19.not = icmp eq i8 %28, 0, !dbg !529
  br i1 %tobool19.not, label %if.else, label %aes_mixColumns.exit.while.body.i73_crit_edge, !dbg !531

aes_mixColumns.exit.while.body.i73_crit_edge:     ; preds = %aes_mixColumns.exit
  store i64 16, ptr %indvars.iv.i74.reg2mem, align 8
  br label %while.body.i73, !dbg !531

while.body.i73:                                   ; preds = %while.body.i73.while.body.i73_crit_edge, %aes_mixColumns.exit.while.body.i73_crit_edge
    #dbg_value(i64 %indvars.iv.i74.reg2mem.0.load, !532, !DIExpression(), !540)
  %indvars.iv.i74.reg2mem.0.load = load i64, ptr %indvars.iv.i74.reg2mem, align 8
  %indvars.iv.next.i75 = add nsw i64 %indvars.iv.i74.reg2mem.0.load, -1, !dbg !542
    #dbg_value(i64 %indvars.iv.next.i75, !532, !DIExpression(), !540)
  store i64 %indvars.iv.next.i75, ptr %indvars.iv.next.i75.reg2mem, align 8
  %arrayidx.i76 = getelementptr inbounds i8, ptr %arrayidx21, i64 %indvars.iv.next.i75, !dbg !543
  %29 = load i8, ptr %arrayidx.i76, align 1, !dbg !543, !tbaa !373
  %arrayidx2.i77 = getelementptr inbounds i8, ptr %buf, i64 %indvars.iv.next.i75, !dbg !544
  %30 = load i8, ptr %arrayidx2.i77, align 1, !dbg !545, !tbaa !373
  %xor7.i = xor i8 %30, %29, !dbg !545
  store i8 %xor7.i, ptr %arrayidx2.i77, align 1, !dbg !545, !tbaa !373
    #dbg_value(i64 %indvars.iv.next.i75, !532, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !540)
  %tobool.not.i78 = icmp eq i64 %indvars.iv.next.i75, 0, !dbg !546
  br i1 %tobool.not.i78, label %while.body.i73.for.inc26_crit_edge, label %while.body.i73.while.body.i73_crit_edge, !dbg !546, !llvm.loop !547

while.body.i73.while.body.i73_crit_edge:          ; preds = %while.body.i73
  store i64 %indvars.iv.next.i75, ptr %indvars.iv.i74.reg2mem, align 8
  br label %while.body.i73, !dbg !546

while.body.i73.for.inc26_crit_edge:               ; preds = %while.body.i73
  br label %for.inc26, !dbg !546

if.else:                                          ; preds = %aes_mixColumns.exit
  call fastcc void @aes_expandEncKey(ptr noundef %ctx, ptr noundef nonnull %rcon), !dbg !549
    #dbg_value(ptr %buf, !537, !DIExpression(), !550)
    #dbg_value(ptr %ctx, !538, !DIExpression(), !550)
    #dbg_value(i8 16, !532, !DIExpression(), !550)
    #dbg_label(!539, !552)
    #dbg_value(i8 16, !532, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !550)
  store i64 16, ptr %indvars.iv.i80.reg2mem, align 8
  br label %while.body.i79, !dbg !553

while.body.i79:                                   ; preds = %while.body.i79.while.body.i79_crit_edge, %if.else
    #dbg_value(i64 %indvars.iv.i80.reg2mem.0.load, !532, !DIExpression(), !550)
  %indvars.iv.i80.reg2mem.0.load = load i64, ptr %indvars.iv.i80.reg2mem, align 8
  %indvars.iv.next.i81 = add nsw i64 %indvars.iv.i80.reg2mem.0.load, -1, !dbg !554
    #dbg_value(i64 %indvars.iv.next.i81, !532, !DIExpression(), !550)
  store i64 %indvars.iv.next.i81, ptr %indvars.iv.next.i81.reg2mem, align 8
  %arrayidx.i82 = getelementptr inbounds i8, ptr %ctx, i64 %indvars.iv.next.i81, !dbg !555
  %31 = load i8, ptr %arrayidx.i82, align 1, !dbg !555, !tbaa !373
  %arrayidx2.i83 = getelementptr inbounds i8, ptr %buf, i64 %indvars.iv.next.i81, !dbg !556
  %32 = load i8, ptr %arrayidx2.i83, align 1, !dbg !557, !tbaa !373
  %xor7.i84 = xor i8 %32, %31, !dbg !557
  store i8 %xor7.i84, ptr %arrayidx2.i83, align 1, !dbg !557, !tbaa !373
    #dbg_value(i64 %indvars.iv.next.i81, !532, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !550)
  %tobool.not.i85 = icmp eq i64 %indvars.iv.next.i81, 0, !dbg !553
  br i1 %tobool.not.i85, label %while.body.i79.for.inc26_crit_edge, label %while.body.i79.while.body.i79_crit_edge, !dbg !553, !llvm.loop !558

while.body.i79.while.body.i79_crit_edge:          ; preds = %while.body.i79
  store i64 %indvars.iv.next.i81, ptr %indvars.iv.i80.reg2mem, align 8
  br label %while.body.i79, !dbg !553

while.body.i79.for.inc26_crit_edge:               ; preds = %while.body.i79
  br label %for.inc26, !dbg !553

for.inc26:                                        ; preds = %polly.stmt.while.body.i73.for.inc26_crit_edge, %while.body.i79.for.inc26_crit_edge, %while.body.i73.for.inc26_crit_edge
  %inc27 = add nuw nsw i8 %i.2118.reg2mem117.0.load, 1, !dbg !560
    #dbg_value(i8 %inc27, !365, !DIExpression(), !370)
  store i8 %inc27, ptr %inc27.reg2mem, align 1
  %cmp15 = icmp ult i8 %i.2118.reg2mem117.0.load, 13, !dbg !561
    #dbg_value(ptr %buf, !431, !DIExpression(), !438)
    #dbg_value(ptr %buf, !431, !DIExpression(), !442)
    #dbg_value(i8 16, !436, !DIExpression(), !438)
    #dbg_value(i8 16, !436, !DIExpression(), !442)
    #dbg_label(!437, !444)
    #dbg_label(!437, !445)
    #dbg_value(i8 16, !436, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !438)
    #dbg_value(i8 16, !436, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !442)
  %indvar.next = xor i1 %indvar.reg2mem119.0.indvar.reload120, true, !dbg !446
  store i1 %indvar.next, ptr %indvar.next.reg2mem, align 1
  br i1 %cmp15, label %for.inc26.while.body.i58.preheader_crit_edge, label %for.inc26.while.body.i87_crit_edge, !dbg !446, !llvm.loop !562

for.inc26.while.body.i87_crit_edge:               ; preds = %for.inc26
  store i64 16, ptr %indvars.iv.i88.reg2mem, align 8
  br label %while.body.i87, !dbg !446

for.inc26.while.body.i58.preheader_crit_edge:     ; preds = %for.inc26
  store i8 %inc27, ptr %i.2118.reg2mem117, align 1
  store i1 %indvar.next, ptr %indvar.reg2mem119, align 1
  br label %while.body.i58.preheader, !dbg !446

while.body.i87:                                   ; preds = %while.body.i87.while.body.i87_crit_edge, %for.inc26.while.body.i87_crit_edge
    #dbg_value(i64 %indvars.iv.i88.reg2mem.0.load, !436, !DIExpression(), !442)
  %indvars.iv.i88.reg2mem.0.load = load i64, ptr %indvars.iv.i88.reg2mem, align 8
  %indvars.iv.next.i89 = add nsw i64 %indvars.iv.i88.reg2mem.0.load, -1, !dbg !564
    #dbg_value(i64 %indvars.iv.next.i89, !436, !DIExpression(), !442)
  %arrayidx.i90 = getelementptr inbounds i8, ptr %buf, i64 %indvars.iv.next.i89, !dbg !565
  %33 = load i8, ptr %arrayidx.i90, align 1, !dbg !565, !tbaa !373
  %idxprom1.i91 = zext i8 %33 to i64, !dbg !565
  %arrayidx2.i92 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom1.i91, !dbg !565
  %34 = load i8, ptr %arrayidx2.i92, align 1, !dbg !565, !tbaa !373
  store i8 %34, ptr %arrayidx.i90, align 1, !dbg !566, !tbaa !373
    #dbg_value(i64 %indvars.iv.next.i89, !436, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !442)
  %tobool.not.i93 = icmp eq i64 %indvars.iv.next.i89, 0, !dbg !567
  br i1 %tobool.not.i93, label %aes_subBytes.exit94, label %while.body.i87.while.body.i87_crit_edge, !dbg !567, !llvm.loop !568

while.body.i87.while.body.i87_crit_edge:          ; preds = %while.body.i87
  store i64 %indvars.iv.next.i89, ptr %indvars.iv.i88.reg2mem, align 8
  br label %while.body.i87, !dbg !567

aes_subBytes.exit94:                              ; preds = %while.body.i87
    #dbg_value(ptr %buf, !452, !DIExpression(), !569)
  %arrayidx.i64.reg2mem.0.arrayidx.i64.reload105 = load ptr, ptr %arrayidx.i64.reg2mem, align 8
  %35 = load i8, ptr %arrayidx.i64.reg2mem.0.arrayidx.i64.reload105, align 1, !dbg !571, !tbaa !373
    #dbg_value(i8 %35, !455, !DIExpression(), !569)
  %arrayidx1.i.reg2mem.0.arrayidx1.i.reload = load ptr, ptr %arrayidx1.i.reg2mem, align 8
  %36 = load i8, ptr %arrayidx1.i.reg2mem.0.arrayidx1.i.reload, align 1, !dbg !572, !tbaa !373
  store i8 %36, ptr %arrayidx.i64.reg2mem.0.arrayidx.i64.reload105, align 1, !dbg !573, !tbaa !373
  %arrayidx3.i.reg2mem.0.arrayidx3.i.reload = load ptr, ptr %arrayidx3.i.reg2mem, align 8
  %37 = load i8, ptr %arrayidx3.i.reg2mem.0.arrayidx3.i.reload, align 1, !dbg !574, !tbaa !373
  %arrayidx1.i.reg2mem.0.arrayidx1.i.reload102 = load ptr, ptr %arrayidx1.i.reg2mem, align 8
  store i8 %37, ptr %arrayidx1.i.reg2mem.0.arrayidx1.i.reload102, align 1, !dbg !575, !tbaa !373
  %arrayidx5.i.reg2mem.0.arrayidx5.i.reload = load ptr, ptr %arrayidx5.i.reg2mem, align 8
  %38 = load i8, ptr %arrayidx5.i.reg2mem.0.arrayidx5.i.reload, align 1, !dbg !576, !tbaa !373
  %arrayidx3.i.reg2mem.0.arrayidx3.i.reload99 = load ptr, ptr %arrayidx3.i.reg2mem, align 8
  store i8 %38, ptr %arrayidx3.i.reg2mem.0.arrayidx3.i.reload99, align 1, !dbg !577, !tbaa !373
  %arrayidx5.i.reg2mem.0.arrayidx5.i.reload96 = load ptr, ptr %arrayidx5.i.reg2mem, align 8
  store i8 %35, ptr %arrayidx5.i.reg2mem.0.arrayidx5.i.reload96, align 1, !dbg !578, !tbaa !373
  %arrayidx8.i.reg2mem.0.arrayidx8.i.reload = load ptr, ptr %arrayidx8.i.reg2mem, align 8
  %39 = load i8, ptr %arrayidx8.i.reg2mem.0.arrayidx8.i.reload, align 1, !dbg !579, !tbaa !373
    #dbg_value(i8 %39, !455, !DIExpression(), !569)
  %arrayidx9.i65.reg2mem.0.arrayidx9.i65.reload89 = load ptr, ptr %arrayidx9.i65.reg2mem, align 8
  %40 = load i8, ptr %arrayidx9.i65.reg2mem.0.arrayidx9.i65.reload89, align 1, !dbg !580, !tbaa !373
  store i8 %40, ptr %arrayidx8.i.reg2mem.0.arrayidx8.i.reload, align 1, !dbg !581, !tbaa !373
  %arrayidx9.i65.reg2mem.0.arrayidx9.i65.reload90 = load ptr, ptr %arrayidx9.i65.reg2mem, align 8
  store i8 %39, ptr %arrayidx9.i65.reg2mem.0.arrayidx9.i65.reload90, align 1, !dbg !582, !tbaa !373
  %arrayidx12.i.reg2mem.0.arrayidx12.i.reload85 = load ptr, ptr %arrayidx12.i.reg2mem, align 8
  %41 = load i8, ptr %arrayidx12.i.reg2mem.0.arrayidx12.i.reload85, align 1, !dbg !583, !tbaa !373
    #dbg_value(i8 %41, !456, !DIExpression(), !569)
  %arrayidx13.i66.reg2mem.0.arrayidx13.i66.reload81 = load ptr, ptr %arrayidx13.i66.reg2mem, align 8
  %42 = load i8, ptr %arrayidx13.i66.reg2mem.0.arrayidx13.i66.reload81, align 1, !dbg !584, !tbaa !373
  store i8 %42, ptr %arrayidx12.i.reg2mem.0.arrayidx12.i.reload85, align 1, !dbg !585, !tbaa !373
  %arrayidx15.i.reg2mem.0.arrayidx15.i.reload = load ptr, ptr %arrayidx15.i.reg2mem, align 8
  %43 = load i8, ptr %arrayidx15.i.reg2mem.0.arrayidx15.i.reload, align 1, !dbg !586, !tbaa !373
  store i8 %43, ptr %arrayidx13.i66.reg2mem.0.arrayidx13.i66.reload81, align 1, !dbg !587, !tbaa !373
  %arrayidx17.i.reg2mem.0.arrayidx17.i.reload = load ptr, ptr %arrayidx17.i.reg2mem, align 8
  %44 = load i8, ptr %arrayidx17.i.reg2mem.0.arrayidx17.i.reload, align 1, !dbg !588, !tbaa !373
  store i8 %44, ptr %arrayidx15.i.reg2mem.0.arrayidx15.i.reload, align 1, !dbg !589, !tbaa !373
  store i8 %41, ptr %arrayidx17.i.reg2mem.0.arrayidx17.i.reload, align 1, !dbg !590, !tbaa !373
  %arrayidx20.i.reg2mem.0.arrayidx20.i.reload = load ptr, ptr %arrayidx20.i.reg2mem, align 8
  %45 = load i8, ptr %arrayidx20.i.reg2mem.0.arrayidx20.i.reload, align 1, !dbg !591, !tbaa !373
    #dbg_value(i8 %45, !456, !DIExpression(), !569)
  %arrayidx21.i.reg2mem.0.arrayidx21.i.reload = load ptr, ptr %arrayidx21.i.reg2mem, align 8
  %46 = load i8, ptr %arrayidx21.i.reg2mem.0.arrayidx21.i.reload, align 1, !dbg !592, !tbaa !373
  store i8 %46, ptr %arrayidx20.i.reg2mem.0.arrayidx20.i.reload, align 1, !dbg !593, !tbaa !373
  %arrayidx21.i.reg2mem.0.arrayidx21.i.reload69 = load ptr, ptr %arrayidx21.i.reg2mem, align 8
  store i8 %45, ptr %arrayidx21.i.reg2mem.0.arrayidx21.i.reload69, align 1, !dbg !594, !tbaa !373
  call fastcc void @aes_expandEncKey(ptr noundef %ctx, ptr noundef nonnull %rcon), !dbg !595
    #dbg_value(ptr %buf, !537, !DIExpression(), !596)
    #dbg_value(ptr %ctx, !538, !DIExpression(), !596)
    #dbg_value(i8 16, !532, !DIExpression(), !596)
    #dbg_label(!539, !598)
    #dbg_value(i8 16, !532, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !596)
  store i64 16, ptr %indvars.iv.i108.reg2mem, align 8
  br label %while.body.i107, !dbg !599

while.body.i107:                                  ; preds = %while.body.i107.while.body.i107_crit_edge, %aes_subBytes.exit94
    #dbg_value(i64 %indvars.iv.i108.reg2mem.0.load, !532, !DIExpression(), !596)
  %indvars.iv.i108.reg2mem.0.load = load i64, ptr %indvars.iv.i108.reg2mem, align 8
  %indvars.iv.next.i109 = add nsw i64 %indvars.iv.i108.reg2mem.0.load, -1, !dbg !600
    #dbg_value(i64 %indvars.iv.next.i109, !532, !DIExpression(), !596)
  %arrayidx.i110 = getelementptr inbounds i8, ptr %ctx, i64 %indvars.iv.next.i109, !dbg !601
  %47 = load i8, ptr %arrayidx.i110, align 1, !dbg !601, !tbaa !373
  %arrayidx2.i111 = getelementptr inbounds i8, ptr %buf, i64 %indvars.iv.next.i109, !dbg !602
  %48 = load i8, ptr %arrayidx2.i111, align 1, !dbg !603, !tbaa !373
  %xor7.i112 = xor i8 %48, %47, !dbg !603
  store i8 %xor7.i112, ptr %arrayidx2.i111, align 1, !dbg !603, !tbaa !373
    #dbg_value(i64 %indvars.iv.next.i109, !532, !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value), !596)
  %tobool.not.i113 = icmp eq i64 %indvars.iv.next.i109, 0, !dbg !599
  br i1 %tobool.not.i113, label %aes_addRoundKey.exit114, label %while.body.i107.while.body.i107_crit_edge, !dbg !599, !llvm.loop !604

while.body.i107.while.body.i107_crit_edge:        ; preds = %while.body.i107
  store i64 %indvars.iv.next.i109, ptr %indvars.iv.i108.reg2mem, align 8
  br label %while.body.i107, !dbg !599

aes_addRoundKey.exit114:                          ; preds = %while.body.i107
  call void @llvm.lifetime.end.p0(i64 1, ptr nonnull %rcon) #21, !dbg !606
  ret void, !dbg !606

polly.stmt.for.body.i:                            ; preds = %polly.stmt.for.body.i.polly.stmt.for.body.i_crit_edge, %polly.split_new_and_old.polly.stmt.for.body.i_crit_edge
  %polly.indvar.reg2mem.0.load = load i64, ptr %polly.indvar.reg2mem, align 8
  %49 = shl nuw nsw i64 %polly.indvar.reg2mem.0.load, 2
  %scevgep = getelementptr i8, ptr %buf, i64 %49
  %_p_scalar_ = load i8, ptr %scevgep, align 1, !alias.scope !607, !noalias !610
  %arrayidx.i64.reg2mem.0.arrayidx.i64.reload = load ptr, ptr %arrayidx.i64.reg2mem, align 8
  %scevgep9 = getelementptr i8, ptr %arrayidx.i64.reg2mem.0.arrayidx.i64.reload, i64 %49
  %_p_scalar_10 = load i8, ptr %scevgep9, align 1, !alias.scope !607, !noalias !610
  %scevgep12 = getelementptr i8, ptr %arrayidx9.i65, i64 %49
  %_p_scalar_13 = load i8, ptr %scevgep12, align 1, !alias.scope !607, !noalias !610
  %scevgep15 = getelementptr i8, ptr %arrayidx12.i, i64 %49
  %_p_scalar_16 = load i8, ptr %scevgep15, align 1, !alias.scope !607, !noalias !610
  %p_xor109.i = xor i8 %_p_scalar_10, %_p_scalar_, !dbg !503
  %p_ = xor i8 %_p_scalar_13, %p_xor109.i, !dbg !504
  %p_conv19.i = xor i8 %p_, %_p_scalar_16, !dbg !504
  %p_shl.i.i = shl i8 %p_xor109.i, 1, !dbg !507
  %p_xor.i.i = xor i8 %p_shl.i.i, 27, !dbg !507
  %p_tobool.not7.i.i = icmp slt i8 %p_xor109.i, 0, !dbg !507
  %p_cond.i.i = select i1 %p_tobool.not7.i.i, i8 %p_xor.i.i, i8 %p_shl.i.i, !dbg !507
  %50 = xor i8 %_p_scalar_, %p_cond.i.i, !dbg !508
  %p_xor30108.i = xor i8 %50, %p_conv19.i, !dbg !508
  store i8 %p_xor30108.i, ptr %scevgep, align 1, !alias.scope !607, !noalias !610
  %p_xor35.i = xor i8 %_p_scalar_13, %_p_scalar_10, !dbg !509
  %p_shl.i118.i = shl i8 %p_xor35.i, 1, !dbg !512
  %p_xor.i119.i = xor i8 %p_shl.i118.i, 27, !dbg !512
  %p_tobool.not7.i120.i = icmp slt i8 %p_xor35.i, 0, !dbg !512
  %p_cond.i121.i = select i1 %p_tobool.not7.i120.i, i8 %p_xor.i119.i, i8 %p_shl.i118.i, !dbg !512
  %51 = xor i8 %_p_scalar_10, %p_cond.i121.i, !dbg !513
  %p_xor45111.i = xor i8 %51, %p_conv19.i, !dbg !513
  store i8 %p_xor45111.i, ptr %scevgep9, align 1, !alias.scope !607, !noalias !610
  %p_xor50112.i = xor i8 %_p_scalar_16, %_p_scalar_13, !dbg !514
  %p_shl.i122.i = shl i8 %p_xor50112.i, 1, !dbg !517
  %p_xor.i123.i = xor i8 %p_shl.i122.i, 27, !dbg !517
  %p_tobool.not7.i124.i = icmp slt i8 %p_xor50112.i, 0, !dbg !517
  %p_cond.i125.i = select i1 %p_tobool.not7.i124.i, i8 %p_xor.i123.i, i8 %p_shl.i122.i, !dbg !517
  %52 = xor i8 %p_xor109.i, %p_cond.i125.i, !dbg !518
  %p_xor60114.i = xor i8 %52, %_p_scalar_16, !dbg !518
  store i8 %p_xor60114.i, ptr %scevgep12, align 1, !alias.scope !607, !noalias !610
  %p_xor65115.i = xor i8 %_p_scalar_16, %_p_scalar_, !dbg !519
  %p_shl.i126.i = shl i8 %p_xor65115.i, 1, !dbg !522
  %p_xor.i127.i = xor i8 %p_shl.i126.i, 27, !dbg !522
  %p_tobool.not7.i128.i = icmp slt i8 %p_xor65115.i, 0, !dbg !522
  %p_cond.i129.i = select i1 %p_tobool.not7.i128.i, i8 %p_xor.i127.i, i8 %p_shl.i126.i, !dbg !522
  %p_xor75117.i = xor i8 %p_cond.i129.i, %p_, !dbg !523
  store i8 %p_xor75117.i, ptr %scevgep15, align 1, !alias.scope !607, !noalias !610
  %polly.indvar_next = add nuw nsw i64 %polly.indvar.reg2mem.0.load, 1
  store i64 %polly.indvar_next, ptr %polly.indvar_next.reg2mem, align 8
  %exitcond.not44 = icmp eq i64 %polly.indvar_next, 4
  br i1 %exitcond.not44, label %polly.stmt.for.body.i.polly.stmt.while.body.i73_crit_edge, label %polly.stmt.for.body.i.polly.stmt.for.body.i_crit_edge, !llvm.loop !527

polly.stmt.for.body.i.polly.stmt.for.body.i_crit_edge: ; preds = %polly.stmt.for.body.i
  store i64 %polly.indvar_next, ptr %polly.indvar.reg2mem, align 8
  br label %polly.stmt.for.body.i

polly.stmt.for.body.i.polly.stmt.while.body.i73_crit_edge: ; preds = %polly.stmt.for.body.i
  store i64 0, ptr %polly.indvar23.reg2mem, align 8
  br label %polly.stmt.while.body.i73

polly.stmt.while.body.i73:                        ; preds = %polly.stmt.while.body.i73.polly.stmt.while.body.i73_crit_edge, %polly.stmt.for.body.i.polly.stmt.while.body.i73_crit_edge
  %polly.indvar23.reg2mem.0.load = load i64, ptr %polly.indvar23.reg2mem, align 8
  %53 = sub nsw i64 0, %polly.indvar23.reg2mem.0.load
  %scevgep27 = getelementptr i8, ptr %scevgep26, i64 %53
  %_p_scalar_28 = load i8, ptr %scevgep27, align 1, !alias.scope !610, !noalias !607
  %scevgep30 = getelementptr i8, ptr %arrayidx13.i66, i64 %53
  %_p_scalar_31 = load i8, ptr %scevgep30, align 1, !alias.scope !607, !noalias !610
  %p_xor7.i = xor i8 %_p_scalar_31, %_p_scalar_28, !dbg !545
  store i8 %p_xor7.i, ptr %scevgep30, align 1, !alias.scope !607, !noalias !610
  %polly.indvar_next24 = add nuw nsw i64 %polly.indvar23.reg2mem.0.load, 1
  store i64 %polly.indvar_next24, ptr %polly.indvar_next24.reg2mem, align 8
  %exitcond43.not = icmp eq i64 %polly.indvar_next24, 16
  br i1 %exitcond43.not, label %polly.stmt.while.body.i73.for.inc26_crit_edge, label %polly.stmt.while.body.i73.polly.stmt.while.body.i73_crit_edge, !llvm.loop !547

polly.stmt.while.body.i73.polly.stmt.while.body.i73_crit_edge: ; preds = %polly.stmt.while.body.i73
  store i64 %polly.indvar_next24, ptr %polly.indvar23.reg2mem, align 8
  br label %polly.stmt.while.body.i73

polly.stmt.while.body.i73.for.inc26_crit_edge:    ; preds = %polly.stmt.while.body.i73
  br label %for.inc26
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: inlinehint nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define internal fastcc void @aes_expandEncKey(ptr nocapture noundef %k, ptr nocapture noundef nonnull %rc) unnamed_addr #3 !dbg !612 {
entry.split:
  %indvars.iv245.reg2mem = alloca i64, align 8
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(ptr %k, !614, !DIExpression(), !619)
    #dbg_value(ptr %rc, !615, !DIExpression(), !619)
  %arrayidx = getelementptr inbounds i8, ptr %k, i64 29, !dbg !620
  %0 = load i8, ptr %arrayidx, align 1, !dbg !620, !tbaa !373
  %idxprom = zext i8 %0 to i64, !dbg !620
  %arrayidx1 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom, !dbg !620
  %1 = load i8, ptr %arrayidx1, align 1, !dbg !620, !tbaa !373
  %2 = load i8, ptr %rc, align 1, !dbg !621, !tbaa !373
  %xor225 = xor i8 %2, %1, !dbg !622
  %3 = load i8, ptr %k, align 1, !dbg !623, !tbaa !373
  %xor5226 = xor i8 %xor225, %3, !dbg !623
  store i8 %xor5226, ptr %k, align 1, !dbg !623, !tbaa !373
  %arrayidx7 = getelementptr inbounds i8, ptr %k, i64 30, !dbg !624
  %4 = load i8, ptr %arrayidx7, align 1, !dbg !624, !tbaa !373
  %idxprom8 = zext i8 %4 to i64, !dbg !624
  %arrayidx9 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom8, !dbg !624
  %5 = load i8, ptr %arrayidx9, align 1, !dbg !624, !tbaa !373
  %arrayidx11 = getelementptr inbounds i8, ptr %k, i64 1, !dbg !625
  %6 = load i8, ptr %arrayidx11, align 1, !dbg !626, !tbaa !373
  %xor13227 = xor i8 %6, %5, !dbg !626
  store i8 %xor13227, ptr %arrayidx11, align 1, !dbg !626, !tbaa !373
  %arrayidx15 = getelementptr inbounds i8, ptr %k, i64 31, !dbg !627
  %7 = load i8, ptr %arrayidx15, align 1, !dbg !627, !tbaa !373
  %idxprom16 = zext i8 %7 to i64, !dbg !627
  %arrayidx17 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom16, !dbg !627
  %8 = load i8, ptr %arrayidx17, align 1, !dbg !627, !tbaa !373
  %arrayidx19 = getelementptr inbounds i8, ptr %k, i64 2, !dbg !628
  %9 = load i8, ptr %arrayidx19, align 1, !dbg !629, !tbaa !373
  %xor21228 = xor i8 %9, %8, !dbg !629
  store i8 %xor21228, ptr %arrayidx19, align 1, !dbg !629, !tbaa !373
  %arrayidx23 = getelementptr inbounds i8, ptr %k, i64 28, !dbg !630
  %10 = load i8, ptr %arrayidx23, align 1, !dbg !630, !tbaa !373
  %idxprom24 = zext i8 %10 to i64, !dbg !630
  %arrayidx25 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom24, !dbg !630
  %11 = load i8, ptr %arrayidx25, align 1, !dbg !630, !tbaa !373
  %arrayidx27 = getelementptr inbounds i8, ptr %k, i64 3, !dbg !631
  %12 = load i8, ptr %arrayidx27, align 1, !dbg !632, !tbaa !373
  %xor29229 = xor i8 %12, %11, !dbg !632
  store i8 %xor29229, ptr %arrayidx27, align 1, !dbg !632, !tbaa !373
  %13 = load i8, ptr %rc, align 1, !dbg !633, !tbaa !373
  %shl = shl i8 %13, 1, !dbg !633
  %isneg = icmp slt i8 %13, 0, !dbg !633
  %mul = select i1 %isneg, i8 27, i8 0, !dbg !633
  %xor33 = xor i8 %mul, %shl, !dbg !633
  store i8 %xor33, ptr %rc, align 1, !dbg !634, !tbaa !373
    #dbg_label(!617, !635)
    #dbg_value(i8 4, !616, !DIExpression(), !619)
  store i64 4, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !636

for.body:                                         ; preds = %for.body.for.body_crit_edge, %entry.split
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !616, !DIExpression(), !619)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %14 = getelementptr i8, ptr %k, i64 %indvars.iv.reg2mem.0.load, !dbg !638
  %arrayidx39 = getelementptr i8, ptr %14, i64 -4, !dbg !638
  %15 = load i8, ptr %arrayidx39, align 1, !dbg !638, !tbaa !373
  %16 = load i8, ptr %14, align 1, !dbg !640, !tbaa !373
  %xor44238 = xor i8 %16, %15, !dbg !640
  store i8 %xor44238, ptr %14, align 1, !dbg !640, !tbaa !373
  %arrayidx49 = getelementptr i8, ptr %14, i64 -3, !dbg !641
  %17 = load i8, ptr %arrayidx49, align 1, !dbg !641, !tbaa !373
  %arrayidx53 = getelementptr i8, ptr %14, i64 1, !dbg !642
  %18 = load i8, ptr %arrayidx53, align 1, !dbg !643, !tbaa !373
  %xor55239 = xor i8 %18, %17, !dbg !643
  store i8 %xor55239, ptr %arrayidx53, align 1, !dbg !643, !tbaa !373
  %arrayidx60 = getelementptr i8, ptr %14, i64 -2, !dbg !644
  %19 = load i8, ptr %arrayidx60, align 1, !dbg !644, !tbaa !373
  %arrayidx65 = getelementptr i8, ptr %14, i64 2, !dbg !645
  %20 = load i8, ptr %arrayidx65, align 1, !dbg !646, !tbaa !373
  %xor67240 = xor i8 %20, %19, !dbg !646
  store i8 %xor67240, ptr %arrayidx65, align 1, !dbg !646, !tbaa !373
  %arrayidx72 = getelementptr i8, ptr %14, i64 -1, !dbg !647
  %21 = load i8, ptr %arrayidx72, align 1, !dbg !647, !tbaa !373
  %arrayidx77 = getelementptr i8, ptr %14, i64 3, !dbg !648
  %22 = load i8, ptr %arrayidx77, align 1, !dbg !649, !tbaa !373
  %xor79241 = xor i8 %22, %21, !dbg !649
  store i8 %xor79241, ptr %arrayidx77, align 1, !dbg !649, !tbaa !373
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 4, !dbg !650
    #dbg_value(i64 %indvars.iv.next, !616, !DIExpression(), !619)
  %cmp = icmp ult i64 %indvars.iv.reg2mem.0.load, 12, !dbg !651
  br i1 %cmp, label %for.body.for.body_crit_edge, label %for.end, !dbg !636, !llvm.loop !652

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !636

for.end:                                          ; preds = %for.body
  %arrayidx84 = getelementptr inbounds i8, ptr %k, i64 12, !dbg !654
  %23 = load i8, ptr %arrayidx84, align 1, !dbg !654, !tbaa !373
  %idxprom85 = zext i8 %23 to i64, !dbg !654
  %arrayidx86 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom85, !dbg !654
  %24 = load i8, ptr %arrayidx86, align 1, !dbg !654, !tbaa !373
  %arrayidx88 = getelementptr inbounds i8, ptr %k, i64 16, !dbg !655
  %25 = load i8, ptr %arrayidx88, align 1, !dbg !656, !tbaa !373
  %xor90230 = xor i8 %25, %24, !dbg !656
  store i8 %xor90230, ptr %arrayidx88, align 1, !dbg !656, !tbaa !373
  %arrayidx92 = getelementptr inbounds i8, ptr %k, i64 13, !dbg !657
  %26 = load i8, ptr %arrayidx92, align 1, !dbg !657, !tbaa !373
  %idxprom93 = zext i8 %26 to i64, !dbg !657
  %arrayidx94 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom93, !dbg !657
  %27 = load i8, ptr %arrayidx94, align 1, !dbg !657, !tbaa !373
  %arrayidx96 = getelementptr inbounds i8, ptr %k, i64 17, !dbg !658
  %28 = load i8, ptr %arrayidx96, align 1, !dbg !659, !tbaa !373
  %xor98231 = xor i8 %28, %27, !dbg !659
  store i8 %xor98231, ptr %arrayidx96, align 1, !dbg !659, !tbaa !373
  %arrayidx100 = getelementptr inbounds i8, ptr %k, i64 14, !dbg !660
  %29 = load i8, ptr %arrayidx100, align 1, !dbg !660, !tbaa !373
  %idxprom101 = zext i8 %29 to i64, !dbg !660
  %arrayidx102 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom101, !dbg !660
  %30 = load i8, ptr %arrayidx102, align 1, !dbg !660, !tbaa !373
  %arrayidx104 = getelementptr inbounds i8, ptr %k, i64 18, !dbg !661
  %31 = load i8, ptr %arrayidx104, align 1, !dbg !662, !tbaa !373
  %xor106232 = xor i8 %31, %30, !dbg !662
  store i8 %xor106232, ptr %arrayidx104, align 1, !dbg !662, !tbaa !373
  %arrayidx108 = getelementptr inbounds i8, ptr %k, i64 15, !dbg !663
  %32 = load i8, ptr %arrayidx108, align 1, !dbg !663, !tbaa !373
  %idxprom109 = zext i8 %32 to i64, !dbg !663
  %arrayidx110 = getelementptr inbounds [256 x i8], ptr @sbox, i64 0, i64 %idxprom109, !dbg !663
  %33 = load i8, ptr %arrayidx110, align 1, !dbg !663, !tbaa !373
  %arrayidx112 = getelementptr inbounds i8, ptr %k, i64 19, !dbg !664
  %34 = load i8, ptr %arrayidx112, align 1, !dbg !665, !tbaa !373
  %xor114233 = xor i8 %34, %33, !dbg !665
  store i8 %xor114233, ptr %arrayidx112, align 1, !dbg !665, !tbaa !373
    #dbg_label(!618, !666)
    #dbg_value(i8 20, !616, !DIExpression(), !619)
  store i64 20, ptr %indvars.iv245.reg2mem, align 8
  br label %for.body120, !dbg !667

for.body120:                                      ; preds = %for.body120.for.body120_crit_edge, %for.end
    #dbg_value(i64 %indvars.iv245.reg2mem.0.load, !616, !DIExpression(), !619)
  %indvars.iv245.reg2mem.0.load = load i64, ptr %indvars.iv245.reg2mem, align 8
  %35 = getelementptr i8, ptr %k, i64 %indvars.iv245.reg2mem.0.load, !dbg !669
  %arrayidx124 = getelementptr i8, ptr %35, i64 -4, !dbg !669
  %36 = load i8, ptr %arrayidx124, align 1, !dbg !669, !tbaa !373
  %37 = load i8, ptr %35, align 1, !dbg !671, !tbaa !373
  %xor129234 = xor i8 %37, %36, !dbg !671
  store i8 %xor129234, ptr %35, align 1, !dbg !671, !tbaa !373
  %arrayidx134 = getelementptr i8, ptr %35, i64 -3, !dbg !672
  %38 = load i8, ptr %arrayidx134, align 1, !dbg !672, !tbaa !373
  %arrayidx139 = getelementptr i8, ptr %35, i64 1, !dbg !673
  %39 = load i8, ptr %arrayidx139, align 1, !dbg !674, !tbaa !373
  %xor141235 = xor i8 %39, %38, !dbg !674
  store i8 %xor141235, ptr %arrayidx139, align 1, !dbg !674, !tbaa !373
  %arrayidx146 = getelementptr i8, ptr %35, i64 -2, !dbg !675
  %40 = load i8, ptr %arrayidx146, align 1, !dbg !675, !tbaa !373
  %arrayidx151 = getelementptr i8, ptr %35, i64 2, !dbg !676
  %41 = load i8, ptr %arrayidx151, align 1, !dbg !677, !tbaa !373
  %xor153236 = xor i8 %41, %40, !dbg !677
  store i8 %xor153236, ptr %arrayidx151, align 1, !dbg !677, !tbaa !373
  %arrayidx158 = getelementptr i8, ptr %35, i64 -1, !dbg !678
  %42 = load i8, ptr %arrayidx158, align 1, !dbg !678, !tbaa !373
  %arrayidx163 = getelementptr i8, ptr %35, i64 3, !dbg !679
  %43 = load i8, ptr %arrayidx163, align 1, !dbg !680, !tbaa !373
  %xor165237 = xor i8 %43, %42, !dbg !680
  store i8 %xor165237, ptr %arrayidx163, align 1, !dbg !680, !tbaa !373
  %indvars.iv.next246 = add nuw nsw i64 %indvars.iv245.reg2mem.0.load, 4, !dbg !681
    #dbg_value(i64 %indvars.iv.next246, !616, !DIExpression(), !619)
  %cmp118 = icmp ult i64 %indvars.iv245.reg2mem.0.load, 28, !dbg !682
  br i1 %cmp118, label %for.body120.for.body120_crit_edge, label %for.end171, !dbg !667, !llvm.loop !683

for.body120.for.body120_crit_edge:                ; preds = %for.body120
  store i64 %indvars.iv.next246, ptr %indvars.iv245.reg2mem, align 8
  br label %for.body120, !dbg !667

for.end171:                                       ; preds = %for.body120
  ret void, !dbg !685
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable
define dso_local void @run_benchmark(ptr nocapture noundef %vargs) local_unnamed_addr #4 !dbg !686 {
entry.split:
    #dbg_value(ptr %vargs, !690, !DIExpression(), !692)
    #dbg_value(ptr %vargs, !691, !DIExpression(), !692)
  %k = getelementptr inbounds i8, ptr %vargs, i64 96, !dbg !693
  %buf = getelementptr inbounds i8, ptr %vargs, i64 128, !dbg !694
  tail call void @aes(ptr noundef %vargs, ptr noundef nonnull %k, ptr noundef nonnull %buf) #21, !dbg !695
  ret void, !dbg !696
}

; Function Attrs: nounwind uwtable
define dso_local void @input_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #5 !dbg !697 {
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
    #dbg_value(i32 %fd, !701, !DIExpression(), !706)
    #dbg_value(ptr %vdata, !702, !DIExpression(), !706)
    #dbg_value(ptr %vdata, !703, !DIExpression(), !706)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(144) %vdata, i8 0, i64 144, i1 false), !dbg !707
  %call = tail call ptr @readfile(i32 noundef signext %fd) #21, !dbg !708
    #dbg_value(ptr %call, !704, !DIExpression(), !706)
    #dbg_value(ptr %call, !709, !DIExpression(), !716)
    #dbg_value(i32 1, !714, !DIExpression(), !716)
    #dbg_value(i32 0, !715, !DIExpression(), !716)
  store ptr %call, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 0, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem72.0.load, !715, !DIExpression(), !716)
    #dbg_value(ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, !709, !DIExpression(), !716)
  %i.041.i.reg2mem72.0.load = load i32, ptr %i.041.i.reg2mem72, align 4
  %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71 = load ptr, ptr %s.addr.040.i.reg2mem70, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, align 1, !dbg !718, !tbaa !373
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !719

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !719

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !719

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !720
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !720, !tbaa !373
  %cmp13.i = icmp eq i8 %1, 37, !dbg !723
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !724

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem72.0.load, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !724

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 2, !dbg !725
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !725, !tbaa !373
  %cmp18.i = icmp eq i8 %2, 10, !dbg !726
  %inc.i = zext i1 %cmp18.i to i32, !dbg !727
  %spec.select.i = add nsw i32 %i.041.i.reg2mem72.0.load, %inc.i, !dbg !727
  store i32 %spec.select.i, ptr %i.1.i.reg2mem68, align 4
  br label %if.end21.i, !dbg !727

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem68.0.load, !715, !DIExpression(), !716)
  %i.1.i.reg2mem68.0.load = load i32, ptr %i.1.i.reg2mem68, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem70.0.s.addr.040.i.reload71, i64 1, !dbg !728
    #dbg_value(ptr %incdec.ptr.i, !709, !DIExpression(), !716)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem68.0.load, 1, !dbg !729
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !730, !llvm.loop !731

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem70, align 8
  store i32 %i.1.i.reg2mem68.0.load, ptr %i.041.i.reg2mem72, align 4
  br label %land.rhs.i, !dbg !730

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !733, !tbaa !373
  %3 = icmp eq i8 %.pre.i, 0, !dbg !735
  %4 = select i1 %3, i64 0, i64 2, !dbg !736
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !730

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !736
    #dbg_value(ptr %spec.select38.i, !705, !DIExpression(), !706)
  %k = getelementptr inbounds i8, ptr %vdata, i64 96, !dbg !737
  %call2 = tail call signext i32 @parse_uint8_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %k, i32 noundef signext 32) #21, !dbg !738
    #dbg_value(ptr %call, !709, !DIExpression(), !739)
    #dbg_value(i32 2, !714, !DIExpression(), !739)
    #dbg_value(i32 0, !715, !DIExpression(), !739)
  store ptr %call, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 0, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1

land.rhs.i1:                                      ; preds = %if.end21.i7.land.rhs.i1_crit_edge, %find_section_start.exit
    #dbg_value(i32 %i.041.i2.reg2mem66.0.load, !715, !DIExpression(), !739)
    #dbg_value(ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, !709, !DIExpression(), !739)
  %i.041.i2.reg2mem66.0.load = load i32, ptr %i.041.i2.reg2mem66, align 4
  %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65 = load ptr, ptr %s.addr.040.i3.reg2mem64, align 8
  %5 = load i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, align 1, !dbg !741, !tbaa !373
  switch i8 %5, label %land.rhs.i1.if.end21.i7_crit_edge [
    i8 0, label %land.rhs.i1.find_section_start.exit21_crit_edge
    i8 37, label %land.lhs.true10.i4
  ], !dbg !742

land.rhs.i1.find_section_start.exit21_crit_edge:  ; preds = %land.rhs.i1
  store ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !742

land.rhs.i1.if.end21.i7_crit_edge:                ; preds = %land.rhs.i1
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !742

land.lhs.true10.i4:                               ; preds = %land.rhs.i1
  %arrayidx11.i5 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !743
  %6 = load i8, ptr %arrayidx11.i5, align 1, !dbg !743, !tbaa !373
  %cmp13.i6 = icmp eq i8 %6, 37, !dbg !744
  br i1 %cmp13.i6, label %land.lhs.true15.i16, label %land.lhs.true10.i4.if.end21.i7_crit_edge, !dbg !745

land.lhs.true10.i4.if.end21.i7_crit_edge:         ; preds = %land.lhs.true10.i4
  store i32 %i.041.i2.reg2mem66.0.load, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !745

land.lhs.true15.i16:                              ; preds = %land.lhs.true10.i4
  %arrayidx16.i17 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 2, !dbg !746
  %7 = load i8, ptr %arrayidx16.i17, align 1, !dbg !746, !tbaa !373
  %cmp18.i18 = icmp eq i8 %7, 10, !dbg !747
  %inc.i19 = zext i1 %cmp18.i18 to i32, !dbg !748
  %spec.select.i20 = add nsw i32 %i.041.i2.reg2mem66.0.load, %inc.i19, !dbg !748
  store i32 %spec.select.i20, ptr %i.1.i8.reg2mem62, align 4
  br label %if.end21.i7, !dbg !748

if.end21.i7:                                      ; preds = %land.lhs.true10.i4.if.end21.i7_crit_edge, %land.rhs.i1.if.end21.i7_crit_edge, %land.lhs.true15.i16
    #dbg_value(i32 %i.1.i8.reg2mem62.0.load, !715, !DIExpression(), !739)
  %i.1.i8.reg2mem62.0.load = load i32, ptr %i.1.i8.reg2mem62, align 4
  %incdec.ptr.i9 = getelementptr inbounds i8, ptr %s.addr.040.i3.reg2mem64.0.s.addr.040.i3.reload65, i64 1, !dbg !749
    #dbg_value(ptr %incdec.ptr.i9, !709, !DIExpression(), !739)
  %cmp4.i10 = icmp slt i32 %i.1.i8.reg2mem62.0.load, 2, !dbg !750
  br i1 %cmp4.i10, label %if.end21.i7.land.rhs.i1_crit_edge, label %if.end21.while.end_crit_edge.i11, !dbg !751, !llvm.loop !752

if.end21.i7.land.rhs.i1_crit_edge:                ; preds = %if.end21.i7
  store ptr %incdec.ptr.i9, ptr %s.addr.040.i3.reg2mem64, align 8
  store i32 %i.1.i8.reg2mem62.0.load, ptr %i.041.i2.reg2mem66, align 4
  br label %land.rhs.i1, !dbg !751

if.end21.while.end_crit_edge.i11:                 ; preds = %if.end21.i7
  %.pre.i12 = load i8, ptr %incdec.ptr.i9, align 1, !dbg !754, !tbaa !373
  %8 = icmp eq i8 %.pre.i12, 0, !dbg !755
  %9 = select i1 %8, i64 0, i64 2, !dbg !756
  store ptr %incdec.ptr.i9, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i13.reg2mem, align 8
  br label %find_section_start.exit21, !dbg !751

find_section_start.exit21:                        ; preds = %land.rhs.i1.find_section_start.exit21_crit_edge, %if.end21.while.end_crit_edge.i11
  %cmp23.not.i13.reg2mem.0.load = load i64, ptr %cmp23.not.i13.reg2mem, align 8
  %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload = load ptr, ptr %s.addr.0.lcssa.ph.i14.reg2mem, align 8
  %spec.select38.i15 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i14.reg2mem.0.s.addr.0.lcssa.ph.i14.reload, i64 %cmp23.not.i13.reg2mem.0.load, !dbg !756
    #dbg_value(ptr %spec.select38.i15, !705, !DIExpression(), !706)
  %buf = getelementptr inbounds i8, ptr %vdata, i64 128, !dbg !757
  %call5 = tail call signext i32 @parse_uint8_t_array(ptr noundef nonnull %spec.select38.i15, ptr noundef nonnull %buf, i32 noundef signext 16) #21, !dbg !758
  tail call void @free(ptr noundef %call) #21, !dbg !759
  ret void, !dbg !760
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #6

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare !dbg !761 void @free(ptr allocptr nocapture noundef) local_unnamed_addr #7

; Function Attrs: nounwind uwtable
define dso_local void @data_to_input(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #5 !dbg !763 {
entry.split:
  %indvars.iv.i10.reg2mem = alloca i64, align 8
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !765, !DIExpression(), !768)
    #dbg_value(ptr %vdata, !766, !DIExpression(), !768)
    #dbg_value(ptr %vdata, !767, !DIExpression(), !768)
    #dbg_value(i32 %fd, !769, !DIExpression(), !774)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !776
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !776

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #22, !dbg !776
  unreachable, !dbg !776

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !779
  %k = getelementptr inbounds i8, ptr %vdata, i64 96, !dbg !780
    #dbg_value(i32 %fd, !781, !DIExpression(), !789)
    #dbg_value(ptr %k, !786, !DIExpression(), !789)
    #dbg_value(i32 32, !787, !DIExpression(), !789)
    #dbg_value(i32 0, !788, !DIExpression(), !789)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !791

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !788, !DIExpression(), !789)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i8, ptr %k, i64 %indvars.iv.i.reg2mem.0.load, !dbg !793
  %0 = load i8, ptr %arrayidx.i, align 1, !dbg !793, !tbaa !373
  %conv.i = zext i8 %0 to i32, !dbg !793
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv.i), !dbg !793
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !796
    #dbg_value(i64 %indvars.iv.next.i, !788, !DIExpression(), !789)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 32, !dbg !796
  br i1 %exitcond.not.i, label %for.cond.preheader.i8, label %for.body.i.for.body.i_crit_edge, !dbg !791, !llvm.loop !797

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !791

for.cond.preheader.i8:                            ; preds = %for.body.i
    #dbg_value(i32 %fd, !769, !DIExpression(), !798)
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !800
  %buf = getelementptr inbounds i8, ptr %vdata, i64 128, !dbg !801
    #dbg_value(i32 %fd, !781, !DIExpression(), !802)
    #dbg_value(ptr %buf, !786, !DIExpression(), !802)
    #dbg_value(i32 16, !787, !DIExpression(), !802)
    #dbg_value(i32 0, !788, !DIExpression(), !802)
  store i64 0, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !804

for.body.i9:                                      ; preds = %for.body.i9.for.body.i9_crit_edge, %for.cond.preheader.i8
    #dbg_value(i64 %indvars.iv.i10.reg2mem.0.load, !788, !DIExpression(), !802)
  %indvars.iv.i10.reg2mem.0.load = load i64, ptr %indvars.iv.i10.reg2mem, align 8
  %arrayidx.i11 = getelementptr inbounds i8, ptr %buf, i64 %indvars.iv.i10.reg2mem.0.load, !dbg !805
  %1 = load i8, ptr %arrayidx.i11, align 1, !dbg !805, !tbaa !373
  %conv.i12 = zext i8 %1 to i32, !dbg !805
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv.i12), !dbg !805
  %indvars.iv.next.i13 = add nuw nsw i64 %indvars.iv.i10.reg2mem.0.load, 1, !dbg !806
    #dbg_value(i64 %indvars.iv.next.i13, !788, !DIExpression(), !802)
  %exitcond.not.i14 = icmp eq i64 %indvars.iv.next.i13, 16, !dbg !806
  br i1 %exitcond.not.i14, label %write_uint8_t_array.exit15, label %for.body.i9.for.body.i9_crit_edge, !dbg !804, !llvm.loop !807

for.body.i9.for.body.i9_crit_edge:                ; preds = %for.body.i9
  store i64 %indvars.iv.next.i13, ptr %indvars.iv.i10.reg2mem, align 8
  br label %for.body.i9, !dbg !804

write_uint8_t_array.exit15:                       ; preds = %for.body.i9
  ret void, !dbg !808
}

; Function Attrs: nounwind uwtable
define dso_local void @output_to_data(i32 noundef signext %fd, ptr nocapture noundef writeonly %vdata) local_unnamed_addr #5 !dbg !809 {
entry.split:
  %s.addr.0.lcssa.ph.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.reg2mem = alloca i64, align 8
  %i.1.i.reg2mem20 = alloca i32, align 4
  %s.addr.040.i.reg2mem22 = alloca ptr, align 8
  %i.041.i.reg2mem24 = alloca i32, align 4
    #dbg_value(i32 %fd, !811, !DIExpression(), !816)
    #dbg_value(ptr %vdata, !812, !DIExpression(), !816)
    #dbg_value(ptr %vdata, !813, !DIExpression(), !816)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(144) %vdata, i8 0, i64 144, i1 false), !dbg !817
  %call = tail call ptr @readfile(i32 noundef signext %fd) #21, !dbg !818
    #dbg_value(ptr %call, !814, !DIExpression(), !816)
    #dbg_value(ptr %call, !709, !DIExpression(), !819)
    #dbg_value(i32 1, !714, !DIExpression(), !819)
    #dbg_value(i32 0, !715, !DIExpression(), !819)
  store ptr %call, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 0, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i

land.rhs.i:                                       ; preds = %if.end21.i.land.rhs.i_crit_edge, %entry.split
    #dbg_value(i32 %i.041.i.reg2mem24.0.load, !715, !DIExpression(), !819)
    #dbg_value(ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, !709, !DIExpression(), !819)
  %i.041.i.reg2mem24.0.load = load i32, ptr %i.041.i.reg2mem24, align 4
  %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23 = load ptr, ptr %s.addr.040.i.reg2mem22, align 8
  %0 = load i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, align 1, !dbg !821, !tbaa !373
  switch i8 %0, label %land.rhs.i.if.end21.i_crit_edge [
    i8 0, label %land.rhs.i.find_section_start.exit_crit_edge
    i8 37, label %land.lhs.true10.i
  ], !dbg !822

land.rhs.i.find_section_start.exit_crit_edge:     ; preds = %land.rhs.i
  store ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !822

land.rhs.i.if.end21.i_crit_edge:                  ; preds = %land.rhs.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !822

land.lhs.true10.i:                                ; preds = %land.rhs.i
  %arrayidx11.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !823
  %1 = load i8, ptr %arrayidx11.i, align 1, !dbg !823, !tbaa !373
  %cmp13.i = icmp eq i8 %1, 37, !dbg !824
  br i1 %cmp13.i, label %land.lhs.true15.i, label %land.lhs.true10.i.if.end21.i_crit_edge, !dbg !825

land.lhs.true10.i.if.end21.i_crit_edge:           ; preds = %land.lhs.true10.i
  store i32 %i.041.i.reg2mem24.0.load, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !825

land.lhs.true15.i:                                ; preds = %land.lhs.true10.i
  %arrayidx16.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 2, !dbg !826
  %2 = load i8, ptr %arrayidx16.i, align 1, !dbg !826, !tbaa !373
  %cmp18.i = icmp eq i8 %2, 10, !dbg !827
  %inc.i = zext i1 %cmp18.i to i32, !dbg !828
  %spec.select.i = add nsw i32 %i.041.i.reg2mem24.0.load, %inc.i, !dbg !828
  store i32 %spec.select.i, ptr %i.1.i.reg2mem20, align 4
  br label %if.end21.i, !dbg !828

if.end21.i:                                       ; preds = %land.lhs.true10.i.if.end21.i_crit_edge, %land.rhs.i.if.end21.i_crit_edge, %land.lhs.true15.i
    #dbg_value(i32 %i.1.i.reg2mem20.0.load, !715, !DIExpression(), !819)
  %i.1.i.reg2mem20.0.load = load i32, ptr %i.1.i.reg2mem20, align 4
  %incdec.ptr.i = getelementptr inbounds i8, ptr %s.addr.040.i.reg2mem22.0.s.addr.040.i.reload23, i64 1, !dbg !829
    #dbg_value(ptr %incdec.ptr.i, !709, !DIExpression(), !819)
  %cmp4.i = icmp slt i32 %i.1.i.reg2mem20.0.load, 1, !dbg !830
  br i1 %cmp4.i, label %if.end21.i.land.rhs.i_crit_edge, label %if.end21.while.end_crit_edge.i, !dbg !831, !llvm.loop !832

if.end21.i.land.rhs.i_crit_edge:                  ; preds = %if.end21.i
  store ptr %incdec.ptr.i, ptr %s.addr.040.i.reg2mem22, align 8
  store i32 %i.1.i.reg2mem20.0.load, ptr %i.041.i.reg2mem24, align 4
  br label %land.rhs.i, !dbg !831

if.end21.while.end_crit_edge.i:                   ; preds = %if.end21.i
  %.pre.i = load i8, ptr %incdec.ptr.i, align 1, !dbg !834, !tbaa !373
  %3 = icmp eq i8 %.pre.i, 0, !dbg !835
  %4 = select i1 %3, i64 0, i64 2, !dbg !836
  store ptr %incdec.ptr.i, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.i.reg2mem, align 8
  br label %find_section_start.exit, !dbg !831

find_section_start.exit:                          ; preds = %land.rhs.i.find_section_start.exit_crit_edge, %if.end21.while.end_crit_edge.i
  %cmp23.not.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.reg2mem, align 8
  %spec.select38.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.reg2mem.0.s.addr.0.lcssa.ph.i.reload, i64 %cmp23.not.i.reg2mem.0.load, !dbg !836
    #dbg_value(ptr %spec.select38.i, !815, !DIExpression(), !816)
  %buf = getelementptr inbounds i8, ptr %vdata, i64 128, !dbg !837
  %call2 = tail call signext i32 @parse_uint8_t_array(ptr noundef nonnull %spec.select38.i, ptr noundef nonnull %buf, i32 noundef signext 16) #21, !dbg !838
  tail call void @free(ptr noundef %call) #21, !dbg !839
  ret void, !dbg !840
}

; Function Attrs: nounwind uwtable
define dso_local void @data_to_output(i32 noundef signext %fd, ptr nocapture noundef readonly %vdata) local_unnamed_addr #5 !dbg !841 {
entry.split:
  %indvars.iv.i.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !843, !DIExpression(), !846)
    #dbg_value(ptr %vdata, !844, !DIExpression(), !846)
    #dbg_value(ptr %vdata, !845, !DIExpression(), !846)
    #dbg_value(i32 %fd, !769, !DIExpression(), !847)
  %cmp.i = icmp sgt i32 %fd, 1, !dbg !849
  br i1 %cmp.i, label %for.cond.preheader.i, label %if.else.i, !dbg !849

if.else.i:                                        ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #22, !dbg !849
  unreachable, !dbg !849

for.cond.preheader.i:                             ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !850
  %buf = getelementptr inbounds i8, ptr %vdata, i64 128, !dbg !851
    #dbg_value(i32 %fd, !781, !DIExpression(), !852)
    #dbg_value(ptr %buf, !786, !DIExpression(), !852)
    #dbg_value(i32 16, !787, !DIExpression(), !852)
    #dbg_value(i32 0, !788, !DIExpression(), !852)
  store i64 0, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !854

for.body.i:                                       ; preds = %for.body.i.for.body.i_crit_edge, %for.cond.preheader.i
    #dbg_value(i64 %indvars.iv.i.reg2mem.0.load, !788, !DIExpression(), !852)
  %indvars.iv.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.reg2mem, align 8
  %arrayidx.i = getelementptr inbounds i8, ptr %buf, i64 %indvars.iv.i.reg2mem.0.load, !dbg !855
  %0 = load i8, ptr %arrayidx.i, align 1, !dbg !855, !tbaa !373
  %conv.i = zext i8 %0 to i32, !dbg !855
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv.i), !dbg !855
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i.reg2mem.0.load, 1, !dbg !856
    #dbg_value(i64 %indvars.iv.next.i, !788, !DIExpression(), !852)
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 16, !dbg !856
  br i1 %exitcond.not.i, label %write_uint8_t_array.exit, label %for.body.i.for.body.i_crit_edge, !dbg !854, !llvm.loop !857

for.body.i.for.body.i_crit_edge:                  ; preds = %for.body.i
  store i64 %indvars.iv.next.i, ptr %indvars.iv.i.reg2mem, align 8
  br label %for.body.i, !dbg !854

write_uint8_t_array.exit:                         ; preds = %for.body.i
  ret void, !dbg !858
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read) uwtable
define dso_local signext range(i32 0, 2) i32 @check_data(ptr nocapture noundef readonly %vdata, ptr nocapture noundef readonly %vref) local_unnamed_addr #8 !dbg !859 {
entry.split:
    #dbg_value(ptr %vdata, !863, !DIExpression(), !868)
    #dbg_value(ptr %vref, !864, !DIExpression(), !868)
    #dbg_value(ptr %vdata, !865, !DIExpression(), !868)
    #dbg_value(ptr %vref, !866, !DIExpression(), !868)
    #dbg_value(i32 0, !867, !DIExpression(), !868)
  %buf = getelementptr inbounds i8, ptr %vdata, i64 128, !dbg !869
  %buf1 = getelementptr inbounds i8, ptr %vref, i64 128, !dbg !870
  %bcmp = tail call i32 @bcmp(ptr noundef nonnull dereferenceable(16) %buf, ptr noundef nonnull dereferenceable(16) %buf1, i64 16), !dbg !871
    #dbg_value(i32 %bcmp, !867, !DIExpression(), !868)
  %tobool.not = icmp eq i32 %bcmp, 0, !dbg !872
  %lnot.ext = zext i1 %tobool.not to i32, !dbg !872
  ret i32 %lnot.ext, !dbg !873
}

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare signext i32 @bcmp(ptr nocapture, ptr nocapture, i64) local_unnamed_addr #9

; Function Attrs: nounwind uwtable
define dso_local noalias noundef ptr @readfile(i32 noundef signext %fd) local_unnamed_addr #5 !dbg !874 {
entry.split:
  %s = alloca %struct.stat, align 8, !DIAssignID !924
    #dbg_assign(i1 undef, !880, !DIExpression(), !924, ptr %s, !DIExpression(), !925)
    #dbg_value(i32 %fd, !878, !DIExpression(), !925)
  %bytes_read.035.reg2mem11 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %s) #21, !dbg !926
  %cmp = icmp sgt i32 %fd, 1, !dbg !927
  br i1 %cmp, label %if.end, label %if.else, !dbg !927

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 40, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #22, !dbg !927
  unreachable, !dbg !927

if.end:                                           ; preds = %entry.split
  %call = call signext i32 @fstat(i32 noundef signext %fd, ptr noundef nonnull %s) #21, !dbg !930
  %cmp1 = icmp eq i32 %call, 0, !dbg !930
  br i1 %cmp1, label %if.end5, label %if.else4, !dbg !930

if.else4:                                         ; preds = %if.end
  tail call void @__assert_fail(ptr noundef nonnull @.str.4, ptr noundef nonnull @.str.2, i32 noundef signext 41, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #22, !dbg !930
  unreachable, !dbg !930

if.end5:                                          ; preds = %if.end
  %st_size = getelementptr inbounds i8, ptr %s, i64 48, !dbg !933
  %0 = load i64, ptr %st_size, align 8, !dbg !933
    #dbg_value(i64 %0, !917, !DIExpression(), !925)
  %cmp6 = icmp sgt i64 %0, 0, !dbg !934
  br i1 %cmp6, label %if.end10, label %if.else9, !dbg !934

if.else9:                                         ; preds = %if.end5
  tail call void @__assert_fail(ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.2, i32 noundef signext 43, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #22, !dbg !934
  unreachable, !dbg !934

if.end10:                                         ; preds = %if.end5
  %add = add nuw nsw i64 %0, 1, !dbg !937
  %call11 = tail call noalias ptr @malloc(i64 noundef %add) #23, !dbg !938
    #dbg_value(ptr %call11, !879, !DIExpression(), !925)
    #dbg_value(i64 0, !920, !DIExpression(), !925)
  store i64 0, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !939

while.cond:                                       ; preds = %while.body
  %add19 = add nuw nsw i64 %call13, %bytes_read.035.reg2mem11.0.load, !dbg !940
    #dbg_value(i64 %add19, !920, !DIExpression(), !925)
  %cmp12 = icmp slt i64 %add19, %0, !dbg !942
  br i1 %cmp12, label %while.cond.while.body_crit_edge, label %while.end, !dbg !939, !llvm.loop !943

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i64 %add19, ptr %bytes_read.035.reg2mem11, align 8
  br label %while.body, !dbg !939

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end10
    #dbg_value(i64 %bytes_read.035.reg2mem11.0.load, !920, !DIExpression(), !925)
  %bytes_read.035.reg2mem11.0.load = load i64, ptr %bytes_read.035.reg2mem11, align 8
  %arrayidx = getelementptr inbounds i8, ptr %call11, i64 %bytes_read.035.reg2mem11.0.load, !dbg !945
  %sub = sub nsw i64 %0, %bytes_read.035.reg2mem11.0.load, !dbg !946
  %call13 = tail call i64 @read(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %sub) #21, !dbg !947
    #dbg_value(i64 %call13, !923, !DIExpression(), !925)
  %cmp14 = icmp sgt i64 %call13, -1, !dbg !948
    #dbg_value(!DIArgList(i64 %call13, i64 %bytes_read.035.reg2mem11.0.load), !920, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !925)
  br i1 %cmp14, label %while.cond, label %if.else17, !dbg !948

if.else17:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.8, ptr noundef nonnull @.str.2, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.readfile) #22, !dbg !948
  unreachable, !dbg !948

while.end:                                        ; preds = %while.cond
  %arrayidx20 = getelementptr inbounds i8, ptr %call11, i64 %0, !dbg !951
  store i8 0, ptr %arrayidx20, align 1, !dbg !952, !tbaa !373
  %call21 = tail call signext i32 @close(i32 noundef signext %fd) #21, !dbg !953
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %s) #21, !dbg !954
  ret ptr %call11, !dbg !955
}

; Function Attrs: noreturn nounwind
declare !dbg !956 void @__assert_fail(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #10

; Function Attrs: nofree nounwind
declare !dbg !961 noundef signext i32 @fstat(i32 noundef signext, ptr nocapture noundef) local_unnamed_addr #11

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare !dbg !966 noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #12

; Function Attrs: nofree
declare !dbg !971 noundef i64 @read(i32 noundef signext, ptr nocapture noundef, i64 noundef) local_unnamed_addr #13

declare !dbg !975 signext i32 @close(i32 noundef signext) local_unnamed_addr #14

; Function Attrs: nounwind uwtable
define dso_local ptr @find_section_start(ptr noundef readonly %s, i32 noundef signext %n) local_unnamed_addr #5 !dbg !710 {
entry.split:
  %retval.0.reg2mem = alloca ptr, align 8
  %s.addr.0.lcssa.ph.reg2mem = alloca ptr, align 8
  %cmp23.not.reg2mem = alloca i64, align 8
  %i.1.reg2mem17 = alloca i32, align 4
  %s.addr.040.reg2mem19 = alloca ptr, align 8
  %i.041.reg2mem21 = alloca i32, align 4
    #dbg_value(ptr %s, !709, !DIExpression(), !976)
    #dbg_value(i32 %n, !714, !DIExpression(), !976)
    #dbg_value(i32 0, !715, !DIExpression(), !976)
  %cmp = icmp sgt i32 %n, -1, !dbg !977
  br i1 %cmp, label %if.end, label %if.else, !dbg !977

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.10, ptr noundef nonnull @.str.2, i32 noundef signext 59, ptr noundef nonnull @__PRETTY_FUNCTION__.find_section_start) #22, !dbg !977
  unreachable, !dbg !977

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp eq i32 %n, 0, !dbg !980
  br i1 %cmp1, label %if.end.cleanup_crit_edge, label %if.end.land.rhs_crit_edge, !dbg !982

if.end.land.rhs_crit_edge:                        ; preds = %if.end
  store ptr %s, ptr %s.addr.040.reg2mem19, align 8
  store i32 0, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !982

if.end.cleanup_crit_edge:                         ; preds = %if.end
  store ptr %s, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !982

land.rhs:                                         ; preds = %if.end21.land.rhs_crit_edge, %if.end.land.rhs_crit_edge
    #dbg_value(i32 %i.041.reg2mem21.0.load, !715, !DIExpression(), !976)
    #dbg_value(ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, !709, !DIExpression(), !976)
  %i.041.reg2mem21.0.load = load i32, ptr %i.041.reg2mem21, align 4
  %s.addr.040.reg2mem19.0.s.addr.040.reload20 = load ptr, ptr %s.addr.040.reg2mem19, align 8
  %0 = load i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, align 1, !dbg !983, !tbaa !373
  switch i8 %0, label %land.rhs.if.end21_crit_edge [
    i8 0, label %land.rhs.while.end_crit_edge
    i8 37, label %land.lhs.true10
  ], !dbg !984

land.rhs.while.end_crit_edge:                     ; preds = %land.rhs
  store ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 0, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !984

land.rhs.if.end21_crit_edge:                      ; preds = %land.rhs
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !984

land.lhs.true10:                                  ; preds = %land.rhs
  %arrayidx11 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !985
  %1 = load i8, ptr %arrayidx11, align 1, !dbg !985, !tbaa !373
  %cmp13 = icmp eq i8 %1, 37, !dbg !986
  br i1 %cmp13, label %land.lhs.true15, label %land.lhs.true10.if.end21_crit_edge, !dbg !987

land.lhs.true10.if.end21_crit_edge:               ; preds = %land.lhs.true10
  store i32 %i.041.reg2mem21.0.load, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !987

land.lhs.true15:                                  ; preds = %land.lhs.true10
  %arrayidx16 = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 2, !dbg !988
  %2 = load i8, ptr %arrayidx16, align 1, !dbg !988, !tbaa !373
  %cmp18 = icmp eq i8 %2, 10, !dbg !989
  %inc = zext i1 %cmp18 to i32, !dbg !990
  %spec.select = add nsw i32 %i.041.reg2mem21.0.load, %inc, !dbg !990
  store i32 %spec.select, ptr %i.1.reg2mem17, align 4
  br label %if.end21, !dbg !990

if.end21:                                         ; preds = %land.lhs.true10.if.end21_crit_edge, %land.rhs.if.end21_crit_edge, %land.lhs.true15
    #dbg_value(i32 %i.1.reg2mem17.0.load, !715, !DIExpression(), !976)
  %i.1.reg2mem17.0.load = load i32, ptr %i.1.reg2mem17, align 4
  %incdec.ptr = getelementptr inbounds i8, ptr %s.addr.040.reg2mem19.0.s.addr.040.reload20, i64 1, !dbg !991
    #dbg_value(ptr %incdec.ptr, !709, !DIExpression(), !976)
  %cmp4 = icmp slt i32 %i.1.reg2mem17.0.load, %n, !dbg !992
  br i1 %cmp4, label %if.end21.land.rhs_crit_edge, label %if.end21.while.end_crit_edge, !dbg !993, !llvm.loop !994

if.end21.land.rhs_crit_edge:                      ; preds = %if.end21
  store ptr %incdec.ptr, ptr %s.addr.040.reg2mem19, align 8
  store i32 %i.1.reg2mem17.0.load, ptr %i.041.reg2mem21, align 4
  br label %land.rhs, !dbg !993

if.end21.while.end_crit_edge:                     ; preds = %if.end21
  %.pre = load i8, ptr %incdec.ptr, align 1, !dbg !996, !tbaa !373
  %3 = icmp eq i8 %.pre, 0, !dbg !997
  %4 = select i1 %3, i64 0, i64 2, !dbg !998
  store ptr %incdec.ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  store i64 %4, ptr %cmp23.not.reg2mem, align 8
  br label %while.end, !dbg !993

while.end:                                        ; preds = %land.rhs.while.end_crit_edge, %if.end21.while.end_crit_edge
  %cmp23.not.reg2mem.0.load = load i64, ptr %cmp23.not.reg2mem, align 8
  %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload = load ptr, ptr %s.addr.0.lcssa.ph.reg2mem, align 8
  %spec.select38 = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.reg2mem.0.s.addr.0.lcssa.ph.reload, i64 %cmp23.not.reg2mem.0.load, !dbg !998
  store ptr %spec.select38, ptr %retval.0.reg2mem, align 8
  br label %cleanup, !dbg !998

cleanup:                                          ; preds = %if.end.cleanup_crit_edge, %while.end
  %retval.0.reg2mem.0.retval.0.reload = load ptr, ptr %retval.0.reg2mem, align 8
  ret ptr %retval.0.reg2mem.0.retval.0.reload, !dbg !999
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_string(ptr noundef readonly %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1000 {
entry.split:
  %indvars.iv.reg2mem16 = alloca i64, align 8
  %.reg2mem18 = alloca i8, align 1
    #dbg_value(ptr %s, !1004, !DIExpression(), !1008)
    #dbg_value(ptr %arr, !1005, !DIExpression(), !1008)
    #dbg_value(i32 %n, !1006, !DIExpression(), !1008)
  %cmp.not = icmp eq ptr %s, null, !dbg !1009
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1009

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 79, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_string) #22, !dbg !1009
  unreachable, !dbg !1009

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1012
  br i1 %cmp1, label %while.cond.preheader, label %if.end39.thread, !dbg !1014

while.cond.preheader:                             ; preds = %if.end
  %.pre = load i8, ptr %s, align 1, !dbg !1015
  %invariant.gep = getelementptr i8, ptr %s, i64 2, !dbg !1017
  store i64 0, ptr %indvars.iv.reg2mem16, align 8
  store i8 %.pre, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !1017

if.end39.thread:                                  ; preds = %if.end
    #dbg_value(i32 %n, !1007, !DIExpression(), !1008)
  %conv404 = zext nneg i32 %n to i64, !dbg !1018
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv404, i1 false), !dbg !1019
  br label %if.end46, !dbg !1020

while.cond:                                       ; preds = %land.rhs.while.cond_crit_edge, %while.cond.preheader
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !1007, !DIExpression(), !1008)
  %.reg2mem18.0.load = load i8, ptr %.reg2mem18, align 1
  %indvars.iv.reg2mem16.0.load = load i64, ptr %indvars.iv.reg2mem16, align 8
  %cmp3.not = icmp eq i8 %.reg2mem18.0.load, 0, !dbg !1021
  br i1 %cmp3.not, label %while.cond.if.end39_crit_edge, label %land.lhs.true5, !dbg !1022

while.cond.if.end39_crit_edge:                    ; preds = %while.cond
  br label %if.end39, !dbg !1022

land.lhs.true5:                                   ; preds = %while.cond
  %indvars.iv.next = add nuw i64 %indvars.iv.reg2mem16.0.load, 1, !dbg !1023
  %arrayidx7 = getelementptr inbounds i8, ptr %s, i64 %indvars.iv.next, !dbg !1024
  %0 = load i8, ptr %arrayidx7, align 1, !dbg !1024
  %cmp9.not = icmp eq i8 %0, 0, !dbg !1025
  br i1 %cmp9.not, label %land.lhs.true5.if.end39split_crit_edge, label %land.lhs.true11, !dbg !1026

land.lhs.true5.if.end39split_crit_edge:           ; preds = %land.lhs.true5
  br label %if.end39split, !dbg !1026

land.lhs.true11:                                  ; preds = %land.lhs.true5
  %gep = getelementptr i8, ptr %invariant.gep, i64 %indvars.iv.reg2mem16.0.load, !dbg !1027
  %1 = load i8, ptr %gep, align 1, !dbg !1027
  %cmp16.not = icmp eq i8 %1, 0, !dbg !1028
  br i1 %cmp16.not, label %land.lhs.true11.if.end39splitsplit_crit_edge, label %land.rhs, !dbg !1029

land.lhs.true11.if.end39splitsplit_crit_edge:     ; preds = %land.lhs.true11
  br label %if.end39splitsplit, !dbg !1029

land.rhs:                                         ; preds = %land.lhs.true11
  %cmp21 = icmp eq i8 %.reg2mem18.0.load, 10, !dbg !1030
  %cmp28 = icmp eq i8 %0, 37
  %or.cond = and i1 %cmp21, %cmp28, !dbg !1031
  %cmp35 = icmp eq i8 %1, 37
  %or.cond65 = and i1 %or.cond, %cmp35, !dbg !1031
  br i1 %or.cond65, label %if.end39splitsplitsplit, label %land.rhs.while.cond_crit_edge, !dbg !1031, !llvm.loop !1032

land.rhs.while.cond_crit_edge:                    ; preds = %land.rhs
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem16, align 8
  store i8 %0, ptr %.reg2mem18, align 1
  br label %while.cond, !dbg !1031

if.end39splitsplitsplit:                          ; preds = %land.rhs
  br label %if.end39splitsplit, !dbg !1018

if.end39splitsplit:                               ; preds = %if.end39splitsplitsplit, %land.lhs.true11.if.end39splitsplit_crit_edge
  br label %if.end39split, !dbg !1018

if.end39split:                                    ; preds = %if.end39splitsplit, %land.lhs.true5.if.end39split_crit_edge
  br label %if.end39, !dbg !1018

if.end39:                                         ; preds = %if.end39split, %while.cond.if.end39_crit_edge
  %conv40 = and i64 %indvars.iv.reg2mem16.0.load, 4294967295, !dbg !1018
    #dbg_value(i64 %indvars.iv.reg2mem16.0.load, !1007, !DIExpression(), !1008)
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 1 %arr, ptr nonnull align 1 %s, i64 %conv40, i1 false), !dbg !1019
  %arrayidx45 = getelementptr inbounds i8, ptr %arr, i64 %conv40, !dbg !1034
  store i8 0, ptr %arrayidx45, align 1, !dbg !1036, !tbaa !373
  br label %if.end46, !dbg !1034

if.end46:                                         ; preds = %if.end39.thread, %if.end39
  ret i32 0, !dbg !1037
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #15

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1038 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1049
    #dbg_assign(i1 undef, !1046, !DIExpression(), !1049, ptr %endptr, !DIExpression(), !1050)
    #dbg_value(ptr %s, !1042, !DIExpression(), !1050)
    #dbg_value(ptr %arr, !1043, !DIExpression(), !1050)
    #dbg_value(i32 %n, !1044, !DIExpression(), !1050)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1051
    #dbg_value(i32 0, !1047, !DIExpression(), !1050)
  %cmp.not = icmp eq ptr %s, null, !dbg !1052
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1052

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 132, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint8_t_array) #22, !dbg !1052
  unreachable, !dbg !1052

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #21, !dbg !1051
    #dbg_value(ptr %call, !1045, !DIExpression(), !1050)
    #dbg_value(i32 0, !1047, !DIExpression(), !1050)
  %cmp130 = icmp ne ptr %call, null, !dbg !1051
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1051
  %0 = and i1 %cmp231, %cmp130, !dbg !1051
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1051

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1051

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1051
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1051

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1045, !DIExpression(), !1050)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1047, !DIExpression(), !1050)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1055, !tbaa !1057, !DIAssignID !1059
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1046, !DIExpression(), !1059, ptr %endptr, !DIExpression(), !1050)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #21, !dbg !1055
  %conv = trunc i64 %call3 to i8, !dbg !1055
    #dbg_value(i8 %conv, !1048, !DIExpression(), !1050)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1060, !tbaa !1057
  %3 = load i8, ptr %2, align 1, !dbg !1060, !tbaa !373
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1060
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1055

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1055

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1062, !tbaa !1057
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1062
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #24, !dbg !1062
  br label %if.end9, !dbg !1062

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1055
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1055, !tbaa !373
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1055
    #dbg_value(i64 %indvars.iv.next, !1047, !DIExpression(), !1050)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #25, !dbg !1055
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1055
  store i8 10, ptr %arrayidx11, align 1, !dbg !1055, !tbaa !373
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #21, !dbg !1055
    #dbg_value(ptr %call12, !1045, !DIExpression(), !1050)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1051
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1051
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1051
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1051, !llvm.loop !1064

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1051

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1051

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1051

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1051

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #25, !dbg !1065
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1065
  store i8 10, ptr %arrayidx17, align 1, !dbg !1065, !tbaa !373
  br label %if.end18, !dbg !1065

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1051
  ret i32 0, !dbg !1051
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1068 ptr @strtok(ptr noundef, ptr nocapture noundef readonly) local_unnamed_addr #16

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1074 i64 @strtol(ptr noundef readonly, ptr nocapture noundef, i32 noundef signext) local_unnamed_addr #16

; Function Attrs: nofree nounwind
declare !dbg !1079 noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #11

; Function Attrs: mustprogress nofree nounwind willreturn memory(argmem: read)
declare !dbg !1134 i64 @strlen(ptr nocapture noundef) local_unnamed_addr #17

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1137 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1149
    #dbg_assign(i1 undef, !1146, !DIExpression(), !1149, ptr %endptr, !DIExpression(), !1150)
    #dbg_value(ptr %s, !1142, !DIExpression(), !1150)
    #dbg_value(ptr %arr, !1143, !DIExpression(), !1150)
    #dbg_value(i32 %n, !1144, !DIExpression(), !1150)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1151
    #dbg_value(i32 0, !1147, !DIExpression(), !1150)
  %cmp.not = icmp eq ptr %s, null, !dbg !1152
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1152

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 133, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint16_t_array) #22, !dbg !1152
  unreachable, !dbg !1152

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #21, !dbg !1151
    #dbg_value(ptr %call, !1145, !DIExpression(), !1150)
    #dbg_value(i32 0, !1147, !DIExpression(), !1150)
  %cmp130 = icmp ne ptr %call, null, !dbg !1151
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1151
  %0 = and i1 %cmp231, %cmp130, !dbg !1151
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1151

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1151

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1151
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1151

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1145, !DIExpression(), !1150)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1147, !DIExpression(), !1150)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1155, !tbaa !1057, !DIAssignID !1157
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1146, !DIExpression(), !1157, ptr %endptr, !DIExpression(), !1150)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #21, !dbg !1155
  %conv = trunc i64 %call3 to i16, !dbg !1155
    #dbg_value(i16 %conv, !1148, !DIExpression(), !1150)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1158, !tbaa !1057
  %3 = load i8, ptr %2, align 1, !dbg !1158, !tbaa !373
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1158
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1155

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1155

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1160, !tbaa !1057
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1160
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #24, !dbg !1160
  br label %if.end9, !dbg !1160

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1155
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1155, !tbaa !1162
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1155
    #dbg_value(i64 %indvars.iv.next, !1147, !DIExpression(), !1150)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #25, !dbg !1155
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1155
  store i8 10, ptr %arrayidx11, align 1, !dbg !1155, !tbaa !373
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #21, !dbg !1155
    #dbg_value(ptr %call12, !1145, !DIExpression(), !1150)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1151
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1151
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1151
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1151, !llvm.loop !1164

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1151

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1151

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1151

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1151

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #25, !dbg !1165
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1165
  store i8 10, ptr %arrayidx17, align 1, !dbg !1165, !tbaa !373
  br label %if.end18, !dbg !1165

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1151
  ret i32 0, !dbg !1151
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1168 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1180
    #dbg_assign(i1 undef, !1177, !DIExpression(), !1180, ptr %endptr, !DIExpression(), !1181)
    #dbg_value(ptr %s, !1173, !DIExpression(), !1181)
    #dbg_value(ptr %arr, !1174, !DIExpression(), !1181)
    #dbg_value(i32 %n, !1175, !DIExpression(), !1181)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1182
    #dbg_value(i32 0, !1178, !DIExpression(), !1181)
  %cmp.not = icmp eq ptr %s, null, !dbg !1183
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1183

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 134, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint32_t_array) #22, !dbg !1183
  unreachable, !dbg !1183

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #21, !dbg !1182
    #dbg_value(ptr %call, !1176, !DIExpression(), !1181)
    #dbg_value(i32 0, !1178, !DIExpression(), !1181)
  %cmp130 = icmp ne ptr %call, null, !dbg !1182
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1182
  %0 = and i1 %cmp231, %cmp130, !dbg !1182
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1182

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1182

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1182
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1182

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1176, !DIExpression(), !1181)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1178, !DIExpression(), !1181)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1186, !tbaa !1057, !DIAssignID !1188
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1177, !DIExpression(), !1188, ptr %endptr, !DIExpression(), !1181)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #21, !dbg !1186
  %conv = trunc i64 %call3 to i32, !dbg !1186
    #dbg_value(i32 %conv, !1179, !DIExpression(), !1181)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1189, !tbaa !1057
  %3 = load i8, ptr %2, align 1, !dbg !1189, !tbaa !373
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1189
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1186

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1186

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1191, !tbaa !1057
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1191
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #24, !dbg !1191
  br label %if.end9, !dbg !1191

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1186
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1186, !tbaa !1193
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1186
    #dbg_value(i64 %indvars.iv.next, !1178, !DIExpression(), !1181)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #25, !dbg !1186
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1186
  store i8 10, ptr %arrayidx11, align 1, !dbg !1186, !tbaa !373
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #21, !dbg !1186
    #dbg_value(ptr %call12, !1176, !DIExpression(), !1181)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1182
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1182
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1182
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1182, !llvm.loop !1195

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1182

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1182

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1182

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1182

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #25, !dbg !1196
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1196
  store i8 10, ptr %arrayidx17, align 1, !dbg !1196, !tbaa !373
  br label %if.end18, !dbg !1196

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1182
  ret i32 0, !dbg !1182
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_uint64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1199 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1211
    #dbg_assign(i1 undef, !1208, !DIExpression(), !1211, ptr %endptr, !DIExpression(), !1212)
    #dbg_value(ptr %s, !1204, !DIExpression(), !1212)
    #dbg_value(ptr %arr, !1205, !DIExpression(), !1212)
    #dbg_value(i32 %n, !1206, !DIExpression(), !1212)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1213
    #dbg_value(i32 0, !1209, !DIExpression(), !1212)
  %cmp.not = icmp eq ptr %s, null, !dbg !1214
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1214

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 135, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_uint64_t_array) #22, !dbg !1214
  unreachable, !dbg !1214

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #21, !dbg !1213
    #dbg_value(ptr %call, !1207, !DIExpression(), !1212)
    #dbg_value(i32 0, !1209, !DIExpression(), !1212)
  %cmp129 = icmp ne ptr %call, null, !dbg !1213
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1213
  %0 = and i1 %cmp230, %cmp129, !dbg !1213
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1213

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1213

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1213
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1213

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1207, !DIExpression(), !1212)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1209, !DIExpression(), !1212)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1217, !tbaa !1057, !DIAssignID !1219
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1208, !DIExpression(), !1219, ptr %endptr, !DIExpression(), !1212)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #21, !dbg !1217
    #dbg_value(i64 %call3, !1210, !DIExpression(), !1212)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1220, !tbaa !1057
  %3 = load i8, ptr %2, align 1, !dbg !1220, !tbaa !373
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1220
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1217

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1217

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1222, !tbaa !1057
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1222
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #24, !dbg !1222
  br label %if.end8, !dbg !1222

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1217
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1217, !tbaa !1224
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1217
    #dbg_value(i64 %indvars.iv.next, !1209, !DIExpression(), !1212)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #25, !dbg !1217
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1217
  store i8 10, ptr %arrayidx10, align 1, !dbg !1217, !tbaa !373
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #21, !dbg !1217
    #dbg_value(ptr %call11, !1207, !DIExpression(), !1212)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1213
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1213
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1213
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1213, !llvm.loop !1226

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1213

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1213

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1213

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1213

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #25, !dbg !1227
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1227
  store i8 10, ptr %arrayidx16, align 1, !dbg !1227, !tbaa !373
  br label %if.end17, !dbg !1227

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1213
  ret i32 0, !dbg !1213
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int8_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1230 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1242
    #dbg_assign(i1 undef, !1239, !DIExpression(), !1242, ptr %endptr, !DIExpression(), !1243)
    #dbg_value(ptr %s, !1235, !DIExpression(), !1243)
    #dbg_value(ptr %arr, !1236, !DIExpression(), !1243)
    #dbg_value(i32 %n, !1237, !DIExpression(), !1243)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1244
    #dbg_value(i32 0, !1240, !DIExpression(), !1243)
  %cmp.not = icmp eq ptr %s, null, !dbg !1245
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1245

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 136, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int8_t_array) #22, !dbg !1245
  unreachable, !dbg !1245

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #21, !dbg !1244
    #dbg_value(ptr %call, !1238, !DIExpression(), !1243)
    #dbg_value(i32 0, !1240, !DIExpression(), !1243)
  %cmp130 = icmp ne ptr %call, null, !dbg !1244
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1244
  %0 = and i1 %cmp231, %cmp130, !dbg !1244
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1244

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1244

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1244
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1244

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1238, !DIExpression(), !1243)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1240, !DIExpression(), !1243)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1248, !tbaa !1057, !DIAssignID !1250
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1239, !DIExpression(), !1250, ptr %endptr, !DIExpression(), !1243)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #21, !dbg !1248
  %conv = trunc i64 %call3 to i8, !dbg !1248
    #dbg_value(i8 %conv, !1241, !DIExpression(), !1243)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1251, !tbaa !1057
  %3 = load i8, ptr %2, align 1, !dbg !1251, !tbaa !373
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1251
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1248

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1248

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1253, !tbaa !1057
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1253
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #24, !dbg !1253
  br label %if.end9, !dbg !1253

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1248
  store i8 %conv, ptr %arrayidx, align 1, !dbg !1248, !tbaa !373
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1248
    #dbg_value(i64 %indvars.iv.next, !1240, !DIExpression(), !1243)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #25, !dbg !1248
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1248
  store i8 10, ptr %arrayidx11, align 1, !dbg !1248, !tbaa !373
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #21, !dbg !1248
    #dbg_value(ptr %call12, !1238, !DIExpression(), !1243)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1244
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1244
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1244
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1244, !llvm.loop !1255

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1244

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1244

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1244

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1244

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #25, !dbg !1256
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1256
  store i8 10, ptr %arrayidx17, align 1, !dbg !1256, !tbaa !373
  br label %if.end18, !dbg !1256

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1244
  ret i32 0, !dbg !1244
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int16_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1259 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1271
    #dbg_assign(i1 undef, !1268, !DIExpression(), !1271, ptr %endptr, !DIExpression(), !1272)
    #dbg_value(ptr %s, !1264, !DIExpression(), !1272)
    #dbg_value(ptr %arr, !1265, !DIExpression(), !1272)
    #dbg_value(i32 %n, !1266, !DIExpression(), !1272)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1273
    #dbg_value(i32 0, !1269, !DIExpression(), !1272)
  %cmp.not = icmp eq ptr %s, null, !dbg !1274
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1274

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 137, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int16_t_array) #22, !dbg !1274
  unreachable, !dbg !1274

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #21, !dbg !1273
    #dbg_value(ptr %call, !1267, !DIExpression(), !1272)
    #dbg_value(i32 0, !1269, !DIExpression(), !1272)
  %cmp130 = icmp ne ptr %call, null, !dbg !1273
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1273
  %0 = and i1 %cmp231, %cmp130, !dbg !1273
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1273

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1273

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1273
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1273

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1267, !DIExpression(), !1272)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1269, !DIExpression(), !1272)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1277, !tbaa !1057, !DIAssignID !1279
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1268, !DIExpression(), !1279, ptr %endptr, !DIExpression(), !1272)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #21, !dbg !1277
  %conv = trunc i64 %call3 to i16, !dbg !1277
    #dbg_value(i16 %conv, !1270, !DIExpression(), !1272)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1280, !tbaa !1057
  %3 = load i8, ptr %2, align 1, !dbg !1280, !tbaa !373
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1280
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1277

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1277

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1282, !tbaa !1057
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1282
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #24, !dbg !1282
  br label %if.end9, !dbg !1282

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1277
  store i16 %conv, ptr %arrayidx, align 2, !dbg !1277, !tbaa !1162
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1277
    #dbg_value(i64 %indvars.iv.next, !1269, !DIExpression(), !1272)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #25, !dbg !1277
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1277
  store i8 10, ptr %arrayidx11, align 1, !dbg !1277, !tbaa !373
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #21, !dbg !1277
    #dbg_value(ptr %call12, !1267, !DIExpression(), !1272)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1273
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1273
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1273
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1273, !llvm.loop !1284

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1273

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1273

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1273

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1273

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #25, !dbg !1285
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1285
  store i8 10, ptr %arrayidx17, align 1, !dbg !1285, !tbaa !373
  br label %if.end18, !dbg !1285

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1273
  ret i32 0, !dbg !1273
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int32_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1288 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1300
    #dbg_assign(i1 undef, !1297, !DIExpression(), !1300, ptr %endptr, !DIExpression(), !1301)
    #dbg_value(ptr %s, !1293, !DIExpression(), !1301)
    #dbg_value(ptr %arr, !1294, !DIExpression(), !1301)
    #dbg_value(i32 %n, !1295, !DIExpression(), !1301)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.033.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1302
    #dbg_value(i32 0, !1298, !DIExpression(), !1301)
  %cmp.not = icmp eq ptr %s, null, !dbg !1303
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1303

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 138, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int32_t_array) #22, !dbg !1303
  unreachable, !dbg !1303

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #21, !dbg !1302
    #dbg_value(ptr %call, !1296, !DIExpression(), !1301)
    #dbg_value(i32 0, !1298, !DIExpression(), !1301)
  %cmp130 = icmp ne ptr %call, null, !dbg !1302
  %cmp231 = icmp sgt i32 %n, 0, !dbg !1302
  %0 = and i1 %cmp231, %cmp130, !dbg !1302
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1302

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp130, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1302

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1302
  store ptr %call, ptr %line.033.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1302

while.body:                                       ; preds = %if.end9.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.033.reg2mem25.0.line.033.reload26, !1296, !DIExpression(), !1301)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1298, !DIExpression(), !1301)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.033.reg2mem25.0.line.033.reload26 = load ptr, ptr %line.033.reg2mem25, align 8
  store ptr %line.033.reg2mem25.0.line.033.reload26, ptr %endptr, align 8, !dbg !1306, !tbaa !1057, !DIAssignID !1308
    #dbg_assign(ptr %line.033.reg2mem25.0.line.033.reload26, !1297, !DIExpression(), !1308, ptr %endptr, !DIExpression(), !1301)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.033.reg2mem25.0.line.033.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #21, !dbg !1306
  %conv = trunc i64 %call3 to i32, !dbg !1306
    #dbg_value(i32 %conv, !1299, !DIExpression(), !1301)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1309, !tbaa !1057
  %3 = load i8, ptr %2, align 1, !dbg !1309, !tbaa !373
  %cmp5.not = icmp eq i8 %3, 0, !dbg !1309
  br i1 %cmp5.not, label %while.body.if.end9_crit_edge, label %if.then7, !dbg !1306

while.body.if.end9_crit_edge:                     ; preds = %while.body
  br label %if.end9, !dbg !1306

if.then7:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1311, !tbaa !1057
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1311
  %call8 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #24, !dbg !1311
  br label %if.end9, !dbg !1311

if.end9:                                          ; preds = %while.body.if.end9_crit_edge, %if.then7
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1306
  store i32 %conv, ptr %arrayidx, align 4, !dbg !1306, !tbaa !1193
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1306
    #dbg_value(i64 %indvars.iv.next, !1298, !DIExpression(), !1301)
  %call10 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.033.reg2mem25.0.line.033.reload26) #25, !dbg !1306
  %arrayidx11 = getelementptr inbounds i8, ptr %line.033.reg2mem25.0.line.033.reload26, i64 %call10, !dbg !1306
  store i8 10, ptr %arrayidx11, align 1, !dbg !1306, !tbaa !373
  %call12 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #21, !dbg !1306
    #dbg_value(ptr %call12, !1296, !DIExpression(), !1301)
  %cmp1 = icmp ne ptr %call12, null, !dbg !1302
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1302
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1302
  br i1 %6, label %if.end9.while.body_crit_edge, label %if.end9.while.end_crit_edge, !dbg !1302, !llvm.loop !1313

if.end9.while.end_crit_edge:                      ; preds = %if.end9
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call12, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1302

if.end9.while.body_crit_edge:                     ; preds = %if.end9
  store ptr %call12, ptr %line.033.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1302

while.end:                                        ; preds = %if.end9.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then15, label %while.end.if.end18_crit_edge, !dbg !1302

while.end.if.end18_crit_edge:                     ; preds = %while.end
  br label %if.end18, !dbg !1302

if.then15:                                        ; preds = %while.end
  %call16 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #25, !dbg !1314
  %arrayidx17 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call16, !dbg !1314
  store i8 10, ptr %arrayidx17, align 1, !dbg !1314, !tbaa !373
  br label %if.end18, !dbg !1314

if.end18:                                         ; preds = %while.end.if.end18_crit_edge, %if.then15
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1302
  ret i32 0, !dbg !1302
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_int64_t_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1317 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1329
    #dbg_assign(i1 undef, !1326, !DIExpression(), !1329, ptr %endptr, !DIExpression(), !1330)
    #dbg_value(ptr %s, !1322, !DIExpression(), !1330)
    #dbg_value(ptr %arr, !1323, !DIExpression(), !1330)
    #dbg_value(i32 %n, !1324, !DIExpression(), !1330)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1331
    #dbg_value(i32 0, !1327, !DIExpression(), !1330)
  %cmp.not = icmp eq ptr %s, null, !dbg !1332
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1332

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 139, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_int64_t_array) #22, !dbg !1332
  unreachable, !dbg !1332

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #21, !dbg !1331
    #dbg_value(ptr %call, !1325, !DIExpression(), !1330)
    #dbg_value(i32 0, !1327, !DIExpression(), !1330)
  %cmp129 = icmp ne ptr %call, null, !dbg !1331
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1331
  %0 = and i1 %cmp230, %cmp129, !dbg !1331
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1331

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1331

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1331
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1331

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1325, !DIExpression(), !1330)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1327, !DIExpression(), !1330)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1335, !tbaa !1057, !DIAssignID !1337
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1326, !DIExpression(), !1337, ptr %endptr, !DIExpression(), !1330)
  %call3 = call i64 @strtol(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr, i32 noundef signext 10) #21, !dbg !1335
    #dbg_value(i64 %call3, !1328, !DIExpression(), !1330)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1338, !tbaa !1057
  %3 = load i8, ptr %2, align 1, !dbg !1338, !tbaa !373
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1338
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1335

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1335

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1340, !tbaa !1057
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1340
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #24, !dbg !1340
  br label %if.end8, !dbg !1340

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1335
  store i64 %call3, ptr %arrayidx, align 8, !dbg !1335, !tbaa !1224
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1335
    #dbg_value(i64 %indvars.iv.next, !1327, !DIExpression(), !1330)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #25, !dbg !1335
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1335
  store i8 10, ptr %arrayidx10, align 1, !dbg !1335, !tbaa !373
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #21, !dbg !1335
    #dbg_value(ptr %call11, !1325, !DIExpression(), !1330)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1331
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1331
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1331
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1331, !llvm.loop !1342

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1331

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1331

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1331

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1331

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #25, !dbg !1343
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1343
  store i8 10, ptr %arrayidx16, align 1, !dbg !1343, !tbaa !373
  br label %if.end17, !dbg !1343

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1331
  ret i32 0, !dbg !1331
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_float_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1346 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1358
    #dbg_assign(i1 undef, !1355, !DIExpression(), !1358, ptr %endptr, !DIExpression(), !1359)
    #dbg_value(ptr %s, !1351, !DIExpression(), !1359)
    #dbg_value(ptr %arr, !1352, !DIExpression(), !1359)
    #dbg_value(i32 %n, !1353, !DIExpression(), !1359)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1360
    #dbg_value(i32 0, !1356, !DIExpression(), !1359)
  %cmp.not = icmp eq ptr %s, null, !dbg !1361
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1361

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 141, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_float_array) #22, !dbg !1361
  unreachable, !dbg !1361

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #21, !dbg !1360
    #dbg_value(ptr %call, !1354, !DIExpression(), !1359)
    #dbg_value(i32 0, !1356, !DIExpression(), !1359)
  %cmp129 = icmp ne ptr %call, null, !dbg !1360
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1360
  %0 = and i1 %cmp230, %cmp129, !dbg !1360
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1360

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1360

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1360
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1360

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1354, !DIExpression(), !1359)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1356, !DIExpression(), !1359)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1364, !tbaa !1057, !DIAssignID !1366
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1355, !DIExpression(), !1366, ptr %endptr, !DIExpression(), !1359)
  %call3 = call float @strtof(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #21, !dbg !1364
    #dbg_value(float %call3, !1357, !DIExpression(), !1359)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1367, !tbaa !1057
  %3 = load i8, ptr %2, align 1, !dbg !1367, !tbaa !373
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1367
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1364

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1364

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1369, !tbaa !1057
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1369
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #24, !dbg !1369
  br label %if.end8, !dbg !1369

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1364
  store float %call3, ptr %arrayidx, align 4, !dbg !1364, !tbaa !1371
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1364
    #dbg_value(i64 %indvars.iv.next, !1356, !DIExpression(), !1359)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #25, !dbg !1364
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1364
  store i8 10, ptr %arrayidx10, align 1, !dbg !1364, !tbaa !373
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #21, !dbg !1364
    #dbg_value(ptr %call11, !1354, !DIExpression(), !1359)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1360
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1360
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1360
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1360, !llvm.loop !1373

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1360

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1360

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1360

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1360

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #25, !dbg !1374
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1374
  store i8 10, ptr %arrayidx16, align 1, !dbg !1374, !tbaa !373
  br label %if.end17, !dbg !1374

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1360
  ret i32 0, !dbg !1360
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1377 float @strtof(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #16

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @parse_double_array(ptr noundef %s, ptr nocapture noundef writeonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1380 {
entry.split:
  %endptr = alloca ptr, align 8, !DIAssignID !1392
    #dbg_assign(i1 undef, !1389, !DIExpression(), !1392, ptr %endptr, !DIExpression(), !1393)
    #dbg_value(ptr %s, !1385, !DIExpression(), !1393)
    #dbg_value(ptr %arr, !1386, !DIExpression(), !1393)
    #dbg_value(i32 %n, !1387, !DIExpression(), !1393)
  %cmp1.lcssa.reg2mem = alloca i1, align 1
  %line.0.lcssa.reg2mem23 = alloca ptr, align 8
  %line.032.reg2mem25 = alloca ptr, align 8
  %indvars.iv.reg2mem27 = alloca i64, align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1394
    #dbg_value(i32 0, !1390, !DIExpression(), !1393)
  %cmp.not = icmp eq ptr %s, null, !dbg !1395
  br i1 %cmp.not, label %if.else, label %if.end, !dbg !1395

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.12, ptr noundef nonnull @.str.2, i32 noundef signext 142, ptr noundef nonnull @__PRETTY_FUNCTION__.parse_double_array) #22, !dbg !1395
  unreachable, !dbg !1395

if.end:                                           ; preds = %entry.split
  %call = tail call ptr @strtok(ptr noundef nonnull %s, ptr noundef nonnull @.str.13) #21, !dbg !1394
    #dbg_value(ptr %call, !1388, !DIExpression(), !1393)
    #dbg_value(i32 0, !1390, !DIExpression(), !1393)
  %cmp129 = icmp ne ptr %call, null, !dbg !1394
  %cmp230 = icmp sgt i32 %n, 0, !dbg !1394
  %0 = and i1 %cmp230, %cmp129, !dbg !1394
  br i1 %0, label %while.body.preheader, label %if.end.while.end_crit_edge, !dbg !1394

if.end.while.end_crit_edge:                       ; preds = %if.end
  store i1 %cmp129, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1394

while.body.preheader:                             ; preds = %if.end
  %1 = zext nneg i32 %n to i64, !dbg !1394
  store ptr %call, ptr %line.032.reg2mem25, align 8
  store i64 0, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1394

while.body:                                       ; preds = %if.end8.while.body_crit_edge, %while.body.preheader
    #dbg_value(ptr %line.032.reg2mem25.0.line.032.reload26, !1388, !DIExpression(), !1393)
    #dbg_value(i64 %indvars.iv.reg2mem27.0.load, !1390, !DIExpression(), !1393)
  %indvars.iv.reg2mem27.0.load = load i64, ptr %indvars.iv.reg2mem27, align 8
  %line.032.reg2mem25.0.line.032.reload26 = load ptr, ptr %line.032.reg2mem25, align 8
  store ptr %line.032.reg2mem25.0.line.032.reload26, ptr %endptr, align 8, !dbg !1398, !tbaa !1057, !DIAssignID !1400
    #dbg_assign(ptr %line.032.reg2mem25.0.line.032.reload26, !1389, !DIExpression(), !1400, ptr %endptr, !DIExpression(), !1393)
  %call3 = call double @strtod(ptr noundef nonnull %line.032.reg2mem25.0.line.032.reload26, ptr noundef nonnull %endptr) #21, !dbg !1398
    #dbg_value(double %call3, !1391, !DIExpression(), !1393)
  %2 = load ptr, ptr %endptr, align 8, !dbg !1401, !tbaa !1057
  %3 = load i8, ptr %2, align 1, !dbg !1401, !tbaa !373
  %cmp4.not = icmp eq i8 %3, 0, !dbg !1401
  br i1 %cmp4.not, label %while.body.if.end8_crit_edge, label %if.then6, !dbg !1398

while.body.if.end8_crit_edge:                     ; preds = %while.body
  br label %if.end8, !dbg !1398

if.then6:                                         ; preds = %while.body
  %4 = load ptr, ptr @stderr, align 8, !dbg !1403, !tbaa !1057
  %5 = trunc i64 %indvars.iv.reg2mem27.0.load to i32, !dbg !1403
  %call7 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %4, ptr noundef nonnull @.str.14, i32 noundef signext %5) #24, !dbg !1403
  br label %if.end8, !dbg !1403

if.end8:                                          ; preds = %while.body.if.end8_crit_edge, %if.then6
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem27.0.load, !dbg !1398
  store double %call3, ptr %arrayidx, align 8, !dbg !1398, !tbaa !1405
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem27.0.load, 1, !dbg !1398
    #dbg_value(i64 %indvars.iv.next, !1390, !DIExpression(), !1393)
  %call9 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.032.reg2mem25.0.line.032.reload26) #25, !dbg !1398
  %arrayidx10 = getelementptr inbounds i8, ptr %line.032.reg2mem25.0.line.032.reload26, i64 %call9, !dbg !1398
  store i8 10, ptr %arrayidx10, align 1, !dbg !1398, !tbaa !373
  %call11 = tail call ptr @strtok(ptr noundef null, ptr noundef nonnull @.str.13) #21, !dbg !1398
    #dbg_value(ptr %call11, !1388, !DIExpression(), !1393)
  %cmp1 = icmp ne ptr %call11, null, !dbg !1394
  %cmp2 = icmp ult i64 %indvars.iv.next, %1, !dbg !1394
  %6 = select i1 %cmp1, i1 %cmp2, i1 false, !dbg !1394
  br i1 %6, label %if.end8.while.body_crit_edge, label %if.end8.while.end_crit_edge, !dbg !1394, !llvm.loop !1407

if.end8.while.end_crit_edge:                      ; preds = %if.end8
  store i1 %cmp1, ptr %cmp1.lcssa.reg2mem, align 1
  store ptr %call11, ptr %line.0.lcssa.reg2mem23, align 8
  br label %while.end, !dbg !1394

if.end8.while.body_crit_edge:                     ; preds = %if.end8
  store ptr %call11, ptr %line.032.reg2mem25, align 8
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem27, align 8
  br label %while.body, !dbg !1394

while.end:                                        ; preds = %if.end8.while.end_crit_edge, %if.end.while.end_crit_edge
  %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24 = load ptr, ptr %line.0.lcssa.reg2mem23, align 8
  %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload = load i1, ptr %cmp1.lcssa.reg2mem, align 1
  br i1 %cmp1.lcssa.reg2mem.0.cmp1.lcssa.reload, label %if.then14, label %while.end.if.end17_crit_edge, !dbg !1394

while.end.if.end17_crit_edge:                     ; preds = %while.end
  br label %if.end17, !dbg !1394

if.then14:                                        ; preds = %while.end
  %call15 = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24) #25, !dbg !1408
  %arrayidx16 = getelementptr inbounds i8, ptr %line.0.lcssa.reg2mem23.0.line.0.lcssa.reload24, i64 %call15, !dbg !1408
  store i8 10, ptr %arrayidx16, align 1, !dbg !1408, !tbaa !373
  br label %if.end17, !dbg !1408

if.end17:                                         ; preds = %while.end.if.end17_crit_edge, %if.then14
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %endptr) #21, !dbg !1394
  ret i32 0, !dbg !1394
}

; Function Attrs: mustprogress nofree nounwind willreturn
declare !dbg !1411 double @strtod(ptr noundef readonly, ptr nocapture noundef) local_unnamed_addr #16

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_string(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1414 {
entry.split:
  %written.037.reg2mem8 = alloca i32, align 4
  %n.addr.0.reg2mem10 = alloca i32, align 4
    #dbg_value(i32 %fd, !1418, !DIExpression(), !1423)
    #dbg_value(ptr %arr, !1419, !DIExpression(), !1423)
    #dbg_value(i32 %n, !1420, !DIExpression(), !1423)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1424
  br i1 %cmp, label %if.end, label %if.else, !dbg !1424

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 147, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #22, !dbg !1424
  unreachable, !dbg !1424

if.end:                                           ; preds = %entry.split
  %cmp1 = icmp slt i32 %n, 0, !dbg !1427
  br i1 %cmp1, label %if.then2, label %if.end.if.end3_crit_edge, !dbg !1429

if.end.if.end3_crit_edge:                         ; preds = %if.end
  store i32 %n, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1429

if.then2:                                         ; preds = %if.end
  %call = tail call i64 @strlen(ptr noundef nonnull dereferenceable(1) %arr) #25, !dbg !1430
  %conv = trunc i64 %call to i32, !dbg !1430
    #dbg_value(i32 %conv, !1420, !DIExpression(), !1423)
  store i32 %conv, ptr %n.addr.0.reg2mem10, align 4
  br label %if.end3, !dbg !1432

if.end3:                                          ; preds = %if.end.if.end3_crit_edge, %if.then2
    #dbg_value(i32 %n.addr.0.reg2mem10.0.load, !1420, !DIExpression(), !1423)
    #dbg_value(i32 0, !1422, !DIExpression(), !1423)
  %n.addr.0.reg2mem10.0.load = load i32, ptr %n.addr.0.reg2mem10, align 4
  %cmp436 = icmp sgt i32 %n.addr.0.reg2mem10.0.load, 0, !dbg !1433
  br i1 %cmp436, label %if.end3.while.body_crit_edge, label %if.end3.do.body.preheader_crit_edge, !dbg !1434

if.end3.do.body.preheader_crit_edge:              ; preds = %if.end3
  br label %do.body.preheader, !dbg !1434

if.end3.while.body_crit_edge:                     ; preds = %if.end3
  store i32 0, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1434

do.body.preheader:                                ; preds = %while.cond.do.body.preheader_crit_edge, %if.end3.do.body.preheader_crit_edge
  br label %do.body, !dbg !1435

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.037.reg2mem8.0.load, %conv8, !dbg !1436
    #dbg_value(i32 %add, !1422, !DIExpression(), !1423)
  %cmp4 = icmp slt i32 %add, %n.addr.0.reg2mem10.0.load, !dbg !1433
  br i1 %cmp4, label %while.cond.while.body_crit_edge, label %while.cond.do.body.preheader_crit_edge, !dbg !1434, !llvm.loop !1438

while.cond.do.body.preheader_crit_edge:           ; preds = %while.cond
  br label %do.body.preheader, !dbg !1434

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.037.reg2mem8, align 4
  br label %while.body, !dbg !1434

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %if.end3.while.body_crit_edge
    #dbg_value(i32 %written.037.reg2mem8.0.load, !1422, !DIExpression(), !1423)
  %written.037.reg2mem8.0.load = load i32, ptr %written.037.reg2mem8, align 4
  %idxprom = zext nneg i32 %written.037.reg2mem8.0.load to i64, !dbg !1440
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %idxprom, !dbg !1440
  %sub = sub nsw i32 %n.addr.0.reg2mem10.0.load, %written.037.reg2mem8.0.load, !dbg !1441
  %conv6 = sext i32 %sub to i64, !dbg !1442
  %call7 = tail call i64 @write(i32 noundef signext %fd, ptr noundef %arrayidx, i64 noundef %conv6) #21, !dbg !1443
  %conv8 = trunc i64 %call7 to i32, !dbg !1443
    #dbg_value(i32 %conv8, !1421, !DIExpression(), !1423)
  %cmp9 = icmp sgt i32 %conv8, -1, !dbg !1444
    #dbg_value(!DIArgList(i32 %written.037.reg2mem8.0.load, i32 %conv8), !1422, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1423)
  br i1 %cmp9, label %while.cond, label %if.else13, !dbg !1444

if.else13:                                        ; preds = %while.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 154, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #22, !dbg !1444
  unreachable, !dbg !1444

do.body:                                          ; preds = %do.cond.do.body_crit_edge, %do.body.preheader
  %call15 = tail call i64 @write(i32 noundef signext %fd, ptr noundef nonnull @.str.13, i64 noundef 1) #21, !dbg !1447
  %conv16 = trunc i64 %call15 to i32, !dbg !1447
    #dbg_value(i32 %conv16, !1421, !DIExpression(), !1423)
  %cmp17 = icmp sgt i32 %conv16, -1, !dbg !1449
  br i1 %cmp17, label %do.cond, label %if.else21, !dbg !1449

if.else21:                                        ; preds = %do.body
  tail call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 160, ptr noundef nonnull @__PRETTY_FUNCTION__.write_string) #22, !dbg !1449
  unreachable, !dbg !1449

do.cond:                                          ; preds = %do.body
  %cmp23 = icmp eq i32 %conv16, 0, !dbg !1452
  br i1 %cmp23, label %do.cond.do.body_crit_edge, label %do.end, !dbg !1453, !llvm.loop !1454

do.cond.do.body_crit_edge:                        ; preds = %do.cond
  br label %do.body, !dbg !1453

do.end:                                           ; preds = %do.cond
  ret i32 0, !dbg !1456
}

; Function Attrs: nofree
declare !dbg !1457 noundef i64 @write(i32 noundef signext, ptr nocapture noundef readonly, i64 noundef) local_unnamed_addr #13

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !782 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !781, !DIExpression(), !1462)
    #dbg_value(ptr %arr, !786, !DIExpression(), !1462)
    #dbg_value(i32 %n, !787, !DIExpression(), !1462)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1463
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1463

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !788, !DIExpression(), !1462)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1466
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1467

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1467

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1466
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1467

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 177, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint8_t_array) #22, !dbg !1463
  unreachable, !dbg !1463

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !788, !DIExpression(), !1462)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1468
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1468, !tbaa !373
  %conv = zext i8 %0 to i32, !dbg !1468
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1468
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1466
    #dbg_value(i64 %indvars.iv.next, !788, !DIExpression(), !1462)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1466
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1467, !llvm.loop !1469

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1467

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1467

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1470
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @fd_printf(i32 noundef signext range(i32 2, -2147483648) %fd, ptr nocapture noundef readonly %format, ...) unnamed_addr #18 !dbg !1471 {
entry.split:
  %args = alloca ptr, align 8, !DIAssignID !1486
    #dbg_assign(i1 undef, !1477, !DIExpression(), !1486, ptr %args, !DIExpression(), !1487)
  %buffer = alloca [256 x i8], align 1, !DIAssignID !1488
    #dbg_assign(i1 undef, !1484, !DIExpression(), !1488, ptr %buffer, !DIExpression(), !1487)
    #dbg_value(i32 %fd, !1475, !DIExpression(), !1487)
    #dbg_value(ptr %format, !1476, !DIExpression(), !1487)
  %written.0.lcssa.reg2mem = alloca i32, align 4
  %written.027.reg2mem10 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %args) #21, !dbg !1489
  call void @llvm.lifetime.start.p0(i64 256, ptr nonnull %buffer) #21, !dbg !1490
  call void @llvm.va_start.p0(ptr nonnull %args), !dbg !1491
  %0 = load ptr, ptr %args, align 8, !dbg !1492, !tbaa !1057
  %call = call signext i32 @vsnprintf(ptr noundef nonnull %buffer, i64 noundef 256, ptr noundef %format, ptr noundef %0) #21, !dbg !1493
    #dbg_value(i32 %call, !1481, !DIExpression(), !1487)
  call void @llvm.va_end.p0(ptr nonnull %args), !dbg !1494
  %cmp = icmp slt i32 %call, 256, !dbg !1495
  br i1 %cmp, label %while.cond.preheader, label %if.else, !dbg !1495

while.cond.preheader:                             ; preds = %entry.split
    #dbg_value(i32 0, !1482, !DIExpression(), !1487)
  %cmp126 = icmp sgt i32 %call, 0, !dbg !1498
  br i1 %cmp126, label %while.cond.preheader.while.body_crit_edge, label %while.cond.preheader.while.end_crit_edge, !dbg !1499

while.cond.preheader.while.end_crit_edge:         ; preds = %while.cond.preheader
  store i32 0, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1499

while.cond.preheader.while.body_crit_edge:        ; preds = %while.cond.preheader
  store i32 0, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1499

if.else:                                          ; preds = %entry.split
  call void @__assert_fail(ptr noundef nonnull @.str.24, ptr noundef nonnull @.str.2, i32 noundef signext 22, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #22, !dbg !1495
  unreachable, !dbg !1495

while.cond:                                       ; preds = %while.body
  %add = add nuw nsw i32 %written.027.reg2mem10.0.load, %conv3, !dbg !1500
    #dbg_value(i32 %add, !1482, !DIExpression(), !1487)
  %cmp1 = icmp slt i32 %add, %call, !dbg !1498
  br i1 %cmp1, label %while.cond.while.body_crit_edge, label %while.cond.while.end_crit_edge, !dbg !1499, !llvm.loop !1502

while.cond.while.end_crit_edge:                   ; preds = %while.cond
  store i32 %add, ptr %written.0.lcssa.reg2mem, align 4
  br label %while.end, !dbg !1499

while.cond.while.body_crit_edge:                  ; preds = %while.cond
  store i32 %add, ptr %written.027.reg2mem10, align 4
  br label %while.body, !dbg !1499

while.body:                                       ; preds = %while.cond.while.body_crit_edge, %while.cond.preheader.while.body_crit_edge
    #dbg_value(i32 %written.027.reg2mem10.0.load, !1482, !DIExpression(), !1487)
  %written.027.reg2mem10.0.load = load i32, ptr %written.027.reg2mem10, align 4
  %idxprom = zext nneg i32 %written.027.reg2mem10.0.load to i64, !dbg !1504
  %arrayidx = getelementptr inbounds [256 x i8], ptr %buffer, i64 0, i64 %idxprom, !dbg !1504
  %sub = sub nsw i32 %call, %written.027.reg2mem10.0.load, !dbg !1505
  %conv = sext i32 %sub to i64, !dbg !1506
  %call2 = call i64 @write(i32 noundef signext %fd, ptr noundef nonnull %arrayidx, i64 noundef %conv) #21, !dbg !1507
  %conv3 = trunc i64 %call2 to i32, !dbg !1507
    #dbg_value(i32 %conv3, !1483, !DIExpression(), !1487)
  %cmp4 = icmp sgt i32 %conv3, -1, !dbg !1508
    #dbg_value(!DIArgList(i32 %written.027.reg2mem10.0.load, i32 %conv3), !1482, !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_plus, DW_OP_stack_value), !1487)
  br i1 %cmp4, label %while.cond, label %if.else8, !dbg !1508

if.else8:                                         ; preds = %while.body
  call void @__assert_fail(ptr noundef nonnull @.str.16, ptr noundef nonnull @.str.2, i32 noundef signext 26, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #22, !dbg !1508
  unreachable, !dbg !1508

while.end:                                        ; preds = %while.cond.while.end_crit_edge, %while.cond.preheader.while.end_crit_edge
  %written.0.lcssa.reg2mem.0.load = load i32, ptr %written.0.lcssa.reg2mem, align 4
  %cmp10 = icmp eq i32 %written.0.lcssa.reg2mem.0.load, %call, !dbg !1511
  br i1 %cmp10, label %if.end15, label %if.else14, !dbg !1511

if.else14:                                        ; preds = %while.end
  call void @__assert_fail(ptr noundef nonnull @.str.26, ptr noundef nonnull @.str.2, i32 noundef signext 29, ptr noundef nonnull @__PRETTY_FUNCTION__.fd_printf) #22, !dbg !1511
  unreachable, !dbg !1511

if.end15:                                         ; preds = %while.end
  call void @llvm.lifetime.end.p0(i64 256, ptr nonnull %buffer) #21, !dbg !1514
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %args) #21, !dbg !1514
  ret void, !dbg !1515
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start.p0(ptr) #19

; Function Attrs: nofree nounwind
declare !dbg !1516 noundef signext i32 @vsnprintf(ptr nocapture noundef, i64 noundef, ptr nocapture noundef readonly, ptr noundef) local_unnamed_addr #11

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end.p0(ptr) #19

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1521 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1525, !DIExpression(), !1529)
    #dbg_value(ptr %arr, !1526, !DIExpression(), !1529)
    #dbg_value(i32 %n, !1527, !DIExpression(), !1529)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1530
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1530

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1528, !DIExpression(), !1529)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1533
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1536

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1536

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1533
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1536

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 178, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint16_t_array) #22, !dbg !1530
  unreachable, !dbg !1530

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1528, !DIExpression(), !1529)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1537
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1537, !tbaa !1162
  %conv = zext i16 %0 to i32, !dbg !1537
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %conv), !dbg !1537
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1533
    #dbg_value(i64 %indvars.iv.next, !1528, !DIExpression(), !1529)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1533
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1536, !llvm.loop !1539

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1536

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1536

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1540
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1541 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1545, !DIExpression(), !1549)
    #dbg_value(ptr %arr, !1546, !DIExpression(), !1549)
    #dbg_value(i32 %n, !1547, !DIExpression(), !1549)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1550
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1550

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1548, !DIExpression(), !1549)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1553
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1556

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1556

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1553
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1556

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 179, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint32_t_array) #22, !dbg !1550
  unreachable, !dbg !1550

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1548, !DIExpression(), !1549)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1557
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1557, !tbaa !1193
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.17, i32 noundef signext %0), !dbg !1557
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1553
    #dbg_value(i64 %indvars.iv.next, !1548, !DIExpression(), !1549)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1553
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1556, !llvm.loop !1559

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1556

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1556

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1560
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_uint64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1561 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1565, !DIExpression(), !1569)
    #dbg_value(ptr %arr, !1566, !DIExpression(), !1569)
    #dbg_value(i32 %n, !1567, !DIExpression(), !1569)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1570
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1570

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1568, !DIExpression(), !1569)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1573
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1576

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1576

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1573
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1576

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 180, ptr noundef nonnull @__PRETTY_FUNCTION__.write_uint64_t_array) #22, !dbg !1570
  unreachable, !dbg !1570

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1568, !DIExpression(), !1569)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1577
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1577, !tbaa !1224
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.18, i64 noundef %0), !dbg !1577
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1573
    #dbg_value(i64 %indvars.iv.next, !1568, !DIExpression(), !1569)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1573
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1576, !llvm.loop !1579

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1576

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1576

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1580
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int8_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1581 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1585, !DIExpression(), !1589)
    #dbg_value(ptr %arr, !1586, !DIExpression(), !1589)
    #dbg_value(i32 %n, !1587, !DIExpression(), !1589)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1590
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1590

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1588, !DIExpression(), !1589)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1593
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1596

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1596

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1593
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1596

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 181, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int8_t_array) #22, !dbg !1590
  unreachable, !dbg !1590

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1588, !DIExpression(), !1589)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i8, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1597
  %0 = load i8, ptr %arrayidx, align 1, !dbg !1597, !tbaa !373
  %conv = sext i8 %0 to i32, !dbg !1597
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1597
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1593
    #dbg_value(i64 %indvars.iv.next, !1588, !DIExpression(), !1589)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1593
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1596, !llvm.loop !1599

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1596

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1596

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1600
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int16_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1601 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1605, !DIExpression(), !1609)
    #dbg_value(ptr %arr, !1606, !DIExpression(), !1609)
    #dbg_value(i32 %n, !1607, !DIExpression(), !1609)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1610
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1610

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1608, !DIExpression(), !1609)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1613
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1616

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1616

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1613
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1616

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 182, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int16_t_array) #22, !dbg !1610
  unreachable, !dbg !1610

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1608, !DIExpression(), !1609)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i16, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1617
  %0 = load i16, ptr %arrayidx, align 2, !dbg !1617, !tbaa !1162
  %conv = sext i16 %0 to i32, !dbg !1617
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %conv), !dbg !1617
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1613
    #dbg_value(i64 %indvars.iv.next, !1608, !DIExpression(), !1609)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1613
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1616, !llvm.loop !1619

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1616

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1616

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1620
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int32_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1621 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1625, !DIExpression(), !1629)
    #dbg_value(ptr %arr, !1626, !DIExpression(), !1629)
    #dbg_value(i32 %n, !1627, !DIExpression(), !1629)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1630
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1630

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1628, !DIExpression(), !1629)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1633
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1636

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1636

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1633
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1636

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 183, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int32_t_array) #22, !dbg !1630
  unreachable, !dbg !1630

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1628, !DIExpression(), !1629)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i32, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1637
  %0 = load i32, ptr %arrayidx, align 4, !dbg !1637, !tbaa !1193
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.19, i32 noundef signext %0), !dbg !1637
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1633
    #dbg_value(i64 %indvars.iv.next, !1628, !DIExpression(), !1629)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1633
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1636, !llvm.loop !1639

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1636

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1636

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1640
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_int64_t_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1641 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1645, !DIExpression(), !1649)
    #dbg_value(ptr %arr, !1646, !DIExpression(), !1649)
    #dbg_value(i32 %n, !1647, !DIExpression(), !1649)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1650
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1650

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1648, !DIExpression(), !1649)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1653
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1656

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1656

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1653
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1656

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 184, ptr noundef nonnull @__PRETTY_FUNCTION__.write_int64_t_array) #22, !dbg !1650
  unreachable, !dbg !1650

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1648, !DIExpression(), !1649)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds i64, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1657
  %0 = load i64, ptr %arrayidx, align 8, !dbg !1657, !tbaa !1224
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.20, i64 noundef %0), !dbg !1657
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1653
    #dbg_value(i64 %indvars.iv.next, !1648, !DIExpression(), !1649)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1653
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1656, !llvm.loop !1659

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1656

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1656

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1660
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_float_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1661 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1665, !DIExpression(), !1669)
    #dbg_value(ptr %arr, !1666, !DIExpression(), !1669)
    #dbg_value(i32 %n, !1667, !DIExpression(), !1669)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1670
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1670

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1668, !DIExpression(), !1669)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1673
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1676

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1676

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1673
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1676

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 186, ptr noundef nonnull @__PRETTY_FUNCTION__.write_float_array) #22, !dbg !1670
  unreachable, !dbg !1670

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1668, !DIExpression(), !1669)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds float, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1677
  %0 = load float, ptr %arrayidx, align 4, !dbg !1677, !tbaa !1371
  %conv = fpext float %0 to double, !dbg !1677
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %conv), !dbg !1677
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1673
    #dbg_value(i64 %indvars.iv.next, !1668, !DIExpression(), !1669)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1673
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1676, !llvm.loop !1679

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1676

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1676

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1680
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_double_array(i32 noundef signext %fd, ptr nocapture noundef readonly %arr, i32 noundef signext %n) local_unnamed_addr #5 !dbg !1681 {
entry.split:
  %indvars.iv.reg2mem = alloca i64, align 8
    #dbg_value(i32 %fd, !1685, !DIExpression(), !1689)
    #dbg_value(ptr %arr, !1686, !DIExpression(), !1689)
    #dbg_value(i32 %n, !1687, !DIExpression(), !1689)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1690
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !1690

for.cond.preheader:                               ; preds = %entry.split
    #dbg_value(i32 0, !1688, !DIExpression(), !1689)
  %cmp15 = icmp sgt i32 %n, 0, !dbg !1693
  br i1 %cmp15, label %for.body.preheader, label %for.cond.preheader.for.end_crit_edge, !dbg !1696

for.cond.preheader.for.end_crit_edge:             ; preds = %for.cond.preheader
  br label %for.end, !dbg !1696

for.body.preheader:                               ; preds = %for.cond.preheader
  %wide.trip.count = zext nneg i32 %n to i64, !dbg !1693
  store i64 0, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1696

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 187, ptr noundef nonnull @__PRETTY_FUNCTION__.write_double_array) #22, !dbg !1690
  unreachable, !dbg !1690

for.body:                                         ; preds = %for.body.for.body_crit_edge, %for.body.preheader
    #dbg_value(i64 %indvars.iv.reg2mem.0.load, !1688, !DIExpression(), !1689)
  %indvars.iv.reg2mem.0.load = load i64, ptr %indvars.iv.reg2mem, align 8
  %arrayidx = getelementptr inbounds double, ptr %arr, i64 %indvars.iv.reg2mem.0.load, !dbg !1697
  %0 = load double, ptr %arrayidx, align 8, !dbg !1697, !tbaa !1405
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.21, double noundef %0), !dbg !1697
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.reg2mem.0.load, 1, !dbg !1693
    #dbg_value(i64 %indvars.iv.next, !1688, !DIExpression(), !1689)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !1693
  br i1 %exitcond.not, label %for.body.for.end_crit_edge, label %for.body.for.body_crit_edge, !dbg !1696, !llvm.loop !1699

for.body.for.body_crit_edge:                      ; preds = %for.body
  store i64 %indvars.iv.next, ptr %indvars.iv.reg2mem, align 8
  br label %for.body, !dbg !1696

for.body.for.end_crit_edge:                       ; preds = %for.body
  br label %for.end, !dbg !1696

for.end:                                          ; preds = %for.body.for.end_crit_edge, %for.cond.preheader.for.end_crit_edge
  ret i32 0, !dbg !1700
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext i32 @write_section_header(i32 noundef signext %fd) local_unnamed_addr #5 !dbg !770 {
entry.split:
    #dbg_value(i32 %fd, !769, !DIExpression(), !1701)
  %cmp = icmp sgt i32 %fd, 1, !dbg !1702
  br i1 %cmp, label %if.end, label %if.else, !dbg !1702

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #22, !dbg !1702
  unreachable, !dbg !1702

if.end:                                           ; preds = %entry.split
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %fd, ptr noundef nonnull @.str.22), !dbg !1703
  ret i32 0, !dbg !1704
}

; Function Attrs: nounwind uwtable
define dso_local noundef signext range(i32 -1, 1) i32 @main(i32 noundef signext %argc, ptr nocapture noundef readonly %argv) local_unnamed_addr #5 !dbg !1705 {
entry.split:
  %retval.0.reg2mem = alloca i32, align 4
  %s.addr.0.lcssa.ph.i.i.reg2mem = alloca ptr, align 8
  %cmp23.not.i.i.reg2mem = alloca i64, align 8
  %i.1.i.i.reg2mem48 = alloca i32, align 4
  %s.addr.040.i.i.reg2mem50 = alloca ptr, align 8
  %i.041.i.i.reg2mem52 = alloca i32, align 4
  %indvars.iv.i.i.reg2mem = alloca i64, align 8
  %check_file.0.reg2mem54 = alloca ptr, align 8
  %in_file.06.reg2mem56 = alloca ptr, align 8
    #dbg_value(i32 %argc, !1709, !DIExpression(), !1718)
    #dbg_value(ptr %argv, !1710, !DIExpression(), !1718)
  %cmp = icmp slt i32 %argc, 4, !dbg !1719
  br i1 %cmp, label %if.end, label %if.else, !dbg !1719

if.else:                                          ; preds = %entry.split
  tail call void @__assert_fail(ptr noundef nonnull @.str.1.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 21, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #22, !dbg !1719
  unreachable, !dbg !1719

if.end:                                           ; preds = %entry.split
    #dbg_value(ptr @.str.3, !1711, !DIExpression(), !1718)
    #dbg_value(ptr @.str.4.13, !1712, !DIExpression(), !1718)
  %cmp1 = icmp sgt i32 %argc, 1, !dbg !1722
  br i1 %cmp1, label %if.end3, label %if.end.if.end7_crit_edge, !dbg !1724

if.end.if.end7_crit_edge:                         ; preds = %if.end
  store ptr @.str.4.13, ptr %check_file.0.reg2mem54, align 8
  store ptr @.str.3, ptr %in_file.06.reg2mem56, align 8
  br label %if.end7, !dbg !1724

if.end3:                                          ; preds = %if.end
  %arrayidx = getelementptr inbounds i8, ptr %argv, i64 8, !dbg !1725
  %0 = load ptr, ptr %arrayidx, align 8, !dbg !1725
    #dbg_value(ptr %0, !1711, !DIExpression(), !1718)
  %cmp4 = icmp eq i32 %argc, 3, !dbg !1726
  br i1 %cmp4, label %if.then5, label %if.end3.if.end7_crit_edge, !dbg !1728

if.end3.if.end7_crit_edge:                        ; preds = %if.end3
  store ptr @.str.4.13, ptr %check_file.0.reg2mem54, align 8
  store ptr %0, ptr %in_file.06.reg2mem56, align 8
  br label %if.end7, !dbg !1728

if.then5:                                         ; preds = %if.end3
  %arrayidx6 = getelementptr inbounds i8, ptr %argv, i64 16, !dbg !1729
  %1 = load ptr, ptr %arrayidx6, align 8, !dbg !1729
    #dbg_value(ptr %1, !1712, !DIExpression(), !1718)
  store ptr %1, ptr %check_file.0.reg2mem54, align 8
  store ptr %0, ptr %in_file.06.reg2mem56, align 8
  br label %if.end7, !dbg !1730

if.end7:                                          ; preds = %if.end3.if.end7_crit_edge, %if.end.if.end7_crit_edge, %if.then5
    #dbg_value(ptr %check_file.0.reg2mem54.0.check_file.0.reload55, !1712, !DIExpression(), !1718)
  %in_file.06.reg2mem56.0.in_file.06.reload57 = load ptr, ptr %in_file.06.reg2mem56, align 8
  %check_file.0.reg2mem54.0.check_file.0.reload55 = load ptr, ptr %check_file.0.reg2mem54, align 8
  %2 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1731, !tbaa !1193
  %conv = sext i32 %2 to i64, !dbg !1731
  %call = tail call noalias ptr @malloc(i64 noundef %conv) #23, !dbg !1732
    #dbg_value(ptr %call, !1714, !DIExpression(), !1718)
  %cmp8.not = icmp eq ptr %call, null, !dbg !1733
  br i1 %cmp8.not, label %if.else12, label %if.end13, !dbg !1733

if.else12:                                        ; preds = %if.end7
  tail call void @__assert_fail(ptr noundef nonnull @.str.6.14, ptr noundef nonnull @.str.2.12, i32 noundef signext 37, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #22, !dbg !1733
  unreachable, !dbg !1733

if.end13:                                         ; preds = %if.end7
  %call14 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %in_file.06.reg2mem56.0.in_file.06.reload57, i32 noundef signext 0) #21, !dbg !1736
    #dbg_value(i32 %call14, !1713, !DIExpression(), !1718)
  %cmp15 = icmp sgt i32 %call14, 0, !dbg !1737
  br i1 %cmp15, label %if.end20, label %if.else19, !dbg !1737

if.else19:                                        ; preds = %if.end13
  tail call void @__assert_fail(ptr noundef nonnull @.str.8.15, ptr noundef nonnull @.str.2.12, i32 noundef signext 39, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #22, !dbg !1737
  unreachable, !dbg !1737

if.end20:                                         ; preds = %if.end13
  tail call void @input_to_data(i32 noundef signext %call14, ptr noundef nonnull %call) #21, !dbg !1740
    #dbg_value(ptr %call, !690, !DIExpression(), !1741)
    #dbg_value(ptr %call, !691, !DIExpression(), !1741)
  %k.i = getelementptr inbounds i8, ptr %call, i64 96, !dbg !1743
  %buf.i = getelementptr inbounds i8, ptr %call, i64 128, !dbg !1744
  tail call void @aes(ptr noundef nonnull %call, ptr noundef nonnull %k.i, ptr noundef nonnull %buf.i) #21, !dbg !1745
  %call21 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef nonnull @.str.9, i32 noundef signext 577, i32 noundef signext 438) #21, !dbg !1746
    #dbg_value(i32 %call21, !1715, !DIExpression(), !1718)
  %cmp22 = icmp sgt i32 %call21, 0, !dbg !1747
  br i1 %cmp22, label %if.end27, label %if.else26, !dbg !1747

if.else26:                                        ; preds = %if.end20
  tail call void @__assert_fail(ptr noundef nonnull @.str.11, ptr noundef nonnull @.str.2.12, i32 noundef signext 48, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #22, !dbg !1747
  unreachable, !dbg !1747

if.end27:                                         ; preds = %if.end20
    #dbg_value(i32 %call21, !843, !DIExpression(), !1750)
    #dbg_value(ptr %call, !844, !DIExpression(), !1750)
    #dbg_value(ptr %call, !845, !DIExpression(), !1750)
    #dbg_value(i32 %call21, !769, !DIExpression(), !1752)
  %cmp.i.i.not = icmp eq i32 %call21, 1, !dbg !1754
  br i1 %cmp.i.i.not, label %if.else.i.i, label %for.cond.preheader.i.i, !dbg !1754

if.else.i.i:                                      ; preds = %if.end27
  tail call void @__assert_fail(ptr noundef nonnull @.str.1, ptr noundef nonnull @.str.2, i32 noundef signext 190, ptr noundef nonnull @__PRETTY_FUNCTION__.write_section_header) #22, !dbg !1754
  unreachable, !dbg !1754

for.cond.preheader.i.i:                           ; preds = %if.end27
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.22), !dbg !1755
    #dbg_value(i32 %call21, !781, !DIExpression(), !1756)
    #dbg_value(ptr %buf.i, !786, !DIExpression(), !1756)
    #dbg_value(i32 16, !787, !DIExpression(), !1756)
    #dbg_value(i32 0, !788, !DIExpression(), !1756)
  store i64 0, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1758

for.body.i.i:                                     ; preds = %for.body.i.i.for.body.i.i_crit_edge, %for.cond.preheader.i.i
    #dbg_value(i64 %indvars.iv.i.i.reg2mem.0.load, !788, !DIExpression(), !1756)
  %indvars.iv.i.i.reg2mem.0.load = load i64, ptr %indvars.iv.i.i.reg2mem, align 8
  %arrayidx.i.i = getelementptr inbounds i8, ptr %buf.i, i64 %indvars.iv.i.i.reg2mem.0.load, !dbg !1759
  %3 = load i8, ptr %arrayidx.i.i, align 1, !dbg !1759, !tbaa !373
  %conv.i.i = zext i8 %3 to i32, !dbg !1759
  tail call void (i32, ptr, ...) @fd_printf(i32 noundef signext %call21, ptr noundef nonnull @.str.17, i32 noundef signext %conv.i.i), !dbg !1759
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i.reg2mem.0.load, 1, !dbg !1760
    #dbg_value(i64 %indvars.iv.next.i.i, !788, !DIExpression(), !1756)
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 16, !dbg !1760
  br i1 %exitcond.not.i.i, label %data_to_output.exit, label %for.body.i.i.for.body.i.i_crit_edge, !dbg !1758, !llvm.loop !1761

for.body.i.i.for.body.i.i_crit_edge:              ; preds = %for.body.i.i
  store i64 %indvars.iv.next.i.i, ptr %indvars.iv.i.i.reg2mem, align 8
  br label %for.body.i.i, !dbg !1758

data_to_output.exit:                              ; preds = %for.body.i.i
  %call28 = tail call signext i32 @close(i32 noundef signext %call21) #21, !dbg !1762
  %4 = load i32, ptr @INPUT_SIZE, align 4, !dbg !1763, !tbaa !1193
  %conv29 = sext i32 %4 to i64, !dbg !1763
  %call30 = tail call noalias ptr @malloc(i64 noundef %conv29) #23, !dbg !1764
    #dbg_value(ptr %call30, !1717, !DIExpression(), !1718)
  %cmp31.not = icmp eq ptr %call30, null, !dbg !1765
  br i1 %cmp31.not, label %if.else35, label %if.end36, !dbg !1765

if.else35:                                        ; preds = %data_to_output.exit
  tail call void @__assert_fail(ptr noundef nonnull @.str.12.16, ptr noundef nonnull @.str.2.12, i32 noundef signext 58, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #22, !dbg !1765
  unreachable, !dbg !1765

if.end36:                                         ; preds = %data_to_output.exit
  %call37 = tail call signext i32 (ptr, i32, ...) @open(ptr noundef %check_file.0.reg2mem54.0.check_file.0.reload55, i32 noundef signext 0) #21, !dbg !1768
    #dbg_value(i32 %call37, !1716, !DIExpression(), !1718)
  %cmp38 = icmp sgt i32 %call37, 0, !dbg !1769
  br i1 %cmp38, label %if.end43, label %if.else42, !dbg !1769

if.else42:                                        ; preds = %if.end36
  tail call void @__assert_fail(ptr noundef nonnull @.str.14.17, ptr noundef nonnull @.str.2.12, i32 noundef signext 60, ptr noundef nonnull @__PRETTY_FUNCTION__.main) #22, !dbg !1769
  unreachable, !dbg !1769

if.end43:                                         ; preds = %if.end36
    #dbg_value(i32 %call37, !811, !DIExpression(), !1772)
    #dbg_value(ptr %call30, !812, !DIExpression(), !1772)
    #dbg_value(ptr %call30, !813, !DIExpression(), !1772)
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(144) %call30, i8 0, i64 144, i1 false), !dbg !1774
  %call.i = tail call ptr @readfile(i32 noundef signext %call37) #21, !dbg !1775
    #dbg_value(ptr %call.i, !814, !DIExpression(), !1772)
    #dbg_value(ptr %call.i, !709, !DIExpression(), !1776)
    #dbg_value(i32 1, !714, !DIExpression(), !1776)
    #dbg_value(i32 0, !715, !DIExpression(), !1776)
  store ptr %call.i, ptr %s.addr.040.i.i.reg2mem50, align 8
  store i32 0, ptr %i.041.i.i.reg2mem52, align 4
  br label %land.rhs.i.i

land.rhs.i.i:                                     ; preds = %if.end21.i.i.land.rhs.i.i_crit_edge, %if.end43
    #dbg_value(i32 %i.041.i.i.reg2mem52.0.load, !715, !DIExpression(), !1776)
    #dbg_value(ptr %s.addr.040.i.i.reg2mem50.0.s.addr.040.i.i.reload51, !709, !DIExpression(), !1776)
  %i.041.i.i.reg2mem52.0.load = load i32, ptr %i.041.i.i.reg2mem52, align 4
  %s.addr.040.i.i.reg2mem50.0.s.addr.040.i.i.reload51 = load ptr, ptr %s.addr.040.i.i.reg2mem50, align 8
  %5 = load i8, ptr %s.addr.040.i.i.reg2mem50.0.s.addr.040.i.i.reload51, align 1, !dbg !1778, !tbaa !373
  switch i8 %5, label %land.rhs.i.i.if.end21.i.i_crit_edge [
    i8 0, label %land.rhs.i.i.output_to_data.exit_crit_edge
    i8 37, label %land.lhs.true10.i.i
  ], !dbg !1779

land.rhs.i.i.output_to_data.exit_crit_edge:       ; preds = %land.rhs.i.i
  store ptr %s.addr.040.i.i.reg2mem50.0.s.addr.040.i.i.reload51, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 0, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1779

land.rhs.i.i.if.end21.i.i_crit_edge:              ; preds = %land.rhs.i.i
  store i32 %i.041.i.i.reg2mem52.0.load, ptr %i.1.i.i.reg2mem48, align 4
  br label %if.end21.i.i, !dbg !1779

land.lhs.true10.i.i:                              ; preds = %land.rhs.i.i
  %arrayidx11.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem50.0.s.addr.040.i.i.reload51, i64 1, !dbg !1780
  %6 = load i8, ptr %arrayidx11.i.i, align 1, !dbg !1780, !tbaa !373
  %cmp13.i.i = icmp eq i8 %6, 37, !dbg !1781
  br i1 %cmp13.i.i, label %land.lhs.true15.i.i, label %land.lhs.true10.i.i.if.end21.i.i_crit_edge, !dbg !1782

land.lhs.true10.i.i.if.end21.i.i_crit_edge:       ; preds = %land.lhs.true10.i.i
  store i32 %i.041.i.i.reg2mem52.0.load, ptr %i.1.i.i.reg2mem48, align 4
  br label %if.end21.i.i, !dbg !1782

land.lhs.true15.i.i:                              ; preds = %land.lhs.true10.i.i
  %arrayidx16.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem50.0.s.addr.040.i.i.reload51, i64 2, !dbg !1783
  %7 = load i8, ptr %arrayidx16.i.i, align 1, !dbg !1783, !tbaa !373
  %cmp18.i.i = icmp eq i8 %7, 10, !dbg !1784
  %inc.i.i = zext i1 %cmp18.i.i to i32, !dbg !1785
  %spec.select.i.i = add nsw i32 %i.041.i.i.reg2mem52.0.load, %inc.i.i, !dbg !1785
  store i32 %spec.select.i.i, ptr %i.1.i.i.reg2mem48, align 4
  br label %if.end21.i.i, !dbg !1785

if.end21.i.i:                                     ; preds = %land.lhs.true10.i.i.if.end21.i.i_crit_edge, %land.rhs.i.i.if.end21.i.i_crit_edge, %land.lhs.true15.i.i
    #dbg_value(i32 %i.1.i.i.reg2mem48.0.load, !715, !DIExpression(), !1776)
  %i.1.i.i.reg2mem48.0.load = load i32, ptr %i.1.i.i.reg2mem48, align 4
  %incdec.ptr.i.i = getelementptr inbounds i8, ptr %s.addr.040.i.i.reg2mem50.0.s.addr.040.i.i.reload51, i64 1, !dbg !1786
    #dbg_value(ptr %incdec.ptr.i.i, !709, !DIExpression(), !1776)
  %cmp4.i.i = icmp slt i32 %i.1.i.i.reg2mem48.0.load, 1, !dbg !1787
  br i1 %cmp4.i.i, label %if.end21.i.i.land.rhs.i.i_crit_edge, label %if.end21.while.end_crit_edge.i.i, !dbg !1788, !llvm.loop !1789

if.end21.i.i.land.rhs.i.i_crit_edge:              ; preds = %if.end21.i.i
  store ptr %incdec.ptr.i.i, ptr %s.addr.040.i.i.reg2mem50, align 8
  store i32 %i.1.i.i.reg2mem48.0.load, ptr %i.041.i.i.reg2mem52, align 4
  br label %land.rhs.i.i, !dbg !1788

if.end21.while.end_crit_edge.i.i:                 ; preds = %if.end21.i.i
  %.pre.i.i = load i8, ptr %incdec.ptr.i.i, align 1, !dbg !1791, !tbaa !373
  %8 = icmp eq i8 %.pre.i.i, 0, !dbg !1792
  %9 = select i1 %8, i64 0, i64 2, !dbg !1793
  store ptr %incdec.ptr.i.i, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  store i64 %9, ptr %cmp23.not.i.i.reg2mem, align 8
  br label %output_to_data.exit, !dbg !1788

output_to_data.exit:                              ; preds = %land.rhs.i.i.output_to_data.exit_crit_edge, %if.end21.while.end_crit_edge.i.i
  %cmp23.not.i.i.reg2mem.0.load = load i64, ptr %cmp23.not.i.i.reg2mem, align 8
  %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload = load ptr, ptr %s.addr.0.lcssa.ph.i.i.reg2mem, align 8
  %spec.select38.i.i = getelementptr inbounds i8, ptr %s.addr.0.lcssa.ph.i.i.reg2mem.0.s.addr.0.lcssa.ph.i.i.reload, i64 %cmp23.not.i.i.reg2mem.0.load, !dbg !1793
    #dbg_value(ptr %spec.select38.i.i, !815, !DIExpression(), !1772)
  %buf.i2 = getelementptr inbounds i8, ptr %call30, i64 128, !dbg !1794
  %call2.i = tail call signext i32 @parse_uint8_t_array(ptr noundef nonnull %spec.select38.i.i, ptr noundef nonnull %buf.i2, i32 noundef signext 16) #21, !dbg !1795
  tail call void @free(ptr noundef %call.i) #21, !dbg !1796
    #dbg_value(ptr %call, !863, !DIExpression(), !1797)
    #dbg_value(ptr %call30, !864, !DIExpression(), !1797)
    #dbg_value(ptr %call, !865, !DIExpression(), !1797)
    #dbg_value(ptr %call30, !866, !DIExpression(), !1797)
    #dbg_value(i32 0, !867, !DIExpression(), !1797)
  %bcmp.i = tail call i32 @bcmp(ptr noundef nonnull readonly dereferenceable(16) %buf.i, ptr noundef nonnull readonly dereferenceable(16) %buf.i2, i64 16), !dbg !1800
    #dbg_value(i32 %bcmp.i, !867, !DIExpression(), !1797)
  %tobool.not.i.not = icmp eq i32 %bcmp.i, 0, !dbg !1801
  br i1 %tobool.not.i.not, label %if.end47, label %if.then45, !dbg !1802

if.then45:                                        ; preds = %output_to_data.exit
  %10 = load ptr, ptr @stderr, align 8, !dbg !1803, !tbaa !1057
  %11 = tail call i64 @fwrite(ptr nonnull @.str.15, i64 32, i64 1, ptr %10) #24, !dbg !1805
  store i32 -1, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1806

if.end47:                                         ; preds = %output_to_data.exit
  tail call void @free(ptr noundef %call) #21, !dbg !1807
  tail call void @free(ptr noundef %call30) #21, !dbg !1808
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) @str), !dbg !1809
  store i32 0, ptr %retval.0.reg2mem, align 4
  br label %cleanup, !dbg !1810

cleanup:                                          ; preds = %if.end47, %if.then45
  %retval.0.reg2mem.0.load = load i32, ptr %retval.0.reg2mem, align 4
  ret i32 %retval.0.reg2mem.0.load, !dbg !1811
}

; Function Attrs: nofree
declare !dbg !1812 noundef signext i32 @open(ptr nocapture noundef readonly, i32 noundef signext, ...) local_unnamed_addr #13

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr nocapture noundef, i64 noundef, i64 noundef, ptr nocapture noundef) local_unnamed_addr #20

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #20

attributes #0 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #1 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "polly-optimized" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #3 = { inlinehint nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #4 = { nofree norecurse nosync nounwind memory(argmem: readwrite) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #5 = { nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #7 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #8 = { mustprogress nofree nounwind willreturn memory(argmem: read) uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #9 = { mustprogress nofree nounwind willreturn memory(argmem: read) }
attributes #10 = { noreturn nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #11 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #12 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #13 = { nofree "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #14 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #15 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #16 = { mustprogress nofree nounwind willreturn "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #17 = { mustprogress nofree nounwind willreturn memory(argmem: read) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #18 = { inlinehint nounwind uwtable "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+d,+f,+m,+relax,+zicsr,+zifencei,-c,-e,-experimental-zacas,-experimental-zcmop,-experimental-zfbfmin,-experimental-zicfilp,-experimental-zicfiss,-experimental-zimop,-experimental-ztso,-experimental-zvfbfmin,-experimental-zvfbfwma,-h,-smaia,-smepmp,-ssaia,-svinval,-svnapot,-svpbmt,-v,-xcvalu,-xcvbi,-xcvbitmanip,-xcvelw,-xcvmac,-xcvmem,-xcvsimd,-xsfvcp,-xsfvfnrclipxfqf,-xsfvfwmaccqqq,-xsfvqmaccdod,-xsfvqmaccqoq,-xtheadba,-xtheadbb,-xtheadbs,-xtheadcmo,-xtheadcondmov,-xtheadfmemidx,-xtheadmac,-xtheadmemidx,-xtheadmempair,-xtheadsync,-xtheadvdot,-xventanacondops,-za128rs,-za64rs,-zawrs,-zba,-zbb,-zbc,-zbkb,-zbkc,-zbkx,-zbs,-zca,-zcb,-zcd,-zce,-zcf,-zcmp,-zcmt,-zdinx,-zfa,-zfh,-zfhmin,-zfinx,-zhinx,-zhinxmin,-zic64b,-zicbom,-zicbop,-zicboz,-ziccamoa,-ziccif,-zicclsm,-ziccrse,-zicntr,-zicond,-zihintntl,-zihintpause,-zihpm,-zk,-zkn,-zknd,-zkne,-zknh,-zkr,-zks,-zksed,-zksh,-zkt,-zmmul,-zvbb,-zvbc,-zve32f,-zve32x,-zve64d,-zve64f,-zve64x,-zvfh,-zvfhmin,-zvkb,-zvkg,-zvkn,-zvknc,-zvkned,-zvkng,-zvknha,-zvknhb,-zvks,-zvksc,-zvksed,-zvksg,-zvksh,-zvkt,-zvl1024b,-zvl128b,-zvl16384b,-zvl2048b,-zvl256b,-zvl32768b,-zvl32b,-zvl4096b,-zvl512b,-zvl64b,-zvl65536b,-zvl8192b" }
attributes #19 = { nocallback nofree nosync nounwind willreturn }
attributes #20 = { nofree nounwind }
attributes #21 = { nounwind }
attributes #22 = { noreturn nounwind }
attributes #23 = { nounwind allocsize(0) }
attributes #24 = { cold }
attributes #25 = { nounwind willreturn memory(read) }

!llvm.dbg.cu = !{!2, !202, !247, !308}
!llvm.ident = !{!329, !329, !329, !329}
!llvm.module.flags = !{!330, !331, !332, !333, !334, !336, !337, !338, !339, !340}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "sbox", scope: !2, file: !3, line: 13, type: !5, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "aes.c", directory: "/home/kelvin/MachSuite/aes/aes")
!4 = !{!0}
!5 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 2048, elements: !12)
!6 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7)
!7 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !8, line: 24, baseType: !9)
!8 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-uintn.h", directory: "")
!9 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !10, line: 38, baseType: !11)
!10 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types.h", directory: "")
!11 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!12 = !{!13}
!13 = !DISubrange(count: 256)
!14 = !DIGlobalVariableExpression(var: !15, expr: !DIExpression())
!15 = distinct !DIGlobalVariable(scope: null, file: !16, line: 40, type: !17, isLocal: true, isDefinition: true)
!16 = !DIFile(filename: "../../common/support.c", directory: "/home/kelvin/MachSuite/aes/aes")
!17 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 272, elements: !19)
!18 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_unsigned_char)
!19 = !{!20}
!20 = !DISubrange(count: 34)
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(scope: null, file: !16, line: 40, type: !23, isLocal: true, isDefinition: true)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 184, elements: !24)
!24 = !{!25}
!25 = !DISubrange(count: 23)
!26 = !DIGlobalVariableExpression(var: !27, expr: !DIExpression())
!27 = distinct !DIGlobalVariable(scope: null, file: !16, line: 40, type: !28, isLocal: true, isDefinition: true)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 160, elements: !30)
!29 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !18)
!30 = !{!31}
!31 = !DISubrange(count: 20)
!32 = !DIGlobalVariableExpression(var: !33, expr: !DIExpression())
!33 = distinct !DIGlobalVariable(scope: null, file: !16, line: 41, type: !34, isLocal: true, isDefinition: true)
!34 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 408, elements: !35)
!35 = !{!36}
!36 = !DISubrange(count: 51)
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(scope: null, file: !16, line: 43, type: !39, isLocal: true, isDefinition: true)
!39 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 200, elements: !40)
!40 = !{!41}
!41 = !DISubrange(count: 25)
!42 = !DIGlobalVariableExpression(var: !43, expr: !DIExpression())
!43 = distinct !DIGlobalVariable(scope: null, file: !16, line: 48, type: !44, isLocal: true, isDefinition: true)
!44 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 232, elements: !45)
!45 = !{!46}
!46 = !DISubrange(count: 29)
!47 = !DIGlobalVariableExpression(var: !48, expr: !DIExpression())
!48 = distinct !DIGlobalVariable(scope: null, file: !16, line: 59, type: !49, isLocal: true, isDefinition: true)
!49 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 264, elements: !50)
!50 = !{!51}
!51 = !DISubrange(count: 33)
!52 = !DIGlobalVariableExpression(var: !53, expr: !DIExpression())
!53 = distinct !DIGlobalVariable(scope: null, file: !16, line: 59, type: !54, isLocal: true, isDefinition: true)
!54 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 304, elements: !55)
!55 = !{!56}
!56 = !DISubrange(count: 38)
!57 = !DIGlobalVariableExpression(var: !58, expr: !DIExpression())
!58 = distinct !DIGlobalVariable(scope: null, file: !16, line: 79, type: !17, isLocal: true, isDefinition: true)
!59 = !DIGlobalVariableExpression(var: !60, expr: !DIExpression())
!60 = distinct !DIGlobalVariable(scope: null, file: !16, line: 79, type: !54, isLocal: true, isDefinition: true)
!61 = !DIGlobalVariableExpression(var: !62, expr: !DIExpression())
!62 = distinct !DIGlobalVariable(scope: null, file: !16, line: 132, type: !63, isLocal: true, isDefinition: true)
!63 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 384, elements: !64)
!64 = !{!65}
!65 = !DISubrange(count: 48)
!66 = !DIGlobalVariableExpression(var: !67, expr: !DIExpression())
!67 = distinct !DIGlobalVariable(scope: null, file: !16, line: 132, type: !68, isLocal: true, isDefinition: true)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 16, elements: !69)
!69 = !{!70}
!70 = !DISubrange(count: 2)
!71 = !DIGlobalVariableExpression(var: !72, expr: !DIExpression())
!72 = distinct !DIGlobalVariable(scope: null, file: !16, line: 132, type: !73, isLocal: true, isDefinition: true)
!73 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 280, elements: !74)
!74 = !{!75}
!75 = !DISubrange(count: 35)
!76 = !DIGlobalVariableExpression(var: !77, expr: !DIExpression())
!77 = distinct !DIGlobalVariable(scope: null, file: !16, line: 133, type: !78, isLocal: true, isDefinition: true)
!78 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 400, elements: !79)
!79 = !{!80}
!80 = !DISubrange(count: 50)
!81 = !DIGlobalVariableExpression(var: !82, expr: !DIExpression())
!82 = distinct !DIGlobalVariable(scope: null, file: !16, line: 134, type: !78, isLocal: true, isDefinition: true)
!83 = !DIGlobalVariableExpression(var: !84, expr: !DIExpression())
!84 = distinct !DIGlobalVariable(scope: null, file: !16, line: 135, type: !78, isLocal: true, isDefinition: true)
!85 = !DIGlobalVariableExpression(var: !86, expr: !DIExpression())
!86 = distinct !DIGlobalVariable(scope: null, file: !16, line: 136, type: !87, isLocal: true, isDefinition: true)
!87 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 368, elements: !88)
!88 = !{!89}
!89 = !DISubrange(count: 46)
!90 = !DIGlobalVariableExpression(var: !91, expr: !DIExpression())
!91 = distinct !DIGlobalVariable(scope: null, file: !16, line: 137, type: !63, isLocal: true, isDefinition: true)
!92 = !DIGlobalVariableExpression(var: !93, expr: !DIExpression())
!93 = distinct !DIGlobalVariable(scope: null, file: !16, line: 138, type: !63, isLocal: true, isDefinition: true)
!94 = !DIGlobalVariableExpression(var: !95, expr: !DIExpression())
!95 = distinct !DIGlobalVariable(scope: null, file: !16, line: 139, type: !63, isLocal: true, isDefinition: true)
!96 = !DIGlobalVariableExpression(var: !97, expr: !DIExpression())
!97 = distinct !DIGlobalVariable(scope: null, file: !16, line: 141, type: !98, isLocal: true, isDefinition: true)
!98 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 352, elements: !99)
!99 = !{!100}
!100 = !DISubrange(count: 44)
!101 = !DIGlobalVariableExpression(var: !102, expr: !DIExpression())
!102 = distinct !DIGlobalVariable(scope: null, file: !16, line: 142, type: !87, isLocal: true, isDefinition: true)
!103 = !DIGlobalVariableExpression(var: !104, expr: !DIExpression())
!104 = distinct !DIGlobalVariable(scope: null, file: !16, line: 147, type: !105, isLocal: true, isDefinition: true)
!105 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 280, elements: !74)
!106 = !DIGlobalVariableExpression(var: !107, expr: !DIExpression())
!107 = distinct !DIGlobalVariable(scope: null, file: !16, line: 154, type: !108, isLocal: true, isDefinition: true)
!108 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 224, elements: !109)
!109 = !{!110}
!110 = !DISubrange(count: 28)
!111 = !DIGlobalVariableExpression(var: !112, expr: !DIExpression())
!112 = distinct !DIGlobalVariable(scope: null, file: !16, line: 177, type: !113, isLocal: true, isDefinition: true)
!113 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 360, elements: !114)
!114 = !{!115}
!115 = !DISubrange(count: 45)
!116 = !DIGlobalVariableExpression(var: !117, expr: !DIExpression())
!117 = distinct !DIGlobalVariable(scope: null, file: !16, line: 177, type: !118, isLocal: true, isDefinition: true)
!118 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 32, elements: !119)
!119 = !{!120}
!120 = !DISubrange(count: 4)
!121 = !DIGlobalVariableExpression(var: !122, expr: !DIExpression())
!122 = distinct !DIGlobalVariable(scope: null, file: !16, line: 178, type: !123, isLocal: true, isDefinition: true)
!123 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 376, elements: !124)
!124 = !{!125}
!125 = !DISubrange(count: 47)
!126 = !DIGlobalVariableExpression(var: !127, expr: !DIExpression())
!127 = distinct !DIGlobalVariable(scope: null, file: !16, line: 179, type: !123, isLocal: true, isDefinition: true)
!128 = !DIGlobalVariableExpression(var: !129, expr: !DIExpression())
!129 = distinct !DIGlobalVariable(scope: null, file: !16, line: 180, type: !123, isLocal: true, isDefinition: true)
!130 = !DIGlobalVariableExpression(var: !131, expr: !DIExpression())
!131 = distinct !DIGlobalVariable(scope: null, file: !16, line: 180, type: !132, isLocal: true, isDefinition: true)
!132 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 40, elements: !133)
!133 = !{!134}
!134 = !DISubrange(count: 5)
!135 = !DIGlobalVariableExpression(var: !136, expr: !DIExpression())
!136 = distinct !DIGlobalVariable(scope: null, file: !16, line: 181, type: !137, isLocal: true, isDefinition: true)
!137 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 344, elements: !138)
!138 = !{!139}
!139 = !DISubrange(count: 43)
!140 = !DIGlobalVariableExpression(var: !141, expr: !DIExpression())
!141 = distinct !DIGlobalVariable(scope: null, file: !16, line: 181, type: !118, isLocal: true, isDefinition: true)
!142 = !DIGlobalVariableExpression(var: !143, expr: !DIExpression())
!143 = distinct !DIGlobalVariable(scope: null, file: !16, line: 182, type: !113, isLocal: true, isDefinition: true)
!144 = !DIGlobalVariableExpression(var: !145, expr: !DIExpression())
!145 = distinct !DIGlobalVariable(scope: null, file: !16, line: 183, type: !113, isLocal: true, isDefinition: true)
!146 = !DIGlobalVariableExpression(var: !147, expr: !DIExpression())
!147 = distinct !DIGlobalVariable(scope: null, file: !16, line: 184, type: !113, isLocal: true, isDefinition: true)
!148 = !DIGlobalVariableExpression(var: !149, expr: !DIExpression())
!149 = distinct !DIGlobalVariable(scope: null, file: !16, line: 184, type: !132, isLocal: true, isDefinition: true)
!150 = !DIGlobalVariableExpression(var: !151, expr: !DIExpression())
!151 = distinct !DIGlobalVariable(scope: null, file: !16, line: 186, type: !152, isLocal: true, isDefinition: true)
!152 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 328, elements: !153)
!153 = !{!154}
!154 = !DISubrange(count: 41)
!155 = !DIGlobalVariableExpression(var: !156, expr: !DIExpression())
!156 = distinct !DIGlobalVariable(scope: null, file: !16, line: 186, type: !157, isLocal: true, isDefinition: true)
!157 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 56, elements: !158)
!158 = !{!159}
!159 = !DISubrange(count: 7)
!160 = !DIGlobalVariableExpression(var: !161, expr: !DIExpression())
!161 = distinct !DIGlobalVariable(scope: null, file: !16, line: 187, type: !137, isLocal: true, isDefinition: true)
!162 = !DIGlobalVariableExpression(var: !163, expr: !DIExpression())
!163 = distinct !DIGlobalVariable(scope: null, file: !16, line: 190, type: !164, isLocal: true, isDefinition: true)
!164 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 240, elements: !165)
!165 = !{!166}
!166 = !DISubrange(count: 30)
!167 = !DIGlobalVariableExpression(var: !168, expr: !DIExpression())
!168 = distinct !DIGlobalVariable(scope: null, file: !16, line: 191, type: !169, isLocal: true, isDefinition: true)
!169 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 48, elements: !170)
!170 = !{!171}
!171 = !DISubrange(count: 6)
!172 = !DIGlobalVariableExpression(var: !173, expr: !DIExpression())
!173 = distinct !DIGlobalVariable(scope: null, file: !16, line: 22, type: !174, isLocal: true, isDefinition: true)
!174 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 720, elements: !175)
!175 = !{!176}
!176 = !DISubrange(count: 90)
!177 = !DIGlobalVariableExpression(var: !178, expr: !DIExpression())
!178 = distinct !DIGlobalVariable(scope: null, file: !16, line: 22, type: !54, isLocal: true, isDefinition: true)
!179 = !DIGlobalVariableExpression(var: !180, expr: !DIExpression())
!180 = distinct !DIGlobalVariable(scope: null, file: !16, line: 29, type: !181, isLocal: true, isDefinition: true)
!181 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 400, elements: !79)
!182 = !DIGlobalVariableExpression(var: !183, expr: !DIExpression())
!183 = distinct !DIGlobalVariable(scope: null, file: !184, line: 21, type: !185, isLocal: true, isDefinition: true)
!184 = !DIFile(filename: "../../common/harness.c", directory: "/home/kelvin/MachSuite/aes/aes")
!185 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 456, elements: !186)
!186 = !{!187}
!187 = !DISubrange(count: 57)
!188 = !DIGlobalVariableExpression(var: !189, expr: !DIExpression())
!189 = distinct !DIGlobalVariable(scope: null, file: !184, line: 21, type: !23, isLocal: true, isDefinition: true)
!190 = !DIGlobalVariableExpression(var: !191, expr: !DIExpression())
!191 = distinct !DIGlobalVariable(scope: null, file: !184, line: 21, type: !192, isLocal: true, isDefinition: true)
!192 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 184, elements: !24)
!193 = !DIGlobalVariableExpression(var: !194, expr: !DIExpression())
!194 = distinct !DIGlobalVariable(scope: null, file: !184, line: 22, type: !195, isLocal: true, isDefinition: true)
!195 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 88, elements: !196)
!196 = !{!197}
!197 = !DISubrange(count: 11)
!198 = !DIGlobalVariableExpression(var: !199, expr: !DIExpression())
!199 = distinct !DIGlobalVariable(scope: null, file: !184, line: 24, type: !195, isLocal: true, isDefinition: true)
!200 = !DIGlobalVariableExpression(var: !201, expr: !DIExpression())
!201 = distinct !DIGlobalVariable(name: "INPUT_SIZE", scope: !202, file: !203, line: 4, type: !225, isLocal: false, isDefinition: true)
!202 = distinct !DICompileUnit(language: DW_LANG_C11, file: !203, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !204, globals: !224, splitDebugInlining: false, nameTableKind: None)
!203 = !DIFile(filename: "local_support.c", directory: "/home/kelvin/MachSuite/aes/aes")
!204 = !{!205}
!205 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !206, size: 64)
!206 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bench_args_t", file: !207, line: 32, size: 1152, elements: !208)
!207 = !DIFile(filename: "./aes.h", directory: "/home/kelvin/MachSuite/aes/aes")
!208 = !{!209, !219, !220}
!209 = !DIDerivedType(tag: DW_TAG_member, name: "ctx", scope: !206, file: !207, line: 33, baseType: !210, size: 768)
!210 = !DIDerivedType(tag: DW_TAG_typedef, name: "aes256_context", file: !207, line: 11, baseType: !211)
!211 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !207, line: 7, size: 768, elements: !212)
!212 = !{!213, !217, !218}
!213 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !211, file: !207, line: 8, baseType: !214, size: 256)
!214 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 256, elements: !215)
!215 = !{!216}
!216 = !DISubrange(count: 32)
!217 = !DIDerivedType(tag: DW_TAG_member, name: "enckey", scope: !211, file: !207, line: 9, baseType: !214, size: 256, offset: 256)
!218 = !DIDerivedType(tag: DW_TAG_member, name: "deckey", scope: !211, file: !207, line: 10, baseType: !214, size: 256, offset: 512)
!219 = !DIDerivedType(tag: DW_TAG_member, name: "k", scope: !206, file: !207, line: 34, baseType: !214, size: 256, offset: 768)
!220 = !DIDerivedType(tag: DW_TAG_member, name: "buf", scope: !206, file: !207, line: 35, baseType: !221, size: 128, offset: 1024)
!221 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 128, elements: !222)
!222 = !{!223}
!223 = !DISubrange(count: 16)
!224 = !{!200}
!225 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!226 = !DIGlobalVariableExpression(var: !227, expr: !DIExpression())
!227 = distinct !DIGlobalVariable(scope: null, file: !184, line: 37, type: !228, isLocal: true, isDefinition: true)
!228 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 240, elements: !165)
!229 = !DIGlobalVariableExpression(var: !230, expr: !DIExpression())
!230 = distinct !DIGlobalVariable(scope: null, file: !184, line: 39, type: !231, isLocal: true, isDefinition: true)
!231 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 344, elements: !138)
!232 = !DIGlobalVariableExpression(var: !233, expr: !DIExpression())
!233 = distinct !DIGlobalVariable(scope: null, file: !184, line: 47, type: !234, isLocal: true, isDefinition: true)
!234 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 96, elements: !235)
!235 = !{!236}
!236 = !DISubrange(count: 12)
!237 = !DIGlobalVariableExpression(var: !238, expr: !DIExpression())
!238 = distinct !DIGlobalVariable(scope: null, file: !184, line: 48, type: !239, isLocal: true, isDefinition: true)
!239 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 360, elements: !114)
!240 = !DIGlobalVariableExpression(var: !241, expr: !DIExpression())
!241 = distinct !DIGlobalVariable(scope: null, file: !184, line: 58, type: !44, isLocal: true, isDefinition: true)
!242 = !DIGlobalVariableExpression(var: !243, expr: !DIExpression())
!243 = distinct !DIGlobalVariable(scope: null, file: !184, line: 60, type: !244, isLocal: true, isDefinition: true)
!244 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 368, elements: !88)
!245 = !DIGlobalVariableExpression(var: !246, expr: !DIExpression())
!246 = distinct !DIGlobalVariable(scope: null, file: !184, line: 67, type: !49, isLocal: true, isDefinition: true)
!247 = distinct !DICompileUnit(language: DW_LANG_C11, file: !16, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !248, globals: !274, splitDebugInlining: false, nameTableKind: None)
!248 = !{!249, !18, !250, !7, !251, !254, !257, !260, !264, !267, !269, !272, !273}
!249 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!250 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!251 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !8, line: 25, baseType: !252)
!252 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !10, line: 40, baseType: !253)
!253 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!254 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !8, line: 26, baseType: !255)
!255 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !10, line: 42, baseType: !256)
!256 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!257 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !8, line: 27, baseType: !258)
!258 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !10, line: 45, baseType: !259)
!259 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!260 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !261, line: 24, baseType: !262)
!261 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/stdint-intn.h", directory: "")
!262 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int8_t", file: !10, line: 37, baseType: !263)
!263 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!264 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !261, line: 25, baseType: !265)
!265 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int16_t", file: !10, line: 39, baseType: !266)
!266 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!267 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !261, line: 26, baseType: !268)
!268 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int32_t", file: !10, line: 41, baseType: !225)
!269 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !261, line: 27, baseType: !270)
!270 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !10, line: 44, baseType: !271)
!271 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!272 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!273 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!274 = !{!275, !14, !21, !26, !280, !32, !282, !37, !287, !42, !289, !47, !52, !291, !57, !59, !61, !66, !71, !76, !81, !83, !85, !90, !92, !94, !96, !101, !103, !296, !106, !111, !116, !121, !126, !128, !130, !135, !140, !142, !144, !146, !148, !150, !155, !160, !162, !167, !301, !172, !177, !303, !179}
!275 = !DIGlobalVariableExpression(var: !276, expr: !DIExpression())
!276 = distinct !DIGlobalVariable(scope: null, file: !16, line: 40, type: !277, isLocal: true, isDefinition: true)
!277 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 192, elements: !278)
!278 = !{!279}
!279 = !DISubrange(count: 24)
!280 = !DIGlobalVariableExpression(var: !281, expr: !DIExpression())
!281 = distinct !DIGlobalVariable(scope: null, file: !16, line: 41, type: !44, isLocal: true, isDefinition: true)
!282 = !DIGlobalVariableExpression(var: !283, expr: !DIExpression())
!283 = distinct !DIGlobalVariable(scope: null, file: !16, line: 43, type: !284, isLocal: true, isDefinition: true)
!284 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 112, elements: !285)
!285 = !{!286}
!286 = !DISubrange(count: 14)
!287 = !DIGlobalVariableExpression(var: !288, expr: !DIExpression())
!288 = distinct !DIGlobalVariable(scope: null, file: !16, line: 48, type: !284, isLocal: true, isDefinition: true)
!289 = !DIGlobalVariableExpression(var: !290, expr: !DIExpression())
!290 = distinct !DIGlobalVariable(scope: null, file: !16, line: 59, type: !23, isLocal: true, isDefinition: true)
!291 = !DIGlobalVariableExpression(var: !292, expr: !DIExpression())
!292 = distinct !DIGlobalVariable(scope: null, file: !16, line: 79, type: !293, isLocal: true, isDefinition: true)
!293 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 168, elements: !294)
!294 = !{!295}
!295 = !DISubrange(count: 21)
!296 = !DIGlobalVariableExpression(var: !297, expr: !DIExpression())
!297 = distinct !DIGlobalVariable(scope: null, file: !16, line: 154, type: !298, isLocal: true, isDefinition: true)
!298 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 104, elements: !299)
!299 = !{!300}
!300 = !DISubrange(count: 13)
!301 = !DIGlobalVariableExpression(var: !302, expr: !DIExpression())
!302 = distinct !DIGlobalVariable(scope: null, file: !16, line: 22, type: !34, isLocal: true, isDefinition: true)
!303 = !DIGlobalVariableExpression(var: !304, expr: !DIExpression())
!304 = distinct !DIGlobalVariable(scope: null, file: !16, line: 29, type: !305, isLocal: true, isDefinition: true)
!305 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 216, elements: !306)
!306 = !{!307}
!307 = !DISubrange(count: 27)
!308 = distinct !DICompileUnit(language: DW_LANG_C11, file: !184, producer: "clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !309, globals: !310, splitDebugInlining: false, nameTableKind: None)
!309 = !{!250}
!310 = !{!311, !182, !188, !190, !193, !198, !313, !226, !315, !229, !232, !317, !237, !240, !322, !242, !245, !324}
!311 = !DIGlobalVariableExpression(var: !312, expr: !DIExpression())
!312 = distinct !DIGlobalVariable(scope: null, file: !184, line: 21, type: !239, isLocal: true, isDefinition: true)
!313 = !DIGlobalVariableExpression(var: !314, expr: !DIExpression())
!314 = distinct !DIGlobalVariable(scope: null, file: !184, line: 37, type: !284, isLocal: true, isDefinition: true)
!315 = !DIGlobalVariableExpression(var: !316, expr: !DIExpression())
!316 = distinct !DIGlobalVariable(scope: null, file: !184, line: 39, type: !228, isLocal: true, isDefinition: true)
!317 = !DIGlobalVariableExpression(var: !318, expr: !DIExpression())
!318 = distinct !DIGlobalVariable(scope: null, file: !184, line: 48, type: !319, isLocal: true, isDefinition: true)
!319 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 248, elements: !320)
!320 = !{!321}
!321 = !DISubrange(count: 31)
!322 = !DIGlobalVariableExpression(var: !323, expr: !DIExpression())
!323 = distinct !DIGlobalVariable(scope: null, file: !184, line: 60, type: !228, isLocal: true, isDefinition: true)
!324 = !DIGlobalVariableExpression(var: !325, expr: !DIExpression())
!325 = distinct !DIGlobalVariable(scope: null, file: !184, line: 74, type: !326, isLocal: true, isDefinition: true)
!326 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 80, elements: !327)
!327 = !{!328}
!328 = !DISubrange(count: 10)
!329 = !{!"clang version 18.1.8 (https://github.com/llvm/llvm-project.git 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)"}
!330 = !{i32 7, !"Dwarf Version", i32 4}
!331 = !{i32 2, !"Debug Info Version", i32 3}
!332 = !{i32 1, !"wchar_size", i32 4}
!333 = !{i32 1, !"target-abi", !"lp64d"}
!334 = distinct !{i32 6, !"riscv-isa", !335}
!335 = distinct !{!"rv64i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"}
!336 = !{i32 8, !"PIC Level", i32 2}
!337 = !{i32 7, !"PIE Level", i32 2}
!338 = !{i32 7, !"uwtable", i32 2}
!339 = !{i32 8, !"SmallDataLimit", i32 8}
!340 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!341 = distinct !DISubprogram(name: "rj_xtime", scope: !3, file: !3, line: 96, type: !342, scopeLine: 97, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !344)
!342 = !DISubroutineType(types: !343)
!343 = !{!7, !7}
!344 = !{!345}
!345 = !DILocalVariable(name: "x", arg: 1, scope: !341, file: !3, line: 96, type: !7)
!346 = !DILocation(line: 0, scope: !341)
!347 = !DILocation(line: 98, column: 12, scope: !341)
!348 = !DILocation(line: 98, column: 5, scope: !341)
!349 = distinct !DISubprogram(name: "aes", scope: !3, file: !3, line: 176, type: !350, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !360)
!350 = !DISubroutineType(types: !351)
!351 = !{null, !352, !359, !359}
!352 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !353, size: 64)
!353 = !DIDerivedType(tag: DW_TAG_typedef, name: "aes256_context", file: !207, line: 11, baseType: !354)
!354 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !207, line: 7, size: 768, elements: !355)
!355 = !{!356, !357, !358}
!356 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !354, file: !207, line: 8, baseType: !214, size: 256)
!357 = !DIDerivedType(tag: DW_TAG_member, name: "enckey", scope: !354, file: !207, line: 9, baseType: !214, size: 256, offset: 256)
!358 = !DIDerivedType(tag: DW_TAG_member, name: "deckey", scope: !354, file: !207, line: 10, baseType: !214, size: 256, offset: 512)
!359 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!360 = !{!361, !362, !363, !364, !365, !366, !367, !368}
!361 = !DILocalVariable(name: "ctx", arg: 1, scope: !349, file: !3, line: 176, type: !352)
!362 = !DILocalVariable(name: "k", arg: 2, scope: !349, file: !3, line: 176, type: !359)
!363 = !DILocalVariable(name: "buf", arg: 3, scope: !349, file: !3, line: 176, type: !359)
!364 = !DILocalVariable(name: "rcon", scope: !349, file: !3, line: 179, type: !7)
!365 = !DILocalVariable(name: "i", scope: !349, file: !3, line: 180, type: !7)
!366 = !DILabel(scope: !349, name: "ecb1", file: !3, line: 182)
!367 = !DILabel(scope: !349, name: "ecb2", file: !3, line: 185)
!368 = !DILabel(scope: !349, name: "ecb3", file: !3, line: 191)
!369 = distinct !DIAssignID()
!370 = !DILocation(line: 0, scope: !349)
!371 = !DILocation(line: 179, column: 5, scope: !349)
!372 = !DILocation(line: 179, column: 13, scope: !349)
!373 = !{!374, !374, i64 0}
!374 = !{!"omnipotent char", !375, i64 0}
!375 = !{!"Simple C/C++ TBAA"}
!376 = distinct !DIAssignID()
!377 = !DILocation(line: 182, column: 5, scope: !349)
!378 = !DILocation(line: 182, column: 12, scope: !379)
!379 = distinct !DILexicalBlock(scope: !349, file: !3, line: 182, column: 12)
!380 = !DILocation(line: 185, column: 12, scope: !381)
!381 = distinct !DILexicalBlock(scope: !349, file: !3, line: 185, column: 12)
!382 = !DILocation(line: 183, column: 43, scope: !383)
!383 = distinct !DILexicalBlock(scope: !384, file: !3, line: 182, column: 50)
!384 = distinct !DILexicalBlock(scope: !379, file: !3, line: 182, column: 12)
!385 = !DILocation(line: 183, column: 26, scope: !383)
!386 = !DILocation(line: 183, column: 41, scope: !383)
!387 = !DILocation(line: 183, column: 9, scope: !383)
!388 = !DILocation(line: 183, column: 24, scope: !383)
!389 = !DILocation(line: 182, column: 47, scope: !384)
!390 = !DILocation(line: 182, column: 26, scope: !384)
!391 = distinct !{!391, !378, !392, !393, !394}
!392 = !DILocation(line: 184, column: 5, scope: !379)
!393 = !{!"llvm.loop.mustprogress"}
!394 = !{!"llvm.loop.unroll.disable"}
!395 = !DILocation(line: 186, column: 9, scope: !396)
!396 = distinct !DILexicalBlock(scope: !397, file: !3, line: 185, column: 28)
!397 = distinct !DILexicalBlock(scope: !381, file: !3, line: 185, column: 12)
!398 = !DILocation(line: 185, column: 23, scope: !397)
!399 = distinct !{!399, !380, !400, !393, !394}
!400 = !DILocation(line: 187, column: 5, scope: !381)
!401 = !DILocation(line: 190, column: 35, scope: !349)
!402 = !DILocalVariable(name: "buf", arg: 1, scope: !403, file: !3, line: 118, type: !359)
!403 = distinct !DISubprogram(name: "aes_addRoundKey_cpy", scope: !3, file: !3, line: 118, type: !404, scopeLine: 119, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !406)
!404 = !DISubroutineType(types: !405)
!405 = !{null, !359, !359, !359}
!406 = !{!402, !407, !408, !409, !410}
!407 = !DILocalVariable(name: "key", arg: 2, scope: !403, file: !3, line: 118, type: !359)
!408 = !DILocalVariable(name: "cpk", arg: 3, scope: !403, file: !3, line: 118, type: !359)
!409 = !DILocalVariable(name: "i", scope: !403, file: !3, line: 120, type: !7)
!410 = !DILabel(scope: !403, name: "cpkey", file: !3, line: 122)
!411 = !DILocation(line: 0, scope: !403, inlinedAt: !412)
!412 = distinct !DILocation(line: 190, column: 5, scope: !349)
!413 = !DILocation(line: 122, column: 5, scope: !403, inlinedAt: !412)
!414 = !DILocation(line: 122, column: 13, scope: !403, inlinedAt: !412)
!415 = !DILocation(line: 122, column: 21, scope: !403, inlinedAt: !412)
!416 = !DILocation(line: 122, column: 46, scope: !403, inlinedAt: !412)
!417 = !DILocation(line: 122, column: 37, scope: !403, inlinedAt: !412)
!418 = !DILocation(line: 122, column: 44, scope: !403, inlinedAt: !412)
!419 = !DILocation(line: 122, column: 26, scope: !403, inlinedAt: !412)
!420 = !DILocation(line: 122, column: 33, scope: !403, inlinedAt: !412)
!421 = !DILocation(line: 122, column: 74, scope: !403, inlinedAt: !412)
!422 = !DILocation(line: 122, column: 67, scope: !403, inlinedAt: !412)
!423 = !DILocation(line: 122, column: 55, scope: !403, inlinedAt: !412)
!424 = !DILocation(line: 122, column: 65, scope: !403, inlinedAt: !412)
!425 = distinct !{!425, !414, !426, !393, !394}
!426 = !DILocation(line: 122, column: 77, scope: !403, inlinedAt: !412)
!427 = !DILocation(line: 191, column: 5, scope: !349)
!428 = !DILocation(line: 191, column: 28, scope: !429)
!429 = distinct !DILexicalBlock(scope: !349, file: !3, line: 191, column: 12)
!430 = distinct !DIAssignID()
!431 = !DILocalVariable(name: "buf", arg: 1, scope: !432, file: !3, line: 102, type: !359)
!432 = distinct !DISubprogram(name: "aes_subBytes", scope: !3, file: !3, line: 102, type: !433, scopeLine: 103, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !435)
!433 = !DISubroutineType(types: !434)
!434 = !{null, !359}
!435 = !{!431, !436, !437}
!436 = !DILocalVariable(name: "i", scope: !432, file: !3, line: 104, type: !7)
!437 = !DILabel(scope: !432, name: "sub", file: !3, line: 106)
!438 = !DILocation(line: 0, scope: !432, inlinedAt: !439)
!439 = distinct !DILocation(line: 193, column: 9, scope: !440)
!440 = distinct !DILexicalBlock(scope: !441, file: !3, line: 192, column: 5)
!441 = distinct !DILexicalBlock(scope: !429, file: !3, line: 191, column: 12)
!442 = !DILocation(line: 0, scope: !432, inlinedAt: !443)
!443 = distinct !DILocation(line: 199, column: 5, scope: !349)
!444 = !DILocation(line: 106, column: 5, scope: !432, inlinedAt: !439)
!445 = !DILocation(line: 106, column: 5, scope: !432, inlinedAt: !443)
!446 = !DILocation(line: 191, column: 12, scope: !429)
!447 = !DILocation(line: 106, column: 11, scope: !432, inlinedAt: !439)
!448 = !DILocation(line: 106, column: 19, scope: !432, inlinedAt: !439)
!449 = !DILocation(line: 106, column: 32, scope: !432, inlinedAt: !439)
!450 = !DILocation(line: 106, column: 30, scope: !432, inlinedAt: !439)
!451 = distinct !{!451, !447, !449, !393, !394}
!452 = !DILocalVariable(name: "buf", arg: 1, scope: !453, file: !3, line: 127, type: !359)
!453 = distinct !DISubprogram(name: "aes_shiftRows", scope: !3, file: !3, line: 127, type: !433, scopeLine: 128, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !454)
!454 = !{!452, !455, !456}
!455 = !DILocalVariable(name: "i", scope: !453, file: !3, line: 129, type: !7)
!456 = !DILocalVariable(name: "j", scope: !453, file: !3, line: 129, type: !7)
!457 = !DILocation(line: 0, scope: !453, inlinedAt: !458)
!458 = distinct !DILocation(line: 194, column: 9, scope: !440)
!459 = !DILocation(line: 131, column: 9, scope: !453, inlinedAt: !458)
!460 = !DILocation(line: 131, column: 26, scope: !453, inlinedAt: !458)
!461 = !DILocation(line: 131, column: 24, scope: !453, inlinedAt: !458)
!462 = !DILocation(line: 131, column: 43, scope: !453, inlinedAt: !458)
!463 = !DILocation(line: 131, column: 41, scope: !453, inlinedAt: !458)
!464 = !DILocation(line: 131, column: 60, scope: !453, inlinedAt: !458)
!465 = !DILocation(line: 131, column: 58, scope: !453, inlinedAt: !458)
!466 = !DILocation(line: 131, column: 77, scope: !453, inlinedAt: !458)
!467 = !DILocation(line: 132, column: 9, scope: !453, inlinedAt: !458)
!468 = !DILocation(line: 132, column: 28, scope: !453, inlinedAt: !458)
!469 = !DILocation(line: 132, column: 26, scope: !453, inlinedAt: !458)
!470 = !DILocation(line: 132, column: 43, scope: !453, inlinedAt: !458)
!471 = !DILocation(line: 133, column: 9, scope: !453, inlinedAt: !458)
!472 = !DILocation(line: 133, column: 26, scope: !453, inlinedAt: !458)
!473 = !DILocation(line: 133, column: 24, scope: !453, inlinedAt: !458)
!474 = !DILocation(line: 133, column: 45, scope: !453, inlinedAt: !458)
!475 = !DILocation(line: 133, column: 43, scope: !453, inlinedAt: !458)
!476 = !DILocation(line: 133, column: 64, scope: !453, inlinedAt: !458)
!477 = !DILocation(line: 133, column: 62, scope: !453, inlinedAt: !458)
!478 = !DILocation(line: 133, column: 79, scope: !453, inlinedAt: !458)
!479 = !DILocation(line: 134, column: 9, scope: !453, inlinedAt: !458)
!480 = !DILocation(line: 134, column: 28, scope: !453, inlinedAt: !458)
!481 = !DILocation(line: 134, column: 26, scope: !453, inlinedAt: !458)
!482 = !DILocation(line: 134, column: 44, scope: !453, inlinedAt: !458)
!483 = !DILocalVariable(name: "buf", arg: 1, scope: !484, file: !3, line: 139, type: !359)
!484 = distinct !DISubprogram(name: "aes_mixColumns", scope: !3, file: !3, line: 139, type: !433, scopeLine: 140, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !485)
!485 = !{!483, !486, !487, !488, !489, !490, !491, !492}
!486 = !DILocalVariable(name: "i", scope: !484, file: !3, line: 141, type: !7)
!487 = !DILocalVariable(name: "a", scope: !484, file: !3, line: 141, type: !7)
!488 = !DILocalVariable(name: "b", scope: !484, file: !3, line: 141, type: !7)
!489 = !DILocalVariable(name: "c", scope: !484, file: !3, line: 141, type: !7)
!490 = !DILocalVariable(name: "d", scope: !484, file: !3, line: 141, type: !7)
!491 = !DILocalVariable(name: "e", scope: !484, file: !3, line: 141, type: !7)
!492 = !DILabel(scope: !484, name: "mix", file: !3, line: 143)
!493 = !DILocation(line: 0, scope: !484, inlinedAt: !494)
!494 = distinct !DILocation(line: 195, column: 9, scope: !440)
!495 = !DILocation(line: 143, column: 5, scope: !484, inlinedAt: !494)
!496 = !DILocation(line: 145, column: 13, scope: !497, inlinedAt: !494)
!497 = distinct !DILexicalBlock(scope: !498, file: !3, line: 144, column: 5)
!498 = distinct !DILexicalBlock(scope: !499, file: !3, line: 143, column: 11)
!499 = distinct !DILexicalBlock(scope: !484, file: !3, line: 143, column: 11)
!500 = !DILocation(line: 145, column: 25, scope: !497, inlinedAt: !494)
!501 = !DILocation(line: 145, column: 41, scope: !497, inlinedAt: !494)
!502 = !DILocation(line: 145, column: 57, scope: !497, inlinedAt: !494)
!503 = !DILocation(line: 146, column: 15, scope: !497, inlinedAt: !494)
!504 = !DILocation(line: 146, column: 13, scope: !497, inlinedAt: !494)
!505 = !DILocation(line: 0, scope: !341, inlinedAt: !506)
!506 = distinct !DILocation(line: 147, column: 23, scope: !497, inlinedAt: !494)
!507 = !DILocation(line: 98, column: 12, scope: !341, inlinedAt: !506)
!508 = !DILocation(line: 147, column: 16, scope: !497, inlinedAt: !494)
!509 = !DILocation(line: 147, column: 66, scope: !497, inlinedAt: !494)
!510 = !DILocation(line: 0, scope: !341, inlinedAt: !511)
!511 = distinct !DILocation(line: 147, column: 56, scope: !497, inlinedAt: !494)
!512 = !DILocation(line: 98, column: 12, scope: !341, inlinedAt: !511)
!513 = !DILocation(line: 147, column: 49, scope: !497, inlinedAt: !494)
!514 = !DILocation(line: 148, column: 35, scope: !497, inlinedAt: !494)
!515 = !DILocation(line: 0, scope: !341, inlinedAt: !516)
!516 = distinct !DILocation(line: 148, column: 25, scope: !497, inlinedAt: !494)
!517 = !DILocation(line: 98, column: 12, scope: !341, inlinedAt: !516)
!518 = !DILocation(line: 148, column: 18, scope: !497, inlinedAt: !494)
!519 = !DILocation(line: 148, column: 66, scope: !497, inlinedAt: !494)
!520 = !DILocation(line: 0, scope: !341, inlinedAt: !521)
!521 = distinct !DILocation(line: 148, column: 56, scope: !497, inlinedAt: !494)
!522 = !DILocation(line: 98, column: 12, scope: !341, inlinedAt: !521)
!523 = !DILocation(line: 148, column: 49, scope: !497, inlinedAt: !494)
!524 = !DILocation(line: 143, column: 33, scope: !498, inlinedAt: !494)
!525 = !DILocation(line: 143, column: 25, scope: !498, inlinedAt: !494)
!526 = !DILocation(line: 143, column: 11, scope: !499, inlinedAt: !494)
!527 = distinct !{!527, !526, !528, !393, !394}
!528 = !DILocation(line: 149, column: 5, scope: !499, inlinedAt: !494)
!529 = !DILocation(line: 196, column: 15, scope: !530)
!530 = distinct !DILexicalBlock(scope: !440, file: !3, line: 196, column: 13)
!531 = !DILocation(line: 196, column: 13, scope: !440)
!532 = !DILocalVariable(name: "i", scope: !533, file: !3, line: 112, type: !7)
!533 = distinct !DISubprogram(name: "aes_addRoundKey", scope: !3, file: !3, line: 110, type: !534, scopeLine: 111, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !536)
!534 = !DISubroutineType(types: !535)
!535 = !{null, !359, !359}
!536 = !{!537, !538, !532, !539}
!537 = !DILocalVariable(name: "buf", arg: 1, scope: !533, file: !3, line: 110, type: !359)
!538 = !DILocalVariable(name: "key", arg: 2, scope: !533, file: !3, line: 110, type: !359)
!539 = !DILabel(scope: !533, name: "addkey", file: !3, line: 114)
!540 = !DILocation(line: 0, scope: !533, inlinedAt: !541)
!541 = distinct !DILocation(line: 196, column: 21, scope: !530)
!542 = !DILocation(line: 114, column: 22, scope: !533, inlinedAt: !541)
!543 = !DILocation(line: 114, column: 36, scope: !533, inlinedAt: !541)
!544 = !DILocation(line: 114, column: 26, scope: !533, inlinedAt: !541)
!545 = !DILocation(line: 114, column: 33, scope: !533, inlinedAt: !541)
!546 = !DILocation(line: 114, column: 14, scope: !533, inlinedAt: !541)
!547 = distinct !{!547, !546, !548, !393, !394}
!548 = !DILocation(line: 114, column: 41, scope: !533, inlinedAt: !541)
!549 = !DILocation(line: 197, column: 14, scope: !530)
!550 = !DILocation(line: 0, scope: !533, inlinedAt: !551)
!551 = distinct !DILocation(line: 197, column: 49, scope: !530)
!552 = !DILocation(line: 114, column: 5, scope: !533, inlinedAt: !551)
!553 = !DILocation(line: 114, column: 14, scope: !533, inlinedAt: !551)
!554 = !DILocation(line: 114, column: 22, scope: !533, inlinedAt: !551)
!555 = !DILocation(line: 114, column: 36, scope: !533, inlinedAt: !551)
!556 = !DILocation(line: 114, column: 26, scope: !533, inlinedAt: !551)
!557 = !DILocation(line: 114, column: 33, scope: !533, inlinedAt: !551)
!558 = distinct !{!558, !553, !559, !393, !394}
!559 = !DILocation(line: 114, column: 41, scope: !533, inlinedAt: !551)
!560 = !DILocation(line: 191, column: 41, scope: !441)
!561 = !DILocation(line: 191, column: 35, scope: !441)
!562 = distinct !{!562, !446, !563, !393, !394}
!563 = !DILocation(line: 198, column: 5, scope: !429)
!564 = !DILocation(line: 106, column: 19, scope: !432, inlinedAt: !443)
!565 = !DILocation(line: 106, column: 32, scope: !432, inlinedAt: !443)
!566 = !DILocation(line: 106, column: 30, scope: !432, inlinedAt: !443)
!567 = !DILocation(line: 106, column: 11, scope: !432, inlinedAt: !443)
!568 = distinct !{!568, !567, !565, !393, !394}
!569 = !DILocation(line: 0, scope: !453, inlinedAt: !570)
!570 = distinct !DILocation(line: 200, column: 5, scope: !349)
!571 = !DILocation(line: 131, column: 9, scope: !453, inlinedAt: !570)
!572 = !DILocation(line: 131, column: 26, scope: !453, inlinedAt: !570)
!573 = !DILocation(line: 131, column: 24, scope: !453, inlinedAt: !570)
!574 = !DILocation(line: 131, column: 43, scope: !453, inlinedAt: !570)
!575 = !DILocation(line: 131, column: 41, scope: !453, inlinedAt: !570)
!576 = !DILocation(line: 131, column: 60, scope: !453, inlinedAt: !570)
!577 = !DILocation(line: 131, column: 58, scope: !453, inlinedAt: !570)
!578 = !DILocation(line: 131, column: 77, scope: !453, inlinedAt: !570)
!579 = !DILocation(line: 132, column: 9, scope: !453, inlinedAt: !570)
!580 = !DILocation(line: 132, column: 28, scope: !453, inlinedAt: !570)
!581 = !DILocation(line: 132, column: 26, scope: !453, inlinedAt: !570)
!582 = !DILocation(line: 132, column: 43, scope: !453, inlinedAt: !570)
!583 = !DILocation(line: 133, column: 9, scope: !453, inlinedAt: !570)
!584 = !DILocation(line: 133, column: 26, scope: !453, inlinedAt: !570)
!585 = !DILocation(line: 133, column: 24, scope: !453, inlinedAt: !570)
!586 = !DILocation(line: 133, column: 45, scope: !453, inlinedAt: !570)
!587 = !DILocation(line: 133, column: 43, scope: !453, inlinedAt: !570)
!588 = !DILocation(line: 133, column: 64, scope: !453, inlinedAt: !570)
!589 = !DILocation(line: 133, column: 62, scope: !453, inlinedAt: !570)
!590 = !DILocation(line: 133, column: 79, scope: !453, inlinedAt: !570)
!591 = !DILocation(line: 134, column: 9, scope: !453, inlinedAt: !570)
!592 = !DILocation(line: 134, column: 28, scope: !453, inlinedAt: !570)
!593 = !DILocation(line: 134, column: 26, scope: !453, inlinedAt: !570)
!594 = !DILocation(line: 134, column: 44, scope: !453, inlinedAt: !570)
!595 = !DILocation(line: 201, column: 5, scope: !349)
!596 = !DILocation(line: 0, scope: !533, inlinedAt: !597)
!597 = distinct !DILocation(line: 202, column: 5, scope: !349)
!598 = !DILocation(line: 114, column: 5, scope: !533, inlinedAt: !597)
!599 = !DILocation(line: 114, column: 14, scope: !533, inlinedAt: !597)
!600 = !DILocation(line: 114, column: 22, scope: !533, inlinedAt: !597)
!601 = !DILocation(line: 114, column: 36, scope: !533, inlinedAt: !597)
!602 = !DILocation(line: 114, column: 26, scope: !533, inlinedAt: !597)
!603 = !DILocation(line: 114, column: 33, scope: !533, inlinedAt: !597)
!604 = distinct !{!604, !599, !605, !393, !394}
!605 = !DILocation(line: 114, column: 41, scope: !533, inlinedAt: !597)
!606 = !DILocation(line: 203, column: 1, scope: !349)
!607 = !{!608}
!608 = distinct !{!608, !609, !"polly.alias.scope.MemRef0"}
!609 = distinct !{!609, !"polly.alias.scope.domain"}
!610 = !{!611}
!611 = distinct !{!611, !609, !"polly.alias.scope.MemRef1"}
!612 = distinct !DISubprogram(name: "aes_expandEncKey", scope: !3, file: !3, line: 153, type: !534, scopeLine: 154, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !613)
!613 = !{!614, !615, !616, !617, !618}
!614 = !DILocalVariable(name: "k", arg: 1, scope: !612, file: !3, line: 153, type: !359)
!615 = !DILocalVariable(name: "rc", arg: 2, scope: !612, file: !3, line: 153, type: !359)
!616 = !DILocalVariable(name: "i", scope: !612, file: !3, line: 155, type: !7)
!617 = !DILabel(scope: !612, name: "exp1", file: !3, line: 163)
!618 = !DILabel(scope: !612, name: "exp2", file: !3, line: 170)
!619 = !DILocation(line: 0, scope: !612)
!620 = !DILocation(line: 157, column: 13, scope: !612)
!621 = !DILocation(line: 157, column: 31, scope: !612)
!622 = !DILocation(line: 157, column: 28, scope: !612)
!623 = !DILocation(line: 157, column: 10, scope: !612)
!624 = !DILocation(line: 158, column: 13, scope: !612)
!625 = !DILocation(line: 158, column: 5, scope: !612)
!626 = !DILocation(line: 158, column: 10, scope: !612)
!627 = !DILocation(line: 159, column: 13, scope: !612)
!628 = !DILocation(line: 159, column: 5, scope: !612)
!629 = !DILocation(line: 159, column: 10, scope: !612)
!630 = !DILocation(line: 160, column: 13, scope: !612)
!631 = !DILocation(line: 160, column: 5, scope: !612)
!632 = !DILocation(line: 160, column: 10, scope: !612)
!633 = !DILocation(line: 161, column: 11, scope: !612)
!634 = !DILocation(line: 161, column: 9, scope: !612)
!635 = !DILocation(line: 163, column: 5, scope: !612)
!636 = !DILocation(line: 163, column: 12, scope: !637)
!637 = distinct !DILexicalBlock(scope: !612, file: !3, line: 163, column: 12)
!638 = !DILocation(line: 163, column: 48, scope: !639)
!639 = distinct !DILexicalBlock(scope: !637, file: !3, line: 163, column: 12)
!640 = !DILocation(line: 163, column: 45, scope: !639)
!641 = !DILocation(line: 163, column: 68, scope: !639)
!642 = !DILocation(line: 163, column: 58, scope: !639)
!643 = !DILocation(line: 163, column: 65, scope: !639)
!644 = !DILocation(line: 164, column: 19, scope: !639)
!645 = !DILocation(line: 164, column: 9, scope: !639)
!646 = !DILocation(line: 164, column: 16, scope: !639)
!647 = !DILocation(line: 164, column: 37, scope: !639)
!648 = !DILocation(line: 164, column: 27, scope: !639)
!649 = !DILocation(line: 164, column: 34, scope: !639)
!650 = !DILocation(line: 163, column: 33, scope: !639)
!651 = !DILocation(line: 163, column: 25, scope: !639)
!652 = distinct !{!652, !636, !653, !393, !394}
!653 = !DILocation(line: 164, column: 42, scope: !637)
!654 = !DILocation(line: 165, column: 14, scope: !612)
!655 = !DILocation(line: 165, column: 5, scope: !612)
!656 = !DILocation(line: 165, column: 11, scope: !612)
!657 = !DILocation(line: 166, column: 14, scope: !612)
!658 = !DILocation(line: 166, column: 5, scope: !612)
!659 = !DILocation(line: 166, column: 11, scope: !612)
!660 = !DILocation(line: 167, column: 14, scope: !612)
!661 = !DILocation(line: 167, column: 5, scope: !612)
!662 = !DILocation(line: 167, column: 11, scope: !612)
!663 = !DILocation(line: 168, column: 14, scope: !612)
!664 = !DILocation(line: 168, column: 5, scope: !612)
!665 = !DILocation(line: 168, column: 11, scope: !612)
!666 = !DILocation(line: 170, column: 5, scope: !612)
!667 = !DILocation(line: 170, column: 12, scope: !668)
!668 = distinct !DILexicalBlock(scope: !612, file: !3, line: 170, column: 12)
!669 = !DILocation(line: 170, column: 48, scope: !670)
!670 = distinct !DILexicalBlock(scope: !668, file: !3, line: 170, column: 12)
!671 = !DILocation(line: 170, column: 45, scope: !670)
!672 = !DILocation(line: 170, column: 68, scope: !670)
!673 = !DILocation(line: 170, column: 58, scope: !670)
!674 = !DILocation(line: 170, column: 65, scope: !670)
!675 = !DILocation(line: 171, column: 19, scope: !670)
!676 = !DILocation(line: 171, column: 9, scope: !670)
!677 = !DILocation(line: 171, column: 16, scope: !670)
!678 = !DILocation(line: 171, column: 37, scope: !670)
!679 = !DILocation(line: 171, column: 27, scope: !670)
!680 = !DILocation(line: 171, column: 34, scope: !670)
!681 = !DILocation(line: 170, column: 34, scope: !670)
!682 = !DILocation(line: 170, column: 26, scope: !670)
!683 = distinct !{!683, !667, !684, !393, !394}
!684 = !DILocation(line: 171, column: 42, scope: !668)
!685 = !DILocation(line: 173, column: 1, scope: !612)
!686 = distinct !DISubprogram(name: "run_benchmark", scope: !203, file: !203, line: 6, type: !687, scopeLine: 6, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !202, retainedNodes: !689)
!687 = !DISubroutineType(types: !688)
!688 = !{null, !250}
!689 = !{!690, !691}
!690 = !DILocalVariable(name: "vargs", arg: 1, scope: !686, file: !203, line: 6, type: !250)
!691 = !DILocalVariable(name: "args", scope: !686, file: !203, line: 7, type: !205)
!692 = !DILocation(line: 0, scope: !686)
!693 = !DILocation(line: 8, column: 28, scope: !686)
!694 = !DILocation(line: 8, column: 37, scope: !686)
!695 = !DILocation(line: 8, column: 3, scope: !686)
!696 = !DILocation(line: 9, column: 1, scope: !686)
!697 = distinct !DISubprogram(name: "input_to_data", scope: !203, file: !203, line: 18, type: !698, scopeLine: 18, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !202, retainedNodes: !700)
!698 = !DISubroutineType(types: !699)
!699 = !{null, !225, !250}
!700 = !{!701, !702, !703, !704, !705}
!701 = !DILocalVariable(name: "fd", arg: 1, scope: !697, file: !203, line: 18, type: !225)
!702 = !DILocalVariable(name: "vdata", arg: 2, scope: !697, file: !203, line: 18, type: !250)
!703 = !DILocalVariable(name: "data", scope: !697, file: !203, line: 19, type: !205)
!704 = !DILocalVariable(name: "p", scope: !697, file: !203, line: 20, type: !249)
!705 = !DILocalVariable(name: "s", scope: !697, file: !203, line: 20, type: !249)
!706 = !DILocation(line: 0, scope: !697)
!707 = !DILocation(line: 22, column: 3, scope: !697)
!708 = !DILocation(line: 24, column: 7, scope: !697)
!709 = !DILocalVariable(name: "s", arg: 1, scope: !710, file: !16, line: 56, type: !249)
!710 = distinct !DISubprogram(name: "find_section_start", scope: !16, file: !16, line: 56, type: !711, scopeLine: 56, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !713)
!711 = !DISubroutineType(types: !712)
!712 = !{!249, !249, !225}
!713 = !{!709, !714, !715}
!714 = !DILocalVariable(name: "n", arg: 2, scope: !710, file: !16, line: 56, type: !225)
!715 = !DILocalVariable(name: "i", scope: !710, file: !16, line: 57, type: !225)
!716 = !DILocation(line: 0, scope: !710, inlinedAt: !717)
!717 = distinct !DILocation(line: 26, column: 7, scope: !697)
!718 = !DILocation(line: 64, column: 17, scope: !710, inlinedAt: !717)
!719 = !DILocation(line: 64, column: 3, scope: !710, inlinedAt: !717)
!720 = !DILocation(line: 66, column: 22, scope: !721, inlinedAt: !717)
!721 = distinct !DILexicalBlock(scope: !722, file: !16, line: 66, column: 9)
!722 = distinct !DILexicalBlock(scope: !710, file: !16, line: 64, column: 31)
!723 = !DILocation(line: 66, column: 26, scope: !721, inlinedAt: !717)
!724 = !DILocation(line: 66, column: 32, scope: !721, inlinedAt: !717)
!725 = !DILocation(line: 66, column: 35, scope: !721, inlinedAt: !717)
!726 = !DILocation(line: 66, column: 39, scope: !721, inlinedAt: !717)
!727 = !DILocation(line: 66, column: 9, scope: !722, inlinedAt: !717)
!728 = !DILocation(line: 69, column: 6, scope: !722, inlinedAt: !717)
!729 = !DILocation(line: 64, column: 10, scope: !710, inlinedAt: !717)
!730 = !DILocation(line: 64, column: 13, scope: !710, inlinedAt: !717)
!731 = distinct !{!731, !719, !732, !393, !394}
!732 = !DILocation(line: 70, column: 3, scope: !710, inlinedAt: !717)
!733 = !DILocation(line: 71, column: 6, scope: !734, inlinedAt: !717)
!734 = distinct !DILexicalBlock(scope: !710, file: !16, line: 71, column: 6)
!735 = !DILocation(line: 71, column: 8, scope: !734, inlinedAt: !717)
!736 = !DILocation(line: 71, column: 6, scope: !710, inlinedAt: !717)
!737 = !DILocation(line: 27, column: 32, scope: !697)
!738 = !DILocation(line: 27, column: 3, scope: !697)
!739 = !DILocation(line: 0, scope: !710, inlinedAt: !740)
!740 = distinct !DILocation(line: 29, column: 7, scope: !697)
!741 = !DILocation(line: 64, column: 17, scope: !710, inlinedAt: !740)
!742 = !DILocation(line: 64, column: 3, scope: !710, inlinedAt: !740)
!743 = !DILocation(line: 66, column: 22, scope: !721, inlinedAt: !740)
!744 = !DILocation(line: 66, column: 26, scope: !721, inlinedAt: !740)
!745 = !DILocation(line: 66, column: 32, scope: !721, inlinedAt: !740)
!746 = !DILocation(line: 66, column: 35, scope: !721, inlinedAt: !740)
!747 = !DILocation(line: 66, column: 39, scope: !721, inlinedAt: !740)
!748 = !DILocation(line: 66, column: 9, scope: !722, inlinedAt: !740)
!749 = !DILocation(line: 69, column: 6, scope: !722, inlinedAt: !740)
!750 = !DILocation(line: 64, column: 10, scope: !710, inlinedAt: !740)
!751 = !DILocation(line: 64, column: 13, scope: !710, inlinedAt: !740)
!752 = distinct !{!752, !742, !753, !393, !394}
!753 = !DILocation(line: 70, column: 3, scope: !710, inlinedAt: !740)
!754 = !DILocation(line: 71, column: 6, scope: !734, inlinedAt: !740)
!755 = !DILocation(line: 71, column: 8, scope: !734, inlinedAt: !740)
!756 = !DILocation(line: 71, column: 6, scope: !710, inlinedAt: !740)
!757 = !DILocation(line: 30, column: 32, scope: !697)
!758 = !DILocation(line: 30, column: 3, scope: !697)
!759 = !DILocation(line: 31, column: 3, scope: !697)
!760 = !DILocation(line: 32, column: 1, scope: !697)
!761 = !DISubprogram(name: "free", scope: !762, file: !762, line: 687, type: !687, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!762 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdlib.h", directory: "")
!763 = distinct !DISubprogram(name: "data_to_input", scope: !203, file: !203, line: 34, type: !698, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !202, retainedNodes: !764)
!764 = !{!765, !766, !767}
!765 = !DILocalVariable(name: "fd", arg: 1, scope: !763, file: !203, line: 34, type: !225)
!766 = !DILocalVariable(name: "vdata", arg: 2, scope: !763, file: !203, line: 34, type: !250)
!767 = !DILocalVariable(name: "data", scope: !763, file: !203, line: 35, type: !205)
!768 = !DILocation(line: 0, scope: !763)
!769 = !DILocalVariable(name: "fd", arg: 1, scope: !770, file: !16, line: 189, type: !225)
!770 = distinct !DISubprogram(name: "write_section_header", scope: !16, file: !16, line: 189, type: !771, scopeLine: 189, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !773)
!771 = !DISubroutineType(types: !772)
!772 = !{!225, !225}
!773 = !{!769}
!774 = !DILocation(line: 0, scope: !770, inlinedAt: !775)
!775 = distinct !DILocation(line: 37, column: 3, scope: !763)
!776 = !DILocation(line: 190, column: 3, scope: !777, inlinedAt: !775)
!777 = distinct !DILexicalBlock(scope: !778, file: !16, line: 190, column: 3)
!778 = distinct !DILexicalBlock(scope: !770, file: !16, line: 190, column: 3)
!779 = !DILocation(line: 191, column: 3, scope: !770, inlinedAt: !775)
!780 = !DILocation(line: 38, column: 33, scope: !763)
!781 = !DILocalVariable(name: "fd", arg: 1, scope: !782, file: !16, line: 177, type: !225)
!782 = distinct !DISubprogram(name: "write_uint8_t_array", scope: !16, file: !16, line: 177, type: !783, scopeLine: 177, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !785)
!783 = !DISubroutineType(types: !784)
!784 = !{!225, !225, !359, !225}
!785 = !{!781, !786, !787, !788}
!786 = !DILocalVariable(name: "arr", arg: 2, scope: !782, file: !16, line: 177, type: !359)
!787 = !DILocalVariable(name: "n", arg: 3, scope: !782, file: !16, line: 177, type: !225)
!788 = !DILocalVariable(name: "i", scope: !782, file: !16, line: 177, type: !225)
!789 = !DILocation(line: 0, scope: !782, inlinedAt: !790)
!790 = distinct !DILocation(line: 38, column: 3, scope: !763)
!791 = !DILocation(line: 177, column: 1, scope: !792, inlinedAt: !790)
!792 = distinct !DILexicalBlock(scope: !782, file: !16, line: 177, column: 1)
!793 = !DILocation(line: 177, column: 1, scope: !794, inlinedAt: !790)
!794 = distinct !DILexicalBlock(scope: !795, file: !16, line: 177, column: 1)
!795 = distinct !DILexicalBlock(scope: !792, file: !16, line: 177, column: 1)
!796 = !DILocation(line: 177, column: 1, scope: !795, inlinedAt: !790)
!797 = distinct !{!797, !791, !791, !393, !394}
!798 = !DILocation(line: 0, scope: !770, inlinedAt: !799)
!799 = distinct !DILocation(line: 40, column: 3, scope: !763)
!800 = !DILocation(line: 191, column: 3, scope: !770, inlinedAt: !799)
!801 = !DILocation(line: 41, column: 33, scope: !763)
!802 = !DILocation(line: 0, scope: !782, inlinedAt: !803)
!803 = distinct !DILocation(line: 41, column: 3, scope: !763)
!804 = !DILocation(line: 177, column: 1, scope: !792, inlinedAt: !803)
!805 = !DILocation(line: 177, column: 1, scope: !794, inlinedAt: !803)
!806 = !DILocation(line: 177, column: 1, scope: !795, inlinedAt: !803)
!807 = distinct !{!807, !804, !804, !393, !394}
!808 = !DILocation(line: 42, column: 1, scope: !763)
!809 = distinct !DISubprogram(name: "output_to_data", scope: !203, file: !203, line: 49, type: !698, scopeLine: 49, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !202, retainedNodes: !810)
!810 = !{!811, !812, !813, !814, !815}
!811 = !DILocalVariable(name: "fd", arg: 1, scope: !809, file: !203, line: 49, type: !225)
!812 = !DILocalVariable(name: "vdata", arg: 2, scope: !809, file: !203, line: 49, type: !250)
!813 = !DILocalVariable(name: "data", scope: !809, file: !203, line: 50, type: !205)
!814 = !DILocalVariable(name: "p", scope: !809, file: !203, line: 52, type: !249)
!815 = !DILocalVariable(name: "s", scope: !809, file: !203, line: 52, type: !249)
!816 = !DILocation(line: 0, scope: !809)
!817 = !DILocation(line: 54, column: 3, scope: !809)
!818 = !DILocation(line: 56, column: 7, scope: !809)
!819 = !DILocation(line: 0, scope: !710, inlinedAt: !820)
!820 = distinct !DILocation(line: 58, column: 7, scope: !809)
!821 = !DILocation(line: 64, column: 17, scope: !710, inlinedAt: !820)
!822 = !DILocation(line: 64, column: 3, scope: !710, inlinedAt: !820)
!823 = !DILocation(line: 66, column: 22, scope: !721, inlinedAt: !820)
!824 = !DILocation(line: 66, column: 26, scope: !721, inlinedAt: !820)
!825 = !DILocation(line: 66, column: 32, scope: !721, inlinedAt: !820)
!826 = !DILocation(line: 66, column: 35, scope: !721, inlinedAt: !820)
!827 = !DILocation(line: 66, column: 39, scope: !721, inlinedAt: !820)
!828 = !DILocation(line: 66, column: 9, scope: !722, inlinedAt: !820)
!829 = !DILocation(line: 69, column: 6, scope: !722, inlinedAt: !820)
!830 = !DILocation(line: 64, column: 10, scope: !710, inlinedAt: !820)
!831 = !DILocation(line: 64, column: 13, scope: !710, inlinedAt: !820)
!832 = distinct !{!832, !822, !833, !393, !394}
!833 = !DILocation(line: 70, column: 3, scope: !710, inlinedAt: !820)
!834 = !DILocation(line: 71, column: 6, scope: !734, inlinedAt: !820)
!835 = !DILocation(line: 71, column: 8, scope: !734, inlinedAt: !820)
!836 = !DILocation(line: 71, column: 6, scope: !710, inlinedAt: !820)
!837 = !DILocation(line: 59, column: 32, scope: !809)
!838 = !DILocation(line: 59, column: 3, scope: !809)
!839 = !DILocation(line: 60, column: 3, scope: !809)
!840 = !DILocation(line: 61, column: 1, scope: !809)
!841 = distinct !DISubprogram(name: "data_to_output", scope: !203, file: !203, line: 63, type: !698, scopeLine: 63, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !202, retainedNodes: !842)
!842 = !{!843, !844, !845}
!843 = !DILocalVariable(name: "fd", arg: 1, scope: !841, file: !203, line: 63, type: !225)
!844 = !DILocalVariable(name: "vdata", arg: 2, scope: !841, file: !203, line: 63, type: !250)
!845 = !DILocalVariable(name: "data", scope: !841, file: !203, line: 64, type: !205)
!846 = !DILocation(line: 0, scope: !841)
!847 = !DILocation(line: 0, scope: !770, inlinedAt: !848)
!848 = distinct !DILocation(line: 66, column: 3, scope: !841)
!849 = !DILocation(line: 190, column: 3, scope: !777, inlinedAt: !848)
!850 = !DILocation(line: 191, column: 3, scope: !770, inlinedAt: !848)
!851 = !DILocation(line: 67, column: 33, scope: !841)
!852 = !DILocation(line: 0, scope: !782, inlinedAt: !853)
!853 = distinct !DILocation(line: 67, column: 3, scope: !841)
!854 = !DILocation(line: 177, column: 1, scope: !792, inlinedAt: !853)
!855 = !DILocation(line: 177, column: 1, scope: !794, inlinedAt: !853)
!856 = !DILocation(line: 177, column: 1, scope: !795, inlinedAt: !853)
!857 = distinct !{!857, !854, !854, !393, !394}
!858 = !DILocation(line: 68, column: 1, scope: !841)
!859 = distinct !DISubprogram(name: "check_data", scope: !203, file: !203, line: 70, type: !860, scopeLine: 70, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !202, retainedNodes: !862)
!860 = !DISubroutineType(types: !861)
!861 = !{!225, !250, !250}
!862 = !{!863, !864, !865, !866, !867}
!863 = !DILocalVariable(name: "vdata", arg: 1, scope: !859, file: !203, line: 70, type: !250)
!864 = !DILocalVariable(name: "vref", arg: 2, scope: !859, file: !203, line: 70, type: !250)
!865 = !DILocalVariable(name: "data", scope: !859, file: !203, line: 71, type: !205)
!866 = !DILocalVariable(name: "ref", scope: !859, file: !203, line: 72, type: !205)
!867 = !DILocalVariable(name: "has_errors", scope: !859, file: !203, line: 73, type: !225)
!868 = !DILocation(line: 0, scope: !859)
!869 = !DILocation(line: 76, column: 31, scope: !859)
!870 = !DILocation(line: 76, column: 42, scope: !859)
!871 = !DILocation(line: 76, column: 17, scope: !859)
!872 = !DILocation(line: 79, column: 10, scope: !859)
!873 = !DILocation(line: 79, column: 3, scope: !859)
!874 = distinct !DISubprogram(name: "readfile", scope: !16, file: !16, line: 34, type: !875, scopeLine: 34, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !877)
!875 = !DISubroutineType(types: !876)
!876 = !{!249, !225}
!877 = !{!878, !879, !880, !917, !920, !923}
!878 = !DILocalVariable(name: "fd", arg: 1, scope: !874, file: !16, line: 34, type: !225)
!879 = !DILocalVariable(name: "p", scope: !874, file: !16, line: 35, type: !249)
!880 = !DILocalVariable(name: "s", scope: !874, file: !16, line: 36, type: !881)
!881 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "stat", file: !882, line: 44, size: 1024, elements: !883)
!882 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/struct_stat.h", directory: "")
!883 = !{!884, !886, !888, !890, !892, !894, !896, !897, !898, !900, !902, !903, !905, !913, !914, !915}
!884 = !DIDerivedType(tag: DW_TAG_member, name: "st_dev", scope: !881, file: !882, line: 46, baseType: !885, size: 64)
!885 = !DIDerivedType(tag: DW_TAG_typedef, name: "__dev_t", file: !10, line: 145, baseType: !259)
!886 = !DIDerivedType(tag: DW_TAG_member, name: "st_ino", scope: !881, file: !882, line: 47, baseType: !887, size: 64, offset: 64)
!887 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ino_t", file: !10, line: 148, baseType: !259)
!888 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !881, file: !882, line: 48, baseType: !889, size: 32, offset: 128)
!889 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !10, line: 150, baseType: !256)
!890 = !DIDerivedType(tag: DW_TAG_member, name: "st_nlink", scope: !881, file: !882, line: 49, baseType: !891, size: 32, offset: 160)
!891 = !DIDerivedType(tag: DW_TAG_typedef, name: "__nlink_t", file: !10, line: 151, baseType: !256)
!892 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !881, file: !882, line: 50, baseType: !893, size: 32, offset: 192)
!893 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !10, line: 146, baseType: !256)
!894 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !881, file: !882, line: 51, baseType: !895, size: 32, offset: 224)
!895 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !10, line: 147, baseType: !256)
!896 = !DIDerivedType(tag: DW_TAG_member, name: "st_rdev", scope: !881, file: !882, line: 52, baseType: !885, size: 64, offset: 256)
!897 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !881, file: !882, line: 53, baseType: !885, size: 64, offset: 320)
!898 = !DIDerivedType(tag: DW_TAG_member, name: "st_size", scope: !881, file: !882, line: 54, baseType: !899, size: 64, offset: 384)
!899 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !10, line: 152, baseType: !271)
!900 = !DIDerivedType(tag: DW_TAG_member, name: "st_blksize", scope: !881, file: !882, line: 55, baseType: !901, size: 32, offset: 448)
!901 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blksize_t", file: !10, line: 175, baseType: !225)
!902 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !881, file: !882, line: 56, baseType: !225, size: 32, offset: 480)
!903 = !DIDerivedType(tag: DW_TAG_member, name: "st_blocks", scope: !881, file: !882, line: 57, baseType: !904, size: 64, offset: 512)
!904 = !DIDerivedType(tag: DW_TAG_typedef, name: "__blkcnt_t", file: !10, line: 180, baseType: !271)
!905 = !DIDerivedType(tag: DW_TAG_member, name: "st_atim", scope: !881, file: !882, line: 65, baseType: !906, size: 128, offset: 576)
!906 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !907, line: 11, size: 128, elements: !908)
!907 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_timespec.h", directory: "")
!908 = !{!909, !911}
!909 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !906, file: !907, line: 16, baseType: !910, size: 64)
!910 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !10, line: 160, baseType: !271)
!911 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !906, file: !907, line: 21, baseType: !912, size: 64, offset: 64)
!912 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !10, line: 197, baseType: !271)
!913 = !DIDerivedType(tag: DW_TAG_member, name: "st_mtim", scope: !881, file: !882, line: 66, baseType: !906, size: 128, offset: 704)
!914 = !DIDerivedType(tag: DW_TAG_member, name: "st_ctim", scope: !881, file: !882, line: 67, baseType: !906, size: 128, offset: 832)
!915 = !DIDerivedType(tag: DW_TAG_member, name: "__glibc_reserved", scope: !881, file: !882, line: 79, baseType: !916, size: 64, offset: 960)
!916 = !DICompositeType(tag: DW_TAG_array_type, baseType: !225, size: 64, elements: !69)
!917 = !DILocalVariable(name: "len", scope: !874, file: !16, line: 37, type: !918)
!918 = !DIDerivedType(tag: DW_TAG_typedef, name: "off_t", file: !919, line: 85, baseType: !899)
!919 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/types.h", directory: "")
!920 = !DILocalVariable(name: "bytes_read", scope: !874, file: !16, line: 38, type: !921)
!921 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !919, line: 108, baseType: !922)
!922 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !10, line: 194, baseType: !271)
!923 = !DILocalVariable(name: "status", scope: !874, file: !16, line: 38, type: !921)
!924 = distinct !DIAssignID()
!925 = !DILocation(line: 0, scope: !874)
!926 = !DILocation(line: 36, column: 3, scope: !874)
!927 = !DILocation(line: 40, column: 3, scope: !928)
!928 = distinct !DILexicalBlock(scope: !929, file: !16, line: 40, column: 3)
!929 = distinct !DILexicalBlock(scope: !874, file: !16, line: 40, column: 3)
!930 = !DILocation(line: 41, column: 3, scope: !931)
!931 = distinct !DILexicalBlock(scope: !932, file: !16, line: 41, column: 3)
!932 = distinct !DILexicalBlock(scope: !874, file: !16, line: 41, column: 3)
!933 = !DILocation(line: 42, column: 11, scope: !874)
!934 = !DILocation(line: 43, column: 3, scope: !935)
!935 = distinct !DILexicalBlock(scope: !936, file: !16, line: 43, column: 3)
!936 = distinct !DILexicalBlock(scope: !874, file: !16, line: 43, column: 3)
!937 = !DILocation(line: 44, column: 25, scope: !874)
!938 = !DILocation(line: 44, column: 15, scope: !874)
!939 = !DILocation(line: 46, column: 3, scope: !874)
!940 = !DILocation(line: 49, column: 15, scope: !941)
!941 = distinct !DILexicalBlock(scope: !874, file: !16, line: 46, column: 27)
!942 = !DILocation(line: 46, column: 20, scope: !874)
!943 = distinct !{!943, !939, !944, !393, !394}
!944 = !DILocation(line: 50, column: 3, scope: !874)
!945 = !DILocation(line: 47, column: 24, scope: !941)
!946 = !DILocation(line: 47, column: 42, scope: !941)
!947 = !DILocation(line: 47, column: 14, scope: !941)
!948 = !DILocation(line: 48, column: 5, scope: !949)
!949 = distinct !DILexicalBlock(scope: !950, file: !16, line: 48, column: 5)
!950 = distinct !DILexicalBlock(scope: !941, file: !16, line: 48, column: 5)
!951 = !DILocation(line: 51, column: 3, scope: !874)
!952 = !DILocation(line: 51, column: 10, scope: !874)
!953 = !DILocation(line: 52, column: 3, scope: !874)
!954 = !DILocation(line: 54, column: 1, scope: !874)
!955 = !DILocation(line: 53, column: 3, scope: !874)
!956 = !DISubprogram(name: "__assert_fail", scope: !957, file: !957, line: 67, type: !958, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: DISPFlagOptimized)
!957 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/assert.h", directory: "")
!958 = !DISubroutineType(types: !959)
!959 = !{null, !960, !960, !256, !960}
!960 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!961 = !DISubprogram(name: "fstat", scope: !962, file: !962, line: 210, type: !963, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!962 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/sys/stat.h", directory: "")
!963 = !DISubroutineType(types: !964)
!964 = !{!225, !225, !965}
!965 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !881, size: 64)
!966 = !DISubprogram(name: "malloc", scope: !762, file: !762, line: 672, type: !967, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!967 = !DISubroutineType(types: !968)
!968 = !{!250, !969}
!969 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !970, line: 18, baseType: !259)
!970 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stddef_size_t.h", directory: "")
!971 = !DISubprogram(name: "read", scope: !972, file: !972, line: 371, type: !973, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!972 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/unistd.h", directory: "")
!973 = !DISubroutineType(types: !974)
!974 = !{!921, !225, !250, !969}
!975 = !DISubprogram(name: "close", scope: !972, file: !972, line: 358, type: !771, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!976 = !DILocation(line: 0, scope: !710)
!977 = !DILocation(line: 59, column: 3, scope: !978)
!978 = distinct !DILexicalBlock(scope: !979, file: !16, line: 59, column: 3)
!979 = distinct !DILexicalBlock(scope: !710, file: !16, line: 59, column: 3)
!980 = !DILocation(line: 60, column: 7, scope: !981)
!981 = distinct !DILexicalBlock(scope: !710, file: !16, line: 60, column: 6)
!982 = !DILocation(line: 60, column: 6, scope: !710)
!983 = !DILocation(line: 64, column: 17, scope: !710)
!984 = !DILocation(line: 64, column: 3, scope: !710)
!985 = !DILocation(line: 66, column: 22, scope: !721)
!986 = !DILocation(line: 66, column: 26, scope: !721)
!987 = !DILocation(line: 66, column: 32, scope: !721)
!988 = !DILocation(line: 66, column: 35, scope: !721)
!989 = !DILocation(line: 66, column: 39, scope: !721)
!990 = !DILocation(line: 66, column: 9, scope: !722)
!991 = !DILocation(line: 69, column: 6, scope: !722)
!992 = !DILocation(line: 64, column: 10, scope: !710)
!993 = !DILocation(line: 64, column: 13, scope: !710)
!994 = distinct !{!994, !984, !995, !393, !394}
!995 = !DILocation(line: 70, column: 3, scope: !710)
!996 = !DILocation(line: 71, column: 6, scope: !734)
!997 = !DILocation(line: 71, column: 8, scope: !734)
!998 = !DILocation(line: 71, column: 6, scope: !710)
!999 = !DILocation(line: 74, column: 1, scope: !710)
!1000 = distinct !DISubprogram(name: "parse_string", scope: !16, file: !16, line: 77, type: !1001, scopeLine: 77, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1003)
!1001 = !DISubroutineType(types: !1002)
!1002 = !{!225, !249, !249, !225}
!1003 = !{!1004, !1005, !1006, !1007}
!1004 = !DILocalVariable(name: "s", arg: 1, scope: !1000, file: !16, line: 77, type: !249)
!1005 = !DILocalVariable(name: "arr", arg: 2, scope: !1000, file: !16, line: 77, type: !249)
!1006 = !DILocalVariable(name: "n", arg: 3, scope: !1000, file: !16, line: 77, type: !225)
!1007 = !DILocalVariable(name: "k", scope: !1000, file: !16, line: 78, type: !225)
!1008 = !DILocation(line: 0, scope: !1000)
!1009 = !DILocation(line: 79, column: 3, scope: !1010)
!1010 = distinct !DILexicalBlock(scope: !1011, file: !16, line: 79, column: 3)
!1011 = distinct !DILexicalBlock(scope: !1000, file: !16, line: 79, column: 3)
!1012 = !DILocation(line: 81, column: 8, scope: !1013)
!1013 = distinct !DILexicalBlock(scope: !1000, file: !16, line: 81, column: 7)
!1014 = !DILocation(line: 81, column: 7, scope: !1000)
!1015 = !DILocation(line: 83, column: 12, scope: !1016)
!1016 = distinct !DILexicalBlock(scope: !1013, file: !16, line: 81, column: 13)
!1017 = !DILocation(line: 83, column: 5, scope: !1016)
!1018 = !DILocation(line: 91, column: 19, scope: !1000)
!1019 = !DILocation(line: 91, column: 3, scope: !1000)
!1020 = !DILocation(line: 92, column: 7, scope: !1000)
!1021 = !DILocation(line: 83, column: 16, scope: !1016)
!1022 = !DILocation(line: 83, column: 26, scope: !1016)
!1023 = !DILocation(line: 83, column: 32, scope: !1016)
!1024 = !DILocation(line: 83, column: 29, scope: !1016)
!1025 = !DILocation(line: 83, column: 35, scope: !1016)
!1026 = !DILocation(line: 83, column: 45, scope: !1016)
!1027 = !DILocation(line: 83, column: 48, scope: !1016)
!1028 = !DILocation(line: 83, column: 54, scope: !1016)
!1029 = !DILocation(line: 84, column: 9, scope: !1016)
!1030 = !DILocation(line: 84, column: 18, scope: !1016)
!1031 = !DILocation(line: 84, column: 26, scope: !1016)
!1032 = distinct !{!1032, !1017, !1033, !393, !394}
!1033 = !DILocation(line: 86, column: 5, scope: !1016)
!1034 = !DILocation(line: 93, column: 5, scope: !1035)
!1035 = distinct !DILexicalBlock(scope: !1000, file: !16, line: 92, column: 7)
!1036 = !DILocation(line: 93, column: 12, scope: !1035)
!1037 = !DILocation(line: 95, column: 3, scope: !1000)
!1038 = distinct !DISubprogram(name: "parse_uint8_t_array", scope: !16, file: !16, line: 132, type: !1039, scopeLine: 132, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1041)
!1039 = !DISubroutineType(types: !1040)
!1040 = !{!225, !249, !359, !225}
!1041 = !{!1042, !1043, !1044, !1045, !1046, !1047, !1048}
!1042 = !DILocalVariable(name: "s", arg: 1, scope: !1038, file: !16, line: 132, type: !249)
!1043 = !DILocalVariable(name: "arr", arg: 2, scope: !1038, file: !16, line: 132, type: !359)
!1044 = !DILocalVariable(name: "n", arg: 3, scope: !1038, file: !16, line: 132, type: !225)
!1045 = !DILocalVariable(name: "line", scope: !1038, file: !16, line: 132, type: !249)
!1046 = !DILocalVariable(name: "endptr", scope: !1038, file: !16, line: 132, type: !249)
!1047 = !DILocalVariable(name: "i", scope: !1038, file: !16, line: 132, type: !225)
!1048 = !DILocalVariable(name: "v", scope: !1038, file: !16, line: 132, type: !7)
!1049 = distinct !DIAssignID()
!1050 = !DILocation(line: 0, scope: !1038)
!1051 = !DILocation(line: 132, column: 1, scope: !1038)
!1052 = !DILocation(line: 132, column: 1, scope: !1053)
!1053 = distinct !DILexicalBlock(scope: !1054, file: !16, line: 132, column: 1)
!1054 = distinct !DILexicalBlock(scope: !1038, file: !16, line: 132, column: 1)
!1055 = !DILocation(line: 132, column: 1, scope: !1056)
!1056 = distinct !DILexicalBlock(scope: !1038, file: !16, line: 132, column: 1)
!1057 = !{!1058, !1058, i64 0}
!1058 = !{!"any pointer", !374, i64 0}
!1059 = distinct !DIAssignID()
!1060 = !DILocation(line: 132, column: 1, scope: !1061)
!1061 = distinct !DILexicalBlock(scope: !1056, file: !16, line: 132, column: 1)
!1062 = !DILocation(line: 132, column: 1, scope: !1063)
!1063 = distinct !DILexicalBlock(scope: !1061, file: !16, line: 132, column: 1)
!1064 = distinct !{!1064, !1051, !1051, !393, !394}
!1065 = !DILocation(line: 132, column: 1, scope: !1066)
!1066 = distinct !DILexicalBlock(scope: !1067, file: !16, line: 132, column: 1)
!1067 = distinct !DILexicalBlock(scope: !1038, file: !16, line: 132, column: 1)
!1068 = !DISubprogram(name: "strtok", scope: !1069, file: !1069, line: 356, type: !1070, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1069 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/string.h", directory: "")
!1070 = !DISubroutineType(types: !1071)
!1071 = !{!249, !1072, !1073}
!1072 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !249)
!1073 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !960)
!1074 = !DISubprogram(name: "strtol", scope: !762, file: !762, line: 177, type: !1075, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1075 = !DISubroutineType(types: !1076)
!1076 = !{!271, !1073, !1077, !225}
!1077 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1078)
!1078 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !249, size: 64)
!1079 = !DISubprogram(name: "fprintf", scope: !1080, file: !1080, line: 357, type: !1081, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1080 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/stdio.h", directory: "")
!1081 = !DISubroutineType(types: !1082)
!1082 = !{!225, !1083, !1073, null}
!1083 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !1084)
!1084 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1085, size: 64)
!1085 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !1086, line: 7, baseType: !1087)
!1086 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/FILE.h", directory: "")
!1087 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !1088, line: 49, size: 1728, elements: !1089)
!1088 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/bits/types/struct_FILE.h", directory: "")
!1089 = !{!1090, !1091, !1092, !1093, !1094, !1095, !1096, !1097, !1098, !1099, !1100, !1101, !1102, !1105, !1107, !1108, !1109, !1110, !1111, !1112, !1116, !1119, !1121, !1124, !1127, !1128, !1129, !1131, !1132}
!1090 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !1087, file: !1088, line: 51, baseType: !225, size: 32)
!1091 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !1087, file: !1088, line: 54, baseType: !249, size: 64, offset: 64)
!1092 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !1087, file: !1088, line: 55, baseType: !249, size: 64, offset: 128)
!1093 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !1087, file: !1088, line: 56, baseType: !249, size: 64, offset: 192)
!1094 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !1087, file: !1088, line: 57, baseType: !249, size: 64, offset: 256)
!1095 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !1087, file: !1088, line: 58, baseType: !249, size: 64, offset: 320)
!1096 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !1087, file: !1088, line: 59, baseType: !249, size: 64, offset: 384)
!1097 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !1087, file: !1088, line: 60, baseType: !249, size: 64, offset: 448)
!1098 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !1087, file: !1088, line: 61, baseType: !249, size: 64, offset: 512)
!1099 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !1087, file: !1088, line: 64, baseType: !249, size: 64, offset: 576)
!1100 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !1087, file: !1088, line: 65, baseType: !249, size: 64, offset: 640)
!1101 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !1087, file: !1088, line: 66, baseType: !249, size: 64, offset: 704)
!1102 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !1087, file: !1088, line: 68, baseType: !1103, size: 64, offset: 768)
!1103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1104, size: 64)
!1104 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !1088, line: 36, flags: DIFlagFwdDecl)
!1105 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !1087, file: !1088, line: 70, baseType: !1106, size: 64, offset: 832)
!1106 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1087, size: 64)
!1107 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !1087, file: !1088, line: 72, baseType: !225, size: 32, offset: 896)
!1108 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !1087, file: !1088, line: 73, baseType: !225, size: 32, offset: 928)
!1109 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !1087, file: !1088, line: 74, baseType: !899, size: 64, offset: 960)
!1110 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !1087, file: !1088, line: 77, baseType: !253, size: 16, offset: 1024)
!1111 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !1087, file: !1088, line: 78, baseType: !263, size: 8, offset: 1040)
!1112 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !1087, file: !1088, line: 79, baseType: !1113, size: 8, offset: 1048)
!1113 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 8, elements: !1114)
!1114 = !{!1115}
!1115 = !DISubrange(count: 1)
!1116 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !1087, file: !1088, line: 81, baseType: !1117, size: 64, offset: 1088)
!1117 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1118, size: 64)
!1118 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !1088, line: 43, baseType: null)
!1119 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !1087, file: !1088, line: 89, baseType: !1120, size: 64, offset: 1152)
!1120 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !10, line: 153, baseType: !271)
!1121 = !DIDerivedType(tag: DW_TAG_member, name: "_codecvt", scope: !1087, file: !1088, line: 91, baseType: !1122, size: 64, offset: 1216)
!1122 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1123, size: 64)
!1123 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_codecvt", file: !1088, line: 37, flags: DIFlagFwdDecl)
!1124 = !DIDerivedType(tag: DW_TAG_member, name: "_wide_data", scope: !1087, file: !1088, line: 92, baseType: !1125, size: 64, offset: 1280)
!1125 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1126, size: 64)
!1126 = !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_wide_data", file: !1088, line: 38, flags: DIFlagFwdDecl)
!1127 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_list", scope: !1087, file: !1088, line: 93, baseType: !1106, size: 64, offset: 1344)
!1128 = !DIDerivedType(tag: DW_TAG_member, name: "_freeres_buf", scope: !1087, file: !1088, line: 94, baseType: !250, size: 64, offset: 1408)
!1129 = !DIDerivedType(tag: DW_TAG_member, name: "_prevchain", scope: !1087, file: !1088, line: 95, baseType: !1130, size: 64, offset: 1472)
!1130 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1106, size: 64)
!1131 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !1087, file: !1088, line: 96, baseType: !225, size: 32, offset: 1536)
!1132 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !1087, file: !1088, line: 98, baseType: !1133, size: 160, offset: 1568)
!1133 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 160, elements: !30)
!1134 = !DISubprogram(name: "strlen", scope: !1069, file: !1069, line: 407, type: !1135, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1135 = !DISubroutineType(types: !1136)
!1136 = !{!259, !960}
!1137 = distinct !DISubprogram(name: "parse_uint16_t_array", scope: !16, file: !16, line: 133, type: !1138, scopeLine: 133, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1141)
!1138 = !DISubroutineType(types: !1139)
!1139 = !{!225, !249, !1140, !225}
!1140 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !251, size: 64)
!1141 = !{!1142, !1143, !1144, !1145, !1146, !1147, !1148}
!1142 = !DILocalVariable(name: "s", arg: 1, scope: !1137, file: !16, line: 133, type: !249)
!1143 = !DILocalVariable(name: "arr", arg: 2, scope: !1137, file: !16, line: 133, type: !1140)
!1144 = !DILocalVariable(name: "n", arg: 3, scope: !1137, file: !16, line: 133, type: !225)
!1145 = !DILocalVariable(name: "line", scope: !1137, file: !16, line: 133, type: !249)
!1146 = !DILocalVariable(name: "endptr", scope: !1137, file: !16, line: 133, type: !249)
!1147 = !DILocalVariable(name: "i", scope: !1137, file: !16, line: 133, type: !225)
!1148 = !DILocalVariable(name: "v", scope: !1137, file: !16, line: 133, type: !251)
!1149 = distinct !DIAssignID()
!1150 = !DILocation(line: 0, scope: !1137)
!1151 = !DILocation(line: 133, column: 1, scope: !1137)
!1152 = !DILocation(line: 133, column: 1, scope: !1153)
!1153 = distinct !DILexicalBlock(scope: !1154, file: !16, line: 133, column: 1)
!1154 = distinct !DILexicalBlock(scope: !1137, file: !16, line: 133, column: 1)
!1155 = !DILocation(line: 133, column: 1, scope: !1156)
!1156 = distinct !DILexicalBlock(scope: !1137, file: !16, line: 133, column: 1)
!1157 = distinct !DIAssignID()
!1158 = !DILocation(line: 133, column: 1, scope: !1159)
!1159 = distinct !DILexicalBlock(scope: !1156, file: !16, line: 133, column: 1)
!1160 = !DILocation(line: 133, column: 1, scope: !1161)
!1161 = distinct !DILexicalBlock(scope: !1159, file: !16, line: 133, column: 1)
!1162 = !{!1163, !1163, i64 0}
!1163 = !{!"short", !374, i64 0}
!1164 = distinct !{!1164, !1151, !1151, !393, !394}
!1165 = !DILocation(line: 133, column: 1, scope: !1166)
!1166 = distinct !DILexicalBlock(scope: !1167, file: !16, line: 133, column: 1)
!1167 = distinct !DILexicalBlock(scope: !1137, file: !16, line: 133, column: 1)
!1168 = distinct !DISubprogram(name: "parse_uint32_t_array", scope: !16, file: !16, line: 134, type: !1169, scopeLine: 134, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1172)
!1169 = !DISubroutineType(types: !1170)
!1170 = !{!225, !249, !1171, !225}
!1171 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 64)
!1172 = !{!1173, !1174, !1175, !1176, !1177, !1178, !1179}
!1173 = !DILocalVariable(name: "s", arg: 1, scope: !1168, file: !16, line: 134, type: !249)
!1174 = !DILocalVariable(name: "arr", arg: 2, scope: !1168, file: !16, line: 134, type: !1171)
!1175 = !DILocalVariable(name: "n", arg: 3, scope: !1168, file: !16, line: 134, type: !225)
!1176 = !DILocalVariable(name: "line", scope: !1168, file: !16, line: 134, type: !249)
!1177 = !DILocalVariable(name: "endptr", scope: !1168, file: !16, line: 134, type: !249)
!1178 = !DILocalVariable(name: "i", scope: !1168, file: !16, line: 134, type: !225)
!1179 = !DILocalVariable(name: "v", scope: !1168, file: !16, line: 134, type: !254)
!1180 = distinct !DIAssignID()
!1181 = !DILocation(line: 0, scope: !1168)
!1182 = !DILocation(line: 134, column: 1, scope: !1168)
!1183 = !DILocation(line: 134, column: 1, scope: !1184)
!1184 = distinct !DILexicalBlock(scope: !1185, file: !16, line: 134, column: 1)
!1185 = distinct !DILexicalBlock(scope: !1168, file: !16, line: 134, column: 1)
!1186 = !DILocation(line: 134, column: 1, scope: !1187)
!1187 = distinct !DILexicalBlock(scope: !1168, file: !16, line: 134, column: 1)
!1188 = distinct !DIAssignID()
!1189 = !DILocation(line: 134, column: 1, scope: !1190)
!1190 = distinct !DILexicalBlock(scope: !1187, file: !16, line: 134, column: 1)
!1191 = !DILocation(line: 134, column: 1, scope: !1192)
!1192 = distinct !DILexicalBlock(scope: !1190, file: !16, line: 134, column: 1)
!1193 = !{!1194, !1194, i64 0}
!1194 = !{!"int", !374, i64 0}
!1195 = distinct !{!1195, !1182, !1182, !393, !394}
!1196 = !DILocation(line: 134, column: 1, scope: !1197)
!1197 = distinct !DILexicalBlock(scope: !1198, file: !16, line: 134, column: 1)
!1198 = distinct !DILexicalBlock(scope: !1168, file: !16, line: 134, column: 1)
!1199 = distinct !DISubprogram(name: "parse_uint64_t_array", scope: !16, file: !16, line: 135, type: !1200, scopeLine: 135, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1203)
!1200 = !DISubroutineType(types: !1201)
!1201 = !{!225, !249, !1202, !225}
!1202 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !257, size: 64)
!1203 = !{!1204, !1205, !1206, !1207, !1208, !1209, !1210}
!1204 = !DILocalVariable(name: "s", arg: 1, scope: !1199, file: !16, line: 135, type: !249)
!1205 = !DILocalVariable(name: "arr", arg: 2, scope: !1199, file: !16, line: 135, type: !1202)
!1206 = !DILocalVariable(name: "n", arg: 3, scope: !1199, file: !16, line: 135, type: !225)
!1207 = !DILocalVariable(name: "line", scope: !1199, file: !16, line: 135, type: !249)
!1208 = !DILocalVariable(name: "endptr", scope: !1199, file: !16, line: 135, type: !249)
!1209 = !DILocalVariable(name: "i", scope: !1199, file: !16, line: 135, type: !225)
!1210 = !DILocalVariable(name: "v", scope: !1199, file: !16, line: 135, type: !257)
!1211 = distinct !DIAssignID()
!1212 = !DILocation(line: 0, scope: !1199)
!1213 = !DILocation(line: 135, column: 1, scope: !1199)
!1214 = !DILocation(line: 135, column: 1, scope: !1215)
!1215 = distinct !DILexicalBlock(scope: !1216, file: !16, line: 135, column: 1)
!1216 = distinct !DILexicalBlock(scope: !1199, file: !16, line: 135, column: 1)
!1217 = !DILocation(line: 135, column: 1, scope: !1218)
!1218 = distinct !DILexicalBlock(scope: !1199, file: !16, line: 135, column: 1)
!1219 = distinct !DIAssignID()
!1220 = !DILocation(line: 135, column: 1, scope: !1221)
!1221 = distinct !DILexicalBlock(scope: !1218, file: !16, line: 135, column: 1)
!1222 = !DILocation(line: 135, column: 1, scope: !1223)
!1223 = distinct !DILexicalBlock(scope: !1221, file: !16, line: 135, column: 1)
!1224 = !{!1225, !1225, i64 0}
!1225 = !{!"long", !374, i64 0}
!1226 = distinct !{!1226, !1213, !1213, !393, !394}
!1227 = !DILocation(line: 135, column: 1, scope: !1228)
!1228 = distinct !DILexicalBlock(scope: !1229, file: !16, line: 135, column: 1)
!1229 = distinct !DILexicalBlock(scope: !1199, file: !16, line: 135, column: 1)
!1230 = distinct !DISubprogram(name: "parse_int8_t_array", scope: !16, file: !16, line: 136, type: !1231, scopeLine: 136, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1234)
!1231 = !DISubroutineType(types: !1232)
!1232 = !{!225, !249, !1233, !225}
!1233 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !260, size: 64)
!1234 = !{!1235, !1236, !1237, !1238, !1239, !1240, !1241}
!1235 = !DILocalVariable(name: "s", arg: 1, scope: !1230, file: !16, line: 136, type: !249)
!1236 = !DILocalVariable(name: "arr", arg: 2, scope: !1230, file: !16, line: 136, type: !1233)
!1237 = !DILocalVariable(name: "n", arg: 3, scope: !1230, file: !16, line: 136, type: !225)
!1238 = !DILocalVariable(name: "line", scope: !1230, file: !16, line: 136, type: !249)
!1239 = !DILocalVariable(name: "endptr", scope: !1230, file: !16, line: 136, type: !249)
!1240 = !DILocalVariable(name: "i", scope: !1230, file: !16, line: 136, type: !225)
!1241 = !DILocalVariable(name: "v", scope: !1230, file: !16, line: 136, type: !260)
!1242 = distinct !DIAssignID()
!1243 = !DILocation(line: 0, scope: !1230)
!1244 = !DILocation(line: 136, column: 1, scope: !1230)
!1245 = !DILocation(line: 136, column: 1, scope: !1246)
!1246 = distinct !DILexicalBlock(scope: !1247, file: !16, line: 136, column: 1)
!1247 = distinct !DILexicalBlock(scope: !1230, file: !16, line: 136, column: 1)
!1248 = !DILocation(line: 136, column: 1, scope: !1249)
!1249 = distinct !DILexicalBlock(scope: !1230, file: !16, line: 136, column: 1)
!1250 = distinct !DIAssignID()
!1251 = !DILocation(line: 136, column: 1, scope: !1252)
!1252 = distinct !DILexicalBlock(scope: !1249, file: !16, line: 136, column: 1)
!1253 = !DILocation(line: 136, column: 1, scope: !1254)
!1254 = distinct !DILexicalBlock(scope: !1252, file: !16, line: 136, column: 1)
!1255 = distinct !{!1255, !1244, !1244, !393, !394}
!1256 = !DILocation(line: 136, column: 1, scope: !1257)
!1257 = distinct !DILexicalBlock(scope: !1258, file: !16, line: 136, column: 1)
!1258 = distinct !DILexicalBlock(scope: !1230, file: !16, line: 136, column: 1)
!1259 = distinct !DISubprogram(name: "parse_int16_t_array", scope: !16, file: !16, line: 137, type: !1260, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1263)
!1260 = !DISubroutineType(types: !1261)
!1261 = !{!225, !249, !1262, !225}
!1262 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !264, size: 64)
!1263 = !{!1264, !1265, !1266, !1267, !1268, !1269, !1270}
!1264 = !DILocalVariable(name: "s", arg: 1, scope: !1259, file: !16, line: 137, type: !249)
!1265 = !DILocalVariable(name: "arr", arg: 2, scope: !1259, file: !16, line: 137, type: !1262)
!1266 = !DILocalVariable(name: "n", arg: 3, scope: !1259, file: !16, line: 137, type: !225)
!1267 = !DILocalVariable(name: "line", scope: !1259, file: !16, line: 137, type: !249)
!1268 = !DILocalVariable(name: "endptr", scope: !1259, file: !16, line: 137, type: !249)
!1269 = !DILocalVariable(name: "i", scope: !1259, file: !16, line: 137, type: !225)
!1270 = !DILocalVariable(name: "v", scope: !1259, file: !16, line: 137, type: !264)
!1271 = distinct !DIAssignID()
!1272 = !DILocation(line: 0, scope: !1259)
!1273 = !DILocation(line: 137, column: 1, scope: !1259)
!1274 = !DILocation(line: 137, column: 1, scope: !1275)
!1275 = distinct !DILexicalBlock(scope: !1276, file: !16, line: 137, column: 1)
!1276 = distinct !DILexicalBlock(scope: !1259, file: !16, line: 137, column: 1)
!1277 = !DILocation(line: 137, column: 1, scope: !1278)
!1278 = distinct !DILexicalBlock(scope: !1259, file: !16, line: 137, column: 1)
!1279 = distinct !DIAssignID()
!1280 = !DILocation(line: 137, column: 1, scope: !1281)
!1281 = distinct !DILexicalBlock(scope: !1278, file: !16, line: 137, column: 1)
!1282 = !DILocation(line: 137, column: 1, scope: !1283)
!1283 = distinct !DILexicalBlock(scope: !1281, file: !16, line: 137, column: 1)
!1284 = distinct !{!1284, !1273, !1273, !393, !394}
!1285 = !DILocation(line: 137, column: 1, scope: !1286)
!1286 = distinct !DILexicalBlock(scope: !1287, file: !16, line: 137, column: 1)
!1287 = distinct !DILexicalBlock(scope: !1259, file: !16, line: 137, column: 1)
!1288 = distinct !DISubprogram(name: "parse_int32_t_array", scope: !16, file: !16, line: 138, type: !1289, scopeLine: 138, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1292)
!1289 = !DISubroutineType(types: !1290)
!1290 = !{!225, !249, !1291, !225}
!1291 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !267, size: 64)
!1292 = !{!1293, !1294, !1295, !1296, !1297, !1298, !1299}
!1293 = !DILocalVariable(name: "s", arg: 1, scope: !1288, file: !16, line: 138, type: !249)
!1294 = !DILocalVariable(name: "arr", arg: 2, scope: !1288, file: !16, line: 138, type: !1291)
!1295 = !DILocalVariable(name: "n", arg: 3, scope: !1288, file: !16, line: 138, type: !225)
!1296 = !DILocalVariable(name: "line", scope: !1288, file: !16, line: 138, type: !249)
!1297 = !DILocalVariable(name: "endptr", scope: !1288, file: !16, line: 138, type: !249)
!1298 = !DILocalVariable(name: "i", scope: !1288, file: !16, line: 138, type: !225)
!1299 = !DILocalVariable(name: "v", scope: !1288, file: !16, line: 138, type: !267)
!1300 = distinct !DIAssignID()
!1301 = !DILocation(line: 0, scope: !1288)
!1302 = !DILocation(line: 138, column: 1, scope: !1288)
!1303 = !DILocation(line: 138, column: 1, scope: !1304)
!1304 = distinct !DILexicalBlock(scope: !1305, file: !16, line: 138, column: 1)
!1305 = distinct !DILexicalBlock(scope: !1288, file: !16, line: 138, column: 1)
!1306 = !DILocation(line: 138, column: 1, scope: !1307)
!1307 = distinct !DILexicalBlock(scope: !1288, file: !16, line: 138, column: 1)
!1308 = distinct !DIAssignID()
!1309 = !DILocation(line: 138, column: 1, scope: !1310)
!1310 = distinct !DILexicalBlock(scope: !1307, file: !16, line: 138, column: 1)
!1311 = !DILocation(line: 138, column: 1, scope: !1312)
!1312 = distinct !DILexicalBlock(scope: !1310, file: !16, line: 138, column: 1)
!1313 = distinct !{!1313, !1302, !1302, !393, !394}
!1314 = !DILocation(line: 138, column: 1, scope: !1315)
!1315 = distinct !DILexicalBlock(scope: !1316, file: !16, line: 138, column: 1)
!1316 = distinct !DILexicalBlock(scope: !1288, file: !16, line: 138, column: 1)
!1317 = distinct !DISubprogram(name: "parse_int64_t_array", scope: !16, file: !16, line: 139, type: !1318, scopeLine: 139, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1321)
!1318 = !DISubroutineType(types: !1319)
!1319 = !{!225, !249, !1320, !225}
!1320 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !269, size: 64)
!1321 = !{!1322, !1323, !1324, !1325, !1326, !1327, !1328}
!1322 = !DILocalVariable(name: "s", arg: 1, scope: !1317, file: !16, line: 139, type: !249)
!1323 = !DILocalVariable(name: "arr", arg: 2, scope: !1317, file: !16, line: 139, type: !1320)
!1324 = !DILocalVariable(name: "n", arg: 3, scope: !1317, file: !16, line: 139, type: !225)
!1325 = !DILocalVariable(name: "line", scope: !1317, file: !16, line: 139, type: !249)
!1326 = !DILocalVariable(name: "endptr", scope: !1317, file: !16, line: 139, type: !249)
!1327 = !DILocalVariable(name: "i", scope: !1317, file: !16, line: 139, type: !225)
!1328 = !DILocalVariable(name: "v", scope: !1317, file: !16, line: 139, type: !269)
!1329 = distinct !DIAssignID()
!1330 = !DILocation(line: 0, scope: !1317)
!1331 = !DILocation(line: 139, column: 1, scope: !1317)
!1332 = !DILocation(line: 139, column: 1, scope: !1333)
!1333 = distinct !DILexicalBlock(scope: !1334, file: !16, line: 139, column: 1)
!1334 = distinct !DILexicalBlock(scope: !1317, file: !16, line: 139, column: 1)
!1335 = !DILocation(line: 139, column: 1, scope: !1336)
!1336 = distinct !DILexicalBlock(scope: !1317, file: !16, line: 139, column: 1)
!1337 = distinct !DIAssignID()
!1338 = !DILocation(line: 139, column: 1, scope: !1339)
!1339 = distinct !DILexicalBlock(scope: !1336, file: !16, line: 139, column: 1)
!1340 = !DILocation(line: 139, column: 1, scope: !1341)
!1341 = distinct !DILexicalBlock(scope: !1339, file: !16, line: 139, column: 1)
!1342 = distinct !{!1342, !1331, !1331, !393, !394}
!1343 = !DILocation(line: 139, column: 1, scope: !1344)
!1344 = distinct !DILexicalBlock(scope: !1345, file: !16, line: 139, column: 1)
!1345 = distinct !DILexicalBlock(scope: !1317, file: !16, line: 139, column: 1)
!1346 = distinct !DISubprogram(name: "parse_float_array", scope: !16, file: !16, line: 141, type: !1347, scopeLine: 141, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1350)
!1347 = !DISubroutineType(types: !1348)
!1348 = !{!225, !249, !1349, !225}
!1349 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !272, size: 64)
!1350 = !{!1351, !1352, !1353, !1354, !1355, !1356, !1357}
!1351 = !DILocalVariable(name: "s", arg: 1, scope: !1346, file: !16, line: 141, type: !249)
!1352 = !DILocalVariable(name: "arr", arg: 2, scope: !1346, file: !16, line: 141, type: !1349)
!1353 = !DILocalVariable(name: "n", arg: 3, scope: !1346, file: !16, line: 141, type: !225)
!1354 = !DILocalVariable(name: "line", scope: !1346, file: !16, line: 141, type: !249)
!1355 = !DILocalVariable(name: "endptr", scope: !1346, file: !16, line: 141, type: !249)
!1356 = !DILocalVariable(name: "i", scope: !1346, file: !16, line: 141, type: !225)
!1357 = !DILocalVariable(name: "v", scope: !1346, file: !16, line: 141, type: !272)
!1358 = distinct !DIAssignID()
!1359 = !DILocation(line: 0, scope: !1346)
!1360 = !DILocation(line: 141, column: 1, scope: !1346)
!1361 = !DILocation(line: 141, column: 1, scope: !1362)
!1362 = distinct !DILexicalBlock(scope: !1363, file: !16, line: 141, column: 1)
!1363 = distinct !DILexicalBlock(scope: !1346, file: !16, line: 141, column: 1)
!1364 = !DILocation(line: 141, column: 1, scope: !1365)
!1365 = distinct !DILexicalBlock(scope: !1346, file: !16, line: 141, column: 1)
!1366 = distinct !DIAssignID()
!1367 = !DILocation(line: 141, column: 1, scope: !1368)
!1368 = distinct !DILexicalBlock(scope: !1365, file: !16, line: 141, column: 1)
!1369 = !DILocation(line: 141, column: 1, scope: !1370)
!1370 = distinct !DILexicalBlock(scope: !1368, file: !16, line: 141, column: 1)
!1371 = !{!1372, !1372, i64 0}
!1372 = !{!"float", !374, i64 0}
!1373 = distinct !{!1373, !1360, !1360, !393, !394}
!1374 = !DILocation(line: 141, column: 1, scope: !1375)
!1375 = distinct !DILexicalBlock(scope: !1376, file: !16, line: 141, column: 1)
!1376 = distinct !DILexicalBlock(scope: !1346, file: !16, line: 141, column: 1)
!1377 = !DISubprogram(name: "strtof", scope: !762, file: !762, line: 124, type: !1378, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1378 = !DISubroutineType(types: !1379)
!1379 = !{!272, !1073, !1077}
!1380 = distinct !DISubprogram(name: "parse_double_array", scope: !16, file: !16, line: 142, type: !1381, scopeLine: 142, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1384)
!1381 = !DISubroutineType(types: !1382)
!1382 = !{!225, !249, !1383, !225}
!1383 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !273, size: 64)
!1384 = !{!1385, !1386, !1387, !1388, !1389, !1390, !1391}
!1385 = !DILocalVariable(name: "s", arg: 1, scope: !1380, file: !16, line: 142, type: !249)
!1386 = !DILocalVariable(name: "arr", arg: 2, scope: !1380, file: !16, line: 142, type: !1383)
!1387 = !DILocalVariable(name: "n", arg: 3, scope: !1380, file: !16, line: 142, type: !225)
!1388 = !DILocalVariable(name: "line", scope: !1380, file: !16, line: 142, type: !249)
!1389 = !DILocalVariable(name: "endptr", scope: !1380, file: !16, line: 142, type: !249)
!1390 = !DILocalVariable(name: "i", scope: !1380, file: !16, line: 142, type: !225)
!1391 = !DILocalVariable(name: "v", scope: !1380, file: !16, line: 142, type: !273)
!1392 = distinct !DIAssignID()
!1393 = !DILocation(line: 0, scope: !1380)
!1394 = !DILocation(line: 142, column: 1, scope: !1380)
!1395 = !DILocation(line: 142, column: 1, scope: !1396)
!1396 = distinct !DILexicalBlock(scope: !1397, file: !16, line: 142, column: 1)
!1397 = distinct !DILexicalBlock(scope: !1380, file: !16, line: 142, column: 1)
!1398 = !DILocation(line: 142, column: 1, scope: !1399)
!1399 = distinct !DILexicalBlock(scope: !1380, file: !16, line: 142, column: 1)
!1400 = distinct !DIAssignID()
!1401 = !DILocation(line: 142, column: 1, scope: !1402)
!1402 = distinct !DILexicalBlock(scope: !1399, file: !16, line: 142, column: 1)
!1403 = !DILocation(line: 142, column: 1, scope: !1404)
!1404 = distinct !DILexicalBlock(scope: !1402, file: !16, line: 142, column: 1)
!1405 = !{!1406, !1406, i64 0}
!1406 = !{!"double", !374, i64 0}
!1407 = distinct !{!1407, !1394, !1394, !393, !394}
!1408 = !DILocation(line: 142, column: 1, scope: !1409)
!1409 = distinct !DILexicalBlock(scope: !1410, file: !16, line: 142, column: 1)
!1410 = distinct !DILexicalBlock(scope: !1380, file: !16, line: 142, column: 1)
!1411 = !DISubprogram(name: "strtod", scope: !762, file: !762, line: 118, type: !1412, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1412 = !DISubroutineType(types: !1413)
!1413 = !{!273, !1073, !1077}
!1414 = distinct !DISubprogram(name: "write_string", scope: !16, file: !16, line: 145, type: !1415, scopeLine: 145, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1417)
!1415 = !DISubroutineType(types: !1416)
!1416 = !{!225, !225, !249, !225}
!1417 = !{!1418, !1419, !1420, !1421, !1422}
!1418 = !DILocalVariable(name: "fd", arg: 1, scope: !1414, file: !16, line: 145, type: !225)
!1419 = !DILocalVariable(name: "arr", arg: 2, scope: !1414, file: !16, line: 145, type: !249)
!1420 = !DILocalVariable(name: "n", arg: 3, scope: !1414, file: !16, line: 145, type: !225)
!1421 = !DILocalVariable(name: "status", scope: !1414, file: !16, line: 146, type: !225)
!1422 = !DILocalVariable(name: "written", scope: !1414, file: !16, line: 146, type: !225)
!1423 = !DILocation(line: 0, scope: !1414)
!1424 = !DILocation(line: 147, column: 3, scope: !1425)
!1425 = distinct !DILexicalBlock(scope: !1426, file: !16, line: 147, column: 3)
!1426 = distinct !DILexicalBlock(scope: !1414, file: !16, line: 147, column: 3)
!1427 = !DILocation(line: 148, column: 8, scope: !1428)
!1428 = distinct !DILexicalBlock(scope: !1414, file: !16, line: 148, column: 7)
!1429 = !DILocation(line: 148, column: 7, scope: !1414)
!1430 = !DILocation(line: 149, column: 9, scope: !1431)
!1431 = distinct !DILexicalBlock(scope: !1428, file: !16, line: 148, column: 13)
!1432 = !DILocation(line: 150, column: 3, scope: !1431)
!1433 = !DILocation(line: 152, column: 16, scope: !1414)
!1434 = !DILocation(line: 152, column: 3, scope: !1414)
!1435 = !DILocation(line: 158, column: 3, scope: !1414)
!1436 = !DILocation(line: 155, column: 13, scope: !1437)
!1437 = distinct !DILexicalBlock(scope: !1414, file: !16, line: 152, column: 20)
!1438 = distinct !{!1438, !1434, !1439, !393, !394}
!1439 = !DILocation(line: 156, column: 3, scope: !1414)
!1440 = !DILocation(line: 153, column: 25, scope: !1437)
!1441 = !DILocation(line: 153, column: 40, scope: !1437)
!1442 = !DILocation(line: 153, column: 39, scope: !1437)
!1443 = !DILocation(line: 153, column: 14, scope: !1437)
!1444 = !DILocation(line: 154, column: 5, scope: !1445)
!1445 = distinct !DILexicalBlock(scope: !1446, file: !16, line: 154, column: 5)
!1446 = distinct !DILexicalBlock(scope: !1437, file: !16, line: 154, column: 5)
!1447 = !DILocation(line: 159, column: 14, scope: !1448)
!1448 = distinct !DILexicalBlock(scope: !1414, file: !16, line: 158, column: 6)
!1449 = !DILocation(line: 160, column: 5, scope: !1450)
!1450 = distinct !DILexicalBlock(scope: !1451, file: !16, line: 160, column: 5)
!1451 = distinct !DILexicalBlock(scope: !1448, file: !16, line: 160, column: 5)
!1452 = !DILocation(line: 161, column: 17, scope: !1414)
!1453 = !DILocation(line: 161, column: 3, scope: !1448)
!1454 = distinct !{!1454, !1435, !1455, !393, !394}
!1455 = !DILocation(line: 161, column: 20, scope: !1414)
!1456 = !DILocation(line: 163, column: 3, scope: !1414)
!1457 = !DISubprogram(name: "write", scope: !972, file: !972, line: 378, type: !1458, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1458 = !DISubroutineType(types: !1459)
!1459 = !{!921, !225, !1460, !969}
!1460 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1461, size: 64)
!1461 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!1462 = !DILocation(line: 0, scope: !782)
!1463 = !DILocation(line: 177, column: 1, scope: !1464)
!1464 = distinct !DILexicalBlock(scope: !1465, file: !16, line: 177, column: 1)
!1465 = distinct !DILexicalBlock(scope: !782, file: !16, line: 177, column: 1)
!1466 = !DILocation(line: 177, column: 1, scope: !795)
!1467 = !DILocation(line: 177, column: 1, scope: !792)
!1468 = !DILocation(line: 177, column: 1, scope: !794)
!1469 = distinct !{!1469, !1467, !1467, !393, !394}
!1470 = !DILocation(line: 177, column: 1, scope: !782)
!1471 = distinct !DISubprogram(name: "fd_printf", scope: !16, file: !16, line: 15, type: !1472, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1474)
!1472 = !DISubroutineType(cc: DW_CC_nocall, types: !1473)
!1473 = !{!225, !225, !960, null}
!1474 = !{!1475, !1476, !1477, !1481, !1482, !1483, !1484}
!1475 = !DILocalVariable(name: "fd", arg: 1, scope: !1471, file: !16, line: 15, type: !225)
!1476 = !DILocalVariable(name: "format", arg: 2, scope: !1471, file: !16, line: 15, type: !960)
!1477 = !DILocalVariable(name: "args", scope: !1471, file: !16, line: 16, type: !1478)
!1478 = !DIDerivedType(tag: DW_TAG_typedef, name: "va_list", file: !1479, line: 12, baseType: !1480)
!1479 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg_va_list.h", directory: "")
!1480 = !DIDerivedType(tag: DW_TAG_typedef, name: "__builtin_va_list", file: !16, baseType: !250)
!1481 = !DILocalVariable(name: "buffered", scope: !1471, file: !16, line: 17, type: !225)
!1482 = !DILocalVariable(name: "written", scope: !1471, file: !16, line: 17, type: !225)
!1483 = !DILocalVariable(name: "status", scope: !1471, file: !16, line: 17, type: !225)
!1484 = !DILocalVariable(name: "buffer", scope: !1471, file: !16, line: 18, type: !1485)
!1485 = !DICompositeType(tag: DW_TAG_array_type, baseType: !18, size: 2048, elements: !12)
!1486 = distinct !DIAssignID()
!1487 = !DILocation(line: 0, scope: !1471)
!1488 = distinct !DIAssignID()
!1489 = !DILocation(line: 16, column: 3, scope: !1471)
!1490 = !DILocation(line: 18, column: 3, scope: !1471)
!1491 = !DILocation(line: 19, column: 3, scope: !1471)
!1492 = !DILocation(line: 20, column: 66, scope: !1471)
!1493 = !DILocation(line: 20, column: 14, scope: !1471)
!1494 = !DILocation(line: 21, column: 3, scope: !1471)
!1495 = !DILocation(line: 22, column: 3, scope: !1496)
!1496 = distinct !DILexicalBlock(scope: !1497, file: !16, line: 22, column: 3)
!1497 = distinct !DILexicalBlock(scope: !1471, file: !16, line: 22, column: 3)
!1498 = !DILocation(line: 24, column: 16, scope: !1471)
!1499 = !DILocation(line: 24, column: 3, scope: !1471)
!1500 = !DILocation(line: 27, column: 13, scope: !1501)
!1501 = distinct !DILexicalBlock(scope: !1471, file: !16, line: 24, column: 27)
!1502 = distinct !{!1502, !1499, !1503, !393, !394}
!1503 = !DILocation(line: 28, column: 3, scope: !1471)
!1504 = !DILocation(line: 25, column: 25, scope: !1501)
!1505 = !DILocation(line: 25, column: 50, scope: !1501)
!1506 = !DILocation(line: 25, column: 42, scope: !1501)
!1507 = !DILocation(line: 25, column: 14, scope: !1501)
!1508 = !DILocation(line: 26, column: 5, scope: !1509)
!1509 = distinct !DILexicalBlock(scope: !1510, file: !16, line: 26, column: 5)
!1510 = distinct !DILexicalBlock(scope: !1501, file: !16, line: 26, column: 5)
!1511 = !DILocation(line: 29, column: 3, scope: !1512)
!1512 = distinct !DILexicalBlock(scope: !1513, file: !16, line: 29, column: 3)
!1513 = distinct !DILexicalBlock(scope: !1471, file: !16, line: 29, column: 3)
!1514 = !DILocation(line: 31, column: 1, scope: !1471)
!1515 = !DILocation(line: 30, column: 3, scope: !1471)
!1516 = !DISubprogram(name: "vsnprintf", scope: !1080, file: !1080, line: 389, type: !1517, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1517 = !DISubroutineType(types: !1518)
!1518 = !{!225, !1072, !969, !1073, !1519}
!1519 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gnuc_va_list", file: !1520, line: 12, baseType: !1480)
!1520 = !DIFile(filename: "/opt/riscv/lib/clang/18/include/__stdarg___gnuc_va_list.h", directory: "")
!1521 = distinct !DISubprogram(name: "write_uint16_t_array", scope: !16, file: !16, line: 178, type: !1522, scopeLine: 178, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1524)
!1522 = !DISubroutineType(types: !1523)
!1523 = !{!225, !225, !1140, !225}
!1524 = !{!1525, !1526, !1527, !1528}
!1525 = !DILocalVariable(name: "fd", arg: 1, scope: !1521, file: !16, line: 178, type: !225)
!1526 = !DILocalVariable(name: "arr", arg: 2, scope: !1521, file: !16, line: 178, type: !1140)
!1527 = !DILocalVariable(name: "n", arg: 3, scope: !1521, file: !16, line: 178, type: !225)
!1528 = !DILocalVariable(name: "i", scope: !1521, file: !16, line: 178, type: !225)
!1529 = !DILocation(line: 0, scope: !1521)
!1530 = !DILocation(line: 178, column: 1, scope: !1531)
!1531 = distinct !DILexicalBlock(scope: !1532, file: !16, line: 178, column: 1)
!1532 = distinct !DILexicalBlock(scope: !1521, file: !16, line: 178, column: 1)
!1533 = !DILocation(line: 178, column: 1, scope: !1534)
!1534 = distinct !DILexicalBlock(scope: !1535, file: !16, line: 178, column: 1)
!1535 = distinct !DILexicalBlock(scope: !1521, file: !16, line: 178, column: 1)
!1536 = !DILocation(line: 178, column: 1, scope: !1535)
!1537 = !DILocation(line: 178, column: 1, scope: !1538)
!1538 = distinct !DILexicalBlock(scope: !1534, file: !16, line: 178, column: 1)
!1539 = distinct !{!1539, !1536, !1536, !393, !394}
!1540 = !DILocation(line: 178, column: 1, scope: !1521)
!1541 = distinct !DISubprogram(name: "write_uint32_t_array", scope: !16, file: !16, line: 179, type: !1542, scopeLine: 179, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1544)
!1542 = !DISubroutineType(types: !1543)
!1543 = !{!225, !225, !1171, !225}
!1544 = !{!1545, !1546, !1547, !1548}
!1545 = !DILocalVariable(name: "fd", arg: 1, scope: !1541, file: !16, line: 179, type: !225)
!1546 = !DILocalVariable(name: "arr", arg: 2, scope: !1541, file: !16, line: 179, type: !1171)
!1547 = !DILocalVariable(name: "n", arg: 3, scope: !1541, file: !16, line: 179, type: !225)
!1548 = !DILocalVariable(name: "i", scope: !1541, file: !16, line: 179, type: !225)
!1549 = !DILocation(line: 0, scope: !1541)
!1550 = !DILocation(line: 179, column: 1, scope: !1551)
!1551 = distinct !DILexicalBlock(scope: !1552, file: !16, line: 179, column: 1)
!1552 = distinct !DILexicalBlock(scope: !1541, file: !16, line: 179, column: 1)
!1553 = !DILocation(line: 179, column: 1, scope: !1554)
!1554 = distinct !DILexicalBlock(scope: !1555, file: !16, line: 179, column: 1)
!1555 = distinct !DILexicalBlock(scope: !1541, file: !16, line: 179, column: 1)
!1556 = !DILocation(line: 179, column: 1, scope: !1555)
!1557 = !DILocation(line: 179, column: 1, scope: !1558)
!1558 = distinct !DILexicalBlock(scope: !1554, file: !16, line: 179, column: 1)
!1559 = distinct !{!1559, !1556, !1556, !393, !394}
!1560 = !DILocation(line: 179, column: 1, scope: !1541)
!1561 = distinct !DISubprogram(name: "write_uint64_t_array", scope: !16, file: !16, line: 180, type: !1562, scopeLine: 180, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1564)
!1562 = !DISubroutineType(types: !1563)
!1563 = !{!225, !225, !1202, !225}
!1564 = !{!1565, !1566, !1567, !1568}
!1565 = !DILocalVariable(name: "fd", arg: 1, scope: !1561, file: !16, line: 180, type: !225)
!1566 = !DILocalVariable(name: "arr", arg: 2, scope: !1561, file: !16, line: 180, type: !1202)
!1567 = !DILocalVariable(name: "n", arg: 3, scope: !1561, file: !16, line: 180, type: !225)
!1568 = !DILocalVariable(name: "i", scope: !1561, file: !16, line: 180, type: !225)
!1569 = !DILocation(line: 0, scope: !1561)
!1570 = !DILocation(line: 180, column: 1, scope: !1571)
!1571 = distinct !DILexicalBlock(scope: !1572, file: !16, line: 180, column: 1)
!1572 = distinct !DILexicalBlock(scope: !1561, file: !16, line: 180, column: 1)
!1573 = !DILocation(line: 180, column: 1, scope: !1574)
!1574 = distinct !DILexicalBlock(scope: !1575, file: !16, line: 180, column: 1)
!1575 = distinct !DILexicalBlock(scope: !1561, file: !16, line: 180, column: 1)
!1576 = !DILocation(line: 180, column: 1, scope: !1575)
!1577 = !DILocation(line: 180, column: 1, scope: !1578)
!1578 = distinct !DILexicalBlock(scope: !1574, file: !16, line: 180, column: 1)
!1579 = distinct !{!1579, !1576, !1576, !393, !394}
!1580 = !DILocation(line: 180, column: 1, scope: !1561)
!1581 = distinct !DISubprogram(name: "write_int8_t_array", scope: !16, file: !16, line: 181, type: !1582, scopeLine: 181, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1584)
!1582 = !DISubroutineType(types: !1583)
!1583 = !{!225, !225, !1233, !225}
!1584 = !{!1585, !1586, !1587, !1588}
!1585 = !DILocalVariable(name: "fd", arg: 1, scope: !1581, file: !16, line: 181, type: !225)
!1586 = !DILocalVariable(name: "arr", arg: 2, scope: !1581, file: !16, line: 181, type: !1233)
!1587 = !DILocalVariable(name: "n", arg: 3, scope: !1581, file: !16, line: 181, type: !225)
!1588 = !DILocalVariable(name: "i", scope: !1581, file: !16, line: 181, type: !225)
!1589 = !DILocation(line: 0, scope: !1581)
!1590 = !DILocation(line: 181, column: 1, scope: !1591)
!1591 = distinct !DILexicalBlock(scope: !1592, file: !16, line: 181, column: 1)
!1592 = distinct !DILexicalBlock(scope: !1581, file: !16, line: 181, column: 1)
!1593 = !DILocation(line: 181, column: 1, scope: !1594)
!1594 = distinct !DILexicalBlock(scope: !1595, file: !16, line: 181, column: 1)
!1595 = distinct !DILexicalBlock(scope: !1581, file: !16, line: 181, column: 1)
!1596 = !DILocation(line: 181, column: 1, scope: !1595)
!1597 = !DILocation(line: 181, column: 1, scope: !1598)
!1598 = distinct !DILexicalBlock(scope: !1594, file: !16, line: 181, column: 1)
!1599 = distinct !{!1599, !1596, !1596, !393, !394}
!1600 = !DILocation(line: 181, column: 1, scope: !1581)
!1601 = distinct !DISubprogram(name: "write_int16_t_array", scope: !16, file: !16, line: 182, type: !1602, scopeLine: 182, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1604)
!1602 = !DISubroutineType(types: !1603)
!1603 = !{!225, !225, !1262, !225}
!1604 = !{!1605, !1606, !1607, !1608}
!1605 = !DILocalVariable(name: "fd", arg: 1, scope: !1601, file: !16, line: 182, type: !225)
!1606 = !DILocalVariable(name: "arr", arg: 2, scope: !1601, file: !16, line: 182, type: !1262)
!1607 = !DILocalVariable(name: "n", arg: 3, scope: !1601, file: !16, line: 182, type: !225)
!1608 = !DILocalVariable(name: "i", scope: !1601, file: !16, line: 182, type: !225)
!1609 = !DILocation(line: 0, scope: !1601)
!1610 = !DILocation(line: 182, column: 1, scope: !1611)
!1611 = distinct !DILexicalBlock(scope: !1612, file: !16, line: 182, column: 1)
!1612 = distinct !DILexicalBlock(scope: !1601, file: !16, line: 182, column: 1)
!1613 = !DILocation(line: 182, column: 1, scope: !1614)
!1614 = distinct !DILexicalBlock(scope: !1615, file: !16, line: 182, column: 1)
!1615 = distinct !DILexicalBlock(scope: !1601, file: !16, line: 182, column: 1)
!1616 = !DILocation(line: 182, column: 1, scope: !1615)
!1617 = !DILocation(line: 182, column: 1, scope: !1618)
!1618 = distinct !DILexicalBlock(scope: !1614, file: !16, line: 182, column: 1)
!1619 = distinct !{!1619, !1616, !1616, !393, !394}
!1620 = !DILocation(line: 182, column: 1, scope: !1601)
!1621 = distinct !DISubprogram(name: "write_int32_t_array", scope: !16, file: !16, line: 183, type: !1622, scopeLine: 183, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1624)
!1622 = !DISubroutineType(types: !1623)
!1623 = !{!225, !225, !1291, !225}
!1624 = !{!1625, !1626, !1627, !1628}
!1625 = !DILocalVariable(name: "fd", arg: 1, scope: !1621, file: !16, line: 183, type: !225)
!1626 = !DILocalVariable(name: "arr", arg: 2, scope: !1621, file: !16, line: 183, type: !1291)
!1627 = !DILocalVariable(name: "n", arg: 3, scope: !1621, file: !16, line: 183, type: !225)
!1628 = !DILocalVariable(name: "i", scope: !1621, file: !16, line: 183, type: !225)
!1629 = !DILocation(line: 0, scope: !1621)
!1630 = !DILocation(line: 183, column: 1, scope: !1631)
!1631 = distinct !DILexicalBlock(scope: !1632, file: !16, line: 183, column: 1)
!1632 = distinct !DILexicalBlock(scope: !1621, file: !16, line: 183, column: 1)
!1633 = !DILocation(line: 183, column: 1, scope: !1634)
!1634 = distinct !DILexicalBlock(scope: !1635, file: !16, line: 183, column: 1)
!1635 = distinct !DILexicalBlock(scope: !1621, file: !16, line: 183, column: 1)
!1636 = !DILocation(line: 183, column: 1, scope: !1635)
!1637 = !DILocation(line: 183, column: 1, scope: !1638)
!1638 = distinct !DILexicalBlock(scope: !1634, file: !16, line: 183, column: 1)
!1639 = distinct !{!1639, !1636, !1636, !393, !394}
!1640 = !DILocation(line: 183, column: 1, scope: !1621)
!1641 = distinct !DISubprogram(name: "write_int64_t_array", scope: !16, file: !16, line: 184, type: !1642, scopeLine: 184, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1644)
!1642 = !DISubroutineType(types: !1643)
!1643 = !{!225, !225, !1320, !225}
!1644 = !{!1645, !1646, !1647, !1648}
!1645 = !DILocalVariable(name: "fd", arg: 1, scope: !1641, file: !16, line: 184, type: !225)
!1646 = !DILocalVariable(name: "arr", arg: 2, scope: !1641, file: !16, line: 184, type: !1320)
!1647 = !DILocalVariable(name: "n", arg: 3, scope: !1641, file: !16, line: 184, type: !225)
!1648 = !DILocalVariable(name: "i", scope: !1641, file: !16, line: 184, type: !225)
!1649 = !DILocation(line: 0, scope: !1641)
!1650 = !DILocation(line: 184, column: 1, scope: !1651)
!1651 = distinct !DILexicalBlock(scope: !1652, file: !16, line: 184, column: 1)
!1652 = distinct !DILexicalBlock(scope: !1641, file: !16, line: 184, column: 1)
!1653 = !DILocation(line: 184, column: 1, scope: !1654)
!1654 = distinct !DILexicalBlock(scope: !1655, file: !16, line: 184, column: 1)
!1655 = distinct !DILexicalBlock(scope: !1641, file: !16, line: 184, column: 1)
!1656 = !DILocation(line: 184, column: 1, scope: !1655)
!1657 = !DILocation(line: 184, column: 1, scope: !1658)
!1658 = distinct !DILexicalBlock(scope: !1654, file: !16, line: 184, column: 1)
!1659 = distinct !{!1659, !1656, !1656, !393, !394}
!1660 = !DILocation(line: 184, column: 1, scope: !1641)
!1661 = distinct !DISubprogram(name: "write_float_array", scope: !16, file: !16, line: 186, type: !1662, scopeLine: 186, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1664)
!1662 = !DISubroutineType(types: !1663)
!1663 = !{!225, !225, !1349, !225}
!1664 = !{!1665, !1666, !1667, !1668}
!1665 = !DILocalVariable(name: "fd", arg: 1, scope: !1661, file: !16, line: 186, type: !225)
!1666 = !DILocalVariable(name: "arr", arg: 2, scope: !1661, file: !16, line: 186, type: !1349)
!1667 = !DILocalVariable(name: "n", arg: 3, scope: !1661, file: !16, line: 186, type: !225)
!1668 = !DILocalVariable(name: "i", scope: !1661, file: !16, line: 186, type: !225)
!1669 = !DILocation(line: 0, scope: !1661)
!1670 = !DILocation(line: 186, column: 1, scope: !1671)
!1671 = distinct !DILexicalBlock(scope: !1672, file: !16, line: 186, column: 1)
!1672 = distinct !DILexicalBlock(scope: !1661, file: !16, line: 186, column: 1)
!1673 = !DILocation(line: 186, column: 1, scope: !1674)
!1674 = distinct !DILexicalBlock(scope: !1675, file: !16, line: 186, column: 1)
!1675 = distinct !DILexicalBlock(scope: !1661, file: !16, line: 186, column: 1)
!1676 = !DILocation(line: 186, column: 1, scope: !1675)
!1677 = !DILocation(line: 186, column: 1, scope: !1678)
!1678 = distinct !DILexicalBlock(scope: !1674, file: !16, line: 186, column: 1)
!1679 = distinct !{!1679, !1676, !1676, !393, !394}
!1680 = !DILocation(line: 186, column: 1, scope: !1661)
!1681 = distinct !DISubprogram(name: "write_double_array", scope: !16, file: !16, line: 187, type: !1682, scopeLine: 187, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !247, retainedNodes: !1684)
!1682 = !DISubroutineType(types: !1683)
!1683 = !{!225, !225, !1383, !225}
!1684 = !{!1685, !1686, !1687, !1688}
!1685 = !DILocalVariable(name: "fd", arg: 1, scope: !1681, file: !16, line: 187, type: !225)
!1686 = !DILocalVariable(name: "arr", arg: 2, scope: !1681, file: !16, line: 187, type: !1383)
!1687 = !DILocalVariable(name: "n", arg: 3, scope: !1681, file: !16, line: 187, type: !225)
!1688 = !DILocalVariable(name: "i", scope: !1681, file: !16, line: 187, type: !225)
!1689 = !DILocation(line: 0, scope: !1681)
!1690 = !DILocation(line: 187, column: 1, scope: !1691)
!1691 = distinct !DILexicalBlock(scope: !1692, file: !16, line: 187, column: 1)
!1692 = distinct !DILexicalBlock(scope: !1681, file: !16, line: 187, column: 1)
!1693 = !DILocation(line: 187, column: 1, scope: !1694)
!1694 = distinct !DILexicalBlock(scope: !1695, file: !16, line: 187, column: 1)
!1695 = distinct !DILexicalBlock(scope: !1681, file: !16, line: 187, column: 1)
!1696 = !DILocation(line: 187, column: 1, scope: !1695)
!1697 = !DILocation(line: 187, column: 1, scope: !1698)
!1698 = distinct !DILexicalBlock(scope: !1694, file: !16, line: 187, column: 1)
!1699 = distinct !{!1699, !1696, !1696, !393, !394}
!1700 = !DILocation(line: 187, column: 1, scope: !1681)
!1701 = !DILocation(line: 0, scope: !770)
!1702 = !DILocation(line: 190, column: 3, scope: !777)
!1703 = !DILocation(line: 191, column: 3, scope: !770)
!1704 = !DILocation(line: 192, column: 3, scope: !770)
!1705 = distinct !DISubprogram(name: "main", scope: !184, file: !184, line: 14, type: !1706, scopeLine: 15, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !308, retainedNodes: !1708)
!1706 = !DISubroutineType(types: !1707)
!1707 = !{!225, !225, !1078}
!1708 = !{!1709, !1710, !1711, !1712, !1713, !1714, !1715, !1716, !1717}
!1709 = !DILocalVariable(name: "argc", arg: 1, scope: !1705, file: !184, line: 14, type: !225)
!1710 = !DILocalVariable(name: "argv", arg: 2, scope: !1705, file: !184, line: 14, type: !1078)
!1711 = !DILocalVariable(name: "in_file", scope: !1705, file: !184, line: 17, type: !249)
!1712 = !DILocalVariable(name: "check_file", scope: !1705, file: !184, line: 19, type: !249)
!1713 = !DILocalVariable(name: "in_fd", scope: !1705, file: !184, line: 34, type: !225)
!1714 = !DILocalVariable(name: "data", scope: !1705, file: !184, line: 35, type: !249)
!1715 = !DILocalVariable(name: "out_fd", scope: !1705, file: !184, line: 46, type: !225)
!1716 = !DILocalVariable(name: "check_fd", scope: !1705, file: !184, line: 55, type: !225)
!1717 = !DILocalVariable(name: "ref", scope: !1705, file: !184, line: 56, type: !249)
!1718 = !DILocation(line: 0, scope: !1705)
!1719 = !DILocation(line: 21, column: 3, scope: !1720)
!1720 = distinct !DILexicalBlock(scope: !1721, file: !184, line: 21, column: 3)
!1721 = distinct !DILexicalBlock(scope: !1705, file: !184, line: 21, column: 3)
!1722 = !DILocation(line: 26, column: 11, scope: !1723)
!1723 = distinct !DILexicalBlock(scope: !1705, file: !184, line: 26, column: 7)
!1724 = !DILocation(line: 26, column: 7, scope: !1705)
!1725 = !DILocation(line: 27, column: 15, scope: !1723)
!1726 = !DILocation(line: 29, column: 11, scope: !1727)
!1727 = distinct !DILexicalBlock(scope: !1705, file: !184, line: 29, column: 7)
!1728 = !DILocation(line: 29, column: 7, scope: !1705)
!1729 = !DILocation(line: 30, column: 18, scope: !1727)
!1730 = !DILocation(line: 30, column: 5, scope: !1727)
!1731 = !DILocation(line: 36, column: 17, scope: !1705)
!1732 = !DILocation(line: 36, column: 10, scope: !1705)
!1733 = !DILocation(line: 37, column: 3, scope: !1734)
!1734 = distinct !DILexicalBlock(scope: !1735, file: !184, line: 37, column: 3)
!1735 = distinct !DILexicalBlock(scope: !1705, file: !184, line: 37, column: 3)
!1736 = !DILocation(line: 38, column: 11, scope: !1705)
!1737 = !DILocation(line: 39, column: 3, scope: !1738)
!1738 = distinct !DILexicalBlock(scope: !1739, file: !184, line: 39, column: 3)
!1739 = distinct !DILexicalBlock(scope: !1705, file: !184, line: 39, column: 3)
!1740 = !DILocation(line: 40, column: 3, scope: !1705)
!1741 = !DILocation(line: 0, scope: !686, inlinedAt: !1742)
!1742 = distinct !DILocation(line: 43, column: 3, scope: !1705)
!1743 = !DILocation(line: 8, column: 28, scope: !686, inlinedAt: !1742)
!1744 = !DILocation(line: 8, column: 37, scope: !686, inlinedAt: !1742)
!1745 = !DILocation(line: 8, column: 3, scope: !686, inlinedAt: !1742)
!1746 = !DILocation(line: 47, column: 12, scope: !1705)
!1747 = !DILocation(line: 48, column: 3, scope: !1748)
!1748 = distinct !DILexicalBlock(scope: !1749, file: !184, line: 48, column: 3)
!1749 = distinct !DILexicalBlock(scope: !1705, file: !184, line: 48, column: 3)
!1750 = !DILocation(line: 0, scope: !841, inlinedAt: !1751)
!1751 = distinct !DILocation(line: 49, column: 3, scope: !1705)
!1752 = !DILocation(line: 0, scope: !770, inlinedAt: !1753)
!1753 = distinct !DILocation(line: 66, column: 3, scope: !841, inlinedAt: !1751)
!1754 = !DILocation(line: 190, column: 3, scope: !777, inlinedAt: !1753)
!1755 = !DILocation(line: 191, column: 3, scope: !770, inlinedAt: !1753)
!1756 = !DILocation(line: 0, scope: !782, inlinedAt: !1757)
!1757 = distinct !DILocation(line: 67, column: 3, scope: !841, inlinedAt: !1751)
!1758 = !DILocation(line: 177, column: 1, scope: !792, inlinedAt: !1757)
!1759 = !DILocation(line: 177, column: 1, scope: !794, inlinedAt: !1757)
!1760 = !DILocation(line: 177, column: 1, scope: !795, inlinedAt: !1757)
!1761 = distinct !{!1761, !1758, !1758, !393, !394}
!1762 = !DILocation(line: 50, column: 3, scope: !1705)
!1763 = !DILocation(line: 57, column: 16, scope: !1705)
!1764 = !DILocation(line: 57, column: 9, scope: !1705)
!1765 = !DILocation(line: 58, column: 3, scope: !1766)
!1766 = distinct !DILexicalBlock(scope: !1767, file: !184, line: 58, column: 3)
!1767 = distinct !DILexicalBlock(scope: !1705, file: !184, line: 58, column: 3)
!1768 = !DILocation(line: 59, column: 14, scope: !1705)
!1769 = !DILocation(line: 60, column: 3, scope: !1770)
!1770 = distinct !DILexicalBlock(scope: !1771, file: !184, line: 60, column: 3)
!1771 = distinct !DILexicalBlock(scope: !1705, file: !184, line: 60, column: 3)
!1772 = !DILocation(line: 0, scope: !809, inlinedAt: !1773)
!1773 = distinct !DILocation(line: 61, column: 3, scope: !1705)
!1774 = !DILocation(line: 54, column: 3, scope: !809, inlinedAt: !1773)
!1775 = !DILocation(line: 56, column: 7, scope: !809, inlinedAt: !1773)
!1776 = !DILocation(line: 0, scope: !710, inlinedAt: !1777)
!1777 = distinct !DILocation(line: 58, column: 7, scope: !809, inlinedAt: !1773)
!1778 = !DILocation(line: 64, column: 17, scope: !710, inlinedAt: !1777)
!1779 = !DILocation(line: 64, column: 3, scope: !710, inlinedAt: !1777)
!1780 = !DILocation(line: 66, column: 22, scope: !721, inlinedAt: !1777)
!1781 = !DILocation(line: 66, column: 26, scope: !721, inlinedAt: !1777)
!1782 = !DILocation(line: 66, column: 32, scope: !721, inlinedAt: !1777)
!1783 = !DILocation(line: 66, column: 35, scope: !721, inlinedAt: !1777)
!1784 = !DILocation(line: 66, column: 39, scope: !721, inlinedAt: !1777)
!1785 = !DILocation(line: 66, column: 9, scope: !722, inlinedAt: !1777)
!1786 = !DILocation(line: 69, column: 6, scope: !722, inlinedAt: !1777)
!1787 = !DILocation(line: 64, column: 10, scope: !710, inlinedAt: !1777)
!1788 = !DILocation(line: 64, column: 13, scope: !710, inlinedAt: !1777)
!1789 = distinct !{!1789, !1779, !1790, !393, !394}
!1790 = !DILocation(line: 70, column: 3, scope: !710, inlinedAt: !1777)
!1791 = !DILocation(line: 71, column: 6, scope: !734, inlinedAt: !1777)
!1792 = !DILocation(line: 71, column: 8, scope: !734, inlinedAt: !1777)
!1793 = !DILocation(line: 71, column: 6, scope: !710, inlinedAt: !1777)
!1794 = !DILocation(line: 59, column: 32, scope: !809, inlinedAt: !1773)
!1795 = !DILocation(line: 59, column: 3, scope: !809, inlinedAt: !1773)
!1796 = !DILocation(line: 60, column: 3, scope: !809, inlinedAt: !1773)
!1797 = !DILocation(line: 0, scope: !859, inlinedAt: !1798)
!1798 = distinct !DILocation(line: 66, column: 8, scope: !1799)
!1799 = distinct !DILexicalBlock(scope: !1705, file: !184, line: 66, column: 7)
!1800 = !DILocation(line: 76, column: 17, scope: !859, inlinedAt: !1798)
!1801 = !DILocation(line: 79, column: 10, scope: !859, inlinedAt: !1798)
!1802 = !DILocation(line: 66, column: 7, scope: !1705)
!1803 = !DILocation(line: 67, column: 13, scope: !1804)
!1804 = distinct !DILexicalBlock(scope: !1799, file: !184, line: 66, column: 32)
!1805 = !DILocation(line: 67, column: 5, scope: !1804)
!1806 = !DILocation(line: 68, column: 5, scope: !1804)
!1807 = !DILocation(line: 71, column: 3, scope: !1705)
!1808 = !DILocation(line: 72, column: 3, scope: !1705)
!1809 = !DILocation(line: 74, column: 3, scope: !1705)
!1810 = !DILocation(line: 75, column: 3, scope: !1705)
!1811 = !DILocation(line: 76, column: 1, scope: !1705)
!1812 = !DISubprogram(name: "open", scope: !1813, file: !1813, line: 209, type: !1814, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!1813 = !DIFile(filename: "/opt/riscv/sysroot/usr/include/fcntl.h", directory: "")
!1814 = !DISubroutineType(types: !1815)
!1815 = !{!225, !960, !225, null}
