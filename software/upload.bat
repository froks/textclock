set AMPY_PORT=COM6
set AMPY_DELAY=0.1
ampy -d 1 put boot.py
ampy -d 1 put main.py
ampy -d 1 put wifimgr.py
ampy -d 1 put clock.py
ampy -d 1 put config.py
ampy -d 1 put config_english.py
ampy -d 1 put time_funcs.py
ampy -d 1 put dst.py
ampy -d 1 put hw.py
ampy -d 1 put urtc.py
ampy -d 1 reset

