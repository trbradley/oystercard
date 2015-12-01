class Oystercard

attr_reader :balance, :station

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_FARE = MIN_BALANCE

  def initialize
    @balance = 0
    @station = nil
  end

  def top_up(money)
    fail "the balance cannot be over #{MAX_BALANCE} pounds" if excessive_balance?(money)
    @balance += money
  end

  def in_journey?
    @station != nil ? true : false
  end

  def touch_in(station)
    fail "cannot touch in if the balance is less #{MIN_BALANCE} pound" if insufficent_balance?
    @station = station
  end

  def touch_out
    @station = nil
    deduct(MIN_FARE)
  end

private

  def excessive_balance?(money)
    @balance + money > MAX_BALANCE
  end

  def insufficent_balance?
    @balance < MIN_BALANCE
  end


  def deduct(money)
    @balance -= money
  end

end
