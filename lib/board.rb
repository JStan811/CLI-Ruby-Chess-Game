# frozen_string_literal: true

# represents the chess board
class Board
  def initialize
    @current_state = {}
    build_starting_board
  end

  attr_reader :current_state

  def pretty_print_board
    # "file" is a column, "cells" is the array of cells in that column
    @current_state.each do |file, cells|
      print "file #{file}: "
      cells.each do |cell|
        if cell.nil?
          print 'empty '
        else
          print "#{cell.color} #{cell.type} "
        end
      end
      puts ''
    end
  end

  private

  def build_starting_board
    board = { a: [], b: [], c: [], d: [], e: [], f: [], g: [], h: [] }
    place_white_starting_pieces(board)
    fill_empty_cells_for_starting_board(board)
    place_black_starting_pieces(board)
    @current_state = board
  end

  def place_white_starting_pieces(board)
    board[:a] << Piece.new('Rook', 'White')
    board[:b] << Piece.new('Knight', 'White')
    board[:c] << Piece.new('Bishop', 'White')
    board[:d] << Piece.new('Queen', 'White')
    board[:e] << Piece.new('King', 'White')
    board[:f] << Piece.new('Bishop', 'White')
    board[:g] << Piece.new('Knight', 'White')
    board[:h] << Piece.new('Rook', 'White')
    place_white_starting_pawns(board)
  end

  def place_white_starting_pawns(board)
    board[:a] << Piece.new('Pawn', 'White')
    board[:b] << Piece.new('Pawn', 'White')
    board[:c] << Piece.new('Pawn', 'White')
    board[:d] << Piece.new('Pawn', 'White')
    board[:e] << Piece.new('Pawn', 'White')
    board[:f] << Piece.new('Pawn', 'White')
    board[:g] << Piece.new('Pawn', 'White')
    board[:h] << Piece.new('Pawn', 'White')
  end

  def fill_empty_cells_for_starting_board(board)
    # a column is called a 'file' in Chess
    board.each do |file, cells|
      # add 4 blank cells to each file
      4.times do
        cells << nil
      end
    end
  end

  def place_black_starting_pieces(board)
    place_black_starting_pawns(board)
    board[:a] << Piece.new('Rook', 'Black')
    board[:b] << Piece.new('Knight', 'Black')
    board[:c] << Piece.new('Bishop', 'Black')
    board[:d] << Piece.new('Queen', 'Black')
    board[:e] << Piece.new('King', 'Black')
    board[:f] << Piece.new('Bishop', 'Black')
    board[:g] << Piece.new('Knight', 'Black')
    board[:h] << Piece.new('Rook', 'Black')
  end

  def place_black_starting_pawns(board)
    board[:a] << Piece.new('Pawn', 'Black')
    board[:b] << Piece.new('Pawn', 'Black')
    board[:c] << Piece.new('Pawn', 'Black')
    board[:d] << Piece.new('Pawn', 'Black')
    board[:e] << Piece.new('Pawn', 'Black')
    board[:f] << Piece.new('Pawn', 'Black')
    board[:g] << Piece.new('Pawn', 'Black')
    board[:h] << Piece.new('Pawn', 'Black')
  end
end
