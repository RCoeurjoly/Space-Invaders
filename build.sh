#!/bin/sh

yosys -p "synth_ice40 -blif space_invaders_top.blif" space_invaders_top.v vga_controller.v sprite_drawer.v ship.v edge_detector_debouncer.v timer_1us.v player.v clk_36MHz_generator.v bullet.v 2>&1 | tee file.log
arachne-pnr -d 1k -p space_invaders_top.pcf space_invaders_top.blif -o space_invaders_top.txt 2>&1 | tee -a file.log
icepack space_invaders_top.txt space_invaders_top.bin 2>&1 | tee -a file.log
iceprog space_invaders_top.bin 2>&1 | tee -a file.log
rm space_invaders_top.blif space_invaders_top.bin space_invaders_top.txt
