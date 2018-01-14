# Copyright (c) 2017-2018 Roland Coeurjoly
# This program is GPL Licensed. See LICENSE for the full license.

#!/bin/sh

iverilog space_invaders_top.v clk_36MHz_generator_for_tb.v vga_controller.v sprite_drawer.v player.v ship.v bullet.v edge_detector_debouncer.v timer_1us.v space_invaders_top_tb.v -o space_invaders_top_tb.out
./space_invaders_top_tb.out
gtkwave space_invaders_top_tb.vcd space_invaders_top_tb.gtkw
rm space_invaders_top_tb.out space_invaders_top_tb.vcd space_invaders_top_tb.gtkw
