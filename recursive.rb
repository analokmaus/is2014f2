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
