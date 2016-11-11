class CreateBooksAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors_books do |t|
    	t.belongs_to :book, index: true
      t.belongs_to :author, index: true

      t.timestamps
    end
  end
end


