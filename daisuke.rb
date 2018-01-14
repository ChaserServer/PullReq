# -*- coding: utf-8 -*-
# Test用プログラム ひたすら四方をsearch（調べる）

require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows

# サーバに接続
target = CHaserConnect.new("Daisuke") # この名前を4文字までで変更する

values = Array.new(10) # 書き換えない

memo = 0
turn =0
count = -5 
turm = 0
oku = 0

loop do # 無限ループ
  #----- ここから -----
  q = rand(2)
  tekito = rand(4)
  a = turm % 6
  
 
  values = target.getReady
  if values[0] == 0 # 先頭が0になったら終了
    break
  elsif values[2] == 1       #上に敵がいたらブロックを置く
    values = target.putUp
  elsif values[4] == 1       #左に敵がいたらブロックを置く
    values = target.putLeft
  elsif values[6] == 1       #右に敵がいたらブロックを置く
    values = target.putRight
  elsif values[8] == 1       #下に敵がいたらブロックを置く
    values = target.putDown
  elsif oku == 3            #3ターンブロックを置いたら
    oku = 0
    if values[2] != 2
      values = target.walkUp
      memo = 1
    elsif values[4] != 2
      values = target.walkLeft
      memo = 2
    elsif values[8] != 2
      values = target.walkDown
      memo = 3
    elsif values[6] != 2
      values = target.walkRight
      memo = 4
    end
  elsif values[1] == 1       #左上に敵がいたら
    if q == 0
      if values[2] != 2
        values = target.putUp
        oku = oku + 1
      elsif values[4] != 2
        values = target.putLeft
        oku = oku + 1
      elsif values[2] == 2
        values = target.putUp
        oku = oku + 1
      end
    elsif q == 1
      if values[4] != 2
        values = target.putLeft
        oku = oku + 1
      elsif values[2] != 2
        values = target.putUp
        oku = oku + 1
      elsif values[4] == 2
        values = target.putLeft
        oku = oku + 1
      end
    end
  elsif values[3] == 1       #右上に敵がいたら
      if q == 0
        if values[2] != 2
          values = target.putUp
          oku = oku + 1
        elsif values[6] != 2
          values = target.putRight
          oku = oku + 1
        elsif values[2] == 2
        values = target.putUp
        oku = oku + 1
        end
      elsif q == 1
        if values[6] != 2
          values = target.putRight
          oku = oku + 1
        elsif values[2] != 2
          values = target.putUp
          oku = oku + 1
        elsif values[6] == 2
          values = target.putRight
          oku = oku + 1
        end
      end
  elsif values[7] == 1        #左下に敵がいたら
      if q == 0
        if values[8] != 2
          values = target.putDown
          oku = oku + 1
        elsif values[4] != 2
          values = target.putLeft
          oku = oku + 1
        elsif values[8] == 2
          values = target.putDown
          oku = oku + 1
        end
      elsif q == 1
        if values[4] != 2
          values = target.putLeft
          oku = oku + 1
        elsif values[8] != 2
          values = target.putDown
          oku = oku + 1
        elsif values[4] == 2
          values = target.putLeft
          oku = oku + 1
        end
      end
  elsif values[9] == 1        #右下に敵がいたら
      if q == 0
        if values[8] != 2
          values = target.putDown
          oku = oku + 1
        elsif values[6] != 2
          values = target.putRight
          oku = oku + 1
        elsif values[8] == 2
          values = target.putDown
          oku = oku + 1
        end
      elsif q == 1
        if values[6] != 2
          values = target.putRight
          oku = oku + 1
        elsif values[8] != 2
          values = target.putDown
          oku = oku + 1
        elsif values[6] == 2
          values = target.putRight
          oku = oku + 1
        end
      end
  elsif turm > 50 && a == 0 && memo == 1 && values[2] != 2  #50ターンたったら上を見る
    values = target.searchUp
      if values[2] == 1 || values[4] == 1 || values[6] == 1 || values[8] == 1
        values = target.getReady
        values = target.lookUp
      end
  elsif turm > 50 && a == 0 && memo == 2 && values[4] != 2  #50ターンたったら左を見る
    values = target.searchLeft
      if values[2] == 1 || values[4] == 1 || values[6] == 1 || values[8] == 1
        values = target.getReady
        values = target.lookLeft
      end
  elsif turm > 50 && a == 0 && memo ==3 && values[8] != 2  #50ターンたったら下を見る
    values = target.searchDown
      if values[2] == 1 || values[4] == 1 || values[6] == 1 || values[8] == 1
        values = target.getReady
        values = target.lookDown
      end
  elsif turm > 50 && a == 0 && memo ==4 && values[6] != 2 #50ターンたったら右を見る
    values = target.searchRight
      if values[2] == 1 || values[4] == 1 || values[6] == 1 || values[8] == 1
        values = target.getReady
        values = target.lookRight
      end
  elsif values[2] == 3       #上にハートがあれば上に行く
    if values[1] == 2 && values[3] == 2    #上が袋小路ぽかったら
      values = target.lookUp
      if values[5] == 2
        values = target.getReady
        if memo == 1
          if q == 0
            if values[4] != 2
              values = target.walkLeft
              memo = 2
            elsif values[6] != 2
              values = target.walkRight
              memo = 4
            elsif values[8] != 2
              values = target.walkDown
              memo = 3
            elsif values[4] == 2
              values = target.lookUp
            end 
          elsif q == 1
            if values[6] != 2
              values = target.walkRight
              memo = 4
            elsif values[4] != 2
              values = target.walkLeft
              memo = 2
            elsif values[8] != 2
              values = target.walkDown
              memo = 3
            elsif values[4] == 2
              values = target.lookUp
            end
          end
        elsif memo == 2
          if values[4] != 2
              values = target.walkLeft
              memo = 2
            elsif values[8] != 2
              values = target.walkDown
              memo = 3
            elsif values[6] != 2
              values = target.walkRight
              memo = 4
            elsif values[4] == 2
              values = target.lookUp
          end
        elsif memo == 4
          if values[6] != 2
              values = target.walkRight
              memo = 4
          elsif values[8] != 2
            values = target.walkDown
            memo = 3
          elsif values[4] != 2
            values = target.walkLeft
            memo = 2
          elsif values[4] == 2
              values = target.lookUp
          end
        end
      elsif
        values = target.getReady
        values = target.walkUp
        memo = 1
        count = 0
        oku = 0
      end
    elsif
      values = target.walkUp
        memo = 1
        count = 0
        oku = 0
    end
  elsif values[4] == 3       #左にハートがあれば左に行く
    if values[1] == 2 && values[7] == 2    #左が袋小路ぽかったら
      values = target.lookLeft
      if values[5] == 2
        values = target.getReady
        if memo == 2
          if q == 0
            if values[2] != 2
              values = target.walkUp
              memo = 2
            elsif values[8] != 2
              values = target.walkDown
              memo = 3
            elsif values[6] != 2
              values = target.walkRight
              memo = 4
            elsif values[2] == 2
              values = target.lookLeft
            end 
          elsif q == 1
            if values[8] != 2
              values = target.walkDown
              memo = 3
            elsif values[2] != 2
              values = target.walkUp
              memo = 1
            elsif values[6] != 2
              values = target.walkRight
              memo = 4
            elsif values[2] == 2
              values = target.lookLeft
            end
          end
        elsif memo == 1
          if values[2] != 2
            values = target.walkUp
            memo = 1
          elsif values[6] != 2
            values = target.walkRight
            memo = 4
          elsif values[8] != 2
            values = target.walkDown
            memo = 3
          elsif values[2] == 2
            values = target.lookLeft
          end
        elsif memo == 3
          if values[8] != 2
            values = target.walkDown
            memo = 3
          elsif values[6] != 2
            values = target.walkRight
            memo = 4
          elsif values[2] != 2
            values = target.walkUp
            memo = 1
          elsif values[2] == 2
            values = target.lookLeft
          end
        end
      elsif
        values = target.getReady
        values = target.walkLeft
        memo = 2
        count = 0
        oku = 0
      end
    elsif
      values = target.walkLeft
      memo = 2
      count = 0
      oku = 0
    end
  elsif values[6] == 3       #右にハートがあれば右に行く
    if values[3] == 2 && values[9] == 2    #右が袋小路ぽかったら
      values = target.lookRight
      if values[5] == 2
        values = target.getReady
        if memo == 4
          if q == 0
            if values[2] != 2
              values = target.walkUp
              memo = 1
            elsif values[8] != 2
              values = target.walkDown
              memo = 3
            elsif values[4] != 2
              values = target.walkLeft
              memo = 2
            elsif values[2] == 2
              values = target.lookRight
            end 
          elsif q == 1
            if values[8] != 2
              values = target.walkDown
              memo = 3
            elsif values[2] != 2
              values = target.walkUp
              memo = 1
            elsif values[4] != 2
              values = target.walkLeft
              memo = 2
            elsif values[2] == 2
              values = target.lookRight
            end
          end
        elsif memo == 1
          if values[2] != 2
            values = target.walkUp
            memo = 1
          elsif values[4] != 2
            values = target.walkLeft
            memo = 2
          elsif values[8] != 2
            values = target.walkDown
            memo = 3
          elsif values[2] == 2
            values = target.lookRight
          end
        elsif memo == 3
          if values[8] != 2
            values = target.walkDown
            memo = 3
          elsif values[4] != 2
            values = target.walkLeft
            memo = 2
          elsif values[2] != 2
            values = target.walkUp
            memo = 1
          elsif values[2] == 2
            values = target.lookRight
          end
        end
      elsif
        values = target.getReady
        values = target.walkRight
        memo = 4
        count = 0
        oku = 0
      end
    elsif
      values = target.walkRight
      memo = 4
      count = 0
      oku = 0
    end
  elsif values[8] == 3       #下にハートがあれば下に行く
    if values[7] == 2 && values[9] == 2    #下が袋小路ぽかったら
      values = target.lookDown
      if values[5] == 2
        values = target.getReady
        if memo == 3
          if q == 0
            if values[4] != 2
              values = target.walkLeft
              memo = 2
            elsif values[6] != 2
              values = target.walkRight
              memo = 4
            elsif values[2] != 2
              values = target.walkUp
              memo = 1
            elsif values[4] == 2
              values = target.lookDown
            end 
          elsif q == 1
            if values[6] != 2
              values = target.walkRight
              memo = 4
            elsif values[4] != 2
              values = target.walkLeft
              memo = 2
            elsif values[2] != 2
              values = target.walkUp
              memo = 1
            elsif values[4] == 2
              values = target.lookDown
            end
          end
        elsif memo == 2
          if values[4] != 2
            values = target.walkLeft
            memo = 2
          elsif values[2] != 2
            values = target.walkUp
            memo = 1
          elsif values[6] != 2
            values = target.walkRight
            memo = 4
          elsif values[4] == 2
            values = target.lookDown
          end
        elsif memo == 4
          if values[6] != 2
            values = target.walkRight
            memo = 4
          elsif values[2] != 2
            values = target.walkUp
            memo = 1
          elsif values[4] != 2
            values = target.walkLeft
            memo = 2
          elsif values[4] == 2
            values = target.lookDown
          end
        end
      elsif
        values = target.getReady
        values = target.walkDown
        memo = 3
        count = 0
        oku = 0
      end
    elsif
      values = target.walkDown
      memo = 3
      count = 0
      oku = 0
    end
  elsif count == 21       #21ターンハートを取れなかったら
    count = 0
    oku = 0
    if memo == 1
      if q == 0
        if values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[8] != 2
               values = target.walkDown
               memo = 3
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        end
      elsif q == 1
        if values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[8] != 2
          values = target.walkDown
          memo = 3
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        end
      end
    elsif memo == 2
      if q == 0
        if values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[8] != 2
          values = target.walkDown
          memo = 3
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        end
      elsif q == 1
        if values[8] != 2
          values = target.walkDown
          memo = 3
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        end
      end
    elsif memo == 3
      if q == 0
        if values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[8] != 2
          values = target.walkDown
          memo = 3
        end
      elsif q == 1
        if values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[8] != 2
          values = target.walkDown
          memo = 3
        end
      end
    elsif memo == 4
      if q == 0
        if values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[8] != 2
          values = target.walkDown
          memo = 3
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        end
      elsif q == 1
        if values[8] != 2
          values = target.walkDown
          memo = 3
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        end
      end
    end
