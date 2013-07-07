class TruckerMain
  def initialize(num_players)
    @num_players = num_players
  end

  def get_players
    @num_players
  end
end

x = TruckerMain.new(2)
puts x.get_players


# Initialize boards for each player, need to do this from the round 1 pattern
  # inflate designs
# Load and shuffle the tile sets
# Start the Build phase
# resolve ship designs
# start the explore phase
# score results of explore phase