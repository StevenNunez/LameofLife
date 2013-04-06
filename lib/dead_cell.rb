require_relative 'live_cell'
class DeadCell
  def self.forecast(live_neighbors:0)
    if live_neighbors == 3
      LiveCell
    else
      DeadCell
    end
  end
end
