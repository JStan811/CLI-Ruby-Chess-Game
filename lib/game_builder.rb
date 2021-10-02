# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'interface'
require_relative 'piece'

# this class is meant to build or setup the game
class GameBuilder
  def initialize
    @player1 = Player.new('Player 1', 'White')
    @player2 = Player.new('Player 2', 'Black')
    @board = Board.new
    build_starting_board
    @interface = Interface.new
  end

  attr_reader :interface, :validator, :board

  private

  def build_starting_board
    place_white_starting_pieces
    place_black_starting_pieces
  end

  def place_white_starting_pieces
    place_piece(0, 0, Rook.new('White', 'Player 1'))
    place_piece(0, 1, Knight.new('White', 'Player 1'))
    place_piece(0, 2, Bishop.new('White', 'Player 1'))
    place_piece(0, 3, Queen.new('White', 'Player 1'))
    place_piece(0, 4, King.new('White', 'Player 1'))
    place_piece(0, 5, Bishop.new('White', 'Player 1'))
    place_piece(0, 6, Knight.new('White', 'Player 1'))
    place_piece(0, 7, Rook.new('White', 'Player 1'))
    place_white_starting_pawns
  end

  def place_piece(row_index, column_index, piece)
    cell = @board.cells[row_index][column_index]
    cell.place_piece(piece)
  end

  def place_white_starting_pawns
    for i in 0..7
      place_piece(1, i, Pawn.new('White', 'Player 1'))
    end
  end

  def place_black_starting_pieces
    place_black_starting_pawns
    place_piece(7, 0, Rook.new('Black', 'Player 2'))
    place_piece(7, 1, Knight.new('Black', 'Player 2'))
    place_piece(7, 2, Bishop.new('Black', 'Player 2'))
    place_piece(7, 3, Queen.new('Black', 'Player 2'))
    place_piece(7, 4, King.new('Black', 'Player 2'))
    place_piece(7, 5, Bishop.new('Black', 'Player 2'))
    place_piece(7, 6, Knight.new('Black', 'Player 2'))
    place_piece(7, 7, Rook.new('Black', 'Player 2'))
  end

  def place_black_starting_pawns
    for i in 0..7
      place_piece(6, i, Pawn.new('Black', 'Player 2'))
    end
  end
end
