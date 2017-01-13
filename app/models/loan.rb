class Loan < ApplicationRecord
	belongs_to :book
	belongs_to :user
	

	after_create :delete_empty, :assign_dates, :record_history
	validates :book, uniqueness: {}
	validates :user, presence: true

	def return_date_extend
		if self.is_extended == false
		a = self.return_date
		self.update(return_date: a+14 , is_extended: true)
		else
			# errors.add(:is_extended, "This loan already extended") 
			self.errors.messages[:is_extended] = "This loan is extended."
		end
	end

	private

	def delete_empty
		if self.book_id == nil or self.user_id == nil
		self.destroy
		end
	end

	def assign_dates
		if self.return_date == nil
	  a = Time.zone.today
		self.update(loan_date: a, return_date: a+14) 
		end
	end

end
