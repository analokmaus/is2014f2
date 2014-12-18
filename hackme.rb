require "rational"

$cand = "0123456789"
$cand = $cand.split('')
def bfa_test(n)
  if n == 0 then
    p($temp)
    if $temp == $test then
      p("Password: #{$temp}")
      p("Time: #{Time.now-$old}msec")
      exit
      #return
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
  $test = a.to_s
  $temp = ""
  $old = Time.now
  for i in 1..$test.size
      bfa_test(i)
  end
  return
end

$primecand = [ 31, 37, 41, 47, 53, 59, 61,67]
$prime = []
class Encryption #1~999
  def initialize(data)
    @plain_txt = data
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
    #return
  end
  def public_key
    #p("PUBLIC KEY SET = [(#{@keyset[0] * @keyset[1]}), #{@keyset[2]}]")
    return [@keyset[0] * @keyset[1], @keyset[2]]
  end
  def secret_key
    return @keyset
  end
  def encode
    @code = @plain_txt ** @keyset[2] % (@keyset[0] * @keyset[1])
    return @code
  end
  def decode(n)
    @answer = @code ** n % (@keyset[0] * @keyset[1])
    return @answer
  end
  def avtodecode
    @answer = @code ** @keyset[3] % (@keyset[0] * @keyset[1])
    return @answer
  end
end

def hackme
  # generate password
  mode = 0
  $pwd = rand(999)
  $primecand.shuffle!
  $prime = $primecand
  code = Encryption.new($pwd)
  p("CIPHER: #{code.encode}")
  print("PUBLIC KEY: "); p(code.public_key)
  p("COMMAND LIST")
  p("> DECODE : decode cipher with secret key")
  p("> ENCODE : encode a number with the same public key")
  p("> ANSWER : enter your answer")
  while true do
    if mode == 0 then # COMMAND MODE
      p("COMMAND MODE")
      cmd = gets.chop
      if cmd == "DECODE" then
        mode = 1
      elsif cmd == "ENCODE" then
        mode = 2
      elsif cmd == "ANSWER" then
        mode = 3
      else
        p("COMMAND #{cmd} NOT FOUND")
      end
    elsif mode == 1 then # DECODE MODE
      p("DECODE MODE: enter secret key")
      p("EXIT : back to COMMAND MODE")
      dminp = gets.chop
      if dminp == "EXIT" then
        mode = 0
      else
        p("CIPHER decoded with secret key [#{dminp.to_i}] is")
        p(code.decode(dminp.to_i))
      end
    elsif mode == 2 then # ENCODE MODE
      p("ENCODE MODE: enter plain text")
      p("EXIT : back to COMMAND MODE")
      eminp = gets.chop
      if eminp == "EXIT" then
        mode = 0
      else
        emcode = Encryption.new(eminp.to_i)
        print("#{eminp.to_i} -> "); p(emcode.encode)
      end
    else # ANSWER MODE
      p("ANSWER MODE: enter your answer")
      p("EXIT : back to COMMAND MODE")
      ans = gets.chop
      if ans == "EXIT" then
        mode = 0
      elsif ans.to_i == code.avtodecode then
        p("ACCEPTED")
        return
      elsif ans == "CHEAT" then
        p(code.secret_key)
      elsif ans == "HACK" then
        bfa(code.avtodecode)
      else
        p("WRONG ANSWER : STUDY MORE ABOUT RSA ENCRYPTION")
      end
    end
  end
end
  
  