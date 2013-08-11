require_relative 'loader'
require_relative '../../src/models/ship_definition'
require_relative '../../src/models/coordinate'
require_relative '../../src/models/round_constraint'

class ShipLayoutCreator

  def create_round_one_design
    design = ShipDefinition.new([], Coordinate.new(7,7))
    design.shape.concat [Coordinate.new(7,5)]
    design.shape.concat [Coordinate.new(6,6),Coordinate.new(7,6),Coordinate.new(8,6)]
    design.shape.concat [Coordinate.new(5,7),Coordinate.new(6,7),Coordinate.new(7,7),Coordinate.new(8,7),Coordinate.new(9,7)]
    design.shape.concat [Coordinate.new(5,8),Coordinate.new(6,8),Coordinate.new(7,8),Coordinate.new(8,8),Coordinate.new(9,8)]
    design.shape.concat [Coordinate.new(5,9),Coordinate.new(6,9),Coordinate.new(8,9),Coordinate.new(9,9)]

    loader = Loader.new(nil, '../../assets/')
    loader.save_ship_design(1, design)
  end

  def create_round_two_design
    design = ShipDefinition.new([], Coordinate.new(7,7))
    design.shape.push Coordinate.new(7,4)
    design.shape.concat [Coordinate.new(6,5),Coordinate.new(7,5),Coordinate.new(8,5)]
    (5..9).each { |x| design.shape.push Coordinate.new(x,6)}
    (5..9).each { |x| design.shape.push Coordinate.new(x,7)}
    (4..10).each { |x| design.shape.push Coordinate.new(x,8)}
    (3..6).each { |x| design.shape.push Coordinate.new(x,9)}; (8..10).each {|x| design.shape.push Coordinate.new(x,9)};

    loader = Loader.new(nil, '../../assets/')
    loader.save_ship_design(2, design)
  end

  def create_round_three_design
    design = ShipDefinition.new([], Coordinate.new(7,7))
    design.shape.push Coordinate.new(7,4)
    design.shape.concat [Coordinate.new(6,5),Coordinate.new(7,5),Coordinate.new(8,5)]
    design.shape.concat [Coordinate.new(3,6),Coordinate.new(5,6),Coordinate.new(6,6),Coordinate.new(7,6),Coordinate.new(8,6),Coordinate.new(9,6),Coordinate.new(11,6)]
    (3..11).each {|x| design.shape.concat [Coordinate.new(x,7),Coordinate.new(x,8)]}
    design.shape.concat [Coordinate.new(3,9),Coordinate.new(4,9),Coordinate.new(6,9),Coordinate.new(7,9),Coordinate.new(8,9),Coordinate.new(10,9),Coordinate.new(11,9)]

    loader = Loader.new(nil, '../../assets/')
    loader.save_ship_design(3, design)
  end

  def create_round_one_constraint
    round_1 = RoundConstraint.new(
        1, [4,3,2,1], 4, 2, [1 => 3]
    )
    loader = Loader.new(nil, '../../assets/')
    loader.save_round_constraint(1, round_1)
  end

  def create_round_two_constraint
    round_2 = RoundConstraint.new(
        2, [5,4,3,2], 8, 2, [1 => 1, 2=>2]
    )
    loader = Loader.new(nil, '../../assets/')
    loader.save_round_constraint(2, round_2)
  end

  def create_round_three_constraint
    round_3 = RoundConstraint.new(
        3, [6,5,4,3], 12, 3, [1 => 1, 2 => 1, 3 => 2]
    )
    loader = Loader.new(nil, '../../assets/')
    loader.save_round_constraint(3, round_3)
  end
end

=begin
creator = ShipLayoutCreator.new
creator.create_round_one_constraint
creator.create_round_two_constraint
creator.create_round_three_constraint
=end

