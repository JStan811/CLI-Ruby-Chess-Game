# frozen_string_literal: true
# represents an entity to validates if a given move is valid
# used to be a part of Board, but I split it out
class Validator
  def valid_notation?(player_action)
    return false unless player_action.is_a? String

    # my simple notation is '"starting cell""target cell"', eg 'e3a4'
    player_action.match?(/[a-h][1-8][a-h][1-8]/)
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
    board_state.each do |cell|
      # skip cell if its empty or if you own the piece in it
      next if cell.piece.nil? || cell.piece.owner == player

      # your king is in check if any of your opponent's pieces legal moves
      # capture it
      result = true if cell.piece.available_destinations(cell, board_state).include?(ending_cell)
    end
    result
  end

  # if I want to combine all of the validations into one step:
  def valid_action?(player_action, player, starting_cell, ending_cell, board_state)
    valid_notation?(player_action) && different_start_and_end_cells?(starting_cell, ending_cell) && starting_cell_contains_own_piece?(starting_cell, player) && legal_move?(staring_cell, ending_cell, board_state)
  end
end
