def get_vivado(machine):
    '''
    Retruns:
    - vivado binary
    - VIVADO project executable
    '''
    if machine == "-Charon_8bit":
        vivado_executable = r'/home/fpga/Xilinx/installation/Vivado/2021.1/bin/vivado'
        vivado_project = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/Designs/VIVADO_21.1/FFT_Behavioral_arch_x32/FFT_Behavioral_arch_x32.xpr"
    elif machine == "-Charon_16bit":
        vivado_executable = r'/home/fpga/Xilinx/installation/Vivado/2021.1/bin/vivado'
        vivado_project = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/Designs/VIVADO_21.1/FFT_Behavioral_arch_x64/FFT_Behavioral_arch_x64.xpr"
    elif machine == "-yannos_8bit":
        vivado_executable = r'C:/Xilinx/Vivado/2022.2/bin/vivado.bat'
        vivado_project = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/designs/Vivado_22.2/FFT_8bit_SoC_Behavioral/FFT_8bit_SoC_Behavioral.xpr"
    elif machine == "-yannos_16bit":
        vivado_executable = r'C:/Xilinx/Vivado/2022.2/bin/vivado.bat'
        vivado_project = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/designs/Vivado_22.2/FFT_16bit_SoC_Behavioral/FFT_16bit_SoC_Behavioral.xpr"
    return [vivado_executable, vivado_project]

def get_directories(machine):
    '''
    Retruns:
    - **input_maindir** : directory where the input files are stored. The format is real numbers of inputs (floats)
    - **output_maindir** : directory where the numpy result files are stored
    - **FPGA_input_maindir** : directory where the FPGA input binaries are stored
    - **FPGA_output_maindir** : directory where the FPGA result binaries are stored
    - **FPGA_twiddle_dir** : directory where the twiddle binaries are stored
    '''
    if machine == "-Charon_8bit":
        input_maindir = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/dataset/input/random_samples/"
        output_maindir = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/dataset/8bit/output/random_samples/"
        FPGA_input_maindir = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/dataset/8bit/input_bin/random_samples/"
        FPGA_output_maindir = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/dataset/8bit/output_bin/random_samples/"
        FPGA_twiddle_dir = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/dataset/twiddles/"
    elif machine == "-Charon_16bit":
        input_maindir = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/dataset/input/random_samples/"
        output_maindir = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/dataset/16bit/output/random_samples/"
        FPGA_input_maindir = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/dataset/16bit/input_bin/random_samples/"
        FPGA_output_maindir = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/dataset/16bit/output_bin/random_samples/"
        FPGA_twiddle_dir = "/home/fpga/yannos/FPGA/fft_mdpi_paper_2024/fft-avr3200/dataset/twiddles/"
    elif machine == "-yannos_8bit":
        input_maindir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/input/random_samples/"
        output_maindir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/8bit/output/random_samples/"
        FPGA_input_maindir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/8bit/input_bin/random_samples/"
        FPGA_output_maindir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/8bit/output_bin/random_samples/"
        # FPGA_twiddle_dir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/twiddles/"
        FPGA_twiddle_dir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/twiddles/memconfig_2-21/"
    elif machine == "-yannos_16bit":
        input_maindir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/input/random_samples/"
        output_maindir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/16bit/output/random_samples/"
        FPGA_input_maindir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/16bit/input_bin/random_samples/"
        FPGA_output_maindir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/16bit/output_bin/random_samples/"
        # FPGA_twiddle_dir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/twiddles/"
        FPGA_twiddle_dir = "D:/Yannos/FILES/PROGRAMS/FPGA/SoC/FFT/dataset/twiddles/memconfig_2-21/"
    return [input_maindir, output_maindir, FPGA_input_maindir, FPGA_output_maindir, FPGA_twiddle_dir]

def get_python(machine):
    '''
    Returns python version
    '''
    if machine == "-Charon_8bit":
        return 'python3'
    elif machine == "-Charon_16bit":
        return 'python3'
    elif machine == "-yannos_8bit":
        return 'python'
    elif machine == "-yannos_16bit":
        return 'python'
