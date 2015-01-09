def room(n)
  #MEMO a = [1,2,3,4,5], a[-1] = 5, a[-2] = 4 ...
  roomprice = Array.new(n+8, 0)
  1.step(n) do |i|
    min = roomprice[i-1]+5000;
    if min > roomprice[i-3]+12000 then min = roomprice[i-3]+12000 end
    if min > roomprice[i-7]+20000 then min = roomprice[i-7]+20000 end
    roomprice[i] = min
  end
  return roomprice[n]
end

def room1(n)
  roomprice = Array.new(n+8, 0)
  roomsel = Array.new(n+1, 0)
  1.step(n) do |i|
    min = roomprice[i-1]+5000; s=1
    if min > roomprice[i-3]+12000 then min = roomprice[i-3]+12000; s = 3 end
    if min > roomprice[i-7]+20000 then min = roomprice[i-7]+20000; s = 7 end
    roomprice[i] = min; roomsel[i] = s
  end
  a = [roomprice[n]]
  while n > 0 do a.push(roomsel[n]); n -= roomsel[n] end
  return a
end

def leastcoins(n)
  centum = Array.new(n+25, 0)
end

def largest_square
  h = 9; w = 8; max = 1
  map = Array.new(h, 1) { Array.new(w, 1) } #map
  map[0][4] = 0; map[2][2] = 0; map[3][5] = 0; map[4][1] = 0 #obsacles
  for y in 1...h do
    for x in 1...w do
        if map[y][x] != 0 then
          map[y][x] = min(map[y-1][x-1], map[y][x-1], map[y-1][x]) + 1
          if map[y][x] > max then max = map[y][x] end
        end
    end
  end
  for y in 1...h do
    for x in 1...w do
      if map[y][x] == max then
        for i in 0...max do
          for j in 0...max do
            map[y-i][x-j] = -1
          end
        end
      end
    end
  end
  for y in 0...h do
    p(map[y])
  end
end

def min(x,y,z)
  a = [x,y,z]
  a.sort!
  return a[0]
end