class ShipTile
  def initialize(coordinate, north, east, south, west, *contents)
    @coordinate = coordinate
    @sides = {:north => north, :east => east, :south => south, :west => west}
    @contents = contents
  end

  def rotate_clockwise
    ShipTile.new(@coordinate, @sides[:west], @sides[:north], @sides[:east], @sides[:south], @contents.map {|c| c.rotate_clockwise})
  end

  def rotate_clockwise!
    temp_north = @sides[:north]
    @sides[:north] = @sides[:west]
    @sides[:west] = @sides[:south]
    @sides[:south] = @sides[:east]
    @sides[:east] = temp_north
    @contents.each {|c| c.rotate_clockwise!}
  end

  def rotate_counter
    ShipTile.new(@coordinate, @sides[:east], @sides[:south], @sides[:west], @sides[:north], @contents.map {|c| c.rotate_counter})
  end

  def rotate_counter!
    temp_north = @sides[:north]
    @sides[:north] = @sides[:east]
    @sides[:east] = @sides[:south]
    @sides[:south] = @sides[:west]
    @sides[:west] = temp_north
    @contents.each {|c| c.rotate_counter!}
  end
end

class Coordinate
  attr_reader(:x_loc)
  attr_reader(:y_loc)
  def initialize(x, y)
    @x_loc = x
    @y_loc = y
  end
end
