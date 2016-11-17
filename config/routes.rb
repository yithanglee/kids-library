Rails.application.routes.draw do

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
