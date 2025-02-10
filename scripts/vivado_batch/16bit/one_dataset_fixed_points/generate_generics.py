import sys
sys.path.insert(0, '../../../python_scripts/')
import global_constants as my

if __name__ == "__main__":

    if len(sys.argv) != 5:
        print("Usage: python generate_generics.py <-machine> <sensor> <points> <dataset>")
        sys.exit(1)
    
    machine = str(sys.argv[1])
    sensor = str(sys.argv[2])
    points = int(sys.argv[3])
    dataset = int(sys.argv[4])

    my_directories = my.get_directories(machine)

    input_maindir = my_directories[0]
    output_maindir = my_directories[1]
    FPGA_input_maindir = my_directories[2]
    FPGA_output_maindir = my_directories[3]
    FPGA_twiddle_dir = my_directories[4]

    generics_lookup = {
        8: {
            "stages": 3,
            "stagebits": 2,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/8_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_8p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/8_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/8_samples/{dataset}.txt"
        },
        16: {
            "stages": 4,
            "stagebits": 3,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/16_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_16p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/16_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/16_samples/{dataset}.txt"
        },
        32: {
            "stages": 5,
            "stagebits": 3,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/32_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_32p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/32_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/32_samples/{dataset}.txt"
        },
        64: {
            "stages": 6,
            "stagebits": 3,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/64_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_64p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/64_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/64_samples/{dataset}.txt"
        },
        128: {
            "stages": 7,
            "stagebits": 3,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/128_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_128p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/128_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/128_samples/{dataset}.txt"
        },
        256: {
            "stages": 8,
            "stagebits": 4,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/256_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_256p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/256_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/256_samples/{dataset}.txt"
        },
        512: {
            "stages": 9,
            "stagebits": 4,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/512_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_512p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/512_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/512_samples/{dataset}.txt"
        },
        1024: {
            "stages": 10,
            "stagebits": 4,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/1024_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_1024p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/1024_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/1024_samples/{dataset}.txt"
        },
        2048: {
            "stages": 11,
            "stagebits": 4,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/2048_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_2048p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/2048_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/2048_samples/{dataset}.txt"
        },
        4096: {
            "stages": 12,
            "stagebits": 4,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/4096_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_4096p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/4096_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/4096_samples/{dataset}.txt"
        },
        8192: {
            "stages": 13,
            "stagebits": 4,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/8192_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_8192p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/8192_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/8192_samples/{dataset}.txt"
        },
        16384: {
            "stages": 14,
            "stagebits": 4,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/16384_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_16384p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/16384_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/16384_samples/{dataset}.txt"
        },
        32768: {
            "stages": 15,
            "stagebits": 4,
            "shiftbits": 6,
            "maxcount": 8,
            "width": 64,
            "RAM_file": FPGA_input_maindir + "{sensor}_bits/32768_samples/{dataset}_in.txt",
            "ROM_file": FPGA_twiddle_dir + "twiddles_32768p.txt",
            "resultfile": FPGA_output_maindir + "{sensor}_bits/32768_samples/{dataset}.txt",
            "outfile": output_maindir + "{sensor}_bits/32768_samples/{dataset}.txt"
        },
    }

    generics = generics_lookup.get(points, None)
    if generics:
        generics["RAM_file"] = generics["RAM_file"].format(sensor=sensor, dataset=dataset)
        generics["resultfile"] = generics["resultfile"].format(sensor=sensor, dataset=dataset)
        generics["outfile"] = generics["outfile"].format(sensor=sensor, dataset=dataset)

    if generics:
        for key, value in generics.items():
            print(f"{key}={value}")
    else:
        print(f"No generics found for points {points}, dataset {dataset} and {sensor} bit sensor.")
