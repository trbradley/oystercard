require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:station) { double :station }

  it 'sets the initial balance to 0' do
    expect(oystercard.balance).to eq 0
  end

  context 'card WITHOUT money' do

    it 'cannot touch in if the balance is less than the minimum balance' do
      MIN_BALANCE = Oystercard::MIN_BALANCE
      less_than_1 = "cannot touch in if balance is less #{MIN_BALANCE} pound"
      expect { oystercard.touch_in(station) }.to raise_error less_than_1
    end

    describe '#top_up' do

      it 'can top up the balance' do
        expect { oystercard.top_up(20) }.to change { oystercard.balance }.by(20)
      end

      it "raises an error if the maximum balance is exceeded" do
        MAX_BALANCE = Oystercard::MAX_BALANCE
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
        oystercard.touch_in(station)
        expect(oystercard.in_journey?).to eq true
      end
    end

    describe '#touch_in(station)' do

      it 'changes the station from nil to station name' do
        oystercard.touch_in('brixton')
        expect(oystercard.station).to eq 'brixton'
      end
    end

    describe '#touch_out' do

      it 'changes the station to nil' do
        oystercard.touch_in('brixton')
        oystercard.touch_out
        expect(oystercard.station).to eq nil
      end

      it 'deducts 1 from the balance of the card' do
        MIN_FARE = Oystercard::MIN_FARE
        oystercard.touch_in(station)
        expect { oystercard.touch_out }.to change { oystercard.balance }.by(-MIN_FARE)
      end
    end
  end
end
