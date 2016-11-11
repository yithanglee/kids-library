Rails.application.routes.draw do

  resources :books
  resources :categories

  resources :publishers 
  resources :authors 
  

  root 'staticpages#home'
  post '/quick_create' => 'staticpages#quick_create'
  get 'staticpages/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
