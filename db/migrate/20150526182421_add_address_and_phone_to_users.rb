class AddAddressAndPhoneToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :address, :string
  	add_column :users, :city, :string
  	add_column :users, :state, :string
  	add_column :users, :zipcode, :integer
  	add_column :users, :phone, :string
  end
end
