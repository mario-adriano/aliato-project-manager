namespace :admin_operators do
  root to: "home#index"

  get "operators/:id/reset_password", to: "operators#reset_password", as: :reset_password_operator
  patch "operators/:id/update_password", to: "operators#update_password", as: :update_password_operator

  resources :reset_password, only: [ :index, :update ]

  resources :individuals, except: [ :show ]

  resources :companies, except: [ :show ]

  resources :projects, except: [ :destroy, :show ] do
    patch :update_phase

    resources :project_files, only: [] do
      member do
        get "download", to: "projects#download_file"
      end
    end
  end
end
