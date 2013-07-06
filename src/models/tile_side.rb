module TileSide
  def valid_orientation?(orientation)
    return false if self.respond_to?(:allowed_orientations) && !self.allowed_orientations.include?(orientation)
    true
  end

  def follows_rules?(other_side)
    return true if self.adjacent_tile_allowed? && other_side.adjacent_tile_allowed?
    false
  end

  def is_connected?(other_side)
    return false if (self.num_connectors == 0 || other_side.num_connectors == 0)
    return true if (self.num_connectors == other_side.num_connectors)
    return true if (self.num_connectors == -1 || other_side.num_connectors == -1)
    false
  end
end

class UniversalConnector
  include TileSide

  def num_connectors
    -1
  end

  def adjacent_tile_allowed?
    true
  end
end

class SingleConnector
  include TileSide

  def num_connectors
    1
  end

  def adjacent_tile_allowed?
    true
  end
end

class DoubleConnector
  include TileSide

  def num_connectors
    2
  end

  def adjacent_tile_allowed?
    true
  end
end

class BlankSide
  include TileSide

  def num_connectors
    0
  end

  def adjacent_tile_allowed?
    true
  end
end

class SingleCannon
  include TileSide

  def num_connectors
    0
  end

  def adjacent_tile_allowed?
    false
  end

  def gun_strength
    1
  end

  def require_batteries
    0
  end
end

class DoubleCannon
  include TileSide

  def num_connectors
    0
  end

  def adjacent_tile_allowed?
    false
  end

  def gun_strength
    2
  end

  def require_batteries
    1
  end
end

class SingleEngine
  include TileSide

  def allowed_orientations
    [:south]
  end

  def num_connectors
    0
  end

  def adjacent_tile_allowed?
    false
  end

  def engine_strength
    1
  end

  def require_batteries
    0
  end
end

class DoubleEngine
  include TileSide

  def allowed_orientations
    [:south]
  end

  def num_connectors
    0
  end

  def adjacent_tile_allowed?
    false
  end

  def engine_strength
    2
  end

  def require_batteries
    1
  end
end