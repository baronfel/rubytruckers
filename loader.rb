module Loader
  require "yaml"

  @@base_dir = ".\\assets"

  def load_ship_design(round_num)
    readfile = File.open("#{@@base_dir}\\round#{round_num}.shp")

  end

  def save_ship_design(round_num)

  end

  def load_tiles

  end

  def save_tiles

  end

end