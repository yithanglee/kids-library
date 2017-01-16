class Loan < ApplicationRecord
	belongs_to :book
	belongs_to :user
	
	before_create :book_physically_available
	after_create :delete_empty, :assign_dates, :record_history
	validates :user, presence: true


	def book_physically_available
		if Loan.where(book_id: self.book.id).last.has_returned == true or Loan.where(book_id: self.book.id) == nil
		else
			self.errors.messages[:has_returned] = "This book isn't returned yet."
		end
		
	end

	def return_date_extend
		if self.is_extended == false
		a = self.return_date
		self.update(return_date: a+14 , is_extended: true)
		else
			# errors.add(:is_extended, "This loan already extended") 
			self.errors.messages[:is_extended] = "This loan is extended."
		end
	end

	def book_return
		if self.has_returned == false
			self.update(has_returned: true, actual_return_date: Time.zone.today)
		end
		
	end

	def returned?
		self.has_returned == true
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
