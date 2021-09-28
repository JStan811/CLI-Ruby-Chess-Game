# frozen_string_literal: true

# represents an entity running the game
class Chess
  def initialize
    @player1 = Player.new('Player 1', 'White')
    @player2 = Player.new('Player 2', 'Black')
    @pieces = []
    fill_pieces_collection
    @board = Board.new
    build_starting_board
  end

  attr_reader :board

  # using to test board creation and changes. May end up transforming into the
  # display board method
  def pretty_print_board_text
    @board.board_contents.each_with_index do |row, index|
      print "row #{index + 1}: "
      row.each do |cell|
        if cell.cell_contents.nil?
          print 'empty '
        else
          print "#{cell.cell_contents.color} #{cell.cell_contents.type} "
        end
      end
      puts ''
    end
  end

  def pretty_print_board_symbols
    @board.board_contents.each_with_index do |row, index|
      print "row #{index + 1}: "
      row.each do |cell|
        if cell.cell_contents.nil?
          print 'empty '
        else
          print "#{cell.cell_contents.symbol} "
        end
      end
      puts ''
    end
  end

  def display_board_v1
    x = "\u2654".encode('utf-8')
    board =
      "        ___a___ ___b___ ___c___ ___d___ ___e___ ___f___ ___g___ ___h___
       |       |       |       |       |       |       |       |       |
      8|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |8
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      7|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |7
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      6|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |6
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      5|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |5
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      4|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |4
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      3|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |3
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      2|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |2
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      1|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |1
       |_______|_______|_______|_______|_______|_______|_______|_______|
           a       b       c       d       e       f       g       h
      "
    puts board
  end

  def display_board_v2
    x = "\u2654".encode('utf-8')
    board =
      "        __a__ __b__ __c__ __d__ __e__ __f__ __g__ __h__
       |     |     |     |     |     |     |     |     |
      8|  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |8
       |_____|_____|_____|_____|_____|_____|_____|_____|
       |     |     |     |     |     |     |     |     |
      7|  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |7
       |_____|_____|_____|_____|_____|_____|_____|_____|
       |     |     |     |     |     |     |     |     |
      6|  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |6
       |_____|_____|_____|_____|_____|_____|_____|_____|
       |     |     |     |     |     |     |     |     |
      5|  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |5
       |_____|_____|_____|_____|_____|_____|_____|_____|
       |     |     |     |     |     |     |     |     |
      4|  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |4
       |_____|_____|_____|_____|_____|_____|_____|_____|
       |     |     |     |     |     |     |     |     |
      3|  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |3
       |_____|_____|_____|_____|_____|_____|_____|_____|
       |     |     |     |     |     |     |     |     |
      2|  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |2
       |_____|_____|_____|_____|_____|_____|_____|_____|
       |     |     |     |     |     |     |     |     |
      1|  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |  #{x}  |1
       |_____|_____|_____|_____|_____|_____|_____|_____|
          a     b     c     d     e     f     g     h
      "
    puts board
  end

  def display_board_v3
    x = "\u2654".encode('utf-8')
    board =
      "        _a_ _b_ _c_ _d_ _e_ _f_ _g_ _h_
      8|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|8
      7|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|7
      6|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|6
      5|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|5
      4|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|4
      3|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|3
      2|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|2
      1|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|_#{x}_|1
         a   b   c   d   e   f   g   h
      "
    puts board
  end

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
