# UART_TX

A UART Transmitter design I implemented in Verilog/SystemVerilog, verified with a self-checking testbench, synthesized using Synopsys Design Compiler, and hardened for manufacturing test with a full-scan DFT insertion flow.

## About the Design

The transmitter converts an 8-bit parallel data byte into a serial UART frame (start bit → data bits → optional parity bit → stop bit). It's built from four functional sub-modules controlled by a main FSM:

- **FSM** – controls the transmission sequence
- **serializer** – shifts out the data bits
- **Parity_calc** – generates the parity bit (even/odd, configurable)
- **MUX** – selects which bit drives the output line

Configuration is done through `PAR_EN` (enable/disable parity) and `PAR_TYP` (even/odd), and a `Busy` flag indicates when a transmission is in progress.

For testability, the top level also includes a **test/scan clock and reset mux** (`MUX2_1`), which lets the DFT flow drive the core FSM, serializer, and parity registers from `scan_CLK`/`scan_RST` instead of the functional `CLK`/`RST` whenever `test_mode` is asserted. This is the only structural change made to the RTL for DFT — the functional logic and behavior are untouched.

## Repository Structure

```
rtl/                        → design source files (functional + DFT scan/reset mux)
tb/                         → testbench and simulation scripts
lint_reports/               → lint check report
sim_reports/                → testbench pass/fail log
synthesis/
  scripts/                  → Design Compiler synthesis script (functional-only netlist)
  constraints/               → SDC/SDF files
  netlist/                  → gate-level netlist and .ddc
  reports/                  → area, timing, power, and synthesis log
  formality/                 → formal verification (RTL vs. functional netlist)
    fm_script.tcl
    fm.log
    reports/                 → passing/failing/aborted/unverified points
dft/
  scripts/                  → DFT-ready synthesis script (dft_script.tcl) and DFT constraints (cons.tcl)
  constraints/               → scan-aware SDC/SDF
  netlist/                  → scan-inserted gate-level netlist, .ddc, and Formality .svf
  reports/                  → area, power, timing, ports, DFT DRC, and coverage-estimate reports
  formality/                 → formal verification (RTL vs. scan-inserted netlist)
    fm_script.tcl
    fm.log
    reports/                 → passing/failing/aborted/unverified points
docs/images/                 → schematics for the functional design
docs/dft_images/             → schematics (PNG) for the scan-inserted design
```

## Schematics

**Top-level view:**

![Top level schematic](docs/images/top_level_schematic.png)

**Internal RTL view:**

![Internal RTL schematic](docs/images/internal_rtl_schematic.png)

**Scan-inserted top-level view:**

![DFT top level schematic](docs/dft_images/dft_top_level_schematic.png)

## Synthesis Summary (Functional)

Synthesized with **Synopsys Design Compiler (O-2018.06-SP1)** using the `scmetro_tsmc_cl013g_rvt` standard-cell library.

| Metric                 | Value        |
|------------------------|--------------|
| Total cell area        | 827.22 µm²   |
| Number of cells        | 81           |
| Sequential cells       | 15           |
| Combinational cells    | 62           |
| Total power            | 5.48e-04 mW  |

Full breakdown is available in [`synthesis/reports/Area.rpt`](synthesis/reports/Area.rpt) and [`synthesis/reports/power.rpt`](synthesis/reports/power.rpt).

## Design for Test (DFT)

The design was made scan-testable using **Synopsys DFT Compiler**, on top of the same RTL plus the `MUX2_1`-based scan clock/reset muxing described above.

**Test ports added at the top level:**

| Port        | Direction | Function                                               |
|-------------|-----------|---------------------------------------------------------|
| `test_mode` | in        | Selects functional (`0`) vs. test (`1`) clock/reset      |
| `scan_CLK`  | in        | Scan-mode clock, muxed onto the core clock in test mode  |
| `scan_RST`  | in        | Scan-mode reset, muxed onto the core reset in test mode  |
| `SE`        | in        | Scan enable                                              |
| `SI`        | in        | Scan chain data in                                       |
| `SO`        | out       | Scan chain data out                                      |

**Scan architecture:**

- 1 scan chain, 15 cells deep — every sequential cell in the design (`FSM` state bits, `serializer` shift register and counter, `Parity_calc`'s parity register) is a valid scan cell.
- Chain clocked by `scan_CLK` (500 ns capture, 1000 ns period).
- Functional and scan clocks are declared as a logically exclusive clock group; `test_mode` is tied off (`set_case_analysis 0`) for functional-mode timing closure.

**Post-DFT results:**

| Metric                         | Value        |
|---------------------------------|--------------|
| Total cell area                 | 994.31 µm²   |
| Number of cells                 | 92           |
| Sequential cells                | 15           |
| Combinational cells             | 71           |
| Total power                     | 8.14e-04 mW  |
| DFT DRC violations              | 0            |
| Scan cells without violations   | 15 / 15      |
| **Test coverage (estimate)**    | **98.46%**   |

Out of 714 total collapsed faults: 702 detected, 11 ATPG-untestable, 1 undetectable, 0 not-detected. This is a **strong result for an initial single-chain scan insertion** — the faults left uncovered are ATPG-untestable/undetectable nodes rather than untested-but-testable logic, so there's no low-hanging fruit left to pick up without redesigning that logic. Coverage could still be pushed closer to 100% with a dedicated, simulated ATPG pattern set (this report is DFT Compiler's built-in coverage *estimate*, not a signed-off ATPG run) or by reviewing the 11 untestable faults individually.

Full detail is available in [`dft/reports/dft_drc_post_dft.rpt`](dft/reports/dft_drc_post_dft.rpt), [`dft/reports/Area.rpt`](dft/reports/Area.rpt), and [`dft/reports/power.rpt`](dft/reports/power.rpt).

**Post-DFT formal equivalence:** the scan-inserted netlist was re-verified against the RTL (with `test_mode` and `SE` held at `0`, and `SO` excluded as a scan-only port) using Synopsys Formality — **17/17 compare points passing, 0 failing, 0 aborted, 0 unverified**. See [`dft/formality/fm_script.tcl`](dft/formality/fm_script.tcl) and [`dft/formality/reports/`](dft/formality/reports/).

## Verification

- Functional simulation with a self-checking testbench (ModelSim/QuestaSim) — see [`sim_reports/test_log.txt`](sim_reports/test_log.txt)
- Formal equivalence checking, RTL vs. functional gate-level netlist, using Synopsys Formality — **17/17 compare points passing** (see [`synthesis/formality/`](synthesis/formality/))
- Formal equivalence checking, RTL vs. scan-inserted (post-DFT) netlist, using Synopsys Formality — **17/17 compare points passing** (see [`dft/formality/`](dft/formality/))

## Tools Used

- Simulation: ModelSim/QuestaSim
- Synthesis: Synopsys Design Compiler
- DFT: Synopsys DFT Compiler
- Formal Verification: Synopsys Formality
