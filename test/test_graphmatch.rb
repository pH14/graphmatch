require 'test/unit'
require 'graphmatch'

class GraphmatchTest < Test::Unit::TestCase
  def test_really_simple
    left = ["a", "b"]
    right = [0, 1]
    edges = {"a" => [1],
             "b" => [0]}

    r = Graphmatch.match(left, right, edges)
    assert_equal({"a" => 1, "b" => 0}, r)
  end

  def test_simple
    left = ['a', 'b', 'c']
    right = [1, 2, 3]
    edges = {'a' => [2],
             'b' => [2, 3],
             'c' => [1, 3]}

    r = Graphmatch.match(left, right, edges)
    assert_equal({"a" => 2, "b" => 3, "c" => 1}, r)
  end

  def test_over_constrained
    left = ['a', 'b', 'c', 'd']
    right = [1, 2, 3]
    edges = {'a' => [2, 3],
             'b' => [1, 3],
             'c' => [1, 2],
             'd' => [2, 3]}

    r = Graphmatch.match(left, right, edges)
  end
end
