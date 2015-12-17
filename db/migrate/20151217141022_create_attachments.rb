class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.column :file, :string
      t.column :task_id, :integer
      t.column :original_file, :string
      t.timestamps null: false
    end
  end
end
