class AddParentDetailsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :parent_name, :string
    add_column :users, :parent_ic, :string
    add_column :users, :parent_phone, :string
    add_column :users, :parent_email, :string
  end
end
