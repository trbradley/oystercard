require 'station'

describe Station do
  subject(:station) { described_class.new('Brixton', '2') }

  describe 'initialize' do
    it 'accepts a name argument' do
      expect(station.name).to eq('Brixton')
    end
    it 'accepts a zone argument' do
      expect(station.zone).to eq('2')
    end
  end
end
