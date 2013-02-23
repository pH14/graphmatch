require 'test/unit'
require 'graphmatch'

class GraphmatchTest < Test::Unit::TestCase
  def test_really_simple
    left = ["a", "b"]
    right = [0, 1]
    edges = {"a" => {1 => 0},
             "b" => {0 => 0}}

    r = Graphmatch.match(left, right, edges)
    assert_equal({"a" => 1, "b" => 0}, r)
  end

  def test_simple
    left = ['a', 'b', 'c']
    right = [1, 2, 3]
    edges = {'a' => {2 => 0},
             'b' => {2 => 0, 3 => 0},
             'c' => {1 => 0, 3 => 0}}

    r = Graphmatch.match(left, right, edges)
    assert_equal({"a" => 2, "b" => 3, "c" => 1}, r)
  end

  def test_overmatch
    left = ['a', 'b', 'c', 'd']
    right = [1, 2, 3]
    edges = {'a' => {2 => 0, 3 => 0},
             'b' => {1 => 0, 3 => 0},
             'c' => {1 => 0, 2 => 0},
             'd' => {2 => 0, 3 => 0}}

    r = Graphmatch.match(left, right, edges)
    assert_equal(3, r.length)
    assert_equal([1, 2, 3].to_set, r.values.to_set)
  end

  def test_mincost_path_simple
    left = ['a', 'b', 'c']
    right = [1, 2, 3]
    edges = {'a' => {1 => 100, 2 => 10, 3 => 1},
             'b' => {1 => 10, 2 => 1, 3 => 100},
             'c' => {1 => 1, 2 => 100, 3 => 10}}

    r = Graphmatch.match(left, right, edges, search = :min_cost)
    assert_equal({'a' => 3, 'b' => 2, 'c' => 1}, r)
  end

  def test_mincost_path_negative_weights
    left = ['a', 'b', 'c']
    right = [1, 2, 3]
    edges = {'a' => {1 => 10, 2 => -10, 3 => 0},
             'b' => {1 => -10, 2 => 0, 3 => 10},
             'c' => {1 => 0, 2 => 10, 3 => -10}}

    r = Graphmatch.match(left, right, edges, search = :min_cost)
    assert_equal({'a' => 2, 'b' => 1, 'c' => 3}, r)
  end

  def test_mincost_overmatch
    left = ['a', 'b', 'c', 'd', 'e', 'f']
    right = [1, 2, 3]

    edges = {'a' => {1 => 50, 2 => 50, 3 => 50},
             'b' => {1 => 40, 2 => 40, 3 => 40},
             'c' => {1 => 30, 2 => 30, 3 => 30},
             'd' => {1 => 20, 2 => 20, 3 => 20},
             'e' => {1 => 10, 2 => 10, 3 => 10},
             'f' => {1 => 0, 2 => 0, 3 => 0}}

    r = Graphmatch.match(left, right, edges, search = :min_cost)
    assert_equal(['f', 'e', 'd'].to_set, r.keys.to_set)
  end
end

