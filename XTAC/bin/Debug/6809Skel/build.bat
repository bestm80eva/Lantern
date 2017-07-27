del /q errs.txt
del /q game.bin

echo Assembling...
..\bin\lwasm main.asm --6809 --list=game.list --output=game.bin 2> errs.txt

echo "files assembled"

FOR %%A IN ("errs.txt") DO SET size=%%~zA

if %size% gtr 0
(
   echo "Errors occured."
   echo "Halting."
)
else
(
   echo "Attaching file to disk image"
   .\writecocofile advent.dsk game.bin 2>> errs.txt
   
   for %%A in ("errs.txt") do set size=%%~zA
   if %size% gtr 0
   (
        echo "Unable to attach .bin file to disk image.  Is it open in an emulator?"
   )
   else 
   (
		echo "done"
	)
)