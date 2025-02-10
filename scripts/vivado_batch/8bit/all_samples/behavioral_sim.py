import sys
sys.path.insert(0, '../../../../machine/')
import global_constants as my
import shutil
import os
import glob
import subprocess

if __name__ == "__main__":

    ##################################################################################
    ## Console Arguments
    ##################################################################################

    if len(sys.argv) != 5:
        print("Usage: python main.py <-machine> <sensor> <dataset> <points>")
        sys.exit(1)

    machine = str(sys.argv[1])
    sensor = str(sys.argv[2])
    dataset = int(sys.argv[3])
    points = int(sys.argv[4])

    ##################################################################################
    ## Constants and directories
    ##################################################################################

    vivado_constants = my.get_vivado(machine)
    vivado_executable = vivado_constants[0]
    vivado_project = vivado_constants[1]

    my_directories = my.get_directories(machine)
    input_maindir = my_directories[0]
    output_maindir = my_directories[1]
    FPGA_input_maindir = my_directories[2]
    FPGA_output_maindir = my_directories[3]
    FPGA_twiddle_dir = my_directories[4]

    python_version = my.get_python(machine)

    ##################################################################################
    ## Cleanups
    ##################################################################################

    # Clean up files (log and jou files)
    for ext in ('*.log', '*.jou'):
        for file in os.listdir('.'):
            if file.endswith(ext):
                os.remove(file)

    ##################################################################################
    ## Batch Processing
    ##################################################################################

    print('\n*******************************************************************************************\n')

    print(f"\nRun dataset {dataset} for {points} input samples and for {sensor} bit sensor\n")

    # Run the Python script to generate generics
    result = subprocess.run(
        [python_version, 'generate_generics.py', machine,str(sensor) ,str(points), str(dataset)],
        capture_output=True, text=True
    )

    # Parse the output to get environment variables
    generics = {}
    for line in result.stdout.splitlines():
        if '=' in line:
            key, value = line.split('=', 1)
            generics[key.strip()] = value.strip()

    # Check the variables were set
    for key, value in generics.items():
        print(f"{key}={value}")

    # Create the TCL script dynamically
    with open('temp_script.tcl', 'w') as tcl_script:
        tcl_script.write(f"""
    # Open the project
    open_project {vivado_project}

    # Set generics for simulation
    set_property generic {{
        points={points} \\
        stages={generics['stages']} \\
        stagebits={generics['stagebits']} \\
        shiftbits={generics['shiftbits']} \\
        maxcount={generics['maxcount']} \\
        width={generics['width']} \\
        RAM_file="{generics['RAM_file']}" \\
        ROM_file="{generics['ROM_file']}" \\
        resultfile="{generics['resultfile']}" \\
    }} [get_filesets sim_1]

    # Launch behavioral simulation
    launch_simulation -mode behavioral

    # Run the simulation
    run all

    # Close the project
    close_project
    """)

    if not os.path.exists('vivado_logs'):
        os.makedirs('vivado_logs')
    log_file = f"vivado_logs/{dataset}dataset_{points}points.log"
    with open(log_file, 'w') as file:
        pass

    print('\nRunnning Vivado Simulation')
    result = subprocess.run(
        [vivado_executable, '-mode', 'batch', '-source', 'temp_script.tcl'],
        capture_output=True, text=True
    )

    with open(log_file, 'w') as log:
        log.write(result.stdout)

    print(f"Vivado exited with code {result.returncode}\n")

    # Clean up the temporary TCL script
    if os.path.exists('temp_script.tcl'):
        os.remove('temp_script.tcl')

    # Clean up any remaining log/jou files
    for ext in ('*.log', '*.jou'):
        for file in glob.glob(ext):
            try:
                os.remove(file)
            except Exception as e:
                print(f"Error deleting {file}: {e}")

    dirs_to_delete = ['__pycache__', '.Xil']
    for dir_name in dirs_to_delete:
        if os.path.exists(dir_name):
            try:
                shutil.rmtree(dir_name)
            except Exception as e:
                print(f"Error deleting directory {dir_name}: {e}")

print('\n*******************************************************************************************\n')