class AddHasReturnedToLoans < ActiveRecord::Migration[5.0]
  def change
    add_column :loans, :has_returned, :boolean, default: false
  end
end
