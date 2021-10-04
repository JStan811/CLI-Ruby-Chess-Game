# frozen_string_literal: true

# represents someone playing the game. Could be a human or computer
class Player
  def initialize(name, color)
    @name = name
    @color = color
  end

  attr_reader :name
end
