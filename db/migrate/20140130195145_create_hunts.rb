class CreateHunts < ActiveRecord::Migration
  def change
    create_table :hunts do |t|
      t.belongs_to :user, index: true
      t.integer :target_beds
      t.string :target_cost_unit
      t.integer :target_cost_value
      t.string :location
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.decimal :distance

      t.timestamps
    end
  end
end
