class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader

  before_create do
    self.original_file = self.file.original_file
  end
end
