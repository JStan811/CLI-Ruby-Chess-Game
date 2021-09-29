# frozen_string_literal: true

# represents an entity running the game
class Chess
  def initialize
    @game = GameBuilder.new
    play_chess
  end

  attr_reader :board

  private

  def play_chess
    @game.interface.display_introduction
    loop do
      turn_loop
      # force exit now for testing purposes, eventually I'll throw the
      # 'exit' command into the turn loop itself
      exit
    end
  end

  def turn_loop
    # Ask player if they would like to save game and/or quit
    # based on response, engage save mechanism and/or exit game
    @game.interface.solicit_save_quit_response
    # Ask player for move/action
    player_action = @game.interface.solicit_player_action
    # check if valid move
    @game.validator.validate_move(player_action)
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
end
