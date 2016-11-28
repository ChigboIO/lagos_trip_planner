class HomeController < ApplicationController
  def index
  end

  def search
    @origin, @destination = params[:origin].downcase, params[:destination].downcase
    @dest, @path = algo.find_path(Location.find_by(name: @origin), Location.find_by(name: @destination))
    respond_to do |format|
      format.js { render :search}
    end
  end

  def roads
  end
end
