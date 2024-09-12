Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  if Rails.env.development?
    mount PgHero::Engine, at: "pghero"

    # if defined? Debugbar
    #   mount Debugbar::Engine => Debugbar.config.prefix
    # end
  end

  authenticate :user, ->(user) { user.admin? } do
    namespace :admin do
      resources :operators, only: [ :index, :new, :create, :edit, :update, :destroy ]

      resources :phases, only: [] do
        resource :positions, only: [ :update ], module: :phases
      end

      resources :phases do
        put :update_order_phases, on: :collection
      end
      patch "phases/:id/set_as_ending_phase", to: "phases#set_as_ending_phase", as: :set_as_ending_phase
      patch "phases/:id/refresh_phase", to: "phases#refresh_phase", as: :refresh_phase
    end
  end

  authenticate :user, ->(user) { user.operator? } do
    namespace :admin_operators do
      get "operators/:id/reset_password", to: "operators#reset_password", as: :reset_password_operator
      patch "operators/:id/update_password", to: "operators#update_password", as: :update_password_operator

      resources :reset_password, only: [ :index, :update ]

      resources :individuals

      resources :companies

      resources :projects do
        patch :update_phase

        resources :project_files, only: [] do
          member do
            get "download", to: "projects#download_file"
          end
        end
      end
    end
  end
end
