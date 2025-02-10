input_maindir = "E:/fft_mdpi_paper_2024_dataset/input/random_samples/"
output_maindir = "D:/fft_mdpi_paper_2024_dataset/output/fpga/random_samples/"
FPGA_input_maindir = "D:/fft_mdpi_paper_2024_dataset/input_binaries/"
FPGA_output_maindir = "D:/fft_mdpi_paper_2024_dataset/output_binaries/"
FPGA_twiddle_dir = "D:/fft_mdpi_paper_2024_dataset/twiddle_binaries/"

generics_lookup = {
    8: {
        "stages": 3,
        "stagebits": 2,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/8_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_8p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/8_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/8_samples/{dataset}.txt"
    },
    16: {
        "stages": 4,
        "stagebits": 3,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/16_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_16p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/16_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/16_samples/{dataset}.txt"
    },
    32: {
        "stages": 5,
        "stagebits": 3,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/32_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_32p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/32_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/32_samples/{dataset}.txt"
    },
    64: {
        "stages": 6,
        "stagebits": 3,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/64_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_64p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/64_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/64_samples/{dataset}.txt"
    },
    128: {
        "stages": 7,
        "stagebits": 3,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/128_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_128p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/128_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/128_samples/{dataset}.txt"
    },
    256: {
        "stages": 8,
        "stagebits": 4,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/256_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_256p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/256_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/256_samples/{dataset}.txt"
    },
    512: {
        "stages": 9,
        "stagebits": 4,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/512_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_512p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/512_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/512_samples/{dataset}.txt"
    },
    1024: {
        "stages": 10,
        "stagebits": 4,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/1024_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_1024p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/1024_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/1024_samples/{dataset}.txt"
    },
    2048: {
        "stages": 11,
        "stagebits": 4,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/2048_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_2048p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/2048_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/2048_samples/{dataset}.txt"
    },
    4096: {
        "stages": 12,
        "stagebits": 4,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/4096_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_4096p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/4096_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/4096_samples/{dataset}.txt"
    },
    8192: {
        "stages": 13,
        "stagebits": 4,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/8192_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_8192p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/8192_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/8192_samples/{dataset}.txt"
    },
    16384: {
        "stages": 14,
        "stagebits": 4,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/16384_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_16384p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/16384_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/16384_samples/{dataset}.txt"
    },
    32768: {
        "stages": 15,
        "stagebits": 4,
        "shiftbits": 5,
        "maxcount": 8,
        "width": 32,
        "RAM_file": FPGA_input_maindir + "{sensor}_bits/32768_samples/{dataset}_in.txt",
        "ROM_file": FPGA_twiddle_dir + "twiddles_32768p.txt",
        "resultfile": FPGA_output_maindir + "{sensor}_bits/32768_samples/{dataset}_FPGA_out.txt",
        "outfile": output_maindir + "{sensor}_bits/32768_samples/{dataset}.txt"
    },
}
