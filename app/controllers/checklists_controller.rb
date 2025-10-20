class ChecklistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
  def show
    # Já tem os dados da checklist devido ao 'before_action :set_checklist'
    @item = @checklist.checklist_items.build
  end

  def new
    @checklist = Checklist.new
  end

  def create
    @checklist = current_user.checklists.new(checklist_params)
    if @checklist&.save
      redirect_to @checklist, notice: 'Checklist criada com sucesso'
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    # Já tem os dados da checklist devido ao 'before_action :set_checklist'
  end

  def update
    if @checklist&.update(checklist_params)
      redirect_to @checklist, notice: 'Checklist atualizada com sucesso'
    else
      head :unprocessable_content
      #render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @checklist&.destroy
    redirect_to root_path, notice: 'Checklist deletada com sucesso'
  end

  private

  def set_checklist
    @checklist = current_user.checklists.find(params[:id])
    rescue ActiveRecord::RecordNotFound => _
      redirect_to root_path, alert: 'Você não tem permissão para fazer isso'
  end

  def checklist_params
    params.require(:checklist).permit(
      :title,
      checklist_items_attributes: [:id, :description, :_destroy]
      )
  end
end
