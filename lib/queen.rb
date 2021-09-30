# frozen_string_literal: true

class Queen < Piece
  private

  def determine_symbol(color)
    case color
    when 'White' then "\u2655".encode('utf-8')
    when 'Black' then "\u265B".encode('utf-8')
    end
  end
end
