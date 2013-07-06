class Loader
  require 'yaml'

  def initialize(tile_file)
    @tile_file = tile_file
  end

  def load_ship_design(round_num)
    return YAML.load_file(".//assets//round#{round_num}.shp")
  end

  def save_ship_design(round_num, design)
    objRep = YAML::dump(design)
    file = File.open(".\\assets\\round#{round_num}.shp", 'w')
    file.puts objRep
  end

  def load_tiles
    return YAML.load_file @tile_file
  end

  def save_tiles(tiles)
    objRep = YAML::dump(tiles)
    File.open(@tile_file, 'w') {
      |x| x.puts objRep
    }
  end
end