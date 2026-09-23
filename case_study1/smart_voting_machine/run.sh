#!/bin/bash

# Step 1: Run Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall -Wno-DECLFILENAME \
  mux_4x1.v decoder2to4.v vote_register.v vote_counter.v voting_system.v voting_system_tb.v \
  --top voting_system_tb --timing --CFLAGS "-std=c++20" --trace \
  || { echo "Verilator failed"; exit 1; }

# Step 2: Navigate to the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }

# Step 3: Compile the simulation binary
make -f Vvoting_system_tb.mk Vvoting_system_tb || { echo "Compilation failed"; exit 1; }

# Step 4: Run the simulation
./Vvoting_system_tb || { echo "Simulation failed"; exit 1; }

# Step 5: Open the waveform in GTKWave
gtkwave voting_system.vcd
