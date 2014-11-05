### dec to bin ###
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


### romaji anagrams ###
$vowel=["a","i","u","e","o"]
def anagrams(name)
  genanagrams(name.split(""), [])
  p("TIPS : make sure the number of vowels should be that of consonants and more")
  p("TIPS : please use 's' and 't' instead of 'sh' and 'ch'")
  p("TIPS : if your name includes small letters, i'm afraid you have problem in generating anagrams")
end

def genanagrams(name, temp)
  if name.length == temp.length && $vowel.include?(temp.last) == true then
    p(temp.join(""))
    return
  end
  name.each_index do |i|
    if name[i] == nil then
      next
    elsif $vowel.include?(name[i]) == false && $vowel.include?(temp.last) == false && temp.last != nil then
      next
    end
    x = name[i]; name[i] = nil; temp.push(x)
    genanagrams(name, temp)
    name[i] = x; temp.pop
  end
end
  
