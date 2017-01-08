class StaticpagesController < ApplicationController

  def home    

    # @paragraph = {}
    # @lines = []
    # # need to do a migration using this page, will open a file from the root, then tries to import it, never tried a chinese file before, but will attempt to.
    # File.open("20170108.csv", "r:UTF-8").each do |line|
    #   @lines << line
    # end
    # n = @lines.count

    # for i in (1..n-1)
    #   row = @lines[i].chop.split("\t")
    #   @book = Book.new(
    #     name: row[0],
    #     isbn: row[7],
    #     barcode: row[8],
    #     author_1: row[1],
    #     author_2: row[2],
    #     publisher: row[3],
    #     series: row[4],
    #     volume: row[5],
    #     price: row[9]
    #     )
    #   @book.save

    # end


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
    @paragraph = {}
    @lines = []
    # need to do a migration using this page, will open a file from the root, then tries to import it, never tried a chinese file before, but will attempt to.
    File.open("20170108.csv", "r:UTF-8").each do |line|
      @lines << line
    end
    # n = @lines.count

    # for i in (1..n-1)
    #   row = @lines[i].chop.split("\t")
    #   @book = Book.new(
    #     name: row[0],
    #     isbn: row[9],
    #     barcode: row[10],
    #     author_1: row[1],
    #     author_2: row[2],
    #     publisher: row[4],
    #     series: row[5],
    #     volume: row[6],
    #     price: row[11]
    #     )
    #   @book.save
    #   @categories = []
    #   @categories << row[7].split.first
    #   @categories << row[8]

    #   @categories.each do |x|
    #       a = Category.find_by(name: x)
    #       a.books << @book
    #     end
    
    # end
    return @lines
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
