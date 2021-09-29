# frozen_string_literal: true

# to house methods for interfacing with user
class Interface
  def solicit_player_action
    # ask player for their move and return it
    # include an 'enter "help" to learn how chess notation works'
  end

  def display_introduction
    display_welcome_message
    display_instructions
    display_board_v1
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

  # using to test board creation and changes. May end up transforming into the
  # display board method
  def pretty_print_board_text
    @board.board_contents.each_with_index do |row, index|
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
    @board.board_contents.each_with_index do |row, index|
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
end
