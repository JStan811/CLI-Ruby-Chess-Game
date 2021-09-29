# frozen_string_literal: true

# represents a chess piece
class Piece
  def initialize(color, type, owner)
    @color = color
    @type = type
    @owner = owner
    @symbol = determine_symbol(color, type)
  end

  attr_reader :color, :type, :owner, :symbol

  private

  def determine_symbol(color, type)
    case color
    when 'White'
      determine_white_symbol(type)
    when 'Black'
      determine_black_symbol(type)
    end
  end

  def determine_white_symbol(type)
    case type
    when 'Rook'
      "\u2656".encode('utf-8')
    when 'Knight'
      "\u2658".encode('utf-8')
    when 'Bishop'
      "\u2657".encode('utf-8')
    when 'Queen'
      "\u2655".encode('utf-8')
    when 'King'
      "\u2654".encode('utf-8')
    when 'Pawn'
      "\u2659".encode('utf-8')
    end
  end

  def determine_black_symbol(type)
    case type
    when 'Rook'
      "\u265C".encode('utf-8')
    when 'Knight'
      "\u265E".encode('utf-8')
    when 'Bishop'
      "\u265D".encode('utf-8')
    when 'Queen'
      "\u265B".encode('utf-8')
    when 'King'
      "\u265A".encode('utf-8')
    when 'Pawn'
      "\u265F".encode('utf-8')
    end
  end
end
