class CreateWaitlists < ActiveRecord::Migration
  def change
    create_table :waitlists do |t|
      t.references  :event, null: false, index: true
      t.references  :event_date, null: false, index: true
      t.integer     :limit, null: false
      t.integer     :total_users, null: false, default: 0
      t.boolean     :active, default: true
      t.timestamps null: false
    end
    add_index :waitlists, [:event_id, :event_date_id]
  end
end
