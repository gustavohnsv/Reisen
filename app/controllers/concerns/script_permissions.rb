module ScriptPermissions
  extend ActiveSupport::Concern
  private

  def set_script_permissions
    script_id = params[:script_id] || params[:id]
    @script = Script.find_by(id: script_id)
    if @script.nil?
      redirect_to root_path, alert: "Roteiro não encontrado" and return
    end
    @permission_level = find_permission_level
  end

  def find_permission_level
    if current_user
      # Proprietário do roteiro
      return :owner if @script&.user == current_user
      # Participante (via convite) do roteiro
      participant = @script&.script_participants&.find_by(user_id: current_user.id)
      if participant
        return :collaborator if participant.role == 'collaborator'
        return :read_only if participant.role == 'read_only'
      end
    elsif params[:token].present? && @script&.shareable_token == params[:token]
      # Apenas leitura (Participante via link)
      return :read_only
    end
    # Nenhuma permissão
    nil
  end

  # Autoriza leitura
  def authorize_read_access!
    return if performed?
    unless [:owner, :collaborator, :read_only].include?(@permission_level)
      render "scripts/show", alert: "Você não tem permissão para ver esse roteiro", status: :unprocessable_content
      #redirect_to root_path, alert: "Você não tem permissão para ver esse roteiro"
    end
  end

  # Autoriza manipulação de itens
  def authorize_write_items_access!
    return if performed?
    unless [:owner, :collaborator].include?(@permission_level)
      set_show_variables
      if current_user
        redirect_to root_path, alert: "Você não tem permissão para editar este roteiro", status: :unprocessable_content
      else
        render "scripts/show", alert: "Você não tem permissão para editar este roteiro", status: :unprocessable_content
      end
    end
  end

  # Autoriza controle total
  def authorize_owner_access!
    return if performed?
    unless @permission_level == :owner
      set_show_variables
      render "scripts/show", alert: "Você não é o proprietário desse roteiro", status: :unprocessable_content
    end
  end
end