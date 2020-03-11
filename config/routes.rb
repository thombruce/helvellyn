Rails.application.routes.draw do
  constraints lambda { |req| req.format == :html } do
    # Catch all requests and render Vue app.
    root to: 'application#render_application'
    get '*path', to: 'application#render_application'
  end

  constraints lambda { |req| req.format == :json } do
    resources :workspaces do
      resources :content_types do
        resources :content_entries
      end
      resources :posts
    end

    resources :sessions, only: [:new, :create, :destroy] do
      delete 'current', action: :destroy, on: :collection
    end
    resources :users, except: [:index]

    # Pretty Routes
    resources :workspaces, path: '', only: [:show] do
      resources :content_types, path: '', only: [] do
        resources :content_entries, path: '', only: [:index, :show]
      end
    end
  end
end
