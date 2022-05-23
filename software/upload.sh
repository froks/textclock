#!/bin/bash
export AMPY_PORT=/dev/ttyUSB0
export AMPY_DELAY=1

for f in wifimgr.mpy clock.mpy config.mpy config_english.mpy time_funcs.mpy dst.mpy hw.mpy urtc.mpy
do
	echo "Deleting $f"
	ampy rm $f
done

for f in main.py boot.py wifimgr.py clock.py config.py config_english.py time_funcs.py dst.py hw.py urtc.py
do
	echo "Uploading $f"
	ampy put $f
done

ampy reset
