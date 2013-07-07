require_relative 'loader'
require_relative '../../src/models/ship_definition'
require_relative '../../src/models/coordinate'

class ShipLayoutCreator

  def create_round_one_design
    design = ShipDefinition.new([], Coordinate.new(7,7))
    design.shape << [Coordinate.new(7,5)]
    design.shape << [Coordinate.new(6,6),Coordinate.new(7,6),Coordinate.new(8,6)]
    design.shape << [Coordinate.new(5,7),Coordinate.new(6,7),Coordinate.new(7,7),Coordinate.new(8,7),Coordinate.new(9,7)]
    design.shape << [Coordinate.new(5,8),Coordinate.new(6,8),Coordinate.new(7,8),Coordinate.new(8,8),Coordinate.new(9,8)]
    design.shape << [Coordinate.new(5,9),Coordinate.new(6,9),Coordinate.new(8,9),Coordinate.new(9,9)]

    loader = Loader.new(nil, '../../assets/', nil)
    loader.save_ship_design(1, design)
  end

  def create_round_two_design
    design = ShipDefinition.new([], Coordinate.new(7,7))
    design.shape << [Coordinate.new(7,4)]
    design.shape << [Coordinate.new(6,5),Coordinate.new(7,5),Coordinate.new(8,5)]
    (5..9).each { |x| design.shape.push Coordinate.new(x,6)}
    (5..9).each { |x| design.shape.push Coordinate.new(x,7)}
    (4..10).each { |x| design.shape.push Coordinate.new(x,8)}
    (3..6).each { |x| design.shape.push Coordinate.new(x,9)}; (8..10).each {|x| design.shape.push Coordinate.new(x,9)};

    loader = Loader.new(nil, '../../assets/', nil)
    loader.save_ship_design(2, design)
  end

  def create_round_three_design
    design = ShipDefinition.new([], Coordinate.new(7,7))
    design.shape << [Coordinate.new(7,4)]
    design.shape << [Coordinate.new(6,5),Coordinate.new(7,5),Coordinate.new(8,5)]
    design.shape << [Coordinate.new(3,6),Coordinate.new(5,6),Coordinate.new(6,6),Coordinate.new(7,6),Coordinate.new(8,6),Coordinate.new(9,6),Coordinate.new(11,6)]
    (3..11).each {|x| design.shape << [Coordinate.new(x,7),Coordinate.new(x,8)]}
    design.shape << [Coordinate.new(3,9),Coordinate.new(4,9),Coordinate.new(6,9),Coordinate.new(7,9),Coordinate.new(8,9),Coordinate.new(10,9),Coordinate.new(11,9)]

    loader = Loader.new(nil, '../../assets/', nil)
    loader.save_ship_design(3, design)
  end
end

=begin
creator = ShipLayoutCreator.new
creator.create_round_one_design
creator.create_round_two_design
creator.create_round_three_design
=end