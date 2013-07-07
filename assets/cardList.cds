---
- !ruby/object:SabotageCard
  round: 3
  day_cost: 0
- !ruby/object:StardustCard
  round: 1
  day_cost: 0
- !ruby/object:StardustCard
  round: 2
  day_cost: 0
- !ruby/object:EpidemicCard
  round: 2
  day_cost: 0
- !ruby/object:EpidemicCard
  round: 3
  day_cost: 0
- !ruby/object:CombatZoneCard
  round: 1
  day_cost: 0
  steps:
  - - :crew
    - - :days
      - 3
  - - :engines
    - - :crew
      - 2
  - - :weapons
    - - :shots
      - - - :small
          - :south
        - - :large
          - :south
- !ruby/object:CombatZoneCard
  round: 2
  day_cost: 0
  steps:
  - - :weapons
    - - :days
      - 4
  - - :engines
    - - :cargo
      - 3
  - - :crew
    - - :shots
      - - - :small
          - :east
        - - :small
          - :west
        - - :small
          - :north
        - - :large
          - :south
- !ruby/object:CombatZoneCard
  round: 3
  day_cost: 0
  steps:
  - - :crew
    - - :cargo
      - 4
  - - :weapons
    - - :crew
      - 4
  - - :engines
    - - :shots
      - - - :small
          - :east
        - - :small
          - :west
        - - :small
          - :north
        - - :small
          - :north
        - - :large
          - :south
        - - :large
          - :north
- !ruby/object:SmugglersCard
  round: 1
  day_cost: 1
  weapons_prereq: 4
  cargo_penalty: 2
  cargo_reward:
  - - :yellow
    - :green
    - :blue
- !ruby/object:SmugglersCard
  round: 2
  day_cost: 1
  weapons_prereq: 8
  cargo_penalty: 3
  cargo_reward:
  - - :red
    - :yellow
    - :yellow
- !ruby/object:SmugglersCard
  round: 3
  day_cost: 2
  weapons_prereq: 9
  cargo_penalty: 4
  cargo_reward:
  - - :red
    - :red
    - :yellow
    - :yellow
    - :green
- !ruby/object:SlaversCard
  round: 1
  day_cost: 1
  weapons_prereq: 6
  crew_cost: 3
  cash_reward: 5
- !ruby/object:SlaversCard
  round: 2
  day_cost: 2
  weapons_prereq: 7
  crew_cost: 4
  cash_reward: 8
- !ruby/object:SlaversCard
  round: 3
  day_cost: 2
  weapons_prereq: 8
  crew_cost: 5
  cash_reward: 10
- !ruby/object:PiratesCard
  round: 1
  day_cost: 1
  weapons_prereq: 5
  cash_reward: 4
  shots:
  - - - :small
      - :north
    - - :large
      - :north
    - - :small
      - :north
- !ruby/object:PiratesCard
  round: 2
  day_cost: 2
  weapons_prereq: 6
  cash_reward: 7
  shots:
  - - - :large
      - :north
    - - :small
      - :north
    - - :large
      - :north
- !ruby/object:PiratesCard
  round: 3
  day_cost: 2
  weapons_prereq: 10
  cash_reward: 12
  shots:
  - - - :small
      - :west
    - - :large
      - :north
    - - :small
      - :north
    - - :large
      - :north
    - - :small
      - :east
- !ruby/object:OpenSpaceCard
  round: 1
  day_cost: 0
- !ruby/object:OpenSpaceCard
  round: 1
  day_cost: 0
- !ruby/object:OpenSpaceCard
  round: 1
  day_cost: 0
- !ruby/object:OpenSpaceCard
  round: 1
  day_cost: 0
- !ruby/object:OpenSpaceCard
  round: 2
  day_cost: 0
- !ruby/object:OpenSpaceCard
  round: 2
  day_cost: 0
- !ruby/object:OpenSpaceCard
  round: 2
  day_cost: 0
- !ruby/object:OpenSpaceCard
  round: 3
  day_cost: 0
- !ruby/object:OpenSpaceCard
  round: 3
  day_cost: 0
- !ruby/object:OpenSpaceCard
  round: 3
  day_cost: 0
- !ruby/object:PlanetCard
  round: 1
  day_cost: 2
  cargo_by_planet:
  - - - :red
      - :red
    - - :red
      - :blue
      - :blue
    - - :yellow
- !ruby/object:PlanetCard
  round: 1
  day_cost: 3
  cargo_by_planet:
  - - - :yellow
      - :green
      - :blue
      - :blue
    - - :yellow
      - :yellow
- !ruby/object:PlanetCard
  round: 1
  day_cost: 2
  cargo_by_planet:
  - - - :green
      - :green
    - - :yellow
    - - :blue
      - :blue
      - :blue
- !ruby/object:PlanetCard
  round: 1
  day_cost: 3
  cargo_by_planet:
  - - - :red
      - :green
      - :blue
      - :blue
      - :blue
    - - :red
      - :yellow
      - :blue
    - - :red
      - :blue
      - :blue
      - :blue
    - - :red
      - :green
- !ruby/object:PlanetCard
  round: 2
  day_cost: 2
  cargo_by_planet:
  - - - :red
      - :yellow
    - - :yellow
      - :green
      - :blue
    - - :green
      - :green
    - - :yellow
