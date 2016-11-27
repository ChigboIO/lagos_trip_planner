require_relative './places_array'

# Road.destroy_all
# Location.destroy_all

# Location.connection.execute("INSERT INTO locations(name, latitude, longitude) VALUES #{PlacesArray::PLACES}")

# Method to calculate distance between two points on earth surfae
def distance_apart(loc1, loc2)
  rad_per_deg = Math::PI/180  # PI / 180
  rkm = 6371                  # Earth radius in kilometers
  rm = rkm * 1000             # Radius in meters

  dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
  dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

  lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
  lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

  a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
  c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

  rm * c # Delta in meters
end


conn = Faraday.new('https://maps.googleapis.com') do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  # faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

count = 0
Location.order(:id).combination(2).each do |places|
  loc_1 = places[0]
  loc_2 = places[1]
  dist = distance_apart([loc_1.latitude, loc_1.longitude], [loc_2.latitude, loc_2.longitude])

  to = Road.find_by(origin_location: loc_1, destination_location: loc_2)
  next if to

  if dist <= 10000
    response = conn.get(
      '/maps/api/distancematrix/json',
      {
        origins: "#{loc_1.latitude},#{loc_1.longitude}",
        destinations: "#{loc_2.latitude},#{loc_2.longitude}",
        key: ENV['GOOGLE_API_KEY']
      }
    )

    response = JSON.parse(response.body)

    if response['status'] == "OK"
      status = response['rows'][0]['elements'][0]['status']
      if status == "OK"
        distance = response['rows'][0]['elements'][0]['distance']['value']

        to = Road.find_or_create_by(origin_location: loc_1, destination_location: loc_2, distance: distance)
        fro = Road.find_or_create_by(origin_location: loc_2, destination_location: loc_1, distance: distance)

        puts "Created Roads:     #{loc_1}  <<=====>> #{loc_2}  -- Distance: #{distance} meters"
      else
        to = Road.find_or_create_by(origin_location: loc_1, destination_location: loc_2, distance: 0)
        puts "Request between #{loc_1} and #{loc_2} was not successful: #{status}"
      end
    else
      puts "Request between #{loc_1}(id = #{loc_1.id}) and #{loc_2} was not successful: #{response['status']}"
      puts "Reached Query Limit. Breaking Off..."
      break
    end

    count += 1
  end
end
puts count
