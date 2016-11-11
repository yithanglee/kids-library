class BooksController < ApplicationController
  before_action :set_books
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET authors/1/books
  def index
    @books = Book.all
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
    @categories = Category.all
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
      # the old - new category will remain the latest categories, so the old category need to remove the book, and insert the book into the category.
      old_categories = @book.categories.all
      old_categories.each do |x|
        x.books.destroy(@book)
      end      
      @categories = params["book"]["categories"]
        # create new category if didn't exist.
        @categories.each do |x|
          a = Category.find_by(name: x)
          if a.nil?
            Category.create(name: a)
          end
          a.books << @book
        end

      redirect_to(@book, notice: 'Book was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE authors/1/books/1
  def destroy
    @book.destroy

    redirect_to books_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_books
    
    end

    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:name, :category, :isbn, :barcode )

    end
end
