json.extract! author_book, :id, :name, :category, :isbn, :barcode, :created_at, :updated_at
json.url author_book_url(author_book, format: :json)