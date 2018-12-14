# Approximate Computing on FPGA

### Carnegie Mellon University
### 18-743 Course Project
### Nikolai Lenney and Charles Li
---
### Overview
This project seeks to reduce power usage in sub-pixel interpolation through approximate computing. We will focus on the HEVC H.265 video compression protocal
and its method of sub-pixel interpolation to create more accurate motion vectors. Our goal is to simulate several different hardware implementations of
sub-pixel interpolation on an FPGA. These implimentations will be vary from completely correct to approximately correct. On FPGA we hope to find conclusive 
improvement in power usage, for solutions that reasobable losses in accuracy.

### What did we build?
By the end of our project we were able to create a computation core for sub-pixel interpolation. This core loads in values from memory into a buffer, multiplies the 
values in the buffer by the appropriate coefficients, and then adds the products together. \
We also made variations of our core that had different approximations implemented. Here is a list of our approximations:\
- approximate mirror adders - our implementation of an approximate mirror adder\
- lower-bit-or adders - add upper bits and or lower bits\
- simple multiplications - rounding coefficients to the nearest power of 2\
- fewer multiplications - removing multiplications with small coefficients\
- approximate multiplications - our implimentation of an approximate multiplier\

### Results
Based on our preliminary tests with Synopsis Design Compiler, our design could reach the maximum frequency on our board, which would be 200 MHz.
We ran analysis with DC of our design operating on an toy example (a small 16x16 grid) which gives us the following power data:\
Total Dynamic Power:  ```1.8875 mW```\
Cell-Leakage Power:  ```63.1889 nW```\
These values may seem incredibly insignificant, but we believe they will become much larger with a larger example, and when running for an extended period of time.

### Files
```interpolators/interpolatorBasic.sv``` - this file contains our system verilog implementation of our correct sub-pixel interpolation (which mimics the buffered python implementation)\
```interpolators/library.sv``` - this file contains our system verilog implementations of our approximate multipliers, adders, cores, etc\
```interpolators/interpolator_super.sv``` - this file contains an interpolator core similar to the correct sub-pixel interpolator, but can be easily modified to compute approximate interpolations\

```output/``` - this directory holds the interpolation outputs of various runs of our interpolator\

```power_repor/``` - this directory holds the power data of various runs of our interpolator\

```poster/``` - this directory contains our presentation poster\

```python_scripts/interpolation.py``` - this file contains two implementation of sub-pixel interpolation written in python one is a naive implementation and the other uses a buffer\
```python_scripts/draw_grid.py``` - this file reads text files with pixel data and creates a static animation to visualize pixels\
```python_scripts/grid_assist.py``` - this file produces text files with grids that can be used by our sv testbench, and our visualizer\
```python_scripts/grade_accuracy.py``` - this file takes in a path to a reference output and a computed output and outputs a measuer of how accurate the output is\
```python_scripts/grids/``` - this directory contains all of the text files used as inputs for intepolation, as well as reference outputs\

