### Core ###
Pixel = Struct.new(:r, :g, :b)
def scrinit(w, h)
  $w = w; $h = h
  $img = Array.new(h) do Array.new(w) do Pixel.new(0, 0, 0) end end
  printf("initialized screen %d x %d\n", $w, $h)  
end

def pixset(x, y, r, g, b)
  if 0 <= x && x < $w && 0 <= y && y < $h then
    $img[y][x].r += r; $img[y][x].g += g; $img[y][x].b += b
    if $img[y][x].r > 255 then $img[y][x].r = 255 end
    if $img[y][x].g > 255 then $img[y][x].g = 255 end
    if $img[y][x].b > 255 then $img[y][x].b = 255 end
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


### Over Sampling Anti-Aliasing for Circle ###
def OVAdrawpoint(cx, cy, rad, sps, r, g, b)#sps:subpixel size (must be float)
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
      pixset(cx - rad + x, cy - rad + y, r * c / (sps * sps), g * c / (sps * sps), b * c / (sps * sps))
    end
  end
end
    
### Bresenham's Anti-Aliasing for Line ###
def drawline(sx, sy, gx , gy, th, sps, r, g, b)
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
    #if steep == true then pixset(y, x, r, g, b) else pixset(x, y, r, g, b) end
    if steep == true then OVAdrawpoint(y, x, th, sps, r, g, b) else OVAdrawpoint(x, y, th, sps, r, g, b) end
    err += dy
    if err >= dx then
      err -= dx
      y += ystep
    end
  end
end

### Blur Filter ###
def blurfilter(sx, sy, gx, gy)
  imgclone = Marshal.load(Marshal.dump($img))
  for y in sy..gy do
    for x in sx..gx do
      if y < 1 || x < 1 || y >= $h - 2 || x >= $w - 2 then next end
      $img[y][x].r = (imgclone[y-1][x].r + imgclone[y+1][x].r + imgclone[y][x-1].r + imgclone[y][x+1].r) / 4
      $img[y][x].g = (imgclone[y-1][x].g + imgclone[y+1][x].g + imgclone[y][x-1].g + imgclone[y][x+1].g) / 4
      $img[y][x].b = (imgclone[y-1][x].b + imgclone[y+1][x].b + imgclone[y][x-1].b + imgclone[y][x+1].b) / 4
    end
  end
end

### Basic Figures ###
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

### Star Map ###
def sbgradio(cx, cy, rad, str)#space back ground radiaion, rad should be float
  for y in 0...(2 * rad) do
    for x in 0...(2 * rad) do
      dx = x - rad
      dy = y - rad
      c = (rad * rad - dx * dx - dy * dy ) / (rad * rad)
      if c > 0 then pixset(cx - rad + x, cy - rad + y, str * c / 5, 0, str * c) end
    end
  end
end

def starmapping(max, n, blur, str)
  for i in 1..n do
    sx = rand($w); sy = rand($h)
    sbgradio(sx, sy, rand(max) * blur, str)
    OVAdrawpoint(sx, sy, rand(max), 4.0, 255 - rand(50), 255 - rand(50), 255 - rand(20))
  end
  blurfilter(0, 0, $w, $h)
end
  
  
