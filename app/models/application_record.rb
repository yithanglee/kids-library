class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


	def record_history
		puts "this is recorded!"
	end

end
