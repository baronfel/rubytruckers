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