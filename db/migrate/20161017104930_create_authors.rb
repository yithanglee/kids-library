class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.references :publisher, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
