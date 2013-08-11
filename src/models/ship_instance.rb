require_relative 'ship_tile'
require_relative 'tile_side'
require_relative 'tile_content'

class ShipInstance
  def initialize(definition)
    @center = definition.center
    @shape = Hash.new
    definition.shape.each { |coord|
      if @shape[coord.x_loc] == nil
        @shape[coord.x_loc] = Hash.new
      end
      @shape[coord.x_loc][coord.y_loc] = :empty
    }
    @shape[@center.x_loc][@center.y_loc] = ShipTile.new(@center,
                                                      UniversalConnector.new,
                                                      UniversalConnector.new,
                                                      UniversalConnector.new,
                                                      UniversalConnector.new,
                                                      Habitat.new(2))
    @removed_tiles = []
  end

  def tiles
    @shape.values.map { |v| v.values }.flatten.select {|x| x != :empty}
  end

  def put_tile!(tile, coord)
    @shape[coord.x_loc][coord.y_loc] = tile
    tile.coord = coord
  end

  def has_tile?(coord)
    col = @shape[coord.x_loc]
    if col.nil? then
      false
    else
      col[coord.y_loc] == :empty ? false : true
    end
  end

  def remove_tile!(coord)
    if @shape[coord.x_loc] != nil
      if @shape[coord.x_loc][coord.y_loc] != nil
        tile = @shape[coord.x_loc][coord.y_loc]
        @shape[coord.x_loc][coord.y_loc] = :empty
        return tile
      end
    end
    nil
  end

  def validate_tile_orientations!
    @shape.each { |x, col|
      col.each { |y, tile|
        if tile != :empty
          unless tile.valid_orientation?
            # TODO: notify player of bad orientation
            @shape[x][y] = :empty
          end
        end
      }
    }
  end

  def validate_tile_rules!
    @shape.each_value { |col|
      col.each_value { |tile|
        if tile != :empty
          adj_tiles = get_adjacent_tiles(tile)
          adj_tiles.each { |adj_tile|
            unless tile.follows_rules?(adj_tile)
              bad_tile = player_choose_tile(tile, adj_tile)
              @removed_tiles << remove_tile!(bad_tile.coord)
            end
          }
        end
      }
    }
  end

  def validate_connected_tiles!
    connected_tiles = [get_tile(center.x_loc, center.y_loc)]
    i = 0
    while i < connected_tiles.length
      tile = connected_tiles[i]
      if tile != nil && tile != :empty
        adj_tiles = get_adjacent_tiles(tile)
        adj_tiles.each { |adj| connected_tiles << adj unless connected_tiles.include?(adj) }
      end
      i += 1
    end
    unconnected_tiles = []
    @shape.each_value { |col|
      col.each_value { |tile|
        if tile != :empty
          unless connected_tiles.include?(tile)
            unconnected_tiles << tile
          end
        end
      }
    }
    # TODO: notify player of unconnected tiles
    unconnected_tiles.each { |tile| remove_tile!(tile.coord) }
  end

  def get_adjacent_tiles(tile)
    x = tile.coord.x_loc
    y = tile.coord.y_loc
    [get_tile(x, y - 1),
     get_tile(x, y + 1),
     get_tile(x + 1, y),
     get_tile(x - 1, y)]
  end

  def get_tile(x, y)
    if @shape[x] != nil
      return @shape[x][y]
    end
    nil
  end

  def player_choose_tile(tile1, tile2)
    # TODO: make the player choose a tile
    tile1
  end

  def get_outer_tile(position, direction)
    case direction
      when :north
        if @shape[position] != nil
          1.upto(12) { |i|
            if @shape[position][i] != nil && @shape[position][i] != :empty
              return @shape[position][i]
            end
          }
        end
        return nil
      when :south
        if @shape[position] != nil
          12.downto(1) { |i|
            if @shape[position][i] != nil && @shape[position][i] != :empty
              return @shape[position][i]
            end
          }
        end
        return nil
      when :east
        12.downto(1) { |i|
          if @shape[i] != nil
            if @shape[i][position] != nil && @shape[i][position] != :empty
              return @shape[i][position]
            end
          end
        }
        return nil
      when :west
        1.upto(12) { |i|
          if @shape[i] != nil
            if @shape[i][position] != nil && @shape[i][position] != :empty
              return @shape[i][position]
            end
          end
        }
        return nil
      else
        nil
    end
  end

  def exposed_connectors
    connectors = []
    @shape.each_value { |col|
      col.each_value { |tile|
        x = tile.coord.x_loc
        y = tile.coord.y_loc
        north_tile = get_tile(x, y - 1)
        connectors << north_tile if is_exposed?(tile, north_tile, :north)
        south_tile = get_tile(x, y + 1)
        connectors << south_tile if is_exposed?(tile, south_tile, :south)
        east_tile = get_tile(x + 1, y)
        connectors << east_tile if is_exposed?(tile, east_tile, :east)
        west_tile = get_tile(x - 1, y)
        connectors << west_tile if is_exposed?(tile, west_tile, :west)
      }
    }
    connectors
  end

  def is_exposed?(tile1, tile2, direction)
    return false unless tile2 == nil || tile2 == :empty
    tile1.get_side(direction).num_connectors != 0
  end

  def has_shield?(orientation)
    tiles.map { |tile| tile.contents }.flatten.find_index { |content| content.is_a?(Shield) && content.orientation == orientation } != nil
  end

  def find_tile_contents(type)
    tiles.map { |tile| tile.contents }.flatten.find_all { |content| content.is_a?(type) }
  end

  def min_engine_power
    tiles.map { |tile| tile.sides }.values.inject(0) { |sum, side|
      sum += side.engine_strength if side.respond_to?(:engine_strength) && (!side.respond_to?(:require_batteries) || side.require_batteries == 0)
      sum
    }
  end

  def potential_engine_power
    tiles.map { |tile| tile.sides }.values.inject(0) { |sum, side|
      sum += side.engine_strength if side.respond_to?(:engine_strength)
      sum
    }
  end

  def min_weapons_power
    weapons = tiles.map { |tile| tile.sides }.select { |key, side| side.respond_to?(:gun_strength) && (!side.respond_to?(:require_batteries) || side.require_batteries == 0) }
    strengths = weapons.map { |orientation, weapon| orientation == :north ? weapon.gun_strength : weapon.gun_strength / 2.0 }
    strengths.inject(0, &:+)
  end

  def potential_weapons_power
    weapons = tiles.map { |tile| tile.sides }.select { |key, side| side.respond_to?(:gun_strength) }
    strengths = weapons.map { |orientation, weapon| orientation == :north ? weapon.gun_strength : weapon.gun_strength / 2.0 }
    strengths.inject(0, &:+)
