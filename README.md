graphmatch
==========

Optimal bipartite graph matching algorithm gem for Ruby. It uses the Ford-Fulkerson max-flow algorithm with a super-source and super-sink to maximally match graphs.

The augmentation paths are found with either breadth-first search or Bellman-Ford. BFS is faster for unweighted matching, while Bellman-Ford can be used for min-cost max-flow matching given the edge weights. _Note: for weighted matching with Ford-Fulkerson, the edge weights must be integers otherwise the algorithm may not be able to determine a matching!_

Further documentation can be found here: http://rubydoc.info/gems/graphmatch/

##Example usage

###Unweighted matching

<pre>
left = ['a', 'b', 'c']
right = [1, 2, 3]
edges = {'a' => {2 => 0},
         'b' => {2 => 0, 3 => 0},
         'c' => {1 => 0, 3 => 0}}

Graphmatch.match(left, right, edges)
==> {'a' => 2, 'b' => 3, 'c' => 1}
</pre>

###Weighted matching

<pre>
left = ['a', 'b', 'c']
right = [1, 2, 3]
edges = {'a' => {1 => 100, 2 => 10, 3 => 1},
         'b' => {1 => 10, 2 => 1, 3 => 100},
         'c' => {1 => 1, 2 => 100, 3 => 10}}

Graphmatch.match(left, right, edges)
==> {'a' => 3, 'b' => 2, 'c' => 1}
</pre>

## Related Libraries

- [graph_matching](https://github.com/jaredbeck/graph_matching) - Maximum cardinality 
  and maximum weighted matchings in undirected graphs, both bipartite and general.
