class PhasesController < ApplicationController
  before_action :set_phase, only: [:show, :edit, :update, :destroy, :set_as_ending_phase]
  before_action :ensure_admin_authorization

  def index
    @phases = Phase.all.order('position ASC')
  end

  def show
  end

  def new
    @phase = Phase.new
  end

  def edit
  end

  def create
    @phase = Phase.new(phase_params)
    if @phase.save
      redirect_to phases_path, flash: { success: 'Fase do projeto criado com sucesso.' }
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('errors', partial: 'layouts/errors', locals: { resource: @phase })
          ]
        end
        format.html { render :new }
      end
    end
  end

  def update
    if @phase.update(phase_params)
      redirect_to phases_path, flash: { success: 'Fase do projeto atualizado com sucesso.' }
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('errors', partial: 'layouts/errors', locals: { resource: @phase })
          ]
        end
        format.html { render :edit }
      end
    end
  end

  def update_order_phases
    @phase = Phase.find(params[:format])

    Phase.transaction do
      @phase.insert_at(params[:position].to_i + 1)
      @phase.update(is_end: false) if params[:position].to_i == 0
    end

    head :no_content
  end

  def set_as_ending_phase
    if @phase.position == 1
      redirect_to phases_path, flash: { danger: 'Fase de início não pode ser fim.' }
    else
      @phase.update(is_end: !@phase.is_end)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("is_end_#{@phase.id}", partial: "end_of_phase", locals: { phase: @phase })
        end
      end
    end
  end

  # Refreshes a phase by finding it based on the provided ID and rendering a Turbo Stream response.
  #
  # Params:
  # - id: The ID of the phase to refresh.
  #
  # Example usage:
  #   refresh_phase(id: 1)
  #
  # Returns:
  #   The Turbo Stream response that replaces the specified phase with the updated content.
  def refresh_phase
    @phase = Phase.find(params[:id])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("is_end_#{@phase.id}", partial: "end_of_phase", locals: { phase: @phase })
      end
    end
  end

  def destroy
    @phase.destroy
    redirect_to phases_url, flash: { success: 'Fase do projeto deletado com sucesso.' }
  rescue Exceptions::NonRemovableValueError
    redirect_to phases_path, flash: { danger: 'Fase início não pode ser removido.' }
  end

  private

  def set_phase
    @phase = Phase.find(params[:id])
  end

  def phase_params
    params.require(:phase).permit(:name, :description)
  end
end
