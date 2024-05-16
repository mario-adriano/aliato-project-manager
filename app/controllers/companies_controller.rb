class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_operator_authorization
  before_action :set_company, only: [:edit, :update, :destroy]

  def index
    if params[:query].present?
      @companies = Company.where("name LIKE ?", "%#{params[:query]}%")
                               .or(Company.where("document_number LIKE ?", "%#{params[:query]}%"))
                               .or(Company.where("company_name LIKE ?", "%#{params[:query]}%"))
    else
      @companies = Company.all
    end
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to companies_path, flash: { success: 'Cliente criado com sucesso.' }
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('errors', partial: 'layouts/errors', locals: { resource: @company })
          ]
        end
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to companies_path, flash: { success: 'Cliente atualizado com sucesso.' }
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('errors', partial: 'layouts/errors', locals: { resource: @company })
          ]
        end
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @company.destroy
      redirect_to companies_path, flash: { success:  'Cliente deletado com sucesso.' }
    else
      redirect_to companies_path, flash: { danger: 'Não é possível deletar Cliente' }
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :company_name, :document_number, :email, :phone, :zip_code, :address, :neighborhood, :city, :state, :complement)
  end
end
