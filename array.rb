### array bubble sort ###
def arraybsort(a)
  for i in 0..(a.length - 1) do
    for j in 0..(a.length - (i + 2)) do
      if a[j] > a[j+1] then
        temp = a[j+1]
        a[j+1] = a[j]
        a[j] = temp
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
  