@echo # アセンブル
m68k-xelf-gcc -c crt0.s -o crt0.o
@echo # コンパイル
m68k-xelf-gcc -c main.c -m68000 -O2 -fomit-frame-pointer -o main.o
@echo # 結合（フラットバイナリ生成）
m68k-xelf-ld -T link.ld crt0.o main.o -o main.bin
@echo # IPLローダーのビルド (フラットバイナリとして出力)
m68k-xelf-gcc -c boot_sector.s -o boot_sector.o
m68k-xelf-ld -Ttext=0x00E80000 --oformat binary boot_sector.o -o boot.bin
@echo # ディスクイメージの作成
@echo # ddを使う例 (1.2MBの空のイメージを作り、そこに流し込む)
dd if=/dev/zero of=my_disk.xdf bs=1024 count=1232
dd if=boot.bin of=my_disk.xdf bs=1024 conv=notrunc seek=0
dd if=main.bin of=my_disk.xdf bs=1024 conv=notrunc seek=1
