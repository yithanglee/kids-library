class StaticpagesController < ApplicationController

  def home    
  	@books = Book.all
  	@categories = Category.all
    @book = Book.new
    @author = Author.new

  end

  def help
  end


  def  print_barcode

    require 'barby'
    require 'barby/barcode/code_128'
    require 'barby/outputter/rmagick_outputter'
    barcode = Barby::Code128B.new('P100001')
    outputter = Barby::RmagickOutputter.new(barcode)
    outputter.margin = 
    outputter.to_png
    outputter.to_jpg
    outputter.to_gif

    File.open('barcode128.jpg', 'wb'){|f| f.write(barcode.to_jpg) }

  end

end
