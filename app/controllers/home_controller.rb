class HomeController < ApplicationController
  def index
    @path = algo.find_path(Location.find(48), Location.last)
  end
end
