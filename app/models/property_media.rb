class PropertyMedia < ActiveRecord::Base
  belongs_to :property
  has_attached_file :file
end
