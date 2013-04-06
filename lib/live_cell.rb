class LiveCell
  def forecast(neighbors:0)
    if neighbors >= 2
      LiveCell
    else
      DeadCell
    end
  end
end

# Created but has not functionality. Just put here since I need it
class DeadCell
end
