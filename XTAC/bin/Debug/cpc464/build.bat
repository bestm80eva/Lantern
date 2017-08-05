echo off

echo Building for CPC464...

del /q main.cmd

..\bin\z80asm.exe -com main.asm

if exist main.com (
	move main.com advent.bin
	::Add g file dsk, with format PARADOS 80:
	..\bin\CPCDiskXP -File advent.bin -AddAmsdosHeader 4000 -AddToNewDsk adv464.dsk -NewDSKFormat 1

	::../bin/2cdt -r advent.cdt advent.bin as advent.bin
	echo main.cmd has been built
	 
) else (
	echo An error occured. Output file not found.
	echo check errs.txt.
)

