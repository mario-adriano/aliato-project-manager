namespace :admin do
  root to: "home#index"

  resources :operators, only: [ :index, :new, :create, :edit, :update, :destroy ]

  resources :reset_password, only: [ :index, :update ]

  resources :phases do
    put :update_order_phases, on: :collection
  end
  patch "phases/:id/set_as_ending_phase", to: "phases#set_as_ending_phase", as: :set_as_ending_phase
  patch "phases/:id/refresh_phase", to: "phases#refresh_phase", as: :refresh_phase
end
