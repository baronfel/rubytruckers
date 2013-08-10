require_relative 'trucker_state'

class TruckerMain

  attr_accessor :state

  def initialize(*player_names)
    @state = TruckerState.new player_names
  end

  def init_board
    # code here
  end

  def processTurn
    # code here
  end

  def display_score
    # code here
  end

end

x = TruckerMain.new('Peter', 'Chet')

x.init_board
while x.state != :end
  x.processTurn
end
x.display_score

# Initialize boards for each player, need to do this from the round 1 pattern
  # inflate designs
# Load and shuffle the tile sets
# Start the Build phase
# resolve ship designs
# start the explore phase
# score results of explore phase


module TruckerGameStage
  :init_truckers
  :construct
  :explore
  :score
  :end_truckers
end
