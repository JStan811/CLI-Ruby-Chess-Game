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

  describe '#cell_contains_a_piece?' do
    subject(:contains_piece_validator) { described_class.new }
    let(:cell_to_check) { instance_double('cell') }
    let(:piece_in_cell) { instance_double('piece') }

    context 'when cell does contain a piece' do
      it 'is true' do
        allow(cell_to_check).to receive(:piece).and_return(piece_in_cell)
        expect(contains_piece_validator.cell_contains_a_piece?(cell_to_check)).to be true
      end
    end

    context 'when cell does not contain a piece' do
      it 'is false' do
        allow(cell_to_check).to receive(:piece).and_return(nil)
        expect(contains_piece_validator.cell_contains_a_piece?(cell_to_check)).to be false
      end
    end
  end

  describe '#cell_contains_own_piece?' do
    subject(:contains_own_piece_validator) { described_class.new }
    let(:cell_to_check) { instance_double('cell') }
    let(:piece_in_cell) { instance_double('piece') }
    let(:player_taking_action) { instance_double('player') }
    let(:different_player) { instance_double('player') }

    context "when cell does contain player's own piece" do
      it 'is true' do
        allow(cell_to_check).to receive(:piece).and_return(piece_in_cell)
        allow(piece_in_cell).to receive(:owner).and_return(player_taking_action)
        expect(contains_own_piece_validator.cell_contains_own_piece?(cell_to_check, player_taking_action)).to be true
      end
    end

    context "when cell does not contain player's own piece" do
      it 'is false' do
        allow(cell_to_check).to receive(:piece).and_return(piece_in_cell)
        allow(piece_in_cell).to receive(:owner).and_return(different_player)
        expect(contains_own_piece_validator.cell_contains_own_piece?(cell_to_check, player_taking_action)).to be false
      end
    end
  end

  describe '#legal_move?' do
    subject(:legal_move_validator) { described_class.new }
    let(:starting_cell) { instance_double('cell') }
    let(:ending_cell) { instance_double('cell') }
    let(:piece_in_starting_cell) { instance_double('piece') }

    context 'when Rook is moved from a1 to a5' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Rook')
        # color only matters for Pawn
        allow(piece_in_starting_cell).to receive(:color)
        allow(starting_cell).to receive(:position).and_return([0, 0])
        allow(ending_cell).to receive(:position).and_return([4, 0])
      end

      it 'is a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).to be true
      end
    end

    context 'when Rook is moved from a1 to b5' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Rook')
        # color only matters for Pawn
        allow(piece_in_starting_cell).to receive(:color)
        allow(starting_cell).to receive(:position).and_return([0, 0])
        allow(ending_cell).to receive(:position).and_return([4, 1])
      end

      it 'is is not a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).not_to be true
      end
    end

    context 'when Knight is moved from d5 to e7' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Knight')
        # color only matters for Pawn
        allow(piece_in_starting_cell).to receive(:color)
        allow(starting_cell).to receive(:position).and_return([4, 3])
        allow(ending_cell).to receive(:position).and_return([6, 4])
      end

      it 'is a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).to be true
      end
    end

    context 'when Knight is moved from d5 to e6' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Knight')
        # color only matters for Pawn
        allow(piece_in_starting_cell).to receive(:color)
        allow(starting_cell).to receive(:position).and_return([4, 3])
        allow(ending_cell).to receive(:position).and_return([5, 4])
      end

      it 'is is not a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).not_to be true
      end
    end

    context 'when Bishop is moved from d4 to f6' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Bishop')
        # color only matters for Pawn
        allow(piece_in_starting_cell).to receive(:color)
        allow(starting_cell).to receive(:position).and_return([3, 3])
        allow(ending_cell).to receive(:position).and_return([5, 5])
      end

      it 'is a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).to be true
      end
    end

    context 'when Bishop is moved from d4 to d7' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Bishop')
        # color only matters for Pawn
        allow(piece_in_starting_cell).to receive(:color)
        allow(starting_cell).to receive(:position).and_return([3, 3])
        allow(ending_cell).to receive(:position).and_return([6, 3])
      end

      it 'is is not a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).not_to be true
      end
    end

    context 'when Queen is moved from d4 to h4' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Queen')
        # color only matters for Pawn
        allow(piece_in_starting_cell).to receive(:color)
        allow(starting_cell).to receive(:position).and_return([3, 3])
        allow(ending_cell).to receive(:position).and_return([3, 7])
      end

      it 'is a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).to be true
      end
    end

    context 'when Queen is moved from d4 to b8' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Queen')
        # color only matters for Pawn
        allow(piece_in_starting_cell).to receive(:color)
        allow(starting_cell).to receive(:position).and_return([3, 3])
        allow(ending_cell).to receive(:position).and_return([7, 1])
      end

      it 'is is not a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).not_to be true
      end
    end

    context 'when King is moved from f5 to e6' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('King')
        # color only matters for Pawn
        allow(piece_in_starting_cell).to receive(:color)
        allow(starting_cell).to receive(:position).and_return([4, 5])
        allow(ending_cell).to receive(:position).and_return([5, 4])
      end

      it 'is a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).to be true
      end
    end

    context 'when King is moved from f5 to b8' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('King')
        # color only matters for Pawn
        allow(piece_in_starting_cell).to receive(:color)
        allow(starting_cell).to receive(:position).and_return([4, 5])
        allow(ending_cell).to receive(:position).and_return([7, 1])
      end

      it 'is is not a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).not_to be true
      end
    end

    context 'when White Pawn is moved from f2 to f4' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Pawn')
        allow(piece_in_starting_cell).to receive(:color).and_return('White')
        allow(starting_cell).to receive(:position).and_return([1, 5])
        allow(ending_cell).to receive(:position).and_return([3, 5])
      end

      it 'is a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).to be true
      end
    end

    context 'when White Pawn is moved from c4 to c5' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Pawn')
        allow(piece_in_starting_cell).to receive(:color).and_return('White')
        allow(starting_cell).to receive(:position).and_return([3, 2])
        allow(ending_cell).to receive(:position).and_return([4, 2])
      end

      it 'is a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).to be true
      end
    end

    context 'when White Pawn is moved from c4 to d5' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Pawn')
        allow(piece_in_starting_cell).to receive(:color).and_return('White')
        allow(starting_cell).to receive(:position).and_return([3, 2])
        allow(ending_cell).to receive(:position).and_return([4, 3])
      end

      it 'is a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).to be true
      end
    end

    context 'when White Pawn is moved from f3 to f5' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Pawn')
        allow(piece_in_starting_cell).to receive(:color).and_return('White')
        allow(starting_cell).to receive(:position).and_return([2, 5])
        allow(ending_cell).to receive(:position).and_return([4, 5])
      end

      it 'is is not a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).not_to be true
      end
    end

    context 'when White Pawn is moved from f3 to f2' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Pawn')
        allow(piece_in_starting_cell).to receive(:color).and_return('White')
        allow(starting_cell).to receive(:position).and_return([2, 5])
        allow(ending_cell).to receive(:position).and_return([1, 5])
      end

      it 'is is not a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).not_to be true
      end
    end

    context 'when Black Pawn is moved from f7 to f5' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Pawn')
        allow(piece_in_starting_cell).to receive(:color).and_return('Black')
        allow(starting_cell).to receive(:position).and_return([6, 5])
        allow(ending_cell).to receive(:position).and_return([4, 5])
      end

      it 'is a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).to be true
      end
    end

    context 'when Black Pawn is moved from c5 to c4' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Pawn')
        allow(piece_in_starting_cell).to receive(:color).and_return('Black')
        allow(starting_cell).to receive(:position).and_return([4, 2])
        allow(ending_cell).to receive(:position).and_return([3, 2])
      end

      it 'is a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).to be true
      end
    end

    context 'when Black Pawn is moved from c5 to d4' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Pawn')
        allow(piece_in_starting_cell).to receive(:color).and_return('Black')
        allow(starting_cell).to receive(:position).and_return([4, 2])
        allow(ending_cell).to receive(:position).and_return([3, 3])
      end

      it 'is a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).to be true
      end
    end

    context 'when Black Pawn is moved from f6 to f4' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Pawn')
        allow(piece_in_starting_cell).to receive(:color).and_return('Black')
        allow(starting_cell).to receive(:position).and_return([5, 5])
        allow(ending_cell).to receive(:position).and_return([3, 5])
      end

      it 'is is not a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).not_to be true
      end
    end

    context 'when Black Pawn is moved from f5 to f6' do
      before do
        allow(starting_cell).to receive(:piece).and_return(piece_in_starting_cell)
        allow(piece_in_starting_cell).to receive(:type).and_return('Pawn')
        allow(piece_in_starting_cell).to receive(:color).and_return('Black')
        allow(starting_cell).to receive(:position).and_return([3, 5])
        allow(ending_cell).to receive(:position).and_return([4, 5])
      end

      it 'is is not a legal move' do
        expect(legal_move_validator.legal_move?(starting_cell, ending_cell)).not_to be true
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
