
# -*- coding: utf-8 -*-
# Test用プログラム 壁にそって進む

require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows

# サーバに接続
target = CHaserConnect.new("new") # この名前を4文字までで変更する

values = Array.new(10) # 書き換えない
# riko = Array.new(10)
# kayo = Array.new(10)
# nnn = Array.new(10)
# pen = Array.new(10)
copy = Array.new(10)

# 岸さんのプログラムで使われている変数と説明
count = 0
dog = 0     # 斜めの位置に相手がいたときにカウントアップ
ringo = 0   # dogの値が3になったらリンゴの値を１にする. リンゴの値が１の時、敵から離れたいのか近づくのか \ｺﾚｶﾞﾜｶﾗﾅｲ/
red = 0     # stageとmodeを使い分けるためのカウンタ(2回ごとに切り替え)
stage = 1   # 1Down, 2Right, 3Up, 4Left
mode = 1    # 1Down, 2Left, 3Up, 4Right
cat = 0     # 袋小路対策(同じ辺上の斜め2マスが壁で, 挟まれた1マスがアイテムの時, アイテムの奥が壁か否か確認する) 向きはmodeと同じ

# 追加変数
action = 0 # サーバに命令を送ったかどうかチェックする(命令したら1にする)
#命令を送るメソッドを呼び出すときにactionの値が0であるか(まだ命令を送っていないか)確認する

def _moshiTonariNiTeki(values, action) # getReadyで隣接する敵を見つけた時の処理
  if values[2] == 1           # 上に敵がいるなら
    values = target.putUp     # 上にブロックを置く
    action = 1
  elsif values[6] == 1        # 右に敵がいるなら
    values = target.putRight  # 右にブロックを置く
    action = 1
  elsif values[8] == 1        # 下に敵がいるなら
    values = target.putDown   # 下にブロックを置く
    action = 1
  elsif values[4] == 1        # 左に敵がいるなら
    values = target.putLeft   # 左にブロックを置く
    action = 1
  end
end



def _moshiNanameNiTeki(values, dog, ringo) # getReadyで斜め位置に敵を見つけた時の処理
  if values[1] == 1 && ringo == 1
    mode = 3
    stage = 3
    #上方向に設定
  elsif values[3] == 1 && ringo == 1
    mode = 4
    stage = 2
    #右方向に設定
  elsif values[9] == 1 && ringo == 1
    mode = 1
    stage = 1
    #下方向に設定
  elsif values[7] == 1 && ringo == 1
    mode = 2
    stage = 4
    #左方向に設定
  end
end

def _moshiItemGaFukurokozi(values, cat, mode, stage action) # getReadyで袋小路の入り口っぽいところにアイテムがある時
  if cat == 1 && values[8] = 2      # catが1で,values[8]が壁のとき
    cat = 0                       # catを０にする
    mode =1                       # modeを１にする
    stage = 1                     # stageを１にする
    # 袋小路に入らずに下に離脱する
  end　# ここにendを書くと, 以降のelsifに分岐できません.(以下同様)
elsif cat == 2 && values[6]= 2    #
  cat = 0                       #
  mode = 2                      #
  stage = 4                     #
  #袋小路に入らずに右に離脱する
end
elsif cat == 3 && values[2] = 2   #
  cat = 0                       #
  mode = 3                      #
  stage = 3                     #
  #袋小路に入らずに上に離脱する
end
elsif cat == 4 && values[4] = 2   #
  cat = 0                       #
  mode = 4                      #
  stage = 2                     #
  #袋小路に入らずに左に離脱する
end　#条件分岐ここまで
# end ←koreiru?
# end ←これ要る？

