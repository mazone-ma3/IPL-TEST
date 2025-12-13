z80asm -b -l %1.asm
dd if=/dev/zero of=msx720.dsk bs=512 count=1440
rem mkfs.msdos -f 2 -r 112 -s 2 -F 12 msx720.dsk
dd if=%1.bin of=msx720.dsk conv=notrunc
