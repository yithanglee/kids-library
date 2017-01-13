class AddIsExtendedToLoans < ActiveRecord::Migration[5.0]
  def change
    add_column :loans, :is_extended, :boolean, default: false
  end
end
