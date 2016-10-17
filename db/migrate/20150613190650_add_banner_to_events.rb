class AddBannerToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :banner
    end
  end

  def self.down
    remove_attachment :events, :banner
  end
end
