import csv
import sys
sys.path.insert(0, '../../../golden_code/')
import fft_integers as FFTint 

if __name__ == "__main__":
    
    if len(sys.argv) != 7:
        print("Usage: python produce_rel_error.py <mem word width> <FPGA result file> <numpy result file> <sensor bits> <FFT points> <dataset>")
        sys.exit(1)

    width = int(sys.argv[1])
    resultfile = str(sys.argv[2])
    outfile = str(sys.argv[3])
    sensor = str(sys.argv[4])
    points = str(sys.argv[5])
    dataset = str(sys.argv[6])

    bits = width // 4
    decimals = bits - 2

    rel_err = FFTint.produce_relative_error(resultfile, outfile, bits, decimals)

    print(f"Relative error for dataset={dataset}, for {points} input points and for {sensor} bit sensor is: ", rel_err)
