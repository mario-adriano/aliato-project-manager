module AdminOperators
  class ResetPasswordController < ApplicationController
    before_action :set_user, only: [ :update, :index ]

    def index
    end

    def update
      if params[:operator][:current_password].present?
        if @user.valid_password?(params[:operator][:current_password])
          update_password
        else
          @user.errors.add(:current_password, "está incorreta")
          render_errors
        end
      else
        update_password if current_user.is_reset_password
      end
    end

    private

    def update_password
      @user.is_reset_password = false

      if @user.update(password_reset_params.except(:current_password))
        redirect_to admin_operators_root_path, flash: { success: "Senha do operador atualizada com sucesso." }
      else
        render_errors
      end
    end

    def render_errors
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("errors", partial: "layouts/errors", locals: { resource: @user })
          ]
        end
        format.html { render :reset_password }
      end
    end

    # Retrieves the password reset parameters from the request parameters.
    #
    # @return [ActionController::Parameters] The permitted password reset parameters.
    def password_reset_params
      params.require(:operator).permit(:password, :password_confirmation, :current_password)
    end

    def set_user
      @user = current_user
    end
  end
end
