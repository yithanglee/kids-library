class BookCategory < ApplicationRecord
	belongs_to :books
	belongs_to :categories
end
