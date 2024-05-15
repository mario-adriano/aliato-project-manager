class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :type, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :password, :password_confirmation, :current_password])
  end

  def redirect_to_reset_password
    redirect_to reset_password_index_path if current_user.requires_reset_password?
  end

  def ensure_admin_authorization
    redirect_to root_path unless current_user.admin?
  end

  def ensure_operator_authorization
    redirect_to root_path unless current_user.operator?
  end
end
