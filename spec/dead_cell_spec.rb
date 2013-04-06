require 'minitest/autorun'
require_relative '../lib/dead_cell'

describe DeadCell do
  it "stays dead unless there are 3 neighbors" do 
    DeadCell.forecast(live_neighbors: 0).must_equal(DeadCell)
    DeadCell.forecast(live_neighbors: 1).must_equal(DeadCell)
    DeadCell.forecast(live_neighbors: 2).must_equal(DeadCell)
    DeadCell.forecast(live_neighbors: 3).must_equal(LiveCell)
  end
end
