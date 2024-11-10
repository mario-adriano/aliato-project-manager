Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  get "/up", to: proc { [ 200, {}, [ "OK" ] ] }

  if Rails.env.development?
    mount PgHero::Engine, at: "pghero"

    # if defined? Debugbar
    #   mount Debugbar::Engine => Debugbar.config.prefix
    # end
  end

  namespace :admin_operators do
    resources :daily_reports, only: [] do
      get "access/:token", to: "daily_reports#show_by_token", as: "access", on: :collection
    end
    patch "daily_reports/update_by_token/:token", to: "daily_reports#update_by_token", as: "daily_report_update_by_token"
  end

  authenticate :user, ->(user) { user.admin? } do
    draw :admin
  end

  authenticate :user, ->(user) { user.operator? } do
    draw :admin_operators
  end
end
