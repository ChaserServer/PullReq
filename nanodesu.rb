# -*- coding: utf-8 -*-
# Test用プログラム ひたすら四方をsearch（調べる）

require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows

# サーバに接続
target = CHaserConnect.new("Inazuma") # この名前を4文字までで変更する

values = Array.new(10) # 書き換えない
wallcountA = 0 #壁の数
itemcountA = 0　#アイテムの数
wallcountB = 0 #壁の数
itemcountB = 0　#アイテムの数
judgA = 0 #判定地
judgB = 0 #判定地

def _startposition(values,target) #初期位置把握
  values = target.getReady
  values = target.searchUp
  if values [2] = 2
    values = target.getReady
    values = target.searchLeft
    if values[9] = 2
       $stapos = 1 #右上からスタート
    else
      $stapos = 2 #左上からスタート
    end
  else
    values = traget.getReady
    values = traget.searchLeft
    if values[9] = 2
      $stapos = 3 #左下からスタート
    else
      $stapos = 4 #右下からスタート
    end
  end
  print "stapos"
  puts $stapos
end

def _startmove(values,target) #初期行動
  if $stapos = 1 #右上からスタートだったら
    values = target.getReady
    values = target.lookLeft
    for i in 1..9
      if values[i] = 2
        wallcounrt1 += 1
      elsif values[i] = 3
        itemcount1 += 1
      end
    end
    values = target.getReady
    values = target.lookDown
    for i in 1..9
      if values[i] = 2
        wallcounrt2 += 1
      elsif values[i] = 3
        itemcount2 += 1
      end
    end
    judgA = wallcountA - itemcountA
    judgB = wallcountB - itemcountB
    if judgA < judgB
      $go = 4 #左へ行く
    else
      $go = 3 #下へ行く
    end
  elsif $stapos = 2 #左上からスタートだったら
    values = target.getReady
    values = target.lookRight
    for i in 1..9
      if values[i] = 2
        wallcounrt1 += 1
      elsif values[i] = 3
        itemcount1 += 1
      end
    end
    values = target.getReady
    values = target.lookDown
    for i in 1..9
      if values[i] = 2
        wallcounrt2 += 1
      elsif values[i] = 3
        itemcount2 += 1
      end
    end
    judgA = wallcountA - itemcountA
    judgB = wallcountB - itemcountB
    if judgA < judgB
      $go = 2 #右へ行く
    else
      $go = 3 #下へ行く
    end
      elsif $stapos = 2 #左下からスタートだったら
    values = target.getReady
    values = target.lookUP
    for i in 1..9
      if values[i] = 2
        wallcounrt1 += 1
      elsif values[i] = 3
        itemcount1 += 1
      end
    end
    values = target.getReady
    values = target.lookRight
    for i in 1..9
      if values[i] = 2
        wallcounrt2 += 1
      elsif values[i] = 3
        itemcount2 += 1
      end
    end
    judgA = wallcountA - itemcountA
    judgB = wallcountB - itemcountB
    if judgA < judgB
      $go = 1 #上へ行く
    else
      $go = 2 #右へ行く
    end
      elsif $stapos = 2 #右下からスタートだったら
    values = target.getReady
    values = target.lookUp
    for i in 1..9
      if values[i] = 2
        wallcounrt1 += 1
      elsif values[i] = 3
        itemcount1 += 1
      end
    end
    values = target.getReady
    values = target.lookLeft
    for i in 1..9
      if values[i] = 2
        wallcounrt2 += 1
      elsif values[i] = 3
        itemcount2 += 1
      end
    end
    judgA = wallcountA - itemcountA
    judgB = wallcountB - itemcountB
    if judgA < judgB
      $go = 1 #上へ行く
    else
      $go = 4 #左へ行く
    end
  end
end

def _action(values,target)
  values = target.getReady
  if $go = 1
    values = target.walkUp
  elsif $go = 2
    values = target.walkRight
  elsif $go = 3
    values = target.walkDown
  elsif $go = 4
    values = target.walkLeft
  end
end





loop do # 無限ループ
  #----- ここから -----

  #----- ここまで -----
end

target.close # ソケットを閉じる

