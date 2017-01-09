Rails.application.routes.draw do

  resources :books do
    collection do
      get 'search'
      get 'quick_loan'
      get 'list_by_category'
    end
  end
  
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  resources :users
  

  post '/books/quick_create', to: 'books#quick_create', as: 'quick_create_book'


  resources :loans

  resources :categories

  resources :publishers 


  match '/search', to: "staticpages#search", via: 'post'
  match '/staticpages/print_book_barcodes', to: "staticpages#print_book_barcodes", via: 'post', as: 'print_barcode'
  match '/staticpages/print_book_barcodes', to: "staticpages#print_book_barcodes", via: 'get'
  match '/staticpages/print_member_cards', to: "staticpages#print_member_cards", via: 'post', as: 'print_member'
  match '/staticpages/print_member_cards', to: "staticpages#print_member_cards", via: 'get'
  root 'staticpages#home'

  get 'staticpages/help' => 'staticpages#help', as: 'help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
