/* X68000 Custom IPL - Hello, World! (Final perfected version) */

    .section .text
    .global _start

    /* Simple short branch over "BPB" area - just bra (not bra.l or bra.s) */
    bra     boot_start               /* 60 xx - relative branch, assembler calculates offset */

    /* Dummy OEM name: 7 chars + space (mimic real Human68k style) */
    .ascii  "MYX68K "                /* 8 bytes total */

    /* Dummy BPB fields (little-endian manual bytes, X68000 realistic values) */
    .byte   0x00, 0x04               /* Bytes per sector: 1024 */
    .byte   0x01                     /* Sectors per cluster: 1 */
    .byte   0x01, 0x00               /* Reserved sectors: 1 */
    .byte   0x02                     /* Number of FATs: 2 */
    .byte   0x70, 0x00               /* Root entries: 112 (typical for small disks) */
    .byte   0x00, 0x0C               /* Total sectors (16bit): 3072 (dummy, 0x0C00 LE) */
    .byte   0xF8                     /* Media descriptor: fixed disk-like */
    .byte   0x03, 0x00               /* Sectors per FAT: 3 */
    .byte   0x08, 0x00               /* Sectors per track: 8 (X68000!) */
    .byte   0x02, 0x00               /* Number of heads: 2 */
    .byte   0x00, 0x00, 0x00, 0x00   /* Hidden sectors: 0 */
    .byte   0x00, 0x00, 0x00, 0x00   /* Large sector count: 0 */

    /* Extended BPB */
    .byte   0x00                     /* Drive number */
    .byte   0x00                     /* Reserved */
    .byte   0x29                     /* Extended boot signature */
    .byte   0x78, 0x56, 0x34, 0x12   /* Volume ID */
    .ascii  "X68K FLOPPY"            /* Volume label (11 bytes) */
    .ascii  "FAT12   "               /* Filesystem type (8 bytes) */

    /* Pad with NOPs */
    .fill   30, 1, 0x90

boot_start:
    /* Stack setup */
    move.l  #0x00100000, %a7

_start:
    /* No screen clear needed */

    /* Cursor home (_B_LOCATE $23) */
    moveq   #0, %d1
    moveq   #0, %d2
    moveq   #0, %d3
    move.w  #0x23, %d0
    trap    #15

    /* Print message (_B_PRINT $21) */
    pea     message(%pc)
    move.l  (%sp)+, %a1
    move.w  #0x21, %d0
    trap    #15

    /* Cursor on (_B_CURON $1E) */
    move.w  #0x1E, %d0
    trap    #15

done:
    bra     done

message:
    .ascii  "Hello, World! from perfected X68000 custom IPL!\r\n\0"
