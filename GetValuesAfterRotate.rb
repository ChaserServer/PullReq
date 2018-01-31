def _display mat
  mat.each do |row|
    puts row.join(' ')
  end
  puts
end


def _rotate valarray, direction
  n = 0
  matrix = Array.new(3, Array.new(3))

  # 1次元配列から2次元配列に変換
  valarray.each_slice(3){|matrix| print "(" + matrix.join(",") + ") " }

  # 進行方向へ時計回りに回転
  case direction
  when 0 then
    _display matrix
  when 1 then
    _display matrix.reverse.transpose #=> 右回転
  when 2 then
    _display matrix.reverse.map(&:reverse) #=> 180度回転
  when 3 then
    _display matrix.transpose.reverse #=> 左回転
  else
    puts("error: direction")
  end


  # 2次元配列から1次元配列に変換
  values = matrix.flatten

end


values = [1,2,3,4,5,6,7,8,9]

_rotate(values, 0)
_rotate(values, 1)
_rotate(values, 2)
_rotate(values, 3)
