# UART_TX

A UART Transmitter design I implemented in Verilog/SystemVerilog, verified with a self-checking testbench, and synthesized using Synopsys Design Compiler.

## About the Design

The transmitter converts an 8-bit parallel data byte into a serial UART frame (start bit → data bits → optional parity bit → stop bit). It's built from four sub-modules controlled by a main FSM:

- **FSM** – controls the transmission sequence
- **serializer** – shifts out the data bits
- **Parity_calc** – generates the parity bit (even/odd, configurable)
- **MUX** – selects which bit drives the output line

Configuration is done through `PAR_EN` (enable/disable parity) and `PAR_TYP` (even/odd), and a `Busy` flag indicates when a transmission is in progress.

## Repository Structure

```
rtl/            → design source files
tb/             → testbench and simulation scripts
lint_reports/   → lint check report
synthesis/      → synthesis scripts, constraints, netlist, and reports
docs/images/    → schematics generated from the synthesis tool
```

## Schematics

**Top-level view:**

![Top level schematic](docs/images/top_level_schematic.png)

**Internal RTL view:**

![Internal RTL schematic](docs/images/internal_rtl_schematic.png)

## Tools Used

- Simulation: ModelSim/QuestaSim
- Synthesis: Synopsys Design Compiler
