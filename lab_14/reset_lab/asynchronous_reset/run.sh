#!/bin/bash
# Run Verilator to generate simulation files
verilator --binary -j 0 -Wall async_reset_ff.v \
async_reset_tb.v --top async_reset_tb \
--timing --CFLAGS "-std=c++20" --trace
cd obj_dir || { echo "obj_dir not found"; exit 1; }
make -f Vasync_reset_tb.mk Vasync_reset_tb || { echo
"Compilation failed"; exit 1; }
./Vasync_reset_tb || { echo "Simulation failed"; exit 1; }
gtkwave async_reset.vcd

