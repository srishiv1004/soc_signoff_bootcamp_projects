#!/bin/bash
# Use Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall -Wno-fatal\
 apb_timer.v apb_timer_tb.v \
 --top apb_timer_tb --timing --CFLAGS "-std=c++20" --trace
# Step 2: Enter the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
# Step 3: Compile simulation binary
make -f Vapb_timer_tb.mk Vapb_timer_tb || { echo "Compilation
failed"; exit 1; }
# Step 4: Run the simulation
./Vapb_timer_tb || { echo "Simulation failed"; exit 1; }
# Step 5: Launch GTKWave to view the waveform
gtkwave apb_timer.vcd
