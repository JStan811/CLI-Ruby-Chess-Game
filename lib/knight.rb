# frozen_string_literal: true

# This class is used to create Knight pieces and contains their movement rules
class Knight < Piece
  # rubocop: disable Metrics/AbcSize
  # rubocop: disable Metrics/MethodLength
  def available_destinations(starting_cell, board_state)
    available_destinations = []
    available_destinations << down2_right1_cell_if_valid(starting_cell, board_state)
    available_destinations << down1_right2_cell_if_valid(starting_cell, board_state)
    available_destinations << up1_right2_cell_if_valid(starting_cell, board_state)
    available_destinations << up2_right1_cell_if_valid(starting_cell, board_state)
    available_destinations << up2_left1_cell_if_valid(starting_cell, board_state)
    available_destinations << up1_left2_cell_if_valid(starting_cell, board_state)
    available_destinations << down1_left2_cell_if_valid(starting_cell, board_state)
    available_destinations << down2_left1_cell_if_valid(starting_cell, board_state)
    available_destinations.delete nil
    available_destinations
  end
  # rubocop: enable Metrics/AbcSize
  # rubocop: enable Metrics/MethodLength

  private

  def down2_right1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row - 2][column + 1] if valid_position?(row - 2, column + 1, board_state)
  end

  def down1_right2_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row - 1][column + 2] if valid_position?(row - 1, column + 2, board_state)
  end

  def up1_right2_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row + 1][column + 2] if valid_position?(row + 1, column + 2, board_state)
  end

  def up2_right1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row + 2][column + 1] if valid_position?(row + 2, column + 1, board_state)
  end

  def up2_left1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row + 2][column - 1] if valid_position?(row + 2, column - 1, board_state)
  end

  def up1_left2_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row + 1][column - 2] if valid_position?(row + 1, column - 2, board_state)
  end

  def down1_left2_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row - 1][column - 2] if valid_position?(row - 1, column - 2, board_state)
  end

  def down2_left1_cell_if_valid(starting_cell, board_state)
    row = starting_cell.row
    column = starting_cell.column
    board_state[row - 2][column - 1] if valid_position?(row - 2, column - 1, board_state)
  end

  def determine_symbol(color)
    case color
    when 'White' then "\u2658".encode('utf-8')
    when 'Black' then "\u265E".encode('utf-8')
    end
  end
end
