class Loader
  require 'yaml'

  def initialize(tile_file, ship_design_path, card_file)
    @tile_file = tile_file
    @ship_design_path = ship_design_path
    @card_file = card_file
  end

  def load_ship_design(round_num)
    obj =  YAML.load_file("#{@ship_design_path}\\round#{round_num}.shp")
    obj
  end

  def save_ship_design(round_num, design)
    objRep = YAML::dump(design)
    File.open("#{@ship_design_path}\\round#{round_num}.shp", 'w') {|x| x.puts objRep}
  end

  def load_tiles
    return YAML.load_file @tile_file
  end

  def save_tiles(tiles)
    objRep = YAML::dump(tiles)
    File.open(@tile_file, 'w') {|x| x.puts objRep }
  end

  def load_cards
    return YAML.load_file @card_file
  end

  def save_cards(cards)
    objRep = YAML::dump(cards)
    File.open(@card_file, 'w') {|x| x.puts objRep}
  end
end