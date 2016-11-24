Rails.application.routes.draw do

  resources :users
  
  get '/search', to: 'books#search'

  post '/books/quick_create', to: 'books#quick_create', as: 'quick_create_book'


  resources :loans
  resources :books
  resources :categories

  resources :publishers 


  match '/search', to: "staticpages#search", via: 'post'

  root 'staticpages#home'

  get 'staticpages/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
