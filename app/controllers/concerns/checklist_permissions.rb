module ChecklistPermissions
  extend ActiveSupport::Concern
  private

  def set_checklist_permissions
    checklist_id = params[:checklist_id] || params[:id]
    @checklist = Checklist.find_by(id: checklist_id)
    if @checklist.nil?
      redirect_to root_path, alert: "Checklist não encontrada" and return
    end
    @checklist_permission_level = find_checklist_permission_level
  end

  def find_checklist_permission_level
    if current_user
      return :owner if @checklist&.user == current_user
      participant = @checklist&.checklist_participants&.find_by(user_id: current_user.id)
      if participant
        return :collaborator if participant.role == 'collaborator'
        return :read_only if participant.role == 'read_only'
      end
    end
    nil
  end

  def authorize_checklist_write!
    return if performed?
    unless [:owner, :collaborator].include?(@checklist_permission_level)
      redirect_to root_path, alert: "Você não tem permissão para editar esta checklist"
    end
  end

  def authorize_checklist_owner!
    return if performed?
    unless @checklist_permission_level == :owner
      redirect_to root_path, alert: "Você não tem permissão para gerenciar participantes desta checklist"
    end
  end
end
