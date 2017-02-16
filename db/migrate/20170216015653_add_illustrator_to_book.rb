class AddIllustratorToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :illustrator, :string
    add_column :books, :translator, :string
  end
end
