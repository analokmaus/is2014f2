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

class Stack1
  def initialize
    @arr = []
    #@arr = Array.new(100)
    #@ptr = -1
  end
  def isempty
    return @arr.empty?
    #return @ptr < 0
  end
  def push(x)
    #@ptr += 1
    #@arr[@ptr] = x
    @arr << x
    return x
  end
  def pop
    x = @arr.last
    @arr.pop
    #x = @arr[@ptr]
    #@ptr -= 1
    return x
  end
end

class Stack2
  Cell = Struct.new(:data, :next)
  def initialize
    @top = nil
  end
  def push(x)
  end
  def pop
  end
end