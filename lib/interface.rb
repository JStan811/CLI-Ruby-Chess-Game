# frozen_string_literal: true

# to house methods for interfacing with user
class Interface
  def display_introduction
    display_welcome_message
    display_instructions
    display_load_game_option
  end

  def solicit_save_quit_response
    display_save_quit_option
    gets.chomp
  end

  def solicit_player_action(player)
    display_request_for_player_action(player)
    gets.chomp
  end

    # using to test board creation and changes. May end up transforming into the
  # display board method
  def pretty_print_board_text(board)
    board.cells.each_with_index do |row, index|
      print "row #{index + 1}: "
      row.each do |cell|
        if cell.piece.nil?
          print 'empty '
        else
          print "#{cell.piece.color} #{cell.piece.class} "
        end
      end
      puts ''
    end
  end

  def pretty_print_board_symbols
    @board.cells.each_with_index do |row, index|
      print "row #{index + 1}: "
      row.each do |cell|
        if cell.piece.nil?
          print 'empty '
        else
          print "#{cell.piece.symbol} "
        end
      end
      puts ''
    end
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

  def display_welcome_message
    puts 'Welcome to Chess!'
    puts ''
  end

  def display_instructions
    puts 'These are your instructions: '
    puts '(Instructions to be filled in later :D...)'
    puts ''
  end

  def display_load_game_option
    puts 'Would you like load a previous game? (y/n)'
    puts ''
  end

  def display_save_quit_option
    puts "Would you like to save and/or quit the game? (type 's' for save, 'q' for quit, 'sq' for both)"
  end

  def display_request_for_player_action(player)
    puts "#{player.name}, enter your move: "
    # should I explain instructions each time this is printed or just at the
    # beginning? or maybe only if a move entered is invalid?
    # oh! I could also put a "type 'help' for instructions"
  end
end
