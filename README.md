# AES-128-Verification-Environment-UVM-Python-Golden-Model-
This project implements a complete UVM-based verification environment for an AES-128 encryption core, with a Python reference model integrated directly into the simulation flow.
The verification strategy leverages transaction-level stimulus, self-checking scoreboarding, and external golden model comparison to ensure functional correctness across a wide range of randomized scenarios.

**Key Features**

Full UVM testbench architecture (sequence, driver, monitor, agent, environment, scoreboard)
Support for AES-128 ECB mode
Python-based golden model using pycryptodome, invoked via $system
Deterministic file-based handshake between SystemVerilog and Python
Fixed-width hex serialization to guarantee 128-bit data integrity
Automated comparison between DUT output and reference model
Robust error handling for external process failures

**Verification Scope**

Randomized plaintext and cipher key generation
Reset and valid signaling coverage
End-to-end data integrity checking
Regression-ready and scalable structure

**Motivation**

This project demonstrates how to bridge SystemVerilog/UVM and Python models in a clean, production-style workflow, enabling reuse of high-level reference implementations while maintaining RTL-accurate verification.

<img width="1068" height="381" alt="image" src="https://github.com/user-attachments/assets/7e9d8e24-89a0-4fbb-99c9-9ebfb6fa170a" />
<img width="1897" height="456" alt="image" src="https://github.com/user-attachments/assets/f5b3c063-db6c-4496-949d-90899fe872ad" />

