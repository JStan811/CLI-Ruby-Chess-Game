# frozen_string_literal: true

require_relative 'player'
require_relative 'piece'
require_relative 'board'
require_relative 'cell'

board = Board.new

board.pretty_print_board

# p board.create_valid_destination_list('Rook', 2, 2)
p board.create_valid_destination_list('Knight', 0, 1)

# puts "#{board.board_state[7][2].position} #{board.board_state[7][2].contents.color} #{board.board_state[7][2].contents.type}"
