class RegistrationsController < Devise::RegistrationsController
  before_action :check_for_existing_users

  private

  def check_for_existing_users
    redirect_to new_user_registration_path if User.count == 0
  end
end
