# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  def available_destinations(starting_cell, board_state)
    case @color
    when 'White'
      white_pawn_available_destinations(starting_cell, board_state)
    when 'Black'
      black_pawn_available_destinations(starting_cell, board_state)
    end
  end

  private

  def white_pawn_available_destinations(starting_cell, board_state)
    white_destinations = []
    r = starting_cell.position[0]
    c = starting_cell.position[1]
    white_destinations << board_state[r + 1][c] if valid_forward_position?(r + 1, c, board_state)
    white_destinations << board_state[r + 1][c - 1] if valid_diagonal_position(r + 1, c - 1, board_state)
    white_destinations << board_state[r + 1][c + 1] if valid_diagonal_position(r + 1, c + 1, board_state)
    white_destinations << board_state[r + 2][c] if white_valid_double_forward_position?(r + 2, c, board_state)
    white_destinations
  end

  def black_pawn_available_destinations(starting_cell, board_state)
    black_destinations = []
    r = starting_cell.position[0]
    c = starting_cell.position[1]
    black_destinations << board_state[r - 1][c] if valid_forward_position?(r - 1, c, board_state)
    black_destinations << board_state[r - 1][c - 1] if valid_diagonal_position(r - 1, c - 1, board_state)
    black_destinations << board_state[r - 1][c + 1] if valid_diagonal_position(r - 1, c + 1, board_state)
    black_destinations << board_state[r - 2][c] if black_valid_double_forward_position?(r - 2, c, board_state)
    black_destinations
  end

  def valid_forward_position?(row_index, column_index, board_state)
    if row_index.negative? || row_index > 7 || column_index.negative? || column_index > 7
      false
    else
      board_state[row_index][column_index].piece.nil?
    end
  end

  def white_valid_double_forward_position?(row_index, column_index, board_state)
    return false if row_index - 2 != 1

    board_state[row_index - 1][column_index].piece.nil? && board_state[row_index][column_index].piece.nil?
  end

  def black_valid_double_forward_position?(row_index, column_index, board_state)
    return false if row_index + 2 != 6

    board_state[row_index + 1][column_index].piece.nil? && board_state[row_index][column_index].piece.nil?
  end

  def valid_diagonal_position(row_index, column_index, board_state)
    if row_index.negative? || row_index > 7 || column_index.negative? || column_index > 7
      false
    elsif board_state[row_index][column_index].piece.nil?
      false
    else
      board_state[row_index][column_index].piece.owner != @owner
    end
  end

  def determine_symbol(color)
    case color
    when 'White' then "\u2659".encode('utf-8')
    when 'Black' then "\u265F".encode('utf-8')
    end
  end
end
