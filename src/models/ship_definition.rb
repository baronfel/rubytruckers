class ShipDefinition
  attr_accessor(:shape)
  attr_accessor(:center)
  def initialize(shape, center)
    @center = center
    @shape = shape
  end
end