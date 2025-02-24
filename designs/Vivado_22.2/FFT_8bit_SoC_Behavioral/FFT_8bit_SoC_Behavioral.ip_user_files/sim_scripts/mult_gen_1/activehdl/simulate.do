onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+mult_gen_1  -gpoints=1024 -gstages=10 -gstagebits=4 -gshiftbits=5 -gmaxcount=8 -gwidth=32 -gRAM_file="D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/8bit/input_bin/random_samples/32_bits/1024_samples/0_in.txt" -gROM_file="D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/twiddles/memconfig_2-21/twiddles_1024p.txt" -gresultfile="D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/8bit/output_bin/random_samples/32_bits/1024_samples/0_FPGA_out.txt" -L xpm -L xbip_utils_v3_0_10 -L xbip_pipe_v3_0_6 -L xbip_bram18k_v3_0_6 -L mult_gen_v12_0_18 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.mult_gen_1 xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {mult_gen_1.udo}

run 1000ns

endsim

quit -force
