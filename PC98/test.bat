@echo # 1. IPLセクタのビルド
wasm ipl.asm

@echo # IPLのビルド
wlink file ipl.obj name ipl.bin form raw

@echo # 2. メインプログラムのコンパイル
@echo # -ms: Smallモデル, -0: 8086用, -os: サイズ最適化, -zl: ライブラリ参照削除, -fpc: 数学ライブラリ不要
wcc main.c -ms -0 -os -zp1 -zl -fpc -s

@echo # 3. スタートアップのアセンブル
wasm start.asm

@echo # 4. リンク
wlink file start.obj,main.obj name main.bin option Map form raw

@echo # 空の1.2MBイメージ作成
dd if=/dev/zero of=test.hdm bs=1024 count=1232
@echo # IPLを0セクタ目に
dd if=ipl.bin of=test.hdm bs=1024 conv=notrunc seek=0
@echo # メインを1セクタ目に
dd if=main.bin of=test.hdm bs=1024 conv=notrunc seek=1
