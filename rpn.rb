$vals=[]
$show=[]
$temp=[]

def bup
  $temp = $vals.clone
end

def e(x)
  bup
  $vals.push(x)
  $show.push(x.to_s)
  return $vals
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
  bup
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
  bup
  $vals = []
  $show = []
  return $vals
end

def show
  return $show
end

def undo
  $vals = $temp.clone
  $show.push("undo")
  return $vals
end
