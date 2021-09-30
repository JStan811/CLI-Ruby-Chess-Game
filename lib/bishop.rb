# frozen_string_literal: true

class Bishop < Piece
  private

  def determine_symbol(color)
    case color
    when 'White' then "\u2657".encode('utf-8')
    when 'Black' then "\u265D".encode('utf-8')
    end
  end
end
