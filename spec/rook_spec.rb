# frozen_string_literal: true

require_relative '../lib/rook'
require_relative '../lib/board'
require_relative '../lib/cell'


# rubocop: disable Metrics/BlockLength
describe Rook do
  describe '#available_destinations' do
    subject(:rook) { described_class.new('White', 'Player 1', 'n/a') }
    let(:starting_cell) { Cell.new([3, 3]) }
    let(:board) { Board.new }
    # the expected_result is an array of cell's with these positions: [4, 3],
    # [5, 3], [6, 3], [7, 3], [3, 4], [3, 5], [3, 6], [3, 7], [2, 3], [1, 3],
    # [0, 3], [3, 2], [3, 1], [3, 0]

    context 'when rook is at d4 and board is empty' do
      it 'returns list with 14 positions' do
        board_state = board.cells
        expect(rook.available_destinations(starting_cell, board_state).length).to eq 14
      end

      it "returns list with the first cell's position [4, 3]" do
        board_state = board.cells
        expect(rook.available_destinations(starting_cell, board_state)[0].position).to eq [4, 3]
      end

      it "returns list with the fifth cell's position [3, 4]" do
        board_state = board.cells
        expect(rook.available_destinations(starting_cell, board_state)[4].position).to eq [3, 4]
      end

      it "returns list with the last cell's position [3, 0]" do
        board_state = board.cells
        expect(rook.available_destinations(starting_cell, board_state)[13].position).to eq [3, 0]
      end
    end

    context "when rook is at d4 and blocked on all sides by its own player's piece's" do
      let(:up_piece) { Rook.new('White', 'Player 1', 'n/a') }
      let(:right_piece) { Rook.new('White', 'Player 1', 'n/a') }
      let(:down_piece) { Rook.new('White', 'Player 1', 'n/a') }
      let(:left_piece) { Rook.new('White', 'Player 1', 'n/a') }

      before do
        board.cells[4][3].instance_variable_set(:@piece, up_piece)
        board.cells[3][4].instance_variable_set(:@piece, right_piece)
        board.cells[2][3].instance_variable_set(:@piece, down_piece)
        board.cells[3][2].instance_variable_set(:@piece, left_piece)
      end

      it 'returns an empty list' do
        board_state = board.cells
        expect(rook.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end
  end
end
