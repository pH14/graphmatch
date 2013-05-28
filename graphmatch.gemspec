Gem::Specification.new do |s|
  s.name        = 'graphmatch'
  s.version     = '1.0.1'
  s.date        = '2013-05-28'
  s.summary     = "Optimal bipartite graph matching"
  s.description = "An implementation of the Ford-Fulkerson max-flow algorithm for maximum matching." \
                  "Supports maximum flow as well as minimum-cost maximum flow."
  s.authors     = ["Paul Hemberger", "Victor Costan"]
  s.email       = 'pwh@mit.edu'
  s.files       = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.homepage    =
    'http://rubygems.org/gems/graphmatch'
end
