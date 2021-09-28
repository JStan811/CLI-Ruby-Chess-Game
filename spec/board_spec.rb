# frozen_string_literal: true

require_relative '../lib/board'

# rubocop: disable Metrics/BlockLength
describe Board do
  describe '#pretty_print_board' do
    # skipping tests for this since it's only being used temporarily as a way of seeing
    # the board state
  end

  describe '#build_starting_board' do
    # Script method - No tests needed since it only calls other instance methods
  end

  describe '#place_white_starting_pieces' do
    subject(:board) { described_class.new }

    before do
      allow(board).to receive(:place_piece)
      allow(board).to receive(:build_starting_board)
    end

    xit 'places 8 pieces' do
      expect(board).to receive(:place_piece).exactly(8).times
      board.place_white_starting_pieces
    end
  end

  describe '#place_piece' do
    subject(:board) { described_class.new }
    let(:cell) { instance_double('cell') }
    let(:piece) { instance_double('piece') }

    context 'when passed a White Pawn for position a2' do
      before do
        allow(board).to receive(:Cell.new).and_return(cell)
      end

      it 'creates a new cell at [0][1]' do
        expect(board.place_piece('a', 2, 'White', 'Pawn')).to change(board.board_state).to(cell)
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
