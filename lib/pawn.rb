# frozen_string_literal: true

# This class is used to create Pawn pieces and contains their movement rules
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
    white_destinations << up1_cell_if_valid(starting_cell, board_state)
    white_destinations << up1_left1_cell_if_valid(starting_cell, board_state)
    white_destinations << up1_right1_cell_if_valid(starting_cell, board_state)
    white_destinations << up2_cell_if_valid(starting_cell, board_state)
    white_destinations.delete nil
    white_destinations
  end

  def up1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row + 1][column] if valid_forward_position?(row + 1, column, board_state)
  end

  def up1_left1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row + 1][column - 1] if valid_diagonal_position?(row + 1, column - 1, board_state)
  end

  def up1_right1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row + 1][column + 1] if valid_diagonal_position?(row + 1, column + 1, board_state)
  end

  def up2_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row + 2][column] if white_valid_double_forward_position?(row + 2, column, board_state)
  end

  def black_pawn_available_destinations(starting_cell, board_state)
    black_destinations = []
    black_destinations << down1_cell_if_valid(starting_cell, board_state)
    black_destinations << down1_left1_cell_if_valid(starting_cell, board_state)
    black_destinations << down1_right1_cell_if_valid(starting_cell, board_state)
    black_destinations << down2_cell_if_valid(starting_cell, board_state)
    black_destinations.delete nil
    black_destinations
  end

  def down1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row - 1][column] if valid_forward_position?(row - 1, column, board_state)
  end

  def down1_left1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row - 1][column - 1] if valid_diagonal_position?(row - 1, column - 1, board_state)
  end

  def down1_right1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row - 1][column + 1] if valid_diagonal_position?(row - 1, column + 1, board_state)
  end

  def down2_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row - 2][column] if black_valid_double_forward_position?(row - 2, column, board_state)
  end

  def valid_forward_position?(row, column, board_state)
    if row.negative? || row > 7 || column.negative? || column > 7
      false
    else
      board_state[row][column].piece.nil?
    end
  end

  def valid_diagonal_position?(row, column, board_state)
    if row.negative? || row > 7 || column.negative? || column > 7
      false
    elsif board_state[row][column].piece.nil?
      false
    else
      board_state[row][column].piece.owner != @owner
    end
  end

  def white_valid_double_forward_position?(row, column, board_state)
    return false if row - 2 != 1

    board_state[row - 1][column].piece.nil? && board_state[row][column].piece.nil?
  end

  def black_valid_double_forward_position?(row, column, board_state)
    return false if row + 2 != 6

    board_state[row + 1][column].piece.nil? && board_state[row][column].piece.nil?
  end

  def determine_symbol(color)
    case color
    when 'White' then "\u2659".encode('utf-8')
    when 'Black' then "\u265F".encode('utf-8')
    end
  end
end
