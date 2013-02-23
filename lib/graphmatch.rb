class Graphmatch
  def self.match(left_vertices, right_vertices, edge_lists, search_type='BFS')
    vertices = left_vertices + right_vertices + [:sink, :source]
    edges = Hash[*(vertices.map { |v| [v, {}] }.flatten)]

    left_vertices.each do |lv| 
      edges[:source][lv] = 0
      edge_lists[lv].each { |v| edges[lv][v] = 0 }
    end

    right_vertices.each { |rv| edges[rv] = { :sink => 0 } }
    graph = { vertices: vertices, edges: edges }

    matching = Graphmatch::Maxflow.best_matching! graph
  end

  def self.match_graph(graph)
    Graphmatch::Maxflow.best_matching! graph
  end
end

require 'graphmatch/maxflow'
