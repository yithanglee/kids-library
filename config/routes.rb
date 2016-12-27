Rails.application.routes.draw do

  resources :users
  

  post '/books/quick_create', to: 'books#quick_create', as: 'quick_create_book'


  resources :loans

  resources :books do
    collection do
      get 'search'
      get 'quick_loan'
    end
  end
  resources :categories

  resources :publishers 


  match '/search', to: "staticpages#search", via: 'post'

  root 'staticpages#home'

  get 'staticpages/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
