**16-bit ALU in Verilog
Description**__
This project implements a 16-bit Arithmetic Logic Unit (ALU) using Verilog.
The ALU performs both arithmetic and logical operations based on a 4-bit operation select signal.

**Supported Operations
OP Code	Operation**
0000	Addition (A + B)
0001	Subtraction (A − B)
0010	AND
0011	OR
0100	XOR
0101	NOT (A)
0110	Shift Left (A <<< 1)
0111	Shift Right (A >>> 1)
1000	Increment (A + 1)
1001	Decrement (A − 1)
**Features**
1. 16-bit signed arithmetic
2.Carry flag generation
3.Overflow detection for addition and subtraction
4.Zero flag generation
5.Combinational ALU design

**Files**
1. bitalu_16bit.v → ALU design module
2.tb_16bit_alu.v → Testbench for simulation

**Simulation Details**
1. Testbench applies multiple ALU operations
2.Includes overflow test cases
3.Generates waveform file:

**bitalu_16bit.vcd**

**Tools Used**
1.Verilog HDL
2.EDA Playground (simulation)

**Author**
Vardhini B
