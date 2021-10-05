# frozen_string_literal: true

require_relative 'chess'
require_relative 'interface'
require_relative 'database'

puts 'Welcome to Chess.'
puts

database = Database.new
interface = Interface.new
load_game_choice = interface.load_game_display(database)

chess = if load_game_choice.instance_of?(Chess)
          load_game_choice
        else
          Chess.new
        end

chess.play_chess
