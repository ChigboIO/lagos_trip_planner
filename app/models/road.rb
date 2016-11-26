class Road < ActiveRecord::Base
  belongs_to :origin_location, class_name: Location
  belongs_to :destination_location, class_name: Location
end
