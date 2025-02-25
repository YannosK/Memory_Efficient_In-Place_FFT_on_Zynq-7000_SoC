import argparse
import configparser
import os
from scripts.golden_code.fft_integers import twiddlefile
from scripts.machine.machine_config import load_config

################################################
# Parser
################################################

parser = argparse.ArgumentParser(description='This script creates binaries of the FFT twiddles. For an N-point FFT it generates half the twiddle values. The egenerated file will be used in the Vivado project')

parser.add_argument('machinefile',
                    help='A .ini file that has important system information')
parser.add_argument('points',
                    help='Number of FFT points')
parser.add_argument('twidwidth',
                    help='The data width of the twiddles')
parser.add_argument('twidfractionals',
                    help='The number of fractional bits for each twiddle')

parser.add_argument('-f', '--filedir',
                    action='store',
                    help='Specifies a directory to store the twiddle file. Else it will store them in the root of the dataset/twiddles as dictated by the inputed .ini')
parser.add_argument('-v', '--verbose',
                    action='store_true',
                    help='Verbose execution of the script')

################################################
# Main
################################################


if __name__ == "__main__":

    #****************************************#
    ## Console Arguments
    #****************************************#

    args = parser.parse_args()

    machine = args.machinefile
    points = int(args.points)
    width = int(args.twidwidth)
    fractionals = int(args.twidfractionals)
    userdir = args.filedir

    #****************************************#
    # File system settings
    #****************************************#

    config = load_config(machine)
    FPGA_twiddle_dir = config['path.dataset']['dataset_twiddles']

    twid_dir = os.path.join(FPGA_twiddle_dir, userdir)
    if not os.path.exists(twid_dir):
        os.makedirs(twid_dir)
    filename = f"twiddles_{points}p.txt"

    if args.verbose:
        print("***************************************************")
        print()
        print('Generating twiddle file for:')
        print("FFT points: ", points)
        print("Twiddle width: ", width)
        print("Fractional bits: ", fractionals)
        print("In the file:", os.path.join(twid_dir, filename))
        print()
        print("***************************************************")

    #****************************************#
    # Creating the Twiddle ROM files:
    # - as many as there are points
    #****************************************#

    twiddlefile(points, twid_dir, filename, f"twiddles_complex_{points}p.txt", width, fractionals, False)