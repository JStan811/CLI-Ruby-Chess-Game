# frozen_string_literal: true

require_relative 'line_movement'

# This class is used to create Rook pieces and contains their movement rules
class Rook < Piece
  include LineMovement

  def available_destinations(starting_cell, board_state)
    available_destinations = available_destinations_up(starting_cell, board_state)
    available_destinations += available_destinations_right(starting_cell, board_state)
    available_destinations += available_destinations_down(starting_cell, board_state)
    available_destinations += available_destinations_left(starting_cell, board_state)
    available_destinations
  end

  private

  def determine_symbol(color)
    case color
    when 'White' then "\u2656".encode('utf-8')
    when 'Black' then "\u265C".encode('utf-8')
    end
  end
end
