# frozen_string_literal: true

# represents an entity playing the game. Currently this is either a Player 1
# human or Player 2 human.
class Player
  def initialize(name, color)
    @name = name
    @color = color
  end

  attr_reader :name, :color
end
