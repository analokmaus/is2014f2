### primenumber judge ##
def primejudge(n)
  for i in 2..(Math.sqrt(n)) do
    if n % i == 0 then 
      return 0
    end
  end
  return 1
end

### show prime numbers under n ###
def primeun(n)
  for i in 3..n do
    if primejudge(i) == 1 then
      printf("%d\n", i)
    end
  end
end

### eratosthenes's sieve ### 
def eprimeun(n)
  list = [*2..n]
  plist = []
  until list.first > Math.sqrt(n)
    s = list.shift
    plist << s
    list.delete_if {|m| (m % s).zero? }
  end
  return plist + list
end
