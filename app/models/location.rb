class Location < ActiveRecord::Base
  attr_accessor :previous_location
  attr_writer :distance, :visited, :road_by

  has_many :road_from, class_name: Road, foreign_key: :origin_location_id, dependent: :destroy
  has_many :road_to, class_name: Road, foreign_key: :destination_location_id, dependent: :destroy

  def distance
    @distance ||= Fixnum::MAX
  end

  def visited
    @visited ||= false
  end

  def road_by
    @road_by
  end

  def to_s
    name
  end
end
