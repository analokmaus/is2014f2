### arraygenerator ###
def randarray(n, max)
  return Array.new(n) do rand(max) end
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
      return
    else
      k = (i + j) / 2
      arraymsort(a, i, k); arraymsort(a, k + 1, j)
      left = a[i..k]; right = a[k+1..j]
      while i <= k || k + 1 <= j do
        if i > k || k + 1 <= j && a[i] > a[k + 1] then
          b.push(a[j]); j += 1
        else
          b.push(a[i]); i += 1
        end
      end
    end
    return a
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
  
### benchmark ###
def bench(count, &block)
  t1 = Process.times.utime
  count.times do yield end
  t2 = Process.times.utime
  return t2 - t1
end
