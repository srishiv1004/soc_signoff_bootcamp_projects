#!/bin/bash
verilator --binary -j 0 -Wall --Wno-fatal \
  icg_cell_model.v icg_cell_model_tb.v \
  --top icg_cell_model_tb --timing --CFLAGS "-std=c++20" --trace

cd obj_dir || { echo "obj_dir not found"; exit 1; }

make -f Vicg_cell_model_tb.mk Vicg_cell_model_tb || { echo "Compilation failed"; exit 1; }

./Vicg_cell_model_tb || { echo "Simulation failed"; exit 1; }

gtkwave icg_cell_model.vcd
