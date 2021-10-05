# frozen_string_literal: true

# rubocop: disable Metrics/ClassLength
# This entity performs all game related validations and checks for specific
# game states.
class Validator
  def valid_notation?(player_action)
    return false unless player_action.is_a? String

    # Notation is '"starting cell""target cell"', eg 'e3a4'
    player_action.match?(/^[a-h][1-8][a-h][1-8]$/)
  end

  def different_start_and_end_cells?(starting_cell, ending_cell)
    starting_cell != ending_cell
  end

  def starting_cell_contains_own_piece?(starting_cell, player_taking_action)
    return false if starting_cell.piece.nil?

    player_taking_action == starting_cell.piece.owner
  end

  def legal_move?(starting_cell, ending_cell, board_state)
    starting_cell.piece.available_destinations(starting_cell, board_state).include?(ending_cell)
  end

  def moving_own_king_into_check?(ending_cell, player, board_state)
    board_state.each do |row|
      row.each do |cell|
        next if cell.piece.nil? || cell.piece.owner == player

        return true if cell.piece.available_destinations(cell, board_state).include?(ending_cell)
      end
    end
    false
  end

  def king_in_check?(player, board_state)
    board_state.each do |row|
      row.each do |cell|
        next if cell.piece.nil? || cell.piece.owner == player

        return true if cell.piece.available_destinations(cell, board_state).include?(king_cell(player, board_state))
      end
    end
    false
  end

  def pawn_promotion?(player_color, ending_cell)
    pawn_promotion = false
    case player_color
    when 'White'
      pawn_promotion = true if ending_cell.piece.instance_of?(Pawn) && last_row_positions.include?(ending_cell.position)
    when 'Black'
      pawn_promotion = true if ending_cell.piece.instance_of?(Pawn) && first_row_positions.include?(ending_cell.position)
    end
    pawn_promotion
  end

  def opponent_check_mate?(player, board_state)
    return false unless opponent_in_check?(opponent_king_cell(player, board_state), player, board_state)

    opponent_king_cell = opponent_king_cell(player, board_state)
    opponent_king_available_destinations = opponent_king_cell.piece.available_destinations(opponent_king_cell, board_state)

    opponent_king_available_destinations.each do |dest_cell|
      return false unless opponent_in_check?(dest_cell, player, board_state)
    end

    return false if possible_opponent_move_can_break_checkmate?(player, board_state)

    true
  end

  def opponent_stale_mate?(player, board_state)
    return false if opponent_in_check?(opponent_king_cell(player, board_state), player, board_state)

    opponent_king_cell = opponent_king_cell(player, board_state)
    opponent_king_available_destinations = opponent_king_cell.piece.available_destinations(opponent_king_cell, board_state)

    opponent_king_available_destinations.each do |dest_cell|
      return false unless opponent_in_check?(dest_cell, player, board_state)
    end

    return false if possible_opponent_move_can_break_checkmate?(player, board_state)

    true
  end

  private

  def opponent_in_check?(king_cell, player, board_state)
    board_state.each do |row|
      row.each do |cell|
        next if cell.piece.nil? || cell.piece.owner != player

        return true if cell.piece.available_destinations(cell, board_state).include?(king_cell)
      end
    end
    false
  end

  def last_row_positions
    [[7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]]
  end

  def first_row_positions
    [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
  end

  def king_cell(player, board_state)
    king_cell = nil
    board_state.each do |row|
      row.each do |cell|
        next if cell.piece.nil? || cell.piece.owner != player

        king_cell = cell if cell.piece.instance_of?(King)
      end
    end
    king_cell
  end

  def opponent_king_cell(player, board_state)
    opponent_king_cell = nil
    board_state.each do |row|
      row.each do |cell|
        next if cell.piece.nil? || cell.piece.owner == player

        opponent_king_cell = cell if cell.piece.instance_of?(King)
      end
    end
    opponent_king_cell
  end

  # rubocop: disable Metrics/MethodLength
  def possible_opponent_move_can_break_checkmate?(player, board_state)
    cells_with_opponent_pieces_except_king(player, board_state).each do |cell|
      cell.piece.available_destinations(cell, board_state).each do |dest_cell|
        dest_piece = dest_cell.piece.nil? ? nil : dest_cell.piece
        simulate_piece_movement(cell, dest_cell)
        unless opponent_in_check?(opponent_king_cell(player, board_state), player, board_state)
          return_board_to_pre_simulation_state(cell, dest_cell, dest_piece)
          return true
        end
        return_board_to_pre_simulation_state(cell, dest_cell, dest_piece)
      end
    end
    false
  end
  # rubocop: enable Metrics/MethodLength

  def simulate_piece_movement(cell, dest_cell)
    dest_cell.place_piece(cell.piece)
    cell.remove_piece
  end

  def return_board_to_pre_simulation_state(cell, dest_cell, dest_piece)
    cell.place_piece(dest_cell.piece)
    dest_cell.remove_piece
    dest_cell.place_piece(dest_piece) unless dest_piece.nil?
  end

  def cells_with_opponent_pieces_except_king(player, board_state)
    cells_with_opponent_pieces_except_king = []
    board_state.each do |row|
      row.each do |cell|
        if !cell.piece.nil? && cell.piece.owner != player && !cell.piece.instance_of?(King)
          cells_with_opponent_pieces_except_king << cell
        end
      end
    end
    cells_with_opponent_pieces_except_king
  end
end
# rubocop: enable Metrics/ClassLength
