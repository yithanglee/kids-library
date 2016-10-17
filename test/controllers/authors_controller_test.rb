require 'test_helper'

class AuthorsControllerTest < ActionController::TestCase
  setup do
    @publisher = publishers(:one)
    @author = authors(:one)
  end

  test "should get index" do
    get :index, params: { publisher_id: @publisher }
    assert_response :success
  end

  test "should get new" do
    get :new, params: { publisher_id: @publisher }
    assert_response :success
  end

  test "should create author" do
    assert_difference('Author.count') do
      post :create, params: { publisher_id: @publisher, author: @author.attributes }
    end

    assert_redirected_to publisher_author_path(@publisher, Author.last)
  end

  test "should show author" do
    get :show, params: { publisher_id: @publisher, id: @author }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { publisher_id: @publisher, id: @author }
    assert_response :success
  end

  test "should update author" do
    put :update, params: { publisher_id: @publisher, id: @author, author: @author.attributes }
    assert_redirected_to publisher_author_path(@publisher, Author.last)
  end

  test "should destroy author" do
    assert_difference('Author.count', -1) do
      delete :destroy, params: { publisher_id: @publisher, id: @author }
    end

    assert_redirected_to publisher_authors_path(@publisher)
  end
end
