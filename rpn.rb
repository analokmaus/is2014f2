$vals=[]
$show=[]
$temp=[]

def e(x)
  $vals.push(x)
  $show.push(x.to_s)
  return $vals
end

def bup
  $temp[0]=$vals.last
  $temp[1]=$vals[$vals.length - 2]
end

def add
  bup
  x = $vals.pop
  $vals.push($vals.pop + x)
  $show.push("add")
  return $vals
end

def mul
  bup
  x = $vals.pop
  $vals.push($vals.pop * x)
  $show.push("mul")
  return $vals
end

def sub
  bup
  x = $vals.pop
  $vals.push($vals.pop - x)
  $show.push("sub")
  return $vals
end

def div
  bup
  x = $vals.pop.to_f
  $vals.push($vals.pop / x)
  $show.push("div")
  return $vals
end

def mod
  bup
  x = $vals.pop
  $vals.push($vals.pop % x)
  $show.push("mod")
  return $vals
end

def inv
  x = $vals.pop
  $vals.push(x * -1)
  $show.push("inv")
  return $vals
end

def exc
  bup
  x = $vals.pop
  y = $vals.pop
  $vals.push(x)
  $vals.push(y)
  $show.push("exc")
  return $vals
end

def clr
  $vals = []
  $show = []
  return $vals
end

def shw
  return $show
end

def undo
  $vals[$vals.length - 1] = $temp[1]
  $vals.push($temp[0])
  return $vals
end
