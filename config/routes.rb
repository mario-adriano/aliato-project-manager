Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  mount PgHero::Engine, at: "pghero" if Rails.env.development?

  # if defined? Debugbar
  #   mount Debugbar::Engine => Debugbar.config.prefix
  # end

  resources :operators, only: [ :index, :new, :create, :edit, :update, :destroy ]
  get "operators/:id/reset_password", to: "operators#reset_password", as: :reset_password_operator
  patch "operators/:id/update_password", to: "operators#update_password", as: :update_password_operator

  resources :phases, only: [] do
    resource :positions, only: [ :update ], module: :phases
  end

  resources :phases do
    put :update_order_phases, on: :collection
  end
  patch "phases/:id/set_as_ending_phase", to: "phases#set_as_ending_phase", as: :set_as_ending_phase
  patch "phases/:id/refresh_phase", to: "phases#refresh_phase", as: :refresh_phase

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

  # get 'home/index'

  # get "up" => "rails/health#show", as: :rails_health_check
end
