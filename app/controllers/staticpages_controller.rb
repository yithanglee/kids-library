class StaticpagesController < ApplicationController

  def home    

  end

  def help
	respond_to do |format|
	  format.html
	  format.pdf do
		render pdf: "help"   # Excluding ".pdf" extension.
	  end
	end
  end

	def import_books

		uploaded_io = params[:upload_file]
		File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
			file.write(uploaded_io.read)
		end

		@paragraph = {}
		@lines = []
		# need to do a migration using this page, will open a file from the root, then tries to import it, never tried a chinese file before, but will attempt to.
		File.open(Rails.root + "public/uploads/" + "#{uploaded_io.original_filename}", "r:UTF-8").each do |line|
			@lines << line
		end

		n = @lines.count
				
		header = @lines[0].chop.split("\t")
		validate = ["TITLE", "AUTHOR", "COAUTHORS", "PUBLISHER", "SERIES", "VOLUME", "EDITION", "ISBN", "BARCODE", "PRICE"]
		@book_saved = 0
		@book_not_save = 0
		if (header - validate).empty?
			
			for i in (1..n-1)
			row = @lines[i].chop.split("\t")
				@book = Book.new(
				name: row[0],
				author_1: row[1],
				author_2: row[2],
				publisher: row[3],
				series: row[4],
				volume: row[5],
				isbn: row[7],
				barcode: row[8],
				price: row[9]
				)
			
				if @book.save
					@book_save += 1
				else
					@book_not_save +=1
				end

			end
		
		else
			return "file doesnt have the right header."
		end

	end

def print_book_barcodes
	require 'barby'
	require 'barby/barcode/code_128'
	require 'barby/outputter/html_outputter'
	if params[:q]
	@a = params[:q].split()
	end
	respond_to do |format|
	  format.html
	  format.pdf do
		render pdf: "print_book_barcodes"   # Excluding ".pdf" extension.
	  end
	end
# pdf = WickedPdf.new.pdf_from_html_file('/staticpages/print_book_barcodes')

end

def print_member_cards
	require 'barby'
	require 'barby/barcode/code_128'
	require 'barby/outputter/html_outputter'
	if params[:q]
	@a = params[:q].split()
	end  
	respond_to do |format|
	  format.html
	  format.pdf do
		render pdf: "print_member_cards", :page_width => '16.54in', :page_height => '23.38in'
	  end
	end
end

end
