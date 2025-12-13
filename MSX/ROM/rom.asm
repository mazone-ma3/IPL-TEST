; MSX ROMカートリッジ版 Hello, World!
; 16KB ROM (ページ0: 4000h-7FFFh, ページ1: 8000h-BFFFh)
; 電源オンで自動実行されるシンプルなカートリッジ
; BIOSのCHPUTを使って文字出力

        ORG     4000H           ; ROMヘッダー開始アドレス

; ROMヘッダー (ABで識別、INITアドレスで起動)
        DB      "AB"            ; カートリッジ識別子
        DW      INIT            ; 起動アドレス (INITラベル)
        DW      0000H           ; STATEMENT (使わない)
        DW      0000H           ; DEVICE
        DW      0000H           ; TEXT (BASICプログラムなし)
        DW      0000H,0000H,0000H ; 予約

INIT:   DI                      ; 割り込み禁止
;        LD      SP,0F380H       ; スタックをワークエリア直下に (安全)
;        LD      SP,0D000H

        ; 画面クリア (BIOSのCLSルーチン)
;        CALL    00C3H           ; ENASLT (メインROMをスロット0に)
;        LD      A,0             ; プライマリスロット0を選択
;        LD      H,40H           ; ページ1 (4000h-7FFFh)
;        CALL    0024H           ; ENASLT (メインBIOSを有効に)
        CALL    006CH           ; CLS (画面クリア)

;LOOP2:
;        JR      LOOP2

        ; Hello, World! 表示
        LD      HL,MSG          ; メッセージアドレス
LOOP:   LD      A,(HL)          ; 文字取得
        OR      A               ; 0か？
        JR      Z,WAIT          ; 0なら終了
        CALL    00A2H           ; CHPUT (BIOS文字出力)
        INC     HL              ; 次文字
        JR      LOOP

WAIT:   CALL    009FH           ; CHGET (キー待ち)
        RET                     ; BASICに戻る (RETでメインROMに戻る)

MSG:    DB      "Hello, World!",13,10  ; CR/LFで改行
        DB      "MSX ROM Cartridge!",13,10
        DB      "Press any key to return BASIC...",0

; パディングで16KBに
        DS      8000H - $, 0FFH ; 残りをFFで埋める (空ROM)

;        END
