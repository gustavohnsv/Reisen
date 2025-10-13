class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @user.update(user_params)
        if params[:user] && params[:user][:remove_avatar] == '1'
          @user.avatar.purge
        end
      redirect_to profile_path(@user), notice: 'Usuário atualizado com sucesso.'
    else
      @user = @user
      render 'profiles/edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: 'Usuário deletado com sucesso'
  end

  private

  def set_user
    # Define o usuário como o usuário atual
    @user = User.find params[:id]
    unless @user == current_user
      redirect_to root_path, alert: "Acesso negado"
    end
    rescue ActiveRecord::RecordNotFound => _
      redirect_to root_path
  end

  def user_params
    # Define quais parâmetros podem ser atualizados do usuário
  params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :remove_avatar)
  end
end
