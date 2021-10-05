# frozen_string_literal: true

# rubocop: disable Metrics/ClassLength
# to house methods for interfacing with user
class Interface
  def display_instructions
    puts 'Player 1 controls the white pieces starting on rows 1 and 2. Player 2 controls the black pieces starting on rows 7 and 8.'
    puts
    puts "Game move notation is 'starting cell''ending cell'. For example, to move a piece from a2 to a4, enter 'a2a4'."
    puts
  end

  def load_game_display(database)
    puts "Enter 'load' to load from a saved game file. Any other response will take you through to a new game."
    response = gets.chomp
    return unless response == 'load'

    puts
    load_game_menu(database)
  end

  def player_in_check_alert(player)
    puts "#{player.name}, your king is in check. Your move must result in a position where your king is no longer in check."
    puts
  end

  def solicit_player_action(player, game, database)
    player_action = ''
    loop do
      puts "#{player.name}, enter your game move or type 's' to be taken to save/quit menu."
      player_action = gets.chomp
      break unless player_action == 's'

      save_quit_menu(game, database)
    end
    player_action
  end

  # rubocop: disable Metrics/MethodLength
  def solicit_pawn_promotion_choice(player)
    desired_promotion = ''
    loop do
      number_of_desired_promotion = solicit_number_of_desired_promotion(player)
      case number_of_desired_promotion
      when '1' then desired_promotion = 'Queen'
      when '2' then desired_promotion = 'Rook'
      when '3' then desired_promotion = 'Knight'
      when '4' then desired_promotion = 'Bishop'
      else
        invalid_entry_message
        next
      end
      break
    end
    desired_promotion
  end
  # rubocop: enable Metrics/MethodLength

  def pawn_promotion_confirmation(desired_promotion)
    puts "Pawn promoted to #{desired_promotion}."
  end

  def checkmate_message(player)
    puts "Checkmate. #{player.name} wins."
  end

  def stalemate_message
    puts 'Stalemate. Game ends in a draw.'
  end

  def invalid_notation_alert
    puts "Invalid notation. Game move notation is 'starting cell''ending cell'. For example, to move a piece from a2 to a4, enter 'a2a4'."
    puts
  end

  def same_start_and_end_cells_alert
    puts 'Invalid move. The starting and ending cells are the same.'
    puts
  end

  def starting_cell_not_own_piece_alert
    puts 'Invalid move. Starting cell does not contain your own piece.'
    puts
  end

  def illegal_move_alert
    puts 'Illegal move for this piece.'
    puts
  end

  def own_king_in_check_alert
    puts 'Invalid move. It puts your own King into Check.'
    puts
  end

  def display_board(board)
    x = "\u2654".encode('utf-8')
    board_display =
      "        ___a___ ___b___ ___c___ ___d___ ___e___ ___f___ ___g___ ___h___
       |       |       |       |       |       |       |       |       |
      8|   #{board.cells[7][0].piece.nil? ? ' ' : board.cells[7][0].piece.symbol}   |   #{board.cells[7][1].piece.nil? ? ' ' : board.cells[7][1].piece.symbol}   |   #{board.cells[7][2].piece.nil? ? ' ' : board.cells[7][2].piece.symbol}   |   #{board.cells[7][3].piece.nil? ? ' ' : board.cells[7][3].piece.symbol}   |   #{board.cells[7][4].piece.nil? ? ' ' : board.cells[7][4].piece.symbol}   |   #{board.cells[7][5].piece.nil? ? ' ' : board.cells[7][5].piece.symbol}   |   #{board.cells[7][6].piece.nil? ? ' ' : board.cells[7][6].piece.symbol}   |   #{board.cells[7][7].piece.nil? ? ' ' : board.cells[7][7].piece.symbol}   |8
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      7|   #{board.cells[6][0].piece.nil? ? ' ' : board.cells[6][0].piece.symbol}   |   #{board.cells[6][1].piece.nil? ? ' ' : board.cells[6][1].piece.symbol}   |   #{board.cells[6][2].piece.nil? ? ' ' : board.cells[6][2].piece.symbol}   |   #{board.cells[6][3].piece.nil? ? ' ' : board.cells[6][3].piece.symbol}   |   #{board.cells[6][4].piece.nil? ? ' ' : board.cells[6][4].piece.symbol}   |   #{board.cells[6][5].piece.nil? ? ' ' : board.cells[6][5].piece.symbol}   |   #{board.cells[6][6].piece.nil? ? ' ' : board.cells[6][6].piece.symbol}   |   #{board.cells[6][7].piece.nil? ? ' ' : board.cells[6][7].piece.symbol}   |7
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      6|   #{board.cells[5][0].piece.nil? ? ' ' : board.cells[5][0].piece.symbol}   |   #{board.cells[5][1].piece.nil? ? ' ' : board.cells[5][1].piece.symbol}   |   #{board.cells[5][2].piece.nil? ? ' ' : board.cells[5][2].piece.symbol}   |   #{board.cells[5][3].piece.nil? ? ' ' : board.cells[5][3].piece.symbol}   |   #{board.cells[5][4].piece.nil? ? ' ' : board.cells[5][4].piece.symbol}   |   #{board.cells[5][5].piece.nil? ? ' ' : board.cells[5][5].piece.symbol}   |   #{board.cells[5][6].piece.nil? ? ' ' : board.cells[5][6].piece.symbol}   |   #{board.cells[5][7].piece.nil? ? ' ' : board.cells[5][7].piece.symbol}   |6
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      5|   #{board.cells[4][0].piece.nil? ? ' ' : board.cells[4][0].piece.symbol}   |   #{board.cells[4][1].piece.nil? ? ' ' : board.cells[4][1].piece.symbol}   |   #{board.cells[4][2].piece.nil? ? ' ' : board.cells[4][2].piece.symbol}   |   #{board.cells[4][3].piece.nil? ? ' ' : board.cells[4][3].piece.symbol}   |   #{board.cells[4][4].piece.nil? ? ' ' : board.cells[4][4].piece.symbol}   |   #{board.cells[4][5].piece.nil? ? ' ' : board.cells[4][5].piece.symbol}   |   #{board.cells[4][6].piece.nil? ? ' ' : board.cells[4][6].piece.symbol}   |   #{board.cells[4][7].piece.nil? ? ' ' : board.cells[4][7].piece.symbol}   |5
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      4|   #{board.cells[3][0].piece.nil? ? ' ' : board.cells[3][0].piece.symbol}   |   #{board.cells[3][1].piece.nil? ? ' ' : board.cells[3][1].piece.symbol}   |   #{board.cells[3][2].piece.nil? ? ' ' : board.cells[3][2].piece.symbol}   |   #{board.cells[3][3].piece.nil? ? ' ' : board.cells[3][3].piece.symbol}   |   #{board.cells[3][4].piece.nil? ? ' ' : board.cells[3][4].piece.symbol}   |   #{board.cells[3][5].piece.nil? ? ' ' : board.cells[3][5].piece.symbol}   |   #{board.cells[3][6].piece.nil? ? ' ' : board.cells[3][6].piece.symbol}   |   #{board.cells[3][7].piece.nil? ? ' ' : board.cells[3][7].piece.symbol}   |4
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      3|   #{board.cells[2][0].piece.nil? ? ' ' : board.cells[2][0].piece.symbol}   |   #{board.cells[2][1].piece.nil? ? ' ' : board.cells[2][1].piece.symbol}   |   #{board.cells[2][2].piece.nil? ? ' ' : board.cells[2][2].piece.symbol}   |   #{board.cells[2][3].piece.nil? ? ' ' : board.cells[2][3].piece.symbol}   |   #{board.cells[2][4].piece.nil? ? ' ' : board.cells[2][4].piece.symbol}   |   #{board.cells[2][5].piece.nil? ? ' ' : board.cells[2][5].piece.symbol}   |   #{board.cells[2][6].piece.nil? ? ' ' : board.cells[2][6].piece.symbol}   |   #{board.cells[2][7].piece.nil? ? ' ' : board.cells[2][7].piece.symbol}   |3
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      2|   #{board.cells[1][0].piece.nil? ? ' ' : board.cells[1][0].piece.symbol}   |   #{board.cells[1][1].piece.nil? ? ' ' : board.cells[1][1].piece.symbol}   |   #{board.cells[1][2].piece.nil? ? ' ' : board.cells[1][2].piece.symbol}   |   #{board.cells[1][3].piece.nil? ? ' ' : board.cells[1][3].piece.symbol}   |   #{board.cells[1][4].piece.nil? ? ' ' : board.cells[1][4].piece.symbol}   |   #{board.cells[1][5].piece.nil? ? ' ' : board.cells[1][5].piece.symbol}   |   #{board.cells[1][6].piece.nil? ? ' ' : board.cells[1][6].piece.symbol}   |   #{board.cells[1][7].piece.nil? ? ' ' : board.cells[1][7].piece.symbol}   |2
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      1|   #{board.cells[0][0].piece.nil? ? ' ' : board.cells[0][0].piece.symbol}   |   #{board.cells[0][1].piece.nil? ? ' ' : board.cells[0][1].piece.symbol}   |   #{board.cells[0][2].piece.nil? ? ' ' : board.cells[0][2].piece.symbol}   |   #{board.cells[0][3].piece.nil? ? ' ' : board.cells[0][3].piece.symbol}   |   #{board.cells[0][4].piece.nil? ? ' ' : board.cells[0][4].piece.symbol}   |   #{board.cells[0][5].piece.nil? ? ' ' : board.cells[0][5].piece.symbol}   |   #{board.cells[0][6].piece.nil? ? ' ' : board.cells[0][6].piece.symbol}   |   #{board.cells[0][7].piece.nil? ? ' ' : board.cells[0][7].piece.symbol}   |1
       |_______|_______|_______|_______|_______|_______|_______|_______|
           a       b       c       d       e       f       g       h
      "
    puts board_display
  end

  private

  # rubocop: disable Metrics/MethodLength
  def load_game_menu(database)
    game = ''
    loop do
      file_number = solicit_file_number_to_load(database.existing_filenames)
      if file_number == 0
        invalid_entry_message
        next
      end
      begin
        game = database.load_game(database.existing_filenames[file_number - 1])
      rescue Errno::EISDIR
        invalid_entry_message
      else
        puts "Loading game #{database.existing_filenames[file_number - 1].delete_suffix '.yaml'}."
        puts
        break
      end
    end
    game
  end
  # rubocop: enable Metrics/MethodLength

  def solicit_file_number_to_load(filenames)
    puts 'Enter the number next to your game file.'
    filenames.each_with_index do |filename, i|
      puts "#{i + 1}. #{filename.delete_suffix '.yaml'}"
    end
    file_number = gets.chomp.to_i
    puts
    file_number
  end

  def invalid_entry_message
    puts 'Invalid entry.'
    puts
  end

  def save_quit_menu(game, database)
    menu_number_choice = solicit_save_quit_menu_number_choice
    case menu_number_choice
    when '1' then save_game_and_continue_playing(game, database)
    when '2' then save_game_and_quit(game, database)
    when '3' then game_exit
    when '4' then return
    else
      puts 'Invalid entry.'
      save_quit_menu(game, database)
    end
  end

  def solicit_save_quit_menu_number_choice
    puts
    puts 'Enter the number next to your choice:'
    puts '1. Save game and continue playing.'
    puts '2. Save game and quit.'
    puts '3. Quit without saving.'
    puts '4. Go back.'
    number_choice = gets.chomp
    puts
    number_choice
  end

  # rubocop: disable Metrics/MethodLength
  def save_game_and_continue_playing(game, database)
    loop do
      filename = solicit_save_file_name
      if database.existing_filenames.include?("#{filename}.yaml")
        puts 'Name already exists.'
        puts
        next
      end
      begin
        database.save_game(game, filename)
      rescue Errno::ENOENT
        invalid_entry_message
      else
        game_saved_message
        break
      end
    end
  end
  # rubocop: enable Metrics/MethodLength

  # rubocop: disable Metrics/MethodLength
  def save_game_and_quit(game, database)
    loop do
      filename = solicit_save_file_name
      if database.existing_filenames.include?("#{filename}.yaml")
        puts 'Name already exists.'
        next
      end
      begin
        database.save_game(game, filename)
      rescue Errno::ENOENT
        invalid_entry_message
      else
        game_saved_message
        break
      end
    end
    game_exit
  end
  # rubocop: enable Metrics/MethodLength

  def game_saved_message
    puts 'Game saved.'
    puts
  end

  def solicit_save_file_name
    puts 'Enter a name for your game: '
    filename = gets.chomp
    puts
    filename
  end

  def game_exit
    puts 'Game exiting.'
    exit
  end

  def solicit_number_of_desired_promotion(player)
    puts "#{player.name}, the pawn you moved is ready to promote. Enter the number next to your desired promotion:"
    puts '1. Queen'
    puts '2. Rook'
    puts '3. Knight'
    puts '4. Bishop'
    number_of_desired_promotion = gets.chomp
    puts
    number_of_desired_promotion
  end
end
# rubocop: enable Metrics/ClassLength
