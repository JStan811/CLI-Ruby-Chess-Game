# frozen_string_literal: true

require_relative 'piece'

class King < Piece
  def available_destinations(starting_cell, board_state)
    available_destinations = []
    r = starting_cell.position[0]
    c = starting_cell.position[1]
    available_destinations << board_state[r - 1][c] if valid_position?(r - 1, c, board_state)
    available_destinations << board_state[r - 1][c + 1] if valid_position?(r - 1, c + 1, board_state)
    available_destinations << board_state[r][c + 1] if valid_position?(r, c + 1, board_state)
    available_destinations << board_state[r + 1][c + 1] if valid_position?(r + 1, c + 1, board_state)
    available_destinations << board_state[r + 1][c] if valid_position?(r + 1, c, board_state)
    available_destinations << board_state[r + 1][c - 1] if valid_position?(r + 1, c - 1, board_state)
    available_destinations << board_state[r][c - 1] if valid_position?(r, c - 1, board_state)
    available_destinations << board_state[r - 1][c - 1] if valid_position?(r - 1, c - 1, board_state)
    available_destinations
  end

  private

  def determine_symbol(color)
    case color
    when 'White' then "\u2654".encode('utf-8')
    when 'Black' then "\u265A".encode('utf-8')
    end
  end
end
