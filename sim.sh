#!/bin/sh

<<<<<<< HEAD
rm top_tb.out top_tb.vcd top_tb.gtkw
iverilog top.v clk_36MHz_generator_for_tb.v vgaSI.v formatVGA.v ship.v edgeDetectorDebounce.v timer.v top_tb.v -o top_tb.out
=======
iverilog top.v vga.v formatVGA.v ship.v edgeDetectorDebounce.v timer.v player.v bullet.v top_tb.v -o top_tb.out
>>>>>>> ad81eb64e23fd2fc7e54f1ed6598670d1516c94e
./top_tb.out
gtkwave top_tb.vcd top_tb.gtkw &
rm top_tb.out top_tb.vcd top_tb.gtkw
