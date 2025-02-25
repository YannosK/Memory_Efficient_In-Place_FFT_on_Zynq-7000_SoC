***WARNING**: This directory is about to undergo a big refactoring. The way it was supposed to work was that every script, especially the ones that create dataset files, would find the proper directories via the [`global_constants.py`](./machine/global_constants.py) script. Now instead I will create a .ini file and I will use the built-in python `configparser` to read the values*


# Folder Structure

This directory contains python scripts that automate various processes.

- [golden_code](./golden_code/) contains the code reference of the implementation and some function for float to bfp conversion.
- [dataset_gen](./dataset_gen/) contains scripts to generate input datasets to test the rtl for the fpga.
- [machine](./machine/) contains base directories that the other scripts use.
- [vivado_batch](./vivado_batch/) has big automated batch vivado simulations for the design.
