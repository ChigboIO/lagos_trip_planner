class DijkstraAlgorithm
  attr_reader :locations, :roads, :unvisited

  def initialize(graph)
    @locations = graph.locations
    @roads = graph.roads
    @unvisited = Unvisited.new
  end

  def find_path(source, destination)
    source = locations[source.id]
    destination = locations[destination.id]

    source.distance = 0
    source.road_by = nil
    unvisited.add(source)

    until unvisited.size == 0
      location = unvisited.get_minimum
      location.visited = true
      recalculate_minimal_distance_from(location)
      unvisited.remove(location)
    end

    return destination, get_path_to(destination) if destination.distance < Fixnum::MAX
  end

  def recalculate_minimal_distance_from(location)
    neighbors = get_neighboring_locations(location)
    neighbors.each do |target|
      road = Road.find_by(origin_location: location, destination_location: target)
      if (new_distance = road.distance + location.distance) < target.distance
        target.distance = new_distance
        target.previous_location = location
        target.road_by = road
      end

      unvisited.add(target)
    end
  end

  def get_neighboring_locations(location)
    # debugger
    locs = location.roads_from.map { |road| locations[road.destination_location_id] }
    locs.select { |loc| !loc.visited }
  end

  def get_path_to(location)
    paths = Array(location)
    while location = location.previous_location
      paths.unshift(location)
    end

    paths
  end
end
