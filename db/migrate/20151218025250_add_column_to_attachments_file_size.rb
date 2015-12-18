class AddColumnToAttachmentsFileSize < ActiveRecord::Migration
  def change
    add_column :attachments, :file_size, :integer
  end
end
