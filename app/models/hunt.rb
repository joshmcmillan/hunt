class Hunt < ActiveRecord::Base
  has_many :hunt_users
  has_many :users, through: :hunt_users
  has_many :properties
  has_many :locations, as: :locatable

  validates :name, presence: true
  validates :target_beds, presence: true, numericality: true
  validates :target_cost_unit, presence: true, inclusion: %w[monthly weekly]
  validates :target_cost_value, presence: true, numericality: true
end
