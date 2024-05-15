class OperatorsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin_authorization
  before_action :set_user, only: [:edit, :update, :reset_password, :update_password, :destroy]

  def index
    @users = User.where.not(type: 'Admin').all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to operators_path, flash: { success: 'Operador criado com sucesso.' }
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('errors', partial: 'layouts/errors', locals: { resource: @user })
          ]
        end
        format.html { render :new }
      end
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to operators_path, flash: { danger: 'Nome de usuário já existe' }
  end

  def edit
  end

  def update
    if @user.update(user_edit_params)
      redirect_to operators_path, flash: { success: 'Operador atualizado com sucesso.' }
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('errors', partial: 'layouts/errors', locals: { resource: @user })
          ]
        end
        format.html { render :edit }
      end
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to operators_path, flash: { danger: 'Nome de usuário já existe' }
  end

  def reset_password
  end

  def update_password
    @user.is_reset_password = true

    if @user.update(user_password_reset_params)
      redirect_to operators_path, flash: { success:  'Senha do operador atualizado com sucesso.' }
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

  def destroy
    if @user.destroy
      redirect_to operators_path, flash: { success:  'Operador deletado com sucesso.' }
    else
      redirect_to operators_path, flash: { danger: 'Não é possível deletar Operador' }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end

  def user_edit_params
    params.require(:operator).permit(:name, :username)
  end

  def user_password_reset_params
    params.require(:operator).permit(:password, :password_confirmation)
  end
end
