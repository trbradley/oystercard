class Oystercard

attr_reader :balance

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_FARE = MIN_BALANCE

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    fail "the balance cannot be over #{MAX_BALANCE} pounds" if @balance + money > MAX_BALANCE
    @balance += money
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "cannot touch in if the balance is less #{MIN_BALANCE} pound" if @balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MIN_FARE)
  end

private

  def deduct(money)
    @balance -= money
  end

end
