# frozen_string_literal: true

require_relative 'piece'

class Queen < Piece
  # The methods being called here are exact copies of the ones in the Rook and # Bishop classes. It's probably not best practice to do this, but I can't
  # think of a better way. Maybe a module?
  def available_destinations(starting_cell, board_state)
    rook_destinations = rook_available_destinations(starting_cell, board_state)
    bishop_destinations = bishop_available_destinations(starting_cell, board_state)
    rook_destinations + bishop_destinations
  end

  private

  def rook_available_destinations(starting_cell, board_state)
    # reads board state to determine which cells are available to it from the starting cell
    available_destinations = available_destinations_up(starting_cell, board_state)
    available_destinations += available_destinations_right(starting_cell, board_state)
    available_destinations += available_destinations_down(starting_cell, board_state)
    available_destinations += available_destinations_left(starting_cell, board_state)
    available_destinations
  end

  # rubocop: disable Metrics
  def available_destinations_up(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = board_state[row + 1][column] unless row == 7
    loop do
      break if row == 7

      if next_cell.piece.nil?
        available_destinations << next_cell
      # if next cell is not empty, add unless owner is you, then break
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      # increment row up by 1 and update next cell
      row += 1
      next_cell = board_state[row + 1][column] unless row == 7
    end
    available_destinations
  end
  # rubocop: enable Metrics

  # rubocop: disable Metrics
  def available_destinations_right(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = board_state[row][column + 1] unless column == 7
    loop do
      break if column == 7

      if next_cell.piece.nil?
        available_destinations << next_cell
      # if next cell is not empty, add unless owner is you, then break
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      # increment row up by 1 and update next cell
      column += 1
      next_cell = board_state[row][column + 1] unless column == 7
    end
    available_destinations
  end
  # rubocop: enable Metrics

  # rubocop: disable Metrics
  def available_destinations_down(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = board_state[row - 1][column] unless row == 0
    loop do
      break if row == 0

      if next_cell.piece.nil?
        available_destinations << next_cell
      # if next cell is not empty, add unless owner is you, then break
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      # increment row up by 1 and update next cell
      row -= 1
      next_cell = board_state[row - 1][column] unless row == 0
    end
    available_destinations
  end
  # rubocop: enable Metrics

  # rubocop: disable Metrics
  def available_destinations_left(starting_cell, board_state)
    available_destinations = []
    row = starting_cell.position[0]
    column = starting_cell.position[1]
    next_cell = board_state[row][column - 1] unless column == 0
    loop do
      break if column == 0

      if next_cell.piece.nil?
        available_destinations << next_cell
      # if next cell is not empty, add unless owner is you, then break
      else
        available_destinations << next_cell unless next_cell.piece.owner == owner
        break
      end
      # increment row up by 1 and update next cell
      column -= 1
      next_cell = board_state[row][column - 1] unless column == 0
    end
    available_destinations
  end
  # rubocop: enable Metrics

  def bishop_available_destinations(starting_cell, board_state)
    available_destinations = available_destinations_down_right(starting_cell, board_state)
    available_destinations += available_destinations_up_right(starting_cell, board_state)
    available_destinations += available_destinations_up_left(starting_cell, board_state)
    available_destinations += available_destinations_down_left(starting_cell, board_state)
    available_destinations
  end

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

  def determine_symbol(color)
    case color
    when 'White' then "\u2655".encode('utf-8')
    when 'Black' then "\u265B".encode('utf-8')
    end
  end
end
