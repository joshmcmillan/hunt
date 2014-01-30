class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :property, index: true
      t.string :name
      t.string :phone
      t.string :url
      t.string :company_name

      t.timestamps
    end
  end
end
