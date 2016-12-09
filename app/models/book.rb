class Book < ApplicationRecord

  has_and_belongs_to_many :categories


  has_many :users, through: :loans
  has_many :loans, dependent: :destroy



def self.search(search)
  if search
  	find_by(isbn: search)
  else
    
  end
end



end
