OUTPUT_FORMAT(binary)
SECTIONS
{
    . = 0x00E80000;
    .text : { *(.text) }
    .data : { *(.data) }
    .rodata : { *(.rodata) }
}
