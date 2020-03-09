Rails.application.routes.draw do
  constraints lambda { |req| req.format == :html } do
    # Catch all requests and render Vue app.
    root to: 'application#render_application'
    get '*path', to: 'application#render_application'
  end

  constraints lambda { |req| req.format == :json } do
    resources :workspaces do
      resources :content_types
      resources :posts
    end

    resources :sessions, only: [:new, :create, :destroy] do
      delete 'current', action: :destroy, on: :collection
    end
    resources :users, except: [:index]
  end
end
