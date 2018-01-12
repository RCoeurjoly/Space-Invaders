# Copyright (c) 2017-2018 Roland Coeurjoly
# This program is GPL Licensed. See LICENSE for the full license.

#!/bin/sh

rm ship_tb.out ship_tb.vcd ship_tb.gtkw
iverilog ship.v ship_tb.v -o ship_tb.out
./ship_tb.out
gtkwave ship_tb.vcd ship_tb.gtkw &
