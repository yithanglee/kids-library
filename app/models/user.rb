class User < ApplicationRecord
  include Clearance::User

has_many :books, through: :loans
has_many :loans, dependent: :destroy

validates :member_id, uniqueness: :true, unless: :is_pending?
validates :ic, presence: :true, format: { with: /\d{6}\-\d{2}\-\d{4}/,
    message: "Invalid IC format" }


after_create :capitalize_name, :fill_up_birthday, :fill_up_gender

	def is_pending?
		self.member_id == 'Pending'
	end

	def member_id_pending
		self.update(member_id: 'Pending')
	end

	def read_count
		self.loans.all.count
	end

	def self.search(params)
		where("name like ? or email like ? or chinese_name like ? or phone like ? or ic like ? or member_id like ?", "%#{params[:search_term].upcase}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%", "%#{params[:search_term]}%")
	end

	def capitalize_name
		self.update(name: name.upcase )
		if self.member_id == nil
		self.update(member_id: 'Pending')
		end
		return
	end

	def full_address
		self.line1 + self.line2 + " " + self.postcode + " " + self.city + " " + self.state
	end

  def email_optional?
    true
  end

  def fill_up_birthday
				a = self	
			  		unless a.ic.empty?
			  			b = a.ic[0...6].scan(/../)
							if b[0] > "17"
								b[0] = "19" + b[0]
							else 
								b[0] = "20" + b[0]
							end
							year = b[0]
							month = b[1]
							day = b[2]
							unless day > "31"
							a.update(birthday: Date.new(year.to_i, month.to_i, day.to_i))
							end
						end
  end

  def fill_up_gender
  	a = self
  		unless a.ic.empty?
  			b = a.ic
  			if b[13].to_i.odd?
  			a.update(gender: 'Male')
  			else
  			a.update(gender: 'Female')
  			end 
  		end
  end

	def is_admin?
		if self.user_type == 'admin'
			return true
		else
			return false
		end
	end


end
