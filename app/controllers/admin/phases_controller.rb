module Admin
  class PhasesController < ApplicationController
    before_action :set_phase, only: [ :show, :edit, :update, :destroy, :set_as_ending_phase ]

    def index
      @phases = Phase.all.order("position ASC")
    end

    def show
    end

    def new
      @phase = Phase.new
    end

    def edit
      @phase = Phase.find(params[:id])
      respond_to do |format|
        format.turbo_stream  { render :edit, layout: false }
        format.html
      end
    end

    def create
      @phase = Phase.new(phase_params)
      if @phase.save
        redirect_to admin_phases_path, flash: { success: "Fase do projeto criado com sucesso." }
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace("errors", partial: "layouts/errors", locals: { resource: @phase })
            ]
          end
          format.html { render :new }
        end
      end
    end

    def update
      if @phase.update(phase_params)
        respond_to do |format|
          if request.headers["Turbo-Frame"].present?
            format.turbo_stream do
              render turbo_stream: [
                turbo_stream.replace("phase_#{@phase.id}", partial: "admin/phases/phase_row", locals: { phase: @phase }),
                turbo_stream.update("modal", ""),
                turbo_stream.replace("flash_messages", partial: "layouts/flash", locals: { flash: { success: "Fase do projeto atualizado com sucesso." } }),
                turbo_stream.append("turbo-frame-end", partial: "layouts/update_url", locals: { url: admin_phases_path })
              ]
            end
          else
            format.html { redirect_to admin_phases_path, flash: { success: "Fase do projeto atualizado com sucesso." } }
          end
        end
      else
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace("errors", partial: "layouts/errors", locals: { resource: @phase })
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

      @phase.broadcast_replace_to "phases_index", target: "phases_table", partial: "admin/phases/phases", locals: { phases: Phase.all.order("position ASC") }

      head :no_content
    rescue => e
      Rails.logger.error "Erro ao atualizar a fase: #{e.message}"
      head :internal_server_error
    end

    def set_as_ending_phase
      if @phase.position == 1
        redirect_to admin_phases_path, flash: { danger: "Fase de início não pode ser fim." }
      else
        @phase.update(is_end: !@phase.is_end)

        @phase.broadcast_replace_to "phases_index", target: "is_end_#{@phase.id}", partial: "admin/phases/end_of_phase", locals: { phase: @phase }

        head :no_content
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
      redirect_to admin_phases_url, flash: { success: "Fase do projeto deletado com sucesso." }
    rescue Exceptions::NonRemovableValueError
      redirect_to admin_phases_path, flash: { danger: "Fase in\u00EDcio n\u00E3o pode ser removido." }
    end

    private

    def set_phase
      @phase = Phase.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_phases_path, flash: { danger: "Fase do projeto n\u00E3o encontrado." }
    end

    def phase_params
      params.require(:phase).permit(:name, :description, :color)
    end

    def broadcast_phase_change(phase)
      ActionCable.server.broadcast("admin_phases_channel", {
        type: "set_as_ending",
        phase_id: phase.id,
        html: render_to_string(partial: "end_of_phase", locals: { phase: phase })
      })
    end

    def broadcast_phase_order_change(phases)
      ActionCable.server.broadcast("admin_phases_channel", {
        type: "update_order",
        html: render_to_string(partial: "phases", locals: { phases: phases })
      })
    end
  end
end
