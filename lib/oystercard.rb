class Oystercard

attr_reader :balance

LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    fail "the balance cannot be over #{LIMIT} pounds" if @balance + money > LIMIT
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end


