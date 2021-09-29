# frozen_string_literal: true

# to house methods for interfacing with user
class Interface
  def display_introduction
    display_welcome_message
    display_instructions
    display_load_game_option
    display_board_v1
  end

  def solicit_save_quit_response
    display_save_quit_option
    gets.chomp
  end

  def solicit_player_action
    display_request_for_player_action
    gets.chomp
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

  # using to test board creation and changes. May end up transforming into the
  # display board method
  def pretty_print_board_text
    @board.cells.each_with_index do |row, index|
      print "row #{index + 1}: "
      row.each do |cell|
        if cell.cell_contents.nil?
          print 'empty '
        else
          print "#{cell.cell_contents.color} #{cell.cell_contents.type} "
        end
      end
      puts ''
    end
  end

  def pretty_print_board_symbols
    @board.cells.each_with_index do |row, index|
      print "row #{index + 1}: "
      row.each do |cell|
        if cell.cell_contents.nil?
          print 'empty '
        else
          print "#{cell.cell_contents.symbol} "
        end
      end
      puts ''
    end
  end

  def display_board_v1
    x = "\u2654".encode('utf-8')
    board =
      "        ___a___ ___b___ ___c___ ___d___ ___e___ ___f___ ___g___ ___h___
       |       |       |       |       |       |       |       |       |
      8|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |8
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      7|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |7
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      6|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |6
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      5|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |5
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      4|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |4
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      3|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |3
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      2|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |2
       |_______|_______|_______|_______|_______|_______|_______|_______|
       |       |       |       |       |       |       |       |       |
      1|   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |   #{x}   |1
       |_______|_______|_______|_______|_______|_______|_______|_______|
           a       b       c       d       e       f       g       h
      "
    puts board
  end

  def display_save_quit_option
    puts "Would you like to save and/or quit the game? (type 's' for save, 'q' for quit, 'sq' for both)"
  end

  def display_request_for_player_action
    puts 'Player (1 or 2, pull from Player.name), enter your move: '
    # should I explain instructions each time this is printed or just at the
    # beginning? or maybe only if a move entered is invalid?
    # oh! I could also put a "type 'help' for instructions"
  end
end
