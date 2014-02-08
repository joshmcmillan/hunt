class PropertyAttribute < ActiveRecord::Base
  belongs_to :property

  validates :property, presence: true
  validates :key, presence: true
  validates :value, presence: true
end
