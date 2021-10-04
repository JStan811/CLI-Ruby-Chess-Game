# frozen_string_literal: true

require_relative 'game_builder'

# represents an entity running the game
class Chess
  def initialize
    @game = GameBuilder.new
    # play_chess
  end

  def play_chess
    @game.interface.display_introduction
    loop do
      @game.interface.display_board(@game.board)
      turn_loop(@game.player1)
      @game.interface.display_board(@game.board)
      turn_loop(@game.player2)
    end
  end

  def turn_loop(player)
    # Ask player if they would like to save game and/or quit
    # based on response, engage save mechanism and/or exit game
    @game.interface.solicit_save_quit_response
    # check for check
    if @game.validator.self_check?(player, @game.board.cells)
      puts "#{player.name}, your king is in check. Your move must result in a position where the king is no longer in check."
    end
    # Ask player for move/action
    player_action = player_action_sequence(player)
    # turn user input notation into starting and ending cells
    starting_cell = convert_player_action_into_starting_cell(player_action)
    ending_cell = convert_player_action_into_ending_cell(player_action)
    # update board
    @game.board.update_board(starting_cell, ending_cell)
    # check for checkmate
    if @game.validator.opp_check_mate?(player, @game.board.cells)
      @game.interface.display_board(@game.board)
      puts "Checkmate. #{player.name} wins."
      exit
    end
    # proceeed to next interation of loop
  end

  # rubocop: disable Metrics
  def player_action_sequence(player)
    player_action = ''
    loop do
      # ask player for action
      player_action = @game.interface.solicit_player_action(player)
      # validate if entered text is valid (follows Chess notation)
      unless @game.validator.valid_notation?(player_action)
        puts 'Invalid notation.'
        next
      end
      # pull out starting and ending cells from action
      starting_cell = convert_player_action_into_starting_cell(player_action)
      ending_cell = convert_player_action_into_ending_cell(player_action)
      # validate that starting position and ending position aren't the same
      unless @game.validator.different_start_and_end_cells?(starting_cell, ending_cell)
        puts 'The starting and ending cells are the same.'
        next
      end
      # validate if starting cell contains own piece
      unless @game.validator.starting_cell_contains_own_piece?(starting_cell, player)
        puts 'Starting cell does not contain your own piece.'
        next
      end
      # validate if action is a valid destination for given piece
      unless @game.validator.legal_move?(starting_cell, ending_cell, @game.board.cells)
        puts 'Illegal move for this piece.'
        next
      end
      # if moving King, validate if move leaves it in Check
      if starting_cell.piece.instance_of?(King)
        if @game.validator.own_king_into_check?(ending_cell, player, @game.board.cells)
          puts 'Move puts your own King into Check.'
          next
        end
      end
      # if all validations pass, accept player action
      break
    end
    player_action
  end
  # rubocop: enable Metrics

  def convert_notation_to_column_index(notated_cell)
    notated_cell_as_char_array = notated_cell.split('')
    notated_column = notated_cell_as_char_array[0]
    char_codepoint = notated_column.ord
    char_codepoint - 97
  end

  def convert_notation_to_row_index(notated_cell)
    notated_cell_as_char_array = notated_cell.split('')
    notated_row = notated_cell_as_char_array[1].to_i
    notated_row - 1
  end

  private

  def convert_player_action_into_starting_cell(player_action)
    action_as_char_array = player_action.split('')
    # "notated" here means cell as player enters it (eg 'e4')
    notated_starting_cell = "#{action_as_char_array[0]}#{action_as_char_array[1]}"
    starting_cell_row_index = convert_notation_to_row_index(notated_starting_cell)
    starting_cell_column_index = convert_notation_to_column_index(notated_starting_cell)
    @game.board.cells[starting_cell_row_index][starting_cell_column_index]
  end

  def convert_player_action_into_ending_cell(player_action)
    action_as_char_array = player_action.split('')
    # "notated" here means cell as player enters it (eg 'e4')
    notated_ending_cell = "#{action_as_char_array[2]}#{action_as_char_array[3]}"
    ending_cell_row_index = convert_notation_to_row_index(notated_ending_cell)
    ending_cell_column_index = convert_notation_to_column_index(notated_ending_cell)
    @game.board.cells[ending_cell_row_index][ending_cell_column_index]
  end

  def determine_piece_type_from_notated_cell(player_action)
    @game.board.convert_notation_to_piece_type(notated_cell)
  end

  def determine_piece_color_from_action(player_action)
    @game.board.convert_notation_to_piece_color(notated_cell)
  end
end
