# IPL.X makefile for X680x0 GCC (elf2x68k)

#É}ÉNÉç
CC = m68k-xelf-gcc

#CFLAGS =  -O -Wall -g
CFLAGS = -m68000 -O2 -finput-charset=utf-8 -fexec-charset=cp932

LINKOPTS = -Ttext=0x6800 -s

.SUFFIXES: .o .c
.c.o:
	$(CC) $(CFLAGS) -c $<

.SUFFIXES: .o .s
.s.o:
	m68k-xelf-as -o $*.o $*.s

#ê∂ê¨éËèá

all:disk.xdf

OBJFILES = IPL.o

disk.xdf : $(OBJFILES)
	m68k-xelf-ld -T ipl.ld -o ipl.bin ipl.o
	dd if=/dev/zero of=disk.xdf bs=1024 count=1232
	dd if=ipl.bin of=disk.xdf bs=1024 count=1 conv=notrunc

IPL.o : IPL.s
