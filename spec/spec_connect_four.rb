require_relative '../lib/connect_four'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/position'

describe ConnectFour do
  subject(:game) { described_class.new }

  describe '#verify_column' do
    context 'Column is string with valid number' do
      it 'returns true' do
        expect(game.send(:verify_column, '3')).to eq(true)
      end

      it 'does not raise exception' do
        expect { game.send(:verify_column, '3') }.to_not raise_exception
      end
    end

    context 'Column is string and not a number' do
      before(:each) do
        allow($stdout).to receive(:write)
      end

      it 'returns false' do
        expect(game.send(:verify_column, 'f')).to eq(false)
      end

      it 'does not raise exception' do
        expect { game.send(:verify_column, 'f') }.to_not raise_exception
      end
    end

    context 'Column is string with invalid number' do
      before(:each) do
        allow($stdout).to receive(:write)
      end

      it 'returns false' do
        expect(game.send(:verify_column, '100')).to eq(false)
      end

      it 'does not raise exception' do
        expect { game.send(:verify_column, '100') }.to_not raise_exception
      end
    end
  end

  describe '#request_column' do
    context 'user entered valid column' do
      before do
        allow($stdout).to receive(:write)
        allow(game).to receive(:gets).and_return('1')
      end

      it 'returns 1' do
        expect(game.send(:request_column)).to eq(1)
      end
    end

    context 'user entered invalid column twice, then valid' do
      before(:each) do
        allow($stdout).to receive(:write)
        allow(game).to receive(:verify_column).and_return(false, false, true, false)
        allow(game).to receive(:gets).and_return('f', '100', '1', '2')
      end

      it 'verifies column three times' do
        expect(game).to receive(:verify_column).exactly(3).times
        game.send(:request_column)
      end

      it 'returns 1' do
        expect(game.send(:request_column)).to eq(1)
      end
    end
  end

  describe '#place_token' do
    let(:board) { instance_double(Board) }

    context 'token is placed in valid column' do
      before(:each) do
        allow(game).to receive(:request_column).and_return(1)
        allow(board).to receive(:drop_at_col).and_return(Position.new(0, 1))
      end

      it 'sends #drop_at_col to board' do
        expect(board).to receive(:drop_at_col)
        game.instance_variable_set(:@board, board)
        game.send(:place_token)
      end

      it 'sets @last_position to [0, 1]' do
        game.instance_variable_set(:@last_position, Position.new(0, 0))
        lpos = game.instance_variable_get(:@last_position).array
        expect {
          game.send(:place_token)
          lpos = game.instance_variable_get(:@last_position).array
        }.to change { lpos }.to([0, 1])
      end
    end

    context 'token is placed in invalid column twice, then valid' do
      before(:each) do
        allow(game).to receive(:request_column).and_return(1, 1, 2, 3)
        allow(board).to receive(:drop_at_col).and_return(false, false, Position.new(0, 2), false)
      end

      it 'requests column three times' do
        new_game = game
        new_game.instance_variable_set(:@board, board)
        expect(new_game).to receive(:request_column).exactly(3).times
        new_game.send(:place_token)
      end

      it 'sets @last_position to [0, 2]' do
        new_game = game
        new_game.instance_variable_set(:@board, board)
        new_game.instance_variable_set(:@last_position, Position.new(0, 0))
        lpos = new_game.instance_variable_get(:@last_position).array
        expect {
          new_game.send(:place_token)
          lpos = new_game.instance_variable_get(:@last_position).array
        }.to change { lpos }.to([0, 2])
      end
    end
  end
end
