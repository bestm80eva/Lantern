
del data 
./Z80asm.exe -com main.asm 

if NOT EXIST main.com
(
	echo "build errors occurred"
	exit /b 1
)
	
echo "main.cmd has been built"

ren main.com data 

if exist loading.scr
(
	echo "attaching load screen"
	copy sloader.tap game.tap
	copy loading.scr loading
	.\mctrd add loading game.tap
	
)
else
(
	copy loader.tap game.tap
)


.\mctrd add data game.tap 

echo "game.tap is ready."
echo "load this into an emulator and enter LOAD \"\"."  
echo "When the file has loaded, enter RUN"
