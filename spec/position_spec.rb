require 'minitest/autorun'
require 'minitest/mock'
require_relative '../lib/position'

describe Position do 
  Cell = Struct.new(:status)
  before do
    @live_cell = Cell.new
    @live_cell.status = :live

    @dead_cell = MiniTest::Mock.new
    @dead_cell.expect(:status, :dead)
    @dead_cell.expect(:forecast, @live_cell, [live_neighbors:0])
  end

  it "knows if its tenant's is alive or dead" do
    position = Position.new(1, @dead_cell)
    position.tenant_status.must_equal(:dead)
  end

  it "sets it sets its future state" do
    position = Position.new(1, @dead_cell)
    position.calculate_next_state(live_neighbors: 0)
    position.next_tenant_status.must_equal :live
  end

  it "knows its position number" do
    position = Position.new(1, @dead_cell)
    position.number.must_equal(1)
  end
  it "sets present state from calculated state" do
    position = Position.new(1, @dead_cell)
    position.calculate_next_state(live_neighbors: 0)
    position.next_tenant_status.must_equal :live
    position.switch!
    position.tenant_status.must_equal(:live)
  end
end
