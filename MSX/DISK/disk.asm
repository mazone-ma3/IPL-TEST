        ORG     0C000H                  ; Disk BIOSがロードするアドレス

        DB      0EBH, 3CH, 90H          ; jmp short +60, nop (8086ダミー)

        DB      "MSXDOS  "              ; OEM Name

        ; --- BPB (720KB 3.5" 2DD FAT12 標準) ---
        DW      512                     ; バイト/セクタ
        DB      2                       ; セクタ/クラスタ
        DW      1                       ; 予約セクタ (ブートのみ)
        DB      2                       ; FAT数
        DW      112                     ; ルートエントリ数
        DW      1440                    ; 総セクタ数 (小)
        DB      0F9H                    ; メディア記述子 (720KB)
        DW      3                       ; FATセクタ数
        DW      9                       ; トラック/セクタ
        DW      2                       ; ヘッド数
        DW      0,0                     ; 隠しセクタ
        DW      0,0                     ; 大総セクタ (0)

BOOT_START:
        JR      NC,FIRST_CALL   ; 1回目（CY reset）
; 2回目処理（MSXDOS.SYSロードとか）
        RET

FIRST_CALL:
;        LD      SP,0F380H               ; スタック

        ; 画面クリア
        LD      C,02H
        LD      E,0CH                   ; Form Feed
        CALL    0F37DH

        ; メッセージ表示
        LD      HL,MSG
LOOP:   LD      A,(HL)
        OR      A
        JR      Z,WAIT_KEY
        PUSH    HL
        LD      E,A
        LD      C,02H
        CALL    0F37DH
        POP     HL
        INC     HL
        JR      LOOP

WAIT_KEY:
        LD      HL,PRESS_MSG
PRESS_LOOP:
        LD      A,(HL)
        OR      A
        JR      Z,KEY_WAIT
        PUSH    HL
        LD      E,A
        LD      C,02H
        CALL    0F37DH
        POP     HL
        INC     HL
        JR      PRESS_LOOP

KEY_WAIT:
        LD      C,01H                   ; _CONIN
        CALL    0F37DH                  ; キー待ち
        RET                             ; Disk BASICへ

MSG:
        DB      "Custom MSX Boot Sector",13,10
        DB      "BPB + BDOS 0F37DH Complete!",13,10,13,10,0

PRESS_MSG:
        DB      "Press any key to continue...",13,10,0

        ; 512バイト境界で終わるように（残り0埋めはアセンブラ次第）
