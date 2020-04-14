Rails.application.routes.draw do
  # /admin/**/*.json Admin::
  scope '/admin', module: 'admin', format: false, defaults: { format: 'json' } do
    # /admin/settings.json
    resource :settings, except: [:new, :create, :destroy]
    # /admin/workspaces/*.json
    resources :workspaces, constraints: { id: /(?:[a-z0-9][._-]?)*[a-z0-9]/i } do
      # /admin/workspaces/:workspace_id/users/*.json
      resources :users
      # /admin/workspaces/:workspace_id/templates/*.json
      resources :templates do
        # /admin/workspaces/:workspace_id/templates/:template_id/entities/*.json
        resources :entities
      end
    end
  end

  # /auth/**/*.json Authentication::
  scope '/auth', module: 'authentication', format: false, defaults: { format: 'json' } do
    # /auth/login.json
    post 'login', to: 'sessions#create'
    # /auth/signup.json
    post 'signup', to: 'users#create'
    # /auth/signout.json
    delete 'signout', to: 'sessions#destroy'

    # /auth/account/**/*.json
    scope '/account' do
      # /auth/account/sessions/*.json
      resources :sessions, except: [:new, :create, :edit, :update]
      # /auth/account/*.json
      resource :user, path: '', except: [:new, :create]
    end
  end

  # Pretty Routes
  # /api/**/*.json
  scope '/api', module: 'api', as: 'pretty', format: false, defaults: { format: 'json' } do
    # /api/:worspace_id/*.json
    resources :workspaces, path: '', constraints: { id: /(?:[a-z0-9][._-]?)*[a-z0-9]/i }, only: [:show] do
      resources :templates, path: '', only: [] do
        member do
          # /api/:worspace_id/:template_id/template.json
          get 'template', to: 'templates#show'
        end

        # /api/:worspace_id/:template_id/*.json
        resources :entities, path: '', only: [:index, :show]
      end
    end
  end

  scope format: false, defaults: { format: 'html' } do
    # Catch all requests and render Vue app.
    root to: 'application#render_application'
    get '*path', to: 'application#render_application'
  end
end

