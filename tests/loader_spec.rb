require_relative '../loader'
require_relative '../ship_tile'
require_relative '../ship_definition'
require 'rspec'

describe Loader do

  before :each do
    @loader = Loader.new('./test_tile_file.tls', '.')
  end

  describe '#new' do
    it 'should be instance of Loader class' do
      @loader.should be_an_instance_of Loader
    end
  end

  describe '#save_tiles' do
    it 'saves a list of tiles' do
      tiles = make_tiles 10
            @loader.save_tiles tiles
      ret_tiles = @loader.load_tiles
      tiles.length.should equal ret_tiles.length
    end
  end

  describe '#save_ship_design' do
    it 'saves a test ship design' do
      design = [Coordinate.new(5, 4) ,Coordinate.new(1,1), Coordinate.new(3,3)]
      definition = ShipDefinition.new(design, Coordinate.new(1,1))
      @loader.save_ship_design(10, definition)
      ret_ship = @loader.load_ship_design 10
      ret_ship.center.should == definition.center
    end
  end
end

def make_tiles(num)
  tile_array = []
  num.times {|x| tile_array << ShipTile.new(Coordinate.new(x,x), nil, nil, nil, nil)}
  tile_array
end