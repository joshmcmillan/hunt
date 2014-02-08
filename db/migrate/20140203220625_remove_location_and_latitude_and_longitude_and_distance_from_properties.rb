class RemoveLocationAndLatitudeAndLongitudeAndDistanceFromProperties < ActiveRecord::Migration
  def change
    remove_column :properties, :location, :string
    remove_column :properties, :latitude, :string
    remove_column :properties, :longitude, :string
  end
end
