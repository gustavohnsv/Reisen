class Scripts::ParticipantsController < ApplicationController
  include ScriptPermissions

  before_action :set_script_permissions
  before_action :authorize_owner_access!

  def create
    # Expect params[:email] or params[:participant][:email]
    email = (params[:email] || params.dig(:participant, :email))&.strip
    role = (params[:role] || params.dig(:participant, :role)) || 'collaborator'
    unless email.present?
      redirect_to script_path(@script), alert: "E-mail é obrigatório" and return
    end

    user = User.find_by(email: email)
    unless user
      redirect_to script_path(@script), alert: "Usuário não encontrado" and return
    end

    if @script.participants.exists?(user_id: user.id)
      redirect_to script_path(@script), notice: "Usuário já é participante" and return
    end

    @script.participants.create!(user: user, role: role)
    redirect_to script_path(@script), notice: "Participante adicionado com sucesso"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to script_path(@script), alert: e.message
  end

  def destroy
    participant = @script.participants.find_by(id: params[:id])
    unless participant
      redirect_to script_path(@script), alert: "Participante não encontrado" and return
    end

    participant.destroy
    redirect_to script_path(@script), notice: "Participante removido"
  end
end
