
echo "building C64 version"

if EXIST advent.d64 (
   del advent.64
)

echo "assembling..."
.\tasm -65 -b -c -s main.asm advent.prg

copy blank.d64 advent.d64
 
echo "attaching program to disk image..."
.\c1541 -attach advent.d64 -write advent.prg advent

echo "Program is ready to run"
echo "Reminder:"
echo "LOAD \"$\",8 loads the directory" 
echo "THE * key is the  ] key"
