Rails.application.routes.draw do

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
  get '/users/:id', to: 'users#show', as: 'user'

  get "/users/:id/edit", to: 'users#edit', as: 'user_edit'
  patch "/users/:id", to: 'users#update', as: 'user_update'


  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get '/search', to: 'books#search'

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
