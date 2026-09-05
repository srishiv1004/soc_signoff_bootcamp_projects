#!/bin/bash
# Run Verilator to generate simulation files
verilator --binary -j 0 -Wall sync_reset_ff.v \
sync_reset_tb.v --top sync_reset_tb \
--timing --CFLAGS "-std=c++20" --trace
# Navigate into the build directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
# Compile the testbench
make -f Vsync_reset_tb.mk Vsync_reset_tb || { echo "Compilation
failed"; exit 1; }
# Run the simulation
./Vsync_reset_tb || { echo "Simulation failed"; exit 1; }
# Open the waveform in GTKWave
gtkwave sync_reset.vcd
