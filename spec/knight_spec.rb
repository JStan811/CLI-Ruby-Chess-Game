# frozen_string_literal: true

require_relative '../lib/knight'
require_relative '../lib/board'
require_relative '../lib/cell'

# rubocop: disable Metrics/BlockLength
describe Knight do
  describe '#available_destinations' do
    subject(:knight) { described_class.new('White', 'Player 1') }
    let(:board) { Board.new }
    # the expected result from d4 on an other empty board is an array of cell's
    # with these positions: [1, 4], [2, 5], [4, 5], [5, 4], [5, 2], [4, 1],
    # [2, 1], [1, 2]

    context 'when knight is at d4 and board is otherwise empty' do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }

      it 'returns list with 8 positions' do
        expect(knight.available_destinations(starting_cell, board_state).length).to eq 8
      end

      it "returns list with the first cell's position [1, 4]" do
        expect(knight.available_destinations(starting_cell, board_state)[0].position).to eq [1, 4]
      end

      it "returns list with the fifth cell's position [5, 2]" do
        expect(knight.available_destinations(starting_cell, board_state)[4].position).to eq [5, 2]
      end

      it "returns list with the last cell's position [1, 2]" do
        expect(knight.available_destinations(starting_cell, board_state)[7].position).to eq [1, 2]
      end
    end

    context 'when knight is at a1' do
      it 'returns list with 2 positions' do
        starting_cell = board.cells[0][0]
        board_state = board.cells
        expect(knight.available_destinations(starting_cell, board_state).length).to eq 2
      end
    end

    context "when knight as at d4 and player's own piece is at e2" do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { Knight.new('White', 'Player 1') }

      before do
        board.cells[1][4].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns list with 7 positions' do
        expect(knight.available_destinations(starting_cell, board_state).length).to eq 7
      end

      it "returns list with the first cell's position [2, 5]" do
        expect(knight.available_destinations(starting_cell, board_state)[0].position).to eq [2, 5]
      end
    end
  end
end
