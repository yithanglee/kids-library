class User < ApplicationRecord
  include Clearance::User



has_many :books, through: :loans
has_many :loans
	
end
