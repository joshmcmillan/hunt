class AddAttachmentFileToPropertyMedia < ActiveRecord::Migration
  def self.up
    change_table :property_media do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :property_media, :file
  end
end
