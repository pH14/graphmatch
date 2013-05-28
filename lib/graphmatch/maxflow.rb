class Graphmatch::Maxflow
  # Finds a maximal matching in a bipartite graph. Mutates the graph.
  #
  # @param graph [Hash] vertices and edges lists
  # @param search [Symbol] type of search to use for augmentation paths 
  # @param source [Symbol] source vertex
  # @param sink [Symbol] sink vertex
  # @return [Hash] assignment hash of left_vertices to right_vertices
  def self.best_matching!(graph, search, source = :source, sink = :sink)
    loop do
      path = augmenting_path graph, search
      break unless path
      augment_flow_graph! graph, path
    end
    matching_in graph, source, sink
  end

  # Finds an augmenting path in a flow graph.
  #
  # Returns the path from source to sink, as an array of edge arrays, for
  # example [[:source, 'a'], ['a', 'c'], ['c', :sink]]
  #
  # Search parameter will switch it from a max-flow to min-cost max-flow search
  #
  # @param (see #best_matching!)
  # @return [Array] array of edge arrays 
  def self.augmenting_path(graph, search = :shortest_path, source = :source, sink = :sink)
    if search == :shortest_path
      parents = Graphmatch::BFS.search graph, source, sink
    elsif search == :min_cost
      distance, parents = Graphmatch::BellmanFord.search graph, source
    end

    return nil unless parents[sink]

    # Reconstruct the path.
    path = []
    current_vertex = sink
    until current_vertex == source
      path << [parents[current_vertex], current_vertex]
      current_vertex = parents[current_vertex]

      if path.length > parents.length
        raise "Cannot terminate. Use integral edge weights."
      end
    end
    path.reverse!
  end

  # Augments a flow graph along a path.
  #
  # @param graph [Hash] vertices and edges lists
  # @param path [Array] array of arrays specifying a path from :source to :sink
  def self.augment_flow_graph!(graph, path)
    # Turn normal edges into residual edges and viceversa.
    edges = graph[:edges]
    path.each do |u, v|
      edges[v] ||= {}
      edges[v][u] = -edges[u][v]
      edges[u].delete v
    end
  end

  # The matching currently found in a matching graph.
  #
  # @param graph [Hash] vertices and edges lists
  # @param source [Symbol] source vertex
  # @param sink [Symbol] sink vertex
  # @return [Hash] assignment hash of left_vertices => right_vertices
  def self.matching_in(graph, source = :source, sink = :sink)
    Hash[*((graph[:edges][sink] || {}).keys.map { |matched_vertex|
      [graph[:edges][matched_vertex].keys.first, matched_vertex]
    }.flatten)]
  end
end

require 'graphmatch/bellman_ford'
require 'graphmatch/bfs'
