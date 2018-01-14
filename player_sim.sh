#!/bin/sh

iverilog player.v ship.v edgeDetectorDebounce.v timer.v bullet.v player_tb.v -o player_tb.out
./player_tb.out
gtkwave player_tb.vcd player_tb.gtkw &
rm player_tb.out player_tb.vcd player_tb.gtkw
