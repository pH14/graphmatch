class Graphmatch::BellmanFord
  def self.search(graph, source = :source, sink = :sink)
    distance = {}
    parent = {}

    graph[:vertices].each do |v|
      distance[v] = (v == source) ? 0 : Float::INFINITY
      parent[v] = nil
    end

    # Bellman-Ford edge relaxation
    graph[:vertices].each do |vertex|
      graph[:edges].map do |u, neighbors|
        graph[:edges][u].map do |v, w|

          if distance[u] + w < distance[v]
            distance[v] = distance[u] + w
            parent[v] = u
          end
        end
      end
    end

    # Run once more to check for negative-weight cycles
    graph[:edges].map do |u, neighbors|
      graph[:edges][u].map do |v, w|
        if distance[u] + w < distance[v]
          raise "Graph contains negative-weight cycle"
        end
      end
    end

    return distance, parent
  end
end
