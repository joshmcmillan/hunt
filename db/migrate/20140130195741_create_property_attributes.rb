class CreatePropertyAttributes < ActiveRecord::Migration
  def change
    create_table :property_attributes do |t|
      t.belongs_to :property, index: true
      t.string :key
      t.text :value # TODO: unfuck this later

      t.timestamps
    end
  end
end
