class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=Washington,DC&destinations=New+York+City,NY&key=YOUR_API_KEY
  # https://maps.googleapis.com/maps/api/distancematrix/json?origins=Oshosun+Lagos&destinations=Ojota+Lagos&key=YOUR_API_KEY

  def index
    
  end
end
