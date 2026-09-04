#!/bin/bash
# Step 1: Compile RTL and Testbench using Verilator
verilator --binary -j 0 -Wall --Wno-fatal \
 ff_no_gating.v ff_with_gating.v ff_tb.v\
  --top ff_tb --timing --trace --CFLAGS "-std=c++20"
# Step 2: Enter build directory
cd obj_dir || { echo "Error: obj_dir not found"; exit 1; }
# Step 3: Build simulation executable
make -f Vff_tb.mk Vff_tb|| { echo "Error: Compilation failed"; exit 1; }
# Step 4: Run simulation
./Vff_tb|| { echo "Error: Simulation failed"; exit 1; }
# Step 5: Open waveform
gtkwave dump.vcd
