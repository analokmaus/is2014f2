def hackme(n)
  # generate password
  for i in 0...n do
    $pwd = rand(100000)
    
  end
end
  
$cand = "abcdefghijklmnopqrstuvwxyz0123456789"
$cand = $cand.split('')
def bfa_test(n)
  if n == 0 then
    #p($temp)
    if $temp == $test then
      p("Password: #{$temp}")
      p("Time: #{Time.now-$old}msec")
      #exit
      return
    end
    return
  end
  $cand.each do |c|
    $temp += c
    bfa_test(n - 1)
    $temp = $temp.slice(0, $temp.size - 1)
  end
end

def bfa(a)
  $test = a
  $temp = ""
  $old = Time.now
  for i in 1..$test.size
      bfa_test(i)
  end
end

$prime = [ 3, 7, 11, 13]
class Encryption
  def initialize(data)
    @plain_txt = data
    $prime.shuffle!
    @keyset = [$prime[0], $prime[1]] #[p, q]
    @subkey = (@keyset[0] - 1) * (@keyset[1] - 1)
    for i in 2..@subkey do
      if i.gcd(@subkey) == 1 then
        @keyset << i
        for j in 2..@subkey * 10 do
          if i * j % @subkey == 1 then
            @keyset << j
            break
          end
        end
        break
      end
    end
  end
  def public_key
    p("PUBLIC KEY SET = [#{@keyset[0] * @keyset[1]}, #{@keyset[2]}]")
    return
  end
  def encode
    mod_p = @plain_txt % (@keyset[0] * @keyset[1])
    for i in 1..@keyset[2] do
      p(mod_p)
      @code = mod_p ** 2 % (@keyset[0] * @keyset[1])
      mod_p = @code % (@keyset[0] * @keyset[1])
    end
    return @code
  end
  def decode(n)
    mod_p = @code % (@keyset[0] * @keyset[1])
    for i in 1..n do
      p(mod_p)
      @answer = mod_p ** 2 % (@keyset[0] * @keyset[1])
      mod_p = @answer % (@keyset[0] * @keyset[1])
    end
    return @answer
  end
end
  
  