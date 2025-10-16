class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    # dup para manipular sem enviar flag inválida ao update
    filtered_params = user_params.dup

    # Não sobrescrever senha se campos vierem vazios
    if filtered_params[:password].present? == false && filtered_params[:password_confirmation].present? == false
      filtered_params.delete(:password)
      filtered_params.delete(:password_confirmation)
    end

    # remover flag (não é coluna do model) antes do update
    filtered_params.delete(:remove_avatar)

    if @user.update(filtered_params)
      # remover attachment separadamente
      if params[:user] && params[:user][:remove_avatar] == '1'
        @user.avatar.purge_later
      end
      redirect_to profile_path(@user), notice: 'Usuário atualizado com sucesso.'
    else
      render 'profiles/edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Usuário deletado com sucesso'
  end

  private

  def set_user
    @user = User.find(params[:id])
    redirect_to root_path, alert: "Acesso negado" unless @user == current_user
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end