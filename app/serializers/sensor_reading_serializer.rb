class SensorReadingSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :aquarium_id, :temperature, :ph
end
