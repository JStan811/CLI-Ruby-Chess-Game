# frozen_string_literal: true

require_relative '../lib/validator'

# rubocop: disable Metrics/BlockLength
describe Validator do
  subject(:notation_validator) { described_class.new }

  describe '#valid_notation?' do
    context 'when sent an action with valid notation ([a-h][1-8][a-h][1-8])' do
      it 'is valid notation' do
        expect(notation_validator.valid_notation?('a3b7')).to be true
      end
    end

    context 'when sent a different action with valid notation' do
      it 'is valid notation' do
        expect(notation_validator.valid_notation?('h1c3')).to be true
      end
    end

    context 'when sent a random string of letters' do
      it 'is invalid notation' do
        expect(notation_validator.valid_notation?('hello!')).to be false
      end
    end

    context 'when sent a non-string object (number)' do
      it 'is invalid notation' do
        expect(notation_validator.valid_notation?(1234)).to be false
      end
    end

    context 'when sent an action with a column outside of the expected range' do
      it 'is invalid notation' do
        expect(notation_validator.valid_notation?('z1c3')).to be false
      end
    end

    context 'when sent an action with a row outside of the expected range' do
      it 'is invalid notation' do
        expect(notation_validator.valid_notation?('h1c9')).to be false
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
