require 'rails_helper'

RSpec.describe BooksController, type: :controller do

 describe "index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
      expect(response.body).to eq ""
    end

    it "renders the book/index template" do
      get :index
      expect(response).to render_template("books/index")
      expect(response.body).to eq ""
    end
  end


 describe "new" do
    it "renders the index template" do
      controller.prepend_view_path 'app/views'
      controller.append_view_path 'app/views'
      get :new
      expect(response).to render_template("new")
      expect(response.body).to eq ""
    end
 end

end
