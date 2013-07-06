class Coordinate

  attr_reader :x_loc
  attr_reader :y_loc

  def initialize(x, y)
    @x_loc = x
    @y_loc = y
  end

  def ==(another_coord)
    (self.x_loc == another_coord.x_loc) && (self.y_loc == another_coord.y_loc)
  end
end
