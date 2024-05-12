class HomeController < ApplicationController
  before_action :check_for_existing_users, only: :index

  def index
  end

  private

  def check_for_existing_users
    redirect_to new_user_registration_path if User.count == 0
  end
end
