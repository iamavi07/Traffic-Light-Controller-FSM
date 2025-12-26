# 🚦 Traffic Light Controller Using FSM (Verilog HDL)

## Overview
This project presents the design and simulation of a **Finite State Machine (FSM)–based Traffic Light Controller** implemented using **Verilog HDL**. The controller manages a **two-way road intersection** consisting of **North–South (NS)** and **East–West (EW)** traffic flows, along with a **pedestrian crossing mechanism**.

The design follows a **synchronous Moore FSM architecture**, where all state transitions occur on the rising edge of the clock. A counter-based timing mechanism is used to control the duration of each traffic phase. The functionality of the controller is verified through **ModelSim simulation**, ensuring correct sequencing and safe traffic operation.

This project focuses on building a strong understanding of **FSM design**, **sequential logic**, and **RTL coding practices**, which are fundamental concepts in **digital system design and VLSI frontend development**.

---

## Project Objectives
- Design a traffic light controller using **FSM methodology**
- Control a **two-way intersection** with proper signal coordination
- Implement **pedestrian request handling**
- Use **parameterized timing** for traffic phases
- Ensure **safe, collision-free operation**
- Verify the design using **ModelSim simulation**

---

## System Specifications

| Feature | Description |
|------|------------|
| Controller Type | Moore FSM |
| Roads Controlled | North–South, East–West |
| Pedestrian Support | Yes |
| FSM States | 5 |
| Timing Control | Counter-based, parameterized |
| Reset | Active-high |
| Clock Edge | Rising edge |
| Design Style | Synchronous |

---

## FSM States

| State | Description |
|----|-------------|
| NS_GREEN | North–South traffic is allowed |
| NS_YELLOW | Warning phase for NS traffic |
| EW_GREEN | East–West traffic is allowed |
| EW_YELLOW | Warning phase for EW traffic |
| PED | Pedestrian crossing phase |

Only **one state is active at a time**, ensuring deterministic and safe traffic behavior.

---

## Traffic Control Logic

The controller follows a fixed and well-defined sequence:

- **NS Green → NS Yellow → EW Green → EW Yellow**
- A **pedestrian phase** is inserted only when a pedestrian request is detected
- After the pedestrian phase, the controller resumes normal traffic operation

### Safety Conditions
- NS and EW green signals are **never active simultaneously**
- Pedestrian crossing is enabled **only when both NS and EW signals are red**
- Yellow states provide safe transition intervals between green and red phases

---

## Design Architecture

The FSM is implemented using a structured RTL approach consisting of three major blocks:

1. **State Register**
   - Stores the current FSM state
   - Updated synchronously on the clock edge

2. **Next-State Logic**
   - Determines the next state based on:
     - Current state
     - Elapsed time
     - Pedestrian request

3. **State Transition Counter**
   - Measures the duration of each state
   - Enables time-controlled transitions

This separation improves clarity, maintainability, and scalability of the design.

---

## Timing Control

The duration of each traffic phase is controlled using **parameters**, allowing easy modification of:
- Green time
- Yellow time
- Pedestrian crossing time

This approach avoids hard-coded delays and improves design flexibility.

---

## Verification and Simulation

- A dedicated **testbench** is used to validate:
  - Correct FSM state transitions
  - Proper pedestrian request handling
  - Accurate timing behavior
  - Correct reset operation
- Simulation is performed using **ModelSim**
- Waveforms confirm that:
  - State changes occur only on clock edges
  - No unsafe traffic conditions are generated

---

## Tools and Technologies
- **Verilog HDL**
- **ModelSim (Intel FPGA Starter Edition)**
- FSM-based RTL Design
- Digital Logic Design and Verification

---

## Notes
- The design is **fully synthesizable** and suitable for FPGA implementation.
- A synchronous design methodology is followed to ensure predictable timing behavior.
- The project can be extended to include:
  - Multi-way intersections
  - Traffic density–based control
  - Sensor-based adaptive systems

---

## Author
**Avinash Tanti**
