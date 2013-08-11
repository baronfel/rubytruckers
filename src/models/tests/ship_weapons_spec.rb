require 'rspec'
require_relative '../ship_instance'
require_relative '../../util/loader'
require_relative '../ship_tile'
require_relative '../tile_side'

describe 'ship weapons' do

  it 'should return the power of the installed basic weapons' do
    ship = ShipInstance.new(Loader.new(nil, '../../../assets/').load_ship_design(1))
    #add a weapon tile!
    ship.put_tile!(ShipTile.new(Coordinate.new(2,2), nil,nil,nil,SingleCannon.new()), Coordinate.new(2,2))
    ship.min_weapons_power.should == 1
    ship.potential_weapons_power.should == 1
  end
end