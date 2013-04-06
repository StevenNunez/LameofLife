require 'minitest/autorun'
require 'minitest/mock'
require_relative '../lib/position'

describe Position do 
  before do
    @dead_cell = MiniTest::Mock.new
    @dead_cell.expect(:status, :dead)
    @dead_cell.expect(:forecast, "Still dead", [live_neighbors:0])
  end

  it "knows if its tenant's is alive or dead" do
    position = Position.new(1, @dead_cell)
    position.tenant_status.must_equal(:dead)
  end

  it "sets it sets its future state" do
    position = Position.new(1, @dead_cell)
    position.calculate_next_state(live_neighbors: 0)
    position.next_cell.must_equal "Still dead"
  end

  it "knows its position number" do
    position = Position.new(1, @dead_cell)
    position.number.must_equal(1)
  end
end
