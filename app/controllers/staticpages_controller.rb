class StaticpagesController < ApplicationController

  def home    
  	@books = Book.all
  	@categories = Category.all
    @book = Book.new
    @author = Author.new

  end

  def help
  end


end
