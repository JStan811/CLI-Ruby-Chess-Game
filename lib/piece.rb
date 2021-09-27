# frozen_string_literal: true

# represents a chess piece
class Piece
  def initialize(type, color)
    @type = type
    @color = color
  end

  attr_reader :type, :color
end
