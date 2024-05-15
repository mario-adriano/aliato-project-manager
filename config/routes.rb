Rails.application.routes.draw do
  # get 'operators/index'
  # get 'operators/edit'
  # get 'operators/new'
  devise_for :users
  root to: 'home#index'

  resources :operators, only: [:index, :new, :create, :edit, :update, :destroy]
  get 'operators/:id/reset_password', to: 'operators#reset_password', as: :reset_password_operator
  patch 'operators/:id/update_password', to: 'operators#update_password', as: :update_password_operator

  resources :phases, only: [] do
    resource :positions, only: [:update], module: :phases
  end

  resources :phases do
    put :update_order_phases, on: :collection
  end
  patch 'phases/:id/set_as_ending_phase', to: 'phases#set_as_ending_phase', as: :set_as_ending_phase

  resources :reset_password, only: [:index, :update]

  resources :individuals

  resources :companies

  # get 'home/index'

  # get "up" => "rails/health#show", as: :rails_health_check
end
