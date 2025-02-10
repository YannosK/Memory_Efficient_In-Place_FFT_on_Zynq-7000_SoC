import os
import sys
sys.path.insert(0, '../../../python_scripts/')
import global_constants as my
import subprocess

def get_datasets(directory, start=0):
    file_numbers = []
    
    for filename in os.listdir(directory):
        if filename.endswith('.txt'):
            number = filename.split('.')[0]
            if number.isdigit():
                file_numbers.append(int(number))

    file_numbers.sort()

    filtered_numbers = [num for num in file_numbers if num >= start]
    
    return filtered_numbers

def get_completed_datasets(directory):

    file_numbers = []
    
    for filename in os.listdir(directory):
        if filename.endswith('.txt'):
            number = filename.split('.')[0]
            if number.isdigit():
                file_numbers.append(int(number))
    
    return file_numbers

if __name__ == "__main__":

    ##################################################################################
    ## Console Arguments
    ##################################################################################

    if len(sys.argv) != 2:
        print("Usage: python main.py <-machine>")
        sys.exit(1)

    machine = str(sys.argv[1])

    python_version = my.get_python(machine)
    dirs = my.get_directories(machine)
    input_dir_root = dirs[0]
    output_dir_root = dirs[3]

    ##################################################################################
    ## Constants
    ##################################################################################

    # FFT_sensors = ["7_bits/", "16_bits/", "32_bits/"]
    # FFT_points = [8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768]
    FFT_sensors = [32]
    FFT_points = [16384]

    for sensor in FFT_sensors:
        for points in FFT_points:

            input_dir = input_dir_root + f'{sensor}_bits/' + f'{points}_samples'
            output_dir = output_dir_root + f'{sensor}_bits/' + f'{points}_samples'

            FFT_datasets = get_datasets(input_dir)

            completed_datasets = get_completed_datasets(output_dir)

            for dataset in FFT_datasets:

                if dataset not in completed_datasets:
                    subprocess.run([python_version, 'behavioral_sim.py', machine, str(sensor), str(dataset), str(points)])
