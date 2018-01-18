# Space-Invaders

Port of VHDL Space Invaders (https://github.com/David-Estevez/spaceinvaders) to Verilog for the iCE40 H1K

## TODO

1. Tone generator
2. Create makefile to handle synthesis and simulation for all submodules
3. Two players
4. Different Levels
5. Keeping score of how many invaders you have destroyed
6. Read the sprite info from a plain text file. Research how to make 32x32 pixel map from picture
7. Create extensive testbenches for all modules
8. Use SystemVerilog asserts to verify model
9. Trunk modules should only have instantiations of other modules. Leaf modules should implement the logic
10. Use Mealy FSM for sequential logic (All modules but sprite_drawer). More specifically, use two process design method (Gaisler)
11. Use homogenous naming and coding convention