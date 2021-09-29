# frozen_string_literal: true

require_relative 'cell'

# represents the chess board
class Board
  def initialize
    # the board is represented by an array of 8 subarrays, each
    # subarray representing a row, starting from the bottom.
    # The index value represents [row][column], ie the cell
    # at [0,3] is d1 (or White Queen)
    @cells = [[], [], [], [], [], [], [], []]
    fill_board_with_empty_cells
  end

  attr_reader :cells

  private

  def fill_board_with_empty_cells
    @cells.each { |row| fill_row_with_8_empty_cells(row) }
  end

  def fill_row_with_8_empty_cells(row)
    for i in 0..7 do
      # instantiate a new Cell object and pass it its position as an argument
      row << Cell.new([row, i])
    end
  end
end
