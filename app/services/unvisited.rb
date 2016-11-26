class Unvisited < Hash
  def add(location)
    self[location.id] = location
  end

  def get(location_id)
    self[location_id]
  end

  def remove(location_id)
    self.delete(location_id)
  end

  def get_minimum
    self.min_by { |id, location| location.distance }.last
  end

  def recalculate_minimal_distance_from(location, roads)
    neighbors = get_neighboring_locations(location, roads)
  end

  def get_neighboring_locations(location, roads)
    location.roads_from
  end
end
