class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.integer :request_type
      t.string  :first_name, null: false
      t.string  :last_name, null: false
      t.string  :email, null: false
      t.string  :phone
      t.text    :notes
      t.timestamps null: false
    end
  end
end
