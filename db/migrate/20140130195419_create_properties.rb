class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.belongs_to :hunt, index: true
      t.string :name
      t.string :location
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.boolean :enquired
      t.boolean :agent_replied
      t.boolean :viewed
      t.datetime :viewing_time
      t.boolean :liked
      t.boolean :disliked
      t.boolean :unavailable

      t.timestamps
    end
  end
end
