class SensorReadingSerializer < ActiveModel::Serializer
  attributes :id, :aquarium_id, :temperature, :ph
end
