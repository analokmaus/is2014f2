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


### Over Sampling Anti-Aliasing ###
def OVAdrawpoint(sx, sy, rad, sps, r, g, b)#spl:subpixel size (must be float)
  for y in 0...(2 * rad) do
    for x in 0...(2 * rad) do
      #do judge at each subpixel
      c = 0
      for iy in 0...sps do
        for ix in 0...sps do
          dx = x - rad + (ix / sps)
          dy = y - rad + (iy / sps)
          if (dx * dx) + (dy * dy) < (rad - 1) * (rad - 1) then c += 1 end
        end
      end
      pixset(sx + x, sy + y, r * c / (sps * sps), g * c / (sps * sps), b * c / (sps * sps))
    end
  end
end

def drawline(sx, sy, gx , gy, th, r, g, b)#bresenham's anti-alias
  #steep be true when dy > dx
  if (gy - sy).abs > (gx - sx).abs then steep = true else steep = false end
  #dx must be bigger than dy, so exchange x and y if
  if steep == true then
    temp = sx; sx = sy; sy = temp
    temp = gx; gx = gy; gy = temp
  end
  if sx > gx then
    temp = sx; sx = gx; gx = temp
    temp = sy; sy = gy; gy = temp
  end
  dx = gx - sx
  dy = (gy - sy).abs
  err = 0.5 * dx
  if sy < gy then ystep = 1 else ystep = -1 end
  y = sy
  for x in sx..gx do
    if steep == true then pixset(y, x, r, g, b) else pixset(x, y, r, g, b) end
    #if steep == true then OVAdrawpoint(y, x, th, 5.0, r, g, b) else OVAdrawpoint(x, y, th, 5.0, r, g, b) end
    err += dy
    if err >= dx then
      err -= dx
      y += ystep
    end
  end
end

def drawbox(sx, sy, gx, gy, r, g, b)
  drawline(sx, sy, sx, gy, r, g, b)
  drawline(sx, gy, gx, gy, r, g, b)
  drawline(gx, gy, gx, sy, r, g, b)
  drawline(gx, sy, sx, sy, r, g, b)
end
  
def drawtriangle(ax, ay, bx, by, cx, cy, r, g, b)
  drawline(ax, ay, bx, by, r, g, b)
  drawline(bx, by, cx, cy, r, g, b)
  drawline(cx, cy, ax, ay, r, g, b)
end

  
  
