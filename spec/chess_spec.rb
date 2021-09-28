# frozen_string_literal: true

require_relative '../lib/chess'

describe Chess do
  describe '#pull_piece' do
    subject(:chess) { described_class.new }
    let(:player1) { instance_double('player') }
    let(:player2) { instance_double('player') }
    let(:pieces) { chess.instance_variable_get(:@pieces) }

    context 'when passed a white rook' do
      before do
        allow(chess).to receive(build_starting_board)
      end

      it 'finds the first white rook in the collection' do
        white_rook = pieces[0]
        expect(pieces).to receive(:find).and_return(white_rook)
        chess.pull_piece('White', 'Rook')
      end

      it 'deletes the first white rook from the collection' do
        white_rook = pieces[0]
        expect(pieces).not_to include?(white_rook)
        chess.pull_piece('White', 'Rook')
      end

      it 'returns the first white rook from the collection'
    end
  end
end
