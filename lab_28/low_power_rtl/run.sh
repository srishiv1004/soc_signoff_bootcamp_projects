#!/bin/bash
# Step 1: Use Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall --Wno-fatal \
  inefficient_fsm.v optimized_fsm.v fsm_tb.v \
  --top fsm_tb --timing --CFLAGS "-std=c++20" --trace

# Step 2: Move to the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }

# Step 3: Compile the simulation binary using make
make -f Vfsm_tb.mk Vfsm_tb || { echo "Compilation failed"; exit 1; }

# Step 4: Run the simulation and check for failure
./Vfsm_tb || { echo "Simulation failed"; exit 1; }

# Step 5: Open the waveform in GTKWave
gtkwave dump.vcd
