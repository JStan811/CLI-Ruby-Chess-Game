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

  describe '#starting_cell_contains_a_piece?' do
    subject(:contains_piece_validator) { described_class.new }
    let(:starting_cell) { instance_double('cell') }
    let(:piece_in_cell) { instance_double('piece') }

    context 'when cell does contain a piece' do
      it 'is true' do
        player_action = 'e5e6'
        allow(contains_piece_validator).to receive(:convert_player_action_into_starting_cell).and_return(starting_cell)
        allow(starting_cell).to receive(:piece).and_return(piece_in_cell)
        expect(contains_piece_validator.starting_cell_contains_a_piece?(player_action)).to be true
      end
    end

    context 'when cell does not contain a piece' do
      it 'is false' do
        player_action = 'e5e6'
        allow(contains_piece_validator).to receive(:convert_player_action_into_starting_cell).and_return(starting_cell)
        allow(starting_cell).to receive(:piece).and_return(nil)
        expect(contains_piece_validator.starting_cell_contains_a_piece?(player_action)).to be false
      end
    end
  end

  describe '#starting_cell_contains_own_piece?' do
    subject(:contains_own_piece_validator) { described_class.new }
    let(:starting_cell) { instance_double('cell') }
    let(:piece_in_cell) { instance_double('piece') }
    let(:player_taking_action) { instance_double('player') }
    let(:different_player) { instance_double('player') }

    context "when cell does contain player's own piece" do
      it 'is true' do
        player_action = 'e5e6'
        allow(contains_own_piece_validator).to receive(:convert_player_action_into_starting_cell).and_return(starting_cell)
        allow(starting_cell).to receive(:piece).and_return(piece_in_cell)
        allow(piece_in_cell).to receive(:owner).and_return(player_taking_action)
        expect(contains_own_piece_validator.starting_cell_contains_own_piece?(player_action, player_taking_action)).to be true
      end
    end

    context "when cell does not contain player's own piece" do
      it 'is false' do
        player_action = 'e5e6'
        allow(contains_own_piece_validator).to receive(:convert_player_action_into_starting_cell).and_return(starting_cell)
        allow(starting_cell).to receive(:piece).and_return(piece_in_cell)
        allow(piece_in_cell).to receive(:owner).and_return(different_player)
        expect(contains_own_piece_validator.starting_cell_contains_own_piece?(player_action, player_taking_action)).to be false
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
