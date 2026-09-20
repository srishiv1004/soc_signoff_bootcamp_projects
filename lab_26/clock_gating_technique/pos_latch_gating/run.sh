#!/bin/bash
verilator --binary -j 0 -Wall --Wno-fatal \
  pos_edge_gating.v pos_edge_gating_tb.v \
  --top pos_edge_gating_tb --timing --CFLAGS "-std=c++20" --trace

cd obj_dir || { echo "obj_dir not found"; exit 1; }

make -f Vpos_edge_gating_tb.mk Vpos_edge_gating_tb || { echo "Compilation failed"; exit 1; }

./Vpos_edge_gating_tb || { echo "Simulation failed"; exit 1; }

gtkwave pos_edge_gating.vcd
