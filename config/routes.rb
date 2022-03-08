Rails.application.routes.draw do
  get 'pictures/new'
  get 'pictures/show'
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users
  resources :pictures, only: [:new, :create, :show]
end