class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader

  before_create do
    puts '1111111111111111111'
    puts self.file.original_file
    self.original_file = self.file.original_file
  end
end
