class AddAddressesToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :line1, :string
  	add_column :users, :line2, :string
  	add_column :users, :line3, :string
  	add_column :users, :postcode, :string
  	add_column :users, :city, :string
  	add_column :users, :state, :string
  end
end
