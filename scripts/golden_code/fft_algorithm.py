#############################################################################################
# Utility functions for integer arithmetics
#############################################################################################

import numpy as np
import fft_integers as Ints

def bit_revershal_permutation(X: np.ndarray) -> np.ndarray:
    """Given an array X, this function returns a new array with the bit-reversal permutation of X.

    Args:
        X (np.ndarray): The input array.

    Returns:
        np.ndarray: The output array with the bit-reversal permutation of X.
    """
    _X = np.copy(X)
    n = _X.shape[0]

    for i in range(n):
        j = int(bin(i + n)[:1:-1], 2) // 2
        if i < j:
            _X[i], _X[j] = _X[j], _X[i]

    return _X


def butterfly(
    x0: complex,
    x1: complex,
    w: complex
) -> tuple[complex, complex]:
    """Performs a butterfly operation.

    Args:
        x0 (complex): The first input to the butterfly operation.
        x1 (complex): The second input to the butterfly operation.
        w (complex): The twiddle factor.

    Returns:
        tuple[complex, complex]: The output of the butterfly operation.
    """
    t = x1 * w
    y0 = x0 + t
    y1 = x0 - t

    return (y0, y1)


def butterfly_pair(
    X: np.ndarray[complex],
    a0: int,
    a1: int,
    w0: complex,
    w1: complex,
    rotate: bool
) -> None:
    """Performs two butterfly operations. It is assumed that the memory arrangement stores two elements in each word (row) of X. They are separated in different columns.

    The first butterfly operation is between X[a0][0] and X[a0][1] with twiddle factor w0. The second butterfly operation is between X[a1][0] and X[a1][1] with twiddle factor w1.  

    The rotate parameter is used to exchange the second output of the first butterfly operation with the first output of the second butterfly operation.

    Args:
        X (np.ndarray[complex]): The input array.
        a0 (int): The address of the first pair of elements.
        a1 (int): The address of the second pair of elements.
        w0 (complex): The twiddle factor for the first butterfly operation.
        w1 (complex): The twiddle factor for the second butterfly operation.
        rotate (bool): Enable the echanging of betturfly operations' output.
    """
    x00 = X[a0][0]
    x01 = X[a0][1]
    (y00, y01) = butterfly(x00, x01, w0)
    x10 = X[a1][0]
    x11 = X[a1][1]
    (y10, y11) = butterfly(x10, x11, w1)
    if rotate == False:
        X[a0] = [y00, y01]
        X[a1] = [y10, y11]
    else:
        X[a0] = [y00, y10]
        X[a1] = [y01, y11]


def fft(X: np.ndarray) -> np.ndarray[complex]:
    """
    Performs the FFT algorithm for AVR3200. 

    The input array X is assumed to have a memory arrangement that stores two elements in each word (row) of X. They are separated in different columns. Also, the initial organization of the array is assumed to be the bit-reversal permutation of the sensor's data.

    The output array has the same memory arrangement as the input array (it is thought as simulating the RAM, thus we cannot modify X's dimensions).

    Args:
        X (np.ndarray): Input array. It must be a 2D array. Each row contains two elements (much like the used memory format)

    Returns:
        np.ndarray[complex]: Output array.
    """
    X = np.copy(X).astype(complex)

    n = X.shape[0] * X.shape[1]
    for i in range(0, np.log2(n).astype(int) - 1):
        j = 0
        k = 0
        w = 1
        while j <= (n / 2 - 1) - 2**i:
            butterfly_pair(X, j, j + 2**i, w, w, True)
            j = j + 1
            if k < 2**i - 1:
                k = k + 1
                w = w * np.exp(1j * np.pi / 2**i)
            else:
                j = j + 2**i
                k = 0
                w = 1
    j = 0
    w = 1
    while j <= n / 2 - 2:
        w_prime = w * np.exp(2j * np.pi / n)
        butterfly_pair(X, j, j + 1, w, w_prime, False)
        j = j + 2
        w = w_prime * np.exp(2j * np.pi / n)
    # Read data in row-major order
    return X.transpose().reshape(X.shape[0], X.shape[1])

