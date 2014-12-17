class Single_memory
  def initialize
    @mem = nil
  end
  def put(data)
    @mem = data
  end
  def get
    return @mem
  end
end

class Multi_memory
  def initialize
    @mem = []
  end
  def put(data)
    @mem << data
  end
  def get
    tmp = @mem.last
    @mem.pop
    return tmp
  end
end

class Concat
  def initialize
    @str = ""
  end
  def add(input)
    @str += input
  end
  def get
    return @str
  end
  def reset
    @str = ""
  end
end

class Human
  def initialize(name, day_born, place_born, day_died, place_rest, occupation, nationality)
    @name = name
    @day_born = day_born
    @place_born = place_born
    @day_died = day_died
    @place_rest = place_rest
    @occupation = occupation
    @nationality = nationality
  end
  def name
    return @name
  end
  def day_born
    return @day_born
  end
  def place_born
    return @place_born
  end
  def day_died
    return @day_died
  end
  def place_rest
    return @place_rest
  end
  def occupation
    return @occupation
  end
  def nationality
    return @nationality
  end
  def delete
    @day_born = []
    @place_born = ""
    @day_died = []
    @place_rest = ""
    @occupation = []
    @nationality
  end
end

class Buffer
  Cell = Struct.new(:data, :next)
  def initialize
    @tail = @cur = Cell.new("EOF", nil)
    @head = @prev = Cell.new("", @cur)
  end
  def atend
    return @cur == @tail
  end
  def top
    @prev = @head; @cur = @head.next
  end
  def forward
    if atend then return end
    @prev = @cur; @cur = @cur.next
  end
  def insert(s)
    @prev.next = Cell.new(s, @cur); @prev = @prev.next
  end
  def print
    puts(" " + @cur.data)
  end
  def delete
    @cur = Cell.new("EOF", @cur.next)
    @prev.next = @cur
  end
  def exchange
    tmp = @prev.data
    @prev.data = @cur.data
    @cur.data = tmp
  end
end

def hackme(n)
  # generate password
  for i in 0...n do
    $pwd = rand(100000)
    
  end
end
  
#$cand = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYX0123456789"
$cand = "0123456789"
$cand = $cand.split('')
def brute(n)
  if n == 0
    puts $temp
    if $temp == $pass
      puts "Password: #{$temp}"
      puts "Time: #{Time.now-$old}msec"
      exit
    end
    return
  end
  $cand.each do |c|
    $temp += c
    brute(n-1)
    $temp = $temp.slice(0, $temp.size-1)
  end
end

def bruteforce(a)
  $pass = a
  $temp = ""
  $old = Time.now
  for i in 1..$pass.size
    puts "--- Try#{i} ---"
    brute(i)
  end
end