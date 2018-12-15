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
We also made variations of our core that had different approximations implemented. Here is a list of our approximations:
- approximate mirror adders - our implementation of an approximate mirror adder
- lower-bit-or adders - add upper bits and or lower bits
- simple multiplications - rounding coefficients to the nearest power of 2
- fewer multiplications - removing multiplications with small coefficients
- approximate multiplications - our implimentation of an approximate multiplier

### Results
In the end we did not use our FPGA, so our power data comes from the Synopsis Design Compiler. Our accuracy data comes from a python scripts which determines accuracy by summing the squares of differences of all of the sub-pixels between our refer
The table below shows the power and accuracy of our implementations

| Implementaiton | Accuracy (%) | Power (uW) |
| -------------- |:------------:|:----------:|
| Baseline | 100 | 451.10 |
| Fewer Coefficients | 94.96 | 414.18 |
| Simpler Coefficients | 86.69 | 471.94 |
| Approx Multiplications | 97.74 | 294.38 |
| Approx Mirror Adder | 48.15 | 356.165 |
| Lower Bit OR Adder | 99.76 | 356.165 |

These power values may seem insignificant, but we believe this will scale up when we have many cores running in parallel. We can see in the table that the tradeoff between accuracy and power is reasonable, as we can save over 20% of our power while maintaining above 95% of our accuracy.

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

