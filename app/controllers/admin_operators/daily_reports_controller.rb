module AdminOperators
  class DailyReportsController < ApplicationController
    before_action :set_project, only: [ :new, :create, :edit, :update, :generate_link, :destroy ]

    skip_before_action :authenticate_user!, only: [ :show_by_token, :update_by_token ]
    # TODO: Alterar a forma de exclusão de daily_reports
    skip_before_action :verify_authenticity_token, only: :destroy

    def new
      @daily_report = @project.daily_reports.new
    end

    def create
      @daily_report = @project.daily_reports.new(daily_report_params)
      if @daily_report.save
        redirect_to @project, notice: "Di\u00E1rio de obra criado com sucesso."
      else
        render :new
      end
    end

    def edit
      @daily_report = @project.daily_reports.find(params[:id])
    end

    def update
      @daily_report = @project.daily_reports.find(params[:id])
      if @daily_report.update(daily_report_params)
        redirect_to @project, notice: "Di\u00E1rio de obra atualizado com sucesso."
      else
        render :edit
      end
    end

    def update_by_token
      @daily_report = DailyReport.find_by(token: params[:token])

      if @daily_report.update(daily_report_params.merge(completed_at: Time.current))
        redirect_to access_admin_operators_daily_reports_url(@daily_report.project, token: @daily_report.token), notice: "Formulário preenchido com sucesso."
      else
        render :show_by_token, alert: "Erro ao preencher o formulário."
      end
    end

    def show_by_token
      @daily_report = DailyReport.find_by(token: params[:token])
      render plain: "Link inv\u00E1lido ou expirado.", status: :not_found unless @daily_report
    end

    def generate_link
      date = params[:date] || Date.today

      ActiveRecord::Base.transaction do
        # @project.daily_reports.find_by(date: date)&.destroy
        @daily_report = @project.daily_reports.create(date: date)
      end

      if @daily_report.persisted?
        link = access_admin_operators_daily_reports_url(@project, token: @daily_report.token)
        flash[:notice] = "#{link}"
        redirect_to edit_admin_operators_project_path(@project), flash: { link: "#{link}" }
      else
        redirect_to edit_admin_operators_project_path(@project), flash: { danger: "Erro ao gerar o link." }
      end
    end

    def destroy
      if @project.daily_reports.find(params[:id]).destroy
        redirect_to edit_admin_operators_project_path(@project), flash: { success:  "Diário de Obra deletado com sucesso." }
      else
        redirect_to edit_admin_operators_project_path(@project), flash: { danger: "N\u00E3o \u00E9 poss\u00EDvel deletar Diário de Obra" }
      end
    end

    private

    def set_project
      @project = Project.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html",  layout: false, status: :not_found
    end

    def daily_report_params
      params.require(:daily_report).permit(
        :date,
        :morning_condition,
        :afternoon_condition,
        :labor,
        :equipment,
        :activities,
        :occurrences
      )
    end
  end
end
