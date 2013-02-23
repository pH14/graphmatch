class Graphmatch
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
