def question5
  for i in 1..2015 do
    if  comb(2015,i)%2==0
      return i
    end
  end
end

def comb(n,m)
  return fact(n)/(fact(n-m)*fact(m))
end

def fact(n)
  if n==0
    1
  else
    n * fact(n-1)
  end
end