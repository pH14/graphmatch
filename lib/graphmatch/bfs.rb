class Graphmatch::BFS
  # Implementation of Breadth-First Search
  #
  # @param graph [Hash] contains vertices, edges
  # @param source [Symbol] starting vertex
  # @param sink [Symbol] ending vertex
  def self.search(graph, source = :source, sink = :sink)
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

    parents
  end
end
