class Loan < ApplicationRecord
	belongs_to :book
	belongs_to :user
	

	after_create :delete_empty, :assign_dates, :record_history
	validates :book, uniqueness: {}
	validates :user, presence: true


	private

	def delete_empty
		if self.book_id == nil or self.user_id == nil
		self.destroy
		end
	end

	def assign_dates
		if self.return_date == nil
	  a = Time.zone.today
		self.update(loan_date: a, return_date: a+7) 
		end
	end

end
