#!/bin/sh

rm top_tb.out top_tb.vcd top_tb.gtkw
iverilog top.v clk_36MHz_generator_for_tb.v vga.v formatVGA.v ship.v edgeDetectorDebounce.v timer.v top_tb.v -o top_tb.out
./top_tb.out
gtkwave top_tb.vcd top_tb.gtkw &
rm top_tb.out top_tb.vcd top_tb.gtkw
