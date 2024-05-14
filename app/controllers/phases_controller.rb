class PhasesController < ApplicationController
  before_action :set_phase, only: [:show, :edit, :update, :destroy, :set_as_starting_phase, :set_as_ending_phase]

  def index
    @phases = Phase.all
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

  def set_as_starting_phase
    @phase.set_as_starting_phase
    redirect_to phases_url, flash: { success: 'Fase selecionada com início com sucesso.' }
  rescue ActiveRecord::Rollback
    redirect_to phases_path, flash: { danger: 'Não é possivel selecionada fase com início.' }
  end

  def set_as_ending_phase
    if @phase.is_start
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

  def destroy
    @phase.destroy
    redirect_to phases_url, flash: { success: 'Fase do projeto deletado com sucesso.' }
  rescue AliatoProjectManager::NonRemovableValueError
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
