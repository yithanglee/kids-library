class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :ic
    	t.string :member_id
    	t.string :email
    	t.string :phone
    	t.date :birthday
      t.timestamps null:false
    end
  end
end
