class Habitat
  attr_accessor(:beings)

  def initialize(beings)
    @beings = beings
  end

  def is_occupied?
    @beings.length > 0
  end
end

class AlienHabitat
  attr_reader(:color)

  def initialize(color)
    @color = color
  end
end

class Battery
  attr_accessor(:batteries_remaining)

  def initialize(batteries)
    @batteries_remaining = batteries
  end
end

class Container
  attr_reader(:allowed_colors)
  attr_accessor(:occupied)

  def initialize(allowed_colors)
    @allowed_colors = allowed_colors
    @occupied = true
  end
end

class Shield
  attr_reader(:orientation)

  def initialize(orientation)
    @orientation = orientation
  end

  def rotate_clockwise
    Shield.new(clockwise)
  end

  def rotate_clockwise!
    @orientation = clockwise
  end

  def rotate_counter
    Shield.new(counter)
  end

  def rotate_counter!
    @orientation = counter
  end

  def clockwise
    case @orientation
      when :north
        return :east
      when :east
        return :south
      when :south
        return :west
      else
        return :north
    end
  end

  def counter
    case @orientation
      when :north
        return :west
      when :east
        return :north
      when :south
        return :east
      else
        return :south
    end
  end
end