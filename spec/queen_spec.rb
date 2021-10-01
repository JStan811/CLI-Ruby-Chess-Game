# frozen_string_literal: true

require_relative '../lib/queen'
require_relative '../lib/board'
require_relative '../lib/cell'

# rubocop: disable Metrics/BlockLength
describe Queen do
  describe '#available_destinations' do
    subject(:queen) { described_class.new('White', 'Player 1') }
    let(:board) { Board.new }
    # the expected result from d4 on an empty board is an array of cell's with
    # these positions: [4, 3], [5, 3], [6, 3], [7, 3], [3, 4], [3, 5], [3, 6], #
    # [3, 7], [2, 3], [1, 3], [0, 3], [3, 2], [3, 1], [3, 0], [2, 4], [1, 5],
    # [0, 6], [4, 4], [5, 5], [6,6], [7, 7], [4, 2], [5, 1], [6, 0], [2, 2],
    # [1, 1], [0, 0]

    context 'when queen is at d4 and board is otherwise empty' do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }

      it 'returns list with 27 positions' do
        expect(queen.available_destinations(starting_cell, board_state).length).to eq 27
      end

      it "returns list with the first cell's position [4, 3]" do
        expect(queen.available_destinations(starting_cell, board_state)[0].position).to eq [4, 3]
      end

      it "returns list with the 20th cell's position [6, 6]" do
        expect(queen.available_destinations(starting_cell, board_state)[19].position).to eq [6, 6]
      end

      it "returns list with the last cell's position [0, 0]" do
        expect(queen.available_destinations(starting_cell, board_state)[26].position).to eq [0, 0]
      end
    end
  end

  # I'm stopping testing here because this has already been tested in the rook
  # and knight tests. Queen's method is just adding the results of these two
  # together
end
