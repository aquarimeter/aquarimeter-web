class SensorReading < ActiveRecord::Base
  validates :ph, :presence => true
  validates :temperature, :presence => true
  scope :ph_avg,->{ average(:ph) }
  scope :temp_avg, -> {average(:temperature)}
  belongs_to :aquarium
end
