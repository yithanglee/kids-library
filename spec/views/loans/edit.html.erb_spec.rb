require 'rails_helper'

RSpec.describe "loans/edit", type: :view do
  before(:each) do
    @loan = assign(:loan, Loan.create!(
      :book_id => 1,
      :user_id => 1
    ))
  end

  it "renders the edit loan form" do
    render

    assert_select "form[action=?][method=?]", loan_path(@loan), "post" do

      assert_select "input#loan_book_id[name=?]", "loan[book_id]"

      assert_select "input#loan_user_id[name=?]", "loan[user_id]"
    end
  end
end
