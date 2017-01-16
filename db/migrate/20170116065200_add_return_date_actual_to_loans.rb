class AddReturnDateActualToLoans < ActiveRecord::Migration[5.0]
  def change
    add_column :loans, :actual_return_date, :date
  end
end
