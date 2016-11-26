class Unvisited < Hash
  def add(location)
    self[location.id] = location
  end

  def remove(location)
    self.delete(location.id)
  end

  def get_minimum
    self.min_by { |id, location| location.distance }.last
  end
end
