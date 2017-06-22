#!/bin/sh

rm data 
./Z80asm.exe -com main.asm

if [ ! -e "main.com" ]
then
	echo "build errors occurred"
	exit 1
fi
	
	echo "main.cmd has been built"

mv main.com data 
cp loader.tap game.tap
./mctrd add data game.tap 

echo "game.tap is ready."
echo "load this into an emulator and enter LOAD \"\"."  
echo "When the file has loaded, enter RUN"
