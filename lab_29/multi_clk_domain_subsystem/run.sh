#!/bin/bash
# 1: Compile and build simulation with Verilator and enable tracing
verilator --binary -j 0 -Wall --Wno-fatal \
  top_multi_clk.v async_fifo.v block_a.v block_b.v multi_clk_tb.v \
  --top multi_clk_tb --timing --CFLAGS "-std=c++20" --trace

# 2: Navigate to object directory
cd obj_dir || { echo "obj_dir not found"; exit 1; }

# 3: Compile simulation binary
make -f Vmulti_clk_tb.mk Vmulti_clk_tb || { echo "Compilation failed"; exit 1; }

# 4: Run simulation
./Vmulti_clk_tb || { echo "Simulation failed"; exit 1; }

# 5: Open the waveform in GTKWave
gtkwave dump.vcd
