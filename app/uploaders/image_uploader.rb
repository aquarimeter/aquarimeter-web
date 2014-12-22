# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include ::CarrierWave::Backgrounder::Delay

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg png gif tiff)
  end


  def filename
    model.random_string + File.extname(@filename) if @filename
  end

  version :thumb_small do
    process :resize_to_fill => [50,50]
    process :strip
  end
  version :thumb_medium do
    process :resize_to_limit => [100,100]
    process :strip
  end
  version :thumb_large do
    process :resize_to_limit => [300,300]
    process :strip
  end
  version :scaled_full do
    process :resize_to_limit => [700,nil]
    process :strip
  end

  def strip
    manipulate! do |img|
      img.strip
      img = yield(img) if block_given?
      img
    end
  end
end
