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
  def can_execute(ship)
    true
  end

  def execute(ship)
    # TODO: need to move ship forward, something using ship.engine_power
  end
end

class AbandonedShipCard < Card
  def initialize(round, day_cost, crew_cost, cash_reward)
    super(round, day_cost)
    @crew_cost = crew_cost
    @cash_reward = cash_reward
  end

  def can_execute(ship)
    ship.crew_count! > @crew_cost
  end


  def execute(ship)
    ship.crew_count! -= @crewCost
    # TODO: need to add coins to the controlling player
    # TODO: need to penalize ship the number of days
  end
end