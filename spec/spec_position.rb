require_relative '../lib/position'

describe Position do
  subject(:default_pos) { described_class.new(2, 2) }

  describe '#initialize' do

    context 'When giving it row and column values of 0, 1' do
      subject(:position) { described_class.new(0, 1) }

      it 'Has row 0' do
        expect(position.row).to eq(0)
      end

      it 'Has column 1' do
        expect(position.col).to eq(1)
      end

      it 'Has array [0, 1]' do
        expect(position.array).to eq([0, 1])
      end
    end
  end

  describe '#up' do
    it 'Returns a position of 3, 2' do
      expect(default_pos.up.array).to eq(described_class.new(3, 2).array)
    end
  end

  describe '#down' do
    it 'Returns a position of 1, 2' do
      expect(default_pos.down.array).to eq(described_class.new(1, 2).array)
    end
  end

  describe '#right' do
    it 'Returns a position of 2, 3' do
      expect(default_pos.right.array).to eq(described_class.new(2, 3).array)
    end
  end

  describe '#left' do
    it 'Returns a position of 2, 1' do
      expect(default_pos.left.array).to eq(described_class.new(2, 1).array)
    end
  end


  describe '#up_left' do
    it 'Returns a position of 3, 1' do
      expect(default_pos.up_left.array).to eq(described_class.new(3, 1).array)
    end
  end

  describe '#up_right' do
    it 'Returns a position of 3, 3' do
      expect(default_pos.up_right.array).to eq(described_class.new(3, 3).array)
    end
  end

  describe '#down_left' do
    it 'Returns a position of 1, 1' do
      expect(default_pos.down_left.array).to eq(described_class.new(1, 1).array)
    end
  end

  describe '#down_right' do
    it 'Returns a position of 1, 3' do
      expect(default_pos.down_right.array).to eq(described_class.new(1, 3).array)
    end
  end
end