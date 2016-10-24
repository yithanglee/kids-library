class Book < ApplicationRecord
  belongs_to :author
  has_many :categories, through: :book_category
end
