#!/bin/bash
# Use Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall \
 counter.v alu.v mux2x1.v mini_soc.v mini_soc_tb.v \
 --top mini_soc_tb --timing --CFLAGS "-std=c++20" --trace
# Step 2: Enter the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
# Step 3: Compile simulation binary
make -f Vmini_soc_tb.mk Vmini_soc_tb || { echo "Compilation
failed"; exit 1; }
# Step 4: Run the simulation
./Vmini_soc_tb || { echo "Simulation failed"; exit 1; }
# Step 5: Launch GTKWave to view the waveform
gtkwave dump.vcd
