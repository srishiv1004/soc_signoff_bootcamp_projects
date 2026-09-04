#!/bin/bash
# Step 1: Compile RTL and Testbench using Verilator
verilator --binary -j 0 -Wall --Wno-fatal \
  metastability.v metastability_tb.v \
  --top metastability_tb --timing --trace --CFLAGS "-std=c++20"
# Step 2: Enter build directory
cd obj_dir || { echo "Error: obj_dir not found"; exit 1; }
# Step 3: Build simulation executable
make -f Vmetastability_tb.mk Vmetastability_tb|| { echo "Error: Compilation failed"; exit 1; }
# Step 4: Run simulation
./Vmetastability_tb|| { echo "Error: Simulation failed"; exit 1; }
# Step 5: Open waveform
gtkwave dump.vcd
