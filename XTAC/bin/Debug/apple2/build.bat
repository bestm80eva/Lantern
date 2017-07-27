echo "This script requires java and AppleCommander-1.3.5.13-ac"
del errs.txt
del main.bin

tasm.exe main.asm -b -65 2> errs.txt

ren main.obj main.bin


FOR %%A IN ("errs.txt") DO set size=%%~zA
IF %size%  GTR 0 (
	echo  "errors occured."
	exit 1
)


echo "creating a disk image"
#java -jar AppleCommander-1.3.5.13-ac.jar -pro140 advent.dsk txtadv
cp PRODOS.dsk advent.dsk

echo "attaching file to disk image"

java -jar AppleCommander-1.3.5.13-ac.jar -p advent.dsk game.bin bin 0x800 < main.bin

copy advent.dsk "/cygdrive/c/Users/Evan/Documents/Apple2/ADTPro-2.0.2/disks"

.\Applewin.exe -d1 advent.dsk -d2 PRODOS.dsk

:filesize
	set size=%~z1
	exit /b 0


