require 'minitest/autorun'
require 'minitest/mock'
require_relative '../lib/grid'

describe Grid do
  before do
    positions = [0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0]
    @grid = Grid.new(*positions)
  end

  it "only accepts 20 arguments" do
    positions = [0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0]
    grid = Grid.new(*positions)
    grid.raw_positions.must_equal positions
  end

  it "stops execution if wrong number of arguments given" do
    lambda do
      Grid.new("Foo" "bar")
    end.must_raise SystemExit
  end

  it "stops execution unless all arguments are numbers" do
    positions = ['0', 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0]
    lambda do
      Grid.new(*positions)
    end.must_raise SystemExit
  end

  it "assigns the right position a live or dead status" do
    @grid.status_for_position(1).must_equal :dead
    @grid.status_for_position(19).must_equal :live
    @grid.status_for_position(20).must_equal :dead
  end

  it "returns neighbors for a position" do
    # from the chart
    @grid.neighbors_for_position(1).must_equal([7,16,17])
    @grid.neighbors_for_position(2).must_equal([9,17,18])
    @grid.neighbors_for_position(3).must_equal([11,18,19])
    @grid.neighbors_for_position(4).must_equal([13,19,20])
    @grid.neighbors_for_position(5).must_equal([15,16,20])

    @grid.neighbors_for_position(6).must_equal([7,15,16])
    @grid.neighbors_for_position(7).must_equal([1,6,8])
    @grid.neighbors_for_position(8).must_equal([7,9,17])
    @grid.neighbors_for_position(9).must_equal([2,8,10])
    @grid.neighbors_for_position(10).must_equal([9,11,18])
    @grid.neighbors_for_position(11).must_equal([3,10,12])
    @grid.neighbors_for_position(12).must_equal([11,13,19])
    @grid.neighbors_for_position(13).must_equal([4,12,14])
    @grid.neighbors_for_position(14).must_equal([13,15,20])
    @grid.neighbors_for_position(15).must_equal([5,6,14])

    @grid.neighbors_for_position(16).must_equal([1,5,6])
    @grid.neighbors_for_position(17).must_equal([1,2,8])
    @grid.neighbors_for_position(18).must_equal([2,3,10])
    @grid.neighbors_for_position(19).must_equal([3,4,12])
    @grid.neighbors_for_position(20).must_equal([4,5,14])
  end

  it "counts number of live neighbors for position" do
    @grid.position_alive?(9).must_equal true
    @grid.position_alive?(17).must_equal true
    @grid.position_alive?(18).must_equal true

    @grid.live_neighbors_for_position(2).must_equal 3

    @grid.position_alive?(7).must_equal true
    @grid.position_alive?(16).must_equal false
    @grid.position_alive?(17).must_equal true

    @grid.live_neighbors_for_position(1).must_equal 2
  end

  # integration tests... ish
  it "triggers next state calculation" do 
    @grid.position_alive?(2).must_equal true
    @grid.position_alive?(9).must_equal true
    @grid.position_alive?(17).must_equal true
    @grid.position_alive?(18).must_equal true

    @grid.position_alive?(1).must_equal false
    @grid.position_alive?(7).must_equal true
    @grid.position_alive?(16).must_equal false
    @grid.position_alive?(17).must_equal true

    @grid.next_generation!

    @grid.position_alive?(2).must_equal false
  end
end
