#!/bin/bash
#1: Run Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall --Wno-fatal \
  reset_stretch.v reset_top.v reset_top_tb.v \
  --top reset_top_tb --timing --CFLAGS "-std=c++20" --trace
#2: Navigate to the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
#3: Compile the simulation binary
make -f Vreset_top_tb.mk Vreset_top_tb || { echo "Compilation failed"; exit 1; }
#4: Run the simulation
./Vreset_top_tb || { echo "Simulation failed"; exit 1; }
#5: Open the waveform in GTKWave
gtkwave reset_stretch.vcd
