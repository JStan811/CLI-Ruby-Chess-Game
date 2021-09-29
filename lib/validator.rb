# frozen_string_literal: true

# rubocop: disable Metrics/ClassLength
# represents an entity to validates if a given move is valid
# used to be a part of Board, but I split it out
class Validator
  def valid_destination_for_piece?(player_action)
    starting_cell = convert_player_action_into_starting_cell(player_action)
    ending_cell = convert_player_action_into_ending_cell(player_action)
    # from starting cell, determine piece type and color
    valid_destination_list = create_valid_destination_list(starting_cell.piece.type, starting_cell.piece.color, starting_cell.position)

    valid_destination_list.include?(ending_cell.position)
  end

  def valid_notation?(player_action)
    return false unless player_action.is_a? String

    # my simple notation is '"starting cell""target cell"', eg 'e3a4'
    player_action.match?(/[a-h][1-8][a-h][1-8]/)
  end

  def starting_cell_contains_a_piece?(player_action)
    starting_cell = convert_player_action_into_starting_cell(player_action)
    !starting_cell.piece.nil?
  end

  def starting_cell_contains_own_piece?(player_action, player_taking_action)
    starting_cell = convert_player_action_into_starting_cell(player_action)
    piece_owner = starting_cell.piece.owner
    player_taking_action == piece_owner
  end

  private

  def convert_player_action_into_starting_cell(player_action)
    action_as_char_array = player_action.split('')
    # "notated" here means cell as player enters it (eg 'e4')
    notated_starting_cell = "#{action_as_char_array[0]}#{action_as_char_array[1]}"
    starting_cell_row_index = convert_notation_to_row_index(notated_starting_cell)
    starting_cell_column_index = convert_notation_to_column_index(notated_starting_cell)
    @board.cells[starting_cell_row_index][starting_cell_column_index]
  end

  def convert_player_action_into_ending_cell(player_action)
    action_as_char_array = player_action.split('')
    # "notated" here means cell as player enters it (eg 'e4')
    notated_ending_cell = "#{action_as_char_array[2]}#{action_as_char_array[3]}"
    ending_cell_row_index = convert_notation_to_row_index(notated_ending_cell)
    ending_cell_column_index = convert_notation_to_column_index(notated_ending_cell)
    @board.cells[ending_cell_row_index][ending_cell_column_index]
  end

  # default color to nil because only pawn needs color
  def create_valid_destination_list(piece_type, piece_color, starting_cell_position)
    case piece_type
    when 'Rook' then create_rook_valid_destination_list(starting_cell_position)
    when 'Knight' then create_knight_valid_destination_list(starting_cell_position)
    when 'Bishop' then create_bishop_valid_destination_list(starting_cell_position)
    when 'Queen' then create_queen_valid_destination_list(starting_cell_position)
    when 'King' then create_king_valid_destination_list(starting_cell_position)
    when 'Pawn' then create_pawn_valid_destination_list(piece_color, starting_cell_position)
    end
  end

  def create_rook_valid_destination_list(starting_cell_position)
    rook_destinations = []
    starting_row_index = starting_cell_position[0]
    starting_column_index = starting_cell_position[1]
    for i in 0..7 do
      rook_destinations << [starting_row_index, i]
    end
    for i in 0..7 do
      rook_destinations << [i, starting_column_index]
    end
    rook_destinations.delete [starting_column_index, starting_row_index]
    rook_destinations
  end

  def create_knight_valid_destination_list(starting_cell_position)
    knight_destinations = []
    r = starting_cell_position[0]
    c = starting_cell_position[1]
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
  def create_bishop_valid_destination_list(starting_cell_position)
    starting_row_index = starting_cell_position[0]
    starting_column_index = starting_cell_position[1]

    bishop_destinations = add_diagonal_down_right_destinations(starting_row_index, starting_column_index)

    bishop_destinations += add_diagonal_up_right_destinations(starting_row_index, starting_column_index)

    bishop_destinations += add_diagonal_up_left_destinations(starting_row_index, starting_column_index)

    bishop_destinations += add_diagonal_down_left_destinations(starting_row_index, starting_column_index)

    bishop_destinations
  end

  def add_diagonal_down_right_destinations(starting_cell_position)
    destinations = []
    r = starting_cell_position[0]
    c = starting_cell_position[1]
    until r == 0 || r == 7 || c == 0 || c == 7
      destinations << [r - 1, c + 1]
      r = r - 1
      c = c + 1
    end
    destinations
  end

  def add_diagonal_up_right_destinations(starting_cell_position)
    destinations = []
    r = starting_cell_position[0]
    c = starting_cell_position[1]
    until r == 0 || r == 7 || c == 0 || c == 7
      destinations << [r + 1, c + 1]
      r = r + 1
      c = c + 1
    end
    destinations
  end

  def add_diagonal_up_left_destinations(starting_cell_position)
    destinations = []
    r = starting_cell_position[0]
    c = starting_cell_position[1]
    until r == 0 || r == 7 || c == 0 || c == 7
      destinations << [r + 1, c - 1]
      r = r + 1
      c = c -1
    end
    destinations
  end

  def add_diagonal_down_left_destinations(starting_cell_position)
    destinations = []
    r = starting_cell_position[0]
    c = starting_cell_position[1]
    until r == 0 || r == 7 || c == 0 || c == 7
      destinations << [r - 1, c - 1]
      r = r - 1
      c = c - 1
    end
    destinations
  end

  def create_queen_valid_destination_list(starting_cell_position)
    rook_destinations = create_rook_valid_destination_list(starting_cell_position)
    bishop_destinations = create_bishop_valid_destination_list(starting_cell_position)
    rook_destinations + bishop_destinations
  end

  def create_king_valid_destination_list(starting_cell_position)
    king_destinations = []
    r = starting_cell_position[0]
    c = starting_cell_position[1]
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

  def create_pawn_valid_destination_list(color, starting_cell_position)
    case color
    when 'White'
      create_white_pawn_valid_destination_list(starting_cell_position)
    when 'Black'
      create_black_pawn_valid_destination_list(starting_cell_position)
    end
  end

  def create_white_pawn_valid_destination_list(starting_cell_position)
    white_pawn_destinations = []
    r = starting_cell_position[0]
    c = starting_cell_position[1]
    white_pawn_destinations << [r + 1, c]
    white_pawn_destinations << [r + 1, c - 1]
    white_pawn_destinations << [r + 1, c + 1]
    white_pawn_destinations << [r + 2, c] if starting_row_index == 1
    white_pawn_destinations
  end

  def create_black_pawn_valid_destination_list(starting_cell_position)
    black_pawn_destinations = []
    r = starting_cell_position[0]
    c = starting_cell_position[1]
    black_pawn_destinations << [r - 1, c]
    black_pawn_destinations << [r - 1, c - 1]
    black_pawn_destinations << [r - 1, c + 1]
    black_pawn_destinations << [r - 2, c] if starting_row_index == 7
    black_pawn_destinations
  end
end

# rubocop: enable Metrics/ClassLength
