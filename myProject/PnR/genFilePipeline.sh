hlstool --calyx-hw --output-level=pre-compile --ir /home/kelvin/FABulous_fork/myProject/PnR/gemm/gemm_affine.mlir --allow-unregistered-dialects -o ./myProject/PnR/gemm/gemm_affine_post_opt.mlir
hlstool --calyx-hw --output-level=core --ir /home/kelvin/FABulous_fork/myProject/PnR/gemm/gemm_affine.mlir --allow-unregistered-dialects -o ./myProject/PnR/gemm/gemm_affine_calyx.mlir
circt-translate --export-calyx ./myProject/PnR/gemm/gemm_affine_calyx.mlir -o /home/kelvin/FABulous_fork/myProject/PnR/gemm/gemm.futil
calyx -p pre-opt -p fsm-compile -p post-opt -p lower -d papercut -d cell-share /home/kelvin/FABulous_fork/myProject/PnR/gemm/gemm.futil --nested -o /home/kelvin/FABulous_fork/myProject/PnR/gemm/gemm_pre_lower.futil --synthesis
calyx -p pre-opt -p fsm-compile -p post-opt -p lower -d papercut -d cell-share -b verilog  /home/kelvin/FABulous_fork/myProject/PnR/gemm/gemm.futil --nested -o /home/kelvin/FABulous_fork/myProject/PnR/gemm/gemm.sv --synthesis
cp /home/kelvin/FABulous_fork/myProject/PnR/gemm/gemm.sv /home/kelvin/FABulous_fork/myProject/user_design/gemm.sv