- !ruby/object:PlanetCard
  round: 2
  day_cost: 3
  cargo_by_planet:
  - - - :red
      - :red
    - - :green
      - :green
      - :green
      - :green
- !ruby/object:PlanetCard
  round: 2
  day_cost: 3
  cargo_by_planet:
  - - - :green
      - :green
      - :green
      - :green
    - - :yellow
      - :yellow
    - - :blue
      - :blue
      - :blue
- !ruby/object:PlanetCard
  round: 2
  day_cost: 4
  cargo_by_planet:
  - - - :red
      - :red
      - :red
      - :yellow
    - - :red
      - :red
      - :green
      - :green
    - - :red
      - :blue
      - :blue
      - :blue
      - :blue
- !ruby/object:PlanetCard
  round: 3
  day_cost: 1
  cargo_by_planet:
  - - - :green
      - :blue
      - :blue
      - :blue
      - :blue
    - - :yellow
      - :blue
- !ruby/object:PlanetCard
  round: 3
  day_cost: 3
  cargo_by_planet:
  - - - :yellow
      - :yellow
      - :yellow
      - :yellow
      - :yellow
    - - :red
      - :yellow
      - :yellow
    - - :red
      - :red
- !ruby/object:PlanetCard
  round: 3
  day_cost: 2
  cargo_by_planet:
  - - - :red
      - :yellow
      - :blue
    - - :red
      - :green
      - :blue
      - :blue
    - - :red
      - :blue
      - :blue
      - :blue
      - :blue
- !ruby/object:AbandonedShipCard
  round: 1
  day_cost: 1
  crew_cost: 2
  cash_reward: 3
- !ruby/object:AbandonedShipCard
  round: 1
  day_cost: 1
  crew_cost: 3
  cash_reward: 4
- !ruby/object:AbandonedShipCard
  round: 2
  day_cost: 1
  crew_cost: 4
  cash_reward: 6
- !ruby/object:AbandonedShipCard
  round: 2
  day_cost: 2
  crew_cost: 5
  cash_reward: 8
- !ruby/object:AbandonedShipCard
  round: 3
  day_cost: 2
  crew_cost: 7
  cash_reward: 11
- !ruby/object:AbandonedShipCard
  round: 3
  day_cost: 2
  crew_cost: 6
  cash_reward: 10
- !ruby/object:AbandonedStationCard
  round: 1
  day_cost: 1
  crew_prereq: 5
  cargo:
  - - :yellow
    - :green
- !ruby/object:AbandonedStationCard
  round: 1
  day_cost: 1
  crew_prereq: 6
  cargo:
  - - :red
    - :red
- !ruby/object:AbandonedStationCard
  round: 2
  day_cost: 1
  crew_prereq: 7
  cargo:
  - - :red
    - :yellow
- !ruby/object:AbandonedStationCard
  round: 2
  day_cost: 2
  crew_prereq: 8
  cargo:
  - - :yellow
    - :yellow
    - :green
- !ruby/object:AbandonedStationCard
  round: 3
  day_cost: 2
  crew_prereq: 9
  cargo:
  - - :red
    - :yellow
    - :green
    - :blue
- !ruby/object:AbandonedStationCard
  round: 3
  day_cost: 2
  crew_prereq: 10
  cargo:
  - - :yellow
    - :yellow
    - :green
    - :green
- !ruby/object:MeteoricSwarmCard
  round: 1
  day_cost: 0
  meteors:
  - - :small
    - :north
  - - :small
    - :south
  - - :small
    - :west
  - - :small
    - :east
- !ruby/object:MeteoricSwarmCard
  round: 1
  day_cost: 0
  meteors:
  - - :large
    - :north
  - - :small
    - :north
  - - :large
    - :north
- !ruby/object:MeteoricSwarmCard
  round: 1
  day_cost: 0
  meteors:
  - - :large
    - :north
  - - :small
    - :west
  - - :small
    - :east
- !ruby/object:MeteoricSwarmCard
  round: 2
  day_cost: 0
  meteors:
  - - :small
    - :north
  - - :large
    - :north
  - - :small
    - :west
  - - :large
    - :west
  - - :small
    - :west
- !ruby/object:MeteoricSwarmCard
  round: 2
  day_cost: 0
  meteors:
  - - :small
    - :north
  - - :small
    - :north
  - - :small
    - :south
  - - :small
    - :south
  - - :small
    - :west
  - - :small
    - :east
- !ruby/object:MeteoricSwarmCard
  round: 2
  day_cost: 0
  meteors:
  - - :small
    - :north
  - - :large
    - :north
  - - :small
    - :east
  - - :large
    - :east
  - - :small
    - :east
- !ruby/object:MeteoricSwarmCard
  round: 3
  day_cost: 0
  meteors:
  - - :large
    - :east
  - - :small
    - :east
  - - :large
    - :east
  - - :small
    - :north
  - - :small
    - :south
- !ruby/object:MeteoricSwarmCard
  round: 3
  day_cost: 0
  meteors:
  - - :large
    - :north
  - - :small
    - :south
  - - :small
    - :south
  - - :small
    - :west
  - - :small
    - :west
  - - :small
    - :east
  - - :small
    - :east
- !ruby/object:MeteoricSwarmCard
  round: 3
  day_cost: 0
  meteors:
  - - :large
    - :west
  - - :small
    - :west
  - - :large
    - :west
  - - :small
    - :north
  - - :small
    - :south
