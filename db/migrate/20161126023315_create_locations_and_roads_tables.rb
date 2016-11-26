class CreateLocationsAndRoadsTables < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.decimal :longitude
      t.decimal :latitude
      t.timestamps
    end

    create_table :roads do |t|
      t.integer :distance
      t.integer :origin_location_id
      t.integer :destination_location_id
      t.timestamps
      # replace them with t.belongs_to :origin_location, table: :locations. Confirm please
    end
  end
end
