#!/bin/bash
#1: Run Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall \
 adder.v counter.v top_module.v tb_top_module.v \
 --top tb_top_module --timing --CFLAGS "-std=c++20" --trace
#2: Enter the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
#3: Compile the simulation binary
make -f Vtb_top_module.mk Vtb_top_module || { echo
"Compilation failed"; exit 1; }
#4: Run the simulation
./Vtb_top_module || { echo "Simulation failed"; exit 1; }
#5: Open the waveform in GTKWave
gtkwave dump.vcd
