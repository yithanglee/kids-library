class Book < ApplicationRecord

  has_and_belongs_to_many :categories


  has_many :users, through: :loans
  has_many :loans, dependent: :destroy


 searchkick match: :word_start, searchable: [:title, :barcode]


end
