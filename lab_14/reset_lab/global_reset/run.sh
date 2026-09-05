#!/bin/bash
# Run Verilator to generate simulation files
verilator --binary -j 0 -Wall global_reset.v \
global_reset_tb.v --top global_reset_tb \
--timing --CFLAGS "-std=c++20" --trace
# Navigate into the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
# Compile the testbench
make -f Vglobal_reset_tb.mk Vglobal_reset_tb || { echo
"Compilation failed"; exit 1; }
# Run the simulation
./Vglobal_reset_tb || { echo "Simulation failed"; exit 1; }
# Open the waveform in GTKWave
gtkwave global_reset.vcd
