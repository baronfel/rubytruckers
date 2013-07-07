require_relative '../../src/models/ship_tile'
require_relative '../../src/models/ship_instance'

class Card

  attr_reader :round
  attr_reader :day_cost

  def initialize(round, day_cost)
    @round = round
    @day_cost = day_cost
  end
end

class OpenSpaceCard < Card
  def initialize(round, day_cost)
    super
  end

  # any ship can go forward
  def can_execute?(ship)
    true
  end

  def execute(ship)
    # TODO: need to move ship forward, something using ship.engine_power
  end
end

class AbandonedShipCard < Card
  # @param [Object] crew_cost The cost in crew members to comandeer this ship and get the salvage reward.
  # @param [Object] cash_reward The salvage reward for recovering this ship.
  def initialize(round, day_cost, crew_cost, cash_reward)
    super(round, day_cost)
    @crew_cost = crew_cost
    @cash_reward = cash_reward
  end

  def can_execute?(ship)
    ship.crew_count > @crew_cost
  end


  def execute(ship)
    ship.crew_count -= @crew_cost
    # TODO: need to add coins to the controlling player
    # TODO: need to penalize ship the number of days
  end
end

class AbandonedStationCard < Card
  # @param [Object] round
  # @param [Object] day_cost
  # @param [Object] crew_prereq Must have at least this many crew members to use this card.
  # @param [Object] cargo The list of colored cargo to take on board.
  def initialize(round, day_cost, crew_prereq, *cargo)
    super(round, day_cost)
    @crew_prereq = crew_prereq
    @cargo = cargo
  end

  def can_execute?(ship)
    ship.crew_count >= @crew_prereq
  end

  def execute(ship)
    # TODO: here we take the @cargo and have to put it in the ship somehow, with users figuring out where to put it.
  end
end

class MeteoricSwarmCard < Card
  # @param [Object] meteors A list of size/direction meteors!
  def initialize(round, day_cost, *meteors)
    super(round, day_cost)
    @meteors = meteors
  end

  def can_execute?(ship)
    true
  end

  def execute(ship)
    # don't forget shields
    @meteors.each { |size,direction|
      # the column/row to hit
      num = Random.rand(0..11)
      target_tile = ship.get_outer_tile(num, direction)
      if target_tile.nil?
        return
      end

      # if we have a tile that was hit, have to blow it up if it has open connectors and we are small, or if we are big
      if (target_tile.get_side(direction).num_connectors != 0 && size == :small) || size == :big
        ship.remove_tile(target_tile.coord)
        ship.validate_connected_tiles!
      end
    }
    # TODO: iterate over the list of meteors, which are a list of Size => orientation pairs.
  end
end

class PlanetCard < Card
  # @param [Object] cargo_by_planet A list of colors of cargo for each planet, so a list of lists.
  def initialize(round, day_cost, *cargo_by_planet)
    super(round, day_cost)
    @cargo_by_planet = cargo_by_planet
  end

  def can_execute?(ship)
    return true
  end

  def execute(ship)
    # TODO: here we take the @cargo and have to put it in the ship somehow, with users figuring out where to put it.
  end
end