class Category < ApplicationRecord
	has_many :books, through: :book_category
end
