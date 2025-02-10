import sys
sys.path.insert(0, '../python_scripts/')
import global_constants as my
import os
import glob
import shutil
import numpy as np
from tqdm import tqdm
import fft_integers as FFTint
import fft_algorithm as FFTalg


if __name__ == "__main__":

    ##################################################################################
    ## Console Arguments
    ##################################################################################

    if len(sys.argv) != 2:
        print("Usage: python main.py <-machine>")
        sys.exit(1)

    machine = str(sys.argv[1])

    ################################################################
    # File system settings
    ################################################################

    my_directories = my.get_directories(machine)
    input_maindir = my_directories[0]
    output_maindir = my_directories[1]
    FPGA_input_maindir = my_directories[2]
    FPGA_output_maindir = my_directories[3]
    FPGA_twiddle_dir = my_directories[4]

    directories = [output_maindir,
                   FPGA_output_maindir,
                   FPGA_input_maindir,
                   FPGA_twiddle_dir]

    # FFT_sensors = ["7_bits/", "16_bits/", "32_bits/"]
    # FFT_points = [8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768]
    FFT_sensors = ["32_bits/"]
    FFT_points = [1024, 2048]

    ################################################################
    # FPGA architecture memory configuration
    ################################################################

    bits = 8        # bits to represent one signgle fixed point datum
    decimals = 6    # bits that represent the number of decimals


    ################################################################
    # Loop: Read input file and create an input binary
    ################################################################

    # Creating the Twiddle ROM files: as many as there are points
    for points in FFT_points:
        FFTint.twiddlefile(points, FPGA_twiddle_dir, f"twiddles_{points}p.txt", f"twiddles_complex_{points}p.txt", 23, 21, False)

    for sensor in FFT_sensors:
        input_maindir_sensor = input_maindir + sensor

        output_maindir_sensor = os.path.join(output_maindir, sensor)
        os.makedirs(output_maindir_sensor, exist_ok=True)

        FPGA_input_maindir_sensor = os.path.join(FPGA_input_maindir, sensor)
        os.makedirs(FPGA_input_maindir_sensor, exist_ok=True)

        FPGA_output_maindir_sensor = os.path.join(FPGA_output_maindir, sensor)
        os.makedirs(FPGA_output_maindir_sensor, exist_ok=True)

        for points in FFT_points:
            input_dir = input_maindir_sensor + f"{points}_samples/"

            output_dir = os.path.join(output_maindir_sensor, f"{points}_samples/")
            os.makedirs(output_dir, exist_ok=True)

            FPGA_input_dir = os.path.join(FPGA_input_maindir_sensor, f"{points}_samples/")
            os.makedirs(FPGA_input_dir, exist_ok=True)

            FPGA_output_dir = os.path.join(FPGA_output_maindir_sensor, f"{points}_samples/")
            os.makedirs(FPGA_output_dir, exist_ok=True)

            for dataset in tqdm(range(1000), desc=f"In {sensor} --> Processing {points} samples"):
                # FPGA input binaries
                input_name = f"{dataset}"
                input_file = input_dir + input_name + ".txt"
                with open(input_file, "r") as file:
                    input_file_data = [float(line.strip()) for line in file]

                input_points = np.ndarray(0, dtype=complex)
                for value in input_file_data:
                    input_points = np.append(input_points, value + (0*1j))
                if input_points.shape[0] != points:
                    raise ValueError("Must have read wrong file, or worng contents: wrong FFT points")

                # Create FPGA input binaries
                X_bit_revershal = FFTalg.bit_revershal_permutation(input_points)
                FPGA_input_name = f"{dataset}_in.txt"
                FFTint.binfile(X_bit_revershal, FPGA_input_dir, FPGA_input_name, bits, decimals)

                # Create numpy FFT results
                FFT_numpy_array = np.fft.ifft(input_points) * input_points.shape[0]
                output_name = f"{dataset}"
                output_file = output_dir + output_name + ".txt"
                with open(output_file, 'w') as file:
                    for result in FFT_numpy_array:
                        file.write(str(result) + '\n')