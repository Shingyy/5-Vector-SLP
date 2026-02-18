# 5-Vector Pipelined Single Layer Perceptron (ReLU) – Basys3 FPGA

## Overview

This project implements a 5-input Single Layer Perceptron (SLP) with ReLU activation in VHDL and deploys it on the Basys3 FPGA using Vivado Design Suite.

The design integrates:
- A parallel dot-product MAC
- Bias addition
- ReLU activation  
- 2-stage pipelining for timing optimization

The goal is to demonstrate efficient fixed-point neural network acceleration on FPGA while meeting 100 MHz timing constraints.

---

## Architecture

### 1. Parallel Dot Product MAC
- Computes the dot product between 5-element input and weight vectors.
- Uses signed fixed-point Q4.4 format.
- Core computational block of the perceptron.

### 2. Bias Adder
- Adds bias term to the MAC output.

### 3. ReLU Activation
- Implements: f(x) = max(0, x)
- Output represented in **Q8.8 fixed-point format**.

---

## Pipelining

To improve timing performance, a **2-stage pipeline** was introduced:
- Reduces critical path delay
- Increases maximum achievable frequency
- Introduces a latency of 2 clock cycles

---

## Timing Results (Post-Implementation)

| Parameter | Value |
|------------|--------|
| Clock Constraint | 100 MHz (10 ns) |
| Worst Negative Slack (WNS) | 1.933 ns |
| Critical Path Delay | 8.067 ns |
| Fmax | 123.96 MHz |
| Pipeline Depth | 2 stages |
| Latency | 2 clock cycles (20 ns) |

The design meets timing requirements for 100 MHz operation.

---

## Simulation

- Multiple test vectors applied
- Output observed after 2 clock cycles (pipeline latency)
- Results match expected numerical calculations
- Functional correctness verified in simulation

---

## Technical Concepts

- FPGA-based neural network acceleration
- Fixed-point arithmetic (Q4.4, Q8.8)
- Pipelined digital design
- Static Timing Analysis (STA)
- Register-to-register timing optimization

---

## Tools & Hardware

- VHDL
- Vivado Design Suite
- Basys3 FPGA (Artix-7)

---

## Future Improvements

- Parameterized vector size
- Multi-layer extension (MLP)
- Resource utilization optimization
- AXI/stream interface integration
- Integration with embedded processor


