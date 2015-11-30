require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it 'sets the initial balance to 0' do
    expect(oystercard.balance).to eq 0
  end

  describe '#top_up' do

    it 'can top up the balance' do
      expect { oystercard.top_up(20) }.to change { oystercard.balance }.by(20)
    end

    it "raises an error if the maximum balance is exceeded" do
      LIMIT = Oystercard::LIMIT
      over_90 = "the balance cannot be over #{LIMIT} pounds"
      oystercard.top_up(LIMIT)
      expect { oystercard.top_up(1) }.to raise_error over_90
    end
  end
end
