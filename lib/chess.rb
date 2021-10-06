# frozen_string_literal: true

require_relative 'game_builder'

# rubocop: disable Metrics/ClassLength
# represents an entity running the game
class Chess
  def initialize
    @game = GameBuilder.new
    @active_player = @game.player1
  end

  def play_chess
    @game.interface.display_instructions
    loop do
      @game.interface.display_board(@game.board)
      turn_loop(@active_player)
    end
  end

  private

  # rubocop: disable Metrics/MethodLength
  def turn_loop(player)
    player_action = if @game.validator.king_in_check?(player, @game.board.cells)
                      player_action_if_in_check(player)
                    else
                      player_action_sequence(player)
                    end
    starting_cell = convert_player_action_into_starting_cell(player_action)
    ending_cell = convert_player_action_into_ending_cell(player_action)
    @game.board.update_board(starting_cell, ending_cell)
    promote_pawn_if_available(player, ending_cell)
    end_game_if_checkmate(player)
    end_game_if_stalemate(player)
    switch_active_player
  end
  # rubocop: enable Metrics/MethodLength

  # rubocop: disable Metrics/AbcSize
  # rubocop: disable Metrics/MethodLength
  def player_action_if_in_check(player)
    @game.interface.player_in_check_alert(player)
    player_action = ''
    loop do
      player_action = player_action_sequence(player)
      starting_cell = convert_player_action_into_starting_cell(player_action)
      ending_cell = convert_player_action_into_ending_cell(player_action)
      starting_cell_piece = starting_cell.piece
      ending_cell_piece = ending_cell.piece
      @game.board.update_board(starting_cell, ending_cell)
      if @game.validator.king_in_check?(player, @game.board.cells)
        reset_board(starting_cell, starting_cell_piece, ending_cell, ending_cell_piece)
        next
      end
      reset_board(starting_cell, starting_cell_piece, ending_cell, ending_cell_piece)
      break
    end
    player_action
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize

  def reset_board(starting_cell, starting_cell_piece, ending_cell, ending_cell_piece)
    starting_cell.place_piece(starting_cell_piece)
    ending_cell.place_piece(ending_cell_piece)
  end

  def promote_pawn_if_available(player, ending_cell)
    return unless @game.validator.pawn_promotion?(player.color, ending_cell)

    desired_promotion = @game.interface.solicit_pawn_promotion_choice(player)
    @game.board.promote_pawn(desired_promotion, ending_cell, player)
    @game.interface.pawn_promotion_confirmation(desired_promotion)
  end

  def end_game_if_checkmate(player)
    return unless @game.validator.opponent_check_mate?(player, @game.board.cells)

    @game.interface.display_board(@game.board)
    @game.interface.checkmate_message(player)
    exit
  end

  def end_game_if_stalemate(player)
    return unless @game.validator.opponent_stale_mate?(player, @game.board.cells)

    @game.interface.display_board(@game.board)
    @game.interface.stalemate_message
    exit
  end

  def switch_active_player
    @active_player = if @active_player == @game.player1
                       @game.player2
                     else
                       @active_player = @game.player1
                     end
  end

  # rubocop: disable Metrics/AbcSize
  # rubocop: disable Metrics/MethodLength
  def player_action_sequence(player)
    player_action = ''
    loop do
      player_action = @game.interface.solicit_player_action(player, self, @game.database)
      puts
      unless @game.validator.valid_notation?(player_action)
        @game.interface.invalid_notation_alert
        next
      end
      starting_cell = convert_player_action_into_starting_cell(player_action)
      ending_cell = convert_player_action_into_ending_cell(player_action)
      unless @game.validator.different_start_and_end_cells?(starting_cell, ending_cell)
        @game.interface.same_start_and_end_cells_alert
        next
      end
      unless @game.validator.starting_cell_contains_own_piece?(starting_cell, player)
        @game.interface.starting_cell_not_own_piece_alert
        next
      end
      unless @game.validator.legal_move?(starting_cell, ending_cell, @game.board.cells)
        @game.interface.illegal_move_alert
        next
      end
      if starting_cell.piece.instance_of?(King) && @game.validator.moving_own_king_into_check?(ending_cell, player, @game.board.cells)
        @game.interface.own_king_in_check_alert
        next
      end
      break
    end
    player_action
  end
  # rubocop: enable Metrics/AbcSize
  # rubocop: enable Metrics/MethodLength

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

  def convert_player_action_into_starting_cell(player_action)
    action_as_char_array = player_action.split('')
    notated_starting_cell = "#{action_as_char_array[0]}#{action_as_char_array[1]}"
    starting_cell_row_index = convert_notation_to_row_index(notated_starting_cell)
    starting_cell_column_index = convert_notation_to_column_index(notated_starting_cell)
    @game.board.cells[starting_cell_row_index][starting_cell_column_index]
  end

  def convert_player_action_into_ending_cell(player_action)
    action_as_char_array = player_action.split('')
    notated_ending_cell = "#{action_as_char_array[2]}#{action_as_char_array[3]}"
    ending_cell_row_index = convert_notation_to_row_index(notated_ending_cell)
    ending_cell_column_index = convert_notation_to_column_index(notated_ending_cell)
    @game.board.cells[ending_cell_row_index][ending_cell_column_index]
  end
end
