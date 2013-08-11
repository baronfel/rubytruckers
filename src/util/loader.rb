class Loader
  require 'yaml'

  def initialize(tile_file, ship_design_path)
    @tile_file = tile_file
    @asset_path = ship_design_path
  end

  def load_ship_design(round_num)
    YAML.load_file("#{@asset_path}\\round#{round_num}.shp")
  end

  def save_ship_design(round_num, design)
    objRep = YAML::dump(design)
    file = File.open("#{@asset_path}\\round#{round_num}.shp", 'w')
    file.puts objRep
  end

  def load_tiles
    YAML.load_file @tile_file
  end

  def save_tiles(tiles)
    objRep = YAML::dump(tiles)
    File.open(@tile_file, 'w') {
      |x| x.puts objRep
    }
  end

  def save_round_constraint(round_number, constraint)
    objRep = YAML::dump(constraint)
    File.open("#{@asset_path}\\round#{round_number}.con", 'w'){
      |x| x.puts objRep
    }
  end

  def load_constraint(round_num)
    YAML.load_file("#{@asset_path}\\round#{round_num}.con")
  end
end