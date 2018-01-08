#!/bin/sh

iverilog top.v vga.v formatVGA.v ship.v edgeDetectorDebounce.v timer.v player.v bullet.v top_tb.v -o top_tb.out
./top_tb.out
gtkwave top_tb.vcd top_tb.gtkw &
rm top_tb.out top_tb.vcd top_tb.gtkw
