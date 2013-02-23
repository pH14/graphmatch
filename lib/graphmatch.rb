class Graphmatch
  # Optimally match two sets of vertices.
  #
  # The edges must be specified as a hash of hashes, the keys being left vertices
  # and the values be a hash of right vertices and the weights to them.
  #
  # Ex. 
  #     Matching ['a', 'b'] to [1, 2], restrict it so 'a' can only reach 2.
  #     All path lengths are uniform (= 0)
  #
  #      left = ["a", "b"]
  #      right = [1, 2]
  #      edges = {"a" => {2 => 0},
  #               "b" => {1 => 0, 2 >= 0}}
  #      Graphmatch.match(left, right, edges)
  # 
  # Ex.
  #     Matching ['a', 'b'] to ['y', 'z'] with edge weights. 'a' is matched to 'y',
  #     'b' is matched to 'z'
  #
  #     left = ['a', 'b']
  #     right ['y', z']
  #     edges = {'a' => {'y' => 1, 'z' => 100},
  #              'b' => {'y' => 100, 'z' => 1}}
  #     Graphmatch.match(left, right, edges, search = :min_cost)
  #
  # If the path lengths are equal, set search to :shortest_path.
  # If the path lengths vary, set search to :min_cost to optimize for min-cost max-flow
  #
  # @param left_vertices [Array] list of names of vertices on the left
  # @param right_vertices [Array] list of names of vertices on the right
  # @param edges [Hash] a hash of hashes, edges and their weights from left to right
  # @param search [Symbol] the augmentation path search type, :shortest_path or :min_cost 
  # @return [Hash] keys are left vertices, values are right vertices
  def self.match(left_vertices, right_vertices, edges, search = :shortest_path)
    vertices = left_vertices + right_vertices + [:sink, :source]

    edges[:sink] = {}
    edges[:source] = {} 

    left_vertices.each { |lv| edges[:source][lv] = 0 }
    right_vertices.each { |rv| edges[rv] = { :sink => 0 } }

    graph = { vertices: vertices, edges: edges }

    matching = Maxflow.best_matching! graph, search = search
  end
end

require 'graphmatch/maxflow'
