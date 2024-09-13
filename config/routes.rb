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
    draw :admin
  end

  authenticate :user, ->(user) { user.operator? } do
    draw :admin_operators
  end
end
