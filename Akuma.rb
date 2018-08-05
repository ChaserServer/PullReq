# -*- coding: utf-8 -*-
# Test用プログラム 周りを調べながら行動する

require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows


# サーバに接続
# target = CHaserConnect.new("AStr") # この名前を4文字までで変更する
target = CHaserConnect.new("IWIN") # この名前を4文字までで変更する

values = Array.new(10) # 書き換えない
mode = 1
turn = 0

# 速攻自滅作戦
# 一回目の勝負で「アイテム数で勝ちつつput勝ち」を達成できた時の二回目のプログラム（2017年ルール上）

loop do
  values = target.getReady
  turn += 1

  if turn == 1
    target.putDown
  elsif turn == 2
    target.walkDown
  else
    target.searchDown
  end

end

target.close
