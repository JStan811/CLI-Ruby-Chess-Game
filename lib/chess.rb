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
      turn_loop
      # force exit now for testing purposes, eventually I'll throw the
      # 'exit' command into the turn loop itself
      exit
    end
  end

  def turn_loop(player)
    # Ask player if they would like to save game and/or quit
    # based on response, engage save mechanism and/or exit game
    @game.interface.solicit_save_quit_response
    # Ask player for move/action
    player action = player_action_sequence(player)
    # check if valid move
    @game.validator.validate_action(player_action)
    # update board
    @game.board.update_board(player_action)
    # check for check
    @game.validator.check?(@game.board.board_state)
    # check for checkmate
    @game.validator.check_mate?(@game.board.board_state)
    # check for draw
    @game.validator.draw?(@game.board.board_state)
    # proceeed to next interation of loop
  end

  def player_action_sequence(player)
    # ask player for action
    player_action = @game.interface.solicit_player_action
    # validate if entered text is valid (follows Chess notation)
    @game.validator.valid_notation?(player_action)
    # validate if starting cell has a piece in it
    @game.validator.starting_cell_contains_a_piece?(player_action)
    # validate if starting cell contains own piece
    @game.validator.starting_cell_contains_own_piece?(player_action, player)
    # validate if action is a valid destination for given piece
    @game.validator.valid_destination_for_piece?(player_action)
    # validate if move is allowed with current board setup: is there a piece
    # blocking the way, or is your own piece in the target cell?

    # validate if move leaves own king in check

    # if all validations pass, accept player action
  end

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

  def determine_piece_type_from_notated_cell(player_action)
    @game.board.convert_notation_to_piece_type(notated_cell)
  end

  def determine_piece_color_from_action(player_action)
    @game.board.convert_notation_to_piece_color(notated_cell)
  end
end
