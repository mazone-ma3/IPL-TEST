/* main.c*/

#include <i86.h>

int size;

int strcpy2(char __far *dst, char __far *src);

void main_c(void) {
	int i = 0;
	unsigned char __far *vram = (unsigned char far *)MK_FP(0xa000,0000L);

	char str[30];

_asm {
	mov ax, cs
	mov ds, ax
}

	strcpy2(str, "Hello,PC-9801 IPL World!");

	while(str[i] != '\0'){
		vram[i*2] = str[i];
		++i;
	}

	while(1);
}

int strcpy2(char __far *dst, char __far *src)
{
	size = 0;
	while(*src != '\0'){
		size++;
		*(dst++) = *(src++);
	}
	*dst = '\0';
	return size;
}
