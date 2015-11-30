require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'tells you the balance of oystercard' do
    expect(oystercard.balance).to eq 0
  end

  it 'can top up an oystercard' do
    oystercard.balance = 10
    oystercard.top_up(20)
    expect(oystercard.balance).to eq 30
  end

end
