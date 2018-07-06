# -*- coding: utf-8 -*-
require  'CHaserConnect.rb' #呼び出すおまじない

# 書き換えない
target = CHaserConnect.new("prac") # ()の中好きな名前
values = Array.new(10)
random = Random.new # 乱数生成

hoko = 0 # 向きは時計の針の向き

turn = 0

uenosaki 		= Array.new(10) #LookUp
miginosaki   	= Array.new(10) #LookRight
shitanosaki  	= Array.new(10) #LookDown
hidarinosaki 	= Array.new(10) #LookLeft

#先を見る？
def _tamanisakiwomiru(hoko, uenosaki, miginosaki, shitanosaki, hidarinosaki, target)
	case hoko
		when 0
			uenosaki = _sakiwomiru(hoko, uenosaki, target)
			hoko = _nanimonai(hoko, uenosaki)
		when 3
			miginosaki = _sakiwomiru(hoko, miginosaki, target)
			hoko = _nanimonai(hoko, miginosaki)
		when 6
			shitanosaki = _sakiwomiru(hoko, shitanosaki, target)
			hoko = _nanimonai(hoko, miginosaki)
		when 9
			hidarinosaki = _sakiwomiru(hoko, hidarinosaki, target)
			hoko = _nanimonai(hoko, hidarinosaki)
		end
		return hoko
end

#先を見よう
def _sakiwomiru(hoko, saki, target)
	case hoko
	when 0
		saki = target.searchUp
	when 3
		saki = target.searchRight
	when 6
		saki = target.searchDown
	when 9
		saki = target.searchLeft
	end
	return saki
end


#直線上に何もなければ方向転換
def _nanimonai(hoko, values)
	nai = 0

	for i in 1..9
		if values[i] == 3
			nai = 1
		end
	end

	if nai == 0
		hoko = (hoko + 3) % 12
	end

	return hoko
end

#壁を避けよう
def _kabeyoke(hoko, values)
	loop do
		if hoko == 0 #上に行きたい
			if values[2] == 2 #上のマスが壁だったら
				hoko = 3 #右向け右
			else
				break
			end
		elsif hoko == 3 #右に行きたい
			if values[6] == 2 #右のマスが壁だったら
				hoko = 6 #下向け下
			else
				break
			end
		elsif hoko == 6 #下に行きたい
			if values[8] == 2 #下のマスが壁だったら
				hoko = 9 #左向け左
			else
				break
			end
		elsif hoko == 9 #左に行きたい
			if values[4] == 2 #左のマスが壁だったら
				hoko = 0 #上向け上
			else
				break
			end
		end
	end
	#puts hoko
	return hoko
end

def _mayokonitekigairu(hoko, values, target)
	ita = 0 #フラグ
	#all you needs is kill
	if values[2] == 1 #上に敵がいたとき
		hoko = 0
		ita  = 1 #フララ”が立った！
	elsif values[6] == 1 #右に敵がいたとき
		hoko = 3
		ita  = 1 #フララ”が立った！
	elsif values[8] == 1 #下に敵がいたとき
		hoko = 6
		ita  = 1 #フララ”が立った！
	elsif values[4] == 1 #左に敵がいたとき
		hoko = 9
		ita  = 1 #フララ”が立った！
	end

	puts ita

	if ita == 1
		ita = 0 #立てたフラグは寝かせましょう
		_oku(hoko, values, target)
	end
end


#歩こう
def _aruku(hoko, values, target)
	#私は元気
	case hoko
	when 0
		#上を向いて歩こう
		values = target.walkUp()
	when 3
		#右を向いて歩こう
		values = target.walkRight()
	when 6
		#下を向いて歩こう
		values = target.walkDown()
	when 9
		#左を向いて歩こう
		values = target.walkLeft()
	end
end

def _oku(hoko, values, target)
	#私は元気
	case hoko
	when 0
		#上を向いて歩こう
		values = target.putUp()
	when 3
		#右を向いて歩こう
		values = target.putRight()
	when 6
		#下を向いて歩こう
		values = target.putDown()
	when 9
		#左を向いて歩こう
		values = target.putLeft()
	end
end

def _mayokoniaitemugaaru(hoko, values)
	if values[2] == 3
		hoko = 0
	elsif values[6] == 3
		hoko = 3
	elsif values[8] == 3
		hoko = 6
	elsif values[4] == 3
		hoko = 9
	end

	return hoko
end


loop do
	values = target.getReady()
	#すぐに敵が隣接しているか確かめましょう
	_mayokonitekigairu(hoko, values, target)

	#右に曲がろう
	#if hoko == 0 #上に行きたい
	#	if values[2] == 2 #上のマスが壁だったら
	#		hoko = 3 #右に曲がる
	#	end
	#end

	
	if ( turn % 5 ) == 0 #5ターン毎に先を見る
		#先を見よう
		hoko = _tamanisakiwomiru(hoko, uenosaki, miginosaki, shitanosaki, hidarinosaki,  target)
=begin

		case hoko
		when 0
			uenosaki = _sakiwomiru(hoko, uenosaki, target)
			hoko = _nanimonai(hoko, uenosaki)
		when 3
			miginosaki = _sakiwomiru(hoko, miginosaki, target)
			hoko = _nanimonai(hoko, miginosaki)
		when 6
			shitanosaki = _sakiwomiru(hoko, shitanosaki, target)
			hoko = _nanimonai(hoko, miginosaki)
		when 9
			hidarinosaki = _sakiwomiru(hoko, hidarinosaki, target)
			hoko = _nanimonai(hoko, hidarinosaki)
		end
=end
	else
		#壁をよけよう
		hoko = _mayokoniaitemugaaru(hoko, values)
		hoko = _kabeyoke(hoko, values)
		puts hoko

=begin
	loop do
		if hoko == 0 #上に行きたい
			if values[2] == 2 #上のマスが壁だったら
				hoko = 3 #右向け右
			else
				break
			end
		elsif hoko == 3 #右に行きたい
			if values[6] == 2 #右のマスが壁だったら
				hoko = 6 #下向け下
			else
				break
			end
		elsif hoko == 6 #下に行きたい
			if values[8] == 2 #下のマスが壁だったら
				hoko = 9 #左向け左
			else
				break
			end
		elsif hoko == 9 #左に行きたい
			if values[4] == 2 #左のマスが壁だったら
				hoko = 0 #上向け上
			else
				break
			end
		end
	end
=end

		#行動しよう
		_aruku(hoko, values, target)
	end
	turn += 1
=begin
	#ステップ5でメソッド化
	#行動しよう
	case hoko
	when 0
		#上を向いて歩こう
		values = target.walkUp()
	when 3
		#右を向いて歩こう
		values = target.walkRight()
	when 6
		#下を向いて歩こう
		values = target.walkDown()
	when 9
		#左を向いて歩こう
		values = target.walkLeft()
	end
=end

#--------ここから--------
	if values[0] == 0
		break #breakしたら負け
	end
end #ループここまで

target.close
#-----ここまで書き換えない-----
