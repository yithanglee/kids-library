json.extract! loan, :id, :loan_date, :return_date, :book_id, :user_id, :created_at, :updated_at
json.url loan_url(loan, format: :json)