import os
import glob
import argparse
import shutil

if __name__ == "__main__":

    dirs_to_delete = ['__pycache__', '.Xil']

    parser = argparse.ArgumentParser(description="Optional argument for deleting vivado logs")
    parser.add_argument('--delete_logs', action='store_true', help='Delete logs from vivado_logs directory')
    args = parser.parse_args()

    if args.delete_logs:
        vivado_logs = './vivado_logs/'

        for log_file in glob.glob(os.path.join(vivado_logs, "*.log")):
            try:
                os.remove(log_file)  # Delete the file
            except Exception as e:
                print(f"Error deleting {log_file}: {e}")

    for ext in ('*.log', '*.jou'):
        for file in glob.glob(ext):
            try:
                os.remove(file)
            except Exception as e:
                print(f"Error deleting {file}: {e}")

    if os.path.exists('temp_script.tcl'):
        os.remove('temp_script.tcl')
    
    for dir_name in dirs_to_delete:
        if os.path.exists(dir_name):
            try:
                shutil.rmtree(dir_name)
            except Exception as e:
                print(f"Error deleting directory {dir_name}: {e}")