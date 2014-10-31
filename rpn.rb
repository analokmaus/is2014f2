$vals=[]
$show=[]

def e(x)
  $vals.push(x)
  $show.push(x.to_s)
  return $vals
end

def add
  x = $vals.pop
  $vals.push($vals.pop + x)
  $show.push("add")
  return $vals
end

def mul
  x = $vals.pop
  $vals.push($vals.pop * x)
  $show.push("mul")
  return $vals
end

def sub
  x = $vals.pop
  $vals.push($vals.pop - x)
  $show.push("sub")
  return $vals
end

def div
  x = $vals.pop.to_f
  $vals.push($vals.pop / x)
  $show.push("div")
  return $vals
end

def mod
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

