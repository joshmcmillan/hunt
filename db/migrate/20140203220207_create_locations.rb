class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.references :locatable, polymorphic: true, index: true
      t.string :name
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6

      t.timestamps
    end
  end
end
