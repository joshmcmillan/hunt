class Location < ActiveRecord::Base
  belongs_to :locatable, polymorphic: true

  validates :name, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :distance, numericality: true, unless: lambda { |l| l.distance.blank? }
end
