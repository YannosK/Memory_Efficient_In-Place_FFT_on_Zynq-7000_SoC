import subprocess
import re
import csv

def edit_makefile(sensor, samples, dataset):
    with open("Makefile", "r") as file:
        makefile_data = file.read()
    
    # Update the sensor, samples, and dataset values in the Makefile using regex
    makefile_data = re.sub(r'MY_RESOURCE_1 = ../dataset_create/input_files/\d+_bits/\d+_samples/\d+.raw',
                           f'MY_RESOURCE_1 = ../dataset_create/input_files/{sensor}_bits/{samples}_samples/{dataset}.raw',
                           makefile_data)

    makefile_data = re.sub(r'MY_RESOURCE_2 = ../dataset_create/twiddle_files/\d+.raw',
                           f'MY_RESOURCE_2 = ../dataset_create/twiddle_files/{samples}.raw',
                           makefile_data)
    
    with open("Makefile", "w") as file:
        file.write(makefile_data)

def edit_lib_fixed8(samples):
    with open("leon/lib_fixed8.h", "r") as file:
        lib_fixed8_data = file.read()

    lib_fixed8_data = re.sub(r'#define NUMBER_OF_SAMPLES \d+',
                             f'#define NUMBER_OF_SAMPLES {samples}',
                             lib_fixed8_data)

    with open("leon/lib_fixed8.h", "w") as file:
        file.write(lib_fixed8_data)

def edit_shaveMain(samples):
    with open("shave/shaveMain.h", "r") as file:
        edit_shaveMain_data = file.read()

    edit_shaveMain_data = re.sub(r'#define NUMBER_OF_SAMPLES \d+',
                             f'#define NUMBER_OF_SAMPLES {samples}',
                             edit_shaveMain_data)

    with open("shave/shaveMain.h", "w") as file:
        file.write(edit_shaveMain_data)


def run_make_commands():
    # Clean and build the project
    subprocess.run(["make", "clean"], check=True)
    subprocess.run(["make", "all"], check=True)

def run_make_run_and_capture_output():
    result = subprocess.run(["make", "run"], capture_output=True, text=True)
    output = result.stdout
    
    # Extract the execution time using regex
    match = re.search(r"PIPE:LOS: SHAVE execution time: (\d+)", output)
    if match:
        return int(match.group(1))
    else:
        return None

def main():
    sensors = [7]
    
    # Open CSV in append mode and write the header
    with open("execution_times.csv", "a", newline="") as csvfile:
        csvwriter = csv.writer(csvfile)
        csvwriter.writerow(["Sensor", "Samples", "Average Execution Time"])

        for sensor in sensors:
            samples = 4
            # samples = 16384
            # for i in range(1):
            for i in range(13):
                samples *= 2
                execution_times = []
                for dataset in range(10):
                    # Step 1: Edit the Makefile and source files
                    edit_makefile(sensor, samples, dataset)
                    edit_lib_fixed8(samples)
                    edit_shaveMain(samples)
                    
                    # Step 2: Build the project
                    run_make_commands()
                    
                    # Step 3: Run the project and capture the execution time
                    execution_time = run_make_run_and_capture_output()
                    if execution_time is not None:
                        execution_times.append(execution_time)
                    
                    print(f"\nExcution times for {samples} input samples so far:\n", execution_times)
                
                # Step 4: Compute the average execution time
                if execution_times:
                    print("in")
                    average_time = sum(execution_times) / len(execution_times)
                    result = [sensor, samples, average_time]
                    
                    # Print progress to the console
                    print(f"\n\nSensor: {sensor}, Samples: {samples}, Average Execution Time: {average_time}\n\n")
                    
                    # Step 5: Write the result incrementally to the CSV file
                    csvwriter.writerow(result)


    # sensors = [7, 16, 32]
    # results = []
    
    # for sensor in sensors:
    #     samples = 4
    #     for i in range(13):
    #         samples *= 2
    #         execution_times = []
    #         for dataset in range(10):
    #             # Step 1: Edit the Makefile
    #             edit_makefile(sensor, samples, dataset)
    #             edit_lib_fixed8(samples)
    #             edit_shaveMain(samples)
                
    #             # Step 2: Build the project
    #             run_make_commands()
                
    #             # Step 3: Run the project and capture the execution time
    #             execution_time = run_make_run_and_capture_output()
    #             # print("ssensor: ", sensor)
    #             # print("samples: ", samples)
    #             # print("dataset: ", dataset)
    #             # print("execution time: ", execution_time)
    #             if execution_time is not None:
    #                 execution_times.append(execution_time)
            
    #         # Step 4: Compute the average execution time
    #         if execution_times:
    #             average_time = sum(execution_times) / len(execution_times)
    #             results.append([sensor, samples, average_time])
    
    # # Step 5: Write the results to a CSV file
    # with open("execution_times.csv", "w", newline="") as csvfile:
    #     csvwriter = csv.writer(csvfile)
    #     csvwriter.writerow(["Sensor", "Samples", "Average Execution Time"])
    #     csvwriter.writerows(results)

if __name__ == "__main__":
    main()