class LiveCell
  def self.forecast(live_neighbors:0)
    if live_neighbors >= 2
      LiveCell
    else
      DeadCell
    end
  end
end

# Created but has not functionality. Just put here since I need it
class DeadCell
end
