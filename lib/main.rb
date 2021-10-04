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
require_relative 'database'

puts 'Welcome to Chess.'

database = Database.new
interface = Interface.new
load_game_choice = interface.load_game_display(database)

if load_game_choice.instance_of?(Chess)
  chess = load_game_choice
else
  chess = Chess.new
end

chess.play_chess
