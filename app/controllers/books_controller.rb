class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
    before_action :set_books, only: [:edit]


  def index
    all_books = Book.all
    page_per_item = 5
    byebug

    @books = 
    @categories = Category.all
    @book = Book.new

  end


  def show

  end


  def new
    # byebug
    @book = Book.new
    @categories = Category.all
  end


  def edit
    
    @categories = Category.all
  end


  def create
    
    @book = Book.new(book_params)

    if @book.save

       @categories = params["book"]["categories"]
        # create new category if didn't exist.
        @categories.each do |x|
          a = Category.find_by(name: x)
          a.books << @book
        end
             
      redirect_to( @book, notice: 'Book was successfully created.')
    else
      render action: 'new'
    end
  end

   def quick_create

    @book = Book.new(book_params)

    if @book.save 
      @categories = params["book"]["categories"]
        # create new category if didn't exist.
        @categories.each do |x|
          a = Category.find_by(name: x)
          a.books << @book
        end
      redirect_to( books_url , notice: 'Book was successfully created.')
    else
      render action: 'new'
    end
  end


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
          a.books << @book
        end


      redirect_to(@book, notice: 'Book was successfully updated.')
    else
      render action: 'edit'
    end
  end


  def destroy
    
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
        @books = Book.search(params[:term])
        @book = @books
        if @books.blank?
          redirect_to books_path, flash:{alert: "no successful search result"}
        else
          render :edit
        end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_books
            @books = Book.all
    end

    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:name, :isbn, :barcode, :series, :volume, :publisher, :price, :author_1, :author_2, :author_3 )
    end
end
