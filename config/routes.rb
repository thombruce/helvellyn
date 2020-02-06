Rails.application.routes.draw do
  root to: "users#show"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, except: [:index]
end
