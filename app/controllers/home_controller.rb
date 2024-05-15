class HomeController < ApplicationController
  before_action :check_for_existing_users, only: :index
  before_action :redirect_to_reset_password

  def index
  end

  private

  def check_for_existing_users
    redirect_to new_user_registration_path if User.count == 0
  end
end
