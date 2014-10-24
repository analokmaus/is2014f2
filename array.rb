def arraymax(a)
  a.sort!
  return a.last
end

def arraymaxorder(a)
  b = a
  max = arraymax(b)
  for i in 0..(a.length - 1) do
    if a[i] == max then
      return i
    end
  end
end
  
