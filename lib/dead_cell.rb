require_relative 'live_cell'
class DeadCell
  def self.forecast(live_neighbors:0)
    if live_neighbors == 3
      LiveCell
    else
      self
    end
  end

  def self.status
    :dead
  end
end
