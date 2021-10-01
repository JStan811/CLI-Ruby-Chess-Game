# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  def available_destinations(starting_cell, board_state)
    available_destinations = []
    r = starting_cell.position[0]
    c = starting_cell.position[1]
    available_destinations << board_state[r - 2][c + 1] if valid_position?(r - 2, c + 1, board_state)
    available_destinations << board_state[r - 1][c + 2] if valid_position?(r - 1, c + 2, board_state)
    available_destinations << board_state[r + 1][c + 2] if valid_position?(r + 1, c + 2, board_state)
    available_destinations << board_state[r + 2][c + 1] if valid_position?(r + 2, c + 1, board_state)
    available_destinations << board_state[r + 2][c - 1] if valid_position?(r + 2, c - 1, board_state)
    available_destinations << board_state[r + 1][c - 2] if valid_position?(r + 1, c - 2, board_state)
    available_destinations << board_state[r - 1][c - 2] if valid_position?(r - 1, c - 2, board_state)
    available_destinations << board_state[r - 2][c - 1] if valid_position?(r - 2, c - 1, board_state)
    available_destinations
  end

  private

  def determine_symbol(color)
    case color
    when 'White' then "\u2658".encode('utf-8')
    when 'Black' then "\u265E".encode('utf-8')
    end
  end
end
