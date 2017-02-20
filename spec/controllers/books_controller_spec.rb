require 'rails_helper'

RSpec.describe BooksController, type: :controller do
	describe "GET #index" do
		it 'let visitors see all books' do
			get :index
			expect(response).to render_template("index")
		end
	end

	describe "GET any Category books" do

  before(:each) do
    @category = Category.create
  end
  after(:all) do
  	@category.destroy
	end

		it 'let visitors see English books' do

			get :list_by_category, {:params => {:category => '1'}}
			expect(response).to render_template("index")
		end

	end

end
