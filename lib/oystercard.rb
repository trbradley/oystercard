require_relative 'journey'
require_relative 'station'

class Oystercard
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = MIN_BALANCE

  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @journey_history = {}
    @journey_counter = 0
    @this_journey = Journey.new
  end

  def top_up(money)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if
      excessive_balance?(money)
    @balance += money
  end

  def touch_in(entry_station)
    fail "Insufficient balance. Need at least #{MIN_BALANCE}" if
      insufficent_balance?
    @this_journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
    increment_journey_counter
    @this_journey.end_journey(exit_station)
    write_to_history
    deduct(MIN_FARE)
  end

  def card_in_use?
    @this_journey.in_journey?
  end

  private

  def write_to_history
    @journey_history['Journey ' + "#{@journey_counter}"] = @this_journey.current_journey
    @this_journey.reset
  end

  def increment_journey_counter
    @journey_counter += 1
  end

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
