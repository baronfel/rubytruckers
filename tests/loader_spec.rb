require_relative '../loader'
require_relative '../ship_tile'
require 'rspec'

describe Loader do

  before :each do
    @loader = Loader.new ('./test_tile_file.tls')
  end

  describe '#new' do
    it 'should be instance of Loader class' do
      @loader.should be_an_instance_of Loader
    end
  end

=begin
  describe '#load_tiles' do
    it 'loads tiles' do
      tiles = @loader.load_tiles
      tiles.length.should equal 100
    end
  end
=end

  describe '#save_tiles' do
    it 'saves a list of tiles' do
      tiles = make_tiles 10
            @loader.save_tiles tiles
      retTiles = @loader.load_tiles
      tiles.length.should equal retTiles.length
    end
  end
end

def make_tiles(num)
  tile_array = []
  num.times {|x| tile_array << ShipTile.new(Coordinate.new(x,x), nil, nil, nil, nil)}
  return tile_array
end