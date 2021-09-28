# frozen_string_literal: true

# represents the chess board
class Board
  def initialize
    # the board is represented by an array of 8 subarrays, each
    # subarray representing a row, starting from the bottom.
    # The index value represents [row][column], ie the cell
    # at [0,3] is d1 (or White Queen)
    @board_contents = [[], [], [], [], [], [], [], []]
    fill_board_with_empty_cells
  end

  attr_reader :board_contents

  # rubocop : disable Metrics/MethodLength
  # using to test board creation and changes. May end up transforming into the
  # display board method
  def pretty_print_board
    @board_contents.each_with_index do |row, index|
      print "row #{index + 1}: "
      row.each do |cell|
        if cell.contents.nil?
          print 'empty '
        else
          print "#{cell.contents.color} #{cell.contents.type} "
        end
      end
      puts ''
    end
  end
  # rubocop : enable Metrics/MethodLength

  private

  def fill_board_with_empty_cells
    @board_contents.each { |row| fill_row_with_8_empty_cells(row) }
  end

  def fill_row_with_8_empty_cells(row)
    8.times do
      row << Cell.new
    end
  end
end
