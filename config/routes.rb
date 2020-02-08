Rails.application.routes.draw do
  root to: "posts#index"

  resources :posts

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, except: [:index]
end
