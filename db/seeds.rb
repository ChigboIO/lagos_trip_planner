require_relative './places_array'

Road.destroy_all
Location.destroy_all

conn = Faraday.new('https://maps.googleapis.com') do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  # faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

PlacesArray::PLACES.sample(65).combination(2).each do |places|
  response = conn.get '/maps/api/distancematrix/json',
                    { origins: places[0], destinations: places[1], key: ENV['GOOGLE_API_KEY'] }

  response = JSON.parse(response.body)

  status = response['rows'][0]['elements'][0]['status']
  if status == "OK"
    distance = response['rows'][0]['elements'][0]['distance']['value']
    loc_1 = Location.create(name: response['origin_addresses'].first)
    loc_2 = Location.create(name: response['destination_addresses'].first)

    to = Road.create(origin_location: loc_1, destination_location: loc_2, distance: distance)
    fro = Road.create(origin_location: loc_2, destination_location: loc_1, distance: distance)

    puts "Created Location: #{loc_1}"
    puts "Created Location: #{loc_2}"
    puts "Create Roads:     #{loc_1}  <<=====>> #{loc_2}  -- Distance: #{distance}"
  else
    puts "Request between #{places[0]} and #{places[1]} was not successful: #{status}"
  end

  sleep 2
end

Location.order(id: :asc).distinct(:name).each do |location|
  Location.where(name: location.name).order(id: :asc).offset(1).each do |loc|
    location.roads_from << loc.roads_from
    location.roads_to << loc.roads_to
    loc.delete
  end
end
