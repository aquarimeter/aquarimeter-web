class Image < ActiveRecord::Base
  belongs_to :aquarium
  mount_uploader :image, ImageUploader
end
