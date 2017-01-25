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
		require'csv'

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
		@unsaved = []
		@saved = []
		if (header - validate).empty?
		
		file = "#{Rails.root}/public/data.csv"
		CSV.open( file, 'w' ) do |writer|
			writer << validate
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
					@book_saved += 1
					@saved << @book
				else
					@book_not_save +=1
					@unsaved << @book
					writer << [@book.name, @book.author_1, @book.author_2, @book.publisher, @book.series, @book.volume, @book.isbn, @book.barcode, @book.price]
				end

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
		render pdf: "print_book_barcodes", :page_width => '16.54in', :page_height => '23.38in'
	  end
	end
# pdf = WickedPdf.new.pdf_from_html_file('/staticpages/print_book_barcodes')

end

def import_members
		require'csv'

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
		validate = ["MEMBER ID", "ENGLISH NAME", "CHINESE NAME", "MEMBER IC", "EMAIL", "MOBILE", "MAILING ADDRESS", "ADDRESS2", "CITY", "STATE", "ZIP_POSTAL", "TYPE"]
		@member_saved = 0
		@member_not_save = 0
		@unsaved = []
		@saved = []
		if (header - validate).empty?
		
		file = "#{Rails.root}/public/data.csv"
		CSV.open( file, 'w' ) do |writer|
			writer << validate
			for i in (1..n-1)
			row = @lines[i].chop.split("\t")
				@member = User.new(
				member_id: row[0],
				name: row[1],
				chinese_name: row[2],
				ic: row[3],
				email: row[4],
				phone: row[5],
				line1: row[6],
				line2: row[7],
				city: row[8],
				state: row[9],
				postcode: row[10],
				password: "123"
				)
			
				if @member.save
					@member_saved += 1
					@saved << @member
				else
					@member_not_save +=1
					@unsaved << @member
					writer << [
						@member.member_id, 
						@member.name,
						@member.chinese_name,
						@member.ic,
						@member.email,
						@member.phone,
						@member.line1,
						@member.line2,
						@member.city,
						@member.state,
						@member.postcode
					]
				end

			end
		

		end	

		else
			return "file doesnt have the right header."
		end

	end

def print_member_cards
	# encoding: utf-8
	require 'barby'
	require 'barby/barcode/code_128'
	require 'barby/outputter/html_outputter'
	if params[:q]
	@a = params[:q].split()
	end  
	respond_to do |format|
	  format.html
	  format.pdf do
		render pdf: "print_member_cards", :page_width => '16.54in', :page_height => '23.38in', :encoding => 'UTF-8', print_media_type: true 
	  end
	end
end

end
