__2×2 Matrix Multiplication in Verilog
Description__
This project implements a 2×2 matrix multiplication unit using Verilog.
The design multiplies two signed 8-bit matrices and produces a signed 16-bit result matrix.
The computation is controlled using a start signal and produces a done signal when the operation is complete.

**Matrix Operation**

**For matrices:**

A = | a00  a01 |
    | a10  a11 |

B = | b00  b01 |
    | b10  b11 |
**Output matrix:**

C = A × B
Where:

C[i][j] = Σ ( A[i][k] × B[k][j] )

**Features**

1.2×2 matrix multiplication
2.Signed 8-bit inputs
3.Signed 16-bit outputs
4.Start and done control signals
5.Synchronous design using clock and reset

**Module Interface
Inputs**

1.clk → Clock signal
2.rst → Reset signal
3.start → Begins multiplication
4.A[2][2] → Input matrix A (8-bit signed)
5.B[2][2] → Input matrix B (8-bit signed)

**Outputs**

6.C[2][2] → Result matrix (16-bit signed)
7.done → Indicates completion

**Files**

8.matrix_mul_2x2.v → Matrix multiplication design
9.tb_matrix_mul_2x2.v → Testbench for simulation

**Simulation Details**
**The testbench**
10.Applies reset
11.Loads matrix values
12.Triggers the start signal
13.Displays output matrix values
14.Generates waveform file:

**matrix_mul.vcd**
**Example input:**

A = |1  2|
    |3  4|

B = |5  6|
    |7  8|


**Expected output:**

C = |19 22|
    |43 50|

**Tools Used**

1.Verilog HDL
2.EDA Playground for simulation

**Author**
Vardhini B
