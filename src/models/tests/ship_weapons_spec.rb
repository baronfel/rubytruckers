require 'rspec'
require_relative '../ship_instance'
require_relative '../../util/loader'
require_relative '../ship_tile'
require_relative '../tile_side'

describe 'ship weapons' do

  before(:each) do
    @ship =  ShipInstance.new(Loader.new(nil, '../../../assets/').load_ship_design(1))
  end

  it 'should return the power of the installed basic weapons' do
    #add a weapon tile!
    @ship.put_tile!(ShipTile.new(SingleCannon.new(),nil,nil,nil), Coordinate.new(6,6))
    @ship.min_weapons_power.should == 1
    @ship.potential_weapons_power.should == 1
  end

  it 'should return a max power and min power correctly' do
    #add a weapon tile!
    @ship.put_tile!(ShipTile.new(DoubleCannon.new(),nil,nil,nil), Coordinate.new(6,7))
    @ship.min_weapons_power.should == 0
    @ship.potential_weapons_power.should == 2
  end

  it 'should return a max power and min power for multi-gun scenarios correctly' do
    #add a weapon tile!
    @ship.put_tile!(ShipTile.new(SingleCannon.new(),nil,nil,nil), Coordinate.new(6,7))
    @ship.put_tile!(ShipTile.new(DoubleCannon.new(),nil,nil,nil), Coordinate.new(6,8))
    @ship.min_weapons_power.should == 1
    @ship.potential_weapons_power.should == 3
  end

  it 'should return a max power and min power for multi-gun, multi directional scenario correctly' do
    #add a weapon tile!
    @ship.put_tile!(ShipTile.new(nil,SingleCannon.new(),nil,nil), Coordinate.new(6,7))
    @ship.put_tile!(ShipTile.new(DoubleCannon.new(),nil,nil,nil), Coordinate.new(6,8))
    @ship.min_weapons_power.should == 0.5
    @ship.potential_weapons_power.should == 2.5
  end
end