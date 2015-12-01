require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it 'sets the initial balance to 0' do
    expect(oystercard.balance).to eq 0
  end

  context '#top_up' do

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

  context '#deduct' do
    it 'can deduct money from the balance' do
      oystercard.top_up(10)
      expect { oystercard.deduct(7) }.to change { oystercard.balance }.by(-7)
    end
  end

  context '#in_journey?' do
    it 'a card should start with a value of false' do
      expect(oystercard).not_to be_in_journey
    end
  end

  context 'topped up card' do

    before do
      oystercard.top_up(10)
    end

    describe '#touch_in' do
      it 'changes @in_journey from false to true' do
        oystercard.touch_in
        expect(oystercard).to be_in_journey
      end
    end

    describe '#touch_out' do
      it 'changes @in_journey from true to false' do
        oystercard.touch_in
        oystercard.touch_out
        expect(oystercard).not_to be_in_journey
      end
    end
  end

  it 'cannot touch in if the balance is less than 1 pound' do
    MIN_BALANCE = Oystercard::MIN_BALANCE
    less_than_1 = "cannot touch in if the balance is less #{MIN_BALANCE} pound"
    expect { oystercard.touch_in }.to raise_error less_than_1
  end
end
