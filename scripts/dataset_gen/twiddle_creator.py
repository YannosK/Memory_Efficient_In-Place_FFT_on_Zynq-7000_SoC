import os
import sys
sys.path.insert(0, '../machine/')
sys.path.insert(0, '../golden_code/')
import global_constants as my
import fft_integers as FFTint

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


if __name__ == "__main__":

    ##################################################################################
    ## Console Arguments
    ##################################################################################

    if len(sys.argv) < 5 or len(sys.argv) > 6:
        print("Usage: python main.py <machine> <points> <twidwidth> <twidfractionals> [dir]")
        sys.exit(1)

    machine = str(sys.argv[1])
    points = int(sys.argv[2])
    width = int(sys.argv[3])
    fractionals = int(sys.argv[4])

    if len(sys.argv) == 6:
        dir = str(sys.argv[5]) + "/"
    else:
        dir = ""

    ################################################################
    # File system settings
    ################################################################

    my_directories = my.get_directories(machine)
    FPGA_twiddle_dir = my_directories[4]

    ################################################################
    # Creating the Twiddle ROM files: as many as there are points
    ################################################################

    twid_dir = FPGA_twiddle_dir + dir

    if not os.path.exists(twid_dir):
        os.makedirs(twid_dir)
    
    FFTint.twiddlefile(points, twid_dir, f"twiddles_{points}p.txt", f"twiddles_complex_{points}p.txt", width, fractionals, False)