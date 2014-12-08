### arraygenerator ###
def randarray(n, max)
  return Array.new(n) do rand(max) end
end

def qsortworstarray(n)
  hlf = n / 2
  a = Array.new(hlf) do |i| i end
  b = Array.new(n - hlf) do |i| n - i - 1 end
  return a + b
end

### array bubble sort ###
def arraybsort(a)
  for i in 0...a.length do
    for j in 0...a.length - (i + 1) do
      if a[j] > a[j+1] then
        temp = a[j+1]; a[j+1] = a[j]; a[j] = temp #swap
      end
    end
  end
  return a
end

### array quick sort ###
def arrayqsort(a)
  if a.length <= 1 then
    return a
  end
  pivot = a[0]
  right = []
  left = []
  for i in 1..(a.length - 1) do
    if a[i] <= pivot then
      left << a[i]
    else
      right << a[i]
    end
  end
  left = arrayqsort(left)
  right = arrayqsort(right)
  return left + [pivot] + right
end

### array merge sort ###
def arraymsort(a, i, j)
    if j <= i
      #
    else
      k = (i + j) / 2
      arraymsort(a, i, k); arraymsort(a, k + 1, j)
      b = merge(a, i, k, a, k + 1, j)
      b.length.times do |l| a[i + 1] = b[l] end
    end
    return a
end
  
def merge(a1, i1, j1, a2, i2, j2)
  b = []
  while i1 <= j1 || i2 <= j2 do
    if i1 > j1 || i2 <= j2 && a1[i1] > a2[i2] then
      b << a2[i2]; i2 += 1
    else
      b << a1[i1]; i1 += 1
    end
  end
  return b
end

###　quick-merge sort ###
$stacklevel = 0
def arrayqmsort(a)
  stacklevellimit = Math.sqrt(a.length)
  if a.length <= 1 then
    return a
  end
  pivot = a[0]
  right = []
  left = []
  for i in 1..(a.length - 1) do
    if a[i] <= pivot then
      left << a[i]
      else
      right << a[i]
    end
  end
  if $stacklevel >= stacklevellimit then
    arraymsort(left, 0, left.length - 1); arraymsort(right, 0, right.length - 1)
    $stacklevel = 0; return left + [pivot] + right
  end
  left = arrayqmsort(left); $stacklevel += 1
  right = arrayqmsort(right); $stacklevel += 1
  $stacklevel = 0; return left + [pivot] + right
end
  
### max in array ###
def arraymax(a)
  max = a[0]
  for i in 0..(a.length - 2) do
    if a[i] < a[i+1] then
      max = a[i+1]
    end
  end
  return max
end

### Gauss-Jordan Elimination ###
class Matritza
  def initialize(a)
    @matryoshka = a
  end
  def show
    for i in 0...@matryoshka.length do
      p(@matryoshka[i])
    end
  end
  def sub_row(a, b, m)
    @matryoshka[a].each_index do |i| @matryoshka[a][i] -=  m * @matryoshka[b][i] end
  end
  def elim
    for i in 0...@matryoshka.length do
      pvt = pivot(i, @matryoshka.length)
      if @matryoshka[pvt][i].abs < 0.0001 then return nil end # muri
      swap(i, pvt)
      for j in 0...@matryoshka.length do
        if i != j then sub_row(j, i, @matryoshka[j][i] / @matryoshka[i][i].to_f) end
      end
    end
    for i in 0...@matryoshka.length do
      @matryoshka[i][@matryoshka.length] /= @matryoshka[i][i]
    end
    self.show
  end
  def pivot(i, n) # find a raw with largest value
    max = @matryoshka[i][i]; pvt = i
    for j in i+1...n do
      if @matryoshka[j][i].abs > max then max = @matryoshka[j][i]; pvt = j end
    end
    return pvt
  end
  def swap(i, j)
    tmp = @matryoshka[i]
    @matryoshka[i] = @matryoshka[j]
    @matryoshka[j] = tmp
  end
end