class ApplicationController < ActionController::Base
  attr_reader :algo

  before_action :all_roads, :all_locations, :setup

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=Washington,DC&destinations=New+York+City,NY&key=YOUR_API_KEY
  # https://maps.googleapis.com/maps/api/distancematrix/json?origins=Oshosun+Lagos&destinations=Ojota+Lagos&key=YOUR_API_KEY

  def setup
    return if @algo

    graph = Graph.new(all_locations, all_roads)
    @algo = DijkstraAlgorithm.new(graph)
  end

  def all_roads
    @roads ||= Road.includes(:origin_location, :destination_location)
  end

  def all_locations
    @locations ||= Location.includes(:roads_from, :roads_to)
  end

  def index

  end
end
