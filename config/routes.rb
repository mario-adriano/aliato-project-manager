Rails.application.routes.draw do
  # get 'operators/index'
  # get 'operators/edit'
  # get 'operators/new'
  resources :operators, only: [:index, :new, :create, :edit, :update]
  get 'operators/:id/reset_password', to: 'operators#reset_password', as: :reset_password_operator
  patch 'operators/:id/update_password', to: 'operators#update_password', as: :update_password_operator
  # get 'home/index'
  devise_for :users

  root to: 'home#index'
  # get "up" => "rails/health#show", as: :rails_health_check
end
