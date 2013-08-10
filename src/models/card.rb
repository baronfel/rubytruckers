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
    @meteors.each { |size,direction| fire_meteors(size, direction, ship)}
  end

  def fire_meteors(size, direction, ship)
    # the column/row to hit
    num = Random.rand(0..11)
    target_tile = ship.get_outer_tile(num, direction)
    if target_tile.nil?
      return
    end

    # if we have a tile that was hit, have to blow it up if it has open connectors and we are small, or if we are big
    if (target_tile.get_side(direction).num_connectors != 0 && size == :small) || size == :big
      ship.remove_tile!(target_tile.coord)
      ship.validate_connected_tiles!
    end
  end
end

class PlanetCard < Card
  # @param [Array[Array[Symbol]] cargo_by_planet A list of colors of cargo for each planet, so a list of lists.
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

class PirateCard < Card
  # @param [Integer] weapons_prereq The minimum weapons strength a ship must have to beat the pirates.
  # @param [Integer] cash_reward The reward for defeating the pirates
  # @param [Object] shots A list of Big or Small shots with matching orientations
  def initialize(round, day_cost, weapons_prereq, cash_reward, *shots)
    super(round, day_cost)
    @weapons_prereq = weapons_prereq
    @cash_reward = cash_reward
    @shots = shots
  end

  def can_execute?(ship)
    true
  end

  def can_survive?(ship)
    ship.weapons_power! >= @weapons_prereq
  end

  def execute(ship)
    if ship.weapons_power! > @weapons_prereq
      # TODO: award cash somehow
    elsif ship.weapons_power! == @weapons_prereq
      # nothing happens in the case of a tie
      return
    else
      @shots.each{|size, direction| fire_shot(size, direction, ship)}
    end
  end

  def fire_shot(size, direction, ship)
    # the column/row to hit
    num = Random.rand(0..11)
    target_tile = ship.get_outer_tile(num, direction)
    return if target_tile.nil?

    # if we have a tile that was hit, have to blow it up if it has open connectors and we are small, or if we are big
    if (target_tile.get_side(direction).num_connectors != 0 && size == :small) || size == :big
      ship.remove_tile!(target_tile.coord)
      ship.validate_connected_tiles!
    end
  end
end

class SmugglersCard < Card
  # @param [Integer] weapons_prereq The minimum weapons strength a ship must have to beat the pirates.
  # @param [Integer] cargo_penalty The number of cargo you lose if the Smuggler beats you
  # @param [Array[Symbol]] cargo_reward A list of cargo you win if you beat the Smuggler.
  def initialize(round, day_cost, weapons_prereq, cargo_penalty, *cargo_reward)
    super(round, day_cost)
    @weapons_prereq = weapons_prereq
    @cargo_penalty = cargo_penalty
    @cargo_reward = cargo_reward
  end

  def can_execute?(ship)
    true
  end

  def can_survive?(ship)
    ship.weapons_power! >= @weapons_prereq
  end

  def execute(ship)
    if ship.weapons_power! > @weapons_prereq
      # TODO: award cargo somehow
    elsif ship.weapons_power! == @weapons_prereq
      # nothing happens in the case of a tie
      return
    else
      # TODO: lose @cargo_penalty number of cargo at choice
    end
  end
end

class SlaversCard < Card
  def initialize(round, day_cost, weapons_prereq, crew_cost, cash_reward)
    super(round, day_cost)
    @weapons_prereq = weapons_prereq
    @crew_cost = crew_cost
    @cash_reward = cash_reward
  end

  def can_execute?(ship)
    true
  end

  def can_survive?(ship)
    ship.weapons_power! >= @weapons_prereq
  end

  def execute(ship)
    if ship.weapons_power! > @weapons_prereq
      # TODO: add cash reward somehow
    elsif ship.weapons_power! == @weapons_prereq
      return
    else
      ship.crew_count -= @crew_cost
    end
  end
end

class CombatZoneCard < Card
  def initialize(round, day_cost, steps, *ships)
    super(round, day_cost)
    @steps = steps
    @ships = ships
  end

  def can_execute?
    true
  end

  def execute
    # foreach step, take the key and compare across all ships for the ship with the least of whatever that key is.
    # for this ship, apply the matching effect to the original key.

    @steps.each {|comparer, effect|
      ship = nil
      case comparer
        when :crew then ship = @ships.sort{|x| x.crew_count}[0]
        when :weapons then ship = @ships.sort{|x| x.weapons_power!}[0]
        when :engines then ship = @ships.sort{|x| x.engine_power!}[0]
      end

      case effect[0]
        when :days then return # TODO: make ship go back!
        when :crew then ship.crew_count -= effect[1]
        when :cargo then return # TODO: make cargo loss happen
        when :shots then effect[1].each { |size, direction| fire_shot(size, direction, ship)}
      end
    }
  end

  def fire_shot(size, direction, ship)
    # the column/row to hit
    num = Random.rand(0..11)
    target_tile = ship.get_outer_tile(num, direction)
    return if target_tile.nil?

    # if we have a tile that was hit, have to blow it up if it has open connectors and we are small, or if we are big
    if (target_tile.get_side(direction).num_connectors != 0 && size == :small) || size == :big
      ship.remove_tile!(target_tile.coord)
      ship.validate_connected_tiles!
    end
  end
end

class SabotageCard < Card
  def initialize(round, day_cost, *ships)
    super(round, day_cost)
    @ships = ships
  end

  def can_execute
    true
  end

  def execute
    # for this card, the ship with the least crew loses one ship component at random by rolling (max 3 times until one is hit)
    ship = @ships.sort {|x| x.crew_count}[0]
    success = false
    (1..3).each {
      if success then
        next
      end
      coord = Coordinate.new(Random.rand(1..12), Random.rand(1..12))
      if ship.has_tile? coord
        ship.remove_tile! coord
        ship.validate_connected_tiles!
        success = true
      end
    }
  end
end

class StardustCard < Card
  def initialize(round, day_cost)
    super(round, day_cost)
  end

  def can_execute?(ship)
    true
  end

  def execute(ship)
    @days_to_lose = ship.exposed_connectors.length
    # TODO : Lose this many days
  end
end

class EpidemicCard < Card
  def initialize(round)
    super(round, 0)
  end

  def can_execute?(ship)
    ship.tiles.find_all{|x| x.contents.find_all{|y| y.is_a? Habitat && y.is_occupied?}.length > 0}.length > 0
  end

  def execute(ship)
    # fetch the habitats
    occupied_habitat_tiles = ship.tiles.find_all{|x| x.contents.find_all{|y| y.is_a? Habitat && y.is_occupied?}.length > 0}

    # find the pairs
    occupied_habitat_tiles.collect{|x| [x, ship.get_adjacent_tiles(x.coord).find_all{|y| y.contents.find_all{|z| z.is_a? Habitat && z.is_occupied?}}]}
    unique_tiles = occupied_habitat_tiles.flatten(1).uniq {|x| x.coord}

    # foreach tile, remove a person!
    unique_tiles.each{|x| x.contents.select!{|y| y.is_a? Habitat && y.is_occupied?}.each{|z| z.beings -= 1}}
  end
end