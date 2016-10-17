class UserColumns < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :name, :string
  	add_column :users, :email, :string
  	add_column :users, :birthday, :date
  end
end
