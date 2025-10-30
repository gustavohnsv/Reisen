class Checklists::ParticipantsController < ApplicationController
  include ChecklistPermissions

  before_action :authenticate_user!
  before_action :set_checklist_permissions
  before_action :authorize_checklist_owner!

  def create
    email = (params[:email] || params.dig(:participant, :email))&.strip
    role = (params[:role] || params.dig(:participant, :role)) || 'collaborator'
    unless email.present?
      redirect_to checklist_path(@checklist), alert: "E-mail é obrigatório" and return
    end

    user = User.find_by(email: email)
    unless user
      redirect_to checklist_path(@checklist), alert: "Usuário não encontrado" and return
    end

    if @checklist.checklist_participants.exists?(user_id: user.id)
      redirect_to checklist_path(@checklist), notice: "Usuário já é participante" and return
    end

    @checklist.checklist_participants.create!(user: user, role: role)
    redirect_to checklist_path(@checklist), notice: "Participante adicionado com sucesso"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to checklist_path(@checklist), alert: e.message
  end

  def destroy
    participant = @checklist.checklist_participants.find_by(id: params[:id])
    unless participant
      redirect_to checklist_path(@checklist), alert: "Participante não encontrado" and return
    end

    participant.destroy
    redirect_to checklist_path(@checklist), notice: "Participante removido"
  end
end
