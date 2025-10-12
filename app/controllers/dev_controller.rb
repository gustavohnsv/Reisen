class DevController < ApplicationController
  # Controller para rotas utilitárias de desenvolvimento local
  before_action :ensure_development

  def login
    # Cria ou encontra um usuário de teste
    user = User.find_or_create_by!(email: 'dev@example.com') do |u|
      u.name = 'Dev User'
      u.password = 'password'
      u.password_confirmation = 'password'
    end

    sign_in(user)
    redirect_to root_path, notice: "Logado como #{user.email} (dev)"
  end

  private

  def ensure_development
    head :not_found unless Rails.env.development?
  end
end
