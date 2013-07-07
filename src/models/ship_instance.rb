requires ShipTile
requires UniversalConnector

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
    @shape[center.x_loc][center.y_loc] = ShipTile.new(center,
                                                      UniversalConnector.new,
                                                      UniversalConnector.new,
                                                      UniversalConnector.new,
                                                      UniversalConnector.new,
                                                      Habitat.new(2))
    @removed_tiles = []
  end

  def tiles
    #TODO: map has into a list for traversal.
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
      if tile != :empty
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
    :empty
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
    # TODO: blurgh
    []
  end

  def get_shield!(orientation)
    # TODO : prompt player for choice
  end

  # TODO : flesh this out
  def engine_power!
    1
  end

  #TODO: flesh this out
  def weapons_power!
    1
  end

  # TODO: flesh this out
  def crew_count!
    1
  end

end