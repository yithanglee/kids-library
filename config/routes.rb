Rails.application.routes.draw do

  resources :books do
    collection do
      get 'search'
      get 'quick_loan'
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

  root 'staticpages#home'
  post 'staticpages/print_book_barcodes'
  get 'staticpages/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
