require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @author = authors(:one)
    @book = books(:one)
  end

  test "should get index" do
    get :index, params: { author_id: @author }
    assert_response :success
  end

  test "should get new" do
    get :new, params: { author_id: @author }
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, params: { author_id: @author, book: @book.attributes }
    end

    assert_redirected_to author_book_path(@author, Book.last)
  end

  test "should show book" do
    get :show, params: { author_id: @author, id: @book }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { author_id: @author, id: @book }
    assert_response :success
  end

  test "should update book" do
    put :update, params: { author_id: @author, id: @book, book: @book.attributes }
    assert_redirected_to author_book_path(@author, Book.last)
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, params: { author_id: @author, id: @book }
    end

    assert_redirected_to author_books_path(@author)
  end
end
