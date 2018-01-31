Rails.application.routes.draw do
  get 'coins_users/index'

  root 'welcome#index'

  get '/signup' => 'users#new'
  resources :users, except: [:new]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  post '/users' => 'users#create'

  resources :coins
  resources :user_coins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
