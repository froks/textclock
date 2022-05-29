@ECHO OFF
SET OPENSCAD="%PROGRAMFILES%\OpenSCAD\openscad.exe"
SET OUTPUT_DIRECTORY=%~dp0stl

RD /Q /S %OUTPUT_DIRECTORY%

IF NOT EXIST "%OUTPUT_DIRECTORY%" ( MKDIR %OUTPUT_DIRECTORY% )

ECHO Creating STLs
FOR %%x IN (led_fixation_plate led_holder_plate backplate_wall letter_plate) DO (
	ECHO - %%x.stl
	%OPENSCAD% -o %OUTPUT_DIRECTORY%\%%x.stl %%x.scad
)
