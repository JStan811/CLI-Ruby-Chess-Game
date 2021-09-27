# frozen_string_literal: true

# represents the chess board
class Board
  def initialize
    @current_state = build_starting_board
  end

  attr_reader :current_state

  # using to test board creation and changes. May end up transforming into the
  # display board method
  def pretty_print_board
    # "rank" is a row
    @current_state.each_with_index do | rank, index |
      print "rank #{index + 1}: "
      rank.each do |cell|
        if cell.contents.nil?
          print "#{cell.position} empty "
        else
          print "#{cell.position} #{cell.contents.color} #{cell.contents.type} "
        end
      end
      puts ''
    end
  end

  private

  def build_starting_board
    # the board is represented by an array of 8 subarrays, each
    # subarray representing a rank (or row), starting from the
    # bottom
    board = [[], [], [], [], [], [], [], []]
    place_white_starting_pieces(board)
    fill_empty_cells_for_starting_board(board)
    place_black_starting_pieces(board)
    board
  end

  def place_white_starting_pieces(board)
    board[0] << Cell.new('a1', Piece.new('Rook', 'White'))
    board[0] << Cell.new('b1', Piece.new('Knight', 'White'))
    board[0] << Cell.new('c1', Piece.new('Bishop', 'White'))
    board[0] << Cell.new('d1', Piece.new('Queen', 'White'))
    board[0] << Cell.new('e1', Piece.new('King', 'White'))
    board[0] << Cell.new('f1', Piece.new('Bishop', 'White'))
    board[0] << Cell.new('g1', Piece.new('Knight', 'White'))
    board[0] << Cell.new('h1', Piece.new('Rook', 'White'))
    place_white_starting_pawns(board)
  end

  def place_white_starting_pawns(board)
    board[1] << Cell.new('a2', Piece.new('Pawn', 'White'))
    board[1] << Cell.new('b2', Piece.new('Pawn', 'White'))
    board[1] << Cell.new('c2', Piece.new('Pawn', 'White'))
    board[1] << Cell.new('d2', Piece.new('Pawn', 'White'))
    board[1] << Cell.new('e2', Piece.new('Pawn', 'White'))
    board[1] << Cell.new('f2', Piece.new('Pawn', 'White'))
    board[1] << Cell.new('g2', Piece.new('Pawn', 'White'))
    board[1] << Cell.new('h2', Piece.new('Pawn', 'White'))
  end

  def fill_empty_cells_for_starting_board(board)
    fill_empty_cells_per_row(board, 3)
    fill_empty_cells_per_row(board, 4)
    fill_empty_cells_per_row(board, 5)
    fill_empty_cells_per_row(board, 6)
  end

  def fill_empty_cells_per_row(board, row)
    board[row - 1] << Cell.new("a#{row}")
    board[row - 1] << Cell.new("b#{row}")
    board[row - 1] << Cell.new("c#{row}")
    board[row - 1] << Cell.new("d#{row}")
    board[row - 1] << Cell.new("e#{row}")
    board[row - 1] << Cell.new("f#{row}")
    board[row - 1] << Cell.new("g#{row}")
    board[row - 1] << Cell.new("h#{row}")
  end

  def place_black_starting_pieces(board)
    place_black_starting_pawns(board)
    board[7] << Cell.new('a8', Piece.new('Rook', 'Black'))
    board[7] << Cell.new('b8', Piece.new('Knight', 'Black'))
    board[7] << Cell.new('c8', Piece.new('Bishop', 'Black'))
    board[7] << Cell.new('d8', Piece.new('Queen', 'Black'))
    board[7] << Cell.new('e8', Piece.new('King', 'Black'))
    board[7] << Cell.new('f8', Piece.new('Bishop', 'Black'))
    board[7] << Cell.new('g8', Piece.new('Knight', 'Black'))
    board[7] << Cell.new('h8', Piece.new('Rook', 'Black'))
  end

  def place_black_starting_pawns(board)
    board[6] << Cell.new('a7', Piece.new('Pawn', 'Black'))
    board[6] << Cell.new('b7', Piece.new('Pawn', 'Black'))
    board[6] << Cell.new('c7', Piece.new('Pawn', 'Black'))
    board[6] << Cell.new('d7', Piece.new('Pawn', 'Black'))
    board[6] << Cell.new('e7', Piece.new('Pawn', 'Black'))
    board[6] << Cell.new('f7', Piece.new('Pawn', 'Black'))
    board[6] << Cell.new('g7', Piece.new('Pawn', 'Black'))
    board[6] << Cell.new('h7', Piece.new('Pawn', 'Black'))
  end
end
