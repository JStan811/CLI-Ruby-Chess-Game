# frozen_string_literal: true

require_relative 'player'
require_relative 'piece'
require_relative 'board'
require_relative 'cell'
require_relative 'chess'

chess = Chess.new

chess.pretty_print_board_text

chess.pretty_print_board_symbols

# p board.create_valid_destination_list('Rook', 2, 2)
# p board.create_valid_destination_list('Knight', 0, 1)
# p board.create_valid_destination_list('Bishop', 5, 2)
# p board.create_valid_destination_list('Queen', 3, 3)
# p board.create_valid_destination_list('King', 4, 7)

# puts "#{board.board_state[7][2].position} #{board.board_state[7][2].contents.color} #{board.board_state[7][2].contents.type}"
