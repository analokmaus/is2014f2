Pixel = Struct.new(:r, :g, :b)
$w = 0
$h = 0
def scrinit(w, h)
  $w = w; $h = h
  $img = Array.new(h) do Array.new(w) do Pixel.new(255, 255, 255) end end
  printf("initialized screen %d x %d\n", $w, $h)  
end

def pixset(x, y, r, g, b)
  if 0 <= x && x < $w && 0 <= y && y < $h then
    $img[y][x].r = r; $img[y][x].g = g; $img[y][x].b = b
  end
end

def imgwrite(name)
  open(name,"wb") do |f|
    f.puts("P6\n#{$w} #{$h}\n255")
    $img.each do |a| a.each do |p| f.write(p.to_a.pack('ccc')) end end
  end
end

def imgoutput
  imgwrite('test.ppm')
end

def drawline(sx, sy, gx , gy, r, g, b)
  for x in sx..gx do
    y = sx + (gy -sy) * (x - sx)/ (gx - sx)
    pixset(x, y ,r ,g ,b)
  end
end

def drawtriangle(ax, ay, bx, by, cx, cy, r, g, b) #/_\
  drawline(ax, ay, bx, by, r, g, b) # /
  drawline(bx, by, cx, cy, r, g, b) # \
  drawline(cx, cy, ax, ay, r, g, b) # _
end

  
  
