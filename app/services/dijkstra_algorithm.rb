class DijkstraAlgorithm
  attr_reader :locations, :roads, :unvisited

  def initialize(graph)
    @locations = graph.locations.clone
    @roads = graph.roads.clone
    @unvisited = Unvisited.new
  end

  def find_path(source, destination)
    source.distance = 0
    source.road_by = nil
    unvisited.add(source)

    until unvisited.size = 0
      location = unvisited.get_minimum
      location.visited = true
      unvisited
    end
  end
end