def _redGaZeroOrOne(values, ringo, dog, cat, mode, stage, action)
  if values[1] == 1 && ringo !=1        #
    values=target.lookUp                 #
    dog = dog+1                          #
    action = 1
  elsif values[3] == 1 && ringo !=1     #
    values=target.lookUp                 #
    dog = dog+1
    action = 1                          #
  elsif values[7] == 1 && ringo !=1     #
    values =target.lookDown              #
    dog = dog+1
    action = 1                          #
  elsif values[9] == 1 && ringo !=1     #
    values=target.lookDown               #
    dog = dog +1
    action = 1                         #
  elsif values[8]==3         #下にアイテムが有るなら
    if values[7] == 2 && values[9] == 2 && cat !=5
      values=target.lookDown                       #
      mode = 1                                     #
      cat = 1
      stage = 1
      action = 1
    else values=target.walkDown                      #
      mode = 1   #次のターンで下に行く
      cat = 0
      stage = 1
      action = 1
    end                                              #
  elsif values[6]==3         #右にアイテムがあるなら
    if values[3]==2 && values[9] == 2 && cat !=5     #
      values=target.lookRight                        #
      mode = 2                                       #
      cat = 2                                      #
      stage = 4
      action = 1
    else values = target.walkRight                # ???
      mode = 2                                    #
      cat = 0                                     #
      stage = 4
      action = 1
    end                                              #
  elsif values[2]==3         #上にアイテムがあるなら#
    if values[1]==2 && values[3]==2 && cat !=5       #
      values=target.lookUp                           #
      mode = 3                                     #
      cat = 3                                      #
      stage = 3
      action = 1
    else values = target.walkUp                      #
      mode = 3                                        #
      cat = 0                                         #
      stage = 3
      action = 1
    end                                              #
  elsif values[4]==3         #左にアイテムがあるなら #
    if values[7]==2 && values[1]==2 && cat !=5       #
      values=target.lookLeft                         #
      mode = 4                                     #
      cat = 4                                      #
      stage = 2
      action = 1
    elsif values = target.walkLeft                   #
      mode = 4                                       #
      cat = 0                                        #
      stage = 2
      action = 1
    end                                              #
  elsif mode == 1                                    #
    if values[8] != 2           #下に壁がなければ下へ
      values = target.walkDown                         #
      mode = 1                                        #
      copy = 3                                        #
      stage = 1
      action = 1
    elsif   values[4] != 2                            #
      values = target.walkLeft                         #
      mode = 4                                         #
      stage = 2
      action = 1
    elsif values[2] != 2                              #
      values=target.walkUp                            #
      mode = 3                                        #
      stage = 3
      action = 1
    elsif values[6] != 2                              #
      values = target.walkRight                      #
      mode = 2                                        #
      stage = 4
      action = 1
    end                                               #
  elsif mode == 2                                     #
    if values[6] != 2                               #
      values = target.walkRight                       #
      mode = 2                                        #
      stage = 4
      action = 1
    elsif values[8] != 2                              #
      values=target.walkDown                          #
      mode = 1                                        #
      stage = 1
      action = 1
    elsif values[4] != 2                              #
      values = target.walkLeft                        #
      mode = 4                                        #
      stage = 2
      action = 1
    elsif values[2] != 2                              #
      values = target.walkUp                          #
      mode = 3                                        #
      stage = 3
      action = 1
    end                                               #
  elsif mode == 3                                     #
    if values[2] != 2           #                     #
      values = target.walkUp    #                     #
      mode = 3                                        #
      stage = 3
      action = 1
    elsif values[6] != 2                              #
      values = target.walkRight                       #
      mode = 2                                        #
      stage =4
      action = 1
    elsif values[8] != 2                              #
      values = target.walkDown                        #
      mode = 1                                        #
      stage =1
      action = 1
    elsif   values[4] != 2                            #
      values=target.walkLeft                          #
      mode = 4                                        #
      stage = 2
      action = 1
    end                                               #
  elsif mode == 4                                     #
    if values[4] != 2                                 #
      values = target.walkLeft                        #
      mode = 4                                        #
      stage = 2
      action = 1
    elsif values[2] != 2                              #
      values = target.walkUp  #                       #
      mode = 3                                        #
      stage = 3
      action = 1
    elsif   values[6] != 2                            #
      values=target.walkRight                         #
      mode = 2                                        #
      stage = 4
      action = 1
    elsif values[8] != 2                              #
      values=target.walkDown                          #
      mode = 1                                        #
      stage = 1
      action = 1
    end                                               #
  end
end

