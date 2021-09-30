# frozen_string_literal: true

class King < Piece
  private

  def determine_symbol(color)
    case color
    when 'White' then "\u2654".encode('utf-8')
    when 'Black' then "\u265A".encode('utf-8')
    end
  end
end
