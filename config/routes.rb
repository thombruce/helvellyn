Rails.application.routes.draw do
  root to: "posts#index"

  resources :posts
  resources :blogs

  resources :sessions, only: [:new, :create, :destroy] do
    delete 'current', action: :destroy, on: :collection
  end
  resources :users, except: [:index]
end
