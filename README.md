textclock
=========

# Introduction

textclock is a parametric 3d-printable textclock. It's currently in development.

It's designed to be used with a 60 led/m SK6812 led-strip, and an esp8266 using micropython for control. 
Using an ESP32 or any other micropython-capable board is also possible, but timer handling and pins might 
need to be changed.

The letterface is available in English and German, but can be easily adapted to other languages, as well as your
specific needs. The letters "stamped" into clock are just configuration files with text - look at the 
[english one](hardware/config_sk6812_english_minimal.scad) for a glimpse.

The configuration for most parameters is also adjustable in the [config_common.scad](hardware/config_common.scad) file. 

![rendering](doc/render.png)

# Requirements

## Parts / BOM

In the default configuration the clock requires the following parts:

### 3d printed parts

__Note: Please read the Printed parts (IMPORTANT!)" section before you print them__

- letter plate (front face of the clock, includes the letters shown and separation between them)
- led holder plate (used with fixation plate to clamp the led strips between them)
- led fixation plate (used to clamp strips & serves as mount for electronics)
- backplate/wallmount (to close the case and enable mounting it to a wall)

### hardware
- M2.5 brass threaded inserts
- M2.5 machine screws (short, maybe 6mm?)

### electronics
- ESP8266 (or ESP32) NodeMCU-style board 
- SK6812 60 LEDs/m RGBW strip
- DS1307 RTC module (I used a dual module called "Tiny RTC" that additionally includes an eeprom, and just didn't it)
- THT angled pin headers (2.54mm)
- Jumper wires (F-F, just cut them up)
- misc. cables (you can use the jumper wire remains)

Since the 3d files are written in OpenSCAD, you can modify them to your needs and available electronics or led strips.  

## Printed parts (IMPORTANT!)

- 0.15mm layer height (some parameters in `config_common.scad` need to be changed if you want to use a different height)
- 0.4mm nozzle (for more detailed letters, you could potentially use a smaller nozzle)
- Filament: __Your filament choice is crucial for success.__ It must be opaque enough to block the light at ~1mm height, 
  but let light through at 0.15mm (single layer height). You can print a smaller test print
  to determine if your filament is suitable.   

# Assembly

## Printed parts

### Install threaded inserts

### Install led strips

## Electronics

### Prepare ESP8266

First step is to solder the angled pin headers to the ESP8266 board. Please note, that you may need to remove the 
standard headers first. 

## Software

The process of installing the software is described in the [software-folders README](software/README.md)
