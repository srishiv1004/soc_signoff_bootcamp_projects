#!/bin/bash
#1 Use Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall --Wno-fatal \
  counter_baseline.v counter_clk_gate.v counter_pwr_gate.v low_power_tb.v \
  --top low_power_tb --timing --CFLAGS "-std=c++20" --trace
#2: Enter the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
#3: Compile simulation binary
make -f Vlow_power_tb.mk Vlow_power_tb || { echo "Compilation failed"; exit 1; }
#4: Run the simulation
./Vlow_power_tb || { echo "Simulation failed"; exit 1; }
#5: Launch GTKWave to view the waveform
gtkwave dump.vcd
