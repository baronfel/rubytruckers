require_relative 'loader'
require_relative '../../src/models/card'
require_relative '../../src/models/ship_instance'
require_relative '../../src/models/ship_tile'

class CardsCreator

  def special_cards
    [SabotageCard.new(3),StardustCard.new(1),StardustCard.new(2), EpidemicCard.new(2), EpidemicCard.new(3)]
  end

  def combat_zone_cards
    [
        CombatZoneCard.new(1, [[:crew,[:days, 3]],[:engines, [:crew, 2]],[:weapons, [:shots,[[:small, :south], [:large, :south]]]]]),
        CombatZoneCard.new(2, [[:weapons,[:days,4]],[:engines,[:cargo,3]],[:crew,[:shots,[[:small,:east],[:small, :west],[:small, :north],[:large, :south]]]]]),
        CombatZoneCard.new(3,[[:crew,[:cargo,4]],[:weapons,[:crew,4]],[:engines,[:shots,[[:small,:east],[:small,:west],[:small,:north],[:small,:north],[:large,:south],[:large,:north]]]]])
    ]
  end

  def smugglers_cards
    [
      SmugglersCard.new(1, 1, 4, 2, [:yellow, :green, :blue]),
      SmugglersCard.new(2,1,8,3,[:red, :yellow, :yellow]),
      SmugglersCard.new(3,2,9,4,[:red,:red,:yellow,:yellow,:green])
    ]
  end

  def slavers_cards
    [
      SlaversCard.new(1, 1,6,3,5),
      SlaversCard.new(2,2,7,4,8),
      SlaversCard.new(3,2,8,5,10)
    ]
  end

  def pirates_cards
    [
      PiratesCard.new(1,1,5,4,[[:small,:north],[:large,:north],[:small,:north]]),
      PiratesCard.new(2,2,6,7,[[:large,:north],[:small,:north],[:large,:north]]),
      PiratesCard.new(3,2,10,12,[[:small,:west],[:large,:north],[:small,:north],[:large,:north],[:small,:east]])
    ]
  end

  def open_space_cards
    cards = []
    4.times{cards.push OpenSpaceCard.new(1)}
    3.times{cards.push OpenSpaceCard.new(2)}
    3.times{cards.push OpenSpaceCard.new(3)}
    cards
  end

  def planets_cards
    [
      PlanetCard.new(1,2, [[:red, :red],[:red,:blue,:blue],[:yellow]]),
      PlanetCard.new(1,3,[[:yellow, :green,:blue,:blue],[:yellow, :yellow]]),
      PlanetCard.new(1,2,[[:green,:green],[:yellow],[:blue,:blue,:blue]]),
      PlanetCard.new(1,3,[[:red,:green,:blue,:blue,:blue],[:red,:yellow,:blue],[:red,:blue,:blue,:blue],[:red,:green]]),
      PlanetCard.new(2,2,[[:red,:yellow],[:yellow,:green,:blue],[:green,:green],[:yellow]]),
      PlanetCard.new(2,3,[[:red,:red],[:green,:green,:green,:green]]),
      PlanetCard.new(2,3,[[:green,:green,:green,:green],[:yellow,:yellow],[:blue,:blue,:blue]]),
      PlanetCard.new(2,4,[[:red,:red,:red,:yellow],[:red,:red,:green,:green],[:red,:blue,:blue,:blue,:blue]]),
      PlanetCard.new(3,1,[[:green,:blue,:blue,:blue,:blue],[:yellow,:blue]]),
      PlanetCard.new(3,3,[[:yellow,:yellow,:yellow,:yellow,:yellow],[:red,:yellow,:yellow],[:red,:red]]),
      PlanetCard.new(3,2,[[:red,:yellow,:blue],[:red,:green,:blue,:blue],[:red,:blue,:blue,:blue,:blue]])
    ]
  end

  def abandoned_ship_cards
    [
      AbandonedShipCard.new(1,1,2,3),
      AbandonedShipCard.new(1,1,3,4),
      AbandonedShipCard.new(2,1,4,6),
      AbandonedShipCard.new(2,2,5,8),
      AbandonedShipCard.new(3,2,7,11),
      AbandonedShipCard.new(3,2,6,10)
    ]
  end

  def abandoned_station_cards
    [
      AbandonedStationCard.new(1,1,5,[:yellow,:green]),
      AbandonedStationCard.new(1,1,6,[:red,:red]),
      AbandonedStationCard.new(2,1,7,[:red,:yellow]),
      AbandonedStationCard.new(2,2,8,[:yellow,:yellow,:green]),
      AbandonedStationCard.new(3,2,9,[:red,:yellow,:green,:blue]),
      AbandonedStationCard.new(3,2,10,[:yellow,:yellow,:green,:green])
    ]
  end

  def meteor_cards
    [
        MeteoricSwarmCard.new(1,[:small,:north],[:small,:south],[:small,:west],[:small,:east]),
        MeteoricSwarmCard.new(1, [:large,:north],[:small,:north],[:large,:north]),
        MeteoricSwarmCard.new(1, [:large,:north],[:small,:west],[:small,:east]),
        MeteoricSwarmCard.new(2, [:small,:north],[:large,:north],[:small,:west],[:large,:west],[:small,:west]),
        MeteoricSwarmCard.new(2,[:small,:north],[:small,:north],[:small,:south],[:small,:south],[:small,:west],[:small,:east]),
        MeteoricSwarmCard.new(2,[:small,:north],[:large,:north],[:small,:east],[:large,:east],[:small,:east]),
        MeteoricSwarmCard.new(3, [:large,:east],[:small,:east],[:large,:east],[:small,:north],[:small,:south]),
        MeteoricSwarmCard.new(3,[:large,:north],[:small,:south],[:small,:south],[:small,:west],[:small,:west],[:small,:east],[:small,:east]),
        MeteoricSwarmCard.new(3,[:large,:west],[:small,:west],[:large,:west],[:small,:north],[:small,:south]),
    ]
  end

  def write_cards
    cards = special_cards | combat_zone_cards | smugglers_cards | slavers_cards | pirates_cards | open_space_cards | planets_cards | abandoned_ship_cards | abandoned_station_cards | meteor_cards
    loader = Loader.new(nil, nil, '../../assets/cardList.cds')
    loader.save_cards cards
  end
end

=begin
creator = CardsCreator.new
creator.write_cards
=end