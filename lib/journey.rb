class Journey
  attr_accessor :current_journey

  def initialize
    @current_journey = {}
  end

  def start_journey(entry_station)
    current_journey[:entry_station] = entry_station
  end

  def end_journey(exit_station)
    current_journey[:exit_station] = exit_station
  end

  def in_journey?
  end
end
