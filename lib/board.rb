# frozen_string_literal: true

require_relative 'cell'

# represents the chess board
class Board
  def initialize
    # the board is represented by an array of 8 subarrays, each
    # subarray representing a row, starting from the bottom.
    # The index value represents [row][column], ie the cell
    # at [0,3] is d1 (or White Queen's starting position)
    @cells = [[], [], [], [], [], [], [], []]
    fill_board_with_empty_cells
  end

  attr_reader :cells

  def update_board(starting_cell, ending_cell)
    piece_to_move = starting_cell.piece
    starting_cell.piece = nil
    ending_cell.piece = piece_to_move
  end

  private

  def fill_board_with_empty_cells
    @cells.each_with_index { |row, index| fill_row_with_8_empty_cells(row, index) }
  end

  def fill_row_with_8_empty_cells(row, row_index)
    for i in 0..7 do
      # instantiate a new Cell object and pass it its position as an argument
      row << Cell.new([row_index, i])
    end
  end
end
