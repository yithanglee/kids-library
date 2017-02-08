class User < ApplicationRecord
  include Clearance::User

has_many :books, through: :loans
has_many :loans, dependent: :destroy

validates :member_id, uniqueness: :true 

after_create :capitalize_name

	def read_count
		self.loans.all.count
	end

	def self.search(params)
		where("name like ? or email like ? or chinese_name like ? or phone like ? or ic like ? or member_id like ?", "%#{params[:search_term].upcase}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%")
	end

	def capitalize_name
		self.update(name: name.upcase )
		self.update(member_id: 'Pending')
		return
	end

	def full_address
		self.line1 + self.line2 + " " + self.postcode + " " + self.city + " " + self.state
	end

  def email_optional?
    true
  end

	def is_admin?
		if self.user_type == 'admin'
			return true
		else
			return false
		end
	end


end
