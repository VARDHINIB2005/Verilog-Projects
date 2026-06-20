# UART Receiver - FIFO - UART Transmitter

## Project Overview

This project implements a complete UART communication system using Verilog HDL. The design integrates a UART Receiver (RX), an 8×8 FIFO Buffer, and a UART Transmitter (TX) controlled by a Finite State Machine (FSM).

The system receives serial data through the UART RX line, stores the received bytes in a FIFO buffer, and retransmits the data through the UART TX line.


## Data Flow

UART RX → FIFO Buffer → UART TX


## Features

- UART Receiver with Start, Data and Stop Bit Detection
- UART Transmitter with Serial Data Transmission
- 8×8 Synchronous FIFO Buffer
- FIFO Full and Empty Flag Detection
- Top Controller FSM for Data Transfer Control
- End-to-End UART Communication
- Verilog HDL Implementation
- ModelSim Functional Verification


## System Block Diagram

UART Receiver → FIFO (8×8) → UART Transmitter

Data Path:

Serial Input (RX)
      ↓
UART Receiver
      ↓
FIFO Buffer
      ↓
UART Transmitter
      ↓
Serial Output (TX)


## Modules

### UART Receiver (uart_rx.v)

Functions:
- Detects Start Bit
- Samples Incoming Serial Data
- Receives 8-bit Data
- Verifies Stop Bit
- Generates rx_done Signal

### FIFO Buffer (sync_fifo.v)

Functions:
- Stores Received Data
- Supports Read and Write Operations
- Maintains FIFO Order
- Generates Full and Empty Flags

### UART Transmitter (uart_tx.v)

Functions:
- Accepts Parallel Data
- Adds Start and Stop Bits
- Transmits Data Serially
- Generates tx_done Signal

### Top Module (uart_fifo_top.v)

Functions:
- Connects RX, FIFO and TX
- Controls Data Flow
- Interfaces All Submodules

### Testbench (tb_uart_fifo_top.v)

Functions:
- Generates Clock and Reset
- Applies UART Test Data
- Verifies End-to-End Operation


## Controller FSM

States:

IDLE
↓
READ_FIFO
↓
LOAD_TX
↓
WAIT_TX
↓
IDLE

State Encoding:

| State | Code |
|--------|--------|
| IDLE | 00 |
| READ_FIFO | 01 |
| LOAD_TX | 10 |
| WAIT_TX | 11 |


## Simulation Results

The design was simulated using ModelSim.

Observed Results:

- UART Receiver successfully receives serial data.
- rx_done pulse is generated after successful reception.
- FIFO stores incoming bytes correctly.
- FIFO outputs data in First-In First-Out order.
- Controller FSM reads data from FIFO.
- UART Transmitter retransmits stored data.
- tx_done pulse is generated after transmission.
- End-to-End UART communication verified successfully.


## Sample Test Data

| Byte |
|--------|
| 0x53 |
| 0xA5 |
| 0x11 |

All bytes were successfully received, stored in FIFO and transmitted back.


## Tools Used

- Verilog HDL
- ModelSim
- Intel Quartus Prime
- GitHub


## Applications

- FPGA Serial Communication
- Embedded Systems
- Data Logging Systems
- UART-Based Communication Interfaces
- FPGA-to-PC Communication
- Digital Communication Projects

## Future Enhancements

- Configurable Baud Rate
- Larger FIFO Depth
- Parity Bit Support
- AXI Interface
- Hardware Flow Control (RTS/CTS)

## Project Files

- uart_rx.v
- uart_tx.v
- sync_fifo.v
- uart_fifo_top.v
- tb_uart_fifo_top.v
- UART_FIFO_Mini_Project_Report.pdf

## Author

**Vardhini **

Verilog HDL Mini Project


## Result

Successfully designed and verified a UART Receiver → FIFO → UART Transmitter communication system using Verilog HDL.
