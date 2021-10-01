# frozen_string_literal: true

require_relative 'player'
require_relative 'piece'
require_relative 'rook'
require_relative 'board'
require_relative 'cell'
require_relative 'chess'
require_relative 'interface'
require_relative 'game_builder'

board = Board.new

p board.cells
