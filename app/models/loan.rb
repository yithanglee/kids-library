class Loan < ApplicationRecord
	belongs_to :book
	belongs_to :user
	
	after_initialize :set_loan_dates
	after_create :delete_empty

	private

	def set_loan_dates
		a = Time.zone.today

		self.update(loan_date: a, return_date: a+7)
	end

	def delete_empty
		if self.book_id  == nil
		self.destroy
		end
	end
end
