# frozen_string_literal: true

require_relative '../lib/rook'
require_relative '../lib/board'
require_relative '../lib/cell'

# rubocop: disable Metrics/BlockLength
describe Rook do
  describe '#available_destinations' do
    subject(:rook) { described_class.new('White', 'Player 1') }
    let(:board) { Board.new }
    # the expected result from d4 on an empty board is an array of cell's with
    # these positions: [4, 3], [5, 3], [6, 3], [7, 3], [3, 4], [3, 5], [3, 6], #
    # [3, 7], [2, 3], [1, 3], [0, 3], [3, 2], [3, 1], [3, 0]

    context 'when rook is at d4 and board is otherwise empty' do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }

      it 'returns list with 14 positions' do
        expect(rook.available_destinations(starting_cell, board_state).length).to eq 14
      end

      it "returns list with the first cell's position [4, 3]" do
        expect(rook.available_destinations(starting_cell, board_state)[0].position).to eq [4, 3]
      end

      it "returns list with the fifth cell's position [3, 4]" do
        expect(rook.available_destinations(starting_cell, board_state)[4].position).to eq [3, 4]
      end

      it "returns list with the last cell's position [3, 0]" do
        expect(rook.available_destinations(starting_cell, board_state)[13].position).to eq [3, 0]
      end
    end

    context "when rook is at d4 and blocked on all sides by its own player's piece's" do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }
      let(:up_piece) { Rook.new('White', 'Player 1') }
      let(:right_piece) { Rook.new('White', 'Player 1') }
      let(:down_piece) { Rook.new('White', 'Player 1') }
      let(:left_piece) { Rook.new('White', 'Player 1') }

      before do
        board.cells[4][3].instance_variable_set(:@piece, up_piece)
        board.cells[3][4].instance_variable_set(:@piece, right_piece)
        board.cells[2][3].instance_variable_set(:@piece, down_piece)
        board.cells[3][2].instance_variable_set(:@piece, left_piece)
      end

      it 'returns an empty list' do
        expect(rook.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end

    context "when rook is at d4 and blocked on 2 sides by its own player's piece's and other 2 sides by opponent's" do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }
      let(:up_piece) { Rook.new('White', 'Player 1') }
      let(:right_piece) { Rook.new('White', 'Player 1') }
      let(:down_piece) { Rook.new('Black', 'Player 2') }
      let(:left_piece) { Rook.new('Black', 'Player 2') }

      before do
        board.cells[4][3].instance_variable_set(:@piece, up_piece)
        board.cells[3][4].instance_variable_set(:@piece, right_piece)
        board.cells[2][3].instance_variable_set(:@piece, down_piece)
        board.cells[3][2].instance_variable_set(:@piece, left_piece)
      end

      it 'returns a list with 2 positions' do
        expect(rook.available_destinations(starting_cell, board_state).length).to eq 2
      end
    end

    context "when rook is at d4 and blocked by 2 own piece's, the 1st 1 cell above and the 2nd 3 cells left" do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }
      let(:up_piece) { Rook.new('White', 'Player 1') }
      let(:left_piece) { Rook.new('White', 'Player 1') }

      before do
        board.cells[4][3].instance_variable_set(:@piece, up_piece)
        board.cells[3][0].instance_variable_set(:@piece, left_piece)
      end

      it 'returns a list with 9 positions' do
        expect(rook.available_destinations(starting_cell, board_state).length).to eq 9
      end
    end

    context 'when rook is at a1 and blocked on its right' do
      let(:starting_cell) { board.cells[0][0] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { Rook.new('White', 'Player 1') }

      before do
        board.cells[0][1].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns list with 7 positions' do
        starting_cell = board.cells[0][0]
        board_state = board.cells
        expect(rook.available_destinations(starting_cell, board_state).length).to eq 7
      end

      it "returns list with the first cell's position [1, 0]" do
        expect(rook.available_destinations(starting_cell, board_state)[0].position).to eq [1, 0]
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
