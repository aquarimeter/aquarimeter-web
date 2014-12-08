class SensorReadingSerializer < ActiveModel::Serializer
  attributes :id, :temperature, :ph
end
