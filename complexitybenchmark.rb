def bench(count, &block)
  t1 = Process.times.utime
  count.times do yield end
  t2 = Process.times.utime
  return t2 - t1
end

def square1(n)
  return n * n
end

def square2(n)
  result = 0
  n.times do result += n end
  return result
end

def square3(n)
  result = 0
  n.times do n.times do result += 1 end end
  return result
end

def squarebench(n, rep)
  p("n/r1/r2/r3")
  for i in 1..5 do
    testn = i * n
    r1 = bench(rep) do square1(testn) end
    r2 = bench(rep) do square2(testn) end
    r3 = bench(rep) do square3(testn) end
    p("#{testn} / #{r1} #{r2} #{r3}")
  end
end