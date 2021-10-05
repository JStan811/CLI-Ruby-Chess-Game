# frozen_string_literal: true

require_relative 'line_movement'

# This class is used to create Bishop pieces and contains their movement rules
class Bishop < Piece
  include LineMovement

  def available_destinations(starting_cell, board_state)
    available_destinations = available_destinations_down_right(starting_cell, board_state)
    available_destinations += available_destinations_up_right(starting_cell, board_state)
    available_destinations += available_destinations_up_left(starting_cell, board_state)
    available_destinations += available_destinations_down_left(starting_cell, board_state)
    available_destinations
  end

  private

  def determine_symbol(color)
    case color
    when 'White' then "\u2657".encode('utf-8')
    when 'Black' then "\u265D".encode('utf-8')
    end
  end
end
