require 'minitest/autorun'
require_relative '../lib/live_cell'

describe LiveCell do 
  it "dies with fewer than 2 live neighbors" do
    LiveCell.forecast(live_neighbors: 0).must_equal(DeadCell)
    LiveCell.forecast(live_neighbors: 1).must_equal(DeadCell)
  end
  it "lives with two live neighbours" do
    LiveCell.forecast(live_neighbors: 2).must_equal(LiveCell)
  end
end
