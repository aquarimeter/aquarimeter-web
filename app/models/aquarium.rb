class Aquarium < ActiveRecord::Base
  self.table_name  = 'aquariums'
  validates :name, :presence => true, :uniqueness => true, :length => 3..255
  validates_associated :user
  has_many :sensor_readings
  belongs_to :user

end
