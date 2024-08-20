class ResetPasswordController < ApplicationController
  before_action :set_user, only: [:update, :index]

  def index
  end

  def update
    @user.is_reset_password = false

    if @user.update(password_reset_params)
      redirect_to root_path, flash: { success:  'Senha do operador atualizado com sucesso.' }
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('errors', partial: 'layouts/errors', locals: { resource: @user })
          ]
        end
        format.html { render :reset_password }
      end
    end
  end

  private

  # Retrieves the password reset parameters from the request parameters.
  #
  # @return [ActionController::Parameters] The permitted password reset parameters.
  def password_reset_params
    params.require(:operator).permit(:password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end
end
