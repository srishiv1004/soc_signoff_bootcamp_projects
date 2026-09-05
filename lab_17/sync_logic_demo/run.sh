#!/bin/bash
# Step 1: Run Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall \
 reset_sync.v cdc_sync.v top_with_sync.v sync_tb.v \
 --top sync_tb --timing --CFLAGS "-std=c++20" --trace
# Step 2: Navigate to the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
# Step 3: Compile the simulation binary
make -f Vsync_tb.mk Vsync_tb || { echo "Compilation failed";
exit 1; }
# Step 4: Run the simulation
./Vsync_tb || { echo "Simulation failed"; exit 1; }
# Step 5: Open the waveform in GTKWave
gtkwave dump.vcd
