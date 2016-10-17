class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.references :author, foreign_key: true
      t.string :name
      t.string :category
      t.string :isbn
      t.string :barcode

      t.timestamps
    end
  end
end
