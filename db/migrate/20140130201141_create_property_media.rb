class CreatePropertyMedia < ActiveRecord::Migration
  def change
    create_table :property_media do |t|
      t.belongs_to :property, index: true

      t.timestamps
    end
  end
end
