class HomeController < ApplicationController
  def index
    @path = algo.find_path(Location.all.sample, Location.all.sample)
  end
end
