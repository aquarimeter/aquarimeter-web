class AquariumSerializer < ActiveModel::Serializer
  attributes :id, :name, :ideal_temp_low, :ideal_temp_high
end
