class AddAttachmentPreviewToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :preview
    end
  end

  def self.down
    remove_attachment :events, :preview
  end
end
