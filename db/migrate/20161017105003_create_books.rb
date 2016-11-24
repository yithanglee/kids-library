class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :isbn
      t.string :barcode
      t.string :author_1
      t.string :author_2
      t.string :author_3
      t.string :publisher
      t.string :series
      t.string :volume
      t.string :country
      t.string :condition
      t.string :price
      t.timestamps
    end
  end
end
