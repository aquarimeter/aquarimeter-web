class AquariumSerializer < ActiveModel::Serializer
  attributes :id, :name, :ideal_temperature, :ideal_temp_low, :ideal_temp_high
  has_many :sensor_readings
end
