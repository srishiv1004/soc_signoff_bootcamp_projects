#!/bin/bash
# Step 1: Compile RTL and Testbench using Verilator
verilator --binary -j 0 -Wall --Wno-fatal \
 cdc_sync.v cdc_sync_tb.v\
  --top cdc_sync_tb --timing --trace --CFLAGS "-std=c++20"
# Step 2: Enter build directory
cd obj_dir || { echo "Error: obj_dir not found"; exit 1; }
# Step 3: Build simulation executable
make -f Vcdc_sync_tb.mk Vcdc_sync_tb|| { echo "Error: Compilation failed"; exit 1; }
# Step 4: Run simulation
./Vcdc_sync_tb|| { echo "Error: Simulation failed"; exit 1; }
# Step 5: Open waveform
gtkwave dump.vcd
