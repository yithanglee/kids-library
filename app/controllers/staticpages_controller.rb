class StaticpagesController < ApplicationController

  def home    
  	@books = Book.all
  	@categories = Category.all
    @book = Book.new


  end

  def help
  	@paragraph = {}
  	@lines = []
  	# need to do a migration using this page, will open a file from the root, then tries to import it, never tried a chinese file before, but will attempt to.
  	File.open("2016_07_newbooks_damien.txt", "r:UTF-16").each do |line|
  	 	@lines << line
  	end
  	n = @lines.count

  	for i in (1..n-1)
  		row = @lines[i].chop.split("\t")
  		@book = Book.new(
  			name: row[0],
  			isbn: row[9],
  			barcode: row[10],
  			author_1: row[1],
  			author_2: row[2],
  			publisher: row[4],
  			series: row[5],
  			volume: row[6],
  			price: row[11]
  			)
  		@book.save
  		@categories = []
  		@categories << row[7].split.first
  		@categories << row[8]

  		@categories.each do |x|
          a = Category.find_by(name: x)
          a.books << @book
        end
  	
  	end

  	
  	return @lines


  end


end
