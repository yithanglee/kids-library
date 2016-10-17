Rails.application.routes.draw do


  resources :publishers do
  	  resources :authors do
    resources :books
  end
  end
  get 'user/new'

  get 'user/create'

  root 'staticpages#home'

  get 'staticpages/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
