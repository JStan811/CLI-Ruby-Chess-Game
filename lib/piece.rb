# frozen_string_literal: true

# represents a chess piece
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

  # this is currently only used by king and knight, maybe it would be better
  # placed in both of those rather than here?
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
