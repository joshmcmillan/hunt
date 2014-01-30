class Hunt < ActiveRecord::Base
  has_many :hunt_users
  has_many :users, through: :hunt_users
  has_many :properties

  validates :target_beds, presence: true, numericality: true
  validates :target_cost_unit, presence: true, inclusion: %W(monthly weekly)
  validates :target_cost_value, presence: true, numericality: true
  validates :location, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :distance, presence: true, numericality: true
end
