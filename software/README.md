## Installing micropython on the clock

### Prerequisites
1. Make sure python is installed
2. [Install esptool](https://docs.espressif.com/projects/esptool/en/latest/esp8266/index.html)
   ```
   pip3 install esptool
   ```
3. [Install ampy](https://pypi.org/project/adafruit-ampy/)
   ```
   pip3 install ampy
   ```

### Find out which port the clock is connected do

#### Windows
1. Check in Device Manager under "Ports (COM & LPT)" for the serial converter of the ESP8266 (typically CH340) 

#### MacOS
1. Run `ls /dev/cu.*`
2. Connect textclock to computer.
3. Run `ls /dev/cu.*` again and look for the newly created device, this is a serial port to the textclock.


### Installing the micropython firmware
Read [Installing micropython](http://docs.micropython.org/en/latest/esp8266/tutorial/intro.html#intro) for details

1. Download [firmware](https://micropython.org/download/esp8266/) for ESP8266 with 2MiB+ flash 
2. `esptool.py -p <PORT> erase_flash`
3. `esptool.py -p <PORT> write_flash -flash_size=detect 0 esp8266-20220117-v1.18.bin`

### Installing or updating the software

#### Windows
1. Edit `upload.bat` and set AMPY_PORT to the correct device from "Find out which port the clock is connected do"
2. Run `upload.bat`

#### MacOS/Linux
1. Edit `upload.sh` and set AMPY_PORT to the correct device from "Find out which port the clock is connected do" 
2. Run `./upload.sh` 

### configure wifi

#### MacOS

1. Create a file called `wifi.dat`, containing:
  ```
  SSID-Name;WifiPassword
  ```
  replace SSID-Name with your wifis SSID and WifiPassword with the password for it. Make sure there's only a `\n` line-ending or none at all.
2. Run `ampy -d 1 -p /dev/cu.<name_of_the_device_from_prerequisites_step_5> put wifi.dat`
3. Restart the clock by pressing reset, or turning it off and on again
4. Clock should now get the time through your wifi.
