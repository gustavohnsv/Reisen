class Scripts::ParticipantsController < ApplicationController
  include ScriptPermissions
  include ScriptShowVariables

  before_action :set_script
  before_action :set_script_permissions

  before_action :authorize_owner_access!

  before_action :set_show_variables, only: [:create, :destroy]

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

    if @script&.script_participants&.exists?(user_id: user&.id)
      redirect_to script_path(@script), alert: "Usuário já é participante" and return
    end

    @script&.script_participants&.create!(user: user, role: role)
    redirect_to script_path(@script), notice: "Participante adicionado com sucesso"
  rescue ActiveRecord::RecordInvalid => e
    redirect_to script_path(@script), alert: e.message
  end

  def destroy
    participant = @script&.script_participants&.find_by(id: params[:id])
    unless participant
      redirect_to script_path(@script), alert: "Participante não encontrado" and return
    end

    participant&.destroy
    redirect_to script_path(@script), notice: "Participante removido"
  end

  private

  def set_script
    @script = Script
                .joins("LEFT JOIN script_participants ON script_participants.script_id = scripts.id")
                .where("scripts.user_id = ? OR script_participants.user_id = ?", current_user.id, current_user.id)
                .distinct
                .find(params[:script_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Você não tem permissão para fazer isso'
  end
end
