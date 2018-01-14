# Copyright (c) 2017-2018 Roland Coeurjoly
# This program is GPL Licensed. See LICENSE for the full license.

#!/bin/sh

rm ship_tb.out bullet_tb.vcd bullet_tb.gtkw
iverilog bullet.v timer_1us.v clk_36MHz_generator_for_tb.v bullet_tb.v -o bullet_tb.out
./bullet_tb.out
gtkwave bullet_tb.vcd bullet_tb.gtkw &
