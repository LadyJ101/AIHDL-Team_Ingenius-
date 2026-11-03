# AIHDL-Team_Ingenius-

This repository contains the design, implementation, and optimization of the **Ingenius CRC Engine**, a medium-complexity CRC peripheral built for the **TinyQV RISC-V core**. This project was developed as part of the **Arizona AI-HDL Challenge 2026**.

## Team Ingenius
* **LadyJ101** (Abioye Oluwadamilola Joy) - Lead
* **Dmannerzz** (Adedotun Babarinlo)
* **willy264** (U-Iriamuzu)
* **Kayphrosh**

## Tech Stack & Tools
* **Hardware Description:** Verilog
* **Verification:** Python (Cocotb)
* **Synthesis & EDA:** OpenLane, Yosys
* **Scripting:** PowerShell, Tcl, Shell

## Repository Structure & Project Phases

### 📁 [DP1: Initial RTL Implementation](./DP1)
* Implemented the baseline CRC datapath and MMIO wrapper for the TinyQV RISC-V core.
* Achieved initial functional verification and synthesis.
* **Baseline Metrics:** ~50 MHz maximum frequency, 1115 cell count.

### 📁 [DP2: Performance & Area Optimization](./DP2)
* Introduced a two-stage pipeline with an intermediate register (`crc_mid`) to break the XOR/shift critical path.
* Redesigned the FSM with explicit IDLE, LOAD, SHIFT, and DONE states to improve timing margins.
* **Performance Leap:** Increased maximum frequency from ~50 MHz to ~125 MHz.
* **Area Reduction:** Reduced cell count to 988 (an 11% improvement) while achieving positive setup slack (1.35 ns).

### 📁 [DP3: Power Optimization (Partial Framework)](./DP3)
* Targeted a 12-17% reduction in dynamic power (aiming for 6.5-6.8 mW down from 7.81 mW) while maintaining the 125 MHz frequency.
* Initiated Phase 1 analysis for Clock Gating, HVt/SVt cell swapping (Multi-Vt Optimization), and XOR restructuring.
* *Note: This phase contains the setup, analysis reports, and optimization scripts, but the final power optimization execution was not fully completed.*
