import sys
sys.path.insert(0, '../../../python_scripts/')
import global_constants as my
import subprocess

if __name__ == "__main__":

    ##################################################################################
    ## Console Arguments
    ##################################################################################

    if len(sys.argv) != 2:
        print("Usage: python main.py <-machine>")
        sys.exit(1)

    machine = str(sys.argv[1])

    python_version = my.get_python(machine)

    ##################################################################################
    ## Constants
    ##################################################################################

    # FFT_sensors = ["7_bits/", "16_bits/", "32_bits/"]
    # FFT_points = [8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768]
    FFT_sensors = [32]
    FFT_points = [2048, 4096, 8192]

    for sensor in FFT_sensors:
        for points in FFT_points:
            for dataset in range(1000):
                subprocess.run([python_version, 'behavioral_sim.py', machine, str(sensor), str(dataset), str(points)])
