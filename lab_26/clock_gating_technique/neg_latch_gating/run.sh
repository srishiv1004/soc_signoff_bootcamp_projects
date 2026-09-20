#!/bin/bash
verilator --binary -j 0 -Wall --Wno-fatal \
  neg_latch_gating.v neg_latch_gating_tb.v \
  --top neg_latch_gating_tb --timing --CFLAGS "-std=c++20" --trace

cd obj_dir || { echo "obj_dir not found"; exit 1; }

make -f Vneg_latch_gating_tb.mk Vneg_latch_gating_tb || { echo "Compilation failed"; exit 1; }

./Vneg_latch_gating_tb || { echo "Simulation failed"; exit 1; }

gtkwave neg_latch_gating.vcd
