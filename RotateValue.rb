# Autor Takeshi Ishikawa
# Date 08/01/2018

def _rotate ary, n, rot
    # 1次元→2次元
    #p ary
    matrix = ary.each_slice(n).to_a
    rotateary = matrix
    #p matrix

    rot %= 360
    #p rot

    if rot == 0
        puts "     0度回転"
    elsif rot == 90
        # ↓配列の要素・分割数によってはエラーになる
        puts "右に90度回転"
        rotateary = rotateary.reverse.transpose
    elsif rot == 180
        puts "   180度回転"
        rotateary = rotateary.reverse.map(&:reverse)
    elsif rot == 270
        # ↓配列の要素・分割数によってはエラーになる
         puts "左に90度回転"
        rotateary = rotateary.transpose.reverse
    else
        puts "Rotate Error!!!"
        raise StandardError
    end
    #p rotateary

    # 2次元→1次元
    #p rotateary.flatten
    return rotateary.flatten
end

ary1 = [1, 2, 3, 4, 5, 6, 7, 8, 9]
p ary1
ary2 = _rotate ary1, 3, 90
p ary2
ary3 = _rotate ary1, 3, -180
p ary3
ary4 = _rotate ary1, 3, 270
p ary4
ary5 = _rotate ary1, 3, 360
p ary5

ary6 = _rotate ary1, 9, -270
p ary6
ary7 = _rotate ary1, 9, 180
p ary7
ary8 = _rotate ary1, 9, -90
p ary8
ary9 = _rotate ary1, 9, 0
p ary9
