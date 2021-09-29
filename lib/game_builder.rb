# frozen_string_literal: true

# this class is meant to build or setup the game
class GameBuilder
  def initialize
    @player1 = Player.new('Player 1', 'White')
    @player2 = Player.new('Player 2', 'Black')
    @pieces = []
    fill_pieces_collection
    @board = Board.new
    build_starting_board
    @interface = Interface.new
  end

  attr_reader :interface

  private

  def fill_pieces_collection
    fill_with_white_pieces_non_pawns
    fill_with_white_pawns
    fill_with_black_pieces_non_pawns
    fill_with_black_pawns
  end

  def fill_with_white_pieces_non_pawns
    @pieces << Piece.new('White', 'Rook')
    @pieces << Piece.new('White', 'Knight')
    @pieces << Piece.new('White', 'Bishop')
    @pieces << Piece.new('White', 'Queen')
    @pieces << Piece.new('White', 'King')
    @pieces << Piece.new('White', 'Bishop')
    @pieces << Piece.new('White', 'Knight')
    @pieces << Piece.new('White', 'Rook')
  end

  def fill_with_white_pawns
    8.times do
      @pieces << Piece.new('White', 'Pawn')
    end
  end

  def fill_with_black_pieces_non_pawns
    @pieces << Piece.new('Black', 'Rook')
    @pieces << Piece.new('Black', 'Knight')
    @pieces << Piece.new('Black', 'Bishop')
    @pieces << Piece.new('Black', 'Queen')
    @pieces << Piece.new('Black', 'King')
    @pieces << Piece.new('Black', 'Bishop')
    @pieces << Piece.new('Black', 'Knight')
    @pieces << Piece.new('Black', 'Rook')
  end

  def fill_with_black_pawns
    8.times do
      @pieces << Piece.new('Black', 'Pawn')
    end
  end

  def build_starting_board
    place_white_starting_pieces
    place_black_starting_pieces
  end

  def place_white_starting_pieces
    place_piece(0, 0, 'White', 'Rook')
    place_piece(0, 1, 'White', 'Knight')
    place_piece(0, 2, 'White', 'Bishop')
    place_piece(0, 3, 'White', 'Queen')
    place_piece(0, 4, 'White', 'King')
    place_piece(0, 5, 'White', 'Bishop')
    place_piece(0, 6, 'White', 'Knight')
    place_piece(0, 7, 'White', 'Rook')
    place_white_starting_pawns
  end

  def place_piece(target_row_index, target_column_index, piece_color, piece_type)
    piece = pull_piece(piece_color, piece_type)
    cell = @board.board_contents[target_row_index][target_column_index]
    cell.cell_contents = piece
  end

  def pull_piece(piece_color, piece_type)
    # find first piece in collection matching given color and type
    pulled_piece = @pieces.find { |piece| piece.color == piece_color && piece.type == piece_type }
    # pull (delete) piece from collection
    @pieces.delete pulled_piece
    pulled_piece
  end

  def place_white_starting_pawns
    place_piece(1, 0, 'White', 'Pawn')
    place_piece(1, 1, 'White', 'Pawn')
    place_piece(1, 2, 'White', 'Pawn')
    place_piece(1, 3, 'White', 'Pawn')
    place_piece(1, 4, 'White', 'Pawn')
    place_piece(1, 5, 'White', 'Pawn')
    place_piece(1, 6, 'White', 'Pawn')
    place_piece(1, 7, 'White', 'Pawn')
  end

  def place_black_starting_pieces
    place_black_starting_pawns
    place_piece(7, 0, 'Black', 'Rook')
    place_piece(7, 1, 'Black', 'Knight')
    place_piece(7, 2, 'Black', 'Bishop')
    place_piece(7, 3, 'Black', 'Queen')
    place_piece(7, 4, 'Black', 'King')
    place_piece(7, 5, 'Black', 'Bishop')
    place_piece(7, 6, 'Black', 'Knight')
    place_piece(7, 7, 'Black', 'Rook')
  end

  def place_black_starting_pawns
    place_piece(6, 0, 'Black', 'Pawn')
    place_piece(6, 1, 'Black', 'Pawn')
    place_piece(6, 2, 'Black', 'Pawn')
    place_piece(6, 3, 'Black', 'Pawn')
    place_piece(6, 4, 'Black', 'Pawn')
    place_piece(6, 5, 'Black', 'Pawn')
    place_piece(6, 6, 'Black', 'Pawn')
    place_piece(6, 7, 'Black', 'Pawn')
  end
end
