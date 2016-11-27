class ConvertLocationNamesToLowercase < ActiveRecord::Migration
  def up
    Location.all.each do |location|
      location.update(name: location.name.downcase)
    end
  end

  def down
    Location.all.each do |location|
      location.update(name: location.name..titleize)
    end
  end
end
