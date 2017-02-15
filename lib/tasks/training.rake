namespace :training do
  desc "TODO"
  task user_loan: :environment do
  	Loan.destroy_all

  	User.where(member_id: '').update(member_id:'Pending')
  	a =	User.where(member_id: 'Pending')
  	a.destroy_all

  	b = User.find_by(chinese_name:'陈洛菲')
	  	for i in 1..2
			c = Loan.new
	  	c.user = b
	  	d = Book.find(rand(Book.first.id...Book.last.id))
	  	c.book = d
	  	c.save
	  	end

  	e = User.find_by(chinese_name: '王晓玲')
	  	for i in 1..5
			c = Loan.new
	  	c.user = e
	  	d = Book.find(rand(Book.first.id...Book.last.id))
	  	c.book = d
	  	c.save
	  	end

  	f = User.find_by(name: 'SHARON TAN SIEW WEE')
	  	for i in 1..2
			c = Loan.new
	  	c.user = f
	  	d = Book.find(rand(Book.first.id...Book.last.id))
	  	c.book = d
	  	c.save
	  	end	
	  g = f.loans.first
	  h = f.loans.last

	  g.update(loan_date: (g.loan_date-21.days))
	  g.update(return_date: (g.return_date-21.days))

	  h.update(loan_date: (h.loan_date-21.days))
	  h.update(return_date: (h.return_date-21.days))

	  	c = Loan.new
	  	c.user = b
	  	d = Book.find_by(name:'耶稣的爱')
	  	c.book = d
	  	c.save

  end

end
