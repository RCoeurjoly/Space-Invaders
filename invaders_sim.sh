# Copyright (c) 2017-2018 Roland Coeurjoly
# This program is GPL Licensed. See LICENSE for the full license.

#!/bin/sh

iverilog invaders.v timer_1us.v clk_36MHz_generator_for_tb.v invaders_tb.v -o invaders_tb.out
./invaders_tb.out
gtkwave invaders_tb.vcd invaders_tb.gtkw
rm invaders_tb.out invaders_tb.vcd invaders_tb.gtkw
