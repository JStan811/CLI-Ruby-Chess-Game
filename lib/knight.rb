# frozen_string_literal: true

class Knight < Piece
  private

  def determine_symbol(color)
    case color
    when 'White' then "\u2658".encode('utf-8')
    when 'Black' then "\u265E".encode('utf-8')
    end
  end
end
