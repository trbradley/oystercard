require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'tells you the balance of oystercard' do
    expect(oystercard.balance).to eq 0
  end

end
