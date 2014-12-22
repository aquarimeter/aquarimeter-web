class Image < ActiveRecord::Base
  belongs_to :aquarium
  mount_uploader :processed_image, ProcessedImage
  mount_uploader :unprocessed_image, UnprocessedImage
end
