class AddMemberIdToUsers < ActiveRecord::Migration[5.0]
  def change
  	  	add_column :users, :member_id, :string
  end
end
