#!/bin/sh

<<<<<<< HEAD
rm top.blif top.bin top.txt
yosys -p "synth_ice40 -blif top.blif" top.v clk_36MHz_generator.v vgaSI.v formatVGA.v ship.v edgeDetectorDebounce.v timer.v 2>&1 | tee file.log
=======
yosys -p "synth_ice40 -blif top.blif" top.v vga.v formatVGA.v ship.v edgeDetectorDebounce.v timer.v player.v bullet.v 2>&1 | tee file.log
>>>>>>> ad81eb64e23fd2fc7e54f1ed6598670d1516c94e
arachne-pnr -d 1k -p vga.pcf top.blif -o top.txt 2>&1 | tee -a file.log
icepack top.txt top.bin 2>&1 | tee -a file.log
iceprog top.bin 2>&1 | tee -a file.log
rm top.blif top.bin top.txt
