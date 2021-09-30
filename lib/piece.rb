# frozen_string_literal: true

# represents a chess piece
class Piece
  def initialize(color, owner, cell)
    @color = color
    @owner = owner
    @cell = cell
    @symbol = determine_symbol(color)
  end

  attr_reader :color, :owner, :symbol

  def available_destinations
    raise NotImplementedError
  end

  private

  def determine_symbol
    raise NotImplementedError
  end
end
