# -*- coding: utf-8 -*-

# 確殺

def _anaguma target, seaval, values
  values = target.getReady
  zone = 0
  if seaval[2] == 1 && seaval[4] == 1
    case $direction
    when 0 then
      values = target.walkRight
      while zone == 0 do
        values = target.getReady
        seaval = target.lookUp
        if seaval[4] == 1
          values = target.getReady
          values = target.walkUp
          zone = 1
        end
      end
      values = target.getReady
      values = target.putLeft
      values = target.getReady
      values = target.putUp
    when 9 then
      values = target.walkDown
      while zone == 0 do
        values = target.getReady
        seaval = target.lookLeft
        if seaval[2] == 1
          values = target.getReady
          values = target.walkLeft
          zone = 1
        end
      end
      values = target.getReady
      values = target.putLeft
      values = target.getReady
      values = target.putUp
    end
  elsif seaval[2] == 1 && seaval[6] == 1
    case $direction
    when 0 then
      values = target.walkLeft
      while zone == 0 do
        values = target.getReady
        seaval = target.lookUp
        if seaval[6] == 1
          values = target.getReady
          values = target.walkUp
          zone = 1
        end
      end
      values = target.getReady
      values = target.putRight
      values = target.getReady
      values = target.putUp
    when 3 then
      values = target.walkDown
      while zone == 0 do
        values = target.getReady
        seaval = target.lookLeft
        if seaval[2] == 1
          values = target.getReady
          values = target.walkRight
          zone = 1
        end
      end
      values = target.getReady
      values = target.putRight
      values = target.getReady
      values = target.putUp
    end
  elsif seaval[4] == 1 && seaval[8] == 1
    case $direction
    when 6 then
      values = target.walkLeft
      while zone == 0 do
        values = target.getReady
        seaval = target.lookDown
        if seaval[4] == 1
          values = target.getReady
          values = target.walkDown
          zone = 1
        end
      end
      values = target.getReady
      values = target.putLeft
      values = target.getReady
      values = target.putDown
    when 9 then
      values = target.walkUp
      while zone == 0 do
        values = target.getReady
        seaval = target.lookLeft
        if seaval[8] == 1
          values = target.getReady
          values = target.walkLeft
          zone = 1
        end
      end
      values = target.getReady
      values = target.putLeft
      values = target.getReady
      values = target.putDown
    end

  elsif seaval[6] == 1 && seaval[8] == 1
    case $direction
    when 6 then
      values = target.walkLeft
      while zone == 0 do
        values = target.getReady
        seaval = target.lookDown
        if seaval[6] == 1
          values = target.getReady
          values = target.walkDown
          zone = 1
        end
      end
      values = target.getReady
      values = target.putRight
      values = target.getReady
      values = target.putDown
    when 3 then
      values = target.walkUp
      while zone == 0 do
        values = target.getReady
        seaval = target.lookRight
        if seaval[8] == 1
          values = target.getReady
          values = target.walkRight
          zone = 1
        end
      end
      values = target.getReady
      values = target.putRight
      values = target.getReady
      values = target.putDown
    end
  end
end