def butterfly_pair_stages_txt(
    X: np.ndarray[complex],
    a0: int,
    a1: int,
    w0: complex,
    w1: complex,
    rotate: bool,
    file_bin: str,
    file_inputs: str,
    file_complex: str
) -> None:
    """
    Same as butterfly_pair but writes the results of the butterflies into two texts

    Args:
        X (np.ndarray[complex]): The input array.
        a0 (int): The address of the first pair of elements.
        a1 (int): The address of the second pair of elements.
        w0 (complex): The twiddle factor for the first butterfly operation.
        w1 (complex): The twiddle factor for the second butterfly operation.
        rotate (bool): Enable the echanging of betturfly operations' output.
        file_bin (str): File to write the fixed point binary values of the results
        file_inputs (str): File to write the complex inputs of the stage's butterflies
        file_complex (str): File to write the complex values of the results
    
    Returns
        None

    """
    x00 = X[a0][0]
    x01 = X[a0][1]
    x10 = X[a1][0]
    x11 = X[a1][1]
    with open(file_inputs, 'a') as file:
        file.write(f"{x00}"  + '\n')
        file.write(f"{x01}"  + '\n')
        file.write(f"{x10}"  + '\n')
        file.write(f"{x11}"  + '\n')
    (y00, y01) = butterfly(x00, x01, w0)
    (y10, y11) = butterfly(x10, x11, w1)

    with open(file_complex, 'a') as file:
        file.write(f"{y00}"  + '\n')
        file.write(f"{y01}"  + '\n')
        file.write(f"{y10}"  + '\n')
        file.write(f"{y11}"  + '\n')
    # word0 = word_creator(bin_converter(y00.real), bin_converter(y00.imag), bin_converter(y01.real), bin_converter(y01.imag))
    # word1 = word_creator(bin_converter(y10.real), bin_converter(y10.imag), bin_converter(y11.real), bin_converter(y11.imag))
    with open(file_bin, 'a') as file:
        file.write(Ints.bin_converter(y00.real, 20, 16) + " " + Ints.bin_converter(y00.imag, 20, 16)  + '\n')
        file.write(Ints.bin_converter(y01.real, 20, 16) + " " + Ints.bin_converter(y01.imag, 20, 16)  + '\n')
        file.write(Ints.bin_converter(y10.real, 20, 16) + " " + Ints.bin_converter(y10.imag, 20, 16)  + '\n')
        file.write(Ints.bin_converter(y11.real, 20, 16) + " " + Ints.bin_converter(y11.imag, 20, 16)  + '\n')

    if rotate == False:
        X[a0] = [y00, y01]
        X[a1] = [y10, y11]
    else:
        X[a0] = [y00, y10]
        X[a1] = [y01, y11]



def fft_stages_txt(
        X: np.ndarray,
        filepath: str = "D:\\Yannos\\FILES\\PROGRAMS\\DST\\FFT_implementation\\fft-avr3200\\notebooks\\datasets\\FPGA_test_files\\"
        ) -> np.ndarray[complex]:
    """
    Same as fft but it creates files where the butterfly results are stored. 

    Args:
        X (np.ndarray): Input array
        filepath (str): path where the files will be stored

    Returns:
        np.ndarray[complex]: Output array
    """

    X = np.copy(X).astype(complex)

    n = X.shape[0] * X.shape[1]
    for i in range(0, np.log2(n).astype(int) - 1):
        j = 0
        k = 0
        w = 1

        # file to write the bin values of the stage results
        file_bin_name = f"stage{i+1}_butterflies_bin.txt"
        file_bin = filepath + file_bin_name
        # file to write the complex values of the stage inputs
        file_inputs_name = f"stage{i+1}_inputs.txt"
        # file to write the complex values of the stage results
        file_inputs = filepath + file_inputs_name
        file_complex_name = f"stage{i+1}_butterflies.txt"
        file_complex = filepath + file_complex_name

        while j <= (n / 2 - 1) - 2**i:
            butterfly_pair_stages_txt(X, j, j + 2**i, w, w, True, file_bin, file_inputs, file_complex)
            j = j + 1
            if k < 2**i - 1:
                k = k + 1
                w = w * np.exp(1j * np.pi / 2**i)
            else:
                j = j + 2**i
                k = 0
                w = 1
    j = 0
    w = 1
    file_bin = filepath + f"stage{np.log2(n).astype(int)}_butterflies_bin.txt"
    file_inputs = filepath + f"stage{np.log2(n).astype(int)}_inputs.txt"
    file_complex = filepath + f"stage{np.log2(n).astype(int)}_butterflies.txt"
    while j <= n / 2 - 2:
        w_prime = w * np.exp(2j * np.pi / n)
        butterfly_pair_stages_txt(X, j, j + 1, w, w_prime, False, file_bin, file_inputs, file_complex)
        j = j + 2
        w = w_prime * np.exp(2j * np.pi / n)
    # Read data in row-major order
    return X.transpose().reshape(X.shape[0], X.shape[1])

