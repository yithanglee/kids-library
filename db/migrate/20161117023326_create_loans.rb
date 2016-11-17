class CreateLoans < ActiveRecord::Migration[5.0]
  def change
    create_table :loans do |t|
    	t.belongs_to :user, index: true
      t.belongs_to :book, index: true
      t.date :loan_date
      t.date :return_date

      t.timestamps
    end
  end
end
