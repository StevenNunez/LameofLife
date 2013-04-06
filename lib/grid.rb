require_relative 'position'
require_relative 'live_cell'
require_relative 'dead_cell'

class Grid
  def initialize(*grid_positions)
    abort unless grid_positions.length == 20 && grid_positions.all?{|n| n.is_a? Integer}
    @positions = grid_positions.each_with_index.map do |status, index|
      cell = status.zero? ? DeadCell : LiveCell
      position = index + 1
      Position.new(position, cell)
    end
  end

  def raw_positions
    positions.map do |pos|
      position_alive?(pos.number) ? 1 : 0
    end
  end

  def positions
    @positions
  end

  def status_for_position(position_number)
    positions[position_number -1].tenant_status
  end

  def neighbors_for_position(position_number)
    {
      1 => [7,16,17],
      2 => [9,17,18],
      3 => [11,18,19],
      4 => [13,19,20], 
      5 => [15,16,20],
      6 => [7,15,16],
      7 => [1,6,8],
      8 => [7,9,17],
      9 => [2,8,10],
      10 => [9,11,18],
      11 => [3,10,12],
      12 => [11,13,19],
      13 => [4,12,14],
      14 => [13,15,20],
      15 => [5,6,14],

      16 => [1,5,6],
      17 => [1,2,8],
      18 => [2,3,10],
      19 => [3,4,12],
      20 => [4,5,14],
    }[position_number]
  end

  def live_neighbors_for_position(position_number)
    neighbors_for_position(position_number).inject(0) do |temp, position|
      if position_alive?(position) 
        temp + 1
      else 
        temp
      end
    end
  end

  def position_alive?(position)
    status_for_position(position) == :live
  end

  def next_generation!
    positions.each do |pos|
      pos.calculate_next_state(live_neighbors:live_neighbors_for_position(pos.number))
    end
    positions.each do |pos|
      pos.switch!
    end
  end
end
