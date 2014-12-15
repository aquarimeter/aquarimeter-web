class SensorReadingSerializer < ActiveModel::Serializer
  attributes :id, :aquarium_id, :temperature, :ph
  belongs_to :aquarium
end
