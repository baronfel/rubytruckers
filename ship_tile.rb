require File.expand_path(File.dirname(__FILE__) + '/coordinate.rb')
class ShipTile
  attr_accessor(:coord)

  def initialize(coord, north, east, south, west, *contents)
    @coord = coord
    @sides = {north: north, east: east, south: south, west: west}
    @contents = contents
  end

  def rotate_clockwise
    ShipTile.new(@coord, @sides[:west], @sides[:north], @sides[:east], @sides[:south], @contents.map {|c| c.rotate_clockwise})
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
    ShipTile.new(@coord, @sides[:east], @sides[:south], @sides[:west], @sides[:north], @contents.map {|c| c.rotate_counter})
  end

  def rotate_counter!
    temp_north = @sides[:north]
    @sides[:north] = @sides[:east]
    @sides[:east] = @sides[:south]
    @sides[:south] = @sides[:west]
    @sides[:west] = temp_north
    @contents.each {|c| c.rotate_counter!}
  end

  def get_side(orientation)
    @sides[orientation]
  end

  def valid_orientation?
    @sides.each {|orientation, side| return false if !side.valid_orientation?(orientation)}
    true
  end

  def follows_rules?(adjacent_tile)
    return true if adjacent_tile == :empty
    my_side, adjacent_side = get_sides(adjacent_tile)
    my_side.follows_rules?(adjacent_side)
  end

  def is_connected?(adjacent_tile)
    my_side, adjacent_side = get_sides(adjacent_tile)
    my_side.is_connected?(adjacent_side)
  end

  def get_sides(adjacent_tile)
    if @coord.x_loc > adjacent_tile.coord.x_loc
      my_orientation = :west
      adjacent_orientation = :east
    elsif @coord.x_loc < adjacent_tile.coord.x_loc
      my_orientation = :east
      adjacent_orientation = :west
    elsif @coord.y_loc > adjacent_tile.coord.y_loc
      my_orientation = :north
      adjacent_orientation = :south
    else
      my_orientation = :south
      adjacent_orientation = :north
    end
    my_side = @sides[my_orientation]
    adjacent_side = adjacent_tile.get_side(adjacent_orientation)
    [my_side, adjacent_side]
  end
end
