module Admin
  class ResetPasswordController < ApplicationController
    before_action :set_user, only: [ :update, :index ]

    def index
    end

    def update
      if @user.valid_password?(params[:administrator][:current_password])
        update_password
      else
        @user.errors.add(:current_password, "está incorreta")
        render_errors
      end
    end

    private

    def update_password
      if @user.update(password_reset_params.except(:current_password))
        redirect_to admin_root_path, flash: { success: "Senha do administrador atualizada com sucesso." }
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
      params.require(:administrator).permit(:password, :password_confirmation, :current_password)
    end

    def set_user
      @user = current_user
    end
  end
end
