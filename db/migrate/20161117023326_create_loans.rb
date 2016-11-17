class CreateLoans < ActiveRecord::Migration[5.0]
  def change
    create_table :loans do |t|
      t.date :loan_date
      t.date :return_date
      t.integer :book_id
      t.integer :user_id

      t.timestamps
    end
  end
end
