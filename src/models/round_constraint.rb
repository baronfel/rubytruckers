class RoundConstraint
  attr_reader :round_number
  attr_reader :arrival_awards
  attr_reader :first_arrival_bonus
  attr_reader :ship_spacing
  attr_reader :card_piles

  def initialize(round_number, arrival_awards, first_arrival_bonus, ship_spacing, card_piles)
    @round_number = round_number
    @arrival_awards = arrival_awards
    @first_arrival_bonus = first_arrival_bonus
    @ship_spacing = ship_spacing
    @card_piles = card_piles
  end
end