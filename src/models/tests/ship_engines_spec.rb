require 'rspec'
require_relative '../ship_instance'
require_relative '../../util/loader'
require_relative '../ship_tile'
require_relative '../tile_side'

describe 'ship engines' do

  before(:each) do
    @ship =  ShipInstance.new(Loader.new(nil, '../../../assets/').load_ship_design(1))
  end

  it 'should calculate standard engine power correctly' do
    @ship.put_tile!(ShipTile.new(nil,nil,SingleEngine.new(),nil), Coordinate.new(6,6))
    @ship.min_engine_power.should == 1
    @ship.potential_engine_power.should == 1
  end

  it 'should calculate mixed engine power correctly' do
    @ship.put_tile!(ShipTile.new(nil,nil,SingleEngine.new(),nil), Coordinate.new(6,6))
    @ship.put_tile!(ShipTile.new(nil,nil,DoubleEngine.new(),nil), Coordinate.new(6,7))
    @ship.min_engine_power.should == 1
    @ship.potential_engine_power.should == 3
  end

  it 'should calculate the engine! equal to min power right now' do
    @ship.put_tile!(ShipTile.new(nil,nil,SingleEngine.new(),nil), Coordinate.new(6,6))
    @ship.put_tile!(ShipTile.new(nil,nil,DoubleEngine.new(),nil), Coordinate.new(6,7))
    @ship.engine_power!.should == @ship.min_engine_power
  end
end