end

  def engine_power!
    current_strength = min_engine_power
    opt_engines = tiles.map { |tile| tile.sides }.values.select { |side| side.respond_to?(:engine_strength) && (side.respond_to?(:require_batteries) && side.require_batteries > 0) }
    opt_engines.each { |side|
      batteries = player_choose_batteries('Choose ' + side.require_batteries + ' of your ' + batteries_left + ' batteries to add ' + side.engine_strength + ' to your engine strength. (Current strength: ' + current_strength + ')', side.require_batteries)
      if batteries.count == side.require_batteries
        batteries.each { |coord| @shape[coord.x_loc][coord.y_loc].remove_battery! }
        current_strength += side.engine_strength
      end
    }
    current_strength
  end

  def weapons_power!
    current_strength = min_weapons_power
    opt_weapons = tiles.map { |tile| tile.sides }.select { |orientation, side| side.respond_to?(:gun_strength) && (side.respond_to?(:require_batteries) && side.require_batteries > 0) }
    opt_weapons.each { |orientation, side|
      strength = weapon_side_strength(orientation, side)
      batteries = player_choose_batteries('Choose ' + side.require_batteries + ' of your ' + batteries_left + ' batteries to add ' + strength + ' to your weapon strength. (Current strength: ' + current_strength + ')', side.require_batteries)
      if batteries.count == side.require_batteries
        batteries.each { |coord| @shape[coord.x_loc][coord.y_loc].remove_battery! }
        current_strength += strength
      end
    }
    current_strength
  end

  def crew_count
    tiles.inject(0) { |sum, tile| sum += tile.crew_count }
  end

  def batteries_left
    tiles.inject(0) { |sum, tile| sum += tile.batteries_remaining }
  end

  def player_choice_binary?(prompt)
    # TODO: flesh this out
    true
  end

  def player_choose_batteries(prompt, number)
    # TODO: flesh this out
    [Coordinate.new(0, 0)]
  end
end