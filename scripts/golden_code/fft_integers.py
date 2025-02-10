#############################################################################################
# Utility functions for integer arithmetics
#############################################################################################

import csv
import numpy as np

def bin_converter(
        x: float,
        bits: int = 8,
        decimals: int = 6
    ) -> str:
    '''
    Takes as input a floating point number, 
    and converts it to a fixed point integer, 
    with number of bits and decimals denoted by the user

    Args:
        x (float): The floating point number that will be converted to fixed-point binary
        bits (int): The number of bits of the binary
        decimals (int): The The number of bits that represent the decimal points
    
    Retruns:
    - A string with the binary value
    '''
    # # Numpy - Alex version    
    # if x < 0:
    #     res = (np.int8)(x * (2**(decimals)) - 0.5)
    # else:
    #     res = (np.int8)(x * (2**(decimals)) + 0.5)

    # # print(np.binary_repr(res, 8))
    # return str(np.binary_repr(res, 8))

    if bits < decimals:
        raise ValueError("You ask for more decimal points than bits available")

    if x < 0:
        negative = 1
        x = -x
    else:
        negative = 0

    xi = int(x)     # not sure if needed
    xd = x % 1

    # print(xi)
    # print(xd)

    integral = [0] * (bits - decimals)
    # decimal = [0] * decimals
    decimal = [0] * (decimals + 1) # The strategy is calculating the binary with one extra decimal bit (lsb)
    
    # finding the integral part
    for i in range(len(integral)):
        xi, r = divmod(xi, 2)
        integral[i] = r

    # finding the decimal part
    for i in range(len(decimal)):
        xd = xd % 1
        xd = xd * 2
        decimal[len(decimal) - 1 - i] = int(xd)

    numlist = decimal + integral

    # Performing rounding 
    if numlist[0] == 0:
        numlist = numlist[1:]
    else:
        # print(numlist)
        numlist = numlist[1:]
        # print(numlist)
        c = 1
        for i in range(len(numlist)):
            numlist[i] = numlist[i] + c
            if numlist[i] == 2:
                numlist[i] = 0
                c = 1
            else:
                c = 0
    
    # 2s complement
    if negative == 1:
        # print(numlist)
        for i in range(len(numlist)):
            if numlist[i] == 1:
                numlist[i] = 0
            else:
                numlist[i] = 1
        c = 1
        for i in range(len(numlist)):
            numlist[i] = numlist[i] + c
            if numlist[i] == 2:
                numlist[i] = 0
                c = 1
            else:
                c = 0

    # string of bits in correct order
    binstr = ""
    for bit in numlist:
        binstr = str(bit) + binstr

    return binstr

def float_from_bin(
        bin: str,
        decimals: int
    ) -> float:
    '''
    Converts a string that contains a binary value to a float
    The binary is in fixed-point representation with some of the least-significant bits being the decimals

    Args:
        bin (str): a string of '1' and '0' values that represents a fixed-point real number
        decimals (int): the number of decimal bits of the binary number 'bin'
    
    Returns:
    - the floating point number represented from the fixed-point binary
    '''
    bits = len(bin)

    if bits < decimals:
        raise ValueError("You provided more bits for the decimal than the whole bits of the number")
    
    integrals = bits - decimals
    max_expo = integrals - 1

    # print(bits)
    # print(integrals)
    # print(decimals)
    # print(max_expo)

    binary = [0] * bits

    for i, b_char in enumerate(bin):
        if b_char == '1':
            binary[i] = 1
        elif b_char == '0':
            binary[i] = 0
        else:
            raise ValueError("You added a string that does not represent a binary number")
        
    
    if binary[0] == 1:
        x = - (2 ** max_expo)
    else:
        x = 0

    # print(f"2^{max_expo} * {binary[0]} = {x}")

    for i in range(1, bits):
        x = x + (2 ** (max_expo - i)) * binary[i]

    return x

def word_creator(
        a_r: str,
        a_i: str,
        b_r: str,
        b_i: str) -> str:
    '''
    Concatenates n-bit binary numbers represented as strings to one (4*n)-bit number as a string 
    '''
    return a_r + a_i + b_r + b_i

