class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references  :user, null: false, index: true
      t.references  :event, null: false, index: true
      t.references  :event_date, null: false, index: true
      t.integer     :tickets, null: false, default: 1
      t.integer     :ticket_price, null: false
      t.string      :full_name, null: false
      t.integer     :amount, null: false
      t.string      :stripe_charge_id, null: false
      t.string      :card_token
      t.string      :stripe_email
      t.string      :description
      t.string      :statement_descriptor
      t.string      :status
      t.boolean     :paid
      t.boolean     :refunded, default: false        
      t.string      :card_brand
      t.string      :card_four
      t.string      :card_exp
      t.string      :address, null: false
      t.string      :city, null: false
      t.string      :state, null: false
      t.integer     :zipcode, null: false
      t.timestamps  null: false
    end
    add_index :payments, [:user_id, :event_id, :event_date_id]
    add_index :payments, [:user_id, :event_id]
    add_index :payments, [:user_id, :event_date_id]
    add_index :payments, [:event_id, :event_date_id]
  end
end
