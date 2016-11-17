class Loan < ApplicationRecord
	belongs_to :book
	belongs_to :user
	
	after_initialize :set_loan_dates


	private

	def set_loan_dates
		a = Time.zone.today

		self.update(loan_date: a, return_date: a+7)
		
	end
end
