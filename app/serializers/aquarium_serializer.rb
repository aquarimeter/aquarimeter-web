class AquariumSerializer < ActiveModel::Serializer
  attributes :id, :name, :ideal_temp_low, :ideal_temp_high
  belongs_to :user
  has_many :sensor_readings
end
