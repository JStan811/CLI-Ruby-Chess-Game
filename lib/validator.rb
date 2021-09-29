# frozen_string_literal: true

# rubocop: disable Metrics/ClassLength
# represents an entity to validates if a given move is valid
# used to be a part of Board, but I split it out
class Validator
  def valid_move?
    # is given move for given piece a valid destination?
    # is there a piece already at the target? if own, invalid. If opponent's,
    # valid
    # is there a piece blocking the way (except for King, Pawn, and Knight)
  end

  def create_valid_destination_list(piece_type, starting_row_index, starting_column_index, color = nil)
    case piece_type
    when 'Rook'
      create_rook_valid_destination_list(starting_row_index, starting_column_index)
    when 'Knight'
      create_knight_valid_destination_list(starting_row_index, starting_column_index)
    when 'Bishop'
      create_bishop_valid_destination_list(starting_row_index, starting_column_index)
    when 'Queen'
      create_queen_valid_destination_list(starting_row_index, starting_column_index)
    when 'King'
      create_king_valid_destination_list(starting_row_index, starting_column_index)
    when 'Pawn'
      create_pawn_valid_destination_list(color, starting_row_index, starting_column_index)
    end
  end

  private

  def create_rook_valid_destination_list(starting_row_index, starting_column_index)
    rook_destinations = []
    for i in 0..7 do
      rook_destinations << [i, starting_column_index]
    end
    for i in 0..7 do
      rook_destinations << [starting_row_index, i]
    end
    rook_destinations.delete [starting_column_index, starting_row_index]
    rook_destinations
  end

  def create_knight_valid_destination_list(starting_row_index, starting_column_index)
    knight_destinations = []
    r = starting_row_index
    c = starting_column_index
    knight_destinations << [r - 2, c + 1] if valid_position?(r - 2, c + 1)
    knight_destinations << [r - 1, c + 2] if valid_position?(r - 1, c + 2)
    knight_destinations << [r + 1, c + 2] if valid_position?(r + 1, c + 2)
    knight_destinations << [r + 2, c + 1] if valid_position?(r + 2, c + 1)
    knight_destinations << [r + 2, c - 1] if valid_position?(r + 2, c - 1)
    knight_destinations << [r + 1, c - 2] if valid_position?(r + 1, c - 2)
    knight_destinations << [r - 1, c - 2] if valid_position?(r - 1, c - 2)
    knight_destinations << [r - 2, c - 1] if valid_position?(r - 2, c - 1)
    knight_destinations
  end

  def valid_position?(row_index, column_index)
    return false if row_index.negative? || row_index > 7 || column_index.negative? || column_index > 7

    true
  end

  # iterative approach to build this. Could probably have gone recursive instead
  def create_bishop_valid_destination_list(starting_row_index, starting_column_index)
    bishop_destinations = add_diagonal_down_right_destinations(starting_row_index, starting_column_index)

    bishop_destinations += add_diagonal_up_right_destinations(starting_row_index, starting_column_index)

    bishop_destinations += add_diagonal_up_left_destinations(starting_row_index, starting_column_index)

    bishop_destinations += add_diagonal_down_left_destinations(starting_row_index, starting_column_index)

    bishop_destinations
  end

  def add_diagonal_down_right_destinations(starting_row_index, starting_column_index)
    destinations = []
    r = starting_row_index
    c = starting_column_index
    until r == 0 || r == 7 || c == 0 || c == 7
      destinations << [r - 1, c + 1]
      r = r - 1
      c = c + 1
    end
    destinations
  end

  def add_diagonal_up_right_destinations(starting_row_index, starting_column_index)
    destinations = []
    r = starting_row_index
    c = starting_column_index
    until r == 0 || r == 7 || c == 0 || c == 7
      destinations << [r + 1, c + 1]
      r = r + 1
      c = c + 1
    end
    destinations
  end

  def add_diagonal_up_left_destinations(starting_row_index, starting_column_index)
    destinations = []
    r = starting_row_index
    c = starting_column_index
    until r == 0 || r == 7 || c == 0 || c == 7
      destinations << [r + 1, c - 1]
      r = r + 1
      c = c -1
    end
    destinations
  end

  def add_diagonal_down_left_destinations(starting_row_index, starting_column_index)
    destinations = []
    r = starting_row_index
    c = starting_column_index
    until r == 0 || r == 7 || c == 0 || c == 7
      destinations << [r - 1, c - 1]
      r = r - 1
      c = c - 1
    end
    destinations
  end

  def create_queen_valid_destination_list(starting_row_index, starting_column_index)
    rook_destinations = create_rook_valid_destination_list(starting_row_index, starting_column_index)
    bishop_destinations = create_bishop_valid_destination_list(starting_row_index, starting_column_index)
    rook_destinations + bishop_destinations
  end

  def create_king_valid_destination_list(starting_row_index, starting_column_index)
    king_destinations = []
    r = starting_row_index
    c = starting_column_index
    king_destinations << [r - 1, c] if valid_position?(r - 1, c)
    king_destinations << [r - 1, c + 1] if valid_position?(r - 1, c + 1)
    king_destinations << [r, c + 1] if valid_position?(r, c + 1)
    king_destinations << [r + 1, c + 1] if valid_position?(r + 1, c + 1)
    king_destinations << [r + 1, c] if valid_position?(r + 1, c)
    king_destinations << [r + 1, c - 1] if valid_position?(r + 1, c - 1)
    king_destinations << [r, c - 1] if valid_position?(r, c - 1)
    king_destinations << [r - 1, c - 1] if valid_position?(r - 1, c - 1)
    king_destinations
  end

  def create_pawn_valid_destination_list(color, starting_row_index, starting_column_index)
    case color
    when 'White'
      create_white_pawn_valid_destination_list(starting_row_index, starting_column_index)
    when 'Black'
      create_black_pawn_valid_destination_list(starting_row_index, starting_column_index)
    end
  end

  def create_white_pawn_valid_destination_list(starting_row_index, starting_column_index)
    white_pawn_destinations = []
    r = starting_row_index
    c = starting_column_index
    white_pawn_destinations << [r + 1, c]
    white_pawn_destinations << [r + 1, c - 1]
    white_pawn_destinations << [r + 1, c + 1]
    white_pawn_destinations << [r + 2, c] if starting_row_index == 1
    white_pawn_destinations
  end

  def create_black_pawn_valid_destination_list(starting_row_index, starting_column_index)
    black_pawn_destinations = []
    r = starting_row_index
    c = starting_column_index
    black_pawn_destinations << [r - 1, c]
    black_pawn_destinations << [r - 1, c - 1]
    black_pawn_destinations << [r - 1, c + 1]
    black_pawn_destinations << [r - 2, c] if starting_row_index == 7
    black_pawn_destinations
  end
end

# rubocop: enable Metrics/ClassLength
