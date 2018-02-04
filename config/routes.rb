Rails.application.routes.draw do
  resources :coins
  resources :user_coins
  resources :users, except: [:new, :show, :index]
  root 'welcome#index'
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  post '/users' => 'users#create'
  post '/search' => 'coins#search'
  match "*path" => "coins#index", via: [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
