# Space-Invaders

Port of VHDL Space Invaders (https://github.com/David-Estevez/spaceinvaders) to Verilog for the iCE40 H1K

## Video

https://www.youtube.com/watch?v=zD_Xy7i3Ies

## TODO

1. Tone generator
2. Two players
3. Different Levels
4. Keeping score of how many invaders you have destroyed
5. Read the sprite info from a plain text file. Research how to make 32x32 pixel map from picture
6. Create extensive testbenches for all modules
7. Use SystemVerilog asserts to verify model
8. Trunk modules should only have instantiations of other modules. Leaf modules should implement the logic
9. Use Mealy FSM for sequential logic (All modules but sprite_drawer). More specifically, use two process design method (Gaisler)
10. Use homogenous naming and coding convention

# How to sinthesize & simulate

## Top Module

* Simulate top module

```
$ make sim
```

* Sinthesize top module:

```
$ make bin
```

* Upload to FPGA

```
$ make upload
```

## Submodules

* Simulate sub-module

Give your submodule is called `file.v`, and the corresponding testbench is called `file_tb.v`, you can simulate the sub-module using:

```
$ make MODULE=module sim
```
