### Core ###
Pixel = Struct.new(:r, :g, :b)
$LAYERLIST = ["$img"] #not available

def scrinit(w, h)
  $w = w; $h = h
  $img = Array.new(h) do Array.new(w) do Pixel.new(0, 0, 0) end end
  $imgclone = Array.new(h) do Array.new(w) do Pixel.new(0, 0, 0) end end
  printf("initialized screen %d x %d\n", $w, $h)  
end

def pixset(x, y, r, g, b, layer)
  if 0 <= x && x < $w && 0 <= y && y < $h then
    if layer == "img" then
      $img[y][x].r += r; $img[y][x].g += g; $img[y][x].b += b
      if $img[y][x].r >= 255 then $img[y][x].r = 255 end
      if $img[y][x].g >= 255 then $img[y][x].g = 255 end
      if $img[y][x].b >= 255 then $img[y][x].b = 255 end
      if $img[y][x].r <= 0 then $img[y][x].r = 0 end
      if $img[y][x].g <= 0 then $img[y][x].g = 0 end
      if $img[y][x].b <= 0 then $img[y][x].b = 0 end
    elsif layer == "clone" then
      $imgclone[y][x].r += r; $imgclone[y][x].g += g; $imgclone[y][x].b += b
      if $imgclone[y][x].r >= 255 then $imgclone[y][x].r = 255 end
      if $imgclone[y][x].g >= 255 then $imgclone[y][x].g = 255 end
      if $imgclone[y][x].b >= 255 then $imgclone[y][x].b = 255 end
      if $imgclone[y][x].r <= 0 then $imgclone[y][x].r = 0 end
      if $imgclone[y][x].g <= 0 then $imgclone[y][x].g = 0 end
      if $imgclone[y][x].b <= 0 then $imgclone[y][x].b = 0 end
    else
      p("LAYER #{layer} not found")
    end
  end
end
  
def imgwrite(name, layer)
  open(name,"wb") do |f|
    f.puts("P6\n#{$w} #{$h}\n255")
    if layer == "img" then
      $img.each do |a| a.each do |p| f.write(p.to_a.pack('ccc')) end end
    elsif layer == "clone" then
      $imgclone.each do |a| a.each do |p| f.write(p.to_a.pack('ccc')) end end
    else
      p("LAYER #{layer} not found")
    end
  end
end

def imgoutput
  imgwrite('test.ppm', "img")
end

### Layer operation ###
def addlayer(source)
  $newlayer = Marshal.load(Marshal.dump(source))
  #$LAYERLIST << name
end

def layeroverwrite(base, source)
  for x in 0...$w do
    for y in 0...$h do
      base[y][x].r += source[y][x].r; base[y][x].g += source[y][x].g; base[y][x].b += source[y][x].b;
      if base[y][x].r > 255 then base[y][x].r = 255 end
      if base[y][x].g > 255 then base[y][x].g = 255 end
      if base[y][x].b > 255 then base[y][x].b = 255 end
      if base[y][x].r < 0 then base[y][x].r = 0 end
      if base[y][x].g < 0 then base[y][x].g = 0 end
      if base[y][x].b < 0 then base[y][x].b = 0 end
    end
  end
end

### Over Sampling Anti-Aliasing for Circle ###
def OVAdrawpoint(cx, cy, rad, sps, r, g, b, layer)#sps:subpixel size (must be float)
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
      if layer == "img" then
        pixset(cx - rad + x, cy - rad + y, r * c / (sps * sps), g * c / (sps * sps), b * c / (sps * sps), "img")
      elsif layer == "clone" then
        pixset(cx - rad + x, cy - rad + y, r * c / (sps * sps), g * c / (sps * sps), b * c / (sps * sps), "clone")
      else
        p("LAYER #{layer} not found")
      end
    end
  end
end
      
def OVAdrawpointRAND(cx, cy, rad, sps, r, g, b, rdm)#color rand
  for y in 0...(2 * rad) do
    for x in 0...(2 * rad) do
      #do judge at each subpixel
      dc = rand(rdm)
      c = 0
      for iy in 0...sps do
        for ix in 0...sps do
          dx = x - rad + (ix / sps)
          dy = y - rad + (iy / sps)
          if (dx * dx) + (dy * dy) < (rad - 1) * (rad - 1) then c += 1 end
        end
        if (dx * dx) + (dy * dy) < (rad - 1) * (rad - 1) then
          pixset(cx - rad + x, cy - rad + y, r * c / (sps * sps) - dc, g * c / (sps * sps) - dc, b * c / (sps * sps) - dc)
        end
      end
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
  
