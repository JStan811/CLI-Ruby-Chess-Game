# frozen_string_literal: true

# This class is used to create King pieces and contains their movement rules
class King < Piece
  # rubocop: disable Metrics/AbcSize
  # rubocop: disable Metrics/MethodLength
  def available_destinations(starting_cell, board_state)
    available_destinations = []
    available_destinations << down1_cell_if_valid(starting_cell, board_state)
    available_destinations << down1_right1_cell_if_valid(starting_cell, board_state)
    available_destinations << right1_cell_if_valid(starting_cell, board_state)
    available_destinations << up1_right1_cell_if_valid(starting_cell, board_state)
    available_destinations << up1_cell_if_valid(starting_cell, board_state)
    available_destinations << up1_left1_cell_if_valid(starting_cell, board_state)
    available_destinations << left1_cell_if_valid(starting_cell, board_state)
    available_destinations << down1_left1_cell_if_valid(starting_cell, board_state)
    available_destinations.delete nil
    available_destinations
  end
  # rubocop: enable Metrics/AbcSize
  # rubocop: enable Metrics/MethodLength

  private

  def down1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row - 1][column] if valid_position?(row - 1, column, board_state)
  end

  def down1_right1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row - 1][column + 1] if valid_position?(row - 1, column + 1, board_state)
  end

  def right1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row,][column + 1] if valid_position?(row, column + 1, board_state)
  end

  def up1_right1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row + 1][column + 1] if valid_position?(row + 1, column + 1, board_state)
  end

  def up1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row + 1][column] if valid_position?(row + 1, column, board_state)
  end

  def up1_left1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row + 1][column - 1] if valid_position?(row + 1, column - 1, board_state)
  end

  def left1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row][column - 1] if valid_position?(row, column - 1, board_state)
  end

  def down1_left1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row - 1][column - 1] if valid_position?(row - 1, column - 1, board_state)
  end

  def determine_symbol(color)
    case color
    when 'White' then "\u2654".encode('utf-8')
    when 'Black' then "\u265A".encode('utf-8')
    end
  end
end
