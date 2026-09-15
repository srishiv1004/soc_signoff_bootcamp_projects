#!/bin/bash
# Step 1: Use Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall \
 counter_async.v reset_sync.v counter_sync.v tb.v \
 --top tb --timing --CFLAGS "-std=c++20" --trace
# Step 2: Enter the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
# Step 3: Compile the simulation binary
make -f Vtb.mk Vtb || { echo "Compilation failed"; exit 1; }
# Step 4: Run the simulation
./Vtb || { echo "Simulation failed"; exit 1; }
# Step 5: Launch GTKWave to view the waveform
gtkwave dump.vcd

