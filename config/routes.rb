Rails.application.routes.draw do
  root to: "blogs#index"

  resources :blogs do
    resources :posts
  end

  resources :sessions, only: [:new, :create, :destroy] do
    delete 'current', action: :destroy, on: :collection
  end
  resources :users, except: [:index]
end
