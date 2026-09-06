#!/bin/bash
# 1: Use Verilator to compile and generate simulation files
verilator --binary -j 0 -Wall --Wno-fatal \
  sync2_stage.v sync3_stage.v sync_tb.v \
  --top sync_tb --timing --CFLAGS "-std=c++20" --trace
# 2: Move to the object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }
# 3: Compile the simulation binary using make
make -f Vsync_tb.mk Vsync_tb || { echo "Compilation failed"; exit 1; }
# 4: Run the simulation and check for failure
./Vsync_tb || { echo "Simulation failed"; exit 1; }
# 5: Open the waveform in GTKWave
gtkwave dump.vcd
