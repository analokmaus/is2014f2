$init = 0
$ans = ''
def dectobin(n)
  if $init == 0 then 
    $ans = ''
    $init = 1
  end
  r = n % 2
  n = n / 2
  if n > 0 then
    dectobin(n)
  end
  $ans << r.to_s
  $init = 0
  return $ans
end

$vowel=["a","i","u","e","o"]

def anagrams(name)
  genanagrams(name.split(""), [])
end

def genanagrams(name, temp)
  if name.length == temp.length then
    p(temp)
    return 
  end
  name.each_index do |i|
    if name[i] == nil then
      next
    end
    
    if $vowel.include?(name[i]) == false && $vowel.include?(temp.last) == false && temp.last != nil then
      next
    end

    #if $vowel.include?(name[i]) == false && temp.length == name.length - 1 then
    #  next
    #end

    x = name[i]
    name[i] = nil
    temp.push(x)
    genanagrams(name, temp)
    name[i] = x
    temp.pop
  end
end
  
