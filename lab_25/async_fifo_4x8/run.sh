#!/bin/bash
# Step 1: Run Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall async_fifo.v async_fifo_tb.v \
 --top async_fifo_tb --timing --CFLAGS "-std=c++20" --trace
# Step 2: Navigate to the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
# Step 3: Compile the simulation binary
make -f Vasync_fifo_tb.mk Vasync_fifo_tb
# Step 4: Run the simulation
./Vasync_fifo_tb || { echo "Simulation failed"; exit 1; }
# Step 5: Open the waveform in GTKWave
gtkwave async_fifo.vcd

