#!/bin/bash
# Step 1: Run Verilator to generate simulation files
verilator --binary -j 0 -Wall simple_timer.v simple_timer_tb.v \
--top-module simple_timer_tb --timing \
--CFLAGS "-std=c++20 -fcoroutines" --trace
# Step 2: Check if obj_dir is created and move into it
cd obj_dir || { echo "obj_dir not found"; exit 1; }
# Step 3: Compile the testbench using make
make -f Vsimple_timer_tb.mk Vsimple_timer_tb || { echo
"Compilation failed"; exit 1; }
# Step 4: Run the testbench simulation
./Vsimple_timer_tb || { echo "Simulation failed"; exit 1; }
# Step 5: View the waveform using GTKWave
gtkwave simple_timer.vcd

