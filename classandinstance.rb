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
  def initialize
    @name = ""
    @day_born = []
    @place_born = ""
    @day_died = []
    @place_rest = ""
    @occupation = []
    @nationality
  end
  def input(name, day_born, place_born, day_died, place_rest, occupation, nationality)
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
