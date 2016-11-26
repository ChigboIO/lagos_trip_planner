class Graph
  attr_reader :locations, :roads

  def initialize(nodes, edges)
    @locations = {}
    nodes.each do |node|
      @locations[node.id] = node
    end

    @roads = {}
    edges.each do |edge|
      @roads[edge.id] = edge
    end
  end
end
