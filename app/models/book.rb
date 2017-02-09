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


  def self.super_search(params)
    where("isbn like ? or barcode like ? ", "%#{params[:book]}%", "%#{params[:book]}%")
  end

  def self.search(search)

  # case
  #   when search[:book_name] != ''
  #     where("name like ?", "%#{search[:book_name]}%")
  #   when search[:author] != ''
  #     where("author_1 like ?", "%#{search[:author]}%")
  #   when search[:barcode] != ''
  #     where("barcode like ?", "%#{search[:barcode]}%")
  #   when (search[:book_name] != '' and search[:author] != '')
  #     where("name like ? and author_1 like ?", "%#{search[:book_name]}%", "%#{search[:author]}%")
  # end

    if search[:book_name] != ''
      if search[:author] != ''
        where("name like ? and author_1 like ?", "%#{search[:book_name]}%", "%#{search[:author]}%")
      else
        where("name like ?", "%#{search[:book_name]}%")
      end
    elsif search[:author] != ''
      if search[:barcode] != ''
        where("author_1 like ? and barcode like ?", "%#{search[:author]}%", "%#{search[:barcode]}%")
      else
        where("author_1 like ?", "%#{search[:author]}%")
      end

    elsif search[:barcode] != ''
      if search[:book_name] != ''
        where("barcode like ? and name like ?", "%#{search[:barcode]}%", "%#{search[:book_name]}%")
      else
        where("barcode like ?", "%#{search[:barcode]}%")
      end
      
      
    end


  end

end
