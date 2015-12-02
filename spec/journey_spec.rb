require 'journey'

describe Journey do
  subject(:journey) { described_class.new }

  describe '#in_journey?' do
    it 'a journey should start with a value of false' do
      expect(journey.in_journey?).to eq false
    end

    it 'returns true when in journey' do
      journey.start_journey('Brixton')
      expect(journey.in_journey?).to eq true
    end
  end

  describe '#start_journey' do
    it 'starts the current journey with the name of the entry station' do
      journey.start_journey('Brixton')
      expect(journey.current_journey).to eq(entry_station: 'Brixton')
    end
  end

  describe '#end_journey' do
    it 'ends the current journey with the name of the exit station' do
      journey.end_journey('Victoria')
      expect(journey.current_journey).to eq(exit_station: 'Victoria')
    end
  end
end
