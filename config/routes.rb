Rails.application.routes.draw do
  get 'staticpages/set_new_password/:confirmation_token' => 'staticpages#set_new_password', as: 'set_new_password'
  post 'staticpages/public_password_submit' => 'staticpages#public_password_submit', as: 'public_password_submit'
  get 'staticpages/public_password_reset' => 'staticpages#public_password_reset', as: 'public_password_reset'
  get 'users/:user_id/reset_password' => 'users#reset_password', as: 'reset_password'

  resources :books do
    collection do
      get 'search'
      get 'quick_loan'
      get 'list_by_category'
    end
  end
  

  resource :session, controller: "clearance/sessions", only: [:create]

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  
  resources :users do
    collection do
      get 'search'
    end
  end

  post '/books/quick_create', to: 'books#quick_create', as: 'quick_create_book'

  resources :loans 
  resources :categories
  resources :publishers 
  
  match '/users/:user_id/print_member_info', to: "users#print_member_info", via: 'post', as: 'print_member_info'
  match '/history/loans', to: "loans#history", via: 'get', as: 'loan_history'
  match '/loans/search_book', to: "loans#search_book", via: 'post', as: 'search_book'
  match '/loans/:id/book_return', to: "loans#book_return", via: 'get', as: 'book_return'
  match '/loans/:id/return_date_extend', to: "loans#return_date_extend", via: 'get', as: 'return_date_extend'
  match '/search', to: "staticpages#search", via: 'post'
  match '/staticpages/print_book_barcodes', to: "staticpages#print_book_barcodes", via: 'post', as: 'print_barcode'
  match '/staticpages/print_book_barcodes', to: "staticpages#print_book_barcodes", via: 'get'
  match '/staticpages/print_member_cards', to: "staticpages#print_member_cards", via: 'post', as: 'print_member'
  match '/staticpages/print_member_cards', to: "staticpages#print_member_cards", via: 'get'
  match '/staticpages/import_books', to: "staticpages#import_books", via: 'post', as: 'import_books'  
  match '/staticpages/import_members', to: "staticpages#import_members", via: 'post', as: 'import_members' 
  match '/staticpages/training', to: "staticpages#training", via: 'get', as: 'training' 
  root 'staticpages#home'

  get 'staticpages/help' => 'staticpages#help', as: 'help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
