# frozen_string_literal: true

# rubocop: disable Metrics/ModuleLength
# This holds the methods for creating all available vertical, horizontal, and
# diagonal movements. Its a module because the Rook class uses vertical and
# horizontal, the bishop class uses diagonal, and the Queen class uses all 3.
module LineMovement
  # rubocop: disable Metrics/MethodLength
  def available_destinations_up(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = next_cell_up(row, column, board_state)
    loop do
      break if row == 7

      if next_cell.piece.nil?
        available_destinations << next_cell
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      row += 1
      next_cell = next_cell_up(row, column, board_state)
    end
    available_destinations
  end
  # rubocop: enable Metrics/MethodLength

  def next_cell_up(row, column, board_state)
    board_state[row + 1][column] unless row == 7
  end

  # rubocop: disable Metrics/MethodLength
  def available_destinations_right(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = next_cell_right(row, column, board_state)
    loop do
      break if column == 7

      if next_cell.piece.nil?
        available_destinations << next_cell
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      column += 1
      next_cell = next_cell_right(row, column, board_state)
    end
    available_destinations
  end
  # rubocop: enable Metrics/MethodLength

  def next_cell_right(row, column, board_state)
    board_state[row][column + 1] unless column == 7
  end

  # rubocop: disable Metrics/MethodLength
  def available_destinations_down(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = next_cell_down(row, column, board_state)
    loop do
      break if row == 0

      if next_cell.piece.nil?
        available_destinations << next_cell
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      row -= 1
      next_cell = next_cell_down(row, column, board_state)
    end
    available_destinations
  end
  # rubocop: enable Metrics/MethodLength

  def next_cell_down(row, column, board_state)
    board_state[row - 1][column] unless row == 0
  end

  # rubocop: disable Metrics/MethodLength
  def available_destinations_left(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = next_cell_left(row, column, board_state)
    loop do
      break if column == 0

      if next_cell.piece.nil?
        available_destinations << next_cell
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      column -= 1
      next_cell = next_cell_left(row, column, board_state)
    end
    available_destinations
  end
  # rubocop: enable Metrics/MethodLength

  def next_cell_left(row, column, board_state)
    board_state[row][column - 1] unless column == 0
  end

  # rubocop: disable Metrics/MethodLength
  def available_destinations_down_right(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = next_cell_down_right(row, column, board_state)
    loop do
      break if row == 0 || column == 7

      if next_cell.piece.nil?
        available_destinations << next_cell
      else
        available_destinations << next_cell unless next_cell.piece.owner == @owner
        break
      end
      row -= 1
      column += 1
      next_cell = next_cell_down_right(row, column, board_state)
    end
    available_destinations
  end
  # rubocop: enable Metrics/MethodLength

  def next_cell_down_right(row, column, board_state)
    board_state[row - 1][column + 1] unless row == 0 || column == 7
  end

  # rubocop: disable Metrics/MethodLength
  def available_destinations_up_right(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = next_cell_up_right(row, column, board_state)
    loop do
      break if row == 7 || column == 7

      if next_cell.piece.nil?
        available_destinations << next_cell
      else
        available_destinations << next_cell unless next_cell.piece.owner == @owner
        break
      end
      row += 1
      column += 1
      next_cell = next_cell_up_right(row, column, board_state)
    end
    available_destinations
  end
  # rubocop: enable Metrics/MethodLength

  def next_cell_up_right(row, column, board_state)
    board_state[row + 1][column + 1] unless row == 7 || column == 7
  end

  # rubocop: disable Metrics/MethodLength
  def available_destinations_up_left(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = next_cell_up_left(row, column, board_state)
    loop do
      break if row == 7 || column == 0

      if next_cell.piece.nil?
        available_destinations << next_cell
      else
        available_destinations << next_cell unless next_cell.piece.owner == @owner
        break
      end
      row += 1
      column -= 1
      next_cell = next_cell_up_left(row, column, board_state)
    end
    available_destinations
  end
  # rubocop: enable Metrics/MethodLength

  def next_cell_up_left(row, column, board_state)
    board_state[row + 1][column - 1] unless row == 7 || column == 0
  end

  # rubocop: disable Metrics/MethodLength
  def available_destinations_down_left(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = next_cell_down_left(row, column, board_state)
    loop do
      break if row == 0 || column == 0

      if next_cell.piece.nil?
        available_destinations << next_cell
      else
        available_destinations << next_cell unless next_cell.piece.owner == @owner
        break
      end
      row -= 1
      column -= 1
      next_cell = next_cell_down_left(row, column, board_state)
    end
    available_destinations
  end
  # rubocop: enable Metrics/MethodLength

  def next_cell_down_left(row, column, board_state)
    board_state[row - 1][column - 1] unless row == 0 || column == 0
  end
end
# rubocop: enable Metrics/ModuleLength
