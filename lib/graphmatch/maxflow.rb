class Graphmatch::Maxflow
  # Finds a maximal matching in a bipartite graph. Mutates the graph.
  #
  # Returns a hash representing the matching.
  def self.best_matching!(graph, source = :source, sink = :sink)
    loop do
      path = augmenting_path graph
      break unless path
      augment_flow_graph! graph, path
    end
    matching_in graph, source, sink
  end

  # Finds an augmenting path in a flow graph.
  #
  # Returns the path from source to sink, as an array of edge arrays, for
  # example [[:source, 'a'], ['a', 'c'], ['c', :sink]]
  def self.augmenting_path(graph, source = :source, sink = :sink)
    # TODO(costan): replace this with Bellman-Ford to support min-cost matching.

    # Breadth-first search.
    parents = { source => true }
    queue = [source]
    until queue.empty?
      current_vertex = queue.shift
      break if current_vertex == sink
      (graph[:edges][current_vertex] || {}).each do |new_vertex, edge|
        next if parents[new_vertex]
        parents[new_vertex] = current_vertex
        queue << new_vertex
      end
    end
    return nil unless parents[sink]

    # Reconstruct the path.
    path = []
    current_vertex = sink
    until current_vertex == source
      path << [parents[current_vertex], current_vertex]
      current_vertex = parents[current_vertex]
    end
    path.reverse!
  end

  # Augments a flow graph along a path.
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
  def self.matching_in(graph, source = :source, sink = :sink)
    Hash[*((graph[:edges][sink] || {}).keys.map { |matched_vertex|
      [graph[:edges][matched_vertex].keys.first, matched_vertex]
    }.flatten)]
  end

  # The reverse of a student -> section assignment.
  def self.inverted_assignment(matching)
    inverted = {}
    matching.each { |k, v| inverted[v] ||= []; inverted[v] << k }
    inverted
  end
end