def binfile(
        X: np.ndarray[complex],
        file_path: str = "D:\\Yannos\\FILES\\PROGRAMS\\DST\\FFT_implementation\\fft-avr3200\\notebooks\\",
        file_name: str ="binfile.txt",
        bits: int = 8,
        decimals: int = 6
        ) -> str:
    '''
    Function to create the FFT initial dataset for the FPGA design

    Takes as input a numpy array of complex numbers:
    - It breaks the numbers into real and imaginary parts
    - It encodes these parts to n-bit fixed points
    - It groups them in pairs (four n-bit numbers)
    - it writes them in a file in the order they were in the numpy array

    Args:
        X (np.ndarray[complex]): A numpy array containing the initial complex points, AFTER THE BIT REVERSAL PERMUTATION
        file_path (str): the directory to store the file of binaries
        file_name (str): the name of the file of binaries
        bits (int): the number of bits of one datum
        decimals (int): the number of bits that represent the decimals of the binary number
    '''
    n = len(X)

    if n % 2 != 0:
        raise ValueError("Input array must have even number of values")
    
    bitstrings = []
    
    for i in range(n // 2):
        a = X[2*i]
        b = X[2*i + 1]
        a_r = bin_converter(a.real, bits, decimals)
        a_i = bin_converter(a.imag, bits, decimals)
        b_r = bin_converter(b.real, bits, decimals)
        b_i = bin_converter(b.imag, bits, decimals)
        bit = word_creator(a_r, a_i, b_r, b_i)
        bitstrings.append(bit)
    
    bin_file = file_path + file_name

    with open(bin_file, 'w') as file:
        for string in bitstrings:
            file.write(string + '\n')

def binfile_to_floatfile(
    digits: int = 8,
    decimals: int = 6,
    binfile_path: str = "D:\\Yannos\\FILES\\PROGRAMS\\DST\\FFT_implementation\\fft-avr3200\\notebooks\\datasets\\FPGA_bin_files\\",
    binfile_name: str ="binfile.txt",
    floatfile_path: str = "D:\\Yannos\\FILES\\PROGRAMS\\DST\\FFT_implementation\\fft-avr3200\\notebooks\\datasets\\FPGA_test_files\\",
    floatfile_name: str ="floatfile.txt"
    ):
    '''
    From the values of a file of binaries, that represent fixed-point integers in the format specified by the arguments, a file with the complex floating point values is created
    The file must contain a data word on each line, whose length must be divisible by 'digits'

    Args:
        digits (int): the digits of each binary datum
        decimals (int): the number of decimals in the fixed point representation
        binfile_path (str): the path of the file of binaries
        binfile_name (str): the name of the file of binaries
        floatfile_path (str): the path of the file of complex floats
        floatfile_name (str): the name of the file of complex floats
    '''
    bin_file = binfile_path + binfile_name

    with open(bin_file, "r") as file:
        bin_file_data = [str(line.strip()) for line in file]

    if len(bin_file_data[0]) % digits != 0:
        raise ValueError("Incompatible binary file data with specified digits")
    # print(bin_file_data)

    bin_data = [] * 0
    for word in bin_file_data:
        pieces = [word[i:i + digits] for i in range(0, len(word), digits)]
        for binpoint in pieces:
            bin_data.append(binpoint)
    # print(bin_data)

    float_file = floatfile_path + floatfile_name

    with open(float_file, "w") as file:
        for i in range(0, len(bin_data) - 1, 2):
            # print('\n', bin_data[i], '\t', bin_data[i+1])
            file.write(str(float_from_bin(bin_data[i], decimals) + float_from_bin(bin_data[i+1], decimals)*1j) + '\n')

def twiddlefile(
        n: int,
        file_path: str = "D:\\Yannos\\FILES\\PROGRAMS\\DST\\FFT_implementation\\fft-avr3200\\notebooks\\",
        file_name: str ="twiddles.txt",
        complex_file_name: str = "twiddles_complex.txt",
        bits: int = 10,
        decimals: int = 8,
        create_complex_file: bool = True
        ):
    '''
    Function to create the twiddle ROM content for the FPGA,  alongside with a file with complex values

    Args:
        n (int): an integer specifying the points of the FFT. For n points, n/2 twiddles are generated
        file_path (str): the path of the file
        file_name (str): the name of the file, that contains the memory binaries
        complex_file_name (str): the name of the file, that contains the complex values
        bits (int): the number of bits of one datum
        decimals (int): the number of bits that represent the decimals of the binary number
        create_complex_file (bool): wether to create a file with the complex values or only a binary
    '''
    w = np.ndarray(n//2, dtype=complex)

    w0 = np.exp(1j * 2 * np.pi / n)

    w_s = 1 
    for k in range(len(w)):
        w[k] = w_s
        w_s = w_s*w0

    if create_complex_file == True:
        complex_file = file_path + complex_file_name
        with open(complex_file, 'w') as file:
            for twid in w:
                file.write(str(twid) + '\n')

    bitstr = []

    for wn in w:
        bit_real = bin_converter(wn.real, bits, decimals)
        bit_imag = bin_converter(wn.imag, bits, decimals)
        bit = bit_real + bit_imag
        bitstr.append(bit)

    twiddle_file = file_path + file_name

    with open(twiddle_file, 'w') as file:
        for string in bitstr:
            file.write(string + '\n')

def normalize_complex_nparray(X:  np.ndarray[complex]) ->  np.ndarray[complex]:
    '''
    Takes a numpy array of complex numbers and normalises the results in the range [-1,1]
    '''
    real_parts = X.real
    imag_parts = X.imag

    real_min, real_max = real_parts.min(), real_parts.max()
    imag_min, imag_max = imag_parts.min(), imag_parts.max()

    X_max = max(real_max, imag_max)
    # X_min = min(real_min, imag_min)

    normalized_real = real_parts / X_max
    normalized_imag = imag_parts / X_max

    # normalized_real = 2 * (real_parts - X_min) / (X_max - X_min) - 1
    # normalized_imag = 2 * (imag_parts - X_min) / (X_max - X_min) - 1

    Y = normalized_real + 1j * normalized_imag

    return Y

def compare_files_of_complexes(
    file0_path: str = "./", 
    file0_name: str = "realvalues.txt",
    file1_path: str = "./",
    file1_name: str = "expectedvalues.txt"
    ) -> float:
    '''
    Compares two files that contain complex numbers, line by line and produces average relative error
    The files must contain one complex element on each line
    They must have the same number of lines

    **WARNING**: file0  represents the real value and file1 the measured / approximate

    Args:
        file0_path (str): path of file0
        file0_name (str): name of file0
        file1_path (str): path of file1
        file1_name (str): name of file0
    '''

    file0 = file0_path + file0_name
    file1 = file1_path + file1_name

    with open(file0, "r") as file:
        file0_data_list = [complex(line.strip()) for line in file]

    with open(file1, "r") as file:
        file1_data_list = [complex(line.strip()) for line in file]

    if len(file0_data_list) != len(file1_data_list):
        raise ValueError("Files do not contain the same number of elements")
    
    file0_data = np.array(file0_data_list, dtype=complex)
    file1_data = np.array(file1_data_list, dtype=complex)

    relative_error = np.linalg.norm(file1_data - file0_data) / np.linalg.norm(file0_data)
    
    return relative_error


def resultsfile_from_resultsbin(
        digits: int,
        decimals: int,
        bin_file_path: str,
        bin_file_name: str,
        res_file_path: str,
        res_file_name: str,
        shifts : int = 0
    ):
    '''
    Takes as input the binary as they are inside the RAM in the end of the FFT - before the correct reordering - and produces the results of the FFT in the correct order

    Args:
        digits (int) : the number of digits of each binary datum (fixed-point representation / must divide eactly the word size)
        decimals (int) : the number of bits of binary datum that represent the fractional part / must be less or equal with digits
        bin_file_path (str) : a string that is the directory of the .txt file of the binary results
        bin_file_name (str) : name of the .txt file of the binary results
        res_file_path (str) : a string that is the directory of the .txt file where the complex results will be stored
        res_file_name (str) : name of the file where the complex results will be stored
        shifts (int) : the number of shifts that were performed in the FPGA. Positive means right shifts, negative means left
    '''

    bin_file = bin_file_path + bin_file_name
    res_file = res_file_path + res_file_name

    binfile_to_floatfile(digits, decimals, bin_file_path, bin_file_name, res_file_path, res_file_name)

    with open(res_file, 'r') as file:
        res_data_list = [complex(line.strip()) for line in file]

    res_data = np.array(res_data_list, dtype=complex)

    # Correct data according to shifts
    if shifts != 0:
        for i in range(len(res_data)):
            d_real = res_data[i].real
            d_imag = res_data[i].imag
            if shifts > 0:
                d_real = d_real * (2**shifts)
                d_imag = d_imag * (2**shifts)
                res_data[i] = d_real + 1j*d_imag
            else:
                d_real = d_real / (2**(-shifts))
                d_imag = d_imag / (2**(-shifts))
                res_data[i] = d_real + 1j*d_imag

    # transform data into a 2D array
    res_data_2D = np.copy(res_data).reshape((res_data.shape[0] // 2, 2))
    # perform the reshaping of the 2D array
    res_data_2d_reshape = np.copy(res_data_2D).transpose().reshape(res_data_2D.shape[0], res_data_2D.shape[1])

    # Flatten data back to 1D array
    res_data_reshape = res_data_2d_reshape.flatten()

    # Write data back to the file 
    with open(res_file, 'w') as file:
        for datum in res_data_reshape:
            file.write(str(datum) + '\n')
    
    return

def produce_relative_error(
        bin_file: str,
        out_file: str,
        digits: int,
        decimals: int
) -> float:
    '''
    Takes as input an FPGA output txt file with binary values and the number of shifts as an integer on the last line
    Also it takes as input a txt file of complex FFT output values
    It compares the results and produces relative error
    '''
    with open(bin_file, "r") as file:
        bin_file_data = [str(line.strip()) for line in file]

    # get the shift amount
    shifts = int(bin_file_data.pop())

    if len(bin_file_data[0]) % digits != 0:
        raise ValueError("Incompatible binary file data with specified digits")

    # create binary words
    bin_data = [] * 0
    for word in bin_file_data:
        pieces = [word[i:i + digits] for i in range(0, len(word), digits)]
        for binpoint in pieces:
            bin_data.append(binpoint)

    # convert binaries to complexes
    res_data_list = [] * 0 
    for i in range(0, len(bin_data) - 1, 2):
        res_data_list.append(float_from_bin(bin_data[i], decimals) + float_from_bin(bin_data[i+1], decimals)*1j)
    res_data = np.array(res_data_list, dtype=complex)

    # Correct data according to shifts
    if shifts != 0:
        for i in range(len(res_data)):
            d_real = res_data[i].real
            d_imag = res_data[i].imag
            if shifts > 0:
                d_real = d_real * (2**shifts)
                d_imag = d_imag * (2**shifts)
                res_data[i] = d_real + 1j*d_imag
            else:
                d_real = d_real / (2**(-shifts))
                d_imag = d_imag / (2**(-shifts))
                res_data[i] = d_real + 1j*d_imag

    # transform data into a 2D array
    res_data_2D = np.copy(res_data).reshape((res_data.shape[0] // 2, 2))
    # perform the reshaping of the 2D array
    res_data_2d_reshape = np.copy(res_data_2D).transpose().reshape(res_data_2D.shape[0], res_data_2D.shape[1])
    # Flatten data back to 1D array
    FPGA_out = res_data_2d_reshape.flatten()

    # read the stored FFT results
    with open(out_file, "r") as file:
        FFT_out_list = [complex(line.strip()) for line in file]
    FFT_out = np.array(FFT_out_list, dtype=complex)

    if FFT_out.shape[0] != FPGA_out.shape[0]:
        raise ValueError("Files do not contain the same number of elements")

    return np.linalg.norm(FPGA_out - FFT_out) / np.linalg.norm(FPGA_out)
    
def binfile_to_complexfile(
        bin_file: str,
        out_file: str,
        cycle_file: str,
        digits: int,
        decimals: int,
        sensor: int,
        points: int,
        dataset: int
):
    '''
    Takes as input an FPGA output txt file with binary values and the number of shifts as an integer on the last semi-line, as well as the cycle count on the last line
    Also it takes as input a csv file and there it will store the complex representation of the results
    Lastly it creates a .csv it will store the cycles it took to complete
    '''
    with open(bin_file, "r") as file:
        bin_file_data = [str(line.strip()) for line in file]

    # get the number of cycles and write it 
    cyclecount = int(bin_file_data.pop())
    csv_datum = [[sensor, points, dataset, cyclecount]]
    with open(cycle_file, mode='a', newline='') as file:
        writer = csv.writer(file)
        writer.writerows(csv_datum)
    # get the shift amount
    shifts = int(bin_file_data.pop())

    if len(bin_file_data[0]) % digits != 0:
        raise ValueError("Incompatible binary file data with specified digits")

    # create binary words
    bin_data = [] * 0
    for word in bin_file_data:
        pieces = [word[i:i + digits] for i in range(0, len(word), digits)]
        for binpoint in pieces:
            bin_data.append(binpoint)

    # convert binaries to complexes
    res_data_list = [] * 0 
    for i in range(0, len(bin_data) - 1, 2):
        res_data_list.append(float_from_bin(bin_data[i], decimals) + float_from_bin(bin_data[i+1], decimals)*1j)
    res_data = np.array(res_data_list, dtype=complex)

    # Correct data according to shifts
    if shifts != 0:
        for i in range(len(res_data)):
            d_real = res_data[i].real
            d_imag = res_data[i].imag
            if shifts > 0:
                d_real = d_real * (2**shifts)
                d_imag = d_imag * (2**shifts)
                res_data[i] = d_real + 1j*d_imag
            else:
                d_real = d_real / (2**(-shifts))
                d_imag = d_imag / (2**(-shifts))
                res_data[i] = d_real + 1j*d_imag

    # transform data into a 2D array
    res_data_2D = np.copy(res_data).reshape((res_data.shape[0] // 2, 2))
    # perform the reshaping of the 2D array
    res_data_2d_reshape = np.copy(res_data_2D).transpose().reshape(res_data_2D.shape[0], res_data_2D.shape[1])
    # Flatten data back to 1D array
    FPGA_out = res_data_2d_reshape.flatten()

    with open(out_file, "w") as file:
        for output_result in FPGA_out:
            file.write(str(output_result) + '\n')