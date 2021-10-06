# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/bishop'


# rubocop: disable Metrics/BlockLength
describe Bishop do
  describe '#available_destinations' do
    subject(:bishop) { described_class.new('White', 'Player 1') }
    let(:board) { Board.new }
    # the expected result from d4 on an otherwise empty board is an array of
    # cell's with these positions: [2, 4], [1, 5], [0, 6], [4, 4], [5, 5],
    # [6,6], [7, 7], [4, 2], [5, 1], [6, 0], [2, 2], [1, 1], [0, 0]

    context 'when bishop is at d4 and board is otherwise empty' do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }

      it 'returns list with 13 positions' do
        board_state = board.cells
        expect(bishop.available_destinations(starting_cell, board_state).length).to eq 13
      end

      it "returns list with the first cell's position [2, 4]" do
        board_state = board.cells
        expect(bishop.available_destinations(starting_cell, board_state)[0].position).to eq [2, 4]
      end

      it "returns list with the fifth cell's position [5, 5]" do
        board_state = board.cells
        expect(bishop.available_destinations(starting_cell, board_state)[4].position).to eq [5, 5]
      end

      it "returns list with the last cell's position [0, 0]" do
        board_state = board.cells
        expect(bishop.available_destinations(starting_cell, board_state)[12].position).to eq [0, 0]
      end
    end

    context "when bishop is at d4 and blocked on all sides by its own player's piece's" do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }
      let(:down_right_piece) { Bishop.new('White', 'Player 1') }
      let(:up_right_piece) { Bishop.new('White', 'Player 1') }
      let(:up_left_piece) { Bishop.new('White', 'Player 1') }
      let(:down_left_piece) { Bishop.new('White', 'Player 1') }

      before do
        board.cells[2][4].instance_variable_set(:@piece, down_right_piece)
        board.cells[4][4].instance_variable_set(:@piece, up_right_piece)
        board.cells[4][2].instance_variable_set(:@piece, up_left_piece)
        board.cells[2][2].instance_variable_set(:@piece, down_left_piece)
      end

      it 'returns an empty list' do
        expect(bishop.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end

    context "when bishop is at d4 and blocked on 2 sides by its own player's piece's and other 2 sides by opponent's" do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }
      let(:down_right_piece) { Bishop.new('White', 'Player 1') }
      let(:up_right_piece) { Bishop.new('White', 'Player 1') }
      let(:up_left_piece) { Bishop.new('Black', 'Player 2') }
      let(:down_left_piece) { Bishop.new('Black', 'Player 2') }

      before do
        board.cells[2][4].instance_variable_set(:@piece, down_right_piece)
        board.cells[4][4].instance_variable_set(:@piece, up_right_piece)
        board.cells[4][2].instance_variable_set(:@piece, up_left_piece)
        board.cells[2][2].instance_variable_set(:@piece, down_left_piece)
      end

      it 'returns a list with 2 positions' do
        expect(bishop.available_destinations(starting_cell, board_state).length).to eq 2
      end
    end

    context "when bishop is at d4 and blocked by 2 own piece's, the 1st 1 cell down left and the 2nd 3 cells up right" do
      let(:starting_cell) { board.cells[3][3] }
      let(:board_state) { board.cells }
      let(:down_left_piece) { Bishop.new('White', 'Player 1') }
      let(:up_right_piece) { Bishop.new('White', 'Player 1') }

      before do
        board.cells[2][4].instance_variable_set(:@piece, down_left_piece)
        board.cells[6][6].instance_variable_set(:@piece, up_right_piece)
      end

      it 'returns a list with 8 positions' do
        expect(bishop.available_destinations(starting_cell, board_state).length).to eq 8
      end
    end

    context 'when bishop is at a1 and blocked on its up right' do
      let(:starting_cell) { board.cells[0][0] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { Bishop.new('White', 'Player 1') }

      before do
        board.cells[1][1].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns an empty list' do
        starting_cell = board.cells[0][0]
        board_state = board.cells
        expect(bishop.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
