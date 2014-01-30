class Property < ActiveRecord::Base
  acts_as_commentable
  belongs_to :hunt
end
