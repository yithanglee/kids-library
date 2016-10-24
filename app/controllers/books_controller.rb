class BooksController < ApplicationController
  before_action :set_books
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET authors/1/books
  def index
    @books = @author.books
  end

  # GET authors/1/books/1
  def show
  end

  # GET authors/1/books/new
  def new
    # byebug
    @book = @author.books.build
  end

  # GET authors/1/books/1/edit
  def edit
  end

  # POST authors/1/books
  def create
    byebug
    @book = @author.books.build(book_params)

    if @book.save
      redirect_to([@book.author.publisher, @book.author, @book], notice: 'Book was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT authors/1/books/1
  def update
    if @book.update_attributes(book_params)
      redirect_to([@book.author.publisher, @book.author, @book], notice: 'Book was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE authors/1/books/1
  def destroy
    @book.destroy

    redirect_to publisher_author_books_url(@author.publisher, @author)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_books
      @author = Author.find(params[:author_id])
    end

    def set_book
      @book = @author.books.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:name, :category, :isbn, :barcode, :abc)

    end
end
