# frozen_string_literal: true

# This is a parent class for all the piece type classes (Rook, Pawn, etc.). No
# object is ever instantiated directly from Piece
class Piece
  def initialize(color, owner)
    @color = color
    @owner = owner
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

  def valid_position?(row_index, column_index, board_state)
    if row_index.negative? || row_index > 7 || column_index.negative? || column_index > 7
      false
    elsif board_state[row_index][column_index].piece.nil?
      true
    else
      board_state[row_index][column_index].piece.owner != @owner
    end
  end
end
