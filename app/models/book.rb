class Book < ApplicationRecord

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :authors
end
