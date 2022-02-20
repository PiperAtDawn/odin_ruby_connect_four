require_relative '../lib/board'
require_relative '../lib/position'

describe Board do
  describe '#initialize' do

    context 'When using default values' do
      subject(:default_board) { described_class.new }

      it 'Has a maximum row index of 5' do
        expect(default_board.max_row).to eq(5)
      end

      it 'Has a maximum column index of 6' do
        expect(default_board.max_col).to eq(6)
      end

      it 'Uses "-" as an empty symbol' do
        expect(default_board.empty_symbol).to eq('-')
      end

      it 'Has a 6 by 7 array full of "-"' do
        array = Array.new(6) { Array.new(7, '-') }
        board = default_board.instance_variable_get(:@board)
        expect(board).to eq(array)
      end
    end

    context 'When using custom values' do
      subject(:custom_board) { described_class.new(width: 3, height: 4, empty_symbol: '+') }

      it 'Has a maximum row index of 3' do
        expect(custom_board.max_row).to eq(3)
      end

      it 'Has a maximum column index of 2' do
        expect(custom_board.max_col).to eq(2)
      end

      it 'Uses "+" as an empty symbol' do
        expect(custom_board.empty_symbol).to eq('+')
      end

      it 'Has a 4 by 3 array full of "+"' do
        array = Array.new(4) { Array.new(3, '+') }
        board = custom_board.instance_variable_get(:@board)
        expect(board).to eq(array)
      end
    end
  end

  describe '#[]' do
    subject(:plus_board) { described_class.new(width: 7, height: 6, empty_symbol: '+') }
    it 'Returns the value at given position' do
      pos = Position.new(2, 2)
      expect(plus_board[pos]).to eq('+')
    end
  end

  describe '#valid_position?' do
    subject(:board) { described_class.new }

    context 'When given a valid position' do
      let(:valid_pos) { Position.new(0, 0) }

      it 'Returns true' do
        valid = board.valid_position?(valid_pos)
        expect(valid).to eq(true)
      end
    end

    context 'When given an invalid position' do
      let(:valid_pos) { Position.new(-1, 0) }

      it 'Returns false' do
        valid = board.valid_position?(valid_pos)
        expect(valid).to eq(false)
      end
    end
  end

  describe '#drop_at_col' do
    subject(:board) { described_class.new }

    context 'When dropping "1" in column 0 when it is free' do

      it 'Makes value at [0, 0] equal to "1"' do
        new_board = board
        new_board.drop_at_col(0, '1')
        pos = Position.new(0, 0)
        expect(new_board[pos]).to eq('1')
      end

      it 'Returns position with array [0, 0]' do
        expect(board.drop_at_col(0, '1').array).to eq([0, 0])
      end
    end

    context 'When dropping "1" in column 0 when it is fully occupied' do

      it 'Returns false' do
        new_board = board
        6.times { new_board.drop_at_col(0, '1') }
        expect(new_board.drop_at_col(0, '1')).to eq(false)
      end
    end
  end
end