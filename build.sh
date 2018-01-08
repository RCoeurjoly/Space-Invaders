#!/bin/sh

yosys -p "synth_ice40 -blif space_invaders_top.blif" space_invader_top.v vga.v format_vga.v ship.v edge_detector_debounce.v timer_1us.v 2>&1 | tee file.log
arachne-pnr -d 1k -p space_invader_top.pcf space_invader_top.blif -o space_invader_top.txt 2>&1 | tee -a file.log
icepack space_invader_top.txt space_invader_top.bin 2>&1 | tee -a file.log
iceprog space_invader_top.bin 2>&1 | tee -a file.log
rm space_invader_top.blif space_invader_top.bin space_invader_top.txt
