class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_books, only: [:edit]




  def index
    if current_user.nil?
      show_item = 40
    elsif current_user.is_admin?
      show_item = 10
    else
      show_item = 40
    end
    @books = Book.all.order('name ASC').paginate(:page => params[:page], :per_page => show_item)
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
             
      redirect_to( @book, notice: 'Book was successfully created.')
    else
      render action: 'new'
    end
  end


  def update
    if @book.update_attributes(book_params)
      redirect_to book_path, notice: 'Book was successfully updated.'
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

  def quick_loan
        search_params = params.permit(:term, :user)
        @books = Book.quick_search(search_params)
        @book = @books
        if @books.blank?
          redirect_to books_path, flash:{alert: "no successful search result"}
        else
          render :show
        end
  end

  def search
        search_params = params.permit(:book_name, :author, :barcode)
        @books = Book.search(search_params)
        if @books.blank?
          redirect_to books_path, flash:{alert: "no successful search result"}
        else
          @books = @books.order('created_at ASC').paginate(:page => params[:page], :per_page => 20)
          @categories = Category.all
          @book = Book.new
          render :index
        end
  end

  def list_by_category
        @books = Category.find(params[:category]).books
        if @books.blank?
          redirect_to books_path, flash:{alert: "no successful search result"}
        else
          if current_user.nil?
            show_item = 40
          elsif current_user.is_admin?
            show_item = 10
          else
            show_item = 40
          end
          @books = @books.order('barcode ASC').paginate(:page => params[:page], :per_page => show_item)
          @categories = Category.all
          @book = Book.new
          render :index
        end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_books
            @books = Book.order('created_at ASC').paginate(:page => params[:page], :per_page => 10)
    end

    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:name, :isbn, :barcode, :series, :volume, :publisher, :price, :author_1, :author_2, :author_3, :image_url, :illustrator, :translator )
    end
end
