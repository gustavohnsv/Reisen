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

    # Em development, confirme o usuário se o Devise Confirmable estiver habilitado
    if user.respond_to?(:confirm) && user.respond_to?(:confirmed?)
      user.confirm unless user.confirmed?
    elsif user.respond_to?(:confirmed_at)
      user.update_column(:confirmed_at, Time.current) if user.confirmed_at.nil?
    end

    sign_in(user)
    redirect_to root_path, notice: "Logado como #{user.email} (dev)"
  end

  private

  def ensure_development
    head :not_found unless Rails.env.development?
  end
end
