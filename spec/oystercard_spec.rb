require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  MIN_BALANCE = Oystercard::MIN_BALANCE

  it 'has an initial balance of 0' do
    expect(oystercard.balance).to eq 0
  end

  context 'card WITHOUT money' do
    it 'cannot touch in if the balance is less than the minimum balance' do
      insufficent_balance = "Insufficient balance. Need at least #{MIN_BALANCE}"
      expect { oystercard.touch_in(entry_station) }.to raise_error insufficent_balance
    end

    describe '#top_up' do
      it 'can top up the balance' do
        expect { oystercard.top_up(20) }.to change { oystercard.balance }.by(20)
      end

      it 'raises an error if the maximum balance is exceeded' do
        max_balance_exceeded = "Maximum balance of #{MAX_BALANCE} exceeded"
        oystercard.top_up(MAX_BALANCE)
        expect { oystercard.top_up(1) }.to raise_error max_balance_exceeded
      end
    end
  end

  context 'card WITH money' do
    before { oystercard.top_up(10) }

    describe '#touch_out(exit_station)' do
      it 'deducts fare from the balance of the card' do
        MIN_FARE = Oystercard::MIN_FARE
        oystercard.touch_in(entry_station)
        expect { oystercard.touch_out(exit_station) }
          .to change { oystercard.balance }.by(-MIN_FARE)
      end
    end

    describe '#journey_history' do
      it 'has an empty list of journeys by default' do
        expect(oystercard.journey_history).to eq({})
      end

      it 'has a history of the journeys' do
        oystercard.touch_in('brixton')
        oystercard.touch_out('victoria')
        expect(oystercard.journey_history)
          .to eq('Journey 1' => { entry_station: 'brixton', exit_station: 'victoria' })
      end
    end
  end
end
