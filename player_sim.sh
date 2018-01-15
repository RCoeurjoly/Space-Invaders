# Copyright (c) 2017-2018 Roland Coeurjoly
# This program is GPL Licensed. See LICENSE for the full license.

#!/bin/sh

iverilog player.v ship.v edgeDetectorDebounce.v timer.v bullet.v player_tb.v -o player_tb.out
./player_tb.out
gtkwave player_tb.vcd player_tb.gtkw &
rm player_tb.out player_tb.vcd player_tb.gtkw
