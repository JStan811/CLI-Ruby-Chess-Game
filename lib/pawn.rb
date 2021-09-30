# frozen_string_literal: true

class Pawn < Piece
  private

  def determine_symbol(color)
    case color
    when 'White' then "\u2659".encode('utf-8')
    when 'Black' then "\u265F".encode('utf-8')
    end
  end
end
