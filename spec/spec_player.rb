require_relative '../lib/player'

describe Player do
  describe '#initialize' do

    context 'Default case' do
      subject(:default_player) { described_class.new }
      let(:count) { described_class.class_variable_get(:@@count) }

      before(:each) { described_class.class_variable_set :@@count, 0 }
      
      it 'Increments player count' do
        default_player
        expect(count).to eq(1)
      end

      it 'Names the player according to their number' do
        expect(default_player.name).to eq('Player 1')
      end

      it "Gives the player's number as their token" do
        expect(default_player.token).to eq('1')
      end
    end

    context 'Custom player' do
      subject(:custom_player) { described_class.new(name: 'Wayne', token: '*') }

      it 'Gives the player a custom name' do
        expect(custom_player.name).to eq('Wayne')
      end

      it 'Gives the player a custom token' do
        expect(custom_player.token).to eq('*')
      end
    end
  end
end