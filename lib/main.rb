# frozen_string_literal: true

require_relative 'player'
require_relative 'piece'
require_relative 'board'
require_relative 'cell'

board = Board.new

board.pretty_print_board

p board.create_valid_destination_list('Rook', 0, 0)
