module Loader
  require "yaml"

  @@base_dir = ".\\assets"

  def load_ship_design(round_num)
    return YAML::load("#{@@base_dir}\\round#{round_num}.shp")
  end

  def save_ship_design(round_num, design)
    objRep = YAML::dump(design)
    file = File.open("#{@@base_dir}\\round#{round_num}.shp", 'w')
    file.puts objRep
  end

  def load_tiles
    return YAML::load("#{@@base_dir}\\tileList.tls")
  end

  def save_tiles(tiles)
    objRep = YAML::dump(tiles)
    file = File.open("#{@@base_dir}\\tileList.tls", 'w')
    file.puts objRep
  end
end