def _redGaTwoOrThree(values, ringo, dog, cat, mode, stage)
  if values[1] == 1 && ringo !=1        #
    values=target.lookUp                 #
    dog = dog+1
    action = 1                          #
  elsif values[3] == 1 && ringo !=1     #
    values=target.lookUp                 #
    dog = dog+1
    action = 1                          #
  elsif values[7] == 1 && ringo !=1     #
    values =target.lookDown              #
    dog = dog+1
    action = 1                          #
  elsif values[9] == 1 && ringo !=1     #
    values=target.lookDown               #
    dog = dog +1
    action = 1                         #
  elsif values[8]==3         #下にアイテムが有るなら
    if values[7] == 2 && values[9] == 2 && cat !=5
      values=target.lookDown                       #
      mode = 1                                     #
      cat = 1                                      #
      stage = 1
      action = 1
    else values=target.walkDown                      #
      mode = 1   #次のターンで下に行く
      cat = 0                                      #
      stage = 1
      action = 1
    end                                              #
  elsif values[6]==3         #右にアイテムがあるなら
    if values[3]==2 && values[9] == 2 && cat !=5     #
      values=target.lookRight                        #
      mode = 2                                       #
      cat = 2                                      #
      stage = 4
      action = 1
    else values = target.walkRight                   #
      mode = 2                                    #
      cat = 0                                     #
      stage = 4
      action = 1
    end                                              #
  elsif values[2]==3         #上にアイテムがあるなら#
    if values[1]==2 && values[3]==2 && cat !=5       #
      values=target.lookUp                           #
      mode = 3                                     #
      cat = 3                                      #
      stage = 3
      action = 1
    else values = target.walkUp                      #
      mode = 3                                        #
      cat = 0                                         #
      stage = 3
      action = 1
    end                                              #
  elsif values[4]==3         #左にアイテムがあるなら #
    if values[7]==2 && values[1]==2 && cat !=5       #
      values=target.lookLeft                         #
      mode = 4                                     #
      cat = 4                                      #
      stage = 2
      action = 1
    elsif values = target.walkLeft                   #
      mode = 4                                       #
      cat = 0                                        #
      stage = 2
      action = 1
    end                                              #
  elsif stage == 1                                    #
    if values[8] != 2           #下に壁がなければ下へ
      values = target.walkDown                         #
      mode = 1                                        #
      copy = 3                                        #
      stage = 1
      action = 1
    elsif   values[4] != 2                            #
      values = target.walkRight                         #
      mode = 4                                         #
      stage = 2
      action = 1
    elsif values[2] != 2                              #
      values=target.walkUp                            #
      mode = 3                                        #
      stage = 3
      action = 1
    elsif values[6] != 2                              #
      values = target.walkLeft                       #
      mode = 2                                        #
      stage = 4
      action = 1
    end                                               #
  elsif stage == 2                                     #
    if values[6] != 2                               #
      values = target.walkRight                       #
      mode = 4                                        #
      stage = 2
      action = 1
    elsif values[8] != 2                              #
      values=target.walkDown                          #
      mode = 1                                        #
      stage = 1
      action = 1
    elsif values[4] != 2                              #
      values = target.walkLeft                        #
      mode = 2                                        #
      stage = 4
      action = 1
    elsif values[2] != 2                              #
      values = target.walkUp                          #
      mode = 3                                        #
      stage = 3
      action = 1
    end                                               #
  elsif stage == 3                                     #
    if values[2] != 2                                 #
      values = target.walkUp                         #
      mode = 3                                        #
      stage = 3
      action = 1
    elsif values[6] != 2                              #
      values = target.walkLeft                       #
      mode = 2                                        #
      stage = 4
      action = 1
    elsif values[8] != 2                              #
      values = target.walkDown                        #
      mode = 1                                        #
      stage = 1
      action = 1
    elsif   values[4] != 2                            #
      values=target.walkRight                          #
      mode = 4                                        #
      stage = 2
      action = 1
    end                                               #
  elsif stage == 4                                     #
    if values[4] != 2                                 #
      values = target.walkLeft                        #
      mode = 2                                        #
      stage = 4
      action = 1
    elsif values[2] != 2                              #
      values = target.walkUp  #                       #
      mode = 3                                        #
      stage = 3
      action = 1
    elsif   values[6] != 2                            #
      values=target.walkRight                         #
      mode = 4                                        #
      stage = 2
      action = 1
    elsif values[8] != 2                              #
      values=target.walkDown                          #
      mode = 1                                        #
      stage = 1
      action = 1
    end                                               #
  end
end

def _changeMode(count, work, mode, stage)
  count = count + 1

  if count % 7 == 0 && mode == 2 or count % 7 == 0 && mode == 4 or count % 7 ==0 && stage == 2 or count%7 ==0 && stage ==4   #countが７の時とmodeが２の時　か　countが７の時とmodeが４の時
    work = rand(2)                                              #
    if  work == 0                                                 #
      mode = work+1                                                #
      stage = work+1
    elsif  work == 1                                              #
      mode = work+2                                                 #
      stage = work+2
    end #以降のelsifに分岐できません
  elsif count % 7 == 0 && mode == 3 or count % 7 == 0 && mode == 1 or count %7 ==0 && stage == 3 or count %7 == 0 && stage == 1#
    work = rand(2)                                              #
    if work == 0                                                  #
      mode = work+2                                                #
      stage = work+2
    elsif work == 1                                               #
      mode = work +3                                               #
      stage = work +3
    end                                                           #
  end


end



loop do # 無限ループ
  values = target.getReady # 準備信号を送り制御情報と周囲情報を取得
  if values[0] == 0        # 制御情報が0なら終了
    break
  end
  #----- ここから -----
  action = 0                         # 命令フラグを初期化
  _moshiTonariNiTeki(values, action) # getReadyで敵が見つかった時の対処
  _moshiNanameNiTeki(values, dog, ringo)

  if (red == 0 or red == 1) and action == 0
    _redGaZeroOrOne(values, ringo, dog, cat, mode, stage) #redの値によって動作を変える
  elsif (red == 2 or red == 3) and action == 0
    _redGaTwoOrThree(values, ringo, dog, cat, mode, stage)
  end

  if red == 3
    red = 0
    stage = mode
  end

  _changeMode(count, work, mode, stage)

  #この条件分岐は？
  if values[5] == 3 or values[5] == 0 and cat !=0 # values[5] != 2 を表したいのでしょうか？
    cat = 5                                                  #
  end                                                        #

  if red <= 2
    red = red +1
  else
    red = 0
  end
  #----- ここまで -----
end

target.close # ソケットを閉じる
