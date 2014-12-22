class Aquarium < ActiveRecord::Base
  validate :ideal_temperature, :presence => true, :enumericality => { greater_than: :ideal_temp_low,
                                                                      less_than: :ideal_temp_high}
  validates :ideal_temp_low, :presence => true, :numericality => { less_than: :ideal_temp_high }
  validates :ideal_temp_high, :presence => true, :numericality => { greater_than: :ideal_temp_low }
  validates :name, :presence => true, :uniqueness => true, :length => 3..255
  has_many :sensor_readings
  has_many :images
  belongs_to :user
  accepts_nested_attributes_for :sensor_readings
  accepts_nested_attributes_for :images
end

