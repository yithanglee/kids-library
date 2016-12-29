class User < ApplicationRecord
  include Clearance::User



has_many :books, through: :loans
has_many :loans

	def is_admin?
		if self.user_type == 'admin'
			return true
		else
			return false
		end
	end
	
end
