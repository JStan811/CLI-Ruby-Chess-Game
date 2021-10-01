# frozen_string_literal: true

require_relative '../lib/king'
require_relative '../lib/board'
require_relative '../lib/cell'

# rubocop: disable Metrics/BlockLength
describe King do
  describe '#available_destinations' do
    subject(:king) { described_class.new('White', 'Player 1') }
    let(:board) { Board.new }
    # the expected result from d4 on an other empty board is an array of cell's
    # with these positions: [2, 3], [2, 4], [3, 4], [4, 4], [4, 3], [4, 2],
    # [3, 2], [2, 2]

    context 'when king is at d4 and board is otherwise empty' do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }

      it 'returns list with 8 positions' do
        expect(king.available_destinations(starting_cell, board_state).length).to eq 8
      end

      it "returns list with the first cell's position [2, 3]" do
        expect(king.available_destinations(starting_cell, board_state)[0].position).to eq [2, 3]
      end

      it "returns list with the fifth cell's position [4, 3]" do
        expect(king.available_destinations(starting_cell, board_state)[4].position).to eq [4, 3]
      end

      it "returns list with the last cell's position [2, 2]" do
        expect(king.available_destinations(starting_cell, board_state)[7].position).to eq [2, 2]
      end
    end

    context 'when king is at a1' do
      it 'returns list with 3 positions' do
        starting_cell = board.cells[0][0]
        board_state = board.cells
        expect(king.available_destinations(starting_cell, board_state).length).to eq 3
      end
    end

    context "when king as at d4 and player's own piece is at d3" do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { King.new('White', 'Player 1') }

      before do
        board.cells[2][3].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns list with 7 positions' do
        expect(king.available_destinations(starting_cell, board_state).length).to eq 7
      end

      it "returns list with the first cell's position [2, 4]" do
        expect(king.available_destinations(starting_cell, board_state)[0].position).to eq [2, 4]
      end
    end
  end
end
