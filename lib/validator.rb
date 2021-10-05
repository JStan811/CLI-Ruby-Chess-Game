# frozen_string_literal: true
# represents an entity to validates if a given move is valid
# used to be a part of Board, but I split it out

# rubocop: disable Metrics/ClassLength
class Validator
  def valid_notation?(player_action)
    return false unless player_action.is_a? String

    # my simple notation is '"starting cell""target cell"', eg 'e3a4'
    player_action.match?(/^[a-h][1-8][a-h][1-8]$/)
  end

  def different_start_and_end_cells?(starting_cell, ending_cell)
    starting_cell != ending_cell
  end

  def starting_cell_contains_own_piece?(starting_cell, player_taking_action)
    return false if starting_cell.piece.nil?

    piece_owner = starting_cell.piece.owner
    player_taking_action == piece_owner
  end

  def legal_move?(starting_cell, ending_cell, board_state)
    piece = starting_cell.piece
    available_destinations = piece.available_destinations(starting_cell, board_state)
    available_destinations.include?(ending_cell)
  end

  def own_king_into_check?(ending_cell, player, board_state)
    result = false
    # run available_destinations for every opponent's piece on the board and
    # seeing if the ending cell is in any of them
    board_state.each do |row|
      row.each do |cell|
        # skip cell if its empty or if you own the piece in it
        next if cell.piece.nil? || cell.piece.owner == player

        # your king is in check if any of your opponent's pieces legal moves
        # capture it
        result = true if cell.piece.available_destinations(cell, board_state).include?(ending_cell)
      end
    end
    result
  end

  def self_check?(player, board_state)
    result = false
    # find player's King's cell
    king_cell = find_self_king_cell(player, board_state)
    # run available_destinations for every opponent's piece on the board and
    # seeing if your king's cell is in any of them
    board_state.each do |row|
      row.each do |cell|
        # skip cell if its empty or if you own the piece in it
        next if cell.piece.nil? || cell.piece.owner == player

        # your king is in check if any of your opponent's pieces legal moves
        # capture it
        result = true if cell.piece.available_destinations(cell, board_state).include?(king_cell)
      end
    end
    result
  end

  def opponent_check?(player, board_state)
    result = false
    # find player's opp's King's cell
    opp_king_cell = find_opp_king_cell(player, board_state)
    # run available_destinations for all of your pieces on the board and
    # seeing if opp's king's cell is in any of them
    board_state.each do |row|
      row.each do |cell|
        # skip cell if its empty or if opp owns the piece in it
        next if cell.piece.nil? || cell.piece.owner != player

        # your opp's king is in check if any of your pieces' legal moves
        # capture it
        result = true if cell.piece.available_destinations(cell, board_state).include?(opp_king_cell)
      end
    end
    result
  end

  # this is redundant with the other check checks
  def opp_check_from_cell?(cell_to_eval, player, board_state)
    result = false
    # evaluate whether any of your pieces are able to capture the king in the
    # cell_to_eval
    board_state.each do |row|
      row.each do |cell|
        # skip cell if its empty or if opp owns the piece in it
        next if cell.piece.nil? || cell.piece.owner != player

        # your opp's king is in check if any of your pieces' legal moves
        # capture it
        result = true if cell.piece.available_destinations(cell, board_state).include?(cell_to_eval)
      end
    end
    result
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

  def last_row_positions
    [[7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7]]
  end

  def first_row_positions
    [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]]
  end

  # rubocop: disable Metrics
  def opp_check_mate?(player, board_state)
    return false unless opponent_check?(player, board_state)

    result = true
    # find player's opp's king cell
    opp_king_cell = find_opp_king_cell(player, board_state)

    # find all opp's king's available destinations and see if it is in check
    # all of them
    opp_king_available_destinations = opp_king_cell.piece.available_destinations(opp_king_cell, board_state)

    # does nothing (leaving result as true) if King has 0 available destinations
    opp_king_available_destinations.each do |dest|
      result = false unless opp_check_from_cell?(dest, player, board_state)
    end
    # break out of function if false at this point b/c it means King can move
    # to a safe position
    return result if result == false

    # need to add: check to make sure any opponent's piece can't block or
    # capture your piece that would capture the king.

    # collect all cells with opponent's pieces except the king
    cells_with_opp_pieces = []
    board_state.each do |row|
      row.each do |cell|
        if !cell.piece.nil? && cell.piece.owner != player && !cell.piece.instance_of?(King)
          cells_with_opp_pieces << cell
        end
      end
    end

    # for each of opp's pieces, simulate all available moves one at a time,
    # then see if check is still active. If so, return false, breaking the
    # loops and the method. This should cover both blocks of the attacker and
    # captures of the attacker
    cells_with_opp_pieces.each do |cell|
      cell.piece.available_destinations(cell, board_state).each do |dest|
        dest_piece = nil
        dest_piece = dest.piece unless dest.piece.nil?
        dest.place_piece(cell.piece)
        cell.remove_piece
        unless opponent_check?(player, board_state)
          result = false
          # return board to how it was before simulation
          cell.place_piece(dest.piece)
          dest.remove_piece
          dest.place_piece(dest_piece) unless dest_piece.nil?
          return result
        end
        # return board to how it was before simulation
        cell.place_piece(dest.piece)
        dest.remove_piece
        dest.place_piece(dest_piece) unless dest_piece.nil?
      end
    end

    result
  end
  # rubocop: enable Metrics

  def find_self_king_cell(player, board_state)
    self_king_cell = nil
    board_state.each do |row|
      row.each do |cell|
        # skip cell if its empty or if your opp owns the piece in it
        next if cell.piece.nil? || cell.piece.owner != player

        self_king_cell = cell if cell.piece.instance_of?(King)
      end
    end
    self_king_cell
  end

  def find_opp_king_cell(player, board_state)
    opp_king_cell = nil
    board_state.each do |row|
      row.each do |cell|
        # skip cell if its empty or if you own the piece in it
        next if cell.piece.nil? || cell.piece.owner == player

        opp_king_cell = cell if cell.piece.instance_of?(King)
      end
    end
    opp_king_cell
  end

  # Not currently in use - if I want to combine all of the validations into one
  # step:
  def valid_action?(player_action, player, starting_cell, ending_cell, board_state)
    valid_notation?(player_action) && different_start_and_end_cells?(starting_cell, ending_cell) && starting_cell_contains_own_piece?(starting_cell, player) && legal_move?(staring_cell, ending_cell, board_state)
  end
end
# rubocop: enable Metrics/ClassLength
