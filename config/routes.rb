Rails.application.routes.draw do

  post '/books/quick_create', to: 'books#quick_create', as: 'quick_create_book'

	post '/authors/quick_create', to: 'authors#quick_create', as: 'quick_create'

  resources :loans
  resources :books
  resources :categories

  resources :publishers 
  resources :authors 

  match '/search', to: "staticpages#search", via: 'post'

  root 'staticpages#home'

  get 'staticpages/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
