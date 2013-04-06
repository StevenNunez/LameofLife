class Position
  def initialize(position_number, initial_cell)
    @position_number = position_number
    @current_cell = initial_cell
  end

  def tenant_status
    @current_cell.status
  end

  def calculate_next_state(live_neighbors:0)
    @next_cell = @current_cell.forecast(live_neighbors:live_neighbors)
  end

  def next_cell
    @next_cell 
  end

  def number
    @position_number
  end
end
