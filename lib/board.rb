# frozen_string_literal: true

require_relative 'cell'

# represents the Chess board
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
    starting_cell.remove_piece
    ending_cell.place_piece(piece_to_move)
  end

  def promote_pawn(desired_promotion, ending_cell, player)
    piece_to_replace_pawn = Object.const_get(desired_promotion).new(player.color, player)
    ending_cell.remove_piece
    ending_cell.place_piece(piece_to_replace_pawn)
  end

  private

  def fill_board_with_empty_cells
    @cells.each_with_index { |row, index| fill_row_with_8_empty_cells(row, index) }
  end

  def fill_row_with_8_empty_cells(row, row_index)
    (0..7).each { |column_index| row << Cell.new([row_index, column_index]) }
  end
end
