class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references  :user, null: false, index: true
      t.boolean     :publish, default: false 
      t.boolean     :private_event, default: false
      t.boolean     :package, default: false
      t.string      :title, null: false
      t.text        :short_description, null: false 
      t.text        :description
      t.integer     :ticket_price, null: false
      t.integer     :position, default: 0
      t.timestamps null: false
    end
  end
end
