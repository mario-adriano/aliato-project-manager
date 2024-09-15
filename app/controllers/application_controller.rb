class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_root_path
    elsif resource.operator?
      admin_operators_root_path
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :type, :password, :password_confirmation ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :password, :password_confirmation, :current_password ])
  end

  def redirect_to_reset_password
    redirect_to admin_operators_reset_password_index_path if current_user.requires_reset_password?
  end
end
