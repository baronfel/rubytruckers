class TruckerState
  attr_accessor :num_players
  attr_accessor :game_stage
  attr_accessor :round_number

  def initialize(player_names)
      @num_players = player_names.count
      @game_stage = :init_truckers
      @round_number = 1
      @players = Hash[player_names.map{|name| [name, 0] }]
  end

  def get_score(player_name)
      @players[player_name]
  end

  def set_score(player_name, score)
    @players[player_name] = score
  end
end