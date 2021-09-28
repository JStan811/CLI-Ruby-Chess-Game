# frozen_string_literal: true

# represents a chess piece
class Piece
  def initialize(color, type)
    @color = color
    @type = type
  end

  attr_reader :color, :type
end
