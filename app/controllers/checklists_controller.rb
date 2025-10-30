class ChecklistsController < ApplicationController
  include ChecklistPermissions

  before_action :authenticate_user!
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
  before_action :set_checklist_permissions, only: [:show]
  def show
    # Já tem os dados da checklist devido ao 'before_action :set_checklist'
    @item = @checklist&.checklist_items.build
    # Expose permission level to views (owner/collaborator/read_only or nil)
    @checklist_permission_level ||= (@checklist&.user == current_user ? :owner : nil)
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
    @checklist = Checklist
                .joins("LEFT JOIN checklist_participants ON checklist_participants.checklist_id = checklists.id")
                .where("checklists.user_id = ? OR checklist_participants.user_id = ?", current_user.id, current_user.id)
                .distinct
                .find(params[:id])
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
