class Aquarium < ActiveRecord::Base
  self.table_name  = 'aquariums'
  validates :name, :presence => true, :uniqueness => true, :length => 3..255
  validates_associated :user
  has_many :sensor_readings
  belongs_to :user
  accepts_nested_attributes_for :sensor_readings
end
