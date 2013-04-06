require 'minitest/autorun'
require_relative '../lib/live_cell'

describe LiveCell do 
  it "dies with fewer than 2 live neighbors" do
    lc = LiveCell.new
    lc.forecast(neighbors: 0).must_equal(DeadCell)
    lc.forecast(neighbors: 1).must_equal(DeadCell)
    lc.forecast(neighbors: 2).must_equal(LiveCell)
  end
end
