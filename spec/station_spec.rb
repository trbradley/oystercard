require 'station'

describe Station do
  subject(:station) { described_class.new('Brixton', '2') }

  it 'accepts and exposes a name argument' do
    expect(station.name).to eq('Brixton')
  end
  it 'accepts and exposes a zone argument' do
    expect(station.zone).to eq('2')
  end
end
