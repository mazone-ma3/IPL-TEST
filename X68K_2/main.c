/* main.c */
void main() {
    /* IOCS _B_PUTMES ($22) を呼び出すためのインラインアセンブラ */
    /* 文字列の最後は 0x00 */
    const char *msg = "\r\nHello, IPL World!\r\n";
    

//	for(;;);

__asm__ __volatile__ (
        "move.l %0, %%a1\n\t"
        "move.w #0x21, %%d0\n\t"
        "trap #15\n\t"
        : 
        : "g"(msg)
        : "d0", "a1"
    );

    /* 終了するとどこへ帰るか不明なので無限ループ */
    while(1);
}