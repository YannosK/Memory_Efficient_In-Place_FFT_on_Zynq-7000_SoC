import sys
sys.path.insert(0, '../machine/')
import global_constants as my
import os
import glob
import shutil

if __name__ == "__main__":

    ##################################################################################
    ## Console Arguments
    ##################################################################################

    if len(sys.argv) != 2:
        print("Usage: python cleanup.py <-machine>")
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

    ################################################################
    # Clean everything: all subfolders and .txt files
    ################################################################

    for directory in directories:
        # Delete all .txt files
        for file_path in glob.glob(os.path.join(directory, "*.txt")):
            try:
                os.remove(file_path)  # Delete the file
            except Exception as e:
                print(f"Error deleting {file_path}: {e}")

        # Delete any subdirectories and their contents
        for subdirectory in os.listdir(directory):
            subdirectory_path = os.path.join(directory, subdirectory)
            if os.path.isdir(subdirectory_path):
                try:
                    shutil.rmtree(subdirectory_path)
                except Exception as e:
                    print(f"Error deleting directory {subdirectory_path}: {e}")
