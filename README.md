# Approximate Computing on FPGA
---
### Carnegie Mellon University
### 18-743 Course Project
### Nikolai Lenney and Charles Li
---
### Overview
This project seeks to reduce power usage in sub-pixel interpolation through approximate computing. We will focus on the HEVC H.265 video compression protocal
and its method of sub-pixel interpolation to create more accurate motion vectors. Our goal is to simulate several different hardware implementations of
sub-pixel interpolation on an FPGA. These implimentations will be vary from completely correct to approximately correct. On FPGA we hope to find conclusive 
improvement in power usage, for solutions that reasobable losses in accuracy.

### Progress
So far we have designed our sub-pixel interpolation module architecture, implemented a working design in both python and system verilog, and developed a
python tool to visualize outputs of sub-pixel interpolation.

### Results
Based on our preliminary tests with Synopsis Design Compiler, our design could reach the maximum frequency on our board, which would be 200 MHz.
We ran analysis with DC of our design operating on an toy example (a small 16x16 grid) which gives us the following power data:
Total Dynamic Power:  1.8875 mW
Cell-Leakage Power:  63.1889 nW
These values may seem incredibly insignificant, but we believe they will become much larger with a larger example, and when running for an extended period of time.

### Files
interpolation.py - this file contains two implementation of sub-pixel interpolation written in python one is a naive implementation and the other uses a buffer. 
interpolatorBasic.sv - this file contains our system verilog implementation of our sub-pixel interpolation (which mimics the buffered python implementation)
draw_grid.py - this file reads text files with pixel data and creates a static animation to visualize pixels.
grid_assist.py - this file produces text files with grids that can be used by our sv testbench, and our visualizer

