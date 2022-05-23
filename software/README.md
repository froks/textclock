### Prerequisites
1. 
2. Make sure python is installed
3. [Install ampy](https://pypi.org/project/adafruit-ampy/)
4. Run `ls /dev/cu.*`
5. Connect textclock to computer.
6. Run `ls /dev/cu.*` again and look for the newly created device, this is a serial port to the textclock.

### Updating the software

#### MacOS
1. Edit `upload.sh` and set AMPY_PORT to te device from step 5 (`/dev/cu...`) 
2. Run `upload.sh` 

### configure wifi

#### MacOS

1. Create a file called `wifi.dat`, containing:
  ```
  SSID-Name;WifiPassword
  ```
  replace SSID-Name with your wifis SSID and WifiPassword with the password for it. Make sure there's only a `\n` line-ending or none at all.
2. Run `ampy -d 1 -p /dev/cu.<name_of_the_device_from_step_5> put wifi.dat`
3. Restart the clock by pressing reset, or turning it off and on again
4. Clock should now get the time through your wifi.
