# SoC Signoff Bootcamp Projects

Lab work from NIELIT's **ChipCraft: RTL, IP Integration, and SoC Signoff** bootcamp, designed, simulated, and verified using entirely open-source EDA tools.

## Tools used

- **Yosys** — RTL synthesis
- **Verilator** — RTL simulation
- **Icarus Verilog** — Verilog simulation
- **GTKWave** — waveform viewing
- **Magic / KLayout** — layout editing and GDS viewing
- **Ngspice / Xschem** — analog simulation and schematic capture
- **Netgen / OpenSTA / OpenROAD / OpenLane** — LVS, static timing analysis, physical design, RTL-to-GDSII flow

Labs were built and simulated using the course's **ChipCraft Virtual Lab** environment, and cross-checked locally against **iic-osic-tools**, which bundles the same open-source toolchain.

## Repo structure

```
lab_XX/<design_name>/
├── <design>.v          # RTL source
├── <design>_tb.v        # testbench
├── run.sh                # builds with Verilator, runs the sim, opens GTKWave
└── waveform.png          # GTKWave screenshot (where applicable)
```

## Progress

Checked items have working code, testbench, and simulation results pushed to this repo. Unchecked items are upcoming.

<details>
<summary><strong>Module 01: RTL Design and IP Integration</strong> — 21 labs</summary>

- [x] Lab 1 — AND gate using Verilator ([lab_01/and_gate](./lab_01/and_gate))
- [ ] Lab 2 — 4x1 MUX using Verilator
- [ ] Lab 3 — Half Adder using Verilator
- [ ] Lab 4 — JK Flip-Flop using Verilator
- [ ] Lab 5 — Up Counter using Verilator
- [ ] Lab 6 — Down Counter using Verilator
- [x] Lab 7 — Ripple Up Counter using Verilator ([lab_07/ripple_up_counter](./lab_07/ripple_up_counter))
- [x] Lab 8 — UART Receiver, design + verification ([lab_08/uart_receiver](./lab_08/uart_receiver))
- [ ] Lab 9 — APB Bus Interface using Verilator
- [ ] Lab 10 — APB–UART Bridge, design + verification
- [ ] Lab 11 — Metastability without synchronization
- [ ] Lab 12 — Fixing metastability with a 2-stage synchronizer
- [ ] Lab 13 — Clock gating using Verilator
- [ ] Lab 14 — Reset types using Verilator
- [ ] Lab 15 — Designing simple IPs (UART, GPIO, Timer, etc.)
- [ ] Lab 16 — Integrating multiple IPs into a mini-SoC
- [ ] Lab 17 — Inserting clock/reset synchronization logic
- [ ] Lab 18 — Debugging SoC integration: detecting a real bug
- [ ] Lab 19 — Mini-SoC project using GitHub
- [ ] Lab 20 — Exploring synth vs non-synth constructs using Yosys
- [ ] Lab 21 — UPF low-power techniques

</details>

<details>
<summary><strong>Module 02: Advanced RTL Design and CDC/RDC Handling</strong> — 12 labs</summary>

- [ ] Lab 22 — Multi-stage synchronizer for stable CDC
- [ ] Lab 23 — FIFO design for asynchronous interfaces
- [ ] Lab 24 — Multi-clock domain architectures: muxes, dividers
- [ ] Lab 25 — Low-power techniques: clock gating, power gating
- [ ] Lab 26 — Hierarchical design and IP reuse strategies
- [ ] Lab 27 — Global reset vs synchronized reset
- [ ] Lab 28 — Building and verifying synchronizers and FIFOs
- [ ] Lab 29 — Clock gating implementation at RTL
- [ ] Lab 30 — Designing reset synchronization logic
- [ ] Lab 31 — Low-power Verilog coding exercises
- [ ] Lab 32 — Building a multi-clock domain subsystem
- [ ] Lab 33 — Introducing assertions for CDC checking

</details>

<details>
<summary><strong>Module 03: RTL Synthesis and Static Timing Constraints</strong> — 12 labs</summary>

