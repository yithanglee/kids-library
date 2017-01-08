class Book < ApplicationRecord

  has_and_belongs_to_many :categories


  has_many :users, through: :loans
  has_many :loans, dependent: :destroy

  validates :name, uniqueness: true


def self.quick_search(search)

  if !search[:term].empty?
  	find_by(isbn: search[:term])
  else
    
  end
end

def self.search(search)

  if !search[:book_name].empty?
    where("name like ?", "%#{search[:book_name]}%")
  elsif !search[:author].empty?
    where(author_1: search[:author])      
  else
    
  end
end

end
