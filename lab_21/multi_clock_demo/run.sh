#!/bin/bash
#1: Use Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall \
 clk_mux.v clk_divider.v multi_clk_tb.v \
 --top multi_clk_tb --timing --CFLAGS "-std=c++20" --trace
#2: Move to the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
#3: Compile the simulation binary using make
make -f Vmulti_clk_tb.mk Vmulti_clk_tb || { echo "Compilation
failed"; exit 1; }
#4: Run the simulation
./Vmulti_clk_tb || { echo "Simulation failed"; exit 1; }
#5: Open the waveform in GTKWave
gtkwave dump.vcd
