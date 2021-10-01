# frozen_string_literal: true

require_relative 'piece'

class Bishop < Piece
  def available_destinations(starting_cell, board_state)
    available_destinations = available_destinations_down_right(starting_cell, board_state)
    available_destinations += available_destinations_up_right(starting_cell, board_state)
    available_destinations += available_destinations_up_left(starting_cell, board_state)
    available_destinations += available_destinations_down_left(starting_cell, board_state)
    available_destinations
  end

  private

  # would all of these available destinations be better using recursion?
  # rubocop: disable Metrics
  def available_destinations_down_right(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = board_state[row - 1][column + 1] unless row == 0 || column == 7
    loop do
      break if row == 0 || column == 7

      if next_cell.piece.nil?
        available_destinations << next_cell
      # if next cell is not empty, add unless owner is you, then break
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      # decrement row up by 1 and increment column by 1and update next cell
      row -= 1
      column +=1
      next_cell = board_state[row - 1][column + 1] unless row == 0 || column == 7
    end
    available_destinations
  end
  # rubocop: enable Metrics

  # rubocop: disable Metrics
  def available_destinations_up_right(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = board_state[row + 1][column + 1] unless row == 7 || column == 7
    loop do
      break if row == 7 || column == 7

      if next_cell.piece.nil?
        available_destinations << next_cell
      # if next cell is not empty, add unless owner is you, then break
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      # decrement row up by 1 and increment column by 1and update next cell
      row += 1
      column += 1
      next_cell = board_state[row + 1][column + 1] unless row == 7 || column == 7
    end
    available_destinations
  end
  # rubocop: enable Metrics

  # rubocop: disable Metrics
  def available_destinations_up_left(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = board_state[row + 1][column - 1] unless row == 7 || column == 0
    loop do
      break if row == 7 || column == 0

      if next_cell.piece.nil?
        available_destinations << next_cell
      # if next cell is not empty, add unless owner is you, then break
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      # decrement row up by 1 and increment column by 1and update next cell
      row += 1
      column -= 1
      next_cell = board_state[row + 1][column - 1] unless row == 7 || column == 0
    end
    available_destinations
  end
  # rubocop: enable Metrics

  # rubocop: disable Metrics
  def available_destinations_down_left(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = board_state[row - 1][column - 1] unless row == 0 || column == 0
    loop do
      break if row == 0 || column == 0

      if next_cell.piece.nil?
        available_destinations << next_cell
      # if next cell is not empty, add unless owner is you, then break
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      # decrement row up by 1 and increment column by 1and update next cell
      row -= 1
      column -= 1
      next_cell = board_state[row - 1][column - 1] unless row == 0 || column == 0
    end
    available_destinations
  end
  # rubocop: enable Metrics

  def determine_symbol(color)
    case color
    when 'White' then "\u2657".encode('utf-8')
    when 'Black' then "\u265D".encode('utf-8')
    end
  end
end
