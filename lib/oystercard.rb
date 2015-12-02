class Oystercard

attr_reader :balance, :entry_station, :exit_station, :journey_history, :journey

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_FARE = MIN_BALANCE

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey = {}
    @journey_history = []
  end

  def top_up(money)
    fail "the balance cannot be over #{MAX_BALANCE} pounds" if excessive_balance?(money)
    @balance += money
  end

  def in_journey?
    @entry_station != nil ? true : false
  end

  def touch_in(entry_station)
    fail "cannot touch in if balance is less #{MIN_BALANCE} pound" if insufficent_balance?
    @entry_station = entry_station
    @journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    @entry_station = nil
    @exit_station = exit_station
    @journey[:exit_station] = exit_station
    @journey_history << @journey
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
