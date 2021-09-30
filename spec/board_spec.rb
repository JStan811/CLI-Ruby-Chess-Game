# frozen_string_literal: true

require_relative '../lib/board'

# rubocop: disable Metrics/BlockLength
describe Board do
  describe '#create_empty_cell_list' do
    subject(:board_empty_cells) { described_class.new }
    let(:piece1) { instance_double('piece') }
    let(:piece2) { instance_double('piece') }
    let(:piece3) { instance_double('piece') }

    context 'when board has 3 non-empty cells' do
      it 'returns a list of cells with length 61' do
        cells = board_empty_cells.instance_variable_get(:@cells)
        cells[0][1].place_piece(piece1)
        cells[0][2].place_piece(piece1)
        cells[0][3].place_piece(piece1)
        expect(board_empty_cells.create_empty_cell_list.count).to eq 61
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
