class Graph
  attr_reader :locations, :roads

  def initialize(locations, roads)
    @locations = locations
    @roads = roads
  end
end
