class AddNameToHunts < ActiveRecord::Migration
  def change
    add_column :hunts, :name, :string
  end
end
