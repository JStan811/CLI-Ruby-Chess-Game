# frozen_string_literal: true

# represents single cell on a chess board
class Cell
  def initialize(position, piece = nil)
    @position = position
    @piece = piece
  end

  attr_reader :position, :piece

  def row
    @position[0]
  end

  def column
    @position[1]
  end

  def place_piece(piece)
    @piece = piece
  end

  def remove_piece
    @piece = nil
  end
end
