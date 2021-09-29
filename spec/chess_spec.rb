# frozen_string_literal: true

require_relative '../lib/chess'

# rubocop: disable Metrics/BlockLength
describe Chess do
  describe '#convert_notation_to_column_index' do
    subject(:convert_to_column_chess) { described_class.new }

    context 'when sent cell e5' do
      it 'returns column index 4' do
        expect(convert_to_column_chess.convert_notation_to_column_index('e5')).to eq(4)
      end
    end

    context 'when sent cell b8' do
      it 'returns column index 1' do
        expect(convert_to_column_chess.convert_notation_to_column_index('b8')).to eq(1)
      end
    end
  end

  describe '#convert_notation_to_row_index' do
    subject(:convert_to_row_chess) { described_class.new }

    context 'when sent cell a7' do
      it 'returns row index 6' do
        expect(convert_to_row_chess.convert_notation_to_row_index('a7')).to eq(6)
      end
    end

    context 'when sent cell h3' do
      it 'returns column index 2' do
        expect(convert_to_row_chess.convert_notation_to_row_index('h3')).to eq(2)
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
