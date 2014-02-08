class RemoveLocationAndLatitudeAndLongitudeAndDistanceFromHunts < ActiveRecord::Migration
  def change
    remove_column :hunts, :location, :string
    remove_column :hunts, :latitude, :string
    remove_column :hunts, :longitude, :string
    remove_column :hunts, :distance, :string
  end
end
