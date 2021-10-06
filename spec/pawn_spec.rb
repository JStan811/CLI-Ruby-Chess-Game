# frozen_string_literal: true

require_relative '../lib/pawn'
require_relative '../lib/board'
require_relative '../lib/cell'

# rubocop: disable Metrics/BlockLength
describe Pawn do
  describe '#available_destinations' do
    subject(:white_pawn) { described_class.new('White', 'Player 1') }
    let(:board) { Board.new }

    context 'when white pawn is on d2 with no blocks' do
      let(:starting_cell) { board.cells[1][3] }
      let(:board_state) { board.cells }

      it 'returns list with 2 positions' do
        expect(white_pawn.available_destinations(starting_cell, board_state).length).to eq 2
      end

      it "returns a list with 1st cell's position [2, 3]" do
        expect(white_pawn.available_destinations(starting_cell, board_state)[0].position).to eq [2, 3]
      end

      it "returns a list with 2nd cell's position [3, 3]" do
        expect(white_pawn.available_destinations(starting_cell, board_state)[1].position).to eq [3, 3]
      end
    end

    context 'when white pawn is on d3 with own pawn directly in front' do
      let(:starting_cell) { board.cells[2][3] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { Pawn.new('White', 'Player 1') }

      before do
        board.cells[3][3].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns an empty list' do
        expect(white_pawn.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end

    context "when white pawn is on d3 with opponent's pawn directly in front" do
      let(:starting_cell) { board.cells[2][3] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { Pawn.new('Black', 'Player 2') }

      before do
        board.cells[3][3].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns an empty list' do
        expect(white_pawn.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end

    context 'when white pawn is on d2 with own pawn directly in front' do
      let(:starting_cell) { board.cells[1][3] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { Pawn.new('White', 'Player 1') }

      before do
        board.cells[2][3].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns an empty list' do
        expect(white_pawn.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end

    context "when white pawn is on d2 with opponent's pawn directly in front" do
      let(:starting_cell) { board.cells[1][3] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { Pawn.new('Black', 'Player 2') }

      before do
        board.cells[2][3].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns an empty list' do
        expect(white_pawn.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end

    context 'when white pawn is on d3 with both diagonals open and no blocks' do
      let(:starting_cell) { board.cells[2][3] }
      let(:board_state) { board.cells }
      let(:up_right_piece) { Pawn.new('Black', 'Player 2') }
      let(:up_left_piece) { Pawn.new('Black', 'Player 2') }

      before do
        board.cells[3][4].instance_variable_set(:@piece, up_right_piece)
        board.cells[3][2].instance_variable_set(:@piece, up_left_piece)
      end

      it 'returns list with 3 cells' do
        expect(white_pawn.available_destinations(starting_cell, board_state).length).to eq 3
      end
    end

    subject(:black_pawn) { described_class.new('Black', 'Player 2') }

    context 'when black pawn is on d7 with no blocks' do
      let(:starting_cell) { board.cells[6][3] }
      let(:board_state) { board.cells }

      it 'returns list with 2 positions' do
        expect(black_pawn.available_destinations(starting_cell, board_state).length).to eq 2
      end

      it "returns a list with 1st cell's position [5, 3]" do
        expect(black_pawn.available_destinations(starting_cell, board_state)[0].position).to eq [5, 3]
      end

      it "returns a list with 2nd cell's position [4, 3]" do
        expect(black_pawn.available_destinations(starting_cell, board_state)[1].position).to eq [4, 3]
      end
    end

    context 'when black pawn is on d6 with own pawn directly in front' do
      let(:starting_cell) { board.cells[5][3] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { Pawn.new('Black', 'Player 2') }

      before do
        board.cells[4][3].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns an empty list' do
        expect(black_pawn.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end

    context "when black pawn is on d6 with opponent's pawn directly in front" do
      let(:starting_cell) { board.cells[5][3] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { Pawn.new('White', 'Player 1') }

      before do
        board.cells[4][3].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns an empty list' do
        expect(black_pawn.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end

    context 'when black pawn is on d7 with own pawn directly in front' do
      let(:starting_cell) { board.cells[6][3] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { Pawn.new('Black', 'Player 2') }

      before do
        board.cells[5][3].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns an empty list' do
        expect(black_pawn.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end

    context "when black pawn is on d7 with opponent's pawn directly in front" do
      let(:starting_cell) { board.cells[6][3] }
      let(:board_state) { board.cells }
      let(:blocking_piece) { Pawn.new('White', 'Player 1') }

      before do
        board.cells[5][3].instance_variable_set(:@piece, blocking_piece)
      end

      it 'returns an empty list' do
        expect(black_pawn.available_destinations(starting_cell, board_state).length).to eq 0
      end
    end

    context 'when black pawn is on d6 with both diagonals open and no blocks' do
      let(:starting_cell) { board.cells[5][3] }
      let(:board_state) { board.cells }
      let(:down_right_piece) { Pawn.new('White', 'Player 1') }
      let(:down_left_piece) { Pawn.new('White', 'Player 1') }

      before do
        board.cells[4][2].instance_variable_set(:@piece, down_right_piece)
        board.cells[4][4].instance_variable_set(:@piece, down_left_piece)
      end

      it 'returns list with 3 cells' do
        expect(black_pawn.available_destinations(starting_cell, board_state).length).to eq 3
      end
    end
  end
end
