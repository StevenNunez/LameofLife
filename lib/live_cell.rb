require_relative 'dead_cell'
class LiveCell
  def self.forecast(live_neighbors:0)
    if live_neighbors == 2
      LiveCell
    else
      DeadCell
    end
  end
end
