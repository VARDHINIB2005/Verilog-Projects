**3-Stage 16-bit Pipelined ALU (Verilog)**
**Project Overview**
This project implements a 3-stage pipelined 16-bit Arithmetic Logic Unit (ALU) using Verilog HDL.
The design improves performance by dividing operations into pipeline stages so that multiple instructions can be processed concurrently.

**Pipeline Architecture**

The ALU is divided into three pipeline stages:
**1. Stage 1 – Operand Fetch**
Inputs A, B, and alu_op are captured into registers.
This stage isolates external inputs from internal logic.
**2.Stage 2 – Execute**
Performs ALU operations based on alu_op.
**Supported operations:**

1.ADD
2.SUB
3.AND
4.OR
5.XOR
**2. Stage 2 – Execute**
Performs ALU operations based on alu_op.

**Supported operations:**

1.ADD
2.SUB
3.AND
4.OR
5.XOR
**Stage 3 – Write Back**
The computed result is stored in the output register result.
**ALU Operations Table
alu_op	Operation**
0000	ADD
0001	SUB
0010	AND
0011	OR
0100	XOR
**Inputs and Outputs
Inputs**
1.clk : System clock
2.reset : Active-HIGH asynchronous reset
3.A : 16-bit operand
4.B : 16-bit operand
5.alu_op : 4-bit operation selector
**Output**
6.result : 16-bit ALU output

**Testbench Description**

A Verilog testbench is included to:
Generate clock and reset signals
Apply different ALU operations
Dump waveform data into a VCD file for analysis

**Sample Test Cases**

10 + 5
20 − 3
6 & 2
8 | 1
9 ^ 4

**Simulation & Waveform**

1.Waveform file generated: pipelined_alu.vcd
2.Can be viewed using GTKWave or EPWave (EDA Playground)

**How to Run (Icarus Verilog)**
iverilog -o alu pipelined_alu.v
vvp alu
gtkwave pipelined_alu.vcd
**Key Learning Outcomes**

1.Understanding pipelined datapath design
2.Register-based stage separation
3.Writing synthesizable Verilog
4.Creating a structured testbench
5.Debugging using waveform analysis

**File Structure**
pipelined_alu.v   → ALU design + testbench
pipelined_alu.vcd → Waveform output
README.md

 **Conclusion**

This project demonstrates a basic pipelined ALU architecture, suitable for learning RTL design, pipeline concepts, and digital system design fundamentals.
