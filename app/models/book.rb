class Book < ApplicationRecord

  has_and_belongs_to_many :categories


  has_many :users, through: :loans
  has_many :loans, dependent: :destroy

  validates :name, uniqueness: true

  after_create :categorize
  after_update :categorize_update

def categorize

  if self.barcode != nil
    case self.barcode[0]
    when "E"
      self.categories << Category.find_by(name:'English')
    when "P"
      self.categories << Category.find_by(name:'Picture')
    when "R"
      self.categories << Category.find_by(name:'Religion')
    when "T"
      self.categories << Category.find_by(name:'Teaching')
    when "O"
      self.categories << Category.find_by(name:'Other')
    end
  end

end

def categorize_update
  old_categories = self.categories.all
  old_categories.each do |x|
    x.books.destroy(self)
  end
  case self.barcode[0]
  when "E"
    self.categories << Category.find_by(name:'English')
  when "P"
    self.categories << Category.find_by(name:'Picture')
  when "R"
    self.categories << Category.find_by(name:'Religion')
  when "T"
    self.categories << Category.find_by(name:'Teaching')
  when "O"
    self.categories << Category.find_by(name:'Other')           
  end
end

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
