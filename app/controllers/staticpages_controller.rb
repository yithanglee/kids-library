class StaticpagesController < ApplicationController
  def home
  	@books = Book.all
  	@categories = Category.all
  end

  def help
  end

  def quick_create
  	byebug
  end
end
