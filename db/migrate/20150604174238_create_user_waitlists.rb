class CreateUserWaitlists < ActiveRecord::Migration
  def change
    create_table :user_waitlists do |t|
      t.references  :user, null: false, index: true
      t.references  :waitlist, null: false, index: true
      t.timestamps null: false
    end
    add_index :user_waitlists, [:user_id, :waitlist_id]
  end
end