=begin   
  elsif turm == 15           #15ターン動いたら
    turm = 0 
    if tekito == 0
      values = target.putUp
    elsif tekito == 1
      values = target.putLeft
    elsif tekito == 2
      values = target.putDown
    elsif tekito == 3
      values = target.putRight
    end
=end
  elsif values[1] != 1       #隣がブロックorハートではない
    oku = 0
    if memo == 0             #初期位置なら
      if values[2] != 2
        values = target.walkUp
        memo = 1
      elsif values[4] != 2
        values = target.walkLeft
        memo = 2
      elsif values[8] != 2
        values = target.walkDown
        memo = 3
      elsif values[6] != 2
        values = target.walkRight
        memo = 4
      end
    elsif memo == 1          #上に進んだ後なら
      if q == 0
        if values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[8] != 2
          values = target.walkDown
          memo = 3
        end
      elsif q == 1
        if values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[8] != 2
          values = target.walkDown
          memo = 3
        end
      end
    elsif memo == 2          #左に進んだ後なら
      if q == 0
        if values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[8] != 2
          values = target.walkDown
          memo = 3
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        end
      elsif q == 1
        if values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[8] != 2
          values = target.walkDown
          memo = 3
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        end
      end
    elsif memo == 3          #下に進んだ後なら
      if q == 0
        if values[8] != 2
          values = target.walkDown
          memo = 3
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        end
      elsif q == 1
        if values[8] != 2
          values = target.walkDown
          memo = 3
        elsif values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        end
      end
    elsif memo == 4         #右に進んだ後なら
      if q == 0
        if values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[8] != 2
          values = target.walkDown
          memo = 3
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        end
      elsif q == 1
        if values[6] != 2
          values = target.walkRight
          memo = 4
        elsif values[8] != 2
          values = target.walkDown
          memo = 3
        elsif values[2] != 2
          values = target.walkUp
          memo = 1
        elsif values[4] != 2
          values = target.walkLeft
          memo = 2
        end
      end
    end
  end
 
 turn = turn + 1
 turm = turm + 1
 count = count + 1
 #stop = stop + 1
 
  #----- ここまで -----
end

target.close # ソケットを閉じる


