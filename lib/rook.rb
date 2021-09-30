# frozen_string_literal: true

class Rook < Piece
  def available_destinations(starting_position, board_state)
    # reads board state to determine which cells are available to it from the starting cell
    # actually it doesn't even need a starting cell. The
  end

  private

  def determine_symbol(color)
    case color
    when 'White' then "\u2656".encode('utf-8')
    when 'Black' then "\u265C".encode('utf-8')
    end
  end
end
