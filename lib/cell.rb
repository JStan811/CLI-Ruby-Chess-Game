# frozen_string_literal: true

# represents single cell on a chess board
class Cell
  def initialize(position, piece = nil)
    @position = position
    @piece = piece
  end

  attr_reader :position, :piece

  def place_piece(piece)
    @piece = piece
  end
end
