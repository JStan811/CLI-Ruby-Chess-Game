# frozen_string_literal: true

require_relative 'player'
require_relative 'piece'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'
require_relative 'board'
require_relative 'cell'
require_relative 'chess'
require_relative 'interface'
require_relative 'game_builder'

game = GameBuilder.new

game.interface.pretty_print_board_text(game.board)
