### configure wifi

#### MacOS

1. Make sure python is installed
2. [Install ampy](https://pypi.org/project/adafruit-ampy/)
3. Run `ls /dev/cu.*` 
4. Connect textclock to computer.  
5. Run `ls /dev/cu.*` again and look for the newly created device, this is a serial port to the textclock.
6. Create a file called `wifi.dat`, containing:
  ```
  SSID-Name;WifiPassword
  ```
  replace SSID-Name with your wifis SSID and WifiPassword with the password for it.
  
7. Run `ampy -d 1 -p /dev/cu.<name_of_the_device_from_step_5 upload wifi.dat`
8. Restart the clock by pressing reset, or turning it off and on again
9. Clock should now get the time through your wifi.
