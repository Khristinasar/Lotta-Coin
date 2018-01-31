Rails.application.routes.draw do
  root 'sessions#new'

  get '/signup' => 'users#new'
  resources :users, except: [:new]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  post '/users' => 'users#create'

#Frank's routes for the txt message alert
  get '/track' => 'twl#tracker'
  post '/track' => 'twl#tracker'

  resources :coins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
