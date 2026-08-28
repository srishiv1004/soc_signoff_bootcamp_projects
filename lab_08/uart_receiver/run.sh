#!/bin/bash
# Use Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall --Wno-fatal \
  uart_receiver.v uart_receiver_tb.v \
  --top uart_receiver_tb --timing --CFLAGS "-std=c++20" --trace

# Step 2: Enter the object directory
cd obj_dir || { echo "Error : obj_dir not found"; exit 1; }

# Step 3: Compile simulation binary
make -f Vuart_receiver_tb.mk Vuart_receiver_tb || { echo "Compilation failed"; exit 1; }

# Step 4: Run the simulation
./Vuart_receiver_tb || { echo "Simulation failed"; exit 1; }

# Step 5: Launch GTKWave to view the waveform
gtkwave uart_receiver_tb.vcd
