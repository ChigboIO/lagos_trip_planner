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
end
