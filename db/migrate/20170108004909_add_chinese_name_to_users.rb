class AddChineseNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :chinese_name, :string
  end
end
