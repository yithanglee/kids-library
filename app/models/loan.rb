class Loan < ApplicationRecord
	belongs_to :book
	belongs_to :user
	
	before_create :book_physically_available
	after_create :delete_empty, :assign_dates, :record_history
	validates :user, presence: true


	# calculate how much fine based on working weeks, 
	# need to find out which week was the book returned date. 
	# if 1/14 is the 2nd week, checks todays date is in which week
	# get the difference of the week and calculate the fine.
	def estimate_fine
		cur_week = Time.now.strftime("%U").to_i
		return_week = self.return_date.strftime("%U").to_i
		late = cur_week - return_week
		if late > 0
		fine = late * 0.50
		else
		fine = 0.00
		end
		fine
	end


	def book_physically_available
		if Loan.where(book_id: self.book.id).last == nil or Loan.where(book_id: self.book.id).last.has_returned == true
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
			self.update(has_returned: true, actual_return_date: Time.zone.today, fine_amount: self.estimate_fine)
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
