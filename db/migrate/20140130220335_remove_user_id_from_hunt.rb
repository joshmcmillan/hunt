class RemoveUserIdFromHunt < ActiveRecord::Migration
  def change
    remove_reference :hunts, :user, index: true
  end
end
