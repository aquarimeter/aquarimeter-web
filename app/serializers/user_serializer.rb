class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token, :first_name, :last_name
end
