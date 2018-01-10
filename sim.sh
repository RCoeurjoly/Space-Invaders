#!/bin/sh

rm top_tb.out top_tb.vcd top_tb.gtkw
iverilog space_invaders_top.v vga_controller.v sprite_drawer.v player.v ship.v bullet.v edge_detector_debouncer.v timer_1us.v top_tb.v clk_36MHz_generator_for_tb.v -o top_tb.out
./top_tb.out
gtkwave top_tb.vcd top_tb.gtkw &
