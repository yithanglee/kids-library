require 'rails_helper'

RSpec.describe "loans/new", type: :view do
  before(:each) do
    assign(:loan, Loan.new(
      :book_id => 1,
      :user_id => 1
    ))
  end

  it "renders new loan form" do
    render

    assert_select "form[action=?][method=?]", loans_path, "post" do

      assert_select "input#loan_book_id[name=?]", "loan[book_id]"

      assert_select "input#loan_user_id[name=?]", "loan[user_id]"
    end
  end
end
