**Synchronous FIFO (8×32) – Verilog
 Project Overview**
This project implements a Synchronous FIFO (First-In First-Out) memory with depth = 8 and data width = 32 bits using Verilog HDL.
All read and write operations are synchronized to a single clock.

**FIFO Specifications**

1.FIFO Type: Synchronous
2.Depth: 8 entries
3.Data Width: 32 bits
4.Clock: Single clock for read & write

**FIFO Ports
Inputs**

1.clk : System clock
2.reset : Active-HIGH synchronous reset
3.wr_en : Write enable
4.rd_en : Read enable
5.din : 32-bit data input

**Outputs**

1.dout : 32-bit data output
2.full : FIFO full flag
3.empty : FIFO empty flag

**Internal Architecture**

1.8×32 memory array
2.Write pointer
3.Read pointer
4.FIFO count logic

**Full and Empty flag generation**

 **FIFO Operation**

1.Write occurs when wr_en = 1 and full = 0
2.Read occurs when rd_en = 1 and empty = 0
3.Data is read in the same order it is written (FIFO rule)

**Testbench Description**

1.The testbench verifies:
2.FIFO reset behavior
3.Write operation until FIFO becomes full
4.Read operation until FIFO becomes empty
5.Full and Empty flag functionality

 **Simulation & Waveform**

1.Waveform file generated: sync_fifo.vcd
2.Can be viewed using GTKWave or EPWave

**How to Run Simulation**
iverilog -o fifo sync_fifo.v tb_sync_fifo.v
vvp fifo
gtkwave sync_fifo.vcd

 **Key Learning Outcomes**

Understanding FIFO memory structures

Read/Write pointer logic

Full and Empty flag generation

Synchronous digital design concepts

Writing and verifying Verilog RTL

File Structure
sync_fifo.v
tb_sync_fifo.v
sync_fifo.vcd
README.md

**Conclusiom**
This project demonstrates the design and verification of a basic synchronous FIFO, which is a fundamental building block in VLSI and digital system design.
