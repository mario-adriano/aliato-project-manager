class OperatorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :reset_password, :update_password]

  def index
    @users = User.where.not(type: 'Admin').all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to operators_path, notice: 'Operador criado com sucesso.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to operators_path, notice: 'Operador atualizado com sucesso.'
    else
      render :edit
    end
  end

  def reset_password
  end

  def update_password
    if @user.update(user_password_reset_params)
      redirect_to operators_path, notice: 'Senha do operador atualizado com sucesso.'
    else
      render :reset_password
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end

  def user_password_reset_params
    params.require(:operator).permit(:password, :password_confirmation)
  end
end
