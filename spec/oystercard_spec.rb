require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  MIN_BALANCE = Oystercard::MIN_BALANCE

  it 'sets the initial balance to 0' do
    expect(oystercard.balance).to eq 0
  end

  context 'card WITHOUT money' do

    it 'cannot touch in if the balance is less than the minimum balance' do
      less_than_1 = "cannot touch in if balance is less #{MIN_BALANCE} pound"
      expect { oystercard.touch_in(entry_station) }.to raise_error less_than_1
    end

    describe '#top_up' do

      it 'can top up the balance' do
        expect { oystercard.top_up(20) }.to change { oystercard.balance }.by(20)
      end

      it "raises an error if the maximum balance is exceeded" do
        over_90 = "the balance cannot be over #{MAX_BALANCE} pounds"
        oystercard.top_up(MAX_BALANCE)
        expect { oystercard.top_up(1) }.to raise_error over_90
      end
    end
  end

  context 'card WITH money' do

    before { oystercard.top_up(10) }

    describe '#in_journey?' do
      it 'a card should start with a value of false' do
        expect(oystercard.in_journey?).to eq false
      end

      it 'returns true when in journey' do
        oystercard.touch_in(entry_station)
        expect(oystercard.in_journey?).to eq true
      end
    end

    describe '#touch_out(exit_station)' do

      it 'deducts 1 from the balance of the card' do
        MIN_FARE = Oystercard::MIN_FARE
        oystercard.touch_in(entry_station)
        expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by(-MIN_FARE)
      end
    end

    describe '#journey_history' do

      it 'has an empty list of journeys by default' do
        expect(oystercard.journey_history).to eq({})
      end

      it 'has an history of the journeys' do
        oystercard.touch_in('brixton')
        oystercard.touch_out('victoria')
        expect(oystercard.journey_history).to eq('J1' => { entry_station: 'brixton', exit_station: 'victoria' })
      end
    end
  end
end
