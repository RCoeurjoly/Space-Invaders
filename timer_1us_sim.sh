# Copyright (c) 2017-2018 Roland Coeurjoly
# This program is GPL Licensed. See LICENSE for the full license.

#!/bin/sh

rm timer_1us_tb.out timer_1us_tb.vcd timer_1us_tb.gtkw
iverilog timer_1us.v timer_1us_tb.v -o timer_1us_tb.out
./timer_1us_tb.out
gtkwave timer_1us_tb.vcd timer_1us_tb.gtkw &
