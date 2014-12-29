class ProcessSnapshotWorker
  include Sidekiq::Worker

  def perform(id)
    image = Image.find(id)
    uploader = image.file
    uploader.process_async = true
    uploader.recreate_versions!(:thumb)
    uploader.recreate_versions!(:scaled_full)
    uploader.process_async = false
  end
end
