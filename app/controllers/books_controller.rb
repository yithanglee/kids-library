class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
    before_action :set_books, only: [:edit]



  # GET authors/1/books
  def index

    @books = Book.all
    @categories = Category.all
    @book = Book.new
    @author = Author.new

  end

  # GET authors/1/books/1
  def show

  end

  # GET authors/1/books/new
  def new
    # byebug
    @book = Book.new
    @categories = Category.all
  end

  # GET authors/1/books/1/edit
  def edit
    
    @categories = Category.all
  end

  # POST authors/1/books
  def create
    
    @book = Book.new(book_params)

    if @book.save

       # @categories = params["book"]["categories"]
       #  # create new category if didn't exist.
       #  @categories.each do |x|
       #    a = Category.find_by(name: x)
       #    a.books << @book
       #  end

        author = Author.find(params["book"]["authors"])
        author.books << @book

      redirect_to( @book, notice: 'Book was successfully created.')
    else
      render action: 'new'
    end
  end

   def quick_create
            @categories = Category.all
    @book = Book.new(book_params)

    if @book.save 



        author = Author.find(params["book"]["authors"])
        author.books << @book

      redirect_to( books_url , notice: 'Book was successfully created.')
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
         
      # @categories = params["book"]["categories"]
      #   # create new category if didn't exist.
      #   @categories.each do |x|
      #     a = Category.find_by(name: x)
      #     a.books << @book
      #   end

      old_author = @book.authors.all
      old_author.each do |x|
        x.books.destroy(@book)
      end

      author = Author.find(params["book"]["authors"])
      author.books << @book

      redirect_to(@book, notice: 'Book was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE authors/1/books/1
  def destroy
    
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
        @books = Book.search(params[:term], fields: [{isbn: :exact}])
        if @books.blank?
          redirect_to books_path, flash:{danger: "no successful search result"}
        else
          render :index
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
      params.require(:book).permit(:name, :isbn, :barcode, :categories )
    end
end
