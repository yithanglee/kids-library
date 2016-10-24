json.extract! book_category, :id, :book_id, :category_id, :created_at, :updated_at
json.url book_category_url(book_category, format: :json)