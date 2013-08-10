require_relative 'trucker_state'

class TruckerMain

  attr_accessor :state

  def initialize(num_players)
    @state = TruckerState.new num_players
  end

end

x = TruckerMain.new(2)
puts x.num_players
puts x.game_stage
puts x.round_number


# Initialize boards for each player, need to do this from the round 1 pattern
  # inflate designs
# Load and shuffle the tile sets
# Start the Build phase
# resolve ship designs
# start the explore phase
# score results of explore phase


module TruckerGameStage
  :init
  :construct
  :explore
  :score
end
