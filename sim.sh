#!/bin/sh

rm top_tb.out top_tb.vcd top_tb.gtkw
iverilog top.v vgaSI.v formatVGA.v ship.v edgeDetectorDebounce.v timer.v top_tb.v -o top_tb.out
./top_tb.out
gtkwave top_tb.vcd top_tb.gtkw &

