class AddFineToLoans < ActiveRecord::Migration[5.0]
  def change
    add_column :loans, :fine_amount, :string, default: "0.00"
  end
end
