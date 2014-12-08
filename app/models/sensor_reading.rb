class SensorReading < ActiveRecord::Base
  validates :ph, :presence => true
  validates :temperature, :presence => true
  belongs_to :aquarium
end
