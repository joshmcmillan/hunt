class CreateHuntUsers < ActiveRecord::Migration
  def change
    create_table :hunt_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :hunt, index: true

      t.timestamps
    end
  end
end
