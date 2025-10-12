class ProfilesController < ApplicationController
  # Garante que o usuário esteja logado para acessar o seu perfil
  before_action :authenticate_user!
  def show
    # Encontra o usuário com base no ID
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, alert: "Acesso negado"
    end
    @scripts = Script
                 .left_outer_joins(:participants)
                 .where('scripts.user_id = :id OR participants.user_id = :id', id: @user.id)
                 .distinct
  rescue ActiveRecord::RecordNotFound => _
      redirect_to root_path
  end

  def my_profile
    redirect_to profile_path(current_user)
  end
end