def circularmblur(cx, cy, rad, w, size) # motion blur
  for y in cy - rad - w..cy + rad + w do
    for x in cx - rad - w..cx + rad + w do
      if x + size >= $w - 1 || x - size <= 0 || y + size >= $h || y - size <= 0 then next end
      dx = cx - x; dy = cy - y
      if dx * dx + dy * dy > rad * rad && dx * dx + dy * dy < (rad + w) * (rad + w) then
        count = 1.0
        r = 0; g = 0; b = 0
        for pos in -size..size do
          if y + pos < cy - rad - w || cy + rad + w <= y + pos || x + pos < cx - rad - w || cx + rad + w <= x + pos then next end
          count += 1
          r += $img[y+pos][x+pos].r
          g += $img[y+pos][x+pos].g
          b += $img[y+pos][x+pos].b
        end
        $img[y+pos-size][x+pos-size].r = r / count
        $img[y+pos-size][x+pos-size].g = g / count
        $img[y+pos-size][x+pos-size].b = b / count
      end
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
def sbgradio(cx, cy, rad, r, g, b, layer)#space back ground radiaion, rad should be float
  for y in 0...(2 * rad) do
    for x in 0...(2 * rad) do
      dx = x - rad
      dy = y - rad
      c = (rad * rad - dx * dx - dy * dy ) / (rad * rad)
      if c > 0 then
        if layer == "img" then
          pixset(cx - rad + x, cy - rad + y, r * c, g * c, b * c, "img")
        elsif layer == "clone" then
          pixset(cx - rad + x, cy - rad + y, r * c, g * c, b * c, "clone")
        else
          p("LAYER #{layer} not found")
        end
      end
    end
  end
end
  
def drawmoon(cx, cy, rad)
  sbgradio(cx, cy, rad * 1.3, 100, 100, 100)
  OVAdrawpoint(cx, cy, rad, 5.0, -255, -255, -255)
  OVAdrawpointRAND(cx, cy, rad, 5.0, 234, 244, 255, 40)
  for i in 1..200 do
    crx = rand(2 * rad); cry = rand(2 * rad); c = rand(20)
    dx = crx - rad; dy = cry - rad
    if dx * dx + dy * dy < rad * rad / 2.5 then
      OVAdrawpointRAND(cx + dx, cy + dy, rand(rad / 2.5), 5.0, -c, -c, -c, 5)
    end
  end
end

def starmap(w, h, size, n, blur, str)
  for i in 1..n do
    sx = 5 + rand(w - 10); sy = 5 + rand(h - 10)
    if str > 0 then sbgradio(sx, sy, size * blur, str / 5, 0, str, "img") end
    if str >= 20 then sbgradio(sx, sy, size * blur / 15.0, str * 2, str * 2, str * 2, "img") end
    OVAdrawpoint(sx, sy, size, 4.0, 255 - rand(100), 255 - rand(100), 255 - rand(100), "img")
    p("star number #{i} was mapped")
  end
end

def autostarmap
  p("generating stars...")
  #starmap($w, $h, 2, 300, 10.0, 3)
  starmap($w, $h, 2, 300, 20.0, 6)
  starmap($w, $h, 3, 200, 25.0, 9)
  starmap($w / 2, $h / 2, 3, 20, 40.0, 20)
  starmap($w / 3, $h / 4, 4, 10, 30.0, 20)
  starmap($w / 5, $h / 5, 2, 30, 10.0, 40)
  blurfilter(0, 0, $w, $h)
  p("stars were succesfully mapped")
end
  
def supernova(cx, cy, rad, snrad, r, g, b, n)
  for i in 1..n * 2 do
    crx = rand(2 * rad); cry = rand(2 * rad)
    dx = crx - rad; dy = cry - rad
    if dx * dx + dy * dy * 4 < rad * rad / 3 then
      sbgradio(cx + dx, cy + dy, snrad, r / 10, g, b)
    end
  end
  for i in 1..n * 15 do
    crx = rand(2 * rad); cry = rand(2 * rad)
    dx = crx -rad; dy = cry - rad
    if dx * dx + dy * dy * 4 < rad * rad / 2 && dx * dx + dy * dy * 4 > rad * rad / 4 then
      sbgradio(cx + dx, cy + dy, snrad / 3.0, r, g / 10, b / 10)
    end
  end
  imgoutput
end
    
### ANIMATION ###
def blackhole
  #prepare space background layer
  scrinit(640, 480)
  autostarmap
  $background = Marshal.load(Marshal.dump($img))
  p("rendering frames... this process can take long time")
  for i in 1..80 do
    wn = 100 + i
    rad = i * i / 16.0
    $img = Marshal.load(Marshal.dump($background)) #update img layer
    circularmblur($w / 2, $h / 2, rad.to_i, (rad * 0.6).to_i, 6)
    $imgclone = Marshal.load(Marshal.dump($img)) #overwrite output layer
    sbgradio($w / 2, $h / 2, rad * 1.1, i * 10, i * 10, i * 10, "clone")
    OVAdrawpoint($w / 2, $h / 2, rad, 5.0, -255, -255, -255, "clone")
    imgwrite("blackhole#{wn}.ppm", "clone")
    p("frame #{i} was exported")
  end
end