- [ ] Lab 3.1.1 — Basic synthesis commands using Yosys
- [ ] Lab 3.1.2 — Design + synthesis of a 2:1 MUX
- [ ] Lab 3.2.1 — Design + synthesis of a Half Adder
- [ ] Lab 3.2.2 — Design + synthesis of a Full Adder
- [ ] Lab 3.2.3 — Design + synthesis of an 8-bit shift register
- [ ] Lab 3.7 — Common synthesis errors in Yosys
- [ ] Lab 3.8.1 — Design + synthesis of a 4-bit counter
- [ ] Lab 3.8.2 — Design + synthesis of a D flip-flop
- [ ] Lab 3.10 — Reporting commands during synthesis
- [ ] Lab 3.11 — Impact of coding style on synthesis
- [ ] Lab 3.12 — Log files and debugging synthesis errors
- [ ] Lab 3.13 — Design + synthesis of a 16-bit ALU, optimized netlist

</details>

<details>
<summary><strong>Module 04: Physical Awareness — Standard Cells, LEF/DEF, Timing, Parasitics</strong> — 13 labs</summary>

- [ ] Lab 4.1.1 — Basic commands using OpenSTA
- [ ] Lab 4.1.2 — Exploring .lib files
- [ ] Lab 4.2 — Exploring .lef files
- [ ] Lab 4.5.1 — Timing analysis of a MUX using OpenSTA
- [ ] Lab 4.5.2 — Timing analysis of a counter using OpenSTA
- [ ] Lab 4.6 — Timing analysis of a D flip-flop using OpenSTA
- [ ] Lab 4.8 — Liberty file structure: pins, logic, timing arcs
- [ ] Lab 4.9 — Cell delay and power from a Liberty file
- [ ] Lab 4.10 — Introduction to the OpenLane flow
- [ ] Lab 4.12 — Standard Parasitic Extracted Format (SPEF) file
- [ ] Lab 4.13.1 — Shift register timing using OpenSTA
- [ ] Lab 4.13.2 — Setup/hold timing reports for a GCD design
- [ ] Lab 4.13.3 — Timing reports in OpenSTA

</details>

<details>
<summary><strong>Module 05: RTL to GDSII — Synthesis to Full Physical Design</strong> — 8 labs</summary>

- [ ] Lab 5.1 — Complete RTL-to-GDSII flow demonstration
- [ ] Lab 5.2.1 — config.json used in OpenLane
- [ ] Lab 5.2.2 — Files generated by OpenLane
- [ ] Lab 5.7 — Floorplanning an SPM design in OpenLane
- [ ] Lab 5.8 — Placement of an SPM design in OpenLane
- [ ] Lab 5.9 — Clock tree synthesis of an SPM design
- [ ] Lab 5.10 — Routing of an SPM design
- [ ] Lab 5.11 — DRC and LVS checks of an SPM design

</details>

<details>
<summary><strong>Module 06: RISC-V Based SoC Subsystem with AXI Interconnect</strong> — 10 labs</summary>

- [ ] Sub-module 1 — Exploring the RISC-V ISA
- [ ] Sub-module 2 — AXI4-Lite communication protocol
- [ ] Sub-module 3 — UART communication interface, demo + verification
- [ ] Sub-module 4 — Memory-mapped UART interfacing with RISC-V
- [ ] Sub-module 5 — Integrating RISC-V processor with AXI interconnect
- [ ] Sub-module 6 — AXI4-Lite UART peripheral integration
- [ ] Sub-module 7 — Firmware development for embedded SoC applications
- [ ] Sub-module 8 — Full SoC subsystem integration + verification
- [ ] Sub-module 9 — Waveform verification using Verilog testbenches
- [ ] Sub-module 10 — RTL-to-GDSII flow for the RISC-V SoC subsystem, using OpenLane

</details>

## Running a lab

```bash
cd lab_XX/<design_name>
chmod +x run.sh
./run.sh
```

This compiles the design and testbench with Verilator, runs the simulation, and opens the resulting waveform in GTKWave.

## Course

[ChipCraft: RTL, IP Integration, and SoC Signoff](https://apps.edx.echiphub.in/learning/course/course-v1:NIELIT+RTL-BOOTCAMP-02+2026_T1/home) — NIELIT, 2026.
