# frozen_string_literal: true

# This class is used to create Queen pieces and contains their movement rules
class Queen < Piece
  include LineMovement

  def available_destinations(starting_cell, board_state)
    vertical_and_horizontal_destinations = vertical_and_horizontal_available_destinations(starting_cell, board_state)
    diagonal_destinations = diagonal_available_destinations(starting_cell, board_state)
    vertical_and_horizontal_destinations + diagonal_destinations
  end

  private

  def vertical_and_horizontal_available_destinations(starting_cell, board_state)
    vertical_and_horizontal_available_destinations = available_destinations_up(starting_cell, board_state)
    vertical_and_horizontal_available_destinations += available_destinations_right(starting_cell, board_state)
    vertical_and_horizontal_available_destinations += available_destinations_down(starting_cell, board_state)
    vertical_and_horizontal_available_destinations += available_destinations_left(starting_cell, board_state)
    vertical_and_horizontal_available_destinations
  end

  def diagonal_available_destinations(starting_cell, board_state)
    diagonal_available_destinations = available_destinations_down_right(starting_cell, board_state)
    diagonal_available_destinations += available_destinations_up_right(starting_cell, board_state)
    diagonal_available_destinations += available_destinations_up_left(starting_cell, board_state)
    diagonal_available_destinations += available_destinations_down_left(starting_cell, board_state)
    diagonal_available_destinations
  end

  def determine_symbol(color)
    case color
    when 'White' then "\u2655".encode('utf-8')
    when 'Black' then "\u265B".encode('utf-8')
    end
  end
end
