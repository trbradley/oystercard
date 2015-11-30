require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it 'sets the initial balance to 0' do
    expect(oystercard.balance).to eq 0
  end

  describe '#top_up' do

    it 'can top up the balance' do
      old_balance = oystercard.balance
      oystercard.top_up(20)
      expect(oystercard.balance).to eq (old_balance + 20)
    end
  end
end
