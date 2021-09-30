# frozen_string_literal: true

require_relative 'player'
require_relative 'piece'
require_relative 'rook'
require_relative 'board'
require_relative 'cell'
require_relative 'chess'
require_relative 'interface'
require_relative 'game_builder'

# chess = Chess.new

white_rook = Rook.new('White', 'p1')
black_rook = Rook.new('Black', 'p2')

puts white_rook.symbol
puts black_rook.symbol

# chess.pretty_print_board_text

# chess.pretty_print_board_symbols

# chess.display_board_v1
# chess.display_board_v2
# chess.display_board_v3


# p board.create_valid_destination_list('Rook', 2, 2)
# p board.create_valid_destination_list('Knight', 0, 1)
# p board.create_valid_destination_list('Bishop', 5, 2)
# p board.create_valid_destination_list('Queen', 3, 3)
# p board.create_valid_destination_list('King', 4, 7)

# puts "#{board.board_state[7][2].position} #{board.board_state[7][2].contents.color} #{board.board_state[7][2].contents.type}"
