class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = MIN_BALANCE

  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @journey = {}
    @journey_history = {}
    @journey_counter = 0
  end

  def top_up(money)
    fail "the balance cannot be over #{MAX_BALANCE} pounds" if
      excessive_balance?(money)
    @balance += money
  end

  def in_journey?
    @journey[:entry_station] != nil
  end

  def touch_in(entry_station)
    fail "cannot touch in if balance is less #{MIN_BALANCE} pound" if
      insufficent_balance?
    @journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    @journey_counter += 1
    @journey[:exit_station] = exit_station
    @journey_history['J' + "#{@journey_counter}"] = @journey
    @journey = {}
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
