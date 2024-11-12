module AdminOperators
  class ProjectsController < ApplicationController
    include Pagy::Backend

    Pagy::DEFAULT[:limit] = 5
    Pagy::DEFAULT[:size]  = 19

    before_action :authenticate_user!
    before_action :set_client, only: [ :new, :create ]
    before_action :set_project, only: [ :edit, :update ]

    # TODO: Alterar a forma de exclusão de arquivos
    skip_before_action :verify_authenticity_token, only: :destroy_project_files

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def index
      @projects = Project.order("created_at DESC").includes(:client, :phase)

      if client_id = params[:client_id]
        @projects = @projects.where(client_id: client_id)
      elsif phase_id = params[:phase_id]
        @projects = @projects.where(phase_id: phase_id)
        @phase = Phase.find_by_id(phase_id)
      else
        @projects = @projects.all
      end
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)
      @project.phase_id = Phase.order("position ASC").first.id
      @project.client_id = @client.id
      @project.user_id = current_user.id

      if @project.save
        redirect_to admin_operators_projects_path(phase_id: @project.phase.id)
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace("errors", partial: "layouts/errors", locals: { resource: @project })
            ]
          end
          format.html { render :new }
        end
      end
    end

    def update_phase
      @project = Project.find(params[:project_id])
      @phase = Phase.find(params[:phase_id])

      if !@project.phase.is_end? && @project.phase.position != @phase.position
        @project.update(phase: @phase)
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("phase_dropdown", partial: "admin_operators/projects/phase_dropdown", locals: { project: @project })
          end
          format.html { redirect_to admin_operators_project_path(@project) }
        end
      end
    end

    def edit
      @client = @project.client
    end

    def load_daily_reports
      @project = Project.find(params[:id])
      @pagy, @daily_reports = pagy(@project.daily_reports.order(date: :desc))
    end

    def load_project_files
      @project = Project.find(params[:id])
      @pagy, @project_files = pagy(@project.project_files.order(created_at: :desc))
    end

    def update
      if !@project.phase.is_end && @project.update(update_project_params)
        if params[:project][:files][1]
          @project.project_files.create(file: params[:project][:files][1])
        end
        redirect_to admin_operators_projects_path(phase_id: @project.phase.id)
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace("errors", partial: "layouts/errors", locals: { resource: @project })
            ]
          end
          format.html { render :edit }
        end
      end
    end

    def download_file
      project_file = ProjectFile.find(params[:project_id])
      send_data project_file.file_data, filename: project_file.file_name, type: "application/octet-stream", disposition: "attachment"
    end

    def destroy_project_files
      if Project.find_by(id: params[:project_id])&.project_files.find_by(id: params[:id])&.destroy
        redirect_to edit_admin_operators_project_path(Project.find_by(id: params[:project_id])), flash: { success:  "Arquivo deletado com sucesso." }
      else
        redirect_to edit_admin_operators_project_path(Project.find_by(id: params[:project_id])), flash: { danger: "N\u00E3o \u00E9 poss\u00EDvel deletar Arquivo" }
      end
    end

    private

    def not_found
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end

    def set_client
      @client = Client.find(params[:client_id].to_i)
    end

    def set_project
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html",  layout: false, status: :not_found
    end


    def project_params
      params.require(:project).permit(:description, :client_id)
    end

    def update_project_params
      params.require(:project).permit(:description)
    end
  end
end
