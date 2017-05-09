#!/bin/sh

rm -f errs.txt
rm -f main.bin

./tasm.exe main.asm -b -65 2> errs.txt
mv main.obj main.bin

if [[ -s errs.txt ]]
then
	echo  "errors occured."
	exit 1
fi


rm -f test.dsk
echo "creating a disk image"
java -jar AppleCommander-1.3.5.13-ac.jar -dos140 advent.dsk txtadv

echo "attaching file to disk image"

java -jar AppleCommander-1.3.5.13-ac.jar -p advent.dsk game.bin bin 0x800 < main.bin

./Applewin.exe -d1 ADOS3.3.dsk -d2 advent.dsk
