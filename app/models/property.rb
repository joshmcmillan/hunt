class Property < ActiveRecord::Base
  acts_as_commentable
  belongs_to :hunt
  has_one :location, as: :locatable
end
