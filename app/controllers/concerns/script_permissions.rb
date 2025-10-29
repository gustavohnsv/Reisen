module ScriptPermissions
  extend ActiveSupport::Concern
  private

  def set_script_permissions
    script_id = params[:script_id] || params[:id]
    script = Script.find_by(id: script_id)
    if script.nil?
      redirect_to root_path, alert: "Roteiro não encontrado" and return
    end
    @permission_level = find_permission_level
  end

  def find_permission_level
    if current_user
      # Proprietário do roteiro
      return :owner if @script&.user == current_user
      # Participante (via convite) do roteiro

      # -- A LÓGICA DE CONVITE MUDA ESSE TRECHO --
      return :collaborator if @script&.participants&.exists?(user_id: current_user.id)
      # -- A LÓGICA DE CONVITE MUDA ESSE TRECHO --

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
      render "scripts/show", alert: "Vocẽ não é o proprietário desse roteiro", status: :unprocessable_content
      #redirect_to root_path, alert: "Você não tem permissão para ver esse roteiro"
    end
  end

  # Autoriza manipulação de itens
  def authorize_write_items_access!
    return if performed?
    unless [:owner, :collaborator].include?(@permission_level)
      render "scripts/show", alert: "Vocẽ não é o proprietário desse roteiro", status: :unprocessable_content
      #redirect_to root_path, alert: "Você não tem permissão para criar itens nesse roteiro"
    end
  end

  # Autoriza controle total
  def authorize_owner_access!
    return if performed?
    unless @permission_level == :owner
      render "scripts/show", alert: "Vocẽ não é o proprietário desse roteiro", status: :unprocessable_content
      #redirect_to root_path, alert: "Vocẽ não é o proprietário desse roteiro"
    end
  end
end