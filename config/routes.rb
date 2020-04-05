Rails.application.routes.draw do
  scope '/api', format: false, defaults: { format: 'json' } do
    constraints lambda { |req| req.format == :json } do # TODO: Does the above line now render this one redundant?
      resources :workspaces, constraints: { id: /(?:[a-z0-9][._-]?)*[a-z0-9]/i } do
        resources :content_types do
          resources :content_entries
        end
      end

      resources :sessions, only: [:new, :create, :destroy] do
        delete 'current', action: :destroy, on: :collection
      end
      resources :users, except: [:index]

      # Pretty Routes
      scope as: 'pretty' do
        resources :workspaces, path: '', constraints: { id: /(?:[a-z0-9][._-]?)*[a-z0-9]/i }, only: [:show] do
          resources :content_types, path: '', only: [] do
            resources :content_entries, path: '', only: [:index, :show]
          end
        end
      end
    end
  end

  scope format: false, defaults: { format: 'html' } do
    constraints lambda { |req| req.format == :html } do # TODO: Does the above line now render this one redundant?
      # Catch all requests and render Vue app.
      root to: 'application#render_application'
      get '*path', to: 'application#render_application'
    end
  end
end
