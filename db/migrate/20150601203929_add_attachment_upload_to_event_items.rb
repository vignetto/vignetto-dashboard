class AddAttachmentUploadToEventItems < ActiveRecord::Migration
  def self.up
    change_table :event_items do |t|
      t.attachment :upload
    end
  end

  def self.down
    remove_attachment :event_items, :upload
  end
end
