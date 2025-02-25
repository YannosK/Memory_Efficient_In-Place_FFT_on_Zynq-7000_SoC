import configparser
from pathlib import Path

def load_config(configfile : str):
    '''
    Load the configuration from a .ini file.

    **WARNING** : import `configparser` in your project

    Args:
        configfile (str): the name of the machine configuration file - usually it is `machine.ini`
    '''
    config_path = Path(__file__).resolve().parents[1] / configfile
    config = configparser.ConfigParser()
    config.read(config_path)
    return config
