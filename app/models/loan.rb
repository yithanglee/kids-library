class Loan < ApplicationRecord
	belongs_to :book
	belongs_to :user
	

	after_create :delete_empty

	validates :book, uniqueness: {}

	private

	

	def delete_empty
		if self.book_id == nil or self.user_id == nil
		self.destroy
		end
	end



end
