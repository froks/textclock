#!/bin/bash
export AMPY_PORT=/dev/ttyUSB0
export MPY_CROSS=../../micropython/mpy-cross/mpy-cross
for f in *.py 
do
	echo "Cross-Compiling - $f"
	$MPY_CROSS $f
done

for f in main.py boot.py wifimgr.mpy clock.mpy config.mpy time_funcs.mpy dst.mpy hw.mpy urtc.mpy
do
	echo "Uploading $f"
	ampy put $f
done
ampy reset
rm *.mpy