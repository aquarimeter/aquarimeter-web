class Image < ActiveRecord::Base
  belongs_to :aquarium
  mount_uploader :image, ImageUploader

  after_commit :on => :create do
   ProcessSnapshotWorker.perform_async(self.id)
  end

  def process_async?(image = nil)
    !! @process_async
  end

  def process_async=(value)
    @process_async = value
  end
end
