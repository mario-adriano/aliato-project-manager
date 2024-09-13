class HomeController < ApplicationController
  before_action :check_for_existing_users, only: :index
  before_action :redirect_to_reset_password

  def index
    if current_user.admin?
      redirect_to admin_root_path
    elsif current_user.operator?
      redirect_to admin_operators_root_path
    else
      redirect_to new_user_session_path
    end
  end

  private

  def check_for_existing_users
    redirect_to new_user_registration_path if User.count == 0
  end
end
