Rails.application.routes.draw do
  root to: "blogs#index"

  shallow do
    resources :blogs do
      resources :posts
    end
  end

  resources :sessions, only: [:new, :create, :destroy] do
    delete 'current', action: :destroy, on: :collection
  end
  resources :users, except: [:index]

  # Catch non-existent routes and render Vue app.
  get '*path', :to => 'application#render_application'
end
